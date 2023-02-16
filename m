Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD1CC64ED8
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 18:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBPSF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBPSF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 13:05:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3F38662
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 10:05:56 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h7so595316ila.7
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CuyPJKMxc6i5zMj33A6V9axEy/k3jz3EOr9qj1i7lA=;
        b=RIyoKPJHmZP7Mq1cNEPwTiXbX1DfSgf3QVJgSuBx3PVJa0aD6bT1eU5asRkhu/usXa
         U8DMtMF5QQ8jq2iAtg4mUVcHLtPt9p1x89H7r5PTBr7exwHlJLboU5KjjZYa0QB4blZS
         fed2uvM2mpqZjEVealS4bVv783VActqk050VdVBTQUhxBRe898SodXr9JlQOzCRUGfH+
         9e0kukuoyx0HAGh2uN8tf9rpwGsN0VJMfxXg0fz1CmMc8l9eNB63HGgNiKmo0Ga4j44W
         PdCv9R+KyjJbDi4+f2IH+kV4NHIp1d7VxVbXnKVvUDS4DE1JSboxYdQBaRBASDKXjiD/
         03GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CuyPJKMxc6i5zMj33A6V9axEy/k3jz3EOr9qj1i7lA=;
        b=SBTuwj8WvRrI/zM4jVgukCVMS0u0m0JwVS/jn8GmptEyhIQW+RBIHfLD0htX63u7DM
         U6d6L954uhW3mVbBasHdj627PO1UYMpGplYcmRX0NEMXZHZBxEw0yOH/6UwG2UU4UW+g
         9knxQTb7mD1jEMOgXUtgPaCZTAVeWhw1LVUy9dSyQafFN0yY4PlCOyDWwNt4QopFeXo/
         7SpXVSiHpciKjM4ouM+nzRgsV0ceVoNSmobaHCLMc9+8e0yGBeunu4mzWdralnhTNXSe
         k3fwwBrK4PD+Oqkexel9l7yt+vgQxQunjBW2Rv/LER6x8NWIntx2C+FjDTjWBj+mAnyF
         VJUg==
X-Gm-Message-State: AO0yUKXkDqT/VccdBtGYe6RFtD8LA77wAdZLht03bTmujCPOvApCSazc
        Uymzhe3xGAxaY45Lwp04aGEAdwIlhIpvLEHC
X-Google-Smtp-Source: AK7set/QvqbJkDvIC9d0IHYSNyYQSo7FNa/M0GKVdKSIDsc9ACd8nRASCrJYQqvN2QHICyFhH6wtMA==
X-Received: by 2002:a05:6e02:d4c:b0:315:5436:a632 with SMTP id h12-20020a056e020d4c00b003155436a632mr4192741ilj.2.1676570755289;
        Thu, 16 Feb 2023 10:05:55 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x12-20020a92d30c000000b0031406a0e1c0sm613738ila.57.2023.02.16.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:05:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>
In-Reply-To: <20230215171801.21062-1-martin.petersen@oracle.com>
References: <20230215171801.21062-1-martin.petersen@oracle.com>
Subject: Re: [PATCH] block: bio-integrity: Copy flags when
 bio_integrity_payload is cloned
Message-Id: <167657075439.383926.13107161520582855001.b4-ty@kernel.dk>
Date:   Thu, 16 Feb 2023 11:05:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 15 Feb 2023 12:18:01 -0500, Martin K. Petersen wrote:
> Make sure to copy the flags when a bio_integrity_payload is cloned.
> Otherwise per-I/O properties such as IP checksum flag will not be
> passed down to the HBA driver. Since the integrity buffer is owned by
> the original bio, the BIP_BLOCK_INTEGRITY flag needs to be masked off
> to avoid a double free in the completion path.
> 
> 
> [...]

Applied, thanks!

[1/1] block: bio-integrity: Copy flags when bio_integrity_payload is cloned
      commit: b6a4bdcda430e3ca43bbb9cb1d4d4d34ebe15c40

Best regards,
-- 
Jens Axboe



