Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BFC2D0
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478547; cv=fail; b=YOu+GFZ4xjEbfosh5aiWQxzpFJ7ng4gHkTk0uhT4V75jyeXV7iiLKQQujaGJs66EwKK0knI99rK/YwWDb4CAIIQfb4+i5wR5XnImg7YIMGeruppsNOBBkcT0lkaygM9IQ2YVAgy9yJBcegjLLOt3yKc+Jp4NYoeZ9Cj9Y1hQAD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478547; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=tLP58R4dUjkLLsC577je6IGt8XFyCZOq1Nkgfj21kZsu6nhWZYCnW1WdMMbxL4H37PcwyG6gzcR0ZESCAfsRMpvs0dRjDY8Sx9Rr6cUbl7UwH6iEuKQn7mN5/JkO76qsSZo7YSr+e6JaCa4aDMvSvgpN8scUiJ89vSSXK76txjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WoErPE6s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Br1QEUde; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WoErPE6s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Br1QEUde"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705478545; x=1737014545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=WoErPE6srTatqChMEHHYhWMLMzecfL2i9k1t9tlv1F15HsoEupguCaw7
   K+IN+Tk1cm+8PLkqvBVT5YUB485u5Jzq8oBU7EvFp6KH5uS4d7PtxBHk9
   UELbSGZRYL5/aciwKrGYgCOCUdTTrswfFfv9WqsYih12XCS3vOy80GXY5
   /X0DSP1ha+amEwZku2oAksb38xOHcOyXUOea2XngLAlBsKVstS4xk5Svz
   SjWLUuhCfty7Gf5Sup45kagPG5Sinai0R4qMdmngjutQLEcYRyHrMxatt
   AalXR0B2sS+0Ieiq+l1KnxLCBvhvvpfY4+ixaYWo5n7wsfAfOcxT0M2yw
   A==;
X-CSE-ConnectionGUID: +hCrN3VzTj6jyBoh3i4G0g==
X-CSE-MsgGUID: mo6oxX/uTYaaNN940FUYPQ==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="6806646"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 16:02:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNxCcCwebJbM04X9l1otQC60gcTazmShC1wF7okxF/MqERiLoIil/GIaOzv+9cRVfvk6XllgUzQHv/S/ZqdAYdYVP2+fcS1s5YDdBrkCNbNHKWDkqNFXWOv1HAgOJnjUPfO4X2gv0+VoyTqLeSbv6fYGnBaIx3XTUGwB+rgsmoKSLPioXzYmGcomRMlazyp0wuHpuGeMjSGr6VZnf1vQpz4FtfrNQMPIoVJ3FozP5Z6wrQoqVMR0xy5JsEHaIYuTKrTLMU8cQtmWRkK8e1Kz7x8POdQnZihuhOLnf82Y463/Jg5vGgiHBB+YxciRGVXwdLwb60M//tcGndzyacCqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=mvCOegNBjaeGDJJ/M9DTRAzxqBR9uNcfcirtRfBvMTtiaPfAsuJH6Mr9xpZri+GO1FBUOSJnzwmdHm89XQn2E30FuR9+psakalWi0cKWkttQxll8aBf4g538uj99inWUJYAeFeKWM53x/6fFUTSvbwWMdY4i5PSpQdVJFjUPBmSEFD/uRxHUNC1P3DaDJLCc2jc7fq5TvbzboR4qTzM5b1oLQk4U0KVuNeVJaNTgjZ7BUkLGowkLfAImi6fN3XwU4fnuylE070tVovr4ZRuudK0ytU6xjQbl54MXtsmexE2b+zdQm2KXNnSWTyLwg9pFGoecJzil4jltdBQRcdg7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Br1QEUde4mXBHXmA5TYr61WZeymGW6T7rVdzuQJPJX0WSQsrft4NMU4ytL0dZAUXBGH4KoZXTbqngcKHFF15qloNwYMlAkaiDu5svluKQQqWyENP7T0kyXVQOx4Qu0rtEDL/tXbqK+X7Dilbe15pHEvtcnnJV5/PVVy7RW29Bw4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7178.namprd04.prod.outlook.com (2603:10b6:806:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:02:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:02:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>
Subject: Re: [PATCH 2/5] block: cache current nsec time in struct blk_plug
Thread-Topic: [PATCH 2/5] block: cache current nsec time in struct blk_plug
Thread-Index: AQHaSJ1Hea+UY6G+Uki7onPItkh6d7DdpcIA
Date: Wed, 17 Jan 2024 08:02:21 +0000
Message-ID: <afdae984-bf0a-4aae-b671-07495fa01f6f@wdc.com>
References: <20240116165814.236767-1-axboe@kernel.dk>
 <20240116165814.236767-3-axboe@kernel.dk>
In-Reply-To: <20240116165814.236767-3-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: c86ba714-fcef-40f8-ac41-08dc1732a1ea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NDGz2560Xo+zRH57sSRe63WRZB7zVoFDsMsUWmroTEzXwtsud28kXDMc7Ilwd+8UL4w+GEW/Cq/fMShS8gAyx4UTHFNeltNGcwZQEP4Xkpgb3bBwQbrvOPoPIT/Qn3gQJ0+mQFobE+O60VzPNb8IGT52NzykH+xVjcljVXtFoNy+HhG0Q756vKRkCBvdN3jHOVn5840SuFR6Gwk6EBanBoy17xCw6s2qITditSHcvlRKKXSoYiNFBYPJ+XsVOr0/I+5HonmKvTUTZtjX6vPw2YGZGlO629dVsRm697iLZvtRgK/TuKKsquLQ73d7VozMDHnOdgqMzz5SaZcjiac48QN3fPpDbZvYS7LCYwXbjsGvw78eIz7q2mU+HfUjyx5/HUZq/VhU96Duk5QKgNy2MRUKlY3xBHhMoeKRm/mI8Om3wSKB9NuDCC3zWeksGjNf3vqqqLWr/+OYinPQb/7DIlodf24hc4fMsscNcAUWXAv3Jsn4540Hf3KsiN2Ruoa1VbpbySQ93f+mW9HEFvAs4dibSI2ayQtBzA7O6M2bglvaSUnnRxfTwEV/ffDZvlVdfNZSFYQymvqeBlI+Au6KOuxSXhw9e4DX+OOvcTmFCOSrBufCD+44zQrSGNWonp/dANR7LGctME2q74D2V6dsa8TsWhSLQEaecKekqDeVz+vDgWSX07Z4GmLd2dehuTt1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(4326008)(5660300002)(66556008)(66476007)(66446008)(8936002)(54906003)(316002)(19618925003)(2906002)(71200400001)(26005)(2616005)(4270600006)(558084003)(36756003)(86362001)(31696002)(66946007)(64756008)(110136005)(91956017)(76116006)(6486002)(82960400001)(31686004)(6512007)(6506007)(478600001)(41300700001)(38100700002)(122000001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDBTUnpGcHlmWHNTQ1NZWUJ1amdsbTdwLzNpVDJMMmM2UDJyTi9sdi9LSU0r?=
 =?utf-8?B?eW9UTFZQUzkzN3JRSitNU2pEUVAyYmFGekc0b1ZRZFU2TlhOajBxYlJZSk5r?=
 =?utf-8?B?U2l1aHVaNGR5MldlanpUU2JURW5oQ0NXOFE1MGxYSDY5S21JejcraFdlZmtE?=
 =?utf-8?B?UmRKZzNYaXRxMlZqelRkb3pTLzhvTHlEUWFTaGVPa2lwVGh5VnZDTDdlWVJo?=
 =?utf-8?B?K0tYMm9KL05TSlRadVJZTGo2ekdLVFNSWXZjb2NaYmRaNFJLWGVwRklDZVo2?=
 =?utf-8?B?di9hRFBVZEUzbEdma2EwWlYwMnZLbGFURWVSZWhUZ0lHTmZZWnR3MHBlNlZI?=
 =?utf-8?B?Zzl1T3BtWnZDdnRBNDdHdXZJOUZLellxbEN6K3dVdmpZeFJzUDIxaENpWGV3?=
 =?utf-8?B?UnlJMER1QnhwZmgyYXhVRk5SMmZEekZmeEFWTXIzekNrNkFFVitRMFVGVDFM?=
 =?utf-8?B?VllHS09TR2s5NkgyKzRFZmVFY2tUYlpOc2k3aWxqTXZGUEgxSVd4a0t4SjNU?=
 =?utf-8?B?dUNsMWUwNkpYanFsZDRBUFZpSXNwbkJHNUtLL1NmM2x4WmZXZkhIZjhzR0FM?=
 =?utf-8?B?d1dGOHNrNk9pQ2ttZzJXMlRIVXJVWEtPTzVkN1FEM3plRk5wUWtGMVZxQlQ0?=
 =?utf-8?B?VWR6SkozMFd1VnRqcG1SaU04UWN1SGR2bE1sTHh3bFAxdzFFK0RyTWRPcS9m?=
 =?utf-8?B?Tm5iUXA3MGlRREREV0E1WmtKV1BKNDZFRE9zRmxsaEV1RkpkQXVEakd1N1NM?=
 =?utf-8?B?TVhlVUZ1QTI4OU9DTEFoYU5GWXg2U29yd0svWGpEcEZKSmJzSVJLV2xjbjlq?=
 =?utf-8?B?ZGpCR0lsZ01xai8wMmtCU2pZVWp2L284SXJyREdXYWI0UkNqZWxZd1BHSDdE?=
 =?utf-8?B?MlcxcEFxNVB5TnBmYUk0TkJkamlRKzFablJ3aCsrclo0Q1JGdXhMNzhpQitl?=
 =?utf-8?B?TVk0MjBSbXJsanNlN0V5TFlYOHhCanFlYXkzeXJSOWpKWk5wRjd6TVRYUFpv?=
 =?utf-8?B?Q3hpRnVLendRaDdmMmdjYWhHN0grcFppaGV2NHFsb2NLRkpOZ2xLakhpejY0?=
 =?utf-8?B?VVJobCtVRGo4UW9UVWJ3eHd3RTB1RVRsTCsxUVNkakpUQ2E5cDEwWmJ1ck5i?=
 =?utf-8?B?bTl5b1hCU2J5aGd0SkV0a2oyWHc2S05tUTl4UThQZ3phUGtjZkJxM3ZVajJ5?=
 =?utf-8?B?VGYzQkpONjd2N3VLb3FiaG9NMXZIeDhqenp1STNhZkE1UDVtRGFqZ25YSHBy?=
 =?utf-8?B?Vm43NFdIdGxJZTJTdlNFUFplYjVPR2hxeXQrSExlZGViQ0VQdHBiZ1dIZGcx?=
 =?utf-8?B?SzFhNlhZeDBrcWFneEFWMFdYVUlBaXg1eHZJTXlRdnN4aGhnaGxMRmpCRFNi?=
 =?utf-8?B?UWZaT0hjZGxuSTY1SmtzNElFS0dvMjd6UmgzdXZDOHBZNjJjQTJCakZsQitr?=
 =?utf-8?B?TWFkRE5hUjZFMTZMTUpOT01aRUNFQThsaWtuZzU0b2x4dE15S1ZCS3h0MzFK?=
 =?utf-8?B?V2ZhSWxDUkVWRE05djArOFNLZHZwRDUraXR1L1Fnem9QMGZ1K1ZuTy84VnM2?=
 =?utf-8?B?Y2kzRUE1emU0bFc4eWJWd05IZU1iZkVIV25wTWU2c3NmZHllMVEzNWRWeFlI?=
 =?utf-8?B?NUFzUW1obGZreDRVMFFLYzA4aUE5Rk1iUVpBVE9WRjJJSWpra2JOWHp0WVdm?=
 =?utf-8?B?Y0EvUDlpb1liSnhEUTBCYWxVUnJLNnpWL1czVk9XbVNoZFdteGxqdW5rQnNN?=
 =?utf-8?B?bGMydDBIOUExdU11UlhzV2FwK0k3Y09LTG42QjBlV01peWJUbVFsRTdqWCt6?=
 =?utf-8?B?QXlxSlVjRU1NMWJEekZzb2xMa0dFazN4MU1xTXRjSmxDMVJBRk5idlcrUStX?=
 =?utf-8?B?Z0pUUzNuVit0YUd2Z1NOT1h3ZnlUbmVwUUtPdm9GYkJMRXZDdXovTVdqYXlz?=
 =?utf-8?B?VmJRa2ZsQkwxa2VoVzlLL3E3MVdiZmRWWC9xRjBNMFNuZG5ldC9yay9SdDVQ?=
 =?utf-8?B?SXFPSElwaE9ESzhlWlFpNTdOVksrT1VsYzFQS2dIcHRuTlVwZXhTRnBSUXlS?=
 =?utf-8?B?RkVFcVRxZlBJd1VvcjAyWGl3OHljWjJwa1lOS0xKK2Uzd3hSMlNwUUlra0ZE?=
 =?utf-8?B?L2M5bDVtaVl6cHdlV3RESjE1VFk1d0dKM0hnOFlVSVZENWluZG9kNHN4VU4r?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6975F7F51D625439B2E164DED2E345A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aTbFHPXZJYNxaeODb7/qUcSWmxkoK086M/fVHY0R3K816I/tQjNue11eR7VcBG/TbJ83hkHS30cxZIZYsmhvdPsxrANpu3RJG8x0Cv0F9FUhL/qFo1//0juyoJKVio3ZaWXzekLk+OI7rGMdpOgoey/bcxOVM7UfZjMRUTf5sVTsst5buwuJ/N7RxOnVV7bA3vekxgNaV19yN9pZaMuQiATRJNZe+14VA71hQ2U3zmZ6tSo86R3at2Jo/29X1gEwD19fcI7kp7MlWQgJ16DW8dW/+oRL1NdES0FOTJZnVBbEJCz4RlvlV8CaS+GbXhK/QQKSjsJVftfMqYWv4VVIg+VVaie/BJCTMVJdbKRcIUMG/Ezfr/HhNJMtQpFZpdCssPo3wFrlZNqPWZzEzhWsIWJWnHlGJr8G8cz7FICtEzmCLBaeUR6WMijrYf/EJ7kT8kP1XwRrI/gzEKI9YIVj82EX0ecKapUdaW2XykjBVh7rSkf84o3jzT9FzyKpe5PZoYF0KtvsIegZzo//5tgVEgmVzieB7IhYhL8gOCWQsMKSVyN9AuN42/4oX9fHsy24eJpVUy1Gga03F4y++EVacLGNmb2FxP7TybYIyWnUak5+nZczbeqM9Y2JxytVkjbM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86ba714-fcef-40f8-ac41-08dc1732a1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 08:02:21.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pf9QtqRmp3z8dre1NIOnbEaeWZVcPoe893K8IOx6o1O8qnfoluOy9wyGkxLUd1C/yRm1Hwa2cwHChyxoRlF3Lgxav2K+EkVLPBQ51WcWMFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7178

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
