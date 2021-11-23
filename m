Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhKWTBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhKWTBw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:01:52 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE63C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:58:43 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id j7so33749ilk.13
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jsTPCCOIpmIL1a5Q1LdHjXMSuDgKbZ1B3NL6RXNxgaI=;
        b=YugQ8mNXY9oZTvMGkqv0XTeNFHhiIV0+JkMYKalxzpwan8lDUwM6/YaSFXka3/d4HI
         p3NMC33WS7EsyFtNxXpTYDFw9J+uGAm0bkynxk4NcGpotqVv/Lb/eGvcZb+mErmSJKTk
         ojcy7cTw37bGxalx4CLe5HGtmfU3Hujo7Qog/tPenKVLixXbhFatcKreOl6UcmqbwRUb
         PPCNbYx3j6eWktr6uSciTOe6ONUxjmklV0JPaFKyDctHnoIwqnSAgXjhKtaUOFozVh8+
         JubuntHnktGXcNMWHbHqufHDGxfiruhclB5Cn5ZNj2rw/4QNlTxWjbuech2EFjcK5DMG
         WVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jsTPCCOIpmIL1a5Q1LdHjXMSuDgKbZ1B3NL6RXNxgaI=;
        b=QV4Qa2un94aokdzVUEAGBvnRRCGvd4l/DVXGiLq2Tjqz3lrBJbSBjS9VcuynF3mmzd
         q3kOWtsK47hpFwHzBT7r08tN8JDhKcB3d45QRLVnbvYOn8hQ6lqAmS1GF99XqTCEmPlk
         d6BZcQ+rjSqDdY8JxjVnNWfOUqQQN/OgzTKhRKZEaGa81KqTK/G5Anw44A8hPb5Pm0oz
         4Qp/Y3IdV1cjaB9hzMadeKz3ML2kjclh3DBSlcFNqfNk9AenATQxAFonG8cTZYI0Zo7b
         W2G9hQlp8Kvnni9xgnsHpmxSTHsD2drA6z7A1CUFnECzAGpsuKCrCTOnnA+HC0gvjcLo
         9oHw==
X-Gm-Message-State: AOAM532Vh5SLguqtjbk0Wiedc4Q0DAUP45vZjlKIwF5ZFzi2Fp8iW6Er
        xlaLxx+Sbk5qoWN/01D43g5itCO7b6/2vbTu
X-Google-Smtp-Source: ABdhPJx5lQSvpeqMq+6MIYUlOSCztTxzPemv+agTx8X+tzRVEPqaNGkm1KyG/LoMSpzzAxhjENwh6Q==
X-Received: by 2002:a92:c14a:: with SMTP id b10mr7378654ilh.161.1637693923025;
        Tue, 23 Nov 2021 10:58:43 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k7sm5507244iov.40.2021.11.23.10.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 10:58:42 -0800 (PST)
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-4-axboe@kernel.dk> <YZ03/OVZcJ+KlfFm@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b24a297d-3d57-7f8d-1932-da614454b28d@kernel.dk>
Date:   Tue, 23 Nov 2021 11:58:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ03/OVZcJ+KlfFm@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 11:50 AM, Christoph Hellwig wrote:
>> +	spin_lock_irq(&q->stats->lock);
>> +	if (q->poll_stat) {
>> +		spin_unlock_irq(&q->stats->lock);
>> +		kfree(poll_stat);
>> +		return true;
>> +	}
>> +	q->poll_stat = poll_stat;
>> +	spin_unlock_irq(&q->stats->lock);
> 
> If we'd use a cmpxchg to install the pointer we could keep the
> blk_queue_stats definition private.

How about we just move this alloc+enable logic into blk-stat.c instead?

-- 
Jens Axboe

