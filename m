Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65266C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1B2084E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HMxCRV2w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xGzbisfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgBCVIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:08:43 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9240 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCVIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 16:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580764123; x=1612300123;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8InNg3O8tyZCirHZTXxJmn4Wo6XTg7Kg9TUD3bkBcRM=;
  b=HMxCRV2wddFIB7PBzcW5dw0g4CFYlNLB8bDViAi/xNuJkegmj+dEDAYk
   ERJJcRwDtcurydTtX9CYCRXAAxU8N3Y9hYDWdPHPpkT6gGZE+yLOB7LKL
   fhlNn8BFBS7UVqDtJXI1gOFNWvUGQOrFvG1IYlAvBxT1ddSeOZvxcB+zF
   VmEuqzC8oeRDb4xc6X+dUgTsvwG6bWAU+C1sqUAICOcmQbKomRTzURzgK
   h6zZ8isQatKg+K0o3SBNWaP4b5FckQ/4mJwlnNUdSKyDjHx1m+odH/+AP
   h5xg8np7udJcCOb7IYTrAOGrXXJIcWcclXkYw/SzVqkQOlM/3bjQz+3zX
   w==;
IronPort-SDR: yp3nqeaPWtmp7+W2KWXZxUSiVJT8Bp9SoySCcGyE5B+b1n8uMyQqOAuoRTGb1WTLCz29HhDHSR
 l/NxCL9xZIfM6No4ICIZc/SDVA5Ao2qkpTwj9hHPvYfOHknr1FlSKPJbPR6xi0z63ZBAiRFhHJ
 /8gjxrrWzR0xQE3WXQXNNbjI7/cNiv4STF153d+H6TXn70cCw/YFeRoBsYpYEhIotI9QneV5rP
 CJg9AyELbFu3FlmOcybaE+hx1IIHWQ5p8n01CTvpDL/ZJ38Ccw9t00Nn/jySBBy3hqj/+8pEil
 zWg=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; 
   d="scan'208";a="130473607"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 05:08:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOMK8lVfqEHQW35rvjfoIzCMjNPMa5a/xHNXepvpzDj3ppeWAjC0Ts+OfASdceY4D5G2/07x7s4esy9zTiXS+QP2y6H60/LG3gFe9r15mmEAqd8jn586K7TnUexOHauAYps1mCypYUFdefGNET+BztR/yk/3cR1agsaR5cFjhyNvnIT3jpFnRJhggVNhticH0Lc9nxsNV3G3ZMAatYa0VITpsmo891vOgwnAKf++G/Q5eVzhQUl97xHjIeyqV9YePeYV/UuziIegyOiPaFJ1gfmzn32lUxB0b2dT1VPxtrJh7sdglXepyJ5fq9lD+OVfTG1pFLwkhsTA1/qZmFztGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8InNg3O8tyZCirHZTXxJmn4Wo6XTg7Kg9TUD3bkBcRM=;
 b=Bov/MAQOmePCjvIl34IU0xS/peE9jWf+vlZgIACq4NDAVSVUdjpq+ObhfYYrAS9oHion9mq54J+qQ7SnW8VjgEvJ54ZhXO7Q2ysy4/yWOBJF6nefvx+YQ6ZIjvXJESnXC9vq3IOVv7EhAIRpKiiazsaU31oifBCX3iZeiO/RV89IuxEYqGSec3L5PHF2EqvsOsJxn5c0eUC/9O2AFOpsDPIt9Dv+YaogbzW7khSE7XFmBlGohLcqRq3x4cC6p1t2wzJQH8wyyoXmDrO3qM3Ilr5RoRkSojBz6ap8JW7dkYtFjQVdjPmxh1vA2R9vMEznRsP0CQ2YLHxlFv3FjYYQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8InNg3O8tyZCirHZTXxJmn4Wo6XTg7Kg9TUD3bkBcRM=;
 b=xGzbisfMdBYe8+uu2ma6LgIgd7CkPuGMzKj+v6NQz90+s65m7sXdgPIJoRF36cS9XKcJs2ESlwzzxilOfUsOteVA93xJguCallbGDzGyfYGpCfjnwRKxO/ehz3Obb2jVope8/cyCF3vTBl6HIteg61w4Nr6KA6akThrM+gR0EbI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5240.namprd04.prod.outlook.com (20.178.51.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 21:08:23 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2686.028; Mon, 3 Feb 2020
 21:08:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        "Elliott, Robert" <elliott@hpe.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v3 2/2] nvme/018: Reword misleading error message
Thread-Topic: [PATCH blktests v3 2/2] nvme/018: Reword misleading error
 message
Thread-Index: AQHV2rC/eUpAofw+kUmYpcRtbbmwpg==
Date:   Mon, 3 Feb 2020 21:08:23 +0000
Message-ID: <BYAPR04MB5749208ADE6A1F185583292686000@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200203164049.140280-1-dwagner@suse.de>
 <20200203164049.140280-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d6343bc-e3a1-4011-3b3f-08d7a8ed3494
x-ms-traffictypediagnostic: BYAPR04MB5240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5240A57C1C5F7CE4B862E69686000@BYAPR04MB5240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(33656002)(55016002)(9686003)(186003)(2906002)(15650500001)(4326008)(26005)(8676002)(81156014)(81166006)(6506007)(8936002)(4744005)(110136005)(54906003)(478600001)(53546011)(71200400001)(66946007)(5660300002)(316002)(64756008)(66556008)(86362001)(7696005)(52536014)(66476007)(66446008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5240;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDeI+esxQ7tQTTKjBJiIbRtbxuPPeIR2WGz6g1mm/YFWF9sH0tR2mjEtlgdW1xZn620tM8FAUruz0YAb/BWyq0bD7WKoaVRf6niZwveZjQyN7rnPz0Z4yGEYOE1uNcuQBKjrllFAYOWHj9ZbkKZCYkuwU/+2fJOeGk6KWM1uXCIox0z9NFYpJCh5eoad81NXesCf99nbQK0R5uLADrKwmoTQTtOyE0lC3ZYF/O1pKSh7qops7C9DxwxYOIDrPskjYcxOfXmogsfO/9SefzFIjg79ZEtghwVPFZbXsGiZbRWFV7nhtMgd5zxVJAVJzMHlm3sk41sOOjwAMbC68Y7gkEwxatlMyEbS0+N7jUQV2WBEvMhNrMjrnwc3nDnhfD0mjLnYwvWK0yVc22FuzHwbdYnJ1ySreUoPdek8gvXcJurT6CzODM03K39nrQpe4D2H
x-ms-exchange-antispam-messagedata: YiZvMsuZr4SGSqNZlIludbC+2MrKb5KOdc0yuRmGJQBw6qcdGqhSzWT40++V/UJ5Zn6lTV5sOiZHw2NJGvFKQIoM6jMd0fTyXgyaSgZAW9enNLD4vbBcs7imVgA9rX40Ht7iZgKMzMhsWI9Zl9SVjQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6343bc-e3a1-4011-3b3f-08d7a8ed3494
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 21:08:23.4842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4ybb3DvYaF7nj/zSwuy2EvcGBus8nUnvEMWDpuO173D4Gno2QrSgaQ6JhOUFihW1bmIJpXiZV8Lp5soYACueQHU9e8WQX1Y0E4iSemHtl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5240
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/03/2020 08:41 AM, Daniel Wagner wrote:=0A=
> 'nvme read' is expected to fail, though the error message "ERROR:=0A=
> Successfully..." is misleading. Reword the error text to clarify the=0A=
> real intent of the test and what failed.=0A=
>=0A=
> Reported-by: Logan Gunthorpe<logang@deltatee.com>=0A=
> Signed-off-by: Daniel Wagner<dwagner@suse.de>=0A=
> Reviewed-by: Logan Gunthorpe<logang@deltatee.com>=0A=
> Reviewed-by: Keith Busch<kbusch@kernel.org>=0A=
> ---=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
