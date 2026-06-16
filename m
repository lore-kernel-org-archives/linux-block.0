Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F033A9627
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626236; cv=none; b=J7lT+ZRa5NR1J+tFgUhMqlhsZQFFu4aeSvNhUpY4Xps/YWnRitCmjPKjWmBmH+uKkGI5ohom3B6XPRp9RgcGKqyGyWrChmRx83rnnuf9OqeYuIu+wsVc/P73kFRr4xwn4NCHJv5P5eywF2xRVpHCKHl7TxmKJbhAZBsprgTjfSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626236; c=relaxed/simple;
	bh=ZV+xMH+L7BMRzWOOqDkrUDIdbUeOcQL0cKT6SNdrrdg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mmeXNRCvjxLgaxgPxkSAdA/BReW4XuCqWdfFaDNv/QehGgbKvuu9IoioLx3E+rZ1TOEpg5q4dni55M74FjGS806UYiA77i4eP9LDoxjXi4ljDwMWl/lQpxjcNyfovG/rXCBjy8LzgIArnaXcFaQx3MLJLDWBzWtkC++4fdTrhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=XpKlGmCt; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="XpKlGmCt"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69e1eae4eb4so3737881eaf.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781626233; x=1782231033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=56DhKWo0xpbgLuTWFrIz2/RO4Hguie7F0SMBKzrcigY=;
        b=XpKlGmCtWrn7NAe1RipSziWBUraJP6e7PKDrSjIAVOmFGCk0rb4XqD7A2XCzvsdwE4
         CBtqDOdIbes+ub+8XafWV387wQCWwqzep5kp4m+ryegxkScuiTTkwlM+0HOBhkPxcPQu
         XfBJgbxWP9bIgHblH1DY6h/v9Qq85IG9HgKCi2ThkduNU0lmjJngYDaA0lYQyyIpJSNh
         +8STB4FKPWeskblSiVC5Y880rF7zYByD2UJkGj+xJb8dV7JaQOHczg8GTSYXogzEH27+
         QRS72/lpe1zGKGDicgscF+LNoEmZ5XADQhLQji4Smqm3AY+3+3ZqrYz0aDfVV6WXHETN
         bchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626233; x=1782231033;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56DhKWo0xpbgLuTWFrIz2/RO4Hguie7F0SMBKzrcigY=;
        b=OxomeA9kmieLujiy+QvVkUzrcX1xvDy+9vWpraCYjucdjXZ7ph8BLI0HMEbFdALHX2
         D7tsM/RXuVDkAm68snn3/K8QqIPitACEhazAYXQ6I7YPEJo7GOaJm0hH95VKZ80qwU2b
         CdZTa7QeoKBlk/fu32EnDGgFBFHAEb1hkN9SUhLqjv8akvPZ0tsv3A5YaCequyTANZq5
         XuIQW4dw6k6WZXJ+yZaNuWcTsnhmRsXg1odc2wo0fhKNtrVWKQxafrP3gZhUvI5YL8J4
         jUlmhvdeUFTSzaXajPplYloToryerAFlH6+TR21lwl1rzRijjPPDp3kIKuYUzZcRR0iq
         EL6g==
X-Gm-Message-State: AOJu0YyD4KjFKxJDRwOCxa2kprugm2EVB2PPehduTdniYM1pl56qB085
	3/SsahBi7jfIx4u8VYSJYleUkzm4v7636Uf9FxSEIewqQ9cWfmhyHTutTbJAADvKJzuZcm2msiv
	aIVvynv8=
X-Gm-Gg: Acq92OENGGrecm+6/vl+wKtOls1GWmWQfCQBFGJSXhBA9gOSQ+58zvt1ClRT8rtB8ko
	L8ZbpcHdpFWPgX2GdGxQx9kitP5sB8fpq8wIBDi7/ost8u6yRaZGgzCV8fUUHsDBELo/3BpLTYP
	9wf+9LbBHDs87+rvJ6nr27uy8F04GcKGkzRgfqDGSvaafFAyclT30/+iG56U44gd7PMZcjXifaC
	hX+CmpGppRrTQze9K4kepu3/XKWokj3KUW6RHnacl93/AhRgpqHBozFoyLqLwrBwH156nz+ViW8
	3j2fOqbUxR61zJhUqCHapc7J+xi9Cceucjdq+4+yUjCy/Dk95TIb3VOmfG70zoxpRSoZCW1t/B2
	Gaad/MbkBeqkK1b+KlhwK2ExfjbcvdbCxpnwka2qL2WmomACB68YoBkWR1a13+OP5HdKrZIQCB+
	0Z9CqRAlARh8CLWj8LRT0rhAu+RNaAXzyY91yp6EbK6SFQQtjlbk3grpMrmSBjE0onYZOhV/ZpM
	O4WPlkKYQ==
X-Received: by 2002:a05:6820:c453:20b0:6a0:acaa:e840 with SMTP id 006d021491bc7-6a0acaaecbdmr1004279eaf.13.1781626233541;
        Tue, 16 Jun 2026 09:10:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-443090386basm2370147fac.17.2026.06.16.09.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 09:10:33 -0700 (PDT)
Message-ID: <43b0010d-1919-4986-a88a-a4ccdb3639dd@kernel.dk>
Date: Tue, 16 Jun 2026 10:10:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: invalidate cached plug timestamp on context
 switch
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, bsegall@google.com,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
 vschneid@redhat.com, Usama Arif <usama.arif@linux.dev>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
 kernel-team@meta.com
References: <20260616141604.328820-1-usama.arif@linux.dev>
 <178162611741.2191657.12211870708971600814.b4-ty@b4>
Content-Language: en-US
In-Reply-To: <178162611741.2191657.12211870708971600814.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 10:08 AM, Jens Axboe wrote:
> 
> On Tue, 16 Jun 2026 07:15:16 -0700, Usama Arif wrote:
>> The details for this are in patch 2. The main reason for this series
>> is to invalidate the cached timestamp on context switch. This was
>> done in sched_update_worker() only before which was resulting in
>> blk-iocost reading stale timestamps and throttling based on wrong
>> information.
>>
>> Patch 1 is a prerequisite to create the invariant that
>> PF_BLOCK_TS set implies current->plug != NULL.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] kernel/fork: clear PF_BLOCK_TS in copy_process()
>       commit: fd38b75c4b43295b10d69772a46d1c74dbd6fc81
> [2/2] block: invalidate cached plug timestamp after task switch
>       commit: fad156c2af227f42ca796cbb20ddc354a6dd9932

Note: I tentatively queued this on up as a) it looks good to me (and
thanks Usama for fixing this!), and b) about to head OOO for a week
or so. If Peter or any of the sched people disagree, let me know and
we can deal with it. If not, then I plan on sending this in with the
usual follow-up merge window fixes next week.

-- 
Jens Axboe

