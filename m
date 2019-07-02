Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1CDC06511
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8560820B1F
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb/Pk1At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGCAzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:55:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37961 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGCAzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:55:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so255833pgz.5;
        Tue, 02 Jul 2019 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOIwG5g5qmRLAvMNTG4avtQVbsGFIvybNsnInhl+M4o=;
        b=cb/Pk1At+z3oGkj9asXbRIPTNhtNNDhEo9ERURh8nDXjg9YfPprqQ0qQYHqhy6rSaF
         JJspKzFbPkoHBG1kaQbIKL4Etz6H7aOfya+lfGpEAx6RnbpVdTd7Rxs7T0tbO5UisAdO
         ZPS+HcJG5yjLZ5ZwaiZd06fGxx/3MPhHrBdRynVocTY4ZZQqWSgJAGtpgAcK2EM1t/IC
         ql85Jt+6SJaTpykfV7iCWdY664TUtO6aseDda3Coj6ovwBG5auhQYjx2CnWoovXC0vYV
         TGVurkVhHPuRr2MoDJiWpkQUxDkKogeLnLOiv6z74HHdSogerj7IJhsi3buT9J7QMe6q
         XOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOIwG5g5qmRLAvMNTG4avtQVbsGFIvybNsnInhl+M4o=;
        b=t56r4wwcSIATbWPyUQVUHoUfq2qmO8W68jYB7o0rPFN0yRjQUvu/CAE0hvxAs3H9JL
         p+uBoMc83Emy4mID6wbtSUlNEYRyAdNf1LhDDC7uoC2JgBMsPHj99Cbqg1Hzh7WFj26c
         2pq3WMXRYqodO6wrXOdwA3/A+mZFfDg067OHAuPxu/XSMrPve91yiiL/qIgDXK5oPaVj
         pTxlWSoouZ53BrGnfdfp1QvDsX0IqIH9XIHTgtyRFPl4kBu6CVxC51OyFZ8/vRiDovn4
         vgsbsEMZx0hDW26C2HLWdQH1KjF0DXWvWq31y8phHSIyUfr+TK9127RE4abGwm1W5b07
         xN/g==
X-Gm-Message-State: APjAAAVtMqMX5jNO4sq4RwWIpEo4jcGCBvnVWCqit4ChjxcJPKLi3VZC
        zeoAOT+uEDx/wGUsAV5iyNSH8iUxLEo=
X-Google-Smtp-Source: APXvYqz77rLbSyHhgcZyWseydKse1/eh4HWO31E2oh1XmlIvsC+gQNegzx8lDeCvxQG38H30v200vA==
X-Received: by 2002:a17:90a:2768:: with SMTP id o95mr8287011pje.37.1562108080227;
        Tue, 02 Jul 2019 15:54:40 -0700 (PDT)
Received: from continental ([189.58.144.164])
        by smtp.gmail.com with ESMTPSA id k14sm135388pfg.6.2019.07.02.15.54.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 15:54:39 -0700 (PDT)
Date:   Tue, 2 Jul 2019 19:55:21 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:NETWORK BLOCK DEVICE (NBD)" <linux-block@vger.kernel.org>,
        "open list:NETWORK BLOCK DEVICE (NBD)" <nbd@other.debian.org>,
        marcos.souza.org@gmail.com
Subject: Re: [PATCH] driver: block: nbd: Replace magic number 9 with
 SECTOR_SHIFT
Message-ID: <20190702225521.GA16741@continental>
References: <20190624160933.23148-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624160933.23148-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Mon, Jun 24, 2019 at 01:09:33PM -0300, Marcos Paulo de Souza wrote:
> set_capacity expects the disk size in sectors of 512 bytes, and changing
> the magic number 9 to SECTOR_SHIFT clarifies this intent.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 3a9bca3aa093..fd3bc061c600 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -288,7 +288,7 @@ static void nbd_size_update(struct nbd_device *nbd)
>  	}
>  	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
>  	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
> -	set_capacity(nbd->disk, config->bytesize >> 9);
> +	set_capacity(nbd->disk, config->bytesize >> SECTOR_SHIFT);
>  	if (bdev) {
>  		if (bdev->bd_disk) {
>  			bd_set_size(bdev, config->bytesize);
> -- 
> 2.21.0
> 
