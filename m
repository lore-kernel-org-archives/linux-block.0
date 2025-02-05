Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8791FCF47
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777968; cv=none; b=GmTzmkLZ0dBw1kdWPwfflYXlR6QnlAJ3QijSwXAn+7BWac2cDm2b7rudvjOFrk5vrMjNTwyXYw5UV1+zF4NOl2q+x7LRCv2ydN2/szG1FrhWQ2Vll6hJpIPoVvn23VfQstVT3IOgj5kYFfsABTj8x0i6tBUpOxdKd611xKT8zYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777968; c=relaxed/simple;
	bh=9A/NebC49Ldx/PEcwzFO1pdXPeg0ZkxYIP1V/bqZyks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzmnBVJD88iue3IpgmVtV3RIWcny1VU/d24UF9+y9le4EW1zDYkU3auJRBElN2LrNJm9Qj6AvLy4tOgRjhFTb0rR9RinpQg/mbCCymKSt/Wel1IahuyvIwsaV1kKqqRCrhwSBfzYdwPEezAE1pp8oCJhrDkuuW2T/Ykv8IgHYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=drs7/RAw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="drs7/RAw"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Yp76f4SLVz6CmM6c;
	Wed,  5 Feb 2025 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738777800; x=1741369801; bh=9A/NebC49Ldx/PEcwzFO1pdX
	Peg0ZkxYIP1V/bqZyks=; b=drs7/RAw5/fHZrchiOzdtO17SiasdBVVn9mgzA9v
	0y+fEQ6rJ9v1NNjkLHs1RLAN2YpXbGgaq6hjkSas9DAjVCpMGr7zDMoaNGlPLcvh
	9jpqA5RtE7VAQJmCAPZdzto4/jekRBR2l+3tjdRht+Z+YoGDcnuU74ck55gw93ao
	Hl+r7VqO97lqnXBxc0SEoW6IRb1VeTVgb8KczQd5HJoAuiHNu7S345jbpuvvluPu
	e9nqWNXbfjFknS1TZ+4RDqIQNjce/QcnI1dNA8MOOzm/VXswyzDj5+90iAzRgfAt
	DvUcNUbHx8T/pyeRK2Lf+kBrBuUMZQUWITVnuZSQuxebWQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x30_vqYbnbXK; Wed,  5 Feb 2025 17:50:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Yp76b2jdSz6CmM6N;
	Wed,  5 Feb 2025 17:49:58 +0000 (UTC)
Message-ID: <04255333-fed3-4f96-9c20-9ad181c4a85b@acm.org>
Date: Wed, 5 Feb 2025 09:49:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250205150429.665052-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250205150429.665052-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 7:04 AM, Nilay Shroff wrote:
> So if the scsi_transport_srp module is loaded and in use then skip
> running srp/* tests.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
