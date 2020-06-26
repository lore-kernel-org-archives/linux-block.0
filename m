Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5214C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684462075D
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zny5JuXH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yzEwry/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgFZBeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:34:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58163 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgFZBeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 21:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593135261; x=1624671261;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mbmHn/m3vkWEehlVDeY6vXEx0eS2qlPTUYVxozIg5Lo=;
  b=Zny5JuXH8Q9I5eYwsNb15UREufdI7D8CWTE7UJck+vlWoZR8bx3Sr7dB
   VL2yXsMYnxipaEpy17h39HyC1UyNGgm7AoXK8BD94UyOcg1AIGThaGCtw
   zJXb9fNVLrfWeZ0CHZoZSBo0pgulGJYrDFmBoB6ee4B/JqA2OGdwej2jI
   gIGjl94MwLbPCr1od/1o4v6lJLYi6YAIBlRc9NNbVDSOqeE/OXqLieidq
   6RXf8ZxPKHC5XbZlzblG7PmVqJlyMSJ8TSeY8sUnYRLpejonQcrDqfV+c
   76qItjuGdMXBAQ0hMPDVfZjM9QaAF0D1scXcdzxtiT+LaM7Yn9Ejo7pe+
   Q==;
IronPort-SDR: ILwWOcl1ezDixi3m+FXWOZAyFlgXJ9fVt389kx9JSf15lpdDCaMg2jKh+f+TTVv9/K8gRNMSv3
 GMHG8aCGFOvob+rEEAdWP2mtc4q8P2xPMTzR82ciX8Tq3YZVOUC3ctXFucPYVGDHhLEiWqDtZf
 57Nj+5qi6/wsgttU5ZtxjKpJKo9sDAuQaWDU2BtvkbiRGhWbj6CtPAiHI5y7nrR5YzP7lD9VbZ
 +7SXeD8UbBbjPm+A6+L/O1Vxbmd5lXokWXgMD+Ngrlpc71IArQNQ74bTR6WHIPqcNkciD+jRyD
 27k=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="145289539"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:34:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yoy6ZVN7dvHfSg0yuu+TZSwGevnx0GI1oCK+Tko22Azx3o0WzhyN5v//jOT3B7w+BETT2wzw861SYbWmQqo3ZnZlzyUl+e97/JA0fzHw4EAomDbiFNokJpP4vPyU9mIAvWXv1SQlcusZeIIk633egwlvoBt4ryLTW0wjgMszI3KK09H/DXhxm9+rdMi0OqkMbT7FdNk587O4i3tWI/5bNr5OBpvqZ/sVvKNYHZVcEVYl6e7ATlKH2k4ceIX4o4Gq9LnW4+rfKMDkZ2mKxA4tzieSbI2nM2fM+jPH7jvZnFyeitjlPuWV6fD2ozvQ4vyOfkpzIbCqhtYp9O+H2oLjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr1eO3QDIVVZSHjixLaaOdJ6Z7ykXPQG6QVpjIXx820=;
 b=Z/eb0w77SRxnYo1nsVNAsLIBAUPPe2HHvo+yd4CA3O4IU8AXuKcV4C10CQYPhfncKQEe+l3OxrOyEAI8KcfFcqwvavY+dXNcAS3n99Y/v39LsyZPu90H2/zoDlh40/yB1jQdxeWVP6BvpvAOm3wY2PKuuUXMr5Q4ny07nY/WnBt29NnCaJ4PyoXZm65UmH+BMYxeFWf6EEhcsmgN90YhuA3vuqohq5I7OU1oBKaYsSaGnplek8qH/izvYeKauEQVODlCHOUuDxj8siAXWV/Nrc7EM4qjHGS3I7XSZhB5wKUUUhcXlmqp0iXw6zKRNoM8D1DB8CufP/y2YXxdU+AA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr1eO3QDIVVZSHjixLaaOdJ6Z7ykXPQG6QVpjIXx820=;
 b=yzEwry/UdzxwjL/XYd5bqexutd0X2HXP5AvHru3NXpExZU9JaOfhC7IS3alTyFTUImyp0Ni6NbKXQ1zLJxqjE0iOBHlZaCt4pxuSx3qzpW/quMN2bHWS1s3FPWKoH2hK/Yc9mmh4Oo8H1VZwOCcZbB6zCHH4gT03Z28OvNXzR0w=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 01:34:05 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:34:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date:   Fri, 26 Jun 2020 01:34:04 +0000
Message-ID: <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91701f0b-cb1c-45a8-8add-08d81971035d
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-microsoft-antispam-prvs: <CY4PR04MB1032E314B8E9720A9CA1780EE7930@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tulzoemxkje2Tf1Ekq+04lyLE84rDOVU7JW/owrEIl+jMbC9IA9jd/b446NzFB6RN5JoLmE+mmRFfMGZ/0JPgvQ319S56MgnPaYoXjsNTvva06GDgrNNyk6bdVPvm8fhjMgNbpYNELUxnjwZgtzgwta8QGdFkGydm5MW7l9ZmEfr5VXVvRSlcNxrsJZPhGBO43CStO9cXta0d9ODappXL2QPbetJeQSf9e/CHhGlRQlZVzu5PqzgUv3HMw2XchZpwhGZl4AE/bbMzWCBr+TzOVuYLC4JxwxKSaMgqCCH7kK60J1uSDUxcfJXItyVtZzl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(91956017)(7416002)(86362001)(55016002)(66446008)(2906002)(83380400001)(66946007)(71200400001)(66476007)(64756008)(478600001)(66556008)(5660300002)(186003)(76116006)(9686003)(26005)(8936002)(33656002)(53546011)(316002)(6506007)(66574015)(4326008)(8676002)(54906003)(52536014)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PLKOjJooXdpoNOF2fF0gbTx7VRDCd1EBPTn4i620QjvVU8KTotl4fUAUz6VY6FG7goVKBmfOnNkQpe9Ok4E0VyYprAHFkiW7dCv9g9IQH1SpSM5v5pccldq76VNbhR7RrbIgxxTPQsqTahhjP/Nfi2n2qDdPbmf+A5ncbFpQkv+r/eVHdhCJYtGx1Y2inuXbt+H7BaK9TdKVVz+0A2ufheD2X3WXNcmszko2v2IW8vZZtfnACTrOtpP5xQ8WSvQSahTau5lLZ2gg7Wi3cdz33cf0+0smBLv29WhQ7r1SmAwvZkuW5II8+Wa/RQcFO7PCe9W+SfZ7fXBfoOK6goiWNLcvfU8myRDmwhOem7L9yMPZ4TmtKowhKuEjrBZLOzLvgqd5o2KGe0ev6gj7bNOkUs+OBcVscjUknL+8TLf2zx4WNEsCmIWBjjCR+0lTquGTbdEs3fNIogRe5GRG4xMeW6OOgSdT+EK/sbs2ZFS9ag+Q2IS5wvahSsmFsyfnmjCJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91701f0b-cb1c-45a8-8add-08d81971035d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:34:04.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6lm/3OGlAJWhNzVnY9+abSJTqKcYss8A3U2IUsTIOpckCs95/JXUWwyPJZf2aUoPjqsSu32c3yzlz5kXkdggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Add support for offline transition on the zoned block device using the=0A=
> new zone management IOCTL=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  block/blk-core.c              | 2 ++=0A=
>  block/blk-zoned.c             | 3 +++=0A=
>  drivers/nvme/host/core.c      | 3 +++=0A=
>  include/linux/blk_types.h     | 3 +++=0A=
>  include/linux/blkdev.h        | 1 -=0A=
>  include/uapi/linux/blkzoned.h | 1 +=0A=
>  6 files changed, 12 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 03252af8c82c..589cbdacc5ec 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {=0A=
>  	REQ_OP_NAME(ZONE_CLOSE),=0A=
>  	REQ_OP_NAME(ZONE_FINISH),=0A=
>  	REQ_OP_NAME(ZONE_APPEND),=0A=
> +	REQ_OP_NAME(ZONE_OFFLINE),=0A=
>  	REQ_OP_NAME(WRITE_SAME),=0A=
>  	REQ_OP_NAME(WRITE_ZEROES),=0A=
>  	REQ_OP_NAME(SCSI_IN),=0A=
> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
>  	case REQ_OP_ZONE_CLOSE:=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> +	case REQ_OP_ZONE_OFFLINE:=0A=
>  		if (!blk_queue_is_zoned(q))=0A=
>  			goto not_supported;=0A=
>  		break;=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 29194388a1bb..704fc15813d1 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 fmode_t mode,=0A=
>  	case BLK_ZONE_MGMT_RESET:=0A=
>  		op =3D REQ_OP_ZONE_RESET;=0A=
>  		break;=0A=
> +	case BLK_ZONE_MGMT_OFFLINE:=0A=
> +		op =3D REQ_OP_ZONE_OFFLINE;=0A=
> +		break;=0A=
>  	default:=0A=
>  		return -ENOTTY;=0A=
>  	}=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index f1215523792b..5b95c81d2a2d 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struc=
t request *req,=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);=0A=
>  		break;=0A=
> +	case REQ_OP_ZONE_OFFLINE:=0A=
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);=0A=
> +		break;=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);=0A=
>  		break;=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 16b57fb2b99c..b3921263c3dd 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -316,6 +316,8 @@ enum req_opf {=0A=
>  	REQ_OP_ZONE_FINISH	=3D 12,=0A=
>  	/* write data at the current zone write pointer */=0A=
>  	REQ_OP_ZONE_APPEND	=3D 13,=0A=
> +	/* Transition a zone to offline */=0A=
> +	REQ_OP_ZONE_OFFLINE	=3D 14,=0A=
>  =0A=
>  	/* SCSI passthrough using struct scsi_request */=0A=
>  	REQ_OP_SCSI_IN		=3D 32,=0A=
> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)=
=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
>  	case REQ_OP_ZONE_CLOSE:=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> +	case REQ_OP_ZONE_OFFLINE:=0A=
>  		return true;=0A=
>  	default:=0A=
>  		return false;=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index bd8521f94dc4..8308d8a3720b 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device =
*bdev, fmode_t mode,=0A=
>  				  unsigned int cmd, unsigned long arg);=0A=
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,=0A=
>  				  unsigned int cmd, unsigned long arg);=0A=
> -=0A=
>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index a8c89fe58f97..d0978ee10fc7 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -155,6 +155,7 @@ enum blk_zone_action {=0A=
>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,=0A=
>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,=0A=
>  	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,=0A=
>  };=0A=
>  =0A=
>  /**=0A=
> =0A=
=0A=
As mentioned in previous email, the usefulness of this is dubious. Please=
=0A=
elaborate in the commit message. Sure NVMe ZNS defines this and we can supp=
ort=0A=
it. But without a good use case, what is the point ?=0A=
=0A=
scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent to a=
=0A=
ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_sectors=
" or=0A=
the like to indicate support by the device or not would be nicer.=0A=
=0A=
Does offling ALL zones make any sense ? Because this patch does not prevent=
 the=0A=
use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a good id=
ea to=0A=
allow offlining all zones, no ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
