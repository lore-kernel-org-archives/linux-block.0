Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8654C4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 09:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLIJow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLIJou (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 04:44:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930045F6CE
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 01:44:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so2329871edj.13
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 01:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfI4vsEkYZcvS0kTttCan8tA6wqo2c0ZacXpsvLTWzM=;
        b=XcarWuHZMTRs5AOZBw/0jYp1FkwxKFBjVogjXX1mlauUBECcasU88p8X5sQGIwxqnB
         NJ2tT7sWa7WhDscBCcic1qSZsWBonbjM22q93xqiQuRaBA+bLGzZSSVmjouaTE0f6Bjm
         mu+TLpuhfiy5LTc1VK3X281sLZKHBL/inEkfdu4WXAxeqHnprdhpNCll+dV8d8JE1vT2
         IpFtcMrSprl1wbrYqB8akJ4nOvdJLuHiOu6W2VTlJABn+Kw+mlp54+Uu2mKM9lcugVd+
         kBcyf78LWC0etYtY+BrVx4d1hYlpaaNtpsiOIBCy3BTvehcQu1kMB9rb2j56wHXaGBdM
         kT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfI4vsEkYZcvS0kTttCan8tA6wqo2c0ZacXpsvLTWzM=;
        b=EDkFUtHl5zwujrvtVXaUynBVAGRfYOcgavPIJr2BOrXIrK2CE7kaHUdEV0eumVHucS
         TkQxdWX5eeQ9OEjaYOfwtd8KBI546jv5ykorC7YmzDhXn6b3/uP7WvspKcezppkyBehF
         QSpllxYVO5WUBoH3ywpa7LSNbxpQ+BeXUvpFVBdNx80tGk3M5Yy0IGypQHgSRNxbQ8RC
         xnJAMVJCjlZtYrMg/f7bVa9vh0aMXqXvFK/1q82tuFkIINm7jMoQNVM74olvEC/34fas
         EuV+3r910voDZ7RPJxlWmkIrIKEkGDIcyC8wah6r6ZMgD3y7Nu8FKRrjQJReZsXwKbu+
         7eew==
X-Gm-Message-State: ANoB5plOdxVw/la2P6mM5yOZFrqRu1hI2ivD4Uy3UI6Ep1nM6+BfxC+L
        BQBFbVe2skZmGevKOdm3drwnBDzOA6YZ5Spw
X-Google-Smtp-Source: AA0mqf5DeqTiaS39hxMFl9rgsXY8FGFEZcgB5nhdAI56X3M3J0nb7ppN74OCnWJ9D0IIxXMeriYBzw==
X-Received: by 2002:aa7:c94e:0:b0:467:5491:1e21 with SMTP id h14-20020aa7c94e000000b0046754911e21mr4237385edt.12.1670579088125;
        Fri, 09 Dec 2022 01:44:48 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id oz18-20020a170906cd1200b007c11f2a3b3dsm353421ejb.107.2022.12.09.01.44.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:44:47 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Fri,  9 Dec 2022 10:44:34 +0100
Message-Id: <20221209094442.36896-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is the V10, it differs from V9 in that it applies the
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
[2] https://lore.kernel.org/lkml/20221208104351.35038-1-paolo.valente@linaro.org/T/#t

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

 block/bfq-cgroup.c  |  94 +++----
 block/bfq-iosched.c | 584 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 566 insertions(+), 256 deletions(-)

--
2.20.1
