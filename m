Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF2CDB474
	for <linux-block@archiver.kernel.org>; Mon, 23 Oct 2023 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJWOI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Oct 2023 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjJWOI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2023 10:08:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A7DF
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2023 07:08:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA1EC433C8;
        Mon, 23 Oct 2023 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698070106;
        bh=3gWo7tjBRuYZBJ9f+7lIbsNH/KkmhwnNlWXy4mRvp9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Szg7Da0f3wnwQL27SHYE6vRppiIKmUoLGjknTMmg7hDaRzs2YVNgeA4Y5mqLIeLec
         Iq23GC2pziIxZM42pnEFcfX3FH2QH1XdVunea72/GcIiQgask8oqzHmHnPsVR9sjwp
         1nBF0v+6eOkI/36t8eY98NwOROQlDtWUL6mBTgCpiqWOCJzy27sdflFLICCCk/+O2q
         qykaoUPQDZ/0e9RTMvCywZ3bbPAzC+9XGNFwdVQIWGw/PM1Ir6TEIKtunPOpyzsurE
         OcuS73wE+CXF5mMWfAF3T2GGDXSdwkSyiFUhmiguvMV1o1RUNGKtpRIi3XWue27tTc
         4PE5EcHFdTESg==
Date:   Mon, 23 Oct 2023 16:08:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: LOOP_CONFIGURE uevents
Message-ID: <20231023-biberbau-spatzen-282ccea0825a@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020120436.jgxdlawibpfuprnz@quack3>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > And one final question:
> > 
> > dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> > disk_force_media_change(lo->lo_disk);
> > /* more stuff */
> > dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> > 
> > What exactly does that achieve? Does it just delay the delivery of the
> > uevent after the disk sequence number was changed in
> > disk_force_media_change()? Because it doesn't seem to actually prevent
> > uevent generation.
> 
> Well, if you grep for dev_get_uevent_suppress() you'll notice there is
> exactly *one* place looking at it - the generation of ADD event when adding
> a partition bdev. I'm not sure what's the rationale behind this
> functionality.

I looked at dev_set_uevent_suppress() before and what it does is that it
fully prevents the generation of uevents for the kobject. It doesn't
just hold them back like the comments "uncork" in loop_change_fd() and
loop_configure() suggest:

static inline void dev_set_uevent_suppress(struct device *dev, int val)
{
        dev->kobj.uevent_suppress = val;
}

and then

int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
                       char *envp_ext[])
{

        [...]
 
        /* skip the event, if uevent_suppress is set*/
        if (kobj->uevent_suppress) {
                pr_debug("kobject: '%s' (%p): %s: uevent_suppress "
                                 "caused the event to drop!\n",
                                 kobject_name(kobj), kobj, __func__);
                return 0;
        }

So commit 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
tried to fix a problem where uevents were generated for LOOP_SET_FD
before LOOP_SET_STATUS* was called.

That broke LOOP_CONFIGURE because LOOP_CONFIGURE is supposed to be
LOOP_SET_FD + LOOP_SET_STATUS in one shot.

Then commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions")
fixed that by moving loop_reread_partitions() out of the uevent
suppression.

No you get uevents if you trigger a partition rescan but only if there
are actually partitions. What you never get however is a media change
event even though we do increment the disk sequence number and attach an
image to the loop device.

This seems problematic because we leave userspace unable to listen for
attaching images to a loop device. Shouldn't we regenerate the media
change event after we're done setting up the device and before the
partition rescan for LOOP_CONFIGURE?
