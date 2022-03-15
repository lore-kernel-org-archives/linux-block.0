Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4881C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 05:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbiCOFZr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 01:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiCOFZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 01:25:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286182701
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647321873; x=1678857873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R6xzwgtd6si0feShKJT+p4K0EsN8nQ56GJCHDYbLTho=;
  b=Y06w8Q0Em1md4RU8M0Sccjc4N8sP+QkQVOXzPSEcYWWnDXgKmoQkbPo3
   9K++Wgaq8QHci8pNcgNaIkgEmAfhwaKzhOg5dXsQxWW+bUPe4LVh07/+d
   Tm0A0on4TYgXaA8F5+C3yaVejyh+9hw0ReWshy04SWV/OOok27Aw6VBt/
   84lMidyyDWr6tnnLvponR9E76z29mqzjbB4OmsTaf4emqcRRc3SH8ji9n
   WJAHJDiFXEgumyMH50nxXBwEREpQcJOPumODXg/LrpQmxsF9NtG1Y1HbH
   RfU5wMy0vrKsKqAN21Y02F0FlP/ygzBDQopZuk+v3kjg8wWHnSH20UVZz
   A==;
X-IronPort-AV: E=Sophos;i="5.90,182,1643644800"; 
   d="scan'208";a="195377661"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 13:24:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAWB5YgrbhsGwRttDGcGYoERrLHXn6kPCX2hGna70PckqWmVK4Wra0PrGWhKaIyo3rASBaKtgERxew5gw9CcKP2pu/KWvrvGO3EejMjW3IGARil1sYXWi3vINmvNxSbYtPbedAmmk3zxTq0bbE0sedQaA9Fxpr+hse1+dRsQXo36ZB2Sri4WjBAK+3rRsfp8n8qijGku/hKamQA/R/kPq/b6bHS2gkk4KCSKxcwsbq/LG+lGtGEsX23MPAcaet5oTT1ERIGdwnlrZmvK7nUT2cFe1PRL+1EWCQ7ftEdz6zaqZuIfUbB2xYuCELacalJ+ylBXKX/swlDqcROerY84EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65e8bckyRYgXkgfGopc95rj8Ca6AagWJanuKu7MmNdA=;
 b=NZZSUlw0eUxKWBgIwS4Pyddcgg89xsElGJxMOu9FO2lJii14tLAvPdDHIGief3JCr6JoMcgkOCvny/Ug7yZLuhE/ShJr3QogA8grOy7bKLr77kyj2oJ/Z1aGS7v7UwKmmogzANuRsi5fMKsUr5f5nM2KV4ZphcQCiGANRMptZiojqvpoohFxwRE31l+N6ZScrDos4LKxJ0f3q86MDCDTII4jU4f4xctJqgw4WwTGWjrhNEWYltTHud6iJlwF2alPT11+YofixCOUc1WSPgpwwP11ptjidwr30xO15yP1rqEqA7Q3omhvp1EMO1mYXdO66kj0Mo2EanxvjDWB972+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65e8bckyRYgXkgfGopc95rj8Ca6AagWJanuKu7MmNdA=;
 b=U99E1nxh7GTCDMjkacnpcMNOlAUw0t70OWd/9+uaid9vS+uIKZdDwWGkAzX5kDE80r3yRJhl3fwYjJKgmnarempFBvblF5yTiJs1FzUpzoONokcUkF7jotLYY0Z8sOmOLz7cMhR5dYkiCZESNsuZb+4vE2Tc2HwNH3SC39rRBFM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8353.namprd04.prod.outlook.com (2603:10b6:510:4b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Tue, 15 Mar 2022 05:24:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 05:24:32 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Topic: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Index: AQHYNF+T3Cwh4555b06Tjj5eYItVAKy4YrkAgAAsjICAAAHeAIABJ3+AgAA5uACABGx7AIAAGrEAgAF3oIA=
Date:   Tue, 15 Mar 2022 05:24:32 +0000
Message-ID: <20220315052431.zhj6d7srkhjudiua@shindev>
References: <20220310091649.zypaem5lkyfadymg@shindev> <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
 <20220311062441.vsa54rie5fxhjtps@shindev> <YisblCKgf6xC0/ai@T590>
 <20220314052434.zud5zb5wqrjljk4b@shindev> <Yi7n9mgblKcC7msM@T590>
In-Reply-To: <Yi7n9mgblKcC7msM@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 387cb8f1-34f0-4cba-37bb-08da0644160e
x-ms-traffictypediagnostic: PH0PR04MB8353:EE_
x-microsoft-antispam-prvs: <PH0PR04MB8353BCA37B404DADED23ECBFED109@PH0PR04MB8353.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LG+LBoZKOM4vcyr4rIyZhVhZUwx9DhKaSUF5eFdzTRoRT9RQSk4yNpE2H1/HKaNsp6V0e/o57cMVUaMiN/SXRq943OM/gnIB/oXOzkwZSKo//fG/lJtZpGmWidWjPpxdTlSk0NyuhuHHznonPTFcHsO5Ln9ubQyn1Yet6lurs4wcItDD0Meo9aC6E4S4Pug9eMMVpDuyxIQo4Ykwe+p5RGQ8frF4fvwPl78TkX9YBH+VHiqECvpJi/b8LcxlEipBnQ8KzKL9iK5ECOBLgOzSnFi9Yu05O5dNvpnfmJG4y66jPhXtVb/zIe/lVw4hivPIO96LNYsn4unjUaWYFEIY1hqymllIhh1yQK9EdT1p9+Aq2rI7UYvQ8pyyxEvRmK91EX4PDfIdcO8GK0sR3Dlv8IV5ClBgSt38Webl8DYKbZLptvroMW9qiGVlIfWIDYXluGVxuFkpQosy+JZr90qdPxafysWvuawfeavcXvj9BV/0T1TNwcRKsfls7c7jDNqey7ntzqcMafYlSZTRnGBf6ApxwCFOpN9WnhZgg9pqfE/TKn2TK/w+3+NEFBoUX7jQ6PKMOYCDRVp0dysBU9Cm2Cpwv2IAGbHmg+Va0nPNWwbsj1e+UQWYXKoScQK2y6RtYTgmfKO65r7Pv1jgYcsOA9GpkjgoCawniEMIf0jaWg29tTMBHqtgdqQOdLfdiK6HX22W67Wm8F0lhW59YGt4EhcrBzlfGJTbKirjZMfILM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(83380400001)(86362001)(44832011)(5660300002)(508600001)(6916009)(66556008)(54906003)(6486002)(82960400001)(2906002)(122000001)(186003)(26005)(9686003)(38070700005)(316002)(6512007)(38100700002)(8936002)(1076003)(66946007)(66446008)(6506007)(66476007)(76116006)(4326008)(8676002)(91956017)(64756008)(33716001)(71200400001)(53546011)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nx4OA7fok4ky3R6bzdOyDD0swvYpQC/3g/9066j3ieiMZUEnGyKcspNig1+U?=
 =?us-ascii?Q?HRQ3JWK4leY0j1yTW9pQij2JJE31pbvJJCAwP+n42OBtAppafM3K1LbxCbZ/?=
 =?us-ascii?Q?lZA7KUNfvxLHQzipNagHnA0Uj0gQIpvCKclUVx8tw3CFmgrXDVvZda/sGJT7?=
 =?us-ascii?Q?AS70RFM/8x/riWfVk9IBSXatjJSU22q6HNRoeFaEpsP2To+RqDjOg0FWW0aX?=
 =?us-ascii?Q?PKA7qzvGhInXVbwptQHFc4kOfju01JqLihY8yuFo49CGgXjtIpn+DhyPGhQs?=
 =?us-ascii?Q?5PtFcRhNYvVjh+xf8NnUCr/T7b0JHXADydjOLaARsrfF6ssU+xVtgPg1Kvia?=
 =?us-ascii?Q?mgFl8vE2tMXTSSQIhWzcE4/O2WwKno5sgovWE1taf7B3XmRM/mlVoOoLVqQ+?=
 =?us-ascii?Q?mcVxai9oYXsiBaiNpU9KzzwHwKHdmLR5GXyuYuHb0cWmUANFSl3oBEwrlFWm?=
 =?us-ascii?Q?Ez4Ollt7AlpEmLmnuWmKyXcgDFbXU/cpOsgCzpEMVlVRs5PrQIuaoDTuunZG?=
 =?us-ascii?Q?PSw7B8VVgz74J06LyNN7KkKxtCILNVfQa3FUgtFY+X5w1GLlFOfEYL3YkCHX?=
 =?us-ascii?Q?6/DzekimJXugvodNIpGYrhMpEoMHQIlLbVZPH6S+33+F50qlEe1trSWSlPgr?=
 =?us-ascii?Q?INjlTSIzxJJGFUOanPu30Y3qT+YlkZfltNNLP/lZfxCpeViweY7UGf+l9x0c?=
 =?us-ascii?Q?16/Ft+csie+NGKggZFUn0QvCjjXtQ4qdgM8snQhSGmjiuU82/IDE8er0afru?=
 =?us-ascii?Q?BLnY33Aocy7M1noMnsfmIv82ZeFLJ9g/xZQg03AClNdtzJrPSZTUHq2jaPWC?=
 =?us-ascii?Q?Odk+ueMkeqoU0K9tiiooN4c9YT5vTIX/UX4eGpsBcqJTxL6upK5XTi8O6Bou?=
 =?us-ascii?Q?8cXF7gsRWw7d3BcOPK8BL7NLvOEzHyRbU6anEjqU7lftXRHJd+WYv2kOWb6D?=
 =?us-ascii?Q?z921/Q9HudKvj0NQwuaCVAWZeOCXNQ81+HgJUOBUb9MpmGe4MBjmx3bacdOt?=
 =?us-ascii?Q?mpEyUMiZZjzgINmtL1ZjY+l6gekL4MUAVqjHQ52Cs8b/axkMbX+4qKbko2DH?=
 =?us-ascii?Q?vfNyA9G1a+2sVKOOz2I29qursOtTpRaaFn4hOVK8BP9aYwRqGBwi73dR6w3Y?=
 =?us-ascii?Q?NtQQPhC1KJ2U9f0xu7a43E8ZO6UxpLz4+EyRA06UQVPou7oO7mzVvv4uVsiX?=
 =?us-ascii?Q?ptGyJVhAvWvBEU6ZVkK/NxYAe46Nc4SuRsMjwEXfxMt31di39l1SNjmT0JPh?=
 =?us-ascii?Q?3Mgxdti3DnOCfuXvA+a5LxsfV8uwyvHU7UMgwAMe84SPHqkpfuVV2kTs/gS8?=
 =?us-ascii?Q?oJgJ7Zkb+70kFVk1NvYF/zVqeNI0V87slhdaYUHICLEHlCzLcA9gwHWI376V?=
 =?us-ascii?Q?PLCqTZTGShcIOdVIHyCCI1rX6Nvh7b2JG6Cv8cqiHtttSsU7yuXFIxUmQyiM?=
 =?us-ascii?Q?/troqkKYinQlEKBbBFCE8o3r0Es6kfSgNystruv1uodccLnaehdJOr+nkcGH?=
 =?us-ascii?Q?Yd2vyw7yqTQMrnc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5EA631A82E3394E89543AB710009149@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387cb8f1-34f0-4cba-37bb-08da0644160e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 05:24:32.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huI8wOgA7Nn14qDPNTNvUNBkzG5e/hgjXV9Xgt2Rslwic9wPkOmOeVnoJtkUCXWuvPRqNONmKn5G2I3f+maByGOVtRlITx2Eihspjsim1/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8353
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 14, 2022 / 15:00, Ming Lei wrote:
> On Mon, Mar 14, 2022 at 05:24:34AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 11, 2022 / 17:51, Ming Lei wrote:
> > > On Fri, Mar 11, 2022 at 06:24:41AM +0000, Shinichiro Kawasaki wrote:
> > > > On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> > > > > On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > > > > > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> > > > > >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki =
wrote:
> > > > > >>> This issue does not look critical, but let me share it to ask=
 comments for fix.
> > > > > >>>
> > > > > >>> When fio command with 40 jobs [1] is run for a null_blk devic=
e with memory
> > > > > >>> backing and mq-deadline scheduler, kernel reports a BUG messa=
ge [2]. The
> > > > > >>> workqueue watchdog reports that kblockd blk_mq_run_work_fn ke=
eps on running
> > > > > >>> more than 30 seconds and other work can not run. The 40 fio j=
obs keep on
> > > > > >>> creating many read requests to a single null_blk device, then=
 the every time
> > > > > >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it return=
s ret =3D=3D 1 which
> > > > > >>> means more than one request was dispatched. Hence, the while =
loop in
> > > > > >>> blk_mq_do_dispatch_sched() does not break.
> > > > > >>>
> > > > > >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hct=
x)
> > > > > >>> {
> > > > > >>>         int ret;
> > > > > >>>
> > > > > >>>         do {
> > > > > >>>                ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > > >>>         } while (ret =3D=3D 1);
> > > > > >>>
> > > > > >>>         return ret;
> > > > > >>> }
> > > > > >>>
> > > > > >>> The BUG message was observed when I ran blktests block/005 wi=
th various
> > > > > >>> conditions on a system with 40 CPUs. It was observed with ker=
nel version
> > > > > >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc=
245 ("null_blk:
> > > > > >>> poll queue support"). This commit added blk_mq_ops.map_queues=
 callback. I
> > > > > >>> guess it changed dispatch behavior for null_blk devices and t=
riggered the
> > > > > >>> BUG message.
> > > > > >>
> > > > > >> It is one blk-mq soft lockup issue in dispatch side, and shoul=
dn't be related
> > > > > >> with 0a593fbbc245.
> > > > > >>
> > > > > >> If queueing requests is faster than dispatching, the issue wil=
l be triggered
> > > > > >> sooner or later, especially easy to trigger in SQ device. I am=
 sure it can
> > > > > >> be triggered on scsi debug, even saw such report on ahci.
> > > > > >=20
> > > > > > Thank you for the comments. Then this is the real problem.
> > > > > >=20
> > > > > >>
> > > > > >>>
> > > > > >>> I'm not so sure if we really need to fix this issue. It does =
not seem the real
> > > > > >>> world problem since it is observed only with null_blk. The re=
al block devices
> > > > > >>> have slower IO operation then the dispatch should stop sooner=
 when the hardware
> > > > > >>> queue gets full. Also the 40 jobs for single device is not re=
alistic workload.
> > > > > >>>
> > > > > >>> Having said that, it does not feel right that other works are=
 pended during
> > > > > >>> dispatch for null_blk devices. To avoid the BUG message, I ca=
n think of two
> > > > > >>> fix approaches. First one is to break the while loop in blk_m=
q_do_dispatch_sched
> > > > > >>> using a loop counter [3] (or jiffies timeout check).
> > > > > >>
> > > > > >> This way could work, but the queue need to be re-run after bre=
aking
> > > > > >> caused by max dispatch number. cond_resched() might be the sim=
plest way,
> > > > > >> but it can't be used here because of rcu/srcu read lock.
> > > > > >=20
> > > > > > As far as I understand, blk_mq_run_work_fn() should return afte=
r the loop break
> > > > > > to yield the worker to other works. How about to call
> > > > > > blk_mq_delay_run_hw_queue() at the loop break? Does this re-run=
 the dispatch?
> > > > > >=20
> > > > > >=20
> > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > index 55488ba978232..faa29448a72a0 100644
> > > > > > --- a/block/blk-mq-sched.c
> > > > > > +++ b/block/blk-mq-sched.c
> > > > > > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(str=
uct blk_mq_hw_ctx *hctx)
> > > > > >  	return !!dispatched;
> > > > > >  }
> > > > > > =20
> > > > > > +#define MQ_DISPATCH_MAX 0x10000
> > > > > > +
> > > > > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx=
)
> > > > > >  {
> > > > > >  	int ret;
> > > > > > +	unsigned int count =3D MQ_DISPATCH_MAX;
> > > > > > =20
> > > > > >  	do {
> > > > > >  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > > > -	} while (ret =3D=3D 1);
> > > > > > +	} while (ret =3D=3D 1 && count--);
> > > > > > +
> > > > > > +	if (ret =3D=3D 1 && !count)
> > > > > > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > > > =20
> > > > > >  	return ret;
> > > > > >  }
> > > > >=20
> > > > > Why not just gate it on needing to reschedule, rather than some r=
andom
> > > > > value?
> > > > >=20
> > > > > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > {
> > > > > 	int ret;
> > > > >=20
> > > > > 	do {
> > > > > 		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > > 	} while (ret =3D=3D 1 && !need_resched());
> > > > >=20
> > > > > 	if (ret =3D=3D 1 && need_resched())
> > > > > 		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > >=20
> > > > > 	return ret;
> > > > > }
> > > > >=20
> > > > > or something like that.
> > > >=20
> > > > Jens, thanks for the idea, but need_resched() check does not look w=
orking here.
> > > > I tried the code above but still the BUG message is observed. My gu=
ess is that
> > > > in the call stack below, every __blk_mq_do_dispatch_sched() call re=
sults in
> > > > might_sleep_if() call, then need_resched() does not work as expecte=
d, probably.
> > > >=20
> > > > __blk_mq_do_dispatch_sched
> > > >   blk_mq_dispatch_rq_list
> > > >     q->mq_ops->queue_rq
> > > >       null_queue_rq
> > > >         might_sleep_if
> > > >=20
> > > > Now I'm trying to find similar way as need_resched() to avoid the r=
andom number.
> > > > So far I haven't found good idea yet.
> > >=20
> > > Jens patch using need_resched() looks improving the situation, also t=
he
> > > scsi_debug case won't set BLOCKING:
> > >=20
> > > 1) without the patch, it can be easy to trigger lockup with the
> > > following test.
> > >=20
> > > - modprobe scsi_debug virtual_gb=3D128 delay=3D0 dev_size_mb=3D2048
> > > - fio --bs=3D512k --ioengine=3Dsync --iodepth=3D128 --numjobs=3D4 --r=
w=3Drandrw \
> > > 	--name=3Dsdc-sync-randrw-512k --filename=3D/dev/sdc --direct=3D1 --s=
ize=3D60G --runtime=3D120
> > >=20
> > > #sdc is the created scsi_debug disk
> >=20
> > Thanks. I tried the work load above and observed the lockup BUG message=
 on my
> > system. So, I reconfirmed that the problem happens with both BLOCKING a=
nd
> > non-BLOCKING drivers.
> >=20
> > Regarding the solution, I can not think of any good one. I tried to rem=
ove the
> > WQ_HIGHPRI flag from kblockd_workqueue, but it did not look affecting
> > need_resched() behavior. I walked through workqueue API, but was not ab=
le
> > to find anything useful.
> >=20
> > As far as I understand, it is assumed and expected the each work item g=
ets
> > completed within decent time. Then this blk_mq_run_work_fn must stop wi=
thin
> > decent time by breaking the loop at some point. As the loop break condi=
tions
> > other than need_resched(), I can think of 1) loop count, 2) number of r=
equests
> > dispatched or 3) time spent in the loop. All of the three require a mag=
ic random
> > number as the limit... Is there any other better way?
> >=20
> > If we need to choose one of the 3 options, I think '3) time spent in th=
e loop'
> > is better than others, since workqueue watchdog monitors _time_ to chec=
k lockup
> > and report the BUG message.
>=20
> BTW, just tried 3), then the lockup issue can't be reproduced any more:
>=20
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index e6ad8f761474..b4de5a7ec606 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -181,10 +181,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq=
_hw_ctx *hctx)
>  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>         int ret;
> +       unsigned long start =3D jiffies;
> =20
>         do {
>                 ret =3D __blk_mq_do_dispatch_sched(hctx);
> -       } while (ret =3D=3D 1);
> +       } while (ret =3D=3D 1 && !need_resched() && (jiffies - start) < H=
Z);
> +
> +       if (ret =3D=3D 1 && (need_resched() || jiffies - start >=3D HZ))
> +                blk_mq_delay_run_hw_queue(hctx, 0);
> =20
>         return ret;
>  }

It sounds a good idea to check both need_resched() and 3) time spent in the
loop. I also confirmed that this fix avoids the BUG message on the scsi_deb=
ug
workload as well as null_blk with memory backing. Looks good. For this
confirmation, I modified the hunk above to avoid duplicated checks [1].

As for the loop break limit, I think HZ =3D 1 second is appropriate. The wo=
rkqueue
watchdog checks lockup with duration 'wq_watchdog_thresh' defined in
kernel/workqueue.c. In the worst case, its number is 1, meaning 1 second. T=
hen,
1 second loop break in blk_mq_do_dispatch_sched() should avoid the BUG mess=
age.

To reduce influence on the performance, it would be good to make this numbe=
r
larger. One idea was to refer the wq_watchdog_thresh as the limit for the l=
oop
break. However, the variable is static and defined only when CONFIG_WQ_WATC=
HDOG
is enabled. So, I don't think block layer can refer it.

Assuming this fix approach is ok, I would like to have a formal patch. Ming=
,
would your mind to create it? Or if you want, I'm willing to do that.

[1]

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba978232..64941615befc6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw=
_ctx *hctx)
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	int ret;
+	unsigned long end =3D jiffies + HZ;
=20
 	do {
 		ret =3D __blk_mq_do_dispatch_sched(hctx);
+		if (ret =3D=3D 1 &&
+		    (need_resched() || time_is_after_jiffies(end))) {
+			blk_mq_delay_run_hw_queue(hctx, 0);
+			break;
+		}
 	} while (ret =3D=3D 1);
=20
 	return ret;


--=20
Best Regards,
Shin'ichiro Kawasaki=
