Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E217721
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114043; cv=fail; b=DLqZKyo0FzxzTUaUO1UNIKyTYwWkwV/t0AJHK08C8FRbozKt3Y+qHOy2az5LlCdrXLz4Zr0bPTLPshYrHh1jvETLVRTdi6x1l4lSnUTpp9XQM4vSu26nQV6YtUg/gcmzza+fM66eRnKSKF/zum5oCCc7SPkMglThxD7oTwRoiI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114043; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bk0KB6LhMEV11DHQFHSB36i4IwzKurnBW8DG4rFVEo4H1lyhmbE2xltxMDRbsDdWhFj1lkAayq9lC7q+bE1PXC1oPd1uCLQYdli+X2JFZPzr4NIm8wVOQvuBwncWmihByVRaQByboXPzu+5j1YjeJxMl521hsxWVCgvBVkq60Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I78smun1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Do5iOvnY; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I78smun1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Do5iOvnY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714114041; x=1745650041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=I78smun1pg2/5LXC2QEPP25KxUEyNUK9YISg+ePSLlpSTF3cL0SBUAIK
   K1tPPlI9BuauRuesyavFxZZWXSHeQY9Xb+72WzBki7MikDk8VGSoBx2Sg
   HmuayabjsQPOcEsghINHNnr1aSuHey2GyTMG84V5IZ0tzGkgCc8b2CcaJ
   8nEjYzw+u5DBN7ExrRpYsnsogyckstby3tiUbbg6Y+sfvB1Bfp+sWxw7F
   u9KJEP4JoPjhK61ULsZVmmltkIzrcklZhyFNbfBv90L9dI0sEQD4kiZpv
   gqNsUo6b5PhBzACSGnqBBlbVKR6K9OQ/TNDMTqPx8TJNHyDEGuTkHdN6v
   Q==;
X-CSE-ConnectionGUID: BYLsntCiS3O/vPuf/yx9kA==
X-CSE-MsgGUID: cgEKgQpfTeuwnwxWWItmqQ==
X-IronPort-AV: E=Sophos;i="6.07,231,1708358400"; 
   d="scan'208";a="15655162"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2024 14:47:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2kEgiiQIdSOAxt/wWx7vPYpJqgVzbPVMHbULZPa4ToLlotDjDZ+kKirnoZJ2P90jDUKjkrTPcmC0cerAfUC+3a1D1WZbZodzkQ2ej37g0Sqrj83CJVPqnxQjN1e+GrsnziRVFgwXjIQ5PYKpG5T2m88/ROys94f7znqdWgSkcQRDRFBvo4mq0iJDeSMgMA4UJTwy8++6tfZpO+levlsmCB7nV0p51mdyBNspDZTLcIWX4cUzGL4p3FSYtndFNU291pR9TNBbZy7JmlAZ/gs6BQKGOBABDFGIqF98TEOlLHMOIFT1PGGATbRlh2aJ+ogyhLb3y5BrF3CJOpxzyQyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FepUgpMsAw++LC8s5XtzLf8NYQ7WcDHZrgJo+W3JO1UN8sWfwyuzmq7m2actYfD1Kta1SeTV7sz7dGKPq5sUISZp7dqrBEm+pGLoS9/wDsseIweC0XaHa6os88Y76dCV56vv1SeiUpI6bLTsSpmGChycvaOenfnvODyySxW6emxAOL1JaVRrZY+KzbQIXGPIogI74NGjBl9vxQqSn4a+2uDQMBwl+/huzyMLRmSuX/p7jkgbgf1FdpVYhsmVdK5382qKgV0GPePCUl+lvSIOB4oknm57eDx3b6GnW8wf1CyWX8oQq27rse6Sph6SAQ5gTO3PvUHwecIRhPksh5QeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Do5iOvnYGQf6ZgT+YljcoiW8SsxY0dNI/hVvSexHZZeAlAZuG4iH44J05qZwP4Yap3fhMZGCOfBWIomO5Dt1gU4yHs+bADryzc/TXBoB4zFvnvyD/SBF+BCjrElKg3mIzH96ft9Wk+55SAda3YOpKojFS/aT/uDdRj8XRSfBNI0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV8PR04MB9293.namprd04.prod.outlook.com (2603:10b6:408:25a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 06:47:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 06:47:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Sterba
	<dsterba@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] bio: Export bio_add_folio_nofail to modules
Thread-Topic: [PATCH] bio: Export bio_add_folio_nofail to modules
Thread-Index: AQHaly73ZRBRfdH1x0mDCTmEC7DMJbF6HMsA
Date: Fri, 26 Apr 2024 06:47:18 +0000
Message-ID: <daf17ff1-3751-4f57-b3e7-f2ca665a0f03@wdc.com>
References: <20240425163758.809025-1-willy@infradead.org>
In-Reply-To: <20240425163758.809025-1-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV8PR04MB9293:EE_
x-ms-office365-filtering-correlation-id: b7ddc69b-c298-4cd0-7620-08dc65bcb74f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmFFUUlIdE9nSmVjVnYvb3RwNWo5MUpvYkU1RjFNeWJrUDdxcW1rbll0aEtq?=
 =?utf-8?B?THI2dGNzcjlKSE0xVyt4YklLS2dWdCsxY2RSUm5Gc2loSk9IUFE3YUw1VXhr?=
 =?utf-8?B?WlR4NlRWQTc1Y016RWp0bExWVUJST3BHQ1hGTnI3ZmZ1dmloZ2lkOHZKWXA1?=
 =?utf-8?B?dXA0TEFLQWlOT1U3cTE5R0YvWC9QRVVEeVh0Rzl0WnlKakJJVStDV01RUmhm?=
 =?utf-8?B?ZzB1SDl2MGlMSjI5V0RUYzRvSVp4cHVFU1JIUkxRSVYva3Z0S0FzcXFVVlFP?=
 =?utf-8?B?YzhNMTFIVlBPMEZQZGNNUXN6dmJmN2k3Mi9ySFVDV3B1Z2VWVXRMU1U2cFBU?=
 =?utf-8?B?TWdqWnhyd1NHTnVhdkNBcE84akhJVVZxWEgwcm8rU09ITHVoaER4MVZXTWgv?=
 =?utf-8?B?d2g3YmU1Rk0zMGpNZUZFNjVyajRMNnh0NldMblg0aDM5c3pHVXNyVXgwWVN5?=
 =?utf-8?B?NHZjZjdBbWJkb1dBcWtuSU9nVDYyaWVGWWMxTXJ1NGZ6cmtaQy90RWVMUWxp?=
 =?utf-8?B?N0hwU1lrZmNMeVBEY0FDSU5SWEMxZldrbXJkcFFmWDhxKzcxU3FOSkZLZ1Fk?=
 =?utf-8?B?Snp1MUtSbnhsNU9ZTDRwYXVIeFc5SXoxZnlZeTVwcTd0L2R0WVpIMERlam1R?=
 =?utf-8?B?QldENDNuZ1lrS2tVVFkyc2MzZHlWeW9xL2xYdGRjZ3d2YklRVWtWL2J3OXg4?=
 =?utf-8?B?cVlZai9QT3ZrUGJKMDNqRWV0WDQzTXY0K09naTZBb3RFY1R0T1Z6ZDYwcENF?=
 =?utf-8?B?UmJtZStxODVxSDZKUStiekNGazRzZ040RTdzS3JrOUh6YWFvR1ZJeEVZMnpX?=
 =?utf-8?B?d1lGY2JDaHhpSGZ3OXUrank2NTZhekU4Q2lqUVpINktBTDh5Z1NmRFE3Tyth?=
 =?utf-8?B?b0tweHJCMXdjODZDL0lVZTk1R0p5SkZUWnd0QnRqYlQ2UFlCRzBhS0NLSll2?=
 =?utf-8?B?VjYrZkZQd2o2andIcVk3T29ST2xEK3pWSFJnZkNDMXFjdGpmSW5NZ3Y0ekJF?=
 =?utf-8?B?VGhLTkkxdUlqRHdRRXZSMnhCT0krQnZ1djllNG1CRjBuWEhmYnVTMnFxNmdS?=
 =?utf-8?B?RzZkSWZabDdtaThCSEtwU09LemttRTZwYmF3ZWM1RHk0UHNTMjNuZUxjYUNp?=
 =?utf-8?B?T1Q0cHZxTXVXZG16Mnl0RmQ1YVZ3OXB2V1Zocm9udFdRL08rYXZzUHlNUU5L?=
 =?utf-8?B?TGNIblMvVm5JR2FOaEpialZSTVVUYkI3TzhDM2xqa1Z6STd6MmlPNlcvVnhl?=
 =?utf-8?B?d0FsQ290NksyYlowRE9Qc1hXbVZaWkVuS3VOa0hoZ0VoM0VQN05kTHNrbWpj?=
 =?utf-8?B?Rzg5Z3Ntak5hM2V6ZG01NXk0ditDbUdHTFlMSTVNVWhKeU1BbzhEeE5Sb3Fp?=
 =?utf-8?B?M3Jpd1diK04zMnhoZnJxd0JYY1VvOXI3OGNQU0I0RlRFQWJhRGtsUlNwSmpU?=
 =?utf-8?B?MUlHQzJvdEdRdG5weHlPZDJNMkxiaE1MV0ZDaUw0K0ZnNktXOHVUUkJhTWIx?=
 =?utf-8?B?WFZyRlVLNFJWc2s4MzRaaCswaWlVZ29MZDlVdTcrZzZTMUgzYmtGeW9OaEJk?=
 =?utf-8?B?TG1RdmdlYUNYajlyUDRvU0hBSm1QSGlWQXVRK0FFRVBqb0YzeFZqQndlV0R2?=
 =?utf-8?B?RVRWYll4Ymw4ZkxzU013MWpPVjI3VXhPRXJ3QWFJa1pIakErR0NpT2VXVnpi?=
 =?utf-8?B?UXZwVm4wWFVSYlAvcnFKbUJ0cm5NNjRVc1R0SjIvOFpUOWtaL0w4NWkybTdE?=
 =?utf-8?B?K3ltS2FlcXpLMFZtSFdCNThGZWhHV0JYb3lsOEw3N1NzSEJxRmxqTERjVFg1?=
 =?utf-8?B?WnVUTUtTc2RmZmFTeUU5dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGdUdGhqT1BkeE5CNXF4QVhhRGswaDl0UHRMOVlLZG9EREg0c1VjaHAzZ01T?=
 =?utf-8?B?UkZDOUhVZkRuNVgzeldEcDVaMWFJTTNLMnVobks5ajlXVFBPREdXMUk2dWZC?=
 =?utf-8?B?VUFYdm5uTHM3Tnl5TUhXbWQ2VXMwVk0rWXY2c1JHQ2lFNnd1c0V4NXZHZTB0?=
 =?utf-8?B?VmJoR1B0REpDZ2o3T0lHS3hpeDlLWVBZM2Fzd2VXSWl1cDZTRHltc1BQWWwy?=
 =?utf-8?B?b0lIRGtUcC8wOHE5ZGp5YTkrRDFJdzVtQk9VRFpOTFRpaXhjZTBPcGt4bjBX?=
 =?utf-8?B?UmNzWXZITVhjOXBXbjZFK2JXdTZaK0J6a1JBYmlibzZoUDY0SjIrU0NESVNp?=
 =?utf-8?B?V2M5bnFxRDFsY0J5T1E3Y0ZWSmdBSFJHZVNOaWdVOXhGZDNYR2RVVGRVdTBy?=
 =?utf-8?B?MUQyd1hyUnJQTk5hdFFZcW1tZ1BPd3NNNFNkVWgxQnFPQVU4Skw0eENZR1Jj?=
 =?utf-8?B?TTFMYWQvcmpRQTlFc3M0aWpzMmZ5dE5QRVN6VzBLV2t1bHZ4SUs4RlV0ZHd3?=
 =?utf-8?B?RGh5WW1rNExlY2poZUJQYnhzYVNwV1VFbXlKZE9oSU1seVd5eWV6Z1lIS2RM?=
 =?utf-8?B?VzdHbHorVVZUK2lSZjZlcDh6Nm1rc0VNVUFJTm5PM0E5WVZWbGJYTkVsekQ5?=
 =?utf-8?B?UDFpeWFzWnIvZFlwN3lZcUdoZVdlVUwvSG1SVlBMV0tSRUY3NlBKN1hQMjhq?=
 =?utf-8?B?SnI5SU95VzVoNnlDL2hrM2ZNUnpYcnlXMkdjaC9mWDhtQnppY09NSXRFL3Rv?=
 =?utf-8?B?QUo1QXJ1c0FqVjNwd2xrcXJxOVAxVWs3UU1OaXl3SmNOR0k4bGxUSTVFcjlN?=
 =?utf-8?B?QzJHRS9NYnF2d2xrMTdNRkZ0Qkd1VmcyVlJnYkdEWUFhTGtFU2J5c25aSXB0?=
 =?utf-8?B?dzF5TnMwVm1jWHpqZDNKcGlWOTVkTVIxRTZvN21lMDIxM3dMbkMydVkxVTNm?=
 =?utf-8?B?cEozeXloN1dLaDYzVFUzcWYzb2tDVEYzaHY5aFV0YnpEWTc0ZW44cWxnUVUz?=
 =?utf-8?B?VmJRenVvVG93TnZaWjJpQmVHdjRxQXJlLzZ1VU5nNmJmL2E3S0JuZmFRTXB5?=
 =?utf-8?B?R1JRRDNhZ2hTaGVSUThhN0dvQkNQbmZ4MlBxc29FK0NtK2dtU3ZGeVhBdUZX?=
 =?utf-8?B?enYyNzNNb25FMWEzK3RJWVhFbFROM2s3UGU4UUZhN29KWGl3VE8yNFFiNGU2?=
 =?utf-8?B?UzdXT2tPTjZZbEZwa3F3c1pka21EU2NuclFISFRQRDBnTjlXNDErQ000cEMv?=
 =?utf-8?B?SDFXcnM0Y2FmMDdraVhYc1dDQytCYndiNjVqMzZ0T2xKOG9JRVl4R29PeVNW?=
 =?utf-8?B?bXczRWhwS3RKWncvbjk3cVpNZEswVUhEYmt0UGZtTG11bTRFWnFhdUphalJC?=
 =?utf-8?B?Q1dyQndGTm00ZU9EQVdLUWI4V25QZzZDc1RybnVla0FhUWZyeDNnMmdCek5z?=
 =?utf-8?B?d3pnOVhDUGdyd2xpVWNVdC9wQmFJMFYvaE93TkV6YTVlZUEvSUJ6dXB4cnhv?=
 =?utf-8?B?MkxTQkc1RmFyMnNmSzhGemFKRm5lTVU4b05WUTlGY1EybnJlUzI1bElGS3V0?=
 =?utf-8?B?QWdkSE9yZDNaVHhkVVlhektyNVlob3hWTGE3blBPVjV0SGpJYzh1bFhqQTRy?=
 =?utf-8?B?K2ozTU54TzB0UHJPNUU0bis2Rlg5ZmRycGhMZW1Yd3dsOUR4ZjFSVFk3elFG?=
 =?utf-8?B?N0hFY3pWUm1rY1NFL3hmUEZtQUZoamY5ZzNpV0c4Y1ZlM2cxVXlURit3aHlY?=
 =?utf-8?B?a3VWSkxrZnhRbnh3Q1NOdGthWllRL0ltWmtubFFRRm5JeCtEeWJsMHBNQVlC?=
 =?utf-8?B?bkFGWm5MWGdSczRsV3c0Vk50RXlLRFpHOWdJdU00Wm1YODdHQmxBOXlDaTBM?=
 =?utf-8?B?QVBNSlZ1RWloN2RaZEFDbStQUko2dk80UVMzcmFZbXN6b1hiTjJyU09BOGxn?=
 =?utf-8?B?NzdvcFU3NkpnVVEydGZtM1FmSlNSc0wzYmNucnBodkMzTHNwa3FMdkRqazB3?=
 =?utf-8?B?dmhpaENlbWZpbGZVUXV1bjFvR3VSd1ZzZ25kNnUzb3BlWE5qdVRmUVAzZ21o?=
 =?utf-8?B?ZzVmekR2Q1hVanRqaWE3ME1UNzIwQWhpNDNUUGpuYkdRTXNMTmtLS0J6OEhV?=
 =?utf-8?B?KzJHUmRteXFIbHYrNGttejdaM0FTbDZwQVI0WnMvSExKV3V3WS96bGRxOEIz?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE0600AFBAD0E54FAD7122B65A791A4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4rRuhO1ssI0A6KZ4XiJlBZ1zEQK86/fBwKytALMWvz3GeQS6qTTNzIc2tVidb5uLkJ9YETjYjfGldjbiXdn9UVWTBHN/wRgUKwaPEm3OWV0ueEXzOGKsFHLWSvp1EkroqcbkdwXZOi4Q+9EmWGXxr0c7466ICRy7nYkDhUdrnkA5HJJcqGmIJJILOeY3kJU2Er5Tdm6hkvcgRRwbM/db1zJPX9M+Z7azVcDnvtwvHd+1MFEiXF/FSm+SQeBjEuo/M8XC1C7MM0MdH+7O+9vB8MUoYmVl852dKKuYKXirVNHao6VWWmAQV5Lc6HSD7BMLFRWivAttlXg1NKNnfNeYIWeBJuzHl/wBjn4yKzRCAqcq15oIBwLoGtpRR5tM4ALBhW1TZGK26z8U0Md9NqsAbvk2Lt/HNg1YmIehJUhLzYEJSJatBFq15xGzTRl9qxMgT7f6yLVcULntkSgvUWM4p9jnBtp6vPFpNihP9VuxxDIhq65bxyHRWg4Q9y0TaJ5pkImXAt8TII2CzCmYO9N0OrfRw5WyUBGYqw2cqs5cSjMYSnOmrgwiKhEO4bHB33n+jbtf8vHrwNFC4fFU+mWxD23FXmkdTrcYR7VtcEtRQLOFZypDlBASlmaq82dUhWb0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ddc69b-c298-4cd0-7620-08dc65bcb74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 06:47:18.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54j286mC9qxdvjc1wp30UiWtyZmpdkbO6NL+9vLP7uMvPLjCd5lOyXuTBB9JS0cFrEUjZW5OFsjzmdjOm/PNTR0mxRMipbnvIZbHLVVEHco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9293

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
