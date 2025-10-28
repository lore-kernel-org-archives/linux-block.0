Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7661799F
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636346; cv=fail; b=RdcbDZnrcXjtBneRL3MVneU1MIm/GYL61krCOl+MFy3FVcnDE0eizxFtVPX5ALmLGWlMWY24nW1KtvheXUMgqvYjDpcNNZHh6uLzMddRpCTVRDT25HeJEhSfeJKNnZKsGMyaDOOtngvciqKDpCuKQ6z1bbpzUnjw5/DqcJRxXB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636346; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iVFAcq25lIteMp1mzKVnFxOBloO5wwd3g5tBmWR1WdIH9gaBqub+K2/M3nL/cDxDKqwIfWswXBl4peeaZnLTxkcblhvKuLzYuG1bT/ItIB0yDmMqO2u98GDXfrlisUnD4iZWU/a4serUoLLNDlZlJ6YuEQr+0+JW/r96bnuqoR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Zm/QnPVg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XwUWauPM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zm/QnPVg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XwUWauPM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761636345; x=1793172345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Zm/QnPVgruWdrTG/Htd/pxJPANd/OKifkvAXINNg14pD7gxHLr+IJ9XW
   vYIof47Bt/qnvA9SC3tcRuOW783/LXoO6fpG481EUEICn2mNyU/rsNc84
   V/7XzHKPq92a2kv2blJQiFcjnDj+oJ9uXK/YwAruntNCAc5NG6PnaPQqa
   CQwr266cyOz4ENChoFGMxL9IbgHiz/tmQUb5Ga4xbqRmhYsyb6i5Ywy9G
   HTKRpZgXFuvBtzaEtoUZ+qhdGTadEt4tVdH2mCc9BdcrqsWA6imarM5wz
   wTlbb/5XHK+etQ/XCfUCAcaAgzZJqfqVAnF9S56MsazoQnQpGbwGzsKuM
   w==;
X-CSE-ConnectionGUID: eAoY2845QLOiiw0tHZ+I/g==
X-CSE-MsgGUID: HM4BK/XFTJ6ZNoMIU9DDnA==
X-IronPort-AV: E=Sophos;i="6.19,260,1754928000"; 
   d="scan'208";a="135282413"
Received: from mail-eastusazon11012056.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.56])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2025 15:25:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTlEN6vlEB9KohiHSqAU94lJHN0eZ5DZiRHSJEKrHU2oipDLL7vO+Tvj63iUQFSFgaunDqcGsm7atki6HumQZtxrwgJW9Ant2blbwx0QvtHYmxd4jlSAwNj6x9gfT/bW3QrHFYVJwC7SWjian2eLiF5TErUxwdV0b/2kxJB4kDWsWnSSCC566Qv0HS3yIgdVS95Y3CY5kkIMvuG6c7Og1zKE3xixydWmbQP7CPw/TiX+mUj5krfNZVUEgvS0CtjgHed4AE6OTH1pmJT0/Hw1x6F4bB07oe3Eu4wu5wjInU/Uq5gEUBwXPVkn6yQyaHDyY9EnDKjOtnU0ZGsohX0zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=EDlLQCz6pe8LyNf9wFs/ntcfyuaDRLHzzLBwy+Lc9w3KtY5/VJAexfpOutEQPpnCVvFGbB2MHbtopqhhnM28C4KVlv6zRTILGUnoAdFjtRb1sn8YgtqHmyVe0NmHpca3c1+jLQX+FNatJ4yiEp5R+hq/WhCf6dYU7ZPU5/Jv3DJ/zWZleTHgkXdFmk58Smnn0CJqPhUnF+8UJoSOxvQ9IuyydIlQJZUa8y/dzr12TPfbSdwPDvbBLTAwN00BiIDHgBc6X9Ho2asVJOGNwYkwWWZOu+D8JHYeEPUV827kYwLj4choFy+y9l+NXAJsMaEhnTAld57At9xEauqma3kYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=XwUWauPMKq5iJaQVYTav8FNgvsAmhXDY1VRpd8QAxK9OX5vEPxK3aVqhnPh9yGu9tSRJ+gPe/B7czuAkRkDQGMj9WKQbLeqWwTbwz6uvVQZWngJ6JmZAVQadPqsaqDnT79x5qiV64uNG6H/Fy1SdZuljHbWkJ4HF8bSnRujFF30=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BN8PR04MB6324.namprd04.prod.outlook.com (2603:10b6:408:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 07:25:42 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 07:25:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktest 2/2] blktrace: add blktrace ftrace corruption
 regression test
Thread-Topic: [PATCH blktest 2/2] blktrace: add blktrace ftrace corruption
 regression test
Thread-Index: AQHcR9Wvoczs7euVT0yBe1bSqpArwLTXKHYA
Date: Tue, 28 Oct 2025 07:25:42 +0000
Message-ID: <fe698238-4a20-49c1-8c02-633d5747a634@wdc.com>
References: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
 <20251028063949.10503-2-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028063949.10503-2-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BN8PR04MB6324:EE_
x-ms-office365-filtering-correlation-id: 24adda4e-1ce6-4051-e016-08de15f333c1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjNwV0JKOHQ1MWF5RXc4NUVPSksyaEVRRlczMGNwS1MvVWxyVnpaV0ZlbEVG?=
 =?utf-8?B?b1J5NUN3Y04vTTFOR2ZocEdPa09zanFwMFltSXdkS281dHFmdDBNekN3VUww?=
 =?utf-8?B?SENHU0pWQVo5aDlhSzJ2S3hYOVZDNzhQL0pxS2VJWDJyVmcvZDJaOUdRU0hF?=
 =?utf-8?B?Y3A2eUtjRm5QNWRrVmRyK3I4RS9sOE5aWjlTSkkwZTR5bWRldE50M2NkV0V1?=
 =?utf-8?B?bUMvbjRZM3V3eHRsT3NRSUFncVRmVDF3WmU3bVdzcEozMVpLUVFWbHJISHl0?=
 =?utf-8?B?N01VcnNQeUxod3RNZnRBYlA1c3lGY2lhUmFlWDJMWDI3NEZNVU5DMk85bjNq?=
 =?utf-8?B?WUpMVURIZzFjc3g5STNlTTNCYTNJWGtPWHRlMU9EeFNFZ3dwYm9CWGlhVzVr?=
 =?utf-8?B?TjVDdDFiWHQ0amN5UytjSnZLbVhnb2htOWxXY0E4R3hjRDlvd2Z5dE0zcUNp?=
 =?utf-8?B?TXhIUWRCalFJUURoek9nYmtMRHdFM21JUytob2JFRW9Jb1ZialpRYVNCMnZs?=
 =?utf-8?B?eE16M29zUHgyRTF3dEJPSE9TM0E4V0Y2T2NieXd0VUQxUnlyeGVLSHcxWitE?=
 =?utf-8?B?Tm9pMEVQdjFXOFhOQzlSNXVoNzFGT0VORTFwbndUNXhwVno0YmtjazVYRHRi?=
 =?utf-8?B?WHdueThrSWp4eDhwaFpEbXVvMVlHZldJSUNyRXNNcGF2R1ZwWnBDcnFCZUZB?=
 =?utf-8?B?NG1WT0NZdi9CWFhmdDlXcXc2M0xWYktsQTNEUTc5a000cXh6NllQVk9kbXJL?=
 =?utf-8?B?NXlaakVZWGFkSVRiVm1GbEFYR3cvL1lheStQWGhnZEh5ZVBJTWIvK0dyOUZ2?=
 =?utf-8?B?eWZ1UEdwbGxlV285Mk9DK1NmaW5ITkdqbUFMZHNndVQ1UlhxVWRQZjRzWjlE?=
 =?utf-8?B?YUlCTnRpQmlUbDBDU0lBcHpiZFdnVVhzZkJIb3pFY0FPZ3laa1FLQ3dGclZw?=
 =?utf-8?B?MWlET3ZWa3RESDdkM29WNjhTcGQrckg3N25uMGdGNjZNNkRLbjhkK2dxcytK?=
 =?utf-8?B?VEpiT3NtempWbWtudFo3ZGtZRmR1L2RXSkV4eVhQUDRzb2V6Zm9Oa2pOUGpu?=
 =?utf-8?B?UjZ5Z1crUktzdVBNZDEyREJ5UWZzMW9mNFRBY0dMSXc3RGR5blltcENnY0lp?=
 =?utf-8?B?QmRWTXhualJmNU92Um5BRVJ3Wm03NUd2U1B4dGpGRTBrT0dOTUdTVnFNT3gx?=
 =?utf-8?B?cjE3M1dWbWg1b1RIcmVkQVpOdzNveElzUUZpd2V1SmIvbExlN2hEQ0tKT1R6?=
 =?utf-8?B?Z1VBVHZMbXBORFRjZHhCelJqTWthQWd4dkNkaEoxZEpkc2tYZmpxMkFTQ2JQ?=
 =?utf-8?B?QUZRSWZ3dDBObmtnVzgvcWgxeDJXZkNCMDBZYzFVUGkwbVdIMkU0d3I4TmRu?=
 =?utf-8?B?a1dwUTFiZytsVVM0cVJvcGc1VHNWSlo0WWZaUThnMmdzR0EydnZlS0NlcU1r?=
 =?utf-8?B?ei80M3N4K25XNGZqRDA1ZktxdWM5dStXSzBtdStGOUc2YXFxY0w0alVmZzRT?=
 =?utf-8?B?alZXVnU3U1lXc2UyaVl4a09yZVhvekttNjdXaUdLemp0T2ppd1JlUkp6U0Qy?=
 =?utf-8?B?bEZ4alFOQjJIMEVrMURQZ3NUNkc2ZnFSQ2hvUkRMbENBMmNTeXhHcmYrR0Jp?=
 =?utf-8?B?dTYwRE9aTTFtcEkxNk0vRFZ4ekJkb2JzNkF6ZDZuVkhaMUJWUFlqWVNsNnBs?=
 =?utf-8?B?S1ZVeWJuejZ1TVVJL0FrTkJ1V2lKKzU4ZW9XNWlkUWxZdjVSWXdPOGVrZElx?=
 =?utf-8?B?Mlp1SVpVSWw3dE5HUXZiSkYxYW8wZDJmVTVIdi9iTzA4Y3N4K0t1aHRKYk0y?=
 =?utf-8?B?Umh4OGdjcEljSnptZXZmeTVTcjJidmhycTJmcDA0Q25qN1Zadlp4MWVWNmxp?=
 =?utf-8?B?MWhhUmRIZkVKdXJnNmJpVk1nQ1ZJcXdMQWFvT0RERjV4ZjVGR0RVZ1JMKzNk?=
 =?utf-8?B?TTlYSm5KZkJlNHdxeW5aNXlWUzV0RkNIaGNxY0k5eE5tZ3FjdG4vZU5qTk12?=
 =?utf-8?B?RHRYZWlzd1pOUlZMeEFSMlFjbm50WllPQ0xTSFh5b0NCQW1Tb3ZaTDRubE9x?=
 =?utf-8?Q?44g7cP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1NBbTB4NC85Q0lxNnY1dW5BOFJNQ28xc0NhN2RxL1o3N0lMejcyeGtqeXFs?=
 =?utf-8?B?TVlsM28rSFBobzlCTzZicWhzUnBZMFNUbUdET1pjVVFZSWJoa1Vvc1ZkaTZP?=
 =?utf-8?B?ZkVRY2xTWmYwUCtTWjMycURiVXZ6cE9jMVZGNUQyZHRzZU9pMDdJRVo5aWdM?=
 =?utf-8?B?aFExU1BjcmdCTTVyNW1PaGVPd2FINUt6OTQxZjc3eTdJNGU1OWV4UXBnckRB?=
 =?utf-8?B?b09iZEg4MmxBejlIZVJKZGpFMFRFcFhNTmJkWDdsZVhpbThTc0RKSTJjT3p2?=
 =?utf-8?B?Rlgvb2kvM0wyWmhmTllrZGtiVUMwWHo4R3RFR0hzVmNoVGxpWExLR1JoYTlP?=
 =?utf-8?B?WWYxR1FXMXJTaFhWaVVkWjJkRmZYbStYSXNSb21CZU11b3VZYTBpZ3UvUzZX?=
 =?utf-8?B?bUhKKzl6V0k4VXZrZHRoemlFZ1FsQlczSy9haDJnZVhBRVl4U0VjWHJ4MDkz?=
 =?utf-8?B?Vzg1OGlIek5iUUdMRzlsWWZYaEs1VVc5eGZ1d1ZCaXIwNDBoQnBBRVBLbnBV?=
 =?utf-8?B?Wk8vZmVhUTlKcTZDdDVXaURGSU9PYjZxNHRSSk9uTzdESjB2S2FKaE1oL2tx?=
 =?utf-8?B?c3U3SGpTNVBNcTFyYWh0b3o4bThaVkd0SXdjbHZiZ0lhY0FXdUtFclVwczB2?=
 =?utf-8?B?dEpMaUVYQWk4MmQwSmJYR2JwOHZETUswbFZRL0ZLckc3bm1Pd2U0U0RqbzhG?=
 =?utf-8?B?K3ZsOHZXQkVId2RaVjVlWTBqWnVLOW5Ya3EvQVhUalo1a2ZHSDlhWW0wc2VN?=
 =?utf-8?B?cnhvQlNvTEo5bWl6azdHbVYwSHcyUE1xZDJXQUE1ME04a3FhZ0lCZ3hiS2hU?=
 =?utf-8?B?NGtpOVF1WGloYlkyT01vZkUvaUtpWlQ4V1JpSzNPSHltNGpndVZObm42eTYx?=
 =?utf-8?B?bDRFWnRnN1JjTytJNUQ4cStKT1pFQWpRRG9WeHFBV2YvM0lHSzgydWFaMjNm?=
 =?utf-8?B?NS9lNjJRSHhtZXk5M3ExN0dQQkVCbm95QmZ6czFGby81WDJsamR2MXhKRzdx?=
 =?utf-8?B?d1BVRnV4YzhJbm1qZ0tweU5lMlovUGZZQU81Q01qcFZ4ZlVnNTlIOUxvNU5P?=
 =?utf-8?B?SllYN3NkUmUxWWtYemdVdlRIbGJQbmlqRDFMNmQ3WmR0L1kzQjJyRnVTOU9Q?=
 =?utf-8?B?S1NYdTFVdVNxcnlVeGlxUDd5ZUJPWVhPTkZGVXZZcXJVYTRVR2NXYzU3ZmlS?=
 =?utf-8?B?NGdjcmZxT0dGRHp4Y1VRY1hmSTgycnd3TEd0T3M5WUsweVVNdjlhaFZlalZt?=
 =?utf-8?B?d3oreWlHdUhIS3BXUXRSUy9MUUFPWXVlWGZUNTBHaWlUVG9yZzVlMkZJUWRB?=
 =?utf-8?B?L2RpdzEzUnN2TGFkM1BLUUdSZ0IvSVRMbk9xUW1YamVFMGY1Y3hRWU85Wlgr?=
 =?utf-8?B?STZ6dVJBRUhyLzZGQlJCcjU0THphL0h2VEtEalRKSXIrd0Vrd2E3UXFsYkp1?=
 =?utf-8?B?cDl1R1RyNzNPL0NRZmRvTFY3NG8wK3Q5NVMzL1Q3am5XOXpoc2xzYW5NdVE2?=
 =?utf-8?B?U2xOR3NEWmNhQXk3cWZHMlUzMFltOWtleEd5YnJmSi9veEw3K1Buc0RQd1dx?=
 =?utf-8?B?eHRIZFNRSklWZElqdi92VHA3eVpGczhCM0NZa2lWOTk0ekdzcE04cTNJbFdn?=
 =?utf-8?B?OHpLdFdmaHhFWW12cjlrNlZPbmtJaHdWZ1FWSHh1U05vL20vMlc0dDdaMzRh?=
 =?utf-8?B?MVlYc0F2SVRkMHVKY2VOVWJIaEM1VjAzTS9hR1dMekVNODhtM3hXUGtzbTBr?=
 =?utf-8?B?dHQyK05iSmIzUGpVbU9JOTFzZ2g1ZkdUOUNqcXE3UGY5SlpWcU44NDJia0Zk?=
 =?utf-8?B?QmI3MU1vRyt2ZXZpRnBXSWFYTWVoOERSOGt6K2lnSmVOTElFVlFrYXgvYWNF?=
 =?utf-8?B?aFJLcDljeUN2TmlhTDBrWTBCWDlvVmMrc0ZCS05Ick4wQUJPak5PT3ZDZHB4?=
 =?utf-8?B?a21XN3psVWQxTjJQMStJWXZqL1Y4S0JxUFRYZVNCRW5UOTBUczFNdTd5Sm1u?=
 =?utf-8?B?VEtyL2ZpeVdsc0pmZmtETFViMEZ5YzdUd292S2lZUld5L3VFOG44VWNhSVBr?=
 =?utf-8?B?Z2NScGFiTkJyUHlSOGxQUm9KUUpjMmFUZHNvbXZSZHJUdEMva0xZM29oaGln?=
 =?utf-8?B?RlFoQTB0ano2STZzL0lhOEN0ZWRxUVUwWnRJbTdSM05vcTc2K1ZVRXlQUk92?=
 =?utf-8?B?VG5vQWlrKzBaT0pBOUplVjJXQ1JpSURFYmtTN09kNks0NzlLYWl4MUQ3M1Jv?=
 =?utf-8?B?S0JheTY3d25ZbFhFamk2UWdobHhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C93DE1D5C10AF948BAA257D0F0C21ED7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	orrjubXzfUjuTIA8mV3TsFVJRxrltdtzPVHZoWeGkXmefhRRf2XTNWVma71+2toatXGk9hRJPAKAkrXA5rvCKkBChQ8uUT65qJQ17WKEZjehZpEw6VZWZxka6rDKxVF3cIvVqIDh6cEVNhHKkRAmdDfr2q/LBUDju8MWhLq4ifxp/V6dK/FnQqMEZeGcZi6KtkE6rB4HC25zogOoeeg/+xv5Md8OU+z8h7hhYxY91vaiN1ow7MU+lsOhwfKsrENf0+To4zUDkHm1Xz83PDwEoo/yRHg2Uv+shFtwj6fGTeyLs2MhsI8z6lUO2GujCPfUw45BfKJkIHunKQRLcKslybTdJijYCeA8p754pbP9pMXSjEnNlz3Yu0o8zI9ImHyZxPiFkQ/v/c2AMwiKXtIJbkzKE/0C2mx224muC7RE5A9TQkEvzWdMfCKi1PUOCbXNiKg4qHRc6IXNQR+9dooQ/GYjgaJe4MWOp7QtwkZ9jwhu8MA0O7n6g0wk8Cjfc05XrSPlTe+F20IlspKHHdeoGoDKYf5agA9eWQxsCNAOskoKvVd0wwywAzw9ayLsbDyV9vvvAngMR/1aXa9aJewCE4Elj/oTaIGBejK2vblxyO932cJCk4kuqQIQU17M0/Bi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24adda4e-1ce6-4051-e016-08de15f333c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:25:42.2148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5n1PGuR5EAdW1cBelC2HB8p8lDsjJbh5uQQC4/qG1LcvmZGxqwx2kf/oBF0Kjq556T+tXfM7u740uLOLA+/8t5qFZAqJ3BCo6m0Ii+I8ks0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6324

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
