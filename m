Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26447C636D7
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBPT0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPT0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 14:26:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBC4AFEF
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 11:26:51 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id t7so1170151ilq.2
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF7xqkWEGWXYZ5g/WDBloEO27/L1B1BR0M13863IeCU=;
        b=mPKe24OBohhhKZTNI6NqsyjUTaxiIyHQSBYt4YQhMBKEIgE753RMPtdN543fPBEND1
         rlDlXJb8/VpOH6woEYTkoGKVnbdvdwXJek2kPB7gzUL4UKE4QINCRQWD/L86Yu3bghSE
         LICBPlbXcCXXA0VlGd8tiNJiRNf5O06dIvl/G33osJ8yp5+A0rNO1wpBpM1oEBOJ3R67
         EF5pLqiavKlvhzPlObh42CpbWluP5PShj0NNBTnoKMqwpTiehZxFSYhljb0LqS030187
         vsaPvY7FPJx6tqkGyTWTfI51BNvCP+IW4H5Ghxd1USsp7hkIKNbSr68piQUpYMwU9cgR
         jQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eF7xqkWEGWXYZ5g/WDBloEO27/L1B1BR0M13863IeCU=;
        b=ULKfv72FdTeot3wU5TWY28Q2g0P3MDQWSDedMCFMdatyaP1TrO9/xlLSm5uXrQdfjR
         zX1a7f88+tU6jyfWbj3IfXqLLQdklRLeeO8bMjp4mxIZZRjvV/s8aSxXbM9zpdpXrEY2
         KgygxKrgm1kbGm1I/2bCNc9N/0JpbdobcgssAZXwC4flYuSU+qznqlMOADPyhZlfKTp4
         FeJBMviDxh9nls1osDPhFmI9/DyUSt971veHOcnaxv2wEFOrujNnr014Rj/OnSWtfX50
         rfWkW2089Bd8mwof0PsYwGmJyrkJ+RaZue780/D5Lzf+uT7zj4iKzNB7I3h2FinjGcjM
         zBSA==
X-Gm-Message-State: AO0yUKXtxU1Wx/VsyLbh2urkDAQC1EEWJk7sbgjdcJ6KTOt2fOptU2DK
        pz63gYamJzZeXB/wF6Ilmx+zfaqfeVu6tOKA
X-Google-Smtp-Source: AK7set+yJ1uFtOTCeeZ1yUv020QTImWK9/nBG/6Y56w887Nn0Gtqw2AfFcwbUirpfvDMxv2D3i66NA==
X-Received: by 2002:a05:6e02:180a:b0:314:1579:be2c with SMTP id a10-20020a056e02180a00b003141579be2cmr5936846ilv.0.1676575610542;
        Thu, 16 Feb 2023 11:26:50 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t3-20020a92ca83000000b00315972e90a2sm176836ilo.64.2023.02.16.11.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 11:26:49 -0800 (PST)
Message-ID: <16738d14-6c97-c344-e096-50f4f6cce0e7@kernel.dk>
Date:   Thu, 16 Feb 2023 12:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.2-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a few NVMe fixes that should go into the 6.2 release, adding a
quirk and fixing two issues introduced in this release:

- NVMe pull request via Christoph:
	- Always return an ERR_PTR from nvme_pci_alloc_dev (Irvin Cote)
	- Add bogus ID quirk for ADATA SX6000PNP (Daniel Wagner)
	- Set the DMA mask earlier (Christoph Hellwig)

Please pull!


The following changes since commit 38c33ece232019c5b18b4d5ec0254807cac06b7c:

  Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2 (2023-02-09 08:12:06 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-02-16

for you to fetch changes up to 9a28b92cc21e8445c25b18e46f41634539938a91:

  Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2 (2023-02-15 13:47:27 -0700)

----------------------------------------------------------------
block-6.2-2023-02-16

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: set the DMA mask earlier

Daniel Wagner (1):
      nvme-pci: add bogus ID quirk for ADATA SX6000PNP

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

Jens Axboe (1):
      Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2

 drivers/nvme/host/pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
Jens Axboe

