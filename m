Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C77347B;
	Tue, 16 Jul 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163696; cv=none; b=sxpHsGgbR8quxb4nnZ/oSgyLG+BZJZNSfcJWSWP/mFB/6bAY4W40DbFNqSms2hWIsHptHWTeb3ZHOWAadX8LshkkOd+a3c+X/fAen0+yetFpSpLQokRZOzKl3KE5ONNK/XWxkivIZGAM2XynjhP3+2i/lplMipGDmVdyt6ynWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163696; c=relaxed/simple;
	bh=p1oSi7GhHZawFFJfsYNjDcinSoL8+zNLxZguvaD5P9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m0JqBIu4yUmCnBFN+wP+B5y0mLwjaZmBu88p4O+wPgnpBr/StPUZcEr2yktzPO82LPwDXE0vkbcvzbgvPiArFKM/8JS9q5WQkZcCp4X53X9rN8LRjcqCzUC8DroSm/wmIG1Vl1/siuGEoCvfmZOID1VDmOfbmOB2c3bOPbytPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XSuA5KCd; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XSuA5KCd"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WNs1h4bP6zlgT1K;
	Tue, 16 Jul 2024 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721163686; x=1723755687; bh=p1oSi7GhHZawFFJfsYNjDcin
	SoL8+zNLxZguvaD5P9w=; b=XSuA5KCdWxHgnMzF13zMqXCtWyaAAKATXNEgL07E
	zJJBexvSrPll74Tw+GmlTXeMQcSBms9RgQpczNMRbROaXdcrT64ar3myHUvOFsuk
	MkSudzITzXuKCStpuZdJ9XSXxkNujEOKT6cTxP2BokiRlZMWzFsVexnPK+hgVBp4
	j9PESTdED+vp4t0NIwCXV3DKvuaJLSjx2stOcDjDbqOOQcCzzU7OTsy1E2+0UmsR
	KA6XSKsn/CCtdPL3aIphe9T39ANP12OjSuvAdRWjpdTFYgVbJWo0aAL1DOVtOFRt
	MSn7qXNNPzr+O5ldU3MV88u95SOx8X8EqA47Jkk6U7fgfg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pumGTdEg67eq; Tue, 16 Jul 2024 21:01:26 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WNs1c5kkYzlgT1H;
	Tue, 16 Jul 2024 21:01:24 +0000 (UTC)
Message-ID: <be0587f8-f4ea-4e37-b87e-569b26f10536@acm.org>
Date: Tue, 16 Jul 2024 14:01:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>, Ming Lei <ming.lei@redhat.com>,
 Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240716082644.659566-1-yang.yang@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240716082644.659566-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 1:26 AM, Yang Yang wrote:
> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
