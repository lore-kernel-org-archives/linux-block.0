Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC215C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 12:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F072146E
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 12:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bJUa7eq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBHM5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:57:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42045 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHM5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 07:57:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so1548330pga.9
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8o9WQR8+8eQtct1sr9NqfWvHVNZh/JgNtGR0JwNPr0M=;
        b=bJUa7eq6bi8EzGp+vEjU76g54q1T2xr2/tut0tndRk/0aO2qtgMl/l78M97ZQzyTlT
         50DgJcjwvslNKrsJ3zKXoRRG1unR+W3xEmXzhLlVVt8ZTS+hwSChE8O7eSvxrh8QpF+A
         q/vbv+LSeCEERTJaZ8MM4FvsO8/Fu9+H7jjMjM5fXrYz3ZDiWefctCvr7tWzWfSg2GDy
         7MQhe+kpd5KsQIilVVPu4l68lLQpfhBBuFPGgAfkMABeNkObuuQliavby1sBxzsRO9Nm
         bQnO14Qi/hZfg1o5TDJ5VIUe3G0IlO+XJ1dN+/6Lem/qrGdaaV/9h+9VlZSxELx5DHXh
         xbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8o9WQR8+8eQtct1sr9NqfWvHVNZh/JgNtGR0JwNPr0M=;
        b=jcxaZ8G0MsUGhR2KfnuUM17Digx2p1BaSN/rtCBJO9GkIOW6EncOlFYLWPU96a2JJe
         s2bNSPTAB14Ynqxu3UN68BmXx6mO0sFLv9uVZ02cX0EqcPXBsqqj4q2I9SGt8csnXfXq
         iOb4W5mtv2n/WeSJqr+lq+erHcYsfEiVJ3nHOdxcgjYnE76BSmcYCEzC/dFzGyrLbmw0
         AJrIcNGTeROSIWUh2Cztg258jCsovB6e/QEzIzMGi45vZAIbAPB6CdcwtH4jkGdmB3GO
         H1PLqljVUld0bVBZxBHMDawaZON8OzPxSvUCAAUOj53qtaoOM0J6BJpPYVCF0QoCOGwO
         zcZw==
X-Gm-Message-State: AHQUAuYfnaRjDnO2DzLUrOhzRmgHXlOY6NOxUpD080Pz3UnMmFfN2gNz
        MywjKQ7afl1vgO9wnZl+0MBPuA==
X-Google-Smtp-Source: AHgI3IbN6oAhv+qaOsIi2k83xHh84uQYniKD05sR1jIFip22SQqu3A/stCnczJw4xfizyEQjv19o3g==
X-Received: by 2002:a63:4611:: with SMTP id t17mr10989446pga.119.1549630673488;
        Fri, 08 Feb 2019 04:57:53 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r12sm2203470pgv.83.2019.02.08.04.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:57:52 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-14-axboe@kernel.dk>
 <bfd383aa-24fb-35ae-eef5-545ab0f493c7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ac73020-6ab0-e351-3a1a-180d0f1f801b@kernel.dk>
Date:   Fri, 8 Feb 2019 05:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bfd383aa-24fb-35ae-eef5-545ab0f493c7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 5:17 AM, Alan Jenkins wrote:
>> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
>> +{
>> +#if defined(CONFIG_NET)
>> +	struct scm_fp_list *fpl = ctx->user_files;
>> +	struct sk_buff *skb;
>> +	int i;
>> +
>> +	skb =  __alloc_skb(0, GFP_KERNEL, 0, NUMA_NO_NODE);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	skb->sk = ctx->ring_sock->sk;
>> +	skb->destructor = unix_destruct_scm;
>> +
>> +	fpl->user = get_uid(ctx->user);
>> +	for (i = 0; i < fpl->count; i++) {
>> +		get_file(fpl->fp[i]);
>> +		unix_inflight(fpl->user, fpl->fp[i]);
>> +		fput(fpl->fp[i]);
>> +	}
>> +
>> +	UNIXCB(skb).fp = fpl;
>> +	skb_queue_head(&ctx->ring_sock->sk->sk_receive_queue, skb);
> 
> This code sounds elegant if you know about the existence of unix_gc(), 
> but quite mysterious if you don't.  (E.g. why "inflight"?)  Could we 
> have a brief comment, to comfort mortal readers on their journey?
> 
> /* A message on a unix socket can hold a reference to a file. This can 
> cause a reference cycle. So there is a garbage collector for unix 
> sockets, which we hook into here. */

Yes that's a good idea, I've added a comment as to why we go through the
trouble of doing this socket + skb dance.

> I think this is bypassing too_many_unix_fds() though?  I understood that 
> was intended to bound kernel memory allocation, at least in principle.

As the code stands above, it'll cap it at 253. I'm just now reworking it
to NOT be limited to the SCM max fd count, but still impose a limit of
1024 on the number of registered files. This is important to cap the
memory allocation attempt as well.

> Also, this code relies on CONFIG_NET.  To handle the case where 
> CONFIG_NET is not enabled, don't you still need to forbid registering an 
> io_uring fd ?

Good point, we do still need to reject the io_uring fd itself if
CONFIG_UNIX is not enabled. Done.

-- 
Jens Axboe

