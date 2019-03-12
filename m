Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F663C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03372147C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bviLqu9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCLJAE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41115 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCLJAD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so1732890wrs.8
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpaxuVPFYTGwRL/2DODlpf7LUNdqYBXLDXiz8LeznM8=;
        b=bviLqu9v7cPllaGCVF2cHXQohTxBX68huyHE6/b/wDXsQG9QsPeCEN2bzwuajeYrJK
         TjSt0Cnw5JjvgUbDqr196MF6bMJn954pFUgN90Xghtg82E46qi+cu7GYazTcK773JxZh
         WLNN9VRSqQ5tr+i3jemT2bcNfdeF8BrPZavabiWLqFxrCAd40o5cGGbJjXHi3qpeovgb
         rYuYC3a/20D3vzBuwaCuUC1j5ljWRmeDjQpNXrpY0MJuWJz87dEDVClbTSDqme+RRERA
         5wt2/B4ekRtygowQOIObJv/3Q2T5eQ70JJvELOQikWE3JPI4MQXWUO4zAmSAsr6P6Pvh
         1oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpaxuVPFYTGwRL/2DODlpf7LUNdqYBXLDXiz8LeznM8=;
        b=co0o16xw9IuHJX4Bke+Qy6uqYzobvnbK94/MeNWIzX3IMWXMO7vHXr0uyy1O1yWsta
         KvM+vHmSMi8aQ1b4iu0piziJ+1PrKCWSC/iqBW2TbV3ElEFP6OQ9DoW1DzUfy7fxj6WC
         JRGx9BUwGljwhQMdQ+qqU7z48zFti6FKGTZRRq+/tXYic49ldo8AN8U/uiO3lECXq5o9
         zxG3Oi4eutpM+2yXGbzBP87S+NSzm23bnZVI8NwP37WBlySusskB/sllxCKfNYVXHnTs
         iD5/4+1HOn7wT4W+O6jp9dKgy4Dfi2AwLBXDaaIp5tIaey5EqoPWWXOQVt8BGz4z3p3T
         AcNw==
X-Gm-Message-State: APjAAAWHeAdg9/4XouRyKbx8/Vgur1ggEWniaw8BbE4frl6nRsJ4xIYn
        4Y7cX9O4sw1AjQCSNcFa2xZ1bg==
X-Google-Smtp-Source: APXvYqwCDzZ/EPobkYCU6Hze9bWWfAXBGe2kJ54SwQbgxQJ1MkIGR39GLlYAVqpIgWBJsSyaM6E8Rw==
X-Received: by 2002:a5d:6948:: with SMTP id r8mr261116wrw.255.1552381201892;
        Tue, 12 Mar 2019 02:00:01 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:01 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 0/9] lock, bfq: fix bugs, reduce exec time and boost performance
Date:   Tue, 12 Mar 2019 09:59:26 +0100
Message-Id: <20190312085935.11340-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this is the v3 of the series
https://lkml.org/lkml/2019/3/10/138
that fixes some bug affecting performance, reduces execution time a
little bit, and boosts throughput and responsiveness.

The difference w.r.t. v2 are new fixes to the patch "block, bfq: print
SHARED instead of pid for shared queues in logs", after patient checks
and suggestions by Holger and Oleksandr.

Thanks,
Paolo

Francesco Pollicino (2):
  block, bfq: print SHARED instead of pid for shared queues in logs
  block, bfq: save & resume weight on a queue merge/split

Paolo Valente (7):
  block, bfq: increase idling for weight-raised queues
  block, bfq: do not idle for lowest-weight queues
  block, bfq: tune service injection basing on request service times
  block, bfq: do not merge queues on flash storage with queueing
  block, bfq: do not tag totally seeky queues as soft rt
  block, bfq: always protect newly-created queues from existing active
    queues
  doc, block, bfq: add information on bfq execution time

 Documentation/block/bfq-iosched.txt |  29 +-
 block/bfq-cgroup.c                  |   3 +-
 block/bfq-iosched.c                 | 786 +++++++++++++++++++++++-----
 block/bfq-iosched.h                 |  92 ++--
 block/bfq-wf2q.c                    |   2 +-
 5 files changed, 729 insertions(+), 183 deletions(-)

--
2.20.1
