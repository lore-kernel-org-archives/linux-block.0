Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C950C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB32146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SceZ3EYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBB32146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeK3VDM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:03:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3VDM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 16:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p6IDe3bNmVkdaqZzqzDEjWVzPy/63DcTYLmFYB4F5G0=; b=SceZ3EYkvE8T71CX9GkyfDZS4
        otcQyrPL1cYn89V2MIKJAD8qdIX8lhfrBtcd9ddngw4Yos8ezI6xzzUcXOi1J/qXlH5GzNYcEuSs6
        ESpF1WyHF3HFmgCHjz5Z3nqHa0mP4n14lC23NTGuarFdjFOxfo4kebs+trm9SfIF1LzCR/XOXjuzL
        C0hwMQJHHBgxP8ynhAA93j2tMrGSnnxB/qpCvsQlCC2ZqqBVwJK5eRBJDyJRcxFgPkzWe2dHYx89V
        XGRCRR/dJ5NhIbOMbbaFTFt/Pkv1befuvT9WTQPLRyHzdIKFHhZfafqI7OsGrtSPuJinKua9tByPb
        9aBtDJfcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSfVC-0006ap-Kg; Fri, 30 Nov 2018 09:54:26 +0000
Date:   Fri, 30 Nov 2018 01:54:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] blkcg: associate blkg when associating a device
Message-ID: <20181130095426.GB17103@infradead.org>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-6-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-6-dennis@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 62715a5a4f32..8bc9d9b29fd3 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -486,6 +486,12 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
>  extern const char *bio_devname(struct bio *bio, char *buffer);
>  
>  #define bio_set_dev(bio, bdev) 			\
> +do {						\
> +	bio_set_dev_only(bio, bdev);		\
> +	bio_associate_blkg(bio);		\
> +} while (0)
> +
> +#define bio_set_dev_only(bio, bdev)		\

This lacks any explanation on when you would use bio_set_dev_only or
bio_set_dev.  Please document why we need both and why you'd choose or
the other.
