Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34F2874E6
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782360463; cv=pass; b=D/HOf+OwPn7qO/aO4MoWh0XCf0mcPe2nMvnskEID0KFFvmWDS4aYei64bZU4bquEAK/zAJHUFaRQseagl2OoStauVnjWjv8oWj2HEMEn+8SV9kGxmIXnWw4IKJlHbzW5qucxU2i31P8tRAR9L7WwEIIzwR4UrGL6/xgal+0YlQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782360463; c=relaxed/simple;
	bh=fMLKIPDN5CObDO1vnnbscHoDeOfOEpuRvS+WxcxpCJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryb39Tj05ftxzFMdT3j2rVKVP7tBegUe1+UbSvyqPysA3XXzthtE2oYiRIdtqUh39fM0uUi1wU2l+9je3FTNjtxfZfQtPIh8FlODIVQRQgH0YXnxTDd7Sg1bY4SphTzlVA/x4vPeCOmduhcfF/N9W7Sqqy2qg2P/Q0HDimVkk5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cU0giwHe; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cU0giwHe"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-441500cd401so192523fac.0
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 21:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782360460; cv=none;
        d=google.com; s=arc-20260327;
        b=KoHSiRuPwK8Gizpsp/8uUahFKVRRUtjhaL1B/Iw9y96e53H7BqpHM0LCjcLcrb5eTp
         48psmVJvxucfzmKwIDWzF/EOesZRYtERqFZ7x8LOM82GwYE5rX0ufhYB+x46CVo+D3/W
         NBoERfP45iIvydX4yC7M7mqb2ku8lXdiZpe/YY7AtpCfa+MZBqYbpBHFoNkJ5sYycX5R
         xHFmc/Aoa5aRqcTLcxbURbGz5uQAP7Z33gDzlIGCY2BIITYr4ytVkPgo/G9ZrvfCV4Qo
         CTk33C6sgdAR0fM/TVdVyX7bd0F9N1wnHbZTwjS8QLu5a/fIP886pvDLUs3d0v8wH+kb
         m6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fMLKIPDN5CObDO1vnnbscHoDeOfOEpuRvS+WxcxpCJE=;
        fh=RbYPdAutttR2jRNeCXxUlyI79zevo0w+jG+WYy+hWBY=;
        b=sUsML02fuw/G0dja2jQg1dttH73AKn9akT+u4v7ElqHo1qrjNAK7+6usRy42FAD+m2
         vKq8w9dB/zntjyD7/XxIuulqwn2Krt6yZHSp5m1TlPWKwr7iyX8bYWV4BjnG04Lf+8AU
         bpDsRAT3lCgZcZI7uKU9KYMRCW/6JRANg+1wZZFjlBLWsgCBOflAmzPVQ5iFD+uht9yi
         C9jn+HKmVCNPrj+BQQ+gPBINpHAxFe+b02sYY2NhhDTSiTOH7zCR5oFM7sm5TOKXzRm2
         X7IoFfSJd8th3fWVDlAcSiSQ59UGB/Aw9jeGeWSzJ7njMvkfFFIBScvAeUvIh+igMLIp
         qM/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782360460; x=1782965260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fMLKIPDN5CObDO1vnnbscHoDeOfOEpuRvS+WxcxpCJE=;
        b=cU0giwHe8ZL9quG2nkDwaCWNGYPVk9+uxU6jcbw3krETF4hth+jZL0DYTX8F11f8OS
         8aginTTK3b1udcNUrTHpMfdXft46LwyTQG30L1fzDjstRR3m2R3dCnIMZcKDkq5XVtdA
         +aGhegq91efPUIcj/3kM2Y52eiDGGhuIzwisgADfCsK+lAr9Zuv8s+iKtUIgE/MH5Wb/
         nPc/lBN689Afbeaa+UceinoZWuel9SXAUHSZPnIRNVX4EV1yk0j7DiT6wfTEK1V8Vm6W
         WVxjzBXOtCCrcoDS7am8g6fw7ZZyyJXMvpKtrD5AYMTmUrRRD2l67nMsjBSWWyLqUbAj
         q7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782360460; x=1782965260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fMLKIPDN5CObDO1vnnbscHoDeOfOEpuRvS+WxcxpCJE=;
        b=m5ShetdkfFMEU7fcaif2Z83dH9LAK55wuoL184ebRQF2cMdUSAMpKmxvz9+6nM+nGC
         wG8OH71QLMhlt1W28JaGRpJ8pgetfCxYiGRMb0R1TyxxHHS01D9HLY4ehP39pQXxU5r3
         uyqMT+3G4JyqpQYcCmKYSpA31HfG5xzecPVAzo6J7INXJt4/K3pO1nkwVNy1IDccGh72
         e6fMiIzbMN5oUsgJ+xA44AT7Lrt33yAnCu7cf0EMgBN+jUE1RxHv0BqQlV8bPiEE/Buf
         2TC1kHtJY86733lgW2iV5H6hAUnT6wjrgTxJlcFRsHsAYYV3L8eDgvbTTuVFFMgRo6f/
         N4sQ==
X-Forwarded-Encrypted: i=1; AFNElJ82wQVg5byuq0JCv4D7Wewa0IIX4tnT9uqflaHMQrCWrf0yelEAKa0uUNIGxbR9mprqnNt1D+Dnbe9r/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjzLI0HLif3qE/FsPrhmQd+4VpofTAov62HEuybObyeDEyEAA
	jcZtm5EQHzjleSlG0knHbJuxsUdKhuvnguxu0T7rMNqWVavZN7gjdoZqsqJPNu/S2SrMuVT3vwp
	OiacAA41iP94BWdwynpdRxfvPlplgDuv4KOZHigUZIg==
X-Gm-Gg: AfdE7cllF8zFTAR6oefwZlw5Gkgeu7j2KqCm854cv7FG5Nbl56Xc9ztEGTVvzcCAlFl
	uOFi8xFPy00djbT7p7cH8aEnrlQYlQUbtdEcKWM0hY4N8tT8cawtuH2+WW9f924zW6FD/jvwJ8f
	glsirE9Rf/2yY5ZVby23kYPgCwnmDpXCUtqD6boaC608rB4SFqRmPol9/1ExAG6WKtBKrk2AZj+
	V3rutfFZA4ESEw0LBlGzGFjDWUh/rqT8Oa02KDS23ItLFm3ialnjRDriobBdWwv9UfN3zt9zg==
X-Received: by 2002:a05:6830:82a6:b0:7db:c389:6495 with SMTP id
 46e09a7af769-7e99c0541f3mr680099a34.2.1782360459453; Wed, 24 Jun 2026
 21:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624080014.1998650-1-hch@lst.de> <20260624080014.1998650-3-hch@lst.de>
 <CADUfDZo4hysS6qj=Z=dEzVk=DQe6D7-zTFODLk8RGTJ13RY5uQ@mail.gmail.com>
 <20260624153856.GA13186@lst.de> <CADUfDZrDNT5rVXE_zSn9-MT1YwZvN2ynCSy_zY4xt-jx_SyuTw@mail.gmail.com>
 <yq1cxxfpfiw.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1cxxfpfiw.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 24 Jun 2026 21:07:28 -0700
X-Gm-Features: AVVi8CdJ6oMXrrOvWB4jJ-minEmCB3D-KTsSrka60wPM7f3zeL1YZG7jE4bD15w
Message-ID: <CADUfDZo=E+ZHNJEQbgakUhxjnAVnh7UHZbjeDKO3YXN69Qo9Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 7:29=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Caleb,
>
> > Right, I don't mean partitions of zoned devices, but block devices in
> > general. I was just trying to understand why the remapping
> > infrastructure exists in the first place. Seems like we can't remove
> > it entirely, but we can at least ensure the ref tag seeds are correct
> > if it's skipped for a non-partitioned device.
>
> The entity attaching the PI to the I/O decides what the seed value
> should be.
>
> If you are an application preparing PI, you don't know which LBA a write
> is eventually going to end up at. You just know you are writing block 10
> inside your file. So you generate PI starting with a reference tag value
> of 10 because that is what makes sense to you. And thus you set the seed
> to 10 to tell the remapping code which initial reference tag value to
> expect in the prepared PI buffer.

Except currently the ref tag seed is set to sector 80 rather than block 10 =
:)

>
> Once the write hits the bottom of the stack, we know which initial
> reference tag the hardware expects. So we remap the reference tags in
> the PI buffer from whatever made sense to the application to whatever
> the hardware requires. I.e. an initial value of the lower 32 bits of the
> LBA for T10 PI Type 1, incremented by 1 for each subsequent protection
> interval.

Right, I understand this now. But as Christoph points out,
blk_integrity_prepare() is only called for REQ_OP_WRITE, not
REQ_OP_ZONE_APPEND. I don't think remapping is even possible for zone
appends, as the final LBA isn't known until the device completes the
operation. So I think we need to initialize the ref tag seed in units
of integrity intervals rather than sectors to ensure reading back the
data at an offset uses a ref tag for each block consistent with that
used in the zone append.

>
> For reads, it's the same thing. The application wants to read starting
> at block offset 10 inside the file so it sets the seed value to 10. At
> the bottom of the stack we know how to interpret the PI returned by the
> hardware. So we validate that the reference tags received from the
> controller match the lower 32 bits of the LBA or whatever the correct PI
> format is. And then we remap the reference tags in the received PI
> buffer, setting the reference tag to the requested value of 10 for the
> first block, and then incrementing by 1 for each subsequent protection
> interval.
>
> This allows the application to validate the received reference tags
> without ever knowing anything about which start LBA the I/O happened to
> come from.
>
> Both DIX and NVMe also allow the hardware to perform the remapping so
> the software remapping step can be skipped altogether. Christoph and I
> briefly talked about that last week. We currently don't take advantage
> of that capability in the NVMe driver.

As far as I'm aware, the SCSI driver doesn't use the ref tag seed
either. I see calls to t10_pi_ref_tag() and scsi_prot_ref_tag(), but
bip_get_seed() is only called inside the remapping code. Would indeed
be nice to take advantage of the hardware's ability to accept a ref
tag seed and skip the software remapping. It seems like initializing
the ref tag seed in units of integrity intervals rather than sectors
would be a pre-requisite to that, though. Let me know if I'm
misunderstanding something.

Best,
Caleb
