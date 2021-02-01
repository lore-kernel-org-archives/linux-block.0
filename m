Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F6EC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34A264DDF
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 18:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhBASwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232197AbhBASwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Feb 2021 13:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612205447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ag2hr9ITdmwoOXE4cqwjfRTA5eKZrvwzLF1h6+abGtg=;
        b=V0ZVlK76TBOZ3UyoG+UPcPvucQp3OfU/bLleH4wrGiCVCa1BDFbJ0h5/UKBU7pKPHTkcFV
        H3JWJO1e1IUg12yqSlaBsr39DxB436tnXMgLeijtVplODKBIfk5xXIvVk3vtkHM38bvrqU
        70qYrnbfTwOLCvdAs4rMS+aW+9pGtPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-WbRlsJhuNouLuK2HDE-D5A-1; Mon, 01 Feb 2021 13:50:46 -0500
X-MC-Unique: WbRlsJhuNouLuK2HDE-D5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D447E15722;
        Mon,  1 Feb 2021 18:50:44 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A485C1A1;
        Mon,  1 Feb 2021 18:50:36 +0000 (UTC)
Date:   Mon, 1 Feb 2021 13:50:35 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH 0/2] block: blk_interposer v3
Message-ID: <20210201185035.GA9977@redhat.com>
References: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
 <5c6c936a-f213-eaa3-f4fb-3461a0b4dbe1@acm.org>
 <20210201181835.GA2515@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201181835.GA2515@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01 2021 at  1:18pm -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> The 02/01/2021 18:45, Bart Van Assche wrote:
> > On 1/28/21 9:12 AM, Sergei Shtepa wrote:
> > > I`m ready to suggest the blk_interposer again.
> > > blk_interposer allows to intercept bio requests, remap bio to
> > > another devices or add new bios.
> > > 
> > > This version has support from device mapper.
> > > 
> > > For the dm-linear device creation command, the `noexcl` parameter
> > > has been added, which allows to open block devices without
> > > FMODE_EXCL mode. It allows to create dm-linear device on a block
> > > device with an already mounted file system.
> > > The new ioctl DM_DEV_REMAP allows to enable and disable bio
> > > interception.
> > > 
> > > Thus, it is possible to add the dm-device to the block layer stack
> > > without reconfiguring and rebooting.
> > 
> > What functionality does this driver provide that is not yet available in 
> > a RAID level 1 (mirroring) driver + a custom dm driver? My understanding 
> > is that there are already two RAID level 1 drivers in the kernel tree 
> > and that both driver support sending bio's to two different block devices.
> > 
> > Thanks,
> > 
> > Bart.
> 
> Hi Bart.
> 
> The proposed patch is not realy aimed at RAID1.
> 
> Creating a new dm device in the non-FMODE_EXCL mode and then remaping bio
> requests from the regular block device to the new DM device using
> the blk_interposer will allow to use device mapper for regular devices.
> For dm-linear, there is not much benefit from using blk_interposer.
> This is a good and illustrative example. Later, using blk-interposer,
> it will be possible to connect the dm-cache "on the fly" without having
> to reboot and/or reconfigure.
> My intention is to let users use dm-snap to create snapshots of any device.
> blk-interposer will allow to add new features to Device Mapper.
> 
> As per Daniel's advice I want to add a documentation, I'm working on it now.
> The documentation will also contain a description of new features that
> blk_interposer will add to Device Mapper

More Documentation is fine, but the code needs to be improved and fully
formed before you start trying to polish with Documentation --
definitely don't put time to Documentation that is speculative!

You'd do well to focus on an implementation that doesn't require an
extra clone if interposed device will use DM (DM core already handles
cloning all incoming bios).

Mike

