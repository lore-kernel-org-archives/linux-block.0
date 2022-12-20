Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F086C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 09:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiLTJue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiLTJuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:25 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE0140D1
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 01:50:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so27897259eji.5
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 01:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nQuG8pByalhJ70WsUAgrsYOXMyPHv7RuONImTbDvjw=;
        b=Ja97wKtsitFlBh+NaZM2lwnIDGETdb4ZT+7QUe0e5VI1v35CRalZ4U8zO4+y4HqwXU
         MOime7T/zIEzj0nahK23UJvA1lm2W1UxvUpCVpWNaqTP5on7rxfTUJTG7WtVcFkO/gwB
         +JbGX8+cTWHk4UyWUKPD/fVGSNk7jI9uyXsgbBh9JctQgV8yQLHh8DTQCs6KHRZOWm5W
         +O+nqKbP75dHv/x3NT6cQ7BhOgD3GykquwPyB1GChUFj8CfUnl4ts4zgycuynSBtlT6O
         8z7RLSjYwuEHHYiduvzXywJ8iT6PVWffRn5qINJPUfAl6H1N7lIwrva/xIdZrd63vjBI
         vBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nQuG8pByalhJ70WsUAgrsYOXMyPHv7RuONImTbDvjw=;
        b=P5Oy0g/Bj2sq9Clq5HKU3p/Xb2J8l9ohcXSqcUr8XVnh3DgmBI1/FHo8xh/pJba716
         3ApZrrI7/bqZYQYpAtLm833EgO9asUYxGYsFRxy5Z2Sa7DaeUXkYWznVJK8eSIrAtTQE
         Miu1A9wMCIhwxpzz7IUbVlI2BJurvWuH8n7DSL1iB5XuQgD1xbtmzXK8i2XlYNf8aoSM
         t89ANG1BbYs+o0hL+woXpBhj9e/yJM0wFienuAkzo1fMHT2VITnnZrd54ci1JFo565JB
         WySo77uFhgpZljoWjCoLr6JmTQ2YgwvcDJvh1T/LpZ2YzYXMmWvcUeEzaVxijQm+f0ui
         ne9g==
X-Gm-Message-State: ANoB5pkhP4rZZGLigG7Ce3zLRT2vvEKXRT67mVEfqmUjKKu7dlESlmQR
        cg0TiEHbNcC6mrfDG8Hoh892DQ==
X-Google-Smtp-Source: AA0mqf7xfEw/DMLYPHFCjKIJT1o5qvECx/OBismwmvSywO+FR0zpBS44Sm2IK/BsNn2wKMhNqSUHoQ==
X-Received: by 2002:a17:906:3716:b0:7c0:bbab:22e5 with SMTP id d22-20020a170906371600b007c0bbab22e5mr35828687ejc.16.1671529822049;
        Tue, 20 Dec 2022 01:50:22 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0082ea03c395esm1669207ejf.74.2022.12.20.01.50.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:50:21 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V11 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue, 20 Dec 2022 10:50:05 +0100
Message-Id: <20221220095013.55803-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is the V11, it differs from V10 in that it applies the
recommendation by Damien in [2].

Here is the whole description of this patch series again.  This
extension addresses the following issue. Single-LUN multi-actuator
SCSI drives, as well as all multi-actuator SATA drives appear as a
single device to the I/O subsystem [1].  Yet they address commands to
different actuators internally, as a function of Logical Block
Addressing (LBAs). A given sector is reachable by only one of the
actuators. For example, Seagate’s Serial Advanced Technology
Attachment (SATA) version contains two actuators and maps the lower
half of the SATA LBA space to the lower actuator and the upper half to
the upper actuator.

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
[2] https://lore.kernel.org/lkml/7125ff61-bf11-6f8c-8496-f2603371c214@kernel.dk/T/#mf28d4c2d5c5265b9bbf3bacbf0ebb2f9e4b907f5

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
  block, bfq: move io_cq-persistent bfqq data into a dedicated struct
  block, bfq: turn bfqq_data into an array in bfq_io_cq

 block/bfq-cgroup.c  |  93 +++----
 block/bfq-iosched.c | 577 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 560 insertions(+), 254 deletions(-)

--
2.20.1
