Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC186C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E23207D3
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oApTUVbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFEDW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFEDW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 23:22:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3274EC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 20:22:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n2so3048126pld.13
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QyQw+sLIla93dlac0TERwcz4aWSKJuqSco16Wn/VCK0=;
        b=oApTUVbvRfwUXQkyK9U+0EK+y9ZjZdvqoGei9Z2c+lWyA4V9WeC6RwySmnttTG6h6R
         J5FKeKiU9vufOnBhhFWruh7l2jnbuXC8HWckjX0IWbOhN+hgkr19jyYnvyUKtb9GTheu
         evTg8bf8NZZU26vKyLPUwu2n9wMheLWcgtUV6877z7H0Zr5+wAxY7sqTsokSArUmkoJa
         77CgaSzTGld6I7+o8tUozYfgSTrnAM0/BRZqTO7g6feV+eKBM4odUNA3qXqctA8zH9JB
         ScsFF9jE/IDuxxV3ZgUfLedbHUBWt3W81bm87m3jv5JSAc39E9TYoGsaPR5oEcTt461g
         XBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyQw+sLIla93dlac0TERwcz4aWSKJuqSco16Wn/VCK0=;
        b=G0by8bh909Iyl4RerGLARBxIBxVaiIlFjpDNJQWHX2A2FuIfDcDVyB0N0h+Xdbt85r
         RJ8IdgwtXxv7l7A/OKn7AqNXic7lpMZ8TRHeI0whCNhETrkYt40SqOeCHALxqhrHTmYf
         ORGIscIJ5CF0WKDXLrhCQBNXzt59pyq6rsTMcDrWf13wWENH+kz4HQEbYX31w/Da1xEI
         XyYJL+WHqsYflM6lkKQvffuLYNHfUFOhYopmSao3YH16SrRwyO1+xCXWZ+xcJ9whE15g
         WlaV3qnfH3Hy3L12wuojx6X1KyrMgsTIjrK58kG7KMcaBLj/A994qUrYQxXgmjZnhKRu
         nyOw==
X-Gm-Message-State: AOAM531OZ/HGeanDbcQZd/Ocs4rGxEn9CnnQliwf274TyEYMqqwfVZ7l
        ivnwwaxrmNmJIjGRKnUYI/UqIOe6CYmDrw==
X-Google-Smtp-Source: ABdhPJwxXh8FFNGBgBksKWyrxn6L7WMe3Dlu7Qjsdz92aLKnsM1nGvuXZeAExnd99VH2EfqwFr5bhg==
X-Received: by 2002:a17:90a:2222:: with SMTP id c31mr570134pje.200.1591327376490;
        Thu, 04 Jun 2020 20:22:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a14sm5520589pfc.133.2020.06.04.20.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:22:55 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] block: nr_sects_write(): Disable preemption on
 seqcount write
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
 <20200603144949.1122421-6-a.darwish@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8440471-e78d-8112-2ab3-c2a948095fa8@kernel.dk>
Date:   Thu, 4 Jun 2020 21:22:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603144949.1122421-6-a.darwish@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/20 8:49 AM, Ahmed S. Darwish wrote:
> For optimized block readers not holding a mutex, the "number of sectors"
> 64-bit value is protected from tearing on 32-bit architectures by a
> sequence counter.
> 
> Disable preemption before entering that sequence counter's write side
> critical section. Otherwise, the read side can preempt the write side
> section and spin for the entire scheduler tick. If the reader belongs to
> a real-time scheduling class, it can spin forever and the kernel will
> livelock.

Applied, thanks.

-- 
Jens Axboe

