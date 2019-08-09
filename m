Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32564C31E40
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DE721783
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4DulV8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406111AbfHIKhn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:37:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35030 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHIKhn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 06:37:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id w20so94480599edd.2
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2019 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gkHgLX5V4UK1k65oAmLi6AaI1fLp95DsTyD8ddVvg6c=;
        b=T4DulV8TxFojoDQYSzeR7Pw8euIwMPWDYxN5hza55/up9neSAe4flVItDMJTKgRaJV
         48Os4L3VMRe3aodF+NKbesg+nRd3jXWdb6YnaDqhkCSSJFBRxtJryKWmTGhp2g+IN98g
         dl1Ic41fEEeuCHvxQj0mhaWqchMD62emhb74+Cjl347LKn46oGdiVbzP/ycN7KGAnJeR
         6qfClFC7/YV7U+nbjaERI1AdlhGoVxgRgQrw3+eFjrMwMY1uboqFpCyXOWCHP+dB8hbe
         PYMA2pRzX4sfAe7xdSUmnntOBqeGmCVrK+qSHpjPLbBx0yq1zPWh+YGQc4eAALYGGHkd
         P/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gkHgLX5V4UK1k65oAmLi6AaI1fLp95DsTyD8ddVvg6c=;
        b=Y6YGmp4qVeOjqQVpHGcBrfryjcb/drCh2szfjI2XA4QsSBYsTWUHU9TnMbh5fBCi7p
         HS1NOE3cJOTjG7DfJPMGQsBpXjnIIgBqpAcVYtJfderzeyROyX0lK2kYcGZqb5sllslj
         6dFV5xExKnl6dXEww+eyq8NmXLcGKMdzb1l6zXrg0nuF0eGfiRq0//xd+z2dQOuwhwO5
         LLUINDYuXhXEWtpAVR/uHoSWQvBS2aisAnIUpYJKWc4ZGo+ZeXp4HC7fpjh7NfU77DUI
         C8czI4zB2OU6d6ipTW2uPeLMrrL1povJg1GLwbJarC/AMETc2bjRMEcgQUb0BxysNKlZ
         KGvA==
X-Gm-Message-State: APjAAAWn3WL/x4igmv+oNtnKldSGJsDtj4csjKY1tjJ5rsnLbypOgIUs
        FOLaUzvMoT+XmQGB4y9FOvc=
X-Google-Smtp-Source: APXvYqyf0+dvpyryIztXTmG4LhWXax7jXVSq2Eh2wptKGDWY42sTFKm7MdLE4zb5PG2k0OQdoJBFBw==
X-Received: by 2002:a17:906:301b:: with SMTP id 27mr17718036ejz.12.1565347061441;
        Fri, 09 Aug 2019 03:37:41 -0700 (PDT)
Received: from continental ([177.96.42.43])
        by smtp.gmail.com with ESMTPSA id k23sm10183293ejs.67.2019.08.09.03.37.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:37:40 -0700 (PDT)
Date:   Fri, 9 Aug 2019 07:38:48 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-block@vger.kernel.org, Matias Bjorling <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -next] lightnvm: Fix unused variable warning
Message-ID: <20190809103848.GA24835@continental>
References: <1565342296-45355-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565342296-45355-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 09, 2019 at 05:18:16PM +0800, Shaokun Zhang wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> drivers/lightnvm/pblk-read.c: In function ‘pblk_submit_read_gc’:
> drivers/lightnvm/pblk-read.c:421:18: warning: unused variable ‘geo’ [-Wunused-variable]
>   struct nvm_geo *geo = &dev->geo;
>                   ^
> Fixes: ba6f7da99aaf ("lightnvm: remove set but not used variables 'data_len' and 'rq_len'")
> Cc: Matias Bjorling <mb@lightnvm.io>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/lightnvm/pblk-read.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 0cdc48f9cfbf..8efd14e683dc 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -417,8 +417,6 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
>  
>  int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>  {
> -	struct nvm_tgt_dev *dev = pblk->dev;
> -	struct nvm_geo *geo = &dev->geo;
>  	struct nvm_rq rqd;
>  	int ret = NVM_IO_OK;
>  

Jens went ahead and already fixed this one in for-next:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=f0e6f41669d9e07f45b472e4de33d7c233a847bd

> -- 
> 2.7.4
> 
