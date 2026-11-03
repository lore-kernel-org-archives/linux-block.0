Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681861;
	b=L6xNChb8VvSEb9UpHg537EwM4Vm5ERSQ4qFxDn6bBmBc/K80cYzrPneGH0oth82s84ac
	 zUcLCsBuIr6GQRgWZ6WbRLArHpiXMVGB5qhjXy/Kd6xfO1mlPa1eHeopg+8eQFhj873of
	 5o4l3vKOwtn+GZmuFVIO27tcVgV6Xvwlv5U+IkkiC7OE8a491dyzy5PeQPqoEFwucHXf3
	 Mj+Atl37jG4PcIK4gAZAt5BeI6hnQ+gHAS4ZrUUrOikW3bAFNpngYd664AfdtIOXciBNG
	 ASTmakrPdgb2DReXZGjx4EaIT1bzaN+uPGL/yKL1V5jJf60p4/3HbVvc2FvsAUqKV6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681861;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SZ/o5wr1ehulH/dJEWTPqDzAjqwoi59PaL1JGefwbC4=;
	b=LjlFFJbFR522zTwiXOaX77czJszYm2H+bzG086Nlp52wBORDmTHDHdpHcx8USpFpD6q2
	 vmUMOAT80Mk3mUFbUNJKuGYViiG3g0z+2TWdPgFl6qhtoDH/G1jQXMlEMSoMiMEsu1wAY
	 AGFOzVsG4nofYp30WWPN7z2x42jZKqF3mSWcOpkBDZp/HLJNTzVoDRROszCXE4yY8IHpd
	 Ad4mGh6VV9grGPjj+C6QSDLNf3NEzEnVfHzXmfZcigxfTEMyigQmXnae9XTkR1jo8dyrk
	 PPsrTblpc2pzhwa3XHozzR57MYRQn7BoEvP9SvaIPTjVCV6CIhN0wAybQr5ZmO2Kj+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYLdOdIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42D606A324
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYLdOdIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A3A1F000C1;
	Tue,  3 Nov 2026 04:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793681860;
	bh=SZ/o5wr1ehulH/dJEWTPqDzAjqwoi59PaL1JGefwbC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bYLdOdIAwPZ7IotkcYceiGfh84hbip3gc2P/KzahR9dyxJFdRB5bjO5NsczE1+FDb
	 Dci/lZFXIpWkgXxJro8MOKMdMHOk4j52wyJnZW/6XtQ/hODEDP6I4LjuMkAbuJlxYm
	 nQUoSOdUuzj2PADuiyfsEqRalLvREPysz6fcMoeTVZ8I0FtbE2AGITBqkjUT0iVBUS
	 FfPaX11pA5Lo3oVBDKO/sGNwJqygaBcsFBjR81TgF14rXAphYHJIF0/YHX2B5G73Pu
	 xZjL4Y9Yo39WOgZ3q0olRdm2hGA075+eGrNnP4APJnWrX/HG0br3+eYaJ3gfEhU3rj
	 m5KyT9U3+ms7Q==
Message-ID: <57d4d8ca-e785-4a3b-a39d-f4430b92f8a5@kernel.org>
Date: Tue, 3 Nov 2026 13:57:38 +0900
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
Subject: Re: [PATCH] zloop: fix block size query
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20261102055558.3212814-1-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261102055558.3212814-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 14:55, Christoph Hellwig wrote:
> The block size obviously needs to be queried when it is not set, not when
> it already is set.
> 
> Reported: Damien Le Moal <dlemoal@kernel.org>
> Fixes: 5e9929e2f03c ("zloop: share more code for opening a zone backing file")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
