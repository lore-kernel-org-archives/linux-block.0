Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E4C388F7
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B5821707
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="SlCn6jkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368842AbgJVP6O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 11:58:14 -0400
Received: from ale.deltatee.com ([204.191.154.188]:46900 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368827AbgJVP6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mGsxdGbyIvAWqUy9xZkX4iq2nhpPqIe9Zm31e9HjaQE=; b=SlCn6jkP9lDFNww1zr47YkPl10
        TZVs4PvKDL3U+du2tRYgqUo0kBbRq9rHP/tlX6IPHN2KFNc2xU8imvlJDnykNEp2+o4XoOv14KZ02
        iul0+bD/sXPe9fWR0OkPaOFa/BRmuX8o+UDlEjm2ChnQ5D4Zl3q/Gis+4QZTmuCRgEtPRzPdy42Do
        O20vCiXaLDyMOQ2592Y60ARM8s0W3bw5cKQh644aL2+7yxWFMIhBBRKc+Ha60KkpbRl/Ovr7D69yy
        nwYE5P1lC1cmUfqL4SdOYqcD2V/NXkz52GsjdRRN1hF2o4KInso36vgIRC98GwBwroew2fC2L9q6h
        qZd74tVg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kVcya-0008Ne-3L; Thu, 22 Oct 2020 09:58:05 -0600
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
 <20201022010234.8304-7-chaitanya.kulkarni@wdc.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9ba9c9ba-7caf-e24c-1471-62c199cfcd4a@deltatee.com>
Date:   Thu, 22 Oct 2020 09:57:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022010234.8304-7-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org




On 2020-10-21 7:02 p.m., Chaitanya Kulkarni wrote:
> In nvmet_passthru_execute_cmd() which is a high frequency function
> it uses bio_alloc() which leads to memory allocation from the fs pool
> for each I/O.
> 
> For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
> request allocation that can be used with preallocated bio when we
> already know the size of request before bio allocation with bio_alloc(),
> which we already do.
> 
> Introduce a bio member for the nvmet_req passthru anon union. In the
> fast path, check if we can get away with inline bvec and bio from
> nvmet_req with bio_init() call before actually allocating from the
> bio_alloc().
> 
> This will be useful to avoid any new memory allocation under high
> memory pressure situation and get rid of any extra work of
> allocation (bio_alloc()) vs initialization (bio_init()) when
> transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
> compile time.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/nvmet.h    |  1 +
>  drivers/nvme/target/passthru.c | 20 ++++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 559a15ccc322..408a13084fb4 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -330,6 +330,7 @@ struct nvmet_req {
>  			struct work_struct      work;
>  		} f;
>  		struct {
> +			struct bio		inline_bio;
>  			struct request		*rq;
>  			struct work_struct      work;
>  			bool			use_workqueue;
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 496ffedb77dc..32498b4302cc 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -178,6 +178,14 @@ static void nvmet_passthru_req_done(struct request *rq,
>  	blk_mq_free_request(rq);
>  }
>  
> +static void nvmet_passthru_bio_done(struct bio *bio)
> +{
> +	struct nvmet_req *req = bio->bi_private;
> +
> +	if (bio != &req->p.inline_bio)
> +		bio_put(bio);
> +}
> +
>  static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  {
>  	int sg_cnt = req->sg_cnt;
> @@ -186,13 +194,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  	int i;
>  
>  	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> -	bio->bi_end_io = bio_put;
> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
> +		bio = &req->p.inline_bio;
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> +	} else {
> +		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +	}
> +
> +	bio->bi_end_io = nvmet_passthru_bio_done;

I still think it's cleaner to change bi_endio for the inline/alloc'd
cases by simply setting bi_endi_io to bio_put() only in the bio_alloc
case. This should also be more efficient as it's one less indirect call
and condition for the inline case.

Besides that, the entire series looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
