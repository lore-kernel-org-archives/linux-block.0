Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D9C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 04:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F074861278
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 04:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhDMEXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 00:23:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36881 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhDMEXa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 00:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618287791; x=1649823791;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=r9q4+PzLV6R4vUCFEzJOFzAavaml+TEci9vDAeUvVf8=;
  b=RXdfP6U430qK6odNTun92WzWT7G7hXmf+9QM/uZZw6c5IzuYNfQwYICJ
   uTdCbDUnbQ7uASB0An9298UxVZkOOunUT+VuVubBZMy4eonxqZTfdjYDL
   0em4vc4a/imHT5sF41ZiJzlNjsW/Z2xmnr1gliSa7TjKrxqElYp/719RG
   5f8Gly00c4rra6em28oI/f3Phu9WevwUptejLjSqzntcG9QFz0E4L3SzD
   rskjEaWD77zS/CVSI6nP+gOUaepCsaKoXWYFEWM3Svmg1YjTDaXfsVXrT
   NWSGLCxRFt9algBIyE1Myu0AABhq0BiAz2Smg++5Jt4ciuy6EozctOA2f
   w==;
IronPort-SDR: 14p4z1R7RP5791sZ5+crm3CHNbcEtoxhmbpYPzURCC1Pl3LLQCOc/1nuYinsX80szgDH8sjypW
 MVAD+EnmCTcSEunwpoxmpQKtj7LO1lnvGSdQm0F1NgMBI8yIBlOREycPHsZPs6M9YsndY6T4qr
 x2cvvKZ8ymNICVx0o00DC93vvxDGAKk1NpShWH2ylathOgupwnUHd46YlBE3WIR6ReReRYU70Z
 aMuDfKAPOKTLiC71sJjY2MplBrUdQePRtzTh37nlOvmO/cl1/BnldYtPx+CShaUBgv06K+nLG0
 /Dc=
X-IronPort-AV: E=Sophos;i="5.82,218,1613404800"; 
   d="scan'208";a="169081749"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2021 12:23:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwLkCM2TR2i47mj3BRATFdqePNAHMCCimJ2wdsbBpAOhNVIzglhm77sL+z6c0//qe2knxVntrQd6r0GYf7KWiBBfx8ZPD8P619fEx2olxnK8tVleUSz++MI+UNs8pXVt5KWwz3l35mSC2bQx+ELBF1VCacsbow7VaGYoTLXc7Eo30Bd8yIqAT70cI6bJ4VF50Ojb1uK7LYiJU6KBSkSiun+mN9hC4OZrpLW1OedMVroJzEOD0kdY7apa8B0jfONZP2aQjuM4/Zgm+/BJf9btRNUI92Md28Wn5Ja4/x+S/NX2Nn5BXRpRHwEb26c0/MoUZUYO/Si75C2pv7gxwWRPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9q4+PzLV6R4vUCFEzJOFzAavaml+TEci9vDAeUvVf8=;
 b=CqbrAToHjFQvc479ffPk7T4H75mx+jw4dwIoMBDqap8QFjgW8cgoVuRXRGy4RqTLjadJdvfAbIIXB2AjGcsAs5KCI8Y37hB9rAK/7d/A93hqgHEckUufooz1zjbNslIfJUvBNUHQsvr1bvnVUQCNzs/S3+GX0w3ZdVhE+nSrKUs3XiKPEK8IIWXe2IXxNWARJGiqxhCoZ8ERcHYaqStd1kq5t1FBOEexab5ikaJYsDwoAtyPexqSUZreRSQU49rN17fmxqsg7cWDPDEY3EDl0ogAnTi10Va5au3TEbjI3IHyjeokAW9l9rXy2i4FNipx5S9VhuHIPm4vqzft6nC9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9q4+PzLV6R4vUCFEzJOFzAavaml+TEci9vDAeUvVf8=;
 b=Kzzemh6LF6xxg7zFDlmtjzlRuV5Qm2Hnb8V7+NgoHIPGGLclpJ+XAXc0Fh1188ScjVzItG0Tny1dqfDyhfhyFyvxpXegBvgMJvY2DpNiTTWz3ZSwvMkozsF2p+EJVwfM2K1fv05i2pYe6ziboCyAnMEiF0eGO+1PFTOLa3JVvVc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5590.namprd04.prod.outlook.com (2603:10b6:a03:108::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 04:23:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 04:23:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] block: Remove an obsolete comment from sg_io()
Thread-Topic: [PATCH] block: Remove an obsolete comment from sg_io()
Thread-Index: AQHXMBdC3iDmh6y3F0aBKy1mJoDt5w==
Date:   Tue, 13 Apr 2021 04:23:08 +0000
Message-ID: <BYAPR04MB4965454C7C6FA9BDB1000485864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210413034142.23460-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3146bf3-f27e-4b36-61c6-08d8fe33d7ca
x-ms-traffictypediagnostic: BYAPR04MB5590:
x-microsoft-antispam-prvs: <BYAPR04MB5590A46D1C889B3FBE25EF4C864F9@BYAPR04MB5590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Nw9ZIAXQ516EwPpfYdM6kyrmRpW65k8XSan6OljRDhq2DgzUAUAnEZnW0f65EFOSIsWXNP53IqN1wnD+HdTCL/2jk5E8MABMJRLA86FnBfTzbvpRaD+ILofJ7FwecI/vKFgRz7Q4sS1uISMo1kRfq7HAKiquzZTwJtXTykLz2ioRPCHK+G7xa60g6+IS5BdYcmCOM2gWhddy7UJ7Vu00FRVnb5+flE267yRSRtVp9i3vk+Gkgvd25B0OtcusLZl6NLHFoORXx7iuOZjcr7yHen/pXJNHZcE5ITY6wEhV186MyoidSwBMhsjyz9u1+zWN1mIgDw/CZ4Cx7BeraiTQ6j0qHgK57jS30eOJ5gMwa8N87Wbw3jVHMO98JrUj8U9Ivx1IIueD+QWVpS/4MytQePcgHJzJeZ7znU6SavoI2c+X5OZFsIbmHltK+AKc6UsGO50qz5+NzC8CPQFozE80Cmh7Ob8F16f8jfyMK9X3FzcuMWCW4NtL9EPfNtY2kYwUiSlzAiMREQMM+IP//2+wXFjSrttvlaFq1BjOmbZdzNPUgDDfXo3/rMsxFY1yAc7gjjcnxiNBQnX7FsmXum0vniFoiO608KbdPCGtF8pf8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(83380400001)(38100700002)(6506007)(8676002)(66446008)(66946007)(122000001)(2906002)(33656002)(64756008)(9686003)(55016002)(66556008)(66476007)(26005)(186003)(86362001)(8936002)(53546011)(71200400001)(76116006)(54906003)(4744005)(110136005)(4326008)(478600001)(316002)(52536014)(5660300002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?roKpGaOfurCkdj1zIVe37cBsjr9z0L/Lfq7TfEih9ZFkB5EZg00wSuHrYY0F?=
 =?us-ascii?Q?ZU7m3PRvLjbTH+LLQB72AVsEH0qneMZfskkQNu4Zt1OAfdyDVCJc9hKFcQG4?=
 =?us-ascii?Q?vyapoNFYU1Cz8wgq394MrQ4iU8iI0+1b5Dsu9o2a/3UrTPJtMOkIYfty5Y79?=
 =?us-ascii?Q?xQcSfMxbr1BxHjcf46RszC229hu90WqB6PiUdEUn9frkHq3VUNKtleCNkfdD?=
 =?us-ascii?Q?cWW1DJ3sbd8ISHWPZanyoeofEcNYhjZJZDHMDT+W3Cf1RYih2snwrKw50t0M?=
 =?us-ascii?Q?tdLxXTOgnbedXUwbK9ZANByTwrAfG9E47yY/B6ZNcfnkkthZQK7uEV65G4uy?=
 =?us-ascii?Q?N44I6d4g1nSzD95NMWh5pOs/qQQqHmqSSzgyNwVEl5SQwi9mxLw3DKdR+Lcg?=
 =?us-ascii?Q?PIpcsCDyU/teO0KXMtYajG1+qcrLnOQWHxHPII20NjWb/cJdkjEDIjT5S5gj?=
 =?us-ascii?Q?rdv/1scAop50HuzUmXPD7s+WXHGId00xzB6CymBfpytx5WUU88nJs9++TTDZ?=
 =?us-ascii?Q?2G/a9WdcVhUktQw9zL3aMYZLffHGVne1Vys46BBeQ1RxAA6Az0P46R6gF5Ti?=
 =?us-ascii?Q?Xh3xPDu7mNjauGms7iHYCmFYbEtnLL+PWEejAvRusqi4dXcsiudJi1W2kJ9+?=
 =?us-ascii?Q?TB+A5EiTqkN8H6fpCh6oQ7Su+BHrtYLR+0z/m5JJarVWOpVHegrMmJyrNncv?=
 =?us-ascii?Q?padxMa+8rHDnk9Ridpk4rcOjmqCNdfSC70J7pYtjmFznKsDn6uNxyTCDa5Cm?=
 =?us-ascii?Q?axCE+m29/F436d4tqoB16gPXT+zXPUllHKVLuV+9u/Uz6xhW5GVF6Bbzdwrb?=
 =?us-ascii?Q?XZEtSUSEnIuff7p+0O4mIGj8pG18YwVBvYq4MUvtGswqi8W/TR1S6iBuqM7w?=
 =?us-ascii?Q?fnrZnDoX9enDusRbDa2+EFWFeNi0HaaU1gRH2wbHYmMSNJGrEjpldeviuCK0?=
 =?us-ascii?Q?x299CSvd8rYcVTMzvu7WATUJwtVLPjXPjbvkD5FBUVAlYsZvhr1ip/yc1TOS?=
 =?us-ascii?Q?J1N1Amukmy3cuMsawCNrnfsGe+ZrZVmfmxbGee61CG3B8zM1qhK+cFZ7HLuw?=
 =?us-ascii?Q?onndweR+e5rSUVlumhGNvNl4/aEPpE67rJZXQfEhg1U+wlXwzli/+PZrgoLG?=
 =?us-ascii?Q?HhGvbUKWHxxV3lSS/gVoGUvlDoGLTtcLLu0av5P+pCViNcrS3VUgSUIWN81n?=
 =?us-ascii?Q?RcuHhaU+iL/NEsw3haYFYwXwkIEHsGw+RYrnrWGQ/5vtKN4HGeelOacbuF0O?=
 =?us-ascii?Q?lellQI665QbT619XSgUfaI6a/yhx5/vAXtuXMy8/vdI4KiO5LwlyjQ9pUc8/?=
 =?us-ascii?Q?mYmKymtj6upYUDyfIa7+HX16?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3146bf3-f27e-4b36-61c6-08d8fe33d7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 04:23:08.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ud5sz3GMjAWTa/keo3mmYaCksW7WjRKARNxjROEhKBX7rm8Ockr48dEaAxMaKw778ctx5P2ttzUQaaoxiHcDJUKyHqn0uTa7xf00eR1H3cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5590
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 20:44, Bart Van Assche wrote:=0A=
> Commit b7819b925918 ("block: remove the blk_execute_rq return value")=0A=
> changed the return type of blk_execute_rq() from int into void. That=0A=
> change made a comment in sg_io() obsolete. Hence remove that comment.=0A=
>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Johannes Thumshirn <jthumshirn@suse.de>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
