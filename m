Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F750C0015E
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 00:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjHGAKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Aug 2023 20:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Aug 2023 20:10:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E65CFA
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691367000; x=1722903000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6SLR8kGYjAySM/GfgP20BlO06tVDMMZcx1GEUbsQrCg=;
  b=CfRUVkzZyQ2S3Ki/XOiBMWu7XKFgZLpHGbT67UVgbrPavO8JTYuAQFrJ
   usibLcz3MUr9fWJPPZo7bxMmUx9qNOt6c2ZqIqGnQPgqlrHRBjDebwWmz
   HJKobPr+XZAJjZo51WKILZ7dg8+6DjhGyPzoQBgtaJ5va2meIfFz2gs0k
   CDceFJnjSzEQkejF0Wacad4uzCrpuOh08TvlWTNMyYhTsa2k4A7NFqmmw
   uZ4M9lz4a0abtprZy00JbAXid+2B3yFDyQoI+888HLc0cKVyYebA8J4Ng
   yJl2NAjcykzIMLGvJY1rJo63wrwjiBycEsnsLw92pM2ybgCkCrTDVCQ8q
   w==;
X-IronPort-AV: E=Sophos;i="6.01,261,1684771200"; 
   d="scan'208";a="238586857"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2023 08:09:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSUFOS2Y+xk0RIY+bmNs6DGnZP6Kl3S8FFmi6z6VVnqEiBVA1qr4yGXNrjdFZ812nobITiV9Y3bhQUH8DjjAVHpmMpcaM60LCP9gLjsuYKy21Wo+tNBYw65cST8RowMCZmwyfUtFg6YhXT/78MuPngutV641hEDPobvGhEn3lCBbkseUSv3BGgwGwtimUTP+EnGKYy3F37ydukitZqE/1Cin9cA/WUaa0gBFO/TDLcntsYYX/0nOXnf7pxKGqMZVtZ5C6RBXZh3+oA8ybyeOzx2okanJJr5IuXG8fOxfx8oNtFE5BUK6d7D20sRyfzFWfRqnEqihYrNAoelJzjZxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faAdijuxYtTuyzbpx5smjMbESrEJK81MRdV1DEZZkxQ=;
 b=j48Trat7tToSWfHO4hNq6popn46KbsGPmaK6kI62rEQka3hIQ5/MhHevYhAcrOQhIc2lCXpcXbbmEpCbZ8Sg7Gg6xCpOvLcTD8G0Gxz2OvdFizsi7Np2FxVo4CIen+GlkZEuuHBYgDvtPklaMfcuyUFFwD+EFd7AZWT6Gffwz6kQMYYt4ftWsLf9H2b5dcE29s38nQ4wDJi4YWuVOE3tiXZLui9jzYHUcZ/PwjqDR93fRFJz+F4IiksX6dldeSjLWi+wSwdkc4KrCfmVC3HgsaQWtfTecRFK90JGA5ZeMEbNU+86Rx6H4U2KfZDNsqzNtGfcJUbHzbPEGpLLgxeRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faAdijuxYtTuyzbpx5smjMbESrEJK81MRdV1DEZZkxQ=;
 b=xdDDTEj/UakmBSMICHVhS06dqAcIMSP5Rm4Bgi8ul3MP8RBGQhixl6e18VZgYM0/bDMRm+eaZO7LLNY8c4lVej35Jhup7Q4gMNEdPkDyOoCzyow3QEtWHlSb9EjyFZA3++TRIn0JEenwuUFiaD1IAjlWyhuonqkkxoHjXcsfhoY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7829.namprd04.prod.outlook.com (2603:10b6:8:3b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 00:09:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 00:09:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/004: reset zones of TEST_DEV before fio
 operation
Thread-Topic: [PATCH blktests] block/004: reset zones of TEST_DEV before fio
 operation
Thread-Index: AQHZxs4J2EJyrcGDEkaJ62l4MkKe4a/aGCiAgAPhJAA=
Date:   Mon, 7 Aug 2023 00:09:54 +0000
Message-ID: <vxnxdaebpeurw5zm2f2n3r2ed34nrfbom32bop7xfnbeveidvy@fjkaomc5rdx6>
References: <20230804122007.2396170-1-shinichiro.kawasaki@wdc.com>
 <d6ce5f11-46d3-cf05-ad47-0114d0f88096@suse.de>
In-Reply-To: <d6ce5f11-46d3-cf05-ad47-0114d0f88096@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7829:EE_
x-ms-office365-filtering-correlation-id: 4b512669-d0e4-465f-eaa9-08db96daa079
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbtXIRNL1jg1hS4rQOwdkv/gLgDjXs6KZxHl4KYslned2RvwXul9KT7GmId+pgYWrzGAOCqqBSaavkxRu7ZBOW/4cGQLXDDgeNYDbeh3iyLYDLSO4Rs6Hm0huzN3S5p12zdG1xAiEM1Ctp5pWbSDlWQ4L3i6PwS/KoGXkYFtslsxBIzlcHnfeRdezYXbVwZ4A1UMxrWtdirwHWbtN4ynq4zseRh4QmnVHEhEBWQ7hRCPzVStnkPWaY41gwkw/xhJbtBiNClZGr+JdGlWu2EEY247cZubArgkR+4gxviwHXwL138J7kK9U+1MR2GJSmun+iFaeqyvUGJ0GgiLkTTBO6mTIX3Pall9IpsFN9KyrAsC0g9GOqdnihH+Md9k7rBSSrWVLNUxXxD7/W8NKihvbGWHfjQ8Qmfuy7kUuXVzSvLi2MSYfgjuATLOVul2wPI1JdYz5uvJRkYxWKQZ8L9ClDUyRJFlxBmCbS3mm40b54cIUM+DXFMDVr6RrdESWzWsn84HmfDx3f96SXQtKMkxrKMRQZUbhoTL115dbBFYwNhO7RmOONzQGW86tWQVYsw3ISItIjVzyKDZsQ50B3JyOJfgaEf9r4l77ZaUZL5JVC7N6RwEq40eRoO2Yb5jiJzX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(186006)(1800799003)(451199021)(38070700005)(41300700001)(26005)(2906002)(44832011)(5660300002)(83380400001)(8936002)(8676002)(122000001)(478600001)(6916009)(86362001)(316002)(82960400001)(6506007)(53546011)(38100700002)(76116006)(6486002)(33716001)(64756008)(66446008)(66476007)(66556008)(91956017)(71200400001)(66946007)(4326008)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sEw7YNw1b7TBYchi2X74fKBhN3kn6LvZaJtRw/zbFOr8B0DLdKFwDjgCcgqo?=
 =?us-ascii?Q?ivTgieC99PdGRok6NgfHN5nEFFd0vuhXMHH2ynYoqAO53cd+lrXM/LWBx2It?=
 =?us-ascii?Q?gXndicacN4AzrkezG5HZhevfkXRCA9+7x9O6VF6m30j9gYfxZESlnTJMFRbI?=
 =?us-ascii?Q?1XD3eAAlR6r6JIW/MDRSDvmrqQ2E4mN9ei+768bpjDf6S+VwC/3goRf0xfrN?=
 =?us-ascii?Q?RLTFlTjHPcWFegbolgE+ey6gq9r3ca5AmfNT8D1EoWxpTvogwkP5gm1uy7LS?=
 =?us-ascii?Q?+ekuqqSK0srq7uR0oHAipa2jw2h5hT0lGLnkf4LGQtMzoHY1ESAoJVCoxvZF?=
 =?us-ascii?Q?FzmiwxCW93mPCDFzNewG7sCWUs5M20iV0jhOB3IyUJdjSwiq8aJ6Ys/8DgSK?=
 =?us-ascii?Q?C5cyZoObr3PaTWtGyWBlD80veEaCbyXQrUV/duSgf6MPqdcC5AO9hhzfhdNH?=
 =?us-ascii?Q?C9JGEzOUSKxE0Zk+fflMBUc0TddCXEq+Jg7S/LkRp/10rg5WVUKwIbki663/?=
 =?us-ascii?Q?l4iZOfI//T17Jx7Inx/teF16d9oG6pXxk9mcsM1inecBP8AwyBTgaC0weZWo?=
 =?us-ascii?Q?47Btc6xL7TKH+N6lasAvjt/R4J3rScxvEGH3WTIzsELhbw0AU+mtY4PGs/dl?=
 =?us-ascii?Q?NB5HBrkl0yC5x2AdY1e0LZ6vzG68Eg7zHQ+Fx1INSLqJ5nN7QHvsD2fmZZ4A?=
 =?us-ascii?Q?p51au6QiLykcBy/729uja1a1n4AzwgLytl6O7pjIn5Ru7p5ZnzjhymUldQbT?=
 =?us-ascii?Q?zUqqdM0h+7EqPwNt8XuWAonBK9qRCs65Qg68O+C0s1LAPAkuEZTzGOUWQwHX?=
 =?us-ascii?Q?rF/4ztcS8PNdIAn50Exgf7ukiqQXGraJ0YBbDeR24doXo/XQi9M02VDZ/woV?=
 =?us-ascii?Q?3vkKwArbk5ntRF4DD3HL5wwyZBl1bzW0x7diJ7N5cdINPgUMij0Sx5DqhluB?=
 =?us-ascii?Q?JMb2r7ePMy+WbM0hfkYZ25iSeav5a/01nxL3VH+SoNuAK8V3Z+tgqKhwsLjN?=
 =?us-ascii?Q?cSozdmftc57if4n4U+QLmW6PakrG39wYbELxL1dAvqLP005d48eYFqOesC3T?=
 =?us-ascii?Q?Qye+KVaoni/iXqzYrom0N823fo5bs0qFnVjreULVmWBS7Nc1hAKduzZDXFRw?=
 =?us-ascii?Q?Ov26BPsQHNPlRraa+4MhtVyqHOzN1ZB4BMQ4eHR/KVlSgO3yqC8GUVjdm+fo?=
 =?us-ascii?Q?hJbJM0iiTe2pkjYu2TeLfMqQeX9bw8SbQkmhNW/FyuPyy+cFIV6xI7CDOthb?=
 =?us-ascii?Q?7NMhYkZuMgr6j/w/rHtI0u1RHftWEagD0ipWqgb0mRjyUWKsfQ+/70NONtpB?=
 =?us-ascii?Q?Ezdk40OuSmusnpBhPK1kfJbJh73o326E+46y58fDFOujVLLXMr5RNMoT6QBs?=
 =?us-ascii?Q?XQFmULFm5g2vw/OnImdbeUdcDZ7NrlIVJUy6VflGXr8XLCWSgEWvYrR57LpF?=
 =?us-ascii?Q?xB5hTBQIYD08erMCbHuH4+2SV4CEFu7BXbrbqzDJehhRb96NQ/meZHWwWTBv?=
 =?us-ascii?Q?7FHgCcxlxoOm+hLvP0P+AQPZ0UmWKHjTKiygLlWQQ4J8VUMWw34dlGytJNTJ?=
 =?us-ascii?Q?A3njPj1nUs4bB4TLf0ciTzd1os2PkNILXfFjzzKDE7pYjjNQVnlKv9qOt/Zy?=
 =?us-ascii?Q?1/lR/1UyKx0A4Ck8mYSSjJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC2152D08225CE47B2780CC1EBA0EA94@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 52ZA9uzRsvsV/p8SATPsJPZjpgMnwm0bxsghvrut4K7baMwLbl5MgsHc2vPqbgQCnhPL/xeD1jhqgwj5XfWAHk0KrRgGcaXdO9g01vITT1BD78PcriM0Dl+BBVo3/8NWEMmd4KPQ4oDUJ0Gcr7pEVqkq6DX3QxQsvFsvHXBQUVgmVBYZBXggT4vxWrDxEC5qRKNNtZlNnUK+wBdbPN5BfbZ1zu8FQsY57xWyoCfBJ3gj25RITHW829jJjY07osh09Ttk9LwNrCwpwWOxGj/40VJKYolsZaW5ob8j7jeWbseVBzkKu1QfrddhFSF2QZWDdpZ5q+XoPJTAX3AGt3BMpLPqerPeO018sLZ2awmZ1W8MkyF8Urfg443uYRL+5oBrJYBkp4H99NF2UY0pnwDok9pZuHyUdfi1VrU/MWjrl801cNYrkhCwSBrNqSrV+MaLCvW8WbCqTxGPcswUOgDsHj+7kP5Sy6InRZRFmZ76lA1dV5kDSH17GVuN2+mrxbfkTQdOOBveJ0aznfwQWaI5VMbSxVczM21DsIkcFNxExWSu139vrjeN8zfRkJHyNB7/11KXYQsyCVTKlnB+qb1r8/V4KG1AlZeTaEJ4LkMjLvNWhUx8Wz/Isgu6llO7e+mrnY2753hi5z0cWuMt7gz3W+6Gn6K7jgBH50FMaP/3OBB/Reak+Mt5JLMT0wbME8sh9h/Kev6Jp4lxmKGDZoAyLhBIURGRY1hoPdprUA1NTHBKxJCz9A1MWR45xcd0qOOnj88jN+gfh0W1AOkN2XCIE/c+GMkwIt/1V9/Avz85jHk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b512669-d0e4-465f-eaa9-08db96daa079
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 00:09:54.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHH7iou0LKz8b0OMp6b9czg1KC3P3N9DsjCwLwsqUNhzVbVAcbeXP6xkKdhbjor/ugGwowlp6qeb6HHs2S1ac9FJ4bjAbkT9M5iPvN0hFHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7829
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 04, 2023 / 14:55, Hannes Reinecke wrote:
> On 8/4/23 14:20, Shin'ichiro Kawasaki wrote:
> > When test target is a zoned block device with max_active_zones limit
> > larger than max_open_zones, fio write operation may fail depending on
> > zone conditions. To avoid the failure, reset zones of the device before
> > the fio run.
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >   tests/block/004 | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/block/004 b/tests/block/004
> > index 63484a4..52a260f 100755
> > --- a/tests/block/004
> > +++ b/tests/block/004
> > @@ -15,7 +15,10 @@ requires() {
> >   }
> >   device_requires() {
> > -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> > +	if _test_dev_is_zoned; then
> > +		_have_fio_zbd_zonemode
> > +		_have_program blkzone
> > +	fi
> >   }
> What would be the return value here?
> Do we care?
> Should we make it explicit?

No, we no longer care the return value. In the past, return values from
*requires() mattered until the commit 4824ac3f5c4a ("Skip tests based on
SKIP_REASON, not return value"). Instead of the return values, SKIP_REASON
were referred to judge test case skips.

After that, the commit 5c2012764cbc ("common, tests: Print multiple skip
reasons") renamed SKIP_REASON to SKIP_REASONS. These changes are reflected
in the descriptions in the "./new" script.=
