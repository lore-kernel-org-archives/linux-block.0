Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C334C76191
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 07:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2720880
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 07:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2PZ8u/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfGRHJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:09:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41897 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfGRHJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 03:09:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so24199254wrm.8
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG/8zjsGwI0huheQ1dD8J/Pm1m5zJ9oP8/IXUD2TeEQ=;
        b=F2PZ8u/l3YIVkv1D6ehmIez5F4a2WimbKNbD1TdUxKEO9fs5XnjICg+eXO5fmngWTO
         6ygGEFomVV25RQUctGSQ7weqiHfmjyWkFwlG4j1tNrcXqdqOcbGc9xWJvJZfdNlw27rW
         X9n3ZNwuFdOD8qd13/S9t7JnsDlbaw02irLulivhnSHUmGM79Og9C6Dy2NjPS/YH1EKA
         vj67JWkUifzCwJj408axKnAOpFteMASKS8YWz+P+ODg2eFElHm74U6qFmqojLlj9aSWL
         o4kWxtpv++swn/dfJ+P5m9h4B+nilNwrVMKbGQv8KqPw3cJbRAuLHSS3Jt8f66tWxjH7
         VvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG/8zjsGwI0huheQ1dD8J/Pm1m5zJ9oP8/IXUD2TeEQ=;
        b=NH/ZNQa5jhJIHj10tDtC/wPFdRZKjOYlxur6OHmvb2JTfHW1pS7ykqGEvv2SXw1NDy
         RAUxA83OCjDqh2FlHqteOx3p0DBwWsK9UJZkhmKoG1P3dnhQKMy9cLdly5Uj+w1dHA/+
         9bGvdm+uT8cV17dCfXrSE+vMLspGBSdLWdzqcWK1YOZC5b4g5ok4Gi1tsSTpBl4T4Gi6
         9jelMt9u5lUFSGzNUjwxt0bQJX9yEk01sw7z0s2p+Nbd4/WESRiXb+w2yNb16GoW9T1h
         IK/ouCInDhmTnZ83gfr4hHnvbXNpnTrEPNpvXQ+sOe6Vh6i84DwJGb8zGvlIzOXtNLY3
         yHOg==
X-Gm-Message-State: APjAAAVJ5Zn55uGcBUqsRiwKXb93Sq3QudqEb9zro+MMwImxejAN6V5p
        ZcOE2boKxHITRNjOLNH5kObjgQ==
X-Google-Smtp-Source: APXvYqwFxi6I6lXXJDPgdJgauNEokbYo682URYuPkZ4F5UMpskKYb5wZTE9J+W5sDeiHZhDhFNwAvw==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr14732286wrl.281.1563433747231;
        Thu, 18 Jul 2019 00:09:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-85-178.dyn.eolo.it. [146.241.85.178])
        by smtp.gmail.com with ESMTPSA id a64sm26629527wmf.1.2019.07.18.00.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 00:09:06 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 0/1] block, bfq: eliminate latency regression with fast drives
Date:   Thu, 18 Jul 2019 09:08:51 +0200
Message-Id: <20190718070852.34568-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[V3 that mentions the fixed/improved commit]

Hi Jens,
I've spotted a regression on a fast SSD: a loss of I/O-latency control
with interactive tasks (such as the application start up I usually
test). Details in the commit.

I do hope that, after proper review, this commit makes it for 5.3.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: check also in-flight I/O in dispatch plugging

 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

--
2.20.1
