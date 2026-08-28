Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386C37E5D0
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935338; cv=none; b=ZUrmWZFnTcezh3w/1AbCbLO1SIC/Ga8eEdIgYC2Qz6kNjgoodAhRQamuWPYu2hKLWLhA1TTdTykGcgHWIZqgG/Y3aP1cofRkk2GrgveyOodbTAmWLw/IuFsHwQNhKtq+hdFTuf9h1X3G21Z7Xenqq89oh03D6j/zIdKyNkBfcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935338; c=relaxed/simple;
	bh=iWJRGJo8GOhSzF7hKjM4hSEZnaMvnsnJxm8SvJPRXuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQZDHRn7heLY+fcJYcb4wzIIrJcdVMzVjNYVcWb8NuwrhxvF403bj1UJsLekOFaxU99FSXCpZT9hvheYfhMsxPajHpch5NaSUCcFkEsYzsXXienvAKz38MBEGwoQ5an62VbSX11cKfMVV+gX3KYl9Q8XoiEKFcDMvR9A60imsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PihfvZO9; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PihfvZO9"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb787dec99so990515a34.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787935335; x=1788540135; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qltHbqH6zAk9rxLPd6W/XN3mLDgy50kN6vVpjpgbgd0=;
        b=PihfvZO9ZaJ5nvVrvqlF6DSFY2QuWc76EKVWxusYSPPGBvmUNWDB7wRk8Wx43G7rnZ
         hUdhH70NGhzzut2arpYwa1Nk67asR9yC2f2ivTow62WhyRVLc5EfkI5PqrtDo2lIMrgD
         m7yHJAtMYiIeKPRIr5Xnf1EhVYODO/ArRmBkRiHX6Pv2FhFrfWPoKDsjCZR918ahPEnS
         736o3pPtOj3jbwTG4+IskKG7FLHuSYLDArfUAgT5NUA+UBhSEVA5Tvz7ZJaKY5FfJENK
         WO64LAX/TenFuq2G+cQoTT0LRQKa9IawYCj/HkZA3ps+k58Z43NaQPsxtcRzhAJUk8xs
         sRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787935335; x=1788540135;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qltHbqH6zAk9rxLPd6W/XN3mLDgy50kN6vVpjpgbgd0=;
        b=V69JZTz1ZlBH6FB0u4CjNsCvtfQxcKYgc0lj5dQ4pMzkMmbN8TnbsZgrxIiLtMbu7j
         IaYgt1uoj28tyJEcYkKwwKcc06Cb64CnUYG9p0XkWq2qRVUxH9RdEsa7zndBrHcR35Mi
         NCvzs8jfaKuTcqa8PdvoCteW//lia7vcFJwu7+ZfQyN7D1oNQ9iLcfX7D7xGlPNMkf5H
         0ZMzTRdT5YXhXR8dnE7uT8AyjGXh59gqKXbcPRtx2o9lHjUYIkykgSTnxdB9WVcBMHow
         pHb2X0psislFGUaT+fq7gCVogBXMRhbGBsmTrZ6KafzkRnK5JKPyidWknTv8mVk7+16O
         GEGw==
X-Forwarded-Encrypted: i=1; AHgh+RrrZJ4C+xTToCS4jFs0mZaXyNSyu5Wkw5HHzwkp5k+DWlhhJmRlw2ahenkgZLt1Z0HmlTxdzLktUn/qHA==@vger.kernel.org
X-Gm-Message-State: AFuF++lBHeir5wEOlSIwpgHVxmcZKs12kwTGTqG5I2AEVeQObr0WleHL
	PEfOrM2s8oT6MhTHnGIpZfO7ECH8tEMU+36ebFfM/1ooT0YRtYB/G+IK
X-Gm-Gg: AR+sD104C5ko5e9SG/6fazIYnfkSdrk5L4dNZM9kwWnzQiengQWPog3SjJ6qXDj5nJG
	fMbMMmQpd8TE5nE4d5tr9MWoTZkWohcpVG/o6PBdepD+cqHK9DvRlDyJFBWqwCJm5KarpFBiFVi
	FajHK793ZlODwJ7+6EUCc5BY2Ind1LQbzcY6Tr3nm0HvZwZFgpurZmj5J//txDIVN+2PTgVlk10
	n//lAENfgAFu4wSGuzKdP+0iWZ3pDnkYxY7Cjsa0lnDze/z6lVtQVetI7jnYomzu+APOTpQ0KbX
	2jKtt5Ispr6OAvAIp3Z875/9+VUJFh08G7pfLUXPFAmNsaY4OM8H3SmjcUzqFSMP3qTxQ9svo+r
	OQSQ4++SBO3ESJElI70SJC4RShChy5h8J0EnHx7ZV7375rMMdz8po8E9HEn9JZGNFe1WjdwSxP7
	+0r3VWyNYv1RJfVPFaVb5/ylb4q/ap1nhQjGeKhRiSYgbuf9YfPIoHnDn3wSln4ajKow1pv5Cfj
	T84rYSneEwWIWpBHvNtz2Jl6++Ho/Ier26g7vYTZH8XPISxxK8bUx8YNo7F5V+rLJMk
X-Received: by 2002:a05:6830:4491:b0:7f4:eb7e:c8f7 with SMTP id 46e09a7af769-7f4f2365bb9mr8713253a34.5.1787935335216;
        Fri, 28 Aug 2026 09:42:15 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-113-94.revip2.asianet.co.th. [124.121.113.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa99d87fsm1567760a34.20.2026.08.28.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:42:14 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To: Mario.Limonciello@amd.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc:
 regressions@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Date: Fri, 28 Aug 2026 23:42:09 +0700
Message-ID: <178793532947.1861819.4688629821762072134@gmail.com>
In-Reply-To: <d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com>
References:
 <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
 <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
 <178793069172.1699234.13635367891277204598@gmail.com>
 <d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 8/28/26 10:37, Limonciello, Mario wrote:
> By chance did this issue coincide with you switching from something
> different to the Ryzen 7 8700G?  For example switching from Raphael or
> Granite Ridge parts to that Phoenix part.

No -- same CPU throughout, no hardware change at all.

My persistent journal goes back to 2026-02-27 and every boot in it reports the
same part:

  smpboot: CPU0: AMD Ryzen 7 8700G w/ Radeon 780M Graphics
  family 25, model 117, stepping 2

That covers 2026-03-17, 03-27, 05-04, 06-03, 08-23 and today. Same board, same
CPU, same SATA controller. The 8 TB drive that first showed the problem has been
in the machine since 2026-03-11, on the same port, and it absorbed two full
multi-TB backup reads on 2026-04-01 and 2026-05-01 with zero storage errors
under 6.18.16 / 6.19.x.

So on this machine the only thing that changed between "three months clean" and
"corruption" is the kernel: 6.19.14 until 2026-05-10, then 7.0.4. First
corruption 2026-06-02.

I realise that sits awkwardly next to your internal issue not following a kernel
version. Two readings I can think of, without picking one:

  - the hardware/firmware behaviour is constant, and something in 7.0 changed
    how quickly or how often the 32-bit IOVA space gets exhausted here, so the
    latent problem simply became reachable; or
  - they are genuinely two different problems that happen to share a
    workaround.

I have no way to tell those apart from here, and I am not going to guess.

> We do have a reproducer in our lab environment that will rapidly
> allocate and trip this issue which is how we could analyze it and root
> cause it.

Good -- then I will not spend the evening trying to build a fast one, and I will
drop the bisection idea unless you tell me it would still add something. If at
some point you want my slow reproducer run against a specific kernel or debug
patch, I am happy to do that; it is only my time that is expensive, not the
machine's.

> I don't yet have any confirmation we can patch this at runtime.  If I do
> come up with a way to do that which works will let you know.

Thank you, that is appreciated. For reference, iommu=pt has been completely
clean here: 40 consecutive 256 GiB verification passes, 10 TiB re-read over 17 h,
btrfs corruption counters at zero. I am running with it permanently for now and I
am not in any hurry.

If it helps your case, I am happy to be a data point on the SATA/AHCI side of
this, since the ASM1166 report and mine are both ASMedia silicon advertising
CAP.S64A.

Thanks,
Mikael Etienne
