Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22877313550;
	Tue,  5 May 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995737; cv=none; b=qiZZ1lHn4VHyBYZcJTYzTt/cjA0ra9TMkBNOk3BkH088RYkUExC/DsDJ1iiRSFKd6gTjIAV4YPZrTit9sJqX0y9s2KTvLOh48waw8KqiZAvJ7f/Y8B1R5xHr+IXt9NiVz7zeUyVhNzt4zq3Bjj7ftT26LgmurI/1eW7B3JCiI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995737; c=relaxed/simple;
	bh=BzcEHEyglD+WwAtGnnN4RinbaNx/5QoNqm9JCn3CYno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHDOEJVuDiHoBTq4eL9q235kmj/GRilT1s9e+K9XgDG+kOD85wpqMkpeRT9+kL7/3blcx7/2ECymGOhuDytw5BaWNEzgAc76ZmLQd5yUoN/ph50ACKfknIYhfOIJwbIhRpKHXJ8oQ8y220Ex1xLt7rVpFpJ92aq9QvstSeP8IFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vwVl88ik; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vwVl88ik"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g92ng3wkkz1XM6JP;
	Tue,  5 May 2026 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777995728; x=1780587729; bh=q1qNYl6x7rCJ4Lu/FnvPoVV1
	JRQuZdv0mQEcO93DffE=; b=vwVl88ik6UpR9sfpl1/c13zyBCBGhV8CY1Qgh7Gu
	y6af7E02G90xWkV5OOuNILuDXUrRP7mKyKf9u4Lp5efJs4vtsqPTm/u406JSZYM6
	4XVVK+6n0BbHYEsyh/fyKWiaEjcyB3lQsMxKEwue4+NKKm+HPp1zY/kozAY6iuMn
	8iBw54sX5qH26mHFiLNBBNbB2NA3g5HQCEV9dxfzw1M1s2eh8Mn9D1O33O40OPgt
	axxIhHWapQxweSDFnaQLROIoDO58YZ4UdxaTZt86CcvzIsTcH9ep94NSc09p+vcP
	PsGtoIGxCXnSBXFFP0KDoGNSn3y/O+6JDEnSIrODi4G84A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EX2hhIESClJK; Tue,  5 May 2026 15:42:08 +0000 (UTC)
Received: from [10.211.9.52] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g92nM4f6Jz1XM5kD;
	Tue,  5 May 2026 15:41:58 +0000 (UTC)
Message-ID: <7c811a44-6d7e-499c-8203-90a256984912@acm.org>
Date: Tue, 5 May 2026 17:41:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 linux-block@vger.kernel.org, axboe@kernel.dk
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 ming.lei@redhat.com, muchun.song@linux.dev, mkhalfella@purestorage.com,
 chris.friesen@windriver.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
 stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260303073744.20585-1-ionut.nechita@windriver.com>
 <20260303073744.20585-2-ionut.nechita@windriver.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260303073744.20585-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 8:37 AM, Ionut Nechita (Wind River) wrote:
> +	/*
> +	 * Ensure the store to quiesce_depth is visible before any
> +	 * subsequent loads in blk_mq_run_hw_queue().
> +	 */
This comment does not make sense to me. How could there be a dependency
of blk_mq_run_hw_queue() on *loads* that happen in 
blk_mq_quiesce_queue_nowait() after atomic_inc(&q->quiesce_depth)?

Bart.
