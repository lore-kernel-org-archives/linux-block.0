Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D47C10DCE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F9E20409
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FSoOORtc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RZInU4V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgCOXWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:22:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6313 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgCOXWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 19:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584314538; x=1615850538;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=igvt4mCp3X9JbMke2lJRhCyi0mtP5hgAquf06/gxF0Y=;
  b=FSoOORtcXfiQ4y42bYa4yzmRMr1PSik6gmxi05hC94gGK4qj4urXX1yZ
   LPod7j0ktU5KKVnCoSFrNULyB+TKL3iqOgmxo4+r8F+A89MBj/YqSm1G4
   A0kwSJBxlPduB+I5zoYKfo0YKU3ok59/Khoz8ZY0VTwBJPeSU8zq8FuVN
   7fgcjEhfjwVq82ET/SCSyVj95MTaQJyRl9r4+334bGxl84n/pclQdNfJO
   A22NkA4hRlC0DkSQfauXgzN58hfSH/3b+g3AIC8KLPs81mIZYK1MxONic
   F/3LRn9FOMAwcbrfxxUdqRvTf9gK7AU/e2jQU4hJ3u4PGnrJAtlN9PJBy
   w==;
IronPort-SDR: untCB8i8/5K7mFiCfJUj20eo+thNDo8ZF8Ie50H3dUnoaRYLzaPQfbI6NzfITe3MWGS7nowAKE
 ciYQJ4iNE9ETOewDU9lN7j9S2hwobLUfpaKW+Cl1smqcY9cvfjoRWvwd67APPj64pXRmchOaIl
 mLVncEqDBpqnhuBnOO37A/Xen2WRSRaTvSdk2TehhNr96B3aPgwDTdduh2VC3cFuE4YLCBNxi8
 bINy0935Ad551dg9Fw3B8JRlldYkDjG03qPOCh4rczb/xfH+OhaKiDGjAIJDypejtzB8X6hhk1
 Kjk=
X-IronPort-AV: E=Sophos;i="5.70,558,1574092800"; 
   d="scan'208";a="133008225"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2020 07:22:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnkB59s0Rt7129wEPHx0BWZpX9FyVhvWvqk855MWODPfrqA9xx3F0eeMcD1E5Ziz1JqGwvX0AfoSXXSTG33ONF3KdRbwDGwX5vsuebxf6yMNufI8J2k1zWonFaIVZfODK9jqRiis/8JHo0Sc4POTxfns1IWJ8AzpdAW6VQnj0PToJ5NXEH+Z1blP29XM3b0sEpSMnuSDm3pSBD98d4NZFqyWzJSBRGlSGkaA4XoOPUAYxUNjF5XkP7coK/8nBBe/V/VJCQjVfNbtggij51QGExUgOX5a4A5IomSrBEOdw2G9602YSnMXPXwKWsfRka0vqX/UCYSOCDHoJPaBxqGI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igvt4mCp3X9JbMke2lJRhCyi0mtP5hgAquf06/gxF0Y=;
 b=W0m8tHouBw5QeyV4gUo7ZqJasuau6LaFHRGOprVWwZh/GPtmUxke8Hqpiu2VG9wgfdDeO6AOSxXKZi/TXiQSjJwVRZ13wARineO/tmLyCZ/6I6BAXN8Qz8iXTyVs1+Qgh05vKPbZ3+UFef4aVe40/M10jwCIUYn5e2iL+NN63ZtJU+D96AVtAPNkL/nbjh8/4kkAX25HFYWpvmfI6bmaKu7VddfRRmx03jd7tzbXXjuX39ddpBolYIOvA5aKWeI+rsDmi41P3Gx7NjecXibbG//MuS7mrgNh7oQM19rrk1RN2JFU67G3WKyFpUl8AEJDVUe98do6/3JgITrsMiwcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igvt4mCp3X9JbMke2lJRhCyi0mtP5hgAquf06/gxF0Y=;
 b=RZInU4V18kyMXxdMwTrxKMSbql3VcdQ0QoddGsGZZy4t3nLJLV5if97AzV3Azr/OIzyQuIm1kYfLTiQnPohh93xdKQopbL8yeCmRnSAIQmH12GMgxIUGpg85Gw4HD3am4u1jRx9POC6yRGnqZV6ZYXzVlrYhD5q4iFfKiRNsLEQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sun, 15 Mar
 2020 23:22:15 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2814.021; Sun, 15 Mar 2020
 23:22:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 1/4] Make _exit_null_blk remove all null_blk
 device instances
Thread-Topic: [PATCH blktests v2 1/4] Make _exit_null_blk remove all null_blk
 device instances
Thread-Index: AQHV+xb2Qg6+Oe4sxEyoyWg+JT9btg==
Date:   Sun, 15 Mar 2020 23:22:14 +0000
Message-ID: <BYAPR04MB57496AC6BE6F598F7D159F5B86F80@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96ab33b5-e513-41db-25b9-08d7c937b276
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB525521B467377C7E84640F7386F80@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-forefront-prvs: 0343AC1D30
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(316002)(71200400001)(81166006)(81156014)(8676002)(2906002)(55016002)(8936002)(110136005)(478600001)(26005)(186003)(9686003)(4326008)(76116006)(6506007)(5660300002)(53546011)(66446008)(64756008)(66946007)(66556008)(52536014)(86362001)(33656002)(7696005)(4744005)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5255;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BQlG6xA3u/ymJP3UESsr0xAU4nmmTnN2Pj2tUC7apR/Kkxy6oNMPE7hVubhuCiSpQnrd74yMjg8aGFDYxPzb6v8exVt9BdgdBgdjB2+2INl1VYnHb1V4v6k7P57/pDMyTOHZiOEtSAfR/AfCcxpKZhU/90HSSNTyXZ0ClaXK9WNOpnRCQoGz0Ne6eup2ihvYfYIJKPuvAU7uYajznot7JsfWOuc9vqPlPPrPArz0LkiF2QMj6CiuUJ4Ed2PTp8S/G9PMm20xyzFdBHjKyweBhtoi1oWOA5/yefvuU9OEvN75DZSJYDr09stAVp4s0b1MTbuHAiZsCpy6ziUbMfNZgjV0xHu7eK12nUTQN6YVHj4t4+zzaWlQP9Dd3rPo+qpnP2+UwXAR0SuuAfCH6Miz2dMkjX99EBsxGStX+vYeGG7i0ratsY+JtanYRmmSPZMd
x-ms-exchange-antispam-messagedata: abH3B2jJb1xPWpZz517B2w2MOmFctJS3WISY2js54DKrBXJgRWYeufz3VJKtnE5Y7ltgT1XHzEu73uxSri7eXUHpyUaWo2pIR9WNP/9lIs8cETVktMCUofB1UdBTqVjESYUTvrekk2CDHOekCFWMcg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ab33b5-e513-41db-25b9-08d7c937b276
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2020 23:22:14.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l32h+I5ypnjW31cwY7/1b0Sj4H+Z35x/AW/ms0YPsq9mEB3vtNa9+YR/HWNWPNNtL91McyWMxblIAU4pj+MZQCV5xwk8bkGAdTc9ue1TSVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good, except the commit log is > 80 char, can be fixed at=0A=
the time of applying the patch.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 03/15/2020 03:13 PM, Bart Van Assche wrote:=0A=
> Instead of making every test remove null_blk device instances before call=
ing=0A=
> _exit_null_blk(), move the null_blk device instance removal code into=0A=
> _exit_null_blk().=0A=
>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
