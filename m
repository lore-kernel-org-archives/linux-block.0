Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47355C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CF02076E
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rfZP+o6W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VLS54hFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFZGm3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:42:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13478 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgFZGm3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593153748; x=1624689748;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NHpBSsJbEkotRKvhqvpfdJDLD9wPiSMMT+xhWyFy+tY=;
  b=rfZP+o6WyEiFCjfJ/51xNNajOW3oepIe8Ki8nDHD1xM3/eu7iWyiQ//l
   BvN6vVPz79ejKa9GQHFJkfOD3yeMsFxgnbhXyFbV58ZS0ljsT5F1E20JY
   E5waTGFsYByr6yNXYwdXl3vOTyEv7iaETmK5Qk7TZgL/DJiGrF0oFk1/j
   p3UrvIN1IhpEjQn+SfqF0vwj3Wa8X4fKyQSs6f6WB46AZsYIkZ208DBHr
   haM7KtqbckEmj8dxlKWu5is90meFeXit9tL0/bJBrviOUluOfRvUk5RYz
   intpZA23oif5sx+XqKmRJHOxixNydRH6GdSbntccjtLSNy/LhF8HeeqUK
   Q==;
IronPort-SDR: gkg+3nSxL4R8NBP5GX7nZVvUz0rClA35Uf/MpaKnc9tda8zU8shr9cqJlYjs/W6FeMjHl+C6xk
 Sdt6XGb8UjEeWRfNwAWGoJsHbMCPgStjagV835BvP2HlufKkc8IdsPy2/qt3OSu2CrynlAhmzI
 XGjG3EImStU+iB2f1RvWVsxXn4rzS/s1W3eA0m/4oEXrxnKffJ1sOqLACdo5ndiLERheihwyLe
 MbNF0tB+/lBpSA7qyISI8yhMOZ7AxPcHiQ0pshQQaO3OhBjPTo49NEmFnCYo4mWDvfBhpAPSzh
 /cs=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="141211955"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:42:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhX2UmJoK83rDbuRv+EbHnJFbMbb7dszgMNdJM5DatB+IgsU8VhLjFimKks/hpL2lct5jDPph9u77hklDZ6FSnoptPD4/ytxPuaqGBZ+7kdsUP+iuCZn467cARr3lfiiQ+yV/0bflqyF4sexKhV+3z876YTM/TiCZ1WEDo0/opM+GeUtFPVv8sx1FRaI3lhQDapVTEM+/FDC9ujSHnwM8OSREUcBPo6ID4MKmTqHP/5xQOmFmDUB7/uY/xq9ibwkNdKZMvavN4Unbu9W0w847jIWu8LV/DzYHHbo3YAeszI6TpcRmYWH2UJBrd3Ye3OmGE8sx8S+8fuEK5XeNB17Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKcv8vLdqn4SdoWiZ45ao1EwbFjIOk1IxpJ9zNuBrp0=;
 b=Y+wEkbq00t9pMR6eJIDGQfVMpLoWDyZq8IAgbMjTBIrSIZw+oaihJuyZVr7LURiLtUWezbS5mI+rJ5sObBjyiCNR0wwFNHa7vGn+HtNZtZYQLxeQRDCC0bV44JPzsCJ0E3Y8h1/8uK5vtTuP88WWerIDj34ICSkT0eh+vs7+KHSP9zxb3nzcS3TmR2Om0UvlvTiLuXpogQPObB8+ThZf5l2kLu9su4FA5iCHn19AgnaOr1OHre4lzZgumjYe7TuCoVpf/HAwVF+e4XjeByFVczDR168viIQc9USZDzdM1q+OWF/OWtyHnCE6hNOaqA7OmsY0XlbTlAVaYHE5ll0W9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKcv8vLdqn4SdoWiZ45ao1EwbFjIOk1IxpJ9zNuBrp0=;
 b=VLS54hFI+DjRfjelhEkrjEb8R6+PONxewTS5kFWcQUAl8MdGwgMiAxF01htD5jXfMjDmt1kLUxoOW/ad/6zV3PLdgy3zCRmoxrH8UzCGxTWAZzZwwfeO7fg/9dEwXDmfWWyCryOBbmtY+Tg7a70dE3O9w/oUkGjIgyhwCsxmxko=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3586.namprd04.prod.outlook.com (2603:10b6:910:8e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 06:42:26 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:42:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date:   Fri, 26 Jun 2020 06:42:24 +0000
Message-ID: <CY4PR04MB37515EAB61CDB458DE5AFCA3E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78cf473b-5148-4dbb-c7cf-08d8199c1601
x-ms-traffictypediagnostic: CY4PR0401MB3586:
x-microsoft-antispam-prvs: <CY4PR0401MB3586D5A409E2FD32DF7C9ED5E7930@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDJS652uPVOsRrN8koZwkaXVZYKoXpwf+xU2S99A94NEVWiJLX5342J5V9+uKql1TvYHT9snOz01sBySvxNXdZ82+rrr0uJLco4O+/0gIRxL0Ppsc0HKQPlyixd6i5PyVrwU4BiRMhlwz2o9w6dVAduzBV3/Oqw3OugZ4pgs6h/IY9D4uHiYi03605NRTEmgbMqa4nQwsf+CeVWaMbbQzwc3jLz8njknXOwyaBb9g4AhAjbn+rQKeF1cUA2G/UTvWIvnuHbNRgwPffJCQVtXuCWTmt1qkp8K/5Y7nAVip5jTRbVMEsn4AkOD6S2Irdcg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(86362001)(5660300002)(8936002)(6916009)(52536014)(8676002)(66446008)(66476007)(33656002)(64756008)(66556008)(66946007)(76116006)(71200400001)(83380400001)(91956017)(4326008)(26005)(186003)(53546011)(55016002)(9686003)(2906002)(6506007)(7416002)(66574015)(316002)(478600001)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WT2c8lS1oZGk6Rskq9z73cDJ/YdyCHtuJ0e8h35slk12CLZin1nMTzoQdoHs0ywtppeawjVzTh9+vqCZ4wyIX5+lwT97A8Jhxk6cIG0NVRTzUFwhvBv+Q7Iwk9iM/Uii9smFX70Li5EZPyXX6TfaWXFCnaZ7Y+VCdjQlACb2BHG89TAFLeo0UdrbHzTDK7Cx80zbD51mqzSJYWw455lih+FX7Tim0NurnA0mye2cKVEmZ4XkiJsrK+EGnkCceov9l1451Kma7dZpaMWyttL/Cbtt/InaKHWo+ejjs1yv4hkip1b7G9ERl/brGbjxZqbEDzVRLjG+v5bvPx1nNPcylLQb5mK3iPW10faKHQ2AGhSzFA1o2zCKvPUyWu/hx1PEECJL+tG2ONORH6lrKejlS3oDWch6ZaPaMogpNVKBe6Z1gxGmYpP5ZvapFEzJXe5YwM4GkrSKKGmdsS7w2D86swBYLT/C4I+tLm01bb93PRLdXa01aJ7Prju/W3AcgA8+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cf473b-5148-4dbb-c7cf-08d8199c1601
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:42:24.5914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OaSbbo2dLcMUX9y/Is0IY0AlpaiVk0DjuZYAqkPjnHlrHMRsI8oVChhWUjwe5Ml29QlGO3AHDeSgYvl9e0iLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 15:09, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 01:34, Damien Le Moal wrote:=0A=
>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>=0A=
>>> Add support for offline transition on the zoned block device using the=
=0A=
>>> new zone management IOCTL=0A=
>>>=0A=
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>> ---=0A=
>>>  block/blk-core.c              | 2 ++=0A=
>>>  block/blk-zoned.c             | 3 +++=0A=
>>>  drivers/nvme/host/core.c      | 3 +++=0A=
>>>  include/linux/blk_types.h     | 3 +++=0A=
>>>  include/linux/blkdev.h        | 1 -=0A=
>>>  include/uapi/linux/blkzoned.h | 1 +=0A=
>>>  6 files changed, 12 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>>> index 03252af8c82c..589cbdacc5ec 100644=0A=
>>> --- a/block/blk-core.c=0A=
>>> +++ b/block/blk-core.c=0A=
>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {=0A=
>>>  	REQ_OP_NAME(ZONE_CLOSE),=0A=
>>>  	REQ_OP_NAME(ZONE_FINISH),=0A=
>>>  	REQ_OP_NAME(ZONE_APPEND),=0A=
>>> +	REQ_OP_NAME(ZONE_OFFLINE),=0A=
>>>  	REQ_OP_NAME(WRITE_SAME),=0A=
>>>  	REQ_OP_NAME(WRITE_ZEROES),=0A=
>>>  	REQ_OP_NAME(SCSI_IN),=0A=
>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)=0A=
>>>  	case REQ_OP_ZONE_OPEN:=0A=
>>>  	case REQ_OP_ZONE_CLOSE:=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>>  		if (!blk_queue_is_zoned(q))=0A=
>>>  			goto not_supported;=0A=
>>>  		break;=0A=
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>> index 29194388a1bb..704fc15813d1 100644=0A=
>>> --- a/block/blk-zoned.c=0A=
>>> +++ b/block/blk-zoned.c=0A=
>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,=0A=
>>>  	case BLK_ZONE_MGMT_RESET:=0A=
>>>  		op =3D REQ_OP_ZONE_RESET;=0A=
>>>  		break;=0A=
>>> +	case BLK_ZONE_MGMT_OFFLINE:=0A=
>>> +		op =3D REQ_OP_ZONE_OFFLINE;=0A=
>>> +		break;=0A=
>>>  	default:=0A=
>>>  		return -ENOTTY;=0A=
>>>  	}=0A=
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
>>> index f1215523792b..5b95c81d2a2d 100644=0A=
>>> --- a/drivers/nvme/host/core.c=0A=
>>> +++ b/drivers/nvme/host/core.c=0A=
>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req,=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);=
=0A=
>>>  		break;=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);=
=0A=
>>> +		break;=0A=
>>>  	case REQ_OP_WRITE_ZEROES:=0A=
>>>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);=0A=
>>>  		break;=0A=
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
>>> index 16b57fb2b99c..b3921263c3dd 100644=0A=
>>> --- a/include/linux/blk_types.h=0A=
>>> +++ b/include/linux/blk_types.h=0A=
>>> @@ -316,6 +316,8 @@ enum req_opf {=0A=
>>>  	REQ_OP_ZONE_FINISH	=3D 12,=0A=
>>>  	/* write data at the current zone write pointer */=0A=
>>>  	REQ_OP_ZONE_APPEND	=3D 13,=0A=
>>> +	/* Transition a zone to offline */=0A=
>>> +	REQ_OP_ZONE_OFFLINE	=3D 14,=0A=
>>>=0A=
>>>  	/* SCSI passthrough using struct scsi_request */=0A=
>>>  	REQ_OP_SCSI_IN		=3D 32,=0A=
>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)=
=0A=
>>>  	case REQ_OP_ZONE_OPEN:=0A=
>>>  	case REQ_OP_ZONE_CLOSE:=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>>  		return true;=0A=
>>>  	default:=0A=
>>>  		return false;=0A=
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index bd8521f94dc4..8308d8a3720b 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_devic=
e *bdev, fmode_t mode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>> -=0A=
>>>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>>>=0A=
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h=0A=
>>> index a8c89fe58f97..d0978ee10fc7 100644=0A=
>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>> @@ -155,6 +155,7 @@ enum blk_zone_action {=0A=
>>>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,=0A=
>>>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,=0A=
>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
>>> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,=0A=
>>>  };=0A=
>>>=0A=
>>>  /**=0A=
>>>=0A=
>>=0A=
>> As mentioned in previous email, the usefulness of this is dubious. Pleas=
e=0A=
>> elaborate in the commit message. Sure NVMe ZNS defines this and we can s=
upport=0A=
>> it. But without a good use case, what is the point ?=0A=
> =0A=
> Use case is to transition zones in read-only state to offline when we=0A=
> are done moving valid data. It is easier to explicitly managing zones=0A=
> that are not usable by having all under the offline state.=0A=
=0A=
Then adding a simple BLKZONEOFFLINE ioctl, similar to open, close, finish a=
nd=0A=
reset, would be enough. No need for all the new zone management ioctl with =
flags=0A=
plumbing.=0A=
=0A=
> =0A=
>>=0A=
>> scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent to =
a=0A=
>> ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_sect=
ors" or=0A=
>> the like to indicate support by the device or not would be nicer.=0A=
> =0A=
> We can do that.=0A=
> =0A=
>>=0A=
>> Does offling ALL zones make any sense ? Because this patch does not prev=
ent the=0A=
>> use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a good=
 idea to=0A=
>> allow offlining all zones, no ?=0A=
> =0A=
> AFAIK the transition to offline is only valid when coming from a=0A=
> read-only state. I did think of adding a check, but I can see that other=
=0A=
> transitions go directly to the driver and then the device, so I decided=
=0A=
> to follow the same model. If you think it is better, we can add the=0A=
> check.=0A=
=0A=
My point was that the REQ_ZONE_ALL flag would make no sense for offlining z=
ones=0A=
but this patch does not have anything checking that. There is no point in=
=0A=
sending a command that is known to be incorrect to the drive...=0A=
=0A=
> =0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
