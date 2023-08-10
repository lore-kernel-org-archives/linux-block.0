Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D1C001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 12:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjHJMvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjHJMvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 08:51:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844002691
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691671909; x=1723207909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEUL71EwkiLOp3n2XKlgpwzZHK/AfiRUPk1Fmfo7GBo=;
  b=Q4AmRa1ihh8VpKKDiEIHkU5wLMuPdq8LXdeFYFCCYJ31BLxBx5Di+Azm
   Ry09iFP+kwHCKEpgQRvD4jKBoe8HcRlErtU2+q7fNfvdOW2IRmFjhu67Q
   hQyM/ZqWxHgKs3ljJmeNfPVOApYS9zTBcrbjnSexyHKJdXKCgfbdVy3sC
   FfimMyTsE+gq5czMi8oIpwltNwX0La2rgJxKRrRFa/LucJ289oWTqA1h2
   g7Yu/LygydDdPkX3k0SyYIRIs4A3Q3/ZUsWjzHgx/8Qhrew1ecEXg+Ad3
   Y+YJqxZGGPbmxxK23ch2jaPS3LogwhzDs/9zUmADt+CEm97CVCIfFLyR3
   g==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="345788159"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 20:51:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imljGWUEvmGM2oGYVabxW8zT8mbOpPveyma96ahrfqDNJcavI8ufiBdd+DmGAJxJsu5eokO1BJCKvoEM5rvZgrUKc35yPvJ/7ueQvLgWrnzhaBgatqzarbY5HL2CXyQSHrZvVfgDx/x3DAeaVa3hOt0iDo5nmTnpfUftfcz4OOFaO3eQ2s2MmaIxHNCJ5kwcUiMl3s8DBVBbnL4JgZ9q/lodybz18+kgt1uvk6PjYv6pdLAqIBsIdTufMZR9ZvHla6R31bRt+v1CnHEOH+KGOASL0TGVnpUqK9kXNqaOPhj0sjRuXjf/t0JQctGrf5jHur0QGYtUcZrg2ebA9Ji0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytPLA+duTuz6eBhAlDoXi7q2y+SboGkt2Bbxt5PKxPg=;
 b=Xqe/o3q2RK0nwrp13WaSouoaKbWcDIdkD9FCHfisf+7sLk2fa4dOLrZuyTFQOipiE79A9jiGhshwlOaEMSB6poYVOPyMXBkKgICtmksvg3kmEpbzJdzGxRBR8kklKD1CyapDVMUhhWMgIu82hXYjDjYQBeWsFsOS+4E/Q6o9yOgqPUDlnYgW99rq8ZzJA4ikH7oO21IUay/egRJTxd8Ecv2sMEoYFdOWf49UiQBETpC8GQF73P3TcnRvLdA04dYtZtNAtdLlOjmS0boxE+lZFeauihclG7ysqZ0a9X+RFKeAHcOeoCYtZg5JPXztWs4snyalA9FB6q/UWcCD0OTCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytPLA+duTuz6eBhAlDoXi7q2y+SboGkt2Bbxt5PKxPg=;
 b=saMe6hg4rAEmITVYAxGEz04nzeC8kpQvxruyNI38LnDWUhl0Nu1ZIrr7geNs+rq0OnEU6EVExhORW2DvBibnNwVQCe5iB1e2xf2uGuFO26eZGlHhQMyabKSNNbA0finRHkGtR7uZpCGZ72hv0I+WP+LQ4WmvojIqxkTaSArTYiI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8604.namprd04.prod.outlook.com (2603:10b6:806:2e5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.41; Thu, 10 Aug 2023 12:51:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:51:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Daniel Wagner <dwagner@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Thread-Topic: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Thread-Index: AQHZydThaLSaElB1oUmqvdDBPohT9a/iL3yAgAB9eICAAJaLAIAAEZeAgAAqFQA=
Date:   Thu, 10 Aug 2023 12:51:45 +0000
Message-ID: <git5brh4yq7ij65oskwd7m4pwnhfcqbvwdn7pzsbrmzv3wgsk4@xvb43h5dbo4g>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
 <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
 <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com>
In-Reply-To: <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8604:EE_
x-ms-office365-filtering-correlation-id: cc07b3b9-84d6-4a01-713a-08db99a08e0a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ktpDC+ODUlmLu0/CQsjtmGnT7h5CrwVud/5DZO8zYXdHuvQHi7ZI/oagGCevINCO9yZI3ulPhwwcmDjX14uOlQdOTR10XgRb65ypJhHfhc0yWX069/gLDN02qcjU2EYe9rDj7z5hK9aQ9fMHzOK4BMTSZDbA/Ij3WpVMkguVG0hWJ48CwiHR4oF6Plds4NLzvLmhkAepITtTCF61Bgpo6Px6beD0Lh+haRFoRu/DashmMXeYHHA2Z4yPNgQlZBJVJRpPVyv4JP/ePu27cgUgPmMnamiXX9oIteJFeYUBmMnqxqk2kJgd9s+Z6ov3c5QeI+a2YRzOtjnno8EFJTgjpOld2oggVkOc/4uYdtfwNHzGCzxSA5Rv9pNerw57Z8Zmzwcjp2hY34TgGvCgRWF7RrFmxBAMXzp7t+xr5wEgMj5R9ChNauMezyudgaTwnFa7vjV65Jk3BvjG5aT7PdXfbMn8C9nc4SJarA51KdSxkZ0zbframx3LqISRYkly2jLJo4QUTyJ7yyNmEIU9gHDdPn7W0oMd+vYOmSr1jYbGypfMpCtZE9pA8JUHqmSu5hDSmUuJ/k3/fb5XoTZvo+d8Rpwqv8LJ4tRL8m1KEt9GzTO6QsF+x76jN/eFEhsWn67e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(1800799006)(186006)(54906003)(5660300002)(38070700005)(8936002)(83380400001)(44832011)(2906002)(86362001)(8676002)(66556008)(64756008)(66446008)(41300700001)(316002)(6506007)(66946007)(6512007)(76116006)(4326008)(91956017)(33716001)(26005)(9686003)(478600001)(66476007)(82960400001)(6916009)(122000001)(38100700002)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sjElkRCHXFqstvV80o+1bBhM0n5sJenu4nUbvUXVR0uE6I8Ush4551IQmJ1F?=
 =?us-ascii?Q?girZDlzGqtvkIhlEnuUw1JxO0QUm+S65NUq2EfKmkFqi8LgxJpkAF44NZ/hn?=
 =?us-ascii?Q?ryRIeu9Z3gW+WurwBqMg91n6SCD13mNkdolC88RaI16WJ0ES+txCd0EbDRbW?=
 =?us-ascii?Q?P+VSLNxoPYTjCcj/NdkwFcVyJ67yJAD/yydsNeQN56ZWol0C9uotlBoFKYGs?=
 =?us-ascii?Q?VgOTNGwZ7HRLwIM2BHHYcnc5JwEw/hIak5NRdM4H+O6IY6/bJQ46ciAMQPdz?=
 =?us-ascii?Q?HoXWN4RlvtsGkIGL+1cT9V0deRL4afvAZjrIXKDfQDfjw/ibOhMqQuvughec?=
 =?us-ascii?Q?PYyi3Lv6HE270bB2G2brNKFPCChvThIP8lKzrNr1lWIvEc6F2kDO1X/Il5tk?=
 =?us-ascii?Q?BEx89wLvJiasVEfbjpo6NcHb7hHiNOxHcR23PfMjBvhYhTuGJSAvEjgXQQv5?=
 =?us-ascii?Q?YuFDCVFCkA5+QoW2wgP8Zvs1p+qCOvv5zEHCiFfuZ9b5ez/gus4B9mprd+jX?=
 =?us-ascii?Q?9j8xDMRiKj0OgoRdWxlD0kdsf2EEVjI+JCCTGLM7e0WZI/79cUWYIFenGtzv?=
 =?us-ascii?Q?YkIQQqKbni6kJxiXc+C/nZPNRnjXnWNfC1g8wP5+KnimKPuR5USDFfYsY82O?=
 =?us-ascii?Q?TMmSPqiTO1hsYk1rSYCN1xg00W+H2Bymu/35ZMpPv+fRzWZl/1lsjqgGmHxY?=
 =?us-ascii?Q?83OORSckT03nc5UwBsm0qKxal8MB88KcQHoKESesIiDuP6/71M7Hi1a2wwLJ?=
 =?us-ascii?Q?fCv7IRVgqlcK6tHn2atM2oq4rzKtWUaokbFL3l0D+JVZnsLCJFurMTa+Od9X?=
 =?us-ascii?Q?maAwSQVzuyCx5GJTr9I19NEWATdAKr9zhvN7UQdgbjl3AGizmXVf1z5at2tS?=
 =?us-ascii?Q?YA87vx5gVpGwEZtMbbswmdQB+S4+XRTWi85pas1J8v2RR3oIawja+HUvIMEi?=
 =?us-ascii?Q?YmQqkYVr8K7tkrsgyUjFM+xpJfmr64GL6yd7MA1rK+P8KDIRrG27m27uNypx?=
 =?us-ascii?Q?cOHcUy/zfWdt2D9SOIDLVhyA4jjUrtdD/qIwJf/hemcTW5YRzb1ZzjSA6Vhs?=
 =?us-ascii?Q?xoJv3sYGkplIlO4Wig1/BW+nj95iapn51STbT+2r8kZ/fmy+tfnKzi3IFDp1?=
 =?us-ascii?Q?J3yEuWbVm6XyTb1gdYG3l9ExkTpsgKa9eqcxjGbE8HFiwh4xHOimok9iNhzY?=
 =?us-ascii?Q?vnMzczp8FGp3Y3Mh2lB7bqPUb34rl4RKmnmJnqgFGRZUm29Ig+bpykX6TaqV?=
 =?us-ascii?Q?kn3OpIY6UGHcCc0ikbS5EOJxfJLssime2cGKv3Ltr3YlgX+mY1dexByFlgVL?=
 =?us-ascii?Q?lg+5nxm6O2cSbPB4+PRqNJNv/c+4jFY5+nD9kfsUFeaQdMvdsZWdNx2Om0H+?=
 =?us-ascii?Q?MaC3mZzNugn+cJjNtyUli4K9ihZ8OGwQKcJPVzzFQ5kK/U0+gKwrHmIMaS9y?=
 =?us-ascii?Q?OyLX6nk72g2wOtAwE80kmYcWs7eCK/W8Gh0J+xFnwuwZ9nJUI2FVkgoS1OtU?=
 =?us-ascii?Q?DCW/8X72VijarSMEaEcx2+OePC0sm+c9DDKqKec0HGb2i1ooE5WuUqvuWdRK?=
 =?us-ascii?Q?aTMH3y1i4t2E7cSEAEBGH3Vfm4jiUadlm/QW0Newh1TXzlDCazzdB3rlge1k?=
 =?us-ascii?Q?a1ROazDm/e/LZEcQ3W6S1/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B3470571AD32A48B2C7F394DB178049@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GayZJiOBbkYJqpR4A0LZTbiIcx+EG7YRbbug5Kgx14jKawpSRXXkCqFy/taNugJgP/ppKc1CF9U2+Ax7pQiq62Wm61o65ZlcPR46JbPSkoCV5YGiW22UiC6nNYicGphpR4hr3stjAvgu24ikNpuxItddX6NPtlz1Gmz+hX76iRm+jhEGSiUeAuv1v4uV/R38B3u+HyqAWAmIMakMKLH+BYRa1GG291Y78fEapm1RuhRIRQ0g1BRUeXsSUaR2WAZmboKU0AxQHJFeEBPHqBKwDIEoHWqG6v+XwEucMdUwwZ4oQu1xbe8lecmX8irtdRcyMAShQqf7E1KsOAb23i4wOtGBEPn/Qc07BEwHbXlvE4xlEi26GR1bs+VzZv/SW3n2gnI2qbROKsC/0daXDfljt0zpQpvTHgyQ98AjCqpPbsxlZqNZNva/gwqpF7tbyuNQ25R+N1XFyZvSlpgDksu3ILt6ihdygULywrxamPNyYH7QPUKW4YewuqzMLT11NrUeN33Y9kUVnU7RJ01nteBuHBr4SSp+eT6J9urPnZ+gd8lkg/22q7+YHPAbAKuMSQ0cDUF8V1NBp6c5BRQvhcsVpCndvr9PjeCTzqQ/L24c+Knw4VNWSsbXlxPxQzCaNiq9FqBsAGVCtxMdiqebC5Z9OeMh8OzO14lWdTfrg0kfZshUUB9O2nujlf0thjS0n0+vSZUv17CDZFgwFGfcFpmeLM41h1hr5u5biORVmQddCw1htAkoIpaPRUDyYHvn00qhaKDfsBgGHn48yh/OdamvjCv/oG+iMrTevm5ibjj7HBopx+BpfSWzrpgysP8lFDQpoMI6T38q3R1avyd6dKPGOMfbx27a91YyNZrLlKh90jIP5XxHt84zu718Td9lHJei
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc07b3b9-84d6-4a01-713a-08db99a08e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 12:51:45.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6YqgcNfAl+ic9WefabEaBvaPC0HLhs1sECXg4xN5+nLRR0oFcu8iNbVNR4N04Qs90xbuUDKQFa61QlGEHTBTgyxGqB60jh4tFWC+Fq1+iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8604
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 10, 2023 / 18:21, Yi Zhang wrote:
> Hi Daniel/Shinichiro
> Thanks for looking into this issue, I checked the 047 code, and we are
> missing _find_nvme_dev after the second connect, and the below change
> could fix this issue now.
>=20
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index 6a7599b..8c0a024 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -52,6 +52,8 @@ test() {
>                 --nr-write-queues 1 \
>                 --nr-poll-queues 1 || echo FAIL
>=20
> +       nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> +
>         _run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${ran=
d_io_size}"
>=20
>         _nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
>=20
>=20

Ah, I overlooked that the test case calls _nvme_connect_subsys twice. Good =
to
know that the above changes avoid the failure.

Having said that, the fix above does not look the best. As discussed in ano=
ther
e-mail, _find_nvme_dev() just does 1 second wait, and it actually does not =
check
readiness of the device. This needs fix. Also I think the check and wait sh=
ould
move from _find_nvme_dev()to _nvme_connect_subsys(). Could you try the patc=
h
below and see if it avoid the failure?

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4f3a994..d09e7b4 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -425,6 +425,7 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=3D""
 	local reconnect_delay=3D""
 	local ctrl_loss_tmo=3D""
+	local dev i
=20
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -529,6 +530,16 @@ _nvme_connect_subsys() {
 	fi
=20
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	dev=3D$(_find_nvme_dev "$subsysnqn")
+	for ((i =3D 0; i < 10; i++)); do
+		if [[ -b /dev/${dev}n1 &&
+			      -e /sys/block/${dev}n1/uuid &&
+			      -e /sys/block/${dev}n1/wwid ]]; then
+			return
+		fi
+		sleep .1
+	done
 }
=20
 _nvme_discover() {
@@ -739,13 +750,6 @@ _find_nvme_dev() {
 		subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn")"
 		if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
 			echo "$dev"
-			for ((i =3D 0; i < 10; i++)); do
-				if [[ -e /sys/block/$dev/uuid &&
-					-e /sys/block/$dev/wwid ]]; then
-					return
-				fi
-				sleep .1
-			done
 		fi
 	done
 }
