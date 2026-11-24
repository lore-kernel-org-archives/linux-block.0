Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548938;
	b=Mre+gsHoUnqO8H5WkIjdK6/hk6k5HNRhfJtAr+MdO07tOyQ9Jt973b6iXeKASnG8zjtY
	 aejr/ybpCrMkt4dsDrIkg1CssgkoSMpCO5lbo1nJA7TApnheryTCvRJ6ZkWfePxcD2Zc0
	 U/CP5n5ioNWMJFhAhuzOf2jOFojF0xysmFHZ2Mx3EwHPTXaOg1shYZU8acmOmHA4OXRa5
	 oPUxQSsNMqPkXYuEJQQj2Rd7qIV9lNXW02nh3cCcpGTe+457pWw0TNCFcXgFi4DmZ/NCi
	 VWIB184d5mLkq4U5QmU9GfwKjNe7VsTCCc0iBktkUoVf+ovUbLytkMkR50MmCRPIKIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ycrwoSNgURzDQDgDGIomqBVTbbUJB3maFJYq7eW8Sos=;
	b=vXliytTwBuuTCzmt0TjdRwHeVVoVzISm/dgTyNp1nKf5b1jBama2xN+hy5AojykXRVB/
	 PavJiEhsKqHindCCjITKzm95j3WE5njbYN0ctif344V3SLVJGzwlqLfuNsbvU4aaK+byp
	 R1//CkhmAWIucv9JyCfqXJtgfTOtzc9eAZ45oTdGbzJxbPXJEBD73c9MhPYsPxvp0lfAb
	 Y/0qaS2Hf7eXfWTmTz/d1mdTtQPc1o93xwKoGPV8anbR9MFZrZbMMEVK4xeXI2uz/KSlT
	 rWmqaWd09YCEPRhMV7UarEazZvb2SkcJ5bnN/IA6tP6bzCJuREYsZdeyZB+W9vRMDZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vW4vHd8G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EA606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 19:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vW4vHd8G
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38699cf08dfso5530967eec.1
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 11:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795548937; cv=none;
        d=google.com; s=arc-20260327;
        b=aM18kpZU9Dsme+VJU4j0cnV6FO8w4rAf2tfF3RMkRZIbSadXnVYOdigq1tRmFsL8va
         2cFgpJ5JQN0hQGSX7JV5KnnhNsOJL7cPbA7y3h0sMrkIpIiGbhn9jAysWLBmTw1EkF68
         r4ZOdqQuwM2k8TxWLbhMIazKQ2HmWWhwAR81oz1aL46qaKK4+FX7EfiXTSSIYkKY4sek
         4D1TmxWEy7Jyy/UhpaCUgCCmki+gm9YL883bblRPjKrO7ROVpq/H6zvr+Q0HULiIfgiW
         gOghuvIODAKVTQV2Q1OItUvchA6tUTfTpYvmK1rLVztfSrXBIDT4H/QAwPwrCPEOrx3Z
         oG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ycrwoSNgURzDQDgDGIomqBVTbbUJB3maFJYq7eW8Sos=;
        fh=kCgpOhPt8FhEx8EL89IYXut9xN1CrkhxAN1qR6kVciU=;
        b=rEHfzM3orr+/0XE7oDguwMCbQP6/b0PkDqsN2TgvZiYm2k2kkDpA/+/cEOtODexUeL
         Bw74GcXhcVBcoTT3DbxgW6p/SIMi6CGX6VjeoX5SLc5WpuXZMr8plhyDi/ZLM0GLNJiJ
         guVsV+YxNHmj1tu6pbLQhk7sYZeEYTJLBNhU/Fyg5F476v0ORD4b0uCaHDSGz0Om3Nuu
         WYyM7ctbsR/uotQ9oKPePfeLYeZbrTd9YwbcauvLw6Qg4GCXtKJz92m/mWH+TdSA1/w9
         CUC2+nGGJ7dMi1sJBB42lvMaaQ1WxmNwW7KbI+k19Es4dqdn38ffZO3HadPppefsaqO/
         4WQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795548937; x=1796153737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ycrwoSNgURzDQDgDGIomqBVTbbUJB3maFJYq7eW8Sos=;
        b=vW4vHd8GmKzRqxi+VLYqPhvBzFW4jlKYA38dJkRXIp1GGVIcHruifqmvrNnL6KURXq
         zmv7m9Doa/53IYJt7L+LbQt55qwrQ7YAoQwrz+Ga0WBMX5WvSLw4pTlWJyGqEJRRDaAp
         my54YC5sWACPp8j6wTO2fWJr2lPAwnIjzcRKTsfbvYSCVuWgPZTz0IxnRAGFq4CF3BHS
         Q9/dM2zIRXpNK3bWr1boZW9C2vH44jMHdf9k7CBb5Lapd4empa7pE8ysGs4zzyoVd4DL
         /oi9oNRLUNmTyOMj9FuRvfaXGaMZJpDHUTvehq30NX4t55fX5jZ/b7hx2NPXyCVZoVC5
         +MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795548937; x=1796153737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycrwoSNgURzDQDgDGIomqBVTbbUJB3maFJYq7eW8Sos=;
        b=iXF6dOjjQiQsdXVg946LDFP6ukvQrrD9AzQJwaDT0Is+bPaDSWiu9b4RT51HLqodc2
         tL99lH2N+wic44uK2kwv8SN0gGmRN9E4K0/itE19m6znPv6krv4xr/RwRPPC0kn8/Rhw
         LH1+B2piV+AUp2mrKG2MnEMaUFtrlTZoSbXL3HTPbaoRbUCEzrnEmmz7EyIWsu5JWHSd
         5v7ZgTqokriY87MHf/u2bIyNuqnkAcgxIPnIoVnRz+bLVVsHoFxcKW3PrC3NEiT3mEqI
         rXRjEquhuHq00cQNBDcfM+miPwIsc8jGrmIqHKXUX1nBu46ngTd2AYzHcmXE8J7kZsUL
         qHnw==
X-Gm-Message-State: APuU4Z9oSFGX7xdb8osu3NYucRvaE9U3xFbcVLVUxB5OjknP29zJuWXK
	LYzuY8/UmtqT811k2TBATCoxx2mFnIv9vS9QpbwuNMWtw2GrVRGeYUldjaoISORq7va0sRMYAIc
	4XiGR1In1uhA2bc77APb9BBpUem47XG7KQA==
X-Gm-Gg: AZFdTZeipoTjS+mqvubC88mFiLyzOy8XUWZBdfb82KmUbf/lqyt7f7jUwc3iRhQ8/iQ
	CGAllFIUbCG/r89yamDgtlyNeLj6Y2me4fg+L3N0A+tCKRNUosMVYj5HJQGHXC1uShg/4DZw55/
	TX1XjofmXKsUjQL7edV35L3StyTZPc8ur5+0jvSqxwY6JEUVxqKth3VKtsiSD6D6TH76uzw7rDV
	knSSe5qjxjf9omovzJC7c/mXkhAVwmO5A5VkjfkeWRBKHV3HsZh1wP5oZBpXXDil5SebxmGDJ+l
	cnKG+GStEqcsX2ctfQug05HV/yuMYBXvtSEvy+ghuqBcJML+ZHq1S6a3Ln0hx4ZKDmnrhquSw8R
	BhU4pRqhvrA807+pOVdEiE54BeI+2/wVYN7+tbw9fjkvA3DTfU7e3pgtQAI0ccWrka+1SKks/bq
	io2v+RK/35jKYrCo0=
X-Received: by 2002:a05:7301:d81b:b0:386:3e56:d039 with SMTP id
 5a478bee46e88-386b844ed9fmr4944314eec.9.1795548937158; Tue, 24 Nov 2026
 11:35:37 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAB0dmhH+Bc=A-3PMneQaEzkMsQxnhjpNYtA+OAaUUwZEcgTxPw@mail.gmail.com>
 <ad52104c-2d86-474d-9778-070fbbf35e77@linux.com>
In-Reply-To: <ad52104c-2d86-474d-9778-070fbbf35e77@linux.com>
From: bouldrenough <bouldrenough@gmail.com>
Date: Tue, 24 Nov 2026 14:35:28 -0500
X-Gm-Features: Aa3M54pUfCA0jomd7zgNA0U5mENTm8TNp0RmDVWuG8KN8o0p7uxpKo2mQw5CmFs
Message-ID: <CAB0dmhHRFbc22A-D1KtM-ct4MLHQd-azKFtxyH-G3NU7h0-nzQ@mail.gmail.com>
Subject: Re: floppy: buffer_chain_size() misdirected DMA in 2.6.12..5.12 (gone
 since 3d86739c6343)
To: efremov@linux.com
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm happy to let you do it.  I really don't know my way around the
Linux kernel world.  I could let Claude do it, as it found the problem
in the first place, but that wouldn't be me doing it anyway.

If you'd rather I let the AI write it, I'll make it happen and get it
back to you.

Regards,
Jesse Beach

On Mon, Nov 23, 2026 at 4:15=E2=80=AFPM Denis Efremov (Oracle)
<efremov@linux.com> wrote:
>
> Hello,
>
> Thank you for the report.
>
> On 21/11/2026 07:00, bouldrenough wrote:
> > Hello,
> >
> > This is a report for the record, not a patch for mainline: the code is
> > already gone. It may help anyone still maintaining or using older kerne=
ls
> > on low-memory machines.
> >
> > The bug was found, diagnosed and fixed by Claude, Anthropic's AI model
> > (Claude Opus 5.5, in Claude Code), while building a Linux distribution
> > for a real 386SX/20 with 16MB of RAM (Linux 3.7.10). I am the owner of
> > the machine and am sending this on its behalf; the analysis below is
> > Claude's, and I have reviewed it.
> >
> > In drivers/block/floppy.c, buffer_chain_size() decides how much of a
> > request can be DMAed straight from its pages:
> >
> > rq_for_each_segment(bv, current_req, iter) {
> > if (page_address(bv.bv_page) + bv.bv_offset !=3D base + size)
> > break;
> > size +=3D bv.bv_len;
> > }
> >
> > rq_for_each_segment() is two nested loops (bios, then segments), so the
> > break only leaves the inner one. If the next bio's first page happens t=
o
> > sit right after the run so far, it is counted as contiguous, and
> > make_raw_rw_request() DMAs across the gap. On a write, the floppy gets
> > another page's data, silently; on a read, the DMA would land in memory
> > outside the request.
>
> I guess what actually happens is a later page gets earlier sectors' data,
> and the skipped page is marked complete without ever being filled.
>
> >
> > It only matters where the page cache is below MAX_DMA_ADDRESS, so in
> > practice machines with 16MB of RAM or less.
>
> I think this limit applies only to x86, MAX_DMA_ADDRESS is ~0UL on sparc,
> powerpc and parisc.
>
> On the 386 it misplaced 4KB
> > blocks of dd-to-/dev/fd0 writes about one write in four, and on every
> > write under memory pressure. A debug patch logging each write just befo=
re
> > setup_DMA() showed, for one request:
> >
> >   DEC pos450 chain14 segs ac5400+3072 ac2000+4096 ac6000+4096
> >   W c12 h1 s1 n14 DIR phys ac5400 -> sectors 456-463 held 464-471
> >
> > (all pages still under writeback and at the right page-cache index).
> >
> > The same loop is in 2.6.12 (written out as rq_for_each_bio +
> > bio_for_each_segment) through 5.12. Commit 3d86739c6343 ("floppy: alway=
s
> > use the track buffer", 5.13) removed the direct path as a cleanup and
> > with it this bug.
>
> I think it's worth to send the patch to 5.10 LTS branch. Are you interest=
ed
> in preparing it or will let me do it?
>
> I don't think backporting of 3d86739c6343 ("floppy: always use the track
> buffer") is a right choice for 5.10. 5.10 doesn't have memcpy_{to,from}_p=
age
> and we should take your patch instead:
> https://gist.githubusercontent.com/agmorion/bc94c0f989334e28e2f1b03ec9773=
3a3/raw/a48235cf721a2dc50d2f47115eaf78ba9c181252/floppy-buffer-chain-v5.10.=
patch
>
> If you'll decide to prepare the patch yourself, you will need to update t=
he
> comment /* (rq_for_each_segment is two nested loops ...) */ because it fa=
ils
> checkpatch.pl check and will need to describe the problem in commit messa=
ge
> with explanation why it's better to use your stable-only fix instead of
> backporting 3d86739c6343 (missing prerequisites + backport is larger),
> use '[PATCH 5.10.y]' prefix for submission and send it to stable@vger.ker=
nel.org
>
> If we will take it to 5.10 there is a high chance such projects as CIP an=
d
> OpenELA also will take it. They still support old kernels.
>
> Let me know if you want to prepare the submission yourself.
>
> >
> > The fix for affected versions is to leave both loops:
> >
> > - break;
> > + goto out;
> >  ...
> > +out:
> >   return size >> 9;
> >
> > It was tested on the real 386 with 3.7.10; patches for 2.6.32 to 5.12 a=
nd
> > the full write-up, with a test method, are at:
> > https://gist.github.com/agmorion/bc94c0f989334e28e2f1b03ec97733a3
>
> Thanks,
> Denis
>
