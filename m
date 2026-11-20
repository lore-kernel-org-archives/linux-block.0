Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795196666;
	b=L7eFyDqSRVo8nKlhwX1AXWPFQkoNZesk+5BH9Dcq7UjqooJ56PSS/ndoc9ehQbza5agi
	 DCJj83h/UApXrnu/swpTfNyx51TZtuaDibvhu4OYKXopForD8FIlQH8lz6kdFh07PwOWr
	 gH5QJuULDWCulz793X15xnvY/W9+jTKDiPFEhFqSuiKyHMeVk+3dhIlUib+ZkSIU8hes6
	 WXE2ZslcWwVKvDnDUTuNGGE8s7RIXWkFoQ+JWbZhuFnMVxVMh6Wkb8kRnTqCqgheUVH1o
	 kMQi3upqzKgP6MTAtiCQEPEDnsdaoADs04hXQiMULiS1g/it/VJ1V8hnzcgEj554OuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
	b=MukJTsl5uQxaziH62EuYJ9Ji17YebwNPv7Ah5A7wgfQevWlFhM2qVPdTYDXbqyS3DnPb
	 r/M22KHeUE1zEbW7VpndlhtAetDXATYYjbEaTkmIukE+h9z81eAsTKPY9N/Y2d7F8nzig
	 Arg6V5Af8yjde5HehpLiZtJNiu/+5t5D+v7uz1oVV3WuU+AFFYYG/t5a4d+GaTyB5lGOV
	 oOPUIcN8LkaCcaPqjDTj/FTzrdmwUQ0tb5Tb5SDBUWUt7XxFN2DbKk3nzHSCFHUZMcZfw
	 WXmwM9mK3izIhQpgnC0Uad4sn7Eblpf5GafVXaay3ubtOzDvXCXYkxBv2zinUdqL8jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LHJ6QWol;
	arc=fail smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392A606A334
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F392A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LHJ6QWol
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8231ccb04a0so144848a34.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 09:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795196665; cv=none;
        d=google.com; s=arc-20260327;
        b=IL0XUAX4BwnHSV7hdg57jWBk9+QtAOJ3RCpkPWjV6P2S0mzbVAwQw18OHFdBgcRFRh
         avZy3PisKhixo64y8o2q4HeNEAV+P6owJ3gytVaZzilXUl1YgmOnMXVv1VM3gkQ7qch0
         hQHAH7SFeaWcuNoDqOXKbQjpkBascjXwuO6E5T36tnmHYOmmHjFuGnoVfgYJcoTh8iQm
         M26BLu9xz8oNTAeu3wwZL05d+T1wiTTUzmr3ozuVWAcP1CX5dKrEvUF7klHgqEigI2me
         Ob436NpBQlE40X+c290Y9fIs5Ll8G/mnqp/UqrWF3bRnBAIuUuXB6NaofiGFRsIzmRTH
         vR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
        fh=hf14YNa+WriQlqDe4TbIYTpfWEcvNSJb/G1MIv17lE0=;
        b=RaNRZaaDB0gdjwdKj+lQYE9Xh9VOv9924TezRc7TuMuKiix9lTzLDPxQ29NdteCiuo
         55jrqdgQgA7Xt1/6ZIj/6R3M8ApxhWVy3M17WXXJR5lLqcoWhcjUGhO+Rfaq6U6dW0iF
         gWW75lP0t9zSxDH0N3ZElITIUbkeW/26RDLdsuSx51go0++M7iC2J5IOT4l1AoK0gY7S
         63AHTfiyFGmoF5RgDmwBkFgvg1b6zvzloXw4Rw1EiC2mD3s7Q/0Sd08kAbwV8M5dxyor
         z3t7F1u5en1M8BRczA+JnhdzDsQqI9nv01DpZ94fOssHfVUPGNsrv8cUH5CQ3cA4dMxb
         s+Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795196665; x=1795801465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
        b=LHJ6QWolNZbCECT1cCM5sJta11VYUHU7CZc8SHEQ8lqzh+DXexDxS8nP+YiC+PcCp4
         v3MOFF9uh+g1gyQx1S1rhqX2DYn3XGc6c0pg+Rx1xXLVbPaQeTJUCBHJOki5u/UqivmY
         1mOupbvh/iRl1UY43O5c6WPfw4/8eE/1zGpozyY6ZZjoFpDKKXOTq5bFosJHeZkzIE0Y
         a/8D+jz8UBjVhhqIyKRd4K6x3E79uakHohWgKzHoZuvEx9Q1u9sQRmrclQJiNuJaFwgR
         4NmxTx+QbZvaSXR6NPJMZXhA+1XWC4HPMhYBJdRrdCOPbL2HGffM/F/K2c8dCyG+JiAP
         X4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196665; x=1795801465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
        b=ue/VVovNXPwYdZuTmelCWRk72eIJ9eeQ96upNc64oNh00RONS1rZilQ39BCawYieem
         54KwLXl4ruwXXvUpFdEFUkFJu0tUFD9mpLKe0+Ou6DOatiTz0Qrji4I5FTFtBzVMuSHH
         iWv8hJAC2ZeygZzXpwMV1eWr7Bmi/lIXxD1ucVeddPrluWuv9phrWxPE4ZFUpiJ97tRy
         qlBFPP2n6D2mQvvgTCt7YD1W7R4LiKuk0OrBfGM8aAm06wrZq+C+0OAbexIRolGaNs0I
         T7Diz4k7Y8ZcS3QSXsU2wuKl4sHq6o8Zgu/XxKy0WQkZF2BuWXy0Ri99pUApbIC+alRy
         rWGQ==
X-Forwarded-Encrypted: i=1; AL+hErH+ySpJyGniwSqzdhhtxzXvlE04LYSvNAPLsqF0S4jj2HuaAn3nbul7CXndSNCZLGhPzdkIA6wUSEwx4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/a+VG3wXrbPPugzh35o/NhttkZUNqBa4rSJgMaaAGLvStJ5cVQ
	5e+R22BjI9IgGb/3NFxKbBii+wxK1l/5/vzPhIsxUPCfHEUbGrHwBFplaaQA8Ck1AteDTdrFiA/
	IpO/GI2LA5i/KA/e9tyy7miWzvKL/UAWEw6zduiBj+g==
X-Gm-Gg: AYBFou00o1VP9p0vw9yUUGX5Rik8HkDZcxRq96eNzCihk+wt2Qyv4hN3Y8EmkD+Oq9s
	Y46uCe71mylyFb8Bc7d6y2zEopFXZNxudXQpjbqU/diWKunjTM1roQ8Kg2fUQdItO3x1qXGYcH6
	1enOK8qD/ebk0aTi2K6YmSOHNIaP9oZXX+RBxF6vB0n24TjR256rm0bKxrAnB7PAi8ecJoH9xda
	FgwoBUbUkjl9tCY0Sgrnau/Y9aPtwznZHa5S/PQfw92gZVJBSgMLfDYYaBNfxJbrBbhELnxPxkw
	rggadAfuQgofm8ePZu+9z6OaszcNpJh2T9PMCtPBYYaAzRSpvvZHwEf9NsoghZSjx6W7MO0oyFk
	BbmknUA37NEq/x+Sdq2sLaS+jjMGW7LTJajqUqA==
X-Received: by 2002:a05:6808:151f:b0:571:a186:d6c8 with SMTP id
 5614622812f47-57a06506db4mr6743010b6e.1.1795196664754; Fri, 20 Nov 2026
 09:44:24 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awBnB-55HQ54C1x6@infradead.org> <20261120162257.498238-1-zakaria.belkadi@inria.fr>
 <awB8OODx0fCFGc5G@kbusch-mbp> <awB_xd60To4UawrJ@infradead.org> <awCCG3FWbMHHvYd5@kbusch-mbp>
In-Reply-To: <awCCG3FWbMHHvYd5@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 09:44:13 -0800
X-Gm-Features: Aa3M54rN6No3ymPiMuTUPQJo1VGf1P8ZHIrPSwo1qjIt4YuOPXOB68fUXRsfIYE
Message-ID: <CADUfDZqNM2=KzsnpA+R5ygAbS-SiUzQczZvgM_NoYrhR7Qyj9w@mail.gmail.com>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref tags
 are remapped
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Zakaria Belkadi <zakaria.belkadi@inria.fr>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr, 
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr, 
	stable@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 9:23=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Nov 20, 2026 at 09:13:41AM -0800, Christoph Hellwig wrote:
> > On Fri, Nov 20, 2026 at 09:58:32AM -0700, Keith Busch wrote:
> > > > Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
> > > > bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_=
WRITE
> > > > when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
> > > > block layer can remap the tags in its own copy.
> > >
> > > Can avoid bouncing? I think the remapping flags can be tied to the
> > > user's reftag check request.
> > >
> > > If BIP_CHECK_REFTAG is set from the user setting IO_INTEGRITY_CHK_REF=
TAG
> > > on a write, we can map the PI buffer for writing. The user explicitly
> > > asked to have the ref tags checked by the device, and partitions requ=
ire
> > > remapping them, so they've told the kernel to write to their buffer.
> >
> > No, the user did not ask for violating the mapping direction.  The
> > whole remapping thing very much is an internal implementation detail
>
> Okay, fine. But can we skip bouncing and remapping if the flag isn't
> set?

Currently, the remapping happens regardless of BIP_CHECK_REFTAG. It
depends only on whether the block device reports ref tag support via
BLK_INTEGRITY_REF_TAG (i.e. Type 1 or Type 2 PI). I think it would be
a UAPI behavior change to make the ref tag remapping conditional on
BIP_CHECK_REFTAG.

I don't see a way to tell ahead of time whether remapping will be
required without walking the metadata buffer an additional time in
bio_integrity_map_iter() to check the current ref tags. I'd vote for
making the simplest fix for the vulnerability (e.g. always bounce
buffering) and optimizing later.

Best,
Caleb
