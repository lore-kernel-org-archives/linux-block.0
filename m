Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E6C4332B
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5EF20739
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shBtMQX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgCUJpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:45:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35185 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgCUJpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 05:45:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so8917841wmi.0
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIxeWZSEoR5mYWjeyLRGn2yStyMPlpi+EFGqSgqgCYA=;
        b=shBtMQX3VrXGFYrmvkYj02IPnuOfoLJECFQuk+qyH0RjPjzQuKQlBXE8zgEZtKFago
         BUDC4yPxjTahxPIZI26mgaXzYBlcRXmdSl9Q39mXxlM/WV5aDVESL+FSKoiX8YiGGVxv
         Sp5yULxyFVGhYAbahEI29euRnygKsmM3k9mjkpfDgObL/maT73WpyMJve7g69EzY73em
         zUyvHryk7+WNpVTHp6Z11nuKVJnqt73sUgqpfs1PXzfozLIRMkuJpKsj/G5j6aHo4M5H
         dv9qF3KJyI8Rpac452PAq3Oam2idJWI+IXQVvyGFaM3dDJyqefy0CMX6JLOCs+Y0Uas2
         D9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIxeWZSEoR5mYWjeyLRGn2yStyMPlpi+EFGqSgqgCYA=;
        b=t3AnOCBJrhLO/hRPMqvZfYNI14jp+K8zZjpcdp6E6Kr6KckkZn2rf5lzd5DVfnzwaq
         nU0gsISv5WGf1GzvVb4J/Wn2HC0M0ST/M6eKqm6rOje0TUEdQqT+52sQ6yIJR0x5kx7W
         72g34n7qwOEhndKKCagtya1mL+xVUNKqf408CyLxMDdUB7ucNYwspg3mo7EpTPkW1SO3
         zH3Z1x1awaIKFmozK/z335DRCdK2fISVw0CX2QXK0WZHKecM8oXR8za87XN7ZIIYNpZO
         Jf7dNo1TlQlrOt/oSIstfDen15tJ5cLzx9z41KIDrXLfPji80+IV1Pjx+yeVL/elGPh0
         hJFw==
X-Gm-Message-State: ANhLgQ1o7BJV/84dUHnSx0Yw/PTEZejJkmO1PxvaoesHO0MMsxb/pvpa
        7Dnitujwvd11boKyCN3ZhtpxzA==
X-Google-Smtp-Source: ADFU+vtPhn4ISbrT1E+hpEtrUmnBVC5uWrCqkZZe4YUVdPySgJB9vhVnEWbiueAjeuWtpF2oXCqIJA==
X-Received: by 2002:a1c:a714:: with SMTP id q20mr15203754wme.148.1584783911597;
        Sat, 21 Mar 2020 02:45:11 -0700 (PDT)
Received: from localhost.localdomain ([84.33.129.193])
        by smtp.gmail.com with ESMTPSA id z203sm5396378wmg.12.2020.03.21.02.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:45:10 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/4] block, bfq: series of cgroups-related fix
Date:   Sat, 21 Mar 2020 10:45:17 +0100
Message-Id: <20200321094521.85986-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this is a series of four fixes. The first patch fixes the issue
reported in [1], while the following patches fix a few extra issues
found while testing the first fix.

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg50629.html

Paolo Valente (4):
  block, bfq: move forward the getting of an extra ref in bfq_bfqq_move
  block, bfq: turn put_queue into release_process_ref in
    __bfq_bic_change_cgroup
  block, bfq: make reparent_leaf_entity actually work only on leaf
    entities
  block, bfq: invoke flush_idle_tree after reparent_active_queues in
    pd_offline

 block/bfq-cgroup.c  | 87 +++++++++++++++++++++++++++------------------
 block/bfq-iosched.c |  2 --
 block/bfq-iosched.h |  1 +
 3 files changed, 53 insertions(+), 37 deletions(-)

--
2.20.1
