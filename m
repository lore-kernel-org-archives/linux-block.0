Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE558C606D1
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 21:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5A2173E
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0PeOKZaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfGHVXy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:23:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33111 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbfGHVXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 17:23:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so8904275plo.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PoxllnVt3pPgDGv5vvBztSod3EQaUuWxXFtNSALxPTo=;
        b=0PeOKZaavrGoWWUvQcGZeJJeWTZkp5kJcR/wqvX7pXkUKdbRxKkf4BXH4wayY1nvJZ
         dD9Oa/bWvGFOYMS013OQ8gG4ohJQnk9fck6UoYq3EGe6hB01gqt4JI/Ej+JAI8Zhs+mE
         oJU3BIQDz5NS5Rq+ZUlOCk+vBGTFYutx46aziXc59GgElSZyJnqpo3RWQHVV5dzPhOou
         WMeYj60gno9QzX7668dL0QFDqalSy0oVAWDOkGVFFNAcHvLzVUVIzlLnZsxhwFaK51se
         0Dc8iOd5DQgM4if9gfv+ZXrArjGcAgwqiNlRhtL6kIjjAAs9KHVxEKj+o81xPhWPrHjW
         7zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PoxllnVt3pPgDGv5vvBztSod3EQaUuWxXFtNSALxPTo=;
        b=I9QdaIdPF69l0ni6m8sBy135HQasg8in3fQGz1A3cg7+jHshk5vqA19vLlSDeZAdnE
         ELKLD7kOJsGULOfgDefeuT9ex+XZe8TerR02N59C4dZ4K5rmeXX1kuloFSK0GXHmz419
         ZUO1jnrhCesVfuKbIRaWyJcu6cTzEy41A0VdpxvIZIOit9KMqdj8KHqgSRLuEFpIfY+7
         EMfD/TxOgbo7Pqvc2Nzh9O+Gb3wIFSKGR3/GTB32h1friCWIPmcQYW/qn+/BKoTv6V4q
         O+XUmmV5UQ7OFWc+ntN2k41H4gb+Hx9ZOJOZ4FA+P/c4pVSXLJVAIgJCYNvz2iITMfjx
         u17g==
X-Gm-Message-State: APjAAAVRQ7sKoqw1C7raE7jj5lEHsuf1Dcr2+TUQrhyTOCvcvem+Wwll
        NxxoNi/lAdUazswkRWsmdvVHog==
X-Google-Smtp-Source: APXvYqzVxtfrXfqAwIsQbB4s8uw0bjDZp8D6dA6aihUAS2/IM+DgRKWcmfFz7EeylWzHoTt/ztUlqw==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr27130170plm.334.1562621033797;
        Mon, 08 Jul 2019 14:23:53 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1134::10d5? ([2620:10d:c090:180::1:5742])
        by smtp.gmail.com with ESMTPSA id b24sm17485723pfd.98.2019.07.08.14.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 14:23:52 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.3-rc
Message-ID: <ad0ffbb9-d38c-fc3a-1963-ed1bd12437db@kernel.dk>
Date:   Mon, 8 Jul 2019 15:23:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

These are the changes that are reviewed, tested, and queued up for this
merge window. This pull request contains:

- Removal of redundant memset after dmam_alloc_coherent (Fuqian)

- Expand blacklist check for ST1000LM024, making it independent of
  firmware version (Hans)

- Request sense fix (Tejun)

- ahci_sunxi FIFO fix (Uenal)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.3/libata-20190708


----------------------------------------------------------------
Fuqian Huang (6):
      ata: acard-ahci: Remove call to memset after dmam_alloc_coherent
      ata: libahci: Remove call to memset after dmam_alloc_coherent
      ata: pdc_adma: Remove call to memset after dmam_alloc_coherent
      ata: sata_nv: Remove call to memset after dmam_alloc_coherent
      ata:sata_qstor: Remove call to memset after dmam_alloc_coherent
      ata: sata_sil24: Remove call to memset after dmam_alloc_coherent

Hans de Goede (1):
      libata: Drop firmware version check from the ST1000LM024 quirk

Tejun Heo (1):
      libata: don't request sense data on !ZAC ATA devices

Uenal Mutlu (1):
      drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA TX/RX FIFOs

 drivers/ata/acard-ahci.c  |  1 -
 drivers/ata/ahci_sunxi.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/ata/libahci.c     |  1 -
 drivers/ata/libata-core.c |  4 +---
 drivers/ata/libata-eh.c   |  8 +++++---
 drivers/ata/pdc_adma.c    |  1 -
 drivers/ata/sata_nv.c     |  2 --
 drivers/ata/sata_qstor.c  |  1 -
 drivers/ata/sata_sil24.c  |  1 -
 9 files changed, 51 insertions(+), 15 deletions(-)

-- 
Jens Axboe

