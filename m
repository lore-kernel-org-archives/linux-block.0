Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCB2D97B7
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763966667; cv=fail; b=gMy23LalsTAWdOvoaxmpCIuLdhmdA+nlpyoQNE/rH/mOzx2O4TjWpIHJO2qPb708prEFiuHuaCXJ5nzFTgB6Pq0zSKmFYceSmkvHx+dvdMNWw3OPvu7tbF02xUU6+NirHy8TF+IbzZbEStitZm2jtOoSxQPolQFEnv6ASkpkNbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763966667; c=relaxed/simple;
	bh=NIic3gK0eML4aeVk/c+QYQR4tfyfK1T7lpvC0UyjQR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YB4/zlI0vr4OXTUhcNTjp/riFfSa/SkO1mu+Sg3v5iXXlWcyB2xG5pF/mdA11VHgyQhtOMgOSgwQwS1BdQ8D1uhITmRHgJEbDZShjTnpl2S1BiIzQcxPPOeaYyRFaL23iI+hHzZZfs36nDu9acBXt91Wx3sJaybPUM6EUNcr21E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fY+e157+; arc=fail smtp.client-ip=52.101.125.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fY+e157+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH9ulke0wC/rYhjbbd6H1Bw1SooWU+rQHN9HJzKXSiLbhsNAvc6sv39tSPBKC0n3S8J7PwyS/Q2aGQx7ZoA0z5JbgISgsBcTixtOO0CMVRMoj2UVordc1GJ161mSEn0ldIZWl4eHXfRrS288hBfmcNc+stbdx+kn455qi0EiKQ9+ahKlnRlA917hRYZ5KxVnEJw+FgZaVMRYR0opQbHocyo3/3vetmThAE3rhr/7XgTxRoGSgAVrCYPjDluMqVwVmJOpAsyIdYw9jX0xyYZ7N2wZO9xtpVV3kdkbgq0a1fOTrBdqlwaIAZdj7HeL86+iGi3HrvIXJuiI9S5z4XwYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIic3gK0eML4aeVk/c+QYQR4tfyfK1T7lpvC0UyjQR8=;
 b=wv4oF+o+YZpR6HCX8M9YHzK9MeoniCv6rzF+iXxtxsGXcNzbTWrPDL5G13a5B8IGc+HNGZ9J1VPdgSTO20CTnObmgsOyTOTaxkY40BwVergMM5FJTpyJnubwIylCTmgZPNoBqCgFBOdyd2n1LlMjY/ILOcjhOXEt63LgAlMy6oUoDtjibQUybZ6fkYIMPFhhiYpR0RJqO2jLEKvOoMrsfh5wIpV2KThvuCCSL/hVnSKzUM9+A0S9jZA8+i1X4giRXnmB+6mCq9fjO8Yg08+bZWWxL1T66DM70V7NXlvekf2FS84ZJ4uifpKvBPp9knDUQ45e3RgwqRpzanAPb8aAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIic3gK0eML4aeVk/c+QYQR4tfyfK1T7lpvC0UyjQR8=;
 b=fY+e157+2obODv2ra3xVZp5GknCYoyLScDhnaMocrYlHf/MWruYbhuMwq+8HXVO0OTQdoFZ5SrHs5VAxfDbLli6kzm8HEKQygThtJ4+xsLFd9ETklZSgMcDwV2CK1vVlnBnaIbcjxI2W2MOc2mSh3/aAQ0XxWRRqS1anCTQw6mycR1AbhROasWIUpBG9R1ONaeLypPbPSzMW6MxVT7hV7f5KzhnEfW8mclt+LVOMykRB8khSfn8piklVrdt24YZEhRzctLzB3rdRG4Csef+hqQC3WrYek3iqg9udHW1zwbzfTQpHG3Tjk0lnYkmS2DGCr4aJydImgQ4ig4oTWrWf6w==
Received: from OSCPR01MB15532.jpnprd01.prod.outlook.com (2603:1096:604:3b2::9)
 by TYRPR01MB16109.jpnprd01.prod.outlook.com (2603:1096:405:2e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.9; Mon, 24 Nov
 2025 06:44:23 +0000
Received: from OSCPR01MB15532.jpnprd01.prod.outlook.com
 ([fe80::e1b7:1cdb:1cd7:c848]) by OSCPR01MB15532.jpnprd01.prod.outlook.com
 ([fe80::e1b7:1cdb:1cd7:c848%4]) with mapi id 15.20.9366.009; Mon, 24 Nov 2025
 06:44:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
Thread-Topic: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
Thread-Index: AQHcWoczw6nLMAM56EiPOlYNbhTHN7T9bduAgAP4nYA=
Date: Mon, 24 Nov 2025 06:44:22 +0000
Message-ID: <1c7ea752-11a1-4f2c-8b1d-1b289eabd583@fujitsu.com>
References: <20251121013820.3854576-1-lizhijian@fujitsu.com>
 <cb0d1c57-7cb3-4434-b6a0-592ce370a4e1@acm.org>
In-Reply-To: <cb0d1c57-7cb3-4434-b6a0-592ce370a4e1@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB15532:EE_|TYRPR01MB16109:EE_
x-ms-office365-filtering-correlation-id: 7d0826f2-9643-45a1-1f66-08de2b24e712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkVnWm4yZ0VhRTAra1RRcXhxM0hCbmpvV01SVXp5akxlTi84cTArK2lHdlN4?=
 =?utf-8?B?Mkc4cmJwWEhCTzZiVnBvbzVKeFAwQ0NUVUJmVThGOVJrUEtkSHlrbXJ5cmlj?=
 =?utf-8?B?aUFvRU5nYW82UW5oSll4NEd3Q2dqVGhFd1FXQkt1ay9XVE9pcjM3RDZJbTcx?=
 =?utf-8?B?NUQ5L25VWUNnRHp2V3l4MHgxVnJsWUxDWHF5YkNNYXowUFJjR0F2MzRWU2VD?=
 =?utf-8?B?V2c0elpZNkpWQTQzYVVzUnFtdlpZb21GaW83YnM5L2I4SUhWUy9yblRPaVV0?=
 =?utf-8?B?S2crT0QzU0Y0bmlkcUlaOTlIOHcvNUxrNXpXTHJDQ3M1THFrcS9uOG5ZQWJY?=
 =?utf-8?B?NUVJNVFlOE5pUlY3Nk9ySTdCWUYwM1M0Y0c4ZEt0THhIZzlCdnNYYVFqUFg3?=
 =?utf-8?B?c3dvb040aEZpQjN4dERuY2hDWVNkYkcvaGViMzJoakxIYTZmZnZHYVJnaEdw?=
 =?utf-8?B?M0tadTdlbzhVdTBqcnFwb2VCNFNmMWdNRW0wanY5QmVuZUJCNHc5Tm9Pdmlj?=
 =?utf-8?B?NlNpWWUxS1owbXFQa1lCbUtHdXRjMjZMY0dSWDN1bkpoUXJvVGFxTE56RWY0?=
 =?utf-8?B?blR6KzNzdkc4OUtGRmlhSmRoT1UvT1dPeEJKNXpObThKZTcwcnFzdmtqdDhx?=
 =?utf-8?B?VzNEQldrZ0VCWHhyTmxVMkdTZm9sa1lwaW85dGN6RFpPUDQ3RlM3djlOZFFn?=
 =?utf-8?B?OUZDbzEzdzFrVXZ4UFBXRURHOFJiOU53SURhcksxU0ZyZ0MwNWk0M1N6Rmli?=
 =?utf-8?B?NUF1SkRFL01OSFVLNENUcTFOVklPd25TWVFnNWcvRXlDYTR1TStmeXJQUmpU?=
 =?utf-8?B?YTNlYlA1cmxjamZHdWxGb244QTZHMHlnZk9RTTh1ZW41RURlU2NuaFV5ckU4?=
 =?utf-8?B?VFEvZnAyT01mc2tvTFRMNEZ3OEVCb0tGaWo5WEdyRUpVSGlpSU5IMGNnMkxG?=
 =?utf-8?B?STZwSXlGem1aZVY2MUFIbDNSZW11Q2V6WDU0dURpOStSbWpXSTBsT0duR2N1?=
 =?utf-8?B?dG5DaTN2WkNtZHNKdzRReUlIQzNrYUhSNTNDTExsdVlvRHl6cjJXOGdKSGJa?=
 =?utf-8?B?REJ6R1F2ekp2VlBja0lLaGVCbDlhZnh2QVZxZG1BaUd2SEg3MWxQMGQ2ZVRF?=
 =?utf-8?B?VkkrNzFaMkRaMDQ5UUFOSVV3NkxVMm5CelpsRTZKNHB6RXNlQ2p1dmFLUUls?=
 =?utf-8?B?S0dqMUhwN1UzaWVjVExXektzUHYrdENUMDIzS2hQOXlHTG5vY1RRMmNNcEl6?=
 =?utf-8?B?dko5dWdpNlJBdkMxWjBLWUpaZ0NOei9YZG1DRndWOUJiNmpGZGMwSFd4N3F3?=
 =?utf-8?B?ZlFWSzZMS0FiVmMwM0lTUXZpbk9hNWgxVUxEZmJtU0xlSFgyYVRnSUlGQjIz?=
 =?utf-8?B?QlVHSStWN1Z5VWQ4RXVkMnNlcHUxTUU2Mk1jcDZ1dVI2d0FkeVJCMUVER2hZ?=
 =?utf-8?B?S1J4ZWlRTEJOSUR3ZTlBZjNRbC95b3dVTHJHc015SlhzV0FDSTdYS1c5djU0?=
 =?utf-8?B?SEFPRHlWcklVa2cwQUFyNzl4K0FOdzFrU1hFd242NTRqZXRjUlNKdHZiRGoy?=
 =?utf-8?B?bXg5K2dXK1NlYmFjVklGUEw2THJlVGJWS3ltek5Gdm1WbHpPWWd3eXdXRFpU?=
 =?utf-8?B?N1R4eEprMW5tNEJrTnExSjRZR2tIR1hJNkRlVTFobXJVWEcrTGlwQktTZldu?=
 =?utf-8?B?Y29TYWhBbnN4WDczK1N5cnpwNWh6ZnFvS05UdFE1aS93QWhBaktEMzFrdFc3?=
 =?utf-8?B?NGQrSkwzS3VkOUZrSDdjbXRzemxJZkZCSXNHc05lSmZsZ3pabUVqb0pMck4z?=
 =?utf-8?B?TXBISnpUQlZmRnFnVWU5LzhEOGo2VEtQekhUY1RQeDBxS1lCdXFNUUVONS9x?=
 =?utf-8?B?cng5VUpjSms2L2k5OEdUbFBPVXZQTHZnUlpFeXorbUdFQUREQkRTNzJkUjU2?=
 =?utf-8?B?VW42SkpWdGtmSW83UnlZNkk3dG5zNWJsMC9BdGxzSTQ0T01Vb28wWURsWVZQ?=
 =?utf-8?B?MUExUnJNN1NJUG5rVlFYY25mc1Fza3JhVGZIeVAvWmtwcERiRkhWSXh1SXpL?=
 =?utf-8?B?dlR3TnBhRVN1S1k0YkdiVFpWd1VtYjZlMXdDQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB15532.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm5ubFdORkVCNVdKMWtNdjhXVjIwbnNYa203V0RrQWxJSjQvOWFnNUd0bzZY?=
 =?utf-8?B?RlRTeDE0a1UwYTNxaHlyOVJhUlVhNHZlaXR2bmtqeWptY09DeC91OXAzbDd5?=
 =?utf-8?B?aG5GTEs4VFRETDR5WS82eGVpekpqVTIwQU91SDgvNXdNUER2cE9xTW9zT0lE?=
 =?utf-8?B?dHNDa0FoVGE2Vk9iYWNwUmczQ1NRRlAwZ29xS21lMForV29od0prKzIwWUNY?=
 =?utf-8?B?Y05sbUU3QUlDSkhEalovWlF1bzJybE9waE1CeFJ5YTRVdXBIVWJHQXphSzk1?=
 =?utf-8?B?V2JRNUkxUWcxdEZCL0xBbnVKTWZJaWxmSjJBRGRhVTlkdW0vZEVFWVZmcHM2?=
 =?utf-8?B?Q0k3UXJjWmRpM21oU0VxTGltVW5tNlRNdXpuSjR0aGRFWlZuYS9OTkVZeWsr?=
 =?utf-8?B?bjRMNkU5UFBRNkJ1bk9oQ2trV0RNMHIzN2dQSzhIUkgrWDYzY2tDckdyRGZh?=
 =?utf-8?B?anJsUk9FZnUyZWQwcWhWZmlkeWhESVYvOE1RMGFXMnVlNnh0MDlOalB2Z09W?=
 =?utf-8?B?VklTQWJZY0s5TUJyM01Sa2tEbzgyQjJTcCtKRnBJYjZlL0ZQL2VMTkxNeHl5?=
 =?utf-8?B?SjluUVFMNHZlQTZqWnZLaTE0QUw5VXBSaVE5MWgraXFxd204QUFYUmUzYXZ6?=
 =?utf-8?B?WDNaV0VlUVk4cnNPQzdHdU55VUNhWC80WElCR243Z0xCVi9iNmlPNnJUSGhn?=
 =?utf-8?B?WXRaYjVIdnM3U2lvc2hrRU5zeVZVb0EzLy8zQTZIdkkwQmprSE5TaEtJbTJm?=
 =?utf-8?B?L3ZRclN4TmhhL2l3K2tTVnFjTzJKRGY4Zi9IVWNvTTdObmY0dVRVV0Z2dmc5?=
 =?utf-8?B?anZESEZhTFZYNzFoZEFzTVhBekptTm5DNFFkRTlHQmZocW9ZZllWbyt3czUx?=
 =?utf-8?B?enRsZHppUExqaDIwK09QaXBYK0djdWRsbHVqMDhBTEowRjN6QTJvcG9RaEcy?=
 =?utf-8?B?bTkvcCt3SzVXZE81dU5IaVVtRFgwVHZWbEprNk8yVHJkWlJQVnNjdUdGM3JK?=
 =?utf-8?B?c01DZjhPVFRtWXVuRUhYSitSNHlZZkFRZWNJemNndEJuMlJMQUNTQ1FDMjV0?=
 =?utf-8?B?enhzS0hOeEgxYVRKeGxIZ1lnNS9OKzBreGNZQ3JTMWN0aERBRVlMOW9BTndG?=
 =?utf-8?B?Q2djd3BaK2E3TmVrTU8wSmh5ZkdyeFVjZnhFaGhqbElpbHZ5bW1DbUxHOWVU?=
 =?utf-8?B?R0lzaE9xcmQyZmx6MEtWN2dJWXV0UXRzYzkxbHJVY0JwOUxJRHNaUm9EZHF1?=
 =?utf-8?B?azBWNlh1UDdpWUxTQnMrdk9uQzQvL3RTUllaTU42ZXlXbWxnQWo3alltSlUr?=
 =?utf-8?B?WGk1SDdqaG5VRkE1elhkMHJVdTZhUzc3YkFOd1R6NkNuRGhLQWpJZTh0dXBQ?=
 =?utf-8?B?UHlSeVhCOVg4SURXNlMzQmFLTndNaXQrVUp0cnJ2K1JnQWdKK0pYWUs1VXJB?=
 =?utf-8?B?Z3JVcFlRdkNMMTJteEpCY1RVUkZMa2lnZzhuVWR4MjBFVlp3Tkw2dUtud2kx?=
 =?utf-8?B?UXkwY1F3dWxyaGpJQzZVVUNoNnZmVlpPRm9BUUhmNnZYQnh3LzVta0ZadmZ2?=
 =?utf-8?B?M1orN2VMaDF3ZFAyQkRPaldSQU1xejhPQlpYalVrUE8zbjVCZ0c2WUIvK000?=
 =?utf-8?B?VXp2a0tBTmdydTdPK0dlN1krNFR4UnA5Y1RLVTRaakNmclhFMEhKSXozR0NE?=
 =?utf-8?B?R0dBYW5vTEVuc2dLUDV2ODk0OHlRd1l0S1BwdDgzOWRkTFo3NXFab2kzUzJl?=
 =?utf-8?B?allLemNyUXp4YzBkT3pkaXMzZ2JaTWg3blRaRUtaMDloWTdORHBxZlM5K0M0?=
 =?utf-8?B?WGtGMEhuY2NFQ1ZucTFLTEFHQ0gwS1VaS3NoQkI2bXJ3cVRvakNhK0JleTZY?=
 =?utf-8?B?a3daclF4aXk0bDRUUm50VTZNNWxqZktpNlhPZ1VGSW42N05wRlZPQ3RuNms3?=
 =?utf-8?B?T1pzd0xpTjA5bFVJU2Y5REgxdEQrdno1dFYrMndtQlY4a3dZZEwxakZTUFF1?=
 =?utf-8?B?L1k2SWh5K3pHNXBFVGxHT2pVeHpwUXlvSUJldUN2cmhtV2FHNVR5OW9iQXBq?=
 =?utf-8?B?NnQ4M05DZ0VzZzFUQTZMMWo3UGUwRFNacVpFYnQxL3IrTmVVb2duZnRQcTJ6?=
 =?utf-8?B?d3RpNHRpM01jM2pUekh6a0JOTEJpcGdxS3hqY1NmRFpWbnV4RmQ4MHV4UWdv?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B521D230D12C442AF9AF9DD2F4EC8B5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB15532.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0826f2-9643-45a1-1f66-08de2b24e712
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 06:44:22.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ys5EqmJkikqSAsWlCGmYsgo4QcfRoEBFmTwPiVGM/lcSYyfF1b72UHXh2ZaclY4woKM+xexFh2r/NPKZ5t36RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16109

DQoNCk9uIDIyLzExLzIwMjUgMDI6MDUsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTEv
MjAvMjUgNTozOCBQTSwgTGkgWmhpamlhbiB3cm90ZToNCj4+IMKgICMgUHJlcGFyZSBudWxsX2Js
ayBvciBzY3NpX2RlYnVnIGRldmljZSB0byB0ZXN0LCBiYXNlZCBvbiB0aHJvdGxfYmxrZGV2X3R5
cGUuDQo+PiDCoCBfY29uZmlndXJlX3Rocm90bF9ibGtkZXYoKSB7DQo+PiDCoMKgwqDCoMKgIGxv
Y2FsIHNlY3Rvcl9zaXplPTAgbWVtb3J5X2JhY2tlZD0wDQo+PiBAQCAtNzYsNyArODcsOCBAQCBf
Y29uZmlndXJlX3Rocm90bF9ibGtkZXYoKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgOzsNCj4+
IMKgwqDCoMKgwqAgc2RlYnVnKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFyZ3M9KGRldl9zaXpl
X21iPTEwMjQpDQo+PiAtwqDCoMKgwqDCoMKgwqAgKChzZWN0b3Jfc2l6ZSkpICYmIGFyZ3MrPShz
ZWN0b3Jfc2l6ZT0iJHtzZWN0b3Jfc2l6ZX0iKQ0KPj4gK8KgwqDCoMKgwqDCoMKgICgoc2VjdG9y
X3NpemUpKSAmJg0KPj4gK8KgwqDCoMKgwqDCoMKgIGFyZ3MrPShzZWN0b3Jfc2l6ZT0iJChmaXh1
cF9zZGVidWdfc2VjdG9yX3NpemUgJHNlY3Rvcl9zaXplKSIpDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgX2NvbmZpZ3VyZV9zY3NpX2RlYnVnICIke2FyZ3NbQF19IjsgdGhlbg0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgVEhST1RMX0RFVj0ke1NDU0lfREVCVUdfREVWSUNFU1swXX0N
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybg0KPiANCj4gV2h5IGRvIHRoZSB0
aHJvdHRsaW5nIHRlc3RzIHF1ZXJ5IHRoZSBwYWdlIHNpemUgYW5kIHdoeSBkbyB0aGVzZSB0ZXN0
cw0KPiB1c2UgdGhlIHBhZ2Ugc2l6ZSBhcyBsb2dpY2FsIGJsb2NrIHNpemU/DQoNCkdvb2QgcXVl
c3Rpb24uIEFGQUlDVCwgdGhyb3R0bGluZyB0ZXN0cyB3aWxsIHRlc3QgbnVsbF9ibGsgYW5kIHNj
c2lfZGVidWcgYmxvY2sgdHlwZSwgdGhlIGZvcm1lciB3aWxsDQpjYWxjdWxhdGUgdGhlIG1heF9z
ZWN0b3JzIGJhc2VkIG9uIHRoZSBwYWdlX3NpemUuDQoNCg0KPiBXaWxsIHRoZSBhYm92ZSBjaGFu
Z2UgYnJlYWsgdGhlDQo+IHRocm90dGxpbmcgdGVzdHM/IA0KDQpUaGUgdGVzdHMgc3RpbGwgcGFz
cyB3aXRoIHRoaXMgY2hhbmdlIG9uIDRLIGFuZCA2NEsgT1MuDQoNCg0KPiBBbmQgaWYgaXQgZG9l
c24ndCBicmVhayB0aGUgdGhyb3R0bGluZyB0ZXN0cywgd2h5IG5vdA0KPiB0byByZW1vdmUgdGhl
IGNvZGUgZnJvbSB0aGVzZSB0ZXN0cyB0aGF0IHF1ZXJpZXMgdGhlIHBhZ2Ugc2l6ZSBhbmQgdG8g
aGFyZGNvZGUgdGhlIGxvZ2ljYWwgYmxvY2sgc2l6ZT8NCg0KDQpUaGF0J3MgYSBnb29kIHBvaW50
LiBJJ20gbm90IHN1cmUgYWJvdXQgdGhlIG9yaWdpbmFsIGRlc2lnbiByYXRpb25hbGUgZm9yDQp0
aGUgc2NzaV9kZWJ1ZyBwYXJ0LiBJJ20gQ2MnaW5nIFNoaW4naWNoaXJvLCB3aG8gYXV0aG9yZWQg
dGhlIHNjc2lfZGVidWcNCnRhcmdldCBmb3IgdGhlIHRlc3QsIHRvIHNlZSBpZiBoZSBoYXMgYW55
IGlucHV0IG9uIHRoaXMuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEJhcnQuDQo=
