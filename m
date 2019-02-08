Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF802C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861CE2146E
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULS4FUtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfBHOCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:02:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46703 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfBHOCd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 09:02:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so3630122wrt.13;
        Fri, 08 Feb 2019 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+I7WE4s+seIoiw3+TGtWhODGeNkLoP8MWApw4w2Zqk4=;
        b=ULS4FUtnnrqhzoNzw9YM+GaJYArxxc+R9RYbfs7FjRYVX5ScyqYmxnplgM5vvmkFcD
         wlPGnLjFkycNBFQjauzmrNxL26y9+RKo4Der0KakfhqXuVbQTx4h0b8vUp6o2MW2V7KK
         MM9H2IFUX0CnZfDnBp78F1ngdvp4lh8dK8ozmjafsS+KqrE2xIrIdfEq+API6Z0ehZL6
         CMGmCMUWGZ8NsSoRnq7L+aKZkqYk8K/yw/iTRzH6ueVeOe9LJr+kt8sgCFoIW2jOm5s+
         KbmvVUm02rAHIGaT0d4PDqwhRSm88YxD56RfiasKJxj5j7eFy9j4nBnnsfpyiJ0jS4tU
         NOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+I7WE4s+seIoiw3+TGtWhODGeNkLoP8MWApw4w2Zqk4=;
        b=qxPURvoD2RnEIBU7FGcQWo7ctgT4tX/lxyMtjJUAlGIafgLp8NmDjoYREkvs3I7dYY
         VECTa502s6c26zLXBOSfJjH1qAgBNyvPSL/H+YS8muoOp0jUUICV0qu3kzDeZD1VTd86
         Y6/X/VbB0McCXCMHlBIAKl+ctKDo73R5VWOyueVqsm1BCmWqXrWygXKUS23jbHTcknXl
         Xen3FGP926LQHW39/YV7GNN8MVhIcHz2Y1xTXj7/tPmckMXDppHBJNmOs/WeFIh3WNHs
         Qe0w84+9jcDIj/56iZGwqFOvuQ5lwU4rshdrfbqzptISE7KHFjbsSJtU2qjAoQN/CB3/
         jCtw==
X-Gm-Message-State: AHQUAuYB+6wgRz272Jeh9Km6s4HxolaOTUASD8lLFEgsBiV8bOg0CQ1S
        JHAGw+Eq0ipxgFvBGODHdpI=
X-Google-Smtp-Source: AHgI3IbyZdKsEF6TGz/5YpIJts3GxtQ2ddRdU6FFGAdNwJ7II+jHXb6X4nIk7pMSSKZw2etceYolqw==
X-Received: by 2002:adf:9dc4:: with SMTP id q4mr4723171wre.330.1549634551136;
        Fri, 08 Feb 2019 06:02:31 -0800 (PST)
Received: from [172.16.8.139] (host-89-243-172-104.as13285.net. [89.243.172.104])
        by smtp.gmail.com with ESMTPSA id j24sm3254832wrd.86.2019.02.08.06.02.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:02:30 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-14-axboe@kernel.dk>
 <bfd383aa-24fb-35ae-eef5-545ab0f493c7@gmail.com>
 <2ac73020-6ab0-e351-3a1a-180d0f1f801b@kernel.dk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <02e71636-5b63-41e6-0ffd-646f305011c9@gmail.com>
Date:   Fri, 8 Feb 2019 14:02:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2ac73020-6ab0-e351-3a1a-180d0f1f801b@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/02/2019 12:57, Jens Axboe wrote:
> On 2/8/19 5:17 AM, Alan Jenkins wrote:
>>> +static int io_sqe_files_scm(struct io_ring_ctx *ctx)
>>> +{
>>> +#if defined(CONFIG_NET)
>>> +	struct scm_fp_list *fpl = ctx->user_files;
>>> +	struct sk_buff *skb;
>>> +	int i;
>>> +
>>> +	skb =  __alloc_skb(0, GFP_KERNEL, 0, NUMA_NO_NODE);
>>> +	if (!skb)
>>> +		return -ENOMEM;
>>> +
>>> +	skb->sk = ctx->ring_sock->sk;
>>> +	skb->destructor = unix_destruct_scm;
>>> +
>>> +	fpl->user = get_uid(ctx->user);
>>> +	for (i = 0; i < fpl->count; i++) {
>>> +		get_file(fpl->fp[i]);
>>> +		unix_inflight(fpl->user, fpl->fp[i]);
>>> +		fput(fpl->fp[i]);
>>> +	}
>>> +
>>> +	UNIXCB(skb).fp = fpl;
>>> +	skb_queue_head(&ctx->ring_sock->sk->sk_receive_queue, skb);
>> This code sounds elegant if you know about the existence of unix_gc(),
>> but quite mysterious if you don't.  (E.g. why "inflight"?)  Could we
>> have a brief comment, to comfort mortal readers on their journey?
>>
>> /* A message on a unix socket can hold a reference to a file. This can
>> cause a reference cycle. So there is a garbage collector for unix
>> sockets, which we hook into here. */
> Yes that's a good idea, I've added a comment as to why we go through the
> trouble of doing this socket + skb dance.

Great, thanks.

>> I think this is bypassing too_many_unix_fds() though?  I understood that
>> was intended to bound kernel memory allocation, at least in principle.
> As the code stands above, it'll cap it at 253. I'm just now reworking it
> to NOT be limited to the SCM max fd count, but still impose a limit of
> 1024 on the number of registered files. This is important to cap the
> memory allocation attempt as well.

I saw you were limiting to SCM_MAX_FD per io_uring.  On the other hand, 
there's no specific limit on the number of io_urings you can open (only 
the standard limits on fds).  So this would let you allocate hundreds of 
times more files than the previous limit RLIMIT_NOFILE...

static inline bool too_many_unix_fds(struct task_struct *p)
{
	struct user_struct *user = current_user();

	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
	return false;
}

RLIMIT_NOFILE is technically per-task, but here it is capping 
unix_inflight per-user.  So the way I look at this, the number of file 
descriptors per user is bounded by NOFILE * NPROC.  Then 
user->unix_inflight can have one additional process' worth (NOFILE) of 
"inflight" files.  (Plus SCM_MAX_FD slop, because too_many_fds() is only 
called once per SCM_RIGHTS).

Because io_uring doesn't check too_many_unix_fds(), I think it will let 
you have about 253 (or 1024) more process' worth of open files. That 
could be big proportionally when RLIMIT_NPROC is low.

I don't know if it matters.  It maybe reads like an oversight though.

(If it does matter, it might be cleanest to change too_many_unix_fds() 
to get rid of the "slop".  Since that may be different between af_unix 
and io_uring; 253 v.s. 1024 or whatever. E.g. add a parameter for the 
number of inflight files we want to add.)

>> Also, this code relies on CONFIG_NET.  To handle the case where
>> CONFIG_NET is not enabled, don't you still need to forbid registering an
>> io_uring fd ?
> Good point, we do still need to reject the io_uring fd itself if
> CONFIG_UNIX is not enabled. Done.
