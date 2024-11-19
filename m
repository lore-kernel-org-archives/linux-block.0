Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D591D0BAE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035388; cv=fail; b=rVdhkEtdHV/MveoMquyOUHfHlu2rPeO1vTgc4rSz/0uQkblt62HFQ6psHDYlMhC11oKIM+YgT0n8GaVm5qbpgeufKdH4dfBVzLxwCGQsHzVwf9CxT7FyCCPGYLKGoEOXFYZnNWyiYKoKiXLcI1Okj3qVAL3pxxpnOWy/qEw7rHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035388; c=relaxed/simple;
	bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyyxMSt2sqfhdYG5fpBAHjC0Vv/XKSNMu2EpUBlkiIrnbmO2FgLPfjHesanXVMGnRgkIxo5q1ZCf/CDX/8x8cRl9O84172SuCmKrp4lqKM8u6Ug1X73SJBM+kRL1Gyc2GQNKyc3PpLro/i4XkqOH0vH7gXVdqygHW6m1vM1zUb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X1k57tXf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BWReC2xt; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X1k57tXf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BWReC2xt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732035386; x=1763571386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
  b=X1k57tXfUbsPYMXsp9zB4c4UUSnSPwaenSEJsMZLx99XtyJcHj2XvpHB
   AYRd+HE6OfgMf7IKsDRIHLwX1KDSAUVMrbh/QPAh5cgS9dq6K8oOz6cc3
   bfxPvIbuTbNtVUc0jBZiWubW76NDzcYnVbLBIqnsrHHVy6Q4wc9yjDpbk
   tKROH9SZte2AjbLV1QHHw1aVjLhlV5vi1Xsp5xoG6c17lDXn6lp4duVQw
   30HWwPDSRADCkxtc9Poe2smJeaWhP/1i3JYlseLZC61a9UvfgNVNKkFlm
   +NZJsdnbi5wAHNSDjteABQGFaCCxGfdUcvjF+9eGEFOaSDV8Bd9nIHq6h
   Q==;
X-CSE-ConnectionGUID: 9QtKT/NuQeio+iEqIca4Bg==
X-CSE-MsgGUID: ET0rxZQrTuuegx+Rp0RJuQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728921600"; 
   d="scan'208";a="32860111"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 00:56:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnPRrdmgrwwgvqp2eN1cHWgEOzDtwJTzPxKFh6/gLiNELCnFUIbSkLXQ4YvDP2QIhqDBOE3UD5h1OR4ZcfBhyZkNzlfGfKJzSvpKUr+VNM2IFFHFv2v+UQbAyOaoIXsFUvhF1MHsd5WRoUpDqAiLgEDeIfifQI9lHlj4Or7YSYwa8eLJsCDjQ4HBrG+Yi/xqH/p33Pg6lixzruvjTBen5d9f6kNxnndwVP3Zz8VGOUwmk2MVNF4meyyf1UhX3VgEt7SVC0YeMgjDABhKUt6E+2vrvPJfPj7Md71tXTOLMchDAYOinzIvrGe8YQCzpbS+g9byjA8ltUVYooSH9Ld1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=D0VUrBD2ZGdENjCVkpdJsKcXEr06DS6uli6H6AC4+/u5dvejxsbh0E3FvO7p7q2Q878c11ckcSmR8rW43yPcfAbOdBoZdHDEggb1PAAj48/ats10EFxM8AZMifyBXoKWc33n4p/GP04+Khql8/yj5f1W2RwdJq4xscV8UcUWm6qdsxLzUTexUrvD89y6G0Tdqe/lQG2DV00b+FycstCsZkdKPkHjzUFxBZCZp2ZNXdMTxwV+IsPsVLSpwKcU8hhsl4kXe5i52UIfIMXyuf7YX5jZZdNCRRxU2UL1EJ4yp8waHMyvThTmMUf69q8jz9Utnx/Dx8awKep8fj5rerN4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=BWReC2xtU0tP01lQfmtABnTMQ+gMT/bU/UyhUMAmCYrtWOan4RArks5OwwXYqGJBSToEkUl6rwhAYnZ0hFp7SFu9MhVbdTJZfbrV1FxDmYFxhEg5Q3FnZji4jDmcNVRaPGeXLWWHZRVMQQUfpuK+OmoGr5T6X/saz2H4Hvp86Bw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7391.namprd04.prod.outlook.com (2603:10b6:a03:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 16:56:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:56:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: clean up bio merge conditions
Thread-Topic: clean up bio merge conditions
Thread-Index: AQHbOp3LpNhTH7q9G06SXyvqfFES17K+0qkA
Date: Tue, 19 Nov 2024 16:56:16 +0000
Message-ID: <4d69e33c-e2aa-4966-85b2-58ee04fd4f9f@wdc.com>
References: <20241119161157.1328171-1-hch@lst.de>
In-Reply-To: <20241119161157.1328171-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7391:EE_
x-ms-office365-filtering-correlation-id: 59610f0a-26d7-4c38-0783-08dd08bb1550
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Unp1RjY5b0tRb0VGLy9mb1NqSzU4WkVVcXNqTFBBb3NDYXFqZXhkNlh6bG5x?=
 =?utf-8?B?aW9lZjl4RzNOVUw4TzJGQkdRK3VpQStoeXdDUzBhd0JxYlhqMk1aTUpialQx?=
 =?utf-8?B?UGhvdGsxckNIcURhYnNZSHc5TDFrVzY5OVc1WFJwa3QvdUtYd1d6dW9reDNV?=
 =?utf-8?B?S0xXdHRkb0U1RTVkOUdjMkNIVWZJa0RDcFhlRjBHYXJRdmlud0tJWFNIczhM?=
 =?utf-8?B?VDlvT0VwOXlaMzEwaWJWRlo2YWhkQ2tPY0ZrM2JZUEl4TXVOV1hhdVFUWVhz?=
 =?utf-8?B?OHdWT1NqTUVTdVdjMDhjc0RzOCs4U0h0MTFJQkNlaWd6SG5NT0pKTjNkUHh2?=
 =?utf-8?B?TjdrNldIcWtxMkhQWmZzOUExWDdWQUNhRVJIR3k1WkdBUjJpNTZQenZmUk85?=
 =?utf-8?B?L2FOVUd5KytLbWR1bTRGaTdjMnc3bHQ3cGtBUVZ5MmNVb3pmd09CcGJ5QXhu?=
 =?utf-8?B?QUIrNmU5Wm1wU0RvdnNIYUthRGpSSFQ0cXhlU0M2aE9UUnBsTm1tUGpJaTBo?=
 =?utf-8?B?dFg2OEpSQnNNYlRQK0lFY1ZqM3pFSjZ1MUNVY0RhWXgvNkhpa2o3eDUvWEwy?=
 =?utf-8?B?d1lJeWdxVnc1bVJBRWxucXlBK1JFVnhLZk9sQk1GeHNiZXRFaXEyaFNhVHVR?=
 =?utf-8?B?UGkyRFdyZDdQR3ZjZXd0M3FFNzNtY1diTDlNWkpJZzlzQUFmSlNJVUJSWkFW?=
 =?utf-8?B?WklBUFZoNFdyTUpGZngxYjBKUUR0bExMSkt5NnM3dmxwRVZpdExtdG1CcmFU?=
 =?utf-8?B?NllqS3IvUSsxeUZKRzZKQ2FWVTg4RFVTZFovbU9iZmJhVW5URTRlT0FtL2o4?=
 =?utf-8?B?N1Fud3pjbzdBSUM3R2VmNkM0QU0wSGNGMk8xYVJweG55c1ozQVM4KzlDcGtH?=
 =?utf-8?B?M081bWkyZzFyVkRNZ3FxZXBQNnJjKzFjdTlabm9CYkJhWkNiUnJuWXRMM0dJ?=
 =?utf-8?B?N1N1OTlUNUJ5SnNla2I5Mkk4cFRiMzVNTCt0Rnd6bzNQNFBQMjltenRoaFdO?=
 =?utf-8?B?YjVrWGZCU2ZZVVBselZ1S0o5ZkpaZFE3d2I3VTlpbWFQb01wWnV6d0VFWk9M?=
 =?utf-8?B?U3I5RE9LRmJORHJFZjNwL2dIcVFrRG9LWXBSMmdweDdaT24xVmsreVVoNVFH?=
 =?utf-8?B?SzlMUEx0UWFzTlNiR1gwcTNDOU1nOHM0SGhCTkFjTXl0WEFZMjhvMXA5N04x?=
 =?utf-8?B?NXEwSm11bkJaK0xTT2RNTjdNaUJOZ0hCUElPclpRMGx6US9ESmMyVS9Kbklx?=
 =?utf-8?B?aVhVNlpOc00rcmNzWE5IS0lEUGM0YmVLdHhqWGNaR1FkMUo4ZEhFNXBoaWwx?=
 =?utf-8?B?OFo4cXhQN2YyYVJ2S2I1NVJ0S1Nid1NqZXF6aUM3eDMzWlBHV1Z1Nk1XVTlT?=
 =?utf-8?B?dG5IZUQ0djJWUllkSVdZa3BMQ29wVTJGSVNYL2xhb210SUxSZGg1YkRrZ2xE?=
 =?utf-8?B?ODQ5ZGlWdE9KdWZiMUFJZkdpSXFIbzhNNWFtRW85cW5raWR3ZlR6U3g2d3g1?=
 =?utf-8?B?NDlteUcva1Rjckgxa25uckdZWUhXejNJQlhyZjExcnRIdi8wQVFaR1laVzRs?=
 =?utf-8?B?K2NibWFqSDRPeUZ0RUhBYkkvL0djdk1Mc3g2VUNYZTVxRnlkcTNSRkcyODJr?=
 =?utf-8?B?ZDhMZjkwaFpFNGlxNmJmS2Z4U2dpOFY4QnUwM3BmYmRCc3lrUUp6RmM2b3dJ?=
 =?utf-8?B?VFBReTROQ1luR2xNVzN5MjFNZlFYdlR3aGFWeHVXUkJaRGcvUnZRQzZjM1E3?=
 =?utf-8?B?c1l1ZjhOa0Ivd2FUbUJIS2JpeHJwUjNSaG5vaUZreTlQVk1iRFFJWmZMTUFJ?=
 =?utf-8?Q?/sS/7eX+6jXcaDcY59GvDiGOdyJw7v37zax3w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z25CVm53NzBBZzcvV2ZTcVloTjIxYzdQT0x2ZTBzYmowMWwrNnhHMXFHMkhS?=
 =?utf-8?B?K0xyY2JQM2FyTi90UU5Sd3oyZlR1bGpZclAxS2lKanFFQmhpQlBXSTE1SGpI?=
 =?utf-8?B?T0NpbDJjaGxuWlovckwrUENMd3c1ZC9vSExoZ2ZvZCsxV29hOFo0bEdtQWl2?=
 =?utf-8?B?Slg0K2pSUzRBWUo1U1VCcGQ5WWIyL2N4SWRneVlDWk11YWllUzhuTkFmUFFh?=
 =?utf-8?B?K25Sckd4UUxTeGtMaitwREJiV3RCclhLT3ZtdjQ5Y0hJdGQyWkszQU9ldnVM?=
 =?utf-8?B?c3BXQXdYUk90M3ArcXdObU05WlUxUnp4SjFybUZYSEgwZVFuOWtpSWpSb01X?=
 =?utf-8?B?cEd2WlN6K0JrQ1BLUTgxRENzb0QySWx4bHJteDd1Yjdwa0FXWUJ6TGtKaC85?=
 =?utf-8?B?blhXNzZRWUdWU3ZQTENhZTFMUnp2SFVGMWZwQVBld0piTnp5ektwU1VjNG8v?=
 =?utf-8?B?TW1JakxlZWNEYTBqUmg4VjR3TGIxd0V4b09idllmTEgxODNnUFZhcnpib3JK?=
 =?utf-8?B?cWk3VlB5RWl0cEY5Yy9BRURaL1VBUUFsVS9XZ3RQQVM1NlVzWFBIenhkU0VL?=
 =?utf-8?B?WUxIK24yMGJ6N1ZidEdXWldWcDJnSElGVmt1dDlWd3NXTmdEM3JZYUw0RGkv?=
 =?utf-8?B?cnBwSXEyUitoK1QwRm4rU1NldGwwbXJCb0NDV0c1QkdPMmNkNGtNZnFpM2U0?=
 =?utf-8?B?b0RJdzBDT1g0NVJGdFU1aFRWWjBNbXczQThSQUpsTHlZZGdOTnhIQVozUWly?=
 =?utf-8?B?MVFyZ0VmTVA4dzBDdk4vcUxURk9XMFF3RDJ4eHgzTHgwV3NYcmNCSEJlVFNU?=
 =?utf-8?B?eWtSM3VtYzltbkFtdlBCUVlUUmNyc284TjZ2VkNWdkVaYXBUV09mTitXTjJV?=
 =?utf-8?B?TkZ5WitsajVuRTVrS1NtZHNzSEd3Tit5RWJtMmlHM3J5S3ZjaElGWkxVMUpj?=
 =?utf-8?B?Y2NyR2RZelVNTjVCaGdrSnhnai9UTUZJSVZpaE9HVTZTMWl4SWNVSkVPS0NR?=
 =?utf-8?B?SGZhNmhCZ0FpNnltcTk3RXphVCt5SXBoMm1LQjBuSGNTVGppL0h6ZG5NL2lD?=
 =?utf-8?B?R2VCZmVlOThvNVhwTmwwbmNreHpIVkd4ZDZITlRuRDlCL2RNWk1EVG5rUytX?=
 =?utf-8?B?ZTM0NXZWMFdrWERZM29abDhQS1ZBRmtHSVVucXJxQVJUZjIzSkJBNDdxcFdS?=
 =?utf-8?B?ZTU5VTVGdGxrQTMxd1M0K1pkdnZUSFhYQlN4b0hiMDBGVmhydTJrSDNwSmpY?=
 =?utf-8?B?Y0VRVWF6QzduOUNQREswb2pQZ0J5UWNnSUF1dEUxbGFGc0J5MDFESGZCR3Fm?=
 =?utf-8?B?RHlSN2lBT2ZQN1ZNbDZURzErS3crVmRXN2V5elZENUZBU3Z3NGhEbm0xMHhO?=
 =?utf-8?B?TzRKSTNKZ2tzdVNsZzZiUEdncmpkSUlPWEdXZzVHdFN4NHlVMzdLZSttaWRR?=
 =?utf-8?B?SFVpZlVkaG5yQU5vM0NLZEI4UmRIS0JKVm5TckEzZENMWUxlNkVyYWVVRkZO?=
 =?utf-8?B?R3VDNFdDdDRNNDJBUjFwRzA1K3FOOUFNdTVhanh6R2FoRTNaNkgrTVVBSzFL?=
 =?utf-8?B?dmZHVC93b2crL0dBTHpZdjJuQ0JRcEhMdkNpSnlsK0lUVHlDUGRxU1dWdjRz?=
 =?utf-8?B?M0NlN2xBTHNoakVDQ1BVTklQY1psTmMzaHZVK1dYZUNQUGVaTUhENVU2YjlU?=
 =?utf-8?B?eXhiQk9Gd3hJb3hyQTNaQ2RtTitRd3d4T2pvWFFNeG9wdmZDbTc2ZmhYZHpa?=
 =?utf-8?B?eCtmeEJmZERLRmhJd3hTUDJTMDliaXBYaFNsQ2tSM2hETzE0d1JmekNEUnZY?=
 =?utf-8?B?THZvNFdCbFZubVJJYzM2ci9OVHR6OHo2UVpPd3k1dXlhNjkxR2tqLzVtSE1Y?=
 =?utf-8?B?TE9BYS9COWo4cnRENUROSzBrTmU0eXQwNkhDYmhmVHByQmsvV2t3bytHNUNP?=
 =?utf-8?B?b2VFNjRSRUQ3NUNBNGFoekMrNmZJZE0rVFFCRGhieXd0OUEyNnN0YmJZWXpL?=
 =?utf-8?B?WndHYlU1cDg3ZDJteUxGT2QxKy9WMUMvT2R2WkpKZ0NKOE8ybjdCYkRiYlBy?=
 =?utf-8?B?S3JwaGJ5QlFWcXQ1U2Z2N21qSXlxMU50dzEraXd5L29lRFpFK25hYnhqNWoy?=
 =?utf-8?B?dlg2cUkwOUpWSUNSSXZYMVdJaytJUWhFTEZyYjlKRGNYSDREYXZieFhGU29L?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5D0F17212631841AEC474AE02EA7F6E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eTeQodxOI70H/L9nlwDj2MuaViT2DXCnTuM20e6iT6E825F6Ii+fMki/PNYSWxYBr03lgkSbHpgdAarMEq9y8iiZ5K8O/6GgxEoJH5KlrklbbfRTP8rOpsLmn52l3D/tffkumjvLDQOc/o0X27AXd8mQler31i/YZ3kwVl3Qu0Tl5voaR2uR4lQ7uywKEwnyUXMQnZjd8psaANQBwtWWuo1ch1WwN7q/fXS6KESDZxJ97Cx4VbMDdWnFJB9FW7yGOVGhrun9KVEQ33ufUY0SH37uY2Fr99xcNZIjY09hAw/CD/qz/CaiGRLyN94pN5tMaHgp2CCudzvaqbOkdk0i2rWcjt9KZ9o4+ucb/M9rM4WZi0lvB39PyP1XIV4ZUb1UT/AQkUOFvuHCvASandGS2zoGFh58q0vOatuB3w9AQKfdJA1yzIGpXlLL7ifwV+BmOWGvGK6QgxNSPUY/vjG4NTFHavNOlV6OkqqK1oJVYXO1Z8n/2RSGQgDcvbq3KMOq/Xw1KbkS7DzX+Z7zGq6OAtnoc6m5qyZwALJy7as6ro0SUJq4VI/jz3OXo5cg83uzef3cpFvA2v2L10HoAJvS5Kj+Qm5xFTRvLoQLjfQDcB2UvMp2tPeefVkLLbv45FQT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59610f0a-26d7-4c38-0783-08dd08bb1550
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 16:56:16.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cwu/NTAVoLrZ2DFodysf86BU+2CIOIqmWPLVzT8V5G2MF9G7CVwxmRHC9jvIK4Ad932QVMAEsDKgWaiunE9OL+wGwmBb1lh1jQB+2SUWrgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7391

Rm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
