Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA81287269
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809580; cv=fail; b=KvgyNgy0LZrTMFBW4eUYuwP8UvdPdtBk/tJFnqoZNy5fBdsKxOqB4HlvbUaWRv106o28CuxBKvOai9gdPQAWcnxFtGrodaTkJQPw2zmlrw038HDT/1vJP2lXUBkGDnq934KzEiR/f+Q4LdqLsXDJ3suY0xnMizEiCQi+UUBsThg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809580; c=relaxed/simple;
	bh=6P6tuU9gnWM+ebEDkZDwl9TcrpYXj/vxZdvc4pUcNjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JxEOs10cMoTyZGa8jOs6rNwtH/vkw9xvH6ZbtEKavqhOsF+rRWe75vz5ANurm2OkF551Dd+7zl9wbgDURR3evbPt18EIMPFfW3HBsDtlv9vlayBLrdCFm98bkrvuac3g3/aIm1iLjn/XnMwHNglC9QtOMEsJDdSxkR0RTTwWzos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NhyKLvRM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dXg7GQ7r; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NhyKLvRM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dXg7GQ7r"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758809578; x=1790345578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6P6tuU9gnWM+ebEDkZDwl9TcrpYXj/vxZdvc4pUcNjU=;
  b=NhyKLvRMQSDDysVdvJmSvbtT9J9kk1cfLi13mPqeGTD1YY/GeApd7kQG
   ohxKysCXY1QbcQlmx1hE/y5Pw1PCqjDJ9eNjk7X35P0vQNctIMuRMmE8U
   sM2hJyN2FWwr1mII2WgjuMO5AfhVfbIDR5IM+2Lby1pVK+CSZoSZdvxqp
   cUutfSsAW2G+4nGeI7hvCb6ReSdgoOn6bURbwqzKM3sNW21+4BvJHGgmh
   ddV0RbN0KuZkABFBhEWRaq29ApL4r0SVPh7mQqlKU4+oYtGLuHY/vZ2NU
   HtzNDmss1PMuDqbGuxBWYL5Zv4NGqSite6mXGErDyHqwUcV9H0Qbyq1T3
   w==;
X-CSE-ConnectionGUID: YDYh+HyDRbiuwGGfCou2dg==
X-CSE-MsgGUID: /FnAwBGsTiGsvDzGrWQ1OQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130163629"
Received: from mail-westcentralusazon11013021.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.21])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 22:12:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgg9OdECDYmJRAB9Ecz67xpTCJCnkCBWkTFGRXhkvvz/Rk+gSM9EGQOW3LNCynJo9HuTjEkac0oYDNDzctKFwiUaQubGLxAsiJ6IumXNtrn4U6gheD6fmSR6DNeZ9uC6h47sLAb3gP2WVvzFLEpjr3My3SlK7eersuqM6w+wyzvNxnO0OnD55FSfaO1zo1hI3vyBGe5SvCG+pW6f9TPpxBYuXjZTa+BbBNZ1eoxgtGLE7/J2wd9Asy6BDJqzIInchiofOIFyZ5qBy909lhEioq91U28tGrPe4Pvrs7vO1yhL2B4TFTKOFC+0H5cRx0gBXnyWN7Z6PHW7tSjdBeSc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siMLAkr8iBi7zcfkWMXqURJU4mz01h+bqm2e3kHgEJ4=;
 b=osGncIX8BsgXcIJHyjeTXnW4FDj3jCd9VItLnz0cnb+H0R5Sj5K3c0jJgoHOHAR8l+zQS7B3cj/g0n/LYx1/3u8WG+Zdlep3WIRN0FUfZMHdyLND6ozJGAwfZ2tl4LMMGwjq59Hml4V/qBDkG+rST2XPzM6at6PNXidIDF9p0LDDCQZeN0SpHYG6pqNdhvFR/0HH/L3mxxjRJ3owrO+bk6O6pUDXh/TjwXKcQp27cH1n1sOZFsBuSgXib/cdYKTUjTmb60amJQuJ8rJ+fJgS8RnZXrdpFDklnoqYjDstIwJc6qSuXK3X/TJF3LTlAFXtRIeyMlOhwl+/O7DvUSDb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siMLAkr8iBi7zcfkWMXqURJU4mz01h+bqm2e3kHgEJ4=;
 b=dXg7GQ7rf1Rxgmxfaf3FF4Q+Oo4EmC2b+b3OR9PC6QV3PTXHGWWVfFwrwqCCMe+bC1w3ltY1H246gIjMZR0fAFMuRI5SKa+S5kv6KC3Z7X+vzcrTUsZJJzWCWAmH4UfRSb0/DYVq+mxfJnJDsk8coYgUvYcTfkx2cmNRfuCuJrE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN2PR04MB6815.namprd04.prod.outlook.com (2603:10b6:208:1ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 14:12:56 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 14:12:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Topic: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Index: AQHcK6sug4CvHkcG+kqFWi7gggf3erSjmJmAgAAB0gCAAFs1gA==
Date: Thu, 25 Sep 2025 14:12:54 +0000
Message-ID: <mlkg5dr4ipq5722ye5owxppp7t7drkvcnijcinsryc2fe4t3y6@n7e4l5hc5zo7>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <20250922102433.1586402-7-john.g.garry@oracle.com>
 <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
 <5d9a2005-93cb-47b3-a708-e0db50328142@oracle.com>
In-Reply-To: <5d9a2005-93cb-47b3-a708-e0db50328142@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN2PR04MB6815:EE_
x-ms-office365-filtering-correlation-id: c810c546-1008-41b3-e317-08ddfc3d9f04
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KlpvzHkayXtH271nhCDgtm2Xn8YAGLgWR92FZoSJ/XfjOvNZuoDIoEJHdqVm?=
 =?us-ascii?Q?Y05/1wEp5aZkUrLlh5IC0pEpa/UpqPp/pnIM9q7jgLkwo89TA8QNAiDK/qrd?=
 =?us-ascii?Q?kLfQlboboAAk3p+w8XN/48EhhxQbYVEmbOQAxzQFPnyvtZV/o3pCzVxQuKv7?=
 =?us-ascii?Q?Ctk/q0mR8B7/jRcARCfwbxEy8R6NTtZaWz/oYM4xJiuMc8/fY9sxX6IZcuf0?=
 =?us-ascii?Q?FPlvJTOOEgx7L+D6LaMF/dZ7gXQeuiLP5LNPNuVo8sa+D1VxMewPV7hqaHx3?=
 =?us-ascii?Q?XIZh8l/9GbQeR+2d7NFoHqesDBAzDVETySr4gwUdwiywXJppdIi2LGskkD8m?=
 =?us-ascii?Q?jm9FlivRc/Yezbv7i8+tHeGabk+DmJO7v0fXyJSug6qhS04Vl/wHJr3VMpnp?=
 =?us-ascii?Q?5UShT2CTLIBr5aRa7W4MiWBFTIUZG5qMQOEe+I79Nl6pT1k7Tb/LhR5YcGp1?=
 =?us-ascii?Q?60q/E+snysDvsnUtNhefH46diARrPm98Nv9g4EeN1ayS4jz18jgPKFNuWCa3?=
 =?us-ascii?Q?Xyw0tsb5ML9+c/CEaIrGkKvmygFSeM7fBB7mdOG22xOIg2XepScHcQutrvcc?=
 =?us-ascii?Q?nmK0RJjLcNAhbQPT+noHnwGsCkTvOlAVljV/60F2BgWjr7cR5G0+GXBi4h5i?=
 =?us-ascii?Q?4rik31wpW4Pxa3bgDldirJBPMEe90uJZG9mOFNovttbdnc7c24GybFMa4UcP?=
 =?us-ascii?Q?1C2q+6eIoMT7bDrLQj+Lwpqpu7Ci3g6/ITykuJir2raaLKSD1BAD5w5i2q8i?=
 =?us-ascii?Q?e0/l23sLhQcSX7ZJ99hViuUxo0h+rUMan823YPv5My5sd02K4ZN3qdfosJN2?=
 =?us-ascii?Q?mUpr1SwQ29TxT99qrqZ7nvuuCjOtarGtQKtRC8J/380LZVo7WYmeCFgo7fr+?=
 =?us-ascii?Q?THqVvJ9aVYm+jfCbxaJl6KLQMXBnzI6r/PpMzoBfjBpLNXuOHe8hEIKFUI0T?=
 =?us-ascii?Q?8pUr73bJ3XpHy4oo+3Tc/hGsrLghuSg3DNZWRBQnCgDY5hTSoVuyGrW55Ong?=
 =?us-ascii?Q?fRvHCg7gMg6yXj0AytNwIFA3wPeB2M/VAi68ivkKEuJGlPc7UYc39PVR3b+5?=
 =?us-ascii?Q?yRKyHfFCUmbOOX+flmf2QO8OL8PXw+DFVHE9bKnrOQvW9P+1wj27rMiPumWL?=
 =?us-ascii?Q?bzkiDN0CwMdOKOW/2GTPv1SsYz7lIoUvT3od5f9ld5AzVt4v+zCYIreIQ6l1?=
 =?us-ascii?Q?Cu8+dKPHllai00bpBfvdDFofYyVXZDRRCWYVUi3VYX+WWRVOpdMWptHfGvWr?=
 =?us-ascii?Q?5vdL/bm2WkfbgVciKm9gwJOkMJoabtfN8Hkoc1hiDuKkOL+kgP7vUI70yEL7?=
 =?us-ascii?Q?TKmphnGVAnJPlxjPaW+j5mTfFyUWtMTdVVCfN3qyVr7eVwIgyXj821T9FHL+?=
 =?us-ascii?Q?fvIZqqgb8cIqiwLZTe+wBlNI8o94sX+8oM2m3+jYZ5LCFOgtEk0FyOWHZ3hy?=
 =?us-ascii?Q?1Tj8Vc6lDdTs4zxHBY968Klz57C+n2MRTfp4WuUVDf+JHydC5Bm3jBHCaYGg?=
 =?us-ascii?Q?qLMK/CY6VVMVkh0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3uzF/kdXxRJxAfBbY0/KJdQcNFU/FUT9YP3aWwuL2QVM9Hd4wCay4qNu6maZ?=
 =?us-ascii?Q?PfnmPazQiFG+kxADOnk22APw5Wc6ehUrRliCSEzGIOlMF+V5XKR48Ud6hQPZ?=
 =?us-ascii?Q?YoT+a+Yf/m7yUkmO3BI66MWN7mNadCKhal3SvCvyb6onghCny4GmKWNrtTQD?=
 =?us-ascii?Q?774tRepPKzfmdw4+S1s5TGh9nVdcVGnOdT+QAoDa1194BxNMYhOTxztJQ2N2?=
 =?us-ascii?Q?F17DoavqgMtWFq3pyA9sIys66uFsjU388urXYiUI5HikuVwEmlJSe/gxzV2S?=
 =?us-ascii?Q?YFrUtG2GeAw7qWOYZrf62Q85yot/wUTQVvOUqpnHEfvlVJi12tE220sKwyv6?=
 =?us-ascii?Q?oNyKs/34Ie70z9YGAiwfqacweddNjuaMMajhHnv2e86DaBIQK0clE44qm/Er?=
 =?us-ascii?Q?5BAuSKgbVEzMBS6f1wrj8ABQ6dcQ4J4r5aV24DNk/4qb6anvcLM+ih7U0Xhp?=
 =?us-ascii?Q?FT5aBGV4zLO3Mfag+YHiS/oSBwf0hHltAXt0M8sH/mm3sJhpcRFsltjZXUbV?=
 =?us-ascii?Q?vMWY0c5zJycCHkEbjJyCBNTUDbb9AJ4+p+a21PzAj/mBpgL8F0FiMHt6z3ba?=
 =?us-ascii?Q?sHHPv2t8U17pawtVwvDUzl0aIKr4A8t6/OaG/eEUeh3x2A41/nFKOjLwrF6i?=
 =?us-ascii?Q?kmxQX8SflX+Y5O/J300FtHRynsLuCCMZSmhkLFVKzcdU2jBaObruDXjdV+sj?=
 =?us-ascii?Q?ezjPnPiH7Zq2BA8UzXDrYPVidlytrzKkeZH3Cq4uW6/c4UMPEzE0Zd+dhyPS?=
 =?us-ascii?Q?s+sn1B6Dudwza8eKDVNc+gPMr/rEhPqHA2kYHAoZ5qEMWwZhvVv+/DnNzRt0?=
 =?us-ascii?Q?z53lwV7mm6TfgEdUT3gA1vz78erYRAWbbCfLVUlatwFPT2BEE+f5SQcy7tLn?=
 =?us-ascii?Q?mMqy7ubhbkRPDLJL+iTSkvmYVMdT4lQyipraWl5vEgMuTUytAlTyVNnlR+9m?=
 =?us-ascii?Q?3IEQSnvKQ0V1aduax0ci3dQ3uPkzAEPk1zYsp/64xWE6b+1egtq7+nW6Gxpe?=
 =?us-ascii?Q?LHTdsAKTd9DlKzyMjanxnfHs1oaclcr9gOZFUQw34SsNQ4fiPI0GzNo1ahQX?=
 =?us-ascii?Q?rH/wwgGKP2WohDZwhml2pGJuFFRjREwnODZnRoWrEfDMmpSquLrztJqKtfu9?=
 =?us-ascii?Q?y2ELQDxqqtcSkFlbZzoSu9sIqLynDo9pvysEoiYvJ9Cw7+T9sI2b6e+EF8fL?=
 =?us-ascii?Q?0Mx9MEy8rO2OYy8EM7cWJV4iUFT6PHoo9vSi2S+AMsLSQsFiYgoKzmmAMOaI?=
 =?us-ascii?Q?uIyL1rF07JMgUPwP0wxSzEOtCZRLvbvvQnNI3nGRSN66nh73fL5YohpfWaoE?=
 =?us-ascii?Q?d3jrI4PXGHcvO9nxUX1V/ghXQWdGSMRA4b1VIs/aJtXFf7Mv/43HUtDA9zRP?=
 =?us-ascii?Q?cihJUh0vGyOPsJHCeLqvpD4lBhukJ21MQYl86W9Smc5hrGAJACiqrDgpSHo5?=
 =?us-ascii?Q?yqP6pEM9oFWvWpukJdCI1CDP2rAtdhUyObwL7fO5R3OQjeoypQzZA1uqV/wZ?=
 =?us-ascii?Q?rLq0j3sEihlPDAs8zyfROVHEhby4CtVbwPmW+sGSPyaI846L1HtF91Sh/jaE?=
 =?us-ascii?Q?7Sbicn9TCh35rb2HJMDgDuMYNMrK/BNyCmB6qC5kcp8JjB24kGukaBYQ9ydE?=
 =?us-ascii?Q?mF6Xbf5YjoL9Z+Tmv4BOLJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF41D8517E35394D88F9D347424A46A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sd8vXkWQlnOJG6J+YRC0jtT+/TGe4W69PiMTf3yib0ZKr0MArkj+kTrabwGHYZflOUW9QNU1b/94Ddnc/a94j886PPaxYeDCn2a9GU4L2vYII/j9eojOgGw2SartOf0Z2sT9mxCXYbJqh/0u+9E1eJj/Lfj/b9YU8XnsjYZyUvGfkE/GhSfF3jUh69rgHL/X8qNsQCRqKaHyfsi6/WXp3P7dd3DYtAhySRMN+glUqxaRoLyFq1rkVgcqJ3auz6iyknNS12H/GlHECxEy1s104g/dU0+s42k+s7DrHSb49uv++y24wyzMDVbYfji16bsN33qEUgrp01gkjx54cdUv9XLYtQFUH+qzhXChH0yxhAmTaUacIruufet6x/0MGSmCyaoCxmdiNYQFqj8iFePQHpmDBbhkIaPATB4OAt16CASdf8iyMQugnQBsfULe0VSHtUeRL4Cp6/XBEOab40+e9wFiwqVA5mdvmk8eLLoBynqP79ng3EJDZ0cOFjr7bHOicPpn3tqBa/S6utOpcT8WtPUFhuYvAnN9GpV1w/XfrXL36UNJIf7sK36Bw1q9vU09pftsnKjPmGxSPEXqKaAEreQ4Zmvl5RgPHm2BZ4V7Cx5bgzntIRLbjSWSrTnCeTQv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c810c546-1008-41b3-e317-08ddfc3d9f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 14:12:54.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwKYzi2zOrEAbmXDg3T4NfaEzaWjgQ5hQ5TROsueVLt4RIRAV7gg4PiI4JthZn9wGKl1UuZlvaXFiv3/1b7qNskTIWzLRdNlVh8UcPjvGlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6815

On Sep 25, 2025 / 09:46, John Garry wrote:
> On 25/09/2025 09:39, Shinichiro Kawasaki wrote:
> > > +	echo "Test complete"
> > > +}
> > I noticed that the function above can be a bit simpler using TEST_DEV_A=
RRAY
> > instead of TEST_DEV_ARRAY_SYSFS_DIRS. The patch below show it.
> >=20
> > John, if you are okay with it, I will fold in the change below. Or if y=
ou want,
> > I'm okay to keep your code as it is. Please let me know your thougths.
>=20
> Yeah, it seems ok.

Thanks, I folded in the change then applied together with the other patchce=
s.

>=20
> Let me know if you have a branch you want to test with all your changes.

I did test runs using regular QEMU NVME devices, so I have some confidence =
that
my changes are good. Your confirmation test on the current blktests master
branch tip will be appreciated.=
