Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F45C433FE
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiK2TJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiK2TJc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 14:09:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371C5ADC0
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:09:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w79so14631196pfc.2
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUCWVuV5ilKeuDgOjxnFQhCADSo39gWh/IcJObN1/7Q=;
        b=C+Jja1wOZ3eCbU8ahJCX0oIjULLFfYy6wBJ3ZWbVWDNApdMWrDtpt0yqkNZ0apBl5m
         WsxZSbV31Sh6I6zG4CSXkML70K7xdi7+Vp2279a+hC8iXAHUVVhVRvvBL0baS/gv7wdZ
         AW3O3Lt9p5ZuWHnmKDQRy0luntXCbdqcL7Z0FcmDGUwB4Y6ylKUxds6wJBITo/z/ZHEz
         kI/tHRj/4MCN4t7ZwqDeUvTwWwR3J4/Vgtu7DSwvGP0ZlHEW08nP0SrZUTICqOOOyx/2
         qhUaYRy8wqJAd7DN/RQNozt6pXy21mMweHm+VUkHI92LZH5yMIcAV0QZLnlTaT9BfJNJ
         F7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUCWVuV5ilKeuDgOjxnFQhCADSo39gWh/IcJObN1/7Q=;
        b=dItXmB9QKZk8I0Bma/AGBokczM25AFrwbrfkGsxH75m3D5KnE33xBCfO4S56wDAzml
         rahXaTspzFgtpVYluVlA0XkmAixThP/g+dZZUoPk+azj/3bBd4DW5g+FiOhfD4a78TIP
         fxsN8yK5o46zfNbtmt/UIM9wkCnq+eh1s3p1QlTvf4T5EwGdhjTLer6feYM52tv3fddn
         lhthcW4lW8rWlLJ2BsoVqr9mRraayt1CAU7IVHGLhQpy0qYl0YQvUxdl/n0HUigw+12N
         9xIWOdxEWcvp01VASJCK+fLf3EoGLNWFyi5AreenJUpln1W8hAFki4gzCrIt5B0IMJOd
         D8+A==
X-Gm-Message-State: ANoB5pk4S1QrD45nbimXDpFV/dol7hI9KuTVxvQnw+fDv3YPsvNd9QCV
        GZ5QLBjlWQF1og2owdNg8s1B2Q==
X-Google-Smtp-Source: AA0mqf6HNK16CbaqqGtDFPprL22DutKkgq2teBmDxMTA4USYxpOLhNvZCvsoZtUKUfnYYHZecgvxUw==
X-Received: by 2002:a63:5544:0:b0:477:6fe2:c1d1 with SMTP id f4-20020a635544000000b004776fe2c1d1mr33105723pgm.444.1669748971157;
        Tue, 29 Nov 2022 11:09:31 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i190-20020a626dc7000000b0057462848b94sm10232185pfc.184.2022.11.29.11.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:09:30 -0800 (PST)
Message-ID: <4e607bb1-1199-b7b7-415b-fb2a2c06022a@kernel.dk>
Date:   Tue, 29 Nov 2022 12:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: blktests: block/027 failing consistently
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
References: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
 <e3e62491-d670-df16-94f8-51feb5d159ec@kernel.dk>
In-Reply-To: <e3e62491-d670-df16-94f8-51feb5d159ec@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 12:02 PM, Jens Axboe wrote:
> On 11/29/22 11:49 AM, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> blktest:block/027 failing consistently on latest linux-block/for-next
> 
> https://lore.kernel.org/linux-block/20221128033057.1279383-1-longman@redhat.com/
> 
> been a few discussions on it. Waiman, how's the fix looking? We need to
> get this sorted asap, or I'll just revert the offending patch.

Let's actually make sure Waiman is CC'ed...

-- 
Jens Axboe


