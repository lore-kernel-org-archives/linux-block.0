Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79331C61DD8
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEB4221F9
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hYh1H8oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgKPP2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgKPP2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 10:28:31 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F9C0613D1
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 07:28:30 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n129so17790679iod.5
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cjrSC5QyZm1b9x+1TfHrkUsiua1ov2aE33mdC49A8s=;
        b=hYh1H8oI2IM6Bil0tmxzNEh4RKYUx/+nhK+eKlQb7zOj/vrW3FSN4b6BJrrDWYWctR
         RDPA+F5lQClMvYY3WN3gOq7cLvMhZTqtB/wbpUJ4rjPw/NlXEvgpaP2vVy4O+HLotRTS
         DkD/OX8Od682zSv5nIDskqBtjeDKsa9ggHsvJ+gAIy/dLJL2De2Sd9Qe1iQZUX73rqIg
         eqejiStQ8VGV84DSHwNOten9Rqg00AxZ/NT0rKFgjgxUJZ6biwYDCfErHKd+pH+8t2Zf
         pBFH7WhP/jYZ5YzHiaoU4JhCCy2ZF0VxD0fLT+4Mih8R1FAIIb5ncqgGEyZzmJoCC05k
         mZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cjrSC5QyZm1b9x+1TfHrkUsiua1ov2aE33mdC49A8s=;
        b=K8UR/pZagFvhzYKF1aZiH+WabPpYOIAQaMOsLZfoyzZloJWhLLQQJ409LsfxxeT9Su
         4LKytyHKBVwloBgGvTNO/y0/GqiOs6OcMhtASyaps1avulEwJR5qUjR+RvSsk8GLUTnL
         VlPPoXYuRSeCIHiSIav5vS8wIeQmyeleJRKfEZfN5V/iga+pGCCNvsWxJfMx1zLEeFEI
         FzJHge+e4+Gx/HwicrI2VboNRZ9UiCzLbHYLefjhHD60OO60pabeht3PXAQHL1ycDooE
         TvBE2QacMm1pG5JD2yHkJq87pqd7H0wv54MpgX99AefGt2mt5ttyJSsoxr0q7hIQOBDQ
         ABvw==
X-Gm-Message-State: AOAM530y/hPbdNvHjJvwZD4cDkA4xhOZqeht783dsa3/vL7rUm0NWwPu
        AQfjBFdT2fX7BcIfQRNQF5IAaw==
X-Google-Smtp-Source: ABdhPJwXvh6hBJkw2iVfweDYQzCcK9t0E9MIUxf+RJhx68sba6/zEYLYAGsimcnpdpkxYzMxL1qHgQ==
X-Received: by 2002:a02:a68b:: with SMTP id j11mr33352jam.32.1605540509666;
        Mon, 16 Nov 2020 07:28:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x13sm11280105ilo.54.2020.11.16.07.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 07:28:29 -0800 (PST)
Subject: Re: [PATCH 0/1] fix null pointer dereference for ERP requests
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201116152347.61093-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d6a4ff9-d5dc-131c-3fa7-afe0c843a731@kernel.dk>
Date:   Mon, 16 Nov 2020 08:28:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116152347.61093-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/20 8:23 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> pleas apply the following patch that fixes a null pointer derefernce in the
> DASD driver.

Applied, thanks.

-- 
Jens Axboe

