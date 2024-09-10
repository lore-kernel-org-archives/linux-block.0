Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790091A0AF1;
	Tue, 10 Sep 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987377; cv=none; b=lm/l09oGfft7Yf1iPoKXBqicArVw1c+cKIkRe5KQS6+NDO6MM3nI18vomRE7BL9ag/vjjghRGYnclEDP1GJKMR5cl4exM/z+0c1136jdzBHm4GOiJDjzqU9lV2ySDoYax2U2jZtslLqyJcw/ATJOIESQXZ1Yt53wO+jVoQON5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987377; c=relaxed/simple;
	bh=QASMGkEsSRO3GG4RNCrtw3i1K+JPiCBiSMSLWt79ni8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnUy1Q3Q2t5Kh39Ksx0E4lIahyABPse2gv9fLkPM8aKUAUMO4B1XZqIV1zihUApZHd+fRRIMPhrxgzl7kIWU/7uaGhGL6Ce1QRSZEgpp807dhxY82FOU580/S17yMHJk6lucrW8QINWJWBQK1xrKOPc1KOxr6WiIwFdQsPQPl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QH0m4UuJ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QH0m4UuJ"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X38wt6nPKz6ClY9D;
	Tue, 10 Sep 2024 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725987373; x=1728579374; bh=av8MBTYW2/cFVFhrt36tfaA8
	FJ1upg3KjEox21DoSCQ=; b=QH0m4UuJTRnLOjm7dhYXNYM/L4fceHeKlot2yT9R
	Gvq+Ptfa3aGvNc2dphcCAUY6uMvRSVtSWOUEzcTyih5KaYw7zGLwbUu3fMMug0X+
	rVDDKneJ0CtkhISvdSx81FaE7fqQcS7sPn/AmhUYzkw5ZV5n5Ax7kS3PHtOxJ0yW
	5RSaoJcehux51RNV+nLVq9DPJtE4RHZ/L8A55xlgj4dWVn9pzuHyVxBC7aDbzpG/
	EVz9VDelsAqsmk4jxhqEFGHwOgfNolyxZ3UR277Dj8uOLL0XzHdhAyUJEyhs1wZA
	17jLE0LIQXt3pZ5A2+37OzPG8bvDUBNqKFzlHkvhrWJePw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 00Ez00uSiIIh; Tue, 10 Sep 2024 16:56:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X38ws0j9pz6ClbFZ;
	Tue, 10 Sep 2024 16:56:12 +0000 (UTC)
Message-ID: <85a71ca6-3011-4bcf-bdb8-cb57e1be23ce@acm.org>
Date: Tue, 10 Sep 2024 09:56:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blk-rq-qos: introduce macro RQ_QOS_FN for common
 behaviors in rq_qos*
To: chensong_2000@189.cn, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240910084238.3543971-1-chensong_2000@189.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240910084238.3543971-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 1:42 AM, chensong_2000@189.cn wrote:
> +#define RQ_QOS_FN(q, fn, ...)	\
> +	do {	\
> +		struct rq_qos *rqos;	\
> +		for_each_rqos(rqos, q)	\
> +			if (rqos->ops->fn)	\
> +				rqos->ops->fn(rqos, ##__VA_ARGS__);	\
> +	} while (0)

I'm not sure whether this patch is a step in the right direction. If
others agree with the approach of this patch, I think we need a better
name for this macro, e.g. CALL_RQ_QOS_FN().

Thanks,

Bart.

