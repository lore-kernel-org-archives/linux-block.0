Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FFC43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1CB206E6
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 19:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xY2+Eoje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0Tji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:39:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42144 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0Tji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 15:39:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so3813716plt.9
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8bYBzIMLidsbtn936Tkn2JZUpNIG8j99wkhdl9NhOeM=;
        b=xY2+Eoje7gw1gG5hGk9AkOQtnnY3k/MKnXHc6J5K6ahYMnz24p3JSYorv+TmXUCn6t
         jtSTGzgYBBj4XvQdLMm21Ob68hv140a1FUlPHjKUNGsG7oLFZv9em3co6lb2IYztCLGf
         4BvTrL6T6EPjY+VQTLExjYsakaqdIvYjz43EI5UpijsxFTEwbKUTRww4K+VJcq6y6/zq
         aI/humarfNwtN5pj8WAajyQFCIHlf/I9DpIpzPwpxxHomu7yY91zFH7oEM8+MqftIHGg
         VoNtQRstAhzX+xdiDB+nNFlzQchrUzrAC10QH66OTr/rkCVAEU4JonbxoD3i6+ir84sj
         J0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8bYBzIMLidsbtn936Tkn2JZUpNIG8j99wkhdl9NhOeM=;
        b=R+Nc5mqzrgnyH6PF3CB+peOV70t/baYh8qXHwH2Gk1nXfR42WXi37zEh19pLgJPjpL
         vdPVzc+/eqRgpsVEwlNDDa3Mi+0YHbdJyuBzBcGqcE4yhFOnWtXN7GvKOji/a5lan7HY
         tmne7/bzcN4W/+Imwfj2WrCGNw+/unusa4q32+ededR43ISJxv108snDy5uHJVdGiIor
         pYH1+9rwEzwiw8DOmc2KF4UN6q7uUFxsWNS4zEmBQ6Paq11Dk/fW6CxFB3vdTNvhP+CC
         l11yCskxCXWWP7lDuHJxt1FQndRC/BOcw2zKAMwe1u5r0uFZY1M+yf26Mi3ikLrFwtiB
         EovA==
X-Gm-Message-State: ANhLgQ2TRGpha0jZlIbn92spZpV6eOyh7E4uVWAbHdiiFIzL8Yf+476/
        SupdpjTbDP76Ckf/RscP8ai84VartLxceA==
X-Google-Smtp-Source: ADFU+vt9BQVoxYP52tQ97iqIZHYm2D+ifrPLeLEz4Y8du2EvSvCGOqhJP1qw9sNzHsg7aXGwKY2CAg==
X-Received: by 2002:a17:902:864c:: with SMTP id y12mr662411plt.8.1585337975542;
        Fri, 27 Mar 2020 12:39:35 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i2sm4256926pjs.21.2020.03.27.12.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 12:39:35 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <093c4ab1-924f-b109-31a8-ce5813f52e14@kernel.dk>
 <BYAPR04MB49659E6F0542900C9DFFE05A86CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ec7a6e6-01f9-8ff9-b1fb-9766b60ab979@kernel.dk>
Date:   Fri, 27 Mar 2020 13:39:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659E6F0542900C9DFFE05A86CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 1:35 PM, Chaitanya Kulkarni wrote:
> On 3/27/20 8:35 AM, Jens Axboe wrote:
>> On 3/26/20 9:12 PM, Chaitanya Kulkarni wrote:
>>> Hi Jens,
>>>
>>> Can we get this in ?
>> There still seems to be the unresolved issue of the function
>> declaration. I agree that we should not have a declaration for
>> a function if CONFIG_BLK_DEV_ZONED isn't set, so move it under
>> the existing ifdef.
>>
> Sorry for replying to previous series.
> 
> Here is link for V4 which has above fix and Damien's review :-
> 
> https://www.spinics.net/lists/linux-block/msg51305.html

Applied, thanks.

-- 
Jens Axboe

