Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC07AC47404
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7D92084D
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 13:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HnE6QibG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfILNMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:12:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33600 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbfILNMe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 09:12:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so13500923pgn.0
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eDPbVXqU+y+RmPn4/ZLvHXxFmtHPu9FG57Z6VOzUMvY=;
        b=HnE6QibGc8QbXvgR7z4lNSDL09+NmGKGy1fRXULhjvG0xbmEdafAJkCDi0302zxTwt
         qBPwDfRYcQB7pUUuEdBpFzdGMwGnMo4BwjofoqTRT2+qK7/5cCDO40UvT4ULFlUtOzWU
         z5aajg2c+ulNJSH3EudIAIulziEwBpZphkcXIGpikHIGOXTeYK99PrDs43X1xUeKmjc4
         vRVE60SnTPpsjQrfNkCwMLRLNhm38Eu7xU6Qo/5AeJ+CJE1ve6p8qsbZ7Tmna+66s5N6
         cbui7ZzWXNWy377MilRPai/306n+XaMMeck8va3DiwUhi3Vh+LNL9HVtJocbHL8yNGyV
         HGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eDPbVXqU+y+RmPn4/ZLvHXxFmtHPu9FG57Z6VOzUMvY=;
        b=G0BbgAi+PYqhuGaxtDdMK6p7datXKI73aRAPQH9Ma55rON2GQjHbLNrBqAIQLcGc6e
         4uzIjiZcys9kd4EacKA3mRu5tfKuYHgLqNzof7KHtFG8L+Uww4eUUDZzNbpg/1WW9In2
         7DZphgh0EXLuxZbaOH7DPsKoLeLrhSr9Kxcp34HYRTmKg/brIcoZ1u0TXJb3lvDM2YE+
         ORdta3xXnkQEY7ix6bvoc6pHfhd2H+9qX8pSN09K+h2D2Nojoz99jayxn11uOiHHL6vv
         P+WpJITgtQ6ysUppdKsmKJJdHH/X2WEf69WQ0jj92JEE3mJJ7CkEkvkzOIdG01sv36Hv
         FuAQ==
X-Gm-Message-State: APjAAAXT0ZWwuzSv7EVBZsdTpuPFANq7PHY/uVHF0yuQw7Dva8/RbOkT
        xqMAZw18JkbQShR1BN9PjkOlbw==
X-Google-Smtp-Source: APXvYqy5IRnkfN40k2/B7q313u2BRWeMvX80jlePX/MlMV1tGW/e5n3Y99EGn/AhhLeBvPK61j8c0Q==
X-Received: by 2002:a62:2787:: with SMTP id n129mr10490181pfn.45.1568293952678;
        Thu, 12 Sep 2019 06:12:32 -0700 (PDT)
Received: from ?IPv6:2600:380:4b2e:3b64:29ff:2f14:b019:100? ([2600:380:4b2e:3b64:29ff:2f14:b019:100])
        by smtp.gmail.com with ESMTPSA id m13sm24678837pgn.57.2019.09.12.06.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:12:31 -0700 (PDT)
Subject: Re: [PATCH v2] fixup null q->dev checking in both block and scsi
 layer
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.ibm.com, matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kuohong.wang@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        andy.teng@mediatek.com
References: <1568277328-4597-1-git-send-email-stanley.chu@mediatek.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a285805-cdf3-fe7a-0d1a-9f53f821d025@kernel.dk>
Date:   Thu, 12 Sep 2019 07:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568277328-4597-1-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/19 2:35 AM, Stanley Chu wrote:
> Some devices may skip blk_pm_runtime_init() and have null pointer in
> its request_queue->dev. For example, SCSI devices of UFS Well-Known
> LUNs.
> 
> Currently the null pointer is checked by the user of
> blk_set_runtime_active(), i.e., scsi_dev_type_resume(). It is better
> to check it by blk_set_runtime_active() itself instead of by its
> users.

Applied, thanks.

-- 
Jens Axboe

