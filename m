Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4873CDB482
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjJKVU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjJKVUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0E90
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a2874d2820so5012139f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697059223; x=1697664023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou8Z46f8D4HFatkbCIXSPvYGp0xJZP5BFrXKyDUAkb8=;
        b=UF0kV8pV6PLXJQZTfcAz8fMCCu95vvysIrVgLfw7KXN6b+rj1fvrGma2s95TnW+b4o
         dTo/1+BaNzpFZQQfebrQlIVn7wv8cTzUa0Lq2kGNOmHMinMMhpTThQG2TQW++IuRBDQr
         syji2/W3mWJgdaPef0BtqZhZuxyGfjDKlHAo+DbDFXRYhS+mMGswm64OTTnx7ZLk45gi
         HYC5Gm/vpdwTLHyhZvbLFQTjHmf5a/ckf9F1fcoRJH/0mM8C0UlyveM0BkAThZaZVdmM
         LU4H19B3lae3+MmmgCmTI4PeQsrxfkzqZenH43aFTuPii9wuPQ0GRmxjg5gVqnSlqezc
         ttuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059223; x=1697664023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ou8Z46f8D4HFatkbCIXSPvYGp0xJZP5BFrXKyDUAkb8=;
        b=uZIPMKfB5e017qPonqSCV46QitgLEhsDYSn/Uya4BWAFqTMM8yCxfYQ9hxT1N0A5HE
         bZ4/CoraaxEVc9M+bBzojiw0E8xeH20aYe1VIEEBlyI4iX+KVw1x0jdbLmPR54KtLckh
         s54DfHnMUDCCiOn9fL4Ty9tb7yvs54JKEkAyLV0ON1RhB2J+Gy6sHztV5+tqxNGN0sVD
         iwil4dbncMvSovGDkEwmOfNxpU49/imec0JC4XTWp/f67wq893e5aJ+NjZS4UsKswzM8
         5O0BUw+YlgP9QgOCFvEp2q+QG0HZbu0/GMCGV3WvNwfGd5Mxv6c1mHHRVbDls7ZWL6CX
         cZIQ==
X-Gm-Message-State: AOJu0Yz8y1oT/NKfU8rA9/t/D7HhwV9FT/5bNYuPicqajA44QRtM8REv
        PpaXHDm7CKVYTYJNHVNg2aexZxRfQ23Luf/y4rukCA==
X-Google-Smtp-Source: AGHT+IFDYfOpCNUhep+7IgWh6NGfsroxNM+d8ImbLUEV1kcWszBBlrRw4fvIGqhVskXuEnZ7Ig6CRQ==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr23781388iob.1.1697059223057;
        Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c18-20020a02c9d2000000b0041fb2506011sm3547225jap.172.2023.10.11.14.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:20:22 -0700 (PDT)
Message-ID: <c337dd4f-e363-48d1-8ac0-a62da3e1a741@kernel.dk>
Date:   Wed, 11 Oct 2023 15:20:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
 <ZScKlejOlxIXYmWI@redhat.com>
 <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
 <ZScOxR5p0Bhzy2Uk@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZScOxR5p0Bhzy2Uk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/11/23 3:08 PM, Mike Snitzer wrote:
>>>> Also, please wrap commit messages at 72-74 chars.
>>>
>>> Not seeing where the header should be wrapped.  You referring to the
>>> Fixes: line?  I've never seen those wrapped.
>>
>> I'm referring to the commit message itself.
> 
> Ah, you'd like lines extended because they are too short.

Exactly, it's way too short.

-- 
Jens Axboe

