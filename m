Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4D5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 00:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E2619D9
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 00:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhCaAJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:09:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61695 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhCaAJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 20:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617149351; x=1648685351;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qcSKGgadveojBlR+WJQK45B/8k0yvx0OSY6u0Yzv/Ew=;
  b=kJe3UBpC31sGvcRGkL73W8hfFkF95rftnnU0rKvPY2yL6HEZfRvYLjQ0
   Ab8GYhyTElAil/TE7IJ5gLI1xDzhga4RNsEl6dVBChvfa8tARKO3HdEqc
   mENYnBncnZ42WiUuO7+9xw9JCDFMVbh6/QEgwcw7llnVv7zwNUGU/EB32
   4Yh5RqVQwWiMuPXsqIjwICoudpqfYJQX09MdGg9PTm0G75vJ+tof5crWq
   2jp3BNXnPkYwB8VccdQQ1iO5/qSm889yHFX+GZBHl24llVvz/tayzDgnA
   yJiRqVE7PhAX3o8kXQKDOqOtGAsCawJvhC7MXDuKXtU3lcAtg3Ff+vcSX
   w==;
IronPort-SDR: M4tUnEOVI46K7kbb+Lu0YrnXOtAbZeowrbJh1I4hiyeaEl+xcaOQBLHPjMQfsR2T+JeSHBN/Vg
 PNqNcStQJozWXmI/stPYYsSAdUtPMMoQVWy8Vpslq85O2WawR7GBlWYuIMZ6WFrvMvT8yN91bC
 w54RtRrNRSfkG1GedGqVWvBlRiycezkdxVCwf8lMgUOrygAgrCD4MK2J/lqSChZDMuhcVVUmVA
 UPJ7H9pgTyG92ckyLqn4QVQFuSS3fZiWIl7rw2NGBCuGz2xe/e4tllLEHSYgsxUmi8yZUcr/kp
 om8=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="274204247"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 08:09:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Daq5SvD3SPCupreKlWR78AqmOSIldBPIRwL4dQKcIsNsJqGJIrDjY4YTD0H1jStyJu65BNLcwJ9nSdO4GdG3Nvwi7YCaauCNvOtgvZmNIsMmP9SBrAWk2Yfvuke27WWvD4gS4VERdV4HPO5zZDiicVu/Y03G4NrTBK0XmtixXXKc1JAzHnN/7x0KfkkNP0PFRuBO578gF1m89eluCzeTQEDDarGexGwBX3fAm/+YGoglyqfkxBgjPFC6ZHpAyMrQQo8FRu/pkHJEpVDciEOGTMFVFLU7RB0UPTCJcHUfmpmFSZrB6qTXuVd/LR8SOFMSl2aebJlg4DLhlBnf3DnHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP+f083rvFubl4BxuhOkCVw9e0siol1Sc6WNw2YOJvY=;
 b=EIsfSiNyo1UpdNtqsPBBf5XDJrKvYYun06a6eyL5dmMmKJEJeLQHYym8HPiuXuC49XuQu09fVwQ2E8jlFqZz8l7TRo06l6tc3YkkLui2rerOdl3pwMkZZ2fBQ1eFuJrT9iAvul9eL9bXnNApUtfJEqzxuxOHhXaKPVcEhqbny2/tjyTvvlHXjCGY4dJjRPe1wRmQcBxvwn8lkexDOAz973ONr3+51jsImar6dCe5Rfv61pZ4oHuMjSEzcdOKWHXYCUbzuPATAgTrpE8+t2RBU/W5kVHBbjN7JqDzgXGqO2n0o4unVyxqEu44Rt1+fxrB4xMeZAWVdyMi5Izzq+10wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP+f083rvFubl4BxuhOkCVw9e0siol1Sc6WNw2YOJvY=;
 b=U+0xDAV2fMgZKNcofG1D9imu9nLf0vPeMUPUa/97rZPJqD0mdCp9kyegoWUjZkO4oFuaRYsKHcfpExbDyurE8+G9NjdCHlyDSaoCn7zkLNzJTXQwkQSfXxmD91tOPCRAC5JAS75Ne5keEfZ/7U9Is29gZ0l7KwYza1bMZxrNQmg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 31 Mar
 2021 00:09:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 00:09:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 24/24] block/rnbd: Use strscpy instead of
 strlcpy
Thread-Topic: [PATCHv2 for-next 24/24] block/rnbd: Use strscpy instead of
 strlcpy
Thread-Index: AQHXJTgNxFN9/7J83EKB+m2s3nrzKw==
Date:   Wed, 31 Mar 2021 00:09:06 +0000
Message-ID: <BYAPR04MB49652183D5CDB39A809E76ED867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-25-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8240607a-cdf8-4065-a9a5-08d8f3d9334b
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB3959D8CA223134F73C0B1709867C9@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xOhKNpAD2U6QTh77b6le3Rk/MVGEUdEvl2xSbuO+/tVcaupRdantTKMkvKw97UY0vLhIJ+MfeSRW3OeSuQ9Di6yjgrCJOPj9/7TG4qTYiw3EKwrhyaAJIrpVbhl3njOUdEeP2Avo+ynr72FlHyA2YE7Dc+VmMyB9SqVXuAxpCGFcC4WhoEDdXNJ0UjiiNkjZE8SK8pgwtIrBlsqgG0bxS6FUldTFe+xUBPNRAJtT6K+N+IGBF2xY17qmGLQMCiISrBzxU5u5yRYcKR/1UqoKUswYC+YqzEA3zhxZLG17GVOVGkIImb9GYYmTXPOOaaDkvTb/4wTqz7nZgZWU9hYtY0vhH9EhZ8iRmYycZPm54eerrtFQqELwHoitiCmueuB2o9+XR826PqNY0M1yD3xVURLrSISerg4D5enL/pYImHNHla8YFqPT/5h8hEAO9EHDgWO8Y0RkCYOL76+oS/0N9INH1onRlKdraSx1bgFaWuGi3GJQGLTKvkKND2mpb42m7zRiYqsGvZNyvlp02ZkICFSA4AZSM9gL/QfyyNw6jAKFDdtBH/8T8D2UZ9OkWiLq5n0z/Lmw3gu05TIBJ5vysfavFsEegreeJbUu2FMtglbPTYNXx5DmzjY6ROYu26QiiKzMR/YxEdTV2IwefFFs/utOdtebRAVKNDalykBhqA/Umfehlp6ixab5IUK8nUCR4OrMC11bQbepVIQqf3gXEeuwh5UcOUB8ruc4AOGy9HhvRUs0PGHykizHROE1ifPhY7A8tj85PaTB7dKnf2HGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(26005)(316002)(186003)(9686003)(5660300002)(478600001)(8676002)(966005)(86362001)(8936002)(2906002)(4744005)(6506007)(66946007)(7696005)(91956017)(76116006)(66476007)(66446008)(64756008)(53546011)(66556008)(38100700001)(110136005)(71200400001)(33656002)(52536014)(55016002)(83380400001)(54906003)(4326008)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/fYxv3jKhE9zlRKmlvNFfc7NnFqhbM4mkmqzKlB/4ZNkp2l/bktzgeJ+Tb+N?=
 =?us-ascii?Q?92y8JKL1DiucNzI6OXE53ZqQtJ3n6FYEzfUlkPlElbzcFrMNmHcyEA/35ELH?=
 =?us-ascii?Q?s1UCWXjKaaToyz3i4jNjxoc+ZzPBKfoDHamYK3geZWmRXk8mLXLLXWTz6rm0?=
 =?us-ascii?Q?JLDIrCpa/aBoak6+OTenES7mVY9YLgUrBhz6JbTpJoEst2ON6rgGWcG2mAdB?=
 =?us-ascii?Q?YE0wgGBhwEo0U+bb7LvUCI+0H9BDFio4dzaoPPKTpx4Q5Dc4x/BHLUXEnBgs?=
 =?us-ascii?Q?E5lrzeK9OZqh7Mq/4y3VW0vjMH+5xzz1stXN+v98HXo/IVsx4d8BjGyeKCsm?=
 =?us-ascii?Q?PRnpe1dc8EqgxrQsjzUamDGJtgyJgPJbUGC58I0oTzJrSX6ntTVHgeY6KqnH?=
 =?us-ascii?Q?KdTWRxAIsSJSo2PNNheFn5GofVSRbx1O0g5S01uDANgiKSJ4YbrcJd0xV0Em?=
 =?us-ascii?Q?Ay8OXcjpatf8YplDqd12NckzVU6AAJUSSaD7mg94bn/HoP3/2hSpo8K/sHax?=
 =?us-ascii?Q?MNFfyKBAy7pX5yhuR1TyQ95tc2JBjGkrqtX/s6LjdRg29Ax/OREnz6/sjcPf?=
 =?us-ascii?Q?FRiWfAOitJg699BmTx6kAdQyJBI0nanO2chh4fPYRuY8eGfT4xmYCwJwUh0v?=
 =?us-ascii?Q?E/+IVG2h9fqrY+LYNOiUpzgB5pkgGhVVR1EpE8yzmPLteyKDKK4aaxBrci6C?=
 =?us-ascii?Q?j7HascMXco3tUe4uhJ6USq1rIDajYRarNWR+7lnhUgkfPeJlWWSr2PbPVEkh?=
 =?us-ascii?Q?9KrI42ObSacR63pamegQMO4ZvXKshsA+edXC4yJCQCRtAEdOPq0s6giPfrk9?=
 =?us-ascii?Q?Bctl0/in4vBTNMMU3C+TMyD2NzgUqiKFyqKLhaRGaieJFYDE6GMkracddm0a?=
 =?us-ascii?Q?+CLV4AJdi1Bq4ghgRrKhFc1JTRdAh9EQCxVq3c844U3AB3TGz4vwF77RHtpt?=
 =?us-ascii?Q?vLEHLStEv0/99dtjA43vXprWtJtgF/KZDLHrGkpZgw2r7aNFsyxGiokIKoAd?=
 =?us-ascii?Q?0HNC3Dv6hONreVZYkUSYFuOfzbpQvs/BdKQLwTb462MqkVG+Tk0vX0HS9muA?=
 =?us-ascii?Q?6XcSAmOgWynfBSGBdNyVT0yoQKYSics5uogbWG2zmFrEDl5E+5VdhPGTJXvI?=
 =?us-ascii?Q?faQVhW5gbmqHhw2Khx18JGoMoQKRqbh4cHr2eYTSFRutyOX0OLrFYpnpzsuh?=
 =?us-ascii?Q?S/bgfgL8ynjQvoXA+7Ul4gcFZXL6Rz8x6Tez1tc1Ldm43PW9QSNh1GUbcjg8?=
 =?us-ascii?Q?J7kp0BIU6gZ7oRmxkutK/rRUNMMv3/fByrigRmmyDOq5SH0ECyHrXT+PCXyR?=
 =?us-ascii?Q?wsfT/gXyf1BhlnpyNETOjbP9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8240607a-cdf8-4065-a9a5-08d8f3d9334b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 00:09:06.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQ++XIgi+c02JSUpA8x/2qNwTkvCHrDrcFQGXq9UmL55Ufzkyy3tJYDuhHdVng1pe1lBB7/p3+18aWUaUg2HrXhUYg3v93WvzTRRE6crm+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:41, Gioh Kim wrote:=0A=
> From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>=0A=
>=0A=
> During checkpatch analyzing the following warning message was found:=0A=
>   WARNING:STRLCPY: Prefer strscpy over strlcpy - see:=0A=
>   https://lore.kernel.org/r/CAHk-=3DwgfRnXz0W3D37d01q3JFkr_i_uTL=3DV6A6G1=
oUZcprmknw@mail.gmail.com/=0A=
> Fix it by using strscpy calls instead of strlcpy.=0A=
>=0A=
> Signed-off-by: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
