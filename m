Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2FEC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjDFGaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjDFGaJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:30:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD59033
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:30:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so41944807pjt.2
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680762605; x=1683354605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QZn0HXB2PRMZIhY+m3c8yvbVQ6ARPLJekS7GXaw73I=;
        b=L8pnZiX47F7GsiURtBgeqa5qkbajhITx9a0oMnkDsnx7B+fC9fagkYOj45lDahdRWj
         wtCaPusaIwkSs0htbBx87u5h9jIV3Yt3jE2XIEVLkte9r6rwoCxg4nHdvHp0Pk201d1V
         IyrVKDEHDRfekwNA8ttYl1F62PAG52yHlya3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762605; x=1683354605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QZn0HXB2PRMZIhY+m3c8yvbVQ6ARPLJekS7GXaw73I=;
        b=4fTN28tE90VfUqLZEj71uX8zHIjdR49IX1/yFg6i94qJrhj3UkZ6DZnCGQp+LQgOv9
         K2Zd2OUhpZ8aOHhGvVNDJ98/V4tai7e1eHJFLP4O0YmLcoJHx3spuUmDEBdzlXYxFe8e
         jSLya92IxBK2suh+tw+WqpVS5z8yb6F67J/ozs2GUuHilwEN0cRHs+7ofKDtLG7ZPnK1
         0tdyc16azak5JuPWuWc44Fa5hG/1PbXy49ciZKxXogTTk5Z3mVXihvFExGrlG6ICrB1j
         AjNQjRF8j6JS9VOZUGgfwWzI3yVObU80yEMkLiivtkMXLwgyoVR6BTht4rdfAdbXizpk
         4TEQ==
X-Gm-Message-State: AAQBX9eywNfY4BOUsOQFcZerivBvTE4Da9dz3V9XG1g+i6UjZ/8DQXb2
        JQpLFEKNd6RMlmWoJ4Z2DCE6EasYY3SFSfoKdI0=
X-Google-Smtp-Source: AKy350bY+/jNbSkVhPSfWImK5U0jyybEX5GTU/ExQGrS8nKZVq0GoYwJSVJPpV6DM6VWc96qZODJ8w==
X-Received: by 2002:a17:90a:1a05:b0:23d:5485:b80e with SMTP id 5-20020a17090a1a0500b0023d5485b80emr10335134pjk.6.1680762604812;
        Wed, 05 Apr 2023 23:30:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902ec0600b0019c90f8c831sm577193pld.242.2023.04.05.23.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:30:04 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:30:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 12/16] zram: refactor zram_bdev_write
Message-ID: <20230406063001.GG10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-13-hch@lst.de>
 <20230406051505.GB10419@google.com>
 <ZC5cYKAgq/v5Ms7L@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC5cYKAgq/v5Ms7L@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/05 22:45), Christoph Hellwig wrote:
> On Thu, Apr 06, 2023 at 02:15:05PM +0900, Sergey Senozhatsky wrote:
> > > -static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
> > > -				u32 index, int offset, struct bio *bio)
> > > +/*
> > > + * This is a partial IO.  Read the full page before to writing the changes.
> > 
> > A super nit: 		double spaces and "before writing"?
> 
> double space afrer . is the usual style more monospace fonts such
> as code.  

OK, yeah I've noticed that in the commit messages as well.
