Received: from mail84.out.titan.email (mail84.out.titan.email [3.216.99.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F228DF1F
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668611; cv=none; b=C1OZ+cL+7z9bS3x+34To3doBr4utTxTLKjgj8yvFTVUMc8Xj+2IOBTnpgyjgBmPLkIfA1jsIp8AxzB8ulDjhi01flWM8uImMw8ipmF8JA7Ux2LQ8PwEIhion02Icx+b7tKr4Xff1KMV7enCRSVsbeD0mBzhNgCu9QxJ8mB6obnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668611; c=relaxed/simple;
	bh=yPaFAfi6o9fNhx+WsJjiCWrWhmiq8TfkTONVAYvEUh8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k9ZURLGLVHS3EuJVZGdeTWOL72eLG3MjMCjsWY+b/q84BJUx4SG9I46V9zvOlByXlopX9t/RCX2OAWp7JtfnW0FenQYZEHx6JXgTZQsdaJPgKkz6E8pxIYeyYob8+BmqVedBG5jJoSDE/RwNd60e8p3Oobm52kntlUlXANq5yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=FJe6yYjG; arc=none smtp.client-ip=3.216.99.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="FJe6yYjG"
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id EF52AE0055;
	Wed, 16 Jul 2025 12:23:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=h8zYSLTyaeNZISXLAZ+/7v9ee3P1U2k3cxwdMkOjCpo=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:from:date:message-id:in-reply-to:references:subject:cc:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752668608; v=1;
	b=FJe6yYjG+9OETmH23H/65tgl5c/U31vdl3uIme6th+FND+m0PoV3VSzoGm8qzdkHmvA9hWO3
	4338LXriIXLwzHfmP+72zvF7GNpKM7J7yoIUHXXGtoTTBE5imH9NBXDETgT54qX/1seNAcI0yNw
	u6WH0jh7b4dS8TbHQVvlnGtQ=
Received: from smtpclient.apple (ns3036696.ip-164-132-201.eu [164.132.201.48])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id A7C71E0086;
	Wed, 16 Jul 2025 12:23:25 +0000 (UTC)
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
In-Reply-To: <20250716121745.GA2700@lst.de>
Date: Wed, 16 Jul 2025 20:23:13 +0800
Cc: Coly Li <colyli@kernel.org>,
 linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org,
 Yu Kuai <yukuai3@huawei.com>,
 Xiao Ni <xni@redhat.com>,
 Hannes Reinecke <hare@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <109C6212-FE63-4FD2-ACC3-F64C44C7D227@coly.li>
References: <20250715180241.29731-1-colyli@kernel.org>
 <20250716113737.GA31369@lst.de>
 <437E98DD-7D64-49BF-9F2C-04CB0A142A88@coly.li>
 <20250716114121.GA32207@lst.de>
 <D12A8BDA-5C2B-4FA7-9C92-731BD321A611@coly.li>
 <20250716114533.GA32631@lst.de>
 <danlsghtalte7sku3vlfxkgngujgwzspanfayaxy4jfnk54jbf@yfvmr5plavmp>
 <20250716121449.GB2043@lst.de> <DE36C995-4014-44DC-A998-1C4FF9AFD7F9@coly.li>
 <20250716121745.GA2700@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752668608785422881.26132.3995369904563401195@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=LqZoymdc c=1 sm=1 tr=0 ts=687799c0
	a=cqlkUh1Psg5J4QAqX6BmHg==:117 a=cqlkUh1Psg5J4QAqX6BmHg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=vQm8URVHFMwqDAv770oA:9
	a=QEXdDO2ut3YA:10



> 2025=E5=B9=B47=E6=9C=8816=E6=97=A5 20:17=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jul 16, 2025 at 08:16:34PM +0800, Coly Li wrote:
>>=20
>>=20
>>> 2025=E5=B9=B47=E6=9C=8816=E6=97=A5 20:14=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Wed, Jul 16, 2025 at 08:10:33PM +0800, Coly Li wrote:
>>>> Just like hanlding discard requests, handling raid5 read/write bios =
should
>>>> try to split the large bio into opt_io_size aligned both *offset* =
and
>>>> *length*. If I understand correctly, bio_split_to_limits() doesn't =
handle
>>>> offset alignment for read5 read/write bios.
>>>=20
>>> Well, if you want offset alignment, set chunk_sectors.
>>>=20
>>=20
>> Do you mean setting max_hw_sectors as chunk_sectors?
>=20
> Setting both to the desired value (full stipe width).
>=20

Do you mean setting chunk_size as (chunk_size * data_disks)?  This is =
deadlock=E2=80=A6

If opt_io_size is (chunk_size * data_disks), setting new max_hw_sectors =
as rounddown(current max_hw_sectors, opt_io_size) is good idea.

Thanks.

Coly Li

