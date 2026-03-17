Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB452C1595
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754857; cv=fail; b=Z9aZuKD85Uxfr4cg8gvGW6azCBg9r3Su2HK1g7BEoBWIgWSoXmCb7c4k29onX2I7E0sRdlg7VU7uE+VhBPM6dE4sfVKfYZAXgzOZSlfDQMuuJFTCuc/hV7OFrwRyUP00CjmEQ/bjLYRKGSTedIF8MtzfQzUfLsfmTGQ3LIp1Zgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754857; c=relaxed/simple;
	bh=V/gVJbFpmBohaa0M286nIS8WXO379ulACjNr5s9AAbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q13xHM70B/ddfs3B3blTeyJemdX1MHvCPUCYRg+MNuSB6oIrDkzJSxEoy9zyv5XObTRCzrGIBKyao5ztzXSWKJqcAkfDz0XJMFqqUyeGP9S98FkKRreJzBHh4oOB84zYdmV07jW5jqItP7yXYVtAIlBRnTECSCja8cx8CaP9wvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A+ThYLFr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KfHSsZ0V; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A+ThYLFr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KfHSsZ0V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773754856; x=1805290856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V/gVJbFpmBohaa0M286nIS8WXO379ulACjNr5s9AAbI=;
  b=A+ThYLFrbXYmQaZxolk1mxTcKDxHYkfRI83jlw7Pluefvfhshjn4GIq9
   Yq+frcWSCAEKwFIxnmLQPhkJxgKM/Uh12VzOlwCSIhfIArj906t9m8Ne5
   bRr8FvZp5GAzXhUjXMJrtx0Ox0F8phqVJnEw7TyR5od2aGh//4jrtLOCu
   T46vH1odQ8A563tlg+nrFYBChqGN7uF6LoMS7tR8vCvXV1hrFFcAXQihB
   USYBFx/Fnqp/ZqOBwAk7aJIohvBCj8ICK9vJOhQP7w51gorQmUNhQ0tIy
   CR57Nky18MUhzK/TlNAbS7AUknI77p4h1G9q/pfwaiBT2O7YneEV2zjTN
   g==;
X-CSE-ConnectionGUID: y1H8rr4yQrS2kWAZEbZKVQ==
X-CSE-MsgGUID: KU6Ke6uVSmq2cZ7bVbWBDA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="139036374"
Received: from mail-northcentralusazon11012021.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 21:40:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajwuL5/TOrXmiMFBlg4yF8W1eAF78TQVRtU2JhIFIC4D6eNyn/NGxoByiAqD6Bq8L7wtv2D+JaxQkhpVKRY01OnbzFIF8GivZ4CwZl/M17Yp4szRQKoiLah9mTxB4Sf1MGmZHj5vMONQuWx46ifWX1RFKbMnUh5WEdFput8EnaesiMBDTkB7k+eSwqYpNFAIwGue2uTNpzGc2gEz/y43GncAOW99mkgH/+7QJ5wbCGWcAD79CAfFHg5N1wOiBxIKuSxvxauylTqOEmtIjr0Jmugim7S7MHkfu8wLg0yjNoFTz4OfG20fOJ4N6StR7EV3YyULbxUCvoYIYFEJ1LnFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/gVJbFpmBohaa0M286nIS8WXO379ulACjNr5s9AAbI=;
 b=MPVJ9siFGHepOHkWD2e4w3ujtZvpGmt5Nje9A/KXC1/BXY6HQ1TnjHKXWQB9ONKth+f46YVJgEY18PUwkfJceWUbDBbbbVC3z3reTcE2q3lve8aLwtMl24BjmMu0uSaeQz5FmFCMFh4SFD6s7VZ3kx9E3PVmKLJY++Qpfa/4mOSEbNjzJ/2oEoQNxPbLf0gcvVJuRKl2pVfJEu3GZNQ+ZVtVwWq1Y7SZmNzZjal4KF8dQJyrRGXA+y5eGNcSibjEwEJ5cDvAqgs7zWMEf/14IZwthB2bBmRyd9fRlY2/DxeevqPDrosBqyAZ2d4s52/VXGaAxj5hKKLylQnaBBmRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/gVJbFpmBohaa0M286nIS8WXO379ulACjNr5s9AAbI=;
 b=KfHSsZ0VDIKtU1Uvxf89zMGnUr4ZkDT40G0jhk3IN+gkT2/cfH4AXxKB9z8lKmIXC12xIKapjIh9wkkrF18vrxgP7UUt+5hC/wAQ5KsJeLghlQQ6F5C40b/ZdLPXIGWt+ouoLr1we4kM7DQy+eFc/ydglixDF9j6y42noTWqG44=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7801.namprd04.prod.outlook.com (2603:10b6:510:ef::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 13:40:35 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 13:40:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block: remove bvec_free
Thread-Topic: [PATCH 3/3] block: remove bvec_free
Thread-Index: AQHctWBGXIV9nF4sAEmkGo7tZwKA5bWyvI0A
Date: Tue, 17 Mar 2026 13:40:45 +0000
Message-ID: <5b6f5531-bfc1-491c-b24e-802987e44c90@wdc.com>
References: <20260316161144.1607877-1-hch@lst.de>
 <20260316161144.1607877-4-hch@lst.de>
In-Reply-To: <20260316161144.1607877-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7801:EE_
x-ms-office365-filtering-correlation-id: 60c1f53e-9b9b-4284-105e-08de842aca5c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 omIjzhTpWqlAczangU0XlM1iewMzURuuBVO1qGbKt5rzCNZLAGNP6fpaREJoXO4OHm7vdH1gko9oYFAgsZKccek8UBbOLYB21I1BUA9w2xCobM+CDgZ6yDH5v6jLmigNJXDEDkzPQad2ir5z8p4Ud7zSQ3N4YozGWJE6pZ5BqMuz+74kN3mMFbVv1DTztK1B1LremTvmC+6Z2fzR3ZhTI397LDACTAaMAKfsZ7yAwmYovEhWvafVMBXOtA/J+8hBy4Lkn9/64E+TDc8zc7i3zCMLctP7tGStUrHGPgJAKqAGrqrzhtx9w1Zjs2dOinCdjkv8djzO73umdIOihBqIzS1Z88agsRVvxTGosynzioVORL7GRQ73TLzOeHE5DiqHZ6kSBXqjWe3FQYvDxkUeaHY7bQTS0lRhKxeof3zVDoq7pmDKd+BKLe2OI6ZKhJvhdPfBaPE/PWamSZ7Y4uihDken1Zc1oNuVFsOuCayyyO+OIHph6p5y7YDuXADDaa+BB2Jqul7s4PmaB5RLHNwwF/Fr37hj4rdsTf/EZBXkurl8LYWYXJXypZqslTvjGJeop3gbMRuJD2ZZKMpVPxB9KdMSnUMndZG/TG3/Odh6JkgvvFmrTg/KMCxma6ahMAheq5Oww6Ntt3fX3hn2nV5EXspDB4fj5WMNCWmdEuBmE0QgUs1L8NQWybTlC85qlrPL9+xiy06rEi2f9qt4QrB0VGbrEhc9e0HDlnmB8nkKdwTjAkJK+QyZ0oZn0WGuMd32dLPYfemIO/vxowOB0EyPPMXVW4bKjH6/iBkG5LlUMdE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUxRTTFnbWxiMldBZzlsK2IwY01LNUxDbExSd3JQczZ4UWNaS1NFekdieUVW?=
 =?utf-8?B?dmY1Q0NzUTlWcVM5QkxIb3B3QmpFSnM5Ulo1MkI0T3V4YTQyVERiU1grZVlk?=
 =?utf-8?B?WFhWN29pdWpOamE2c1Z1Nnl2M3NlMzBtMU90WXdIaU5aTzlIa1pNUFMzcTRV?=
 =?utf-8?B?K1dqUHNvS0pWZ3NyaGlSNytCR2xmT0dDYUYyek5BWHJyWFFrNkhWb2NqWjd4?=
 =?utf-8?B?L1VoSXZremo1N1JWaVRRRkREcG5vejJUNWx3KzJabUdQdkdTaEdaNnVWcWVC?=
 =?utf-8?B?QUlsT2gwMUFYcURWSFJwQ01nblQ5TjRPZjczSjdQd1VhN3R1YS9jMFh6V0Rn?=
 =?utf-8?B?ZXp6VUNRSkl6N1J6RTZoNEtESk15N2tTU3p0Uk03N0ppL0VnQ1Nxa0xCUFBP?=
 =?utf-8?B?RFF5ZnRpZFBXNHNldXRsRUh6VEM0bDZMV1VEQTNWWU85SVRPQ3pPQzBHcjJ6?=
 =?utf-8?B?SklKOCtKMmVaelFib0FtSjFFYmVvQ2RYOW5SQ3hsNTZPVWxCSkxNWHBYZGpD?=
 =?utf-8?B?QXoyTHBEam9tR3k5bUk0THp5OFViOUs0MnR3MGtyeDlFMHRIRlVnVjJ0MjZL?=
 =?utf-8?B?d0JPMkFnS1E2d1h4c1dGd0xJbmEvZE5oUDE2bWxFVXJGVkZFU1BLdXhlVFY5?=
 =?utf-8?B?dmxtdHVMY3A2cEFrL3BBZHk2emFFVFI1WkVpam5DWGRJR2pRSjhrR29nZmFu?=
 =?utf-8?B?dmJDTHZqazI5QUw4RVJBOWMxdTJuWlk4Y2NOUWExZUl5eTJER2JuZ1dITkJw?=
 =?utf-8?B?QkMrMElJenZsb0VoWTgyWTMyMjdob0Fwck1ZVW5GaEZNU25WbFhNREZndW1P?=
 =?utf-8?B?bHorL0I5RHNSaTdiQU9sVXF5VldXY3JMRE05bjNDYUw4cW1RR1lZVWlINTdr?=
 =?utf-8?B?dVNOcm5aSm5RY2RaWlNWWWkyWUlFZ2R6enRRaTZwa2krMWhXM0NIRVBQMGRO?=
 =?utf-8?B?UzhaOXVpV3NvQkpDekxtb1VnandSR2JXbE83eW94aXphVXphMDNjTXdFSzMr?=
 =?utf-8?B?RWc5a3hrdXl2MC9XbWtqVDVjeGJIeDQxeENyQXhEc01YbXdlckh2OXUrdmNV?=
 =?utf-8?B?ZUZlTWFRdk51cXhVM1pxYnlwRklqRHVzelh1OTN1NDhPUmIvM2Z6VUMzNVBp?=
 =?utf-8?B?dHo5ZXFHYW5ZTk9DYWt1SmphM0pVczlSZU8vOVpiV00zbzJnUEY4citxMEww?=
 =?utf-8?B?bnZNV0pVbHpDRCtSSXdXek9JNWVEQXJVeU5YYUMxZm1ZYlNoQlRJZjMxaDJZ?=
 =?utf-8?B?b29IeFhTaExZMys5cjNvRWpUaWhlYXlVbjNZK3RMNHZWSWtzNEFSVStBZWY1?=
 =?utf-8?B?WlUrTGdZOU5SanU4V2xFakpJUFluOG8zaGVkSmIvOExxa09lTDJFa2U0OVp0?=
 =?utf-8?B?RjhoZVdXNisxQ1J4OXFtNWhhd2RkK1RHYzVCa0pENTdNNFpDUDdjME1UOUt6?=
 =?utf-8?B?NU9lQldvNGdTQ2JLdU9LQ2dTbTl4ZmRiOElISm9pK1N4NjVieGxZc1FnbVA0?=
 =?utf-8?B?ditoTTlLdUladWdsVlAwNW83RmMyUFFlYlI5anQrSU53UEMyZ3UxOVRINHNC?=
 =?utf-8?B?YzVzK0VMNjlSZmNiUkdzSEJFWW5RR1RCUlJKTnAvOWFhd1k5RFZmd0wwT21v?=
 =?utf-8?B?b2xNejBOUzZlemFMN3U3b1RFcEt0UDdKa1R2QkYzM203L05Ncjcxcy9xbDJi?=
 =?utf-8?B?N0pTaVhCeE9rS3lxcVc4QVM4N09SQnRjTVV2ekQvMERXaU5CQjhUZ1ZOZ3Jl?=
 =?utf-8?B?amlzMkNwVVpRMjdWTEUwUy9kZ09tTTNqekc0M28yZWwvcE5wbTd6aHJFbjVY?=
 =?utf-8?B?eEdxTEQrL2dnS3pHZWhTNnhEaXFUTGgvbUtpcnRGVGo4OExIUEFYUTluY3pM?=
 =?utf-8?B?Sm9kcnh5VW92TDdVek84UnVZc01lcDZIUGVBWHl4QkRuS0ZtTUlCR3RSVEZK?=
 =?utf-8?B?b2pBU2tlTWpmSnZsdWZiZkxDMVR2ZmpIUytoWjIrOVNSaWtSTEZuT0g4ZnFK?=
 =?utf-8?B?bzdsYXRzSFZKUXJlRkVKMGNWcXFXVWk1TzRXMUx2dFhlbDRmaU45SGNIMjI3?=
 =?utf-8?B?NzcrWjd0Nmc2cVpnQlI4cGNWazdwUlgzSkZhVFQvMXdDSU0yU2c0dEZoRXpt?=
 =?utf-8?B?blJCWjNQUzZ6VmJQMlhSSHhYaGlSeC96SHBjSkFNU3E0WDFablBlei9POFMv?=
 =?utf-8?B?L1dVT2gzZS9POW9RM2ZRSzFVeUF5ZUxCRld3SEVkUWNOYnZHd0w5N1MwcEpa?=
 =?utf-8?B?V1YxbTlGUW9RcFZQRFM2eTB0d085QTIwdGl2ZU9oZUNyTkphMGpRUklzOC8z?=
 =?utf-8?B?NzVhNkYyUHZERTNDM3U4emVyK09EbHdPbUtTK0NIVndkS2owMXJSb0dneWFx?=
 =?utf-8?Q?Jtfl/55fupJduRA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0321E9C6FF7C940BF5F9C61A639D11C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gGpRkJZB3cxw32uPf9HgJsKxbYLyOpIGNHVboRLSv1hN3Tp5S5QQUBVSwMSVqJIJrE/jDWR0zu3ogOfexicioyBu7k/doOn/uoeb4vp6GDmRrt1YO7aSfe8JoK3kd09SY2IDg56syxATFe+5Vu9iPa+oMM5DVrtA0R5jT6bf5WzXUd4ENo7FzSpfDSjtTJ6A91f3EeRA98W7CtSoebiLx+bXDHxQNHCF1kPQok0mxf0SZB8z+24IyluM8s3ez+PECUNW3t/Q9YwYrSjw7xHcueunxauPq9NPIMutIDDmis6dwF6PFHYEslO/uDWwkyyPyPm1HCiqmSeULLU7pWZadw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OLtK4RddyvAoqofaqfzNbqEJBYk5gtxaENkVWdPe0MqWQ1jwyx1tK1cdDEKqGTuZEet7p4+9yIuHQ4K+qnp7YIiA287DaJLxPBChCfS2GVXsCq1rOiqWQyh3bZwGcE/SLJ15ecqtPIRgVG8L32wAfpybkWj0qsp1TWCaPe+ec0kW57NVJp25SmoeQoFxXOmh8k5xYhILRZyxPPR5DMMJ/iauVkxUXQMZ3nKBk1ig6HzcUlDVNbU/zHnv1zuQBw+JHeSZlxzWYIvxSOLwp2WTuY0a8t3jVLBpEV18O7xpaCiexR1gc+NBlVln4C2+ISg8om/ta5lRAf7HRhxuuxB/R+I0PJLiOZlWGHxamkTYzTuF6+HxpDjhgaeqgTCnLydqFx+ULoJx8xox4adcH0zQaKhDN/mQtKYifI33RKCWkfosqcfN/EqvH0bqk/Ur0pnu5aspyFIABAzycSpre2Cd6rGApKo3x+K3IoA2CdPTx1sSrNC8J86H/AHafxv2hXB9o7JHCfgv10194gHxSPr+iRy8iidp7dXT1PlZ2xICPHm4cK4iSyQLwOodK9TjOGYizj5C8Ow4Skog+wE2vNQKZjlNDOfg+z1B26lwbNmlYx3W5NLqlpKNd2oWv2o4vNh8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c1f53e-9b9b-4284-105e-08de842aca5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 13:40:45.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCk/b4kkrxEdBxicZOp1B7fs0fNabIt+bJJh+lnnVxIEubRrmYaXm4Lvu3Leap7GULpqnq8UQa7iwX9I5vFnXfGkD6TXXBZlREUV+gi3jQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7801

U2FtZSBhcyB3aXRoIDEvMywgSSB0aGluayB0aGlzIGNhbiBnbyBpbiBvbiBpdCdzIG93bi4NCg0K
UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCg==
