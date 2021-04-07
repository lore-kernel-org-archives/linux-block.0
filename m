Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168A7C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EB4613B3
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 01:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhDGBii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDGBih (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 21:38:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED4C06174A;
        Tue,  6 Apr 2021 18:38:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p10so3388383pld.0;
        Tue, 06 Apr 2021 18:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYV8q9cPR39r8XTv5NGEbYCLUvn316w9E8k7pBADmqg=;
        b=T3OjG7pfoC/aH0hlb4jmWpTRfPfin47UDirBmbxO+5Rj/5DfxGzphuvBUIzEE/Z+rE
         GlrzSByibJQ1StDX05ya8MHWMNDVcKilz6j1vloMRX5iR4r3HveyxoOxcVGGkecF89T1
         mKpDhU1IGTXlw3wx+fL+xa7nw1lFsv12+Zd3vIbn3knfrEKM8WG39mkDFJn3fbYXOfo5
         6N3HMl2UUdZTiyU723AcJGlsNkmiVtS1kvrqkGJ4kGWcP1DKjGyQfztygaJbpnO3RKSV
         raCOr+SANoE4nsZm5d23qlT2x8CQK/wc2GBn7EHP6ROfmBQ7kxOdqWwL8L79iN2cN4pU
         eROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vYV8q9cPR39r8XTv5NGEbYCLUvn316w9E8k7pBADmqg=;
        b=D09tMe5krUeP+cru6MY0C5CJ4TR6sSXgQLF/Gx0uZznRlnPEMUw6dACC1/lZirSOSg
         oqa8tO4Xtwigib4ZPd/axznDJf+jJtWTZ6aQDvy5eefDj3j8BmQS5r+FAlm8wOntT8Ze
         6T7jyBSNtzn/Xm/FJf8K0SwNXYN0BlKxvm90UeEUAAkn/NPsQIo3raFYNriM9L1WDeEt
         30CnfMe9qD8ir0CZ8rRV/zBYvgdOVSp0AXXKZcOHgNzKt7SR+9khySRgxh1jfAqjNv5T
         Mo3MKkCrf7AFshAzEK1bxsGkhPgOqilMjyxJEp2gVweHp+9RMhTeZ8ACtxQ7/iKL6Rg7
         ZZfw==
X-Gm-Message-State: AOAM533l3eCXCwUp3y8uz6bXpB6ad3tkvRwL8a765hzg3MrVI+FqP+ac
        1LEwJ8hTNMXWvL7ZlH7aA1k=
X-Google-Smtp-Source: ABdhPJymbio9FUUUVE0VvfQ/hhxcFRjaxvMlfG8qdoolaPAemBXI64vcL/KJSEUD4iuv4PUDAMLdqQ==
X-Received: by 2002:a17:902:d2c7:b029:e6:dd9e:d652 with SMTP id n7-20020a170902d2c7b02900e6dd9ed652mr977807plc.1.1617759507863;
        Tue, 06 Apr 2021 18:38:27 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:5a8:9f08:98f1:7659])
        by smtp.gmail.com with ESMTPSA id d19sm3335897pjs.55.2021.04.06.18.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 18:38:26 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 6 Apr 2021 18:38:24 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YG0NEIUfJ5lmS4DL@google.com>
References: <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
 <20210405190023.GX4332@42.do-not-panic.com>
 <YGtrzXYDiO3Gf9Aa@google.com>
 <20210406002909.GY4332@42.do-not-panic.com>
 <YG0JouWqrJPHbpqz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG0JouWqrJPHbpqz@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 06:23:46PM -0700, Minchan Kim wrote:
> On Tue, Apr 06, 2021 at 12:29:09AM +0000, Luis Chamberlain wrote:
> > On Mon, Apr 05, 2021 at 12:58:05PM -0700, Minchan Kim wrote:
> > > On Mon, Apr 05, 2021 at 07:00:23PM +0000, Luis Chamberlain wrote:
> > > > On Mon, Apr 05, 2021 at 10:07:24AM -0700, Minchan Kim wrote:
> > > > > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > > > > > And come to think of it the last patch I had sent with a new
> > > > > > DECLARE_RWSEM(zram_unload) also has this same issue making most
> > > > > > sysfs attributes rather fragile.
> > > > > 
> > > > > Thanks for looking the way. I agree the single zram_index_rwlock is
> > > > > not the right approach to fix it. However, I still hope we find more
> > > > > generic solution to fix them at once since I see it's zram instance
> > > > > racing problem.
> > > > 
> > > > They are 3 separate different problems. Related, but different.
> > > 
> > > What are 3 different problems? I am asking since I remember only two:
> > > one for CPU multistate and the other one for sysfs during rmmod.
> > 
> > The third one is the race to use sysfs attributes and those routines
> > then derefernece th egendisk private_data.
> 
> First of all, thanks for keeping discussion, Luis.
> 
> That was the one I thought race between sysfs and during rmmod.
> 
> > 
> > > > If the idea then is to busy out rmmod if a sysfs attribute is being
> > > > read, that could then mean rmmod can sometimes never complete. Hogging
> > > > up / busying out sysfs attributes means the module cannto be removed.
> > > 
> > > It's true but is it a big problem? There are many cases that system
> > > just return error if it's busy and rely on the admin. IMHO, rmmod should
> > > be part of them.
> > 
> > It depends on existing userspace scripts which are used to test and
> > expectations set. Consider existing tests, you would know better, and
> > since you are the maintainer you decide.
> > 
> > I at least know for many other types of device drivers an rmmod is
> > a sledge hammer.
> > 
> > You decide. I just thought it would be good to highlight the effect now
> > rather than us considering it later.
> 
> To me, the rmmod faillure is not a big problem for zram since it's
> common cases in the system with -EBUSY(Having said, I agree that's the
> best if we could avoid the fail-and-retrial. IOW, -EBUSY should be
> last resort unless we have nicer way.)
> 
> > 
> > > > Which is why the *try_module_get()* I think is much more suitable, as
> > > > it will always fails if we're already going down.
> > > 
> > > How does the try_module_get solved the problem?
> > 
> > The try stuff only resolves the deadlock. The bget() / bdput() resolves
> > the race to access to the gendisk private_data.
> 
> That's the one I missed in this discussion. Now I am reading your [2/2]
> in original patch. I thought it was just zram instance was destroyed
> by sysfs race problem so you had seen the deadlock. I might miss the
> point here, too. 
> 
> Hmm, we are discussing several problems all at once. I feel it's time
> to jump v2 with your way in this point. You said three different
> problems. As I asked, please write it down with more detail with
> code sequence as we discussed other thread. If you mean a deadlock,
> please write what specific locks was deadlock with it.
> It would make discussion much easier. Let's discuss the issue
> one by one in each thread.

To clarify what I understood form the discussion until now:

1. zram shouldn't allow creating more zram instance during
rmmod(It causes CPU multistate splat)

2. the private data of gendisk shouldn't destroyed while zram
sysfs knob is working(it makes system goes crash)

Thank you.
