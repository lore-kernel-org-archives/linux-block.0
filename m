Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306023E320
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750575; cv=pass; b=AND7EEmWzaaRuC3+7TC5PFlEABNI+5NVkEZ+F4LirqH6n24s3oCHKdsjSx7/BwF7L/zWBRpbpYgmULRBQTZu5KPKow/lB8L9Eb1DJ3uD1csDNH7zcC6D6qcQnn7e6qWxc6D2Jih3ZdW7W5sIiZuiwaLa0+ZOeDclbXlqyDjQU8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750575; c=relaxed/simple;
	bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koKnGsqR+S2uf0d4UwGXZfUsbGkTYR/7j8t+2LFaPo9FgxucSj6+GKaiDJJv3BuxPIAftT2ehLAVQjCAQfJQ/y1xcs4Eh+oCuP16qJFIrUH6p/BAFDC9xXvPIW/AYBGY2tckt+uV8LSAGHHUir7jTiP7FpSDSu8jDykfXG4CpSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=fVqSFWa8; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="fVqSFWa8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso3400499a91.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 13:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784750574; cv=none;
        d=google.com; s=arc-20260327;
        b=NVYQmCUl0t0+5sR7XsfMFKO5TTD5TCqxje4Z6iQqaJJi6K/dp5CJcqNpoZGPMZz8SF
         jDUSG2SDvmAo+mos7AV1nnzRzgoTuPEGtEnbqdExc0/6+/sfwjwyzMwZMzT0iXTzUkgl
         iNacXTkWWQNXbcoJyZuHTl63yVSRGVT9Y6sjEIz8WDJ97hKoN+fiXpYbPO9LGoWPL0Bz
         4iO62dMfF4J3+k8Wol0U37GLC48OOXbTo8VzwIyLwUMraPI19eUhoQHpaur4Hjy9rS0N
         aOe2J3rPy+788i4duNpCH4uh48S5ql/72T/kvpA3Mhln9eG6ttFFoM01DQys/pKq5kD9
         Gw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        fh=puOI87+GkbfKdPRGddnU5l2LqtouvuVlroiSjzs8kt4=;
        b=MjR+VRdiQ92HgQmW+31QdOZy6qbCrz/IyHz1IP/Bsb6W3nmLItL3aOC3b9Cu7tlwyU
         mTrhtROcEe118NMWI4z4/6PzFdio3n/SbwWWLqchBUdel6/gHGAAr6jBtH6fQo4IaskB
         u0CpMTlBMemXsmqyngfofsRlVg42KZCuM4cssSlFCmD0CkJ52/Grd4zsrvbXPikAQ3+o
         zla2bMUnod3OXZMMOckaxCW+Y2OHKOxEmIAyjh4ku7YK3gg5Ez54Iuxz29Bdf13hVASI
         3TkGyirlWQn9buD0qZcrz3t9Csgc8cg5dVe6iB3WlqS0b4B8UFBbidYY84Hy/p3ThhSZ
         Gqpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784750574; x=1785355374; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        b=fVqSFWa8CR4WGP03THynVHBaqIQzRh1S9Vl7PP6rUAN/da1I02prdrIB2JF1bbV1L1
         jHKk3cp7aLmOGxcp8y0PLLD7sZMFWl7a3pBjaCJUK3J71I5PCfocLuZiopCUpIXu+sxc
         BqX6U5InP7Xn9YJ65cTQQJTHDnd3tuWpL3HpGZCceJkKdASxEA+FTIYKo03SN1HBJfms
         CP8NrqIzfmwRbKqLu0AvRKYacacnwzJh1HiFGTm2kgQbtz7nNj1TKnS4wmGAaHF+t0tR
         7Y4IFgR2kWg/Ef3Ej0Tcvd5EeTM+FiGokqFpY+964NguHyTc9n5FCXVcfXaAzqJ1xbnf
         pRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750574; x=1785355374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        b=bsIaPxBPRhy/9QmPh+6eR0b+zr0vAGn90fhLEul9O676GmJxcb9tS1n/CBMSgwlCC3
         DbTOjBPi+kYAqZllbSdGcsqkHlCgS41utMOK++erAl97glefhk3CYCeM5p43/Ql6eQHo
         jqsclR1S6Kb5MhDJBiRPlU09Xfxq+aOIfkuZw9ibC1aPWoSzG5rYQk57pktd1ivL/Ah6
         EcsasRAQ/pZzJF15OvLc4Sg5+og3BWqFcKiHhv3O5utx9s06eFbdyeLhcCj2H1Tkv8aR
         d496iE3x3r+ppEQ4RpqujUCDI7cEZhmrqwPqHqDgEkILjoH2max5wEim0FxWjlTzZxVj
         t+oA==
X-Forwarded-Encrypted: i=1; AHgh+RoI5ENBzmt/TjQTciBGiMqOJFHMlfgFYzMVGMJgPGOYeWuoSye1Lq9TzWr0Lup0I46orsdhLxdSL+FCGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPn7MsBbnPDjRfuvRcKRnSBx3ZUWQJg62j3CF2Z85344aAaFil
	PkFFgI/vszikCUyvf8dRMItUyu9SXphafqDxWVXdxW0/HIMYxEsMgeTqpzl8CkWJ4zElJAZesoI
	vFxbtbtgucoLK+VjcTIeoxXtxR1iDNawiDT+OrBJa
X-Gm-Gg: AR+sD10tinjmYCTycRWH4jehl21xZxonU3BMlmFruOKDe/0SsSVk6wt/8/WM/GT2uJq
	pHrRzTtW1j5MRCpuweE0iaam1jbjiEbHrA2iFldDmxJBuhUB1reAJJynS4cYdgQRGX930LMkIdb
	QA/HJycYFypj15PPanBezdX0YW/uchFC5dd5tceCuw00ajomYEQ1vxOSJXup6PxDRTIxy/+wgcv
	N5hlRHalLeGjAf72GKzu2WypdWmb1+LyElhfzRmV4d3GVYTqsNHQyVz7N1pklyjakTVHZlQIbdz
	ydp6w4dqQd31bMjpu/R/BYWj45ptAW5yCoGcScHppEt5UIMkf5C1C4OSKSmzIk0GOhHYn/DwXxO
	jITU+Hh2j5shxd+6oDQPufTuQtA0aYIzTpYIFVSo=
X-Received: by 2002:a17:90b:2d10:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-38ec698af76mr113249a91.15.1784750573899; Wed, 22 Jul 2026
 13:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722185841.449934-1-mykola@meshstor.io> <20260722185841.449934-9-mykola@meshstor.io>
 <536428fd-9c23-45c3-be0a-5eaaf8f3939a@deltatee.com>
In-Reply-To: <536428fd-9c23-45c3-be0a-5eaaf8f3939a@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 22:02:41 +0200
X-Gm-Features: AUfX_my0hGYZfb89FIks6uN6jtY1SapXkJQfTk3Dh1NK0AxygDAcUpRTP3iNF6Y
Message-ID: <CAPzsNDscnb+fH0XZF3qBDgxkREmgh6F=rp0GO18Wy7gLc=4Ldw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I think it would be better to
> move the code more towards similarity with raid1 instead of diverging it
> further.

I'll move bio = r10_bio->devs[slot].bio; up into the declaration so
raid10 matches raid1 in v5.

Thank you!
