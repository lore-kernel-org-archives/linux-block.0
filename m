Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9BC352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 08:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiLFIQC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFIQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 03:16:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95988178BD
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 00:15:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so4346076ejc.2
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 00:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stOrUeAezGYWH6O5jRYFnyRnOGFSYXV3ludw//XtusM=;
        b=Uzo6WVa5XE+77HyTAn5Ic1ddgCFcKbbPuNTmHK8QywYcs2JKIpW0y6zrtIokCOmHPf
         0QxC6VwwGsJ+2uZId4MvlaPCAI1tzBsqqs9/UY6W1d0pAgEDCJkcoSnDwxt6QXCMZsE2
         eUSb8KQh95t68L2wDSe9niKDFsZZG7w5+T1wD5M94hS2BIx22IFZsItM1V065iP3LfWf
         0z6xTPNzDyFLDZGAw3Xk0iSsgLxykFd5Tfk7VgsdzFtGQCxKnKG5VoUxoY7tlMuRGbgA
         49apVPQc1mLxya/o7+hsjzjmUKXz6UEndO1IKfkOYYiCwoX+0MurcqZiIqveSQkzSVXi
         wZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stOrUeAezGYWH6O5jRYFnyRnOGFSYXV3ludw//XtusM=;
        b=HAy0gSuOQoMNCsSkGAlf73hSBOhZz2AeDhqLJvZKGxbanwUo0ckRzvOkbTJEL+JXyJ
         mjd6EeflYp4R2Stdfs1gGWCi3KC0E8MBnjal8j2gWBwqMWU7hxhhTnXiAtaVOecFv4nU
         4EdBXte+yB+9wg7npvJT+rYaSSqpepby7FkDnZp/3fEAnmHnOYnAKsow4d247Fewk9ax
         je8ZYtw4VTg9QtHAevLpWMOJkX631h69vJW9a2Dc0A19w0OMsHd9m+NgVLHEtaH7BK1O
         7Q9qNR5m544IB8i54KG2GWft28MuzKz1QnoqNX+XMq1+kWsOcDhv1b94riquc64Yn9xm
         pXlw==
X-Gm-Message-State: ANoB5pmvsCFuas02u0ZlFwNL/4Zh++7lK/S8D5oAJOUluXMntQvLx3fB
        yeuqzhmP/pfTaG2maYLz5j8bAw==
X-Google-Smtp-Source: AA0mqf4Fbck58myf45UKMDP+j97tSbHvZaV71xvZjUrVynI9H0xGLHQalfvut9hpd28nmFk0D4R1ig==
X-Received: by 2002:a17:907:2127:b0:7c0:ee16:3c5a with SMTP id qo7-20020a170907212700b007c0ee163c5amr7638168ejb.298.1670314558118;
        Tue, 06 Dec 2022 00:15:58 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm7161944ejw.148.2022.12.06.00.15.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:15:57 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V7 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue,  6 Dec 2022 09:15:43 +0100
Message-Id: <20221206081551.28257-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is a V7, which differs from V6 in that it addresses the issue
reported in [2].

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
[2] https://lore.kernel.org/lkml/20221103162623.10286-5-paolo.valente@linaro.org/T/

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

 block/bfq-cgroup.c  |  95 ++++----
 block/bfq-iosched.c | 575 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 561 insertions(+), 253 deletions(-)

--
2.20.1
