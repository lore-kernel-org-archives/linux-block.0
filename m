Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F72F12B0;
	Wed, 12 Nov 2025 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991854; cv=fail; b=LZiAf+BYdnjBMT3DzRC7TKux/9VEHUO5S/WxVQc4p8OJ4xo61NwbkRjvhjP7+FWVodz4yyq1D485eUEX+sbXRCRUPU+Eexi0KO/iymeTxTOMdAUd94wDBYLwojdRNRLe1inq8CjDwf8g9ALwzBatVYrMZrG5+0zBzw8/hO2Gscs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991854; c=relaxed/simple;
	bh=odt7xQ4f4eY6I3MVb0KWXKug/6TeELMADTFtRQeiIQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JiS3jwKmebRk90exFGKkDLB//ctPhDZlwhJIzezloOSQig4m3Gk3tCqvRLTHXsMQyrqzky6chDoxeLCUm1jkP4KeQxCPAdC3yTk5FWcsBfD5Ms5cyMst+JhtGAGSa9AjLTDtwmNqBpyedDXXocsIMzIg9emZfWGRyS0bxQifmlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SP0qERFn; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SP0qERFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFZPqsCxqwslaJvt3yWkx71CIAZLTWUuRPYWx5cDGCzGG0zC/3BhVq7x/Ft/nNZokRuTfDPVlQmpQ+HUquhF/13a0xlOXpPWnVjt3LtWwCDi/gLmbssejAPCtQLd+m2VvURxGZBv8BR2OYSO5+nXKUNoa+RT8lCGeLhyPM+YQAfr3Lep5kg07n9FahRQG+iMSX+JrYGDGfLwy9sRsjTB3nVfVtEwRpMwA2tfwD8F483p2JY4NH8sNDSutUl3xVXNqRvwSIiaCw1nmalqjJ/gR49cJ74VygdR8V0RvpuoZrEM5leFEBT89Q/XmbOqhLKyPrRb5Kdl0xxnNwvfHwiM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odt7xQ4f4eY6I3MVb0KWXKug/6TeELMADTFtRQeiIQo=;
 b=yzmGaFLmC8QymOtTpGq6rnbEP9JtBCh5LHDWIpu/EWSmYLrJoExQZkz9ul3GcW2OeCgcZ/oohdGmPx066NpzCIFx8eEm6+oDVf0HuZ8mO31AVSqdW5RCOzTOuNTx7chJZwdkLnsDi6308q3NeudBovzYwaweftDoT1+27RoIc7YXMmzZ8zrbdzDl0uSsjJrnuQBgUHScVxpneCg3H/eeCM1lFppcSYNX5gaqXNBq/l2eNxBZDRogA+cjmFjU8XKaA9Xyzikte+Qeuv2EncThsqIIYigSKI8VLna02pBU+PoOMm1BRb/0s+JbRWQRpA23nMVuarpFIfuJba94Nc44pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odt7xQ4f4eY6I3MVb0KWXKug/6TeELMADTFtRQeiIQo=;
 b=SP0qERFnLzAOoiYhURDniGXWjYquEYyZILKeS6G//f7lESr3ugVi9eGr+hfATZr3jWatIU+iWYSOeorurMleIkagIpj4PXgtxYhqbak4HjYkb4QE67s2suntTFplUtwGaqF/VHldfDL4UKN42NAURynb5Rgo2qupSfsCwnyLeUMoZkB5wJvsFUl0vgyW1Lno+YenDhUzPdX3FjNtwNuJXMfGqPAWE+iyouesvTySS2tfQKUxiQPG/W0WKVW9RNm3ELaEcDfLXu2mNOyyH1sz5ccSyjBNn/cTZ35GDJ0YqmIi9iUgaRI0SsndbjT2gLZyWcnROoR3qxV9xO33SzJqOQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 23:57:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 23:57:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Thread-Topic: [PATCH v4 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Thread-Index: AQHcVA1m1R28MWPy10WlbDga76nx2LTvuBmA
Date: Wed, 12 Nov 2025 23:57:29 +0000
Message-ID: <65889a66-a4a2-41a7-be7e-dad856c4ac56@nvidia.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <20251112-block-with-mmio-v4-1-54aeb609d28d@nvidia.com>
In-Reply-To: <20251112-block-with-mmio-v4-1-54aeb609d28d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7248:EE_
x-ms-office365-filtering-correlation-id: 19bad708-8be4-4083-8c1a-08de22473d23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VW1TZjJOOVBEamtHbkVIdDFrOUJ3Qy9MSjhjRWlsRUhCTnBqNHVuYnZLc2ts?=
 =?utf-8?B?YU5DeUZSdml0Y0dPZ3BwRUVvU1BTSm9zUHFQUElRTXczQVJXc05FRWsxSmFD?=
 =?utf-8?B?OFNlNnJOeVczNmFEVEpKNDdKMTZ1SmdUdW50NTJ0ZVJ6MkJXam14RmJPeFgr?=
 =?utf-8?B?Wk5OckF1ckNoeHJtYVh2QVNWUkVQeG5iMEZGcXQ2b05TclozZWVkZE4wWmZw?=
 =?utf-8?B?MnI5Wm1EQWlzdzFmM2IzVG9Db2p1dTJyN3IyUkdQSCtIWWl3enhPaFNNV1pO?=
 =?utf-8?B?NDI3dklmZ3R0U2dFaU9XTGZGYXFtbVFZdVJHMS9nck5XZjlzR3JqK21HUHR2?=
 =?utf-8?B?dEVDMXFGV2xLazhRN21lU0h4NDhBRTJ6OGIrVWFOd0VoUWE4MnlkWGNHTW8z?=
 =?utf-8?B?YUFsSWhrckk3aXVwYll3RTUwVTlyTys3NEUwRnI5WWpwYWFrc1luTUxScEsx?=
 =?utf-8?B?VHhhRjRQOU5Bem5aY2ZGZzhoQURVWE1vQUNoUWN4Rm9vRWJuL3BOTHk5Zk5u?=
 =?utf-8?B?Ulg2aHhvblhtOUdIcUFXYWVhVEdqRXNVUFYwM2xPZ2NtQXhHaVNKWXRpc29m?=
 =?utf-8?B?RElvYXVrQWN5d0RLVy9qYlkzTllJZlVWU2hzOFVYNEhxcEJKMHRhbmI1WWF3?=
 =?utf-8?B?ZHN5Z2h0SHc1U0RqcE5WSHdMY1FCOExZelhzVTJ4NktrcDhYQkFSSm04Y1Z0?=
 =?utf-8?B?b0pxQnBxYW1HRGFHbjVjbmh5QzkybVR3VjA3TkYwbDVJUXE1UTlETXVNTjF4?=
 =?utf-8?B?c3JNUzI1VUo4ZSt5ZHc3M2VBSUJHeE9XMkRpcngzSnZUVE10bWtqM2Z5cGdx?=
 =?utf-8?B?ODJhUUUxNlFsQzBLLy9hVHIyUmUraHdkYnBSVG45YXQ1YmFLZzRLazJmSHFJ?=
 =?utf-8?B?c1RPMXRtZWU5blhZZHFTeG9Ld2x2K21IZ1J5OStsLzlyVlo0Y1h6a051R2pH?=
 =?utf-8?B?WHBqancwdTRGcUdVeGhHUytiSHMzRzg2ODNlUVQvakNWc3ZESTVBSkVFTXgx?=
 =?utf-8?B?N3BBODVDSmFnb1VEeWErZjNIV0tBMnR2Q1lWYXNHWUw3MUI1WTZwZmwzanlJ?=
 =?utf-8?B?NUFjeEFkOTE4dU03L3RRMmVoQ2VxQ0lKNlNxcm94bklHZURFeUJnTXJkTENP?=
 =?utf-8?B?V3d3RHFFd0xKOURsUktJYTV6c2FzaUZsQWY1b1hJZHdCSThzelZMT29sZmN3?=
 =?utf-8?B?WU51L2phNzZhNEtnZ2t3NDRTbGlmT2gyZWcwaU92UHVralcwR3R0QmlHdVhN?=
 =?utf-8?B?UTNOMGs4Tm1iNDF1dmhUaXRQdW41VFBjTElIdUxsU0o0MWF6ZG1MOTJFMXB1?=
 =?utf-8?B?OEdXa3NlZS9ZZTU1Z3NPM3dPcWIwaW1ySFU5cTFjcjVXSk1sS3F6eEJYSSsw?=
 =?utf-8?B?MTZKOXN5Rld4V01mTjJTcURxZzFNbHVvdXRlNDhIVkJ5RUkrRE9veGR3bm9P?=
 =?utf-8?B?ZkxmdFYxL29kOUhrQWtnWWd3cEFtbDV6eitYVGhRd2lmMzVxU0xQTDR1Nk9X?=
 =?utf-8?B?cFltanJSUTYra0FLSWo0aFJxdU9LZ1oxb3Q5dVRBKzN2OXdHMysyOUVxVHY3?=
 =?utf-8?B?dW8rRjZQNHBwM1RVNmRFRXphRmNPdWtic2gwQzNPNUtuT2dUMzRXUkhsZUU1?=
 =?utf-8?B?aGptSitNVTBqdnhyWW1WWlVud0ExSGJWV0Q2OVNIekVpL2d3MUhNaHFHN0x0?=
 =?utf-8?B?ck9DVUpFalUvRzNiNVdjek91ZUpVQlRrYkF2VTN5S3hmeG11RUlrTmVwUkVa?=
 =?utf-8?B?cURlakp5Q0d3VElqNkIvVlh6NWY1T1hTbXQwc2J6Znp4TDJXRFpsa2hGRTZy?=
 =?utf-8?B?SHRWdk85WVZxVHcyVDdNL1pLeHk3UG12TlZFMEJjdnBSS05aQnYxSFhUaS9V?=
 =?utf-8?B?a2JuQWxwU0J1Ym9wakRHS2NZb0M1dm5yMm0vazUydENqVUlrNGNMM1dlSmVK?=
 =?utf-8?B?dExXNktQRHByWkxoTmJneC9OcEZnYURZWm00cGoyMnJrSHdBSzFnQWRjc2RW?=
 =?utf-8?B?TEl5T3RnZ0VpWXR0SEQ2NFc1SC9kWjJUeEl6RmFoQVJsMEd0aXhJQ1M0OHlG?=
 =?utf-8?Q?cyWVhd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2RueFFZYVhrNVhhM25xT0c5TktsMDNrNEZMSVpnRFlXYktiN3FVZzkwd1pW?=
 =?utf-8?B?d0pJTFFISThVVDRDeGZReWthZ0dBUmdua1pYNzZubUhxZ0paVzArcHdxbXVs?=
 =?utf-8?B?VERuSUNCZUlWbEY5ZXdMQnR3dWlZQnJSYTdYOWwzQ0QwcW9UWXgwTU5xa3Jn?=
 =?utf-8?B?R0xWUXIzZGh5eU5MKzhyc04xUStQY1h3ZVlkQnFOampKSDVjNHozTFJYSHpx?=
 =?utf-8?B?VThRYy9wNnlCM1FKL2I4NldrMm5vK2g1RDhvZnlCNHptT3Z1NDJUOFpQK2dp?=
 =?utf-8?B?ckVFZDFkS2Z0WXRnaHZHMERQWjJvTFBVczE4SVM0TVZ3cXNYRzlsNkxJVVVH?=
 =?utf-8?B?V2hVczBpeWt4RkpZNmdWcGZKT2pnWDhwUmRwVFE2NVJUZFlnckNzelJ4aWla?=
 =?utf-8?B?cW9BY3lhdE03TFQ3UXpXUitBYmlwR0dqY2xFbUV2UUN1N244Z1FjdTRVU0Nx?=
 =?utf-8?B?dSs0SThZVkF5WER2TXE3NHpGU2dpU1RwV2Ewekw3RzBFd0gvUEM5SHU0MkRB?=
 =?utf-8?B?bU02SkhqVTQ0MXBHZnR3cWl5T3NuM3RiVE9aV2s0bG5RSUttbTZsSG9kbkJS?=
 =?utf-8?B?V1kySVhOYjZ5LzdjSUZ5SllEV0RtZ3VPalZYV3pvWlROdEY0QnhOM2tTSUxs?=
 =?utf-8?B?aC9qYmZ3anhTNkxQT1JPZWJlZDU2NnZmUk8rZU1mVmMxc0l3R2ZCMnI5b29W?=
 =?utf-8?B?REJYU3dkUDNPZ0ZwcjhtUzN5N2V2bVYzNDNXY0JHdWl4RjN0TEo3MnU5cXYw?=
 =?utf-8?B?VGlpRnV3SVFxOERySVBPbVFpaTM4bzd0amF5VlRnWnhJUTM1TGNoUVNQY3JJ?=
 =?utf-8?B?MUNGMDU0cCtOa0g5bHgvQ1FjMUdDU1A3YWQ3dTZ3TzdjOENIVUg1Rm92cWxH?=
 =?utf-8?B?Rmlxakc5VlU3VitCT09jWktXOWUvdGZwbGNHQWFWYU0wUHNQQ2NTb09sdHpN?=
 =?utf-8?B?bWJieWM4cVRyUkVqSkxmN0cvSVNKVjRONkgzREtqYU12NnovU1B4azlxREdh?=
 =?utf-8?B?eXZkOU1ST2FIQ2pQb2JWUURwbHpNcG1sUWszb0JGNzNyYjB1ZXQ4TFU3SWZ5?=
 =?utf-8?B?YnJReUFJcytEVk5SaUVNZStBOEFHbk5LM1JIUitJalJpbWsyb2doVzNyWkl2?=
 =?utf-8?B?OHp1YWRZVTU0UjVDcHl3TVBRejhWRVFsVjg3UUdZQ1hpY0VmdEJyUlg3U2FO?=
 =?utf-8?B?RGtEM2VmeGlkVHNqM2g1WXBjUVN2OFU3WjFJV2x4S0Y0RUdoZFpSalV1UjlW?=
 =?utf-8?B?VTE2d2ZqT0tkaHN5MXIyb2UyU2dsTjNodzlicjF6ZXdzWFdDQlVNZGt5SlRD?=
 =?utf-8?B?NElEdGlmbFNkMlZuSExZN2tjcFp5aUphazFDM0tqbmVYbTNHZ0VIVm03L3BN?=
 =?utf-8?B?VHNuWXNCYXlsS1hKM2NFZENzYi8vRlhTaTl6NzZFR0I0STBXbkY2NkNYZ1Bj?=
 =?utf-8?B?L1JxVFN0b0xFY1hIdVJiMWlTWXg4L3Y5KzlNdzlQa3lXZG9MZWI5YXVHNGlV?=
 =?utf-8?B?bTlzSDBWc3R6c0JxelpxYWFzVHNmVXdYOHhySW5BS3BPbFg4TDFsS1d0S1o2?=
 =?utf-8?B?YW9hVU9qZjhndm9DK0xUQUFnN1BvYk5jRGJjREJnRVJaUmwyaEpxdmpPMVo4?=
 =?utf-8?B?Y0x3VDBDKzZlbmNWbVI1YjMvenArUGo0ZnJFc1hmOXYzemZ3c29zTUNxU3k1?=
 =?utf-8?B?V2RVQmVMb1RqOTdyc3Z5bXMveUQvTXl3SzhGbGI3dlViVk5ycXIvTkRWMDNB?=
 =?utf-8?B?bTlVdnRoTHA3eFNaeUhaMVVKRFFoVHp3Vi9WdG5EeVBZVTl5Y2VBY0VacTZv?=
 =?utf-8?B?ZHVkZFBna2htMmowVUpkZnhkMTF5amg0QlpDdUtKRmtUbW1ydmJVWVFQNjVt?=
 =?utf-8?B?WHJYSUgxZlNVS2hxZTZWbUhIM2hNQWI0NUV6WG5NSDJkMmhkUmxpWlRZcU9k?=
 =?utf-8?B?L3FhcHRDTUloL3d3UURWOG9uZFR3c3Rta1RUWWlsb2lIOTBWUURBbGwxQ2N2?=
 =?utf-8?B?UkZMU0ludmsraWJ4aWsyRmJ5R01uRFVxdkJKYkdIRWJNQnBzWW4yWlY0MXlp?=
 =?utf-8?B?bllYT1BHWHE1Wll4ZXBuV2NFZzNqQktzZndjT0lRV0x2dUtpZ2RSdWoybWZz?=
 =?utf-8?B?WWpwODlSRlp2RndRdExrcWNxUnp4aVVrNDBwYlN4Q1I4dmE0bUZqVlRiNmtT?=
 =?utf-8?Q?llhV1FPHqtlbFCEQWPGaci6Xt8aAke2Ql9YzcaBe9Ctb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7365D4F2D3EB254D8C8AA9A0521258D2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bad708-8be4-4083-8c1a-08de22473d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 23:57:29.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rtnjN+Xa+kumYkF7WQ+nN3+dHOpZ/sNSKPoRNY3cdrt6LqSXFRGZSavl6sgEoBLACVV6JPxtyxUXAt00mMW9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

T24gMTEvMTIvMjUgMTE6NDgsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVvbiBS
b21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KPg0KPiBBZnRlciBpbnRyb2R1Y3Rpb24gb2Yg
ZG1hX21hcF9waHlzKCksIHRoZXJlIGlzIG5vIG5lZWQgdG8gY29udmVydA0KPiBmcm9tIHBoeXNp
Y2FsIGFkZHJlc3MgdG8gc3RydWN0IHBhZ2UgaW4gb3JkZXIgdG8gbWFwIHBhZ2UuIFNvIGxldCdz
DQo+IHVzZSBpdCBkaXJlY3RseS4NCj4NCj4gUmV2aWV3ZWQtYnk6IEtlaXRoIEJ1c2NoPGtidXNj
aEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5k
ZT4NCj4gU2lnbmVkLW9mZi1ieTogTGVvbiBSb21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
