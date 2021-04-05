Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205AFC433B4
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3781613B5
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 17:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhDERHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhDERHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 13:07:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA11BC061756;
        Mon,  5 Apr 2021 10:07:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h8so5967843plt.7;
        Mon, 05 Apr 2021 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RLfqM/4YIXZIGygat9vmW8mY7gaObgItiX8qoqBUvFM=;
        b=vKScQsi48K81cCQB3BArJMMXH64fEPo6XNMxfDYOdDm7Hr+2nx1ABrak2wk6LP1qt4
         AN1MHQaKcEa+nDGHFCY1xf5+6N5etpWKp5C+zq1TtU9VEQg5JXB+QeDFy2oYTklPlVYL
         J8Ld45pQiIlVKmhHGzrlUPgdHONwyTu8XztYZ9985gXFLi3Xgqc1gui6F2Iqtfy1AgbQ
         WbIL8r19uU4fOY+6ns45J9vVWra9ATh/7bIt2Eo9ulziV6iUZWWDoXN5BjEDCVZ7XATB
         qhHvCSPd7xRDn+3HsOIVJDc7fwrVXWQzz47m1ybBSCou7R+n57/Mr/8/dGhpXStf1SHR
         5gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RLfqM/4YIXZIGygat9vmW8mY7gaObgItiX8qoqBUvFM=;
        b=Xw5awSFcbyQpiBf5CqTy8Exy8U9KSG4Hm9+KWCGHtiK5JvBL7gQXEEXK/VyUxdxDxl
         wpLPvszVEfTdHSPEt242m82SuxkivOdNTiWDyQHW+tYN7iEwgPwFETMpa+wPteqt2bOi
         +BVT3h4+XyNvbTIsPMntohMa+qYeLVXqNhoZ3MsicvdFdiJ20oEMiHtE3RomiSpykpg/
         EGgllBF3NOgHvOCYfutLQBWfZWr7OUxhDX80vqrg102yzigk4VUvL1+y6SfPyk0+aF1x
         7ywsCyiQpu/hygmMB7EojZDbup+VkNiB9Pt1ieSi+Bzgis7w4tv5GNK/x3S5ekRY+2/m
         mABg==
X-Gm-Message-State: AOAM532E87aq4ECZas/4PS9NYmefS8My27XKm9Y+Dc6KelrVH7xl/KHO
        R9qLDxRruS0Ut7EczyZbd3Q=
X-Google-Smtp-Source: ABdhPJyGSiFR05Bhvb/JuonUQqVWP6LEo2ZFxM4pFWlWuLFuRzOAIxqzzmm4i6WU9PMLSmDnL6Mc/w==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr111631pjb.206.1617642447981;
        Mon, 05 Apr 2021 10:07:27 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:30d6:b5a3:92ae:5a02])
        by smtp.gmail.com with ESMTPSA id w23sm16270541pgi.63.2021.04.05.10.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:07:26 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 5 Apr 2021 10:07:24 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YGtDzH0dEfEngCij@google.com>
References: <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401235925.GR4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> On Mon, Mar 22, 2021 at 03:12:01PM -0700, Minchan Kim wrote:
> > On Mon, Mar 22, 2021 at 08:41:56PM +0000, Luis Chamberlain wrote:
> > > 
> > > I would not call it *every* syfs knob as not all deal with things which
> > > are related to CPU hotplug multistate, right? Note that using just
> > > try_module_get() alone (that is the second patch only, does not fix the
> > > race I am describing above).
> > 
> > It wouldn't be CPU hotplug multistate issue but I'd like to call it
> > as more "zram instance race" bug.
> > What happens in this case?
> > 
> >         CPU 1                            CPU 2
> > 
> > destroy_devices
> > ..
> >                                  compact_store()
> >                                  zram = dev_to_zram(dev);
> > idr_for_each(zram_remove_cb
> >   zram_remove
> >   ..
> >   kfree(zram)
> >                                  down_read(&zram->init_lock);
> > 
> > 
> >         CPU 1                            CPU 2
> > 
> > hot_remove_store
> >                                  compact_store()
> >                                  zram = dev_to_zram(dev);
> >   zram_remove
> >     kfree(zram)
> >                                  down_read(&zram->init_lock);
> >     				
> > So, for me we need to close the zram instance create/removal
> > with sysfs rather than focusing on CPU hotplug issue.
> 
> Sure, that's a good point.
> 
> The issue which I noted for the race which ends up in a deadlock is only
> possible if a shared lock is used on removal but also on sysfs knobs.
> 
> At first glance, the issue you describe above *seems* to be just proper
> care driver developers must take with structures used. It is certainly
> yet another issue we need to address, and if we can generalize a
> solution even better. I now recall I *think* I spotted that race a while
> ago and mentioned it to Kees and David Howells but I didn't have a
> solution for it yet. More on this below.
> 
> The issue you point out is real, however you cannot disregard the
> CPU hoplug possible race as well, it is a design consideration which
> the CPU hotplug multistate support warns for -- consider driver removal.
> I agree that perhaps solving this "zram instance race" can fix he
> hotplug race as well. If we can solves all 3 issues in one shot even
> better. But let's evaluate that prospect...
> 
> > Maybe, we could reuse zram_index_mutex with modifying it with
> > rw_semaphore. What do you think?
> 
> Although ideal given it would knock 3 birds with 1 stone, it ends up
> actually making the sysfs attributes rather useless in light of the
> requirements for each of the races. Namely, the sysfs deadlock race
> *must* use a try lock approach, just as the try_module_get() case.
> It must use this approach so to immediately just bail out if we have
> our module being removed, and so on our __exit path. By trying to
> repurpose zram_index_mutex we end up then just doing too much with it
> and making the syfs attributes rather fragile for most uses:
> 
> Consider disksize_show(), that would have to become:
> 
> static ssize_t disksize_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	struct zram *zram = dev_to_zram(dev);
> +	size_t disksize;
> 
> +	down_read(&zram_index_rwlock);
> +	disksize = zram->disksize;
> +	up_read(&zram_index_rwlock);
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
> }
> 
> What's wrong with this?
> 
> It can block during a write, yes, but there is a type of write which
> will make this crash after the read lock is acquired. When the instance
> is removed. What if we try down_read_trylock()?
> 
> static ssize_t disksize_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	struct zram *zram = dev_to_zram(dev);
> +	size_t disksize;
> 
> +	if (!down_read_trylock(&zram_index_rwlock))
> +		return -ENODEV;
> +
> +	disksize = zram->disksize;
> +	up_read(&zram_index_rwlock);
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
> }
> 
> What's wrong with this?
> 
> If it got the lock, it should be OK as it is preventing writes from
> taking the lock for a bit. But then this just becomes pretty fragile,
> it will fail whenever another read or write is happening, triggering
> perhaps quite a bit of regressions on tests.
> 
> And if we use write_trylock() we end up with the same fragile nature
> of failing the read with ENODEV for any silly thing going on with the
> driver.
> 
> And come to think of it the last patch I had sent with a new
> DECLARE_RWSEM(zram_unload) also has this same issue making most
> sysfs attributes rather fragile.

Thanks for looking the way. I agree the single zram_index_rwlock is
not the right approach to fix it. However, I still hope we find more
generic solution to fix them at once since I see it's zram instance
racing problem.

A approach I am considering is to make struct zram include kobject
and then make zram sysfs auto populated under the kobject. So, zram/sysfs
lifetime should be under the kobject. With it, sysfs race probem I
mentioned above should be gone. Furthermore, zram_remove should fail
if one of the alive zram objects is existing
(i.e., zram->kobject->refcount > 1) so module_exit will fail, too.

I see one of the problems is how I could make new zram object's
attribute group for zram knobs under /sys/block/zram0 since block
layer already made zram0 kobject via device_add_disk.
