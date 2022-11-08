Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AACC4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 17:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiKHRgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKHRgA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 12:36:00 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52613D7B
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 09:35:59 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x16so7825387ilm.5
        for <linux-block@vger.kernel.org>; Tue, 08 Nov 2022 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=;
        b=EWVfAUTumk4AQ08iyW9Q5OaA+9vWPO6YXORW8T5vAzOH6R3K7ePQEkc/AHQzv4NKuL
         axNwPnt9zkKFcnumeuq3Ni1HnW4BX34Gn59FgjBhrGjPTd7VNT02mNylwqxlosNEpljw
         gLj1g5pPGDGSu6B3Cm6i4ai6v4hnqaafLqm+ZgKjB2oZ3rA8N/es+FSCve4w7CPWpPJ/
         hQ4h4K2FlUn0ck3GDKUnxoSEdgFcMavTdrYKR5NbpX6LOqJPIkI1BOtWMGSlsYzuBv7p
         VRAR7d0ny4wxqRYewMATM3IX2ICxnAgla9kFsIz76KsTayT2UWLTnPsofs3xrHEHKeSJ
         BhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=;
        b=Mf9kG3ZvtHF3vTtw32aGEi/tg4XrbjdXPM/HDG7x71ffmW9I4jCpc1Q1Cw8wmWhCIo
         lbO/pQGp7yavK5vL5Df4R1/JSTKv5Gy9yVp3Prv3CtyRvNeeAJQnCWAWkZc8tTNFTb+G
         blLa7PJ+xEq2LLgwrWC4GCBIzTCa7iVZX8IHfQdVxESH6XQ5weKLlbAP+v6MjrWmLDxc
         t8bWPsNgch93Kx75bVevQY5ecKlNr/2XwQ5o1YpFWBDYeRWOBn1qn+ohbBsGvFF7+3Im
         ofuEt9blKYVsSf+RQo3Qitr1sdiDfzUX4bftL6hyWoR+unhvSZtPr/6OYiCCym0grE84
         eXQQ==
X-Gm-Message-State: ACrzQf07k2XT/M98cNmBG85W/Y0wUPMTlGffI59aB7/kohJVmp2qxQsy
        0nCqu2bN0BQdPseIGJNEXgptug==
X-Google-Smtp-Source: AMsMyM45bvy/64lNW4dHL3SZe0PN0KsWFFiszerLfZ0l1x4JN7xNJQy40y5C6TaqXPGbKUXelxVvNA==
X-Received: by 2002:a05:6e02:be3:b0:300:c33d:4ad7 with SMTP id d3-20020a056e020be300b00300c33d4ad7mr22795761ilu.150.1667928958975;
        Tue, 08 Nov 2022 09:35:58 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v14-20020a056e020f8e00b002fa9a1fc421sm4018267ilo.45.2022.11.08.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:35:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Keith Busch <kbusch@kernel.org>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-nvme@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru> <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Message-Id: <166792895795.7601.10122514732945288817.b4-ty@kernel.dk>
Date:   Tue, 08 Nov 2022 10:35:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 7 Nov 2022 23:39:44 +0300, Serge Semin wrote:
> In accordance with [1] the DMA-able memory buffers must be
> cacheline-aligned otherwise the cache writing-back and invalidation
> performed during the mapping may cause the adjacent data being lost. It's
> specifically required for the DMA-noncoherent platforms [2]. Seeing the
> opal_dev.{cmd,resp} buffers are implicitly used for DMAs in the NVME and
> SCSI/SD drivers in framework of the nvme_sec_submit() and sd_sec_submit()
> methods respectively they must be cacheline-aligned to prevent the denoted
> problem. One of the option to guarantee that is to kmalloc the buffers
> [2]. Let's explicitly allocate them then instead of embedding into the
> opal_dev structure instance.
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: kmalloc the cmd/resp buffers
      (no commit info)

Best regards,
-- 
Jens Axboe


