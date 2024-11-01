Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891B1D555
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458293; cv=fail; b=WzYqdoVpvcPk5nX3OB5WFUdeTFmmWZaRQIGIQvhgV6jVig5FM1atyKtv59g0UH39HPrg55MH11RwK2FxZvbLHJyRPmeO10JkWpHR+vHEvswMaR7npb1fzuUIHbw7dA/jrz4ynVCG/V03dE7oKOSp9nY/OC8LOxRb6WFr9gHwevA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458293; c=relaxed/simple;
	bh=I8JTz0wh7iOJUE5WBV9G0FrpI3tHSpGICb4rEf0dp20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CuCxQW1Vq3jKfyCyB5rL0Mq4il/CpxRYE0pqRH+a/3pTw6kX5RbyXsdKPZ6yF+6ZHg0aPtn18upLiLd5XMHOBYKP3xPeFMkhNACEHCvyEtc+5xueAZp63AoaARq00aBn4ceVOpzbF4vH8kadyeOo5dE8LeDva4nNR+56ehDpKd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m3Jwpk6P; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oMZaD178; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m3Jwpk6P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oMZaD178"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730458292; x=1761994292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I8JTz0wh7iOJUE5WBV9G0FrpI3tHSpGICb4rEf0dp20=;
  b=m3Jwpk6PYFIZHCBrlNnUfkyCIwYWq+DTL3gz4Xh5JQX8VJNNaHz24w6G
   +p+ibxQs6PQCMMuLnLJfq1hN2OO6m/BBGr+05JLCRBMeAjfHZalZeYkhh
   h7imkD6wRqnE4N9C17FZwcHWoJSdJeOZ4aBI3AYxfoL0OqruOIS0GD6aP
   6tKP4B3mlSdwSed/2m9OPQOW5z8qxl6LLIgejBGfyfcGMdEXRO+dDfdAA
   5wqFaQ6ge2qHJq0NWhXWZcKjaPM+tv3dhzgHEniwWZAfEj35GlRgDMh/m
   1gqXIE35KP3M0r5l8Od/50vOtiC3Sk/lYfOkFpY8gu5Aeh/TG37rWeJ4o
   Q==;
X-CSE-ConnectionGUID: fdICUozvSvKY6pGnFy3CbA==
X-CSE-MsgGUID: k5cfsLjtRHuORjCOFUAzGQ==
X-IronPort-AV: E=Sophos;i="6.11,249,1725292800"; 
   d="scan'208";a="30539984"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2024 18:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Touu+KZnWaqZLZ3eIOf+jkrzBQ4TqBNrYDt/MbV2AtQt9qc6tErBiTrEZsUbgcqQ+7u/r8dl3xE+vVhM+zo65iZgyRKibo69LgjISDXWJFgo//InD3LIJSL4SPc03J6rJpUcuDSkwGzP7T+fhC2ZM8tKOCokYz6IWSc2ooh3wDASqGgX9eGTfwIobwNhxaZhSD6juRjESRucwu9HTtFLCIOogs1zW61KdJWWI6ap4kxjup66R8mP/dcnkCIHjMg+nFf8eNJYyFLEJ/2ByqvB0MJLm9+bO7DQewTPjiN0RSN5XgB2IiVAtqkf4sMGhJJbQ5FkKynNuCNfNbWyJd9Xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8JTz0wh7iOJUE5WBV9G0FrpI3tHSpGICb4rEf0dp20=;
 b=N52KQtL9PoEBR1binr9opaigWlG+LuE+9josOhSgVocdUfBcPWAMoFBSS5HenVSg4o7MeVMpKdUi54pw072ZG0c4VEoM7rDP6PMPjhAYAVkeU5Px+CIluAMIUWwk0OyJD0mQjX1C0kF3rZIOLjFrN5JT3ykjggCDQPaMk8MF+2qlUBSWLemes6U3aTbBHm+6XnwM4sJaVXvPqRQkD2zpyCQb+OLrHuzuCPgBOJrtSdRAk3wT7qc5Y0whl0yqziebva7c1sLDKjH14nYgzLTR4JD8u93Et0VnayaBMCDmYmH3toFCwMIwIcuCy7HsRlwSWHBZ8PXRlu4CJqCktC30kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8JTz0wh7iOJUE5WBV9G0FrpI3tHSpGICb4rEf0dp20=;
 b=oMZaD1780krji0cKdmgCdCgA4/GsiX9l18WmNfxX3Ic390YPd7VDYy2aNIu7aJVPt3bz/11R0DKFk1yz7ALfB1wxqrpleim8pgcwSTQxm1xfwpfMsAh24YE+udusukH0cNoIgncTRgEV0+cSV9UtM0UNL9x7m8UHriXCfBRVGnU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA0PR04MB8786.namprd04.prod.outlook.com (2603:10b6:208:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 10:50:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 10:50:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "saranyamohan@google.com" <saranyamohan@google.com>, "tj@kernel.org"
	<tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, Ming Lei
	<ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v3 blktests 0/5] add new tests for blk-throttle
Thread-Topic: [PATCH v3 blktests 0/5] add new tests for blk-throttle
Thread-Index: AQHbLEvYR4jOaPgrnUOtF1K3+1ni5w==
Date: Fri, 1 Nov 2024 10:50:20 +0000
Message-ID: <233yatkr4hnb7cjjfiuvamydyvfvfzb3tmghft62wuulvyrngd@j5sxae3bllha>
References: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
 <05380f47-13a0-cd25-8f34-003fc1a85729@huaweicloud.com>
In-Reply-To: <05380f47-13a0-cd25-8f34-003fc1a85729@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA0PR04MB8786:EE_
x-ms-office365-filtering-correlation-id: 5ef9905f-26fd-4eab-4752-08dcfa62fb0f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2xZdjVJMGRYd1pDMlZSVzZjQUNzMFluUW1pOVE0em9RT29PVGV3bUFaSkdK?=
 =?utf-8?B?bWRXa2FDVEt3b296TmNYQUpxUjFFTCtxNkxSWkJDTkVhclVqZzZZYktrS2Fv?=
 =?utf-8?B?VDFmbXlRQVRpajNGN3RVUktiWGxRZDVNUFl3Yzl5VzRQRyt6Vlh2RWFXaXlv?=
 =?utf-8?B?eE56RkV1TitFYWtaUVEwdHVlUHdremw3Y1NNNGtXWlg2NG1WOGxQUm5ycUdE?=
 =?utf-8?B?emppQTRPcEZXalJNU2dmQndCOXFwZG5HM3lHSHdRQ1J3UGZ5SWJPS2VTRkkz?=
 =?utf-8?B?RGJzRklEY2QzMURyeDVuQkY4QWJwUnRBMllWTFUvd0ZVUSs4SjdxYlRZYnpz?=
 =?utf-8?B?MGlYOVh1QVNGMkxGR3dhejF5SkpzYUFaekszcFo2MUZkY1dXSkJXYjJwNUNO?=
 =?utf-8?B?NkhqRDM2dTlrcFVVK3RmUWZpa1REUzkrMnlKa25oaU1WSFFaaldrL2lrbGQy?=
 =?utf-8?B?WVl0bldmbmRkcWVzcVJLSGlEL2FnelBsblp3c3hPNGtQMDhqNGNHcCt5eUdm?=
 =?utf-8?B?TUQ2aHR5czE2RlE0cnMyVnVnNUZ5YUFhN24rL0hhSjBkTDA5SDdIaGg5WXp4?=
 =?utf-8?B?b1ZidGU4SW1OQ3h1R0hseW5kcmtlM0I4UTllNXpLR2syQkd5MDFjUzJoR3dF?=
 =?utf-8?B?RjNNaEhBb255Q3lRNXh3TUJ3b05Mci9MbFI2S1JlNm9TWVJKUTRrQXpKbjE0?=
 =?utf-8?B?S2pPU0EzbE1GZXZqU2RvZHNXZUQ2NktEUGVZaFkveGxlQlB0aTBEUllTSWVl?=
 =?utf-8?B?MGRHTW5uYnd0bVVydVp2THBQTXgzUUZpbldiY0RCV0tiV2k4MWxXRkEzUzA4?=
 =?utf-8?B?NDlVV2dlbzNEQ0kzb3V0cExPSlVwYTk0T3JWdHZzTFFkRDh6ZGpxWm1IakU5?=
 =?utf-8?B?Wi8xR3E2d05LaThydStEUFpJZXQ4YWRoK1JzWmppT0FMQ1RxZWM1RTZpQitu?=
 =?utf-8?B?MzcxcUNWKy8rSDdybjFMNGo2SWRJeTRzanNDYkZDSWlINkpZY1JxZVd3dDBD?=
 =?utf-8?B?UDRzWmVFblhzMFpVbktmaWl5ODJzdnRVc2J2d1pmalNvUGlnRmNoK204K3g5?=
 =?utf-8?B?ZmFFc2ZYMllxRDgrYzVTWGozRmw3Nmorb0psVW5WQnJ5TXlSU3I2bUJ3bEp2?=
 =?utf-8?B?bXhBNldhZ0lobkMxVDRFQXdsNjh4MVdPajJUWFd4dFhIQ2xTVklCVm9BY0Vn?=
 =?utf-8?B?UVYwUmplN3k2RXhqdmRUdGlMWU94VCtmd1AxRHdNb2tOdUlEcnNZMmdqREhn?=
 =?utf-8?B?OFdRdHdKWEVrM0UyZW05MWZTb2V5SnBCQWMzYjVEMVJ4QUNrWE5zYXNSTlFT?=
 =?utf-8?B?VTZmcFhQZ2ExN2JITmFneTY5bUlQeWZDNE9nY2VidlJnd05yalJwc3BwT0lo?=
 =?utf-8?B?eUpUaFZ5YjRycWUwT0R3dEZyQVJZd09pWmM1ZjdhS01BUkJRL0lFeFhaa2NS?=
 =?utf-8?B?TVJ0elZhWTRRR3VPeFJ1QzZpS0JNOGpUajVIWVBhRm02SGh5T1NyRWdscE5n?=
 =?utf-8?B?Q3NjeUV1OGJlNS9XaXN0U0dvZjkwbGttUW5NaUJhWmRzNDlNWmZyVGRXM1Za?=
 =?utf-8?B?aFlKM2owM2dLL0d1RXVPU3FsR2JOOVRqWUF1akxmZXVnR0ZNZzJmb0pSb3NW?=
 =?utf-8?B?YVh1ek9md053S21USVZMOW9haFN6c1Y5bmJteTFhRi8vdTZpZ2U5bDVodlhZ?=
 =?utf-8?B?RHA3cWF4ejQvaUZUZFFwV0VyNE1zamFoWVR2Um1MODlZcmRUODV6K0ZrS3ZU?=
 =?utf-8?B?QituSnR2a2dJd2hjMldXY05ldmlLcWFmLzM5RHQ2ZERRek9ocFcvc2NmWW1K?=
 =?utf-8?Q?RfLH+GGPOPDYUggsa7/RM+I3uAd0/UDV4DsR8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVV4R0hnTDNnYkx6UjZMQkJYY1AyK2J1dzBZUEdJbUgvdUNGRThWSkUvQmFQ?=
 =?utf-8?B?dVFZSTc0MzNVREFNKzdTVjRaNlZWNkk0b0lKRVpGUlNFQUxjV3U2MlNKY0lo?=
 =?utf-8?B?TFlVc1U2c1Y0aVp0WGprSk53eDE0OWpIRjh6enpRaDNxemUzS2JUWkFkTXl6?=
 =?utf-8?B?SkRKajJLUGFQY0ZQTExRV3F6WWtJQ0hMQUg2T0RBa0dDUm82N3BKL0JGODZZ?=
 =?utf-8?B?Z3p3QktzeU9PRmNjazNjSDV2WlFGMVdLYXVhbi9BRndKTWNCME9tbm4vdDQz?=
 =?utf-8?B?RkpKVURxME9SdkY1NUVvKzZ5U2w0eTFLZG1NVHh5UHNrelE4SXVJRnI2dlg5?=
 =?utf-8?B?MHk1ZlplQyt3WkFGNlJRQmc1eTBPYUVHTHgzZ0FHU1FyTXgwVmxMZHRkU2cy?=
 =?utf-8?B?Y1JNYVNLb0lVU1RhdmV5V054eC9nYzkxVU82OEphOUM3QzZWNUxFVHNwTmM3?=
 =?utf-8?B?UWVSV1A4UW5wWGNraUJkZUR3ajdXSTY3TVgzZk01K1J4Y2Y4MDd6cHZjaHU3?=
 =?utf-8?B?ekxIaTRuWTRoUGpsMjJWQ3htTDc0SWlvSUUrNTZGU2t3a1lMZUxDd3ZuTk03?=
 =?utf-8?B?K2x4VnZyRExjRm1QcHBDRUxxWjBMVXU1eUt1NVl5SXpWUVJNR2hJem5DVDBI?=
 =?utf-8?B?dmlsdytXY2J2RjhMajh5R2hCNHhHSmdsN2FwMjdBeGRndEh6UjNsNFo5SXRG?=
 =?utf-8?B?V2x2SzJCUkNGRFZ4ampWZVhBWDNnbUJsNTB0L3d2RUdhLy8zSE1PaC9PdHA3?=
 =?utf-8?B?bldQNWQvRWNMeTV3VHA4ZEFpM09OeDZ1SlVLbXM5RkpLT2x5ejZ2Nkorb3Bh?=
 =?utf-8?B?UjF0VzcrUXV5YmRUcTl4UGkzNUxQdjZVRGZzSnRJcmp0TnZ2L2JDK05QZG81?=
 =?utf-8?B?cjREalo1N0pEZVlIZnJMNm94c0oyMVFUcjhzWEZWYklrTHVRMTRQZkJIOHY3?=
 =?utf-8?B?RmNiME1CbmZ5bmdJRUFzZE5sMUNVSTA5Vkl4cksvQnVja01ZdFB2UWNGUVpu?=
 =?utf-8?B?SHVhd1RvbExDUlphaXM0NjlJdlJ3bURzUWtBY2k4ZmJSL1ErNUJWdDNBZ1Vp?=
 =?utf-8?B?Q0htSW9iOGhreWhwc1kwNXA2UFNvVy9GSzFzZ3dUcWNwZWpHM0hHQTVqczVn?=
 =?utf-8?B?NkV0TUJYTzk5bStJNEZzWm1rNzVjTy94RUZNNmZSc1NEV3JpVHQyMVNqcFFv?=
 =?utf-8?B?MlRwVTRqcmx2UTFTYm92Sm5jbTZoNi9kRFJ3ZDRuK3Nkem44ZGsvdncxR2tG?=
 =?utf-8?B?ejF4WUNiZU9IbnNFMGlFd1RvaDEzQzZqMVVxQ2Frd2Fjcm1EK3FYZzJmeUlW?=
 =?utf-8?B?NU4rYnFrdnYxTmF1aUI5KzJyclhZZ28rVmYzSGtsOUkzaWlPUkpKc1JTdjNI?=
 =?utf-8?B?QXF4VGVVcTZqSlhOSStUcG1qOHM4ZjIzMnpaMUtwejk1VHROWTllYnlKSnp2?=
 =?utf-8?B?enZIdDNmajAwQUpRdWpIMzhaMFRFa3ZsOHhoNVpHakNRK2dVU2x3N3kvMWF3?=
 =?utf-8?B?SlZ6b2ZoUU9VS1RiOS8zNTROMVVMb3RwMFRmdE52OG9HLzg4U2VVdjNiWndy?=
 =?utf-8?B?UTRETml0Vks1Zkh4T2dKWVZEcDgzVXJ1Q0NINVcxd3ZOTVd4NWpPTnBEUjM2?=
 =?utf-8?B?dDFmT09PTkxLajFvbm1lRkY3S0FmRTdTUkkyNk5Ud2hsRytkckNwcG5xYnRj?=
 =?utf-8?B?SzV5WFVma2JxOUZXZ2pjbGJxdGVWdmY4Vkw4dXhLN1lsNHBQemI2SjZQZHBw?=
 =?utf-8?B?VW1TN1B2U3paYjErTG1XUHBxNEF0S0xLUkVxOUhMVksyWllva3V3c3FnVjFq?=
 =?utf-8?B?dVRYVnY5Szk2OEZVMEhqYWhKc1FHNWE1Tkp1dDhXSEtwU2VkNFBseHFuU2hm?=
 =?utf-8?B?OG1OM2lvU3EvcWVkdE51Q2I0L1dPYVNlK3hybnZOTmt3a3ljeWd3MVdMSjVC?=
 =?utf-8?B?Vmhlay9tbVk1dzVhdjR6blJ1TDYvY3ZYenpDODhmSXFyVmZ5d0poRVQ5b0Nz?=
 =?utf-8?B?UnMzYzA2T3VKTkF4TkJMWDZOTzJOMFpYQk5MN1RlNmhSZDV0TFROblFwRHVG?=
 =?utf-8?B?SEpJb1ZhVGJTSHhyUWlJaSsxSVNFdmZEVGdhVzY5SWNORnFKNG5kNWlsc1c5?=
 =?utf-8?B?cDdjaE0yczUwTUNZeC9JUFBkWTlqSWdaaXpTTTI0eWUxQ0xyQXV4bktSZjNi?=
 =?utf-8?Q?v1dhKyJHkT8tX80UJ7q+HyM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F14AA2058ECA14B8D04853386FBE271@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O4wpSOKdw5oWXB1flVRsJ1G7+8GxMpFFEifDnyGSQ2UyOrvkEfqxbZ/sLWmD/xPeWRnwnrr3HD9iXQtvor9X0bX4fuR01g75m2CNM2XiD+OPbpOebXCbFdT/yaG4chtLzjPq2jkJsFjLe4IXDcQ9Le9JAH79M1O5wtEN2fZEsoZ5J/xQ153cB8C/B9Emhel0ZXKbL6Eu2oFcempSC+tU6H0pcqdtPjNfo0AI0fD2quZhXR31+h25ynurEhDUyInrwib2BZHhoGIzu7zTYM1F/uUtj66PZe1aaB3k9F8wpL/ZUuCT5n/hnqsm4JWJSHjf5Zv5Tn8cIDOqQM0HAbYBqeumAC2lEtsOXJhU/4xYJKp/VHvogAczu0sf8vtENFGlfaOBd9QYUovn183f+owjMtd5NkAJQ5p1N6Ak2sx58B0rMF8tDsZGHj432/FY+AgTf1iSFd4hMq5e7nE+9X4o+Jv2pCHzd82HCNIWpZlrUGeaI4GF5MvMl8Z/sbaFGDV+6ND9+uVFhPB0ENhEIbaMpnze+LWHxaEOY/oAZ8cAbF1GrvsgPC2JQ1jNhAwTGENFZ0ffPqpL0WAr96c5c71AFxplKxQEeFtr0vbxuTJHCT3uu+vRUrTexA/nbt2szGTm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef9905f-26fd-4eab-4752-08dcfa62fb0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 10:50:20.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkNzx+01KRxVED5EQJ9w25hEklbLphEnmGQxaGRNOpzLkXNvWInvh0pOP/i5yrwP1pVDHfmOdNHGa3ZZKif9AxZ1Smkib42nteL2dSccaL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8786

T24gT2N0IDMxLCAyMDI0IC8gMTY6MDIsIFl1IEt1YWkgd3JvdGU6DQo+IEhpLCBUZWp1biBhbmQg
U2hpbmljaGlybw0KPiANCj4gQW5kICtDQyBNaW5nDQo+IA0KPiDlnKggMjAyNC8wNC8yMCAxNjo0
NSwgWXUgS3VhaSDlhpnpgZM6DQo+ID4gRnJvbTogWXUgS3VhaSA8eXVrdWFpM0BodWF3ZWkuY29t
Pg0KPiA+IA0KPiA+IGNoYW5nZXMgaW4gdjM6DQo+ID4gICAtIGxvdHMgb2Ygc3R5bGUgY2hhbmdl
cyBzdWdnZXN0ZWQgYnkgU2hpbmljaGlybw0KPiA+IA0KPiA+IGNoYW5nZXMgaW4gdjI6DQo+ID4g
ICAtIG1vdmUgbG90cyBvZiBmdW5jdGlvbnMgdG8gcmMNCj4gPiANCj4gPiBZdSBLdWFpICg1KToN
Cj4gPiAgICB0ZXN0cy90aHJvdGw6IGFkZCBmaXJzdCB0ZXN0IGZvciBibGstdGhyb3R0bGUNCj4g
PiAgICB0ZXN0cy90aHJvdGw6IGFkZCBhIG5ldyB0ZXN0IDAwMg0KPiA+ICAgIHRlc3RzL3Rocm90
bDogYWRkIGEgbmV3IHRlc3QgMDAzDQo+ID4gICAgdGVzdHMvdGhyb3RsOiBhZGQgYSBuZXcgdGVz
dCAwMDQNCj4gPiAgICB0ZXN0cy90aHJvdGw6IGFkZCBhIG5ldyB0ZXN0IDAwNQ0KPiANCj4gRG8g
eW91IGd1eXMgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgb24gdGhlc2UgdGVzdHM/DQoNCkhpIFl1LCBz
b3JyeSwgSSB0b3RhbGx5IG92ZXJsb29rZWQgdGhpcyB2MyBzZXJpZXMuIEl0IHJlZmxlY3RlZCBh
bGwgb2YgbXkNCmNvbW1lbnRzIGZvciB2MiAodGhhbmtzISkgYW5kIGxvb2tzIGdvb2QgdG8gbWUu
DQoNCkkgd2lsbCB3YWl0IHNvbWUgbW9yZSBkYXlzLiBJZiB0aGVyZSBpcyBubyBvYmplY3Rpb24g
KEkgZG8gbm90IGV4cGVjdA0KYW55KSwgSSB3aWxsIGFwcGx5IHRoZW0uDQo=
