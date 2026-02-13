Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AC5CDF1
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992037; cv=pass; b=XQijP23eoUUSwMOMIP7/d13TYP6uaDJx/3jVY4+dmJcG6rDCWLmXkhRGf2vngbW/5rA+F5KW90F+rTaUpDYoRWnxLPcDjlq52dAKLsfI/LqcTgGhu7HHWo7N/vNAWDZzOL0F/31wFEaklKZ6QyK1DQDLZFskY0RycwGu1fspoh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992037; c=relaxed/simple;
	bh=c//n5IhGxoVarfdC2xFaKdhT38pvZG/r3KF2IYj+MGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxhNPWQDwqs/1cMEnXZjqYAZnvoIQVUoIm4KOQ/rXrpW4joDEoE/d7zxDlVLH6MsGeONqEM6KP3/xmUQZeEH8yQQa6/wQQ4/qNyJVMZUatICRuKwt9cWGMST54Tj4fZYj1LuDVcxORDAlS2626Ev2YY4yyivStqAvk6w0weygkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HE3rcDOT; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HE3rcDOT"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3870c7479c6so6450411fa.3
        for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 06:13:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770992033; cv=none;
        d=google.com; s=arc-20240605;
        b=j1BL8/wkoSmZWFT42Q66/6Sj8GYEkK3VCCBwrVDE53IthMdMxfjgTvEgdp3iIuK1lA
         GI6S+NQsVDb7MZae1L2LXHiNpb43I2cVe2h9982pt3sVB8SEXpvGmjkKjrYL0TVW65VU
         W4QctYMXLY18SQ+Rxm9KUkA096LqDaQH4EHsd3ccWmWcy1acLwEYN6hVsPZjLwewbcap
         p93LzzLaCqDM8f4kB5GCczDKmLQDr5dQ23Wx+yrXx1fV52o+d6nQkx0P47hzijbbXCX+
         UZhVtMswh3Qj1VVz52W7XadSaOHEo9WSDmTzN9Mlz2Rr8twyReDnDYfvi12Mr1oaYseu
         WKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c//n5IhGxoVarfdC2xFaKdhT38pvZG/r3KF2IYj+MGU=;
        fh=cgQXfBeDhu8bfOXGm+gsx/4iK64fVEs6ozmSlkJ5g0E=;
        b=UCZF0FE8PUTVlT1o8OobHrI7bXxXAct+YvmG+LqrS7a1cF9riyTRQvMqgjIfUHDUxi
         oS5x5xnX/mk5gPmas84Bu88aO+555zZ+iE9kYs72Lh0WFa3Ggu8szQXxsACnNgD39osa
         Z4jH1Gsi8FylKnje1XRDMwsub8Ril3OFx0BSs0/yuVQ7BD84eFEDKefZmN6ZIiyzrcTP
         01i/Zr1rF9QvyA4MMPOP7tMAsqj12pmsP14ryE9NheRd021s05VmyrRo8pHHrDJNeT3n
         9d5pUm3UsroJnS+gvC1htcLTcBL2EEHonxKn09hogXLXU+FivF70dlYhYi60Ik1cdmZV
         uv0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770992033; x=1771596833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c//n5IhGxoVarfdC2xFaKdhT38pvZG/r3KF2IYj+MGU=;
        b=HE3rcDOTxaEW/qQiU1LK0Pob8FC+Rn9TYgwaetNCWWDBSt1sU4+XAJ7K4oHa8FuiBQ
         bThntaNlHQfpHQfLRAqJPiD+m0iy0XO0Evm4GruxFVbeZe0BXP/btXenGJkvZ+bhP+V/
         JfpQD4NvrBD8/U2d27bMj2KtCy8VSnG9E+k9qVsbzWTC1iQyGBuDFZF9nOdU83OE44TA
         sw/gYYnjBB1wJegHrKSLrp5uuipp9PWKE8WzZamPyyO8XPL3V+toWTof20zQiWoL+1KH
         XhtMzMKaSo8cE5dor0YG8RC5HWhxFZ0VcnA27rUC+eoHzZb3ZBjcsDCbeMVAnjQePSPs
         zfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770992033; x=1771596833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c//n5IhGxoVarfdC2xFaKdhT38pvZG/r3KF2IYj+MGU=;
        b=C8/wgom1VAkUzCRFY/HblKSc0O3K0aVAtzQwZ4Q1NnUjRsHDbbWHaupaPxvTX7OG+1
         8hVd/BkidUSw9O1c/5Ou8ATX4g0yOv8BHTUfFzMwDqYQVgJ5b3Dv49UNSFBlAA5kVKuZ
         yotunL/NVkM078nuMBEOXd1q5A7jSRYfthmmjqehqS4rTP9BszcObb9XcyqD2gKN7IdU
         FqIILkjV9AxJPsU6TyLPTgzzaNj6cZOSsiLsyTAnqQKyYpaUmeEM7ME3C815ZcHW1ZqU
         7IgdPZQDXWkP8cJtNajTcnpo3MVokfclMujkfrRAz6BK0vphJzXygPFQp+ZchYiSw3mB
         xb0g==
X-Forwarded-Encrypted: i=1; AJvYcCXFNsXkrL8fof+ASY6tuVgbYhQv/Oo7krNPbfC6bak1ZX7ZjQjMBgYGnN/B4LLIjgKPz7tSWoAR+hUVxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RtLkakobpjxmMQB0lP5nMcvL6P2BYSljxr0ZP28gh8i6FD0Q
	Ygm68oez9fB8vgpx0gUqzV+1H3V2XLAKhch5R12sYhJPcHfZ+UM0Q/+2M9WM3cUo8hYR9kSUAvD
	T+m2691+6se16lNTSODw5vVxbS3IMiWY+KrcPwodadQ==
X-Gm-Gg: AZuq6aIUkfP2/BepB7pHhPVCmcM071FkLMNzI9UCjGRJ4V/xjAM8bKUKErbRyfguUqI
	WRY2R1ZCHmwsFMoKy0ndNEdBLbUSG4N1n84iIyafNHoSoLEpFSfvhclrr4ByOPrJrCc0PDAvOR1
	WfHie5YJ2jUiM9RJGt7ZqbTVqAk4FH5g/A+mlmaFegOijDsdWPWIkZ3Y36Whi7H2NBuYePCxa4f
	iutlc/wpfscd6hkG2doM1SA3lzsdRrBOxqUshiegwtAHDfXhAPdjn2a4ucg2h9cq9gPf2g/XrjX
	64xyShgoNURNsmqI8UXQjvKaZw03tAb50Ctv+ADJVcnEOBKbCOsxBcscumdPYBs1I3bLuMbhXyx
	xrls=
X-Received: by 2002:a05:651c:144c:b0:387:d66:2531 with SMTP id
 38308e7fff4ca-3881056806amr6232581fa.23.1770992033487; Fri, 13 Feb 2026
 06:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <0ea1530f-31d0-43b6-b35b-1286fc58fd19@acm.org> <CAJpMwygcLdvWNSwj0uy=FBwZyu+DhQSPCvc=CJfiLRvmbfwsKw@mail.gmail.com>
 <CAJpMwyhe-UmSkv2vzFPS-o5JRRz==kw-nNbY8RiyQKQykpumrg@mail.gmail.com> <07f7ee7b-06fc-4fb7-a826-d465562ced24@acm.org>
In-Reply-To: <07f7ee7b-06fc-4fb7-a826-d465562ced24@acm.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 13 Feb 2026 15:13:42 +0100
X-Gm-Features: AZwV_QiwbCeURu_T6GjdMWfbmZlwy546X7dLY_bt7A0hWkBoVe6auFnn5sui1gc
Message-ID: <CAJpMwyitnaUGSragWh2y4NkMqiXPEoa2RQpaFzmGFEsn03xTFg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Bart Van Assche <bvanassche@acm.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 7:31=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 2/10/26 5:06 AM, Haris Iqbal wrote:
> > We did some quick runs to get the sync time and performance numbers
> > during syncing.
>
> Hi Haris,
>
> Thanks for having shared this data. Instead of performance numbers I'd
> like to see more information about the implemented algorithm.
>
> The description at the start of this e-mail thread says "The proposed
> solution tracks dirty IOs through a dirty map". How does the dirty map
> work? Is there a single bit in that map that tracks whether any of N
> logical blocks has been modified? If so, is the worst case behavior that
> logical blocks 0, N, 2*N, ... are modified and no other logical blocks
> are modified? Does this mean that the worst case behavior involves
> resynchronizing N*M logical blocks if only M logical blocks have been
> modified?

Hi Bart,

Currently, a single byte tracks a single chunk. In that byte, a bit
tracks whether that chunk is dirty or not. We use one more bit as a
flag for a special case during disk replacement.
The disk "replace" feature in BRMR, allows the user to replace the
backend disk for an active RMR pool. In order to "replace" a backend
disk, that entire disk is marked as dirty. This information then needs
to be communicated to other storage nodes so that map redundancy is
maintained. In case of a "replace" happening on an isolated storage
node, this communication will be delayed. We use a bit from the dirty
map to track that such an information (certain or all chunks have been
marked dirty) needs to be communicated to other storage nodes when
communication is restored.

We also want to eliminate this feature bit usage as it significantly
increases the size of the bitmap. This would mean that only a bit
would be used to track a chunk.
As the project is still in development, we plan to assess this in the futur=
e.

>
> Thanks,
>
> Bart.
