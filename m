Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB36C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E74161026
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 17:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhD0RBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbhD0RAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 13:00:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7EC061756
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 10:00:10 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a11so7911976ioo.0
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1NzrBQsJWF4WoHy4tHLEbqAl0M9aCcHHmWxZlSiVLu8=;
        b=Lh+N34dFUpS47izy71VVaSm96koFb8G2k6dpWK77gjDRf7vUha8F4XoEjeMSqyISeB
         msu4uJKQAtY6fhX8Ogp1CutoiElPKp5My9vFUZc0N61LAj+cN0kqtbQ03B9n+oWhItDX
         4+g0aP76wKEP3T7+dLd0kv0nquLNhdQPkdh7jYQ8+8C8hgPothIWZZa1l2hVqKMgCF+W
         UTwbIv4Yhpbl85W2x+maXarVK9DcWktQMLvTcbEHct5GA9dIu4z4wCaOza0Sp+HRTbDf
         kDoAE181JHpuk2fOc/SSIkFKS6S2ZzeTvba6VCSbFVmT73pF8ZvOWxL3J7AFoVv3mM79
         WUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1NzrBQsJWF4WoHy4tHLEbqAl0M9aCcHHmWxZlSiVLu8=;
        b=pDWQQs3m5PTymj4E236R4m5BtsmfKpodIPwGgxuBR6IEWavBQUD0whHSHz5B1PQVd4
         U04RU9UaXUKN8r+8Ig/lZ1/0KA3cgeaUv6mi2bFetbP13Eoc/aFrNl1IJr55Y7Uq8DUn
         ++vZrVVEbU340/QuyiAXDR9v5jEkIQzTZuETEtv3PMcryNfN/NoJhzqSr7yVtgpSBWyu
         4kv2lWn9oaJb1mcK4koEJINZ9EHdB66KMzDrSw37JHJ+CUQCjzfZQ4N+U18K8NSfrRav
         r5dniZuvQiHU53x5p9lwX+T1QSPxb+U9BbbSu7hDmUYDAHosaN+uAFX/G7UGJfyqU+r2
         qeiA==
X-Gm-Message-State: AOAM5328furVRsjCP46Ah+H4y3gSLflNfzFEviZWUbYcQyk1YDIUmoua
        QoBRiAAgvpt9Q9aAx8xhoOqoqQ==
X-Google-Smtp-Source: ABdhPJxGYmPJl1ni7V1tdgV+rYFyoM+flvMt6PvRifFx915XCT4Pw0orBm93J7V6/LY0W8DHnqsS1A==
X-Received: by 2002:a6b:e903:: with SMTP id u3mr20258457iof.161.1619542809899;
        Tue, 27 Apr 2021 10:00:09 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n4sm1618086ilm.39.2021.04.27.10.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 10:00:09 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.13-rc
Message-ID: <7a48da22-ec0b-f22a-bc0d-4ad76f712ef0@kernel.dk>
Date:   Tue, 27 Apr 2021 11:00:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Mostly cleanups this time, but also a few additions:

- kernel-doc cleanups and sanitization (Lee)

- Spelling fix (Bhaskar)

- Fix ata_qc_from_tag() return value check in dwc_460ex (Dinghao)

- Fall-through warning fix (Gustavo)

- IRQ registration fixes (Sergey)

- Add AHCI support for Tegra186 (Sowjanya)

- Add xiling phy support for AHCI (Piyush)

- SXS disable fix for AHCI for Hisilicon Kunpeng920 (Xingui)

- pata legacy probe mask support (Maciej)

Please pull!


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.13/libata-2021-04-27

for you to fetch changes up to e06abcc68cb555377efd5aa781c014d3d68498b6:

  libata: Fix fall-through warnings for Clang (2021-04-20 14:23:17 -0600)

----------------------------------------------------------------
for-5.13/libata-2021-04-27

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      ata: Trivial spelling fixes in the file pata_ns87415.c

Dinghao Liu (1):
      sata_dwc_460ex: Fix missing check in sata_dwc_isr

Gustavo A. R. Silva (1):
      libata: Fix fall-through warnings for Clang

Junlin Yang (1):
      pata_ipx4xx_cf: Fix unsigned comparison with less than zero

Lee Jones (35):
      ata: libata-transport: Fix some potential doc-rot issues
      ata: libata-sata: Fix function names in header comments
      ata: libata-pmp: Fix misspelling of 'val'
      ata: pata_ali: Repair some misnamed kernel-doc issues
      ata: pata_artop: Fix a function name and parameter description
      ata: pata_amd: Remove superfluous, add missing and fix broken params
      ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s 'mask' param
      ata: pata_hpt37x: Fix some function misnaming and missing param issues
      ata: ahci_xgene: Fix incorrect naming of 'xgene_ahci_handle_broken_edge_irq()'s 'host' param
      ata: sata_mv: Fix worthy headers and demote others
      ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
      ata: pata_amd: Fix incorrectly named function in the header
      ata: pata_artop: Repair possible copy/paste issue in 'artop_6210_qc_defer()'s header
      ata: pata_atiixp: Fix a function name and supply description for 'pio'
      ata: pata_cs5520: Add a couple of missing param descriptions
      ata: pata_hpt3x2n: Fix possible doc-rotted function name
      ata: pata_marvell: Fix incorrectly documented function parameter
      ata: pata_jmicron: Fix incorrectly documented function parameter
      ata: pata_optidma: Fix a function misnaming, a formatting issue and a missing description
      ata: pata_pdc2027x: Fix some incorrect function names and parameter docs
      ata: pata_pdc202xx_old: Fix some incorrectly named functions
      ata: pata_sil680: Add some missing function parameter docs
      ata: pata_sis: Remove superfluous param description and supply another
      ata: pata_triflex: Repair some misnamed functions and fix some param descriptions
      ata: pata_it821x: Fix possible doc-rotted function names
      ata: pata_via: Fix a kernel-doc formatting issue
      ata: pata_piccolo: 'ata_tosh_init()' is misnamed in its header
      ata: pata_sl82c105: Fix potential doc-rot
      ata: pata_opti: Fix spelling issue of 'val' in 'opti_write_reg()'
      ata: ata_generic: Fix misspelling of 'ata_generic_init_one()'
      ata: pata_legacy: Repair a couple kernel-doc problems
      ata: pata_cs5530: Fix misspelling of 'cs5530_init_one()'s 'pdev' param
      ata: sata_mv: Fix misnaming of 'mv_bmdma_stop()'
      ata: libata-acpi: Fix function name and provide description for 'prev_gtf'
      ata: pata_acpi: Fix some incorrect function param descriptions

Maciej W. Rozycki (3):
      pata_legacy: Properly document module parameters
      pata_platform: Document `pio_mask' module parameter
      pata_legacy: Add `probe_mask' parameter like with ide-generic

Piyush Mehta (3):
      dt-bindings: ata: ahci: ceva: Update documentation for CEVA Controller
      ata: ahci: ceva: Update the driver to support xilinx GT phy
      ata: ahci: ceva: Updated code by using dev_err_probe()

Sergey Shtylyov (4):
      pata_arasan_cf: fix IRQ check
      pata_ipx4xx_cf: fix IRQ check
      sata_mv: add IRQ checks
      ata: libahci_platform: fix IRQ check

Sowjanya Komatineni (4):
      dt-bindings: ata: tegra: Convert binding documentation to YAML
      dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
      ata: ahci_tegra: Add AHCI support for Tegra186
      ata: ahci_tegra: call tegra_powergate_power_off only when PM domain is not present

Xingui Yang (1):
      ata: ahci: Disable SXS for Hisilicon Kunpeng920

 Documentation/admin-guide/kernel-parameters.txt    |  90 +++++++++++
 .../devicetree/bindings/ata/ahci-ceva.txt          |   4 +
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 176 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
 drivers/ata/ahci.c                                 |   5 +
 drivers/ata/ahci.h                                 |   1 +
 drivers/ata/ahci_ceva.c                            |  41 ++++-
 drivers/ata/ahci_tegra.c                           |  66 ++++++--
 drivers/ata/ahci_xgene.c                           |   2 +-
 drivers/ata/ata_generic.c                          |   2 +-
 drivers/ata/libahci.c                              |   5 +
 drivers/ata/libahci_platform.c                     |   4 +-
 drivers/ata/libata-acpi.c                          |   3 +-
 drivers/ata/libata-eh.c                            |   1 +
 drivers/ata/libata-pmp.c                           |   2 +-
 drivers/ata/libata-sata.c                          |   4 +-
 drivers/ata/libata-transport.c                     |   6 +-
 drivers/ata/pata_acpi.c                            |   6 +-
 drivers/ata/pata_ali.c                             |   6 +-
 drivers/ata/pata_amd.c                             |   6 +-
 drivers/ata/pata_arasan_cf.c                       |  15 +-
 drivers/ata/pata_artop.c                           |   4 +-
 drivers/ata/pata_atiixp.c                          |   3 +-
 drivers/ata/pata_cs5520.c                          |   2 +
 drivers/ata/pata_cs5530.c                          |   2 +-
 drivers/ata/pata_hpt366.c                          |   1 +
 drivers/ata/pata_hpt37x.c                          |   6 +-
 drivers/ata/pata_hpt3x2n.c                         |   2 +-
 drivers/ata/pata_it821x.c                          |   4 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   8 +-
 drivers/ata/pata_jmicron.c                         |   2 +-
 drivers/ata/pata_legacy.c                          | 106 ++++++++-----
 drivers/ata/pata_marvell.c                         |   2 +-
 drivers/ata/pata_ns87415.c                         |   4 +-
 drivers/ata/pata_opti.c                            |   2 +-
 drivers/ata/pata_optidma.c                         |   5 +-
 drivers/ata/pata_pdc2027x.c                        |  10 +-
 drivers/ata/pata_pdc202xx_old.c                    |   4 +-
 drivers/ata/pata_piccolo.c                         |   2 +-
 drivers/ata/pata_platform.c                        |   4 +-
 drivers/ata/pata_sil680.c                          |   2 +
 drivers/ata/pata_sis.c                             |   2 +-
 drivers/ata/pata_sl82c105.c                        |   2 +-
 drivers/ata/pata_triflex.c                         |   7 +-
 drivers/ata/pata_via.c                             |   2 +-
 drivers/ata/sata_dwc_460ex.c                       |  10 ++
 drivers/ata/sata_mv.c                              |  18 ++-
 47 files changed, 538 insertions(+), 167 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

-- 
Jens Axboe

