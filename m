Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05AECAAD3
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 12:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiIAMKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiIAMKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 08:10:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A5E42CF
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 05:10:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y127so17306149pfy.5
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NVrLH3Oi0/SJy5yAisyEMC8qxmGPGgPjz9UGUkOyfxA=;
        b=NV9NczHWj74G5RzNcGpY1lxRtZM9Z7fvBmj78EA12YqrODVT44YhiZBUEwIYtvLdqB
         mUcbceIckaLRSiMd31/7kfP9LEnD0thbHFRs379svT68Y4bf6MhOr2umwnlUa5M4vT7J
         P/HKb/VeiqSjLbOklR/lNM7W0jEJSn4vilsyjgemPolUwSquWnIizRB5Uylh/Z87m17M
         5Q720m2d1FGJcivZTW7+WdakVn6p3rDcFbGdneexxcrmqO5gcHnaDfWeEtySxPnoQ92s
         cZxNiPVIWCTtL7W3yLnpdTuCf43c0uWqFk4y0PpExkA27hmToYG59xajfBcgqJotUd3G
         8/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NVrLH3Oi0/SJy5yAisyEMC8qxmGPGgPjz9UGUkOyfxA=;
        b=NDZckF6ZBRjgTIPLW4gCS4OF3ORCR0zXmwb2MutLwKQvhpj/r9RTBdLjK4Ty+syL4Y
         xbSk9EaRc+uqE72VuyjGY4mo6UQkoKzTIJCGeWuO7NIvM7l3PVfTBIvqyOqpPSLlBug+
         SFjYnMshIm+9PWgnPLMza1QTiNlbXoM5jTxi8u2nFnL5pXcu8AToqlCM5wY/1XbfSxoN
         vvk6DsDE3Ka12O8ozmn2ae8HZmqxYs/9EsjkiIsUnsXeG6s30IsXZN73DoRdYDqVd+GN
         m+Gf4QQhkLfmcUXtRfbD19EIVj3VmR04EVUW8TCPvW4GlaMx2t3Ueu6QbpVv9yDUstaQ
         tlSA==
X-Gm-Message-State: ACgBeo09ReSm8/sM1rS1rPpBNRXTl0GTB3hsHAQ4Wwd+OU2tkhNco7u1
        02pIEY4PIqu84uc2KOzR7vM=
X-Google-Smtp-Source: AA6agR5ljURyrt+6we3iVo6Ud8+Q/yN6WMa8zAfQ0n7ZeS4ZeEPh4RvXLiMagEULytdg1PWMktvZJA==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr26273760pgj.539.1662034246609;
        Thu, 01 Sep 2022 05:10:46 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id bb5-20020a170902bc8500b0016db7f49cc2sm13526490plb.115.2022.09.01.05.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 05:10:46 -0700 (PDT)
Message-ID: <05447371-bbc3-7b5f-9060-d27e3f5398ee@gmail.com>
Date:   Thu, 1 Sep 2022 19:10:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220901023008.669893-1-ming.lei@redhat.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220901023008.669893-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/22 09:30, Ming Lei wrote:
> Add documentation for ublk subsystem. It was supposed to be documented when
> merging the driver, but missing at that time.
> 
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Seems like also forget to Cc linux-doc list.

-- 
An old man doll... just what I always wanted! - Clara
