Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C023C8A1
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842630; cv=none; b=pn3SW+usOjcg6btYDT3Sil8/VvE4BcaxQWwm4MVgXgduOLOB61YUt7nMDptdrwFSsaJzhvs7C1s5nEXrylnbf0dfn62QjZMLG2EU9hGxR+v+QEMhBJBMqIHWQ3t/X3FH7nBs9aKW2GTGfSTqZ3gO3B5aoL6v+FaNfU9sJJ6YCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842630; c=relaxed/simple;
	bh=MPVCVS5EIDloMkwegAhAEvIZ3bIKWpMIJfYkR8t3UUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrDbgLe7wUbW0BlPOSdVD2scVIQeZXh8tzw0VOpj69vinVzFkuK0TAcE9iQJ1ncDJFiF38A0qZYkRU10ujPpKXupmiRqOc9lId32sU6/8YK4C5G/cBt0rIrqemBCFIvArBelH1WALGDDwGzpGd4uso4CkkmECj/Lif+fcHCufRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gvvA14F0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gvvA14F0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240d930f13so263685ad.3
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744842627; x=1745447427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfRJOJ9CRsHZJefMhleN5QEhzGV0ETX7MtMvPUoW28c=;
        b=gvvA14F0Kau2L3+XYbsglsV11/yJ+ywMP2CsH03c9VrBBP6PByLxZS/EY+4xGE9rrq
         STRLX2XLF6exnc8Bl/Q2aDkt1Z+aZLbxojyVlCgBy5oUnvWDUFNuwecluXuxSfq64jmQ
         hls9xXdG4Hkbz1CgLVYyZk9hoUaRiFEoPrTONIOJnTOpIvrYADMsZpnDklypkyuRhPbA
         hMhYFUnQhK7dikvgpPDDjP+8PN+9k400wZh80EIcT4Jx+OxJWfkYOOMy00PJTH5hSQis
         AOipkYDyrjOwY49YxW9QMQa9h6GhrFmWdSXrLJJzTv7nlPlJt87u79WIRLaDRIZvEbSB
         2+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744842627; x=1745447427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfRJOJ9CRsHZJefMhleN5QEhzGV0ETX7MtMvPUoW28c=;
        b=BZokhfymtq8t/y3QjBgj1Uyw3TasyitRp+9W+tGTdXUoXq3a20LwHherPUCtkc4ecX
         vC2FK5HKg9d+1U4IOaJAQJY8T9m2QFbNY8rbNuGbmsd74K72hg+fvf1KoSpRqhu9GrTq
         fkDQV2IRZ6GGrb1FGvUr57pqZb8BqBOxQxUKdMhS4S2ScWG++cHdITJJ8ajRdOn9/5ta
         hm6j/otNI2/siQtZ42vPhIL3RvjdPpzwC1L2phBvM1sxosagDJntsLJt7TmZZr/hy7rB
         ZAkqtdIxZbXXedcepgFCIxBAuTJ1O9TOio/HVvWWRINdjHdGJv0SahrQHnKaEeLgs72v
         zupA==
X-Forwarded-Encrypted: i=1; AJvYcCUTupRMXuPAWHmoNsQTiHsfDXOI85U/grT5QvmxISQpfMKL4TQ3EvtJX5YNoqW8j8sJOoEaF2DcHOKKWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM77CdOpTQK5ViIhUEQ1APpo2Aa8NTHttQ+1T285iH0bD+iGuL
	fb/F9JaAzWoCuF9Q0XsVF0Uv/OccOjZd8wfSZIWZKOz9evLlABmQqL6cFBasg7Sn+R2aPl7YT+q
	kE66mD1wSN1/+2MLe1sCbKY5GaQSyI57lp3zxCg==
X-Gm-Gg: ASbGncvVeuY3eSxFJMlvXf9/SEKS2jcsWcMkUKBGd8k38czBgUraI4olbQpAgYQe2x8
	8uv4J9KngQqiQENuYntp43zb9DAVx6XCJVA3ZkBblpCX0dEe/H3ag/eyA0fY4QHl5E9A7xeE+mV
	Iuacl6NpRReFoJ76RQiV473G9N
X-Google-Smtp-Source: AGHT+IFPCjiCP4UFzZ0MkuOGd+hSWcQBivXnxmbuOQEvtCyO5XP28tMDmUgVwNQMpakN6HjgMHswlg1t+ZtZyAQy8wk=
X-Received: by 2002:a17:90b:3ece:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-3086d477001mr818376a91.8.1744842626698; Wed, 16 Apr 2025
 15:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416160615.3571958-1-csander@purestorage.com> <20250416150529.1e24677e3798cd783f4adb8f@linux-foundation.org>
In-Reply-To: <20250416150529.1e24677e3798cd783f4adb8f@linux-foundation.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 15:30:15 -0700
X-Gm-Features: ATxdqUFBl5hBWIF_oWQiK-ZiCgPwok2zNFOKH2CPgKufEkvUGI0fDCz9XU9nTSs
Message-ID: <CADUfDZpH5v8jxphVRGvD5o-jLXiDbTw0SsAxzTSCLGyua9erjQ@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: inline sg_next()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:05=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 16 Apr 2025 10:06:13 -0600 Caleb Sander Mateos <csander@purestora=
ge.com> wrote:
>
> > sg_next() is a short function called frequently in I/O paths. Define it
> > in the header file so it can be inlined into its callers.
>
> Does this actually make anything faster?
>
> net/ceph/messenger_v2.c has four calls to sg_next().  x86_64 defconfig:

Hmm, I count 7 calls in the source code. And that excludes possible
functions defined in included header files that also call sg_next().
And the functions which call sg_next() could themselves be inlined,
resulting in even more calls. The object file looks to have 7 calls to
sg_next():
$ readelf -r net/ceph/messenger_v2.o | grep -c sg_next
7

>
> x1:/usr/src/25> size net/ceph/messenger_v2.o
>    text    data     bss     dec     hex filename
>   31486    2212       0   33698    83a2 net/ceph/messenger_v2.o
>
> after:
>
>   31742    2212       0   33954    84a2 net/ceph/messenger_v2.o
>
> More text means more cache misses.  Possibly the patch slows things down?=
?

Yes, it's true that inlining doesn't necessarily improve performance.
For reference, the workload I am looking at is issuing 32 KB NVMe
reads, which results in calling sg_next() from nvme_pci_setup_prps().
About 0.5% of the CPU time is spent in sg_next() itself (not counting
the cost of calling into it).
Inlining the function could help save the cost of the call + return,
as well as improve branch prediction rates for the if (sg_is_last(sg))
check by creating a separate copy of the branch in each caller.
My guess is that most workloads (like mine) don't call sg_next() from
all that many places. So even though inlining would duplicate the code
into all callers, not all the callers are hot. The number of locations
actually loaded into the instruction cache are likely to be relatively
few, so the increase in cached instructions wouldn't be as steep as
the text size suggests.
That's all to say: the costs and benefits are workload-dependent. And
in all likelihood, they will be pretty small either way.

Best,
Caleb
