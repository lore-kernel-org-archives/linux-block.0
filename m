Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1639DC00307
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 07:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D818F21A4A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 07:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKRj88wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfIIHcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:32:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfIIHcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 03:32:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id p13so13372301wmh.1
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2019 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1DB8hLBI0DfoqSgN7BPkx2C4LPQLRBtlT6+2pkAJhs=;
        b=HKRj88wLIuKKvMVrlcCv44LZGStlBJSMMWn4leonTHif3dSsI6XAAv+OM86+GCrN1v
         /hOaBr4dA9agJJsMN2NYIiBjmsuYpTNf+QT52+rpd974601QbtgJW3WkeenkfG758vHI
         8ZxT/x+F2of1EhU+ByWFVGSyy1wTh1hM88FeSE1dPOx5hCgQYmVMy2M94iciqXojaTmL
         3VOUCnsFbF9Ancywa6eTxH/S//UOOLO/4AZLR5wRM1KS4iGmDekWn9sLA1XZwuc5p3s5
         QmPtliwpPqY1PJaqx6n0mXBW58VfnEJe87NWLZ/rah0/r1Rte+oSMwZzDYGlc18n3Dpp
         7wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1DB8hLBI0DfoqSgN7BPkx2C4LPQLRBtlT6+2pkAJhs=;
        b=HFA4VWHV52zkOKwQHFkSWFmszT4yzTMB2K8Wau1+Nqp3mThl/k5oJWqRBby64MX2Eb
         zsY8L6kvWkxZ0aGcJApczU5HsYTqDXFOG08DjKiRTQRaFUu9hJ35SIEjqR4rLFIH5g2Z
         4pwtbRvZi1ku5XOAPWvg6SkMCIHBvTBInKehG0tPe+pF5NOU0726UpOXmNBUmccxomim
         jyaS00pDJFuOL/wLh5SGLKIXylF0CKdWtrX0zlodlRLogBwzntHTxzU+sToKKVhqkL1k
         FLXDR/4wc9SomNylUXFL2OB5lWxuDIkKQbciqnhjRU/4C91tRwZxCTK9Q42IgCgYImXX
         EuSQ==
X-Gm-Message-State: APjAAAU1H8jJ3/MwTEFiaxs62sLDBO64IbPDc3u0e/g2i8a2f9O+98Mt
        Hktiddx80w1zUxxdsyrI0IW1HQ==
X-Google-Smtp-Source: APXvYqzv1j7KdbWHRbYvFmEQmw0sUCnWSiYEhKtrI2a3yeQ+7I2WDIr3T9Q1zYOP3/YMvnPk/YV7DA==
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr11413619wmd.117.1568014320844;
        Mon, 09 Sep 2019 00:32:00 -0700 (PDT)
Received: from localhost.localdomain (146-241-7-242.dyn.eolo.it. [146.241.7.242])
        by smtp.gmail.com with ESMTPSA id c8sm617012wrr.49.2019.09.09.00.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 00:32:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
Date:   Mon,  9 Sep 2019 09:31:16 +0200
Message-Id: <20190909073117.20625-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
now that BFQ's weight interface has been fixed [1], can we proceed
with this change?

In addition to acking this solution, in [2] Tejun already suggested a
reduced version of the present patch. In Tejun's version, only
bfq.weight is changed. But I guess that legacy code may use also some
of the other bfq parameters in cgroups, without the bfq prefix. Apart
from that, any version is ok for me, provided that it solves the
current confusing situation for userspace [3].

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/8/27/1716
[2] https://www.mail-archive.com/linux-block@vger.kernel.org/msg35823.html
[3] https://github.com/systemd/systemd/issues/7057

Angelo Ruocco (1):
  block, bfq: delete "bfq" prefix from cgroup filenames

 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--
2.20.1
