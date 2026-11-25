Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595374;
	b=soLrRRcP6om7TpOt9g1X0/f8zYc7FDFcMq9ljAp7p6HdzraK22eShucgNuDvhm3fl8Bv
	 UASc+Y2J+2n4xHYhr83tuzjaG5SSwRGFVTH3hexqZW1GbLZdkEb03iYD9ZIMvzBiMYk0O
	 IYQj2hxba5YfzHSG0EkUSci+4A9u2NAURQwswDEGdSfPqln3f33JRG9pC/XeaxNqxNx75
	 tq2AITBZA28SpGJt/Z6akwUIPLITyot7zB/zNjFB/TDjR4yl8yr920pZBeuyJYjl9MOco
	 2AYKh2GWWcDTNs/p/hx04AJsIOi/nYwpUyrZd0J2To8NPSiCFhj/nt909grfSISRxDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type;
	bh=S6ViIbz72DmFlSP9JPwMgRiVlDXqmWEKuOKUgxyI9tw=;
	b=UqBafIKF6u4pA1kv93p3St2RCpWxQewuAfSLVIdvQH9iwn3KxKoBnwpmVpmSk0M8FK+E
	 aeijKbVrD5Mpo359wcr5XkWgNcwA38yluY3EJzuhH3/0BFy6FN4Dy2MnUuZg4WIdd328o
	 zwB+JPEDUA3I6oIIH04Zic6F1Z15beto+j1G0vXNW5wamqKBoT6uPjFk225htTMxXGv+U
	 +pZsdP+0438vw1ZCrC++1wDieLM6cCa1h4tOrI2gHqCUGLOW3xWmB0gpWu/QpHmumdWFd
	 IT/SKcp/sEjrhf+M/bdCbr+sIoRay0PBYCHoBaUwANXzcaX5scqY0ghgugkBAhrMRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=VeflcpUy;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E606A321
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 08:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6814E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=VeflcpUy
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0E955240101
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 09:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1795595366;
	bh=S6ViIbz72DmFlSP9JPwMgRiVlDXqmWEKuOKUgxyI9tw=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 From;
	b=VeflcpUyzPhCpjRA+hwGIABsDeXvnG4eFvJ3bXzmjs+kXSDXKtBiCc6WMRVbn1hmP
	 EYePBgScZo2+dseEopZpPF+EWpUS4RooTMZMMIVpZ+Q6EHlmw+fwZFN04gzOhfoKz/
	 U8fbKgAp/ZY1Nj6q0zYDV/drokdlPQ/f5102bqwh7TyWKGr0ziFb251T+bWtz+LjMO
	 NVW9h4G0TcrahhwlOl6XFiXIxIctFN630WDA3YBPDzEKpk9NHI8L83S7FRxugT/Cak
	 IaeK1pWvppakwIpacEBcHyqyetG6IQwgw6MzQltY8GqP05tVf6mrghnQ7H1iy2wjMh
	 Th2Q0NZYiUp0A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jZCX35YyNz9rxD;
	Wed, 25 Nov 2026 09:29:23 +0100 (CET)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 08:29:25 +0000
From: Tobias Laas <tobias.laas@posteo.de>
To: Laurence Oberman <loberman@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, regressions@lists.linux.dev,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase =?UTF-8?Q?BLK=5FDEF=5FMAX=5FSECTORS=5FCAP=22=20=28=36=2E?=
 =?UTF-8?Q?=31=37-rc=31=29?=
In-Reply-To: <7eb28c6334a655eb5bfbf3035cf1f1ff1041bb3e.camel@redhat.com>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen>
 <7eb28c6334a655eb5bfbf3035cf1f1ff1041bb3e.camel@redhat.com>
Message-ID: <ea064dc05dbf146814f1495adad4d39e@posteo.de>
Content-Type: multipart/mixed;
 boundary="=_a0bc4d5717c364c5892ec2d35f20af0c"

--=_a0bc4d5717c364c5892ec2d35f20af0c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Am 23.11.2026 22:49 schrieb Laurence Oberman:
> Hi Niklas, Tobias,

Hi Torsten, hi Laurence,

I am responding to both of your emails in this email, because you both=20
suggested to check out intel_iommu=3Don,sp_off.

>=20
> I tried to help here but (full transparency) I had some LLM help for
> further ideas after I coul dnot repriduce this on my platform.
>=20
> I tried to reproduce this on a Coffee Lake desktop (i7-8700, Cannon
> Lake PCH AHCI 00:17.0) whose INCLUDE_ALL DRHD reports the same
> relevant capabilities as Tobias's dmar1:
>=20
>   dmar1: cap d2008c40660462 ecap f050da
>   (SLLPS =3D 2M|1G, ecap.C =3D 0, MGAW 39, SAGAW 4-level only)
>=20
> with intel_iommu=3Don, DMA-FQ default domain, max_sectors_kb =3D 4096.
>=20
> - 6.12-based kernel (pre d373449d8e97, i.e. the old VT-d page table
>   code, with the larger BLK_DEF_MAX_SECTORS_CAP): 2M O_DIRECT reads,
>   clean.
> - 7.4.0-rc1 (generic iommu page table): 2M and 4M O_DIRECT reads and
>   2M writes from hugepage-backed buffers against a SATA SSD, ~15k
>   I/Os, no DMAR or ATA errors. The iommu:map tracepoint shows
>   2 MiB-aligned iova/paddr mappings, and domain_translation_struct
>   shows 2 MiB leaf PDEs (e.g. 0x000000039c200082, PS set), so the
>   superpage path was exercised.
>=20
> The 4088 vs 4089 threshold matches exactly the point where a request
> first needs a full 512-page (2 MiB) IOVA, which is where superpage
> mappings become possible. All three of Tobias's fault addresses fall
> in the same 2 MiB window at 0xff400000.
>=20
> So on this hardware neither the old nor the generic page table code
> shows the problem, which supports Niklas's suspicion of something
> platform specific. One difference: on Tobias's system dmar0 reports
> no superpage support (cap c0000020660462) while dmar1 does; on mine
> both do.
>=20
> Tobias, a few things that would maybe help narrow it down:
>=20
>   1. Boot with intel_iommu=3Don,sp_off and an unmodified cap. If the
>      faults go away, superpages are involved.
Very nice. I just tried with a kernel with the cap at 8191, which I had=20
at hand (the new default cap is 8192 IIRC): with intel_iommu=3Don,sp_off=20
the faults go away, indeed. More on this below.

>   2. The full dmesg from a failing boot, including the DMAR/DRHD
>      lines. The faults are reported as DMA Write while the outstanding
>      commands were WRITE FPDMA QUEUED, and I'd like to see what else
>      was in flight.
To be honest, I'd like to avoid having to capture a full log when the=20
error occurs, because I can't think of a good way to save it.=20
Technically, I hope the logs up to the first fault are identical with=20
the various caps. As you can see in the log corresponding to the first=20
screen full of errors in the attachment, there are exactly two WRITE=20
FPDMA QUEUED commands that fail at a time (with the cap at 4089 IIRC),=20
so the log looks very repetitive. After the first couple of errors, the=20
kernel starts reducing the ATA link speed (and later maybe also the UDMA=20
speeds) and continues to do so until it gives up on mounting the rootfs.=20
Then I=E2=80=99m greeted by an initramfs shell prompt, and I=E2=80=99m not =
sure if I can=20
mount any other filesystem at this point with the slimmed down kernel=20
config I used to speed up the bisection.
I=E2=80=99m not sure if I=E2=80=99ve understood you correctly regarding you=
r second=20
sentence: I don=E2=80=99t see any contradiction here=E2=80=94for a WRITE FP=
DMA QUEUED=20
command, there should be an associated DMA write. The QUEUED just=20
indicates that the SSD can reorder the commands in the queue (NCQ).

Am 24.11.2026 09:55 schrieb Thorsten Leemhuis:
> I just a few days privately was told that "intel_iommu=3Don,sp_off"=20
> solved
> problems wrt to one unresolved regression related to iommu with a
> similar generation intel hardware. The user wrote "[kernel] code
> improperly thinking that the CPU supports something called=20
> "superpages",
> which it does, but only when the integrated GPU is disabled (speciality
> of Intel Haswell)."
>=20
> Could that maybe related? Do you use the iGPU? Does that parameter
> prevent the problems? It's a long shot, but quickly tested, so I=20
> thought
> it was worth mentioning.
Yes, it could very well be related. My CPU is a Haswell (Refresh)=20
Desktop processor, and I do use the iGPU. And sp_off seems to prevent=20
the problems, see above.

But what I still don't understand is why DMAR faults occur. There are=20
dmar0 and dmar1, and as Laurence explained, dmar0 does not support=20
superpages on my board. I guess this is because the iGPU is supposed to=20
be associated with dmar0 (The BIOS might configure this differently when=20
I install a PCIe GPU and deactivate the iGPU). Is there any conflict if=20
dmar1 uses superpages and dmar0 doesn't? Or does the kernel not respect=20
that dmar0 does not support superpages? Or is the iGPU associated with=20
dmar1? Who determines this: the kernel or the BIOS?

Best regards,
Tobias Laas
--=_a0bc4d5717c364c5892ec2d35f20af0c
Content-Transfer-Encoding: base64
Content-Type: application/x-compressed;
 name=errors-page1.log.xz
Content-Disposition: attachment;
 filename=errors-page1.log.xz;
 size=756

/Td6WFoAAAFpIt42AgAhAQEAAABSQCtu4BFRArhdACITRCb6Xl/hSARhz/6EHyB2DO+W+mIEXPW4
9keuMX/fvz71eXlhu8OOAPIx6Gu0T4ns8pGP1CdRSOhWfUkV55qDAJpJaszN6meosmvP2+XAKE9k
qNdBaR6OKSeo2pLZmcTw9Qsfvgn3OeLAbzMHYGdPoLbkdVFhikFVFCNY4HYXq+T04hOIMG1LgClT
ZuqIMUzjActaxKY4VcyvkV6/mz2UakbFow+Cgz7sARw0dGqkSRxvgedSWjZfpKOjP4Ll8buPcjHG
ebxU5MesHe7ST86Zd3vQ2C4A/oQB3jf47cFP2SoIxpN+Yr3kneTruvCAve8TZuvl7ImLAUen86xd
JofDp3rx9OR/4nUj7cmdgTq2S17774PF6bB9SOpu0Hxo3CDMx+/3nMQ7OSaAWMXrGbX/qjV7ClVv
nlDVu4iRpETy7IMUCrU/N1nHBG+HWZmX2jVCL1/8EppHMDvBkTRqFpfDDU+9jHOiZ/2Z1MLeDDSl
/4huoxVKIiy2kLz/JbHwZtSsMbFgmkus2DZe1MRdC+UJ8fO1vf3ESNzFVqp6fYJ+SOl98Ag65Jnp
8+CbtwNJYQnbfcUD5aH9/RjURtu606YhYgi5576dUq1/mZxjzCyyObKO0t7l7t9q9zrs5SzRrobQ
Nx38zFBec8CXCTtQlc09oOrHF+GJX2bqqQY6QlQKWGUExFXMTiTrIGKH3dPpczGV7s39kcoCqXif
p5MbW+7aQEpJPrXkGsMRRxpMIuIkrZ06XZODo+h+LcFsL5rE3CE6xChToAyEZcW7HmV76pJeX1mc
vaijG9t+WfLR9Wbe47Rcmkl/JCmn2aa3I71UYO2L9qF11s2x16Mw7lh5PRhBwT6zQJDR8wAknnWf
VBQOPIbZmSG7qrlIKQXztnXvI+Bvmfl15oYf0gT5NywFrYidUui1loqIkABASj3aAAHQBdIiAAAe
pB+uPjANiwIAAAAAAVla
--=_a0bc4d5717c364c5892ec2d35f20af0c--

