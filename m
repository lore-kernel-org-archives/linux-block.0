Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE325C818
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356306; cv=pass; b=SVU45h8/dpdofjKyj4d8FikTgPL+jpMrhS1dRXieUREDMXS5MwA7BByQUBa/wF3dFXm63/vCggvIs6sK8pBhtKZUHgYh+9zNesuIvo3RfA8CbMhkmmDM8Y1CDmd1OXoQLSwFVSkDZP24Y3y98sQfsrP9vTI53adQQu2X5Sag3RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356306; c=relaxed/simple;
	bh=yqTSsXn3Tf0bFbAjwSIJvuO1YqDq8DGlfkp/JXwCRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zhj1GYbkbbA+cjgoruuHVgPEYhdQkwNtntwUFeXEwbv21EQSlt/BjkbZRWpz9mfrYFEIzrGTwqXOzBSoPX9GhS8WioIGgZL6dL5ary/2d7zUf+q3p0mpcBl8yv38khaQ/bob2V9YD9b0N6b+3pWCoRo/z7estXgjU5izPKFUQCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fAgAj3VR; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAgAj3VR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a27dddecb0so7304950e87.2
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774356304; cv=none;
        d=google.com; s=arc-20240605;
        b=OsxeKHGqRzugnu5R605kT5P3gi6fRde8uyC8yK2rPSf3XjKOXzYFIU8ozta7E1p6Ug
         hlnajwnmPG4Nd5mtG1Pr8fF17R/Hde//Y7jAAEK8xwnGupZIIuIyboA79N/Se7ccJ99k
         AWskSfBcSGxBXwsGNS+ere0yXLrId1CuFoidT4I+bBfD3slJJPtcpjDQU/u34lwwGWqf
         nkYzhEO82e9OK+foRlcO5hWaHu7l5h+mZjDTc0hfjvO1Z946e6iB3RUzp5QzkDglNtTk
         bRmlyUc87cp+BHBjazuFjPyKSXKQrKa9Qojm/nwnCrL1gFfuXSzj8HuFlI/hMk0hmmTB
         xSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t5fYTCkjrAgQURSIIg0HU6EB9FGTRkSpxZH93SzCPw8=;
        fh=IxbL6Ugw3/0rNO2IIcTZ4hBNP4NRxi+ZgMlElmxwVp4=;
        b=HTtunow6+EchxYuNpJYkhyhDR/NAauM6EnDdYxF9CpUxRyvGuJfygxUADLGoY2TroR
         mug6zF6fhxukMeQ83OJ0e7U3riM7PD2+NfbZEYyvm08eAiD4EVd8k6ifBgjtBNSaj+jG
         7YxacjpTGYckFhdiICkAhC+LaUgDGDTblrvQSfGhxA8sqmsvT9LtnV2ApBYcdJpCUrPa
         aVLF/r9QcO1oiOg/EOr53QXgZksVvsDewlLZHzlbL160cVrOEHfx2sieIXBgYJsXNgj+
         TjJA1xWRuChrmN2c/XPiXvtHC9d4Jqt2p2nQPqywwjUohgUQaMNQG5xwQs56Fw910wmo
         g7GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774356304; x=1774961104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5fYTCkjrAgQURSIIg0HU6EB9FGTRkSpxZH93SzCPw8=;
        b=fAgAj3VR/2wpkKs1SpN01z9BDGgtwW8hI43hRZo2+Ztdw/xveAMkn0rUgO8H5cfux9
         k73FNPbOV5JL9rKQYJK1QQdwZR7dk2RZ1NK0sNuAteSBRklZSj/k7uQ3hQjoxgirokEx
         EzQVW2wckcVlHKn1gJDOy/MPIzXiV8Gp9ajFuuEvQMyqpEbc/CoH5AWooO7aBFKWZkA4
         2osCVlGVqCHOAkzRNOkyAA+hSaEsOlgCsLheDeWcxN/dU2wGJKqUQMi0x6nOqp5n7Z21
         NzQuJrEBxCR0HKhBY5xbfnsrceoKPXFZJrahkpVQpiLXpuDE6eERQ35zzqAN5v6Z3cIi
         QHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774356304; x=1774961104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5fYTCkjrAgQURSIIg0HU6EB9FGTRkSpxZH93SzCPw8=;
        b=mXV3U4m4Ex+ycbEQLPwgsJ17xSZdnrqz8LyA8A0Rvx6Z76T7rNQPNQXowkAuPYMDVT
         xbp0S3zpNOx9kEVrn+QqczvuzIHJPDS0PbvP/2iaOxlEevDeG4ZrmAqm6QfQ5J5IbZc4
         76sVxxk5JQwHX+RWcKUfGO4V9YzJIKb/rH70nofPuAM+Cde8s2di1JxgIEEnIqhZ9Pys
         T8J6KCI8V1JsycM/i8HLOCw5QrCddNsR2vmuYkSoVz0qBm2biKDYkXU0d61i7X3GDFOy
         DwT2j5cSuAjcf0FwRlKtTWlA1sDr6RKQjbUJ6wSd/wwqInQziDOvb2J+bYjc/hTIwCji
         TvVA==
X-Gm-Message-State: AOJu0Yy1lAdMmURU4FCVJEJyb2PRmDXZRoek/ihQG+NUtoYgGwhqVPFX
	ZLe+looxEZL0Gay8ULVArEk8k1vYKfTFsc54nIkjQPz1XH7+tADW+mHA4LaTCSj9+asF26qeIuf
	Lz2vekeXuOuWYo7UL97BiqT2nfwFe7EAbDenK/ZVuww==
X-Gm-Gg: ATEYQzyGBqdnXbvajIlyLXZm6W5WZiRxlehO/9ggKg6aQuv6MxMhVTNURtddvQ1419/
	dD3KJ5v9UHKGJa1HqYf05fgjOrTWVBq8EjbirBqeK52IW1vAjajWkmjgb4JSWf7uqqhXMp2kTxp
	5HsfBmI49od2oR6nHbTiBtC5x7XTFx2jGv0r8AOMIHM1WH0asPDGANN4kcFFZR/GOYaAZVG5WLk
	HDrJVeQNEshhLDBGRxe4ifuONs9Q7/8PTPR6ossY921f075wbl0HY/yVuEvAqn/xT1k+XqSK9yB
	8lBx9/F3
X-Received: by 2002:a05:6512:609:20b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a2864abeffmr3572286e87.20.1774356303463; Tue, 24 Mar 2026
 05:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310160408.3976760-1-b-liu@ti.com> <CAPDyKFrM92eAxCxU9E1eDNfXMdOC4JvAOXYgY=HcmFG2YfrQEg@mail.gmail.com>
 <20260316162241.2zry4hjmufiwphmg@iaqt7>
In-Reply-To: <20260316162241.2zry4hjmufiwphmg@iaqt7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 13:44:27 +0100
X-Gm-Features: AQROBzBIVyK8PtCTVLrDRNOS2gRTfn-qhdFv6gGKbTwAiOJKddMixLXpA7wQmq8
Message-ID: <CAPDyKFrHnhoUB4LqXV6RU6i=it4GcM_OXAzD2YeGK8rPq3cQ_w@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 17:23, Bin Liu <b-liu@ti.com> wrote:
>
> Hi Ulf,
>
> On Mon, Mar 16, 2026 at 04:01:38PM +0100, Ulf Hansson wrote:
> > On Tue, 10 Mar 2026 at 17:04, Bin Liu <b-liu@ti.com> wrote:
> > >
> > > Due to errata i2493[0], multi-block write would still fail in retries.
> > >
> > > This patch reuses recovery_mode flag, and switches to single-block
> > > write in retry when multi-block write fails. It covers both CQE and
> > > non-CQE cases.
> > >
> > > [0] https://www.ti.com/lit/pdf/sprz582
> >
> > It's great that a link like the above can be provided, still it would
> > be nice to explain a bit more about the problem in the commit message
> > too. Can you please do that?
>
> Sure I will add the errata details in the commit message in v2.
>
> >
> > > Signed-off-by: Bin Liu <b-liu@ti.com>
> > > ---
> > >  block/blk-mq-debugfs.c   |  1 +
> > >  drivers/mmc/core/block.c | 12 ++++++++++--
> > >  include/linux/blk-mq.h   |  3 +++
> > >  3 files changed, 14 insertions(+), 2 deletions(-)

Please split this patch into two, one for the blk-mq core and one for mmc core.

> > >
> > > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > > index 28167c9baa55..5f97d07fa3c8 100644
> > > --- a/block/blk-mq-debugfs.c
> > > +++ b/block/blk-mq-debugfs.c
> > > @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
> > >         RQF_NAME(ZONE_WRITE_PLUGGING),
> > >         RQF_NAME(TIMED_OUT),
> > >         RQF_NAME(RESV),
> > > +       RQF_NAME(XFER_SINGLE_BLK),
> > >  };
> > >  #undef RQF_NAME
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > index 05ee76cb0a08..00016584d70d 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> > >                     rq_data_dir(req) == WRITE &&
> > >                     (md->flags & MMC_BLK_REL_WR);
> > >
> > > +       if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> > > +               recovery_mode = 1;
> > > +
> >
> > I don't get this, sorry.
>
> No worries, the logic of this solution is not that obvious.
>
> In summary of this patch, in both CQE-enabled and non-CQE cases, in
> *_complete_rq(), flag RQF_XFER_SINGLE_BLK is set in req->rq_flags when
> WRITE request fails. This is to mark that single-block write, according
> to errata i2493, should be used in retrying this WRITE request.
>
> In retrying, mmc_blk_data_prep() is called again with
> RQF_XFER_SINGLE_BLK set, this makes recovery_mode to be forced to 1,
>
> then a few lines down in mmc_blk_data_prep():
>
>         if (recovery_mode)
>                 brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;
>
> The req block size is set to 1 to use single block write.
>
> Please let me know if this explains the logic of this patch.

Yes, that makes more sense now, thanks for clarifying!

>
> >
> > Under what circumstances do we need to fall back to using "single
> > block"? Or is this just for debugging?
>
> When multiple block write fails, use single block write. This is
> the software workaround documented in the errata i2493.
>
> This is not for debugging. When multiple block write fails, switching
> to single block write will sccuseed.

Okay, again, thanks for clarifying!

[...]

I noticed your conversation with Shawn, where he pointed out, that we
already have something similar for READ, which is implemented
internally within the mmc block device driver.

I don't have a strong opinion on how to do this, so assuming Jens is
okay with the approach in $subject patch, I am happy to proceed.

If we decide to move forward with this, perhaps we should re-work the
internal MMC fallback for READ to align with this approach too.

Kind regards
Uffe
