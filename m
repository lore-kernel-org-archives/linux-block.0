Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85571A32;
	Sun,  4 May 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379247; cv=none; b=Pd2x1Ym3dezd9gYLTPZtfIkM+OOAMakFlLblrc0gbmHybjqhESKsjLBELvvE6gNGduK5EH2UWUL2LYewLMI5ENMcz+ys0xO6FQy7FO0wnTuigJ0/KRVHjnZD/aX+hGBXTxyacOtRmeLkgK4i76RsI7PPa+2bMpU2vlRto6WMFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379247; c=relaxed/simple;
	bh=Slh3CPtxZdQkCpRtkRRBiUTgSiG+PRKZ7lTazFXIyxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIx0i0INr63ngRKkRKHGKjlsBZXDGipXI0nYC6HZPg7GykZqrWziti0/KjwbnHL/89TjtnUdRc/vy97oOnaNqgcmuPdB/mOQlaBx3z/j6SxMb7vM+kNshBnblweJTiDm70vEhcSOAolMhx6OLezaXwRY+E55E40lOp1FbtgWmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MSbc6MFd; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MSbc6MFd"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZrBJ50zbCzlgqTw;
	Sun,  4 May 2025 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1746379235; x=1748971236; bh=Slh3CPtxZdQkCpRtkRRBiUTg
	SiG+PRKZ7lTazFXIyxs=; b=MSbc6MFdbmGU1BAmGBCAzUSSmesgSRKoHjcKbzq2
	EyodiLWTgLEfdlMB2iTw6Xm4cRmKAjmxbu2A7ZKwV/FA+rCD/etIN/UYZXCOT1Eg
	k+EKrQmIkUbbf0uMdmvy3g7wVmTNuYHGVu78ms35YxDo8NhZdThMfZNVO0agQwdd
	k5XCt2LLI13aX9b9m9DB7LSF0ITT2LH1Pc0vutxaP0nPOkM5J4SrEAVHhbBhv73o
	vdNSGoF5q0d3rFbJFZeNDbzEKF1qSpBeyqhbSI6buWjvx4wWqcMHxEZJTjOOYp3p
	bLjz8inKSBoICyu6fjrfes8K71AxfbiiNhKdgiQEvNO0Gw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id A6pFCqPjChMx; Sun,  4 May 2025 17:20:35 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZrBHy43L3zlgqTt;
	Sun,  4 May 2025 17:20:28 +0000 (UTC)
Message-ID: <ffea92dc-1e9d-4281-bdc2-04f391840ccd@acm.org>
Date: Sun, 4 May 2025 10:20:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rnbd: add .release to rnbd_dev_ktype
To: Jinpu Wang <jinpu.wang@ionos.com>, Salah Triki <salah.triki@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aA5Rzse_xM5JWjgg@pc>
 <CAMGffEnT+C2xSNXuEFzGm9Yh_f=sRVrPsFO=tSasLMWciqKPhw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMGffEnT+C2xSNXuEFzGm9Yh_f=sRVrPsFO=tSasLMWciqKPhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/25 2:58 AM, Jinpu Wang wrote:
> Nacked.

Instead of NAK-ing this patch, please rework the rnbd driver such that
rnbd_dev_ktype has a .release method and the driver keeps working fine.

Bart.
