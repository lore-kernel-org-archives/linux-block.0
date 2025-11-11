Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3119824BD;
	Tue, 11 Nov 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885157; cv=fail; b=dksUKhnYmiNhDUu90mcsCp5HXHLAYEJM8FeN8qQYDMCkcOI+Lw22uQ0rv7zSaleNHSuSB9bQOyI5rfhr9RNKzdeoZULMVItpJYx4VdnHKN1ZT3vp1IieeqnPixvy9MGyO2TCnWalnbreYLK6bWQKN5fPNABIEz2jE4TJIPwpE10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885157; c=relaxed/simple;
	bh=WMT/bkzTseoOqwiqjfSsyD57w+QPHTRCxMOhRy+V4lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BjI2z+B1LYb0RopsySMljbxCV5Yf4J78XpmE+TqiVZrjf27GxvUhpvRNaRyC0Xv0Pqr8kF3QQuzPasYxHW7XTG5oyprQ2yO6rJP7S8QTum4B0q4M1exDkfkxcxZu3XfD3Dm3KMLx3V51Nsd6MoEURrKYMuHO3Cke0w3Y6t5m3Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gm9UUlft; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gm9UUlft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5kwUG09f06fsPX76zJS2b5R2Mr7k9aA1aQVhhJAbAEl5GW8VL3Na+PXh1dVy/jukObQy+cZ2p/0FlPqKrsny63uaJ+Ul2T5rFeyWqxJucww0nu6y2R66nOJSR1IA2uRHZ1OFepo1DBCNO026cK8NxUCP1isT2TxLc9Fu7wo3VPfhkyLjJQT+1WCZS7nlYt4wvxvE+ct+mqJl2Y74l0vL3DIZpiI+tJzzjHL7/3qX1S+ZIkrqskhjmYLy/oLNfUGgHc4xVkYioYkcr+82sVMh7ZcFLFkpL5z+Ezqhyl8kmGbuCCxPehwj6qztFF/vulwxyFmVVY7h5aqZFYf9T5PMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMT/bkzTseoOqwiqjfSsyD57w+QPHTRCxMOhRy+V4lc=;
 b=fJg8Z9RFDT42Dz8Fquu5Kwoth7I7XQnI74DmKuK3X6oq2pleLrNENQ7/Y6eKr0Tohszsy/ZopOOIaO7VJ4+KU1lmWLPFGzRHy31+52vdtHGFifk6tUlzicy+y0oUDu21paBDe3XHxuiXXnSLSMcIwSaB74HlOTBLHoV2V0c9v9pivhv35hC1etozg+DJWMXVzuedBbgJJeNfzoy2W9HIRR8oU8joJ6RnZGYLq1dytJajQfs7ppUDqpR2kqLGKaA0qWu9kQe7XFHz2eTY89cClIwWwGJXPQslztzAqEvGZbQ8kYfZHyCS1NEQq2s2JiQvH99Rm5RavFaT9PCOSi8+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMT/bkzTseoOqwiqjfSsyD57w+QPHTRCxMOhRy+V4lc=;
 b=gm9UUlftizVAwfwABexY0dA2AnbLOee9WcDqIiaoIqAURMTtk89jHpCvzRNVeqmW0lbw6Mp8+PDwKO3z8ky3JwwtnNM+7DytPs5IHe9FWZaALKfJYXiqEeIYUmk3HQ641PO3Nfj+GEn4LRsgs3oL92sulpu55b7GLZ5gZXckC7ttpk11gNNoY/bDd4Fpe6DYdr3OGOE+2m5ouXYCNKHDQrhr5axe6gPm8Q0y3PL1D5MZF0No3jIhQm3x6/guYiawNSd+M5au93Wrs6b9QQmFDDml96eufWcLfxhcE1b+wcDk/YOUE6jIry5miaaTib0E//Em0jkbWI9f23f/QIDgPQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 18:19:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 18:19:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Caleb Sander
 Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/2] zloop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Thread-Topic: [PATCH 2/2] zloop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Thread-Index: AQHcUQOmREdX9Oxw5EiSTJx46E6UxrTtM02AgACaBwA=
Date: Tue, 11 Nov 2025 18:19:12 +0000
Message-ID: <82841969-7892-4222-8f2f-a55bff4ce56f@nvidia.com>
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-3-csander@purestorage.com>
 <20251111090755.GA12545@lst.de>
In-Reply-To: <20251111090755.GA12545@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS2PR12MB9750:EE_
x-ms-office365-filtering-correlation-id: 0612c424-86c0-4524-a772-08de214ed0ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlVNMXRiMzdWQWI2WkpFS0hyanJLZ1JEVnFFcUVUZVFiZUtSdGUyMndSaW1X?=
 =?utf-8?B?TXlOMmFBZE9MUDZtZ0pRWGhGZmdNLysyVW9YQSszYlkzUnlzQ09TbDVmN29F?=
 =?utf-8?B?cUdXNW5kMXJTQXB3WnhYOWdCK2tWK3dLcVNwSEZCLytjRURYN0NoSUxxSUc0?=
 =?utf-8?B?bDc3WEpEVFpQZ0tyOTd5Y3pKeHNORWdHWFprVlZtdVJZUy9nM2ZNUHFqSTJU?=
 =?utf-8?B?MFM2K2hYUURDTTBDVnJyQkpHMWpIa25nb1l6SHg1R1NuVmxoYVZSTWd6UFRq?=
 =?utf-8?B?WWcvRS84cVF0TlB3bUduR1hZaDgrNFVMVGxUMEhLZjlaTk9GYkJGa1N4Vkdq?=
 =?utf-8?B?Qkl6WTMzVlJGeEl3bVFQbVQvc3R1aGlIRmVpOWcxR2RBdTU1MklubXkwdGNp?=
 =?utf-8?B?dDFXWllWbjlkTU5QbHRRV1dCeDZMM1AzNjdpUWo4UHZYUTZuODlGREg0ZE11?=
 =?utf-8?B?b3pDWjBieU1kQ2RuZ2RpcVZ2UUg1bFhnWHljSXU3MGNxc0dSUVZzYVM2LzhC?=
 =?utf-8?B?R0ZTWFpMcjY3OFlhcHZzMHljVGpQOUhicFZTY2VZOUZkVGZrR1Ric0ZwbHFG?=
 =?utf-8?B?U0VLR2hUWldheU82UXdOYlFZc2I4NmYzL0NtcStlekRNK1RML3BkVEprcGVQ?=
 =?utf-8?B?S0tBaWJmSTdqUHVsWEgvbFJRRE5OWHBqZDFwQW9laUdWNmI1WUc5L2d6eG0r?=
 =?utf-8?B?THNYTU1ITmtSN3IyaHZOR3BTWDZQNkpJcFUyL2ZlWWJpSXdIN3N3VnpLeTBz?=
 =?utf-8?B?L244aHppRnJNTEQydVQrRDJRWHFzbWt0b3BtQitmZDZmZjAwSGtwaDc4TWM2?=
 =?utf-8?B?THF2ZDZwUnM2OTlUaXp3OVBWaGE4d1Y1SWgxZnN5dFlaQ0I5cmlEVFd2YUtm?=
 =?utf-8?B?QWx3MWpySzNBV3VSQ1M0UW9vb1F4c0gvRkkxeDZXZnlvdnlIZEorbzVCVkNs?=
 =?utf-8?B?aUl5K0hRa0FDR2JFQ3Zzd2dvRUdIc0p1bnBSS1ZOemNBVUVSUE9FVmxvckN3?=
 =?utf-8?B?cE0xRkVJTDlLeHZURWhFRUdJUGRHWndJZUtyd1RjbVdYMzN4SEY4VEhpd01X?=
 =?utf-8?B?Z1V3ZGZMRWlnTWdJeTE0a0tiUjVONnh0ZklIaHJFMXVBc1RYRmxscHYwRGs2?=
 =?utf-8?B?cVNnSXl3N1FWb2pwTTdVUUE4TFdYL2NVbHNGWnVMN09lUmRKeUdoRXMwYlJk?=
 =?utf-8?B?NXNLV3BHbU5TVWp6RXBSSlByUmNwYnVNUU1TMTlKVnVSTmdEZ29remUxaHRP?=
 =?utf-8?B?TG9ZeitTTU43VGJiSEt2ei9kQXIyR1dxaXdUbFpCSjVQTm45WFk1RDdDd01y?=
 =?utf-8?B?SHJTK096K1FXOGlHZ2JxM1Q1Nm1Cd3IvRzZrdjJDRWVkdmZMOStzbzU5c08w?=
 =?utf-8?B?UGRCdk0wTlFFT3pFNVBNS0tYRCs1djZDcFh0V0V3a2NyOFJSUFo5d2ZBVTQy?=
 =?utf-8?B?a1I0dzFqSTAwNEt6VkxEODhycEFhdFdQYUllVVdNNnNzNE12UnpjOWVIU3JJ?=
 =?utf-8?B?SzNmRmpETmhRSTRpdXloZktSVFEwaTlXT1FvQ1p2ODBaY1VhQzkweUN1ZHRy?=
 =?utf-8?B?VEl3NzNPd1h5N2g1VTZzY0ZSYWh3ZnRJSWFwdkF3N0lCRVVLUTllYWVZU09m?=
 =?utf-8?B?ZjBnaXhmQ2plTko4V05qZkNTTUQwZ3RuZFJ2MkFyWUNCMFBjYlJuUUJhQ0pm?=
 =?utf-8?B?aWlVYm5NWndhSlpUeDlVbDQ3eXN2OUxiV2hKY0FJMURXNUlGTC9pZjRtSWtt?=
 =?utf-8?B?WWUzTGhDem9sUU9oUDRqK3JxTlpKWFA0TWNudmxFbDdDZUE0UnJBL1pURSs3?=
 =?utf-8?B?Q3hWZWRUeTJ3YkRzdk1mOUdyTFFzbkZXcFBIUWhrT1N0UXkvdHl6MnVGUXNC?=
 =?utf-8?B?dzFlY2hnUVhpUWN6Ni9LWE95cG1uYlRUS0dabWRuYVhWQ1lzcWxsRGRGbHk3?=
 =?utf-8?B?NnNBTVFzZTlrOVRRL05rVGU2cEdVK1lkdFBCZWU5a0xPbTZ0UWRTNUlUcjhw?=
 =?utf-8?B?ZUMxRWFQNUlvcGhxemVIUTVYa3FkamFMVGloU202cnpKZ3prcmtoTUxhRmE5?=
 =?utf-8?Q?cXz+Sf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2xLRHdNVHJocGFuMWY2VHlZZkk0UExLL0c5WGxoZWp0aEF6anR5S1pBR2pD?=
 =?utf-8?B?U2REcDllQWdyYVVESFd4emVVSU11cmZKemI0a29oU2w3TmgxbkFKMCtvdjIv?=
 =?utf-8?B?NTFWYytsTnlMTk83ZWlHcHBkQi82V3B6VWdXS1pSVDdOQkZYd1RmNmJjNi8v?=
 =?utf-8?B?N01jZExLdU1SS1FJazRnM1FvWkpad241N1BTT3NmcnVyTmZlTHFGdG13aE1y?=
 =?utf-8?B?V1hLVTlta05MVFhrM3dGaGI4Q1VzU1lMMXpjRmJKODRscDlubjJwRVc2eDNy?=
 =?utf-8?B?OEhzVUZWYUFyMERoSmR1OVc0c2NnRkxXckNNbWtYNWJvWExPVy9IYnNmUVE3?=
 =?utf-8?B?QU5XaWEwVW41SXZwRjZlWnFxOUNoek4yUGN0blBqdTBabWxKbkk2SUN6Vk1S?=
 =?utf-8?B?WnBHR1pJeWp6emg4Qyt6WS80Y2lNcWE3NnRIczBGMjR1Z2RueDhtYkhDK2NQ?=
 =?utf-8?B?YTVVNC9Tc1BLajR0NWtGTEpzS2FNazNMaWUvS1E3SG9pcGFzaDN6YXcxWHJF?=
 =?utf-8?B?eEt4MjVNVnAweUlBZjJMbGFtUUNCK2NuaFc0R0xabWlFcTZZS1lwc0JFZlMw?=
 =?utf-8?B?bFhFai9ySFBEY3NzN085bEdadGhmTDJzbkUyblZjSFNZWWdVSVM1Yk9mK2JD?=
 =?utf-8?B?QTh0dlVBMjd0TG50SW9sYkVrdmFaOEJHU1FqZ3JnVTd4NXUwbm0yRzRJSHdK?=
 =?utf-8?B?Q3RLU2tOa0ZMV2krVGdvT0FTcVdiYlZyM1VGcmhMc1RPcWdCNkFXR1RqOWJ2?=
 =?utf-8?B?MS93N2llaTJCOC95QiszcldlTVlub1NtWkVkelhMYWxIbWxObFRVdGVxamFK?=
 =?utf-8?B?Y0EyL25UeDRaUEVGM2w1MlpFY3UzWEFiL1h4dnRBNFFsazJkTjV2NkJ0VUVr?=
 =?utf-8?B?dVVTV3JCQyt4L3BXZFp4YU5xeUhCVENIWkFpZE5vZEE5THdoUHhCcWNCa2tP?=
 =?utf-8?B?bHR3WURjYURPTVAxeHlKR3JhaG1BU1ZTSnNGNjR1cDZIQ0d6eXJFSFB1R05z?=
 =?utf-8?B?VTR6YWZVUVpJek82ZFM0WldSaWtSQmswSC9BU0kyV1B4M3BjbmorNXo0RFVq?=
 =?utf-8?B?OFdRZStQZWdBOGZ1OVh1aDE0dFdKeUhLVll1cUhnL1hxUUNtZURYUzZuK1ZY?=
 =?utf-8?B?Yzk3ejRrZUtDZ0ZNVXgyVldLWnMvZ1EvaHVUbjdnektsdFp1NkFTWnB5YzFF?=
 =?utf-8?B?SENnY2swNklRT3R2eUhzT2tRNFNPSjB3WnpuVjR6amlrSElLeE1JdTNncUti?=
 =?utf-8?B?djRuTlAyR0tHZ1N3bldzbnFvbjYzKzJHUUtUbDBWSlhyT0JOOXlFa3lCcHJ2?=
 =?utf-8?B?MlAzMHJ5WEpnK1RpWjUxOFR2QWFncUZkYUg3RFhIVkFDQXcvcnMwcnN5aCsv?=
 =?utf-8?B?TlpvL0J1NitrK1l5N1NBVzA2MFc1NCt6bDNZZnV0TE44SmM5TEh1RHpZS1p1?=
 =?utf-8?B?OENaY3FkY2p1eEJ0YmxtdXlGWG5za3diV2M0MkU4UzlUaGFBS0k4S1JmYUo2?=
 =?utf-8?B?SjBEbVNqNit2Z1BiMnE1a2gyZWFBbWsybk5kMDZNOEFxODlUd1JhTmxWUjdD?=
 =?utf-8?B?TzI2b1ZIUEFkWGFHWEFDOXpnV2NkMkc3RkRqaUZUQ1d4dDhNamhSVmxDaWZq?=
 =?utf-8?B?YlNDWi9RNDV4T2hMTVQ3UjJjbFIrd2NvY2JZdVFDT3h0ZS9LT3JhRDZBRmhD?=
 =?utf-8?B?RXZ1eFRnMGdxK2ZndWZaWmFWN2tzaFExQmdxMGpKcnowdHFXOUNZcWFxUmUx?=
 =?utf-8?B?eHBLdUJpdDlqOWpIUGNMVHAxSERZbkVldnlVWCtZYUhKOEVNOFR0b2lTZjlq?=
 =?utf-8?B?SitHNER1ZUpaYkpVaUEyU0VjWjhkb1lYM0ErUXNyaGY5MmpRaXo2WFJnMzBO?=
 =?utf-8?B?c055UFpzL2p5MjdWaUhFKzkxMHI3MkNSQjc4R05mc21DRCs4c25JOWo4djN6?=
 =?utf-8?B?UUpsU016Mmp0RHI4VHBKMzRReU1sYTREM2l5UTA5RmgxWTAxWFA1VVhBcERJ?=
 =?utf-8?B?N2duQy9JcFVwcE9hRWMyQXBDbncwYk5UcnNGM1hqUURBLzdzWXRvbVNGTDZG?=
 =?utf-8?B?Ym1MdW9WdkhxM0FGUzIxb0cyVTQ5eEdHOEdrU1VWNmpyUklqZm94MlpuWmd5?=
 =?utf-8?B?WkFqMGYxVFU1dDhGVnVkbDk1NFVMcld2SDBQZ3pRaEY0Ukw2MEF5TjNRQXpW?=
 =?utf-8?Q?Ixft5nmOEa484EhhznaPSaA5koZunJIf12/t3iZaiw5Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <252D817F9F7187408157D86C894FCF0F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0612c424-86c0-4524-a772-08de214ed0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 18:19:12.9269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHYbG/9Uko116TCnmWx8TMN4rFpJLyC4fp0luO58WL1IqX+La9t+ylIaZ6JiRfQeybW+rOSDB2iQRF155R/Aow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750

T24gMTEvMTEvMjUgMDE6MDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBTYXQsIE5v
diAwOCwgMjAyNSBhdCAwNDowMTowMVBNIC0wNzAwLCBDYWxlYiBTYW5kZXIgTWF0ZW9zIHdyb3Rl
Og0KPj4gVGhlIG51bWJlciBvZiBidmVjcyBjYW4gYmUgb2J0YWluZWQgZGlyZWN0bHkgZnJvbSBz
dHJ1Y3QgcmVxdWVzdCdzDQo+PiBucl9waHlzX3NlZ21lbnRzIGZpZWxkIHZpYSBibGtfcnFfbnJf
cGh5c19zZWdtZW50cygpLCBzbyB1c2UgdGhhdA0KPj4gaW5zdGVhZCBvZiBpdGVyYXRpbmcgb3Zl
ciB0aGUgYnZlY3MgYW4gZXh0cmEgdGltZS4NCj4gU2FtZSByZWFzb24gdGhpcyBkb2Vzbid0IHdv
cmsgYXMgTWluZyBleHBsYWluZWQgZm9yIHVibGsuDQo+DQo+IE1heWJlIHdlIHNob3VsZCBsaWZ0
IHRoaXMgY29kZSBmcm9tIGxvb3Avemxvb3AgaW50byBhIHdlbGwgZG9jdW1lbnRlZA0KPiBjb21t
b24gaGVscGVyIHRvIG1ha2UgaXQgbW9yZSBvYnZpb3VzPw0KPg0KPg0KQWJzb2x1dGVseSwgcGF0
Y2ggc2VudCB3aXRoIGFkZGVkIHF1YW50aXRhdGl2ZSBkYXRhIGZyb20gbXkgZXhwZXJpbWVudHMs
DQp0byBwcm92ZSB3aHkgYWJvdmUgaXMgd3JvbmcsIHBsZWFzZSBoYXZlIGEgbG9vay4NCg0KLWNr
DQoNCg0K
