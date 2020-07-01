Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA18C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A59520675
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Host1AXe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XVHpD8FR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgGAEpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:45:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19160 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAEpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593578716; x=1625114716;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kGgjhaEGMDvmVt4JXsxO5hilJ0aMR7khE/8Q3bomnfY=;
  b=Host1AXercJ/GAjRWBH/IHjTv2i4fIeY9t6Eo6IwL9/XkEQiig2itZLD
   4E5VPE0UVuoVOrd+eIjNfgN0BxbzdusuVU1yxCWmy+kbe9twWyGx9Ilwl
   b/JmSOSH0WI0Z0VEn9JbUcZ94SHloGnx4UynzSF834htecYSmYlCP94B/
   dksqG31DfICbbaWv9hcSlxlxxMdZ6+lWrLEmMOjN1m9o6lZMWE8maAZoq
   Kc6Rq5k2anea2uOQnVAwO4tctA+dAgEcEJdGNuwlq4rhG9oR09F/+aTUj
   G0iGKkGp+usisoDKI37vodBJwyllrfenbkHPDiJLz+dM0/NoS+3BDWCa7
   g==;
IronPort-SDR: QA5Jw3KQk3zjGJKg3C9ANi/ikEbyWtonTQuHdaOkMJx98rovTrT1KeOQ/iVqRZ5eOJOsKw3AnZ
 HNEKrcHD5TlnCPkp6b7XZOa5eLFFvOF/AuOqr2WMXaSr90EUvfyALeDooDu4VJYDklUu4lkB85
 hqvf9I9ENUI9cnM0fqX2yFEQkReIw7umAJylB8gXwHXyD5hrejhIUhAKOSjunH/JrWE2UVrnZL
 K1gpx+gapiYjBigS/IS3gPkHSG7TDzJDInpuVs2C8XYAeXC0EzZ6e0J4wlxaX4dfN5B8qf54Wd
 UhE=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141341625"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:45:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYkkdHuFKcpAl1hYi/I+qSjw78UI/yrCeBKMxPLA7orADojyn9iKUhFq2wYAT5hR1Q+bs74GrRWIBYQA1rdWxf01cg6Huvc4Og0vyKyphOBaD2hjwcku8VFn8dQz9tESfLac2ov6l86mZMJFGpbmVq9+CdM2jrx8fSA9xJ63BaDQVM3X+Oq0l/CsVqX7vMFUkg8yvh9tX46D/Xa2oBQOnwU4O817qlaRgUX+G5TAWt3YyYkww1OkW9htvhEAa+5KArxwhUyahmrxdlGcV7BujyQ/PJNwlQ1aq3LFGdOfIIYFymET2vQZEK3xETWD9M89LOCwz6V26otV9wDLVWb5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru8X/R7cAxhiSW4tZBvtqzCI6MZ1EuUq8zb4fj1Z9Ps=;
 b=E8vYjsJiXhUSAmFmHOvHi6eXn7S/rkoYa6zFvKsWmVshVHgDp0w8eMlaVpEBxE01gs+srL/deFpg7GhZJk3N0MHrECbOlIj2+zPXbC1lmuFlVChplPUox0X2T/5Jmlf14yb3DbiVSeAv/tP2Hk6YkST0HY+Zd6iZCytgPb+f8pRxN0QwTvq6mKYrAuzhpZpzqQhh5QtzaSVO9QjTSwrmkvUep+PeHm47UeibI7AnmWEb4gAjbguxPWZjkn6Lyjo6owXfYJgsH6m3qYAYJVdIzGfJlxs9teYt5DvFGbgA8hYrS+nw1HVGC+MvpMlPhureKu4MS1X3FNCAZYgZ3yOzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru8X/R7cAxhiSW4tZBvtqzCI6MZ1EuUq8zb4fj1Z9Ps=;
 b=XVHpD8FRKVM014zdZQvKJS8Q7LErrCW1fCrN2peAHh2rFqqejtvs+iOXyr6dz3bnyiCeQrcykcHUnvnlc1z29dv0iyL+ps+yx0/u7yHzOIJRhesripRLnh5pVD2erzMWM4rMahsXFcmIkEh5cB/YNUYXimILyVhtHASzcIhrLnI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 04:45:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 04:45:03 +0000
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
Subject: Re: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Thread-Topic: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Thread-Index: AQHWTm9LvGU76q0unUybnpt+xj1KpQ==
Date:   Wed, 1 Jul 2020 04:45:03 +0000
Message-ID: <BYAPR04MB4965E849D99120B59011CEF5866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-11-chaitanya.kulkarni@wdc.com>
 <20200630051332.GG27033@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 044c2dbf-bbc5-46cb-013d-08d81d798520
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124B1FD9FF9B8B3E1300E2B866C0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ci0D5I3VYMobN1/+lkENDXHzofKDM5bgVg8yEVlIlIjK040mKTo+6OJtlWVPPghQjMETY7Fx4iiMiFA6yEuZYLcIgyrlfIpMlIDcOQlEb12Omc7qQ7Y+eJVeYXKsYSTay2GyLcnrYXsPWxH1CwudWKpjPzHMyUgvrk9kg0nAMIWOEzzwRyG7ibGmSxt8kyavj2bDzo8ZOx/eA4Um76rAlj9csRIfWeCuGNR2V+fMpj2p8OMhJhIN5FGuGv7DvqtHg9r71l6AIv9bygDb9g62dxR1YT5ZHBxGXeFW27dNyQuVV8skdhGHM/+cc9VWJ80ZVSRusnwJRMSwHpChElFQYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(8676002)(316002)(53546011)(186003)(4326008)(26005)(6916009)(71200400001)(54906003)(52536014)(33656002)(4744005)(83380400001)(5660300002)(8936002)(76116006)(86362001)(64756008)(66446008)(66556008)(478600001)(66476007)(7416002)(55016002)(7696005)(66946007)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GZ+A6Utax0lQCf/oBma9DK0wD7Z/VTsJ0TydVxMcK4cGyfgoWvXIVDbitid97br7c+Ljq4KkossdqQLh9f+PmYuK5ibwE44LTRoerZ2rC4A1eaSMMhmveB6bQDwKYKmXfb7pmSHHjiiAet2q++DS7r4cCGDDQtorlpWlb4LV0JWCyrIsBluDCSk22ofu4le+76F/jusP3GD1Egt74OHOD9PNwws5L2SIQzxL/GR3ooQx1cwod6EYxxSp2/mycpUqJnvvnBHGxb66Z53Yv8rvBRnp8zexRW28LwB7tU360ILXAxXxls47XcZSoSm19JYxbj2zGXkszcRDA2AzJUM+wBp55sHL3Zrh9nKRMZ87kzNdC5k1h7TJnFsTkjbKpyl2vTkIbgaqboldZiVnsRQX8es2DCxcEYjkBbj3n2qnnDJHBZYvpSeLTW4ag+aEM4Z8Lk4JblSfZPMoOvxploUk10KYPXR19d3xcBKZZzs3aiM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044c2dbf-bbc5-46cb-013d-08d81d798520
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 04:45:03.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiYhxFY3ghqDClEPerInmD2HEEEcrTDhCbxanL93sjAAsZORgsh/f62K+4YpdvlBFvSaYkF6BPupnwLtFLg4uqLm4EMV12he+oK6fWtM6y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:13 PM, Christoph Hellwig wrote:=0A=
> On Mon, Jun 29, 2020 at 04:43:13PM -0700, Chaitanya Kulkarni wrote:=0A=
>> The only difference in block_get_rq and block_bio was the last param=0A=
>> passed  __entry->nr_sector & bio->bi_iter.bi_size respectively. Since=0A=
>> that is not the case anymore replace block_get_rq class with block_bio=
=0A=
>> for block_getrq and block_sleeprq events, also adjust the code to handle=
=0A=
>> null bio case in block_bio.=0A=
> To me it seems like keeping the NULL bio case separate actually is a=0A=
> little simpler..=0A=
> =0A=
> =0A=
=0A=
Keeping it separate will have an extra event class and related=0A=
event(s) for only handling null bio case.=0A=
=0A=
Also the block_get_rq class uses 4 comparisons with ?:.=0A=
This patch reduces it to only one comparison in fast path.=0A=
=0A=
With above explanation does it make sense to get rid of the=0A=
blk_get_rq ?=0A=
=0A=
=0A=
=0A=
