Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EE330644
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438650; cv=pass; b=VmGvx/ity64viEr+mzzHkFCLK5s8hZ2eimpTBEr8Hk7FGHOUsLOMkaUWr0m7hjUmwTPSYd5xdvPFtd6s8ng2nP+1AdtL6TrpLQQelKhBz8TMxWRnZDs5skrTu4THq1NHZRzMPA8hBVvW15kKHuumFuLxJOtvQM9jeQjzCelz9KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438650; c=relaxed/simple;
	bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urusbRKDEYZEC0Q94s4cpISyX9DaHvfyalJ7aT4wshBS5BwDX3y/BJJL3ESkK0RUz/tUAbg1bxh8SiGLy8visWT4l4+ur5FpgKztQlZrFdp3ufZJEoostbPkpRF/V+BYvLQ/oqgIGQAtJGUSGt60bR4a5ldNavB86FymuAuO3bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I5e94ITk; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I5e94ITk"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-41574fa6a87so165680fac.3
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 08:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776438648; cv=none;
        d=google.com; s=arc-20240605;
        b=bpsQ7hK85uHPeTR4cXWNPn1mP5PCYEf2r+luNf3xSifwfP6FhEQP5JtDTlt5ygeKo+
         pukiM/SEDfOfbMJ+/1RuMKv5+b+dpZa0rQPwqPBx8xzo20WyeaeTQKVTmgZajwiMWkCz
         BpGYXRr1YLYCWiwMmeg6OXxroDuL1eZtfQKHjHfkBzrPiHShbHs0RxTm/9JchjWnyP/m
         27leGzG/uFEdSTzhfr1v/VOH6cpq/GCqGzMv/dJeajMNq7AvhZdbqLKkLiBiXMcBiWcw
         cMn0RdqL2nkGxQg/rFhhpU2X81uF/PRDm16ZWKGKtWcoLm9uRZ0cguXTNwiO/9cED1q9
         wPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        fh=GzEzna5RPHTpy1YiSkcgLd5lQGyTFiKrMBuX8fAB9aA=;
        b=PtZzguhdB9CUAJ2ymnwFAHwXOENqtBZw4sW/i3LETZsYWc6D7SpPuEasmhUAYom7H/
         g7yQf9b/zf+ibLM9SsuNMaSXuUvYwzCcffw5+f0W0PRiwynS5ZZ4WQekxUSG1EUvm1Rf
         uUNWSnIKNgohA7ldp90ggNHWXXZdLSS11Ct8im7UUrJI/hJW7A+kOny45zSOxGgSKLbn
         /Jzyo2A/YiUQC4lzC6T9djTiRQdK1X63QNJ2mgm+xHilYQPKhDJJoh8Y4UsvQqOJwu8+
         rTBvQlFWsHUv4TfOgtBrsJYnXPBACdHrK99Ps+2EzY+zi6SSxMWHzlC1lF6PZonUnuYA
         JIiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776438648; x=1777043448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        b=I5e94ITkR+Rsbq/S115qpU2rTYR/eDDXeEmS5iqWvxOgurzgpA+yyiBQCLMkGRgswB
         pTbDLRPJZABeuIzYjUeXlp/3CY03MjF6Xr1qxD3TsqJI+dRwDE53mS/qVGSV9/fAB07r
         Ilq9aXE24kBk7q/iqp6WO0tys59b/4kMXV8b1MNoGVd0mZkoqGMXykJkK3JbK/4BQ2v4
         WXjmidAMNDJQ0s34JYVyR08iKNIQecaoGW+CWmJSLba4dv73wk7GvoZh5T1/zFmxmd/w
         sJpbpjQJwRcRpgSZsJzGCGzsw4iLBB6/ja6ybbuJVOH7UdYQjTQzRITL7sG7DPhN2RHG
         F0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438648; x=1777043448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        b=CZuyCPpwdt1A4PeRk4ucfjlLAVr3RCvptvupkKBVr+3r52yXYfKEqqMoH3MJxQPusS
         a0jPSrOqDTOyeddj8ILWpIs6aXFZPjXBrayJlOMF6gSDPbyCrnRUoK5LbV8wPRXkqKJQ
         tjK9VksnkEkI2biLFpgYxljCpCqMCmfiiLq4FKzMk0yUrgKXtK6JKL7fL0n84lEUVyi1
         +eWur9cJ15pPaOxbtxHiAKmo4sxS1zJLWqZwnhssSji7Wr8Uztc+VXAIY9jTegfT1A5B
         O3RiZA9kuE9wDP+h/RejEL/tuE1Jz7e/fK5IY34/U1rb1sQVqmz0uGpHhhHgOHgMuRe4
         tiPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hf7Jn6U1jsgBlQv6sqrL015PXgk9pZCmW9dN0LkLKudTONHMYxxMyIN9RJQ/IlSeW3mJuCPBSSNiRKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyfw8fajPN9pcb1cNzLxQcKZdW85GDdb9VWg2o8e60pCDIgmX
	7lhDztm74oaN6JixzUqHL8+J3nljr0Zxy83igXaaO4i92EUD0AGyK0rjdCDxRg5a3DMJmuQGfk9
	VvuhlCGexNW2F6Kfx0FXvTgen5AA0O/IuEkGQzIGJYw==
X-Gm-Gg: AeBDieu3aM64gGwnbJdPeorfDUD1EPkARqSv1iybKAGdAlTjWhDQq+fSITaF7xOfzlG
	HTZzT1SbvI9Ig5tO4bb+zmpRm4x9wRi7IoCSTFIXyJ9tuIl7jXE38U/3l7D5m4SWlI8UFYxjvTI
	MttSZlOycomdMt6MhJuTX7kgghytbEf/5AdhVho7gK59oytUVDT3B10zekw0o6ZYxtRoKWGDlfV
	wgUu182OW33b96T8VPSfs7zUgEUxCxfsEeN6/feARarSV0DoA3N4CC1nmwMJQUL3uzS5uJKE7AN
	BPZPtNBz50NV7LUkGNW7r5JguwB8rQ==
X-Received: by 2002:a05:6870:8888:b0:417:a04:483 with SMTP id
 586e51a60fabf-42abf22006cmr1173721fac.1.1776438647695; Fri, 17 Apr 2026
 08:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com> <yq18qams3re.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq18qams3re.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 17 Apr 2026 08:10:35 -0700
X-Gm-Features: AQROBzAgZnPY6pX5OSwcczY9YUvRnJkbRQ4Ptv6iv7u-Y7bsDv654h6ccq-SxOo
Message-ID: <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 8:26=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Caleb!
>
> > The block layer's integrity code currently sets the seed (initial
> > reference tag) in units of 512-byte sectors but increments it in units
> > of integrity intervals
>
> I don't necessarily agree with the premise that the seed needs to be
> expressed in any particular unit. The seed is a start value, nothing
> more.

NVM Command Set specification 1.1 section 5.3.3 requires the reference
tag to increment by 1 per logical block, so that seems to determine
the increment unit:

> If the Reference Tag Check bit of the PRCHK field is set to =E2=80=981=E2=
=80=99 and the namespace is
> formatted for Type 1 or Type 2 protection, then the controller compares t=
he Logical Block
> Reference Tag to the computed reference tag. The computed reference tag d=
epends on
> the Protection Type:
> =E2=96=AA If the namespace is formatted for Type 1 protection, the value =
of the computed
> reference tag for the first logical block of the command is the value con=
tained in
> the Initial Logical Block Reference Tag (ILBRT) or Expected Initial Logic=
al Block
> Reference Tag (EILBRT) field in the command, and the computed reference t=
ag is
> incremented for each subsequent logical block. The controller shall compl=
ete the
> command with a status of Invalid Protection Information if the ILBRT fiel=
d or the
> EILBRT field does not match the value of the least significant bits of th=
e SLBA field
> sized to the number of bits in the Logical Block Reference Tag (refer to =
section
> 5.3.1.4).
> Note: Unlike SCSI Protection Information Type 1 protection which implicit=
ly uses
> the least significant four bytes of the LBA, the controller always uses t=
he ILBRT or
> EILBRT field and requires the host to initialize the ILBRT or EILBRT fiel=
d to the
> least significant bits of the LBA sized to the number of bits in the Logi=
cal Block
> Reference Tag when Type 1 protection is used.
> =E2=96=AA If the namespace is formatted for Type 2 protection, the value =
of the computed
> reference tag for the first logical block of the command is the value con=
tained in
> the Initial Logical Block Reference Tag (ILBRT) or Expected Initial Logic=
al Block
> Reference Tag (EILBRT) field in the command, and the computed reference t=
ag is
> incremented for each subsequent logical block.

The ref tag used for a particular block needs to be consistent. And
since reftag(block N) can be computed as the reftag(M) + N - M if
block N is accessed as part of an I/O that begins at block M, the
function must be of the form reftag(block N) =3D N + c for some constant
c. Thus, the ref tag seed needs to be computed in units of logical
blocks (integrity intervals); no other unit (e.g. 512-byte sectors)
works.
To see the issue with the current approach, consider an example
accessing LBA 1 on a device with a 4 KB block size. If the block is
written as part of a write that begins at LBA 0, its ref tag in the
generated PI will be 1 (sector 0 + 1 integrity interval). If it's
later read by a read starting at LBA 1, its expected ref tag will be 8
(sector 8 + 0 integrity intervals), and the auto-integrity code will
fail the read due to a reftag mismatch. This seems completely
unworkable for a block storage device.

>
> We happen to set it to the block number in the block layer since we need
> to be able to know what to compare against on completion (for Type 1 +
> the restrictive Linux implementation of Type 2). But that does not imply
> that the seed needs to be specified in any particular unit. Submitters
> set the seed to whichever value makes sense to them (i.e. it could be
> the offset within a file as opposed to the eventual LBA on the backend

I agree, the seed doesn't need to match the final LBA, but it does
need to be in *units* of logical blocks, plus some constant offset.

> device). And then that seed is incremented by 1 for each integrity
> interval of data in the PI sent to/received from the device. The
> conversion between the submitter's view of what the first ref tag should
> be (i.e. seed) and what is required by the hardware (for instance lower
> 32 bits of device LBA) is the reason we perform remapping. The seed is
> intentionally different in the submitter's protection envelope compared
> to the device's protection envelope.
>
> Using the block layer block number as seed was just a convenience since
> that provided a predictable value for any I/O that had its PI
> autogenerated. I never intended for the actual LBA to be used as seed
> value on a 4Kn device. Initially we just used 0 as the seed. Leveraging
> the block number just added a bit of additional protection.
>
> I confess I haven't tested 4Kn in a while since things sort of converged
> on 512e. But I used to run nightly tests on a SCSI storage with 4Kn
> blocks just fine.
>
> > This looks to be a longstanding bug affecting block devices that
> > support integrity with block sizes > 512 bytes; I'm surprised it
> > wasn't noticed before.
>
> Are you seeing this with NVMe or SCSI?

With a ublk device. It should affect any block device that supports
integrity and has a logical block size > 512.

Best,
Caleb
