Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8299FC433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 01:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B2E214DA
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 01:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R9FIKSSL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F6tzRf+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfHABBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:01:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26544 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHABBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 21:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621267; x=1596157267;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5YjdwEDVJvnHQTzHVBUv6y+Iw6I3/O+johIOHMeGLIo=;
  b=R9FIKSSL1PGzb5uvHKO/uVbdJTkJSSMiE+6XexvamsrgUeOfz6dhHH7d
   9Pzu0M6/XJc8JMxosv+MSUPioX8MQtCYSQacP1cmCrAldUa/CSBrCoFba
   MGhF6crysCUXEsHVzxf1+95G78Kx00IDnVUiZaND55WRmv8fJwbOjcrxT
   NsOgsSJdjyBXNm8Eb4RWpKdG74neGsT71nCj7QnhOzeY+3S5pNgvecbSV
   nzn7kvLSI3SaRh+vsaCxU7pskfRDvZt9UYHdvIow/7MS/m5evwne3aVhb
   p62D4xN5bvkeNoS1BpqudLKiJPEUQE5RHdUwVVY8Fchc9yfyy649HqryM
   g==;
IronPort-SDR: K4GxWGKv+3+k76a8fVEDsKgMtjXzMSX3+BoyVMS0Zc1WQA4qBs8z+6IS7q3smw9odOfkZSjgQy
 rEtYDeRmliYP6IKT+wpPgl2XbVSTKOyT39VQCWphe4Qn/j3Fi+6XbbfIpGLrUuaY6h8bTuAvLn
 4A8QzG8l8BYyrlrpaNHRtPCAo60avmclpvMB1PubzvwDD14VNM9H8Knm81FwjRwCmqKDiPxMxh
 eQyVGaF02l9GzvVeqnvYgr0oYmSpUvUKLkU79Rrwe4JNDpBMNj+E6ERbpd3CFki/Mg5toRWJxK
 y38=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="114650643"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 09:00:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg5pGvcpWo9hxe26UdW7SJEINYRVZc/yKanIHbuWwqyjDrRt1R3Ec6mJBRdoXB1DY3WOdNQNcD64veT+SKj3TenA4ZY7gZqhyVqnwQUteLkBSIUGJdhwSL2kjnSIPL3/rOm+orZQ24Ze8RKtPPVEdOAU26+inFhkPqQGRl/Kx520DIVS8drhdv1jCEMMe9uJzKeI/btBtPiKbAyJh+UfOTxWsGf6yPxlDwKd0IXsEzDrhOOEa76Uzx3QbI5cHEYf71HFzcr9bO5E2HbUXJRVZoHol9ZMflh8i8XRLsQXxewIWtWXMYxrQ1GjxpM/0Hr129G47H4tVWwb0MVk1gxHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5jdjgJ2n22XtMCKjto0I+oIj5rVRgYyVt6SnMwx0CY=;
 b=Ms9P+re8p0gBVoLE9IxHnevFe4cb9BDYhEsVdDvp+cRuPsBKKjrvOLAfyG9IPuzWbuQ7IpUN73we9dJkBZB6W3HLDmeiFXDD9JSwnOgeBasHCrQalc6c+IIxbf/meh9kIglRXVWmPZoaEGQjvgpGAVKYAOSQyY+RDeL2cIemMdmAsRZbXF17mJW1zptVHCo9NX6EojYbnprzsQF6iYyJgYdgJUAseZ+07gvlSBcrxjvANig7WqER+F/7KA0d/9RjPuEkRXqJefh4vY2/pZlm4h6gBH+XgwM/V88VdUMd79jyuqWsSjIlRdh0M+YFL4pqZjHifcCb2S4lLlD4aSHISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5jdjgJ2n22XtMCKjto0I+oIj5rVRgYyVt6SnMwx0CY=;
 b=F6tzRf+Ih7dkdRlqM7CVpfQ4CiBuGqGkT/SCa/Fu83vR3k7uY1Rh2XgrvuphFHxFwlbIrZ9y7WJLUmLQy6hpM3ev5sVA5nhrvSN8Xd9xWVZkNlM9vtlny7BxNwBvXFvUCQj0Te+4IGYCcVQMfg32FmSnRz9BhtM1rA7twAdAonA=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4406.namprd04.prod.outlook.com (20.176.252.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 01:00:51 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 01:00:51 +0000
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
Subject: Re: [PATCH 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVR+My7xr1FkohJEaR3yEeKqtOiA==
Date:   Thu, 1 Aug 2019 01:00:51 +0000
Message-ID: <BYAPR04MB581616F0196D93AE1C596735E7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
 <20190731210102.3472-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b37e554f-7191-4103-f969-08d7161bb2ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4406;
x-ms-traffictypediagnostic: BYAPR04MB4406:
x-microsoft-antispam-prvs: <BYAPR04MB44067DA04C0EDC49865DFEFAE7DE0@BYAPR04MB4406.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(14454004)(476003)(76116006)(71190400001)(7696005)(6506007)(53936002)(53546011)(2906002)(316002)(478600001)(86362001)(66556008)(76176011)(64756008)(66446008)(110136005)(66476007)(26005)(6246003)(52536014)(71200400001)(186003)(5660300002)(68736007)(102836004)(66946007)(91956017)(9686003)(2201001)(256004)(7416002)(229853002)(6116002)(4326008)(7736002)(25786009)(54906003)(99286004)(486006)(81156014)(81166006)(8936002)(14444005)(6436002)(66066001)(305945005)(8676002)(33656002)(3846002)(55016002)(74316002)(2501003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4406;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cPDhU+EM9QEZOvpgiT6hnovCKV9epaKbbTD2vEk0Uln04P4Zcq/z7pv/R0EebIKAIyXlRnOcrGV0R65v9wqDjbY8emSSfTJSCs+H1n/VJ49hEBYmnVH8kzmHwcjcpzNmehGMkZQKu9PZXQtTpzXXknNZQtl1WFMHhslTEHHUBszVrQplCF9EIoXEVHb4w6bBPlscmmViucK8fcnqhTv6Jelz0pWom6id28iqOVzWw3XDB4Y5QWecNECHS0w4tgf2t60zIRq9X4I0Xwq9oa04TnKvaWij1fA6we417mSxcza45xEPlM0JDaTpiG9M9RIJW3iE/8Xybk9tVdbocRv3kWHC5ERe3OJMVD+ghX25dIC4v1SQ8P2d1S5HMETwfe0ZQLbAVI9PMoY/vvjZx9n1E5jlYo4aOrTdQ+Dvn4vmgHE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e554f-7191-4103-f969-08d7161bb2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 01:00:51.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4406
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/01 6:02, Chaitanya Kulkarni wrote:=0A=
> This patch implements the zone reset all operation for sd_zbc.c. We add=
=0A=
> a new boolean parameter for the sd_zbc_setup_reset_cmd() to indicate=0A=
> REQ_OP_ZONE_RESET_ALL command setup. Along with that we add support in=0A=
> the completion path for the zone reset all.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/scsi/sd.c     | 7 ++++++-=0A=
>  drivers/scsi/sd.h     | 5 +++--=0A=
>  drivers/scsi/sd_zbc.c | 9 +++++++--=0A=
>  3 files changed, 16 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index a3406bd62391..620a6d743952 100644=0A=
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
> @@ -2948,6 +2951,8 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)=0A=
>  			 */=0A=
>  			q->limits.zoned =3D BLK_ZONED_NONE;=0A=
>  	}=0A=
> +	if (q->limits.zoned !=3D BLK_ZONED_NONE)=0A=
> +		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
=0A=
Move this into sd_zbc.c in sd_zbc_read_zones(). That avoids the "if" and ke=
eps=0A=
things for ZBC in one place.=0A=
=0A=
>  	if (blk_queue_is_zoned(q) && sdkp->first_scan)=0A=
>  		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",=0A=
>  		      q->limits.zoned =3D=3D BLK_ZONED_HM ? "managed" : "aware");=0A=
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
> index db16c19e05c4..538216b9e1f4 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -209,10 +209,11 @@ static inline sector_t sd_zbc_zone_sectors(struct s=
csi_disk *sdkp)=0A=
>  /**=0A=
>   * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.=
=0A=
>   * @cmd: the command to setup=0A=
> + * @all: flag to prepare a RESET ALL WRITE POINTER scsi command.=0A=
=0A=
There is no "RESET ALL WRITE POINTER" command. It is the same=0A=
RESET WRITE POINTER, but with the ALL bit set. So maybe change the descript=
ion=0A=
of the argument to something like:=0A=
=0A=
@all: Reset all zones control=0A=
=0A=
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
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
