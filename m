Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78CC433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 01:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJGBg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 21:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJGBg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 21:36:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E023692592
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 18:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665106612; x=1696642612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6DGgGL0W8/mlRRrzW/RdXgR1QOTzLHtKPgtlYn1bTlA=;
  b=B34+bwbkKsIpOcPDGsMmnpe4XCdghDnZL0cRvOsJFeV+3bjDfdxrKDYt
   5xKwdHv5P/OCaKPOj9xI8mci4QTN4G6ybL/5NbptAmzj8YWJH20J1NE7M
   5Y7Y8RQGI+DdEIfPA9ufwsnaav0CsKBgguCVTXoN10+cbguqsqs5kI2RJ
   F74WSVbga963ycxRtZ1C0dQoZlKzrM1piS/sFKXwwnbV3BKE0AkXmAJOF
   M3WppymGGRZIravlNYq2cIMNpfS1vuXfVFWotTVtpVQrifGQl4K4xO5cl
   6i4/b9y2HQokn9GSOZDZA0hPTKGQys7Nz3MoegVyJsOpZYH+ideVN8zuw
   w==;
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; 
   d="scan'208";a="218374739"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 09:36:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5VZjGrH43J60Qt/iFciYeX65eJ/KDgKesAlbEOly/ux3KaA1XwpYFXxtEIyckYCQil3fvSBGPINshcM0xhvpXq9Ws3xqm2Ad1g9NiGVIXI16WdkgE629O0bH0iz7bhF5u/QLLeXuZgewSKRdLop2MTLABYX4RoHB2+Xs4KEiF4rpkSsh1kJTsGgrkKSbC0xsmYImRnxBPxr4dxOcV9LrsvcCSxyWN/1i0gpHXVblhq+irVVmrmNxTY5O8AeltAQIG2jc5YBo2tKAtiZehzC6YRCe3zTCnf9wa9YTJ7rR4za0pgHX7BvQKyhZyH6p3eIzt7vL0OvvXE4knjKX0n7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWmEKh1rmgeeaqe6+J8Nu2w6mnWHLC9BN87M53OvwBA=;
 b=N/lsCitZf0bK9v+2y1CEJAbIA4fKseW52sOCM/2qR/hXdOA5kJAo875w9w7Js1SxBZWT6TSC4EkEu720qGN7LYQaWcn/8khld1xHPr/TXdw9C805H/G/ThXMPb2Mab6IAkEK22BJmEV+ldLHoyqZovSSjZaHNkIMfYdobia3w5v39tUKzMRH4Ju/AAKaS/N90k5qRaeOGev+kQ+DgJvq2za+2d25pAAsv+m3OJWPsXy7ZraGb3HNIm95DSuF7zyJfz6SR7aI5zAEzLdj+6tKg7vzsc23jyEc8tKkXGLISwzwQ25DvmGvJvgZRjPeNShILSjH5n0dam1qYhR2Mnzi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWmEKh1rmgeeaqe6+J8Nu2w6mnWHLC9BN87M53OvwBA=;
 b=fEvVRvMUe1Xc8kLY6zpMsQt+hCLV4/1AQ3hivnwLpx7uKRJ4Cm7+Z/vl7Iucp/8sqhm0bIwahWPmWmkPryuVjK++Km9jQ4XRR7G012FRaWbUHWpgYetGSFBxYslpsW60uXB/AyaOTno+Z8Pe6t8S+CnoSZAM9+4DTxifYOPKG1o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB6577.namprd04.prod.outlook.com (2603:10b6:208:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 01:36:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f%5]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 01:36:49 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Thread-Topic: lockdep WARNING at blktests block/011
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaa330IUAgATf7QCAACBlAIABQxMAgAAHQICAABRnAIABUUcAgAAY/QCAAEiBAIAAzDKAgAGDOwA=
Date:   Fri, 7 Oct 2022 01:36:49 +0000
Message-ID: <20221007013648.bhktcylgeyekse3q@shindev>
References: <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
 <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
 <20221004122354.xxqpughpvnisz5qs@shindev>
 <20221005083104.2k7nqohqcqcrdpn4@shindev>
 <15c6e51f-a2a4-38ff-15a4-9efee32824d3@I-love.SAKURA.ne.jp>
 <Yz2SkNORASzmL+jq@kbusch-mbp.dhcp.thefacebook.com>
 <20221006023051.mkuueh5epnfominu@shindev>
In-Reply-To: <20221006023051.mkuueh5epnfominu@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB6577:EE_
x-ms-office365-filtering-correlation-id: e2c6d2a2-9bff-4aa3-1924-08daa804674c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibhOqRkVO4D8XOK18LqdqpjtCRtYdFxyqP1gX0i1S3YHBbdpLtJToO4lngw6nZThsLM+3i0Bv6BAqc1VauH1ijFlsaofYltLantTVd7ngsmbQG+rds+CTCWOcpwy4/3sm54V8FkZesoh+v5zh8nQXIHm9IIII0jWXsf3tcGO/F+Xxq9IxFDjKRqcz1X+gxzSqj71OkyomdNGeMUNvK6QCV1SZcAhHwiEmh7oIyexWOoomLBZis852uwSg3zx35EqwPuH8CNWFNF/NBCsww0FQmuyCHv8QbIgG/3h1siTCckr9A6LBePP+w+iOKEN4qmJxHxA8bUNa4ibLIQfoUPnPuPQ9xJGNzGHQuEd0Fy1TJMEaGHO2vrgXDlD54lIw2XNS7qo/lPhsYG0KlOKcEI1kq46Z6Dtygr685jrsTP1UTZrc8qPAW1qqzW9C4UUytTTR1cGiNM2QkUYO4LLe7dedynvyaC2E7KC5BO+vQvtjq+vMal4yIvS+T5NskrxjwdH6encpAOnv/mNFZCE7P/xe1C1tan0feaENWnin8jG59692Q4E3YRqdiuyjQxUlUWQ1p9Q1BX5Z9+DaexpCZWzwFSlhCLsYfOIB7bJbbr63Z5QP0n+wGBOFDbfL8kRyLdK+tPtNxg9YKFSgf/DT9YQVb45Z4NQ1QxgZAKydmbWPGWsw1PUXW85ie1i+eCijZKjLCJQyxrUhq4YWA1Onn+0nEXJijED1GBG5KTGkU06ZfblLVHniv2Qr1iah0r7ipwjI+AKZ0JVx8HJBRXs9CeLeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(38070700005)(6486002)(71200400001)(33716001)(54906003)(478600001)(86362001)(122000001)(6916009)(82960400001)(316002)(38100700002)(186003)(6512007)(8936002)(44832011)(26005)(9686003)(1076003)(8676002)(6506007)(53546011)(83380400001)(66446008)(2906002)(5660300002)(91956017)(66476007)(4326008)(64756008)(76116006)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/sDHpwob00RkO0tAeg21zKrNWv5LPArmtRBzRJZEVrbkUgqUPaPbiNlx3/WB?=
 =?us-ascii?Q?vt2vEV3IBoBzI9491VLKx1JjUM7Fbbbh13RnIB1EFmOHXgMvoH/d+7dmnw4g?=
 =?us-ascii?Q?kojqZVOtFAvdvpPX0xlvI/7h2fjyoPhX2oCad4Mbne+451ig/jc9Vch8JlF+?=
 =?us-ascii?Q?DsgEGpRGB6yt0Xv8HWxawtP1D6TPJFeBQOx68YsdWgwG8Cg9rXL8mwKRcHW0?=
 =?us-ascii?Q?GPOU56heQo9jQQpDSNUC931UiGhk17D9a/x1iMXFWSzSCUCpZYpVLiSMPhgf?=
 =?us-ascii?Q?3+hhDRAreyLvT2nCGB8y6o6Juu9KXOlMQDIYWEAm/saZmAUAKzW2lTevSYEc?=
 =?us-ascii?Q?OPEny8GJfoFN7LmDZxbuWaIgOPVljwuexjICiByLUpijm4LKxRRaJyHJlKKH?=
 =?us-ascii?Q?aM7TwayRuSXd1CgxKOF8nkqTqtErmUTB0IEnAWXy8FtRW6j7Xj9Ok4Mqo2a1?=
 =?us-ascii?Q?P6zxkOV54oWE4pGEQgSelJPrWPho18gs3y56w9r+aom0Tdi0a7vezUuhk/ZX?=
 =?us-ascii?Q?RZuWYm8adQeZAMJGDdexgnYExmB2rwbyWN8futPatb8QLQeE7IesUOqS8SzC?=
 =?us-ascii?Q?DsUNXdxfy0+4wI6lPWR3c+H4nno96GJsdIDZhn567MMsnzrJ4vS/o+3N7CcU?=
 =?us-ascii?Q?XUDwL+r430lTmqBLj0rL+2eNwR9HJ1SHmXuJSHL/VTUUXLEr5ynNnHQEVvGA?=
 =?us-ascii?Q?b8vOdW4jBG9yHJMPKAyfQtJ8JN/ta9osvVKzFqYq4XiGgPp0SlujnE8hySEQ?=
 =?us-ascii?Q?8o2Nf98VluTi8/Z5xgJdPhroNGkkx0C/X99/kF+GbUT4PEeoWW0vcAKrcy9z?=
 =?us-ascii?Q?nXD8mq9EkB4CTJbOUEFXsupbqCGSws7VPqIEv/U18zIYly/lU7hBsr+BPsRR?=
 =?us-ascii?Q?UJ45L+SCuHg2xBQBjpiuI/P767AfBRbRVy6C3f83gUfUFpydDRjgnl2kkQQX?=
 =?us-ascii?Q?K4kzHOHCoDqScLmjkPeUIV14xFiotFmVe/augz5G3LNazwIJqUu6A9lh2y3N?=
 =?us-ascii?Q?UpPsQIhQFqnfzY+d3MwApoqdL+z5ZsCCsL9OGZKxIuITEETPYRozEYYUI1Iv?=
 =?us-ascii?Q?4dcUvaYQrZg9Zs0tF/WChpxxjx3CH4bSjJ1UYmHgaS+khAlDjm10zkjuf8ld?=
 =?us-ascii?Q?tL6SJQQqEfJaqtdMenkVi/mymHM7QSFtv3IsrlnSfO4fe1DbT2XQwCBbhDV7?=
 =?us-ascii?Q?fLL3rcu7+ch2sW9N2+8+swekEhgJRRAwASRRttad2gNmejh8GI7J6uJw4YK2?=
 =?us-ascii?Q?UqQZYt7f3I25BZkh5LHV1pdw7YSOgahL9jZwBfJdYgBDYnBCjtXnR321JeLv?=
 =?us-ascii?Q?9Pg5SCap0/nwGz+j4NG8IFMMFODdw6LwVLWFZnObQ386zYCNqD2R9reKvtL2?=
 =?us-ascii?Q?7M0WrCoxPa2+cqqopGu1V3DCzMAY0fwyvNjvdq239I5I+G2/awYGOv04Ri9F?=
 =?us-ascii?Q?p62EkdkCA/GuT2/U24RLShQ6YokzvNlvwhQZzyVd7a4sDAgw2AHlE1ZqIUj2?=
 =?us-ascii?Q?AKJ4R/vPeUxlTUXsvX/cieMWjnmTsMtQDIRUCvYL9b4YpxdSHuMOGL72QY87?=
 =?us-ascii?Q?4stWkbJ3q6xml30DcWBgG4ztQw3Sk3xokNqN9X5cmEYzsxolarR+lOiDLqJ8?=
 =?us-ascii?Q?fpmanNLvHIowh51A7bKbcGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92BD99CD9231764EA4421A774147F344@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vaqXp1vY/RIYP6FFvJmBheJhixm/Cm0rq34X+3bC5rhKon/Gd4Q9tWjzjyV5?=
 =?us-ascii?Q?PU/UGkg8wBXlV/9NROcyXc2nhplHYqQbx6rwBvyIzlkN1IdRkgYEmT7oTGbP?=
 =?us-ascii?Q?OTiMNKa9PSst0+5fQRN18YaISY4c04fRpmyuxcsHc53Hzxod5Rce16FmLBdj?=
 =?us-ascii?Q?pQIsOnN8DrZ0TL0czaRR+jW5oIPvPRyimWOKdFO7i6JJu0eJlaC3XDUem1xi?=
 =?us-ascii?Q?PzMcR31dNYAchQ0OuNoDPPHKR+C+7TJiwvQpX2GVxTclVoshjeze0r3kC0Rg?=
 =?us-ascii?Q?VIoSiLeWjd1o20sHA/cr998FFEJglQ3nRJFyMRAljDqbsYmUCXsEVPI7vfDu?=
 =?us-ascii?Q?YoITxf5TKiAUXFGOrnbK8XIoypXIKPT8fpRZhU4ig2CnWI0itLASFam0zjZP?=
 =?us-ascii?Q?H/jhYeg1SIXqrZDgvOA3SZ2u3UXD/gVDGc5jmqdXagmMigE7dAy+sdr3LCp4?=
 =?us-ascii?Q?yRCPQXa+WzGicfKU/b8rgjhF/iIYIGIwRPKqJBhvb/JY/VZt4XBWxDYeufZm?=
 =?us-ascii?Q?UZh6Zr4/o1F5UUniQwjq6clVQlOA+eEl+MEq/mQsrAo2T4nBnldX/+Xfp/Wx?=
 =?us-ascii?Q?pCLb12Pl43d/CxR3tg7mVOgbY/15Kc3w9TVG7BBZGqLhgTOd8YxOp1Inr6cP?=
 =?us-ascii?Q?vN9hlUDMfJpeZRHkOP/jvu1gUMygOcEiEniNI0vfS8OMmaO+UbyAZZRj2zM/?=
 =?us-ascii?Q?LNicmt78QT32vjnW1v/1k9mo2+fkWVBnsunsAVDbG4/ZxgRfW1Jf4gETM1Zk?=
 =?us-ascii?Q?wb+jAbUpGFbM4QPFgz7ckgoy+EGjUiuYLc7sYRvaHuqjIY2nJwfW+tTEgSze?=
 =?us-ascii?Q?lBi9lGYVs247Jyk2hBYg/0/Ir1v+DcQ6cMldkyJ6qNO1cXyWPSxILsHaapdz?=
 =?us-ascii?Q?JwVFV74AlEKpi1xNWc+g16iQtImRYgajHm737S/nwueuCTrlBraukyPWF5sE?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c6d2a2-9bff-4aa3-1924-08daa804674c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 01:36:49.2410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5SvV6S4U/X8gObI5dkvqoF2OqFW47xMKuTqsekNBFwmXjUwu9HzIpApjCe/gX/O2FNrrhUdXZd8RoecRmmhX0JodOWCduQ0bBmYwt/alPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6577
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 06, 2022 / 02:30, Shinichiro Kawasaki wrote:
> On Oct 05, 2022 / 08:20, Keith Busch wrote:
> > On Wed, Oct 05, 2022 at 07:00:30PM +0900, Tetsuo Handa wrote:
> > > On 2022/10/05 17:31, Shinichiro Kawasaki wrote:
> > > > @@ -5120,11 +5120,27 @@ EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
> > > >  void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
> > > >  {
> > > >  	struct nvme_ns *ns;
> > > > +	LIST_HEAD(splice);
> > > > =20
> > > > -	down_read(&ctrl->namespaces_rwsem);
> > > > -	list_for_each_entry(ns, &ctrl->namespaces, list)
> > > > +	/*
> > > > +	 * blk_sync_queues() call in ctrl->snamespaces_rwsem critical sec=
tion
> > > > +	 * triggers deadlock warning by lockdep since cancel_work_sync() =
in
> > > > +	 * blk_sync_queue() waits for nvme_timeout() work completion whic=
h may
> > > > +	 * lock the ctrl->snamespaces_rwsem. To avoid the deadlock possib=
ility,
> > > > +	 * call blk_sync_queues() out of the critical section by moving t=
he
> > > > +         * ctrl->namespaces list elements to the stack list head t=
emporally.
> > > > +	 */
> > > > +
> > > > +	down_write(&ctrl->namespaces_rwsem);
> > > > +	list_splice_init(&ctrl->namespaces, &splice);
> > > > +	up_write(&ctrl->namespaces_rwsem);
> > >=20
> > > Does this work?
> > >=20
> > > ctrl->namespaces being empty when calling blk_sync_queue() means that
> > > e.g. nvme_start_freeze() cannot find namespaces to freeze, doesn't it=
?
> >=20
> > There can't be anything to timeout at this point. The controller is dis=
abled
> > prior to syncing the queues. Not only is there no IO for timeout work t=
o
> > operate on, the controller state is already disabled, so a subsequent f=
reeze
> > would be skipped.
>=20
> Thank you. So, this temporary list move approach should be ok.

Keith, while I was preparing the formal patch, I noticed a path which may c=
all
nvme_sync_io_queues() when NVME controller is not disabled. Quote from
drivers/nvme/host/pci.c:

static int nvme_suspend(struct device *dev)
{
	struct pci_dev *pdev =3D to_pci_dev(dev);
	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
	struct nvme_ctrl *ctrl =3D &ndev->ctrl;

        /* ... */

	nvme_start_freeze(ctrl);
	nvme_wait_freeze(ctrl);
	nvme_sync_queues(ctrl);

	if (ctrl->state !=3D NVME_CTRL_LIVE)
		goto unfreeze;

When nvme_sync_queues(ctrl) is called, still ctrl->state can be NMVE_CTRL_L=
IVE.
So, I think namespace addition or removal can happen in parallel to this
nvme_supsend() context (this is super rare though...). If this is true, the
patch to move namespace list to stack list head may cause removed (or added=
)
namespace to appear (or disappear) after suspend & resume. (I think other p=
aths
of nvme_sync_io_queues() disables the controller and fine.)

Comment on this guess will be appreciated. If this guess is correct, Tetsuo=
's
suggestion would be the better, even though it adds a new mutex.

--=20
Shin'ichiro Kawasaki=
