Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99918C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 18:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiC3SxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350815AbiC3SxS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 14:53:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F53B553
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 11:51:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 9so22727916iou.5
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=y92bvKVGil+XZIjxQXyncjq3AMwQmOj/Se4/L6WvBo8=;
        b=3gCw8s3HHskcb+LSDXXaVbHpv9SbKZTlAR4hi2sgsDZPkhmmD3MP+bFWyNS9vzUEqN
         vBvc0mVIqmaQaAhypqdgmXbjEszkwApa8aFt5fidnXgUCeM/kc9nl6Zb0aqEjM9VaOug
         yyYB6T369Gdp264crOjKNwsWa1cm48eqBCXI66ZjvPE1mfmN7ZGKGwOcNLqHq9IP1zT3
         r5IAp+/gSW8FEkrYJE2BH6pg5InDhNWpm5Q70GJoi8P/MDyl5zcrNKKlkj8bS6JpDlea
         vYfHoIRmwqlua69ryfDxyLkXCp1d0eQna4jVUw4V4CJ+xBaqGhZ+rDtNR4qjdN97MumR
         Ul9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=y92bvKVGil+XZIjxQXyncjq3AMwQmOj/Se4/L6WvBo8=;
        b=EgGeZ8kyOGkki8kcwkD795fP7t6HK13Z399QMLcyulsncV/RGWL6pQU2WmpWKpTO9R
         khqhmWqSvDs4/QGkzLpO4U1Ism8pySZ2ikw8cqbxF5BMcKfK8LdFeaNSx9FdsFZujQyW
         JTPg8czDZKfOAaqNsVDPFE8Yy5SCX2E8OL1CQv2HdAoBtsJDl4Qedrz1NBVG+Tm3ZLWg
         R6kK8pJb1rRbx/YJUTbPt5ITTzAEl+s3phFCs26gVO92Iw6UvzXbLEuCok9/DXbaN6R0
         3zoRJ3drdChwQyS4vCBlRTsdFEsq3/lY96S+83aSZqRAd6oKb/lNX6o6rOdNPXFdhdFt
         AvjA==
X-Gm-Message-State: AOAM53333LSHLW4tibsRZ0X5ruPUP9t5f2bDDjNUZpL2P8JMy5ir5Zte
        yl4UB0EpRaU4OZ3FnG4Pw1zE3YedwtiO/A/A
X-Google-Smtp-Source: ABdhPJxFa1K1f4C5BONxN28/ytYaG07W6F2EgJyQSyUkT/eiqQ9cyCL99l6RfDPPlj/FGN6oO03b9g==
X-Received: by 2002:a02:7050:0:b0:321:440c:5e11 with SMTP id f77-20020a027050000000b00321440c5e11mr680586jac.35.1648666292621;
        Wed, 30 Mar 2022 11:51:32 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z17-20020a92da11000000b002c83987c2ffsm10383622ilm.76.2022.03.30.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:51:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     hch@lst.de, linux-block@vger.kernel.org, dm-devel@redhat.com,
        ming.lei@redhat.com
In-Reply-To: <20220324203526.62306-1-snitzer@kernel.org>
References: <20220324203526.62306-1-snitzer@kernel.org>
Subject: Re: (subset) [PATCH v3 0/3] block/dm: use BIOSET_PERCPU_CACHE from bio_alloc_bioset
Message-Id: <164866629201.257072.14870349731518355925.b4-ty@kernel.dk>
Date:   Wed, 30 Mar 2022 12:51:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 24 Mar 2022 16:35:23 -0400, Mike Snitzer wrote:
> This v3 is a rebase of the previous v2 series ontop of the revised v2
> patch that Christoph provided.
> 
> Linus hasn't pulled the for-5.18/dm-changes branch yet, so the 3rd DM
> patch cannot be applied yet.  But feel free to pickup the first 2
> block patches for 5.19 and I'll rebase dm-5.19 on block accordingly.
> 
> [...]

Applied, thanks!

[1/3] block: allow using the per-cpu bio cache from bio_alloc_bioset
      commit: a147e4805855e34f8e1027b88baf59a7f7c8b8d3
[2/3] block: allow use of per-cpu bio alloc cache by block drivers
      commit: e866e4dbad251b4dd1e134c295afd862333864bc

Best regards,
-- 
Jens Axboe


