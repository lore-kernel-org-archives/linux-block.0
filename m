Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA66C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E568208E4
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CCPOukw7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TXYISwqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJUXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:23:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24341 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJUXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 16:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583871828; x=1615407828;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u9I9YCeiIV4rcTXBUllhcWIBPGnSQFP6N+zLSEYoNww=;
  b=CCPOukw74q/XDJCSDbRTJ7CXILxXAJ0WUa6icazLdIk01R7Dz3ANje1n
   tpUaMe/QjZeI57OIe0zB40VDsGk2IciUK6vpcJ2JRh4vKX77FFbN3I85t
   LLjGTfGcTGi4Q04MqV87LHII2ybHapI1JlKNHBHD8h9QOs/XDbZuREENE
   0WGT6c43HO6xwvxQib6RtBEWNC6tAR0ZP+MVPeZLu6PTkHHNlaZ2EvE2F
   RMMoecAy8v6iDSmgU2G3m3hq5nvhoG5g/bB85wP5WG1xw9d1NAccDxPeC
   b9y/LQB0lCLWYHeI+HF7KdMt17KiyzFin3e0xLra/9H+0rbH2A24E5s5b
   g==;
IronPort-SDR: J7i4q+sGwEa6YQKOCfERKQTr0WN/9OVBwYhqohpuiGgv75gM75ZnAyoVB6AdTjV7BDNt2IM6dM
 tlvGf3EgtNF3XM/8uZYX8x07WMZxwNA1d7isU+dBeIlNXAeAcjVvI4PjPLqkpJCD7D96zLwqjG
 tfyUah98wAzvolLOkZcbi0/MIZw7M5h/hNWMK16eeU+fMk6zIdNoZ+ZHp5vg1dZyXlknmgMGDY
 KQBmjF0WK4XS4mVBYbyjHA3HYVH+oK3cgJSywx0q2B3rQpICk3he2umpNCll+CyYwL4Np6226e
 IqE=
X-IronPort-AV: E=Sophos;i="5.70,538,1574092800"; 
   d="scan'208";a="132094204"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2020 04:23:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8KKx3GHTo+etECO4PrIBvjz2VNRN94qIyRfa6F5VQHzOjuycW+/X2ZRRyuZc4N/DywuNmo1pfjLSQzOlx99o+cZ/32d4hf3gb6SfOj1PpbEF7W6pVgJDBMGYFZHuPmolRpXBRTqAN/DPni2qIZ5nISUn9FgIvjHSCrjIxOdBP+8O8BaCipRKr/VbcYCliT99jD2OFx18IOd+J0UWIJibofFeeA73NobbE8y1TwdZWFgqdJMYwR1oKx12RB3KglfusBA21I7TYOVaFoUOBV71XpEEbl0t9vK6mu4STsIYIGv8j5mJo38Z7AKeWQ30T9rKzeb6nVrFoLnARGUZbINBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9I9YCeiIV4rcTXBUllhcWIBPGnSQFP6N+zLSEYoNww=;
 b=NYCfVZDHWnvG+/T6eMdOMRwtyTsGJI2Dn088fce3bXxmsitLu6htWqQFRxYd9eaSx2oyAZsLji4J/J10Inc3hrNbTh+vrSlehjUt36PlcNVRkY2GAUI+c9gDRWTTNordopYsvqb3A6jBD0PSFVGD1HRZU+sB7RA33jsQ9dJZjvWTE1WjdkLacifL/Qs+0gAW7pU2JKUpodmx1dtPFKV/JthGYgJwOwF+R9np99Mqy0ovL0k74QM4Tpm5buSHZMFTTtVympVh/uTAq/S6uyvjr55zGqUX/Qv0zNqleAz+wihGTGfprlYzceZG0GjQ8SfuaGuhV9GTeZAs0SwTqm/yNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9I9YCeiIV4rcTXBUllhcWIBPGnSQFP6N+zLSEYoNww=;
 b=TXYISwqMj/yj2LUSQCwxz2ZZjvzWLRFhZRwS3Y+iUMxRfevqbHAt7DekoHxIByzg0N+i9ddHHVi0ieWBdyiaDldPKHEpC1pmLbw7tJjoYCmWDSfBWXRZIGMMLrN2+PPblnoUtvsD75bWepQTmkWY54dCNqstEH20RFLGyTnuw64=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB6120.namprd04.prod.outlook.com (2603:10b6:a03:f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 20:23:46 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:23:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Martijn Coenen <maco@android.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH] loop: Only change blocksize when needed.
Thread-Topic: [PATCH] loop: Only change blocksize when needed.
Thread-Index: AQHV9t4ymHRqJ4/teUKyMDsr4sOQ9A==
Date:   Tue, 10 Mar 2020 20:23:46 +0000
Message-ID: <BYAPR04MB5749104A80045EB0BD3EB28886FF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200310131230.106427-1-maco@android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2be410b3-0094-4cf8-49e2-08d7c530ef86
x-ms-traffictypediagnostic: BYAPR04MB6120:
x-microsoft-antispam-prvs: <BYAPR04MB612044EF1FB924ECAB8B12F286FF0@BYAPR04MB6120.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(55016002)(54906003)(4744005)(4326008)(52536014)(76116006)(66446008)(66476007)(66556008)(316002)(9686003)(64756008)(66946007)(478600001)(8936002)(71200400001)(110136005)(7696005)(2906002)(6506007)(53546011)(33656002)(8676002)(186003)(26005)(81156014)(86362001)(81166006)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6120;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IH7LxusKRNqyXHG0sd/l7Ow9FwsDg2Xj6qx/HwNEEAhrDxpUvMorv15uWakmYeLrE3MgZqLzBzNgs9sOjtf3g0jnXcj0qu1MiVeqliuJBmA3kgVy+sD9gQrJCa7PuGCl0g6FIbDJqHLoGcj5qOBra7N1JCHo+ut9ALnTOpqlXV7mX3iffOV0dEa68Bdu6YMhEdp4iFheJ75IcMFOQ/3p+9qll9LNP053TrhEdSfROm4T8FuG9qfAcK+vCO+A+K/YujV+lazxfXFgikAjWpNr0dewUXeXWeZdT5mcItYfbsw7LzRaHD38NIAAM27qlXhucaXhUvzyYfAhVqC8nmeaz4bBAAMkkVo54KhLQ9De5Iud/0NVXDpR2+pJQxzqrzGwyySlagGzuwAXjIsrjxqtwZxROp6ZmcKUIAXcwe6dvHSbSffKZCtnCZF90YqvrGyg
x-ms-exchange-antispam-messagedata: i6QkPO+R3ctdlcAT3PY9abjhBLirqt7PhxZp9LBPQGVPib9SKg5FQU78hLLVbHRtP8KHJHqIGfNzGmYYpHXYjxoLb4rix5g2H+7+WTX6EVa5Rwx7c2/QHHJO38vN7hILEdoymUr9n+H8wDEU7mqS9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be410b3-0094-4cf8-49e2-08d7c530ef86
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 20:23:46.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vx5FirXtyoc/iMG5nxLepQPjG9fMYW+rNOp/yanEOfc530U0KDabCVNzdgFvI+ZWP/4EnxMPhY6GStKwXbi/qK5x1rlurTNxlJXcDrnaOpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6120
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Logically this is a right thing to do, but I wonder how much speedup=0A=
you are getting with these improvements ?=0A=
It will be great if you have some numbers so we all know the speedup.=0A=
=0A=
Irrespective of that, this looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 03/10/2020 06:17 AM, Martijn Coenen wrote:=0A=
> Return early in loop_set_block_size() if the requested block size is=0A=
> identical to the one we already have; this avoids expensive calls to=0A=
> freeze the block queue.=0A=
>=0A=
> Signed-off-by: Martijn Coenen<maco@android.com>=0A=
=0A=
