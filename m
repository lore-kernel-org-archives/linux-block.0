Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33885 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbdDDS4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 14:56:48 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/9] block: T10/DIF Fixes and cleanups v3
Date: Tue,  4 Apr 2017 22:56:32 +0400
Message-Id: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch set fix various problems spotted during T10/DIF integrity machinery testing.

TOC:
## Fix various bugs in T10/DIF/DIX infrastructure
0001-bio-integrity-Do-not-allocate-integrity-context-for
0002-bio-integrity-bio_trim-should-truncate-integrity-vec
0003-bio-integrity-bio_integrity_advance-must-update-inte
0004-bio-integrity-fix-interface-for-bio_integrity_trim
0005-bio-integrity-fold-bio_integrity_enabled-to-bio_integrity
## Cleanup T10/DIF/DIX infrastructure
0006-T10-Move-opencoded-contants-to-common-header
0007-Guard-bvec-iteration-logic-v3
0008-bio-add-bvec_iter-rewind-API
0009-bio-integrity-Restore-original-iterator-on-verify

Changes since V2
 - Cleanups in response to commens from axboe@ and hch@
 - Use rewind bvec api to restore original vector on verify
 - fix one more bug with bip_seed update on bio split.
 
Changes since V1
 - fix issues potted by kbuild bot
 - Replace BUG_ON with error logic for 7'th patch

Testcase: xfstest blockdev/003
https://github.com/dmonakhov/xfstests/commit/3c6509eaa83b9c17cd0bc95d73fcdd76e1c54a85
