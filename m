Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA701DFC4
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710728742; cv=none; b=byi53BTE2CXLh+oNZR/aT2h9xrfgd9dDx5lkHVkM3UAP4Lu/YEoIPVaNQ85P0MrfurIuxcuGhOsAOxT6UzMymRbgoGFDsuXuPQRc9e7HpQ18OXQvCmE7GQeghOfFinzySGSwB3L8PziuyPmDRg3LGCouCDrvmaqXMr+T1rcBA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710728742; c=relaxed/simple;
	bh=830yeIiYSt8KnsKpNcjt1vrw1zNe4pYgqpqJB3wSzBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNRHDsLClNt0LLFBeMVlkIX8dmI6StxT/Ik0XxHd88FEVdwOisqqi38dntTs6jpRgQMcMdpzNQVNkk1RHFefCOsneRr0co6L0lkcAz0OFPWHNNSi8rKzLTjAkUa//xRQvfH1lGo7Z+bjI0b5JpQqyPpHLrzf0jE3eoxqJVyQLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GPurMK2i; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GPurMK2i"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6c18e9635so1056034b3a.1
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 19:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710728738; x=1711333538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzfTtmgC7f1d6ByGyKi4beyu/Q4BGc1/1EYW4f5E0xM=;
        b=GPurMK2iRWbhLMWKWGH4XGi0GFvYNK7+gkFIgYib4Qe/9Uag2d3iqemRilvq2VXFXv
         9nnEaiFbvFdgT6r8nPt+yp/h6qW5bBCTBZoZuE6B5ltKKnqmOyy6B8ggTE0853/hptUm
         Qxb8WmOy4Wnpxq5vt7116MIfKHSNGDzmhXOjA6i4MWl/dmUif2ynnB6EOMDLXYobxMRr
         speF6jQF10MRa9+l1RKviZR4dR6qhW+uMAXqqp54ZuUVUJ7QHaJlk4asRtHREJIpDlgM
         lviLAVKDjIJGfN2rl7l0XGO4x0Tk2KkVwNS1NVDQq1xNQUTcL5hY5/tFxymo4dXi0kLA
         74QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710728738; x=1711333538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzfTtmgC7f1d6ByGyKi4beyu/Q4BGc1/1EYW4f5E0xM=;
        b=G7fhTYsxBz+Tn6+3UxJn24Uzum8/wEnTTxT0LtGZYwrlwy5yJDuu5EIdXmDghdhp3s
         3mNPKDSSrYpg0YhEbOFhaO/eajWzpXyK9YwY/NMFL70+zcXzjlxSCPeMEmVFTvSJ6J0O
         CMkmjFeO+lpiZquju51rzLpYIR25+bMJYKbbj7VxqIkVq1QUSDJe4UYcyy8QpFK0qNFy
         9r33YSjA+MPkvfFk/uxjIbdh5BrPSQ0LhVeZuIGvb0JR/qY0rgPohAG2KlNn12mDrSBa
         6Bo2j+AuRDmHwt03QSyPPljENvAE77szAPvocJAYlhIlJu3hp/vF+1rcA7Ai0eja2xtw
         PRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvWVRz1WbbnLSH/vHv1KhpX+9aX34aLFBhYImY69/vtb7F+6gCORUpHN+Oh0d07/WXDTTgumHc0o9lD3oOy6gJp68vN1xRrmodv8g=
X-Gm-Message-State: AOJu0Yzbf4kQSlWRXlvM4+x+e8myDWvsk0s0mDJB3BqxI4w773lbsbU0
	qUnU8la22Y0xQ+6aTfq3dnFIp2uX5eoQ3ULgb6ev9hwkHYer3b3cAF0pltPxR9Q=
X-Google-Smtp-Source: AGHT+IFrcVx1K4mfhYy0KguCrafLi7pQSftH54Ehhs5LbysuzinXm5bpYzyjxkXzWiAF6ID8UXV2WA==
X-Received: by 2002:a05:6a20:3ca7:b0:1a3:5f13:e447 with SMTP id b39-20020a056a203ca700b001a35f13e447mr4988635pzj.0.1710728738504;
        Sun, 17 Mar 2024 19:25:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090aca9000b0029de1e54bcesm6279352pjt.18.2024.03.17.19.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 19:25:37 -0700 (PDT)
Message-ID: <e987d48d-09c9-4b7d-9ddc-1d90f15a1bfe@kernel.dk>
Date: Sun, 17 Mar 2024 20:25:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] io_uring/cmd: fix tw <-> issue_flags conversion
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 Kanchan Joshi <joshi.k@samsung.com>
References: <cover.1710720150.git.asml.silence@gmail.com>
 <c48a7f3919eecbee0319020fd640e6b3d2e60e5f.1710720150.git.asml.silence@gmail.com>
 <Zfelt6mbVA0moyq6@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zfelt6mbVA0moyq6@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 8:23 PM, Ming Lei wrote:
> On Mon, Mar 18, 2024 at 12:41:47AM +0000, Pavel Begunkov wrote:
>> !IO_URING_F_UNLOCKED does not translate to availability of the deferred
>> completion infra, IO_URING_F_COMPLETE_DEFER does, that what we should
>> pass and look for to use io_req_complete_defer() and other variants.
>>
>> Luckily, it's not a real problem as two wrongs actually made it right,
>> at least as far as io_uring_cmd_work() goes.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> Link: https://lore.kernel.org/r/eb08e72e837106963bc7bc7dccfd93d646cc7f36.1710514702.git.asml.silence@gmail.com
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  io_uring/uring_cmd.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>> index f197e8c22965..ec38a8d4836d 100644
>> --- a/io_uring/uring_cmd.c
>> +++ b/io_uring/uring_cmd.c
>> @@ -56,7 +56,11 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
>>  static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
>>  {
>>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
>> -	unsigned issue_flags = ts->locked ? 0 : IO_URING_F_UNLOCKED;
>> +	unsigned issue_flags = IO_URING_F_UNLOCKED;
>> +
>> +	/* locked task_work executor checks the deffered list completion */
>> +	if (ts->locked)
>> +		issue_flags = IO_URING_F_COMPLETE_DEFER;
>>  
>>  	ioucmd->task_work_cb(ioucmd, issue_flags);
>>  }
>> @@ -100,7 +104,9 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2,
>>  	if (req->ctx->flags & IORING_SETUP_IOPOLL) {
>>  		/* order with io_iopoll_req_issued() checking ->iopoll_complete */
>>  		smp_store_release(&req->iopoll_completed, 1);
>> -	} else if (!(issue_flags & IO_URING_F_UNLOCKED)) {
>> +	} else if (issue_flags & IO_URING_F_COMPLETE_DEFER) {
>> +		if (WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED))
>> +			return;
>>  		io_req_complete_defer(req);
>>  	} else {
>>  		req->io_task_work.func = io_req_task_complete;
> 
> 'git-bisect' shows the reported warning starts from this patch.

That does make sense, as probably:

+	/* locked task_work executor checks the deffered list completion */
+	if (ts->locked)
+		issue_flags = IO_URING_F_COMPLETE_DEFER;

this assumption isn't true, and that would mess with the task management
(which is in your oops).

-- 
Jens Axboe

