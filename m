Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F76824BD;
	Thu,  4 Dec 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834058; cv=none; b=LMhhiXhHvaHk3IA7M3IN31xUCOeLglh7W4XBJHkrLkB1X9vox7VFpmjE7PCfBa/T9QKHfZk4kCF6psnEr5GGOR2OOsYwc3N4kMEBDxbWAy0fzUcCQEq3iqsZfgNA8k5xJwYqBKLlkcFlq4ANeunHvVrTvAspoO5zqE7badeCV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834058; c=relaxed/simple;
	bh=QPvpDRwpJA/J58ISelsDPEIn3NTiDFGxD2OWiFSsGM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELahNhk3t6DCWVZNBEVqXjsqwV/Qi5iLpBkh6gRpXcBo4Lr6M//5kb4kR8PxWq/aDlXh9nF5sTlS1GuPtO+lNwj9FLNNPXWR9NPo+k7zM0aO5eW/q/hjGT41oMPwTD3Tc6VGF0MJzq3LUzEkIaXyzliUbgBCUh/WG9tvpN0GR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssIEyVh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssIEyVh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B37C4CEFB;
	Thu,  4 Dec 2025 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764834057;
	bh=QPvpDRwpJA/J58ISelsDPEIn3NTiDFGxD2OWiFSsGM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ssIEyVh1ucOGVl4gzGrb5c7N5MB28+BTTx3kCoFSk8SuO+8yJtPfcI75mA94qsefC
	 SkYa8Q23MSFrxp7pxpUkARac3mNsCtz4TtSKgCjaBZNKma21bgtJRyXwTFdnELv4Nj
	 5Gb5rKR8MDWs7mXosPdyv9iwKJKJR2cZY4oGOCicLP795qp69r+6rPKRsOmBQeAips
	 18soyoV97l10XAx1//q6YMx3bp578nCvpalRgcSsVaZy5BEtC/u/WbuCdn1PzqsxS3
	 VXiUJh73FevsHxu5XEMkTjc4tasG3/t7djJRX8CPp4ZgoJsSD5k6hqkKoxf2APqsBc
	 5a9wDOYDrmx3w==
Message-ID: <84d23c11-b860-4a36-bd48-563e4fd3379f@kernel.org>
Date: Thu, 4 Dec 2025 16:40:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix comment for op_is_zone_mgmt() to include
 RESET_ALL
To: shechenglong <shechenglong@xfusion.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stone.xulei@xfusion.com, chenjialong@xfusion.com
References: <20251203151749.1152-1-shechenglong@xfusion.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251203151749.1152-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 00:17, shechenglong wrote:
> REQ_OP_ZONE_RESET_ALL is a zone management request, and op_is_zone_mgmt()
> has returned true for it.
> 
> Update the comment to remove the misleading exception note so
> the documentation matches the implementation.
> 
> Fixes: 12a1c93 ("block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL")
> Signed-off-by: shechenglong <shechenglong@xfusion.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
