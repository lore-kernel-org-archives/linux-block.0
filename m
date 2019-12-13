Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6420C34963
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001C024712
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfLMOcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:32:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32785 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLMOcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 09:32:53 -0500
Received: by mail-io1-f66.google.com with SMTP id s25so2614130iob.0
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2019 06:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ha5H69ROwwwkt1q+crhJHJ6jyB4TwkL0Kag/FminmOw=;
        b=P+9OdaXKO13q2vzdnErgDLoQgBgsslF9BKxzNPUM30GZp+z0Hq0TXeuT7BegceL8fm
         kdwIB7aVkQUmHBJFmqoQcpeiMBw6IiLGu7j1O2FxwFLPJawToyhnoKmrZrI5NQ3q6b8j
         Kph/+88JFHIZHuBpBoNlnN1CKolpLh1MFPABETgoXFTOkLvnDe9OPQqlrP4JvCFlyaiF
         +gXJvSS9VvPWymGV2Xo1QT/UjsRZtJoEwDk4G0YXFL/YoMaxMkqbh6ksAaZ2X30L/9qs
         svPVPBW3s0nc7KsijQtpV3L6w8f0a9vZWLkkiDtfGsKYonU7ot3/aqr7R/VO1Gn+rioi
         PI/Q==
X-Gm-Message-State: APjAAAXbXbGiZjW/Mz/LMqfVXaAgYJYilqI2Oe1Cxbv0wtoEV0RWRkPj
        LFPSrLt1AWbot7QOEPvrtWQ=
X-Google-Smtp-Source: APXvYqwxNrrzs0WD7ke8k7C7Bm6RnN4UP3Qj+EEnG+8FkWx/RtPmo9X1LCBic/ZDvzLdVnUWX+hnPA==
X-Received: by 2002:a02:cb44:: with SMTP id k4mr4027059jap.26.1576247573019;
        Fri, 13 Dec 2019 06:32:53 -0800 (PST)
Received: from bvanassche-glaptop.ka.ltv ([75.104.68.105])
        by smtp.gmail.com with ESMTPSA id i79sm2785026ild.6.2019.12.13.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:32:52 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/4] Add an SRP test for the SoftiWARP driver
Date:   Fri, 13 Dec 2019 09:32:28 -0500
Message-Id: <20191213143232.29899-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
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

Changes compared to v1:
- Only run the new test if the kernel version is at least 5.5 (the version in
  which iWARP support was added to the SRP drivers) and if "rdma link" is
  supported.

Bart Van Assche (4):
  common/multipath-over-rdma: Fix expand_ipv6_addr()
  common/multipath-over-rdma: Rename two functions
  common/multipath-over-rdma, tests/srp: Make it easy to use siw instead
    of rdma_rxe
  tests/srp/015: Add a test that uses the SoftiWARP (siw) driver

 common/multipath-over-rdma | 58 +++++++++++++++++-----
 common/rc                  | 28 +++++++++++
 tests/srp/015              | 45 +++++++++++++++++
 tests/srp/015.out          |  2 +
 tests/srp/rc               | 98 ++++++++++++++++++++++----------------
 5 files changed, 179 insertions(+), 52 deletions(-)
 create mode 100755 tests/srp/015
 create mode 100644 tests/srp/015.out

