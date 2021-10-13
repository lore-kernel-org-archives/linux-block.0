Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054486115C
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 14:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhJMOne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhJMOnb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 10:43:31 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CAEC061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 07:41:28 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h196so3281791iof.2
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N8w05oFbWFAKCVP+4JWSz4RxyHp111NubKrEF9wnPKo=;
        b=Myav3CG0zG04zE12d6m6SVr7/m0adi9m4yMsK2J7Eaj/X7c8Xdh8yYg9DBENVcOtn/
         Uju1XHf7s07kXg616ul1um7FHNEwbbuxUxP8Wi0gVlvEluvUjxIM/1Dt9bN4du2xdX+O
         MQQcyL7tisqYvgIa8IAW11892BPmXM/6R78WHD1WEHANp3yIubG/L8D0e2B1kiWrr9mH
         dzhY1y224aFyvPOAZhG5j60FNDRba8UdCErSaFHSvi4eJC4AJ3CAaLjzSA4lhL5czW+A
         vCe51yDgrnd9fETvNZeEvr6kbiXIREbDfy7TugKMeVqY1KvW4quVlERwtPdTSBbnIl+z
         iE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8w05oFbWFAKCVP+4JWSz4RxyHp111NubKrEF9wnPKo=;
        b=lnapF87F/+/6SDnL8DjqN1Qe8hfW6/XrL6vwe28sXlD7rRO9eHepnADNvgIuBpVvgk
         a4ztsSB9stvMCmiI86eEUlUt5hkOX95rSWZZD+315bB7jmJ3sWz3u3dbEJubRIouoS+A
         q5FSMkElf7awpUjol6MZ1I+cl75MutJxGTuPFO/wceoGixJaQCe0m1XngA2bzlTi4Vn7
         qx744p/wDA8c2mBXn2FYVIn3ECJ90oOmNjNWhEUo15+ZE0BeT/3QRr1ofNvBf4hLew30
         PfKANH7SGbLGuXmRcrMV5SxfwylS5ACEA4qKcOpXs7MfkSwoQwO7lDK3RViExZg5FR6N
         XraQ==
X-Gm-Message-State: AOAM531k4lKB3CFrAjuGFxh/EpMQk8V6DB4YMSMK9V0HkYaGkPph5m1J
        m5eCu1sMd1tOirAa9TO/6XHR5xP0zyLVVg==
X-Google-Smtp-Source: ABdhPJwAQWHVgfXcDNmIvOl5VZ5cHRfQm/2paaeVAg37P91R1vJ9/R0PNySzfpWqhnl7sVhGGiOPdw==
X-Received: by 2002:a02:c484:: with SMTP id t4mr22699476jam.37.1634136088080;
        Wed, 13 Oct 2021 07:41:28 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h5sm7127030ioz.31.2021.10.13.07.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 07:41:27 -0700 (PDT)
Subject: Re: [PATCH 5/9] nvme: move the fast path nvme error and disposition
 helpers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-6-axboe@kernel.dk> <YWaDQiwoo/vjNXxZ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <044549fd-b3eb-cfa8-b687-42726c2ed08e@kernel.dk>
Date:   Wed, 13 Oct 2021 08:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWaDQiwoo/vjNXxZ@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 12:57 AM, Christoph Hellwig wrote:
> Please Cc the nvme list for nvme changes.
> 
>> -static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>> -{
>> -	if (likely(nvme_req(req)->status == 0))
>> -		return COMPLETE;
> 
> I think the only part here that needs to be inline is this check.
> The rest is all slow path error handling.

I think I'll just kill this patch and check nvme_req(req)->status in the
caller. If it's non-zero, just do the normal completion path and skip
the batch list.

-- 
Jens Axboe

