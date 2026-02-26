Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968037AA74
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079462; cv=none; b=WceFKiMYJ/m62orx94GgPjEY4BVjgHSxMVsJwpU8i1c9ZHmW5+HFRVR3e9dK8YPDYufNE7MSXocL0H8X1sYV7ugmXH3Bo4gEu9uMM0BJzCJpIOafJr3OKWa/ODgLBC50Yc1ZD2uNA4Kbg5BwhqI+uy6i6pN9ecAqEdAwSvaHu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079462; c=relaxed/simple;
	bh=qsdJ1IE59KDDxn+0oghoPIY6RutvO+WauFdBC7m1M4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJotmjLjiIOrhIOBomNSLWxT4hDlx7UgOfNp6a/JwPdboE73qxqx49ESmzI7DfIysNNU/7zojCH5xjbspoNeLSFhuQXd49dO2AhAHF7OgbmFaXBYYXB6OrGjg5MyF2VT+4hN0npmqxZo9u+D5G892JfXqhw4cKp8nithNNFz4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmWWmKeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmWWmKeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA67C116C6;
	Thu, 26 Feb 2026 04:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079462;
	bh=qsdJ1IE59KDDxn+0oghoPIY6RutvO+WauFdBC7m1M4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UmWWmKeK5GqRDfO3CVYhEG/W/S75xiOzvjSMk9X+qU0H+Vjbpg2Zz+jrqMWwR+GV8
	 XWs0jHnQaRUwfncgLqAXYYbOiIdxiLQuQ6q0kRi4jNZ6PfWPqBTUikq8E3GAJms0XD
	 3s+6cFrk4f42BGvoPg/Mw/L1afrovwEQZR3+oGaOPbvduDJZr8QmWAGwNoMTmON5iY
	 20i3fTHelcEa+vyo3E+2+H0Hr6gyF22YHbOeZJxyr9g7OiDPfQlFyG8Qqj0q1uxKSP
	 JMaDIZbQTWX0VfLk30X/LsKybMsR3pdzSbbW5xO40J4UGiDsKzgNCPRgkNOBSgdLXd
	 m3t7Lp0DkKBVw==
Message-ID: <30267aa8-1732-4ce9-9b56-75cdea5d3b3a@kernel.org>
Date: Thu, 26 Feb 2026 13:17:40 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 1/2] zbd/rc: do not use invalid write pointer
 values by blkzone report
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
 <20260220132351.273758-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260220132351.273758-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/26 22:23, Shin'ichiro Kawasaki wrote:
> After the recent change in util-linux [1], the 'blkzone report' command
> no longer reports numeric values for write pointers when the write
> pointers are invalid. Instead, it reports the sting 'N/A'. Currently,
> _get_blkzone_report() assumes that the write pointer values are numeric
> even when the values are invalid. Then it evaluates 'N/A' as numeric and
> triggers arithmetic operation failures.
> 
> To avoid the failures, check zone type and zone condition. If the zone
> type and condition indicate that the write pointer is invalid, do not
> use the blkzone report string. Instead, use -1 as the write pointer
> value to indicate the value is invalid.
> 
> Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
