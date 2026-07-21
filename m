Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DE480DE3
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629700; cv=pass; b=UVvvTBbzWYm6JdxruSO9LkkhvIhKU43SP5a/Hknw0+tv1I4mM+drVNR75LkqJrDjPgqfdfaPAs4+ANGA9bMUJfLIfACma2vtfVdnmnprhQUc+hTr11oXkgaaxRxOV9Ta2EIPo4R1fCtcTEuK9csBzycjuevjiUsKmHzWcsa+hDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629700; c=relaxed/simple;
	bh=GCmBUg9lf4+MCsfifhl4yZ8wJL9WIieZDMiRY5qBvak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0hLRYDRT7BHz3kvUST02apqtFCDQbdindUI934PlphH7R8ASdcf30LubLt8F/tCy5G4qo0CS3ZZUBPBd1DDFv+I6rTuPOXWsNt/88xaV1TlW38N9lfXj6owPfFo4MmPQGwlZwA8TZjoET4MbtL9GDmXsE9U18UJh2mkR9JVj8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eVmhLhki; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eVmhLhki"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b013084dc2so6689681e87.0
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 03:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629697; cv=none;
        d=google.com; s=arc-20260327;
        b=k06TLzPXfeYyWe4PPRmVFiCSRzk7Y8ecFjoJGocrrYJEFIk7EIZOFI4HnDAFzUPatE
         5KpRoNcjZ+7uVnTvErP1hTjIf210XWRDgOyMRzF29G3vpiF/OfOdcK3IKe9CRfNcK6Kz
         QAcJK3OeFp1p25fyRZ77UYKxUGWhI6dD4/SzExa4jxSDGjBtFhP3F+S0N2LZs9bWmFdy
         FElTGUphFAYBwScR/h4dkESZzct46LPKZXhWZ8TMfnxhOBnZKt8SZs9pvNk8CPR68E39
         3qtaP+/D9S/SE8IwunAF5ieVPBINMBqG8Cqe1KkHAjy7cHtxS+Zk3BrNNrV1Awltinco
         Cz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SoHnuR1K+ELu9I08mSGdKf/9orhIXXZRTqPFADnhB+0=;
        fh=r/fD83woVwCFu0/uSYG3I1OTExfG+dwuPBirYitc+fM=;
        b=Sz1eR2B2I7bCdOltbBpO08llAyQRBBJDIyYP674WCwIlpq647kHZfjR71P9FTDjnM0
         4FH/HCwBn7dopZQXiNMUNCaFZ63O2hCS+8f6DUEwegt9hsPhMgZdQ5QeV+JrIqRh0DUl
         I73grS+Q+YPvTe7Npyzl35PLFBZ2rWK9SRrTr/Yzl4oqNeUdylMDKZSyONN7sIKGlzSG
         5rxOgckavJcHydFOExNdCkhT8tjVp6ln/W+LNHn1W9ENIcb0kyPEbj35XFQ7/HIKyVLI
         tcjAUPTMwe0+xjJI6T3NtGTy19NgRRPMfpaTBDcWTqZ0cMQ4ecyPaWK5yoIqmsu+9f9B
         HXGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784629697; x=1785234497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SoHnuR1K+ELu9I08mSGdKf/9orhIXXZRTqPFADnhB+0=;
        b=eVmhLhkiSfGE6AEj7v9LDy6wJ6SODO3Vyb8wqNpFDeN78kdMdERrh2RdxBzucjzKiR
         800AFMqKnFXCH6H0I18TZ1ANqzo2XUAnNxTIFBjdTuJZyidLQ/KYRUWgIXI5o759cVFj
         tX8eybzvSF4iiLsvVLrjq6B1pX7LUQrsGpiKLmQMqVXWtXwiUSzlnrXk7u8EYcMStLxD
         +js8P63P+3/lXjUvuo92QIeG8q3CNaDfvbU+3WMknEV0k8r1aI90S9hk8ZjIwu9VDF1A
         GSbVJO7BSig9yI9HZ2AxebJYGrWj2/BuoqbqHJfcP2bOBb0nz8JnM9d9UlvLkm0NGiQ7
         QA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629697; x=1785234497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoHnuR1K+ELu9I08mSGdKf/9orhIXXZRTqPFADnhB+0=;
        b=MJV7lt+jTRe09/X5TdiR7rAhfTvBecKgRpnZqaAvx6FhvtPiDEokCQyy7S6EMKOeUe
         OO6AJI9BBfs1/HmoUF8UfTOv5s4UI/ZHe3zzWlDDP5IE2tu5dJYgGuEyUJhx/baICBMV
         avn46Ovj/i3yOuj1dwFE4hWRw92vwNXRF4UX+oz+ZPfXjl/hamr6ontpzNagcZrmyrgt
         kYur+8ltQBzhUqrrJ9BYJmKS/FdfA8UKCcqFsYQ07E0MoxLPM2f6fEzDRSpjsiVC6vKC
         9pLWhDk9CQ2wzcuec10AdKhFm8HgahcNKE565IctHd1x2rYqY5pNqH01szv2E9GRIZOp
         eMjw==
X-Forwarded-Encrypted: i=1; AHgh+Roqqg3hz24VgsbhzuZ7x1tYSb4iYlRuRoMjp30zX3E7aGoAhsc4WZQ5udNdzr6hoHxSdQdbZhVFvT3A2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk8hqC7LY/mw/H9la3xJKTIG4NJjDqtFIQC4RctJbRCeSXzZC
	5/uz3GfAP5OVKQ8RpkzjLcj+gqbxkBqi89Stm0INRXGgWwTWBYFCKMgTY4Q/pHoJK62LmzvXcCW
	2IioBlDTOryy0pzclrE32YVElpHXFs/qsNhz2uQWahA==
X-Gm-Gg: AR+sD13EM+ees7l4tOzFj/G/nozhV4GWVNKG18hX4xtcF9pTOUETdC6vw8zmWDMH9jK
	v+zxTC8F9ErIQEJQv4NrTaZls//fkVjmH1oQsNlCUMeeXj0lnFiT4N1oSAjtQgmeYJSWE6dCOeD
	hVou0qnH/T66rdTvizcRZ8rmDDP5+//uHDXBCg8LyLKp1cOratFbF9nL5pMFp/osc9MYzJRrlRA
	bbL7tFBCOuOJrPcVcPSU9YBThh/Lj6542Upl9Cj27m2oiY37PNFIalQiPJCwbAeNdbISYS5pFdd
	3i5S2NN2KscFq2eKX1Y=
X-Received: by 2002:a05:6512:4891:b0:5b0:1959:d877 with SMTP id
 2adb3069b0e04-5b28f9aa443mr2179417e87.41.1784629697396; Tue, 21 Jul 2026
 03:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521232956.553287-1-atomlin@atomlin.com> <20260521232956.553287-6-atomlin@atomlin.com>
In-Reply-To: <20260521232956.553287-6-atomlin@atomlin.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 21 Jul 2026 12:28:04 +0200
X-Gm-Features: AUfX_mzCRJLCQLZMCo1gdm4siRIiMkxb-RfOHU_q0bS9uhQEONh81utt5tGAw_A
Message-ID: <CAAofZF6xLwOdGj1mPA7ayhnAfSFBhBv7kYOfgbyDY0dQVMz65g@mail.gmail.com>
Subject: Re: [PATCH v15 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, 
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com, hare@suse.de, 
	kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, 
	sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, 
	nick.lange@gmail.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 22, 2026 at 1:30=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
> + void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
> [..]
> +       /*
> +        * Snapshot online CPUs to prevent TOCTOU races between the
> +        * mapping phase and the validation phase.
> +        */
> +       cpumask_copy(online_mask, cpu_online_mask);

I'm wondering: should this code be protected somehow, maybe directly
by the caller (eg w/ cpus_read_lock()) to avoid a CPU going offline eg
after the copy?
This invalidates the copy because a CPU set there might have gone
offline, and the blk code would then still use that CPU.

Does that make sense or it is not the case?

Thanks!

--=20

Marco Crivellari

SUSE Labs
