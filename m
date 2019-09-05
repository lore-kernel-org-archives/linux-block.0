Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D4C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880562070C
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbfIESEP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:04:15 -0400
Received: from verein.lst.de ([213.95.11.211]:50741 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403808AbfIESEP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 14:04:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 907B568B05; Thu,  5 Sep 2019 20:04:12 +0200 (CEST)
Date:   Thu, 5 Sep 2019 20:04:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 2/3] block: don't remap ref tag for T10 PI type 0
Message-ID: <20190905180412.GC24146@lst.de>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com> <1567701836-29725-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567701836-29725-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> @@ -186,7 +186,8 @@ void t10_pi_prepare(struct request *rq)
>  	u32 ref_tag = t10_pi_ref_tag(rq);
>  	struct bio *bio;
>  
> -	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
> +	if (rq->rq_disk->protection_type == T10_PI_TYPE0_PROTECTION ||
> +	    rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)

Maybe just check for the ones we want to remap instead.  And add
a little helper

stastic inline bool blk_integrity_need_remap(struct gendisk *disk)
{
	return disk->protection_type == T10_PI_TYPE1_PROTECTION ||
		disk->protection_type == T10_PI_TYPE2_PROTECTION;
}
