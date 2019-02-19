Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D69CC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 20:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E252147C
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 20:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P7NUapv4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Cbu4dV3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfBSUHu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:07:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSUHt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 15:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550606869; x=1582142869;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AcJS1SbR2x/2CQm1J1fQMMGYqb9jZP6X0vDfkW+OM2w=;
  b=P7NUapv4cAK9rovNfGy6063DOXulH2aUH6tNUPF14Ev9+aNQnNskJz2g
   zi5bAHl/go+R8H20RQx5KaLXjaNNOz71jwJF599GNLvHkMlbfe6/Xr9ez
   aDIIbylxDmQvl2bRl/7Z7npgyYQWqaNZ8MKLfBo7vn5YNHecV+SwBnP04
   5mHq9C9fqgRtzXMnZrrxpy9EuTm6bUL9LfzhX9uHPDYVK0RzrXInfr9ry
   uPRjevSvQPexaYEQSLNk6zj2CPc9EZYGE4bbIJwHKvK1TpwnooNctX+6e
   rAZnVSljgI24oWqlrKIE9wnj6E5NBR2V9bCTwOecR/ldsZmVIMm/2vAvK
   g==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="206859234"
Received: from mail-by2nam05lp2059.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.59])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 04:07:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2SmwSjqS6kQyjz4djg/L+XVFm3h2k3SSDokhYpvvLw=;
 b=Cbu4dV3cJ6LqHhi+sPoNtkofO4VfG1YBe74udlwrWTciV/1RUk55sk+kj11ZEmQsyS9d8TcHFiRGPkdOeN+epw5YVwnkpd7ezRW38k2npypBipYeeNLnWzFx0f8YqRBomf8snJFoaeG1TeCUhBQdbZl/1BdrRF6QlVZNkcdK2R8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3837.namprd04.prod.outlook.com (52.135.81.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 20:06:53 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 20:06:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH BLKTESTS 3/3] nvme/017: fix output format
Thread-Topic: [PATCH BLKTESTS 3/3] nvme/017: fix output format
Thread-Index: AQHUx7tK2FOwo9iaQk6ThojRIsaAwQ==
Date:   Tue, 19 Feb 2019 20:06:52 +0000
Message-ID: <SN6PR04MB4527C555ABF5CA70AEF361F3867C0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550516022-16374-4-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550593062.31902.111.camel@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d36f561f-f324-4d83-8cfd-08d696a5ca6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3837;
x-ms-traffictypediagnostic: SN6PR04MB3837:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB3837;23:xJC96sRdcCNDoPLmR+x0bFcgjUv/uwGKFKyJHCBJi?=
 =?us-ascii?Q?OQFCRsypUgbT65aLRmpER/rF5W6C2P9hTOP/pOUQo/oLxnhw+h2mm+ojRnkJ?=
 =?us-ascii?Q?rbwtaPwdRp6SWVUkITSFXCIUyjk9UxDTaurLGG3ayJ21G+lZ2qNbsFFOVfvw?=
 =?us-ascii?Q?aLz0W7Afq8cz76Amuj7M7dj/giHNeN8n2g9CsfchEi/KaUgOa3MDOM13zJ9A?=
 =?us-ascii?Q?HrcL/MDckHOykyfmujsXzP6Xw/ICnDPvVRsGExbd6Hifgx5U3P4wTlla3n29?=
 =?us-ascii?Q?ovpHYSTVCjj93PCMvbKU43zWZ3hnzS6ohT1+NBuuQpNi0U39pKxxrXndl+sG?=
 =?us-ascii?Q?AsoBEHSkAHTyKe9F09k4PK9ZPSday3ahqIV0L8DoTR+A0sSswA80V8Tfh+Mj?=
 =?us-ascii?Q?sxnhn6EoNtco3nRXlyWPY7nD3QLRQtmEEY3uiXDuzJ/5u+lq1r3R7VlIcPx+?=
 =?us-ascii?Q?e2ioCOZXQb+XFQXYwORlguzr7nRVuMLzqMi0QehfAzhcZZ4AITNFwKHmf7QU?=
 =?us-ascii?Q?zwCV0qDNH5ORlVM8yNZw+3Gzuas78N0/Ypy5igiFD1P1gdwnQ3npsSAT9xjo?=
 =?us-ascii?Q?QVg1mWTuMej4yZUOWrfSQu8+wcZD6k2cceMfWHcAehv6ZRjYlJxjg7a9h8tO?=
 =?us-ascii?Q?OVIGR0A1gBnmKLq2aOFR1ND3Twkr4pEkDsQmxGf8isPPNhCOfwkR2bfihwZF?=
 =?us-ascii?Q?tQXWz3D3lKRCTSnqEekbXjXoHugs47wKnbQg+yYgXWVOntX7S//lU/h33HI3?=
 =?us-ascii?Q?pIiBDjVHDnt8P863RhFErLhIJuXfVcdRlDB8tqyVPhKRnlLBKud0tdk7u4UI?=
 =?us-ascii?Q?Iv19jYvspugPF03D3WUjq3H9oG1/ITZKP6/6RzC9ogEm8C/1DzuPjVrma6fF?=
 =?us-ascii?Q?4gc2ZOQIUzcaEpKS2uOPvrk686aM9L7IZa16or/uXvna+/gp8sIdyS+3XgbE?=
 =?us-ascii?Q?elvuNEhU+LaOTcWUXlBEm+vtdcm+eJ0jBW5jU12TvOOgjOmqeSKhud/0k4HJ?=
 =?us-ascii?Q?s9BaEP9Z3hPwPQxPt2BcGNHssEYk8kAgRmZrlELIEW7FQ9nLtG4JXX1f4sC6?=
 =?us-ascii?Q?We0+P578pVaA9CLHteAQxQzaFm9FiSiQa8FDFuGZ+YvKcadYPVBdWNpZP3n3?=
 =?us-ascii?Q?jwraHYdc7fAQ/TUPK74Dw5guOYL99zaJFM1jzmNSOsrDAjKwSX1AcXa0x1wQ?=
 =?us-ascii?Q?RUDPvniZOXV07QuK1Sko4AIy7hAMTZtiGNvVWFkxG2ifhzvJUIb8bAUIw=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB3837F887C4AFE2DFBD0769F9867C0@SN6PR04MB3837.namprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(256004)(305945005)(316002)(76176011)(99286004)(217873002)(7736002)(7696005)(4326008)(110136005)(72206003)(53936002)(14454004)(81166006)(3846002)(6116002)(478600001)(8676002)(6246003)(86362001)(33656002)(66066001)(8936002)(81156014)(71190400001)(71200400001)(2501003)(105586002)(106356001)(186003)(229853002)(26005)(446003)(9686003)(74316002)(6436002)(476003)(102836004)(5660300002)(486006)(6506007)(53546011)(68736007)(2906002)(97736004)(55016002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3837;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0GdEPLEFUhkHJMCXNxNGLkI7jLLeNkgTzlU5FMcDg2NZHLleX//YS6XMvWmd/8r/395KS3rS36/VXwlGUBRh4elaw2arYtiZtc8cgZCGpQ/FOfIahmcx9eTqXnBykjT0mlhD9bOULB/fi9VydWO0q6g4ywH5+LA/PiLGbBsg+X/dmeWsOanSiqpZ8AFGpGpT0hHS89wMX2Amc+k89cm+nN13W8qE3DnVRsbTo24y/Bn3TbcAwQqu1yQoTm6VO5O5fWfIIOhnInUBfN3tVjEMoN3lg8DTl/ZDnpSzfExMLiEF65ytS/qRoEJBlkd1j6Kq4JCCrzdyqds0P51jVjdw/nrzxx5LUUsHUwsRY9lSw26+UQL/4Za52hYTLoUAgNJwYzrEHJDPNqghfbwDr1boiNM24BOOyZoq22tb28AeGkE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36f561f-f324-4d83-8cfd-08d696a5ca6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:06:52.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3837
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/19/2019 08:17 AM, Bart Van Assche wrote:=0A=
> On Mon, 2019-02-18 at 10:53 -0800, Chaitanya Kulkarni wrote:=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>   tests/nvme/017     |  5 ++++-=0A=
>>   tests/nvme/017.out | 11 -----------=0A=
>>   2 files changed, 4 insertions(+), 12 deletions(-)=0A=
>>=0A=
>> diff --git a/tests/nvme/017 b/tests/nvme/017=0A=
>> index 0b86bec..db87759 100755=0A=
>> --- a/tests/nvme/017=0A=
>> +++ b/tests/nvme/017=0A=
>> @@ -37,7 +37,10 @@ test() {=0A=
>>   	port=3D"$(_create_nvmet_port "loop")"=0A=
>>   	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"=0A=
>>=0A=
>> -	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"=0A=
>> +	nvme discover -t loop | grep -q "${subsys_nqn}"=0A=
>> +	if [ $? -ne 0 ]; then=0A=
>> +		echo "nvme discover command failed"=0A=
>> +	fi=0A=
>=0A=
> Hi Chaitanya,=0A=
>=0A=
> Please keep the code style consistent with other blktests code and write =
that=0A=
> if-condition as follows:=0A=
>=0A=
> 	if ! nvme discover -t loop | grep -q "${subsys_nqn}"; then=0A=
> 		echo "nvme discover command failed"=0A=
> 	fi=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Bart.=0A=
>=0A=
=0A=
Sounds good, will send out new revision.=0A=
