Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE722772D
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765703732; cv=none; b=CJoNa5h4XBqzd9tsMbcUZYAI7NRrhuSx2yWeyYJy2/M8z75LzeUzRWwMe7lDKdD0vopeyafBaiwrKVi8qFx3n08lyWf4ds23gRtDKisRIWFPP+hFZkVdmdrXohiUBfn5dXY/3mOb1goMA42LU906NdxvNpVlPG8FMfuYI7ENHbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765703732; c=relaxed/simple;
	bh=kwn5LX396L9u0ULhT/A1+iwyZh6kBCL/T6qNbRwX154=;
	h=Message-Id:Date:Mime-Version:References:In-Reply-To:To:From:
	 Subject:Content-Type:Cc; b=en63DoRGleQH5dMsDdl2E+qW71vJ83gxMw881q/tDRCCYFbBtp6hrl4WOtHDSdn3Q7iaMJMKPsvXhpA2U49mZM6Y+lXTdkEOmYFF4XF84cq+SCSh45TZUXyenjdgA9BBu1CXbICBrMLkQQ9hdURB2knTmRF5exBac//RxnmMS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=VHIwh5+w; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="VHIwh5+w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1765703598;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cdpZbarSkWJ/mUa00isJ1rqRL3EXFlz+OnHN7qgR2BQ=;
 b=VHIwh5+wuRXZw1IPlTxkzvCb+1/h0PYSJ/C7Qug1y2cUCtxIRRBNyuXdaLjoTBiGo8K/gq
 fXdXwir7oLn4fcAGBRcDv9VEqrPq9fh3IlMV+SK8R86Ds20b1f7fRe7ubpyVaAFv7pvYVZ
 SjYgqPe/iBTU1Wgl2Yk5xcaFBgk5OYMRh/HpdEABSNDVVJCYGRSUmhTkNzHn1uYXCr0Bft
 6Qq7erTVlUmDdAgpf3MNS3sOjibE2NiY9IGcFlxkkC9CaZGtM9NOwnDli4NiYjyEEQpdso
 dFYKbGKsXEvqDunC1YGb1PlDk7cLxqYzCDxVslp8j4PYlCFlYYMVYpvydq7hLw==
Reply-To: yukuai@fnnas.com
Message-Id: <87918803-689e-4853-b715-7eb033af5bc9@fnnas.com>
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Date: Sun, 14 Dec 2025 17:13:11 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2693e7fac+859623+vger.kernel.org+yukuai@fnnas.com>
References: <20251212143500.485521-1-ming.lei@redhat.com>
In-Reply-To: <20251212143500.485521-1-ming.lei@redhat.com>
Content-Transfer-Encoding: quoted-printable
To: "Ming Lei" <ming.lei@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH V2] block: fix race between wbt_enable_default and IO submission
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Sun, 14 Dec 2025 17:13:16 +0800
Cc: "Nilay Shroff" <nilay@linux.ibm.com>, 
	"Guangwu Zhang" <guazhang@redhat.com>, <yukuai@fnnas.com>

=E5=9C=A8 2025/12/12 22:35, Ming Lei =E5=86=99=E9=81=93:

> When wbt_enable_default() is moved out of queue freezing in elevator_chan=
ge(),
> it can cause the wbt inflight counter to become negative (-1), leading to=
 hung
> tasks in the writeback path. Tasks get stuck in wbt_wait() because the co=
unter
> is in an inconsistent state.
>
> The issue occurs because wbt_enable_default() could race with IO submissi=
on,
> allowing the counter to be decremented before proper initialization. This=
 manifests
> as:
>
>    rq_wait[0]:
>      inflight:             -1
>      has_waiters:        True
>
> rwb_enabled() checks the state, which can be updated exactly between wbt_=
wait()
> (rq_qos_throttle()) and wbt_track()(rq_qos_track()), then the inflight co=
unter
> will become negative.
>
> And results in hung task warnings like:
>    task:kworker/u24:39 state:D stack:0 pid:14767
>    Call Trace:
>      rq_qos_wait+0xb4/0x150
>      wbt_wait+0xa9/0x100
>      __rq_qos_throttle+0x24/0x40
>      blk_mq_submit_bio+0x672/0x7b0
>      ...
>
> Fix this by:
>
> 1. Splitting wbt_enable_default() into:
>     - __wbt_enable_default(): Returns true if wbt_init() should be called
>     - wbt_enable_default(): Wrapper for existing callers (no init)
>     - wbt_init_enable_default(): New function that checks and inits WBT
>
> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
>     proper initialization during queue registration
>
> 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
>     disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then t=
he
>     original lock warning can be avoided.
>
> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
>     code since it's no longer needed
>
> This ensures WBT is properly initialized before any IO can be submitted,
> preventing the counter from going negative.
>
> Cc: Nilay Shroff<nilay@linux.ibm.com>
> Cc: Yu Kuai<yukuai@fnnas.com>
> Cc: Guangwu Zhang<guazhang@redhat.com>
> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freez=
ing from sched ->exit()")
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
> V2:
> 	- explain the race in commit log(Nilay, YuKuai)
>
>
>   block/bfq-iosched.c |  2 +-
>   block/blk-sysfs.c   |  2 +-
>   block/blk-wbt.c     | 20 ++++++++++++++++----
>   block/blk-wbt.h     |  5 +++++
>   block/elevator.c    |  4 ----
>   block/elevator.h    |  1 -
>   6 files changed, 23 insertions(+), 11 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fnnas.com>
