Return-Path: <SRS0=JpzN=ZB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D53C17440
	for <linux-block@archiver.kernel.org>; Sat,  9 Nov 2019 01:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DEB214DA
	for <linux-block@archiver.kernel.org>; Sat,  9 Nov 2019 01:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qynJGZ/c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wLE86SbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfKIBju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:39:50 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18419 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfKIBju (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 20:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573263590; x=1604799590;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2MNJurTOyCCkwWm+NMg0iY8Kh9mtPPBYxya+XIVeMRc=;
  b=qynJGZ/cgZ8dYEBVJHlXx+pYh8mXmFe7z6TrBF7IxMJBvlRH7MFzmxDy
   wnZbIQYMvHplTWSe7Qf4Cye7C/1xtxWA8Pti+fQlpPitWdOwDwpDr6M4D
   X7dy6+b+bK4ddS/M+7Rn+2xCYnXV3Q9HnpsspuFAMTP9T3D+nase4LtGh
   1yGBmvZZzgxb5+0ohxFBSGBjl0GWDfGeqVWLf+/pqTrSHkrhLBms7fNCs
   77xw/s9mpfRSHXhKC7yZizJgHXVwPmlKYo1oXfrYfGFZBien4GLJdgiaQ
   3mz/dpklUsPRMYxRfLnysCMxWHmORzYv/wRPmeCFARzhP43ievOyo4VGV
   Q==;
IronPort-SDR: 0tlWegc8/MVB7IgyMOd0fSw7hyN9XmO1FekzNzV4f6VD0SLB/zLrqFbtg2CYwR+3NpGjZUXD8N
 XF0ORlc9gB1MYbrDgq/kWUuxZSkXa95jehRpln5QUDCjQ0o+PnFwld7vqi9cyJWskbSfBVMDtj
 GcYrT97I5qIEdt/nxRYHgcLqLZOAFTeeeJrdiydN7uZ76YUo3w1u9IPBYm4X26FcO9ZjCudmuX
 oDSo8tz1vWO4S8EitIDUEKKFSRXBTL4chkBcbtkh40iBmqdpx63I1EYSW9Ql9mnaGeMr3U91so
 kgI=
X-IronPort-AV: E=Sophos;i="5.68,283,1569254400"; 
   d="scan'208";a="124159046"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2019 09:39:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBrD5Nr3hw1OC5Q0ql9xtuL2xSJUAZn5WTH51kw9toj1n1jI7sB0R6129ao+wp2+8b8NvedeKDzqUDUOrKjTn+rTvTX0k28hCMNohwrmuwqHAstN6m1oGIbzT/41tQw466HwYDlWkVh7x/ZK8JTokvO4XlV28cgDuAOSDMOGgCBd0hhkSJroAC0N2LCnbf2CKw3yMAjYcOJ6DYEC0twQAZrnOQBXdkwgujjpQ+zKpYGAIZh6jRK/HC1tjccBahfdbGIkbRsA+Rc/WMCXgW4QBlZl5hgDQbQL07qMXTkTrqqOWm9FD4YkaUTF7Ez+F0QC5HoxtSUbNh3ql3ytlsjmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhYMl/uQzIYv78MrHspIrLlUO4wMvNSDc+aZgJ144Ow=;
 b=ncUZks5Dt0AxrEIhexg5VSK+iLOdA6s16afsbKgB0Lf1lJO3x4ID9eoAeVKqwCPh37aZ4nRkmFxaD75FsQALV9Uwu5c/Nx+XxUhJeSYu8moHg9smGwTPVTx8AsTPqTV20B66H7+6ALzbgfVILNeXwWivrpo2TtepiXSSJPreERgyK4yFI07JRxHNSKlOTEgLDf2/EwuQ7ek9Y/9UQu8ldCLeZfw4RBxqM95KGCYSsWP5P84rAq4KEEpIkp46XKo/+pkIHSAO8kUPbAcNl/SgQQxfSPfIQ8q9ELI46kOftTgpE35zWlw1P4h1o0jvmuCHoQUmfvh3MSZ+Wt05mdOEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhYMl/uQzIYv78MrHspIrLlUO4wMvNSDc+aZgJ144Ow=;
 b=wLE86SbGIhUjJZ9UOTmk5ScMISTZ2XgiPeycbdZ6l93/5mnUm2NRpLXPcc9w0RvJYnLHCPRk6zF7jOjPS1+mFjunoNobC+hMGngVq98LzqitWPGW/yQCH5c/WRIb4mS0kMMItkWXjr/4RrR2O05aySMKppwZfgtk18CxyCLRT4M=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5877.namprd04.prod.outlook.com (20.179.58.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Sat, 9 Nov 2019 01:39:47 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.023; Sat, 9 Nov 2019
 01:39:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: allow zone_mgmt_ops to bail out on SIGKILL
Thread-Topic: [PATCH] block: allow zone_mgmt_ops to bail out on SIGKILL
Thread-Index: AQHVlo2hPrURUxQIBECzzHWvmEIzZg==
Date:   Sat, 9 Nov 2019 01:39:47 +0000
Message-ID: <BYAPR04MB5816F1039A83D63DE2B2521FE77A0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191108233820.4325-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51d89dd5-8039-4b53-8678-08d764b5b47e
x-ms-traffictypediagnostic: BYAPR04MB5877:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58773C2EB7342D518AA2E0E9E77A0@BYAPR04MB5877.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 021670B4D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(51444003)(189003)(199004)(2501003)(966005)(186003)(71200400001)(7736002)(81166006)(81156014)(71190400001)(486006)(14454004)(6116002)(6506007)(53546011)(3846002)(6246003)(66066001)(7696005)(446003)(6436002)(305945005)(26005)(5660300002)(8936002)(102836004)(74316002)(76116006)(91956017)(86362001)(66946007)(66476007)(66556008)(64756008)(6306002)(66446008)(256004)(14444005)(110136005)(52536014)(316002)(9686003)(229853002)(76176011)(2906002)(476003)(55016002)(8676002)(99286004)(478600001)(33656002)(25786009)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5877;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlJmcMKaKPHYCQFOx4SLYP1CWjdVYkIbwYCLbbBbE9AfEoGpg+iT4rCWHWW7DVyH4EdTfbwf+bYXFjSQtbaV0lLgYhNHAbxhg63CTdU/e/69RUM9afwl/PoKYjb5FvV0VlQh8QWSQ9HXULhuORWZ1ucXcgoyyLcgZy1QkCIFoRXLGc8mF16OG2bnBijeY/xWKMZJ+n3QCH59a3qD6fzNnZu3gCRni0h+71xaMc5s2U5EUPPWK7LjNOGya2fANwHXlzc644ri99Bc7UpCB5aGr2tuimfV5OWwO3zKuWGvtYIbpqwhyXiYulXewogePMUhYeDZTKWLGErtF/RtWiTfxbVYzE+dKNHYALlHDAhM9L+LJYhusXrrq6EPPbufoYUYWXFu74itBKRjmRraRs05VPGk4Y5/Guj51vO88uzit5PUhMe7JjeoRT/9q1fcEERRK1KosYJ4AVppWG+mZnh2lsDcYljGSaLiTsusvbD4BBw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d89dd5-8039-4b53-8678-08d764b5b47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2019 01:39:47.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wgon+VxsedcuNUgUKRMmhS+kC19zjSkVCvv/fSEpgIACPPyYiRvxzm4KaCWK5lKNxzF6JgJwg/eAYnxxoMqCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5877
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/09 8:38, Chaitanya Kulkarni wrote:=0A=
> This patch is on the similar concept which is posted earlier:-=0A=
> https://marc.info/?l=3Dlinux-block&m=3D157321402002207&w=3D2.=0A=
> =0A=
> This allows zone-mgmt ops to handle SIGKILL.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
> =0A=
> In case someone is interested here is the test on null blk with=0A=
> added prints for zoneid.=0A=
> =0A=
> Without this patch :-=0A=
> =0A=
> # blkzone reset -o 0 -c 1000 /dev/nullb0 =0A=
> ^C^C^C^C^C^C^C^C^C^C^C^C^C^C^C=0A=
> =0A=
> [  174.115065] null_blk: null_zone_mgmt 163 zoneid 993=0A=
> [  174.125071] null_blk: null_zone_mgmt 163 zoneid 994=0A=
> [  174.135076] null_blk: null_zone_mgmt 163 zoneid 995=0A=
> [  174.145082] null_blk: null_zone_mgmt 163 zoneid 996=0A=
> [  174.155087] null_blk: null_zone_mgmt 163 zoneid 997=0A=
> [  174.165091] null_blk: null_zone_mgmt 163 zoneid 998=0A=
> [  174.175096] null_blk: null_zone_mgmt 163 zoneid 999=0A=
> =0A=
> With this patch :-=0A=
>  # blkzone reset -o 0 -c 1000 /dev/nullb0=0A=
> ^C=0A=
> =0A=
> [  211.889379] null_blk: null_zone_mgmt 163 zoneid 191=0A=
> [  211.899420] null_blk: null_zone_mgmt 163 zoneid 192=0A=
> [  211.909424] null_blk: null_zone_mgmt 163 zoneid 193=0A=
> =0A=
> ---=0A=
>  block/blk-zoned.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 481eaf7d04d4..07ff2b75e6d7 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -17,6 +17,7 @@=0A=
>  #include <linux/mm.h>=0A=
>  #include <linux/vmalloc.h>=0A=
>  #include <linux/sched/mm.h>=0A=
> +#include <linux/sched/signal.h>=0A=
>  =0A=
>  #include "blk.h"=0A=
>  =0A=
> @@ -287,6 +288,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum =
req_opf op,=0A=
>  =0A=
>  		/* This may take a while, so be nice to others */=0A=
>  		cond_resched();=0A=
> +		if (fatal_signal_pending(current))=0A=
> +			break;=0A=
=0A=
I think that if the loop over the zone range is interrupted short,=0A=
-EINTR should be returned even if the following submit_bio_wait() call=0A=
succeeds. So may be an additional check is needed at the end of the=0A=
function.=0A=
=0A=
>  	}=0A=
>  =0A=
>  	ret =3D submit_bio_wait(bio);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
