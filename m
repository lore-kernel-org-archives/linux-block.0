Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6632BF52
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606182; cv=pass; b=DDYNH4SyOjm8tIWET+s2G1iHsBPN3v4zN+hIO6LB8oZYOsW/7KfofgwyqzSvU4kjfGz3HTkz+B0n3o6mXR1WICl7SA1wDyo9lxgy8Kh7dPNAbesdwve0TtM/5YFd0hQTWWcGuW0ysBmSo6SAs4CD6T8abZw3yq8Wj5k+CEUe4Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606182; c=relaxed/simple;
	bh=yr09OYddakfpKLDI+altrhxF+h/mehdJz0FMmy5tKT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTkDAQH10Mt1Tfh9mkz4pxgV7dlwqCAtqfvjiujhf0cpkIpgtRlpcM/HltxyF4Sc1KGd1QnzHRnOtfdNv/pe8SKLsOiGiqT7vkAH/DuKsffms4Pyi5DKmPKGnTgphTB1skYbT6WB0yJDJK3g/oUqg7GEGY3Y8JPBOK5uvgJUtkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A4JjXpzD; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A4JjXpzD"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-694907f7967so373271eaf.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 10:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778606180; cv=none;
        d=google.com; s=arc-20240605;
        b=bIooGF46k8EqKcpshEnLKHzk1P+zda+MxOkfJxZB/MON8HLwoV6uUdtTQuTmyHE825
         Z/SFh1Sm9aEsMDKWVsQHKP1ER3YHXL93sKFZX7bDUv8vHoEx+mbF26n05/F+hdkphdzy
         M6koXmmxzqPW+Y//HDA2yTuakGAclLXskqVYy6tMmovTV7lpH4ILQ1OqkyPz+2D19qxi
         drGX1FKb/xFu/N4YOP9XHIKMhhK5gLV1Cz1Y0XfoNoKBrFdkFhZAIiQ6J6tqqQPDmqTi
         IeIIVDELhqS4Hi0GlFB2cTyugGqwJY2dY28TmZhjBoF+DLllvAbB52BEaMhKOW4aFH+3
         s4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rdZQxmc05py15X83OrNX0XV1ZNSACXUwhjKUk69e8KU=;
        fh=wRtULzZ53EAOYw5zxWX+gRxNFSy7b0YSKl8VXpQwNjY=;
        b=cUs/NoQb68IHo7KG2CUZZ91Wsi5gfTBBy/A+prPa4mM3LapX1V00cWBKLsU5l41kfY
         og+yDbpkXICrFHUPz05oM+WJS0dZ/mDrGo4myzm7GVF765k9pdGzPsDCKeNcN2sxm1Qh
         yqdkgZB8c66VOu7KLQ5KvepnHX165aX1rULzv90iBgM1m1i9tjIsx5aD6KX8XCbns2yI
         bmrkwuimUjNT6+lSn79HS3cwkJHxUBqC5i78NRAaS65DSh/SFsdFxvtpesdPlgVM1bw6
         KsbQN7dfkHpNqxOC1uJDm1MzEXF6nEp1RBOepwujOmLvJ0ESFr7sPNFwqS7KYKP12cJQ
         hU9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778606180; x=1779210980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdZQxmc05py15X83OrNX0XV1ZNSACXUwhjKUk69e8KU=;
        b=A4JjXpzDzl7HIXBVkI7O7NR5aaMraabXKGlrNtkUmOXikKMwIVoADfECFHZuvRWSye
         ms0SfTENOWYG83YBqfUZgbH0jVKBp6io9Kf7BU5fpHcwAwdZ7iqk6z8k7Iu+/uOfmE7u
         eFKhF+7uEsEXIDRGdjnew9wkTAgsEMp2X0NBqiKd5zx4EJ0kbm7ZOg3u2ZBaX5wmslct
         Fbj5lgvcig1QKamc1UbFMS/YQ1LKVPYOsQkoX/6To+3q43Vnnlum3moVLbivmxAAcJ9h
         XpVAWNWibE+bxA2/adFprLJkOHJQmGz8muA0LsTg8hU4z72Ic4AKtcwPajOdtBBhIvTf
         wpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606180; x=1779210980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rdZQxmc05py15X83OrNX0XV1ZNSACXUwhjKUk69e8KU=;
        b=rP+LrcNzV5+pD0vSEAa6bd6Ept6IgP/zI8/Ql2W2sJZMlDBquHCVCtJ5Zc3dsA7O/s
         v2e6IwhRC6AvkfciGOzVPHyilgkz+RwcxkaUsaUYmds7B1es5hGAh4GKLfRK1N6SiowM
         zcnDf9m2iCsjRBGVG//d0y4TTCa2zU4gDHKNj0u6VU7QWVuUYhUQU77w8A056tbY44Sz
         lecycHtL9czD5lT8jEAXKF+hcxbsNIfX75QpJMv+yhjiOsQIppzOrmrHsMC7JxiJKb7G
         NPwtSQiBy2zobC3AMIWT5IEQ9FoVRp6AGeQ1eRBEQH3DxcPl39pvLXutuHntmT90DCTx
         Nxvw==
X-Forwarded-Encrypted: i=1; AFNElJ/kfaHUBRZntRirUSjSntdTVMGrdcxNdl+bC9oyVVam92sHCLFrSi3w5ztST2B08VdCoweOYU8d8Gs4+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVlY2lhNcP/RmM4gLeh/t/IGhnc7zEA2gCABHZT7HZ0omymfS
	0WhSNZzU3NkSsmwzUSBpY6T3lSp3Vj4ST+1UPdCEouL+fUiOzuLAYkd4nzFdUA7rJw+dRqYb+32
	FXs0iTfkWZZsmR9IPoEThtEnoC7sPOfp76leeFjZfiXsoZxuO2Lg9CJG+4w==
X-Gm-Gg: Acq92OFdZp4QnkJvN3DI/5huF5t6IOStLvjmt+/+HbpFg18LICNyQysLWHXAzFRUj0y
	ZEu7bdTVZ7DtfjVLcrGitXfyZAYAKDQcy8JUQaXW1aZVK4vnvyQtvwIjLH07QCgB6JrSOR/b4cP
	kgB3wgX/wgaP3d9mZhBSB2g2KdfUXcwy1W/IsayQ/aGDp1I7KkBKBV4HUXp/vMkvW1CKxr3nXB6
	f61bs1tN5p8tu3UegHBhKRV1jCHCKN4awUNZcT90lT6bYnlUct8vo1mUWDlYA8c0Lfp/Z3Yo3lD
	iXOlfq4TQU1syVTPBi4=
X-Received: by 2002:a4a:e38c:0:b0:694:59c8:852 with SMTP id
 006d021491bc7-6999a096d59mr6746981eaf.0.1778606179598; Tue, 12 May 2026
 10:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512091528.617022-1-gality369@gmail.com>
In-Reply-To: <20260512091528.617022-1-gality369@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 10:16:08 -0700
X-Gm-Features: AVHnY4Jzrk8BAWx1utszTOkGBZXpnXiS7CyRNYkXNxaOYSMltPLvgwW4JJ5gxNM
Message-ID: <CADUfDZqYi=OznD0a=-e+D=y2nWUTmycdNWuTQzSbpboXzWF0ZQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: clear server ownership before aborting in-flight requests
To: ZhengYuan Huang <gality369@gmail.com>
Cc: tom.leiming@gmail.com, axboe@kernel.dk, ushankar@purestorage.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:16=E2=80=AFAM ZhengYuan Huang <gality369@gmail.co=
m> wrote:
>
> [BUG]
> A stale UBLK_IO_COMMIT_AND_FETCH_REQ can reach the normal completion path
> after ublk has already aborted the in-flight request, leading to a
> use-after-free in map/unmap mode:

How is it possible for UBLK_IO_COMMIT_AND_FETCH_REQ to be issued after
the ublk device has been aborted? __ublk_fail_req() is called from
ublk_abort_queue(), which is called from ublk_ch_release_work_fn().
Issuing UBLK_IO_COMMIT_AND_FETCH_REQ requires a reference to the ublkc
file, so I don't see how it can happen after the last reference to the
file has been released by the ublk server.
Plus, ublk_ch_release_work_fn() will call ublk_reset_ch_dev() ->
ublk_queue_reinit() later anyways, which clears all io->flags except
for UBLK_IO_FLAG_CANCELED.

>
> BUG: KASAN: use-after-free in ublk_copy_io_pages drivers/block/ublk_drv.c=
:946 [inline]

This function doesn't exist upstream anymore, can you test against the
latest ublk?

Best,
Caleb

> BUG: KASAN: use-after-free in ublk_copy_user_pages+0x83c/0xcc0 drivers/bl=
ock/ublk_drv.c:1013
> Write of size 4096 at addr ffff88800ce2a000 by task ublk.fsfuzz/275
>
> Call Trace:
>  ...
>  ublk_copy_io_pages drivers/block/ublk_drv.c:946 [inline]
>  ublk_copy_user_pages+0x83c/0xcc0 drivers/block/ublk_drv.c:1013
>  ublk_unmap_io+0x2bb/0x350 drivers/block/ublk_drv.c:1076
>  __ublk_complete_rq drivers/block/ublk_drv.c:1188 [inline]
>  ublk_ch_uring_cmd_local+0x157c/0x2180 drivers/block/ublk_drv.c:2477
>  ublk_ch_uring_cmd+0x42/0x640 drivers/block/ublk_drv.c:2561
>  io_uring_cmd+0x26f/0x570 io_uring/uring_cmd.c:263
>  __io_issue_sqe+0xc2/0x760 io_uring/io_uring.c:1826
>  io_issue_sqe+0xdd/0x11e0 io_uring/io_uring.c:1849
>  io_queue_sqe io_uring/io_uring.c:2076 [inline]
>  io_submit_sqe io_uring/io_uring.c:2336 [inline]
>  io_submit_sqes+0x806/0x2390 io_uring/io_uring.c:2449
>  __do_sys_io_uring_enter+0x5c0/0x13a0 io_uring/io_uring.c:3516
>  __se_sys_io_uring_enter io_uring/io_uring.c:3455 [inline]
>  __x64_sys_io_uring_enter+0xe5/0x1c0 io_uring/io_uring.c:3455
>  x64_sys_call+0x2419/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:=
427
>  ...
>
> [CAUSE]
> commit e63d2228ef83 ("ublk: simplify aborting ublk request") removed the
> abort-only completion state and now __ublk_fail_req() fails or requeues
> the request without first revoking UBLK_IO_FLAG_OWNED_BY_SRV. That leaves
> the tag looking as if it is still owned by the ublk server, so a stale
> COMMIT_AND_FETCH_REQ can pass the ownership check, reuse io->req, and
> call __ublk_complete_rq() after the request has already been ended. In ma=
p
> mode that drives ublk_unmap_io() into freed request pages.
>
> [FIX]
> Clear UBLK_IO_FLAG_OWNED_BY_SRV as soon as abort starts in
> __ublk_fail_req(). Once ownership is revoked, any stale
> COMMIT_AND_FETCH_REQ fails before touching io->req, so the completion pat=
h
> can no longer copy into freed bio pages.
>
> Fixes: e63d2228ef83 ("ublk: simplify aborting ublk request")
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 57ec900f0ce0..4f16a1ce7d2a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2673,6 +2673,9 @@ static void __ublk_fail_req(struct ublk_device *ub,=
 struct ublk_io *io,
>         WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
>                         io->flags & UBLK_IO_FLAG_ACTIVE);
>
> +       /* The ublk server no longer owns this request once abort starts.=
 */
> +       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> +
>         if (ublk_nosrv_should_reissue_outstanding(ub))
>                 blk_mq_requeue_request(req, false);
>         else {
> --
> 2.43.0
>
