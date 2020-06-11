Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359BDC433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8F22083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMZgDBZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFKOHy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKOHy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 10:07:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A7C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 07:07:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so6629537eju.2
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sBZCAFP78v5xfVnE168pR3j2RBXpcVNVGT19lNoxO1w=;
        b=SMZgDBZn0jwIw/TZ8ir5nFxm+c6/RE98ofUO2Ip7RNKzlyrGNb4b+xIOZyNCzDZ9b1
         JtSpR5Wt7Bvv6RzCYqN71xdx0uBbM3Ca26ZSGaUC4Z+SLGMI1Zn0wzSBezXOXV+0AW+r
         /NJRhAUE0UT+tyaNKR2kZ/C5SL+l1UtwN6QoIybls7jixNekpLmJYUhpX/F9Z+zXLLMG
         EY5CKJDZCib8mZqbvMeZU5f5yI64vN7lErl62iR9sETuNykcrZ5CXJ+xXF3gwQFnpGdm
         jQtNUfawgJGGgjYI2ZdF7SVHeVEOGfX9cVyKGrmG3KQIcXcxM/bF65hJiDYx3mObQ6K0
         GISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sBZCAFP78v5xfVnE168pR3j2RBXpcVNVGT19lNoxO1w=;
        b=ukiRwU/ipR0y24JvON0FiYuuOH8M4BtPPk5NHdwQKfz+zIF2hCff/TF4F/2e6Nuks8
         /x2RfXmYGSN+3Y24S8Z68g+Sz3tl6eOxYO57LF/0LXJcxDuIt2irJgAEirAoYuiDldUj
         XCAkz1ZgCb0wAoH+xXo5L5v1HH+4mOFem3mEsyWWciMU2oofg82zrNfyO4SxDAJ/8g5f
         K21KmAfGDdBiS02Vx+lPGeee/RVOUZd6yt/BPb19sIIyzf64uALJJiIcOKSX4CrStsrg
         wYBZrZHscBmMkbqzJQjJw2QfwBnTlhIVD5Vbk/Sq/3izrdOh3N8HszUkK43J/5G/9Z4g
         4vPw==
X-Gm-Message-State: AOAM530Dw1sYGCkDuqCx07vCC01hciskDJ+By8ynGWrL8qVtPf22h/nI
        7AH3NTFoKqsQOPfGsTuJ2YDoHZKbOaY=
X-Google-Smtp-Source: ABdhPJx2DTndnEqtVam0Pg75BQb+cPzKUTILGbLHtaRAnBb9BmBDZRxxO5jTKn5DcWqPOotUfpW8Ug==
X-Received: by 2002:a17:906:4ec1:: with SMTP id i1mr8294417ejv.152.1591884471277;
        Thu, 11 Jun 2020 07:07:51 -0700 (PDT)
Received: from [192.168.0.2] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id fw16sm1906673ejb.55.2020.06.11.07.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:07:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] bfq: Use only idle IO periods for think time
 calculations
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200605141629.15347-3-jack@suse.cz>
Date:   Thu, 11 Jun 2020 16:11:10 +0200
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-3-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 5 giu 2020, alle ore 16:16, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Currently whenever bfq queue has a request queued we add now -
> last_completion_time to the think time statistics. This is however
> misleading in case the process is able to submit several requests in
> parallel because e.g. if the queue has request completed at time T0 =
and
> then queues new requests at times T1, T2, then we will add T1-T0 and
> T2-T0 to think time statistics which just doesn't make any sence (the
> queue's think time is penalized by the queue being able to submit more
> IO).

I've thought about this issue several times.  My concern is that, by
updating the think time only when strictly meaningful, we reduce the
number of samples.  In some cases, we may reduce it to a very low
value.  For this reason, so far I have desisted from changing the
current scheme.  IOW, I opted for dirtier statistics to avoid the risk
of too scarse statistics.  Any feedback is very welcome.

Thanks,
Paolo

> So add to think time statistics only time intervals when the queue
> had no IO pending.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c66c3eaa9e26..4b1c9c5f57b6 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5192,8 +5192,16 @@ static void bfq_update_io_thinktime(struct =
bfq_data *bfqd,
> 				    struct bfq_queue *bfqq)
> {
> 	struct bfq_ttime *ttime =3D &bfqq->ttime;
> -	u64 elapsed =3D ktime_get_ns() - bfqq->ttime.last_end_request;
> -
> +	u64 elapsed;
> +=09
> +	/*
> +	 * We are really interested in how long it takes for the queue =
to
> +	 * become busy when there is no outstanding IO for this queue. =
So
> +	 * ignore cases when the bfq queue has already IO queued.
> +	 */
> +	if (bfqq->dispatched || bfq_bfqq_busy(bfqq))
> +		return;
> +	elapsed =3D ktime_get_ns() - bfqq->ttime.last_end_request;
> 	elapsed =3D min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
>=20
> 	ttime->ttime_samples =3D (7*ttime->ttime_samples + 256) / 8;
> --=20
> 2.16.4
>=20

