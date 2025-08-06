Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCDA165F16;
	Wed,  6 Aug 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466782; cv=none; b=ntqKvhRBgUsMcFYcwD9njlnpvqTaVE9cm92TEGZRoaxCrWvE57rsPd6Zo21cl/1aBI5KSAivnAhJjLBS2TIqY27Q15l9o2uApULnNKuQIshYEn837EU+two6p4xM4+55+E5nlDWL3ifBY8avPB9w0mM5KVlp9ejRwXgHW7s4hKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466782; c=relaxed/simple;
	bh=vjZ/PYynVitpivwcFOEElnXTe3L6l9h3Id1OlE3ktkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry0efrCwYV2ylGhLnHlztq3Ty8KdXLK3o/wEOEsQO/cfK8R+omZMOTKjpaNZzDLKGOpQ7tvPq77tERYvpIUnTGkJjDhqK2V4p7tylVa/8riHDIsy9ka9lc2cmm9XtIjLJFRlQ+KbqMedDd5KdYwZ2luONg46QWVhYYUqgefqjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOdLjmvJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOdLjmvJ"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b9375d703so5786592e87.3;
        Wed, 06 Aug 2025 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754466779; x=1755071579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT5DXR7bSWks+fi2UKXqjA8U5I349zMTjxariW2ArL0=;
        b=iOdLjmvJBryr8B0YlJUR/K+SRMEjaliRnzaR2lSXC2pmwIprQYwQMV8aUGkszoyVfo
         AbVpiyPtw/52p4OiL3B5uBTOrfhqQKUou25KCXi1k+2WB9iHeyGHBBufgewidGia9SrR
         RXt800ETO+Lvd9sNl7fylapyOupI6f2eibgWY17oZnZGSFAphD61avzC9+cIRy5GsNwV
         iil/TWezUYYKFImNAyUi+kTbRzm8lGomL6rYggpEo4sWwsclvSBYTf0P/gPVWC9c0rT8
         Vd0GeKDkkwD9dE2GwtST9xVDbOE0HjqWhRAPlkKd+PnUOI4uSMJnlA7lNJlH+lGJyi0i
         As6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754466779; x=1755071579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT5DXR7bSWks+fi2UKXqjA8U5I349zMTjxariW2ArL0=;
        b=FHormx0JsPo+Tr8AlFkdTHHqBCnMBl50T3ONKRlplZLtfsGLYYZSkcEWPAbVCZs2Wa
         SkwyWrezWs9D107/BxdKHqVjnVfXnv7mDRb+qWk8oHWMO132QKApDzy3yHV/EQ6Q3Zak
         RdnNQYEPedmlQbZEdxugFaVABEEmMPHUXqM7DIcJuoFSGnzUp0NXfPp+/QkxDE3z8h6U
         WFrtL/UELNbnyJGsuUwIO11MI4VWJiWD8RxcAJeMGez4Zvgm82njPCUYzVwxCk7CB//R
         tyjbb1hFU57oRFUXZCDvRRXwx4e2EFbLbDDNeboMp6woPcD26fod3KiW03m+lWRLKDhP
         X5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU3la6daqyIZNkfOm6/E4w+MCDKk6yfjiie7WDsxUw70MSgL9QzpTIxR1kllJtLYrzOqCGEBNtqt1LU/w==@vger.kernel.org, AJvYcCVboo+exeCVXlehb5Vp01c6ztFS1k4BnvrxII6Wa0prxQy5eMyItYcGi84C3O/fC0echrKPL7FL@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsibLXzUtSubCGIjMmnkd0Qt15tEy2fKVYo3GJNgg566LJrof
	jDsCmy0DsJT11mWxIlN455eWwlUXZm/rI7xse36dRaoVlzWrcxUKdyWUPqL6nqpU0xZBN3/U9bY
	iBrWmWFRht9w4VQxioZKYp3xu/4asAms=
X-Gm-Gg: ASbGnctuPfzaq4BheKr25Wej3AgOJcqUCvy/qCb4cmnYhN6rBOBrcK+X8NDpj5NC05v
	hOW7NdYSbrdUJ7qRWpT+/CPc1Q7uG0/vqRhXMb6kt9UmHe2+a1V8ZFsKYD9WEyrhBhc1vUn7d8v
	V9plWQEZxiUeLPAIuLS6QgZCTkdtEjrbNJoEeP4IfGZbDYX/hoj55Jr/h862wIeEbUnMzj6hmpA
	VLLqfn24lq7xr/RRrKY
X-Google-Smtp-Source: AGHT+IE5E8cOvYb5M5skNhZ3L3p4c7HWEpFb1WmaEz8dsZdWMxoaZAvgxc1BlF4riOoUQ5vgDUsNWk/0+d8tVrw9ZdI=
X-Received: by 2002:a05:6512:3c94:b0:55b:9460:efeb with SMTP id
 2adb3069b0e04-55caf37baf0mr591064e87.15.1754466778443; Wed, 06 Aug 2025
 00:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731123319.1271527-1-sunjunchao@bytedance.com>
 <CAOB9oOZV5ObqvgNxr9m0ztm7ruM9N9RMi8QHmiG5WL4sNbLxuw@mail.gmail.com> <2ca5109a-341c-497a-9da7-422d56620348@kernel.org>
In-Reply-To: <2ca5109a-341c-497a-9da7-422d56620348@kernel.org>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 6 Aug 2025 15:52:47 +0800
X-Gm-Features: Ac12FXw9yKDnQmzMmMHqXpyf8YxkO9lGnOzN-NTE6KMNrwXMyX01kVReky1R61M
Message-ID: <CAHB1Naip80KUc-AQxYgBzQqSntgDk8A5tWzkA_Zk8bs67Sjwqg@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: Fix io starvation in wbt_rqw_done()
To: yukuai@kernel.org
Cc: Yizhou Tang <tangyeechou@gmail.com>, linux-block@vger.kernel.org, axboe@kernel.dk, 
	stable@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 1, 2025 at 1:13=E2=80=AFAM Yu Kuai <yukuai@kernel.org> wrote:
>
> Hi,
>
> =E5=9C=A8 2025/7/31 23:40, Yizhou Tang =E5=86=99=E9=81=93:
> > Hi Julian,
> >
> > On Thu, Jul 31, 2025 at 8:33=E2=80=AFPM Julian Sun <sunjunchao2870@gmai=
l.com> wrote:
> >> Recently, we encountered the following hungtask:
> >>
> >> INFO: task kworker/11:2:2981147 blocked for more than 6266 seconds
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
> >> kworker/11:2    D    0 2981147      2 0x80004000
> >> Workqueue: cgroup_destroy css_free_rwork_fn
> >> Call Trace:
> >>   __schedule+0x934/0xe10
> >>   schedule+0x40/0xb0
> >>   wb_wait_for_completion+0x52/0x80
> > I don=E2=80=99t see __wbt_wait() or rq_qos_wait() here, so I suspect th=
is call
> > stack is not directly related to wbt.
> >
> >
> >>   ? finish_wait+0x80/0x80
> >>   mem_cgroup_css_free+0x3a/0x1b0
> >>   css_free_rwork_fn+0x42/0x380
> >>   process_one_work+0x1a2/0x360
> >>   worker_thread+0x30/0x390
> >>   ? create_worker+0x1a0/0x1a0
> >>   kthread+0x110/0x130
> >>   ? __kthread_cancel_work+0x40/0x40
> >>   ret_from_fork+0x1f/0x30
> This is writeback cgroup is waiting for writeback to be done, if you
> figured out
> they are throttled by wbt, you need to explain clearly, and it's very
> important to
> provide evidence to support your analysis. However, the following
> analysis is
> a mess :(
Thanks for the detailed review.
Yes, the description is a bit confusing. I will take a more detailed
look at the on-site information.
> >>
> >> This is because the writeback thread has been continuously and repeate=
dly
> >> throttled by wbt, but at the same time, the writes of another thread
> >> proceed quite smoothly.
> >> After debugging, I believe it is caused by the following reasons.
> >>
> >> When thread A is blocked by wbt, the I/O issued by thread B will
> >> use a deeper queue depth(rwb->rq_depth.max_depth) because it
> >> meets the conditions of wb_recent_wait(), thus allowing thread B's
> >> I/O to be issued smoothly and resulting in the inflight I/O of wbt
> >> remaining relatively high.
> >>
> >> However, when I/O completes, due to the high inflight I/O of wbt,
> >> the condition "limit - inflight >=3D rwb->wb_background / 2"
> >> in wbt_rqw_done() cannot be satisfied, causing thread A's I/O
> >> to remain unable to be woken up.
> >  From your description above, it seems you're suggesting that if A is
> > throttled by wbt, then a writer B on the same device could
> > continuously starve A.
> > This situation is not possible =E2=80=94 please refer to rq_qos_wait():=
 if A
> > is already sleeping, then when B calls wq_has_sleeper(), it will
> > detect A=E2=80=99s presence, meaning B will also be throttled.
> Yes, there are three rq_wait in wbt, and each one is FIFO. It will be
> possible
> if  A is backgroup, and B is swap.
> >
> > Thanks,
> > Yi
> >
> >> Some on-site information:
> >>
> >>>>> rwb.rq_depth.max_depth
> >> (unsigned int)48
> >>>>> rqw.inflight.counter.value_()
> >> 44
> >>>>> rqw.inflight.counter.value_()
> >> 35
> >>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> >> (unsigned long)3
> >>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> >> (unsigned long)2
> >>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> >> (unsigned long)20
> >>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> >> (unsigned long)12
> >>
> >> cat wb_normal
> >> 24
> >> cat wb_background
> >> 12
> >>
> >> To fix this issue, we can use max_depth in wbt_rqw_done(), so that
> >> the handling of wb_recent_wait by wbt_rqw_done() and get_limit()
> >> will also be consistent, which is more reasonable.
> Are you able to reproduce this problem, and give this patch a test before
> you send it?
>
> Thanks,
> Kuai
> >>
> >> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> >> Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
> >> ---
> >>   block/blk-wbt.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> >> index a50d4cd55f41..d6a2782d442f 100644
> >> --- a/block/blk-wbt.c
> >> +++ b/block/blk-wbt.c
> >> @@ -210,6 +210,8 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct=
 rq_wait *rqw,
> >>          else if (blk_queue_write_cache(rwb->rqos.disk->queue) &&
> >>                   !wb_recent_wait(rwb))
> >>                  limit =3D 0;
> >> +       else if (wb_recent_wait(rwb))
> >> +               limit =3D rwb->rq_depth.max_depth;
> >>          else
> >>                  limit =3D rwb->wb_normal;
> >>
> >> --
> >> 2.20.1
> >>
> >>
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>
