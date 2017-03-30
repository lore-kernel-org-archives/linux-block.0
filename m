Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36362 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933002AbdC3Nto (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 09:49:44 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/8] block: T10/DIF Fixes and cleanups
Date: Thu, 30 Mar 2017 17:49:28 +0400
Message-Id: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch set fix various problems spotted during T10/DIF integrity machinery testing.

TOC:
## General bulletproof protection for block layer
0001 Guard bvec iteration logic
## Fix various bugs in T10/DIF/DIX infrastructure
0002 bio integrity: Do not allocate integrity context for 
0003 bio integrity: save original iterator for verify stag
0004 bio integrity: bio_trim should truncate integrity vec
0005 bio integrity: fix interface for bio_integrity_trim
## Cleanup T10/DIF/DIX infrastructure
0006 bio integrity add bio_integrity_setup helper
0007 T10 Move opencoded contants to common header
## Fix tcm_fileio info leak
0008 tcm_fileio: Prevent information leak for short reads

Testcase: http://marc.info/?l=linux-scsi&m=149087997013452&w=2
