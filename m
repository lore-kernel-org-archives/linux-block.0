Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44311340DB1
	for <linux-block@vger.kernel.org>; Mon,  5 Jan 2026 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641361; cv=none; b=P2I45HiTgyFEP22sDzMJ6rdFEt+FyBWLORg/PQln/n8y0hBDNl44agqYFk3SASm38FLwvQTRn5ougrnRWib7t7BU5gX20EgjdTu2tQg7SSSfxp36D3jVXe26D2NaPDgtJBbf335AEa4DSDBNa8ijAgtnVwbZgEgZS6d/CsJH+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641361; c=relaxed/simple;
	bh=4q7zjiMztx4TqbiphqF7KyHD7GkrdILcLu6qGCKShJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+H08KVa8jZc7+evr94QdfA5vCcGD85JCiKTaSWYSpScvPol8hYaezzUecbUZwI6sDua7xb14A1NDNSghStPftrEs30B0uxHk2UrVrODcAJegTkpTFwe0sz75UqO3/edQaRFrn/k4ucVpqnQw2GQfSHjI6BrNzvcbKaa4bi7bNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRVXTl//; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRVXTl//"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so100944137.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641359; x=1768246159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q7zjiMztx4TqbiphqF7KyHD7GkrdILcLu6qGCKShJE=;
        b=dRVXTl//brTP3Rjv9baowmv9nDvghrUtjmtp2/jNJa4sFBzL0UaB9OvuWfIeVKbhjh
         /mWBD+NS/escAIEHmU78jNJz3tgwpF4vff4yK04ojdEwayp0xrDh/jYI0Oid9YP13e6U
         4rHp9uTSTvS7cP3gDj3G7VbvhIBOSczuQUU8D6Sbu/dfaHFCcgC7bJdCiH36sBk60A2n
         XNn/XUYQY9XcVfu8Q9deo0gVXMtIj+OUpNRdZZwVWLGr4xGoIdTVXkVKDyUcRksntvgM
         k6yQfO4IgorSbaSvk82TF+EkxwcJlz5stHrhXEcD4qpWXneKFCHnHbXLNkW7opk08F9C
         /lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641359; x=1768246159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4q7zjiMztx4TqbiphqF7KyHD7GkrdILcLu6qGCKShJE=;
        b=i6gonrkHMqhb9CCkKMRxDSsLE96JoHUbPXc4t1qXXJM7Z/fbOMd2C2+AJXEIANp3Hh
         2zbuStBjTvOcPt4k9w57H8x3DJGGN/Y/W+eAy3FOOBXLhFSZgtvgKzFXursY/xpdNXci
         8E9mq7ohkPqQ1R6CwrfLIGuXbISSrDsQjmFKDlkzDE1lhDhcE7WEWmjLmG0qJxnCbfPo
         CvQ45vejfnFC9eH3az+HccU/ZhU1cVecPOMJg2fTmwbMoJ6vfnZS3HOANXoOXSfN4qfU
         Tb2mp/ZQFUiDAALu69O3h9aGKVXSm7i7gIvRlbox/5KSLlkKLp6BrxSHJjPqPtVcpd26
         0wFg==
X-Gm-Message-State: AOJu0YxaSOki5Ck6+opXwr3SPEIwhEipOiyzLC5MkOm1iVy/mPaqm0XE
	H/8BUIRtpf1nNhNP/nYt9LFIu0sTeEmk++uVLKdj2zyIbs/HSohn9aWqcm6tM4n6CUX4Dl48+j+
	OfG69lqEMrRM1eD66lKH5HIIjqqi36ZtKJDqrHOw=
X-Gm-Gg: AY/fxX4DhA5MraoQGhmG5sKaitqdF1cUM4i+u0woII/1yP+gYxOaBdBRZFlryLESegW
	6mj73V9dSCjP/qSGnnBZ0kgbZvG0fPP9Qic9HmOQmCZXQYxNC4L1ASuc3uA5GkVhmQtyKBTxHb9
	b5tBoBLy0YOFx4DxA6hFC/pdPHPVWpOteCYvkskVIll6zMHibKtBv26GruWLXhMLmXUviEhK+EC
	+s+PaUsSOiGCMSwt4XADEAKarQ1Wemk/6C7pvT6gItnoOlwVsGo+W9kb7TtA6icpV5vvT+c+y23
	FgMHHoQxhSaersP9ELYGK+jLHBzX
X-Google-Smtp-Source: AGHT+IEe8UKkk2h7BpzVcEwHWC/sWqwc2MZY4Kvn4Z+IHlV1a0a+CwpvSiV8XUjBASIJ7qPF9b/FYFNA6BO9PO85Rmk=
X-Received: by 2002:a05:6102:3f55:b0:522:86ea:42c with SMTP id
 ada2fe7eead31-5ec74330421mr177233137.11.1767641359029; Mon, 05 Jan 2026
 11:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 22:29:07 +0300
X-Gm-Features: AQt7F2pMgKTlnuto4S9HkLyjodLaVsqWExGHp9yO0nB4jzx8fHD3I6QJ8e7Kamk
Message-ID: <CAPqjcqrqQ7PjPywFgdA-2eXf5LRAP2fAqcFGknnDYrMyqw3W8A@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>As I said before, just don't use RWF_ATOMIC if you don't want to deal with=
 these restrictions.

But how to get the torn write protection then? What if the kernel
decides to fragment my 'once atomic' write?

I'll add some details:

The real NVMe disks with atomic write support which I know are:
1) Micron 7450 / 7500 and probably later
2) Kioxia CD6-R / CD7-R / CD8-R and similar

Both use AWUPF=3D256 KB and NABO=3D0. That means any write up to 256 KB
size is atomic regardless of the offset.

Actually it results in atomic_write_max_bytes being 128 KB when IOMMU
is turned on because max_hw_sectors_kb becomes 128 KB because it's
limited by iommu_dma_opt_mapping_size() and it's hard-coded to return
128 KB =3D PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1) =3D 4096 << 5. But
that's not the main point.

My use case is: I use raw NVMe devices in my project and I want to use
atomic writes to avoid journaling. But for me it means that I want to
do atomic writes at arbitrary 4 KB aligned offsets. And I want to use
atomic writes **safely**. That's why I want to use RWF_ATOMIC - it
allows the kernel to guarantee that it doesn't fragment the write.

With the current restrictions, as a user, I can't do that - I get
EINVAL for some of my writes when I enable RWF_ATOMIC. So I'm asking:
what's the reason behind these restrictions? Could they be removed?

On Fri, Jan 2, 2026 at 8:41=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 30/12/2025 09:01, Vitaliy Filippov wrote:
> > I think that even with the 2^N requirement the user still has to look
> > for boundaries.
> > 1) NVMe disks may have NABO !=3D 0 (atomic boundary offset). In this
> > case 2^N aligned writes won't work at all.
>
> We don't support NABO !=3D 0
>
> > 2) NABSPF is expressed in blocks in the NVMe spec and it's not
> > restricted to 2^N, it can be for example 3 (3*4096 =3D 12 KB). The spec
> > allows it. 2^N breaks this case too.
>
> We could support NABSPF which is not a power-of-2, but we don't today.
>
> If you can find some real HW which has NABSPF which is not a power-of-2,
> then it can be considered.
>
> > And the user also has to look for the maximum atomic write size
> > anyway, he can't just assume all writes are atomic out of the box,
> > regardless of the 2^N requirement.
> > So my idea is that the kernel's task is just to guarantee correctness
> > of atomic writes. It anyway can't provide the user with atomic writes
> > in all cases.
>
> What good is that to a user?
>
> Consider the user wants to atomic write a range of a file which is
> backed by disk blocks which straddle a boundary - in this case, the
> write would fail. What is the user supposed to do then? That API could
> have arbitrary failures, which effectively makes it a useless API.
>
> As I said before, just don't use RWF_ATOMIC if you don't want to deal
> with these restrictions.
