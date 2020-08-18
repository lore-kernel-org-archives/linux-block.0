Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E4BC433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 05:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CA82075E
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 05:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSpO836N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRFaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 01:30:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87110C061389;
        Mon, 17 Aug 2020 22:30:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f19so9820265qtp.2;
        Mon, 17 Aug 2020 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=clmrhtEHnkuE6LcwVqYnlSll443zoXYKCOx0MPBjbtk=;
        b=FSpO836Nu0sLIbjI7R0n/GywVAllnHSOgajQheJ4LvlGzRNwCoH3uDem8Jo6zEd4vk
         eJszO1iJn48dQRINgqIQmPkHV7uVFN6l/+QNGjsnHrJ9s0jeNf/otsuCZ4FHRcJ8+Ebz
         x61E+o5Xaj2knzR/y3bLubXK/Mg0Avr2H83z6y9OxeSJSON3O676Prq6R/St4ZdtX3Qe
         Srm7D0uwzC18T7FNWau0Z01qTP6XvY739+/KI/4sbb7Tpe6cqwvKpsoAFtO62qzpR3HJ
         H+w3Ge0cNXAXg3ci23NfqPqGN3kaub3EocUQj2nFmrxPbbMRZPz+5Leoe3MK3mHdo7Ma
         JfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=clmrhtEHnkuE6LcwVqYnlSll443zoXYKCOx0MPBjbtk=;
        b=lPPOUx7XTufGALZPMwFWxlq82Bl1rwABsGea0pmFgbj136/xUOZPLaxD1LApH4i4Dn
         6upV4Jhp5oXnApG/0HjHU+Wk71tjjCQqbzWEf1EcqcuLexwPi1EymtvCwZuc4HWCv9m3
         tuOrf9BzOVevkz8XNN+53vP0nf8R2E3k6ip7WDLzVOFQ2u6hOJKG7fbxrwb6mq66OztV
         dXQKddD9ROxBntuZAHuEh6OZuVWhsck2096Pol0DSG5yaHDqkabSjiJRp4LTLXnkoeQk
         gvhJQ+cNskiVbhuANspYtmqdXadZ8qIMBNoXtshItPrZ6xk0Q9eqKF6mZsmuMU0klIxf
         hG3Q==
X-Gm-Message-State: AOAM5320QXdOP9XIdbmdscGHKiDL2s7f0Y5JZJyrreCRTzRDcaHx3eXx
        zIKwPKouZ1gEL/oU3lqshFg=
X-Google-Smtp-Source: ABdhPJwP6biy1fYwTP/ol1yzd5B7Y+r/WWD+1xf5w/MqzJsO+dHku2euAsV/d5OlG0IHy2iylSek5A==
X-Received: by 2002:ac8:1c3:: with SMTP id b3mr16860962qtg.240.1597728599880;
        Mon, 17 Aug 2020 22:29:59 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id o48sm23401139qtf.14.2020.08.17.22.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:29:58 -0700 (PDT)
Date:   Mon, 17 Aug 2020 22:29:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Brooke Basile <brookebasile@gmail.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] block: rnbd: rnbd-srv: silence uninitialized variable
 warning
Message-ID: <20200818052957.GA2253299@ubuntu-n2-xlarge-x86>
References: <20200818040317.5926-1-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818040317.5926-1-brookebasile@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 12:03:18AM -0400, Brooke Basile wrote:
> Clang warns:
> 	drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
> 	uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>         	if (IS_ERR(bio)) {
>             	^~~~~~~~~~~
> 	drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
> 		return err;
> 		^~~
> 	drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
> 	to silence this warning
>         	int err;
>                	^
>                 	= 0
> 
> Silence this by replacing `err` with `ret`, returning ret = 0 upon
> success.
> 
> Signed-off-by: Brooke Basile <brookebasile@gmail.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 0fb94843a495..f515d1a048a9 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -123,10 +123,10 @@ static int process_rdma(struct rtrs_srv *sess,
>  	struct rnbd_io_private *priv;
>  	struct rnbd_srv_sess_dev *sess_dev;
>  	u32 dev_id;
> -	int err;
>  	struct rnbd_dev_blk_io *io;
>  	struct bio *bio;
>  	short prio;
> +	int ret = 0;
>  
>  	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -138,7 +138,7 @@ static int process_rdma(struct rtrs_srv *sess,
>  	if (IS_ERR(sess_dev)) {
>  		pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
>  				   srv_sess->sessname, dev_id);
> -		err = -ENOTCONN;
> +		ret = -ENOTCONN;
>  		goto err;
>  	}
>  
> @@ -168,13 +168,13 @@ static int process_rdma(struct rtrs_srv *sess,
>  
>  	submit_bio(bio);
>  
> -	return 0;
> +	return ret;
>  
>  sess_dev_put:
>  	rnbd_put_sess_dev(sess_dev);
>  err:
>  	kfree(priv);
> -	return err;
> +	return ret;
>  }
>  
>  static void destroy_device(struct rnbd_srv_dev *dev)
> -- 
> 2.28.0
> 

I don't think this is a proper fix since the root cause of the warning
appears to be that we are ignoring the return value of
rnbd_bio_map_kern. Should we not set err to that value like this
(completely untested)?

Cheers,
Nathan

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 0fb94843a495..1b71cb2a885d 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -148,7 +148,8 @@ static int process_rdma(struct rtrs_srv *sess,
 	/* Generate bio with pages pointing to the rdma buffer */
 	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
 	if (IS_ERR(bio)) {
-		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
+		err = PTR_ERR(bio);
+		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", err);
 		goto sess_dev_put;
 	}
 
