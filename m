Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932538;
	b=zgYHOIocWwT6GC/WVJzqsJd2vC/J7d1O0N8lA4JQBQYg+Y38LKdj9I6s/ednibO4heU+
	 OsT0NAsJwPl5MHRvq4ho9QjIsfM5XELkw7l7b3GEgQJAQXlY95wERhMyMyHhV1pfrDgH0
	 vX5t6QBMEmsD7fo7LSUkKAWEvV1xPjkCAbg+cDl8SaHMSPjML1mVO/4MwTHFcGIQs02D6
	 l1P5/Vy9MZcXp6/iu/odAsV4cCWfM06IGeQPKyBhobvSdOekiW/5UU8QXcy/3iqnpsd2w
	 Bq2N7l7UsS4+m0W+Btb3VRhyfuaRzX5z3pgrpOpZ/Ki7VFpQC5+bB0JtqohmXwDk7fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mUgYb/28VlXqFK4tqZxZSxLjPMzDJs50o/Np603ElF8=;
	b=cG51Ly9SL4NejVaolJBVtiBYHceCJnt5mEg8Ken3kL3u/15WIH/hnMcUmdJm9cBolryZ
	 CwQPVg0TzjXNF0Ph1z+ql+xKp6LiT3uKj3Qr7oKw66IOlmIfgUgSeKXGGdF6iiNLtONe6
	 jRZzXaYzlihbVQwEk+eDkYuJlRgvXx1P4vSsuqqpEzGQxh1L2q6HpcWideBtdMfUKr58q
	 PfZbd0Vxn3lAmPb8N5AFmijmQ6dHDwVRc0AoUFbcFwZ1N372ppoTOgA6hl9yf+XorGC6t
	 P+rrkS0QDzNLhdMFBBQI7TL794hxPPQuvC8BvSImzoTUBAvFs5p2/4UdFTEKEffJE/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Cbui+chg;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFA606A337
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 16:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AFA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Cbui+chg
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jTVPP5xRcz1XMYJS;
	Tue, 17 Nov 2026 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794932536; x=1797524537; bh=mUgYb/28VlXqFK4tqZxZSxLj
	PMzDJs50o/Np603ElF8=; b=Cbui+chga4Zrlksna23IjV+M6Qe6V7aB7oATclHW
	jq5H/FDt5B4Tc4HFeJIW+02mi0pnMQagcVGC1jWrTYWGFukD0o1esQwSJb7ar/3T
	HzA2HDseGboasfaYs5E04jD37kl2it90MZ2uyDs0eWnKT0DJxIMnp99npEK3Tu45
	58opiNXxMgjuCIIOmqqIWHItbFrwHIFVrtvnyECKFCPSBaM7D3aHWQK4l4fA3DJO
	KYy0C7BKrM1E/MWFOY+JICYSznZ23ra/su4FXOoe/BSmMQixnWIj5pPqVpZG9ey8
	6LT05CNDJUHK6+fkXH+Rz5cllshcUMEpA5Wt/9GkGzgOrQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dnWH_1Y1AYcR; Tue, 17 Nov 2026 16:22:16 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jTVPN3YT3z1XLksG;
	Tue, 17 Nov 2026 16:22:16 +0000 (UTC)
Message-ID: <2f89a1d5-85ba-41e4-83e6-da708875c44c@acm.org>
Date: Tue, 17 Nov 2026 08:22:15 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] blk-flush: fix a possible deadlock in the nvme timeout
 path
To: Ye Bin <yebin@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
References: <20261117131540.3542423-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261117131540.3542423-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 5:15 AM, Ye Bin wrote:
> Fixes: 9f16a66733c9 ("block: mark flush request as IDLE when it is really finished")

Reviewed-by: Bart Van Assche bvanassche@acm.org
