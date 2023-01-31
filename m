Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA44C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 10:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAaKYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 05:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjAaKYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 05:24:33 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7783A38668;
        Tue, 31 Jan 2023 02:24:26 -0800 (PST)
Received: from [192.168.1.3] (gsystem.sk [85.248.217.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 89F937A04D9;
        Tue, 31 Jan 2023 11:24:25 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 2/2] drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport
Date:   Tue, 31 Jan 2023 11:24:23 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com> <20230130211050.16753-2-linux@zary.sk> <e6041145-7336-2534-8449-7b9b6a842466@opensource.wdc.com>
In-Reply-To: <e6041145-7336-2534-8449-7b9b6a842466@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202301311124.23302.linux@zary.sk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tuesday 31 January 2023, Damien Le Moal wrote:
> On 1/31/23 06:10, Ondrej Zary wrote:
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index f1365608bc8c..de8aa561c95c 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
> >  obj-$(CONFIG_SBUS)		+= sbus/
> >  obj-$(CONFIG_ZORRO)		+= zorro/
> >  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> > -obj-y		 		+= block/paride/
> > +obj-$(CONFIG_PATA_PARPORT)	+= ata/pata_parport/
> 
> It would be better to have this in drivers/ata/Makefile, not here, so that doing
> something like:
> 
> make -j64 M=drivers/ata W=1
> or
> make -j64 M=drivers/ata C=1
> 
> actually also checks the parport protocol modules too.
> 
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 23588738cff0..2f85812e16ef 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -114,6 +114,7 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)       += pata_samsung_cf.o
> 
>  obj-$(CONFIG_PATA_PXA)         += pata_pxa.o
> 
> +obj-$(CONFIG_PATA_PARPORT)     += pata_parport/
>  obj-$(CONFIG_PATA_PARPORT)     += pata_parport.o
> 
> And then we could also have drivers/ata/pata_parport.c moved under
> drivers/ata/pata_parport/ to tidy things up.
> 
> If you agree, I can fix that up, that is easy to do.

OK, thank you.


-- 
Ondrej Zary
