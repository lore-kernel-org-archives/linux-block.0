Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C5CA9EC0
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 21:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8BE21479
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 21:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mdqUvevv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfJ1VVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:21:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbfJ1VVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 17:21:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so7826364pfb.0
        for <linux-block@vger.kernel.org>; Mon, 28 Oct 2019 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Mw7GL5lBYXyFZbiWmVYNAyXtWbL7t7BFptE67UtrXA=;
        b=mdqUvevvfBLxrYNr2yNzMM8uR4yvZhS6590jFY8aR9m7NDeA/LtEEEwmO1M4odTmsi
         W+aePD5McG+4Cqy/4v8UNKWctp2JtlU13WkRxvUvx8YbAz4a8lykcpq/5vUT7WMlM14H
         WgZRxrLZJ1myiEmk/ciNTZk+FCIDZN3IcTqvbi9kze3pgPE26FdtsY6FuGDBWW9w+/7X
         9a1oWVzJdYHI0ax8WBwnhg8kuuDc1HVMoHlxav6Nnf2htd6oEOk/hIER3WpanWCyrVuE
         d0CQPRdngHjxasD35maEqTnJOunz7wjUqMs0JxNR7EJvFjXv3V1awSiqMvW6KWLC4O/+
         1wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Mw7GL5lBYXyFZbiWmVYNAyXtWbL7t7BFptE67UtrXA=;
        b=aEFvg00FaOj3ZjxgSl3AH7xQbMMBmt7rdHoOFAU8oDrvmA8Co5ajcOzzDfVZBTjk0q
         bOVWNdQ24NkyENrcoS5sLwc80ST08hYFw4RaIxs00WC00TNxdZOuCCDzbGrPpE0Kljhi
         USrnKilv8UKo2uz3kiNfZezA3rjnKqdKJJrUzlyaBtiwwbqwBToNehzhF63VeXiNNg+D
         DcbUR8GPSAwaktl+BapXqTh7KNZCoUxtOvYHYem/utRdpici/dyGlHFUIhhrCqUpfi+/
         HSDudfSsiaP4n614aoZyrG5W73+133A4SifdhN0Cxb/tQt1/92shzwiWrFHKPKW3NzJH
         b1CA==
X-Gm-Message-State: APjAAAWM5Ow/in10yqmyKItBsj3IxDAgNAYdqX136xEpERRZBO+m7As4
        LpeOOmtgr+BhGwnCgY3ULocLdA==
X-Google-Smtp-Source: APXvYqyPoIlnOJZJqEOsM4sNGwVvOKDEjCPDkaCDLLtoUlAQ7AfHS8suRZQky5AUcroiTC15cF1TJQ==
X-Received: by 2002:a17:90a:a886:: with SMTP id h6mr1616033pjq.55.1572297674717;
        Mon, 28 Oct 2019 14:21:14 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 21sm4071230pfa.170.2019.10.28.14.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 14:21:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] io-wq: small threadpool implementation for io_uring
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-block@vger.kernel.org, mingo@kernel.org
References: <20191025172251.12830-1-axboe@kernel.dk>
 <20191025172251.12830-2-axboe@kernel.dk>
 <20191028171010.GH4114@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39c0e199-3229-d500-1ab7-d69c7f2b4d60@kernel.dk>
Date:   Mon, 28 Oct 2019 15:21:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028171010.GH4114@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/19 11:10 AM, Peter Zijlstra wrote:
> On Fri, Oct 25, 2019 at 11:22:50AM -0600, Jens Axboe wrote:
> 
>>   include/linux/sched.h |   1 +
>>   kernel/sched/core.c   |  16 +-
> 
> This all seems pretty harmless, it makes the wq paths wee bit slower,
> but everything else should be unaffected.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Great, thanks Peter!

-- 
Jens Axboe

