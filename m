Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585AC35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98C22087E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ggY25KzW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="derc/MH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCVIt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:08:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9262 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCVIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 16:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580764129; x=1612300129;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+byj+REjEP0AL7b+zPoZLEVLLvrmRNklVkt3HYLDxw0=;
  b=ggY25KzWqKTd82w5Qresrtnko1DdLcBJycsGaZH4liotEfm7QmqBrwGw
   52Ub8O8fIzQiedgTZNNcnZU1+4Gbvu5RfOI4kgdYZBibq2+dJqN+bVIEH
   m7ArhTiYTU62kFLcko+pdSnA1JlKD7ckXli3peAQ2Rezf8nfsTSZ0Er+U
   /w7hKpIGJOEBf8khHauSsl2p+AV4UGSxeLzL2B3nCKZXhMZSidjmUdP4D
   ZFVZJ4grOtR8NP10w/UohpJ2HghKMpP9571pweeQF5H1hWURy+9qKJ4WF
   OyeMvdw9LcobzZgOMXlo2PJs+6gebK844sOS4uyERew/GHpK5ANJwiKuU
   Q==;
IronPort-SDR: gsIl1fG7qBeZDJ0GmMshH7RQj+3IPbw5PB6pIxMwPdFDSBpzMfOt69cFYksGWV9hbmy4xC8B88
 cucGrVohNAg85P+QqIPRTCzznPfzB3jdh4mpXhAevWxQsvsux41PZtaQay/j2h+bRe1tR7MxQx
 AOcSZ+0MF/calRU88GqN79pEFU4jLZR/PM5UCnmcqcPJO+LaqlFvk0hDj6fBuUDnbpww6HsLXU
 8jAaIORy6Q/edZVmWURnCIyFdJLFwhX8hHmrFNZ4+lgsZyyJkDc4ITxGms6sJ17VR0v+0ic1H4
 1Lw=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; 
   d="scan'208";a="130473615"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 05:08:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBdfQQ7IlkRKEyql1X6gzidaliCU5rwtHLK8cXIgnTo7lVZP0JuOfvv/J+0s4Qi2qKxnL3vqlx2GWE2wV+u8Gn/Kk83CqaVKolDOuVs3SiifQcnU6yPO8/B/O157uXHN50xFzwyl/slZZXQ5EZXgXsjx3GyOrFHmGLp68fdJxo+YSpfNKIXa79e4FKQ8FSdI54lE1UKj7gDeo6JGPyLHmMlWcKAjq6zLKw43m3/8Mjb5ehs8++T3vjB6lYvTcQPRuq4G/p1ptR8UGhJBR9vgCsfrJ7QC4UodrWTApI2IIYMDhcgzVV28JV/v59TGIxokdvGzxlUlNVseqWfjS0ZP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+byj+REjEP0AL7b+zPoZLEVLLvrmRNklVkt3HYLDxw0=;
 b=Fmsd+IZRxXr1DTaUA0CFFbgk3j9IYq/qixlMKR/4cpTt6UFbc+tR3gbcSm47wKwRMnLnSR4m9rQLmQ968miX7PWRa65IrYQQzSFV6UsxopCDZb3sU3T+napSPUzpC4q1cbn3g7gbeNYsZRG1glIRwSZkU66gbnsdwvHBYVs5X3I06i40njOrel63o6r8m/YjvIjHxeSE60BDAokmdRx9dCyk8bD/3+a5gJBG/IougSbDQ73K0R1QRQO+vFZaFUp5vBBlWe3jSD9SrlKgeQFtvWzD67PdBKIaDHIXflsK9Zp5OJw51WC3KiWIkHH3FjryGpHpaA82u2q1OFWg7S0pAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+byj+REjEP0AL7b+zPoZLEVLLvrmRNklVkt3HYLDxw0=;
 b=derc/MH2+x9LnoiG9Gu7voMWPmP+1w2GRvCcpm79/3V1A9fwK0a/7XnMQU7CkifooueywsO6XZ4mtYIrtZX12EAWFF8Vyq3sHp3BBblLy1+ICOhhaYdjYc/KYbNfse9QD4zma6I5GeGtUL/TCdYx7zm9rvxpiDUfWKx2z04VMxc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5240.namprd04.prod.outlook.com (20.178.51.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 21:08:46 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2686.028; Mon, 3 Feb 2020
 21:08:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        "Elliott, Robert" <elliott@hpe.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v3 1/2] nvme/018: Ignore message generated by
 nvme read
Thread-Topic: [PATCH blktests v3 1/2] nvme/018: Ignore message generated by
 nvme read
Thread-Index: AQHV2rDAxCPe7MN1r0K+VQZhs5JjCA==
Date:   Mon, 3 Feb 2020 21:08:46 +0000
Message-ID: <BYAPR04MB574950427DADCDFB94FC434186000@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200203164049.140280-1-dwagner@suse.de>
 <20200203164049.140280-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07fa01ac-f0a8-48c3-f775-08d7a8ed4251
x-ms-traffictypediagnostic: BYAPR04MB5240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB52409386282DD465BAFC2E1E86000@BYAPR04MB5240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(33656002)(55016002)(9686003)(186003)(2906002)(15650500001)(4326008)(26005)(8676002)(81156014)(81166006)(6506007)(8936002)(4744005)(110136005)(54906003)(478600001)(53546011)(71200400001)(66946007)(5660300002)(316002)(64756008)(66556008)(86362001)(7696005)(52536014)(66476007)(66446008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5240;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XD7lemB55U9bleyNkO19/2gKoKDwLIM8gfRkEJDTyLDLXtO5mrm4aHsNuKlMF5dInRnydHRtUehrZPfJyxEleSlw9M07rDvZbqnhG2CvJZ+OFtlC+r6DQ4z9tVvQ0jVqIfORp/uO4RzUAydIGmWg5NI23YX288w8DWgeb2MxgRyJRbb4GgKnxUCofpE347mjoBUEDaAY4WRom0p3U0lXZOW1e53KbwgMfSH6q0ZaQvsZ3fccBF9ODUN+yXeLCB3JkkMxJP90VkEurpmp/Q08GdnCYfetoUh4moA7+8JzEx1DA1ioE/aFY0fsaeWdBpg/EUZ52qwKisDErsm1p0PcaFP+ju1TrVTjlFU9VlsQ5d7Xnpt2EIy+D0scs2DIfmdHZhIkobN0vvTeb9yIkFmC92RY6bzfmTp3V4gq5YSvaGbDVKMXnHwvcjlp/Il9skp2
x-ms-exchange-antispam-messagedata: 4GNHMSsbEwZB8+eKwRg6Cp5Fw2/bYL/XT7jLYpdAM7gCt7ChD/XUTqGE7upF0a0UGiVC/QqrXmcX9i7VyiU1eTQGAeNV2/JQHdVgYhjwMLhob5qu0J6K4ePL/oNAuFfu9X3lgmR3lyyKcFCc4dCk7g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fa01ac-f0a8-48c3-f775-08d7a8ed4251
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 21:08:46.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4spJaEQLk7f1nnhdXxeA2zYbVu7mbhU1h0BepCxX931ixd4tVcKI4VqUBA7OHFTYLxtqFzMyYkvh1Uxd1RIdGlPy58PDWtn9g0GCylW91C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5240
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/03/2020 08:41 AM, Daniel Wagner wrote:=0A=
> nvme-cli writes 'CAP_EXCEEDED' message also on stdout not just=0A=
> stderr. This lets the test fail as well.=0A=
>=0A=
> Fixes: 1aee5f430b30 ("nvme/018: Ignore error message generated by nvme re=
ad")=0A=
> Signed-off-by: Daniel Wagner<dwagner@suse.de>=0A=
> Reviewed-by: Logan Gunthorpe<logang@deltatee.com>=0A=
> Reviewed-by: Keith Busch<kbusch@kernel.org>=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
