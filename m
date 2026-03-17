Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10736EAA9
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747720; cv=fail; b=popk1DeNM9UcfHRDRF1OuH4YneLDpQJ4ndYEIL6Eq+ZkF/bstJ09bv/IqcF054X71nK5iCevMqAup/WYMY+tIwzIGifjml2ClbwCEjNEjcbm+tRW78qRLCCtTYkkhLBnh1KHc97pr0t6pTlB7m2+4LSifLHOeZl6P2IHxxBsxj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747720; c=relaxed/simple;
	bh=LLCASsY6Su/4TjZsavjY1YPto0eSrtRLOHGyZwvSlhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D2nIWR79r2ttSCFxtGWvKIELHp9MuazA6swJuTcrjuYLYYTGzjVgu4Aa2XLbl4zEn2wkHCyd3galCz5/hDHlJ9mvIsOeZ5TTJ5YT7/he+3aqa+I1cjScfeJ2FKlOVPrIk07FVgKdPEUyfLKh5UGq0Ho3zjbcUupvmf7aXIeNFMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MdP7eQdr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eOsisdrF; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MdP7eQdr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eOsisdrF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773747719; x=1805283719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LLCASsY6Su/4TjZsavjY1YPto0eSrtRLOHGyZwvSlhU=;
  b=MdP7eQdra5xD3iR22ky+KKU0TKrHEV+lvje+FiW1+nnB8Mlwy+ddeJYq
   92j1tj3Pny59b9SRTZZLt/hzWy1yhQ0LFRf/AWVbSqCxSnpEiJiUhXNNX
   vC80YnljG3bD/JPOS7LLYiFzzQqst05rt7uqavcnThM/zoahvCLSwxOXK
   N6+LNM7U6LBh/9d2gdpT5JNBLte+GoN/hCoLXhaUoDFg2TGUNDTewjW64
   KW/2QMXv5xv2KZW/V9r19nFHRLXYM9lKsoT+VDtC+WG/0gUC+mSSX7jYx
   chv2DmwyX3lYlrRPanZYboYUf/yT0sta8EZXkva1MgxpgrOKyr40LKMx7
   A==;
X-CSE-ConnectionGUID: C6gNjkGUTIyOTfXkzHOljw==
X-CSE-MsgGUID: 4gApaPLFRIiuoDrRHRlpwQ==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="143813734"
Received: from mail-northcentralusazon11010025.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 19:41:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo6seExJ3uxk8t+Vg8+xmeT0cQLNWuCA0E81X3Bpql5Ry8lI5EoOwuLNT8GMssowScmQPwKB0gK5KEyH0RRJ38rzy4R/MaPJLhflrgYpDCrmNMxNjjYhWNW5xgv9iZl+Pwv+nPgqLpCFZAj/sc2Sbdp/Wrd74H1ldrXwUzAYHSV1FDEd5fEgmAQbXSEQ5kJKP9vPLXjUrBFU+yfBC6x2zwq17yIVGSOmdx2xlNx4EeuL566D1SIoJt1b6DqIQhwBK0XFpHYkFbipk/HO6pwnEslJro9tbt9Dq6dZS1CkHxiSlMCI3WhYN1sccyq5Ofi5a3XcFF4tmG6pDsT/Uith9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLCASsY6Su/4TjZsavjY1YPto0eSrtRLOHGyZwvSlhU=;
 b=oe6SISWgNhOrnSGGbK9cxGISc39OeIgYUUJuz2XQgm8V6aVIkMFEUXbWJEA7tF/ABht4SKVO7EYNzo8AIMA+jxXjVaHCtDWj1K5TSHli2mS4feVl9u9/R12y6I34w31raDgvDRNdDXItmACYNaQo8xavr42g5QNyee3trx7VaNWBZLpsadMA3IIV9RQ2uSHNG5sVMESazmRoyDDShlmWrCMZPCl76+51/S5Jd0ZQebv6sU0Lpd5kNLLY+hb6aKlEo0gxSJKc8Al0hTj7xa5C8yESs9itxhj+ugYYL/RQWYyavZyn3SD54jSttFclbyphO6CUio06/AuHEWnv+cTC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLCASsY6Su/4TjZsavjY1YPto0eSrtRLOHGyZwvSlhU=;
 b=eOsisdrFV71sMc8Lnbhp2maHnLf/VEZj8JyBv0+lKsWmVWYeEk+vjOd+06lFymb0nNr3nVznq5aLrxSFw+L/bRgImQGTsU/3Iky1IGpR1J1Xpz+oqr2HeMNBr0QXZJ+4DuU3H9vd1ZHRtacEWnMJ8gvegGnkrADUNJ8tV+I+rjg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB6980.namprd04.prod.outlook.com (2603:10b6:a03:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:41:55 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 11:41:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "yukuai@fnnas.com"
	<yukuai@fnnas.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, "chengzhihao1@huawei.com"
	<chengzhihao1@huawei.com>
Subject: Re: [PATCH 0/2] blk-throttle: minor fixes and cleanup
Thread-Topic: [PATCH 0/2] blk-throttle: minor fixes and cleanup
Thread-Index: AQHcteDbNhjkOLyiGU+j8xJDLbopQrWyYDsAgAA6HIA=
Date: Tue, 17 Mar 2026 11:41:47 +0000
Message-ID: <abk8PK0cOI_CxieN@shinmob>
References: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
 <abkEKqXG_FkZe-l_@shinmob>
 <bc5dda8a-7b43-45e2-8888-cf8c37f53483@huaweicloud.com>
In-Reply-To: <bc5dda8a-7b43-45e2-8888-cf8c37f53483@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB6980:EE_
x-ms-office365-filtering-correlation-id: 835e6f88-6cb6-4e6b-ea72-08de841a2bf9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 kLVZm1YBHvexAHCMYjHQPchHdba5IbSdawRO0yMJR1QgNvkt4yWCofK+sOCR/XRwscTZx+M6dgptpib5ODLprTn/MCmYrKQBqPCFtUjFVCmJ3iz6me9OXs1SlCeZiKbK/lTwZmRX+/VwvpcqeduQv90yCdQ93V0HDQRV7aH5CRn+ua422tiAY4BcACIfVajQ2ftfr7cukXNkj/PuHLVhkAxCIVm/VgBS+Q2DVQxSSnEp/V3uDfpkt5VZG8ZhyMYF+HQ9iV4TqCGR5S0Hwz2oVB+iU3bCgcQ0cB8kQ9OouBDPebFcQA9xkpLP/68+wR99SKLLkfJNdCZSW6VkPk87o46E+RURHSO7CoPrukC84XYeN4t6vM6YO9NsSIcrzF9KiwjXWAVubRqW9ac8g5ig3fVATyYwwki52rlrobvcDq7caB4Oe3XcwSHqf967ljSROze2mfc40SzUAb86TVpiM/QVh4AJnjjWApkid4tdM5x6UqWuIUT3h0lf3qqW6eNyaVl7yeyd/MZYAimgeE+Jp0xXezZliFVcg+lkmwqJ8I+nUZ2CIWS7Ku8QKS4yqHr39Sy5yjjwFs5MCy1xn1xqZbwkIziKpDLAm6z+r3n7mWpNVFW+V/jRxckZ7nfjQwo+ZA0r0mc2+WVXEtP+pJ4ehlF4cUxhKTBuNhNb0Yf26C3euI9xPBEQ2Rl2dq8Tl2v/URSCiAJXdQAG4WR4BS15Og41unRAaToB+cJStvoaICymTtJJQp+uR7PTJ4ZnjUUcmmN/jU63axXy/btXRP52uLPRcUYmtq2JOVU9AHDJtdM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWE2a2xIa0EvM29YNmc0NXJDcHVBMnhVR1MyY0g4R3QreXJUdWhrZEVHenpi?=
 =?utf-8?B?Rm9jL0VJNkJVdWM1blVDRE9KdFdsakNYS2pxVlFWeWlLVy92NTVFOGR4WTJC?=
 =?utf-8?B?TzNKTlJ3eG84TWRjR29EU2JPQkIySTZPYSs0OEYvK1hINFBIY0J4clIrV3Zh?=
 =?utf-8?B?NHNHeTZ0aTFvbmpNWU1KTCtRRVRRNkF3ZHB3VmgzdmdGSEFMV2Rib3RvbFcv?=
 =?utf-8?B?L3F4Y2V0VDc0ZHQyazRycDNOSXhid0NrZTVoZkNGM2hyYmxjUTJpUG4zekM1?=
 =?utf-8?B?RllVUUlxa1MxOVlLeU5kczM4dWw1Y2ZYaG9ObmdLdlhxS0tlQTREaHF1Y1lm?=
 =?utf-8?B?MDFVOWdmSStxT1NQcElWZ3lJcjlTUFduN2ZpZzRNMWhFSU5ycjdGVkpmTFVY?=
 =?utf-8?B?TlFyeExKL2VkQ01NelBLZndQbE5zbG9IbmpIWnBhNTc1R0dadlZTUnpoUzhS?=
 =?utf-8?B?Y2R2Mkp4aXVGUndNRitaSHZ4YTM5Vnh4eFJhZW8vRkdxTXJ2dW1zbHJ4RFBN?=
 =?utf-8?B?OUVPWkFvbVU2NHFlNWhCV2RBV2pwQVlOQVlzVUJHMjNsdWx0eklwcHN4bVF4?=
 =?utf-8?B?VHp0RytwWi9jcklwczd1ZmhBZ05FeGtjT0R5cFp5KzhQV3ZXNXE4aU5BMDZO?=
 =?utf-8?B?elNkbi9JZmJMMFpYZEhaeDc5NzBKWjZZQkN3UnhkSkQ4d1ZqWmcwcFE1ZVZp?=
 =?utf-8?B?bHA2VTZ0MngwMTVMNWNlMXIySlliWVZYeFJUUHhvSFoyVGwxMnJnV3FEb09x?=
 =?utf-8?B?cTNLWkhrMGVJOGpBWFdiRk1EdmppaUZ4bUZucWFYcXlNaXhqNFNSd1BLeDVK?=
 =?utf-8?B?dG13dnlZVXhmYnN1QitrT0RCV0tRYUdwZjlVUnZ1UGZqb1NSZWVIWlM3QXJy?=
 =?utf-8?B?dFhhc0hVRXY4Vnl2aUdQQ3RkVjB2OHN0eWR1Z3J6dm56d1lWOWF1aHVCZXdo?=
 =?utf-8?B?a2VKTkNzblZhRWM3cDN5bTN5RHVISVpudzUrYldJTTJQWmh6cHJWR3dLaHRH?=
 =?utf-8?B?WkJOWExKL2t4R1RJT3hqcWU3TXJwaDFUQXFLWFVkUnUzUU82VnVEcVJSREY4?=
 =?utf-8?B?MkZDaVE0RXgvOXNwSmpFOWtoTUxzNzh6QWNtWXY1eHRVV3hncHA1Mmh1Tity?=
 =?utf-8?B?NzZmaEltNUtSUXJ0MjdkNzBDQVMwRXZpa3Mva0FXZi9VaWNySkt1ZUpLdVFu?=
 =?utf-8?B?c2oxNDhMaExVVitxR1pkUG1wOFJCbk1zaFpJdFpNRmJEdFZ4UDFxdDlFYnh3?=
 =?utf-8?B?RjcvdnpFb3VaSEJiMkFOUnBzc3V3eGRDRDVWL0JEaUJ1NjA0bDJmWWdLWGxV?=
 =?utf-8?B?Q055OERpZUpzc053cVg0TG5rT2c0a1cwb0RVNW1HQmpRYVNEaU8yZG9qbGpU?=
 =?utf-8?B?VnIrMVBOMkJuWi92RGNnNmcybkQrc0xySHBRNVdRSVgwTWQrRDlieUFpdFpL?=
 =?utf-8?B?T1U1b014ZHhic3FqbVFwejZpMGI3dHZkS3dIYjlVT1pJNExyYjRhb1NUSVR4?=
 =?utf-8?B?c3VMTmhPYmdOVzZRRjJHT3k3T2Roa3lxbFg2RVVUc0NkRmZmRmg4ME52RXhu?=
 =?utf-8?B?YmtxR1I2QklXUVVhVmZGZ3pzK3BSQmszUTR0YnlPZ1JBYXZyYU42NDZvalRQ?=
 =?utf-8?B?cVh0cGRPS0d6V0FobEM5SFYwV3MyajV4TVVPakFxRDVLWFllWW9sV2tMSDdT?=
 =?utf-8?B?c24vY29vVmM3MGZUcEZQeDk3KzFScUJyYjF2UkkyY09IZmR0L3doZTE1U1ZQ?=
 =?utf-8?B?WC9PYzJxdkhzRmhuNnc1VVpLYUpmL0RwVG84anNoU2tFdGQ1RzhZREw5SXI3?=
 =?utf-8?B?THlFSlNMeDVtZ2lGek9ORjdSdTlvczg5NzZCWnR4enMrbURMbFBySWdqN3Zj?=
 =?utf-8?B?TVpYMUtFZzJHVUh3a0ZtN1V2N2FhR2E3dDdtOSt0Rndob28xU2pFa25UbWwx?=
 =?utf-8?B?ZnRHN1NNazJuRThKbTRrUXA2blJNVjAvdVdQK3FvZjBGZnJtUUZrZkRHZGdO?=
 =?utf-8?B?ajlodXhOM0JBVDVtYXNseVplWTJnYUNRRUhLQ0pWYThkUTloaDFkdDhTbEd5?=
 =?utf-8?B?cnprNkNUVDFkNlJ1Y0p2dHIwQUFpbmZVY3VabDJlOHdUYzBxRWxTemZhbGVi?=
 =?utf-8?B?bUNKRnhDZ0VMRlFXbmZrcjZ3clIxQU5GdlQ3YUVWZFJ5S2YyUnhKTnh4NmVi?=
 =?utf-8?B?TlQ2ZHBqdSticVRSbWpOdkJ5QlRWWjEzVXVRdDVPcWw0Zm80U1ZoKzlNNk9F?=
 =?utf-8?B?emZlMGliWXMxSG45cTJqNnV5WHNyaXFsZlloTzJ4ZHhud2JSM2UrWlE5dzBC?=
 =?utf-8?B?TWwxMXd0TUYrRVJkTk4va3NnSU9iRUIxVFJraG1SRHI1WnFRUEhEdkdoTEhU?=
 =?utf-8?Q?v8pEeXLA0LBS3eUQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <894AE7DEA1EF3349BCA02986C5E0303C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vfQYQ3jXetF14Y/iydk7ZZ+QAAc2l/7/0FO8dvjMquaY6jeNBOsKUF+Mq+8WM/UxydehJgZ76fkow0LbvgF2Ftb6Spnc+xF+YCddfELAIsEFr2Ym/8hCx5bY5NYLeJYjMQ3RaGg16cX7Z6aj8ZrDK0zN+UmU3LwcC0v3gpZTfOTdHW6K843sx4k/FkWDr3Cnqod0q0v6oNGxnF7kzCMqOuySDs/GO/qgjfLiRNg4o4AElYI7BLBZ9pjVJdTZ9pNTIYkX2MHJaf5QjZrMxZNgNIpF74jUp8W4cNWvz+zKVs7NKC+QJMHgLzSYkNX8VG+VqIZ2H8PL07F0+9dr+TjVyg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LMcIBMw4KO2qOvMsY8ODpTlHpT6PYoXnqQPgn5Ys83rgeQqfYzR0lvHksLDbi/Eg5BijfdBPjysSkE5JQ775YqqyftEzlSiTnwpS2x6DBt+erzrMlKOH+cQmlBoaekSomD1rElZgt1ili5ZMphlp288Kg5zAaoY+bEt+v/TMxRhrKx2DgMn2CcqwyPg+0nzNh2zI1s0/1upmbUxh1JIfCgItnzhRRozyyMtrni+pURpSPtWUNz/yVaH2VbdMeBLAZyaIAZz052uskGfzAxJcAyHg1dhSRbolK31/pnFkkuCmhNaD0CMUrmiSnb/kn6SUK2T3FK5BBXS+5fJ8YF6aUfeVXE6i7ITM3rN5Op8GZQUes3jBr4SUNWni3td892hbjpb2dKnzWQqwupgfX+cb4t1/GqzD3+ft2XYklUo6P+Xirvt0z+uzTraEom275IM6v8/BRzzeD3MsvJUgs9amyKA7D/iaicalNgtGv8tfcjQ/qNTPxAwUQin4vap42K7xJstjp2pP1FVj9PCMm1NVT/BDMUsn2XGj12p/0ksyOS+G18KWBcVECNudIK1olM5BeH+DFOJJhD9FZODes8nL3cyz6r0n67wx/mFa6twNbq8ozWMIWoShtKE3XDXZ0mEi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835e6f88-6cb6-4e6b-ea72-08de841a2bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 11:41:47.4403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IgeTdXG1duKxSjRDcZQ4pZrAZZVxl18ZYVp0zhZm67EV8xM/gthuBvLBAcydoqau0yHEVwLKFSxSlh8/XyUgLLJ72cGOKoR+Af2Y8XdTw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6980

T24gTWFyIDE3LCAyMDI2IC8gMTY6MTMsIFppemhpIFdvIHdyb3RlOg0KPiANCj4gDQo+IOWcqCAy
MDI2LzMvMTcgMTU6MzcsIFNoaW5pY2hpcm8gS2F3YXNha2kg5YaZ6YGTOg0KPiA+IE9uIE1hciAx
NiwgMjAyNiAvIDE2OjQ0LCBaaXpoaSBXbyB3cm90ZToNCj4gPiA+IEZyb206IFppemhpIFdvIDx3
b3ppemhpQGh1YXdlaS5jb20+DQo+ID4gPiANCj4gPiA+IFRoaXMgc2VyaWVzIGNvbnRhaW5zIHR3
byBtaW5vciBwYXRjaGVzIGZvciBibGstdGhyb3R0bGUuDQo+ID4gPiANCj4gPiA+IFBhdGNoMTog
c2ltcGxlIGNsZWFudXANCj4gPiA+IFBhdGNoMjogZml4IHRpbWVyIHNjaGVkdWxlZCBvbiB0Z19m
bHVzaF9iaW9zKCkNCj4gPiA+IA0KPiA+ID4gWml6aGkgV28gKDIpOg0KPiA+ID4gICAgYmxrLXRo
cm90dGxlOiByZW1vdmUgbGVmdG92ZXIgY2FycnlvdmVyIGNoZWNrcyBpbg0KPiA+ID4gICAgICB0
Z193aXRoaW5fW2Jwcy9pb3BzXV9saW1pdA0KPiA+ID4gICAgYmxrLXRocm90dGxlOiBmaXggdGlt
ZXIgc2NoZWR1bGVkIG9uIHdyb25nIHNlcnZpY2VfcXVldWUgaW4NCj4gPiA+ICAgICAgdGdfZmx1
c2hfYmlvcw0KPiA+IA0KPiA+IEhlbGxvIFppWmhpLCBqdXN0IEZZSS4gQmxrdGVzdHMgQ0kgdHJp
YWwgcnVuIGZvdW5kIHRoYXQgdGhpcyBzZXJpZXMgdHJpZ2dlcmVkDQo+ID4gdGhlIGZhaWx1cmUg
b2YgdGhlIHRlc3QgY2FzZSB0aHJvdGwvMDA0IHdpdGggc2RlYnVnOg0KPiA+IA0KPiA+IHRocm90
bC8wMDQgKG51bGxiKSAoZGVsZXRlIGRpc2sgd2hpbGUgSU8gaXMgdGhyb3R0bGVkKQ0KPiA+IHRo
cm90bC8wMDQgKG51bGxiKSAoZGVsZXRlIGRpc2sgd2hpbGUgSU8gaXMgdGhyb3R0bGVkKSAgICAg
ICBbcGFzc2VkXQ0KPiA+ICAgICAgcnVudGltZSAgICAuLi4gIDEuNjY3cw0KPiA+IHRocm90bC8w
MDQgKHNkZWJ1ZykgKGRlbGV0ZSBkaXNrIHdoaWxlIElPIGlzIHRocm90dGxlZCkNCj4gPiB0aHJv
dGwvMDA0IChzZGVidWcpIChkZWxldGUgZGlzayB3aGlsZSBJTyBpcyB0aHJvdHRsZWQpICAgICAg
W2ZhaWxlZF0NCj4gPiAgICAgIHJ1bnRpbWUgICAgLi4uICAzLjI3M3MNCj4gPiAgICAgIC0tLSB0
ZXN0cy90aHJvdGwvMDA0Lm91dAkyMDI2LTAzLTE2IDEwOjI5OjQ2Ljc2MTg5NzU0MyArMDAwMA0K
PiA+ICAgICAgKysrIC9ob21lL2ZlZG9yYS9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2X3NkZWJ1Zy90
aHJvdGwvMDA0Lm91dC5iYWQJMjAyNi0wMy0xNiAxMzozMTo1NC4zNTUxNzM2NDQgKzAwMDANCj4g
PiAgICAgIEBAIC0xLDMgKzEsMiBAQA0KPiA+ICAgICAgIFJ1bm5pbmcgdGhyb3RsLzAwNA0KPiA+
ICAgICAgLUlucHV0L291dHB1dCBlcnJvcg0KPiA+ICAgICAgIFRlc3QgY29tcGxldGUNCj4gDQo+
IEhpLCBJJ20gdmVyeSBzb3JyeSBmb3IgbXkgb3ZlcnNpZ2h0LiBJIGhhdmUgYWxyZWFkeSBpZGVu
dGlmaWVkIHRoZSBpc3N1ZQ0KPiB3aXRoIHRoZSBmaXJzdCBwYXRjaCBpbiB0aGUgcGF0Y2ggc2V0
IGFuZCByZXBsaWVkIHRvIGl0IG15c2VsZi4gSSB3aWxsDQo+IHJldmlldyBtb3JlIGNhcmVmdWxs
eSBuZXh0IHRpbWUuIFBsZWFzZSBpZ25vcmUgdGhlIGZpcnN0IHBhdGNoIChhbHRob3VnaA0KPiB0
aGUgdGhyb3RsIHRlc3QgY2FzZSBkaWQgcGFzcyBsb2NhbGx5Li4uKQ0KDQpUaGFua3MgZm9yIHRo
ZSBleHBsYW5hdGlvbiwgbm8gcHJvYmxlbSBmb3IgbWUuDQoNCj4gDQo+IEknZCBsaWtlIHRvIGFz
ayB3aGV0aGVyIGFwcGx5aW5nIG9ubHkgdGhlIHNlY29uZCBwYXRjaCBjYW4gcGFzcyB0aGUNCj4g
Y29ycmVzcG9uZGluZyB0ZXN0cyBpbiB5b3VyIGVudmlyb25tZW50Pw0KDQpTdXJlLCBJIHJhbiB0
aHJvdGwvMDA0IG9uIHRoZSBrZXJuZWwgdjcuMC1yYzQgKyB0aGUgc2Vjb25kIHBhdGNoICJibGst
dGhyb3R0bGU6DQpmaXggdGltZXIgc2NoZWR1bGVkIG9uIHdyb25nIHNlcnZpY2VfcXVldWUgaW4g
dGdfZmx1c2hfYmlvcyIgb25seS4NClVuZm9ydHVuYXRlbHksIEkgc3RpbGwgc2VlIHRoZSB0ZXN0
IGNhc2UgZmFpbHMgZm9yIHNjc2lfZGVidWcu
