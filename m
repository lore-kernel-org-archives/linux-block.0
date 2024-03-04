Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691414A93
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538558; cv=fail; b=hZ+FCQk52NTMiVEGx83/ccJafsdmwngzSESZaVKYIAyVnT/IANP5yEdrZ13qNP+U9nJU4pkJpW6q7lITyCoBSVSU86qIH09+S8QU5gxAFHyeQOwBnxSi+eHCck6HvLofQ5Q5B6kOm6a6L/Xuwr9HmmmqwgNEFMCWDxdhrH1G9I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538558; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BPiGKXamKSO4fHBngZs/AZYPPJs6wZ+qQfwgoILFti2FTh4/AOZaJ+MXl2gxw/+RMuXT2mA+W+caL8cnILUC0eQc8xIvHHWhSxA5U73h11FakOT97WptOj3+TXW34ZEiRCqaE7WAFIL7lFBghLKoa6e4uty4vITziDJi1wpeH5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BTeRs88f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S3IFUBxj; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BTeRs88f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S3IFUBxj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709538557; x=1741074557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=BTeRs88fdaN/IFlDG1b34y6DmCozs8bcHZ+UsQ3kMsIdJUkJrcDIwo6E
   uFr83y7zicu2KP6ewPNQqjr47knVsbLTOkWAt3WZqLs179PnE+ZzS4JF7
   ERmjrI5J3emNMZ4ng7i+JCVM1CMNsWM6Banau3bs8MsB/jHpNQPgEQWtg
   xx4YKr5Ty6D3SRIAfZcjECNTbMbbgdnX5wDVcUDliMX2V2bXyn+1/V/tB
   73d0DEmAtqdVg46hVXh8Xw+sAi3nPPPUuoJRQv3cTClbO70JBojtIOAkK
   ODQgejvwMIyB4WW416/HP3RDUbKqfjW/QwnmRxMDBhJgNLvaZdKLzl9YP
   w==;
X-CSE-ConnectionGUID: iXhbfTkrSKiSYJalUC+ajA==
X-CSE-MsgGUID: M7ch2Xh4QGim94GN0h4LCw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="10281964"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 15:49:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlC43Di3L1onoZA8IrV/2OQ4LHH63AtlPgVPns4/da6QZ70HRHqhgDm1ahHR1k/BAxQwR3JhHlzFcnyCIuAXVU0/92hGHrzK80NjGNaI0Zyv8tx4rJHqkyN5ceUySOA9PkQd2hWfQNkNMeWNMiOvRww7SaMbuy+Hpw+yEjP6Lqsk+ByNrg1WBIOrxHS00SrfwicIRBruSnbTLky4/HphpYBtGVzmVMS58MzXdop3f+0qBaz0gkymilJMfy+DUnikB7D0nCxOLS1SJO5IL2+r+h8L+vi05K76z3GdyVk5Iqrt1d17+84U6vLKv9rlQVbthzxrj0tL0X95k6po55+V2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=kX+zNkZCzOCEc19gdixpOA+5H1CWMOIZoobK+u1TM5+nObBhPdiwVblkd26uvUpK/v/Yu3Ng65iCnyEN0liCauEJ35UK5g/8nds6jATucqbJWZMbt2zfbGm8Ta48egbApErOuZW5Dtb/4fhZHZvW2YwF1AhF9W7mj4wl6Iv6EoqdeGN/M4LpGNuvJ08PCBTOrcnZBtaFwyDNeolKoxV0NNTrdj/0wReLQh0weivZPFyqvXUK5BOJr4WOV1isKC36TUqdrIuXLhCEWjQXOdXgVJb4z7RznOZ+ZUtGPEbDdVsfgrMgnjaaKxC4dRvTY+CqzusOW4O45qwCj0RCh4Utrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=S3IFUBxj/0evuJBkDVSBYRusiJ072zEDpJ7GO/FIK8ElZ6Jcq4suy8uS4bCambuHPGc65+fDlKEZ3ZrTiT4D2Q2K+qc0kTQVcvXOTropDmnM7GEbsoLZl63T6iwSdhYrDjDnJyNflLTFj/5W7cE7pOMjbItdfMrz3CH2CJrTVwQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7371.namprd04.prod.outlook.com (2603:10b6:806:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Mon, 4 Mar
 2024 07:49:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 07:49:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] virtio_blk: Do not use
 disk_set_max_open/active_zones()
Thread-Topic: [PATCH 1/3] virtio_blk: Do not use
 disk_set_max_open/active_zones()
Thread-Index: AQHabA5sPMCPYRtyC02iVb4Zm9usqbEnOMgA
Date: Mon, 4 Mar 2024 07:49:13 +0000
Message-ID: <927d5db0-ab9b-4b07-b10c-de129f441ba3@wdc.com>
References: <20240301192639.410183-1-dlemoal@kernel.org>
 <20240301192639.410183-2-dlemoal@kernel.org>
In-Reply-To: <20240301192639.410183-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7371:EE_
x-ms-office365-filtering-correlation-id: 9af166cf-7cb4-4fb2-ec25-08dc3c1f95b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9TUTLm+wW+jtBb+UChcoLvTTpSGS3UGY6Hy2S2YhuF5fW1vnvpdvXyT+YiER9QMICkgIfstRdJilz3CaFChdUZrqziDU4x0aXrY6S3IM8Do28VSh5V4AZxUZSnLMV+2SBTM62mcs46VyIbU/63iTl9Iei70E/zspGeX60+xwm9JxA0bY0+vaIKzSRJRRBhXeWDn8o1igKY6qLKskpwL78HePb6Q5PTjtHlEp2XBQva5U9RGS0/+ii9Ux4/zB535t54YplNhs0fFuKFyqidYWf4CqVmYCpdgh9zcSZicr9qZU6wjOO1Lg/60/6AwiCG4bippPLLa0NMiyJgF56XX5q5lg2ZfABZPZMDpeEirL/f2WOAm2aA3x8FWrp5stqQzrTlVlGpnl2kpJxQEb+j8TxmOfwkYh4AuNJqhs371bp75m9rWa9PN+n+7JX/AW6/fRWm2mLwYwM1Gnybfn8XL0lAx5alrD9emqq2NAC/4a2W0eiyUViYEb/2uPDx6hB/0wGXLlpl58zqhJU9FekZ/2v3kVMTCsfJc0LaFwxs8S6q9LUlN7XOi5ZZz17GkckWogxEvTKfQieLZTqg939RUiTCwDndhL+2YSafbbCOjGte4xJqa+bkr+lktG3StUFmP0k7bXc0Y8eXM0KPKgupQpvBtso/iJUWUbTQAWNMBWfkkMHxSdP2Hnraf6uUWytcU01V/y2iQjefUmcwYIbCDC8+k2MWy260sYd5U0kuh4ZMA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1phZ0ZZWEo0UU5venN3dko1UFFmaU50MnFINDk1dFhYM2YrVmRtendLTmg2?=
 =?utf-8?B?VGhsdjFKSG56dHNUTml0MkF3ZG5TNzRaVndjNkRsS2ZpTTJTMVBMZWxkZFB0?=
 =?utf-8?B?cTZ3U0xoNWcvSWpPd0pFUk1jQlF4NGJGbS9wVWd2OHh6bjEvQ1ZXS0d4ZEdq?=
 =?utf-8?B?d2dZTit2aVFWeVJpUlU0YkpJTkQ2czVaTStnYVdvWGdsNGxJVEFSTnQvVmlr?=
 =?utf-8?B?dm5LR0NYTFcxTDJnOWJvMEkrTjlhUG5aUnRiT2k3L2E2cllnU0FRTXo2R3ZY?=
 =?utf-8?B?NVVDTktENmxmVVRvbVh6THh5akVKTDR2MG9tT0lzbFNBejNlbm1QRVpWL0s0?=
 =?utf-8?B?VU9MRGVYbWVPQVc4dWp5Q2tSK3piWVhvcUt4QStQVXR5Zm85ZDVpbE5FVnp0?=
 =?utf-8?B?aEkzRTgrbDFkTCtDejVyakdsT1pQTXd1OHZBM1NjYmxnbmgzVlNsV2dzWkJR?=
 =?utf-8?B?UHptNWJER3NKMDFUL1YybitBYjNybW9zdWhpUFYzUlRSWU1BZ3E4OGVJNXFQ?=
 =?utf-8?B?bTQ2b0FoWUNxaTV6aFhSR3poTDlhNmpVRHM4dkdhS0w1OTM1ZXkrWWtoSC9D?=
 =?utf-8?B?eUhoYWQ0N242dDNqUDZ2eVpCbll5M3dCeUVJYWd0N1lyU2VHMmYvcjNudGNO?=
 =?utf-8?B?OUwxRzRMb2ZWN0dJWmFqTVZXdWhINis4U2VoNG1XZm91YTdJSmJrNEt4OGNy?=
 =?utf-8?B?TldTRFdad3kwa3BTRXdwWGZwMGFlbFlUUVJOUWI0MmdPUENWWHllQmtGdThC?=
 =?utf-8?B?aFc0dTNkMHFpNEZzYmpRZGVhTCtzSFdwQW5YS0M4MDJWNUpyVnc3MmNGUGhW?=
 =?utf-8?B?S0VCTEo2OG1kOWJTbU1nb015WVFMekZDclFuZXVpMzZRaHludTFaRW8zVFJQ?=
 =?utf-8?B?dXR1aDlXbTdNdXhHOWFLYTF6NzVBSysva1ExTTNwNkhvam4zTFdmQ3pQY2pJ?=
 =?utf-8?B?ODZEYi9Sa2h2YXR6R3pTUGYwZmZPUFJCSlZzS1ZUYkZWUEFZTDFRWkhRRHNh?=
 =?utf-8?B?azlZeDFaMTJiV3RiKzkwSkhzb2RCQzd4K1BZcXVUTjVqV3JBZCtkOFc4SEVm?=
 =?utf-8?B?WDc2TnRIaXdCYzZNZEdubEVwVGtWNkw1Z1JKeExJb2xqckQ3NDRsRXdDNlJ4?=
 =?utf-8?B?bUNjaTQyNjcvTFJ5ZVBFbEREWDRkRzVWb3pFUzZZZFFWRVZITGV1S2t6SE1t?=
 =?utf-8?B?M2QvR3ZsZnZ0eGVWK2JvaTY4Y3FzQ1ZyMUM2UW9BdmlPV3NtUGlRVjIzZWFY?=
 =?utf-8?B?UVBGOWFORUE2bmlUQkwxLzlHWHJyYlJpdmFORjZObGpXT2p1Y2NUakw5aDZs?=
 =?utf-8?B?dlJwZStEZHlpcC9ENDFQSXRGU2FVOWxzU1Q3dVVkSXFoM3A3L1lHb3o1OXI5?=
 =?utf-8?B?QmttMUY1ZGVMQmJjMkhjaEgrNWtMY1ZraDE5TWhqeWR0b2ZQZGt4OHNUUDlh?=
 =?utf-8?B?NHdXMHdHT0cxeUY0N2E5RzhRbXcyWStabjAvaHJRU1FSdkh0c0FlSzJYT0N0?=
 =?utf-8?B?alFzelJ5ay9pNDltcU4yT3M0bUoza1R4N1gzQStva1ZyTzNEd3ZSZmcwUnlD?=
 =?utf-8?B?dlByQjk1NXY3NGtyTS95bnJnOGVDRDQ2cklQTDlBbWFHMzRHRExxNU5FenlU?=
 =?utf-8?B?ZGR5SVhZdUROdkpFdzJPanc5TENqK1h5RDJnOUtWbmcyVHF1TEo4UjJXYVJS?=
 =?utf-8?B?UnFqZmRINENyamxmRk1TNHNsdVQydjdnS3RaOWhZci9SR3pIaklYQmxUQU9T?=
 =?utf-8?B?UXFYS1dHVS9SNFBrL2hvcE5lYkN5ZmlZTjlnZVBzd2E2aGlENXMvaGhhZkNq?=
 =?utf-8?B?UXBlQU1mb0ZrSFVNN05hck9PY1Q5MCtSRkVIRkNTN2t4UnJnRjNxdUVwZTRk?=
 =?utf-8?B?enBzc1IrU2xNZHBqdVM0RnVNZlhVd0pNeEVXbTVwUXhhNmJXcEM5NE1TN1l4?=
 =?utf-8?B?SEpTdDlNU2ZhaHMyTTd5VzNmQUtSdHh3K1ZaeEllVDBEaktHSW1VTXNwbGJY?=
 =?utf-8?B?R2NJWEVZWGFGYUY1MHhCZlIwOHJMSkY5V0pKV0V4TjY5aFprRXJiZTc5cFJh?=
 =?utf-8?B?aXpXTUdGL016a0t5K003aWhmYnJCTW9pcWNveUJ4TElyRVhLNE83dkZ4ZHZP?=
 =?utf-8?B?MFNWL29VZEozdVBRTHNyR0R6V01ROExoMWxKcDAzSVJCMVo3UDN1Vml3Y2gr?=
 =?utf-8?B?K3RZaUtnNmZjV2JsdlNtaU1DUzgyeEFjRU1tZjJ4Y0FIdFBxRk9jNVVkMFlI?=
 =?utf-8?B?VmR1QkZjYUJxaFBCZjJDRS9vRnd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF03458C69A90146BAFD6A716A3386AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/JIvzcsK1Ty09X9tGBxuozQYz3Z+SVTEkkFhN58oBr01ApuPosA5skH++zqJPVtY0kSJ54XiSAdknZ9aVCJXBqyR+GNR3wd7eUvtoobGVjBjc6h/WujuB/vDLSQO8wKQNwr6oP5XIqURglvR9MwBa/7vU8tOtylMJrmv24dfEkMjyG2L8UeGhyhnqGi55nLlKEMn7XjoRsA3y4qr+crmdnd080CVMAiH46P+HXb5M/TY03PwgJ1us74w9/lGu1UOcASzPnKzKG4mEK3PpeLY2ojctFHMV3k7j29fI51ZaQwoA1vWFPujOSSyvjQcIcG9qTbk0tRkzsQxqIjTGQi3SyM9mN0XVs775yR31wzoaJFWU3sV/NJLgRlX/iwDgt+ho5N3taHhiYODB1RvHS2HGdKvhg/nZHR9/r3pOpIO8/nPsMDENSw2kvyiiT3nCvSHB1WeQupF+XiFMTasOYXvzCOak52Dag5RPe2S+e0Etu1cLkF2fVWclP7DOvC9ZvZzeqRQeghcFaWJwU5Fy5ZfN1XoRQGZWx1a0nSnX2UWsrLG+eEaoeoyCFiEysDor6N+EtH/nf22vzQ9ecI3ze4A66sPAB0TWvly7rTLQbj3jUE07vtOgAdNH+nnkk+En11s
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af166cf-7cb4-4fb2-ec25-08dc3c1f95b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:49:13.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsLmLEUSqKbgiMaG9Nv9hvWO+6T1TGOtWSbpJNYhjjg4GkcnYZ2sKUcrS0TgJLDruUBXJgjsen8mTLxnWVgSxiM3oDME+ERyU9Zh4y9N2OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7371

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
