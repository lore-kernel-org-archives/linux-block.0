Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F2374192
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161623; cv=fail; b=SyGQ3D1kjS/MtHvE7grMI7qUZaqOwvNlpAODVbG7wYMnCX4nHMs5GblfNNsp6iPUfwYtqynEuwqHPAQ89+lTQb+kzLCAkWeXwLtZrKt3CDk6CuZ/v8JiCPTwVoDu83c13PR4XIEQUuE8OG56Ez5VXKWkXq2vuCOXd12D3z14oOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161623; c=relaxed/simple;
	bh=y5b4iGQ/J9DTPRmOA8R7f4cmhApCSdyq1lJZXUlPkCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KdboxbIeh7iKxD0Xdbl2+fsRV9wvveOOe6dcoq0ToSle9sIhhT1A2JnPnhvOx5wf4jhGDy2/0Z41LaneDGzBBdrjkFTLyIvel26JLtBelG2lmon/i/JCZAEs9WGItfUJXl9/9BFQ1Qs6zADyu6pK62b89lfOY2fL/cMkGKWV2Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dlJ2p3DR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fBSrPviN; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dlJ2p3DR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fBSrPviN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792161627; x=1823697627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5b4iGQ/J9DTPRmOA8R7f4cmhApCSdyq1lJZXUlPkCE=;
  b=dlJ2p3DRIXYAFIMTiGUmboCf7clLV4JLdtet9FHWxr7i4ABrYwM8zsLJ
   jziAU7klBLEBAY6EB2X48v6+IBrtNaEV7c3hWG5/rheqMGPkDL9YKeIIn
   RtckcQNtp+1k40C9Muq+rtLVroc0n5/gC3bqxI3sQeCA2Xpw9UMjNy2lc
   EbbDPjRfMvkIxmc+UzBnzuGJLSfS9ORHv/oKiYbWDqCvJkSP0kbC2raK6
   aoqzGRDwnwHf47wXUdm+CxSSiT13RE7P9y9tWtfAzYPpL+w3cCsb/X8PW
   cUSUjahjXSZEvA4HOtP7+Ge1FaWPW4Uyy6HpC3aIX20lbbgpvMQ7Peehn
   w==;
X-CSE-ConnectionGUID: wdGrJXgMT1+IflDfle+oMg==
X-CSE-MsgGUID: ydHIUo9FSauGNnRIzv+OhQ==
X-IronPort-AV: E=Sophos;i="6.27,161,1786982400"; 
   d="scan'208";a="158163437"
Received: from mail-southcentralusazon11011010.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 22:40:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdPw1CM55EWMDdqC7I4cEKHO9l4qt0O0rUqnPFVAXeq+0mVI4wzPGu1F9XnL9NH33ZLl6kBq04f2MSu8ZgXNmeDbxzsM9U2h4VujYtzh+jeNawI+qCTUKLoSkdODLynbW0P3LSYAfXxvyy0XMDG/RGjSFdU9fWtlsSTiZV3kgwf0U78FMwcOt2JQ2tNybZE0gq5hiaWwVu3ZiHkqfd8iSl286/69UspreGAuBRtmgD9cnA8ywQ0FCaz5IGvKKCT2oHuIFwVZzfffln/EgikrcNNwrjrumbzQDuHUmlhfgA8AwL2SBRgasIFVb/xKVrRmoXD1N41KbaRHPB7lUoNyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RozR1UpZwZAYNfDYJ1GECuqx2nEwAE0Qxuxi50bk02c=;
 b=LzmLpeyGX2gxOjwQjSomycPouUuexIwiGaOD28d6lSJMs8Hp2nR9IBwLgo8eHgDA/8SDaXeqP3w3dLqsTYasp1dD/RnOSULD+3ioCAC3zSK1yMkp3aBLZ+Gp1nVMfgOdTLu2LGAwldgIhsKHEn35G77IhoMMnO8K0LovQp+uxlZn/XxMpJRlIEJHKlito54XnXJbsEsjPVAwgzybwgxh0NzUlPVTv6DYulUeujoF0BNqC4uTES8gLz8RoOhJAu4uruNdFh93dfgkG9n5jCESy2MezzxA79G694yCA7bf8hYnrjkF+bnpk69FdDNKP04QUg5wvFJACBvI58Sm1woc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RozR1UpZwZAYNfDYJ1GECuqx2nEwAE0Qxuxi50bk02c=;
 b=fBSrPviNaiZdCWIgNUnuh/l78Q5j4nz7eg848/EhgSpVCGlsN6fDJoxiyEYM9Ng4gpkJismpto+Hz0mJfhOMeb4qPPPP3ZPJKrl3VZzqPObhA+Z6lU0S6oDlnqV4IocGEjjJ8St+2qZD4gchya88wevsrWUcolf7Tt8pyju2uik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by LV0PR04MB9838.namprd04.prod.outlook.com (2603:10b6:408:334::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:40:18 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:40:18 +0000
Message-ID: <237f8537-79cc-4ac0-83ae-31ea0d51e0b9@wdc.com>
Date: Fri, 16 Oct 2026 16:40:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: print device that had errors
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
 <4104c9c7-2df4-4008-ac2d-0c999bba98d6@kernel.dk>
Content-Language: en-GB
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <4104c9c7-2df4-4008-ac2d-0c999bba98d6@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|LV0PR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ee2ca4-9e49-480e-096c-08df2b93658a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|10070799003|23010399003|22082099003|10067099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AOsBehkC1qGQx2WTf5uB6sm0EKZ2X+h6UflG+QJfegrtv67Z4u36i8jRQw7AgHNWZL8g8fQfhwuEVq1zwhYVEAxaRFX7OWPhPuM0kdWVurf2Bap7I8bfFAgmSECrwwO4sdRrbIQx7/8+AL7bJiBGFPEK4++8ndnQ0dtz9+2+jJNNrTfJePibLFgAoEiOhkqu9FRgrx4WeTVgTztSE1Fl2V8km2YsnuXDZNVVezf9h/KbHaaHD7gtB1K9bQqbPqH/tPcw7aBXdexSFo5cNCsbR6iRLKXT2bg+9iZl9yTK68ylylLnq0uHmhx3iVeBgyqAzE675pHKT3WDSxRBzeYoxRNMvGN9sQc9bAwfr5KbdVhG3dd+SvRCOIIqQW8EPCbCwaAVpvHniuMLEXJEumehHQAhvIeGr1VSlaJaQzbOaymUVhhzZuU9IdnvQc+3Lkg8Ee9J8K4LaUqIaZocRLXdOtCOXmETimRv97jtmtowK48ph+Z9d6eUIG7eeCNI+IAh4HBwjNvytrb1D6Lj2LbSOHqWqOkvvGajGKpcP3wvXZEK96wFdxjWdGQgVHK87MCmK9EkTb7+V02wNulLlPvoJ5h0Tf/p1L3EjSNEHtpvzbwaxxxZFazbneSUDUfjptWmMLknTv4SB1SsmZAaTb3HImafaCxpMim7/8SMLsJfBF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(10070799003)(23010399003)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1Z4TlhrMkhHRWtDQkVaZDNlakRrYjdGWnk2SGpwZlVOZXBMVFJFT2M0UW03?=
 =?utf-8?B?Mmg0ei81eXFseC9LZWJXaDRxQ2JPUkFtRVNmYzFjYzNrOXdaQXJGci9nSk1P?=
 =?utf-8?B?SEVHckgzWlMxZmI4QmZndVZFT2pmNW1wNGdBQ0sxOFMxNllpTU8wKy9wTUFL?=
 =?utf-8?B?M1N4djRTM1BkWlZsUm1HMzQvYkozMjBDV1RzaFhZZW81aUEwUXB6NWU2ZElW?=
 =?utf-8?B?d2g2M2JhUmxYMFpiMHdyZEFuNjNDUGkyMmNXK25rMXlGR3g0TGU4VE9TdzBl?=
 =?utf-8?B?TDF5VnZiR2dUL0ZoYXlrOTlaWFRrcXRERnhNeXRWWFlQZmxjUDVMdWdaekE0?=
 =?utf-8?B?dUtKbE5XcUFHalJlVDk3UE1xVkd1SUUvK1g5c2o4NnZnMW9xZHJ3WXRCTHdr?=
 =?utf-8?B?anA4M0tlQzFlR2FrTS9ENXpqUURML1ZKV1Frc3pXNXJldUxsbC8xc1pzbXhY?=
 =?utf-8?B?NDlPaU8wU2dSVHhTU2wwcVA4aVNrYVVVb01ZMXdTMmY0NHZuU0dUUUVFK3U1?=
 =?utf-8?B?KzZ1YzRQMm9hRk1xOWk5WVlXZ21MNXhYTFR5d3ZObE4rRzRWV21hTHRxUXJl?=
 =?utf-8?B?a1Q2Kyt6ajd1UzJNUU5xc2YrelQrU3l1ZTVtVkgvKzBlbnYvb0RsYkFGbnpi?=
 =?utf-8?B?c1VOV0gzczNwNk52ZUxKdkNnN21jVmZqenB4SkNManBsOVNua0N4Z21hYXlF?=
 =?utf-8?B?MXh5SnYweXFsT00zNGwweFM3T0tvZlVmT2hCNmxrZlAyTmZmbHpVVU1FV2RV?=
 =?utf-8?B?WC9DU3YwTUhwQktWM3E0RXRjck1PSXIzMEN5YUhnanFSSzFFaG9TczVhbkVj?=
 =?utf-8?B?WG1LcHRDdy9nSlNMcW5jZjZkQTdlc1JhRlgyWDExUkVoVkx1cEx1VkZpQkx2?=
 =?utf-8?B?U1VJbjJnK1ljU2ZDSUxhMWtpdVJrTjhON1V6bGZSOUJ1QWN4TGxFOVdzdEJl?=
 =?utf-8?B?YnRqQVB4TkxrUnl0dk1YRHRlN1pUc2hTTHhKV2RWNENXL2RkZmMxT21OOGhy?=
 =?utf-8?B?ZG03UFRWcWtINjVudktmVjF0ZC9tNHdQT3FjcTFYSC9GWVpDV0V6WE9MK2xB?=
 =?utf-8?B?ZkRhdUVxdVBYNnhxMnB3ZGV1eE8rbXFiVktJZTI3RzU5eGxnUXh5b1FaYnFT?=
 =?utf-8?B?QlJhaDRydXAxemNoUmdzK1BmaEpQYVlyZmlSeGp1LzREUXY2M216WTVNNE9a?=
 =?utf-8?B?NnRpRHZ5bEdvZ0hvaVJhdnFFZTFJTk44Y3ZJbjF0ZHQ1eDgrT1JzNCtDNC9R?=
 =?utf-8?B?dStvY1BxdHdCWGNsVHc1aE9UUHJnbnBoSTJpT1lrWSt3RUxHOWhOSzBtQjZ2?=
 =?utf-8?B?RjdZeVZ2Nmp4VzE0aGVLdFVvYmdQUWlIdDVpajhKVE53TjU1OTlKNXNRcWwy?=
 =?utf-8?B?NExQWnZMV3RNSC81N09VNTZOSTloWnlKMi9DVmhTcmF3Mi9wUCswanh2a2FX?=
 =?utf-8?B?OXQ3TDZ1RnhwZWhrc2QrMm0wSlluZ2RGc21HV0tOVFd6c291Yk9zeHlBVVJL?=
 =?utf-8?B?YmVraWljWkFaV1k3Nms1dk1TL1NkUmhnSmFGRHY0U2RTTmZJQ3BIZzd4MU5X?=
 =?utf-8?B?YVdhQ1F5dDBFVU01SkpHcms3SmVGTDdsTENHZ2wyS1VqWkh0ODBCVGtpMXlv?=
 =?utf-8?B?c3FoZmZOb2lmSytWdVFHWTBLeHB1YUlaWktuZGs1VUdYNm0zK3RMQ1EwMFRS?=
 =?utf-8?B?UTNyeEpkMEZBTFBEZEJWWnM2NXQxblBDYThFdjBSaVR1TzFGOHd5NEsyWDhk?=
 =?utf-8?B?YVRLbUp6S3Q2dDdSeXR2OUYzcTIxZ2xxM01zNnV3MkV3ZFNpWFpuMEJPUWRY?=
 =?utf-8?B?YWt3bzBiS1BaOU5IMjAwaDMyc2FVMHlkSGxlSnpwZUIrZVF2TEpWVXZBcE54?=
 =?utf-8?B?UUdVZXlZOVovWmJwa1RGQlVncEdwOTdFdS9hSE5lV2k4WUd0aDhyYlZUU2JT?=
 =?utf-8?B?T0pkWFloZWkxcUlQWHpuQWVHSWNZZUl5a1BxS2N2MkxlM0ZJeEdkVURoWHpU?=
 =?utf-8?B?MVNRamdLWS9sc1BsMS83ZVg0K0lteWdhSmlXUWFvQVVYNWczNjVicUxRUnZx?=
 =?utf-8?B?M2VtYTJueTVQZEI3YWxnaFRtTWt5TXRYVFMvKzhoV2QrM1ZPaGl0NDJYMitG?=
 =?utf-8?B?VkhBa3JvOGFjWlpJazd3ZU14VEI1UnB5SGRMamgzbzJpRkxpOXdDWEY2cXdw?=
 =?utf-8?B?NkFwUEloRWZOb1F3djdTMG84Z2tDaldaM0NzWVFTRHFaVUVpTS9JNDBmc1N4?=
 =?utf-8?B?emtYRXdSdVVyUy9PVlhNQVc4VkxUQUM0MG9OUjVPalU1d1FrMWpnaXZFSFBt?=
 =?utf-8?B?bGpOa1Z6ZnRxT1hUZE8vNVpMc0xkWU5DQUdRK3BuN2V3VTFlb3NTVGNhWnoy?=
 =?utf-8?Q?7qFgm605nQXtiEzJnaSo+jWuKnE5rDfoLom8GFTky6arh?=
X-MS-Exchange-AntiSpam-MessageData-1: jW3M9gR9TCRl9MsYtJHsM732QzA35HOd34M=
X-Exchange-RoutingPolicyChecked:
	yAxR0D6KSrT4pRSapa2jHvcB0ftYcZsya8w73/pPiqRdrQ997wo0xx2Y4fRig6OZUlgY2U5BX9o2yD7TMt49NUSlDboK0ESXdbJcII0rw5EmYDeNAcOfC9R6kfAjfArJH0XxSfWpTKuUMeZ0FZQ8x4j138IXUckBKeU6KP9WFm93iB67bemKVn/yHgIyQqHJftbMBo8VKZFyZuWWkctMU/lYaV6H0VkjWbFj44hNFH1rLm0nyotAA9jrqbDV8NDyBeMyiADB0lX2S69vD5a/7LY0NTNdGNi7qQWQBtxhuxtMVb5H5UT4WtrH0to9W7LzplQs7E+VCvyQq8BBVxdLQQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d+h9U7Urg8q4Q6FD+wP/lVerMyJz9MvnNNCneeGO7llncNR9wL773vwU525Eqcx+RbksMEUIG336fzcnpVatpnRMoeU9cMgZVOVSV+CtCWUUvnPIxtAzA5jDlX2870MhxBtByY+hlFHTuH0NLx5BocI+nCOK+0F8kFlxZHfaG8iBBqux3U8rFtbRwrRKLaMhPfB09cPJDyFJkYs0rh4VzAS0F0fZ1JlCoVDaLUrdUP5oJER2noPoq/apWFzBqAspPgfMrWwY6rD/b2ohUfK2WEQQsbLKOARprjOo6FIwg/t8/h5bsbSgRhygKPjKefthvq4nlcgb8aTsr8xZ3sUWRNonuctbkVeluJ7LtHTPdKgNVEzCiGZfBD7TyVBP0r2ikP/GpMSnRYVZ/psfPXEiJtkIm5jINzKkoxC8ht2VFbcY1W5tVJM0BaUUHzF/Z6IcWMbVqvO1NL64Uzb2VvW7waRWPcR1+4ht6Fn4ioyTsXYD5kVL2AzhGLT6I55c5Cg3vS6Ouqx38uaxH5CWHEJn1y55VCvIa763dK2bG5W593/awe1OWZawWYnKHL2LUaEKKQMQfMeWUwrtYyjYMEmS1u0S95KuGlq5fqVA3bu0xMkigp2VmOYahfPJgPEm9z1T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ee2ca4-9e49-480e-096c-08df2b93658a
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:40:17.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxL/sp8TA+aMMn6d0sBiE/xH5WxYxiAmFgpsO4pEvatkg7WOAe2AGq9tESNmotuX92jb+VAj67PvZl0cXfLdpLVuhU3212KC+44m2PWnXfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9838

On 16.10.26 16:23, Jens Axboe wrote:
> On 10/16/26 1:30 AM, Johannes Thumshirn wrote:
>> When testing zoned filesystems that span multiple zloop drives it can be
>> difficult to figure out which devices access caused an error.
>>
>> Prefix the error messages where we have the disk available with the disk
>> name.
> 
> I don't know what this is against (doesn't say), and it doesn't apply to
> the next branch...
> 

Strange, it applied on 34fbfb9d8d1f ("Merge branch 'for-7.4/block' into 
for-next") in your tree.
