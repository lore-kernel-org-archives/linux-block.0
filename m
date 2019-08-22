Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DCC3A5A1
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EB32173E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 13:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NNroVZEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfHVNRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:17:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35146 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfHVNRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 09:17:44 -0400
Received: by mail-io1-f66.google.com with SMTP id b10so2658700ioj.2
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qj4zz9/8trkP7Ek6bfCGpry5JwGqluiSWB5f+6bSqI4=;
        b=NNroVZEZULWySYWamnnPG4/XEK3jpyE2HtBvBBPkioOARqPD5PyKyKdhl5CNhOcU5X
         KiaG7a1bb0sOY2rK0VlJxXKbMQOz/Dkp5QFlz/zrdyO6Ph3WzAMdy0VpoZRr5W29YaD4
         1oF2OXZT/DjxKV2WWqxaXUHYqybE0riCZA15Vz+POtnaGxXKRv7hinnE8KhVp9j3V5tR
         eXYiw66e1InJ5tottDuja89/SAbSoNaKcaRNDovGFyKM6+p/kgaUNQxccg63hGnFUJpY
         EeX81rQvirbAFZi4zP0e43ExIsIkmf3x5gMKUl1K0xsG8X8d+7l9nRJ17iUaADrurarx
         d0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qj4zz9/8trkP7Ek6bfCGpry5JwGqluiSWB5f+6bSqI4=;
        b=SDIyX8PU6WOLON6YeyNjpDEy/JrbcO+LZnXHkAp5AmyQtAUdpaaFlBp011zajqm+u1
         j6+F3BtkqWR3tRj6gNXIFXbXHodRpgBerESCy2IeI8M1UjEANXCZV+dSLExFb603UQrF
         Xjzy9N1axfgJSq/6Yt0H5ZZHsnFBiR+nmbXYeUTMXMTpPBSoXwV6vdpRrhQnx/SwqYQe
         rS0UvpoKiLplHnXwcR6CtRVBy5ShDTR5ahwpPG+iswDozIwfKD8gnpuP9pZS/dhtYrFy
         28GKDoTqWR6UQMRTihd/kMCNwtPG7jsXv8MeXM+JAJjOANfljUqLJG41FpZI1tgZZ1WW
         pyuw==
X-Gm-Message-State: APjAAAXr1IfvwMinEATzWJQcnrHrME0CatvX1D+Nj8OMXMJveMN4etu8
        l79eYMZ1a+O8LuOD8oJUQ7ZvGw==
X-Google-Smtp-Source: APXvYqww8CVseXYUiV5Ty+W7oWsgjU0Z2Wf6+ru8zyL6eLNDk0LbIOTo/b3H9M9BezUtkhHzyGRqNw==
X-Received: by 2002:a02:810:: with SMTP id 16mr16307812jac.121.1566479864056;
        Thu, 22 Aug 2019 06:17:44 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k6sm20525256iob.11.2019.08.22.06.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:17:42 -0700 (PDT)
Subject: Re: [PATCH] tools/io_uring: Fix memory ordering
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20190820172958.92837-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d996c8ae-2ce3-d5da-fb53-e7745e70718f@kernel.dk>
Date:   Thu, 22 Aug 2019 07:17:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820172958.92837-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/19 11:29 AM, Bart Van Assche wrote:
> Order head and tail stores properly against CQE / SQE memory accesses.
> Use <asm/barrier.h> instead of the io_uring "barrier.h" header file.

Trying to think of how we can best keeps things sane in this area going
forward. As you know, the tools/io_uring/ stuff is basically just copies
of either liburing files, exception being the io_uring-bench.c which is
a copy of the t/io_uring.c from fio.

We could move t/io_uring.c to liburing instead as a sample file as well.
That is a bit odd, since t/io_uring doesn't use the liburing API at all.
I could change that to just use the setup etc helpers, but still use
the raw interface. I think that's a valid use case, for other programs.
If we do that, then we're down to just syncing with liburing, and we can
take some steps to make that easier to do.

Open to suggestions...

-- 
Jens Axboe

