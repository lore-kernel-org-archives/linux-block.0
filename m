Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFE3B7760
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183670; cv=fail; b=qc3Jkmz6ngZ59kVT+wGJAkWeUN90Zn6kMRzIvPAdvKrhsrVCar98O4u38ILSJlMeBcgAMIwepjxfk0Xn54Akbs5siAuQqACIhWrgjtkkUN6FJdYV4KyMVtQa0MvN1IMkXaYj2k+I1hf/k4tqidIugiObqZyXMZkgiexAmB3GcXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183670; c=relaxed/simple;
	bh=RTyEmIEQ/W/bAyIvQfB7fto7Uu35VyUZwqiIq2F2veI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWPIOjUQEoSzrxmCZedR0ykQ3N2S4x7hW/09+CzCjztOUAWcdE0T6TZ1Ep/g8xVfW7/8ovRJ+a7cl9saiK4t/2EWRla4FRd3h2VbhyrAjdeV4XjNQ6sz2rXPXH9zwMO+I9z8tfoFo8IvAWJ+qyDO13Of1o3+m0A7WW0FG85i0mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kKJhR1kO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=R0ej10So; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kKJhR1kO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R0ej10So"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776183668; x=1807719668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTyEmIEQ/W/bAyIvQfB7fto7Uu35VyUZwqiIq2F2veI=;
  b=kKJhR1kO3tEXaWvh4ecqN3O0u0W09j3sYRQEypLKpdH4nHucYbZrTcPg
   dEtONbFgWVcTQ4E7KALkNtjI44DRY2GwqKoHFlnt0lUpOYZEZga9df08/
   R9TJW8QCA50vu4eaLkpfrGlLyxte2lTWHxffBDWSUaJM172x7iyOU/+x3
   4cjTuYJLmjYolKtL0a6chJhagku04qh935OVvf313aYzfmsh3fR3oDORa
   CvdBSDtlRMPTaJdDbHLKcJcMQq6oP3MisRMtNAlTCeeSv8QnOKDUwTWWE
   vrdpy3EYn8BEwvMT8DizXprOv5jxRMD/XZ9T3z8uzgNt86pedbT2Jvtl1
   g==;
X-CSE-ConnectionGUID: ++RZjQv+RZCQQISc/ORDmw==
X-CSE-MsgGUID: X26Bp4BhT6SbaOW+/31U0w==
X-IronPort-AV: E=Sophos;i="6.23,179,1770566400"; 
   d="scan'208";a="143408130"
Received: from mail-northcentralusazon11010019.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.19])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Apr 2026 00:21:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usq9pI8oPWHR8v6qZ4/LqG6rwWqZNbrZ/9gVKFSjUbfbjoBtzFC19u5PgKUvKXOx9XWXyQ3s07L5S+XmMJR0ctlnycItIQcEX+ZLX/7h6xLcOMklMFFfTduU3fZhMVUh0HamAXPWR1qNxFO6JXJtQtFfBMKTjudQJfywBQuUw/j0eK82Pv2P7fTL98QaPk0MgnaOAQgSS9R6GgwN/uXF5igrOSN02RypTPpBOGmOssdD4PZn3PRZnOVVGE++t6NZvG98ITBmcuksAnw7Am4xfoKulI3lTvYGcvpgfHKw8NbyBm//J6rnhwaD03lQdjBAKaXLiBzzxW2V+zmy7pC9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EnORfnYPr6k0/udlkUgLuXy/fciLKcCdCa8JbbuT5I=;
 b=o4tU0W32JS3S2PHbDIwySceFM+xtIICwFWmL7dWoBkLfj7Id6gbF5L543I9MsN8gV/WCI4p6FQDCoxlWIRLfMAro0ImWdCSMqboYn5EXE9r1yH27liTX4V7vakXXecG6xMZAkHOE+JgOI0aR85ZAYCOsLsOrtveLQBivsX63cexTA9lQghIoS1846yFqcOF9QJoEDoGYmneoKczaJHfcfVeHn9DGRSbQ2Kg/cRUe/Feys/HwPNTwV8dxE5Hc9ihymmvkJ8+EhbuZU6G5rq3AErltiRIPViJtzcqSLvcjcY+LcA5w+MhP+rgX5oXZ1H4KgV1YxIm7eA894x3gINpSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EnORfnYPr6k0/udlkUgLuXy/fciLKcCdCa8JbbuT5I=;
 b=R0ej10SoVUYOi0chP75NfkodckJ8ZrOse0X9rW8pQaAWTd5+5k9EuzLoLQ4qpgqD6F47O4J2E8lllC683+MrW6mJhv2G/J4esTTI6zHaR6FNILMnslo3A1wx4RQIu9ZXdEH6/wfk14x4WpKoczblizZgrLGZiZi5Ivw2q0S7rmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN7PR04MB8464.namprd04.prod.outlook.com (2603:10b6:806:32d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:20:50 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 16:20:50 +0000
Message-ID: <46cec6d6-897e-41c6-ae15-5c707e946351@wdc.com>
Date: Tue, 14 Apr 2026 18:20:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: zloop fixes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260414081811.549755-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To LV8PR04MB8984.namprd04.prod.outlook.com
 (2603:10b6:408:18b::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR04MB8984:EE_|SN7PR04MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: a1142f7d-8c3d-4390-152d-08de9a41cad3
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nE79p+ziXn79SkB/+pmvTQiHpLUDlP5YvMUemfxth6B3iHJHDvsdWGxW+nfk/IANt+EAOY60K8+iedo24swFkj7Rt7kFQRJMfc2EI8sEaM5xNE774pFm+8lizmHFBItsRqamdxGxdW68s0kMIkCwpQQ+9plfYIXkdJOIG7SyENnQXy6VmkE/Q3ENQAwDUAEMso6lUlUGg3tPXg2Iyk75cVrPVcE9DuDdpqhgej1grcwRzYeDgqlIEcDZEbWSeDLkyleLKG8rFMzECRnMEv88Msj8MLXV/0r1Rjumuiq6AH2SBENFcLItOZcyOLgOnmxoJWRHG/0ATZl+uYL3I8x5TIL7dw+5X03gk/My1jgAHE7R66xtOsXsWRSMiu2/b4BckTn5Oxw719oUQPyQy/vr4xI5JZHAbiJsbFRZI29zcoQEH6uL0ABUyc6yqvd55t5dNtrmn0ErPYOM9o4knVXDQEFu6Wje9IDd3IxNJXch479czhCAwQ7ulTX7BP37lIgutH+N9zoJuab7ToiO5RPw94gWd8EKVym1eRxKC7jKwm+o2MUzPPqoowSlBe5iWeC4ApBoJ9QwKSV7VlFWnDqkZ0LforDP7ID5kO/9Fz1utfLFUMeM7JNd3MuN3f/EL9VkJYY3I4+gD9LDscCeiHIGIQgCYjXflqjQ8gBn4BKIQLal3pDHsnBBmYzqC6Ctm4Qa3xGve32m2WqqIRIyBGqHnPfyMYEKJM1t0xeC4bBm1uM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjhjVk1yV3V3RFVzQVoyc0dKWUh3eTV5Tlc3NDZvUnVPZVBvM1hYS01NZXE1?=
 =?utf-8?B?SmQ4U3lIRlcwYkVsd1grUVdKUGZicVg5VTlGMUkzSEJBOWFaTzZZYm56WjN1?=
 =?utf-8?B?eElYSzQ5U2kyZnp2a0lVZTNZR3YxZmlLVG0rOEEyQ0FRWU1wQzhsY3p0L3B2?=
 =?utf-8?B?Rkszc2N1aFpwT1dyeFQrSkJETTB1eFNYeUkycFlXMDhmRWFORHJyZ0JxdkVZ?=
 =?utf-8?B?SWs1bmpqT2lTd0dibWtIblpOUjJaTFc2RnNsa1NxREgzeitweVZ0TFczYTVJ?=
 =?utf-8?B?c2thcWNhcktOL2k0OHNnV1hybVFpRjZIa042aGRlRkM3dWQ0NmF5VGorZEk4?=
 =?utf-8?B?L05YS2ptRDB2L2hNb2FGK2dpdXJWWFdkZ0NnU01GMVAyUzRnUytlbm53eFox?=
 =?utf-8?B?TTRsWEd4eXV0dmViTVRwSXlJemdXYloreUhVN0VQb0p6bzBXdGRTY0F0MUZV?=
 =?utf-8?B?cERaSjBnb3VaZS85dFcvMEMrTkxrQTRVaWdVckpQbXJxbzNweXhSU0orWE0x?=
 =?utf-8?B?dyt3ZWg1LzNoNE9aNWlMZkYxd2p3UVArNFIrbERaY2o1YklOcVF4MWR2YXl4?=
 =?utf-8?B?dGdNVWMrZ1pyYVJMa2J2OUt2aytRMWxKK2NhbGs0RmxxWWR3N1ppc1dhT1lB?=
 =?utf-8?B?Z0JUQ3puZWd0Zm40M09DTmVlYytUaEZvZ0NDUTJRb09WL1AyWWNJRGNqR3pk?=
 =?utf-8?B?amhjdTU3WEFDWmlLd1c0VFEzTVJDNDRlMzI1RFBuL0VFWUpZNE1CNnZOcUNM?=
 =?utf-8?B?Zm5nTzdIekRmQlkwSTBEQk15ZlRBZi85ZW90bU9JR3BuRlQreW9Od3RBSmFq?=
 =?utf-8?B?VUZvTWtXOFk2RU51MVNyRzJUaWdSWHBCOTY3QVA5elhUbExCdllxVnR5S3VD?=
 =?utf-8?B?QzdFd1dDN1hvZFBMUnE5NFIwbzNvVk53R09ma3hZV2lUWHdaRWJ2UXNOYWFS?=
 =?utf-8?B?TTBwOVJsdUd2VXlkY0hHa3VMa2xEblY3WElna2ZweGJtWkhoS3o2MWRLUUhO?=
 =?utf-8?B?WUJrTmJZUzV6YW9JZWlnZXFaNk1wb21wSUNLVUxaTW5XSzNsTFhSTnVWY3FU?=
 =?utf-8?B?VStXdGx6L3daaGtTY3F6cDJPUHhaVW1JcXdoQ1kwQ0JQaXNBZzE5T3V5NTJQ?=
 =?utf-8?B?VjArbzJDaUFPS0FDT0YyZHhtRFU1WGRWOGRSMnloVlJIY3I4NzZkbXlSc3Vt?=
 =?utf-8?B?VmtsRHRZTDhMU1ozelJLdDFWWDAzN2NiNWpRVkZrcDJoY2oxK2g5VWtma2FO?=
 =?utf-8?B?Y01IN2dUS2hKK0UyQ24xZ3VlK0dSSHppLzRnQXBUR2NQYUpsSWhldUsxWkda?=
 =?utf-8?B?NXRBc0gwL2ZpQlg2YzZnTW1jbXdoaXhJSGF3OVZaN0ZsSzc4eTJOQ3JUMnRr?=
 =?utf-8?B?UWFCWkUweDlHa3p4OW0xY0lrbkc1QjdheDd2RXpWV2FIM29xTmFwTHJvSnR4?=
 =?utf-8?B?MTdqYllyd3pJeWxsZGppWjloZ2sxTVZtck5mL3NTbHFmTGszU1FycUlxZlk0?=
 =?utf-8?B?YTVXOUYxR2tOK1dpZ2t1NmczMHU0eEx5bFJhNTBleHlqV2pzV2lmV3c2MEdO?=
 =?utf-8?B?TU9NQUlDWklVZlBoT0g2RlYzR2JWNFJEYVozQ1hiZmlTeWxuNjJkQ3gzUlJl?=
 =?utf-8?B?Z1FKU3M5UUZqWW1qT0d4ZVkxbFlqVkcwUlEyd3ovTUJNek5BcWNnSERoTExF?=
 =?utf-8?B?QVFVWkFJV1NNc1QzamgvaHd4S2xmc0phVVNEZTY3TXhpUjVaVDV0VGR5a3I1?=
 =?utf-8?B?QUxVVlZjRDdnKzIySS9ObXd1cTlCcHZ4QnVzTTUyTUt1NmlSWFZJTE9QZmFW?=
 =?utf-8?B?VE1Pb04wM2FseE5TY1ltR3hVR1JvTjVzRG0rcWRSS1FXNjc1Z0N0Ymk0SGg0?=
 =?utf-8?B?NzhPQ2hxWEdSVVgwakJTYlZyVGlTbm9jUnZxdng3UW5FR2JrQ00yTE8vUVVG?=
 =?utf-8?B?NHdoTENQc01wL1V6Y1ZKU1pVcEhMUC9lbm1NOSsrbGhwbC9hNzE2a3NaSGJL?=
 =?utf-8?B?eWtZcFBGc0YwN08rcDg2U1g3eTJRWlBxMXRXeDl0Y1dzNDhDcUdiNHR5d0VH?=
 =?utf-8?B?Y0xUbU4vT3czS2Fzb0U3dEl4Qm03Rk9kTEt2TFExeWpFVlArbFJXQm1kWmFY?=
 =?utf-8?B?LzBRRU5aOWFnVjd6QXpUVVRkTW9lNjFsRWNXKzN5K09nLzA4bjFwMU0rTjNL?=
 =?utf-8?B?bEdPNGJPUThkYjA4alhxY3NMcVhjOWlNWURFL0pITlNLS3c4eVRySUdmekVO?=
 =?utf-8?B?QWVhR01BTXp3cVdObmRLN1hTUXp3MFVkY1pPVUl6Mnkxajc0TmlxdFdtb1ZR?=
 =?utf-8?B?RTk1a1A3aXBCWjdiSUVEQnRLNVRNSEo1d0p5elZudjNZS3VCQVJjZzJtaHFC?=
 =?utf-8?Q?c3Du9zbvQT21+lBOmsvMDBlEJaVOPQsIOGh1WKf1RrnfV?=
X-MS-Exchange-AntiSpam-MessageData-1: T3PrW3XvZNjngVDOHchJQWTtKk0WrXAJVSA=
X-Exchange-RoutingPolicyChecked:
	C68/3vwQnJ38MAKwz6TGkIL+04xajTSJx65JfUkrSi+KRxXD2eoUci4b8wbfEVJ5W51pYJQ8z+f22SXAOdA230Cz9O/hFkWHa2jOmsZWgWlGnX2nYqXWri48AY5gySt7GqtabLeN9sRbun+48DvKRSkQPm8XnLjpL8NWEyusoeqwi0e43oE404k6CXh13rTHcTnrRCNSDMQGncGQDBvYQBQ5Nq8J7M5yJ86TBr5rZD69gvx8IMeQROVdTWvtoO52/bSxeWjNJNMrN0dwMhtZJnvw8Sggu5mP6cOfWU5yyD+Xf3/2a/QHwk2VesbN7sBQO2jBUIrfExMkv6R3JpZtZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4h6qFEn8SPGj6k8HHDD2i0y2LTvQ7De9SPDPi44sUvHinjJWl5VoRy/EXVNdUTb2GQ4Wqe2kEOngzIRsaDrymxhCJlP85g/KfCSOEUixNtnaMXNzPv0aA5FTqFXYQFjB7Aw/237M/egdAi+cJj7NONZXZWk7asYdsIhkB8MaqHejyRVwqAdkh79gU8W4v6s1eDcwcANSejz3J5aE5/qQohACDyk814ATENsJNu3n0sGQ4ufd+xgPoHCcuMXTa8STwmQ6Jnk/4GxwXuFnzttCVh6kOZxkUNb8jBXy8QSD4pN3Db0rzE9DZGWk6Jnqw7o+P91v56l+TnFN1AZDq72YkTSYXo8o7ORISqF+ZvX96mXZNvh0YdFyU5PMRH2cxU+BZx2KRZbf2M/Orx6UWPzPpt7M3lZ5Xx2y3f2Je4kkTaEzRv1NdJALo5Ycpst6bFY9rJk2jhIoS2TJzQQHEBgGtAkdmoFk8LYgrtbdugyPxYeHXP0NwUiVA10Vi1kTSg551ZRk/miiOJDj7ZjkWci8QuifN0RBDg16+LSaU20yk9GGwWtQEyvJm1IU9pZkEwY2CxMl8D97ATVxe6TAlrx8KzuXXsDxX5UB7U0tfOCcIWMrOCFaQNUb3KijB6llrBqU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1142f7d-8c3d-4390-152d-08de9a41cad3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:20:50.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTXOIZB5D5ZRQFGqKbxOlW3G+m2K49Tav7D8cp40TT75fNCa69wea8mZFyfPnrVqGapuPW4jI1jHE1Sqdn9ZMKfke/DzALy2qrTFD5ANVz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8464

On 4/14/26 10:17 AM, Christoph Hellwig wrote:
> Hi all,
>
> this series fixes a bad bug and a few minor issues in the new zloop code
> queued up for 7.1.
>
> Diffstat:
>   zloop.c |  123 ++++++++++++++++++++++++++++++----------------------------------
>   1 file changed, 59 insertions(+), 64 deletions(-)
>
Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

