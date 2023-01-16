Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324EAC54EBE
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjAPXbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAPXbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:31:16 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531AF3251C
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673911249; x=1705447249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ymX8dG3DFUvzpVOfFjC5ckfzfRrJmy8YIPmwNpCqKY0=;
  b=CJgQPzpBnXghXPkZPOKLCpxAWybubwX2xBJlznlv2Ox9E9DrDH8sTNsF
   vClwMlsB1M8xErGfea0Zs1F1Uar8VeSYSfYuDJyWy6M5CpgUI0MCPWAYQ
   bugnwNu+X4W0tMyBiGcprGPiEapkeIpr3UyuOSzjRUQahjpPABB2920ns
   IvOUgZH+Y4SDo5IKEFJEkgIBpEwt4bcL3nxJf0MIRGo94byJbeCx6Oufp
   cFeBDIZwWj+8mPL+xpjl002tS8uRnb007Fj1qM/WA7NEJDReV3dn78yHk
   DNMelsP6uRZbu2KsXP7COeZesTSHnYeLRyXrAAiX1BnhgKfzILtjBgQ0Z
   w==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="220789000"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 07:20:48 +0800
IronPort-SDR: OKUPsXFIDH4kRp6I+WbEqoCmy7v3wKUElMGwnzZeR9u1KzjGd8thuFM1og5ODPIMRzPZz2APmu
 qUHkO6eVXxZFaKTUXdT39+mRJtl7gzsUX4syIMFYufbUKj1zccqSgSHyf6oQvpD9R52JSKVYEI
 jOcSxFv6B7E6cnQ9X2i+oz+cPh2k78NgxTJi89x91wCnZ8pM/nMdJBBypmCjABedlPYWPqk8LZ
 eq6pApnmeAiw/Bx6ueF79RsTJBXsCJ/yCB9zC425zANVd1EA81gYhrVOpel1O0MAsp4xRprhQo
 wIA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 14:32:46 -0800
IronPort-SDR: /FEaMc3f4h30L7PakjnwdvhYbE6cwotfebD9CkzAr2QhxLW/DT5V01OUlL37B5TqvAS1I6L9bc
 4FlN1C1hZZt8rQydzPVxCqhJUM68qky8hT//iMAbJfqmXEQYNfzclR5n82b+QX9shFq7TAJvDV
 558Lf6Y+wDN47D0fH/GjCDgN2cdpY938jqv2Yvh26rsFC8kruhZJdVa35tl9ls0beyXuxi3LmO
 l1CfP/h/jPY5T2s7tLr4431aewPdBCsc4pfI7Fp6YW7eBWRRvgAcGG3Y7l1QQSQ2ENjcrtHX+e
 ZCg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 15:20:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nwp0v61ycz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:20:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673911247; x=1676503248; bh=ymX8dG3DFUvzpVOfFjC5ckfzfRrJmy8YIPm
        wNpCqKY0=; b=YUbgIka5HS5DYotZvjkX/OB1JA86wNyrmrN+44bisBItXpBG+kj
        vcYDcUO1E5/r7OseQvoA6fUZRsFItKwAzDPy/AMpJ7Mt5EP0y9kvCLPMNEGhZB9h
        /N9Jc6oKSOqQtj33qO+9SnzOF6iviUp5EF3NIk+zci0OUC68w1qeLtbuzZS6LQG5
        /Sh7txezFns2uywyJCzPpR15gAHSb2BUDorvIF1fTUF9E05czGaool4A4z8Evus9
        rMzHrO7zyJTi4eVapsmyZ463KYOeWMrYqP7DkF1UGLRkOVcFgLwIrJ4xRMiraK+d
        v/RsDL1vNDvPGinsXPMuGuP9IagPX7HzokA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3cw8RrpAY0cq for <linux-block@vger.kernel.org>;
        Mon, 16 Jan 2023 15:20:47 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nwp0t3JvRz1RvTp;
        Mon, 16 Jan 2023 15:20:46 -0800 (PST)
Message-ID: <7c69e3b5-c81b-a3ba-9588-9a59c32c45b7@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 08:20:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 06:06, Jens Axboe wrote:
> If we're doing a large IO request which needs to be split into multiple
> bios for issue, then we can run into the same situation as the below
> marked commit fixes - parts will complete just fine, one or more parts
> will fail to allocate a request. This will result in a partially
> completed read or write request, where the caller gets EAGAIN even though
> parts of the IO completed just fine.
> 
> Do the same for large bios as we do for splits - fail a NOWAIT request
> with EAGAIN. This isn't technically fixing an issue in the below marked
> patch, but for stable purposes, we should have either none of them or
> both.
> 
> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
> 
> Cc: stable@vger.kernel.org # 5.15+
> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
> Link: https://github.com/axboe/liburing/issues/766
> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Since v1: catch this at submit time instead, since we can have various
> valid cases where the number of single page segments will not take a
> bio segment (page merging, huge pages).
> 
> diff --git a/block/fops.c b/block/fops.c
> index 50d245e8c913..d2e6be4e3d1c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  			bio_endio(bio);
>  			break;
>  		}
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			/*
> +			 * This is nonblocking IO, and we need to allocate
> +			 * another bio if we have data left to map. As we
> +			 * cannot guarantee that one of the sub bios will not
> +			 * fail getting issued FOR NOWAIT and as error results
> +			 * are coalesced across all of them, be safe and ask for
> +			 * a retry of this from blocking context.
> +			 */
> +			if (unlikely(iov_iter_count(iter))) {
> +				bio_release_pages(bio, false);
> +				bio_clear_flag(bio, BIO_REFFED);
> +				bio_put(bio);
> +				blk_finish_plug(&plug);
> +				return -EAGAIN;

Doesn't this mean that for a really very large IO request that has 100%
chance of being split, the user will always get -EAGAIN ? Not that I mind,
doing super large IOs with NOWAIT is not a smart thing to do in the first
place... But as a user interface, it seems that this will prevent any
forward progress for such really large NOWAIT IOs. Is that OK ?

> +			}
> +			bio->bi_opf |= REQ_NOWAIT;
> +		}
>  
>  		if (is_read) {
>  			if (dio->flags & DIO_SHOULD_DIRTY)
> @@ -228,9 +246,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  		} else {
>  			task_io_account_write(bio->bi_iter.bi_size);
>  		}
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> -			bio->bi_opf |= REQ_NOWAIT;
> -
>  		dio->size += bio->bi_iter.bi_size;
>  		pos += bio->bi_iter.bi_size;
>  

-- 
Damien Le Moal
Western Digital Research

