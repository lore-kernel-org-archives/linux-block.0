Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468511;
	b=nMuEWWznvOY+z8uzIlHK5tnd/7182FL+jKNWk0oXdkh1Cjq8aOw3540Cn7AfEgi5OWW4
	 0fKzfaKlmJJXAVeFhRARCGbOdld36B7Cn3f3q9GcQzv5yYulp23OTsrY3hZ7c7ywwS88g
	 FNI/PuIl4BAPEgfTne7Pl02eyLRjbPSuvtZ+4/GE3QoEpi2TIaFDI2hn+uJFBrjkCwpPY
	 +DmWK0FifKOq6S6PFoj3NHGLteDGTD9irzPUU5ZpuEoIRp9IKXSIMjWGkYZp6WK0RjGxL
	 u07JEag8oB5g1X22DT+vIcbhqv6bBlM2EXZnOlP4OBLYqvlpvNTL6OLXk8tHisMkGMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468511;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3jq2Z62gtHEtgXMAc3x7RQGWJ7r1tjdQYRw3YuBq5nA=;
	b=iBKvrICJYj5BHG2nhDQwA5j43Jfa+0v+m3hI0C8j3whqOdE3nJEbAdtNhazIp+f4QBDl
	 2CxJ0u9pTLaa6RaeB/xR9YVYqCBIlaRjvXdQ+lveilmO64Hrz/BwW4Qkv0shUwOtT0Gem
	 N/dPypGmXHhQemJ02BYuWl0WqCK5fLN7XmN+PSbxPL4N4bvjSd/4/eaHUKilByaXfjH5y
	 VvoWlH5pOP1cx2Vsqw/tjdyvYbPjs7W55zeL0SCplCgrCEsUzqeknjYe5PwjdpDSznJ3y
	 VwKda07Yjue28ypZRsHQMj7NKh7Q65v/F8LCa3fY9FrjShYZvky7SrvPIT30XlrnQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D0606A327
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 21:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0D0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2da1667b2so2367478137.2
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 13:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468509; x=1796073309;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3jq2Z62gtHEtgXMAc3x7RQGWJ7r1tjdQYRw3YuBq5nA=;
        b=WDl+hdtD+CGI0eFsT6NOOS/oXNvCr/ZAlDQyldbtTtpT+R52mhr1uX7bm2kTdzpnqs
         EWpPB3ycAiNLWpSzN2/8Ab3akTW1qJiHuMBwtXn8G/Pr8SgFEALhaj6qRdCuzZcbWxTH
         P2zxFG272rYj67vCq96MB4Xsi9+TT2dnGZrjopxdoAR4NCCjZW219ocHAbv3cj0rwD1h
         KQyOq4o84ciwttRwjcpciT1Rmofr/oax2ZtlGn4VhdU4ex3ENVg21RHm18J4kCXTTPft
         RaM1AjWqCo/GJXv5FgPLeU7VNBoLPKSZ7mI3AOKGqTa6T5s+el1V81iBQZ31Uwh305dU
         AprA==
X-Forwarded-Encrypted: i=1; AL+hErEfNx0p0wJKJGPjevc67NUvH0hzh/tMzkEfyT4+L04gxV+QAwVcBsB9WPKYVSdYjl4zpqvyW8qb5OgWBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zLQpy3hVHuEYVObdbVjjaUEkVbXqeKC+YZDyKQ+jDT1B0TAwe
	L7GhUPXbASux7VQ+5hWT0h4tWGIqDCJj3TL/zinlbup276wX3/9l2Yq3
X-Gm-Gg: AZFdTZci5dqjcjfr/yvVWi2lof1QqIGOFROpZcSsfxDdgGITQlW2tO4rsyDcouRyvtu
	NobZCu6Ca/h+D5AZ4CzPaYZ4ocuKagPcV9BrWfFA6i/fnsSFkb2XAywE1BBstU2PAmU0MGTjHaY
	9U6USbw3nvsJRqpnQUrj6fXy8yCV7a6CXQDf1AucJETGC3pMdSMNugj9FleHO8accE6v+cJfzJ4
	3V3fk1gatfcj6nHeguEGCXDVJGqNBcXpDnPaJVNk2M07rfziqCO6PIcwZjswh96u3hxPljPfnbC
	gx7jF5k6JwFlESwv3fHR/KfZhQmCtXxqxuM7vkACQ5Y1ylxr+hCPsZthB2tfPM+wy9eyTtXDdmh
	MqQxL+isIl1xL+radkLkl1Fekcm3IwEF90jNfe7jIcUdNYOS6tFmndKbnhEgmxJGu4X7smRiaST
	ru4d5P8UCHyWT1+RKkM7lZaCC3BNY5Q0GgWf4FgEESJoOitu2zI0e3rpU4e3Me1gtRZn0hBtt5Q
	nKjFqqxaLH4RKh1BvyQucGqgqYQkEjPQBwEP3hFrFZcw1FWTF0lqacJrIHaEvESTUlwLX/K1oKf
	0TCmCM70vL+hyR2wwRavJbfGV8M=
X-Received: by 2002:a05:6102:950:b0:7bc:dd88:add with SMTP id ada2fe7eead31-7d7393cefdemr5996420137.14.1795468509248;
        Mon, 23 Nov 2026 13:15:09 -0800 (PST)
Received: from [10.68.32.41] ([5.194.175.168])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e05ac5asm12912635241.9.2026.11.23.13.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 13:15:08 -0800 (PST)
Message-ID: <ad52104c-2d86-474d-9778-070fbbf35e77@linux.com>
Date: Tue, 24 Nov 2026 01:15:06 +0400
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: floppy: buffer_chain_size() misdirected DMA in 2.6.12..5.12 (gone
 since 3d86739c6343)
To: bouldrenough <bouldrenough@gmail.com>, linux-block@vger.kernel.org
References: <CAB0dmhH+Bc=A-3PMneQaEzkMsQxnhjpNYtA+OAaUUwZEcgTxPw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <CAB0dmhH+Bc=A-3PMneQaEzkMsQxnhjpNYtA+OAaUUwZEcgTxPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the report.

On 21/11/2026 07:00, bouldrenough wrote:
> Hello,
> 
> This is a report for the record, not a patch for mainline: the code is
> already gone. It may help anyone still maintaining or using older kernels
> on low-memory machines.
> 
> The bug was found, diagnosed and fixed by Claude, Anthropic's AI model
> (Claude Opus 5.5, in Claude Code), while building a Linux distribution
> for a real 386SX/20 with 16MB of RAM (Linux 3.7.10). I am the owner of
> the machine and am sending this on its behalf; the analysis below is
> Claude's, and I have reviewed it.
> 
> In drivers/block/floppy.c, buffer_chain_size() decides how much of a
> request can be DMAed straight from its pages:
> 
> rq_for_each_segment(bv, current_req, iter) {
> if (page_address(bv.bv_page) + bv.bv_offset != base + size)
> break;
> size += bv.bv_len;
> }
> 
> rq_for_each_segment() is two nested loops (bios, then segments), so the
> break only leaves the inner one. If the next bio's first page happens to
> sit right after the run so far, it is counted as contiguous, and
> make_raw_rw_request() DMAs across the gap. On a write, the floppy gets
> another page's data, silently; on a read, the DMA would land in memory
> outside the request.

I guess what actually happens is a later page gets earlier sectors' data,
and the skipped page is marked complete without ever being filled.

> 
> It only matters where the page cache is below MAX_DMA_ADDRESS, so in
> practice machines with 16MB of RAM or less.

I think this limit applies only to x86, MAX_DMA_ADDRESS is ~0UL on sparc,
powerpc and parisc.

On the 386 it misplaced 4KB
> blocks of dd-to-/dev/fd0 writes about one write in four, and on every
> write under memory pressure. A debug patch logging each write just before
> setup_DMA() showed, for one request:
> 
>   DEC pos450 chain14 segs ac5400+3072 ac2000+4096 ac6000+4096
>   W c12 h1 s1 n14 DIR phys ac5400 -> sectors 456-463 held 464-471
> 
> (all pages still under writeback and at the right page-cache index).
> 
> The same loop is in 2.6.12 (written out as rq_for_each_bio +
> bio_for_each_segment) through 5.12. Commit 3d86739c6343 ("floppy: always
> use the track buffer", 5.13) removed the direct path as a cleanup and
> with it this bug.

I think it's worth to send the patch to 5.10 LTS branch. Are you interested
in preparing it or will let me do it?

I don't think backporting of 3d86739c6343 ("floppy: always use the track
buffer") is a right choice for 5.10. 5.10 doesn't have memcpy_{to,from}_page
and we should take your patch instead:
https://gist.githubusercontent.com/agmorion/bc94c0f989334e28e2f1b03ec97733a3/raw/a48235cf721a2dc50d2f47115eaf78ba9c181252/floppy-buffer-chain-v5.10.patch

If you'll decide to prepare the patch yourself, you will need to update the
comment /* (rq_for_each_segment is two nested loops ...) */ because it fails
checkpatch.pl check and will need to describe the problem in commit message
with explanation why it's better to use your stable-only fix instead of
backporting 3d86739c6343 (missing prerequisites + backport is larger),
use '[PATCH 5.10.y]' prefix for submission and send it to stable@vger.kernel.org

If we will take it to 5.10 there is a high chance such projects as CIP and
OpenELA also will take it. They still support old kernels.

Let me know if you want to prepare the submission yourself.

> 
> The fix for affected versions is to leave both loops:
> 
> - break;
> + goto out;
>  ...
> +out:
>   return size >> 9;
> 
> It was tested on the real 386 with 3.7.10; patches for 2.6.32 to 5.12 and
> the full write-up, with a test method, are at:
> https://gist.github.com/agmorion/bc94c0f989334e28e2f1b03ec97733a3

Thanks,
Denis

