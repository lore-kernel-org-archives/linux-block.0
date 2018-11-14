Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F9C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29C62089F
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c/EV8r9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29C62089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeKODU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:20:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44423 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeKODU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 22:20:59 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so6755392iod.11
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TELA2/5WnTM5m/eMx9fHO6d5FlbNukZpVnv7IOnOzIs=;
        b=c/EV8r9z5sT0hy+UqFNxfDBx/inOvXGSP0ty6rR5N0TO3Vw561WXwtnQaVf4t+hVkB
         hqRGUyoOiK5OZZ8Ay98owuD3eRKLYbXit+xvczIcwX8hd5HvXBATi706i99NWjOvurU+
         2vbhVTCIez1bo7qQznlmaYyn/RV/SQrJlwQnp/+wnYh82JyBj9IhRuCwwH4OW2Wn7w38
         B5Va61bB74yCbaBP1O4amkOK+A3VKVSE+Cfw+d6yd9CZ4KXCyvFH3Ov90SkjjiLEBAMH
         QH0UI3DXBLJhGiPlyjiXzCpoMILIOpjpX4gR06latHPeRB+vKygdASKwgAP71rQraiXp
         xDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TELA2/5WnTM5m/eMx9fHO6d5FlbNukZpVnv7IOnOzIs=;
        b=im2HcQqGNVqUJB1lOodvp8CJnfgdS3Th+rDmSe8eGxseyj9NYhF6z7mFskcCqimUjw
         +q/YFT+WPoUfaqtPI2/SAiYdBAbM+Iz0CDyf6meN0YBP30sVIVUlEEZ2EmAFQjCuWZtS
         vTS0V4T4ldbXH1ybBR8x8LsuQQbU1mDKkxQyI08UFuKadu0pjet0ztAKUnWtWkNg0Mvo
         DgT/oW0JrjpC17YaFV4ob5AI/bxrkod/UsdM5CpZ/2t5S+KRcJFE8mZU3xb57HGnjW6p
         T4fMX6vHTnE+s1dfY9KTCxg4uvZBVekkefLOucrPCJAchXraiTZ62sCRrZSpobXbkWMh
         p1hw==
X-Gm-Message-State: AGRZ1gJjsga84o+ZZrsPlBGxherMOK4DzgWD5fsojzTotgMqBDk7exTC
        kFPwJFgiVtgZgMj6I/XrrM5dip1lzfQ=
X-Google-Smtp-Source: AFSGD/V4kUWaqSL2Nvg9JoAGDga46RV7OlfxH63MfYzrzm4Y9eI9cbE88K3cvbMYDE3pjhmzH99RVQ==
X-Received: by 2002:a6b:ee13:: with SMTP id i19-v6mr2183987ioh.69.1542215814835;
        Wed, 14 Nov 2018 09:16:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s203-v6sm7798094iod.31.2018.11.14.09.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:16:53 -0800 (PST)
Subject: Re: [PATCH 5/6] blk-rq-qos: inline check for q->rq_qos functions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-6-axboe@kernel.dk>
 <20181114152132.GB22186@infradead.org>
 <e81bc8be-cbb6-6f78-c358-32c7eae4e454@kernel.dk>
 <20181114154043.GB22811@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a167e828-ac45-717a-7f77-52a9be670e5f@kernel.dk>
Date:   Wed, 14 Nov 2018 10:16:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114154043.GB22811@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 8:40 AM, Christoph Hellwig wrote:
> On Wed, Nov 14, 2018 at 08:33:33AM -0700, Jens Axboe wrote:
>>> The inlining sounds fine, but please do it without the obsfucating
>>> macros.
>>
>> Why? It's a lot of code duplication.
> 
> Just source code, not binary code.  And remember that humans want
> to understand this code by grepping it, finding it in source browsers,
> etc.  And all that macro obsfucation makes it much harder.

I've changed it to just spell them all out.

-- 
Jens Axboe

