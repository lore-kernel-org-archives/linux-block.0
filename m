Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F96C433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 02:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJFCa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 22:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJFCa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 22:30:57 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796AF27DD4
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665023456; x=1696559456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XHPkFthF6Mij3bsKi91g9AAn8v6uM4kh737zi2gf30Q=;
  b=fv3/7BQ71dmnmRDSbtatlWDXjXCOZCcgZyD/73pHGupKH1rewbma0NSG
   Tj/xUZv4tyj6Pxph85e7AQ+L8O8lxlE+gbmyWtRaI6Ni7xb+r7c+oLFon
   fQa8brrBBjfSbw5Njq4cVwP93Q5z1/71r+U8QLsgh8ansmWfqUh0QMx0+
   envGmOhRKy32FtnldC0C46vum23dSpBAGqOFA5tkwsObzEhz73kdxR5Mz
   KFs+X/wuxrtVA7/zteyMWFZBkkN0qVZGAWnY0QrtJxRfYDh+aV6pyRciL
   3JpTCL0RMo+u+thNOC8bxwxgG13Tcbgn+3zTAKIXu9USypIa9NfFoz2HM
   A==;
X-IronPort-AV: E=Sophos;i="5.95,162,1661788800"; 
   d="scan'208";a="213497065"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 10:30:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtflKbgcakAz55s1GSAzfA2mwNXFl75MxHG/QVgMZckdXI5udvVNHdvkNQK9xmGVtDbr4CzfSDiK+gzn3BBNgmh8eduxDDDh5Yxj5mbM7xEKn2oZiet6FNjIzUHeMEpCQGUZlZvPnk/nE9PSqKgR5g1aTVTmZpVV0JJm/r1/hpZv7UcKlHl3U7HF26kUQR303xoXAXLk/RlVrcGa96lQBqTd6dKHukN9bywbfIbnJWjMZyrWh9drvNxUjl/tL2LXaVFq1+htG0Ja1rVqFym1scXy78ssyYCM5G0bi9JGtnJKFgbX3oEMaMlr/LT9NeuR3Kaekh2xeDN4zYLRbALhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFoZx8U665voe8GlaPV5b3e5krQWyGc/9zaQsxga7EE=;
 b=FXUNMZylXW1aHUPeO3bUFYxalPK98zAAqQ8U9WBjGvd8Am4Vb0A1xQDmiI4nX4lE2sUbIa96/9iGfu2CocGMPQm9EEZmz6q5ZH/bGfGW4FyVztUUi2IxewBFT8dDeZK4su15gRWJp55ohG7GHT8P3VHPVXV1Ege3nSzi3rPpVUFmQXalgwGyTtO19NShldvZOD2kio/I1FWjJNW7DM2QjVaAVDVRUf5HCDXUQRBRi1EZKoD4X/Cc0r/cW28x6+04zzMaUdOecpCOiXyXpD+3OBdvtA/xN4hiVZZVSsLxpDBzujMI2Ho38Jj6SbeynP2nWj83HNDzOa7YV4hCcLCegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFoZx8U665voe8GlaPV5b3e5krQWyGc/9zaQsxga7EE=;
 b=ARRpcLYDrRP92aYlbTkp74qoODEYGFT4W2Z5AWeabq9gqMhNhUBhxcs0oLMulAg4Fzb1lBGhuq7mcv5AOR0k7n6ieQCLJLDpzrwcNS2cnnKIjJAovg4KmA95zH7Wt3TncX6i42krcYj32Sh9qFA50FAhx81iPv1+/Wia3/W5psw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8406.namprd04.prod.outlook.com (2603:10b6:a03:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 02:30:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 02:30:52 +0000
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
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaa330IUAgATf7QCAACBlAIABQxMAgAAHQICAABRnAIABUUcAgAAY/QCAAEiBAIAAzDKA
Date:   Thu, 6 Oct 2022 02:30:52 +0000
Message-ID: <20221006023051.mkuueh5epnfominu@shindev>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
 <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
 <20221004122354.xxqpughpvnisz5qs@shindev>
 <20221005083104.2k7nqohqcqcrdpn4@shindev>
 <15c6e51f-a2a4-38ff-15a4-9efee32824d3@I-love.SAKURA.ne.jp>
 <Yz2SkNORASzmL+jq@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yz2SkNORASzmL+jq@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8406:EE_
x-ms-office365-filtering-correlation-id: 5997a862-0eeb-4b66-13ff-08daa742ca06
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skbcDVROztU8bK15Pgc0pFRpP1aCFuSn8qAWSLWWVtVBzIb3zB7bN96LskGfzBhj7NNlTXXBCT2LkxR+Zv/Hd25lao57roj4WYmNL3pOAwNXL+iXAfADL+JxslnyBOsINZzASbmbwBMCQs16Ug4sitYTFvYZOcHMe7l89qryhg8Tx2kaBYOury9GbJWX7CosOaLL6LVPeogfXg40/5OewZBeF1UNd5puHHJMvELw+TpVGZn+lM2gusGUIMWvgE9Pof7ecJGo3XMVrgkpRlXYaXIwwVXtai/pYzVEWYhdWOZ6UXdS209CfI7NTwhMSymlBGv5tIRK18HGtLPv6wKgNwJSukDP802Mf0+rzmfo7fwBgKPTDgx6RRYjZqD764AQnY37T1NAlWdqVcWXRsbPXsFhPihyRAS4feVoBPmHPhHc0pdH6SOwslrHKX0xFjNj48S2n0KG+LuxHqGU9JrBPVm7Sx89VhYn29Q3Ax9885Y+chn27cvSMFNZeHwsIQ6UKNipTrJrXjNU64Ii8+velGuDrluxWDIe018+rARyXAiTLq1e6P7oG3hPAOv9/LcQPd5d1GbHyIsVPFlp9+ApJ74T2pNHwOG5x132YHW3JiM2kU6QROsmtF3dfXkY4G1u8PPHBaBigJLP7VN8I5J3KJcYE01WtAbpZbDAha9gXuGB8aPke2QMapWVhOnAJGXfHRkMoq3a9Brm8X2stGHWbQxzdqLO6Vrwyspa5Y8YpoSJhvC0RmMcQNv2dtcM+qIadtQazmwiPSC7Zf7JRxqpLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(122000001)(91956017)(38100700002)(44832011)(71200400001)(82960400001)(66446008)(66476007)(64756008)(66556008)(53546011)(2906002)(86362001)(8676002)(186003)(41300700001)(316002)(76116006)(66946007)(6486002)(5660300002)(1076003)(478600001)(83380400001)(4326008)(8936002)(6512007)(6506007)(33716001)(54906003)(6916009)(26005)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IvgsmF+A341FMs0zUJegIzzcL4botN1jnS/qznmJkv+t7Z1HyBqwAXNa6Z9h?=
 =?us-ascii?Q?M8jlgv0k4Gu3TJpFFf82GGe4QPAbgpMYAL7JsBJCjeG5VpfQSO6uXcketJB6?=
 =?us-ascii?Q?dmf3KAtkufiU4jL+EzZZ46GT8h0NshsCkiLfxv7Pw6BYVDi7DH0Gn1fnG2su?=
 =?us-ascii?Q?j0YdiHtm04EZa7gk/aQWFwOuPu5w/Pwv0nQS0DFpK6fH4gbUpk4EYCNnFrf9?=
 =?us-ascii?Q?BMdlVFO3lQ7Xn0urFRI8CmCAyXRu89w3rLT669c5X7F+MqIoCymG+2wSIssw?=
 =?us-ascii?Q?+acOMgyrdjTjM5dSbKnnB3rL2PbCsXRPzjtqlJJlKYGUOrjYn4+UmhCfoJV/?=
 =?us-ascii?Q?c7xyo4ghBGcQBg1nQkDpbAYHC6+ottX0vfFCfEZqQJikG+aJ3SjbyjvHeA60?=
 =?us-ascii?Q?Ne59StpLXYnMxVE4Co60afJ1NRRjp8rJWLBEbH8XVKfZY+I9vUg3AFufNeQT?=
 =?us-ascii?Q?f0qd/CmHLbwjPHUz1x09VZ0ebXvp8BARfC8Q0Unx5cgCpc8TQKdi/7PsLIup?=
 =?us-ascii?Q?65uSR9339h2uMlM6Te9O9bqA7Hi/QK2naGFkU9fstUEywBuXIU6LHPltAJ+z?=
 =?us-ascii?Q?khORe5iYyBbnemFxsAJlJCk/h13SCx0jhi1Zqzy5P/Kb1nYhqp/9w8FUq9SK?=
 =?us-ascii?Q?udRcnaEbqeB6xSKziuT2YP+cRXiZgu009A4ANP1q0QJqcgL0w4ZlmRGN75Za?=
 =?us-ascii?Q?maipbUsSVAaxUEEtaupRGjszZ3VaMtvheoZGhcBhLvuhVCrVWjujMBYOEziZ?=
 =?us-ascii?Q?sz9hmVrl0/WeWRs+QljclCRql/PLiMV3LO4ynXmNj1CT8K/6LGWvHDJsBivd?=
 =?us-ascii?Q?tFSLBMCNaJZ3cRUbkZZtYwPGWvuqBTQ+8Zqq+wzgwAD+v1H6K9SE8pP3xI4v?=
 =?us-ascii?Q?GIQO/rZ8K4f0PYJ2mtcD6tnHHHA3o48dNVfxIA903YBB226gIN151MOASJRu?=
 =?us-ascii?Q?zgeHiwnoEisLOZsfNIwm54cjFGj5fzjmKSNkbpO/aupH3dw4ViGTE9LlW/Xc?=
 =?us-ascii?Q?Stg1BKppLYolvkA5hsMxKlRX2R5JTZQ8iWmBUbUy12fFEUqWPTGeZivgqRq7?=
 =?us-ascii?Q?IsPRW/96BiUDOrHUKwSBpXddUg87KHiBS/tiDX+6CQqE0p39Zd/Fuen7JgVf?=
 =?us-ascii?Q?jQUidD/Cbc9LCMeT67tAKWdgTytrfM75kYL6msLEjt/iBDTwBJJaVFWwqSR4?=
 =?us-ascii?Q?cKyqFKE8Z52j2tAg91pr9nATgBpkf5kCpW8fOOD0AUuLtDDXI3ul8dPWMljP?=
 =?us-ascii?Q?yYZaM15zFSUD/3o3M4l9dkYrgPbE+wFcXOq1jc1hxBhDwEpVIeSgPrwBHtB5?=
 =?us-ascii?Q?E+SHT5p4DK1SnWXo7l2urK+oYQb1VD8VcOL5JOvCMbcAQt1nZ0tcJaDwWDXM?=
 =?us-ascii?Q?r9V6rDf43C2HgmkGwlgg/mEpOjuE7CyhGhAY1k84rnjExJo1ucw+tJ/V/RGg?=
 =?us-ascii?Q?rcDeg0Zcw0//t1sdq8oRVyi7d5XQODJCfbVnlPlbeSztlF2ER6UtX/77KhSb?=
 =?us-ascii?Q?MN7XWSVVmz75REJv9O1V4opOn2mzP5vaH1nYa0YpqlISIg9YpdGdH16P1J7u?=
 =?us-ascii?Q?hvKlKOlKgKm3stNF3Mhhl+PGVNOEKCp5SPY3DDZ6NucbtctaYXskzgG030eR?=
 =?us-ascii?Q?52AfgEK5XerOqy8Yiu2y84w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A99CD2CF0E8B5245A714523711DF4306@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EhRedK01JlhmwKWL5niVxq0lorC6Djs5s28JocUeEyf2p3iRfmlkAsopHRFi?=
 =?us-ascii?Q?ETAFCQ6dfMpy1W81BY3yOisU5at4EMu6EDvTVqUSsKGhEPyeUgOzT0DNFu1N?=
 =?us-ascii?Q?h2dyOBC5khqGMUsE/fK3bw8ncSwK4NHy9JsDk/Yzj+inb/XRulSbeF6R3Qlc?=
 =?us-ascii?Q?Kd7PHYAysRXS+RxCQur816Jz96ByQwTfd4ZlFZtBxUf14Ft2d4X2DJz/AsKp?=
 =?us-ascii?Q?v/XcB3eH5WhHyaB4I7yqKbtnBCgLPC+RaEZd6mp1sJ5wQ0NYZjmfPygzG3sH?=
 =?us-ascii?Q?aFgVPM9ieOnITtEUtNjy4ws7Ck9tWXQ1XX+HCnSyUB+FO4ePhvBYcbU0Vpw2?=
 =?us-ascii?Q?wrLGH7VPOAvBVd2RB56I/GkKSDFXVpfZ3j9QSAnRqHGNi6gP29EL8gDw31cX?=
 =?us-ascii?Q?2Jm9JqBpROscB6e5bshOjCey27AStMDdkwMVTml2+si/JYCb7x/oCVZF0Jdq?=
 =?us-ascii?Q?Wg0qWslF/QRjg8iW9VNImrDA4awAOlo4D4dzjU3r4SWsLQQwKJ2MRYzVVRsq?=
 =?us-ascii?Q?igghq5bjiOaXpwJmVfb2WwZr9fhx9GAApwyTr7hIO9n9Id1KfTPbiWxL212j?=
 =?us-ascii?Q?dkplULZEDNe9Np1WY1p15viFn6ppyll/B3owtVOs+FLehsqGbQEKutyfwcpC?=
 =?us-ascii?Q?4vWo1/TwZ0puLkf4y+jWG2Ust5PXXU3diHP5Q04yoJPMiHUMYrIVSJxeRgW9?=
 =?us-ascii?Q?WypztJwNQmm6nFfedd8IkmkHgj5HR48+DbBshYlVtAUB8XxplnkM3cUvIETL?=
 =?us-ascii?Q?OQWpYOEqPi+gGunlWMg4VOS9i/Qqfbwcv4z6hVbNVlWRLmHrsr5EfDyBIk7d?=
 =?us-ascii?Q?Qr6txgkchwaIlp0EJdBWOH73qO3KfWpu0Ql3FzftEusia15AElQFtlyJXakW?=
 =?us-ascii?Q?QYVSrX7QNrm+ch8F+v0PxBn2stICYgEITzl4AX52PTv3usXOiIqf9JgT13sC?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5997a862-0eeb-4b66-13ff-08daa742ca06
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 02:30:52.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6mxqHCWBYKXUrBeJIZHqbZtsPhDf02srj1CbjBvMeIToyWRNJf+hEz8AU4Fs/+JzlzvTNP97789uU0u8Z18h2Q0w4G5iq9qKzFGqAmOEdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8406
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 05, 2022 / 08:20, Keith Busch wrote:
> On Wed, Oct 05, 2022 at 07:00:30PM +0900, Tetsuo Handa wrote:
> > On 2022/10/05 17:31, Shinichiro Kawasaki wrote:
> > > @@ -5120,11 +5120,27 @@ EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
> > >  void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
> > >  {
> > >  	struct nvme_ns *ns;
> > > +	LIST_HEAD(splice);
> > > =20
> > > -	down_read(&ctrl->namespaces_rwsem);
> > > -	list_for_each_entry(ns, &ctrl->namespaces, list)
> > > +	/*
> > > +	 * blk_sync_queues() call in ctrl->snamespaces_rwsem critical secti=
on
> > > +	 * triggers deadlock warning by lockdep since cancel_work_sync() in
> > > +	 * blk_sync_queue() waits for nvme_timeout() work completion which =
may
> > > +	 * lock the ctrl->snamespaces_rwsem. To avoid the deadlock possibil=
ity,
> > > +	 * call blk_sync_queues() out of the critical section by moving the
> > > +         * ctrl->namespaces list elements to the stack list head tem=
porally.
> > > +	 */
> > > +
> > > +	down_write(&ctrl->namespaces_rwsem);
> > > +	list_splice_init(&ctrl->namespaces, &splice);
> > > +	up_write(&ctrl->namespaces_rwsem);
> >=20
> > Does this work?
> >=20
> > ctrl->namespaces being empty when calling blk_sync_queue() means that
> > e.g. nvme_start_freeze() cannot find namespaces to freeze, doesn't it?
>=20
> There can't be anything to timeout at this point. The controller is disab=
led
> prior to syncing the queues. Not only is there no IO for timeout work to
> operate on, the controller state is already disabled, so a subsequent fre=
eze
> would be skipped.

Thank you. So, this temporary list move approach should be ok.

> =20
> >   blk_mq_timeout_work(work) { // Is blocking __flush_work() from cancel=
_work_sync().
> >     blk_mq_queue_tag_busy_iter(blk_mq_check_expired) {
> >       bt_for_each(blk_mq_check_expired) =3D=3D blk_mq_check_expired() {
> >         blk_mq_rq_timed_out() {
> >           req->q->mq_ops->timeout(req) =3D=3D nvme_timeout(req) {
> >             nvme_dev_disable() {
> >               mutex_lock(&dev->shutdown_lock); // Holds dev->shutdown_l=
ock
> >               nvme_start_freeze(&dev->ctrl) {
> >                 down_read(&ctrl->namespaces_rwsem); // Holds ctrl->name=
spaces_rwsem which might block
> >                 //blk_freeze_queue_start(ns->queue); // <=3D Never be c=
alled because ctrl->namespaces is empty.
> >                 up_read(&ctrl->namespaces_rwsem);
> >               }
> >               mutex_unlock(&dev->shutdown_lock);
> >             }
> >           }
> >         }
> >       }
> >     }
> >   }
> >=20
> > Are you sure that down_read(&ctrl->namespaces_rwsem) users won't run
> > when ctrl->namespaces is temporarily made empty? (And if you are sure
> > that down_read(&ctrl->namespaces_rwsem) users won't run when
> > ctrl->namespaces is temporarily made empty, why ctrl->namespaces_rwsem
> > needs to be a rw-sem rather than a plain mutex or spinlock ?)
>=20
> We iterate the list in some target fast paths, so we don't want this to b=
e an
> exclusive section for readers.
> =20
> > > +	list_for_each_entry(ns, &splice, list)
> > >  		blk_sync_queue(ns->queue);
> > > -	up_read(&ctrl->namespaces_rwsem);
> > > +
> > > +	down_write(&ctrl->namespaces_rwsem);
> > > +	list_splice(&splice, &ctrl->namespaces);
> > > +	up_write(&ctrl->namespaces_rwsem);
> > >  }
> > >  EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
> >=20
> > I don't know about dependency chain, but you might be able to add
> > "struct nvme_ctrl"->sync_io_queue_mutex which is held for serializing
> > nvme_sync_io_queues() and down_write(&ctrl->namespaces_rwsem) users?
> >=20
> > If we can guarantee that ctrl->namespaces_rwsem =3D> ctrl->sync_io_queu=
e_mutex
> > is impossible, nvme_sync_io_queues() can use ctrl->sync_io_queue_mutex
> > rather than ctrl->namespaces_rwsem, and down_write(&ctrl->namespaces_rw=
sem)/
> > up_write(&ctrl->namespaces_rwsem) users are replaced with
> >   mutex_lock(&ctrl->sync_io_queue_mutex);
> >   down_write(&ctrl->namespaces_rwsem);
> > and
> >   up_write(&ctrl->namespaces_rwsem);
> >   mutex_unlock(&ctrl->sync_io_queue_mutex);
> > sequences respectively.

Thanks for the idea (educational for me :). I read through code and did not=
 find
the dependency "ctrl->namespaces_rwsem =3D> ctrl->sync_io_queue_mutex". I a=
lso did
a quick implementation and observed the lockdep splat disappears. So, your =
idea
looks working. This approach needs slight additional memory, then I'm not s=
o
sure if this is the best way. The list move fix still looks good enough for=
 me.

I would like to wait for some more comments. Or, I can post a formal patch =
for
wider review.

--=20
Shin'ichiro Kawasaki=
