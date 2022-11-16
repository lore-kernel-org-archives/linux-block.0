Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB9C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 18:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiKPSwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiKPSw2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 13:52:28 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63663663FC
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 10:49:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h206so13919896iof.10
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBeqtc5M+tLwfUtRyMfu4WiiuBiwZMRVYN499g+Yfdc=;
        b=wt9vl5qkviMyOCyVwVqPF8c10BRr7xBkyxnMD5w6UMUpBCf+AWlLsJeRcUmJDHraPw
         1n0wfR8iWdYwZ+Odd8h728nOydGXayWiLNU07DK7byPGdg1QrZqxc50Di7ezWO8emCot
         5UN/IRtia4glQE/dSGMzhQ39WURHdZfezHc39S7Naw415r61NNLMRNIgie2fixjKozfl
         6J94kEFW0nMxTC+j/yu6jWyM06W6ZE48VJhCQ4HDgIIOfpDpqrZLeWhWoplKv0Op44Dd
         /hSpzoy/jil83Lc+GHQTdYqycJ+zmduSlMUnCFULTp4cwKHe2PnnjIFd8WuAADF7DKzL
         0T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBeqtc5M+tLwfUtRyMfu4WiiuBiwZMRVYN499g+Yfdc=;
        b=EPMKN7TmOp42OhfbxvJyY/meOoNYnMfRjMm3uAw5NQOfOLjBHaCkmIcbfWMGm0Qn1/
         FjjmVlcwm629ViW1EKIK67rh4qQykkRE18nnrT0KG2MpUHeuvtLreXB3fUIBCIYD4ayc
         f/fDJN9dRlA0AxnC4MUqu5AM9kbjp8Q2BUNKZkp5Pb8Bt5viY4UMD5uvS/4uxElqIcH/
         7VjYAN4Tv+IhMx9NC0OKeAmOSCT5tzbZSoQRxGRvoB10sZBSbaCFFhnAZkyeM+pDymWC
         HHT45rgJm9n+RccMEfQIotfWCEHleOgTx6ed7Vh3fk0DHjJfPDYgcG6UOh+O02YZikWF
         46lQ==
X-Gm-Message-State: ANoB5pn09kOWxzCuFGj4pK3I1ck5DMMfFAMpbhCvsbLvywmSyURw7Dd0
        OlNrl3L4rV1jnhEulil8FjloZ5TUTlZKoA==
X-Google-Smtp-Source: AA0mqf5B9Y8SqTUVpLKT6eSxTGLQYb+Opu/ud1uxi7OkQeoJzGbjpIFowc4W97y5V0Lys1WcTQ6a8w==
X-Received: by 2002:a02:6208:0:b0:376:22d5:a030 with SMTP id d8-20020a026208000000b0037622d5a030mr4392191jac.17.1668624575540;
        Wed, 16 Nov 2022 10:49:35 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m1-20020a0566022ac100b0067b75781af9sm6913174iov.37.2022.11.16.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:49:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221116132035.2192924-1-hch@lst.de>
References: <20221116132035.2192924-1-hch@lst.de>
Subject: Re: [PATCH] block: remove blkdev_writepages
Message-Id: <166862457466.199729.5782233523467662330.b4-ty@kernel.dk>
Date:   Wed, 16 Nov 2022 11:49:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Nov 2022 14:20:35 +0100, Christoph Hellwig wrote:
> While the block device code should switch to implementing
> ->writepages instead of ->writepage eventually, the current
> implementation is entirely pointless as it does the same looping over
> ->writepage as the generic code if no ->writepages is present.
> 
> Remove blkdev_writepages so that we can eventually unexport
> generic_writepages.
> 
> [...]

Applied, thanks!

[1/1] block: remove blkdev_writepages
      commit: 470373e888f494a52f9916bf3eeea41fe819d031

Best regards,
-- 
Jens Axboe


