Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F76C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 11:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBPLxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 06:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPLxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 06:53:45 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7E53575
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676548424; x=1708084424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i/tcY9aKcAeoE85ESjwUOEtsIFMMN5PJd668avVgpOc=;
  b=HmLo/7PVPTTnt6Gp9P81Hv7ZdX6YCcr0V+fZDbfe0O2qG2dPvbWnKF6y
   vkvBUR/tuCzVJLQkx/CEf0EUJLlPubxvbnvP+Mq82otrWBBmLatRugCLl
   eJlaakLwqrXeZG4HRKsEAYz1hoQv50xWF/XabePX/sJ1uHY4RbWBjyFhm
   cYqqONETAutVmHWZs9SNI0zhf1E0hVZiSsF5ba4s+6uTGEUj7sARgyHzP
   YFkS53hgpa89Yf+UA7A7+U5Cbd6PmVIjMxDrTyB6+NF2cQ6OyCelI9ahA
   D0o24IFtZgDbHfoGKm21jHe4JnvZr03fzk1gtBLRNU+4fo9X/mLokqvcg
   g==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669046400"; 
   d="scan'208";a="335424984"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 19:53:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpeD1G2HlHZ+2sULE6HwFyCoYcvQJBStzt6cccBhh49A5uK1siZIFei8KH57rG1X/iqXzcEuS58jDAg7x7XkGDVmbQqPfGIjvT77r+KWhSOhTnJSy0O9B+TdYXGl9isMJa4GNF1SqD4Q/U1tFuvo2ndWMtt+0ON0WL5jceM7TrVVVPQ/OYNQXRybzokJcZH+4/9w0MvxXQRAAbyGA0psXgdwgCP4uxzZeXBAS+CZ9U8OwQF8Jq6NLZop6oD54s41ZOxrDmqqkfkYj0wJCmS01Vaa96Q7WBaZRemUHxmna7S/gIe0T+dt3gAg7vmZuoUQkzR5MjsynBPINDdnBfB0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLs6L++JvRw+a03PF5RkZ/7rkW0Vkuubc+94il/HSjc=;
 b=Qspmfk30PRzkKtZe0rTigeA/EfKA6p84B/rXDTHYAydJzGUja2kNBjwLggeE0WUxxrqCIa+xWoVPGrW2RKjMTxLs2Z1uMr5r4zlUxbKfSIS2DN6k3SF7Imli3gFp2gNElIFwUnIeGCDJHOd+0+NZCXI/p8uiY71tWP4ZGmQNPIro21BdOVvUtNTU3muW00ErIrMHUQJEZbTgDpItdo6fMGvq2MWAl0J4VcuZDJbxjq8SQfOQneQtuQDlqa3KM8MoxA96F7D0KXqSgFZz3LSnmFecFCoPY3wctV2Y2qUnSQ1gOQjyE5JA1UedzmgjpD4ZqycRzGNw8VBpBpo92SW57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLs6L++JvRw+a03PF5RkZ/7rkW0Vkuubc+94il/HSjc=;
 b=uYjNS3c0mG1CrAwcE0iuVYd6oZjAHalt+jemOnyhmAPr1Dc/xZfTUgUH3RYRbvaoVOXHeI/wTPutL6MbEIbOBk/Lyk/PEIgnnF5z/P6lunXGFXrd9jLEcN9IokqbIVMZ4Mxre1/w5e0j+RuBLKV5SGbUkdP7ZDFoQDm7ceRXEW8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4102.namprd04.prod.outlook.com (2603:10b6:a02:ab::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 11:53:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 11:53:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] blktests/src: add mini ublk source code
Thread-Topic: [PATCH 1/2] blktests/src: add mini ublk source code
Thread-Index: AQHZQbMmz/+Gl6q8Gk6d/h52HlK6E67RO2sAgAAKuACAACT6AIAADBkA
Date:   Thu, 16 Feb 2023 11:53:39 +0000
Message-ID: <20230216115338.z3mi6ofxde67l76h@shindev>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216030134.1368607-2-ming.lei@redhat.com>
 <20230216081938.oyc6ys5zo3bayrqw@shindev> <Y+3wGE9IiHIEECvO@T590>
 <Y+4PHBqOfAJwSKcZ@T590>
In-Reply-To: <Y+4PHBqOfAJwSKcZ@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB4102:EE_
x-ms-office365-filtering-correlation-id: dd875b65-ded3-49af-6369-08db101471c0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9G8EBHcz+3PcgY1n2vBcjr4OzYUA6Q4udnBdofraNdaL0ly6uAOYV70C4Zfw/z0R1QnlQBx0t0X+BVfeae6HQcnBL/csYJslHO7+RL5lavC6JNlby0kgWfHNk4DmW8uOtLWkMU2NTD+pbcqrwxzfvJmTDqhsL3mcZzR7NFDQSClPyPmArotLL+qq6pVt2XztQjy4x4Bw94EGmgjt/dAW1NQzieOxtUQfvg8mR2NvXNFhADYurDJlB/EHX9q/37D2qThRbm0zhqXehj+/Z0irjWkIGCN5xhib/1fdaqdrS/ybW0QTBlgsuOSH0D6utm4ZDZB0nWDVDGK+M+DzLCxw3r9zsxRv90q0H8GRtSYxsR7JwkGYDRoNE7w3QavhMJSHxJdVyo5W5ulc75kcS7wrg7nor7K/5dQeTiX4Hpe+9nq9MhPGjq0J2vDkQ4sbm9JCPtuCHIof+RErzvd7B1xBuKKf0uJ9d/eyRRFQb53iH0yAEHvZ2WWDJrwbgw8MqwTJ+XeNgLH/5dqYJx1ebzFTgUl7QQ+Vj39CQCOc1ew9kW2q87oSx3mA/HSFGrEawo79k9dRnznAgizfWQXnVoqQZD1ozt8tJ30YTktPBRcawaXcXOVtEC8Pv22CsX9dKk7pdulHwDVbjmh8xjBD3vIft+WR2f4SCxR3X2roVIKxptPrYprEPkXLqLqOkA1OJj//DI8BxBTzqQXdUGiOwDlxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(76116006)(91956017)(122000001)(38070700005)(38100700002)(316002)(6916009)(64756008)(41300700001)(66446008)(66476007)(8676002)(66946007)(2906002)(66556008)(44832011)(4326008)(5660300002)(6486002)(478600001)(82960400001)(8936002)(6512007)(186003)(33716001)(9686003)(26005)(86362001)(83380400001)(71200400001)(6506007)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mi7VtWi1xmk+UUK2smq997/Wzgd0qj8OAZot52eWwc4D1nrXcfFvuG8NfZK6?=
 =?us-ascii?Q?VTXWhkGJ12C77hVQO4+uPAyCwNyPgl+kFGXLJyxpD32mgU6A11/OLAcp9WQk?=
 =?us-ascii?Q?uwpW+/XWPZ4hbwKOIHqyMhPkiKVUQ1Tc6HDvOqkv2LvgbtszPPyE+5WowvWc?=
 =?us-ascii?Q?zgjDvYDH9v70pRUb5dSSwTPCYczVdCM9I0tVhaMdV95h00SNcSnjcj1KMtA/?=
 =?us-ascii?Q?AZVuTdwGekhzAxArXZ4Q+FSb1fvC5MNXDx+lKLciMMq+D8wvaljo6ClSK3N+?=
 =?us-ascii?Q?VfJMmELiobgbtekmxHEttOUC5t29RKNOYZRekvv0IfT4GqUJxdkc25tXhXYK?=
 =?us-ascii?Q?POakBpsDRX536DOp5KoTwN1AH2pf13s5XJHkxHqBpW80gAWs8ly9QOj3TrC+?=
 =?us-ascii?Q?WFK6IiNC1QSK1OYl+HzYsfpdXuDgAQPsaL6U1xLrYogbjuhDNHB55/QJVT1L?=
 =?us-ascii?Q?/YK+592x2sJ9YzVymYi0+jCNZxnfD75LuB2FoDGBhCtsl9DiRynzr7CslZ3z?=
 =?us-ascii?Q?HBymiI7UUNasRSNeyJlyNyj3tyBt5qZEsPaDgiegeYF7S3hLvyr3czsQFsAE?=
 =?us-ascii?Q?by3+M+Eitv0forKf/ZVkMTMzsfJu0cwV61V8TzxXMPckNQoRtrknlNAUoByd?=
 =?us-ascii?Q?zfmc5MPjNrZHLYbYHuEsrcDIrGtt2AuqQuJPKYYKl+SX3W8JNJJTwHG4krEs?=
 =?us-ascii?Q?b2dumV4XBPxQr66mRSNRXrOXDj04ziBya25EtAOoaXb5qmEAmqCgrETQjivn?=
 =?us-ascii?Q?UwAa692WiEhs7svsRNdnt3QkPRLg7n33iQiqcLICKO4W51TAVFCpC4B2vSpP?=
 =?us-ascii?Q?Eno6LZVzYYzRD4z9THE+/G5MB3o13rMDBnImBVreVvGN0pfwypI5YBlLzYWb?=
 =?us-ascii?Q?JLAC+j9Yqrwo9TIExd6hOofDkYcPhFvSBWAXS39CsadS2agNYKNiBwIkjV96?=
 =?us-ascii?Q?Q8RHnUigBuF8+nbRiGjB3elUitsdHDO0ydnudbIP8wpfEQ7JKYSeVimChrUt?=
 =?us-ascii?Q?ofEWF5m0qAqGsrEV5caYzUpYJE3VromnLLoK4snKhTqC+xtfqPlDhZJEyxnN?=
 =?us-ascii?Q?Uj17hskySnZfpTneSZZrTNAUPxDHX770l9RFsxUZSG5KIPVQ8FOLYAZo204u?=
 =?us-ascii?Q?vkzUpmnJ8CipmTAeItCwUGkbZOJmbxtOMm4g+DgIgJrobB7ODi8jnTx4vbuC?=
 =?us-ascii?Q?Xq3mrrwTyD2bitIkEilVlO8THCsbX/uCWl5p/aNPXfCJaXN5OGTUrmOwRJbu?=
 =?us-ascii?Q?Ndhyx4sUTiF6FGieKHuOJ3CaiSknRGCCvjQPZRENEytErR/FwKuaUr2f8IzW?=
 =?us-ascii?Q?97UFTMhLBaQWzHdA7F/qDl/gwR+i5eTdcUTAVSZdb0+Gx3VZdFozy/g7lYdo?=
 =?us-ascii?Q?vOzvpMIEyqJ+i0HkdM+hEa1sQEP0zvppgBFLRlgW3fDOKA4Czvgx0ht60UN/?=
 =?us-ascii?Q?rEFzp2LGsjtPZq+VuZNMkH6alErqTsdz0RGAij2N4GRox82iNuG1vY+3Z4Vn?=
 =?us-ascii?Q?V0JtVkCCppwa4C/MH6AE1CeHZZf+6IdoJp7SQAGn0cltM+2kJKVfBpnnEZNe?=
 =?us-ascii?Q?2C+qLqpmL7iX4zGZzmXCocspfzdToIjxOepQ3pW93GaQ8zkUFO2d0Kzdr9Rz?=
 =?us-ascii?Q?PZWb9OEiSil+CbdhQkJEzoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F9578DBB8765F4783CD9700CC0AF76C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nvgLD+GLV4QzVk8fc93a4879SW2kyVx93VWnE1GpK2rSRrcj/NsWil4j2emzFpcVZxVmQYGe68IOXHDwv8BBYE9IYzofHsjTVBTL0MP4aCfkp7P7RAs8YRstmd0k9xl7saaJAcgtAZCyYTbscYfjVA8PGrQFIfrertttGRAEnTg3LNGIFTHZZoqiX+bHjyif5aw6xIsUNWO7M3z8QnvV0Fk4X5fmdEhxUnOwG2D1d4ZugwoJB3ZHOodUAcZrxykPsV9ZAUVCbJsZgCylZdPN6Zfyqn6iq1GUQUyYEyvUDEi3G0SmFsOx7WE+OInpdt/Nk44KnKEXtvSI7CknOAO4wPEet78J0JH+lcWQt6bhDpuKgexJjOhnOSXVflKNTHvOPFcSsuNK5rdd7OBkgvvX6c0BJjMiws9aPH7kwqz/NVBhky5EAXTwajXTMSR61K12dzHf+cUXErwcQ7rhV9HiuxhP7Ty8VDRdk//vlcCfxhQsQSMJQyal9wVGwvpV01Rne3KH/6VK7+bxJkxjXRaIEpkKcDSvct2t16cTYigqY9v2iCkRBsAuKLzRgRBME1KNuEy6g3STusuvkATAs2pdbuZc0R6ZfS2YDSXKhdUchstpefM6J6KnwXcPh30apTtpWv6WSnMsS96beb6ZZQdt0tPjAHX9RVd1HfJoKTAsK9/6TdfPIdLJ7Y+ZQO3jh5zxord6PZ9KR3GL3h/ffFp9SgWXa0qsRZy3Qhgo3Ejg89Ztl+6tWndnevsDx5TUhEz2CTWE/brs8se8PrvTMasdYV8ExToqosp+ZxtAQlWv0bmbUzsCxXGy+0zVXjBATZUO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd875b65-ded3-49af-6369-08db101471c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 11:53:39.6568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiEn5+yYqwtoAxHnH5BaEaRZo2F5JywuP+vSUh5+06Q4nVx6MMVZvWS5KeLaa+YHQ0H7vw84kiOcJFxOaj4ERR+Mbhax54mzXPbqKrZodjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4102
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 16, 2023 / 19:10, Ming Lei wrote:
> On Thu, Feb 16, 2023 at 04:58:00PM +0800, Ming Lei wrote:
> > Hi Shinichiro,
> >=20
> > Thanks for the review!
> >=20
> > On Thu, Feb 16, 2023 at 08:19:39AM +0000, Shinichiro Kawasaki wrote:
> > > Hi Ming, thanks for the patches. It sounds a good idea to extend blkt=
ests
> > > coverage to ublk.
> > >=20
> > > Regarding the commit title, I suggest this:
> > >=20
> > >    src: add mini ublk source codes
> > >=20
> > > The word "blktests" can be placed after the word "PATCH" as follows:
> > >=20
> > >    [PATCH blktests] src: add mini ublk source codes
> > >=20
> > > Please try --subject-prefix=3D"PATCH blktests" option for git format-=
patch.
> >=20
> > OK.
> >=20
> > >=20
> > > On Feb 16, 2023 / 11:01, Ming Lei wrote:
> > > > Prepare for adding ublk related test:
> > > >=20
> > > > 1) ublk delete is sync removal, this way is convenient to
> > > >    blkg/queue/disk instance leak issue
> > > >=20
> > > > 2) mini ublk has two builtin target(null, loop), and loop IO is
> > > > handled by io_uring, so we can use ublk to cover part of io_uring
> > > > workloads
> > > >=20
> > > > 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> > > > add/delete disk dynamically, this way may cover disk plug & unplug
> > > > tests
> > > >=20
> > > > 4) ublk specific test given people starts to use it, so better to
> > > > let blktest cover ublk related tests
> > > >=20
> > > > Add mini ublk source for test purpose only, which is easy to use:
> > > >=20
> > > > ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> > > > 	 default: nr_queues=3D2(max 4), depth=3D128(max 128), dev_id=3D-1(=
auto allocation)
> > > > 	 -t loop -f backing_file
> > > > 	 -t null
> > > > ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> > > > 	 -a delete all devices, -n delete specified device
> > > > ./miniublk list [-n dev_id] -a
> > > > 	 -a list all devices, -n list specified device, default -a
> > > >=20
> > > > ublk depends on liburing 2.2, so allow to ignore ublk build failure
> > > > in case of missing liburing, and we will check if ublk program exit=
s
> > > > inside test.
> > > >=20
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  Makefile            |    2 +-
> > > >  src/Makefile        |   13 +-
> > > >  src/ublk/miniublk.c | 1385 +++++++++++++++++++++++++++++++++++++++=
++++
> > > >  src/ublk/ublk_cmd.h |  278 +++++++++
> > > >  4 files changed, 1674 insertions(+), 4 deletions(-)
> > > >  create mode 100644 src/ublk/miniublk.c
> > > >  create mode 100644 src/ublk/ublk_cmd.h
> > > >=20
> > > > diff --git a/Makefile b/Makefile
> > > > index 5a04479..b9bbade 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -2,7 +2,7 @@ prefix ?=3D /usr/local
> > > >  dest =3D $(DESTDIR)$(prefix)/blktests
> > > > =20
> > > >  all:
> > > > -	$(MAKE) -C src all
> > > > +	$(MAKE) -i -C src all
> > >=20
> > > This -i option to ignore errors is applied to all build targets, so i=
t will hide
> > > errors. Instead os ignoring the error, how about checking the liburin=
g version
> > > with pkg-config command? I roughly implemented it as the patch below =
on top of
> > > your patch. It looks working.
> > >=20
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 9bb8da6..c600099 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -2,6 +2,11 @@ HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>"=
 |		\
> > >  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> > >  		else echo "$(3)"; fi)
> > > =20
> > > +HAVE_PACKAGE_VER =3D $(shell if pkg-config --atleast-version=3D"$(2)=
" "$(1)"; \
> > > +			then echo 1; else echo 0; fi)
> > > +
> > > +HAVE_LIBURING :=3D $(call HAVE_PACKAGE_VER,liburing,2.2)
> >=20
> > I tried this way, and it fails in case that liburing is built
> > against source tree directly. And liburing2.2 is still a bit new, and e=
ven
> > some distributions doesn't package it. I will think about other way
> > for the check.
>=20
> Looks the following way works:
>=20
>=20
> diff --git a/src/Makefile b/src/Makefile
> index 83e8a62..adfd27a 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -2,6 +2,10 @@ HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>" |		=
\
>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>  		else echo "$(3)"; fi)
> =20
> +HAVE_C_MACRO =3D $(shell if echo "#include <$(1)>" | \
> +		$(CC) -E - | grep $(2) > /dev/null 2>&1; then echo 1;	\
> +		else echo 0; fi)

Oh, this macro check idea looks nifty :) It looks working in my environment=
 too.
When /usr/include/liburing.h does not exist, $(CC) spits out an error. It w=
ould
be the better add one more stderr redirect to /dev/null.

HAVE_C_MACRO =3D $(shell if echo "#include <$(1)>" | $(CC) -E - 2>&1 /dev/n=
ull \
               | grep $(2) > /dev/null 2>&1; then echo 1; else echo 0; fi)

> +
>  C_TARGETS :=3D \
>  	loblksize \
>  	loop_change_fd \
> @@ -15,25 +19,30 @@ C_TARGETS :=3D \
> =20
>  C_MINIUBLK :=3D ublk/miniublk
> =20
> +HAVE_LIBURING :=3D $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
> +
>  CXX_TARGETS :=3D \
>  	discontiguous-io
> =20
> +ifeq ($(HAVE_LIBURING), 1)
> +TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
> +else
>  TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS)
> -ALL_TARGETS :=3D $(TARGETS) $(C_MINIUBLK)

I suggest to add a message here, so that users can tell that miniublk was n=
ot
built.

$(info Skip $(C_MINIUBLK) build due to old or no liburing)

> +endif
> =20
>  CONFIG_DEFS :=3D $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZ=
ONED_H)
> =20
>  override CFLAGS   :=3D -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
>  override CXXFLAGS :=3D -O2 -std=3Dc++11 -Wall -Wextra -Wshadow -Wno-sign=
-compare \
>  		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
> -MINIUBLK_FLAGS :=3D  -D_GNU_SOURCE -lpthread -luring
> +MINIUBLK_FLAGS :=3D  -D_GNU_SOURCE -lpthread -luring -Iublk
> =20
> -all: $(ALL_TARGETS)
> +all: $(TARGETS)
> =20
>  clean:
> -	rm -f $(ALL_TARGETS)
> +	rm -f $(TARGETS)
> =20
> -install: $(ALL_TARGETS)
> +install: $(TARGETS)
>  	install -m755 -d $(dest)
>  	install $(TARGETS) $(dest)
> =20
>=20
>=20
> Thanks,=20
> Ming
>=20

--=20
Shin'ichiro Kawasaki=
