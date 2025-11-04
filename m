Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CF3112B4
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250305; cv=fail; b=C1OaVSo4j3SriFmyAb1c0/PUgF+2M+HhnskmXxCCwSJKc03ZxmXNfD9mjsRRoH0uojc/rre2FkkW9vKLCZn4TKJrUpHH5R+XdRG3nDEAsO4jjIq/dh5bYZq3kfulQd19MLkQ0XMawM31ISMyKQo+tPDVOc9o9MOlVTzNriMh4jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250305; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5KOpPq3MoSQ3xm5jlapvjwjxkQlQpBxUJ7QjquAyJYEUCwT9iWG7upL/R2idhqhhDrYAycMVItK1yWvyjm7rrt9si1If8OdQW3BQfbMKiMxa8NCavXcO3h24r9TtADkrtV1l42owYMZTrmOu6jhazN7hJUoMGc46G8y/QpJnfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KDzXa5UQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=M+sDJQjJ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KDzXa5UQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M+sDJQjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762250304; x=1793786304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=KDzXa5UQcLvWQfpo3s3/U67O4SePQI2T3dZ4UiuDw1vR6/ZhJbth4hwa
   4TnnClX6p4YQU+GSOZUMvEsgr2zZnnniyXfhCuOmg7KrRLw/YTYVwfwUP
   bB8aJTHAaCZLl4dnk0skTaLT0pqcW7PfQGx2cfqMtdJ2st89jhVYFq1Tg
   9rjb8athiNMBgCavncjd8/7JiEBpdWVcos93LC0ok2JMmOCWCynbvsbKr
   Q1dTBwEQJrngTieHAZB9ujEWEzAdxsQNOHDU21JEReBO+HryD24g/D+Fl
   8facIy3qlqsmMypc3ElLfMt35mqbDpP7KqFvD2n/Q0O3ZRbdzF5bCkaV/
   w==;
X-CSE-ConnectionGUID: PfRms2qQQo2ZNZAmzFwuRw==
X-CSE-MsgGUID: 5lm2sEHtROCNb233y3dPHw==
X-IronPort-AV: E=Sophos;i="6.19,278,1754928000"; 
   d="scan'208";a="134409822"
Received: from mail-northcentralusazon11013061.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.61])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2025 17:57:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyIV1vOmg/7xfr8prqR9au4TYBC8nvSukGoBeFELXeWiBXs9Cq2jD/ln+nWUtiAqke/H69xiB9V/HNG+AZfx7iGBgoSZ2b8A7tHXARR/LObs/O8JXxwEzjVbA7YdiR0c3YI0HFLfE6cE6YvDMUUO1TWD95eLpWjzeIxHdBKCOXKj1KqqSxTSe8xZvu6cSLkxUfVTcSi3fjb4crhfKjg3WbRz6SqC58pqlRHFKiej8Ayo5TYVXOQwXhVjSW94eiNzOmlnQnEkOHZjgfgbXlaWtOb+8cCEs/+apIQ0CE2IwRRUz+FnpCJs+wGYm50M3D/qSYi0yfGL2XzNR3RAX6VLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Z7dvYjxtSEG/mwDHusoX+KXl1Ml6GxVW57SPCMVotAMwhScZGNl+6Zs/U89QLP8sm7LhJuceqyluGEbG2WopCzdwDSjrgB7JSIfy2yYeeB3AoUdUeczG8L6rgb+P7o7/mOQfp3ktz5VPESWG3LxEz2RpxN+T4RdkCxDIsPuna9domLDn18zo/SsoC6KNiZ13qXNblC8/fmPVmPmrueTwwUlf0/+lxcotCbTEWiAbL2pHdu+cmuBreJXFPJNDb4UuQeK569twdxYq+TttEOVZY7SgSM/lDZxWrfGSKiDRQiSFsYygJH2gfAeVp6uHyoZgZviK91jdP0yLUecciP4e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=M+sDJQjJDpVQ7Vtup9tNEOk/pSB1SNK48k+6lnB6f4fE2NT2B4Ml0hHbNGc7zszy0rGI61bpaAHIY8SVc1aYAMN1Qda4Hdt6VsZgN9qC7CD8GKzIG1muevu4nIItDmkT0aVpPEtHHxS9LsWhfyPxarH6R20IuZoOvnVj3ZsuIlk=
Received: from MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19)
 by SJ0PR04MB7312.namprd04.prod.outlook.com (2603:10b6:a03:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:57:15 +0000
Received: from MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::30e0:2f81:e3cf:78d9]) by MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::30e0:2f81:e3cf:78d9%7]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 09:57:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] blktrace: add blktrace ftrace corruption
 regression test
Thread-Topic: [PATCH V3 2/2] blktrace: add blktrace ftrace corruption
 regression test
Thread-Index: AQHcTR4+Y813TABBRUyL4M5zJXc/07TiSI4A
Date: Tue, 4 Nov 2025 09:57:15 +0000
Message-ID: <1b825973-622d-4c7d-bbf0-6243db027af5@wdc.com>
References: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
 <20251104000149.3212-2-ckulkarnilinux@gmail.com>
In-Reply-To: <20251104000149.3212-2-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR04MB7411:EE_|SJ0PR04MB7312:EE_
x-ms-office365-filtering-correlation-id: f4cbd47d-4ea8-439b-0b0f-08de1b88886b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ty9pRjFvZGlUWEVVdmVvVTNRVGs5bXQ1Yms4YmNTVzk1eXd4clZQRmxUaVF6?=
 =?utf-8?B?bTdyTlFCV3AzNVMxYWc1QzB0WGFNU3Q5ZE1JTTRSaDg2YWwxelpOTFdsbGc0?=
 =?utf-8?B?eGZ1K3l3aVlSQWY2aCtYSDkyam9Qa0ExNjIyVlBKWlQveTg5cVY5bkdKb0Y5?=
 =?utf-8?B?TTlROTZGQi9DdlJDb25icVdidVZJWWtuYU8vdFBvVTkyeEdyYXR5SW1LUW9F?=
 =?utf-8?B?L1pKOERGSlBYaitSWEU1aTJManVWRGkrYWp2Sml4eVZiVXZ6OVB6Zld6b1E3?=
 =?utf-8?B?b3V2K1owZk8xWkJEblJvTG1hcjdKbzVvTnpPWmVGVGFDYWpuaXoxeENDNkFm?=
 =?utf-8?B?MGxFVWVvN09MREFXQytsbXRkNGgrTWFQNGpFVS9LZy9oSFZXbFEwNEJPK0dX?=
 =?utf-8?B?SEMvRTRQS3RVTmEwSVFwVitObHhZa3FpUE5ydy9QaDZTTzdEa3g3TG5FTTgy?=
 =?utf-8?B?TjlmTWlIUFJuWmlBS0N1aGNpL3FEU1JTOHc4K1dZdHRzalE3cU92VS8wWldq?=
 =?utf-8?B?OG9SVVBFRDF1TWVhdFlwOHh5SWRJbWtkcGZmMlF2b1cvM1k0eXRlQS95NklL?=
 =?utf-8?B?L2hoTVBGTW80VU54UXUxVkNlTys3WEhTVkw1L015OHMxZ2Y3SHQ5Nm9mazlG?=
 =?utf-8?B?YmFySGtNUUcvdE5URDFFRTJQZEFXb011andyTDlsOEhPbWxTcjJoVjVBSTZu?=
 =?utf-8?B?VFlEbXFsMlVtalVDTjhLcVpwUHBxNjE5c010VFlXdEVFbFlKRkNqUDhFdFYw?=
 =?utf-8?B?YVVhbDFiSTBFUXBBNm9jNzh2ZVBSZ3FZZENEWUp5Q09rcFcxMldiM2h3Sm5w?=
 =?utf-8?B?UnVJVWFndGl1QVloUGl5ZGVvRE9JckJlYTlQYk1LWnRDSk1sdm9yUUxvbW5P?=
 =?utf-8?B?Y3Rka2c2ZzhBbm1qY3VJa2pQMEZtNCswbCs0Sm1DWW5OY2o0dHRSZnRKZmJo?=
 =?utf-8?B?bGl4OFRvY2pQM0hUT1F2c3Zia1gvSmQzMnNMQXlWZnBjOXAzZzRmT0tzcDJv?=
 =?utf-8?B?cmxGVnF3VEhFLzVRRUpNTVptSzNaMGZOOGxHcHk1V3RTMHllOGxMRmx0MDBa?=
 =?utf-8?B?S2I3ZitYTXZjeVpoa01IY21LM1BlalZpTWpYZnNLMStNNXZSUDZmMTJQbkRm?=
 =?utf-8?B?enFScWljRTRldm9EUG9mWTlJK3lldEtFQ1FUbGRnbGcxMklqSnRNUzQvaGRR?=
 =?utf-8?B?SGtrVHR5MEl2WjlTZUNoWUNvcVJSbWR2ZTNSUlpybzNRSWFUaXI3NmxrMVJD?=
 =?utf-8?B?Q1dDb0UzbjUzbWZ3bVF5Mmh1NWY4ZHNEdWtpZmk3cjJIRzhEM3Vra2JISW1T?=
 =?utf-8?B?L2FoTmUvYmFhdUZTWWJ5TDQxODFjYStUOXprZy9PeVJtTFhYVDBhZHZ5QzU1?=
 =?utf-8?B?QXprWEttc0NyWWFRblNCQVRxemVjR2RQSWNTS3phSG5vVXVVcS9LUTNUMExR?=
 =?utf-8?B?eGtMTU1YM3hFZzF1RWFpRFl2SnhuUllRc3hHU0hJY2tLb2R4QlhmYzFYYjR1?=
 =?utf-8?B?Y3hWWWMvU2NNbGJyZ0pBRXZrcFhldWNVZFkrTVFtMDZ1L1l4SlFLMTJneHZB?=
 =?utf-8?B?OVlmalk0TUEvUktyc0t3MGdTMzU3TWxrRXBJR0tJcjMvdVJIU3Z2SnFVK1pP?=
 =?utf-8?B?eEpJZWlyRlN5dDFtUjhOS3RNejBXVnhQVHBsaEVnS0F3Mys0bUlyL3JWbFUr?=
 =?utf-8?B?T1VJVnRYbTVrQk9vaUo3MWk5aTNXMUMxa3VRdUtpTy9kZFlMUlRoL1BSaXJ5?=
 =?utf-8?B?VHVUZHNSU0VGWGtRWGNONTByMDhpc1RtMWF0LzhLUzNPbE1rRkNnOXVaUGF0?=
 =?utf-8?B?Z21hczJDcnZxMnJvTDZqWGoyS1FETFE0ZWo0aEl4N1lKKzl1ZUw2bUtkWGVV?=
 =?utf-8?B?OTFnVUZYNUkwQlozUXUzRkZLU3dFWGp2czNmaFhpMUsweGo4cVhlR1ltelFX?=
 =?utf-8?B?M2MrbWg5ZW4va2Y4WjNWbThzcEp1VFhnMitOTTRRNHdQSEZTUCtDaUlNNXRa?=
 =?utf-8?B?QzJKYngvM3NHYnFtaTlsaXlQQUVNNFpQMnlZTGQxaVlMSkRqNUUwdERMZDcy?=
 =?utf-8?Q?9o7Zjg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR04MB7411.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTd0UEJCdGlCUWhkdlJWMzVpK2pvNlBoVVIvV3JrMS95UDZNcXdhNGJUWDYw?=
 =?utf-8?B?WURxR0RJQldWZTdGUzI2RTlBdllhcW1IWDBzSmJQVVlYbXFWeUFTaHY1OTdL?=
 =?utf-8?B?eVRjc1NDaGRQdmZKaUk1akJGdCt1VkV2dVU5b2NWazU0RmQ0dTM0cURQMXhx?=
 =?utf-8?B?WVhRSGw1cDlkcjV2dDFqa2NLUDZSc3ZBRUlYbk5tSXRaSVZUeUpGZUNpaFdz?=
 =?utf-8?B?eFdzcmtHd1RXR1Ard3o1V0pzQWJXamptUWh2VytHNklwd05XNXh1WU90SVda?=
 =?utf-8?B?Z1hEU0R5UHcxRmdVd1B5R2RjWGV0d1M1eXdVT3pYOFIrQVpTd0ZPZTJsb283?=
 =?utf-8?B?Tm8rT3cyZUZJTkF3bDlHYm5jblZoeGdzS3dtTGUxSDdLQjgxRXF5MG5qT01q?=
 =?utf-8?B?Wk9Danl3dHcvTFBjQVJPZzJ3UFAwUHVxaDdnV1l0WG5QMlBDdEt2dzl1bGRJ?=
 =?utf-8?B?Sy9KWjhDMlR0SUJPZnBPYm9rSTdJdU9rWTk0ZTdRREp2Nm1LNngvYURKMlR0?=
 =?utf-8?B?SXNHNHZQV3V5NndvcmNqeGxGbHZXWm02dytacEhMMWlxczNHRGdpZzhPeUJW?=
 =?utf-8?B?ZzFSdFFnbVA4bU1xWTd2Vy9RdnkxcFRHVk8rbm5RWHJEWnB5R04wYW5sdUZu?=
 =?utf-8?B?QVZNMXRaYU1CZUpQS0p6NU5LeWhKeUtRdytqWWhLczV6aldOelE4WkxnbTFx?=
 =?utf-8?B?bldxTnlXYnJOejd3OExmYVFjT2dEdTJUN3VhR3JnVjNGZ1IzVW5kaHBQTDhx?=
 =?utf-8?B?bjd2YkJaa2VrL1ppMzRJbWxmMVoyT1dxNW4yeVBpTHN1bUVmaHZFQitkODVs?=
 =?utf-8?B?M0U4L0lsRnkyVC9kdkEvaWJIdlZoZVpTeDNxMjZZZ3h3L00vRU0yQXcxSmZK?=
 =?utf-8?B?WW5vdlpsSy9Xcjh0NGNiS2RVaStwc2NRbi8zUk5NOUhxQ0ZGVlJLZVczeDZj?=
 =?utf-8?B?aDlnQndlZGpVRFJla1dyc1JudHBTUXBjRmFlK2o1OUpEZDdvN29QSGV1d2tx?=
 =?utf-8?B?UFN3cTZLVUZhOU5qcjN0M3hwNVhMcVowenE1R2tIUHFSUDNuN29YTXBQcEV1?=
 =?utf-8?B?MjBFZkMwUnUrVkxxUG96TlhZUXJQUnU0dDEvTEtKYUkzVnQ3WFdNTnRTSHJn?=
 =?utf-8?B?cUo3ZWRacnUranFtZFVmQVpRbEVXQkxZd01zT2dBbzEvQ3E4Sk04Ty9iWUx4?=
 =?utf-8?B?cWNZbmJ5TmdGSTRuMzZyOGZZbXN5UVdFMG55M3NSMGlXQldhcmlBY2lJcG9u?=
 =?utf-8?B?b1JaWVlJWGdidEtxaThEbTdqbDgwNWpaWGU5VDkxcU9mU1BYcDVKcTdqajhN?=
 =?utf-8?B?NGhuajhOQnVlVTFaMEJTWTdRZm5NTzVtY3hDWkxqTlNtOWlxeHBQTHhFZDlO?=
 =?utf-8?B?alFBNHVTZ1A3dks1M2xSV2pvUEthZXN2cStlNEtOMXc3NGdkUmF3ZDNxU1hF?=
 =?utf-8?B?dlZrZXRmVEJiUmJxMjBieEZ2Q2MwU0VpRUNpcTh0cDUyUFpLNlRUNUFLNGlo?=
 =?utf-8?B?SU11M09na2V2V1cycHJhNFpuMXNva0VqbllHSVA1eGVuSHhrVGtwNkNjR2Mv?=
 =?utf-8?B?NVhVUEY2NVRoQnN5dEN6NDNVMmpmcGdFMkFxTXVNV0dMVXhmUU5YWWZjUUMy?=
 =?utf-8?B?WlVIOFQwanZUejJVWUl5RitIQ3R3cVpxVHdyenlwb3dHY293VWcxVkhYQ0Ns?=
 =?utf-8?B?UmZ6WjVrWTdYbkpreXJURWVlbVRSLytrRnBGYndHUUJ2bVhRcmJjTlF5emtN?=
 =?utf-8?B?WmJHOVZPM25mMnAzcmFHcGMvYnQrZWVGaDNHelJVay9FOUxKWTJUZUxTbGJK?=
 =?utf-8?B?U1FRYU5nVDh2SksrNjltbEt1WCtheHFVbDcyaUtJSmhKTHJXcTJSeVM1NDVa?=
 =?utf-8?B?NWNWckppZUhaRUsrN1k1OXZMd0ZZSFdTZVZ5VFVLalBZRm0va0tzeVQxemNh?=
 =?utf-8?B?N0Q3WVZiTG04RHpzaEwvbTdITzFnSG9Ja20yeG8xcjFjeWJyQWJtOVpSc1N6?=
 =?utf-8?B?ZzcvRUcvR0hvTzJ4SEo2L0g0QTdJemVRVHJNTkhwQklzTlV1Zno3Q3NrQWZT?=
 =?utf-8?B?ZWd1YWxyRGF0elFsM3NFdENtWUVWTWZuTVVjU1ZYKzBrcCtsYzFUR052ZzdQ?=
 =?utf-8?B?VHdCWmRGdG9SSVVrSFNHUXhoeHhFMXhRMktjWFRhM2k0K0lkTnN4SmowTjds?=
 =?utf-8?Q?7KnyXpx6U0Jk60eD2SSZWZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95C31036CBF55D4B9BDFADFC2BF6AD34@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dkc+ttvC7NswE4g2rlsb40da1V/H6RXUZuxh2wYIV7paByphsRHJimJq2Jwq9nVkX4Yimmmcdet/qJ93YZlBmN5e7uFO3dBMTf1vhnLx8+/CEu+ER3oCuKArhRJU4gkpzCNagSvaQf68hK9X3qHIVqwOlBG5uXE9gltQilqOm57lSEO8WzEKKROgBwReLgZ20Rwd1K7qjiuMP8Bdn1+tcTU32QRs9eJMPCPfYdzMHwFzSG1ki8sXTGjFqUvml72j6AOgYpVcDRaeB9Vhw1v0mSWJSuHrKATATwXvkLVs/E7OlBQ4DI0lJ8A5hw8AEhynjTQ5bVUo9oTkOUxPbnLhoqG7oyt5nmRFbjBXFURpeVAjyiyrDiSQyeZMbgks3wK0M3GeD9zhBdK19vGRmwWUSFKvxQcGUcR8unoZIak8/sLkD5GRvHBcftInnexAL+5DEnIS4wknUAvb8zL+N7ibV5HRKzjZKloOSI/ElqSuXjK7L0sF8DB5UYZ9UKyZQ4MkzfTTKp1N58IDPZst7W/HRXZ16IsogN7otjAk6tiI47Q978W5bOtnW8GsuDesXQUoxoiWzD5rIcyxSGnuFs3D8DTtXzaHqE9RftqokYMaIyIYxwhpcaFCFL274Y3B+ftH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR04MB7411.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cbd47d-4ea8-439b-0b0f-08de1b88886b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:57:15.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3A5Wpb23DRb8cak7nwhHlvc5G34GfXAyNNhXrPp3suIJcw4oaiY+Fs7/7ioC1uHhCoHzFjKSpAercfNEKyt7IcOKKQEAnqnJZUHFZmd6jp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7312

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
