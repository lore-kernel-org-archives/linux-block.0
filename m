Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF13C4332F
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 11:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiL0Lk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 06:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiL0LkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 06:40:24 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A810C4
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672141219; x=1703677219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zn/ihQsfDfa1UMBK3L/KtZtW/zdy5aXa2U8WQ3yy3C8=;
  b=ZtYjLFWt4LBmYcvvSVHVnJuv4wlb29GACChYB4IUkoiuuDmEtL3XMNbA
   m7opI+D0X5RAgzS7GZImaTvcNE52U28xCEiAb0D2dJGhIXaEVca23IoqD
   o7O0Fpj3CpNkcRQ9tOzMDiy+wd9JcGrKBYcGZvOkiOKefA5uvSb8V8HKU
   ZoNH10tx1l6wZysgqEbgOnlr/R7GGqKjIeJEqfgOewUifxLpE71fb0WtI
   T9NxAxGrNZXFN46kcWBqyafPYivrRlTAXbv6QJvKol9dk1VypNT0LOLJh
   2yc6d/vVw09OCe+XgD+3JNu7eg0eYhlzRNQ+UMgnlSxE75dK0v7/gpIt3
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,278,1665417600"; 
   d="scan'208";a="217757966"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2022 19:40:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcCJMIesC1vc4xbY3Q2YhSigA1Oo6LeeGeupljyEtb4bfPqUHChZ55JEEXCrgX6WVJjuctQ51zHJg4ePJduWvDnTVsO+/TFQU7rUr+WTuuao4j4P/Z//IARCNPpXIE3dD9iW24EAR8sz/qFQg9R4oX2o+8xr16Ela5vMivmUUM3GQkxExByvXp2A1hmND2O9WVHHfZMaxMvaV8VzkpDls5vo3ZjWm6TH5q5UEXuyX+YDpZwKpCGAD1PxHvHTB89k0Tb6tYR60PGV0g2uxqPO14Ge0WVdWHJhWHXOFzVOQwIJxVDt7YxkMqcF037TxxlyZT3buUw5QPTFQabM+zQrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snlV34X/33zHxdFYjwqK8PUkKJRvDG8wcXcKQuXj7g8=;
 b=m9aTkmwllOMq/kfUHDdOY4XYTE3QZ+OK9owLeeUUt+cm/Lnb4KXiUyzQ9Ne7W/vGwE/oMuZ9ku0/U6jxHfFoV8qIlXcsk+uZp8BCYxtfNHiLIEP3Vma7+1f4S9kl/FkwFN18gh3YE6LO0qfuhM682MAsgr6aYpi+XujfaaXLoQU+7Gx42hJwPfbnA/pvLIEbzUf9UQzKkcArF4jBFB6w21PrgVRI44Ziv8RHMtNY36/AwMG8VzHkfdcJv2aMuFgcxC79Uzlbxr2A+AXvLQiC1onysXQH/qCXaJDx6kyzhNgUUFB4fG8iylx3ZDrJSJowiEbUrI9N2J7zjjh6wTKjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snlV34X/33zHxdFYjwqK8PUkKJRvDG8wcXcKQuXj7g8=;
 b=uJG9GPPhSAs8kRZZtOzs4X/+n0IzZK4YqPipn2PVLcEVx6UrE/LSGtUcvOtetyGHmJvbark3biYuh4qXBUQFZcVognRH9TohxVYigEgXb26j/F7gKCXMVnhrTZrPCQiKDNSy5wQMKdv1e7aSwtSlEjZ9VidPN0EqxG/rbNkw7FQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7754.namprd04.prod.outlook.com (2603:10b6:510:e5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Tue, 27 Dec 2022 11:40:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%8]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 11:40:13 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] blktests: replace module removal with patient
 module removal
Thread-Topic: [PATCH v3 1/2] blktests: replace module removal with patient
 module removal
Thread-Index: AQHZGef7EYv1AfZMTU+uWU7XfE1CUg==
Date:   Tue, 27 Dec 2022 11:40:13 +0000
Message-ID: <20221227114012.sdziqsz7thkyomaa@shindev>
References: <20221220235324.1445248-1-mcgrof@kernel.org>
 <20221220235324.1445248-2-mcgrof@kernel.org>
In-Reply-To: <20221220235324.1445248-2-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7754:EE_
x-ms-office365-filtering-correlation-id: 57eb5dd6-f41d-4015-9cdc-08dae7ff1e4a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4OGK5Mw6D3/3zJmAiaD2mrrZLbqeQi+Em8h963hT64PUMM2JXBrJZNtFuXJmGUZ9dbAAnJlP01TcVzhTeAfBkRRuyUW5vkgMT0bcvGql8AfbMc8P//msPbLSOraeEn1+6P3rUnUUZBFmiHnqsJ8qRpnoD4gb6W00qk4LBgbmOaXffJpO+96HCNZ4Ari2gRV+Xm63/7hrUjI56WcB51Hooin00ufsl5DJythGXxrvsZe6Q4PHiCku5+H8EVLdAIdvXMRusLQxTH2p/4UJ1N8nhSkqsRUzYEn0/xgNsyK6liAFBjqtqB56P67bFYt7+4OkYXILtndnw10ymuWZZ06tCUXu+YGlG2IZJC5iLKayZEOG4yVlgDAf85InA1lmwwMLhOmkBrYf1w3+GLN+ffyleLMuPiqxyuG4wN9fwOSVaX8MZLSYXB6qXW5ISELr5Ed8dGC5IB91Jrdlo6jj81QjMP+Nd9Uw2AH4mq3GEb7jzn8+K5BMcj6CxLh5/SjxO3DvyYgMZev6FGoLU8Sc0GrRqMkVTGUhj1apFszmFK3fAZOEOQQYSB5w/JHlu4XBRUtBDblty+HOCet0frPHzXZgBgEFfCrmZy+IG3GnoEQLzvHQMMsOQy5dSJbIPe/8ljc/1S6RdeWtsC84o2r07YZAf7kBvZO+JS20zIhhlq6QDgX3FCY8sDqrYg1T1oBfGtbH3CGMEmlrktyqCHTjqoBii/+vtnBLkIbMxMRhSnUZtYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(91956017)(9686003)(26005)(186003)(30864003)(5660300002)(44832011)(41300700001)(8936002)(66476007)(66556008)(66946007)(4326008)(8676002)(76116006)(66446008)(64756008)(6512007)(4001150100001)(2906002)(54906003)(6916009)(478600001)(71200400001)(966005)(6486002)(316002)(86362001)(1076003)(38070700005)(83380400001)(33716001)(6506007)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lU1kRJ4ZbI8TBk4hUURQmz3Tk5wCgzzpqTn9kJxTNaIEJfFjbDEtto1Jfwr+?=
 =?us-ascii?Q?xfYHzFpRzr8YC7fe322F4126GS8qy4pU1caxUycupVdIqSj3IxpOOB2bt9tp?=
 =?us-ascii?Q?c12xx1YTgM/x017u8XoKm20rerUqp3execLCMo1Xk838txRJ47YB/LxKG1DO?=
 =?us-ascii?Q?IwGlVTwOoT7yCQTx4EWpm/r+HxilylAf15yegTnKxKDBwg9QNfaPFXvL9zta?=
 =?us-ascii?Q?yO6o3bD+YyxcpGW/p2HcMetk0Dce+8uGKZc5NnjUIRIgBYGyqdzQBTZFYZqc?=
 =?us-ascii?Q?hVAuDWEy+mXDgluCpDOa4mv04KpJnQSB6QaMBL/llEzHBY9+IfpOnZI8LmOg?=
 =?us-ascii?Q?ilJc/LkpaCX1VMzSVXo42IT96xzYdnuvxqWCrnevvqQXZgog+yJp25Eo+QY/?=
 =?us-ascii?Q?/i9vOcPon/Vmy1399auSYDIBNpvq5NCwxa9rckx8rFxlaRT3nfS2bPNpeUja?=
 =?us-ascii?Q?p19nArlE8ehlbYCOBw8DWwEEOTm6Pu0+RTtN/TZVcT6/u81/+75HcfAHAYDl?=
 =?us-ascii?Q?H8YmFM8luiHuxvzu8G+Ik6uTDfgrUBK1x1zffRmPPkyU4GJANItTNSRcYwXz?=
 =?us-ascii?Q?zPg56Q4xYaS1EIU+Qen9hJejYAy7AP3Bd84bosYZh4nsRx1H9Lhj8F1MH1qb?=
 =?us-ascii?Q?fguhaxYN6skM4TaerSf34fRiYKiBL1a8xLSojRXKwy9WL+rwWDHRab0C3N4x?=
 =?us-ascii?Q?8t0sf2WsGKctJe0X/3+hw+zVbjOACOUPoA8sHxT+CamnyMRGOvrcXmZT39il?=
 =?us-ascii?Q?Z8JdqAZTzMuUmF+c8DezP4Mhey8Ii3FabdDFJrCwvG/U+Sr4xQeBY0pX6wiB?=
 =?us-ascii?Q?6Zt2f2BFk2MCom6yB8AmSwMvk1I5OVmbKnvzSaeUbFkJgYARqmZkHyjco4KJ?=
 =?us-ascii?Q?hpSyV74OcvIpNe6KBgmT65nAk1EX28JcvqvpQRpyJeXqzEK672Nnqm+1IJUe?=
 =?us-ascii?Q?cL5bS/9UmPHedLowtekMGIw3xo9lCETzFffc61JQy5B/XyP2+nrowFCDH5iR?=
 =?us-ascii?Q?usRiwKbi/FGZ08XiFx5cwhEwkQ60nK/8n0f6GJ15UOnc+nR/tRgHBmoxtbYA?=
 =?us-ascii?Q?pv54EVy7mtbgWpiJVbYP6W2SBbH4HYfarfIojNrz+fkWg52S/p+HbMDxpnrc?=
 =?us-ascii?Q?V+hRws+YNUAKMp45OPxG3aG1orvluTfxDU5B6o0fWLR/D++2BHx+VHq5Bs+M?=
 =?us-ascii?Q?GQ6+ZlQugsdsJuUIW43107EBowHlY8ffDGlxTBqbuz8mBMVSD3yoL34/zQ/Z?=
 =?us-ascii?Q?xxZJZL3aAT3Cb2GGQE8J8quDYffQ6EUXY7TzKO9MCt3a20INff5fVIuN8bXM?=
 =?us-ascii?Q?ma+pvQLIi3MrRCf3qwUNb4nCpSJgHd547OwWJxKC0vhJi7i30Nkrdu6Jm5z8?=
 =?us-ascii?Q?k0U1yag6t6MpF8cEUajrd+FuB/KXOQ7dxXiU1IwUqD/BMDAg0D9KGUxkGldm?=
 =?us-ascii?Q?Ag7rPuzPh1b7iKECxE5d/Cp5+ywWJWsnHgK+ELxYj6SrDe0442VHhVOkVAXq?=
 =?us-ascii?Q?JIyKrDz3PT9K7sO9ULQi/cwiZtFYi+SEMUdEc4UFi8XfL8tc+JtM4h0Q9ire?=
 =?us-ascii?Q?YeQfsNwAQIVZJCCMN6DvUNQ+Z89uxTDwt5FEVnn/sPbEWNUNVFsZo+2R0M7n?=
 =?us-ascii?Q?Am4z77+j854U63Vq8sPCz5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1602A6213917E64FA6D2989AB92F7243@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eb5dd6-f41d-4015-9cdc-08dae7ff1e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 11:40:13.6604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esvTH3+Qj5r5yCtXV65Yned+y59hw8rLxq4tMKmrlaVquTJe0Kd3aaKL8PXnQGQpBT0gvfQuivJeXl5iRyt7EdlDjwL4p70ZG3eLk8ALYCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7754
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Luis, I also observed module removal trouble. So it sounds good to ha=
ve
the patient module removal feature in blktests. Please find my comments in =
line.

On Dec 20, 2022 / 15:53, Luis Chamberlain wrote:
> A long time ago, in a galaxy far, far away...
>=20
> I ran into some odd scsi_debug false positives with fstests. This
> prompted me to look into them given these false positives prevents
> me from moving forward with establishing a test baseline with high
> number of cycles. That is, this stupid issue was prevening creating
> high confidence in testing.
>=20
> I reported it [0] and exchanged some ideas with Doug. However, in
> the end, despite efforts to help things with scsi_debug there were
> still issues lingering which seemed to defy our expectations upstream.
> One of the last hanging fruit issues is and always has been that
> userspace expectations for proper module removal has been broken,
> so in the end I have demonstrated this is a generic issue [1].
>=20
> Long ago a WAIT option for module removal was added... that was then
> removed as it was deemed not needed as folks couldn't figure out when
> these races happened. The races are actually pretty easy to trigger, it
> was just never properly documented. A simpe blkdev_open() will easily
> bump a module refcnt, and these days many thing scan do that sort of
> thing.
>=20
> The proper solution is to implement then a patient module removal
> on kmod and that has been merged now as modprobe --wait MSEC option.
> We need a work around to open code a similar solution for users of
> old versions of kmod. An open coded solution for fstests exists
> there for over a year now. This now provides the respective blktests
> implementation.
>=20
> I've tested blktests with this on kdevops without finding any
> regressions in testing. srp tests were run with and without
> use_siw=3D1.
>=20
> The results are actually *part* of kdevops now under the repository
> itself carrying only failures [2]. Linux next tag next-20221207 was
> used.
>=20
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D212337
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D214015
> [2] https://github.com/linux-kdevops/kdevops/blob/master/workflows/blktes=
ts/results/mcgrof/libvirt-qemu/20221220/6.1.0-rc8-next-20221207.xz
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  common/multipath-over-rdma |  11 +--
>  common/null_blk            |   9 ++-
>  common/rc                  | 134 +++++++++++++++++++++++++++++++++++++
>  common/scsi_debug          |   9 +--
>  tests/nvme/rc              |   8 +--
>  tests/nvmeof-mp/rc         |  15 +++--
>  tests/srp/rc               |   4 +-
>  7 files changed, 160 insertions(+), 30 deletions(-)
>=20
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index fb820d6f4e42..ea7b233486ee 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -4,6 +4,7 @@
>  #
>  # Functions and global variables used by both the srp and nvmeof-mp test=
s.
> =20
> +. common/rc
>  . common/shellcheck
>  . common/null_blk
> =20
> @@ -428,14 +429,8 @@ stop_soft_rdma() {
>  		      echo "$i ..."
>  		      rdma link del "${i}" || echo "Failed to remove ${i}"
>  		done
> -	if ! _unload_module rdma_rxe 10; then
> -		echo "Unloading rdma_rxe failed"
> -		return 1
> -	fi
> -	if ! _unload_module siw 10; then
> -		echo "Unloading siw failed"
> -		return 1
> -	fi
> +	_patient_rmmod rdma_rxe || return 1
> +	_patient_rmmod siw  || return 1
>  	} >>"$FULL"
>  }
> =20
> diff --git a/common/null_blk b/common/null_blk
> index 52eb48659d8d..cee72d73b688 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -5,6 +5,7 @@
>  # null_blk helper functions.
> =20
>  . common/shellcheck
> +. common/rc
> =20
>  _have_null_blk() {
>  	_have_driver null_blk
> @@ -23,10 +24,8 @@ _init_null_blk() {
>  	local zoned=3D""
>  	if (( RUN_FOR_ZONED )); then zoned=3D"zoned=3D1"; fi
> =20
> -	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
> -		SKIP_REASONS+=3D("requires modular null_blk")
> -		return 1
> -	fi
> +	_patient_rmmod null_blk || return 1
> +	modprobe null_blk "$@" "${zoned}" || return 1

When null_blk is built-in, the test cases which requires loadable null_blk
module should be skipped. However, the hunk above affects it. The test case=
s
are not skipped and fails. When modprobe -r is replaced with _patient_rmmod=
, we
should keep the logic for SKIP_REASONS.

> =20
>  	udevadm settle
>  	return 0
> @@ -58,5 +57,5 @@ _configure_null_blk() {
>  _exit_null_blk() {
>  	_remove_null_blk_devices
>  	udevadm settle
> -	modprobe -r -q null_blk
> +	_patient_rmmod null_blk
>  }
> diff --git a/common/rc b/common/rc
> index ef23ebee7704..b17fcbf70c6d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -409,3 +409,137 @@ _have_writeable_kmsg() {
>  	fi
>  	return 0
>  }
> +
> +_has_modprobe_patient()
> +{
> +	modprobe --help >& /dev/null || return 1
> +	modprobe --help | grep -q "\-\-wait" || return 1
> +	return 0
> +}
> +
> +MODPROBE_REMOVE_PATIENT=3D""
> +if ! _has_modprobe_patient; then
> +	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> +		# We will open code our own implementation of patient module
> +		# remover in blktests. Use a 50 second default.
> +		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS=3D"50"

Do you think the parameter MODPROBE_PATIENT_RM_TIMEOUT_SECONDS is useful fo=
r
wide blktests users? I guess the default constant 50 may be good enough for=
 most
of the users. If this is the case, we don't need this configuration paramet=
er
and the constant 50 can be defined in _patient_rmmod. In case it is good fo=
r
wide users, it's the better to describe it in Documentation/running-tests.m=
d.

> +	fi
> +else
> +	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=3D""
> +	if [[ -n "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> +		MODPROBE_PATIENT_RM_TIMEOUT_MS=3D"$((MODPROBE_PATIENT_RM_TIMEOUT_SECON=
DS * 1000))"
> +		MODPROBE_RM_PATIENT_TIMEOUT_ARGS=3D"--wait $MODPROBE_PATIENT_RM_TIMEOU=
T_MS"
> +	else
> +		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
> +		# with environments without support for modprobe --wait, but we
> +		# only really need it exported right now for environments which
> +		# don't have support for modprobe --wait to implement our own
> +		# patient module removal support within blktests.
> +		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS=3D"50"
> +		MODPROBE_PATIENT_RM_TIMEOUT_MS=3D"$((MODPROBE_PATIENT_RM_TIMEOUT_SECON=
DS * 1000))"
> +		MODPROBE_RM_PATIENT_TIMEOUT_ARGS=3D"--wait $MODPROBE_PATIENT_RM_TIMEOU=
T_MS"
> +	fi
> +	MODPROBE_REMOVE_PATIENT=3D"modprobe -r $MODPROBE_RM_PATIENT_TIMEOUT_ARG=
S"
> +fi
> +export MODPROBE_REMOVE_PATIENT

The variable MODPROBE_PATIENT_RM_TIMEOUT_SECONDS is evaluated here, and the=
n set
to MODPROBE_REMOVE_PATIENT. However, I found another hunk below modifies
MODPROBE_PATIENT_RM_TIMEOUT_SECONDS in stop_nvme_client() in test/nvmeof-mp=
/rc.
This value change in stop_nvme_client is after MODPROBE_REMOVE_PATIENT set.=
 Then
it is too late and the changed value is not reflected to the modprobe --wai=
t
option. I think this MODPROBE_PATIENT_RM_TIMEOUT_SECONDS evaluation should =
be
done in _patient_rmmod.

> +
> +# checks the refcount and returns 0 if we can safely remove the module. =
rmmod
> +# does this check for us, but we can use this to also iterate checking f=
or this
> +# refcount before we even try to remove the module. This is useful when =
using
> +# debug test modules which take a while to quiesce.
> +_patient_rmmod_check_refcnt()

Nit: this function name is not so straightforward for me. How about
"_module_refcnt_is_zero" ?

> +{
> +	local refcnt=3D0
> +
> +	refcnt=3D$(cat "/sys/module/$module/refcnt" 2>/dev/null)
> +	if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
> +		return 0
> +	fi
> +	return 1
> +}
> +
> +# Tries to wait patiently to remove a module by ensuring first
> +# the refcnt is 0 and then trying to remove the module over and over
> +# again within the time allowed. The timeout is configurable per test, j=
ust set
> +# MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
> +# This applies to both cases where kmod supports the patient module remo=
ver
> +# (modrobe --wait) and where it does not.
> +#
> +# If your version of kmod supports modprobe -p, we instead use that
> +# instead. Otherwise we have to implement a patient module remover
> +# ourselves.
> +_patient_rmmod()
> +{
> +	local module=3D$1
> +	local max_tries_max=3D$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
> +	local max_tries=3D0
> +	local mod_ret=3D0
> +	local refcnt_is_zero=3D0
> +	# Since we are looking for a directory we must adopt the
> +	# specific directory used by scripts/Makefile.lib for
> +	# KBUILD_MODNAME
> +	local module_sys=3D${module//-/_}
> +
> +	[ ! -e "/sys/module/$module_sys" ] && return 0
> +
> +	if [[ -n $MODPROBE_REMOVE_PATIENT ]]; then
> +		$MODPROBE_REMOVE_PATIENT "$module"

When null_blk module is built-in, the line above fails. Then test cases whi=
ch
can use built-in null_blk fail. For example, block/006 fail with this messa=
ge;

block/006 (run null-blk in blocking mode)                    [failed]
    read iops    ...  296442
    runtime      ...  24.852s
    --- tests/block/006.out     2022-12-26 20:14:17.578580764 +0900
    +++ /home/shin/kts/kernel-test-suite/sets/blktests/log/runlog/nodev/blo=
ck/006.out.bad       2022-12-27 11:20:59.933458782 +0900
    @@ -1,2 +1,4 @@
     Running block/006
    +modprobe: FATAL: Module null_blk is builtin.
    +kmod patient module removal for null_blk timed out waiting for refcnt =
to become 0 using timeout of 50 returned 1
     Test complete

To avoid the failures, I suggest to check existecne of the loadable module =
file
at the beginning of _patient_rmmod.

diff --git a/common/rc b/common/rc
index e50f70e..454849b 100644
--- a/common/rc
+++ b/common/rc
@@ -466,6 +466,7 @@ _patient_rmmod()
        # KBUILD_MODNAME
        local module_sys=3D${module//-/_}

+       _module_file_exists "${module}" ||  return 1
        [ ! -e "/sys/module/$module_sys" ] && return 0

        if [[ -n $MODPROBE_REMOVE_PATIENT ]]; then


> +		mod_ret=3D$?
> +		if [[ $mod_ret -ne 0 ]]; then
> +			echo "kmod patient module removal for $module timed out waiting for r=
efcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
> +		fi
> +		return $mod_ret
> +	fi
> +
> +	max_tries=3D$max_tries_max
> +
> +	while [[ "$max_tries" !=3D "0" ]]; do
> +		if _patient_rmmod_check_refcnt "$module_sys"; then
> +			refcnt_is_zero=3D1
> +			break
> +		fi
> +		sleep 1
> +		((max_tries--))
> +	done
> +
> +	if [[ $refcnt_is_zero -ne 1 ]]; then
> +		echo "custom patient module removal for $module timed out waiting for =
refcnt to become 0 using timeout of $max_tries_max"
> +		return 1
> +	fi
> +
> +	# If we ran out of time but our refcnt check confirms we had
> +	# a refcnt of 0, just try to remove the module once.
> +	if [[ "$max_tries" =3D=3D "0" ]]; then
> +		modprobe -r "$module"
> +		return $?
> +	fi
> +
> +	# If we have extra time left. Use the time left to now try to
> +	# persistently remove the module. We do this because although through
> +	# the above we found refcnt to be 0, removal can still fail since
> +	# userspace can always race to bump the refcnt. An example is any
> +	# blkdev_open() calls against a block device. These issues have been
> +	# tracked and documented in the following bug reports, which justifies
> +	# our need to do this in userspace:
> +	# https://bugzilla.kernel.org/show_bug.cgi?id=3D212337
> +	# https://bugzilla.kernel.org/show_bug.cgi?id=3D214015
> +	while [[ $max_tries !=3D 0 ]]; do
> +		if [[ -d /sys/module/$module ]]; then

Nit: the two lines above can be:

	while [[ $max_tries !=3D 0 ]] && [[ -d /sys/module/$module ]]; do

It will reduce the nest depth by one.

> +			modprobe -r "$module" 2> /dev/null
> +			mod_ret=3D$?
> +			if [[ $mod_ret =3D=3D 0 ]]; then
> +				break;
> +			fi
> +			sleep 1
> +			((max_tries--))
> +		else
> +			break
> +		fi
> +	done
> +
> +	if [[ $mod_ret -ne 0 ]]; then
> +		echo "custom patient module removal for $module timed out trying to re=
move $module using timeout of $max_tries_max last try returned $mod_ret"

$module is printed twice. Can we simplify the error message a bit?

> +	fi
> +
> +	return $mod_ret
> +}
> diff --git a/common/scsi_debug b/common/scsi_debug
> index ae13bb624b3d..889116e8b46b 100644
> --- a/common/scsi_debug
> +++ b/common/scsi_debug
> @@ -4,6 +4,8 @@
>  #
>  # scsi_debug helper functions.
> =20
> +. common/rc
> +
>  _have_scsi_debug() {
>  	_have_module scsi_debug
>  }
> @@ -18,9 +20,8 @@ _init_scsi_debug() {
>  		args+=3D(zbc=3Dhost-managed zone_nr_conv=3D0)
>  	fi
> =20
> -	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "${args[@]}"; then
> -		return 1
> -	fi
> +	_patient_rmmod scsi_debug || return 1
> +	modprobe scsi_debug "${args[@]}" || return 1
> =20
>  	udevadm settle
> =20
> @@ -60,5 +61,5 @@ _exit_scsi_debug() {
>  	unset SCSI_DEBUG_TARGETS
>  	unset SCSI_DEBUG_DEVICES
>  	udevadm settle
> -	modprobe -r scsi_debug
> +	_patient_rmmod scsi_debug
>  }
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index ff13ea257cab..df78ed4bc6ea 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -162,11 +162,11 @@ _cleanup_nvmet() {
>  	shopt -u nullglob
>  	trap SIGINT
> =20
> -	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> +	_patient_rmmod nvme-"${nvme_trtype}"
>  	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
> -		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> -	fi
> -	modprobe -rq nvmet 2>/dev/null
> +                _patient_rmmod nvmet-"${nvme_trtype}"
> +        fi
> +	_patient_rmmod nvmet 2>/dev/null
>  	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
>  		stop_soft_rdma
>  	fi
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index 4238a4cd663e..27e835a158ae 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -162,12 +162,13 @@ start_nvme_client() {
>  }
> =20
>  stop_nvme_client() {
> -	_unload_module nvme-rdma || return $?
> -	_unload_module nvme-fabrics || return $?
> +	_patient_rmmod nvme-rdma || return 1
> +	_patient_rmmod nvme-fabrics || return 1
>  	# Ignore nvme and nvme-core unload errors - this test may be run on a
>  	# system equipped with one or more NVMe SSDs.
> -	_unload_module nvme >&/dev/null
> -	_unload_module nvme-core >&/dev/null
> +	export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS=3D5

As I noted above, this value change is not reflected to modprobe -r --wait
command (It is reflected to the open code of _patinet_rmmod implementation)=
.

Just for curiosity, why we need different MODPROBE_PATIENT_RM_TIMEOUT_SECON=
DS
value for nvmeof-mp?

> +	_patient_rmmod nvme
> +	_patient_rmmod nvme-core
>  	return 0
>  }
> =20
> @@ -267,9 +268,9 @@ stop_nvme_target() {
>  				rmdir "$d"
>  			done
>  	)
> -	_unload_module nvmet_rdma &&
> -		_unload_module nvmet &&
> -		_exit_null_blk
> +	_patient_rmmod nvmet_rdma || return 1
> +	_patient_rmmod nvmet || return 1
> +	_exit_null_blk
>  }
> =20
>  start_target() {
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 55b535aea619..4d504f7bd0cc 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -491,7 +491,7 @@ start_lio_srpt() {
>  	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
>  		opts+=3D("rdma_cm_port=3D${srp_rdma_cm_port}")
>  	fi
> -	_unload_module ib_srpt
> +	_patient_rmmod ib_srpt
>  	modprobe ib_srpt "${opts[@]}" || return $?
>  	i=3D0
>  	for r in "${vdev_path[@]}"; do
> @@ -553,7 +553,7 @@ stop_lio_srpt() {
>  			 target_core_file target_core_stgt target_core_user \
>  			 target_core_mod
>  	do
> -		_unload_module $m 10 || return $?
> +		_patient_rmmod $m || return $?
>  	done
>  }
> =20
> --=20
> 2.35.1
>=20

--=20
Shin'ichiro Kawasaki=
