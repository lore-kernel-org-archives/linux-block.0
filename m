Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC748C77B7F
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 02:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjERCB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 22:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjERCB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 22:01:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB22D76
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 19:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684375281; x=1715911281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ofsX0mc8uzTTbNDRBB1ip66KMh+DTRgpjWVqwOOR/Gc=;
  b=S/gweIw/+Yg+Yz2Nc7gEUJ5l1vx5tzaZ11uVYpT8fg8JGG99baajExRS
   36mE2q/5KZ94R+NbNZVwczw0WR5ghrm5NGD+u+23Fov6AvyHif4tBaOj8
   yLP8Nh5LUXDU5ZKVMxrma1dnzvAnpgHZ93VfqpdjQ90mkU7lf2Aw/vfQd
   8qEYcFjRSaPM30ve77vHs23kdIB3tDise4DSp0bpSVnCJILgtF3ONt3NM
   P1LT+Wn6y+Dy0LRll4/MGSdZS4dIJ56l66f5/VFSk2c6Rct4ym+5nOX1l
   gdy3uIFek1Hl6dY3FwIw0gARfofRchfs7VIgel9Kfc+lT0pCvpl7dAG3O
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,283,1677513600"; 
   d="scan'208";a="335507680"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2023 10:01:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+cSaNwSBpNwQihTjAG+foUJCoLewxpquiPL2aGFRSJIIocaPILUFLrysbiHu8GjxqcE9aNrOVn/naZSJTDEypqeVfmTR7cMoslFYUAvvUefpnfm5iM1e09+kol0ZIjgYnQgqwmCJKG86Hxu71Tv+9zvJPlCgYwFd+xO4oTtepvf5rDhIROhuY5pYVmlG6jS/xha5w9lAR/uuQ15ZohjajJhvtySDzwvUwioC2j21iubizWmW/ow27u561l4q9GsjanhPjFJq6QTLYWi/RZX81uF9UxFcPA2sptmfdVktfp6Ipn7uN+clABwTrDgvCI7zcNuaHRW645JVA9FFoD0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofsX0mc8uzTTbNDRBB1ip66KMh+DTRgpjWVqwOOR/Gc=;
 b=LZTKxoQms6zaAeKQ1MCabLEgjsfT0oPJmsjtYfzuLV2hOp654hEgWVxNe2i80kBOCiDi1SCMDF3PYsKJJpPAF46BrQdiAaWFPHD8KjqLHKe3buDJzCxGxdvF8IRQU1NHpSkQ4QAzRPLJNHqbbStSBrCZCYqyApccb+FMrvBRc/U2u/OWFmpmg8lSRz7dQsqydpp/1ieuJaafFo9Bpvw/cXq2RRZe2hMxoYZDV3erxq/xEKQNXGiiujbmljqP34Bi4YrnBYz306o+5D1GRqth5d1fN1OFPH44IX3VXuM8TqDjtR9KxMaGFHMfdfhevYX3BepdNtNuDgBER+QU1Cv4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofsX0mc8uzTTbNDRBB1ip66KMh+DTRgpjWVqwOOR/Gc=;
 b=jzozHhgQUlt4M9IYox15wkMJ+8SFi57ko4DJHz5ExkI7mp0xw4QS4AX6xCRLgYmMPSp0eoZl9oVeXw0SdEFS72Vg+LunUDoVFHXTJ4dPj6YAxkNksJxDBN6IDdrYZYnD47mmvr/TYVNKpl1/8aEGaBwebubaVte5MrAGqyAd2kQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7573.namprd04.prod.outlook.com (2603:10b6:510:51::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 02:01:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 02:01:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH] ublk: fix AB-BA lockdep warning
Thread-Topic: [PATCH] ublk: fix AB-BA lockdep warning
Thread-Index: AQHZiMRMCkBP2d2xk0erqUiZ55xRO69fR7kA
Date:   Thu, 18 May 2023 02:01:17 +0000
Message-ID: <a57cn4zqgxm5hds2ekgg2y5jbfd4bgwoujimit7enm6eh5wo56@hftyn26mv3aq>
References: <20230517133408.210944-1-ming.lei@redhat.com>
In-Reply-To: <20230517133408.210944-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7573:EE_
x-ms-office365-filtering-correlation-id: 2c92dc97-602b-49af-f0e9-08db5743c466
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLUMo4mLrdZHgJynz6zu1z0eBVdgjnA2FxuffuHLp2sAj/CiJqwf+/sW5hTssfhEVQ+9aqQZgWVL+1tSunGlwi9OkzXnAxNIIloLRrtN2lcuy2vgkA9TxwqY7UXAr+xhTaZjtM3x0sjVRJUvUNJlJ0hWOotwXSphcLvMLdDEDtlmO/fPNBs05e7IE+prfwIv8Jqy/0AbesV9LHDY7rLWncy5ypqgHR6OWaRVrq0ek1p7abWKpjcatf8vAJl1smFKIrxr+kpPf0Tdkhuo+yqtmV09aF9qKM+tTn3UguqNoiAa62rewfSHbk8q/wnvEdT4ZGAGLLpNKV9e6TNEpNifWf+8T7F7hUl7ZSgTwY3DUIexsbOC0g6uxReX2HvELwIqUiCdTEqKwj5hWWWQHZtSNtLWy5xWemi46D6Q4wk/DbIQcA7s9dv2KWRMpIEO4cfVKCXHxPE217aqHNhslJbedNQVxE1Nl//Niu9r/et1tPhLIi/ja4TJCxYQNQG5m1BkpzqEZyRaBUzzugcPt3Kn4TVIGwBWGkxyIlyrd6fea351A7M/UYHKq4+h85n22qMc+2FmC22uD8+YeuFTwR+s4U+u5u27u6qwt1IJ5XqsDvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(26005)(6512007)(9686003)(6506007)(966005)(83380400001)(86362001)(38070700005)(33716001)(122000001)(38100700002)(82960400001)(186003)(6486002)(54906003)(44832011)(478600001)(4744005)(2906002)(316002)(6916009)(4326008)(8936002)(8676002)(41300700001)(5660300002)(91956017)(64756008)(66476007)(66446008)(76116006)(66946007)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E8YbZHA4i1em5/+DeVKKjzoIvpnKssMubLz4JMUtU/01MDf8hgKbw9DIuGzP?=
 =?us-ascii?Q?PoepfianqLcsAQqX9Yzn/DJIAj5nQjmElStRxm1CAL03Bml5GkI+kNedE0P2?=
 =?us-ascii?Q?AJPybYr0fc6AqXVSrMufPpVxaMHnDehkR96NTDl3tdbbzLoW7hQjFABGSTSb?=
 =?us-ascii?Q?d1AgssgbyaCH4nRV1NwFaPMgWw/9TXmRVtUByy/Eh7T1NNnNLUzhTVTdU794?=
 =?us-ascii?Q?7AR0HxO3iJUwtBn64IRBHW4PQNGYxK8WjEYJ5fgOTYpf+YKu/84hwnuD00Kg?=
 =?us-ascii?Q?SUl8vLLbz3qJ9D86kHC86bddAfwFLhkbcVYldIUs/TaeKYmUhSLlTDJaX6J8?=
 =?us-ascii?Q?LcvepE3injxlHk9WIRDYVpNihHt++m6yviBB9dHrLcBANnVInNWd38d+Y811?=
 =?us-ascii?Q?1DQfk2gWjqken4qSJZtKu7PbmFvuMPUM3KJNVvLSRQ9YJRAXMkhOooGQ7dMc?=
 =?us-ascii?Q?xSBM2GZrE0dGuoPGX5dzZjX/JpWw/MRpD7VzCN0KvFlYiCuj9IsZ3cyPJA7K?=
 =?us-ascii?Q?AXEviktmozWXi+qLhUpez7zAPyZs+OgFkrNBk2A2EN3xBrbkEhQblhkXxlHL?=
 =?us-ascii?Q?N68fcTblVaegEAJraEzIYHcihyEXmmA7uV3vfrkqgmbpzpwrXyTd5XAfJx45?=
 =?us-ascii?Q?ksRPp2pza0hMkJw75Lrbjk169QmxSLK64JZsdBzpRlNDW6Fd80JYl3Yk6DvV?=
 =?us-ascii?Q?hz1cqrMhH8CtoMIq4PF4bQzBniGG1Q+4d5XyESmV6Voa3UEqUC1GUJqudKwT?=
 =?us-ascii?Q?Gn3waNKoEcd9ue+jvEcJH39CoClxUvf5At/e8GW9R98UuRN6n3sbrQhPzAqt?=
 =?us-ascii?Q?1pRoghox+PI7EGY0rAprrhQ+EOtF/qx8HRAzKSf5DxWvER0A5TIj8/84AIhz?=
 =?us-ascii?Q?lkO9aXqU1DrAoxTayIIhK9NhVNY1ilD+LRm8cPmmdNkr5eBHakzlJIHNzxxW?=
 =?us-ascii?Q?7LHLNrecRpRKg40Vawx66pzAtKm713mKTBniImxtVY92Rwgb6TeZdLANR8Oo?=
 =?us-ascii?Q?d5ROYeV6z6H428ZOnsHbSxXNcJENZVw+oVesOG4xlOzVxH2meOv+QV+XBxgk?=
 =?us-ascii?Q?assuRNFhLn/OqsLb5qEukTb45xloB6C0LZfYJHj2XnLKuvQrbVaHjuQlZgJx?=
 =?us-ascii?Q?1a6PS++CZnqAZnc2aMpmThxYgPmJAAeE1ti49I15tWDcaG8cKR4JnBCY/lwl?=
 =?us-ascii?Q?ISxM6B5En4M7iPO47TYKVwOzpv9tqkQ9UCJEBJkfND/6ikNHgW/zv6joLRrK?=
 =?us-ascii?Q?yD0kTzoQnVqxN4MVgeBeUWPnsBnwcf4Dgd65nPqugpW2gE8Mb59whhnlw3s2?=
 =?us-ascii?Q?7O9JsbZLoRY+sWYGzaCSMQZvkqv6J1mBiBgFQrUEMyugEFWozr9Hx65C6No/?=
 =?us-ascii?Q?H3sx4TAHvyv4SiZ6fzfg3qfctOTjTjhNC4kLHZH1XGwGxPPYeMUB4NtorRAH?=
 =?us-ascii?Q?EcvcwzZGknGyyW3FL9miPWqOkxRh/E063vvjVEpk4XKP1Xk9Ji5i8Vfjejko?=
 =?us-ascii?Q?AulaOtrKVitTNRdgSOSdE1zx6M5gvdsTm0+M8dsh+PIimXIS6wp4W2LPjqJT?=
 =?us-ascii?Q?stvAq3gRQlS1XWZg1Ya+Fs53Uvop2E035GS3pj3ReADuaAtPtyDBElDvJdTu?=
 =?us-ascii?Q?TAfqzcD/y2gKjDUMUTa5sGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <738FA8EFA66BE847819D2B25A69FA185@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iAWRpU9ITK5/8hr8MpOL+buWr+/sFBzhIbL2ALdBZxRutKfQsLgQI5ileC21j5A2YRsmqEV2PuKpvl/0N3yykdXYo86ppy8BWJZzy53pt5KOJcrFWPc0l68q5YIeSJkKHQWy0jTlC7MYOxdtdzysLbofu+8jKon8qw/m0LAqnTkY7ShHw7VmY88pCLfP8TT71jol5l+U6lSilXyjWmdT0l/BCXdyZ0tEo+iSUbH7F2HVH5VWQm1WzH0YicnFOS8/S2Wc1pcc0oMefzExfrotSEPuTOJDA/ZABGH8rOmtFGgwY4lSumA3A3SHk06Oyen5ZmsB97inaMyrh+E6/u4QSNLcob/8irClhg6W+JjiOsjQbArW8b/kph7JxRl+mQwhKB1G7tDCpjOrZWOvp3f+geBRlsQkYlq0rn4yXL0MSaVyQyPUrUW8o7c1CuMASCBh2ft0uyx3ixiSP5OBkTPMu2hQUiUeloZ117Ggsf7b6Lhh1YmgEIUtSpWL2YvqmFyAtWhkujY0L/sCnmtS+NcBEtoGmQ1lZ/m770s+pAnNacanP5HNtg8HSSRRGqlVeohOMUvsqBTUnU2l87mMhUaQLp+lwBdblT21IOUjERdgsUY07CrVjxdfoko/EWU/QPblA+En8nGYAc5GUS0rqgfSLp1/wiSdRR0weN4Ql6IIVVtsZWcVeaXZUwVpqIzPt6uTf4adQLB8zsW9KrrdEKKuK3Wr9Uw0QhIPbSIUl0HWEB8tA4FG7fbN8JcixltiSG+Ss/tPh6dGUaIyZrmdN18JpoSsqUbUcTyTgi5DqX/fAT/EWIvrQk23HP2afPG1r8VL6W40PH4vcHSupYXnv2MEgqKU6xD7OIjxXfTnY+aliq7yJ5ouyrSIgbQmeSolI7Bf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c92dc97-602b-49af-f0e9-08db5743c466
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 02:01:17.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuSshFrZ0CUfs56AIS8KObVDKC/h6Auk+pbfGKe0ZYS5C3sCoP/hIlyca7fk4vZEeQd+LLbWmGaMl4BRPdKZ2EtOMH+mh/RA1mHVUlVOurs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7573
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 17, 2023 / 21:34, Ming Lei wrote:
> When handling UBLK_IO_FETCH_REQ, ctx->uring_lock is grabbed first, then
> ub->mutex is acquired.
>=20
> When handling UBLK_CMD_STOP_DEV or UBLK_CMD_DEL_DEV, ub->mutex is
> grabbed first, then calling io_uring_cmd_done() for canceling uring
> command, in which ctx->uring_lock may be required.
>=20
> Real deadlock only happens when all the above commands are issued from
> same uring context, and in reality different uring contexts are often use=
d
> for handing control command and IO command.
>=20
> Fix the issue by using io_uring_cmd_complete_in_task() to cancel command
> in ublk_cancel_dev(ublk_cancel_queue).
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/becol2g7sawl4rsjq2dztsbc7mqyp=
fqko6wzsyoyazqydoasml@rcxarzwidrhk
> Cc: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Using Ziyang's new blktests test cases, I confirmed this patch avoids the
failure I reported. Thanks.

Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
