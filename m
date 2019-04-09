Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C1AC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11873217F4
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mAQdepYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfDISXj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:23:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42355 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISXj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 14:23:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so9891757plb.9
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PNVquwwp98grAeY4p/OsTz4uwPvJY4QzfDrrKIhwckI=;
        b=mAQdepYMqjV59NADmqDN+b5fsNEXJA6d5WVSejU51qXmU+EmyjMCVQT7XpIteEIsb7
         Fe3SIIn3SUBYkQTlbOkGFxkXH+sGJPeqPnXaW4a3fP002SGN+fGRlfj/2Mej3A8Dt/z3
         AYSGYkKFlbbra+abb4N6+3TaKIFw0jZDK7+JBD+hhPuLbeucP8VNCgRydYddPlnJN4WO
         S0u8VBjOLOd33eGZME9tkfPrSA3ijx6YeRg8TwsqpnhDLMlMLs9kl8hjBrG6H6VV3vqb
         7vQaerBJZPoFsjAjf6ZSdWLT9k0cNscNSyNCnp9LINTH9ayPnMBAKLylrfSvPm7gV2Dw
         9Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PNVquwwp98grAeY4p/OsTz4uwPvJY4QzfDrrKIhwckI=;
        b=KYMoQI4IjxPswpWyenKfmjvETXgrxnMkBjOBZg5VGXQwfwN9mByJxbTb/XqjM+rM3d
         006WU8Ys6tnC1D/RR5ITL1rHnLnoJhUj51sueZ3vVT+jFgw6toNgIFJQ0tJ7oDrX+Ew/
         k36mdlZiaxHsfSenEWpHkAok5ODADxJX1QTKaj2CRZLI/9gls5L+m6e5pBDrzJbCV9oo
         m1RrUMHhBvFjZsPprTuVxpnZsCwRo7m1Ez2mn0HV6rfHVSdpkc6pQ8oO3Fy1yl4J9+gp
         oqGa66unNb2hsc9tpZgzeL/bpi5OSxdmRVLKBc30T0ebFi1cGAEvfHVh0lMWvT4jTU6Z
         xcOw==
X-Gm-Message-State: APjAAAUGm8z5yj7LOOnZb1AYYtQHeuhepx+Fl4VrCkKiU8+zAd2j/DRr
        BsavhojDRNFyT4eiVUO8opPLLw==
X-Google-Smtp-Source: APXvYqwl905bBA0yyU3tGDNoEAfOlWunKxcIUtIgqtdK5eeUiT69V/TPXctnM1sKu87kPC6kSlH2/A==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr38653676plb.153.1554834217882;
        Tue, 09 Apr 2019 11:23:37 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j28sm66715725pgb.46.2019.04.09.11.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:23:36 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add support for barrier fsync
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
 <20190409181742.GA24925@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f8d9644-9e8f-c9d2-611e-4b144c62539c@kernel.dk>
Date:   Tue, 9 Apr 2019 12:23:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409181742.GA24925@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/19 12:17 PM, Christoph Hellwig wrote:
> On Tue, Apr 09, 2019 at 10:27:43AM -0600, Jens Axboe wrote:
>> It's a quite common use case to issue a bunch of writes, then an fsync
>> or fdatasync when they complete. Since io_uring doesn't guarantee any
>> type of ordering, the application must track issued writes and wait
>> with the fsync issue until they have completed.
>>
>> Add an IORING_FSYNC_BARRIER flag that helps with this so the application
>> doesn't have to do this manually. If this flag is set for the fsync
>> request, we won't issue it until pending IO has already completed.
> 
> I think we need a much more detailed explanation of the semantics,
> preferably in man page format.
> 
> Barrier at least in Linux traditionally means all previously submitted
> requests have finished and no new ones are started until the
> barrier request finishes, which is very heavy handed.  Is that what
> this is supposed to do?  If not what are the exact guarantees vs
> ordering and or barrier semantics?

The patch description isn't that great, and maybe the naming isn't that
intuitive either. The way it's implemented, the fsync will NOT be issued
until previously issued IOs have completed. That means both reads and
writes, since there's no way to wait for just one.  In terms of
semantics, any previously submitted writes will have completed before
this fsync is issued. The barrier fsync has no ordering wrt future
writes, no ordering is implied there. Hence:

W1, W2, W3, FSYNC_W_BARRIER, W4, W5

W1..3 will have been completed by the hardware side before we start
FSYNC_W_BARRIER. We don't wait with issuing W4..5 until after the fsync
completes, no ordering is provided there.

-- 
Jens Axboe

