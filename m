Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2815B135
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626776; cv=fail; b=JiqugQ6khArra9PoF6+qTdnoJV+pvLckUn/kfkPCY2Tx2HHOzlOexnabhyg7wrVnpDQbxMedan2Ocii96MTls+luydxqf8NFedV7AKGDPAt67aPDjG3/Jyn0GyXQ1SYh1a7VW3P9/ZC1mifo2ixMpNfS4+JWrOsCIv/BC6wXSCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626776; c=relaxed/simple;
	bh=nrqfNBQbbgeeZ35smkKXkvlR7qLuiSAIpCjD0hIbd80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JLE1xl6N/DAUPS3p4Kc3WfL0hkk0D7eSPB1tI3RQF1YddpjPxFWWSmD6x+LN6DgviUCo0M9CK1DvMEOc8VJRmL8nmlxM+n9wcmq2mymEk1xeHnu0P500sw5ddi4In7dzhGIGMHJKkNUHXA9DbALVNBv5p++dexMGLbZCjqRFFMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NemWxoqX; arc=fail smtp.client-ip=52.101.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NemWxoqX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHdl3X3pD+n1lQDpI2jX2+XrrMfv/baWIlh+EeOhPoRXjkJlwLG+qPFBg5ly2TM3ZEiTdYLemvGHBwLCSnBbEkvRJaS6Yoaga34UmrVIDZUchpij64Cytkr1fd6W44igJ22uHofCxXadorlRuFCc9+PoZVaG/eAr3N8FK8HuZhsaqX3/DX963tPbB0J9F4TYhuWZtMQycn7+wf+KyKHCo2eKqlYFKABpcqmeDH9RI/DzEcqujzVuO3iq6aItDWtgo7Q9ZmZqt988DBsTPbuxF9Ftnk6rrDlqUABJrF4ZmOxdR/rwaV0ITANNlY0HwhyndOdUpylAL8JSn+csQNjVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrqfNBQbbgeeZ35smkKXkvlR7qLuiSAIpCjD0hIbd80=;
 b=EMsrVdrWWdDrOZ37RdmA8uVmFAub7YLQySxYzWwX6GaaoruUL3adB0lJ2XqB1GbSO1auNSXVm8qjfJlCDGvTFDaovrIok0mVjrGcVMJWYEShYifePcl4jW3D/VVtcVY7sJfPTPswouJ7PBJNfuiaxdBDATG5XY0rEvQ4jPNq2T5xhWvcm4yuxVGS3YQJ9i3QC3t2rYgbVcHTN4u6+MgYlWQH9BDRE6f6qSjgpbIAnbIjtmUYAQOp3l8i7/rG8LJQTaYDd8v6ldyt8Zz3oxlj6CEJttzYzHgmHQ6cpeCB06WgDluKlsYVvxAXdd/rxI31IGp/LvY0+yEr62LiyQnP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrqfNBQbbgeeZ35smkKXkvlR7qLuiSAIpCjD0hIbd80=;
 b=NemWxoqXSXICvhNwvpsBWMOCDNmpDFuet3JCcn3Ri72zgaR1YPnNvIR9JtqVsltLSLK4g1PPAAgTF9fBjUKQ/C8vUs0eI4XRCypqLCd62UdlY5ztSAVCUifgB+XZrQ69VnRYv6RYuO+u8XbqJFwqASgrllywPqYw77JVh5TKITSGUe4UGw62AmDUOE9p6Mre76ipoORkk+lXWJTkjdaCN8FnZeFPCimpoAo++QjGJXJde+eWOQ7vGaPRBXn/8P7/eAUsAKu+SuaF/WzhBHGNLF+Y1ZbRrrcR7dYEWm2k8621n4M8vRwsWcM3X1SGx8r/AsykQ87QsWn4I3s3+J0xqg==
Received: from OSCPR01MB15532.jpnprd01.prod.outlook.com (2603:1096:604:3b2::9)
 by TYYPR01MB10466.jpnprd01.prod.outlook.com (2603:1096:400:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:19:31 +0000
Received: from OSCPR01MB15532.jpnprd01.prod.outlook.com
 ([fe80::e1b7:1cdb:1cd7:c848]) by OSCPR01MB15532.jpnprd01.prod.outlook.com
 ([fe80::e1b7:1cdb:1cd7:c848%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 08:19:31 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Steffen Maier
	<maier@linux.ibm.com>
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Topic: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Index: AQHcWbyd/dB/TE6bnU+b/Z/pvJC8ZrT7KHkAgAAQ1AA=
Date: Thu, 20 Nov 2025 08:19:31 +0000
Message-ID: <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
 <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
In-Reply-To: <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB15532:EE_|TYYPR01MB10466:EE_
x-ms-office365-filtering-correlation-id: 45d15893-ee14-45f9-d72b-08de280d8823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?ck9ONGVQN2NHR2xDZ1NkbFF5N2ZSUnpVaFhoczYwaExvUWU3SVRaeE03Y0VC?=
 =?utf-8?B?TFJndFpjM3lSczBQUzBocEZ5cFdlVERmNDBvVkl0TnBWTHl6N1d2SjVmanI5?=
 =?utf-8?B?TjIrSWpVVU1vRk5vQ0xPTWlabmUzZXZaYVdIWmpvV1hibUk5VE9GeEJndWZt?=
 =?utf-8?B?RmZlTzI0YUQxNFRYU1g0NnQ4OFdEZHVYWnhDWWFwcGZhTndTeCs2ZGR6MnMv?=
 =?utf-8?B?cEVySXc3bVFNVWk2MnVIS0FGdkdiQUFUdXQvV1FBY1VtcG1RVkFFTnF6YU9O?=
 =?utf-8?B?UmwrZHVJcWFlQ3hiVWVYSEZ5TmJ0MkJ4MUJmM0RIQzV2bW4rNzRQRElmSW12?=
 =?utf-8?B?b0hjblZaZ2tuU3ZFYTJaamxyVU5BM0t4blNnQUw5WnRNcVcvaXRhTlFKWEFn?=
 =?utf-8?B?SURQSGEza1VIQjEwaUVvMUZrZjZma3VhM2k1Umtpb1E4VSt4RjFHQmYrQ1JT?=
 =?utf-8?B?SncyQXlkUHg2V0kwZzNUTDErdTBEN0h0czlGOXdQVGlRcTBnckFTMm54VDdj?=
 =?utf-8?B?QjJET3BYZVg1bFlQbjQ1M3JUempaTk4yZWxBT0FXenNVRHdHTTdWWWdFaVhD?=
 =?utf-8?B?MmJOMlZsSkR5dmRzY3FRV2lJSGtHYlIrdG5Vb2IveER3b0hiNkJkdXk3dzdy?=
 =?utf-8?B?dnNuM3IwQk0wWDRNNmltM2o4TEJBL2l4ZEd2dFpiNHRXR3RqeHJCajBuR0kz?=
 =?utf-8?B?ajdWUnRTcTJHaGJzUGlCelcramY2NkplU2tjWG9LbWpLT0pRYVNseE92QXpU?=
 =?utf-8?B?ektMVXFMZ01WdHV3cHdHRDNhbjVzdTRONjFIcTBLWW16M25TSkU1VnN5TTVa?=
 =?utf-8?B?TFNMdmVPWHJMdXkwU1E3M2drVlFKZnhRbXhwSzYxMUJ6RStCS1lGNkVZOUpS?=
 =?utf-8?B?NitUZWg0cFFseFljaWk4M2dSU0lsS285OGRhTXFLNnJ4MUpNZHN1UjdzVkpX?=
 =?utf-8?B?STdBVE5TSXZYRmM2YlJYVjZuM2g2eUM2SWp0dS8ydzVXZ3dJT2I5TG54ais0?=
 =?utf-8?B?UXVTT295aGMxVkVRRTV3NFlkTjhBYWxhTUUzQ3g4aFFNbi9LdStza1hIS3U4?=
 =?utf-8?B?Q28rbEV6eEFtd0tsdjZOTkorNnpwdG84N08wdUxrNEVQU1pQeU5pdmxjS2tw?=
 =?utf-8?B?TWJrazhYbjB4bFlJYnBmR0xaYWRSTk9Cdnk3REdSZWx6c0xjLzhIbE5qYU1k?=
 =?utf-8?B?M1BWOGxNaWFSWkUvSjZ1ZHNWazNaSnQ4WWNQU1U1MlR0cUppRytOUDBVenhn?=
 =?utf-8?B?b3hDSEtDN21wU0hud3VndHJpQXZuNFhYaks5RGxjUm9oelQ5ZVhJam0vY0Nq?=
 =?utf-8?B?Vy9JTjNtV3ZkdW1RNXJ4WUxGaml5cGZQblpNRnhBa3puU1pXTjJrUm1hbURy?=
 =?utf-8?B?MkVSc0hxV0FZcVUwME5UQjFjVTlZaFZGaE1KdDJqODBiZWZ6ckJ3SEVCWjZJ?=
 =?utf-8?B?dlVhbEVjbG5ZY1MwclZOUFF0enpwVktSemhIVlFoOFNMaFV3OURzeFNiaWEv?=
 =?utf-8?B?NjV5blFpNGxVM2E0YllEZXZPYm00NzRDbW9Hck9Ud3NwbFNiVkd3MGV1Mjdl?=
 =?utf-8?B?NjA0VVNNTk1KUUo4QnE1MHBEQUNmWFVTSVBnNkJ6QklLbWdSQjQvS0dUWjM3?=
 =?utf-8?B?UjVnbGdSZ1U2MDVuemw2WEN4b2tyemhOZ2g2Qjdrem1FZmVKaC9qTklhVTBh?=
 =?utf-8?B?RkdmNTQrN0RwbGd4dzQ3Y2RoRVNEWGRRdnBkNE1rb1VVU2d2S3gvN3VZMjJi?=
 =?utf-8?B?anNQTDZuRUk0YXlRbmpwQUo3ZzJBdXE4SzN2T2llanp6MEtaUGk4MWxST25w?=
 =?utf-8?B?My9kUU4zbjlBUzNpT1VTNUZJdXV1NmxaM1Y1cy9BUXFMcVVFdTd2Q2FKdXV1?=
 =?utf-8?B?R1FRV3dCb2VvMTllQWJBallJd3c0djArK2xBY1BENTc3S3pOVFRUMlJ3ZVNL?=
 =?utf-8?B?c3JoVDlvL0ZlMFQ1UEZpNFp2QjZvSHpIS2tzQWt1dVNkdzR0ampSZEt0SGJH?=
 =?utf-8?B?QkE5SS80bTdxQnFDNFBOcEpIdzcrejJoU3VxbUNMZjhQZHcrMHFvcTRWNHp5?=
 =?utf-8?B?djJDVTZVc01OQkdmVlRCZ1R4OHRzUlRKbTc4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB15532.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmZlaXNXSU5YSGxLOWlyOUdxNlpQdDFRekdHMjB0NzlVY3I4cVpTdkh2b1Zy?=
 =?utf-8?B?MXNMTTlwK0MwMlVwWjZiZDRiblJTOTE1RlZZK1o5M3c1RVJRdVcxR0xlMDBY?=
 =?utf-8?B?d3lBbmN3a0Z6R1BaWm8rSTE4bEJZWVJjQVl4TWhVRlBjdHZ3UXVScGNMcEY1?=
 =?utf-8?B?a25CYnRpZUhkcmR4QzZ0bFViZy9LckhTS2F3REFnS1NMUk5VNCtndEJZL09B?=
 =?utf-8?B?MElQd0Rvd2JHTWtTSmZlbFZhWW5LRHY4VUExTU01ejFhN05QVStodUp6SnVs?=
 =?utf-8?B?MnY4T2diM0hrc2d4TFkyeUpyOTFMNzFaWTE4UnJoNVV5eTFuQ3puVWl0K2xo?=
 =?utf-8?B?aTArdm12U2tWRm16TGNzcGxlYm5GS2FWbVYydlNkMmZBam92dk8wODREV0hq?=
 =?utf-8?B?ajdTR2Zscld6RnYya2dnR3BqVEJzdzJBWnN0dGxpNU5DNzFZTjlleXg4Tk53?=
 =?utf-8?B?ZVU3SHEzSzBTMHhPUTNGeXo4VTVycWtlVlpHdTNQTkM4LzRSaFFhaWw3TVBR?=
 =?utf-8?B?bllIT3RySmxHbTBQZTZWdmtINDl3d2dPMzJVNGdkZ0VFWjM1Wis4ZlVpcXZW?=
 =?utf-8?B?V25ETDg1OEpqK3dZbzliNy9XYytpc0NVQ3BhYmU0eC9BbUdEYjczRUZHWFp6?=
 =?utf-8?B?RTNwWVZGaThiQTlydG1zMHNaenNBMFZJMk9hbXJNRmdUK1pCMUFMR1pSdnUw?=
 =?utf-8?B?TGNvWExFOGNDWWdIcU15b3QzOG5kQkNtL3pUdkgySFhhQURMUEJGdzhxU1JI?=
 =?utf-8?B?eHZZOTB5aGJBOW14bkI3S21XVE43VW9Rbm4rTC9yV3ZTV3RuaEJ4ZmJTNmJQ?=
 =?utf-8?B?emN6UXFnVXJuUEdHQkY0WGhwdlZCR1pTcDNjaTQrcUd2UDBBSGVrS1c3a0tH?=
 =?utf-8?B?UWEzbWNqcXc5U2RuM1VSRGpIeTBabVJ2NUJpcmZlOFcvNTNOL2xRTnJCRDFW?=
 =?utf-8?B?L2JNTktZT1IvUG8vWENZSHcyTm5YTmFpZzFsc2pIVDlCMzV4UXR3OU1NNUlU?=
 =?utf-8?B?V3ZQdkg0UmIySzZnTXhmZDFYUDhyQnZqMFcxbzE1WU9CNVZSVWNJYkdrZ2or?=
 =?utf-8?B?QkNVRnptcmNhc3NNODRwbmJaS203OVRHZ0xpZUR1NUpFdnlkSmdTbVJ4Ym1x?=
 =?utf-8?B?MkxOTEJGRnMzNHRzZDQ3OVAvM1FrWWhzKzNSd2lsejdJdDRLbHZqMU9rdU5O?=
 =?utf-8?B?bnBDV1ZVU2ZOZ1lUeUlWNGU4QW9CYkFQQnpvWFYwTTk1UnJDMzdnOTVVaGtP?=
 =?utf-8?B?ZGREYk9DcVZWdHdNeC8yM0hqNUxlWVk5aVBVNmxKK1RJM203dzcySnN5Tjlp?=
 =?utf-8?B?RHpHNzg5eXBCT29wbHYrbjBpT0ZQZ05yYUhVdEdSQlFoOWY5N3dkcXQ0ckxU?=
 =?utf-8?B?blV1QzdDRVlGbWdCWTQ2dmNSL1A0NlZRZnJKOTlOSWVJSDdHTHFXeEI3QWd6?=
 =?utf-8?B?d0RiRjNZeTBUcWxKK09YWFFtdUVxd1hQZkJnU2pwRjI1LzJ1aGdQZWttekJl?=
 =?utf-8?B?MVpUT0o2L0Z3TFFsQm93eDYvdy9QMUZycVVjenpDTEVGVEQwV3F0TzRJWDZi?=
 =?utf-8?B?OUNITHFTa2gxQnFQZWtMVXJ6TFVtM3ZFSStVc3BXS1Y1K3EyOE5tOExMVXdS?=
 =?utf-8?B?bUZYSGJtbEMwZjFDdVpDeld0c1ZYalRGNWJNU1hZc1Z4NTEwdTgxaGc0TUZm?=
 =?utf-8?B?VFZPWm0vcFpvZzVtWVFRSkVnL01FOWJBcW1kcGk3OUZ6ZUdnRmdESGVrdXlw?=
 =?utf-8?B?SHdpd0ZFVE4vbHFGWkdKQjFkSEF2R29hVUlNOGNZM2lSbmhmTy9XVWlGeStR?=
 =?utf-8?B?Q09temYrZUl4ZjJOa1BCeE5pcFFXakk0RWt4K1VnY1NoRHFLb29pS2RIaU12?=
 =?utf-8?B?RHhaV1duY0s0Z1pwZktyblZHb3RvaWorck0vamJsRkY5TThlajFMVyt2UmdE?=
 =?utf-8?B?QWtDa0J3RnQwMkVVQ1UwTHBNbnlSOHRvR3dKb1YzNmlWbFFudkkwVjl4SVRl?=
 =?utf-8?B?L1M4S3dSNnI4NVluM3Y2UlVwNjNvVGRLY3RzTTlLSlVSaDNxakNOWUFMVXkw?=
 =?utf-8?B?NXJyVmYvR2tTZmRQTTBFY3llQ1BiNGpxYlBaa1BMMVJoL1VkS0J1UkVwY0Yw?=
 =?utf-8?B?K25acnNkNUE1Nm16MGNHZENhaSt6Q0s1bWRucWVkSGwrVnhQTkMvbG1Db1lT?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40445944FF74AC4D941C1EA70E844B5E@jpnprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d15893-ee14-45f9-d72b-08de280d8823
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:19:31.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4TznGvr8zjuzdPNK6ms51ljemC/mAcljAEz50hbaCYJ5d3C0hp1ZihHbRlJL096elQXSv2sGULGr8PcGEQaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10466

SGkgSGFubmVzLA0KDQpPbiAyMC8xMS8yMDI1IDE1OjE5LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IE9uIDExLzIwLzI1IDAyOjI3LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gVGhpcyB0ZXN0IHdp
bGwgcXVlcmllcyBtZXNzYWdlIGZyb20gL3Byb2Mvc2NzaS9zY3NpX2RlYnVnLzxudW0+IHdoaWNo
DQo+PiByZWxpZXMgb24gdGhlIGtlcm5lbCBvcHRpb24gU0NTSV9QUk9DX0ZTDQo+Pg0KPj4gUHJl
dmVudCB0aGUgZm9sbG93aW5nIGVycm9yIHJlcG9ydDoNCj4+IHNjc2kvMDA0IChlbnN1cmUgcmVw
ZWF0ZWQgVEFTSyBTRVQgRlVMTCByZXN1bHRzIGluIEVJTyBvbiB0aW1pbmcgb3V0IGNvbW1hbmQp
IFtmYWlsZWRdDQo+PiDCoMKgwqDCoCBydW50aW1lwqAgMS43NDNzwqAgLi4uwqAgMS45MzVzDQo+
PiDCoMKgwqDCoCAtLS0gdGVzdHMvc2NzaS8wMDQub3V0wqDCoMKgwqDCoCAyMDI1LTA0LTA0IDA0
OjM2OjQzLjE3MTk5OTg4MCArMDgwMA0KPj4gwqDCoMKgwqAgKysrIC9yb290L2Jsa3Rlc3RzL3Jl
c3VsdHMvbm9kZXYvc2NzaS8wMDQub3V0LmJhZMKgwqAgMjAyNS0xMS0xMyAxMjo0NjozMy44MDc5
OTQ4NDUgKzA4MDANCj4+IMKgwqDCoMKgIEBAIC0xLDMgKzEsNCBAQA0KPj4gwqDCoMKgwqDCoCBS
dW5uaW5nIHNjc2kvMDA0DQo+PiDCoMKgwqDCoMKgIElucHV0L291dHB1dCBlcnJvcg0KPj4gwqDC
oMKgwqAgK2dyZXA6IC9wcm9jL3Njc2kvc2NzaV9kZWJ1Zy8wOiBObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5DQo+PiDCoMKgwqDCoMKgIFRlc3QgY29tcGxldGUNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IMKgIHRlc3Rz
L3Njc2kvMDA0IHwgMSArDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvc2NzaS8wMDQgYi90ZXN0cy9zY3NpLzAwNA0KPj4gaW5k
ZXggN2QwYWY1NC4uZmQ0Y2ZiMCAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3Njc2kvMDA0DQo+PiAr
KysgYi90ZXN0cy9zY3NpLzAwNA0KPj4gQEAgLTE5LDYgKzE5LDcgQEAgQ0FOX0JFX1pPTkVEPTEN
Cj4+IMKgIHJlcXVpcmVzKCkgew0KPj4gwqDCoMKgwqDCoCBfaGF2ZV9zY3NpX2RlYnVnDQo+PiAr
wqDCoMKgIF9oYXZlX2tlcm5lbF9vcHRpb24gU0NTSV9QUk9DX0ZTDQo+PiDCoCB9DQo+PiDCoCB0
ZXN0KCkgew0KPiANCj4gUGxlYXNlLCBkb24ndC4NCj4gDQo+IFNDU0lfUFJPQ19GUyBoYXMgYmVl
biBkZXByZWNhdGVkIGZvciBhZ2VzOw0KDQpJIGdldCB5b3VyIHBvaW50LiBBIGJldHRlciBhcHBy
b2FjaCB3b3VsZCBiZSB0byByZWZhY3RvciBzY3NpLzAwNCB0byBjaGVjayB0aGUgY29ycmVzcG9u
ZGluZyBjb250ZW50IGluIC9zeXMuDQpBdCBmaXJzdCBnbGFuY2UsIEkgaGF2ZW4ndCBmaWd1cmVk
IG91dCB0aGUgZXhhY3QgaW1wbGVtZW50YXRpb24gZGV0YWlscyB5ZXQsIHNvIEknbSBDQydpbmcg
dGhlIG9yaWdpbmFsIGF1dGhvciwgU3RlZmZlbiwgZm9yIHNvbWUgZ3VpZGFuY2UuDQoNCkFsc28s
IGl0IHNlZW1zIHRoZSBrZXkgd29yZHMgdGhhdCBzY3NpLzAwNCB0cmllcyB0byBxdWVyeSB3YXMg
YWN0dWFsbHkgcmVtb3ZlZCBmcm9tIHRoZSB1cHN0cmVhbSBrZXJuZWwgaW4gY29tbWl0IDdmOTJj
YTkxYzhlZiAoInNjc2k6IHNjc2lfZGVidWc6IFJlbW92ZSBhIHJlZmVyZW5jZSB0byBpbl91c2Vf
Ym0iKS4NCg0KT24gdGhlIG90aGVyIGhhbmQsIHNpbmNlIGJsa3Rlc3RzIGlzIGFsc28gcnVuIG9u
IG9sZGVyIGtlcm5lbHMsIGV4cGxpY2l0bHkgYWRkaW5nIHRoZSBTQ1NJX1BST0NfRlMgcmVxdWly
ZW1lbnQgaXNuJ3QgYSBiYWQgY2hvaWNlIElNSE8uDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0K
PiBhbGwgaW4gaW5mb3JtYXRpb24gc2hvdWxkIGJlIGF2YWlsYWJsZSBpbiBzeXNmcy4NCg0KDQo+
IA0KPiBDaGVlcnMsDQo+IA0KPiBIYW5uZXMNCg==
