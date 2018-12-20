Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660DC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9836E218D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545329911;
	bh=xj1yrDDF4dxZ0jgmpjhzECD0N7zPdcyGIQnnyUmFHiY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ACFMV0ZOheEtdmfHY80yZVDNzDZozsUgaF5KJF90V833orQChvthBs+CczrQNgpk8
	 6nneKvUClNMaXqeiNurdSwFTgX7mkxN/w4u25EGmRuyDfT/BMF1yZ/hjpRfuMQz+Sf
	 /08XZcYPtMP5bKYMgTcd9VX502gXFWxJuSfevJks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeLTSSb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:18:31 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45962 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeLTSSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:18:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so1041955ywd.12
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 10:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YyRuqjnW4LfNozhJsM7mwJlgob5Pj0wj7b6QRgp6XXM=;
        b=tJSsmO4Y99IDopu3FdzH4DyiYKKcWt7MRzAvCKz+8P6TLRydZMaqlIKk/pPdegeVDp
         v/YEJdJHM4vttKt8K8n1r2AuUH6D7Swd8TdMI3lywB549R7NHRKcWnHTiYekJ7bYWPAF
         qNFSvR12lSMwFWoBP5352ywzJGG+w0kzod/iNjL+7eIu6rIpOMuXRXSGAYqGXjh4iOke
         XbYrFdan8E+XIbzyIvU4Jg6gQ1O0WDZN6BzvVjkBVPkwzLJ/wWO+EFBPzSSzFrPEMWi9
         DQbg9PuTP0BRYSyz9es3rbN+sJqM88OBEp3k9zNmS/utVVqLYx+ohL3bcOFANTvUzLF8
         LiwQ==
X-Gm-Message-State: AA+aEWZtdrIyo6QmN7M62KUyy8DJA9l5nMvt6WODLb+AfqwPfRpRtDgN
        UAFZYnSaeNrP30fowbn6HSKrti4TB30=
X-Google-Smtp-Source: AFSGD/XtFSsPNhIZbXAPReKrX2PObMHhD+6BmbLjQ9iW5U7UPXO9jcgSXEXIb2UBsVnYggppFLeHQw==
X-Received: by 2002:a81:a748:: with SMTP id e69mr26753005ywh.309.1545329909972;
        Thu, 20 Dec 2018 10:18:29 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.2])
        by smtp.gmail.com with ESMTPSA id q185sm7115113ywe.87.2018.12.20.10.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 10:18:28 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH blktests v2 0/2] Add scsi-stress-remove to blktests
Date:   Thu, 20 Dec 2018 12:18:24 -0600
Message-Id: <20181220181826.55481-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

v2:
There was a minor typo in 0001 pointed out by Omar which I fixed here.
0002 was refactored to use common/scsi_debug. I also rebased onto the
top of osandov#josef changing the test from block/022 -> block/027.

From v1:
Ming Lei's scsi-stress-remove test found a bug in blkg destruction [1]
where bios being created when the request_queue was being cleaned up
threw a NPE in blkg association. The fix is currently being discussed in
[2]. To make this test more accessible, I've ported it to blktests with
Ming Lei's copyright. I've tested this in my qemu instance and verified
we do not see the NPE on a fixed kernel.

Ming, please let me know if you have any objections.

[1] https://lore.kernel.org/linux-block/CACVXFVO_QXipD3cmPvpLyBYSiEcWPN_ThQ=0pO9AwLqN-Lv93w@mail.gmail.com
[2] https://lore.kernel.org/lkml/20181211230308.66276-1-dennis@kernel.org/

This patchset is ontop of osandov#josef 98db2e11c97f.

diffstats below:

Dennis Zhou (2):
  blktests: split out cgroup2 controller and file check
  blktests: add Ming Lei's scsi-stress-remove

 common/cgroup       | 18 +++++++----
 tests/block/027     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/027.out |  2 ++
 3 files changed, 88 insertions(+), 5 deletions(-)
 create mode 100755 tests/block/027
 create mode 100644 tests/block/027.out

Thanks,
Dennis
