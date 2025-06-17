Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41E2E4270;
	Tue, 17 Jun 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.60.8.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163216; cv=none; b=e86OVYa3pSVhXKaEYqNegCyx+EZc7YrjqSQvNmKUr+wcZOOz//sGvtMOxUxeVe07Ocr3Big2TVtonYG/OGmtLaA88yzOIHckXeX6f5akecZr5k20o4i/1rBjbfI508ShRIB92nb43FSIHAk6A3ZezDxzBPVGBwCg4rQrJBb3Ifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163216; c=relaxed/simple;
	bh=+KcDYPHd+lFgy+PyxN98VCtQE/RUTNx3gwg72OyuATQ=;
	h=Message-ID:Date:MIME-Version:Cc:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=oD6rc+uLUOMWGFIF8z5Ei4HSBCH2yvvsh2lxWpzOfs0AZXMf/2GA+l0Z/gBYzdmIwckuDbSoB9o9RB6hscUaywE2EoTCI/ceX/OeAJbfsUs9Nv5qnO5nS0vKwdmJInKNUaZ5Iax7qrgfhf3dhS5r3pcxX97Bk2XztqM22vWnnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at; spf=pass smtp.mailfrom=vrvis.at; arc=none smtp.client-ip=92.60.8.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrvis.at
Received: from whiskey.org.vrvis.lan ([10.42.2.171])
	by iris.vrvis.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(ESMPT Server)
	(envelope-from <valentin@vrvis.at>)
	id 1uRUuN-0002zm-2B;
	Tue, 17 Jun 2025 13:55:24 +0200
Message-ID: <46323554-0ccf-4fce-855f-84e06f8fc7b3@vrvis.at>
Date: Tue, 17 Jun 2025 13:55:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, ed.cashin@acm.org,
 linux-block@vger.kernel.org
To: Justin Sanders <jsanders.devel@gmail.com>
References: <20250610170600.869-1-jsanders.devel@gmail.com>
Content-Language: en-US, de-AT-frami
From: Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <20250610170600.869-1-jsanders.devel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -4.5 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.1 GREYLIST_ISWHITE The incoming server has been whitelisted for this
	*      receipient and sender
Subject: Re: [PATCH 1/2] aoe: clean device rq_list in aoedev_downdev()
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)

On 10/06/2025 19.05, Justin Sanders wrote:
> An aoe device's rq_list contains accepted block requests that are
> waiting to be transmitted to the aoe target. This queue was added as
> part of the conversion to blk_mq. However, the queue was not cleaned out
> when an aoe device is downed which caused blk_mq_freeze_queue() to sleep
> indefinitely waiting for those requests to complete, causing a hang. This
> fix cleans out the queue before calling blk_mq_freeze_queue().
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212665
> Fixes: 3582dd291788 ("aoe: convert aoeblk to blk-mq")
> Signed-off-by: Justin Sanders <jsanders.devel@gmail.com>

Thank you very much for the patches to fix this issue.
We have tested them in our environment and can confirm that they work as 
expected.

Tested-By: Valentin Kleibel <valentin@vrvis.at>

Best Regards,
	Valentin
