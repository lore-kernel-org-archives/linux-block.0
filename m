Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D92285CA9
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261841; cv=fail; b=SSypsIgSi8x3Pb+dC1UXe7YaYwvBVt+QPpaKn0d7NO/UcTODlqn5M/TuyK/9IlJU77CCfDn5bHJmsstGsJHjK46keikkDG9mp4noJzR/Id4NeTnnB8L3OSTEEa4ZvniXuuz+qJYqpJVtoLteRjfrBZeDG7g0OelUQpt6OjOgSko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261841; c=relaxed/simple;
	bh=UQqipQVZOPU3EVupUeQ5OG69f3033N/t6eK3vtEiSn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nifwBQXpmiCe8aKyRcaleXZ45YVlu92v4T+yCTKOdYl4wA+iruMMvHCAkaNrDMNWQRM0lVA9Xbs2H2Euen4QrfwyMfvEYB22bSsAOnSVSotx+UHi9r3FfbEAFDg9I8OKNUonoAUs5vDc1qrC3I8S8QWqq7j/BCL783eW/jXSuDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBEgX0ak; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBEgX0ak"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C22c1oEn1ibj5cr/zZnSP6lRxeKmE8qin7RgeTko0hqncmYB+YFQJCnzsZ6EA4VXAaNBUtWWkpKo2lAuZ8BG0q9OGAcrHPflBv/sJakqjuwlUd7UAJUk2oo22np8SSn/fKGKToClDMWmPGKnOWvUDXo6oZyWgbNt34USB3JDGba6g7h7B3nqUSIkgcC3RCGFu8YWXuhOH55pz8EMNyJurATJbi74aJyjNwbsnhjuzIMx/6hmaqTv7D4KKb9k4sv1BdBrAM9qKMDcKEAssFqr6e0QYHWwDREy9MOqh4o+YW/L2gK47G/7juep7zCMNqmJ3ia9WQ8uufvax/SdHVXZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQqipQVZOPU3EVupUeQ5OG69f3033N/t6eK3vtEiSn0=;
 b=NVUJ+ePOXKbUxYUVxjhR5cytndnPCWLVVLi/80t2YdnRNVZEgwLeu83yKPstCmT3QxMgMF8Uo4NcKH0glUdk2IN1gT8CKziIH677EkFPNiTF5Yn5HOPugsqJm2kv8qV+mg4/o6coQuqgtUHynea18jcIhmD5bCWGJU8rZ41A+fa4NjIFW39S6ZHH1eZ8ovIyyCNs04DVSIUtMlaDVwUsx815t1L0cGAhzCNawUe3DypRM+RriXNJByaW8sv5UwGkcQVwPIS2GWm5866E7EeHLo+hqt2h55bQJB811ycd2+jkw4HzIBkaZgMyUbiUPDWjb2kdKPxQ+mR3TOFAmg4eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQqipQVZOPU3EVupUeQ5OG69f3033N/t6eK3vtEiSn0=;
 b=jBEgX0aksHDKxmyZUt51agStjbGpFAOKVpxH+jLvKDBxlbuyXQypXSahjgUYYaeDrA4ecz9SI3XP4sWsmqnSLqV5aowv7twRwDmKo3DvI7/gWpFxxACTUJeq5t4cINOo/WVFpaQwb5Pd3hn6DI302uRNn0lbigYg+oUfijnMcPKRrIwwiqYjG+VozKkwawWr1OIdo7xYPAZrGRYsmVZj9GsT/o0kvDq273hbdBQcsU+BJd3w4I3Sh0WY4U/popZrWeRY/ZyJKKsVdhjW/qwe4Aw+BY91Qk9ItnDeis3aq4OOUemKwqjkeAy0xlfXe3CjLUhGvWlwriObgEnDSgCLHw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 23:50:34 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 23:50:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCH] null_blk: fix kmemleak by releasing references to fault
 configfs items
Thread-Topic: [PATCH] null_blk: fix kmemleak by releasing references to fault
 configfs items
Thread-Index: AQHcg+q8T8DeMLzkG0u4S90Kg5SaxrVPNKWA
Date: Mon, 12 Jan 2026 23:50:33 +0000
Message-ID: <5977721b-aa6a-446a-bab8-dcb458e592d4@nvidia.com>
References: <20260112174003.1724320-1-nilay@linux.ibm.com>
In-Reply-To: <20260112174003.1724320-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7148:EE_
x-ms-office365-filtering-correlation-id: c941cbea-37a5-46b4-6a74-08de5235608a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eG5pbnI3L2lrRlpGUEZCVkRkekxZVzVaMFkrdXB3cmhHOXNOUWpxWDZjdWNa?=
 =?utf-8?B?STFwbWJhdmRRQXBZMXVUdUM3UEZxL3ltYklQU3h3WDR0YXBZSERxaTZLUUQz?=
 =?utf-8?B?bHFKRS9LU1AvSU16aGEzZ01zOUQwckNGZ3VWOW4xNVRQT3Z6ZjZ1aXVXSUd6?=
 =?utf-8?B?MFowNEtyUkhJV202QTR3SUtibm40ejNKaE1qRXBkY1JBTjdBNktJU0RhbW41?=
 =?utf-8?B?YWZseEdPRXZOTU5uand4cVhZUlRoNEo2cmlHUEZBOUxXSkJoUEtONEhsaEJB?=
 =?utf-8?B?WEpMRHhudmswUUtkc0JHWFZzdnZiT29xc3JqT0t0bWF3bnI3SmhsUnAxZVdV?=
 =?utf-8?B?elAvUUtwZkUrRklHczdReUhMMTVnL0sremhneW5RMjR4TTl5R1BGTWFMU1Jz?=
 =?utf-8?B?UENMZko2cXRGdGFKMm9QMzhaYXlHRDlndVlyYUlES1cwY2ZQbnV0bW5SbHNR?=
 =?utf-8?B?WVhva25qK0l1U2dYZUxyN2xEczhQM01UdU5hNXJUQmtiWHdQeDdJSTJZd1FJ?=
 =?utf-8?B?U0IrVkx6MllaVDU5RUx0S1ZVV2VMQTVnb0I0Z0E4a1N4TEJSNUxSUFdwMk94?=
 =?utf-8?B?TkJPM2xIU2tOekxvMmkxWUJ1NktCRUllbWVjQU5tTk1STnJuY05OT0I5V21C?=
 =?utf-8?B?enpoZVJRK3ZxUGpOR2JnaUJweEpmeElvZnphMzU5aDZQVkc4ODVPL1R0eFF3?=
 =?utf-8?B?TTFIU1RwRUIwNk1YTUI5UG5JcVFFWEh1K3BIdUozSzFlNGlxME96cnNoYUVt?=
 =?utf-8?B?SG5XNHJVSnR6V2Y3N0hJdkxubmM4YkNNVktlaEV0NUZLNWl0emZmcnFKaG9R?=
 =?utf-8?B?WnlGS2I2OWxiWGtKWlRHV1FxQjYvd1QrbjBFVU1lYkxXZEUzRHAxR2xpUnM2?=
 =?utf-8?B?Wmt6ZmJFVCtzMERsRThISUFDMm1Kb09Rb0ZtQmszbWxqUzFmTTdhZml6WVd1?=
 =?utf-8?B?TDVBZisxdjYrOGVXUFVmK09pK2RhcjY0eS9iRGZ5bkVtRW52ZWg0QVhlREhT?=
 =?utf-8?B?Rnp5bFRjakRFT2hVQmRaUUlyQjJZWm0xL3ZQYXlBdmFSdlNaYXpKdDNqbEk0?=
 =?utf-8?B?VWtRWjFyUTR5ZmRPckVyUEE0eTQ2alNiMTRYRmxqZHA4K1A4RDZtWjRleGI5?=
 =?utf-8?B?RGc3NXZzWE5XNko2aCtkbGV2b0xrSncwcEIrREswOEcyMjV0Y2M4bTYwZWZT?=
 =?utf-8?B?eFkrVTNrd3Y5OGtRYUZWbmp1SEM0VER1dUVIcEhrTG9NM1N6RlhSMXZkMlZQ?=
 =?utf-8?B?OStwbkJvN1FXV2dXTVlYQnBTK3c2OXJrUnNXbXZrckhHL2t0emNHZVdva3Rw?=
 =?utf-8?B?YmxmZ3kwaFFXR0NCOUZDZDRUK1BoRm1NL0daZ0FVOUxGenZEMmV2M0FiRkkr?=
 =?utf-8?B?T1dMOHlYMUxPd2J2dWxyc1pQV2Z6eUhoSlJvN3BWOCtLSVQvK3VnSGlVQXlJ?=
 =?utf-8?B?MHl0T0R6Z0FjWnVsKzNEWmZoN1YwK3pVTGR6YjN1WVVaRnlVSm0xazcrVDFE?=
 =?utf-8?B?dU5BaXVnUVVRNkM4QTRZT1djeWxjUVpOVWtkUGU1eEVWU2swWUpFY0I5Tmlu?=
 =?utf-8?B?OUNuUzJySTc0cjB0YXBESi9PdHdEQ0ZHbnpuM1g4VzdMMms0Z0FFdTBPN0dy?=
 =?utf-8?B?K25FaG5DMFo2NGpzMG5Fa0RCaXpoK1ROWnhWaFMwTHJ0OEptM2EvNkRhOG1a?=
 =?utf-8?B?QitpWW4xaUU4ejhEa3lqaWtvZ21ZbEdockFtcklHV3BIakRmT3FRWVJqNmlY?=
 =?utf-8?B?QXBDV2M4MHJmbFUvVXlBZzQrdHY4T1V3TEo2VkRsbVg3L1ZqVzVUVFh5cUdU?=
 =?utf-8?B?aVFyOHFSMmxRR25tbWY1WnhhTEx4N0JuYTAxSnNTZUMvaUxnVjBLRnlyRTM2?=
 =?utf-8?B?TWs1RHl4RDRmOGtGUTV5MFJuSis1bTRaZ2V4aUpwQXpIcmtKTnhlWEpUY25B?=
 =?utf-8?B?WVZ4VVNVUFZGMCtKZHU0VitlU0dQbG5rRnVwTUY0YittVXlMeTd3Q3U1eE85?=
 =?utf-8?B?dEhOZDdNZnRHZkdYM2xXUEgyTnVJN2pnSE5BNmRPR2hYelExcmpZQ3MwR200?=
 =?utf-8?Q?4TLRIu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW1oQ2lZZ0ZmZ25iTVNvQjQ3MmlpWTloMWF6elFIR0FEQTI3c09KcXRsbGxW?=
 =?utf-8?B?Nko4S0xzMk41VGRvTUZmZmRObElyazhENkJJbVd5UTBLTlNhRWNWWW1idlp4?=
 =?utf-8?B?c3lQNm5ZNEpEVnJGUWc3S3JpVCtUWHV1TE94dWVRV1RNdWxzemwraVVyZ2Vh?=
 =?utf-8?B?U2tJZ1dhT2E2V2FJQTBlczdhdG5iRVNhMldvemJuUHZCeTZ0T0x6NEJ0YVg4?=
 =?utf-8?B?WGNqQk1TOXhwRFdGb1B4d0M4UFl1cVJUN1ZlaDNTeWkxMVBXZ0tYSDFSQnlO?=
 =?utf-8?B?TUpubldsVTg4S1psQnZMY0xrZDBkSmlTNlJ6TTBzUkpUb1R6S1IxK3pWcEJK?=
 =?utf-8?B?aytCMmwvMTd0VkYxNzR1U0E1dFBYZzJVWHdIbVdNSVFyRmNhb2FyazlaQnhX?=
 =?utf-8?B?NDhBTWZUZlp2SHlPb2tzT3VXQTZVTHdxMUY4Ynpkd3FMMEVtS1pBQ0dWZ1Vi?=
 =?utf-8?B?WWlKci93TGtzVFVPNk5HNUh3OG9HNG1iMEp3WHlKZC9vUm9hWmk4b3hwNUVz?=
 =?utf-8?B?Mmkzb2ZpYzhrRytwQmdCVUR3TDIwbzdqL2h4ZHBTZU81V0t1dnlEaHppSGZn?=
 =?utf-8?B?WTdXakt0ZmZKeHNqWVRKK2t3dk8rYndKUUNXZzZtV1JuYzNqT2FvdU1MMzli?=
 =?utf-8?B?TThxQlVEV3JMOTV5R0hiVmhTWUFRZjF6eWtIQjExbUs3NmFYbVdjRU1idHFz?=
 =?utf-8?B?RHZUVDBJcUVKdjNCc3k4TktNYkNRZFdqeVNFcWh1SlVDZHlBZ3QxNkJUQkJL?=
 =?utf-8?B?ajQ0eUJEWG8zdDN4RnBTR2RiMUtZOWVuVEJkV21YWG9SZmFxb2ZGMEtmdEJR?=
 =?utf-8?B?ME9nWGdpbTdkbHArdGlYaHVRMm15SHhMcVoyeC9hbkxaaEdUZVNVVno0UlRk?=
 =?utf-8?B?d01PZWRZSlRWUmFnNXZaa1FuTnZzOUdvVXNnbVVkMGZLSUVHR2hTZ01WbC9L?=
 =?utf-8?B?d2hYQ2w2aWt6UEJ1L3JBdkk5NVA2Sm9qbDJ2N1ZwTks4QVZHcDJSSEkzT2tw?=
 =?utf-8?B?L3lqakMrVlB5TnF4SGNpQnpKbXZ5M216eGJ2ZWFLZFk0c245KzJkZGlNV3F4?=
 =?utf-8?B?c0phVTdyTW01eHZPdlZOd3FmeVh1ak9JZGttb29YZ2wvQUtZa0dEWHdBUml3?=
 =?utf-8?B?bmNVRDRHN0VIK1RWVFhWaHVSY3JMVjNEcTZxWndoUlZMWTBTT1lNditSWmhC?=
 =?utf-8?B?V2RhZVcrc0pBR3psN1VtZmFqbXV2d1BTa0dUSTltT2dqWVFyV1c5b1htWDFO?=
 =?utf-8?B?ZTZuQVRYbC8yeTMwMkNtdWQ5VGwzck5KZ1k1UGxidmNLSnBEd0VRaklYbjR4?=
 =?utf-8?B?RlI1d2dIbWpDK0daTHBRZlBBZ3JGcjlIdllpMlRhaGdIYXYrU0RaL0Q3R0kw?=
 =?utf-8?B?UTl0Z1BNZzljOVgxTEpNWTltTVFDV01IWEZLOHlFMHd3VXFDYVdGNDNxQmYr?=
 =?utf-8?B?Ly9iK000bThtNHgvTlFkbmdCcHZMbEEyTTZSTStSNHdrQURpWDhXNlRFSkRx?=
 =?utf-8?B?cGNhVHN1RDJ2SkZ1NS9zbTh2NHg2dWlYUlNENDNEc3p6NmwxMDNqSzAvRzZQ?=
 =?utf-8?B?OUVSbDk3aDBLT2s4N3k0bWZScjFUcGdyeTFZSkNVcXZVbkdIZktUc2FXdmpC?=
 =?utf-8?B?aTlZSk1UVlgvVXZkNUpRUDlhNk45b21KRnE1cnJXKzlwZGExNVRTZ2huR1hD?=
 =?utf-8?B?dWdqRkpIY0xTREYraFowSzdqK1h5R1VsRkMzaWhVdkl0TVNZZ1c0K2VuWElB?=
 =?utf-8?B?cmtncEl6NFNiT012ekhGWkU1dWh1Z2FydFd3VkxJZVdVYWk3dzROVWFOdE1q?=
 =?utf-8?B?QXNmRmc3dEJpYk1yTHA3eWtybmozZWVtNzRwelFtL3JBRTVVU2p1YW12N2RP?=
 =?utf-8?B?L1Y2ZUx0RW0xU2RzWEU3TzlDNnFpOUYyUitTNW9hRGlIdUZMWVNDR0NYaS9l?=
 =?utf-8?B?T2d1M0dDZzFaMllXVThRQzBlQ3pqUWU3QW5sSmR1azg0Q05pd0lPTEpRd3k5?=
 =?utf-8?B?SkVIRUdpM2lveHAvM0tqdmlBdFNSQTl4RDY3cWFsY1FERFVzWEZUVlpPODFl?=
 =?utf-8?B?elRsQnlJNXNHNHNQSEdMbm8rSW5MR0gxdU5HUGJPQTN1TXZaWVJLTnM1Y1Z6?=
 =?utf-8?B?NzZnNmRnMmQ5YUhsYWZsVUpFR29nUTVWaGdKRW9xb2tsMXM0bWZ2MVlaRnlF?=
 =?utf-8?B?ejRhaEZ0cmtEaTZLUkRLeVg0czdCYXQzOFVPM3hvNVJaZTBjcVhrZnBHZ2VR?=
 =?utf-8?B?YXdpcnVaTmxXazZzdHBHLzlwekhBSEZVMmlqcFNiaEw0OU9NS09hVUMvbHVF?=
 =?utf-8?B?bE9mS05kNzRzOEMrV244US9SYU9obWVJc3RnT25oSFUvU2EvMzB6NzZzNFNk?=
 =?utf-8?Q?npItYlK6bq2wk/G1DB/P3KRYN7l2ZR4OP0AoK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F5D8549A3F59E49BD0647AF498AD075@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c941cbea-37a5-46b4-6a74-08de5235608a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 23:50:33.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5IQIUzpkjSCuY4UrktizDPLgDZaZ0na4R7todt/XBOn/TP++rt1V6CmpWlffJZ1RdETYc64ArGiEZS4/vSofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148

T24gMS8xMi8yNiAwOTozOSwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBXaGVuIENPTkZJR19CTEtf
REVWX05VTExfQkxLX0ZBVUxUX0lOSkVDVElPTiBpcyBlbmFibGVkLCB0aGUgbnVsbC1ibGsNCj4g
ZHJpdmVyIHNldHMgdXAgZmF1bHQgaW5qZWN0aW9uIHN1cHBvcnQgYnkgY3JlYXRpbmcgdGhlIHRp
bWVvdXRfaW5qZWN0LA0KPiByZXF1ZXVlX2luamVjdCwgYW5kIGluaXRfaGN0eF9mYXVsdF9pbmpl
Y3QgY29uZmlnZnMgaXRlbXMgYXMgY2hpbGRyZW4NCj4gb2YgdGhlIHRvcC1sZXZlbCBudWxsYiBj
b25maWdmcyBncm91cC4NCj4NCj4gSG93ZXZlciwgd2hlbiB0aGUgbnVsbGIgZGV2aWNlIGlzIHJl
bW92ZWQsIHRoZSByZWZlcmVuY2VzIHRha2VuIHRvDQo+IHRoZXNlIGZhdWx0LWNvbmZpZyBjb25m
aWdmcyBpdGVtcyBhcmUgbm90IHJlbGVhc2VkLiBBcyBhIHJlc3VsdCwNCj4ga21lbWxlYWsgcmVw
b3J0cyBhIG1lbW9yeSBsZWFrLCBmb3IgZXhhbXBsZToNCj4NCj4gdW5yZWZlcmVuY2VkIG9iamVj
dCAweGMwMDAwMDAyMWZmMjVjNDAgKHNpemUgMzIpOg0KPiAgICBjb21tICJta2RpciIsIHBpZCAx
MDY2NSwgamlmZmllcyA0MzIyMTIxNTc4DQo+ICAgIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6
DQo+ICAgICAgNjkgNmUgNjkgNzQgNWYgNjggNjMgNzQgNzggNWYgNjYgNjEgNzUgNmMgNzQgNWYg
IGluaXRfaGN0eF9mYXVsdF8NCj4gICAgICA2OSA2ZSA2YSA2NSA2MyA3NCAwMCA4OCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAgaW5qZWN0Li4uLi4uLi4uLg0KPiAgICBiYWNrdHJhY2UgKGNyYyAx
YTAxOGM4Nik6DQo+ICAgICAgX19rbWFsbG9jX25vZGVfdHJhY2tfY2FsbGVyX25vcHJvZisweDQ5
NC8weGJkOA0KPiAgICAgIGt2YXNwcmludGYrMHg3NC8weGY0DQo+ICAgICAgY29uZmlnX2l0ZW1f
c2V0X25hbWUrMHhmMC8weDEwNA0KPiAgICAgIGNvbmZpZ19ncm91cF9pbml0X3R5cGVfbmFtZSsw
eDQ4LzB4ZmMNCj4gICAgICBmYXVsdF9jb25maWdfaW5pdCsweDQ4LzB4ZjANCj4gICAgICAweGMw
MDgwMDAwMTgwNTU5ZTQNCj4gICAgICBjb25maWdmc19ta2RpcisweDMwNC8weDgxNA0KPiAgICAg
IHZmc19ta2RpcisweDQ5Yy8weDYwNA0KPiAgICAgIGRvX21rZGlyYXQrMHgzMTQvMHgzZDANCj4g
ICAgICBzeXNfbWtkaXIrMHhhMC8weGQ4DQo+ICAgICAgc3lzdGVtX2NhbGxfZXhjZXB0aW9uKzB4
MWIwLzB4NGYwDQo+ICAgICAgc3lzdGVtX2NhbGxfdmVjdG9yZWRfY29tbW9uKzB4MTVjLzB4MmVj
DQo+DQo+IEZpeCB0aGlzIGJ5IGV4cGxpY2l0bHkgcmVsZWFzaW5nIHRoZSByZWZlcmVuY2VzIHRv
IHRoZSBmYXVsdC1jb25maWcNCj4gY29uZmlnZnMgaXRlbXMgd2hlbiBkcm9wcGluZyB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSB0b3AtbGV2ZWwgbnVsbGINCj4gY29uZmlnZnMgZ3JvdXAuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IE5pbGF5IFNocm9mZjxuaWxheUBsaW51eC5pYm0uY29tPg0KDQoNCndpdGgg
Zml4ZXMgdGFnIGFkZGVkIDotDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
