Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF5DC04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477762082F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T6Fpeqb6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HpCSaKOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEFRrh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 13:47:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26408 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFRrh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 13:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557164857; x=1588700857;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L4avvjgBVpOnX3mqCUD9i++5DXwh0cv767RyuurzlQw=;
  b=T6Fpeqb6vnZ3IOn5h8ZHuFEzcGMxG3Jqnp15VhW2DKFnQYoJD9O5uvQL
   f2T/ScJAN+1T/kPMM5/2wyRJXPB8KUH6yOZVVbgcvGW9VxNEsHjuX1w5L
   Sz3NHNjUtoZ9k9xfkCAKRkEyg+6XxmPka9QEVtRAQCWtHHeFsQM0Ou4xk
   CNNPFCk3Q+YNuzbIYYEpm2JbxYKas8LqU0rV2PqlP2vwMab4Iu87dOEOe
   nZ6N1t+cb0BZJe66XuexKg1IwHGF13ngw2lBdXwqKUhDOCvVZiEzM+V4e
   API6I1GxIEL97cDMp9JqB5/SUUR7sJVTr464fy3TEpYG+axKRkjPcrFoZ
   w==;
X-IronPort-AV: E=Sophos;i="5.60,438,1549900800"; 
   d="scan'208";a="112576429"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 01:47:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4pGq1VEQ50QfqDDPynobxJyR1A3g0JCEsgwaGbO9/M=;
 b=HpCSaKOOSVnDYyqW1aAJvzGmQTfNqNh4N8Kh5zi2NLp2NJKt7rBkNN9S3bxFequ7nuQZ9KdpaQ5+FIbaavLnPZKLE9PkbDm7q3KX6OR834+f7zWo9fIQP7b73JwBZwh8errPVFcRADI215P93MlNyzDdmh8Fv4fKt3mMtIjVAbc=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4701.namprd04.prod.outlook.com (52.135.122.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 17:47:34 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 17:47:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Topic: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Index: AQHVA1Q6zH4CttIufkWRxlafayMhPw==
Date:   Mon, 6 May 2019 17:47:34 +0000
Message-ID: <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f6c351d-8122-45a2-f92b-08d6d24aebce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4701;
x-ms-traffictypediagnostic: SN6PR04MB4701:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB47018998F54C47733E4EC84586300@SN6PR04MB4701.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(26005)(186003)(4326008)(25786009)(6246003)(74316002)(446003)(305945005)(7736002)(53936002)(5660300002)(66066001)(476003)(8936002)(8676002)(81156014)(81166006)(486006)(6436002)(316002)(72206003)(110136005)(102836004)(68736007)(229853002)(9686003)(86362001)(55016002)(54906003)(76176011)(73956011)(76116006)(91956017)(66946007)(66446008)(64756008)(66556008)(66476007)(7696005)(14454004)(6506007)(6116002)(3846002)(53546011)(52536014)(99286004)(33656002)(2906002)(478600001)(256004)(14444005)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4701;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wo90gWaSl1vS3X6qmhSYK3vUVCM2A4nKrihObCaZJc1MlmhRZbxNfoBzPEmme3LAqxas5r1pPdL+7Z3UIX2s1byqJdpuVgcIEysL7C4fW5MuBorsCkk8dx/snT1eXZkSFsKpqYOJh+VAHJGWPnN/uENxRf5o46HAFVeZCR5VK90ZB35C76XYQkPDXBEpjqq3AGY59wtu8tnKJmwbvm3J4+bhg8ZDryX+f/KkQi0brbKPhkcWiiT1dlIrluH5o8/Xir+wXvjiyScEEr84bSdUz+3CqnvWCSVpEIKn3Fi5Uci5GG0zuX6OEddu8q/4aw44so/z7acyFbJBXZqkaQUywGa9qm2kaz0VzHCrl7jPaVZePliEwgrJOxYeZU81PWgZC/V5WftMTzSA9S//jE9MesQGpZ0dshOq+BkAFuAXlJQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6c351d-8122-45a2-f92b-08d6d24aebce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 17:47:34.3445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4701
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2019 09:54 AM, Minwoo Im wrote:=0A=
>> We need to get rid the string comparison as much as we can e.g.=0A=
>> in following output the nvme-cli output should not be compared=0A=
>> but the return value itself.=0A=
>>=0A=
>> -Discovery Log Number of Records 1, Generation counter 1=0A=
>> +Discovery Log Number of Records 1, Generation counter 2=0A=
>> =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D=0A=
>> trtype: loop=0A=
>> adrfam: pci=0A=
>> subtype: nvme subsystem=0A=
>> -treq: not specified=0A=
>> +treq: not specified, sq flow control disable supported=0A=
>> portid: X=0A=
>> trsvcid:=0A=
>> subnqn: blktests-subsystem-1=0A=
>>=0A=
>> Reason :- we cannot rely on the output as it tends to change=0A=
>> with development which triggers fixes in blktests, unless=0A=
>> testcase is focused on entirely on examining the output of=0A=
>> the tool.=0A=
>=0A=
> Totally agree with you.  nvme-cli is going to keep updated and output=0A=
> format might be changed which may cause test failure in blktests.=0A=
>=0A=
> If Johannes who wrote these tests agrees to not check output result from=
=0A=
> nvme-cli, I'll get rid of them.=0A=
>=0A=
> By the way, Checking the return value of a program like nvme-cli might=0A=
> not be enough to figure out what happened because this test looks like=0A=
> wanted to check the output of discover get log page is exactly the same=
=0A=
> with what it wanted to be in case data size is greater than 4K.=0A=
>=0A=
=0A=
I wasn't clear enough.=0A=
=0A=
It doesn't check for the return value for now. What needs to happen is :-=
=0A=
=0A=
1. Get rid of the variable strings which are not part of the discovery=0A=
    log page entries such as Generation counter.=0A=
2. Validate each log page entry content.=0A=
3. Check the return value.=0A=
=0A=
We cannot *only* rely on the nvme-cli return value or on the output.=0A=
