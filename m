Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE61CC63709
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 10:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLHKtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 05:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiLHKss (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 05:48:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95706578C9
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 02:43:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so2900255ejc.3
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayq2uzYmxur5KO3TBD7Tr7qziqy3xJrvwA2myfA8G2M=;
        b=zeWPkoCZb1FlV7oMvzbYNU2TqdCH2PecBvv9BOPMv1x/pbetJ/0zzxlW9aLYpXI+Uj
         rLpDGjKActCDbELjrkfq5YHMz/duulYHGsoVZe1eGCogKHRZDN0WicmHTwb52JJsDGv7
         mx+FomyfQPKw7Wi6EvBj6WfFjGpqVGOeQeWnR7x46B3oCKm+skdTsNqIVPbTfGcbhmur
         zRxWNz8W5DCd/WtodpRe2sna/Mxulse9tkACWGy4TzT8oSoD8SYSzB7K8DOuaZn5rdq5
         /3msWgsvHEatA0Np63ffbStzLoLqEw9hj4DJVvbJ86HmdRsK0dhaaRIO/bYSn9Nj7MvP
         EXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ayq2uzYmxur5KO3TBD7Tr7qziqy3xJrvwA2myfA8G2M=;
        b=HiVQldMZPqIvNrNdnR1ObqmudBs16thqJC20Y0GryS5hDUKYMcGbFxAsyIHqJmFTAZ
         EHgNMO9VXyM9UyEVFFWc/9AkbR2s+20P6p3bg7F3BaeHtL/98TJDhn9boFNgqNz6CeE+
         JdGd44oUCN6Q27OfgwZTyC2lErOQmhue/LJvdnzWHuQcOKwzoIMWv9kzbGLWkQtpBfQ4
         7kiYBrvTw4+tw4zVdxPhHuZ9aHEEUMEUjZENyvnJbToQfvfKscz+bLbOHOXq8iMCnpa8
         1E6U4/AuIGgpiRLR/ih8LlpLpp0Pkk6TZYP9yhyELWq1YjmIvsU5CwbxtC8fSu7WomJR
         i+QA==
X-Gm-Message-State: ANoB5pnaWO3c1HDYEHI5g7pKsgeufNeUS6MzaE9PIgrAwqkqjtiT/DHs
        iWLfFAaRRIH9XqEUqeebS9+pUg==
X-Google-Smtp-Source: AA0mqf4jzaLcHPMM3pVvfOP2Kujd1gMjC+2C370Fvv+vTgvoCQkzYjH+uTtcZZfjEx0gOgDzyKVPZQ==
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id z17-20020a170906435100b0078d513df447mr68192785ejm.708.1670496238174;
        Thu, 08 Dec 2022 02:43:58 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9544193ejc.210.2022.12.08.02.43.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:43:57 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V9 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu,  8 Dec 2022 11:43:43 +0100
Message-Id: <20221208104351.35038-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is the V9, it differs from V8 in that it applies the
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
[2] https://lore.kernel.org/lkml/20221103162623.10286-5-paolo.valente@linaro.org/T/#mdb87dc01b2ac165056ee3c7a1386754dea42a006

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
 block/bfq-iosched.c | 580 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 565 insertions(+), 253 deletions(-)

--
2.20.1
