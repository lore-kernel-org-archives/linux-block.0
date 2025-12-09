Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38F23BF9F
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246020; cv=none; b=fs39wF9gWoV2bpMfqKbx8ckKxkNqmdRLxGbEEts88hcWRvBXCwnBNYaS4a+2WK7fLlJZLJOfIJI3mf5fcuafiSLyU7YiVkGeXKk8PvA/DP0/C5wBlOOK1OedzyvhFr3CHcG4kFKcHfnLPxrV1vVZLKZ8ezPqPeijMNYoAiYdYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246020; c=relaxed/simple;
	bh=YNdOjnU3RjHeumIdjRe9HosnY6ArRfJfsy4E62rIOTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIeI1K/MAeypdbRlYivIUQlMjZHD62aNBg9xMM0N5EdY+ZUVdPDCV4DPJQXMupMHFJMNRZA2PQl4TmUhmkDig8MtKGmwNKAuZb71SW9fEStnaNymGjnNjFZYL0xA58NbzsOkhcTKZ18/wKsktGrGrK0XIZrwG+fVlb0HAdG2sXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx8mopId; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx8mopId"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso5862326b3a.2
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 18:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765246018; x=1765850818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmNn1xueZis1+pRgwdAWIO7rUeDG93yacC0yIdzXyEo=;
        b=Cx8mopIdbfjSh1YuM4rhSBxYt9t6lJDwUZMuxL9dDdiu/iq11rYZnFfRs4ORSFPw2N
         0gaNHO7uCRFWYP3FH4s43pEsdeVJ1ejHRkuD5lO5owgLSgK7bJ0xHttQxPffDzSYDS76
         j2GLP4Y1OR+m2L1wW9jIubiJr0NZHU8p5utWLm4E5+8piOwhm07yu4EHodKa9uvBwyEg
         te5AKFPeyjGtIq5v+vuEM4wxMu0jR/XFiLi+0nB45zmsMAmXDJbujtB02tZNmmD9iIdi
         4lliLTyJrw2kgv9QMxNetzQxCRBlMhfAhuuoPIAZdFz4nt7RYPNoUC/JEuAEjMaLk5qv
         0URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246018; x=1765850818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmNn1xueZis1+pRgwdAWIO7rUeDG93yacC0yIdzXyEo=;
        b=IVQabwp8WvryHBpOx0shrfb2bFccHT4DoKL1MJTDWCm9kAE9G25r6k07GhM/LiXFdz
         eDAeP1jvNkssO9OkbuyaPR9u6Ky59DQRoAf5nuPEQ6PS6e5rnvGHdsmpgwGofi61C001
         BlrcOQqHWIdlYabo/pyiu6BP+vhxDlBvoJyvD9KV0Lsz9dMam0/ayZpboC3qLfkYKMcJ
         daVb5gdmqWlE3PtL557iqmY61IQgAkaSsRBqOAXe+G3bgN1tyq4pGfASo28tbwkkk5qq
         a+X6buFKFl+4qYmv/IeTw92XmlzrwaKwQDHJWMEvvK/0woBPjrS1btUUx7AMoPqthTC8
         YNeg==
X-Forwarded-Encrypted: i=1; AJvYcCU1CVb21nSiqUP8mZyfj7pHF7Y8U6wYDx+Q+Yl9HX38Cs+g8WYXoXOBHQAtNu2Eo0ar7FvgMNQx8fcBVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwRTzuuXsNrxYeNd2JpOWhHdDUmM7QIERGsOvEIgJlIcN6B/s
	t22xc12CdhgWvrP6SoCAWH+if3R7KjlG0+s8ldSKt3KOOn0ji8a/ZG7Zch4svQ3qkkRBK7vTcpy
	DgWk4YSmQQpK87uMaEa/viO0FUaFKT9Q=
X-Gm-Gg: ASbGncvLgYVMo3mtL12Yds7KIkUZUco0Y5WkRZbCi6z89zG3Y+VAehqxfMeAVy90fNZ
	i7VksOTEo25RbDPHJz1jbUEUu98yVW2rsHiMWwYjH6dj5z8SeHbwJexok5Cql+hIclt/oReFBdk
	PS6EA7O/lftv8eGxIv94G6pTvDii+ELBaJ5hW8Tq14AgBBMAAlfbeU/fC4qZ/7pOaHlHQmNEnZB
	dURomkPPUTC5jwi6MXvD2Rya16wv8X4QcOPXiOscbRVXO7cu+DDkeSLWYk+Rk7NsU0YfQ==
X-Google-Smtp-Source: AGHT+IFyeIBizeosCDnsJozmwtXeTZ3Wj2/Z9val8hDQVawDooHONhL0/YodAWhXUxL27JU5DsObS26EWq4vSIiyZdo=
X-Received: by 2002:a05:6a21:9991:b0:35a:80f2:fa3c with SMTP id
 adf61e73a8af0-36617e83b82mr9209793637.31.1765246018123; Mon, 08 Dec 2025
 18:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208110213.92884-1-pilgrimtao@gmail.com> <33dcc737-1419-4f3e-8952-2f34db47a087@acm.org>
In-Reply-To: <33dcc737-1419-4f3e-8952-2f34db47a087@acm.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Tue, 9 Dec 2025 10:06:47 +0800
X-Gm-Features: AQt7F2q6HA9ih7D4cTjshL_pzYYxabnrmjW_6p9Gun9d4NL2ywaSVpZp_OjO0Dw
Message-ID: <CAAWJmAb0+Xhm7Wy2kqH7E4VGLUqZa_2ohBYP4ttw6zzjD109JA@mail.gmail.com>
Subject: Re: [PATCH] mq-deadline: the dd->dispatch queue follows a FIFO policy
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:24=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 12/8/25 4:02 AM, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > In the initial implementation, the 'list_add(&rq->queuelist, ...' state=
ment
> > added to the dd_insert_request function was designed to differentiate
> > priorities among various IO-requests within the same linked list. For
> > example, 'Commit 945ffb60c11d ("mq-deadline: add blk-mq adaptation of t=
he
> > deadline IO scheduler")', introduced this 'list_add' operation to ensur=
e
> > that requests with the at_head flag would always be dispatched before
> > requests without the REQ_TYPE_FS flag.
> >
> > Since 'Commit 7687b38ae470 ("bfq/mq-deadline: remove redundant check fo=
r
> > passthrough request")', removed blk_rq_is_passthrough, the dd->dispatch
> > list now contains only requests with the at_head flag. In this context,
> > all at_head requests should be treated as having equal priority, and a
> > first-in-first-out (FIFO) policy better aligns with the current situati=
on.
> > Therefore, replacing list_add with list_add_tail is more appropriate.
> >
> > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > ---
> >   block/mq-deadline.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index 3e3719093aec..dcd7f4f1ecd2 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -661,7 +661,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> >       trace_block_rq_insert(rq);
> >
> >       if (flags & BLK_MQ_INSERT_AT_HEAD) {
> > -             list_add(&rq->queuelist, &dd->dispatch);
> > +             list_add_tail(&rq->queuelist, &dd->dispatch);
> >               rq->fifo_time =3D jiffies;
> >       } else {
> >               deadline_add_rq_rb(per_prio, rq);
>
> I think the current behavior (LIFO) is on purpose and also that it only
> should be changed if there is a strong reason to change it. I don't see
> a strong reason being mentioned in the patch description.
>
Previously, the dd->dispatch queue contained both requests with the
BLK_MQ_INSERT_AT_HEAD flag and those without it. The implementation
placed requests with the BLK_MQ_INSERT_AT_HEAD flag at the head of
the dd->dispatch queue, while requests without this flag were placed
at the tail. However, now all requests in the dd->dispatch list carry
the BLK_MQ_INSERT_AT_HEAD flag, and I can't find any justification for
continuing to use a LIFO (last-in-first-out) policy.

Additionally, the dispatch queue has recently been moved from struct
dd_per_prio to struct deadline_data, switching back to a single dispatch
list. This means more requests will queue in the dispatch list, and
continuing with the LIFO policy makes earlier-arriving requests more
susceptible to starvation. Could anyone explain the rationale behind
maintaining this approach?

--=20
Yours,
Kaitao Cheng
