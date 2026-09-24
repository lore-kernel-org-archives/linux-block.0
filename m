Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E51DE8AE
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219485; cv=pass; b=s/EXXylbnzZyBDJ+qO71nzx9U4he5uwrsjssH0n07Em1XXy2bt/rxNsKIgdeiuXafiaEnuKjq3SgMdtZOM/gul6ALWXEZptXx+r9KeeqAYK6k6OFPxAb3jIBpPbsqnv0GJmAptassvqnRLQaFFFFkd+OQlk87/RCP+BUziXx27k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219485; c=relaxed/simple;
	bh=2j1C56GM8BFyvZlQYTWpHHylUYR90lKGt/E8S17eoYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpHL0Wybk7y9NrycgkhZx0nuhocINvuS1W239udbjb6rpFyRH+2cZLbsICx/xoDTg6BB+1ykiwMIDSnUiqmh2mPxLhsljbRja+mdAQ1vHOUCTswShHEYEPyZa/BDm5jYkK3celI44bwM27rvzCkWjBy3agthNz8cL4wtArP1YG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfXqSMba; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfXqSMba"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so889688eaf.3
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 20:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790219481; cv=none;
        d=google.com; s=arc-20260327;
        b=QTSVq7oVzufPabZ7sSNBv5SUdgMc/RIHORSO8Ohamo9DMLKQAUjvTO7/QsawlDRt60
         rWPnK6weDqAQfaPj+5HVZQt2F8vS+dhGZttJ/aWTD8GU3UARJJZMiv8HzQDBEwPO9hVS
         UlmqtZyE+/AEdkmJPqvZOccATmzZRpJyb2g8VsHfhxD/FM4IU1QCbNfN4a0e9qQg6CdJ
         RIpKIsevZVPTXjz5UTAl+4gHAJg+aa4EozBvb2hBy5KchB+N2U3k89SutauK1A8fk7uG
         6opBbaqUB02DM9BQn2KvZ144vtABRjhhDJo393F5DT31dkk7qt2A2ctOFoSC6cbjDQH5
         3UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PAbCNvl+vbwtDCjhKld2y+X8RPnKNQMIOsSC/w3hdyg=;
        fh=TJyzGoT3ToiKEgSON9lNdNani5ajzxr5s/WG5CJsqcg=;
        b=c19ZSPsYxizrViCKJ9C85mcyR2t767uwYTDXAeiIFD8KeAmLaygXXhD2p8HOr1l7jF
         WmYHpzQlRthmtmL26gBNj9Y2Jp/2VCInyY6ECNY/cXyUn8YSqvi6fJU6sNSmj9Q8fJsZ
         dDkvCztVAaZt3BkH4qqgsOuPkLGynx85huhR10i46aQQWhHDvLNSvA2wRwS8zN9XRno8
         OHhCO2E3a91UUQODC6dpZGHYAS1/RfPlJ97BxLvMK0gP6yBFF+K5SkADjOCkV2xQxkVM
         iarIAXFG5GoarGYYpWOnW8w4XO+RwDwyC+3V4zk3lYEps+vxSRqeCW5TvvxDGK1TC2iN
         xOGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219481; x=1790824281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PAbCNvl+vbwtDCjhKld2y+X8RPnKNQMIOsSC/w3hdyg=;
        b=TfXqSMba54WY0GY9oG64XNy49goW9EVXAFyjh7WC4AZVqRdm3u/GTi1IwwKPRhyIwL
         LvNzKzpuefIdNAcE62z5F9SREPZvOwQFLtd+xyRcpwzDu6BBtJsVXfyqhXjUQHxDzbXI
         bW9lMHZEuOe8bFseU9nwPOvFyOvgovvTy6Q9Je7hgqollxdXr5opszCr0JgfHIkebxJB
         rZpHGDNe0/0x2tjDPflDwf6txNRVSMtTGFajO7Ef0WXzfi3G+BhEypTfDHeE4ql0i6Cn
         kZcjvC8celmEJQcYXM3xw3qzlXOpynCRP3bssN7aTQ4s0c8ED34hVRVejhNe/Za7yeUU
         4DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219481; x=1790824281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAbCNvl+vbwtDCjhKld2y+X8RPnKNQMIOsSC/w3hdyg=;
        b=dYXSAG4puEDjiXVj2n65qZVni1VMV+HjC9bOeprVv+FJq7hX3vpNIkU2Cu5yavJUj5
         RacZlvXm4b+1f9tIcJyp+FA256ugqVCRS+10rLkkfBV/1qt9l6N5ogGj/8UbY0GWhgSd
         w9qgQ0bs7pTTFyj6SnFMf+8472UVzh+a+xUMXziQrVx23wnyOXmCnwvXUCEGv5DrM0ge
         ZACHHsI86RnYis5lblug3GbsbWBOD0cVxx9+yqY8vuPzww/YauOaJO6PO/mZhuyQJYnw
         XQ4s4Q0uvhMRkCL7zcKR9kGV59FxOtWtuOboazV1u5Cw5j2AA9Rfj3RMitm2A2RmnMc9
         rarw==
X-Forwarded-Encrypted: i=1; AKwUvBy7Arh6DZWmJpWAvfkNsY49i2gqG8rcefxQuLpkQi5OMWzI70sf67hFYf7lhqE7UD4oXdcktraZBuavLA==@vger.kernel.org
X-Gm-Message-State: AFuF++npVcISDg90VVWLQOLesKhkmM8f+yjM2P6kb5cs1ukjpodk/GP5
	UwFIv1TKZvROGqBbltdLpPijAhc7tfs51YnMj7AvrvHZCcRdT8dNlS3UkZaHHhD9P/6dy1jAYrb
	QE+rY3JqjUhhEg5bdR20eLhuAUjWPLtA=
X-Gm-Gg: AYBFou3LQOMJpvyALaPNncq7VZX+ObpMufm1Bep7/hl806D3e7lWCMFhwlaCbH6MZVQ
	vJOW4Rb81Z3npG8/NvBaxF1oAV4ABszIIgOypDzq7GtigQSJqHYmm6jp7kTy0rWUpYxBmEvt4va
	iit71KPjEHdxpyMCjeO79g+x0cUVbH6SLip5qGygF2j5/SaQNW4BZVEwx0zX6Gqtr/WtNfhqgW0
	iiGiN+w1KaI4bcjNFijDwp+YvB2mFLOYloxz8EdCphD2LL29vtDyNWxH08aS0ziMJibK13p0jeE
	KNkLUMipt3ct4+vJDsfNXX+dooQ5NKcK9VUDtBKeb6OvUamOMTxS45LookkxuykqxiJcwSOXHXG
	BWoaxQliowjVyJqudM9GhP1C/TX70QGEf8h6ActMppLEr9hbaOhivJNA=
X-Received: by 2002:a05:6820:3092:b0:6c9:83aa:6fbd with SMTP id
 006d021491bc7-6d4416aaba1mr1152652eaf.66.1790219481377; Wed, 23 Sep 2026
 20:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179010105967.8478.2344875677216734809@proton.me>
In-Reply-To: <179010105967.8478.2344875677216734809@proton.me>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 23 Sep 2026 22:11:10 -0500
X-Gm-Features: AclHuK_hx_9XpVaJnWKId8Vpv3AIeuVNOuhwsC5qOUuULKOEPF9dmpRXHbPPP8c
Message-ID: <CACVXFVNi5E2Anxs5-EwevS+srqv2_D0bp3NJJv_hzM6pBNBWeA@mail.gmail.com>
Subject: Re: [PATCH] ublk: hold RCU read lock in ublk_try_buf_match()
To: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:17=E2=80=AFPM Paolo Bertinetti
<paolobertinetti200f4@proton.me> wrote:
>
> syzbot reports a lockdep splat when I/O is dispatched to a ublk device
> with UBLK_F_SHMEM_ZC enabled:
>
>   WARNING: suspicious RCU usage
>   lib/maple_tree.c:720 suspicious rcu_dereference_check() usage!
>   ...
>   Call Trace:
>    mas_root lib/maple_tree.c:720 [inline]
>    mas_start+0x3cc/0x640 lib/maple_tree.c:1250
>    mas_state_walk lib/maple_tree.c:3006 [inline]
>    mas_walk+0x1db/0x490 lib/maple_tree.c:4458
>    ublk_try_buf_match drivers/block/ublk_drv.c:5639 [inline]
>    ublk_init_iod+0x5d2/0x1120 drivers/block/ublk_drv.c:521
>    ublk_dispatch_req+0x97/0x9c0 drivers/block/ublk_drv.c:1776
>    tctx_task_work_run+0x73d/0xa80 io_uring/tw.c:96
>
> ublk_try_buf_match() calls mas_walk() on the buffer tree without
> holding the RCU read lock or the tree lock. Writers are already
> excluded because ublk_lock_buf_tree() freezes the queue, so there is
> no real race, but maple tree readers must still hold one of the two.
>
> Take the RCU read lock around the walk.
>
> Fixes: 4d4a512a1f87 ("ublk: add PFN-based buffer matching in I/O path")
> Reported-by: syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db48868c46e62c1c4cb2c
> Assisted-by: LLM
> Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
> ---
> syzbot tested this patch [1]: the RCU splat is gone, but the reproducer
> then hits the already open "WARNING in io_wq_put_and_exit (2)" [2],
> which syzbot has been reporting since May on kernels without this change.
>
> [1] https://lore.kernel.org/all/6ab1eabe.71f81b7d.15fa6d.003b.GAE@google.=
com/
> [2] https://syzkaller.appspot.com/bug?extid=3Db0d54b9e81de55179e47
>
>  drivers/block/ublk_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e71..7a64745e1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5628,6 +5628,8 @@ static bool ublk_try_buf_match(struct ublk_device *=
ub,
>         unsigned long expected_offset =3D 0;
>         bool first =3D true;
>
> +       guard(rcu)();
> +

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks
Ming Lei
