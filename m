Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D351C433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 01:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C630B2311B
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 01:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAMBV7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 20:21:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38649 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbhAMBV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 20:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610500917; x=1642036917;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZRjPaYvjAtdBLhenUxUZrBIXPERLm4qSsQR9BrbJECY=;
  b=VazCM2NX7o0Cyv+Ykd7NWFBMO0on61iUHgnifeOcMvDlVdfMM0p1IZF5
   1hoVvHbpfdOO9w55jxkiI1zjkY+Z5vP6l73a6rMRgUN+smb2vVJPWwIkF
   XcFp30hLgXeu0TgIhwPYHa2V8sOYWWAtjkhPbnJrH13HXBvlX57yyVpo7
   SvWJ7P/X8sTGTHkGm01bF+iwPz6vFoYLbrHoJHTai0YkbMx0rac99K6TZ
   hyjzYmEeF5s+g5HRe/ME0tKb0ddVg4NPWhSlCCLjbo3y3AesXkBSvDFju
   Sk8v6eSY/Yd59wAihck0bG/dmOdFzArEUN45RrJLpbaTZVj1/ivuZBtTu
   Q==;
IronPort-SDR: vT8ZdPD9FXB/QOsSSpPTQAVP6f4wgWMb6p2OYbXZ0/WWKn+yJZAXJ2uCy++qbieSCHsZSNIazB
 +4SDn/lONntMyM3d6IBwBXKsDZUiXxjMZ3FanM5uuTB/SeOQMZCp+cXJVtLiFk1mHSK8UKWmyE
 onCacHeclmFsPzw+aJoMhQPGX/zNxQpkcoU5kGpbbT6wdj304pVSyr3KiWUou1SBetsaj95SsD
 SesR9Y7m4tvAXIGn722g6cDaz20zI96uNyu/kjYSeKimKVnP0EeTHfeX+Y2gzCLNHyYrR+UymU
 vNk=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="161729716"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 09:20:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdSzY8+e7zUCfYXvTh0uW5bvSloQj8+M6VTL5tPTIuh0cjd0qqyRbO8hwoIemfU1Y2Qb1tOcXV70tlmERueE2bAyV6CIfpz5BO+n+ad3e2+rv5Eb+WwDOk+Ix1t1NfWNiZMzHgLDkD8i++xxHlEeVesOdV844qvQDQ+oCoqx/zYn8sElQv8L+ZLp8AsEyEo2VLbOrmaDXhJl6IGBCs0DtNFI3rG/PFvoQr8Z2cGg1yBRx3b/N12q4TVnvQYXCJg2YD1LEWWHhlSbis2qbSiL2JCe7HWqHZP0BswfTotnpuk+HRluF+FHksIS5aH11l+egwDEuIO/+fI3xIora9RJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRjPaYvjAtdBLhenUxUZrBIXPERLm4qSsQR9BrbJECY=;
 b=iLbOKk4bzDdoDsYKedJrIVLrqd/vrcQRXutg4iUuntubv/aXj+laV0waOnHir7wcE8XVP8mYk8d3Tb94LfbKix2S9Bb7btul6+iWrU1XBPEcBmqeucV6kctxju0ImjxqsjsBNLpTsMWlpcJS8s87nKxf8L51PqU1AcH7opfkfanDBc8BzzJRXhHu/Ko+35C0GoKMUnFH9XczYgI7I8IRC56glGeHnZjAa8Wj/lnpac3emUjwzeeFwdx8ZP69qAeELEg1Xw7CzVnYTP5Gwc8l/ViWopP0n2GwfsKz9zCrjBaLgEzBXI3ib5o5CowXdYdqLZ7nniSonU43SMPFNMTlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRjPaYvjAtdBLhenUxUZrBIXPERLm4qSsQR9BrbJECY=;
 b=xHpVZZnEyyJhopvP9/MKUtuJFdFk0wvSRt6BcSik+n5ZaJUWm/+LwIUxFKYQylkczGAMcubIxzUpCXdYF35Q/MVuQTprYkjwhGAJU3pX/dg9IMwIW3/OfJK6t7pLcR7wH3PZlkxfr9krzMsGwjrkat1yxTgxmwDkL9pr60NvA/I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 01:20:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 01:20:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 1/9] block: export bio_add_hw_pages()
Thread-Topic: [PATCH V9 1/9] block: export bio_add_hw_pages()
Thread-Index: AQHW6Jsh/0gWv58ncUe1WmJsE3mZvw==
Date:   Wed, 13 Jan 2021 01:20:51 +0000
Message-ID: <BYAPR04MB4965CA7945266B82A6A8022C86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
 <20210112072441.GA24155@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a987e06f-b290-4c48-0759-08d8b7617730
x-ms-traffictypediagnostic: BY5PR04MB6900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6900377C2B2E2862C871A47D86A90@BY5PR04MB6900.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYopA3oQLEBOgJVYhcXG55F7BXBynhZ30+l6aQhumxox4K4OJqfIXb01yrvCga8efQ9nBZb9JccNq6wa/rBIEulbTkb5a7C5PuFMeBu/kXFY9mQLfY273XFvF6xQHCu3t3BruNKZN/a3czHX/wHvwAGeDPVJxRz6pN7oXpue3fIqNKekP6hBti4gV9JGXaIphC1qKKOEEsGZ47dfIFV4JT9M2ffCBYv/DJh5XAcpR1TIAa25Hc7Ymzrwn6K+EeRdAS09THZLAIfhYfq+6b3484JmmD6/Wi5VYVMWcvxg8HRwuwqPa+tymz0hKTdq5EPmq9wWCXkPLdkDOWPdiLCljuKp29rYmtGQzABy1AGfuVX/V4lmO9+vajk/enhjABtwl4NTfIaYN5Y/HrSK+FcC4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(6916009)(53546011)(6506007)(558084003)(7696005)(33656002)(26005)(2906002)(478600001)(8936002)(54906003)(66476007)(71200400001)(316002)(9686003)(66946007)(55016002)(66556008)(64756008)(52536014)(66446008)(86362001)(76116006)(4326008)(8676002)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?k8puelSpm6gOcBr6dDoAYwlHpJJNnHpN+0cczQ+NqNtiNCU/mFozEGsvQ89v?=
 =?us-ascii?Q?6xPdVGlGAlwLEnZLshB4cZo6Xr2Zd39+ghRqkfsTwHA5T3uSp3RC8LNz+waI?=
 =?us-ascii?Q?uj5X7q4ICOq6vUjlmt+kp7mca+WOzko1eGVOe0mL2BzMxxWlWp7KuHOv5GKB?=
 =?us-ascii?Q?6NdG+TTRMReoB/oE3FYLnMYAwx/Rct0XlrmyQuRSZ3GCi9OxQTAWLwMKHBFI?=
 =?us-ascii?Q?xlcSGSPh7cZgmc9eoYdOgCqyL2bHK+lhu6pUA2BOgWOm2amTzvdD6LR2NsaZ?=
 =?us-ascii?Q?bGZgaNsbMByu87tDWEp6MXTBhQ5vVSm6Wy8gkDaef74dj8Vzq8FqmIe9tveD?=
 =?us-ascii?Q?tSh0JB5U0WSaK+54SjNm2oWX8AOhKenxpevnwf2jnbJGWdZ8JRdtvovDFgzI?=
 =?us-ascii?Q?cDw90xazI2ABUpdbzpnq83WntHWG9ODsV4tkwwkTZzURLwdjN12f1QHYg0A2?=
 =?us-ascii?Q?32LkoUfnl8kK21wknaJupURYSToCJNsw1Nh777P8cagHaIi8vfwK0D5f2AJZ?=
 =?us-ascii?Q?mXmhW3eU05Z9oxKowFMiJg68F7OkVaKADeZgNOdFwXLsGCePF8ssX3pk3njL?=
 =?us-ascii?Q?Gi+g4A8nEvzbmY0msVK494N+pp3sdxEb59PECFvXX7U9XQvF9M4XUjjHu3no?=
 =?us-ascii?Q?t/84EqD9CKnOjMvUCmEpRBOzJ18XUJ0z6j3HFsojY9LkudeAxrbqdcys3S8Z?=
 =?us-ascii?Q?UGievWdwF/5a2v6AIaQI5i5EAX1RjghiHSpYKCt5BLMngElglYHH6Ba/32kE?=
 =?us-ascii?Q?gJT2TC9/or8TRgDi/g7HaCLDQRkvWWwIxTmSk2Gtl1/IzeQ1K6F7ZD2nwDRV?=
 =?us-ascii?Q?mwtBYMFTAw3D34ruQF2HrZDZUHezZ7z620ET2I9Nr146QCpIgqr+ACnZ9EE8?=
 =?us-ascii?Q?9u3VBbc5QK1qc7vab3WImqd4OGPU6DemysH08iHz9Nk4hro8TeiUpnhCndkQ?=
 =?us-ascii?Q?9Nynqj+fMjOBAt1PgIgmO+nN7cS9XP04ap3xHqIa7Q0ZhAMeYtiyyZkLAAcy?=
 =?us-ascii?Q?jH9e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a987e06f-b290-4c48-0759-08d8b7617730
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 01:20:51.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lq3xy5DtSjVCrvTWrA35kMbS0X568KUkJLNzZL8w+XlHKf5/9+RBx7+Z2BG8pjdiIchs3+EYUy11CDGrtBeQoxlAYBMgL+/SRARy2TS9SGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6900
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 23:24, Christoph Hellwig wrote:=0A=
> EXPORT_SYMBOL_GPL, please.=0A=
>=0A=
Okay.=0A=
