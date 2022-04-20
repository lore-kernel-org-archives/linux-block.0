Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 12:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiDTMpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiDTMpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 08:45:04 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F851FA6F
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650458536; x=1681994536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hnE4MWeY8ORQRmymq706Yr+efOVoB/jQB9+Iwa7bLeA=;
  b=Ielw1PCE0+k+GCtoBKrb6lrn8jJYVAP4MLn/b0D1vsDabxLP6nVQX3s3
   +MxrP8x8jglRBjxLto2cjPi6/M9IeF/X1E+wuMMP/bx45vm1v250hDsvr
   b8axDhySgUkcoGfXbuUahk2Qye0cbByV7M0VZYZhpkQSDMqlcPdlQA+7R
   lmz4Aty8WBORSIR3uK/hSY+kMdKt9+lFhQuTpCjb5sZ9nlnrge+o2WyVK
   2SY0+jOxGQK+IknUOKX2n7lZ1qe2yTgb1xjemAN9bvxOiMqVFHpsswJSK
   U1Tpe92c21CWVLhydzjHucrkpLsFwUlNrd6AQx4bsTEzzuG+V0pJMXKQT
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="198362831"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 20:42:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSDqAdmcSqR9E3PIs8qYPZh9njnjuRzDz1yelx5do++i3qn/QJvOb9vSjDs93PCmBKhmLNBhq5zkl3zv3ouzyBbIC1bBFlpgs8QEnOwe9vvy2i7vMLX1aqXLFgam/US70gf1kkKEwe6/AgOYbzHNI2r4R0FO7txdbvDScOsyOJKnZIkmSU8Aj8WhDYkNEeFt1Mz3ByxmzNX/7fsT4BXiDRVp63KnHZ+OM2qXrnYq9GiAVlbyBjCF5VoZJj7VjcSaFa5UDYdotL8savOp2Ab/WiB3pZYd6Vsj5NDUJuLticY5+2aRl6QZM7Q2XdBjmah5alsZ8Fa9odk0X5Q6aPDVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8mgd7GG/XvpkZfgh1Fe7VAnbQH73nqIr1IOY6egDMc=;
 b=dedzXJCNZpa+MGH1KC/LRCmQl6/wvWisnbXFZRuBTCdPWiP0r4EgGh12boKZn3Gl2c2hU4zgSYtjJheG/7WI2Aq4HvuN+iPC2s1FbnW1OyOMdgZhPDvFmSEb5cA4O9wuHK4hWhf32FErCoyP59ZW1Suw8gelUeI2bPLTmGCVXoyyDNYkoUbzh64FSA1sMwSXQElZ40iEoqPntN5gVGmjVG55Hdex6CHMxCgnlvfBw9US3l/1ZSP+ohAiECT82lVZ989rvb2qDNq3rg4qDJkIZ14QNfqqjj44/1jT3R08MzKFGXA0S0JeGP/y2zEP/tCBlViOilN/5agqJLCiWQpYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8mgd7GG/XvpkZfgh1Fe7VAnbQH73nqIr1IOY6egDMc=;
 b=I8ciwPsP3RdELa08TUSIZkVcFj0ksvDEPXDg9yBYmiZy0kd4Zm3RNbDge/9bwfsmhX2lyUAkjUM+zuknv/CQer5Ebi42IApvcObZv+yPE9r/8CWcpLqvbUn4BEZgg6z8O9Tj+9DQk+4mSM4hYpCIpCE9Exc31w9hqbCh1tLuHW8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8257.namprd04.prod.outlook.com (2603:10b6:a03:3e4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 20 Apr 2022 12:42:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 12:42:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Thread-Topic: [PATCH blktests] block/002: delay debugfs directory check
Thread-Index: AQHYVHNmSGa1G2Gr0kCPcyfebm6VRaz4iqaAgAA0kYA=
Date:   Wed, 20 Apr 2022 12:42:14 +0000
Message-ID: <20220420124213.5wc4umnjrlvu6zbi@shindev>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590>
In-Reply-To: <Yl/TjWYle8mOOwlO@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00c42dc2-1ed0-4c24-22d6-08da22cb3256
x-ms-traffictypediagnostic: SJ0PR04MB8257:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB8257E74847BEF49FD13C8DFDEDF59@SJ0PR04MB8257.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSo9y4QVv/HYnDiNMBtbpbkVKnwj3XpCkEzY5WFvByNEFzUdeJ7/7pgaNMo3hAEnIWhfOol88uvhRfz+Ke2cUAGvhTtWWxvVOU9wkhiwx+cJIZDMEKGpzNzHpORcCCKIONVyLrLzLRun0isHNTI23lV5ld+gQPvWucTEc6Hq5FU2u6wgyxML6fv+yPfxPujf37Sj26LQs+bwHPsta4sNLUIIp+cE2Mq/XfWhe3GfzIcNewJJWrgGv1oV6EROIPfWgKmavNwx2pXCBnh63JYJDrkSUD+IF8/c1Fe4i8m4GgSY8u9t646qnZydphdRI88HNuDsK1982RIPTaNnNL5q7MBFqyF66a9pAG7htRGFgxT3eIYU5mflvzwlTWan40/j57fj60MlHRa8rFot6uRx1Cz/erdySa5TznjDzlBhh4bfBNjDcAe3ntl8rgC9Zu6cZ7Aj8B5RiGoe/u4avCSzJWWpfEJIUxlHwzGOSD5r3AGKxsHu1Rc6t0PiTrcAH0GAUx55A4MyWsxkcZDkAoilVuBmuc+EDVT8j7MjMJiw9QcrmplE64bef1HjXezx0LtGVxZGcGP5VZ9V0DawtebYkGdzyiBw15uswp4hcHP/JUXBik5BnBVyDRcl37bqpaUKQGuVygBsqwmEaeG3u1nYRLCxGMWy4tUbz4YM065pzvtv0CW3CbK0ZYpD7A+sD0497Z2mwfRGvl7ub2toHGrHD6QF+LJCeS3HC3TIvaL307M9Msvc4edSuVuY+JIJGJon2PL2PXnTNFtS46RPlGezb+4WZ/cdpPZTp+bOW62pINr1XCW8EKjGBWq8EomMP9tD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(82960400001)(26005)(9686003)(186003)(6512007)(6506007)(38100700002)(966005)(8936002)(30864003)(6486002)(44832011)(33716001)(5660300002)(508600001)(122000001)(38070700005)(91956017)(71200400001)(86362001)(66476007)(66946007)(66556008)(83380400001)(66446008)(76116006)(316002)(6916009)(54906003)(45080400002)(2906002)(64756008)(8676002)(4326008)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b/1HGYJzwZgXz5ozJ8rqItVYs6+Ow1sl+AUnuxu6z/P5zJZIHzfO4n0Y1FtL?=
 =?us-ascii?Q?09UgRpV4qhib+1CvN3pA9mD096um1lSIJOlbD7GFCa7Es2JOIaeQ1ewbFJlZ?=
 =?us-ascii?Q?CR+nemjLvBC41K0AmpFic04sL6TiU0k0XYSHcXCXg/LICH/yWd9OIbmsF8+E?=
 =?us-ascii?Q?66HG+gh6uR4X+pIw5hE9LGcmoqv9zq30RsNfjw+I0Los8FKfpd6c8ltPxJvz?=
 =?us-ascii?Q?nGshVGS3JogbvTcIvVefRfc8JtDqhupgttazi6tWCOHDsjqjKV143P25IB/F?=
 =?us-ascii?Q?JI8Fgs1VPqRoaotRgw0epb7dxUhG+3fooDi8pfnkfx0f89BPbND51QEDFrNK?=
 =?us-ascii?Q?bwHH7VTGwa4o3jksf//2J7Hc4G7KFSN0TuCcHQBLZTfY8+QIF5DaW04Kk4oW?=
 =?us-ascii?Q?wWTi1uit0Y82ivnEb6J0u8MTYyI2Dc8/ffVxhaIT/xlxm90D9EGrdRv910X3?=
 =?us-ascii?Q?Z27Vp4Ig1/yx6L2wqFNjOIqfWMBXlbcV5/fH1xYV5C+3olMNfPu5hbGYTxWT?=
 =?us-ascii?Q?rWtRsxcrPR//Do4qkHVFjxJTc5xDQkJn1ZT427ySB4JAX7LnU0r7TtNl4lzs?=
 =?us-ascii?Q?bGxlTK0XkHLzj3rrPegMwpmMdLJ61x9Tdf7vaIx7xoSuVaE7/3XHItD1EGN3?=
 =?us-ascii?Q?+f5eQRAqbfFBxHjDpDeFwTH6PfiR9N0n+0ehq1ktHo9w+i36S28NO8NJKW7C?=
 =?us-ascii?Q?KY84lI1BFvjTZArYP1wtLFxFw0uPeOcw//YBnS/nTM+ltSHorVGXRLubNuUk?=
 =?us-ascii?Q?QhhZa5uPDilaxVrul7YQxuMwB3499r3RvrGziMhbz2PDObIV00TX2C7HbWCg?=
 =?us-ascii?Q?1WV1uIoWseZ2sOFLDlzuEhTpzYF20FBMm9Ew9LpwIouEVWAI6V7zQzUWg2NV?=
 =?us-ascii?Q?ALcv+I9qgf0Nsed7cjmvxmBnQg2N9ShDTH0OZTWQAd3jY6oixOv5JneP0lvO?=
 =?us-ascii?Q?MGitjTHe0+wdGjSl29ENeHl3Z/rgkMSNHR+NQl4zoWB225trvQ0X/nDOOS/v?=
 =?us-ascii?Q?hqlbW2DAmbLYhptBUU9D1/7tm/5HLgtQNnlEJNSEZ3sihaKWrQhqzoLb6hzp?=
 =?us-ascii?Q?fw5vBIX0NI90buCiVaZ5RpsdpYu6tP0cbapE27hN+RcwuALJ+N7zezDcy/Sc?=
 =?us-ascii?Q?JJ3nSY4GZSlDwPdbv2qQaS8QrgTsw/qmExqKMvZnXqcjKfhsn+OsOjGW2ioM?=
 =?us-ascii?Q?VXOftyukIwcvivP9ODY4vMweVaFPLsPqO19B2NQlsO8SvZ6wpj+iw/V3kMco?=
 =?us-ascii?Q?DSqBxsd4pVhXqHR9KbEOiC5vqLu+FNnA7PZ+ESoHbeHngWMal/pSqS+xLZPh?=
 =?us-ascii?Q?OvlTtx11JSLDVHMkH199txmWxI/gtwM7+Bie07kS6tY/Jkp/z9eEQKklpewB?=
 =?us-ascii?Q?lXEG1/qYuUpU81tz+Vb+vcWHHTXupOcSyblJmuZCQZ1bxhYgXrIiEOGeGd2S?=
 =?us-ascii?Q?hIcuxYkNDlMpMpAsRHuNsPcQqYrlgFYLSsJmp1kIw3qOPH0OoUzJcuOvkToR?=
 =?us-ascii?Q?Ma8t2HM/ZdbDUC77uJE2ZKXe+dytVF4FEZAlCilNg/8J1d9WjoWkI0JVtuXm?=
 =?us-ascii?Q?JhNyYL3zFUXeM/oVGhrXLhGZ72Ndz3QT/EcVUmHsykJARCAVpr2Wvu414YrZ?=
 =?us-ascii?Q?Nn83aysjk8zA4OzfeTB4VsBq18hRORyfIXWUFbvNHu/YqNv2k8jez/Nf9Jan?=
 =?us-ascii?Q?4FgoKqDf51YxwZqUk7UgRkTg8T5NnPKozn/UvzDCNbqY+RKUrJaXgR9mKhOz?=
 =?us-ascii?Q?KJ5f1jBoJfF9e+FGQbRRVK5iX7q0pQDGwkXYt7twD25B/6LElz8Q?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53C13FFCC96F0F459AE01EDFCABA808E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c42dc2-1ed0-4c24-22d6-08da22cb3256
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 12:42:14.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4D5Y/I7cErsjCGUy4z5HKBsj6SoXJN8/Ur7fysBsE/djfgtwlRfSzjeQ5MmE7j3+RpHJqZJ/qW9bYwbwSI1f294tPiwyUCWsF4UmLZsmwKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8257
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 20, 2022 / 17:34, Ming Lei wrote:
> On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wrote:
> > The test case block/002 checks that device removal during blktrace run
> > does not leak debugfs directory. The Linux kernel commit 0a9a25ca7843
> > ("block: let blkcg_gq grab request queue's refcnt") triggered failure o=
f
> > the test case. The commit delayed queue release and debugfs directory
> > removal then the test case checks directory existence too early. To
> > avoid this false-positive failure, delay the directory existence check.
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  tests/block/002 | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/tests/block/002 b/tests/block/002
> > index 9b183e7..8061c91 100755
> > --- a/tests/block/002
> > +++ b/tests/block/002
> > @@ -29,6 +29,7 @@ test() {
> >  		echo "debugfs directory deleted with blktrace active"
> >  	fi
> >  	{ kill $!; wait; } >/dev/null 2>/dev/null
> > +	sleep 0.5
> >  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
> >  		echo "debugfs directory leaked"
> >  	fi
>=20
> Hello,
>=20
> Jens has merged Yu Kuai's fix[1], so I think it won't be triggered now.
>=20
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git=
/commit/?h=3Dblock-5.18&id=3Da87c29e1a85e64b28445bb1e80505230bf2e3b4b

Hi Ming, I applied the patch above on top of v5.18-rc3 and ran block/002.
Unfortunately, it failed with a new symptom with KASAN use-after-free [2]. =
I
ran block/002 with linux-block/block-5.18 branch tip with git hash a87c29e1=
a85e
and got the same KASAN uaf. Reverting the patch from the linux-block/block-=
5.18
branch, the KASAN uaf disappears (Still block/002 fails). Regarding block/0=
02,
it looks the patch made the failure symptom worse.

[2]

[  466.424358] run blktests block/002 at 2022-04-20 19:44:02
[  466.508847] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues=
 to 0. poll_q/nr_hw =3D (0/1)
[  466.518617] scsi host7: scsi_debug: version 0191 [20210520]
                 dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statistics=
=3D0
[  466.535080] scsi 7:0:0:0: Direct-Access     Linux    scsi_debug       01=
91 PQ: 0 ANSI: 7
[  466.548701] sd 7:0:0:0: Power-on or device reset occurred
[  466.549819] sd 7:0:0:0: Attached scsi generic sg9 type 0
[  466.557985] sd 7:0:0:0: [sdi] 16384 512-byte logical blocks: (8.39 MB/8.=
00 MiB)
[  466.570116] sd 7:0:0:0: [sdi] Write Protect is off
[  466.575644] sd 7:0:0:0: [sdi] Mode Sense: 73 00 10 08
[  466.577821] sd 7:0:0:0: [sdi] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  466.590343] sd 7:0:0:0: [sdi] Optimal transfer size 524288 bytes
[  466.645516] sd 7:0:0:0: [sdi] Attached SCSI disk
[  467.438285] sd 7:0:0:0: [sdi] Synchronizing SCSI cache
[  467.458790] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  467.466714] BUG: KASAN: use-after-free in __lock_acquire+0x396b/0x5030
[  467.473951] Read of size 8 at addr ffff888104e05248 by task check/1549

[  467.483373] CPU: 1 PID: 1549 Comm: check Not tainted 5.18.0-rc3+ #24
[  467.490426] Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/=
2015
[  467.498164] Call Trace:
[  467.501313]  <TASK>
[  467.504120]  dump_stack_lvl+0x56/0x6f
[  467.508488]  print_report.cold+0x5e/0x5db
[  467.513205]  ? __lock_acquire+0x396b/0x5030
[  467.518092]  kasan_report+0xbf/0xf0
[  467.522288]  ? lockdep_lock+0x30/0x1a0
[  467.526738]  ? __lock_acquire+0x396b/0x5030
[  467.531630]  __lock_acquire+0x396b/0x5030
[  467.536346]  ? lockdep_unlock+0xf2/0x240
[  467.540970]  ? __lock_acquire+0x23db/0x5030
[  467.545861]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[  467.551705]  lock_acquire+0x19a/0x4b0
[  467.556068]  ? lockref_get+0x9/0x40
[  467.560264]  ? lock_release+0x6c0/0x6c0
[  467.564806]  ? lock_is_held_type+0xe2/0x140
[  467.569693]  ? find_held_lock+0x2c/0x110
[  467.574316]  ? lock_release+0x3a7/0x6c0
[  467.578856]  _raw_spin_lock+0x2f/0x40
[  467.583222]  ? lockref_get+0x9/0x40
[  467.587414]  lockref_get+0x9/0x40
[  467.591439]  simple_recursive_removal+0x36/0x7e0
[  467.596758]  ? debugfs_remove+0x60/0x60
[  467.601300]  ? do_raw_spin_unlock+0x55/0x1f0
[  467.606278]  debugfs_remove+0x40/0x60
[  467.610643]  blk_mq_debugfs_unregister_queue_rqos+0x34/0x70
[  467.616919]  rq_qos_exit+0x1b/0xf0
[  467.621028]  ? sysfs_file_ops+0x170/0x170
[  467.625740]  blk_cleanup_queue+0xfd/0x1f0
[  467.630449]  __scsi_remove_device+0xdd/0x2b0
[  467.635422]  sdev_store_delete+0x83/0x120
[  467.640137]  kernfs_fop_write_iter+0x353/0x520
[  467.645287]  new_sync_write+0x2d9/0x500
[  467.649827]  ? new_sync_read+0x500/0x500
[  467.654455]  ? perf_msr_probe+0x1f0/0x280
[  467.659170]  ? lock_release+0x6c0/0x6c0
[  467.663709]  ? inode_security+0x54/0xf0
[  467.668253]  ? lock_is_held_type+0xe2/0x140
[  467.673144]  vfs_write+0x61c/0x910
[  467.677250]  ksys_write+0xe3/0x1a0
[  467.681355]  ? __ia32_sys_read+0xa0/0xa0
[  467.685982]  ? syscall_enter_from_user_mode+0x21/0x70
[  467.691740]  do_syscall_64+0x3b/0x90
[  467.696018]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  467.701772] RIP: 0033:0x7f2d0b701817
[  467.706046] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  467.725492] RSP: 002b:00007ffd37a645e8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  467.733762] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d0b7=
01817
[  467.741596] RDX: 0000000000000002 RSI: 000055a23ecf4630 RDI: 00000000000=
00001
[  467.749431] RBP: 000055a23ecf4630 R08: 0000000000000000 R09: 00007f2d0b7=
b64e0
[  467.757267] R10: 00007f2d0b7b63e0 R11: 0000000000000246 R12: 00000000000=
00002
[  467.765101] R13: 00007f2d0b7fb5a0 R14: 0000000000000002 R15: 00007f2d0b7=
fb7a0
[  467.772945]  </TASK>

[  467.778033] Allocated by task 111:
[  467.782141]  kasan_save_stack+0x1e/0x40
[  467.786681]  __kasan_slab_alloc+0x90/0xc0
[  467.791395]  kmem_cache_alloc_lru+0x258/0x720
[  467.796457]  __d_alloc+0x31/0x960
[  467.800477]  d_alloc+0x44/0x200
[  467.804326]  d_alloc_parallel+0xca/0x1490
[  467.809041]  __lookup_slow+0x17f/0x3d0
[  467.813495]  lookup_one_len+0x10b/0x130
[  467.818038]  start_creating.part.0+0xf0/0x220
[  467.823098]  debugfs_create_dir+0x2f/0x460
[  467.827901]  blk_mq_debugfs_register_rqos+0x1fe/0x330
[  467.833655]  wbt_init+0x35e/0x630
[  467.837676]  blk_register_queue+0x26c/0x430
[  467.842565]  device_add_disk+0x639/0xd90
[  467.847192]  sd_probe+0x93f/0xf50
[  467.851212]  really_probe+0x3d7/0xa10
[  467.855581]  __driver_probe_device+0x2ab/0x460
[  467.860721]  driver_probe_device+0x49/0x120
[  467.865610]  __device_attach_driver+0x191/0x240
[  467.870845]  bus_for_each_drv+0x119/0x180
[  467.875560]  __device_attach_async_helper+0x172/0x210
[  467.881314]  async_run_entry_fn+0x95/0x500
[  467.886115]  process_one_work+0x7cf/0x12d0
[  467.890915]  worker_thread+0x5ac/0xec0
[  467.895369]  kthread+0x2a7/0x350
[  467.899305]  ret_from_fork+0x22/0x30

[  467.905779] Freed by task 1588:
[  467.909620]  kasan_save_stack+0x1e/0x40
[  467.914159]  kasan_set_track+0x21/0x30
[  467.918614]  kasan_set_free_info+0x20/0x30
[  467.923416]  ____kasan_slab_free+0x167/0x1a0
[  467.928391]  slab_free_freelist_hook+0xd6/0x1b0
[  467.933618]  kmem_cache_free+0x138/0x640
[  467.938246]  rcu_do_batch+0x35f/0xd30
[  467.942613]  rcu_core+0x6de/0xbd0
[  467.946636]  __do_softirq+0x28a/0x8fd

[  467.953194] Last potentially related work creation:
[  467.958768]  kasan_save_stack+0x1e/0x40
[  467.963309]  __kasan_record_aux_stack+0xb1/0xc0
[  467.968544]  call_rcu+0xb3/0xec0
[  467.972478]  __dentry_kill+0x3f2/0x560
[  467.976934]  dput+0x43a/0xa10
[  467.980609]  simple_recursive_removal+0x133/0x7e0
[  467.986017]  debugfs_remove+0x40/0x60
[  467.990386]  blk_unregister_queue+0x1e2/0x280
[  467.995446]  del_gendisk+0x2f0/0x7f0
[  467.999728]  sd_remove+0x85/0xf0
[  468.003661]  device_release_driver_internal+0x3c3/0x5a0
[  468.009580]  bus_remove_device+0x2a3/0x560
[  468.014382]  device_del+0x499/0xb60
[  468.018575]  __scsi_remove_device+0x21e/0x2b0
[  468.023638]  sdev_store_delete+0x83/0x120
[  468.028353]  kernfs_fop_write_iter+0x353/0x520
[  468.033502]  new_sync_write+0x2d9/0x500
[  468.038033]  vfs_write+0x61c/0x910
[  468.042132]  ksys_write+0xe3/0x1a0
[  468.046242]  do_syscall_64+0x3b/0x90
[  468.050523]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  468.058469] Second to last potentially related work creation:
[  468.064912]  kasan_save_stack+0x1e/0x40
[  468.069442]  __kasan_record_aux_stack+0xb1/0xc0
[  468.074669]  call_rcu+0xb3/0xec0
[  468.078602]  __dentry_kill+0x3f2/0x560
[  468.083057]  dput+0x43a/0xa10
[  468.086732]  step_into+0xbc2/0x1d50
[  468.090917]  path_openat+0x3bf/0x24b0
[  468.095288]  do_filp_open+0x197/0x3c0
[  468.099655]  do_sys_openat2+0xef/0x3c0
[  468.104109]  __x64_sys_openat+0x109/0x1a0
[  468.108825]  do_syscall_64+0x3b/0x90
[  468.113105]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  468.121054] The buggy address belongs to the object at ffff888104e051a0
                which belongs to the cache dentry of size 312
[  468.134522] The buggy address is located 168 bytes inside of
                312-byte region [ffff888104e051a0, ffff888104e052d8)

[  468.149836] The buggy address belongs to the physical page:
[  468.156102] page:00000000fe687ef7 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x104e04
[  468.166191] head:00000000fe687ef7 order:1 compound_mapcount:0 compound_p=
incount:0
[  468.174361] memcg:ffff888130bd2801
[  468.178461] flags: 0x17ffffc0010200(slab|head|node=3D0|zone=3D2|lastcpup=
id=3D0x1fffff)
[  468.186549] raw: 0017ffffc0010200 ffffea0004a5fd80 dead000000000002 ffff=
88810025cdc0
[  468.194990] raw: 0000000000000000 0000000000150015 00000001ffffffff ffff=
888130bd2801
[  468.203430] page dumped because: kasan: bad access detected

[  468.211891] Memory state around the buggy address:
[  468.217375]  ffff888104e05100: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc=
 fc fc
[  468.225298]  ffff888104e05180: fc fc fc fc fa fb fb fb fb fb fb fb fb fb=
 fb fb
[  468.233221] >ffff888104e05200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  468.241138]                                               ^
[  468.247406]  ffff888104e05280: fb fb fb fb fb fb fb fb fb fb fb fc fc fc=
 fc fc
[  468.255328]  ffff888104e05300: fc fc fc 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[  468.263247] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  468.271160] Disabling lock debugging due to kernel taint
[  469.094627] BUG: kernel NULL pointer dereference, address: 0000000000000=
0e0
[  469.102295] #PF: supervisor write access in kernel mode
[  469.108221] #PF: error_code(0x0002) - not-present page
[  469.114064] PGD 0 P4D 0=20
[  469.117304] Oops: 0002 [#1] PREEMPT SMP KASAN PTI
[  469.122704] CPU: 2 PID: 1549 Comm: check Tainted: G    B             5.1=
8.0-rc3+ #24
[  469.131138] Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/=
2015
[  469.138884] RIP: 0010:down_write+0xb1/0x130
[  469.143773] Code: 00 00 00 48 c7 44 24 28 00 00 00 00 e8 98 de 50 fe be =
08 00 00 00 48 8d 7c 24 28 e8 89 de 50 fe ba 01 00 00 00 48 8b 44 24 28 <f0=
> 48 0f b1 55 00 0f 94 c0 5a 84 c0 74 4b 4c 8d 6d 08 be 08 00 00
[  469.163210] RSP: 0000:ffff8881963bfb50 EFLAGS: 00010246
[  469.169139] RAX: 0000000000000000 RBX: 1ffff11032c77f6b RCX: ffffffff9b4=
379c7
[  469.176975] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881963=
bfb78
[  469.184809] RBP: 00000000000000e0 R08: 0000000000000001 R09: ffff8881963=
bfb7f
[  469.192643] R10: ffffed1032c77f6f R11: 0000000000000001 R12: dffffc00000=
00000
[  469.200470] R13: 0000000000000000 R14: 0000000000000002 R15: 00000000000=
000e0
[  469.208298] FS:  00007f2d0b884740(0000) GS:ffff8886ed900000(0000) knlGS:=
0000000000000000
[  469.217084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  469.223523] CR2: 00000000000000e0 CR3: 000000012ca86004 CR4: 00000000001=
706e0
[  469.231358] Call Trace:
[  469.234505]  <TASK>
[  469.237312]  ? simple_recursive_removal+0x173/0x7e0
[  469.242897]  ? down_write_killable_nested+0x150/0x150
[  469.248649]  ? do_raw_spin_unlock+0x1a8/0x1f0
[  469.253714]  simple_recursive_removal+0x173/0x7e0
[  469.259120]  ? debugfs_remove+0x60/0x60
[  469.263662]  ? do_raw_spin_unlock+0x55/0x1f0
[  469.268638]  debugfs_remove+0x40/0x60
[  469.273005]  blk_mq_debugfs_unregister_queue_rqos+0x34/0x70
[  469.279280]  rq_qos_exit+0x1b/0xf0
[  469.283388]  ? sysfs_file_ops+0x170/0x170
[  469.288099]  blk_cleanup_queue+0xfd/0x1f0
[  469.292817]  __scsi_remove_device+0xdd/0x2b0
[  469.297791]  sdev_store_delete+0x83/0x120
[  469.302506]  kernfs_fop_write_iter+0x353/0x520
[  469.307646]  new_sync_write+0x2d9/0x500
[  469.312187]  ? new_sync_read+0x500/0x500
[  469.316815]  ? perf_msr_probe+0x1f0/0x280
[  469.321529]  ? lock_release+0x6c0/0x6c0
[  469.326070]  ? inode_security+0x54/0xf0
[  469.330614]  ? lock_is_held_type+0xe2/0x140
[  469.335503]  vfs_write+0x61c/0x910
[  469.339611]  ksys_write+0xe3/0x1a0
[  469.343715]  ? __ia32_sys_read+0xa0/0xa0
[  469.348345]  ? syscall_enter_from_user_mode+0x21/0x70
[  469.354091]  do_syscall_64+0x3b/0x90
[  469.358370]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  469.364126] RIP: 0033:0x7f2d0b701817
[  469.368405] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  469.387853] RSP: 002b:00007ffd37a645e8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  469.396113] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d0b7=
01817
[  469.403949] RDX: 0000000000000002 RSI: 000055a23ecf4630 RDI: 00000000000=
00001
[  469.411784] RBP: 000055a23ecf4630 R08: 0000000000000000 R09: 00007f2d0b7=
b64e0
[  469.419618] R10: 00007f2d0b7b63e0 R11: 0000000000000246 R12: 00000000000=
00002
[  469.427451] R13: 00007f2d0b7fb5a0 R14: 0000000000000002 R15: 00007f2d0b7=
fb7a0
[  469.435299]  </TASK>
[  469.438191] Modules linked in: scsi_debug xt_CHECKSUM xt_MASQUERADE xt_c=
onntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_objref=
 nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 n=
ft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rejec=
t nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip=
6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrac=
k nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security=
 rfkill target_core_user target_core_mod ip_set nfnetlink ebtable_filter eb=
tables ip6table_filter ip6_tables iptable_filter qrtr sunrpc intel_rapl_msr=
 intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel=
 iTCO_wdt intel_pmc_bxt at24 iTCO_vendor_support kvm irqbypass rapl intel_c=
state joydev intel_uncore pcspkr intel_pch_thermal i2c_i801 i2c_smbus ses e=
nclosure lpc_ich ie31200_edac video zram ip_tables crct10dif_pclmul crc32_p=
clmul
[  469.438399]  crc32c_intel ghash_clmulni_intel ast drm_vram_helper drm_km=
s_helper drm_ttm_helper ttm igb drm dca mpt3sas i2c_algo_bit e1000e raid_cl=
ass scsi_transport_sas fuse
[  469.540513] CR2: 00000000000000e0
[  469.544603] ---[ end trace 0000000000000000 ]---
[  469.662129] RIP: 0010:down_write+0xb1/0x130
[  469.667027] Code: 00 00 00 48 c7 44 24 28 00 00 00 00 e8 98 de 50 fe be =
08 00 00 00 48 8d 7c 24 28 e8 89 de 50 fe ba 01 00 00 00 48 8b 44 24 28 <f0=
> 48 0f b1 55 00 0f 94 c0 5a 84 c0 74 4b 4c 8d 6d 08 be 08 00 00
[  469.686477] RSP: 0000:ffff8881963bfb50 EFLAGS: 00010246
[  469.692414] RAX: 0000000000000000 RBX: 1ffff11032c77f6b RCX: ffffffff9b4=
379c7
[  469.700266] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881963=
bfb78
[  469.708113] RBP: 00000000000000e0 R08: 0000000000000001 R09: ffff8881963=
bfb7f
[  469.715959] R10: ffffed1032c77f6f R11: 0000000000000001 R12: dffffc00000=
00000
[  469.723809] R13: 0000000000000000 R14: 0000000000000002 R15: 00000000000=
000e0
[  469.731669] FS:  00007f2d0b884740(0000) GS:ffff8886ed900000(0000) knlGS:=
0000000000000000
[  469.740476] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  469.746931] CR2: 00000000000000e0 CR3: 000000012ca86004 CR4: 00000000001=
706e0

--=20
Best Regards,
Shin'ichiro Kawasaki=
