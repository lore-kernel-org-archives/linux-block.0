Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395EFC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3352064C
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAZV41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:56:27 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42054 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhAZEqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 23:46:06 -0500
Received: by mail-pf1-f181.google.com with SMTP id w18so9790158pfu.9
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 20:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TevLDGx6IiFMAmAKVMYNWkteiHuHEKNgEO4v2KV2j9Q=;
        b=B+K0/BZv9ZeS+t1Jz9ojbSMWuVWy7h7sInSpyKft8A+fLmErD1xRwoBVIPP235nT/x
         Lyv9Gduc4XgvFT6Esa55BNxlcwSxEteMDqM2ct6Qb+J2Xo5pJdRhXo9nfUsIHsCpQdT9
         89dWNLTGMSvpAnwjdgK7FcxSK32R4i4Tr7txS/6gwA2he2ArT+G5CKXEY3M+hQC1V/DJ
         U8RnjgMz5uvpnZJjAnxIx53MrlaqRDYrJlxfZ/qCSQOPZfp3u1aEk0cv9IJ0r5xL1a0d
         GCQsNel0NzrOWl1V2DlEKo1Ni1waIMXb64jeL9ObYQZjCNcjDHb2vz+Sqd3QzNfEvqHi
         nPgw==
X-Gm-Message-State: AOAM531DIxMMY8fQC546OgAm/SoLJXRjhRTqYKFC8t57baY55ilT/hHO
        2lIK5y3Im45CDXfr0wBT7h0=
X-Google-Smtp-Source: ABdhPJwNYGEsfoVre+EJRbvs3dH5EyheYwL+FatAc935T9orRQ4LHNTvpP+uVLc+ehEoeHVl8pCM8Q==
X-Received: by 2002:a62:e217:0:b029:1c1:59ed:ae73 with SMTP id a23-20020a62e2170000b02901c159edae73mr3733516pfi.6.1611636326524;
        Mon, 25 Jan 2021 20:45:26 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:f18a:1f6a:44e7:7404])
        by smtp.gmail.com with ESMTPSA id m1sm866857pjz.16.2021.01.25.20.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:45:25 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 0/3] Three SRP patches
Date:   Mon, 25 Jan 2021 20:45:16 -0800
Message-Id: <20210126044519.6366-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

The three patches in this series improve the SRP tests. Please consider these
patches for inclusion in the upstream blktests repository.

Thanks,

Bart.

Bart Van Assche (3):
  tests/block/030: Make this test less noisy
  tests/srp/rc: Improve reliability of stop_lio_srpt()
  rdma: Use rdma link instead of /sys/class/infiniband/*/parent

 common/multipath-over-rdma | 111 +++++++++++--------------------------
 tests/block/030            |   2 +-
 tests/srp/rc               |  52 ++++++-----------
 3 files changed, 48 insertions(+), 117 deletions(-)

