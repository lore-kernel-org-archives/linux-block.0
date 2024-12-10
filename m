Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A032248A1;
	Tue, 10 Dec 2024 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814552; cv=fail; b=TuqjZr/JsYxqC3S0NvAKVYSbEEkXyVOcSbTMdEs13EgxBrNfXarMNpLwWpXY4MufikjB9Xi+oo3CZmRAKLsrFa3CsArnp3rZswaqFxUJRXrvtbMggO0dwrYAqdD2uVrkEYal2UkF3BziooqmHyJNe53I07/5GhmPAv8WD+ctZ0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814552; c=relaxed/simple;
	bh=pTNZW7d2nqerorvWvGN/d1EsL3gs21mMmUK9lwIG3f8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rfkoq4OMm3qOlhijbtGRMm+GK/h0joGzmizT/5GRkc8ppji/F+GILiPtPMg0BivlGGfr3Hc8bSlv03rDZ4gGhrvnCLwHEqSrMmjD+2egTLyVRYe/dQbo6eJUY4Gbkp/laLefnKFWsNYBv4x+eFb330gKu1TGvxZ1/cLaKqyQAAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EUb3CM+D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vWiswYy3; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EUb3CM+D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vWiswYy3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733814550; x=1765350550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pTNZW7d2nqerorvWvGN/d1EsL3gs21mMmUK9lwIG3f8=;
  b=EUb3CM+DPkECNi8IIcwhYQz/3PV+tFSTBPJ58CL58IAd5nytC/hgDWO7
   nvTuSADIw1Zsl1X9pm4RHELaK7YNJympmg2Mse8jwXSPzi0Ktj2fBmOEi
   E2m7g7a+q/MYI/uYG1hu5xewPh/Shctm10P853lKidhDJ9G7LpwPGoPhV
   5C5MkUfrlguYrF65zJ7+oodR+KrXDgrZefe5gk8Xt7yU7V7JIKVmI6y5C
   iEW4ykqSlxMJEfNXPxdkEjp2aSHH4LbUl9TLKCXJ+HOMpOlhX2b4gBKgC
   mCiWSBa/7Mc4ytG4v5K8A9BXKsPFvzLJJN+JwB4cfXJpMdexUyhGCjFz6
   w==;
X-CSE-ConnectionGUID: 6yTF6hjUS+OgnBK1XG5Dpw==
X-CSE-MsgGUID: mfAxOk4ZSC6Fbp5iZs9E3Q==
X-IronPort-AV: E=Sophos;i="6.12,221,1728921600"; 
   d="scan'208";a="33972210"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2024 15:09:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzQYKjP5Asps+WCw2OStD1kSyCTX2ORlN9WF1UySXy7fJZVEsKLl/YCDwqiY09YAf44AEgTlY0TDKaUm1HRl2KTiS1QYG1zvUBfJfgzpB+UKci0bnQ8vMFGjysMSeHRRAG4Ycc4iKZDWGVqypllLqvPgyBouOHsmVWaSkKigKkDz9mdHRow51Bs7ffDY3yOe4NXPS8BipyWnWPZEYlR+oPAwfon1WJ6EZrQ+BZw62GMzjHw9a+vpuNa8y3bNu2+7uGTKLMBctcGI4QYJAKESrZPHquJPMLVqNvkd9eAEq7rzTxZ04ns43JDevrdkMdWgWlDBjk9J9QafoFU91c8eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTNZW7d2nqerorvWvGN/d1EsL3gs21mMmUK9lwIG3f8=;
 b=X56+4BpPn2XXmE73/Xugfd3ffTbPtsRA5XyDKkw/Bi1CH4n78qlhp12OCC1R95Aehzm1QMlpJ3xf5yq+IeEIPpj2PvgEd1dh2faHUfInBByI4xguMsZvTx1irHtNVGdg8MG5Vloj/AGRnIVKrwA6kulZ00l47jLbikWfebcnmf50mkcg78TAdApxeOPNHOSQzeBJQjWSgKB/3+E4jN3wsHIRwy6NVnB5CZXnML7RP4Ralv0+rY2emduKYT3NTUcEznpGWu0w6hs9qG8U8fv//HrgQd1NQ+Yoc+QKPlCzlth3YJTt5sPg6+QceP0jMU+LGh23t6lR4LPmbUDtC7JAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTNZW7d2nqerorvWvGN/d1EsL3gs21mMmUK9lwIG3f8=;
 b=vWiswYy3dW9SEo5ginNLB5wJCgllNJGASvraPIeFTlAh42yFE5/IdNnAM9T+qC06iJLteapQFx3MzvPjcuIEa/qsYWOdMM5ekZHiLIr9Yds/OMaSCPtnXQGDeOicSvbR76+Cub1GuS8Eh4uyPlr/usG+9rcKZOiobbZOYcr5tTw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8102.namprd04.prod.outlook.com (2603:10b6:5:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:09:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 07:09:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Atharva Tiwari <evepolonium@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
Thread-Topic: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
Thread-Index: AQHbSswdXU9f8X5MAk2rlV09yjhWHLLfDyyA
Date: Tue, 10 Dec 2024 07:09:00 +0000
Message-ID: <7e04fc51-e7d7-472d-acf9-a7bcdc6c5496@wdc.com>
References: <20241210062340.2386-1-evepolonium@gmail.com>
In-Reply-To: <20241210062340.2386-1-evepolonium@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8102:EE_
x-ms-office365-filtering-correlation-id: 9fbf4b11-f2b3-4de8-d0c0-08dd18e985be
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlhyaTJ4UmVCK09rR3BvVG9xZlZWLzlVdlpMU01yMmRoUU9VbW1Dcml3dVdJ?=
 =?utf-8?B?bDV5UW00SUhjVkdVS1RabWFJdWpRbGp0Y3BSUWxJT01vamRpQjh6VUJCVkxt?=
 =?utf-8?B?YTVVR3NMeEdpb0JHc1B5R3BIVS9HbEFNbm9EVFRiYlo3ckQyRFc2QmJYS01k?=
 =?utf-8?B?YUsrVXYvUEF3OWl0dXBwUlhJZWFTY0oxYTQxbUlRR0lrNXJ6ckNRYVJVTVl6?=
 =?utf-8?B?ck9WVU5BRnhBKzNHQ1FFZDNEVmh6V2xTWkxiMmdwZCtMNnRJYVVrSTZ5R1o4?=
 =?utf-8?B?cEVTdDcxbXAvakM4S0EvNy9vcWJuemxyU3BHR3VLRi80aDdqbkZucTR4L0Vh?=
 =?utf-8?B?OUVTVkU1ZDNBa2ZDWmZNUHZIVlJFQlRMeE5wZmxScXEySG44VUR3QzlwZHJT?=
 =?utf-8?B?UjQ2OC9QM2dxVTJjRG9ya3Jwa1VVNUdZMEhBblBkTkIyWkhEb1R3bmszSERD?=
 =?utf-8?B?QzFKVE1zVzI5QmpwSDRKM1drcmp2OG5vczR0ZzVDTktWNjZsQkVTaTNQMStZ?=
 =?utf-8?B?SHlpVDJ5eHd2OHpHYnFQZldyTGtxZlgwMHc0NXpSYmJ5dDJKZzVEQjNMSk5I?=
 =?utf-8?B?VHBPWjI1OHJEdmgxamRjWUFhaEtqY2tHMHVvajVaUXdKTDZFbURDS1ZCMDB6?=
 =?utf-8?B?Y1RmdDVsZTAvQWFjZHpiUkMrL1JqZXZGc2JNS3UrU0lIWVB0OXYwVU9scnNC?=
 =?utf-8?B?ZEwxNzBLbzdmK1pEQlFianIyYndTckxuSTBHbXR2VnhRVk9NRUVFU2MrWWJ2?=
 =?utf-8?B?Rlc2b0dpTWZVM0Q4blE1bVZ5Yy9uakxkdkFBYmtha0tHY1ZTNmEyRjl4U0xr?=
 =?utf-8?B?Y0tDaDFWd3FpcHVXcFdYY0NMdnRMWGxSRkxhRGEwRGk0RTlDRWl6ZkhZbHVj?=
 =?utf-8?B?TzUxZk5nRXBlbkZ3dEszZ3AvcWtrL1hCSEJ0ajkyU3kvWTZ3cFVIV1hNTW5q?=
 =?utf-8?B?VUgwT1ppMGtNVzNRTnV4MlpHNkplK2dWSXViRTg3UVBkZmVmMklxejhrT3Bq?=
 =?utf-8?B?czZxRFFYM3Vxd05sVWFndHJjVG00VHE2SzMrbVU5anFOaEFyejRLQ3lkVVVL?=
 =?utf-8?B?Y3JFMzF5UVNTam9Dc3VzS1NnNkJwelFBOTV2UjVwclc5Q0M2b3BjU2Z1UVFF?=
 =?utf-8?B?bS9oMkJLdTd2RWNYcVlMQXFwZHNiRld0NjhhU1l3aDRjdVB3ZGFJVmk5SC9R?=
 =?utf-8?B?aTNPWmVqcU45WENLQ2Yvck1PZ1RwcHV0azZ0MTM5cVlaM0NzSjduZjJ3d29E?=
 =?utf-8?B?eUhIOUhPMjRiVnF0ZjFoejZhNUFQejRiMmNIRWVQWTBXL1ljMGxIbll4VUdT?=
 =?utf-8?B?WEpsTGt4S2l1WUJ2S1Rxb3lHeE9HMTFyWlVrT0U0aDBIVE5Pckt0SE5RSDZj?=
 =?utf-8?B?TEF0STdmNkhLbU9rN2tjdVBYVHNKNVU2RHpyV3QxVjRWbE04M0RPK3pOTlFj?=
 =?utf-8?B?TDQ0ajNsaVRpaHR5dlQ5Mk13ZVV3R2NBRzFTV1dIM3JwRDREQmVzUnhYQ1dG?=
 =?utf-8?B?dndpN2w0TnpZWllTM1lLYm1MNWVNWkFSTFBaeTF5cjFCQ21SeXViQy9DUFZz?=
 =?utf-8?B?dGJnVmdoZjJyRFdBTGU1Nll0VmNSNUZrNHVJMmZyQ2R6S3pFUjFyTlVoTDlo?=
 =?utf-8?B?Y0R2SGE0c0VEUkN1Q05tc0tweVhpTENrZTJscUJmSWZwSURuTW5pU3UrY2x4?=
 =?utf-8?B?eDQyZm5yNWN3T1dJYnlFakFUMmtOUkRUd2duUXdmNWlJUE80K2VNS0Z5RXpB?=
 =?utf-8?B?eTJIL0JUMXRVWkdkYWhPZk14UU0rVDBWZUNtQmpDQWI0eXgxMWIxQTJ6em10?=
 =?utf-8?B?dzU4Rmg5T1NnRUZjTU1XZlluZkMzNzhpRmZJcGs4TksyOUcrUitwUXRFaklK?=
 =?utf-8?B?c2FZcEpFS3lwYkF2emhaaXh2S2RqbGZ1U2tSaEI5QjRCOGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck5jbXRsMmJUNEQ1Q2tqV1lXKzFKRlN0TUJuTVVPYjRPM200aU5IbFRHaU9s?=
 =?utf-8?B?MU9IN0QzOE44T3U3NDNOWVlETlJ4eVlJUG1BU2dzRHdPd2FwYWtXUVBQMVd2?=
 =?utf-8?B?U1hudTIrbnhuc1UyS0x0cG1ScVpibFMraVA3eXlrb2xVWEhEMDMrOUQwVXVv?=
 =?utf-8?B?cGNtM1Qzc0doWklCZStpdVE5a1I3eGtxdUoxeDNDcTg5b3BHWjg3SWlGZExj?=
 =?utf-8?B?aVNIMU5tY0pFVkEzOG9ianZjK01ESW9SOVRxaHB1N1lZNUluY09GY3pwUHp3?=
 =?utf-8?B?YjFncmpVZzFYdlU4VzA1NVpWY28zZjdkMC83UEY4VDlZNkNmdG5ScmFZZzBG?=
 =?utf-8?B?WnRXVVBuTkVuR3R1eGd1NVlZWXBMY2lpV2UrTUtZMHRlUmlMUVFBQ1owVjZD?=
 =?utf-8?B?RTZtbU1pSlFqTnNpbUw1enArRUhpRzNXZkFXWDA3RS9yRi93cnJHejk0a3dj?=
 =?utf-8?B?SWV0Qm5ZMHV3OTdNTk1VNCtrZkNhcko0SllsbWlPcHFtRExMY1pYTGY5b3d2?=
 =?utf-8?B?c0YwQVNUL0pxTFV5THJqQXBJNDhBbHowSDE5eS81Uy9iTUpsWWtYQVN0djZa?=
 =?utf-8?B?R3BRWUdQbncwcm85UXZDSGpOOUVranc2MEtKRHQ2NmNWdmU0V3hQdnZqbjZH?=
 =?utf-8?B?cUhpMmozTjBzQ243MjVOZVYyYkNoZGpnc0xZUTlXVkJSTnFkajl3Uyt2MEdx?=
 =?utf-8?B?T3hwQjdqTWFjelYzbzZJYWUwRXVORmlCWVFqbFBibVBTUkVYN25KZDVCVE45?=
 =?utf-8?B?OC9SdjNETUd0MmRMaHhsTVZvc25JcGV4Sk5mb0dvaVVodkQvcEZUVzhLYXEv?=
 =?utf-8?B?NFBqM0pFZWdPL29iU3BKOHRXUUVyQmhLOWw3ZU5nenJNQXFpTmxQTGRWaHVi?=
 =?utf-8?B?QTdjeGlZSHZJSE1BNHlSelRORjkyNUtFS2V5Wkxkdm1CQUxjRDJuNkprRVVW?=
 =?utf-8?B?TitJSWtKdHRLalhYU3VLVEhzUXVkUGpZekJ0M2NqcXE2SDlzdzNGYU5EVGpw?=
 =?utf-8?B?SGJmZVMxS0tTOUp6b1RqUjFxcU5ySFlWOVVrS1JoYzJJZmdDa1lGVG1oaDlD?=
 =?utf-8?B?ZlJuU1JtdW8wS2N6d2M5TUYrUzBHR0E0aU1WNGVGMnFJNXpEeXVJS3krOWs3?=
 =?utf-8?B?WXNRU2JQQ2h3bXU4M3hrd0lSMU9lTmpkZytHakIzUUliclNObmREUGVITk5C?=
 =?utf-8?B?a29JL1dKTjd1Y2hEYld1RzBVV2hoUDNYcStiTGlKY3JrajludzMzTDJsQU1R?=
 =?utf-8?B?NS9CTXZRNlk0ZytHVG5YeHZRZmt4dURlWnlJSktZWElJT1dCM1hNN1BadTAy?=
 =?utf-8?B?Q0l6S25DWVJ1dW8remtPSmtDRmlHbjZUY3hudGhoZHdwbXBKbU9kV0xrSnIy?=
 =?utf-8?B?SU5JODBPcmtDcmJFQjFWVU01WlptU0FmMUJpUGRSWXRWdVNQMHgrTWkyQzJU?=
 =?utf-8?B?aWdITXZsUHJYQWJmamV6VkdoTEsvVXJSZnZBMXF4SnQzY01OdXJiWXVFVGh0?=
 =?utf-8?B?Ym1TMlN0TndkVk8wSW9aZG9FRkFTakQ2eVozSXlwRmNDN3prSnVNSUZVS3JN?=
 =?utf-8?B?TEU2WmFreUFWQy9DL0JXZXc0Zk85aTQyaFdoYzRGUlBxVTJGZEYxZnpXUzJ4?=
 =?utf-8?B?WW02U3BmWDR6VDB0NmRwUnNkWk5HQ2dPSGYrUUJaSTF3L0RIckpBT3BXdEY1?=
 =?utf-8?B?V2lTQXRoTjFlUXFiMGtSWmRGRGFaTzdTZ1kwbXBBQjJJNVhXek11WW94M2tq?=
 =?utf-8?B?QVVOYVhiUWkxdjY2L01nR2haN3ZGZ0JWNk9BQm5lN3UvTWNuNEJYZlowTFA2?=
 =?utf-8?B?cGgzQWx5c3AzUTJyUHR2NzhiZklqbWpBWStGd0RkUEhCTkJySVJaSi85QnQ3?=
 =?utf-8?B?cHNkSCtJby9PRTdQNjFUTHd0bDNrdkkxN29zNnVvVENzdU5waGVQcXcweS90?=
 =?utf-8?B?WUdoS2R4YVNUZ3FiRjQ0MTR0c2FSY2ptdzhLbWljQ05BSTZwTFl6MVdlaWlI?=
 =?utf-8?B?elpyMWhQTzVCNTVQM1JxQldDa3I5TG1jMmZTTEk5bk5nSUN6bUx5UlNqZ1g2?=
 =?utf-8?B?c1B3Y2MxNktRdHQxdXFWcjRFeXk4OUhEMVNnbXA2WVdtek1iY1Qrdkt2Yzk0?=
 =?utf-8?B?QVEvVU5paGt5MG9TNGxNdmJ5Sm52VURlUmxsM3hTK0F0ckRTMXdEeFViTFZq?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <036661248E5DAE4780C24849F420F5E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iOO/vvQKEVYHs+cV5/h8/tDdhXeCWm1IVej14HPd7SNXejpz9nvYOJuU1+SQrQj09EZVkSYk5AbabdU9ow8bwUd3w+ceJew2eLFODpD8XyEJ6hJptfOcCkUiOsc6d/8w63lwOetWgLHrS+ab8NFhLMZSQ0zRO8qzIy+ckuo3kzLEyUBM59QudCy7ZOu2S5+XnhcRV7FGKH97lsdXaWxZICwOIVan1WgkDu7pawKsC1HbhCCsOGUDMXNl+DiPZ/A5VHmyJrVc7NYyK4j7Yktrzwg03Cpiz6wn63kKqJ69Ya0oaKrGBOeGvjknrjJRGbLHGsXy2MoMLyvpQOHmvyc+HUB5O4w1MGHSiF0RtLRcHGEBF802u2cxt+Zfbq7H2XEDL+cfhK+b8THPxIdrZRBhuZyhW+0dorH6dEnLGjrUfcFHU327J0N69k+mfyGedmxdVG+RQnqsPxP+t5p7otBuA0qtd//otxCVciil57y0AdlESlsgRxi1psuMOFrLJzmzUzX1z5HVC1ZGG3p48TEwHCFXgJj6AWVIB63O2Bn0jCgSZhrDPvwBzselogfTgRtqe/4acZrZTH/pAi3suMHHu7GXo0UWznspJ75UmwVDFHnHSqGUdNdvBQy3JQIkH82d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbf4b11-f2b3-4de8-d0c0-08dd18e985be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 07:09:00.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnwS3xJjnaSyMyZAalURPBk5uD5c3wT7vHjpTLC524HJdl/SXj7ljfkjOtbtF82Z7mjV32PZVSOtVmZKALWK8Ikvltb347hMU7hvkeQTMWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8102

T24gMTAuMTIuMjQgMDc6MjQsIEF0aGFydmEgVGl3YXJpIHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5
OiBBdGhhcnZhIFRpd2FyaSA8ZXZlcG9sb25pdW1AZ21haWwuY29tPg0KPiAtLS0NCg0KWW91IGF0
IGxlYXN0IG5lZWQgdG8gc3RhdGUgd2h5Lg0KDQo+ICAgYmxvY2svYmxrLXpvbmVkLmMgfCAzICsr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstem9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jDQo+
IGluZGV4IDI2M2UyOGI3MjA1My4uNjBmOGJkZGY5Mjk1IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9i
bGstem9uZWQuYw0KPiArKysgYi9ibG9jay9ibGstem9uZWQuYw0KPiBAQCAtMSwzICsxLDQgQEAN
Cj4gKw0KPiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICAgLyoNCj4g
ICAgKiBab25lZCBibG9jayBkZXZpY2UgaGFuZGxpbmcNCj4gQEAgLTUzMCw3ICs1MzEsNyBAQCBz
dGF0aWMgc3RydWN0IGJsa196b25lX3dwbHVnICpkaXNrX2dldF9hbmRfbG9ja196b25lX3dwbHVn
KHN0cnVjdCBnZW5kaXNrICpkaXNrLA0KPiAgIAlzcGluX2xvY2tfaW5pdCgmendwbHVnLT5sb2Nr
KTsNCj4gICAJendwbHVnLT5mbGFncyA9IDA7DQo+ICAgCXp3cGx1Zy0+em9uZV9ubyA9IHpubzsN
Cj4gLQl6d3BsdWctPndwX29mZnNldCA9IHNlY3RvciAmIChkaXNrLT5xdWV1ZS0+bGltaXRzLmNo
dW5rX3NlY3RvcnMgLSAxKTsNCj4gKwl6d3BsdWctPndwX29mZnNldCA9IGJkZXZfb2Zmc2V0X2Zy
b21fem9uZV9zdGFydChkaXNrLT5wYXJ0MCwgc2VjdG9yKTsNCj4gICAJYmlvX2xpc3RfaW5pdCgm
endwbHVnLT5iaW9fbGlzdCk7DQo+ICAgCUlOSVRfV09SSygmendwbHVnLT5iaW9fd29yaywgYmxr
X3pvbmVfd3BsdWdfYmlvX3dvcmspOw0KPiAgIAl6d3BsdWctPmRpc2sgPSBkaXNrOw0KDQo=
