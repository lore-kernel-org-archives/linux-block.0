Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58257293458
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683426; cv=fail; b=WsEIfWdJJHYv3vTE9AQ2PRHeVsib3gQJJZNOll3fnlBAWKk1P1jQp+V8AzN6ekQUeD3k12EpoY4LDkeeuycQ6yve/UxbwjNjLMV4BSAAX1xSufsZncrDQVk5jtnW7RuU0FSBjDdn7+VTDx9WfY3SmsPsq1Yubsbs0q5+jEc7qoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683426; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ElLelIn4ghipQAOVcJrK/HG5dgB9iQDMAQIO85yCGnf4v5XPN6zxCUmUI5neQeK0ORTzE+eyGb2NoUIHiuwgLHwxFYRR6du2cY5ETXod3KTYL/SRtyK/6SOXxLCTkxa7bPYm8dM0f2ehkuw14kdeCASt65PwEQuyyYJIwt/W5So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/w1Cm4N; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/w1Cm4N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrQrWvZN2zva/pyttUBbxc2kPtp3xqdbRpUQ96+PbljJiC02CQvbs8j1KgCsIqopkolQYVXGERCz6B6/rp8gcBI0XvPYRExkJNcjDskWVQNuC9gMR2bMUO4W8bNik2lYtmQ9vTJSa4+vMz8sg+LqgsBaV7Rj6coY+vSYSyLF/fmviCvNWW22PrDplbS8l3I5DVmpR8uW1nKGcV0skkYTb9+NZYvah25NhRLGWGp552X4KVX2bmnpWaW341t04TI7eCYj5edQnuM4xjc5wZsum8PCIUlkmifBcn9EXwDHcPM/k08PZePHOlswegTxZRwiHQb+R0jjoFaowxWUpl3syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=wKljSwfAHea6JCbCMozm5ebg5IAlB7q3h3PhfpRA3lX2qWavXeO1IKzv0GyrPzZwVbCip/rPTb9ih6zxTDm4CzRx0NJQB4fPxE+SwJ/G2A90MQZ/jZ/hQFpwKNUxBAnwXw6sSrIKtEdnzq3IFoiY5R3yumyXaZxqatFZDS2t4zuhpq5D1G1h5ZngqJDgiV02ALo9R+na7FpkL5UMdzfFHJ8O9mr8rH/PZElmPZgBKB7DtJRnjhtVgFgaIyumGhsV/OsijY+5G+ND+zPxlid4D/ch6HPwMvur0R415M/Bo4QZ+U8o/E9BTSwJdTnQ64avlr3EvkAY50EwNmWyhLDARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=J/w1Cm4NptM+RiQMZZkQ7av+0tnshM6r55xa5/PerAUzdMMhuebPXxsWRw/ef6zA5mRnFxb9Ibl+CDghlMDMfyoBqajrpRo2mBhl5duxNBZ4la+eWVEPZfhK7uCqmmFJ/vLH7AChohWyxpbwv2RY0Qz51Wnev4jnwIiwZWQMNCkBXea7gKR2hHOWZLNe8sb9BsXeHzGCM5y42KjwLJelVU6I8e6ihsHRlMHFUOfLjmB6b+I+djGQL3EAm6zrjFFxOi7sOr0trekzGUrpcpcmXfGelxsVNvYsOrJKnsE4hQus+uo446+e408yH1H52uaEvC6EfMxZ/jmOb6JU5kbC+w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:17:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:17:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH v7 14/14] block: Enable lock context analysis
Thread-Topic: [PATCH v7 14/14] block: Enable lock context analysis
Thread-Index: AQHc9RXWKxM2RJCSRUOnVtq4AyN5XbYwRNcA
Date: Fri, 5 Jun 2026 18:17:02 +0000
Message-ID: <cc12f566-e3f6-4079-ab02-b5670a75cd2d@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <e248ca3aeead238bbc489cf3afdafcbff9e41faf.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <e248ca3aeead238bbc489cf3afdafcbff9e41faf.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: 3831ad15-ab48-4fca-bd5d-08dec32ea42a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 8LpD5fb+ZAX4Uoq2f3Lo0+lNY6WI8eeDTQyxsu+vx7m1WFJT9R2OgbnzKvHhB0eiLP02UV/y2uyKRFwl37ES4vwS0Z2AOcHteaF+E4C+1X57/Iy7Gkdq+2sLIzkcl9tAv4x7Sp5UaU2bySe0QohAMgTp8fnX3lrkJGFiBpdctP3PRdXUGT5B4GdUbJ1FwEDz2+5fGi5hPnFANydTiuTMIojeRkjPQ9dXyqBtVqQeDPWw2DAIqb4gkgATUOoqW3SzSCW+k1pK+HK1ujq+dIxkOAzeJhfDJb0AKsUngZrx7TtlsUT9aXtEx2ZwmIpSH3x1K3Y9ZizrKBE55i3fEqfkbr4gPnU907/mvmAB/CFKip5xutyz+mh7cmL6ZXa+Blbnc9PsnLljV5U0MVj/kpyjeyRjKXGs72o63bh2CgYrUntuUC1rkY9NOd1ZoWDE6rIBXBXfPEi/xFCzj46gdyvvn4JjJia8sJMC6nezOphUMiBSwaA0FbFaHZicSpOGlQf+dvRza3VGzHFU7WewqHQMLRtS2C32qH5a4qZZdit/LyMYkiTnVDGdRcrWKSsdk1ATw8RiN1ih9cP63oYtY2DEzLxKRzd/+5fldTNCZ7WaPcigKBqjxXTfNKkPOGNhH4gZg88K6cYvX/4Si2DSVTn6oIdeWs7oI8pk5JheGwJXMh5vQ4xrM+Zu2Y14GLSm5mXMmHk61e+77Hcv2RF3tIZNnLalCU6JwAKaIuraHxfTrnwOnKosXNKXy+5q6MGdJuOt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFVPNlhIL2VEQmFNd2hlOCtZRzdDNFNwMVVUYStrRFdWVHB2MVo3Q0RqVDVJ?=
 =?utf-8?B?Q1FzbTFuTkVibmI2T0VBZzcyNDJMdmtIRFd0a1BCRm9pTzcwTngzNnAxUHNH?=
 =?utf-8?B?d2xZcnhDUnZqQzIyN0Z2WjNISURrMzhPc0RpWnlMUHJoU084Q0RGRWoycnRS?=
 =?utf-8?B?WUNzVXlDdzJ0cWJBc2QrdnRpTmtEbVU0UkFybmNEbnp3L2J1WkRlMzh2UzUy?=
 =?utf-8?B?ZmdCemdzOHdmOThFTG9tQTFIQkdLL0ZRaFltMWgwRnBRS083Wnh0SW1HZlVP?=
 =?utf-8?B?NytJU2xjVGs2dXlyR2lWcHgzWXk5Tzc3VWZ6UkgvQWcwMFZtck1wMU8vaWVp?=
 =?utf-8?B?L3ZGRzY3TDdjQ3JvaFRRaWVac0UzeWNpV3FjVUk2UUFaalF5UDBvTDFrTG1z?=
 =?utf-8?B?VXROa0k2MWU5R2taYWM2NWs4bXdQaUxWREl2ZkdXcEgzVXJZaTZ5YjBoYmww?=
 =?utf-8?B?YTlBNC9DYTdpd29xZEpiVlhLTkk5b3ZBWUpiTmlmZXZweTRRaGhGbDI5K2FX?=
 =?utf-8?B?UUFwTUVWU0VPSldublFGRlgxSXdwN0JDNncrY1prZ2pLdUVxZWkyM0dRbjly?=
 =?utf-8?B?c3VpeFRmRGdKLzNSTGkvTG1DU1Mrck1KSjAvMEZNczJuQ3U4bHhUT3cvdUpi?=
 =?utf-8?B?Ni9CdEppQ3cyakFORmcrMmFMbmJHSVZ1R2VxZklEbURJVEZGVkd2bnIzTVhS?=
 =?utf-8?B?UDVIOVM0QnJvOGJESURkTjdaTUJ1T0lGUUw3M0FYYkMrTmNvTEovQUtOYXhM?=
 =?utf-8?B?Ry9mOGNxNkZZcmNjckRNRTYwdzQyakt6dWtmYUVoemczdVZGK0JRbkl6YWJZ?=
 =?utf-8?B?dHlpZU9MZWNWMG1QUUt6ZUNQRGluaWREZWJGVFM1Zlp2NE1WcTJzMFkyYnZa?=
 =?utf-8?B?eDFpUWx1NWJyZ04zWjlFcTlKbzFNdXpOQWNaN1crdEhIdzZQam41RFpCbmJ6?=
 =?utf-8?B?elVHSVpvTHRobVdSL2FIcXNkK24vZU00L0xnTmNhcUxIYW82VlZQVzBuYVYx?=
 =?utf-8?B?MVlBQUhNOUNiUmlSbVJFWE0vNVQ5aS85ckFBTVhrWnY2Tzc2NzZPc3V0Tlgr?=
 =?utf-8?B?aXZ0R2gzcC9TaWxjbEs2MGlWbU41WW5WZ0NEUUNhYU9UNGpFK2ZldjhTUTFr?=
 =?utf-8?B?VzFBcmRtTzdzU2J1V3VTTTBsUVpmSloyQXJHY2JYYm1ucFlOTWRCZ0c0UmhI?=
 =?utf-8?B?RHlablNRZ2szVzZjeFpPaW9TTm5HUWI4QWdwSENxQkZlaFhvVlY3UjVZTHFm?=
 =?utf-8?B?MVFrdDNGVHg3V2o3aVMvRmpIQ1l4TzErZkdPL1Qvc0FtQ2E3cFZTWk1yZ2xE?=
 =?utf-8?B?QTN0dmRZdGIya0taeWd6THRXR2RiNFVQZFIyczhrUE44QmNXTnZFMGRLQm1n?=
 =?utf-8?B?RXQwYjVaMG5ldysxUkRFc0k1ZDBTWFNMeFdyS0NHbjlXTGZ1RjFsblorbDRM?=
 =?utf-8?B?UEphTGlOcU82ZURVR09qMTQzNlAvMWxxY3ZwOHJsbGt5QTRkSnJSWVlNSmM0?=
 =?utf-8?B?S2pQWDZxZFYvRmJ3L3liWkFWK1dMOVJxaTBUU0xtdlpvOHJjRGtaZDdDSXBk?=
 =?utf-8?B?dHo3aVo4dEx5cU1yM0ZHaXd4cnZPL2tuQk15cm5EaDNjTjhiMDB1aytuQnVI?=
 =?utf-8?B?MW45MzdqbjdWNitneDA1T1BvNEZ3NFEwc0tDWlR2U2kzZkF2TW9vZ01JdHNn?=
 =?utf-8?B?Z0o0RGNDcWZralJOR21tM3crQW1qelh5RVBuZmtjL212NW5SMG81dXNhYm12?=
 =?utf-8?B?Y3llMGVUQmtKSmkrK1FDRGU0YVdpUzBMb0c2cHBZa0pacENnRE9qZmUzYXA3?=
 =?utf-8?B?ZWpUeVpocDZsL2JFVm9KQklvUDFDYld4d1V3ak5jSXZhZGFZUXNmbmpVQWFt?=
 =?utf-8?B?ODJlMmpPcTVPT1NRM1BXT2FJN3V6MmZhVC8vWFlaZ1RFbEJ1bzAxSmVGK3hK?=
 =?utf-8?B?MWlxM3dNQ1pENzk4STJlbWpFdm8yb2ZlMFhUdHlzcGx4VFNhQTZMNUljdWlQ?=
 =?utf-8?B?dWM4ZkJ0U3oxQWF5Z0JaWEdTTisvOHlZa2tFaWtPdkwzSHBFclhNMXNrS0x1?=
 =?utf-8?B?OEVXMVZaZCtjRlFWSEgxaXhZa2dQY0w1K2RBOTZiRFgvVk9peG9hWWRxT3Yz?=
 =?utf-8?B?dDBYUVFjOHBhWmIwY2FmMC9Fek1kTXNNM2JvbTRFNlZYK0x2eDl5K21kZnJx?=
 =?utf-8?B?MlIwbWZjaDNsTzF4aVNDMmJnUURVWVBhRjdLelN3UDlRNkFNeTVQNVVHb0tn?=
 =?utf-8?B?WkVBV0gyMWFnVWF0V0dBQVlOMEF1S0d4bTVIK3pIanUwS2JJdkpna2UzdmZs?=
 =?utf-8?B?R3FFYXdGR0xXZmE3eElNWnd5bHR3SC9pSTBTMlZrb0p4SW5rUzRsdzNrZHVL?=
 =?utf-8?Q?74RgnZCj0KEfyD8GUt+xqDXfLq+ull9UTf7iY5NAfRAmb?=
x-ms-exchange-antispam-messagedata-1: PcGocisl2gBc1w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <185EAF48D83B1F41ABD893B02037A686@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3831ad15-ab48-4fca-bd5d-08dec32ea42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:17:02.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9x82dLGzZGCGM5cS8WD3sayGVhHFovn25jMCVIxTC++J5w4w8KEaD3TmkNQ62YVQdm53ETH5Aq3ZLdbPiFF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
