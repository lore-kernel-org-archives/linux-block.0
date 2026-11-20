Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209811;
	b=oRXIG2fzQUBB/UWqVekSKW+262LpyBzrnzx8PcO5igfRFpZ5QVbwbUurodP9/+eOuHEr
	 z4Jhs/ezpOdaMD6YMGJZEjmGYlwYzqbTmtrxD5r9qnbAI/qrxsXkt3kZYh0Q5XiYS3EbH
	 oikZpkJ5BEun1pQ8TGesDBS41AKtSiV4Zv/vMZJycHk19AewbIf/bvZqgEp/03yfi9E7b
	 FtEQMVFoLIAaQdnKnQM4ythThaXK3LFlWup9JuK0Sn3T/+PSVDLs51r+/ro5Zsg/6msEt
	 RbS4lRzqXJSzn4U9uMKGXefPMpS8INww0+1JZWsZLA83OvcPRs/vHC8pfhTmZLTbQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=M8u1XVMFyHF1hXnfW9u2WFmeDsUzEDO20LNBH8tl3wQ=;
	b=CAwETNMheqYepJRtF7JVh48oIOEijfINhseSwGIKUDPsvGVep901WMk/P6ImCeup7yJa
	 o3jAV9/6qHEfuLWWlHn1FsAmgM5MeJq4XX5BjFX/8SgQjor/BFOTTT+jHRyP0m5MD74gF
	 YjIduxR/L/+EZTLsEGnrGLqxTmGMsI6GQ7tJ/IDbhdUVwjVVw1XDF1EAnnSGsa4s9r/Xq
	 Z/SfEsszRnD+CqhBDfiv2gAVg15fIjcnlVGtMYdB0awVtwyNC8KTMRjpwgl67WBc2W2C8
	 uRmwk39YVVn6Cu5RuzLH4Qj5XCSgM1/BDlkDB6fVyx1c6N+inNrjDOyd4zhNb5FXkFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="gkd/7U+C";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495C606A687;
	Fri, 20 Nov 2026 21:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2495C606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=gkd/7U+C
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jWSxS2057z1XM0p5;
	Fri, 20 Nov 2026 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795209802; x=1797801803; bh=M8u1XVMFyHF1hXnfW9u2WFme
	DsUzEDO20LNBH8tl3wQ=; b=gkd/7U+CQtmg/607Ca66FlkHf98+RvUnNOcCENfe
	ue/n+N5A0CPYnAyTL4PEEe8keXdXIU0+QsMCVUvfnl56sjRGIkGxgGtTBEvv3JkK
	TslQR8zFfg/BRCi7gVZtHAz11453oe8sBo8m9fvdZYMQMUh/p7fbI4qzbDbh8eFD
	g81ocGCHsrrS9GALRDQ1Mox+G2QvwnyEZtKHxOT3hqgeMOjdC6hreg3mMeTU7FJ1
	KXs2R7nCRlj15mXH+onfWJAVPZMvkC8LXAloms0FA1wkGb1iA3kyk4vcEACBXuzA
	FBxGogcI7dDftZ5gxzztUGpLyvMESKXLXvhR7WrHPAGr8g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MkiQKUL8H2XL; Fri, 20 Nov 2026 21:23:22 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jWSxQ1YvQz1XM6JB;
	Fri, 20 Nov 2026 21:23:22 +0000 (UTC)
Message-ID: <f00cd07f-348d-470f-894a-c70435f45076@acm.org>
Date: Fri, 20 Nov 2026 13:23:21 -0800
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
Subject: Re: [PATCH v6] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928093512.3153646-1-cui.tao@linux.dev>
 <df36224b-7fcb-45c4-ab78-d7e726bfeb9d@acm.org>
 <edfc22ef-799d-4f70-8668-bde0caf67bcf@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <edfc22ef-799d-4f70-8668-bde0caf67bcf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 7:08 PM, Tao Cui wrote:
> I'll send v7 with the comment fixed and the redundant cancel removed
> once Tetsuo's series has landed.

I can't find v7 in my mailbox. Did I perhaps overlook something? As you
may have noticed there are no plans to merge Tetsuo's series.

Thanks,

Bart.
