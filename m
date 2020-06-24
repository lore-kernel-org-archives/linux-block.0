Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E7FC433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 07:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6AE2073E
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 07:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TgKGYAUb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v2d82Zf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbgFXHXt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:23:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59248 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389651AbgFXHXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 03:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592983446; x=1624519446;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=y+duPxakjukan89fmte9zRTuhCWGxnkWr8i7j88FJKo=;
  b=TgKGYAUbxOdnYekIl8+QEdWf34NA6PyGE/qBUEAP31Jn+xudAocDjCnk
   Kiu+qKl3REgBGu4V/0WIeNhoc5ozAl0Y8bjylvTgHzdBJP5MehhDHbAzw
   2B1PTUdVccgppb52sTmkn0MmUhsERpXgnK+C88n2HIWyfGX0ifqhbNDAm
   2XgShxCYLTJBYIQed2FwJ4msW7vcqpYCMAaGH+Kl8Ee1AqcG/AMQpiKpn
   Xi6DIGhBjB2oGJcCoUZMlxzk3aRxq/sB7JziVIndghpR67rT7mUHfhr25
   y3o58wmsWmrGouRHLLwJ8ShuRgdQcQg1tHxVjqxwYElurluc39FsPuRRz
   A==;
IronPort-SDR: ucAZ97I5d0ubrzVORSpIn6pxPE2rsSB9kbkvzW/Ywag87rYdzuFio+Kp9n+o1Z4fGNSLoykuNO
 YK80wEzNsOeN3SsHnn1ZfJTyzig+CS1m1qLK4BJfYrx5zhu6Gj8XshOwsg+TGORmTb2PZv1YYd
 vgQbYWD1/ERtw5FoXtu1ML+RQfa1lTQ0IKBlHNvylwcJH5yeryaP6bxyoRf2N2yMiKquvV8DKk
 V7mTS8+KIzeZ6Flr1jXwlMgBYkGWpxAhba1dKGUH3BqrWIBuZ2l08fewQHoBJCp5VJzP2eWFJb
 a44=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="243775375"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 15:24:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZZmiFGwPPLhIB3xAfiTV9sZv6gM2IlRXrzLvv9EQajyTaTwrH5pklS+wYDIVmStnryK3YrOxe2jnY2r0vbvrUDXqgoOVac6Z3b+k4QwwQ4R5UZNDWjUERW/D51BM4nzz4FlhLkXDbeEhcuKuK8QA2mGRyBodprOxxLZj6kdo5jpiPcoarauxTnJtUi7+QsKlyEZAhTuOEvNvvoglixJweoFWYaf3630FB4gJlslw1WeYnzLRbS2ToouWO5gdFCHnNDnF9gSv3e1mVk0mqpOdZ8ttzZ8oBMkZeh6ahbD637IYaWsqyVFGItfOmruu3Pd+NfyFz+FIJiMk/W0I3Kwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM/HHCep4Jb3vnr0xl2N4Fn6WApgpT8nGR+IzbQ6wzo=;
 b=b1YSttnzgTHDhDYMx+XDRHV1ZYjZ9FcgL2HI4yN2uPgzNvbPX50e6Mjm9Za75POFG3X+wFfD22V+an1jgGKG3lzElPycWKC7o0hoUmY55A1SpTaqunJKCamsJBGuDyUTJErmIvOw/vVs645vd4IHSSOy65U2V+J1OSlMWJ5mUmJXWMbZNl/sXx/JeAyzHSs70EWX2zunthOUQlgAW4xUQrNK1AfftXQXTLrv67ytrUjxBCMezyVmYozoLOXWl6by6jx7Vp5RyaUgtZKCwJP1DHyVLPJ/QQyRH9vAYx1ameftPt2xCjWMq1gpKeOI4dNqdOKejWYYr/3pLYnnHE9jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM/HHCep4Jb3vnr0xl2N4Fn6WApgpT8nGR+IzbQ6wzo=;
 b=v2d82Zf4Xythqy4rsnyMHzULZv0AW4tVHJeNN+DoL3SYuoaIBd50EZX9RASiT5DmFfeCMdY4HJ4qMmL7v9tX+DTn/kbYIzdD+I94elIl3vv4VXmrw7h2iZ+j9/FTKG7rq8BemcXgHw1Sc2csgkaBb/JTWAh+x86b3UTpMD/RYj0=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5770.namprd04.prod.outlook.com (2603:10b6:5:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 07:23:45 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 07:23:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "satyat@google.com" <satyat@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: move request_queue member docs to kdoc
Thread-Topic: [PATCH 2/2] block: move request_queue member docs to kdoc
Thread-Index: AQHWSaoqlz7E3vAo3kGBel7WHOGX+g==
Date:   Wed, 24 Jun 2020 07:23:45 +0000
Message-ID: <DM5PR0401MB3591826F66C18C8F09BAC6719B950@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200623220311.8033-1-mcgrof@kernel.org>
 <20200623220311.8033-3-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b965bb1-c7a6-42b8-f242-08d8180f8799
x-ms-traffictypediagnostic: DM6PR04MB5770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB57708CEAC8DFD4641860BA549B950@DM6PR04MB5770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qILGJ9CF361rseUVMeROM1OuqR5SkAKWKLbptQDZiRlfDPPaSL/ejvd1xSrooDZujjq7+Nyi2kWF4SRmPll8yoyrg2+8VyXW3apy7EI+vr8Mh0wqOUbYjz7MI1x0EBXi1qQiOPNFhHjFRSdylrOfh+G7RKxG9BgkJvFyP5KI9PW1VsgN4Z+FCvTe/SqS143ddk4wNPFhAx8GawjyLTac+F2nT698MTh30TRhAxHHKJXnjzHCrtvzqF81O7qeQZeDh/354oIcDJujoSVqiZfgH16N0q0l2ieLKbAFeHpmtpx+Nr99eMEzwyVGnUexqUMAq5b4Nnx12f5OJ7vME+k06g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(86362001)(8936002)(33656002)(558084003)(478600001)(66476007)(66556008)(64756008)(66946007)(4326008)(66446008)(76116006)(83380400001)(91956017)(55016002)(9686003)(5660300002)(316002)(52536014)(8676002)(2906002)(186003)(6506007)(53546011)(71200400001)(54906003)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wweHzlHw4kVuUFYLtOP7xbjgVdMdUWKJX3JSvbm2X9WAOiGSLRk+w5YAgQULl+haZLOWQPB8nn2Lz2z2issHuTRtsZOD8eaNV44JbcaiUdVdNQ7cpjH8x2iZ6R9tdDQQntjn4olv1pHOkk4J7/ET9RX2QWNlr2uYr7rT7z7buFdwauAnYDIrikjfucyCp2sVw6+5Hq4cDIDY/krvxYWwVrP1dWMyBNrOR19gvh124UODGvFSLYnI1DpLZx7NWnc+Shv4IYIiND1O+oK6MUVBz3fVmADCNAoj/hX0SITlyp0QRRvWp9fl3d36S4WCmlcKAjqtsjDErHxL4N0pUWZKXspqpTKeeEVZ+El2Ezg6hp+8idemflvv2nvq7uRVh7EhcX3f6pKd93mMyjFWQLj8gsX2zOASfra6Nux6peSuWkqIaiXDrFI9cz41ljaQOrtoFuWLazE1YCRgV7ntkmQMKABYoJesKsb0pE6NtyYYY84Ji3XFWfWOcDtQXkUllpwVT+joW3ARP21ZAmMeDWgORV2f3Hg5yYuBHG6tPPr/XYObCUjZ2+cn1+2fZlGU3oFD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b965bb1-c7a6-42b8-f242-08d8180f8799
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 07:23:45.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNeeO+NV0MrdSYAF6ac1JqfAlTxyvnb3vxrR5R/wRQI8NXYoV9RuAErR0v+3IXmbZt8KO/mJRb6e171txl1MUai6e3MeByqSP5g4xye5nEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5770
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/06/2020 00:03, Luis Chamberlain wrote:=0A=
> + * @debugfs_mutex: used to protect access to the @ebugfs_dir=0A=
>   * @debugfs_mutex: used to protect access to the @debugfs_dir=0A=
=0A=
This line is duplicated and one of dups has a typo 'ebugfs_dir'=0A=
