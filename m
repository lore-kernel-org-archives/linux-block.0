Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7029EFA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 01:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiJ0Bpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 21:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiJ0Bpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 21:45:49 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6372089977
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666835148; x=1698371148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wTrycu0yCLepbRsKzvRQe2YDaN2RazwoDNx7Z2eFFXQ=;
  b=hW8AfL6XuVcFoMekf/ZTDJW9z8D5F5KLqMHmA5b7TBJysAmJGghEHBId
   dnjp+gsVpFrZT99Bn/Yz3evayN8rt5Y2dMn5u4Pe9Tfy8lOFUJKy05+YD
   x5j3p5/IjBy3m5uQBrRUywJK+AiheoF0FFag29cZmtC7ofJaMAgwgd+H7
   7dFJRi58qv2nNkRSvykdeLithBv/pA6eDaRD/0zq4RVGmjCxTu0N5EYY6
   fKqHgfn9TCrA4viSEh6NIjFR91IoGkNQkXm1kDdhiW0QWRp8o1RKDfsTT
   QaNCVSe5yCS4IVMrCJEQGDMjwjHNPCwv9sWG3/9QfzVdt9S7+bigW7ZVD
   w==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="215193090"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:45:45 +0800
IronPort-SDR: qUO0SzvXljTGUzAi8r7JazT/0sFoTOYngaSltGqN2G4Cb+vO1WEV4n9O+hwn/preQ6NUd1/YU6
 IJgPNLY9g3QAy5ZJ+46Vk9adJlfF+3yhKVtnm1RL1tbUAhOrC/ECkddKgNYAsqvjayKT+Gcyvq
 H8hnnh8dP9MpDfLt5quNmWkNMoJQ1qBf5jqJsDimW7kXY8N01Cl1DYCXD9yYRelPHlrWFcMDhD
 s0lORlCIMByf86D3i02koZzyOezq+2e83XZwt8P4qU+G/qsf4gSW69CqOQJoDy+dIyNRwl1htO
 Lbin/UVKhdhZGMHYHRyVPpmG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:59:24 -0700
IronPort-SDR: jRS4z5kZReXTVcwLJOKoTjgR3brnAU7839qfXooQJzBNdQH5/4iFAX+p5nCr7asa+vJd8ffVj0
 G0kWJ8RUCpBRd70zY0ZHWwwfcjATjCRmvgXRLwhZxzOh1al2RZOypk9hxYnzNmcZEBcb0x3WCn
 nRY/NA8kVn4oQWCt+eCyme0g/WNviLyMNZhsQ6RKkDuvu5cMwYaIAwyW0EISDQPvMM468sqzwk
 5mMlhSUwJamSblh+waKBvB2W92pUl11DulSNpOsq3v9hLc4F6JKXX8H+xsOiqIuQPYCoSHf127
 PVI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:45:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MyT605fbxz1RwtC
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:45:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666835143; x=1669427144; bh=wTrycu0yCLepbRsKzvRQe2YDaN2RazwoDNx
        7Z2eFFXQ=; b=AlzjxwjgQFq1W155Jv7xM2lsUL9uiOX64jICKes4K3eW7A+UUlC
        gK4PbDbRvmg0TDdb7Xbe05l+uzj28gVqXomsJSjCJg08Rcrl60ymMkyoq88K3Awa
        KjIYi6O2hZXXH3neeqxK/g4MyajMZvy3vI3vVjEE7rQvlILO0aXjVp4PS2A799js
        iXOkfdW/f3lCD6RJMnJS6tDzeZHFsQqwiOnmPrqHXJq0ulfOB/01qN7MYdMuMEpD
        HLnheR2DOMjCNYDUBB2tpAAZ4Mcovntrk9egMKvaotiQcCopsOqGG4Dq7K70iMUc
        H/85efM7O+MesD7drnI68r475KbNdF2/jFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bo6R-vRgUBzW for <linux-block@vger.kernel.org>;
        Wed, 26 Oct 2022 18:45:43 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MyT5x4Xzwz1RvLy;
        Wed, 26 Oct 2022 18:45:41 -0700 (PDT)
Message-ID: <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:45:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693976-181094-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/22 19:32, John Garry wrote:
> Add callback to queue reserved commands - call it "internal" as this is
> what libata uses.
> 
> Also add it to the base ATA SHT.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-scsi.c | 14 ++++++++++++++
>  include/linux/libata.h    |  5 ++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 30d7c90b0c35..0d6f37d80137 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1118,6 +1118,20 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>  	return 0;
>  }
>  
> +int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
> +{
> +	struct ata_port *ap;
> +	int res;
> +
> +	ap = ata_shost_to_port(shost);

You can have this initialization together with the ap declaration.

> +	spin_lock_irq(ap->lock);
> +	res = ata_sas_queuecmd(scmd, ap);
> +	spin_unlock_irq(ap->lock);
> +
> +	return res;
> +}
> +EXPORT_SYMBOL_GPL(ata_internal_queuecommand);

I am officially lost here. Do not see why this function is needed...

> +
>  /**
>   *	ata_scsi_slave_config - Set SCSI device attributes
>   *	@sdev: SCSI device to examine
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 8938b584520f..f09c5dca16ce 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
>  			      sector_t capacity, int geom[]);
>  extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
>  extern int ata_scsi_slave_config(struct scsi_device *sdev);
> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
> +				struct scsi_cmnd *scmd);
>  extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>  extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>  				       int queue_depth);
> @@ -1391,7 +1393,8 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>  	.slave_destroy		= ata_scsi_slave_destroy,	\
>  	.bios_param		= ata_std_bios_param,		\
>  	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
> -	.max_sectors		= ATA_MAX_SECTORS_LBA48
> +	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
> +	.reserved_queuecommand = ata_internal_queuecommand
>  
>  #define ATA_SUBBASE_SHT(drv_name)				\
>  	__ATA_BASE_SHT(drv_name),				\

-- 
Damien Le Moal
Western Digital Research

