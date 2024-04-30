Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E59249E8
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457811; cv=fail; b=Nd/odmgo2zhA6RTOlSedUHMrvf7rhDMtg+3Tp0OsylXjDCSNnmsV4Ada72MYXYnaI/V4CuOnoQ8KXz5LlGMX3SZ2vZLm07zbyJ74ogVMiUgfaGawdaV03XAzR2xHCQ9c5QrMemAvAVQXODu3GHnYa786NX3t0yk2zMw04Y/EGRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457811; c=relaxed/simple;
	bh=UTRy8hy1cExj+3vapONPXkGgVt1VFRIpSSy6WW6fAw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nyfD2cUI157xa4898rX0u5xfOu0AlxTEVmEkGz1zNHRuAUHwno5exWL7vJSIX3Mkgz6QMUndyYVrTG4RlUlLbNsj6VEgL4Bo++uRwWW91j35FU6avr7skPgd36Vf0Rfirq1wX6h5YBFEWyrHdp4AZgZcPgVomZ57/Og7lKRvX+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UxzrbmrH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aoZ8Pnsk; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UxzrbmrH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aoZ8Pnsk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714457809; x=1745993809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UTRy8hy1cExj+3vapONPXkGgVt1VFRIpSSy6WW6fAw4=;
  b=UxzrbmrHzrtxMiQ6/3BnHuZhWH8R9KjIBKtXEfV6gogk6rx6FSlyq/52
   rN1jYz2MryQg7RDFjDmsI6wKT0sti84PbDxYdRklDOE53KC77QDzgVXdT
   UK25kabHsQk72lItMUl438aE39NAmGdKEnHjkCVJKD8PYVc/6L67Z881P
   GWmsj8BL8bDaAqX+XayGCdGPoVeNCp6hv0p3MSQVZgWtYB7ZU7lGx3zZ8
   BEcoE5ahinytZspBzYxr4FRVKkfO6hPBIxK+i/V7WX+rmQkA9HcTKoFTm
   /8VFp7Ak74jiKTz6XNimxzyBAWFJlVD26m5cxFrv9sKflTV+uc8pHdMuG
   w==;
X-CSE-ConnectionGUID: hBMwLLkLQPO9Wv5jZ6pMSQ==
X-CSE-MsgGUID: HDAFxAw1RzOWol/xLpuYJA==
X-IronPort-AV: E=Sophos;i="6.07,241,1708358400"; 
   d="scan'208";a="14573698"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2024 14:16:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9wA3y8ZYd+X+kT6ZPrZIraTl2mcsFbw9qZz0qTJ12AJO1YfmC2MXuubiSmXGGe5v4erOBuyBUfEIAt8C9ysRK6nEuFnidtFcY4kGPrR0a55HOHdPiD/JkyfUTiR8eo3D0K8lOden2ow9ZspSkXp9S+jIWVrB5mZ8qvbNTYSfaDbe3GiCM/dZ4BGy8S3cSAN0vbYMDWVCqF0mBceY12w4yTaoMTOY1FWcdLGdPIEpA/S6oCfcMtzMAgnO6xQ4SiQxEFQnFwVKIGcPykQCV+3msIxY2NhcWMUa+HEOdPgC0B6SESAntkktxl+EDuIDCcxdYBm45CG7L3Yxq9gsLQrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTRy8hy1cExj+3vapONPXkGgVt1VFRIpSSy6WW6fAw4=;
 b=YSs62crGsuyXriczPDjdlrXkgVGJ4N9hpnm0or7QHHF4zwayT2K8NOG9NwOqFAetvre2Ab2UoVWiNMPaPayYN9BGiVtxFAOT32tWooG6Tmd8V3okIke6wrwyarvUmJyJAnBrIR4hqB5rWhsJjhblqYSPkFuxuAXwNU1ct1qVX2cRFZA6Lpbwnx4zCSIfakifWE+4PZG5svmyKHyLBwpoPusq64nZAO8coBg0GjtBHAv1oLSuJA1RmNjQnIMC10RFufEfnZ6wAcDIzPPeQvvpuBJoSj3VL67KZUhPyZRbxJ33kG00VGWl5BWKJ0tYNsB0PyFnDSjDV/xyPQbcOlyh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTRy8hy1cExj+3vapONPXkGgVt1VFRIpSSy6WW6fAw4=;
 b=aoZ8PnskX1OAF/iuI/hZyzKliWdjUUDEiaIycXiF/lbVkpq4oH3TdIO95iqSOCXoaoX9hTFoFTcOhfK1GxmDm6BllCDbF3vIWA8DErdj8V/wlrDNTEQNKX4JavN9ILsMInpv+B0n1i1Gd52DsvVjMqSkYPHha379AGZqea/BFAI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8192.namprd04.prod.outlook.com (2603:10b6:408:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 06:16:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 06:16:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
Thread-Topic: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
Thread-Index: AQHalYDAYvNpgmNs+0unDARlhknrY7F/Wf6AgACBYYCAAIWOgA==
Date: Tue, 30 Apr 2024 06:16:42 +0000
Message-ID: <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
References:
 <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com>
 <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
In-Reply-To: <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8192:EE_
x-ms-office365-filtering-correlation-id: c1b3f7e3-b3fe-4d89-3df0-08dc68dd1a8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnNEVnJCUkNnOGJlWEJsRndtR0dWZGo3bm0wM0dxLzYzZitrUDN5Q0RMenlC?=
 =?utf-8?B?M1VuY0ZIZFJTNGlJeW1KZkRQeWZ1TlkxL1BETGRPeHoyaG9Ed09wTCtZenZ6?=
 =?utf-8?B?VkZPUjAxbWxqd01rZk8waDE3RjdSc3Z2dTB2VVNkRkx6QWpMdjhTWnZmUzds?=
 =?utf-8?B?S0lnR3ZDeVk3VHBuZE9MRjBKNHlJSGZmdEtyNndNVnpnSlNKZkZrZ3M5WU1G?=
 =?utf-8?B?MEZLelNWZ3VKQmFuWkVvbmNkdUlNWHZieXpwa2NpRjlhaWFLY3dwdllYNk1W?=
 =?utf-8?B?NFZOVGt4akhSQU51eHMwYjU3eXZrRHd4L1o1d09ERzFvdkUybTZGd2FwT3E1?=
 =?utf-8?B?OTZhTnBYd2pIWW1JbFJ4cjIyQ1Jod2w4LzBRd1NiRmxndU1NMWt4TksydytL?=
 =?utf-8?B?TXJ6Y0VVSFZXQlBkdUV5Nk52ZWhXMEtGT3RxNy9TNUd6cDNjWUk0NklwRVgx?=
 =?utf-8?B?SVpBUEZHQkdvYnFIWjFENGNhNjd2dkdvV2FmWndUam9oSERxSDVWSW9sYnNG?=
 =?utf-8?B?eDlZeHd3WFY2am9aQmljUHU3Mzg4b3BLQTJVRlRHajNRRnNkM3FtaGhhZjhk?=
 =?utf-8?B?ZXFkYWlEWUxNb0UxSVJicFZ4ZVVZS0JxRmdtQXVKUVJhc1ovVzZ4azZNd1F0?=
 =?utf-8?B?NlVKSmc1RDdOa0JSUEhJRlQxOVpkcDZFK2xiVXh1WFpidHpreWJ4RHRHUlhF?=
 =?utf-8?B?ZXd6aHIrTTBtb3JVMEN5ZWRVU3U1WmYvSkRraGJjRnhOTFRuYkpqTmRRS2Fp?=
 =?utf-8?B?VXM5WTcyMmgxQnpqVEZFdUl3Q2t2K1NaczZ2alorV0NPSHZuakhMTlRiYlg2?=
 =?utf-8?B?a1ZMN0toc0E3MUh0T0xXMGFyWEd2MGM4ZkM5V1V6Ly9RSm9XM1J6b2JrTWhZ?=
 =?utf-8?B?V3dyVGFQVWpxNjNoaDg4RlIyWlJRdXNPcXRpYXFwcFI1T3RaNkpXWGlwNGNW?=
 =?utf-8?B?V2lLcGZSd0ZYN2VvYkhzS0NBZzhFaHB5emNjVTJKaGIyck9HeE95RFVzSXkr?=
 =?utf-8?B?NlFQTER4VFkvUjBkcURWOFdrcHZWMlhlN1RXVGF0OUo0d2l2R1FSbjVVSndt?=
 =?utf-8?B?Y2ZFVmpnYitHVFcwWVpXV21MZEFzTENqUHNoK1NEdmRmZXVMcFIrcWFvVlNE?=
 =?utf-8?B?TFVldXVsK3ByOUN6MFE4YkExczN4WVZNLzM4L0FFWDQyYm0zV1ZzVjZIY0Jy?=
 =?utf-8?B?eWJSWDFyK0RUTlNta3JKSk9OTGEvVHZIWHhzdU9mU21qRlh5Q1BCWVdDNlJR?=
 =?utf-8?B?UFF4c05iK3U0RXA5L0ZnL0ltWHhvOVpQSGsrYWtHdjZibWhQdmlBK3BiTlhv?=
 =?utf-8?B?VGtSYW1WTDFGTERVSy9Va1AvZWRUakNDY25OZU1hSVExUzRPSW5FT2s5R05q?=
 =?utf-8?B?SWwwSU1SV2tDK3NRNnJBVUdwQ2VLYTRmc2dlVUJwcllXL0lGMi9YZlVXRFJw?=
 =?utf-8?B?dGFKT3gxRmlmemp0NWpFNFBCMEdUSFFyL25FZ1c4UkhpS21yMCtTVmx1UkI5?=
 =?utf-8?B?Q1hwSG1WcmdYYXFRS29TdGxWc3JUK3ZhMjNieFkxVFhQckdGZ0NRb1BLOU1h?=
 =?utf-8?B?cE83Zi9uVm5JSDdpM2RtYUJzL1l2d0VGTERsM2szaURLRFFjTUdJVXZqZDZk?=
 =?utf-8?B?U1c3VmJRbm1hVDJINGRlbGVCSUlKY1VjVW5paU5xOUhyeXlwS3o4eFZ4enRU?=
 =?utf-8?B?WkMxL0hDamhoREp5QjFLQ2lham4xK3Y0TWdzaDB6bFpveTdUQktncXBSN1hk?=
 =?utf-8?B?VHNYQUxjMUFZNVNwcG9FbU9uMmR4SzdsS1pxdmkwRmtNWWt6b3JGeEkxQWk4?=
 =?utf-8?B?TXkyRlowQzZsZEVOMWxlQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE04MENBVEdwSG00eGNSQTJRSGJodUliUDl4NnA4TGhJU3JIRCt5bkFmenZp?=
 =?utf-8?B?UTVzWnFpN0IwdUY1ZC92WEtJVFlEd2gwcVAzaERMU3E4Sk51M05SS2lkcHlv?=
 =?utf-8?B?aXJpMVVDZFdwaWV1aFp4Q2YyVGlEaXFScmNnM3B6VHNCazNpQjR4YmNFYVhX?=
 =?utf-8?B?dWI0anU2Ulc5SDR6bnZCOVJOYTF0YUh6V04yVDZRY0pzVUo5dHEvQXhrTHJV?=
 =?utf-8?B?SDhZTnZ6cHZIKy9hY1FydkgveC9rL1FTdlRYQUNBUWM1a1ArdjdLZVA5MDA5?=
 =?utf-8?B?ZFRxbzhURkUrbFpLUHp4cFFZRFAyREM5LzlWbUtjc2x4RTZscHdpSmVSN0Zi?=
 =?utf-8?B?ZjlXeXVvVmlxTjh6M2Z6ejZQTXE0ME9acXpCczdNSGQ3UWplcW81Ykp4aHRO?=
 =?utf-8?B?aE1vTzIrbVRzLzBud1BKdmYrbjVWRndZUU1MT2tkN25EcHdIT1JhNmF6dm1M?=
 =?utf-8?B?eStpc2xlZG8ydlpWQ3JLdzI3QXhGakVMNml4cWhYeDhaN2N5c2k5TXY5angr?=
 =?utf-8?B?T1BjdFlaQTRvYzc3VDdSTW1tQy9kYUxnb0NrdzdBbWlQcG9MZ3FqaFkyejRS?=
 =?utf-8?B?N0pxczRlallPeHdSRkFrUC9maXVlSDdCUk9uOVF2eWw0NkcvMEhEOGplU2k3?=
 =?utf-8?B?L01SU2gzUXg5RUd5SjhoRDdGQlBtVkpPcDQrbjlBM2VGNExIRTIrejZCU2lj?=
 =?utf-8?B?NnZrbGhncU8yd2pZYjZJbTJLYktmVGZab1ZMdlRlVksvWVRVeEZJWlFhSkRs?=
 =?utf-8?B?VWZjSkhlV2hDWEcyMnhuRUJxb05aYWdMaEYzaVRUOVNnWm5aMFhGNVNVbGpr?=
 =?utf-8?B?Z1NxUEZ2TVE2OVVnRExqVUJoYzdtMGRGaGZFem1yazNzVUljUTI1MWNkNVJI?=
 =?utf-8?B?MW1jK2ZDTGhyQU9JNStISVYweThaQmJxbTZMT25RREovZXMvbFRQWWlWNWF4?=
 =?utf-8?B?ckE3QnJxSDRENGhTVCt0RkF0UGt6RVIxTzB5ek82UnBMRnE2RkJCNC9iZkt5?=
 =?utf-8?B?Z1dlNXQyN1VnbHZwQ1NrUGF1QWJuZnJLVUxzcS9oNkxmUmcwZllJZGdTYkVF?=
 =?utf-8?B?U0JJazEyQ2RWR0tWK3RyTHFkN0RQL01sWmY0K0ZTc2NEVWlXN2ZJdVNwajJV?=
 =?utf-8?B?eWJrQlVEcVhuUldTNktsTk50KzEyZHMvLzVQUHo4aDFSRHdjN2FXM1g4SlBP?=
 =?utf-8?B?aUhSNmNQRnVHRWhhaDVRZXIxZmd4c3VzeDUrbnd5czl3VXhyQzkwNVluaEZF?=
 =?utf-8?B?aXVEclIreWV4MTFIRVB2S3FJUThXbGFGQ084UDJCU3lxZ1Z4SlBtMmJhaERU?=
 =?utf-8?B?ZVZKc081UkNoQWM2Z0tYTm4waEdRTmlEb2xLcFdTeThERmEzR0czTDFPRmFZ?=
 =?utf-8?B?TGpFOWViREZ5clVKTjErL3RYMmJRM3F2bGFBczhjRzZzTkJmb3BYa2cyTEtt?=
 =?utf-8?B?QjJBTDdZOS9pbk1RZjNFUXBuRmtVSEw2bXZMazVEcDNrM1NWODRDVmYyVFg4?=
 =?utf-8?B?T0ZWOXBCNkZrR3JsTnZweEJkZDVqbktxdCtlMkJibFVSNTdkemMwOFBQUHRG?=
 =?utf-8?B?Y1BCT1BIemhPeGJIZHVtcUFHNS9UL25uUzEzY1hvT2dpcWVqMW9oaUpONFcr?=
 =?utf-8?B?Mkl0SFpHYXFRNmwrOHRuaGZnTThncjcrNG9lc2NyTTI2T3FubW1RZW5ydmhn?=
 =?utf-8?B?U3pKcVBoTG9oWkM2cmNIc3VQb0pVR1p2Rkt1UnM0NjJKenlHRzRKcFMvZEVZ?=
 =?utf-8?B?MEtRMDdjYTdaTHlWZkhDbEJtVVAvRXcyTnVtUWF5a0QrMkltMGRpZ3F5VStS?=
 =?utf-8?B?WU52aFVvUnVjRzAvWmhVZVFMVW5rQ3U4QVlaOHdRY1RmVHlXKy84UjNJajJ4?=
 =?utf-8?B?VUpEN2JhWXFpQlh6czl2ZGpXREF6WlZJdjV4N1ZOWHE0Z1NQY1NzRTZPZzJu?=
 =?utf-8?B?KzFreU1NSXYvK0pYQnY2RTlyTmxURVV6eVFOYWtFelhPWjRyYVVqL2YvZTAw?=
 =?utf-8?B?Si9RTFE1QU1KWkQ4Q2RFcUd6MEY1MTZ5Sit5bWtRRnorb2xsQXRyenJjbkZI?=
 =?utf-8?B?bkgxZURTMUZKNC9xNnRRVldsM01sZmVxa0ZraVRxTkRFYURIMzVUZjB6Z0M4?=
 =?utf-8?B?ZlA5b0pOb245N3VZcUVFajhUUGZUM1k0djRCMmhjRlIrc2RGZjVSVldzdHJm?=
 =?utf-8?B?RXlJSW5NWEF1Z2V6WE1tVlBab1lpZitzanRtUWNQMDRhSG5kVFB4bTJ5MUsv?=
 =?utf-8?B?K1dISGlRRmtJeG55d21rVUpSazZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CE727F7E12CE34786CFFEBA163AF966@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	01emQ0OCFX6cOtBVDKBnrLoWyU6pw+7WnExMFKpIgroI1McMaIyqXfuzjY+ptfsqj34seZc3vEpTbSv4ZDiC7/VDMsX9XoxG/4fuy2j6nKQXt1m1geBlUVI8/Kd87bIRSieP1wnJG/rPMIsL/3J4tHClnPDGzOBdMZpj9IQ72lP3R9j6agYscAqiymFIMGedFTzuwbYFISbzUNixNc58kmVHypX+6Rlk4Y0AAkz75/RUHXG4cAeRbw1tEAUQauTjUXbfTPSzZsBupiyQfXzCwML3X5TghjMOGIhIiBZm+9xE+1LbuLwROFarKzNSbiFE0XhGOAxHDN9oq/FyZDReLami0zaQQzysd14vVSbWKooNeoXjynFQ1PUbInn6WcnU4h4nHKTnVkP86ik4DS6nhLHM+TzlTMrqqA4PwOVEhULLjUgtC380maq46u1cP5rsPkkzEL+gwXnoTf47SEmiBfjvlJafSNA/EeNSH8xE9oUG6s3NAOQIgKP+rct9b3aVG9pKrkymuHYYDNdQNMj3ozbnHFj1iNnxbMBgrpKiITIt22J/0C0pNqaPYPm4V0fvGMJNtW7GatoATDF5Iun0OHxhRaU63HTv8hnT4+Z7ELjnGV+QqmKRFvbsw96LQeGh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b3f7e3-b3fe-4d89-3df0-08dc68dd1a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 06:16:42.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3yl47W1Tkzpu714Z4itoEGIUq5noxN5f/rf5Qx6Wt5inImHl/AGSX5nMALXwBTjHW9qVVGRVIkd1RJTXHdaS3Ps6RwhL+3+lAI/GzAOAyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8192

T24gMzAuMDQuMjQgMDA6MTgsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gT24gNC8yOS8y
NCAwNzozNSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMjMuMDQuMjQgMTU6MTgs
IFlpIFpoYW5nIHdyb3RlOg0KPj4+IEhpDQo+Pj4gSSBmb3VuZCB0aGlzIGlzc3VlIG9uIHRoZSBs
YXRlc3QgbGludXgtYmxvY2svZm9yLW5leHQgYnkgYmxrdGVzdHMNCj4+PiBudm1lL3RjcCBudm1l
LzAxMiwgcGxlYXNlIGhlbHAgY2hlY2sgaXQgYW5kIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkDQo+
Pj4gYW55IGluZm8vdGVzdGluZyBmb3IgaXQsIHRoYW5rcy4NCj4+Pg0KPj4+IFsgMTg3My4zOTQz
MjNdIHJ1biBibGt0ZXN0cyBudm1lLzAxMiBhdCAyMDI0LTA0LTIzIDA0OjEzOjQ3DQo+Pj4gWyAx
ODczLjc2MTkwMF0gbG9vcDA6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMjA5
NzE1Mg0KPj4+IFsgMTg3My44NDY5MjZdIG52bWV0OiBhZGRpbmcgbnNpZCAxIHRvIHN1YnN5c3Rl
bSBibGt0ZXN0cy1zdWJzeXN0ZW0tMQ0KPj4+IFsgMTg3My45ODc4MDZdIG52bWV0X3RjcDogZW5h
YmxpbmcgcG9ydCAwICgxMjcuMC4wLjE6NDQyMCkNCj4+PiBbIDE4NzQuMjA4ODgzXSBudm1ldDog
Y3JlYXRpbmcgbnZtIGNvbnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtDQo+Pj4gYmxrdGVzdHMtc3Vi
c3lzdGVtLTEgZm9yIE5RTg0KPj4+IG5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6MGYw
MWZiNDItOWY3Zi00ODU2LWIwYjMtNTFlNjBiOGRlMzQ5Lg0KPj4+IFsgMTg3NC4yNDM0MjNdIG52
bWUgbnZtZTA6IGNyZWF0aW5nIDQ4IEkvTyBxdWV1ZXMuDQo+Pj4gWyAxODc0LjM2MjM4M10gbnZt
ZSBudm1lMDogbWFwcGVkIDQ4LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMuDQo+Pj4gWyAx
ODc0LjUxNzY3N10gbnZtZSBudm1lMDogbmV3IGN0cmw6IE5RTiAiYmxrdGVzdHMtc3Vic3lzdGVt
LTEiLCBhZGRyDQo+Pj4gMTI3LjAuMC4xOjQ0MjAsIGhvc3RucW46DQo+Pj4gbnFuLjIwMTQtMDgu
b3JnLm52bWV4cHJlc3M6dXVpZDowZjAxZmI0Mi05ZjdmLTQ4NTYtYjBiMy01MWU2MGI4ZGUzNDkN
Cj4gDQo+IFsuLi5dDQo+IA0KPj4+DQo+Pj4gWyAgMzI2LjgyNzI2MF0gcnVuIGJsa3Rlc3RzIG52
bWUvMDEyIGF0IDIwMjQtMDQtMjkgMTY6Mjg6MzENCj4+PiBbICAzMjcuNDc1OTU3XSBsb29wMDog
ZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAyMDk3MTUyDQo+Pj4gWyAgMzI3LjUz
ODk4N10gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3Rl
bS0xDQo+Pj4NCj4+PiBbICAzMjcuNjAzNDA1XSBudm1ldF90Y3A6IGVuYWJsaW5nIHBvcnQgMCAo
MTI3LjAuMC4xOjQ0MjApDQo+Pj4gICAgDQo+Pj4NCj4+PiBbICAzMjcuODcyMzQzXSBudm1ldDog
Y3JlYXRpbmcgbnZtIGNvbnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtDQo+Pj4gYmxrdGVzdHMtc3Vi
c3lzdGVtLTEgZm9yIE5RTg0KPj4+IG5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6MGYw
MWZiNDItOWY3Zi00ODU2LWIwYjMtNTFlNjBiOGRlMzQ5Lg0KPj4+DQo+Pj4gWyAgMzI3Ljg3NzEy
MF0gbnZtZSBudm1lMDogUGxlYXNlIGVuYWJsZSBDT05GSUdfTlZNRV9NVUxUSVBBVEggZm9yIGZ1
bGwNCj4+PiBzdXBwb3J0IG9mIG11bHRpLXBvcnQgZGV2aWNlcy4NCj4gDQo+IHNlZW1zIGxpa2Ug
eW91IGRvbid0IGhhdmUgbXVsdGlwYXRoIGVuYWJsZWQgdGhhdCBpcyBvbmUgZGlmZmVyZW5jZQ0K
PiBJIGNhbiBzZWUgaW4gYWJvdmUgbG9nIHBvc3RlZCBieSBZaSwgYW5kIHlvdXIgbG9nLg0KDQoN
Cll1cCwgYnV0IGV2ZW4gd2l0aCBtdWx0aXBhdGggZW5hYmxlZCBJIGNhbid0IGdldCB0aGUgYnVn
IHRvIHRyaWdnZXIgOigNCg0KbnZtZS8wMTIgKHJ1biBta2ZzIGFuZCBkYXRhIHZlcmlmaWNhdGlv
biBmaW8gam9iIG9uIE5WTWVPRiBibG9jayANCmRldmljZS1iYWNrZWQgbnMpIA0KDQpbICAyNzku
NjQyODI2XSBydW4gYmxrdGVzdHMgbnZtZS8wMTIgYXQgMjAyNC0wNC0yOSAxODo1MjoyNiANCg0K
WyAgMjgwLjI5NjQ5M10gbG9vcDA6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8g
MjA5NzE1Mg0KWyAgMjgwLjM2MDEzOV0gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lzdGVt
IGJsa3Rlc3RzLXN1YnN5c3RlbS0xIA0KIA0KDQpbICAyODAuNDI2MTcxXSBudm1ldF90Y3A6IGVu
YWJsaW5nIHBvcnQgMCAoMTI3LjAuMC4xOjQ0MjApDQpbICAyODAuNzEyMjYyXSBudm1ldDogY3Jl
YXRpbmcgbnZtIGNvbnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtIA0KYmxrdGVzdHMtc3Vic3lzdGVt
LTEgZm9yIE5RTiANCm5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6MGYwMWZiNDItOWY3
Zi00ODU2LWIwYjMtNTFlNjBiOGRlMzQ5LiANCg0KWyAgMjgwLjcxODI1OV0gbnZtZSBudm1lMDog
Y3JlYXRpbmcgNCBJL08gcXVldWVzLiANCiANCg0KWyAgMjgwLjcyMjI1OF0gbnZtZSBudm1lMDog
bWFwcGVkIDQvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcy4gDQogDQoNClsgIDI4MC43MjYw
ODhdIG52bWUgbnZtZTA6IG5ldyBjdHJsOiBOUU4gImJsa3Rlc3RzLXN1YnN5c3RlbS0xIiwgYWRk
ciANCjEyNy4wLjAuMTo0NDIwLCBob3N0bnFuOiANCm5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNz
OnV1aWQ6MGYwMWZiNDItOWY3Zi00ODU2LWIwYjMtNTFlNjBiOGRlMzQ5DQpbICAyODEuMzQzMDQ0
XSBYRlMgKG52bWUwbjEpOiBNb3VudGluZyBWNSBGaWxlc3lzdGVtIA0KNTEzODgxZWUtZGIxOC00
OGM3LWEyYjAtM2U0ZTNlNDFmMzhjIA0KDQpbICAyODEuMzgxOTI1XSBYRlMgKG52bWUwbjEpOiBF
bmRpbmcgY2xlYW4gbW91bnQgDQogDQoNClsgIDI4MS4zOTAxNTRdIHhmcyBmaWxlc3lzdGVtIGJl
aW5nIG1vdW50ZWQgYXQgL21udC9ibGt0ZXN0cyBzdXBwb3J0cyANCnRpbWVzdGFtcHMgdW50aWwg
MjAzOC0wMS0xOSAoMHg3ZmZmZmZmZikNClsgIDMwOS45NTgzMDldIHBlcmY6IGludGVycnVwdCB0
b29rIHRvbyBsb25nICgyNTkzID4gMjUwMCksIGxvd2VyaW5nIA0Ka2VybmVsLnBlcmZfZXZlbnRf
bWF4X3NhbXBsZV9yYXRlIHRvIDc3MDAwIA0KDQpbICAzNzcuODQ3MzM3XSBwZXJmOiBpbnRlcnJ1
cHQgdG9vayB0b28gbG9uZyAoMzI3OCA+IDMyNDEpLCBsb3dlcmluZyANCmtlcm5lbC5wZXJmX2V2
ZW50X21heF9zYW1wbGVfcmF0ZSB0byA2MTAwMCANCg0KWyAgNDcxLjk2NDA5OV0gWEZTIChudm1l
MG4xKTogVW5tb3VudGluZyBGaWxlc3lzdGVtIA0KNTEzODgxZWUtZGIxOC00OGM3LWEyYjAtM2U0
ZTNlNDFmMzhjIA0KDQpudm1lLzAxMiAocnVuIG1rZnMgYW5kIGRhdGEgdmVyaWZpY2F0aW9uIGZp
byBqb2Igb24gTlZNZU9GIGJsb2NrIA0KZGV2aWNlLWJhY2tlZCBucykgW3Bhc3NlZF0gDQoNCiAg
ICAgcnVudGltZSAgICAuLi4gIDE5Mi43NDdzIA0KDQoNCg0KQ2FuIHlvdSBzZWUgaWYgeW91IGNh
biByZXByb2R1Y2UgaXQgb24geW91ciBzaWRlPw0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg==
