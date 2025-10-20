Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC6303C8D
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002886; cv=fail; b=Ase8THYMCXxNaZX6DcGufV6NtxodPgBnEz542BZafLh10x2kBxfsY7hQLuSRRuhaxTIB1efsAD7GT4KSZK9qX1z9+ESX7KHcEVUTh9EAN+uOht8yjSSHaafTUBJ0oBMNjZwWkoNlW7ll7eghxlt0XTXFG0JZwZK+M7h2KttnqMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002886; c=relaxed/simple;
	bh=fkmYy8wAKdQy/TWuJrf2zlr1F0ctuDh0Yp3lfmAV9ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilLd22kC/C9UModQfpLraUYJ/m8RMLk7yCMSzKJIjHQEiiOT6X1oEWJOoiBddub0hTP8xzywnwbgNkUplPz4pRUxV6KvJNBCvgDfeVjXGDpe0U7UwfDsjx/vAF2NlTi4X3FWjvtRdkWq8DHz/GEwbyW3Hdj19pblgg8mkAIdfJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6M6f7f5; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6M6f7f5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GufH2YwpJlm2qo7ZJOdXXa3DQyP5pJ5hIqhYxPDZ3FBc4tDGCEYgkt+t5txQ1XX/7Wo8gwolzgsjZReKyMVMpY3eE/Y6K+bBLX93zLw4lKe/zsPbTpRONFCnW5zv/NIqLCkB6qsL7jWCchkUpDRnp8KcOPQzwx99l/6HPVHJXnfb4KYFbPIOf7mkuy/QROULvaXg+CpjsyyglYZcvdGrZ6kMd6B/B6kKMvlpvKwFO9tyJBWJIvr8nwcsDXDHXsWj4MEfZe++/hnASaDDakpAPd0oTaD7vMh92/ngieNiH1vsHqovhiyKxqX+jz5NUNgmCHhDga0YR+3otZz/9tiO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkmYy8wAKdQy/TWuJrf2zlr1F0ctuDh0Yp3lfmAV9ko=;
 b=OoLcz/GHZvC7P16qJL1fIAw2dJrrc2/nNEzTsL/O4mCfe4xNnl0NgDC6B5Y5c3EtK+FPD2xJ6eFzewxDSdPZUvsIA1JEImYngziJHJurrFBSSKZkO4glGa3QkqtMD1rwbLk0Tnu9DeGuBdFYibcijXbVQ5sK0W04jOVf7faWrVGasglAv4OhNJmk5UEbAbkT1sm9YSaNtnFFXazKr56cA8ftxi2O744fJVyan3RNovM4Pkx/M2wAp0zb6MaXquOw7chUeADZ6sa+9flnDu7d7f5o93X30KCfn7oAlWPrnUjX8Z0UBMwS8gABr1jsq3hLTa24XkP2b+Rt9YyF8CEgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkmYy8wAKdQy/TWuJrf2zlr1F0ctuDh0Yp3lfmAV9ko=;
 b=r6M6f7f51t+XY/hghZraZ+2Xj0M3tMqIliCfv1+HAEuMQaMqxLpiy0FauRp1MQ6BWz/PPMn2VWwYGYEmCkbL3A8xfT9jbCJCVQHK+WrmE87lGmBNZDs85cT4n6u2InU+AuB1YvijBHj1GPsbR6osaILk68z1CmVMpePVjeFDFMYXemHqIy+7Z/jY3xqn7/In1wkk86u4bMlihL5tXmvAuBvx95OPI2qUGHDgZGep5HL6D19vIKb3/fsX5ukeT+mS6MELLX7UpfNpgbUEPb0JgU8ga23e1560khXH4Nba/0EBToXU3SKYkZBFn9/BdXnXxV9h9+4hyoJbIAqgdc/tjg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 23:28:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:28:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv2] block: rename min_segment_size
Thread-Topic: [PATCHv2] block: rename min_segment_size
Thread-Index: AQHcQgLPs89xIQrzCUGexmZ7fzJnxrTLrlGA
Date: Mon, 20 Oct 2025 23:28:00 +0000
Message-ID: <995806f3-c875-4c8a-af5b-68c05822495c@nvidia.com>
References: <20251020204715.3664483-1-kbusch@meta.com>
In-Reply-To: <20251020204715.3664483-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6429:EE_
x-ms-office365-filtering-correlation-id: af2c01e6-7b91-40c4-9068-08de10304f0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEhOZWkxdzFTY1gzUUNKKytBUXc1blp3R1RkN3hRUnVRNEhPWFFDaHNlbjJZ?=
 =?utf-8?B?YVVybnFNcXRFdUNZWkFpSU4zR1lZOVBsQnVWK3g0azRzZ2p1enBYdERXcU5h?=
 =?utf-8?B?aFR2MHEybmsrcnp5M3ZSa2lxeUhLdzFWemJvVnhHWlRYZ0puTndib1VldFcx?=
 =?utf-8?B?VkhMOGV4SE0vL2lyZHRtUE53dkF5TkJBL3ZlR0w5dlVOdWRNN0Z4elJNNnRN?=
 =?utf-8?B?UzlIZzZaR0RmVUJHWFlhaEJiSEZFenNCb0NleUNxc0NUNlZzMXhZRTZSdStq?=
 =?utf-8?B?V1ZNNFlad1VjMldWNkcvTWFLeVZrQnkwRTAvVUlQVDRmaGdXNU5zT1RCOTFs?=
 =?utf-8?B?RklXVjhON2VYemtodjVZR0dkME83TE1lb1B1NHhoQW1pRysvUEpSU3pmK212?=
 =?utf-8?B?NHVvOUd2bjNtQnZabkhHd2w1amdiblhlQkdwelo4bW5GMVQ3THNpckVIODk3?=
 =?utf-8?B?M2l2T1RHYXE0cUVyN2FrZkNIbGNXSXdaNjhWeEkrRFVNWmpIdFkwaU1FWU55?=
 =?utf-8?B?bWUyVTE5eGU2MVMxUWVsaDdBdE1pRHlMVDJ4UGxRUUNJUlVhV24vYWo4aUdG?=
 =?utf-8?B?OUwybEx5SjJLNXVOSmJlRk8rbzEwWnNEbHNsWlJPK0FFSmU1ZEhvOTdscTJP?=
 =?utf-8?B?L2xxQzV6N3RBc28vN2I0NVZ2cmJDL3lKOEMyM1M3Z1ZpU3hwUjZyTGJLUEhU?=
 =?utf-8?B?UC9pK01nYXhJT3NPUFBIVW93QzR0NWFJZkU0Slpld2ZveXI0MXlmRGtsWmFN?=
 =?utf-8?B?aW9kOHNpZ2xpV1M4RGR0ZjdhaVZOWnVsREw4SkZLQjU3TDQ2VDVYRjBXTU00?=
 =?utf-8?B?WWdnMG9IcGUvWlJkL093Y2pTekQySmxxU1lrRGZpSzBtc1VWckVEM21OaS9L?=
 =?utf-8?B?OHA5aUxzb1ZidzhhbGVWbnpTUTJCa2xYN1VZbnBQblYvSE9xUUcyRkxDTWx4?=
 =?utf-8?B?UllqUDlZbTNvMlBhNzVQY3F6aHJsd1JYZzNMdm5GN3FZUWFOck9CWEZWdUJx?=
 =?utf-8?B?VVBUYi81dndReVhmMTZmdEoxUGZUaHVaZy9KeWErNThuMVN4OW5kRS9EV2ZG?=
 =?utf-8?B?ZGFJYktpcExQQ2NuZEhzSXlvYTVMV1lha3ZjdmNVcTQ5dzJETTBNKzRyblRw?=
 =?utf-8?B?Z0pXekkwenZuK3R2OVQ4U29YNjRuTytJdjBGYWxENzR6a0hMRVczbDVFbzl4?=
 =?utf-8?B?ZFNUMXlvZ1ZoWlRya2hqWTg3TXZFNXVlL0U2eS9YUXF3bFRiSHZIK1ArRXQz?=
 =?utf-8?B?OGVFVXZaNjRvM2lDZWF4bElaQmRQM0hhVlBBeEx4ZlNkRTNBLzhudDNqSnI1?=
 =?utf-8?B?dEx0V2Y5ZFdFOEFwaWFLOFcybFkrNjhYNzhZVHNjYzZOYXdpcXRPV2hpcVJl?=
 =?utf-8?B?M3FhSkFVbzU5Z2FPOUFPVHJsR3QrZ240dmFqdEZOeHovWm5zakpZaUtmWTVI?=
 =?utf-8?B?VUhoY2p4TXcxZUY2YnFLUThOQW5KazBiQ2RMSjZ0R2JRejRRR1JDdjFqaXo2?=
 =?utf-8?B?cDEyV0w2M20wb3laeDdQdzdRb3V5U2JUUmFEUlRXSnJ1VytTQ3BlRjZXTFAz?=
 =?utf-8?B?VVkvejkvRlo0WXZ4SnNkT1h1RFdzUU0wQ3hEYlR3eUZpVzNKUnFkQVNGRnR6?=
 =?utf-8?B?SllHQWk1MjBEUTF6VWd0SGZXb01kdGsyTVBzOFkvbDVaaUs0a1NIelZaU3F5?=
 =?utf-8?B?dU5qQm92cFljcnlrVUNWOUJEUzA4cEJOc3JsZGU5dm5lQ0RIODIrc3RPRDJ6?=
 =?utf-8?B?OFJheU9LUStuUXBhcFQ0YzBmTkVRLys1bytqL0xVbUZNWmhUQU9FL3dyTmtQ?=
 =?utf-8?B?SkJmZlNzVjAzZHIwSWdQUEM5cDZGNFFrSERHeG43c05rSUNuazhVVERwWklE?=
 =?utf-8?B?cW81eHFTd2U0NHkwNUE4dEpMQkg0RE4zSmg3bGovcUJJTXBlNTNlQW9Qc25H?=
 =?utf-8?B?c2RZczVQdVhkKzBEM2VrUDhYcHJiZzg1Y0J2VkdtcldQOE1NSDVnbGlPM1NB?=
 =?utf-8?B?d3lTZzRDWjJ4TkVhSnJVTWE4cmNwY2lKQm40YzR6OTJ6cjM2MFdVU3dGTVBT?=
 =?utf-8?Q?WAMgQA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anE3WkIwREpSeElLbHU5dGhLUEk0L1BJY2dyOVhaV3kyMjdJaVZzVk5NN3Vw?=
 =?utf-8?B?TlU1Q1FVdzVKck4wR0c5dWk1Z0JRbDE4QW14RjhVbDU3VUFQN3FtekVodTh2?=
 =?utf-8?B?MUJrbElFZEh2TzlPdXFaTlBJaUpza0F4MWw0aHRVZy9qVzV0a0l1blB4bkdL?=
 =?utf-8?B?YTJzV0RMUlh6T3pSVmVKbG5yTjBYUWlLQTkvU3p5RlNlVS9xU09mTTZTZVND?=
 =?utf-8?B?MHJiR3A5RTUxWHBEYjhkQTZEdkVnOXJVMGNEU1pubWNjUlJVN1ErMStKajNH?=
 =?utf-8?B?U2R3TjhPZFFFUk9DYWhaMG04bTVkdlZEdXM0dy9jeWlOSEpCa05ZYThMQnp5?=
 =?utf-8?B?N0RzYUttMUhNWE80Z25vZUptWURBQk5qd2JEY2tkNTRtZEp0TjliU2dpeklk?=
 =?utf-8?B?VzhrdEhTSW4rc21NMWgvT2JjbDl5YVp0N3Zua1gvZnh0emhxeHZjNXlTRkN3?=
 =?utf-8?B?MmtUQW9BK1dyZ205c2FzQzVVZ1J1Y3VBUjNDS04vdWFFRkZwOGFVcFJ2ODQw?=
 =?utf-8?B?emxwZmJBSWFhb3k5Ti8vM0FrWE5QT3A0QUMzNUMwTDJySzRGQ0xlc3N2Tkwz?=
 =?utf-8?B?TEpNMGoxV0FDcUkrZUx5a0ZRYUVzNEVHM1VBTHVIYUhMR3g4OXZhaVhCT0F6?=
 =?utf-8?B?d3A3cjVHcTJ6RHZnU2sxbmliK3dCRElpc0NUcm91U1RMcjE2UUpocmlsTVox?=
 =?utf-8?B?UU1OWVczd0hhZWNlTEFpSC9QLzMxRmtFaFZkS3pSNFozd1BDdG1hdnRTRlls?=
 =?utf-8?B?WURJVXdEUjFzUTNlMXVybHVubm1vQ0t6VEI3MDVsbEpDSUgyY3NSUVdLNk5i?=
 =?utf-8?B?TU5HZ1ZsSHlzWmFkeTFPODBscHR3NUZnUjF4N2NQZU13Si80THVjZ1d2dlR2?=
 =?utf-8?B?eXdYMFRFRi9yQ1loQTNLbnZSVW5QQzBvWVhJMmRSMnBPWEc5WDdzSGVidGY3?=
 =?utf-8?B?VjV0SEV4NDE2QU1Xc1hCd21GU0ZHNTlTbDBRbDZuKzFyVTc2YndMY29JOW1Q?=
 =?utf-8?B?ZlZyVVp6VFdBL1RjZU9IN1p6ekt1c1hDK0UyNGRCeVNaQ2lYKzFjSjFmU0Nq?=
 =?utf-8?B?U3pEcWhQbHJ5VW9jbm42bVBMRDhtZ052YzhiMjA5MHFLVlh2cE1HWHdENmZZ?=
 =?utf-8?B?UVhUZVFBb0JsVUw2cHA3NjE3SEdGWFl6QThSMzNjazl0RnFhOWM5SXlrejFl?=
 =?utf-8?B?N1dkL0xadEFFZHRjN2FTNUZLVVFZNDFYYy9Galh1TEQ0bnZLSkc3YUtQK2tI?=
 =?utf-8?B?K01pR094blBGdm9IN1JCQzc1ZytPeGwrQldKaDI5UHNJMUhJRnFGMnN2T2J6?=
 =?utf-8?B?SjBwcy80bVJjb0RoUlBmbHdzQmtobW0vMjlOTHVhT3FNZVFHdDIrSkZFWks0?=
 =?utf-8?B?UjRCaUJ0Yk8vWFp6QkxZWHBtSFhiQUZNcVQ3cFp2Nnd3Qm1PemF5eVd1V3BX?=
 =?utf-8?B?OGRwRWtYbjQ4ZmpoZnI1WVNVektNM1d6NU01WktUMDRpWmxaNlRuSDJtS1J4?=
 =?utf-8?B?Uk5tRXFncXpZcGcrT0NYZHhYOGZHZ0tOdHdQS2k2UFhhYVB3R2N4ZXlDV1BQ?=
 =?utf-8?B?d1ZNN0hjbDQ4VFQ3K0U2R1RLNWd6UytFL1BCSGtrU0pING1qSWI1dXBvWGVH?=
 =?utf-8?B?NjIvQVJGSk42clhCejBFbzA2dkVuMDhTSlhTaUs3TFh1TUpzWHZXOFR4enhR?=
 =?utf-8?B?L2w2dEZhekZnek1Vb0pXSU11b2RQdXdIQmY0MDJpUXgreXdPRXBjalJESHhB?=
 =?utf-8?B?NVpEU21NZStndllTZzJNSmJpSnV6bWJFdHFYb3FVanlSb2tMbVViS3BOMzlp?=
 =?utf-8?B?Ly8wRmMrNUdCc2xDemh6emkyV0tnL3hZY3Zta1FjZ2RpTnFYNy8xYWpkVGd5?=
 =?utf-8?B?WWdwVjJVZWc4ODlXdHhIVzA3dEIyMVMvM2pFdVBsK1ltVVozcTQxZHdUbUZz?=
 =?utf-8?B?OGNLTFVvWWx3dkNBUThiaTZyY1FVWWdlYm5BenJFWXdtb1VTQitPcThnSTdy?=
 =?utf-8?B?RDJIZ1lrWFh6K3RySmk0OXJTd0tzSzZtV2hOUmNneHlvVW1HN2Q1VW1jb01o?=
 =?utf-8?B?R3VKalFjQ200UlBiUTNDN0ZKOXA5Y3FmNnE1bUZFRHRQS2V0KzBYcVVub3FL?=
 =?utf-8?B?RTNMQzIzd3BWUHRTbHF1cW1oNzhQcGVmRmprL204SER4ZzNLUG1UTno2V21s?=
 =?utf-8?Q?WCtbiPtP2TxpMiOQE6EB6P1esPv2j60cpSJMQ4oBPGdT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5E811AD830626499FD790D16B1B62F6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af2c01e6-7b91-40c4-9068-08de10304f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:28:00.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgspUaxabk+YOcwtBztISKovOHR5/q/BQVxhtLLl24Q3y9XHVBi7VDDToAvEzvB/M+L5Za/iTvyPFdEoUGQsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

T24gMTAvMjAvMjUgMTM6NDcsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gRGVzcGl0ZSBpdHMgbmFtZSwgdGhlIGJsb2NrIGxh
eWVyIGlzIGZpbmUgd2l0aCBzZWdtZW50cyBzbWFsbGVyIHRoYXQgdGhlDQo+ICJtaW5fc2VnbWVu
dF9zaXplIiBsaW1pdC4gVGhlIHZhbHVlIGlzIGFuIG9wdGltaXphdGlvbiBsaW1pdCBpbmRpY2F0
aW5nDQo+IHRoZSBsYXJnZXN0IHNlZ21lbnQgdGhhdCBjYW4gYmUgdXNlZCB3aXRob3V0IGNvbnNp
ZGVyaW5nIGJvdW5kYXJ5DQo+IGxpbWl0cy4gU21hbGxlciBzZWdtZW50cyBjYW4gdGFrZSBhIGZh
c3QgcGF0aCwgc28gZ2l2ZSBpdCBhIG5hbWUgdGhhdA0KPiByZWZsZWN0cyB0aGF0OiBtYXhfZmFz
dF9zZWdtZW50X3NpemUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBr
ZXJuZWwub3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
