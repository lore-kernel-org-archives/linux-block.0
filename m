Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03445821A
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770875; cv=fail; b=nAK26E+NAfGQQfc8xX3k3mpPIBbL88vmn3mqntyiAihbUiQ2ZY8b1xi7HiwPIwvPeIxa/xk4gc5HgrsdGGl+ILKEzuFRJddTXLPwVmwTzW2CYYcTYoqFgL3BNnGveWfCTW38fgyvwu9FT8dExDgzEeLwVJJN/iS9bz8m7VCtS7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770875; c=relaxed/simple;
	bh=jZgvGQnSLjoIqwFtX2VjKB6685C3uZfY/EczdmxUTqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lu0btRHlnKpZVjgUZ0Z6mnX6CGR3PdQbBembbTMfuSwl/DxAgviQACM06fMGP6daMEh0TzcXJ/FJlR4u9EJSoKzBv9kiwSDyeQkcuiNzobUxasZuZ8I6o/4aBNiGGX/JAPwl0eYFrrOdvYO7v2gSolCI1qE2302ou57/Nm1TwQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFmyb30l; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFmyb30l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cer69JyslKtaWoGLEFY+ljYmRsEehvvAtVaqT3qU8E8pKDwigGbKdvZSGMS0kOMPZ7DMTAFOQWXy1hZFwRcl0W94yARzDpk4Uslw9QFmzceC821FXd8cAzgLbAETHZLfxZ8ivH/gURygHNXBme0NOWdRrcwKpRmggL3iiTFZoGJOiGVyzV0d6B0zAeGvtwmCN5W2JPryQ6dyxqcBrnoD+93xMVoz74WeA2deI9joicHi1TZi1V7P+PLdCTs3EqQs0+MS4Dy27i9tQN+HsfOqU7iu22w6nLvZiOoYWxxyGmmIFuPXG6sUzA/UQ0diHTBP49RTtR+V+7qlnY9XhoL2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZgvGQnSLjoIqwFtX2VjKB6685C3uZfY/EczdmxUTqI=;
 b=mWyaMfUwQgtWk69PKmjtcfW6iDUgT/ZWTTo+1pxLDh+qvtRJnsL391sMEhvr2rfvGeMFpxbxisJRmVdjxMeQXlIbvymUoyTQlCWhBuj5zxKoCCyji+WuOsZRTMmmh0rojb67Q4FLg71LFl3pH7n+XbIZA5sGuGCFmK25VGWXW376/ZJNHkUOyH4NW6hlZvTCl0sDM/Y81Bk0DKFZt31TQfZzL9C9uufHVUiPUhsktsNs4twRO8Fta3/ODfPll+kmB/mxGdMumQWwuxMtsLdLuHjDVI13OROEkvwasbBNH0KAa3sF0F6NGkvMtAnuKgePRGuEsq6l8RbcJzXlTNXYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZgvGQnSLjoIqwFtX2VjKB6685C3uZfY/EczdmxUTqI=;
 b=jFmyb30lCG7Mz31ZVCKnxf8/tn/nrApcMB8craIiIPEPpQSxcAtAiMH8mLrhMM/mADQJWuinQr1mkOPtMkhstJih9xFu8juZYHZ1T3LPpxpw2tsaH8A9BfFalXU6yEMH5n8OWQeC5fxm6ot1t3/iJMTD/2bxhcRSmzMvl4a2EyFcmDZ4IrI0cE4pLUz1tnahVSsxF4RgD4RXhVpJMx9yCAHfsCTwUnnHv00jrKttW9Wuj40tU83xmz1kjlmUOFwrGEWNxxPkLv3RPPKiusDuCrP7hLXmEIICCtiqiVhHwsdFZcmabq22XZttwMeiRF2JfZEu0/Hw50DPtQWBvp7Lqw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Fri, 3 May
 2024 21:14:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 21:14:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Yi Zhang <yi.zhang@redhat.com>, Damien Le Moal
	<dlemoal@kernel.org>
CC: linux-block <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
Thread-Topic: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
Thread-Index:
 AQHalYC3FffdsqLz7E+2zSBCgF1fE7F/Wf6AgACBYoCAAIWOAIAAhjkAgARNlgCAACqKgIAACFIAgACrKoA=
Date: Fri, 3 May 2024 21:14:29 +0000
Message-ID: <87d1ac8a-df56-459d-a2f8-bcf940aa9e0b@nvidia.com>
References:
 <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com>
 <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
 <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
 <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me>
 <76c17ab2-b3a2-491c-a6b3-7bd39d6d5229@wdc.com>
 <1ceb71ce-c4fb-419a-8800-8ebbbe1706fe@grimberg.me>
In-Reply-To: <1ceb71ce-c4fb-419a-8800-8ebbbe1706fe@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8873:EE_
x-ms-office365-filtering-correlation-id: 14039ec2-493f-42cb-1f78-08dc6bb60579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjZ5MmdXY1V3dGN2eG9wbmFVek53QXNrdDZ3SHYxOGxmVFNxRkkvUmR5aUJh?=
 =?utf-8?B?bDkwYzNsMHZyNnFLWE0yMlQ0cy8wRmVyUm9Qb2tBNTR5OWlKK2xxZUV3RUV2?=
 =?utf-8?B?dGlLeXZJNUVXV3dDU2h6V3Btai9NRFc4bmE0ZU1obnFtZnZYcXlwM3k4SUxp?=
 =?utf-8?B?NFdsT0kzSU5rNVNMUWcwa1cyUGRPRVFmT0dlOTZKQ1dEb3R0NXR1aFV4VVd0?=
 =?utf-8?B?aTZ6ZURjemhkelhUYXdEK1A2TE5FdU1UdDhxMkNTbGMxWU1MSGFoejUwcXAx?=
 =?utf-8?B?OFdqR3RmSzk1Z0JMcENqcE1MUnBXdXMwZW9pVlpqWUM0OXQxS1QvYjJ2UmJO?=
 =?utf-8?B?L3ZFVEFabEM5eUMwYXdIMUxlUisvTlM2MGhITkQvWldtbFZpdzd0b0JnL1VR?=
 =?utf-8?B?Z1dhRWQ1WkhxOG9QVUNFdUkzWmxQS2gxWG8xb0EzbnFPOWY0dGI3YU9yaE1y?=
 =?utf-8?B?MUV2UmhmcHAySlYwMDdlUHFzekk5cXRueXo0czR2bVQ1UVdaU0ZIVDdDSVZL?=
 =?utf-8?B?b0RiSWdwZXB4MUUyUmtsaGlLVUlFanZ0dXJOODZLUlRpL282eTFiV1V5K2Q5?=
 =?utf-8?B?b1Y2cW13N0hoU2dkSXBhS2h6aVVFZE45SHJnSkoyTGtnc2l3R1k4N3VFMlU3?=
 =?utf-8?B?ZmZ6WmNPb3lhTWN5UzlqSGFjT0ZGY0xvWGloZVdYNnlzNUsvckw1eUpBd0ta?=
 =?utf-8?B?MWNzZ1Rsc01sSFBDK1l3TkJUOU5QNTI2MjZjdy96KzdzcWV6dU1WWWtFQWtY?=
 =?utf-8?B?MEtRK3JQa1k2cnd6YThxQUhaYUJQV3FseVJIVkFKcFl1VFdiQ0cwS3F3NjFu?=
 =?utf-8?B?ZjBpb2oxVVhhand2NmlqNWxqazRJYUpqdTl1TEl6Yk50b2NnQWdwY2xsM0E5?=
 =?utf-8?B?UkhvUTRkMmtFdkxnWG9ZdHlhdXJYbmI2SkpJMlVMQVFNK3o3L0tHNGE2Znlj?=
 =?utf-8?B?UXYzV3kvdnpwbENxOHRMZ0FoN3lmelNyU0ZXV2hpWUFwdW5GL0MzTk5CWXYx?=
 =?utf-8?B?WXk2b1I1RW9aWk5tdHRGL2g2OGE0ZFJOMGdhNlNiTjRIVk10VFVrQkd6UldJ?=
 =?utf-8?B?VkRNWEFaMkJidjNlSUVjTXF6TjV2Qm5oMUplc2wxb3lwYjNtUm5GRW9IeEkz?=
 =?utf-8?B?cExnNTg2clFFSWR3ZkJiZ1RBRWNxVnFWNE9JUlQ4enBITWV4UmR0ZERQalBt?=
 =?utf-8?B?eVFxMTdaYU9IMHhHS2p2Y25ENXlNcFRiYzljdDBJUC9IZndXNm9jbDlBN2N5?=
 =?utf-8?B?ZU1ZaXdUK2sydFFmWGpsVlA2QU52Szgrb3VmWDlkTktVMCtINTJndEZ6V0Zi?=
 =?utf-8?B?bE0yZ3pLeVZkSEhvWkZDZzVyNkdFc0Q3Um5abjBrc0RlQ0llRFY0MElXUHRX?=
 =?utf-8?B?Y01oTnhGMEFScHJrTE10K3BzcnFERnB3OW42THhUblc5QWlROGtNRkdBVVZ1?=
 =?utf-8?B?eTRyVWUwYVVDcHVDcnRycjVkS09PUmx1eFNRbFRFby9Ed3NzQjRsbkNXUHg2?=
 =?utf-8?B?UThrdjlWQVN1NXpuWStSTlZ5UVg5QTVLRlVIRW84Y3FVTUx0Q0tNaFZWRmhV?=
 =?utf-8?B?bERwSXBYSlkvcFNBc2g2Y1VFRGJrTVdsVU5WazE3QURuTDBvVjVsZksvem13?=
 =?utf-8?B?NjFHd0ZqSXE5WWJCQlB3ZHZIem95enpSQ2ZnMm1XdS9PT3FHcTlhMVRnT3l5?=
 =?utf-8?B?VGVjcEs1ZkduZmZsRHBlamUzdG14MVNja1didmc5S1BUbjNUQnlJVTVVNjB1?=
 =?utf-8?B?NXpFWE1BRVlrdXg3OXZ0Yll5QVl3ajN3TFlyTVVWck9zM1FDYm1oVHRlV05Q?=
 =?utf-8?B?ZUpnTTJpdDVFZ1o0dE1XQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUpHZFhVbS84QmFKaDU3U0tNRGZqQ29OblM5YzZoY3B0L2NWWlJLN0ZSSFNy?=
 =?utf-8?B?SWdBZzdVakRzY0w1UTN0ODJQRC8vMFFiT3VTamx1TVhoc1hVdm9OTzc2K3dZ?=
 =?utf-8?B?U3lXL2hDaGdiZG5FTG1tSEY2alVKaENJRzlySmZRNUpwNEdCN1lwbzBMcVNR?=
 =?utf-8?B?Sjk3M3dCZmIwaEd2VFMyOXl0UlRuelFob0wrK1hkbTJZTU0yTCt1REpVNGc4?=
 =?utf-8?B?a3ZsamFCalhvNU9pUXJpNDVMQlpkN2Z3ZXJHdlJNRUYxSmcwVXJlY0J3OEUw?=
 =?utf-8?B?UTBUeE94RjVseHNsSEdNME5XRnJjZEJZUjRJdmg1ZlhBV0U0UUgvWnNBTThy?=
 =?utf-8?B?RVdNcktCejcweHVjVHN1S1RyREQrd1ZEOWMyN2RDbXNaWlVHQ1ltUVZRS2Jv?=
 =?utf-8?B?cXhpMkM4dXNIbWE1Z3NlWDBPZVFaS2dJT0RMbnorWVhlT0F5am5CNVJXZlZS?=
 =?utf-8?B?ZUNZOXNYVjJvcjVCdzQvTnA0OThNNEFRWkp2RmVOK2RCbDV3Q0M0VFF4Z1lo?=
 =?utf-8?B?VVFuREFRZGpPeDZTZjlWOTFWaTdRL3YyTzFTZkZFNFg0NGFxMS9KaWVoWFZa?=
 =?utf-8?B?RkVmRCsyWTdHenV4MlU0bmFLZnZLQkpHaWQzRjJubEliS2t3KzhDNDJPSkI2?=
 =?utf-8?B?TEZvcmpFTXIrcDRJaG9HL3dRd0hQaVdwVHFOdW95M1pvbk00eitFTFpOL3M2?=
 =?utf-8?B?cnloYzVUcHRVZEhzS0txZi9pMk5CTHkwU1NBWnh6UUErekxZY0FZaEVjZS93?=
 =?utf-8?B?WVk2Y2NqcmNsWFJwY2RQMUtDdUc3eklxb0I2dzJORlM2cWpNYXpKMEZVSU9Y?=
 =?utf-8?B?amtVVGF0WE5UeDNwbjVWQ0M3MUJnL2YyNnV5eUxIN2dqZlVtbkhsUmtqdEVE?=
 =?utf-8?B?Nmd1cWk3SHJXS3YrdkdjVU1KSDc0WUVUdnMyU3gxckZWR0gycUh5L2ZQaW9r?=
 =?utf-8?B?SEtSaXF4ODV6ejd6TExqb3pVTlBqQnhFWWhEdEVpR0NVc05uSXlFL3Y1eVdv?=
 =?utf-8?B?MGJWc1krTDlzelEvMzhRd3RrVkFOallCWk10R05DZlRucEpxRHNUK0ZJeEw5?=
 =?utf-8?B?NDd5ZlNxaXRFeEdWcDdsRFJudi9EVXpWMGpsSEJqZU9SNU5HVTMyRnBMMnJo?=
 =?utf-8?B?WTl1TysvZVIvNytFaElka1MrZW5QbU9GUW16V3ZZVlRnZis0NlpoOXZhVnMz?=
 =?utf-8?B?Qkg0MnJ5VUF4bDNGaEFEWEo2M3NvNTVJcjA4eXRWT1JLbjdOUmtPTzFmeE05?=
 =?utf-8?B?S0NOSUU0b1RYUHFpdWtZaDFqUmpNUXBRNmZjQWZiYVBxZ2ZzcEdSbmk2am9t?=
 =?utf-8?B?Ni9lMDczSFl2eXp6R21CUVRvWnNEb1RvVVVONnhNWnMrdXdxTXl3SEZ5ODJO?=
 =?utf-8?B?Vndsa3IycDlqUUNEM2VqZTFteDZyZmVMajlJZGU5aXRJTWZjZG50WVhCTGJn?=
 =?utf-8?B?d3J1aXRRMkw5WXoxaXQ5YzNpU3B3aThkbGh6YXFqdnBDcFJoSzBHN2JBUXFJ?=
 =?utf-8?B?ZVp4RSt4Vk40QSt2OSszdURiakJqV2loNURNRjBKRDA5blpsMElqVEdGbHBh?=
 =?utf-8?B?ZGpJZW5PSElOVGEyMVpnZCtTQ0wrZ2hUY1pvUk1MRldzb2Y4SjdIWG5WV01r?=
 =?utf-8?B?RXRRbCs4Q3BXbEgwRGJzNUkyeWlqRXhsZzk2V1lHMmt5cis0a2xndFVlZVFQ?=
 =?utf-8?B?bUkzbmFUVnBWeHBJMXJaTS9nVXlneTZuWS9mbFBBb1ZwNkZ1M1VrMXpxcUMr?=
 =?utf-8?B?VnJ4S2ZQMHM0eHp3RWJpSHVQQUE1cmZlTE9tcG82NGlzckQ5OUR5a09IeWNK?=
 =?utf-8?B?VHNpTXdoQ3Q5QkJ3OGRXZkxEUXdZc2crVGVwc0RIY2RXWFNmckcxeDRKMHFj?=
 =?utf-8?B?UVhtWGd3MktJaEl2bzBIbWhJMEVUMzNyc2h3aW8rbFlMQ1BieFYybGZGcmRu?=
 =?utf-8?B?RjUwa29BQ3ErNm1WZzhZSU0xaDBkZUZuRmt6c0VDTnN4di9GTU9LUlFIQ2FE?=
 =?utf-8?B?VDAwc1I3VjVpb2pPQkRNejZ3WGFxalQyQ3RwSDVRN2MzeTlhRitaRklNZ1pG?=
 =?utf-8?B?WEdnZ09vVHg4bXZFKytRNHBTS205L1kra1FaaHZJV3gvbUVyRFlqbC9OSTJM?=
 =?utf-8?B?MFZvTThyaFRBTUpvTTZEMHNYNVB4bXdrL0FCdFR3NTNJVE54ZjhmN3IvYjdD?=
 =?utf-8?Q?s/PzpNCYWk5JX0UsEroVT4d4Kjry4J1ZowPp/eLYOFd7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54AB9162B58D19458EA340235D51D51D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14039ec2-493f-42cb-1f78-08dc6bb60579
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 21:14:29.9335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAiitXLm4FYikkkkTtNiR8tkkryTi6oB6lJ9cft9G73cowKryoK0s4B5e7BPZDpeEPGu3GyRD8v343wtLWye4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

DQo+PiBUaGlzIGlzIHNvbWV0aGluZyBEYW1pZW4gYWRkZWQgdG8gaGlzIHBhdGNoIHNlcmllcy4g
SSBqdXN0IHdvbmRlciwgd2h5IEkNCj4+IGNvdWxkbid0IHJlcHJvZHVjZSB0aGUgZmFpbHVyZSwg
ZXZlbiB3aXRoIG52bWUtbXBhdGggZW5hYmxlZC4gSSB0cmllZA0KPj4gYm90aCBudm1lLXRjcCBh
cyB3ZWxsIGFzIG52bWUtbG9vcCB3aXRob3V0IGFueSBwcm9ibGVtcy4NCj4gDQo+IE5vdCBleGFj
dGx5IHN1cmUuDQo+IA0KPiAgRnJvbSB3aGF0IEkgc2VlIGJsa19mbHVzaF9jb21wbGV0ZV9zZXEo
KSB3aWxsIG9ubHkgY2FsbCANCj4gYmxrX2ZsdXNoX3Jlc3RvcmVfcmVxdWVzdCgpIGFuZA0KPiBw
YW5pYyBpcyBmb3IgZXJyb3IgIT0gMC4gQW5kIGlmIHRoYXQgaXMgdGhlIGNhc2UsIGFueSByZXF1
ZXN0IHdpdGggaXRzIA0KPiBiaW9zIHN0b2xlbiBtdXN0IHBhbmljLg0KPiANCj4gSG93ZXZlciwg
bnZtZS1tcGF0aCBhbHdheXMgZW5kcyBhIHN0b2xlbiByZXF1ZXN0IHdpdGggZXJyb3IgPSAwLg0K
PiANCj4gU2VlbXMgdGhhdCB0aGVyZSBpcyBjb2RlIHRoYXQgbWF5IG92ZXJyaWRlIHRoZSByZXF1
ZXN0IGVycm9yIHN0YXR1cyBpbiANCj4gZmx1c2hfZW5kX2lvKCkgYnV0IEkgY2Fubm90DQo+IHNl
ZSBpdCBpbiB0aGUgdHJhY2UuLi4NCg0KDQpJIGNvbmZpcm0gdGhhdCBhZnRlciBzZXZlcmFsIHRy
aWVzIEkgY2Fubm90IHJlcHJvZHVjZWQgaXQgZWl0aGVyIHdpdGgNCmFuZCB3aXRob3V0IG11bHRp
LXBhdGhpbmcsIGJsa3Rlc3RzIGlzIHBhc3Npbmcgd2l0aG91dCBhbnkgZXJyb3JzIGZvcg0KYm90
aCBudm1lLWxvb3AgYW5kIG52bWUtdGNwIC4uLi4NCg0KLWNrDQoNCg0K
