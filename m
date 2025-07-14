Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402E22F152
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532626; cv=fail; b=pXUKTKWUka3dTEKBwqwE0vbqzRl5Jwt3DIsXoGlj1Y4dZghE8dxYRcDhMCEFtAL9ZVlNuL5cmwOXv+0sHuZ1tN/wWS2pLbBRTIYL6HhpIc6nlUz+jYWoU3Uy+NCSC12AqEn3FC28kL1918ZEqE3dRK5zct/us1LA894G7ot3U94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532626; c=relaxed/simple;
	bh=StX4P1ec1tnG6m6U8lQbsl+UJzoAJAE6Y+W55rQ2528=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e80LuSTpVjb/DOafTqYYW9hx50vPDsh8WPF8HERIKZtyJMMyv8jGpVOMv9eb6EC7fqMRNvFsODKUmysJl0BlJ25Htg6Vi7KlwbNksmQXeoVI0dybNRiekLgjzoWlPWiix4DjFeyXmLrWsUp4igFYeUqos9ALJPTtIWM0VIaptbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNvl42Wa; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNvl42Wa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeiLRYSwDq2xnSUf9wlijsnil9A579yHM+1gMMiw/08CVZeDZqrz5cY/fISWm8A93f3kgCrAm1QOqhPU1rj0+NLNzQLR+3yDuq4wgN+qtmT9h1Ntr+gXl7Q1An/zyeVeEKjX6ryiGqY2zMo+ZHyqrhsz5QmBhaiQKBuPNq8a9LoXY4fCuKo+twuS2/uFPiutxK6q3Ai6M0tV+2gArBwknqFBemBs/PRJ/5KeaVau2zBm8D9h/36UZo2qyoBZ1qoFTOzv4rxvHkNP0baHLxMBI23WokOKXoUl48kIKouqmUz1GHL3u1P4rFVeG332/CK2WmIEsmQTJn/7LP9+xcaWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StX4P1ec1tnG6m6U8lQbsl+UJzoAJAE6Y+W55rQ2528=;
 b=afBLiCggGarLavfC/pZY9I7Sc3C5s53skFRCDHTLKUsAbnvqbZODmK6lnsdPRtsUXlTECD56Z433QReNMLZkkxZm8S6EbBjYbRwaCO/KCJ41KfRsQHbx+zZApIESVkexoW4ZtbQFzulCr5vTFgvWxnevr6KqJY3Uwd+Dm1nv3zAH+Qev3/Qsp8oSCIu3uohvgV3bv4HH39L9ph7kMlI+7x2Lokzty074fWUH/oAadlMIoFtENU6vuR6/tA0ky0WchIgktf6jkxmPzy3vmYqxpAjkNZDLM38RSYY3K72BpWTjqP+oAk8w2sFoTGO6JmXVmirpbbvnP10+E5U3hgxAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StX4P1ec1tnG6m6U8lQbsl+UJzoAJAE6Y+W55rQ2528=;
 b=iNvl42WacRiy+H65nCj7fL+PJAtLG/asow8+gU3G4M+fYpHbb9onyexbBC9+VpY7Ke/0B08xiwnOhSHM653+/ER+JpEVQxQAZhF+WT0gLmqAYZ08qALpCFTUsjADxiQH5vGv563Sl2hDMsOlvtg7kYcfKZ94eg329sUUKzQvSQ/1u1FK8ZSKPEjV719TMjpmzWIRgyCWuK+czii6WuFUcdQNI4OwRJJuYUqL1hxEFGktQbkpBJP4buH9D3T9T/+5MtOMgUbiwZhWnTGoFDSwAQuVCXVU9Z702llL41I5WSvbgeHCF69uWQKzkZnUS7fD56S0WNrBYvL+1aQgCZmLvg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 22:37:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:37:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH v2 4/5] block: add tracepoint for blkdev_zone_mgmt
Thread-Topic: [PATCH v2 4/5] block: add tracepoint for blkdev_zone_mgmt
Thread-Index: AQHb9M0gUd2RTRIhqkCQPbQZzVrzS7QyNgaA
Date: Mon, 14 Jul 2025 22:37:01 +0000
Message-ID: <f6abd17e-67e4-4886-8a2a-a0701c604c4a@nvidia.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-5-johannes.thumshirn@wdc.com>
In-Reply-To: <20250714143825.3575-5-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: a5dd852c-1a90-40fc-2900-08ddc326f39e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkJEZVByQU5GVFBBUXJOQXBOYzZyUTU1c0pxOGNZNU1lblZNWG1HL0RDVG9L?=
 =?utf-8?B?aXdtZGJjeEs2M1l2aVRRRzBlV1dsRTAvVFpzQzlMTDlBc1FrWU5CcnBvT3pz?=
 =?utf-8?B?eXVmUVdReHVYTWwzUWRtTHRnd2FQNURyMEVELzlHVVpQQWFsS1pnZVltVnZu?=
 =?utf-8?B?VWZmSXZvMVhMNzV3R3M0bTF1V0tpZWtKTmlqWmIzUDFNUkRpMjNoY1pnOUZQ?=
 =?utf-8?B?a0ZzQW5HVUNKOTB3SHN6VzZnaHZtN3hyM0FRSDhYODBha0RPZ0FSZ3R4RDE3?=
 =?utf-8?B?UXVQRVVEelBrci83K3M0aUpEenFtUStVYUVaSncxdmpPZStLT3psWjBBV3ll?=
 =?utf-8?B?Wit2ZzYveHRHMXNBQ2RDeCtmdUdyWEZxSWJvc205S2IweVFRNjBYdUVuek5B?=
 =?utf-8?B?YkVSWkhtL1hQR0d1VFBCNnJCWTRYeHNQTnZVTHZtWFFvcU0vUldyMk9ud29n?=
 =?utf-8?B?aXdrOHJjRU1MYkRzaHgvVE9JWjA0dWlIS1MzQXg2b3VqTGlhZmxMZDdGRWhX?=
 =?utf-8?B?aElMZkQrTzF2Wlh2OS81cU9WWHcrSDU1U2E0aUoyb0hxNXVjRXk5aWVtSHYw?=
 =?utf-8?B?NjFMajV4MHNyTVlLR2lCM0Nnb01OU0FKREd5L3hodUtrcDJTTS9JNi9HS2lB?=
 =?utf-8?B?anBOVlVaMmdha3lIdHpURmdac0V1QldyQ1dvUUFRL0JJRndRUTVKTCsxZEhw?=
 =?utf-8?B?SW9lM1pPb2J5M0UzRVJRQ0RRRTA1VjZ4NTQzTDVhNFl3enB4SkwyNkM1d040?=
 =?utf-8?B?djJ2cWJvYWVmL1hsRm9kbXJUOTEwei8zVENyenFtcUU5Y2JkVCs5Sks0djNk?=
 =?utf-8?B?djBpYkRHd3ByTlBVeXJYSVBvOXNXV0xlR2tpaXVSaW1XdFZTMnNoZzF1NVJG?=
 =?utf-8?B?Y01KT3pmYmh6Szh2bFhjQzN1SnhqK3Nhc1FrcDVGZ2RtQVdwZi9VajFNdHZH?=
 =?utf-8?B?RFlxaFRrSktFQ2dja1dnUFBuUHJJdnZBRkp2UDhva3RMMDNjMWxmQ25Bc0tm?=
 =?utf-8?B?eC9LUlhrZDh0ZkpaamFtV0dVY1FqYWZtVWkxa0JGZ2RZMkU4elBDR1ZIWUhW?=
 =?utf-8?B?L2xUSVV1SENwYmlUWlVKL2k1WnNNczdFTlpZL3RYcDJnUWE0aHFKY052TWs2?=
 =?utf-8?B?SnNCNVAzZTh6TVJvaElIMFJmbXZmNFdQQzJzT1BPd1pFOTc0clVLcmdKTWZK?=
 =?utf-8?B?VzJQZHNhUFBoMDlIb1Y4cnVlTWhrV2VxRy9aT1F5c0ZKSGNiK3RzMHVRbUUw?=
 =?utf-8?B?ZHladDhaZ3kwY2RlTE9UbWZ6OFFmOVdqRXg5a2hqMUhyWTRrR21FWmJaNVJR?=
 =?utf-8?B?WWxOWWVZeThCY1pOaEMwVVB4cFFEWERZUTR5MSt5Nkg3Ly9nTE9WRUloejJa?=
 =?utf-8?B?Nmt5SVhrMnFxQ3VjSng2T3RkUHNHdjZnWTBhaEZFeS9POTV5bW0walgxbEJk?=
 =?utf-8?B?NDNkVGM3UVp2UklpMlYrYU1TS2VERTVFL0QxZngvRWtNeVo1dGowSTZIOUEx?=
 =?utf-8?B?Uk9wRktOMGhSZDRqSFZrTjdNZHl4eEpJdysxYVAyYjNEdGh3SDZFbUZUeW9B?=
 =?utf-8?B?M2lqOGRxbGhEd3FzM25CMnlaK2lHWFlNZlR0aE5YRnN3aXB4OGMraExsTnlu?=
 =?utf-8?B?K3FaMWR4TkdPazNQaFRZQ3MwNjh2bzc3OTRYNDVObzlvVlljS0xlQ2UvRU9h?=
 =?utf-8?B?MDlkOG5Zbmh6MGlNbWVOanNxb0FnNFhvVXRGU2htakZESWpDR3grdjRIeGVt?=
 =?utf-8?B?M1RzakxkYnpHZDNDa2xJYnpyUk1oR3ZkQVRabTRBcHRXZ0pqZFBvSGh4Znph?=
 =?utf-8?B?QlhHYzVXZENsME1EdmhPd0paRG5ZREk2QWhzZTA4MGhsdWcySHZBNnZya01x?=
 =?utf-8?B?dThSVWI1anJubUVkdlVxQ1k4bjI2dGZrZHQ2T1VkaStCT2Y5a2YyM0RieFNT?=
 =?utf-8?B?UHdWdm9zb2hheEQ0Q2lSRVRncUZFSkNrbEZMSG0rc1RYRTZlakdJSGwwTDlr?=
 =?utf-8?B?a0F3WXpYMkVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3lzaG1aTW1tVktFa0JleFkyZ3Rwd1puUEcvUlcxeTVlL1RydnRyWFZzU0dZ?=
 =?utf-8?B?ekZYQnlVcGdIMlF1ZlN4Z2RjcmFsT3JpU1JiMFhIb2VRYVFQbVBPMklvS1N5?=
 =?utf-8?B?NStDYzNJbjQxWmVsc0xzTmlPU2UzcVpQTE5oVTQzRTZ1VDZLMXpGSGVDQ0Nn?=
 =?utf-8?B?UDdtMFZkOGt3TXVmeHVSd3dSeVlieFlucWxyU0x0SVJRVVNGRmR0THVIWEFz?=
 =?utf-8?B?bkxQM2ZwaEE3UVZWR2NwUk5iaGFRYkFtdmYyMmRvY1NsTkk5a3hpaWQzNCtv?=
 =?utf-8?B?ZGhHYzJ0bDdQZTJlSXZReVlZVEpIRjFaSkhsV1ZRcXBuaVhjeXdVU1E2dTlN?=
 =?utf-8?B?a2pqMTYzWHdxZ2tOL3ZnOWkwY2hsQmpnK0I1bHcvK1ZXZFJNMUR1dHk5WXl6?=
 =?utf-8?B?eXJvMFR3YzhCTUMvT0lVQWIrL1YrVytjQ2o2dmhKQnVTbkVNY1p2L0FYc0ZS?=
 =?utf-8?B?V3Z6eE03S2MzSHk1UzV3SmpvRnUwZzBORDRLRnQ2RTVKczlrWExUanVSQUV5?=
 =?utf-8?B?YVdLMm5OSFpCdEk1Vnd3SUQzVEFZUzhmWHlOUXV0RGsvb1BxTFdwZnluVG9p?=
 =?utf-8?B?R25vVmhTVm9oME5zTDY0eWU1Y1RWb2lQanlGZmdHOEcreWozNUIvWGZObWFh?=
 =?utf-8?B?SE5Ma1ZyRmF6dW4vZ29GRDRXbUNkRWwzRXFqeXdOL2tZblVUOU5oSXptcGFC?=
 =?utf-8?B?Y0tKL3E1U0laUDE1YW1NR1h3R08rMkFNK0s2L1JzcExCeGFkeU5MM1JQdmdx?=
 =?utf-8?B?RVlsVE5VUldmZVRiOU93Y3FPWm1VbjZ4Wm1oUXNFREZWc205c1ExTFVFajBi?=
 =?utf-8?B?RVh0WFBiQWVGOHJ0SFo1bHlLblMxNFVZMnRvZ3UvdksxZTlhQ1VHMVQyMFp2?=
 =?utf-8?B?MXdpRXBYb0s5a0drTUl5L2w4dGF6bXg5cFFQMFJLd2FwM2xkWjZyK1lCSlNY?=
 =?utf-8?B?cTdPZTdBZGZHdUZ2TWgzNHM5TytsZGNNbXdiU2lkUkthOTNQcldQZDdyUWEw?=
 =?utf-8?B?Yjdpc1VIWjZXODAxVThHK2M3OTNpYlBqUzhENjI3cjFjdEJYeEwyNmcvN3VZ?=
 =?utf-8?B?bDh4QS9RVnRsK1dQcWcxYTlhM1VxRUhGRGkyL2RvMHYrdmNPMjUzdFVSUlZj?=
 =?utf-8?B?NGoyUitncERqbWtYU0dxTmV3ajQ3YjNBR1BkWTJxR1FnTU5ISnA1UnRJZUZH?=
 =?utf-8?B?RXFpaVJlM0NZamdONktFU3FtdEJwWVZFZ2I4cFFidG9saVY2SFB0TG9FZWRq?=
 =?utf-8?B?K2tiNXFHbnhIWnNKeUVqTzhvazNKRG9XWVFIVUFNa2JaQ1RPWURUV3dkSnVN?=
 =?utf-8?B?NmFMWmZsbTAxRy8wT21mbDdEMGp5T3RkeDNuMkNiVUZ6SGtxUVl0bkdCQWd5?=
 =?utf-8?B?US9EUVRib3BtbGJmZ0ZLUlVuR2hYbTd5aEFsTWVJSkh0bGNpaS9Db0hpaDB5?=
 =?utf-8?B?UHFTYUl6NDJxQUo4SHZWb3BOdWpYV1Vyb2UrMGUwajZGZkIwRFI3WVBhMTJo?=
 =?utf-8?B?NWdsK2tYeFFDK0lodHdiWWpEV1hVbktGL2ZjdVNLNXIwY29rSmczUElkTTBn?=
 =?utf-8?B?akhIc2NwUjBhVFdCd00rRGJHb1dxS0c2T1VvSkw1UURNaE1XeFZWdkgrb1Ju?=
 =?utf-8?B?UVYvTjhKMTY1ZmZkd1hESmtERXVZWndjUDQ3M3FvcHNQNEdlcnJGeDJqVVM3?=
 =?utf-8?B?Q1JPazJIOXloT1BKOUhoYW9UMGxVanpJdXMwT20zTWk5WEJaT3ZYZGlONGR3?=
 =?utf-8?B?NHk3RUQyaGViWEExSHo5QlpDMVlEVklsM080ZytaSS9BbGl4bDVLKzAvSjMv?=
 =?utf-8?B?SUVuZ1lGNFRnMHd0eEJkVmtMM2laeklML0tUWXBSTDJRQkxZL2xub0hXcitR?=
 =?utf-8?B?QyttYkd2N0xwU0FUZkdpcjlsUlNqVk04S3RzZlYrY0daRVJlU1FJdk5aQ0wr?=
 =?utf-8?B?aVc4WGVrTlR3eE5zZ2NTWVFNZjdBV3BXK1IwaWVueStSTlRzZTZsamNSdFo3?=
 =?utf-8?B?Z0NqOUtuYk5Nd1cxUWEycFBINUpJbkpvTFpxS0NNTDVabEZhVjhnWWFTTW5r?=
 =?utf-8?B?MEwvV0hPT2VwbDJneFZNTjkvUmdIV2tOdlNlV3FJT2VTLzU1NVFmUWprVC9M?=
 =?utf-8?B?MTRZZHUwMVB2NjRDK1F4WEQvRUxIeHo3d0xqVC9ldVN5eGVBa29BNUd4OEF5?=
 =?utf-8?Q?Szs7piliA56KDUng3p0zohhcKikqXyDtVqWx55+exCDO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2D0E82AFDE07A418F678DBB67D2D87B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dd852c-1a90-40fc-2900-08ddc326f39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 22:37:01.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVk8qNECirj8WNLZOSuItxdrCUPgK6IuQtVS6qGHClH9yNkxVcj1mb0xEB8dLoGJ0ZmmQODpf2t0K8KcXee4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

T24gNy8xNC8yNSAwNzozOCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgYSB0cmFj
ZXBvaW50IGZvciBibGtkZXZfem9uZV9tZ210IHRvIHRyYWNlIHpvbmUgbWFuYWdlbWVudCBjb21t
YW5kcw0KPiBzdWJtaXR0ZWQgYnkgaGlnaGVyIGxheWVycyBsaWtlIGZpbGUgc3lzdGVtcyBvciB1
c2VyIHNwYWNlLg0KPg0KPiBBbiBleGFtcGxlIG91dHB1dCBmb3IgdGhpcyB0cmFjZXBvaW50IGlz
IGFzIGZvbGxvd3M6DQo+DQo+ICAgIG1rZnMuYnRyZnMtMjAzICBbMDAxXSAuLi4uLiAgNDIuODc3
NDkzOiBibGtkZXZfem9uZV9tZ210OiA4LDAgWlJTIDUyNDI4ODAgKyAwDQo+DQo+IFRoaXMgZXhh
bXBsZSBvdXRwdXQgc2hvd3MgYSBSRVFfT1BfWk9ORV9SRVNFVCBvcGVyYXRpb24gc3VibWl0dGVk
IGJ5DQo+IG1rZnMuYnRyZnMuDQo+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVt
b2FsQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybjxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
