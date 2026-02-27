Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C536896C
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184208; cv=fail; b=M9M9w3q8UywzOsbtSWivu2ugsuJk/+LhOzAE1LVRawlEyYRIiiJXIZ5AFdCWX6Tiwq0U+hr6Cvoh0MZHjO9AjMXiCcO/wcrmDlpc0Ebl8vui/0N7vLhJyLUmo8F6ZFpiCoY51sK4yjuzM+llw9EkqtE08AGNL998+KjQSKx/ZVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184208; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uASZJkcdMqnPJhUPl+oBYnUXKFTVYjCzEV9F6S9JZx2j3WXhXEOpvrpGUm4aTdeh98e5GWDcTQANSq/F3veH7eCBP612tvrOljQuVewxLlllCQanGTCCm6NuorTp+iHB9+RkcoLEpXdn7kKd95Duuewdk0/lXjw2H59/M3jDtDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a8LxIRth; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SNT7vsDj; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a8LxIRth";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SNT7vsDj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772184206; x=1803720206;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=a8LxIRth7WvO+ETSqTg7Y3Rq01aoB0W7B4jkC81WIyaQyAC56EzTktru
   y0oH0gdsA5PEDNrhanxRQkAtJPHuno3y4JLDBY4+JE5JsY7y2Xx/aQrxA
   WJLRkXa+HB5clltUpVO5H2Qxmd8I+ZcS4E8kS9TcC0HoSUjZqT9aQ3+Lz
   CUjY8G15/PRZhG4HDbBuCuWm2sQrpRDC2qdP0gtOKaC6NTgGecCELCN9T
   AWB2YLY6XAOYjNwbDNNN5MH8cq6Rc7waAtZI42xDAvu7Yv6qSoeiEk39o
   wohcauYcjHmqihUZIIoYfA0XVdzzp2CaGAWxqTi420RtpuXspzEotabum
   g==;
X-CSE-ConnectionGUID: Pl0yoGFvQRKyHtVJZXf5yA==
X-CSE-MsgGUID: Vd3SglQDQduioB9Rsc9JPw==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="142131724"
Received: from mail-eastusazon11012025.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 17:23:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHcE/GomqjjGOVdCN8CF2E2OzEAepSQogdFwZRbbTmF0ntG/sKFKOHVdx/jiH3gRF6rlBNNqh59AdII84aENHJIYeWUKpU4JyOISFbpCJKCujMI297PWCBRYJYFhGvM1PBvC/yx0VsG9a08NnMPxTKkeigDgBUJyTQ7UdsqqFMUzpEF5YfNZeiRD+8BmwwlJP6Aa7Q9s3e5O97iVXSvQgywcqw+Bf6nMR2nYp+4dCeEcVzGIVOsU0DJ5QUt53jGZ0lCndpvHExGxl9hqIA+Rpd78bd7200qqMHBVbIag+5wrlYJktdiQtG5YapOiVwPaQ2bVsmJSVPfE4eZv5NxvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=qfEUmhvPy5H/NlVovp3HTh078lejVTDIf98LTjPFknTtXbg59M2rSEzcjvI+uMEeJkCsxQDJFnkcmTka/t/x3V1JGkmLRx3HckwUJ5RJZz2LaJulYwExy/hiIuRmtdVxfiNpHSBGxtiV6/qmeEJqU2lUaecptL8JpJb/YhdBRN8lPwGEKgNIv4vvmLl5OZyUaxwZqBcMl7nMQk6J33TrvpQeNXUZVVwX+jsP6EBPz/lEhRoXssHfpYT7pG2Ch8bzaf2DWB953Cav/NbzxeGQVq6GU9VwGbdmD9ppYlqG2W6UB/CyGjdw+iX26DnOTtyC0xWHX7qsttQw9URuwsbpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=SNT7vsDj0zIR8UY1Bte23wAtKZheueNm0uuILPCL949ze6BZrpRx8psDeMy4IhY6g9IcaE1rSE5Ka6LgStdNcHpiGUCFqCAyMxDPzE/A9Q8EhNZL2SjQhP/B4X6tfkkN0a9Du/XraSIpOQG0GMhYtAKFtklmU7KXtY0LtE0IokM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA1PR04MB9827.namprd04.prod.outlook.com (2603:10b6:806:4a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 09:23:23 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:23:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] block: fix zone write plugs refcount handling in
 disk_zone_wplug_schedule_bio_work()
Thread-Topic: [PATCH v3 2/8] block: fix zone write plugs refcount handling in
 disk_zone_wplug_schedule_bio_work()
Thread-Index: AQHcp4w4B3006//L+UCWQ7dUWJ62CbWWRlYA
Date: Fri, 27 Feb 2026 09:23:22 +0000
Message-ID: <e1871f89-08bd-4407-a19a-0d9fc82dce9c@wdc.com>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-3-dlemoal@kernel.org>
In-Reply-To: <20260227014951.2327711-3-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA1PR04MB9827:EE_
x-ms-office365-filtering-correlation-id: 33c46775-69e7-461f-5259-08de75e1daa0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 6VjoOGs0Qa04hp3HhSnV2PjO+I+oTDruccuizjwtu5a2inII4mdLbJikZGuDYQOVf/9bt3Szmtf6M7E7/VKif36Ctcsnfjezd1UVTf0XlEU4gS+D0NkRVl7gmyfhryTnDr2ytuASfFhkxRNem+VXnmuvLHKkb9nZDzOdIZFnd2V0oPDtEOB84iQhO79CToj0L88bqSLJabGEcL0z522FlBykty3B4PjU/7YDyOI3pCYAUIDnWjjvi5iPWsjcA4O6hOkH+niCi0BolND0Z9SdOSTQRZUPoTf0Hbce1f5usH2J0cucnyGyGJlYiZjBdYQQiCzMepdv45OiJdjdxBBYmAirkDN9uw5816ESDCbo1Mf/dXwFIfMveTWspXaq+YGqZJRmqyVDv+WhEIKK0on47wRwIFzgHN6Oj40fmmb8KmO+Aq5YcNzjyK6haQ5ccfpj42OHQRhUtqvmNnwLUe/wuZMkM1gStsySrpF4Ca3VNZibfl+KWhIhq8q91smSC7kH+MXjdAIje2gYXoGzDr2Mok+XqXOFQPdeOXTC9Yqc+t0XEhq9mxCgYFabxYATfI+GwH4Z18oRcuUhWuL6zUr7qYvmxf81GJFoJMhejqAEaJJtnc242/46osmDVLPPreMUjTKtFKaX/6CjwdoAseMWQj1XFLzDWwnsFJSn9BAgFBwKBO6KboiaYMNHNrxXVwhfBEVh+XU6KcpJTj7PIQT/ZQYuqgk74jFnWoD2V5GvCryFAdVMdZXdkDYB69/8ay8mLbZJEjAY78Ejx02DgpQ5yNvh+38RJtnkM/sOVpuSffM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUNhK3ByZ1pleW5OSEFTTzhXZ1ZDeGFUN08wOFpXL253NllnYzhQdXRoVXh2?=
 =?utf-8?B?elRCdUhOdms4MDlHWlpoUk1DRURHVVlUemRhTjRQWGJHbXBqcFBXUDdVWm85?=
 =?utf-8?B?QXdYZXZkSkZOSDBIT0RlV3ZpejZ5UWtsa3RwWmR4eEU2MDFnN2kyZ1FTcUt4?=
 =?utf-8?B?c0tQUGlDUWI0YlR5L0VQQnEycEN0ZEUyMm9jaFp2ekVvNmNHZ29sVWQ3NjN5?=
 =?utf-8?B?ZDQ0ZDB5QitMWlduNDVhWjUva3o5SzByOW5lak9Ra0lnZ2FkL1prOU1NOXFm?=
 =?utf-8?B?VFIzUHJkN05RWVcwY25TZ3hKYlc2QmJ6N0NlNGdlaVJ0Q2EwTzNFRE5ZT1pr?=
 =?utf-8?B?UTg0TEFhY0M5WlBMMThXcDlFd2RYdHBUSlVnTFQwZGRyN240UjFQRXJxaHRn?=
 =?utf-8?B?Y2tpUGJVTWE4V2dHL1AzZ29aOW95Q1REMDh5SURzZlQ5Wm1uS0dPT3ZOLy9h?=
 =?utf-8?B?akpHTlZKZnlmQzYzRzBLdm1oSHdJbFVuUkdmSHc0RDQ2UExiQnpNNVFDS2t2?=
 =?utf-8?B?SHNMWnN6SkQ3QmM2V2NqOEtNdTlBdDF4RHVyM0xPbEZKaU1uNWtqaUV2NGNT?=
 =?utf-8?B?ZzdSMFJxdVlIUlM0RU9pWUV2ZytJMmN4eklGNkwrdzc2MFFtcjNFcVBiellu?=
 =?utf-8?B?YkpENWJjMmxwVFJFMzdoMWFtWlh3ckVIVldNN3QreS9VdjcrYldFR0lzWWhY?=
 =?utf-8?B?c0FKa0FTRVExQkM0YmJzMktqVnVNRVJYZVpFWHE1R1RwdExycHIvendJNkh2?=
 =?utf-8?B?eVVJTmZ5UU51UFBvNXBIL3RTdGRiMU1UYnpoK2RQYTFPWFNHSERlaXJ3Q0FW?=
 =?utf-8?B?bmRjTUlSaGZOa0lZdnduM0dSNVVXMjZ3aXVwT2lYOGpMVERkcWx0UkRyUkNz?=
 =?utf-8?B?SDhXalMxTkFyaGZhckE5VUN6TG5GODJVeVUrN1NNVnN2TVVNd1h1ZEtTVTlv?=
 =?utf-8?B?U2hIa2tEMHNocU9vVmRYZEVWTEM4NzJHZGx0NUFmREFVM0VPWUh2enZPaDhl?=
 =?utf-8?B?cDhrbE5kWisyQmtMWS92QjdZcE9lMzIvVHpQc1FUQ1RCM3B1YjlVNlBxYTFl?=
 =?utf-8?B?MUQ0alpZNnlnMFRhRXNycldkU2xTTHlnM2dhMk9POHYrOFBjUU8rSXhxYTVk?=
 =?utf-8?B?ckVhcGNMcTZmY3hNMzcwSkl3RytROEdpZzZWdWtRVS9wUmVBZDNkWmxxTzA0?=
 =?utf-8?B?cEpjMXRBOE5DVXhGR3pVYU8reE92SzBHdS9SVXdVdkNBSUlVUCtRV2tjQnFr?=
 =?utf-8?B?MVFaQjF0aEhqTFlFQlBRcUd2OFd5V0dRNVJSVE1FazlLVndlei81Y1ZBZHRw?=
 =?utf-8?B?eFN6czZBalZBZWpsOGdHN2FLdDQvUlE4KzI1ZGhVSFl3SXlKRi8ySU9pR1Np?=
 =?utf-8?B?ZVRTalZnN3NsNjl2RThJYkovK1hCNFJQT2ZqTW9KWHg4OTFlVWZmc2NYMUx6?=
 =?utf-8?B?WnpJaC85ak1OMVBudU9yMmY5TlVRS0FpS2xlMnBGRXBBQkNRZHFDM1p0cjdS?=
 =?utf-8?B?SEgvTjNsdFl5dDBXczF4MFpkeWtQUzYwQUgwV0FrU1daUlZKU3NXNTRMMklQ?=
 =?utf-8?B?dTFyazdJbEJjelNwenVPd1djOURLMFlXK2V6ZzBBZG42UFBmZXpBOGRwek5n?=
 =?utf-8?B?Q2E5NytmN1FVQjVlZFArdllzMG5HVC83Nm5aa0NzbnBJVklTNzYvMVcxc2tt?=
 =?utf-8?B?OUF0OUdaQ2FoOHNnbFROOStrdGFhRVpBbTNBR0I0L0VHKzZNVm5iYjRlRVBN?=
 =?utf-8?B?SGxXY1VHekhNczZhNHg0WGo3WUgvM0tjbXI3QllOaHRnbjN2Und4VUgwSmNs?=
 =?utf-8?B?Z01YUU8xMmIxS05kODVLWUNIRENLazU2eW1KZzNaWjRNM3ZzV1hsQ1pCa2VB?=
 =?utf-8?B?dEJwVk83MjUzL2NpVmJsTnVxSkdsWnlRODZMbnB6azZOMk45R3h3R241QVAw?=
 =?utf-8?B?aWV6QlBLS0prK3hVSExUOU9aN05uWnYvZzJRYTBDUStnakszaFBtY0xqZ3lO?=
 =?utf-8?B?RVlhb3BQYjNYRUhsWS9uOUcvYjdkSHVTZUc0bklvczRJYXRLYy9xeklES2x1?=
 =?utf-8?B?cTRSbWFuc3M0bVZkeVNIeDJuWm5PQ1dRc3drYVRqYlF5MlVVTG1qMTg3SzBx?=
 =?utf-8?B?a1BmTGNZaXBpUWU2UlZpNFNNTnVNaXBSRXJ4Y2V4STlqb0g3c29iSDVyU3Vj?=
 =?utf-8?B?TkV0TW4rTFlsOWg5cnBtNzUwVk1KZ0xiWDRxNEVwT0dnUWZkYy9xa0k4d0hO?=
 =?utf-8?B?N25vMjhYdm55bllJRXhwUVhRRy9GVktTOENVclJlYnVESVJlcU9UZmY5T0Z6?=
 =?utf-8?B?cHlMUmpvcVBURTlvVjVyaGxvY0NYdjlldWk2UFMwaWNlTTduOWNxaGVvNi9u?=
 =?utf-8?Q?yc2Vywf7V9zLEdLZ3ji+fB5+v+rSbAbIrWYWypHdeY4vD?=
x-ms-exchange-antispam-messagedata-1: W9ytBQj7+O3bl94H3X10Siq/aRavtPhfQrI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F63F8E852D4314EBB4F657FD3480F7F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XBCulFXzuwgRAUfaTe//zoi8UeBOdXo4UwfJopfu6L/d1gbRahhO2949iu3wleQCyxWcbwFjlz2bxH1gk+a8Rg+5UUBhHWOwiDRkY6lCg+oqe94Tz9jydhHHT4MaK1fEFGft7/FsokQSldQFc+gA8UOg+jbNtXycjjUZvv/NYSswgYSF+itxOs+I5920oe4eSGZ4hTt4qKgtm4x6o/OESngpUAXkDHRVNQOkEkdAktukXPXUfmx7o0783e9TiWQMcSEZkMmWxGw1u8hsO49gr/iQADq7huOzdKf3c0/6MIveDnPn2W3m3JNEQ9xdlambLQ1X1acTGd7Uvgq/3r3q9d8MQG4oSX5BCZ28b3iq8sw4I3RAxyvUAGkWbQcirIrFBY+psEFhHNigdD07jm5N3SBJSUN3EhneJ1VNjV/dQuYOKmoblF2AXg44Xl0RT8qYAZjavadU2LElHYviB74FNssTpL3SB6EzKTKr9Mi9m73uS98O+I9WTMd5KV57iAy9L0kNDd4O5GXq1DDqlwbErJeMsCNUb6+P64Yi4KnRT4Cem396a6irsfFRrFlZEF5kyrFWl3YwLMUetbq4q8bwCTjl8BOr4yp0Z4Z5AABv9cyYugZK+IbLrIXGoZJyVuuX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c46775-69e7-461f-5259-08de75e1daa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:23:22.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w36G7pSeJ36h49tt/3PNBJPtsVuQ3OkJqo62pdxSLgmNSlJXO/MRyip3mF8YzT2AJjjdgQ9N3y9TZFtilrwIlwTYTN4d4lDta7BQmJu9AIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB9827

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
