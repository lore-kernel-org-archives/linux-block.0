Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A727C433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BF32310E
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 11:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhANL6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhANL6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 06:58:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B29C061573;
        Thu, 14 Jan 2021 03:57:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y12so2958342pji.1;
        Thu, 14 Jan 2021 03:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHUPfjQqKMD93C2nYw1vw4UVeUNBSie9Mh/QCa5nMGg=;
        b=aRuAkVjlBZpQRiP365Rzhp0V18psq+LDAa+b9USHkEOaGZFonZdF3JeTsAfwY/2zjx
         YoHWBwHQ5hvYnXQObLhblU3beZnBG+dRZqGninvvzztV4ib48lmtaLbXANr/RUOuOvl9
         IRGxFlMIkHXZFRzcxzwHA9NDMvMTziNv+K1ICAPQZxrpZKFbKanCzchId8stODFt6TIJ
         1+BDsqJwhDCigyrt2g+QBUXhA27/m8g+VFfrEwYvTRO3SS/rIhwiNelL6gLfpE2iuShC
         v2QvtsUjzK46AQwqJ5uhYf8z10Bct8KhvYEX7t0GsYg1qefC9QxPRaXIIgSKsfzE3wn4
         G97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHUPfjQqKMD93C2nYw1vw4UVeUNBSie9Mh/QCa5nMGg=;
        b=KPJPweLF8F7sUkw1v1ZRycYlfGu7d5eReLY0uxpOhCrvd+Xx7hGMBw+NWLN5WK+aFu
         QnWacbxzLZ/Z4oJXxoaK4M555Y2vc+9Mju+Pht5g5EAAvBoCeyo/9AXFnLuNOnRr3RzW
         IDaNf95xKtxCvTk8z7ngTZm/yz7Hn35lYlEdfcAAbsqmxrxgoy0We6xWvrsy5hCVxCZW
         fgPSezfkjHy4a9VDxcSkhAz4ihO5aVYDGgrdDrH5cerzCYqQZuNJo8oEDTxx2EOELrXW
         OG9qXfiGNWlUB2SnFhNuUvtMnGhCxUr0QedDN7lIUwnZKWMjjUIf1PlQ0uzwtwWsdDPG
         j4Lw==
X-Gm-Message-State: AOAM53154RvW4RZr2pSbQ44T6dRELHIoLTxABgqEXeMS6xo8qWRrleXs
        OAemoUiUE1ba/pYViB1GMvE=
X-Google-Smtp-Source: ABdhPJzeYztrpCXiHywG2ZTAttYRrRp9yNdrdbCC8YIHCmBUWqTvbB9Osshx3R9FbSxrct7Tsmvesw==
X-Received: by 2002:a17:90a:4107:: with SMTP id u7mr4618078pjf.163.1610625449668;
        Thu, 14 Jan 2021 03:57:29 -0800 (PST)
Received: from varodek.localdomain ([223.190.37.127])
        by smtp.gmail.com with ESMTPSA id t4sm5107914pfe.212.2021.01.14.03.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 03:57:29 -0800 (PST)
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
Subject: [PATCH v4 0/3] block: use generic power management
Date:   Thu, 14 Jan 2021 17:24:20 +0530
Message-Id: <20210114115423.52414-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20200722083335.50068-1-vaibhavgupta40@gmail.com>
References: <20200722083335.50068-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
    - Compiler: gcc (GCC) 10.2.0
    - allmodconfig build: make -j$(nproc) W=1 all

v4: patch-set rebased.

Vaibhav Gupta (3):
  mtip32xx: use generic power management
  rsxx: use generic power management
  skd: use generic power management

 drivers/block/mtip32xx/mtip32xx.c | 54 +++++++------------------------
 drivers/block/rsxx/core.c         |  9 ++++--
 drivers/block/skd_main.c          | 30 +++++------------
 3 files changed, 27 insertions(+), 66 deletions(-)

-- 
2.30.0

