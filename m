Received: from sg-1-38.ptr.blmpb.com (sg-1-38.ptr.blmpb.com [118.26.132.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEC3A0E98
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731001; cv=none; b=ciuD0b01vprflUn4OsCK7IHkCxk8EIFmC2Fmc8P6LzrPlQBVLlVlTnXHB9ykGFThYa6YtMSxu5KYjuifCh5XPIDMt2LoWVaIyIDiLf/TWFpyJWOaFkdcYEF3kUspiObDYo2A6WsTzyf703WLZp/9K/wQje62//bd2AkL8ca7zO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731001; c=relaxed/simple;
	bh=NBgiYgLBu5nM+0SlN7Vrkrmq9hi8EhTzyCsZ1rCym2s=;
	h=To:Date:Message-Id:In-Reply-To:From:Mime-Version:Cc:Subject:
	 Content-Type:References; b=oeoRsEef/6VMZBTgd4d8XH1sICf2A1y7fxOiJwaYtnAvpSu2CweOJiNgWrTlYFj6vDtoxZocPYgW6urhVztksCqFkHtOTOPXItUpHgESKaHXnpm/89Y9XVnorbSWS290GqWQjBozpi7SeU7NKL3MTrBNoBzRunqtOBhmwJ6d/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=0KG82UYG; arc=none smtp.client-ip=118.26.132.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="0KG82UYG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1772730992;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=D2pGLx3lueL6dK4c/ymuVOTZI8taow9V0Cys4kW88s4=;
 b=0KG82UYGoX54hg4oIoHI1gcPeVov/6gr4nLy66XGVCtxeb8DlT2Kk7Q6O39qAjWZem0GR9
 Nyd4UHedOAZCJqdEaPrjzDmXbtxlKIk12Kx6alT4/uWInU5DufAyf6C+aWPquxGyZORmot
 z4MeJoNU+J7ufkpwcp64kDIdXiZU+7lZlubca4xkvvsN08Fg1ECMJ5Vd0Zhd3qTe0e3HLY
 X1GxsGLkv2rUj4y9OEq5U3s4nPzb7gZS6HbtsMw2uBD9I601cXxHy2MNH00Nu073WXYo3A
 xi4/wggbf3jHXIaMXb4ouDX6LGI56TLa7X0++i2P7xqdb13Cdq6Y4vSyjRoxHQ==
Reply-To: yukuai@fnnas.com
To: "Jialin Wang" <wjl.linux@gmail.com>, <axboe@kernel.dk>
Date: Fri, 6 Mar 2026 01:16:28 +0800
Message-Id: <71d29799-2b5b-4ebe-ba7f-70f87aa16ad3@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.182]) by smtp.feishu.cn with ESMTPS; Fri, 06 Mar 2026 01:16:29 +0800
In-Reply-To: <20260228100144.254436-1-wjl.linux@gmail.com>
X-Lms-Return-Path: <lba+269a9ba6e+443ef3+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<lianux.mm@gmail.com>, <lenohou@gmail.com>, <yukuai@fnnas.com>
Subject: Re: [PATCH] block: fix race in update_io_ticks causing inflated disk statistics
Content-Type: text/plain; charset=UTF-8
References: <20260228100144.254436-1-wjl.linux@gmail.com>

Hi,

=E5=9C=A8 2026/2/28 18:01, Jialin Wang =E5=86=99=E9=81=93:
> When multiple threads issue I/O requests concurrently after a period of
> disk idle time, iostat can report abnormal %util spikes (100%+) even
> when the actual I/O load is extremely light.
>
> This issue can be reproduced using fio. By binding 8 fio threads to
> different CPUs, and having them issue 4KB I/Os every 1 second:
>
>    fio --name=3Dtest --ioengine=3Dsync --rw=3Drandwrite --direct=3D1 --bs=
=3D4k \
>      --numjobs=3D8 --cpus_allowed=3D0-7 --cpus_allowed_policy=3Dsplit \
>      --thinktime=3D1s --time_based --runtime=3D60 --group_reporting \
>      --filename=3D/mnt/sdb/test
>
> The iostat -d sda 1 output will show a false 100%+ %util randomly:
>
> Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz =
 %util
> sdb     ...  16.00  104.00     0.00   0.00    1.25     6.50  ...    0.02 =
  0.90
>
> Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz =
 %util
> sdb     ...   8.00   32.00     0.00   0.00    1.38     4.00  ...    0.01 =
100.30
>
> Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz =
 %util
> sdb     ...   8.00   32.00     0.00   0.00    1.38     4.00  ...    0.01 =
  0.20
>
> Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz =
 %util
> sdb     ...  11.00   44.00     0.00   0.00    1.27     4.00  ...    0.01 =
 82.80
>
> The root cause is a race condition in update_io_ticks(). When the disk
> has been idle for a while (e.g., 1 second), part->bd_stamp holds an
> old timestamp. If CPU A and CPU B start I/O at the exact same time:
>
> 1. Both CPUs read the same old 'stamp' and pass the time_after() check.
> 2. CPU A executes try_cmpxchg() successfully.
> 3. CPU B fails try_cmpxchg(), exits update_io_ticks(), and immediately
>     increments its local in_flight counter via part_stat_local_inc().
> 4. CPU A continues to evaluate the 'busy' condition:
>     end || bdev_count_inflight(part).
> 5. Since it is an I/O start, 'end' is false, so CPU A calls
>     bdev_count_inflight() to check.
> 6. However, bdev_count_inflight() iterates over all CPUs and sees CPU B's
>     newly incremented in_flight count. It returns true.
> 7. CPU A incorrectly assumes the disk was busy during the entire
>     'now - stamp' window (the 1-second idle period) and adds this large
>     delta to io_ticks.
>
> To fix this, we capture the 'busy' state before performing the
> try_cmpxchg(). By taking a snapshot of whether the device is active
> prior to updating bd_stamp, we prevent CPU A from being misled by
> concurrent I/O submissions from other CPUs that occur after the
> timestamp comparison but before the inflight check.
>
> Fixes: 99dc422335d8 ("block: support to account io_ticks precisely")
> Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
> ---
>   block/blk-core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 474700ffaa1c..1481daf1e664 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1026,10 +1026,11 @@ void update_io_ticks(struct block_device *part, u=
nsigned long now, bool end)
>   	unsigned long stamp;
>   again:
>   	stamp =3D READ_ONCE(part->bd_stamp);
> -	if (unlikely(time_after(now, stamp)) &&
> -	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) &&
> -	    (end || bdev_count_inflight(part)))
> -		__part_stat_add(part, io_ticks, now - stamp);
> +	if (unlikely(time_after(now, stamp))) {
> +		bool busy =3D end || bdev_count_inflight(part);

First of all, you're moving bdev_count_inflight() before try_cmpxchg(), mea=
ns
there is no guarantee it can only be called once in one jiffy, and I think
this will have performance overhead that might be unacceptable.

BTW, this is a known issue for us, and we're fixing this in iostat, by
checking util together with aqusz, specifically:

util =3D min(min(util, aqusz * 100), 100)

With the respect, if user issue IO one by one, util is the same as aqusz; a=
nd if
user issue IO concurrently, aqusz must be greater than util.

> +		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) && busy)
> +			__part_stat_add(part, io_ticks, now - stamp);
> +	}
>  =20
>   	if (bdev_is_partition(part)) {
>   		part =3D bdev_whole(part);

--=20
Thansk,
Kuai
