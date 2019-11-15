Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA7C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7F2072A
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKORHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:07:20 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:32988 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKORHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 12:07:20 -0500
Received: by mail-pl1-f174.google.com with SMTP id ay6so5077245plb.0
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 09:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku2qpjP0JNWbMNUlGt6wNW7Ml1J0eR/sRi8G+DIbzG0=;
        b=U+rebxfaxfVvEM5Zqyv92vzdhfrLVctRd9gYI06GFefpkMglLfDdOFwHGeJZLd9PDj
         Rz7h1bHgNs18Xs+n/9njvMBna2+1JrOPsGiOfQVO9cc7DBMgTaBKs5mCsj4bPa/BOrtH
         y7f09F/PvwYBZhsu1EsbXM8Uf7C69JEZP4JOuzM6f/0qjPTG15cUZKdkYs/Atfh3Wh0b
         sTxj7T9X2XhYSfhJR5H2MovolP0It2ylGnaFuN0s7IgiqVZTDmT+ci2q0Sw56QhvDKNq
         gSlbmW2NynMNI99o34pwnbxHmOzgvnQ/QHfVKURHKDkurY7vUvVWBIOjVSZGRKBhvIyf
         wa+w==
X-Gm-Message-State: APjAAAUa43bnlPG/md3MOjW2Y3d2GFilp/Gnmmgrw7NtqjYbLXNwZf1Q
        z3xP0Drp7SThyWk1HUoBous=
X-Google-Smtp-Source: APXvYqxmCJP8NhGGDTnhtCHVJaVUWGIOABLzRyL228TClMmYv6WXHujCQ5P8MINX9zpnc+dWuT9RQg==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr116060plo.289.1573837639572;
        Fri, 15 Nov 2019 09:07:19 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m7sm2364793pfb.153.2019.11.15.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 09:07:17 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 0/4] Add an SRP test for the SoftiWARP driver
Date:   Fri, 15 Nov 2019 09:07:07 -0800
Message-Id: <20191115170711.232741-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

Recently a new low-level RDMA driver went upstream, namely the SoftiWARP
driver. That driver implements RDMA over TCP. Support has been added in the
SRP initiator and target drivers for iWARP. This patch series adds a test
for SRP over SoftiWARP. Please consider integration of this patch series in
the official blktests repository.

Thanks,

Bart.

Bart Van Assche (4):
  common/multipath-over-rdma: Fix expand_ipv6_addr()
  common/multipath-over-rdma: Rename two functions
  common/multipath-over-rdma, tests/srp: Make it easy to use siw instead
    of rdma_rxe
  tests/srp/015: Add a test that uses the SoftiWARP (siw) driver

 common/multipath-over-rdma | 58 +++++++++++++++++-----
 tests/srp/015              | 42 ++++++++++++++++
 tests/srp/015.out          |  2 +
 tests/srp/rc               | 98 ++++++++++++++++++++++----------------
 4 files changed, 148 insertions(+), 52 deletions(-)
 create mode 100755 tests/srp/015
 create mode 100644 tests/srp/015.out

