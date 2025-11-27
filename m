Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C1125A9
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212452; cv=none; b=rbXDly9tb6Zs+4eFKooj9DPYRt38o1pK5MFCO0fGqKMds/T/xq/XChWzEesQs5kIckt8SfdHONbk0FeZZd3QrrFaCf/a0AjYgjSzhYClqjKmBcPbqlHb3hun5iMkXo1es1sYWLZhfVdRih8a7qRLAWDGAfcmXsntHcwsVFmtT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212452; c=relaxed/simple;
	bh=m0yGjP6v31pUStShPnwq+2WMOUW3WZ70btTtmI2IKmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm6TKxyp7+czK55GZTQ63dnm1xhwmfA9rGUM24SsUYh/77hkoOJDmSCWk4IFx10iBTNkJcduXX74HXy3g6MkF+j8nrRnhXEGErRSQbvUkotOVEhDEp0YeW/twkTyHEvzk4oQtzEx0WnkNQHeVbuhiJmR6UyDj5rmoKMQnV5Cvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+j6zf8S; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+j6zf8S"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5597a426807so341556e0c.2
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764212447; x=1764817247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK7QZt9H1VG1joBi2Y4otJT02WRIudnpn78bRLVMJrY=;
        b=R+j6zf8S1HrYVW/CSAnqf9xjUKeLDhead/H3rfeUwKQJVQPQd3HUyDVV+0BrMkKAlL
         pxtAPaQiRYjNm323fYvT6spNLOlWpkD/YAAvLSWMHJ9zIQjyvewIVlwCLkboVAV18pED
         ytfHHQkTGU51fYZClMepdc5ccTZRTVQL45mCzZ3nXoLryBla8s+r9y4kgav3nDIX59Ko
         sM38e3jQYkIm8+LRzSL+a5/xye1F3OgSKWOY75l0N/1PHAG7zg/Ndo8zOiOeIop1wnqC
         stMx+JEJAdD3OAilFfyylCYkOgop1KTT6XheJwxRok4tDSLqSPsu6pQ6fGewD1iOuV1W
         UY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764212447; x=1764817247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GK7QZt9H1VG1joBi2Y4otJT02WRIudnpn78bRLVMJrY=;
        b=G/H5PlScdMEufNBCdu36OOlfD34cWxNHMJRP0gLKoaVyxm3LJGI4tBoJDiijfvddRz
         f9/ICEGZJK6BpWiFGtDwJZ+j/LR3HSvHFOswUYK4CvkEPae3abU2A1S7TMXvtPEKQ4ZK
         0Si1csYXr8jdHFHpoMLc3h6iHkguhQrk/urUFcxukWNItxLd3OCF6rGYCS9W5MrFjImY
         n1Vqt3aJholYoknVd4v9kRVYN3za/bM2blww9uueg5Wnn7uR9EAXiOFTCWKe+dl1NjwA
         RMGW9ZTVNzC6FfOPUjzRvLsH8+ANtHQIX7HNOSyHuaBgfqPOTmLxhjVZVV83vstcsuAt
         JI+Q==
X-Gm-Message-State: AOJu0Yw/WUjF05tAr3bzvr+3drDPIgacFyjvJ/V7E5qwef+DsLxm5ZjE
	TQ5HckzGrWPVDNHPYFo8JKrbFSd2iCJQk4EhBKIYmxkP5/JzFVf0Hr+Fe5ZvoJHQpXxke6KHbrx
	qEv4OyzPH4++Akh3lojh2UBV25tNl5AA=
X-Gm-Gg: ASbGnct2Dsz1iQ7V1mieFnMwnOomn9I6AcRwmv63XwIZhVDnmcSoxBJUefq2URXyaDK
	4ireXyMolzX323T4SyIQwl+Y7EDyrGPxooC5rEQQhnjUkb8yOxJnaJ6qufHIY3uGbGfJIhwklI2
	rlcsQ/wkt0dOB4d4+sWJ4vNAZVuW8IWnrhEydYFP72J5brDB8JwzgYXo8vnbV/rkHD9BJyze/up
	yNc6kepNgmQoOay6S2MRNqrh13CGRm7pwXCqlnrzvNXZYKLn8guIIyR1XMrYhZ7Gp+xxhuH
X-Google-Smtp-Source: AGHT+IEPMq1sYDJkwllln6+aCMDhOEMp2wyaIU++RZKnVmU+GzIZMcFkyhljT8HNKIAH9k/pJn/bYFLjE79gSPxkNlY=
X-Received: by 2002:a05:6122:6602:b0:559:ed61:4693 with SMTP id
 71dfb90a1353d-55b8eff01fcmr8502194e0c.10.1764212447494; Wed, 26 Nov 2025
 19:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127013908.66118-1-fengnanchang@gmail.com> <f7a406c0-ca24-4367-9e0d-fb7bfe91df3d@kernel.dk>
In-Reply-To: <f7a406c0-ca24-4367-9e0d-fb7bfe91df3d@kernel.dk>
From: fengnan chang <fengnanchang@gmail.com>
Date: Thu, 27 Nov 2025 11:00:36 +0800
X-Gm-Features: AWmQ_bn6lY8kIktt3eGWE0Q6QmoKY2_22wGOs7_HjiK_zbL1ciLMmPbRnvX5gHo
Message-ID: <CALWNXx8r8_Bh5ySPAm4GSWAm=OHXc4o9ta4Sf042hMmacwt0QQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] blk-mq: use array manage hctx map instead of xarray
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de, hch@lst.de, 
	Fengnan Chang <changfengnan@bytedance.com>, Yu Kuai <yukuai@fnnas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:49=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
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
> >
> > Fengnan Chang (2):
> >   blk-mq: use array manage hctx map instead of xarray
> >   blk-mq: fix potential uaf for 'queue_hw_ctx'
> >
> >  block/blk-mq-tag.c     |  2 +-
> >  block/blk-mq.c         | 63 ++++++++++++++++++++++++++++--------------
> >  block/blk-mq.h         | 13 ++++++++-
> >  include/linux/blk-mq.h |  3 +-
> >  include/linux/blkdev.h |  2 +-
> >  5 files changed, 58 insertions(+), 25 deletions(-)
> >
> >
> > base-commit: 4941a17751c99e17422be743c02c923ad706f888
>
> Adding correct Yu address, was also wrong for v1 and somehow not
> corrected?
I didn't notice this, the error message was blocked in the spam folder.

>
> --
> Jens Axboe
>
