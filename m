Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD343C079
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536921; cv=fail; b=ibP1EIrPfafIDavdxdWIZJ39weHthcwKz3uqiBPWHr5Nq7Pn02WX9aI1EYwI59luA5g+zc7VpuA3SSRGLA2vymu1SufrezKM5UYdsrALy2LyvHVtX/aLZGyP+Kfpm0qjd5cYnuFYRWfnaEmN6ALhiCeVLq35TtiiGzAWSTv77iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536921; c=relaxed/simple;
	bh=ZMlJseWOAhDM2iSoKIOFALtG+/PsyE0Rviyoxr8Q3Mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KB+qoPqTnL//r5rLL6Ulb43t5C5ZpPV2Ve3zZFZR6/4VMvEmgc/kDeeBLoR9F8j2z3geZUB0ZocLWCwQpLkNm+QbxSoP9Us7Edv6l5grYpwrqxFLMbhX4WEPc2voaFQq729p9Wes3lV1mSOeu81p6Zz0oaJVnXSw33v2buOM8zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GVPphmsq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yNtFKDkC; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GVPphmsq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yNtFKDkC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786536920; x=1818072920;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZMlJseWOAhDM2iSoKIOFALtG+/PsyE0Rviyoxr8Q3Mw=;
  b=GVPphmsqF5MAL07A1a10IKAsf6Sn+1EdfhyMendHLZYEPa0Fl3Q5z048
   Ys5znSR6YdyAW+lDW0D4f1wDX8tLN71O+H4sqxJiMUFmWXDbIk4po9N2E
   g7vbFraWE8GNw9wh6pH82vupzlqvraMWyW3whGxteApJL5kgsYJSwjo21
   kTCKLeNuq/KGa2HdYP1NAUN6U89zqkLSHgMBfUhtqJcalD3cht8T5t7lC
   nVGUTqnSOs377nPwF27X8nGklrvQNovdK4DLsKcGZYEzlc/n6Nv8GiX7C
   0DPp3DoljUEoflMnAR+Ogvsg4fKOhTriloOMwT+dbPj3QUZHMabdFt2iC
   w==;
X-CSE-ConnectionGUID: 9t81T9EeT3KPxLqY2fsRCw==
X-CSE-MsgGUID: XLEVmf+aTJWx/LgTO4pg3w==
X-IronPort-AV: E=Sophos;i="6.25,219,1779120000"; 
   d="scan'208";a="153007711"
Received: from mail-centralusazon11011023.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 20:15:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye3H0hLoozadFZ/eUbe6yHLRp099J29+ZKPho6FEUj2YZNlT0MFilBac18k+foFaTKeJOQg7+x1jlxwjoJe9Nn8Gt0p6UvabBB8PR/vzBafQ2pAERd+uXaLgZFqGQvW/vndo/dBfkx+9fzquz0sQWFjcnv35pmtTswSOiLf62NqsKf8nW1oMX0g1Eg0GTJGeTsAYT/NzeQl6xt0UiCsN8j1tkDco9kn9UuV/ge7KRdBzZPB6Bwe0r5sCNgsStZnrJRZX3lAqTlhqiYISjvOfHdmVHv70rBnrEUWpkUsAsVDr4kpYN2D0KIvFfMRerzl5Xc38iZKSq7ZsMppmPDR6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMlJseWOAhDM2iSoKIOFALtG+/PsyE0Rviyoxr8Q3Mw=;
 b=ek+Sj+nJqsOfzvBmmIewwXqNBMufslCha8b2H+vDBNz0xItmm/HkjiUN5ec19KdR1w+zlsjYZU7TtV4oFTfLIVgAetA1JwC1bBs9cIx75ccewtSr72KEDhiHcCdjtG1vfvSqwJ0BWI/y2iXy+ipCXbMnSvJx0ViKCWZ+H6wI839rfwy4R50hxeWlVCjaL34Y+lm3lJNY7Ajx2qORBfwlRII9UPbdPPsYTHuIiLHMH0o/sh8N5SXuZRe86P/uKzzpal0T4fxyYDv7SzJsiB0ENfeax5XWm3agsC5J0zCX2kunmN2Tkeul4Ib6Zc0xaAZdM99REQxO0l9EffSfOzphog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMlJseWOAhDM2iSoKIOFALtG+/PsyE0Rviyoxr8Q3Mw=;
 b=yNtFKDkC8W+d3Vs4h8eXb9gpHjvX6Cnln4MjVWEaWGuGEIMBczXsSiXVkqMR5Vcfyq+/ixnuFU8wkl/LOxpHYuIIGhqiolBp+c4nygKtfo0C5n/nBTatjF9/8cJJH9jWqDP+Laf8WFhCHdhe3Ptme+Z2XvKy76na1pJrrU3V2l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by CH2PR04MB6587.namprd04.prod.outlook.com (2603:10b6:610:64::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 12:15:15 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 12:15:15 +0000
Message-ID: <102655a3-bdd6-4d6e-a86f-2d850af7eb09@wdc.com>
Date: Wed, 12 Aug 2026 14:15:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] block: drop all zone write plugs on capacity
 changes
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-8-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260811105852.1245357-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|CH2PR04MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd1da4f-21ca-4e8e-dfd2-08def86b5de0
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	TSlqGc7oUoxBJoT5r7mmIC/VN6HklNCAuUgLHC7J0ImIzP2EdzvNPlkonKh7UciZYosrLpy96GwGiraYc4OOweJt/Q1Sw8bz5sfTwlFT1wZFdTGPVaeguZXhjWxsxUSAgOuAFfuJaWRTdFFv6hirSchdwSkEPZk/uQgJQbLqiDPLOyEhFu1J62TXNw+0pAROnHseHSh2QHW3Px9QDN2GPuanYNmHUceBe6H5v3Gqfuf5Q72DTs2gCKVzSya/gWPxUnxMq3VczJBWtloVDOWRa9vnO+txoFxXSnuXvOwdchwc24mtBbdeMv7OEBG0RDF+beWcKhf9PqTdzSkRhS+lkRvi9jD3h7DL6cVFtv7H0AMQN/uF5dbbOwpRjMkT7LeM+kDy5QZM0RQ1X/U6v+fkO/U4P7e9iWm2op14kbVO6ux4dkWETAER+eplkgQGB+5hd1fLNTcCE44gqVcstpKwVdUmqYkExcP9DkXaXgVGULXq6dLitGpjfLM0Ll/bj3qWbnlgwjcObOR5m5TtF7/ex0TpL5pavgYcVhbsQg6yT30OVBP4/+r5vDUv+vP7totSJzuW6WKRg+NBndm30fleNFDpsnPK4qNiEY13f7AkrdGS+jAr90hTaostUe7MKKBOJH0lDShB2Fsk/k5eun1fPmoUUIHJpr6Yh8vqPCn8q4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UExZN3hyeW1FNEFxVWpScW5ENGlPQVBrRzFybWxTTzJHQ3VFODYwakpyNjlw?=
 =?utf-8?B?VHpuSjhwd015a051T2NkdXJGajJuYXU1UnlaUjlTTU1jUVQvcllqSE1rSG85?=
 =?utf-8?B?TVFtaktUS29sQTNydXJpS0xhWWs2SUxNV210QWZWSXd3R1dGaCtjUlQ4Sjdh?=
 =?utf-8?B?V0xZU2hnWUlWUStHcStPRmVvL3dSK0huUXYvQ0JlQ3hldENJazhha3JldmFn?=
 =?utf-8?B?OGk1cnpwWkkyMTFtdkQ1emFWQWFvRHMxVE5DSThiN1hKU0dZVDVYK09Oam5B?=
 =?utf-8?B?M2o3bEkxeVZ3RWxpaExya1pxNW1jQm9KOGNDcUNvaUFlUmIvTVptcnExbDJ2?=
 =?utf-8?B?Uk44cXVIY3hDQmpQdTY4ZXBpOW13UGFtVTA5enpSekR5M1ZxSXI2NVJ0Zmdy?=
 =?utf-8?B?ZTlLRHlnejZCQ0VnajlCL09mV1RjcnQ1SWcrb0ExbVBJeTlFL2M0SVgxcGJx?=
 =?utf-8?B?RVBHMVlZMTFWbngvTkJMZktpTEtPSkFSdkJUNXBqZFk5RExSbW5LSWdNL1B5?=
 =?utf-8?B?UW5OWTNHSEhMTDA0RUJianRBZGxveFAzTUQwREFJRWg0U0M0MGI5Y3BOOGJZ?=
 =?utf-8?B?SkpFMFIrK0lWbWhPWkhXSG5lMm1VQmtUYmEwelk4RGovMlpVYWU0R09iSDVv?=
 =?utf-8?B?MlZMS05Ua0dEbDZHNDEvSnM2ZEREN2dmM2thL0NzS1Y5ZU1lT1VibEJXNVJa?=
 =?utf-8?B?SDIxUndvVGd3R3FWNjZ0S2tYdmhNdHdUdWY3cFAvVUo4VFlMZU15NU5NNk55?=
 =?utf-8?B?UkI1YllWNityZDR1WTNPdm8yaW4xWWUwQmQwUElsT2dMTmpydjJhS3lwSFZu?=
 =?utf-8?B?d0VwcnlOMThIK0szcGRQOXpPcnd6VkZva1V2QnUxMFEzQy9tVTRvVDdPQ2V1?=
 =?utf-8?B?TTFXK1ozaTc1WnhsVjlEWW5LTTk4T0RjWlV4NjZpZHdnbWlBcitlcGRRaHlY?=
 =?utf-8?B?TzZ4UFBzVjR5cG8rL1BPTGcvRjdabzVNaFRHbXowT1c0SWtYSGJxa1c4SmdS?=
 =?utf-8?B?SnczUTVDUThvaUJzdFMzTFRKY3czNVI3MFh4UGI2d3A3SHRvQTgrUDNZZnJr?=
 =?utf-8?B?SmVjcE5mRkYzWDBuQnczNjJzdGUwczltZTM5VEtTdFErNEp0V0YyT0NEenJj?=
 =?utf-8?B?cFVaRG9ETzQxaG9laGE4ZURRaWJzMEJWdGh6WWJKNlA4M0ZWSHRlaFpiZlBy?=
 =?utf-8?B?T202cVZwUlBEZFU2L05QRVVQL3Y0S0grT1g2ZnhHeW95OEZaRDB4Z25rVnlC?=
 =?utf-8?B?Wlg4NzQ3MEpsbndXd0RZeE5oQ1psOWcycnZDTVpBNTBqYWVEV1AzS0hFejhQ?=
 =?utf-8?B?S2MzVlNyaXFVQTBZSkVGTFZXUStaWXJybHhVWHo2cU1YbGU0SEZUREdUcHlJ?=
 =?utf-8?B?MlNXM1psZlN2ZWRLdHZuUlBKWWcwYU96aE9pRXNLL00yN3YzckpWcWZxREc1?=
 =?utf-8?B?OTdQRUNNQ1M1Y3dBUFg3VlNqenBMUVZpWGQ0SHBNVXhtejFUWXZQM3ZzVnBQ?=
 =?utf-8?B?aVFBZW5jaVAyVVdFTklnK0NpNTdKcW1OaUdxU3c1UC8yb0FDSXhzOWVVaE5Z?=
 =?utf-8?B?dGhjRVNRaDhxem1IVjRRcFlQYkxvaVBtVytuQ3hMaEZpa01xempnUVl0TWxN?=
 =?utf-8?B?QmtxaVZvSGFVUzd3YTF1WUxTLzNJcWRRTkJUSmlwbHBmK1NKcTgwYUR4QXNB?=
 =?utf-8?B?SFNPU1Rhd0EwaWMydzJkN3JqU3BXWkpPbU9yY1UxeXY3Z1hUMlMzcURGSnZ0?=
 =?utf-8?B?eUQ0M25Nalc5VDYvdVhtQXM0cEE4SE9ZZTBVanZ3Tmp3TS9za0kvakJKdHJT?=
 =?utf-8?B?R09mQVI2RXlXSVN6L2IvcjFTcjVjN2VPc3BMYkI4SFVzbzFSYWlOYlJpbm1Y?=
 =?utf-8?B?dGJjQUtDNkJWZnZBZ0FNVTlGWGk2NEU0UEUxdFhpWWVucEpFL3V6WWdPeVNZ?=
 =?utf-8?B?RWlXOU5CTDMzTlZSSndJVFp5N1JpWXNLYTVYbTFiYnhpZU9SQXAvYWFSN0pE?=
 =?utf-8?B?eDdPb0xyYzJvVDdOZXN5aGJqUjlHdHYrVVlkajkrdkdURHRuWmVSSXFYYlJP?=
 =?utf-8?B?bHFUdFAzZ3JUeWdQZnNxU3YrV3BiSnA0VXNSSFFycnlTckdVYlQ4a3RaVkJX?=
 =?utf-8?B?ek5PTGxqOVRtYmlmc1dyRWtJbldxbmpTOHdOb3N3RlJaU2Z6d0swWEZsdWVk?=
 =?utf-8?B?bWtTaHRMbHhBN1VDWlhGaHFBaENIb1RBV1ZYUUgyektWTzF2SFVSV3BpZmVF?=
 =?utf-8?B?Y1U5R0JsVS9FbXdaK09EUlIra2lGTzVQY01vYkk5aDV2VEYxaHhXSWU2QmhK?=
 =?utf-8?B?QmxEc1VNWTRMQjNiemVDZ2w5RU5obXhsV2EwTWRrSzg1bWUzVm9jTkhrc3k4?=
 =?utf-8?Q?l3lUR65EIaXD4cyE=3D?=
X-Exchange-RoutingPolicyChecked:
	YFV0GfZxYvcx3EqYL7gUazQqAgRMG4cxLKBLc01uYMG6jacNpdmZsaovOy+uoBVUpxQdF+0ialEOE6E5nRfXuafEF4zIfjdD6pNcN3F0s6i8yW48EaDa5ryxQQay6YbX2G2CQxcu3H5BuVl2ka6B/Gm7JR4moWS5pdTQIhLMtCsmJBXhSmAhzKB9KWxy01NEYGcWiDf01dQ+hYCc04gdZA8figFHmbub1jgiGJkLItKmu3B2/DCWgh82wzyea7LvEn+wv+5bj3Iumikrz7gWD5BIvbWtoGuvUTV5d6mhShnsmB5aNqdWXo0SJ0f6hrROUuYiztFjOouIgIJD2vp0LA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F9Fi8JKpcHv/JIDaONZvud3DgSB1vBZSNFV9Y9b+UXjEBfXAVky9uRC9YRZfrJD34AHmpkKq7lOjbdqZF/n2T/EinLoOc3gJ7wKEGMOk69tPnzSrFaoMJOxHTZhsn8e68XLe7P/hHVH2uINwrGcX3h6Youmv2d0rP/VpsCdLWvObXJEeWo5GRdLUzAGjV1gLv4Q///VaHjmqxBNPXhmYiViro4vy6ntpxua1XRVAIGJVx/qPFYcGOEBtoXY9cTMSg1PlWc9v7dfVVakfTBrt7vJ9VvdaIMQBDmK3iGdFJjrpnuS4N0+OYtanV7po7nRAgpPdUbZBS9tHSQRFQbHXGoe+AfUD/ybZ/FX0ccqLua7lqVgg7EJ6mxzUPRFruOnT3TzdlnIsMWcGGuRqpNtCcxQ71TknRbGxekr0H/EStpwXiTNkbSwkSW7PB203yptnsY3Gt1sNSVDyY1pMBrZTc5eRNQ2QMCT1ZjUa1XiaLaR59C0P1ANxcTijtVfEx/jFYsvqMYa+ViQy0i503K2Sl6UcE6zClEfoJYukaWa/yDOieB0xKUdnyyGv0OCR44X/CBRISxnv3Yo1tbRCd6nkQ4vG685Yqh7LrBGqdwLQ64OzLmPMchPHzSUJ5fYjzetp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd1da4f-21ca-4e8e-dfd2-08def86b5de0
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:15:15.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo235BANNG1CFcxF2EYKfVlUUZ2v10kulWpAtFGEk28ssclrymH+JgB5cdJ/0rhnZYeHPkbWbsyt6P4PpRP0BDES+FR5HRFhsSMmeradpnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6587

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> the gendisk hash table by marking them as dead, thus avoiding also to
> leave zone write plugs for zones that are beyond the new device capacity

This reads wrong. Are you sure avoiding is the correct grammar form here?

Anyways

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

