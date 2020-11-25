Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A5FC63798
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E9206F9
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 18:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qK7mydwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgKYSMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 13:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbgKYSMN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 13:12:13 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A00C0613D4
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 10:12:13 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so3056194pfu.13
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 10:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fTEKA1BMnqAP7zyIDbxBxAhXdG9fLKBB1cVyiZbdIk=;
        b=qK7mydwfThuEnHCeCqtsAec7PjmKPgL006jyoRQUHxhQEzYX+v3i8lrsi4NLokEEOO
         2U/+qVQm9hgjSY9fD8BTvL6bBIefJ+o7tDJUUy3mymwO0VFTWNLWC7noIUr0jP0rl/xl
         XabZauDW8EaoIhbulQIbQyZFhLcw5KpEFnGnTtN/FMfB8KNLUKxooQnIxjGCpYTCyvUO
         SxhhVaT+OITiAuHLzZH3IZwCBfgrMDL2Qmg+ne7fzqxkhTPRTS1zJ9tHeSs8SJ2vJoyB
         t/bZOTzF45Zv/YLXfH3CzFehdxjhpEt4aoWsb1K3ogSDoRYBOaz0nA3txU2Phrk/0SCO
         SwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fTEKA1BMnqAP7zyIDbxBxAhXdG9fLKBB1cVyiZbdIk=;
        b=s/6WarSVqsJ9IpBIDf/KOk/a+GIB4oq4bT0wCSBdVQQiZHA7F5OUgT9NXFgFVqVhas
         FQCOR123e1UE7iIUk9G2Rnn2D9ikZORU0S7dWX/6Ow+emqrn3w/3zPijdzaZmnbVVC8I
         5m3Lo5mPqhfBYzD6LdKdBOfo1H1oR4Q6hholth/2JCTW5xI++Pli9aWDrlg+qtRcI4CJ
         v94KZWqpzOPFcnn7++QU0qwMyxuPPsTOPCV6S9IUSlcF4ZTbohIV45cx5+SgfxIK/eYr
         QGQmc/RyqCNckJp7VLlupdfhc+mfqdwr9STfHYc/s4Y9RowSAX9aXJu6FghApapgwfoq
         vVMA==
X-Gm-Message-State: AOAM531Wg8Gu80aZsGI4uw7HAzIBf3iFTQ73iaqm3LqI6phD72sBgCRK
        mKIvAGaj8XiuSY9sYbuPNmiu5NTWNGZrIg==
X-Google-Smtp-Source: ABdhPJxMcVFdDN6YNX7OtkH8nV+bfaC8jrFj8a32FW1Y5/fvpiESvMPLvlFD6Cj4vMf/zHD7iOHVNA==
X-Received: by 2002:a63:8a42:: with SMTP id y63mr4054002pgd.364.1606327932905;
        Wed, 25 Nov 2020 10:12:12 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:ffc0:fc77:4500:e880? ([2605:e000:100e:8c61:ffc0:fc77:4500:e880])
        by smtp.gmail.com with ESMTPSA id s21sm2588977pgk.52.2020.11.25.10.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 10:12:12 -0800 (PST)
Subject: Re: [PATCH] block: remove unused BIO_SPLIT_ENTRIES
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20201125065817.34148-1-jefflexu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e4cee43-dec4-5f03-a2a3-603c21c69d31@kernel.dk>
Date:   Wed, 25 Nov 2020 11:12:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125065817.34148-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 11:58 PM, Jeffle Xu wrote:
> Since commit 4b1faf931650 ("block: Kill bio_pair_split()"), there's
> no user of BIO_SPLIT_ENTRIES anymore.

Applied, thanks.

-- 
Jens Axboe

