Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA6C3DA79
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 20:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiL2Uhl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiL2Uhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4C15731
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 12:37:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id x22so47372334ejs.11
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXFg2yYaAB6S4MxMGxEcZLOgUNKxyT0DBdu5JG8/72g=;
        b=KWJqtgZAz4Hx98dc87ZfYDATs7g2MgrmI3tCHcxxM+x6bF1Jbp1XOQjLtTkNSKxCdW
         n9/cnYq9Aza8+IJZn0tW1PlcwWW3sjOu6xrKWAzqy2x9ixxjNEFSbI3nZy6pd2jnssJL
         QeKn2eHtfUeHTCXkwqvZB7lwiNIXPTh5+RPk5vBwU6ds27rs/Toly/LjZtjdxAO3vkBC
         +F2j3Ipxm8bINILpnAcFlCoXrAb/xnwd1H7sSyQyXIAIXz2UGhXRfjszxtOtTEi3C24i
         RBGAI6PomfxgvBmSbg33HLFUgrL/BSg3fxENcdk51BIwDq08WNuiztN2rrNthPkJLjD4
         FuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXFg2yYaAB6S4MxMGxEcZLOgUNKxyT0DBdu5JG8/72g=;
        b=AyqCIpKpW14am36KxcPt0xJduCeOQgb0Jy0FxHISLt1tgy0kOAUI4qw3Y4ePbvWc1O
         jKura1Yx0ybotCPtkvlHiRxXRqmHAAszkwGQJyGxITToZWVuivKdcLHC+7YXZiqdXiWF
         qu/VdzrXZD4KrE8mwwOY7xyvU+rECodDjYPZhTNcOy6ood+f2G/jmLmHdjP5rNnSpxc9
         +747n267W24L7gsyI9py7pT12Jg+1ChBzJvPaIiwXQgQc3HxmV0Xkt4ymJrY+IazG5ir
         9Sn1qhRzPpopM93112iol3xpLEcqK/lJBoconsb9R4seBjRIP8n6ytJYhrBHja2fcdb1
         NmtQ==
X-Gm-Message-State: AFqh2kqitezo6dwQtAEBdyKHlSkbQzOw4gD55cBTSiFcAv+uve+KDRPT
        0O2NCVJdT60PgcCubBErJrCq7g==
X-Google-Smtp-Source: AMrXdXurFqQk307rW/edSlHzZMiOW+xO8s5Rrclekyw2EZyTuJYysKRqJfnIcwc3M1nGpHpHxN284A==
X-Received: by 2002:a17:906:60cd:b0:845:bb21:f638 with SMTP id f13-20020a17090660cd00b00845bb21f638mr21517513ejk.75.1672346258461;
        Thu, 29 Dec 2022 12:37:38 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:38 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu, 29 Dec 2022 21:36:59 +0100
Message-Id: <20221229203707.68458-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is the V13, it differs from V12 in that it applies the
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
[2] https://lkml.org/lkml/2022/12/26/428

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
 block/bfq-iosched.c | 587 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 565 insertions(+), 259 deletions(-)

--
2.20.1
