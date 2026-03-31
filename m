Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F53EBF3F
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949241; cv=fail; b=MCIbYovhjl75M3Q/OG2fCMHa3QSsS3ONCf0dOFHi6CxtJVBiRtNz0HMeilFQ9F8PHjlF0ZfZoeT3GHF4U4eFcU59Ah4KI3bl5OkPuT2Dvihr8K7nuA+FXhsEoIEzvgWh2vorwBFUN5xfeiQGqJXmpjoiRuBb0Ko7BxglNo4CeHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949241; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Itxq/hNRjZZf3N5LThWZ9Fj/J8Zs4z4/EEY23lJkHhUeGbWU7Hu7EzgNEsL3jJi7eorvIymbjTshSmmZG+A1IwzN11GUHnGzFdiU3/L8iBLnPDukpHbQfqaoIqRQJTtar2qINw+KYg+U7ewy2s8MPo5v6QClE++pMwOEVaWth48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c9zN3wnH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QdcD2NL7; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c9zN3wnH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QdcD2NL7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774949239; x=1806485239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=c9zN3wnHA0/Xim3AcMr4+L6SNxPeVWWMn5dS1FMdqaPhq68kTHtbWDw7
   l4bEDOJCS7auBd/qYxwBrTtD/J/cFPvg+W9usR4Hu81BQ+LLvn4pRDbHk
   3RApGzSOUw5I09+KPHZKRDi74lQ+XS5uNfn2HWgGyVg91XAXH6yc9Dbj0
   unVfOfTGJN3lSGVNfWzVtaBAayfQUUCLIR8l3K0NuzHpn4PemIszjTxpS
   1IfgrJ+TmUnGwvSpv+25cby9K8qsvutgnAe9RnFTyJY1P3bB8YGFsUOgR
   GgV5Wly7olLnXUKPsuB+ad6hqxGdcNMyuSe3PTgAUnc73rEPdPgQqbOOJ
   w==;
X-CSE-ConnectionGUID: +T4fehD2SqajUlMg3MivUA==
X-CSE-MsgGUID: jFFSIhk1Ti+TZbvbRvYBJw==
X-IronPort-AV: E=Sophos;i="6.23,151,1770566400"; 
   d="scan'208";a="144084894"
Received: from mail-northcentralusazon11010061.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2026 17:27:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXPWBBhfCx+ckbolb8lCKflQ9EFK09xUkkrbPHFeK6uAyqxgvAmPBais06vrar8e8ILZZfww29hqmTMcPONqLodMIZymxiHnYnpWyYLZ2GKE76OJIx31jta+7tjkPIIo/HphgsIQ+zSveeiKbukYNh3X9iV5RqewArA6ztoBVhYF+CUB/x/jPSzmOq5zAVSMZcO0pFMaB04fVGvoo9vFDCEeM3DL9lhVGrfKOLCZ6QU2fg/itfNjJdNhfSnxzB4oWYRy1AAD3BuUgD1Ni/CKqTQE+80QIDdZC1TvU0BvD6ENRyTr0LC7Ma3xsnHiqOMnCNSQB7K1l4hwYWKl5LM3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=xtoK5KRQSE3syoEIq4droOyFq9IQBVZeNQTTYgi6rqhtq/lsk8qJ3K1aDnyLSPzaJdJAWzDrO5J5m99R13ibQtXb3H4+DtYO76PgLXXJHgW3RKbpDCtgiluLOWM8qdCmxa2DpBqug5GwWhx32tqF2uU+b0Ad6JGZSLHtMsIEzdYt6mNu7S7fUgAAkboRTbLf55Pf0R965IIg7ik1V1sVn6ZQE6JI1fYWgeeC6YBtYMkNqow5zE1S6O05w3MMUwx/qz8gxzGvaA9sYHjIC1GKGsAEuc3j+Q7HnFc6uXKBbM7lZSedpIiNJn6lrfA/+OvVqCIsHtEZAwoL6o2RDn5y+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=QdcD2NL7OVIgQC4880QNcfuNoa8zjV1bkTpWb0eivVi1TeSLAq7UDED78qHS3kRJSXgwSIqP7A/HPEyqEAok1xHqECeqqdkeMEfsv+2KGSKUdsLkR4HBIhhrzNAPKDH5v6Un6Ul28kdAkL2/hIIfjRI9DXN/HGQl7L63jzFTUY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6831.namprd04.prod.outlook.com (2603:10b6:208:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 09:27:17 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 09:27:17 +0000
Message-ID: <89819f53-92e1-497e-bc44-cbb362014679@wdc.com>
Date: Tue, 31 Mar 2026 11:27:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: add max_open_zones option
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260326203245.946830-1-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260326203245.946830-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To LV8PR04MB8984.namprd04.prod.outlook.com
 (2603:10b6:408:18b::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR04MB8984:EE_|MN2PR04MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: d06426ad-e8d8-491f-4ded-08de8f07b343
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|19092799006|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	c1AbOMdy2jkpC0xTG1jLI2IvzRcB+BFHYnyEv28Wr5tzf+78G5iF78wSIMYShqvezjhjihyCTo4lYVY4JWH2fKICjLp+kkQbaq1BJREcMpS6mooJrCSEpatzzNns9zwfmxOHcu1KvWkrlgprRv+ULTqZC+VITNM8f9nbPP+fJMcPCtfqoYMoG7moX7DWIDbh9IkLW5eExAQuATBY0Qaj9mBr67aqz2Dcjb7tZhd3bf6atz4BpCeHsrJIkoBR5DHmwbjtcvROl3BSi7oZY/b3+hplAk3xbtOBdAfSe0t8ksmG/ioHL20u18XqTteaoUpNveqkMJYtd6Y1hwNMjiKp7PB11YoYuec4MQMGSf0iC65QYnIJWSOuUuubVoecQLnAgca5vESfwYw+6xXrvoWUrBkHT3Qe97SerhyN4cSpRrK2nHnvqu8/OV6t+XiY87QEG2bpvCSSPZGsVd+inW5vD5+DbXufo9EnFyH9vg9d2ZFdpzn9jIy0aTxum3rOGyYjrSj9xAcwZ5DB90SytPor/k1waKXSDYJ5cQC2foRsIYsq7JkHY25YN1WKhrYVp8OvSdsalI+Kmx+XuAgCLPtvKaKZ8Yj1cyoonlIyfmUjZ6NhtO0wbH1sye8A+qXgS/8xbt7Ta02XKZG2AeT+KrqzSU/pWxvunzQ+dsTm18bELHBc97c3uG2q0yu0ObCJfuAroWhsQHj9F5sQ4TCznAB+ek+3uLbvYMOcQ1H0KlGgEMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(19092799006)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEtUN0NqcHN5T3ZqMy81WnNmZEE0dFI2amdLQ25tVzVTRVZSd0FSK2dsMnZY?=
 =?utf-8?B?U2pkTnIwSzhiV0t2YUJFeUp6SE0zeTFsVnNqbHg3Z2dQaEZ0QmJsdWI1RzNk?=
 =?utf-8?B?ejhma0JzeVNUSUxMZGYzSG9Cd1BPWXlJZTdUaWZuU3FFQXNQZmdIZlJhVGNt?=
 =?utf-8?B?UklGeXg0dFpSR1VVY0V6YkFkWEZZdlVpVExJNXNnYkZQLzg1UzdIRXVMSnNE?=
 =?utf-8?B?S0VpMGc2MnFBMnpoOEdld3VEMXhzRDRtcXBVRmkrV05Bd0JKckdXbHAwOWJl?=
 =?utf-8?B?ZkhUTXRBbS9uaGl3SVFDdmRqQjJ4RHdQSlhMU3N4MFJGbDFQTGdqQ1VsMTJG?=
 =?utf-8?B?VW42bUUxZlVIcVZ5RndsaU5XZThDVUhzSkFzeW5Tcnl1MkNZdGh0SnorQzJy?=
 =?utf-8?B?N080eGxqSVRzT1hLUWJjb2xRLzJ0KzNPd1NiOHQxYkFqZ0JSUllGZzc3aGpi?=
 =?utf-8?B?TGZEVWpjT09LL1NCOXVXbHN2Nmp5NHdDOTd1YkNyeVNZcUhid0c0MFZ1UUZ0?=
 =?utf-8?B?WTIvM2JoSUNndGRtNnN1TzIrK0JxMUpPcW4wMjFUWXFMd0xuSWlXVDBlMFdT?=
 =?utf-8?B?TGE2SEw0WGdjdXB6UnlrWXZyVktJUkpxeGliUGJEZUdxMy9ldVkyNksvV2lQ?=
 =?utf-8?B?K3l4OEp2dUZuQVVOY2FVcFFodlFibG9QUTNRWGloL0ZOMWFsZnpENnlhSndu?=
 =?utf-8?B?S3E0SS8yQSs4MXhVbTNNWU15Qk16UjM1aTlPWmJhR3Z3b0JtQlp5R0lpOGxq?=
 =?utf-8?B?SmtYdTZDU01aa0Y5c1d5R1ZGa3pML0RQS2svSEZ3dXNUNjBsY1J1cHlCTTI4?=
 =?utf-8?B?eEh3WmQ4UVlyNXp0bWt6c1k2OTBMcytBL0QzR0Nua01PZjUwWUFhbmpxaUlT?=
 =?utf-8?B?dkFzNSs3M053WDZ0Zlo1SkhoMndJbk5pWlZVTDAxcjh2TmpYV3JXcnBtb1dY?=
 =?utf-8?B?bjNQSUk5V05nam5hd2lXeG5wODhxdlo4QjN0UGkxdlN5dXdacE5QRGxPbkV6?=
 =?utf-8?B?WDlhR2dNR3pWbUtuMy85eFN0VjlVNndEM0xGaDBmYXJENFBMUWlidGx1NzY3?=
 =?utf-8?B?RTF6L2xSbER3ald2WmtLT2w3N2tJZlVubitPa3FBQ1V4a0NGOThPY0JLcmFN?=
 =?utf-8?B?VUdLZytxZzBxeVl4S0QvT05yVkRIWG1YSm54Vm9QaTdRWGxzRGwxTVQxUnJp?=
 =?utf-8?B?VzlmWEZoZi8xOFNKVHpsMlhSaG5SMGFMWFpBNFlRU3BLM0hrT2VaZDFNZUJQ?=
 =?utf-8?B?RzNxRUZLeE5WMzA0ZzBxblpLTU9qSmI0MllRNUhyWjVxQlZIQ2FKZ3V4NkJD?=
 =?utf-8?B?QnpGKzVFZExwYWZEOUVTektWRTVRZ3RmRUxnUTZKSCsxNXZLT2JUQTZBMzBz?=
 =?utf-8?B?UElhMnlnSEVZa0V0aXNVNEl5L3J4VFlsSFptL2NDMlFJZ01ML2xKc1BpM0RF?=
 =?utf-8?B?WVBrODdPbS9JVnh4TWlObWVEeHZGMXN2cks1a2wwVXBOV210eTZYaW9TSmg2?=
 =?utf-8?B?UlAwek9ja1c5QVpBOURPRUVUTmlVSzJZMGUrSGRWT1JwOFg3QjdSbmhIVnBx?=
 =?utf-8?B?N3pOa0NwOUhMUTd1NzVmOWlGVmNYUm1GdzQvRzBXd2haL000ZEtFSTlDTHM0?=
 =?utf-8?B?UkhXbzB4cDBHb29YbkNPQmlCQ2kySmhCamRweVN1QjRuZXRKa2xVWWVjWXVx?=
 =?utf-8?B?NWw3a0ozQzJDSklvQWVaYjdHM2wvckp0d2ZIazlPdk53VG1XS3dPTnNONjMr?=
 =?utf-8?B?ZDJiNm9lcm5ET2tkZW1XNUZXell2SUdpcDFLd0orMkJRNHhFY09FdkhJWXky?=
 =?utf-8?B?UkQ4aEZvaFlIbVFJVTBBVkdocGY4RTljWlZWOXB2NGJMamxoSFpjNjNFNkhG?=
 =?utf-8?B?bkJvd0J0aGpMMis3eGVYTVA2aGJ1d2V4VEFzRXZiSHBLWmtWa3hFZml2NFpL?=
 =?utf-8?B?RVhpN3UxUm1kRUpJV3JMWjRhS1RHa0hjNEQ3Q25pQVJadW9yM3lZZ3lLZUkv?=
 =?utf-8?B?Ull0ZlVyNHpJWmhTa3ZkNVpGemNEdGRsNVNHNzhoc3JFMVBvcCt1S3J6cmxi?=
 =?utf-8?B?ZkZ4RTI3YmxsK0ZVSWxDUks1dnRvQldFd1dWejBrWWpGck1sQWxKa29QWUV2?=
 =?utf-8?B?SjFlZkcwdHlKUEl1cll0bmFUdyt5ZW12LzR0eGRIZTdFc3dpY1FzVG5Kb0Zw?=
 =?utf-8?B?UUlrUlBzVTlJUE83V056SFpmK1lmUHBZUVEzaldHNEp4OW51eUJBaGxsWDUy?=
 =?utf-8?B?NnVxT3JmK3lVOWtwMmRwenFuUVIvZWs0OVVpY0NiUCt1aGJXZys0Q0RpZHRV?=
 =?utf-8?B?aFhaWjYrQmZNcXN0bnVLeFVnSkFUNmZRZy9iZDhaUjVZS014RE5PM3NuZWNP?=
 =?utf-8?Q?kMfPl/KqOf3wP4r3wTgEnxx822kjAQiE840Vz/2maIJSR?=
X-MS-Exchange-AntiSpam-MessageData-1: sVDRgY13Yx3LUTFoRoBgMJZNZdLoMpXIde0=
X-Exchange-RoutingPolicyChecked:
	iQz7Lw1RcRf3E5ewaZN5Kqys3XxaiJWf4qfiHZcsYaJYMOGAY6FKBqb3WCuSRINE6261KLMzrJvBr/Ue/CLWevU8RuZNKtSCfLU0qmYkUznInXmAJOoTfz73reNK1gmG0uOh+V1cVI3WS0Rlz6FdFs7E4LCY/uOY6WOKmAo1Lqx8ogTflj/5tHQP2ujs1emTqxPTe5sGGJT9d85m6kOufYQ/KtmEJRxPk7p/HsLG6ZG22nhyo25glDV9jBB6MHXnl39uZclcYMi6YSJTFHYYyOfALK+Rf0a0TKeJApuiUBhqTcfHSmQOJkAOuuDjNoM44D7o7yXjZXAPCv9ZkOce5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4c38I77sQWZtm+NL2gQ4ADYORZvLQL0JGN9gd/IozYxqN7+kH1HEZnTR9sVo/VDLrArAmjwtCjhu3N2jw67innQaHHvvSyuARAdIbU05U2PTMdQ08pvE0n4yC1qfYyXP84XNRvdYIUWkUmiAWVaWU88I+aHwJt4JsXeVdAlBJpF/0gfOgXKvDLrXLVx+793VXXExRtPTbJGjOr2ZBdvdkCOCdhBTfLGL0tWiPYJwKgYax4wYZbI6seA8BdZ2UdF3XHeof+JnZMw5d5ra9IMq+AjX5ozXeAs9BhFewTAsspsWSozZkyxw6sCIxGhdbVjO7VAPUwznaGCV3gQ8X++lLi7DQHYlxw2geFIlqui5xwM5PigUvqOEK8x/P/xwhN1fNzw8ksG/dfiMv4R6Ix2SpQowidVENhZyBR69M/0b6Hx/QoDDev+yk1R2fTgnRd4w00z8QpDtywCHcykcnVgt03xNVPkiP9dbUYiXDuxnY/04E+GULCU7Ri/I47MJqaOdn6LUCtqhX5qZz1RVzWTJTRDKPzgcqg5457s8mRgpQXXZIZfw9GcyZF6PKpW1CfgpSBbBOZaEhEfepApqO7B/TORd7EEfZr8zWQhxCCuYbtLoq/V7UU9bmPnQbMgEIvzP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06426ad-e8d8-491f-4ded-08de8f07b343
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:27:17.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fjUL19ILIn56rLgqu6zmqwSYTlRYCCOr2L24FTsbORBijKi6yc7c/of61RRO4k1FPrjx91HKAaUpBiwCn6tQ1MYE+21uXgIiWHyctcDug8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6831

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

