Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F91C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12F82074A
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PYTXvCR/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w8ezxV2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgEPEOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 00:14:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11707 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgEPEOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 00:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589602456; x=1621138456;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0FatU4PpZcoRQBxDvNkjaViw3x2h3n9LXmanSY61Kao=;
  b=PYTXvCR/+F0c1vSG5sUHc08opmstVq/v8tpjJcsURO79sDdRXGD8MBCA
   E8jVOzJ02pKRDesYg13E+fh+CS5eTYmQQO4GaQpFrA/VGtUtR9sKu8cff
   CWN+GG105djShP18rkfqEN4JRN727cGyrIqNNt70WgBf6JyeZPw9Xm08X
   thGvRseoTF8CrClODZHZZaVn/Ogckh0FfAkDOhatbbyK5WOkw+PY81uG0
   TUL8UpM9lm2hr/Kag2YuCMr9VpNKfNoU7NPRz0GBzg6aE3AZj913q/XAa
   NLY+P5co63Jc7g35uK9YLiQzO0Kzlg0zaeUxZ43MfgvILICnuXappnSm2
   w==;
IronPort-SDR: 27/vUEx2fc/t7JmLds9IOEL/AAwfJRm8CV0sNNLMLO6wuEVKjdfTuyxQLr9W8rAGX0UZRlXjlH
 L9FFLfyhNZyc+77TTGahhm79dCYOP4YztKFp47tftZXwvSFFBx5RtkrLvQc3rnYc9RBMakQEBX
 gD7s6XBlG2xpy2fxJ2/pQFGiWm+VGFd0Fyfx7wTDrUtkYOqN/3Fu9tmKntYM35dPglUfImrWVY
 Yc1AEFe3dYt5FNMKdO8sK0ORtasL0a+pjonsQGwr9j/UbSGMWdlEbWJSSfQLbt45geJBOzT9Gk
 vqo=
X-IronPort-AV: E=Sophos;i="5.73,397,1583164800"; 
   d="scan'208";a="246801370"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 12:14:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaaA9wI67nIvKOLuju0vvkQEEriyflBci90fEu6f1466eQ4APrR3U85L8+NjSpTr2OHibZsRk5Sx577rk/IIl0affc0q09yRJsvEjF3B3hPbNbFjnusGSeSTYUBH9U8vtf8zyXvHRq6GycODLhs2ZhDB0f+4JR4whWstTWoi1SKxC0AV0CA1I44009EKNR/em0jQGSFroq6hvVzmkyIVdjuzyVmA4YP10VUtovnZ4FwlUFoUzcoclEMyIBYIqO2l0tKdQzgYkNXnjpYHYcgmpWU7IBf7f9hFr+4OhEDA9dOUtCceHmXnmZtA+C1GJN7oCPPu8H/fmJesKAavdxyCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FatU4PpZcoRQBxDvNkjaViw3x2h3n9LXmanSY61Kao=;
 b=kYUyTupY8f2ltjhy2YjlyvJZg0NGNYPIP5t+8IjbFfxjPqeSScxARPjwBwcyJpr6JcW0YSPmh2kUTkEbcdMu2GwLN89whc7oAYBcf1nmKK+OOGMEVFFnWFkke/ytp6hGHLg9ow6Ycl5kImvJuyt6QQZw2PNiTQ+wrQ7NWW9sm6ZFDhe+9R5Vgqi3ltPmGPRNXDDq6WPHKWbxm3QWrncAxvTHLkDtVOanwuB+SXvNWbdtu9gtCNop0wtcqUusfOI3QzKuwD9WOt7PI7QTGEG9aVB+NsvjODhsrjU0roUBqL4G8ai9JuoTvLJOhHjwwTLfHAuRajKtXfVqJpZDKf8oAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FatU4PpZcoRQBxDvNkjaViw3x2h3n9LXmanSY61Kao=;
 b=w8ezxV2sdK5YP5guXyCv60ADJ3JP/mmhOCsdu9GshsvHiMBgpCdDVyL+HHCuiq0ID+Pz8ht3JKKymxoeKuC1zS483IF8gniNyYY4FN65+bD3psQ5Dh+feZO5sfHkL/plpedOpiLWFUPe+E7s+lFcdHeyeBDanNcFPI2lJ4eeW8s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4456.namprd04.prod.outlook.com (2603:10b6:a03:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Sat, 16 May
 2020 04:14:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 04:14:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: remove the error_sector argument to
 blkdev_issue_flush
Thread-Topic: [PATCH 1/2] block: remove the error_sector argument to
 blkdev_issue_flush
Thread-Index: AQHWKSMWWPeb5HWrqki5+fg1PPJkKQ==
Date:   Sat, 16 May 2020 04:14:13 +0000
Message-ID: <BYAPR04MB4965DE35BFC30F298E145C5686BA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200513123601.2465370-1-hch@lst.de>
 <20200513123601.2465370-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72abb8f4-95d4-411b-6fec-08d7f94f9740
x-ms-traffictypediagnostic: BYAPR04MB4456:
x-microsoft-antispam-prvs: <BYAPR04MB445683DA390B9D790B62C85B86BA0@BYAPR04MB4456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJSJLxu2QbNhlVtJrj8PvBX8V24AOpgaXio1ZrKmFXbfTwItJPMDNpIvgqKBkpAxK+nRjmobxugtVgME4xcQZf82DRFXl4yw52BovVJUmuZ6JcTlWLOCwIJ2n6u9Gyi1L4upndbuYOhKcjJ0akAbCa/KOLztWhm3ExsBybY++DdbwJ5dLkIdvEDOyZiLn1m9N4T8iKaK1MQaHi5S4QC81g76SjR3AQ7zqYRiSQ5DCVI6phN+xIJxRMdi/HoIC67SsyUZRo1uNw7oJkuOIbIgzJUCUfHt1BpQvtTXjrK4QRsk4q5AZ19LrkMaB6xkb/cAl7RQOI+h/F+12cyJRDDvVFNNrojh7x8Dqbzzqu16STTnlPdOh+3tsop/PS38bEILgvnFyzKGxrkSe+27LjN53fvrrPqZ3+cR+n/5k4BCLU/yi6jPYpeap1Y149jMWngZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(4326008)(558084003)(2906002)(66476007)(6506007)(316002)(478600001)(33656002)(71200400001)(110136005)(66946007)(53546011)(52536014)(55016002)(9686003)(76116006)(86362001)(64756008)(8936002)(66556008)(26005)(8676002)(66446008)(7696005)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bphaW9PlV2RC5MxnR01XJPg22i0/nInI2nw3himeg1P3zXwfLkiFKR0tejuKPDrreTYOQAy0wcvG0+49EXa+DyjGDRQ9/GwHvst/skiLo0k9v0y2V0Y8hbjqsbXRtcTOHPI0lBl8jzL2Sicrr9pdNpfo3QNZnRGNsTZ/EvsW/9D40MmrAhcb97SMTb1OU1ocCG8iChsVGLgDTwKFtnn9aPsfDm2xoydQMWuthC/gpEa3EEMT7jI54iDM1taA1ognyVjgeiaoYIZxgjt2On8BAh/0soNetCd+I0qYn2ZkHA7Ekre6NqkQ5+H5Bg1FZ0xUjGXwcMG6vFCu8DHBbUFLKVYwYZDENujxiN84Lz1j9Ro2gJIfzZE0oEebhtVdd1OAnivG3LtJxV3IpIMaSCVtTLZtmj8FDtZrhjEghVEuMQ5juXz8ulORBoDhjax1udTr3BeGs+EUbNHB98Q+4Bw5EGLI9dOZV99J9jmqx/crEhA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72abb8f4-95d4-411b-6fec-08d7f94f9740
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 04:14:13.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97wdHM1lfs/CPSbjQxcKUU3GQqivCBPPtVVEQjnmqtvZm1l8ugJHIwXnzg5XJHLk6qY+AJrIkenzbTOIHEF85sdRqJJmyWQa6EEmDUmQTsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4456
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/13/2020 05:36 AM, Christoph Hellwig wrote:=0A=
> The argument isn't used by any caller, and drivers don't fill out=0A=
> bi_sector for flush requests either.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig<hch@lst.de>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
