Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7BC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A7A610E8
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbhHRP3W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238837AbhHRP3W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 11:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46A3D6108D;
        Wed, 18 Aug 2021 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629300527;
        bh=uUvkZoVLR5bWAmJre78Z4EYXJnQf7ulpfcF3RH5A8tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6Whza/n37tjWo/ohy03NjT+pQlSSDEE+iAIY4v6vI+7dNs9UAxWz6TGQEkEodD5t
         aLYg2Gql9iA6iIlmmZpXPo/2v95hOYuithk40/vJ5ZzZxHHGjbedWLnUT7n22rxZLu
         XpVX5hAfpfCDyfkWXS98jSc/g32BmwW2rOV9BD+o=
Date:   Wed, 18 Aug 2021 17:28:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YR0nLGdH3zVMSRXm@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <YR0KySFfiDk+s7pn@kroah.com>
 <a9056084-8a9a-40b3-1a20-1052135c1ee2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9056084-8a9a-40b3-1a20-1052135c1ee2@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 11:44:14PM +0900, Tetsuo Handa wrote:
> On 2021/08/18 22:27, Greg KH wrote:
> > On Wed, Aug 18, 2021 at 08:07:32PM +0900, Tetsuo Handa wrote:
> >> This patch adds THIS_MODULE parameter to __register_blkdev() as with
> >> usb_register(), and drops major_names_lock before calling probe function
> >> by holding a reference to that module which contains that probe function.
> >>
> >> Since cdev uses register_chrdev() and __register_chrdev(), bdev should be
> >> able to preserve register_blkdev() and __register_blkdev() naming scheme.
> > 
> > Note, the cdev api is anything but good, so should not be used as an
> > excuse for anything.  Don't copy it unless you have a very good reason.
> > 
> > Also, what changed in this version?  I see no patch history here :(
> 
> Nothing but passing THIS_MODULE automagically using macro, as a response to
> 
>   > Do not force modules to put their own THIS_MODULE macro as a parameter,
>   > put it in the .h file so that it happens automagically, much like the
>   > usb_register() define in include/linux/usb.h is created.

Then properly document it as you should when sending new versions of
patches.

thanks,

greg k-h
