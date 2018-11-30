Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A14C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD12082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kZL2O/lE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFD12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLAJWr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:22:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34010 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLAJWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 04:22:47 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so3027501itd.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/p0yTGibIrupKYU42dPBLFonRWhw4F3SMz4uxrjj8KE=;
        b=kZL2O/lEPo6+eUS6j+BpAjWoEkm69l8u8j1yCtNDlnAWcW+NNnslCQxVGYBXB1QPZS
         XHQIl3YH3apEixYKMi5C3rZNbFQsmgTVWCGG5GFBQZ1WJLi2qr90pdOYSrPYjhQ1wWg5
         v4NykgdaWD54kpzbA/SejHxpKOGTESXpDx5Q+487XfAMUP+4QBbvKhfxVpPn9JfWRHPC
         Y7iB1lPFT1FlSNjTSbYnzq9+bP/nA5tuivGm3s+7Cz4Fn6x+0s0jiExkZYMwoKTtS0Xg
         H5fuJmnGwhUVJxjSCCQ4rzXGHUcHeuKsaimyOGxVq4WcpX5m5EsOzN52IFshJ7lamLVC
         BU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/p0yTGibIrupKYU42dPBLFonRWhw4F3SMz4uxrjj8KE=;
        b=dhym4eSKfCGWq//JWC8FC+huzAa0HPOpgDlHAo27dYgHbctVuqTjR568rDshwNfT73
         td/65bYMPc6ETIiY67Gy/95ug46FDCfEMCP9g5W6sHjBZTp0VNncwIlo67es00tDRkhU
         3ymobkQRUEr5yd47/F4qTALl0Cb01goJCoE22dDC8dQ96izxdEZk4vr3wJEoNshjjMcy
         AMG5I/9XjWmLZKoLfqGdPC9GemXupHeHkbQmP6iImG/Qken7kp/KTeOa9Tfh92+U3bls
         vEIgx7AoTwU0WL2xJI4CjloD1N4ay/qXxkFFD782dVomjQKHPX/H/g1v4odRrwvGlPPH
         38xA==
X-Gm-Message-State: AA+aEWbSx3xPxOhJezNrdScijYhnWUDVh0oU3FM/N3/JBNtP4ws+GrF9
        Ok9sm1L0G6+Li6gAEdQVAvZzqQ==
X-Google-Smtp-Source: AFSGD/XaLabHs9+1lPwqYSqKR5OIR5wlX33qiridV0BSn9rwMgLewrGXsmVV35JVyW0ykLtbbGE3Gg==
X-Received: by 2002:a24:3842:: with SMTP id b63mr587692ita.19.1543615921123;
        Fri, 30 Nov 2018 14:12:01 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d3sm208957itc.40.2018.11.30.14.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:12:00 -0800 (PST)
Subject: Re: [PATCH 27/27] aio: add support for pre-mapped user IO buffers
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-28-axboe@kernel.dk>
 <x49pnum5jfv.fsf@segfault.boston.devel.redhat.com>
 <8dc2ea1d-b6a4-728b-7550-87d32240989c@kernel.dk>
 <x49k1ku5ij1.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecfd6c0d-325f-c22c-9f10-e3073e5aa765@kernel.dk>
Date:   Fri, 30 Nov 2018 15:11:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49k1ku5ij1.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 3:04 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>>>> A limit of 4M is imposed as the largest buffer we currently support.
>>>> There's nothing preventing us from going larger, but we need some cap,
>>>> and 4M seemed like it would definitely be big enough.
>>>
>>> Doesn't this mean that a user can pin a bunch of memory?  Something like
>>> 4MB * aio_max_nr?
>>>
>>> $ sysctl fs.aio-max-nr
>>> fs.aio-max-nr = 1048576
>>>
>>> If so, it may be a good idea to account the memory under RLIMIT_MEMLOCK.
>>
>> Yes, it'll need some kind of limiting, right now the limit would indeed
>> be aio-max-nr * 4MB. 4G isn't terrible, but...
> 
> Unless my math's wrong, that's 4TiB on my system.  ;-)

I guess that's a little more terrible ;-)

>> RLIMIT_MEMLOCK isn't a bad idea.
>>
>>> I'm not sure how close you are to proposing this patch set for realz.
>>> If it's soon (now?), then CC-ing linux-api and writing man pages would
>>> be a good idea.  I can help out with the libaio bits if you'd like.  I
>>> haven't yet had time to take this stuff for a spin, sorry.  I'll try to
>>> get to that soonish.
>>
>> I am proposing it for real, not sure how long it'll take to get it
>> reviewed and moved forward. Unless I get lucky. 4.22 seems like a more
>> viable version than 4.21.
>>
>> I'll take any help I can get on the API/man page parts. And/or testing!
> 
> OK, I'll add libaio support (including unit tests), write the man page,
> and I'll definitely do some testing.  I'll start on all that probably in
> the latter half of next week.

Awesome, that's much appreciated!

-- 
Jens Axboe

