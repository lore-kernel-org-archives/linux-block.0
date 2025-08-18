Received: from mail50.out.titan.email (mail50.out.titan.email [44.199.128.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76F3218C1
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.199.128.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532377; cv=none; b=T8WpAOFDua0Dd0YjFf2GEGYDbXKQnalmHOkdwcJ2hmOVVYAEzNrm3WuUvOtcrCw9xkEas62+pAiIOzmXmpCXeIgzensUMuq4/ii0UcfinhkzePQQnbjpre0nq8IFiBVbQNj9/5fw/IWIqdiNf13nScGApov2zBTQ4qoAXG+xeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532377; c=relaxed/simple;
	bh=V9M9wMxPnlfMdOoxvaWhPt6Jp5GiXrncfe43UPOqPSg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cPq3PzKDi158CBJX1Z+2J9KPNOiTWCd28Akw0VeWlNPRpt9vwuUdzJZp6rCbETbxJhZQD1s6c9Cds3ItpkqAFJJsK7ePRa05Ur7fb97LL0YTfU7PveD5abULjif7sFRVxRvl/zPzFK5h8bxqLYznxznss71GrkkE7rpINZwc6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=WJkBrm8P; arc=none smtp.client-ip=44.199.128.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="WJkBrm8P"
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 751EFE0003;
	Mon, 18 Aug 2025 15:37:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=YFNeV2hpG32/Mt0T1WCtgG5lavQDl4NnNdFXE/YjiwE=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:subject:from:in-reply-to:message-id:date:cc:references:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1755531434; v=1;
	b=WJkBrm8PNQFMlxvneGicJ/3B8k6+9UQlSCTcmY5edLxJQ1xywItF7fWa60Egz1363gVf1vcL
	2565AxYY6FwuX+wmjanlfAeafFv8VYlhtfVdx7xu0hObWTEsCCbuSmQRZ5Xnpu2rPiLfvlZo06R
	woxreejFkVs2qrg0MzRaUYZc=
Received: from smtpclient.apple (tk2-230-24811.vs.sakura.ne.jp [160.16.109.65])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 97E67E00AD;
	Mon, 18 Aug 2025 15:37:12 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] md: split bio by io_opt size in md_submit_bio()
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <64f293d2-d824-44bd-a087-75a394576776@oracle.com>
Date: Mon, 18 Aug 2025 23:36:59 +0800
Cc: colyli@kernel.org,
 linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org,
 yukuai3@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <87FC6945-B66D-4950-BB76-D1676AC00E78@coly.li>
References: <20250817152645.7115-1-colyli@kernel.org>
 <20250817152645.7115-2-colyli@kernel.org>
 <8b627eed-331c-4ce5-b095-e682bbf8ebe7@oracle.com>
 <6DA25F37-26B3-4912-90A3-346CFD9A6EEA@coly.li>
 <64f293d2-d824-44bd-a087-75a394576776@oracle.com>
To: John Garry <john.g.garry@oracle.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1755531434327322197.32108.8490670035783708505@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=HMc5Fptv c=1 sm=1 tr=0 ts=68a348aa
	a=peXjpEhgHtYhbNWIf7X81A==:117 a=peXjpEhgHtYhbNWIf7X81A==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=yPCof4ZbAAAA:8
	a=mceLpxf-RtnszdjpyGgA:9 a=QEXdDO2ut3YA:10



> 2025=E5=B9=B48=E6=9C=8818=E6=97=A5 20:20=EF=BC=8CJohn Garry =
<john.g.garry@oracle.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 18/08/2025 11:26, Coly Li wrote:
>>>> static struct bio *bio_split_by_io_opt(struct bio *bio)
>>>> +{
>>>> + sector_t io_opt_sectors, start, offset;
>>>> + struct queue_limits lim;
>>>> + struct mddev *mddev;
>>>> + struct bio *split;
>>>> + int level;
>>>> +
>>>> + mddev =3D bio->bi_bdev->bd_disk->private_data;
>>>> + level =3D mddev->level;
>>>> +
>>>> + /* Only handle read456 read/write requests */
>>>> + if (level =3D=3D 1 || level =3D=3D 10 || level =3D=3D 0 || level =
=3D=3D LEVEL_LINEAR ||
>>>> +     (bio_op(bio) !=3D REQ_OP_READ && bio_op(bio) !=3D =
REQ_OP_WRITE))
>>>> + return bio_split_to_limits(bio);
>>> this should be taken outside this function, as we are not splitting =
to io_opt here
>>>=20
>> It is not split to io_opt, it is split to max_hw_sectors. And the =
value of max_hw_sectors is aligned to io_opt.
>=20
> Where is alignment of max_hw_sectors and io_opt enforced? raid1 does =
not even explicitly set max_hw_sectors or io_opt for the top device. I =
also note that raid10 does not set max_hw_sectors, which I doubt is =
proper. And md-linear does not set io_opt AFAICS.
>=20

At this moment, it is only for raid4,5,6, which have XOR parity blocks =
involved in.


>>>> +
>>>> + /* In case raid456 chunk size is too large */
>>>> + lim =3D mddev->gendisk->queue->limits;
>>>> + io_opt_sectors =3D lim.io_opt >> SECTOR_SHIFT;
>>>> + if (unlikely(io_opt_sectors > lim.max_hw_sectors))
>>>> + return bio_split_to_limits(bio);
>>>> +
>>>> + /* Small request, no need to split */
>>>> + if (bio_sectors(bio) <=3D io_opt_sectors)
>>>> + return bio;
>>> According to 1, above, we should split this if =
bio->bi_iter.bi_sector is not aligned, yet we possibly don't here
>>>=20
>> The split is only for performance, for too small bio, split or not =
doesn=E2=80=99t matter obviously for performance.
> Then it should be part of the documented rules in the commit message.

Yes, as I did in the commit log and code.

Thanks.

Coly Li

