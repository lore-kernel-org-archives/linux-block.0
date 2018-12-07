Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C63EC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0902081C
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nE19CACo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0902081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGQpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:45:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52120 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGQpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 11:45:04 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so7833752itl.1
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 08:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p5CES3Oh9ijubBPWmy9r22fwVUyuMkZ7xXziYwv2kIo=;
        b=nE19CACo2eUlYtqDmd6GPjRJoJ8drYuwIQC0KG2JAy9gZF4/ogZ/nbBKoNr0lHngE4
         kjzbdEWE4DWwVO/uzlnPyL/R9vkIaOOnms6jVxa66Wp7FBaC2Qklqi8faMd0lxue0oyZ
         pbHGEvtNOs3aKRU6Rw419TCVuUeY4QnuGXZutDbooYqUwAJoqPRv6jcz7ZiSSyk/FUYo
         r/5+d47owW8J8y0p7XSs6TzRD9brMLtfvLtYJvUlKxlfgpoAvF/WOBh4gQHL0kmL7iWI
         orYzCrsODRVuWFXTDk69pQ/XUVnt1IkcZOPZyB51e1DM4qCxCeXFeBcFHC3mrX2FLK2n
         Wjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p5CES3Oh9ijubBPWmy9r22fwVUyuMkZ7xXziYwv2kIo=;
        b=Tym4Uvomgehqxn2+W4RYfvsgJGSD3mGWzTdBYfdsh99akrEJ3vP5+lY/QM1HdV+AWk
         f+9ZEg5AbnsaaJ+E+GNVP06KvHB4iLN8dzv8DRiUtBVFgb3sXsSkg8+nwc7DoJK9FdSs
         nyn++xcSyk2QSSKr6xGHF5yQUoe3w5T9CbeOi3D3Oom6igGYpZWVpIi8mRwnqyHCN1P1
         y0GDJkFoPLfQdqeT+XkTh0HY8GaiDZ4MKMiFRAJMICfPRL9s9vRPKXrVUQiKRRv9LqZu
         VnBoRpfq2oxReI8cWcNyw3NCU6S84gzClWoMOXWHas9Y32wfP9uQbkL7X8/BXoW4Jw8A
         AYbA==
X-Gm-Message-State: AA+aEWZZzNZ5j/7WmvCBrQxp59/VbdFeGsE0PftnFoF+QL4OfWMU8gvF
        4Wg/cGmF5H7HaBhWBv96CJaR4iRZKhM=
X-Google-Smtp-Source: AFSGD/XyLeZmNizp+GQPTf12VgePrPJb6IqwvcD4QjYE4ZTRquVfMqxZt1vcJhdx0A1j6briwKYb+w==
X-Received: by 2002:a24:4cd2:: with SMTP id a201mr2559319itb.172.1544201102828;
        Fri, 07 Dec 2018 08:45:02 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm2119467itb.8.2018.12.07.08.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:45:01 -0800 (PST)
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
 <1544199585.185366.303.camel@acm.org>
 <693ac87a-ebb5-2e4e-25e5-92a1d3865c8f@kernel.dk>
 <7eaf8a39-3628-e153-79c9-0f115a4392d4@kernel.dk>
 <1544200879.185366.314.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6f805d0-95be-9dbe-275f-dcda64326824@kernel.dk>
Date:   Fri, 7 Dec 2018 09:45:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544200879.185366.314.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 9:41 AM, Bart Van Assche wrote:
> On Fri, 2018-12-07 at 09:35 -0700, Jens Axboe wrote:
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 29bfe8017a2d..9e5bda8800f8 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -377,6 +377,16 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
>>  
>>  	WARN_ON(e && (rq->tag != -1));
>>  
>> +	/*
>> +	 * It's illegal to insert a request into the scheduler that has
>> +	 * been through ->queue_rq(). Warn for that case, and use a bypass
>> +	 * insert to be safe.
>> +	 */
> 
> Shouldn't this refer to requests that have been prepared instead of requests
> that have been through ->queue_rq()? I think this function is called for
> requests that are requeued. Requeued requests have been through ->queue_rq()
> but are unprepared before being requeued.

If they are unprepared, RQF_DONTPREP should have been cleared. But needs
testing and verification, which is exactly why I didn't want to bundle with
the fix.

I'll test it later today.

-- 
Jens Axboe

