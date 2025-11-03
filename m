Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E322DF6F8;
	Mon,  3 Nov 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160376; cv=fail; b=o2JwOM5x2JZOUqInonhZdzp+U1XzxKfP3zwFrxAZAjMHkaipsfslrKTJHGWfTt8lY/FSjWRhneKacjnLquzEFN2wdPFxZDso8UxwjiP0fLbVGBsr/Zyo4uOyH6P59Tx3KbblcmGZapdRu2Vs66X/B1Kcvw8hGgMbiLdw1v+YBzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160376; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJkNwmrxCi8Ci5jEvrFqMsjH4gIqdaoY0cNdZ+JS8y0uotmj1tUIqYi82eJ3w5uHqCv2+l9hDrVxgpGt8KdA13o6gMx0BxFJLyz513IWZodqduJoeNSw8gJJmrdIV1YLiYdjh5hEa5bnDHTp7jC8mw4LExofp9D/iTV3Hs9AjXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hRoe5hpR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wQLrR+yP; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hRoe5hpR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wQLrR+yP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762160374; x=1793696374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=hRoe5hpRKC2sKLD6C0/enJ30uTqlnSVK4HKGz7tP5uq3VaIzGyXPJcc7
   2YIfh84LAAQjQN11CIa1mZud1qG5wo4Q0XU/PrGOmsXsum0vFtbvXYfaa
   otSGtqInALxzf752bwK9hMoEnp2d5eeecGM6st+UUX9I2p4f3kj9NWyby
   8JFSAPJ2aplzcOp5Pemb+wy0cdZE6hvtWo2Aj5VntY6BK5cU6ckUuwtZV
   wyhX2GDernAuAtboegjiNboxCOQoCp+Zeu5rNGEpqboZVeQzYnAs0SpQs
   bQ+pUhgPe0q/hE5s53fXaoWh+aUlLu/JoDfJdJ5DLUHiQC/imq1p3sa2i
   Q==;
X-CSE-ConnectionGUID: wyJ2YSkfRJ2GrckvdTidBg==
X-CSE-MsgGUID: XY6toRARTCuGW+R7kuQNHQ==
X-IronPort-AV: E=Sophos;i="6.19,275,1754928000"; 
   d="scan'208";a="131380780"
Received: from mail-westus2azon11010024.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.24])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 16:59:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewsY9r9/EM/DubDhQqNJfecracsd7yN+oTIv8AUv/sFUuX1HCS8dGShG+vzLKlvmmFMppCSZ5MRdonNHpPiWq4n9cbA9IsiCG2fvse/1dBQH8Tlq6lCKlXoDjmYph/pLCk3VLHlMY0dYUopo0Peb5/J+Q6gXUL1huWfdEljyWVOSEC5GHP/+KxnP7Ownw4M8tPLJslkdnfcMutuEmoXO7y58zsXQxwaxeCaV1+MzY8ENpctIoybToe0c/MwYBffWzvmMDB53Nmu6SV6Giswf3IcXD9W8crZXVg0nUC6fD/V3PkxwL6yOAScbFJv9w3r4vV1bABJxgUqkwJ+w5y4jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=M6qYkPM/UK2iw2ZzB9wpMFs0gdUMGvmDmDOBXL2IGKmGVqVsSRBl5smOH6C/Dj4rDQz3a9LPK3a6maF1qQm/kMs+CACoC/3pXMtIWnd8FUorH0qKygKtcJyFWKN6YsYgltkgcvcd2RJtQ/ltsdiceeoDWllas4tGgPDXdDmwNujLwmiV5UNvr+T7tyI6Lv3PlTlKfna4z39x1hVEfni69Zm5DwzmafOiv0DstVGgZBvY32F8fR9HBes6DuIwc9RrvpLSfdHTdhMJABGATcjI3XLdl0okBzkM7QdxGEDC72gfUBI2Sa4TOlLeyIkpb5C8lCtfyXOFDB5hndy1tlgMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=wQLrR+yPLKZhNl23+do6kMeqN/PjQ6wE+fBFEX1LQrmZQNIaEI98fLmo6oJ4YhgVNbhxewLjQ+4xGiV5Gtdv4aofKgoRgij5+IVcR2cpbOrHYenEVdwYm79ZQ0yw0ik7cOrPTXo/PcZyIVRGnJea7Eh7wc5LIUIrTk7J6IXlMKs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by IA3PR04MB9232.namprd04.prod.outlook.com (2603:10b6:208:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 08:59:25 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 08:59:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "john.g.garry@oracle.com"
	<john.g.garry@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] blktrace: add support for REQ_OP_WRITE_ZEROES tracing
Thread-Topic: [PATCH 1/1] blktrace: add support for REQ_OP_WRITE_ZEROES
 tracing
Thread-Index: AQHcSITxjHhQxXWZ0EWnNrc3nnVT/rTghY2AgAApt4A=
Date: Mon, 3 Nov 2025 08:59:25 +0000
Message-ID: <f9bbd697-0dc3-450a-8ee2-67d7572ea269@wdc.com>
References: <20251029033423.7656-1-ckulkarnilinux@gmail.com>
 <34fb4096-7292-49bc-a0c4-8c13a1362283@nvidia.com>
In-Reply-To: <34fb4096-7292-49bc-a0c4-8c13a1362283@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|IA3PR04MB9232:EE_
x-ms-office365-filtering-correlation-id: 9e9788fa-7a30-4f8d-7cec-08de1ab749f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlV4WSt2NmZKazl5M3lSdmVORThlbnE4Y201RzVjKytGV0JWNWVROGtoN0pN?=
 =?utf-8?B?TlJZMVA1bDNiTm1qM0lOOUErSkV4ZytDeWdLanBMT3ljVW1oOHo2VU5xcS9V?=
 =?utf-8?B?dEdMWHR0cEdaUlN4d1h2Z2lleUxnSlIxWFdKbmdqeUVKZXJaSks2NzNBSzVk?=
 =?utf-8?B?dkwxZFlVMjFtL2hxT1RhK0s1TWlTU3RKZzU1SW01cHIzOUJPTUJHa2JRcWxY?=
 =?utf-8?B?N09GS1gybmJxVEtSS0w0UkRiU2JZb2pMTDdVMTNqdGpnRXNjWVJVdnJPSlpW?=
 =?utf-8?B?UVVCNkdKcURjeWpteUdETFBaZG1xQnFlYTI5TDVkd2NkcmRhcG12azZJaXVj?=
 =?utf-8?B?MnNZL09ad0p5SnlBZzhyVjJyWisrQ0o1eURVU1g4VkxjL253N04xUmpjTUdX?=
 =?utf-8?B?Vm51Y0w0dDV4c01PaFpVWDhaVnZVSUlPSUlwdmlNOXRNRnNsejl6VDU4VEs2?=
 =?utf-8?B?WFpqT0l3elVuVWIyT0ZSSk9RazE4WUV1RHpWNktsY1ZYMW14M1M1bTN4b3RB?=
 =?utf-8?B?QklVTkVETkowRW1FZzA1SmQyQWZmd1dhTUd1UEp6NHBlNGN1TWxIZExlL0JH?=
 =?utf-8?B?OExZVnFLK0x1T2hXVmZEYjAzZHd1RzlGdVNJSG83K1psMWJoNnNUbk9WVkd2?=
 =?utf-8?B?V2dnRlpyUDdHS0kxUFkzSmhxR0VNWGhkU1Rid1dQRUIvVXRmbGhoUFh3M2Y5?=
 =?utf-8?B?c0J5b0dhd2tsY1VJQStIM1J2R1Y0OFJWOE5CaHltNXJZUUcxb0REbE9SYUVK?=
 =?utf-8?B?SjROc2RLOXMvdG9IWkl2MnBpbnRUYlErQ2VXbmxkRmVEZm5HczdBUzZTamg1?=
 =?utf-8?B?ZDkzWEZXUk5FRi9ROWRoYTVESE1nRDVQQW45U2FTL0JwTlViVnRqR0tJSUtZ?=
 =?utf-8?B?dGE0Z1NPUlViMzN1MjJaUGhKc3hXVndsYmhtWGpkTWQxYlRQQ0JuRmhDcEhi?=
 =?utf-8?B?UHlWcEhuZGphdlRlSXpBSlJvaUh5Mm1KQnowN1d3NHVPRXZYSWdEdTlTYzA0?=
 =?utf-8?B?NXJuWjJrTDVSVmRFSXcwbnF5RUpxY1l5RmM3V1Z1UFBlOHFhaitQLzlDWGRP?=
 =?utf-8?B?U2ZmS21OdStNZTVJcVJOZGdnaGs3T29pcnd2TkNOUkRVMnkzZTB1Mk1WZzVy?=
 =?utf-8?B?MTM4NjYvbk14ZkRGZERhR2xPVVlUM0pMTldNQks4VTlITTlkRWw4VS92eXk0?=
 =?utf-8?B?ZXdhMVFCa2krcGJWZ211RVhhMGtqMEtiNllzQnpsZi9PUFF3aWhwZHM2Y2hq?=
 =?utf-8?B?WElYa0RyeG5YQjgySFMrQkdEUlIrTXc1clZ3VXJVdThqdmc3cWRuMGlMdmxp?=
 =?utf-8?B?Qk9taWJxR3BGV0tOc3lsLzZtNG1sK083TGloL3VZcmVLWGRTdlRlYkxQcE1B?=
 =?utf-8?B?ZkZwemg0T2hBWDFWRlBjT2JFR2doU05WbDAyYnJlcStaeFcyRnE2WkQyTlk3?=
 =?utf-8?B?QkprUDFZZklQRFNGYkZLcDdRMHBlYzZhN081RWc1YWtML0pwTFlFZy9wRHd3?=
 =?utf-8?B?YkhxU2dIbFFwa245OG5ZZEkvQzhEU1ZQMDNadjNHQk9XNXpJY3VwVUlPaGNv?=
 =?utf-8?B?SEZITWo4OEhhaERROVZETDF6dHQ5Q2MzcjZBSUl4RWg4UituK1NTZHUrQmky?=
 =?utf-8?B?ejdDd1hGTm1jQVQrTThxVnV2YlRBYndPdTUxZFBBeURpc3I2N0luYjFTelQ1?=
 =?utf-8?B?TEtha3dPWC96UVZBcWNSYU85M2haVzRWS2ZvS1k2bURpenNnUzVWS21SeHVw?=
 =?utf-8?B?Wng1MkVhNVhqU2E2d2N4ZC85bHAvL3huMU1RU09oVjZoQm1WZlVmQytNbERY?=
 =?utf-8?B?djY0MlJxYk0wNkJ6dFRKTjdpb0xud01zYU1aNFZhcUJocVRZOHhNQk16ZVVM?=
 =?utf-8?B?T1BJMkFUVDFGbGZJbjFXVm5JdFJzdUNkK1o2RW9CMFhZOUxpRHg4cnM5c24x?=
 =?utf-8?B?REVXV3dvVzNidFJ3YU5XeW9VQVhSR1JCU0U5SXE4SHFiTnZMUURXZW5Mb0tT?=
 =?utf-8?B?NG5QNTFwa1AveTh2ZSt1dnlRb2k0Z2tDWHFWeFJGUVlvWXhqaXVORlB2ZVhn?=
 =?utf-8?Q?6/K+TD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFd3ZGJEdWlhaFBtUnJnWitBcnV5SThhYytpNlYvYXZObEV6eEEyb3k0UTVB?=
 =?utf-8?B?MXYvbUxKeG9ia3NXUCs5YVdFOEhaUlFzT0h2ZTNGZVhScy9pQ0wvZldlS3Az?=
 =?utf-8?B?T3R2c0RrMGViMmVLNENGOTFvUGtFUVJmS2d4eDlSRzRabit4RjBPSk1zdk12?=
 =?utf-8?B?dVlGOVp0NDcrVlNDMlZFTjc4TWdNTHAyNjJDejBBNW1GU3dzcFQyQ1I3ZTVG?=
 =?utf-8?B?cFk5a0ZGVzZEQWNmMWprVFBqSW9nc1BsZnBMRXU4ckkrWHRtZ2FaWURtdXVJ?=
 =?utf-8?B?dkY4VDA4YTBpcURQNWpGRTJQOVdxQ0E3Q3pBS2lBUEpZcmVxbk5DZDJMZ3NG?=
 =?utf-8?B?NThNSkZSUXJvRmEvbEYrVW9TaFNsRC9ueXBWa01qdzRYVXI1M3BvekZXeXNq?=
 =?utf-8?B?STA5TmZ2SVNVOHJEL0JRLzB5QzBVWWtkS1Fnb2Y1aDVTd0R4WXBXdzlEWDhE?=
 =?utf-8?B?bzVkdm9mR09XR2pCUGkyVTh6SjhVNUdqNWhwL2JqVVFKVEZ1b1RtVWNCWjFW?=
 =?utf-8?B?Y1RHaVVzU1I2Z093NmNNczA5ZTkxaWlNdDV1SFphcTdXdnBSck9DMm81U1Zr?=
 =?utf-8?B?VDR4akRmbWY1V3RqQmRvcTMyT205MXVJSDJBNXVqeUgwZVdnY2ljaGREb00v?=
 =?utf-8?B?cHJxaUZMMHJ3YmR4VGpYNTZJMGM1ajVmVXVqbHZIQkVqbDFaSG1wdkhBYUYx?=
 =?utf-8?B?RURGeWtPMVFXcVBHYWJaRE1HajMxekJvQ3UyaWZYZjk0OGdEbXAyYUdzSXF1?=
 =?utf-8?B?UVlRZ1ZOMDJDQTJaM0JmcFFoM2NpQk1jT241QnNGK3hHcEtJRDViZEJGSGhu?=
 =?utf-8?B?TExXYXc4blFVVlJFYUpJMzJ5K05TRzZMRWR3OXIwdzRnVFM5VlBEREhWWjBZ?=
 =?utf-8?B?ZlNIbHg3UUFuRnFwOXk4cURlNk9JTlZIRFhkZGJFQW5keG13enpTNWViVnR1?=
 =?utf-8?B?SFYwM0dRUFZhS2QvbU5lODBhTlM5b1VSZ25VY0w2akltbnpOa01LSGU1WGd0?=
 =?utf-8?B?aEhvZjJHVFVudDJmVDczNndsbkhDUjBGUXlqSEdyTjhTV2NlbDBNdE1MeGV1?=
 =?utf-8?B?OTU3Y3lDenAyd0h5WDU3NGRRR0VJejBUNFE2V2tTeFhrYTJIbjZhaE9rQkE3?=
 =?utf-8?B?MWlHclJidXYvZzBZWTQzSWdHWURjVE9NUHV4M1JWS0xsREpJY2J2OVZReUND?=
 =?utf-8?B?aFViNFFkVzRxaXhQRnZVMzlsNkREcUxIMHNwVDdOcFQ5bDFzV1V2czYxa0xB?=
 =?utf-8?B?VkdnVjc0Skx2QzBtQlF5eVlvTHN3eWhURnA5VW1abzB4L3oyTWFxbUJGNmFG?=
 =?utf-8?B?bHJsVklYQlYyMlVXVG9qUkFETk94T3lYZlZSWmVuVndNWTFjWW1yZlljbDBR?=
 =?utf-8?B?WktNWTBVVlUwSTFLQnE5V3RtMTgzYytKTHdSaHoycUlsY0RtaWM1TVBJNUUv?=
 =?utf-8?B?OG9ldEgwSm03UlNwUHAyYUs1K2hmcy95a2ZtWlFINThxd01KVXNBTVgwZjN3?=
 =?utf-8?B?SnhMd0Ywb1pDU3RaaGdlb2pPQjRmMko2R0hnMi9WQzNsd2tIMk9uSkUwbW1q?=
 =?utf-8?B?akFYZHdhRytwM1o4bmpHVXFhWGJEOUh6OThURTcrUDRtYWsvS0lUdFNGSngv?=
 =?utf-8?B?aTFaZExIeXA1ZVBYZUpmWUdVQVgzS1ZSQ3F1cWNpTk9paHA5aU1QVjVqTEto?=
 =?utf-8?B?ajFGdHpaRVdVdEU5RGgyMk1BSWNneTFaVk1Fdk95TkJsZ1RHQkNZS3ZkSXZh?=
 =?utf-8?B?NEZMczcvdkZwMEJoUFVraVU4bWxhNDZZOVBnTGt2S29HNmN0RWMzQWRWb1Rm?=
 =?utf-8?B?cVZDaUx4QjJDeWkvSWJkYmluRDhJNnZGZndxb2hwaFhLWTB0R0ZzWkFpYnhk?=
 =?utf-8?B?N2RDR3lKRXNXUHVLYXNBeHJUNEltbVNzLzRWN2o1bUtuTmdMcU5HUldPVFRK?=
 =?utf-8?B?RjVpZEZkU1VCZkI1cmRYTTdKSGd1dUhkYnlXNllOdU4zZXlNYjRuekhvN2dB?=
 =?utf-8?B?MlpwZ05aYUdLSW1WbXQybmVCbGZXZEw2dysxZDR0Tisrd1VDbm5NZmpyc2k1?=
 =?utf-8?B?SXY5c1dDYWNvL1ozTnllRXpaeFFoYUE2NEF4dDZvYWdVMUdnN3JwWWwycjdC?=
 =?utf-8?B?aGpoWE93dWh6cUkzSUhobDhyRjNnTmE1U3dEZUdwSVJYcWRjT3hSTXVnb3dy?=
 =?utf-8?B?Zk9Nam5qRmZIbUF2dDR0RGNCaytub0o4QWdqRVNZazJuUC93dFBXZTNnUGVE?=
 =?utf-8?B?ekxPYS9nU3MzV1RkL2dhRjg3Y2tnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83F42230EB922245B7F77145C3A77885@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vZB9goGA8BxmDHDNqUjr+UKDq28P054SnrwxPWn+YM/Mk5i3F70QCSQTmfJCUjLFeMGAtTYgLsYPNHvVZIFrm0ufRQjihE/aVYxyd0V0usIMGrCUy55k+N+xIKVxbADoaL9e3eIOZnDL8+zpsHSe0+7814hlfBjEqex6Ds1wgys0HC4YQKLi4rWmKMifz8nxsu/Es3pRDWxkZ3ypwJRU2ba7I1lwb8nABd05TmCij/1n9pcTiymADkCPoB/cfXaKwkht6EvJ5TjMFqqitEFu5lkOIr1pwTwRBS1B5cUJ9yWjjVrOlq4iaFSMcEDDm86JYONs/JFRGb8b64ZLzQBbG0eIX98EdE4ZJdbxNGV3LToP5+YCpZ1tz7Ff/Zw7C/HSWPIQp5E1dvR2XtQFSHlqtn456LXl/xJuElmcOEJ72IpgAMMsKGGkpyqtZ8rgYhsj8VRsdQWKPg+r9KQqq5H/wh+Qx029IPIK1MRP1hFAi3fAwpyuTX1v6y3tnlYruTMVveH45aqDXUL+OE7fUx5MX+u/u1syxKYZ95Ca/FQLsDrIKkIL1KSvT/H84onLfAKdVq3Sd7KGmedyNXQraGWS4///xFRHIKVdM2eigY4QlRBfTSk5IHOy9K0Q4ze7XPFd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9788fa-7a30-4f8d-7cec-08de1ab749f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 08:59:25.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAArw/PQsmYQ3wJ4bGj0VmyPJvwRbIAqpc29+rN5qWqwp0MerHFluqHLCSOJStGHA6eUxkERwvNliU44Hstv3DfhMKpFq+wVAGVtJvgRnJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9232

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
