Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A5C433EF
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 12:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiE1MU4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiE1MUz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 08:20:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B231DA53
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:20:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x12so6121311pgj.7
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=DGwAaujp7RjoQXFFcLFSo7q3N+wXOBi8yMEvirZAsoI=;
        b=aPAFsB2WRsqFdBzaG4yjAsgHO0SIVQSGlAsCBkMBFxRI6Vuxh+UmCDz+JaTYc15g/b
         iCqSCPauy64eXxeZdpe49YsVaAEMO8X+X/sRDNcdtLO56lyj5arHDrplaLfkWtgyE8+g
         676DmwJw5HGSWe1xD8VfGLfB6nF//v+kLzsOR60iOV97t5wMtfVEhGJPYcbMBupTZ+i5
         K1bnZcHG+j69ft3yBfsKGQcttyUPlh2MsczCHEnFXYBixlsbgklreF38zvuA7mWPPRwR
         bpocX9i/PCsqNS8dh9HXvPh9xt//gxkQDflkaCFqjNEXGmBiJoOgcgIivyqM6fQFZCfY
         il+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=DGwAaujp7RjoQXFFcLFSo7q3N+wXOBi8yMEvirZAsoI=;
        b=cJ9x/BDdxGG7EpYHFgAqDtWpA1g1vmIMb0KaO0He4mBhvGIv/Ygg002P0sFesbYCKw
         sj0eyaU8yNwS9clsviFZKD/R1MjAaKPJCkyHmUVlOOzvB/1ir4SOGir2wU7XmPTvGGpe
         5b/14QrEDvnPf1Jky1NAnoHriU2e9m7ZX+1STKYyTdp/FPZn1ZwJPwHRMDaP05ApII/f
         v8r/CsSB0s1xTQnqCKqptlF6m6L95LOel53ldUE1ToNy8TZjroeO1XtT85Ju2gLFFdSi
         GBMeZvv6KLmSTLTU4dSeZFRIvZ7wpsuHG7SMEAw7UvcG5scuBQ3FnNsZ+jfg0lEjtHvs
         4ckw==
X-Gm-Message-State: AOAM5322B7nWI9ni4Rjk0TBq98ASWi3q93vbivhQ4ZKQ7ADiWjn6vuVA
        /h1kkYrhfS/rAOn+Otrwqmx/seRFgKJcKA==
X-Google-Smtp-Source: ABdhPJx2ZWKQyyO99NrJObMxTgeLx+QbDoRTMWfEev7Xd2qsQ0/qKjUwsQjiPPdwWn3zLlqnWgNHng==
X-Received: by 2002:a63:87c1:0:b0:3fb:9d17:72ed with SMTP id i184-20020a6387c1000000b003fb9d1772edmr8012315pge.597.1653740453468;
        Sat, 28 May 2022 05:20:53 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b0015e8d4eb21dsm5491045plc.103.2022.05.28.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 05:20:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220523124302.526186-1-hch@lst.de>
References: <20220523124302.526186-1-hch@lst.de>
Subject: Re: [PATCH] block: use bio_queue_enter instead of blk_queue_enter in bio_poll
Message-Id: <165374045268.753993.18145252150496233892.b4-ty@kernel.dk>
Date:   Sat, 28 May 2022 06:20:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 23 May 2022 14:43:02 +0200, Christoph Hellwig wrote:
> We want to have a valid live gendisk to call ->poll and not just a
> request_queue, so call the right helper.
> 
> 

Applied, thanks!

[1/1] block: use bio_queue_enter instead of blk_queue_enter in bio_poll
      (no commit info)

Best regards,
-- 
Jens Axboe


