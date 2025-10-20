Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6811E9919
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956088; cv=fail; b=m/dU+1WuEiYxSzhyRebW/2WoQ/ntV7Nt456vIf71so8arRxMaQZRCEtPv3Hev3vAcjuowbo4RiHHpvf2adjQCYFrNftgwt98bJruSKfn6+9xK1/YpZhn4DWqwzS5dGmRkZVAudB2zU7PRwfqlXdFZY0LW5FLhjTEajxWVdXILME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956088; c=relaxed/simple;
	bh=MTuYM+520zaUKxCNY9Z/GOaO1I6s9n0s9SK3/RJ3758=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u8y3SAfmzGsYmY1IxLfy1gwoN8996AtYbwqyx09F+EEQ0imoRvNSxBWCwM4UpcMjc7vKz6/AYGqPJo8z7esUvgaKz/VdvRjt++HTV2/s3yaPq0pVWllnd0QldvV3dakdJDHf9NLOIW21yZf3B2lzA8UoRoDcOpOHeTx8l4opMYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UB4dFXTQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hmgSJ4/Y; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UB4dFXTQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hmgSJ4/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760956086; x=1792492086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MTuYM+520zaUKxCNY9Z/GOaO1I6s9n0s9SK3/RJ3758=;
  b=UB4dFXTQizc9hdvQZraiM+LaCuUuxgHo2W8xgWWeRijh/v4ocpkp7EoD
   yercpJHOzDnWL+ckILvJQsIaiIeynls1NK0IJXad+kKeDEuS+BJ4DP2jR
   6HiCCltyjSMONpYd+spRi88Bo+uRBjb1Wjo/BZ/KsIB9VDwlV3X8UMIw5
   RJIIyNbtEgoKhsGCiyGdqthLbw4OKB8HhWW7f2UeLjcYzAYZX7T2T30YK
   E5dMJjTs3HAfZuPL82cxhajoPbLgXwvR18YR9PI+6rweUCdzmyF+sacMi
   AQkrBRJz9Cn7ezoeOVzhfKfjZSr9J23aJYrn4JPkNIUkZMjE5+HgkRshY
   Q==;
X-CSE-ConnectionGUID: jJCwMsUkQWSuvCdpxOXlqA==
X-CSE-MsgGUID: DP0HsD1sQgOaMOw5Nv14NQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134798293"
Received: from mail-centralusazon11010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.0])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 18:28:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI9UT2p9YEOxwpz0cbs4TjgByNwIYetz20JuWLO0yc88cYlLKOdELnZ8dzbl565cvb9UH1K1rX62nx1owxP+ChA88Ua8jUOhMvdEpfA5x7W342YJR3oX1EotKN5FwpYKzGK+2H2nDaUnzDSlyqLLbLeAEgAFobudP1j/wfffYYlQB0mEdUpqQ9OYAnGKrfoYQoZ+KWqgFh6tn2uHzo/qnvvqpy3/MFyDNVxqQNdnmx9frjxWQcgmZTYDf3irP7P4IILxCG8J+DXjeMwg4IWjpanSj/WPs7+3QsQrOlkAp6LnU1ecF9a/USMROP1ltJrjpzPzDNK6b5Ew788TR9mHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTuYM+520zaUKxCNY9Z/GOaO1I6s9n0s9SK3/RJ3758=;
 b=OT+BL7sBOAF3Je+ul4mwVhz0ttcyDOCtroCa8oISrrCp5LK8xRav63y+0ufHxoj2w3Mn8t1tRm3zm4ZPuhZK4ZQiaZFxfTDLk62EDGFsflWEXVXwlJkZkojiRuRzcZfvDWllvGT3Wfx8br8HSEdl2w7lrayKGwi53ebjT0dsQldjhjA8T8dxDrWFWQVxG9Y+DlteGRT5a5f3/xaM1kA+7Kc8cdsrIOwN/jp4PDD6Cvqg6HJvDR/ac0NTJ/U9s2Mj4vCHcybLnMMiQxZdtexQalMslaAJPpW2Z7Hrs3JtjN0SkUQMAyT7NqQkb7IVNOFF1P5Is3Zd+cXyaYOiNhXsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTuYM+520zaUKxCNY9Z/GOaO1I6s9n0s9SK3/RJ3758=;
 b=hmgSJ4/YKKSnmn3a5emPe+cUIa31TPvOoqodrFYaULR6MuBE1GtBHhn979emMiMKrtbhuWvtYz27Ci6yzH9K4P8pyOymnWbyaqyisJGwpZZzCoZ2ryuTlvqLvsaol1ouo9R1s6sJgvokJURp4U3E397fpSRuAWN845UTtJMReZs=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV3PR04MB9321.namprd04.prod.outlook.com (2603:10b6:408:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 10:28:02 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9228.010; Mon, 20 Oct 2025
 10:28:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "yukuai (C)"
	<yukuai3@huawei.com>
Subject: Re: [PATCH blktests 0/4] throtl: support test with scsi_debug
Thread-Topic: [PATCH blktests 0/4] throtl: support test with scsi_debug
Thread-Index: AQHcOb6rKcDxJwmsaU2VRuZRljNVlbTBQk8AgAmin4A=
Date: Mon, 20 Oct 2025 10:28:02 +0000
Message-ID: <la3nxvrf7eqcry7ypc4hrf4234kqfayip2w2wa3fkmtpx33nmg@xsqtbbqhaxku>
References: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
 <e7f5e12e-5409-cb78-9990-f4c0b3142cc9@huaweicloud.com>
In-Reply-To: <e7f5e12e-5409-cb78-9990-f4c0b3142cc9@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV3PR04MB9321:EE_
x-ms-office365-filtering-correlation-id: aa14167f-c002-43bc-d755-08de0fc3595c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021|7053199007|27256017;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlZyVkhRbklqbXJ0S2FHRHFpZ3RYV2NYMGNDemMzR2ZyOHVqa2R2Rzhnc09s?=
 =?utf-8?B?aWRvNFBpdzlralRFRlpCZWhHTVpUbVR6NklJVkUvRUdYWmVpcmwxeGJRVGJD?=
 =?utf-8?B?dFNYbW56eVk4SE1lZW5PQ3Z0ZFhqc1M1QTJ5K2pOQnFLUkMvV1ZhaTJmTTBx?=
 =?utf-8?B?a2txUm53cnpoaDZIN1FUZElxejBwY3J3TzBtUXBXc1AxbS9iK3VTTldpZUdI?=
 =?utf-8?B?QUwrbHh4WlZGbzZ3Q3pjNWo1ZHhYTUYyUjYvbDdDUzRLdVRnZkhCdWN1OThJ?=
 =?utf-8?B?Sm85eEJaNUVBSk5nM05Vd2J0Rld6SFpyRExhRzJrUjUvZVpkZ2w4aGdhM1ZW?=
 =?utf-8?B?WHFrcnl6TG9KNjFza0ZGTmxPdm52ZXhCV1lSVVF1Zmg4T3N0U3VPN05DUWYw?=
 =?utf-8?B?cytRWkVkaTBlNTAwN3dqcThxM3FCcmZ3M0lLYy82N29lbFY4VjlrRzlaZk1Z?=
 =?utf-8?B?R3doQ0Y3Qk1WRURWN0FHM1FPb3hlaDBRK09tNWVxak42aFBrVWp2Y1I4d2Iv?=
 =?utf-8?B?YkVYV0Zaa0NaNnRsRlBJaHFwMDlYbVo0bkNWZThjQ1FvRjUvOU90ZDZJWFpz?=
 =?utf-8?B?cHhUdm82RC9SeFhZNW1ud0dWK0l6dFNNbGRrVUpxckh6eXVIM0ZOL0JFanZ0?=
 =?utf-8?B?SkV5bXhHdWNnYUs5akNCUjNhSW9vR2hNZEQxMmUyc3h1TWhmdmRTUlpEbVNr?=
 =?utf-8?B?WHRPd1RiOHQ2MW9IbDVCOGFnL1RCRlkraWZQY1hSU1IzbFNOTThLQURTK0NK?=
 =?utf-8?B?Rnhrd1NJSThDUG00Nkg4empFeFJBb3p2MFdCRUt0T3lPZ1hLZmNHdkhMWkMr?=
 =?utf-8?B?UElJZ1F2aEFBZXZodGpBeFA1V1hhN1h5UlZKTGtGT2UremxwRHIxU2hINGkv?=
 =?utf-8?B?WllTNmdvY2N4VkdYaDVoVzJCalRoeTJnMy9TRXdwdzduMkFCZWpCVXhCaXA3?=
 =?utf-8?B?L1Z6WURsY20zeFI2TlFOWldyZG5NMmJ2blo4NTFTd1QzSlNRL2o1Wm51cVFG?=
 =?utf-8?B?c2wzQ25FcGhQcFd5QlJpSFcvR3cwMVVhVFcxNi9paXNJREdYRGFkNDVnbDZT?=
 =?utf-8?B?WHZmbjBvZk1Uem9LcCs1UWtCemtUZW9TWFJRMC8zZEx5M1hQN1JDQmNLWldQ?=
 =?utf-8?B?elBhOENzRW9iSTRqRVI2Yi9hNExIbVQ2U2ROeEhWbkQ2eVRGdmFNbVBCSS91?=
 =?utf-8?B?TERuQUplRjRlUnhZWGZWeUdnVXkwd1FwUWV3VG4yeWZJemNKMjNlZVd6QWh5?=
 =?utf-8?B?WllqOS9SNWFQbGJNdjJwdHZwUm0vZWlSMkhIVUcxL0hvOFgzL0k2YmpUVTZ5?=
 =?utf-8?B?bjBxcmkxdklwbzFGTVlpTmcxTWc4RFhlVjJoMTZsUjRWV2xIbXdEUXpJaURK?=
 =?utf-8?B?Q0lRVnNUYWZObWhmZmgvOHpIcjhGNWh5bUhGOHpMWVpQdnl1a3hSMFFJWlE3?=
 =?utf-8?B?SUozRngzNGg5MGFEcnNHcTFBdWdXRVpMS0d2WTN0RmhxNjQ2SFdnTnBOdmN0?=
 =?utf-8?B?bW1KUTR4TWZEdUt1TDdKTVUyUjdQY1ZmbzdGTHNMZnBkUFJya0lESkMzOWIz?=
 =?utf-8?B?dm1UZ2ZsdXhRYkpYWUwrL3hqZEo1V29iLzVWRDhtcUlrV0NkeWpaNnNaSVRE?=
 =?utf-8?B?VFZJeC9reUlDeFlpYmdtck85T2t6cHlBRG9XaFFpeUQ3RklQREh3SmtEMytZ?=
 =?utf-8?B?TEZiZjdTQW40ZkZ5QlVINlFQRTc3TEdTWldzR1BvU3ZvZkhvaUEvK1Jwb2FB?=
 =?utf-8?B?ZXlKZ0RXTWJBTWt5UkMySGw5MFJNV05HOTBWVlA3UHBYbUpKTTVFVXh3L0lV?=
 =?utf-8?B?cTdxd0hCM2lXVVRmTkZ3Zm43RUJZSHgwMlJWZkJCWkd5ZkZ5T3k0eUt3cU16?=
 =?utf-8?B?LzVDN2F1VElhNTJPcjVCRTdTSm1YUlRDcElDM0VMQWNDYUZqUDB6VjEzZjdW?=
 =?utf-8?B?MEkzRk5HWW1MVm5qZVJDUlY5c0JISlM2R2tMZmExcFRhWjBQRFl3RGpGRGFJ?=
 =?utf-8?B?ejJwdlUzZDgzYkJDcEttV1Vzamg4QjlWZ0tRT2Z3MUcwZllNZ1lYQmlQbmkx?=
 =?utf-8?B?WVd4eDJtakJUbmtkdTRjbWJYdXdQTTRyTFJjMGk2Tk01Vmg5RHI3dVY4TTlW?=
 =?utf-8?Q?okxk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(7053199007)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTNDYm55Szd2Wk9uL0NXRHFXOVRoTEVtZkVSdjEvd1hqY2ZVU3ZGa1pyTWx3?=
 =?utf-8?B?aVFkVVFDRUplajM0SG5Rdk1aQ1Z3V1V4Vlp0SVU1cWJCdU1PR1Y5ZjZMeHZJ?=
 =?utf-8?B?S1JGSFpJNllndmlLWmEydjlZaHV5SGZEVjNLdkdLV0gxcVZBNTJKWUlWQ2N5?=
 =?utf-8?B?TytNK1ZqYkZzUTJWdDhYRE1iZlVJUDNvYVdDYkt4QlhtVVllb2E1RkVzOW1j?=
 =?utf-8?B?YUJBVElUeTRuVGpwNlN4YlZYcENkY1pFSm0rMlUvQ2RrdVgvK0hjTjlPYUkr?=
 =?utf-8?B?ekhQZm5rQ2NWSmo1VEs5Z0pSMlJ6YzRlMTBqQXRhRzdrUWV2alRwNDU4WHBh?=
 =?utf-8?B?cjMrL1ZjUy90NnFVa2RIdWxrVk1velA4T2gveHRCdnN5Zjh4Mlh5cU9QaFBv?=
 =?utf-8?B?TnVpVXl1MlVCOXZHdSt0Nld0eDVGbEJzYTF3Q1RubXRuOGUzM1ZhM1VWMlRF?=
 =?utf-8?B?Ti9wbWZ2dzhhL05UdDIyN09Qek95OXdHWkJ1Nk5tQURxRjhoWHpPQzJDVGZl?=
 =?utf-8?B?dGptcS9ueXRrMy91QnVuN2pNaUJHRVdEZ3VTMkI5REhkRThhbHlyb3ZrVE03?=
 =?utf-8?B?ckswZjBtalN2RWhaMXBkMHNCYlJPN1NTeFBOTnRQNFRDVmVRTVRyOWxBM05m?=
 =?utf-8?B?WEpKVnBYY09XMVR2Vkk2VnpnRzluZHlic0V4YTdoOGJlUS92ayttcFNlRVdW?=
 =?utf-8?B?WDdRT2l3RmJTVWs3VXQ0d0RKczlLWGNvNUR6b0RyUG5ZVmdPRXd3V1ROSitL?=
 =?utf-8?B?WDVIY3Bpa3AzY3RzNW9sQ0NqcGp0WW5mazJOM3pNVzNGZVE2WWhmVDNvMlZv?=
 =?utf-8?B?b1ZyM3ExRktJbmxZcndQOVhZQ21WSkR4RkZVQnBHOHJqMG5BTHRlaEJMdVJ1?=
 =?utf-8?B?Z0k1MUlQdFVqQkhMbW0zbkI1TCtFYUJOdXlYZC9yellaOWtCVlFqaEQzTGxo?=
 =?utf-8?B?bTBiVFptaHBZeW1vaXVRUVd6MnFZdGNwc2RwYUN2YnFQYjArOGNlcm5SZ1hq?=
 =?utf-8?B?ZFpFZFMzVTVFOFovY0pMTmlZUkVRLzdXWDBPajV6bjd0WmlUMmVva2VDODFi?=
 =?utf-8?B?RXJLemRsaWkwYThUMG5sWVJZRDhVYlFtTVkvOWJZcWtnU0tQZGdrT2lzZnFO?=
 =?utf-8?B?dmhEUk9QYjZYRjF4b2dsdi93K0dMZ0NoQmhOZHllSUR4b0tZdkc4SkRqY3RI?=
 =?utf-8?B?MG5FWFBSSlQvUHVjbnVkTkNnWlQ0YitYZUxHKzAxZVI2UDVSY3F2TG5jUEU2?=
 =?utf-8?B?Zk1tcGtMdmFjQnpCMGg5MDFZeUNINU5JaFhESFFtczVSVmgvbWJWaUpyNjN5?=
 =?utf-8?B?UjlQL3lkbjFUWU5RSXlOUUhtc2dTcEE5TERtWHBHRDFyRnB6S3J6cmJ2OXZs?=
 =?utf-8?B?RUNyK3E5dEs3L1hhU2FGaG0rZ05qbURUNWkxMWl2MHQvU1J0cDV4UUNGcmR1?=
 =?utf-8?B?MDNPQTE1cDA4eUFLOXhLVFZBLzZzWUdtOTZJYXJqUlFCbFBqUFZMbThSOVh5?=
 =?utf-8?B?QnhyWGJHd2cwamhmRjV6ZzM1ZHIvdW1nNHJ0NGpjc25tMmVraTBXNDl4VlF0?=
 =?utf-8?B?K1dXQnptNEJVZHZqNXRMQmFuc2x1MGxFb3hxcjFUdXFUeWV0WWRJM1ZNZVA2?=
 =?utf-8?B?N0JkVHZLaWlyN2o2Vzk0cWJkTncyQTFkN3U5U1M1b2RTUThuMnhEVUxpUjZV?=
 =?utf-8?B?N0lMUXA4amhLUGxDL1FUNmN3MUNUcnN4azJ5eE9mU0pKMGY5YitqRVNCWHpi?=
 =?utf-8?B?czZRYU1aMDVwVkVIMFp4NW1LdFhPSUhRcnhaTkR4VGlxMkZ1RHlKckxWY3hp?=
 =?utf-8?B?T05KaXFOSzUwM1EwdCtGRm0xVG1RUXRKeXNEZkMxdHJ3SmgxZklUTU81MDk3?=
 =?utf-8?B?VTlUMTVrWitzNHcxTGlBU0Q5aHBIVDNXRXFjeWZ2ODVpZkcwUFdlVEUxcFNB?=
 =?utf-8?B?MXRMTzhhY2pMSW8ySVlyOWdmamV6TzFuTGJXMzhyY0lKNE9MbFB5TDU5M1Ba?=
 =?utf-8?B?VlVyK2hWNTc1NGd1VUpFdEduN3pFajkyWkR4TCtaU0NvTCsxRldYV3FReVNm?=
 =?utf-8?B?TmsxVUdwdFI5dy83OWJqNnBhdEl4YVY4dWlYYU9rdHJiSE4rTlh4MEF2MzNj?=
 =?utf-8?B?NzZCNUFNV2oweHF5QXhkTko0K0VCVDZQbXJqRW9QWTl5cFluZVppdm9uU3No?=
 =?utf-8?Q?NVYpf2plLdTrwUtnXzj6s6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E5325E57F214541BFD18316FF817C1E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cNHSGcT4oIeyO++esC87KYx5nDIJqZJulYGUC6qLdA2ubA5LXeg8QuIx0FvsUkOAf4YLEw9Cir5stRtVEt6FcjGgOmAuMiS1Mf68JWJ1NgmKNBQD9U5lpF+GIKxwK/tg1kPRVy8mNNEPyc7oOcpT25Rj73Eukp3NRi4+w6cXxMdMLl/uTbBFrjWHENCY8b7gv9SAkShN4LpD0zIQD2xGhjB5W37vLaktWe3GicKoNEVYxwOq32DBz6uKWZfsc3dFo2bCBukqBhwIQhntIgkboxCbiWo1yKuY65xWHdEEcUCXyti8PRCZuc0xN7Rwbc1BJUW/PvHpx+YS9NUO/Thl+/3BZm9FWJ0zLY1RiuVhVHkAV0r6mJKUKJB0Z09hmpyrJE81eZM5sZObzCXP4eetHLqYF1kGbfv+d7IZvV4KIfWXNpI3FeThcfwdR03BqtcNLEQ/FsdpMpsVwqIblA/itUp/FtoOTWuMXOfmf6yABOZOUODRzODOjdKljOqTV+d9fmaL0ltqFCpLyfWnpjc1qdCyFBwhVu6iQh0TLHPxHV0HfnXXf6G3uj1DUSZkHRP6X4ZNi0vb/6LXwIT1k2xaqAWKwrEuC2OGssRkhNSRubMf7lU2YvAQwbaW2xQAO6Ht
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa14167f-c002-43bc-d755-08de0fc3595c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 10:28:02.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isp/f20wsZtR48/sEEAuz5RjMc3YLJA1ECvYv5h48jxsud2sbOEi0saTm0ufRabS/PSiJoZ83W1tw8WWZse5qjWat/d1VfyCvvyGYACdXho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9321

T24gT2N0IDE0LCAyMDI1IC8gMTU6MTksIFl1IEt1YWkgd3JvdGU6DQo+IEhpLA0KPiANCj4g5Zyo
IDIwMjUvMTAvMTAgMTY6MTksIFNoaW4naWNoaXJvIEthd2FzYWtpIOWGmemBkzoNCj4gPiBDdXJy
ZW50bHksIHRoZSB0aHJvdGwgdGVzdCBjYXNlcyBzZXQgdXAgbnVsbF9ibGsgZGV2aWNlcyBhcyB0
ZXN0DQo+ID4gdGFyZ2V0cy4gSXQgaXMgZGVzaXJlZCB0byBydW4gdGhlIHRlc3RzIHdpdGggc2Nz
aV9kZWJ1ZyBkZXZpY2VzIGFsc28NCj4gPiB0byBleHBhbmQgdGVzdCBjb3ZlcmFnZSBhbmQgaWRl
bnRpZnkgZmFpbHVyZXMgdGhhdCBkbyBub3Qgc3VyZmFjZSB3aXRoDQo+ID4gbnVsbF9ibGsgWzFd
Lg0KPiA+IA0KPiA+IFBlciBzdWdnZXN0aW9uIGJ5IFl1IEt1YWksIHRoaXMgc2VyaWVzIHN1cHBv
cnRzIHJ1bm5pbmcgdGhlIHRocm90bCB0ZXN0DQo+ID4gY2FzZXMgd2l0aCBzY3NpX2RlYnVnIFsy
XS4gVGhlIGZpcnN0IHR3byBwYXRjaGVzIHByZXBhcmUgZm9yIHRoZQ0KPiA+IHNjc2lfZGVidWcg
c3VwcG9ydC4gVGhlIHRoaXJkIHBhdGNoIGludHJvZHVjZXMgdGhlIHNjc2lfZGVidWcgc3VwcG9y
dC4NCj4gPiBUaGUgZm9ydGggcGF0Y2ggc3VwcG9ydHMgcnVubmluZyB0ZXN0cyB3aXRoIGJvdGgg
bnVsbF9ibGsgYW5kIHNjc2lfZGVidWcNCj4gPiBpbiBhIHNpbmdsZSBydW4uDQo+ID4gDQo+ID4g
T2Ygbm90ZSBpcyB0aGF0IGN1cnJlbnRseSB0aHJvdGwvMDAyIGZhaWxzIHdpdGggc2NzaV9kZWJ1
Zy4gVGhpcyBuZWVkcw0KPiA+IGZ1cnRoZXIgZGVidWcgZWZmb3J0Lg0KPiA+IA0KPiA+IFsxXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDI1MDkxODA4NTM0MS4zNjg2OTM5
LTEteXVrdWFpMUBodWF3ZWljbG91ZC5jb20vDQo+ID4gDQo+ID4gWzJdIGJsa3Rlc3RzIGNvbnNv
bGUNCj4gPiANCj4gPiAkIHN1ZG8gYmFzaCAtYyAiVEhST1RMX0JMS0RFVl9UWVBFUz0nbnVsbGIg
c2RlYnVnJyAuL2NoZWNrIHRocm90bC8iDQo+ID4gdGhyb3RsLzAwMSAobnVsbGIpIChiYXNpYyBm
dW5jdGlvbmFsaXR5KSAgICAgICAgICAgICAgICAgICAgIFtwYXNzZWRdDQo+ID4gICAgICBydW50
aW1lICA0LjQ3OXMgIC4uLiAgNC41NDFzDQo+ID4gdGhyb3RsLzAwMSAoc2RlYnVnKSAoYmFzaWMg
ZnVuY3Rpb25hbGl0eSkgICAgICAgICAgICAgICAgICAgIFtwYXNzZWRdDQo+ID4gICAgICBydW50
aW1lICA1LjI3NnMgIC4uLiAgNS40MjZzDQo+ID4gdGhyb3RsLzAwMiAobnVsbGIpIChpb3BzIGxp
bWl0IG92ZXIgSU8gc3BsaXQpICAgICAgICAgICAgICAgIFtwYXNzZWRdDQo+ID4gICAgICBydW50
aW1lICAyLjQ3M3MgIC4uLiAgMi41NjlzDQo+ID4gdGhyb3RsLzAwMiAoc2RlYnVnKSAoaW9wcyBs
aW1pdCBvdmVyIElPIHNwbGl0KSAgICAgICAgICAgICAgIFtmYWlsZWRdDQo+ID4gICAgICBydW50
aW1lICA1LjU0MXMgIC4uLiAgNS43MzJzDQo+ID4gICAgICAtLS0gdGVzdHMvdGhyb3RsLzAwMi5v
dXQgICAgMjAyNS0wOS0yMyAxNDowNTozNS4wMTE4ODU0MzkgKzA5MDANCj4gPiAgICAgICsrKyAv
aG9tZS9zaGluL0Jsa3Rlc3RzL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXZfc2RlYnVnL3Rocm90bC8w
MDIub3V0LmJhZCAgICAyMDI1LTEwLTEwIDE2OjUzOjM5LjAzMjM4MDg4MyArMDkwMA0KPiA+ICAg
ICAgQEAgLTEsNCArMSw0IEBADQo+ID4gICAgICAgUnVubmluZyB0aHJvdGwvMDAyDQo+ID4gICAg
ICAtMQ0KPiA+ICAgICAgLTENCj4gPiAgICAgICszDQo+ID4gICAgICArMg0KPiA+ICAgICAgIFRl
c3QgY29tcGxldGUNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLCBJIGFkZCBzb21lIGRlYnVn
IGluZm8gYW5kIGNvbWZpcm0gdGhhdCB0aGUgdGVzdA0KPiBmYWlsIGJlY2F1c2UgdGhlIGRldmlj
ZSBtYXhfc2VjdG9yX2tiIGlzIG5vdCBleHBlY3RlZCBmb3Igc2NzaV9kZWJ1ZywNCj4gd2Ugc2V0
IGl0IHRvIHBhZ2Vfc2l6ZSBmb3IgbnVsbF9ibGssIGhvd2V2ZXIsIGl0J3MgNE1CIGZvciBzY3Np
X2RlYnVnLg0KPiANCj4gY2F0IC9zeXMvYmxvY2svJHtUSFJPVExfREVWfS9xdWV1ZS9tYXhfc2Vj
dG9yc19rYg0KPiANCj4gSSBkaWRuJ3QgZm91bmQgaG93IHRvIHNldCBtYXhfaHdfc2VjdG9yc19r
YiBmb3Igc2NzaV9kZWJ1ZywgaG93ZXZlciwgd2UNCj4gY2FuIHN0aWxsIHNldCBtYXhfc2VjdG9y
X2tiIGxpa2UgZm9sbG93aW5nOg0KDQooc25pcCkNCg0KWXUsIHRoYW5rIHlvdSBmb3IgbG9va2lu
ZyBpbnRvIHRoaXMuIEkgY29uZmlybWVkIHRoZSBzdWdnZXN0ZWQgZml4IHdvcmtzLg0KTGF0ZXIg
b24sIEkgd2lsbCBhZGQgaXQgYXMgYW5vdGhlciBwYXRjaCBhbmQgcG9zdCB2Mi4=
