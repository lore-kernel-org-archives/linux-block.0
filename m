Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C92C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 10:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiEILAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiEILAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 07:00:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7D224061
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652093773; x=1683629773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s6llyTiUbvr4fpGedW1V3ftgXLhlNGQHJycK47Qp/nM=;
  b=DbEQU4qoBNCAKA8/NPooR8MqN3D5J78246pXQvyvUkS2WtsDFqOovOl3
   vyS3h+HSxg09lQ6+WeZmMBYfxJvateyl8vdRYJRQa6SJKxXpi2RYq1UoL
   2ZNf557QlsdM0qjb2inDc+RHQElKYP0KJ3QFzs5oWtXJyi9IuSU4pKVpy
   52hjf1xSgL7hg45JGobhN8WYC9FYzcqreU+0TQpGZuXyT24mnYXQYqxq6
   7vMRlUaZChSVs5takEOO7L1GL3oqMagU6hcEd242iJyH6w4J0nWoMAsr6
   gALJxEXIsd51//iORK8OYm0lCLS/j5siYbIlZ86Wows5uM0op/J7306kV
   A==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647273600"; 
   d="scan'208";a="311835327"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2022 18:56:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQecmQgMuChIqCNS/ACa/gSHDeMkR3knqm8uIL1j/cVncpCyeHm7Vt+Z2zYZih8J8xquRDc2xRUXGtQK2gcP+Ylvp7mPHnDv2NEh1oEJPDDXpxGN9ALsGpkKCYu7xcD0jNAIxzO5yMqS7MpYng/TKis9WjXEEocl8lCnHlB7reqQ3zXx+bDEwnL5gQj+kSE6YEIhHxo6K28vkmrhigWd66ba+b8ba2HGWv1aJN4HEw36PwTQi/nNFnG2fQ3Wkyz5Kn7nTjuZrx3BJiDd+74Qe+a/gQLLcX5cMHRYh60xHaYESvUqZRJhcbGBrpX5USCGdPNwCY6kNXFlEVIh6Fl5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJqeiSSk6TAVqFuMc2z+SsvNzEDeU4Kq/EmCAMef5mM=;
 b=XHde/7eBzRnfUMXSL/r63zfCG5wrTwPiG9FSwQAvBHe7+iMWjYlL10eTvTzLuKjTlGdmKJ4qhxm1dBup1p6LCOPzERueeZtRmBOPhQRmyT+JpqP1N/OLcZ+zdUCjZDBqm/Vl/mSzSJmlGEqhdue5D+GizwmjtUpWMVt4FHfTtanZ96E2dSvFFigI4Y+oLeV3Nl78ax5NIR9l0CNpyJAjQzb8c747Fp0LuA4xYd9RnDHR95kZznFoPkNKRPlzP8rK1rgzaOv9jZORQEtRzYMIHS893ynfuhgSVfysT2JW14k06I4eXgPbz3rjwBlryeU1gf8T9DzoI/1ygV+uQXX+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJqeiSSk6TAVqFuMc2z+SsvNzEDeU4Kq/EmCAMef5mM=;
 b=WgRkh4ox9cSE7LWHsYPkZL06ljGpTxXbWE8iyCc/i0Mo9pPI12vfXAco2E4/O99k3pzFvyow3lrVzZOZVkJY1+HMOm0ZI6kFIoEqTLyX6otyv2g2rpKAWBu6flZUSwLHGSx1bcBFk3p45g7qcPUJpaF4z+bEy8ZCTyPdmkZj/Dk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5191.namprd04.prod.outlook.com (2603:10b6:a03:c2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Mon, 9 May 2022 10:56:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:56:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] Add I/O scheduler tests for queue depth 1
Thread-Topic: [PATCH blktests 2/3] Add I/O scheduler tests for queue depth 1
Thread-Index: AQHYWsj3Oy8natyW3k+71OYU0Tti/K0FvXiAgBCzvYA=
Date:   Mon, 9 May 2022 10:56:10 +0000
Message-ID: <20220509105609.lqq6ffmyib3i4ojx@shindev>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-3-bvanassche@acm.org>
 <20220428062659.udpifr26qgsqfysh@fedora>
 <deaf359d-584f-f328-0b0a-1f3ce0e0937e@acm.org>
In-Reply-To: <deaf359d-584f-f328-0b0a-1f3ce0e0937e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caad3e94-d026-4d9e-1f06-08da31aa871d
x-ms-traffictypediagnostic: BYAPR04MB5191:EE_
x-microsoft-antispam-prvs: <BYAPR04MB5191A291FC14B3319EB8065CEDC69@BYAPR04MB5191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfNNQireDjqaEAgPv+pW6ICDMj/qrJQp2qQG064GDwQqwv7OsUejDSpdC0IS19Fgm5HkfW4gTZkZuwH9PtNAQI/O+7YJCcmkihasf7hENtT6ME6unAT9NUR4iqnMHEGbI6iY6yHDU5/7h03nVH1+AGGePu5debn20XJFuSTEP1uYV5MYKf9RFKkUQThPkgyIbKNqztr6xx/fgrHDU4WY+drgDWpwyDmHnQdwOlVWenRAjmfMUSyrXpAiI3uZcVRGUV4SJBH0nPEcJTvovbUgt2Di3vk7NLM9usibI5jPhBMnSzD69odV8FV+tglZwu8hzAm/mXonfBtPxVUou+dWuUL3evVT1PHt3TNwsddhpD44f2hGiB2kbwqgMpl7Uo04G0bdvfWnRExc9YL/gqyL9s3O37chPMpma7XRkMsLIXwoHL9SsEzClLt2vR9z9v9OTwr69ZvuO7BOMXH0jkwQ6V2vSkgJ+E+1//MRxOVuz5u4r68bUEXOhHkpePD5RlBS0ukrQXkxtdCd90hO6t0fp0PWnZBwTc8zGFDhhZcS0VhvaBhufHyMA6q4HUk/ZR/HgJqj/sBIzlMz8cw8QZHHbrqmAKFgYoKJd1cgVMRTUpxojCSXWr1MY2thEurm3VJzoroEDr9l4rY0b6sENrjltU+BYz7Xe68qLs1EEKY/mIio5tOeAEPD6jFP/w+I/ge/b4g6weF+6iid3cUGdVo2bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38070700005)(9686003)(6512007)(26005)(33716001)(38100700002)(122000001)(64756008)(8676002)(6916009)(66446008)(4326008)(82960400001)(1076003)(186003)(54906003)(316002)(91956017)(76116006)(66946007)(66476007)(66556008)(71200400001)(53546011)(508600001)(5660300002)(6506007)(86362001)(2906002)(8936002)(6486002)(83380400001)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RQ/v1vHG4+akxd8v4LnYjuBx75HmSaoTT9PG5E3nX7mQtkxCrhNvUEEJcIKD?=
 =?us-ascii?Q?TiFZK7LohGIe8jDWHsp+mjAek39Ce/PdYEcZKD5m6QvV0csPwqJ5WpePdnyF?=
 =?us-ascii?Q?C8BCNcyQR4qWEh5ZxsSqS6TaBtKP/NDQNc9WAWEhHfvvCBy8fPSPjW0EnF1v?=
 =?us-ascii?Q?dE9BCaAkwvko1i72eddHbzagohsDRQtnFHdgmAFM/R64SkkvsO3Z5fpbqkGv?=
 =?us-ascii?Q?Sns6h9CrE4jtG+Dthec3DkiaaXC9Hd+mCa7DOfiBSxoFtQNl4TstxQowPkqC?=
 =?us-ascii?Q?uPKCBHfJ9E28bxmlK9tXHp8fowIDqhzqXUpG2sz3CnqDoDl2VksBIh8jmDOe?=
 =?us-ascii?Q?ASdQs4/SCnvYdQL100c8C0FcW4FI4KF+/DtNSCkkq2C4rxxY1kSL6pANxypp?=
 =?us-ascii?Q?nXO60HsSATPzqzwHYLVNZ8YklNXUfc1UZ8VEMHS905HQWMk7/emBfY/RRVKM?=
 =?us-ascii?Q?eSFMeb/Hl7/8q2tah8JEbdDgFr53pwmLUpRYX5sL2I4fOdQJ6qg2bO/mF6jp?=
 =?us-ascii?Q?K4r7Ewhbtxxr2LsBilq/vk1iBFnk7QgTjb1vQfu07R1UiOrcVbLTN0fDXWa7?=
 =?us-ascii?Q?Qvk8mKOoxiGHaN9vwk8JTcZNaQgm+/v1A+pBEe5LReUEDWJYuX1e4v1nrajn?=
 =?us-ascii?Q?OA1lbXll9bPZ+20Yh2S1XUg+vgXZWW4q9Rg/mYPzWhdaruEq7UHrMAs5itOt?=
 =?us-ascii?Q?QSfXhrypFDgBQ6g3OXf9xE8lqQ8QpYCFz93Fth/W76VwTKjchtRDQxKlKG+T?=
 =?us-ascii?Q?EVYoGIyqoA6/4SuijYwzdeQFlmDrhgYaAcmSusWZsFNvmChwE+1jhR+m534J?=
 =?us-ascii?Q?kICl1o5pM+BRPfGWiGE8i/qN51XJwOlD64wk6ukQhjT0E0kpfry+nQwl+80E?=
 =?us-ascii?Q?QvSLqYM6RwhyP/reOISVy2lXnEpK7XXPV8c6yjnm7NDZLCFPDZ4c8PWIsNoh?=
 =?us-ascii?Q?D8uY3BUN8wtuMj+bjr+3tfKV3sEEG57JgylkVYOdXlFnqlOuXex35JEU0UKN?=
 =?us-ascii?Q?vjbdYbavu047bjTi6pGH8m9947+ejGMfXGNnTLj5GODWPa9COzF9pxaIxLUi?=
 =?us-ascii?Q?9cFbg/MiLBNJ88VnBFXrIu1l3c6J7PCPbNMzfRKAvCA4zP9jPRorlJJlryDi?=
 =?us-ascii?Q?tLTy3wR3X3BBRbza8TtmJkLXpxTtVmKRxFGyiGmOY8L9r+OlYgXVbbbzQLOH?=
 =?us-ascii?Q?qu8stvWsbKgqQzQUSUogyjJKjZvz2pOjoJyuzrC2cys3q5VIWxEb3OifY5Ir?=
 =?us-ascii?Q?l3kvgwdnpN5PveMV5yzTUcsC/TB8ZTdM4yCKoURBTh6PPMGDghs/vxX7JxkI?=
 =?us-ascii?Q?ti47617wgkwQDg5NVVuJ95Sum8D+qrXqFVeDIZD3kYoUGHSZYJSked+rITvW?=
 =?us-ascii?Q?7QxBJF5u68Z/uFJvtHOTjBd6igVfu7muHka0tDrxfpcD/+tjzQ8EHplNQk6o?=
 =?us-ascii?Q?GOjn7lUnkqoxKLwtWWjTtICDzxxP75kD7wlkeARwz4l+qrjr9cq7agmQyW1S?=
 =?us-ascii?Q?w+QfgJ9eHN51gklATRUdI6CozzjncIvTZt15OKOXuUBee1lhiCl2jR915L2z?=
 =?us-ascii?Q?izjvk0QHIE/ISdDP0G5q0ad7hhwbAA3rWc+C6lWzjLXe3UtddGMjOKqxkGXS?=
 =?us-ascii?Q?274EXn7Kv7rZzrYNfqe6eQP2aMOq2MMx49Z4GTSre+z3EVe/kO800ajH0rJ2?=
 =?us-ascii?Q?eNgaH7oyvNZII14MqB5zr3x5xfdKi4V5ktn5FqoHkfSjDGga5EJhj+iBmu9i?=
 =?us-ascii?Q?flkdb+DQBN6sZloevBMxy3iGQv9EQGNF2BCIJKtnzpC/MSSkg/Xp?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <819912E70B944742853F621FFA5B7E72@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caad3e94-d026-4d9e-1f06-08da31aa871d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:56:10.6911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GawC6cbWF4lb1Zg94EvzYSXoyLH3LkDqbKbLTFZ1Cjmuh1y6vjeMv9eQOmsqmz7KDYBRB7+smL4cxNeIR1bheDeAdN8ep7tu3EJQQzHhm6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5191
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 28, 2022 / 12:52, Bart Van Assche wrote:
> On 4/27/22 23:27, Shinichiro Kawasaki wrote:
> > On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
> > > Some block devices, e.g. USB sticks, only support queue depth 1. The
> > > QD=3D1 code paths do not get tested routinely. Hence add tests for th=
e
> > > QD=3D1 use case.
> > >=20
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >=20
> > I tried this new test case on recent Fedora kernel 5.16.20-200.fc35.x86=
_64 and
> > Intel Core i9 machine, then observed failure:
> >=20
> > $ sudo ./check block/032
> > block/032 (test I/O scheduler performance of null_blk with queue_depth =
1) [failed]
> >      bfq          679 vs 243: fail  ...  679 vs 252: fail
> >      kyber        542 vs 243: fail  ...  551 vs 252: fail
> >      mq-deadline  577 vs 243: fail  ...  572 vs 252: fail
> >      runtime      20.514s           ...  20.660s
> >      --- tests/block/032.out     2022-04-27 22:02:46.602861565 -0700
> >      +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/bl=
ock/032.out.bad2022-04-27 23:18:48.470170788 -0700
> >      @@ -1,2 +1,2 @@
> >       Running block/032
> >      -Test complete
> >      +Test failed
> >=20
> > I tried v5.18-rcX kernel versions and machines (QEMU or VMware) but the=
 test
> > case failed on all of the trials. Do I miss anything to make the test c=
ase pass?
>=20
> Hi Shinichiro,
>=20
> The two tests added by this patch pass when using the legacy block layer
> (kernel v4.19) but not when using blk-mq. I see this as a (performance) b=
ug
> in blk-mq. With blk-mq an excessive number of queue runs is triggered for
> QD=3D1 if multiple processes try to submit I/O concurrently.

Thanks. So we need the fix in blk-mq before we merge this test case to blkt=
ests.

--=20
Best Regards,
Shin'ichiro Kawasaki=
