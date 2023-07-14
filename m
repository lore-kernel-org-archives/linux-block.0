Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10505EB64DA
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 13:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGNN67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjGNN65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 09:58:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE0C271E
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689343136; x=1720879136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rmot77ZYRUqqIjgQz6ugbdYpx5tNx/UGVX7cfDynHOc=;
  b=Re2p4uO80aDYgn/hiyBUiAQz2GnocCPJPQB90QFIPipoBZwwhXSE+dvS
   nw3yHoj+7wRbxAQwK724JdIbzjx1O5DedZWVM/Tzy5wPQZxE/AB61Jl8X
   j4WCN1vGjYywaaOdNsiD2kxab2ef/8R3Ud36B12hFGfXxcpoQbTYc1Ccm
   zxUuElbsCDvoTq8j/Q6GPSLd7fiu+O0q8qD2nKknQZF7Rj+sv3aFNV620
   0v6YHX0/RMe7shi9OCNKP2csit8x3dlRjwGJw7GxQY/lw/5wDPUS/l8KJ
   EArxp/I9beIdxGWRUHmbujZ90rQ4Nh/3+30XXvSIYNXzeGGWZOonqWJti
   g==;
X-IronPort-AV: E=Sophos;i="6.01,205,1684771200"; 
   d="scan'208";a="236411393"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2023 21:58:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ/V3MtN9GsiZwOR5Pme+8Gr+eRtC1WkYqEtsQVOxjn8bpJhlRYFNYDBagjVH/sgTenNvRAgWuAE7qTQ4zLB89YdyjNLhr44T5joDvfpaA+mtSOnfotlwPOZjJ0h0BgOD5ObTWLyeHqOPQHoXQ1UJq6QIBfw6jQFJclpkySdh5aL80Q0JkzQNs5IE1/XzD4hNthvHSiztLQgDcTCnPEGVZ3Uh2rP5P6GCr715Y+Y7gEn3T+xrQhTgEqhl7KVUT0xucIQPbsbgG7owJO0GVbeZOBS2KoH8tuxgWrjwIGH1n6Y50DUQE/gWno44UU1nu9COhZ1oDT7UInma5ki3NbmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmot77ZYRUqqIjgQz6ugbdYpx5tNx/UGVX7cfDynHOc=;
 b=mnbi20uwEALM7X5TPS/mYoJDu+BDNauCZCKYyYzKgNRpa4PRvDgqgqZS5HPYbQku5MqeQld7ZbVBR5RNJMP5TUGi5X3u3YpvIhq8MwNZ6F4C9H+TT9uqZ1DchqVIqlENUZmO/9HehxUdVK6hVkJDMMq/+eJfNNBj1Z0aAo6JrFh3+kvwp/0X7lbE1AtsAVvIpjs0yfLfnxm7R9sYRgaPBbQG9nOoMULMTJsIMzKaGqF+jkPxwY4+TK2DrASNLqPCbX28CPRZUkvuh4uxJpQ0CUYDoet+YaRyoE28aevbNvwwku+xKYmJ0OyJ6Jh6J7cWcLjow7DF61ONsIQb0rv8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmot77ZYRUqqIjgQz6ugbdYpx5tNx/UGVX7cfDynHOc=;
 b=pW4OmY1Sh7bpb6nm2kreHpeTQFKu+iuEQyEy/JOOV91hmrQzJ4JdKHZB7Vy5PbDqyoR0vL9GHahzUG72e+AwRE1SORK5LhCdZqQ2frqdCqCzSeYI8Yb2WCfE0k+WCWhggFxtrWJ+p2qRRvSM5qBLaPPtb6GaJJkA/1z/uxojJXk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8713.namprd04.prod.outlook.com (2603:10b6:806:2f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 13:58:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 13:58:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/ublk: avoid modprobe failure for built-in
 ublk_drv
Thread-Topic: [PATCH blktests] common/ublk: avoid modprobe failure for
 built-in ublk_drv
Thread-Index: AQHZryxt4wu0Hu5SJk+EO9+IDJXFDK+rS0CAgA4M+gA=
Date:   Fri, 14 Jul 2023 13:58:52 +0000
Message-ID: <en5jujsvg6iazx4xhiruxxbnxven2dvbtthohjjzdtlt2domyq@3rpv5qzk4hwa>
References: <20230705103522.3383196-1-shinichiro.kawasaki@wdc.com>
 <ZKWLMZ2+bBeIofSr@ovpn-8-34.pek2.redhat.com>
In-Reply-To: <ZKWLMZ2+bBeIofSr@ovpn-8-34.pek2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8713:EE_
x-ms-office365-filtering-correlation-id: 5088e0be-7a57-4418-5188-08db84727540
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdQMapuy7Fyb6gC5zK9rWOfg9KiFvRZMu4fWmhVc5spb61+B711uTsXVQl0gaJd4kUs11lU2nid1Pcz6eQf3hHsJflcHK7xGtrM4u8IWdEBM+iOeICIjezDTKn3QZyUP6bSJ7nz8mH3FpnQocFMnP+ICDfhu/HGEHwj18u2ExoZZg431vkYCOO3XzvTHxjA6JC/pKEATGThJm7AYPQBYMmeDdqKyOXeVm5lGi9uXfHKm2YO5ZBWeGOdSKynjnCHdFCPb1K9Sk86oZQbt16kOTI8gk+Odfe/w4oTTgSaFDONZmvToICwAjkdJ9qqXxDOxot7D7Zy530+dSoaPfnne7VLP/qzp6iDpkLsUMTAFaDvSdXQ8u7m4OBm4f274PY6kvwVNtQJzV3e8szxmolDkDoohELsRqoHQw1tZgbV3RDo1Bg+8JcqSjMbxg1tir+svAQB/a5qxwcVkLjMT90cW87HbNRGfzj5nsxrdvfIkukachKqa/nPgSheBgFVdv00eRB7RMhTmOnb3CQh/fVW6lSxp1HtDAdWc1vVpAxKO6p9fxlgP6RSR7tQdKnEH6rQFX86yOy77pYMODCsjlVQ4DLUquwMGey1QdPRAdnVyGTO+9DHwbssTBcuXfMs8wABN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(9686003)(66476007)(6916009)(76116006)(316002)(66446008)(66946007)(66556008)(64756008)(91956017)(71200400001)(4326008)(5660300002)(6512007)(6486002)(6506007)(26005)(41300700001)(186003)(44832011)(478600001)(8936002)(8676002)(558084003)(2906002)(122000001)(38100700002)(33716001)(38070700005)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R9Bhmzs0vj+KdxTklm/c7RMmb5Ruv+4JVSeuZqaONWa7C7dcTNqvkthS4XOm?=
 =?us-ascii?Q?MW9dnZK+WZ6IpjJo/l9JDjkk/jcqdwK5Q1zNI0QAawku9d6lfmak+O/Tu+9s?=
 =?us-ascii?Q?PTrcNCAA5IGA0g/StFJeqQyfd60FoIN4TBekIjNqUH36DiXu+dwXS+/JYlrr?=
 =?us-ascii?Q?/T+wGZxIqp3ahkPdZ3NuOeiuBV3eMate0FV7ZlqhbrWcpeIs4zJJogmJOBAK?=
 =?us-ascii?Q?dwLLMJ2bjFBbeTyZwfoojAX1rCoPJ6MfPClBEN4qtubxlmHUMAu62uGAuYVL?=
 =?us-ascii?Q?PEwzffXExZ+T1HQr1xGHXWGFSf51tdms2n5/9tBZRar2HQIv3kolIWXCffSx?=
 =?us-ascii?Q?bQP7+0FtTsz2wp7XR9FhUte8RUH6Ld25E6sqjTnajb+E1ava3iUlEAOqPh5d?=
 =?us-ascii?Q?poPguK129/c1jPBSLGdev9VyM87RNNZhOkZ7gn+6gcWxQFpE1fU9CcsuaHRb?=
 =?us-ascii?Q?gbV4I9Udj2RUfVXE9DPbmnxe4HSg+XND1A+qVNiplKpanYGFrs/BSQMfQm2L?=
 =?us-ascii?Q?vSEIpevSX8Tv/ZN2gC1mkS3nBZM/66ncLn88WEYgm80YN9U1pNRtQkdrVWDM?=
 =?us-ascii?Q?NLke23n2IdlwvKtnJf+Aw/mYnkICPGfN5AE4UBh6vQ7v1o1EU+QDuf3eBbXh?=
 =?us-ascii?Q?tRr67HeiIgss4LK5GinnWq0CrkRybjOpUvI/V50sfoW13Tyd4Coo8mobylGj?=
 =?us-ascii?Q?9Mzyf5nx4wyhTIQmE/wF7otjO0w3GVbzAroMBYdcCDqM74db0zUWHijEg/rr?=
 =?us-ascii?Q?rxS5izmiy7qTiNg57A7BebAKsRVNC6+kHRpfBp4W2xXS5GjcbPdckYOQikq9?=
 =?us-ascii?Q?1RO1iP0CAdBnjDEunl1fAOjBjliYXAvMkKVvI54C+RAJdlUdwOqURx/uo1kV?=
 =?us-ascii?Q?h8n4xBqIjF66E4nYEX7p+P/ar7+SYxkFN7tUW+Abxe3M9lzLuY4Uc9AmD9Ex?=
 =?us-ascii?Q?wq8R1HH1OO7D/DKaRUMvq44Lwp+FBVa/DU/umRXpEwzKwKvvpO8YA7cnXZK0?=
 =?us-ascii?Q?gec3SlmpGJodVF0FRh1S7oBk0PEVqXYaX0booitlozp4xudR5GJwwPO1F0kH?=
 =?us-ascii?Q?2PERwBwP0piBMTeToKnoh3dDcwmV0BoXbzyV1TfRdr8S6KJa4wIvhHEXV8Ik?=
 =?us-ascii?Q?by/gzvnh9X0h34Y/lgllSPA/ixYZV2UTsM3xDUgNFvokuP8X0kk51glr3xaZ?=
 =?us-ascii?Q?cgcVFMybmjYWnOq/PeZDfCUjnveXagL8jHrbuFUqqnIITU8wpXvODR/37fuJ?=
 =?us-ascii?Q?hiNDSn4YgnxXKbHQXOvo8Rq1hr4sxAoXx7KwEu2m5lT51a8plDxVGNWlTEBl?=
 =?us-ascii?Q?gZs6HlEXQ7MS2Nts8bmaR4O7SOIBpBT2KRhg360M1u+vdkPGWSG4AWEk2fiy?=
 =?us-ascii?Q?CSdh7AmlcCHJqZaqkQP2zRWiZU7vBZ0i6qDnhB3dMqbE0uhmCLen8NnVcOtG?=
 =?us-ascii?Q?WEs+CUavfIzilvH05ymYWJNul0i6NVOfIWSgBEmx4/NBFWGYeGXsG+PG0Jdr?=
 =?us-ascii?Q?Rrkb5n3nx3dBgdC1a451twjoDUrgPfZAiYJbkmCjNYXzKlADpZIJzPePDlGR?=
 =?us-ascii?Q?NvSy64cYYQFdKSd8tQow8AHMzuOa03G846DOxioiaIRxjcp3y+y9sDkVpAg2?=
 =?us-ascii?Q?1GWAFkzq8SB2NsbmEBbdSIk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F288F9C86BE1264E87AE2042A9B0FF91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E+7dVSvXlch2TVP0YO5WsxBNIwrSxy1vyUvCozSgayRi8Ps1WgL2B1w4WPRZy3RrhywwNnirtbF8QQ8cyjt8k9UNlb7ekxDtI9GyxbNjEAckhKxMw2Zd0HONSKiZuljk08/gPHhSVND9BnPb4exmQdjuEFMCyKwtChtLga5tPSvf7Ux4h2094k/XqtUMeubOpVh/aLnMAfXLIdvmVIs9ggLVh63OVklL4jWLtBO5tveflICIg2mjOS09EDB40fP+b/H4ZkRpgvknn5ofhXpjVZv8SRJWQPN/Q4y+MWoPwwZLzoeCP7lTaTVIM0HEHellq7HqOOVBqxT8fXRBTk8vC9Z2M06obI1jvksOR7wWcwdA6ehRqlMej3R2IlSR8VUzdOrHFGdYpinDu5p7xCSOsckPWs6s0DCnYCSwb1YiTeqn92P8VknvNBGXv+1PPDJ6NrhR/n7FLPMkGNjiYlsBgJ7r5bwwALs2v0+dkzgbWHNbkWY1kRBoBSPFz8TCgg2wj+ihTAktNm2JJ5vZaVJoXVcWug7ExxzKxSDmKSU08xDTB++XoQ/CVQtvnmsZbw1jEr0aF29q7+m35HPe59hxtYs4QnABHsTepYwlw1wmFL4T5AWRf+qG4usVcGwHnS1rdInlE9RKnpq8E1el0CtT0FEo7ft0CaLO/x0HPms5aERkJkE7Q9611cIJM/syoNq5USy15BV7avC4OaCehr4hg2Ii+o76AkSBBA1bomY8B83aFt/hwJUoW7ZYpzhmLfdTqt3LPvWibq32GXS4kgKs6VR+auCmaL2Zm24Elk5UsK/Xz1fcdjY/7qSUG6ovdpLu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5088e0be-7a57-4418-5188-08db84727540
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 13:58:53.0912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkEEcM3ctuEjGG3X/GCXMuIyY1Bs2+uqtYz9uBI/ykd7p8IkS6e0DEBMmMjJ9WI3LsTxkAYlmwdMh1WZcc+bDdlDdI3fpB95Oun69EbBYKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8713
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 05, 2023 / 23:24, Ming Lei wrote:
[...]
> Looks fine,
>=20
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review. Appiled.=
