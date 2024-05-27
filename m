Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878917BCA;
	Mon, 27 May 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795502; cv=fail; b=SS3MFhNqjH3XRHeZ1W9OF6JrrLOpqKlRXZkDuzJzb8CziNgMQm3RIFzfeoHJHXu2d+ToLTeWNw7a+3noSgGJTEGwLVMBV5BubBnIj7eigZX7EOadbQ7XRISeQfl5DRRy7hDFkt0WfGgUt5OrZWozYzDImOQqRClpBAM/RfEVlZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795502; c=relaxed/simple;
	bh=rE9gmSyLYv4dFVWSJ6UIu2AG+n7o6SfDNyDf+CjN9jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtyokSdX7WENl/YnnTXjMDIWazsYyHlhMhrzTM124R4ysyxEpdZ40FeGAocvaNOwliNMls1uZvhhFr/vMleQFbmM0r3hp9aPXZuK1bl+3HU3b/GNzH3IvS88ixaEs8JtAU8Hc5j42YaiMBDKFuNm7bVUrjhOl6mfGN+9bUbQi04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mMeHrBOd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ENFZ8oZw; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mMeHrBOd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ENFZ8oZw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716795501; x=1748331501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rE9gmSyLYv4dFVWSJ6UIu2AG+n7o6SfDNyDf+CjN9jY=;
  b=mMeHrBOdDLtu2cqmAnwsWOax5VEZf2hqxUCQavzzdgFZFXcW4Uck8Q0G
   duktJdp82yWg1m8WakQLCBevtO3lJlV+UuGnv6pSsPumPuG9E75tzggAw
   yMQ9hZ4mzZqGiuaI0y8nyGCyH/zS/i15ky64HeoaOiRWtLXXSv7fYy/Hp
   GxvfIbtB2MxV/gRcP7x/svmhpF9ebiU61N9peS0WtGcHzCO1XLErbfYyw
   BZ6skxE1SiNb01WyAe7cmqEsth+fa5PTGY8HbfsppQJm3C9JEeIEYlNgW
   Fof8dWweZs+VvYW8Qj60JSkKfDonJ8XSuug1gMT5sA4kTf5gZL38CXwDJ
   A==;
X-CSE-ConnectionGUID: bdn0JD/wRF6rBgai7QsUzg==
X-CSE-MsgGUID: /+dofCCGQne8h/RfowMeRQ==
X-IronPort-AV: E=Sophos;i="6.08,192,1712592000"; 
   d="scan'208";a="17074263"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2024 15:38:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K08rpwnj7xHPm2mgBKFgJXLkuNbhGzd99a26ZJPPsQPRS53yjynxQDAam0z4d9+KmWmrHq+vZhsNWisZ0/dLPj1M4jZUM2D8o1ppRrHuBPwev/P9But/qYLeDaFHfn9pEkYIJftJDu9BAHOElmfJPxSIc/9o6Zx8Ph06EedQ7DoIuMNIG8U5sK70Ce/h5aIUQwos1mzj/ffH6Sp9Cl2TjYnvqoaPunF+MS6EIDiX/OY+evhWa3gSeEuDRp98RiAETtEnILfX2REI00OaJovTnq8WIYJok2fxVs0qncMY5f61w39RralRFSK9eUYkP4IPqCCyPtd21kieLm1PYSk0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE9gmSyLYv4dFVWSJ6UIu2AG+n7o6SfDNyDf+CjN9jY=;
 b=gH/s12IA/sDkdDplecZ6DJ5aBvyr670NZ30KaXYiWkUyw3UtZ80gnGcakNrnTiICjsjaDorrDzfs2VJoG7qCaQsmLyg3nSkU+QpYjtLKXiSogm1/XROADkPlrbfCiSTtRf4zdRjEKaEFjjH1RymUPhfG8/iGnNmfGOhM5oe1hp7IMqAIxr6L3V7T2qbmtpb0fCXC0SuwohHbkF8+9trNfo/t6uMAf/slNfEb2ty6od3NeU6I8g4Qp8+iGCu4fKV//rjD+xV6biKbpbjSyjZOYs6auQFD9HlUF8bHVIMnOFQA5IIViQeSCaYKB0fUip+4RoASD3eN4qsXtCTiVT/fvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE9gmSyLYv4dFVWSJ6UIu2AG+n7o6SfDNyDf+CjN9jY=;
 b=ENFZ8oZwrJ4oCjFyfROmZFCaYYdRWcfeM4fmZ/t7SmaPnkZ8jggbd9iqmGaNL1whEO59r0cful5VMvBeToOVZYecaNNDB+X8hMY8gjadh4SzvWHOZTVzKOJl37qhX7uZ5tEzOEJksOOFUO/GXcQASPV3sm4Sgr/ZngQQ9R83Xk8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7537.namprd04.prod.outlook.com (2603:10b6:303:a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 27 May
 2024 07:38:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:38:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Markus Elfring <Markus.Elfring@web.de>, Yu Kuai <yukuai3@huawei.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Bart Van
 Assche <bvanassche@acm.org>, Chaitanya Kulkarni <kch@nvidia.com>, Chengming
 Zhou <zhouchengming@bytedance.com>, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, Yi Zhang
	<yi.zhang@redhat.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
CC: LKML <linux-kernel@vger.kernel.org>, Yang Erkun <yangerkun@huawei.com>, Yi
 Zhang <yi.zhang@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] null_blk: fix null-ptr-dereference while configuring
 'power' and 'submit_queues'
Thread-Topic: [PATCH v2] null_blk: fix null-ptr-dereference while configuring
 'power' and 'submit_queues'
Thread-Index: AQHarOVY0VXK7QNuUkqU61vUOCDLFLGpfqKAgAE5PwA=
Date: Mon, 27 May 2024 07:38:17 +0000
Message-ID: <7bdebf81-253d-4278-a615-ed82692e026b@wdc.com>
References: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
 <369912bd-2ccf-4cb7-817a-a32ccbb3d83d@web.de>
In-Reply-To: <369912bd-2ccf-4cb7-817a-a32ccbb3d83d@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7537:EE_
x-ms-office365-filtering-correlation-id: d06084a8-15b5-4085-6795-08dc7e1ff944
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?U21lYkhONjBpSXMrRUd5bUF6RERhWFRwdkQ1MWY2cTRKQStoa2hKZHhsK1FF?=
 =?utf-8?B?NVd0dTd0c2lHZ0tSVEM5bnJ6bzlSbWdUcTFYZUdMdnlUdUVFSHBVSnYxRktm?=
 =?utf-8?B?YmhMT250VFNXRmIzNlQ5c1dKNjgvRjJPZmdwdXdvK1RrVXZJOW12cTNXQUtn?=
 =?utf-8?B?QWtjYldYc1ptY2xoOFI2UGt2Mmk0cGhDL0lhTDRjc1FLb1dydWFnM296cFgw?=
 =?utf-8?B?WHpRSUM0K0s4bGc5a2YwN1Z4TzVST2pWOTNuY0dlNWZmSDdRT25rb1V6U1RZ?=
 =?utf-8?B?RXdEVi9aV3ZRd2JjUmpDTXpTc2lJajJVclY0VHN4ZEhUQnp2U2dGVUg5V2Rp?=
 =?utf-8?B?S0FjaG9VRlprY3BNdDZjamdRQXNxNWNRR0FPbXhjVTRpR0ZUU3ZMVHFUZG45?=
 =?utf-8?B?MnpXTWtKQVErZW45QUdlYWRWRVozTnpEYU1qYVFyZllGcVc4b1hVUTlXd1Mv?=
 =?utf-8?B?Nko5d2hSSkNZRTBMcXNJdmZJd2ZURnZxejlqcEZsdXRGZnJaN1RkdmRPNUhY?=
 =?utf-8?B?ejdORDdCTllnQ002SG9BRHJmM2kwOFZTNTd5NWc3SmlDSk9waWc0TFJwNWNj?=
 =?utf-8?B?MjRWNjdrd25CWUhTbXNkL0JlV2J2RHozekZ1c0VBVkFiRERPNHVRSWpNZnhp?=
 =?utf-8?B?VGMvMjlGZ2d2MjV5U1dzSzVmTFBIaGVqUzNvQWNtbFFsL1FxMkJBSmVQbjRs?=
 =?utf-8?B?M1h2TkJnOFBsZWlJQlQ2SkhDWlFTcGdYUk1kaTFVZzZNNUsvYTBlNGhTaUds?=
 =?utf-8?B?SE9Fa2JPdWFSOVYrTm1oQWpvcDExb3NrSVBaanNIbHZaZ1RYRFIvWUhZTTJv?=
 =?utf-8?B?d3FZSmsxcUdQYWJlODFiSHRyM0xqNXo2U2ZiQmdST2hJdlhJOUZURXMyZXhR?=
 =?utf-8?B?QjFacyt3VEVsaEpPdGN6enRDdllrRUFVaFkzYlg1OUN3TkZrK1FVcjZ5VDFK?=
 =?utf-8?B?a3pnTUpjQ2NaVmNCS21SREE5bmJhMW1PUjFPdlNTT2xJbUdyZkZGQ1F2eVly?=
 =?utf-8?B?dmRpMU1Nak9kWWlXbDV6dGN3ZHR5bUVTQ3BNcTFWZDlSZzNqQWJaZ0JzRmtR?=
 =?utf-8?B?cWtkbXZ0UXBUMTlnRVh0VEtDdmxQTzhZNzczbUtrMVNPck9INFd4bGFoc2gv?=
 =?utf-8?B?dmhZY3N1Zkw4MEdsZFlGV2p3cndIdE9JZUxaNHczNVQ4eFpmMGlzMDF0QmhX?=
 =?utf-8?B?NTgxVCtnNUYxV3M5L2ZrOUw1UzNGWllpS29UVEIyUmJ0aDZNMEkrUzdrcTZC?=
 =?utf-8?B?aHN6UUJ0L1BKOHZlQXoxVVZmVm54eVlqMlVSZW9ydGdhRHplS3UrV2lZWnNj?=
 =?utf-8?B?Y0NmMzFpMnYrR2o0blZYQTc5Vmc1eU80WWYyWjQrb0lBcWQ4S044dFo2bnhZ?=
 =?utf-8?B?Rk9kZU9ENUp1d1JoRTl6bjFXbEtHYmoyeTNVNThxSlZnY1R5VUtWbElRZnFl?=
 =?utf-8?B?YzFVelRvN2xqUG9lb1diaURLUFpqMWE1S3czTWdOSm5TcW1yYkpmU2tpUENv?=
 =?utf-8?B?VGxuM3RBT0xuTzhZNlZ4NXBqT0FrVjA1M2VSajZtSlNqSjZtSFQvQWt0T2F5?=
 =?utf-8?B?aG1oalBrOG8xUmtUWHErcXpNS0dFeWlvWVBsMkhIVnFHbEkrZnFkNjI4OFh5?=
 =?utf-8?B?aUlaeHQyZmRYS3U3VTBmMFlIL1VnUlVvOG9TbUF1RVF4amJ3ODk1U2RUVjA2?=
 =?utf-8?B?RjdvbWV5UDN3RkNSRnVWb2RDNExQN0VnMTN2M01ZbmNHZ2UwN1BySnpKb0d6?=
 =?utf-8?B?STRRZk1QSC9SanduMEtwZ3JZZnJnQUhUNFlxVXJvVS9ubk41SE9YR1NBNWto?=
 =?utf-8?B?aFZGaEpJNTQ2UFE5djU0UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFIyWFg2REtqUjNxSVNIS1o4aVRVcnc4U1pqOG9naGRUSllOL2wyOW52ZHps?=
 =?utf-8?B?NnJ1WTBwQndNQytEL1ozZXJvdnZweHRJRGpFU1ZVa0MxaDFyNmxEZ3J1eHNs?=
 =?utf-8?B?UDVnclU0aHNKVGt2SG1BTlJXTE41bk13U1dwUW5wM29sRTh6Sy9kd0tzbU9i?=
 =?utf-8?B?SWlDTEMxaGJTcERheGhYdWowaGg3ZExKcm5TUm5yVDhUT0RiZkhQVzJIOWlq?=
 =?utf-8?B?blVoM0JYNlRncDEwdW1MOHluaDNHMklDa2xxUmtrOCt4eEdmaUkyYU1XOWlQ?=
 =?utf-8?B?Nm5pYkxNT1FoMXVHS0lRQXVpWWpmWGorUmpxYzM4aGJkMWhWaXYwQ0hZWDVx?=
 =?utf-8?B?VCtONGFtMWMvYWYzcHVrMHZEQnZ0dGNqcFhRSHRiOE5MS1Y0UUJyZEVHZjJK?=
 =?utf-8?B?bW5Ya0Jpd1RHdmFPY1p5TURzRGtqV2ZrbmVBZTg4T0drd3k3YlRwekFqd3lH?=
 =?utf-8?B?bHp1OE9lYW9oTUhzSGVENHZLcFpieDBmYXQvM25mK0l2OHdpQWtlTDdwR3Ns?=
 =?utf-8?B?eG5LcGozSWI2SVVzakpleW9OdXd0YXNsbFlzMXNUMHBPZnBQUGdZTHdsOVJ5?=
 =?utf-8?B?TFMxZGRockFuelBwK3VwTVFpMzVNaTcrWW9CRzdrMkd4KzhJRHF3Y0lhak54?=
 =?utf-8?B?UThreFdZMjY4SDViRXlQSXhTYzNRSzRxRUtDNVFrV3NucmV1dmdrOFh6bE5j?=
 =?utf-8?B?OGU2b25NcmZBUzVqVTJXdVoyQzN5TUhsVjEwajFnRWRXbUNIWk9kNmdPWFJW?=
 =?utf-8?B?c1kwOThlRCtFUWVSSUc0dlp4dWFMczk2MDBJMWt0UkExRUtJbDYwUXIxZXJS?=
 =?utf-8?B?YWJQSmRmTVpNSGhDOWFVekliSmxVOFMxODlEMWpmSVhVWFBTdUgweWR1REZx?=
 =?utf-8?B?RmFWVmVIWDd6R1BkSW1OWDdlbUpKdHpXNGhscWV1YVl5Mk8zNk0yRGhoTHBY?=
 =?utf-8?B?N2REMndvUnpJdUlWQmlCcUFncVhtdEMxNjVHaTRWK0RnN0hkWGxvektkV2Rt?=
 =?utf-8?B?R2JQYnZRQ21FT3hGRXpMT3BDWG5Wd01oSlV4K0IxNlNFd0o2VTlWR3N1M3Yy?=
 =?utf-8?B?UTNBM0tlc3F3UUJXUVBtUytzdG5mMG1jZDNjUnNHbVF6TVJsYk1Db2dPUy96?=
 =?utf-8?B?TlZwM0h3T0x6ZG9jQWNNMFhpaXZGMURseVhxaWNOVjR3Skk4VHlaaHhTNTJP?=
 =?utf-8?B?OFlzMVFZM1U3MDg3SXpJNWd6NXNhK3dLTU9MVWtyN2JkaXpDYUlUUVVMYWpR?=
 =?utf-8?B?dWFLbnF5L05mSWVhZ3pUci9DbmdIY0IxL3Z0WTFvR1JtZzBEeUFFMHdyRE5p?=
 =?utf-8?B?ZmRvZWF4TlJodnQ4RUZITmtqMllZeTFodDBvT2ZaQzE0SHVnSTVwRUJRL0lz?=
 =?utf-8?B?cU0xakY0VDYrWGJGQmo0TjhiZ2k0Ky90Y0xpRFJBWGFrUDdEU2NZN1BHNVFt?=
 =?utf-8?B?MHdyOUNNeHFLMU9MQi81cFVSMU0wWEp3VDdEb1VCWkdLajhkVDFuTTNzSVFI?=
 =?utf-8?B?T0J5cDhuS0dsUFlHQTh1bVpIMXNld1RvYUtvRG9ISXJBZXl2NXZleGdmaUIx?=
 =?utf-8?B?eW0yM2pYRUpCS1hJR04yODJ2Z0VReFhpVkZmek4waEF6dWFBNEFNSlFhMUlX?=
 =?utf-8?B?Z3YxbnJaYlJxckNNVzhXVFBiM3hWNUp2TEJFMEdJZjM2NmJBeEc0ZnJyYkE2?=
 =?utf-8?B?blF4WjJlVUNSMkZ0dnF1ZFpvN2lUMnNqMVVLdzZuZk5aU1o4dnFKMXZkVFJP?=
 =?utf-8?B?QTRsWktaZ2RLT3h1K05NVlVLa1lPVDNjYXZmVGpZNnFxYzZIVlBMTllGbGFE?=
 =?utf-8?B?RXlZekVEWGhKNDkraXE0T1JJbDVEd2NjV25GMndyLzY1TS9qY1NycTJmSTNx?=
 =?utf-8?B?djB6TlorREdhWlBNV2IyTE5nN3lUbHRWOVBuQVdWTW9yMFJxcFRIUUtEb2Zs?=
 =?utf-8?B?ZGVrdDNhUDZsK1ZUa0F1WVVrOFNDREpuRHQ5MTl0OElqNWYxY2s4V1FPMEVv?=
 =?utf-8?B?R0doNTBTMVBQNW4rUTBuTVY5RkVCZ3BjYjM5eE1USDEvbndKRmVZdWVzQTE4?=
 =?utf-8?B?ZGVDNmNobDhtbWpkN2ZObUIyUERUb1oxM1JranlBWk9WK1I1M3kvSlY5NU9Q?=
 =?utf-8?B?NGJ5V2RLTEhuZzB2emNVajBEVGxwY01RSWkvRElCMzc5UldKdVFRdlhvYmJE?=
 =?utf-8?B?YW5zR1FGR0VZUU9UQU92bVRrRU40eXpoRUdlMEY5czBRViszYmZTdk1FSk5N?=
 =?utf-8?B?M3diZTVwOC84aTdES0tNMVErTUVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CAD1A9D602E37478873D47E2C0782C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MKmIVwYWq+mBvMjUWKKVFm8/oLCd5htLKrYSF6OL2R6yEicpX6Ik4l3VMejpq6j2Y9UN/PEOdqp6eBXWEVOo473y/XXXC8nxzb7Sp0V2meEOImiX2WnbFHKH4GHwGmscwU2xrYlcyC7CmA90GhvwDiqDRFkXHOjqIefSGNwJOwJCKs5HC5PlmqLVoJSZ+M0u1bryiw+qGr70rmbsWILeWAfyqx4v92y1sgFCfq2w/FSNsqWmTVgGZC8BnGdrjVGSnnMDE9NtrgPUH/B4Up5kaX7MWb/I8fBJtMWZFL1tQUc6zAtTaYYXs65krAvPsvr/SKnce7KNJYjtAlf+9YUfBj5H7GSsSexCUmUvyzyMzzU+GOs81P52+ON8WGBHZRxPSEB41Aj/l3QkFaLzZ/EszrYoFHZ1kPkbL2sJpd3CM32JxrHMlYapQezI+0AnYgffRVLRr7Djl7ZsJm9K0pu8kGmpNJPpMVKXPPILVFjlcukdATnGDYy7j4LqKIygpGHa8WJTOi5EgQS04VF1WgreoPoJK14yvuIg3yn0Yz+0Y6Q6JtIsVU5iEX/pPJqyS+K+dnPTSfwkvjvI5R/CtjOStO1QA4vcI9sSOdxw1+ZOO+OYawfWYHimuo1eReRx4Ur4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06084a8-15b5-4085-6795-08dc7e1ff944
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:38:17.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcTSI/e15kKzBeEeRr+yISYnid3c4y8eDYn8el21YqAGkh48jcF7yqDbvqTxtYU5QEYjnNQtRTJRjtBnPfm6D6u/RD4sGHC+yjgkzE9t/uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7537

T24gMjYuMDUuMjQgMTQ6NTgsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiBXaWxsIGRldmVsb3Bt
ZW50IGludGVyZXN0cyBncm93IGZvciB0aGUgdXNhZ2Ugb2YgYSBzdGF0ZW1lbnQgbGlrZSDigJxn
dWFyZChtdXRleCkoJmxvY2spO+KAnT8NCg0KTm8NCg0K
