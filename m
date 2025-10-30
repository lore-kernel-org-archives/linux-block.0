Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A255524F
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827543; cv=fail; b=hDWgPgeZt2uAOpTw0nKGAQAON2Fp/ltUe6uW1cXPpmCzvLyE9lVmujGv5gRtuR+MpzRiJHbSYALvk8vllDI7hp1//HBr+aV4e9uaVktUEYy5tWnh/FxDjWHzBnMDILFuX3Jy+N33lGLBLRdOicwWTRx8l+hYOZLaELoCSGEnLSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827543; c=relaxed/simple;
	bh=WmaoFhg9GMKMB/G0O8uiL1dTeKZsnBNxhSz7mGeHb8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofFDyFD4Q+XSHAdHJgUQSY1J7Ee3Ik7Z+giCuGfTAx0sxivcjfZ+gU6qc6glX5TkGNL/p4lxVqC++sDYZ2fPyKxSFuoc37bQIsF2i8mIAXZgQXB0LnF1HiYHhGEYRgBca8Ub+kqOfypsU6KfV0jpGakMD3lfQ+EIVTRNH08NqHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YRvspyDm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=e810ot8R; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YRvspyDm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e810ot8R"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761827541; x=1793363541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WmaoFhg9GMKMB/G0O8uiL1dTeKZsnBNxhSz7mGeHb8M=;
  b=YRvspyDmbv18cKZeztDNysXkQqUR09ses9xSZPnE3P0YWFtpCpD504S3
   nMR+LJjaURr5Lu7zB8knnDGeWDfqrz8X6sp+g4DKLpKEcdyjxUSf4hYAG
   rWIC1JGHpeEMeVQ6N1fxlsuyknFJHi9uZ2Rb/K0onGlkYB/JA/s/TSGfO
   DnKJjNwpGWa9W5yvUCUWqA6jaY7n1eiZZudnemipFR6Sa/nUJ3+lPmpFA
   Dek0pL/Xv8AMy1O5p3BuYLOZR2JoQzVhw9xV9tfcDkmj7iKKhD6metGZ3
   RBG7K0mBaF6AqYTNetm0Bj+62GzznnlQ3nBxVTDr/yXCJv/8Z73IHIGbl
   A==;
X-CSE-ConnectionGUID: jPoHiCZcSmGyimaXEJXSaQ==
X-CSE-MsgGUID: psotsUqzQY6yLVH6FprdLQ==
X-IronPort-AV: E=Sophos;i="6.19,266,1754928000"; 
   d="scan'208";a="135129219"
Received: from mail-westus3azon11012038.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.38])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2025 20:32:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zlt001GxpbY0HBpRHqdAgArmcpidJrWmBv9pKaKJ9QHOD0Do7Vh0kxzWhbjYsOeL5eH9+iG4neDxROZF2pnY88Ys5RIcLCzbc/Q4F3eVXnn0W5Q2qBjxHcafToTh1CEHJw8Z7R/j77gK12DkDzE3zHSgpG3bERhVY4Q8SJd+5c06T8cYPI6LmnElVRVzQmyxo4tTJNrh8hIC+6CxKa75YzE8Gayr5RdjJRg4xgwapVXCTmATJjEFt47qOPc8qDwOg2iB/nMMqmBOvpwjMrz0dQ1s69M+T0gEU/+8g2S53nZCGDFdjXC3nLcsvQHrtsPjp8vkr5y+OfThmQSLKUWOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmaoFhg9GMKMB/G0O8uiL1dTeKZsnBNxhSz7mGeHb8M=;
 b=rRIKFSPRRB993h0tOIVe0zN8ZpBUIgEzMeuPFxDx2t+pFC8ne/mHmpGlgyoTHoohctNfR6Li1oKdTO03+YQ/k+XDrj9xDed/qQZOFPYkqZXrnAgFLx5QdZTKcO322cuiqZRP4Fn/6tHd7vGsUv/VfNVOMTFB6xoUUQJxi7LB6uGeXTDiGthsyPJPtGbK3jwdnkfbEJ1hyR9II+CkbU2X9LjOt9zc1TSHTnmiBwAcqxkE6Rpfd/lp1ZNvjNij+UNwUIQbPQBCMhDOx+sN+JDOBXML5fzLuSJxEraBIknMAEhXbWmUcJgQ4iDhkvmS72xETs6sfFUSk0JTH7RHlvqg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmaoFhg9GMKMB/G0O8uiL1dTeKZsnBNxhSz7mGeHb8M=;
 b=e810ot8RMsZb7Dn2t/7E+csZYISlT5hdzC/L4orWeyB69roZKS7rzpcCB7Kdo3Ag0MM9qn1gdIXxhIZhEz1bakTttKcZWeh8ezs+UJllguf8BZgB7MTgRthALCGgyvFUaynu2BUTVLn7pxHaDRSYqetL1Ke+ml2/i9vwbpQvWfs=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by MN2PR04MB6766.namprd04.prod.outlook.com (2603:10b6:208:1f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 12:32:10 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 12:32:10 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Thread-Topic: [PATCH] null_blk: set dma alignment to logical block size
Thread-Index: AQHcSNmRMl31g9c7cUqN+P/TmYvZCbTZKlqAgAAWbACAAAmBgIAAAp8AgAFT0YA=
Date: Thu, 30 Oct 2025 12:32:10 +0000
Message-ID: <d0efffee-0d5d-4ad2-aece-599eeb4d05dd@wdc.com>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
 <aQIgvwec4Ol7ed8K@kbusch-mbp> <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>
 <aQI7hyET6f-nXnmp@kbusch-mbp> <aQI9uiTuEr8hbWbC@kbusch-mbp>
In-Reply-To: <aQI9uiTuEr8hbWbC@kbusch-mbp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|MN2PR04MB6766:EE_
x-ms-office365-filtering-correlation-id: 0b5b709a-a6d7-4d14-7b6c-08de17b05909
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXBHcC9odm1NY2o3aUViWlRJUVdNeEZIVFNYV2YzRUZid3RINDZNQWNBdG15?=
 =?utf-8?B?Z1NPaFFMVmdyWXVDTFg3TVpUMm55RHNPU21kUCtUMTMrenR1NzJLT3NBNFc3?=
 =?utf-8?B?dEg1TjdsVnBzR1NNOENTeWJZeWd6RGpNTVllOGlkZ2UzWTl2T1M4ZEw3NUZ6?=
 =?utf-8?B?L3BQRTJJVWQwbDZRVFFHK1V1VFBzL0R4V0VLaFlZMHpHanA2RHU2bHM4L1hP?=
 =?utf-8?B?RDR5dVpLeHNkVi94aVJwWUJ1aE5KSHdvYUtpbnJETXJjVzh1a3J5RWlCS1cr?=
 =?utf-8?B?ZTdXeUlrYThEVmtSdVFiY05FQlpta2dxSTA1clUvSzRYYWdNRXpmSG9kaTV2?=
 =?utf-8?B?aTlHOFpPZStmcWJXcG1XWDBkOWRXVXl3Sm9tcmtMYTZNY0t6WU9URk4xNGYz?=
 =?utf-8?B?dkdpaW1WejZEc2trcnU3YWRLR0VBTkdVdXFITUpiTWlNbnJxcWE1dEVSaXE1?=
 =?utf-8?B?cnlJUnhkQ0lyL1pWYWtkd3RhRzhXV0Y5L3N4SWpKNXFmSnllMkRPTW1NVlNP?=
 =?utf-8?B?SHlpWm1ZWXc1T3A4ZXBtWUZMOXQ0STh1VWpSSGdKMTdqSDkweGtCQnJpUHlh?=
 =?utf-8?B?MFFlSHZhejlTQ3p3NkVuektKRHB6UGlYc1dBZWN3UmlVclh5cGFUc1ZySjZV?=
 =?utf-8?B?OGdqT3dwY2JvZFZKRGY3dXVmMlN1OTV1WlFHc2tRbnc2N2JOZW1MVEtxT0Np?=
 =?utf-8?B?OGtBSGxTS1lxbkdLWUJVaWNUYkVkMjk5b0hmaEZENm83MUVFcWdkU0JiWnJW?=
 =?utf-8?B?amt3Qk5RM2hDK0lWUG1YYjZmdVZIbnFtQ2NQNjFickwzYUp1alhWcWFKOWdN?=
 =?utf-8?B?RmY4Wlc3emhRRTdUZVFDZHZPbm5NNC9sZ3dqSURtbUpGQUd5MDFLVGdNSTI1?=
 =?utf-8?B?QkprL21DZFZMc3hjeXA3MFp5YjNEWHJFcFJFWnIvY2NJb3hIYnhRRUxJREVP?=
 =?utf-8?B?M3BleDhrOHBBMWkxZmZEZEwveWRiRTZPa0prN3dCempYZDR4Vm5pamthVHhS?=
 =?utf-8?B?WWtOWmNCQ0UvaUNUdjZBRDgwN08rYkwzM2xLLzRQc0Z5REJQbUtTQW8xZmZl?=
 =?utf-8?B?emlWa2NmTFJ5TDU5TVVWOXJZWVF4Z202bTRGY2k0T1RSbVR4VWg3Sm9pUjZl?=
 =?utf-8?B?dng3em5taWNDamlKSGJPbHoxOUw5c09EaEoxeGJPKzdVWlorWnVzTkd4dlNv?=
 =?utf-8?B?UFBLU0IxNlRnSGx5a2RYeUg3NVhZMThCRUcxWVN4cUFwM09jbkRQR3B5VVFI?=
 =?utf-8?B?R3ZkUnhpRUVMdGxtd1NlRXYzMHJpN0I1cHdnaTVhclljcWVhdG13bkJ4TllC?=
 =?utf-8?B?TkhkcUFlcTRwcXByM3U1VWxzZHN3b1A0Y0p6SENzdGNyMVNJWmFLcnJDV3Jp?=
 =?utf-8?B?NWZ0SzQ3dGIxdSs2QjYwdkYxRG9pcER0Qk0rVlNsLzJjK3hpMkswbXRlRWtV?=
 =?utf-8?B?TUc1YmxCMjFZRGRBTDJESnRnaWVTaGh5MFZ0OEpqWG9SWVFTSEJQYW9tQ0Jk?=
 =?utf-8?B?OEhzOUhUemNCOTlMWWNuRThCdHN0N0tXR0VXd1BFcDJnQURUZkNzQk5Zajdu?=
 =?utf-8?B?U1pWRE1jWCtmdGtDdzROeFFNT1F4TytnSTZPSkNWM280K0podDFFTDhFRE1y?=
 =?utf-8?B?TnltSjBMUitrK3JiK0dPUURMTGliRE1KRGExb25ObFpsOVlUcmNPcUhEQyt3?=
 =?utf-8?B?VWNIYUN5Y0MwUDRGdHFMcGRtaWFEUFBRUGJySWxwMENpSEFaRWl1YzZrK0ZQ?=
 =?utf-8?B?L3FOaEdiaXlQUlFFM2ZiR1piYSt6ZFlSTC85Tml6NDdEZGVVSmFIUXQrQ2Zi?=
 =?utf-8?B?ZWt4YlFiNkRtVWdEeW4xcTBWejF4OGRCSDFBQno2OTI5QWFpT0tKOG93ellr?=
 =?utf-8?B?SUlyM1kwcFBUYXlJSUI1SGdrcVVkNkN4MjhacTRKa3p0dnFJeEZ3eTNTNi96?=
 =?utf-8?B?OXlhNnlOMEUzeXgwQ1pVOE0rOS9wQkJvTzdpSEVKaUpiS2c4SmtrNzdES3Er?=
 =?utf-8?B?RXNRYnhRc2huaWY2ditRN2pMNlBUT1huK2RZU3RheGhUeldpdC8zZXJYeWc1?=
 =?utf-8?Q?+hOhbd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHRSSG5hQjU5WGZhVnVrVnRZY0lPSTRueEoyaHpXR0ZUSkludlhpWUo2bHRl?=
 =?utf-8?B?cTVvN0huSTlwTXFkQXBSK2NtWUhkK3VQZjg5SDFKZ1NqWTNsMWZLbU1HUFFP?=
 =?utf-8?B?RWZ5QjFqWXpQbkRxUHp3TXA0N3ZFN2ZVUDgxdGtRdzZmWTUwWFFhaVIzYzE3?=
 =?utf-8?B?a0grMnF6VmN4MFZyRmNSZE5rWHFDcEdheEdrb2Y5Z05UQlE4U3g1dHhHY0gw?=
 =?utf-8?B?b3ZmR21yVStDYXd6OXpSelNkR2hIeFdVcVZNODN1QXBkQkNqZEhFRGlhaTFL?=
 =?utf-8?B?bGk4N1c0eVRSaFNVcHM1emZOSmhrMWdVVU8zZG1QTVBTb0FYSCtxcmVRandQ?=
 =?utf-8?B?R1R2aWR1WTFYb3JzbExFaDNzcXhRMTlmOG9NVkZpOVBWWW1lZjdscHRCYnpH?=
 =?utf-8?B?YVZkWnpKSGxVVk5vMTZyeXFpUFp1Qjl6YjZIejRnWGttQUZqZnI1dGNEWnR3?=
 =?utf-8?B?TWJ6ZERUK0tFZ3RDNERUbVRjeVY4bERyQTJtcFY5cTlDUG5rNEVGclpRRUNG?=
 =?utf-8?B?dEZ6c1pqYUJwSmNmblEzU2drdXdSNXVYV3p1TFFlT3IzbURRendlV3FHb3Zz?=
 =?utf-8?B?WDZGaDAvL0xqTmRLTjNsenlyR3ZRRFVxbnhld0VZbUJOWTFaUUhldSttR1lt?=
 =?utf-8?B?OUhqQ2g5OVVQOVJSem45ZjNWMEtmK2lZYiswRUZ3UTM0YU9UYVNDejRUaXhS?=
 =?utf-8?B?NVNuQ25kdGREelJQSGdpTGwyR1hYckhPNDdQQU9DVk85cmxaNkhXTFJ4SzFC?=
 =?utf-8?B?V2w3enAvbUUveTVpZ20zUnF5d0trSXo3R1dpZXFhR2ZUaElLeEI0WUw1NmRr?=
 =?utf-8?B?ZHhxK1I0VzdtSnRtMmd6SGNzM001UWFGM3NWQjdMeVFybDdGZXFqQjRBdS83?=
 =?utf-8?B?RE02ODREV0M2R0JIaCtud1FxMTRydnp5UjRZM2VSY3drbDh2dVdNOWxNblpw?=
 =?utf-8?B?bnluUTZVVlFhdk5wNUYzWDJKeHNRSGp4MkxxQm5BUmdRRVFjTER6c0VEMXFk?=
 =?utf-8?B?dW10b1VlWlV4bGR0dWRSWlh4dThoZ0FHZGpwYlVLc1M2Y0MxNEhGMG1xOWR5?=
 =?utf-8?B?OHg4ZDhKeXl3Y25SY1cxOGxHdXkzNlgwbTdib3RxaE8wUWZRTkh6dEJYR1NN?=
 =?utf-8?B?TFl1Y3Q3RlQ4Rk9OQjRTUWRMeXQ1dGVRZ1NYdC9QdDUvbU5lTjNmWVlaN3Nl?=
 =?utf-8?B?NHdtVGNSbjJCL0dhZjNyWUdKTHIyRmxBMGJ3ZGg0QmtteS9ldjR4TlZCNnR5?=
 =?utf-8?B?Mkl2aUZ4TTBiajNJZ1k5dThWR0tXaWFCbk5vcnR6aWJmTXMxT0tNSTBNazNG?=
 =?utf-8?B?dW5qWUY0eXBCa1BkakNoTnBkSzFwZGRvRmJhM3JhMUQrMGZZNkx3RjNuNmQ0?=
 =?utf-8?B?ODNVMHU4YVZQekt5UzB6bFBPUHo5ajE3ZlYvUVYvN2V1ekE1R1JsbHJIa2d2?=
 =?utf-8?B?bTNqZmw2dG1DN0xrSVo0cWxRZHMvVHZLckVRSUVFd2FrYUJ0QlpnZTVzTDFz?=
 =?utf-8?B?MjEzN1l0Z0IraWxWcDY3bFRKZEJxUzhjMmxXUGQ0SXpOeEE3ckIzWUgwQ1pK?=
 =?utf-8?B?NmdJN0d0RzlqK0hrYzhKdVIvZzR0MEFjNFhiN1F4Y3l4NytQRElBbEN6RWpq?=
 =?utf-8?B?bnExMTZlWnNUSXhmM0VMWHVRelNSaytmcUlCQ2JudDZNR1RXR2g2WWhNNWt5?=
 =?utf-8?B?SWFwUFo3WndGU25uNWRXaGZSbXNTNHFGWFdtd1dvd29jM3RqSk1HQUxGSTd6?=
 =?utf-8?B?Wk0zalRvQWlNMTF0L1AwQ3AzSVZpS1lzdTQ1UVVLbG9VL2orYWE4ZGcrK2Vu?=
 =?utf-8?B?M3pwTHpmTldSaFZGNW9qSzMxNEZydVVhMGh6MHFhRmQvTllvWjl4cHE0bXF1?=
 =?utf-8?B?NmNlN1pQSDI2Ri9tQkNLNGczSFNodldWeldrK3RkU2RrZnJlME5IWVJkNnNq?=
 =?utf-8?B?WkJDRWZKdGNCNm1VeDd5SWt6Rm4wOW1yblBiTXNPUmpkaE13cTFiT1NHcVhy?=
 =?utf-8?B?L2dMODBBQzZlTXlxLzczSmY1WWMvcGFQQ3c3ZUViRFRtcDhJTmR6aXdsTHJM?=
 =?utf-8?B?QkYzNEdaS0lEcFE3VDlWU3hhS0VZZnFicFM2NFkvaU8yb0czYVJqbFBMeWN3?=
 =?utf-8?B?cDBxbG85V1MrbTFkWWxpRXh6VlFWblBSZ1BZcEJrQXUycnVWNVpDY0U4bkF4?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <895F550A41BA36439B8013814E0443FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3IryO56sGqaXgGaOiLiVPNLyhWZ8Gv8PiPg86NCU4m0i/JFOBttRQBaaUSk+RV9GAVnVP35MYINHdUOLBkrWwKoOyV9DIMoWYyrbgpzs6IC2XWM09dJhXM8utHvRmkT5p1yn0YDwr9AS2Kdr34BItRaiyzxCiZ9wkCe8p3dZ7mi/eJ+GFz/TjHMu4lynmTusjC/OnrKGiHZaaBiV0B/JlibOo6jNEUmLQj1rLhRB1Sxm59+Au6i2XvwUI/puTUO1kuq3zrHKvkktAIRrd98aKDOQtBXYSyqjBx8TlFrUcWRWWmAyOCKT7szhw3o6tPNbM9fxmPws+mWRPWo94frVvdJdkAhCJNrVtZWL9FBYGZ/AKXqExqnlwV/m6ry0LKq7nd2j/ejnJ6gE4/z+mYLHaS1Z6JllEGTK2wVh2VqhJHc6OtIIbxgawmu1wnhSrdUF2B3krcVAYNWwUj+PM+0rVyPC7Butsr2tO+ILK038aTMxnIWP+6Oe7VDWTzOUN6woH22292EaI49VKF7b8QRQhQFd0dUhff0A2uaLNoa0ZIxxVX6whVUSm4p6CVP9nXW60vqWR9e4R2sOL/o4bNUdI8wVRWo0TytX5bViEhJu68xXB3TLtoHKmdt8c55iTRQ2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5b709a-a6d7-4d14-7b6c-08de17b05909
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 12:32:10.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQsgn77qO5KWTx0tMi4/dyjl3ErAUiofK3+j1896zHdyTJ6vlnN2898Ae3H7b3D6vjVX8l8P2MFFWqgd/1y0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6766

T24gMjkvMTAvMjAyNSAxNzoxNiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgT2N0IDI5
LCAyMDI1IGF0IDEwOjA2OjMxQU0gLTA2MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4NCj4+IEFm
dGVyIHRoaXMsIHlvdSBjYW4gc2V0IGRtYV9hbGlnbm1lbnQgdG8gMS4NCj4gDQo+IE9oIHdhaXQs
IG5vLCBpdCBzdGlsbCBjYW4ndCBiZSBzbWFsbGVyIHRoYW4gNTExIGJlY2F1c2UgZXZlcnl0aGlu
Zw0KPiBvcGVyYXRlcyBvbiAiU0VDVE9SX1NJWkUiLiBXaGljaCBhbHNvIHNlZW1zIGxpa2UgaXQg
c2hvdWxkbid0IGJlDQo+IG5lY2Vzc2FyeS4uLg0KPiANCj4gU29ycnksIGxldCdzIGp1c3QgZG8g
eW91ciBwYXRjaC4gVGhhdCBzZWVtcyB0aGUgc2FmZXN0IHRoaW5nIGZvciBub3csDQo+IGFuZCBJ
IGNhbiBtZXNzIHdpdGggZG1hIGFsaWdubWVudCBsaW1pdHMgZm9yIGEgZm9sbG93IHVwIChJJ20g
YWxyZWFkeQ0KPiBkb2luZyBzb21ldGhpbmcgc2ltaWxpYXIgZm9yIGdlbmVyaWMgcHJvdGVjdGlv
biBpbmZvcm1hdGlvbikuDQo+IA0KDQpBd2Vzb21lLCBpdCB3b3VsZCBiZSBncmVhdCB0byBzdXBw
b3J0IHNtYWxsZXIgZ3JhbnVsYXJpdHkgaW4gbnVsbGJsay4NCkknZCBoYXBwaWx5IHRlc3QgaXQg
aW4gbXkgc2V0dXAuDQoNCg0KPiBSZXZpZXdlZC1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPg0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBjaGVlcnMhDQo=
