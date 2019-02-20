Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B82C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14FF20838
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cg+V1P1p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XrFIvcOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBTSUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:20:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2593 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfBTSUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550686800; x=1582222800;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rnW3uCZcGUAqJMx+e25eJGecd2Pay90uYQdLCXNL6Ms=;
  b=cg+V1P1pA/AoQssO5yPAKmWrpe5Rdl7nwxdS0J1hFleI1znchtopTqCP
   okJTwU/HJhgjHSt16EWZa//gwJ9He8lhe/ZJQGaOioAV/1EmuDO2p+N6C
   xV7vbbLDYAfU45cXbhrf2uppYduHH0rW368g/wg0uAQkEAEIsFQwhpXIG
   ptiZfWT3lDjNCLbNK88rHxGJvPeQPxyRh3Nq1rbBU7h018ymOdwxTMca8
   VgwLHLbvoS3dcGBjIWWuzOXkVFWw9cbFuXapumk/ONgo/s5+LEYFDQdKL
   USt2TU0eFLrpsSog8IAjxUSky7VavRwLZjIc2Ppnw3nJJGiwYJe046nuJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,392,1544457600"; 
   d="scan'208";a="206959815"
Received: from mail-by2nam05lp2059.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.59])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 02:20:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGDlfI4lzrNkvOTXRK43CCPeeVpr5YMNqXQoR+y1YoA=;
 b=XrFIvcOw2D1Z0E3mRnh7dwMi3kYmVoUmNELxpa+fnT7dOC12p+NAB1ntMhxgf1qpmppwSAzl8Po6BGtGIwrFIsW6iYXRwSwfzFQ5toPhq6fvdwVWbVWcK/BxyWYTd2vyjzTSdRnUlnuGNAKTw9mu7I+va5+PkiaRhsQA6y2O0mg=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4974.namprd04.prod.outlook.com (52.135.114.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 20 Feb 2019 18:19:58 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 18:19:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH 1/8] nvme/021: use consistent coding style
Thread-Topic: [PATCH 1/8] nvme/021: use consistent coding style
Thread-Index: AQHUyKrYYPpjVwmR1UqmhU6yVlC9cA==
Date:   Wed, 20 Feb 2019 18:19:58 +0000
Message-ID: <SN6PR04MB4527E6227D11DE9066855F55867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550618905-4112-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220181042.GB8325@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47be9ae6-c251-441a-e3aa-08d6976005cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4974;
x-ms-traffictypediagnostic: SN6PR04MB4974:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4974;23:mGxbNdBY8gATE7TTUCDXo70nbSCWM96xzbqvpwdWQ?=
 =?us-ascii?Q?NxZvyjE5P8rcjddJQvxC/5GosnM/HM23nwlTgAU730tPhLYeArgmK0n1wTNH?=
 =?us-ascii?Q?ciBwud6k0weFr+CNYUkaxSxfk4t4yDmgoSi1Vpc6qaqI3j7jtY+YaDFdiIKZ?=
 =?us-ascii?Q?mA7mod+f75L/0yp9OWA+y3iuZsjQQ3wBKHVOx5jTud8WO78RZYziQuwTAAXQ?=
 =?us-ascii?Q?epSB1CqIVsAw2/mPzU3aELnoA7LVTWi+wqml0EMPAg00nvRq4zE52HkuhXMN?=
 =?us-ascii?Q?pyyQY17W5WCwYZGpBlb5Xg1yYpBMVEqD0mPilpTAPGQc/UNFHsjSxscacOM8?=
 =?us-ascii?Q?9iXevxfCmMHfDR8wWOomXsWqKb92uPY2ftKv65DZErP7VzfW3WBo+sULQKaz?=
 =?us-ascii?Q?YW2r+QCOcPxDyBzG7KwKSguZi384LQ4xoAx8nKuXSry3EscyaZQmZ6Qyok7T?=
 =?us-ascii?Q?+apJ2oWv3pueVpf/YinUqPsLIDottH923l7Xq/PGEuKg0VedsulfNOcwKpvw?=
 =?us-ascii?Q?KXENZ39Nu8Ss6W6aS8c1Fvw6x73yllpbSIEZ0INETWpi9kjaZmoJJMhdex50?=
 =?us-ascii?Q?klac13/y4jR7Q+jXVcVrBfHHl5hUSb5x27Nl+ZirAV+DKqK1sB/yBPOQxtJi?=
 =?us-ascii?Q?mkrqpTLdqNyCPEHiZ2Mf/CVNRjZPgRdK+wTXqnFUmuw6W66lTpNv6Eh/X2IJ?=
 =?us-ascii?Q?zZvPPxn8a+o3FPM35qVyb/YcABw/L7CkREuxHgnleitDhXkBjFCZoD9a5taM?=
 =?us-ascii?Q?PRKV3cVo2CUW6utV4rD2SE0+UIXSZ46IOuave8jFpnBLZnGA/qkmSx9RGUuI?=
 =?us-ascii?Q?G1mQbY7/9C36BqlaLOVQ0NmS8//F2ZHP6ZVQMgySo3kQCDrcPWdu6/f3H6og?=
 =?us-ascii?Q?xaU2RWK23Qai0PLn4fUL5jiph1zHdPmljlcLCP/1Q3JLZTYy9jP4aQMufjRO?=
 =?us-ascii?Q?oCg8VxZdStpHjz2BQ3k1Hj5E5+WpNRHAfk6bhXcFBNuih4+aVnOfTYPBPA9w?=
 =?us-ascii?Q?U03xzpRwB6TPYhAvQcOZ43GSSvxA/RD1IfpR8OtQ/PQZZ3Dguo1f0Yy1Q3gM?=
 =?us-ascii?Q?Sa7Q9Etf6znw8jHRYZsfwUH6mUkQgeWTfplM8q/a347fuV+Pbky5BXcyuCZ/?=
 =?us-ascii?Q?82eW3QNhKLDJ5X5ABkfYn+qF/rwWg+7NTBbjuxNbpIKdRkPbj2NfCQk80R1V?=
 =?us-ascii?Q?+mUnwD8v7464bobLEuYCxjWhu+Ko2IEKwg8?=
x-microsoft-antispam-prvs: <SN6PR04MB497424A7E9429341301D4EED867D0@SN6PR04MB4974.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(229853002)(6246003)(81156014)(81166006)(478600001)(72206003)(4326008)(74316002)(97736004)(8676002)(256004)(7736002)(305945005)(25786009)(14454004)(6916009)(8936002)(6116002)(33656002)(3846002)(99286004)(53936002)(186003)(2906002)(7696005)(106356001)(105586002)(6436002)(76176011)(54906003)(486006)(5660300002)(68736007)(66066001)(55016002)(476003)(446003)(9686003)(26005)(86362001)(102836004)(316002)(53546011)(6506007)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4974;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YmGqRCRcZiSW0oVoczEu4HOZ7xGn/oe/kw/6N/BBuGtY9JmsflHH9pjcKskm5WRjcd2z08zlvhN5KwM32obC8xPVTURc2tHW2n4WRviU75kpyjVTM5IrP5fwbdibZFtwNwPF8CA/g30j+AbeZ8pAJxNEexdxyzl54NTFiJ/1ZTDWn+k1DreO8JZMHrpPl8B1bkVofvpH3FL6wS8C1RKDqUwi2+YatREXvAi3d13rsYFyhw9SSpu7A695yCzYcauMzJNwBRaIXLDysQLEDtu09/LK3FwzE88XTbb/+oSFguWo36dNib9YrKhoV1uzGFT4UB/YZKGuRUiXcKFBgyHcdT1RKYndwQ1Yri6YdJKu1G/WjrHYGPea5hT/ndkeCT9J6T2d4WrEKb1CA9Y3AF8FZciRt6BiYSBAvThqtCzASm4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47be9ae6-c251-441a-e3aa-08d6976005cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 18:19:58.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4974
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/20/2019 10:11 AM, Omar Sandoval wrote:=0A=
> On Tue, Feb 19, 2019 at 03:28:18PM -0800, Chaitanya Kulkarni wrote:=0A=
>> ---=0A=
>>   tests/nvme/021     | 15 ++++++---------=0A=
>>   tests/nvme/021.out |  1 -=0A=
>>   2 files changed, 6 insertions(+), 10 deletions(-)=0A=
>>=0A=
>> diff --git a/tests/nvme/021 b/tests/nvme/021=0A=
>> index 8e9512a..f204a2f 100755=0A=
>> --- a/tests/nvme/021=0A=
>> +++ b/tests/nvme/021=0A=
>> @@ -38,11 +38,13 @@ test() {=0A=
>>   	cat "/sys/block/${nvmedev}n1/uuid"=0A=
>>   	cat "/sys/block/${nvmedev}n1/wwid"=0A=
>>=0A=
>> -	nvme list > /dev/null 2>&1=0A=
>> -=0A=
>> -	rc=3D$?=0A=
>> +	if ! nvme list | grep -q "${nvmedev}n1" > /dev/null 2>&1; then=0A=
>> +		echo "Test Failed"=0A=
>> +	else=0A=
>> +		echo "Test complete"=0A=
>> +	fi=0A=
>>=0A=
>> -	nvme disconnect -n "${subsys_name}"=0A=
>> +	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1=0A=
>>=0A=
>>   	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"=0A=
>>   	_remove_nvmet_subsystem "${subsys_name}"=0A=
>> @@ -53,9 +55,4 @@ test() {=0A=
>>   	modprobe -r nvme-loop=0A=
>>   	modprobe -r nvmet=0A=
>>=0A=
>> -	if [ $rc -ne 0 ]; then=0A=
>> -		echo "Test Failed"=0A=
>> -	else=0A=
>> -		echo "Test complete"=0A=
>> -	fi=0A=
>>   }=0A=
>> diff --git a/tests/nvme/021.out b/tests/nvme/021.out=0A=
>> index 5fb0601..b6b1a7c 100644=0A=
>> --- a/tests/nvme/021.out=0A=
>> +++ b/tests/nvme/021.out=0A=
>> @@ -1,5 +1,4 @@=0A=
>>   Running nvme/021=0A=
>>   91fdba0d-f87b-4c25-b80f-db7be1418b9e=0A=
>>   uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e=0A=
>> -NQN:blktests-subsystem-1 disconnected 1 controller(s)=0A=
>>   Test complete=0A=
>> --=0A=
>> 1.8.3.1=0A=
>>=0A=
>=0A=
> For all of these, I think it'd be useful to have a more descriptive=0A=
> error, like so:=0A=
>=0A=
> diff --git a/tests/nvme/021 b/tests/nvme/021=0A=
> index 8e9512a..0b215c4 100755=0A=
> --- a/tests/nvme/021=0A=
> +++ b/tests/nvme/021=0A=
> @@ -38,9 +38,9 @@ test() {=0A=
>   	cat "/sys/block/${nvmedev}n1/uuid"=0A=
>   	cat "/sys/block/${nvmedev}n1/wwid"=0A=
>=0A=
> -	nvme list > /dev/null 2>&1=0A=
> -=0A=
> -	rc=3D$?=0A=
> +	if ! nvme list | grep -q "${nvmedev}n1"; then=0A=
> +		echo "NVMeOF device not listed"=0A=
> +	fi=0A=
>=0A=
>   	nvme disconnect -n "${subsys_name}"=0A=
>=0A=
> @@ -53,9 +53,5 @@ test() {=0A=
>   	modprobe -r nvme-loop=0A=
>   	modprobe -r nvmet=0A=
>=0A=
> -	if [ $rc -ne 0 ]; then=0A=
> -		echo "Test Failed"=0A=
> -	else=0A=
> -		echo "Test complete"=0A=
> -	fi=0A=
> +	echo "Test complete"=0A=
>   }=0A=
>=0A=
=0A=
Okay, will send out a new version along with if any more=0A=
comments that you have.=0A=
=0A=
