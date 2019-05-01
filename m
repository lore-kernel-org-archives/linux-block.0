Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DCC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891C21743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a40CkGKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfEAEdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEAEdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685202; x=1588221202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K3xEmJPQTOdOe+dyRZ7nlLxMY6ttnL4LqUIA7FGwIAw=;
  b=a40CkGKWWVFJAbnR4htb4ZsiQ2R4iO6tkw7G7l5vxAUqEwHPp/mrjwJ2
   6tewSzf1pdde04sgbeRwa5JPkNlgaAHhO35zQ9Ld5Fm0txBQlcvkQJIww
   b+hGQwkxJVgAhd8GjPTfXv3+uBrb3FJISTBAxTukkVv2Fn/EqgWeRfEI0
   euwiIBD9VDYADxGfldBIv4IS6CGaxVaGjWK400gpinS23fw2NXnQgd0bK
   0gJqr4We4551xWebU/3SvJw66XxHat3ZZtQBHun2yJTPog8aRyC4TQ6RG
   WnrbXzQO2NG/a4AAqqwOvZvjwDdjjwoJM7yRV0KVMovipTdbDIZJ/NS++
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229715"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:22 +0800
IronPort-SDR: VnpemOxarP7Z4T5aVollakE+7iKgQb2ipFYWyeDTguGyCKbyQqUwIG2Hycq1EWDLnHf41H9Ezn
 H3i3uateI19EMvFMGTKnT4ZG9gs+TJBAicEzvRtAcFGitiiLQwWf1ZKKeLHSRP6pFEe7AtoSpY
 iKlZGVoMHNhLz5nQGP3j0imBUPWac4Id7HH+cOHf2RPhih4y9boKec3VMFmEFEDRCEDISL/2g9
 41EFXi1shOMW4qbXVkVyBmnzjEA0DnC/UvttZ7LKCbccSbhQ/4L4Ff71UpLLlUhdg9GdE3Spyh
 Q7HyAgUSJZVd3XvUvAXJIzkw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:11:50 -0700
IronPort-SDR: mPlIk/f8ESMR6KPkjq88T/xsXo05d6XfuT4c2c48lMN1igPyBkZjdH21pI4r2jNyF3rjg1gbMP
 KBIXurn7BenJ/gWNCp2QL+qiM97eDmSpSP1jqvR4IA2uUiibvos54rvZ3Y7GB4Ufx0sIUUeqyE
 yqyYrSThmGMEpyrx7Qq9eiQVvb82g72AH5L/6+q9BU8N3LUNz6AyMueop6+HFzoN/0OGzlsQdW
 zvZ0Pc1l60inr94IGvdWbzyaEI34AONZL+GwOFeN7u4XATVbjcLWWhEHQsZBtFJ6SemwPS4gbU
 lT0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 00/10] blktrace: add blktrace extension support
Date:   Tue, 30 Apr 2019 21:33:07 -0700
Message-Id: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch series adds support to track more request based flags and different
request field to the blktrace infrastructure.

This is patch-series focuses on the userspace tools of the blktrace
infrastructure.

For more details about kernel part please refer to the following
patchh-series :-

Chaitanya Kulkarni (18):
	blktrace: increase the size of action mask
	blktrace: add more definitions for BLK_TC_ACT
	blktrace: update trace to track more actions
	kernel/trace: add KConfig to enable blktrace_ext
	blktrace: add iopriority mask
	blktrace: add iopriority mask
	blktrace: allow user to track iopriority
	blktrace: add sysfs ioprio mask
	blktrace: add debug support for extension
	block: set ioprio for write-zeroes, discard etc 
	block: set ioprio for zone-reset
	block: set ioprio for flush bio 
	drivers: set bio iopriority field
	fs: set bio iopriority field
	power/swap: set bio iopriority field
	mm: set bio iopriority field
	null_blk: add write-zeroes flag to nullb_device
	null_blk: add module param discard/write-zeroes

Chaitanya Kulkarni (10):
  blktrace.h: add blktrace extension to the header
  blktrace_api.h: update blktrace API header
  act-mask: add blktrace extension to act_mask
  blktrace.c: add support for extensions
  blkparse.c: add support for extensions
  blkparse-fmt.c: add extension support
  iowatcher/blkparse: add extension definitions
  blkiomon: add extension support
  blkrawverify: add extension support
  blktrace-tools: add extension support

 Makefile             |  3 +-
 act_mask.c           | 60 ++++++++++++++++++++++++++++---
 blkiomon.c           | 16 +++++++++
 blkparse.c           | 85 ++++++++++++++++++++++++++++++++++++++++++--
 blkparse_fmt.c       | 76 +++++++++++++++++++++++++++++++++++++++
 blkrawverify.c       | 26 ++++++++++++--
 blktrace.c           | 85 +++++++++++++++++++++++++++++++++++++++++---
 blktrace.h           | 46 +++++++++++++++++++++++-
 blktrace_api.h       | 66 ++++++++++++++++++++++++----------
 iowatcher/blkparse.c | 70 +++++++++++++++++++++++++-----------
 10 files changed, 477 insertions(+), 56 deletions(-)

-- 
2.19.1

