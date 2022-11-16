Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A670C43217
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 22:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKPW63 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiKPW61 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 17:58:27 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9C21A0
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:58:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 62so288196pgb.13
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JenFovSTQN9+wzGd6rk1pX/UQFf/Esi4jnYBpJTyW6k=;
        b=a3CnQCTY+sOglLWewC6KfAkG2nzYIG/EJ4k79vRsm6gRAzlGhXRfUT9qNb1vyM3FzT
         30OshguCOphBFprvSMYJyOkzvcbRv+v71kRXSZYLM0qwlrYUQZ1SM6DUVZYfAgI9A8S/
         95moTeo/mFgPULYyOPTSnceC6DvVnZlguf1Aapd5cxVmOznzHik7qVBYsImICLm5zVcd
         MQe/KLaeCdftFBKoQzlIZSDeA65sKB9EpvWBiXFJdN4/tjhvyNLeTQXJhH811Nh9iFWb
         G8kRy9SdAfEJyXkpbh7hLoPPczukHQhQH5N0cTZYhxuB2nLgja2wyo+RAT4TbWXK+Ekx
         rUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JenFovSTQN9+wzGd6rk1pX/UQFf/Esi4jnYBpJTyW6k=;
        b=FNtZg+SY5IvdyebIRoY1Nu3svbI0jsX68oa3P4GfLbu942ut36TtOMaL0hPd36IuWx
         /dEI9jeOFbZPS7I5rg2WTznxR2dAggvshi4FiMGEX21NqmjqjgIr2gAN4fSmvNjZ9fA2
         ZfCzrcd6ejogkNbF6ewU+dJUpAl18ITXDpxHfgoJssEBzVLU3Rsj1qHJgwS/TqiPHPQ7
         rRU55Eo2qFFXVCGPPTZiU0XfxYJtlqTlcLueRen4Q5JRNoIKNaqslmidHY1i6MmrCPti
         VI5yptkiFecJbqnz4dxNMEXLWY7DS6cSfrLVn4OVTtifk8KLAafMOlqDKckVKueb1yT+
         BMvQ==
X-Gm-Message-State: ANoB5pncFIRC9w8Q4f3FEL3fAM6AMZo3v4rBRKt/EEHoOvgYBZtgkagx
        FnJe+vpkcEmxj2+Zt/YaDKmriXANZvfPsQ==
X-Google-Smtp-Source: AA0mqf4tuHJxwwqe1b7MIqPh5fOVIaMq+WItB05J/gZuYEoZcL8yGsMlVDLBnsm67KcdNeRNlET/sg==
X-Received: by 2002:a05:6a00:440b:b0:56b:b53f:e887 with SMTP id br11-20020a056a00440b00b0056bb53fe887mr290248pfb.3.1668639504962;
        Wed, 16 Nov 2022 14:58:24 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0018725c2fc46sm12891214plx.303.2022.11.16.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:58:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Keith Busch <kbusch@meta.com>
Cc:     Keith Busch <kbusch@kernel.org>, mpatocka@redhat.com,
        ebiggers@kernel.org, stefanha@redhat.com, me@demsh.org
In-Reply-To: <20221110184501.2451620-1-kbusch@meta.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
Subject: Re: [PATCHv2 0/5] fix direct io device mapper errors
Message-Id: <166863950373.9526.11859127241881103074.b4-ty@kernel.dk>
Date:   Wed, 16 Nov 2022 15:58:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 10 Nov 2022 10:44:56 -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The 6.0 kernel made some changes to the direct io interface to allow
> offsets in user addresses. This based on the hardware's capabilities
> reported in the request_queue's dma_alignment attribute.
> 
> dm-crypt, -log-writes and -integrity require direct io be aligned to the
> block size. Since it was only ever using the default 511 dma mask, this
> requirement may fail if formatted to something larger, like 4k, which
> will result in unexpected behavior with direct-io.
> 
> [...]

Applied, thanks!

[1/5] block: make dma_alignment a stacking queue_limit
      commit: c964d62f5cab7b43dd0534f22a96eab386c6ec5d
[2/5] dm-crypt: provide dma_alignment limit in io_hints
      commit: 86e4d3e8d1838ca88fb9267e669c36f6c8f7c6cd
[3/5] block: make blk_set_default_limits() private
      commit: b3228254bb6e91e57f920227f72a1a7d81925d81
[4/5] dm-integrity: set dma_alignment limit in io_hints
      commit: 29aa778bb66795e6a78b1c99beadc83887827868
[5/5] dm-log-writes: set dma_alignment limit in io_hints
      commit: 50a893359cd2643ee1afc96eedc9e7084cab49fa

Best regards,
-- 
Jens Axboe


