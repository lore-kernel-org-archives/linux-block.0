Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60C23EAA5
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592005; cv=none; b=cew6aCfg3OxLx09vjRXOgFhRTBqvlpnmlPKynWwJ8jsgcxoxAz0mWcqo6jMUeM8Y5zaNNlu+yS0CfRvUEbjYr5CDpLY+L9DbYUglnQ1OOf1O18b0Mgq5bQdhS7oPTsIgf/Rh39ltom2XDRWlQL8M6uIHhzMVF9xPllz83FPcxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592005; c=relaxed/simple;
	bh=O1hScv4GXB1QqS9hUTJfFLN1TPjrl4pUkUEKEs/6stw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJpw/+fQTa9zAuDoooWPgP/tTXWGViTbS+t8Eq6oNOZjN90JBDUTPlr9wNdgIicKk2TG59MTWdgHrvXsuN071UC/q/4d3WjnoPWQ4ZuOIObHPofusfkqviLjQkkaCF6vwCmCU1OW7DnPgKkGNC1VkYc652Ka/d28UuPjbOV+kKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7AbEPbB; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7AbEPbB"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so2589545e0c.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764592002; x=1765196802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f/WDSngOB+5EAXe+MQPJ5L1soAfrNYQuovqGp7oYrU=;
        b=J7AbEPbBCyDQ0bTVIUOVOLkHYDf+MQbHR2XXdXPrTEYNAeY0Fd5/WKdz3zkzPp9O97
         xheDppLbBqIOA+ph9jvvCdoIKeWRUQBY721ZQsGplFl+cAGCUkLAtq6xnhBb2x4KD+rv
         AkcL9IHhsmCm8sAVmQNAamRUh1MwxL7NS/Y2sfbUFiN4FngTJ87ZRUmIpP0TH5cpCFpg
         4d/ySBgqQuWxDuNJA8FymlkiFDRuHf3KkBXVWW1QaZPPX/F8pEb57MjletbY+4J3P2uZ
         EsdPRgVGIwPj61vf0Qoa5BXuvVv1Q+VWvgy0tAangXZg5eYn+TLPFV0twRLsjjB7qHfr
         Xuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764592002; x=1765196802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3f/WDSngOB+5EAXe+MQPJ5L1soAfrNYQuovqGp7oYrU=;
        b=gR2joUoteahHTTK8CeCYXYfbmeE+i1pWUdAawVBPKXsleUyjQ4fiXYWPpd7dGlz4Vu
         qXmSsL+ai5b7XpIE0SLr8uNx1rs5tw2cJHR4i5AUALm98LsY7G6LVUe0FDgK+MDxu4Ue
         L17uLVN9G8cJnz1eISXyHcVVkw0oFN72d2fOctiyNOuiX3Zcggs0rB82vIpTHo5nkSqG
         bfCwq62mSfxlOF9fhV5RBDcOfIUh+BPBwx04P39L0g7LZHBSW8vRUqeBeWuTHD3/wlHe
         DabVEPoifHHBpogJP7CnZvPWHqQ/Z+guh85o7QQhBMdyDUYPiG8sVvKtArWwFTiwY3Vq
         4POw==
X-Gm-Message-State: AOJu0YxgB70O82OUXp1EwVHzUG0e6jKDnaf6CxzFigiRzo0aez33kh8m
	Ut+RZaYDqoZlBWkMEO2YVD9brNEQCL/IaGcXWhUOXW2cal84OebyjbMxWJj33uBPkKlDV4ax8XI
	++cKOEROPoHpiXpAaS6loyeXtF3MmPBw=
X-Gm-Gg: ASbGncuO0mMgh8BovmXKLDjOPruB7apByLfC+Q5XJGnGAnm0H6y40IwZdwuzSznUvdx
	HaYbpLo7AoFbgWDp6wEs4MoabSsfVQbhcA4wte61KD1AoNG/L8HwjPrnDjiXMoTmezrHqUPtbnl
	6C96HVfA7COJtB88NIvW5Va6oJpd1bcGWXIN4ig0/BEclvQf58qCORDh88RObWWjFZ4a70CWy7h
	WHc1Zbts9v9OTRFi1ro5TPFxiBJgRfbnTnOgIKuP2tWnpuFNpUjsjLYf2fsv/WfJj/rzpiTjD5h
	zg==
X-Google-Smtp-Source: AGHT+IG+CkvQWCz8m1VkWR+brhztPp5HJd689u1HMHPbmpCzTlXlEzBOL0cBS4njZAEffCD0xy5rZ4IDCJwOycV30to=
X-Received: by 2002:a05:6122:20a8:b0:55b:7494:383c with SMTP id
 71dfb90a1353d-55b8d7c0831mr15579430e0c.7.1764592002483; Mon, 01 Dec 2025
 04:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128085314.8991-1-changfengnan@bytedance.com>
 <20251128085314.8991-3-changfengnan@bytedance.com> <c0e60e0c-42fb-438c-9d15-5f62567c1963@kernel.dk>
In-Reply-To: <c0e60e0c-42fb-438c-9d15-5f62567c1963@kernel.dk>
From: fengnan chang <fengnanchang@gmail.com>
Date: Mon, 1 Dec 2025 20:26:31 +0800
X-Gm-Features: AWmQ_bm_Sh6l-eq3EvzvmRAB5-N6th3MwgbboHCF0Z3tdJkrX7e5tOqfGJTIeaE
Message-ID: <CALWNXx-DRcxCONsOvOFgZneFfBYtrdNin9AFvCGogUea7eHCDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de, hch@lst.de, 
	yukuai@fnnas.com, Fengnan Chang <changfengnan@bytedance.com>, Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:20=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/28/25 1:53 AM, Fengnan Chang wrote:
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 0795f29dd65d..c16875b35521 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -999,9 +999,20 @@ static inline void *blk_mq_rq_to_pdu(struct reques=
t *rq)
> >       return rq + 1;
> >  }
> >
> > +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q=
, int id)
> > +{
> > +     struct blk_mq_hw_ctx *hctx;
> > +
> > +     rcu_read_lock();
> > +     hctx =3D rcu_dereference(q->queue_hw_ctx)[id];
> > +     rcu_read_unlock();
> > +
> > +     return hctx;
> > +}
>
> Should eg blk_mq_map_queue_type() use this helper now too?

You are right, now some caller of blk_mq_map_queue_type now didn't
grab 'q_usage_counter', such as blk_mq_cpu_mapped_to_hctx.
Also checked all other functions, no more missed cases.

New patch:
https://lore.kernel.org/linux-block/20251201122504.64439-1-changfengnan@byt=
edance.com/T/#u


Thanks.

>
> Note: I've applied this, so anything beyond this v3 should be an
> incremental against the current tree.
>
> --
> Jens Axboe
