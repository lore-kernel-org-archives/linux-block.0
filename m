Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A7385509
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620531; cv=none; b=V1mDBTqaweJAKVBZsF0fgkdya/Q02wJAcxOqefL8r3Bi1scKCgCy9cbollgWbQUSPOrsGcBkFw3TFjjP+32o2OiW9R9LJdGspghg5ZlI1T3nHeCWkBKBXydMi51E2xA90OtACTzGt4Whif0nKPuzonyZPlFfU3kD8zrqau95WkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620531; c=relaxed/simple;
	bh=Fa7UETDgObC9pq8R4zODrgE9VeFREK6fLvCloveBz6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K50Ej/q+BSO8MVxDkjtDrd4O2pp7nFOS0xoMMv3Id9Daa9zpJ3KXZBt/fMPiwPQOiq+4BE6Zkblf2tjy8pC73k7Zi706X/9jn3Ux2GXygn2rlNwQC7kEJV7BV9SopwxvnryXf7d/DUGTMIPkkvuok6qdb8/NeRz37JL0qIRTHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=OCQvMRWF; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="OCQvMRWF"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-53324cfe178so20814321cf.3
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790620528; x=1791225328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxYWdnG9XxFrqCAEGe9EqULQHLeOXuQ+tsemj8NQgPs=;
        b=OCQvMRWFaaG7PG+jWRdM+wDB+dmQ16r3yAiNRv9fmJLd7/4TvTRZetCx55AE2QH99U
         VywUQNpucSdncZWLk2G/X0+OJXbe9HxD7j5bhPUYgV+JS5WGWQZWuK65kgRWeOT2yW15
         sBz9LdDqgvu9sy/GEIYpNtD/B5o4lYfFEp8ytTs/+L1umwr6DosXzrXW2X0MZxvfyBAn
         ie42fcimUeX6gVesioD+18VLGjpbZg+P+PULtAtIYIGFXfwBHGY/43SjAr/ONuNLxcbu
         9aQDetwYd3Sd5nQeCJr4gwuRn4vqEBzo05vZB/1CiV7MC/EptfO6U3RPLlBwoF7Mjkfq
         Bwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620528; x=1791225328;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxYWdnG9XxFrqCAEGe9EqULQHLeOXuQ+tsemj8NQgPs=;
        b=aQ6mBliaTWY3BmJngz92FMx1h1C+2IRFg2E0BKWlgIJSexCrrN8FiewOh6oFiIZFS7
         sqkcLq3mFxXRiPYGRye1Zbc+7fI+qKwQjijaklp1nA5pyxBs3FdOtyOh7Fre/WtvW+Zn
         rnCdoU7d7MlhpRDGhvnlYjNtnAkNaUXv+RrrvwctLjeQ8d3AmDwYLJTaawrG0AtZN87F
         1SqHYUqMvSVHDT0FgX5cZGr2DN2OEtymHpImQmUcATeYiIbfy3qocOKLrCqsROc2OhEN
         pLjaquPQB1Bzt8ekY1N31nUKpXlFpCuy+P/HvThAIBzlU4kJx49520bzqbzYAq0S+2Zr
         wMPg==
X-Forwarded-Encrypted: i=1; AKwUvBwVuzE8rzQrz42aJcx9FuP5Ep2lSgJ/yB49w3Re0xPerGYJSWgSPqeI9If2yEu6DMgR3jl5hcERkNyHEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nn3aIltQZV4rmo+J1+YvgWn94uMAS6HPHWtMCjAHNIxesfJ+ZB
	Am14keFYpa1h5/wBIIdm+7o8bj2OxClQ9APd6v4BrQjg1ZfIFWdRRH9LnboiBOCgamcji7VdgJW
	Q9poHMNU=
X-Gm-Gg: AYBFou0Wr3IMTdvAjSGJbo1vM+JXjfqjNruykpN+lTgW25CNhjiDIbxcvGsjmks40Tw
	8Z+I/M2EbauUL1XdB/x2KjSX9XkxTYhqtHssLjJKUawBSRQeOJQFoAsll2kiD+MAP0D1gB3A9GV
	PtOUbLRwFx3QvXN/WEOFGKU6OB6W6eg89VGL+qWGxjI3xzA9oAj8/rzypj9LCpe8SYgU5G5vWyx
	rPYyPQttlB0asT3AyJHYpZ180+37PxdQCPv8vd3iDLK+KzbfuDVv5bG1Xq9RsI8Y3eGA5tqeu94
	7xrKYNKg3xnbkSnP3xdqZrsCJ6DezIVnsIQkOMM0LD8eYoew8ocNGeY7BvinuOrePAMcKgPTaSD
	XJgWAGwu4Ew/Ca3BzihcXLJdrcdC56RliGjDOVsrqM2tNoPWhO4qbgQm93/6au6hkPShgyoeJrZ
	e5AJx3Petsz+yzopEoPNDtdOnh4URIsxaOSspRiSpI0TG0efsaLNweBnAffZ3XY5ZP4xySwnL+O
	Lx8SHqFAd+3Xss=
X-Received: by 2002:a05:622a:14a:b0:533:427e:11c5 with SMTP id d75a77b69052e-533427e1705mr80457491cf.56.1790620527932;
        Mon, 28 Sep 2026 11:35:27 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332240741asm69846731cf.26.2026.09.28.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:35:27 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:34:13 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/9] ublk: keep queue canceling over canceled commands
Message-ID: <aop36p477swqzqcn7u7ib3wx5g7sjytcfnya6jjuaukihlgfwn@d6adnvllypd6>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
 <20260928-b4-ublk-cancel-stop-v1-1-4a4360232a46@toxicpanda.com>
 <CADUfDZpg0O89whqqCD4tASkS1KxV6b7xWn9mH8TTPQPo6KSFFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZpg0O89whqqCD4tASkS1KxV6b7xWn9mH8TTPQPo6KSFFg@mail.gmail.com>
X-Mutt-Resume-Draft: 1

On Mon, Sep 28, 2026 at 09:46:04AM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 28, 2026 at 9:02 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +               WRITE_ONCE(ublk_get_queue(ub, i)->force_abort, false);
>
> I think this has already been done in
> https://lore.kernel.org/linux-block/20260821103047.369522-2-yangxiuwei@kylinos.cn/

Not quite. Yang's patch went in as 8a14be55bdc6 ("ublk: clear
force_abort in ublk_queue_reset_io_flags()") and this series is on top
of it, so that clear is still there. The problem is that this patch has
the ready transition of a UBLK_F_BATCH_IO queue look at ->force_abort to
decide whether the queue has to stay canceling, and it reads the flag
before 8a14be55bdc6 clears it. A ->force_abort left over from the old
server's quiesce then keeps the new server's queue canceling and the
recovery fails, so it has to be cleared earlier, when the old server
goes away.

You're right that clearing it in two places makes no sense though. For
v2 I'll move the clear instead of adding one: drop it from
ublk_queue_reset_io_flags(), since the release work covers Yang's case
too (START_USER_RECOVERY can't happen until the old server has
released /dev/ublkcN), and say so in the changelog.

> > -       io->flags &= ~UBLK_IO_FLAG_CANCELED;
> >         ublk_fill_io_cmd(io, cmd);
> > +       spin_unlock(&ubq->cancel_lock);
>
> And this looks like it may also duplicate
> https://lore.kernel.org/linux-block/20260508123746.242018-1-tom.leiming@gmail.com/

That one is f7700a4415af ("ublk: fix use-after-free in
ublk_cancel_cmd()"), and it orders ublk_cancel_cmd() against the reset
path, ublk_reset_ch_dev() clearing io->cmd. This hunk is the fetch side,
which f7700a4415af left alone: __ublk_fetch() drops the stale
UBLK_IO_FLAG_CANCELED and then publishes io->cmd. A cancel that runs in
between sets CANCELED again, the fetch clears it, and the queue goes
ready over a command that was already completed. Same lock, different
race. I'll mention f7700a4415af in the changelog so that's clearer. Thanks,

Josef
