Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33014 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdDCHXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 03:23:49 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/7] block: T10/DIF Fixes and cleanups v2
Date: Mon,  3 Apr 2017 11:23:25 +0400
Message-Id: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch set fix various problems spotted during T10/DIF integrity machinery testing.

TOC:
## Fix various bugs in T10/DIF/DIX infrastructure
0001-bio-integrity-Do-not-allocate-integrity-context-for-fsync
0002-bio-integrity-save-original-iterator-for-verify-stage
0003-bio-integrity-bio_trim-should-truncate-integrity-vec
0004-bio-integrity-fix-interface-for-bio_integrity_trim
## Cleanup T10/DIF/DIX infrastructure
0005-bio-integrity-add-bio_integrity_setup-helper
0006-T10-Move-opencoded-contants-to-common-header
## General bulletproof protection for block layer
0007-Guard-bvec-iteration-logic-v2

Changes since V1
 - fix issues potted by kbuild bot
 - Replace BUG_ON with error logic for 7'th patch

Testcase: xfstest blockdev/003
https://github.com/dmonakhov/xfstests/commit/3c6509eaa83b9c17cd0bc95d73fcdd76e1c54a85
