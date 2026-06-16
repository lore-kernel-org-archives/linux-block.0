Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FE3546E3
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629755; cv=none; b=EiHqBO3T/lQRwmEP8SZntJyYQ5yM0UwfllHJ+kaf58Lvw+nnG4e+OT6dARwgXTVX8i4RlUAqR+AzEsIDjLU0t7RLGp15Bh30OMQ56cx0LJYbm2W2ovh/CHPCcxlUEsRJMmWZKH1NW1t9cFM7UAgfnbYb/ohVRtzKhlhF2qZROVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629755; c=relaxed/simple;
	bh=SpY6/qEVPg9oghQPGJlbPsb4+ihix+AFmNKEy+OvOf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKAHgaPn62hg70AO1bsWTy0sGBAaElzwTXuPkvdgkCBrCIbL5CbVKstA0FKfZvbTzmfPKbFJq6m+e+xrmIyBmruRFhnLWnXCJry6rWZtgHOv1Qixnhe6EqXd6SQeCMcWjaGHZQVxw9Iveo6jMoZOhRgXb4TsgOefanM1U7AJymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=muErZ+Be; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="muErZ+Be"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6e9408e30so3422269a34.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781629753; x=1782234553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvOVp8Jo4aoHBJxFYIf1f27DnohJ1CxVWMkx0wT+xQQ=;
        b=muErZ+Benmujcx/PSQiSL42A/dYN4A7xltp1BvF2aAkuERtmKk6lPCA7+j0uIBAN/Z
         FydDhE9PY1r7q0zXCZ1iK8WYThfxWWtU+jssXHPoDJP9osSliVjnT4HTp8iNWBlDrP31
         TswpGD/MFWZRTYj3g2G4tshtACcQ4bZ6vd1ghTZLsIbXV32H008PTAMUwvPo2kPZbqGt
         01GXv/HE0HkcYsqUNbc9eekDn+Nd+YTQBDueaUMrOjIJEIEUsOi8zb8iM6gBcxfvNOfi
         inr3LsyEfrB99nRzwHDda84Llc6zilI5GwISf3ef+AQ8hptgw4nuWQC5O2AN3BY+InXF
         1GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629753; x=1782234553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvOVp8Jo4aoHBJxFYIf1f27DnohJ1CxVWMkx0wT+xQQ=;
        b=NOL///ISJwBwpk9i/4pRjzd4jxjh/icTLBpd4PAKRQ975QDZWwLVjaOtga2eYmRxzJ
         7hxXMP4JX2weK+JIz5qXuhgkYuwnRaYjZYQ3+Lc/kcGZk7NGbrIXddbQXPOIfqc39JV6
         mEBNguCOhdVjR/5DdFYygtEBiza4ERQPN5y2Y3flOAfHHuafKZ1VZgbM2wgcBKKlasHH
         JXoYdiopPnOlKROW8TmPyzewdMpahr5H5/uGiyVQef7Aoes//hOCiNV69jopdQigT8u9
         ndV1rzytafLEwQ+urCzvNJOXYQuJAoXLbYRu/3I3Q6UG3R3iQKhp4PlYo9CI+ahJFXje
         qC/A==
X-Gm-Message-State: AOJu0YxseXh0FAZB8iaAzFWu5rpYv/UqQqqlfDriPB3fksGsO6vkcYIQ
	IC2S+dmqamOnNwjN4ZwL14dZ/sWO6w2Q5EzqZEBBb4pz9pcJfSPY1h1BKUUmodc3D/AUjNTgmVb
	2ap/C1IA=
X-Gm-Gg: Acq92OEQVfh3kLRaketZAEyJGH8d0b+R8pUIZ1om7fR9O3AgEIix8znm8s8dpvLShg+
	yoZTaB/3QtfZXABf9FdFe+8c2FMPlBQQLifOx3GVwHXCbpFfYJY0CfiWbqspZxxNs5W556MnudT
	xQeJSQOwbzwVMk24QOZuHesutaKCaPTXO9QhY6QnbO2hZnv5ZmRkDzGk5xb/TYemUEiLpeWPEFe
	rJCvjvdMCdPQvdDryAx5A+ISwn22jaMwLv83ryrKDoWk8pdx8x0h6dMwWhg5sh0kHFmz+Dh0oMJ
	Xck0KoJ+OPwwF6j6/avG24C5XMZWgRIDW1t86UaVK0E0mLUaco6nZRRd7ECyFCpImjHfq/14lTs
	IBhh5rOdPeQ7pzpFEM230ISu/I8y17CxyJBTPn4jCxbNlQAtszP8OXN6KT3W5Z3YyGgS5D6Oy2K
	d/4cgB6f8uYAIRMkkjoM+UmNAHEe1To3r95hKfoY4TT8q4aRT+09mz0aIGcRkfxMq3BSfgJSbXD
	Yi5d3qn4Q==
X-Received: by 2002:a05:6830:4991:b0:7e6:efb8:fe66 with SMTP id 46e09a7af769-7e90b44277cmr437292a34.12.1781629753086;
        Tue, 16 Jun 2026 10:09:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb344sm7488184a34.7.2026.06.16.10.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 10:09:12 -0700 (PDT)
Message-ID: <702baa76-9254-47e9-bc63-0fdd52cf3ade@kernel.dk>
Date: Tue, 16 Jun 2026 11:09:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: invalidate cached plug timestamp on context
 switch
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-block@vger.kernel.org, bsegall@google.com,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
 rostedt@goodmis.org, vincent.guittot@linaro.org, vschneid@redhat.com,
 Usama Arif <usama.arif@linux.dev>, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, riel@surriel.com, kernel-team@meta.com
References: <20260616141604.328820-1-usama.arif@linux.dev>
 <178162611741.2191657.12211870708971600814.b4-ty@b4>
 <43b0010d-1919-4986-a88a-a4ccdb3639dd@kernel.dk>
 <20260616165434.GG49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260616165434.GG49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 10:54 AM, Peter Zijlstra wrote:
> On Tue, Jun 16, 2026 at 10:10:31AM -0600, Jens Axboe wrote:
>> On 6/16/26 10:08 AM, Jens Axboe wrote:
>>>
>>> On Tue, 16 Jun 2026 07:15:16 -0700, Usama Arif wrote:
>>>> The details for this are in patch 2. The main reason for this series
>>>> is to invalidate the cached timestamp on context switch. This was
>>>> done in sched_update_worker() only before which was resulting in
>>>> blk-iocost reading stale timestamps and throttling based on wrong
>>>> information.
>>>>
>>>> Patch 1 is a prerequisite to create the invariant that
>>>> PF_BLOCK_TS set implies current->plug != NULL.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/2] kernel/fork: clear PF_BLOCK_TS in copy_process()
>>>       commit: fd38b75c4b43295b10d69772a46d1c74dbd6fc81
>>> [2/2] block: invalidate cached plug timestamp after task switch
>>>       commit: fad156c2af227f42ca796cbb20ddc354a6dd9932
>>
>> Note: I tentatively queued this on up as a) it looks good to me (and
>> thanks Usama for fixing this!), and b) about to head OOO for a week
>> or so. If Peter or any of the sched people disagree, let me know and
>> we can deal with it. If not, then I plan on sending this in with the
>> usual follow-up merge window fixes next week.
> 
> FWIW, looks good to me.

Great, thanks Peter!

-- 
Jens Axboe
