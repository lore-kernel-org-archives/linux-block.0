Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E8C4338F
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0E861055
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 09:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhHOJUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 05:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhHOJUF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 05:20:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1A0461042;
        Sun, 15 Aug 2021 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629019167;
        bh=BBRTIP+Tkdjn2MlFAAdXPpIz7DPoiledsIUo7WXVHUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iznmch2geNCe5SEj5ZoR98dePm9D5/hf22MlZqdRrkI5APHmbKfVvflKlAtU7Plzz
         dVhbWDUao3XVpn4M5/Sb1gQpCvmksH7ixye00d3oaohGdVuR/TaKspvWPShYkcuXT6
         7j5N6wiW1IBnFpBu+7yT2pouw4Ho4xdF7efbYJIg=
Date:   Sun, 15 Aug 2021 11:19:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YRjcHJE0qEIIJ9gA@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 15, 2021 at 04:49:55PM +0900, Tetsuo Handa wrote:
> On 2021/08/15 16:06, Greg KH wrote:
> > On Sun, Aug 15, 2021 at 03:52:45PM +0900, Tetsuo Handa wrote:
> >> --- a/include/linux/genhd.h
> >> +++ b/include/linux/genhd.h
> >> @@ -303,9 +303,9 @@ struct gendisk *__blk_alloc_disk(int node);
> >>  void blk_cleanup_disk(struct gendisk *disk);
> >>  
> >>  int __register_blkdev(unsigned int major, const char *name,
> >> -		void (*probe)(dev_t devt));
> >> +		      void (*probe)(dev_t devt), struct module *owner);
> >>  #define register_blkdev(major, name) \
> >> -	__register_blkdev(major, name, NULL)
> >> +	__register_blkdev(major, name, NULL, NULL)
> >>  void unregister_blkdev(unsigned int major, const char *name);
> > 
> > Do not force modules to put their own THIS_MODULE macro as a parameter,
> > put it in the .h file so that it happens automagically, much like the
> > usb_register() define in include/linux/usb.h is created.
> 
> Sure. We can do like below.
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 13b34177cc85..70f00641fa11 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -302,10 +302,12 @@ extern void put_disk(struct gendisk *disk);
>  struct gendisk *__blk_alloc_disk(int node);
>  void blk_cleanup_disk(struct gendisk *disk);
>  
> -int __register_blkdev(unsigned int major, const char *name,
> -		void (*probe)(dev_t devt));
> +int ____register_blkdev(unsigned int major, const char *name,
> +			void (*probe)(dev_t devt), struct module *owner);
> +#define __register_blkdev(major, name, probe) \
> +	____register_blkdev(major, name, probe, THIS_MODULE)
>  #define register_blkdev(major, name) \
> -	__register_blkdev(major, name, NULL)
> +	____register_blkdev(major, name, NULL, NULL)

Why stop at 4 _ characters?

{sigh}

I think you need a new naming scheme here...

> > 
> > If you do that, you can probably get rid of the __register_blkdev()
> > direct calls as well...
> 
> I assume "automagically" implies "do not patch individual unregister_blkdev() /
> __register_blkdev() callers". But "removing __register_blkdev() direct calls"
> requires "patching individual __register_blkdev() callers". I didn't catch
> what you suggested here.

Yes, that is a different thing, sorry for the confusion.

> Anyway, since this patch should be backported to 5.11+ kernels, lines changed
> should be kept minimal. We can do whatever remapping after this patch.

Don't worry about backports, fix it properly first.

thanks,

greg k-h
