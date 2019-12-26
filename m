Return-Path: <SRS0=USsu=2Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12692C2D0DC
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 18:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D6020828
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 18:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0tE0Ffhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLZSTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:19:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43512 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLZSTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Dec 2019 13:19:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so13183071pga.10
        for <linux-block@vger.kernel.org>; Thu, 26 Dec 2019 10:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=08B4u/S15ecKYI/XSdrazPr5ZmzptAt9X1vFOPdWkjY=;
        b=0tE0Ffhs4qKFi382ulWtwm8qM6dpv8KqM1tjXlvHZNvRDT2GOBCSwatuVJJmzKxI1B
         xu1l7EIAZUJ6SWT4on+RYzojKrnPfgznknnQ3GzqUYseE6ojamUF41pAhHk/3XZTQ3+F
         mFzG/RZULFRcqClGX7vhLObVe/Os2OwHFGrhPD9m2x7UStDFurwMELxFZnqEhxA1GyNt
         RWoeAyiuFvVwprVEDsgN544MYxAdM9bQJT1XSEJ8jDtJNIhgGkK7zTuaybBJUEnPdgJt
         1/fevj5ptrm9//IVz1Y2SyAmEbtVcWpwEFAYCly9qVq0kageCoRygE6FJBPM8TocZ10f
         FgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=08B4u/S15ecKYI/XSdrazPr5ZmzptAt9X1vFOPdWkjY=;
        b=Vvy7kxvFmK8oQaSNOYnSDpNZCP8FVijBlSa+WkicykcjC8Ouhkr+K32vvnGs/xo++3
         x8yx5fBIl70Id44XWIggzZ17H7KO3SvOEltctSTGWsIEAyUeVXfXmrQSRiiYSmw2ExvR
         1BCXDi40GliqO4Xc/YkxpURZRsYTijOTjxocna7+j7NkU4wszQNNmL6cZlQ49QC8QU2e
         jGS2YEBlVoOXFBYQMZgz9llSq9HP2Ct4+DalvwwRNfUSOwMq2V66/TG5f9oyEobCLCiy
         5YtOlm4wzBC924jC/SLZofFZuCNbfIU0EYYJN86zygMPitldP/zyNjWNia0PWJ05KDRx
         jdbg==
X-Gm-Message-State: APjAAAU6uPD8+jY6X5qOhdV0UjIcs+OueXipoECl+HUMu0b+tCwOeyaA
        o/Y7DXHZPE+tMG3Pw+65oWpgUQTGwSyRsQ==
X-Google-Smtp-Source: APXvYqzgbI5Fm+kDBgTCy0vN0nhJvVlPfQbwdcmLFHqKjZ+3e/qjJAfQmNox1buvt/A1qZDd71XNaQ==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr51094655pgl.212.1577384344062;
        Thu, 26 Dec 2019 10:19:04 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z13sm11495368pjz.15.2019.12.26.10.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 10:19:03 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.5-rc4
Message-ID: <465cf62f-2e8e-de03-fd02-f82e756db91c@kernel.dk>
Date:   Thu, 26 Dec 2019 11:19:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Two things in this pull request:

- First half of a series that fixes ahci_brcm, also marked for stable.
  The other part of the series is going into 5.6 (Florian)

- sata_nv regression fix that is also marked for stable (Sascha)

Please pull!


  git://git.kernel.dk/linux-block.git tags/libata-5.5-20191226


----------------------------------------------------------------
Florian Fainelli (4):
      ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
      ata: ahci_brcm: Fix AHCI resources management
      ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE
      ata: ahci_brcm: Add missing clock management during recovery

Sascha Hauer (1):
      libata: Fix retrieving of active qcs

 drivers/ata/ahci_brcm.c        | 133 +++++++++++++++++++++++++++++------------
 drivers/ata/libahci_platform.c |   6 +-
 drivers/ata/libata-core.c      |  24 ++++++++
 drivers/ata/sata_fsl.c         |   2 +-
 drivers/ata/sata_mv.c          |   2 +-
 drivers/ata/sata_nv.c          |   2 +-
 include/linux/ahci_platform.h  |   2 +
 include/linux/libata.h         |   1 +
 8 files changed, 128 insertions(+), 44 deletions(-)

-- 
Jens Axboe

