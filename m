Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86764C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FB120830
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U4tjuKC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfDJNzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:55:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33276 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfDJNzI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 09:55:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so1628436pgh.0
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KVvJABIBSgcHdfAB8e8HevNW9p1ofcuwyUz+cr1Lv0Y=;
        b=U4tjuKC9ZeW5fd+OHeehMtJJpn61Fa3Dx5hx+cOUkZKJBc0o3y9FPR+XWFT3rrS1RV
         T0N29mgDT2dIeyzG4AdXispRkuufSp8RCYudpPT423bLMM77VgqUTKniHJk1HXZZf7ZQ
         le/m1okqHa6jxUR+uuK+9ELVsUyWhhrtuT6cuvSsUcxF0G3YkvpUN3bbWJYecV1LaLHi
         DZs+y6FwrRKYZzvv8+nTHSAxhd/EKoSsutacPJGccCA6VPV6nMKlcy4SI4TxIy1Ip6Mi
         8OXtP+twWF5W6sfjMduNMcCgjdMAHqQGIvB1mkMoKnobk3JevGuhtDSj69oB2QArOKKr
         BeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KVvJABIBSgcHdfAB8e8HevNW9p1ofcuwyUz+cr1Lv0Y=;
        b=HitsxurUyf1LN9p4hbuFOHq03MKUY4zLg4yVdVVWKzqlglyvINJz0koQ/ERxSkTWUv
         CHeAiN+jNjOplENKcqLB1NfwBBx5EKgs0Ni/cOE+xOfbLfHkPetGHJqPbOJ0JoNjEVq7
         Qq2TSc6D5cIXP6zROh+cUIDMADygYLW8YvX4HaPuujFkJbEyhu+42Rwo7PQnuNg0urU5
         zk/mCfQFLCzJUZTPrW67cpNHKuOIIuZnNKTFpYIrUfvIQeNIC/7kwdKG7d28YedaI/EN
         5mVUx3nMniD0STPx1t72MZ2VReXSJJ6mcHtN5pf1Hkwt099PuzqXCpXswfIxc4yeZ6sB
         4oUQ==
X-Gm-Message-State: APjAAAXtCcUEN9XCBksVly0XKyqSbi5/a4AM0uVCqlddr2uaY124qfte
        jclNM95yjShAJuWKYL8ykQV/3Q==
X-Google-Smtp-Source: APXvYqzA73n9fdV3wcniPIT+XAKT5bdsNpHyC/aj3g1r6fh4Gr0YjmVtPMU1+6yTf2Kex/wkt7S3Xg==
X-Received: by 2002:a63:d304:: with SMTP id b4mr41113150pgg.300.1554904507471;
        Wed, 10 Apr 2019 06:55:07 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d15sm51503564pfo.34.2019.04.10.06.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 06:55:06 -0700 (PDT)
Subject: Re: [PATCH BUGFIX V2] block, bfq: fix use after free in
 bfq_bfqq_expire
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Dmitrii Tcvetkov <demfloro@demfloro.ru>,
        Douglas Anderson <dianders@chromium.org>
References: <20190410083833.14462-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94d03c91-2e4b-6f42-7c99-09efe964cc8a@kernel.dk>
Date:   Wed, 10 Apr 2019 07:55:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410083833.14462-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/19 2:38 AM, Paolo Valente wrote:
> The function bfq_bfqq_expire() invokes the function
> __bfq_bfqq_expire(), and the latter may free the in-service bfq-queue.
> If this happens, then no other instruction of bfq_bfqq_expire() must
> be executed, or a use-after-free will occur.
> 
> Basing on the assumption that __bfq_bfqq_expire() invokes
> bfq_put_queue() on the in-service bfq-queue exactly once, the queue is
> assumed to be freed if its refcounter is equal to one right before
> invoking __bfq_bfqq_expire().
> 
> But, since commit 9dee8b3b057e ("block, bfq: fix queue removal from
> weights tree") this assumption is false. __bfq_bfqq_expire() may also
> invoke bfq_weights_tree_remove() and, since commit 9dee8b3b057e
> ("block, bfq: fix queue removal from weights tree"), also
> the latter function may invoke bfq_put_queue(). So __bfq_bfqq_expire()
> may invoke bfq_put_queue() twice, and this is the actual case where
> the in-service queue may happen to be freed.
> 
> To address this issue, this commit moves the check on the refcounter
> of the queue right around the last bfq_put_queue() that may be invoked
> on the queue.

Applied, thanks.

-- 
Jens Axboe

