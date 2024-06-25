Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC31B806
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295293; cv=fail; b=rlTznmNQzNaGduK3/r4uk1/YxoVFZOL4Vk/l7w2OPN4J3hU4rMZiPt/mYvs2nHAsl09X1TPf2bPWH6WDTSW1DOAzntTF9+aEDQA3iBBSJJEzh3o/eNd7ibMTuANsiQpDkDCDZsuBK+YdStbTYe9ST6ABPWGUSQjU7KirUtm9PU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295293; c=relaxed/simple;
	bh=AfO+avKJaYrrzK//dcg/6WBUhIf82iUy3c1d+ztKuWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nqqve67g9w4XAHBUb5aisobWXyzAIq0+YNfhIZR4tnZXC9pvwD9xeXEPNWUfsvmMhWUHnOq8wzS7ErD6al6p9tVB8f2HQ73YOPOvFym6MsxJQ/gLOdmCZ3ltYoh19z6/jiZ/aWCs1oRYG8RRAAMIV4cjBjoAiHWj7sF03l77QdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZQecEB9; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZQecEB9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur3hdcw4RTyOOg1erJRYciwQeTpkd5d9ujwTF0MwoiwscIBlOurBSMyyhFksWoDM6nEPysuel0SWWKLNaBgYQ2KTkrhx+Auw/6YnbAMqc5iU0XIiuYDYHmd1MG5YEf0H6djLn+XXj2AR1BePpAEx6up69m7es/zW6SjDfoMbE2DUMPOci634PGtlMrDQopzwuj0idkX1LydAKGSdrfb5JXVnSbHlGZ9QhgmSuYcUAPgTL74/gyLnZEbjORyrsl7LVUN8lPDJhENzHeI/m0vwtAZ6enaYX+wYajAWZIPl9y88J3ryX2zhLnu787ILztDveuMG9DWQ6I1gpZohjHaHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfO+avKJaYrrzK//dcg/6WBUhIf82iUy3c1d+ztKuWQ=;
 b=aZxB4ChbMsXr3KY9KeYvCyG1IoWn74wJFdUnAN757oyhErQ38aqqZm3RNg+RE8WJMLeus5GWgeTkTwem4+3XUuLUK4vr05n/tIMENFy+Cd/b35/ot45aNWI3FKleAHT2d2bbV+NNgX1OCX6FcBXNT1SmNE8/qE9lcMDhV5VvCpzsszy9tl7XVLhUR3F/MgMo4gYK1HtYrY/R6HieZyYplC2JYx5gLNdQGkp71rlz8ovDh7QemoWq5hBcVOUA2mliZbhzW5f0/M1a278zpF3RHazQYkwRh9XCZ3j+/eHJHgKeW8ksHkJ8RQM9XKlqzNRS/0ITu3B//PN9u/bIpaCYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfO+avKJaYrrzK//dcg/6WBUhIf82iUy3c1d+ztKuWQ=;
 b=lZQecEB9pLEteQ3BJ4SEk7zUsiWaOLn95WpLn6sSrWt2+POvZTsfUVMQRKpIIR5bVtP/e9c9WOoVhn0s3jtKKifPJAuD2pxeOBzDX+n5Bkzwj2ACfHKJ9E3XyM8B17ctUrJ0BYW1DkTaDZewWTL/w2gGiCc8iRe0Q/vkD+Ywn8k+gYasSdN9Plw1pSp42WDvcV07a6LwPnOm/M1fErQa1BifAFE7n6obPrLIaTp5gDF+O8f1wyRxL4fjMnMKEFyd+j/3YkcE7HJ7hbKImdOzAYCgdfbopp1iRvABlyhIMFMbzkKr/ou717rBfDNRvHel7+BsfXF1munBbLrNZ8d+ng==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 06:01:28 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::ea8c:ac6c:b8b4:c6a6]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::ea8c:ac6c:b8b4:c6a6%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:01:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Bryan Gurney <bgurney@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] dm/002: do not assume 512 byte block size
Thread-Topic: [PATCH blktests] dm/002: do not assume 512 byte block size
Thread-Index: AQHaxqsZl9to2/dKjUma6NACMePp7LHX/OYA
Date: Tue, 25 Jun 2024 06:01:28 +0000
Message-ID: <74f86cc9-9862-4aea-8eb8-1e1281a33ca9@nvidia.com>
References: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|SA1PR12MB7296:EE_
x-ms-office365-filtering-correlation-id: 84c89bff-18b0-4c5d-704f-08dc94dc4108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTlGY3BNUWs2TnVrNEM1cklRYXZkNi84ZTYxS3ZoQ2FOSDcvb2R4SXh4eElC?=
 =?utf-8?B?UjZsaHM2UUZ2d2FUbHpuZytkVWRxS1hhYVEyQTNLNHYveUdUdC8venRwN1kr?=
 =?utf-8?B?RVhGZ1F6c2V3RjFXMVhxNmxlRk53NmxxQjZ2a29LMzRLc2VMMXBQZVZXWC9R?=
 =?utf-8?B?NWpPTlZUY2JsZXpkN3RMc1Ftb25ReGphcmlyd3I2RnNROEd6UURVNHRkL1c1?=
 =?utf-8?B?L25zaTBNL2RINllpRndCTVBWanNEOVV3ZnE4S1VuM1R2bXo0anlRaTk4UWFO?=
 =?utf-8?B?WXpqdk1FekxpS1Z0TUlFQjY5aHlIajVSUnIvbXhWeFB5QzZ4RWFKdG8xbnJr?=
 =?utf-8?B?VWMxcFlrcDR6Mm1wU24rNmVzQ3Q4a2JYclFOUDVNcDNtUERjelRpNTA2RjA2?=
 =?utf-8?B?WXZudk9JdXJrc3JIZnRqL28wZzVlT0ord05pN0RqZEpsSEhKZGpmWldLSXNo?=
 =?utf-8?B?OXk4ellJN0NYWFRZVEt4Q3pvc0hyUy9vTllmcHpFVm43SzBiRC9jZWxSNE5v?=
 =?utf-8?B?Um54ZkROTmlnWktMamw3NVJUS1Qwa28xbW9TUTJ1dGlUaVVhS0hjUkw5Q04v?=
 =?utf-8?B?WmlldkhqbFh5ZGRmaHdQSXBjUXFyTmUzNmNVOXR3YUVWbERVUUFabThSY3lt?=
 =?utf-8?B?SjFOK2xnMmcxMi9TT0lkNDI4MEplZkp0eDVqRzc4YS82N3hEMndna1Q1Q25N?=
 =?utf-8?B?eHJxbFNYUU1RVzlscndRazM3UjhBMENQRlEyL2p4YkkxYlR0UXg1UGJkL3RM?=
 =?utf-8?B?aEFvOXBycnQ4U1Nob0UrVmFSbGp5SUpLSGFNVG5XcndYKytTcXRjZ0RwRVpF?=
 =?utf-8?B?OGV3QmNEL3UwQ2xxVmFwNng4VnEvZFBPMTliYjF0aGp5akZJWWJya1V1QkVk?=
 =?utf-8?B?TkFFT3cvYXlBNTROUjZrZXRBZTZMTWR1V3pqYURmYlQ4ZlJMOUtZK2hEZHcy?=
 =?utf-8?B?d1cyRzJlMWNqbElIc0VPcTlFenVTWkJNNmNSNUsrTVJ2ZXFKamF4V1EwSE1C?=
 =?utf-8?B?eTh5ZFBpZElzUzdWRHhhSHRnSGdhZllsb21TM0JNRHBkSysrU3ROVklvQ1g3?=
 =?utf-8?B?Vjl1NldjZFVoQ1ZBSlI5Q2o0R3ZuQjZzNGZ4KzA0UUk5b25neSt5OE5xYy9K?=
 =?utf-8?B?ZGJvaFFBcUVGeUIzaTZRUGV6QWhESVRyREkyclE1dUFTeWlDaDNVdkh3YVNZ?=
 =?utf-8?B?SHpRMGwyOTlKa1lIcmtlRi9LOEQ5QXZUN3RET2RKTUJTbTZ4YWhOcW1PajB5?=
 =?utf-8?B?a3FkZW9wMkRmYi9QNXphbml3L1ZFVlFJOFRwZ1oveS9iaXNjcHlTaERvcXVY?=
 =?utf-8?B?QWFHV0MxbzRWK0tSZSt0Yi9OamllTXBjSHhxWk5PbWVnRkpZd28zQnNXOGZa?=
 =?utf-8?B?QytTZFZFMmxpR1lLczg3R2RCUnQ5WmxUU3JpMEI1RTl5MEJWYlhITzQxZkxJ?=
 =?utf-8?B?aXROUk9lTUN0aTNFWEk3WC9RdEpRZW1YeFdyYWhPVVVvc05IVkNKWXZxWnJB?=
 =?utf-8?B?WVVlTlVoS3BzRE1BQk03UUF3TGVTMUh0aWxyS0NRMjZBbW5zWWthRFNvS3J3?=
 =?utf-8?B?c1gyV2IyUWlGWDBlU3JEVnNRTGplVGFXRUxabi9PTGNHcFhHbmtKL2wyUnAy?=
 =?utf-8?B?VVNTQmt2aXlSTmdhWldJV2ZHTnk1Y2MzOEZGeVdpYUFISzdNZWxjdnVjY3ow?=
 =?utf-8?B?OGY2ZktPNlZZaFl5djhDZkhOMmJQcGZBdE1vOVJWUEVJdmRHYXpXSW9jN0I0?=
 =?utf-8?B?b21wZzZ0Znl2WU1VNDl0c1Z4MG03YjduMjZCYWZ1RnFiQStTdFNTOHJ3ZmU2?=
 =?utf-8?Q?6wOv9i4UTqf3y2Sz9u15W7tebTEiQZ6MD7pSU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHZ2WEI2TWsvSTVudWRYSjhrY3ZUVjZSWEhTYURIckZvejh0VnVBU2pDZWox?=
 =?utf-8?B?K3Y2WmYxUWRaMDEyK0JLek5aQTN5M00wTEV2R1ZLMnd1cWFHWElYSCtWRFpJ?=
 =?utf-8?B?YUJOUDBiWi9aZGVsMEFtS1QvbncxdVFGUXBKRFZycVpXVWtQZjBCKzg2U05r?=
 =?utf-8?B?a1RHZUE5eXFIcGZEeGFjcjZGT2VzMU0zYk90cmh6RVdFUEQ3NTRJWDlxWGRM?=
 =?utf-8?B?TGFsTnB5RmRpWUE2V0JDRExGOEFqcmdpWnZjenh0emlBTEc0K2VoZC85VGl0?=
 =?utf-8?B?ZmZ2RnRvZmNzdWc4OGlKcmR0Zjhmdm1DOGExWlJVaXlkT3cwbmQrby9yOHN6?=
 =?utf-8?B?OWppQVp3TU8vcWQzU2U3K2JYdWdibk9OejYrUEplZWE4MlFRVWxVNURuRGVw?=
 =?utf-8?B?bUNKd3dwZVFOZWxEcEhQVys2NWd3bUZiMmwzdjFmalprWUlMMWlLbUNscktS?=
 =?utf-8?B?T3hxWTBqZVlZemFNbDRoR3NYVk80SUdNUE9HMjdLaXlNbVBVM2xXZ2RXT2c5?=
 =?utf-8?B?U0ZkWWtJamh3cDNWRWI4UzVCdW0xZ1IrZ1IrTnZWYjFFM1RzTTg2RmNkNlY4?=
 =?utf-8?B?RVVsYzROeHNBRWRiQzYvZm96cDk1Q2cwbjh6Z1JCNTUrZTR4VVpQVzAydkVS?=
 =?utf-8?B?RzV0TFBycXIyTWRNOTFtSnQxN3lFS2wyZFZQZDYvTDd4ZHBYc0ZvY3hkNjVW?=
 =?utf-8?B?TGFZRzBOMzdISkFjNVFIeU5qeVBPN3p2aWplYi8xdmpMVVFkd0U4MlkwbUNW?=
 =?utf-8?B?S3d5Si80dCtXaGtRektRVVozallPWVlDb3oyUDg4dnUrMVJQMHplUlVJYjJI?=
 =?utf-8?B?TkFrYldjY2p3Z2NGVk9GQzRXWVBHa0hEVzF2eFV2MG01M1E4WlN4eUl0bGh6?=
 =?utf-8?B?ZlJSQUgwSXE2eU5iSWVJN0dZZXpTaGpMUEJZajU2Wm45TWVKMlYycmZvZGtB?=
 =?utf-8?B?ZUM3MkxSb3ZIM1VsMWdyeUt1Q0lHUk9HajVqRjFGSDV5NDllK2dyelNVZmtL?=
 =?utf-8?B?UVNTRjFKbFpBbGJUTUU2cGtneDcrSWNzeDNrV1JhTXc2bVVPenMwUGVEd0Fj?=
 =?utf-8?B?N3FMaE5iNDF1NVh1S3Yrc1ZCNDJucDNMQ2Q1ZG9QQkJBc3l1U2dqbm9PM1lG?=
 =?utf-8?B?a2dUeXI3YWJ0VW81U21CMWdTcGRSZVhSSHd0RWdON0trMmZFR1FLMTNUMXh6?=
 =?utf-8?B?ck5rNDliNzhLZlh1V1BqQ01zSWRwbTdLSzBaM29UenYrNU5OaTFXR3NicDc0?=
 =?utf-8?B?V0RwV29zYURFNVZsKzB6T2czUjdiZCtPamt0V2JkU29XOWV4eXliZDJ6SzVw?=
 =?utf-8?B?Mm9zWXk0SXhGclAvelQ2MCtTamZNZ0pNZlNURmF3ZSsxYTFRLzRYTUFOLzJw?=
 =?utf-8?B?OFFpNWV3Q2JSNGFMaGlwL1pGSy9LaSsrR2lQbnY2TnZtNVJNMGYvWkYzcEJT?=
 =?utf-8?B?WVY4b2hrM0ZxeXdJbDlGMlZMNmIxNFBOVkpidHp0TGF3VjNSSlZvOXBsS1Vn?=
 =?utf-8?B?QThnZVhYNWRzYWhXQjlJQjdEMDVtTU1hQVpVNVFuMCtGSDQwRUJlaCtDMnhk?=
 =?utf-8?B?Q3M3UkhHY0NVSk1MSE9MZEdWRktoVlEwWnI1QjRQVWhxQ1ZGcmoxclYxTVI5?=
 =?utf-8?B?aG5Dc3VtS0FCOU1oOUdxYW1PdkczVVZtbG0rOWRDSGNQTlJyaEttK1A2ckJN?=
 =?utf-8?B?NUxrOWUyTGEvTFNRYVUycFNCdmtTdmg3YkdnQUlGVm9ZMGFyS2ViSG1WMUFz?=
 =?utf-8?B?Rm14cG1XWmdjTGFrai9udytzekM4dTcxT2RPNm1ZeWlSRmVGSmprZktZU1Jq?=
 =?utf-8?B?NlNTL2U2VjlhMVRaUHNhRktQQ1c5K1lrL1pKSm9tZTlVSkJnNnIyUzBidzdy?=
 =?utf-8?B?R0pIZWFsdEU1RTBybEpzenB5S1N1TmNSaXEyV3o5NzBPKytpV1hjdUdTUHA5?=
 =?utf-8?B?SWxIVnFKdDE2bVU5eDJnbVNjeEtpNThqOUF6RlhVRHRySityTzY1OUl1Y2hQ?=
 =?utf-8?B?Q0NMTG9UY3c0OTh0Y0NOV2NhUGRZZnNzNUs5N0crS1BUelQzR2RIU25Mclp2?=
 =?utf-8?B?UVJRT1gzdGdNeW1kOU9PVkVTNVp1Z1gxZ1djRW1BMEVMeHU5aFlYNkt0dlk4?=
 =?utf-8?B?QW9MT0VWZzBPY29oMHZVdnFCbWl4Um5HNjlLTUxheU9EZWxFc2JWNldJYTZh?=
 =?utf-8?Q?UXVOIJDw/rW/qMh1Qr4jlzDyTvleJvXHlioRN7kCggbG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <565A312F87A04A44BD9B19F653D66D3D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c89bff-18b0-4c5d-704f-08dc94dc4108
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 06:01:28.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ83WWJZu/q8PGluGw4PJFQ7DuN8yJWOr29Ipsua8Zt2/o0XSMPXlqA8cFuQyfxPwnINr1NTEIAQZTG53BdnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

T24gNi8yNC8yNCAxOTo1MSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSB0ZXN0
IGNhc2UgYXNzdW1lcyB0aGF0IFRFU1RfREVWIHdvdWxkIGhhdmUgNTEyIGJ5dGUgYmxvY2sgc2l6
ZQ0KPiBhbHdheXMuIEhvd2V2ZXIsIFRFU1RfREVWIG1heSBoYXZlIG5vbiA1MTIgYnl0ZSwgNGsg
YmxvY2sgc2l6ZS4gSW4gdGhhdA0KPiBjYXNlLCB0aGUgdGVzdCBjYXNlIGZhaWxzIHdpdGggSS9P
IGVycm9ycy4NCj4NCj4gVG8gYXZvaWQgdGhlIGVycm9ycywgcmVmZXIgdG8gdGhlIGJsb2NrIHNp
emUgb2YgVEVTVF9ERVYuIEFsc28gcmVjb3JkDQo+IGRkIGNvbW1hbmQgb3V0cHV0IHRvIHRoZSBG
VUxMIGZpbGUgdG8gaGVscCBkZWJ1ZyB3b3JrIGluIHRoZSBmdXR1cmUuDQo+DQo+IFJlcG9ydGVk
LWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gRml4ZXM6IDczMDhlMTFjNTk1
YSAoInRlc3RzL2RtOiBhZGQgZG0tZHVzdCBnZW5lcmFsIGZ1bmN0aW9uYWxpdHkgdGVzdCIpDQo+
IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrL1ptcXJ6VXlMY1VPUlBk
T2VAaW5mcmFkZWFkLm9yZy8NCj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kg
PHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gLS0tDQo+ICAgDQoNCnRoaXMgcGF0Y2gg
Zm9sbG93cyB0aGUgZGlzY3Vzc2lvbiBvbsKgIHRoZSBvdGhlciB0aHJlYWQgdG8gcmVwbGFjZSB0
aGUNCmhhcmRjb2RlZCA1MTIgYmxvY2sgc2l6ZSB3aXRoIGRldmljZSdzIGJsb2NrIHNpemUgd2l0
aCB0aGUgaGVscCBvZg0KYmxvY2tkZXYgLS1nZXRzei4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K
