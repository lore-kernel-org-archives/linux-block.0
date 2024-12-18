Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AD158853
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522144; cv=fail; b=P3N5l/80rhOl4U0mDkpQvdOjtF7cQP9IUq2Xvfo/xKWAj6tdGYeVKcxXByOplhGkCaWMin8sz46r8MdedN5CV31u0ZFIjevWkAIr8SsOBK/5H2vBx67OJyH6cK2hIZA7rRAWofv8y/4jaXkOAcIhmFo8lgIIX4fQB5J55dotS/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522144; c=relaxed/simple;
	bh=ixbLy+ZSZsrSnBA9wqLlzR7eTikWowT/wWpQF2BxKUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4kqJxQF/K0oZMEg4CfNQclFIMSQWd3Fh4GSdVde8JIxr7KmwDc46Vh2DYPnKvRUDE1JbUomrqLZZWWmDP6rBD4PafLrb7vxYPyIyTkjBXLYrdr5Hq9donJ8UF0lolC0m48rUiR5JgQdaK5YvdsNwKpla1v3QAHPZH2JaU2gwVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VKAbU9lL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tcxvnjb4; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VKAbU9lL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tcxvnjb4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734522142; x=1766058142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ixbLy+ZSZsrSnBA9wqLlzR7eTikWowT/wWpQF2BxKUs=;
  b=VKAbU9lLStGuaw1l3sIETBlyGFp564H9hE6g1dd053hvsObdZtzlCpGA
   T1yQH2wVU6N6yjlidoPFP/SggxfaPgstLe+m7QCgL3//zdAGaS2sYjGk5
   7zZOFTjhdWT9M6v+MQraQPcSK7WrmSMMSNZF5Jo7WPM+YusnW91c+ROrY
   hvddAf1GMS98crXsc/PCXHO2PSiZ+DzXc8vFlImW74q6rjFDoVe2xTi01
   PIGGCom/ySeCaGQz/L2kMJKYeYum6qih6p76ReyAOoP4hNECeUQVVwCI4
   XK4fNskrFR7Z4b32pahcdp8NuFFFWHUwnBTF+tDr1TLIqwTcmGdOCANwo
   w==;
X-CSE-ConnectionGUID: lF/bpsr9Qke9eSGDMrBqNw==
X-CSE-MsgGUID: KmZfwD2mTV6KHmE+IT0Qwg==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="34662112"
Received: from mail-eastus2azlp17010019.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.19])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 19:42:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8tCwgA1cOg7rLaZxIL6DBqd/+jbpubg0phe8Ay7vGzZUWPRodlIw9UmFycWP6a10lj8zBSwItBib0OosxipT5srAU4GOErqjuz1GcmklsMybJu++v0n2pN9bbpIbEBKTE+7GwDS6LEyUEidt8XXVawT+MGgGR78K2Z2bm/QaXm0i48Dj9tvKsorq4f5wEQvhnDRcbIyrSGCmCtjxiiKEGXE0g3AWGhFUptxlcP5foXqdlWzSQduX81U6XuOdalCJdpuQrLp+Kyj7DG7aexLLeA8ILHG6AfnVnZXFcPVkrT9KNHOV2FtEmw0I1w8EyLC0//E4sLDT0560n5AT9NO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixbLy+ZSZsrSnBA9wqLlzR7eTikWowT/wWpQF2BxKUs=;
 b=Z1BnbPYn1hjzsSQLfhR1wL8oZXtVMhTy4DyEGVJhWNeDfhFbuiBgh4fe3BflipctaMkSXQEY1WAaAbuKs4G7hQdpXeyE8S+YUSW92h0Qqu3lEMM7/GaUaoU9gKBEcNeRkMDWOMbFZq6FALUKkYt0EAQ1gNyypSnOR7n5ONIHW69LRPD5f5tw1KdxGwTDHPSkMZYu64Sgn2xuCMkaXry1uVuIvijSluuMUkp+D/JV05Ca1fyL3Mh9bGQlnnJnnr70UiNaRMvHHvN5p7ZL13fEBdo3AkiLfBIDnVNHsRVSedKGcsFCjSm4qo1ocMuCnR+4q5acvF+mYsHHtSmJ/Zikow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixbLy+ZSZsrSnBA9wqLlzR7eTikWowT/wWpQF2BxKUs=;
 b=tcxvnjb40tU8Qh3m8Lh4UnH8kRm0Z2wn4xYgbvZRTI4GzWXcanaJPfrSj6XMKmqZqr9FbK7O6DwtjzKndopJRalVepsT+VXqbxtOaicLr1xkmLQpg1iCTFqJaODOJCiDqHEeTaoBV4JmlQZon51bmyusQ2GxkRzO3W5jpeqUyzg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9403.namprd04.prod.outlook.com (2603:10b6:208:50c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 11:42:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 11:42:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: Yu Kuai <yukuai1@huaweicloud.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
	"yukuai (C)" <yukuai3@huawei.com>, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [PATCH blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
Thread-Topic: [PATCH blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
Thread-Index: AQHbUIWwOucgQz/+E0qLPXLHojldvLLrRwIAgAB8gYCAAB85AA==
Date: Wed, 18 Dec 2024 11:42:19 +0000
Message-ID: <w4x77ozo6sf6g237mpifsgev76kwj3cyuscx4byircemr3zohs@mcqmfvkbqyrg>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
 <20241217131440.1980151-3-nilay@linux.ibm.com>
 <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
 <1cf36d9b-235e-4747-9c1d-ba2363800369@linux.ibm.com>
In-Reply-To: <1cf36d9b-235e-4747-9c1d-ba2363800369@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9403:EE_
x-ms-office365-filtering-correlation-id: 6e2faec3-667e-44d5-ad27-08dd1f59076d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmxnUEVvUTN0bTlpUWZ4YXNKNjdPb0E3bTBIKzdvSmViVVl1Zy91QWxkbUU0?=
 =?utf-8?B?R0VTMitJd01SRXpJRXBYVXBiZGQ3azQ5M3NLOThCbWxVazlZa2NVTUJKL1RK?=
 =?utf-8?B?NlRyaXdXNkRzV21FSU1LUzAwV3E4Mmd5TlY4ZjFlQXFSNkFuaFQxS2s0REFU?=
 =?utf-8?B?bFJLSkRPS3o5aGoyM3FscGlkK3k3bmxtRGpkaHE3amI5SFplMk5FK3lCYVM5?=
 =?utf-8?B?UTlvT2tQUmh6TVV4N0ptNzR5Q0NOeW9iejROU0VDV1E2S3VCKzVWeGk1Ym1p?=
 =?utf-8?B?a0NSeWgyTVA5dS9DQ2E5MWlWek1TYUhyRFc3b2dIQklFdkt6SHZHV1lVaUsy?=
 =?utf-8?B?eW1BdG4yUHRLRHZUS1FRMnpnV2tqbm51bWpHMFArd0NDSE1oMFUyRGgrQ2FD?=
 =?utf-8?B?K1MrOVZ2c3ZOQUxjb3NuQ3FNTFJjWFAxSGkrODRrUWZuKzRkWGJoYjJkcC9i?=
 =?utf-8?B?VW8yREo4WURUMG1nWUZtMkxieDVLMXhxQlI2aXNSWXd0S0V3VE1FTW5Tblo0?=
 =?utf-8?B?NStoR3VzYjBVMXVnbTVRTzE5WDBFcDRaUEdMMHlVb1BLQUJhN1lJcWRSeTNR?=
 =?utf-8?B?ZHhGam1rZmRPVmVQMFJpeDRlb1FOT2hZOUFOUTR6a0IyQjBZQlhmdjZiWmFL?=
 =?utf-8?B?WlUzbFpmazdqLzVUWkkycW5ieGQrQ2FZYTF6YlRzZVN1N01uejlTRktoYy9m?=
 =?utf-8?B?d0ZZdmg1UnBrUjlESytQeWFaQko4ZzQxdjQzak1mZ1dvRXFvSzA0eFpQZHZP?=
 =?utf-8?B?QVcvYUsxTzVodUhnT2taK0V3cXR5NnFYUXF4YVFIeGJJK1JFc2w2SFpmdlRx?=
 =?utf-8?B?bkhIZzhwMy9RMGt6bzZhSGYva1E4amtKOWQ5bFRENUM4Vjh4RVR5NTV2dUxx?=
 =?utf-8?B?LzQ0VUJlc2pnNS9nVy9QclpYQ3VwaklHckZ4ZVJ1ZlRsU2FPTWpZRVh1a0NO?=
 =?utf-8?B?SHIxQnBaS0NTbDBtU0NlOWh5MmU5ZnFoNExBQ3FYNmRTRmh2WlVIWkU2ZmMx?=
 =?utf-8?B?c29LeXlYQlJVelRBbDNLN0pxWkRydnRtMmRWOUlwZmlZck9VU0U1eTl3Qkda?=
 =?utf-8?B?U3VSUGh4QVF6RVZTOVhaeXROUU9TSnZqbHRuL0Vhck5WRTA3VUtwK1pkcUJz?=
 =?utf-8?B?STkvS0MvRnJHQjQ5Q24xYTdpdGhSZHZvUnNxcVg4TmZ3ZW5RRXVSZnBwVzUx?=
 =?utf-8?B?VXZ1TkwwZWFuaHpQUHFMUGJlVmNIc2hlWUFtdjZ2UmZ4bHNudGluSmw5U3di?=
 =?utf-8?B?OEQrTFY0QVpoNVhNRy9CMGoxb0F1cHRiVjM2OVNpUDhDR3JUYUhZWjJ3TEhw?=
 =?utf-8?B?aEVDWldNdG9GSlBGWERFWXpuZ2wxTzh1aVpnQTZZR1BaZXZzM29ETitkaGNC?=
 =?utf-8?B?ZUtCWGczMklsZXNMcVdJd2piVndGbmQvZjczc01DR3U3V2Y1RHZFTnphQm1M?=
 =?utf-8?B?Wmd2OGZqd2Rpb0lSOUZUMEwrT1VweGZTeEY5ODdEamhvTFlPdFpINjRQZ05C?=
 =?utf-8?B?aFBPeUpnMEdVbDZoVkdVTXB2UU5zUHExNXJIdFpTdW1DaFNIZkczTWpqdlhz?=
 =?utf-8?B?Tk5GcVpWTlgxL2Z4VUdHcHppY0o0YVJmb0hySlVmUDdLVnF1REdHU1ZVVTVU?=
 =?utf-8?B?Tm5URlpCMTd5a3VqTldXdFFpQmxDUWJTV0JBTG9RRlhUV1ZvODdoM1hZTE04?=
 =?utf-8?B?WFJGbzEydzJ2M0RQV1JvWjkxSmJtZUl1SnJYOGpzbFFMS1lHbVZnR2piWFFU?=
 =?utf-8?B?dVdpSHhqR2VSQUdzbE11WmlwMXZsRjNsM0FzMVhYc2dkOFN6K3ZDd1lnNTJj?=
 =?utf-8?B?TStrTTV0dExCT25rSDZEeUtLSVE2T2JmNnArVTBCS0k5b3dJMGt4N2NiZEhD?=
 =?utf-8?B?RE9PR2czTUtmUStmYWd1WUpOalhTL0pIajJjNEZzeXF5UjQrUStWNnJOK1E3?=
 =?utf-8?B?Uzd5UlErcXQyeGNyZDhoYzRGd00vODlWYk1RTjlsQ1NodHp4d0VnTXhlYXRn?=
 =?utf-8?B?L3VRdU5zU2F3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3RqTi9PSFAyMEkxVjhxK1ZsZWVuV2FScXB5dGpZMHhVYUlWM05XMWZ2cm14?=
 =?utf-8?B?YmtNZS9nTnV2R05xcU1wSTRDRzFsRGRPNjNFRW0vTWFOSkh5MWVyY05ZQzBZ?=
 =?utf-8?B?bzZXNkt3ODdoeVA4SmJCU0dkV2gxYnZSK3M1R2cwV3lIYm5xMHRlNm9CbWFG?=
 =?utf-8?B?WUxwcmdrRHlQaW1kRUZPbU04bG81RmlLV1pTbG9pNkJaL25zRmN5MFhaSzFM?=
 =?utf-8?B?OEFnSmY3R3JaVnQwY3YrWFVjWGFYN00zVFlvTEt4bHFnVjJrekEwK2RyZE4r?=
 =?utf-8?B?SXIwQkxmR2VEbnc4VTdwV2x6dHluVWs5OG1JT2F4cW9XcE9JSlg4czRaRFFK?=
 =?utf-8?B?OUVHLzFEMXg4dWZhN09TbjBmdFY2bXpacHk2ZC9seVl2bGg0MmdWVmpWR0pB?=
 =?utf-8?B?SzhyV3g2TWtxQldBNmovWHRmcjRuVDBUS29aS1ByS2k2VndnTUpMbTJZZTF6?=
 =?utf-8?B?aWx4UGE0RlhUdHA1ZDRWa2VkK3NHemJRYWdQWDhYVkpHbTQvSm5JZDZtRVhr?=
 =?utf-8?B?MnFpQUxuQlJmOFlmclZvRTYrVTljejVPV0VVMUxEQ3lKMDdkdldGR2FCQlRZ?=
 =?utf-8?B?RDBTeDRrakgxaVl3OWJHTkxNYWdJQ1ArVURra3hTYUV5ZWNWN2xqdHJHdTV0?=
 =?utf-8?B?QTg2dCtjcjZmSVE2Zk9USHc2SUR2RFhIMVJUUXdQLzNLUzJzc1JSY2ZXNlIr?=
 =?utf-8?B?eFM4MUtNTGZSMEx5UjBia3dHanhCZWhUTm1aN1dCWkdndmgzRlBTam1YcDEx?=
 =?utf-8?B?cjlBa0NvZTE4ckEva1pBUk9XQ2dkSmVyQ1gyZkdTZk1Oamw0ZC9DTlkzVGFv?=
 =?utf-8?B?SmxOWncvR2Vmdll2VlVEY3BPblBSN09qeVltSzRhdENYN1FrTVJyVTNQeld3?=
 =?utf-8?B?dzFWbHBrTExNNGxaWWtWQ2VKN3VuNWhEM3hsbG1sOXRBSzYvMnU5Y3dNY0l2?=
 =?utf-8?B?SFBDVFQvUjZoSUxROXM5Wk1zWHRWOXBDSzRyalJKMGhDdDNtald2REdQRERZ?=
 =?utf-8?B?djMwVVhuZUdURER5QTEybENMTkl2NURGYXlXZU1BY3VYQnQ3RWI3Z3Rhams3?=
 =?utf-8?B?YnhDcnhjNHZhdFM5V2llbFpqSlp1U3VmTTJwMXM3THk2cXdOd3RtVXREV0lC?=
 =?utf-8?B?aDdOcWloS2Rtenp0RnR0S0FmMXZxcVYyM2tGQWhJbDVycjYwclhNUVAvSmNa?=
 =?utf-8?B?cXZoaVJWNnBxTVZMeS95ZkNTUVhDUmtKSGozRUl4L1Z3dmlBT1lyemR0NlEr?=
 =?utf-8?B?TExzVVkvNzVNMGg4SWxPL3FGLzRMVDRWMVJWTTFPYXBYUVVyMWlibUE2U2NL?=
 =?utf-8?B?KzZVWlZRWWpjVG53WHBQU1hqNXcwajhJWmdhM1BUMFJmV3VkMXBFNGx3eVpt?=
 =?utf-8?B?elp6dnFYWWsrb3JvU0ZSM042L3hOdk9pNUh3bDAzYnhBM2YyVHhHSDI4RWJP?=
 =?utf-8?B?MXBZTWJJck1yclpwQ0drRVg1WDRqd245NkVYcXI2MElPTlV2V0c5L084WGNa?=
 =?utf-8?B?ZWQ4TTNJWC85QU44TXNQdjgxL3ZoNU5USy9KMnNUbFpiajFmMTM4RXVCbDcr?=
 =?utf-8?B?RWNiOUd2K3M5WHRGQXczREJOVFVXODZUd0hKSVFkNnp4Z3VOSkl5akFnUXly?=
 =?utf-8?B?WGFkS0ViSnVNYzNMMTJGcHVrTHo4V1JLQWc0VWY1V3JoOWl2dTMvVVF1dWNw?=
 =?utf-8?B?NnJuaDVyM1oxVERHYUczcTNnQ0w4ZXY2MDRWT3U3c2F1QXhoamc1R2NWNjho?=
 =?utf-8?B?bTVGZlZEUlFzamVnNlZ5Qi8rSGMyeXh3VTlSd013T0JObGk5NS9sbkxMMW5M?=
 =?utf-8?B?WVFqYjRKY29JNyt0K0NGMENRSktSdUJ5UUNsNjJRSjY5YkV2TERtdDZRZmdW?=
 =?utf-8?B?UE1OWkNpVzk2SjZHbk1TYkIrRnNvOUNyREpWVGZ0R0F3dVBQREE3NWlHemxk?=
 =?utf-8?B?M1FJRXVFMVBpMVFrTkxYclMrMmp6SUJpZHJPNWR3Z3FxNHhUeFdGd3ZtYmlu?=
 =?utf-8?B?QzdmZG83V1VsWHNEOFhjclMwRW5xcVJEVFAxaHlDWTJLdHdwSVNBbXJzbHhz?=
 =?utf-8?B?ZXBzUVpIdGhFQStLNmFJZDBFSS9hME1xbXNsNkVzbU9mL0Zlbzd2VU95aytG?=
 =?utf-8?B?ZWlTVTRKSksxZmR4NEV2QlFpek4xdlRhMjhJdWo5Rmh4TXp6bWNDencvNWgv?=
 =?utf-8?Q?aUm8JGpEpo/ZRLgTJijGILU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA886058051DFA45B929659FD7054168@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y+ww+f+0IhlkyPqpuxhmNN5tot7Fq0CR9Z2tC0tCqYTTPGpBviV9TRWWB5BlSorNKeJHFjko4xBpQ2zPSVnUupFnzhiqTRxJ409cRVbBiM/2Gsu605Sf7mU8S5Zk0k3z7S43VrMhSA2D5jQRLQwW2AfkhrrlGElxs55S7VZeV6C1yKfLeMN6ySIrz8/YtZT4f58s7OZInzu+BsDO7AXkv6B4znn8H5U7FvpgDAfeosvxlDmi802iN5TgyujY8NJDl+cDYAdDeY0BpRvqvKDHGLAC0azFhHHLBDLIe6kvLDPc7oovI+ySr7FyKlPcBbuUu8/YYlBnapJvtQZTTMm1A9SxbGUS3cTOH2faVbQfxujsxoi0a/MmL1Db0jSWXwOVy7tZxlJepkz0sgDOxmkz2oa9ARDaQR/UtHpfl0Xu7iSeEcNarvBxxI+Ulw8Lbf2h+5xeN8OK7MU3qn+GUzp2tSSj5UghFcfHUujxnJS3jRpcc/3KtkLlyQcX5GAD2a5Mv9F4oHkjDOZf5LOrYW//MRWaf3rguWNyZID4hiEo+YOPJzIywuLYHwrjA+Z1yICBN6FHyx5mLeDBcFZvi7bXK1IvUL2HNdUlwQhnH/tiIyjUyZneA+QFQYLZCxE4Ej7M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2faec3-667e-44d5-ad27-08dd1f59076d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 11:42:19.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txcauwGt2ontp7d6+1/tgLAMZx1j/bgqAT0h/NmwnrzzCqeiNnm6dg8gTVDme92YyyTb2VUADCnS2KGkXSt3TVDWAFBcBzS0pOowruosm2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9403

T24gRGVjIDE4LCAyMDI0IC8gMTU6MjAsIE5pbGF5IFNocm9mZiB3cm90ZToNCj4gDQo+IA0KPiBP
biAxMi8xOC8yNCAwNzo1NCwgWXUgS3VhaSB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiDlnKgg
MjAyNC8xMi8xNyAyMToxNCwgTmlsYXkgU2hyb2ZmIOWGmemBkzoNCj4gPj4gVGhpcyBjb21taXQg
aGVscHMgZml4IHRoZSBhYm92ZSByYWNlIGNvbmRpdGlvbiBieSB0b3VjaGluZyBhIHRlbXAgZmls
ZS4gVGhlDQo+ID4+IHRoZSBleGlzdGVuY2Ugb2YgdGhlIHRlbXAgZmlsZSBpcyB0aGVuIHBvbGxl
ZCBieSB0aGUgYmFja2dyb3VuZCBwcm9jZXNzIGF0DQo+ID4+IHJlZ3VsYXIgaW50ZXJ2YWwuIFVu
dGlsIHRoZSB0ZW1wIGZpbGUgaXMgY3JlYXRlZCwgdGhlIGJhY2tncm91bmQgcHJvY2Vzcw0KPiA+
PiB3b3VsZCBub3QgZm9yd2FyZCBwcm9ncmVzcyBhbmQgc3RhcnRzIHN1Ym1pdHRpbmcgSU8gYW5k
IGZyb20gdGhlIG1haW4NCj4gPj4gdGhyZWFkIHdlJ2QgdG91Y2ggdGVtcCBmaWxlIG9ubHkgYWZ0
ZXIgd2Ugd3JpdGUgUElEIG9mIHRoZSBiYWNrZ3JvdW5kDQo+ID4+IHByb2Nlc3MgaW50byBjZ3Jv
dXAucHJvY3MuDQo+ID4gDQo+ID4gSXQncyByaWdodCBzbGVlcCAwLjEgaXMgbm90IGFwcHJvcHJp
YXRlIGhlcmUsIGFuZCB0aGlzIGNhbiB3b3JrLg0KPiA+IEhvd2V2ZXIsIEkgdGhpbmsgcmVhZGlu
ZyBjZ3JvdXAucHJvY3MgZGlyZWN0bHkgaXMgYmV0dGVyLCBzb21ldGhpbmcNCj4gPiBsaWtlIGZv
bGxvd2luZzoNCj4gPiANCj4gPiDCoF90aHJvdGxfdGVzdF9pbygpIHsNCj4gPiAtwqDCoMKgwqDC
oMKgIGxvY2FsIHBpZA0KPiA+ICvCoMKgwqDCoMKgwqAgbG9jYWwgcGlkPSJub25lIg0KPiA+IA0K
PiA+IMKgwqDCoMKgwqDCoMKgIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bG9jYWwgcnc9JDENCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9jYWwgYnM9
JDINCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9jYWwgY291bnQ9JDMNCj4g
PiANCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbGVlcCAwLjENCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aGlsZSAhIGNhdCAkQ0dST1VQMl9ESVIvJFRIUk9U
TF9ESVIvY2dyb3VwLnByb2NzIHwgZ3JlcCAkcGlkOyBkbw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbGVlcCAwLjENCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX3Rocm90bF9pc3N1ZV9pbyAiJHJ3IiAiJGJzIiAiJGNvdW50Ig0K
PiA+IMKgwqDCoMKgwqDCoMKgIH0gJg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyBh
bmQgc3VnZ2VzdGlvbiENCj4gDQo+IEhvd2V2ZXIsIElNTyB0aGlzIG1heSBub3Qgd29yayBhbHdh
eXMgYmVjYXVzZSB0aGUgaXNzdWUgaGVyZSdzIHRoYXQgdGhlIEBwaWQgaXMgbG9jYWwgDQo+IHZh
cmlhYmxlIGFuZCB3aGVuIHRoZSBzaGVsbCBzdGFydHMgdGhlIGJhY2tncm91bmQgam9iL3Byb2Nl
c3MsIHR5cGljYWxseSwgYWxsIGxvY2FsIA0KPiB2YXJpYWJsZXMgYXJlIGNvcGllZCB0byB0aGUg
bmV3IGpvYi4gSGVuY2Vmb3J0aCwgYW55IHVwZGF0ZSBtYWRlIHRvIEBwaWQgaW4gdGhlIHBhcmVu
dCANCj4gc2hlbGwgd291bGQgbm90IGJlIHZpc2libGUgdG8gdGhlIGJhY2tncm91bmQgam9iLiAN
Cj4gSSB0aGluaywgZm9yIElQQyBiZXR3ZWVuIHBhcmVudCBzaGVsbCBhbmQgYmFja2dyb3VuZCBq
b2IsIHdlIG1heSB1c2UgdGVtcCBmaWxlLA0KPiBuYW1lZCBwaXBlIG9yIHNpZ25hbHMuIEFzIGZp
bGUgaXMgdGhlIGVhc2llc3QgYW5kIHNpbXBsZXN0IG1lY2hhbmlzbSwgZm9yIHRoaXMgDQo+IHNp
bXBsZSB0ZXN0IEkgcHJlZmVycmVkIHVzaW5nIGZpbGUuIA0KDQpIb3cgYWJvdXQgdG8gcmVmZXIg
dG8gJEJBU0hQSUQgaW4gdGhlIGJhY2tncm91bmQgam9iIHN1Yi1zaGVsbD8gSXQgc2hvd3MgdGhl
IFBJRA0Kb2YgdGhlIGJhY2tncm91bmQgam9iLCBzbyB3ZSBkb24ndCBuZWVkIElQQyB0byBwYXNz
IHRoZSBQSUQuDQoNCkkgdGhpbmsgdGhlIGh1bmsgbGlrZSBiZWxvdyBjYW4gZG8gdGhlIHRyaWNr
LCBob3BlZnVsbHkuIElmIGl0IHdvcmtzLCBpdCB3b3VsZA0KYmUgY2xlYW5lciB0byBmYWN0b3Ig
b3V0IHRoZSB3aGlsZSBsb29wIHRvIGEgaGVscGVyIGZ1bmN0aW9uLCBsaWtlDQpfdGhyb3RsX3dh
aXRfZm9yX2Nncm91cF9wcm9jcygpIG9yIHNvbWV0aGluZy4NCg0KDQpkaWZmIC0tZ2l0IGEvdGVz
dHMvdGhyb3RsLzAwNCBiL3Rlc3RzL3Rocm90bC8wMDQNCmluZGV4IDZlMjg2MTIuLjBhMTY3NjQg
MTAwNzU1DQotLS0gYS90ZXN0cy90aHJvdGwvMDA0DQorKysgYi90ZXN0cy90aHJvdGwvMDA0DQpA
QCAtMjIsNiArMjIsMTAgQEAgdGVzdCgpIHsNCg0KICAgICAgICB7DQogICAgICAgICAgICAgICAg
c2xlZXAgMC4xDQorICAgICAgICAgICAgICAgd2hpbGUgISBncmVwIC0tcXVpZXQgLS13b3JkLXJl
Z2V4cCAiJEJBU0hQSUQiIFwNCisgICAgICAgICAgICAgICAgICAgICAgICIkQ0dST1VQMl9ESVIv
JFRIUk9UTF9ESVIvY2dyb3VwLnByb2NzIjsgZG8NCisgICAgICAgICAgICAgICAgICAgICAgIHNs
ZWVwIDAuMQ0KKyAgICAgICAgICAgICAgIGRvbmUNCiAgICAgICAgICAgICAgICBfdGhyb3RsX2lz
c3VlX2lvIHdyaXRlIDEwTSAxDQogICAgICAgIH0gJg==
