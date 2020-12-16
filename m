Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A045C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E5E233CE
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 15:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgLPPWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgLPPWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 10:22:22 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43DC06179C;
        Wed, 16 Dec 2020 07:21:41 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 2so7571282qtt.10;
        Wed, 16 Dec 2020 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTJEIFfXmE7r1WzgPDDfxuwJ1vDzxVqAGMd8dIJWkqg=;
        b=RHINyEilxFbQ2dMUhCn4il3bqkR75NLZBoLqvyWMdAlsGs8dFiPTilCHeYEtHnU7o6
         WXivhsb9UTWoGU0EbbCPdfdF6IazN+BPd0fNwxd7/Jr1Z2l+1VYbkvECoqypY2Ml3gCH
         0rDKcid/tAhBlTgJUnGD1DF/+yocFbf9DhDTP/5WP0jvIctXrtfEttnmuVMsTtAFChbA
         zoM7tl2ORn4JMvk0L+n9roKII9GEe7HJ+hLzMq59NykeLj+MQe8RXmjIUxwt0lMxNTGk
         rEzWS9yZEryfgohy7zW6IdesWmpy5lAe3u/J6472rK151b27j1CHAUfg3Hj1uM0YFGp1
         rxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yTJEIFfXmE7r1WzgPDDfxuwJ1vDzxVqAGMd8dIJWkqg=;
        b=HclDaV+gwXwU3KkDgpElOdLZp3Z5V3gCQrY+pZOGH0giaxDtc30SeJPd5ldgeBuBUk
         rfcTL/FLuiJgu7p6Xt4c+QvHZkM0nxZopg1+nx+JhzpVYYtxI93agW4IaexIFvNQe2SN
         TH3YOMe8vyMBt5nlIlaKoUHEk7ZCe8ZNmZX/6TVz6GXBdfKkIdbT3u+Tnc2cN5nDkQHP
         7MV7YO1zpic7ts2ni3/X4J7dqbknx2H7taQKEp0tBJpX1r1tU3B3ZJ6gi6PIzVGFpOfn
         hw+FnryhdpB4t+20DMhmabrnTT7lt+TyUVdeXpF1OEQG/MhNKZAmW7mFlu1+UkTibutH
         yS3w==
X-Gm-Message-State: AOAM533G0OzR2kgnrbei0ezmDs7oxZatzHJ4nOvvPzjDj93dVgQMOAEM
        3cb4DD4QHjf9GdmhFBlyj7GE9BOMNV2RCQ==
X-Google-Smtp-Source: ABdhPJwmJgJHwe2hsYK48BoUi+lAmB4B469oaZDaQnd/Etj04dkkrOT1WqjcXuq8zkylZ9PfCBZi3g==
X-Received: by 2002:aed:36a5:: with SMTP id f34mr41791784qtb.1.1608132100968;
        Wed, 16 Dec 2020 07:21:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cbde])
        by smtp.gmail.com with ESMTPSA id p6sm1167951qtl.21.2020.12.16.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 07:21:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Dec 2020 10:21:06 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-iocost: Use alloc_percpu_gfp() to simplify the
 code
Message-ID: <X9ol4gE65kD6qIyh@mtj.duckdns.org>
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
 <aa518c5b5c7185e660a1c8515c10d9513fe92132.1607591591.git.baolin.wang@linux.alibaba.com>
 <X9Iv/MlqQI00wZRn@mtj.duckdns.org>
 <33480f8a-89a3-3ed9-6fd0-95b2944ccbdd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33480f8a-89a3-3ed9-6fd0-95b2944ccbdd@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Fri, Dec 11, 2020 at 03:13:29PM +0800, Baolin Wang wrote:
> Thanks for teaching me this, at least I did not get this from the local_ops
> Documentation before. Just out of curiosity, these local[64]_t variables are
> also allocated from budy allocator ultimately, why they can not be
> initialized to zeros on some ARCHs with __GFP_ZERO? Could you elaborate on
> about this restriction? Thanks.

* It's highly unlikely but theoretically possible that some arch might need
  more than raw value to implement local semantics.

* People might wanna add debug annotations which may require more than just
  the raw value.

> By the way, seems the kyber-iosched has the same issue, since the 'struct
> kyber_cpu_latency' also contains an atomic_t variable.
> 
> 	kqd->cpu_latency = alloc_percpu_gfp(struct kyber_cpu_latency,
> 					    GFP_KERNEL | __GFP_ZERO);
> 	if (!kqd->cpu_latency)
> 		goto err_kqd;

Yeah, the lines become blurry when all existing usages are fine with zeroing
and we do end up needing to clean up those when the need arises (e.g. we
used to zero some spinlocks too). It's just a better form to stick with
initializers when they are provided.

Thanks.

-- 
tejun
