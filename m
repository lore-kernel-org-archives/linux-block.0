Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F322D4D1
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747360327; cv=none; b=b0uHvw/k9ZCABUjucsbhEpFWUecCUyrHH+PuDmxhO2Xv3KXYOkfx8xOxgPArZVAFyqiWv2Vdm3ElIIbjrEDmg6/2C5OIxOlt28HrLspGcBmNkcPQlxe8EASnAft0TAH8wWYhfWv967SFT34PVC5Lm9eT+ryprTRwMseSjPUD6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747360327; c=relaxed/simple;
	bh=wf5+FbjqixvjHNb8swHNqfFvTaqSjk76G5GiXe0ZOj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7icWjvslXtUJp6B9Ugccnb0w/5nt49uESkBP/9quJKzp36vvldsw6sYV1dbj2JGoXQDfXYfbG8nWFIGr0GIm+vGdwRMWIMv2ZMWztdEZgc4XlpG/h0q8XYkl3ckZ6yKC4yei4+vurgxNojzYWfIhfL9W4gfPuKGjaulzQzo9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D6/5H8Oc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D6/5H8Oc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231c790d558so1387025ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747360324; x=1747965124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Saw/Uwc4ddbEuxXyv57Avq0Co6zLd1WCLUuinqpAosM=;
        b=D6/5H8OcVOpo+iouq04+GNXv1nL+yKTDOxpZnGYftFSYf3k5MgsM+iOiM5HshsBNw6
         PFCFjLmQtuKA8R0tQII7J1rowpfWypPBU9ZPahcst3B87qQmhvYeXHCz/zUzOLNJ1OXK
         hYdUGI80mgU2sPrzjtcKGCDMc3dlcg3DhQB6V1oM+iYTWCylLqykBrF2U3y0OyEZDIUT
         oSCfO5CAJNS5/OeYdMcu0zFToXH1+7G8TH7r4digZN0yeZet2Yf5i7w1DF5kvsKOAsab
         xUsqjjo81/en1aGO0hQgNovWoL7sgwAUQH3c994vXZkOmp2LtJzvXILb1u5RsQa5E5sD
         2jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747360324; x=1747965124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Saw/Uwc4ddbEuxXyv57Avq0Co6zLd1WCLUuinqpAosM=;
        b=E5HTa4jghJi9ZD+7EK0I6JK7aVpkizy87mcR0PJ2ehSC/NwWq6AmNIXRmbtvFNXKuE
         hAeknXGjFSCe+PBL3xUNERHX+VkkrZ1Ka9V15ndTTBin4QhIgg0JL34baAQocLzopedA
         Zz1NzOe1XnjLEF2339vWlNPDKc0pSMiCsuanQVXm3I83LL9rDG2TFhiywyoBFnypHwpi
         dJBNy46PGBONysg6S/GRUTpn6BMI/4Q4PKbxxVrD5JVpvSzrAmrgMDhd/AVl6yI7fhqN
         qULbua5OQ8LzNhCl9+0xQ89a5Dg/UxmqeDD87s4WGYcWZvkeuKdaNS5lDSnTbq3i99/A
         Mltg==
X-Forwarded-Encrypted: i=1; AJvYcCUSAIv6GG+Gfv0YB73PThGSNew/I5t0J9RNozBUD0jFHEtn0hIQYofOmTdH8gLZ5sthRsP3HjoolEf3tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFfroRlwoJx7CdC/+iea3umVdn+fxdOW2pUMyRDtIgOwASyz8
	845k1aWxYnM0SBfRLfC9/Y8W+eVqvOhDPSm+WUehgS5e0XkZ2wxi/mKQ6CjRnozrZdsr1SzCYm6
	5sEbjIwycJR1sW/a52aEUnoIwIQM8glCO1PCl3xGNZA==
X-Gm-Gg: ASbGncsNUeyS1HjRn+Dod3wPF/wXaQ//6G2vJpA/uEHV4oyVcyGf/yuHDao1bfjmdpg
	LplFhhg13XA0L9uwNvCpSZeFa4/TlsBLMQKPvhAZ+yqdzFbFG1eK+8DOLSyRb2ywvP+Ztfbeihi
	UWMw6gEO1+Na2iYLHPvfoG8uytsHPmWOc=
X-Google-Smtp-Source: AGHT+IGQtzehs6YFaC5D46agB/hXyNrQlPBTGMohxgQNZu6nJrQNEVLPxk/tps+7YlUzFXvGfuKo9R5vHj+tVoFbA5w=
X-Received: by 2002:a17:902:fc48:b0:224:88c:9255 with SMTP id
 d9443c01a7336-231d438c7f1mr7306635ad.3.1747360324208; Thu, 15 May 2025
 18:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515162601.77346-1-ming.lei@redhat.com>
In-Reply-To: <20250515162601.77346-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 15 May 2025 18:51:52 -0700
X-Gm-Features: AX0GCFs1FvuGB-BBw4L7CmJShzt8QYvuSdgfGAg-V43tZJcbKYpTw4Qe5iO7N6c
Message-ID: <CADUfDZocCU0NL6HZ+nd5VRkrKyJMNcU-xDBsvq99FiSJ=Lk90A@mail.gmail.com>
Subject: Re: [PATCH] ublk: fix dead loop when canceling io command
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:26=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Commit f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_tas=
k and ublk_cancel_cmd")
> adds request state check in ublk_cancel_cmd(), and if the request is
> started, skip canceling this uring_cmd.
>
> However, the current uring_cmd may be in ACTIVE state, without block
> request coming to the uring command. Meantime, the cached request in
> tag_set.tags[tag] is recycled and has been delivered to ublk server,
> then this uring_cmd can't be canceled.

To check my understanding, the scenario you're describing is that the
request has started but also has already been completed by the ublk
server? And this can happen because tag_set.tags[q_id]->rqs[tag] still
points to the old request even after it has completed? Reading through
blk-mq.c, that does seem possible since rqs[tag] is set in
blk_mq_start_request() but not cleared in __blk_mq_end_request().

>
> ublk requests are aborted in ublk char device release handler, which
> depends on canceling all ACTIVE uring_cmd. So cause dead loop.

Do you mean "deadlock"?

>
> Fix this issue by not taking stale request into account when canceling
> uring_cmd in ublk_cancel_cmd().
>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mruqwpf4tqenkbtgezv5oxwq7ngyq=
24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn/
> Fixes: f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_tas=
k and ublk_cancel_cmd")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f9032076bc06..dc104c025cd5 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1708,7 +1708,7 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq,=
 unsigned tag,
>          * that ublk_dispatch_req() is always called
>          */
>         req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> -       if (req && blk_mq_request_started(req))
> +       if (req && blk_mq_request_started(req) && req->tag =3D=3D tag)

Is it possible that req now belongs to a different hctx (q_id)? From a
quick reading of blk-mq.c, it looks like the hctx's requests are
always allocated from the hctx's static_rqs, so I don't think that
should be a problem. Reading req->tag here is probably racy though, as
it's written by blk_mq_rq_ctx_init(), called from
*blk_mq_alloc_request*() on the submitting task. How about checking
blk_mq_rq_state(req) =3D=3D MQ_RQ_IN_FLIGHT instead of
blk_mq_request_started(req) && req->tag =3D=3D tag?

Best,
Caleb

>                 return;
>
>         spin_lock(&ubq->cancel_lock);
> --
> 2.47.1
>
