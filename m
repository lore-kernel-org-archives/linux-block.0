Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C41C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AC3613A9
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhD1S2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:28:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65378 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbhD1S1y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 14:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619634429; x=1651170429;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k7VHid9qi92u/irhiot3BNVUnVcaC1Ehb6Vynwtnf0o=;
  b=qpY5DO17dBkmofH6kYHfeu4q1NjzAPw/7qc5jN8nN+cddZ4aBeyZiCVa
   BhAIeqVAK+ethm7lCJ3jxoGTGMgOinDthJocv+dv9H10Rd2GdcClC08ei
   ICRnaMzgdglIayBJtyD1RRzzFfJG8WtVnxo9UoDZfcWj318rR7oVhAAMB
   MdEf17Yt0YnZOnQ3SscHhdHJ3E8jsQ8PfdxMp6hB+JOGlALSZ5Wk0ENq7
   zCGIT3ovRHqQknZ+GVlVLcLsS0hCwylHPUjhDLBnPn/NVEld51NAWAXYo
   iFJR3QBRJD68ZG1J90/zsqTtkDVgR1dtjXTdmk7vfmZnhocXnSxDLX6ff
   A==;
IronPort-SDR: zOX16sr5SvMoqznDbbQLqsR3pWfw3UMvDiZ7ne62+R5Qjb3mywqx0ODCJGTtRV4KBC1I4c7pP/
 VuRj42EDXRgJRR/4586lcUHxFLaJx8UssLxs7zgl3puzrAxiWtwk6pJgPHFhsUKRKEuO7lmCoB
 NYQxXYkObFq2xwL4P7jcm8/6Hh6JGyeebpRaudTsZ9diiV0CmYMWAG3+3nkhGo6ZHSiJirHNu1
 GiV2S4+VSKH0i/DgANpGHwAdFttd2cfnQg9nG/utyFCoyM6HXoQUltSzeEMhqJevyfYkdOk/Nv
 QnA=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; 
   d="scan'208";a="166572754"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:27:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq9WDA3e3I3KHczF94OZO3doGWrp0yQfCB6rAqYaNh25Zvwrzh4vTUyZJ6O4oywxVJTkkikxgchT8OHSa4IWcdS04a7cDRig+QC7CxqWeSysmwpQVjLa8MRzDZ5Am9SzSNQ8onjpSHoims58X5XHilEJDRR+XvbBEOs7jvgQ9y2q0piWSHhAqGDn7H6x1httHO1hpepHPg9cNx0t2GANwJhaqD7CkokMHC8Gbf7LvSqGkLKxYPeVV1wZKg1xdkwSAZ6Dcmg8C8qtxoqsW4R96rQfZAwahgnJMAB/5b4HM8i1Zu/d2GjaUKGfT8Dul8v9GGYbZsrRMk7X0FSt1XuXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7VHid9qi92u/irhiot3BNVUnVcaC1Ehb6Vynwtnf0o=;
 b=BsHfmSHDVamRFJHEfCzxlZQ1B5FUu6iS7fYQAcugLBvC4/ScwmldXCR1/K1SKUn0Op/Qk/5YstLg7UUf8haxtNQFdRGSh476hjPdMJDDyGxE9Z4qFMutazCBDPE1qckWjT6JQpQcvq98vpjGD8O1YFL7uYhKDHkotipgTgaGfxpDy1MjDEvQx4F4d6coV0e1lL8bdJEFa+c94tje4lEJz5u+4Pnh3cjKIdNazhtPR+h6LjIqAvL/xbHpiQ3MXvYFxqCVtKA3WdQVneUxg5QNcnfz7Gaua3MUZHZhgOod+3GADIlPqPw/tlDna+xXPo4vtgqkOVn/OyQ4TpfXzHGBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7VHid9qi92u/irhiot3BNVUnVcaC1Ehb6Vynwtnf0o=;
 b=ECNIW0bQW0NA667LsNOJutd2R/nNTe1Ja/Wb/fRUnjd16ill/aVRurziFH7XB3GLGdfvxYBRjYOnpyPzuyN948D6Fe/uIPqXZ2N2gkZ5tCv4xPh6DjaO5EQp46fcHNK78Ax3afhbuUge74pRROarewhD3WTWzQxK6HBpcOZKrS4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6881.namprd04.prod.outlook.com (2603:10b6:a03:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 18:27:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:27:08 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>
Subject: Re: [PATCH for-next 1/4] block/rnbd-clt: Change queue_depth type in
 rnbd_clt_session to size_t
Thread-Topic: [PATCH for-next 1/4] block/rnbd-clt: Change queue_depth type in
 rnbd_clt_session to size_t
Thread-Index: AQHXO/XKdYfU7YRUWU2IE1k+Es49AA==
Date:   Wed, 28 Apr 2021 18:27:08 +0000
Message-ID: <BYAPR04MB4965E6E24681864C5A5E789A86409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
 <20210428061359.206794-2-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3f688cb-2b73-4ac9-c008-08d90a733b54
x-ms-traffictypediagnostic: BY5PR04MB6881:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB6881CE16EC473D0C50F9485886409@BY5PR04MB6881.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkSag4WHAM9d/Iiob8qcgFCJqlRpq6FCrEY4QvH9ef7Kd91HLuEbapwEiQksqFXXDmJZVW/5R90fy/H6rTeH/IAv3UPgaf/3aWJA+WLqE6JW5/d8BDkjDOC4qkdPsNcWSs81Ag4G/brpXS67DOJMjctU8lFWv5j/zwJHwYEhvKyCU7+coagpyVAAq4sRa3UmnwlyelWj1rS6Qz9FU2N3+6hsFJRRQbvDAxuIcWdSva+EQ1fCjdLFWs1U73v2ja6x9RwNMb4KKjj7dGmZH56If0bTBMGmj3EvQX6kpYWqSZPaTU+1XO9eiZLKu5p2/f45emp08Dchnd2hL+W02aWFEoERuJruuzeODZdLN0dYT2XVx/rZmSqcC3ZCMc+CusaHa7ql+1X1C0tQ4htoiOnAMQxzWJcPijjnwpOjSEZMI2Wit/BKuBiPehTk/JZVw2a2FTf7v6nvN1RvgphdlUbAidFa7DRBRCIQSfmgR44ohAY59enB0+GSShTAA1GlTrG2ob26GCIJ2gidHPRijCzQRS79Tnqvsfao8hkzlviBYj7ZCvSOIEhQod5nPDPij7S81qKi3iE7Oz83oEMmaqnqWT5bkORjyo0ax4qag0f/L+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(64756008)(7696005)(66946007)(6506007)(66556008)(86362001)(38100700002)(8676002)(7416002)(5660300002)(53546011)(66446008)(4326008)(76116006)(54906003)(52536014)(316002)(66476007)(83380400001)(110136005)(186003)(2906002)(71200400001)(33656002)(4744005)(8936002)(122000001)(26005)(55016002)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y9oBgG4ARmcYqQpwW0ojRKZRokGYbs9LpTZ9ZrgevYBTFD99DC1E0mI7JKlK?=
 =?us-ascii?Q?h+spkOPTWEXQfTs79HCzF7V09udG8YjNC6rLjazEwfzDraUbd8U/34VNn5pW?=
 =?us-ascii?Q?KqPK+C9YT5AssLqh4qK6mA9JfHqP4DHsMYIJhXzTX4Iy6V/8DEwYqJ6jrPnQ?=
 =?us-ascii?Q?h5tQxFynkAn3O1FnSA1JEbpYDA4wp/X1RnL0Qh8wc+n1QUw/RqHvZtEksVcx?=
 =?us-ascii?Q?yGi+hHgzBcnQnp1wqpBn1//07H/AVRVR2LzAwcU6VnUyc92H4Dq8KVv05E06?=
 =?us-ascii?Q?vmZKNhKhfsTTsxH/qwqd4obMU+ocBhjEQIpa9FVC0ffXuUVlEFjYxaeytZHa?=
 =?us-ascii?Q?NmYBZw9pgIWg8tWoeU8gl2wuRKzKX7Eu1W6gUybVKL8cFZ2U+tSXUCnQYvx0?=
 =?us-ascii?Q?OTvzsdYfw9MkNpmAZPdtlmNUOJSr7CrmqHXsq3eScAUbMvQuPa3oDsdbtiMl?=
 =?us-ascii?Q?K1chlTIkkGIXCukVdobFtH7Ay9FNWuTDqn0zusJUTTEyb/mseEb3uAc5gOHu?=
 =?us-ascii?Q?lEQmyA+7nEUgEYfEEQEfP3Qf+b+rlgnxvjtTbz9vcZkdDqn2Pn5Y40t7qB36?=
 =?us-ascii?Q?203y6vxDSAPE6ZTgg2jQC60uw7UMdJJ2NA7xaiJ9Vs7eBKTXRbLfyAvz8mzd?=
 =?us-ascii?Q?/zExGn9yN3gzOll3upBYrjbIxBFs0hM1aSjS6CzUDC/1znB64D6Jji8Orto6?=
 =?us-ascii?Q?jhb0C+Y08h7pr7AHGOXgcLvBF445C1CNRCINgG80pd/fMhhwWHBjKKUE5NdC?=
 =?us-ascii?Q?016hZdQ5cOTNma7mwfGmIPuzFvGtDhHp89d2MiLG7ylLzIANownMp4JV5OuV?=
 =?us-ascii?Q?/T+PbZc3rKF6pKszP9gISHD8McMfepO/cZjBQnR5pMRcI6IXAUN+ihZlyZkl?=
 =?us-ascii?Q?Ky+5SGR9BkP3Xc9G1ZFbYo2ETE063zQOxX7q6KnLFYHAjUqBHjIG3G84DL7Z?=
 =?us-ascii?Q?k7HlwzoHsZMe2d4JM+P6bk6UP61LPNCWZeGaJ26GfRCM9YTKNanCSaWJWqgt?=
 =?us-ascii?Q?JJVaNVpIICOVr5xdpTu4kvOLDrRuzgt6phm8kFXolBR1yf+/pRkyHNYhz1Cb?=
 =?us-ascii?Q?m8Yf1P/Ci8nw3Lula6na9hc94wKmuPCxtOXvmU/MulyH3kpfJsiI3aXtMfBg?=
 =?us-ascii?Q?jFbysjCDnnmUnGq/uN9qaUG1Gy522Svw4HgwReqLV3fwvTAhX6zrr+h2uqtj?=
 =?us-ascii?Q?iOY2KUxlMSmLHr8cyIMupYwSHPlKaw2D4LFzdVuMUAVa7o5fTZvEfkQLYbHD?=
 =?us-ascii?Q?tF4aehTQZskv1ynpS4SINntMB2dmADNVIunuw0MWIK7zINW8C/cvQEtX1lM1?=
 =?us-ascii?Q?VXToFJBasV607ZFxEdr/kkb7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f688cb-2b73-4ac9-c008-08d90a733b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:27:08.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewo2LVreW4iuJVa+MD5FpEfhawYPd0R61H6CO4/Db94iOTZ6FYXhF5LJCHOOOAjf7l6Uh/4RRtwAUu+A3kETs5jpyvBBXy8VMu92jcppZro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6881
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/21 23:14, Gioh Kim wrote:=0A=
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>=0A=
>=0A=
> The member queue_depth in the structure rnbd_clt_session is read from the=
=0A=
> rtrs client side using the function rtrs_clt_query, which in turn is read=
=0A=
> from the rtrs_clt structure. It should really be of type size_t.=0A=
>=0A=
> Fixes: 90426e89f54db ("block/rnbd: client: private header with client str=
ucts and functions")=0A=
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>=0A=
> Reviewed-by: Guoqing Jiang <guoqing.jiang@ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>=0A=
> ---=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
