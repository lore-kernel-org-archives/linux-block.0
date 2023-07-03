Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65237EB64DD
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 08:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGCItx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGCItw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 04:49:52 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7F93
        for <linux-block@vger.kernel.org>; Mon,  3 Jul 2023 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688374169; x=1719910169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kRr+6vosWNPCNSl/+U2mo96hm+Gm/0kv0JNRxX/dj+w=;
  b=Ddq5Oed9rNx6b0Ps926Zskchp5sQSXDNfJcwa9XucsSLCgFUAy7PK3mX
   Tg/+U4bDCl0BjbrXB8doF4+nJsjpPixNbPKB8P6bxKM9MRdMdHSvJopw7
   ja82HHpIcy5W/4SqjhPVNymYw0Pm6t97MWGDu69OijDCEBXTiYS+xanD1
   utd3Wlpxc5TpEPFm3yo4UEvSzG45CQuovkEdIkPKlo6y9ghKVEK7HLkkm
   HThdMKdOIFysWkiFqSDXxEyluPPIRMUdLacylhucDWDz+S792wVFVw4cd
   U7UHpQGyJIWGJQBO5PJaQy2flR1ndSTMDHMgZOjd3r7OuFgfHyVI6fFO3
   g==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684771200"; 
   d="scan'208";a="236790499"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2023 16:49:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMaFMcyP+QG7ua24aM1wX2oG0f0AHC3Spy1jVKe3HzSvkH8MVO2qFG8fjbaDc7igehe2rp/5btPrzP6Hm3dHY3KSttsBCIH2GyC77F35yCJ7Nj4U2MBbMdv7fZv28mlvULWIboy6j9mM9Ir1wwrZbG8NkKzkWoWcj++e29Y75RCZBQijYZivugf+FJ+w6O3grMQXOAvYFbu02UVxaSaj2FaZaDHlQ0nXmn110Wx4Yy/H78poWQWjNEDrF49Y2b68SRHRDKyiGqNF7KmdHVbpytN+JXc9uatbBEbtcEa5NK7cJGZp57CCFHSMKS653I8Pit1F+Di9yEc+cx9Sm1K73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwg57MXQ7ejB4kl0UVmWP+q1/XSPNoIlhMCJCfJH90w=;
 b=aKv4lk3fSZhVV5sOAg6BUyEzcu2rDTD7HoX1rc6yl+7PUe3aQuY6TNGhhp++pXW5sUe5nD9QeSHgEU6nbkuDStc18Jm+EPwRrFjgnUEByaL5FLnn1FJrX1Z2aQSSqxjq7g7Y8jNec2yuQ/kUXsjC1hAshMFs5LWm9wKbaN+iXlvHB+mB0R8zpQ48/nbQhflxrDYBj9owJfJ5tLIRLdK6pOMY5mqRf0pnHeaSCv8DUY0KbM2dZmyUmG0vFGG3GyeQzG952/tSJ2D2XYdbdOMKxQIHPHoAuZ4/oyM+SS/aP2XV4CG4Y4OIx61gDFIYPHdv5/8Y4ArACWqsZDGByTR7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwg57MXQ7ejB4kl0UVmWP+q1/XSPNoIlhMCJCfJH90w=;
 b=GQbw7O4hkQQqQ1o+KQSnOeLYmQVinU9s3xxtoY9Q25aLVk888IuL8Xwd3J9BKzBoNZbjotZxp5+XSlA4QSM7ZW4IY6188uyVkZt6vRxZqP+9liVXMEjqgQ6pSlzFBKzOjp9m+H7ubZnxwP2Sg4LET88mjSO+D7os2tvZaLUuBec=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6319.namprd04.prod.outlook.com (2603:10b6:208:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:49:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:49:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests] zbd/009: skip have_good_mkfs_btrfs when
 mkfs.btrfs not avaiable
Thread-Topic: [PATCH blktests] zbd/009: skip have_good_mkfs_btrfs when
 mkfs.btrfs not avaiable
Thread-Index: AQHZqwa62Hr++jXvcke9+EYLQ1lxOq+nwHeA
Date:   Mon, 3 Jul 2023 08:49:22 +0000
Message-ID: <62hb54sw2c7ckzihf45ryvhimtlenh6a5j7ohu3fpinpru265u@p7vtgzmu75pt>
References: <20230630120028.2980792-1-yi.zhang@redhat.com>
In-Reply-To: <20230630120028.2980792-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6319:EE_
x-ms-office365-filtering-correlation-id: 2ebddf02-54b4-4e5c-f48e-08db7ba26595
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PtArXi/JHK9eDN/neeKUXx7CSTR6oz3w0fB38WJt2/drG81LsyarkG7FmBfN2fqoVgW2PTOhJlnkstvgf3XiE6GnAJuRwfSwuwh1PcMKf2pawrMyPWha8IycC8VgL+8Q+0AkXZmRzC0i+fO+trTLUhjtkcefAnYCm+9hVu9Bd2/cVYHmLtbSjEX60gk6L9QdSzDYWvNS3uaFm2QOKF6yPh3939Q/PFXmGRBOZfK55ggzUg1wFL8Osq1Key9BF3Yl2aAGVnyRBu7z2mZ1Xu10ukqDoLLMBcjUzzTKvTXBo6Njv7Tdm10cVdMBffSUvIgo0so3oUX7KLnwLf6Y2eg5gyg06jypsrPDPwVzSpzaS2gn2nkRRODFVxhcJyv5rPZoDn7Ti+2yP38xfIJxgeo6yKfhIRZPKQIVN5zji1tJBKW/V/WKle7wjwsXNBWVW7ffduFMFcTcQxb+EUG8HVJsfA69Z3v0Q+i/sS6vbKx4ZampPxhoqo4nAGZMGCHZ7NEYevrZCAk3+lw4m7SOnUIMX541LLQQbMTL1oZwJcVAM6Vdkr4KWrn1Cn9f6bCCZsNLDM80Kivz4S4QSm3gbgVEaDNfjSW0aBuu3hj1JZte4VlulepEqRt+Z0ZoYr+KG9a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(38070700005)(4744005)(2906002)(41300700001)(5660300002)(8936002)(8676002)(44832011)(33716001)(86362001)(186003)(82960400001)(478600001)(26005)(6512007)(6506007)(9686003)(71200400001)(6486002)(76116006)(91956017)(122000001)(316002)(6916009)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vl/rf37gFWFG283fWjYYYYBmrF3qbEzdBwAXT1lqYk0S+r5xnC5RDn5s+iBt?=
 =?us-ascii?Q?a4oDCBAXgMepruuVAxkhv3X8xNXaHJxHrldymJt9eE0bxbPZ5Q98oCy3g9S1?=
 =?us-ascii?Q?13lzio4jJuoozLbnG+oKaTA4N65Ipik3C5AI5cyh7tVk7vywMiggSvUk+vw0?=
 =?us-ascii?Q?hkj637LCx2nfwA7LtzQcWrKLJoUEhpv2CUx03zPwiVKbO2Oq5z660oRHkU9i?=
 =?us-ascii?Q?M8Ysoaq61yJEU36OWQXng1SBw7YPiAIza4o8UTm3bGmv3WCRmxEBztA3JVjv?=
 =?us-ascii?Q?P+GwWnrEXr4gUrAOqUphlee5z425/WTutlHgzx7gC1fv0BDUpogqqK5CEeN6?=
 =?us-ascii?Q?coSAPWUE/9U4WHvUK9VvtQbVa/yfgZ2qWsJUcYceUDzI6Kb7yu5clk+wJSWm?=
 =?us-ascii?Q?pS/eaTlc/KeBl6jMxUXruGey2kVHD2TVszvAKqXc5XbYhRfWUdjDcdjNyMFJ?=
 =?us-ascii?Q?3O2uVOimG0cGf6TG73xXwBKFaa8+kkxbXLnFFo2hLz145khFlyxzSqKvfJSq?=
 =?us-ascii?Q?7+XCzEcwXAJag4WZ6gVz//+dCt5XejBr9C+nHDScpLo+Vj/CvAs/+TZpj9BZ?=
 =?us-ascii?Q?EGyzcKh2+5nLghITX+7IHETyMuIALuq26NyuecaoFC+6mSbpKEIgdDzugfMx?=
 =?us-ascii?Q?B+A8PtyCdMPIFw+pmZmQ5xRmK+aY5EvPhqwMpQ6PeiYZ1IcHTxZxsX08ATDG?=
 =?us-ascii?Q?znW/p+z4pJalhOnzFq1/SbbN3z4XMKixtJe1+LSSJiPnLZH3URmwwbopR/DF?=
 =?us-ascii?Q?JCJrUk0gMTQfmev6DXKm4hwbJp46K2AnQ0NNhuMvsoQrWcINBJ9Widr0N9yS?=
 =?us-ascii?Q?3Hh+q0NZ76vYqfiboUYoHePVl8fYvprX195Fc/kmUZJ7efzwv4m3KZu6UXXh?=
 =?us-ascii?Q?1CR1JtXpLfplt3FQoL8WtH7n0Y9agbrecawpKDnz8ZkG+QwxGsxDH/KGmD0p?=
 =?us-ascii?Q?EytPjq9fESGedE8oAsUzRpS9Y5BvDPytmrti9omEWLKcKNoA62ke/Mg49L5p?=
 =?us-ascii?Q?XNAdXst6SE1UPHdjQwqWgy+g071+Xae0sH5aPkdDT+xmiAPKsWzwtnyrvdrz?=
 =?us-ascii?Q?0gry3XcsNRI3Jvx5edlWM9WWgUr7WanP6+TnPYk+WsPF4AWfXGQqS+bebvQU?=
 =?us-ascii?Q?I+o53SDyPI6xuJZGklIxs1McweKhH9Q9qOs3vAZ/Tp/kQYGw7ysITBQZWgoW?=
 =?us-ascii?Q?JkME4zOzhVXH/G+/jsKzlmedkwTNNRBp/6ZtgAeOa+ft+SGkNlg0uaTgA4nq?=
 =?us-ascii?Q?ro/VpJu/4uNyYHgQSbWEQ051LIUukRa6pM4R40OcLZJG9aCTQKOIpjUJVAOB?=
 =?us-ascii?Q?hr7017xDhVnOUt/ZmssxWPB4LsZncMza/l10BJq+A0gFTbcE4hiNMT5kaBIc?=
 =?us-ascii?Q?QegV8KIBqET8VQdjelLa4Ejqj2cQtq/zbria75XkMrX8A9gsaYTvU8+2uNIo?=
 =?us-ascii?Q?J0xyFJ8EBFnHslh8OAjBNMC6dHM+jLULB49WsgDuBInNIHEiOV5OJj7Vxcsh?=
 =?us-ascii?Q?pROz+256SMD7p2YmPXqNgn2FSEV1bJhYKXHT0Scb6aC2ee0S7pG/r1B0kH51?=
 =?us-ascii?Q?j+Ff7LKf8c3Yicw0r5SxQQR1rx3aV5jsUMTfRoKxX3HPdpO+VN0RiFGSgdpz?=
 =?us-ascii?Q?DiaiO8m/dhJ/8FMmiKhA3KA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47D30BF36C0D2F4FB62EA573A992A605@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q2p1xNjRYeu7phINq9yEDlU/+mbiMdrBr1ft138C9APqrgSXni+KifN3mlnbVGB4Xx267af/OYVDNW+X1dYpIc+W4gZFvK9bHvRz2Se3EZoU+VqfKVUELrkdPX7rEZDUxihk8Hvq57IdkP8fIDr2nkofNkFhb1GcZ1JEKDMpLemiB2UmDCu6xTymvDG8oK1I8Q3jYSNg/byWWh4D66UJIb1gmImnHZ25LHhuLQ/y3DJqZdAEJ6kn4UyychQeC9rVCP7hVu9CuC6TnB2pV1CwvYkmyXJY8IvLM2+WgB64OBsoc0qNcJNddd2+7AYm58S3nBi7mwCoebY700XLMXSUUFgv/2lPwXlAi1iFX9VxZWLb/2ZMXhWozprxnybY7gX/pTgT1QTVxBbHIw3/xZYFxAH95tsDexOTPm/0jpRAVlJdtBU/Uv8GrVtvAf6yBQm7rIHKHYQTIq0bZG1V4yE3x8Uq2Tw3uE+pDCYK3NYtzmCk/DgjOJSU+DgiAREnNer9lal7MzzyHu6p4sC5/+O3Gxw6X5wn0XOLiYoZwPoRvRpv6hyd0OpRXWhp/xZo44VZCktkkf+WjMrgC5UHnnKVgbHv1okh6z2SP6DAVJzIpkW4nAer9i1PRd5X54+EjpbXLPI8ACt078ZNFWwtPYc8o044UfS27M/HrT47gMK8CVRlsZTT4HRlQvbK7XJP+KJez5PFY3/fejgVsHMJUoZYLdRtubM4Mp41+Zkopfao+LvOOHNnlYAR0NdkQD3/wvvDivaQuBv/upGcP+KHCT+8KGWF6hNVQQxfxWQiadlYNN3Ry+WN4X5wObWgJh7l927rDqB5Wa5QrZXVpkAvI4LZvA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebddf02-54b4-4e5c-f48e-08db7ba26595
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 08:49:22.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8fWEdyV537Uydj6MneGmPgWbng8iXuPuRdb5grbaihvtexw8wgRFTm+gsgKKD5wJFQKbuU4upcVpZrO/WejJY8lRadd1O/Kk9m2D7Sem38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6319
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 30, 2023 / 20:00, Yi Zhang wrote:
> tests/zbd/009: line 24: mkfs.btrfs: command not found
> zbd/009 (test gap zone support with BTRFS)                   [not run]
>     driver btrfs is not available
>     mkfs.btrfs is not available
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks for the fix! I've applied it with some commit message improvements.=
