Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD33876B9
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079501; cv=none; b=NKhKNNzgbkMB0KCGQXm1uWmMtPj4XEa961tEhtNNsJeV8oSkT30DuWQZx3hwdsdgvErQLSy+bsy7Z9tsHBV3mnjrrxggUPW8OO6VZU0fi4WrBWSC+cASb9guEeYJxHDnvtYBWAI5sxQiE/ao8pxbBvIHz62hhJ2sbbjDDD/pBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079501; c=relaxed/simple;
	bh=acmUe1/s2wI5ZC+qgezw9CYz10JsN3R+CtPSymiFQso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAp6wznW5bEVtrGk+TGnJAjmUh/OBoBB2d+MjpF/baKzHqLpU6nBJNC9/eLs/y0OO2LFo22RNN/NU+7xusWS0lD6zzIl+8HQQAYuqG7udXYU6Z86GCCr0MrC1VF4R8Er6yM7lnCn192HM5raPoGnY6SF3QfI3rka6X50cTKS4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW500cOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW500cOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA60C116C6;
	Thu, 26 Feb 2026 04:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079501;
	bh=acmUe1/s2wI5ZC+qgezw9CYz10JsN3R+CtPSymiFQso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JW500cOTLNCf2f7koHugwPt7VtZoA51sHu7dOT2+Q3PTRUmb0i47Pj3y/UeT+KFvR
	 OGwGRrgWgXiZxJBnK613MAg6mpgrUZ4LDJJ/pROmWHNzrTTtux6vBxHtX5K+BmbdFk
	 SOGApgzhZwLpVjBR4bLYqk8yxe3uTRSCRzarxmDCMOVibmgu751a+KynZyOtpjNtSv
	 QQeQu3Cfs/F9BHlUC5cpErjL7mymUcYLUeL4hAj1HhTBwHA/RPwbzJ33o3iebdxorI
	 Rq5jQ1f/w9v+zPeNfIJ+iN0d93u4lLQzqUyp92FgykubsaeXRPZMqxsMXE1ngVMtpH
	 nMb4HsbHCsxzQ==
Message-ID: <94a65175-ea75-4597-a504-1915a746f506@kernel.org>
Date: Thu, 26 Feb 2026 13:18:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 2/2] zbd/002: do not check write pointers of
 conventional zones
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
 <20260220132351.273758-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260220132351.273758-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/26 22:23, Shin'ichiro Kawasaki wrote:
> After the recent change in util-linux [1], the 'blkzone report' command
> no longer reports numeric values for write pointers when the write
> pointers are invalid. Instead, now it reports the sting 'N/A'. The test
> case zbd/002 assumed that 'blkzone report' command would return valid
> write pointer values for conventional zones. The test case worked before
> the blkzone change, but now the test fails because of the wrong
> assumption.
> 
> To avoid the failure, do not check write pointer values when the zone
> type is conventional.
> 
> Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
