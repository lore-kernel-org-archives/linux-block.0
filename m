Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A99C3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 11:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjAFLFa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjAFLF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 06:05:29 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB56E0D2
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673003127; x=1704539127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ppI2ADbPh92LEZhl0iWNA6l1Q71OYI1WvrdKjfPvkU=;
  b=GTRGPCkcUFii6x2W0nKKd8VJ1q7Zc2RiIfC2Q8VL4LfWXVsdeNQ1eWbK
   jp0KUQdx4Q53Uog3pyX28Fbegqha4bFQz5HMwbdj4jCZOBNDbgtEGeviB
   jzKTcDUy9O5wIjG7K7hx5JDP7v3zXfONTf9FMTIe6ww4VmphCjENqrMKf
   kDQ6yfENSICXj5QylJfaA3ekm6Vl3GcaMDJiOP14BG8TpGT/ZcpRmgcx9
   PC6G/7a4sDW8xhKSWdlN9B+FnKANjdnP4LymaN9WitcTdgibBG9xWb3ix
   8A329g4zIOR4LOMK6Py9CCGjkmZTSHSZYJB9UES5H4mJNPCgHWollWQKt
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="220054084"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:05:26 +0800
IronPort-SDR: 4wUSB9g0oy5e029Y94XbBrvGZl0dJlmJpQZVjry+XvmCV9D2VXHKFt0Cs1q1iRyg8v5HL6Del1
 /zAdrQqZZkLp8Vhi8q7GCVVmUhhN/lNoA2FN8/kLjUedyhFvZ1e6oVDDmr/k1Knh7zVpUup5T3
 WdBAKE6N4zKkNRzzpczWzn3kGI5KY2Tje6pK1JsoFRrIZmZZ10XhwyXlC3DlWqv538Mfajy9FS
 vKw6XiGZBPZw2mOkfnFWpMmlxVFEuI8VKZ3Wh6md1ImJ6/+Wj9tag4/dh/DDpn9hZ6fola9HMo
 FxQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:23:21 -0800
IronPort-SDR: USJYM6Kp2p6oZ41Y/PsAqsl3utUYcz6QG2I7FVcpMjTdVk4TBoi7STXRON/nEKg7r0tKkSGpiC
 3NWvetj9wlJjHApQp3TVZpSmE+aGXuG+fvkBADoAEMbCfYUx9YkzUV5t0d0kFjpppLLaNdji3m
 w7sxTXX3K/fwX+II8kqHznKy4O2G9lO2MRLiFAfbaxtUe4nb7aWgCkk3zF5Grsg2hQmBoeoygY
 xpHRunT6BtKRNbPV+WY6pPj/SF4o7wZ1qPzl3EMEHFwnt76igDcfbvoGDhdWJEH41HggNxmML0
 zSg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:05:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL922R0zz1RwqL
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:05:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673003125; x=1675595126; bh=6ppI2ADbPh92LEZhl0iWNA6l1Q71OYI1Wvr
        dKjfPvkU=; b=eY8kjWzmn9wZSzKEZAguHx/VZkReXQs5zaH7Rf1ksAOkIUiIG2D
        Sg8x+oX4b1xCUJhHpLmSurhvFw4PsDvpxYaXaZHbf8U1z2hwdgSI957H33SmYv9F
        rp/kavzKuh0+qbO+Zt+W7u5BUkI0R+9gpeI/oWL6oAWZkZ2C+/Ni4qbZUDsXo7w5
        /VDhEjNCH7zNK1nDCaq84+J6R2IM9I5KbiWbDFUIKeOFqOjiufofDZroMMGIEgO/
        xecfYhJeEGLPjqyZ6JENptrcgojcXfqk0DYRVEwu97W9sXK640ZVGBrN49yDT0EK
        WvAlPZbEwx1ayzySGTS7Oh1UyII9ualn1hQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a4809HjytgFX for <linux-block@vger.kernel.org>;
        Fri,  6 Jan 2023 03:05:25 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL8z4YCqz1RvLy;
        Fri,  6 Jan 2023 03:05:23 -0800 (PST)
Message-ID: <c9cdd392-f4b6-1500-30b5-7a04bdf83786@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:05:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] zonefs: use bdev_zone_no helper to calculate the zone
 index
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698@eucas1p1.samsung.com>
 <20230106083317.93938-5-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/23 17:33, Pankaj Raghav wrote:
> Use bdev_zone_no() helper instead of opencoding the logic to find the
> zone index.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/zonefs/super.c  | 8 +++-----
>  fs/zonefs/zonefs.h | 1 -
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 2c53fbb8d918..c2ddc62e99dc 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -487,7 +487,6 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  {
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	unsigned int noio_flag;
>  	unsigned int nr_zones = 1;
>  	struct zonefs_ioerr_data err = {
> @@ -502,8 +501,8 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  	 * size is always larger than the device zone size.
>  	 */
>  	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
> -		nr_zones = zi->i_zone_size >>
> -			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +		nr_zones =
> +			bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);

This is a number of zones, not a zone number. So this at least needs a
comment to make clear. Otherwise, I find this confusing.

I would also prefer you hold on this patch. I am about to post a big
series reworking many things in zonefs. That will conflict.

>  
>  	/*
>  	 * Memory allocations in blkdev_report_zones() can trigger a memory
> @@ -1420,7 +1419,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	int ret = 0;
>  
> -	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
> +	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
>  	inode->i_mode = S_IFREG | sbi->s_perm;
>  
>  	zi->i_ztype = type;
> @@ -1804,7 +1803,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * interface constraints.
>  	 */
>  	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
> -	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 1dbe78119ff1..703bc4505b29 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -179,7 +179,6 @@ struct zonefs_sb_info {
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

