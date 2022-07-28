Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15308C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 03:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiG1DQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiG1DQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 23:16:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E2EAC
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978177; x=1690514177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dgNNYral1PZUbj2wWm9r5vHUxNg+nAHsDtFwSnOitJs=;
  b=VtSPgNNIAiPRX3JvCqvljE7+ExX0K+X2WhXXS7vKO/U0AxJffsR1iQai
   nXwxl7JkUGdTxHhN6G2vG70HJoiWjpobzAdzYBJgUb6A7EU9C9zBGMVl8
   5T49oxrbAd5BS1WcxG79B8vdmCjCF7v34pHBYI6dti25yOHEy8LllOU/F
   w0JLVNiiQC6W+ai2djagezJSyhKohpOAFTrmN5WUvbcOOSwtGT+1D/QHO
   X3zcsm3gcC+y/qRcGsB17eUghjEcWVkiQJzjdNw+gxd8VoEB6QzC/McGG
   mXsFBupd93qVko38S9PSvSTw941pQj4jpiCNFXzxL2fP9hoXwbkf9Gq7B
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="207109083"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:16:17 +0800
IronPort-SDR: vKFRwAVYd9YNzrBPfuWVdIXqGUfE6ECXIVoy+XDZM9soocI/GBVvXmdOsKKBpdlg8X/LaC0v1b
 szoNd9aTa8k7vAZoFqlou7v/Q8Ks10yVYblb57w2tknl7ePWhHauLY77v4ha3v5SInIMPXCMUx
 /lqv+DWLatGCpDBYs+ly2dZtOk7n+LMOoiVy7a/HqxmIULIyKV641OnimUz9x1y0v+vHrCA+bW
 C6u7XPDJMfmHGIiZilHgNIzKwjGCvoibnhZC9ofEO1pqSzi/+/lOtoPORm929XAZjHkqUxx59d
 /RZAK2TGo403Wmp8XVDnzHyz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:37:28 -0700
IronPort-SDR: Au/SE/UoAhiYE4lplGTrX+2QrUljhG3QMWNQy12E4kSPWJlgdrwQl3fKBchWmvlMQHwR/Bkh3e
 C2xXVVU2256ejzsxWbxcYdWwv4ikAGbNqLCsJ0u03GIu7dF77KBKU1izAI1e5KXP4DpTalTrjW
 9WsxC/+TleWa/a8I758sNBZFMkRYkq4wOQC6HG5oinDS0Ufyhr6BWX+mGKvjPGIqir6o0o/1S5
 0bpz7p4KnDJCS60qg5EBklFhDrNW+XnfAoAAJt28JSgko3+JGk9RGHUq2NGhLPfJR2WckTmCiP
 k6Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:16:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbQT2mz4z1RwqM
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:16:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978175; x=1661570176; bh=dgNNYral1PZUbj2wWm9r5vHUxNg+nAHsDtF
        wSnOitJs=; b=R5e6i4Wx+Zk8ZxQNatmOznoYtBAQxg1SGYYWl4r16bvw6kCtOhF
        7nrOJa+fZNOBHginYxEkSfjIbEU7ZCHImAGv75zKkw+mdVvNi1LiV1JZ+RXDhJBU
        KD9I2zCAiS3ng1e6ssvmAQQrFP2K9lTPdmKxM9ZuIxqn3nOUGWn2z3OTj85uMTMo
        C2clIlBIqA5TToS3VWHZHXyaLnC90i8zh8XZBRXWi4Gqatwd6N9+aKzvZm0iYgpJ
        uTOp3HRi4GQauMo/lIWh+MqQ/RSBNMXdyGodC5gDUUKb+kqdjhkaA231ZreRltkh
        eO8mYYd/AkkfjnKASL9e8TZW/5ocqmCCUTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cODig2XHPOhh for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 20:16:15 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbQP5Dsvz1RtVk;
        Wed, 27 Jul 2022 20:16:13 -0700 (PDT)
Message-ID: <cf96b0e4-dbb1-350b-602b-a72682fca2fb@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:16:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 06/11] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162252eucas1p25be8b79231334fa0c759c2475859e93b@eucas1p2.samsung.com>
 <20220727162245.209794-7-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> The zone size shift variable is useful only if the zone sizes are known
> to be power of 2. Remove that variable and use generic helpers from
> block layer to calculate zone index in zonefs.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  fs/zonefs/super.c  | 6 ++----
>  fs/zonefs/zonefs.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 860f0b1032c6..e549ef16738c 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -476,10 +476,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  {
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	unsigned int noio_flag;
>  	unsigned int nr_zones =
> -		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
>  	struct zonefs_ioerr_data err = {
>  		.inode = inode,
>  		.write = write,
> @@ -1401,7 +1400,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	int ret = 0;
>  
> -	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
> +	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
>  	inode->i_mode = S_IFREG | sbi->s_perm;
>  
>  	zi->i_ztype = type;
> @@ -1776,7 +1775,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * interface constraints.
>  	 */
>  	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
> -	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 4b3de66c3233..39895195cda6 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -177,7 +177,6 @@ struct zonefs_sb_info {
>  	kgid_t			s_gid;
>  	umode_t			s_perm;
>  	uuid_t			s_uuid;
> -	unsigned int		s_zone_sectors_shift;
>  
>  	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
>  


-- 
Damien Le Moal
Western Digital Research
