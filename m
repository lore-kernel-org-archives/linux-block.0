Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9520B1F4;
	Fri, 11 Oct 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637703; cv=fail; b=DEHSFx5am2nJfkkjfkeiaJnDefPe0h791HS9OLV4SqW6EoyG/y0YMpGXh3fNJo+kw5arfnPkNc/gQ+e0lNuC0L8J77xKnYlaWwips3Ipfik4ListM0ovP2V+MhB+WHriHSXfvWBJt6nlKydb91SqbxllId+LXDBRlTVjNNTw3mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637703; c=relaxed/simple;
	bh=uN0nnRPsFIM2pf6E9qzHUmqmU1K8A2WFcD2jRXl3Q30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X2ILlNpWHSMS0zhFJDL/WGdSqynH7kywpLE5wXASUhlfcYeihx+OLXAAXCNQq4mWzCmSukDmK/NSIz2Pd2rCIEfeEuifZqIaZV1qeVtITkaJh3bN2xsSaAL0V6lKQHKNJuJ77LV+hWQkPLBH5G3gWZhGb8JoJULBbtiis1shGos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NTHWpHkh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iAYeMBQQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NTHWpHkh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iAYeMBQQ"
X-UUID: 5931aac487b011ef8b96093e013ec31c-20241011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uN0nnRPsFIM2pf6E9qzHUmqmU1K8A2WFcD2jRXl3Q30=;
	b=NTHWpHkhrimCHSg6qGN9i7ekxlDSjlNJjeK+RZ8b9Ch5EWOyi9xk/CQfACXaoP9VLhSQb5AIb4PL6iC3iJKMvLEoWYjp1iEdBLINcFUZT3u73Z4rGUph4YLO3qNpsxYQkTGUDxgJn/K6AAOj29G1ez9vBqyyk3Qoio7nyh9YIqs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:4b1a939e-15f4-46f2-b77a-5012c22c4a39,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fd83a226-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5931aac487b011ef8b96093e013ec31c-20241011
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2021172029; Fri, 11 Oct 2024 17:08:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Oct 2024 17:08:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 11 Oct 2024 17:08:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEXsEZEuMFjyNOFZ2c1LcEk/6SwC1n39vi3Yl1kzpkm1qwXYuPoW3eBBTd/SCown7RbrhB3vrOQWLGyEDFTYxUddtfwFus2/09lCRUm3kdh9Fgnrw1XPQne2PAc6abZnHq/b6upWOFkkZHrqSjgNK7r20xOMvrhpktlknRhbCPuU3Edbj7JsNbXnazM+IZ2d15my5uH1Ag2UtogZDMbcEKFtbaXZLMMISOUTLMihmMj5bvE4NrnapTmonVFFDDi23HJ6yonltKksG+oEBPNHpnYpI1FovS5bqUHy6/rSNobW1VPBWZdVFcVYmTnEJ30xOFUy2qS9ksbG28LDXDiJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN0nnRPsFIM2pf6E9qzHUmqmU1K8A2WFcD2jRXl3Q30=;
 b=uwOiUw4pC14MDfZFc38/2tkp3yXE0bxsOogkMhq7C82bfr5h1Z37KfEiDbkd/MuFOsK7wSgQsa5tfLEp7Wg2DLXt4b8Z6gRl8cuA7RN/d9jGxs64F5HtIf8S9R3ICgQ0JV30FyLEQeWOt0TeNpHAQ7MfnCSMnXK6PHboBfQnd6RLfyhTw/+rM1JuqzKJm5PcHNML+4/IW+d5G0EKgx8olvRCtXrUBtCcUNig1B/BrXZak+XLcm7A75BheYI1iNRl5JUbODYt0cLUbBfkuLyAPFajf5ia85NJDOFUgN4LnbAb7xm9Jw3GsMAKW8MYeXVBLAVUr2zm+Ta7rkN3dTzDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN0nnRPsFIM2pf6E9qzHUmqmU1K8A2WFcD2jRXl3Q30=;
 b=iAYeMBQQbfBqACBfa17sFYmx4OGebhcdEvURI4RZKRMhD0SewViFGQTYy4w8dAmDuKbT+I1EW53jVn+bxpCmbZXpqa0AcxR+BXWM5Dvn//UgncDxbNruQfUzsPhVYoL3mANVlH/2uvPl+p9hJIQr56zgVKQ7jfJ1YqH+ROabjIM=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by SEZPR03MB7298.apcprd03.prod.outlook.com (2603:1096:101:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 09:08:10 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%4]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 09:08:10 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "ying.huang@intel.com" <ying.huang@intel.com>
CC: =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"baohua@kernel.org" <baohua@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	wsd_upstream <wsd_upstream@mediatek.com>, "david@redhat.com"
	<david@redhat.com>, "schatzberg.dan@gmail.com" <schatzberg.dan@gmail.com>,
	=?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?=
	<John.Hsu@mediatek.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "kasong@tencent.com" <kasong@tencent.com>,
	=?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>
Subject: Re: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and
 SWP_READ_SYNCHRONOUS_IO
Thread-Topic: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and
 SWP_READ_SYNCHRONOUS_IO
Thread-Index: AQHbCod08FuriN+lckm7AKNlb4+2T7JoJsoogBk+VYA=
Date: Fri, 11 Oct 2024 09:08:10 +0000
Message-ID: <17b30f253172cce94d1e2ec86d00e82eea077bde.camel@mediatek.com>
References: <20240919112952.981-1-qun-wei.lin@mediatek.com>
	 <87frporxtt.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frporxtt.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|SEZPR03MB7298:EE_
x-ms-office365-filtering-correlation-id: 84e20d17-5968-42f3-ee8c-08dce9d43aac
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aWlBZWFVMzlGZkFpeWkzbzFLVXVyeC95aSszc3JZZXBkSGFGNXhPQkJHMVNt?=
 =?utf-8?B?TVFWa3JvQ29PcEVTTXJuM0VOYUxPeVRac3l2cXROckd3NU5yZHcyVWZoWE1s?=
 =?utf-8?B?UFNEUEZMYThBdDdtUWFybUMybGdxRWYvWmJDTy8rS3pNUW9TQlgvMzFGL0o2?=
 =?utf-8?B?M1FsVTlxTUtRQWlRMFpPeEllZ1NRSGo5TVlkOENyelR4Rlc5b0dBQkFHQVRt?=
 =?utf-8?B?Y1ZSaVgzN3Y1UjJmdWM0RXhsL01CU1ZYMFpjKzl6dkdQbFpHUjRZeHZYUy9l?=
 =?utf-8?B?a3E1QkVIUlZ2KzZRdE5xbG51V1Fob2REUnU4NjFETzVUK1pnOG9tQmNYTUxE?=
 =?utf-8?B?VzhzZ1pLMUYrZ0FHT1hzZ1hRMms0OHREQ1NxRUJoR0NjSS9jdWEzekcvdXY5?=
 =?utf-8?B?djhzLzhPUEw4eithYnlyekJ5QnpqbG45WlRyaHlnVlJ4RWl0NUdlNXlOdE5X?=
 =?utf-8?B?TENib2dFMEVtNkhSK0E4Y1hOWnQ1elBZdmJJWVJjUVhLUG10QmtUeXc0bHdE?=
 =?utf-8?B?VVRMRnNOUmh0VGJXUzFWVWNjUUEvRytsL1BzTUtJdWZiVFdXR2RqTFRtQ25O?=
 =?utf-8?B?SVJ0eFlPUWk2Tk83UFowU3YxNDBhMFdqREFnUzZxR2ZYK3JxNWw2SUp1Z1J5?=
 =?utf-8?B?akp1OE0zc1lkMXRkZTZwNzUrWEg4K0RkdnlkMCt2UWRWNlRaakVuME9Fd3ZR?=
 =?utf-8?B?dVJYdTVmeWRLOGtDRXAvWjFCMnNGeEZBb0tXQmc1MjJ3VUVQM1FISzhXaDBo?=
 =?utf-8?B?bXI0SFlQc3liR2h5T0RncVdONWJPdTlQV2h0aDlwQXRGSUs5L2xIZG8rME41?=
 =?utf-8?B?d2I3dS9hUFh6RnJZcmpoa0N3endTUHNoaURDWGdDZWZrcjF0Y0NoTGNDM3h1?=
 =?utf-8?B?KzZ0TU9KaVJ2cnJBZHczNUdqYUdXMnhKSEQ4TGwvVFg5cUQ4NzRYaXRhWmRO?=
 =?utf-8?B?K1A1OVk4Q1lTejJwQjUreHBhbzBQQXVBTEFoTFV2WG9pZEZVSU5ES3lVejR2?=
 =?utf-8?B?a2MyV0tGempab0ZVMU52T0xzbkd2bU9qSTVlMmxBVjZJclBXeEhRUmJqVTEr?=
 =?utf-8?B?MERHL0l2RmphT1RGNUJPbUNHNUlWekx5R0orWHEyRnZWcXFzWnBjNU5FeW5P?=
 =?utf-8?B?aENUeW9HQU1LVEhuVENBRkFSSEYrZWQxakVwTng4TWFQV1QveWYrVUpCNzg3?=
 =?utf-8?B?UFd6SEFiTDNJUmFzMlcySStTRk1tTXRoYlBGRit6akM3MjkzU3pYclM3Mlhy?=
 =?utf-8?B?UUNNNzdVWWdEZ0RhVFJ5WjdaR3phRnFFcmJoaFgxYTBoQVNLcHlqMlI5TFE3?=
 =?utf-8?B?QlpmRGJOM3ZXZ0JiVzZoWkVQR2c3ZFpoSWtVTVFMWFlLclJucFVrMkdERm1n?=
 =?utf-8?B?SkNSTC8ydTM5dlVVYjU5MEQ0WEJvaEpQYW5IV2tXWlh5V3Uxc1phcGRxN3FT?=
 =?utf-8?B?UW1oNEtYTUcwcWN6YjVvaGx4SU5EUTc0Vy9sSjhLdDJHRFdJT2tEZCtiRW00?=
 =?utf-8?B?UnhSMVpYYXNuOTBBTEIvV3NkQXp3ekVTZlNhdXN4SFdyZnZMVk5mc2UzbDZx?=
 =?utf-8?B?REg1UXEyTGR2WTRJM0FuRVVsRHBraU5nL2hhcnlwd0IrQjAvdm9nNXNsc0RT?=
 =?utf-8?B?TkY1SDdkdkRZaWdkNnVmL0pIQXFzUXVsSjhnQXowVEtVclBOZmxWc3ZaOFZC?=
 =?utf-8?B?VlJWbmpxbENWWTVGOUpEdEdKSURiT3B1akRJWUduUjI4dmtLeXZPWlRXR2c3?=
 =?utf-8?B?bWs5c0EzbHJMMlh0TDhvZStuQVlqM094NFpjUktLTXFCWUVRa0Fjd0RrdW00?=
 =?utf-8?B?L3daVFgxSTJwRnpITGMzdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHNtampsSDJZWFBvSHlrNFRuV0NrbGRVdUU3Q0lFcU1rY3FkQytqOE5RK3g3?=
 =?utf-8?B?eFNVNGluMVNndEM3dU5GcEc0ckhUa1N4TmpjaXp1bjFxOXhiaElSZ3ZTdmVk?=
 =?utf-8?B?K2lHMGlhS28wYktrQ3dHNG5ibjltVFlaTXF1Q3Q0WFlDSEw1NEd4SmkraHUz?=
 =?utf-8?B?V2tsQjVGS0xxRnlTeGY3SjUvQjF1M3k4MllpSVg1TFpPUXRVUzFOLzc4V2F3?=
 =?utf-8?B?L2dKeHRPTXRHa2J1ajlpM05rREpKdWhVU1JkUng4UW9zZ1RxbWRLSXlVSkZh?=
 =?utf-8?B?MlJ6ZE5yOGg0YUxxMmdGMTNnYjUySnRpallzbU9MQjhNSmh3UzJkUjRkZDY4?=
 =?utf-8?B?RHdFMTR4MDY1a2VtR1BHb1lsRzgzVWlzRFk3UFJWYVowV3lSUU5FTjJVd1M3?=
 =?utf-8?B?Uys0Z09ScGVKQTdpaTJrTndDNWVOYVpsS3MwTmQ5MFk0VUxiZnFSOFQ4RDhr?=
 =?utf-8?B?WU5RcUMxbXQ5SVByUUxGeEtUTDh4ZVliOUcwbFQxaWhCVS9aTnVqd2VSQ1pQ?=
 =?utf-8?B?cks0Q2pBZlZGbVB3MDVnQnFPZllYaUpUVlRWR0tYcnR1TWthUVFWVVA3cjY4?=
 =?utf-8?B?ejdjek9tVldJRk5XOWxxNXpqemRzZEptWUxFZDZzdDZYVWxrWXZuVmhtQ3M4?=
 =?utf-8?B?ak55ZzFhUEQ4QXlqYTZLR3cyMTZCK3pYK3BLYVM3dkFObmxJN0hDcGlRdU93?=
 =?utf-8?B?L1VYYXA0NGxrWHRSZnp2VFJuazN2ZzdHVUJwWE9BYXVTWXVWb25pbXg5WHVM?=
 =?utf-8?B?SGlRUXp5Sld5WmVYU29YWHlOaDRUVnRQdHl4WmpvQ0o5QSs4cWhVK29maStM?=
 =?utf-8?B?NWczQUxPT3NwWFpsTmVvR2tmYzZKWmxMUE5Lamo5N2FvYlNuTGt6UndERUVR?=
 =?utf-8?B?RkRmTlZGU25XQkNUblFOM2g1RStTak4yZ2lyODdUVnZqdWJSVkdrOHFCMStz?=
 =?utf-8?B?ZGpsd0N5cmwyMGcxZHN0WCt5UDNwdUU2VTlrUUxMQUlrQ2N3RDRicnFPVTB0?=
 =?utf-8?B?VmtZUC91K2xPdE9ycmxvcVFSSDhsQzM1cTFYUkdINjFxeVhVMXZ1am81dTRz?=
 =?utf-8?B?Q0hmc2VPM3ZlOHc2R3Z4bDN5dHY5TWtDR05CKys5SXN5OTR0bE5hK3JaNjU1?=
 =?utf-8?B?dzc5THJyK1ROZEEyeEtoV0tkT2NJMWkwSTlYaEhhVzVLcWZ6c2E0dDlBZnZF?=
 =?utf-8?B?elhQN2ZEUW9vYTZpM0xlbnhsQXFPYmxMdWsxaVp0Yklra2FrYlQyZmx5Tkps?=
 =?utf-8?B?UlNUV1huQmRtcG9VcEpzRVRHNEtJL3FTaENibDcxZnJldVBwS3NWWkVzQUNr?=
 =?utf-8?B?YWFCSWowMWh0bWEraXA4Ky8yQlFFVkhJNEVtNFpVeW9yU00wbFRCRG1aSysw?=
 =?utf-8?B?dkRwKy9COEFiUjc1WjREZFN6aWN6bm5FZGNtOXY4c3pZUTNpQ1FUMFhOUDU0?=
 =?utf-8?B?ZG5jemVRbnYyc3F6cXRkODNjRmRpanpkZGV0bGcrRWVseUYzb0MyZ3NuT2s1?=
 =?utf-8?B?enkrYm01ZDg2T2R3cld5c2Vqc1YwYTZIV0UxUjBTOUU4NGV4blVvaEJXQ0t6?=
 =?utf-8?B?cE1FZkthSVdldUZMaFBDbVFPSTBEeVV6TUdqc252UHhVZnlYVFFtTnl0b1RN?=
 =?utf-8?B?SFRrYy9zaUs1Q0tDRGE3NHlwNEVjTGowdkc2d3VzUmI1SElLNVQvQkVXem5z?=
 =?utf-8?B?V3crY01KZnZyV1kwd1F1WnNiT2FVUXVOMGpMZTZSSVFpUFI0MHF2b3plZTlq?=
 =?utf-8?B?ZWovZW8xYUhHeFM1NnM2V3lmQ2hrNjNJMmFhNzN5YS9FRHVMZHlnZG9QV0c5?=
 =?utf-8?B?TG9DWHBFWXBWVHcwRS8rcFVsVit1NUx1d0hIYW1uQ3V2OFhpT2NyckxuRFpU?=
 =?utf-8?B?SGhWN3pxY041MGpTOFZIRWFybXZGNXljWTkzaDU5ZFQ0Si9qUGVHK1dWOUMx?=
 =?utf-8?B?TVl3ZUIzNEd0TlNFNDZpMjgySXFNQ1RDQ1FKSkx2d3IzZmFaTnFVZVRLbUtQ?=
 =?utf-8?B?UkJxZnhvY3BENkVxY0R5Q0cra3dRZjhwMkhjZnZUbkhwNVpMVDlDNjVMdzZ3?=
 =?utf-8?B?M1hPU3VwWkNMb2FwRGZYWlR2LzZJZGJBSUIvNjVBNTAramVyeXdnMjUycWxn?=
 =?utf-8?B?cGtsTG9jTnlqcnRpajAySktaenR3Y08weWF4S0QrdkdMb2VMU1gxY0RMVVp3?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D302519F7774FA4FB927294B1FA071E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e20d17-5968-42f3-ee8c-08dce9d43aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 09:08:10.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KspmU+fhO9lU3qQrx/vs3EGhB7L0DBtE0f8DleGkedB9ybXooK6so0qzsBd98lsEgsbWrt9GVPZPn6Umd68jnUnWKCiVN+tS1ArvEefTJZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7298

SGkgWWluZywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHF1ZXN0aW9uLg0KDQpUaGUgcHJpbWFyeSBt
b3RpdmF0aW9uIGZvciB0aGVzZSBuZXcgZmVhdHVyZSBmbGFncyBpcyB0byBoYW5kbGUNCnNjZW5h
cmlvcyB3aGVyZSB3ZSB3YW50IHJlYWQgb3BlcmF0aW9ucyB0byBiZSBjb21wbGV0ZWQgd2l0aGlu
IHRoZQ0Kc3VibWl0IGNvbnRleHQsIHdoaWxlIHdyaXRlIG9wZXJhdGlvbnMgYXJlIGhhbmRsZWQg
aW4gYSBkaWZmZXJlbnQNCmNvbnRleHQuDQoNClRoaXMgZG9lcyBub3QgbmVjZXNzYXJpbHkgaW1w
bHkgdGhhdCB0aGUgd3JpdGUgb3BlcmF0aW9ucyBhcmUgc2xvdzsNCnJhdGhlciwgaXQgaXMgYWJv
dXQgb3B0aW1pemluZyB0aGUgaGFuZGxpbmcgb2YgcmVhZCBhbmQgd3JpdGUNCm9wZXJhdGlvbnMg
YmFzZWQgb24gdGhlaXIgc3BlY2lmaWMgY2hhcmFjdGVyaXN0aWNzIGFuZCByZXF1aXJlbWVudHMu
DQoNCkJlc3QgUmVnYXJkcywNClF1bi1XZWkNCg0KT24gV2VkLCAyMDI0LTA5LTI1IGF0IDE1OjM0
ICswODAwLCBIdWFuZywgWWluZyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBRdW4tV2VpIExpbiA8
cXVuLXdlaS5saW5AbWVkaWF0ZWsuY29tPiB3cml0ZXM6DQo+IA0KPiA+IFRoaXMgcGF0Y2hzZXQg
aW50cm9kdWNlcyAyIG5ldyBmZWF0dXJlIGZsYWdzLA0KPiBCTEtfRkVBVF9SRUFEX1NZTkNIUk9O
T1VTIGFuZA0KPiA+IFNXUF9SRUFEX1NZTkNIUk9OT1VTX0lPLg0KPiA+DQo+ID4gVGhlc2UgY2hh
bmdlcyBhcmUgbW90aXZhdGVkIGJ5IHRoZSBuZWVkIHRvIGJldHRlciBhY2NvbW1vZGF0ZQ0KPiBj
ZXJ0YWluIHN3YXANCj4gPiBkZXZpY2VzIHRoYXQgc3VwcG9ydCBzeW5jaHJvbm91cyByZWFkIG9w
ZXJhdGlvbnMgYnV0IGFzeW5jaHJvbm91cw0KPiB3cml0ZQ0KPiA+IG9wZXJhdGlvbnMuDQo+ID4N
Cj4gPiBUaGUgZXhpc3RpbmcgQkxLX0ZFQVRfU1lOQ0hST05PVVMgYW5kIFNXUF9TWU5DSFJPTk9V
U19JTyBmbGFncyBhcmUNCj4gbm90DQo+ID4gc3VmZmljaWVudCBmb3IgdGhlc2UgZGV2aWNlcywg
YXMgdGhleSBlbmZvcmNlIHN5bmNocm9ub3VzIGJlaGF2aW9yDQo+IGZvciBib3RoDQo+ID4gcmVh
ZCBhbmQgd3JpdGUgb3BlcmF0aW9ucy4NCj4gDQo+IFdoaWNoIGtpbmQgb2YgZGV2aWNlIG5lZWRz
IHRoaXM/ICBSZWFkIGZhc3QsIGJ1dCB3cml0ZSBzbG93Pw0KPiANCj4gLS0NCj4gQmVzdCBSZWdh
cmRzLA0KPiBIdWFuZywgWWluZw0K
