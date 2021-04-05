Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71703C433B4
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500A861359
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhDETAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:00:40 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:35525 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhDETAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 15:00:32 -0400
Received: by mail-pj1-f53.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so8324361pjb.0;
        Mon, 05 Apr 2021 12:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VQLxv+fwDrryOyCWC7P6vvpxkvE1Re9vaLtUj6lxGI=;
        b=H3asP2ZzIx+NdlkWz+9i3/k07R8MgsvyYPpkRIz/dHr+e4Qxe+VQN82NgsBeO9uiRN
         +jLWX6LdQcH7xm2hL416CEexHhel91/NN3HRuEVx2+4llp8WER095ksES2TgHy3FiNmI
         +T/iEeDRMnxRvCHfyh0FCCMn/e/0VyJUje4IM5s2lblMSzfzYA0CEy96LTVuej/Enpwt
         0kPbRB3BKr0IpAdcZc6NF9k/eiFCvirR6BpiGicPE4Nr6DvHBtiZrbfHLjqc5BTLW00P
         6sHQj47gQ2TjP/FwJBtP+ZxykLqGQ8BdSC4L145NQm8yNHnfZ+wTughdavbsyciU6cD4
         R7mA==
X-Gm-Message-State: AOAM530j5H7MSPlpXPGg8fnW4Vsk1mUOXEzs3/xmPSfi9xb0Kointnvv
        cvXPEe+NPV1tN8w3NdpW0Jc=
X-Google-Smtp-Source: ABdhPJw6EwpaSO/ZVSBEbVKmY2YSdf03bqIL1NtwVcoQlkLtx7FMFCXTYCN9DZGTs+Xa8yTX8oL2cw==
X-Received: by 2002:a17:902:b684:b029:e6:8efd:fb00 with SMTP id c4-20020a170902b684b02900e68efdfb00mr25800261pls.16.1617649225557;
        Mon, 05 Apr 2021 12:00:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f135sm16472839pfa.102.2021.04.05.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 12:00:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BB146404EF; Mon,  5 Apr 2021 19:00:23 +0000 (UTC)
Date:   Mon, 5 Apr 2021 19:00:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210405190023.GX4332@42.do-not-panic.com>
References: <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGtDzH0dEfEngCij@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 05, 2021 at 10:07:24AM -0700, Minchan Kim wrote:
> On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > And come to think of it the last patch I had sent with a new
> > DECLARE_RWSEM(zram_unload) also has this same issue making most
> > sysfs attributes rather fragile.
> 
> Thanks for looking the way. I agree the single zram_index_rwlock is
> not the right approach to fix it. However, I still hope we find more
> generic solution to fix them at once since I see it's zram instance
> racing problem.

They are 3 separate different problems. Related, but different.
At this point I think it would be difficult to resolve all 3
with one solution without creating side issues, but hey,
I'm curious if you find a solution that does not create other
issues.

> A approach I am considering is to make struct zram include kobject
> and then make zram sysfs auto populated under the kobject. So, zram/sysfs
> lifetime should be under the kobject. With it, sysfs race probem I
> mentioned above should be gone. Furthermore, zram_remove should fail
> if one of the alive zram objects is existing
> (i.e., zram->kobject->refcount > 1) so module_exit will fail, too.

If the idea then is to busy out rmmod if a sysfs attribute is being
read, that could then mean rmmod can sometimes never complete. Hogging
up / busying out sysfs attributes means the module cannto be removed.
Which is why the *try_module_get()* I think is much more suitable, as
it will always fails if we're already going down.

> I see one of the problems is how I could make new zram object's
> attribute group for zram knobs under /sys/block/zram0 since block
> layer already made zram0 kobject via device_add_disk.

Right.. well the syfs attribute races uncovered here actually do
apply to any block driver as well. And which is why I was aiming
for something generic if possible.

I am not sure if you missed the last hunks of the generic solution,
but that would resolve the issue you noted. Here is the same approach
but in a non-generic solution, specific to just one attribute so far
and to zram:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 494695ff227e..b566916e4ad9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1724,6 +1724,11 @@ static ssize_t disksize_store(struct device *dev,
 
 	mutex_lock(&zram_index_mutex);
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		err = -ENODEV;
+		goto out_nodev;
+	}
+
 	if (!zram_up || zram->claim) {
 		err = -ENODEV;
 		goto out;
@@ -1760,6 +1765,7 @@ static ssize_t disksize_store(struct device *dev,
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
+	bdput(dev_to_bdev(dev);
 
 	mutex_unlock(&zram_index_mutex);
 
@@ -1770,6 +1776,8 @@ static ssize_t disksize_store(struct device *dev,
 out_unlock:
 	up_write(&zram->init_lock);
 out:
+	bdput(dev_to_bdev(dev);
+out_nodev:
 	mutex_unlock(&zram_index_mutex);
 	return err;
 }
