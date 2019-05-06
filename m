Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E109DC04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 23:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58F8205ED
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 23:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VpjxRJdz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NZbrJM7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEFXBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 19:01:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21066 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFXBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 19:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557183666; x=1588719666;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UavILbRUOStU2sEdzEAEID1TYYoCmdY3B45C8Sz7hK8=;
  b=VpjxRJdz4PG06dYAHcW7Q4+Ph/23PyKDOizOa3Xad0kqH/CvelBN5qOC
   Zf73sPRkBVCpC7j3evcIQaV+fXG4AJCyX1buftU02gRu/8ocduAl/IMlr
   iO3ei2Vu8ShSY/52ibGxhaJWdPJtUZ8RIoJ/qrFbkwyyF8Lew8tYYfrVv
   rtu9azXtsA8BZ2KeaDNDQB4Skho1kt5/hHwZFTyOKd5b1ymdnR4ntpQYW
   ouNW7VsBWkKksuJDqBh/IdnviZHvcC/LjXVUEQUwia/nUfUTvYQM7hdMK
   axPe3Sqt4J8tJwfLjN8d2A6nfBCS54v1V4VMPIDxdcfw8aAoEHzAYbVyo
   g==;
X-IronPort-AV: E=Sophos;i="5.60,439,1549900800"; 
   d="scan'208";a="108861121"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 07:01:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcKayQ/1kN7djSQcqfwX297rQ2XI2e4ZqC5iQQkMP7Y=;
 b=NZbrJM7QO/bH5woxHsmZPMDnYB5y6o2FSwEKLzwx8drbE1TlbS19FYB6t0BesdGLvghsjwOxSX/pRsmFUPyWdIDymY9Ot27gX7+3ZvqlSbv44LdAnLlL0UohaXOXrcodQchJ6dEjdlN4zA9Wgg6UV9rZc3Qdqd41Rv8V1bx9IAc=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4893.namprd04.prod.outlook.com (52.135.114.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 23:01:03 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 23:01:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Topic: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Index: AQHVA1Q6zH4CttIufkWRxlafayMhPw==
Date:   Mon, 6 May 2019 23:01:03 +0000
Message-ID: <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5baed53b-c548-4bcc-d76d-08d6d276b6df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4893;
x-ms-traffictypediagnostic: SN6PR04MB4893:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4893FCDC8369ABB301C9EBD586300@SN6PR04MB4893.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(346002)(366004)(52314003)(189003)(199004)(99286004)(2906002)(4326008)(25786009)(71200400001)(55016002)(71190400001)(256004)(14444005)(7696005)(52536014)(3846002)(229853002)(53936002)(9686003)(5660300002)(966005)(6306002)(316002)(6116002)(33656002)(6246003)(53546011)(6506007)(186003)(102836004)(26005)(72206003)(86362001)(478600001)(76176011)(66946007)(73956011)(486006)(91956017)(66476007)(476003)(76116006)(64756008)(66556008)(66446008)(14454004)(446003)(7736002)(8676002)(305945005)(68736007)(66066001)(110136005)(6436002)(81156014)(81166006)(54906003)(74316002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4893;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: awnvgO2dTOnuW6Ytzkc5KyjtbgCKOmD11jSOQ0B52cuXr4IUHBkrXrZhGnY7pgcT50dKp9KAN9/JHB5MMklBIK3kFiZxxv4HiEA/0C62rG0iGc2bYDBVLvF4NixtDxSwaxnNti2PFALetLbtS8qZ+WmKocSKy2pTA2qMOPCgYvln33UcHL/Q2HORQ/994E0QrhvJQRlFrMy2HkbFUUiYQbCwB0PYca132Iqvd169/XfSbNdSQs/m8/SJCnD+MSxOn9pHtc27CIhtXV+UAJbL0FfpXiZSqzIE4AL7MB3RpSOGMjpbgxWJ4AzI0RerD+wNSYSK2bdgn858h6ldXku+vOPyc+AGHvWGV/yD6z0vE035vK6q22toAmibroq+mav2uiZhLDguYKTW155RLq+Xlx1Ij1IZO3GTPZaCFq8d7iA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baed53b-c548-4bcc-d76d-08d6d276b6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 23:01:03.4369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4893
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2019 01:13 PM, Minwoo Im wrote:=0A=
>> I wasn't clear enough.=0A=
>>=0A=
>> It doesn't check for the return value for now. What needs to happen is :=
-=0A=
>>=0A=
>> 1. Get rid of the variable strings which are not part of the discovery=
=0A=
>>       log page entries such as Generation counter.=0A=
>> 2. Validate each log page entry content.=0A=
>=0A=
> Question again here.=0A=
> Do you mean that log page entry contents validation should be in bash=0A=
> level instead of *.out comparison?=0A=
=0A=
It has *out level comparison.=0A=
>=0A=
>> 3. Check the return value.=0A=
>=0A=
> nvme-cli is currently returning value like:=0A=
>     > 0 :   failed with nvme status code (but the actual value may not be=
=0A=
> the same with status)=0A=
>     =3D=3D 0 : done successfully=0A=
>     < 0 :   failed with -errno=0A=
>=0A=
> But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss.=0A=
> Anyway, if nvme-cli is going to return 0 for both cases: success, error=
=0A=
> with nvme status, then test case is going to be hard to check the error=
=0A=
> status by a return value.=0A=
=0A=
This should not happen as it will break existing scripts which are =0A=
written on the top the nvme-cli in past few years.=0A=
=0A=
   It should be with output string parsing which=0A=
> would be great if it's going to be commonized.=0A=
>=0A=
No, we cannot rely on the output string as this problem is a good example.=
=0A=
=0A=
I'm not sure returning =3D=3D 0 for error case is a good idea. Checking =0A=
return value prevents us from writing unstable testcases which are bases =
=0A=
on the text output and allow us to modify tools as specification moves =0A=
forward.=0A=
=0A=
> [1] https://github.com/linux-nvme/nvme-cli/pull/492=0A=
>=0A=
=0A=
