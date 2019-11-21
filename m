Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6B3C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D28206D8
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DMu5HLgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKURMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:12:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42492 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKURMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 12:12:00 -0500
Received: by mail-io1-f67.google.com with SMTP id k13so4281653ioa.9
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1cIZwA3AuIjLS4tpGadLzBG5pwl4YtsB/A1sAcKR+4A=;
        b=DMu5HLgLXr5MHtGzBECpQ1azakhXh6JGTxRHT15eZh1chOvs8BiaYILit058YLQGDK
         NZmmxBMB7tJu6+dB66JwQRF4tJJZhVHTOUVyAyaSlUuDlwzCnjKB2j+x5CEWBeVvyZzO
         ELHdJe3N7fNUt0JW6KDPpq91g2hz/iMLDqc2BZFqDGHri7Z8yTL451MHq36BJAYk6Mwj
         hgJhr7aOtJwVTIURvkq1R71veoGrgaa5PIhYe6DP/qzoF/BzQTSq8oZBnARo68UQp7Va
         sN6myTQ+n08ZII+6mPpnbEv4I4HxjUdH8JLPGFinCyqmQkfVnfk3RYs1Kcs3Kbe82fTn
         Uznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1cIZwA3AuIjLS4tpGadLzBG5pwl4YtsB/A1sAcKR+4A=;
        b=m9eVwGxf8mET+ZEXif8OkcAPZN3WE9BVdNE1P+ypEsuB3n1SRfPqjWOGuclq/8hvBP
         mAQv0wXeWDsrVF7kY7eHI8xNAtDEZXMFw2BiMQjUyw6vBfa3L4P8usfChKvDKkh2OAr/
         OFNgHMrt6uOEFneOzg42amxD5rj+kuHxHJkK1xJusMFE93sslv6SGuXD8RlFzfqMxobb
         6z7QV6kMXCKpbVybTTaoc8W+XT7XUcO4wW92zdvw/3/pON6TIxncr2+AucaPm6rIwIXN
         k9qgFyhpwi8rvSHgUPJh0jW4Cw2hVm08nNon87qGWv9j3oDffNPOMstz1PMh4v/NVsgf
         nU7A==
X-Gm-Message-State: APjAAAWNzBVK4o8+90fFhZnbe4mFxNkvM3b3CTd3WddmoG0vw9Djixz1
        WKg/Uj+jUFT4SEinQ7vSq66f4V7vNWfXuA==
X-Google-Smtp-Source: APXvYqxo/WQnh44IDTW7D6ColLyFMMn2PodO5NhCAhK6Lqw/wRVcbjSXPk+5c8EOmGvOz9jhAnebdg==
X-Received: by 2002:a5e:8202:: with SMTP id l2mr8496405iom.207.1574356319593;
        Thu, 21 Nov 2019 09:11:59 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k76sm223456ila.71.2019.11.21.09.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:11:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <7f58df62-263c-3e2f-edb7-63e526c2222e@kernel.dk>
Date:   Thu, 21 Nov 2019 10:11:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus.

Here are the libata changes for 5.5-rc1. Just a few fixes all over the
place, support for the Annapurna SATA controller, and a patchset that
cleans up the error defines and ultimately fixes anissue with sata_mv.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/libata-20191121


----------------------------------------------------------------
Bartosz Golaszewski (1):
      ahci: tegra: use regulator_bulk_set_supply_names()

Colin Ian King (1):
      ata: pata_artop: make arrays static const, makes object smaller

Hanna Hawa (1):
      ahci: Add support for Amazon's Annapurna Labs SATA controller

Jiri Slaby (4):
      ata: Documentation, fix function names
      ata: define AC_ERR_OK
      ata: make qc_prep return ata_completion_errors
      ata: sata_mv, avoid trigerrable BUG_ON

John Garry (1):
      libata: Ensure ata_port probe has completed before detach

Michał Mirosław (1):
      ata_piix: remove open-coded dmi_match(DMI_OEM_STRING)

 Documentation/driver-api/libata.rst | 14 +++++++-------
 drivers/ata/acard-ahci.c            |  6 ++++--
 drivers/ata/ahci.c                  | 13 +++++++++++++
 drivers/ata/ahci_tegra.c            |  6 +++---
 drivers/ata/ata_piix.c              | 14 ++++++--------
 drivers/ata/libahci.c               |  6 ++++--
 drivers/ata/libata-core.c           | 12 ++++++++++--
 drivers/ata/libata-sff.c            | 12 ++++++++----
 drivers/ata/pata_artop.c            |  4 ++--
 drivers/ata/pata_macio.c            |  6 ++++--
 drivers/ata/pata_pxa.c              |  8 +++++---
 drivers/ata/pdc_adma.c              |  7 ++++---
 drivers/ata/sata_fsl.c              |  4 +++-
 drivers/ata/sata_inic162x.c         |  4 +++-
 drivers/ata/sata_mv.c               | 34 ++++++++++++++++++----------------
 drivers/ata/sata_nv.c               | 18 +++++++++++-------
 drivers/ata/sata_promise.c          |  6 ++++--
 drivers/ata/sata_qstor.c            |  8 +++++---
 drivers/ata/sata_rcar.c             |  6 ++++--
 drivers/ata/sata_sil.c              |  8 +++++---
 drivers/ata/sata_sil24.c            |  6 ++++--
 drivers/ata/sata_sx4.c              |  6 ++++--
 include/linux/libata.h              | 13 +++++++------
 23 files changed, 138 insertions(+), 83 deletions(-)

-- 
Jens Axboe

