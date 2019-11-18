Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A32C432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C814C206DC
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 01:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XZW3XRAO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j1EOXyNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfKRBpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 20:45:55 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16076 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfKRBpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 20:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574041555; x=1605577555;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WNZTx9GyoL4Vd7lTFi/mb0kb7oCUmiWhKqr5z6bCBeY=;
  b=XZW3XRAOXL61ioi4qhOg4TIp4WItnCwbHXKmkFpsBL5z6JL2W4aff38R
   JVDF89t5fhHeSaNPD4bv2P9zuxXa3ayxXs3QDrXwIiZKeGZWjxKIeIYAp
   V1kxH5mYuec1kxIHv/dK3I7v4cFHAvIWiztoAQpcdij8080I7VXxFODy0
   NnUlzKPTodZ+NsM9H/l5+ky6ZfmYIEhE5mSoDLj8BP4mocH61UDhiNgVa
   KY3q6lFvVP9xNe0SynfvhTaoMdO6gYALOa5YBgn13YfmdutzSiw9+IcUa
   sRZegwaIdEWb1f3LOjZEERXdeYl5KUPw/T7HHUT3vG8l6RtPdLwbwh2h+
   w==;
IronPort-SDR: QVAehKPDbbPrMVSnHqbo7FAF31zVOt8tU74SrcByLWob+oWYilZ7hq32DDiY+jOvHV+o3hBSDR
 iD8lgcx8tcyx00U5Eb4MSfWt4Xl63D0v22yA8R2rsFys3TXHRMOgYBFFjGREMo1wBR5B+D5nEg
 bcfDBtQXeEbcZV78oWGQTpo5C+3a9VwqPfv3S2iafBgeXbovO0ryqWztge7MfSo7sy0HjlSbLK
 JA2UwzvANMGji/XKj9iYmHd+ZPTC6igCOc/NshluayFytgh8W6kQ3X3BigR96C9unIAdZHryyu
 F6I=
X-IronPort-AV: E=Sophos;i="5.68,318,1569254400"; 
   d="scan'208";a="124028463"
Received: from mail-sn1nam01lp2056.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.56])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2019 09:45:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbbn+wknnClHXwU8wRrXEdC3+dIfwmlcsUeRA5f2cAf5302vd27YQyoDnfyT5Hh+m1zeXHuo4VGGKbrOWezk1jEj1kq33KP11AQlUDuQ8AYVkDFfPl7/yheOIUPwe/LNsa6LHLNYa+DmiVIQIBg/1RP87TsQ4zTcmpqui5LJRcHHZ6GqrCQQIsQBJWwsojmcfj9dkQz+gremPnINRBiJevA/h/jz7vbtcbed1eVoc80aMKkT9G42n5fYwB7bnlhiM+omQRwslQDT20tBiqPzRzNe6kZndcLIYMKa9Nmi+/+6lYbMVRwXwB0Uz99ThokANnk9/8wRycOiAUYpyFOruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvX1t/gr23CyA5gA/ly4kF2WbeaeJFifNwNj94j15Vg=;
 b=O1f1z8HYO6pDBjVf/JcmZAuJKCj2+6oktcJgB/Zupgj72fck4GjlXMtsTE+EE992xwFRoNNoPmp9vr3TRquIP9Kg/7GjpnCdQl4+7Ya+AWgopD3qaygcwoCa1oyDiqTQ/BbDtkSlPADx/iYk6a1I1sZdGBblGOkJpoVxaFszmUhUe7A3O7TtnVaKQTrIG7HTVV6AoNKu4c+adNQuhLGXzd8oIQALvF475oz5wc+/k7evhxVCRns5cotEeFUe8ZG79wmZJrpErUxNrfofaGEg4nbcwzSmYDO/bEJ7v/OkIX6fa51t4TvY38j3UfwglbcHbI0+HAsnDQub6cigpgxlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvX1t/gr23CyA5gA/ly4kF2WbeaeJFifNwNj94j15Vg=;
 b=j1EOXyNuQc/SCGmhjrwnGmf8zYvst5ZJQ8rxpO/kifUHl7bI6cOOOsMBxAxshomzcPgnzcNtaOX7MJTnGCQcXuid6E6GSTDb75HJCOyQh+6whK19OLWh5S7T0TSJHPRCfWgIwJNCyNwG0lNpQ2cmnbWpSUVvcm0hfogpEcI8dLw=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.58.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Mon, 18 Nov 2019 01:45:51 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 01:45:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH v2 2/4] skd: Replace magic numbers with PCI constants
Thread-Topic: [PATCH v2 2/4] skd: Replace magic numbers with PCI constants
Thread-Index: AQHVnaYi33hLetsYh0O/iIIdyDhL/Q==
Date:   Mon, 18 Nov 2019 01:45:51 +0000
Message-ID: <BYAPR04MB58162980CA2A2244626C999DE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
 <20191118002057.9596-3-fred@fredlawl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5231936-d835-4b5a-336c-08d76bc90b02
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-microsoft-antispam-prvs: <BYAPR04MB5864815FA95060EFDB516DC8E74D0@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(186003)(3846002)(71190400001)(6436002)(2501003)(26005)(7696005)(8936002)(52536014)(99286004)(8676002)(76116006)(102836004)(66946007)(66066001)(91956017)(86362001)(66446008)(66556008)(66476007)(64756008)(53546011)(478600001)(6506007)(33656002)(446003)(256004)(6246003)(14454004)(316002)(71200400001)(76176011)(81156014)(81166006)(5660300002)(2906002)(55016002)(476003)(4326008)(9686003)(486006)(74316002)(54906003)(7736002)(110136005)(305945005)(25786009)(229853002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5864;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNuLWPWJfbTju6b9J7yPiCMA0CO7HacfRqI+4a7FbZ5uGJIaz7z86esfm5tNbpztKxLJD3M0XpA1Os8hw1tz+5wsXpbZI97W1orK0JgBR2v1PXKTY95Y5QME8NbeShS4EMi6KaJB3U8RCywlGu7YhNM05f8YY0mh+0wZNCzOcBgFq2NkrfMLQhwKUyVcXcqGy7mna8Q78uLZ3KvuThwvjul2pb6pUzYYvlRBvAtJA41pD8INvgztTLyyL2ULDTAn0bHPEXRZtFTV39cOK0Tax3Zs00RCpXRIOi/yEvdTmHUX7D+6S2iTIvjTP3BDFykul44epxEAOsK9RTZBHR09yKpdn06sbdeBgluf7rBdW9mPdM8RD4DC52Jmo1kf7JvFx1XSxPNXZ5yzIUJh2lzB45zcA79fR47rvt3BswRuKe8QvBNagGu+NSqDgtPi5pkM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5231936-d835-4b5a-336c-08d76bc90b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 01:45:51.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QN6X5PKPFCC+FxOJ1Vg05kVwzZjEaF5RDAQLYGuDkZoCkZmUMBNGQgMZzn/HeJ4fLTb+CQfJFhCsZ4nwcXtH2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/18 9:21, Frederick Lawler wrote:=0A=
> Readability was improved by replacing pci_read_config_word() with=0A=
> pcie_capability_read_word(). Take that a step further by replacing magic=
=0A=
> numbers with PCI reg constants.=0A=
> =0A=
> No functional change intended.=0A=
> =0A=
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>=0A=
> ---=0A=
> v2=0A=
> - Added this patch=0A=
> ---=0A=
>  drivers/block/skd_main.c | 8 +++++---=0A=
>  1 file changed, 5 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index f25f6ef6b4c7..7f8243573ad9 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -3141,9 +3141,11 @@ static char *skd_pci_info(struct skd_device *skdev=
, char *str)=0A=
>  		char lwstr[6];=0A=
>  		uint16_t pcie_lstat, lspeed, lwidth;=0A=
>  =0A=
> -		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);=0A=
> -		lspeed =3D pcie_lstat & (0xF);=0A=
> -		lwidth =3D (pcie_lstat & 0x3F0) >> 4;=0A=
> +		pcie_capability_read_word(skdev->pdev, PCI_EXP_LNKSTA,=0A=
> +					  &pcie_lstat);=0A=
> +		lspeed =3D pcie_lstat & PCI_EXP_LNKSTA_CLS;=0A=
> +		lwidth =3D (pcie_lstat & PCI_EXP_LNKSTA_NLW) >>=0A=
> +			 PCI_EXP_LNKSTA_NLW_SHIFT;=0A=
>  =0A=
>  		if (lspeed =3D=3D 1)=0A=
>  			strcat(str, "2.5GT/s ");=0A=
> =0A=
=0A=
Looks OK to me. But since this is changing again one line that is added=0A=
by patch 1/4, why not make patch 1 and this patch changes a single patch ?=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
