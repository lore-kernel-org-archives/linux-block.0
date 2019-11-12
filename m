Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B3C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 15:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1942821D7F
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="F7QSzOCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKLPkK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:40:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38389 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLPkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 10:40:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id s10so15281477edi.5
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yabfyb3HuQva60d9UPsbPaWQhMDPtVd1XlwpN7MOv50=;
        b=F7QSzOCrcuYaCqVumhQuIMqXrz04AQ1Rmn0bG3JRrKSUPJ41ChwcvQGjMzsZJW3ZSI
         wHh5hbamYtmvraZxuzcfSLHAeJzjk9BcwQw50/JhCzewdeLpur9j0JskyU0PYB4kzZjU
         kwAVBwpwmHyBijbGyBI4a9yS9K5bRjWUGtA7YE2m9c8KzzYNyr3Rf5T2MhwmqcoiAnB+
         EkFaz+I0Aw+RQw9wZTalcTolCzn+qU0da0XKS8P+3LiMPYtzDP0yNEBuY1CKCNEJJP2f
         6UeaHRvQML2d9BCqaSaL5BWnjM5tc7g9j3xKKhvff9NG/97BFLakzXd2ldG1AAdBnb26
         d93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yabfyb3HuQva60d9UPsbPaWQhMDPtVd1XlwpN7MOv50=;
        b=Bujpb4IwrEFe3ISzNw5OJPot5IkBjIrYQeFkbMLbuGJv5dzL2tp60g/oqVicSt94im
         J5oJZMZ+5QdTt0LBbvzhTpC+GQpDTBrV1KbZ41HhT1ry6k9Xtp7VTFBFDF2RnMY2ODc8
         T/GyYH5sVek0vuNUUkvT1j+0d56JjJMGs4+9j+onhMxf3Rb4QsG25FNBto1h2kAIaipB
         qBLZSEojGNv98HRgHJhcwhuo9s5Ns/cQSrTXHI5ImAhzBseAFTL4z+69FwNovZ1rp2o9
         h+EiKCL5Jd/SdNjVlHzgOKsv9f88v4DP4VWblR7Stx3cqTW3q8w0q0KJ/lIP44CSF/z4
         hBhA==
X-Gm-Message-State: APjAAAV0kYQSN57bbWuG5wpYu1UvyFESpXFvpQqby3nmNMIkI6zQr+0t
        POhxzP2wXtMbSUzq2ZaWm3D7JA==
X-Google-Smtp-Source: APXvYqzQAY6+oDNVM8dhKnF9LFGHhWQDD1oHRDtjNMM+0hPNS4+cz6vy29kctNiSwuSIW8X+IWF9YQ==
X-Received: by 2002:a50:ac2c:: with SMTP id v41mr33062660edc.11.1573573207696;
        Tue, 12 Nov 2019 07:40:07 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:8148:8ecb:9630:da5c? ([2001:1438:4010:2540:8148:8ecb:9630:da5c])
        by smtp.gmail.com with ESMTPSA id v5sm631372edd.90.2019.11.12.07.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:40:07 -0800 (PST)
Subject: Re: [RFC PATCH] block: move rb interval tree from drbd to block
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20191112090139.16092-1-guoqing.jiang@cloud.ionos.com>
 <20191112145043.GA31295@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <55c12a4a-db31-298e-58d9-8e1be7cf4a41@cloud.ionos.com>
Date:   Tue, 12 Nov 2019 16:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112145043.GA31295@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/12/19 3:50 PM, Christoph Hellwig wrote:
> On Tue, Nov 12, 2019 at 10:01:39AM +0100, jgq516@gmail.com wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Currently, drbd has the implementation of rb interval tree.
>> And we would like to reuse it for raid1 io serialization [1],
>> so move it to a common place, rename to block_interval, export
>> those symbols and make necessary changes to drbd.
> This should not be built unconditonally, but be selected by the two
> users.  And lib/ seems like a better place than block.

Thanks for the suggestion.

> Also please fix up any > 80 char lines that your naming changes
> introduce.

Hmm, some lines are > 80 char before. Anyway, I will fix those warnings.

Thanks,
Guoqing
