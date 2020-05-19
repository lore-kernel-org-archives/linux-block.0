Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB22C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D3720809
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 23:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eKrhOds6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgESXiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESXit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 19:38:49 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E262C061A0F
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 16:38:49 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb16so516861qvb.5
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WX8zNao4hB0v73w8f5UXj9N2V1yEgSHUlRcesp4q++8=;
        b=eKrhOds602SoUWuWh+rz6Zjf86gkwodoowj8v7Ru1Zu2FN674srfU7AYTUaQrsuLPn
         a1xQB/Do514Hx1o2FOn5XiCrfX1MRNsvj3FeX0wOrqvLgHif1uAC3mNVMnjAsred6AwM
         fTTqqxxGTEu0Ted/EYPCBH9HX6n4oZkDCZQkqL62lXwAkK9FJR4778UUvGDZIRM+JNK+
         CyIXLfkWWawsQzmtNpZTp/pif28uKhCB57kf3h4wSYCyhla73TDYQpZ0e9K4Dv6TMHVS
         Z8Oz+I04grVssJ2OmCjsYSfy+2Eb4bru/N91x36154pXGLGUnpTgkDv4Z/gd295+ivMn
         7PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WX8zNao4hB0v73w8f5UXj9N2V1yEgSHUlRcesp4q++8=;
        b=gTdvIckN21ZuD+nQfFx3Z4qYpinxjSl5jvbhh0pIRUA+tOgDX/5K8CUae5d0EKO050
         UE/NJuLd1bbqao43tW4Ex1ilqHPe7frL05UA0ym3fN+7oqsDkjM4oW81uz8sI7QMkWy3
         SUweHtfAC+TT1SpVV3VxIOilOYPjELbV+otP6cFrGjvvxpx5/DEZmtIK1qaC19o871Gk
         +3nvzG8rE0/yESIffxABDEl42GL1NOq+SAydGVaKdUMemij1UcfkHsCyfKdMZT0gf2Vv
         YAuwarcP5XAPdMSS5GjWHck5adv9cI3ODlUEAnZvd7MCqhZwcPKNsBTlcGSWiKfbyZc6
         TxTQ==
X-Gm-Message-State: AOAM533yAw+ue7M5fAYiWCf9qBuapTkGB4uKdcj2ye21FsTCi8M9rKhY
        oFBHXAuHTrAJ0JVQZMQJHSCKueBjva4=
X-Google-Smtp-Source: ABdhPJxVKDooS2c8caBYCj+9YCvHhBKGb1TvQ7mIVqolG2QzHvKHbBkWsndvedK3ht5yka4Bv9t99A==
X-Received: by 2002:a05:6214:42a:: with SMTP id a10mr2142855qvy.78.1589931528308;
        Tue, 19 May 2020 16:38:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m59sm1037279qtd.46.2020.05.19.16.38.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:38:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbBot-0003Y7-Eu; Tue, 19 May 2020 20:38:47 -0300
Date:   Tue, 19 May 2020 20:38:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        leon@kernel.org, jinpu.wang@cloud.ionos.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting
 smatch warning
Message-ID: <20200519233847.GC12656@ziepe.ca>
References: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
 <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 07:29:15AM -0700, Bart Van Assche wrote:
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 468fdd0d8713..8dfa56dc32bc 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -727,18 +727,13 @@ struct path_it {
>  	struct rtrs_clt_sess *(*next_path)(struct path_it *it);
>  };
> 
> -#define do_each_path(path, clt, it) {					\
> -	path_it_init(it, clt);						\
> -	rcu_read_lock();						\
> -	for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&		\
> -			  (it)->i < (it)->clt->paths_num;		\
> +#define for_each_path(path, clt, it)					\
> +	for (path_it_init((it), (clt)), rcu_read_lock(), (it)->i = 0;	\
> +	     (((path) = ((it)->next_path)(it)) &&			\
> +	      (it)->i < (it)->clt->paths_num) ||			\
> +		     (path_it_deinit(it), rcu_read_unlock(), 0);	\
>  	     (it)->i++)

That is nicer, even better to write it with some inlines..

Jason
