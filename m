Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA9C46467
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 14:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjACOzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 09:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbjACOzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 09:55:21 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A149FD21
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 06:55:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so67363434ejc.2
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2023 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuUtcOvepsI82FMOzxtotY8LlWD/xLqfqPDA8rrQV6I=;
        b=vk0kImVxbqsgz+D3pFJ+zgncojr3lo/6vNRXcflvLUAUAGNej4//WY59Ll/WXA6MUK
         WczzNidrEo76fNqlKC4Fet8Zd4aJQ3cVU+eMc0D65CeAKT/k2NLkFvGQYDG1mABklzp9
         7nD/VN+V0OunyJixyp8YH82Zos9Qf77K+ffr7SJsK7hY4CxCQWfBZH5s/lyHpr7mBFsX
         rr8Pohqjv1XZWlhmTPY/3/wuRoy31VynfTUXmiDSW5l6OeEsOeCgcXmEAqwepaUyhBs7
         Aa/++dGKiif2NOTCmS0SB1StXcEJXedxi/Fnep/YKjkV/+y1zRRybQWWpVC5XldBQR0l
         1aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuUtcOvepsI82FMOzxtotY8LlWD/xLqfqPDA8rrQV6I=;
        b=0ywtxMbW5HxxpGPUZTfKu8Ndi2PMQcukoE0Cj0Uoy/SJHxAzdRL8SM0lFkP029k2cx
         jUIwSNlRq5wpJpv+K2lfogW7i8ezIUCE+YsB6xZmuZdXSatEGF7H4cl/V4WcVbAa19hT
         XLXFGCRnIMif1LpyCcOERO31ZiQAHOrtWFliSB1//hAKoxjQASWisrh4j7+UmZO2Gnjp
         dEpZojjKhjPxcDKxle/nD0xwKVRiUV3YPxQlrhdShWjL8z+K1SiesAczGjO6LG3kQ5ni
         nScx1CtVWhHmtMB3FBdKauGpUFWXSMxvpYF29jbJSpfylaT76M+W9c6F0hEnJJKRX/mQ
         mE5Q==
X-Gm-Message-State: AFqh2kpz96q/Gd2dmyVJvjuZb3FvXt3fzxR4k286OFSH6rOgPHdIr8+l
        D68V89jfZasIEcKgtBb8t6qGSw==
X-Google-Smtp-Source: AMrXdXtIF3qQW4zznwlKQLihslUnYCYOd3ic9sw+60FBBdYzIMhnzl7q51Wcp/BVclMnTekafU2htg==
X-Received: by 2002:a17:907:7707:b0:844:c651:ce4b with SMTP id kw7-20020a170907770700b00844c651ce4bmr35936970ejc.33.1672757718948;
        Tue, 03 Jan 2023 06:55:18 -0800 (PST)
Received: from localhost.localdomain (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c16fdc93ddsm14122595eja.81.2023.01.03.06.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:55:18 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 REBASED 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue,  3 Jan 2023 15:54:55 +0100
Message-Id: <20230103145503.71712-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
rebased V13 [2].

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
[2] https://lore.kernel.org/lkml/20221229203707.68458-8-paolo.valente@linaro.org/t/

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
