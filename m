Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50260C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9FF20767
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bc3LUOi/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xRmANxWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgEPEZr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 00:25:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22801 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgEPEZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 00:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589603146; x=1621139146;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qw3f0KbLRBtuKOIQP0a/VaEyYgAr5G6AY3RtT5C3c98=;
  b=Bc3LUOi/O4ffZUXZq1Ph2cLIvhuz9JdmSCV+JsS/RCnRzB4TeHy9bbCn
   GldABJKReHUhwP1H4F12svHXcVDJKjQJISNk2ZX6r9u09ENdcOeGUJi+S
   V/ybeTazgJhJJppYvIV1Y2eC1KhRtZkAyApJrYAxgxuWd5xkGYrLgu85H
   SltIEjVWRWwc5L5gYZ4hdUKc6gC60+gUZXrNJ7g16+jCHzZ4rYiEQLvHu
   +KuGpiC/FQz8g8MJb6MXmsUDi/Vu4064IyD+7h0gn5EH6FmJnuNDHs23X
   LDK+MLwaiwAdyfDKKc4FtLxIR0VEuSVqxgkxpAH4aZrPRCgxKBqqlh6Ei
   w==;
IronPort-SDR: RQsbd3y3phtdqLfS1D4gb0iH3GRS3LY+26S4W8x3gKPOkm7vFE5OTkiLX0QW7AT9R5INOhaZwC
 ag7o/+2/Pcsgln6yxqIt6dL1nHossc66PZovsy4dm/xA5+A2AfaNQNpXo7gAYyTRDW/HtzHslC
 m3H+Sbs137kJnQ4gGh8f6BidHZfqOYWktOBjXoZA2ibblFv1eRafIlDtFujnh3WG9LU17SAywx
 c2cuuMah44ivv8HlVsS7gjk+LjJA0vMV5TRJuKK4E3ag0EiE9rwNYKZMQRjq8dIvbrCeu7CDHz
 kYg=
X-IronPort-AV: E=Sophos;i="5.73,397,1583164800"; 
   d="scan'208";a="137829833"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 12:25:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzygOomUNa7jAfIGdUqXGvrrhPIIk82QvOKKZSuSTHtWgI/JYBVVwNbVR4JMks+5kwm2sgiEa6eVvfLvBMBGyiGllZjpVvz+1HEPmOydzbzFdKNwlgHW2MBBI2GLTS9+zEoCletZx0h1rMtv+TpqWFs2FhG5HWjUBFxhOwLJ4MdR47tDQNQwC4VnK5qsIW5kLAoI3pa7qCk4xEzz8c6qzGKVscv7mIWbV8DFKo5aYDxPDDzA3tsNHM2dCbCuHMadm4FOrKdpN9ljw8sJGleiHxbl5A5YTeDe7vse395HB5dTqcdgo3ZpuVANHbYVdfvssi5W2RsHtK7mhRpPcJcBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw3f0KbLRBtuKOIQP0a/VaEyYgAr5G6AY3RtT5C3c98=;
 b=JgB5pRE1/0afk/SFRYwWYi/ciwKorhkQ/rLsUwJ1G8xS27zwbZdWfjf0PB79XRTF9lkjLLytdQpFjgAJDZpg4Oz55eozU9p8CDXJjqZiSa1cxDjtIzes8fw1+7SfmAf1tj7pC8RX3UeAN3FBS11pLhFzekRzF5vJYvyNuUGf7AyvhG9Hce6odkg9Tlmn6Z0U9rY9Kljq5+DdAfKYMy33GWIx3Pmeasu9AKGgQcBVQ7HNcU3/eqppa1WofyFwHB5aYXPnOR55w3yRsk2BBUZmt5ku5q1sw+DEGKPlbPtnFCJeoHPvsf/C6CehdMYLIJqGODcduocaJ425xKTHhrNELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw3f0KbLRBtuKOIQP0a/VaEyYgAr5G6AY3RtT5C3c98=;
 b=xRmANxWv6AmN4WypLNtXQTIdp9rS6+yo3UABH5V6WAxTv8zdMxT/a8w3yaMmqI4nWNbrGFzluazw6tecpE7/wmRsU0jkAjfMpnAdaKFnpyevdfIOqM941rtlhUJg688VkSNczIXAxqwxkcF0feN/2/mq5jILmECNqnmJJ1TZH7M=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sat, 16 May
 2020 04:25:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 04:25:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: remove the disk and queue NULL checks in
 blkdev_issue_flush
Thread-Topic: [PATCH 2/2] block: remove the disk and queue NULL checks in
 blkdev_issue_flush
Thread-Index: AQHWKSMZI+l5NA1nsEOkRkP33lT3ng==
Date:   Sat, 16 May 2020 04:25:41 +0000
Message-ID: <BYAPR04MB49655554C7B77F1BF0AE1C8986BA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200513123601.2465370-1-hch@lst.de>
 <20200513123601.2465370-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d9262c1-efa4-4898-8b05-08d7f9513196
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-microsoft-antispam-prvs: <BYAPR04MB58299A76BCED61F66A7D8E7D86BA0@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfN3xe88eghbS7hyQ61uNg7+8JPcl79Ljd1CN20HNhISAkUubbXIvcfq0WDn7HE50bv+2EyQ9AMqph6qza5l2tHz4BgourBXePNFS4gTrNm9R+RbhapLzOXGTbNofh+YUb1gR3lSlWLaCc/iPmpvwPs/+GvXpOuM63xpFBL+zhBZd0qxXnTjitD90hIvU1t00kp24/yP33eE59Ss8+FP9LPZE0YGOAbfvOYWKjdyS81B3V7v/ww/HROEcIcUSf5NVu4J6Z36rfgF1+yrQuD32TJS0U/1teA6pkZxyVqR/KBsRrWTX/qMthsDfCIZoyDDMGc1E2U8KLOWi6w0U2j+SSy9ixEqkb+0g5D66mLY6Q70987kwtKCIu1SJj2Vt6Px8J23MG2nUFZFPauB957bZ0Zk3twcscPyJY5P4Qt0hwo+1kfmwPlXFJCA9JB39xmV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(55016002)(8936002)(8676002)(26005)(186003)(6506007)(9686003)(71200400001)(478600001)(7696005)(558084003)(4326008)(53546011)(316002)(110136005)(86362001)(33656002)(64756008)(66476007)(2906002)(66946007)(76116006)(66446008)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rV4UGBuG9GAmlUnDRM9LMgQL/XVIO2syPnNDINiSe6i3aRNtilib6SZyhBYFl7cQ3LvA/dmvefTpPgFafeWpV29IUaaz4VSsflESXbuylMKZcvgOjFo/ExK1/lLcY9QILS4RbopzL1JTOzg9agMa75GPcOY5EG+3Ti3N6+/ADJ706oHOH41u9/jSrZtEgntMyCDuG9WKXkz60UKZAT+mu6PXdMQo39tHB1kk3D7A9WN9vH//BF/UZXCViXb2UmEozRaDYqhOreKOR5wy+Wf4CJYyHpIe0uwRygMNLPvvQxH+NBnG+3Qw8EIA5GyLPeHzSrbW2EPTJUuUr9DRfpc/PuXb9+FoQoPamyfdFJIgO8DyXO65zIFeI9pHrs+6zli7UDICt2H3FjGsQiBoAGuShLuDqrsx8yfbiga6WiPJ6/08epdEOx3myOMSfqtNInYXoryP7n1XgMkCrKGvEa6+u011Ufgp2xRE8CFhBA0CwNg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9262c1-efa4-4898-8b05-08d7f9513196
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 04:25:41.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8U5xvLrOBllsHScEYQ/FZfWLHWPed6yXeG+/OlxGoCUapVVMPgIgaqcoAn0eVQnqzB+a86iX3TWFgxS1LTmhbcXyr2TQ8gyM9QyJb1drks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/13/2020 05:36 AM, Christoph Hellwig wrote:=0A=
> Both of these never can be NULL for a live block device.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig<hch@lst.de>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
