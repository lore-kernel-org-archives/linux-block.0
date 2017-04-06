Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34518 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbdDFNTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 09:19:15 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/6] RFC add blkdev tests v2
Date: Thu,  6 Apr 2017 17:19:04 +0400
Message-Id: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

During LSFMM we have discussed how to test lower-backend of linux IO-stack.
Main idea was that xfstests is the most obvious solution which cover
most use-cases filesystem do care about. There were reasonable objections
that xfstests is not ideal place for that, especially when they mixed
with pure FS specific ones.

My opinion is that it is worth to have blkdev tests here, in xfstests,
instead of not have it at all. But tests have to be placed to separate
namespace "tests/blockdev" to prevent confusion.

Please review my RFC and tell me: Is my proposal too ugly? And we have to
have completely separate framework for basic blockdev sanity checks.
Assumptions:
  - All new feature and regression tests should goes to "tests/blockdev"
  - All tests belongs to 'blockdev' group
  - Pure blkdev tests (tests which behavior is independent from fs) is not
    added to 'auto' group. So it will not affect normal fs testing flow.

TOC:
0001-add-lio-target-helpers.patch
0002-add-blockdev-001-check-page-cache-coherency-after-BLKDISCARD
0003-new-blockdev-002-check-information-leak-for-lio-file
0004-new-blockdev-003-basic-blockdev-T10-DIF-TYPE1-integr
0005-new-blockdev-004-Check-that-live-fs-survives-blkdev
0006-new-blockdev-005-Check-that-busy-fs-survives-blkdev
