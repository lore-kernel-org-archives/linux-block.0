Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E2C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3F0206CB
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TgQqOHSh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LQZiofWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGAEdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:33:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60431 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593578020; x=1625114020;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=au015O/e4CcW4rIbEvXTKlzstufeFmATSePaeuBICB4=;
  b=TgQqOHSh5A6WiBmgvwv/lXey7m80XH1K0ww+hWrn2l7qC2CV08kaODh5
   cScZaVcJUO62Ex9NJ9+5iIxSmqrTa1WHXad9Nzl55/pAGsuiXU3sgmdXj
   f8V2edGnAAa2iuMGjzPmLKpw10iGx8DPtXtOHrTFIowsB1e6Ar+pAGHGF
   43tUSH3XQ/EnMPdIj6WUJNGEKCLvEyisgvsXhQUgt2DQIJ00cXKa0l07z
   ZOo6imxbnkYlhdiXCpVQl564gSQ2srJBjmr6xW4bHwDnM/S17HXyjXFRt
   djEoi++e8hPWb+c7xpeadCOO7RulyKo45NYEswV4WQXymqjbnxj0dxwoE
   Q==;
IronPort-SDR: bQ5UpKCojvMl86Bsot4IdCmuvTrUPq7RA7GwL8Hp84b9IxueyxDk77jiZoRZflGTByHyh9AZSI
 WYYY+ji8UfGEb3xcPvkqjq0T7YMfd84Pt/r7CehsPmb8U6asMRklxmML961M490sHC0Alugmfe
 p6Eu+giEZ2bnCelPEnkaYcQqH1kIHWBClerXIQZkpuneUJ1TmFUUdIsrAhT+aDqt5hoGMbqROF
 shRbquza31FUexVE+CJizqNzyeSaJ3KM6ZqJHxrISf+stFb95woyUPQ1kbNzHyieiMM17AGlcv
 5nE=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="142695574"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:33:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftkctpEJorMPG9+v1vIIiG5Fg+mfr2jsF62wy2E1Ey0XiNygskqM6MMWKymNzBEcbpN3BGGmprLyP1uLKuMZDDUT4HyxiW8y5td52FJuHVFiOA3NxZ48pZHFWijMfQMzg3holymdC5K7MTjtY6ifLM0gNwU4E5o3/6G+F1EF2bJG71BCH9AwDvvgPeJAMWosDVDvJIy2+Kc6PRTczeat6MKewC0748eh3PH7RHoKqMHQPf6L0HXoqNZlsHbvPEX3pbQhnSFC3mr4YmveR74uLfDZZ8AdrXrSNiMwDPdfgkfS/uKaF0fEZnJsApSYSOfrDojIiPyL7H+kzY8ddxRk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au015O/e4CcW4rIbEvXTKlzstufeFmATSePaeuBICB4=;
 b=Vm5pODVS6RjNY8ekL85Ph6/700x41wRt7obR7CuDsKNfOPbVD7clPrOJHBXkoZBLgHpJmMgLhkdTHF6bTaf7TPuyJxgzgjrGwk3mJfsnDNwXm+cNDOkNfhAoUQ9b52AImjEpomunZC8/tMuY0alz3R7RRn1Vm0rqZXvX2B71ugxkByYigaxs6sly8HHnTzCqaZkx+zlB1EF9vSVMm6M7cL1xoywwxZYwCtIF3bH/c0UDgEO+02FYil6vOfNuoYPNE+xPcErQNspuhHapsyfVVH4pxWhZVyCWWjK9+7vKbupwZSzpsXTLvJ1MhoN3mHnZ0LWcaDueYHISMECiAscQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au015O/e4CcW4rIbEvXTKlzstufeFmATSePaeuBICB4=;
 b=LQZiofWvmIF3V6ZYg4WnZk1JdHClJnHud2cCgslqO85o/NcZxOPux2fzoFH1VBqycrIQJAuAKwgB9yWyJEYkya0jxJ9DX3m/Q4slJ1O5Z1GhXXRvJ5NMS9PlJ4f+NxwufB+LIjzs+KiRtbxbvcf0Kawea5mD8HWWyRJUwWi+HPA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 04:33:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 04:33:37 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "jack@suse.czi" <jack@suse.czi>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "fangguoju@gmail.com" <fangguoju@gmail.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCH 02/11] block: rename block_bio_merge class to block_bio
Thread-Topic: [PATCH 02/11] block: rename block_bio_merge class to block_bio
Thread-Index: AQHWTm8eLx51K1pAvUWCbdphnCEgcg==
Date:   Wed, 1 Jul 2020 04:33:37 +0000
Message-ID: <BYAPR04MB4965637C75F740A3FD144470866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-3-chaitanya.kulkarni@wdc.com>
 <20200630051042.GB27033@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88d6a4b9-91e9-462d-85fd-08d81d77ec7f
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB71248BCB2EDC5942217F971A866C0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ItpEIIJQdlsxwi7HXKvnfyUmYPE9hOJ7xgwETXQtwpAp3G1HUF4dFGck+aDD4p2J6sl5lOIWUpnroqG5G1e/6V0TGO+avvi7poDNk5l9puD5HpkfV1TtK+kgHKSvEEU/alDtRKCERgR3cMAg7FIs2cKvDXnUA1VI2ynezOLYY469ZFD5srjZ/LSpk28NXne4Uw7u2FgyQ8COfXc+L4ULAHcIY+apK7tO1/Lzfj8CebBO2r/gYg6W+LvGai1FYY996C3/WQFmAwGQ+LJ4uqyJRaLNhOMCeQtzHtuovLiqvqH1eptWCmb7IRpYL725rWla
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(8676002)(316002)(53546011)(186003)(4326008)(26005)(6916009)(71200400001)(54906003)(52536014)(33656002)(4744005)(83380400001)(5660300002)(8936002)(76116006)(86362001)(64756008)(66446008)(66556008)(478600001)(66476007)(7416002)(55016002)(7696005)(66946007)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rEiQvRHOmdJ6nKCy3IZEWcTqgUOp5/BN5+C4miHFsZetQ8EmMm/xyGj/KWeJMtdkr4M89Qsg0Nj3Pus3ppV6ZC24RTQKCgsD+mMDJxM5kpiU3WTEF8sFnqqp3RDmeJQlsN4lUVluWph4z255CWsXLOI0b7dc6iHHgvVCr/lXQhtaTNqq7fj+9VvE79vm0Q5Udl7gnm6AolxvGLuqwEltbruus9zw+vw0DGy5JODUeeygKyD6ee/eBtXkSDzkqq2+04DCzQ3i/yLZ3zbkdcA/0o3/rgd8a1e/GYIOe1g7ALZrzncWCcXxn4vnlOdnFIQKasxITrcCK87wcL9mWCeYl8jG+ikLB8QVus3vY52MpulYhRxSSmK2yt8ReajqFyg7rlCn4squudsr6d+Eh6jA89enep1RtMU7LiAh1aFNOQ6mf3DELxbr8sDoe4NMqcthrgcExdlCsEbYM8r65V6u8myuaMOVqnaKfn7nZBkMz28=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d6a4b9-91e9-462d-85fd-08d81d77ec7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 04:33:37.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqZRcgOko27ofkO9je46epJ+pi9/uR9+p3DM2SQieAWPddjyy/j6MallhYUml5U27ZYRgX15B5DeH7U4ymevfKdBw05NhUD8iXyTla4XTWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:10 PM, Christoph Hellwig wrote:=0A=
> On Mon, Jun 29, 2020 at 04:43:05PM -0700, Chaitanya Kulkarni wrote:=0A=
>> There are identical TRACE_EVENTS presents which can now take an=0A=
>> advantage of the block_bio_merge trace event class.=0A=
>>=0A=
>> This is a prep patch which renames block_bio_merge to block_bio so=0A=
>> that the next patches in this series will be able to resue it.=0A=
> The changes look good, but I'd merged it with the patches adding=0A=
> actual new users (which also look good to me).=0A=
> =0A=
Okay, will merge it.=0A=
