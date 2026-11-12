Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518807;
	b=2+1HKZs004IQ1Q4dTSVgIKWliHnyhPHoy8zNdcD3dhUK8mhtgUl9Z6Y5hKE6kT6EWRN3
	 PELq/pue1kpig1O1tLS3LhJdcnT7Flhj5Gz5xtgosgZcWlLO1g0p8FmCPdxSD+50DqtKC
	 XCnOzsIevzCTUWCPto7xgk0YtoHfuqkCZ1GDsleJaSb33Zny5YIMR99mzIeIJwLqRo4jo
	 cMabnU9o3VQYAN/8oN/VBjukBsrIN/zT6McqgkuvEiHnRU9lkhLJy8RN+RT8um6lelawM
	 xoj8aRcZ8Swlr9Fdr7KWd2JSZoFwsH+zGgbVUFxiWumMOPOzIQUawdRloTCjU0DbHWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JBMHkVOFZcl9fxEDNKOSeCK0S5Pm+0iUiyfj0Dglm4c=;
	b=qF9iqBf9Dq5V5tJTd75HPfQtJUE0ihFMdNNGBv7KXFjEurF2GWZeSHLRCABINfB+ZFsg
	 B36i7ur5KDQMB6r5jHseAQnJPOrPB9bsUYaBC6CHUHVolASmqqRX5X3cN7fzmHsIr1FmE
	 JMBNEf6Xn19OaT3oobGZH/p9u+PTCgC2jKSJpaTh2H8ftydPeqo8J2tEQUKhUSbNF08KO
	 RRz11iZLvW1jmDktDK9Ix1nBRcSHkCwdK469wbiA6oSzGMQ65HpttJ6DlcnJSEVfRrXgf
	 4VLNjwK+o62j9u5sNEp/qj5LUGMlXEd/l0M0SyRdUPXoBufMzdcyDOatRrCjHvE44Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uWg4QYGF;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241E606A323;
	Thu, 12 Nov 2026 21:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7241E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uWg4QYGF
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jQYP26sPvz1XMYJg;
	Thu, 12 Nov 2026 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794518804; x=1797110805; bh=JBMHkVOFZcl9fxEDNKOSeCK0
	S5Pm+0iUiyfj0Dglm4c=; b=uWg4QYGFCpo1EzVE5PHLK4k38Wa5nVkJVqBHXhWt
	SiRzqLLHo/A6KPyN9A0+dyCFfFU32H6cVSfAJy5UZDpLRZUftKOYW+1iRRs9JdgM
	tarq8Mcu0Z2iKtJD0eR+NsZvI53mNb3tt7gV3AIAIdx+xaUl6Ter/qKwflXjgqBh
	W0+q527jXRlFHw4cnvdJOpp3iz6/FkoEkZq+PZ8hUaPbDt3dSbbqzZUHtV9rQ+bq
	m6sgwJXVGKF3MNcoGI1M/qA5L1z6gDEO2k+CT0BjRPkmk6wbXES31fvX/VbL6CSM
	DGcQvF0iZ7ivwul9VCKT6UoxZvX/YuyudFXpwViML4gUDg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gRCXMwv_9KJj; Thu, 12 Nov 2026 21:26:44 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jQYP04Tdqz1XMYJW;
	Thu, 12 Nov 2026 21:26:44 +0000 (UTC)
Message-ID: <c2ce2c9b-04b3-476f-984d-c2b68187a740@acm.org>
Date: Thu, 12 Nov 2026 13:26:43 -0800
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
Subject: Re: [PATCH V2] nbd: Reclassify sockets in the reconnect path
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org,
 syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
References: <20261112105939.260856-1-trintaeoitogc@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261112105939.260856-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 2:59 AM, Guilherme Giacomo Simoes wrote:
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf008..b2b27f90a7ed 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1356,6 +1356,7 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
>   	sock = nbd_get_socket(nbd, arg, &err);
>   	if (!sock)
>   		return err;
> +	nbd_reclassify_socket(sock);
>   
>   	args = kzalloc_obj(*args);
>   	if (!args) {

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
