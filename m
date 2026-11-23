Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470572;
	b=oFYuBZYOva9Ywy0vpPnHtb+s+hpcLKt0EiUDQGC10t65vE3t4oYG0rIEF59cuN+0PEaE
	 qekCDaqeBLI/o0gg8HNlzttGULpO+DxGrYNrCBlFMfjo6hfLVgHsJoYtnyDdDQb4RgdyI
	 jULp1EHUL+nF4ZEJZCXhYrkpqQwONZBYboVk6gGoZ7MM0wp7dwRUidVDQ/bJy5ktl3DYc
	 O20Bqn84NmJZGM3wN1G2M/XE/zU4CHnUb7P/At0FhCLd+8OoT90LDI/aWjFKufiZZPGaJ
	 f8p8kuTA9fAdx+SXB27MhD7iu4AKRmAZP6UjF7h3HBSWdjpVj2PeqSQiUhlJ8R/wHXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470572;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
	b=xC+RUiH+Hofma2UoSJVy0gEUrWidRUusksscR7CaQfe+TJGiC1a5Nv4f6vFAEkTlzoVL
	 F/yrsaZVVp5QzIWO5P2oDu74HjgLxtcI0hA57m/0bHOy1HcLKQbqAIP36vKm+GJypdUIV
	 dXTOTJmRAidZMaa9lPWvYNYPNxkxVBjaaHwLwwwkxEJhLcAt4B4hu78LVoKc6gLF3AGpQ
	 4NCnjdG6A5bmjbonnQeqPuFavgnC+K2UoD7xQhIKZiVZyl4dLJv3sIEHFVjo1xNePM0e8
	 1VoXatBBE/QPg0vvheGaXwA1TpfZxsIUhKdFTIn0pzH0dUJUU+hUawudjphznfniRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P8utDJXe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bCXDnQ2R;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C5606A31E
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 21:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P8utDJXe;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bCXDnQ2R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795470570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
	b=P8utDJXemWcB23UD8Ny7GUBZQFlqFR2oolQreTffV2mwufBZyHki6jKc6+5UwtuI/kTfo9
	hasr5FK0ggrkdSg/WOUUIKxpO1wqyCBztiJ51m2FhqAmq03OojH3MGn9TZ5hhHsqySuD/B
	bU2N2IP9WR6a8PIdTUCWdoQPZnM7OV0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-q9zHxN92OE-4DJsE0HUwDw-1; Mon, 23 Nov 2026 21:49:28 +0000
X-MC-Unique: q9zHxN92OE-4DJsE0HUwDw-1
X-Mimecast-MFC-AGG-ID: q9zHxN92OE-4DJsE0HUwDw_1795470568
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-92109408212so80537636d6.1
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795470568; x=1796075368; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
        b=bCXDnQ2Ryer5m326RspAln23rGoCEwQJTNaCAWCsv96rqxf6eaYey6KX0q789iTMCg
         Cg92nKnghbXo3L3AyI5aII6FtvN/X0pEU0jc48Fx0Ye+WTDrMCEBldLuTPmZ/51YhVfj
         VvmJkehxJ89hBkv4ZJt1bNMCaVo61f6c+86YXpf3dfNFkzzpteASf9fWCWlmuKIjM6o/
         vYTkRqeNxo/MC2KsGR6Xkj6nbwNgZs5M1+PoNjZZmW+nAHNGVytGAtdgxs5RoJLQeLDP
         o+Ag3N2s1oPGc+mQy8O6t06sfFL9LF/uoYYAzQIfprGwnH7FHh8IkRe1mFdtw9Zjrm0s
         PjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795470568; x=1796075368;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
        b=XsvTIbSiSL6dZlS38OYrfTwoH/s8Y69Wu7eeGODUwbBxDMX8mQcR+Jhl4YisQZiSy6
         tyTHHjefKStnwnll4AHgHCmqmyR9aApfAKZkDxxe/go7oRtDkbB88tUEOuWK8HePgmon
         MGk/3YrT19tLO3ARBxXBMNfglr/t3TYb0JMgKBGy3IkH0Meqkj2A7IfW1hurO/QOWRyh
         jtpZwluko29Vyn/pJEiCKrcvt3HeJBen8SJ7H+2TPHrzGKnFdGK900Fsce45+tvf48Dl
         RbjpgUlUfsnDUeEhkUwY4aWUXz6ywsmqrdHIOSpoZtFP6HJONUDS9/78aW590VJ5uv5G
         8wEA==
X-Forwarded-Encrypted: i=1; AL+hErHH0Xu38Ge+xXauvX0JwXtAmwPpmF2rxKM/5ayw9ZTOdlezr0XCf8JSg51KsZ+yD0frOH9eX0IU4OjM7w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dGI3NKGmOtWWUHpzJwlxbOqrlkTn0W6/Fh4lq7QFZiNtWGJLI
	sturCZz3MuDtF2SlplHRUL4MEaQ6pgAyWJYbUB0RZmXNWJP4pH4uuQEtEktk2Mlf2ZQyj24UBzi
	6BQX79jhimfJnY8sDzI5IF79ThpM3bcXyNy65Xrzou6tnnc4cZvIzQ6r6RXEY3tGkkEsk7mRq
X-Gm-Gg: AZFdTZeM0WLA6VQ52RxbP+cEEDf6pJoP/uA51NfQtJN6nYL/pZgXmxmOWJxrYl0M1YP
	/wD4eXnNtojWTwaHudtI1uliEXkSCUpGW4+hKGdYtUn2NuwYTUr5qdfNyluRwAFXdUSTcVXJuxh
	lMKr47kDnYrSIysL8eS79ItDbXqs2vN6AudeW+PO7gSIOYIT8ibyE1fw1h/hEqpjwoluaOC+H7y
	UJloGUCS0pL7A62otBylJW2O8mk4XkzheycnzPFsxAEFgpoEfvVdjgzf7tJGtrAfZZllzVmFQ9d
	iYZR+7s7toq5wKWpfZl/0rdgnoy3lav59BCIYPfn+ivs/CE/1xXH+V08hpBk3KSogJ33rfmVYHI
	15/ySqx4B4qea9l65OoQvqgOr7l5dI+0Djo54ym592xOL4h6ERgdUf9zOPA8P9Rkv88/vrdVnK6
	IAkz1Xcab014Tubo+Aiz6oECL1fwwEoEKxsrMzpmyc6Pm7A8TbwlH0Nm3MekkzalZfpuzlak4=
X-Received: by 2002:a05:6214:252d:b0:91e:a73b:f9cb with SMTP id 6a1803df08f44-921349d1a8fmr238824466d6.4.1795470568028;
        Mon, 23 Nov 2026 13:49:28 -0800 (PST)
X-Received: by 2002:a05:6214:252d:b0:91e:a73b:f9cb with SMTP id 6a1803df08f44-921349d1a8fmr238823796d6.4.1795470567440;
        Mon, 23 Nov 2026 13:49:27 -0800 (PST)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0f6bsm117366396d6.21.2026.11.23.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:49:23 -0800 (PST)
Message-ID: <7eb28c6334a655eb5bfbf3035cf1f1ff1041bb3e.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Niklas Cassel <cassel@kernel.org>, Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>
Date: Mon, 23 Nov 2026 16:49:07 -0500
In-Reply-To: <awSs5Cw3hFkf4O4T@ryzen>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 22:15 +0100, Niklas Cassel wrote:
> Hello Tobias,
>=20
> On Mon, Nov 23, 2026 at 06:51:03PM +0000, Tobias Laas wrote:
> > One way forward could be to a new entry to __ata_dev_max_sec_quirks
> > similarly to the recent commit
> > a12cc63129380a5364e787d92b30a3257f66c250
> > ("ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8").
> > However,
> > I wonder, whether that would fix the underlying issue or rather be
> > a
> > workaround, because 4088 does not fit the pattern of all other
> > entries,
> > which specify either a power of 2 or a power of 2 minus 1.
>=20
> Your attached kernel log shows that you have a
> Samsung SSD 860 PRO 1TB, FW: RVM02B6Q
>=20
> This SSD is probably quite common, so I somewhat doubt that it is the
> SSD that is at fault here.
>=20
>=20
> >=20
> > Furthermore, the first error messages are DMAR faults, and a SATA
> > SSD that
> > isn't functioning properly shouldn't cause any DMAR faults, because
> > the SATA
> > controller should never read from or write to areas outside its
> > memory
> > region.
> > Since the issue with mounting the rootfs disappears with
> > intel_iommu=3Doff, I
> > wonder, whether there is a limitation on the maxmium block size
> > either by
> > the hardware or from the configuration of the IOMMU and SATA
> > controller by
> > the kernel.
>=20
> Considering how common your SSD is, my guess is that it is somehow an
> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI
> tables -
> DMAR on Intel).
>=20
>=20
> We have seen similar reports here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220693
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221713
>=20
> Does it work if you revert:
> d373449d8e97 ("iommu/vt-d: Use the generic iommu page table") ?
>=20
>=20
> It would be nice if we could involve some Intel IOMMU experts.
>=20
> If the ACPI DMAR is at fault, perhaps it is possible for the kernel
> to
> patch the ACPI DMAR for your platform.
>=20
>=20
> Kind regards,
> Niklas
Hi Niklas, Tobias,

I tried to help here but (full transparency) I had some LLM help for
further ideas after I coul dnot repriduce this on my platform.

I tried to reproduce this on a Coffee Lake desktop (i7-8700, Cannon
Lake PCH AHCI 00:17.0) whose INCLUDE_ALL DRHD reports the same
relevant capabilities as Tobias's dmar1:

  dmar1: cap d2008c40660462 ecap f050da
  (SLLPS =3D 2M|1G, ecap.C =3D 0, MGAW 39, SAGAW 4-level only)

with intel_iommu=3Don, DMA-FQ default domain, max_sectors_kb =3D 4096.

- 6.12-based kernel (pre d373449d8e97, i.e. the old VT-d page table
  code, with the larger BLK_DEF_MAX_SECTORS_CAP): 2M O_DIRECT reads,
  clean.
- 7.4.0-rc1 (generic iommu page table): 2M and 4M O_DIRECT reads and
  2M writes from hugepage-backed buffers against a SATA SSD, ~15k
  I/Os, no DMAR or ATA errors. The iommu:map tracepoint shows
  2 MiB-aligned iova/paddr mappings, and domain_translation_struct
  shows 2 MiB leaf PDEs (e.g. 0x000000039c200082, PS set), so the
  superpage path was exercised.

The 4088 vs 4089 threshold matches exactly the point where a request
first needs a full 512-page (2 MiB) IOVA, which is where superpage
mappings become possible. All three of Tobias's fault addresses fall
in the same 2 MiB window at 0xff400000.

So on this hardware neither the old nor the generic page table code
shows the problem, which supports Niklas's suspicion of something
platform specific. One difference: on Tobias's system dmar0 reports
no superpage support (cap c0000020660462) while dmar1 does; on mine
both do.

Tobias, a few things that would maybe help narrow it down:

  1. Boot with intel_iommu=3Don,sp_off and an unmodified cap. If the
     faults go away, superpages are involved.
=20
  2. The full dmesg from a failing boot, including the DMAR/DRHD
     lines. The faults are reported as DMA Write while the outstanding
     commands were WRITE FPDMA QUEUED, and I'd like to see what else
     was in flight.

Regards,
Laurence

