Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073E1D5160
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763728138; cv=none; b=jle3EJRiwvKc4p/AdyXRh03NvJrgxq4LkbCoAg4bSO9xJmpb6j6LjWlkbkQYxTF0VL4R5+isJip5rwnPJL5QbFqlR5VePDDqRB8A/lEQy3oHH/e5Pajzrja3qHlwEy1maxJNuSc8b5QWcVIAO5di2mdNYbu5D+89HWjLqKRiXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763728138; c=relaxed/simple;
	bh=7+X1TkiRBs2rYXrvwnRamg0PGczo9rUONGNaLGCzprg=;
	h=Content-Type:Subject:Message-Id:Mime-Version:In-Reply-To:
	 References:To:From:Date; b=T1B3NOKJzs9AkieWwdjQtWaov4nlFHak5BCj8jlJhSpf1O26adPQHM22ZNBUGE/XEkyDv720uzkIUYKuO2TW9hFL0o+NeV0A4plsL0Gy9+vxnPnm554PNBqjtRTwtl4fK9rCsPhZpL2VNHpI0OZi/PhVdTPSqa7FA+EMu5pNTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=dLo0Qt11; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="dLo0Qt11"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763728121;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=7+X1TkiRBs2rYXrvwnRamg0PGczo9rUONGNaLGCzprg=;
 b=dLo0Qt11yBaEBJtvgUjt9t7ujnEozF31k6ZvccJPLcTCpuHrmCzclsMaSxEMDFNbERQYQf
 k4ByiHIxHGxBPpSRVBDRw4ctPvZIwi8ZcRM4LLOw0eGdpnZcEyst7b1EKWZekAR8RFU1Qd
 PDLkbSK0W2umCOn7kfCW898MgI4zwAG0wrmLoy2luXgWgVu1oidGG216lHN6oeYqAcqBCl
 NQO2NF6sNJDsweyzz0bJyGCCuEkaNe/6DGbz0SvqcJVSniSh1StGbetd2bLLPmWTnpaUcg
 m0av67iqgjlm4x8t+57M/PC+znVyyjN9oFv0h86QT4kLmuaLgKKoDyMCYIms8g==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] mq-deadline: covert to use request_queue->async_depth
Message-Id: <1c2e8761-5344-4300-a2bf-9e80b3983968@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <c93e88cd-ade4-4264-8d80-a6669e361c32@suse.de>
Reply-To: yukuai@fnnas.com
References: <20251121052901.1341976-1-yukuai@fnnas.com> <20251121052901.1341976-7-yukuai@fnnas.com> <c93e88cd-ade4-4264-8d80-a6669e361c32@suse.de>
X-Lms-Return-Path: <lba+269205af7+7c334d+vger.kernel.org+yukuai@fnnas.com>
To: "Hannes Reinecke" <hare@suse.de>, <axboe@kernel.dk>, 
	<nilay@linux.ibm.com>, <bvanassche@acm.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Organization: fnnas
Date: Fri, 21 Nov 2025 20:28:36 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Fri, 21 Nov 2025 20:28:38 +0800

Hi,

=E5=9C=A8 2025/11/21 15:18, Hannes Reinecke =E5=86=99=E9=81=93:
> ... and this is now the opposite. We are removing an existing attribute
> (raising questions about userland ABI stability).
> Wouldn't it be better to use the generic infrastructure (ie having a
> per-request queue async_depth variable), but keep the per-elevator
> sysfs attributes (which then just would display the per-queue variable).
>
The problem is we can't make this api inside elevator writable as it
used to be, and if user do use this, they will probably write it to
limit async requests.

And I feel it will be acceptable for this kind of user api compatibility,
replace it elsewhere with the same functionality when kernel version is
updated.

> That way we won't break userland and get around the awkward issue
> of presenting a dummy attribute when no elevator is loaded.=20

--=20
Thanks,
Kuai
