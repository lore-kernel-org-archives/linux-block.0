Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21462E9ED4
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046802; cv=fail; b=pmIKDUVD8gRcGFdn+QUGspStduAfzhyLWtHGdCA4xQK2Dl4o9vfFB93myvCnVyRJNHJW/h4SbKUGQJ508VLoF6kW+ipKci8Md7r/NUOEvzOSVCdMc/Bil3tmBqbu3CSEtPNj9IXdVoEAl2ATNDS2pC+9+oc0eaFh5QkwL844LtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046802; c=relaxed/simple;
	bh=AGODHouczH8940x43FC8FPXCoBglPmXlRV6SS6rfu+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ui40w1cWpr42nMbJY4zcIP5uMWDqoX9iY4yYFj/xDmG0CpAcD+/2eNHGAjICjkhkFdlAHyxjUf+BxoEy7a5DR29JcaklIzfVPyyLV0vT6lAlB9p6srGQ6Xbk32VSsMbTMJjEFaG4IWU43p5qybISTxVGbAoj12av/3/QQMORDgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvIFmJNR; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvIFmJNR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXyKPS3RdJBLvETRk9N6wdgO0kklWS1XzPShattumgwmkkM1YQaptxlvyQYH5M+7X7AS3X3nRX7zrqrwHi71dMgKUGXl9zD88ghLzIpz5ZBEe3e23JnLd+GQSCYs4iOv9+AAfv8uXlUZ0OQ+sakyjCfBI7Pn66sov1UIOa1SKhYPWmaxqd3HKOLCAqvVk0i7nukoCoS0RdghJBuvsi9dM0q7qF/TrtEz2iwzUvxlXWpk0nQbPB+arbkEvKxK0q4kFjCoDXlOaR6GLK+us5F3pOLc/LXZ+DdTNnpagzK+1nFDU1fdLM23axDm9wqg4TDqZfMdcckQjRWDGuA9naMAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGODHouczH8940x43FC8FPXCoBglPmXlRV6SS6rfu+c=;
 b=ivC/v0CsDUy/CBnnrcq0W/sdpbPHcnCDZzUch+MtCyg21/5Y0ixip7JRox62eFcPZ8plFunvXItyh5cCng/pfKummuo1BNGaYCkLwPcLqwl1gveMF3K0/EHaNKrMPeDch2JZwgzP3ZYC1n2NJ0ca7xKkkgBE2/vxmXxDAWfVB54uzW/vphuM3gUfI0moiCBg4W9veQ/Dej74hYju7eEYOA3GtTULliR1iN/blJ0afk0robSk50OBkk9TNpclzQMPvT/ony0i+57+QpfH2pJLEOTI/tsI+nZL6cJr7qAT6FQanOlAhTxJW5xsA2m3LRU40fZc6TEgT21A+6GNmlOP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGODHouczH8940x43FC8FPXCoBglPmXlRV6SS6rfu+c=;
 b=SvIFmJNRo1ade/reIU2pHD2xtVeD3LeLb3iieqbs04+hZTHgclAgQPRJFs9OOWyOpirPsoCeAPDvgTH6T52qI8C9E74gKFE2iOhts9suiXT1aajQCG9MyJ6OBKLCDSnxlYmRHQZ7VqhOnnsDjtUA1lE5y7+2R9IlMgeczuYA3tRBWmBoV6Y1S1QP+Xu8BJ2e6Sf8Kt8sReip9xVpBpLLKgJ0M8je1IH3vLwHy3e9wKIZwmIF/LPaIHWxYLMRDklswpmmHNQpQgucvo+iWHm+WQhkKSH9YV9Ubb4RkFqeTX6dkkfMzMp+9S3dNnVLlTNEEEPQUC0dkOFA336f1ygYsg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 17:53:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 17:53:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, Daniel Gomez <da.gomez@kernel.org>,
	Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>, Nitesh Shetty
	<nj.shetty@samsung.com>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: new DMA API conversion for nvme-pci v3
Thread-Topic: new DMA API conversion for nvme-pci v3
Thread-Index: AQHb5cVIubpj0SCqHUO+y4Ky5LS4GbQUE7IAgAKNTACAAHrOAIAAMV+A
Date: Fri, 27 Jun 2025 17:53:15 +0000
Message-ID: <da5265d2-b2cd-408b-8367-cfe8dfa58836@nvidia.com>
References: <20250625113531.522027-1-hch@lst.de>
 <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
 <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
 <42d8df98-65c7-4a4f-b931-ea32fe357fbf@kernel.dk>
In-Reply-To: <42d8df98-65c7-4a4f-b931-ea32fe357fbf@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8207:EE_
x-ms-office365-filtering-correlation-id: fc423705-bbb1-4157-0889-08ddb5a37e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGpJWG16c0pwNk0yTDNiRnVLa0k3ajJqS2ZhWHF2SFlpSkxTRUljUVh0TkU4?=
 =?utf-8?B?Mm5aZUJDaHlZL0Q2NTk3ZExkWVRjOStXRVlYdnA2QkpaSU8ya3lrNk0yMEww?=
 =?utf-8?B?TlQ4QWQ0SkhmeEtWbi9PY0lFWWJ2NmZXbGxaZTc4cXJnRmc3eHY0blFhYmxL?=
 =?utf-8?B?TEdvOWdoQ0w5ZUlmZm0xbThPSUdvQmNuUGRLVXlYd3VqN0E1R0RUaStJd1h3?=
 =?utf-8?B?REhqMUlYMG1IOEc2RGZWNVRSbjEvQi82TXpsZ0lqVnpnL0RDZGsrYmdFYzI5?=
 =?utf-8?B?RkVTNmRVei94YjIrU01yd1hxWE44dTMrcTIwWmpRdlFyM2ozc1d3WUdNU2dz?=
 =?utf-8?B?OWY4bDA1U2VIcXpLbWhiYnFaT01QNW52cDAwSFZkL2luU25mc3JKdlRhNm9h?=
 =?utf-8?B?TlRDSmVJTnVZa2pGb0RXcXZPRGF3STBZS04vTjNpS1IzanArYVNMYUJWSGky?=
 =?utf-8?B?Y01abUEzeUd0aGVNdW0vSFY0OHZKcXplaExGNk0rMHNDYmRaajJHelJ5UVYv?=
 =?utf-8?B?TENFS1FtdlBkU3FRSHJCc1ZiMmJHdjlUZ0FocGduU29IN2V6aDlvT0F2U1lH?=
 =?utf-8?B?NGZsVy9SNEN4NEVaVldMbVVZdkNJSEZIa3pLV2RxeG40VEhuSmRUdjlzMm5K?=
 =?utf-8?B?YWhSdHRXQ0FuaC84ZUkvQnNtSnBaTHVGVkdrZ2ZSUE9Pc0tHY0tnUmQ4ck1V?=
 =?utf-8?B?VmZJRHpaNS9PaktqQ0dvUmdwQ1hNRW1pYkJnbXoybW0ycHBqZ2piT2xpS0Mz?=
 =?utf-8?B?Q3I0a0M5REt6T2wzNVNoZlZRZTJKeS9kVllKcnVUckdnalcxWDlCODIyUXFl?=
 =?utf-8?B?eTVUQkRTZkRDdnFYSHJBcTlQVzhNRzMxUjRPejBEeVd4Q1J4MFZiRlRvbW4x?=
 =?utf-8?B?ZDRZWnNCYVc3QTJJSmJuRnE0OVJ6Q09JVUg2ayt0STVWc3pJdHJsSVMvcXJF?=
 =?utf-8?B?RTN3OVo1YzdESEFrc0VmU3ZicDVOZFQ0R0ErZmx1RnJWdHNZZWx3S1VzQy93?=
 =?utf-8?B?eFByZm8zbk5aeHVPbitwWDlFSmJPNVcrNmdXZ1VpL21wQzlsRmhtUzZtNWFS?=
 =?utf-8?B?T2x0UWkrTUJ5dXhKWGFqeFBmcGhTbVM0aGR5OENUWCtoSmpXWkZzSUlCSGw4?=
 =?utf-8?B?RzcvbDFyZmN5SFVJMkJXYUpOTkpzbXppeXpERjVROGF4SEFaYkI5M0d5YXJU?=
 =?utf-8?B?YWpkMm5HdDc0VkxpSVl6U1RGVDlsVE1CUHZ3UFNxa1hjK3l4V1BZclpjY1J2?=
 =?utf-8?B?SXl0TW42UE5SblJXb2EyYlVqQUxsNEhIVXNpLzZLZHA4NDVvczhGb0pGNG05?=
 =?utf-8?B?anpOeTMwTE9KUkhtd0YweFRrRmZxektDWDZocUJEbkVDeUxqcC9uQlVDRi82?=
 =?utf-8?B?T3dyS21aSWhxL2Z1bG43UnZxanNoSTFPU1FEVk1UUjdDRlZCZndkTHo5eHhD?=
 =?utf-8?B?NTB3b09kNnFJcUVaTXFMWUNjMGhxSkxOZDh3QWZTOFdQTFVWTXdkN1h1dHlX?=
 =?utf-8?B?U1VUMmJJYUdpM2poK21nMG5FZGxDTWdtK3VFd1JGbWRRUnl2TGdqcTNBOWd4?=
 =?utf-8?B?SXY5Q2g1dHh2QnRoWXBwT2VJR2hESktXN0REM3REUjNuWnR1VmRYZ2xtK2ww?=
 =?utf-8?B?QmV4TXZEWm9ZQ253UHlzelVLNWlWOFcvUnVHOUhUZUt1cFE3alFCWHJYZDJs?=
 =?utf-8?B?YklnU3d6WU8rV2NFa1FaTVRPVzkwQ04rUmlYRytwcERtVEFjRm9sckVwMm03?=
 =?utf-8?B?WGdSc1ZyWFJvSU5HTkUxZHpsSW1VYTJOcHh4N1VNOGxndmE0YUMwU2lOaW44?=
 =?utf-8?B?QkFvbEVYVGltQ3ZOOW9YZjJZZkhUMDdJZWliY1N3ZU15K2hCaXRsTVpXQmtX?=
 =?utf-8?B?eWp0a3JzanFsaFZsMkpteVY3U0ZSdkNzTVFHaW0vaklyV0RQazdnS0U2UFRC?=
 =?utf-8?B?NEFFaEJ3MFIwUE5sTWwzM2o4N1pPbWJkZHcrcTlobnZiMStDSStybFRZbE5k?=
 =?utf-8?B?SE5CYTZCYkJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzhoL1MwOWlOZTJ6dHBva3I4ZTQ5TUlzV1IyZTd4anBXWlIxNUoyUDYvVVgx?=
 =?utf-8?B?WkxqbXJucFU2M2V0ME9sRk05ZWJvUTE5ZDJzaFozNmF2OUljdW5WRjdMWWJD?=
 =?utf-8?B?UGE4dSt0R2NLMVEzL0J4dHlQdk9KN0NZOXdzNDB1OEVISGlGRG52QXR1K01S?=
 =?utf-8?B?V2h6UHpSYmhOZ2tZWDZSN0lCZmRHSml3aURkaW85Y1hYbkUxck9kYXd1L3pm?=
 =?utf-8?B?OUZJazRTU255S1pmQzFJcHZpQkovSGlEYzFXcGF1YnNlRnpKQk9adk9NaFh4?=
 =?utf-8?B?K2VabU1WeHJvK1ZpTmZsNXREczZpbGxHZ1VpbmR4SnBweVVUTVJ0eUxxTDN1?=
 =?utf-8?B?aTVwMnIwb1hsWVUvekZSRGphL21Na3B0U0M4NEpFcGFKcGtZT284S0w2cWxI?=
 =?utf-8?B?cG9qbnk1dG9uQ2VPaU8wYy9mQmRIbTR4V0ExMTRTOEM4dXpCMFZIMzhvcVR3?=
 =?utf-8?B?ajQvQStHUG01QjVXM0ZWQlA3RHdIY0pzd2JpU25pWDJ2UCtrdjZ3MEEyMWdR?=
 =?utf-8?B?aEVoZXdWVWtncktpNkF4bUoydkhETHB6QWJHR3M3ZDlzc292c1h2NTJveTRL?=
 =?utf-8?B?YVJWVGY4YjRXdlJVYU1JQ0hVQy94K05Ea3ZQYUFaVFlRWng2MW9Dd1dVUlNi?=
 =?utf-8?B?M3NDdVN2aFArMGVBaFJzK291UlRHRnYwZFgraDNhekJVdG9PRkZRQW90RUlV?=
 =?utf-8?B?d3Z3VU9LbGoxanMrQzJJQStzcTdMM3hsQ0xOeEpxdytEVjREd2xrMDJOTFpl?=
 =?utf-8?B?cHJ0THVVMWxXcWZOY1R5bS8xd1RNdlUzRU1YVjBwQVhPSEhZOEg4RmNGL29B?=
 =?utf-8?B?bkh6TTdudW42YXd3S1hJcExyb2RUcE5kSHBuRWdScDExNlVZejdSTVJIdVNW?=
 =?utf-8?B?SUM2SFVFSCtjcU1jVFI1L29nVzBDK09GTnN4UVl1VXJHWFJVVnNVbXJqNHA3?=
 =?utf-8?B?bEhZbnh6THZQVmxGbDlTeVhUN2U4S2ltMFZSSWN3eHk0S2I3TkQvN29Yb1l3?=
 =?utf-8?B?WWRhcnN6WGFDdGdBSkdUTUtsTnd1UXJVNjBtbW9hZHNIazdaS3BmeVZJQ0tx?=
 =?utf-8?B?anFyQW4wWW9BVitOVmVZMXlybXl3czBKa1RFZE1aTzNqOStVS1BqMmx0aXly?=
 =?utf-8?B?a1dkRnBrdzNrcTNKa2JHNWZMZEt5UnczUEhoWjIxRTAxZmUwcThRTGVSZU4x?=
 =?utf-8?B?cnplaFFiVUFiZ0lNOTRURk5rWTZ0aVMrSnlkc1pFdHZZeDBMWVE5YTluQ0w3?=
 =?utf-8?B?NkRpYjg4UjFsRlMxWWpXTmREVEdENUFrWVJIZlhFTjZvTGc3Wmp2S2VYaVJW?=
 =?utf-8?B?WFRFVGNNNEhwNkV0OWcvOTB2d3h2S0J4QWJ5a2orMWtVL054YnUyR0JOeEdY?=
 =?utf-8?B?bExxcHFId2VMaGdwa2UvcWxGMlVQeUVuZGsyUG1mUXZPVVdENVNWeWxvNmhj?=
 =?utf-8?B?OEdwcFQ1QjFQdXFjUXlVRVJ5Z2xvTWZOMi9hRmV1dnV1Zmw3V0lBTE5UY0Qz?=
 =?utf-8?B?V050dnZkcjF5WVZydzRoMmN6U0VQTE92b3NNSWF2cHpyMHRPTWdvR1Fvdm1v?=
 =?utf-8?B?UHhpWE1EOFpSUkcyekpHOWo0enRqYWNnZE12UUJYNkZ1cy9zYlNkK1JLTVBO?=
 =?utf-8?B?U2hlK1FQdlBqcGpxU0RCSzRXZmc0MktKT0pzTG5YTHYwU0FnT2R6UzFKdWhT?=
 =?utf-8?B?SUlTTld1emhSS0NxZXZMbTU2TXZwM0djVE9USjA3UERMZUROZVB3R1UwUW9i?=
 =?utf-8?B?T2x1R1pFY0M4ZmVnOEx2dUdEZmkwYmtKRzI3bE56QThvZ0JnamZULzJnQmNO?=
 =?utf-8?B?Q0NUeTlEMjZuaUsrVzVhVnNTRXZqUkJKdllndnJoUU54QStrVHpNeVVMbkdm?=
 =?utf-8?B?MWQyeHZpOUZTZ0cxR3hxdk1UeUk0Wi9EbDRSVkZxTkhPcDJRYkYyTjlNN1JR?=
 =?utf-8?B?bzNmOC9DRGVyOW9seEJPS1dlMTVGSTNMeFFZRmJPVmlNNVFZT0UxSS9IbzNl?=
 =?utf-8?B?N1QzN0lkck1RcnlJMmhFak1xZDN0dFBrWGo1Q2Y2ejFqZWFwdmQ2RGNGbk5W?=
 =?utf-8?B?d0hJcWRlTURBdXh1bFNPZGR0Mm04Ymd1bjk2Rzl2cGppL0hZK1JmNGlRWjV6?=
 =?utf-8?B?YWNsNkxtK3p6ZVgxM0hNYjBmWWhnSVA1VHk5VW9mbHdjRUtDOVhXVXZuTnFR?=
 =?utf-8?Q?p/Q4XM+DuA7+KlqghRLRrle69yVAjOzKxy6UapHYSbtZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDA39F99C5BF3543829B7034F4040D01@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc423705-bbb1-4157-0889-08ddb5a37e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 17:53:15.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NDwdnE9sNguXqRO06OIz6h5pfvHRgV2nahabsXQnE9SwWYaGv58gxR475DROor2bSlddq4R6XxUp98lKE4oig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

Pj4+IEFwcGxpZWQsIHRoYW5rcyENCj4+Pg0KPj4+IFsxLzhdIGJsb2NrOiBkb24ndCBtZXJnZSBk
aWZmZXJlbnQga2luZHMgb2YgUDJQIHRyYW5zZmVycyBpbiBhIHNpbmdsZSBiaW8NCj4+PiAgICAg
ICAgY29tbWl0OiAyMjZkNjA5OTQwMmQ4ZGUxNjZhZjYwYjI3OTRmYzE5ODM2MGQ5OGZiDQo+Pj4g
WzIvOF0gYmxvY2s6IGFkZCBzY2F0dGVybGlzdC1sZXNzIERNQSBtYXBwaW5nIGhlbHBlcnMNCj4+
PiAgICAgICAgY29tbWl0OiBkNmMxMmM2OWVmNGZhMzNlMzJjZWRhNGE1Mzk5MWFjZTAxNDAxY2Q5
DQo+Pj4gWzMvOF0gbnZtZS1wY2k6IHJlZmFjdG9yIG52bWVfcGNpX3VzZV9zZ2xzDQo+Pj4gICAg
ICAgIGNvbW1pdDogMDdjODFjYmY0MzhiNzY5ZTBkNjczYmUzYjVjMDIxYTQyNGE0ZGM2Zg0KPj4+
IFs0LzhdIG52bWUtcGNpOiBtZXJnZSB0aGUgc2ltcGxlIFBSUCBhbmQgU0dMIHNldHVwIGludG8g
YSBjb21tb24gaGVscGVyDQo+Pj4gICAgICAgIGNvbW1pdDogMDZjYWUwZTNmNjFjNGMxZWYxODcy
NmI4MTdiYmI4OGMyOWY4MWU1Nw0KPj4+IFs1LzhdIG52bWUtcGNpOiByZW1vdmUgc3VwZXJmbHVv
dXMgYXJndW1lbnRzDQo+Pj4gICAgICAgIGNvbW1pdDogMDdkZTk2MGFjNzU3NzY2MmM2OGYxZDIx
YmQ0OTA3YjhkZmM3OTBjNA0KPj4+IFs2LzhdIG52bWUtcGNpOiBjb252ZXJ0IHRoZSBkYXRhIG1h
cHBpbmcgdG8gYmxrX3JxX2RtYV9tYXANCj4+PiAgICAgICAgY29tbWl0OiAyMzUxMThkZTM4MmQ2
NTQ1ZDM4MjJlYWQwNTcxYTA1ZTAxN2VkOGYxDQo+Pj4gWzcvOF0gbnZtZS1wY2k6IHJlcGxhY2Ug
TlZNRV9NQVhfS0JfU1ogd2l0aCBOVk1FX01BWF9CWVRFDQo+Pj4gICAgICAgIGNvbW1pdDogZDFk
ZjZiZDRjNTUxMTEwZTBkMWIwNmVlODVjN2JjYTA1NzQzOWQyOA0KPj4+IFs4LzhdIG52bWUtcGNp
OiByZXdvcmsgdGhlIGJ1aWxkIHRpbWUgYXNzZXJ0IGZvciBOVk1FX01BWF9OUl9ERVNDUklQVE9S
Uw0KPj4+ICAgICAgICBjb21taXQ6IDBjMzQxOThhMTZhODg4NzhhYmE0NTViZWJlMTU3MDM3Yzlh
YjUyYzUNCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+IERvIHlvdSBzdGlsbCBhY2NlcHQgbmV3
IHRhZ3MvdHJhaWxlcnM/DQo+IEV2ZW4gaWYgdGhleSBkb24ndCBhbHdheXMgZW5kIHVwIGluIHRo
ZSBnaXQgdHJlZSwgcGxlYXNlIGRvIHByb3ZpZGUNCj4gdGhlbS4gVGhpcyB0aHJlYWQgaXMgbGlu
a2VkIGZyb20gdGhlcmUgYW55d2F5LCBzbyBpdCBzdGlsbCBwcm92aWRlcw0KPiB2YWx1ZS4NCj4N
Cg0KSXQgdG9vayBzb21ldGltZSBmb3IgbWUgdG8gZmluaXNoIHRoZSBwZXJmIHRlc3RpbmcgaG9w
ZSB0aGV5IGFyZSBoZWxwZnVsLg0KDQpJJ2xsIHN1Ym1pdCB0aGUgYmxrdGVzdCBmb3IgU0dMIGFu
ZCBQUlAgdGVzdGluZyB3aXRoIGRpZmZlcmVudCBibGtzaXplcw0Kc28gd2UgY2FuIG1ha2UgdGhh
dCBwYXJ0IG9mIHRoZSBkcml2ZXIgdGVzdC1wcm9vZiBmb3IgZXZlcnkgcmVsZWFzZS4NCg0KLWNr
DQoNCg0K
