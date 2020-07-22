Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F269C433E2
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F9A2077D
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzz9d3FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGVIfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGVIfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 04:35:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B419C0619DC;
        Wed, 22 Jul 2020 01:35:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so814387pgc.5;
        Wed, 22 Jul 2020 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5B0GVk1sEbUASjT4+xgZWsr7v8I6T3nqfWa5obXE9M=;
        b=qzz9d3FLgW9eDvZozb1+QqmuacZbBMJUtVOb+ZnFDUVbj1aiDYQ2dEqp01X8FR0x76
         uc7DYiPf58TvPP7LrFQc3XLcknbdMhMl4WvUEvji8G3t1NAF2S/m6zkZuJH7YYxIL16/
         68SxxElSMctAqhqfcZ7y7OJCyE6g/LEWwAaI/Fixg7By1/6KGSCulpVDtMRdi1uWgvKG
         isZb2a61iGeqsPvijKksv4uOf4lqnbUNEEx/2xony4xlHPYKVsnijadpTKAIaMxG2AZJ
         SZg2yYbeels9SzuzOS7HTlEa6qeoGIgSoE9iJKsB6YoN8igRyZOG+r32j3vJTnE9fzRl
         xXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5B0GVk1sEbUASjT4+xgZWsr7v8I6T3nqfWa5obXE9M=;
        b=E6z7Wsglg7JqCw4WDcLya8DJvG1+iXHMz4ibb3W3W8df6uQkLyqpqKgzkwmu65Gk4z
         cu69AsN9Lr4CMBNa4z4vUrraDDXlEOA94SajHYOKzGj/IrYJDKVxJqxBf4FI4bRz9VBM
         RZRRZSszmLhgRcG5jqLQD/y39BJhb/S6iHMkVrgmInfG2WVVGNrxOcgx/wUOHQ84iyKd
         1D8kqGxNvxUuRTyrGqzF0m8zuFKFxx2Y9FSM0ZJ1ZGaVlsmG6R6z0p+71t0k2/W1/EMe
         MIGWzbsScNxs1s2g67FS/w4JN28GONpxCCl2hgLVCcvhPXMipFQ+URfiXGUEnhbyEU4O
         PJEw==
X-Gm-Message-State: AOAM532M+OmqcRDfbYQwDLMrQccu1JC/MilVd29R/T10DFs/0ubci7qK
        RQsiRNRD6s+yVK97yapWDNg=
X-Google-Smtp-Source: ABdhPJxW1giZd/2EieXhbK29tsVlNOYQs2kZciw/ydObd4eRPAb2i+Inq0D8ck6rN2S6QrVIV3yPIQ==
X-Received: by 2002:a62:7845:: with SMTP id t66mr27743156pfc.5.1595406900728;
        Wed, 22 Jul 2020 01:35:00 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id g13sm5777319pje.29.2020.07.22.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 01:35:00 -0700 (PDT)
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
Subject: [PATCH v3 0/3] block: use generic power management
Date:   Wed, 22 Jul 2020 14:03:32 +0530
Message-Id: <20200722083335.50068-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <ea5881cdfd4d612193feed646ce89f253a36db69.camel@wdc.com>
References: <ea5881cdfd4d612193feed646ce89f253a36db69.camel@wdc.com>
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

v3: v2 needed some changes in commit messages.

Vaibhav Gupta (3):
  mtip32xx: use generic power management
  rsxx: use generic power management
  skd: use generic power management

 drivers/block/mtip32xx/mtip32xx.c | 54 +++++++------------------------
 drivers/block/rsxx/core.c         |  9 ++++--
 drivers/block/skd_main.c          | 30 +++++------------
 3 files changed, 27 insertions(+), 66 deletions(-)

-- 
2.27.0

