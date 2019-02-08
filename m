Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA43C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E872146E
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MWxZ0zHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBHPNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:13:22 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51074 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfBHPNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 10:13:22 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so9547304iti.0
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pMObUi19GEotYT2OyzsOXFhyUa3pxX6yfzE6BHtNrbg=;
        b=MWxZ0zHLkLw7jsAa/qtyizopdU+Lzc+g/WkAyCf8ZEVa3GJ8Bvox+E/ZccZcO6XrQe
         nnMLmttfDCa1Qv42L96wXm8rHnHf1eUWPQsXAut+huJ0cxK4dscXEsrd0YiKDm7XBghr
         Pho2oxQsfISiDlnuLjZnx8Re8NxYUfW1D19M61W5xlcoCPctP/uLqaTLOpsEOu9GyKXs
         eeO0plaGngiqSLuDthnzCl8Eg4GLiYYNPjG2MKcDeSbQU0uIBxJvkC2MUY1lx+J2N1bx
         Chc8H/KeYruIq0Zo6asyYfw19Mxb/gB29Ob4ASKugr2jcbwKA9oymawnkbU4YFZAfRTN
         157g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pMObUi19GEotYT2OyzsOXFhyUa3pxX6yfzE6BHtNrbg=;
        b=mRzHMFRiYVcAidD/wOjunJH8YeaA1chM/jm6F38emGHwYfBlZgSg9tG9FiWn7Bt4uP
         IO6rFwMul19IKZoSiOa++kBrul0IbegBQlPwwSCmrzxppIgspFa6TPJb9prNQHKxuYkP
         hdDTu+pozwPF1k/zOw367IfQ7zYD4QMk4+wx8NFLLII8JtECZxRfuOhsIzSEvqGNh4FM
         U3M5Agq6G0SnakH9RCM8nNX5t0L1dmCbGyDuYfd5hslHWPDF5WuJkBbp2k2fMrFq82D6
         76TKQTfybdkay10z1wzOcwkvQSJz7kh6F43zHQXOCWT5Y4Z/uGmX5k17SYrTU22UT/Kc
         fhmA==
X-Gm-Message-State: AHQUAuZON6LB2X2EJBWKGFsVF9W8tIpeU0VvekiqLOm441CmLsxMzzvj
        0fLEQT8GXhu4sU5dqn9sIqvA3g==
X-Google-Smtp-Source: AHgI3IYO+G8i3rZsp2MQOQZIG5XhgvZQ5UjikKQTfUFul5IRhxlURt/vPnJzyHSv3fHy68JXWNOTBg==
X-Received: by 2002:a24:80d2:: with SMTP id g201mr9113069itd.63.1549638801257;
        Fri, 08 Feb 2019 07:13:21 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b22sm935356ios.45.2019.02.08.07.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:13:20 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-14-axboe@kernel.dk>
 <bfd383aa-24fb-35ae-eef5-545ab0f493c7@gmail.com>
 <2ac73020-6ab0-e351-3a1a-180d0f1f801b@kernel.dk>
 <02e71636-5b63-41e6-0ffd-646f305011c9@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad669e88-5a33-37e1-6d69-e2b182d89891@kernel.dk>
Date:   Fri, 8 Feb 2019 08:13:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <02e71636-5b63-41e6-0ffd-646f305011c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 7:02 AM, Alan Jenkins wrote:
> On 08/02/2019 12:57, Jens Axboe wrote:
>> On 2/8/19 5:17 AM, Alan Jenkins wrote:
>>>> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
>>>> +{
>>>> +#if defined(CONFIG_NET)
>>>> +	struct scm_fp_list *fpl = ctx->user_files;
>>>> +	struct sk_buff *skb;
>>>> +	int i;
>>>> +
>>>> +	skb =  __alloc_skb(0, GFP_KERNEL, 0, NUMA_NO_NODE);
>>>> +	if (!skb)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	skb->sk = ctx->ring_sock->sk;
>>>> +	skb->destructor = unix_destruct_scm;
>>>> +
>>>> +	fpl->user = get_uid(ctx->user);
>>>> +	for (i = 0; i < fpl->count; i++) {
>>>> +		get_file(fpl->fp[i]);
>>>> +		unix_inflight(fpl->user, fpl->fp[i]);
>>>> +		fput(fpl->fp[i]);
>>>> +	}
>>>> +
>>>> +	UNIXCB(skb).fp = fpl;
>>>> +	skb_queue_head(&ctx->ring_sock->sk->sk_receive_queue, skb);
>>> This code sounds elegant if you know about the existence of unix_gc(),
>>> but quite mysterious if you don't.  (E.g. why "inflight"?)  Could we
>>> have a brief comment, to comfort mortal readers on their journey?
>>>
>>> /* A message on a unix socket can hold a reference to a file. This can
>>> cause a reference cycle. So there is a garbage collector for unix
>>> sockets, which we hook into here. */
>> Yes that's a good idea, I've added a comment as to why we go through the
>> trouble of doing this socket + skb dance.
> 
> Great, thanks.
> 
>>> I think this is bypassing too_many_unix_fds() though?  I understood that
>>> was intended to bound kernel memory allocation, at least in principle.
>> As the code stands above, it'll cap it at 253. I'm just now reworking it
>> to NOT be limited to the SCM max fd count, but still impose a limit of
>> 1024 on the number of registered files. This is important to cap the
>> memory allocation attempt as well.
> 
> I saw you were limiting to SCM_MAX_FD per io_uring.  On the other hand, 
> there's no specific limit on the number of io_urings you can open (only 
> the standard limits on fds).  So this would let you allocate hundreds of 
> times more files than the previous limit RLIMIT_NOFILE...

But there is, the io_uring itself is under the memlock rlimit.

> static inline bool too_many_unix_fds(struct task_struct *p)
> {
> 	struct user_struct *user = current_user();
> 
> 	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
> 		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
> 	return false;
> }
> 
> RLIMIT_NOFILE is technically per-task, but here it is capping 
> unix_inflight per-user.  So the way I look at this, the number of file 
> descriptors per user is bounded by NOFILE * NPROC.  Then 
> user->unix_inflight can have one additional process' worth (NOFILE) of 
> "inflight" files.  (Plus SCM_MAX_FD slop, because too_many_fds() is only 
> called once per SCM_RIGHTS).
> 
> Because io_uring doesn't check too_many_unix_fds(), I think it will let 
> you have about 253 (or 1024) more process' worth of open files. That 
> could be big proportionally when RLIMIT_NPROC is low.
> 
> I don't know if it matters.  It maybe reads like an oversight though.
> 
> (If it does matter, it might be cleanest to change too_many_unix_fds() 
> to get rid of the "slop".  Since that may be different between af_unix 
> and io_uring; 253 v.s. 1024 or whatever. E.g. add a parameter for the 
> number of inflight files we want to add.)

I don't think it matters. The files in the fixed file set have already
been opened by the application, so it counts towards the number of open
files that is allowed to have. I don't think we should impose further
limits on top of that.

-- 
Jens Axboe

