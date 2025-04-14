Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA24A07;
	Mon, 14 Apr 2025 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589540; cv=none; b=lKx52hUmOXwxG83la0fFc9qOMkcxX3eMahCuuXkoxoUzlF/3ypZHCK/T3UlDOLpZCU51E2xqSViozSvTQ29NcRwpIAVWaET8HPr9tKBPicjw0/xsfQkCzN0og3PVFu8L1ouOBM6SAKgIW49G/isqO86mvOjOTI6kILl3tj2p0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589540; c=relaxed/simple;
	bh=BENLlnhV6obc/Xc5tTfY3/9UWXuwEIUyVe6XJUmn2SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PodoJxRnOTbWCODxGa5LjHM2xo/X6LJDCgkPQvjB9KXe1HQr3uvMKONoXqWOU2jG3vT3vk098L4/Fe27lDiwSJFVLOio259ROyBxJypQbKhg44gt/J0DX1+Frf/Z9sJNiHKBovZVFaPZ3F40Mw4QWhFSer5EddlbRtHzxcXYoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPvDDUXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPvDDUXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13043C4CEDD;
	Mon, 14 Apr 2025 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744589540;
	bh=BENLlnhV6obc/Xc5tTfY3/9UWXuwEIUyVe6XJUmn2SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPvDDUXQ4XmbbnKJ31tHS1xcoTdFtQmVrG0giwsE342TPZ9+FQhV2eXLq+60xti72
	 V2JYzpCrivQKiZLAHSn8C1oFpEve+McBVPdYOP/KMMV9GHPgtpaBeLer0ClU2ifdJe
	 OrV4NinG7QgRfYKiy94WW9RGng03B+PdxFAIDb2feqVOqza4pnjImz8vfbzbA7soOm
	 6Cw/n8R3Fore/tkiFRY2fjEaR11n7HJWtcZAdyvuXNbhaQIMz5tk+Kh5vdtwGIUNGk
	 cKcfp6OR2/zVExNwaKFhNSyxwFcoiE+LrlBya1ashfumANpakBSwrYqyM2XIZBPLrR
	 KjgVwNg6FpvJw==
Date: Sun, 13 Apr 2025 20:12:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>, "kch@nvidia.com" <kch@nvidia.com>,
	"yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
	"zhengqixing@huawei.com" <zhengqixing@huawei.com>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hare@suse.de" <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 6.14 29/54] null_blk: replace null_process_cmd()
 call in null_zone_write()
Message-ID: <Z_xS4iiTNPJ5mP0-@lappy>
References: <20250403190209.2675485-1-sashal@kernel.org>
 <20250403190209.2675485-29-sashal@kernel.org>
 <qytrsydugyz3ksuzg4m3aznskweuhphm7nkhm2faks3oefc7ok@jmteb2yigxj5>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <qytrsydugyz3ksuzg4m3aznskweuhphm7nkhm2faks3oefc7ok@jmteb2yigxj5>

On Fri, Apr 04, 2025 at 03:31:03AM +0000, Shinichiro Kawasaki wrote:
>On Apr 03, 2025 / 15:01, Sasha Levin wrote:
>> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>
>> [ Upstream commit 4f235000b1e88934d1e6117dc43ed814710ef4e2 ]
>>
>> As a preparation to support partial data transfer due to badblocks,
>> replace the null_process_cmd() call in null_zone_write() with equivalent
>> calls to null_handle_badblocks() and null_handle_memory_backed(). This
>> commit does not change behavior. It will enable null_handle_badblocks()
>> to return the size of partial data transfer in the following commit,
>> allowing null_zone_write() to move write pointers appropriately.
>
>Hello Sasha, I don't think this patch should be in stable kernels, since it
>just refactors code as a preparation for another patch. I suggest to drop it
>for all stable kernels.

I'll drop it, thanks!

-- 
Thanks,
Sasha
