Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E39C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D7F619D2
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhC3Xzv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:55:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29539 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhC3Xz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617148528; x=1648684528;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SQrPxFfF/dmV3PxFaX2PkrVxjeQ0Ji+Jf6XA+fNTSIQ=;
  b=ONUHt1Vp9UkFMdtzqk6KodyIBvE8/mTRk/M5DH6uM80EzJ+TCCtB2rM4
   0LX15YhuaqaFMPO1PsL1HumoC9z0ofjevhxc0S8+YR2GKmnkOpThaM8mp
   b3Atu+CUjT/Ifzb3/SzsdW0PwneVDtrQyred4NmtW/JSK00NN82XlQ9Dm
   ef42pep7+Kt1UcuYSirhI1ra66bNdvRJp1YUj0siDadMjtcyj+hLcf9qi
   JUeUep5WD4LlhFOdY0fWliZ9NS1E5JIkhCEuXRAtsCVPv8jI9HK19ZHbK
   KB7YonTO3xlAEqT0edisl9Bqybh85RuSff0v4Ce835984um+SMhA6dbEn
   g==;
IronPort-SDR: PxPb5+xAs9Q3G6e4fiBIDiK23FCNcRNpdSv3Tojj6PPw+aB3/+zwA12KDUrxsRXr/f69KLaHAF
 nv0fNdYdYFGCcO3RiD2Wehs8BHVydUqnBWWSaNiAiWuYcGcOFpIFWdDRgnq2Uj9WpKa/h3tvUj
 Yc5Wf9zXPQj9yn9sWhWsTVVKJ1pwhaK47cqah8oSQdDT8g+wfdBBoQP1MEhTEmfOhazgm9AXSW
 tLHxjELYrjUpqzenmf/vHgPKQEl/Mv8gVXrm3TLBaom4a1FmHDpRrv1UBfGR+JTiC2mjw+tscn
 TTI=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="167868789"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:55:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJR3N44ViNngnYJraAj7iIQSK9kqJtPc6HTnFvLRENhvzI7hXnieI6h9F/I2WO+eYbri7ye5wyWT5MLbEn3HuOQKxBB9Od7u//Fy3/0I8X9lKIdT5sY+Ta+ghepIe+BVs1RvpyzaSj2dJ322XN2ximzYKvOVKYoevLadshtv61+QsjFIMIUpB3AF37te+AniIYtHKgPZKbqJ6M1NM6Yr1znOqIbcRjdBZayYWxgTTh1AJMVznQu3JAsjSCJqqK8mKK4FyU8al3BCKnFakcZqmRBtlLFk0Hqk7zA+bvFu4b3Ht416CG6BsiTHkawSOc01CU4AlZAjTRmHeoYLfGislQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQrPxFfF/dmV3PxFaX2PkrVxjeQ0Ji+Jf6XA+fNTSIQ=;
 b=iJbKq0lU8PuTDm3DaVI3CE+gC3kkq3UTsWQcI/+O/sEczfZ7C4Hjq0I2AZFJ7puTH6Cd06r53Cjl7lVn8QHc9Lq11tAWh18NGH2zi3t8O8jZC2+EZfps68XU126G7gLzJMb1XJDxi37HWEe+Snl33KvaUJWaFy1cDbhDYiVmPRziJR2B5138SSQMtTFQ0nbEMSykqMuRDAR6beoj6K5+dO1HF9XfFS3+h2tfODr2oInE2EwIKggGTJkYYiYvVfbMGyUeBWJV0gWvZ/m4YgESQWbnXGtcp0rFz+Qc+iEN9aVsyVa5z2lZb6YSdL5XU7T3eH0XNnybtUxMd73ouIIRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQrPxFfF/dmV3PxFaX2PkrVxjeQ0Ji+Jf6XA+fNTSIQ=;
 b=hql1kflds7NpdsKOiR9dyUdOhINuBQuDviZVLtPqgl3tcaM/Ok0BlVaZvxw5TMnkPTT4zUicAES7nHB/FTnsr0oVs5Bx4Aga3BTuVYFOVRhA1ZXdG6QlJO+/MjIOiB/3YCgf8JSit50k2qPoOrAbnK+z13k3lEnEhXNecPw68VA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6424.namprd04.prod.outlook.com (2603:10b6:a03:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 23:55:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:55:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 10/24] block/rnbd-clt: Move add_disk(dev->gd)
 to rnbd_clt_setup_gen_disk
Thread-Topic: [PATCHv2 for-next 10/24] block/rnbd-clt: Move add_disk(dev->gd)
 to rnbd_clt_setup_gen_disk
Thread-Index: AQHXJTfN6y3wO3bgzkCWw2sdOB9qqw==
Date:   Tue, 30 Mar 2021 23:55:25 +0000
Message-ID: <BYAPR04MB4965E5103C577E2C2D2C5A8C867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-11-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7f4e095-8a13-4cb6-1470-08d8f3d749ae
x-ms-traffictypediagnostic: BY5PR04MB6424:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB6424831A92968D8E72A8C7D0867D9@BY5PR04MB6424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bh4gVMsC1YoUvNHM6KlBw/97j89mIwZsYqP6gXhJPVWQ88CSUYGVHBcqvQqz0JgCyAs4rfR1Bp01phWE8kI8wP7nokLP07tlREr+BUDt+/N/tvsXw1j9pOwxfik93cOCYDKSKU8lpcyoeQS76rdlno27pM1CWxw6ZXnAaPqA1VegR/usj2hOIpMV0KCC+KNOmfv5SCkekdTXhnLo3yaUWYwc3ATHPopwI1p0QoOZxBVFIs+8an+sGkgxgYnfoHmdlTtIXWp1j13O+O6ahnYOOahmjkU/3xJmA5BW7mW1xcDH0iQFa3AKEdr7tKQRbonRaD1JfaetilJ1jv0J0D5xS45oY2haVSnTRQowwyxyz7PRtGYQxE6K7fyr/Q04tiYMd71ukQ8sm+q0ePinLiJheTSmq+w4YVrd8MLPYiVK61/JlH3Y+sX6eE9FPE3KASBrMbuFObU8QERGBeI7DAgjKsliqciYhVJnzj13myrdQ9E7S0hrYjpB2FSp3u0iHCyjmyiGg48YwRMBStloDr82hnRvW1BnPupIZ5cTppvEdFUwxhnVY94lolS6ZfQphKOQDj9+FbX779JjUrF+ZE8eDhf1hR6xAasHzRo7cDZmPETI1PG9jae4OLoHjkNmuqnQ33Q6wxGA398BDnZTFeo1N7XUFbQxxjWkhvNiVyf+1Bg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(478600001)(2906002)(5660300002)(110136005)(7696005)(38100700001)(7416002)(66446008)(4744005)(6506007)(71200400001)(186003)(83380400001)(9686003)(8936002)(54906003)(55016002)(76116006)(66556008)(33656002)(26005)(66476007)(64756008)(8676002)(316002)(86362001)(66946007)(4326008)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1puGkZelEmEsGvT/I02gQgw4vZi5f7v0p7czqTrGFer64k5VXjpU4q2gG+eb?=
 =?us-ascii?Q?rBC6WKsK6wCFBiNyqWMMu8Uc9fLTItO4KD/ECbeHJQy6h5Nb4WSQwOD4jFEq?=
 =?us-ascii?Q?h4fbRbWR+8QRmpLWoBbHQ2UxpJZFSlQYpjalnEyFp/me4T2m/NpQ/z5qI2Qw?=
 =?us-ascii?Q?9r0QkAffAUOrsQTmAnTyAha1z1hFFIQS8LAb6t6HZEJ3faeHcsl4P1SFk+dD?=
 =?us-ascii?Q?xcCvJ9PboxFO26C+v9Pb75Cv31V34lV2MNm/KDkP+bDk+L6GbbBGp267ts25?=
 =?us-ascii?Q?5N/wxf5/D5n9y4fO/1WYMaozGBGClR4TowoApqcEX4UYe5KDfn9yCKfzme6j?=
 =?us-ascii?Q?CAocQ2VBUEpiBhLaCn1O7pLsMEzmbmKWq/ln/X+BxBDcadb2ZGV4ItHkkOod?=
 =?us-ascii?Q?cHbjXSYImlz8NhGtXS7I9O0F6qjtbSwDRgX04ameoxHGw3yVuMfhlFJnKEqc?=
 =?us-ascii?Q?7IjBlYOYdYFopYXwwkTaDAspD293CuCtnbMbjX48VQbLeDg4GAhXHLMm/sEA?=
 =?us-ascii?Q?eUX9TB9ZGR9HN7QIBupY0FnEtnMnitPFNR/HHdt2tuFnyzQHGBNjktINVBTN?=
 =?us-ascii?Q?UnDkPjRwc9gjFwmuV2wnL7DbA4MjEEJUHVUbtWTsXOd7/Re0b+WKwpkyYOmg?=
 =?us-ascii?Q?VfBM/lwxQvOgJf+SOJ1QVSRIipryywhGd9hHvTqst/oV6ToHs9n0mHlBOZE6?=
 =?us-ascii?Q?8/nZUIQk3FT3iC4drTseJWu3lZQDF9CWV7SbReOWEA8edIIVCjL905DTJ1uK?=
 =?us-ascii?Q?yVolS7U4ztIJP744qwyh8e6NF39Igr3aRvpuskUqyFzfPdYEYabb6QfVDtBz?=
 =?us-ascii?Q?tyjpbOLcOB9aWy1Tl071Tj68Do+Abe3kgs2I57OCcqjTv6b0Zs+ZENgGrnBA?=
 =?us-ascii?Q?oLriVDovhDItOIFX8WeR0el18Wnj0ohBUcfGLzh04R96kxfYqQSVN4/dIoVB?=
 =?us-ascii?Q?ACDDajaIX9dn10o7HKu9K8Qvlnudphue2fJjuk1Qcl2rlhhyznnA132L4AtO?=
 =?us-ascii?Q?dbC3U+Wze75etano4VfaU6Jail/k4iptqhTRcDRzSBxL8y7t2JbsxnhlDJ++?=
 =?us-ascii?Q?bLYh87913xPUcq9R51GRDE2lLKyzP6XIaPfFRWIaXheNN9YY+1SOuCVFEMXo?=
 =?us-ascii?Q?8aB0EwXuxOjwwmgYfvtOiZlj5BO23xGaZYJzXEhUX6vmGb/Xvy1ibA2ATBSo?=
 =?us-ascii?Q?8xQ7TNWfCvotLYnXtx1xBWKyMZLj/ogGsrgcb3R7tff3N/p4vo2o/inH2n1+?=
 =?us-ascii?Q?qAhgUF8JdxWrbNJEqaNPcQaKWEl/NofKkr0ZOtDh1VoKRY/NJNk9V0B8vQ4f?=
 =?us-ascii?Q?VTYzVURAsjAQXiKpVi8cug3M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4e095-8a13-4cb6-1470-08d8f3d749ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:55:25.1439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78Yal70SIr039NbWcRqu0oB1dcEPH+lOUs9tmjALotlI7fxRlZ6p2teoyi3YDJTWbFQlOJ8Pvx5TTXO7Eq+DaC5s70Qb60DfGRjcJJry/vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6424
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:39, Gioh Kim wrote:=0A=
> From: Guoqing Jiang <guoqing.jiang@gmx.com>=0A=
>=0A=
> It makes more sense to add gendisk in rnbd_clt_setup_gen_disk, instead=0A=
> of do it in rnbd_clt_map_device.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>=0A=
> Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>=0A=
=0A=
The add disk call seems to be out of the lock, I hope that will not=0A=
result in any issues since this patch moves add_disk call when=0A=
dev->lock is held.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
