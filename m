Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46734C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 04:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168DA20820
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 04:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlm86soP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfGNEIm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 00:08:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34128 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfGNEIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 00:08:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so12378418qtq.1;
        Sat, 13 Jul 2019 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q5bbMBPu8QAd1DDh2cADphw/jDT31bG60vG8iZgXrVk=;
        b=Wlm86soP0owNkaS5D/15LRYAhA7T7WYP33N64+5GNF4ggiSev76ploSXSsaUVKPiPe
         2y6kpVrp9cg4DRoexaM0V5pN3rKhzwXnsQ/G3LQ/ioppJbFZ/31aZMX2hbBc0h6mdbi5
         vkhRb0+H8g0XqZX1jkELmfGK4/K+ofYco2jPv5TdtG7nZkKmNztF6cG7/bx3CupDlKgg
         8bQgLLWvOCQG2DyfGIP9yf1TsT3R4GEqjydbKe8YMqW9r5u3sf5LtmDm8IyS4/XUL1N7
         00jYvuI6zZQReaoBTlkEN4MNR/H0QZLGVIRsPiCITaiF64isvqesrAtPK7rVDyymdoao
         LqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5bbMBPu8QAd1DDh2cADphw/jDT31bG60vG8iZgXrVk=;
        b=IBwfH32c5R60G0N6Cz4m7dLlbdFVTnVKqCwyhx4t+j1N+atbZpx0VixscqlK3F+vcM
         eQMmx3ufkSj1sl9uwDmDQeB5nUYgKhdr2UAnE+iKoUQ7/D+RSyJDaslIsfZBK47bo7kz
         rvFe2/H53JIy8QYoS69cVJ7MxF/Hd3Zz4CzzM/lLSBIbOAIs0O7N9aH0VXhDLuQsMKS+
         IdBYU2UnF9qoSi6/Rxa4whbRm39GkJwnp265x9dvqMFOHF5VMKW5VY41TetNyoEW9qcj
         vJf4GB+iUgK0Y/wkZYcirMtRNXXocTh1+FAzSX5kw7hYFxGvBVo27yPkNMMvNKFaDp/i
         neFg==
X-Gm-Message-State: APjAAAVdsnHUft+RmGEtl+LsrZR+rFbJZoObgh7mGK7abF61TNfRcgV8
        OWxOzw5AQec2RdGcpMEfPvhqgSmTxhs=
X-Google-Smtp-Source: APXvYqwqfxx+wBlC74G4VcmDDci2R9i7mtSetOxLk5fCVm11o3/3IJ60HklV9E5IZDAN1v/W5XqEjA==
X-Received: by 2002:a0c:b163:: with SMTP id r32mr13628757qvc.169.1563077320621;
        Sat, 13 Jul 2019 21:08:40 -0700 (PDT)
Received: from continental ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id i23sm6181565qtm.17.2019.07.13.21.08.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 21:08:39 -0700 (PDT)
Date:   Sun, 14 Jul 2019 01:09:33 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:NETWORK BLOCK DEVICE (NBD)" <linux-block@vger.kernel.org>,
        "open list:NETWORK BLOCK DEVICE (NBD)" <nbd@other.debian.org>
Subject: Re: [PATCH] driver: block: nbd: Replace magic number 9 with
 SECTOR_SHIFT
Message-ID: <20190714040933.GB19237@continental>
References: <20190624160933.23148-1-marcos.souza.org@gmail.com>
 <20190702225521.GA16741@continental>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702225521.GA16741@continental>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Tue, Jul 02, 2019 at 07:55:21PM -0300, Marcos Paulo de Souza wrote:
> ping?
> 
> On Mon, Jun 24, 2019 at 01:09:33PM -0300, Marcos Paulo de Souza wrote:
> > set_capacity expects the disk size in sectors of 512 bytes, and changing
> > the magic number 9 to SECTOR_SHIFT clarifies this intent.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  drivers/block/nbd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 3a9bca3aa093..fd3bc061c600 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -288,7 +288,7 @@ static void nbd_size_update(struct nbd_device *nbd)
> >  	}
> >  	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
> >  	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
> > -	set_capacity(nbd->disk, config->bytesize >> 9);
> > +	set_capacity(nbd->disk, config->bytesize >> SECTOR_SHIFT);
> >  	if (bdev) {
> >  		if (bdev->bd_disk) {
> >  			bd_set_size(bdev, config->bytesize);
> > -- 
> > 2.21.0
> > 
