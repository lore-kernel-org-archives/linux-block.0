Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6409FC10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD272183E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 12:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="teyby3rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfDRMCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:02:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39171 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388897AbfDRMCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 08:02:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so1699481ljg.6
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=S78YZJAKtE8N2Uzsmqz3nEmuAtHZYrQ7X+IGoi6+ZFA=;
        b=teyby3rVsiZUtnrIRk/rXJGJfwYtwLla94602mogMtMk0tJtj/p8RgBo56D259Y/zw
         h65IL66mNgAB1vfw15WTnxMLwfGb9Xz5+QceZ8JG3OmMlwz/Ja5IBc3DsSR+Ck5dGGcW
         03Z7fLgEDYnvGf9Ys+g/Osw3CbzPQRCedzn/WnYsZB781bIf+7xk72jSmZoLonCliEL1
         gx7phwuRilAdoR2XFVbpdp+oztvrHwiQ9m2l1ncfD0xF8PvA4H9KIWpGl7Y1tHrerINk
         KvA9u/zUArUG+nuPGvA7t5QRU7g1mgR1TSLit/rO5rEdOjN5CLq7QG/lXGG03LQuMKD8
         vEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S78YZJAKtE8N2Uzsmqz3nEmuAtHZYrQ7X+IGoi6+ZFA=;
        b=tUEkK6yRT52KqZ3Ri0ksTNQjEaDs9oMX9TA6u78HumKYIp6TQ2JUTw9YFIgXa2xvhI
         ITWc9GZ1H5M7FeXGS+pOFPMyd2x6G4iRluKVXLfEgmCXHnqPxYKQduJNgu+CgJyjhEDp
         cey1iIJZDAeqGr7inSXLQXLcl92cA55sNZtLfq9NZTuIXxRykf574HZ7GqM1vq+7vhIE
         cBbyUlXkuXBQWlkBp8898FD60hxWW2EBpyO0FQ3nHpfpqEXo0nKcPfbFzBApZ2dn5Un6
         GUtP8epPMgqjFdHRTkr0/VlhFl476bbP7PkFLIroE090cXtcCFStT0I4DTQv43tL7EvP
         Ef4g==
X-Gm-Message-State: APjAAAW80OZ5joJDHNseYYY/jwmzojgaVeG8e1CDb1Z983LCjKqBETls
        nXZjsG68LnrbQsgYHyIEWgDB/w==
X-Google-Smtp-Source: APXvYqx5yNS7Ty1ho4w9cIOwMmoTMUSW7i+6rMNezdwUKcDnTwnS0D4b1CKfH6yePpemJY/VfsBbVw==
X-Received: by 2002:a2e:5b5c:: with SMTP id p89mr50731370ljb.177.1555588933021;
        Thu, 18 Apr 2019 05:02:13 -0700 (PDT)
Received: from titan.bredbandsbolaget.se (c-bebee655.03-91-6d6c6d4.bbcust.telenor.se. [85.230.190.190])
        by smtp.gmail.com with ESMTPSA id l16sm409659lfk.44.2019.04.18.05.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 05:02:11 -0700 (PDT)
From:   hans@owltronix.com
To:     =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Klaus Jensen <klaus.jensen@cnexlabs.com>,
        Simon Lund <slund@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [RFC PATCH 0/1] Introduce a new target: lzbd - LightNVM Zoned Block Device
Date:   Thu, 18 Apr 2019 14:01:24 +0200
Message-Id: <1555588885-22546-1-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Introduce a new target: lzbd - LightNVM Zoned Block Device

The new target makes it possible to expose an
Open-Channel 2.0 SSD as one or more zoned block devices exposing
BLK_ZONE_TYPE_SEQWRITE_REQ zones.

I've been playing around with this the last couple of months and
now I'd love to get some feedback.

It's very been useful to look at null_blk's zone support when
doing the plumbing work and Simon and Klaus has also been very helpful
when figuring out the design. Thanks guys!

Naming is sometimes the hardest thing. I named this thing lzbd, as
I found that most descriptive acronym.

NOTE: This is an early prototype and lacking some vital
features at the moment. It is worth looking at and playing
around with for those interested, but beware of dragons :)

See the lzbd documentation(Documentation/lightnvm/lzbd.txt) for my ideas on how
a full implementation would look like.

What is supported(for now):

	* Reads
	* Sequential writes
	* Unaligned writes (a per-zone ws_opt alignment buffer is used)
	* Zone resets
	* Zone reporting
	* Wear leveling(sort of, wear indices are not upated on reset yet)

I've mainly tested in QEMU (cunits=0, ws_min=4, ws_opt=8).

The zoned block device tests in blktests (tests/zbd) passes, and I've done
a bunch of general smoke testing(aligned/unaligned writes with verification
using dd and fio, ..), so the general plumbing seems to hold up, but 
more testing is needed.

Performance is definately not what it should be yet. Only one chunk per zone
is being written to at a time, effectively rate-limiting writes per zone,
which is an interesting constraint, but probably not what we want.

What is not supported(yet):

	* Metadata persistance (when the instance is removed, data is lost)
		- Zone to chunks mapping needs to be stored

	* Sync handling (flushing alignment buffers)
		- Zone Aligment buffer needs to be flushed to disk

	* Write error handling
		- Write errors will require zone -> chunk remapping
		  of the failing chunk.

	* Chuck reset error handling (chunks going offline)
	* Updating wear indices on chunk resets
		- This is low hanging fruit to fix

	* Cunits read buffering


Final thoughts, for now:

Since lzbd (and pblk for that matter) are not entirely unlike file systems,
it would be nice to create a mkfs/fsck/dmzadm-like tool that would:

	* Format the drive and persist instance configuration in a superblock
	  contained in the instance metadata.
	* Repair broken(i.e. powerfailed) instances
	  Per-sector metadata is currently not utilized in lzbd, but would
	  be helpful in recovery scenarios.	


The patch is based on Matias for5.2/core branch in the github 
openchannel project. It is also available at [1] (branch for-5.2/lzbd)


Thanks,
Hans

[1] CNEX Labs linux github project: https://github.com/CNEX-Labs/linux


Hans Holmberg (1):
  lightnvm: add lzbd - a zoned block device target

 Documentation/lightnvm/lzbd.txt | 122 +++++++++++
 drivers/lightnvm/Kconfig        |  11 +
 drivers/lightnvm/Makefile       |   3 +
 drivers/lightnvm/lzbd-io.c      | 342 +++++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd-target.c  | 392 +++++++++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd-user.c    | 310 ++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd-zone.c    | 444 ++++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd.h         | 139 +++++++++++++
 8 files changed, 1763 insertions(+)
 create mode 100644 Documentation/lightnvm/lzbd.txt
 create mode 100644 drivers/lightnvm/lzbd-io.c
 create mode 100644 drivers/lightnvm/lzbd-target.c
 create mode 100644 drivers/lightnvm/lzbd-user.c
 create mode 100644 drivers/lightnvm/lzbd-zone.c
 create mode 100644 drivers/lightnvm/lzbd.h

-- 
2.7.4

