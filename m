Received: from mail42.out.titan.email (mail42.out.titan.email [209.209.25.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0282F0043
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667061; cv=none; b=lJmLF2/p0lPN5gZ1JfwCnfEVbWz/CSUraTpMrhjArz5I+uIW5jFjMwDgvFkjOdxY2vT37CDzhM977Kph7s7ciGL6EljCXfoVe4Fp17BSoL2pDJJF+dpU/6gdRDu/pXZ/QS8AQ1PkBrLkDLzhMrH1DsEA5Te4wnMcs816dtv7XW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667061; c=relaxed/simple;
	bh=3+VJMevxgFqhNHDpZE2wbABdDyYuLoP1V0Zj4jS5DAs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JugZS0FwFsjzBtWfq7iXjzE3yO7bMzPQ43J6/XQuV72WLqz/CvpaXKWNp+/NewgxLgOwwXeCdKmDrdW49FJrljYA7B4vjBfp7g0ctGxXmq1UaaW89+PVOfcye6NIG/RNnWEGS7cImGlD1NwBBHJxi0p0YTDPGBLuO0zrWoREpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=OBz2mL5n; arc=none smtp.client-ip=209.209.25.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="OBz2mL5n"
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 14135E007B;
	Wed, 16 Jul 2025 11:39:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=tB0d9qvNHtH3IsDuEuZm+SIgYBI3QUvRXUOD8BomEiE=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:references:from:date:cc:message-id:to:subject:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752665972; v=1;
	b=OBz2mL5nD0tMzXkxIgVBVHDbrwteD4eeUzjdc8BWX/JddGTDRiSszrpvhEVO6ylrmXRtok9j
	dZvszhG2RzxGzOFC0tuOXMZSbIhu8rFynRV/HIP2XncR5FfwfukLFqg1qS48p6CzC9k4qPCaRtO
	vchZla+nbbJ00nCNy48ySfOI=
Received: from smtpclient.apple (ns3036696.ip-164-132-201.eu [164.132.201.48])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 15CB4E003F;
	Wed, 16 Jul 2025 11:39:29 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC PATCH] md: split bio by io_opt size in md_submit_bio()
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <20250716113737.GA31369@lst.de>
Date: Wed, 16 Jul 2025 19:39:18 +0800
Cc: colyli@kernel.org,
 linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org,
 Yu Kuai <yukuai3@huawei.com>,
 Xiao Ni <xni@redhat.com>,
 Hannes Reinecke <hare@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <437E98DD-7D64-49BF-9F2C-04CB0A142A88@coly.li>
References: <20250715180241.29731-1-colyli@kernel.org>
 <20250716113737.GA31369@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752665972906227694.26132.2900403526860660937@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=OcdiDgTY c=1 sm=1 tr=0 ts=68778f74
	a=cqlkUh1Psg5J4QAqX6BmHg==:117 a=cqlkUh1Psg5J4QAqX6BmHg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=YOkcuq-kbnDDGABybXIA:9 a=QEXdDO2ut3YA:10



> 2025=E5=B9=B47=E6=9C=8816=E6=97=A5 19:37=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jul 16, 2025 at 02:02:41AM +0800, colyli@kernel.org wrote:
>> From: Coly Li <colyli@kernel.org>
>>=20
>> Currently in md_submit_bio() the incoming request bio is split by
>> bio_split_to_limits() which makes sure the bio won't exceed
>> max_hw_sectors of a specific raid level before senting into its
>> .make_request method.
>>=20
>> For raid level 4/5/6 such split method might be problematic and hurt
>> large read/write perforamnce. Because limits.max_hw_sectors are not
>> always aligned to limits.io_opt size, the split bio won't be full
>> stripes covered on all data disks, and will introduce extra read-in =
I/O.
>> Even the bio's bi_sector is aligned to limits.io_opt size and large
>> enough, the resulted split bio is not size-friendly to corresponding
>> raid456 level.
>=20
> So why don't you set a sane max_hw_sectors value instead of =
duplicating
> the splitting logic?

Can you explain a bit more detail?  In case I misunderstand you like I =
did with Kuai=E2=80=99s comments.

Thanks.

Coly Li


