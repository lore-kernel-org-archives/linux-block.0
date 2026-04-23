Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06237311967
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968324; cv=none; b=jiBw3KBYlOKM3wlca1c4KbqnM6sOczzklR/OALKXGspZNalaBWo82V5gBg4oL9rNPNGTlhljYwhhzcV6YwAWUNTnTr1Oxq6IvIjdMSgRW5Tlmu72p3Y5bgMzwHG9Slud5xMbT4rQQwvdaOCAxuQpDIebmzkwzkhk2wHEnHGL8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968324; c=relaxed/simple;
	bh=AhPykmDqKzPiZnCNRx3drsrlWVmZQDCzGevPFw5/SY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQZ7rznI3YJvs8QHZ2qG6zwk8uaVQprDCxRVNcPkyvQSR/LGrPnTTnecgsRdxv6EI+yltu7Naj9mheo/yxu4aRtUhOJAnuI8v/rv8QSS+SUUScvGYE/bFnOSDIu16HKzs/mkYR9dNy6gvHs91ms6rFRIGx/Mss/4vOmivNBhJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=kzIOUC8G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="kzIOUC8G"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so56814395e9.2
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1776968321; x=1777573121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wNsqzv/VhvPhxD5VdhDjZ4FmwSvpZ9y0weaOvjolKg=;
        b=kzIOUC8GTHi1PJlmQjl+4nZai5MOvSkaWyNfPO9cswLc0BcNzmozbRXNGajm8MHuzP
         +7VFofFGQa8yHopguYZsVrY8silCbXxOwyukyHBBk/tkNQ5ncJhudAH3Dbx9s4XLQ4LW
         CySFH39jGc5Uak+dtmirwkvGrqajJhtrCxB4Vn1HPL9mnzAMbWodkqPUIxJHuSGMYUs6
         XsfRqdXdDfOFT0VfGRz9pFZ84W2wa55foF2Tqja5afbvAlEs/nhtzK0tJdOEmRRTmTgj
         oCHiLEt1yRXpVU0T4iE4RBzBgU5lfbZEIGN+9+jFR+DyDUpFG/sCB1Fg2qDuwHq273L4
         Oo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776968321; x=1777573121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wNsqzv/VhvPhxD5VdhDjZ4FmwSvpZ9y0weaOvjolKg=;
        b=WWs1e/CP7+39l0gI/mx1Te9E/5+edbcmTMUYfiv1CjuyRXclUCrq07n4DaGPLxrP5N
         1WDsffuTZ96xBcVJ/kBNt4XWIVtWf0twbg7BH+Ly1MMLEb0mq6YPeRAAxsM2Nvq114Fv
         0oAVQ8GjF9b993XV8DArd5ERj9O/jr2dK1E6xo5YzMVeUI8+ojsg/Ezexbpo1+5YAf5r
         kA17FCVQF5trem8dmEoEYlNddcLygYXx7enihuLA5VrhfrDhDyRB17W/ayxCZxjcJrRN
         QDZZPGx+Dec1/z3C0KZXYrRT7L3G8hUC+lvFPhjeZOLx3brT1R8iQ3zKO8wKslvaSMys
         NBcA==
X-Forwarded-Encrypted: i=1; AFNElJ+3gFJciy7pC7QW19QBbAAGyf9fbAX5NG2tTjTosFtNCGMSyp0xDlAVXw9bztTVv20zd1dDgQJ7Vnooew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ImMlqNUthiahkxdkBJEUxVGPuxEJ8WNT7xkkrsGmz5VzbE+9
	8CGrqAQseGnrKThvYzd5vLwhml6fAlWJIUgQLU0MI97TgPXWcZkGQgxOup9A3tyHx8Y=
X-Gm-Gg: AeBDieuktpYGNTgi2ZyRHqr/8KJC/H9j+/ros+CphRSkKkcqLBi/XK1e6FE/0ZcgZVV
	+P2s/rtmeRILcCb3XYx7LEpB84sQRjUa+9hwGDLD3sKj1APaiR5KGz6w+dMioW+fDxpcx8SK2MT
	y9S1KDM5knr2jAk34Ve52EJbQWyCSGrbz7wKcir1MNRAaiykeRJdWuvGa2fyLeRd84iFhT3NF43
	jFuo0uL7JROj+55tuvYtnyEe1/o/Yv6XEujSa2XmAPZTxJgN5MHanpiPXqQM++HeoweO2XZaTHl
	+eY6VTteRzZKeAMpOYdvUaYyd+FcZTLyj9xg18NMfT9rtlWDrRIFOpgn8te4aRLMZcGDec4IVT9
	M194r+/FSN5o4PbKpDAA1It0apcV1LlcuwPe+S4kcu+cPEEWPgAyHPb/JTA8O48P07FumGCjJfo
	2+XPt7FtdcLVYkh5rVbvU/
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr384148865e9.18.1776968320896;
        Thu, 23 Apr 2026 11:18:40 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm586656105e9.1.2026.04.23.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:18:40 -0700 (PDT)
Date: Thu, 23 Apr 2026 19:18:39 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc: Matt Fleming <mfleming@cloudflare.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: 10x I/O await times in 6.12
Message-ID: <aepfV6Gp2uKbHi2N@matt-Precision-5490>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>

Hi Yu and Jens,

On Mon, Apr 21, 2025 at 08:21:13PM +0800, Yu Kuai wrote:
> If nsecs - plug->cur_ktime is still milliseconds, can you check if
> the following patch can fix your problem?
> 
> Thanks,
> Kuai
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae8494d88897..37197502147e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1095,7 +1095,9 @@ static inline void blk_account_io_start(struct request
> *req)
>                 return;
> 
>         req->rq_flags |= RQF_IO_STAT;
> -       req->start_time_ns = blk_time_get_ns();
> +
> +       if (!current->plug)
> +               req->start_time_ns = blk_time_get_ns();
> 
>         /*
>          * All non-passthrough requests are created from a bio with one
> @@ -2874,6 +2876,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,
> bool from_schedule)
>  {
>         struct request *rq;
>         unsigned int depth;
> +       u64 now;
> 
>         /*
>          * We may have been called recursively midway through handling
> @@ -2887,6 +2890,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,
> bool from_schedule)
>         depth = plug->rq_count;
>         plug->rq_count = 0;
> 
> +       now = ktime_get_ns();
> +       rq_list_for_each(&plug->mq_list, rq)
> +               rq->start_time_ns = now;
> +
>         if (!plug->multiple_queues && !plug->has_elevator && !from_schedule)
> {
>                 struct request_queue *q;
> 

It's April again, and this time we're moving to 6.18.

The I/O accounting bug reported at the start of this thread is still an
issue for us, and we've been carrying the above patch for 12 months.

Digging into this a bit more, the issue appears to be big writeback
(e.g. xfsaild invoking xfs_buf_delwri_submit_nowait()), where one plug
covers hundreds of writes for around 10ms on average.

xfsaild can stay on-CPU for long stretches which leads to inflated I/O
times in /proc/diskstats. Tracing the requests shows that they're not
actually any slower than previous kernel versions -- it's purely an
accounting bug.

Of course it doesn't look to be an XFS thing. It's just tasks doing
massive writes without getting preempted/interrupted.

Any interest in merging the above patch?

Thanks,
Matt
