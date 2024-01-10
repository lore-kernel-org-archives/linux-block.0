Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AC3EA82
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4LB13sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C03C433F1;
	Wed, 10 Jan 2024 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704878999;
	bh=KeXIOP7J5XvfJunCm97mAeQ6QSAeE9CE229AHbGk9Oc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=o4LB13sy+7KY3eePQTlmKXcRbwmTfngod5lyWekYUDWG5DoL0l6VRfhf+EAU6jKyU
	 56RXzTzrvnWdTzeTNcsirZ2rKPi0KFxTwnAz6popjr0z2gRLtukIEnsT37f2xwDoI5
	 WwY2xyyUkctxE0bElXKYDJQQfdId+DoazOBQeQJ0GgeOsxd3PxY6lh97muJ1nJx0uz
	 ZHvDyi+QcvUYYpTjgCRS9jxEsK4ztKaPNZKRv4rJku7cejGgQwhfzs4OnuJU1o98kf
	 kCVehFE5ZxNq8maCXPSLBAAr8IrHwi+BEEkJknldvnHrvDObGSopTzvuHRyka16Uto
	 pfQbyDCz/nR+Q==
Message-ID: <6aad1fce-5864-4d1f-97da-9d3738cbe575@kernel.org>
Date: Wed, 10 Jan 2024 18:29:57 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix partial zone append completion handling in
 req_bio_endio()
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240110051559.223436-1-dlemoal@kernel.org>
 <fb2671c4-fae8-42fd-9d36-931a3a013090@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fb2671c4-fae8-42fd-9d36-931a3a013090@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 17:22, Johannes Thumshirn wrote:
> On 10.01.24 06:16, Damien Le Moal wrote:
>> equal to the BIO sizei, thus ensuring that bio_endio() is called.
>          typo: size ~^

Oops... Sent a fix. Thanks.

> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

-- 
Damien Le Moal
Western Digital Research

