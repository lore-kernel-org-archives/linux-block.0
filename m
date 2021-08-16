Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F44AC4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 11:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D1663214
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 11:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhHPLaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 07:30:12 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:37574 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhHPLaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 07:30:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A51D1128112D;
        Mon, 16 Aug 2021 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629113380;
        bh=wMzqHVuwm82GtGhENkipKS10ab+jBE/QG/BQ1I0XbKY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IXt5smmEQ6vH2W8nZjjMQPoX2YxEdrGlWMYa95ziiw+BJMuqY+G+cAYNLa5j/7AxY
         tM40sS1f3ozHPt2IU1rNCU7SLBhvNL46UDbvwE8jyl8uvKYaJ1CqDZzvm8VT/waSch
         mtLClW3moF6mEiBJc0evdpt9337V8w1c5BbTIysM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RGY65QHdlTM0; Mon, 16 Aug 2021 04:29:40 -0700 (PDT)
Received: from jarvis.lan (c-67-166-170-96.hsd1.va.comcast.net [67.166.170.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 19CA41281128;
        Mon, 16 Aug 2021 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629113380;
        bh=wMzqHVuwm82GtGhENkipKS10ab+jBE/QG/BQ1I0XbKY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IXt5smmEQ6vH2W8nZjjMQPoX2YxEdrGlWMYa95ziiw+BJMuqY+G+cAYNLa5j/7AxY
         tM40sS1f3ozHPt2IU1rNCU7SLBhvNL46UDbvwE8jyl8uvKYaJ1CqDZzvm8VT/waSch
         mtLClW3moF6mEiBJc0evdpt9337V8w1c5BbTIysM=
Message-ID: <ca7576c640d2c0bf2d80aef3098849d3c25311ff.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 01/11] libata: fix ata_host_alloc_pinfo()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Date:   Mon, 16 Aug 2021 07:29:38 -0400
In-Reply-To: <20210816014456.2191776-2-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
         <20210816014456.2191776-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2021-08-16 at 10:44 +0900, Damien Le Moal wrote:
> Avoid static checkers warnings about a potential NULL pointer
> dereference for the port info variable pi. To do so, test that at
> least
> one port info is available on entry to ata_host_alloc_pinfo() and
> start
> the ata port initialization for() loop with pi initialized to the
> first
> port info passed as argument (which is already checked to be non
> NULL).
> Within the for() loop, get the next port info, if it is not NULL,
> after initializing the ata port using the previous port info.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/ata/libata-core.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 61c762961ca8..b237a718ea0f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5441,16 +5441,17 @@ struct ata_host *ata_host_alloc_pinfo(struct
> device *dev,
>  	struct ata_host *host;
>  	int i, j;
>  
> +	/* We must have at least one port info */
> +	if (!ppi[0])
> +		return NULL;

I've got to ask why on this one: most libata drivers use a static array
for the port info.  If the first element is NULL that's a coding
failure inside the driver, so WARN_ON would probably be more helpful to
the driver writer.

What makes the static checker think ppi isn't NULL?

> +
>  	host = ata_host_alloc(dev, n_ports);
>  	if (!host)
>  		return NULL;
>  
> -	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
> +	for (i = 0, j = 0, pi = ppi[0]; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  
> -		if (ppi[j])
> -			pi = ppi[j++];
> -
>  		ap->pio_mask = pi->pio_mask;
>  		ap->mwdma_mask = pi->mwdma_mask;
>  		ap->udma_mask = pi->udma_mask;
> @@ -5460,6 +5461,15 @@ struct ata_host *ata_host_alloc_pinfo(struct
> device *dev,
>  
>  		if (!host->ops && (pi->port_ops !=
> &ata_dummy_port_ops))
>  			host->ops = pi->port_ops;
> +
> +		/*
> +		 * Check that the next port info is not NULL.
> +		 * If it is, keep using the current one.
> +		 */
> +		if (j < n_ports - 1 && ppi[j + 1]) {
> +			j++;
> +			pi = ppi[j];
> +		}

This looks completely pointless: once you've verified ppi[0] is not
NULL above, there's no possible NULL deref in that loop and the static
checker should see it.  If it doesn't we need a new static checker
because we shouldn't be perturbing code for broken tools.

James


