Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710274F4758
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777903; cv=none; b=Y1V8ANbkocEi8Z6w/yWPL4v9BfQn/hvsb2wenNWoR963C2jhw+WxZSHgwtr40XyT6yWMfOTqiBI1Um044fyKZ7URbYQ8BvRTnuqc9xa87+1itV53VWgaXSLHOWOHje71MHbNJOcTw+EtxV789OuKze9eHzHg9ozAsSTVr5Pv2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777903; c=relaxed/simple;
	bh=YWPdCfsFS6ZQRQCEfEmlwZY8o1h7IsheV/Zhu+t5mrY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fhxe9TdSEDnrQHs/xDc5PoRY7tLtCJAqgbogSrYY6Pnp3ms6DUsaYIP6DLlY1dVGWIyJyWhIkl3qC6bCZssnhQhvbubg5TOzPee2IugWRcrMfS4IxbZ6si3g0pCneV8BnEYD4B54uGKdgspvIzAgvT8TqxuK1vUKw6g5bBeAVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XdniRzin; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XdniRzin"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91219376dd6so59790706d6.2
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790777896; x=1791382696; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=abUwIeE8e0bpFPRb9wUYRAMfwfBclRmiyensy4fqIE4=;
        b=XdniRzinlTcHzMj9HW9T692w9pUcHbeyAyLPc77mOd3x7fanJf/QcI4epp1ovlEZVY
         IMo+13a8sOH6q8EeJd2TLw+WFlQCzLL8URaHz7UyqTrLxC1O/ggVwypxm0RtL+AuMFA7
         RLD8eceGCpNSa/xtRFgpOFXrFW+RU7KE5vevaYvUDxMeIYFExbYBHPaqGOGu+ZVNt1MP
         XJE3RvifOQ43BjRb6p1rHBQatxv8APv6orX86J7ycwlToBYixsvB8tVbGHD4fI1XljP9
         /34jOMOrMw8ef7Nvw6cX/7KdcVyw6cal58EE4bLHMzljIqfHMzOh2zNieR12I3QVNxMM
         Q8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777896; x=1791382696;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abUwIeE8e0bpFPRb9wUYRAMfwfBclRmiyensy4fqIE4=;
        b=dOZqLKl4pc2nPT23WjHAUQbHIj5RiDkkVp1tpyardmWNfhuK8py0h7UrSqpCuUgTfa
         U3Wseqvbjy5KR1XYqTV0py7e6ayfrDXsrZviib2kKetByIGk15vIzF45kWZiGUvXGtjD
         6knk4F3sCZMTsvBKrdCfkYU/U1faSRGAckR5SmzBGQAaAHSNFuBbAixFgm4nRAXJtyKz
         VZUkpUZyXJq/Ff0Ynx9Jm87/K3m3M9/6EIF6BDZWxI+5rtmouXNaq/fjOlFUjDQwVUPs
         uKAxrCnlpwYrEoTfxnDYdiWaVVKxOEvMtI5tm+ufqeV+7/6sSIqFTvtFD83AwHBbeUQ+
         s5rQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiYPoXi6tudzZtnIl7WPkyvzWuezxjq0HxIeCGxSknl8uYuKGaylV/K3R4cft2nv8+mof/K/f/pkFMhg==@vger.kernel.org
X-Gm-Message-State: AFuF++l6OUG80Ktc6797jYtChq84YG9ZazlUzNL9mX9cwFZaBzfxCDiF
	N4Tzy3Bpu2LfWX/fWS3dXGWCwqiuDi5QYvXLX0oD/iUqitKJfHz68b4svG1Km3gf5j/n+X3mo+N
	I/PzPtB4=
X-Gm-Gg: AYBFou1x91vxDgVKFJxjF/RZxJ5msDofVI+BXe9UJku08GVC2q2x+bUqf1ArJrF9Gz0
	6WOvXSXccd46qx7VyJN4uPjrOtwK3WsRTXLfzoGr8lBrDp58Hw3ypcExySEdeDatwbUtlcDp9kp
	N0SOVRlIyZ8XhBBWsbB7qXprIk42mvqRgmJPlZfutXftJEBOkE7VPdOGkjnAhW1XWqbubynlBQe
	r3JQvmgLaOVbUSA4tySr9Dw3jhZc9etFLFDxarTGSpNpeiptULQLD0UhfEJ2D2YOo/HmecYFIK+
	jBc02jWDZvCNybhZqSVjzh9WrIjM29ahj1v7zrMOwhMDfTmo12jWz9i6UrFI095YMMW3z9Eqi56
	CJGgobA7IqgqvDZkXHL1hTUEu/0tjkeAhiUlNkwAUUx8tR20HrD3LdNa030Lba+VoQuKFhq2BE6
	BgTSoysSEw7ems2SgsQLf4BnRB2ty2AKLKc7dDW8u8S9rL26Nx86Y5GicCkkm86By67hKQikTkt
	+OzDJdBlEuvW+A=
X-Received: by 2002:a05:6214:2601:b0:917:98b6:51ff with SMTP id 6a1803df08f44-917a0bd731bmr24260116d6.32.1790777895505;
        Wed, 30 Sep 2026 07:18:15 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8aa9c54sm347136d6.49.2026.09.30.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:18:14 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:17:31 +0000
Message-ID: <e15d4e3c39e8ed1860b762cfd8e43c92.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Caleb Sander Mateos <csander@purestorage.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/9] ublk: fix dispatch to canceled io commands
In-Reply-To: <arvOwDHOgvpVW86j@fedora-laptop>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com> <arvOwDHOgvpVW86j@fedora-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 09:44:16AM -0500, Ming Lei wrote:
> It looks two races: STOP_DEV vs. START_DEV, STOP_DEV vs. FETCH.
>
> Looks fast io path shouldn't be touched for fixing the races.
>
> >   2. A partial FETCH round whose task exits, once another task
> >      completes the round.
> >   3. During recovery, the task of a queue which is ready already
> >      exiting before the last queue is ready.
>
> 2 and 3 could be solved in single simpler patch by making use of the
> ub->canceling flag, and it is easier for backport.

Agreed, yours is much simpler, and keeping the flag set for the whole
FETCH round is the right model. I ran it on top of for-next (d70609a2f68c)
with KASAN and lockdep through my reproducers and the ublk selftests. The
oopses for 2 and 3 are gone, and recover_01-04, batch_01-03, generic_17,
stress_01/02/05 and 60 batch QUIESCE_DEV/recover cycles pass.

What's left for 2 and 3 is that the device still comes up. For 2,
START_DEV returns 0 and the new disk fails every request. For 3,
END_USER_RECOVERY returns 0, the device is LIVE, and every read on the
queue whose task exited sits requeued forever, since the queue stays
canceling and nothing kicks the requeue list. With ub->canceling
covering the whole round that's a small check: return -ENODEV from
START_DEV and END_USER_RECOVERY when ub->canceling is set, checked under
cancel_mutex against publishing ub->ub_disk. The server can't fetch
those commands again anyway. Patch 9 of my series did that on the old
model, I'll redo it on top of yours.

For 1, your patch alone still oopses in ublk_queue_rq() from the
partition scan when START_DEV follows STOP_DEV, same as before. I'll
respin my series as just that, on top of your patch and without touching
the commit path: STOP_DEV marks the queues canceling and takes the
fetched commands under ub->mutex, and FETCH marks its command cancelable
before it publishes it, so a cancel from the control path never
completes a command io_uring doesn't have on its cancelable list yet.

For your patch:

Tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks,
Josef
