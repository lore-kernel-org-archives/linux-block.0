Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2558C433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 15:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbhKXPiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbhKXPiG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 10:38:06 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79398C061574
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:34:56 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e8so2858189ilu.9
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=0C370uoMGNSprhARNq5uWnnfCQxZWsbKaAfWfQrrBEM=;
        b=Osc7EqcP7kAsBqX8kMkJ5THlt7vS3EVs1JKS6BngIRXZypfuD/LTF4cSsmGeQZ/6Lv
         150GqD12C9bStRzj8qxWTPsQjg2hEwkCuUTcFgZ5MUW3ESn45b2enRCh7XjHLiOoAk/H
         qH+fOIxcsInScVf0kReOnyygVZhfP9HP0IanyKL2qanu/8pXrE1Owro29JrmWA3UIAzA
         wCPCiIApaDTjxBuPOQ3a+eq6UKs7n258SWQox+mZsUUKhidGBi2H06Z95v6MKUpv4KL1
         RIvsEZQC7wd7ckZW01+ggXoggdQt2hGk6FUlxiMHD9NhcRKjBEPkViecrl4Fl+zcRfgD
         kmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=0C370uoMGNSprhARNq5uWnnfCQxZWsbKaAfWfQrrBEM=;
        b=rpCiDulQl8ou1xzxv/o7xH6GWqxY5iEWPAHNu18ku8DtziD8me1GHQrThFIeFvCxYp
         F2uDfJEPxbP1vN2r/IBrmt1g4VGCqd7gwepuhIErne1QTji4Sv9Eg0n0sNamxP5NjZOh
         SNRP8kq4zTgI710+cZkrUo4CTZUc7p27DWSk6OdmrtaOA61TsumSnv56UCyd8hTp4ryg
         4DLGkQUDmZ6msP7SmyztLI5G26MM4cDf5Qa1/oKyJR8QM8E/mc0dS5a4arwkpbwZZNNQ
         BzG/16fnIQGC1dVakB3Zyzh606vnQUNdONeh9pw7F9XY8I1m0tiW3Id7hX1tG//dVYk7
         uo+A==
X-Gm-Message-State: AOAM531vqQFE3WyUk4+P4tHMXJ0SsUQbZ3jOUKnlwQ3VMQoFLty856BS
        XRb1qPg+3oVxQ95D6E60Jpjz4gUHAdPRhuqV
X-Google-Smtp-Source: ABdhPJxySKcvJwRPsWW8R1AJl8nGN8KuitksAVSHdMKO+xd0QVjUfQ/9cauKGlwrIagwcluAg+ZSTQ==
X-Received: by 2002:a92:d6c7:: with SMTP id z7mr13462226ilp.92.1637768095704;
        Wed, 24 Nov 2021 07:34:55 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l13sm105761ios.49.2021.11.24.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:34:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
In-Reply-To: <20211124013733.347612-1-ebiggers@kernel.org>
References: <20211124013733.347612-1-ebiggers@kernel.org>
Subject: Re: [PATCH] blk-crypto: remove blk_crypto_unregister()
Message-Id: <163776809520.461254.18142955526119989491.b4-ty@kernel.dk>
Date:   Wed, 24 Nov 2021 08:34:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Nov 2021 17:37:33 -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This function is trivial and is only used in one place.  Having this
> function is misleading because it implies that blk_crypto_register()
> needs to be paired with blk_crypto_unregister(), which is not the case.
> Just set disk->queue->crypto_profile to NULL directly.
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: remove blk_crypto_unregister()
      commit: f08fd5d1f9d146428809a7cd61d557df6af56f7b

Best regards,
-- 
Jens Axboe


