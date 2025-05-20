Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C558256C7C;
	Tue, 20 May 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741977; cv=fail; b=cORfq7w1tG0VPdcP2vzSXCpUn99FUG62Mf4ACowyrmsnXQDQW4cPrIanlBR2M+GzN5WW+Cpq0hvPkLrNtApWoSU+nc29HTO0GMlaNQvE3tmKhROUZipyF9kSszAHRqpofydtuXgxhcse69HhZVJ8WyM2I/lyMLV1tXHopkQSeuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741977; c=relaxed/simple;
	bh=tiZnpraE3nDR8WgLMuuAWdGylEz42jjVRqya17ldgqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wbm82OBLovRn7FAmCcbOMpDDNWS0sCVmaqns9WvlY22i9/DllDmk6YELFWKJYAB9fWT7e9HOyxSHk9rC8PrllbAIVHJ9fMXU3hyyLIEqzxYYe+3/SE5H50X6cFbUgDI0R8mLd4PL6HxAuQFi4vPprBZ9X4JVRRdc6Z+8muXgU78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K5MNlF002446;
	Tue, 20 May 2025 11:52:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46phe8u5yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 11:52:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo5Vf1bL48yFamvcFdjbh9VbduT7TosMmFH4k2/RbGXXN9Ni8T3J22VDRluPMfraUZzYGUoCY4sslGBVmWAz94LyLr15/WDFwpdVrwmhjuG3x5WC8MTzxngT+DMJG1Gt77875JHd5n1mL7YZwuyVfwfQ3L/b/YgV5oshab0bitLKHwkQNjWpzoXQxjqXoBVwmtbwUoZQpG2i+1kN6nGWpeH+A0TxVrNgP6LIZfI7KYiAj4udh+SOsKsnxoGbnO0i8C/d/tlL9B8GHO6kteOQ7RboFekeqtTj2S/M8RvfZFAoLihiJ7WuRS04QnuFNSdCW7Jqv6gmvRk3YHyrnHnzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiZnpraE3nDR8WgLMuuAWdGylEz42jjVRqya17ldgqY=;
 b=MA5UenJbGCwM7NGhWuroG5H7mdcgIbGP0FeFGjDUv2QLZ7zMlGWpX85UdB23BUU/LHAdpllqR002nHsJpRdnhottlIc5UOBhxDIDoZcBZuN92qLMXV3PQq/xCmtH4lowApiD+CuYWMtZFiGhtdjlq03M9oKdmt+kr21g+w3+sbTx9rPmGvgDhk1qyibQ5+0xzzoQzfbopm7uhCJoJMrpb9iPL+nRxQrXe58N+WeympYOscVBfVlFlpQT4XQehAiw1X8bw0AijxVWKk+REDA1qWmjcrgEOGtE0dAu1PgL9WNhBa3GxeBLx/Exdb07RbiOfNWe53NTFZNwQOVoLLWSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9)
 by IA1PR11MB8223.namprd11.prod.outlook.com (2603:10b6:208:450::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 11:52:34 +0000
Received: from BL1PR11MB5979.namprd11.prod.outlook.com
 ([fe80::b0f6:fbc:94be:2372]) by BL1PR11MB5979.namprd11.prod.outlook.com
 ([fe80::b0f6:fbc:94be:2372%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:52:34 +0000
From: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Christian Hesse <mail@eworm.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "christian@heusel.eu" <christian@heusel.eu>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com"
	<syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Thread-Topic: [PATCH V5] loop: Add sanity check for read/write_iter
Thread-Index: AQHbyX2sne1on+Ljwku7LlrGkpoYaQ==
Date: Tue, 20 May 2025 11:52:34 +0000
Message-ID:
 <BL1PR11MB5979A3A409B5E6229609C480869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCwlRMEuvvP31UGG@infradead.org>
 <BL1PR11MB5979CBE5243379E686674B1C869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCxnTIwiVhBK-XIt@infradead.org>
 <BL1PR11MB5979E4700AE4B7B6A09681B8869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCxqgDkHPHxrOFJH@infradead.org>
 <BL1PR11MB5979FDAE8B8831DD0F558552869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
In-Reply-To:
 <BL1PR11MB5979FDAE8B8831DD0F558552869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-AS, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5979:EE_|IA1PR11MB8223:EE_
x-ms-office365-filtering-correlation-id: a54187ee-a72a-4b94-18e9-08dd9794cf6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NWNzUTdIQzM2bHlNN0pHRXVkWS9oeklrS1Z0cEFHcUNkc2lmU0hhQ1R1aTdQ?=
 =?gb2312?B?WHpRVWxmRjdlaHRWVWtVemN2T3RPS2VHbU5BZG9qUDhQN1c0WlpaMFNIcnRo?=
 =?gb2312?B?bkN1Z2RwMVQrS21zV2tjbUs1clVIM2tkZDg0S1E0eTRpekZ5WU0vZVBqakRw?=
 =?gb2312?B?eVJhMzhrMHlmTXh1T1QzZWdqeENIdjFUeFZjVDhESEh0aEtFTzF0cE41MHl6?=
 =?gb2312?B?Mi9FOHFqMnNmUC9XdEVFdHUza0JCOTFUdVR0NUw1YW1YZXdYbFpyM3R5MmxM?=
 =?gb2312?B?YXk2bE1SUkJ5dWRSdWpQWTdZa05ITGp3THlJWWdyMzhkQ0FHSnpuVFkzbVNz?=
 =?gb2312?B?QTNtUVRSSGt4Q0Z5TitVV2JlZzNaRXJYZTd5SWdpMndxeFI2UURwOE8reXdK?=
 =?gb2312?B?eFdsc2hDdTQ1Y3VvdnhSZnNxMlp6VStEZmQ5VDhDblM5YkFuRGlSaU9TSk8x?=
 =?gb2312?B?Lyt1Q2FyOTVsVkVJOE5JejdSdzlYMkl5UXZJTnRGU3JvbXBoTWo3SFY3aks3?=
 =?gb2312?B?ekJ0di9rMXo0SHRKdkxVZ3B0ZktGYW5TUmlqSVYrRG5FT0JzZWZ5OWZmMWc2?=
 =?gb2312?B?RDlhdHVJQytOanNESmxZWWdzelBSUjdRbmhrYkNoUTF4QXNHaW5SL0gxbitI?=
 =?gb2312?B?L25DS0dDV3oycW9GNkNSMTJzUHV6am9QcS9RTDRlTS8xM3cyM3Via0JFSXNZ?=
 =?gb2312?B?N21zcXd5cUNRT0dxaGt4d2VJaHREUjRBNVV3aVBuOCtKczYyeEJ0L0hERk51?=
 =?gb2312?B?bGkzbWlIQVllTVlnc0FQM2QwbE9FdnNXdWZXaWtKaVFFOExJM2cxbVA3Z05a?=
 =?gb2312?B?Smp4djhhbmt4VzJaZlpTaWl5MHMyOUwwZjZLTFJVc3ZabzdIKzJLNG1taTVW?=
 =?gb2312?B?N1J1MHhWNUEyMCtuWUUrU2U4c1VOcWN0UmZOaDMvK0tFTVpud3VrVmwvS2Mz?=
 =?gb2312?B?N0V0V3JTTTVtYjU1R3ZmNUlEdmYwV2lNWVJ5RmlvdUxkNEJEbXNtZUtVZUdz?=
 =?gb2312?B?VGdmVEJyTVhaeTB0anJUN1FIdGc2dUl3MC9aZk03aXdRTzhnM3htRlZodXEz?=
 =?gb2312?B?cU5icEhwSy9VRFduUUw4eDVFbXJzOFRCbWkxYVdCd1paRWxsQ1QvaDFQS001?=
 =?gb2312?B?SHJtVE8vVzlva2VDR1IyQkxSUEFDb2pQTmIrSitBNjJTdWVUMlpnVEJLbkpk?=
 =?gb2312?B?NFU2M1NwUGhjN1ltNjlRelJCTUFna1pGb3RBOW9yRS9WMnZQRHArcFVXK0hI?=
 =?gb2312?B?Q1Q0aWs0dmhVQ0U4TUNUSjR5cElqT1lDTDhvcEQwV3E3WGJ3VnhGYW1kcEc0?=
 =?gb2312?B?eFdhbitIekFtN1hDenQ5TDllVm15TzMxcWdqY0hsVGRUWG1JOWdYSVBOY2tp?=
 =?gb2312?B?bEZ4bm95VTdEbEpDbDMyRlJlNkM4aDJQK2Z4VzllcGtWbnBZUE4yMUZLY1hk?=
 =?gb2312?B?dHRKa2lVV1FKSjBPZk9zd0l1ci9mRVNYV29zeWtwSlQyTGtmZmxDRURzOGlF?=
 =?gb2312?B?QlhzRG9jdmp1L0tIZkpKdjA0azgxdGpsWjl0SVhwSjQ1L2tidDRBNWVHUUpQ?=
 =?gb2312?B?anBXVE9XSG5sZUZMZ01uL1JEdFhiemZDSDEvS3RLbC85NStyRy9tWGw4ak5q?=
 =?gb2312?B?SzBXZStlaU1VenFXeXkrMHUxeE1Ma0VIZDNHOEFpMkR0S0tCbG5reWhFcExJ?=
 =?gb2312?B?c2todVlsbHFwZkhSc0ZRVTRYODhXRTNqNXk0ZzBPelVJSkVFTnl2b0pkS2tr?=
 =?gb2312?B?cGRHdFpJWFlhRllUOG9lc3FLNDNrZURWei9Vd0dHeWEwbnpqMDVqRlJPRTR3?=
 =?gb2312?B?NDhTNXh0RUU5RjUzeisyaWJkNUhvbklBYXk3NzM2Q3ZaemVMbmk4UHFtSTdS?=
 =?gb2312?B?bTlwUjgyc1ptRGNBTkdDSFhHZTVpbzVOYjh1emJKbWs2YW1zcGxtc3NGTmdu?=
 =?gb2312?B?eUlvdTVRVGJCVytkY2hxeFZOd0FmNUpmUTA4Y0MwWDZUMkVMRzVIdCtWRGV1?=
 =?gb2312?B?NzY4NVR0MmpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5979.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YU9SNmFuWlZ5L0tCMWtOWnZIWHFudTN1SUFUU2paSEpXTEhQdXBTd1h6elBJ?=
 =?gb2312?B?S0ZESWNWZ3RKZUl4Q2ZibjQ2aUpNeHdmalcvamREdlBMYk13dnVQUFdpVlpy?=
 =?gb2312?B?UHZNRUVwUytHL1ljZS95cTN4TTVzNUtRM3NKTldBSVdhKzFSZUJSMUNSS2RQ?=
 =?gb2312?B?b3BGT1hwUUttYmpGbVF5b2YyWDdhZm5HUG1GRnRUNUo0WkRtcDRKb25PNjN6?=
 =?gb2312?B?UWdUOEdKYk00TTViRTFKTEFSNTZlRHBWeTdrYjVzdzhTTzB2RUdYU1ZiOGtj?=
 =?gb2312?B?aHRYbnE0b2xVUGxKajBadnFPd29Ja1ZlNDloK04rRHlja0tLcTJqRlpwa1Z3?=
 =?gb2312?B?ZW12TWpWdXVGOEpjRUFOY0M5dmtBRWdCWjkyUlB1dU9hd0I3TVUwdkZPUFA4?=
 =?gb2312?B?UlZPOURkZDRGc0ZwUERIQUdrTHd1TXlESHJSTzNtZk90amR2Q2lsSzkxaFcw?=
 =?gb2312?B?V0p6RkR0cThEWXkybTNXbFJwelZOcWo4bHFyY1cva2VYMEpCUmVoTWU1YXlT?=
 =?gb2312?B?QWk2MWJxeEpDc0hGWWJ5NXhZTzdma0dOWFZ1MThYczNOdTk0TytES3Y2eVp2?=
 =?gb2312?B?TklBNWF6bFhWU2RKejRzNnBZZTg1elpKSHpYZ2dpeG9iVDh5N0xURkt1MUxK?=
 =?gb2312?B?MExIRnBCSUd2NFVSdk5iMEs2UzJMdXE1eWl2NnozcUVQQzU4ZURCVEhaUXVN?=
 =?gb2312?B?Zm1DUVNvNTZ2ME5UM0lZcVpGV3VsdXdrTXFXY0JWNzNuY2Fzb1RFdVFDdFdR?=
 =?gb2312?B?ekYvV3BPeGVCOWVmS2R6a0Fqa0lVM3E5RDlDMHZZS3E1UlFiMWRHN0lxczU5?=
 =?gb2312?B?K0ExMHgrMGJDdExaaG5HenpUekh2Y2lDS2xqQzY2VnBwZ0FIV2ZDU1JpZi9K?=
 =?gb2312?B?aXlKUHpvZXdqVGtTSE1xSy9sL1N2WStVT3BYVTNYbFdldTgwLzZORHpndEht?=
 =?gb2312?B?UFovcXI2S08xOTVKSEU4clIwNWs2NDhNdzdDYmd0bnFWTk5pTU12Vit0eCsx?=
 =?gb2312?B?RlhOZnBtVnJreDE0a0ZjZitXWHlqaWE3alZkUnZxZjlVcnMyZWhXTUI5ODVH?=
 =?gb2312?B?UjZRS1MwRGhCVVVkWHpCbGRKWXNQcUJGdlZYUEhYYlVQSjk2ZnQ3cjZFY3cz?=
 =?gb2312?B?WS9VbE45RVV1SW5rNVJEQiswTnAzTXFuQ1Vnb0p5UG1TK090b2l2eWdVWUpq?=
 =?gb2312?B?dFVQQ3FUeVAwbkJ5QWNjcjQ3TThSTGlSS3M4TEJMYmdoNUdKUXhwamFIU0Jp?=
 =?gb2312?B?T1lRK2ZjOWdZdVo4Q2FJMUVPLy9PRUFIODNibi9PekU3MGNFa1kyZTIzRmpz?=
 =?gb2312?B?YnJsV3d0eGxmUE1TdE9zYUxmMGlpWHFzRTBRdjR6NGloWGxHdmxVbXlUcFBx?=
 =?gb2312?B?bUxiK082cm95a3RFaC9SVGF4OHdpNVVPdnd5ZndteXhtcWw1dU1ITGx0YUZD?=
 =?gb2312?B?WDRJVVo0MDBvZi81WkgvcGgyVFB2ZHVYQU5RemhKcitXUTFGQ0ZCdDZhSGRj?=
 =?gb2312?B?N0xRRkpqMktOK2d2aUNWOU5BeklML2xKWVlOck1CeG5NMEg1L2FmdmVlckZY?=
 =?gb2312?B?SHhMYzMzTnVKTzZkVzdabE0rOTVObEtwYzJZNlVzTW5Ga0syNTBUSHM4ODlE?=
 =?gb2312?B?ZUhlekY2Q2dpTUlTSjY0Z0FsZUZhZUNHZUovZ25tNmZwTmRFeVozbnRjSkFG?=
 =?gb2312?B?VHlwaGNITHExb2ZyY1JJUzNGaHNtNEdWTmZ3aG5QM2I2ZnRDNkhwSyt4ODJQ?=
 =?gb2312?B?UWIxZmZYR0ZkTnltVVJtbXo0OCtJS1VHOHFFR2JRSVoxTmFHNjJwSi9ZbmRX?=
 =?gb2312?B?ay83cUorUEJ1RVM4RjZIY3Jwa0tDT0U2cEpuZnI4YXhsL2JGMWd1amFySk9U?=
 =?gb2312?B?SlVNeWNtRkR3K1JuWjNEWExocXZrZU9jZUJuVWVOM2V3aS9mUUNWNjZ6NHk2?=
 =?gb2312?B?c0o2bm8waVJuQk43MkFMS0NMQ2NXemkzRnRwQWZaQXpUNUFIR2tXK1pBT2dk?=
 =?gb2312?B?VFVqaE1UbnlrQjhBU0lQZW12b3BnM21FWGd2bFJpYlNYSTVJS1hkNitHTC9s?=
 =?gb2312?B?M1Z4eDdJaGhRb2ZZSVkxQzV1QUswRlhvNWswU24wTllmNmhyNzNvaDBNOTFH?=
 =?gb2312?Q?tho9QTpx/pvqpbUFcmX+0OPP0?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54187ee-a72a-4b94-18e9-08dd9794cf6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 11:52:34.6918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjQt2ergSvaueVtMlBrAbVPX5dbcyzyeOwX6WxuqMv53OrXrNE+O150GpnMROHzKYCwrYg1JIyGEy3mu2+qeFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8223
X-Proofpoint-GUID: qxaObXBvKV9VJ2ZypDkyemsPTPcwA7Qw
X-Proofpoint-ORIG-GUID: qxaObXBvKV9VJ2ZypDkyemsPTPcwA7Qw
X-Authority-Analysis: v=2.4 cv=arGyCTZV c=1 sm=1 tr=0 ts=682c6d06 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=dt9VzEwgFbYA:10 a=Tc3ZHNnsVXUYpIoDhdsA:9 a=mFyHDrcPJccA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5NiBTYWx0ZWRfXw2PuEE5ZubNJ dCC0wmw+3QbiHItJssahI5mpgwvQznrqmfyIFYiZHmu+JbqHJ4bzfszRPBCZaEmC3qbfccas291 wh8FTLP3OQsxCY6JcSXh1yVLneJ1ZBypYSYgTWb2Tty1UoKAhmuV7p/fYdbcquNXAbW8yXRYv9k
 ddUX4GInh5wEFPDsXaZ5EuuQdkrYS4dG6TFeSXR/NhuvYcbqAx0UkxKaog9jIKLKG5uj6yD8sD+ 6N3TkSdjsEG00WYms0WQXkaiyFlfDtLMj2mjbNUNsfA92SUUXRsbC5sReRcX2cONgNpqJsAnK6W HDU3qHCRkAYedR8O/FEGCHPMk2xHzd6+KTNitBGRZUD20Nduu2Y2rT5XuTsYd2IeLZrrlwYSwFA
 ZXE1PrWpbM/K/3J4oEqhQYXQLXECZTZXsP8qT/rpSYavOTAY+DwvtGZwQUlRfCpdVZH1RL6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=364 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200096

SSBhZGRlZCBkZWJ1Z2dpbmcgY29kZSBpbiBsb29wX2NoZWNrX2JhY2tpbmdfZmlsZSgpLCByZWFk
X2l0ZXIgaXMgTlVMTCwKYW5kIEkgc2VhcmNoZWQgZm9yIHJlYWRfaXRlciBpbiBkaXJlY3RseSwg
c28gaXQgc2F5cyBpc29mcyBkb2VzIG5vdCBzdXBwb3J0IGl0LgpJIHNlZSBpc29mc19yZWFkX2lu
b2RlIGlzIHNldCBpbiBpc29mc19yZWFkX2lub2RlKCksIEkgd2lsbCBmdXJ0aGVyIGludmVzdGln
YXRlCndoeSBpdCBpcyBub3Qgc2V0Lgo=
