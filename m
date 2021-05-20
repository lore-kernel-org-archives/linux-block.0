Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B6BC433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 00:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B19D610A1
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhETAB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 20:01:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15301 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETAB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 20:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621468836; x=1653004836;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hs8mMXOPxrQQyBKYeHO2SWH2Eg+2FOlBtrvUw3SqlEI=;
  b=OTfwmL/nu8YmTo91XZ/AQX8+yE/B7osSK5Q6HISChiUBdJ9zyL3XEtSD
   VOknupSZXptl8w0YpDBn0K4O/Y0493kEaiiikHd2695s+ijwo8qhJFfVI
   hI++3eq//yLh2T2d8hQk/eAJSKiPMWc5gyY/U2316xbbwSCQHgs+2KunY
   ON6Y/wt2dwld9JrG7P233BjYoQDOw+82Jx6hRFk9DCMHzN2j2j18Csq5G
   i9KinLLxi4WUHafDl851KdoZ3N5FPhBwKJsHXovozlWvCUo3T0gY8wPG2
   x7vWYaBgNf+Uc3+Y1RSp5QF1cKj/dkoPUvQQIvlS2dPT125XV8BB+I5SL
   A==;
IronPort-SDR: 2+fbRkZ7jvirCSphrVccDFcnvKjvs8fYLIonRzdCsCjkUjoYg2Xd6uSQxcItkoGyo7ujW4CHKS
 kKEP7/Qf3LNQ3n8+7C6Dgv8xsUroNOj0bP/CPFxYKM1Ck9rY2V36XBxMS5ezXnxO8YM9d6WWtt
 oC0f96uL3siAjxNGaTyl1qRLa3g+Ht+CnJNSqtCMoVbMYE/oa8ej/cKjEoDBK8naaKRm3YD13f
 FIEOMySperZ6Eek9aR38u9yHP9auaLhf6Kl65Lo3xzfQ8zVuopW5x1Esu8UbvjIrnL3jeai2FB
 nr4=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168079308"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 08:00:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffpHF1v3D5ZbDAtzbdrLpqb2DERs66skDllVHGVU4Rg9j6FWNeXaLvSq3Xo0PLbB85EwrJtzWzoRWTIaxRjRRoOncaB7cJ/AB7sWVt6H0vfaLxFhp19HQtVtzMQJHuYeiiseFj/+jUykDEuSkUlfk7h23b+UA1KwX1rqOTpfQCfw3rNwpemPNDAyfKV5R0TdrFti106m+6IVvBNb9qI6SYKTwNsQAs9dUKuVt79hqO8OfgYo8ZayUgDYqyfOfzQCxAhCtf8YHSpwbbnNxzBDBTxmRn7tK05ndRBCy4bYSRTPy0EcaI4elyQjQnJsypl6+h5fTC5EMt8q/L1R28wpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr1RYmpyQA+SsJsXZmWHUzFGjQDcFBEmbaNpKWbLDis=;
 b=UfvT0Yza8i2FU7Jzq8RN2BAveCpeDQahoxa6GB2mWtG9PgMaX4hFt8FSQx+riIATrYmeNmcQKt8ljpiuIQNEy4qO+AIHIyAiJTe10I46XhVwaJW6YbxukvWmYXoeJ/w8whrSJBgHDGKtvrhiG3hdMD/zRVwWIPUQYpqiIEO0V8lzpPJKeKZD/w4VjWJE11owu4KfTM5ibcQrw7G46ym6lwCbHjHda20yjlPVlRVk5ldVa715xqgUjJ1bP1Up0DWowRyMZ9xvUzHms275C2RlJHHK6V6W0Jyc1ZQQWjWjiAt3guRCAgElF2yHnXjla0Sp8D89KzRnxW+UFMZepxmhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr1RYmpyQA+SsJsXZmWHUzFGjQDcFBEmbaNpKWbLDis=;
 b=YlVR/Z9umTMGsHdSk06lawrZgww2/TIIrK9nX7OLCKcVNRMjH0yMznYxl/h5FQz+NQyI2b9WfQfZeCiaVhW0hETfjxbYV6YhwHyphuqhiQf6vL4ani212d7V2i74FlYETIM7GCOARRupKIjNQmv3PANInLaMBpjcMqNpNl9VMtM=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5658.namprd04.prod.outlook.com (2603:10b6:5:168::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 00:00:34 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 00:00:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Milan Broz <gmazyland@gmail.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [dm-devel] [PATCH 11/11] dm crypt: Fix zoned block device support
Thread-Topic: [dm-devel] [PATCH 11/11] dm crypt: Fix zoned block device
 support
Thread-Index: AQHXTFp6KMWepVasxEixIhToOv0t7g==
Date:   Thu, 20 May 2021 00:00:34 +0000
Message-ID: <DM6PR04MB7081B7965B612300F87C77F9E72A9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-12-damien.lemoal@wdc.com>
 <cbbf8310-cc46-7925-c8e9-1edb23d245ca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d5e8:c272:2ab7:c99a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: debf7499-c0ba-451f-d3b2-08d91b224acb
x-ms-traffictypediagnostic: DM6PR04MB5658:
x-microsoft-antispam-prvs: <DM6PR04MB565866903D3550404EBB1FD7E72A9@DM6PR04MB5658.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRwGRcyzZO9x+7tCZrRg414iNq3TMgefH6C7T6TO1RWgI49IZBYGeMGAosca0Fn75PP4DPBbSnx7RHY2M/IiKNCKbDDaQoaeWuJIVlXs0B/AWDhcE45Ay6w3ExDbMkcqRD4mJ7OtyoisQDMd0OPca+e3Vjblk+fXNcOb5B9/dVhpoW096AeiJDO2WDymZwI6JonL1u82jPmgiZW3TtOE2/JpY+QMQqc2QY5duCT64Z/Sh4FOQJJsN5NzUFIiQr3aDG3Phyxxec6Jtb2RJ88VcBPYcRBSY/gQcE3es020naAiAk2bxn7HQkHLkVkaZiTYVcrgxHPmFyqqpMkdJlXunU1kV47dsm966eANMNo0YStasG9FdEHxb0IocL36rDjL0R0bJyleU09xcocqljqM6sqI6O4QOlcStAhvMomNukFsWh6k7KPykQZkaTExWaLKHFn/lA9wiIDI91PX+CCRFPhGV1wcGwvpdPu/VUqC6G+FNz2TuOOdsj8WiJQNlbzOpnlvVLOx3sv6Ezu7C8/URgMciaApCqmrNQwELrb2h3+sFKb0Up1vBUtvht4ydxEVQMSmimjgollQhKcxClRIQ6Ps/IY1aRYp6iJQtQMA/UrLfw+rJWqUXwMtkRHZYEAyVS9mO5Lty2VpwTxgBd6yfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(83380400001)(5660300002)(66556008)(110136005)(7696005)(76116006)(91956017)(66946007)(66476007)(316002)(33656002)(38100700002)(186003)(122000001)(71200400001)(9686003)(8676002)(64756008)(66446008)(6506007)(53546011)(2906002)(52536014)(55016002)(478600001)(86362001)(8936002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j5ognqkMSWCH4iq8+JQSQyzS9hWkZHq8PPGf5ndomrPl7EHfVcE8Vclf1u3o?=
 =?us-ascii?Q?ZOBLycHVmMlV6f+H4U/h0POvOjm978Otq4Px4zugVc8QqJWfyqlzodUAChNN?=
 =?us-ascii?Q?o1Yah3PQNc3SIo8dgijIKdxXFksVQrZwoEwP5h0EU53C6C7zZl5eMvsrzeiZ?=
 =?us-ascii?Q?A+NRbgK3APOAsCJfuabWfmIndLq21tubILXjCV7bWc+UkNPF9XgOnUc1bcTR?=
 =?us-ascii?Q?0gi1hQA1VutSxpc8OyvttYABZZ08bo1htDQOrqBmhYKtXOHLXKZjmFUZExIX?=
 =?us-ascii?Q?dd7l50F6h3DiBvGgo7/IY5WB7aMnKJRvDqfMzkD3hZFSXABwetGZogmHgitS?=
 =?us-ascii?Q?TmMzOvaFiEF1H687tRtlN9kuloGxSKbteXQw9CZM3QNwxoZ0sZr1apQS+NLH?=
 =?us-ascii?Q?gWQs3NbNi6CsmM2d4IuTODQL9n0hyKKTIfH+KCU5/qYBHDaGJJIfoXRO8VUU?=
 =?us-ascii?Q?I5JReY95Nb8Ksxllq7W/MXiAZxCK/QABq+6ySQLuTRe3Lo5b41+LlHc8y2RM?=
 =?us-ascii?Q?i9XtgrcmPIG4EjLj8IE226qro3KUe0e88nEj9V/u0JLW6NaXvARey+FHvR2a?=
 =?us-ascii?Q?DrMGDT5voNHpH3EVmTCNBjfe1dXDkMjL8tjSAMAX8Eirgc1tKPIRs38nKBD5?=
 =?us-ascii?Q?ERakVpCKHQZeV0cNMZdsFPhvsTqZORFeJEVZy6E/aRsn+MiuQMMyC/xBdv9m?=
 =?us-ascii?Q?n24oV3EA1fcYeDGTHC8rSjf4Uzix5hquZSo8C4VwLH2TT6FSf40/FYk2vN0g?=
 =?us-ascii?Q?Lfsn6XJjvfr8airlIDr6YyWQtBtOoUw/Om7lgh1HnxeFr/Z0dWPGMcBUG7/u?=
 =?us-ascii?Q?VAK/Pys+CN2VNliPR2fKCUZxwx+7b5b8gc0JGm+rQTeIG2bjnORraxDxwShg?=
 =?us-ascii?Q?p5KOMe9LjyqjwpYLCz+vI3p8ymWlNkFG0nNEHreDufesqmPEFiKVGtE5e6DR?=
 =?us-ascii?Q?zaI2Ezsk5ttYNw6eyqwl5HsaB0NU5EjlO79t/ooRxFT8JyXWlD0OtfRStCnX?=
 =?us-ascii?Q?oTAgvGddKlDIwgOBDz91slQLYZ2JyIdkrNU1VmWe0R9qPtb5KNdOLR20jKm0?=
 =?us-ascii?Q?URg/gD7CpfUL3RZ+1eLkLKblcASC5kueOOOHyy/tPREKy98MWzB3zyV+y6Zz?=
 =?us-ascii?Q?7WX3zeGrUoEiEpII3h6tfE0cSdXFlZrDOGq5QtUcwYAXaLWOx+xYORX1qcik?=
 =?us-ascii?Q?HNrlGMiQcB9lEAEx3xKy5MsC9MIRPcMntf2hRqjqP+XkQ8VZOLdr+6sB9mzm?=
 =?us-ascii?Q?E2zPk9oZ2QvCiI/fVxbqsBuSetnAOQKa/tQl/4IlQRqSdgsR16EPnBNnp3aK?=
 =?us-ascii?Q?RFMYBc0Vl8U+ekRIkoyBZ+ZE5TvNNjQQvs4Mh/jx6U0LBa9PwLJ2zuo//y47?=
 =?us-ascii?Q?i+mmtVynlld+J9vv891MQFgTXlULuUKRkppN906r1xELWPFvCA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debf7499-c0ba-451f-d3b2-08d91b224acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 00:00:34.6185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hcWi3UPzM5XS30uX+/nlC5xcPYSTbnGglj4yORp/IgjUVvWReHjjJ2MarXLN7VjrBItdWEKkNzn9FXYQWErVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5658
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/20 0:46, Milan Broz wrote:=0A=
> On 19/05/2021 04:55, Damien Le Moal wrote:=0A=
>> Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector=0A=
>> of the zone to be written instead of the actual sector location to=0A=
>> write. The write location is determined by the device and returned to=0A=
>> the host upon completion of the operation. This interface, while simple=
=0A=
>> and efficient for writing into sequential zones of a zoned block=0A=
>> device, is incompatible with the use of sector values to calculate a=0A=
>> cypher block IV. All data written in a zone end up using the same IV=0A=
>> values corresponding to the first sectors of the zone, but read=0A=
>> operation will specify any sector within the zone resulting in an IV=0A=
>> mismatch between encryption and decryption.=0A=
>>=0A=
>> To solve this problem, report to DM core that zone append operations are=
=0A=
>> not supported. This result in the zone append operations being emulated=
=0A=
>> using regular write operations.=0A=
> =0A=
> Yes, I think this is definitive better approach and it does not need=0A=
> to fiddle with dm-crypt crypto, thanks.=0A=
> =0A=
> Just one comment below:=0A=
> =0A=
>>=0A=
>> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  drivers/md/dm-crypt.c | 24 +++++++++++++++++++-----=0A=
>>  1 file changed, 19 insertions(+), 5 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c=0A=
>> index f410ceee51d7..44339823371c 100644=0A=
>> --- a/drivers/md/dm-crypt.c=0A=
>> +++ b/drivers/md/dm-crypt.c=0A=
>> @@ -3280,14 +3280,28 @@ static int crypt_ctr(struct dm_target *ti, unsig=
ned int argc, char **argv)=0A=
>>  	}=0A=
>>  	cc->start =3D tmpll;=0A=
>>  =0A=
>> -	/*=0A=
>> -	 * For zoned block devices, we need to preserve the issuer write=0A=
>> -	 * ordering. To do so, disable write workqueues and force inline=0A=
>> -	 * encryption completion.=0A=
>> -	 */=0A=
>>  	if (bdev_is_zoned(cc->dev->bdev)) {=0A=
>> +		/*=0A=
>> +		 * For zoned block devices, we need to preserve the issuer write=0A=
>> +		 * ordering. To do so, disable write workqueues and force inline=0A=
>> +		 * encryption completion.=0A=
>> +		 */=0A=
>>  		set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);=0A=
>>  		set_bit(DM_CRYPT_WRITE_INLINE, &cc->flags);=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * All zone append writes to a zone of a zoned block device will=0A=
>> +		 * have the same BIO sector, the start of the zone. When the=0A=
>> +		 * cypher IV mode uses sector values, all data targeting a=0A=
>> +		 * zone will be encrypted using the first sector numbers of the=0A=
>> +		 * zone. This will not result in write errors but will=0A=
>> +		 * cause most reads to fail as reads will use the sector values=0A=
>> +		 * for the actual data locations, resulting in IV mismatch.=0A=
>> +		 * To avoid this problem, ask DM core to emulate zone append=0A=
>> +		 * operations with regular writes.=0A=
>> +		 */=0A=
>> +		DMWARN("Zone append operations will be emulated");=0A=
> =0A=
> Do we really want to fill log with these?=0A=
=0A=
I added this to signal to the user, indirectly, that performance may be imp=
acted=0A=
as the zone write locking mechanism used for the emulation essentially limi=
ts=0A=
write operations to at most 1 per zone. Overall, the drive QD can still be =
high,=0A=
but per zone, it will be at most one write per zone at any time.=0A=
=0A=
> (I know it is not a good example in this context - but during online reen=
cryption,=0A=
> dm-crypt table segments are continuously reloaded and because the message=
 is in in table constructor,=0A=
> it will flood the syslog with repeated message.)=0A=
> =0A=
> Maybe move it to debug or remove it completely?=0A=
=0A=
OK. I will change this to debug.=0A=
=0A=
> What would be nice to have some zoned info extension to lsblk so we can i=
nvestigate=0A=
> storage stack over zoned device (if there is some sysfs knob to detect it=
, it should be trivial)... =0A=
=0A=
Yes, it is simple to add a sysfs attribute like=0A=
/sys/block/xxx/queue/zone_append_emulated.=0A=
=0A=
That can be done later though. I will see if that can really help applicati=
ons=0A=
or FSes. Right now, I do not see the need for this attribute. After all, al=
l=0A=
scsi SMR drives already have zone append emulation (in the SD driver).=0A=
=0A=
Thanks for the review. Will send V2 later today.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Milan=0A=
> =0A=
>> +		ti->emulate_zone_append =3D true;=0A=
>>  	}=0A=
>>  =0A=
>>  	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
