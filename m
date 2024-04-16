Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9D12BE89
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270921; cv=none; b=iI85BrUogTwbTNYF255yicmTFPwDV1lq6FLUAn8qqj3dg1dae7Zpr7HWZ60CkTGg6xOiwb7qMU5uZjRtP5lKvx+qfIUWlKONoXBIFa8oALIjq3sOGLqsvgoADacFRgUzq0C6A3UsKEk0JY39W1I+v64XvDyIKaTlsp0y1wVTttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270921; c=relaxed/simple;
	bh=inWWdj9MvNGDdrtqvILd/lof8eBjNVW6tXkg1e4JIh4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R3Z+URc3eP6fcPWlXnNEPf78zAEN6J5+Km0R2aSGIDLzFAg7DQhjGSiYUfFPY63TMgQQknsz9UFkXfr88JUnxxuRV6XjSVxQL49aBmG4np8wLh1vpJkK8yNOrut76W9xPNV4u3RBQk2VDMfg7omouZpK4bJoBxi3VFLGVNf5e4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U1oRutYV; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U1oRutYV"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d9c78d7f98so2514139f.2
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713270917; x=1713875717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Df4rgDVrySDoPOTdCVc9E7p+LHXWB+uc53nXNreymTs=;
        b=U1oRutYVsF/r65YDG5JvcEaaReSqcp56u3zjN9bwoBhAPn3ygnC0BCH5MPnV7Zezg+
         4LzLM3aFKaKCgwNlEfgNq+K5uGdYh6/PaKqZiy+ef562hOjzmWC5PvxnmOl4Z9ItenZF
         UCo0reS9O/+Y8Lf0l4w/VwwdXW9gzkSmMB8l4qMeEoCV3jrqBkHdr2Ov1HfagwPeUvoQ
         c2SHkbA8SHVGH45E0cUzBWsVrYYxJOk6l28B/9/DrUTqcMN/bmbrA6aRa/rQ3pXnP+8b
         ZtifGR/hld/cbw0lUlbMD57D0ffTtw8H3kyfhc+JKjtmdfddYPXSU+IzyR3Lz5m0wNXf
         xzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270917; x=1713875717;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Df4rgDVrySDoPOTdCVc9E7p+LHXWB+uc53nXNreymTs=;
        b=m8MClLufZj0j3l1jHWCvLcjBg1/cYwlf1A9uT92O8c7dIuJ9xfK5Uh3BuoPEd5Dk1C
         6g4ZPqCdh6ldLN+1O5vukKx2EYX6QI7jZz8Sv3tSpxZcolPAzS+XP8GduIe6ZHLjZVAC
         OEf8pO8Wf55LOLNXJA6jbqZmqSzjU2foM6EHx5q22txS0AEp8Js1n3q9TWnUO/oozoVt
         /5o4Pwyxd+cUyB/evUYsQKj2jXAQ7adbC4yVtxsJjgYOz4/tKoTWATqEKh0kMbYCQ9LB
         8ClXrHIPMPg1qrXjcsGkyEojSn4onpKr1THLCl0E5xvECzZTClC9Ia4rKsS3c7mrsI7F
         rBaQ==
X-Gm-Message-State: AOJu0Yydnjf0uHcdzePE8xMLST+XkeQWBOP19BvUQjqwOQo+QAjbjw8N
	vtNU6XzQXVr15eBLC0ZJKpPWnoVAtJ+Fu/mMq9mIcWBwZKEyF1xgNvB+EYxeunQFnBmGfdjYnBb
	y
X-Google-Smtp-Source: AGHT+IHE3/df/mMKYE3wCXk8JCvY0v0s7HOj4owkV1dEBLH20u6VPMQ+8RoEVPInGIjyJs/7VTLaVQ==
X-Received: by 2002:a05:6e02:194f:b0:369:e37d:541f with SMTP id x15-20020a056e02194f00b00369e37d541fmr15028939ilu.1.1713270916632;
        Tue, 16 Apr 2024 05:35:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id a24-20020a656558000000b005dc36279d6dsm7555582pgw.73.2024.04.16.05.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 05:35:16 -0700 (PDT)
Message-ID: <6db8b3eb-9e66-4df2-bde1-c5c7dde74b3b@kernel.dk>
Date: Tue, 16 Apr 2024 06:35:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at io_uring/io_uring.c:2835
 io_ring_exit_work+0x2b6/0x2e0
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk> <Zh3TjqD1763LzXUj@fedora>
 <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
 <Zh5MSQVk54tN7Xx4@fedora> <28cc0bbb-fa85-48f1-9c8a-38d7ecf6c67e@kernel.dk>
In-Reply-To: <28cc0bbb-fa85-48f1-9c8a-38d7ecf6c67e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 5:38 AM, Jens Axboe wrote:
> On 4/16/24 4:00 AM, Ming Lei wrote:
>> On Tue, Apr 16, 2024 at 10:26:16AM +0800, Changhui Zhong wrote:
>>>>>
>>>>> I can't reproduce this here, fwiw. Ming, something you've seen?
>>>>
>>>> I just test against the latest for-next/block(-rc4 based), and still can't
>>>> reproduce it. There was such RH internal report before, and maybe not
>>>> ublk related.
>>>>
>>>> Changhui, if the issue can be reproduced in your machine, care to share
>>>> your machine for me to investigate a bit?
>>>>
>>>> Thanks,
>>>> Ming
>>>>
>>>
>>> I still can reproduce this issue on my machine?
>>> and I shared machine to Ming?he can do more investigation for this issue?
>>>
>>> [ 1244.207092] running generic/006
>>> [ 1246.456896] blk_print_req_error: 77 callbacks suppressed
>>> [ 1246.456907] I/O error, dev ublkb1, sector 2395864 op 0x1:(WRITE)
>>> flags 0x8800 phys_seg 1 prio class 0
>>
>> The failure is actually triggered in recovering qcow2 target in generic/005,
>> since ublkb0 isn't removed successfully in generic/005.
>>
>> git-bisect shows that the 1st bad commit is cca6571381a0 ("io_uring/rw:
>> cleanup retry path").
>>
>> And not see any issue in uring command side, so the trouble seems
>> in normal io_uring rw side over XFS file, and not related with block
>> device.
> 
> Indeed, I can reproduce it on XFS as well. I'll take a look.

Can you try this one?


diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3c9087f37c43..c67ae6e36c4f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -527,6 +527,19 @@ static void io_queue_iowq(struct io_kiocb *req)
 		io_queue_linked_timeout(link);
 }
 
+static void io_tw_requeue_iowq(struct io_kiocb *req, struct io_tw_state *ts)
+{
+	req->flags &= ~REQ_F_REISSUE;
+	io_queue_iowq(req);
+}
+
+void io_tw_queue_iowq(struct io_kiocb *req)
+{
+	req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+	req->io_task_work.func = io_tw_requeue_iowq;
+	io_req_task_work_add(req);
+}
+
 static __cold void io_queue_deferred(struct io_ring_ctx *ctx)
 {
 	while (!list_empty(&ctx->defer_list)) {
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 624ca9076a50..b83a719c5443 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -75,6 +75,7 @@ struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
 void __io_req_task_work_add(struct io_kiocb *req, unsigned flags);
 bool io_alloc_async_data(struct io_kiocb *req);
 void io_req_task_queue(struct io_kiocb *req);
+void io_tw_queue_iowq(struct io_kiocb *req);
 void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts);
 void io_req_task_queue_fail(struct io_kiocb *req, int ret);
 void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 3134a6ece1be..4fed829fe97c 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -455,7 +455,7 @@ static bool __io_complete_rw_common(struct io_kiocb *req, long res)
 			 * current cycle.
 			 */
 			io_req_io_end(req);
-			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+			io_tw_queue_iowq(req);
 			return true;
 		}
 		req_set_fail(req);
@@ -521,7 +521,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 		io_req_end_write(req);
 	if (unlikely(res != req->cqe.res)) {
 		if (res == -EAGAIN && io_rw_should_reissue(req)) {
-			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+			io_tw_queue_iowq(req);
 			return;
 		}
 		req->cqe.res = res;
@@ -839,7 +839,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 	ret = io_iter_do_read(rw, &io->iter);
 
 	if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
-		req->flags &= ~REQ_F_REISSUE;
+		if (req->flags & REQ_F_REISSUE)
+			return IOU_ISSUE_SKIP_COMPLETE;
 		/* If we can poll, just do that. */
 		if (io_file_can_poll(req))
 			return -EAGAIN;
@@ -1034,10 +1035,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	else
 		ret2 = -EINVAL;
 
-	if (req->flags & REQ_F_REISSUE) {
-		req->flags &= ~REQ_F_REISSUE;
-		ret2 = -EAGAIN;
-	}
+	if (req->flags & REQ_F_REISSUE)
+		return IOU_ISSUE_SKIP_COMPLETE;
 
 	/*
 	 * Raw bdev writes will return -EOPNOTSUPP for IOCB_NOWAIT. Just

-- 
Jens Axboe

