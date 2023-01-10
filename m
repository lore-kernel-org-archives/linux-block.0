Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC96AC46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 21:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjAJV6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAJV6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 16:58:14 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE69C5DE73
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673387890; x=1704923890;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sx2MAS8pFeR3d8yTCiM0ZjG2Pu+K8FMPa0JiFjW85iU=;
  b=ZGTsf768ne76qb9Vf/IQTdfERAKDT0cqwfNLNVPbNlMQVyKXJQhmQvFu
   ijvDoWASSq4VFtmf5sQ11IAVpP0JPEHOrnS4PGGpdiqiBKhA7xOUrNACq
   fT1qKYbdjhqcyIDnh+fV+omAbzYP5CUXGszSDBKkJMAAQi2mh54ax2yu/
   p6FKRC6BoIo32X2sVVDsnbuSzMilhXRRO8rCkcm9FLKZavWGCXQPGcLt4
   skS3dhbtHucKBD2I5/okoa1i7jMq5Ir4zYxzM4PW62v7yNCUDmNurbhe8
   nHF7WfIHClg8DNIxEEsQIfO5pbnql8m900r7jthB+bj0lArFth5iFV/Nd
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="218795506"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 05:58:10 +0800
IronPort-SDR: ZwOpdVs38CTzI/mjEqMM269HbSIf1d6H1anE+w6ujX0Ofi0PHuzlw+dEDT0xuQLduN0MCBvsmq
 KbZQ2nWe5kHGvzMCRKRTqajEecDyin5mVhiaUblRbMRc/cP6rT7b1CER+mLnQLJSF6YIitfOqg
 vAHq6Q1lcmhyflrWyX74kmvciJohvFjl0NE+Okvpy/lOQf0nKuHJucA/sRSgc4oWXx4x5U7IDe
 UFnNz58amS+rDKBqKj0PhM6Wg9lYRNfwjMQAPl9LRhT+CFAr070lrHmo+/x6+yIcooQRK8ayY+
 HMI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 13:15:59 -0800
IronPort-SDR: B9XqV0ehYPi7jQ9EHHM2co5W1WA2SfocJHgjWomK9kgsnC/0qkhZz5w03vNZ5ShrMOgmvgVf8v
 dB6jslyGO+2MQ/M4/DAdZau/GRQ6QNBkhaPydmrrYHGlkpcWVu3Z06v9P+xX50IieHnO2Lv1F0
 RzlBm5msrs+rolNzFArRf5UrTz6yZ3f/TLUGWL7oJfv6LBKQkX1XN63TC5VVo/guMipVNZOUag
 3xCA+AXwuh+Swt3hBuIHtGuHMarxdd3aR0rq/dsuQKUIBuv7jj8rjcKU4VylsfyxxXJUxEs4m5
 ByY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 13:58:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ns4SK5jJ0z1RvTr
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 13:58:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673387889; x=1675979890; bh=sx2MAS8pFeR3d8yTCiM0ZjG2Pu+K8FMPa0J
        iFjW85iU=; b=lMvCKLgtsfjf5TvcK324BQKzGgxPFLXkUSFQWnv6KlpMbyRgCE3
        LoEM2iW9mt8oG2lCc7sgOPRTXLxydMOoX2RRmlwIi2s/BQcrzNdJj8dRXm9pxE/u
        UHepmzmEO+V4/TDdHuwFdpOKc1baIEmSI08/eaT7Eq6nFhf7VGYvG+gIMgS1+u0V
        keVQHHXpI5uRRw6WXf0W69v0Egr7IrjJAkuLe0Lx38ROZBz9oqgfPGHBHNvcFJDh
        J5l/EFOl/n1sUPzaEquLff3D2HnkqLL+W0h7zO3WTSHjCsJTVE4sjHMfAp2Sx1Ow
        VrXMpaxu4tKXZ6WA9ATX3BbCcni2WzQ50xg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 45E4hzT7ZjnF for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 13:58:09 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ns4SJ24Jkz1RvLy;
        Tue, 10 Jan 2023 13:58:08 -0800 (PST)
Message-ID: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
Date:   Wed, 11 Jan 2023 06:58:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
 <20230110132710.252015-2-damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230110132710.252015-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 22:27, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
> 
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
> 
> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
> these are data write operations used by btrfs and zonefs and may also
> have the REQ_FUA bit set.
> 
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

Christoph, Jens,

Are you OK with this patch ?

I am going to queue up patches 2 to 6 in libata tree as we have another
series on top of these patches (CDL series rebased). Jens, if you could
take this one in the block tree, that would be great.

Thanks !

> ---
>  block/blk-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..c644aac498ef 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
>  	 * Filter flush bio's early so that bio based drivers without flush
>  	 * support don't have to worry about them.
>  	 */
> -	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> -		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
> -		if (!bio_sectors(bio)) {
> -			status = BLK_STS_OK;
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE &&
> +				 bio_op(bio) != REQ_OP_ZONE_APPEND))
>  			goto end_io;
> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> +			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
> +			if (!bio_sectors(bio)) {
> +				status = BLK_STS_OK;
> +				goto end_io;
> +			}
>  		}
>  	}
>  

-- 
Damien Le Moal
Western Digital Research

