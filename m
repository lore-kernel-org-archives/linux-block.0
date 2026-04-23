Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9F29D275
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931923; cv=pass; b=rptwGM1khiOf0NgY4+1PQndPRkftzPGfetUjPjiJfTVfn5czVqjafc8krYGYrY+Iw6Xf7axUdh1dnFeleoTbrgmDKXHH9M+QJb/brMzB2ixpDzRMr3ercJc5qD+3qZ1FKQHS1EVBADn2tW4iBBR0bXsNUahvRN7XWezWk9xdzlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931923; c=relaxed/simple;
	bh=FBFY+j9O1ezwGMt8wjE4G7Wepfqjb6qbKfE3J0CWqXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+BVHZBjMCvrQgIBHycawbx9A9kEasly5bC2OPLnwlIabG4Yl9YgZnmI2AdP+sG6Kk6mGI+z+Yc1Dbu/i/9Pf+ykPpgcNoMJFBkpBEdv8D0vXzG08/ku34JFrD8/BmptF5qsml68MY0kxKM1cf0Z7c+jBIFTnvRbzJJ9O8DZio8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LZxXHIU8; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LZxXHIU8"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a1307438ddso5837335e87.1
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 01:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931919; cv=none;
        d=google.com; s=arc-20240605;
        b=GKXPJPQmhPrtQ+f6PilZk16pPr7wER61qceFdIEiS2viWw5iWdtZ1xkMIbiM7rKJw6
         BCX8u5EbjDqo6Gl/RplPcmJV/+XAA59bdayXLg4ywbrswJqee0ALELszeGatZHqZvO5X
         4Mvjnk3FIluzIwwz9Wy3K3jRi2iKfbeYKE33WHlq+fSCdLalDLISng3qEQD92IvSpBFg
         pdDqyMe534sIV0aOSqnyNZNwUskvqkAxnwdrcwKBkV/yMybXiS1sg5FoHJyR0JQBIHGS
         SgEZdopdRBVVYHMFTS6syleM1F+HmXFoKq49tchMN8jARnEoj1S8b4ADVXFs8iweG1ma
         DTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        fh=vuOaT/HK8JRu0gNxJa4ni4SLjZEtiFi5DbSumdmjxs8=;
        b=fBiS9T9FfwkPAtK6C8Vhhi9mGiqNKCEO2HOiC1q7CJe1V5HhxvMkBirg9EnZeTUBTx
         NPoFTlLIeFou/JPo6xMIyULjZh5VHcUyQz/XUOtczsYYbCKLcgmJu3HeOBrFAAEQeK4q
         IJBiRY3CivkgobGPggIMECr0E6ufPDuVAF5x0sJuOpRUPo3UUJFgFd0Ihz73krtsCBIF
         2GXJP+uID28MnNkC+23Y9NaMmveS5xdGRYD5Bj+/ksTpG6JeduKZW4dBIGAtB7BlaW+2
         ICTTJZ0VtTlGNPHr4jjv+iEtIuHbT3KJK+F9V1gJveV8aqEihf9wpBvO08wXINcgAc61
         yPNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776931919; x=1777536719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        b=LZxXHIU8Fzc1Rhw7AF3e24Cq9Ni9zaiXujz6UTCKT9+1RVtQJYQ1Bif0V/ah7S6AkK
         QVHSPaDnCiGC86kkVfX/0v9NsDcC9AvpwBHYU+RYi2FREgYsfWpyNQNSrU3FZGPI0mpi
         9zyKT0SD5wPkC17KDHbm1LHuana/JMTEpCIkZEa5hL9kU24I9hSAc6dtfa14gyAClMD7
         xSY8WK8iUrbsQtxsq7jtc4DDVn6h2BaHKi6iZuLP3g8THQeI21PZkbQmvsRKm58pjexI
         9zXcvvMXr+qUZeuExK8Lh5SEptOU2/ISlquzEcNa7+uQWIdmwaS/3aZ/Fs/Pp5PR2lk0
         QzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931919; x=1777536719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        b=sPu52OKC4iyZPSWDJi3QNIe3JSAikzmweKr5ts5OwoXSp+awsbJ2ypTqxYXUeFH5LW
         W1MWkeecFrsJvGEvb4XUQHblAXdFDrjMmcP3jwndBMwLpO5i1MbM77Um2ZCSetb/hAjT
         xnoVmhKC6kBvdtAocfMkwRoZrSFC2rqCnM2CkRBfpPV7/1rHFY9Kzj7qyDgjsHUDkJTb
         jq1kpcC1vnxC29AQW6RsaJMpX5UgRvmu4JnuoCZGANnZFg8Sw20qPcrz12JQfBT5m4MU
         GEjIxgTPzxpVQ+LrMNGxapbxSJNdnfaqZ0eAD/7dNVmN6z4NxLnBja+dYoLDWasOMXvP
         VMPg==
X-Forwarded-Encrypted: i=1; AFNElJ+xQJIosbp3oDpVkRgsGHAfGFJDjLD0iczPQ1dHcsreqpPjEcCay/W8Ki5ZmieHKaAWEXmiaoavcFoURQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySLmc1Ino/Etkr0JT89mCtjf6gzYPNcDvOI31+FD4XkGXC2UAI
	zBXM4FlXxmnHD26vikwO7m1GdKJovlNXiekX8b9wpzR1XNB2uTDeym5XBX27js3lfkGJV0kEnOD
	kMQKKJbG92WwED4n3vs5iTw/herEle9RdBcWdP6lkUw==
X-Gm-Gg: AeBDievFEfZmBErietNo6v5NTqy5CrovqHeeP37pwAHpE6jbtNc1L2tNLy7c12lD/+s
	CRfpRetd2L7ZX9ZdHHJoRwF9NPez18ayurcDinCKP3B1A9ozZvByWKEDOTXCYmUXGjOiaJBLyiT
	QJC4oxAeyWhm8Sk8LaE58bkmvdSmcgfPEdfFsMiz2ykVt3attyvIJSQQ7m3Wco1ri1p768nhUdZ
	/dpVcE5o5PIkcW5lVnMM14f1m9j+YEGaVm+NzeLAoYgxzQv7SfRjN9gGmHPFy+lRAcerANP0uOi
	BEL3SGeXwSyjentoRZCyHhX9/BGYyqhC1p+ZQdz+zcyZ9Sbi4Y8=
X-Received: by 2002:a05:6512:3ba6:b0:5a3:ff60:b72e with SMTP id
 2adb3069b0e04-5a4172eac66mr8218916e87.39.1776931918554; Thu, 23 Apr 2026
 01:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416192942.1243421-4-atomlin@atomlin.com> <20260420131152.243488-1-marco.crivellari@suse.com>
 <tfkr5mlsdzbhdzv46ookoy2e7ed2wcozuxanv4wagjf6hqb4sa@7i753lpqkxvp>
In-Reply-To: <tfkr5mlsdzbhdzv46ookoy2e7ed2wcozuxanv4wagjf6hqb4sa@7i753lpqkxvp>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 23 Apr 2026 10:11:47 +0200
X-Gm-Features: AQROBzAAJimGp24FdJwHT7vl8MEKvFnP60qRLQ-HOdwRzLvk1TNgQokO0fGWBCw
Message-ID: <CAAofZF5+igiyR8vne9We5tnfouuWNO2H=BdwWbFCN+gnpUXoVw@mail.gmail.com>
Subject: Re: [PATCH v11 03/13] lib/group_cpus: Add group_mask_cpus_evenly()
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: James.Bottomley@hansenpartnership.com, MPT-FusionLinux.pdl@broadcom.com, 
	aacraid@microsemi.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	bigeasy@linutronix.de, chandrakanth.patil@broadcom.com, chenridong@huawei.com, 
	chjohnst@gmail.com, frederic@kernel.org, hare@suse.de, hch@lst.de, 
	jinpu.wang@cloud.ionos.com, juri.lelli@redhat.com, kashyap.desai@broadcom.com, 
	kbusch@kernel.org, kch@nvidia.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, liyihang9@h-partners.com, longman@redhat.com, 
	martin.petersen@oracle.com, maz@kernel.org, megaraidlinux.pdl@broadcom.com, 
	ming.lei@redhat.com, mingo@redhat.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	mproche@gmail.com, mst@redhat.com, neelx@suse.com, nick.lange@gmail.com, 
	peterz@infradead.org, ranjan.kumar@broadcom.com, ruanjinjie@huawei.com, 
	sagi@grimberg.me, sathya.prakash@broadcom.com, sean@ashe.io, 
	shivasharan.srikanteshwara@broadcom.com, sreekanth.reddy@broadcom.com, 
	steve@abita.co, suganath-prabu.subramani@broadcom.com, 
	sumit.saxena@broadcom.com, tglx@kernel.org, tom.leiming@gmail.com, 
	vincent.guittot@linaro.org, virtualization@lists.linux.dev, wagi@kernel.org, 
	yphbchou0911@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 7:47=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> On Mon, Apr 20, 2026 at 03:11:52PM +0200, Marco Crivellari wrote:
> > Without it, I guess the kmalloc() in `group_mask_cpus_evenly()` will
> > return ZERO_SIZE_PTR:
>
> Hi Marco,
>
> Thank you for reviewing the patch.
>
> You are correct. If numgrps is 0, __do_kmalloc_node() will
> return ZERO_SIZE_PTR.
>
> > Should this check be added or it is not needed? Or maybe rely on `ZERO_=
OR_NULL_PTR()` ?
>
>  - File: mm/slub.c
>
>     5275 static __always_inline
>     5276 void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flag=
s, int node,
>     5277                         unsigned long caller)
>     5278 {
>     5279         struct kmem_cache *s;
>     5280         void *ret;
>      :
>     5289         if (unlikely(!size))
>     5290                 return ZERO_SIZE_PTR;
>      :
>     5298 }
>
> Regarding your suggestion: rather than relying on ZERO_OR_NULL_PTR() afte=
r
> the fact, I think it is much cleaner to just add the early exit at the ve=
ry
> beginning of the function, exactly as group_cpus_evenly() does. It avoids
> the allocator path entirely.

Hi,

Cool, I think that's the right thing indeed.

Thanks!

--=20

Marco Crivellari

SUSE Labs
