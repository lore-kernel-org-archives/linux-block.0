Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E1C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 11:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EE664E9B
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 11:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhBALDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhBALDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 06:03:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1BC061573
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 03:02:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d16so16043272wro.11
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 03:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PP/zMRPoUZIH9Vosxey0IfdNkO5xvEKJgF+rdi0whsQ=;
        b=BuW+JBnxM+cQbuhujz0kFeMcXbLH5lQx/UD/6yASo1+Df2ARH4m1HXeUtGYiEkyZ3X
         CyOeKuc24wkW5276EoGMlVQFExeSjkzWmlPYYVZEeIb6FaoJiiplo1Y8X2Kfn38ymaPR
         g7oIBdTY/VVFDoAFigtZ29jEu4AZZ3FwsthsQ05IvigH099BMRCaGYoPfTwdfEOo/fS1
         KPh8rCem3QOOMC/0oftCOArl3WZejK+cOYjkkI9+EggUKJD+FtsHaxioPKBUw38EDinf
         s7qxDUfEZAH45fiT4BcaqJqthzUH20v0uBXgYBHLD8wa+QFM+1wObaW0Jy/O0lZ9I4A2
         qNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PP/zMRPoUZIH9Vosxey0IfdNkO5xvEKJgF+rdi0whsQ=;
        b=SB9C6vkkFqF6eZJIxQV3UybbxdavSX/S2mmlyF5IFrqTam8CDpSdmlBpy0iNSrDkhS
         rbASF4m0fx/nRgLMPpKQxl1rxlBeVLvGoQ/EAPyrolISyRJg54oZnkCWYKxFyIr74VOe
         UP2AW0BvEb/d3au5SHezRkenumYlV62kHBhKAlNH+Zz3dEWu8qd/e2ZVI0w9jDYGus3J
         TVZqWACJ29x8Sei3xURF2sZhsBo2eRYtCm8z9L6ISkCnt+CwuT7//3aMlfGvqXvnOP3L
         BMN0BJzvzIvEfQsABgX7nE7/kg3PZSKJ+qorrernpsSRejNwaJVKw3D0P+kCikq9QQZ8
         KNSg==
X-Gm-Message-State: AOAM532Hv4P+9NkCZGOLPN181SmHQwcCGaCB9gbj/hkfnMj/hJlalc7z
        oGAuxeGAkoUioevHwKB6Vx4uoJrT7DM=
X-Google-Smtp-Source: ABdhPJwq1VOH2rm15JkdKkPQ22ooA1/5Kc46Z4YZlCIg2u+aDGAFoMBxiR7U6IRL4ovvkpj631vGlw==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr17388425wrw.150.1612177376599;
        Mon, 01 Feb 2021 03:02:56 -0800 (PST)
Received: from [192.168.8.166] ([185.69.145.241])
        by smtp.gmail.com with ESMTPSA id i8sm27926336wry.90.2021.02.01.03.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:02:55 -0800 (PST)
Subject: Re: [RFC 2/2] block: add a fast path for seg split of large bio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <cover.1609875589.git.asml.silence@gmail.com>
 <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
 <20210128121035.GA1495297@T590>
 <48e8c791-fe4a-60c7-aa8b-bcaf0f5562c9@gmail.com>
 <20210129020010.GD1649137@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <d36ddc6b-4c73-174d-2ca1-624fd869c8b5@gmail.com>
Date:   Mon, 1 Feb 2021 10:59:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210129020010.GD1649137@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/01/2021 02:00, Ming Lei wrote:
> On Thu, Jan 28, 2021 at 12:27:39PM +0000, Pavel Begunkov wrote:
>> On 28/01/2021 12:10, Ming Lei wrote:
>>> On Tue, Jan 05, 2021 at 07:43:38PM +0000, Pavel Begunkov wrote:
>>> .bi_vcnt is 0 for fast cloned bio, so the above check may become true
>>> when real nr_segment is > queue_max_segments(), especially in case that
>>> max segments limit is small and segment size is big.
>>
>> I guess we can skip the fast path for them (i.e. bi_vcnt == 0)
> 
> But bi_vcnt can't represent real segment number, which can be bigger or
> less than .bi_vcnt.

Sounds like "go slow path on bi_vcnt==0" won't work. Ok, I need to
go look what is the real purpose of .bi_vcnt

> 
>> I'm curious, why it's 0 but not the real number?
> 
> fast-cloned bio shares bvec table of original bio, so it doesn't have
> .bi_vcnt.

Got it, thanks


-- 
Pavel Begunkov
