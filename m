Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A071C43217
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 13:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJCNc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJCNcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 09:32:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495953472C
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664803967; x=1696339967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=32EsTH4UuMLgRtClTM4nfy24/adOIWN6Y5k9hctJRHA=;
  b=aYKicN9O+Tn8m7RWpF5zwyaDDBogzO3m2yhyZCyaiuhCIpwbz26A3+Uo
   2mozJm6+5PePJB+XjYZWUIVSLY0H53qmJvUTdytSEdxxhTnFQL+tF7X6T
   bpr3t5c1BNqRZ6Bwq2+l94LlRRNLr71itNNmZDXIUGDwq0FFUetIFpO7W
   eUn6z2bTWjb4RNxeImE4AjQjWSoFgPdVLfBJyVxX40bTCzVV/uP6i9ay4
   OjwLWb0vfWVznqTIwuvt3Ma4q7lUDw4+xEWijpEcgMC2792rTa6a9dgnl
   KUq8AuuftuvVMep407fJDz66P5OFvo4L6Y+nbV5Y+J09LWIMdw4JFSKbs
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,365,1654531200"; 
   d="scan'208";a="317136589"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2022 21:32:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRFNL6LpH8syRPh6yiWWrp5q7AjOJnGVl1Xov0c2WVhHg+iVxkj2zrQeFkwuBTMWknVGr35xYoOreTmv+cMIPVhXMJ2YqaKTI4hnC1iYP1EP0jBMaKHo2aYCD+6rNHf3Y2LUhcqg7VPxXQJLVPY1wUoHG8fSF1U/HEg3LVmI8WcqHyxxYKTzM3hjWnqMmW1D3waFTNnlDkW/KcXksrTtjrokEXxJ48DwegnMPMD2sQ1nGtqaCWGL/Fv8vIQjydPgxMR1cY5Ux+kUCPtkwpel2ik66ZeFAZFrasqFLTwXXvU2YdaYYREd6mgFEjMyIX2Be2fejRcD2fdKjdclznwn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJejfkecPrrB27q8PI+sfAyZcMkgrlP5uwx6eS1RqV8=;
 b=OZ0lgHAU7VuWDehQ3AbTR0aWzOKeMIwnac7AV1ZndtUcGsEc72+tEdv9BQZv8v93m+1b7oK6o3mfAnIdURAE4EnC/BQD+qLMHiDJe9EqthSDpY8KFOb7llZzcTZX+WLF1a/byX21cEpH7nW03njCRtuAoCXUaF4j6fCgM8FetE63Wq/tRmttxaGF3wTSacMAnwaxBwh1byB+1DkhGAGnEDzNCfC89ssUKS0+HpWUHq9YjyhDWCOzreGZ7zc8FFfqSDJdjCcjRbUB8X/ymZhBr4SNAwKs9dGlXKPd/UF+kOmvI4g66iS+CvJZJWc8UVx6L8c58TGQEIupzlEaP3O0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJejfkecPrrB27q8PI+sfAyZcMkgrlP5uwx6eS1RqV8=;
 b=ZZBi7o4BrP3eGxh0iWCbbKcwctRCEjcYith1dsEGey8WwWqP1VL/1q/VdTQ1Fu3/NXX3nYk2kGl22pk3Y3grlMRHzo2ttgx9c5gGqSkjHYchzbiiM7p1zjlrUAh8OJWjxVktuJZ4dZOhS/ingy7ZSGhmLtEwNam/sSo+zYhuX8I=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR04MB0231.namprd04.prod.outlook.com (2603:10b6:903:3c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Mon, 3 Oct 2022 13:32:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f%5]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 13:32:41 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Thread-Topic: lockdep WARNING at blktests block/011
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaa330IUAgATf7QA=
Date:   Mon, 3 Oct 2022 13:32:41 +0000
Message-ID: <20221003133240.bq2vynauksivj55x@shindev>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
In-Reply-To: <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CY4PR04MB0231:EE_
x-ms-office365-filtering-correlation-id: 37c4e7fb-38bc-46c4-75ed-08daa543bf5e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9G2uSoLaD1lURiQpaGn/skIxLUshquT1EtczQr9KBLnStB5AU/R5s3PNJfBrX0ivuSYngrpLHaxangrRBQlIqwruo76P/xFMrjG1wwNKo5dWW6VjAeiO6rBH5GxhyjPjLvTxJwI+fWIK+X6GXPIeYOvSVXDHsbOg8FHupqabjSeAecYxlYCfqUJ1c8c49yXCtXYZPegbAsY4xZLtqVqkwHBjaCIPhDpV3sFXHciPR2BA1isSRff/COTdFgn1iZELIThNeD3kHnUZrmIrQwEhTH4LhgMEIEyHvomS99SUsNJO95mebY24a5sLo3QDP77h5VhHP3jq0W5shHhqO/Yk0DKSBNVO6u6KWGNvO3A6WMz9ZG5IR480nQxNaEEdvJ2R2gJ53p4Y7mv9KEIIhuLIvukq0b6SvXV/DILIhliLSD5Sv+FVFPn1mSbcwtRSbOLQmJegQRK+Zl+lyr1OoPLbYDUHuQ6Uc/XS0aGPU0lgWdl7IapJqaoN4PV7nfMPrI3QHPcke0VZREhdluBPLwSBEzbJbH6BfKMfehr6rJjOx7zEIVJAZPOIvWkl9V2q1eBDKFZFLs8gVaoYiFInr+6NJgGVAHnBEMbfNtYIKGMVJ6Z5mBwM0LQ04b0hJD9yfYmz0UQdD+AqpExiMUE5DRmJKqlA0uJy5fcXiG8kfw94AJd3BYqQKNL6xDPTHVZd+fqs9hcfOadJ5U9XT4KnA28UZhFHPpZ+V6Jk6bDMln61rf4ZOkQnosNTDv6Qdkx5z1nNQmI7oYA30J+XrLh004cow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(2906002)(44832011)(5660300002)(41300700001)(8936002)(6486002)(71200400001)(76116006)(478600001)(82960400001)(38100700002)(86362001)(91956017)(122000001)(6512007)(9686003)(8676002)(6506007)(54906003)(316002)(66476007)(64756008)(66446008)(66556008)(53546011)(4326008)(6916009)(33716001)(26005)(66946007)(1076003)(38070700005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?79ZBgrxNpvBIVD9+aOc4fywAPwIN8fhIlTYSRIOzCEJCZTrXpgGxReVz01No?=
 =?us-ascii?Q?JtiDOF5F5Cuy/egGQLvea9qzPgF/u07wJR3GNNzBYbSypDVW3mi1+gMEr+8x?=
 =?us-ascii?Q?Y+WFSHkf8QBcirmPE1rjdj5xY6x5bTGkegueY5ccQFpEho6nGm6rg7QVQh4B?=
 =?us-ascii?Q?GCqeT+BzbqBo2+JZ+endpxXHptntRcvJoEqQo7w4VtdLpYJKiQXF7ojkljW1?=
 =?us-ascii?Q?fb5esmPiRgmFIccBSKdAX5EeJl8c989f1gbc61C0tlQC0eNeM/djf5OBUDCm?=
 =?us-ascii?Q?syasBl/5JYIrgUndVdyDIe5lox3u93VfQqkxGokshlmdumqlvhkDYNRE+WMH?=
 =?us-ascii?Q?ELbAyUazSflRastYDtnxnlycA1vIlLtcay9c65GTd2mPuNISeCBZ/s3mxS2O?=
 =?us-ascii?Q?EsRNSz3AaQUzxM8Cs1HutkgmzAiD/3kKrWN27L4o2VCc+s3wx0lEg8hda/RT?=
 =?us-ascii?Q?qmwtbJrzSylqBtIouDsmDAPWi+08xBgoCgYD86o+XAVJfuIluWDoUKJqKLzK?=
 =?us-ascii?Q?cRqo8POmk+Scji35/vvkvq47lQx9tnv1dBEha2Qiu+8jgidUSBzqhQhPfKp2?=
 =?us-ascii?Q?+9b0DM+Q+887lgyL1/hsAMn9+sLgLipvzKt4ucTBhNTJbPV2kRUr+YKmblh7?=
 =?us-ascii?Q?7x8psrMuFoQQlzKTPLAKpTZ2pGXsfOkNjt4+6m5nQQWs/IihVPFiaHbeLO1E?=
 =?us-ascii?Q?ZyacgOXsz1FeqNsT0qwefwR6XHso00M8g+8cAhnX2kqzsehLTloLTBT4sndm?=
 =?us-ascii?Q?RUIU2dUSWpjucijWiOR4wJEUByHQ7U8GsEYjXJuKewOqOKXD21y2DwKij+ZB?=
 =?us-ascii?Q?BeO2hMvDgeJjE4oHvas0meGUMYFfH12LpzK+c8HoPRdHSpyLP8i6TuwBAlkd?=
 =?us-ascii?Q?tNImHwE663ycPajnPjcVfTVWRpOBKYWWtIiJRd8pZpRM+ITvpxKEAejQzVF+?=
 =?us-ascii?Q?6do9+/nW3JKAsHZPml/kDR8fI8YuAHhleJUl+YDyigy3x6Hc8VVPl4G0ETRf?=
 =?us-ascii?Q?yPrdqRPYMZs0X9SX1NBXn6T6Nww6iea49LG4KBkk1WrR8Y/IM90EiJlXSJ8x?=
 =?us-ascii?Q?JWbPcMmrY2Gz9y0qjXDw63d75hiyr2MkTbkdSorDtOEqobCJxp5o2Hpppr0U?=
 =?us-ascii?Q?Nk6FEf9j0XuNUX+o9sf07WwsKY7J5J7Md/s04GsFD0SdYQ7MNn0WF8ADiTnu?=
 =?us-ascii?Q?yXJ3BcDkyxhUqdyLLsNn6T4SF0aP4GtfyK9BerfFYxVI3N0S4DkTeAmnEu32?=
 =?us-ascii?Q?X7SHn8pNADwoccL9xb0Qciih14ySO56Hv6+l4aSOkxP2bz+ZbKOPLSloW3pw?=
 =?us-ascii?Q?FhPGiEJUEZQNxGFlQRw283iXXQfTZNYQBXvDXq82433mOrm/AmARcn0SDRiU?=
 =?us-ascii?Q?/gU91LDN6sqxOHJjhcuPSyOAIr2lRpnAJasHAAeQ4zSP4M4mBT9NiNu2CgC/?=
 =?us-ascii?Q?Pi014sf/VAcgRH0Vcat+6pgRsd/gYovPM9pIqprMp1vooUNVps4lR4f7nA3K?=
 =?us-ascii?Q?C+QFaUFY9mSSZgXzisDd4FC9PmiIFCW/6sZGrgc1eotFN+0YWpHr+xRXhxe2?=
 =?us-ascii?Q?XLPPoBWfabkwmlBQIzFglHX+FaGuF7WfHKewIOQOFtLZgWzF7wW+OSrIKI3T?=
 =?us-ascii?Q?wFGR/sVNe4BvHjObpIKfcFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4567C5DC2240764AA2246A37FB9460EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c4e7fb-38bc-46c4-75ed-08daa543bf5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 13:32:41.7908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Z1kTzAXaNHpmnzfqFIm+ZziyPfYt1BxhD9r73W7rzjFDICNUiN+EHPZVXvKV8rKfS983dnkGHK55Wh0+TrMc0RXf0C0kjFPkNY97PvNL64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0231
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tetsuo, thank you very much for your comments. They clarified one of my
misunderstanding points.

On Sep 30, 2022 / 20:06, Tetsuo Handa wrote:
> On 2022/09/30 9:19, Shinichiro Kawasaki wrote:
> > Kernel v6.0-rc7 triggered the WARN "possible circular locking dependenc=
y
> > detected" at blktests test case block/011 for NVME devices [1]. The tri=
gger
> > commit was c0feea594e05 ("workqueue: don't skip lockdep work dependency=
 in
> > cancel_work_sync()"). The commit was backported to v5.15.71 stable kern=
el and
> > the WARN is observed with the stable kernel also. It looks that the pos=
sible
> > deadlock scenario has been hidden for long time and the commit revealed=
 it now.
>=20
> Right.
>=20
> > I tried to understand the deadlock scenario, but can not tell if it is =
for real,
> > or false-positive. Help to understand the scenario will be appreciated.=
 The
> > lockdep splat mentions three locks (ctrl->namespaces_rwsem, dev->shutdo=
wn_lock
> > and q->timeout_work).
>=20
> Right.
>=20
> This is a circular locking problem which involves three locks.
>=20
>   (A) (work_completion)(&q->timeout_work) --> &dev->shutdown_lock
>=20
>   (B) &dev->shutdown_lock --> &ctrl->namespaces_rwsem
>=20
>   (C) &ctrl->namespaces_rwsem --> (work_completion)(&q->timeout_work)
>=20
> (A) and (B) happens due to
>=20
>   INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
>=20
>   blk_mq_timeout_work(work) { // Is blocking __flush_work() from cancel_w=
ork_sync().
>     blk_mq_queue_tag_busy_iter(blk_mq_check_expired) {
>       bt_for_each(blk_mq_check_expired) =3D=3D blk_mq_check_expired() {
>         blk_mq_rq_timed_out() {
>           req->q->mq_ops->timeout(req) =3D=3D nvme_timeout(req) {
>             nvme_dev_disable() {
>               mutex_lock(&dev->shutdown_lock); // Holds dev->shutdown_loc=
k
>               nvme_start_freeze(&dev->ctrl) {
>                 down_read(&ctrl->namespaces_rwsem); // Holds ctrl->namesp=
aces_rwsem which might block
>                 up_read(&ctrl->namespaces_rwsem);
>               }
>               mutex_unlock(&dev->shutdown_lock);
>             }
>           }
>         }
>       }
>     }
>   }
>=20
> (C) happens due to
>=20
>   nvme_sync_queues(ctrl) {
>     nvme_sync_io_queues(ctrl) {
>       down_read(&ctrl->namespaces_rwsem); // Holds ctrl->namespaces_rwsem=
 which might block
>       /*** Question comes here. Please check the last block in this mail.=
 ***/
>       blk_sync_queue(ns->queue) {
> 	cancel_work_sync(&q->timeout_work) {
>           __flush_work((&q->timeout_work, true) {
>             // Might wait for completion of blk_mq_timeout_work() with ct=
rl->namespaces_rwsem held.
>           }
>         }
>       }
>       up_read(&ctrl->namespaces_rwsem);
>     }
>   }
>=20
> >                       In the related function call paths, it looks that
> > ctrl->namespaces_rwsem is locked only for read, so the deadlock scenari=
o does
> > not look possible for me.
>=20
> Right.
>=20
> >                           (Maybe I'm misunderstanding something...)
>=20
> Although ctrl->namespaces_rwsem is a rw-sem and is held for read in these=
 paths,
> there are paths which hold ctrl->namespaces_rwsem for write. If someone i=
s trying
> to hold that rw-sem for write, these down_read(&ctrl->namespaces_rwsem) w=
ill be blocked.

Ah, that's the point. If write lock comes in parallel between two read lock=
s,
the read locks can cause circulating deadlock.

>=20
> That is, it also depends on whether
>   down_read(&ctrl->namespaces_rwsem);
> and
>   down_write(&ctrl->namespaces_rwsem);
> might run in parallel.
>=20
> Question:
>   Does someone else call down_write(&ctrl->namespaces_rwsem) immediately =
after
>   someone's down_read(&ctrl->namespaces_rwsem) succeeded?
>=20
> nvme_alloc_ns()/nvme_ns_remove()/nvme_remove_invalid_namespaces()/nvme_re=
move_namespaces() calls
> down_write(&ctrl->namespaces_rwsem), and some of these are called from wo=
rk callback functions
> which might run in parallel with other work callback functions?

Though I'm new to NVME code, let me try to answer your question based on my
understanding. (NVME experts' comments are more valuable. Please chime in.)

NVME host manages dev->ctrl.state not to run contradicting works. Then scan
work, delete work and reset work do not run in parallel in most cases. So t=
he
write lock by the scan/delete work does not happen in parallel with the res=
et
work which calls nvme_sync_queues() and does the read lock, in most cases.
Having said that still I can think of a rare scenario [1] that does the wri=
te
lock after the read lock in reset work context. Then I think the answer to =
your
question is "Yes". From this point of view, the deadlock scenario is very r=
are
but still looks possible, in theory.

BTW, I came up to another question during code read. I found nvme_reset_wor=
k()
calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
controller is already disabled when the reset work calls nvme_sync_queues()=
.
Then another nvme_dev_disable() call in I/O timeout path does not result in
nvme_start_freeze() and the 2nd read lock. From this point of view, the dea=
dlock
scenario does not look possible. If this guess is correct, why the lockdep =
splat
shows the deadlock scenario??

In addition, I found nvme_reset_prepare() and nvme_suspend() also call
nvme_sync_queues(). These functions are not in the lockdep splat, but may h=
ave
similar deadlock scenario. I will spend some more time on them tomorrow.

[1]

TASK A            scan work TASK       TASK B            reset work TASK
---------------------------------------------------------------------------=
-----
nvme_sysfs_rescan()
nvme_queue_scan()
check status is LIVE
queue scan work
                  nvme_scan_work()
		  check status is LIVE
                                       nvme_sysfs_reset()
                                       nvme_reset_ctrl()
                                       change status to RESETTING
                                       queue reset work
                                                         nvme_reset_work()
                                                         check status is RE=
SETTING
                                                         nvme_sync_queues()
                                                         read lock ctrl->na=
mespace_rwsem
		  write lock ctrl->namespace_rwsem

--=20
Shin'ichiro Kawasaki=
