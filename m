Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC2BC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C61820869
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="V0w7TpRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAaVPB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:15:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38112 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfAaVPB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 16:15:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2057660pfi.5
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+YQ/3atzQhe7kDwM5s8R0RZc7/2O72lL1GRMhSTOtVw=;
        b=V0w7TpRY7Hs/ZGOdOG4+6nXdECX2O2DRn/LXeP1Oiz8u868HSPKFn/5SHJ4cwfIdTW
         G/sRtHGFRJQD6w6YK8jAZJ1Ch9w2g7v165yTd5iNMxr5im7JMkdTYMLtKr5B5h+GiHaf
         gmWbBKZodzWPQItVms77brhQVm9WbYWP7i/qA8xdj3Nbc6H9s4UFR1hY7rcJ3nhAZ2tR
         H1Btr2jzKbWo3tbmVxLSYhCnD8kWwMGVhoeEFS39oJSzoG0WPPTKSxhD5nwAnnzZMEV9
         PUVfDZjpAE5ZmLj4JCBS/YujVrsmKvvN6U4v/IMQjG0VVW5gi/J8o9u0tpqxxBiublf5
         a9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+YQ/3atzQhe7kDwM5s8R0RZc7/2O72lL1GRMhSTOtVw=;
        b=bNciKYACv/kaHyXYg8s+mjd/+01xCHy0c7YfW5qpcOnGoCQp/GXzIhR0NPeIwSDxy0
         vu8t/C1FWEBU9SAMtJsft013R8VWWLtnefChAKWhkewcHVJJ/OkgIB+Xtr+KObo5d5h3
         pa+kSfvONIyodAI3lsqyrj6AKPcMrdMwv7HS7ttFpvcgW17sNGXoY5txiSWreNj1LmOA
         yG15Pk4GUF2KnJJ6XSl5gdZN27LbN9oKReJ0/8LLbAl4xzlP68vSZkeaH9PfjDHEYQUD
         IiRmhSEkJzLFXefNgxSf4Oq7UVMAxzH8h10noOpbFXZ6hEuQN26HG4JJ7i2WEhSy2Vgx
         jg5g==
X-Gm-Message-State: AJcUukdWEpJRVH41C01nzNen/qqi/1oYMk5j+/hoFLfVYh+eW6URRcj8
        gGDlHunTxGM/ZRu8/rvTX3nwWw==
X-Google-Smtp-Source: ALg8bN6cN8XXCRPwRpXlY0OBLh0GFhczwh0GTHwyim232rqZa1i1Eqm2ZJhAYYImPt/scblMJc533Q==
X-Received: by 2002:a63:2784:: with SMTP id n126mr33434530pgn.48.1548969300618;
        Thu, 31 Jan 2019 13:15:00 -0800 (PST)
Received: from [10.111.68.238] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id h9sm8056434pgd.53.2019.01.31.13.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 13:14:59 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: fix bio leak on large sized io
To:     chansol.kim@samsung.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "javier@javigon.com" <javier@javigon.com>
References: <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0fd83092-515e-7e59-bc38-66e1d3b5d9c1@lightnvm.io>
Date:   Thu, 31 Jan 2019 22:14:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 2:53 AM, 김찬솔 wrote:
> 
> Changes:
>   1. Function pblk_rw_io to get bio* as a reference
>   2. In pblk_rw_io bio_put call on read case removed
> 
> A fix to address issue where
>   1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value (0xA)
>   2. pblk_rw_io calls blk_queue_split passing bio* pointer as reference
>   3. In blk_queue_split, when there is a split, the original bio* (0xA)
>      is passed to generic_make_requests, and the newly allocated bio is
>      returned
>   4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the bio*,
>      that is not the one returned by blk_queue_split
>   5. As a result bio_endio is not called on the newly allocated bio.
> 
> Signed-off-by: chansol.kim <chansol.kim@samsung.com>
> ---
>   drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index b57f764d..4efc929 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
>   struct bio_set pblk_bio_set;
>   
>   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> -			  struct bio *bio)
> +			  struct bio **bio)
>   {
> -	int ret;
> -
>   	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
>   	 * constraint. Writes can be of arbitrary size.
>   	 */
> -	if (bio_data_dir(bio) == READ) {
> -		blk_queue_split(q, &bio);
> -		ret = pblk_submit_read(pblk, bio);
> -		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
> -			bio_put(bio);

Could we kill the NVM_DONE_IO check in the pblk_rw_io, that should 
achieve the same?

> -
> -		return ret;
> +	if (bio_data_dir(*bio) == READ) {
> +		blk_queue_split(q, bio);
> +		return pblk_submit_read(pblk, *bio);
>   	}
>   
>   	/* Prevent deadlock in the case of a modest LUN configuration and large
>   	 * user I/Os. Unless stalled, the rate limiter leaves at least 256KB
>   	 * available for user I/O.
>   	 */
> -	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
> -		blk_queue_split(q, &bio);
> +	if (pblk_get_secs(*bio) > pblk_rl_max_io(&pblk->rl))
> +		blk_queue_split(q, bio);
>   
> -	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
> +	return pblk_write_to_cache(pblk, *bio, PBLK_IOTYPE_USER);
>   }
>   
>   static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
> @@ -69,7 +63,7 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
>   		}
>   	}
>   
> -	switch (pblk_rw_io(q, pblk, bio)) {
> +	switch (pblk_rw_io(q, pblk, &bio)) {
>   	case NVM_IO_ERR:
>   		bio_io_error(bio);
>   		break;
> 

