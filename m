Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC1C001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 11:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjHJLmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJLmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 07:42:09 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325791
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691667728; x=1723203728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gjqdKfr8bpNnqk0PVtFqNiZ2UJsTRK0n0VT4y+xaT8U=;
  b=Xjf3OV1NOwK3z1lukPqav448YKmJj0gvyCN2ZADxJOqIUrsq4jd2NZL/
   d8oYrMa6MM1Ylk07/fC/0Zk1NWg94941b90VzimSA7kyKOU0U1kSW9tnP
   x9xbiCT3XE/hOUmQqVEozwHyN/pMisIFdHjFX1jJ6A5K/JE7TH6KlEtyF
   Srf5XvumNXJ3ut8fd58hH/RDZMI+5+MJuSgbjx7ZUZdWnVk9lBLHDKOPB
   HEoVS0YbuYfc92NALpXyRMWHpZ8r8ELJ7HK3UeLyFbvtuHr/K+x92gDyA
   +BwsMc5jACfsUJM4TXZdEwfLF6u/fjboc/ok9lgXh5vtrDhFV1Wjg+V8O
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="352669016"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 19:42:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un8Vl8EcWTKY/aYR0ISI8kZzyYm9kiB5ExJhD84AENB5XV2vOu0jn3yOXRYs9nBwvg6xJWdT9Xa85lGrwzVDRc+iuzzGF39qWU4ZROhbDJvomeNYUqyzz0bUdbOByzItwWYqMK0/XT2YrdCAxACfUFKFObLXs3Qe+VfYjftPxNbGvQPg7b6NfKTy/G7ExdVwJ0RynAlgr1zGu/6gm+JWpINbFjOg+MeymYn085NfHSSB284wMdHqn0V9VVW0NWiuG5qwK387EsreMVn3HQ7mXYK55Mu7f9Ug6H9YmdLw5sUVT7hDLPjdgrDwo37iC7svUBt6NaANvcunpp6VwwiwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngFXc8dfTByp7DOy7A7SKyrzp8aoDqwzxKwjOGmlMx8=;
 b=SBGP09wW31ezpfYwhNXtencsUYvxOzx+gc8L7y2ZquGxmvekv0HO/2UioSRETwLqDv8tAeKK+XhtFoSXA1R6aTPn99aqll1mEztuR+gfGdBEoU9707s7O/mGrjjGrGN4z97Yvi8oe6WS+FoAQ4RzQJ9cdLiEp64RWTlr+axDr5MuNcNU6HgtwIZ6fdPclAuVld58aGzefq6yzh1dB01Jd2ioC0E2OVTUipd712p5mNPtt5rWDYTbgHeCO/VaUE8pvuaEBRSLzESE4B4m7F47LMoNkMT88Wl3AkOTDY4rV2Bg1jzuK6vpU9YKvNQ2Rx5T1EBpg88m0oN4fnykpbx9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngFXc8dfTByp7DOy7A7SKyrzp8aoDqwzxKwjOGmlMx8=;
 b=vWvXD2K1e06rTvjACdZe0ItuuaRJMOo4YU5m/Mfh2IEy4M9cIs3p1WqwpWXpWudPV0H4+0VGt5cSTwRPo6ROx9Lz8VQKy5FTQXLx2+0iu8dX0gtvjx2/xUQNF9DjwmgZ2s7DrQp/qxzIlLlXbrClVeanQPQUdp0TorWb8TQ4nHM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7151.namprd04.prod.outlook.com (2603:10b6:a03:292::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Thu, 10 Aug 2023 11:41:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:41:59 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Thread-Topic: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Thread-Index: AQHZydThaLSaElB1oUmqvdDBPohT9a/iL3yAgAB9eICAAJaLAIAAKC0A
Date:   Thu, 10 Aug 2023 11:41:59 +0000
Message-ID: <ub6fdhg4utcdsykexuskiylems4qj7czpbi2umb75gazddmcru@va7rzcgs4wur>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
 <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
In-Reply-To: <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7151:EE_
x-ms-office365-filtering-correlation-id: da784241-9d2a-4680-f1f1-08db9996ce8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8NZx3ASCOiqSnkB3TQXODE52747AoFzjFD2no/4cucKdgE23+2Vp8547aRn7VdMHi4upsugQhKo0jS/ngWA3ZwPilx+BEtXt3/oO50Uv96Zdn2B04YLDGrpwQNlcjGvQ8B3JCuNZ5++5LSpvb805Opg8GvT6F6UgGwRqEfD5yY+Vwcb9fln8c+SPnJeczpL/Kctx2PzjqFw07xRHy4o1hCNZM8lCvVMAUpJmcOrashDhpwAsuYV8tptyHwhU2It1MZbQBOWNQzCLZkHyAGYAeJmj2Ky9mIFMzMxp/nXIMuBZHnleKMUyvV8dG1X6M2ua02yc7rqmV4NYURwJ3NBsjJzJYDBGxUVZuGjIvbDwj8m2S2cMFaUlLNtqFncxrajUJCb0I08/r9tocxiNNqIO4CusnlQC/AmDtZN7x50o5UU7VRx+bbgkBd+ZvBteWpIzSW08W+28DAHrpWsGjcO9l8BuElhcEsPirPBoQlxOUvgjcxB1xlYau2q/2BKyzCUDl1dNh8dp2sDmiwTtm91WR0PGlc6FCSGbfscBSOIlC30x1yTSKerefaIcwf9uJzlpBzC7ghb34L6IuWQYrNUKj+FK3Bvwuqbc8lDnx9jyWfE3esFiQpmr1mHdnAQ8Mvh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(186006)(1800799006)(451199021)(38070700005)(66476007)(6916009)(4326008)(83380400001)(316002)(66946007)(76116006)(66556008)(64756008)(33716001)(6486002)(41300700001)(8676002)(26005)(38100700002)(5660300002)(66446008)(71200400001)(8936002)(54906003)(6512007)(9686003)(91956017)(86362001)(6506007)(478600001)(82960400001)(44832011)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w4TK2eQjxBVfHUqNaWCPcfG1so3q1pFkpcnceiEC04aga3ppF6dgM9X/3/AU?=
 =?us-ascii?Q?Gcc3k49D/PFPsVGZAsM7es/Ag81Ds9UM9rwqaHttgXR8aEPtXwWqcjYWc1lx?=
 =?us-ascii?Q?w0BWm8yTYbs4Ml3Oi7qE7nKRDnXt6ZFAeQ3JWfJ4vzd2Hgl9g0jrSUqLsOHN?=
 =?us-ascii?Q?KAVgckucpgJc+6NhjetW1c4zyh5GCjkhr+ttee8odKnG9USWVFNGqGiMUDEH?=
 =?us-ascii?Q?7G/xuDkczNFur2cWHTszftGoZHZ2Be+zyBtqhCPdwlByi9TjVQajPZzsbKdk?=
 =?us-ascii?Q?3iInzYEnyIyTu57bzhib5mmVvBn8oj+v3YE5sQNVxzcm4mUINJv3YbfgA99x?=
 =?us-ascii?Q?Iudm5+id6+EivW6imR9+4D6nQgOqG16o4aiPNUTr3rFVzk6oKqW9EDFFIZEb?=
 =?us-ascii?Q?WDPH34yaF/h3/6fV2rUN/XN401Mlj3o+1WbWlCa7hGqHg9NUXfFloEGJgr4C?=
 =?us-ascii?Q?PnaynKEN+MAqI7F8RbQ0MnePOVRKa1aSrzlNDNO5GEaQusuoSEZrU2mlKCZI?=
 =?us-ascii?Q?iJWbDpIpJZCFpadhT1hHZ0RG+xLOGjXI03SZ2DbJpQ0/65+tVVyiq3uTtpYd?=
 =?us-ascii?Q?TNJxB9/AT0HvttWnNmzQslopnDZ5QgbbbNrvu0Q4dbZE2NaaZbDNQJlZ5s0U?=
 =?us-ascii?Q?HD8QLCmW7LSUN0rZ/jUinUDZKDCe1df3sAtk4BaQybEYPW9LpPkW+XGLQG5g?=
 =?us-ascii?Q?bjOiwVLrS2cu0jnaCVNpLm6uww4/SyeEWDcY8g5cDZThNRM8jisbUYcYeDjQ?=
 =?us-ascii?Q?AK0rFT6cuXWWg3Vs65iJVCI1k9iAW4f/36euprBJC+39nSWDcTMJqI4zPCht?=
 =?us-ascii?Q?rvnAoZ0UL3BHg20Mbf0RLSMvOrKiQW2zDW31MwYHoAY2ybRWLTkoGdsBb0mC?=
 =?us-ascii?Q?MFQanar9ZdV8OPLWfFBomLLD/kArbCNxZjlenKf2T/lARR/NLIco8/ywWGTe?=
 =?us-ascii?Q?jBxKjGr99+aEE13S9DwXEsPeGbvqiWTN+tvhbZV6fNRLoVKglOutKtgB3myW?=
 =?us-ascii?Q?DXndhwclOvGyzsrdtQJ7aogBu3iSLkn8dqBVMKGjjGXtCPh+T0dc+Ddz/BHQ?=
 =?us-ascii?Q?OlQGkQLDxLJ1Q77ffOjxoxhPTBH467l/hbz6YieySUCgt9x5mV6zWkxN5CJ3?=
 =?us-ascii?Q?hhnrSG7qXRVeQhF8CIKIl8iAWli5ExnAfilc7s8oAB7DFYL9z/MK0xnTd9JU?=
 =?us-ascii?Q?1ccTIo9Fu8qGWmwSn3NUur6oawr7tXzU6MmeEMizT/jYU4ZuR97fVfA4BFTb?=
 =?us-ascii?Q?4GZdOQtZLQH6yfiNZqeh4y8osDXKb7oRkNZH95BteJgzmi/7YvJ6xF7PZYdA?=
 =?us-ascii?Q?jdYjNxy43qbQ4v5bT+S16OlWKzqPY0crxKCa6LtYYoxkDklEbQWsN6YyK/j0?=
 =?us-ascii?Q?Pm7gzbSgBxQVjpf0tm2LgrIdDDODUDwKl2gQCZa96X9QzzgHdoQGOBvAFsCb?=
 =?us-ascii?Q?99LdGbuRVs226/kB8MWcW7ttGZnWHrgy31gi6tS5oDm9sfsenx1NFMbb1cRJ?=
 =?us-ascii?Q?1MeGn6Z8kcr+GxOiZP6UCLO8XJWDAW9RejZoKmHb6+Mi/K9A//PkDBrRKcpo?=
 =?us-ascii?Q?CpBgccaVEU8RoEdZdYxivdvVWTI+l8OLyjqVZrITaLZYMuQho0OhrPr2+vqS?=
 =?us-ascii?Q?x/8pRWEMdBVkF/3Tr8S6+IU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E00BCC1D7841642BC38A1489841E817@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bZZt0Flg8newf2Jotj2/2dZLBMXPjOyUYgnUY8FDu63MsCNrGnFxz/2+pZC+vm1hzr58oscFYbArRUsYx0DkFh3xPHvCyZl623buIoB6MuSDZGwN/Sn9AJQ/kFtp0w7Mkhn/wMaqUivF3rZCq62eiNVMBtIEaJJwxMmntUtzJB5z66h/gBpRdKa5AE9GyWSZO3sDNcOYca3d7tFpHHLzqK6Mhgjk0mN0S1qOdFczeQJr6o2TD4al1SOrFQJ1vx2vRgroNJ5FeR0cRm2x818hFmFLAU+kuPUKmo5A8iW11hjCVPjtqt3ki5sbs3eY8ZajBHuEQ1d5SqoBR1Vjhqc1gjgSZRtI6feqSolh45IlPxT4e82pnn8GsLzJCdnBExJMV1lGecGhrTxGWlqQSgMbDBFv9tHV0w357RYwSUU4PlyFt75RtRD8pufwC+m/AP8hKkMW2C6nY7l8iKvQawpqTk1J9mBze5B12PdV9XMU1xDMFDgfSQH9oT45HQQjbDNjCxYtDeK2ckHV1a63ymMw+aeah1px6juPWTgBY0WQx2fAKODLG1xGvGIkYucYGqufbFLyqJZ1lgoFh+bV6DqdmrSzpwgHxJ4SGmqlGx4anKX1ey4JX3lqBnFUynDSazSLBd1XTEXDFxnzT+QaWr9LTkuzFYPFfDMP5xhJCC9thy9IGeiZ8AGWA7j7LiO3nd1YKu1+OkpR4NzgDU3m8m/mqySLSxw+7ND8RCJhYHDijut4krB/urS2dBkWa4aykkjfvCVe/Rlq8U0iyrBg3anAaRsQjbenmEyP8q3DmOvd6iPX6kfZJuQ8Sp0rrMyef3oTKULlFMEyJ6MMjgQXuOd7Xs8RU/koHti1Z8JbFstzoVADqm8d+xim5ELWIemoeowp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da784241-9d2a-4680-f1f1-08db9996ce8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 11:41:59.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /f3NtlJSwhlBFhhAcQ6VcWRj+hj6nt2TEVsCpYKg7XE51YM+4vj2v09zVw542Mnzs+YGSWmiS8R91TxOSTTk0MaOckEHjIPW2VzSQFqZNMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7151
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 10, 2023 / 11:18, Daniel Wagner wrote:
> On Thu, Aug 10, 2023 at 12:19:39AM +0000, Shinichiro Kawasaki wrote:
> > Yi, could you try and see if it avoids the failure?
> >=20
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 4f3a994..005db80 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -740,7 +740,7 @@ _find_nvme_dev() {
> >  		if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
> >  			echo "$dev"
> >  			for ((i =3D 0; i < 10; i++)); do
> > -				if [[ -e /sys/block/$dev/uuid &&
> > +				if [[ -e /dev/$dev && -e /sys/block/$dev/uuid &&
> >  					-e /sys/block/$dev/wwid ]]; then
> >  					return
> >  				fi
>=20
> The path for uuid is not correct. It's needs to be something like
>=20
> 	if [[ -e /dev/$dev && -e /sys/block/"${dev}n1"/uuid &&
> 		-e /sys/block/"${dev}n1"/wwid ]]; then
> 			return
> 	fi

Oh, right... I think /dev/$dev should be /dev/${dev}n1 also, if we will add=
 it.

I guess the current for loop keeps on checking the wrong uuid and wwid file
paths, then it does 0.1 seconds wait 10 times =3D 1 second wait. So, it doe=
s not
check readiness of the found device, but the wait allows the device gets re=
ady,
and achieved what the commit c766fccf3aff ("Make the NVMe tests more reliab=
le")
aimed.

And I think this for loop to wait for device readiness should move from
_find_nvme_dev() to _nvme_connect_subsys(), so that wait is done even when
_find_nvme_dev() is missing.

P.S. I've just noticed that you have almost same idea in the cover letter f=
or
     the v2 series of "Switch to allowed_host".=
