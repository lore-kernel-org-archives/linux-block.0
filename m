Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B771C17440
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 03:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46DB2084E
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 03:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YDfSI/Wg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AnlKs3Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLDxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 22:53:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43643 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLDxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 22:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573530812; x=1605066812;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lF244pZsbUtsgrYmvhX+dAr2mJrQjX5LcX9fQ57WwCw=;
  b=YDfSI/WgFz3VLtQ+tVn20SoJ5xUNG/VBqPPma7OIKVzrWK63yS76gTO9
   LypGZQ6YpszCbcRYl6iBOoSz6TDccmyaenr2LAr46q7KdPPOLSl6WIHub
   zWOomx+ajnR9H5yUAXSWwzQdmLw9lG1XJ3SRFXZydQEFx/xF3rJE34LDy
   EcWCzAL5NY+T4fj8QixCFrbQzZR8UG6M/fDXDlz+vfbHSLYSnKOU06k0K
   ZmT0bpa9VJtWJJ4XNHpTCAvz5eBsUptQILLRfc40Rr+ivqtmAbqsoa8c3
   0NmaVdavGTyG83GWEojustjaJU0hev9pZjVSx+fWUGxldKH4lxhud2CE3
   w==;
IronPort-SDR: fbSzF145/DBIh9ed+MqYyiwxeiCSb5XVRPYta2c2uLqGN9j8+N4o/N9uX3LbanOrtXnC0ob9qb
 /q9+VimIuzkAHcHNVNmLkIRbE7WFEsyslGaP0RtZPy3DzjJSvHQzg2cWlzhoc3c/R09QXR1PZJ
 Kaye2l6nkALoZ5vaUtIo3tw0QjBtnwZkGMccjAVlVjcCFpy2SHiMgm7SeMJ7EfzlG7ZS0Y4Ur6
 qWyEJhd7WS5YvZtob1cmUKM4sy52fRqOXCM9GfENjUVMJX9TX+mrUle3girCTzH7CPGCAHgS37
 h90=
X-IronPort-AV: E=Sophos;i="5.68,294,1569254400"; 
   d="scan'208";a="127152583"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 11:53:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGas+0OjuTmlxmMBDOtJ6wSRHn2lTPNKQej9RIobcfz5AMgd+L9iD2/y+fYwS5yS89DkaK7Yq9jaPRnbD0GharMqUyAr5q7Y8sbqVidFDcaVM3doQof48T8M1RQT1B6OCZI1VO0kT39nwlMl9Cs8hz1WHmsCGdoHHSA1IxdIbpYzdtLFa9u2ePXktFBGBRSBKNtLy/ClJQdi81Y8EMwZcqAsoqoBXiw6cUS1JPVp49GAO5BY2GPMUFsz/j+sgNfHbOTJIV0E9QG9vYaz6NAkA00U1ZpLhi6NTfKJKaLSj2ZO0RVjVXf/dMsOb2D0GZ1UsVuqCVhydDlbOfoU8pTdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fIdLwIXhiz9bM44Hxl/EnHlrAWvyJZAS7Sa9P+KXPQ=;
 b=knZ8FF7P5x8IrvFnG72anw3ouJGQ0yqAFFEQDo3qZ/LqC90MGEKU3ETSjon5YPRKzQQWhLDX54eqHUOCxTQSODGgI/6fDhMLHdRmwObk1wfp7moVIEvpwX/I9nRkeq1h5enIEV/S5X6xz/YIcnc0RCoiNWcn5C+wsI/qQ56qfCj3M+LwJ0auYnxO6QFdm3o161k0qoI31wokSVf5n38iIalhXjfGftiOkw5Klj/ixduT5NfgJbXMhnIm6syPpk24mnn9K8XxSuWgxLJi5sCUzy1zxwXNJOCaz1HwBTFNnGOo4N7ENeEXi1lPXVaK9nrUqHMtYgu0SoNG6H3Zj+Gjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fIdLwIXhiz9bM44Hxl/EnHlrAWvyJZAS7Sa9P+KXPQ=;
 b=AnlKs3QcqFSA8Byb5+uPwe2ZQY7QB+8FVZisUqrvWMFG4es6S0kqkfHV7iMzsaKAVQepWEekaLDWwQD5lV3dGZcbSYDFgNY5JKNPwVjUXCL0VsqVeuZY/pd2BT1CnTC94EvdNWEvs/dFWlzf46y5C0O2J9OYWnSKZaBQba8CbOo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4422.namprd04.prod.outlook.com (20.176.252.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 03:53:26 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 03:53:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 2/2] block: allow zone_mgmt_ops to bail out on SIGKILL
Thread-Topic: [PATCH V2 2/2] block: allow zone_mgmt_ops to bail out on SIGKILL
Thread-Index: AQHVmNWfuaupUYRVf0iSiFExjl++kQ==
Date:   Tue, 12 Nov 2019 03:53:26 +0000
Message-ID: <BYAPR04MB5749AC2084CC7FBF7ABD551F86770@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
 <20191111211844.5922-3-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5816865D212AD49866689ADAE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ca05a38-4f9c-4086-513b-08d76723df79
x-ms-traffictypediagnostic: BYAPR04MB4422:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4422BCF158ED2F186EE6578D86770@BYAPR04MB4422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(6306002)(14454004)(5660300002)(33656002)(6246003)(55016002)(6436002)(52536014)(316002)(26005)(25786009)(966005)(8676002)(76176011)(4326008)(8936002)(2906002)(102836004)(81156014)(81166006)(66066001)(110136005)(6506007)(53546011)(6116002)(99286004)(71190400001)(7696005)(71200400001)(66476007)(186003)(2501003)(229853002)(478600001)(9686003)(64756008)(66446008)(76116006)(66946007)(476003)(3846002)(486006)(7736002)(305945005)(14444005)(66556008)(86362001)(256004)(446003)(74316002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4422;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYR2caVDbmpAM1weUD9jzgOoO5Uyl52QCX6pFOI5yyZ+SPmJMgOFFq0ZopWX0xl1QEuylg6UCVBK4ihzDT7CzoeVz9FuGE9e96hyDMQ2hcxVOP4R641XCCJJpCvHNLFjm7DEJG4tgPa16pvwwZnVIdylDpDp+aAeMiEisZpeSAJMNEo522yI9p4KTjTTw2FjEV7bxUazZigWXWRe/ObZloaAmeXZFq20E4pzQ85GzBg84zS2nP2d7zSXHLFQfddxDNkfX+oaOxsKLz5dgYBL7kdGSH9EDxecQUM0dml07wRGclC76yb00NWx7zZqO6hea939hkKiujNsRJ+Y83bc0oC4aIG6HyT3VI/1/UNkMCdtlfhG4OhvYpRwTvtARZrOaZMk5ecmoKgrRK0K4neDfJC9S4pp6BkAZXqk9ku0Xxg/WAhqsCgTiMnkcVOjTcd9217o+XXDaVcOMRxYGq3mRgzEX+l9rJvn6sjQ9XpmR2g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca05a38-4f9c-4086-513b-08d76723df79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 03:53:26.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhienZctcmm5VoHe4f8+OlF33Iu8B/xe1QnsdHppF6ULIjLh6kea830VrpNbd2fKhg5qbkTQ2W2O3nomz8Dp/ZZv1IQVf0tUuAb+O1s4q2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4422
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/2019 04:04 PM, Damien Le Moal wrote:=0A=
> On 2019/11/12 6:18, Chaitanya Kulkarni wrote:=0A=
>> This patch is on the similar concept which is posted earlier:-=0A=
>> https://marc.info/?l=3Dlinux-block&m=3D157321402002207&w=3D2.=0A=
>=0A=
> May be reference a commit ID here instead of an URL ?=0A=
>=0A=
With reference to the cover-letter  I couldn't find this commit in=0A=
the repo (on for-next branch), waiting for Jens to respond if he wants=0A=
me to bundle these patches with the original in one series.=0A=
=0A=
>>=0A=
>> This allows zone-mgmt ops to handle SIGKILL.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>   block/blk-zoned.c | 5 ++++-=0A=
>>   1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>> index 481eaf7d04d4..8f0f740d89e8 100644=0A=
>> --- a/block/blk-zoned.c=0A=
>> +++ b/block/blk-zoned.c=0A=
>> @@ -286,12 +286,15 @@ int blkdev_zone_mgmt(struct block_device *bdev, en=
um req_opf op,=0A=
>>   		sector +=3D zone_sectors;=0A=
>>=0A=
>>   		/* This may take a while, so be nice to others */=0A=
>> -		cond_resched();=0A=
>> +		ret =3D blk_should_abort(bio);=0A=
>> +		if (ret)=0A=
>> +			goto out;=0A=
>=0A=
> There is no need for the goto here. You can return directly.=0A=
>=0A=
Okay.=0A=
>>   	}=0A=
>>=0A=
>>   	ret =3D submit_bio_wait(bio);=0A=
>>   	bio_put(bio);=0A=
>>=0A=
>> +out:=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   EXPORT_SYMBOL_GPL(blkdev_zone_mgmt);=0A=
>>=0A=
>=0A=
>=0A=
=0A=
