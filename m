Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2C0C001E0
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 21:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGaVBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGaVBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 17:01:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65D1BC3
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 14:00:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b867f9198dso7452825ad.0
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690837259; x=1691442059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xk/+g7frfPfprivbp0LBMO3SR/isu0odW2aNrR0rUDc=;
        b=tEo7VKfO/KEoQg+Y3PFBgTEeRgrNJNJYXMEvXv/sajvyfEybfCY4Vl8/ZOkW4+y6MQ
         x+KQWcBm97AR7Po5m7c1UnIhtvtNiDw4tKH6tsz2Cw3qT3/6o6iIxFP22kZALJyYaZmO
         OYiPmJZxkhw7zOFtspLJO8C9wylnR0C3LDowws6tIpG+xm+Zp+DfJcZwe6aAgOOa5u51
         FPJSzTRTuHj0BvS9CZ48a5W6c/YAHpW1VF9OSyD/ZRFLhWe/IeS+Q31b/+JqyuNZG4JD
         unEQZChb7PnLH0jlyApUlbqVO2cpNgBim5XKGJZJlwoBet8Lx8pjoX4Xu9rx7HIFme8i
         6R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837259; x=1691442059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk/+g7frfPfprivbp0LBMO3SR/isu0odW2aNrR0rUDc=;
        b=g8goyT1fruuOnpAA7yxd39Bsi83VcVBv9XB2wwBupqGMgt5CBwtqIfY+ymPAOMFIeV
         aXKlnf0+aXv5cY2Decw9GeTPGwDBGCeHLkEbkiBpMsnUJqrEYjVe1m2g4E6kWvYRBHBC
         OBI3sz5h+lk1YVSWpUllz5t3cSFydd0RtzyF/salbCtuk/LI0ADqiv3bP5cxxTRXUz9q
         Lx39u0zAy7xAERPDZknilC8VAYLeXXoCgouFnCLE07bKkDFkDL639C65eajtWlmRS2Gw
         U07WUYKsKmhiqO9oNzX6K0pHh4wtH20c2f876fnVp3TVTwANnXEpUYsZypAgpcOWLviV
         R/0g==
X-Gm-Message-State: ABy/qLYA05MXO75WJl3ESMlp51rOFAmDP5wRbkxif+Khx3gbfvYiqv4j
        he7001sCySVoS4Hg+PNdeAonIw0qSZwmjUj/me8=
X-Google-Smtp-Source: APBJJlGX3izugUaKA3YCpQ6crLrWprxMPVnvrhBbLoZKZk27UKt2riYq3YvoNDSQNse20pLazNG+Mw==
X-Received: by 2002:a17:903:22c6:b0:1b8:2ba0:c9a8 with SMTP id y6-20020a17090322c600b001b82ba0c9a8mr9924948plg.2.1690837258999;
        Mon, 31 Jul 2023 14:00:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001bb0eebd90asm8971128plg.245.2023.07.31.14.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 14:00:58 -0700 (PDT)
Message-ID: <22d99997-8626-024d-fae2-791bb0a094c3@kernel.dk>
Date:   Mon, 31 Jul 2023 15:00:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] io_uring: split req init from submit
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>
References: <20230728201449.3350962-1-kbusch@meta.com>
 <9a360c1f-dc9a-e8b4-dbb0-39c99509bb8d@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9a360c1f-dc9a-e8b4-dbb0-39c99509bb8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/23 6:53?AM, Pavel Begunkov wrote:
> On 7/28/23 21:14, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Split the req initialization and link handling from the submit. This
>> simplifies the submit path since everything that can fail is separate
>> from it, and makes it easier to create batched submissions later.
> 
> Keith, I don't think this prep patch does us any good, I'd rather
> shove the link assembling code further out of the common path. I like
> the first version more (see [1]). I'd suggest to merge it, and do
> cleaning up after.
> 
> I'll also say that IMHO the overhead is well justified. It's not only
> about having multiple nvmes, the problem slows down cases mixing storage
> with net and the rest of IO in a single ring.
> 
> [1] https://lore.kernel.org/io-uring/20230504162427.1099469-1-kbusch@meta.com/

The downside of that one, to me, is that it just serializes all of it
and we end up looping over the submission list twice. With alloc+init
split, at least we get some locality wins by grouping the setup side of
the requests.

-- 
Jens Axboe

