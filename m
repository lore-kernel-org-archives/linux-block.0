Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570F3E5EC0
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938028; cv=pass; b=j63ZX724T9xheClzH8/UPdtz51G/nNTC5rN0P1nyjtsRAIJ1LY9duX5eChqYKbyjuSeubZNA1e7NfPVGAIk4xlQgWhahs04P+vgxkwhIQzaePqmdRugcWokTvXNteM6fKlNPmB39kmun6a15VlliGKOueJ/EM3t7PZATk0QO6qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938028; c=relaxed/simple;
	bh=bbsSLoZoKXKVFf90pkeqMTOgNUERfyvfvzBCM7moNTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVxgMFgwIndZGgr2XbihB++otm/hp9DabDxTVmx8gM5dErhsdZFxadbu+/e/sdrGSHeu4kri0fR0ml8gLnJHvTbwSquvSLMnS2OSApMoqzVqNnIzcS1OnwlVSThIkriC78RFWkk7dxiuKOWlHwoJAp71SNxPsymhmYoR++pxSLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjvuf5Kc; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjvuf5Kc"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-902f92b8504so21281986d6.2
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 03:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783938024; cv=none;
        d=google.com; s=arc-20260327;
        b=FHAQGFjKo+oZp2JEJtgDjqADTodBjPnrNMlIYTj/rFXLb/BUYTOHg2sGxgnr+DHp8O
         vDp+vQprTn6xcII9c5oIwenGi+COn1K8vdvPw6xocdRydxZGukKukBRiaBk3qzZfDk0I
         joZHkDqgQ6jnmKdIEEsBXN/k36XcdXlDLVDt2/Z8JtAfSzjXEVfYq7iJcDshiUFDzVaq
         owZwwNSC4FeYAk/XcEFLxUVYgPsxCzRAyC0LmfLJ7gWBjRxcCfALZNTadJziVXf2llI5
         +F3uqtZnv8QJJ8YBmAazFnvqyzLL+Kq7XNjZJPRUUj8Kz+zQAaHTCEju3XZclHITmOeu
         0lsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bbsSLoZoKXKVFf90pkeqMTOgNUERfyvfvzBCM7moNTc=;
        fh=0AuP8ln+goCiUsOnNQ2wr9kLYsX2EPcb8H2KqNsWxwA=;
        b=pBxPfeMjWX6wfGSmkC/9n+Le9MyUFWuekwrTV4cs+VCld/XzHPqYwlh8s3IArwET22
         EoqH4jdQBVsn7uHRiV1zbu2qY8CMTCiAORXbgFuxM3yk8tyGq6S5vFEDK59a38WVz5Hg
         mP2MeJUclmveartKscz6zLi6ruAwgr8H3UlqU8ccoyFp8VSDMk3ywA/ln/hNojCj0VO5
         goJ2RFnNENaXsMciI2nNxPBhBLw4DpvGIiTMclZJzio8/mle5TRHOHL1jUhd/moJkbai
         3DcOFRdNQK5Gvqi0bK1fJ3aI9NTIvP7N5OeFwaX+FYiYm2oKeAF2esrfpl961HeqewE0
         VoaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783938024; x=1784542824; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbsSLoZoKXKVFf90pkeqMTOgNUERfyvfvzBCM7moNTc=;
        b=Qjvuf5KctNJi9fv9rzz/QvraggLXC5fqKuFHJ6LNBaPw83X4tz3f61vBj5QJiFmSwh
         4i95tA2ZnYYs9JisNfWqdJgiMOizfR27ud8M2NkPqu6gzEair9ScuunNfNtrLHyJXdlM
         SbIbGT8zwke5PPvCFxsZ1aB9v6fEUXn5gSYDy/d8vJkuXwZ71kzI/CSoprzCUHqb03MZ
         LUsazuFxrwsk4NV6CUM/jhBBd3gGYh6R1hF/vtcNK6VMfBzHb87QDnGF0VpHWVNLKHvl
         gANFIgyaTM5QEuV+d+oiQRtlnCshtMVxMS/LHavrNv53nleoFSClky5hlvexAcAbXjQX
         aE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938024; x=1784542824;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bbsSLoZoKXKVFf90pkeqMTOgNUERfyvfvzBCM7moNTc=;
        b=oq+qoEIR6wjYPtbjCQwu76E70FdifU/rIuJW36rL+OGtrxeXV+rY6/o/JhXSJ/KnTW
         d64CfACVclDZrHw+Q+nZMrXGhmO8+HpUi37aRXnbDVdrvfvgujyMcFbeBNIsyWEXXjsR
         K8RwHbiACpNZFg7d8LwNOkPsbxf6tn5iS9xT6KEj7HPc27JnPvk59PkA08WbgieATAa7
         FA6pANmT0O5EKdja6y1V/4VKH38F7zu219q4Ao0oEAOKFYYhxcEM70qPiegZu2jEYx9G
         WPl+KarO/TMdh+2oV/lqw8NzxrlhFDOU5522XWiyiddbPFjWBsU7xNiEFKnmqPJAUc/n
         J9tA==
X-Forwarded-Encrypted: i=1; AHgh+RowfYmUJ2/Z6RzqnaykdPEiLlffGZ5oATkIloogrOHA3yEMuSWeckhFCVUDnQJlBlX4PtNKL081+2ftwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywDp9q8GFfjQq1DcHy1FjPuv1L+TbuXgS+ZSEmg38Nq9wqTF/e
	Bgf83sOnAy0xUK01crT30/CtB0rzEeWzjGkeFaiseaXkDIE64Mqk5SPTSFIsXgwJGFSDtje5roo
	nESpjt0MbqY3VpGSxINUaxGSiZv1KBr0=
X-Gm-Gg: AfdE7ck/DLgHFYUw769DwF06UGhlo41buM8rifjE+ys7WBwwhpb70J8dIisRqBuTvW1
	g1oAhkusfs3mcv89OoWQ4N3c3xg0uv8vK46ADTaIwKAgoN7HZD5LSwHsO6Y9s+AcapydxDLR1tW
	5Zkhq+ZzNKrww2BelEIRqEjPwJ88W1/kP4nhQiciNLHH/VtsUE3TZecf50rCm3kHDqPNcpIJhW1
	N0VmSBn2yhFP1siOHnCAULoNTijY74rcsHHf1eEagKAH1RTlWLbj5W4uRdSI4GB7ehgpQE=
X-Received: by 2002:a05:6214:226b:b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-90403a62281mr96428866d6.31.1783938023906; Mon, 13 Jul 2026
 03:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKTh279tH68oS4gTQd9DFqNuegvAhwZ8ck2uViR+cbeJDW9jDA@mail.gmail.com>
 <20260713092945.GA8612@lst.de>
In-Reply-To: <20260713092945.GA8612@lst.de>
From: Neptune <z1281552865@gmail.com>
Date: Mon, 13 Jul 2026 18:20:13 +0800
X-Gm-Features: AUfX_my4xSlI2HtdKrIKgSv4SpolOe6XPGEOUdWrP6Zn1UxhWj0eKWlOe4CLXDE
Message-ID: <CAKTh279snB+AfprcUxVazx8v6WBo99AXzEGoeYOYqLfPuhyZhA@mail.gmail.com>
Subject: Re: [RESEND][SECURITY] block: double unpin in bounced direct reads
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

On Mon, Jul 13, 2026 at 11:29 AM Christoph Hellwig <hch@lst.de> wrote:
> Does fix the issue for you?

Yes, it fixes the reported double-unpin in my original reproducer. I
applied the patch to the vulnerable parent, built an x86-64 KASAN
kernel, and reran the test with the same QEMU NVMe PI namespace and
XFS setup. The exploit now reports a stale page miss and the process
remains uid 1000.

I did find a boundary bug in the rewritten alignment loop. If the bio
contains a single one-byte bvec and nbytes is also one, the first
iteration consumes that bvec, decrements bi_vcnt to zero, and moves bv
before the vector array. The next while condition then dereferences
the invalid bv before the later bi_vcnt check can run.

I reproduced this on the patched kernel with a 512-byte O_DIRECT pread
from a raw virtio block device. The destination starts at the last
byte of a mapped 4 KiB page and the following page is PROT_NONE,
leaving one bvec with bv_len=1 and bv_offset=4095. Immediately before
the loop, GEF showed bi_vcnt=1, nbytes=1, and bv_len=1. After that
bvec was consumed, GEF caught another call to unpin_user_page() with
page=0x100020000, bi_vcnt=0, and nbytes=0; KASAN then reported a
general protection fault from unpin_user_page() through
bio_iov_iter_get_pages().

This boundary test requires permission to open the raw block device.
It is a correctness regression in the proposed loop and is separate
from the original unprivileged XFS entry point.

Keeping the loop driven by nbytes, with the old partial-bvec check
inside it, should avoid evaluating bv after the last vector has been
consumed. The callers can still pass an explicit starting bvec, but
the loop needs to stop as soon as nbytes reaches zero.

I also noticed two read-bounce cleanup details while reviewing the
error paths. If alignment removes every user bvec,
bio_iov_iter_bounce_read() returns the error without dropping the
allocated bounce folio. If alignment succeeds after trimming bytes,
bi_io_vec[0].bv_len retains the pre-trim length even though
bio_iov_iter_unbounce_read() later uses it as the copy length. The
error path appears to need a folio_put(), and the successful path
needs to synchronize vector zero's length with bio->bi_iter.bi_size.

AI assistance disclosure: I used OpenAI Codex to help inspect the
patch and organize the test results. I independently applied and built
the patch, ran the tests, and verified the KASAN and GEF results
described above.

Regards,

0wnerD1ed
l7z@0b1t.tech
