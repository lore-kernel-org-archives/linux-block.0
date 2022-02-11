Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E0C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 10:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348731AbiBKKCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:02:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348768AbiBKKCb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 05:02:31 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4140133
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644573748; x=1676109748;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u58xzXKuue3Efjl5YAW8AZXWqLFkeDyfKKl6///ClkE=;
  b=rh3IEXd8BddwUmAPcFftsgz15PrWtRsgDdIwyo1pCThAWPjmTLcHXTiZ
   01wJ6QBIX0Woki1M/lI6oVwxxJ/+Ae88Nc8zML/xd467uYc9ljC0g3+vb
   j3yiPMdvQKCLMtklNvnVMYXoXvDMsPabKE/nDMwlOMslccDnZ5QPqPDS2
   vJ94lfBJ26s67/vF4cGZgewcHCRU0rakO+RGmJ+qSJojvtx/+STIYtZFi
   TvALAhTC0yT/wOL2YvhWY13Qkvgz37swKXIynPmbEsSkaWfuiYkQPlmOr
   iJHVjDtmgDdZNj62ILjFEm8sUwuhXsErbJYlQWq2eZTsMLnQz9DUn3whC
   w==;
X-IronPort-AV: E=Sophos;i="5.88,360,1635177600"; 
   d="scan'208";a="197506576"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 18:02:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FglU9zFFqDNKdjkx2SXlKiCk+t8/HoCOMHoLSh1u/j8P75IvmeWIfMzplpdi3vkDbTodlFS6Fp7Rs/xaTBo3/LsNeSipemL1JcRLpTFMScu63EMA7/e/acLuU74EWgSkWWLXsw7WVydfHNsZmMWHcDnHg/dXWlGGb7kh1LNHWqwdHH/8r/EBr6KL+P0yhLfBR64LIrhNpCfJCzlMycbUZ1D3bcPfKK/edOLzRkUOkA6GuEU3oYqPP6ZCLcRiaY0AoYp1Xq9Oa5IEXzGuLQ7cAsgzhtA6ri8RVho++w3L3RryzNS4YrS2QlDq20qXAuNnWvMAVQ/FzI6kQWiEqkFWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u58xzXKuue3Efjl5YAW8AZXWqLFkeDyfKKl6///ClkE=;
 b=Inz7ECBbVoPkwNy48+4D+5A5YBKj+Q1L6+8vIMIlgc0obOj41+j+nOyNJEvb4OEZEN8seuB0Z6vORS0gi76NhvXoQRFI8FmM7QCIt5oRfkLTv3tHwx+EPwr66xl7MhVsFF7O12lNtFFhfMVHvA90utBSfG3rma4iQVESoCNp5E565oGdUgwGCv/wRh/FHe8RN8jZj1WEjYTOD2M/m8UDJVKfJyVquqx0SGO9tBdYVg1C6UFS25Z9zvZmbfuwkT3wYpVDQXA6SnX1clJpFEb5B8jXmuk5hYFtDV3twTfFhCwpAXU1V7LTS96NULVO9fCEIY3yiJ6r7Nkry+OFNYqhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u58xzXKuue3Efjl5YAW8AZXWqLFkeDyfKKl6///ClkE=;
 b=wwUg/8mvqnUJnVO+ysp4Nd2+lm4jmQ46PzHSBx1y3WZY8IdyM+nT0AR6Y6ZA0USUNCy+ud+IQHgnlHPElCcqNzd0FmuRpQDTDX0BiJYSj+Epdyzga9QQxb9U4VfbQPJ8cuM3oFjFJ3L3usQXK3bucUZwAdb54xttcK43QW3Qnu4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6760.namprd04.prod.outlook.com (2603:10b6:610:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 10:02:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 10:02:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Thread-Topic: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Thread-Index: AQHYHyuwDs0xN4PpMEadJthhR/vcZw==
Date:   Fri, 11 Feb 2022 10:02:26 +0000
Message-ID: <PH0PR04MB7416B842B185ECF0F52AF0949B309@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220211093425.43262-1-p.raghav@samsung.com>
 <CGME20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314@eucas1p1.samsung.com>
 <20220211093425.43262-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e8884c-b525-4b5b-149c-08d9ed459b75
x-ms-traffictypediagnostic: CH2PR04MB6760:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <CH2PR04MB67608EFE2BB47C68D40E3B7E9B309@CH2PR04MB6760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrqjGf5cCC10BuPhJIXRCQb/I8qBEMDrcoKH8xRtD+RmAoc+w8ntGPHQ1kEjFBegLFZ1IfE4BYj2G7MrUFazqPdGBMX5mZobtG3VYIzlZmjZGz3jdSpwe3E15/olA1JMFGT3eMUpWppIhsrEGEWhF1ef8yRcvlrwMkIX4WIrO30fuSXSSJpHEKEA2Jo4dfA0dOxxk3oTdSlSZ5MJjMNEPomT/nPSs2cgBS8M8qgPlxgvyjD9ppv1iIY1HRxXSqlpCSJZA3B75lJIk+0CeuWeHgam7kuH7GlrMoNQdd6vOFXX/JmaUvC+PJqxiWsnYzrctEw0zYjabeLp+oak8nZNJVnLESXjaszij7VgSps1BCJgfPKgV+43JjnkbxHK4xgmT52wwOCyr/WKqGAETz90QHGl+934HHh4Qvkhqj+hAX2Nd8y/QCxNBnntNiDlh0ZzceTZv+XS0mWnLKqsa7RcMPjDsinSwInGP6ZED7xgPwDmPE1fgMi+9Cb41io2FcbBh7SZ6DTmfPmAUlGqrlZ9PhHelbyRVufxqqPAvvWN1fKYWgnUoxvh1SPAmrOuNHidH8XPWo8np0IUEOJHd1Lm9WzUyu5qhXzfJD3jfRNuRxkvykGi5+S3magrv6D83ydnAUdZt9l8jxju5OaEYZgqgKvkRy5ReQeLFe9HJoGaRz4rGSWDer0IDry+yzcoVOlm7YLI9psU8DyoyRix3T5nsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(54906003)(38070700005)(82960400001)(64756008)(4326008)(66446008)(66556008)(8936002)(91956017)(33656002)(66476007)(66946007)(76116006)(5660300002)(316002)(508600001)(8676002)(52536014)(122000001)(7696005)(9686003)(186003)(86362001)(71200400001)(4744005)(55016003)(6506007)(53546011)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cevp6dwR1fmKLqOCMeBpw7omFSeJg8isrHESRhjcsh+pIMxDNA6fw2zMB5?=
 =?iso-8859-1?Q?JMPK81q8aQUV9585UQcz4PNToQxUQZ7Ozow4RU03OvRere34Tapr+vgP9T?=
 =?iso-8859-1?Q?hMVUqO/re1SofZAJ5yQ+5vbdbOjbHYmCuzg1lx4btOw/uxL4Gc7shKT9OB?=
 =?iso-8859-1?Q?J0W8mmC6FNHbH2NnJOJk4pRjvKfxGYFSIDAbHwi4SD6Lo6EBFQzwzb/vSy?=
 =?iso-8859-1?Q?qnDWE2f1WpJhwkPLABaf3iNitnMfA00bVW5Xzl/MDeXYv6MtFDJ1mDiuup?=
 =?iso-8859-1?Q?CrX6iqE4f/8YU0/XIfVnrsH3yJ8EnNoNnhMoQHYgkZ4ls0tArsSjr08GQd?=
 =?iso-8859-1?Q?IWbqXzTMauak9SPLIkLLd+jZz6F2KrH6AadFVdaVYP98llnsA4m+CZquAW?=
 =?iso-8859-1?Q?47uBKPSca9B1SdITlDhxtf0i1OyR1XkmLxORJUluMttwhwRRRGFc76Pwsk?=
 =?iso-8859-1?Q?Tz5SofcprFj3Nkp7TnCGoaQPNj2PrFzXo5SCyv/lJOY6GF4Sx21+ZqQPIy?=
 =?iso-8859-1?Q?ze4wPDfsuQ4vnZkWSehgoptZzDkiNP8to3ODr36tzq77mY4GVShe2YD+nc?=
 =?iso-8859-1?Q?yKoY17TckyssieM2fle2liaxGFPpjY1ga6IwS27DM5e3TmmqNuyH196/27?=
 =?iso-8859-1?Q?58k3mgjr5kZWBOSXc6V/3Sh2ATX4p5J61ENe1p2XJIzPJulW4CSJp1PrEC?=
 =?iso-8859-1?Q?2XUrJJhwRB3gEX4Ewd0CuLsbyc+oaDgWd8UvqKgFZIqMfBU43MUa0rMkXN?=
 =?iso-8859-1?Q?ys9ZOo91d4v5tl+c06zjvr1nvaTl+SJElmHVwJQ54jUYkbXi25PNrm7ph9?=
 =?iso-8859-1?Q?CuSSH+KHchjJ9XJKclB+RHA8z88/m+R6PlYggGM8ngT1hHC6J21OgrFYJg?=
 =?iso-8859-1?Q?zUNq4tZH61P94daxS+i5ZuZYRuMaY+zqCKn3C39VrcEOT9NEl9lQoFj0gX?=
 =?iso-8859-1?Q?S3tPaD2baBYYjK6kXOphhiAzbMMUjVuo/4MOsM1Jv0Ym1o4jhtGSUIPH/t?=
 =?iso-8859-1?Q?mh2Z5yFeIyHLVN+uXPZIeQJSN09HpOOSOcZS1+LbXs0R0i4O8NgKPVtn4W?=
 =?iso-8859-1?Q?9sgILShEBdp2YapC9GZoMmqzUC7/deXyZ7K20m5VoB0MsXTGhOUJAUAgZf?=
 =?iso-8859-1?Q?GMnpM4y4vrLouFW/SvCxZt/iXBDB3ulYb3q/kXlJCpcA2pefdSZqURRmAq?=
 =?iso-8859-1?Q?9aMWUTzTpSI3nBrSsPZ999S+N+5JGLoaT+wR5MZ7nmq4izgTOZ9a/mVAHO?=
 =?iso-8859-1?Q?gIK39X0zd5t/WSLK3Nny8nEbeYR92R8XbxVx3ib5cnRkiorvHg1C1BTAU7?=
 =?iso-8859-1?Q?ZA3vRKGbMQm2pJPKF2cpWxA1ngkbIPQRm1V/2uHNJwpSOdyjyhlWl+AKO7?=
 =?iso-8859-1?Q?YwlCHHvyqOa988bugXqDaweBRPyapscRHlKEund2hixcQJJw/l5qkvXaEq?=
 =?iso-8859-1?Q?VUlK35q4Ts/O1jFz8xWL3T5Gw6dyhhU0pMq03oD2ABrzDnPfs72a3L00Iq?=
 =?iso-8859-1?Q?sEkFLFGhU25MI05LBxXmbWBtIzyrXb21Pk2IxYN6VeVTIxFdJDIxeG8GgM?=
 =?iso-8859-1?Q?O2eVISy9E8LnOPTyUrhZHKlxvcudF31f32r4NESLBtJWemLa2WTYGIvhKZ?=
 =?iso-8859-1?Q?dSOH8kPbAIfCXKR1xFsDCSLz9dgJoTS7z9fqHIAzhl9AkESxhto2f2+W6Y?=
 =?iso-8859-1?Q?FW0byO6Icm5PnZdmG5x46EmS6W/EhWiyM6y/B1m3n2QlLCTuETcRBZluAG?=
 =?iso-8859-1?Q?E9ryJT/3tNFiwEs96iSNqtFYcGiP1DFADJHVXRbPJvKgQYNtZ+i7hMt8cy?=
 =?iso-8859-1?Q?S4lecImRmjA94bdyUidwks/q6R/bRck=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e8884c-b525-4b5b-149c-08d9ed459b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:02:26.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9GxnyWtfyEC8SjjdzbziujfcTf4c3/WnBbCutQQ2v3he+SDfj99xhDY2fTFZhn8FkZEZ6X977M+CeEyRqd641ci81j8k7Vyz8qKmIpTxeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6760
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/02/2022 10:42, Pankaj Raghav wrote:=0A=
> Zone append command needs special handling to update the bi_sector=0A=
> field in the bio struct with the actual position of the data in the=0A=
> device. It is stored in __sector field of the request struct.=0A=
> =0A=
> Fixes: 5581a5ddfe8d ("block: add completion handler for fast path")=0A=
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>=0A=
=0A=
I would've preferred if you had put the trace and steps to reproduce =0A=
in the changelog instead of the cover letter but, maybe Jens can update=0A=
it when he applies the patch.=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
