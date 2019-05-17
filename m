Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C9C04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 21:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DEA2087B
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 21:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZQgB8svU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfEQVRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 17:17:10 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:36322 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEQVRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 17:17:10 -0400
Received: by mail-pf1-f169.google.com with SMTP id v80so4266678pfa.3
        for <linux-block@vger.kernel.org>; Fri, 17 May 2019 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VfSQiZXDw9z5dZjFrjKTsYiGBGvOiJv1Tcdgk1Ayenw=;
        b=ZQgB8svULT7m4+ckNsrmDzuqhvjxHZ1KLASM6wK8qybKMMuf8tyQFKFF/qh8cfIPgC
         VAVycKs4s/8hNg6okfC2EAXU7FXf3ssdMfN+KPpaQM72/8YyV+s04X9OO7PBh1PDKJVa
         SihoYwqOKL4E2fL1WK4g4vlQrM/I0m2F3x1vHBBqcYaTtPCb/XPr8fJTsqnSBXwO+J9l
         BYDz7KUFsOV036aJB+tZYzpqlKr/GA4zci5ubzCh+kHwd0QRF4yqRi2ckgNmjCplzn71
         h7AD22WuoMrYzDN9/rzj2BBhWzSAdUumenJKXuHjRF2c4V561/irlMcjLTvuGro5tv1n
         yQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VfSQiZXDw9z5dZjFrjKTsYiGBGvOiJv1Tcdgk1Ayenw=;
        b=dSuRmnsF1MyskRCIruy0Xyl51DheCV0xk55xf+i330u3IhTwz2Ts6Vkv8IczK/tIpN
         oNPlkzD+4XNMonicxuSIZBT6AujD0pZ2YNPbfIKnE198iBlXA1pUFqGUfs6gUTBvw+wK
         6hsHh4s3WQX2GsePYDEWH1J2VaJjbCyQclOwH7JvgiIF9tkUWPCBKJ3NtxIc5OMPVVLS
         /XCNNO2g/oTPzPcOeMI64oOHloixlxKHXlIB9sqVMQgAZzkTMDPaXkmTFKEM3ygYG2pv
         xq/7cUaXarm28lNsxLVU1djObSzwqWQ0aCaqAnWGuvb5R9wLsbNtPY755k3Bvn6irFtt
         lU7g==
X-Gm-Message-State: APjAAAUNW9FWDEij5rtuVs/T2lNI+jDriDOhsq/VUI5sx2cm0ZD2Q6VB
        +xPzKQPgFTyMcQd/pxIAUy+c8wihck7DRg==
X-Google-Smtp-Source: APXvYqxxPq8B0uWTBxjteNDiS1BP4g+8mhy1GplIdofmapADGYTuQgku8Axzh/smxiF171yIwBAh8w==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr59156393pgd.63.1558127829276;
        Fri, 17 May 2019 14:17:09 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 1sm10170104pfn.165.2019.05.17.14.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:17:08 -0700 (PDT)
Subject: Re: [PATCH] block: bio: use struct_size() in kmalloc()
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e46a73e2-b04d-371b-f199-e789dbdbd9fc@kernel.dk>
Date:   Fri, 17 May 2019 15:17:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/19 3:12 AM, xiaolinkui wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

Applied, thanks.

-- 
Jens Axboe

