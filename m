Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504BC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6915A2080D
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 12:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esDOKSg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfBLM3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:29:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBLM3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 07:29:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so2819214wmh.3;
        Tue, 12 Feb 2019 04:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ShyyDc1yUO1OErk+lapjnvgAjevBHSPwQt5swKr7yNY=;
        b=esDOKSg1Z6/gvB19zE/jSIGx3vBHz+JLbjjSpCB7jog+fAMbzRTOVdm+qgG4y2IsNQ
         wJXU4TmyMXL8jGlPJfemDiTP3qm+CVEyzzrfAObq9ZA0wPEW8OV+tTdjCOLWYiAa/q3U
         sZG61CqMq6K1gkXzpIJ2VgjxrDq3r50OalRNJI/dPfgpHLP2PVNKB69K453i0UtW4McV
         mMoWNyAPo1DILfxHCLy78C7EvkVPQ4WkS7rUjrwPTLr2r0JyVrW9ao99gyR7t9vEKI5Q
         wzJ0TrBX6tEiO7jooluobHvOLByeiUQyoG0ZW/oCKdF/Z9943OyoBL0nlVdnFzAxM3iS
         LMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ShyyDc1yUO1OErk+lapjnvgAjevBHSPwQt5swKr7yNY=;
        b=f/JhPh/IQhcECGP/rgz/oT8tXk3Fjc9kyGBDoEXQ9SKtTMCEPAwSj5LxnD0K4M0Q/m
         1Vzv/9gYnYDhIjwRBzUug1xhzozM6oZE9LNZgEvC+yHDUBpHTlrrN0Dt+pd9EuwGTxTI
         JUK3YB4YS4J+Cr6L4+DxGMBx109HZV85erj/6MLy96i2FZddd7ilpVdSMY7CJvDvDdUP
         ZBkJgZY7EDvWgzFhWVqiCOpWLBHcn4pvR+Do0EixDXBpKFF2jGWN1FDof/JLcO5Xv7cU
         cT6UJIw9BWeGDnVPsZCLs2DPM2aYAaPVNHBkYOBPKsE4jzMzKQnjgiIhbqsOOnKPmlbn
         ryKA==
X-Gm-Message-State: AHQUAuYDYsHLCpYNFtQMMExlj5xdx66BlF/RFawGKzHN3Z3jVmMEPDgI
        NWcunCYrZlKSQeOM/XDZQiU=
X-Google-Smtp-Source: AHgI3Ib+pUszB4A+jmcw9BiyyHzjbftxDieoipN+AdqwP7UucFgPoZzPb78/t2aKOkGO3IL3MkVtTw==
X-Received: by 2002:a1c:cc04:: with SMTP id h4mr2963854wmb.13.1549974572087;
        Tue, 12 Feb 2019 04:29:32 -0800 (PST)
Received: from [172.16.8.139] (host-89-243-172-104.as13285.net. [89.243.172.104])
        by smtp.gmail.com with ESMTPSA id a20sm1831141wmj.39.2019.02.12.04.29.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:29:31 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-14-axboe@kernel.dk>
 <bfd383aa-24fb-35ae-eef5-545ab0f493c7@gmail.com>
 <2ac73020-6ab0-e351-3a1a-180d0f1f801b@kernel.dk>
 <02e71636-5b63-41e6-0ffd-646f305011c9@gmail.com>
 <ad669e88-5a33-37e1-6d69-e2b182d89891@kernel.dk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <c2ef6663-3e15-d071-56e3-4afba7b2d778@gmail.com>
Date:   Tue, 12 Feb 2019 12:29:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ad669e88-5a33-37e1-6d69-e2b182d89891@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/02/2019 15:13, Jens Axboe wrote:
> On 2/8/19 7:02 AM, Alan Jenkins wrote:
>> On 08/02/2019 12:57, Jens Axboe wrote:
>>> On 2/8/19 5:17 AM, Alan Jenkins wrote:
>>>>> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
>>>>> +{
>>>>> +#if defined(CONFIG_NET)
>>>>> +	struct scm_fp_list *fpl = ctx->user_files;
>>>>> +	struct sk_buff *skb;
>>>>> +	int i;
>>>>> +
>>>>> +	skb =  __alloc_skb(0, GFP_KERNEL, 0, NUMA_NO_NODE);
>>>>> +	if (!skb)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	skb->sk = ctx->ring_sock->sk;
>>>>> +	skb->destructor = unix_destruct_scm;
>>>>> +
>>>>> +	fpl->user = get_uid(ctx->user);
>>>>> +	for (i = 0; i < fpl->count; i++) {
>>>>> +		get_file(fpl->fp[i]);
>>>>> +		unix_inflight(fpl->user, fpl->fp[i]);
>>>>> +		fput(fpl->fp[i]);
>>>>> +	}
>>>>> +
>>>>> +	UNIXCB(skb).fp = fpl;
>>>>> +	skb_queue_head(&ctx->ring_sock->sk->sk_receive_queue, skb);
>>>> This code sounds elegant if you know about the existence of unix_gc(),
>>>> but quite mysterious if you don't.  (E.g. why "inflight"?)  Could we
>>>> have a brief comment, to comfort mortal readers on their journey?
>>>>
>>>> /* A message on a unix socket can hold a reference to a file. This can
>>>> cause a reference cycle. So there is a garbage collector for unix
>>>> sockets, which we hook into here. */
>>> Yes that's a good idea, I've added a comment as to why we go through the
>>> trouble of doing this socket + skb dance.
>> Great, thanks.
>>
>>>> I think this is bypassing too_many_unix_fds() though?  I understood that
>>>> was intended to bound kernel memory allocation, at least in principle.
>>> As the code stands above, it'll cap it at 253. I'm just now reworking it
>>> to NOT be limited to the SCM max fd count, but still impose a limit of
>>> 1024 on the number of registered files. This is important to cap the
>>> memory allocation attempt as well.
>> I saw you were limiting to SCM_MAX_FD per io_uring.  On the other hand,
>> there's no specific limit on the number of io_urings you can open (only
>> the standard limits on fds).  So this would let you allocate hundreds of
>> times more files than the previous limit RLIMIT_NOFILE...
> But there is, the io_uring itself is under the memlock rlimit.
>
>> static inline bool too_many_unix_fds(struct task_struct *p)
>> {
>> 	struct user_struct *user = current_user();
>>
>> 	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
>> 		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
>> 	return false;
>> }
>>
>> RLIMIT_NOFILE is technically per-task, but here it is capping
>> unix_inflight per-user.  So the way I look at this, the number of file
>> descriptors per user is bounded by NOFILE * NPROC.  Then
>> user->unix_inflight can have one additional process' worth (NOFILE) of
>> "inflight" files.  (Plus SCM_MAX_FD slop, because too_many_fds() is only
>> called once per SCM_RIGHTS).
>>
>> Because io_uring doesn't check too_many_unix_fds(), I think it will let
>> you have about 253 (or 1024) more process' worth of open files. That
>> could be big proportionally when RLIMIT_NPROC is low.
>>
>> I don't know if it matters.  It maybe reads like an oversight though.
>>
>> (If it does matter, it might be cleanest to change too_many_unix_fds()
>> to get rid of the "slop".  Since that may be different between af_unix
>> and io_uring; 253 v.s. 1024 or whatever. E.g. add a parameter for the
>> number of inflight files we want to add.)
> I don't think it matters. The files in the fixed file set have already
> been opened by the application, so it counts towards the number of open
> files that is allowed to have. I don't think we should impose further
> limits on top of that.

A process can open one io_uring and 199 other files.  Register the 199 
files in the io_uring, then close their file descriptors.  The main 
NOFILE limit only counts file descriptors.  So then you can open one 
io_uring, 198 other files, and repeat.

You're right, I had forgotten the memlock limit on io_uring.  That makes 
it much less of a practical problem.

But it raises a second point.  It's not just that it lets users allocate 
more files.  You might not want to be limited by user->unix_inflight.  
But you are calling unix_inflight(), which increments it!  Then if 
unix->inflight exceeds the NOFILE limit, you will avoid seeing any 
errors with io_uring, but the user will not be able to send files over 
unix sockets.

So I think this is confusing to read, and confusing to troubleshoot if 
the limit is ever hit.

I would be happy if io_uring didn't increment user->unix_inflight.  I'm 
not sure what the best way is to arrange that.

Regards
Alan
