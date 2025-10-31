Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB128488F
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939071; cv=fail; b=YzmMHPyVxS67wnh5H1A1Sh551lbL+g9nhQ8DSY6m2ywawS6eSv3KCkFhX03kByp78sCa2ps/LSOR/6HchCOPkJDJpWjMaMMHURWQKMxl9bhYhDsX+Lv1GNKjySH6PbPdoBOmHqyBqKKAhUwUoYRhTN+u5olqHx+hjZJlH1wBO6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939071; c=relaxed/simple;
	bh=ZV7lj2q5nc553Yx+OSQf8HXf3tTKnUIrz1gxK2KWUCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hA0Opi4wx1EorlpPesCgZBn+5/KzK8n+yrRu8MNZlllwYZdIJ62Iu9U2xJoIkPRiKATKF5ZWEcG6FK/8lssmvvNEgPecGOlmKFPBDmBMu/BagxjPMdYxFT7L8r/JfmjuM+VqF6UmdHL0ggW9nNuzEYq+KJHNAjCYM634lktNywk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K31sTdTy; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K31sTdTy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iULm5vrRO81XZhSXrR6F9DaBJF+ZTqBTVWQeR5y6PH0WhS10jiNwQQ/XvY0T2VtrJ6p4dWskFcUHcxzSPcUVneQICBt1qs4KTcswvmS1e2n7nsB9ZcbgpqR3SqYs6DelipsjnMlzlsD30gILG4XAI1SNODlI8NB2J1e6NPYgFcyHsYvJWiqEUipulFGwahgWYY/s7D8ORzwJZpAytUXbac+HIhDMpkMX/cbPCXPnHemw0+U4f2yyR2e+FtxCbNCGBnP3aJBO21Fh0hf17rbcPoS3DEEa+O/JkRRDH9fcX5hPT6REIC/au3zDppKB3X4l3eVUvz0Ym5QuqJ1PyvWuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV7lj2q5nc553Yx+OSQf8HXf3tTKnUIrz1gxK2KWUCw=;
 b=a5j9dGevmxPlRoh8ASoFj5lM86LO4M4Tlk6kvBge0MmxIf7ALvP6Jy2AnmXGInpMPDS6r6bd2/x9/BhCXJKaoF9CegddyWDtPsqcG3A1BnApfhN9Rnq2mlfXLpAbsr7mik8r8DR/KUTj7A5LLBYNXTrka+03m76lnw6n8UXN/6nNTYP/DHZH63giN7WOC+WoHEveLBkM+LMlJIH4YW2G9BMBGGjJEgcLUXHsZqlYF3xIV3aZFKvQFQjR6S562No45J/kGgpHidBk4o/Xh+6i6FTN/yAa7EE4aoXegoHcAOGCG8zqwUr8SQqJBVPaWGsEV8jhs2eTG/Q/lHKIEwXXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV7lj2q5nc553Yx+OSQf8HXf3tTKnUIrz1gxK2KWUCw=;
 b=K31sTdTyQXgvSqOdLZ5QO9HXNd9bZRoZWxELRaLKf2+viL+QEtOVJgK8R27BkoDIeVFvtn2PGe9auPJIXePM0m0/8OE24ZYbIf5IzNvWTL5AC1ZqAIeXh6SiRUfQy8oueCulTUiKpenbkOf1ktuJ3pmkKhOici4iQDRSRkCO8b+PkmzWpbhs8IG1eIO5XIo7I/3GPPIxCg8xpognj5AgDlLQZqnHSPGLmeesr4tKXNQg5hcT9Je7vXDkFckSGJ5RcZKZGDMKhNtzotOr5/zR47zmOeMet4+6+EHtg+V07PuHQ710zlWPNDnzgj/IO7wvADdy+Ix5UHdfbVycwdXWXg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:31:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:31:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Casey Chen <cachen@purestorage.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "yzhong@purestorage.com"
	<yzhong@purestorage.com>, "sconnor@purestorage.com"
	<sconnor@purestorage.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>, Ming Lei
	<ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Topic: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Index: AQHcSRhauqXv7enrvU2FX6HoDAYwUrTZ2SIAgAB+qICAAkx4AIAAA1eA
Date: Fri, 31 Oct 2025 19:31:04 +0000
Message-ID: <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
 <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
In-Reply-To:
 <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9121:EE_
x-ms-office365-filtering-correlation-id: 3ffcb6ff-5958-4550-7812-08de18b4081a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eW1MUmR6MnhsV2lVMFlsMGI1aTk0eWdyeEVCZDNFcGJCaDgzVk1wcGlFMVpR?=
 =?utf-8?B?VGNXb2ExMXMrTjhCYkhJcWd6Qk41OWpZVStpbGpCWU5RTTNpT0xUN0d6SzhS?=
 =?utf-8?B?dUx1MWw2K2Z3ZGU3Rk9xMTNzdWZNL2E1QXI3eVg5bzNTbUpXNEM1M0oyZlRu?=
 =?utf-8?B?Qy8rdCtETTBzd0d4cU8vRnRYWk9pRWdHZmhmR1d0K2tGUmNTQ1pPdXhBd0h3?=
 =?utf-8?B?OHo0UW5lZ0NBZ3k1cGFNaURncjRiVnBIODlyclF2TlNlMUVoYkVwZ3lwMXJh?=
 =?utf-8?B?cXM1K2o2aGJhUFZBRmZrZjBIVnJEaS9hMVljV2tKYTFpc1VXRStnczJnVmhX?=
 =?utf-8?B?Qm9hYnRsSGxCeU9aV0FzQlZPc2h5cUJ4Nk5xYThDKzBDdlFvNmVWUW5ZK2pV?=
 =?utf-8?B?R3JDdVNHVWdGVS9Wby8xbFBvNjRJNnBWRitjdzdBWWdJSlNMNHBoWGZSUWt0?=
 =?utf-8?B?UnBIOGRSeVpNbDRuMDdlYU8wc2tqRTFmSGd3bElTa215K1dGbUNsMlJnQ0JT?=
 =?utf-8?B?V1NLY2VyQkxGRnVZRk50aDg4cG1SY3hhenVXUFk4T2I3THlaRk05b04wcHF0?=
 =?utf-8?B?aGx0YktWNzZTWG5LeGhQc1NNUDBldlorV3VSSVZ1Qnk4THcxSFF0cXYyUndD?=
 =?utf-8?B?VFhuM3VMNnhwK0I0VTk0dk9nNXB3K0MzNHVicGVLZ3hIYUNGMEI4Sm1jTU5s?=
 =?utf-8?B?L0ZaOXVHc2V5NFVGSUxIaVdmQy9kSHY4c3FXR2VFSnYzRWpvaVUvZ0V6a3Fv?=
 =?utf-8?B?VGxTc3N3L0F6a1ZVc1ZPd2FtWStpeHBQa09sTVdhY2VLem8rZHBGb250RTN1?=
 =?utf-8?B?T2U5dWJTa1J1ZFBwWG5vVklEa0g0aWJiek13ZkxFUjc5Tmc0Njd1b3NEbklu?=
 =?utf-8?B?TlZYSk9yU2JMY05XbmFhSW9yY25Pcm8wSmpnbXB1MUkyb01hTVZTcXZCT2hT?=
 =?utf-8?B?a1o0MUlDUXg2Q09qYnFiMjVvVkI4KzNzaFcyRG53c3ltYzVRVFdjTStGcngx?=
 =?utf-8?B?RXNWUC9OMk50OVNkcGRCNzAvU3NjdStrVVhOTTAwQzZ6cU9nM1RoWk5BWlZq?=
 =?utf-8?B?NXI3QVRYZGRZWFNURFhRdDBCREJmczI3ZTB1QVZTU3NXRE90T0Y2OTJpbUdV?=
 =?utf-8?B?N1ovOGVYdW96b2FSWkNVRVpxK0o5TEszZEE1RWxWRVUvUENYVjNRNkFCdlJh?=
 =?utf-8?B?RENRNWZ0aHYzUlNPWmZGSVlqS2l0MXlQVzZXNFBMZ0ExZloxVFRLc3lsb1BK?=
 =?utf-8?B?K3VuYUtNY3owaHlVRjI3YjhGNVhPL0JGMTdZdmV1U291OWI1Zi80VFNhaVdx?=
 =?utf-8?B?NDhqck5CWnRKR0hHZllCbk51M0NLd1J5Tk9nRk1OMzFLUDFSREVhcnhwb0RO?=
 =?utf-8?B?dDh1ODY4N0VlR3VJeTByUFJJbFhSY0EwbGxsd3Yvc1BWc2hWMDNaSHRZQ2lo?=
 =?utf-8?B?a051MEU0Uk5yYUNkNGZnV3FiZDNwSlBFSktMbk1nWDFPNUZhVVZOY01JM2xE?=
 =?utf-8?B?aXdVZ1N6TUJYUFU4UUtINlFqYTg0QlIxd0Q3UXdJTzB1VXhrN1E3RTdCMkhh?=
 =?utf-8?B?TFl2Rmh3VVA0U0xuanIzYXhiRy9ST3JGWVV6aEFyNWFjVWtlbXcvL2YxMHdE?=
 =?utf-8?B?cmthNjM1bXpVaVNFcTR6VHloOXd5Y1RYNlFXa1kzRzBBTmtORWR2cGdTazI0?=
 =?utf-8?B?b09FR2VIdUZtTTM1dHJwNlhWeVlhOFcwbnpMY09wSjdRd01CU1RxbmVPOXZC?=
 =?utf-8?B?VmtFOU9JWmlERmVrS1cxMXdLKzM4RXoySjZ4UndyYnEvQ2kvSmdmT21nWDdm?=
 =?utf-8?B?WnJTNU41TCtHREdRTWJHd0duNnRsRS9vV1E4V3FlQzVHRnBaSDB0Y1FXNzZu?=
 =?utf-8?B?ZStaRGxFUTUvSmdOVzNSS2xsTTJTakhqa29IeEIyanZnamlHKzNFakJPbTl1?=
 =?utf-8?B?cjNWK1FFemVBTGMvOTlIMWdWWXQ5eFRMM2drbEJOTnIreXNoME1rbG5QM2pn?=
 =?utf-8?B?UFlsa0JsU3ZJNGRTSXhBUjJQSWxXUFVoNVVYMnZwRVhBRU44Yno5R3hvL09r?=
 =?utf-8?Q?p1vLnw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTl6dmRwTUJ1Q05DcFJ5VkV6eEZxdWVFU3FhQ1BEOU5xQjNHZ3FiTklSazFJ?=
 =?utf-8?B?K0xLTjI3L0UybUFDQWk4VDRkMTh4Uyt5M0FySitrRTNVTFlKWDdIbDdwQ0VC?=
 =?utf-8?B?N1VISkZPOWlVQ2pocWUzY1hYb3BFUU9TNVRSOFFGQXZDTHVmMHkrMTkxbGQ3?=
 =?utf-8?B?WmdvQ3NCNlVtMTRNZ1hpRmlkYTZacEhBSCs0alloZjQvWWlrL2dLanN4YTRn?=
 =?utf-8?B?SElpOXBtL1Y4UkhiR0xRQ2dzK2Z0Yk15cnBKdVRhTzMyanN6aVJhMWNLTWc5?=
 =?utf-8?B?MmU1Wk1YOU92aFZsMzJtZmFDR3R3QThLYUwxSGJNWXNEVnNoY3Q2RFhRMU9j?=
 =?utf-8?B?TzN3RTJNejAwUmxKNWd1YmkxTzdGbjBNQWJmYVVMREZhQXhFWjRhWERUSTJL?=
 =?utf-8?B?Z2V4cWlBdjVtK2NTRWxJanNJeXo3MDErTGdUdExSaW10LzhKaVFWUndiZXcy?=
 =?utf-8?B?a0FhaFozaEcrajk2WHBUblZKazN6U3dMWmc1eHoyM0o5MFJXS0E2WUpnM1Vq?=
 =?utf-8?B?Q01VcXYvUk1QVzVGNEtDYmRjdTA3eFE3amxicXEvVTJhT2xTZFZxNkRmeS9T?=
 =?utf-8?B?TXdrRS9GVk9XS3NuKytPaW1zaE9lR0doMXlLcUhwcHNaWHRYdVE0M04vbVQv?=
 =?utf-8?B?Y0k2NEpTellMZjZiS0N4OU5VRVpYVVlpbGc5WjlLcWpQVVFMS0dmZlpkUkJQ?=
 =?utf-8?B?bUFtR2ZtQzVKRStuY2pyc20xNGZUdFV3U0E0TmIzWjArVXdublFlNVJXUkhu?=
 =?utf-8?B?K2VxUkRHaFFxZ1R6VlE1Z3hTc2FGbU84TDNPbHVramFHakRSOVd2L0RVK284?=
 =?utf-8?B?M3Z2a2pUdlFYYWJyYkthQmJ3elVFWThrVERVZmZHNjE1aEUvNVNLeTZURVpu?=
 =?utf-8?B?Vy9rb3lIS2FGMU1PLzFUSU5FRVBOQ2ltVFR5TkQ4SndRdld0ZjVra0lqNmVP?=
 =?utf-8?B?dDFzRk4rMldsamlTZm9QbFJVMmlxMlc0SXFoU0pHRVdyRlRWeG1FOXBoZjhZ?=
 =?utf-8?B?ampnZVl3VTdVdVRQQzZ3cW9xcjVOMEpPVzNGeXVUL2tORVZLYmhVZlkvS3FS?=
 =?utf-8?B?WE9ucE9PWFNvNXJpaDNLSXBjSW9tNlROZ3JyaC9CN1g3ZUZlaldMcUVpdERt?=
 =?utf-8?B?MGZPdnpHMEVacVlnS2Z4MXRnSHJJemtYb1E1VkppSjROcDlIZ0kvN3dmYU9n?=
 =?utf-8?B?RzBmUDhXR0o1UkdzQWpXZ1BPT2lSL0Jib090UTZwT0tTWGZPRlRuNk5URGk5?=
 =?utf-8?B?UWs5K1ZZbjAwUjIwbCtlaDBTemlDRmhrMHUraVc2eEF6VUtxY2R1RWdBRzRM?=
 =?utf-8?B?MHp1K2tPL0hkbDZvUU1QWGVKVDhFYXJJWnVMbjNTeDBiUktTeHFpSktyQ3Ux?=
 =?utf-8?B?cU1rOEt4eEFmYnFLSUVyUjlrZUZ6OGV2eVQ4cVZWSmdBUlFwQWpmVS9mTWpm?=
 =?utf-8?B?RHh2TGo3dXVoYnZZd25mV2RxTS90RUh1UmEzNTJBdWdkT25tTDZXZFl2d2tU?=
 =?utf-8?B?Qy8vdm41U3QraDEzVVNSUSsxaU5LV1YzNmxFYUloRlJmNzZmTXF1MnMzTHNr?=
 =?utf-8?B?ZEpsRkJ4QjZlUGFNUWFUMExpMFBtUHlJSHl0U0pPeTZiazQxQ0VGaFNOL1JK?=
 =?utf-8?B?bHlVYVRXbVFCWHkwcktxR3h1dDZ2cVhyZzcrY3V1SzVNdWhicmsraVJzZ0RE?=
 =?utf-8?B?Z0szOHE3TkNpWVU5SnM3WkI4WVRiOGxjS1NMNjlVRlppb0ZKaTBQZW5OOGxk?=
 =?utf-8?B?QnFoQUd5djdUb1NaUE5QZktob2ZNNTd5aWVlaktJd24rOTVucmFmbENHUHRh?=
 =?utf-8?B?cUFkSlkzL3lMVUZyN1YxTXpyd1FhMW5aV3RPc2hqczhweXRlSVdvdkN2Q2Fh?=
 =?utf-8?B?QnA3R0FJR3l6RC82dEttaCs5TFBmdi9sZGNDRzJEOVdpbjE0OVJ3azRWdVp4?=
 =?utf-8?B?M3YxU0IvVk5mNWRnTTFCNHNwRTl4MHVlVEJLRUdORkVmQkxTVURRb0JPTVh6?=
 =?utf-8?B?MHJnc0Urblp0NUFJVnpyVzlSS05NRHpnNFJHT2NOaFZvc2xCcGEwVXo1Uzhx?=
 =?utf-8?B?WWRxQjlkUUJUZjErOERNWU9jWGt5eHVMdGVURzFuNVdqd0tVc1Fsb0IwRmJB?=
 =?utf-8?B?elNiMUtkTDgvWXVkeDJDOVdNQi8wNkd4cTlVOFE3YnJSWERXNjFwS25OSGJD?=
 =?utf-8?Q?7cnEL8w4GDMuig4pY696Oe/d5aGEE/Y8sJ9U5KQ2asfM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A6DCBE498C60D4385BEE928541BFF9E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffcb6ff-5958-4550-7812-08de18b4081a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 19:31:04.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UJyo//E3HARbx4CYexq3PygGoqLbn2JZwRBmgOEWh4Xq1OG/OFlOFcyd2o0wKIlXkjFSUKBaaS1fFEFAc26Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

T24gMTAvMzEvMjUgMTI6MTksIENhc2V5IENoZW4gd3JvdGU6DQo+IE9uIFRodSwgT2N0IDMwLCAy
MDI1IGF0IDE6MTLigK9BTSBDaGFpdGFueWEgS3Vsa2FybmkNCj4gPGNoYWl0YW55YWtAbnZpZGlh
LmNvbT4gd3JvdGU6DQo+PiBPbiAxMC8yOS8yNSAxNzozOSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+
Pj4gT24gV2VkLCBPY3QgMjksIDIwMjUgYXQgMDM6MDg6NTNQTSAtMDYwMCwgQ2FzZXkgQ2hlbiB3
cm90ZToNCj4+Pj4gRml4IHRoaXMgYnkgdGFraW5nIGFuIGFkZGl0aW9uYWwgcmVmZXJlbmNlIG9u
IHRoZSBhZG1pbiBxdWV1ZSBkdXJpbmcNCj4+Pj4gbmFtZXNwYWNlIGFsbG9jYXRpb24gYW5kIHJl
bGVhc2luZyBpdCBkdXJpbmcgbmFtZXNwYWNlIGNsZWFudXAuDQo+Pj4gU2luY2UgdGhlIG5hbWVz
cGFjZXMgYWxyZWFkeSBob2xkIHJlZmVyZW5jZXMgb24gdGhlIGNvbnRyb2xsZXIsIHdvdWxkIGl0
DQo+Pj4gYmUgc2ltcGxlciB0byBtb3ZlIHRoZSBjb250cm9sbGVyJ3MgZmluYWwgYmxrX3B1dF9x
dWV1ZSB0byB0aGUgZmluYWwNCj4+PiBjdHJsIGZyZWU/IFRoaXMgc2hvdWxkIGhhdmUgdGhlIHNh
bWUgbGlmZXRpbWUgYXMgeW91ciBwYXRjaCwgYnV0IHdpdGgNCj4+PiBzaW1wbGVyIHJlZiBjb3Vu
dGluZzoNCj4+Pg0KPj4+IC0tLQ0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+PiBpbmRleCBmYTQxODFkN2RlNzM2
Li4wYjgzZDgyZjY3ZTc1IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4+IEBAIC00OTAxLDcgKzQ5
MDEsNiBAQCB2b2lkIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoc3RydWN0IG52bWVfY3RybCAq
Y3RybCkNCj4+PiAgICAgICAgICAgICovDQo+Pj4gICAgICAgICAgIG52bWVfc3RvcF9rZWVwX2Fs
aXZlKGN0cmwpOw0KPj4+ICAgICAgICAgICBibGtfbXFfZGVzdHJveV9xdWV1ZShjdHJsLT5hZG1p
bl9xKTsNCj4+PiAtICAgICAgIGJsa19wdXRfcXVldWUoY3RybC0+YWRtaW5fcSk7DQo+Pj4gICAg
ICAgICAgIGlmIChjdHJsLT5vcHMtPmZsYWdzICYgTlZNRV9GX0ZBQlJJQ1MpIHsNCj4+PiAgICAg
ICAgICAgICAgICAgICBibGtfbXFfZGVzdHJveV9xdWV1ZShjdHJsLT5mYWJyaWNzX3EpOw0KPj4+
ICAgICAgICAgICAgICAgICAgIGJsa19wdXRfcXVldWUoY3RybC0+ZmFicmljc19xKTsNCj4+PiBA
QCAtNTA0NSw2ICs1MDQ0LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9mcmVlX2N0cmwoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPj4+ICAgICAgICAgICAgICAgICAgIGNvbnRhaW5lcl9vZihkZXYsIHN0cnVj
dCBudm1lX2N0cmwsIGN0cmxfZGV2aWNlKTsNCj4+PiAgICAgICAgICAgc3RydWN0IG52bWVfc3Vi
c3lzdGVtICpzdWJzeXMgPSBjdHJsLT5zdWJzeXM7DQo+Pj4NCj4+PiArICAgICAgIGJsa19wdXRf
cXVldWUoY3RybC0+YWRtaW5fcSk7DQo+Pj4gICAgICAgICAgIGlmICghc3Vic3lzIHx8IGN0cmwt
Pmluc3RhbmNlICE9IHN1YnN5cy0+aW5zdGFuY2UpDQo+Pj4gICAgICAgICAgICAgICAgICAgaWRh
X2ZyZWUoJm52bWVfaW5zdGFuY2VfaWRhLCBjdHJsLT5pbnN0YW5jZSk7DQo+Pj4gICAgICAgICAg
IG52bWVfZnJlZV9jZWxzKGN0cmwpOw0KPj4+IC0tDQo+Pj4NCj4+IGFib3ZlIGlzIG11Y2ggYmV0
dGVyIGFwcHJvYWNoIHRoYXQgZG9lc24ndCByZWx5IG9uIHRha2luZyBleHRyYQ0KPj4gcmVmIGNv
dW50IGJ1dCB1c2luZyBleGlzdGluZyBjb3VudCB0byBwcm90ZWN0IHRoZSBVQUYuDQo+PiBJJ3Zl
IGFkZGVkIHJlcXVpcmVkIGNvbW1lbnRzIHRoYXQgYXJlIHZlcnkgbXVjaCBuZWVkZWQgaGVyZSwN
Cj4+IHRvdGFsbHkgdW50ZXN0ZWQgOi0NCj4+DQo+PiBudm1lOiBmaXggVUFGIHdoZW4gYWNjZXNz
aW5nIGFkbWluIHF1ZXVlIGFmdGVyIHJlbW92YWwNCj4+DQo+PiBGaXggYSB1c2UtYWZ0ZXItZnJl
ZSB3aGVyZSB1c2Vyc3BhY2UgSU9DVExzIGNhbiBhY2Nlc3MgY3RybC0+YWRtaW5fcQ0KPj4gYWZ0
ZXIgaXQgaGFzIGJlZW4gZnJlZWQgZHVyaW5nIGNvbnRyb2xsZXIgcmVtb3ZhbC4NCj4+DQo+PiBU
aGUgUmFjZSBDb25kaXRpb246DQo+Pg0KPj4gICAgIFRocmVhZCAxICh1c2Vyc3BhY2UgSU9DVEwp
ICAgICAgICAgIFRocmVhZCAyIChzeXNmcyByZW1vdmUpDQo+PiAgICAgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0gICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAgIG9wZW4oL2Rl
di9udm1lMG4xKSAtPiBmZD0zDQo+PiAgICAgaW9jdGwoMywgTlZNRV9JT0NUTF9BRE1JTl9DTUQp
DQo+PiAgICAgICBudm1lX2lvY3RsKCkNCj4+ICAgICAgIG52bWVfdXNlcl9jbWQoKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlY2hvIDEgPiAuLi4vcmVtb3Zl
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaV9kZXZpY2Vf
cmVtb3ZlKCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnZt
ZV9yZW1vdmUoKQ0KPj4gICAgbnZtZV9yZW1vdmVfYWRtaW5fdGFnX3NldCgpDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmxrX3B1dF9xdWV1ZShhZG1pbl9x
KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtSQ1UgZ3Jh
Y2UgcGVyaW9kXQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJsa19mcmVlX3F1ZXVlKGFkbWluX3EpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrbWVtX2NhY2hlX2ZyZWUoKSA8LSBGUkVFRA0KPj4gICAgICAgbnZt
ZV9zdWJtaXRfdXNlcl9jbWQobnMtPmN0cmwtPmFkbWluX3EpIDwtIFNUQUxFIFBPSU5URVINCj4+
ICAgICAgICAgYmxrX21xX2FsbG9jX3JlcXVlc3QoYWRtaW5fcSkNCj4+ICAgICAgICAgICBibGtf
cXVldWVfZW50ZXIoYWRtaW5fcSkNCj4+ICAgICAgICAgICAgICoqKiBVU0UtQUZURVItRlJFRSAq
KioNCj4+DQo+Pg0KPj4gVGhlIGFkbWluIHF1ZXVlIGlzIGZyZWVkIGluIG52bWVfcmVtb3ZlX2Fk
bWluX3RhZ19zZXQoKSB3aGlsZSB1c2Vyc3BhY2UNCj4+IG1heSBzdGlsbCBob2xkIG9wZW4gZmls
ZSBkZXNjcmlwdG9ycyB0byBuYW1lc3BhY2UgZGV2aWNlcy4gVGhlc2Ugb3Blbg0KPj4gZmlsZSBk
ZXNjcmlwdG9ycyBjYW4gaXNzdWUgSU9DVExzIHRoYXQgZGVyZWZlcmVuY2UgY3RybC0+YWRtaW5f
cSBhZnRlcg0KPj4gaXQgaGFzIGJlZW4gZnJlZWQuDQo+Pg0KPj4gRGVmZXIgYmxrX3B1dF9xdWV1
ZShjdHJsLT5hZG1pbl9xKSBmcm9tIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoKSB0bw0KPj4g
bnZtZV9mcmVlX2N0cmwoKS4gU2luY2UgZWFjaCBuYW1lc3BhY2UgaG9sZHMgYSBjb250cm9sbGVy
IHJlZmVyZW5jZSB2aWENCj4+IG52bWVfZ2V0X2N0cmwoKS9udm1lX3B1dF9jdHJsKCksIHRoZSBj
b250cm9sbGVyIHdpbGwgb25seSBiZSBmcmVlZCBhZnRlcg0KPj4gYWxsIG5hbWVzcGFjZXMgKGFu
ZCB0aGVpciBvcGVuIGZpbGUgZGVzY3JpcHRvcnMpIGFyZSByZWxlYXNlZC4gVGhpcw0KPj4gZ3Vh
cmFudGVlcyBhZG1pbl9xIHJlbWFpbnMgYWxsb2NhdGVkIHdoaWxlIGl0IG1heSBzdGlsbCBiZSBh
Y2Nlc3NlZC4NCj4+DQo+PiBBZnRlciBibGtfbXFfZGVzdHJveV9xdWV1ZSgpIGluIG52bWVfcmVt
b3ZlX2FkbWluX3RhZ19zZXQoKSwgdGhlIHF1ZXVlDQo+PiBpcyBtYXJrZWQgZHlpbmcgKFFVRVVF
X0ZMQUdfRFlJTkcpLCBzbyBuZXcgSU9DVEwgYXR0ZW1wdHMgZmFpbCBzYWZlbHkNCj4+IGF0IGJs
a19xdWV1ZV9lbnRlcigpIHdpdGggLUVOT0RFVi4gVGhlIHF1ZXVlIHN0cnVjdHVyZSByZW1haW5z
IHZhbGlkIGZvcg0KPj4gcG9pbnRlciBkZXJlZmVyZW5jZSB1bnRpbCBudm1lX2ZyZWVfY3RybCgp
IGlzIGNhbGxlZC4NCj4+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8
IDIyICsrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4gaW5kZXggNzM0YWQ3
MjVlNmY0Li5kYmJjZjk5ZGJlZjggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4gQEAgLTQ4OTcsNyAr
NDg5NywxOSBAQCB2b2lkIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoc3RydWN0IG52bWVfY3Ry
bA0KPj4gKmN0cmwpDQo+PiAgICAgICAgICovDQo+PiAgICAgICAgbnZtZV9zdG9wX2tlZXBfYWxp
dmUoY3RybCk7DQo+PiAgICAgICAgYmxrX21xX2Rlc3Ryb3lfcXVldWUoY3RybC0+YWRtaW5fcSk7
DQo+PiAtICAgIGJsa19wdXRfcXVldWUoY3RybC0+YWRtaW5fcSk7DQo+PiArICAgIC8qKg0KPj4g
KyAgICAgKiBEZWZlciBibGtfcHV0X3F1ZXVlKCkgdG8gbnZtZV9mcmVlX2N0cmwoKSB0byBwcmV2
ZW50IHVzZS1hZnRlci1mcmVlLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBVc2Vyc3BhY2UgbWF5
IGhvbGQgb3BlbiBmaWxlIGRlc2NyaXB0b3JzIHRvIG5hbWVzcGFjZSBkZXZpY2VzIGFuZA0KPj4g
KyAgICAgKiBpc3N1ZSBJT0NUTHMgdGhhdCBkZXJlZmVyZW5jZSBjdHJsLT5hZG1pbl9xIGFmdGVy
IGNvbnRyb2xsZXIgcmVtb3ZhbA0KPj4gKyAgICAgKiBzdGFydHMuIFNpbmNlIGVhY2ggbmFtZXNw
YWNlIGhvbGRzIGEgY29udHJvbGxlciByZWZlcmVuY2UsIGRlZmVycmluZw0KPj4gKyAgICAgKiB0
aGUgZmluYWwgcXVldWUgcmVsZWFzZSBlbnN1cmVzIGFkbWluX3EgcmVtYWlucyBhbGxvY2F0ZWQg
dW50aWwgYWxsDQo+PiArICAgICAqIG5hbWVzcGFjZSByZWZlcmVuY2VzIGFyZSByZWxlYXNlZC4N
Cj4+ICsgICAgICoNCj4+ICsgICAgICogYmxrX21xX2Rlc3Ryb3lfcXVldWUoKSBhYm92ZSBtYXJr
cyB0aGUgcXVldWUgZHlpbmcNCj4+IChRVUVVRV9GTEFHX0RZSU5HKSwNCj4+ICsgICAgICogY2F1
c2luZyBuZXcgcmVxdWVzdHMgdG8gZmFpbCBhdCBibGtfcXVldWVfZW50ZXIoKSB3aXRoIC1FTk9E
RVYgd2hpbGUNCj4+ICsgICAgICoga2VlcGluZyB0aGUgc3RydWN0dXJlIHZhbGlkIGZvciBwb2lu
dGVyIGFjY2Vzcy4NCj4+ICsgICAgICovDQo+PiAgICAgICAgaWYgKGN0cmwtPm9wcy0+ZmxhZ3Mg
JiBOVk1FX0ZfRkFCUklDUykgew0KPj4gICAgICAgICAgICBibGtfbXFfZGVzdHJveV9xdWV1ZShj
dHJsLT5mYWJyaWNzX3EpOw0KPj4gICAgICAgICAgICBibGtfcHV0X3F1ZXVlKGN0cmwtPmZhYnJp
Y3NfcSk7DQo+PiBAQCAtNTA0MSw2ICs1MDUzLDE0IEBAIHN0YXRpYyB2b2lkIG52bWVfZnJlZV9j
dHJsKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgICAgICAgICAgY29udGFpbmVyX29mKGRldiwg
c3RydWN0IG52bWVfY3RybCwgY3RybF9kZXZpY2UpOw0KPj4gICAgICAgIHN0cnVjdCBudm1lX3N1
YnN5c3RlbSAqc3Vic3lzID0gY3RybC0+c3Vic3lzOw0KPj4NCj4+ICsgICAgLyoqDQo+PiArICAg
ICAqIFJlbGVhc2UgYWRtaW5fcSdzIGZpbmFsIHJlZmVyZW5jZS4gQWxsIG5hbWVzcGFjZSByZWZl
cmVuY2VzIGhhdmUNCj4+ICsgICAgICogYmVlbiByZWxlYXNlZCBhdCB0aGlzIHBvaW50LiBOVUxM
IGNoZWNrIGlzIG5lZWRlZCBmb3IgdG8gaGFuZGxlDQo+PiArICAgICAqIGFsbG9jYXRpb24gZmFp
bHVyZSBpbiBudm1lX2FsbG9jX2FkbWluX3RhZ19zZXQoKS4NCj4+ICsgICAgICovDQo+PiArICAg
IGlmIChjdHJsLT5hZG1pbl9xKQ0KPj4gKyAgICAgICAgYmxrX3B1dF9xdWV1ZShjdHJsLT5hZG1p
bl9xKTsNCj4+ICsNCj4+ICAgICAgICBpZiAoIXN1YnN5cyB8fCBjdHJsLT5pbnN0YW5jZSAhPSBz
dWJzeXMtPmluc3RhbmNlKQ0KPj4gICAgICAgICAgICBpZGFfZnJlZSgmbnZtZV9pbnN0YW5jZV9p
ZGEsIGN0cmwtPmluc3RhbmNlKTsNCj4+ICAgICAgICBudm1lX2ZyZWVfY2VscyhjdHJsKTsNCj4+
DQo+PiAtY2sNCj4+DQo+Pg0KPj4NCj4gVGhhbmtzIENoYWl0YW55YS4gSSB0ZXN0ZWQgeW91ciBm
aXggYW5kIGFsbCB0ZXN0cyBsb29rIGdvb2QuIFdlJ3JlDQo+IGxvb2tpbmcgZm9yd2FyZCB0byB5
b3VyIGZpbmFsIHZlcnNpb24uDQoNCg0KVGhpcyBpcyBLZWl0aCdzIHBhdGNoIEkganVzdCB0ZXN0
ZWQgaGlzIHBhdGNoIGFuZCBhZGRlZCBjb21taXQgbG9nLWNvbW1lbnRzLg0KDQoNCi1jaw0KDQoN
Cg==
