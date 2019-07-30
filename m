Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D40C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD752064A
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 17:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnrv5qvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfG3RG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:06:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41268 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfG3RG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 13:06:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so20037178pgg.8;
        Tue, 30 Jul 2019 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0wnesJAQofX39qSktPPeaA9KjBRjREjisYtCAJl0JHk=;
        b=gnrv5qvI5ZA3oqdGUokoHb79EGdD7KPi+PK7q7HsIDilgdKKNGsM5bjTM9VFbfdLPL
         V9mB2LZKsEPBQGF4CNAwby6CxflWls4Eus9U+oMd4NC5OLoRpQ6xVQuQRKAg+HKeEci5
         m7fGsPWIizmM6HaY5p2SHIPYIruTdTEoz0q5KxsbiWX4NuyU55x6uW0NAomKUEDi3q29
         VY5QXOH3OVgzglOUbL9FvRKU3Gx0lNtE2jrcwenZeHCIVTFKPf3o45G6cLOb9itN6S+1
         WTuh7IjVkZyUx5J9l3rFG9sfeEj+hnb8wXXUdTMC8C2gOhQuN0nLjcUNOgy841J+0AiX
         4ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0wnesJAQofX39qSktPPeaA9KjBRjREjisYtCAJl0JHk=;
        b=HfgJckwQd4hKqM2bGrp7DO/S3lTxKVMsIzNzQHOPwEMS1nn7g8QL6y0CT2qA1paPW5
         7mUmDFxpxrNCdLq4RW3kE75YNPALVIM+apngOaoH3V+H2Y+qici/fft/M+lFReNSUmbq
         m3XznKepIfO+DAw3Bfs8hq15t94uyPW9dW7pCgBM0pW7hO6hCqyvBZOQlZOTRaFhTrxD
         LsnmaAN7634aSstDyTCU+3I0rSHxB7qsqAeqSl7CIp2T/SgOF0VdSB3AJwGa9hXifJ31
         VZU8Q4O1ZFzVB1neaAloofnmt4+QvXniZ4Bq3w5z7B28CLkzAfHinJylFcu5IT5BNcfr
         0p7g==
X-Gm-Message-State: APjAAAUE+4nocMhTfXLPChiaSAHnS9jhwRrk0B9SnWuCT+P+J54ZCBG2
        KqWgMe+Fvh9/B+eRDmBGXTo=
X-Google-Smtp-Source: APXvYqx6i7dzXvExadnR4qSrEF5Vp2/xDYM8ZxKoMxJaXNmCJoooe28tliJyMrpiaYdRs29uwGSrgA==
X-Received: by 2002:aa7:8e10:: with SMTP id c16mr41838508pfr.124.1564506388364;
        Tue, 30 Jul 2019 10:06:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r75sm87830722pfc.18.2019.07.30.10.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:06:27 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:06:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
Message-ID: <20190730170625.GA19996@roeck-us.net>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
 <20190728151931.GA29181@roeck-us.net>
 <0BCD5EDA-6D08-4023-9EEA-087F0AB99D47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0BCD5EDA-6D08-4023-9EEA-087F0AB99D47@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Paolo,

On Tue, Jul 30, 2019 at 10:55:24AM +0200, Paolo Valente wrote:
> Hi Guenter,
> sorry for the delay (Dolomiti's fault).
> 
> I didn't consider that rq->elv-icq might have been NULL also
> because of OOM.  Thanks for spotting this issue.
> 
> As for the other places where the return value of bfq_init_rq is used,
> unfortunately I think they matter too.  Those other places are related
> to request merging, which is the alternative destiny of requests
> (instead of being just inserted).  But, regardless of whether a
> request is to be merged or inserted, that request may be destined to a
> bfq_queue (possibly merged with a request already in a bfq_queue), and
> a NULL return value by bfq_init_rq leads to a crash.  I guess you can
> reproduce your failure also for the merge case, by generating
> sequential, direct I/O with queue depth > 1, and of course by enabling
> failslab.
> 
> If my considerations above are correct, do you want to propose a
> complete fix yourself?
> 

I had another look into the code. Unfortunately, both bfq_request_merged()
and bfq_requests_merged() simply assume that bfq_init_rq() never returns
NULL, and don't give me an idea for a path of action if it returns NULL
after all. I'll have to pass the problem off to you for a fix.

Thanks,
Guenter
