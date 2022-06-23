Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965EFC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiFWPx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiFWPx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 11:53:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8352E681
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:53:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n1so28316858wrg.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRHeHRH3cZ/+b6GPkMmzaCrX1eZuqFFPiinOLY5MTlE=;
        b=hdlvhWUmoY8QF+THiQiMKSf9mbrg9w85JT7zhHhzY7wNsYx6YrgXZQTRuzF7PQdDqr
         o3D9i2rd8+4gZ1TENoouV0UNpW4QPimhvWK2iudQ2PH5qIqnCWx9lXSV0EOpjLQXTEbE
         yfcbURQRZfcTehETyKUADw4a3Zd+3fI3I0c392K2oKyX2fwecptAd4+06z0TcBmk0qTq
         jNQvxdtUJEVzzf92NfsPUec2AJib5VtSEEm3Vcex+TEBnyZwhTigwT/ZdMWKwa0QEPUa
         iA3Rz43/ji9q+4IaE71p2XjawKS9qfNUvxxmLmiiOZ3XfIoG6dPDb24Yo1QUNr8ekWlg
         9LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRHeHRH3cZ/+b6GPkMmzaCrX1eZuqFFPiinOLY5MTlE=;
        b=y2l7xPIyL0BKp3nhDYMFJycYFkb7+hx2nUIWoeVm3iMggSkXUdtYitom8wv181V4tu
         hNzF5V4rKg5CAWnnms9sDpTj5ECRfmJzLxTszUBIKvGtBWj/U9KVlgYG3pBJXdSUSs9U
         Ym3AeWbWDDul6J8E4d3H3O8oQ0BK+FUC2nIdiQD8W9BE5gHEVidRXXo0uy67C/5hqL66
         2WuXcmIWX1WgD1FVJErq7vjKIL2Jwcjwl1cd/LCEpObW8IspwGjUgmJ4ho3OlHp+zkY1
         gYjeZy5sauFBVNRithAJMTjB8pniQZoC5fHSEVy8iQz6+hyZGStFeGuyUmLf+KrIbUBf
         5ipw==
X-Gm-Message-State: AJIora+6OeGYwFYp73cAfXw+exGrgay6K3xXp8kcU/T8B4cLDhpg55ng
        79j/msQj2DDJxGlO3RET59LnIg==
X-Google-Smtp-Source: AGRyM1sFMHoVJujwMT2tPtzjdfOj+iNc5ECMWfGgZWojW6+E9IQ7J33jKf0TAMnleYrBhxf2rVFT7A==
X-Received: by 2002:a5d:4c50:0:b0:21b:a6cf:f699 with SMTP id n16-20020a5d4c50000000b0021ba6cff699mr4866352wrt.668.1655999634599;
        Thu, 23 Jun 2022 08:53:54 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:53:53 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu, 23 Jun 2022 17:53:27 +0200
Message-Id: <20220623155335.6147-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this patch series extends BFQ so as to optimize I/O dispatch to
multi-actuator drives. In particular, this extension addresses the
following issue. Multi-actuator drives appear as a single device to
the I/O subsystem [1].  Yet they address commands to different
actuators internally, as a function of Logical Block Addressing
(LBAs). A given sector is reachable by only one of the actuators. For
example, Seagate’s Serial Advanced Technology Attachment (SATA)
version contains two actuators and maps the lower half of the SATA LBA
space to the lower actuator and the upper half to the upper actuator.

Evidently, to fully utilize actuators, no actuator must be left idle
or underutilized while there is pending I/O for it. To reach this
goal, the block layer must somehow control the load of each actuator
individually. This series enriches BFQ with such a per-actuator
control, as a first step. Then it also adds a simple mechanism for
guaranteeing that actuators with pending I/O are never left idle.

See [1] for a more detailed overview of the problem and of the
solutions implemented in this patch series. There you will also find
some preliminary performance results.

Thanks,
Paolo

[1] https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-sata-hard-drives/

Davide Zini (3):
  block, bfq: split also async bfq_queues on a per-actuator basis
  block, bfq: inject I/O to underutilized actuators
  block, bfq: balance I/O injection among underutilized actuators

Federico Gavioli (1):
  block, bfq: retrieve independent access ranges from request queue

Paolo Valente (4):
  block, bfq: split sync bfq_queues on a per-actuator basis
  block, bfq: forbid stable merging of queues associated with different
    actuators
  block, bfq: turn scalar fields into arrays in bfq_io_cq
  block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS

 block/bfq-cgroup.c  |  97 +++++----
 block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
 block/bfq-iosched.h | 149 ++++++++++----
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 493 insertions(+), 243 deletions(-)

--
2.20.1
