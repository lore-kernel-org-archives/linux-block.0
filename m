Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A4C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33058611BD
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFUQNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUQNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 12:13:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F5AC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:10:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id s19so9062239ilj.1
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NIXFW4d/l6JipXD+/0NcPFQCvP8OgaOcZXTLa60iRMU=;
        b=T2p7SPo0ef3ZtgukkCjRcmkFccBBEceYg/ehQbtqGhXTzC1XQrndy/WBqt/4g4ARMm
         ptOlGs8x41re0jUsLsB5NU1SLI8xYxVPC06XhEJO2/Nofl/APUA4hJIJtBL/x4ZlU74s
         bc81vfGEh7kEYtSVNUk0fxeU/GM4No04UzYZ1iq4N91ZW9A9gDRFIq9QwMioN6kd45h5
         DwQc6ym/s6a1taUPBJvTbrx9v1Y1bGpci5Y/Ze9Qd5hYI0kRfMhCI111ymR9QpTSzTos
         GgZt1SS4cZwHXckQhCGvVDCw3cAA+OC8ohWExGeKB3u7KHM1tSoM7LMIw6qi+LSOtI3I
         ijuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NIXFW4d/l6JipXD+/0NcPFQCvP8OgaOcZXTLa60iRMU=;
        b=CUJNReHf/oKCZ8ZqJj1PMnT4W+g/hC6qpvahcAX/QUK89nLDNsdfjgOxkSNX1vGP8b
         Uhu8UNUEsY3JnjmnMJkRN/PPl6dvt1QQp/SqsR4+evQfF5PwC6QnTIy38r9tOE4a5mcZ
         KCKIg/xPrk1J++hOoZu9BJUpT9JFX+YYLaOWXZ05feErhL9SD4922yZXyN1Wu8gW8VNP
         cQpWQqbv3bFnwa5kkzzQNJ/ziQtwxLZPGr3e7WffLv0yMuQDn6GmmMqiQEFdMbVC0u32
         rhhbLoyNjL4se3uAdB8s8l21Gm4e3fW5DkRYkHbYI6OTQXESCbZGSR6Qxor5+wlOyYGi
         FO2w==
X-Gm-Message-State: AOAM530Vwn5T+h+rSnhWNn1qeDrG1u5uxQ45txel1MKpnZqBuLRNqzLt
        SZ7W9DdLaCXekfmmM7HxL9PdjA==
X-Google-Smtp-Source: ABdhPJzId8IoJUJ6NhyScU9qFziw0Mjj3cpdZx2izFkhaPFyPU4FC5Y21EAi7wTT+FqOgIdWGXitrA==
X-Received: by 2002:a92:bd0f:: with SMTP id c15mr3330600ile.229.1624291856458;
        Mon, 21 Jun 2021 09:10:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i26sm2554555ila.85.2021.06.21.09.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:10:56 -0700 (PDT)
Subject: Re: [PATCH] mmc: initialized disk->minors
To:     Christoph Hellwig <hch@lst.de>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210621080144.3655131-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <173d25d7-2833-76ab-ffab-37e48d5d4659@kernel.dk>
Date:   Mon, 21 Jun 2021 10:10:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621080144.3655131-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 2:01 AM, Christoph Hellwig wrote:
> Fix a let hunk from the blk_mq_alloc_disk conversion.

Applied, thanks.

-- 
Jens Axboe

