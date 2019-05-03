Return-Path: <SRS0=mx3V=TD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1CFC43219
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 16:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE720652
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 16:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdGbzTGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfECQHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 12:07:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41300 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfECQHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 May 2019 12:07:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id c13so7275026qtn.8;
        Fri, 03 May 2019 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u9+1pRMtVZijVpiKszv7DYjENOttF/3UpYG/lhu9aP4=;
        b=JdGbzTGUFbHdXLm7puwN/iICE9nKC2sZMxj/D1oHxduCwfjPZl5H8vlkonIf0Rbycw
         aJVJwa9mopANbwfvTHqNCJbLcN+A+M69WiUjzFZ43aGdgqLaBJTYSGGrqC+/u7fNBzc7
         a5QD6Rlh9hkstwf4OXp3qw/e6VllGgfuKYW/KjGiPMqn3zPUGaVRHYEoR3I3Xjc1pwt9
         zzNpmuxHGEjjwb0GMzYWnIMBoOu2+mBDuOtzkYH+rnjbyUkTmUn3w2jx7bAZQIrp8L7c
         8CxIqMdQ1YlOb5MqWCs2vMMxhWJATIC56P7oOGpZ7sFOvwPmwIbjz6NroW1aNt4pe2sL
         wZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9+1pRMtVZijVpiKszv7DYjENOttF/3UpYG/lhu9aP4=;
        b=Q43e44drhcs6d2JaYQ7YZdlK5jvYp+sEOKO1bb0TRmp0k6Ad1NUsUH7jFiTwXKV6ee
         qtigMekkCAg+enrJk4Xv5gTiHkGB/6wrr2OBKuneu/ieXOAQ7o7w4IHOV5Xd/70OZbk0
         sgCINHCr6hMWoRs2V2ILvE2RZBsATf0G2hXQ2pJWaZXwlHX7tiHvjtlkqTkkqXafwR1x
         xL1jeohaKLeSDhOA1FOB1v1r6YudYxP9gnM3JTtUs1/t9P8WKbny88/7/AlCJNpsetnf
         yXfwUlru4IFTafn4z0EyNKfRyAPM5LUZP3N8ZNi0ARXMVRqvDQTjhNvxnG8bY0vy8GIB
         +mFg==
X-Gm-Message-State: APjAAAWfpompDOPYLQcgV7e9e0RAe5XwbAi7GbTct8LMaKfRhr+ugO5K
        s5II5lrMiYkGApgfYU8nK1M=
X-Google-Smtp-Source: APXvYqw5Xx29unL51N1wn1N2DADKp9ewBxfgsxxXMlV5+tLdMjvpOsZXQM+Jky1w1Z2AKELfnC7DWA==
X-Received: by 2002:ac8:35ec:: with SMTP id l41mr9512125qtb.109.1556899639519;
        Fri, 03 May 2019 09:07:19 -0700 (PDT)
Received: from laptop ([177.96.40.190])
        by smtp.gmail.com with ESMTPSA id m24sm1421455qka.83.2019.05.03.09.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 09:07:17 -0700 (PDT)
Date:   Fri, 3 May 2019 13:06:53 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya.Kulkarni@wdc.com, marcos.souza.org@gmail.com
Subject: Re: [PATCH v2 1/3] blk-mq.c: Add documention of function
 blk_mq_init_queue
Message-ID: <20190503160650.GA1174610@laptop>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
 <20190502020455.GA71748@laptop>
 <698e2ef1-e45a-e66b-f604-5c6bf76c40b5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698e2ef1-e45a-e66b-f604-5c6bf76c40b5@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 02, 2019 at 02:37:56PM -0600, Jens Axboe wrote:
> On 5/1/19 8:04 PM, Marcos Paulo de Souza wrote:
> > gentle ping v2.
> 
> It's not that I hate the series, I just don't see it adding any real
> value. It should already be quite clear what the functions do, by name,
> and the comments don't really add to that.

My first goal was to make someone to first read the function comment without
going into the details of the code, and at the same time, by adding these
documentations, having these functions being listed at
https://www.kernel.org/doc/html/latest/.

So, in IMHO, they add a fast way, for someone who is trying to understand how
things work, to understand exactly what the function does in some seconds, than
reading the functions code.

In you're now happy with these comments, can you point how can I improve them?

Thanks in advance,
Marcos

> 
> -- 
> Jens Axboe
> 

-- 
Thanks,
Marcos
