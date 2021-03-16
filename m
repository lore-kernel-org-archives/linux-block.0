Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3494C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D51965077
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhCPObn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbhCPObW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 10:31:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365ECC061756
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 07:31:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u20so37326665iot.9
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QBrTqmbWkT3m4ogzCMY8L/5RjpVs2Bwj4VfzNovCHcY=;
        b=WZ4wdj4zQdq/AoWbRfvpsRKEyQjHIw6AZKzfcuM/wQxFzYQ4UfalEnV7KA+QdeohGD
         h6yNwu/xq8jddKxh8DmaW2xinj7JlQPKPSRVxhXjPafMr9s5/aStzxufxfNt3YKxnumN
         02Z8E3ecZdPMzgd2NUWYQzKJQwykg8+DfgRVbpz0UnoA81gSPQgyCI0reU4qiM6Lgen8
         ho4OLCSzKuQDuZd2tykgvV1imXVx5+V4k6GDX8j6ITpju3by/DFoXTYX61w/IJq8vp+9
         TBGVIgyXSmj5Mrtr8IRzsaTNupnQ1EQfhFjgBbT/EN1JOl3YN3VwPHwSMP3zMLg7PJFt
         T1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QBrTqmbWkT3m4ogzCMY8L/5RjpVs2Bwj4VfzNovCHcY=;
        b=qL2WVvBLwo9EKqZT8zPbPOEMsjcbIeLeR+Xy/BvmJQjgLwDClq1CYgcPxxCbzgSqxG
         WDfI1f2jVTYy9grFepf0qRn78WklvPGTvf0tTwbGMI6Phpg4RV9QG0RLBjaT3qhPQeWn
         eXKdvSPtJBcqUmsZxoZ8OIAgUXCLUeyhkze7yT7h2a7bT7/5ZuZHJfhhKWlPPnOBcYLV
         yhSYEd8ppTvNSb+Q1Ny+sEpRbeGqyq/+BP1zwr3mUtv18AzzS030UEYcMgFkWFVQbBS4
         fKXX/JGMTKia3C4h5p+3ANRSnrCn593IA8XxCiS1msD/zhRVCu80npnbQSFUzJgbe4/d
         2NDA==
X-Gm-Message-State: AOAM53139SSz1qpb1tVfy3FU+BmnvHgUTRGrduZZhXgdUU4Z2JpQcpns
        WEsPPUbSvp3CtnkSu1zTOFfp+Q==
X-Google-Smtp-Source: ABdhPJwJDINYIHtGv7AA1OeehO1lScr+eKoDb0C97yp6l13rjNlzdpEMTq/xFiWltriuJcdffftGTw==
X-Received: by 2002:a5d:938e:: with SMTP id c14mr3640584iol.88.1615905081657;
        Tue, 16 Mar 2021 07:31:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a16sm9550081ild.82.2021.03.16.07.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:31:21 -0700 (PDT)
Subject: Re: [PATCH 0/2] s390/dasd: cleanup patches
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
References: <20210316094513.2601218-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b19c6de8-5d97-2ce1-5e48-c73e713f69fb@kernel.dk>
Date:   Tue, 16 Mar 2021 08:31:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316094513.2601218-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/21 3:45 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following DASD cleanup patches for 5.13.
> They apply on you for-next branch.

Applied, thanks.

-- 
Jens Axboe

