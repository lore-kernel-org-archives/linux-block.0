Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE961C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 03:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiGGDN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 23:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGGDN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 23:13:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8BB49
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657163604; x=1688699604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CRfAZhyFmKWHwSVdIhR3mZ1ZlWCmL2eD25U6zFm6oR0=;
  b=c3fKtF+vsPhmIR+2ceN+laF5YbLv4NMlJfbINjemTNh9lKuaDsXwLnn2
   YJ+c/ydAbxgVwEI68YGT5XGxJIgmXKvotZ6xQxypMriQLeDgpqo1zZ5jK
   xMuiKfMKIj8g5vfkZO/xXnJX0/MLHUOPHk63s4HkNPWt9Taix2k7TKvhu
   kJduIGbbhya4OPsdvaQYkEPluN8KW/v6BsCj+ugW1FblRV+m6X4IkE2qJ
   snaQIktC3W27O5oXw9AFeA7pd4BRWHQt6Wf4noyd/cF0CTtp167ZgqVc5
   Bl0jjnf/2dbEiUBqWcwViUGd6IqvfOENuSbo40VcBSYBfqivv/1iYVY+T
   w==;
X-IronPort-AV: E=Sophos;i="5.92,251,1650902400"; 
   d="scan'208";a="203695919"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 11:13:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNZklz9tN4RDrsZcBoSciR4ITWEOr3RpRkDs2B6CcAuMjwf4YJicm5i6aOyfehAwgY4EThYeoDcMfhjyYn93OqsnN+iwJ4whVN2nO6cjUlzfXqL8GCdW87yEprDLEH7vm603bZcWsx4YPaPgS5lcX/oJvTeqFIxYXxyhdzuQp6KjuM5EB4fwrw0htfPeTA1Nr//aQo5lMhJrcdIQUADZx31Uh/8blmPMuT3yIz+FPh64WeijJc3UneCnGjRYqyoc3AHEhD5FrgaELXQBa0b2t5jZ/xSivDO611kK6R9oq8HYTR0rCp1Z/fC5ipybFxJLLRpuD03QTPOFuCjgs/EaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIc6hNWhV2AuLSyfsboF4VCj/ndPL1gDPeNrgmyjdAU=;
 b=muGDqD11W+N3i/XRI1IxmbwIDaawI4u038gSyMs5J+aSyVR7T0n5pkOirt3ZGK2iwsrZKk8eZ76TDfPy8wtZaLSrIlUTI1Hc5dcMjhiKaHwTdLM+hWN4ibaSzgwdU0hkHhJ8g7ziQ6T68uoShwDlWzX6eF5MQ28zAJKoTanH4ejBJby1Hy1FwndseY9Lbw1MvGKAVmOx23UN2uwHjdfbZtjzJ07X7F6OTfMR1/yzSzIPsRPbH0AZdVHOW0rPG/j1586RsXCIK3QMIirvoVoxuiDCByxAtzLZJKK2U9RUipIVOZGHtslWHX87SkfrrjVNrjOAtJRvrmPUV0LxAburTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIc6hNWhV2AuLSyfsboF4VCj/ndPL1gDPeNrgmyjdAU=;
 b=LN6epJibHzw+PGaFqSHp28FngWbbi7WldMuEPhW2HNlmW+pnnU6rulEhDW+/7p7FS0PlCVMv07xKQtSdlhE0qjT7TSRwiuiCITLomkeCmZaQmdD5rw64ToGb6dQvCkPhzElnmvf6KSOWXqIHqcdkbfX+QxaqEppqVaTkxQ7ilIo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7511.namprd04.prod.outlook.com (2603:10b6:510:4d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 7 Jul 2022 03:13:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 03:13:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] block/008: avoid _offline_cpu() call in
 sub-shell
Thread-Topic: [PATCH blktests] block/008: avoid _offline_cpu() call in
 sub-shell
Thread-Index: AQHYj5ePqJNS+3ohb0Knt8rCK0LlY61xYPoAgADe2oA=
Date:   Thu, 7 Jul 2022 03:13:19 +0000
Message-ID: <20220707031319.gz5rwbx5ritddq2k@shindev>
References: <20220704111638.1109883-1-shinichiro.kawasaki@wdc.com>
 <521c76db-1c3c-07f5-8b00-7fc5385fbd4a@acm.org>
In-Reply-To: <521c76db-1c3c-07f5-8b00-7fc5385fbd4a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 317b6cba-cb03-4142-d756-08da5fc6a4d7
x-ms-traffictypediagnostic: PH0PR04MB7511:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXyd17UQ6Ayn+q8J/AdVyXICVi0PuJ4z5HYQwZrGn/nGt1C3jCvhLkXloODxVvUeeGQGd73qJn0MIyarz1iC90bzARF2aQqzWQZsU21S4aFr5M1dr0SdvpIBixMrO2Yfn5yvIhN4kndLzEoa3vdMLt+Tb8Kjm4v1+CEbcQ2/Fm85ffEVbWeN8Us/UtaZ5DHMEv3wf4kymDbut6hMRibg3XJCYqYTbpzSRNxqCZor0ZD+YyNvbJ74owUqx9jWy+7DQQp0SXRyS29BlvWRth7E7oVLbv5i6qUHxwMUF1abYMkdrY1BG2UO0EFwPgQoHK7aQ3fAAl1nl+GAbtIbLOY1PjovgR/8KPcMd+H1egVqlBxMB3IG+Vm14t1DPiBKSuR/lnQckvm/DwQB1fjkC/xC79dQlZwKFCK1iFjyLhi0it0WC9/F2fxhiSicdoH/5yC5zSgNnkJgRvS0YqdxDTxJmMPsoyu2NTNc8a23bgiS0JB375aSPdu4gBA/1A2PwWT2Mx5mVYXdnL/B5ToDOW92QBZPXYwAGkRaHDogPfsG9tDjNMh+DCZu7COqg3zbPVIgFCjaXJ9oq9fKNitaLQkV+dREPjFj+0S8M9q+1Sw+puNH1Pe+c5EQjUg6VhfveL39QOdAASsHK+4/XxDYfA2r5uEq5Y7QHmFlBddwF0Ts9DfNXod0YVEZ5CxuGOrdgk7LeJzcEM6zWJcoytnzwqxxK8BcuHyn2UKaTzsNYYOEj4YkzJcY3iyELX6Vl8AgxQcP1iLppcQEg48M3/UbyucKCzLGC3oyiZT9SafRkZHTZPYuv4iBQ9eMvK7Ss9pKdNgF/1kelCP6lUOL7kjc03qMCRk16zQmQIwjcqNQBXnm1ng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(316002)(6512007)(53546011)(66946007)(41300700001)(26005)(6916009)(9686003)(83380400001)(91956017)(478600001)(54906003)(6506007)(71200400001)(966005)(4326008)(6486002)(2906002)(64756008)(66556008)(66476007)(33716001)(66446008)(44832011)(8676002)(76116006)(5660300002)(86362001)(38100700002)(1076003)(186003)(82960400001)(122000001)(38070700005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xi6td1OQrrHrSCZwVUj4p9b+PwYocn+cdoZ1O6TV49CFlLVajsTxXbwl3DPR?=
 =?us-ascii?Q?oreBZ7LLu7irdAb/DtZLyaJ8+UxxvfQHRFBia+HApZHRVqWG6igB8sv/36KJ?=
 =?us-ascii?Q?Lbn05Ldcevd5jJKvFxHwONyQfRJ7bwycsURMxgXEAITtsG533c4+cPfjdrZg?=
 =?us-ascii?Q?/jcI80EeUr6jgClOrP1BffYEz0DU/eHPoQk7SR3pg/qNEyVEEmZbKwxmso0r?=
 =?us-ascii?Q?M7TW6z04+Tbbm4U2bxHU3SBcKRm52xRwUnBqNNGB+/pGenYgZmRdQbdAI1KR?=
 =?us-ascii?Q?bGv8somELOJwI/B3Whe4bfnvWag33c2LChvJ7YcAkhuypHXrXl5nQEETuMK0?=
 =?us-ascii?Q?TgYKhKI1TehmXkqTFfQlobpjirbsY3GDnov5R8UaUpkLsO0cNFyG4SGwNDG1?=
 =?us-ascii?Q?jOL576n/GM1dZWDHmZaqzPtQOFAdz0oCw1JdZSZO9fDnjfT8bO7Ddettak0a?=
 =?us-ascii?Q?9AV1QylU9edOT4cY/GdJPFiIlX9aDP4Oovv8V383xceBw4RZJ3geUay/i6xu?=
 =?us-ascii?Q?TQ2PRn6CEwXo5yRfjlg/6KhlkAB805tW3I91czepKfec9WkK3lgpVQ1d+mQL?=
 =?us-ascii?Q?xzToc7HCB7HcBbG61Mbx2IuSSwGnFVEZH00FM9azEF9npixZMW4xEUn5eeA2?=
 =?us-ascii?Q?g+9pD9vJx1RllI6yoDHQO3xlEBBO64nn0NdCBhulh7JkmbDV0TW2feVbsT+v?=
 =?us-ascii?Q?4v8sxrTWkx8mC3Qd4g9MK/3+tL6qImFRc9ZR+e4l+rY3iT4rrMvIQpyr0s+s?=
 =?us-ascii?Q?vdqXoI7oSCojUWphoHTkYfmoxkVjcaFeaVhismfMUnwZpeBD1Ezj4lbRd9yO?=
 =?us-ascii?Q?PqUx1wP/g80eNXXbDWkzFFGyYIDV3KcRQ/m+19r783Qb9VlSV4eO38X4LEBm?=
 =?us-ascii?Q?kSsxbHI59Pj0AHpfQ77D8j2FdxswL8yNvfaG7hHjj3kEJIrDTT40Z6vDbfaE?=
 =?us-ascii?Q?peLS4nd3qEU2cyXc+FlsLv6kuwhFHtMHqRoavo1O4qD6C5zxnbCYh7/NVmZU?=
 =?us-ascii?Q?KETfUeuBaNJ2UT+DMR2DRHmo1UhGN2y9HCAzOTyqPEbrJMPjeOUxYpSHrT54?=
 =?us-ascii?Q?2zeo3UzBKnYRwaP8I4CFSnOtsPgE2wTZf4RtDt4YQqNUolublxoundvUqQM1?=
 =?us-ascii?Q?GOUK6p3rxRtCTNbQ64eoogfCp4cZd1GX7fU0tW7beErdMbeQ8X8L0fqtkTVq?=
 =?us-ascii?Q?240+OVOQjAI7ERIfN8v7t4VaDS0RNkD3ZS+geATrkoV41yiO7JnCWS7a3L9T?=
 =?us-ascii?Q?tdLU6CrCdTMCF9KhlJP8Aii+dFLDOhMOYo9HRvnWv56arwUpke5ZsV1XY3x1?=
 =?us-ascii?Q?UUijwXaMSCEf5ViTDm+j58mqvqqNHD3jC8sjAQTlOovNnnwcwnJjznqLkIwC?=
 =?us-ascii?Q?NDqtsblB2TyNAM3c9vP51vK35/JN9paTpRo6jnfTsi3Q94po2AQxFqt9DJmt?=
 =?us-ascii?Q?SwLgVYreQWF6VGr4Ol753oQjpJBTOzvXQ36zZPOdcYFjLNEKST4ybypKvQkp?=
 =?us-ascii?Q?FRhMxhF+AyaCMvJCGtGOchU+aEb/fFqu0AdBssYDu0VWRnAMyo8E5C1Waw1e?=
 =?us-ascii?Q?S/JJKkugInScMeAhM5MIgzEpOk+x/7OMY5KlqnIL3pcY31QI54YplPkwnu+8?=
 =?us-ascii?Q?7fbqYY6iN1OeOGLgJ+80C2g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1648525CC577EB4F86A989C2C6E73C39@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317b6cba-cb03-4142-d756-08da5fc6a4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 03:13:19.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBQyAB4J0pNFrTUV+uLuHWbdDDjDQmmKv8yF1LxVCrhkqTDvu2zxRxsRrOzyN/3hRmuXAMU4S9OkuiuNmvgYkXl89p9ZdQMVV8xXvz1wbA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7511
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 06, 2022 / 06:55, Bart Van Assche wrote:
> On 7/4/22 04:16, Shin'ichiro Kawasaki wrote:
> > The helper function _offline_cpu() sets a value to RESTORE_CPUS_ONLINE.
> > However, the commit bd6b882b2650 ("block/008: check CPU offline failure
> > due to many IRQs") put _offline_cpu() call in sub-shell, then the set
> > value to RESTORE_CPUS_ONLINE no longer affects function caller's
> > environment. This resulted in offlined CPUs not restored by _cleanup()
> > when the test case block/008 calls only _offline_cpu() and does not cal=
l
> > _online_cpu().
> >=20
> > To fix the issue, avoid _offline_cpu() call in sub-shell. Use file
> > redirect to get output of _offline_cpu() instead of sub-shell execution=
.
> >=20
> > Fixes: bd6b882b2650 ("block/008: check CPU offline failure due to many =
IRQs")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> > Link: https://lore.kernel.org/linux-block/20220703180956.2922025-1-yi.z=
hang@redhat.com/
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >   tests/block/008 | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tests/block/008 b/tests/block/008
> > index 75aae65..cd09352 100755
> > --- a/tests/block/008
> > +++ b/tests/block/008
> > @@ -34,6 +34,7 @@ test_device() {
> >   	local offline_cpus=3D()
> >   	local offlining=3D1
> >   	local max_offline=3D${#HOTPLUGGABLE_CPUS[@]}
> > +	local o=3D$TMPDIR/offline_cpu_out
> >   	if [[ ${#HOTPLUGGABLE_CPUS[@]} -eq ${#ALL_CPUS[@]} ]]; then
> >   		(( max_offline-- ))
> >   	fi
> > @@ -60,18 +61,18 @@ test_device() {
> >   		if (( offlining )); then
> >   			idx=3D$((RANDOM % ${#online_cpus[@]}))
> > -			if err=3D$(_offline_cpu "${online_cpus[$idx]}" 2>&1); then
> > +			if _offline_cpu "${online_cpus[$idx]}" > "$o" 2>&1; then
> >   				offline_cpus+=3D("${online_cpus[$idx]}")
> >   				unset "online_cpus[$idx]"
> >   				online_cpus=3D("${online_cpus[@]}")
> > -			elif [[ $err =3D~ "No space left on device" ]]; then
> > +			elif [[ $(<"$o") =3D~ "No space left on device" ]]; then
> >   				# ENOSPC means CPU offline failure due to IRQ
> >   				# vector shortage. Keep current number of
> >   				# offline CPUs as maximum CPUs to offline.
> >   				max_offline=3D${#offline_cpus[@]}
> >   				offlining=3D0
> >   			else
> > -				echo "Failed to offline CPU: $err"
> > +				echo "Failed to offline CPU: $(<"$o")"
> >   				break
> >   			fi
> >   		fi
>=20
> Has it been considered to move RESTORE_CPUS_ONLINE=3D1 from _online_cpu()=
 /
> _offline_cpu() into the callers of these functions instead of making the
> above change?

Yes, I thought about it. Looking in the codes in "common/cpuhotplug" and
_cleanup in "check", I guess it was intended to hide RESTORE_CPUS_ONLINE fr=
om
test cases. So, I chose the fix above, but I agree the file redirection doe=
s not
look the best. And it still leaves the limitation that the _offline_cpu() c=
an
not be called in sub-shell.

As another fix candidate, how about the fix below? It moves the
RESTORE_CPUS_ONLINE=3D1 from _offline_cpu() to _have_cpu_hotplug(), which i=
s more
unlikely to be called in sub-shell. It still hides RESTORE_CPUS_ONLINE and
should fix the issue.

diff --git a/common/cpuhotplug b/common/cpuhotplug
index d3aabfa..f57a5aa 100644
--- a/common/cpuhotplug
+++ b/common/cpuhotplug
@@ -27,17 +27,21 @@ _have_cpu_hotplug() {
 		SKIP_REASON=3D"CPU hotplugging is not supported"
 		return 1
 	fi
+
+	# shellcheck disable=3DSC2034
+	RESTORE_CPUS_ONLINE=3D1
 	return 0
 }
=20
 _online_cpu() {
-	# shellcheck disable=3DSC2034
-	RESTORE_CPUS_ONLINE=3D1
 	echo 1 > "/sys/devices/system/cpu/cpu$1/online"
 }
=20
 _offline_cpu() {
-	# shellcheck disable=3DSC2034
-	RESTORE_CPUS_ONLINE=3D1
+	if [[ -z ${RESTORE_CPUS_ONLINE} ]]; then
+		echo "offlining cpu but RESTORE_CPUS_ONLINE is not set"
+		return 1
+	fi
+
 	echo 0 > "/sys/devices/system/cpu/cpu$1/online"
 }


--=20
Shin'ichiro Kawasaki=
