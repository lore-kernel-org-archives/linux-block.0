Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46165C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJEIbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJEIbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 04:31:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC36D9E5
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664958674; x=1696494674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XRpUBlwiYI7ircAfEAbpqfQN+2U/19fvCi71r2Edx9c=;
  b=RisTf2WFZ794MAzL7DrZ7fMkd6NWZq0ZbL4B4WB43kps1gO9W4uZrOvX
   e8IHFxiSXfEaXfFL7BEmscAgFtcH07m4mQtOdTSqXO3Jt7FxHfNG2L6WL
   Hq0dP3lhAB3v0wEJmqQTJazm5qMQXiLvUUBSTHF3AqBUPfmmtd2fHitjQ
   Zg2uzWn0MBKzGHhlHehhqQLl8pINDjQ7XgMsiRI4yAfct8nsYTNOEsxif
   z0E5PkWSMJP6EuyXtGVgbbM8idfvgvoO25AWh2G6/aZv8pSfecAS7Qsmc
   RacvQmpHiIxY5KGpTxU/pIOHHtFCTaFM+nHhkwm048ARhhXImdxNBX4g8
   g==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="325129956"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 16:31:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFCZPu5vxC5CYlteo+RW3jL8UfxM2iTPOES7NP9IAIfYrNpuWX0Itmd3VMFteQyOa7OaYmBKg+Ccv4YXiWcQD7qevnnHj8nhv2yOdYGNPTKNfHBOz4TsaA4RuagUGx/yFBWwofOVe4Jdenf+h9HNnno2ngkxFQydquHm8cJephqBUxhG01hX5CWYstOHfK8jLr/iJW6tldFe3eQ0I445f2yzFX+dn5RRdd4SNW8zpszjGYAFK+uETT/w52YMWgYb0kxxcBp4ec0j3o6m0YqSc8prnW9VIXb+mCSwJMvDKzxTos70WkR/hUurelZUHdcPliF/WP65R6RYKvt1l+5HCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Jzp71aSo+0z5+Snngen18yDZGqsVGwB416VG7oY/Zs=;
 b=Qau88xA584apMweTH/IywMFzYlHG/oQkfhxsD9xdzb2x1KqCOdJOPF5Bz/yU/svwaU3tybY8bueoGzJr3qN8FM3zlCBa2jNNrp5pZUZBRdIaddhvtxxFLD97221bO5zYK5PMPiSveuyhCRr7096ALEXZcRR7g1qhSNFUhSV0WxT2FAIOsPr3iOB11KDqMpV1UYO78lb/+/QgJg3G2IJMGE5Lgbg5WP6HIBku8qV1Egr/hK0y9lWbRqGVG/6DIAALl9fXB+QX6MFQTxsh1cbpVsPZnSmOs2680txyZqJqOFBJwOV2OI9Q5RlGsq/LmvPHchKrAN7s/GfkglUP2S8XLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jzp71aSo+0z5+Snngen18yDZGqsVGwB416VG7oY/Zs=;
 b=f3v4JPYia2QTuFdjnt01bpVjeTmgKI7I0ZkAt2FNSc+kpVXZniYiZ5eGhdykDRF7hrN09FmvgZOxVkxlVEDwSZFcbSUmhmva6DyKSnX06Kt+qiFcdct7/ktudNqBulNraOK6yIEzv73bPFuVuMiF1B7zNsvozjxd4zYGlTtZFac=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CO2PR04MB2200.namprd04.prod.outlook.com (2603:10b6:102:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 08:31:08 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::da7c:b5fa:de5d:707c]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::da7c:b5fa:de5d:707c%9]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 08:31:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Thread-Topic: lockdep WARNING at blktests block/011
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaa330IUAgATf7QCAACBlAIABQxMAgAAHQICAABRnAIABUUcA
Date:   Wed, 5 Oct 2022 08:31:08 +0000
Message-ID: <20221005083104.2k7nqohqcqcrdpn4@shindev>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
 <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
 <20221004122354.xxqpughpvnisz5qs@shindev>
In-Reply-To: <20221004122354.xxqpughpvnisz5qs@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|CO2PR04MB2200:EE_
x-ms-office365-filtering-correlation-id: 83148567-be30-4e3a-2d42-08daa6abf37f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0L6fyUV53ra+Uj6oi8jMfzF6l8z74D5nPahrvOisryVwpwjDFK3jMURfVw9t0VQQWno5Cl19xnelR43xxT21fjLrIQNZ2f7pdwQZyNzkvb3nqaldU5uzWi53GZKLHk1Rg5tL/kPR8WAUcRF2xnQAKpT/KVrAsa1Co7gz3QKlOzBEWuOlJpjISpZzA0C0HgmMWpAvKV2RTjTI95QSPlFE3Tgj88C85izZ/itOIjxAEd2F/wQAG4xlEfNFhn55ADhtSHaE6a+UC5MjgOcxHgF0YiYxViZXiamHj1GS/Bsy0Ugp8IXsNVCGlOslZBuiXGrE685HUSu+qJP7xuYmK6vfTARcL0MBNG3kYm6vXKmJGwt6teZb4U2q+k4A6t+E9JgTDuKuu9PxKB6RZJwj/E6iSG8sOIlsOfdlemU+0VNqgOD7zYhE+xiXsh6CjEjaTNib4YE1IqqvIoEZrcOJiCbBDBBL97BjdnRVYKytT3JX/kjy363pT0AQoZV/cF6xCcZS8gmztksxQG9ws5F/mfEmadqQgiK7ymMUS1druJFocehtvPOmrveKeLji2d+o5qfOX2VywRffuHo3y3J7AmY1W8+xMU2e2jbvyYkAyUcYFgUiT2UZ37cxcKTz4iAklEOs5t8IrQBg9n/yh6XM/nyUwmcD+e6vAIHD1HS5z3caCwuNiTU2+qsEPB8NR0JK6TKTgFgm15mRJTOdeMzWBVv281Bp1u5w0z9Pnyz5YGOTUS0IK2AEKz5aGEno3tyGmkEM2RKAdFfZCc/PAOXf66KGEq0MJDHvQg9l8mQ3GLJvAF/a9mfBd8wdVVbGuUkJIQVKeAMxdUY5UkgASOH6hTAqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(38070700005)(83380400001)(1076003)(186003)(82960400001)(38100700002)(122000001)(44832011)(54906003)(8936002)(76116006)(66476007)(66556008)(8676002)(66946007)(66446008)(64756008)(5660300002)(41300700001)(4326008)(33716001)(2906002)(9686003)(71200400001)(6916009)(53546011)(6512007)(26005)(6506007)(91956017)(316002)(478600001)(6486002)(966005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?14fkRdSkjtYhNaHovv+NOdw9Jh0XKZIZ8iV0c3Q17922BEXjsnNyn54BiU6X?=
 =?us-ascii?Q?ksxtqIQysCl2R7tuZm6QwmiZtaq0KZsw2ym708fddo6qjxG2BUclkC5zj/4X?=
 =?us-ascii?Q?jH3I0EgYQ9AWd7mLubXtYPjoZ0IvuG+dg05JSE2Y08A8ajS2JfxSErn6mntO?=
 =?us-ascii?Q?46ZW8oPxFptKQxsbArhbbsRho0OaEmC9CypUQGqZa8bJdDx3RCYVbV0r2HaL?=
 =?us-ascii?Q?8Ulcp61OBwdOTew9LTaN8vhR7KizavYt+QGng4trI4snvf1w262s+nf7GraX?=
 =?us-ascii?Q?aii+9wec+TE1Bij0po69EqaJOfv00QOAsq5jrt2drqvDflQs27Unp8APaevh?=
 =?us-ascii?Q?pgBsdp6AUxWcFK/53plXC2TX+Ch1avA9GaPAzalU7kiKgi2m6M9RZLXLTjGK?=
 =?us-ascii?Q?SoB7tqPovfF+PDfrUkE0vMvrm4BHyTuZmiuIhJLU8+dKVW/BsBXLqBPY/nR/?=
 =?us-ascii?Q?ulX8MKsdXiMBLWPp5bBgBe5WUKpyILyGPa52LVQKZsXalNN5ZP4UBTxUeScq?=
 =?us-ascii?Q?Csr3TOThAHFhNbEzWnePmzrahufqIdlQEM9Kp8FgUbZizfoZZAlxcpNV/wcb?=
 =?us-ascii?Q?TmF/bvBHrqEPdI155B7Y2m4OUJSDxi7MWJ0m07IAgWxFdcbJ8sKcFJAADbBn?=
 =?us-ascii?Q?FyTupDWZbexAJgHdTePs7bI5yf6GaTOK3qsIiPQ3avbmW5wjSoGFXPxMLVYj?=
 =?us-ascii?Q?iMuNfZK2zfJpyFIWnbE2xGgpiviPwZthC1jTPtrAt7LaO3nTcmnOVzoQiIMR?=
 =?us-ascii?Q?jMSt3/+uN2YW6RW7rJdMNUh8Q7761Eo53lMAMkHBLqCc+wszofSGJnFNq8DL?=
 =?us-ascii?Q?DnTh70KStpW/k7f+TzYYEp2IFRG0SVyZ1wIC5MBoipvQIpM4D+EdvLzmTosD?=
 =?us-ascii?Q?cvW51WrBULupXzcKa1B0YrvtVF/pgTC6nGZNlDFrTGSHacfDXoPPzhfpsEWZ?=
 =?us-ascii?Q?Q+x+xPu+rJOR8amLbkiNNSc8Y/S7x+ByeMQJpOTfJt530qCKjYyM1IHXuAlD?=
 =?us-ascii?Q?gcgaQ/HJ/ittaMyWbVwoR/kc2xWE03yhAW+M99EDuXuLj2rJWdxStfr/ifuB?=
 =?us-ascii?Q?wgKj8l9U7e1MsH7aPyyFxu5iWKkQoKwMjunUx5/SUO8niBeOnq4L0lxNZA1p?=
 =?us-ascii?Q?HAD/PwUqaPjwlH/vzRfo6uVafgavvqVnaSVmr6ZmLusrJNCXznznL082Vt9l?=
 =?us-ascii?Q?7xsdc0zcpmR+1N4aVMspBL9YBgD+ho30wbJEw6/Nv9SWx7bWX/hk1GzlXJWb?=
 =?us-ascii?Q?YFuOlEvBiWjOY4p5w+lAh58HpcLvumJFm4b3RuqOrrHfXQaiMaNd/VEw+kdI?=
 =?us-ascii?Q?J9KeCh8P4sg3Ijs0dNrxud8lE6t3ItMSqVPIpYtAJq2OZlTgQt8AxZAFLwgT?=
 =?us-ascii?Q?7fpkcK2cBlRRl3JTFI0YAzIJM3j+UGcXgOFYhZARcFlhE0foVz8PnPKvHMuI?=
 =?us-ascii?Q?cUqCIIWHYJPFzsbZW6L3FypfH0NQLK/kTIt6Yy6th+Hv/sGxc913icOTeV6Z?=
 =?us-ascii?Q?TEePNFcUMTunyWdUWKR+RkP9dGtx+r2PhoQhevxSn1gMFSN3Cr/YdTlZSztr?=
 =?us-ascii?Q?WJOKVNgjzkw1NXdAqC/6wEhOVoMSJDbcr82ni8IwWT3Ooh5VNODTtIvKGrAV?=
 =?us-ascii?Q?HOTVC928HELr4rb5mFNjJZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <078BFB71C29E0D40B33899AF26E988EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iaEHZjFR5srwOanm22WmfJeJMeySuRHYZUOlwgbbt5FIX4DAQ6Mhy7uWsx7y?=
 =?us-ascii?Q?CZ6CyBKU4F5L872xzpQFi0mxhn3C0MZz8XGGQolY9Qtfpg/9KMgwqhLri0uU?=
 =?us-ascii?Q?XZ9N48BDI25PyaN8TQGxdzQIN1QjeP8ss96+S4EukqCJfTltvmyOQUBYAJ86?=
 =?us-ascii?Q?IMjFmdleWEQ3SuOH6cArUjz0mC7MF2tVu3zF9gSBqZxS7OEAhUF1BaYaMYFq?=
 =?us-ascii?Q?AM+kbSWnkQUxCwoOKvtkNw74qe5GzfCUKW0o4Zec2e36DEeMDDbw1U3DTRol?=
 =?us-ascii?Q?6lLl0oowHWKJw9RT9roD28yFgYPqGecfIdbuOMWJb6RI+0puO2wDlEfp7wIE?=
 =?us-ascii?Q?/2Y3MmYeMSZ1DltM5qJMavIOkoj2UXuNjPwSxbf3ZGTGIsyMa70AcoE/p94C?=
 =?us-ascii?Q?A+PoJN6l4stObuHP5GhzQoLazoyYz2Bf0il+n5dY3IopWYvw8xal/thA63KN?=
 =?us-ascii?Q?xauYZdVYq8RgRVBgDPHmeLWeq7MgzjWhcmK60KAfi7JvBo5bgIZwG9ijjop9?=
 =?us-ascii?Q?fe95w8Zi1zmoNbptKBZf/AOLduq1sVbOc+AAZmWrndnwXkhMbpn+KvrPD0+5?=
 =?us-ascii?Q?wJQ14O48coJOQlDoskcAxyaNy5z81DnXJXLPmzupXvlsI2U+f0Ao952jvXXQ?=
 =?us-ascii?Q?SLrjaAUa4oPL4NzEc7GwXjLBlROhzlI06aAtzmKMtuG86CaTKQjPFqYOUyJ4?=
 =?us-ascii?Q?vTnSLtusf0JcNrh2dcE+pg+t909BrA12Ds8zgIYYvJZKikRaPT2JQRgZgJ2y?=
 =?us-ascii?Q?QOBnL4zA+3qCjZMEAAjHJtV0folBk5exTpk0tdulOE3f+mEuBoPZ/1oRFliK?=
 =?us-ascii?Q?d/8qzy36HH00Ov4JUFG6mjM8YH4xj6bJEqGRhA1FYBXxEadjpMrPT6aziq6p?=
 =?us-ascii?Q?CbtfBbew7GCaZM9RrAKxyBSydGx0+wt27Pif6do0qrQxdnp0ppvTgKGg6TA3?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83148567-be30-4e3a-2d42-08daa6abf37f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 08:31:08.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXNaEVsxUFRz69JGdVfm9LF+jyp6B8T2jykwqNdNy+LbnYRoCV4Yd9rMT/l9WDRKvn4N2YIS91kuFE5iseQTC7uR0t5ynqWjX3EULdSjy5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2200
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 04, 2022 / 21:23, Shin'ichiro Kawasaki wrote:
> On Oct 04, 2022 / 20:10, Tetsuo Handa wrote:
> > On 2022/10/04 19:44, Shinichiro Kawasaki wrote:
> > > Any comment on this patch will be appreciated. If this action approac=
h is ok,
> > > I'll post as a formal patch for review.
> >=20
> > I don't want you to make such change.
> >=20
> > I saw a case where real deadlock was hidden by lockdep_set_novalidate_c=
lass().
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D62ebaf2f9261cd2367ae928a39343fcdbfe9f877
> >   https://groups.google.com/g/syzkaller-bugs/c/Uj9LqEUCwac/m/BhdTjWhNAQ=
AJ
> >=20
> > In general, this kind of deadlock possibility had better be addressed b=
y bringing
> > problematic locks out of cancel{,_delayed}_work_sync() section.
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit=
/?id=3Da91b750fd6629354460282bbf5146c01b05c4859
>=20
> Thanks for the comment. Then, I think the question is how to move the
> blk_sync_queue() call out of the ctrl->namespaces_rwsem critical section =
in
> nvme_sync_io_queues():
>=20
> void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
> {
> 	struct nvme_ns *ns;
>=20
> 	down_read(&ctrl->namespaces_rwsem);
> 	list_for_each_entry(ns, &ctrl->namespaces, list)
> 		blk_sync_queue(ns->queue);
> 	up_read(&ctrl->namespaces_rwsem);
> }
>=20
> I'm not yet sure how we can do it. I guess it is needed to copy the
> ctrl->namespaces list to a temporary array to refer out of the critical s=
ection.
> Also need to keep kref of each ns not to free. Will try to implement tomo=
rrow.

Getting suggestion by Johaness, I created a patch below and confirmed it av=
oids
the lockdep splat. It moves elements of ctrl->namespaces to a list head on =
a
stack, so that blk_sync_queue() can be called out of ctrl->namespaces_rwsem
critical section. Then the list elements are put back to ctrl->namespaces. =
I
think this temporal list move is fine since the controller is in process fo=
r
reset, stop or tear down. This point needs confirmation with NVME experts.

Keith, what do you think?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66446f1e06c..6ed68bb6008 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5120,11 +5120,27 @@ EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	LIST_HEAD(splice);
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	/*
+	 * blk_sync_queues() call in ctrl->snamespaces_rwsem critical section
+	 * triggers deadlock warning by lockdep since cancel_work_sync() in
+	 * blk_sync_queue() waits for nvme_timeout() work completion which may
+	 * lock the ctrl->snamespaces_rwsem. To avoid the deadlock possibility,
+	 * call blk_sync_queues() out of the critical section by moving the
+         * ctrl->namespaces list elements to the stack list head temporall=
y.
+	 */
+
+	down_write(&ctrl->namespaces_rwsem);
+	list_splice_init(&ctrl->namespaces, &splice);
+	up_write(&ctrl->namespaces_rwsem);
+
+	list_for_each_entry(ns, &splice, list)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+
+	down_write(&ctrl->namespaces_rwsem);
+	list_splice(&splice, &ctrl->namespaces);
+	up_write(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
=20


--=20
Shin'ichiro Kawasaki=
