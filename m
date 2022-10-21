Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCAC4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 07:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJUHxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJUHxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 03:53:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE1324A548
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666338818; x=1697874818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SeAtyxoTqgOdxhjRAyjtcy1nlXJPo4BVkWQUP4hOkRo=;
  b=iA4cndttDBrd7Ub0hyLgcGT4u0L4OfHPhbTr+20wzYOsUpKwEZjmrvix
   jg/kBEDM87cunp3tkNj1o9k5L4bRNzuyY9KVtrid4sJSlht+Ua0MwtocN
   gUmFN49YKQDL0MmRDn7dFCP+vvACGj/gbg/0xunGTDtZgfKcmvCaNX8q2
   yLBZ1mlz2+cAOQbJ+h/+EMl98fdcxCymqAZo2GbHRVo3ZSY4+iJXamomw
   iwWIsEbTBhRPownXRw2rk4Ln45buxwvbmSE9WUQbnLXjhtNUnft+uNiYp
   X2z/X0E1yLGco2Y9hKkQ6xZSeGTTRZ+3fm+Bt4FiEEBFRbqB0EVfzV/tS
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="318738930"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 15:53:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmktjKTT+AVeWuva/TgoDxFAARz70BPnrnbo3aqeVlwcNb/EUWqM8xbIUAmEVu1iaUN/lcz16USvc+Fc18n7ICmz/id6+2qml8p57Z3ZaM25n7v5DcHqe5ixtJIoRf0AXX0AQuJ11MgVN4BWdw2yoa4WyM+b6bIcqnnimXQQUoeAbe80a9SJ5sWh/BeDcplz5V90ry/k3w2cBOtp6/D+D8LBsKIlXIhNs9h9iu5pwnVgHCJ0AgW2lV/HG694GBDHn3sS1J9lxCjZm+xkmoDTTHT8hyfclU83XJQiOKIWvBGAgUTxE3dTpLG7bRP7SVCVaGvxGjrm2/5rMcKhQv3BRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeU6Su/FkXoFMOki0deC117prAMtIbFSsAJ0rikAp24=;
 b=n2UzTEy2ZTcbdQl0wuQWxxwU+/3yUyKKltvgfhA6eyNikaIZYFR/E9TBNYJwiKxFAU5VTs5ne0leSMxEjdXLCGUxo/S+09FFpe1UI/XoQpjO62zNW/2+E5G0CPBRbDJBgkYS2JEg+OdNgLS9mvyUcwkPZkoFkwwMG1qdvn4NWhquwbzGYaNtV9IulGwbRAT/28LLGPXh/mXQ9d2dAPhGXI/sVXzJEvLXnlVVrRXYEHSPS+ptlsIUPIZ/XkCk7tr772k+7WQ7M8OWTkQszEglFLG5MSebrVNg+KykE9R4GG/NzGsTXDr34Q4KXWHx0ws8dIlMl/L/nTtn9xn8krQQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeU6Su/FkXoFMOki0deC117prAMtIbFSsAJ0rikAp24=;
 b=vPx6Zw7xue8uZuZDfIKj+xerDqxVEvABAFGp3yg7VvoSkOsX/S5A/+sjMN7I5+xlqCDaXNHnBeh6e4F4U4B5hae8GYGD3hLJ+99T+p/5c2KL8PxTsUxULCCMujtPBMtQrPrMnGMg5JuW+h8UbiJLfrlx2FvAyqADVqbsr9jAfuU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.34; Fri, 21 Oct 2022 07:53:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 07:53:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/multipath-over-rdma: fix has_soft_rdma
 checking when mlx card as netdev
Thread-Topic: [PATCH blktests] common/multipath-over-rdma: fix has_soft_rdma
 checking when mlx card as netdev
Thread-Index: AQHY3ZaKVp103uDrzE+jwnCcY8bhFK4YiUAA
Date:   Fri, 21 Oct 2022 07:53:32 +0000
Message-ID: <20221021075332.5itihe3z267ater2@shindev>
References: <20221011172454.310389-1-yi.zhang@redhat.com>
In-Reply-To: <20221011172454.310389-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB4325:EE_
x-ms-office365-filtering-correlation-id: 6d420733-ff6f-4363-a8bc-08dab3395a06
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BIke/NuwD+7fTHmJgMhhpm1vPt4Nz77uuq/p2o6iwwsE55K3CBCdF8J2Z5dsAaueBuHxaosN4GhBd5yHRtoaJLOLu07LxaHX7kIGdEEqFo+CfCUIbkNXSAdE6kagsp0lGb0UWg7GqKfnaX2bci3XEOlKb2Urlgkh9nnLOVMJ26cSYSn+A+kaoyCQGuS1eTcuJOcGRwq83nC/BbQySirHY0pMxHXKq09m7J8qfX1d5L8ftyE7luUybawNL1nVxQRRAc0y31aGLDd4epkS36ulWV//pRwTBA/17lTt6lUtI5HsliCpp7LSUuiEBy12t+XYNbfi+uIuLdLbdzLZzkxhBD0U46jUL60eGPthHelD4iH0VhCdkRItIJ4sn04KyMp114cdTz8lMPkO9IS2ZlrHSoFod9h0gB907Ed6BitUnOrbsqfkj03n7A2L5OsEebWIO1q/XL4oPi4CEh3yICXsLpAasph2NjqD9toNurxikTbEEsOgoYWTudhIMpYmtaDbAkOUWrahElq8Kw8JK7klKcV1jwilk0hk3tiUHnWjpsKkQWFm6GPTEfFCjpFWXcQChbhP5zllcyXExFNBls8G7c7/LVEQt5iUuoTVeUfimHYrSahKc4ZgdLB60RdolO9c3BBGAoqEKPREA5phIEkp9VZeQUXhvHkalIofuh0ppzT3PoMOElqnih5PVUCMBsA72/nbCC/8eqFuWaee2jxLcGGvTb6S1gbQuKIHygUhAu9Tb9a97KgD0GGMVTimL8NrgwFu1a9hvyFPpALrwD6qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(478600001)(6486002)(66446008)(71200400001)(66946007)(66476007)(6506007)(4326008)(54906003)(91956017)(41300700001)(33716001)(64756008)(8676002)(122000001)(38070700005)(9686003)(6916009)(6512007)(26005)(38100700002)(83380400001)(66556008)(1076003)(82960400001)(76116006)(186003)(86362001)(44832011)(5660300002)(316002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBXz0PFEcAymuWz5u2T2nrxC5qmqiPXiyucgePGAzLupojnZxsPkIqwA2HeZ?=
 =?us-ascii?Q?eRCGWEanCDMCYhf43ip+srfkBqGLJWT+e1BbeTgrGkGEDRfl0U//L7XiWFZq?=
 =?us-ascii?Q?m2McTRPfrwoQTl/veLV584koDuSVSMdRIRxtDrvZkUMOBb/jWWT2fS3uC9an?=
 =?us-ascii?Q?xiQ1HqSbcQnzm+0lSZlCE9obJ2Uy8gHY+3SyGL3zTWc8BGdDvYR+Asoa7k8q?=
 =?us-ascii?Q?PrErpvjRMbdl64fdg/QrjG4C28Y7Ku5AnEf4i/TsZoL55pij2Pwg3114cjng?=
 =?us-ascii?Q?Q1391fKMs+ygxvtwjlF9DNoP/fAj3ZG6eXAVN9S1D4W1eJJCMFOOURXyZesb?=
 =?us-ascii?Q?fiAI9DWfPGZfGxXpOwZFaM18kDaMG9u7ktv3uTuG/zh8ZkBsulTHrL8egAdt?=
 =?us-ascii?Q?qEuO1qVIHdzheYref2Ul7CQGYTst3r38QPDQnCDJuoU1fiiszwoinUmUYLGT?=
 =?us-ascii?Q?yaP1EOk4KEUg8j4EJLYfO/yRoHbtTMWARkisHUet6eyaHqIkYnUpWkAh7yq/?=
 =?us-ascii?Q?1KMNI6OJzSXUzuRrFWSe+UJ6NAslaOym9/DMmyMk9Puxj/8812VEOdX9oeXN?=
 =?us-ascii?Q?Q+i6qdpME3EG9hS54Yv0UeoflkM95eWaGRUuYDFYpTOm4RM15rhfQ2k+A0Ux?=
 =?us-ascii?Q?PnH6+KgRQCAgCTcCdoB8UoLKWwiSWihaFlZLc2SYqqJNaF637X2Jx5Qhe27B?=
 =?us-ascii?Q?ir/+OJr/1myJ14A8e7rwe3mK2/KGJ5cR2fq6kLCSVhuCfUCq42/ZUUgU6e3w?=
 =?us-ascii?Q?U4MWM/JnfsvIjbJT8qCfX2iZOmKMd3H4GhpeS4GWlRtDThUhQDm4GfaQlxen?=
 =?us-ascii?Q?HWS4q4lK/gUFH0ogs2MkfvYQavp7DbIlHl9HH1hIDp84rRCDPUS4JqdXT2/t?=
 =?us-ascii?Q?0nFmeols/3gzXz1QGy/hX41Stq3BmS0FfPqx+T3ncUSaIE0JyYKZ0Nh9sQnf?=
 =?us-ascii?Q?e//4uH31iYJTcllmuCs3e/pfefm26dXgqN1v3c480FflNGSE4x0OXT50Gvw/?=
 =?us-ascii?Q?yi3aDtAqQr5Tm8NuJCB8wjBNdOyVGTDJ/1NY7mP+eSFKtVRkGazugd+jhT+l?=
 =?us-ascii?Q?HLCQ9eOA5JgazrkMht43ciT4ipy/+DPVUpQMtJOK8nWmdwVb+R1Lh2/M8RrJ?=
 =?us-ascii?Q?CXeAaffU6si0UKMG37wYdWnwqjsOgemj9Wjo/1t9A82I6Kb5oJuoLkRIqRwv?=
 =?us-ascii?Q?zu9v6rHdOs/LHe6Cb0Y81xd7zYd/QD/X1is8q4IPs2EpKwUKWa6ptSJLo7ym?=
 =?us-ascii?Q?11lac6klmAw/i2zLQPr5givZ/N+/dZKsVegE1sT5tEYo5g3Pw1W985Sr6J2L?=
 =?us-ascii?Q?8+bZRM6gfEibXt/XcHlMzqmO3bBVcmqsBmNKHd2cNwbx/5nZgQ/C4dj11eeL?=
 =?us-ascii?Q?w+9pdHcm0zK/citw0SisNZ/mKT9dwWPNzr6MRmP2ylXFLVD5Nq3weDdChqBF?=
 =?us-ascii?Q?gfpALEzrpkx19+TMaWagRRpAJqgYSru9UevsRb9mDzOdonbDlXfiZFOVG2VN?=
 =?us-ascii?Q?vR1o/ZMDMZJjInYJXLIulHyvuP3WPX3SLrEpYM//fX4BmPFVbREPwNMum6eH?=
 =?us-ascii?Q?UOjFBuq7yYddHmWxOBw7FJCIlTj4Ha4kZiEjHyDY6ekOULcTkMRxsQLewgu0?=
 =?us-ascii?Q?VYJ71Ut6mlHQ2npHZiqlVRY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD415568F9E31744A4943A382B27CA50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d420733-ff6f-4363-a8bc-08dab3395a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:53:33.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxxMN95yeqR7DhAhSG4a3DA+Pb1wb07l6fnUobq+ZCojgyzoiTV16zEibNMTnCrZ7pRG7m7tRqs15yNGKPGb0zibOOneeU7clODPJXFl8p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 12, 2022 / 01:24, Yi Zhang wrote:
> The mlx dev will be ignored in has_soft_rdma when it was used as netdev,
> add more filter keywords.
>=20
> link mlx5_0/1 state ACTIVE physical_state LINK_UP netdev enp33s0f0np0
> link mlx5_1/1 state DOWN physical_state DISABLED netdev enp33s0f1np1
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/multipath-over-rdma | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index fb820d6..6b9629a 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -387,7 +387,7 @@ all_primary_gids() {
>  # Check whether or not an rdma_rxe or siw instance has been associated w=
ith
>  # network interface $1.
>  has_soft_rdma() {
> -	rdma link | grep -q " netdev $1[[:blank:]]*\$"
> +	rdma link | grep -q "link $1.*netdev $1[[:blank:]]*\$"
>  }

Question, what value do you expect in $1 here for mlx devices?

To match with the rdma link command output below, 1st $1 should be "mlx5",
and 2nd $1 should be "enp33s0f0np0", but $1 can not be both. ??

  link mlx5_0/1 state ACTIVE physical_state LINK_UP netdev enp33s0f0np0

--=20
Shin'ichiro Kawasaki=
