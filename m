Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4EC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6082089D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PIbNKp/7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B1huncmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgGBIwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:52:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40924 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGBIwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593679982; x=1625215982;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XvPvSN41Nl2PBHfJlWPCWf+s8fhgXAR4TFqZVD60/Ck=;
  b=PIbNKp/7W/lvAAYoz3oDAXPQnKysSKznnXlt2WkqjnM6m8IeBmjldT+N
   CMHq9h/B27qCcT/ZPQXQ5IeY7fD4HfVJBN45hQecuootwvN3cn38cd7cD
   DHskVXIfoUIUJUim39h74V15zqScHdlAgg0jq+L12WbqxDQhAK4rMwLIO
   8w+ssjU3Sxd46etEZRTCTskXfLglpGYgMkTgUsavx/2KtyOxOna1ijx2B
   Tvbb5fdWF8XowuIxGLZ5z0+SjuZW9cwveNzeyQUPyzHRhT0VXzFL/7qiU
   gKjm3Tw3KZ+MtPYExDFaIw9s5cJ5+bKPE1trrabriGYpq88/8Gu1VKqb8
   w==;
IronPort-SDR: sNdgz5mHLbSOJEU06J+Kb6+FPQM/Z1U/4hCtReXVN+YkXRIGbsO2oDH3nZI0JRlIfNrwQtDGvf
 wW8a4UKzbXvEEAJ/XtyWJ3FaP+yUONmCpHwrtNH451PWwXDOqsUAjDNgFO15sAEr6MQ4jxLgnH
 HklsHE3UjD43uzHvFh4/O4I7IfaK5R7C9W3iQhy/FR6bM2kR5mUZIXLf47tPZH8I1lZKG01Iov
 2neA6aHRtKoHEPzphAULGiZOGk3GwNulcUbpDNCTzqLplWfkBKrH8jJVmiSS+jd8iT9gMTpL8d
 gwg=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; 
   d="scan'208";a="244484604"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:52:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuYtMOuBhYeuR3qr2ezZ5aDkYASloELJ7Xv+z08ovc0CJHpqFzP74pgUCKkvD6WQS/CzbMFqCH+UvMzXggepeHNRlzgTkkuG0DaUaPO9uCxP3eWwnkuIFWsG5Ju/iEN0sQ3EVaYvDczF4v/LRHPUat5MSmxGDF//Mo73k1n17Gd3QrOIviwmjMZXWjEk5kcmueKaJFEbCGeB3FPDfVnEiIcpT7DKeMpW65mwQLIjqI9xwI6n4Wecjf5Z/XJiEpYFMjAYwUnQdwRLZetbRzwRrsDta78jthsjyzBZX8sI38fP6YMQ4v/icBIA9KbsZVZOQHGzoyJMon6ZO7m027TEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPbbSN6FM6+V66+ZY69yt6xpdbZOIFgkYujFPKoYu0s=;
 b=WM/PIK6jvZpvJXrXTC0rHWra35nS3atd3baOuB6KIplA/qW+vl5zKWnH04VboJU3/1dI8ZYdr+IysflCbe20mW0uSw2nqWemw38M2ciSsvjqdESRPDL8nCDsCEkbjLPv7EYrfpCeMUvEywsr1SJrXzWekm4z+Y81OvwUCCvPAhdIBZCZfF4JAdmHBIUZUI8b+kRtgIXnTcIymJ89IlEecjdg+hr9sGOye6ELQxM2h+kINoIK6nB/IN8fsG5m1COaKqoFzPIPApn1sm3X8Xc9zaW4zJ8k+jXM3c2pInmV8ZBlbFeLchh+2hMe6l8EmcwXlTnyiIX0GsDerJs2qYwiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPbbSN6FM6+V66+ZY69yt6xpdbZOIFgkYujFPKoYu0s=;
 b=B1huncmDWMlaib3IaDhY9sgRJ28SHCwXmOP4RZndSe1Iup45JEdelmxYldNV+A3IPyMu5G2F4QKwwr9rIk8hqe4TkRXcnJqXbfqneYw64VSsZ/37gpwMRxzkrx/wzxYf8pPoYx8Cge7oP/n/Y+Bg0N8vwS9X4nnoj97cnWSowtE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1206.namprd04.prod.outlook.com (2603:10b6:903:b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 08:52:29 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:52:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 2/4] block: add support for zone offline transition
Thread-Topic: [PATCH 2/4] block: add support for zone offline transition
Thread-Index: AQHWUD25AuPO9FUJKEmO2iwqT0FCbg==
Date:   Thu, 2 Jul 2020 08:52:29 +0000
Message-ID: <CY4PR04MB3751E40E2719591FA81C21F2E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-3-javier@javigon.com>
 <CY4PR04MB3751F9F6BBBAD8CAC7E15431E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083956.rwlewfgyc6ycs4ys@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 944a3614-7817-4182-36f6-08d81e6540a6
x-ms-traffictypediagnostic: CY4PR04MB1206:
x-microsoft-antispam-prvs: <CY4PR04MB1206EAD554910462DB159D46E76D0@CY4PR04MB1206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S5XLYeXslr51COAmTwa8q00GcpmCc2Xg6RxuRyL59lo+Wr5rTPV5kWd1Ln+ncXrFsmta+5+HEw7/VSbeAo2uNxk5Xu3bjvQ0uZS7hZt01OL5mH/gSZ8nTAgoCabHfJfIgBl4BX83CIa9qQN75eJqwGUz5hAjirbYWz+yOvMyUahncWkkkP1nokv73jSKWzYs3D2lesbwt1fM3pW6w9A00TXn5eplQkOhvF4fTxK34zdXwZ4k2eCBYkmGtw21w/VUajIAn515FivaIxxBlbExTKpvhUqhGlBAPrDbIOXExY/0KGU3I2stFpdR3y2ihd09dUUafhIhsJDAKNo7UH2MHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66574015)(33656002)(316002)(54906003)(2906002)(7696005)(186003)(83380400001)(4326008)(26005)(6506007)(53546011)(7416002)(6916009)(66946007)(66476007)(64756008)(76116006)(52536014)(66446008)(66556008)(91956017)(71200400001)(55016002)(9686003)(8936002)(5660300002)(86362001)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KcbRkhqp1ys28OsYJxgp8DOXXrqvrUHBLo0UX8ut2HKlDd8K/4BZrojDM9tJr0yHyNKVHuEG1bruzh97ga+PfOm44PvyKM/jeaX9O+D+4Mumcv1ygTy5a97D2QdJwli1c8R8HmvAu0ODWqIUbU6tDRZpNzklGx2/ISxg8a5NlWhmc0HZWgAwfiIf+RNTmY7m851geqqCidGQ2dVSciicGufThMFe+140mZCO8RvL0RKVfAQnz+fubciae1rlqZ7NEufEQRIOFVa6RfHToJ/HjZ1tNeQyP9PICc6lh8ycd6EBefKzb59tozHjpDURms7VH93dkdMiWFHiQROjrqIjuPgCw6fW/+58H/ZgA/QxNtLH1ndv9S5paQnNyUfkwemIR0h1fJqA7FPzO1Hq6BWFAbQxxijEylcrE6XiBATz/u50Gf1wmcLzqtutJfzrgZRb7XhjcBNA7JH7RiUsZ0jurxq/0EKc6DY4bKd0Ma54mHY3zS37lniHxZCY6J/OjT4r
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944a3614-7817-4182-36f6-08d81e6540a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:52:29.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNmpWUjf8ZNXqp2lPg+u5gE+XotThzycHv36b2QHSuCx47PfIzbdj9a1FLCp8aNO5CC303lfHX1kib7IbzMi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1206
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/02 17:40, Javier Gonz=E1lez wrote:=0A=
> On 02.07.2020 08:10, Damien Le Moal wrote:=0A=
>> On 2020/07/02 15:55, Javier Gonz=E1lez wrote:=0A=
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>=0A=
>>> Add support for offline transition on the zoned block device. Use the=
=0A=
>>> existing feature flags for the underlying driver to report support for=
=0A=
>>> the feature, as currently this transition is only supported in ZNS and=
=0A=
>>> not in ZAC/ZBC=0A=
>>>=0A=
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>> ---=0A=
>>>  block/blk-core.c              | 2 ++=0A=
>>>  block/blk-zoned.c             | 8 +++++++-=0A=
>>>  drivers/nvme/host/core.c      | 3 +++=0A=
>>>  drivers/nvme/host/zns.c       | 2 +-=0A=
>>>  include/linux/blk_types.h     | 3 +++=0A=
>>>  include/linux/blkdev.h        | 1 -=0A=
>>>  include/uapi/linux/blkzoned.h | 3 +++=0A=
>>>  7 files changed, 19 insertions(+), 3 deletions(-)=0A=
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
>>> index 0f156e96e48f..b97f67f462b4 100644=0A=
>>> --- a/block/blk-zoned.c=0A=
>>> +++ b/block/blk-zoned.c=0A=
>>> @@ -320,7 +320,8 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, fmode_t mode,=0A=
>>>  }=0A=
>>>=0A=
>>>  /*=0A=
>>> - * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl pro=
cessing.=0A=
>>> + * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE, BLKFINISHZONE and BLKOFFLI=
NEZONE=0A=
>>> + * ioctl processing.=0A=
>>>   * Called from blkdev_ioctl.=0A=
>>>   */=0A=
>>>  int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=0A=
>>> @@ -363,6 +364,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>>>  	case BLKFINISHZONE:=0A=
>>>  		op =3D REQ_OP_ZONE_FINISH;=0A=
>>>  		break;=0A=
>>> +	case BLKOFFLINEZONE:=0A=
>>> +		if (!(q->zone_flags & BLK_ZONE_REP_OFFLINE))=0A=
>>> +			return -EINVAL;=0A=
>>=0A=
>> return -ENOTTY here.=0A=
>>=0A=
>> That is the error returned for regular block devices when a zone ioctl i=
s=0A=
>> received, indicating the lack of support for these ioctls. Since this is=
 also a=0A=
>> lack  of support by the device here too, we may as well keep the same er=
ror=0A=
>> code. Returning -EINVAL should be reserved for cases where the device ca=
n accept=0A=
>> the ioctl but start sector or number of sectors is invalid.=0A=
> =0A=
> Ok.=0A=
> =0A=
>>=0A=
>>=0A=
>>> +		op =3D REQ_OP_ZONE_OFFLINE;=0A=
>>> +		break;=0A=
>>>  	default:=0A=
>>>  		return -ENOTTY;=0A=
>>>  	}=0A=
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
>>> index e5f754889234..1f5c7fc3d2c9 100644=0A=
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
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
>>> index 888264261ba3..b34d2ed13825 100644=0A=
>>> --- a/drivers/nvme/host/zns.c=0A=
>>> +++ b/drivers/nvme/host/zns.c=0A=
>>> @@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,=0A=
>>>  	}=0A=
>>>=0A=
>>>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
>>> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;=0A=
>>> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;=0A=
>>=0A=
>> The name BLK_ZONE_REP_OFFLINE is not ideal.  This flag is not about if o=
ffline=0A=
>> condition will be reported or not. It is about the drive supporting an e=
xplicit=0A=
>> offlining zone operation.=0A=
> =0A=
> I wanted to follow the same convention. I can change the name in the=0A=
> same enum for the report flags.=0A=
> =0A=
>>=0A=
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>>>  free_data:=0A=
>>>  	kfree(id);=0A=
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
>>> index ccb895f911b1..c0123c643e2f 100644=0A=
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
>>> @@ -455,6 +457,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)=
=0A=
>>>  	case REQ_OP_ZONE_OPEN:=0A=
>>>  	case REQ_OP_ZONE_CLOSE:=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>>  		return true;=0A=
>>>  	default:=0A=
>>>  		return false;=0A=
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index 3f2e3425fa53..e489b646486d 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -370,7 +370,6 @@ extern int blkdev_report_zones_ioctl(struct block_d=
evice *bdev, fmode_t mode,=0A=
>>>  				     unsigned int cmd, unsigned long arg);=0A=
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>> -=0A=
>>>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>>>=0A=
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h=0A=
>>> index 42c3366cc25f..e5adf4a9f4b0 100644=0A=
>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>> @@ -77,9 +77,11 @@ enum blk_zone_cond {=0A=
>>>   * enum blk_zone_report_flags - Feature flags of reported zone descrip=
tors.=0A=
>>>   *=0A=
>>>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.=0A=
>>> + * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.=0A=
>>=0A=
>> The device supports explicit zone offline transition=0A=
>>=0A=
>> Since the implicit transition by the device may happen, even on SMR disk=
s.=0A=
>>=0A=
>> But I am not sure this flags is very useful. Or rather, isn't it out of =
place=0A=
>> here ? Device features are normally reported through sysfs (e.g. discard=
, etc).=0A=
>> It is certainly confusing and not matching the user doc for rep.flag whi=
ch=0A=
>> states that the flags are about the zone descriptors, not what the devic=
e can=0A=
>> do. So at the very least, the comments need to change.=0A=
>>=0A=
>> The other thing is that the implementation does not consider device mapp=
er case=0A=
>> again: if a DM target is built on one or more ZNS drives all supporting =
zone=0A=
>> offline, then the target should be allowed to report zone offline suppor=
t too,=0A=
>> no ? dm-linear and dm-flakey certainly should be allowed to do that. Exp=
orting a=0A=
>> "zone_offline" (or something like named that) sysfs limit would allow th=
at to be=0A=
>> supported easily through limit stacking and avoid the need for the repor=
t flag.=0A=
> =0A=
> I can add that too. I left it out as I did not add any implementation on=
=0A=
> top of it for the device mapper itself. If this is the way that it makes=
=0A=
> sense, then we can add it to the different device mappers later on.=0A=
=0A=
If the capability is advertised as a queue limit and the generic limit stac=
king=0A=
function adjusted, you get DM support for free and will not have to add any=
thing=0A=
to targets supporting zoned block devices.=0A=
=0A=
> =0A=
>>=0A=
>> Happy to here others opinion about this one though.=0A=
>>=0A=
>>>   */=0A=
>>>  enum blk_zone_report_flags {=0A=
>>>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),=0A=
>>> +	BLK_ZONE_REP_OFFLINE	=3D (1 << 1),=0A=
>>>  };=0A=
>>>=0A=
>>>  /**=0A=
>>> @@ -166,5 +168,6 @@ struct blk_zone_range {=0A=
>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>>> +#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)=0A=
>>>=0A=
>>>  #endif /* _UAPI_BLKZONED_H */=0A=
>>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
