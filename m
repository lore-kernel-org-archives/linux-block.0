Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E74EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392AB2070A
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RE+pWIEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgENOGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgENOGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 10:06:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC13C061A0C
        for <linux-block@vger.kernel.org>; Thu, 14 May 2020 07:06:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so1202746plo.7
        for <linux-block@vger.kernel.org>; Thu, 14 May 2020 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhoL/6HO1ChA5Oa8fnvPVyKwLsbEO2mjs/X8Rtc1les=;
        b=RE+pWIEqlIAWGLqoVVtMQ9kJeowfKM/bSS2m9ZpBDj/pGumqBP6hPo/A0ijuBmccha
         w8ZIeZ4r3NucOognCUcjW3stjbA5S8gTCUwHI+g3wlZiupKwh1ac1oTiQiyEAtmrr31r
         HavAg3R1Buc65CMqTluU0sB9vSciF1qJZGpcwXK8KPEaTWZ1vhy6sJtHxTUFLTj8tpo7
         yNxdtq0x77BhrtYIA7EWbgQsJU4nW4hUES5dflXe6wvgoisaAXL+1BHm6mXhJjR81Guq
         OR6Qy69kE0PeMbZsPrJoPrc/ycjEnzz//IrV8EQZNnH/AqZl6friQ5AhmPFO2TXesZEW
         u7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhoL/6HO1ChA5Oa8fnvPVyKwLsbEO2mjs/X8Rtc1les=;
        b=LIgJamr7QQinSdq7sxKQAN0Qirep+arKzEMwmMZE7i61DoXRLfS0Vxu9Z51PCihZny
         ObhS1MmI1tcOPvinm5/QQLoGh6hMrn8kjLzbe0kG+niYlbD6ETm+anf5USORrEPKOdAG
         2G/OVkr7W5ioccQ6mzAbBeEC6PdQXy1DDThlSHXfuzJikA6wZCO/lHLZ/7mLjV9by1kl
         ZMA9ay3UiqvFK+nEsNdC3xURnyMyhPyQq2Y8Pvgo1Gji0Obbdw2qPUucAJamk3RMmUie
         U6HpI7xgclrrkiLZ05Rbd+Vfuw16FHo9EsWGmQotV/HQF3ApL3A9Cq0LWNso8FrCE3CJ
         s3Gg==
X-Gm-Message-State: AGi0PuYf3jPKvVAeq+aNZLEQIQbGwoqfN5Yr+w/zWklgSNg5hU5/UOVE
        9mOMSfNvC087Fp122HzICtpiZw==
X-Google-Smtp-Source: APiQypKBpRCSK6gyqvCtXPNqRpnr55JxsneenMdSB7jkgSuxWBaLzKRXKbV34J308FxYw0nsfW/ycA==
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr39592335pjb.37.1589465200651;
        Thu, 14 May 2020 07:06:40 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:a45a:373e:9b20:39ea? ([2605:e000:100e:8c61:a45a:373e:9b20:39ea])
        by smtp.gmail.com with ESMTPSA id m8sm17824360pjz.27.2020.05.14.07.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 07:06:36 -0700 (PDT)
Subject: Re: [PATCH] block: move blk_io_schedule() out of header file
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>
References: <20200514084509.2117337-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2a52355-f708-3b67-8210-ed614e81ba3a@kernel.dk>
Date:   Thu, 14 May 2020 08:06:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514084509.2117337-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/20 2:45 AM, Ming Lei wrote:
> blk_io_schedule() isn't called from performance sensitive code path, and
> it is easier to maintain by exporting it as symbol.
> 
> Also blk_io_schedule() is only called by CONFIG_BLOCK code, so it is safe
> to do this way. Meantime fixes build failure when CONFIG_BLOCK is off.

Applied, thanks.

-- 
Jens Axboe

