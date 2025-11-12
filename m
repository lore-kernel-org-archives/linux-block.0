Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919E221275
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923750; cv=fail; b=rRi99FKCbFZJS6YxlyvTiLKKBFvZFOi+AYRfLLeHT7KhlgQ2T1LcyooYW7bpCpCkNHtAAfg7LrOK8AkhpSPjOmQLqJB/ae4dxpAbWyxv3RxXS+SqiLAhHWhQy/tfdTQAmEooWfm+ZiexSJxlwIm27Q7lVt07J9JCs1bGCXqvHXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923750; c=relaxed/simple;
	bh=vjvczehkNhSCpOftEF/xYE8m/RDApQjJRHizVuK0W0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NGzEq607PYuTg3mxm7mi06zCO1Vm4GOsfHJAOZwrNKYQznL/vnU0Qe5+AJ8/NWWR5s7DW3AXo7jE2mwcPgYBFO8PqvaAuE32DPNVwLHFqujcC5f9bdCFwTbnx6LTGHfvcWnzaWyB9Q+ll1PgbjrompLs0RMMD0SIHVZ/Aoo4mDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HYrAl3nM; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HYrAl3nM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlNvJUkt+QKHFJDSSA98XddZ+EJxUZfZ8HtIgb1BHr+IWubOvMwabR8GseH03NdWNa/gVrUlfWtPs1bveCIvssJMRKdFoBt41RgI1O1c/jXGOPf4ZWgZmjGulgsXUfxwqjcvzfbmkLLYGozrTAnsoDw5IdYMiOvz71JAmGByKO/Jdk5bR5Wgo43FSzaX37BebpC9KQ5fI8f82GH4ug2miqX9x3wndfrfnDxd6Xp1S9tpgml6Rx8eWqR/+SMVLzJTzjSCTcYbEdVfEnPnQS8UyMhTVPVm402SVKTNMGUt1K5/f/+4djky6a8VrO2Bl/u185rGuc98mnsHZFwhP5cgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjvczehkNhSCpOftEF/xYE8m/RDApQjJRHizVuK0W0g=;
 b=rG9q9efuST3Aa0K+PZKE26kd9LWAit95kdFUtCegDAYj2pQhPAe1jM3DDCwzlS/rNRHqbvtAATXMEZkdG529qGCpvgzMYPJBTOEfcUilzpvhnrV+v6wNjXT8sYvMFig9yX81pRp274eKhK4Is4rh02pdAGalIQHdnD5yecOVe6NZ6lgO2UbC6WaQHplWokWd3VKGas9ckk1D9robXGmArYpNZ/bzDs6rAG3Z7z/9WcQJVeNqQPSStOZuwvAUiWI2QedaTZivA2jwOCsFEM/tLhjY15dNEL3XBjV0Gy7k4D4o6YKwHSZOtoEK3YtPvPms+MLtsAtbQ/6BZA9m6IQQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjvczehkNhSCpOftEF/xYE8m/RDApQjJRHizVuK0W0g=;
 b=HYrAl3nMPnAhrFyFb9UGgNoVu234/x8uu54UAEL5405XcZ9nVV/eGdGDp8HyXRM4JyobZ5hZnrCXZEyoN7SdEFvHbKsRxp+o9UZZ3JkdNt2fiX5rzCQcDpX6Rjt5wrloRVdgVORMlAFfrQ1b/+Utp/tQnrZjdygXm8UFrZBTm/ObG8W5smNkZJH0d6zxHIAtpDsg/xxrEXK9UrLy+FtZavwU1o7PGXp7tHf2HxNKqKamJJzgHmVvr21cNR3P61Po4jlnxNm/vGES89nUGuHDlXX2xIefroGCdfnBnlTqis6HPnUvwPBHdg/BGmZ8iC0c8AzMpM2LljKMnV7b5WZKsA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Wed, 12 Nov 2025 05:02:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 05:02:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, Chaitanya
 Kulkarni <ckulkarnilinux@gmail.com>, Ming Lei <minlei@redhat.com>
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Topic: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Thread-Index: AQHcU2IiEOCHpn1A8EelxJPvuVBn2rTuXHSAgAARjQCAAArKgIAAA4KA
Date: Wed, 12 Nov 2025 05:02:25 +0000
Message-ID: <949fd750-ff1c-4997-a2d3-274e7530f200@nvidia.com>
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
 <aRP6KdADdbnhwwrj@kbusch-mbp>
 <efb44fe0-6d2e-4c91-be68-a30b53ebdbf2@nvidia.com>
 <CAFj5m9KtSFF6Fx+Qf4SL3tazcQ9yp1Q+-pB5uGG40mExoFCmcA@mail.gmail.com>
In-Reply-To:
 <CAFj5m9KtSFF6Fx+Qf4SL3tazcQ9yp1Q+-pB5uGG40mExoFCmcA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6118:EE_
x-ms-office365-filtering-correlation-id: f4defaf0-4613-493e-604b-08de21a8abe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2xPMDM5TVdBMHdNT1hOTmR3MGYzTXVvNi9GRDJjSExWOFhuQWNablpQeS9P?=
 =?utf-8?B?TUZrMGZ6SEs4TmloRXlqK3h1WkZJcXZVbVdFazFQR3Y2NlNIa25qa1RiV2N0?=
 =?utf-8?B?dFp3VlFxYW5KcTFEclhVWTlaSENwWXdoNjgvNTVBVTRJNHZNbHczOVQwOVN0?=
 =?utf-8?B?SWs5aW91aG1wamJZT2pSNUpHNGR4cEhqbUd1R2dJZEgzM3FsRmRlT2tsMVZE?=
 =?utf-8?B?RW0vMUM3R1F1UWVUVXRYTThMSEFMTGpmYU5QTHNJUi9DdGg5WWo0R0NJaFEr?=
 =?utf-8?B?dkY3ZXF0ek1kMXRxQVdjUlhnREg3cXpRMzdQY3Y2cnBiNWY2RUlaOHNsc3E3?=
 =?utf-8?B?TWZIY0s0WlFaYWU2dVArcmx6MHlJNGMyd1JhdGxBSzIxTmFCN3lKSTQ1Z3BD?=
 =?utf-8?B?WlNUSWp5clllL0FldTQ3eW9PM0JONTN3blg5NDBBYWY0d1MwM0xKV1Viek5C?=
 =?utf-8?B?c1lreG5EcmMzQ1U2c1ZDQkxMVlo5UWRBbjNlL3VyVDJPTXVSTUxqeVc5ZmRE?=
 =?utf-8?B?QVBJOXVhUHF5OGVPaHFJcVQ4dk9kRVNNNm9ZWWhUQTdiSnJSbFdzUjlOUnhB?=
 =?utf-8?B?NFZSTXVVa2drNVU2L1BsajhPUjdNUGdpQURFL2IxditlNzJta0wvR1RGVXFD?=
 =?utf-8?B?NEV0UHloUDdoWHl1UjBuaiswWmkvbUcxVmpUUWk2N1FlR0RiNWFpb0RnaEgr?=
 =?utf-8?B?T1VLRWVaMWRBWWJHWTZ0OFljS0VRYVZEbk45K3IraW40T3RMMGg2aW5OT1VC?=
 =?utf-8?B?Wms0eWNydi9pUngyYUUxZWlDdUhsdGkxd2hyMXlKNTVheXBsd1cxeWpwK3dR?=
 =?utf-8?B?cTh0M3pJeENiVnE1dCs0THJrNnR1cngrbkxIdTZ6K0I0Y0xRNXVFNFNZMzRo?=
 =?utf-8?B?dXg4WC9VYVZvMFdML3pic01HRWlkNHFQR0NVOEdObTd5UytGQkhUWTRVUVYv?=
 =?utf-8?B?cmY1WGNob2JaRGR6MXBDazU2WUgwbVVwK2JkVEttQitITHpiNkpOZ3IzbERV?=
 =?utf-8?B?UDdJdENyNnJDUjNNS1pOQmthVG9hKzNNb2UxWGdUSEpUYnFndTBjangrbWp5?=
 =?utf-8?B?NSt5dGtmVE1Lc3U4N3gxcENJTzc5dDloZWZSNlhRNm13MkEvQmYzalBHdS85?=
 =?utf-8?B?MjRWb2dXR21PTnZhSkJMYWJBR2RpUlFaWTY0U2xWMFhEaUtscGxkeDZRN1RM?=
 =?utf-8?B?TzVUYk5KbUZqWW80VHVjNGFGS0VxbVdQb0lRNmtoSXZsMDJTSmNTOEVxN0RS?=
 =?utf-8?B?VlhFVXZZdEhhbkROZHo3NVZDM2NGTXc4RDZ0S1dMTVY1VkQ1U3UrY25vVmlZ?=
 =?utf-8?B?VVJGL0NhL2ZXK3pvemNpYkhFSmdFZjh3QTJlZzVNQ1EzZjh5akZiYi9lSk1n?=
 =?utf-8?B?T0NTanF1aDlZb1JkaXpSWVJpUUsyWWw5TERIaEF5c3BBbHdQYm1EVW93ZWRz?=
 =?utf-8?B?dll5ekkwLzVvSE1pQjdhSW5HTGZENnZ4WVFyZUtXNGpwQmJVV0tjdXlpS0sw?=
 =?utf-8?B?TzRZbENSa0oyYUpYdXIzVlIzd3M3Rm9selNYL0dmYnpndzZRS0xnSVo2YVIr?=
 =?utf-8?B?V2swZzJjNkZDYWNYUFkrdVRUN0ZVSzN3dVRzcnlBd3RxL1AvMUkrR2FGUmlD?=
 =?utf-8?B?RkU4alJHcFppdTc5VEpqQTUwcHJGRGhVNTVzNGtCelpOdmN3enZnL3FKQzJJ?=
 =?utf-8?B?UlFGNXdndGZjeUsvK2tCZ3BKN0hPREl3U2Z4RkZpejVDaXVZSGR1bHhtclJo?=
 =?utf-8?B?T0E4VHBWbUZkZnIzRjduMVFKR2ZsSmoybjJJeG02dDlxcC9CL1ZwQWRpWjZH?=
 =?utf-8?B?N29DSnBSaTA5OHduTHJ5c0ZVKzZlS24rSlZWcEE3WnZFbFR1VWgxVTZCYUFi?=
 =?utf-8?B?clJ0Q0R0UXA2bWphNmZRR0VVdFpVY013R0pkL0xSTlZ3M0FoNWtYbWFXSktx?=
 =?utf-8?B?a1Bqc3NKbUxHWTl0bmRZKzdJcVpRRmowSksrTGhUbm9nK2ZCQTFRUEI2cmtM?=
 =?utf-8?B?QXFJTHhMUHI2NFlwbUNNWlIvZ2k2d2hZNFZTdGR0WTE1QzZnMlQ2WVFpNXMy?=
 =?utf-8?Q?zbLjSM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkR0WEZxRVV3aXZRQjdEc0hMTGw5U09RaFYzdi9wdXpnN3pXWWdkcUY3UU5s?=
 =?utf-8?B?dTZvZjBkR0lXV3I3UjBoZWhEOWtsYTRucTRVbFRweEFqa0tnbzdneEVQT01u?=
 =?utf-8?B?SEM1UlhLUTh4b3ozeHdDOExMa3A2MWZFblhSQkpuTXFhVU91QktuemQwaDMv?=
 =?utf-8?B?aXZEc0N1bW1oN0kvSy9MeGo4Ky9IU1NsK3QxdW9nSEk2cmhhdHp1QzNIM1E1?=
 =?utf-8?B?eURpc3FhVEpoY0tTYWw0dC9UY1Q5dUg1TkJCRWpCRlkwdmJhWjR4NWNHa2hS?=
 =?utf-8?B?VWlnU1BWWHhwd2g4b3dlek0yRktHbGdrT0lVNGMxd0twai9CaXdocEJSWUg4?=
 =?utf-8?B?M25HTlduWk94NFJjdm9FN0ZzM0lRRTVCdFZsSGFIRTRQN054Qm1SenhsNlVI?=
 =?utf-8?B?T0U2ZktvcXgwdGVPbFI4eE5zUmZmZW1DcWNqb2QzRWQ5TlRGYWgzT3hCeWw3?=
 =?utf-8?B?SnlQY25ocW0xYjhEbE9OczRHRldva0FhWkxGTWVGb0NmWUNOcGhTa0g5NFFI?=
 =?utf-8?B?WDFJVkpDNklVVVZyK0lXNnVTU1lkRUJFZmM0SS9DVDBXQkxQOFlzb3B3NWNx?=
 =?utf-8?B?aVRyeFM2WlZLZDBFYmpnYWliWTJ1b0JGNjJXWVFuZnc1RnZvN242U2hrY2xW?=
 =?utf-8?B?Vko2VHdKSlNLOHQ1T2VmUGJVUE1GSXhCOUxSUGZhTnhoK1BucVJyUVE0OTlV?=
 =?utf-8?B?aXVOakhuWDR3aFBFOExkTFJweEtSbTNhRVIrY2VjRnREaHIzZUxXaTBLN2Ev?=
 =?utf-8?B?ZVowOVVmVzNuYXJTV3JkNFJpVkY4dGxOVHJHMFA2RmFSSzQ1VUt4SEtpd1Nq?=
 =?utf-8?B?SXNuMzZUUHBqYzYrUWQ4WVFsVmRyUFNjWjlKcGFuWTdKVTlXQWpwYnBVMzY5?=
 =?utf-8?B?NG13QzNYMjIvdDlDenlaZVRLS1ZJcEFsQXVjNVhIVXJiVk15ZlEwLzk0S1U0?=
 =?utf-8?B?Mi83MVVDWXhGTDhYQnkrV25Dd3Z0UHpWb0hpUDZaZTNUVUUySjB3aEhnako3?=
 =?utf-8?B?MUJpTEc1KzZodzJQVjV1cjZzZVF4TzVHTXBtTmVtd0RqSnB5M012UENxellZ?=
 =?utf-8?B?VWhTak04aXVaNnBCRXdSaktzQ1NXOU1RU3J4enh3NEVkbEdDcE1lM1NzSXpO?=
 =?utf-8?B?YU92OGdjRlVDSm1tbXg0NXFXNnNSdHd3a3JxN2RMQ20xU2w4VzBEUTlyUmVm?=
 =?utf-8?B?UEJnSHdJUXcxOUVXampoQjNSQ1pFd1lHUkpva0F6QTJKZEJnZmhxUnV5cHVG?=
 =?utf-8?B?UGhtMG9MSDdvaDRtYVZDYzB0UVBzQ21Bc3JCV3pvYS92ZkZ1cXR3Nk9nb0xn?=
 =?utf-8?B?WmpZenVIQ1dWakxUZStLOEgrVmZYUDVkV0NHVmF3NVpRVGZuZjhLQ2dKK2hy?=
 =?utf-8?B?eTVGN1BMWGlBV1IrWFJnaU5OYjJFWVZJeDBFenJDeWxJelZyb2hBN0JaQzE2?=
 =?utf-8?B?SUdjQjFNd2pRMXVWN1krNHQycjd1QmhLZ0N4TW9DMGk5REUraWczblVOa2ts?=
 =?utf-8?B?NDAvVHlNdUQ3bnhXQXljaTlUaUdIWGVxaXRhcXljbC81Y2hjSlpLeVBpQkI4?=
 =?utf-8?B?QmNJNHh5eDZhbS91cjlyNWtmMUlFWVBRSnk1VTFxSlA5WWN0KzlhUkVOQTNL?=
 =?utf-8?B?OG5wMkhBeWVaL2JRc2xlOGpNOHJyNXg2OU94bUhtZXd6TysvK0RzL1Z5QjdD?=
 =?utf-8?B?S0VFK3VhdGVZY2lZenk5b2o5aTRMTHNnaytqdFVVdFhVandSeXBpbTRPMzhr?=
 =?utf-8?B?UjMvdEQrYXlIbVREVHlvdTJaWS9GZzlDOUEzc1pZMkhUQ1NxYlJRT2xRVnAz?=
 =?utf-8?B?QkRSc29aUzkrKzhhMlpKdWVwOTV1aVpTSW96cVlQQm9jaEFSUlBValZJSVR3?=
 =?utf-8?B?WVBKZlEwMXRTZk1LUjFnOHRVRC9UT0JSaGgvNkM0eThpaUViVFdqNU9BcnVX?=
 =?utf-8?B?Wk4yUmdCT1pyc2I1YU1wamd0RkE1N3BVNkFkZHlvcGZxK1Z5c0t4MDBya3NT?=
 =?utf-8?B?ZWplelM0b3UvMWpZK1l6dGhnV2ZqQzFXVzJHRWFKUWRCRXFPMVhoZ3MyMER3?=
 =?utf-8?B?VGxvbzFhOW1ZRnZuNm1LRTAxaERucG8yNEY1YmwzWXg3eElIS1FZMnl5RmJh?=
 =?utf-8?B?RkR5VFFyMFZzbnZmMGNRTkx4MTl0emJUZWhtWTYzVkRaT0Rramx5eFprdUg3?=
 =?utf-8?Q?GPiwKydMUR8il/LYYDrrE33pEi05n7BCHz31YPGIxTh+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9A2F72EF908447B8E51A09A6E10124@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4defaf0-4613-493e-604b-08de21a8abe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 05:02:25.4962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6HBTrhfrWsADvT6IV+AFUE3s2Ii2D0CydZIrjPIEwMX9ESvR9mWJ7ORak0Mp/DD2+u4T7x+8HMfIHm8P9rPKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

T24gMTEvMTEvMjUgMjA6NDksIE1pbmcgTGVpIHdyb3RlOg0KPj4gQEAgLTI2NzUsNiArMjY3Niw3
IEBAIHN0YXRpYyB2b2lkIGJsa19tcV9iaW9fdG9fcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcnEs
IHN0cnVjdCBiaW8gKmJpbywNCj4+ICAgICAgICAgIHJxLT5fX3NlY3RvciA9IGJpby0+YmlfaXRl
ci5iaV9zZWN0b3I7DQo+PiAgICAgICAgICBycS0+X19kYXRhX2xlbiA9IGJpby0+YmlfaXRlci5i
aV9zaXplOw0KPj4gICAgICAgICAgcnEtPm5yX3BoeXNfc2VnbWVudHMgPSBucl9zZWdzOw0KPj4g
KyAgICAgICBycS0+bnJfYnZlY3MgPSBiaW8tPmJpX3ZjbnQ7DQo+IFBsZWFzZSBkbyBub3QgdXNl
IGJpby0+YmlfdmNudCwgd2hpY2ggc2hvdWxkIG9ubHkgYmUgYXZhaWxhYmxlIGZvciBGUyBiaW8g
Y29kZS4NCj4NCj4gSXQgaXMgb2J2aW91c2x5IHdyb25nIHRvIHRvdWNoIGl0IGZvciBjbG9uZWQg
YmlvLi4uDQo+DQo+IFRoYW5rcywNCj4gTWluZw0KDQp5ZXMsIGl0J3Mgd3JvbmcgYW5kIGFib3Zl
IHBhdGNoIGlzIG5vdCBmdW5jdGlvbmFsbHkgY29ycmVjdCwgcHVyZWx5IGZvciANCmNvbmNlcHR1
YWwgZGlzY3Vzc2lvbiwgdG8gYWRkIGEgbWVtYmVyIHRvIHN0cnVjdCByZXF1ZXN0IGlmIGFjY2Vw
dGFibGUgDQouLi4gaXQncyBnb2luZyB0byBpbmNyZWFzZSB0aGUgc2l6ZSBvZiBzdHJ1Y3QgcmVx
dWVzdCwgYnV0IGlmIHdlIGNhbiANCmxpdmUgd2l0aCBpdCB3aXRob3V0IHNpZ25pZmljYW50IHBl
cmZvcm1hbmNlIGNvc3Qgb3IgYWRkaW5nIGEgbmV3IA0KY2FjaGVsaW5lIGFjY2VzcyBtYXliZSBp
dCBpcyB3b3J0aCBpdCA/IC1jaw0KDQo=
