Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6995EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 07:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGKHvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGKHvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 03:51:02 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C9E55
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689061861; x=1720597861;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=VgRsfCZU6gRxg6KspMerscxN4uszBjv5iDtFDP7Re+o=;
  b=Uzx4tTKap8rylaBG0wUqP3G2WYEQ44D3GFEzZcVRQuL+RaYHq7WBfrLx
   XM5f7K60H+A2dErpgl3X+XYIpEViJMJsvpas7juJ5xNNfgpAxqPVLdObC
   HiWDNQvevfbce+6w1s4tz4+3lFcHfTeiGcLhHTkDeR1U19hQ6/4bmY+gY
   +Lz2BlcVrtk4VvCO4jsFqKbOohdg+L3mZ+TE5on7J19oJI0cSGwVFx8jZ
   sPi58yrjjbg2snOr2TMeTLK6BVv1VgNUq1eFUWAoyhAGyyU8d3qFxZLn/
   OihI7uBd5CCt6pYxmGK87I5DYrJpfk3q3km7XFktEX7K3Wo+m0Aw0442f
   g==;
X-IronPort-AV: E=Sophos;i="6.01,196,1684771200"; 
   d="scan'208";a="237447372"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2023 15:51:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+N3LrxwuW7MJaQ81LjjhIPQWkuN5UddZwhQiEFcA7cAJeSsYpcfPAXdvHDql1g10HQ283d5Z9mcVZ0Ht0VLbMe7A1WNxBAyYPhG/Dv/6IZxilmkf+IpivOu6ajQb7lZPSypkdsPltc+qlBnLx9yPCsrhAI7lRrRzqIgTeo7z9YjfXlxkciFEmvV9xK4zIHRguVzbObv2w7dsWF36YgsnPcjGWt/wLsmIUx9jOwkger8GkZ1kPQQJu3s9SKyYUEga4MKZTGfe9NqO+QarZV/T88v1hCwRBuEQkTTVR3lVEvFTWVPWhBRgmjk5BExmGuF2esn1N9sZcv4xI4ekWtD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qL5bHS5wpZogQ30CUENhcYaA31o30qLhElBPlQcUmo=;
 b=Y0QHzaH+27KBKRrhBd7gnYSSmfH8LYtBXFzLSxpagFr9oO5w4eYcIWu1NaJQZtVaZw9jg6X4DKQ/6QlelN7zg80z44owf0i/Vp11wtVv58Majl7AdQQt64//xdbfaU3MqJO1hsFohTD1QOlcqxqwTeWDM26LsXcHry3Y98J7JQXrnoLn+eWJhA40NzJbVPNGANEnoEUCpJaJcibhcFulwsYDm4pzh8lddCNc89cx6kvGOYw1Id4t2+s8OTO+2u2HcbrkPCt9I1bS1+5Ajb2TP41AH0BIQHo9eVkftJ8q5KIKwsmAk8G/wzp3uhwdYwRaqqwYVLEHYr45b8eMWrj3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qL5bHS5wpZogQ30CUENhcYaA31o30qLhElBPlQcUmo=;
 b=hJUhrfZM068HtNyBd1OLEoclM/ehzmwf2hjWrrTnEFFmPyIu5JR8jR1QTdVo23JfcrjU+ji1+tZ57XI4kkhez5cjn6dZT992UlKu2Yeahh+H/dM+y+oslpLhSMTymYs0iXMCa6YflzBkeqBb5oBflMFuABJtXOsdewyQyr3jp8A=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CH2PR04MB6617.namprd04.prod.outlook.com (2603:10b6:610:6e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 07:50:54 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::fc6c:c6fc:91f8:5fde]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::fc6c:c6fc:91f8:5fde%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 07:50:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [bug report] EIO of zoned block device writes
Thread-Topic: [bug report] EIO of zoned block device writes
Thread-Index: AQHZs8xrY1lbBaheok6QQEG72lJ04g==
Date:   Tue, 11 Jul 2023 07:50:53 +0000
Message-ID: <5zthzi3lppvcdp4nemum6qck4gpqbdhvgy4k3qwguhgzxc4quj@amulvgycq67h>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|CH2PR04MB6617:EE_
x-ms-office365-filtering-correlation-id: e0fd279c-a1c6-4275-67d5-08db81e38db7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HA2gaj9R0b5Z8oL0O9YWMSX1hyKgaozSjGZpbriZH0k816y9r4GBijDjLZe2JUA+4hVHLNTlFjTggXho6AY3qtfaGIhDUtwqQNs2EssAqkDHvnzzHIYVzEWopKF8z7gcLyVJO2ss599GrwgKA3e8x8XkJR7eBuKjPxwQxT25zbxzq22hmr2Fx3uTsYGqbap/wdvvdkzpLqZQUKFa/4kbjm0iXCsVazYe1SRDfDXsEDr/gIsldJDjrxjNQzT0Hm8p8KM0+kqyNb/BlX2+2UuheViwEFIJITuhsb5UliMqpTmSpc69GDzTybk1JMGk9sqRJA12I1PygEpqxF734no9ibFsGqX458qNoY+4dxeN77jrnn8Em3zZ502H5rZK+YJDjn06v6WGeqApyYP3dFCODxZGINRxR+Id5PFMjidiQJkE9IZViOLbAFrIGToVHPiA2YDJgUqAwYh2NW7FR2LYvturm8Il6BGAr9ZQzSWxhMBAkuEB+cLR3TbJHZ5VkX46sO1+yQAMOqTDH35sqZKEHf5biGL2JqS/8RwGLaR/M2WycintChWbacQBbLxQ/YNU9aTZ4HQRYhgHHGw7hyuDw4MjlpyPoQzyfSSz9AH6goczGgAO3B1DcVnzXfpSw0A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(186003)(26005)(6506007)(9686003)(6512007)(83380400001)(41300700001)(316002)(6916009)(64756008)(2906002)(66476007)(5660300002)(44832011)(66556008)(8676002)(8936002)(4326008)(66446008)(478600001)(6486002)(71200400001)(66946007)(76116006)(91956017)(54906003)(33716001)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6RU3mr46iLSEZJfRsOpgo2BfVDshar7ctDSzz97GaZ6oAjzQwrcDu5LG2FST?=
 =?us-ascii?Q?7Gz9tmA+Y2ltyF4+INppg77DDfDtXNZIvl/8oBYskIooKpgSpVzuYB2mxvby?=
 =?us-ascii?Q?9DbQv8fUkyD/mlfKAp0IofnsCiBdfT5aJsHxDsi2LCcesKQlj7pxxN7nq3RT?=
 =?us-ascii?Q?q8zZpX8ejY3aKB1oAgdj6Zxf2CvSQI8uPjVZN1jRNrOHyQLNMZ19u1BmsB+C?=
 =?us-ascii?Q?s8TFnQh6qSysufAjstqYFTARkUOvkG4bqVb8DQb3+3B7RHyfU5SgcWLdG6GU?=
 =?us-ascii?Q?VXjmLu/hsk0hz06jgo/pWruoZorGCBJq4UULHTXmyDzvFHOlG8pigx9oMdP4?=
 =?us-ascii?Q?Jb4JPSZgcVBYGQvfm3KslWFKUDwWpSruLG6fScU/XtD90JyF5rded3WMBRMN?=
 =?us-ascii?Q?1rPHM6GFsdMLaIty5xPbZ+e01rmkl2+IrCW0Fs6Z9dbSEdCwHuvTSRPfcTcS?=
 =?us-ascii?Q?7zMjyFEDTzTVs7Dn21J5cpzE+HgV3gIKkbnLAr7/jvEpLAdXAXm9+33pAA16?=
 =?us-ascii?Q?YwOo7gvYphXNiyYY2twsny5Xrv4bfM/lB84NqegNl1LB/0mb+ttr0AInvEMz?=
 =?us-ascii?Q?acXGg8jrQPPG8iMIhWHo0MSucUG0KFEaN6jptIGoLu4NSYicV55AVpZDbGTQ?=
 =?us-ascii?Q?BRlq9hpwjXZgvNdxtpOUnOn/eT0X9hz6/637lbU92Rb/pGJma+bDzPprccd4?=
 =?us-ascii?Q?h+dolUNmSns2zVXs3109UkVuJrF9sGSHbfEUV4iwG+OlNP0Revt40NfN63+L?=
 =?us-ascii?Q?tDMIx+zMK3oqek9SjMKTsmAAma54JPA622RvtiOiQn3nW5WMd+P8SSNmFj9O?=
 =?us-ascii?Q?KzT/gGWIrJGEiJR6bzRyn/aq7NqaenvP+ym0Zvr88EiCrAmdXlV9ECeAU/TY?=
 =?us-ascii?Q?kNk7dcWeuuGRs5RLO3ZF2uf8v/cVmGn8aTMS6AuN0bICrck4bVNn9+PVgtbg?=
 =?us-ascii?Q?GEIb6gMIZEt2SM//JLYlTzU4D1V62PqqLO9LmaPdXyMJsYi6vd28ytl31Hmd?=
 =?us-ascii?Q?PGjScInJSwYjTUv+o2qwh7oX5Z/kEBAzLJLc6spK5ghvilEktF8ReDlyKCHF?=
 =?us-ascii?Q?YYckJ7ciTKvsP5r6NXhl8c0OP+8ZUFXUH0n0+jHXtwwJ1rnG0x4ea1yTMM16?=
 =?us-ascii?Q?QxWyQKd04NpKBoDcYlkor8XKdGZghCYBHGVjXENJsrFwUUdXgpXLYvuIMJ+t?=
 =?us-ascii?Q?XyagfRuhGJZe7l6OwLT0V7vRsUzZOF9lT1srtjPwrzfUFlGGjDkwGnok9Cn/?=
 =?us-ascii?Q?79gHCIT7DfrsyF1H4z5TgV1ToDA/8QW8kwEOb9zabJZ8oyDuc2KFnZcEtMN8?=
 =?us-ascii?Q?MSiIonE6b4T5A95DhPEgUKfxhsyyiaQackHAEC9y+mirraudyJd0eEbLpImm?=
 =?us-ascii?Q?7W1KQaBDwFCtHvdi+OQQ3ZHzilRjxmuMIszWsLMhxcGKFFsS97Y2zYSers/9?=
 =?us-ascii?Q?5KkjF2a2Hy4ml6rQG3j/zwJO+dLoq0aVMKjlsoae2fLFtSP0x0IBSnUGCf6e?=
 =?us-ascii?Q?MFjtzASTRvXF8tVp534LT1gasUmsL7zpTEAgZgLKREShBSvGxwUH9atS1Tlw?=
 =?us-ascii?Q?/xLwoLHXObEKgPrfwCUjPyyF82j3j7ITGXAKmxgR4XhIY38ybmq8KKQQ307Y?=
 =?us-ascii?Q?ZDXDApwRj3p6dDsdT7SP36c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B58C0AF5A69EC4B89A340EFC8BC864A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zp60l1Cg9PUFjxIFbGkRt5Wa5MVv5GsZvvvtG4zWvvgAc0GAbBybYe31rNFj915O4bT+hgNrjVPZVkslWOLeT6wRYqLcL/6xWBfex+kWzAAcUUav3NQ7H5FkA16aISmiRmchZ0cYCSzjm+2m/XoAOi8sbtHiF7cuAb5ttfqVCeBx53jLvfoRreYtS1Xtpdd7kvZDEAL65Lz1IPbSMGyE3BV9G+1VutuwgLK3REA8xjCgMARc7i3iTlgJ4bQM10s2GZwZFvmtOPXHMw49QdKDXpuK32AA1D42ch3ApkL9WxsT5nK3NV795+a9xcJdrzUHT60mqr9t83N/RkwH+d6iI6a2kqqlmbZhwc4sHc0hoV+flXBW7mPifROGMaBoCO7CYYv8SE8lA9VUuqa6H4D4MpYvjJbfY6PJm+LZbgsL8klE2LMgf4INpTPwehuFW4gEcjnb0u207vmLGrvshZcuO9bBdKKdxydPAjrPziAUJuG3HAotm0eff7TsylazFhC2PimEUBQlyM8IhZ4frEwR7gP/ylnXmYmzjpfHC67XlshRIgSie00KlQFbYZEju+QsASn3Hfg2qFrOi+3/FmhG3q0l13pNuh0xccOhlIlULJcosjGRxwmUiHbJKS2Ne3CkSNwtA0QxRJIizWSW7hD8XYRv/ULYOveKPABqhGEBkUkmPqj9Pob9oODiZfBP4PauYypuwfBWRu6lEHTkP054peMHknYSlAjf7rB3z9zy1u/8nSgSKX53YlcX/Z5C0Sthmg738NmIWSy9zXFGVHXWxB26U4MoPm0goWT2o1EbPOk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd279c-a1c6-4275-67d5-08db81e38db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 07:50:53.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3cqEQ7wPmh9r3fxignt329M0rHpoF18Cv2Oz9jKjEhvxsizjEWA9n6YVir37kaKbEXg0abTM1wrf/JktMgXK3sSDeZlSjTdYxsfYPvbAsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6617
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With kernel version v6.5-rc1, I observed an I/O error during a fio run on z=
oned
block devices. I bisected and found that the commit 0effb390c4ba ("block:
mq-deadline: Handle requeued requests correctly") is the trigger. When I re=
vert
this commit from v6.5-rc1, the error disappears.

At first, the error was observed as a test case failure of fio test script =
for
zoned block devices (t/zbd/test-zbd-support, #34), using a QEMU ZNS emulati=
on
device with 4MB zone size. The failure was also observed with a zoned null_=
blk
device with 4MB zone size and memory backed option. The error was observed =
with
real ZNS drives with 2GB zone size as well.

I simplified the fio test script and confirmed that the short script below =
[1]
recreates the error using the null_blk device with 4MB zone size and memory
backed option.

The trigger commit modifies the order to dispatch write requests to zones. =
To
check the write requests dispatched to the null_blk device, I took blktrace=
 [2].
It shows that 1MB write to the first zone (sector 0) is divided into size o=
f 255
sectors. One of the divided write requests was dispatched to the zone but i=
t was
not a write at zone start, then it caused the I/O error. I think this I/O e=
rror
is caused by unaligned write command error on the device. Later on, another
write request to the zone start was dispatched. So, it does not look the wr=
ite
requests are well ordered.

I call for a help to resolve this issue. If any actions on my test systems =
will
help, please let me know.


[1]

#!/bin/bash

dev=3D$1
realdev=3D$(readlink -f "$dev")
basename=3D$(basename "$realdev")

echo mq-deadline >"/sys/block/$basename/queue/scheduler"
blkzone reset $dev

fio --name=3Djob --filename=3D"${dev}" --ioengine=3Dlibaio --iodepth=3D256 =
\
    --rw=3Drandwrite --bs=3D1M --offset=3D0 --size=3D16M \
    --zonemode=3Dzbd --direct=3D1 --zonesize=3D4M

[2]

...
251,0    1      136     0.871020525  1300  Q  WS 0 + 2048 [fio]
251,0    1      137     0.871025680  1300  X  WS 0 / 255 [fio]
251,0    1      138     0.871027679  1300  G  WS 0 + 255 [fio]
251,0    1      139     0.871028675  1300  I  WS 0 + 255 [fio]
251,0    1      140     0.871038432  1300  X  WS 255 / 510 [fio]
251,0    1      141     0.871040086  1300  G  WS 255 + 255 [fio]
251,0    1      142     0.871040949  1300  I  WS 255 + 255 [fio]
251,0    1      143     0.871050035  1300  X  WS 510 / 765 [fio]
251,0    1      144     0.871051688  1300  G  WS 510 + 255 [fio]
251,0    1      145     0.871052551  1300  I  WS 510 + 255 [fio]
251,0    3        8     0.871054865  1115  C  WS 24576 + 765 [0]
251,0    1      146     0.871061570  1300  X  WS 765 / 1020 [fio]
251,0    1      147     0.871063327  1300  G  WS 765 + 255 [fio]
251,0    1      148     0.871064204  1300  I  WS 765 + 255 [fio]
251,0    1      149     0.871073358  1300  X  WS 1020 / 1275 [fio]
251,0    1      150     0.871075004  1300  G  WS 1020 + 255 [fio]
251,0    3        9     0.871075262  1115  D  WS 510 + 255 [kworker/3:2H] .=
.. Write not at zone start
251,0    1      151     0.871075921  1300  I  WS 1020 + 255 [fio]
251,0    3       10     0.871077227  1115  C  WS 0 + 765 [65531]  ... I/O e=
rror
251,0    1      152     0.871085051  1300  X  WS 1275 / 1530 [fio]
...
251,0    3      281     0.904191667  1115  D  WS 0 + 255 [kworker/3:2H] ...=
 Write at zone start comes after
251,0    3      282     0.904445591  1115  C  WS 0 + 255 [0]
...=
