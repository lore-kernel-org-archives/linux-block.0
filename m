Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2AC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F364EBA
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhBASTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:19:52 -0500
Received: from mx2.veeam.com ([64.129.123.6]:54274 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhBASTe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Feb 2021 13:19:34 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 49F224114C;
        Mon,  1 Feb 2021 13:18:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612203523; bh=7r/MqH9loKA33bLlpIYLMsNQAOZIhKTb3ZZT72/pbio=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=SCPSxI8onESKQULwBs41MWCYQCvDLrQscXJXXes6K/SSYKsX8zKbQ/M77lfQhSpQw
         l+trIQi0nIMJ5ZQMqHEqfmh9tkwkIl4QjNi+yJf9V/JZU9hoR/vPFqqw7xg37pZ5Tw
         FwcAAonoYJ5FU6OFgGVDMjLkLQAHIsWzaEwK14Zg=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 1 Feb 2021
 19:18:40 +0100
Date:   Mon, 1 Feb 2021 21:18:35 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [dm-devel] [PATCH 0/2] block: blk_interposer v3
Message-ID: <20210201181835.GA2515@veeam.com>
References: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
 <5c6c936a-f213-eaa3-f4fb-3461a0b4dbe1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5c6c936a-f213-eaa3-f4fb-3461a0b4dbe1@acm.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26566776A
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 02/01/2021 18:45, Bart Van Assche wrote:
> On 1/28/21 9:12 AM, Sergei Shtepa wrote:
> > I`m ready to suggest the blk_interposer again.
> > blk_interposer allows to intercept bio requests, remap bio to
> > another devices or add new bios.
> > 
> > This version has support from device mapper.
> > 
> > For the dm-linear device creation command, the `noexcl` parameter
> > has been added, which allows to open block devices without
> > FMODE_EXCL mode. It allows to create dm-linear device on a block
> > device with an already mounted file system.
> > The new ioctl DM_DEV_REMAP allows to enable and disable bio
> > interception.
> > 
> > Thus, it is possible to add the dm-device to the block layer stack
> > without reconfiguring and rebooting.
> 
> What functionality does this driver provide that is not yet available in 
> a RAID level 1 (mirroring) driver + a custom dm driver? My understanding 
> is that there are already two RAID level 1 drivers in the kernel tree 
> and that both driver support sending bio's to two different block devices.
> 
> Thanks,
> 
> Bart.

Hi Bart.

The proposed patch is not realy aimed at RAID1.

Creating a new dm device in the non-FMODE_EXCL mode and then remaping bio
requests from the regular block device to the new DM device using
the blk_interposer will allow to use device mapper for regular devices.
For dm-linear, there is not much benefit from using blk_interposer.
This is a good and illustrative example. Later, using blk-interposer,
it will be possible to connect the dm-cache "on the fly" without having
to reboot and/or reconfigure.
My intention is to let users use dm-snap to create snapshots of any device.
blk-interposer will allow to add new features to Device Mapper.

As per Daniel's advice I want to add a documentation, I'm working on it now.
The documentation will also contain a description of new features that
blk_interposer will add to Device Mapper

Thanks.

-- 
Sergei Shtepa
Veeam Software developer.
