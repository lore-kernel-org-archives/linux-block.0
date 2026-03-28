Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EB30FC23
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705209; cv=pass; b=pISft4kCgYjCrSMY+F0heymbP2QXP8CdAtWaIh07v4V1e/r4Hvie5emp9PhEep+FUKOlQ4dfDHWY+Nx3QlHv+Tbhps27w9QMOmhirpxzwpDWm9l2lh7wrD7vcz5QQaJJo2AHvXV1FNw1y0NLNBJGlrZp4ZyRRYUZ3g44XmasQUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705209; c=relaxed/simple;
	bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jme3eauz3aJ7P7XNSqlXEq/8cAbPtUw8a6j8oikKF4RW1Y1Am66M+zw1cgENxVqKVKWp0Xq55wns+Ijg0dAGy1iZMPj4cAY+UEscY5fiAkbeDBPWL+0QmBsJABkGOdbnah7XdmyNsk/jQMHUouAu9LNURkx6pyrRTvGi4HkebK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDEvyPuV; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDEvyPuV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8296d553142so1507039b3a.3
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 06:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774705207; cv=none;
        d=google.com; s=arc-20240605;
        b=AoS1+0suKczYwTsJSpPhnfnp35PLsLywoW1CVK8Qg4m6Ee5c75NQSUks8y4qVs44LC
         tQ6CSCvm/5+M+HqFoIYktC/isiX+v4WfFL2N3OqHDIBXz/HrIhLlVt7vq09iufqZrU6S
         Wx3c6eSGbOsU6M3o+kbot6J+lGE+O8Of2BgdRSxfVFdNHb+ZQGeSnp+kCmNSpz3IPuDf
         b3aQ0hmUnhadbf7PhPOc6lVH28unQbXlsG+vZehorQezxOG2wLeLecnEHBL6wmVjEQsU
         e/Q6kUvFE6zxQwlP5YKR5nS2UnjIXYUKZYpp9FGozpMtPzxOYlxPh4DHR0p04LrbGgbE
         LHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
        fh=LUg4VYeo4QEpVMep8e9Y2bSfDcN/FOw/da8wJrNsyVk=;
        b=ljOJyrDySOCWc2cxWAadBvSRDsB8qlAiEAkv7LLFSTAGsl+gwKP/K3IpDckJ+3m9PA
         RS78Jy8knTJuTk85xMq7+UECnwaIBItU1h1gO6oxrCnRpsUamDqs8997+vLszkLDhTup
         krihPuSEpyHN1HZueO580tz8Dh3zhOUoBLyRBhWQlCC7V7Q+MtZUAHV1T7EQd0vZbHyI
         70B22sXt5AYWZHAmxhlGB1NfkkuDw+c4e/5sDZgOb1GPH3gHjPYmfoMSAUPmpE2sH+5n
         e5euDFfKhd+r+K3C2CvTNW1JYERZjPtxeEAAHjqD5h/jOMYT/+5/9EyhaCiBsB6cVogA
         YeHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774705207; x=1775310007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
        b=CDEvyPuVDoJAurm6Ipy4sC0g77FY7WX7Hj7Y0GX3ZfTfB0oCEiNy0zPGyhMzkqDs2a
         YJebyPFJkM7dGctnxi8GJnbebKI4KfWZ9yJcGayBTdCyhq0KtiN64xSg5P6ckQhsaEeQ
         HOezVtlhhm0s76fO4C8aOGGWd4kSdN9wVLIioC0a3Jj3in+zrSOea2/MKnvk7ayend4M
         Fdjbykq/PnURVDnMC3nYSk6vwydevXT4bWizpwlqw31jKu9XY4TP9RLlo5312OxYQkgt
         +014sUSospkbg8lpNzwmFML32EFxCNKXMFy3cARWUNqbnqpW0qbMirq5Bddq6bNE7hEi
         RgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774705207; x=1775310007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZtQ2cHIQnNPmhkNNEc2uIDy13fXSNOA9me1ZOCMupg=;
        b=oLNLMqhNUFuoMJUGyGf3aD+yREp1Ap+UBKhLxDCVOB1gymUWyxNaAhKVyyV84Hzly4
         d19yMvCrpVCD00a08XkifV2u1uJgolsA85/OkJ/9Hswlh7S2KIKwC8RPiO7s9+/kR2ua
         wuQnI84g3KYzP4MvjnEEujgDTQbEQ/K2UZ2JuzNMB1FMoECM/dlxNIjcIwQaYCLF6j9a
         6MuTX/N6g1Up3G5OniBsMU8igYs043HRTR4nDmALxeSX7XbKooh0RTMIyAjF0zIwM/og
         zAjFwgDd7PPaM00jY6hgF3ZGsUXjqA7JPf8U9UopwBlB0BYHa4bOBY4Fpjh5RuXkEOON
         Yo0g==
X-Forwarded-Encrypted: i=1; AJvYcCUz6MSvu0Ea1znXyDO5KpvEcqiLvcNnTjpzB7GdTXJ1yoTOyDhn4DAp+rkNdFtKE1VHD3S7uU59T5fr/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJcyBbwerG3er5r/F3AFVkov4I4RH0KcI67lpj/7bIyobqaM7
	DEE2wfMAwKdnuCHM8wlVE723VdN4beEFlsMIvWzHjgjnGdH2xL5eMqrwlDIjcdd6nckQD+9q1MS
	6hvO8o8QK96B2CJxvC5I+MvY9fYFHuEA=
X-Gm-Gg: ATEYQzzukGYjAajJDcBgVgMleqaS232OvjRsDdFaGbWWBx4b1dRnPKEZqW0UsPk7Elt
	pPMjssWduPAtg/sDSTPk25R358buUMRn2rub/EW+pMPGSyZ7X9OwlQtj6dPaOXJCOJ3H9QL0r7s
	ZEER3v9Su019Iktq0FIrn6Csq4vLyQQyAxWbLXagJNiUkfANNwDsC+wjWeWHdKAQgm1fz1+LuW8
	j2x1fA9a/1Z7XId2QOUieJfhWQzM/bjeVbrkULOX5AvH84t9im4W6No1vUimFtKWaS6IEzocKHp
	3aF5VBg=
X-Received: by 2002:a05:6a00:1789:b0:82a:6de8:fa50 with SMTP id
 d2e1a72fcca58-82c95e45d30mr6453604b3a.18.1774705207164; Sat, 28 Mar 2026
 06:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114741.91500-1-pilgrimtao@gmail.com> <91bacd7d-6ec0-4888-be0d-f11a6607f38f@acm.org>
In-Reply-To: <91bacd7d-6ec0-4888-be0d-f11a6607f38f@acm.org>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Sat, 28 Mar 2026 21:39:55 +0800
X-Gm-Features: AQROBzBTENtnZtQhxmzRNb76sGSIhzOCRnc5fvzKUgEMLoc4tyX_zU5SvhHxtug
Message-ID: <CAAWJmAZe+pyfju+37-dfjYUdwRR1ae6Rq8OJjZea76d2CPkEMA@mail.gmail.com>
Subject: Re: [RFC 0/2] block: Introduce a BPF-based I/O scheduler
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:48=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 3/27/26 4:47 AM, Chengkaitao wrote:
> > I have been working on adding a new BPF-based I/O scheduler. It has bot=
h
> > kernel and user-space parts. In kernel space, using per-ctx,
>
> Does "ctx" perhaps refer to struct blk_mq_hw_ctx? If so, please use the
> abbreviation "hctx" to prevent confusion with struct blk_mq_ctx (block
> layer software queue).

Here, ctx refers to struct blk_mq_ctx. The intent is: when no eBPF
policy is attached, the new I/O scheduler behaves like the none
scheduler; when an eBPF policy is attached, the blk_mq_ctx queues
maintained by the new I/O scheduler serve as backup and fallback
for the eBPF program.

> For what type of block devices is this new type of I/O scheduler
> intended? This new type of I/O scheduler is not appropriate for hard
> disks. To schedule I/O effectively for harddisks, an I/O scheduler must
> be aware of all pending I/O requests. This is why the mq-deadline I/O
> scheduler maintains a single list of requests across all hardware
> queues.

This new I/O scheduler targets mechanical hard disks. The scheduler
can be aware of all pending I/O requests, and users can maintain a
single list of requests in an eBPF program.

> Additionally, this new I/O scheduler is not appropriate for the fastest
> block devices. For very fast block devices, any I/O scheduler incurs a
> measurable overhead.

For the fastest block devices, avoiding extra scheduling policy is
often the best policy. In some customized workloads, however, extra
policy may be needed, for example priority scheduling, cgroup-aware
differentiation, or fine-grained metrics. Those scenarios have not
been validated with real demos yet, but the approach seems viable.

> > I implemented
> > a simple elevator that exposes a set of BPF hooks. The goal is to move =
the
> > policy side of I/O scheduling out of the kernel and into user space,
>
> What does "into user space" mean in this context? As you know BPF code
> runs in kernel context.

Sorry, my wording was inaccurate. It would be more appropriate to
phrase it as "into user-defined BPF programs".

--=20
Yours,
Chengkaitao
