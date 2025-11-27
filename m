Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C0299952
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212142; cv=none; b=QanmDhvWXZYAqRlN/Tl3px7UzmBF0HkO/JgT9ReH6hE+9VZcT+YzP8xt9dzEDdG+pupci2sJ/eeUHaB7HXIICNrOO9eAC0ldYU4DIfQ0JWCADefGeMo9x/Iz49D2qY/ascHSw6OETXBEk48q62sGGDDh+rJpR6o2/ENvYksvbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212142; c=relaxed/simple;
	bh=hc6upCGkduiimowubqxotaQMqvsSIomhY2CvmHY2+hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFrur+vrKxVtYTOHXxZaMKVNpZc5jrymFqObmsty1uQLXuzcF1h/0F7pTjbIsvNirptprYyJIf52fVYRuDrcx9J4st+Z+3GfP5bNlVlifRWwUMtbBGwvnEEgs6QN9LpyQr+RqRNVZ0IQ5wnI4ZVLUETsIhyjsS9jSdabfvsbzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvD94nJY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvD94nJY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55cb8cabb4bso138644e0c.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 18:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764212140; x=1764816940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwT/yOV/Bnfn0fleHgcw4F3mp8xI9I/lnjbokhmEYgM=;
        b=lvD94nJYm4n/hpfexqziiD8UdoZnFz0ZKHiIDytG2/+TGQ99FMi8WvTSowFZsd3Gy2
         aoDPzzCZtg+l29plciu/iuzZfPYWnXPwtT4SZqKQG8e7okvuo9E312r6kcQ3T/ysNTqq
         r74ubSnlUPXqy8vR9TeNkq5ZLg52e7je4n1/H9E6SPefSShRKy/M1mM3KL3lRpHbPFWo
         jIv00EyfzPpDNzfJwF7yIMATc9SSn8ikYDCFdw+B9k38HkIjAw3OHoqOvKi2ZY8TWRBr
         sx7pRX9olzaY8oSXXuYU6RtEQUPLl2wAJivZJ3Mcdp6jYEv3nfbA24TMiifIXecrLoAD
         N0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764212140; x=1764816940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwT/yOV/Bnfn0fleHgcw4F3mp8xI9I/lnjbokhmEYgM=;
        b=U222qkY/1H8NNnf98fYGbHTIz5RMpSn0ZQC5ZXhTmCFmljvnJmZ6VYiONBtkoAdjBg
         mITIc67DTpibNNCqjsUkEUeG3KwB9nlNT0guoheCTZ0mC6URV4iur2V+OSzhmWF3kOJn
         3/NrBOAkDe4TjP6saVfzbwsk9NaKI6jpkJvGYIxgZ3oiQ82OVgxkbweARqLulWUd/FUz
         zz2/kSXzeTK/Jc2hgefb8m1O6lHwngIwq4xcLyExImqXlbUePR6xlHZoFp6Kklg0ssZr
         IQvlAbE0FQW4KBAQci27tyLRGArVO5Xgfcd2qiiprxQaY+6jAoz7TQA1pg0A3cxqoUsO
         TZDA==
X-Gm-Message-State: AOJu0YyDfLfN8OgxYyqdlPqimUinMrARNrgm5Yq+/QEt31mRXmKWz62r
	clUgSbJoBBTcxuRax2c+hZYSQybqnGxmBvVHcENp0GcONa68Nq/tBd/s+uLU1yn/kbX1Ly6QgNp
	3p3h/6Fxv04+R9bGRK9YUGo6x+AbcDz8=
X-Gm-Gg: ASbGncuCm1JSTow1lKuDUAWquCRGXccqFFN4HOB4lHYN4EDtH88W6GI+5dlJy/VvTKn
	Ihkqa5zEqFuCXzrVn8AU+xJoVLZ1+LlahBotXgYihgl0MN0KWmUtE3uzUggatmgwOOH1CJSJ329
	Gj9e0uui8EPPNAwETFXt8FWSbKK0t7XsXXh+p4rj44DaQo1gZPiIbZ+879ukba1whsIKKck1Y2t
	iOofbWmD4Pg+WNnymPSS3fSdaLXleSXPhj4T3s53dtIdth9so2fkkDFAhGH8n881ts127DDALOp
	+xYIyKo=
X-Google-Smtp-Source: AGHT+IEEIV2+8xMrCrVvbJtjrACDO/eB8FO1fZvyC96JBNc5vm1yve0mmi2aS+kXjMTk5IMnMtDwouZJPYGFZrigtuk=
X-Received: by 2002:a05:6122:130e:b0:55b:10d7:51a5 with SMTP id
 71dfb90a1353d-55b8f00df13mr6609398e0c.10.1764212140100; Wed, 26 Nov 2025
 18:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127013908.66118-1-fengnanchang@gmail.com> <448a22ed-b28d-4cf3-bb8d-956df0660533@kernel.dk>
In-Reply-To: <448a22ed-b28d-4cf3-bb8d-956df0660533@kernel.dk>
From: fengnan chang <fengnanchang@gmail.com>
Date: Thu, 27 Nov 2025 10:55:28 +0800
X-Gm-Features: AWmQ_bkty-_1v4hm3w2CVfOGdYDIhtOn_XcsDZqnSnssOYJe3qBhq4VD8fmHWGA
Message-ID: <CALWNXx9nye71NcVPSUaYVJrqZ_n2e3zE7Vpn_pzCjrKJcHVAPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] blk-mq: use array manage hctx map instead of xarray
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de, hch@lst.de, 
	Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:47=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/26/25 6:39 PM, Fengnan Chang wrote:
> > From: Fengnan Chang <changfengnan@bytedance.com>
> >
> > After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we us=
e
> > an xarray instead of array to store hctx, but in poll mode, each time
> > in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> > introduce some costs. In my test, xa_load may cost 3.8% cpu.
> >
> > After revert previous change, eliminates the overhead of xa_load and ca=
n
> > result in a 3% performance improvement.
> >
> > potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
> > avoid, same as Yu Kuai did in [1].
> >
> > [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei=
.com/
>
> What changed in v2? Neither this cover letter nor the patches have any
> mention of that.
Sorry for miss change description. Two change in V2:
1. modify synchronize_rcu() to synchronize_rcu_expedited()
2. use rcu_dereference(q->queue_hw_ctx)[id]  in queue_hctx to better read.

>
> --
> Jens Axboe
>
