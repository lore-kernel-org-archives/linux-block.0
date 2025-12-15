Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538622D4C3
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799633; cv=none; b=gnVu716Wxu56+yEOLpq0GSjNSbzh+rqOZ1bcPODIqmJQnWezsaGa0KacUe66RF42adm/NphQUyesW7xo+eyWuRlrZq3Fkr5O1gKu3MV0PA4eqUm8diKscuM2E1Y4cbQxzh8lgM/lVJ+l0LBSoWFgNKssDBSXj63uw86bpdtGXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799633; c=relaxed/simple;
	bh=q96evF2VG4gMhsIlbEZZnGhDG3jPqzwcmFH6XMimKMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPvEFlPNtQjf5w6ajIodHtSg95LaYcXoLCqnl6qCOGBohlfpzaeD4N9DvRrFZZfyaG5NzA46zzkWTVDtObMucHKaIndnUS87W9tMmsUZWqAsuX+kM7MABtB3pwUqlZuT8MY5D0q4bB/HbJ+pEwUhswDIXk83+fC1TU9xuUmcMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nILjK3/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nILjK3/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98569C4CEF5;
	Mon, 15 Dec 2025 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799632;
	bh=q96evF2VG4gMhsIlbEZZnGhDG3jPqzwcmFH6XMimKMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nILjK3/kuoXWRhLsEvjPdopNCrM7WUJn1DfwqNauRXLQX4msr35VjBik0S7LYJnEW
	 SgsYHKSIVlUyYH6yiUq+R1aoFmXQ2Sm/lQO98bocYYdj9+YVGb75mtA1C4YfJL8r02
	 sWzswRIQ1M25JXYiO52YJkBnvmY7zdOTz1Pe1HdrrMBSoxLKQ464DydXEvyO1UC41U
	 vIPOOXFIwJagV1Icdiy21DQ8u36ftPDDbeIAqA6wH27+xNmim4lEiu6SY2SfeuujfB
	 NZ1wifPVSmkl2knAnKB/L8zSIj958ej4DAk6VuV0ud4E5wqAFjcEOrQ583vISKFe5f
	 qaMQrTLk9Xenw==
Message-ID: <3d977618-4456-422a-a469-be623b9e55d3@kernel.org>
Date: Mon, 15 Dec 2025 20:53:50 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] zloop: use READ_ONCE() to read lo->lo_state in
 queue_rq path
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
 <20251215094522.1493061-4-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215094522.1493061-4-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 18:45, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> In the queue_rq path, zlo->state is accessed without locking, and direct
> access may read stale data. This patch uses READ_ONCE() to read
> zlo->state and data_race() to silence code checkers, and changes all
> assignments to use WRITE_ONCE().
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
