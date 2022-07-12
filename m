Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 12:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiGLMtD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGLMs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 08:48:58 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABE26AC0;
        Tue, 12 Jul 2022 05:48:58 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 23so7464380pgc.8;
        Tue, 12 Jul 2022 05:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=54C2TPYXSPlTMXJUnlGF1jTRtY0nrlM/ihgIc0q9Wag=;
        b=O0B3lvpJG6QioVuNnag38xXqfEk2SpikZlweVPQKcejz7TuO7PKjQ9Sg9VARIM/jwS
         cyUsAtxgZVERedD2B/BbpeIRUgu+Xr1dNi2k6zdVT6C3eQfFqtlfC9jq2zLeiIRLIqxP
         YsSPOooIYvp8jgs0xQhRz7GzAO1cQwGBkv8M8sc9ylVTJmY+GPo5dzUVT4SejwSfw3Gq
         SPBd+NlNdx5uy99tdjNE7dzvUA2lgweFl4h2ExvnEo/hpkSLCY25OyBwEIagWjjxrXGe
         LheT89q+Q+lhUzCG/aB1/wTsL0KWnUfrVtd/e2QYrX015E9YxI8dtzosGfN5M1XPa/AL
         gXxA==
X-Gm-Message-State: AJIora/fbqDzp7r+4MbkwRwdGxq0Fn5uIvpF31zc7e+D4cycsyB2YHdR
        lBIKeqbUx7ul8v2lv44X4l70KNr09To=
X-Google-Smtp-Source: AGRyM1tm6+g/fhzGG8TP6P5Y9Z9kczuFlCKFDM9768aqwWimPJgAXA07HLQWvwlUlinS0oHUfyFddQ==
X-Received: by 2002:a65:49c5:0:b0:412:6e3e:bd91 with SMTP id t5-20020a6549c5000000b004126e3ebd91mr20590031pgs.221.1657630137602;
        Tue, 12 Jul 2022 05:48:57 -0700 (PDT)
Received: from [192.168.51.14] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902bb8700b0016bf1ed3489sm6735698pls.143.2022.07.12.05.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 05:48:56 -0700 (PDT)
Message-ID: <1f9e8664-944c-5ab2-cbc5-c40fdd9b517c@acm.org>
Date:   Tue, 12 Jul 2022 05:48:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: Use try_cmpxchg some more
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220711153301.2388-1-ubizjak@gmail.com>
 <Ys0C72unFFlsWomq@infradead.org>
 <CAFULd4bqmbundK=YE9A1scW6za3z4B7B_XjY=sS1R+3H40fF0Q@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFULd4bqmbundK=YE9A1scW6za3z4B7B_XjY=sS1R+3H40fF0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/22 00:04, Uros Bizjak wrote:
> while (try_cmpxchg ...);
> 
> looks to me like a semicolon was left there in error, like "if (...);".

Putting the semicolon at the end is not what Christoph suggested and is 
not allowed by the kernel coding style.

I also prefer the while-loop instead of do-while.

Thanks,

Bart.
