Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36B299937
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799573; cv=none; b=BGOtm2cL7LfDV/ZE8dD9ytAkKyBKn5kLqmp0Z/rljIyuVOSams/P6s3Rtav6f9TM9F7XVN15WyvxG8Ma+QAuoL4JC8YYAQHgSM3IaZfBOoTnPccJRBed12A0ZdxvUSFYE3zXBDYF4og8Aok4X5pTxpE1lA5acREe4D+BHh+vk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799573; c=relaxed/simple;
	bh=tgRrFQxPgMkztCvbGOehPGJMOSPLsKO4+ky/bJkXCWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U623FhJmf+/rstmIey48z6U5PRoDN7vjGjE/CVzqTD+tHyjJ5v3pMxN9SkhHF+esNOfLLybTY0fSAAL1+HSowmNHk1N0vLoaw+Sh/cdBREIAH8AUW5Ahtg4bP9TLgXTpNOjjsV093VGcmb93QyFHWThlxkN3oPcL3Zl3Mz8z3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLwpQmXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLwpQmXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC915C16AAE;
	Mon, 15 Dec 2025 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799573;
	bh=tgRrFQxPgMkztCvbGOehPGJMOSPLsKO4+ky/bJkXCWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OLwpQmXLYItSIsrKvu3n4ubSdoUNwrra0qcvgpsH3BHdt40shAeWNWPSwzx+NYhUm
	 CMcp9c+FwIhFg0OUn3VWsVNoD+u8bt19auLIqlagA9sNtHFT7TBJbT/wh5RYB+j499
	 lS2o4sb0mGgEiyH0EKz/MdjsGNb0c/Fv6jQ0C2asqEKaeYtdexRlidAnO0Rlb9QHQv
	 9xUBdcS/2bKtcW75kvyEKuHN+vHJ6a3r4B8NiTaG9JZW1Ff5dAcg6iP+BfEyb73Umn
	 eQRzwvoXiw3/QJ18BI8m6OxgOox4/0AswLn+cKSA4x7LIBXhGOoae5zRUMPs/hpRbl
	 R5doHfK2K1MdQ==
Message-ID: <b80227a1-d05d-4302-bf12-ad9bfc468351@kernel.org>
Date: Mon, 15 Dec 2025 20:52:50 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] loop: use READ_ONCE() to read lo->lo_state without
 locking
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 18:45, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When lo->lo_mutex is not held, direct access may read stale data. This
> patch uses READ_ONCE() to read lo->lo_state and data_race() to silence
> code checkers, and changes all assignments to use WRITE_ONCE().
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
