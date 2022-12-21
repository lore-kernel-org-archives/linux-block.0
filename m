Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F04C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiLUKbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiLUKaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:30:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F198222A7
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:27:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d20so21435958edn.0
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CzXwq/9SNG8hbn2X73aOjREHxCi+RooE+zbwoK01ow=;
        b=QPzxO68k6+dGEZJpruyXt4W/gZpcPXW/hYlpXft9I9ZNNiRq6PVUNqdbZFqp+Q2vTo
         SU/qxHIpxia9jxWEBMvC94IwaPCwux8sG0yYgnvCWWtS/TIToriT+RH8rvnvW+/yAfnK
         zd+Poi8M6Mla3PZvVXJqfxLGvZD+JbOg7dXQSpMEyPEY6QJVNtKECEooasMang8WOzy/
         Zm5JTvccyJZuRr7dVX0bl0JGB9XCrwRrQerBYX5MKajyb9DVfWNjvtj0EucjYaLhKknO
         MEiZYUulcO5OGJbsB4Lb1TB4V4bn6Poyr+GmWDJ+lwrLD3BFJf62hR8l8Y6oLGiofa64
         mV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CzXwq/9SNG8hbn2X73aOjREHxCi+RooE+zbwoK01ow=;
        b=sFo4hV9qev01ua1DXslKbZ51UdTBxvyH/t6j8yJyOxPfZ5Cqo0MHSYUmOH0ewzEpfx
         uNMmLxQkxhWOU+Jxu8P68+BD6Qsi4ptxVRwwAoR6Ae16fSj3CqzqtGEEdvcaFWYLUd/4
         Rnes6flbRBjnNWb2qs17oqHgMYKjEIdxHgqO9U46C/WKe1+YNR+Lx0PODeCxbs3GJ2ng
         HmIrFgdeiBdfPLjDl18h9NIbtz0AqYETYbHF1x1zzIVwhkq/0qBvVwL2LlIoMHgBSewU
         xMVo1XbtS/q19b2cFNAcwSLB10mXT0DEe7Ha7J/6uCrJAS6AJwxoUJIhqQii9eTPXSi0
         Mt2w==
X-Gm-Message-State: AFqh2koskm+SUcgOCMEbU00LoNTa9QEyEboF5fu9rjrtx80ufDKrkAv/
        hufmWrmUih1/JX84AgTA090+sw==
X-Google-Smtp-Source: AMrXdXsCzXLY6RnE8fup9Ydtb78UXb7M5vMpIvIRbJf61fMnLcDLYwmuDAfyDwYk/ndw+wBFcWwlzw==
X-Received: by 2002:a05:6402:2935:b0:460:811d:8a12 with SMTP id ee53-20020a056402293500b00460811d8a12mr950237edb.20.1671618450044;
        Wed, 21 Dec 2022 02:27:30 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id p26-20020a05640210da00b0046b16872e69sm6835445edu.2.2022.12.21.02.27.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:27:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V11 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <8a49432d-642f-cd58-8e4d-2b320aef5edd@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 11:27:28 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D429FA01-9510-41FF-AD85-F74EB8AD171F@linaro.org>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
 <20221220095013.55803-2-paolo.valente@linaro.org>
 <8a49432d-642f-cd58-8e4d-2b320aef5edd@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 21 dic 2022, alle ore 01:46, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
>=20
> [...]
>=20
>> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
>> +			      unsigned int actuator_idx)
>> {
>> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
>> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, =
actuator_idx);
>> 	struct bfq_data *bfqd;
>>=20
>> 	if (bfqq)
>=20
> With your current bic_to_bfqq() implementation, you will *never* get =
NULL as a
> return value.

I'm afraid this is not true.  A bic is associated with a sync and an
async queue, or with both.  So, in the hunk above, bic_to_bfqq returns
NULL if:
- either the bic is associated with a sync queue, but is_sync happens to =
be false;
- or the bic is associate with an async queue, but is_sync happens to be =
true.

Of course, with these patches, the associations move from "with a
sync/async queue" to "with a set of sync/async queues, one per
actuator".

> So why is this if necessary ?
>> 		bfqd =3D bfqq->bfqd; /* NULL if scheduler already exited =
*/
>>=20
>> 	if (bfqq && bfqd) {
>> -		unsigned long flags;
>> -
>> -		spin_lock_irqsave(&bfqd->lock, flags);
>> 		bfqq->bic =3D NULL;
>> 		bfq_exit_bfqq(bfqd, bfqq);
>> -		bic_set_bfqq(bic, NULL, is_sync);
>> -		spin_unlock_irqrestore(&bfqd->lock, flags);
>> +		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
>> 	}
>> }
>>=20
>> static void bfq_exit_icq(struct io_cq *icq)
>> {
>> 	struct bfq_io_cq *bic =3D icq_to_bic(icq);
>> +	struct bfq_data *bfqd =3D bic_to_bfqd(bic);
>> +	unsigned long flags;
>> +	unsigned int act_idx;
>> +	/*
>> +	 * If bfqd and thus bfqd->num_actuators is not available any
>> +	 * longer, then cycle over all possible per-actuator bfqqs in
>> +	 * next loop. We rely on bic being zeroed on creation, and
>> +	 * therefore on its unused per-actuator fields being NULL.
>> +	 */
>> +	unsigned int num_actuators =3D BFQ_MAX_ACTUATORS;
>>=20
>> -	if (bic->stable_merge_bfqq) {
>> -		struct bfq_data *bfqd =3D bic->stable_merge_bfqq->bfqd;
>> +	/*
>> +	 * bfqd is NULL if scheduler already exited, and in that case
>> +	 * this is the last time these queues are accessed.
>> +	 */
>> +	if (bfqd) {
>=20
> Same here. bfqd can never be NULL. Or I am really missing something... =
Lots of
> other places like this where checking bic_to_bfqd() seems unnecessary.

As written in the comment above, bfqd is NULL if the scheduler already
exited.  That is, bic->icq.q->elevator->elevator_data =3D=3D NULL.  This
is an event I have checked several years ago, probably while porting
cfq to bfq.  If boundary conditions changed later, and nobody realized
that this was not true any longer, then bfqd would never be NULL as
you say.  At any rate, I guess that such a change would then belong to
a separate patch series.

Thanks,
Paolo=
