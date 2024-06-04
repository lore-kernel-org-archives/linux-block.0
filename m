Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A413775E
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464201; cv=fail; b=oFEIvcXF8SNKFj7DXx1/KBMImQQuGQmXKCOQN0NDmPWwGT0/FR71hTct4qryF5FQgf6pqX5eBA/piZzL1rYu+XHJn9WVKTK8bY7zvO1PdjUrA+Tme4mxw6FctcznSoAgSOM8qXNl3h8MGtLwAd/m6tT54/lwFXmLubA/RMkSbMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464201; c=relaxed/simple;
	bh=oiYSemAve9KMZ2TwG55bpiCnSGpwOhxx0YgkDv1y7SE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsyZ8d3u/7oK4t854bbRenerotOy/JJ35NPNqY43437vm3dsiSTzsb8MwLP0MvtH536Ol479IsEWOQble45MWl9tTxb0rwbozJpY2WhgPtpxSkYtbQBqrX8Jjia/t0Xlcw0zaP45qXynlBFWzGXzzHKFsHKrcII2/xnvqDtYRCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WSxH0qv7; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WSxH0qv7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYX+8vkoIO1wBX0AC8qifs17cuYsRYcfEZf8sB04SIVORtqoWhZtezCWZBesEym2ILpa4PG22/7y+Q9YeavocRjXejxm7Uf4xYDPtC6LFT9uMLfBSVkco4QvdW5xSMH2VmLAA8v85NxHWvmY24fk+pxnQwfkG9IeY7IheDyEfgGivzZFrpJ9gnScpdiTjWQ4nOZOw0GaWuL3VXp5IMQu7cDQAg4jQJ1v3tNLxe2Sy3ule1FvlKKyfTG4cDRu3Rc1R8bquz5Rco6gAuSbHIu2HsbutEKejkIPyqsFtOs6aJmvykZEndEhktGOvNDAniH19Qufc9F8vd338UUGV059Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiYSemAve9KMZ2TwG55bpiCnSGpwOhxx0YgkDv1y7SE=;
 b=KDsEnFI237Xv5hvUZh4yV6DaUAYV6kT1wgp1Aa7D03JTmR0NnieHCm122wcQIEWnpkI2tyfambsTIYfut00cKVVM38mYaINjHIPVQ+VqmLSR4eFdxERjR9c2sEZ6Pvggp1AE1C9oPVeWQnbud5w9rSEz0gl2jFNKtgHKKeC0cpb5mid209z5w270l9MXUh9cJvF5UWv8oJYRw1xS93ZoTYCQ0MwXCOVUst0XWhjJ0dWw9dWTVW8X2vkVndCiKCU8lVsY2JMlWlydFQ7BQc3EIEhrLuiVpC51BciDBGT3gZLgiuHOhqnAmYXA6emgy3HUW09p8TGN6LnAp/0zbn9hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiYSemAve9KMZ2TwG55bpiCnSGpwOhxx0YgkDv1y7SE=;
 b=WSxH0qv7P/AqiaBVO1iQa5hrATRwWMCNoaRv35QEcLGZAvD1RyWFesS6F383r9ceHw1EactJjRiOzO66o0nCETqF8nc0oojph4BPZf9+nyJE0JHGYzADsPLmQhwwGsH8PUw4auZxIg7NOrF0Nz/0Rtnliqf35CkcLFR1uyDkX8WQKEKFfggC/inJugokR9L28UN305vXkzopbYSvj8/dXFUBCmbLfvjRr/553iSaCbzKMtIOqCwk80uy2HvnLCjdJkkfUEYpJTQ726GyUnyvPr0mU66Fz+rRKa3ctWtAsBN0olxjak/xNYBYHBp9GXxLpZS35YktOmamHfuohdU1KQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 01:23:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 01:23:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] README: add dependent command descriptions
Thread-Topic: [PATCH blktests] README: add dependent command descriptions
Thread-Index: AQHathgmysfyxOOiFEGn+DaYKO1xP7G2z1uA
Date: Tue, 4 Jun 2024 01:23:15 +0000
Message-ID: <66dde821-c532-479f-8cec-c7811a47e4b2@nvidia.com>
References: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB9161:EE_
x-ms-office365-filtering-correlation-id: 24e01a1e-82ed-4291-6906-08dc8434e891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGtybDh6aTFvL0RQRFlPcFo3cVVDYkd1S2hWUHA0V0hqVTBKRW1yZ3hjWmR5?=
 =?utf-8?B?Um4wamNLU3cxeTlOTFFzdFJJT3gzMkcyalR4bHNwWno2RkVTdW1xTzhCeFp0?=
 =?utf-8?B?cng0OHRRT1plZU5OQUsxa3NBV1E3UU1kNnlKWHZHK1BPYXI1TDFCRTVBYWl2?=
 =?utf-8?B?UkdFcmkwbS9SVVJqeWdvdjhzSlVXZXBjakFQaEkxc0VRMXVIbE9iaVFiTURa?=
 =?utf-8?B?RzMxVzIvSEtTU0xnVTUxeXA2Y2U3d2ZPUGZMRjlWcFdvaEpBVFdUcVhWSWUv?=
 =?utf-8?B?WlhDTFRFdGt0eW9iVWV3QWh3K0xoVzQ4eHN3OUljZ1djVXdXUE1kbWF0dkc2?=
 =?utf-8?B?SnBKS0xhOS9tNW1WM3EweWdERWJKcFV6YXlkdFNjd1k3WU5xTGVyaTJYRVhX?=
 =?utf-8?B?SDVCTXBIUGtQd2tBL3pxcTVvVTduckJPdk05TExVT20weGFUZ2QxbjdOSzRT?=
 =?utf-8?B?aHh1M3pJRlkyYk5pVTFEZG0xekNvdUhMNkUvZEovZVU0NE54NXI2N01iU3hF?=
 =?utf-8?B?L0dqRUM4WVhXTXlSVktYK3h3blJLSGt4akxmZkFVMXVkRFhPdzNnUTlpUThJ?=
 =?utf-8?B?TFlpWi9acCtKOWFSaTNBWm1pWHZOK1ZSOXBHcGRNRC8zYUN1NThqRm1wM2Y0?=
 =?utf-8?B?eGo5MlhDWXIvdG90clJjT3R0QXVOZ1ZqQTBqVTdrMDBWRUNHY20yd2Q3VVM4?=
 =?utf-8?B?eG9ZRkZTaU9CYkpZUVNyaTNYWlI1ZFliMHhYaEhHeUdQV1FaZzdNZXpvQkti?=
 =?utf-8?B?QlZBQkYxc0dKc0doRXd0OVpiNEJpajhnOStLVXU0MTdNd21PdXJpOGFVYnZ1?=
 =?utf-8?B?RWlSa0ptRmRlRy9ab0YwSkhoMWY1dDRWWU9Ra1hyZUQ2QXlrYnp5K0FqdzhF?=
 =?utf-8?B?RlFSQ1ZFeTRlTVl5NEVMd1JVUTIzSm4zdUk0cDlJL3R2Q1BOL0FNZHlWNklP?=
 =?utf-8?B?RG8rMmx5MTBxUy9CZTNpd3V1YkhUeXdyUXNvVFJMcFJieE5SOVBhWEx1ZHF6?=
 =?utf-8?B?WEFBcktManV4UW1RZzV0RWQrNFVyZ1pVSFBWL204ZUsrbmtxN28xajVMcm9o?=
 =?utf-8?B?SkdNYWtlOEV1QzRyc2NwTlROSUtZVVhQVEo2ZkJUU0RuOEc1aUVpNkZJbEtD?=
 =?utf-8?B?YjdJZG4zeExSRHBYKzduR3NPQWNJOEw0Z2w2ODkvYkp1aWNPWmJjdC9NWXZP?=
 =?utf-8?B?MmxldE1ZVjdZRFNGSnB2MkZXWHRwV3VPaFNMRXNnNUJZd0NTMWVBNG0wUkc5?=
 =?utf-8?B?RDNIaDBNSUtTUkZPV0I0ckZRM3l2SFFWb01EWnlHOTZCV0VDS01IQUpReEt2?=
 =?utf-8?B?Znk0TlpHYVVVMnM3dzdSRGl5TnpZRlZWcDE5WUhoMkRENzhON3J4RkdnRzNE?=
 =?utf-8?B?emFUeUV1UElKYnhjV1pQa1pERWx3QXY3Z1o5RGdjSzFWNjQ1WHFlMElWb3NY?=
 =?utf-8?B?QXpJcFR0MTdCOEdVRHRIMndGTGRvb1g5UDVQOWRqYVAyTGRWNGdPN2s1TUEr?=
 =?utf-8?B?b2hRbmVabWp0R1p3RWRwdnNUTUVGWWpzbmhqbHM2bVlsdktXS3JpTnh4WnBZ?=
 =?utf-8?B?R21DWndKaVVuMUJMR0pZYmtzdVpySXljdk4yUVpmWE5mY25WTWUxT0xLUHVI?=
 =?utf-8?B?ZVlPbHVJSGcvaVhJUlI0VFQ1N3lIL01hR3ZoYVFVNW02R3VKTlppamowM1Ni?=
 =?utf-8?B?WjBxZkVNQVprbXZ0WCsxdVlyOWU3OVBGUW1NVGhFNUtkT1p6SC9jTXQzaU5z?=
 =?utf-8?B?T294cWcvaVVFYW96bEIyVEswSEUySFhUL01SMlYxUHRSRzBIcGRvQUFmY0V5?=
 =?utf-8?B?UzRxTVlIaVNsZ2pEWlBpUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHVlZ0RNQzI4N1NuNkF4TDVmZnd2eEk5SUtGNDZwN29yTERPSTYrVTlqRStZ?=
 =?utf-8?B?Z1VCSERubk43VnZ4ejdiY0tWRElZWk81NW9zd1pUMVFOTzJNZE5jaDBMenR2?=
 =?utf-8?B?QVk1UmY4VUFTcGVqcHR6SGY2UlVNQnZPSTYyaXpTTjB4NCtSbXZkYVNYeWNx?=
 =?utf-8?B?YXZLR2JRbDBaS05tN0JNbFNYdGtFN0xCdm5nM0xvd3lKZGQ2ditlOFU5d1Jz?=
 =?utf-8?B?TnVVSDNGR2FJUlpmeHI1S0lTbXUyV0pHV3lTT0lXTzFraGFVSHgybjUveis3?=
 =?utf-8?B?YTdKR3ZDYVNLeWprdTIva3BUOWZwNEN6NWx3N0xLMGZac2h2dXZWaDJNenpM?=
 =?utf-8?B?WU1yYjVOOFliT0oydjlNQnR4RE9qdlp3ZzB4MVJNdjFwRVZNT0JpV2gybGlM?=
 =?utf-8?B?bUpjajh3UURaVDJXUjVsQTF4OWpVaFBOZHJuOGFxSVhuQ2RnSHZRbzMxR0xP?=
 =?utf-8?B?ZjA2N0NZcWh0YkJKVFhLc2JuYjlIUU12VGJwcEdicTZGUFNuSFNrQm1BUk1J?=
 =?utf-8?B?SkFmWXE3UjNQRVFtZDFHdVhYSjZza3NobGU1bmJWYTk5RjRWYllqNTVpbHRi?=
 =?utf-8?B?a2tiVVV4T2RsT1VSVFpRR0xsQUNuMHZDQmdGU2h4YWJ2MlFlN3lVWU5RbDUw?=
 =?utf-8?B?OVY2dzg5YnRZUWw5VHdDNGcrNFlURDJ6VU1XRXRPVm9pQjV5RGp0d1J0dW5r?=
 =?utf-8?B?TEpnZGlFS1RJdmFHNzhGbzlUQnFualRvOUxSZ1VXeUhvNWVzYjhPTVR1QmJR?=
 =?utf-8?B?alJkTlVlZitTNXZNSkJ4ZmprTkxZdStHYkZDTElwQ2FGMUhOTnQvSVl1YlZE?=
 =?utf-8?B?UEZPRkFLYTR5TEtjVUVFUGducHVBZHJoV0MxQnVmM0N5SjZLQnFNc0xubDRa?=
 =?utf-8?B?TThEMXlVRGNLZ1U3ajJLbVlpdnVJaSsrY3pBTFBvL0xKWkQ0eEg4NVV3MHpE?=
 =?utf-8?B?VExtcGswNk5vaWJyL3BMdlZKaktoeFdOUUxteGZqRFFaZFJvL1hHSVNDZENR?=
 =?utf-8?B?L1dxMXI1TWQyK3ZmdC9IYjdDMDFZNEthZGwwYnVkUHg5S2p3TjQzbmF4OEoy?=
 =?utf-8?B?VEFUbkFubkp6T0R6cWpaYXRMc2FiZUcxWXdQTVUxNWJHaXlqc20xMnI1MGg5?=
 =?utf-8?B?Q3g2ZjRlb0tacWtxZGJJbCtlTGx2WjhEM1hMcjVwakdXTXQxMWMxQnpVendL?=
 =?utf-8?B?Z1lLV21RU3NlZDUvMStpUnIvQk1GVVMraDNjSGEwTHJ1UndML2lxQXZqSkli?=
 =?utf-8?B?UjlEd3Q5NHdqMGg1MGJVb2p0aGZyQ2dwblgyMlQzMnYyNnBhSFFvZUlJSjgx?=
 =?utf-8?B?d0hyUjRvMERxWUxBcjlVZTNvTXlwMVZGRWJObmZGRmN5Mm1LaFFnSHZKTXY4?=
 =?utf-8?B?cVdXSmNDdFI2TEtKcEJhOTQrcWlQalRQbkVxeEQ0S1Y2N29iU0lNMDd5eTBN?=
 =?utf-8?B?cmJQbklocGcydytCY2VCSW1WWWlSYnl3SXRpSUhMMHRSVHVDNXZ6UlNmdjlZ?=
 =?utf-8?B?MkxLK1h3V0ZrREU4T0k0dldsZkVrZXl0MmYzODdPcUJhWC94YXo5a2oyWkRr?=
 =?utf-8?B?ZHAvTTZvL3dFcmZMeGpHUkwvcUZJeCt2Z0QrMXhoU0ZoS0N3UkRpYnFhN2Fy?=
 =?utf-8?B?TUhzNEIzWUd0cnVtM0xmY3lPc2FYZWhOSS9RblNseFV6Uktzc09hZ25tejlF?=
 =?utf-8?B?QVFveVZBamIxcHJzbThuMy9tQlUzMjJkc21QYUxiczFWYWxRYVFtKzRkSE9J?=
 =?utf-8?B?SDZzbTU2amFaTWNlcFRWZm5EMWJJbjhLN2FLaG1PbStOb056Vk5TT2ZRc0Ri?=
 =?utf-8?B?SW9xTVpYNitSd3IxQnIxcDFRUWRqNXBlNGRsOTBKNmM2Um90ZSt2ZHZVVzZD?=
 =?utf-8?B?bGM4c2ZXMVZDVWhsTUlMVzNuUC9oeVhyV0tQZGxXSGR6NTlsN1ZhRTdRMEVB?=
 =?utf-8?B?eTl6VWUxVTVwZjhiNHJwQUQvTjF5RVViOWdUTUZLT0tGQnBERDNLZjNwcjQ0?=
 =?utf-8?B?QnhyWU52aGt0cFM4ZzdBd0R1Mnh3ZFJ0V0lCVXBVQVp5VXhqdjZONE5TRW9S?=
 =?utf-8?B?ZDE5dzYyMVJKNU9ZL283OUVsdXJSeXpwenJ1YnA1elYvWGV6ZFRWMUtGNTlx?=
 =?utf-8?B?SXJMc3cvd0ZEdWhqWGdTZlNnbHZKVkdOQTkwL2hjejlLdXdRNTZjd0F6WWFt?=
 =?utf-8?Q?6CaX3jf5eGyt8rGGz3f6zT6baRJ5IasAkwDV47KWZqZ/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9FF9FFDA0011C41B2B711626E7F91B3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e01a1e-82ed-4291-6906-08dc8434e891
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 01:23:15.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKdCD8D0rjr6y0ry7y/XZswOQ9Y+o+lwHOyR2QHKMXtXYRpCCdUZV97NVx6ikGIQwrOCvN1n4HWQidhr8PwzPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

T24gNi8zLzI0IDE3OjQyLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gRXZlbiB0aG91
Z2ggbWFueSB0ZXN0IGNhc2VzIGFzc3VtZSB0aGUgYXZhaWxhYmlsaXR5IG9mIHRoZSBzeXN0ZW1k
LXVkZXYNCj4gc2VydmljZSBhbmQgdGhlIHVkZXZhZG0gY29tbWFuZCwgdGhpcyBkZXBlbmRlbmN5
IGlzIG5vdCBkZXNjcmliZWQuIEFkZA0KPiBpdCB0byB0aGUgZGVwZW5kZW5jeSBsaXN0LiBBbHNv
IGFkZCBvcHRpb25hbCBkZXBlbmRlbmNpZXMgdG8gb3RoZXINCj4gY29tbWFuZHM6IG1rZnMuZjJm
cywgbWtmcy5idHJmcywgbnZtZSwgbmJkLWNsaWVudCBhbmQgbmJkLXNlcnZlci4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2k8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMu
Y29tPg0KDQpUaGFua3MgYSBsb3QsIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
