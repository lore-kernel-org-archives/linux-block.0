Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FA27F016;
	Tue, 28 Oct 2025 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623066; cv=none; b=KSYvEaxVPnjrxp57xYzcWadJnEbYltKrSBSx0Pi3Iia+R2QB1ufyX6AuBsyFhplATZiBJG+KDbzm0g7XWPgYMrzbqDr0+rsNFsZiJP61WAyIkzX02E9rJR4eFOvuk5breJQfxw4a2RFxzOyZhajLhIWCzpA5bjiFhBK94Cq9fyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623066; c=relaxed/simple;
	bh=TnFIbM+bq7/HtWgjH5l2JYw1r4W3RkKTaKZQ39zMTXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYMDMrcIdzKrDji+cvxxPJawTe9gkvK/RgS80L1XwJ6KrTjMuvmrm/ZFVuQNCF/31iozrJzoWPpRuET+lh41Cs0uPrH+OPqaV4Pg4nj+jxmGg60K2UaNJ5uPVN0ml2anfTshiOVu7gwoE32X9I1wULEWnj2ya4cpiMvCIXeEJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBXslR44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBXslR44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27786C4CEE7;
	Tue, 28 Oct 2025 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761623066;
	bh=TnFIbM+bq7/HtWgjH5l2JYw1r4W3RkKTaKZQ39zMTXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OBXslR44Gdx3KqvVkKSDO1fbyT+3KaBycyKYr+5ysSMLzBg98a9iD9aFYY4e8Idif
	 uIOebabqY+faUfhJ1epzPoJy6FA9JuQTK7ftV4cSKR9GQn/pJZd4BM7rN2EmVqEr17
	 TbRysXQvc5MwVmpG99SgSFBLqxYz+kWvmg8catMGHHqvIcxN0qICHvlFgowAg6zL/o
	 j3wH4MkRX4wG28nwcTEfI9vXGICkv7r6HhJS4x+QJ54mtfid2cmgtc6hrpWml52289
	 cerEfbl74jFmhT0GuDP2X7VCKAWRQlv/Oei/KNfLQ5D1sKgTCB7ndulZF32lblZN4N
	 TD/DUjht6gSeQ==
Message-ID: <980b6563-07f6-405d-9bf8-e67b5f00c556@kernel.org>
Date: Tue, 28 Oct 2025 12:40:40 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blktrace: use debug print to report dropped events
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Johannes.Thumshirn@wdc.com
Cc: linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, rostedt@goodmis.org, axboe@kernel.dk,
 syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
References: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 11:46 AM, Chaitanya Kulkarni wrote:
> The WARN_ON_ONCE introduced in
> commit f9ee38bbf70f ("blktrace: add block trace commands for zone operations") 
> triggers kernel warnings when zone operations are traced with blktrace
> version 1. This can spam the kernel log during normal operation with
> zoned block devices when userspace is using the legacy blktrace
> protocol.
> 
> Currently blktrace implementation drops newly added REQ_OP_ZONE_XXX
> when blktrace userspce version is set to 1.
> 
> Remove the WARN_ON_ONCE and quietly filter these events. Add a
> rate-limited debug message to help diagnose potential issues without
> flooding the kernel log. The debug message can be enabled via dynamic
> debug when needed for troubleshooting.
> 
> This approach is more appropriate as encountering zone operations with
> blktrace v1 is an expected condition that should be handled gracefully
> rather than warned about, since users may be running older blktrace
> userspace tools that only support version 1 of the protocol.
> 
> With this patch :-
> linux-block (for-next) # git log -1 
> commit c8966006a0971d2b4bf94c0426eb7e4407c6853f (HEAD -> for-next)
> Author: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> Date:   Mon Oct 27 19:26:53 2025 -0700
> 
>     blktrace: use debug print to report dropped events
> linux-block (for-next) # cdblktests
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.805s  ...  3.889s
> blktests (master) # dmesg  -c
> blktests (master) #  echo "file kernel/trace/blktrace.c +p" > /sys/kernel/debug/dynamic_debug/control
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.889s  ...  3.881s
> blktests (master) # dmesg  -c
> [   77.826237] blktrace: blktrace v1 cannot trace zone operation 0x1000190001
> [   77.826260] blktrace: blktrace v1 cannot trace zone operation 0x1000190004
> [   77.826282] blktrace: blktrace v1 cannot trace zone operation 0x1001490007
> [   77.826288] blktrace: blktrace v1 cannot trace zone operation 0x1001890008
> [   77.826343] blktrace: blktrace v1 cannot trace zone operation 0x1000190001
> [   77.826347] blktrace: blktrace v1 cannot trace zone operation 0x1000190004
> [   77.826350] blktrace: blktrace v1 cannot trace zone operation 0x1001490007
> [   77.826354] blktrace: blktrace v1 cannot trace zone operation 0x1001890008
> [   77.826373] blktrace: blktrace v1 cannot trace zone operation 0x1000190001
> [   77.826377] blktrace: blktrace v1 cannot trace zone operation 0x1000190004
> blktests (master) #  echo "file kernel/trace/blktrace.c -p" > /sys/kernel/debug/dynamic_debug/control
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.881s  ...  3.824s
> blktests (master) # dmesg  -c 
> blktests (master) # 
> 
> Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
> Fixes: f9ee38bbf70f ("blktrace: add block trace commands for zone operations")
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
