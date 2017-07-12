Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62449 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752857AbdGLOxH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 10:53:07 -0400
From: Tomi Sarvela <tomi.p.sarvela@intel.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk
Subject: linux-next scsi-mq hang in suspend-resume
Date: Wed, 12 Jul 2017 17:51:50 +0300
Message-ID: <21128504.iYAzanzLsA@fractal.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello there,

I've been running Intel GFX CI testing for linux DRM-Tip i915 driver, 
and couple of weeks ago we took linux-next for a ride to see what kind 
of integration problems there might pop up when pulling 4.13-rc1. 
Latest results can be seen at

https://intel-gfx-ci.01.org/CI/next-issues.html
https://intel-gfx-ci.01.org/CI/next-all.html

The purple blocks are hangs, starting from 20170628 (20170627 was 
untestable due to locking changes which were reverted). Traces were 
pointing to ext4 but bisecting between good 20170626 and bad 20170628 
pointed to:

commit 5c279bd9e40624f4ab6e688671026d6005b066fa
Date:   Fri Jun 16 10:27:55 2017 +0200

    scsi: default to scsi-mq

Reproduction is 100% or close to it when running two i-g-t tests as a 
testlist. I'm assuming that it creates the correct amount or pattern 
of actions to the device. The testlist consists of the following 
lines:

igt@gem_exec_gttfill@basic
igt@gem_exec_suspend@basic-s3

Kernel option scsi_mod.use_blk_mq=0 hides the issue on testhosts. 
Configuration option was copied over on testhosts and 20170712 was re-
tested, that's why today looks so much greener.

More information including traces and reproduction instructions at
https://bugzilla.kernel.org/show_bug.cgi?id=196223

I can run patchsets through the farm, if needed. In addition, daily 
linux-next tags are automatically tested and results published.

Best regards,

Tomi Sarvela
-- 
Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
