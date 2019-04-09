Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBCC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1DA2133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=demfloro.ru header.i=@demfloro.ru header.b="EHBPsxqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDIQO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:14:29 -0400
Received: from mx.demfloro.ru ([185.52.0.75]:49014 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfDIQO3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 12:14:29 -0400
Received: from fire.localdomain (unknown [IPv6:2001:470:28:88::100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: demfloro)
        by mx.demfloro.ru (Postfix) with ESMTPSA id 44dsmx4DCfzBBjs;
        Tue,  9 Apr 2019 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru; s=032019;
        t=1554826466; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIlnP5FGsi4pz+IT2z95Yx/7q9M/zyCA1yUqRhbOGgc=;
        b=EHBPsxqqocY7V/R/xYDsix2CEuURJeOldTkd+WwRKyevS80CqcBpkoyH3cywhDqUsH6Bkn
        gp71ptZIApwNibSmq+uyYE5ABm84bTBB0i+RJ6y8Cu1sY/7P4cIcrqTxwt6+Aj40JhQruK
        4O6/Q5dtZ/moz450mC1Y9gYFaTieq8ucTTP2ggxN7amkFdMXsnabPuoLgkRZ1qAfE7hkzN
        wx7Y3DRjwgV7Hszo1Skjt5OLhHtUe5JT7cmSqHNfuaCOfm8NKJnjU0BUSht/0VDtyPvk4F
        O4q0UfSVa1TvCuRV7Qon+xh3z6tMjxAo429Lfrzfe/qzF/vhnbDDOZXzNhQd+Q==
Date:   Tue, 9 Apr 2019 19:14:20 +0300
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
Message-ID: <20190409191420.3f56d493@fire.localdomain>
In-Reply-To: <A90B593D-4831-4DFF-89CE-0E59045E9093@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
 <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
 <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
 <20190401115509.76310e03@fire.localdomain>
 <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
 <20190401122233.3e861312@fire.localdomain>
 <EBC090F1-72C0-4794-91CC-37F9A2A1DEFB@linaro.org>
 <20190404222257.0cfb1130@fire.localdomain>
 <A90B593D-4831-4DFF-89CE-0E59045E9093@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru;
        s=arc032019; t=1554826466;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIlnP5FGsi4pz+IT2z95Yx/7q9M/zyCA1yUqRhbOGgc=;
        b=UbOrsdq69KIm6wKXIApqN6PozdKfvCJxggt4BC4DuyPhejpqi/SWywOauYQOTf8pEMGneU
        iWjtFAVfkvYUpFZ8u1LTmgwBvNSLvZLtBRoP/lpOnJ/7NuQR68x0JMdKglAwueT3sH80cz
        NtVu38Sr2BL9mJNdB/QprDV6M4+1yQ+KIDeRuKbdDCVpXP8QMrlDXS120mXybDWGme+wWq
        kVNOk3XvF2BfgxORlNDOxycb/02gL8XIdZnEbROAEAo4vDOl6MRUVdFpv8DbR/lXlEx1p7
        Oy2pssYcpP1L9jMCKcQsxSsRZr31Z2H3AnPAJlt1GdmBRy9JeObcdL0vpTkkBw==
ARC-Seal: i=1; s=arc032019; d=demfloro.ru; t=1554826466; a=rsa-sha256;
        cv=none;
        b=QciqiWxARtEKqibyHruZFAmbK4ewnBEs71qX2n65NpQA6SVBoJBH0AWc4PwXjH5IsMtjVf
        kVDTgrH97o/jrGlqj1DFscCJHnrfAzwHDS1OTvNv3bnLOSLzYz1jd707ty7SOBY7LpG8cT
        4uI6Wn2otCSY+CRMW3FF6EZ907JPC5TOcEV7/3kbi5IH++W5dCeDyBrP1xa9G1RCarBU+5
        fZ0fP8AxH5KE92eHJ9GIVUkesszosvEdjTqyIfYe733LP2fm1QD64qjucpn6wI3vbLwUYD
        a/ndrRf0VKzKveb0WFZoNwH6SYeEDCKjWLUPLkMO+FNf/g9WOqnWp1ZwF3LGpg==
ARC-Authentication-Results: i=1;
        mx.demfloro.ru;
        auth=pass smtp.auth=demfloro smtp.mailfrom=demfloro@demfloro.ru
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 9 Apr 2019 11:55:21 +0200
Paolo Valente <paolo.valente@linaro.org> wrote:

> 
> 
> > Il giorno 4 apr 2019, alle ore 21:22, Dmitrii Tcvetkov
> > <demfloro@demfloro.ru> ha scritto:
> > 
> > On Mon, 1 Apr 2019 12:35:11 +0200
> > Paolo Valente <paolo.valente@linaro.org> wrote:
> > 
> >> 
> >> 
> >>> Il giorno 1 apr 2019, alle ore 11:22, Dmitrii Tcvetkov
> >>> <demfloro@demfloro.ru> ha scritto:
> >>> 
> >>> On Mon, 1 Apr 2019 11:01:27 +0200
> >>> Paolo Valente <paolo.valente@linaro.org> wrote:
> >>>> Ok, thank you. Could you please do a
> >>>> 
> >>>> list *(bfq_bfqq_expire+0x1f3)
> >>>> 
> >>>> for me?
> >>>> 
> >>>> Thanks,
> >>>> Paolo
> >>>> 
> >>>>> 
> >>>>> <gpf.txt><gpf-w-bfq-group-iosched.txt><config.txt>
> >>> 
> >>> Reading symbols from vmlinux...done.
> >>> (gdb) list *(bfq_bfqq_expire+0x1f3)
> >>> 0xffffffff813d02c3 is in bfq_bfqq_expire
> >>> (block/bfq-iosched.c:3390). 3385             * even in case bfqq
> >>> and thus parent entities go on receiving 3386             *
> >>> service with the same budget. 3387             */
> >>> 3388            entity = entity->parent;
> >>> 3389            for_each_entity(entity)
> >>> 3390                    entity->service = 0;
> >>> 3391    }
> >>> 3392
> >>> 3393    /*
> >>> 3394     * Budget timeout is not implemented through a dedicated
> >>> timer, but
> >> 
> >> Thank you very much.  Unfortunately this doesn't ring any bell.
> >> I'm trying to reproduce the failure.  It will probably take a
> >> little time.  If I don't make it, I'll ask you to kindly retry
> >> after applying some instrumentation patch.
> >> 
> > 
> > I looked at what git is doing just before panic and it's doing a
> > lot of lstat() syscalls on working tree.
> > 
> > I've attached a python script which reproduces the crash in about
> > 10 seconds after it prepares testdir, git checkout
> > origin/linux-5.0.y reproduces it in about 2 seconds. I have to use
> > multiprocessing Pool as I couldn't reproduce the crash using
> > ThreadPool, probably due to Python GIL.
> > 
> 
> Unfortunately this failure doesn't reproduce on my systems.  But I
> have a suspect.  Could you please test this patch? (also attached as a
> compressed file):
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index fac188dd78fa..0a435bcfed20 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2822,7 +2822,7 @@ static void bfq_dispatch_remove(struct
> request_queue *q, struct request *rq) bfq_remove_request(q, rq);
>  }
>  
> -static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct
> bfq_queue *bfqq) +static bool __bfq_bfqq_expire(struct bfq_data
> *bfqd, struct bfq_queue *bfqq) {
>  	/*
>  	 * If this bfqq is shared between multiple processes, check
> @@ -2857,7 +2857,7 @@ static void __bfq_bfqq_expire(struct bfq_data
> *bfqd, struct bfq_queue *bfqq)
>  	 * or requeued before executing the next function, which
>  	 * resets all in-service entites as no more in service.
>  	 */
> -	__bfq_bfqd_reset_in_service(bfqd);
> +	return __bfq_bfqd_reset_in_service(bfqd);
>  }
>  
>  /**
> @@ -3262,7 +3262,6 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
>  	bool slow;
>  	unsigned long delta = 0;
>  	struct bfq_entity *entity = &bfqq->entity;
> -	int ref;
>  
>  	/*
>  	 * Check whether the process is slow (see bfq_bfqq_is_slow).
> @@ -3347,10 +3346,8 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
>  	 * reason.
>  	 */
>  	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
> -	ref = bfqq->ref;
> -	__bfq_bfqq_expire(bfqd, bfqq);
> -
> -	if (ref == 1) /* bfqq is gone, no more actions on it */
> +	if (__bfq_bfqq_expire(bfqd, bfqq))
> +		/* bfqq is gone, no more actions on it */
>  		return;
>  
>  	bfqq->injected_service = 0;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 062e1c4787f4..86394e503ca9 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -995,7 +995,7 @@ bool __bfq_deactivate_entity(struct bfq_entity
> *entity, bool ins_into_idle_tree);
>  bool next_queue_may_preempt(struct bfq_data *bfqd);
>  struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd);
> -void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
> +bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
>  void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue
> *bfqq, bool ins_into_idle_tree, bool expiration);
>  void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue
> *bfqq); diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index a11bef75483d..a0c60c47ed1c 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1605,7 +1605,7 @@ struct bfq_queue *bfq_get_next_queue(struct
> bfq_data *bfqd) return bfqq;
>  }
>  
> -void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
> +bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
>  {
>  	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
>  	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
> @@ -1629,8 +1629,18 @@ void __bfq_bfqd_reset_in_service(struct
> bfq_data *bfqd)
>  	 * service tree either, then release the service reference to
>  	 * the queue it represents (taken with bfq_get_entity).
>  	 */
> -	if (!in_serv_entity->on_st)
> +	if (!in_serv_entity->on_st) {
> +		/*
> +		 * bfqq may be freed here, if bfq_exit_bfqq(bfqq) has
> +		 * already been executed
> +		 */
> +		int ref = in_serv_bfqq->ref;
>  		bfq_put_queue(in_serv_bfqq);
> +		if (ref == 1)
> +			return true;
> +	}
> +
> +	return false;
>  }
>  
>  void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue
> *bfqq,
> 

Awesome! I can't reproduce the panic with the patch on top of current
master (869e3305f23dfe) in my VM and on baremetal machine. Reverting
the patch allows to reproduce it.
