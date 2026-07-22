Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD64399FA
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744342; cv=none; b=L88sXO1qq3pbDle6m/PtGGF9mK9PelPqiqVvOcQCAm/0jOJmaNNRUhpFRo5sAL1z7IVQ+kYmYcIVVZQR1D9+qy7vqWD+YD7kncYOBSx1jh4+eALihsusWJEjCXrRKijrklEnkw/3ygaKOS7g1UKdCPHd4VrSdAfvpAw0cDTLMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744342; c=relaxed/simple;
	bh=cBKW2nxxsgxUJF1CPjmbYvXgy2EbkC9jwn9KlyNOCck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sU0P9zfoCeFT3RQ6+gktc5d63z61SZisclLxF7IMJB9o81QNociBYjlvA0hbXmwy36omES3CXCe6jru+3Wq+mJZDFCCpptJxo59ZlP4DEXPVZnsDeKyZ1yH2mBxRy1fLPyFmAQn/qJ2FTmp0aPSFAyX3WGSZwsvPE1JUIuH/IxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nQ/JfBDg; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nQ/JfBDg"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h52ZV6zWNzlfwgD;
	Wed, 22 Jul 2026 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784744336; x=1787336337; bh=cBKW2nxxsgxUJF1CPjmbYvXg
	y2EbkC9jwn9KlyNOCck=; b=nQ/JfBDgxo6/B7otepejqR3rmk/n4W3ZCLB3jlXW
	r9NTNgNy6WcQ+4WTfr9G4av2JAwnmB4a0cvksNDcKMwSxTM/HjZnOyV/byrhYfQ2
	dBEHW75TTpNVE4w/LbepEamizGMNrAW+klNGs/rTfd+ugksqTKLtx/Xo/DmPIR4o
	dfpPNU9PGB40N4FkPsu14J41k8ezJ1TBqGialQeO06TN9sjkXB9IN57T5d+Ni8xw
	K21Iw3KYcesbJPZeYYNXxIYY6usyfWXEoGyjWsMZeQ6OaEc6M1HRv67mmQ08wdBM
	W6RXrxFIj+24M8lf5W4NQ5Zpd/bzLXbteusVrkG8RO11xw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ly9kNRveQz13; Wed, 22 Jul 2026 18:18:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h52ZR2NHHzlfwgC;
	Wed, 22 Jul 2026 18:18:55 +0000 (UTC)
Message-ID: <0f813803-2334-4e9b-8744-4440d13089ef@acm.org>
Date: Wed, 22 Jul 2026 11:18:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] drbd: Enable lock context analysis
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Marco Elver <elver@google.com>
References: <cover.1783632330.git.bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cover.1783632330.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/9/26 2:35 PM, Bart Van Assche wrote:
> This patch series enables compile-time lock context analysis for DRBD. =
The goal
> of this series is to allow the compiler to statically verify that locks=
 are
> acquired and released correctly, helping to prevent deadlocks and race
> conditions. This version addresses feedback received on the v1 series, =
improves
> the annotations, and refactors some conditional locking paths to use th=
e modern
> cleanup.h guard infrastructure.

Christoph B=C3=B6hmwalder, are you the right person to help with reviewin=
g
this patch series?

Thanks,

Bart.
