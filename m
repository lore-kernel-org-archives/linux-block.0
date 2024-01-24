Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13420F9C1
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088149; cv=fail; b=cd5sSPLj2jPHxiP+cFkKcnRcOpQi3Q+Ed0VZ3FGP8rq/uDKJWO24Pk+HwV4SPVQo6b+PxkZ3StRTfI5VO/gkOglERIWO+WUIzIFUdR0BcOSNjNS33p74bLSmdU+2QSaV2m8VhP366PHjmjpo90NW44DM/JjnalsRS463EGA/kyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088149; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z53IOJZCi7FqcytuECao74TZOBBwUh+qVsCOemyzjjzUCJ2w1qBlFPlWqCGjKIMS0iTieHysgZDl/Z7EcR9uFoieL9WkxTfi8epeOycEdQjvMo0mUNTqQy2kduj0gyexaQqI2uNYFzDOGB0EJvwS843tahSQQM8i/i+l9GSfNbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iv0LRpIc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wSyB1sKZ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iv0LRpIc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wSyB1sKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706088148; x=1737624148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=iv0LRpIcGmvc65wrtm1EMbO/DMCK96MJPb0fpPsupSFdjpUoaq7HwHFc
   yq/eLg8MFyTKgfmUYY8BK/rc6SuElLL8tOHXhAQ3AH6AESDAVyheeq0H+
   KEIepClauoSh4q7NFSjaDWsJeUZ3+If/Jd37VtmAYVmGGpm14cdhbrht7
   lXLF7ZlwS2Py07XBv0/q2C0Sa7hlaLiS+jy06wgxKkHySM1DTFyx9ZADx
   lWdw4LOFACJrOf4EbF4f/ncbQXeDeq/Lvl/f4RKBhSWrMSK5MJZvhJcA/
   OpAIxL9miHEdPGJQNgzfjHaegCPUL/JjetyZYn2jQfi+ETcxkl29XsMlF
   w==;
X-CSE-ConnectionGUID: 7vQ4wXGTTKW9ViuH3eWX9g==
X-CSE-MsgGUID: oIpxPhspSEim14tZ+xjZWg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="8116608"
Received: from mail-centralusazlp17014024.outbound.protection.outlook.com (HELO DM4PR02CU001.outbound.protection.outlook.com) ([40.93.13.24])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2024 17:22:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvm145TdPaYdz7mqoEls4oozBbQPTwDxXkdDu+De94u/hTNpBG/TW8Qkg8Xpr9oaGcs5WNX1nPDmqBqJU1zDAAqxUHxdQnOalVHpzEoWph+EAoAZfbMWeTqzdXde1eTOsrdgmJIpdGISIjiH3TTUsIoGuuFXlQt5LWvFyaeEA172jb+HJfRcg+ZVDBXLsVIwzcaVOLRD92QTlLwSETy3LCr/fZllNN7k/caiJOwMN5O38AH1yO67Mo7ZqgeYn6pVlOQuGwPp5ES6LG9DfKzLZr7TkWxHf3nAOWA1ijxjNPxaHma/tjsYNyNj9jlXJFTjWupsG3Jl7GAc9WPi2G6N/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KO638WkZmtS5ngonOGGnIWXK6nTNDUo9Ak5Kjzg6OAjTUFbw5hz0VhsGgKYvn8q+Y9sgjy/6vLXJ6CPvCFn02NloZpHCKyQrAqgPnhvV+PcCvsVFJHlsEYnKl8S8HiLhJvUBQ5gF1V2UBIH6rc753elVypW/pB6IJvYUoK2YaCIGVq+/np5gqcNcPwBoGk7LPZk9dBIVYQVe7OfweEdoEehc318bHGwirdKx/jKe9CGh0zgp+g0YA51PKjjvNOXnwGYNG47zMnVMyCtIWOoKudER1ZqqZ6NFRLuGDA09z+G+Mk3wMb7jc+4GM9HF1ND5OIOZX6WVrP2s+E3IrneHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wSyB1sKZYhe6oITYzjavhWBkNQp5rXJKXKc5UYAzeq3V8LO8TFG0L2pykQE4fnT0gAI8oXOZwWlVXQleKajz8ljPjB8c+nwJv7CYeQyFb3D22wQSDBsLvyZbrTys+E7bvoJ5QNBrM06VI3jwqsdTnnjOsikP9rG19TFhXrdefoA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7340.namprd04.prod.outlook.com (2603:10b6:806:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:21:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:21:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/8] block/mq-deadline: pass in queue directly to
 dd_insert_request()
Thread-Topic: [PATCH 1/8] block/mq-deadline: pass in queue directly to
 dd_insert_request()
Thread-Index: AQHaTiNJVkUbBSqTtEiJBbRjGJG+WrDosUgA
Date: Wed, 24 Jan 2024 09:21:59 +0000
Message-ID: <9fb1b61c-5fc6-4aac-936a-f68204a8bdcb@wdc.com>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-2-axboe@kernel.dk>
In-Reply-To: <20240123174021.1967461-2-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7340:EE_
x-ms-office365-filtering-correlation-id: da415fb6-3974-47ee-149e-08dc1cbdeaba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 15s79UUTgwdvtSwk3p3zKXLqhvObewS6y1+pvc/Uz+rkiSJavTtRTWIJSUawjO4xu4WqsuarnpjFnK1s4/SMkXpsnx5z66MWfJCo8LbQXQ5+XfGDT2NwFK65VNtiCLCLbA3G6vJB6dxOzBh3S1kffUDIQI3qYEoyE9ESvyhd47/65zS6ju51OW6cKb5TyfUAlyFc9RMDuRjbjCh7PI5AIMb/9/XpWEIjMGIHcJ43iaB9XJcxL3ezvLlviYw1+icL9LThe61vp3Gfspimb8Eb1akNGNzNWPscgg+/wp64lSkiTwz5jUzw12EFnIUjLHgoKeNT1cKJMO6+rQAnIAD20OPOcbHgfbF7YL+vAqNmXrG2RbqbH6JRlcUqiYXdbvDJ61EzfPkwkKl+Jfr4UEvW9kaWP9lsvUxa84K8hh2fUxNBUSP6ywrT5q5j9SUqdEMlaSuE6CLz3t1YB95Bi0b+aQ9WgRTUBDYPFBSWDzl1TgehP+AHrgxDhRYFpL8hyDN/ideWZcVl76LQnk8ZMkp2p3280p0umUP2wGXvCqvPq/3ov9SDGvRKnZoJmkK0VpWJypvtzNNTUQQcz+Tz/hc1SjT5+ggsr6EE4wa+a9HcIbSViJMfln3KVeXmCJ3zd8xe/zyLUcMqkX3X3crPMOz1HV9mMN0/m5L2YlhTrHp2QW4qWQshP/FKfx6u/DJDIJXl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82960400001)(122000001)(19618925003)(38100700002)(478600001)(38070700009)(31696002)(86362001)(6506007)(36756003)(41300700001)(6486002)(71200400001)(558084003)(4270600006)(4326008)(8936002)(8676002)(2616005)(110136005)(91956017)(316002)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(5660300002)(2906002)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHo1Z1ROOXBGOG13cDR6bnJlMDRrYk81NXRpZjJSeFFBL3FiaVRFT0FvTTRm?=
 =?utf-8?B?dFdhdkoxbVBsTTBqT0dhamNlU28vNEtRUUNVZlhlL2dwVmJNTkdqSm5RWmR4?=
 =?utf-8?B?dEdvNVlxT1dDSUNHR3NEckl0RmwyOTQzVTlDSHkyUGV0UHI2UXJRY0FWbWh0?=
 =?utf-8?B?cE9pTGpKeFdZYUxzN21nczVKcGlKVXE3UTFSbktYNVE2TFJ0U2FrSHVLTmlr?=
 =?utf-8?B?K0VmRVE1Yk52RkZLcVhuVElOV3hKYTBScmJTN3FlTm56TGpCdVZ4T2RTMmRK?=
 =?utf-8?B?WEVTMVByRG1lVVhDUENuZ1VjeThYb0xlSGVzNk8wMHNNUmgrNWZWRW1NeCtG?=
 =?utf-8?B?bVBWYTdxSFlRdTRESUFORzlnVXkrQnJ5TWJNRk1VampZTkltTzkxZTZtS2ZX?=
 =?utf-8?B?U3NpRkNwaTBlSHN1QzZUR3hWTjBTK2M2aVdORU1qZlI5TnQ4dW5zTldVSWlj?=
 =?utf-8?B?M1Y2TWlsMU1CQjBFR1RCOGRTRUtWMUVyaktERk1uaVBGYW5oSmIrU083SkQv?=
 =?utf-8?B?VmplN0M1LzNDOEdpaFBPR2FXSTArWmtOMitCR1pCcEhzVFNJamM1UE81d0tx?=
 =?utf-8?B?TzlxSmw3UFladFRXOGl3VFZ1aVhTNFRGcWJPWndOalh3RTJjaS9Ycy9GUGhn?=
 =?utf-8?B?eUU5dFlyOXJBekVKZDBxSStNQnU2dkNqODRPbGhJTUh4OFhkaXlWTGRpYjNv?=
 =?utf-8?B?dXVBNlcwdWpZZVlyVXgzSCt2YUhTMUpwTi9SOVVxNktua3ZrZ2hWeWFRZ2hG?=
 =?utf-8?B?eTA2REdtSkZ6aWRUSGJpSjVFNkEvSWw3ZDZtcmJ5VGI5VEU2QzVubHZ5RlBP?=
 =?utf-8?B?R0ZnUTErVVpUZnlML2pRS09jVVpjeFNnL1NHNHQyNCtseGxYSXM3ZUVyM1Yr?=
 =?utf-8?B?R0dnU001SzZOWGVBN05MazNUWW81VDVqd2FsaW1oSVkwOFhRbmF5b00xMms0?=
 =?utf-8?B?MWdVVFJQYU8xZ3FGclhNUjh4MFBycnAzbXliS3V6V1FKT0VTaDF1b25temFO?=
 =?utf-8?B?VHdhWGpFb1ZRbzVHZkxCRzZjclE4UHBmdUIwejRXZHpKbDhUaTVBWVFDL29m?=
 =?utf-8?B?T1NyemJzN0FiUFMwbzV5cTFRRk9qYkcwWlNqTGhBN1c2NC9FOFZMbThUa3Iw?=
 =?utf-8?B?VTdlUmlkMjZrd2wwYUs5SVp3NHFlQTN4SlhWdk5zRkNwUmNWcmlQZnU0NEkv?=
 =?utf-8?B?b0k2T3pYTmttNXpxSFJkbStHYUgvK0pBTlBwZlZZUjNZZHBteFZ1ZTM3bXl5?=
 =?utf-8?B?R283ckpuWWttQlIvVmxZaFhpeUZoYXRvK1Jvd3NxMTBQa2huclFPUDNsTEN1?=
 =?utf-8?B?ZlZnclAwNGJQc3BvQ3QycVRHT3Q0Q3pyTUdhUjh6YXZINnF4OWp0RDFlUW9w?=
 =?utf-8?B?VjdjUktCNzhobkVISGpjbjU2dGwrWnVpRWo2OGQ0WVNBRi8vSEdER2srM2hM?=
 =?utf-8?B?TVAyZlIvZFozRGlNbWVaa0wvenVGdTM3b2tzeVRxYUtQOGpDNkFxK25IM1l0?=
 =?utf-8?B?RzNNTENING1SZklhYVNWamJJVmZFUTN1aGVFeEhMUHJHa0lWaFprT3NtaDZB?=
 =?utf-8?B?L2twWGU4M1IxejJyUldlaFdFK1FSMVhEZ0ltSXlkVTg0c1dEbzg2T2Z4OTdT?=
 =?utf-8?B?UjdoN1o5NW9hTVRsV1J4K0ZQNml4MjRQUXlaTXphM1IrbW9JaWpmTjBMQk5D?=
 =?utf-8?B?cU9nTVB4T0Z6Vm93Sml4NDF5MWxQVjA3YU9zcmIzbTZNL0doWVZMa1hUR0R5?=
 =?utf-8?B?bDdjeXJPbFlFK0hUVVd2Y2FJTys5OHpLb2xKdjNyRHVxbk42c2ZVSGh0b0pF?=
 =?utf-8?B?Q0R4VmNJaS9nQmtUNmp3UDRETElxalBhVFBQeU81WGpBMDdZUEZqdDlaazBv?=
 =?utf-8?B?eWxIWmxWODNFMWNyamlveG5mR0drbjEzalIwRTAyVVMrTFhmWER0M1dZTUto?=
 =?utf-8?B?TjhKc0hBUDYwaEZJS3YwVDl6U1dma0RlVE9wdVZsNzMrdVh2RFpCdmlLQnJP?=
 =?utf-8?B?c2wxV3g4Ylhpd3lXK1dFUVQ3L3lSd3dnd2UrR0FGbnpaQTFwK084TEw1a0lR?=
 =?utf-8?B?clcxVE83UElvWmpHT3UrUUxXM2ptcE5RbUp6L2xMalhMZFVTaEF1QXZMbVZa?=
 =?utf-8?B?cHAzQkRYSnY0ZDl2SWZRSFJ2RFhRKzl2dFV2dTlGMU9LWHcyQkh2dTlvdm1a?=
 =?utf-8?B?TzlGalQ4NEZWVVdUMjlhY1ZqK2pub3ZHSXQweFJjYkFJbWVRdm54WTFvc3U2?=
 =?utf-8?B?Z1A2dW56dlVSdm9yWlM1emhOR0RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <243D281DC4E12346A23A6CB45B127FEC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KIlrd/Ce4Iv4W273Idzdx7TLKgaF84zyIqeovs8voL0IT2z/58JyurIjIwHR3GsF9XpPxmeUsYHbR44ZPfupe8dZcWj6q+DaX5iWe1+Z/rz/R2X++GUZIYe7aJcninLDzewTR3K3E3t8+8crb7zi0CLGKllhIUmdLEENmwZO6trEjFKRznLhFKwSr35tIVRerVbaWCw95VqbHxCxULyYO0kNlNekZDmQhMKAz99uTf34h5ArLZ+jO/s4mDIESiiPtn4fCrepm2iEPjRxUfcyEydFmMR+wCefMxaxgEtQSKdc0esT3uAka5cNfphqljRQqJ4991hOr+c5LvnSWLHmrjptehotHQKLS8YveeEgKGZfdKoKPyeGB4P3XwjpgxNOFPhS7e8LxHNxPE9WQ0Y2HPcDU4PWXMPnD3BGu1R381mZgAWnLMyTUJYZ1Sa1+z4btzCJBtwRJqcHp3ugJXZtR/WNGOsDHz0i8yEDUC2r29vYrFfltFdVtaLVM1cxDLn5eS9YEovtvRZirHDBfb7tyrcptoU8wxMoO95dyi9JlQ3XbK41me5UzpJtXEQa8C6ySWu2FbjfQVkLpl1g+Z2HYClFaw2DE5bMLIZYENMJJLEyleIOrtOUefvnfmdPT7f1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da415fb6-3974-47ee-149e-08dc1cbdeaba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:21:59.2146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzIYMs3ddyYvhyuM+oGt8/JiZySL2wZqOOhHctikYDmog3EdFx8AoB7W2pTb21bvoiXEAVDuyOyssQCGDWeO/T1/fSRc0C2wvQJ/K+aos4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7340

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
