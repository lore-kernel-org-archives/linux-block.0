Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71380C4332F
	for <linux-block@archiver.kernel.org>; Thu,  5 May 2022 00:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiEEAeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 20:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiEEAeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 20:34:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66654BC0
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 17:30:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t13so2412142pgn.8
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=zdqBAKt425XW5mz7Vokpz9j1pCZvlZkVo2mO0I2Fcjo=;
        b=yFTrVl9cUXdi7ESx9lbxrWEaewScVHkzs/RhHcwrXt8g2IjNGFFLRvqsQvSIS19Ehm
         +GMK2G/IHC2PWHaKDSU3HiTVYkU0r+66n9wwD5ADl6cIcV0iWNwRYaipQ6TeR+Zae2M0
         Ps76cxqNxhlBC4y1bRaRa0nTvwmfG+6Y9dcoxWp0cNEuSvdFvNBzNKBUQ1huQAEFw+a9
         v1KmLKI85KzTI2fib26Yp9RmTtujrpdHbwn/FMVd6hGBbDN5dDB/9Y2Ov8RQFIiuNCC4
         gtJ3uCDJ8oazy1adJUBiLpBuLLEZBBhJw8MlcBUnSLpR7fp6QyKk5qvzU961XIa6X/cD
         95LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=zdqBAKt425XW5mz7Vokpz9j1pCZvlZkVo2mO0I2Fcjo=;
        b=NoKJ2JcW1vYbkn3HwiPXM57/XMMCDe/eyXTd5XjxH3limWP95wUSbcxBNf5fd9+7Rv
         REjpoQcB6zf1nmX3Et32AcoMc8L15PIFA+ro3wpEDu+ufUWnpsKYfF0JrCLmBfsE0aNO
         7lGF/jiZJfhambwMH0m91FMesJRQ7JIInUZG06P4HqPyCsA3EkIa1idskt4gb0+dh7wx
         37Sv9ZpA7+KNyuc2WeXww7b58l63USDvZ0uK9SAWZHEstEwzbBSNdh8qw7lKSmRZEY19
         WhCnicAa+BhAL7LeXTHLkJmeCGZ16iArqfZ5O6YudzUTDUsReZ8VdPzRpbO38BIs84S9
         BqEQ==
X-Gm-Message-State: AOAM531pPDqpFsuAY/IIoF7NXj3HxcIjQed1wD191nrYWuAtQSPP2wRj
        yM1VvdZz8l8Y5Y1US0oUuom2NXwLwqXR2g==
X-Google-Smtp-Source: ABdhPJzrINl6/EGzdAP7NV/BQthbEnYuCXbgzF+Y6DsJpuz64bsY0FPXPNHUfFaHJp5bEPgTHPvVbQ==
X-Received: by 2002:a63:2114:0:b0:3c4:995c:344a with SMTP id h20-20020a632114000000b003c4995c344amr6288139pgh.125.1651710635904;
        Wed, 04 May 2022 17:30:35 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902a5c900b0015e8d4eb2bcsm64799plq.262.2022.05.04.17.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 17:30:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220504143355.568660-1-hch@lst.de>
References: <20220504143355.568660-1-hch@lst.de>
Subject: Re: [PATCH] block: improve the error message from bio_check_eod
Message-Id: <165171063483.26465.1350604595581402063.b4-ty@kernel.dk>
Date:   Wed, 04 May 2022 18:30:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 4 May 2022 07:33:55 -0700, Christoph Hellwig wrote:
> Print the start sector and length separately instead of the combined
> value to help with debugging.
> 
> 

Applied, thanks!

[1/1] block: improve the error message from bio_check_eod
      commit: 069adbac2cd85ae00252da6c5576cbf9b9d9ba6e

Best regards,
-- 
Jens Axboe


