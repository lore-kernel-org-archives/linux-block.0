Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC15EB8FB3
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 13:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjIFNdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjIFNdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 09:33:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01510C7
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 06:33:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68e38caa352so13062b3a.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2023 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694007198; x=1694611998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkS4dwu10x1+vjWXsbcfHKESE3PkULXw44CJgNTiRms=;
        b=WVDUKCPrebb03IZhMIE6XBoODrfiqlC8amEaYhSpEWNcwCFC2rOY4Udt8VL3xFXZhx
         tBEf+H1uqHkG01hGbf6AjqssbXGdOJt7yThm/hiQ18l5sJ2WG7zhlDsQS+HfnLa6gHMw
         phPXivWThteYx416BHNYj/GiJSzCNzWk9psed65K3TehkSR/vNZ6U3BQ2SA975o7hBCG
         wgO4ORM8HCEc8ACCI7mAa/b/M0cDVT7jwRiS6KrAzmWQUTfqjjMIoAysxxEgFL4f/Plh
         cctQF5yGtTaQvA7cjGPmfH987hmreEY05vW8wXNkOG0oqexyMA2Ai0D4xRJBppJqvrWb
         yTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007198; x=1694611998;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkS4dwu10x1+vjWXsbcfHKESE3PkULXw44CJgNTiRms=;
        b=LE23o67RXga49M33SaI+ghHn8eVPMB4YDga0kkwwXLy/Osj4uVZ6HR/Ocy+RR+wnnh
         s4KxYFpdwGJyLke34vlgfXsXTG0LbCVzQ0/+DQYpVS9ZFaaG60bofbETPdm8oyzlVl1p
         B7ZD87VrdohSMO9YXwabJ+Hao6kukhCjC1Q3fSKmV2BD2uNX5Asn4J32Ha/B1mvjqxjI
         3TJrYU1ThVzLcJ7r/5wyaWn1ol/PrF4u7K/cf87IhquZ6AvU1RB8nTLjQRX6XbBse8Ro
         +yYPvFUaSga60XCS9R5uj8W7eoOrZ07RJUJu1MsXfKEBx9ojJMwluM76D1sglAd1R2dq
         bPdg==
X-Gm-Message-State: AOJu0Yy7KMGyw/IiyKEvwMX85jIrFwMH18X3GgXPbU1Fwmpg3uuLF2FJ
        UlfbXc7sIWr3b5ohrm0KUf1mMnndPZngkiwhUS0QNQ==
X-Google-Smtp-Source: AGHT+IGMje/FRWokck2wn04oudnOTW0gkJmtiwBeKlTR4UMAz+n7yyu1Qfzy6BD2WResn9T32HAU8g==
X-Received: by 2002:a05:6a00:1d08:b0:68e:369b:a123 with SMTP id a8-20020a056a001d0800b0068e369ba123mr793304pfx.1.1694007197881;
        Wed, 06 Sep 2023 06:33:17 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b22-20020aa78116000000b0068c10187dc3sm10726107pfi.168.2023.09.06.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:33:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230905124731.328255-1-hch@lst.de>
References: <20230905124731.328255-1-hch@lst.de>
Subject: Re: [PATCH] block: fix pin count management when merging same-page
 segments
Message-Id: <169400719660.700937.6892513127903157201.b4-ty@kernel.dk>
Date:   Wed, 06 Sep 2023 07:33:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 05 Sep 2023 14:47:31 +0200, Christoph Hellwig wrote:
> There is no need to unpin the added page when adding it to the bio fails
> as that is done by the loop below.  Instead we want to unpin it when adding
> a single page to the bio more than once as bio_release_pages will only
> unpin it once.
> 
> 

Applied, thanks!

[1/1] block: fix pin count management when merging same-page segments
      commit: 5905afc2c7bb713d52c7c7585565feecbb686b44

Best regards,
-- 
Jens Axboe



