Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6303C43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3ED20645
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 01:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DA26xxig";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B9d4mcvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFVBMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:12:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1674 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFVBMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 21:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561165966; x=1592701966;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NLHnRUAICa0FhahH+V46y5+LcvaLpnih2HyNGbeR1qs=;
  b=DA26xxiggSO2lUc1YixqxeKvpxnmHWE7gd6pyRvwZLgxgZqshybXSAl4
   bAdr+c/0NCnWUm5JZTS+lNRCkEoXMUIxoVBbyhbBOJS6zzT3MHTci8ZlX
   AcCC4UyNP38QlulRjT6c/ZwA+fhL5yh+TlQki4j8dFMeEu6D7icuupL16
   gSXcplgOVugo1fFsDoc4jb0tOc9JS3NkIN90a2Xwtjt/WGfPuzmaVOc9Y
   8aWTE6Y0uVFpXE7whH/ZU5klTT8pLysvKalZPkCggp9Gy6twX6qwzEKwN
   FbVcXRgMJn2TNRFH37ltcOX0zDiu9Q/iognL2dcln30AZBY6gCltNIYRd
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,402,1557158400"; 
   d="scan'208";a="112835979"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 09:12:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe6jjccL4+LyXSrabG25wFwU63+PIZScOJFrCFU+kMc=;
 b=B9d4mcvmLfqUtIPXSWkh5Vqi3YPsjJgBPka5oVIYb9K/mXl6ltKzIjJPfmIoJ34o469EfucfVphF6MWhILMi951BsL+5IFkh86VJ699LmxhVB9v+e5+8yfKqFeMdKka6CzSQwsZGd/kkjEX/NOtxpZspBabBShIptx/+upHEFt8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4135.namprd04.prod.outlook.com (20.176.250.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 22 Jun 2019 01:12:43 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Sat, 22 Jun 2019
 01:12:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish
 support
Thread-Topic: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish
 support
Thread-Index: AQHVKDJQ1kFjoU4TbESp3h1U0NgG7w==
Date:   Sat, 22 Jun 2019 01:12:43 +0000
Message-ID: <BYAPR04MB58164B645ED9BE7FA861BE33E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-4-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cff6e2c-0d9f-49a9-3f5c-08d6f6aebae4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4135;
x-ms-traffictypediagnostic: BYAPR04MB4135:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB41355E36EF64FB5340AB51A4E7E60@BYAPR04MB4135.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(14454004)(81166006)(14444005)(26005)(256004)(3846002)(25786009)(6116002)(53936002)(71200400001)(446003)(71190400001)(476003)(486006)(66946007)(55016002)(186003)(66574012)(7696005)(74316002)(6506007)(81156014)(8676002)(5660300002)(9686003)(64756008)(66476007)(66446008)(53546011)(66556008)(102836004)(99286004)(76116006)(73956011)(229853002)(91956017)(8936002)(305945005)(76176011)(7736002)(52536014)(6436002)(4326008)(33656002)(66066001)(6246003)(72206003)(2201001)(2501003)(86362001)(478600001)(2906002)(110136005)(316002)(7416002)(68736007)(54906003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4135;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j38CHE9hygDH9tfDmk9uAStDzmSF6H0w8zidOSOAeCuOzV2iIFfrjBii6/KWxUrORBu1dgaObz8+wuyeoY+OEJ9wDGgkiqri9pdiYqdkmA6pAdRVURQ6z+Zuj7aK3IIk716yzw+oSNtgt47GAdEh0qFrmAb4FsUBrvhYy2YMWqsinxSRcdhKSYEZXSyVhiKSfi8J2AsK2PQkCJxh+gGCsRI3I4YUuxkVUuq4/Wi1uZXgxxqjcLTCOR/kCB73iVFohDysRD/M12Luro/X08UzoF0RO7dK2pCgmQLMQ08ZVZaDzDHIi2nd7+6qOZ3+QIqhLJchm575ble9PjhC05cqJlXV8XiFi1FUq5/Esc0iXRzdOWCIt50S3FrDx9ViIWeqb8KOLFmmt7B3vc1bH8SizFSeCLaMHh6rc2sWpOk8bOU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cff6e2c-0d9f-49a9-3f5c-08d6f6aebae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 01:12:43.8707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/21 22:07, Matias Bj=F8rling wrote:=0A=
> From: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> =0A=
> Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH=0A=
> support to allow explicit control of zone states.=0A=
> =0A=
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> ---=0A=
>  drivers/scsi/sd.c     | 15 ++++++++++++++-=0A=
>  drivers/scsi/sd.h     |  6 ++++--=0A=
>  drivers/scsi/sd_zbc.c | 18 +++++++++++++-----=0A=
>  3 files changed, 31 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index a3406bd62391..89f955a01d44 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -1292,7 +1292,17 @@ static blk_status_t sd_init_command(struct scsi_cm=
nd *cmd)=0A=
>  	case REQ_OP_WRITE:=0A=
>  		return sd_setup_read_write_cmnd(cmd);=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> -		return sd_zbc_setup_reset_cmnd(cmd);=0A=
> +		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,=0A=
> +					ZO_RESET_WRITE_POINTER);=0A=
> +	case REQ_OP_ZONE_OPEN:=0A=
> +		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,=0A=
> +					ZO_OPEN_ZONE);=0A=
> +	case REQ_OP_ZONE_CLOSE:=0A=
> +		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,=0A=
> +					ZO_CLOSE_ZONE);=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
> +		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,=0A=
> +					ZO_FINISH_ZONE);=0A=
>  	default:=0A=
>  		WARN_ON_ONCE(1);=0A=
>  		return BLK_STS_NOTSUPP;=0A=
> @@ -1958,6 +1968,9 @@ static int sd_done(struct scsi_cmnd *SCpnt)=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
>  	case REQ_OP_WRITE_SAME:=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_OPEN:=0A=
> +	case REQ_OP_ZONE_CLOSE:=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
>  		if (!result) {=0A=
>  			good_bytes =3D blk_rq_bytes(req);=0A=
>  			scsi_set_resid(SCpnt, 0);=0A=
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
> index 5796ace76225..9a20633caefa 100644=0A=
> --- a/drivers/scsi/sd.h=0A=
> +++ b/drivers/scsi/sd.h=0A=
> @@ -209,7 +209,8 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)=
=0A=
>  =0A=
>  extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buff=
er);=0A=
>  extern void sd_zbc_print_zones(struct scsi_disk *sdkp);=0A=
> -extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);=0A=
> +extern blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd=
,=0A=
> +						   unsigned char op);=0A=
=0A=
In ZBC specs, open, close, finish and reset command are all ZBC_OUT (94h)=
=0A=
commands with a different servie action. So may be renaming this function t=
o=0A=
sd_zbc_setup_zbc_out_cmnd() is better.=0A=
=0A=
>  extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_byt=
es,=0A=
>  			    struct scsi_sense_hdr *sshdr);=0A=
>  extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,=0A=
> @@ -226,7 +227,8 @@ static inline int sd_zbc_read_zones(struct scsi_disk =
*sdkp,=0A=
>  =0A=
>  static inline void sd_zbc_print_zones(struct scsi_disk *sdkp) {}=0A=
>  =0A=
> -static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd=
)=0A=
> +static inline blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cm=
nd *cmd,=0A=
> +							  unsigned char op)=0A=
>  {=0A=
>  	return BLK_STS_TARGET;=0A=
>  }=0A=
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
> index 7334024b64f1..41020db5353a 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -168,12 +168,17 @@ static inline sector_t sd_zbc_zone_sectors(struct s=
csi_disk *sdkp)=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> - * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.=
=0A=
> - * @cmd: the command to setup=0A=
> + * sd_zbc_setup_zone_mgmt_op_cmnd - Prepare a zone ZBC_OUT command. The=
=0A=
> + *                                  operations can be RESET WRITE POINTE=
R,=0A=
> + *                                  OPEN, CLOSE or FINISH.=0A=
> + * @cmd: The command to setup=0A=
> + * @op: Operation to be performed=0A=
>   *=0A=
> - * Called from sd_init_command() for a REQ_OP_ZONE_RESET request.=0A=
> + * Called from sd_init_command() for REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN=
,=0A=
> + * REQ_OP_ZONE_CLOSE or REQ_OP_ZONE_FINISH requests.=0A=
>   */=0A=
> -blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)=0A=
> +blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,=0A=
> +					    unsigned char op)=0A=
>  {=0A=
>  	struct request *rq =3D cmd->request;=0A=
>  	struct scsi_disk *sdkp =3D scsi_disk(rq->rq_disk);=0A=
> @@ -194,7 +199,7 @@ blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd=
 *cmd)=0A=
>  	cmd->cmd_len =3D 16;=0A=
>  	memset(cmd->cmnd, 0, cmd->cmd_len);=0A=
>  	cmd->cmnd[0] =3D ZBC_OUT;=0A=
> -	cmd->cmnd[1] =3D ZO_RESET_WRITE_POINTER;=0A=
> +	cmd->cmnd[1] =3D op;=0A=
>  	put_unaligned_be64(block, &cmd->cmnd[2]);=0A=
>  =0A=
>  	rq->timeout =3D SD_TIMEOUT;=0A=
> @@ -222,6 +227,9 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned =
int good_bytes,=0A=
>  =0A=
>  	switch (req_op(rq)) {=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_OPEN:=0A=
> +	case REQ_OP_ZONE_CLOSE:=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
>  =0A=
>  		if (result &&=0A=
>  		    sshdr->sense_key =3D=3D ILLEGAL_REQUEST &&=0A=
=0A=
The comment after this code references only the reset operation. So it need=
s to=0A=
be updated. The same comment applies to all operations as they all have the=
 same=0A=
error return behavior.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
