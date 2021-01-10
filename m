Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCCC433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087E823B16
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbhAJJVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:21:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E9C061786
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:20:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so13223890wrj.7
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yXJgaZ30bCNx0d/Nlv7SzE2CGcAUZbD7YijRwA9pDuc=;
        b=KcG/JlQ1+2kflGk/GLZne91f+IwXGVmTDbqrofWVm0guNBr0W5phMkp6tYvgwNnZkv
         rl/hmn/Lh+msvNs8XA4hJNsceTeFkhyz+e7IIH84kj2llNqvFJ2gbTcV3U4BPHfJxi1M
         JJAuo1R0MYAWyFpbcChXP+LS0XEwIffYeRFZ+NGxJ+RFlVcWXo4gRDOo+2np3jpaeab2
         9Wr7a2sSb6J0JZqZ6EMIm0A5mf40OU6ifMUGQgULcw+tPrEt+WqvP3sMtad/JQyj3yR0
         aSrYPQ80pePZ0yjmaHWN9Xsy9pZSfUXYnBKkiqg0wxFxTmi0WzbFa1JaYfPsZQlD33Fz
         W4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yXJgaZ30bCNx0d/Nlv7SzE2CGcAUZbD7YijRwA9pDuc=;
        b=FkQwaxFESzXM+auOUSVNY3kIqSkRvkZrJZNVhLlrU+bygFm385wbPgw0tjgOSxl7XR
         wXOdk8axo850vdvsv2rvQkRP3jVrKijgPVsmbE8h2Nv5j+igjSA9BhEAdQgj/8T9+a8P
         ePLlWuuYj/BWGPXZKv/wQnV0zzrSwCi95UMdHMvx1Q98TFdzDePQsFTcxT3nuLU7TXUa
         cpuaCXQIb8WR51qj+HAKikMjcS2KqrcLgfj1+ba6pGiMorvUNg7NY6ADshdboB3shAEs
         fUoEhYbjJ6yPfDTscCn4TMAkq4gbVJ+a6Urgmr3Y6HScbft+SkNXJJ9Ti+eLqOY9rgcK
         zDQA==
X-Gm-Message-State: AOAM530O6Bj9PLWVJVFMkesY4Tz8mpk9rvHoURisZtN2uYeHLmYou7O1
        KzMMvXEJozh3UGYCHDGO5fQ/8v1bwBN+gnX/
X-Google-Smtp-Source: ABdhPJz+wMrHI1zxHOuLW3hqAjg1B0eK25hoV9yGmUvQVlBdNW6AsiNPbo/m2jj7gzHm9p39vHvgBA==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr11268569wrn.316.1610270421575;
        Sun, 10 Jan 2021 01:20:21 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id f77sm17485617wmf.42.2021.01.10.01.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 01:20:21 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] bfq: Allow short_ttime queues to have waker
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200409170915.30570-3-jack@suse.cz>
Date:   Sun, 10 Jan 2021 10:20:19 +0100
Cc:     linux-block@vger.kernel.org, Andreas Herrmann <aherrmann@suse.com>
Content-Transfer-Encoding: 7bit
Message-Id: <9F84671F-5B43-46A8-8D92-FE30F6023F94@linaro.org>
References: <20200409170915.30570-1-jack@suse.cz>
 <20200409170915.30570-3-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 9 apr 2020, alle ore 19:09, Jan Kara <jack@suse.cz> ha scritto:
> 
> Currently queues that have average think time shorter than slice_idle
> cannot have waker. However this requirement is too strict. E.g. dbench
> process always submits a one or two IOs (which is enough to pull its
> average think time below slice_idle) and then blocks waiting for jbd2
> thread to commit a transaction. Due to idling logic jbd2 thread is
> often forced to wait for dbench's idle timer to trigger to be able to
> submit its IO and this severely delays the overall benchmark progress.
> 
> E.g. on my test machine current dbench single-thread throughput is ~80
> MB/s, with this patch it is ~200 MB/s.
> 

Hi Jan,
I've modified this logic a little bit (in patches that I'm going to
submit).  And I don't see your boost in my tests.  So it's difficult
for me to validate this change.  If ok for you, you could test it on
top of the patches that I'll submit.  If you see a boost, and (as I
expect) I won't see any regression, this improvement is very welcome
for me.

Thanks,
Paolo

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 18f85d474c9c..416473ba80c8 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1928,7 +1928,6 @@ static void bfq_add_request(struct request *rq)
> 		 * I/O-plugging interval for bfqq.
> 		 */
> 		if (bfqd->last_completed_rq_bfqq &&
> -		    !bfq_bfqq_has_short_ttime(bfqq) &&
> 		    ktime_get_ns() - bfqd->last_completion <
> 		    200 * NSEC_PER_USEC) {
> 			if (bfqd->last_completed_rq_bfqq != bfqq &&
> -- 
> 2.16.4
> 

