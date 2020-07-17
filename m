Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B75CC433E0
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A4C2076A
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxO+Lekr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgGQIKb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQIKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 04:10:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F1C061755;
        Fri, 17 Jul 2020 01:10:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so6300350pgv.9;
        Fri, 17 Jul 2020 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wb+mPg1t2a/HwdF5pc/QRkfVddm7WxKqWMPXH/1N+qM=;
        b=LxO+LekrPnoGrzriVhswyB7/G1U2O6WqKZbD8gwzhVHXmrZAfaUFoi9vYk6U8ycsff
         k2SbF+c1uJ/5AUZLMGGo2n/HWylovQhcI5LcP20nPEWiCBtRDAkbotjK1MSpNGtbKusK
         7paGgCd/78ftlysmgKkIQDG9IxtkSjZvuy/U+KpGEd9GnGfRGZXfKpd+KFiTVwV6Ar1T
         Jfg8x8TE1ELJimwvB0QE+QyhvkSkTezA2Wwa+kURv5jxd5jt2zLzw0Imxskx1ezI2TEx
         YNIifYoRaPRBWRvjgB1pFDbhJcDP3yJ2Bp+FwsgeMUb6M06phhiRtzJHb90L9ZGOy3S3
         3kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wb+mPg1t2a/HwdF5pc/QRkfVddm7WxKqWMPXH/1N+qM=;
        b=UgSj7+pc6n398nZ5eH33OqBWUZYRsrGjZFb2CaXh/uWaqALsvyiW6bTmbn53acOC4W
         a9pgX/71VwP62xSqQmDed9mFtMYgLbYF0Z3gsSbg+NobwaU+MwT9/kTi601zSWS+PzZ0
         bLv2T3hAPAAYekyfEmQiIzB14lVDHlvJhLRQYgkr+JCPPAYRc83fLbu1E4+ROo8O60xI
         fSoi8qX8P9aOBa0gojMgHDQYNVpSv7h/2BAjSbY746SaQAREADU+K40AYmZYnE/5ooUp
         zrHp8GtfyZszPoCt+aQLmyODT3KXoPu8d3Bz6yQvWKMx2sOVf3vC5IWSzzgJ6NKI1YZF
         7kCA==
X-Gm-Message-State: AOAM530IExGWVEA4xv84Oad7wfK7+j6rqgMjLkFpv88lVGEVyRrojj/8
        f4YlpsvGZqZAdQkqi2HRyns=
X-Google-Smtp-Source: ABdhPJwxtCCwa1VmRCFBDVqGdQcJ/2V5fJ5JyH3gwwFNIOYc0esNeHrFaSxs2CqFCUyitRpWn4V8Nw==
X-Received: by 2002:a62:1d0b:: with SMTP id d11mr7346372pfd.1.1594973430357;
        Fri, 17 Jul 2020 01:10:30 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id d5sm1937296pju.15.2020.07.17.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:10:29 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 0/3] block: use generic power management
Date:   Fri, 17 Jul 2020 13:39:07 +0530
Message-Id: <20200717080910.342741-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to upgrade power management in block
drivers. This has been done by upgrading .suspend() and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
their job.

The conversion requires the removal of those function calls, change the
callbacks' definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (3):
  mtip32xx: use generic power management
  rsxx: use generic power management
  skd: use generic power management

 drivers/block/mtip32xx/mtip32xx.c | 54 +++++++------------------------
 drivers/block/rsxx/core.c         |  9 ++++--
 drivers/block/skd_main.c          | 36 ++++++---------------
 3 files changed, 29 insertions(+), 70 deletions(-)

-- 
2.27.0

