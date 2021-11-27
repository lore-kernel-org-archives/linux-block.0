Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA4C433EF
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 02:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhK0CnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 21:43:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45545 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbhK0ClT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 21:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637980685; x=1669516685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=keLWOeFa78lyRylinuI7DJyw7hsAOmJEAiHlERlH40g=;
  b=X44WGLpDQqMqwwBH5ll4YWO3L8C6XXN8pkMP7irSZxWoL7H3FGS+PL7Z
   fxAnZjJw+P+suno1ZD71GiQT2IreHiXvje/9/6PG5rbmNJTZ1Xep3f9s5
   ixBs57JIubb1dvTe5H9E66cPGe0A4/HUx29ji2KU4CMAg1V/KWv/lmjuK
   IaWB0BCa8sFLT0b7HSku6hFkBRbTnGAN46odYJ4aXKosH9AInZXRAK4Hi
   y+FlfHrgJ46kHGjP9HzrNX3VKwnbyxByLn4C/qMEz4PgzUbYyP/CMqQgl
   7DfBJZgVkhHSqC6uBzHqWDtnQ9UlGF4vyiASM3tfy0R+KH8HdjipsClTs
   A==;
X-IronPort-AV: E=Sophos;i="5.87,267,1631548800"; 
   d="scan'208";a="186787882"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2021 10:38:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBDnyML+zS+Ex94/H9BQkNoIQnmYY70EvN6Q/sG6MlEU9dC9RKRpg8NJOePb+5HsHjbhJdxlvWqO8kB1qcSDokFqjRvuQMoSfb7rIhalZ81UxEatbOJUzUj5taN9VvhSGJ13t6YOUvRbBrfyhbYObb3JASxuO7XRGHuygowpEbCOpvvKn9v7g8rSRvL06wOKH7asuLNex6VjoAimlBMx0VGLAIdPjtz8+nyKBvgnigTCTO3541+e1M/DFb3/CcS+1vhNBUgtYefsxiROQKCEKUdtjwid33bjTFxUotaPhhJRuJd3OwW48wSafALpcPrPFH/k73nwUerQ3TmF5CxjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keLWOeFa78lyRylinuI7DJyw7hsAOmJEAiHlERlH40g=;
 b=UBUxcsZdY+OpimHpoYB/41sxTbulZr1DZ2qC9zIbfJ4w4hBA3TSmJ/cozllZpgURyiiquM5lBw78YMER3tXJ4a+C0lEnb30kLgJICFCBGbCog2Xh5I5tih23Ir2j7AeHpYHubCF4j8Mvwiumerl+XoP7Y6KoFmcQI2Qg+0ecF044xJQsZFjYXKcILjb99tEb3iOLzXwU7QVfmjVeQ5r1L2PgC2mLf4NSzXMigGRn1XeIZbQP2VDPBDOcTfGRfHzmtVckFE127XOZX00lEgCSmMQZ5YejNT486HAfSnykksWvhrJtQCflvGVEeMHQNrEQKslVk9Gjbu9pnQhVfOCw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keLWOeFa78lyRylinuI7DJyw7hsAOmJEAiHlERlH40g=;
 b=cK4kCDKI7hiuqJ6MLmH54pRIh40sEBsy7X8ulTxVMKjzXcq9dGALH+cRHxfYrbMtOHjRyu98yrv807fuvdlPd3GvgnFLXwfrCliuE9uKR6VOzAFmw9dIQ47O/m/pY62t5rAqyL85KA5vsDwhMSLWWhjiBwkwYmreKhPu86auVnc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7895.namprd04.prod.outlook.com (2603:10b6:8:39::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20; Sat, 27 Nov 2021 02:38:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e%5]) with mapi id 15.20.4713.027; Sat, 27 Nov 2021
 02:38:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: I/O hang with v5.16-rc2
Thread-Topic: I/O hang with v5.16-rc2
Thread-Index: AQHX4quF1d1OnS15AUqhFGZLwogS9qwV/ecAgAAJqQCAAKKygA==
Date:   Sat, 27 Nov 2021 02:38:04 +0000
Message-ID: <20211127023803.ytrqsde5r4ydqn7m@shindev>
References: <20211126095352.bkbrvtgfcmfj3wkj@shindev>
 <124f86f8-91db-3a02-702d-5c26b22de107@kernel.dk>
 <e1b65eee-e8c8-e98d-d2f7-5e35eca46651@kernel.dk>
In-Reply-To: <e1b65eee-e8c8-e98d-d2f7-5e35eca46651@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa7a23c9-9290-4458-334e-08d9b14ef051
x-ms-traffictypediagnostic: DM8PR04MB7895:
x-microsoft-antispam-prvs: <DM8PR04MB7895E173283402A8102415C4ED649@DM8PR04MB7895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZXqA+6+kAryTbaDX7gmR/fruFL9kGX+JlbHw9B3zvKZyE67mXirFZQXT5MB/CAU/tYxSK7NoefL1A7/WD9XtRLLrlGXj6s2PGjNvo8+INJJD6Lg9Htt2T//cS8Cd9Ulhkwi71xlCqqOTECYzuNu9nP/5xzzcc2I3LiDn/PFj6VBhLVe8ShmKVk9ylHbQ86jURAe+Lr69jlUAm/WI6tF/6fCJUk5rCKUlSeRLdOR8Zpn+IhQcf4f72vGJA6lf5tJJ/LW7g4CR/I3YQhOiGF0HP+r1cSH0KoMju8YBEMoEpopUoWOA5wbwB0G0s3IymxRk3oqmsvE0ep2vn0GYckzPyGz9kjhTzgT8BO4vCk1CYnqwMmBVSgxCMoz97rIGDz2f4nqIc66WNzB3PMIc29VrUAYbznJYudI3Zr9Hx3Do831zLNKoEFC+x9q3zheXYDfnaQI0ADUZg4BvDK/pQESTUnyGgrJQPxm7XQXwEHCV5fpt+QnFR4YQrY/afvH46978+CU7NEEwSK9XW6Ykel5qSWQ2KtJSwRihI/1wAFBLCJ1rPuB5V6NXpZIpjCaSa2LuP/HQvsuJdvaaMvLJKKZDYFzmKEwozV/4rdxxfagiV0kggAALJKBpL3awSvNixlZslS+DqtgrgGPOD3IHX3EVS0B4sRJQbV+UDfWmmYISwnYTXE0rPThUdlDM/D6YNuZBkiaZYKJ5k2K4MZwncJNIyFNOJtm2LeO7Ke3t7lSrXdVEvXqug0LgX8B0v+GZNtJB8u+xkM6X0n/RLQN+G1fPnmIuKyFidRYH3sDyzMs2Lg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(83380400001)(66556008)(4326008)(54906003)(82960400001)(71200400001)(8676002)(66946007)(66446008)(966005)(64756008)(8936002)(6512007)(66476007)(1076003)(26005)(44832011)(76116006)(186003)(33716001)(86362001)(91956017)(9686003)(38100700002)(38070700005)(6486002)(316002)(6506007)(508600001)(6916009)(53546011)(122000001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mh5z5uhgkUcvu2wlvFJLIbp1R0AvlMJx6xoz5nVNbd0jxSgnUfEkuMk6uCaX?=
 =?us-ascii?Q?0fKKjgI0+oLlad1wYMWbXSpp6a34OCa0AdrMZDDtuXp4xVPwRC/nfIcpYwgq?=
 =?us-ascii?Q?Y2Uf+TWiB0RPTaJWZBLeoZnpAh/F/AJNVp6dupBYiZGtXYf4xXgGt9WCCQ7u?=
 =?us-ascii?Q?f5id5E3dRRY4sGPYZlwGzHITofOyCeH3Fj3k9iwktd/tLcGk+ESrB6dgIq4O?=
 =?us-ascii?Q?rxsonc+nI2fjDCPB0VvRpbeWzNi/qR93VOuATeU7IabRQtjPF2u5x64Y5E+T?=
 =?us-ascii?Q?qR6Q7Nvk+ivh1ifnvdOFPh2dybHEgEoD4GX+ghCVCy0CTOqXdQ4YhAyaPGdh?=
 =?us-ascii?Q?HjwBpZkjeAa1ApzUcM+Cyqa3rZazEl+QZtJglD3aDnREY86ZA0QrLPLd/4jj?=
 =?us-ascii?Q?YRS8notFQiFgoSyvFBAzgojNjUDAaoh67H1jxndp/cLtyIef3paXA6FCh4Mj?=
 =?us-ascii?Q?cfT37XehRZovdXTPgDCSy+64zA52KTC74YzMg9faVnzpm1+FDbYYJ7Tpd8Z3?=
 =?us-ascii?Q?+tIfAz88t/+OgaXvx/1JtF4CTGAF9d6FOR2C3scsvl9l4R82i7TFcUmWSRNY?=
 =?us-ascii?Q?aDnRBi/8NlABJj97cJDz3sjrztV30EpTDNwGNgoURO6o9BAVLXlmAFSv6fC0?=
 =?us-ascii?Q?6KqhZWIx/x4VcWBvJ80xcq9hXJYsn7l05RNSl3EX6cfZFdnzun5xfGdv+3jp?=
 =?us-ascii?Q?oiXnkRglYkkZY8bbMnUstTHsZL1FSOrQBnQbFu921TvpdH15xccOJn1r2GWQ?=
 =?us-ascii?Q?H/pAZcj90LIGZTjiIytim4N4ro9F/3K5kBUwr1nClSg0WxvzFOuw/OOTH5Gb?=
 =?us-ascii?Q?FssnLK6B7wtgRpbzHEaLqGPah7/XQuro4agRsz2gXLcQ22s/Zh985YnIOspX?=
 =?us-ascii?Q?c+uD7obOQ0jzAi/xGWAP9LpYHbKjTbCctYacUPXSSkxc/21sggPuy7AxYwUF?=
 =?us-ascii?Q?0clOln9aGk9JP5II+o735+IWgfuNjuvctwP3R0sSC0YprwGn+9GXz5WKW4J5?=
 =?us-ascii?Q?igfCvk0dF1AGEJHF5sNNMUwMxBSRgRn/VHJRongLMZhPNUb+FSis9rUMBH2M?=
 =?us-ascii?Q?92TQzNaMSCz7dbDgeD9Zj7a3nEndBQm2jhh23DzFpuBEX5NNURbJXJ0xQ16l?=
 =?us-ascii?Q?mbW9ezrvcYWiBWP0r7VuiOwu9xFVgfuKCeY7lfAnTFZD0gbngkec4jSONh5c?=
 =?us-ascii?Q?nq/W2waObiKxydqvqO2O8594LOpd4YIlw5PG/84C/vL5mF3S0ppxQtEOcH1Y?=
 =?us-ascii?Q?/AYrp70DMpQfzmHEnJoU2AWsfjD9HWMg5fcaGvaoiKbOPMNI2R9U6aXHxMHI?=
 =?us-ascii?Q?KmLMe/Xf6ZnuUa64h0rOveJ60OdaR8n8ksdi9OP2q/eWtPY3WysnlnNtYc3h?=
 =?us-ascii?Q?PBIn9y04httwVONL3IT1bq0hyOrUql1+ZHho4i7x1AmJ506B28EIzUbczp5p?=
 =?us-ascii?Q?cGKufgPfCURQFXxoxzitn/BOfyxAgWcLWn3OR/NGyngkwDAU3TwyX3QjZaoL?=
 =?us-ascii?Q?7GbfH/Do71UCXswZL18t3HUmew4pYk9rVExYJAR8fQ3RpOqbhDsJn2gxhcCl?=
 =?us-ascii?Q?iWUXrjIk3VpFoUhiCxXzXvLmD6Ptl/irBRTUcNEVehxYIoQ440K8Apf7X0yu?=
 =?us-ascii?Q?EkdHf4WDK7izDptOQZGzrKd9EeQq8iAaO1Mub6GZq7xZ+L7ZoZBx11SO+K7h?=
 =?us-ascii?Q?8MX3jo20kB0I2VAx1xVQ53zczh0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56A4BBC20ABEEA4692F2A83EE23A29FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7a23c9-9290-4458-334e-08d9b14ef051
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2021 02:38:04.5750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUSo7iDBlPKRUAr84hWcUYUHLTOpsGljIWXzwCPAfKguEe+5UOHn3uQA+4Kc0FIlhTwLZyMkrkbjNjNH5EbzXbUEW094ypqC9ad1I5mkTaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7895
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 26, 2021 / 09:55, Jens Axboe wrote:
> On 11/26/21 9:21 AM, Jens Axboe wrote:
> > On 11/26/21 2:53 AM, Shinichiro Kawasaki wrote:
> >> I ran my test set on v5.16-rc2 and observed a process hang. The test w=
ork load
> >> repeats file creation on xfs on dm-zoned. This dm-zoned device is on t=
op of 3
> >> dm-linear devices. One of them is dm-linear device on non-zoned NVMe d=
evice as
> >> the cache of the dm-zoned device. The other two are dm-linear devices =
on zoned
> >> SMR HDDs. So far, the hang is recreated 100% with my test system.
> >>
> >> The kernel message [2] reported hanging tasks. In the call stack, I ob=
serve
> >> wbt_wait(). Also I observed "inflight 1" value in the "rqos/wbt/inflig=
ht"
> >> attribute of debug sysfs.
> >>
> >> # grep -R . /sys/kernel/debug/block/nvme0n1 | grep inflight
> >> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:0: inflight 1
> >> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:1: inflight 0
> >> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:2: inflight 0
> >>
> >> These symptoms look related to another issue reported to linux-block [=
1]. As
> >> discussed in that thread, I set 0 to /sys/block/nvme0n1/queue/wbt_lat_=
usec.
> >> With this setting, I observed the hang disappeared. Then this hang I o=
bserve
> >> also related to writeback throttling for the NVMe device.
> >>
> >> I bisected and found the commit 4f5022453acd ("nvme: wire up completio=
n batching
> >> for the IRQ path") is the trigger commit. I reverted this commit from =
v5.16-rc2,
> >> and observed the hang disappeared.
> >>
> >> Wish this report helps.
> >>
> >>
> >> [1] https://lore.kernel.org/linux-block/b3ba57a7-d363-9c17-c4be-9dbe86=
875@panix.com
> >=20
> > Yes looks the same as that one, and that commit was indeed my suspicion
> > on what could potentially cause the accounting discrepancy. I'll take a
> > look at this.
>=20
> I sent out a patch in the other thread, please give that a whirl.

With the patch on v5.16-rc2, the hang symptom disappeared. Thank you!

--=20
Best Regards,
Shin'ichiro Kawasaki=
