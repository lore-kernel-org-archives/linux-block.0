Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E04C4167B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4372323BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgLINKb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:10:31 -0500
Received: from mx2.veeam.com ([64.129.123.6]:49400 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732106AbgLINKZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 08:10:25 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 08:10:24 EST
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 0BAB94131D;
        Wed,  9 Dec 2020 08:01:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1607518906; bh=JTqT3LMXZw1By0AVPjPW5T3J6zJt6wgyTiqJzVkIVZA=;
        h=From:To:CC:Subject:Date:From;
        b=YeoxJmVyVrtCccC+JmCdywZguQTpBCdn+S7F5b05lxjxOUTwoPtxqKLnvsY33a/Nv
         67kjEeju2u/Ctz0syDqKc7n9jvkxeGhU9/EbcdthBdfMdD9DVPJKZ1OVBAX/6f6teP
         hz6PCKbcNVvMFPdAj37X+g1ABT4GTz25G4dxI5es=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 9 Dec 2020 14:01:43 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <johannes.thumshirn@wdc.com>,
        <koct9i@gmail.com>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <hare@suse.de>, <josef@toxicpanda.com>, <steve@sk2.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel.tide@veeam.com>, <sergei.shtepa@veeam.com>
Subject: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
Date:   Wed, 9 Dec 2020 16:01:48 +0300
Message-ID: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A627160
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all.

I try to suggest the Block Layer Interposer (blk_interposer) again.
It`s allows to intercept bio requests, remap bio to another devices
or add new bios.

Initially, blk_interposer was designed to be compatible with
device mapper. Our (my and Hannes) previous attempt to offer
blk_interposer integrated with device mapper did not receive
any comments from the dm-devel team, and without their help
I will not be able to make a full implementation. I hope later
they will have time to support blk_interposer in device mapper.

And my blk-snap module requires an architecture change to
support blk_interposer.

This time I offer it along with a sample.
Despite the fact that blk_interposer is quite simple,
there are a few non-obvious points that I would like to clarify.

However, I suggest the blk_interposer now so that people
could discuss it and use it in their projects as soon as possible.

Sergei Shtepa (3):
  block: blk_interposer - Block Layer Interposer
  block: blk_interposer - sample
  block: blk_interposer - sample config

 block/blk-core.c                        |  32 +++
 include/linux/blk_types.h               |   6 +-
 include/linux/genhd.h                   |  12 +-
 samples/Kconfig                         |   7 +
 samples/Makefile                        |   1 +
 samples/blk_interposer/Makefile         |   2 +
 samples/blk_interposer/blk-interposer.c | 276 ++++++++++++++++++++++++
 7 files changed, 333 insertions(+), 3 deletions(-)
 create mode 100644 samples/blk_interposer/Makefile
 create mode 100644 samples/blk_interposer/blk-interposer.c

--
2.20.1

