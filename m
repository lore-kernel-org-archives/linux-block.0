Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FEC4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 16:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKCQ0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKCQ0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 12:26:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3796DEF3
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 09:26:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i21so3820484edj.10
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tt/lBSJ07NTr/8w7hhp+nZAob7j7Xiq0qJ8m0UH5/hU=;
        b=quHYiChPb0Skd4UIuRGNpR9MbACvRzfrTff2KYgZMeH1TnKNWkV3gnKLRt4qxuItKf
         YaAo1VtOP8uCKfoGX3pV8CaLkX2MwXikncLam1oX6JEfT9tqq+lK+jyQT0rIPskfHFz3
         OVnMZf+5zhO5OSiDpoPXwJ7mu/VdUdM64GQ5x0kk3w9hPo+zNXvBwq7SccYSSnyx4dKM
         XmTqzf9KXpIreBCKPTvZebeVpKydna10/mBnerbmFczViYUtcKEB0Q2AAofDyUOfDsea
         wPk1fWl6DJSAv773+Wg5np6epQe9JIwFcPw7VYYg03srOEEouAdVNnppcaa+utCqeMp7
         81TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tt/lBSJ07NTr/8w7hhp+nZAob7j7Xiq0qJ8m0UH5/hU=;
        b=yXr1hy/TXsMOyxpoX8YArF2XYsGAdg/5AC+XLu1x07P0mANUYAZrkApsB9d35b5umY
         vO5f/p+GbbvObh7G6HHrtxkUNZLBukQn/9PV8XGwmrb7HKNci60UddbX4uIGTB1IHpNb
         oAeY/LorqQfX8DIRemICVoj+DYt+OiHllsqoA9+ZkboVCnEjd5P1yVgShBo6oJEKBuVB
         4LfpcvTyqMocXfHvM90HUtcUXVAGo4WnqvyUnTJh0N8cB/pHzuvB6CQtZDnExnCsM0iW
         UdTTLHPy1l8vU0a6aCyxyux6JqGmF8/SdmJtbL98gKtcJdUZIjgWlFCsg4TR3vgxpEpE
         w2rQ==
X-Gm-Message-State: ACrzQf28OamJ6fE2mKRCzIGxI22fGbj7L++HDvQ3zd5MlwPlXSG9wcqN
        Z49iY2qwrO9c06ibaV0MuUThkNTGzMuANQ==
X-Google-Smtp-Source: AMsMyM4On8hniExIm3sBavi2zeanTFcNEqBmzU2CfhKdD3EnXY/NiQRTzWY5qx4ZhlR25l7k2AcZGg==
X-Received: by 2002:a05:6402:51a:b0:461:970e:2adc with SMTP id m26-20020a056402051a00b00461970e2adcmr30802753edv.44.1667492796209;
        Thu, 03 Nov 2022 09:26:36 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0078116c361d9sm702507ejc.10.2022.11.03.09.26.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:26:35 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V6 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu,  3 Nov 2022 17:26:15 +0100
Message-Id: <20221103162623.10286-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this V6 differs from V5 in that it addresses the issue reported in
[2].

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
[2] https://lore.kernel.org/lkml/202210301803.9wm3k7D8-lkp@intel.com/T/#m3685011dacaf0801bd084b2a3194c861a4e940ba

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

 block/bfq-cgroup.c  |  97 +++++----
 block/bfq-iosched.c | 521 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 141 +++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 528 insertions(+), 233 deletions(-)

--
2.20.1
