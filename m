Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1821552FC
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074781; cv=fail; b=HCEr7Hks9FAyjuu+iNXk0RrKsET1JAyflNU8RuxgMSBowbSza7Z9nvNzYeo1hk9qHg2+PfSPz9wWzEI3K1tV0BG0KR83IHJnAQP1jgeoc+vGZ6wPA3UcJn+6GfUvo3B5Nkl8XlNSndoVkH/Vwi7U38WXjeUHEJDjsq5VoYfYSF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074781; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvxSBMNDjJYCEHwX/TYNplHvbuDJ1jSafqNfwEQ1X6VkO4SZmzewoAEGg5YbqNlzg7LwWMwXU5kiFXbtoSVqA+/x7G3yWVHgj/V7uotayyPo0+u0TpZdvxSQ7S1cwAU8/SpKbTkYP7Jxzxn+w9vmlF9wYMmikdOA3APvY0gzWBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C39S+G30; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t35cRvoj; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C39S+G30";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t35cRvoj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734074779; x=1765610779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=C39S+G30gkpTdRI3mjc4JgjVfRN3pjFAwcKGfAq2J8pn52ICnqLZKMb8
   iQbmV6+21nFCKhmdpjiaO9S38zcBDenHWHbRvJZkW4HmOyYHwoaP9SRfF
   rydW309vAA0FN0nZiMQNpkapUA3VS8mD7VjHJfuhtnMYLdIY5Ujk2cUSY
   9BWxvEMClbL4Zon8iqt8cr3F+Yjk4SvnYvHqliZKcb5AqVLzIO3/RZgY/
   xC08nFypl/8OLkyhyVRLc+U+hGVIqHnzx5SHHCvrlvmtOCs8oieGHjSYD
   iUHtHXskG3dsV+VHLlWcP1yoS4EdRLqh6AI1gUKxh299GjRY0eOtWeh3/
   Q==;
X-CSE-ConnectionGUID: dwldZD4mQi2MxlJy+hdoIw==
X-CSE-MsgGUID: iSYOt2zATV6WRz/3RjynOw==
X-IronPort-AV: E=Sophos;i="6.12,230,1728921600"; 
   d="scan'208";a="34265729"
Received: from mail-southcentralusazlp17012015.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2024 15:26:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEkdC23YOCUhvbwb7blRy1Ati08B2Ydwh2ECE+rz3IcDXZF5q3/zprWQAttnwajzakaEPeuD1/0f1dJgcfm4XANdPKhmluAuzj/qzJ0X5oz3I37xY9hdFcr3+TxTCB1tV93bJzgzmSB2MhJxfcA1MaluNm+4cXcqh7giGl3SB7L9XZEPZn35w79sD7PEEJCdT9fViodlUXudGIJZGAN2QrSJgRBb63Bt5iIPKUHMfc5H25yb6oyXrJvI1zVFkiqSPvC4ktPZTL3UA9EV0g7RM74yVnwCBErrtvvf9Cu3+F0bLdZa2BGzlNad0XiWZy7eUA8NMA5jWL/Z8SkNfsJ5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=LEecEXTChP7Msvi50N+QjOtecyw8s39wfuN3zTxRvPo/vjtvD5oA85F5IQSa1Mrqyc1aq0xhe7a+BRyK4Y6wYhxqiVbnV0UEHkbn5aOHDCdZOjK1blm3ONrFxCrA9PqQXRGjXPWP3PXl4KBOL66pfJpt7UpBA2MKm/gUdMopRseDTxGpIQfKybT48fNlIgyF4+Vos3JkzK2xaXdhexdj7MeVUQdJqHUbIA4PWTuBenZtDtXUwVN+oflOmuoOGMEQZcjhr7JoXkMBaA1n9it+oJmQGqX4zAwsivvSzlOVzjTu12jeNCwlYlf66rBi/w7u8Z62np/g1HMqBVeuldatDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=t35cRvojKRbW6bui4kpzFbbViC6Mnz8WklwYuOS9aNyD8GXwJLgXz7dEBCiqDXwoPzDV1gxnXOld2S+xjz7E1BXS1iuuQ0ZONRsuiWYLlFuRZXDYqaXweTFXPC7T9jiRADXu+aB9fWIme3PfC2NzaWhJtUlegwJ/Js4hm7lYfYY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6546.namprd04.prod.outlook.com (2603:10b6:208:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 07:26:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:26:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch
	<hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/3] mq-deadline: Remove a local variable
Thread-Topic: [PATCH 1/3] mq-deadline: Remove a local variable
Thread-Index: AQHbTN0Xadv/L9A9DUudSn9VJz/U4LLjxtuA
Date: Fri, 13 Dec 2024 07:26:16 +0000
Message-ID: <f032ad06-673e-4b7e-aaa2-3bfe6104df34@wdc.com>
References: <20241212212941.1268662-1-bvanassche@acm.org>
 <20241212212941.1268662-2-bvanassche@acm.org>
In-Reply-To: <20241212212941.1268662-2-bvanassche@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6546:EE_
x-ms-office365-filtering-correlation-id: 1845a2ca-1b2a-4609-2305-08dd1b476e55
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnhkRXh0TnVwb0tKNEthWFFmU3U1SWJyK3JmWU90WE5iakdia3pLQW5OQ1lK?=
 =?utf-8?B?WS90empRUTV2NTZMM1M1b0ZaWkJUbFVuNFJWR3JhNnE1RUhCQTRjdWdIUUl2?=
 =?utf-8?B?dlkvei9DVVYxblFsM0o2bmNWUmtWLzlWUi9yMmxIWDZXNWNuYTkxVmhpNmRq?=
 =?utf-8?B?RnZzV2ZvWERJcHRGMEk3VjZJSXphMC9RZi9oYVF6aEcrakI3UDhQeWhsOEdz?=
 =?utf-8?B?czIyUUtkQ1AyWERCSnBxRlB0ZW1KZEJETkNKb0xMcEMyZUI2NWdiOTZxTzBH?=
 =?utf-8?B?WHFYYzBFeDBXMElzcnpHMFIyRnJLTFRoMTJxOEZDUmVqOEF4SlFPWnFyL3ph?=
 =?utf-8?B?S2M0ckpwdk5YWXJhejl2dHVsbk1OaGp6MUdmQ09Nc251Q0oxaG9NOE1XTE84?=
 =?utf-8?B?alZCdlUvODVYR2UvOFFlSXJpdWVISTBWYk4xMnE1TlVnb2pkN09MbXBNOXJH?=
 =?utf-8?B?d2o4Um9PN1hPejJ6R3lMMTBWKzIxajlTeVBRWTlGY3FMaHlGbDJ5dFpYRUdS?=
 =?utf-8?B?TEVvZjlsbVhCZFFrSHNOckVFSStCUEhsaVFWSjhNcFRxdW9LYmxGM3FFL250?=
 =?utf-8?B?VTJ6WWwzYTN3NFViRmRNdzNKTFNpR2Y0SkJNeVdpMHZJWHJLNkpya00zWnRr?=
 =?utf-8?B?QUphelJ4bVYyTFVWMmU4ano1T0Nna1Izbk9HajcwOFJLamYzS2tVVlNvcXlt?=
 =?utf-8?B?T2NsbjJvSmpVdWk4ang3emo5Q1FON0xTcEtxdmdRYlZISE13SHArVXVtMTlI?=
 =?utf-8?B?VGQwekk5QU5EUk5hNFJzRytWRmh6VzRnOXdRc1BHdENHMVpaVVVhTlh4SHJj?=
 =?utf-8?B?VG0wTDRjOFNoL1pMREo4NlZEVG1kYjVuYml6NUVVOGJHRkJ2dE9Uc2dINDh0?=
 =?utf-8?B?TEM4RHNGeFlSUHlkelpYNExtQmlsZEdXT1IzalhtM0JJTDE1ZHpVMUZaZEd0?=
 =?utf-8?B?d1h5eHZCOEJ2UXQxUG1GMXAvaUw3MlBJMlVKdEUyN0puL0VISU1jbnNhVk15?=
 =?utf-8?B?REVzcGVVaXRvUjBFaFE2bDBkbzBTVHdHSnBRbVhZbzZNRHZ0TWYrTnM2SkZ4?=
 =?utf-8?B?WWtuSWVGSkZ5TFlqajZkU2U1OWhxRGU0T3d5Sm9kYlEvN0xRWllIUUQzdzZt?=
 =?utf-8?B?ZDhLUUF4N3RSTU1BS05rdWdqeFdaTWg5WStRbVJMSW1QR1J1MnlrRXYwNEFq?=
 =?utf-8?B?U1JnZEUrT3lmU2JhQnVsTUFMT2wvR0dYU1FocStGdjMvRHRCYStqNlA4UTE1?=
 =?utf-8?B?U003SFZWd1pMdTdqemRPQm16OE1kYnVxWTE3cFNCbVU0OERwanIzT2JuNDBs?=
 =?utf-8?B?Sk0xS1NJTEhsZGFZYmhNanVoK0xXVG1lWjBEeEdUOWVIb0JUMEpabEY3RDdY?=
 =?utf-8?B?bmhRa2N2SEFDR2JFVmJuRkR4ejFYbGxwd3pFVzVWR0F3NjNWMmZaM0VFQ25t?=
 =?utf-8?B?LzBVK2N1WW1VMUVMNVRibittaFV1OEsyRTBUcHhLRHNhRUUra05GV2dMY0ww?=
 =?utf-8?B?b1dVcUwrOEVqVHVKZ0RBRUZsWlE1b2t5dUFsTWhDRHMxcTJJVWFOdXdVRmNT?=
 =?utf-8?B?SHU3VktjKzZYTXhqd2haVUFOSWErMUh1UWFTc1lIM3lFd3g0cFlsNmNwbUQ2?=
 =?utf-8?B?OXFzYjRjOEVTL0R6R0JXN1JNVjN2Wks3cUVHRkxrMFI4dmsrcEgxcHIvWHZa?=
 =?utf-8?B?VERxQmx5bzkyYXN5dThnVGVtN0ZZQlZBT0dsWGFFMkk3Yy9DQkV0aWtOT1BW?=
 =?utf-8?B?ZUZxNFphS2NjVkVsS2FuNTJOZHc3S1JNZ0xRTlI2RUg4M1JxRnd5NkUzQi9E?=
 =?utf-8?B?c0VpYllzL1ZqUkJ0anAvdEFxSGZWa2VZcFdiY2dkVEZYQStnQit1S3U1enZk?=
 =?utf-8?B?dGlTeGxPSStvYlo1WTVzd1hBRmVRV1ZkV0hyaEY3WlQ2RVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGUyZk1XYUF5bldobmFZQ1ViNUJLblpjRGQ5QVRlRDJxTTRldGxqRHY2OUJk?=
 =?utf-8?B?eTJUd1R5aXFwL0tmM014UmhTb1JrM1UzUUR4YnpjNngwalJTUDVnb202VzIw?=
 =?utf-8?B?RnY5RUhyeW8xNzkrdUpzZkQ2aDZESm10T3FiZmgyVG1xTVFVbmlrWUEwaHJF?=
 =?utf-8?B?aldtTmEwRHhQYTcyN1pON1VUYWhqQ3RLNStGZXZ2ZHNhaE44dktQNXVUWGZ5?=
 =?utf-8?B?Q2lSWEVCZkVneHdieUM0SzZvaEw1eVZGKzVOdExmVDNHejdWS3h3eUpzQW9o?=
 =?utf-8?B?QU93OE41NmdabDJmaXlvdVMrZ0pKaEtKdnFxcmJYU2pRaEcrZ2cvRWhmMzY1?=
 =?utf-8?B?L2YzNjJGdGJMekowWlhJc092UCt4T2VXWTBHWFNEU2NSNGkvQlEvWVpVUzln?=
 =?utf-8?B?T1hoV3h4ZGhCak1pVnVuRS9ZaGZqSDdUM3BBejltZldRTkwvbjRsdmVpaWcv?=
 =?utf-8?B?eVVjRkd5eGp1dkRLUkkwSnk4YjNPaDVRL0krTVB3U1JwWGl6dlhTcmh4MEZa?=
 =?utf-8?B?QzhlaGZ5bVdCcXRFWlFiT2xnV01HOUt3Ty85VTA2Q1h6QUV5SC9mMm5SUjBG?=
 =?utf-8?B?bWxvWXJ5WHVmVis5S0xGYzl1ZkhkaXZEV256TngyRWN5RUxrd0dQdU9kUWth?=
 =?utf-8?B?L3dJZTVFN1JrUXQ3ZjZRMjdoZENUTDJvM0U1cS9nZ09GbldpeVdrOXNtVDB3?=
 =?utf-8?B?S2ZPZnlBVWxad0dGMGNRZ1c2ZFIvZTVNZnhLM1lwaVNkZUp3YUtsZjkydmpm?=
 =?utf-8?B?d0xuU1BaV0NpOXIzY0g2bUUrVUQ4eTQ3bkUwamM4V2p3bStXV3dmV3NEeG9n?=
 =?utf-8?B?RDEyc1NDYXVLNGdzaW41c1JiN05EaXNzMXJzM0ZJRGlDdC9QZTVGY09RaFZ4?=
 =?utf-8?B?UmdIWmxjWFg0c1QzNVlpeW5Mck53WGZWeElMY2NBbkIrbStLZm42TktpalA1?=
 =?utf-8?B?N3hOM1ZPdnFLUHo1M0REbXhVWWJpbDRCOVRsRmQvTHRXZlhYMFdlSjRqc3hM?=
 =?utf-8?B?TmgyM3pLenFzbm85anJGYUdDTlMwRHRONk5KbDJhR1RJY3FQNU5tZ2t4dVU1?=
 =?utf-8?B?RjFJSEpkNlMxbTQrNzFhRjIzdndaYjVwbXNWcUYyU2p5N05wUURsOStFYWFH?=
 =?utf-8?B?V1dGeXBmWlpJZnkvbVlsb0YvWDFaRUptUm9UQkpIOE0wNTYvY2VrUlVxd2NR?=
 =?utf-8?B?bFMxWFhEeEVUVHlGUG50ZG1LSEFQUmNrSk5PeXhPVFdWVHhHV09UclJsa3pH?=
 =?utf-8?B?WFdCT3BzSCtpTVltNlhTRExlTi9taU1tTU5EZ3p5d3RvTHErazNzdjRKd3Vq?=
 =?utf-8?B?Z1Q4L010V3NnU2NSU29xUUJOazcraVRjcDcvOTRFZUdPaXJvbEVycURCcCtP?=
 =?utf-8?B?YndLcHZ2cURyYnE0U09UZjBtd2IyaUN5a0dSWG82cVpBazJPbGp0N3p6QS8z?=
 =?utf-8?B?MjZJbG0yUFlpdTRHdm8xMTNjaGxNR0dVWk9wOXRZc1RkUmozK1dEeEtnK0xE?=
 =?utf-8?B?cGRWQlJnR0x3TlhhVEN3RW11SW1tQkt1VlBhZ0hqNHNjREFsUTBPbVlqbU1V?=
 =?utf-8?B?cytKczZPNG02UDUrb2UwWFM3NHN0Q0pQMGZ6MU1lbXZDVjhkSURZWHUxd2lu?=
 =?utf-8?B?WVk0bU1yM29SU090REJVbkdGeDZ0QTdDd1FQaDhWdFNTL21EdTlLdXZoN2d4?=
 =?utf-8?B?c2VyM0FPL0NCdlpRTmpDMU8zbXZwUmRKZ09QQ3AzSGpoZG83bEZoTDBHZXZq?=
 =?utf-8?B?OWhSWGNMblJIbXAyZDZkaUpFT3RxNGRqSWx6V2FrdTYrN1VqY0F0SWk1MjF5?=
 =?utf-8?B?R2VoRWZkYnFQUmh0TEFESnVxN2Riei9NMGxtTXFUQzRkTHl4WnR1SVlDWVFy?=
 =?utf-8?B?bk91aXVtWjhVL2dZK2pJNEtiaXZLZlI5RWlxQk9sTFVPTmQ2RlBKRVV4ekdK?=
 =?utf-8?B?aGEvWTJQOHYwK0VyVUJCbVpGZllMUTF1T3A5TjBnM1VCVVdYSzc5OXhFQktm?=
 =?utf-8?B?QWhvMXZxSGR3VlRrZCtzTmRKUUt2T2ZZSjl3TWxjVmtnaFdqOUY3ZUtKcnR0?=
 =?utf-8?B?d1NYTVdGRzBxWlE0Vmw4M0l5cEdleUNTd2hXTVJnZDBpb2dMMHJrdTNMMklH?=
 =?utf-8?B?YmF1UEtRcHVZdDFuWjJSTnpuTE5iTktvRVBuRzRrODlVc1VRelJ3c25waFBQ?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7578A6B4ECC9D149804365949476F944@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JNkpuorwLbNekp+UYN5BLTy7Mm9crzOBV9I7iFTyvrnjjuBGD0sMQhWYoUXKyN1qS5dghiDbMSSwSXwuBMWbLDK1lwZUGQAW+ArKiaiomI5xO05IraVgHZXz1HIVdyNcuSg99uvtPJuM0Xq+f4f+T5DSRhhIdqJbriQN1jGqrzjEJ7NeCoCaxa1Na4mQ46cowo1bsnsjNcYo3wEIXbsMve5MeVaEekdQDzUW//EiU0rdnIo5MQGKIIlYZpCQ6OB+sbexfT7L1DMH8geMs2WtRREB4eZBe29vIS2Q7s7hPH39MpEnGofMTmJdKlSXz3RoQjQt+nJAtFfNTwrUXAool1PRE7KROESyAV/PqvFMeEyU19B4Yvsti0PDAcfalGWsUSc9Zsj2qQFAlVRAOwrCAjNbcrXwmLctA+DA7ACZgZS1Rj1A8GJU7jO5q1ZCoGxoIMkwv4ADJUt70iTsdIgldFbETn4PN+1mw5hGFQTw/YOW8o5XNK+l2K2UCDxImpNEm2Zb94qObaMOmYwgP0wNM0oYSU5Sxd2RJiOwZkgwrAxGn5sEN3dJhqTeM/1crWfuNlVCc4C+j7P8e7HJ+Kof9o7aGqOy3m0GcEQ2xobYLxZpkaLdanU1PUAcbw6bhMBX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1845a2ca-1b2a-4609-2305-08dd1b476e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 07:26:16.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IidhUZJL7YPOju4wQG2t1Zxuvq4Qdd6+7fnDaI3Zam0I3GIop6gbOi8VARWn9CBr/h3Y/gDlOhP/BFr3lwmvUjX7Tnmf+PgRLh6TcnYbzBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6546

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
