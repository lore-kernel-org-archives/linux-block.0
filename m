Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF126B0A9
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405524; cv=none; b=F0cGenLB5Qltyy31f/bU+2TsqsqbI9h1w9yApRtDBXIPsJJ9pm0u/xZXnZgOiiA0WmFVp0FZUC0At4uRR+eWcQdbDrLJdKEAfVgZZDWyb8l42oPxZ7nwzxEPLxTlGjOkkjdZYN8+ztyU5hk2f/YLMyABPlevVwW9ydWZPSSX7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405524; c=relaxed/simple;
	bh=2F36LOlrnYgPW+20PAv1FMuxvBNKqoBjcgw/bp9pnBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeQOo03xYezl+0uQznQu3mHjxLTUC+2jiHE+ryLTIjDp7hRzXIfeGFp52w4bAJGI7QzEDCr0tErpb8jDRbkmQhx0D2PJIF+OoDeZSg+3OAa02hg4lF1E81xfHPF9QkA2Dj8H5qD/eS+4e1WNUvqaiOoWztvp8guQuei1QR0Cr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DntL0SC+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DntL0SC+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1017364366b.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745405520; x=1746010320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zFO2mmTugaYerF/bVgaeCak/CfVfIQBIS6clL7bKh/Y=;
        b=DntL0SC+b7F3f9EXZqzvb0ezIHqQCid+R8PWFcfxbpFWXyTIdX1UWTLZ/9BGvYovFj
         5vyRNLM9OZ94RkMc8XiNYnhy3WoQzYRUWLU88IOW+3A8/teoU/8jMfmUXW2K26kT28Yi
         YDn++RnlWxuszJ+4nYso5EIvG6ugMCZIcNIE0qbXjKascooFfP4mT3BSfNPUNhNUdcld
         Ou54gs9kFQwLAJymJXVOckp0aRamyUDvCwcjlAeV3oyYFIZ01iUGR3IgbNjndc6rpy4/
         SqsVU3olACa+bTHmo8ONbk2nmev/E7vzeP7Ue290xvPW5zEHR5CbsUDnKqZFpRD2SGSo
         sh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745405520; x=1746010320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFO2mmTugaYerF/bVgaeCak/CfVfIQBIS6clL7bKh/Y=;
        b=eNN6mSttdO4i4IiSJ0TLp3ZaOJqpGDibjg/hUslgy+sXe+B18tTH5rEc2NHhjo6+Hd
         X5QBl+KJwdbjTwr+ZDEMcjETIYFYUb/IU6hl4gRivJMQaa8sKlRHPb3rq9M9dbM1sLQw
         5kx6zE3xUcFm+qMGIWOq9QUaVkqvb7m2nbkCOyS/a1JCbSUjv5GBX28pQdjF9pwWQDjd
         M8dkC+9PJfdd5BqVaCeSrc3hL+ze5w1JSg8SG32fV1/+O2iquOyvYv1OrSBDeU7zck6I
         mo6n6eb1e3ZIrHERN4hrWD0UGe92MumzzXHnrj/nswjZugMFSSUShbWZq7Sn7ktlBzg2
         3ulQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBNwGyG5W/EpHtAONrgQHhY2NW4P3INQ07D3D+8y4ZLASw72O/y3/XUhnT5tlnR1hwyVOzpO65sqUNJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqv4aCkgBicuX8JLQv9bneVjKQ5VIbsyWBqpSWr8MqsxNnlAoZ
	hVkgdPmqNLFRWz/UI210/WGSL+ovLyI9qs86wR/tPGvvVlw4kKlB0BvWcA4Ftb/GDP/fAN+nHKs
	dQPynbnntHV/t6qq+fyiX7qBDQW2/nO/L19o9pw==
X-Gm-Gg: ASbGnctyldybZ8M3S1Orx2OQmt4wHhlu/NFiLLnIltdtlCc68YVh1fPeB7CZLhuuSh7
	Io8bhT9zhrLC3J50OONY27kH5lAaBD5jMPTMvVd2DIUgikEKmIPHQb/82dpISRhr329j0vqZfIC
	5fHYAGMEmytbOBuRNIEhq62aicHE1+G5GL+QPANQ==
X-Google-Smtp-Source: AGHT+IE/6pYUsMYMqhI2sEYVYX9i4m5CojtOxAROai1tsh+YLxDn4eQAJh180vtKXL3rYE+ymaXy85dh6zaYjIY7VKo=
X-Received: by 2002:a17:907:7e84:b0:ac7:6222:4869 with SMTP id
 a640c23a62f3a-acb74dbf2demr1572534466b.37.1745405520636; Wed, 23 Apr 2025
 03:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>
In-Reply-To: <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Wed, 23 Apr 2025 11:51:49 +0100
X-Gm-Features: ATxdqUHvdxhkEJsQjh9v6htOzoAzXGkLqhK6uEUE3jiVW8bPlhzCFKk6UwnvJNs
Message-ID: <CAGis_TWtWMK93nVBa_D_Y2D3Su8x_dDNwNw9h=v=8zoaHuAXBA@mail.gmail.com>
Subject: Re: 10x I/O await times in 6.12
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 13:21, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Can you drop this expensive bpftrace script which might affect IO
> performance, and replace __submit_bio directly to __blk_flush_plug? If
> nsecs - plug->cur_ktime is still milliseconds, can you check if the
> following patch can fix your problem?

Yep, the below patch fixes the regression and restores I/O wait times
that are comparable to 6.6. Thanks!

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae8494d88897..37197502147e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1095,7 +1095,9 @@ static inline void blk_account_io_start(struct
> request *req)
>                  return;
>
>          req->rq_flags |= RQF_IO_STAT;
> -       req->start_time_ns = blk_time_get_ns();
> +
> +       if (!current->plug)
> +               req->start_time_ns = blk_time_get_ns();
>
>          /*
>           * All non-passthrough requests are created from a bio with one
> @@ -2874,6 +2876,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,
> bool from_schedule)
>   {
>          struct request *rq;
>          unsigned int depth;
> +       u64 now;
>
>          /*
>           * We may have been called recursively midway through handling
> @@ -2887,6 +2890,10 @@ void blk_mq_flush_plug_list(struct blk_plug
> *plug, bool from_schedule)
>          depth = plug->rq_count;
>          plug->rq_count = 0;
>
> +       now = ktime_get_ns();
> +       rq_list_for_each(&plug->mq_list, rq)
> +               rq->start_time_ns = now;
> +
>          if (!plug->multiple_queues && !plug->has_elevator &&
> !from_schedule) {
>                  struct request_queue *q;
>
