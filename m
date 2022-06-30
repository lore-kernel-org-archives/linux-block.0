Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106EFC43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 23:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiF3Xgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiF3Xgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 19:36:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319159243
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656632201; x=1688168201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r6X2OyF2LdVH/Zai5tVsKfvSmmEUG4X69PY54341eWI=;
  b=UWJ02sVsRmCJjGakgYZ6U53EplMRnRwUzQflR/3Gr2FcwI+O+B4iJlS+
   xsRLrvjgvdUdDOUe93OnZxMvuJnjrIhCr8CTZGRrSrffpwvZMb/siqeKB
   GqOIaBovlYK5qCLu6J7l1xT31Sx+DmG9FOEIbT/QeSMiSzVO8l0/gFBQN
   Ce6BGR3MiXSr80ebvGg53q6C6SdNdUzBbgVsk5pSKNNpKjmCeQ18ahHWx
   p0/1q5X4SSHIED+pDviBkTPVmg7wWGMqHl+ISeorhxN/oFXHazdlMXTxe
   bqcxuudR5nBD01/HIlBOYOEY2VAGBaE0igMzCqHaTWxDoCXFX9NoH5H/E
   w==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="316648476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:36:41 +0800
IronPort-SDR: JKRZI40omYqV2UoPk1jtJ8sXLJ+PoJSp9W/4BFEklG6TpGnqBFIoGdOiq3OejOkMXeFyxtSta1
 L6JhuPDaIIEdU2ZlqMrxE+P54txZeG1DG7QoqjdhO9yl1OOXNeusgUEBuwIp9N+on3KzULRQQ2
 hOGTJ80REkx1iomY2aicDawuNWdo+HRJ++7PtFuOCjGT/5pk/JHKdWh6Hz7b0ElDiPfEKYrZGp
 p0jOmYNhXBCS8nxwGBx7c3fLUxohExBZ/dibZ/dBonCPdrNFup2pYxUFWRr9TvnPNHGpNssTmt
 r/U8TOVv5qzXFaSx03bhqCsW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 15:58:53 -0700
IronPort-SDR: pu7EQYppsxYdF69y+rHutymI4bHPAgkdBc7P+SGrGRHtrzgPz38vqiJL2ARbCOfKk5BKXjHTB2
 Nx6ZiXuqE5NYWouYSOSyayAJZ46AVQCAQrNL4nqbhpNnemojM79GzGzfZX9zi9KICIc6WKoVzf
 vD9iBdjrEUI1BmGMxYDsvYEpPEDe5HNKrdjaRIYXKKweRBjqzn7a88ergA4tdjocq5pGf8SgUf
 xApwZGzkb3aney1IN8s18PLfPIL75+3MGreDiamzfV2xyl6x5nPbHH0SzwNKu7du+dQqsNON0q
 Xk0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 16:36:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYvqY00ldz1Rwnl
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:36:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656632200; x=1659224201; bh=r6X2OyF2LdVH/Zai5tVsKfvSmmEUG4X69PY
        54341eWI=; b=bHw+xjE2haAA8hTtQHcR8DwsrVuuE/98dBLSLOXUr9colarkLPE
        RJfKcKYlBClVEPAXgRrDyzWFanqvPLcOealFe93olwOccpDzazeotLqVtZfHJ1J3
        Z7ouQ4Bt8Cw/Q52mra7oi2xyrn2OF9w804oV6C2ZPBHV5uLr2dtQ2x80d9DQ1uo8
        Fl1soc8B+BL2yvLXpL84SpDNaOhYHaYY/ZK3Px6b/uBRpgTf37yb0y0bbIfMv0Dj
        dB9PIpHIncL1yh5taugdwFqyRFpF6ysWy/N3xeZ44Xai2I9qxOvaxpPL9HjG1D8k
        EB0Nqb8J8Powfq3vNYv3NvdlbK3nBgC1b6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LYtrcPT-u9C2 for <linux-block@vger.kernel.org>;
        Thu, 30 Jun 2022 16:36:40 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYvqW3rkPz1RtVk;
        Thu, 30 Jun 2022 16:36:39 -0700 (PDT)
Message-ID: <6c16aa7e-3e0c-5de4-e506-1b739d521a8a@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 08:36:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 30/63] dm/dm-zoned: Use the enum req_op type
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-31-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629233145.2779494-31-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 08:31, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for arguments
> that represent a request operation.
> 
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/md/dm-zoned-metadata.c | 5 +++--
>  drivers/md/dm-zoned.h          | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index d1ea66114d14..34db364c23a8 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -737,7 +737,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
>  /*
>   * Read/write a metadata block.
>   */
> -static int dmz_rdwr_block(struct dmz_dev *dev, int op,
> +static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
>  			  sector_t block, struct page *page)
>  {
>  	struct bio *bio;
> @@ -2045,7 +2045,8 @@ struct dm_zone *dmz_get_zone_for_reclaim(struct dmz_metadata *zmd,
>   * allocated and used to map the chunk.
>   * The zone returned will be set to the active state.
>   */
> -struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd, unsigned int chunk, int op)
> +struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd,
> +				      unsigned int chunk, enum req_op op)
>  {
>  	struct dmz_mblock *dmap_mblk = zmd->map_mblk[chunk >> DMZ_MAP_ENTRIES_SHIFT];
>  	struct dmz_map *dmap = (struct dmz_map *) dmap_mblk->data;
> diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h
> index a02744a0846c..265494d3f711 100644
> --- a/drivers/md/dm-zoned.h
> +++ b/drivers/md/dm-zoned.h
> @@ -248,7 +248,7 @@ struct dm_zone *dmz_get_zone_for_reclaim(struct dmz_metadata *zmd,
>  					 unsigned int dev_idx, bool idle);
>  
>  struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd,
> -				      unsigned int chunk, int op);
> +				      unsigned int chunk, enum req_op op);
>  void dmz_put_chunk_mapping(struct dmz_metadata *zmd, struct dm_zone *zone);
>  struct dm_zone *dmz_get_chunk_buffer(struct dmz_metadata *zmd,
>  				     struct dm_zone *dzone);

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
