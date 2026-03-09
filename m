Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214983C1F
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100955; cv=none; b=UB3KgcQBCZJwsxb3eA5SXoHdsyih3eSIQyACuhd69A2/fSVEId2TFxS2Sn2QpVIx/AJixlow+11vOryfKZYnqdzUGTpPBZYFuesxLRXBzPNgutVI9jnn4A7YCuJRh8FGsTRYCvA3SUdutji7fkn2qV6+zGMQnyieHwnWtTpHzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100955; c=relaxed/simple;
	bh=6Vofe/6ZWdzfe1bQhwcok7tc5hua1lVSK0g1U2J3b8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erdNGP/dLV7vptnTHabZ1pqHL9BvOsAvc5bs2Zvkr9kXHfyaA/wr0q+yugdC0WwDA+PD75xCpRiQSXKsS+z5q1Yx2xec5bjOmoxs69S+uZWJ4cmKjo9QZb3KYo9XrE00GkTK02EtqkvfXlhgWf7A/l6p94RgmTMUytQvbVaCnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9358dd7f79so969198066b.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 17:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100952; x=1773705752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUJ62UzriDRExITrg9iBzNvEWYzDINBTrPfASD/nLws=;
        b=u056Px5jtq44HQqVF1JxAmqJpormOientetsUBiU6KcEAwr+9DzuflNLurOvg134ww
         fQQo9YWC43psfphKubiypwBljvuR/X8gcUfkDYbGsr1Ma34/itHgK4kVAR3H7XoR4tPq
         rGWPQ/B89lK8gFVnrKj3Pn/yBbTv5r9d+2sS3JGH4IN/Xx0ZOqZdoe4XZeZMTpVWbTJW
         foEVbl+L78WDkSdyY2SML89Fbl3h3B/GTsJsPaaJy1hip9yYl38RWHbq53jIlz0IC6ig
         TTxyf3nIOWlQkziT7Vmv+EHgrCvLCuk6y/Apq0OtSEHc1Kg3bP/RQ1wbaNBSqv7Wtdn7
         kT+w==
X-Forwarded-Encrypted: i=1; AJvYcCXrfV4jfLIEZ4+hAkYQvdZenRUn/tfdVSkFd38uCiA7ZCiBWApHe31gG1VYpbWbWWGeQJ4OvRNGtI+U6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBplruSwM+wFzbkhOn9UiYtYY/v+gPPdApWi6oCais28JGqIQ+
	qrvieDs7GAZJbU5j2ouNOHr0ZUzO4pNbjtsvJ+5IJjn75CJKT3hBPdUsTMMV0CSBf2+v5For
X-Gm-Gg: ATEYQzyAOLxOMX8uJRaG5h67v4h+DJN/TZFNbPxWqAMxJh80WRPR/vHQaAaSIelkG1O
	fLIlCSkyFYxzqLZue51o5IgsXyiSb5Pe9pnMKf5D/8p9gBTjqht/kkI9p41JjY2aPkhrt2Hx+6y
	UPbNwRvbXZcEzELo+VVwTtY0WhKvXPv4MEjMgiFanWO7ntAv4vJxuTzDT3pM0LRtZDil4LlVlFp
	y2ASGx+AuXPrspAgxjuCWK/jfk4kbLBexHsWduhSUDaR/mzbRnj8SFMvN+yoCdIb5XbMxPdFGUh
	gDoCzcxeDorLiw6UJCz3OY0qvI2ymb7ImMs0dRRCGyAc3006XS18GiHQjT8Ju7axN6tMeIdPwdd
	B7pne5ZR5eUAmZCwLZ+/8hrH1m/dVr/4dXMVqNix8UTL7ro9kT7RGc1tyyTZgBy/sLguxqgDJMy
	HemooQtoZ2nK5cRC2eTk+PMoE574KVPigEYXf0GRC26X5aUnoKVXZz/AQ=
X-Received: by 2002:a17:907:3d89:b0:b8e:5e2:79fc with SMTP id a640c23a62f3a-b942dba6626mr744267166b.14.1773100952182;
        Mon, 09 Mar 2026 17:02:32 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f189de1sm424918466b.63.2026.03.09.17.02.31
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:02:31 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so5723585a12.2
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 17:02:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY0EEiJsdMAr2Pjjblk2H/uslloXmZalo2FWyzUoNRmudcdeDK8bqGT27qIgGSfWI6Tgd9DIurxz8fMg==@vger.kernel.org
X-Received: by 2002:a05:6000:144b:b0:439:ac33:5082 with SMTP id
 ffacd0b85a97d-439da66b72cmr23928350f8f.26.1773100503051; Mon, 09 Mar 2026
 16:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
In-Reply-To: <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 19:54:47 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
X-Gm-Features: AaiRm53vE5uEinTHUYE1aa6bIvdkwyOpz0dn9fOlsjLR4PN8Z_3w05vllGJ47mw
Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
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

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result,
> > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
>
> The node argument to blk_mq_alloc_hctx() comes from
> blk_mq_alloc_and_init_hctx(), which is called by
> blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set,
> i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> doesn't find any CPU affinitized to the queue. Is that even possible?

Thanks for your review, Celeb.

blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
exceed the
number of CPUs. Afterward, it is adjusted on the caller side to
numa_node =3D set->numa_node.

set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
proximity information.
But I'm not sure if this is usual in the real machines. We found the
crash in QEMU.

> >  static struct nvme_descriptor_pools *
> > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
> > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> >  {
> > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[=
numa_node];
> > +       struct nvme_descriptor_pools *pools;
> >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> >
> > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > +       else
> > +               pools =3D &dev->descriptor_pools[numa_node];
>
> Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id();
>

Thanks, I will modify it in V2.

Sungwoo.
