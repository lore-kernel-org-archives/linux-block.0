Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2BAC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 20:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123FA21744
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CZVn+TGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEIUYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 16:24:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54124 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEIUYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 16:24:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so4813255wme.3
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/YDXEZRxuV2qTjYMaMahCsdsWUVcw9ZKVZqQOKJAZkg=;
        b=CZVn+TGzEZMtIh27kvx0ysv8c1EsfTEJr0B5bBHunc28rWQ/IxylXFx+OUzG0ByYEa
         7xAFvdOnVDuecY6AasT0bp5/GgQ4d7wTI9YjYhSqIC3uFBL9WY8n/BVmC81g5XsQG7Qg
         psJqrD8bjDEQYQhK9NxJlgGXmuslwUWti7EhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YDXEZRxuV2qTjYMaMahCsdsWUVcw9ZKVZqQOKJAZkg=;
        b=tJwvXmrwsGqVATO4cKipm7lr6jnHiEA3amTtsJhlPMrjY7qJFsdeLHeFXg51ito1J+
         QaW8uM/zeoOlGLyQmonyQQm39DCafX8IzZaFK73yM9XNR5PYRumzWjI3c+M/xqLN58OX
         tXzJY204h/PdzpKdvYITqKnJrHKx6gRJC10Y867EtnN/tdRWPPisjwZtwYxx0AeTRtOa
         aPTwRj/EHh3hLtOdmnipqq8yLN/pBkmBON3I6xhaCwlSuacoNgeTA+th8cmTIEC56rOQ
         X0Y6unFFGmsnPw0PJhUy80MZQFg55rd9748Z9BvySwt+iNiBy5Tkdw1UGP3F872q7Iiw
         X5PA==
X-Gm-Message-State: APjAAAXa1CPZiFjHapWf6bOOS7FLZ6eR8wLGCCcxIY2qMcHM9bDwsW9k
        VSRUxG28hOr+Q50eJhSNE6gOCw==
X-Google-Smtp-Source: APXvYqzchPpABxmZuNCtQkZ+r9trf3h12x/WCemjBdV3WbUERiFZ3XmNzii5UBG2h1EMOtTmmnaGXQ==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr4035627wmb.23.1557433453504;
        Thu, 09 May 2019 13:24:13 -0700 (PDT)
Received: from andrea ([91.252.228.170])
        by smtp.gmail.com with ESMTPSA id t6sm3238636wmt.8.2019.05.09.13.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:24:12 -0700 (PDT)
Date:   Thu, 9 May 2019 22:23:56 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] bio: fix improper use of smp_mb__before_atomic()
Message-ID: <20190509202356.GA4097@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-3-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556568902-12464-3-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 29, 2019 at 10:14:58PM +0200, Andrea Parri wrote:
> This barrier only applies to the read-modify-write operations; in
> particular, it does not apply to the atomic_set() primitive.
> 
> Replace the barrier with an smp_mb().
> 
> Fixes: dac56212e8127 ("bio: skip atomic inc/dec of ->bi_cnt for most use cases")
> Cc: stable@vger.kernel.org
> Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org

Jens: any suggestions to move this patch forward?

Thanx,
  Andrea


> ---
>  include/linux/bio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index e584673c18814..5becbafb84e8a 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -224,7 +224,7 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
>  {
>  	if (count != 1) {
>  		bio->bi_flags |= (1 << BIO_REFFED);
> -		smp_mb__before_atomic();
> +		smp_mb();
>  	}
>  	atomic_set(&bio->__bi_cnt, count);
>  }
> -- 
> 2.7.4
> 
