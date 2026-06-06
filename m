Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC42253B0;
	Sat,  6 Jun 2026 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730458; cv=none; b=WFT/jTXb7VKTtqa/okIAhTXXMVH9cw4Tx9nyerKR0S/XOMS1gSSj1uwSaDzjCc94mY+vGpsO2ulQG7hR5AHHAl9RhcFkt5O1ofAtJu39Nd/76yZIubCF3/09Vnq9YnQqntGzGo9sDIqCGH648C7o/mMfc+eEfezcaUtb068qfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730458; c=relaxed/simple;
	bh=rMhZK1SN/RbGyo0FjTJb/iICLfA04dqm6KJ1I8s9gSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JS5dUQEupFLjGLE4V56cvenIGTROI7zzfcrVwKvvLf4IhoZJ4zpD9ETzzpXfdBTbi6vs/cNo1O3glRaQyZfGhecjoDE4Xto8Tb4OKjg3uKNczrwmCWjh7VP/ih7u7QPtsQ0EhRhGVt3ethSIZSt7ryElSQhKnJUNH9uJjk0fbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS56c23O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS56c23O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C61F00893;
	Sat,  6 Jun 2026 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780730456;
	bh=Au2jdjefKcMNjn0WG02kshAw1MguBmRkFl5JN4LlKqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lS56c23OhBxAl6xxNUWTR+QPKeGWKYNMoTOzYlAF2NGxPQx5jhXFPl3A8li170rBy
	 aFJsJBSDuGdci28VlKvUOb/zssF4ajR2LAIaL2CHBSQ6qpoaJSwXC/ZJdXWF2oeXUX
	 QCvA34seLS0tfakFW96IdsErZTVDOg2R78UmByGJCBIZ2/PfbmIiV9g1HL+o5GW+L+
	 JitQXOSJAa3d2hr5Bm4XomJ8msf+1F/G3zKmlsBKyrW0IPtCaVn4cotHoiVcfdRwM9
	 3eDz/TxRdrjgT4Az7LF2nVson+MGahnIBnGQ6+SK0hyNTvBrIkge5qo3FmsrEdGswJ
	 kTT32HyG+9Zug==
Message-ID: <f962deae-4662-4a77-a722-65bfb478f90c@kernel.org>
Date: Sat, 6 Jun 2026 15:20:49 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block: add a str_to_blk_op helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260605184441.590927-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/06 2:44, Christoph Hellwig wrote:
> Add a helper to find the REQ_OP_XYZ constant from the "XYZ" string.
> This will be used for the error injection debugfs interface.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
