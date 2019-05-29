Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B16C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5821019
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 12:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GRSXKhF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE2MZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 08:25:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2MZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 08:25:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so1512660pfm.12
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wV5GW+wNmFmQBPj3TgKe7/OIT+MA0KFJOxyQzNc+M+U=;
        b=GRSXKhF5vslMGQUWp0fUQDsgXLlCWLwv3OqZNVf4y8QsY5R3Cez3BPqbz1Kaqxic1J
         BkGxDkmlOFnuWy1KPC9MX2t7kI+t1uHgRwGFcgZYRCjU8rDUPPgdMkhRhTBxUYcWjKGW
         jYm7WojpSn7u5NpkAmbNz5y1PRoBNBHkFgnw/XBVGMoFOWcA5LqR0dQTiJxsWSD+bw9J
         hTlWD7Hp4lHObAJlRzXs14PebjLLRtLwb2qloR3BhjUNQIizqGb9rkxwYyHP7KG3Sm+O
         aOZrufvPUTAFgk5b8/mQqGzuCUAGUPjoUxAHPoyzlkv4E8ZjqoX+LYm8XOHfGNfJIHec
         OhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wV5GW+wNmFmQBPj3TgKe7/OIT+MA0KFJOxyQzNc+M+U=;
        b=OVa8TERnsZ8I2EQJ5hLLbhVZdciooF6ZRfZDlS/ziV5FwnoW+PyhEoj9PWDbo5Kab/
         oCUZsxnD0G2KXCHEf7O3z0Rps7LXXoe7dgKfuEszMFASt6Ncu6O3Buef9wbv/qOblmt3
         ddisxc5dv4o+Oo9oxoBvgW4rKAuKaJ/IYKMzZo7XN1rgFyOegl9yj0ZZ7C7DH7iNR3LF
         ySOAoKMhPgoPTQblRxscg+2THlMvQPe9IDfSyq4EiDpdOj95N8mE1359Wja+podcjqrx
         rKxblB/EsW0ZFigXi1BNZWfrWa2tR/pdpsYN/gwT5yptYCv0v9AR0X0wPFkZDQrlzoK2
         oJ1w==
X-Gm-Message-State: APjAAAXbT0dcxRMFn5HaEqamS2E/xFmqtsamxfnxZLCdQvH7WqSNmg6K
        MulmbirQ1P7/xmmFL3ZBx2TOaCm+oxBLGw==
X-Google-Smtp-Source: APXvYqywo+rKxpNyhEmgVwGhXZfljePVQaAsy0Ry1wC/rK/m6ky6i5fB4oqIJKQ7fGJfZ2+2Q7zx6w==
X-Received: by 2002:a65:528b:: with SMTP id y11mr137200696pgp.341.1559132712261;
        Wed, 29 May 2019 05:25:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i22sm17596272pfa.127.2019.05.29.05.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:25:10 -0700 (PDT)
Subject: Re: [PATCH 0/3] block: queue exit cleanup
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190515030310.20393-1-ming.lei@redhat.com>
 <20190529065201.GA3728@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fac85b3e-7c8c-5e85-63a9-e4198690a092@kernel.dk>
Date:   Wed, 29 May 2019 06:25:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529065201.GA3728@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/19 12:52 AM, Christoph Hellwig wrote:
> Jens, do you plan to pick this up (at last patches 1 and 2)?  It
> fixes a NULL pointer deref and a md raid issue.

Agree, applied 1-2.

-- 
Jens Axboe

