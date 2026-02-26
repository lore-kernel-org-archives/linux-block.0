Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C42765ED
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084349; cv=fail; b=L9bVFunsznxqVkAXmztfcq1j695Ukz1DoxTfqA614+mpGETTuQKiEcPaEJc4LyvaL4poBtNVoiTeGfvXbUzvY1RZoo6ozkzLHxaKXnJFO1jvN3P74jmNBToubivAzMoHjEa3uu04WDn5VVf5+jwsVdsy/4XWGhU6lE6dFHO695Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084349; c=relaxed/simple;
	bh=ZCH6nXOAdN8clhiBnlPYhCR0pCjy9KY9K+NV5yjUSYQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pBZ0wQDLdjcvGG3V4iMjzVLzlXKrPJq8gTK28BqWThjqp9+Iu3ES2BBbWCiFmwgUpbUnnvxTeY3yAnXLO9+L+gndDQs3ZL07tN7miHYvI2S0A8zranfnrNBwuE+UgqEvpeZaTkP0DAfrjEjCBxjiJqyIphWkXN76J7108UDIigI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pT8Zcm3O; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pT8Zcm3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clx9dc0L30xtPyDzJ1qFlpid1soapAtTVUw+UrX6aeSt7RgKU1f2SNQemqRCzvE/MUuAOBHmZZ+bT8BjyaJ1yLqe2Wofw7ejwsdhul1+34/BNpUb0keVXerZBm2u1BtASDRli8mDUsrQIwtb6ePM8pAyJkkooLfobeGDMFcfCezRlGOlVzrzy9qR3lQ+mp5jSVilsmAezkLedNcVniCo4C/hGCoLdygipldZ4qkj9lPNdmKxTudA1koNXeGS4OT3+/GVEyFpmyMXAggR/tv6497ED164gEKPAjYADeK2akfwA9xHYUamT8qHUmOWKdD0/nB9iNbYUy8ouV4Bh6kUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCH6nXOAdN8clhiBnlPYhCR0pCjy9KY9K+NV5yjUSYQ=;
 b=le0F31GuDlKchIanrrzIz1XQVKnL7SflREg2wtMnHXBxcJUEmHVsy9U8WeQuFuF8ptiIptuKKpGH8IC/wKXfV1GLmGBwTj4EsDvOljj/vZY8Z+utF+pHSERs/loB+4fBjfSOoyNMR4luGkmgatEHsAjUd8/PcGHM0uvBDx4V01A2xKnr3xsMriMzOp3CR9iMRnXq3ZMU/3RMe0fEIYGjMoOpBJI0cjlrytUjMndUQctYiM2Is4gfFBG9dyBlo72C4D6zzTir3bTQgOwsXF4nvh5YCqiTBIYAQT084Fmpqq4BE+BELJgFcMYQRLXaItuKYFX+/VfQc5Lhc+3TEhmXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCH6nXOAdN8clhiBnlPYhCR0pCjy9KY9K+NV5yjUSYQ=;
 b=pT8Zcm3OusZUsLoqRiGBstlKRsW0N9MjULQ/IZaE1zh1C1e8UrpMX3oblXpWMHUsbIpxWBCDW1I938HDcppg0WjcPtHrTPxYmxKV/yyOIn7WXaj7c7dV9/GoNxJsW/K5XnV+OCj4mMoDdZBORf50U5X7VYHk7YIpfzMZzo13TOdxQoaIxwvwSCjvSqFjilEM62qrptyCGwW35lWrbZ7mBhRKVb63K1oNFUf7PswK2QXgIeGuAz63r8hWlgSFpz1ZuiUwHs/0qOAqpz+eCzvq3rC7VpM8/sa7I2aGHPiQvVTycbaKNo0QJWiCayambTRDEdAnloORSnxEPIc4RUUJzA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Thu, 26 Feb
 2026 05:39:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 05:39:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 2/3] check: increment bash requirement version
 from 4.2 to 4.3
Thread-Topic: [PATCH blktests 2/3] check: increment bash requirement version
 from 4.2 to 4.3
Thread-Index: AQHcpJfb+zNo98yldUKbJdmHAtYayLWUez8A
Date: Thu, 26 Feb 2026 05:39:04 +0000
Message-ID: <81944e3e-1dea-4df3-b944-097b2ac2df9d@nvidia.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
 <20260223074110.144758-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260223074110.144758-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8488:EE_
x-ms-office365-filtering-correlation-id: 4a7c4cfd-b2ff-42b8-2391-08de74f95a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 l52sAxBhstP9WnoqbIL5nXVhKajrne4nKLJybxcisId0KGRiAuy4pw6EFV7gFoiFPwQgAnEuM3lLXEBDLTEe/ZoGdQVKkOZN2mdqW1yTJSYj0K0LyhjhXmEkojQ5dk9fu0BVL5O/Rl9J2SlBY/RKj7bpru4eIX/vL6eJmRuzFjyCV38z/N+DexaW+z4ps4GqA3/sk4sFVq/w5WOZGWhCQ0hT4MTDSg3juRBgFeeAyv5+Lme20NRCMHYlZyGv+5D0r6i7v6DULd6aOgIqZqTxYEnHa6CDLkwQV5FiuyuAsq784wQx/q+Bq/2aLmscy2xfDdMktMEJLiZc5WtbEs4e7xmbYmaYS2d0sIoffWUBTRShHLXaO8lXNpj02jmTa/JgPr4H/fwa5kGd+l1CsEGEgn9pARdRFOJPx5Buegro2xmqAeXY2wk+WtUFmctzZEAm/jzemC3M14WrQBXKjaVNLvn+S71tMwM+/7N6hxq58GqeIOCO4dQi2ol2suUaCsd9WRONHnEAxvkwuYBltuipunypsCFWTjPBwqOrkX9pVi9RAqPb8QPflD4Go0lHfEU8J+GgeVp6BpqStOSN74Um3WIubEIWwhnYovkCiRpIeJnyO/GSO7tJIXs5Ldm7QHYv0iQJ3xmrSagdhAxGCRoKFvwrIPWK8uUczJivkGR/d3IvYBjQ54Jglz0Wa+42D2A4eg61ifrSKbZIcCcYSJ5ZbY39ccRen9kS/LgXmutAXrKcX+ccCk0QxeA0u9Pp9y1yikDsTk43cXwUF1vDfBxnISVXu8amnHvZlcpjD2w255o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEwyekgxaGxLUVZaQTdjVUljTFNVaDA0Y2FxVTJiSUZaMVVpT3lIdzI2eU9D?=
 =?utf-8?B?S2F4UUlXUlpUV3I1TTlpN0lVYUs4MkdxSkhKeVM1eHo5cWM4ZUVPbWlYbEdv?=
 =?utf-8?B?YUtVaEc0bTJTWDN2eWcvN2FnSVBDSnNjbUkwOVlleTNFWFFTTkNmNFdPazRM?=
 =?utf-8?B?Rk9qcW50TWhIOE8rdkl5aXZlQ2VWZTlKN050RWIwdDRMTXQ0QUV5UjhZTXZl?=
 =?utf-8?B?VnViRDBRazhQZmI2d09vQU4xNXM0TnQveDFwMVlEVHBZcjJPZ3V4MW1BWUlH?=
 =?utf-8?B?RENIY1dPaTFIMEo2YWx6Y1FSaWF4aVFzelNhY3V1aG1jSEorVitIVkpsckNn?=
 =?utf-8?B?VDVyUTdWUU9jNExaZXorS2hhNXdaQ2dNbm1NVXNqZE8zdzJjbWdEYkxLMEpW?=
 =?utf-8?B?Y0J2K3BYSUxDc3lNQWtWamJOMmhyZ0xZL3BLdXJuOTJaVkp1NGF4OW9XdzUv?=
 =?utf-8?B?Sk0xWnRQaFR6b0RocFp0THROeVV6UWFmakpTdkFwNWc3YXBtTDZaNHVvMVlT?=
 =?utf-8?B?c0FadC9EZFgwS3RVZGdLVVZiNTZyMnU3Z0NBT0FjY0Y3Tk12QUs1Ukpsc0xE?=
 =?utf-8?B?V0hOeUVqT3RtUG9MS1V5MzNKcXhRU2xMdTNTUkZkN3lyK0tHUlFjWThncnRl?=
 =?utf-8?B?ZVVMZy9xZ2t5SWhmZklLdE5pbFB4MHhqUXFkblQ2Z1pXWXptSi9OUkMveTRF?=
 =?utf-8?B?NmwzN1dzby9KN3gwZ0dVSCs0ZUY5cVQ3TlFuT1djMXVsSUtib3RSYjdhZWN1?=
 =?utf-8?B?ME5hZVdxRFpnM3R5dm5sTWppY1U1cHQ4UUFlUDU5M05wbjdZTXA0eVE0Y2xW?=
 =?utf-8?B?ZE5mQ0F1VDROMXh0RXF1Z01MYzE3bEhnaVFOaWZNeHJ5czVoSEFaYkdON1Nr?=
 =?utf-8?B?WFdaMm5laUVIRlk5Z1YyUGNORm9rQW9hVU92TXlPeVVzZUlYRjByTVgwbklF?=
 =?utf-8?B?VmNFSFdIY2g5RjU3cGE3QWc4eDIzSVo0dkdTTnpKV0tvMjlvNU01ZUhBSVgy?=
 =?utf-8?B?SUFqbjJFREVONGxvYndaYzdvTHVpdEIxYzJBdmhySWxDYklUTU40eU1rZVFY?=
 =?utf-8?B?aTZzbU8yUU9aQkJicVBWakdSU05tNEwzUmFMN3RlV093NUs5bk04QkN2UHps?=
 =?utf-8?B?UFRSOVc3UnNxclJyaUZ2WXQ5c3I3QXdHK1VuQXFSTTBHR0ozdWlIb2N5V0E0?=
 =?utf-8?B?djlFa2E1cWozYThuRG4vNTI5c2hnQ1hYS0ZCMStaTUVnSWxJUGw0bDRsOE5D?=
 =?utf-8?B?Q2lFeThEMTZkY3V5TzE2R2NUNTRaY0dWV0NRSFNidWhlOFA5Ylg3N3l1M2s4?=
 =?utf-8?B?bk54UjFSRTZDaXdUYlJuVjNDNnFCS1JlbXQ5S2xEOUprZElKb0lhbkxzWWNi?=
 =?utf-8?B?alh2bm5tTWtPcExNYnFKMVBBZnhzWGhrYU43emZKVXB6TEJKd3Fab3ErZVk5?=
 =?utf-8?B?ejRLSlVCQ3lkMDNDWUxqUHI1dVY0ZFlUVHdwMkdSdVlXSmsvWWlFemU0ZTlz?=
 =?utf-8?B?ZW1JbDFyYkNzRGlXTHQ0a01PUm04LzVaWXkrSWVIblJJMmplUjNGS1FnYWpZ?=
 =?utf-8?B?QjdKQTVvaG5na1BLbnlXTUJYb251cDNKeE0vT0JVSThjOE5iYVpWM1p3U29l?=
 =?utf-8?B?azNUemt6U1hiWVB3R3A3aGdpNzI2bHF4TTlIWE42STgzMmpmYzJlTE96VDNL?=
 =?utf-8?B?a3oyZkw5YjBHWGVxaW9nTkNkM1dvUngxbDhPY1VmbkdwY3o4Q0pCWEF3KzNU?=
 =?utf-8?B?aHNGb2JxNm0zOWVlQjVUK1V5cFZRNmJxN3NlNjFyQ0ZKck5xUEpRNUlqWGdq?=
 =?utf-8?B?dVA2bUptR0N3V0pWRUxkMVJrM3BoYWx1T2gyL2Z5QTcwbjF0NHJBMEtMVUYz?=
 =?utf-8?B?N2hIcHhtU1FKck5xVlBmYXhzNGR3Q3NjUVcrbU1sMHFrSjBqeHJ1bFVEL0pj?=
 =?utf-8?B?NHBNWkMxdkF3cENLTXg0U2gya1cvRDRqWHBKN2EvTkg2elpKYmx6TVppWmEy?=
 =?utf-8?B?NUl1cWR0VkNWbGovbmtpdCsybkc4Y3F3cXlyTGxZU0VYNjhJM3MwYml6NEVT?=
 =?utf-8?B?Y2UzMExuZDRMN3luL1RPalh1Mmc0V294UlI5ZndmTlQyNmo4S1JEbkJNbTFl?=
 =?utf-8?B?U0RzMlFtNy8zcDBUMzFsRFJJWjBmMlQ4enM5SENQTlFZSkZ2MUdibzladlVk?=
 =?utf-8?B?WlhrZnZjVFAyYTErZ0VxYTh1eUhJNGJGc3F2T3VHQWxRb2lXeXk0U0hBb2ky?=
 =?utf-8?B?Y0lXK09Jakg2YkpkcXRxY0dKOXNGalhGL3FOMnJaYlQ0MDJKeFhXK3cxV05F?=
 =?utf-8?B?d0hIKzdXV3JPMkNXUVBYMXpaaE1OUjY1b3A2dzA2MmpkMGhJNUlRMkh5V2NY?=
 =?utf-8?Q?fTn7GzRgTlDVQ3i74s5OgTOqjX+PQo1sW+UzlgEw+EVzF?=
x-ms-exchange-antispam-messagedata-1: 7uQ/ln95qJnbNg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFD735F7D6E8314CB292692C48056264@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7c4cfd-b2ff-42b8-2391-08de74f95a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 05:39:04.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWz+eazdKveh6C/c/Vh/GSj/JX1uUQCmb/1whVvIajJupfgKeUuPHhZYXNiws6vpCwYCDFbJGmb5Ji+mxsFHFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

T24gMi8yMi8yNiAyMzo0MSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSBoZWxw
ZXIgZnVuY3Rpb25zIF9nZXRfbnZtZXRfcG9ydHMoKSBhbmQgX2dldF9udm1ldF9wb3J0X3BhcmFt
cygpIHVzZQ0KPiB0aGUgYmFzaCAnbmFtZXJlZicgZmVhdHVyZSwgaW50cm9kdWNlZCBpbiB0aGUg
YmFzaCB2ZXJzaW9uIDQuMy4NCj4gQ3VycmVudGx5LCBibGt0ZXN0cyBSRUFETUUgYW5kIHRoZSBj
aGVjayBzY3JpcHQgZGVjbGFyZSBiYXNoIHZlcnNpb24NCj4gNC4yIGFzIHRoZSBtaW5pbXVtIGJh
c2ggdmVyc2lvbiwgbGVhZGluZyB0byBhIHZlcnNpb24gbWlzbWF0Y2guDQo+DQo+IEZpeCB0aGlz
IGluY29uc2lzdGVuY3kgYnkgdXBkYXRpbmcgdGhlIG1pbmltdW0gcmVxdWlyZWQgYmFzaCB2ZXJz
aW9uDQo+IHRvIDQuMy4gTm90ZSB0aGF0IGJhc2ggNC4yIHdhcyByZWxlYXNlZCBpbiAyMDExLCB3
aGlsZSBiYXNoIDQuMyB3YXMNCj4gcmVsZWFzZWQgaW4gMjAxNC4gVGhpcyBjaGFuZ2UgaXMgdW5s
aWtlbHkgdG8gYWZmZWN0IGJsa3Rlc3RzIHVzZXJzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGlu
J2ljaGlybyBLYXdhc2FraTxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQoNCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
