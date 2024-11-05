Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A21E485
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810135; cv=fail; b=YwDU5YDel7julyf9INvetCqGLXxz7CJdo0CaQgR3huxXEVON5H1cXEeSff/8+S5BmowrE8B7Xm1oQC4Vt0LoyK42AHwGM6PqnNqZWsGwltOayqCuLntNKyVtsaZNnoARkSvlZ0KoJawWI34Praic9GZrq0zf7j0fkfTDsK+XOq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810135; c=relaxed/simple;
	bh=AL47Ldkb7oaVepGuUVubTd6yYGkAVfwCsca4sAThtnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQoMRNZYz0ONyLMC70G0aHNavLw9ADKnd8ZLfpKtQaukrYSC0RFPhHxTZN3WJixbM5vOfC8A+BS/qatNl4jDaLz0jsaVuwSsxAjRiKR+HmzH9adbGAy30CYx3/4ZdnBaXnhfdXim96DiZ8B6/S3Chms4eOGkqjsY9frsQHMSRlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e7CHAZv1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kVMVaQsR; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e7CHAZv1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kVMVaQsR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730810133; x=1762346133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AL47Ldkb7oaVepGuUVubTd6yYGkAVfwCsca4sAThtnM=;
  b=e7CHAZv1YlpiDk442lslMgfDHW3apBIc+woHneCb4QSEeddtzBJHIivy
   ckFV62/ibWQP5U2V4NUvqX05fVF/pC15auwlIj7yEE5skpoNQ1oZ38ogf
   4guM8IEgc5g2z+32Te+GwPXEepX+sGHN1rY94a6Adt9aTGiQaauvIOdeT
   KndJzz/CEwiK1Y9AS6omWNtyn4jWIr3LZJ0zA5EzSjQTZyzb0imkHan1Q
   KKKe42QyS7f017LUvbpqjdqZXHUezKo056XM2NIgTln29LGgjDIpzK81R
   wnPAEjK1ySttfjBFz1qZwvY9orQN4X0ekeA/Qr1UxxQgVbNh+gSWLKvzA
   A==;
X-CSE-ConnectionGUID: Kry/pTqpS8a0BggJfbZ2GQ==
X-CSE-MsgGUID: cAN6nyUaRWCJDhWwabbWKg==
X-IronPort-AV: E=Sophos;i="6.11,260,1725292800"; 
   d="scan'208";a="30085763"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2024 20:35:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9KFUJy/QgW850z9wnhqsxz1G4tyWTsDr4OE0uwmfdT6deTyGKldTDTspKFBk9EgEwLSMk602Irlt5GF7pkaPfztCKXW4ezbwRhVIizjaZQs7UV44S8T0QY27Iz+X7JETZd3uV5DWIi9AXLhtSWzxj+oUpgE/354IiKtyU37dB1o9vduCZ0ryZI/UYmj4MwJ5PTe2+Pvt1NMeYGcIHsYLXb+UVpeODFwi2ZL/yn6fNlrUPwokiA91MrD7xw13hfSAw2VGNTTwKk8/+ppGsXb/6yBunoHbq89KAJz7WmsYTQ+U80jlk4RCnkxOhRVCq2H9KRsPU2J8Br5JAmaZqYE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL47Ldkb7oaVepGuUVubTd6yYGkAVfwCsca4sAThtnM=;
 b=y5xOegtDdeVITpeN0vDn+H+jBSJIdVA/PMyupKUQ1Kun2xmwbdiT1iYmsLUBhf7OlsEJMe1pBgFC5ylrsaFwWmI0D0BJU/XjrpBtn5RZh9Xuk2b5N8gNdHyH1T8BO/BBS4hMjKep5cZVuucAvDJ621HbDOLsNhmhsJ8NWtXYKKz7EgcTIJ8kANDQfJpLkWLqjG14DSz1CIk9tP03WjENC2mRkB29Kn6Ha9Y9ZpYhdQKDK5GmDU+LHrUzs8fq0MYGlLAW70qxLiO9i0ArRr27sFqbyY8KeR1mwK0ZwMBm8xG03R/E17XIKr9VbaEiMl+VllTT8XHO3YorYin7E5vF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL47Ldkb7oaVepGuUVubTd6yYGkAVfwCsca4sAThtnM=;
 b=kVMVaQsRmyJNUZPkIrX6eHQ/Wl9yHVZfDtdMdv94HvhJLWhpYuRaD26mWiFqRucvcG1cX/xPVtRaDink2BJv+4Sv4GzPd1irRW2ZMkEZjAmGydke28gDX3Majtf38fwAuajg8m+SMTEHkIC/H6/TRVb+4A4DnDOzoagFYfvxaZs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7301.namprd04.prod.outlook.com (2603:10b6:510:c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Tue, 5 Nov 2024 12:35:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 12:35:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "saranyamohan@google.com" <saranyamohan@google.com>, "tj@kernel.org"
	<tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, Ming Lei
	<ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v3 blktests 0/5] add new tests for blk-throttle
Thread-Topic: [PATCH v3 blktests 0/5] add new tests for blk-throttle
Thread-Index: AQHbLEvYR4jOaPgrnUOtF1K3+1ni57KopcsA
Date: Tue, 5 Nov 2024 12:35:29 +0000
Message-ID: <gpio7idmjk72tsrym7xivxhts5w3stt7ibpqyfvny5vhx2rfak@cwrk7dsjoyyc>
References: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
 <05380f47-13a0-cd25-8f34-003fc1a85729@huaweicloud.com>
 <233yatkr4hnb7cjjfiuvamydyvfvfzb3tmghft62wuulvyrngd@j5sxae3bllha>
In-Reply-To: <233yatkr4hnb7cjjfiuvamydyvfvfzb3tmghft62wuulvyrngd@j5sxae3bllha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7301:EE_
x-ms-office365-filtering-correlation-id: d777834a-62f8-4079-4cdb-08dcfd9654fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dk9Fb0kwaUlWRTZuRW9YKzNkek1CN0oxamU4bjk1cDFhVlhTR3FwRzdXTXI5?=
 =?utf-8?B?NUk0RkhFSURnK1lHTFQzVkRYa2U3aUpyQmwwY2RWdmVObXdveEp5cHIxWVRO?=
 =?utf-8?B?MVNmNXNwajNjQm9EQks1NndiMkxqWlVDN3V1cGZYYUZNdWtaYXlNWHRUdkJF?=
 =?utf-8?B?cFRkLy9ZYXI1UnlHMGxyTmRsdzNYV1ZVV0ZEK1lhTnV4YjI3NmRJL3NMVG9N?=
 =?utf-8?B?VFpFd0YvV0poQTVVb0hDdS94YXJDK1JRZU5KTHNRZ0FIVkRZck9XSlRSSjhF?=
 =?utf-8?B?L0EyUU9yN3k1Z2tTZTBvbzVybnJQMis3ZUNNekowZGhteVVBTVBmWUxLWEh1?=
 =?utf-8?B?bi96SkVQbzJ0MEFpNHlOa0FsWGw2Y3Bya1JMVy9DYXBCMmpNWk1vclJockdw?=
 =?utf-8?B?UkJtMmorZzRLdEZ3NEhRRHV5a1JsT3R6clJMQzZJbk83QXZnYmVOMlpNdjhB?=
 =?utf-8?B?bmJrN2grem5TRUpRQU5paDFSVk50NE1nZnl5QjhVTzNPYXBhb1lrN1FiUWJX?=
 =?utf-8?B?Kzg0azVNQlRyTk5MQmtObmo5MzZYUWQzbXVTUGQyYnR4WGlzYTNoSmZDaVVB?=
 =?utf-8?B?eTJTcytFd3RmY2RKMExqR1dqcjl3RDcxSndpK1ZlUEdBWXA1WkluOHFxZWU1?=
 =?utf-8?B?N0RHMXNVUHZwT0FaeVl2MHU1MHpJNXVHQ0FpNGY3blRvMTVBSytYd2duU1ZM?=
 =?utf-8?B?dVBxQm9qRXVxQi85L0VqTDNKRUg3MEU4Q0F6YzA0Rk1YMlBlTGJyRlBZZU44?=
 =?utf-8?B?ZjZRTG5PVnJoRVp4dWh2dGtud01DSmF3WThZL0p0NUU2SlN0S2pJWkJBRDVt?=
 =?utf-8?B?VFoyaGpuT054VmZkR1R6OUJRc3MxamUycmhldlFCQ1ovSThRSSt1bnBuN3Mr?=
 =?utf-8?B?eERTYXRaVmZ6My9jMjJGR1BPNi9iUC9OYldVVzZYS0NWRkwyQkJXL1NJUGVh?=
 =?utf-8?B?SWpHQlh5R2F0b0t6eWcvbEx0dFNuYTBGSjdkeDJ3TGg5US9CVzM5K2FpeTVL?=
 =?utf-8?B?YXBwVzhqYmlqaVdxd2dpR0VhQ3BEVHROUWlKOVFvTnV2TS9zeG9RNDJzVVdV?=
 =?utf-8?B?TEJxNlExZEwyR3d3OCsyMng1SG5rQmRGSVV1YXVYUkpLQ1RuZzhpYlpNRklH?=
 =?utf-8?B?RUt3d2ozb2dOQW9Ib0czV1A4M3BmbkhVRFM5WW1kczJuZTJZS2JYM0hxN0Y0?=
 =?utf-8?B?ODlvdEp2dkpTemk3S1NISnNzMy85d0ppQThUQXhKZEZHdFBPT093QTNzK1Vl?=
 =?utf-8?B?cVlOSlVpRGdydEFPNG5jOEtuYnFoWnRNWkovcWttbGQrL2tXK0UxQkdOTXdn?=
 =?utf-8?B?RnZyQ2VQY0lFakNNRnBIa0FuY1RTcDl1aXMwRzJ0ZjBXQlh2ajZ6RzVGNlF6?=
 =?utf-8?B?ZDNycGJTWk1DNGtEeVVOV0J2Rzh4WkZuV3FNeXZ6MUhocVJvWUJ6R0JNUmNY?=
 =?utf-8?B?NG5LSnQwUVA0U1VVMHFEcnI1c0Uwck9LSjRHZW5MaVQ3M3hvY29reXBFTGFn?=
 =?utf-8?B?UjJnN0w0UVFaNXVzNkQySjBWZ0hybWVuamxORWRlZTdKQUZyMGpaQ0dCRzg4?=
 =?utf-8?B?OVVPcEticzZmMC9GcEF6dkdaSlBXMGxZSG5FdHU3bjRGeVJ3ejY0eDlOakFE?=
 =?utf-8?B?QWc5d2wvdGhQRmlVKzhFa2VTVmlJTlRmUUJzWHpRZWc4ZFhMRjF6NzQ5ME1B?=
 =?utf-8?B?d1Ivc3ptUDdwSW14dnNhRjBwcUljMDlTZ094MjNyK0RSVEZVZ04ycGVLbk9i?=
 =?utf-8?B?Rzk4OW1WcUtwc3g1amdkTHhNZmN0Q1R2WUt2b2tUTlRRdkxPZ2lTWGd0Vytu?=
 =?utf-8?Q?9/uqX3ZN2ML3LHBEG0fuahUq8YQzqFomeomCw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXVZM0tVcHAzMUZXMEJpUXNWSUsyenhwTWNWSFJlNjFucjNmSm9RT1pJZEhn?=
 =?utf-8?B?OXFHOVJjcndLZGdIWlNYbSt1NE9WVU1DTEJUNkdmenBtRFNBUnI1NHoreTBm?=
 =?utf-8?B?WjBqSUdabERGbGtlS1NPbnZDcU9PYnhVZEJzKzByNkx4ZnFieGVGbjFNQ1hL?=
 =?utf-8?B?a1grZlUweWxUMWdaUC9ja21SUTFYcWc1RHg3RXFsOUp6cGVUK1VpcHV2SmpZ?=
 =?utf-8?B?QXY0cG05enNJeG1kbC9wSXc2SjRhZkIxOHJXQ2xoY3ZlSWt3TlpxRzFYbUJ0?=
 =?utf-8?B?Rk1yOG91M0ZPemJBSG9XVERQMGd5Tld0b0JBbER5Qnl2cDMrZEV4SkVHdWtz?=
 =?utf-8?B?a2NVNVh2LzNQUitOY0ZnOEp0MEVQazNSSzdaSUtpWCtEYXo1eVBjNUVVUXRl?=
 =?utf-8?B?ckczUEhCbklSU1dKejhwaDI1VTdWSjJWczZabVplWVpTT3hZNVhqbTlUaEkv?=
 =?utf-8?B?eGJUUUplbXUvVGRtQWZtK25SQ0l1VVZpNUVDMmhnbXNkMmpiN1MzejI5cHc5?=
 =?utf-8?B?MG1IQkNyR1dtYmtodThZcXJueldCNHBObFo1WUFRQ05CZzljRHZiRXFUZjcx?=
 =?utf-8?B?OHlUeVk1WEozTng1bnVORjRCVTlDR1pWWklHN2lDcVRVZHZweVQxdDRVcWtr?=
 =?utf-8?B?NGZMOUxqT2Z2eWNnT2N0YVhyc1R2YUUyUFk2TUh2Q2dzS3lGQTkrRzR3TWZm?=
 =?utf-8?B?MEZEa1JMN2ZaeC8rYlNESjcvMEZSYksrcThITmZSWkozZDZFS3Z6UjJXUFd3?=
 =?utf-8?B?aHFWSXlrYWRUUEFPL0NhSWdydHNYWkVQelEzT1NVSUZxdlB1bHBmd3l3aG1O?=
 =?utf-8?B?anFsWWp6YkZMOGRCQ0UzOFlORFFBSGM2eVBqdXpGd2NKVzZKQXBrSUpIN3FV?=
 =?utf-8?B?anU1SGhNREZKbGR4UW1zcUVEaU1sNWhjYzBPYS9WYzY0bEd3cEo0Vlo5MEVB?=
 =?utf-8?B?OXowcUZnY3Y4TC9RY0JDSDE1dWJKckRPbFV4UDMyN0tJbE56V05jNHdMdDJ1?=
 =?utf-8?B?NFRqbTJDeCtOYi9xRExmdzBHMHIvenFPV3JiYnpFNTVNWHQ0bTBCQmQzMEEv?=
 =?utf-8?B?Y0swMzVOYXliRnZQWDNIQ0VlSHBkYTVmM1p3RGZRVThrZDhJOERVeENTanJV?=
 =?utf-8?B?L3Q5QUtwVWlxODh6T2x1MTBma0hrbFhnS1FoaUZOblhWYjlyMUlrUWd4MXUy?=
 =?utf-8?B?dFo0bEEvbzdTZ29MaUZrcmhidzUrMDhqdERLU0NrL0gzc1o0QkRGdDlDSmM0?=
 =?utf-8?B?dExISzJiNVdPTlFiSXhORXRqdjFEVWdaYm1RK3NOdmwwY0lBdEU1RFRiclVa?=
 =?utf-8?B?YlRHakd0MTl3bjdwYzFiK3drSzZuVlE2dC8rRGhpUHgxTFFqSkxicWMybitD?=
 =?utf-8?B?N0xhT2lFbUlzNnM5OVgzSU9EUXlpb0tlOGt6R2w1SFVwOERrazBtYzR6VTg4?=
 =?utf-8?B?Y2pOdDhVNVJldlhSUlRUUHBrZVdGWnFYKzZIejhlMnN3WTliZEJqVUV6Ty91?=
 =?utf-8?B?T20wNjRmbEdFcHRMWGxLeWdqUzNsYUViTDVhVHFQc3VVdWxhZkY2aEZyUnd5?=
 =?utf-8?B?Z1cwQ3FLTnJPUHp3TlAzTWszb3JNMnRzYzI0SUhlV1NBcjVtanBOZmdvb09R?=
 =?utf-8?B?Q1BVYUxZQlptUmZnZno4UXR5TnZBcm5SOXp6cTg2OGVsWkROampuK2xXeFVC?=
 =?utf-8?B?R3ZQQ3dJbGRuT0JtWDU5WG9UL2IvVFRmS040RXgyRUxwMEttVUZnVUxIMm04?=
 =?utf-8?B?bjFhcXFGVWdua1VuTEd6OFROUHBwcjRid3poR1BRTVYvUktjTTlFSFRBMEpM?=
 =?utf-8?B?TGJkTEVacWpjbFN2QkU2dFhrb2I5c25yWFhOWlpGTTlTMWgyNklmUzh4UlJR?=
 =?utf-8?B?UVdESFd3RHdqeUg4cXRpZ1UzRGtMZXh4UVRNSmgwM1ZTZHJCbEUrTm5RVGxF?=
 =?utf-8?B?eXE3dGRtL01WWEdZT2ZCbi85ZXhGU2Z0cWExU0lsQnZ1Vjk1ZWFYdExxZHJE?=
 =?utf-8?B?dXgzY2ZwTWRQbWY4enA4NmVEUzZob00xcURqb0JmbWhOenJDeGw1TkxiRjJG?=
 =?utf-8?B?QmpRWmhIejcrZHF5RjlnR09maVdBeVJKZVNjUjFZdHhERUV4b3hxblR6VjYv?=
 =?utf-8?B?eGJwOTVLeGNtb3VmbWg4QTZVWnoxVGVzL3V3eUl2OFZCb1NEcW5qM3YwZXVi?=
 =?utf-8?Q?n8Wl+Yu9Euf8+jqmUpJUYys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <615E0DEAE3C8574194DB79678EBAEB73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IMXrpiJOtSu4wUl94eA5n49i1dixzjxswAc05Bmmvbp6U0J5NgJsvlGGrJP0nnSvDiMp+XhbS3ZtqyLWjLNvr0FtCFEkoYXjAR1pWt1yxJPI/fwbkyAibYRdQjj8gHYHJvIHksNyzOhqm6Nz1ugIsExq18erodFbWoVKFlROHfF3kim3+yX4F/U22UqlRAZ+YLpqDEDaUnE50SOIDTiwHG6mKzk509iF4ImmH3yoB2EEVrGGqB3wpwAL1d5I8Sjqm1Ql6wHL/wKCCziOyqGYUQNj3pR2EVRlgs5wtIbo79cwUH3JZ7cK/4lP+HOHYCt3QSCmEhMxQ0NnYX4Ipjsi7OmTvZBysAlge2AcykoSCXjDf9Xv7Z5E7IhOyfJUXXem5QMYH3Re6eZWixqPoTNLDyeyGoHWSQPorTvtU2efkat3Pieq2f0oR+jP43ZESiiWJzpH7hR5KnHFMM/wVTOwhaozh6BI5OVqVJ7mGKxLDoGF3Oyx4BJgbdkWrlSHbpdh4/lbejDmnrSiQmw/Ee8Lapudx7EcfFL0vsAtyI+KqTtALwVl5TjJgzFAkvhX3AAsyhbp51YEC3YbFeyAZQWWwjRlmqg9szQzsGWeTc+r25KtHOBhGNIveB2z7Rji3iJW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d777834a-62f8-4079-4cdb-08dcfd9654fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 12:35:29.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Y1CUvMIjo6RETRvmmfClN6SpXb6BR1leIAmomvkiCuqC+em8Hif9zGfyl4uaqQvdBwwW5xrWX0S+oiLJhuwT5wJu7fXPUUYfDAgpD8Fh2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7301

T24gTm92IDAxLCAyMDI0IC8gMTA6NTAsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9u
IE9jdCAzMSwgMjAyNCAvIDE2OjAyLCBZdSBLdWFpIHdyb3RlOg0KPiA+IEhpLCBUZWp1biBhbmQg
U2hpbmljaGlybw0KPiA+IA0KPiA+IEFuZCArQ0MgTWluZw0KPiA+IA0KPiA+IOWcqCAyMDI0LzA0
LzIwIDE2OjQ1LCBZdSBLdWFpIOWGmemBkzoNCj4gPiA+IEZyb206IFl1IEt1YWkgPHl1a3VhaTNA
aHVhd2VpLmNvbT4NCj4gPiA+IA0KPiA+ID4gY2hhbmdlcyBpbiB2MzoNCj4gPiA+ICAgLSBsb3Rz
IG9mIHN0eWxlIGNoYW5nZXMgc3VnZ2VzdGVkIGJ5IFNoaW5pY2hpcm8NCj4gPiA+IA0KPiA+ID4g
Y2hhbmdlcyBpbiB2MjoNCj4gPiA+ICAgLSBtb3ZlIGxvdHMgb2YgZnVuY3Rpb25zIHRvIHJjDQo+
ID4gPiANCj4gPiA+IFl1IEt1YWkgKDUpOg0KPiA+ID4gICAgdGVzdHMvdGhyb3RsOiBhZGQgZmly
c3QgdGVzdCBmb3IgYmxrLXRocm90dGxlDQo+ID4gPiAgICB0ZXN0cy90aHJvdGw6IGFkZCBhIG5l
dyB0ZXN0IDAwMg0KPiA+ID4gICAgdGVzdHMvdGhyb3RsOiBhZGQgYSBuZXcgdGVzdCAwMDMNCj4g
PiA+ICAgIHRlc3RzL3Rocm90bDogYWRkIGEgbmV3IHRlc3QgMDA0DQo+ID4gPiAgICB0ZXN0cy90
aHJvdGw6IGFkZCBhIG5ldyB0ZXN0IDAwNQ0KPiA+IA0KPiA+IERvIHlvdSBndXlzIGhhdmUgYW55
IHN1Z2dlc3Rpb25zIG9uIHRoZXNlIHRlc3RzPw0KPiANCj4gSGkgWXUsIHNvcnJ5LCBJIHRvdGFs
bHkgb3Zlcmxvb2tlZCB0aGlzIHYzIHNlcmllcy4gSXQgcmVmbGVjdGVkIGFsbCBvZiBteQ0KPiBj
b21tZW50cyBmb3IgdjIgKHRoYW5rcyEpIGFuZCBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gSSB3
aWxsIHdhaXQgc29tZSBtb3JlIGRheXMuIElmIHRoZXJlIGlzIG5vIG9iamVjdGlvbiAoSSBkbyBu
b3QgZXhwZWN0DQo+IGFueSksIEkgd2lsbCBhcHBseSB0aGVtLg0KDQpJIGhhdmUgYXBwbGllZCB0
aGUgc2VyaWVzLiBUaGFua3Mh
