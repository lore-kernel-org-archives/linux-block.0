Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4338FC4332F
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2524561994
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 12:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhJEMix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhJEMhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 08:37:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A4C061755
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 05:35:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r75so24107908iod.7
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nd2ejrVn1IrBzoTnNUOEIyw1dA744hB3m7HTfczVCYw=;
        b=xmvqwh+kxSPa9x9HeEtsBRyEMZbiwmF9kmT2OvILc5pg90cUkpuaMZ5OvHxKqkDYU/
         1fpVksM05Rf0fxzEAil/CPpgNnKkpCNejmW21owoiE3aWLED7++R8k81uvojfVvqc7ci
         HHXXOXOa9lBEMqLOMKVKNocxqsF+0fQcu+AQ08kIFpjn5xBRAdKSlfOYM9Apu+9R1+eY
         SHsfuYhDY6L8gqWWZaKmVr3FcM7xqLEmeo/ExEEu7PQfnMv9yRp+FF0GUJngHr9mvWDX
         kTsCNcRsjwP+pp6QAXebSf40N/OR4D2lHP2fsAz5ikvIPfnSdkdPZWCCpOhP/G2e1N4n
         RT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nd2ejrVn1IrBzoTnNUOEIyw1dA744hB3m7HTfczVCYw=;
        b=aadcJS0LOPEpKUhjM/rPpXf/e2016ZuV91S5xrnoNY2uReTRKHOvdWFXNC7pcqrFCn
         sUbB0G6QKQZ0FFXb+/r+3H9M3o46BFlJpd9OulSE42advK/jd34qo6j1SZY8SNOu4znV
         xstN5Is7a8uEE91vY92lVuh4F8Ic0oHhCBeuXlutXILsvCm3Wy+Ak7AVoRRRC8Y36kFU
         PeeTChAK/4lIPsGeSXAS5xpI2so1xnsAbE9kZtqeswLUNP2W6IGeGyCWfOqGakaPhu1G
         Sq41d4kNymXKiExOvKjfLoBPCRaGLly9a9bf+q4nduq/K90S6A5V0mVdAhYxgGxAoK2h
         qB6A==
X-Gm-Message-State: AOAM533Zxww2h2kyiFq66MVKQIhw1isjxa8uaeAIcZKpOe0Cy4ZgiTpd
        noIyFU1NLmBQplpgAAKi6WDvMOfSlAgOjw==
X-Google-Smtp-Source: ABdhPJwRiZXSHS0qUfot1WPJLc5czmuF+55CPQgpqu62Bytbnh3tfhH63y5zGznVaUNcr7o0Yrnpfg==
X-Received: by 2002:a02:7006:: with SMTP id f6mr136991jac.113.1633437354591;
        Tue, 05 Oct 2021 05:35:54 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a4sm8961525ild.52.2021.10.05.05.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 05:35:54 -0700 (PDT)
Subject: Re: [PATCH v5 00/14] blk-mq: Reduce static requests memory footprint
 for shared sbitmap
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, hare@suse.de, linux-scsi@vger.kernel.org,
        kashyap.desai@broadcom.com
References: <1633429419-228500-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae33dde8-96e8-2978-5f32-c7e0a6136e8e@kernel.dk>
Date:   Tue, 5 Oct 2021 06:35:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1633429419-228500-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/21 4:23 AM, John Garry wrote:
> Currently a full set of static requests are allocated per hw queue per
> tagset when shared sbitmap is used.
> 
> However, only tagset->queue_depth number of requests may be active at
> any given time. As such, only tagset->queue_depth number of static
> requests are required.
> 
> The same goes for using an IO scheduler, which allocates a full set of
> static requests per hw queue per request queue.
> 
> This series changes shared sbitmap support by using a shared tags per
> tagset and request queue. Ming suggested something along those lines in
> v1 review. In using a shared tags, the static rqs also become shared,
> reducing the number of sets of static rqs, reducing memory usage.
> 
> Patch "blk-mq: Use shared tags for shared sbitmap support" is a bit big,
> and could potentially be broken down. But then maintaining ability to
> bisect becomes harder and each sub-patch would get more convoluted.
> 
> For megaraid sas driver on my 128-CPU arm64 system with 1x SATA disk, we
> save approx. 300MB(!) [370MB -> 60MB]
> 
> Baseline is 1b2d1439fc25 (block/for-next) Merge branch 'for-5.16/io_uring'
> into for-next

Let's get this queued up for testing, thanks John.

-- 
Jens Axboe

