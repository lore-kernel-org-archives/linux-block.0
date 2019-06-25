Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B92C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C75208CA
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 12:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Iw3Owu9D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cnoQZeo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfFYMgu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:36:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14898 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFYMgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 08:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561466209; x=1593002209;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PzBw+VL2FYfqwgkkhZDXCP2vS5OcKxqGM4KtRqsG488=;
  b=Iw3Owu9DYC5JXxONDYOsbh2q0pqNb9izCoGuBsf4hVMXEv9/vGYFWw+M
   EJawpPAVYV4F8tChba9SXwL5Tg0xSkCQblHDdM2kz3/OrhaT8ZKPM5YeQ
   WDVektTf8mo0V/5aKuJyBzzKSqEiVAq0RxKlX81qYG0II+C1UkyZGSWr3
   xEQJNy/3opmMdSbf7maQ+65LBMUICquG03HPjVRCyxeCrf1gndbsQ+1oi
   +Xknsi4Lp197oA8fpY0HZ6pZWlm/uTvyZYLRt+QTXVs02mmOPZvoyEYr8
   3CXAcBDy/mDr8+ak/jXTNX+1aFmzbn+WcdNFzDVql3Yz5ExbtVVPhoqKN
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,415,1557158400"; 
   d="scan'208";a="113114685"
Received: from mail-co1nam05lp2055.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.55])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 20:36:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLYyMfRmNHDXWRmqXJkoDA1AFufNIOrHUUEn4BbKARs=;
 b=cnoQZeo4Ik6YPzGglDncYeCS0s09AKD8h4pDNVhHBY8xzqyYOViCBnpnfBkl7dWlwzLtpkkwHCbieFBQBcuqPVdADv+fZ2P9QQyMSWfWJ99GcK42jq6jpf6PUSESy+MAQIzJ7zb0CaVi1navGiloFe8XsvE56hrf+HSYyxxXL3c=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5432.namprd04.prod.outlook.com (20.178.51.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 12:36:46 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 12:36:46 +0000
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
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 2/4] null_blk: add zone open, close, and finish support
Thread-Topic: [PATCH 2/4] null_blk: add zone open, close, and finish support
Thread-Index: AQHVKDJPvRqrrDdCI02PGkGKUbxkfQ==
Date:   Tue, 25 Jun 2019 12:36:45 +0000
Message-ID: <BYAPR04MB581665C81B89838BC022BF7BE7E30@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-3-mb@lightnvm.io>
 <BYAPR04MB5816D471063D970DDCF9AEC7E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
 <1aa6552c-ecf9-a168-df75-ec8c52ddbea6@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7818b15d-1f38-40a9-6d70-08d6f969c934
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5432;
x-ms-traffictypediagnostic: BYAPR04MB5432:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB543279E0BE36C574315CA342E7E30@BYAPR04MB5432.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(8676002)(7416002)(6246003)(99286004)(14444005)(446003)(4326008)(74316002)(3846002)(6116002)(14454004)(91956017)(486006)(476003)(256004)(5660300002)(55016002)(316002)(305945005)(52536014)(72206003)(2906002)(7736002)(25786009)(68736007)(54906003)(73956011)(66946007)(110136005)(64756008)(9686003)(66556008)(66476007)(66446008)(53936002)(229853002)(7696005)(81166006)(66066001)(76176011)(66574012)(71190400001)(478600001)(71200400001)(102836004)(6506007)(186003)(53546011)(8936002)(81156014)(26005)(76116006)(2501003)(86362001)(2201001)(33656002)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5432;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kYQpOYjsDU06Uc7yoQxfUK6kC7AWxSmd6WvYafg/EaoMM9vTKh1pI+u3XZLB1SZSrf5LvN+R0jNZFGNXkIiIn8U0lVJ7UATpJETezFR4VLMUOW+8r4tRJJYHdthPTNSLkqOi9OqwfStHF5ed6vdOBk2eXxgKSOGAnn2j0tN+S9jVwnVfeVm8JD75vnekVMS+NS7wITSSlAAYwQzUazHhPzXzFQGEmYPnywiNk2RDF9M1ljBjyHOjUFbgZK+4qqz7qAQI+2vOGrFHFLwXAVe+Oi2Qnd6msA7B/y8FC62W3BjQRS2vZBCTBRQ/Ilz+VShJN/IXtQ/sIhRb+u1JJOCiliUtf6H9mFzf5soU79cI8xmpG9XyNitv2GjbYB+kXTWpdUuKEcgkjQx+kXMmO2oXRk0w8eDb/LDs9EvtvbABlJc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7818b15d-1f38-40a9-6d70-08d6f969c934
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 12:36:45.6705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5432
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/25 20:06, Matias Bj=F8rling wrote:=0A=
> On 6/22/19 3:02 AM, Damien Le Moal wrote:=0A=
>> On 2019/06/21 22:07, Matias Bj=F8rling wrote:=0A=
>>> From: Ajay Joshi <ajay.joshi@wdc.com>=0A=
>>>=0A=
>>> Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH=0A=
>>> support to allow explicit control of zone states.=0A=
>>>=0A=
>>> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>=0A=
>>> Signed-off-by: Matias Bj=F8rling <matias.bjorling@wdc.com>=0A=
>>> ---=0A=
>>>   drivers/block/null_blk.h       |  4 ++--=0A=
>>>   drivers/block/null_blk_main.c  | 13 ++++++++++---=0A=
>>>   drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++++++++++++++---=
=0A=
>>>   3 files changed, 42 insertions(+), 8 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
>>> index 34b22d6523ba..62ef65cb0f3e 100644=0A=
>>> --- a/drivers/block/null_blk.h=0A=
>>> +++ b/drivers/block/null_blk.h=0A=
>>> @@ -93,7 +93,7 @@ int null_zone_report(struct gendisk *disk, sector_t s=
ector,=0A=
>>>   		     gfp_t gfp_mask);=0A=
>>>   void null_zone_write(struct nullb_cmd *cmd, sector_t sector,=0A=
>>>   			unsigned int nr_sectors);=0A=
>>> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);=0A=
>>> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector);=0A=
>>>   #else=0A=
>>>   static inline int null_zone_init(struct nullb_device *dev)=0A=
>>>   {=0A=
>>> @@ -111,6 +111,6 @@ static inline void null_zone_write(struct nullb_cmd=
 *cmd, sector_t sector,=0A=
>>>   				   unsigned int nr_sectors)=0A=
>>>   {=0A=
>>>   }=0A=
>>> -static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sec=
tor) {}=0A=
>>> +static inline void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t s=
ector) {}=0A=
>>>   #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>>   #endif /* __NULL_BLK_H */=0A=
>>> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_mai=
n.c=0A=
>>> index 447d635c79a2..5058fb980c9c 100644=0A=
>>> --- a/drivers/block/null_blk_main.c=0A=
>>> +++ b/drivers/block/null_blk_main.c=0A=
>>> @@ -1209,10 +1209,17 @@ static blk_status_t null_handle_cmd(struct null=
b_cmd *cmd)=0A=
>>>   			nr_sectors =3D blk_rq_sectors(cmd->rq);=0A=
>>>   		}=0A=
>>>   =0A=
>>> -		if (op =3D=3D REQ_OP_WRITE)=0A=
>>> +		switch (op) {=0A=
>>> +		case REQ_OP_WRITE:=0A=
>>>   			null_zone_write(cmd, sector, nr_sectors);=0A=
>>> -		else if (op =3D=3D REQ_OP_ZONE_RESET)=0A=
>>> -			null_zone_reset(cmd, sector);=0A=
>>> +			break;=0A=
>>> +		case REQ_OP_ZONE_RESET:=0A=
>>> +		case REQ_OP_ZONE_OPEN:=0A=
>>> +		case REQ_OP_ZONE_CLOSE:=0A=
>>> +		case REQ_OP_ZONE_FINISH:=0A=
>>> +			null_zone_mgmt_op(cmd, sector);=0A=
>>> +			break;=0A=
>>> +		}=0A=
>>>   	}=0A=
>>>   out:=0A=
>>>   	/* Complete IO by inline, softirq or timer */=0A=
>>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zo=
ned.c=0A=
>>> index fca0c97ff1aa..47d956b2e148 100644=0A=
>>> --- a/drivers/block/null_blk_zoned.c=0A=
>>> +++ b/drivers/block/null_blk_zoned.c=0A=
>>> @@ -121,17 +121,44 @@ void null_zone_write(struct nullb_cmd *cmd, secto=
r_t sector,=0A=
>>>   	}=0A=
>>>   }=0A=
>>>   =0A=
>>> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)=0A=
>>> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector)=0A=
>>>   {=0A=
>>>   	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>>>   	unsigned int zno =3D null_zone_no(dev, sector);=0A=
>>>   	struct blk_zone *zone =3D &dev->zones[zno];=0A=
>>> +	enum req_opf op =3D req_op(cmd->rq);=0A=
>>>   =0A=
>>>   	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
>>>   		cmd->error =3D BLK_STS_IOERR;=0A=
>>>   		return;=0A=
>>>   	}=0A=
>>>   =0A=
>>> -	zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>>> -	zone->wp =3D zone->start;=0A=
>>> +	switch (op) {=0A=
>>> +	case REQ_OP_ZONE_RESET:=0A=
>>> +		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>>> +		zone->wp =3D zone->start;=0A=
>>> +		return;=0A=
>>> +	case REQ_OP_ZONE_OPEN:=0A=
>>> +		if (zone->cond =3D=3D BLK_ZONE_COND_FULL) {=0A=
>>> +			cmd->error =3D BLK_STS_IOERR;=0A=
>>> +			return;=0A=
>>> +		}=0A=
>>> +		zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
>>=0A=
>>=0A=
>> With ZBC, open of a full zone is a "nop". No error. So I would rather ha=
ve this as:=0A=
>>=0A=
>> 		if (zone->cond !=3D BLK_ZONE_COND_FULL)=0A=
>> 			zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
>> 		=0A=
> Is this only ZBC? I can't find a reference to it in ZAC. I think it =0A=
> should fail. One is trying to open a zone that is full, one can't open =
=0A=
> it again. It's done for this round.=0A=
=0A=
Page 52/53, section 5.2.6.3.2:=0A=
=0A=
If the OPEN ALL bit is cleared to zero and the zone specified by the ZONE I=
D=0A=
field (see 5.2.4.3.3) is in Zone Condition:=0A=
a) EMPTY, IMPLICITLY OPENED, or CLOSED, then the device shall process an=0A=
Explicitly Open Zone function=0A=
(see 4.6.3.4.10) for the zone specified by the ZONE ID field;=0A=
b) EXPLICITLY OPENED or FULL, then the device shall:=0A=
	A) not change the zone's state; and=0A=
	B) return successful command completion;=0A=
=0A=
>>=0A=
>>> +		return;=0A=
>>> +	case REQ_OP_ZONE_CLOSE:=0A=
>>> +		if (zone->cond =3D=3D BLK_ZONE_COND_FULL) {=0A=
>>> +			cmd->error =3D BLK_STS_IOERR;=0A=
>>> +			return;=0A=
>>> +		}=0A=
>>> +		zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
>>=0A=
>> Sam as for open. Closing a full zone on ZBC is a nop. =0A=
> =0A=
> I think this should cause error.=0A=
=0A=
See ZAB/ZAC close command description. Same text as above, almost. Not an e=
rror.=0A=
It is a nop. ZAC page 48, section 5.2.4.3.2:=0A=
=0A=
If the CLOSE ALL bit is cleared to zero and the zone specified by the ZONE =
ID=0A=
field (see 5.2.4.3.3) is in Zone Condition:=0A=
a) IMPLICITLY OPENED, or EXPLICITLY OPENED, then the device shall process a=
=0A=
Close Zone function=0A=
(see 4.6.3.4.11) for the zone specified by the ZONE ID field;=0A=
b) EMPTY, CLOSED, or FULL, then the device shall:=0A=
	A) not change the zone's state; and=0A=
	B) return successful command completion;=0A=
=0A=
> =0A=
> And the code above would=0A=
>> also set an empty zone to closed. Finally, if the zone is open but nothi=
ng was=0A=
>> written to it, it must be returned to empty condition, not closed. =0A=
> =0A=
> Only on a reset event right? In general, if I do a expl. open, close it, =
=0A=
> it should not go to empty.=0A=
=0A=
See the zone state machine. It does return to empty from expl open if nothi=
ng=0A=
was written, that is, if the WP is still at zone start. This text is in ZAC=
=0A=
section 4.6.3.4.11 as noted above:=0A=
=0A=
For the specified zone, the Zone Condition state machine processing of this=
=0A=
function (e.g., as shown in the ZC2: Implicit_Open state (see 4.6.3.4.3))=
=0A=
results in the Zone Condition for the specified zone becoming:=0A=
a) EMPTY, if the write pointer indicates the lowest LBA in the zone and Non=
=0A=
Sequential Write Resources Active is false; or=0A=
b) CLOSED, if the write pointer does not indicate the lowest LBA in the zon=
e or=0A=
Non-Sequential Write Resources Active is true.=0A=
=0A=
> =0A=
> So something=0A=
>> like this is needed.=0A=
>>=0A=
>> 		switch (zone->cond) {=0A=
>> 		case BLK_ZONE_COND_FULL:=0A=
>> 		case BLK_ZONE_COND_EMPTY:=0A=
>> 			break;=0A=
>> 		case BLK_ZONE_COND_EXP_OPEN:=0A=
>> 			if (zone->wp =3D=3D zone->start) {=0A=
>> 				zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>> 				break;=0A=
>> 			}=0A=
>> 		/* fallthrough */=0A=
>> 		default:=0A=
>> 			zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
>> 		}=0A=
>>=0A=
>>> +		return;=0A=
>>> +	case REQ_OP_ZONE_FINISH:=0A=
>>> +		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>>> +		zone->wp =3D zone->start + zone->len;=0A=
>>> +		return;=0A=
>>> +	default:=0A=
>>> +		/* Invalid zone condition */=0A=
>>> +		cmd->error =3D BLK_STS_IOERR;=0A=
>>> +		return;=0A=
>>> +	}=0A=
>>>   }=0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
