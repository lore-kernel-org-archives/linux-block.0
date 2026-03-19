Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39733BBA2;
	Thu, 19 Mar 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905573; cv=fail; b=iHSVppFGr/DfL5t0srxNjmP2m00ACFnlsJ6tUonrzaUXL37cu6s4ovDGqjyR0di5jJnCClJLi9DHdfIx+OLDEWESqYbDT6ndaIcel47hI7gCFfQ+Rqxv5vFXNMf/Dp5FIC8qchbuSiHuImIPcZzKbOT5IQa92UxDYx/MXwgbqek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905573; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPDBJii4X1XTy5cXiHIpHXp9mKmBS6SYOsnSJ2J9MtN4eoo0bYHQhINKO0HgWj6GHKmb9K9D92evDSh3+Q7kkTqa1m9e0Ot5nvamWYgG2EyU2BdydRuuBA7Z3f555E4Mf6vJeI5Khdc5agrPOp/vK3L6tdsovzCLh6yzmStL1lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dwAihCYU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KXwro85v; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dwAihCYU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KXwro85v"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773905571; x=1805441571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=dwAihCYUp8EJA1MLncI/HBY6jp/U6rnueVa96jIF+KKwUBmm4bO6t/lS
   Yx+AwbFukFCUhSoVy1gnnzGce8iZqyEJa3mf5OsaazVPmSeHqdR0Oe3h4
   hfJQZRZrCXPE2ZsIAXnBM06I3PZT7UnPX5VcCE5bj6xQLdQI+ecuw55fO
   oOFfGGngpxnrCvchboGV9WLqOEsYHVNaydiOV5wzh0UueTq5T2J3gwR5V
   wjL3XUHgtro+yVc7vlTirHSocCe6wHiYq32AtAITnb2FgJICOPIMli5Cv
   F06HQEqdEbI7A7macm6bFXDfvIU8ka75NZdWDQDGguyUOhVLKW2NXp5sX
   Q==;
X-CSE-ConnectionGUID: w3vz9pwoTcu5hpdVbSdSRg==
X-CSE-MsgGUID: k5ppuOIuQI6tdLLIQDkRug==
X-IronPort-AV: E=Sophos;i="6.23,128,1770566400"; 
   d="scan'208";a="143344563"
Received: from mail-northcentralusazon11010069.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2026 15:32:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROT2BY0yV9dx6txWYkw70QPnX7qeaeUSClUzi36qKFw0Ev2N+Iu4+Zttp2FECZ1AK1kO6x3HBVSmNe/C3Uib+W5RcxqWUty/xZtxtP6g8QVEm4vk1gV06u/S+STrQK79G+AiWYHmXpoiz82EjGRRkDZ9UOkoSBPp2HUVcbAhD7qvYx1kgH1+QhAz8t1hRv5Bm9sfotHg4ZdQOWSFewr5fPHu/BV5hRGKH5IvvynAlKBApiYb+D7SlQmHClnnnCTOeNU6CBQSpzkv6Dmid0Et4KHfI5BJTYkFDUPKFZXVHLI7ZXdD+2iGmUAtuMTGyjeHtOyNIvJtG9ErICalCQ8WFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=afAbrTelebDbBQ5lKdRxpXTuUsAZAmXNrInYm27ZZrVVCgPSNNx2HdjdfaRX6o+LtPzUE+5gANg2DXt2/zKRsr6zrHBP/Gi9iE/qyMJv4YnsWzMAAXE9UicReI/udnEnwSgQ/QB99qJPslyJ0uVx4iW6QVlPjhy5XSI13g+17xX+ZGG4VhcGoIxXq+LTA1u0QlMRaxeE7HTGvbI6Kd+HG+dZzpVnWwtoi/XeFVCaEGb7rxHIHFv+Ac9OdOGAkIWNesr2QOwNFlsQn/sGhqrztQvpEHcsKcsG6Ln7OEJdrnOgUSK+u8tuxMg5AehAknTKIpfyJNg6cwMI05VbCN7g1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=KXwro85vJuWT/DDcWOfYxbYxDhD6ebcopARhdqzYSUyORFrHTr/Fe9oLiVNPYJtGbLLSfWg55d5mSKrQ4nULLdpD2LmnKJUeLwOPluGCw+XdOOMl/acc3OnCvLmtslJ63WQr85GFSh9B6A4b8bGr4Ppp3olAbUpjRDf2W1cL+zY=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN7PR04MB8621.namprd04.prod.outlook.com (2603:10b6:806:2e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:32:46 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 07:32:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Aaron Tomlin <atomlin@atomlin.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>
CC: "kch@nvidia.com" <kch@nvidia.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"ritesh.list@gmail.com" <ritesh.list@gmail.com>, "neelx@suse.com"
	<neelx@suse.com>, "sean@ashe.io" <sean@ashe.io>, "mproche@gmail.com"
	<mproche@gmail.com>, "chjohnst@gmail.com" <chjohnst@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Thread-Topic: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Thread-Index: AQHct0MnJ1ngUwRMrU2PRAC0LfP247W1dqGA
Date: Thu, 19 Mar 2026 07:32:45 +0000
Message-ID: <63dfc26d-7d9d-4530-bf85-4f07fbcf240a@wdc.com>
References: <20260319015300.287653-1-atomlin@atomlin.com>
In-Reply-To: <20260319015300.287653-1-atomlin@atomlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SN7PR04MB8621:EE_
x-ms-office365-filtering-correlation-id: 10be38f2-2992-4732-af6c-08de8589b6e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 Zhe2/s75MhL/Jhg42LCSaPDylfXhh5LeBhMFZVxlnRYReaB+m7bbooHJlVn/4rgjsWKph9D8qt40i/z9JKeMF+uutb3obxRylhCUNGGtmmO8XDGZlGdxs69rKN+rw0L9vt2UcsynSrhQ0A1wLHfEunSdI63RV5ijz/Nn+fMZGlJ7sMaOI45xG3H/7mhP+gaYYcC/NV1HS+F3+6so2APP0HsdSNvCr4AVZ3jUN48l5D6QbUw7eOcNyuhI0tkh1PRgWtnUpp4/iMNpCArBDwJ3UR01aQjb9G//XTiUbgqqfkKU6cMzJbEphWjDonXWSQiNBbSSltMF3Ecp266AN/cjrTPYkf8dbicLUSKQa+LwB54komOzZjd0JiD9KdQJ+Otb0HiUh3dmYAGDDCEVfTCoBHX/eRu3e8U9/dVnV0s54W8c3F5Oz2WNuddWtjJGTC506kTzWaQ0ECONVlv1sSaBlxWVSpGZJkNs48Ona4DlYoKWKeP/jE7NjsgOcl+CvwxBVZNr1bYYm79YS8s+r5EDMPazOe7mkqkreWaooQROBCGcr/sV2w6vsUgPGXuamoOJ/UfB7YgB2hffGnAmJ8t3QhovoI+k1vY8J40XifBZaiuBg7EIncFevnjSF5NwJeBhadqQHMkJdcS2IlzFuA4gLxtqgCtTy8T9PxJeOzU7qF5cX4OgUdgVGL00jFOwXGJ9y27IhrGz3A/E5JLGSYCEtuBOR4PSrYe65L9+rcqQ2xRAc1GtSdJzlk3w2B7SJVO+H7/itlvraLqHa4sHxNYVXNb8JWPIt9f4zbdYLLRwgW8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXU2SERQUGt0WE5oVlhDTTF5K1dwTStlVDRKWTFPdjBPbHFBTnRiMW1wcExo?=
 =?utf-8?B?TzdGd3dZS2F1Ukt1WmlaS3B3aXBCQ1MwcWZrVE1YN0k1YUdUZzJ3bDFsUEU3?=
 =?utf-8?B?czFSWEM0bVArU1RpR1k0UDhqTXpKMWcvVjBkV0V0eE5VS0hON1RIbVI2ckdB?=
 =?utf-8?B?cXZhems2V3RjZ0dCbVJieFA3TmF0OHl1dUI2dEY4NGhJczA1OWJaSG82L01O?=
 =?utf-8?B?emxZN2lFd2YwdUJ2Zm1xdk1ydDVwZEFsa2RDTVBLQjhtcWxhOEFISlJRcnlJ?=
 =?utf-8?B?TGtTTFZuSmxFRzdLc2pQd0YzM0JUbzNzaW1TWUFkRFF6WFI4b1doVWtnVTVh?=
 =?utf-8?B?eWZuS3dVcHRjZjJ1Wnp2UWtOdFpocStLRkFHbVh1UWFCZU9ueEc3ek91Riti?=
 =?utf-8?B?YURHSjh6T0dXYU9SUEpmNHRFVlI0cWUwNXBYUHhEQkc3akVveW9ldGhPT0Nn?=
 =?utf-8?B?aVB5cjR0S29sUldLeHMwUnJwU2cxa3VWSFJ1d05pMCs4TkhNQXdGZHBqeE1i?=
 =?utf-8?B?c25tMUZhc0NQR09HUnJabkNlbXE0L1cxTmFmZE1zZXBtcFVwNndlZWh1YmMw?=
 =?utf-8?B?QlpxZXRJRmY4eVZ4MEF0UTVDeFpQSHRndXllK0c3U1ZzYi93cG5BUWx2TGZw?=
 =?utf-8?B?bFdPSzRGUVdDRW1ibEVJZkdvTlNmZTg1TUlpSFF1YlNaMzF0ZFhPVXprK3kx?=
 =?utf-8?B?VUVLTzhOdjZDWDR1elQwaXN5Nll0bXpHQ0cvWWdCQnpIZ0JySnBMVXlYVGVU?=
 =?utf-8?B?bUY4NDNmRGEybHcweS9mVFNWWm1JN1ZPc3lFeEMxenlJd09yRm1vRWtIaDJZ?=
 =?utf-8?B?aC9TUWUzb00xelNCM29WMDQ2TG9FemhHVVNkQk9xM25JYTd0UXowK0lPSkVw?=
 =?utf-8?B?Q0htaDZSaEpjcEZzUWZrN3AvTXlXUGpOWEZVUU52Q3cxTjV0Z3hzV0sxdTFZ?=
 =?utf-8?B?S3pCRStlY3gzRVVwakdGUStwWVRINVN4Vkl1S0xYcWVSYlowMXZFZGRlWTlQ?=
 =?utf-8?B?WDJBN0Y5SDB3Y2NZa0ZNbi91ZzltYlJxQ09jTkowMC84SEVLVGFtR3UrUVlU?=
 =?utf-8?B?ZGxMcEI0cmFHbjhRTTBiL1BMSVFUcHRGL1R0WEdSeC9iSEJTZG5ELzVkWEQ0?=
 =?utf-8?B?MDFZaDB3YWVZU0ZUcS83SGs2WDNCYnZDUUFzYkRyWVM1U1BhUVlMY21CRWdE?=
 =?utf-8?B?bGFoK0w4dUdFK1hxNEczRjJuTUxPRjYzU3B3WWtDckMyTWlTNUtjWFdsaU1y?=
 =?utf-8?B?UXV4T1VITjBsWTZGQVNqb2d2b1BpQVFBV0hGeGZnMlpVa2VsZklWMzdBeFcx?=
 =?utf-8?B?clYzNk8zU0ZPYUFPWVIzUUh6aVNRd1ZoOGhoQVJMV3QyU0h2Z2NwcmZMOGNT?=
 =?utf-8?B?UmV6WWt4TFdJUDh4UEg3NUNwNUpoeVoxbnpwcmY5cDB3L2lkMVlkZWp1K29V?=
 =?utf-8?B?OHBOeGtLejU0Z1Z1VC9mTGNEL0s5Q2J6U2RoaDlaampFVlhkelZWdTZ4bExi?=
 =?utf-8?B?ckdxWEU3OFFvbEM2OXlpcUtISE1DbmdCeXNvaHRmMUVGd2dTdjNWejdwTTZM?=
 =?utf-8?B?Y3Jpb0M0YUNwUWZNRXpVOWJaRjJRWkFrT0lROHpDL01UWExuVXlUbVBsSkph?=
 =?utf-8?B?SUIxUXVtWGROQmQ5VDZNNGdjQitSNHJDSTBSbHN0Z2NJMG5MYjh2Z08xTWtL?=
 =?utf-8?B?M1BxbmZ3ZVdleUJ5Z05zWHh1am10SnpES3UyUW9mendZYW9yYyt4Ky91VjBl?=
 =?utf-8?B?NFVvTXdqVGR6NFFJNWVSN1hkZ3loa0labE0yVTR5RXJ4K1J4bjhPSmVubWIz?=
 =?utf-8?B?LzJPa1BNL3U2ZE5zc0h0MU1sbXdUS3RoUzJ1S0V5YjFyQ1NVbkpHeG8vT1RL?=
 =?utf-8?B?T0lNWXczQ0U2LzZ4a2pHYzU2bWtTRmQ2QzlaYkNVdHVpR001VGcxWmI0NlJl?=
 =?utf-8?B?RkQ0VjhMMjZIY1hmNlRXTlpCVTNtbkw5amhvU1hiM0d0NEZRbmVNc1lBbFo0?=
 =?utf-8?B?eEcrSnFNNzBQOEJQdmN5SEFqY0twSFJnRFQwdWowT1pVYkdudlgyajFxR0Zx?=
 =?utf-8?B?OEdIa1BvbEMwU3FzVmtjS0VUMGNSKzRRVHN1aTlKMm1mdnZzYTh1aTJTbEVL?=
 =?utf-8?B?ZWEybmlDejdDeE54MHVDMjg5WmJ6a3hvczc5Z1MvOFczOXc3eFBJNXNLTytK?=
 =?utf-8?B?dzJiSzYxRmtUb1MyMFhSdkFZYkhKc2ZGK0xFK1ZFUHExSDJJVFRhM0pQcWRi?=
 =?utf-8?B?clFWOCt3eWJFdG1VRE4xekU5cFZaVTdXVkxzY3BrUXV0QkVjRVErYWZqeklF?=
 =?utf-8?B?TWpUT3J1d29aY2xTUGsvV21SZ0hhNUd1OE9OdTBTZytKb3dVSW9Rcit4dE5p?=
 =?utf-8?Q?eCYuQ0aeBDG7HAhbKkDGAzj9MthzWZrTxeOg/GSmd0WzC?=
x-ms-exchange-antispam-messagedata-1: bcZnyi5PjuGcmKNcRYxtCZiAcNx3bLF4fXA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B33D2D089625146814E26A57ADC74CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	S2MUqOKyxlOWqc+wwfSag0pHdUiVTNOzXgmd0fpZ4L+SsXlkPc89L9fjDhVcqsfASHGjPTZheviY8INXAx2Ik6ZYbzniOAX+At32z0bCNGbZSSOUHLVY+2M3UALLgo3GJZZQeeCBTLh3OeoYCMDaGFOUAtb7d4C/4tKvw3gjHCP5Mjgayu/bgJDq52OFx8WhHVy4yWNFKYESeo83incs2VvxLMDbQIvXK8F28db86/Ok0zwGWOF5hgxe7j2Ngk+9RoR5sUYmyWqvBZCMAt+fBEEWxw8m7w0xgE+cZtWOaU8iuWPifLi18BurSByF/T5RDYj2zI/qYMYeNUaCc+jNWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Jo7tJDrRqAD8+OInoDrM7k4UwYNEwTTYchNR5Cs7hjjwU3UiFS+1e8F+wNaMGN1DsmG265d0anDoLCGCF2eE/4tfZBICCPmhB88n0waXF10qINGjdAm/EvtRN1bc5X8NKAArwQVx8DbdwYAd8DUKA+k8c3Jqb+jsYdAJdHpxHZ3nOYlLtZmx6zjKd7Nt+ErqTlPtRhKyll4yk9gabiI9U6ce0VusGbC0nHX8uRnMKwhcEQc2WlNDs4Rz1QWqFc+KUt5IWjruH6k1M5hJslEDDaEAcIHy3E+AMX0ObhgYpZUQgRzLrhcPzYKh1b9pGzq1zgS0FdEEJNmrTETymOUT6WiGonlyB4MTd+NjjZ33qv2sesnHnlePnKifXqtuyErN52xZkLxAKLo29tsocRvzF0Adm5R/wP22ufvyADKpk9KYya+OV99xCIMcDbNKibLrpmSJaiV6rskGcWMOVKbeQoOGoqMwF8gcwGfIpQ2DRQ0kgTPI7avpy5hjk4KJ48mvZyzrPSmXE+tEtmGVn9jx6rGlHB0dQ/myOaw3mRyzF2OHTMZCuNn7nzE6v+j+Vc3MzFLWtBKTBJc59hMDuWxbtgPdLn6pMj3DkL02tvbg7HgAt+6QoyYz0ystE/t0MMN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10be38f2-2992-4732-af6c-08de8589b6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 07:32:45.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0G11DfSTqPoQGNxQnCJpCDach08YUxnx844k5JMuozNZtgk/VX91UvA9UTA+IFD0xWlwQxo6qs5OxB9xvlv0JEUFPsNMMbYPSakmJdkPqFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8621

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
