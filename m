Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33221 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdEJPU6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2017 11:20:58 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/9] block: T10/DIF Fixes and cleanups v4
Date: Wed, 10 May 2017 19:20:43 +0400
Message-Id: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

TOC:
1-bio-integrity-Do-not-allocate-integrity-context-for-fsync
2-bio-integrity-bio_trim-should-truncate-integrity-vector
3-bio-integrity-bio_integrity_advance-must-update-interator
4-bio-integrity-fix-interface-for-bio_integrity_trim
5-bio-integrity-fold-bio_integrity_enabled-to-bio_interator
6-T10-Move-opencoded-contants-to-common-header
7-Guard-bvec-iteration-logic
8-bio-add-bvec_iter-rewind-API
9-bio-integrity-Restore-original-iterator-on-verify-state

Changes since V3:
 - Rebase to next-20170505
 
 - 5'th patch: fold two functions to one, in response to hch@ comments
 - 7'yh patch: replace unreliable error set to TODO note, in response to hch@ comments
Changes since V2
 - Cleanups in response to commens from axboe@ and hch@
 - Use rewind bvec api to restore original vector on verify
 - fix one more bug with bip_seed update on bio split.

Changes since V1
 - fix issues potted by kbuild bot
 - Replace BUG_ON with error logic for 7'th patch

Testcase: xfstest blockdev/003
https://github.com/dmonakhov/xfstests/commit/3c6509eaa83b9c17cd0bc95d73fcdd76e1c54a85
