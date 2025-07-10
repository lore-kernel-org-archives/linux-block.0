Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD436287508
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128861; cv=fail; b=dv/9HEy6xLG/0jMyMDGnt7fsVDUjAGt6Iisl2G+1PTXzItPQv2UrTXRnvDjWbn0qb9ueYQy0Nx3q5LRw4c6F/VioXxiFzvyDLTaLPSMqyG9Lu/qTWw4RtXdCuu68EgeBBN4FiOH8cIYx1DH+iGfvCzbv+P/RXDTb3LPTvCyeLiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128861; c=relaxed/simple;
	bh=qE9eJAT5SqrFVjOUAdw3OATgCNGXQMCpvA2A7NSYQZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwZRC4qD7I0zYbNpn8CqX6DClYYwCVd9QzHBCpDkv6ftR6mMqlo/hGWru+7kKecJ/RkZcjm8mUJopiQElHfkZQAbDTEsGOkeWj5AXtxkPVe6yj/b3cGWQ3EwO4NPM2onm988t5XX7CrV3bVPqol5iuc9+tKBQZexBu77nEbM9ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rd3a/aZ5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xYejcI4B; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rd3a/aZ5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xYejcI4B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752128859; x=1783664859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qE9eJAT5SqrFVjOUAdw3OATgCNGXQMCpvA2A7NSYQZc=;
  b=Rd3a/aZ5FZC+RNzufUrm4Szj6+pWbS2WjJYcahe8pZMgnZlc6/IL2U94
   wFJAxFzgqBpot6AeI5XtroQ5ueZJLZiM8fyMPf4lQAqp1TXxn+MPLHuvV
   DknJB+yis6hP5Tqgrv0Ki/Q22pHe0TSt4LJveNvNYlVPz3jfDK13OrWY5
   3Ckr2C17tnoyb+l/zrV7dG1cAMejPqCBJhtbHGELdc5ogKhsNqLsQtY2Z
   5Eb+qpwgFkYOsKN7hvwZIUdCCkb/79p4UoMWTZYlYo57V4N8C4WdmaHH/
   uSusur5xJSa8rvFcnrXtYVVHaSYifqEg6sj3gjd72KTu1kfO2oAe5AN3v
   Q==;
X-CSE-ConnectionGUID: PUAVNDJDQNCmgyqty5EW7g==
X-CSE-MsgGUID: FUPWeslwRoudhYygQd4l6Q==
X-IronPort-AV: E=Sophos;i="6.16,300,1744041600"; 
   d="scan'208";a="86185319"
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.68])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2025 14:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVWcbH+9v7e0izaHDyiXe9BUbVKQvlHNat2uqUizi3e/nf4Wq+mOKFx5g1JOUiXBskBsa3IjgbvAKztWRe5HztT3bGh2YN4JcBwRi1ZtwAmTR+WDepInccGF0/DaIBcR8XoP7pNXsPN+njeGuhSwFktctXH3YxZrFd83F+PTmrPsKdYAmH+DycNNT4rWVcrx8GTG2SYGeuUuKeKEZvgkolC32ZokNk0g5R3Lh8LxG6SgsDUXTke1cvLVhsjYpIh69EppDiyaAsimfbQllND2y1JqeoKt98fDT9p6qlGBndLOuQh8D8vKGAPK4+cqIRWqpvtqbMo2NDfS7ZXWAwgM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE9eJAT5SqrFVjOUAdw3OATgCNGXQMCpvA2A7NSYQZc=;
 b=QTBZrPXFKml43HFr3Pk1CCYASgz6dmR4jd8toWfeR+r+u0tbNf9fCidp+PPA54wMoA7enuUgfQy6buoKe+820neLhLfKtF0iIurN4oxWjsyjLusXLCg6M6GouyoEBjHyD7MyWl54mcfAk356foZIfvC5/c6o/MXasS6q8kitLPDYiEB9z5wV1arbt43h9woM4njmP6soWFpnAUwy5Xxa/uyGZ28INrcRYZmDy02iuk0e1qrouRfmksgucdXob3b0Pto05PqWRQ4xtEiZOhzop2bASJVz//T5q/luCSQTuqaFfuAZFsNE5whSeatrtrkA1qnETpZjnBA+/yMamqPQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE9eJAT5SqrFVjOUAdw3OATgCNGXQMCpvA2A7NSYQZc=;
 b=xYejcI4BZ3cnyOx4G3Tte2imYcGbAQrBCk9GIzeMNXcHtPTjnw9yMh7Kp8Vv+m2IP/78WipVn3g4LUxzyP041c7Sn3WavBZKlMAaylcQdgkCGPg3gXjcsQ8wGgXmRRcglsMXmKluibhejSY4W6B62cNe7vb7VGFi6Kj6wC2g44w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6974.namprd04.prod.outlook.com (2603:10b6:208:1ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:27:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 06:27:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: hch <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 5/5] block: add trace messages to zone write plugging
Thread-Topic: [PATCH 5/5] block: add trace messages to zone write plugging
Thread-Index: AQHb8Mc9vJ+882S2VESQp3vEi/2N2rQqw04AgAAilAA=
Date: Thu, 10 Jul 2025 06:27:34 +0000
Message-ID: <5242cc26-f6c5-45e1-816d-b9527f44f6bd@wdc.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-6-johannes.thumshirn@wdc.com>
 <38766c2d-eadc-4998-b07a-81c95449e091@kernel.org>
In-Reply-To: <38766c2d-eadc-4998-b07a-81c95449e091@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6974:EE_
x-ms-office365-filtering-correlation-id: 6d63af16-c5be-474c-15bd-08ddbf7adb5d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THNOcHdsSXFDU2Q3aS9XelZvMGZRTVhtem1KVnhBaDh4MmZwQlNLOGZqNGxy?=
 =?utf-8?B?d0c4LzBGZGZxb0YxemgvQjR5OUlMMWg1ZzRQd1F5TWswUmx5UFlJcWthZ3pS?=
 =?utf-8?B?S2RLbmpvMjUyYkxTeWVpMzBXNzJESzdnQkhuSVpQK2daVVpqOXhJYzlPbmpJ?=
 =?utf-8?B?KzlPdE5uQnFEZUVCczZrS3lsUHRWT2lNNW1DMEtKRGgybWluaUMyZWNMaVFB?=
 =?utf-8?B?bFZ6VzRzNWFRVDIza0tQaVVIS284QXJLR3Znc0JvWjVrTTloR2hiVnZhU3Fo?=
 =?utf-8?B?M201aXRKVjNLWG9BL1VUbktsamdUNThNRDF3MTRwdUkzNXlVOXlBUTYyaG9p?=
 =?utf-8?B?UGdqQVp6Snp4VXhvZlNkLzBQU245U0ROenRablU0SUluZFRkRU1PQ3NaRXpj?=
 =?utf-8?B?dWkvbEc0Y3F1UmdBZ09lQmk0d1E2S2dLZ3R6Znh5ZkZUQzdzQWVPbkllOUVW?=
 =?utf-8?B?eDFOL05vM0x6aW1EY2hZcXVEaHFLNmp4YlNTWDNJS2FMdStIMUJaSUMyRVZx?=
 =?utf-8?B?Z2J4L0EyVXdCQy9aNmlMQmYwSU9hckNKN2hsaHhHNUs0bEtVOTJtT2VhZnhj?=
 =?utf-8?B?d3ZRanptNXBoMkFIYUoyK2hZdzI1YUREY0xObkIwSDdwdFQyekxxZlExYUFn?=
 =?utf-8?B?SmtiV2VjbnhXMERPNTR1VHc1Zyt2bTVxaDJoVkZEaEhmNGhMYVc4by93ejRS?=
 =?utf-8?B?ZVV4dlJvNUp0UzFFMW0zazdSMWg0QnV4UTlKMzBxakgzTkxKTEp5K1E1VDMz?=
 =?utf-8?B?cTgzME94MFo2cUc2WkJUaW5kMWVGci9KdEo3cjZacmNBZFNpdXNyVWJQdjJZ?=
 =?utf-8?B?LzBlZlpJc09IK3Jib0hKeGg3WlNoR0JKVnFEakphRmk1UFlHUmd1Y3F1Vm1Y?=
 =?utf-8?B?b04xekViclhVTjRBa3RkdXZMTTArQ1hBdmlCMHp3aFJaWmNHQUJqUjV6SHFK?=
 =?utf-8?B?TVpEdjhOVitoSkRoQmlDWlBTZVkyU2oyeHcybTkwK1hNWGFYZjlNSXFXUjdv?=
 =?utf-8?B?VzVTR1JPd3d6NEh0V01ZRGtBUHJieFZyNExVZFQvT2FkQm1rM21zNVJqU25K?=
 =?utf-8?B?QlNmZkpMajhPc0VoZjhTMUtiWElQMkthK2JBZFF2aVlhcmdkaVNRMWFrZ2Rx?=
 =?utf-8?B?ZDdCWEFPZWlxREYwVzZqQW5PMGdRSVBabVZTK29oYjh1bmdvcWRGUzQ3QmpR?=
 =?utf-8?B?ZXRPVjNZZWZvSUE1TkY3TGh0dUNIanZ0ZTVoQUs3OStNMmNMczliRHdFRnlE?=
 =?utf-8?B?eHhpZkQ4TGxQVHVDbi9Idm85d2VQbDZ0ZzBoMSsyNkNraC9zbW01aUo5S1BY?=
 =?utf-8?B?SEo4MDVJY3NidHJ2cUI0TzZ6dTNDYTdkeWtNdU1HUGRZS0ZhZHVNMkczYmN3?=
 =?utf-8?B?THhUUXZOenRBc1hyTGU0MjBkOEc5Y0ZJaVZRYThyVmRoUCtBVGVpV3RGOVpB?=
 =?utf-8?B?aHhEbFRNR2l2NWw1cVJWZ1BYbjhyUmdocEJCanZtNXVSZmlYSUxwQjIvTnNn?=
 =?utf-8?B?V1ZLUmxPcHZPTE9hUFA2VzlBd2JjeU91QWVoUmdIY1FFekMzTURBNUY0cEkw?=
 =?utf-8?B?amJhUWhZallURDZjaTFDV2lyaVNlb1dLSyt6Um9TaXZJWk9kMGphZWpXWGQw?=
 =?utf-8?B?UWVJbHRDUC90S3lmK3J4S3FUNW1yaVVRUGxJbGtoTStmaVoyak5WRFJVU1Mv?=
 =?utf-8?B?azBpTDVyNUhvZUdPaTZjNGtlZm9tY1pQWjRjZ2x2NlhIQ0FvSHp0RjcyVGNm?=
 =?utf-8?B?UjFpR3ZnUHY4TVVKeUlQQ09yVHFGN2o2NnpsdGJaN0FjK3Y4ZzBQWVpXSHZl?=
 =?utf-8?B?blZCa1VEVzkxOEdYWUlzUjVlbEdvZDBlUVh2V1dKY21QemRBaXFic2wyZ25H?=
 =?utf-8?B?WEw5cklzLzdlMjFFS25uYjRERXFkcjM4R1V2eCt6RDdzdWIrVU1uakVWZ0Rj?=
 =?utf-8?B?OE1nYUNrT1h6R1JWd0JjS0IrWGtWTmpXRis0R0V2ajVXbnhkWHl1UzNHcHp6?=
 =?utf-8?B?Z2NUdEhwRW1RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzA4cXBYdk9ZYWt3VjRvdVRjN0dOVEJLQ1B2RlMxNXZ5ZTg1K0dKM2U1MG5u?=
 =?utf-8?B?SzNSaE0vZ2QyWmU4S1BrMDEzZzA2MVBaN0d5TllFcEhCYWUvUmFRMkhZNlla?=
 =?utf-8?B?bHkyTDNlZnVZTEVWMFZ5cFVESDdpMEM4YWlxbGR3a28weVhqblRCa2pXMFYr?=
 =?utf-8?B?L21qTmQ5eWlVT05VcEh3d2twYzlhSG5Oam5vdXdqUTI2cE9CUmN0MXhrcXF5?=
 =?utf-8?B?QW5oUndRU0duWC9wWllxME8rN0RPVWtnbHRFbE16UFBoU2N1d0crbnUzZ0ZF?=
 =?utf-8?B?amRCZ0NZVUNkOEE4RzdBc2UyS0xLNDNuSWE1TlQ0SDBubFFITFNwQ3pwbmtZ?=
 =?utf-8?B?emVCODJPYUdQaHErWUxMWEk3TUVXRFpsckJ4dmpobzNQQkZSNVdzTUNqaWFZ?=
 =?utf-8?B?RTdHNVRFQ2VEdDU1cHdtMlpRSjJRbGpvUlBkY0NjWmV0a0ZLemJXUHJqekhF?=
 =?utf-8?B?SGIxeUN0N21TQzdNTUtCVE1ZUUN2M2t0UWYvZHg5dVFnMXdrZGRxMGdpUk4w?=
 =?utf-8?B?KzBDdjJpZlI3UWgxaEJycElFakVieWNQdHV2MnVhc1NMNkFueUZzK0Z3MFlX?=
 =?utf-8?B?dSs5M1dMODlIL0R6MHBSWkR1VG1NOGFhYlVFN0JxTnhtMk00NEJHSDNEQjdM?=
 =?utf-8?B?TUZmQUpLbjZEaGt1ZGEwY29keGlScGYzNzNHR1RuZVhub1g0bjF4ZUJrcGtx?=
 =?utf-8?B?WHliTHNDbXZDNWhLWWd6S25oQTJZQ1JieHAvYTFYUW1TcE5iNExEVElQZjlP?=
 =?utf-8?B?N1J6a1F2bHNFWnBLWXhwLzdCUVlnTXVZZTVTK0Q5YnVEVVYweXBTQ3d0cWE5?=
 =?utf-8?B?YkNGMzAyUUEwVWdqWUw0MGpJbit2NzJQOFV2c1BvRURCSXprTHhVT3VqU1dz?=
 =?utf-8?B?bnlWVmI1Q21mQ0xZTWR4czBodFB1bnJjcVoyTzl5aUZHejdpTWRubFJQeXVO?=
 =?utf-8?B?U2ZCSXFTdHR4ckg0b0pRSENxTkN0Z29OVk93M202MGdaaHVSdWNBMzBCVmI0?=
 =?utf-8?B?V015aE1XbWVlbzB4a1JoS2hhYkpXUEJTcnQvRmN6VnBKalJjZUxuNzQxbExw?=
 =?utf-8?B?OUdxUzRraGpkNmxRSHZMV0kxWjVQTTE1OWFXeDR3YUdYUXpvUlh5UHlCY242?=
 =?utf-8?B?YW91eXhFUi96UHJNQ1hVK01CeklhTFV1Y1NRV1gxekJldE04VFludWxPTUw5?=
 =?utf-8?B?K2d2SU1HbHliWXdiaTJqRnFIcWtqVmswaHBVRzNidElNSEVscTk2c2tQcEF3?=
 =?utf-8?B?M3o3NU0rck53M0FUODF6dFJsbnhtQ25jcG5vMjFOU0k5RUc0L0laOEJwVlFl?=
 =?utf-8?B?S1l4d1ZCYVdKRjU1MDhNOFRaQXZQa1N4a1BzN0tzZ1RnYkV1QW9OZyszWENE?=
 =?utf-8?B?cndROVlXRXk4bzh5a0hkQWk5MEUwQnZTczJYRkh2RENsNGdnV3NGbFlFVXRP?=
 =?utf-8?B?NGJLalJBNXRoQWhmWEVjYWg1WnZ2Z1dYSFpwbnVtUVprVW1mOFM4WW5SaDI2?=
 =?utf-8?B?QXhxWCt3UkNhQlFuS3M5L1JvU2M1cHJ6bnVlMFpIMEVsNEtaNGkxdGx4ZHFE?=
 =?utf-8?B?dlZUbVJIMDIreWVaemcwcWpFaFR0QTN6MGJqOW9KalBuVlpBMU5qQ0EzVWgr?=
 =?utf-8?B?ZVhSR2Z5TUVpNzZjQ3BQQTlMUmlqbk1YVnJuM1V6TGE4eUV6MUlrUkRzZXlx?=
 =?utf-8?B?blVGbThEdEZTRlMweGRTSTBlc0h2UW9BbklTZ0lTMTRIbW12TWp2SitoM0pr?=
 =?utf-8?B?cjl5R2dxYmFUWDhsV0ZlM3dzM2NsajlNcTkxdGpVODFzeWJNdElQS2lOcHB5?=
 =?utf-8?B?aEgrTG95SWRKQ1ZMT2ZTSlRibXlEdElsWFhveTBFc1BPV3JrdXE0U2NIL1VO?=
 =?utf-8?B?anlFc3BBSWhtS2R1S1dKR0VjbVptRTYyeFk1MVJiakR0ZmNJT3FCVWpOZDlv?=
 =?utf-8?B?cXNZSjlBUzgrbWdic204QkJXR05YUENZWFpRVFRmUHpyT1VrSmlmMlpzYjVK?=
 =?utf-8?B?NlQrbXh5cFBRR0xnMk1LV1VvaWE0TkthMkpueTdzOHVWRyt0NERMZzBoWEFG?=
 =?utf-8?B?c1hOWXdpV21idjJ4QVp1eVhleFJNRkRUNmkxcHJFRzhwY2pUK2xQM3laMis3?=
 =?utf-8?B?dTZMYVUzU1hFTkVhckFqaWxXWTU4YlR4M1pKdWlBMWw1WWFmN0ZCTGwxeEV0?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9153496087B0A44B9FB8BE69B015C0F1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WVgw8a5lL9J3EfRSK/c5ak+LKoobThoyoYmR+wrOWa5G9FZWKZOoZt+yPPcM2PduixP/OCvnDaKL07h7IfEZlvkhMQi0tI+aU/ZSb80qVxzLai2CZsbiZltnTuXYiMoDTSCRBU8OJv9qbcmfgjjZUHLleG5Q5ddw93zpoTJ661CJmFp70cizQOpF6SWW72phjViwXsVr/nGnYhz7BNd+5IlR9qBIw/+iOQ+0bXkNXBCplZywbX/FVTIYqtqUQ0DF0BvhRy8oi5eW991n4wEMhuNuKLHAcLW5y8htr/wgoER0v1gDBY8i9FwroNqKl7/7LCWYnUgonruAlfgXwDVM7zFju/LXqwEhklO8978Yy6Yv+rLQOBwyURzfPiBXy/0W09gX905X78amGOVPKJRXei+ZCufNgUEuDIERMlXNbsV0rVMwv+HDGWgRH0yz6Bsvpaf5rRHbStgjDugZxDzEjibywvSS4Lmq2nM1NogsRylDZxZA1+jRXLr21h1VxZbTBz4QYa82ttcDHlMdIWJkl1HCVIv7O43MTBiz5bBOM3zKOSlHvnHoHC5g4MOOUw2NAz4tTblgReGCU9Xy3nC6G4v77mBjI3yx/0wZm12m4bYg7cwW1f8RdxUage9OP7OQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d63af16-c5be-474c-15bd-08ddbf7adb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 06:27:34.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdRjHhopix6+iUTo1sELtat0z4UucdtESKiyBu+1phRGczkLKx/QnUgE1/CRStVnFeP9zM83OBe/p/jSVKW0Le3Vg12p5LJy2RZv6ap0pyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6974

T24gMTAuMDcuMjUgMDY6MjYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiA3LzkvMjUgODo0
NyBQTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gQWRkIHRyYWNlcG9pbnRzIHRvIHpv
bmUgd3JpdGUgcGx1Z2dpbmcgcGx1ZyBhbmQgdW5wbHVnIGV2ZW50cy4NCj4+DQo+PiAgICBrd29y
a2VyL3U5OjMtMTYyICBbMDAwXSBkLi4xLiAyMjMxLjkzOTI3NzogZGlza196b25lX3dwbHVnX2Fk
ZF9iaW86IDgsMCB6b25lIDEyLCBCSU8gNjI5MTQ1NiArIDE0DQo+PiAgICBrd29ya2VyLzA6MUgt
NTkgICBbMDAwXSBkLi4xLiAyMjMxLjkzOTg4NDogYmxrX3pvbmVfd3BsdWdfYmlvOiA4LDAgem9u
ZSAyNCwgQklPIDEyNzc1MTY4ICsgNA0KPiANCj4gVGhpcyBpcyBzaG93aW5nICIrIGJpby0+X19i
aV9ucl9zZWdtZW50cyIsIHdoaWNoIGlzIG9kZC4uLg0KPiBJcyB0aGlzIGludGVudGlvbmFsID8g
V2h5IG5vdCB0aGUgIisgYmlvX3NlY3RvcnMoYmlvKSIgPw0KDQpCZWNhdXNlIEknbSBkdW1iIEkg
Z3Vlc3MuDQo=
