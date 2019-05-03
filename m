Return-Path: <SRS0=mx3V=TD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3EC43219
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 14:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAF82087F
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FAILa7Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfECOsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 10:48:19 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45796 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfECOsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 May 2019 10:48:19 -0400
Received: by mail-io1-f44.google.com with SMTP id e8so5375014ioe.12
        for <linux-block@vger.kernel.org>; Fri, 03 May 2019 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w8E+9xVXk9AOi8IVdyeI0M13iSyFi+ASRIxz8PRpjb4=;
        b=FAILa7Aa4l3ku/s6j3lSeGLKGMLVcvZRvZZTRNMWSdUCnds8EGyMBS7Bllab+UiSFT
         CGXyCZQahMAV9ypkogBPP+P1CrF+Q8BIZ1CDHtOma0cnFPNk0LyIzVx9C57pqJSmHwjZ
         /7dOBYU5+Blfpx48s0QoNjQnJqAT3kCfGkWSiIyEtxO8Od4P9ZBt1KxiOibRed71f4+b
         0+9dDAIfWiHc/s2F9uBIlyL8Y4GXBhOJZHEpDcM0I2I3gDslsRRkui+7s90/kJqhJz+N
         qpTPTsQ+IjhV593EeUFcn6+WhfTve5z5MuR364xD+9qkSZT8Hd7NStWeJbV+jobcXj6d
         4xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8E+9xVXk9AOi8IVdyeI0M13iSyFi+ASRIxz8PRpjb4=;
        b=g6e9DMBIRelh8n0mcNXvqQ0SjPWBHYVQIif+lsB13uMJrSnapzuyAx8PIyOf3TLusx
         xdIvhF5FWmRdbhZw7ZkvqulKAxMlE1q2YN18K0+fyLYXcG/dEHXUM66AatSJDOt3N+Zy
         Oq+50CVYrilWuWJCDQaeXbVHmjCPEIhLPF1SUKPT+oyZfgImRZGAwHlpq/BIWjeVk1LR
         f6fQhS75DrjsLMvhhMkRvkxAvecKU2CMaH9kXrTaO6LcQpx8+ze4ayxI9fvu7TDxwx2B
         E4ZqRDH9lE3taFf8wn/X1AW+5S2wfumQWi2m4U9RUa0MGk1zKAl5FatcvVZvA3wWfU18
         PQFQ==
X-Gm-Message-State: APjAAAVK4LVPylIVhCFbFkKvBTvadIJZroOeDXtkIlOM6X6V7SRWOkmT
        7iE8Wjk8GoG280B3QSfXheOPQg/H6hClcg==
X-Google-Smtp-Source: APXvYqy4/Llc5gn6WfsodhlR6aaQVNfckI/oDQJ5Rwx3GdK6asbMFVG+IIPPWd9JvEnfJBTrTYFrhA==
X-Received: by 2002:a05:6602:20cc:: with SMTP id 12mr5874666ioz.6.1556894898766;
        Fri, 03 May 2019 07:48:18 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y203sm1150673itb.22.2019.05.03.07.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 07:48:17 -0700 (PDT)
Subject: Re: io_uring: REQ_F_PREPPED race condition with punting to workers
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <bdc72cc4-ee7b-db12-baee-47e8f06d30e7@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3900c9a9-41a2-31cb-3a7b-e93251505b15@kernel.dk>
Date:   Fri, 3 May 2019 08:48:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bdc72cc4-ee7b-db12-baee-47e8f06d30e7@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/19 4:22 AM, Stefan Bühler wrote:
> Hi,
> 
> if the initial operation returns EAGAIN (and REQ_F_NOWAIT) is not set,
> io_submit_sqe copies the SQE for processing in a worker.
> 
> The worker will then read from the SQE copy to determine (some)
> parameters for operations, but not all of those parameters will be
> validated again, as the initial operation sets REQ_F_PREPPED.
> 
> So between the initial operation and the memcpy is a race in which the
> application could change the SQE: for example it could change from
> IORING_OP_FSYNC to IORING_OP_READV, which would result in broken kiocb
> data afaict.
> 
> The only way around that I can see right now is copying the SQE in
> io_submit_sqe (moving the call to io_cqring_add_event to io_submit_sqe
> should simplify this afaict): does that sound acceptable?

I'd be inclined to just fold the prep into the regular handling. The
only prep routine that does any significant work is the read/write one,
and if we're punting to async anyway, it's not a huge hit.

If we do that, then we can get rid of the PREPPED flag and the separate
need to call io_prep_xxx() for the command type.

-- 
Jens Axboe

