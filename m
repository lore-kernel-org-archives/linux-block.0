Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB279C76186
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE46220679
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfG2UcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:32:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43105 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfG2UcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 16:32:06 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCJR-0001qK-7z
        for linux-block@vger.kernel.org; Mon, 29 Jul 2019 20:32:05 +0000
Received: by mail-pf1-f200.google.com with SMTP id x18so39187477pfj.4
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 13:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMfAWDCqrjBeE42rbQCRmwqZEuUIVCeOcgzSaEx81J8=;
        b=eMP7PCk0y3/tCd7naAVwC5lX6sJ+ixiE7AdChGRDuE+QmspzSIgfmMR4iS2UuuV41i
         7pfHICPeHs341iiSE60gBkEgICrsZlNfAVW7DvmxP+ngcjTFOi1Emy4EOaBc+RCxC82j
         WEivsS8XadVCy6h+ZdYwFmvbNG4sFtZNn7tXH1Jq1TfIbv0B4KyVdpuUwVVRXwqMsuAk
         s/O3BP4om0ukaTlkRsp1nOFAtFRj0UXfgmvklOD8YefXzbiG40UP9r9jpaPXxrkhE1Xj
         wXb0YvKQ0JKol2YKplkSfdtBo++Olb1HQQcDjRnATETlqTuvvt/B/usOOZW9RyKDmFOo
         AqIg==
X-Gm-Message-State: APjAAAUJ/Mw40UPIeewY2ZFsYb/5zQklBrqYBi0xsY3gWa7Z/gnvJ9IQ
        SrttDM0vu/PwPtmRp7/IXRB3pDaaWyGdtu0mKIF1dmJH/seP0R0lpiOSvBTNyb6CZRRmr6lzBUo
        2xpk8AErICkZAn2rl6agViJG4O7LvA/+Nm2fFiuq6
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr113783962pll.236.1564432324028;
        Mon, 29 Jul 2019 13:32:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5CwXyWbTEeZiJ87HQ6jaOLVqakwH/nw+0O+WCPiV0SFTLFFtXdaAewFJs6dO9mSgODGZ6tA==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr113783942pll.236.1564432323845;
        Mon, 29 Jul 2019 13:32:03 -0700 (PDT)
Received: from localhost ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id i74sm122266922pje.16.2019.07.29.13.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:32:02 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com, neilb@suse.com,
        songliubraving@fb.com
Subject: [PATCH 0/2] Introduce new raid0 state 'broken'
Date:   Mon, 29 Jul 2019 17:31:33 -0300
Message-Id: <20190729203135.12934-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the md/raid0 device behaves quite differently of other block
devices when it comes to failure. While other md levels contain vast
logic to deal with failures, and other non-md devices like scsi disks
or nvme rely on a dying queue when they fail, md/raid0 for instance
does not signal failures if an array member is removed while the array
is mounted; in that case, udev signals the device removal but mdadm
cannot succeed in the STOP_ARRAY ioctl, since it's mounted.

This behavior was tentatively changed in the past to match the scsi/nvme
devices (see [0]), but this attempt was quite complex, it had some corner
cases and (the few) community reviews weren't generally positive.
So, we are trying again with a simpler approach this time.

This series introduces a new array state 'broken' (for raid0 only), which
mimics the state 'clean'. The main goal for this new state is a way to
signal the user that something is wrong with the array. We also included a
warn_once-style message in kernel log to alert the user when the array has
one failed member.

The series encompass changes in the kernel and in mdadm tool. To get the
'broken' state completely functional one requires both changes, but mdadm
and kernel can live without their counterpart changes (in case some users
gets an updated mdadm for example, but keeps using an old kernel).

This series does not affect at all the way md/raid0 will react to I/O
failures. It was discussed in [0] that it should be better if raid0 could
fail faster in case it gets a member removed; we just proposed a change in
that realm too (see [1]), but it seems better to have them reviewed/treated
separately.

This series was tested with raid0 arrays holding both an ext4 and xfs
filesystems. Thanks in advance for the reviews/feedbacks.
Cheers,


Guilherme


[0] lore.kernel.org/linux-block/20190418220448.7219-1-gpiccoli@canonical.com
[1] lore.kernel.org/linux-block/20190729193359.11040-1-gpiccoli@canonical.com


Guilherme G. Piccoli (1):
  md/raid0: Introduce new array state 'broken' for raid0

[kernel part]
 drivers/md/md.c    | 23 +++++++++++++++++++----
 drivers/md/md.h    |  2 ++
 drivers/md/raid0.c | 26 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

[mdadm]
 Detail.c  | 16 ++++++++++++++--
 Monitor.c |  9 +++++++--
 maps.c    |  1 +
 mdadm.h   |  1 +
 mdmon.h   |  2 +-
 monitor.c |  4 ++--
 6 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.22.0

