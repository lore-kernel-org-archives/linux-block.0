Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A7C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961A32084C
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dQBi/UIq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M0P5uXh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgE0SQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:16:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5646 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388720AbgE0SQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590603366; x=1622139366;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dQBi/UIqakokSupm+gjAhqbq+M8dXU2vYk8FAmzo5hanoubsHBiXH3is
   qwI4qeTXzV5Fh8uwcPc4Bm3o5IXW8QlM63DFtj8rq/LbyaF9mmkoOwLPT
   R0ieZ0P4H+W+8iCqvcE6Zs5xDtpzVEO18khCuquY9WsMb8jEU5lgysd8x
   iR1mBJdu8cT6fxCHMV5fOz33gJL2BJ3b+OO0QCGsSSWp4Yg2FREVABMFE
   SUFEtpceDZqOyvXlCNQZu+/YFP1RKT5F+M8sbp9USAYwXdZwkkHjUZmTo
   kD6hlKHUh9tvftwk2+HvIIKdOZ8hXEXI6VbClf8mXgaHwdBXFtk6bEDyL
   g==;
IronPort-SDR: kK56++10dXEtfryHkN2uE6PRzqzcU/hwtlnpLgbPiWKyVziN0VMEavykNUPKdn3Fx62Pgttlss
 wqlyMWJ6pjdWuKLHCVIAckrU0j8WDjCL3gehAm5+49SC/WgKudWCEkfm3JyWJvfCsJCFzpaalr
 SQl/GAbVqraDKDTiBUpZ91OT41dysssIbYuMZTlTle19nqMCnZvXnE2c9nAXA6O+Wzl3au4prr
 OL4caITKSTwHInj0N2jO7wHobdzRdt7HHBcnjzxJwZrFzEk/s//FBqDqRLdoWdsYFfHDx2dEWR
 /ic=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; 
   d="scan'208";a="138965258"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:16:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej++ysIyR9FNWrBgTfm3pnVmD+S59GLSw4Qq5+xM1XGTe6J+awal//9lWmGH1UdCJ5s6iNHALaLOHE4gdyMvAyBNjUuUsa4aRA7wEXtJZO0D+CVVKvky0tKUZjNp5Ovk31Z+Zdme4cE840aDvb/nolQbTHouqBxvYd3aYLNlPF2Oo8J8brjxWIFmQWOJ6/nBOwsKPd7wCKFOtwtq1HY9XSpGLb1kaA1sxaZNvSHYRM+ngRJDBM/Yi/U0KMiPBIDwMfaF/z6CYN3DiwlvR0yS4sYgrA1YTHslU1JnWnIV/64NG00hkVkOSUJuLwyeuBslfJwwQc/gxle3VnfdpwxfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YGNYS+qmDLAL7gAHAptvIhtlNF+BrM/tzZG6NKrs+lTm7AxsdbJypLN9qP1BhxQuOBNJrX9NQ8xFGe76mbLf/99I92LF+MUsFbPxbgQxyfT1+D8NsIBECu+Pl3oBw+nndrpw9l4UMY0jMP1094imyXxI4Ed2KEKxjatiBzKtn0EndUTN3b2LRV1biYPaBohy7ireFJoUesVx5ME5pR3snCyp6Zdwz234uWbjeepEYXWD3UzKSwmnsOEdIiHOVCtIDItL92u9tAp2YM9dz6iRGNMgi/oSXlBY/h09TqahdwpBa8qOEAeZDlHHlryxUqVsoq11XJVv+9mNejEZWI+TaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=M0P5uXh03hRmdG2olrx3dAq4Zvt8xhjc8QCeZUPADiAF+6GBQbkOeKBwKBN3e5ku6J3SXauHWnaN45oFZ83TKoqUIS3QKLekXXItma/Ok26oGsfK6Mb7QbbngWR81OIEOrakJce7A/wf53EwijrV6bkK0lES+G0HP6BDU/ODzm4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:16:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 18:16:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 1/8] blk-mq: remove the bio argument to ->prepare_request
Thread-Topic: [PATCH 1/8] blk-mq: remove the bio argument to ->prepare_request
Thread-Index: AQHWNFGdmK5LBFSazEmsPqo+3KabMw==
Date:   Wed, 27 May 2020 18:16:03 +0000
Message-ID: <SN4PR0401MB3598F74D2E88D19C85F1F5729BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a00dbc85-33f4-470e-47dd-08d8026a0488
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677A45FA43A4D913D4893269BB10@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJJsIYh9CJwP3Psca3Az8minYzbrFrtRsmjCUp8EtQd658CFCx/MgpCipuRykMDJLN3H0wduJvSxeXarrAxWlLIOhKFUhe1oy/g1qqmjMSWvdyDT9ewLN+OYTw+b2Gf8KYhkWN0mye3WpZs3lbMoeB4DvbGyBiG0qkw4QJLoAIPgvxhtvpTknxA15Nk4auex6zkV7LiTibriaDTTiYm6Rt9Lv8D4ApN1iVX1rr6/+CEQIgwPoWT8Ot3BZUa2WyRbFpVoZBxCYYfQM0FkWgtjjrn2J696HMBFnqevQ4eE2G+bUU2mMoiyqWukYzStX1av1k7Q7LESIRAIyDKCweQq3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(4270600006)(52536014)(91956017)(66946007)(66556008)(64756008)(76116006)(66446008)(478600001)(66476007)(316002)(2906002)(186003)(33656002)(6506007)(54906003)(26005)(8676002)(7696005)(19618925003)(6916009)(86362001)(9686003)(558084003)(8936002)(55016002)(5660300002)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CMOMsyJbW582KG6lnwXWj04WPlLdXPXhUv8ggOneoFw9PJPwaYtuUnXZ95GHv5L8P+EVsi4xhnkorQ1A4iD1Ik93YWRYMtDtKt2RJAY3OMY3l9BfsjxNMdUJ3eIHlOGN79lWUVo6Sq2+oHBXs45me6jFaJRcYiaktVuSXyqbapTCTsADE8xPJwD6XiDwkT2oaT+h9hHISXt/mSvo9Xxgy8JE3lxJPdaWKsblxCRHk+02otC9UsxePxRd7VkE/8/gBq3NXZP3MuQzRgF4pLLKSAqyaSnQ/5/lXNSfuWHTIiP5rNfF+cQLCESCXSDSWxec5gLQlL/UN4obkcmivcIntAaWfLdwnKDFqVBRWda66IXG+DOxrVOS3IxLbV9grJFbPjGWIyaH2kUQZAOJBkkIrwHVpvCa3ywhObb3o/+GrKMgaxHfO4vtsyhnP0XV5NDbbhy+siWfINNTPkcevwSqT+5OwYPZaAvmPZ8qyVU2t+XHVlwmBPSnPK5z030THY/O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00dbc85-33f4-470e-47dd-08d8026a0488
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 18:16:03.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BybOQOwl7g6Wp5V0Edh5+10Cxb6yPL4f+3ZdhYipG4996crl9Jn/iAVv1og1kQifvpftzSSmZAvyc3y2HLmsHx+EsF59qoE+jUZJAZLqyxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
