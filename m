Received: from sg-1-110.ptr.blmpb.com (sg-1-110.ptr.blmpb.com [118.26.132.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBA2EA485
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712736; cv=none; b=uQUZPHqRJC8gWisMuLiFUKE5eR+CLk/M3Nsl/yx7k2Hl3n0loJ6YbL0TOKMzXWolFH6hJ6XbfUx8KeTDgBbJMGtjv3VzOOKBFk1DI1e4wyJ5FS1+0QtF+JopsBvy5iJMcWRgdGAZsIbOPZPrbRapsZmcdkiZRbw23HF1Nj1eS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712736; c=relaxed/simple;
	bh=uiSb+J2w507d+dFrZpFQw+b55iS46t8jZ3mFz/UxFHc=;
	h=Message-Id:To:Subject:References:In-Reply-To:Content-Type:Date:Cc:
	 From:Mime-Version; b=Uzat8/fKLy3M6lPqanjSiw6xrVKF/wfp6j6n16N1kN9aJe1g3D4bWby1xQd+YgTHYX7770p02EEpx6mMjyzQjKCs89H5VrG78LQOMaeXuYmohjrvhpuEoIobOcljw56rvuZrd7DT4RmNwvcqObOhq8aSzDcKI+Gy2XW2qqM7bIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ON5mbVWp; arc=none smtp.client-ip=118.26.132.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ON5mbVWp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763712719; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=uiSb+J2w507d+dFrZpFQw+b55iS46t8jZ3mFz/UxFHc=;
 b=ON5mbVWpFi0E8UtB+qzUp5ZFFHc7iPArxCbDmruyuX9Yk2CzAIRAElojff8vHcUWl3Y3Mt
 /OA2nRccI7+WXz6r6eKLYy1IQE7MOcOl/chKnjN2HCzBqHX//bNTAdQijEg4a0FGgXqDv9
 Mr7Tyep+fXqerQyAugazX91VRmS5Miri7cQxLGUjKGObgxLA4Vxhiv2+GKPkm5u+Tr2yyc
 x3gxhQrGfTPZJkeLkA1Be7R3IUntTAYWdg73POCt/EOa63I1+4IuBrG8LfCsmck6h/6bif
 XWGW2jk+rZOilnTCOrgriPvJF//dMnERR8QipAX+Yho51+Ws6wUEseU84eKrCw==
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ff6bf04a.edf6.4fe8.aab9.a78110a1d5f8@bytedance.com>
To: "Jens Axboe" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
References: <20251120031626.92425-1-fengnanchang@gmail.com> <20251120031626.92425-3-fengnanchang@gmail.com>
	<d01e0be0-6c4e-4308-8663-b408ab74a911@kernel.dk>
In-Reply-To: <d01e0be0-6c4e-4308-8663-b408ab74a911@kernel.dk>
X-Lms-Return-Path: <lba+169201ecd+8cfadf+vger.kernel.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 16:11:56 +0800
Cc: "Fengnan Chang" <fengnanchang@gmail.com>, <linux-block@vger.kernel.org>, 
	<ming.lei@redhat.com>, <hare@suse.de>, <hch@lst.de>, 
	<yukuai3@huawei.com>
From: "changfengnan" <changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> From: "Jens Axboe"<axboe@kernel.dk>
> Date:=C2=A0 Thu, Nov 20, 2025, 23:01
> Subject:=C2=A0 Re: [PATCH 2/2] blk-mq: fix potential uaf for 'queue_hw_ct=
x'
> To: "Fengnan Chang"<fengnanchang@gmail.com>, <linux-block@vger.kernel.org=
>, <ming.lei@redhat.com>, <hare@suse.de>, <hch@lst.de>, <yukuai3@huawei.com=
>
> Cc: "Fengnan Chang"<changfengnan@bytedance.com>
> > diff --git a/block/blk-mq.c b/block/blk-mq.c

> > index eed12fab3484..82195f22befd 100644

> > --- a/block/blk-mq.c

> > +++ b/block/blk-mq.c

> > @@ -4524,7 +4524,12 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_=
mq_tag_set *set,

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hctxs=
)

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memcpy(new_hctxs, hctxs, q->nr_hw_queues *

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(*hctxs));

> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q->queue_hw_ct=
x =3D new_hctxs;

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_assign_poi=
nter(q->queue_hw_ctx, new_hctxs);

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure r=
eading the old queue_hw_ctx from other

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * context con=
currently won't trigger uaf.

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_rc=
u();

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(hct=
xs);

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hctxs =3D=
 new_hctxs;

>=C2=A0
> Might make sense to use the expedited version here, to avoid odd ball

> cases that end up doing this for tons of devices.

>=C2=A0
> > diff --git a/block/blk-mq.h b/block/blk-mq.h

> > index 80a3f0c2bce7..ccd8c08524a4 100644

> > --- a/block/blk-mq.h

> > +++ b/block/blk-mq.h

> > @@ -87,6 +87,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue=
_type(struct request_queue *

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return q->queue_hw_ctx[q->tag_set->ma=
p[type].mq_map[cpu]];

> > =C2=A0}

> > =C2=A0

> > +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q=
, int id)

> > +{

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct blk_mq_hw_ctx *hctx;

> > +

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0hctx =3D *(rcu_dereference(q->queue_hw_ctx=
) + id);

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();

> > +

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return hctx;

> > +}

>=C2=A0
> I think that'd read a lot better if the type was **hctx and you just

> return *hctx instead.

Do you means like this ?=C2=A0
static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int=
 id)
{
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 struct blk_mq_hw_ctx **hctx;

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 rcu_read_lock();
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 hctx =3D rcu_dereference(q->queue_hw_ctx) =
+ id);=C2=A0
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 rcu_read_unlock();

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 return *hctx;
}

It's seems not right, queue_hw_ctx is protected, after unlock to
access may cause UAF.=C2=A0
How about=C2=A0 rcu_dereference(q->queue_hw_ctx)[id]; ?=C2=A0
>=C2=A0
> --=C2=A0

> Jens Axboe
>=C2=A0
