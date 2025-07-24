Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D02D5423
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370363; cv=none; b=KCMU3T6Zj452LmQ9vUpjoHW575IYRVT8QDv9OC5v0+Azd+FfSuq+dV7ePUtC/gOs6knBkVLjhkAz6UyMgf4h8Altcp9BS5hSbu70/fMwavXTovEJJhw/qK09ckfENKTs5a067ueCmQgXaBt6ORTGdgbHyd74mfhKO50v039z6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370363; c=relaxed/simple;
	bh=I/hAoBnqUfC7CBKGLrmAnDUD4J6rUGlF5xsQyWwA6bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcG7tDcJrOQHj7/UK7BAR0+P30OetinFWqD9IyPovsxPfy8fIiCxDfoICZxSfzhps8vmIDPRQ3d/nOwQKQOiMqZc6x5fTvJIjM5Y/f6mJncNsYYza/Ru3tuwE1s3qKRrsFSY5jakUUq9t8FHGT15EQMPBs6YMHaOANIvxTaIwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SlayPdny; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SlayPdny"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bnvmn1m5Szm0yT6;
	Thu, 24 Jul 2025 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753370359; x=1755962360; bh=cvmbZOra27JmsZSpzaxRqfRv
	rpvuGq6JSpDcItrFzb0=; b=SlayPdnyEADyduAtHTyee3hHnnf10Xp2h46Fagj+
	J9wpqz1J6a/kz24AiX2bNysHgkV7hEfWEVZG3tQv1PtspS8CIzmcsEd+RQo9YWiC
	y/aHdDzTWKr3XRisk7ST3zCjBt+YF+snlrGgqgdGWRvpVPFyttDR6K9j0/Kw9EeN
	r4RbHM5TvuKPvFOpZh0J9j3sSLNn5+mSr+5L41KwLsBk6K7VrPA4PlRC9aqQw2/3
	VATHF3HJMYUnxjkntNmtb+hWn4fzS+4iPQmnwdKmXtybusOk3UT4EL/f33BLX1af
	LlwZoYyLgiffOZ/HXvvoEncbiq6Get3ydcqtEcDDAHytgQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DT7IR4KN4bet; Thu, 24 Jul 2025 15:19:19 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bnvmg1f9Zzm0yt5;
	Thu, 24 Jul 2025 15:19:14 +0000 (UTC)
Message-ID: <b595ae91-1fb3-404f-8633-7d18efc71fc4@acm.org>
Date: Thu, 24 Jul 2025 08:19:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: Hannes Reinecke <hare@suse.com>, John Garry <john.g.garry@oracle.com>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 dlemoal@kernel.org
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
 <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
 <2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/24/25 4:04 AM, Hannes Reinecke wrote:
> While there are no real checks on the physical blocksize (all what
> matters to the block layer is the logical blocksize) I can't really
> see how a device can have a physical blocksize which is _not_ a
> multiple of the logical blocksize.

 From SBC-5:

------------------------------------------------------------------------
Table 91 =E2=80=94 LOGICAL BLOCKS PER PHYSICAL BLOCK EXPONENT field

Code   Description
0      One or more physical blocks per logical block (a)
n > 0  2n logical blocks per physical block
a  The number of physical blocks per logical block is not reported.
------------------------------------------------------------------------

I think this means that the SCSI standards support physical blocks that
are smaller than the logical block size. However, as far as I know the
Linux kernel does not try to determine the physical block size in this
case. As one can see in drivers/scsi/sd.c LBPPBE =3D=3D 0 is treated as o=
ne
physical block per logical block:

	/* Logical blocks per physical block exponent */
	sdkp->physical_block_size =3D (1 << (buffer[13] & 0xf)) * sector_size;

Bart.
