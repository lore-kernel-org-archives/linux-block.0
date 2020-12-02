Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EEC64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BD022206
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgLBIgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:36:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65438 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgLBIgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 03:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606898159; x=1638434159;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KtBL/alvIDAg+yDvX9DgB7M8Bp5srYIhHVqhT4c2+jrsHjyddehkhV1B
   OpWr3bUSvsdIQLoLyfMawke0VYDjrpVOn3CamssEn46X3JDMjOcj8ldNL
   7C0Qg+GFn0dK8BtJlLHWHI3sF51GLc6Sfd/v2XDmZRv0Gq+e6UgGjutCu
   Li0iP0W6lCMIpvXB/DBQaWhwqxWVPVoHSiiN5o28nYXgERO+4XYUKQPte
   larAeIHohuoikwj/KD151nm/EPDWg8kxrHeZadbtOFLDG6esMD6K5UqGO
   8lD2nsxM0RjBc1mpn70pa6PPXNfaI6oO2Bi+fQPCwSMs5IxJxhp6IRqPv
   A==;
IronPort-SDR: K4OHu8xJatOumRpNtOaPD/mdVKqbfHQ+lIZUrNbdsYxPP9pZXq+AZ3o3/4t0wFf+V1UEPxCpKH
 7zbLpzq73H6f52DnecUkloI9ezjb1hCf6YnwWwaiivfXMQ+y0xXTTrVLA+CqJLaC83GHNh5lRq
 y3gRA9PeY+qhZPPCVI7yFGNw7WhT53qTLKT4OsHdI5vnjzPWVjBevDrmo6M5XQ1n6TcYm+CU2y
 8d1KS+KaTyOxrYqSsTq7QODJ5EcXad06X/3eRazlyYWYi345ydqFaSzfBXGgiERCOG6CrDXeFe
 igQ=
X-IronPort-AV: E=Sophos;i="5.78,386,1599494400"; 
   d="scan'208";a="264136629"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 16:34:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX/FwR+qzX8W0+puORm9ntOefOnjthr+Hbv5MMn4JJp9TSzkDMil5jfnTr2NxvnZoYNPBikE61M2pl/najjsdgej38QHsmBgvRs1dG9uCfjp1GBft+f9H9s/0tnYVaBkgXsJe4WZjH1olrgS3ocVmxrCfIl3JyjP+V+Hu7gLMtfSpm1Z/YjrXkinDTl9iZS4J6aIQby/sllRICGOdMIzIuRB2lo1IU94wBxX1AnLkxi2vNjg0bXf6+tAMTJXYBuAMUyeC+Jn6HnvyhWWm4evdPlMPfNHFFPJPyl6hT+PtD8kTX7z5Wr01+PzgeZY3Wc1GPoU+3qAUigSqZMMpDXpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FUNBMQedIV5pMp2YenukQOXBClM+Hj+Tu7jXh0D0ysDXw+YuYu79rZ8un1VotN+8VKpsyOwyH1tFZwwtACdNKvGmM5B/B+quVb+jC1E8MCkhzx/k/Rm0+qGr40aeI1lXPrvGFaSz/TmMOxg3Il8IhFilM9bG/0TBu0ymvH8APYrXYWccFBJ1W3QZXSAAFoY/Hnzsa5KKYIPt0zbZiMTLcyzjfKJ6WzMd5Nqqe66GCK38NB3V0W6iqW1VnBWmfAwQr3EE1hAjBSh68SmO+Zvd2jmDIBVB/9g/jFtlcX2mi6OmyEtVdtOAJQrMbuYU0SZKaVJ0/ojpFIxJF3oT166IYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=if4vvfyW3n1pOvO5p2HFMxNRET6M8M1/+QLf1U81zp4QSSMY7YnWaawJiiL4FeuBtHkll2DNu0vpVfe9HPmF+72BWG18+qmfhc+7nDpM+/nJzIThftrrp7lSnAXwurJqhC7a0oIK5AC+rwoJjSNMy5xyLuMB7Z4wW4RopqTURuU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 2 Dec
 2020 08:34:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 08:34:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V4 1/9] block: allow bvec for zone append get pages
Thread-Topic: [PATCH V4 1/9] block: allow bvec for zone append get pages
Thread-Index: AQHWyHOTuFiODGzGI0ivmGPqQAQD3A==
Date:   Wed, 2 Dec 2020 08:34:53 +0000
Message-ID: <SN4PR0401MB359859A38356352823473D259BF30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:10b1:51e8:1aa8:b188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 431965ce-7264-4133-53fb-08d8969d2440
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36788426441C77493532C53B9BF30@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYBIvPhth9MiISyKjOUBNTy6DBS0aDYPD4tAAyp/hMzS4UprNh5UMSjqbkezSdjZfWekbqugrz7tVrghyqFfhCt8zjtHqc7+7yWocZm9wzQ5a89RvB7sYs+S3VaMvVBmwg17rVr07R9c+eL78uICcV3JrnnC5gR1+fQO9kyG6vzFqg5dyPREabiZp9pYcUl2VzafBmf/jQHw+AxnjNOIsaXnVsAPs/fPTDBkdi2slYJhTl3uAIHGY9n4bWCFCppbUsbbZLK4wJZnPWWTiGBR/dPGYyaO6a9Ttv3usjQK2XNMVxLEnLZYJhplxUFOBLJOgeSYy4whXDiu+zySNwhWkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(316002)(54906003)(6506007)(64756008)(66446008)(86362001)(66556008)(52536014)(110136005)(91956017)(186003)(4270600006)(8676002)(7696005)(5660300002)(71200400001)(9686003)(66476007)(558084003)(8936002)(2906002)(4326008)(66946007)(55016002)(478600001)(76116006)(19618925003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e/oFvNhtcFNCJYpfw6fWs2+14pcaooFS3l7GdHsx0c+KiBNUEi3A6YKKSmZ7?=
 =?us-ascii?Q?gg5pnEz30DKCevxir3pIYZCIqal+dHNit8Sl5csDKA5T4Ngj0t4U1AOWDyPT?=
 =?us-ascii?Q?IWNoNzZkMxtbGzdCmnIGgbYYvhbhLsrem8CyhdBQ2yz+xNJo/qvZfEZBYE4u?=
 =?us-ascii?Q?IzCGG7/JfBq1qsyFjTlUro5hgPTZkPyiCeg4PT19Kxm+/eJXnG2VASbnwOcV?=
 =?us-ascii?Q?rjV4ONYnTNivmwrhIsn2yvU5L+Y+CeU+acRPG7mZpcCEPl/EJmSgYdue4e44?=
 =?us-ascii?Q?yewJ9aaBU8GX29BaF2/tzozt4mrOrdEimZRCIVKGX4ufL/SIZs1BwUhW7aOV?=
 =?us-ascii?Q?a86lI7l757SY9bGzXKyYZc7oZ6nDpVQIjjahAOS+6rPuflVCJT+54YeLdtSe?=
 =?us-ascii?Q?586gyln2Tg7P/5Awb+KLdfQagTjut3AD/96jNRuc9qucBBV77YuyHtVV2bHb?=
 =?us-ascii?Q?bc0uNElXu0kIX1qqfeEKzh/FojSu05dqdissJnFB24Pm4jL64PZ5Q3afRaaH?=
 =?us-ascii?Q?edp9giFGEEKqujkFeT6S5k1V0qSuDwbRmJxyBghg1+5W5UdDpHQUTaLAzT5m?=
 =?us-ascii?Q?a2OFCbPUiyXxkDthphaHV8MG1VzHuLwob5YcgyW/MF+lLThHVIbGUmeoIURB?=
 =?us-ascii?Q?r11VGgSRWIflTMgXh6txl9WwlSohBm8iTg2N74IqgUz7i3RnkjK7XPD3cUNj?=
 =?us-ascii?Q?oxfE7MGhXwCLpE3ViqFRNSSMHBaL8B/1ql9GzyZnW2//pJ8V7VjQ+C2uS5z+?=
 =?us-ascii?Q?fC8IDsRlffh8ClqnYpdFPEc68f+AhB7IXoeDGrvrwOYEYry5LepWPrtUfNu1?=
 =?us-ascii?Q?wRpPrJjum7BiAad/AZqA+gogiW7iQuzGIUGleeCGdmmBadxZz72ulUTjkHW2?=
 =?us-ascii?Q?4tjSQGYRu0qvB7lrRn2kTaNU0aBSuP4Hq+1y/S9fcDMrOUej29LdkjM8b/gd?=
 =?us-ascii?Q?mOCLsKuxgPUAX9poMZzlElcfg2jg6iZcL55ddmi1PxS0s1iDo49KHczvYGAC?=
 =?us-ascii?Q?kZvmF9v2HGX4Gv/+P3y5MzoS8CnVA/kcEh8dMwbn/FYsKlVDd2ExHeLeun2d?=
 =?us-ascii?Q?F8lRBDHE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431965ce-7264-4133-53fb-08d8969d2440
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 08:34:53.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1doMZNV8mk74TWX6bnac9gGGhAsVaHeIUkvwSCt+z5sELrhtBHPZM5lQqzdf+wtoZnmCS8gIUiajoRBmPx0GSIxoBRCqXU0vOmWAQ51QKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
