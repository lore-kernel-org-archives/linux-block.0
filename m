Received: from lf-2-17.ptr.blmpb.com (lf-2-17.ptr.blmpb.com [101.36.218.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EA4229A6
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694660; cv=none; b=HSq3fRLWNgn1U9SHnIfCifuqP7b5ZvjOlyv/1agojny84M+QYFvDnnaFOrR7sL+pffdxvgFsnGG17vmUneG9o9K4QAgMWhuXCBFkT+7UKLBuNnRh+gBlGmf7x07P71p9DjZYgB0MlhP4ntZZEAc7IuwxZm62ummnboPG02232bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694660; c=relaxed/simple;
	bh=2o3OD3j2TDpssbwNohVtaBgqVEv9rQjgCEXK9NhLGHc=;
	h=Mime-Version:Content-Type:Message-Id:In-Reply-To:References:Cc:
	 From:Subject:Date:To; b=cLM4fV4HR2cg26JMzNeKO2E8E+u8epdxId5h3NuT6JbxUqySTC7m8/9W7cGKmlVLI0aUl7KmTMDCPG9I8CFHo+FV4Nq3dBl+634tImRcZdXvzAGwzykEU9SabXdlJGmCyXz1jO/e0vdhH0FxhkY0ZhLxsp/J3s66izAwuALMn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=GYgVxP4V; arc=none smtp.client-ip=101.36.218.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="GYgVxP4V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1786694610;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eP5KdiR+Rw/feoVGKIi3NuGdvTGIMk7gH5biqZ4BOrM=;
 b=GYgVxP4VlG19j37wtMT5kZQRIe1LjQxQgMe2IgnloGT/BBVJ2IYUPH/fodXdKpDeCYk4Ew
 7lAxuobCuCU1ww3FpZnIJEV5H7ICXVmYfgU7PSjxaiCD6UcyJ53hALhRMcXaT9MoWxQrkT
 4FfR685VgLTcs74oDqGFqVdvSCuHfcyjhq4NmJ4z/MdhM8v94mRuJvmAAcx9K5l36VOsyo
 3ypUsmWYud6uj5BkTI01HIiRVGggOvwHKqQGY3CGxKXiluMZ5OnvHZ9Vu5OA5zINfi1vC9
 YKFJnLjFc0M7ItBCoJPOm08dLW0r9cgx8kjAiag26u7mklIyRsEmqgF9PQ3ZkQ==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.156]) by smtp.larksuite.com with ESMTPS; Fri, 14 Aug 2026 08:03:29 +0000
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fygo.io
User-Agent: Mozilla Thunderbird
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Message-Id: <c1de5e83-4d89-49ed-a3cc-30806f238f76@fygo.io>
In-Reply-To: <CANUnaiYZNj2n40HitJFJnzg1GSFg-VXZJSGEEHL5E7YqL3EHhA@mail.gmail.com>
References: <CANUnaiYZNj2n40HitJFJnzg1GSFg-VXZJSGEEHL5E7YqL3EHhA@mail.gmail.com>
Cc: <hch@lst.de>, <axboe@kernel.dk>, <ming.lei@redhat.com>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [RFC] nbd: is the add_socket queue freeze needed on the initial (pre-start) connect path?
Date: Fri, 14 Aug 2026 16:03:26 +0800
X-Lms-Return-Path: <lba+26a7ecbd2+3d90c5+vger.kernel.org+yukuai@fygo.io>
To: "Zhichao Huang" <huangzhichao.1@bytedance.com>, <josef@toxicpanda.com>, 
	"yu kuai" <yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/8/14 15:14, Zhichao Huang =E5=86=99=E9=81=93:
> To: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@lst.de>,
>      Jens Axboe <axboe@kernel.dk>,
>      Ming Lei <ming.lei@redhat.com>,
>      linux-block@vger.kernel.org,
>      linux-kernel@vger.kernel.org
>
> Hi all,
>
> This is a question / RFC, not a patch -- I'd like your opinion before
> proposing anything, because the code in question is a deliberate,
> stable-tagged UAF fix and I don't want to weaken it.
>
> Background / motivation
> -----------------------
> We run large numbers of Firecracker microVMs whose block devices are
> backed by NBD. On the VM-create hot path each microVM does an initial
> NBD connect (netlink NBD_CMD_CONNECT), and we launch many of them
> concurrently on the same many-core host. Profiling the create path
> shows a large chunk of kernel time is spent in blk_mq_freeze_queue()
> during the connect: each freeze waits for a full RCU grace period, which
> on these many-core hosts we measure at roughly 35-50ms. Because several
> connects run concurrently, these grace-period waits stack up and become
> a visible tail-latency contributor on VM start.

There is already a reviewed set to kill queue freeze for nbd:

[PATCH v8 0/8] nbd: eliminate queue freeze/unfreeze overhead in=20
connection setup - Yang Erkun=20
<https://lore.kernel.org/all/20260805122930.57647-1-yangerkun@huawei.com/>

>
> One of the freezes on that path is in nbd_add_socket(), added by
>
>    b98e762e3d71 ("nbd: freeze the queue while we're adding connections")
>
> with the comment "We need to make sure we don't get any errant requests
> while we're reallocating the ->socks array." I understand this freeze
> fences the krealloc() of config->socks[] against a concurrent
> nbd_queue_rq() -> nbd_handle_cmd(), which dereferences
> config->socks[index] and config->num_connections -- i.e. it prevents a
> use-after-free / out-of-bounds read, and it was Cc: stable. I am *not*
> questioning that this is needed while the device is live.
>
> Observation about the *initial* connect
> ----------------------------------------
> On the initial connect, before the device is started (nbd->pid =3D=3D 0),
> nbd_add_socket() runs while:
>
>    - capacity is still 0. set_capacity_and_notify() is only reached in
>      nbd_set_size() after the "if (!nbd->pid) return 0;" early return,
>      and on both the netlink and ioctl paths nbd_add_socket() runs
>      strictly before nbd_start_device() sets nbd->pid; and
>
>    - the queue advertises no write cache / discard / write-zeroes yet
>      (those queue_limits features are also only set in the nbd->pid
>      branch of nbd_set_size()).
>
> Walking submit_bio_noacct() with capacity =3D=3D 0 and no features, every
> I/O op seems to be rejected before it can become a request that reaches
> nbd_handle_cmd():
>
>    - READ/WRITE with sectors: bio_check_eod() -> -EIO (maxsector =3D=3D 0=
);
>    - flush (REQ_PREFLUSH): !bdev_write_cache() path strips the flush and
>      completes a zero-sector bio with BLK_STS_OK without dispatch;
>    - DISCARD / WRITE_ZEROES / SECURE_ERASE / ZONE_*: not_supported since
>      the corresponding limits are 0 / not set;
>    - passthrough (DRV_IN/OUT): not_supported on the bio submit path, and
>      nbd issues none itself.
>
> The only theoretical gap I can see is a zero-length, non-flush data bio
> (bio_check_eod() skips the check when nr_sectors =3D=3D 0), but the VFS /
> direct-IO layers don't actually submit zero-length data bios.
>
> The question
> ------------
> Given the above, is the nbd_add_socket() freeze effectively redundant on
> the *initial*, pre-start (!nbd->pid) connect, where no I/O can reach the
> driver? If so, would any of the following be acceptable, or is the
> freeze intentionally kept unconditional for robustness?
>
>    1) Skip the freeze only when (!nbd->pid && get_capacity(disk) =3D=3D 0=
),
>       falling back to the stock freeze otherwise (fail-shut);
>    2) Some cheaper barrier than a full-queue-freeze RCU grace period for
>       this "no I/O possible yet" case;
>    3) Leave it as-is -- the "no I/O reaches the driver" property relies o=
n
>       a non-local invariant spanning bio_check_eod(), the flush filter,
>       the pre-start queue_limits, and the set_capacity() ordering, and yo=
u
>       consider that too fragile to build on.
>
> My instinct is that (3) is a legitimate answer and that the invariant is
> fragile, which is exactly why I'm asking rather than sending a patch. If
> there's a direction you'd be willing to take, I'm happy to do the work
> and the testing.
>
> Thanks,
> Zhichao Huang <huangzhichao.1@bytedance.com>
>
--=20
Thanks,
Kuai
