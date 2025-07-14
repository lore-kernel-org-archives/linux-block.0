Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D78266B41
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507347; cv=none; b=o5Gw8rNJASXYlEtrFnDT9kkEbSQDuyhE0GJNFGedoe3ud4ggU3dhzF7B86dfPRVzyTKS31b0Qv2P7fQnXk247eXOCV5+9vkDj0u4WQ2WrpBTX9HspSQrv2mkYN8MfNZ93Rwnr1FPm+tqZ7Xopuojm8Dkkeo0L2yr3NKZM3LxxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507347; c=relaxed/simple;
	bh=yrFDLwdINBK7UqcTuH68qV4q+0Us9kwhAGLRBRoNYVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+En7X1TnrvQ+HFp4DoENldh9KurdS/1NT1TvxTg0JnmwgGNLw/0yImfM36aO0I4eutZ4BS1KAfM60n2MvaHFt7KeEJnwcN8iS7BUNZdeqR66IEQW6u7YIHuY1F9Nnk+jKFd0QoMV1Pzdv5lcZ6m9Ra0LZvm2slDDYjVGYkKwVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k2UBnlMW; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k2UBnlMW"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bgmcC4q0Zzm0yt0;
	Mon, 14 Jul 2025 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752507338; x=1755099339; bh=S/4KNFMuCoE2OVhNAdnufJs0
	sHYkdft37EreiVcSm58=; b=k2UBnlMWyFSLa7XdbdmkkNzcDzy3X+eQsZOhxIgi
	iDyGXOC20AAnl14NPSFPmb7m2eB4OtMs4yJFDj2p8gfNfYFyDX4awMZq270qUerN
	u4FCWcUS9+AumTrlnznkkfGrkG7EP73HLsTbui9Gp4WNj5GzbsZrSMjyBbCVVLwz
	+SFL1BY26FTslZhCzSOluD3/Y1H+9odAzzEB2kOTiKuZ7ky5YxG1a6p/WonfMsb/
	aqsVAbm+cXTLdY3lOLa6fXCUcoC6cO9J0VwolFAsAhvhdfGJrU/0mrIUArnkkf/9
	tL9MOa3xKfNMEPhEuPIqG/mkN99PSRs7jHAcD96hEleoUQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OgYQ-g36Q2Ap; Mon, 14 Jul 2025 15:35:38 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bgmc70twLzm0yMP;
	Mon, 14 Jul 2025 15:35:34 +0000 (UTC)
Message-ID: <52c19699-cead-41b7-a5c5-517f412bcbec@acm.org>
Date: Mon, 14 Jul 2025 08:35:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: Split
 blk_crypto_fallback_split_bio_if_needed()
To: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Eric Biggers <ebiggers@kernel.org>
References: <20250711171853.68596-1-bvanassche@acm.org>
 <20250711171853.68596-2-bvanassche@acm.org>
 <a276765d-665d-49af-9776-d06e88c766cd@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a276765d-665d-49af-9776-d06e88c766cd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/14/25 6:48 AM, John Garry wrote:
> since you are touching this code:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0bio_for_each_segment(bv, bio, iter) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_sectors +=3D bv.bv_len =
>> SECTOR_SHIFT;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (++i =3D=3D BIO_MAX_VECS=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>  =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> if efficiency is a concern, then it seems better to keep the running=20
> total in bytes and then >> SECTOR_SHIFT
Anyone who cares about efficiency should support encryption in hardware
instead of using the software fallback code. As far as I know, on
Android phones, the crypto fallback code is only used during hardware
bringup and not on any devices that are shipped to consumers.

Thanks,

Bart.
