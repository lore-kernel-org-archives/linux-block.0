Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E2C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9872073E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y/lZB61M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dAgSa5jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgFSHnm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:43:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgFSHnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 03:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592552620; x=1624088620;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=syndOrZM3SW0Ky8ig9nPG18n5CfsPXM8ky9jSYSLwfA=;
  b=Y/lZB61Mqdlh0FrFTLL0K3cw46dQAw78JpaYTNIjhpdIEsE1kFXf0Xwf
   rZCAdpM5gEeCNxIc6SdhqGlSQIQcCNOrCd9mj88vehdLDSENlaFhVUoFG
   tpjWfyukJ52Ovtp+6myew6JmWvIIkF+YgQIMd2kW09KRWPXGFaYrhJ26k
   m2id1Dh4cGh2sYIPR9vtq762Rb4b4O3Mji/nuWsYtKgj6LBEcPNWBMVKM
   iVbXLW+RuPSqfUX2gNiEuULfJLnV1Q7sjbSE345ktSBG8n/Ll620wPOWX
   3oEqkyItdb0qGD1UZjoM/B3wzdMLMgWOLxYnG3IuU6fZEcHYSYPv84fs9
   g==;
IronPort-SDR: o0pkqRRQ40frrwjb/EBL1WkAXdx3Vlqk2HtdKb6Pqilvp7IIefPZ+sqY8ekCr8i4/hdWmsGV1v
 66Cepm5VwGlFQgBAypJqK424QckILHSQKfQ548y9rAhTALbn05W8zI0/xoHpKT8jq68NrD6/fN
 VXmYVwu1+k56k8CWe+oRW9bdLLZlCrDa8R5K5Jvom30SLxK4wb/pK+0A+HyjtcIVdJLHWoJVjV
 8GrgsSY6f40A5dUabNclkZUlJ+GyKiEF44aoOyfZDVb2FILdjH8xZUlU/8lktCLVoBdqmlu8R3
 E64=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; 
   d="scan'208";a="140408005"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 15:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WALb9uDYddM28VrJIgLUYfzzAdZa8deo01HcqhDgKyTkp11M/9Fij/ygPI+d3FQazEOsO03PgJelSYBZPpKZtSKRKeyTPafFT9pporePZg34XzCeU35MWmFJAh0y1NVnI2uSZI200y67Db4QQkFu40mV388hDgf0rX6WKsVTqd0NcyBSh0aZ+blBz1YAdhZIHU6jrVgaWlHS4yvPgW2ekVotAlgMD+hM02cy5XFlBieTbjYQkAo4uYM9px6/AvB71+aw/IVzWopSH7VsfZPVoVvsyNBE+aMA9Xsi6uhGpKuASAsKnbZfRYbdN5fNgHX3Ft4oQ+ewCAscxn1/cpBSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syndOrZM3SW0Ky8ig9nPG18n5CfsPXM8ky9jSYSLwfA=;
 b=dxXI+2Zehw0RwJiMP458hpPV/uZUkFoA2mdQJ3DBfKNW/AkSvRdpIZ2kzOQ0KpU9LKXQV4CQmHauBxC7xESqxASsMPf4LE79rjF4NxBPOebpS30p4v0cWUMnJ7u6ajneGj4R77jCDB7n5X+FkYGlGFSE2X0nPfONV0XJ3nGPpsIEyGKtwPVJNh/gdwCbSXQB4UDQMssAesdwqnx7FnXPStk+6AWppvfd76TnlZEVyzlQAlLQxpTc1QnPQRRLy+PpZajz7nwtQWlc2cCgezds/pHyYF3/qyaS1YKK2rAzgJOVhn91PqosaQswzrT0YgVi7NiHAwo3vVw4ztrRWKKZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syndOrZM3SW0Ky8ig9nPG18n5CfsPXM8ky9jSYSLwfA=;
 b=dAgSa5jl2+HnoPXWS1ICtM8CLRjzhD9SZ75CBsgcUOg4kMRZMwjm+r35uS70k1+PDIlz2gjbRhsFQOHbMkbEUcoo0gntSjcF9TXiRy9FVT7wrSzVfnPhsJsx3ex5xWQCG3meoqyBpnz4DO6N9Can38tlnCtfDjp9VkW5yE4ylx0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 07:43:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Fri, 19 Jun 2020
 07:43:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Keith Busch <Keith.Busch@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv2 4/5] nvme: support for multi-command set effects
Thread-Topic: [PATCHv2 4/5] nvme: support for multi-command set effects
Thread-Index: AQHWRYBY6dkcvfj5QEOv6Tpz1l2QgQ==
Date:   Fri, 19 Jun 2020 07:43:37 +0000
Message-ID: <SN4PR0401MB359884F5470C0812E7EFE3279B980@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-5-kbusch@kernel.org>
 <c8c285ee-6c49-810f-c029-eebdac7bcd72@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lightnvm.io; dkim=none (message not signed)
 header.d=none;lightnvm.io; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:50b:1cf3:953b:431c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d122eeac-e5f4-45a3-2990-08d814247a17
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35208FFA263A2B43719CC64D9B980@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFm5zEfBLsESvzJNtyv3/Y69cHnwICWOsbGxNldGrJD3VCsihwih7oSDYVEWmr57yYYWspBOjQ7e5oofAwS+MqjUkqaPvRv2CgheYKm7huqVjao47j0EGYNcaZj7a+7UGGiQ5mhnin/oMHd3PxPcOppVT77lzW2rtda46naiOXxJjonicApPxxoz3qcU4nGt1fwx3hYESn41VGlwke6ede5MLQkfyLeHxPyqTGoKcWcyJGhB8jYXZQ6CTpINwA9FA1ZdfLsUQQVYhYsbMObtApczRre6DLxcOynK9xXWKp8WlEsL/zxY3e/6WXAziBkIyQJB8OtEB3kMvEDop9Z/uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(55016002)(4326008)(6506007)(53546011)(54906003)(558084003)(2906002)(186003)(7696005)(316002)(8936002)(86362001)(5660300002)(33656002)(66476007)(66946007)(76116006)(64756008)(8676002)(66556008)(66446008)(91956017)(9686003)(71200400001)(110136005)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4LwfZBQwgWV18HxtplNBRVs0092ipnoQbr+1k/5kMFSmxc8Y28JbLK74OnrARUjJU2UcbZB7+h6pLcIPRtGw5kotL3fKghuVLQBgqdxhVs7f+xTL7yUWayCuwoL8BCti4vYmAUOM/nAbsRqUuDT1lZeq9kfwqHhCpReo3eXT1kdiLto9htHzga+ThB+6Q9tGjL/mYYgkoLcUpSBbLzOlNiDsx198lsNrP/AGRB9HUJteOqoyQNlcxlNg5UvDz6vKQB5w1yXVf7Lylvl6o99d8+J80h0vljMZ0xNST6B3ippu7j2WTelNorgD4uqmIg1PTzHI8AUPPNVYlFqn0H4ymWagpqggxAg7RNkqSW5HsUkz4ljpeNTFPsPAOCb85Ho1jyV1BpkNI79DAXiXLssXrdByyvSdjoUHOaL7fPJDcvE6WPQSY2uSIX1Rr78L3p49QzaQWUR29q27sMMCi58XSUIIPx/tFbX3tVOXPR5WIsExHA7xZu6v7cj+/mE0hb5c7xwhdbH3q/0Y+E1Ud4GQtgzEFbcjFCSZfRhwNT4zAVqEB3ogiCnTa8nyoyJVsiOv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d122eeac-e5f4-45a3-2990-08d814247a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 07:43:37.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gjY2aLfcm5DL3xFmzCKV3ZHopKjhe8DpZqQdsgPNfXJlvMN3IjTVuk8P9EviJwcx3ue8zGNrM6KnNQADFMnyg+o1u8QrlFTIi17CheJtdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/06/2020 23:09, Matias Bj=F8rling wrote:=0A=
> Johannes caught the double newline.=0A=
=0A=
Oh you hid that on purpose to check if people are reviewing *scnr*=0A=
