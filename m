Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9C1FDE35
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272604; cv=none; b=eWZTgnG9Vheh6XfDprvqKS93LN3AD7Q4mnkbNgotMnzuwdoBAxzBlv9aADtEoqAz7Xi5ibVbg+IzSobAmLMtTiuopTdPlikP0+0NE16ZdJnKAgIrNiWPXfWG8AifDLw5C2qx7P5l2+/J7GvY973VXVMcNk4b9PhFxrAQqWzr+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272604; c=relaxed/simple;
	bh=v6L7VWSJIgACPa8S6DIWjcCyagnzXKIIU0w7JFQudHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCphthhhneJqZsiHs4sx+gsbaxB/QL1hrYSGc3yOygGqybpCFNtIVcV9kyu7GK2CAE7oBIDwk+dr/8uCrRXBcOmZKLuK1Kze9neIlPK2iQ+41zQaNHmEdWcdxjq+UaSJKWcud02xhx4o5JVcAVW9/7XRXYyNaMBGXWytIBaxqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxagR+QM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxagR+QM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJzAfhES749wOpuO+4y/0ItmENS5B4AmLoraCFDO8CM=;
	b=AxagR+QM9UuC4UClBkxpRUCfG5fFFwVFo86dOJPuYddPju40amo+Xnsq80kRtOuSo5K9Pl
	+3Wf4O0Ml9l9JmgZdOiUOf4Qv0AMgN05Jf4qk2lXiyhS56RuMC6cYsEkZ3nkFZyo/cvCeu
	wtDaFJrzQykUDYAzR3yt8lFqj9Hy8wo=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-qYWWULzEORyMXtJqfJzxmQ-1; Tue, 11 Feb 2025 06:16:40 -0500
X-MC-Unique: qYWWULzEORyMXtJqfJzxmQ-1
X-Mimecast-MFC-AGG-ID: qYWWULzEORyMXtJqfJzxmQ
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8670b638a1bso3083182241.1
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 03:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272600; x=1739877400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJzAfhES749wOpuO+4y/0ItmENS5B4AmLoraCFDO8CM=;
        b=a4Wfl4AMkEl9k7+o+JylSIbirTBJh1/xGgkkzyWq8NzCpREu4FZz8Fvz0ReU14xpEv
         xixHJCQDB6h2/zqwgbdhQpfFk1T+x2X7j6s0ODiITSvfQRa1BustcgF9a0K9c2RV8eeq
         5iQmkI6NpEl4zCDShSR6VCKUniL82OSzKggbQrlRhnXVuihmQLO7pPuF6/euzhnAncJ5
         0DugxSk1LudSvqUWLSo8bsj78qI4nXbP8DalxYq3wn7l+4VIUdQYuYqp5/W6YHRbp71G
         nkyhE5idKQGNRnI5IXGkBCuVx5MxoumIUltCuqKTDewe1Sf9MUCyzR9/S9iTTSiqDTUC
         Tuvg==
X-Forwarded-Encrypted: i=1; AJvYcCVct0i0iZResP6LWHtMNugTZMbSFUnJPRKX9zPJx6Xdhxr8KuQDZDotoI+fNmRM1YcFhMjRFHvvcocSOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVQOl2awoYiRsy7m52h10i2HUorxU7wqK7Ig/cdPmH97PMDQI
	w7zVIqVRFa0ZC+6Pl2xTkwSDhwTHDYgG6Sh9soxVidjAAMVJ80IQDEcWfwMfzn0SXPcQn/aiYoA
	RZeCt3OgbTrU888N4GZGTWnfGsngyBxq6rwFs2sOlLq81+erkL+4uVGhsfhOG57Rm4wbTB4lAv5
	45I/HlFL4vcShVsHfcV+Pzg3M1Y8+JL4yPAvM=
X-Gm-Gg: ASbGncsfpoLRKS/hBmo0J/lYWV+Xtl3uRrxAXA0oGnzuuq3CPxvsp1lPjnPkoBetPdC
	OqAIbv6G5Bp/DRB1nN0NKgZlN9RcSh4SLJuo0PncR73X/TfwZb2zesAw0iqfpBSI=
X-Received: by 2002:a67:f1d9:0:b0:4bb:b7ff:c486 with SMTP id ada2fe7eead31-4bbe13fa999mr1292522137.12.1739272599838;
        Tue, 11 Feb 2025 03:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuw4bDbKers2LBOjUPf1ci4KK3E01ua+qHdVX73SzcwbkcrnzDIc9zvq+RgnUVg0CSnXmq1xV980CN5J8Ylpw=
X-Received: by 2002:a67:f1d9:0:b0:4bb:b7ff:c486 with SMTP id
 ada2fe7eead31-4bbe13fa999mr1292516137.12.1739272599589; Tue, 11 Feb 2025
 03:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207091942.3966756-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20250207091942.3966756-1-zhaoyang.huang@unisoc.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 11 Feb 2025 19:16:28 +0800
X-Gm-Features: AWEUYZngUiVZpgpKMHf6EzK6vzeOH3hPqlgk_AbWr9mji6vpkgOsm0DXze0RF8A
Message-ID: <CAFj5m9+77j1Y3nNkxqhCcJ5XN719723iudjKVYDsppWfy7sWfQ@mail.gmail.com>
Subject: Re: [PATCH] driver: block: release the lo_work_lock before queue_work
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:20=E2=80=AFPM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> queue_work could spin on wq->cpu_pwq->pool->lock which could lead to
> concurrent loop_process_work failed on lo_work_lock contention and
> increase the request latency. Remove this combination by moving the
> lock release ahead of queue_work.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 8f6761c27c68..33e31cd95953 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -890,8 +890,8 @@ static void loop_queue_work(struct loop_device *lo, s=
truct loop_cmd *cmd)
>                 cmd_list =3D &lo->rootcg_cmd_list;
>         }
>         list_add_tail(&cmd->list_entry, cmd_list);
> -       queue_work(lo->workqueue, work);
>         spin_unlock_irq(&lo->lo_work_lock);
> +       queue_work(lo->workqueue, work);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

