Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE940C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E909206E9
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbhALGQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:16:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4115 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731619AbhALGQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 01:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610432165; x=1641968165;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ipj9Gd0ehDtXC3vaB5Bn2wUtA4DHRV+3K88oqBsMu/Q=;
  b=ioO+kWiP5tbOOc2Da+8rRh99NecF6GiCoeluTegTcPQ/CYeJYiqpnkhg
   CXjmd2iKSzjSUcMwYkx01EMyRF0XLnh+/JN72VwHrhuKPiL3crFZ8BQed
   pRGkR3PMCUSVPWCqGme74kz0JE2b0lzMEbdKbff9P958n9kxJma3efDOn
   Y71O3pOh0AmHcsMt85N9U5VJ+NeRJYp/sPO+EhO2x1nU8Q+E2TNS6olBL
   8Rq2YWZTOGotEmPSbqY4oP9Qh+O3qG/n18/gtXlAfhQ4XpF7wRCldV7dE
   Kq8eBIlSEMoXHYtEf0p9K024EmF18OONryEzjamrfvDEX7Q2vPhiidq6J
   w==;
IronPort-SDR: 2ED8KGznFvWJa3sPMIMNEYiYcu36hs/eM4LDBa4fxIw0FGLXEKd0efpz3dhpTlzRIA8A83/n/H
 LJxEyK/eqzqTHgYnc3qdTCJwi7FXSEuVJxEMEWu8Rl3gBv5bD3+/aQm4AH73C2kpwpiwbia6A5
 EsNHz36OiK9jA2gnsMbcN3aUKQ+bVEF94bf3KOE6RmmN+ECHkpsn9cAzhLF1bCTRb9pwKicRHP
 k1GRTLNIHNP9uQfOUx45R8iuJ0ZTGtvo8HEkF5o2dCR3z7EIwL3/uOg9Rig4us16PyjEpVcaB8
 eNA=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267511337"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 14:14:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbfsUXWflzSp35JC3Ug91v+oO8Ozm2MY8a7s09JnbvmTrKdSxsvsB1PqylDoscHEPhBCMwxmSkDFh1p+YdN2gplMsLpCRwDAm3vldm8EJ6OqRMLDf06ICigrY1Sy1zle+OBh+ciytJLUH6QKrRA0JmQVE/VwIjCf/cKgD24ZYFDQA+Mds1aDKskmegt78j/WJYgnit/LdomO8wRLnw9KDIut/gw8nNjRgh6WZY13sEdC/ZRUT1D68xRMMwnnrUl68eDVsMd/mFMZJBvNQGXv5SLRUps9Hhpb95RT93ubTFuw/mXYuQlaZL6jvB4k5z8hUGefsjQDtqpWE5qLMgmTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipj9Gd0ehDtXC3vaB5Bn2wUtA4DHRV+3K88oqBsMu/Q=;
 b=FWlMXQ8IQqA1Jj7KLiHU5Cey2KjDLzPkEyBh/C7WkeM5GNEIgowX2asm+BKJ4AGE5SjMIZotgBR/1Z1Ox7XxBeIBq3JdLHxHjtsxJTyFGgFMXgCygaOB3JiEkffebwGP9RET3q3qXwPHahMa8ZLnpqZ9arR055pJJUox/5fujV9zku8qnFvWCSdbGR8oMZM8fgnOjPjVq9sr9FHcsHIyOr+NpN2DlMtNfjNAtAA9M538MWv5dZ4cIZIGUxWvESBNKrhC+v0LyoS/doqq9RZ61Dq/7bHc2l3MzMDS7KHZDpbgAM+xia0P4DaMpFq3khxZQ0v2/Tmt+ElWjz1CZudu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipj9Gd0ehDtXC3vaB5Bn2wUtA4DHRV+3K88oqBsMu/Q=;
 b=IsG79RYONNDznxIGpbGbCcuISDDNj7tFSyGK3K5ra1AA/tzJZ/yF0e81KJETCuzGxr8a26dyl39VoXSc5nsVdP6Jdisu1GqV2MTcy2YXLG0OVE7c38DRQE1jJFfaodUHjc9FNCLOdYK4FZujYbGRG+p5jXpGw+qpkiVmvrBO27I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 06:14:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:14:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Topic: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Index: AQHW6JWhR5mW3oqDJEeeLViUBHbqRg==
Date:   Tue, 12 Jan 2021 06:14:57 +0000
Message-ID: <BYAPR04MB49653C161BF9EFF21610CCCF86AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112034453.1220131-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3b8be0d-257f-45db-ae39-08d8b6c162d2
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58954C2E5C57844BBF584D2B86AA0@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8N5W+yzz/OTWdMXP4+C4GKi02mzAbfL2CrXQ6U6LyrIBZnmJAjWRUupfdxFsdBcSl5rFGENF9aj4nVQwPg8lGd3eIll717dnFsvXkXWDEaSM/vTRVpIOcSqkxZisukTbRDo3gGSgqr+xljsxfJ9DJWpYP7g80F+IhLpeIX0u8pC7TNd2CMJEHhbot2aLUi98Va3yWhyVOy/tnSNxY8f2Ik/VCFzliaJq7/q5Yl4t/Csa7zAQlgGjoxYmVCcnOwxRsp4bVrcyVpC8O0IPLgo7cQ/EU18pyzaTbD9ssjmJXOAzb3vIV6Im3G3nkdmJtUTLbGydQhN6xp6H9hrwzC0vP4gHVU95smv16nShKELQN3HH6aV2IVq3+mpjp/SjKMzf//FukfiRQMSDL5C8HSoNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(110136005)(6506007)(316002)(5660300002)(53546011)(2906002)(33656002)(71200400001)(4744005)(26005)(186003)(76116006)(8936002)(478600001)(86362001)(64756008)(9686003)(66476007)(66556008)(7696005)(52536014)(66946007)(55016002)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GKTXHyzUydzTUbm+HsjP03GFr54mgN2TyKmKlyTbS0DVqFfRzIJ4jSl2f3F4?=
 =?us-ascii?Q?/ARX5APidvMtHl2FzQyQZ1DW90Ds9exDJIva7/bujJazMXISHQ3EdvQMxBWz?=
 =?us-ascii?Q?tDJIgvlZD5ZzO9BIJ6FC/26SHjys8+m/dJ1wW8XUxFOM9A9uIzHRCnf7YfL0?=
 =?us-ascii?Q?97AMlhoixFnyqIsfOFOpRIFY+ZoRAaGgaMtJVo+zUO6VuuzfH+L33TDQgAlI?=
 =?us-ascii?Q?aqsh2Qa4wreLNfaLXGpOMUtI1IXl3MPrYFXYXdutYJ6uBxI7CID/2FwMONWg?=
 =?us-ascii?Q?GV5iYzE3457lor0nmk36UAXV9RS7/kGPKavH3+t2/L5aLXZvjEJRaUPt+Gc4?=
 =?us-ascii?Q?CqSKwdRVnYz11jDjWTQYHh0u89gbKKphLLmL2qzVujZOEeiZxZePJIgm57E4?=
 =?us-ascii?Q?mtT9SWloMi3fJxSjcKWa2JNxVC2m/4G+ihOprAG0dGPT8qLNgzfbT/VJPZT3?=
 =?us-ascii?Q?2XJjQA3AEg3MpNr0BNmJZJtnvR3hASqG0q/Emn0y68JBTfkAOsqy5xx20ify?=
 =?us-ascii?Q?euJr4rm8/iuV2Lz30B2mwc4mI/n9gXFlEPlpaDn7q0GtOurlUYrqnL80VqHp?=
 =?us-ascii?Q?K/KuM3VPCbjm2AAWr6ceybq6uysbJ0zrcRyc7KwIMO5wlGIyqylGMu9Q+9Rt?=
 =?us-ascii?Q?/xryWXaRLZltwrmLuFWTC9rZtj++0rQ7KEi5/CNsoG6YbuZgrYJyxR5ANUpf?=
 =?us-ascii?Q?9NWIVvzyWZaXR0EES7HOss1bNWzrXdzqugRPyP43DVTxNHjfEJ/TWUXKwTlh?=
 =?us-ascii?Q?7G7KH6pLblD76OTZvX31ChfLUr9AnjgqgmHu5u55sTX4H0doKriL4UDzhiCp?=
 =?us-ascii?Q?dIHWn8MnOEhW3q3sMa6QJSZKUjsJT4jT78IZGSMlY1w8HCxAgryphaDae0Fz?=
 =?us-ascii?Q?FlQ16MRGDS6/Z1w/t0smvI6A0rLXJQ+iOQTsAHI2/qCSiHyv613WIPDJHkIa?=
 =?us-ascii?Q?kqOK9uz+t/Xp64I2da9M/56Ayuz8GpqnNDpokRmFdZ3tmQZPLw4JfjHuKBvz?=
 =?us-ascii?Q?nFIA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b8be0d-257f-45db-ae39-08d8b6c162d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:14:57.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3i9woP0ybhglq4w217N55pmmaHIR6OJ3CJRcAeNVeUxjl5SDbUoiul6E6s4ZNgdRGnqN5KzQIy1reHong65Jh99Y8Q7viLqv1oBlPU+Gc28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 19:47, Damien Le Moal wrote:=0A=
> To avoid potential compilation problems, replaced the badly written=0A=
> MB_TO_SECTS macro (missing parenthesis around the argument use) with=0A=
> the inline function mb_to_sects(). And while at it, use DIV_ROUND_UP()=0A=
> to calculate the total number of zones of a zoned device, simplifying=0A=
> the code.=0A=
>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
