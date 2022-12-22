Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5765C4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 15:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiLVPWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiLVPWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 10:22:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9202B254
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m18so5667671eji.5
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00e9FJpVGfEOAiHvEaDoajL9FdeFE17qZFjV5ZA2BMg=;
        b=EVi3Vc9v/lZHjNlZy63H9HJA32sgrDaK4EOlRf44uvWlkkHR56dlTLOEOh9ql8GhH+
         Bh7NrP5yO+j8uOJw9C53S4+SwuK2E2XXoECRZnnIkDalrNlSdk9bUKQZ9mI8qTNLXLcy
         igM3WhHNkdk/I+Ki+PyZ3Tp07Q75Z7iy/Wj+DMSbZSrW8Yv9+J1f8rLGgM40P9u7RLrB
         DuPv4cUUFEdjPgnh+NwK6T5wb9mFL2VOuGsg26TIcOcpCCl5w69ciB6OKN5mS1nIFohJ
         DWMH+rDbxCVdSk8bhiz4ObE1SEztQtj44jr8VTG1dSVtXPJBiiQvx+7aPiiUXTroPNux
         ekcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00e9FJpVGfEOAiHvEaDoajL9FdeFE17qZFjV5ZA2BMg=;
        b=a7LjkLCGe1cP6hcCAsurtnfpNTlZEPY/Nni0sbFeK2jpdJkFyYAppNqnLz2EWwhH7t
         Iap+5Lvao+7mo65bKl5rOnC8iayd9DaBic6RmgGYnUsS6Z8nIXJ+AUNr3BBnB7ZZ+9ZR
         eeFtmfYlOBGEjQ4H14qScamooMvEEcIVrfGhASN5pkB0ENfbI2XTzsI8slOlzNNhR/96
         SB4oZTzZs3QDgiMe2nrzBEBmHHoMtjRMCKFWuYpD/2HibiTgRNwgO0/Am+wwPkr6yGQC
         qBDjI8TX11LUEN6OI7oD/z98+oROa2IEZQF7pv8J3RqLxoGwTMxIEbLWb9bQLyjWTW4x
         Roeg==
X-Gm-Message-State: AFqh2kpHiprRIqQ1YqYVeX2UKePf+EH7y5ZQ6IPnBragIm1WB75JrfqS
        DBnbX/boUeL4NVGmGCOK7V50fRbVlpd15fGO
X-Google-Smtp-Source: AMrXdXslN8b6R+g9KHsnBjoshEGJHr9DIix6zotavKJINuzFk309lGbOAEitD5WLkDrSRpER4xWtwQ==
X-Received: by 2002:a17:906:39d8:b0:847:410:ecff with SMTP id i24-20020a17090639d800b008470410ecffmr831336eje.16.1671722524619;
        Thu, 22 Dec 2022 07:22:04 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007c08439161dsm355670ejo.50.2022.12.22.07.22.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:22:04 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V12 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu, 22 Dec 2022 16:21:49 +0100
Message-Id: <20221222152157.61789-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is the V12, it differs from V11 in that it applies the
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
[2] https://lore.kernel.org/lkml/20221220095013.55803-1-paolo.valente@linaro.org/T/#m28f40c3b060087a230998a3b55a021020c396cab

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
 block/bfq-iosched.c | 591 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 569 insertions(+), 259 deletions(-)

--
2.20.1
