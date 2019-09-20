Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F8C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3280E20B7C
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 20:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j7vZEL6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfITUSM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:18:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46089 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITUSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 16:18:12 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so5837127ioo.13
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2019 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xNAVoEDP/Q/RaJ7y4/6cduzBNNDLdl7IyXLrfmdgfJs=;
        b=j7vZEL6t6vkcTdgPfCT4xR6ZKya2piJColOyVBO/QrQNlQDSVUTHnxvYAgUspHKJHZ
         0Ui3T/G1Rq2J9EKVxo/T36CQADo7N9sHzgQnymm9fbccOIypdjNAW5FiCBadhzfcb7/I
         2y9ee4zp+Z+j8n1a4eal5/yH45yi/jDjxJGFjl4f40ivI7wynxTf/LZCw+schLPN8r/x
         PDEianVFtQEFmeSLNB1NULGsn8pzCWDUpAGbc1nvXopQKCm2uU42vtQMW5hB6tip+B7p
         4RWxUf/EWkd54FTxVXvN7Arr170F+q4Qv7BFHT20WBOVvCiJYD4KDPJkiSE7GL5P+EHv
         ofMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNAVoEDP/Q/RaJ7y4/6cduzBNNDLdl7IyXLrfmdgfJs=;
        b=f2uCf+H6ztV7H8LJhsmF+oq4K3IX5NEgKBQG4U2/QZivwk0rb+u9xLocHEI0pn4zBb
         Hk2BPYHsCySDWTU0O0iaGfHX8nHnInKKRRIH69g0yYWsDgQrcyfb1SAmQKBiur+5qiuX
         LHwt7t7wlcRnSbdUzwwR2zc52kzu/xE2y7/e39b1GXQThDsnHFVZroLLUYCng16iKZQM
         51GEDIBbpY7OkioMJ/xW/PovKzs/letM+RSfyRKs0eO3lBfoLZpQrZ02mTsxDuTzYswG
         s5TbLdR2dmLp0nVNLlBSAxVqXAt5khMIFPjArUftwULwmCPRAunmbgecHBcUBQ4xEHzz
         iREA==
X-Gm-Message-State: APjAAAW60ceHDWFy2/vGVfBYzwby4+2P2F0VvYULCstocAt0xz2sYJ1k
        pAwNnXVpZvAi/gc51tydcS3S9aUjU2p+Bw==
X-Google-Smtp-Source: APXvYqzQ9wyokBc4rupL1Jei5zN67xSHsVyR6OIvmoTImQtnjRpqyMuZfkil7vAJXt8i1mmRDUEHSw==
X-Received: by 2002:a6b:e302:: with SMTP id u2mr12377504ioc.135.1569010690801;
        Fri, 20 Sep 2019 13:18:10 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x2sm2296418iob.74.2019.09.20.13.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:18:09 -0700 (PDT)
Subject: Re: [PATCH] io_uring: IORING_OP_TIMEOUT support
To:     Andres Freund <andres@anarazel.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
 <20190920165348.pjmdnm3mozna3ous@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <838a193a-cb83-c6d5-f251-b113e9faf9d5@kernel.dk>
Date:   Fri, 20 Sep 2019 14:18:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920165348.pjmdnm3mozna3ous@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/19 10:53 AM, Andres Freund wrote:
> Hi,
> 
> On 2019-09-17 10:03:58 -0600, Jens Axboe wrote:
>> There's been a few requests for functionality similar to io_getevents()
>> and epoll_wait(), where the user can specify a timeout for waiting on
>> events. I deliberately did not add support for this through the system
>> call initially to avoid overloading the args, but I can see that the use
>> cases for this are valid.
> 
>> This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
>> when waiting for events, simply submit one of these timeout commands
>> with your wait call. This ensures that the application sleeping on the
>> CQ ring waiting for events will get woken. The timeout command is passed
>> in a pointer to a struct timespec. Timeouts are relative.
> 
> Hm. This interface wouldn't allow to to reliably use a timeout waiting for
> io_uring_enter(..., min_complete > 1, ING_ENTER_GETEVENTS, ...)
> right?

I've got a (unpublished as of yet) version that allows you to wait for N
events, and canceling the timer it met. So that does allow you to reliably
wait for N events.

> I can easily imagine usecases where I'd want to submit a bunch of ios
> and wait for all of their completion to minimize unnecessary context
> switches, as all IOs are required to continue. But with a relatively
> small timeout, to allow switching to do other work etc.

The question is if it's worth it to add support for "wait for these N
exact events", or whether "wait for N events" is enough. The application
needs to read those completions anyway, and could then decide to loop
if it's still missing some events. Downside is that it may mean more
calls to wait, but since the io_uring is rarely shared, it might be
just fine.

Curious on your opinion.

-- 
Jens Axboe

