Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C43C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 23:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiF1XKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF1XKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 19:10:50 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8D37AA3
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 16:10:49 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id k14so12418549plh.4
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 16:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m1VGRzovQ6eFVNQdoLWRl6fMmQuI9vALLEc7yi/fNvI=;
        b=KkLGp3qXOCaF4GM4o3X+iCHwYis13k97W40kdWS3pebSr7ScxHJcfHuIirZjDMnckI
         HdBPfQR+MlMP4XnLTPKMDUXBwpSRVGe3l+/JYBG3AX+zCOpAwYZGsnPmxLGAuppdKTkY
         0EXa3/vdNEbhgzVf2IMo5JygoSwpPfG0YMJP052qiNheiaeyiU4fSj381Jab2bMB74e0
         ygVeFGXAhs5YT/Fd0vtn1J2fX6m5ChPzysk/Zw8l1s0EP2bPtKb2V1UUf5ih9blZktUa
         vhttshpDprRgT5MaNmiz44mrmUjH6lrXAZ1+/T9kK4YajT2fX00cBqJYpFTtmab+36Er
         yeOg==
X-Gm-Message-State: AJIora+WZ9L/lO1i5g/26Oiga42Syp5wpRLDiuIYH1qxsAAuwheNHanW
        d3K/6G38PLMblbBJUjywedDAN/ESHdI=
X-Google-Smtp-Source: AGRyM1sMhEsQ8Uf3BDn1dwfgKvq5luJr/HU649LIp/J0711QaToMFWn+IHtp7/YHMid1QpTJom9AWA==
X-Received: by 2002:a17:90a:3fc7:b0:1ec:fcbf:be06 with SMTP id u7-20020a17090a3fc700b001ecfcbfbe06mr311400pjm.197.1656457848730;
        Tue, 28 Jun 2022 16:10:48 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id jy18-20020a17090b325200b001e31803540fsm452519pjb.6.2022.06.28.16.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 16:10:48 -0700 (PDT)
Message-ID: <52216a08-4d6f-ccd7-b385-9cbb3233695a@acm.org>
Date:   Tue, 28 Jun 2022 16:10:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/51] Improve static type checking for request flags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220624050527.GA4716@lst.de> <20220624050706.GA4789@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624050706.GA4789@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:07, Christoph Hellwig wrote:
> Oh, and a third:  there is still various places passing the op
> separately from the flags and/or using bio_set_op_attrs.  This
> would be a good time to clean the rest of those up (I already did
> a lot of that gradually).

I will look into combining 'op' and 'op_flags' arguments but I would 
like to postpone removing bio_set_op_attrs() since this patch series is 
already too big.

Thanks,

Bart.
