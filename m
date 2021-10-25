Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD5FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4D960E09
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJYKQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhJYKQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 06:16:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDFC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 03:14:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 83-20020a1c0456000000b0032cb02544aaso693343wme.5
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R/0xlVJOsSs3p1nU/nlihCS+ZAOF5Hs1zASGaVuq9IE=;
        b=Ei/TmeHi6GjPnDTxhdpvwAaLDLRK5nUyWI2I3NLK/PYaz4lGvpcfzr8eBXiLhHT6id
         LUK8gBPEuGtbj3SJ8EopWVGtW4au9LlktYg7TZ3Rk6OT2WZZX7CnwQv6V576FDZrWWz1
         7geerNkjknEvbLEbTAmYX8VY0u1pVwxMLYu/jbaRtPMWIG8fYJntn70nHVGl1EmdzXb/
         cNnN4j2NrExJy7/2e4C31odTfULhK8rPYBO0T9K5+9BGFAcTxykl4Ag30RpGwDa8uxRs
         Mw5tpU0gPCqKCct2P997etPCYSiOC5bYxI4XjLGTPsLiz1cplM81JKV6l9ecI2S//tXi
         CxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/0xlVJOsSs3p1nU/nlihCS+ZAOF5Hs1zASGaVuq9IE=;
        b=NkSFemYpM/DBOrAYbpeM6c/ltUz029l8NJYr/1iBAmAr0sND4cSCU1R3U2Lj06Y2kX
         oihKqio+9fHA9wlr9vXbeHnczrLmZpPZ3+K/ED6Dyrqs0ayBV2JSMV0YcnwUSG+406M/
         qvT8QtceydAmJz1+ptroy2fbCg44rsuKlLxq3rJZZiq60nwOTQvrniZQVN9gtmg2W+fF
         LEdL2eGPDgZ3P4+JuGzsmVAR0u2Ly7KFydeuBO0k8JS0C6hax7Gk4tYCUJK8C3J7f8w2
         i5Z8W5v2QwUMnpwDTPhA1IC5o+088vmVLxxD8eWNIP0Xj5ygo+K7zkgvKdO9CjC3dkTx
         LUeA==
X-Gm-Message-State: AOAM530ikQrePZ5K0AoyFRHEODSPYiSGy5TJyM+BysCkrZeXztzV6j+Q
        17ZtEsRhs+U6EaChy9T10y3knV3iaqo=
X-Google-Smtp-Source: ABdhPJwA/UwAnB4fD0YY8a9jVvbYHacsw/euD3ZCtB+VcU83RNu7uuIZq5sPyuS2vkNHyFc+Uy8wTQ==
X-Received: by 2002:a05:600c:5122:: with SMTP id o34mr5226882wms.105.1635156853857;
        Mon, 25 Oct 2021 03:14:13 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.144.165])
        by smtp.gmail.com with ESMTPSA id o6sm2637292wrs.11.2021.10.25.03.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 03:14:13 -0700 (PDT)
Message-ID: <4e53a08b-3cfa-8351-2713-af632a759e88@gmail.com>
Date:   Mon, 25 Oct 2021 11:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
 <YXZeNUVx3cJW/lV+@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXZeNUVx3cJW/lV+@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 08:35, Christoph Hellwig wrote:
> On Sat, Oct 23, 2021 at 05:21:35PM +0100, Pavel Begunkov wrote:
>> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
>> serves only multio-bio I/O, which we don't poll. Now we can remove
>> anything related to I/O polling from it.
> 
> Looks good, but please also remove the entire non-multi bio support
> while you're at it.

ok, will include into the series

-- 
Pavel Begunkov
