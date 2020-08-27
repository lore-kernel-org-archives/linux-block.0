Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8D0C433E4
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719B622B4B
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UzPU2o8Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n+X3CoY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgH0OuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:50:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60056 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgH0Npl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 09:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598535941; x=1630071941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=akviaS+P70RNeG7SwRi/XIf2nVfV/oZr/bJ5NWuUj3o=;
  b=UzPU2o8ZK9lhE6VFE9JLhllM1Tm3IdjnUwQEPQn4Iu5KVyAgVZi34I88
   5KWOuqMXRwmmxCBzeLPQLf/IbF3kV05MsdqlPcW5XT5R/4l67JrlPX3io
   qtMy6413b8GwVdwhWbFC+5vMDxpyJQDQoN/mFL6kfe+qoqswJ/1vfeW6u
   taTsO4Qvf5NGwrU+RasiBlDqlrxZ3TbxvTvbyJbxkKIVjhUuwFi2DToKi
   /nn5fj5ia0NTSmmXCQe1umjiq2+SHgcTvCj9NpR07UOEc1FOwSBkqSKUL
   jujzcNoFxLQ0ysLznNFn1paM8Nj6ZsLkIT2yzAGvCb06VnYo5jo8h2NbJ
   w==;
IronPort-SDR: h1IePQS9kqy3peKeDSzTPaGC8Bz8/FRNvXAzPcUgOBmQyOmWXFLKd/BcKwbryePxJD2DuaGuuG
 /uSfBtpGEnI+D68J/mHz9bcs07yvK2Th8Ve+/spd7HGdmkh+WAUyaRq76SI4dLe2a80WSZzNW9
 3FMrCvLip8j8EWyiw1ZUTwgxTzzF6Efo1PSbXlPl/ku04mD6//tCAIE21+u0juZw+aMRaER/5Z
 x6AjbHMmqmsnbACdIY/8ot8fd5tbnBa7jU3wWervDlFuNZuarpw6IiJA5bsvbqoFzKyn9cQi7R
 AOQ=
X-IronPort-AV: E=Sophos;i="5.76,359,1592841600"; 
   d="scan'208";a="145975570"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2020 21:45:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM43MPI4GTaejlG2AeHikqCH3r4LYTUhjap991ayH3SqRuRW7kjHXenTd+VXW///d7doxtgQAOQcfV2MQ2cn3JOBEOF7Y1y/2hJqBWAZkcvdnEX57lIlyW9N9luL763gF7iZ5iAW3W4iLjfNCm1gvpCGoEoel93tz1lJwOdCCPhGmQMds4wOazBd17bw8Q4kOWwFuGgsSwQJkhzX8B2o2L1+YhYooKAh4VGDsRg/XC438b6n0gMBf9nPD76RBoSIRkYkbxDlIehyIQ2puKjFSjT4Lzt/uuEdQK07Koyiy+FokwQHwVNK9pb2xfWEL354Tk2h1MNLXQRdYOw42CT3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akviaS+P70RNeG7SwRi/XIf2nVfV/oZr/bJ5NWuUj3o=;
 b=GTE8oENyVlfBXh+rFytd9HBPKigJP0xZ7YhFpK1fgE0lz8cpkqhgPR5r3ra60AtsZhZCWTxwJGOwUZq47VDsuBJquv7ZMcXxwRujvFyF6PHsyWpA2aRVImt/rGWQp2B23MaGVurBiguYPUTseM8M72YzYEs+0IhIfuXbr+GTupM7aL7efT+sbsRoTw1b4sDO8DAxcp5aj3KYJXK5NjjnYX4DNGGRiEMGaho+Ptvmxg4QIlfWGt6Y3T+v9x/3u057w3ghJ+zhAPEXIf4lxUBcXKz6imhgrEd1zw7rEXF9u9U+yYfX5jy8jSyR1tqgzg6v9jnb0XcfDbIejXiU9fqp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akviaS+P70RNeG7SwRi/XIf2nVfV/oZr/bJ5NWuUj3o=;
 b=n+X3CoY7uQ+EG1qDikmYJF5P4p2mRYrc7n5VFdLpD3Cg9Uov0feMEzfoSg+pgR1JG5UZBjCJYPumKfV1qlx65sM2Yd6AXOpSpWDWw70QsuaQqB0i6K3EZJ8PyvUgPtuI2BP05RhqH9u2s9LMOfJTamnCa4IFCzwAjfcOd/qaFw8=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN6PR04MB0933.namprd04.prod.outlook.com (2603:10b6:405:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 13:45:11 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::cd08:5da9:34ed:4ec4]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::cd08:5da9:34ed:4ec4%2]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 13:45:11 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add support for max open/active zone limit for
 zoned devices
Thread-Topic: [PATCH] null_blk: add support for max open/active zone limit for
 zoned devices
Thread-Index: AQHWetp4dfc0OXrFHkmHJcJ6rQ91L6lL+tmA
Date:   Thu, 27 Aug 2020 13:45:11 +0000
Message-ID: <20200827134509.GA62540@localhost.localdomain>
References: <20200825122244.126129-1-niklas.cassel@wdc.com>
 <CY4PR04MB37518DF84867B6E8573A13B0E7570@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CY4PR04MB3751304895558D34A8EE8DB1E7570@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751304895558D34A8EE8DB1E7570@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0b1b285-2578-4f24-ca99-08d84a8f6b64
x-ms-traffictypediagnostic: BN6PR04MB0933:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR04MB0933C6018CC1C645B9EDD5B6F2550@BN6PR04MB0933.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZpydKrgDcj89+a0MW7v8WlkLiXQ/LEYgIyLjkOMpp2jGuUqKBrlvj01DXy9Lff577q+TPEa+O46INjk+90NqawpCO0zze6PeVKcPQ9S7+/m4QXpkkmMSyxu5QiPc6HeGn8FC9XhEa2rkqymrcFH4OEIsmEsUkk25m+HV+NE4NRrqk+vYJDqaJNtN8vhH4+ML/gvSTzadB37dI08yQop6ARGAPM9/uAnVT5P7vokTXbw8BIvD+ogZE9QmFmntn/W/34C2CLL5VJnUFBLxfGOy7hCFCkcZoCB2emnQdQuTK2gttN+4NWr1vJCFgaAs3+2XAO3g4wWwqa93864W6YIhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(6512007)(8936002)(8676002)(6862004)(6636002)(76116006)(478600001)(9686003)(5660300002)(64756008)(66556008)(71200400001)(1076003)(6486002)(66946007)(66476007)(66446008)(91956017)(2906002)(4744005)(86362001)(33656002)(316002)(186003)(6506007)(53546011)(26005)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wZt+H5ljt3riQ5BH897XSRXAGbQ6cmuqBg5Tnz8Cpinf4Tmkm7yrW4vdZwZqNEVjkCdcnJiuwvkE8OGbA+428nics8kcdyIMYLPEHMc78cD09X2dSCUwOcPprrYWm5rCalT1TqUywDtY3zMAoL//DAc/y26DKu7s/Sym/TPmX0Bj4WzTXBNajuEd3btByEAEVWuRQxsYjqANuXrHELHYIt1EHl5YPh1yDYtKPHa2NSQzyrnPp0tEFLTVQf8XtiKYu7cVEG1W4ITvzGUnrscIVaZDaWCzoYpOu7j8/TZkYVc3/n3L7aDGiUWx++GybRn3hkLk0un9g/PPU2cKFx292290PP3RE3m4KTtAAuwzZ+eOgYWJmUrMgIXWpqbh3b5MTNdKQ4rzqIaKR+6o46uaaniMJw6rhjmHV/oDydEmqa7hE/E2mTPAKhdGIyZ5sSw2cM+ymAy5mbswrqZwD2S3F8TUitYQP/R48Iab0NSV+pAlXHRnHcMEhd3b7ifVssPCeNWDCejM3o/sdQO0FfaH9p5Q/jAx7TQgdJbnQAfY6vFuosmnwY0pi54VxQf9CQbHh+yAraHuRUUTtZxrNskRxfZFX+VnkHWd+mWp9uDKZ+qL9ko/0SE/sNWOxCyvSJRpmp/Oqt4+ijw+df+NoN/+Mw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2752D27D41D6A4893B977C6173741CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b1b285-2578-4f24-ca99-08d84a8f6b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 13:45:11.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHtKpf5z0xyoc/2mh5oDFSZQ1Aj3mTG5U2LosPo7XnT89zPU1Cp6trQKKoTF4GsHIsQ47U97GwpvQgDCRK1fOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0933
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 25, 2020 at 11:03:58PM +0000, Damien Le Moal wrote:
> On 2020/08/26 7:52, Damien Le Moal wrote:
> > On 2020/08/25 21:22, Niklas Cassel wrote:

(snip)

> Arg. No, you can't. There is the trace call after the switch. So please i=
gnore
> this comment :)
>=20
> But you can still avoid repeating the "if (ret !=3D BLK_STS_OK) return re=
t;" by
> calling the trace only for BLK_STS_OK and returning ret at the end.

Agreed.

Thank you for your review comments, much appreciated.

Will send out a V2 shortly.


Kind regards,
Niklas=
