Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02F7C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347004AbhLFQgc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346810AbhLFQgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 11:36:31 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF94C061D5E
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 08:33:02 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t8so10807955ilu.8
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P8Qlq0IP76FBJPtbKTV0K0to60+5xjfpAElrt5bnfUU=;
        b=7YoMmeZOFlE/gf1crOSyXJawN2jjGiLYiNQnMA8S3fU/7lAXGqTATxFQZ98EEv62Am
         qugOz8oc0aT+XD+6vTX8I2Y5WMqcL7Y0COE9Q4pa6h0TP3S15EXWv5aayyq8kjXettb0
         sKV4BbkZ9j4f5YfqRckWydtN+De0O0d8aUQ7V0N9ajANDpViYJ9Nx/pP1Kv5lIjn2h+Y
         pvrnFYBtQpKYOMB2JHSdAshiDBt8OQ2V4nJfFbyCs4t2v+zOntyEGcyO35EexfzjqHul
         2F/pSdhkCtqs+LDKyqoHXa9LInjDLnp1vTnVaueX2V43LeYg9kXExHXaa0Ri+tZodcbz
         rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8Qlq0IP76FBJPtbKTV0K0to60+5xjfpAElrt5bnfUU=;
        b=zZra4lMiYYeFrhOhUxgngUOmfPAXhbChv+YLKT54xs/3OEEGLgeCiP0Liip7DFwj0Z
         bYZNh28Ci6U1zVTnpAt9lUxriOkKdWPkM0C+vZrb81hjARBJOJF4HFoSEzjl03kmQwJF
         /K4vbCIr7SSN/7ejJN6N4Y69zvwrBd2DcrnhyFk13KVWS6Honiws0mI/RkLwydkqmMQr
         UhkDLOfBQFVAi5jBI95EkvMq90O/bx1yKLzHpKluQqEQtgFXfX/kDt9l0nYzaV3OWGJF
         62BsQXSyuke71zNVQz5cOZLAGTkNxaZ53NYnt5LS/QBME81RWhE3IDFLY6sRjj49+n9r
         2kCA==
X-Gm-Message-State: AOAM5303ApBX2fgvBEiqkk5C+77zPl/r/eo7Hm7jCiWZ1czeGbtYUuel
        VPgFFBS/dcKk3IFyPCSbkkTT9XHcXeiOC8RF
X-Google-Smtp-Source: ABdhPJw9v+Yf5V5dzAP3iWDNSr8+U2o4BdRnJwxT6jym1Wu7eblVVX7mcv6YcSbbQGUcTiBvkXvX/g==
X-Received: by 2002:a05:6e02:1a08:: with SMTP id s8mr12128889ild.158.1638808381464;
        Mon, 06 Dec 2021 08:33:01 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x7sm6753239ilq.86.2021.12.06.08.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:33:01 -0800 (PST)
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-3-axboe@kernel.dk> <Ya29+OXo3SBh7UNo@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89485d2c-a0e2-c7fb-90fc-ecc500e49127@kernel.dk>
Date:   Mon, 6 Dec 2021 09:33:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya29+OXo3SBh7UNo@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/21 12:38 AM, Christoph Hellwig wrote:
> As mentioned last time I really don't like the proliferation of
> tiny helpers with just two callers.  See my patch I responded with
> for my alternative.

I tend to agree with you, but for this particular case I really don't
think it's better to not have the helper. I did try that version too,
but you end up with several sites duplicating it. So while I agree in
general, I don't think this one applies.

-- 
Jens Axboe

