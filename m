Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2613DC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF50B206FA
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EIsb9UAG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="USr+pjyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFRPgg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:36:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10055 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFRPgf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592494595; x=1624030595;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Aw5+4us5U88hINs12zQMQLrHGBQqufq2W9imjb3DO8Q=;
  b=EIsb9UAG70pHblnLJmzwEH2cnEkF/nQL4w1GMkUtzlAyG6jAS6esEbTB
   kD+1N0Q/kfhB0tlFtXFpv9mNF5twKFzisPk++kcbG6EtRz6Ab+9IPGJEs
   N+IMWHYfnaexoVTt+SP3HWJ+Xh/JjA54c+676ijs1L0CYoZue7khQiU7Q
   JvEn9DnA06DF82Dj21wdgyx2z2NzGrjejzFfpfRNjS/b6i4nbDyp0wCFd
   QdUVqlRj0ju3cgs/bEG8XdrI0cf3jJGZBEYuukIXKo4zTMDSnKYHj+H+8
   X+BImHtm5y+64BLPuH3kKGudBgg8h/c7qHqUu3NsCIw98ugMWj571pVn4
   w==;
IronPort-SDR: qLQtr4CvjpiorwbCMmhQhyHg0h/OhZAHhciUMh/Or7g8c1wMXCNcPTY4yxvINbwDi7IDxA/Pva
 OB/pHUgosADFEmRQChIf7jwHtSP4e3ejfb85rMTZBq7rg6J8u5tGeyDjboxnseSH1xucysCAzo
 i8ntfYYacGdbayUex/KtL2wlOJ32smF8ayJUwbjodc8ONcxRFseGL9t0gl2zRPjD5sDO8OWypA
 vzmcGkE8IU9L5nGo81cvjA1iXSTWGnxS2vXeUul12ygVuPK7q68YcIMwkYXLQhzIfoMBrA3oYO
 KHM=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; 
   d="scan'208";a="141713971"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 23:36:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5fFQsfecCru31hk+mXWeb+wyYGYOqNRytFeP9fpp+ZeGQ1lXQ9MLGrCIWme4iCkc2ML50dLbWNxu6JNhDmzCLekU/VSSDP9gssMLQAaPeez051SoWTBw6pGOenNOiM2G93cOcffKZSf4VMxNZFybTCZ7CHSqjRhfJY10Ja4fgzAaEjdZzzr3uN3+QUBm+phbJ4KB2tK9DlX8UxB3ODmU1K+0mHstwoNLlO9uMy52ZuzHIF4rHnvrLzXiC8uQqwEQSQMftGI+OyE1CGioYhAak8dFpjyBbFEJohyAk9dU4TnRzHZhcPir4H+Sx+3ZmOkRiQaac5KX8AJwKVuLpZaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFOqDOLLFElts/aL73/v1Ip8Im+/QZbNOqxwMFaHk0Y=;
 b=ED4LSrehXprojG7iD+Xm79979vy3YDBEznFnD56NUhYhxLxDpZn0mqeiRAvao9+2gfqbixqjv1TC7SRa7506nSx6a1miPMQrdAXDaJHu6e7r0tyBJ1HL0chkkEgJJsoSIZPWigJbnQcsDwAfwi/iaakJ1Y9uK5U8pHuLi45lxLxsOKD3I1u+vNfSTj8rDtxc+sinmBE7/acMCaiyOGc7DqOJoXQOuVsB3KR/Z6NUL/t+Ws6A9q+vSBCmGS0IwapVXRvAa2mUAv2WvSC4WMbBWklUB/IcOf8ERkDt7XdCMEKI/VbHzLqnxaiQ6YzZ3nV1MnEEaBGCIo9wXH5kFl8/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFOqDOLLFElts/aL73/v1Ip8Im+/QZbNOqxwMFaHk0Y=;
 b=USr+pjyF3qgFtXHcEMrX+Vfe28ZZGN0hECxsJisH3WepAMOlwCuEVs0MdiC/rtL8IdMFFgpTTrZ0uCiOqHYMFdJ1EmjutDsTosvEdCgTXH+5Vk6kh7Vg0SdDH17/JF1DC1BKC/aVTxZC4X9+/s+dyMTxlZQ0OrwBr4RM2gIL2lU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.28; Thu, 18 Jun
 2020 15:36:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 15:36:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Thread-Topic: [PATCH] blktrace: Provide event for request merging
Thread-Index: AQHWRLAMNttH7JUaU0CGzcROGKdTgw==
Date:   Thu, 18 Jun 2020 15:36:32 +0000
Message-ID: <BYAPR04MB4965EE8C1438F49F582CC6A0869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200617135823.980-1-jack@suse.cz>
 <BYAPR04MB496500B1315D577596F07724869A0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200618120446.GA9664@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5bc5f87-0622-4a49-26f8-08d8139d60c9
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB40395E2E04A02FD8EAF6CDA9869B0@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBkQ3e3YIhF33zWmpATtS5dJ5Eij2d8uiO7k0c0+05iHXoacNqcVMUsRoTOdUk15q5S31oPKFW9Hr1KhN4iDzmOqdOI5cI6yNCI3RPwwHLqc2DuE1XVvgYelQ+SwBZwwx7NZrizXpW0ht3xQW88N2zdalfUdSP+9amn5m5sSyzQPgVCCTAZdhCcOohuMsOers7Cuw+J01QGTG4NMFLwl+LDnfR2zwNY90azeVw5n4nGEl4F2c0hbufX+9GKtYPrQ39oSSkBOoZFIOvtvNpcF0lwhS948yvugOqPERETC8sk9yzgOyT05bD94EOQDcN69UNFmmOLHSjj4KaRhrtDOqrCDRgWjZEt0Ql94stAlGAKIaXUy9Nt91B6ZVe4L6bea
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(86362001)(53546011)(8676002)(71200400001)(6506007)(54906003)(33656002)(26005)(7696005)(9686003)(4326008)(2906002)(186003)(478600001)(5660300002)(64756008)(6916009)(76116006)(66946007)(66556008)(66446008)(66476007)(55016002)(83380400001)(316002)(8936002)(52536014)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lBgzRUWk1piq6C5Tg+BhIkqeWNdnX592uvHd8J7FHwUFVdORtXi93twT6h7PbAAsIvtcvAAerM6cAJNzugGNPwtPnwV4KmXkUffcDoTTPGAtK3i4qB51HgGtqsLLjaiA1J0u9JRMZfWQ4pE6/OYDd2lm+Uft6B/sRqQM2ZOpKOVx5nig2PG/zcDgAzj28hrB9kmeWb22HY4aOyBGgk856wLwJQCfFq7YhYn2tB6virxiDuyzVu4hoylc6uUwwcOD7Yi8z4iaBNQwgCo0KBiUvGM6dQDlPjd3BL1bqGUG9g6x7lY3Veihf2XdwLhrmdv/UrAFWUcTnNdpt/sT8Q9zuu+UZHKYw8RWo2u9wafChbXwoyap9A0DfKwU8n8HwaUdIbMvDTLtSlKaboV0c2+C9UqONc54jxJ+TLFBZN/us83F3VtR0Os384XvVAO4wW52QRMWl5DhUd5EQBZmOjMh+XrCli/n24rBI1Rr4eSaXWs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bc5f87-0622-4a49-26f8-08d8139d60c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:36:32.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJ5akrljEKH4mJkgoBaMEoVGGMmnfp3ZNacXjmeRKQrAC/xiLkpCwx7zlFVhaM/R4cjzrTZvwotUBOWhURRBethh7PGc5ijP7Whvo15ccWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/20 5:04 AM, Jan Kara wrote:=0A=
>> The attempt_merge function is also responsible for the discard merging=
=0A=
>> which doesn't have any direction specified in ELEVATOR_XXX identifiers.=
=0A=
>> In this patch we care unconditionally generating back merge event=0A=
>> irrespective of the req_op.=0A=
>>=0A=
>> Do we need to either generate event iff ELEVATOR_BACK_MERGE true case or=
=0A=
>> add another trace point for discard ? given that it may lead to=0A=
>> confusion since elevator flags for the discard doesn't specify the=0A=
>> direction.=0A=
> attempt_merge() is always called so that 'req' is always the request with=
=0A=
> the lower sector, 'next' is the request with a higher sector, and 'next' =
is=0A=
> discarded and 'req' is updated. So attempt_merge() always performs only o=
ne=0A=
> direction of a merge and I don't think it makes any sence to distinguish=
=0A=
> back merges and forward merges in this case. So discards don't need any=
=0A=
> special treatment either AFAICT.=0A=
> =0A=
Please disregard my comment regarding adding a separate tracpoint for =0A=
discard.=0A=
=0A=
I understand the code and that is what I'm saying it will only back-merge.=
=0A=
=0A=
The concern is just like we have ELEVATOR_BACK_MERGE used in =0A=
attempt_merge, we should also have ELEVATOR_DISCARD_BACK_MERGE and use =0A=
it the attempt_merge() then this tracepoint will map to the back-merge =0A=
which your patch does with the use of BLK_TC_BACKMERGE nothing needed in =
=0A=
your patch to change regarding tracepoint.=0A=
=0A=
> 								Honza=0A=
> =0A=
> -- Jan Kara <jack@suse.com> SUSE Labs, CR=0A=
=0A=
