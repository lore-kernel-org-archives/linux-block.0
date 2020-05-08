Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72628C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DB220A8B
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cn832cdn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hWRjbn9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEHKdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 06:33:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40245 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHKdN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 06:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588933992; x=1620469992;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yq1mYqqY233SOQMVk857s2dCqDrKox6ompIadaskkT0=;
  b=Cn832cdnu4amwq21wo+C7Rdggn0MRN/fpd6CbdRHmJjeqNCQIcDB5PGJ
   Xms8kuoxTaPxLp9MphooEErQM2CaymO44uTC3MJImWLRDOcVvErBqKjR0
   fiNUr4r5EuxNP1P5ESvEAwrFHLI3QdUQwJGLGDNPID5BfEpt29ZYIeQx1
   6+ze5w+AreJKEbu5LnKr0uell4Im+9QqOCWTFCNKhouRB4Pa5LDoVPfyy
   VNcaKcOgHhHKkFRWZZvhpR/C1g2u5YdyiOWZWEFbKqjBIKsQDuKgxqgGu
   j0EGF51T0hVejqIQ/KkiuS+0eNtO/wQ1YsPLMV3y3hrFbx21jX2GdMixa
   g==;
IronPort-SDR: XIpq2Fw0jprBdNM0vPOdoebtK25etUlwb/EHtFg+Gek4rtEhipEjLLPo0MOV1DhAOFXUR9kgmJ
 Sxl16M2CA6H6SIpVG+PnHg17JDxCXIZQk8hucrxKd35jzmsv3cB09ze6UTECzp0He/KSd588O0
 qOmFuWdkgYl+k5C6RO23rG1B46Kp+I3pEC+48yiubfCjVxZuKYIZ/6gABo+XM+EWT32L7Aonqz
 tLWm7hEqSOCk12ZuY04Z2AmaqPEoEDVVnMWH8B/a21Nn/nXSpon/tlKxUpGn3gY6Wmh/UFBIeL
 Z8Y=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="138649577"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 18:33:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpDNFCGH+EpV9zcAmIcUMKJmV48HclUWdjdKF0qxtV4TxUPQjZZ7Rfaqp5e8NZH+UWm0eAzIDO7KQMeknqowTi5q6UqXZ+DZWedWB6ZESmLbCeSNPcL9oA9nqrd9GALBuX0i9sFrz3yrY+1akSDSAPn6hfefB7Gjino6dilmOo53QW7vGgqs+u4egDRTxGnDt2Nc0q/ZOZDnFtPB5Xf9T5YdRS86WLNyq/y+f+tGXjCUA4+CGuw3YscVQlTDFVM/e+WgzlD2T0TKnBcZkTmTng8qBE6qGBgG+fz/SR8cwHHCQaiuJtuQL3/P9euy5JhjcC0khBE38wfImymisffk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbPwSLPzmqKtQ3Xmp5XdT3FlJRU8L24MKKydqB/frrE=;
 b=OZ/GiZckzz5/WCa8uUeLgmRt7VSNOL84takFSbMPdK3y4F4EgG7YnQHKW3tyEtn34vx1us69Dvpd8n+PQDXj4HWf0bngGxmSwUi4DSG0s93FvvH33sHg29Kdo8KxgSTp0pS2lCiTumiQE1/kPwyHMB/TGeQ1ssvxMOTLGiv0SRQdjKZnRqBi+1CUv0ZZvyI06pl9s/5Adoj1INMmwKNM0BhmuJBpZIKw0yns0AggpJn95g7ncNpH1mtC27GlGidWoDfKU2LQPpsECf8GTP6+ofmGDgbfA5fly0u6hsfzqJJ90db8yey7GHjqvt/J557WonbsbD7VMd4VdRLtszoxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbPwSLPzmqKtQ3Xmp5XdT3FlJRU8L24MKKydqB/frrE=;
 b=hWRjbn9LhNRlHkVPhhk2QRQr4Rudupk1xYV4lXIkQMQ7duAU4KxHNEqYS36nW2aCpVu74YAHVK/mXxc9fGH9GHaiMpKvECndXCXq0MMQyDWEF4agt0zwAADjMi6Y4xFP+SdCR5JLqc10vPknAo9cXUxKupVW/3nKQbsATSaLatw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3565.namprd04.prod.outlook.com
 (2603:10b6:803:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Fri, 8 May
 2020 10:33:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 10:33:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] block: drive-by cleanups for block cgroup
Thread-Topic: [PATCH v2 0/3] block: drive-by cleanups for block cgroup
Thread-Index: AQHWHwCa+7Yg+AL48UqGlFI7NvB/lQ==
Date:   Fri, 8 May 2020 10:33:09 +0000
Message-ID: <SN4PR0401MB35988824F2F4CAAAED6C8CEA9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [46.244.194.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3ed03eb-e649-4e09-120d-08d7f33b3427
x-ms-traffictypediagnostic: SN4PR0401MB3565:
x-microsoft-antispam-prvs: <SN4PR0401MB35653C52D4603BFA83FB028D9BA20@SN4PR0401MB3565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86MYNdBeoAeLadRB79uFcVgIoGCCvv/DGmN5S3t8vxHC2GMbPwJywHD7KIDZGg0MeD60Ljlf+L/1w/V1SUPy4ATgXZ85BtnJ4CEC6LAU9fvoSH5b/kHUaDyMR1Uoj9NDsH1IYO0Cz1vokjZM/oF4TzR/q3VuH5WgdHOnQdCynqEWjP2Y4iHyuPnUpbZJB2NgT3PsELbDR4h1CJA6pPB/8da/qtSJQw4K76xe61fE9e/9jMt3FM+yJea7Farnjlg1HMXcu28/y22QDsGWCOw/k1GRPThJsGa9KZMTWHambOgermdH/MZVBS/OF+cttcqP8P7u6KoRohz1LZTeFKSICRZ//5HeFePmAYHmqu8IHVSEr3CYA3y+frVeVvfJhxqWvUYz/ZVwTd4bFiNGXVC2u6B11fh3bzZKSrPf+QLoPA6kWSatuzR+pfikDi0Tu6DdtgBGOvBJnr+NvSLd8vqkcgOTgYGCmB6VF4lFoZBKGvrzlixQHhzYd6nxxyG+KXcR8Ljb7SI9oeG4pvteme/aAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(33430700001)(91956017)(2906002)(66556008)(76116006)(66476007)(83300400001)(316002)(66446008)(64756008)(83280400001)(83310400001)(33440700001)(83290400001)(8936002)(66946007)(83320400001)(52536014)(4744005)(7696005)(86362001)(9686003)(71200400001)(8676002)(26005)(478600001)(5660300002)(6506007)(55016002)(53546011)(186003)(4326008)(6916009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: puK281R3TBrlA6XnwJ/6zHxqvZaDcwbgk7yCDbN5+7LXu3JcZtAqVaVnTdLdi+EDMZ/kVy/D4DGgQ81dIMFDWV1jPeZoKZCjn/sDrYQWOJlejw8EPnfz5WVmJlmq1WfRd/N2ILB7Q5ocZQP24/EsyOjnjOaafyUAdMSt+NKwR7Iz/6AHLHuK2RDxPyhqFOx/c0/Sy1Asn2QLgf+pZHjigO5iE5FLTNtO0TLUSEE0NK8S+Hh8K+vBIs6e9j/vu+EKzZQuSqmg0xRwA6UP6hYEh1C0BNn+HeqLEqYnqQf+HcuNcYD35hUB4HVY6Tc9WwcO7Z3g8nuwQv1Gwp2e9eBLucbiePXfk3QO7fhQVGQ5ecUVFh57No/J6BbdsMJFRMZJYld/+X3BipxbwxVD/fsDj35ykc+AqpnJ3lLcRaOwhn44WSsTU9B0N48XKKXIJrb7PsCMxKg9/mVe4tHF/EtUZW/fI5JuBsxLnSwq5S0xcJA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ed03eb-e649-4e09-120d-08d7f33b3427
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 10:33:09.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJKLCCadO3QK0fgDvjp8l2ZgPLKvZKLYHqCp1mwNSHQdjWwjCbAwiGxh7ElR+9oDd/IkUtcmXy+xwvKCGtqtAH62FpPzkieF/MO+s/tHg+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/04/2020 17:04, Johannes Thumshirn wrote:=0A=
> While reviewing Christoph's bio cleanup series, I noticed=0A=
> blkcg_bio_issue_check() is way too big for an inline function. When I mov=
ed it=0A=
> into block/blk-cgroup.c I noticed two other functions which only have one=
 or=0A=
> no callers at all, so I cleaned them up as well.=0A=
> =0A=
> =0A=
> Changes to v1:=0A=
> - Re-based onto for-5.8/block with Christoph's patches=0A=
> - Removed white-space to not hurt Christoph's feelings=0A=
> - Added Reviewed-bys=0A=
> =0A=
> Johannes Thumshirn (3):=0A=
>    block: remove blk_queue_root_blkg=0A=
>    block: move blkcg_bio_issue_check out of line=0A=
>    block: open-code blkg_path in it's sole caller=0A=
> =0A=
>   block/bfq-cgroup.c         |  3 +-=0A=
>   block/blk-cgroup.c         | 57 +++++++++++++++++++++++++=0A=
>   include/linux/blk-cgroup.h | 87 +-------------------------------------=
=0A=
>   3 files changed, 60 insertions(+), 87 deletions(-)=0A=
> =0A=
=0A=
Ping?=0A=
