Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417823EAB2
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192017; cv=none; b=FY8z00pAuOVlKSl1rMQygpJQpALnMvj2/ze1+Xf1VUc5qXhthR8OXKoNSTtmHbQfV5eX9+lPEpRTd0aH9WZ6MdlCNSgq61ASc4VfLtXMZa/Ebb3YOz5MrQpCRgxREeXj1Uyrkg1+okBe+Cvpj3lGAkUk3EtJ+6ZBv4RasB5g19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192017; c=relaxed/simple;
	bh=/oF/doq6oyWwDTCyW1l4hS1E5POtzgyvQYrb/7hmVZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgb/0iSyDnWEsshRVMUvOdjVH6E/mQel/bBGxUKwT9yuNB6LwROxNphlqfmCiqjaRzvKEIAu2NbOKg9PhiyqG7QgFMMwOVjQhF44wkAPlngvG2Ywz6mO/aVwG4b3zngTfOOp49WJuE1JK1k+vuxQfZkEcs3ox7h6+/+YzuuJgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b93698bb57aso77363766b.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 18:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192015; x=1773796815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oF/doq6oyWwDTCyW1l4hS1E5POtzgyvQYrb/7hmVZg=;
        b=qLMKzb8o11uiPssH8LMKNW0MY3mo2jjeXB9+j2PmJCRv1hay2s83hcpHli8eVcZZ3H
         NBetPOsi5vVNFIjNONlhI2EbbaHdK/pD0X0hMy9w93vgsnoP3lZLPIE5oy0YU+o7d5qB
         RCpI1t+Llx2m7W88UkjaY42PPzyahDTWa8vjCtMGjjD39WrPQphMnZaKli+DzedFVU3D
         0GcRXemDM4hYZIJWuc3mi5eaanoojs/GlsIVdEANKgL8ImcuM10J1f4rrs3ESquM39Az
         7cJm4E5O4BMsiCVPx3LUUw/JWtwfg/K6GP//5BisRDyu/pGUzasdpMhaKZYPUB/Wj10L
         j+ng==
X-Forwarded-Encrypted: i=1; AJvYcCWfIWGDnNTnX8NQMwVdR5CukfBB+NhrHe43o/jsHJVyO9OdI2cXUusNnOrMbph3vMBUnxSxJbJIyCRfVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8E1AB0JcyXOS7AjTKpbcVq9YtVQmUfVfDe51WlF/itSXonFb6
	6AFknomnzlhzXwsFtgibIjbBqZBrd2z9Tt01WpwoA5pwDWyFvaHa6fJmWyQPMuNQOxciSg==
X-Gm-Gg: ATEYQzwhpQN6SsOeCTK1vv9cPU9RrkcZCmcJgzlAjHy35Bh13y1kVYgHMLIX109fB7F
	hA8vsto6Lff0u2sCjY2XwUWxwJ2x2W6emQVDN/iqqWrMdu/qbzNtdw/0HE/HeqOLTxLY7CvdnBi
	yq5CYtxP1gkqvnblhDBv9lNNwcCHO/IqKcWmwaBYX1uxNxmNukdfNsNOXNS2YWPzHVjJ1nmmgTA
	s892nK+SL0YbnpM0t2TRKK5LsOfdRoule6eaP3laz27N1YNO+xTXSLWIEL+FlLjNg3oyoONEUBs
	zrkktHvHhhAy6hjF+49yQXsKTVQ5PeYuEXQx4ZUpA5rXgL3rnTisdR8nlzxDiyPgYcFph50XCck
	qp76Tedt39ODyqjhX+cHrLq5C28tdcJdlTTnrNgPf2EdiLPY2hOX9OMcqQgn8wFAIoJvccotWOC
	UxE9uC35qC15xj9kckf/r4ABBWFvS+O5P0lopWCWHuK6gztyxFVquBt1M=
X-Received: by 2002:a17:907:5c3:b0:b8f:c684:db37 with SMTP id a640c23a62f3a-b972d5246afmr35445466b.9.1773192014571;
        Tue, 10 Mar 2026 18:20:14 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de48423sm17526666b.19.2026.03.10.18.20.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 18:20:14 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b93698bb57aso77362466b.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 18:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNF/9w7HNaKPdGLqCDfqCHi4x0Mil1W5rgQGXsy99zcM8+1rOjeKLqVt/fXSwNTWuxG/EsvHtHsSfdjw==@vger.kernel.org
X-Received: by 2002:a5d:5d05:0:b0:439:bb46:7457 with SMTP id
 ffacd0b85a97d-439eff518c7mr10359487f8f.16.1773191708627; Tue, 10 Mar 2026
 18:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
 <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com> <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
In-Reply-To: <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 10 Mar 2026 21:14:52 -0400
X-Gmail-Original-Message-ID: <CAJNyHpLU7sTJRtDqTbczTz0iayj-Nm8bPHrPaOcsKVb6nQyw1A@mail.gmail.com>
X-Gm-Features: AaiRm51cz7xo1V1erpi09gKFdY9TTILawmEFCzQE55oadwxdss7qBUImRUPZq3I
Message-ID: <CAJNyHpLU7sTJRtDqTbczTz0iayj-Nm8bPHrPaOcsKVb6nQyw1A@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
> >
> > On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim=
> wrote:
> > > >
> > > > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > > > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a resu=
lt,
> > > > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx(=
).
> > >
> > > The node argument to blk_mq_alloc_hctx() comes from
> > > blk_mq_alloc_and_init_hctx(), which is called by
> > > blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(s=
et,
> > > i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node(=
)
> > > doesn't find any CPU affinitized to the queue. Is that even possible?
> >
> > Thanks for your review, Celeb.
>
> While I'm flattered you consider me a celebrity, my name is Caleb :)

My apologies, Caleb. I'll be more careful.

>
> >
> > blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
> > exceed the
> > number of CPUs. Afterward, it is adjusted on the caller side to
> > numa_node =3D set->numa_node.
>
> I thought the NVMe driver capped the number of queues so every queue
> is affinitized to some CPU (see nvme_max_io_queues()). What am I
> missing?
>
> Best,
> Caleb

You are right, every hw queue should be affinitized. It seems I'm
missing a lot. I'll look into the reasons and get back with V2.

I appreciate your review again.

Sungwoo.
