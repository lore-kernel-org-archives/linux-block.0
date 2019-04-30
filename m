Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A91FC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB6F20854
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oUj83RKm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HA++E8Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfD3Vi5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:38:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61414 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfD3Vi5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 17:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556660336; x=1588196336;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=anUh+OtMYhUrCVQIb7GE/UQfYFBo10FlhJ7lgzbqxdA=;
  b=oUj83RKmbUTGdTX0295gwERKkYmYkRJDyS3EqKD3JwNO3EvZFGDl+a3+
   kW30Bbe5LstCEgCfSqmE2T0HKzBUrzfK2/pTk1HmihVsx7R7pw1PtMPD/
   Hv+NcY2dE6Q8YVvfc0Tn4pM3vpT5CAiQrU64vu9BFmTj0Cdb+lPwe8zoh
   oVn1zhFhySZWeLHU4HYnOmZEOdDs7iXUrs/JF0I13/U6OFpqN3RU3tiEI
   8YJxZ9ENLpDzAY9TNDiQ+ogAzsiH4a27fHAfsAjgCVsvYpFaWgZtbJ5MV
   nMBH0JhatwIVFJscWbffyP+bUcWoUX3FNaxRCnq+LFg48w5vNEawOSpbk
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; 
   d="scan'208";a="108420245"
Received: from mail-bn3nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 05:38:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGBYblHDEqgj9ENZPZEgSCuuDD9SM9VthfMLl3QtC/8=;
 b=HA++E8Eyo7XOsbQirCwyTDZ4kEeU6pW+QM/fQGYrrPlnNSPmiiQF/ZelUdS69Z+RGxxdaMjXOD3WWwj5zUdbk/o/5VfHLlj3+ZkNGrkL/dHJS5oINEfCmjJ0leer9i/bh+F10qRTgDgH3eAkIYohrJWXxgmSFE3jtAwfXwkTzDY=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4272.namprd04.prod.outlook.com (52.135.72.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Tue, 30 Apr 2019 21:38:52 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Tue, 30 Apr 2019
 21:38:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] sed-opal.h: remove redundant licence boilerplate
Thread-Topic: [PATCH 3/5] sed-opal.h: remove redundant licence boilerplate
Thread-Index: AQHU/4SvaOS1sd4j/kKdXCcOhiLhsw==
Date:   Tue, 30 Apr 2019 21:38:52 +0000
Message-ID: <SN6PR04MB4527EE25D45B24D2A5E05183863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430184243.23436-1-hch@lst.de>
 <20190430184243.23436-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb69f8ed-32ed-466e-146b-08d6cdb43d32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4272;
x-ms-traffictypediagnostic: SN6PR04MB4272:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4272E87E0CD5470368B79FE0863A0@SN6PR04MB4272.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(54906003)(99286004)(26005)(74316002)(25786009)(7736002)(6436002)(76176011)(68736007)(66066001)(53936002)(6116002)(33656002)(3846002)(52536014)(6246003)(4326008)(486006)(186003)(2906002)(305945005)(66446008)(55016002)(110136005)(446003)(66946007)(91956017)(76116006)(71190400001)(66476007)(7696005)(64756008)(476003)(81166006)(81156014)(86362001)(72206003)(256004)(8676002)(102836004)(478600001)(14454004)(229853002)(53546011)(73956011)(316002)(6506007)(66556008)(7416002)(9686003)(8936002)(71200400001)(5660300002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4272;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gqO6ozeutwTiX1eUqRlmAmm1cFoSteCosYD0ey1toAiIvb66FGUc1MgEliAxsxxTC54R9XDhKpnkp7mMuc172Sq20ra8+wxShYb0RUOW3Cp6KxpNixlfsbvTvNoZX5p2RStrfSYGXlmhKGj6clmRikhVS9uQLT1AXVRJljw0CKlSq6mTfgpZnC5ArGJQWNrJcc343i1YkAgKndPwHgttuTc/vG9o7GptFKHNgHREvLLwXhfCX4rquY0C5XQ4HwUtX2Z22On+ie9kdP/NTJbTH+GOYLR+kxQgpXi2nHFknG97vxkxA3mOxs9sTPI1VLTUBrcW4jx6etUkTeEvSmwB1Kn8SDZqdTDK1woYpABQPxhG39yXPKin0vCgDyLhX9NF78bXwpn4x3Q/dhzQz7jY5ycsHCeNUrDxIHxWfcYhduc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb69f8ed-32ed-466e-146b-08d6cdb43d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:38:52.2492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4272
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 4/30/19 11:44 AM, Christoph Hellwig wrote:=0A=
> The file already has the correct SPDX header.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   include/uapi/linux/sed-opal.h | 9 ---------=0A=
>   1 file changed, 9 deletions(-)=0A=
> =0A=
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.=
h=0A=
> index e092e124dd16..33e53b80cd1f 100644=0A=
> --- a/include/uapi/linux/sed-opal.h=0A=
> +++ b/include/uapi/linux/sed-opal.h=0A=
> @@ -5,15 +5,6 @@=0A=
>    * Authors:=0A=
>    *    Rafael Antognolli <rafael.antognolli@intel.com>=0A=
>    *    Scott  Bauer      <scott.bauer@intel.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   =0A=
>   #ifndef _UAPI_SED_OPAL_H=0A=
> =0A=
=0A=
