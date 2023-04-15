Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C1C77B71
	for <linux-block@archiver.kernel.org>; Sat, 15 Apr 2023 03:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDODnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 23:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 23:43:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6095270
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 20:43:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b621b1dabso391424b3a.0
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 20:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681530230; x=1684122230;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FZwsA5lGAAJ6WyZakIZfb86WvlsXSAR4mhCeCsLVgM=;
        b=ZrwL6Owcfnet/9BBFTHVY82v13SgXDk1tX4xPrPGyrlDWnZ82bFVMe0PzUbL9gYG2i
         h1Zzl/zLoUBJbpD86BXeJp8Hub4Ugkx2copgpWiR7h8xNdmu1E5B9zZp78nkhkGzyoNc
         USe7myl6g7HGT36E0UJPVceokAafSvSq60wQ7P0GeMRGQBHcag3Er6tzTFYCg57FnbfK
         Bb3RsDV3nAlhll4DrR3tfzvd6BAUg7ui4kffxTxv1u1zbVwFfBsMioqXe4C7mjCe2t4R
         tj1/OcYaYL/GxZynLr0+SGvKRsoooW3/o6i83qZZ7R6RDvVHV8tr4Q2glhRZs0am1Xty
         4MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681530230; x=1684122230;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1FZwsA5lGAAJ6WyZakIZfb86WvlsXSAR4mhCeCsLVgM=;
        b=SP9st7hop1DYunKVmRuraWwTbCftSKatYySInFZTtL7V6BFHEj77deSyFy82ewxb7k
         jcD8FvxVGJ7Ul0qVbget4yGUXThFJRYVufCRQ2Ttgiu/C+dYFLPlBJCfYcezxEmqpxXy
         w+v79Kle61Xvz0OdDh5Ng0hQKGcTDWHU0T4ezB95WmPm71fGcRVg7aMmqlPyVLa2UQnf
         DKyXTyDtIqPN0bwmyKW2c/Tu2t4TRtPnmpTvcdHs+8Hw6ILQWj2fZNZ84yuUkIVj0zc2
         mftSrxvFMsv82Jx607DlbHiyc6bRwM7Ur8oiGq4v2YDgaY2QrUJWdRPTGezY8xpsVmJy
         fqng==
X-Gm-Message-State: AAQBX9cn4WZ4oMXbHwEsbdOOpKqbV+dCKboJlEUlpInE7JPEpicvUbHc
        +O/0NzL0A4uM5Q7k7UwQVXLkVLWmUZj5VsRYN4U=
X-Google-Smtp-Source: AKy350YzZEnf3env4LRuhlqp3OmKP0I31LZCzuW98YiVs9Wg1eshzha/sdUhsv078iLkOvbG87ZWNQ==
X-Received: by 2002:a05:6a00:310c:b0:624:bf7e:9d8c with SMTP id bi12-20020a056a00310c00b00624bf7e9d8cmr5164785pfb.1.1681530229820;
        Fri, 14 Apr 2023 20:43:49 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78294000000b005921c46cbadsm3832731pfm.99.2023.04.14.20.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 20:43:49 -0700 (PDT)
Message-ID: <9d88e759-5201-82c4-792f-dcb6e29c808a@kernel.dk>
Date:   Fri, 14 Apr 2023 21:43:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.3-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just an NVMe pull request, with a single quirk entry addition. Please
pull!


The following changes since commit 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1:

  block: don't set GD_NEED_PART_SCAN if scan partition failed (2023-04-06 20:41:53 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-04-14

for you to fetch changes up to f7ca1ae32bd89ab035568c63b4443eb55420b423:

  Merge branch 'nvme-6.3' of git://git.infradead.org/nvme into block-6.3 (2023-04-14 06:29:00 -0600)

----------------------------------------------------------------
block-6.3-2023-04-14

----------------------------------------------------------------
Duy Truong (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD

Jens Axboe (1):
      Merge branch 'nvme-6.3' of git://git.infradead.org/nvme into block-6.3

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Jens Axboe

