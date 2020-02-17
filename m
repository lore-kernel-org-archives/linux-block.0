Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72063C3B1BF
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 01:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDFB22522
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 01:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lt/epHm1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ss4Po6Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgBQBFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:05:35 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11659 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgBQBFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Feb 2020 20:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581901535; x=1613437535;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xQjTo0o7Zmpgx640Qs2CcxvhtetCfQLBJGOk28qHggk=;
  b=lt/epHm1ggkkHNmoN9W9x6L5tNwKnoq7KCSDkCuqpzwBBF+wj3TIl9Qc
   ihakuEv7Z9Jb/HOtYFx9eeMJf1Sf5/g/1U4AWgGbhCmpqZqMrWFYrkzxd
   0TW46w7pBFAVI97rbk8kB3PfUwFDrjm+k8fF79b0y4c6Y1iBLp0KEM+kK
   FVkuludI7WMhgIUtpqgKn0K864Fg99snIQGMsR9/uNRbPQ9ojU+WQL1tz
   Vakm30HGCyMpZF1Ar1L87GAMFPQ50OIgnSCGfR2xq5f3YzHEAaXo0HNSj
   X6tYepUCpJoindHz3OGAX6yNYO1Um3JIhczz99K9P7E2rglhPNirGNq13
   w==;
IronPort-SDR: nKtZLy4nluHN9AshUgSnuLq+l2LJ6rZJ6SeMVtqfvUcemSF5RmShIPcx2wLhRa3lIcENJe31uz
 UoH5DKLXNn+MMKy9xXQ2g1DUtJ9z4vE4sUWG9ual7gjh69K2p9wbQ18cMTY0pD8zOXPCaM8gbX
 uGN4DpY+qmzmfbrGfwEiUouHiasl+58zg9h7cm+vk6t+AM+1aiT96fFvDoGgQNY11PckV34urC
 RfxAozJgMdKwlGX+3gHdp5YvYJWf5NnU5nOHd+A3WQM/iK2rJsDDpqocjWYxNit/FBsg/O91LK
 xYc=
X-IronPort-AV: E=Sophos;i="5.70,450,1574092800"; 
   d="scan'208";a="130504535"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 09:05:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR8Ebg6K+mzp8RMBrivK8il3eUWaIFuX2geujGQ3MyVlpVUgY6lO5bXtxmLGtA4kxR5oGo3bsl5KZaJaWqvjUs7wY2wRjYha8Kl0G4zjhv4v79eNNoCKE7spoAA/gBzueVM1xg9rWfNILq7FCg6bDvuOxLAZKYCjpjl0AxuQwXLwgluCZrYWTVlYDG2gV/AGHOOoVaDAcvXdWV0oloVSUud3BBb0ydub60lCswPW383AVcsbuIV4n2QhoJbxcPuHosCjs7CDQ7ioaQ27DTbM200lhJXW80VByRb4bHc20dbNaumRUGR/DBA5YPg33C5GSFkF0grs9CKxd/cSB2yA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQjTo0o7Zmpgx640Qs2CcxvhtetCfQLBJGOk28qHggk=;
 b=GiC9VpSkuVEzvLgpd0vs4q0gf9XRDslUKqf9jic8T7BMN3CNTEvm4IUNYcBYARH2p8F1hjpj4kNx6gvjs2vbXzu7c6KJ7epfhZ3e6QN9C9gNWraX6/vGKqfyAPOgKDrGWEyWB8IqY8YHpKz/rKPc0u8GkKAXEEBxRD9jCk1Ax1CvRHtTovsq7d72T0qLsa+sUqChY2wWWp4ULSSx56c17VNKo5TpK7n/vXyJk5FkTS0nR7m2lp6shOt2lNvBDFVdUuQT8s8peU6I1pY4w3m6spEsULmgaPskFmKUzSpyHZungRi4WVTWER6dL6EB9RVOOCCv5tE4BrMM6Z5J6dEOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQjTo0o7Zmpgx640Qs2CcxvhtetCfQLBJGOk28qHggk=;
 b=Ss4Po6UnwiHpQ3F4cUfVTKiu4WLA4mNWXGZRVcZfSU7fRwa9Zt9EOhRi7VIfYDMoMVtDRXqOFkp0T6wCvInJP/I/Y/SXDsOnxUcf/N0or421POA/LPgQLAce0Ft6JQdlq6UTeuk8VZ8J+0h5p+z8ABhYfIFsTBTcj7aCZpw0Dzg=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5668.namprd04.prod.outlook.com (20.179.72.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Mon, 17 Feb 2020 01:05:33 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59a2:b03:15e5:7c02]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59a2:b03:15e5:7c02%7]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 01:05:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] null_blk: add trace in null_blk_zoned.c
Thread-Topic: [PATCH 3/3] null_blk: add trace in null_blk_zoned.c
Thread-Index: AQHV45sA8BcdLPzSYkWRdf3vU8k8ow==
Date:   Mon, 17 Feb 2020 01:05:33 +0000
Message-ID: <BN8PR04MB5812F812A38B8CC633337D99E7160@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
 <20200215005758.3212-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51974b76-0be7-4f22-3a33-08d7b3457d4c
x-ms-traffictypediagnostic: BN8PR04MB5668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB56680942AD36CB489D05D5AFE7160@BN8PR04MB5668.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(199004)(189003)(66946007)(52536014)(5660300002)(64756008)(66556008)(66446008)(66476007)(54906003)(9686003)(91956017)(110136005)(316002)(76116006)(86362001)(4744005)(55016002)(4326008)(7696005)(71200400001)(478600001)(8936002)(8676002)(26005)(186003)(53546011)(6506007)(81166006)(81156014)(2906002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5668;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zT+bK0EcRtYvQmC+NUpTqPo1acDnuUCLj07Qr9wj+Ugd8sfj7f3H4ooCHRqdVntlzN/APaf9yB618hPAzhDV/lSN0W2k/dUGeL5KT51NqDNNhUWP/r5JV/LlXvivCmkpj88+ahQpiqWy4vSJRzPsZO60k5YjvkRnJyhK5Un90bmVzZLb0DDp/OD5LOs5vhyGIZqekEKoTNLC0MzGtbN06LSXcspws8aoSCET5D0RU9gR8fS/bWQ8oDMeRtUZue5GujDSAh69e4nFcx/vqaZqG9BPt1YvxGNlangoogpyU39OzFabjx1LgIyl6VEzDtsiwRV6zTzgLGav6apGrJv8Bk0/JsV3myJMLs0yaRbCtaPLkBY83ehPsbMjaSUNFqcuYNUxtzLMb8OdJTptvUqwkGjtymzqgHX2SLgkPYvhFkhMiuw+fU/YgJLYOFru1TRS
x-ms-exchange-antispam-messagedata: kuFH44v4BbjWhV6gDrA1L33jfv4wCGlnde0ODx6sfKzOMB7DyCuIzrz0oYd6L3La85FZwZfdwYBJ82eR8QHMN44PdF2joiLMS5SI9mvRheoZVU7ymX0IWGqD/P+xtLm2P8wL3Z2N4Gy4LvH2JrHxZw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51974b76-0be7-4f22-3a33-08d7b3457d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 01:05:33.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2NDO2kZ+O3yHyPP4Hx3DsGE0hIQ0xfpTJKDEbDyt3ta+hx/v5hYxgBuyDJjCbSyZb1tK+t1WTGiBJTlzK+qGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5668
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/15 9:58, Chaitanya Kulkarni wrote:=0A=
> With the help of previously added tracepoints we can now trace=0A=
> report-zones, zone-write and zone-mgmt ops in null_blk_zoned.c.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
