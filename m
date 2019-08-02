Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9DC19759
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 01:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0E7206A3
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 01:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mgfAWNAd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Nq1S2cty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfHBBHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:07:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43364 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbfHBBHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 21:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564708058; x=1596244058;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+7ltFzWWSD1CF3GHa44SnNZQWVpk6t0nxCUU96kG9os=;
  b=mgfAWNAdcW3r1GqOhrdcONkc1vxjFVmEgVD9n9RB6+LxOSBbvJysv1Ce
   3GER4sKpJ4Ox8jkMhsjgOF5oyPbSVEvUIoDdYxYWS0eTkmQ6sN/WKuwMY
   6xA8vSh7P+6y9QpZ8VGhtkrNh+apZFN5cxFLlSmGUm1r2fqHOmYfT8+s+
   +0hFd8V2GJc3MVm5jGIW56mKCASHh8H+7KVJsGSPeIF31R4RglLyWFd7H
   2/dJrF1iKMLT8Dxd0A9I35Bu8XiMnYYsNYZdNAAKknbKxevKaXXjMsJT4
   aNP98Kmoxg76KcNhWK4UyuBqE5MXibLebreq7hzZz2FU2VV0CsSwZ4OF6
   A==;
IronPort-SDR: sJu0iGOHD5BGZMqd2ygHeK+CjbC9K4MzaQ3OG6I3ZLFbCZXrAvOhdfkeGzZsvyO7RiOpMzzxHY
 Avme+ajz9NWjljAuqW3PVY0lUHvYdPgZySvUJRASCvwzyNsCoEfv6wi+QS0sjGkiGIdHXHtw7+
 uS7Bqh8IMojDrXGXPjC/ynkeQbYqCcIiLWYZdIX3dlct2Bk8m/gXvyF8j9BUeUWC7U1JX2bCAy
 1O/aRSPJ4bFGNdeVbIsrHuEfU62AbN7zpvDxuiDUG0YhFxepVbW6KyUXh1XcmwVbbXzPB/UaQh
 A8s=
X-IronPort-AV: E=Sophos;i="5.64,336,1559491200"; 
   d="scan'208";a="115755109"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 09:07:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/+LoAAyoYSXOuPmm3hHq2ZKgnHmha16XNaejyPtRuvTeb1q4giEqznVnGqQVo3zw1gXXqrDtQMHorUb8hCdYV02OlxNTk3keUxx+uxdwV3FXeOJwIE2LZQUN0Sax/WZMWzgITxKM7v4OKgaAqwzBiQ0CEmk09zxc15ZNnXtBth1PeiIJ+Naj8PAPOmF004Y7Ym3wXVXmZxS4VrXUrD3IqhMbhLtRwlWmdWvPcI4yQPHeLKSbK/nyWRSnVFH+LvNCRPlDzUBESSoIuMSobjyDNjfzUxp1iAh5aOibrRR5BbwKOQ/mOy8WwbW3SdmFE/DmdVxECCeZ1R58bOnc3vKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFfWFfAIMBNzsPTd4o8MSA5aL+9xvaz33X/kr5NHCCo=;
 b=U7DDWBAdXiOh9ljjcLYZPXmled+UP6AllhYOgCnMsBb0XuBH5p8TiUz+VGhqVJnRokApCYSxnOz484cZv8l1TK/56BTCS3KfOdqqsrbjaA9NNUQv0YMKRlHJUclTXDwOUSGgMjtnqusIFo9pFW5BlZsRtSak9b6j6yKR2mEEtvpYeN+PAvA3r6MCHTdLYQjivbiRAALD+QakMU873evWCHbMv2NzazD15yfZ3BFuDe9XuOIicxKNJnKX7tPJiV/2f0P/ttYsunA6ulrgeb2qkJXoAA8ec4nn+UEkQd0PrWW/DE17Lgc5nY3eYayfR5f3mhc3BZAecjLBtTQ5iAkFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFfWFfAIMBNzsPTd4o8MSA5aL+9xvaz33X/kr5NHCCo=;
 b=Nq1S2cty+Sg8NSpypeEQ0u6CKyEzmwIjRDz5OjnhPplfKn+qA7Vu/Je/sEmSdjOMbeGFN2hph/wPX69FFQEupbz8tULMTvw1ZOaegE8981krRpotGp3Xp62py2KbItsbBsG7bv0CczYirIwAHSs4wmPL12/aVc3ld7TLVgeGUts=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4103.namprd04.prod.outlook.com (52.135.216.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Fri, 2 Aug 2019 01:07:26 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 01:07:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH V2 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH V2 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVSI5o3BN681RaXUGmIyildT++Bg==
Date:   Fri, 2 Aug 2019 01:07:25 +0000
Message-ID: <BYAPR04MB5816E0755EA3A1D90C8FA63AE7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
 <20190801172638.4060-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08cbb364-3c6d-41ea-d710-08d716e5c84c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4103;
x-ms-traffictypediagnostic: BYAPR04MB4103:
x-microsoft-antispam-prvs: <BYAPR04MB4103A4C3A94AB5F12296A740E7D90@BYAPR04MB4103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(5660300002)(8936002)(81156014)(2906002)(8676002)(6246003)(66476007)(26005)(66946007)(2201001)(7696005)(3846002)(71190400001)(53936002)(53546011)(7736002)(76176011)(110136005)(6116002)(52536014)(7416002)(91956017)(76116006)(54906003)(99286004)(71200400001)(66446008)(256004)(9686003)(102836004)(55016002)(86362001)(229853002)(6506007)(81166006)(14444005)(6436002)(25786009)(66556008)(64756008)(74316002)(446003)(305945005)(4326008)(2501003)(33656002)(476003)(14454004)(486006)(68736007)(186003)(66066001)(478600001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4103;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZR/h3M15miQS3icTZdcp9euzsHvKALXp1KMj50XVLnniaj//FZ3coCYrwVFCo1RVekP7uCLpenOn9fnKuNK0wt1GjiYIFg54FOPpwnWGgumPEnXd5b/j5OmUL/cUzjARvLhbfFS3bNRH35qSnIfRG/bdlvRBiX/FLWsvz9p/wKn0B1JzKIGQYgEy6u3AUO/e0We+Y2EOx0vi6Jo+AMdlqLuf4Wf3HFY//lac9tsEssVlMTOpjAxzU9z0HufPFmWVq45cCRAJIJOPphd/UMuwd54WgnAwvKc4MptxsJT1M1ZSAR7/seOEd5AibzGH+ePwIOiFCVVZFlbXM8TWRtwOX42NC4UgTe9c99ml7cS0PtFV85e4qQ2TJ7M/v+XTN1TSrEqkHVirL7oICptGBGvu5xcOXb5B986VmOSU2oyuhHk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cbb364-3c6d-41ea-d710-08d716e5c84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 01:07:25.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/02 2:27, Chaitanya Kulkarni wrote:=0A=
> This patch implements the zone reset all operation for sd_zbc.c. We add=
=0A=
> a new boolean parameter for the sd_zbc_setup_reset_cmd() to indicate=0A=
> REQ_OP_ZONE_RESET_ALL command setup. Along with that we add support in=0A=
> the completion path for the zone reset all.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/scsi/sd.c     |  5 ++++-=0A=
>  drivers/scsi/sd.h     |  5 +++--=0A=
>  drivers/scsi/sd_zbc.c | 10 ++++++++--=0A=
>  3 files changed, 15 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index a3406bd62391..42ef930c4df5 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -1292,7 +1292,9 @@ static blk_status_t sd_init_command(struct scsi_cmn=
d *cmd)=0A=
>  	case REQ_OP_WRITE:=0A=
>  		return sd_setup_read_write_cmnd(cmd);=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> -		return sd_zbc_setup_reset_cmnd(cmd);=0A=
> +		return sd_zbc_setup_reset_cmnd(cmd, false);=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
> +		return sd_zbc_setup_reset_cmnd(cmd, true);=0A=
>  	default:=0A=
>  		WARN_ON_ONCE(1);=0A=
>  		return BLK_STS_NOTSUPP;=0A=
> @@ -1958,6 +1960,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
>  	case REQ_OP_WRITE_SAME:=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
>  		if (!result) {=0A=
>  			good_bytes =3D blk_rq_bytes(req);=0A=
>  			scsi_set_resid(SCpnt, 0);=0A=
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
> index 38c50946fc42..1eab779f812b 100644=0A=
> --- a/drivers/scsi/sd.h=0A=
> +++ b/drivers/scsi/sd.h=0A=
> @@ -209,7 +209,7 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)=
=0A=
>  =0A=
>  extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buff=
er);=0A=
>  extern void sd_zbc_print_zones(struct scsi_disk *sdkp);=0A=
> -extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);=0A=
> +extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd, bool =
all);=0A=
>  extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_byt=
es,=0A=
>  			    struct scsi_sense_hdr *sshdr);=0A=
>  extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,=0A=
> @@ -225,7 +225,8 @@ static inline int sd_zbc_read_zones(struct scsi_disk =
*sdkp,=0A=
>  =0A=
>  static inline void sd_zbc_print_zones(struct scsi_disk *sdkp) {}=0A=
>  =0A=
> -static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd=
)=0A=
> +static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd=
,=0A=
> +						   bool all)=0A=
>  {=0A=
>  	return BLK_STS_TARGET;=0A=
>  }=0A=
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
> index db16c19e05c4..c1c7140ea787 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -209,10 +209,11 @@ static inline sector_t sd_zbc_zone_sectors(struct s=
csi_disk *sdkp)=0A=
>  /**=0A=
>   * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.=
=0A=
>   * @cmd: the command to setup=0A=
> + * @all: Reset all zones control.=0A=
>   *=0A=
>   * Called from sd_init_command() for a REQ_OP_ZONE_RESET request.=0A=
>   */=0A=
> -blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)=0A=
> +blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd, bool all)=0A=
>  {=0A=
>  	struct request *rq =3D cmd->request;=0A=
>  	struct scsi_disk *sdkp =3D scsi_disk(rq->rq_disk);=0A=
> @@ -234,7 +235,10 @@ blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmn=
d *cmd)=0A=
>  	memset(cmd->cmnd, 0, cmd->cmd_len);=0A=
>  	cmd->cmnd[0] =3D ZBC_OUT;=0A=
>  	cmd->cmnd[1] =3D ZO_RESET_WRITE_POINTER;=0A=
> -	put_unaligned_be64(block, &cmd->cmnd[2]);=0A=
> +	if (all)=0A=
> +		cmd->cmnd[14] =3D 0x1;=0A=
> +	else=0A=
> +		put_unaligned_be64(block, &cmd->cmnd[2]);=0A=
>  =0A=
>  	rq->timeout =3D SD_TIMEOUT;=0A=
>  	cmd->sc_data_direction =3D DMA_NONE;=0A=
> @@ -261,6 +265,7 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned =
int good_bytes,=0A=
>  =0A=
>  	switch (req_op(rq)) {=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
>  =0A=
>  		if (result &&=0A=
>  		    sshdr->sense_key =3D=3D ILLEGAL_REQUEST &&=0A=
> @@ -487,6 +492,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigne=
d char *buf)=0A=
>  	/* The drive satisfies the kernel restrictions: set it up */=0A=
>  	blk_queue_chunk_sectors(sdkp->disk->queue,=0A=
>  			logical_to_sectors(sdkp->device, zone_blocks));=0A=
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);=0A=
>  	nr_zones =3D round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks=
);=0A=
>  =0A=
>  	/* READ16/WRITE16 is mandatory for ZBC disks */=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
