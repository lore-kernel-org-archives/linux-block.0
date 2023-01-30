Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C999FC61DA4
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 15:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjA3PYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbjA3PYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 10:24:20 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1D34021
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 07:24:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id l15so1406436ilj.5
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 07:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdRsnq8SrpYziohnBt7964p9wbA85jXc5wEU3EWSaMA=;
        b=xAA0YSZ7rVFbbsecaWjmQE+dUSgIdAVQdX4IkJsP7jFdRkp55tlz9muaxeaVkm6HoN
         0Zufn+RndEx/p14C6tz7uWwr4I2mAjEKs/JPTmKKSsyIRyRnhyZDiZhawctr5sk5AK8I
         r5vOrdGGTUffdFYG1EH0f/hHYu0VSJviqEedS0mLhLQy55wgRFufHKlR+gSmmqCGHa8T
         tOidIMfoA3i9GnHSq1Y3dZW+voZJ40ijIm81wRWw0tH0s8AcqIcdkZdVS5aBIvNNlGBY
         yO/VQMhmNxyX71IdrRLg9JPGYRvKPJjnCjE0udMnyqvevmAGQPwHA+IV3K5dmf5y1glb
         VJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdRsnq8SrpYziohnBt7964p9wbA85jXc5wEU3EWSaMA=;
        b=HpnaAEX+d8mdR2eSorAFvAJmxNkCChuJWa+mdu6veYdTJdf8wbuZsJkIAcFB1bzzmf
         MCAKKhC14R7HvqnA0ZMPHUIK4ZEF8NLMHYOEQKKabxfi8GHl3KhQErSxegzkNVx0Ufm/
         r6pR2L+oNEig7ns7CdLPwZaHlwxI9P2klMyL8WHjopMZ2F5QNB9dlzvI1FtkWo8vNN3k
         YyTas/25Ph2qyTlYcilS7xZkGyzKAIxGA9jEbvDs3QeppNQnR20PZ74e+0IZexwYHTg3
         kZahctAAw8W0AXk6wJSdLfnhFozlebX8RwWVBLkqcgpcyQubNU22+VCRT2HDkzU9t8kB
         CmNw==
X-Gm-Message-State: AO0yUKXhl3N5/z/z5K8Q4K0CcsACf8xQrDWHhstf9LQ29MYq7nT+fKPs
        kE96vVvlkpMOqwCI0TH2Rk6b6w==
X-Google-Smtp-Source: AK7set/GJmwY86PqWy8yhNLsuUM4E0VP4HyJCqdWV47Lf++7Qi4bE2ApOk/vWfH15N3FLWp8Vm2itQ==
X-Received: by 2002:a05:6e02:1a46:b0:310:ecea:b488 with SMTP id u6-20020a056e021a4600b00310eceab488mr960112ilv.3.1675092254136;
        Mon, 30 Jan 2023 07:24:14 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q18-20020a056638239200b0038a56594026sm788407jat.66.2023.01.30.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:24:13 -0800 (PST)
Message-ID: <740be398-6963-08cc-6a5e-01e1315bdda6@kernel.dk>
Date:   Mon, 30 Jan 2023 08:24:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ondrej Zary <linux@zary.sk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
 <20230123190954.5085-1-linux@zary.sk>
 <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
 <20230130064815.GA31925@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230130064815.GA31925@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/23 11:48 PM, Christoph Hellwig wrote:
> On Sun, Jan 29, 2023 at 08:44:06PM -0700, Jens Axboe wrote:
>> I would prefer if we just delete it after merging this one, in the same
>> release. I don't think there's any point in delaying, as we're not
>> removing any functionality.
>>
>> You could just queue that up too when adding this patch.
> 
> I'd prefer to just deprecate.  But most importantly I want this patch
> in ASAP in some form.

There's feature parity and probably the single user of this already
knows it... I think we're grossly overthinking this one, just kill
the old code.

-- 
Jens Axboe


