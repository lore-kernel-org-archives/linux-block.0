Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B33A29CF6;
	Thu, 12 Sep 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.60.8.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141021; cv=none; b=PhKGzLMeEb9e9coHdFwrF/V6ogyc+28JLqNDF73cf7rYOONUCYu9ZymBCrhT4r7HpDZPRvY5pI3qVpgKL+6fUHvNMmguyM91rRlypwEhg3Dsg67/LMiwT/GthHrPJ0kD6KVROkQb8rt4AP6mb18yIrf8CL1k1jURO9btWAX59sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141021; c=relaxed/simple;
	bh=yCWwqYowKJ2cQpeC8wSeYs2nASVcdeCpMVxGz7y9JtA=;
	h=Message-ID:Date:MIME-Version:Cc:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=GcFvNLPNjNeNAr4HjxKDUf4ibTEtJr8avnrOzzjlCXzjQxYLMYCoaXHuz0LSfp4g79n5LNr5gip4uYfbVRu/VVME9nR3i1N6VzEXYrjflF6PK01ljZhBmt4QOLFG2MgLZ+xSzIs8F/5Wg6qndwH3ncny3FMdAvxKk4+94fNT924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at; spf=pass smtp.mailfrom=vrvis.at; arc=none smtp.client-ip=92.60.8.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrvis.at
Received: from whiskey.org.vrvis.lan ([10.42.2.171])
	by iris.vrvis.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(ESMPT Server)
	(envelope-from <valentin@vrvis.at>)
	id 1sohXD-0007Us-2A;
	Thu, 12 Sep 2024 12:58:52 +0200
Message-ID: <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
Date: Thu, 12 Sep 2024 12:58:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Emelianov <xemul@openvz.org>,
 Kirill Korotaev <dev@openvz.org>, "David S . Miller" <davem@davemloft.net>,
 Nicolai Stange <nstange@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chun-Yi Lee <jlee@suse.com>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>, Justin Sanders <justin@coraid.com>
References: <20240912102935.31442-1-jlee@suse.com>
Content-Language: en-US, de-AT-frami
From: Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <20240912102935.31442-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -4.5 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)

> Then Nicolai Stange found more places in aoe have potential use-after-free
> problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> packet to tx queue. So they should also use dev_hold() to increase the
> refcnt of skb->dev.

We've tested your patch on our servers and ran into an issue.
With heavy I/O load the aoe device had stale I/Os (e.g. rsync waiting 
indefinetly on one core) that can be "fixed" by running aoe-revalidate 
on that device.

Additionally when trying to shut down the system we see the message:
unregister_netdevice: waiting for XXX to become free. Usage Count = XXXXX
on aoe devices with a usage count somewhere in the millions.
This has been the same as without the patch, i assume the fix is still 
incomplete.

Thanks for your work,
Valentin
