Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84708C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495FF20830
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BeZ3bZyC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JD8I0Iyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbfIMWSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:18:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51310 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbfIMWSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568413085; x=1599949085;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=a4B+A4VfvrqqGbhUPGURBdLSI1hJDfSnict5JUfNaU4=;
  b=BeZ3bZyCfSmKLmxe16clt7BTvG6r0IMk9bLIAZh/qKhWDP96+wIh1jf9
   yW0uM4VxtookpG7G0TDE6FEkhdVvRdkyQH7zOHMgq0bB34hsNUmuSCUC7
   WuzwAYQdPTNS3YLOhWurD6qHjFFQIn6YFT6iaJ8dWiuLpIggALV9M9msy
   r+QdEMXR2fvdc6OG/XTAWMtiJiKRGxe7sxZlo16xPK7WijRQTcxsnuYZQ
   8YV/aNs9Tyf0RmlQdDsTCPnzW73FoivAsp5lOu/zg+KGIEm6/4kUOBbDh
   VzOqQfNH07Q+n8DniIzRSAjXv/9ymV5jfntxdbvDHwqiJsROEgwT5Pzbz
   A==;
IronPort-SDR: K2yn7qmc+I/UBBAJyqNyhFfT3DigKChS/E44RaroSKBEYk8AYKzinThN0l9nBaNAu85eMtxYZO
 M56jwJsMNrsY0I1gZWhnfHPvqdamI4NtSlGQqwLJiJ47aXEUd/lXAHPcNR21eAJYGdUPt3GPvq
 WOy081WrLnQOVMhNB6eDEras1wPSE26xNoTq7jYNzA20ahf6G/jHY+0kKPceAloB0tFbMsJ6Np
 SC0RvQW33nOoqhUYhAZ40SOShaIBzm8ZdoGW+F1yJt2KniVuTIJ6IJP88NzuMUdgXcMOnf8uGI
 ZtQ=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="122734352"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 06:18:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNC04FHqaxAEOxBnXSoF19Hjfjys5U6wKAoAdU29Facd0E4CHIXIE3V3rsiLKzceHIs2PexJ+J3l1FA1xcC6KXBL8zMsQFZZNvpFWRi9m1ZYnD5vguXYGp9v803BfhGUylZamiXBV9hs7koThYJbKlbUFlWikYJma77kehpGNR00J3aChbTHaXtSz6BCqGJDpGAfUX1V6iVsyJHwAQgnGkEib9n3JmapAynqTpk7894j6OyUDnjPoazbZvj58/CQzvQwdkfvLtO/LjB25XsDnL1qc/oqu/lotfhTekMXLUEpd0e8dei0/M99vNN98VynP2bdz4b0Va4Q3peyhDxGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4B+A4VfvrqqGbhUPGURBdLSI1hJDfSnict5JUfNaU4=;
 b=Mmcu2zdumao7n5TLaYaUtzTyZxexkB6Ph9AMyYaXmFJKpHROba23Aqhw3oHMOoV2FiYSa6FvODlJFZKKx2MSh8YcGsBvhrXF/hy4cOKZNgKf6RjV5ORKYyMC6r9X9SLoVnQCcjJooKJfkCAyh1fAispnreQJsZIUKMcpz2JAXD2x2T/LZ1ysvW9dOnZTVU/QxKXq40jMYcN27IUCa7k4q+Dx9enruu95Ai8+FEWPWhiG5YdNrY2CfQH1IuoixR3KWo5JrCEWWMYW1CajuSq7+Slw2gWHmKoNcSe12fpGvhQuutdIU3RsCPBq6xDAYaIxYMaL8/7rk15XJn+ml1DLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4B+A4VfvrqqGbhUPGURBdLSI1hJDfSnict5JUfNaU4=;
 b=JD8I0IyhffcytF2vuY/+LHmHvZmLUAtNO0LMCYp8RPLy0HjPVr+jU0UWSVLzQRsrPl06IPAS0AmVM5B4CYnFYam4MS+36kO6X/0ewGqNEygwzlBgp7uDbJTmF0KoPG/lZpZoHqyX7RWKdjF2hNUvk7nRTsk8gKpSttX7pPkvgDA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4294.namprd04.prod.outlook.com (52.135.204.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Fri, 13 Sep 2019 22:18:04 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 22:18:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH v2 4/4] coding-style: add explanation about pr_fmt macro
Thread-Topic: [PATCH v2 4/4] coding-style: add explanation about pr_fmt macro
Thread-Index: AQHVan8+AFfTTAYPG0GaQndc6wd6Zg==
Date:   Fri, 13 Sep 2019 22:18:04 +0000
Message-ID: <BYAPR04MB57491969A325583BDDBC7DA486B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-5-andrealmeid@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89db8e6f-c604-4443-53a1-08d738983f49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4294;
x-ms-traffictypediagnostic: BYAPR04MB4294:
x-microsoft-antispam-prvs: <BYAPR04MB4294779995655438F164BF9486B30@BYAPR04MB4294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(99286004)(478600001)(54906003)(110136005)(3846002)(229853002)(316002)(52536014)(9686003)(4744005)(55016002)(7696005)(76176011)(86362001)(14454004)(6116002)(81166006)(81156014)(8936002)(5660300002)(4326008)(8676002)(33656002)(25786009)(71200400001)(71190400001)(53936002)(76116006)(476003)(6246003)(64756008)(2201001)(6436002)(66446008)(66066001)(2906002)(53546011)(256004)(2501003)(102836004)(446003)(486006)(7736002)(66556008)(66946007)(66476007)(305945005)(6506007)(26005)(186003)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4294;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Ibr3eipibCOXuGgPof07daHqMQG+4F1B8mUeyU+TotnnZMKy/yxl/y5DBPkht3nf+5Pm6pCgL2omSYjfwXmMl4Oa+lmJf2Rx8zXseTk4EiXUUZ6qYFMtyOYJTS73xaPRWnnoLe3X22SeJwv1oubv7b588ZBLw2YEZ0oYg/TlY5QAvop3E3fzxDZ2WjN7pijxBFKBKCypoBf8ummmUZMlgYjbSnPobrwS/Ex8Eu6TxzxKB/4+t9FHXnL8J2rJ3Dtyx0EKYzOduRD/UGW91+jkC9W26SBt7DED5039VlGBM35pWX2RreU9QvGg/7D/t1S20QC7ay5OAe2PskddSU8tiYBxSqRonaC1zHcqbPL807s9+R1sa4lWaI8AEBgaPIRQKP3uuXvr3MYeFVi67rQBB59T0nTNmKl/plPhdEXbX8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db8e6f-c604-4443-53a1-08d738983f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 22:18:04.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJZ/vu0uKT3hTvaeC+Ouim6s2HT9uRuxMVUG2kBgDYGKEX0Tc/yaCmDJZHIRaCUP9RrNehO1MAluI/uoljLNAFYlUPXzACgLlMBr8iUOKLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4294
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm not super familier with the format, will let someone do the=0A=
final review.=0A=
=0A=
In general looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/13/2019 03:04 PM, Andr=E9 Almeida wrote:=0A=
> The pr_fmt macro is useful to format log messages printed by pr_XXXX()=0A=
> functions. Add text to explain the purpose of it, how to use and an=0A=
> example.=0A=
>=0A=
> Signed-off-by: Andr=E9 Almeida<andrealmeid@collabora.com>=0A=
> Cc: Jonathan Corbet<corbet@lwn.net>=0A=
> ---=0A=
> Changes from v1:=0A=
> - Add Jonathan as explict Cc=0A=
> - Replace "include/printk.h" by "#include <linux/kernel.h>=0A=
> - Add note about #undef=0A=
> - Replace hardcore string by KBUILD_MODNAME at the example=0A=
> ---=0A=
=0A=
