Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05629E112
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250216; cv=fail; b=sZ1/jKmFoZAx3ERv4Nz52zLjXeD3YrSzn/Zy2pfCNMC3lFo3epIdcMRSYjL8Zp7wX8CcvLbteeCQS9CxSjpVztubQ4I0+3KTmnBDgLYhc2mcKyLVkmK+MTvP7uf3g2dtLlVCFSiTtFwDFbF7N4dY2ryNWeQCRlnPXg7Xdi8OC3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250216; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=coygXAzs1z5HZOwxEYFxuWQJp+M8bnFhnHIPhuJJsOgvZFfN16API+EeqOrcnGvplQ5razMoFQubx8o/HPoab8K4q/R19hnSriIBQ9gKAeJ0fZvmsGshL9Amlbj1J6evs/xl6uIY0G3Mr2yKSqHwQib04S2lH4ZcX3qX2gpF+T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IfNWmwSi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KmrEsop8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IfNWmwSi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KmrEsop8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762250214; x=1793786214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=IfNWmwSiCMWxNbpMOYyomphNsng4jZmTMBGuxiEIv4Loq9j8GvujdmYo
   Je8tkP67Nqkw5WrPG1cbXZAUqXZvaI+kK4bhyjqcKZ9gAyrK9dqtRWDV4
   n4AskOmyp+n1sakkehzyWHDjqNryosuOW0UBiPj20puDnN9FJ9OFjP3j1
   a+EdhbntTKymonQs4IJQjfIcVKyayYqYcMopahypQSDUyJ9XpSiPilC04
   po1WDSturbB9LDIoe15GMUVTBC49woq4piA8qJuQ3K0Md6Orc8GwfBsAm
   cQLP9dgbQ0r54XE3hIIyVlswJhaDU2TFQZvqvic72a7UpCcmGS2EtT0WE
   g==;
X-CSE-ConnectionGUID: yl3UmLlaTnmVB5WrizBybg==
X-CSE-MsgGUID: RBTuDwEqSvixObvHoVjwsw==
X-IronPort-AV: E=Sophos;i="6.19,278,1754928000"; 
   d="scan'208";a="134103254"
Received: from mail-westus2azon11010036.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.36])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2025 17:56:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTMbJIcUl3gyxwsg0WwOTfkGI7rMj4gYUIHPxTO2mtDNyixfmbu6jwLpQUL6RcTWQL/F+gRy2k2ntCd2FCSTAoIsV7DY65EIeI03paRS7Dgy8Aj6bfn3/+pxapQKj6uXSR0lu5TXtpvrNrhfYbxG5KsTa7u4hnk3Zeq6JBJ3p3QZwVN39qvgtthn8bRWTZ75bXW/rLf2/p8m8mRn2tDB/34MJZVP7ED9BtjDrYbvzk6ERySjkAzH4xXrCJmgzR15phKbbIE72GYb61wZ86zJLSj+2HVDy3Kehx0z8UUGDMLIbrtkWXrN97PMrXqtMr1QdGADNfNYyVs0u7lnf3rP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=awvrPbDc6nx2ynwWtccY5WfH+xmk1dk8O/q0JD/FRFlTONXyPs0yRl+JEzzJTfOX8300pqWN2MRC7NXPpEfY29EZlud5E8/0QYKYR8rul5JKVCj4qje7spEkh0OrcjLqnWufBU/0ZQQO0L4Cx69s+Qp0CsLM6DfGMvAoBr832mImVrAf+9Ep8hbIEwPxw+S4PpNrFYFkoDoysjc2YilzqxCr7k47bt1DtkPHhPXgnxirDYkbTWqFRCd+r1JhZEE1W2/pv3u4C+GL54seZn8W36/+z53ANNGsYHsVeZeT0OsdCvdTE1BfihkQnsCoo6dRgYuJe4mB2DyOVPIIZwvumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=KmrEsop8UBDY6P1V4Xfwua5XS+P6MmSAbKD87E2skgT0e80Lqtr+PYD0QkkmRkCrOII19IUwqbMF1L953d0YdtqwdSQPecfR50GbkFhcbZ7uFz56U9l2tB7mcZEzMFPjNoDbf3nLBQWpuG+4bP6ie35k3zVG9bjws7gazpKnS68=
Received: from MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19)
 by SJ0PR04MB7312.namprd04.prod.outlook.com (2603:10b6:a03:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:56:52 +0000
Received: from MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::30e0:2f81:e3cf:78d9]) by MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::30e0:2f81:e3cf:78d9%7]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 09:56:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] blktrace: add blktrace zone management regression
 test
Thread-Topic: [PATCH V3 1/2] blktrace: add blktrace zone management regression
 test
Thread-Index: AQHcTR47M1rvxkc6XU670ZrNjyz0r7TiSHKA
Date: Tue, 4 Nov 2025 09:56:51 +0000
Message-ID: <5a757a60-f1cc-45ec-a749-e78e68bf2784@wdc.com>
References: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR04MB7411:EE_|SJ0PR04MB7312:EE_
x-ms-office365-filtering-correlation-id: 1691688f-07e9-4020-5614-08de1b887a8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejJhRk8vdW1OV3NjNXJ0MkJLaS93Z2ZmenI4TmVPQ0xYSjlsVkFWc0FEMHVB?=
 =?utf-8?B?bHhZMVJ4cXNwSlBxTnpUV3BsSkRmdmRaWjRmcnFEdDluallQQS92bFNiUzNB?=
 =?utf-8?B?MWxlaVJKMkdnNlc5L0ZDTnBZVy9qU0ZDcVBPZTdWK2dTYmVCTW9RWnAzUHVX?=
 =?utf-8?B?RDFSZDJzYVJvUjRqUE5SUlMrZ2ZhdHdBUk5NelBHUlc0L24wY1YxakVqSTFS?=
 =?utf-8?B?ZEpOUkRFWGhmQ0Y2bGtyaWhMVEtwUGZlQlpQaEgxZkwya0d1eHZlYnpUWFph?=
 =?utf-8?B?a1F6c2E1by9CYjVRUFBvQWJZeTMxaGg0OTREbUdqRzkxelhBMk9JSlgwenFT?=
 =?utf-8?B?RHJQWUt0d1JXa2dmZmp2ZEtWTXA1bmlOTjJEMm5NaGJmYy9ZTnNrSzR2Sm41?=
 =?utf-8?B?alIzNUx3M2JzcURjOXNQTGs5RnB2dVJNRk94cSs3U2FpbnlHWUdGdDhkTzh2?=
 =?utf-8?B?Uk50UGNLQ0FUeFE5NVhaazhwa2dhN3JnY2tNN3V2b2lYZG1QQkVmM0tmUEdC?=
 =?utf-8?B?VEhST09iYnhTaVpXRS9SdERzWkIyOUg3ZXhDa1BGblB2Mkh5YmJMOWFmaHdq?=
 =?utf-8?B?TWJPWXFSTHVGcjN4UlIwRExwcGJmb1AzMnNhKzhqYUVpOGdHQytlVVhyd0ph?=
 =?utf-8?B?V0hlMmhZdkkvUGZ3UHR6cWpKYXJTYXN6NDVUQm56ZE14ZWxFb3k4UDVSNFhD?=
 =?utf-8?B?dXZydXJHMnhGYU5jN1cyV0NUSVFZT3Ntamc1SSsvTzh6N0IyMnY0dCtJTmZQ?=
 =?utf-8?B?VEN2MDg5UEh6dFRTdFlaM1E5ZXFUMjdsMW9oalF1NkZ5WnozQ0F3bHFaaEIv?=
 =?utf-8?B?OGJuVzFnUTVnMWY1b05wS1UvWUFaOWhTOVlHTTBieGRuelloMDFvWXkxM25Y?=
 =?utf-8?B?d3JTVmJxMW1WOGhWR2hqd05RSWo5bkNGeGptWUNkSm4zbnNGcW9SS3FjTHJi?=
 =?utf-8?B?TmhhenBYWWtRTzZNY3VZM1UyTWNHbXgrLzZ1Y3VKRWwvTEdXRHljYmdFclNB?=
 =?utf-8?B?akV6Z1BhYkI0QzVWS0dXWVUxb25NQU93T3ZIK1g0bk1iZW52VXZoY3MxMjdT?=
 =?utf-8?B?ZTFVazVpUDNYdlZHcVNYM1l2UVBxMGswOFlvVUFzRmdxT3Y4YXNqaHkxb2dX?=
 =?utf-8?B?VnE3OUZrUUd3TXdOeGU0NVo1RW5EczlOVkxYeENLaGZzSCtSbURLZ01qa0RD?=
 =?utf-8?B?Wnp6bXZqOGtwTVFpWmpTd1JFZkROSEdlY0ZlUlljOUpoVk9OWThiclBDZnoz?=
 =?utf-8?B?MUp6MVBNQytFcEh6ZnhGclMxb05DQkdPVVdJbDQ3bXZjZXU5WFBYUXN3czlp?=
 =?utf-8?B?RzRPR3JwQURSWS9PUlV4K1VmaGdQUHMrb3VCbWJ4Tk1KWG9FU2JCYkhIc0Q2?=
 =?utf-8?B?cE51Umg2c2JZY3cya2JmZXNwdU1Jd09PeHo5R3FZWXZabEw0djA4OGZiSGkw?=
 =?utf-8?B?SE4wa2hTOEg5MVNyU3FtNTlncytnV3U5ME5ERlM0VFNJdGtrTjUzSitoOWtX?=
 =?utf-8?B?L1U5RENWYjgwU2xidWRoWC9xQVZTbUlJSWtlaWpDWlA3RVlubWJoL1JJRSt1?=
 =?utf-8?B?K05jRmQ5NlhCaHB4NTViT0hNT2NLQ0phcDY5Y0ovSHhaNWdqZzZCK3NXWkpn?=
 =?utf-8?B?L3RYeDh4YkxJRHMwcjl4K2pGOUF0OTBRRGlpejlEWnh2WG91bWR1NkNPZU9Z?=
 =?utf-8?B?TXhJTjZGMmFQQUpyeXZuY1pIUmR0VFVxanE2VFZFSXZMZXYybGZsQVhXZXE5?=
 =?utf-8?B?YXBBSXVRVmZKSVNGTTRNSldBS1NLUjB0U1ZLN1lCbWY5bWgzTFJaM0tBaFJW?=
 =?utf-8?B?UngveE55UkJIVjJMTWhXQ0NtZFUxNTNYNlNLTnNra0ZZMS8zL0t6aE9McHI0?=
 =?utf-8?B?Z2I0ZFk1ZWJDbzRvM0pIZWlEUnFiSWtaT1RPcDQyMXJtUWlPeGQ2QUpyaEYw?=
 =?utf-8?B?UjllSEtJZ2c4Qm51eCt1SHZCa0gxbHhLN2J4c2ZpREpZNEFHMkxIenBVa3VJ?=
 =?utf-8?B?L3c1c3gvc3FKQlJ5eS9JbEtkZ3ZDem8yVWxoY1drRTJER1NLZUI0TXFIMGlV?=
 =?utf-8?Q?mAcZ3z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR04MB7411.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkY4WFRYN1JSQWRGUDNVb1hVdldqSkYxY3pPR01wL1ZrN3lSdXZidlBiN2pp?=
 =?utf-8?B?d0tXemhlS1NrKzU3WVRsUWZ6S2F5WlRmNlExV1YvTlJhZlBJZnovMjM1U1px?=
 =?utf-8?B?Q0FMRFZTcExhL1NSVnNDeWdwOUVtd0FQdXlUOGFZbk9VNi9yT0c1ZWV5RHc1?=
 =?utf-8?B?R0lLemZrOXdnYUlQbk95K0FCTnYxUjg2UXdYa0V2N2RFNG1mWGQwVXgvUkI3?=
 =?utf-8?B?VWNRdk4yaWxGaGlqbEFPL05ZSU9Jb3hoQnRUbXZoQUYvZ3hycFRQK3BVWE8v?=
 =?utf-8?B?cSswYUhaUHRrbC9LSXBwMisvd25tTUdyTlA3Q2pjNGVFZ3kzWHpXUklwY1d2?=
 =?utf-8?B?aFh6QXdJdEpMU3JKbnFCbHBJRnZBNWRGUHY4STdDREdRYW5LR3pvVzk5OGo4?=
 =?utf-8?B?MStIenQwcHlTdHNVeHZ2emgrbXdMQWJENUk0ZklMdWhWd2R4bTM1dnlqeHh0?=
 =?utf-8?B?K2VvOWNETUVsa0VYeDZoUWdSOWtLOFVERTdvRXU4NXpJU01uVDJPb0ZPRWRl?=
 =?utf-8?B?UDR5Sk96T21SQWUrcWhYOXJPcnZ2ZUZxdmVBd3BDNWZZSkFYenJUemVnRVA4?=
 =?utf-8?B?bzN1TEtNVVAvTWoyc2hpemVjaXF0S2Y1ZjJoZFpjaDRRNHc0MklGNS92WWhs?=
 =?utf-8?B?bWthQmM1bFdKUDdaWnlZZElHYmhqcGsvRFRSL0NHMjQ3a05Ib0wzY2U5TzZM?=
 =?utf-8?B?U1NuelY0bnFWMHJsT084VGlIRkRveW9XN3dIbzJSQ09ibk5mTXl4SzhBZG43?=
 =?utf-8?B?QTJxM3NLWDBpdEhaVndVdmtXTEhFVi9oT1F1U1kwN2JocWg2NmRPdnlDTUxP?=
 =?utf-8?B?ak1zMlFJMjdPelpGVUgwODZnakl6dTlmRmdzV1dxbzFxeGowQ3hMZjFtR0V6?=
 =?utf-8?B?RUpLTElkMVBHVGR6YzNhVHhlMXJSWmlSR3NWay9jdGRqcXhwSkc4WXhqTng3?=
 =?utf-8?B?YXUzT3AvbEZsL2djUlR0dWllVlpSWm4wN21oa0ZvWW1lb2E2dW1LcXM3Y3J1?=
 =?utf-8?B?TnhjSWpPSDVHYlhQL2FVZDdwOGduL2xUeHJ3KzczdEhJYklhUXF0VTFyc0NW?=
 =?utf-8?B?SDJaWm9MU1VvdEhxbEhGSkxOeDJxYjFkR1hHVkFUME1TZ3hXWGZRS3NBOGtV?=
 =?utf-8?B?bVJUa21DYUV0VXRsVTU0eGZ3RWtpRmMxWTNGZm16R2xHMU14RmlSdHRtcTQ0?=
 =?utf-8?B?T1hzUS9EYXA1Ymg2MGwrSXh4U1Bpcy9qS01WcVpMeUhFV2JGRUczNmtEMWtD?=
 =?utf-8?B?VzdFWGlmSE9uK1ZuNFFWRUNHSmtDeW1hbTJ4YVYyWUdtcFE1NWxpOUpORmVI?=
 =?utf-8?B?dmdvU3FWbk5BMXVKb1owTnpQdjBtZkIvSlZiTVhYeFRENkdxRFpxallTbjg5?=
 =?utf-8?B?ekNva29WMFNzRjNhSzBUVk94ZC9zdTNRU3Y3aFR2Nm1QRktYZ212SWkzZTFV?=
 =?utf-8?B?aC9aTlFkQVVnbXdCMkIyLzh2MUsvTVh0SWJUMWtOSW5RL0dpUmsyTE9MQ2xj?=
 =?utf-8?B?RnNlMkYrOVRoOVZiMldCdEJOVTZEQWFncWtJOE1kODRRd3MyU3FTWTd5VmFL?=
 =?utf-8?B?VlBSbStBNXFWTlJFTU1WMWx4dndPTlVkS0hmZngwc0krNENjMzQwSjVUTktW?=
 =?utf-8?B?V1Z2UXN6QXRLVHpTaWtDV254WW8xVjVMOGhOVzc0dnIwUHlvM2loVVZVNG9R?=
 =?utf-8?B?Y3licFJYMnJZMER0akNCZXZPcDRJaWp0ajJqM2wvUDhjRTNkMHZIc0dpbGtH?=
 =?utf-8?B?V0h2Y091azBSZC9rblVCZUd4OGJHenpTOHNZcllzdFdZVENFVVNtTHd3bGtq?=
 =?utf-8?B?K0dhWS9rVjlPTXdNTk5Za055NldNanNiT05qR1lzdGhYQ3dnVlRsZHhhcVBl?=
 =?utf-8?B?MDRpRXY4bzNaZ09GK0lLRnhoSU94QlhmNkNwOFp4SjVRNy9BMGZUQ2dMT1Ja?=
 =?utf-8?B?L0VMUUE5RGdPUnFhWG9jYVlZbWhXcHZlZDZ2aVJSTlI0dkJVNW9tNGdIdkk1?=
 =?utf-8?B?WVZkbC92Mm96WnE3V2FUbUVTVC9pZHdBd2UrRWNDRWF1NkY1SElTMDZLTVNq?=
 =?utf-8?B?dVl6YWhhdk9lWVhMT3Rqc20xZlZvRVc1Z0R1dyt3ZGlkSGdFMVcvbDZkRWd5?=
 =?utf-8?B?aGtWRGwvZ2N4WXJCalhYcVpnMVFUM3BKZGV4OTFVbnlMcHdQQlpTQ0VGTi9L?=
 =?utf-8?Q?DIzECwmomT/WRdAJgXI8Kw8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE1043272990B4DBEF5FB0214353232@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+IeGt2p7z5I29JnNOWauGdRPDqu5isO85ioGKxq/ezF9/pHjRP0omdKeuZ6PIT/Mv5znIDT78JuecxWrZ2kCZHo8RSJLfolqyR0UoKJtLWDBF4q1tgZ4XQOoRoqpphCDGFP+8foOD0Ck6L7G4mM3VCmzptISQaomdnyOprnGDSd3o/4dTiLjXqJ43YnN/DOR4zjk1mzqaRbKP+56VCLVTeDyY4iM4DGKRtKqN0uJNxaYTiOVnh0PE9bQeo4SKMfrywFI6zVSG7qi5AfHrUYJezACNWBG6MbWnre0t2/GikVbWCOREHsSTdJ7aKFVfpdCG1xQZ6PVCxzp9KhZTT9EDIhbj50+PWKc6ETc77CJFBNpMHbVLTHa9JQyU6+Q1mEv2r5JRHE6UkzBb+AiRGFdXqr6hgOwQZ2zdxmHkHbUP3mFPKLso/VUIpGoilaue1HpJUJjMYfCJbr8KFNU0rjQCD7nazRUTvcNVgJZw2bd/p6rRKCLBKuK86DMvtEU/BZJlUi7b8qMZuoTEIBN7Pm1f3xNshbzboM2KC6JnYuF9aDuPuDsu6XxJ2cZPFhOmCAmE9Gftbu1pgBC5c0rFpOYNJuwBfXGQyIUJwLyLsuRREtgrWKhH9N36USniiZnex98
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR04MB7411.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1691688f-07e9-4020-5614-08de1b887a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:56:51.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kw6+BTI399qYnocw9E24cteJqK5Crw09IFDaaaJMJdVvrWq9hA5FlQAIDMCFo29CtE/Nzo0J98da8CMSsN3JBewqBBqjT3uOjnhCTY8Ppn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7312

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
