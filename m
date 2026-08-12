Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94441D23E
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529069; cv=fail; b=Mmog4EI26fY4raGYEhg1zHJSqwCis1WqQqTQDHMjlQIYzFFy/pAicJtNo4SwdltV6sVRJ9bCGz/utQyByXOYLHYl5QHM4gNIXoZzDi3ukikE2BvN/SeRwryg7ihjG9Va2ZjgqT83ekdSWUw9wkno8Wkh1+LBulzohqI2WECiAtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529069; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AIXY9BbTR9tk0JHa1f88RoPIFtoS5277PgjUhQMQkEHN+TKsYApJbXbeiNNzt1HKmUW6xdiIL4ZBOr8cgpvHRnc4DkqmTRhZHVT+iSGqglOrISBtnbM2ftJRpYKMXp+LgTcf+TjYNSVCoqKkZrRK5wEmbfq8yN+q1vxgbxrsKjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fw+pZqbl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wmb9AXZR; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fw+pZqbl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wmb9AXZR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786529064; x=1818065064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=fw+pZqblnx4zNuC9dE3lss8MDfoKa1Psa4cyV70FAplt7GTiNHd+cCSg
   DX4AhU9336OBfSJHD63RKPJVq+pU5wpA8RMWuz1noI/VygKEwRHYa7FFw
   vzKqilV58BPWxSdDle3C7L1WiLov35ietKLdnndSuqnrcgSx6nbEvBwNJ
   VeGFP7lP3Us+JS+ciMyvZh79z3B4yrl7wokOXBuFjf+DkqVKL3jnoscu+
   AfkVzWyUpmkW+DE65djUEDokg/V4m99m5Ro6XeN1kC6bSs6D4zKjPlh/V
   Qx2mQ8Ykeve7TqvRz4dMQbSqvXhwBAwr/xwN0yNQomQQh8Dmyw1B6aKXi
   A==;
X-CSE-ConnectionGUID: 9nrUsbWaQJqgOc6FcQv4tw==
X-CSE-MsgGUID: X0GJ7MaET0+t9IqslMVO1A==
X-IronPort-AV: E=Sophos;i="6.25,219,1779120000"; 
   d="scan'208";a="148815110"
Received: from mail-eastusazon11012068.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 18:04:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miHs/bEoX+CluJ5LnqA57fb7ufm1bIFBta54Dm1sVSyWdNl/vo7aGQORQfYPi6RtOq0DslIy6Wj4bfsWIYGn/sd0ZkEDvh5DUcBt8K9X7aOrCg9/t50t17WKEVxK+Rvc1hLjlfokNc65EoQy3a8Bdd091S9J4DyHaTmXeKpehTlIbucdpEClrJAZtSYsyxM9Y+OcJhAdiq+R+Z7ZizmAXpR46ypi9yVtk8DLZbDo/w12W6EOSQLqQsCdZMV1Vm4VIZIznD62HIOREVDz6liQDx70xpu5vTk3K/yO8nEt+byUyLj2M2HDztwnH3nLTi90ANBoCr7/OEfRjwtmmf3NqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=lyXEeabX+5CGr9CL90MTvUpj0In+mccN2xPDYgAC/4UTHk3KKUTEZbWAdF/18dl9ZZmL3fTqAyysIHMZKH9j6En/1zHgvpJTfPlWuAZo2F8u5Zg9fLteUSGmto7uGPvolYGTMGa4HRMEo4TIeim6V5EXYVtX87h5z75jNZhWdfwpNAbOhc4ICJj5e7SfvebjPei5dZXpCJLVxZRenbDqOlVC5XKn8ZtFecgQbH1gU6Z85hSOgZ/+if48ZA/3T0FqSLXELmqMdQEDn8EIBiu7GHXlgR1M6jopQ+Orz2SnlB2IpMrC4I9Uq9pRocr3np/XiwuELXVsQ9mdzejdtM64og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=Wmb9AXZRcgDTuAre9QR/MrszODJBWfpCdF1PgrCVlAh+dX8fq1gMxvomDmIdObgOkd0tMboIn5qNBjJ26FW/ArBF5fVi4amDittRN53Dy+vB6S3aoVb4zQMWHAI0gGP4L4usBWfczC0R3v39h50DG7PCRNzZ8r+QdIoBj82sfR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by SJ2PR04MB8845.namprd04.prod.outlook.com (2603:10b6:a03:53c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 10:04:14 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 10:04:14 +0000
Message-ID: <226fd3f8-f141-45be-9a1d-f3d1c303ced5@wdc.com>
Date: Wed, 12 Aug 2026 12:04:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] block: remember a zone type regardless of its
 condition
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-5-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260811105852.1245357-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|SJ2PR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: a14463cb-b154-40a3-952d-08def859107e
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kzRx+ZEALEBjvr8cbC8qJAL0ILTl7vrWui8O311vlO7GG0CFD9JFYqL5hM4SBgBx3/wLMXWhGpWwYHWC0cfmEgqv/+m4IaKGnK8leAyJ29vLAayrj7XcNaeackz5chh2ChCPz12iu++j/e15188ceJxc92ha77H4A4b9ZCdEAq6FyQFxyvYXM0eTKXArgB94pqfdBOYXDmuYwV3GjeuGlF8qM81RptawPD0u0T/bHX2t4ixzCc7K224eCz1fCVN5EV16rY74X9jT/D6Ha5D/bhmKuPFmip7Jdbn031btmnoJclfCog+Nc7NCTfRTv0GCUG96busL3671UvAgBjg6R+7sQe2MtplW8a0ayCerKryJewGz3tlvimFt8zC6oIejCsA2X3rMx1ybYXDjl1E0hGxfFsFeZQD98ww0D4h3XDGozu8RdneYPrhGk1mtGJQJPQnCrLpxicY3+gqnsFv3gDIdtL7mOSSxV7L3oQHsm/QhkoTl+7A6FCFbwCZFPqHMvulIVRMvzbuksAmxprGawW1MArRcyLcfiF5tjIchddN1CeCp0qE/EckN94k5ZWId614rLERQXb86uSM0WL6lt2ZNX01txQcWHdE4yi8qiRWD9ROX9lutDNY6LLwdWO8XXI1lKiToFM8ScQfKFl9SrBzQ3GRDlwt9IvTSlOuMG9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW0rYzAzeSt2L1pWcGdPNmlRMVZEL2kybzJKclJsYWE5RXlWdFhIcC9rUG04?=
 =?utf-8?B?dTN3cFZxVXFGVHE4ZHZKUXNOd1EvSS9VVEs3OWxWL1lVRk4xdko0MHZHTGp2?=
 =?utf-8?B?MWEzS2xZdG1vRlN3TlRFWFFScS9BWnY4M3prYzdmTzRIUXhuU05HbVk5V3lP?=
 =?utf-8?B?Y1BwSDYrSEl5bzFGYTltMWxrS2lCTE1xVi9TemVmTG93SlBiNGJsTk5Dckd1?=
 =?utf-8?B?Qko0OG5XTVNhNjU4M3M4SW1MVVBMVE1UM2NWNzRlUGNsaWJZalFxTlYwQ2FS?=
 =?utf-8?B?RTZUNmFWK0JuQ3BHUk1GbVk5RjM1NHZWTDJIbzZrRXV6eTRqYUNoY284VVB3?=
 =?utf-8?B?R0tvRUo3WXNxd0hqanBOdERhYmdRdmQwb3hHd3Jlb0ZsYVE3bFo4NlB3TENj?=
 =?utf-8?B?ekl2dHVDak1KUTMxaCtQZWU1dkNqblFWcDJENkdMeHY3bEE3TkJqYmxuUEVO?=
 =?utf-8?B?Z0M3ZDJHaFY2d0ljSHZWelF0WXhZSEljWjNxTVI1R2c2M01nc1BIdGE5V0Fv?=
 =?utf-8?B?YXNwdHY3U1lscnRvL3RlblJYZTlvUmYxeFhDbXJ2R0RhcG9uNUlmNDd5QlNv?=
 =?utf-8?B?OXlxVVJYZlRCRTR2N3I3YjVvWVNxbGhNSHF0aTB6OGhVc0dJY1RVaUlZVGo3?=
 =?utf-8?B?K2FDVFE5QWZyYWJwMHA5bmVzL2RZa2tvWGdFQ2x2Um9HVFU1eFhXTVNJeWhY?=
 =?utf-8?B?cFQxQWNjZjlVZ0IzTXhkUWVVZ3JNWVpHd1kyb21JcVc3ZFZXTm5EMlZUM09X?=
 =?utf-8?B?RjFva2lkRHJTRHZUYTQ3L3NNWHBPRHhkL1NZUVc2c2wyQ3JVY2pLQVgzU0Fw?=
 =?utf-8?B?U29XSkNBcHpWZHlWK1BOS25IaHdyd1pZN0tNYVM0WXF3c3lPRzFYRmhrdjVM?=
 =?utf-8?B?S2hvY1lvTW9GeEM0ZU42SytZb3VFUktzN2FRKzdwMm9sUjFnUEJtdEMrOXBt?=
 =?utf-8?B?cnRZdnJ1TDRBY0NoZy9uWFhpUlVWSnhxOVZiQllRSmFnVjE5UnlSWGY1Z3pB?=
 =?utf-8?B?dmVxSEU0ejd3Skl0QWtPakFUSWtScFB4c2dIVjFLbEQxME80dElxMGtkYWxi?=
 =?utf-8?B?WXJ0Y3gxckdYeEVlK1hVUnYzczd3UW5UbXJYaG93UTR0WkxoQ1ZReFBpRFZs?=
 =?utf-8?B?WEFJNndLT1lXNHhzYkxCaHNOamRlSFEvK2hwSE1Zd2h6RUhaeDhvVloyWTJ1?=
 =?utf-8?B?WlpqbU5JSlp0NVN6MTMza1FQOGxGWWFXWmlrTnVXWGtPekN2alZHWmZMVUl6?=
 =?utf-8?B?S3JVZkYxVHQwcGZzTlA0SmlkbHdicDRCOTBBMzZKYXhQQ09uSzkvZFVXZmNs?=
 =?utf-8?B?VG1ycXZNNG1hL1YrU0xTclVSZk9SN0Y2K3JKUHU1UWtTdlZlNXEyalpLdFc1?=
 =?utf-8?B?Ym0rSnFQek5VU1VyMXEwb2EzYU1tTFlIZTNTYWVKcDFxV1ZWZjVSMDY1VTRZ?=
 =?utf-8?B?VkxLbEUySFpKLzZ6Szc4eUo5cEthQlh6SHJSNmxmb2hraEhhZjFSMUw2WGZS?=
 =?utf-8?B?MjRLdjV3MlJaMjVBNjl1bnhOQm5yTkdsL2tRRVd4eThqZ0pHY0U4RlNZczNo?=
 =?utf-8?B?WTBuK0xWQlZyQWZrQzVBeTRrdG94ZFZ5ZW9HLzM1ekc2SjlIaXhvMVZKVFhl?=
 =?utf-8?B?SlU2UTN0YzZRV28vZ25CT3VHbFhQVll1TjF4Sk42aWRtbzdXRHdVN25aZ0Jw?=
 =?utf-8?B?Q3k1Q3VqaCs4ODBZRHVXcGNQdXVKT3V4cStrVG92K05iMS9PZzJuaGM2b2ps?=
 =?utf-8?B?V0d6RnBOcGZXNmdWRElqWXJJcGlvSzJDZ0dDS0ZDWk1INE5UMFVyRDRWNmcy?=
 =?utf-8?B?R2ZWMjkzSkxyYWM0UkhpVWl1WmxVbkVMMEE2WWVVb2Y1MWRyZEVmcVI0alQv?=
 =?utf-8?B?V2ltYUxvUzNmbkM0N0tvZ1VOcVM3NUUxdDZhWk1rVzMwb1VYbFNVSjNPNGd5?=
 =?utf-8?B?OEgvd0pOUEpFNm84bVA5OURHa1NiV0RCSnJ1bFlNMllINHo2NTdWOVJYam1h?=
 =?utf-8?B?ZjNTR2F5U1FtWk5KaEhObFlnS25KWnhpSkZ3Qk1Pb2VYVWViSlh0TkhaTVdZ?=
 =?utf-8?B?dnRHSlBUOEQrMlQyVVBRS1pIU2NlcGVwZkQ4cHJnQitxRG9BUXhpRTJ3ZFNs?=
 =?utf-8?B?eisxVmFSbTVmUFplYXdnM0QrSlAyK1ZOcFpKTDUycEl6SFNLUlpXNThoYk0v?=
 =?utf-8?B?MXF0WEZpNEtlSlVERTRmZXZPQWxMODdyc0xkZ1pCb3F0T3RJbXVyeitQODRR?=
 =?utf-8?B?UVlvZzlmTmFiejcycE15aGZRMzRyV3JNUFRxNG80eklFREt3RDJxNkNlQ0RV?=
 =?utf-8?B?STN1UTV0L1lZd2lhQnkwdTVKZ0xTZnlDTm5ndW1Dc1U4U1lMUUVidDhKaU5X?=
 =?utf-8?Q?fshFTZtNp4MxSeOKv5xqyauuJw2f0VjIqMUCoEZMuxseQ?=
X-MS-Exchange-AntiSpam-MessageData-1: zqQsvNzwEvF54wr5Dnvco2K03/qhQ/wLWz4=
X-Exchange-RoutingPolicyChecked:
	koK9H1yWAHpnSQS2IoJpFWclq0Or1ZZjAdfoITDH3UuArV8E54VpTJvqBTjdodaoNoEW5dbJKiComL746PgyPgW4femxRtboGlzD0ccmQ7D9LuxXDh3o6YbzlhhAKkQ0BwTZlstR4pZiaKCacVhk3VLQ13E1xWnXEir9fQ1WcaKoHyEleCqTIeU/MvPFhQIFvS0S4X7RNeBtZhDh+0Qb2YdUdJqsXkW4ZTSqQR1I0Ua5KiuC52bnyGc4kDgAY+8OwvGaCj7IuvE+AHLzs+rXvqhm4OWXQTUT5SylQFLWd04qLcoHuYRtIhpGve6ckjrTpcmMKsbnpHiHRrw8QJlM6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tAYO/u9QVSVNYMw+ERgg6BOIj9foxjZ5bypD0EhejGVsFremweBNfaO6M6QMMc2XTBBP+zph/e4qREntAP2UYMXluu8C/bmWuYHJYh0+NrZhIQ5BPWLgoiqYZk5LrRs8dHf9Cx53VG/Mf2ocEoyYPJRDp/Ol/kJJV5vzlOV3xWAk5sJjqSRhwiarS32kEICk9euxx5ZiphvrVXOyDJioGf8P43998W5HAFQzqpCwE8gEJm6TXov0ZjJqfud6KsscDsbtJpKh7WBSMoLGZQw4AvArwvyGydeKyndZXNkn4Vjm3cHqsqWJ+fkHkobAGVCjKZH6eI+a+rS7TxHY3SKZ6Ymg98O+f2Jjpy2E7D9TdzSFIV0f3/q5iXxHYiX+Ot34PInFfPX1xzi+nuQqCelq0NDqpW8WBCzrUSBODIPkglDlZ2xNHfUuFuA5iL1Pe6nt4y17kYD6lRf6dohWRIOWd8UHpd2h84iKhfAcyT/yykxVBI9VU6ZrZsg/QLz0Q3NAE1omDVB2QSoHdoDMw9e7UDuHPmKfn+rg3wr4dh4cArSMiT3g4xZwL4iP6HcXvMpu+c9nJ/ApGYAiQKkadj0aP7iSp7DuQ6o1RKia4p8kgol3tfRgZbUJ3IeCuePgM+W5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14463cb-b154-40a3-952d-08def859107e
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:04:14.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8MYzEu7SBXLaZQ/rTQW8KibELMSJotgV2PbBftVtapRr4Nm/St+ZVp0rGzKzSMxhSPj8XsZ7jtEPAA4ahQSfXb663l9MAJxHvrNz2/v+IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8845

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

