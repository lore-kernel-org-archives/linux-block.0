Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD65145348;
	Tue, 17 Feb 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311722; cv=fail; b=fO8L+P0/b+T1lW/0/BzMzaS4yYNwWZTvJqcwpr8Po0iYSfVu/mSBBf/AYQwetxyqlcfCVkSInWcDRBYWzufRw8LsPMllyb3FMzBetMTCXMGXkrLsjowMr0pDLBimCTXpUaJT9WnrE2o2KZsrWt0l6IMw9bODKcxiHudialoa/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311722; c=relaxed/simple;
	bh=QegscNxwSe2hOfAKYwPUN3BNYDxAuu/06ZIrmg+FKkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JonerepSz9wDLKCe70peFAWw/DZs7kEbA4AjZzV8HyUqD5BgSwdtC9Q6rOXjKWnjeY2T+EsxuSPDkghVflpKBLTlbSOJBbbsCGLQphi3+Yd9zd1hMqcVTUjIzj5wcR/bXrGalEFt79930RSB99mfxHmOs08LUiYqMT8r4CIBsdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VEg6zSAg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dzodu6gJ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VEg6zSAg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dzodu6gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771311721; x=1802847721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QegscNxwSe2hOfAKYwPUN3BNYDxAuu/06ZIrmg+FKkc=;
  b=VEg6zSAg9DRQx1nT2w3knwPJPqwNlQdU12C9emtheIV692UZggsbUnEI
   icrbox3im3oky0zWk6OO1gEZ5RItdh6WA9MsyopGSfDF7u9Ze+mJPS/Fh
   W/dgVa6B5nai22NVRol96gIFZi0ZH/HZKAREqYI1wzpydCLzo8pzdO+lq
   3mKbKgkxSEfvugIGmLNWmuVJAAcPKaj1+Ly4sAO9Y/7pW4syofDqiQt0t
   Tof4qMhrLlTZLsw9KLg4qXeWWsaVL5ADd0I2zxN+mwcd1XtJvOl8xXlFr
   TtXjDhkSKVsdi9U0eC+JaSpYyp+dpAQ3UiPpg/IYDwxj2L/V1XQt6A7hR
   w==;
X-CSE-ConnectionGUID: NGD3SLO2TuSP5kqpkxAttg==
X-CSE-MsgGUID: 32/K4Om1RpWL4BrpjIxTCw==
X-IronPort-AV: E=Sophos;i="6.21,295,1763395200"; 
   d="scan'208";a="142006920"
Received: from mail-westusazon11012067.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.67])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Feb 2026 15:01:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvins4Se+q2uMYvQ0IxjrhV5Gu3SJUWI7GFp93ViekC8QniXceDQLS0aCyAaMrHahRXwlyXfp+KPVsJ47XOu1jaRonXf314LznP7hBGimPWGDC2An9k7RXcwiZWi8mRZzS7PVLQ856TXXz2vgBez9rkbrfye4YIhPDkwD7Os3DswJW4yqd19p9FkwdOJ/QkoZ6C2M3kW5Y1l6/pOM5B8gCkmLudpGVB+HHmhTC6YZz7kWfP6MwRXlYJlxuoHgofiOlcP61wbSGH7dQFXjIhkqn+gY7fVCEsiZmsfW1Mv4MWMwLFkrgwaqtjXgnnEpA2NaGFexMa1v4O0t4MVNBxcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QegscNxwSe2hOfAKYwPUN3BNYDxAuu/06ZIrmg+FKkc=;
 b=c6m/qfUES/xBmS4yTQ30aMWGe4pcOTCbIn5j/1m35iuEp39CSI0F/AL54oj7RgRYhFFcktDL3FdtuQX4yjyO7Mkao0xds9G3xc59NRz2nTT/osuklOxWxbrsy8t7dlrUwY2IX3V5/6NT4sqWebeyvKCXZZUxDjjh6+GwgIVWHai5/X6UP1gNTR+tbBhoNUosj2GvR2LPBF7flonlhFhrAxtn5BdHXDi79SiTTc2TJBDiVoRjg6ofSdy7+QOV2tXrg/V7Imf9RAylRQGl9BqkBIyNULXW0alqx1dTek+173NtIijq6CSksHG8jh0sSSo9Q9bX7l7fD3PonsNadAyVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QegscNxwSe2hOfAKYwPUN3BNYDxAuu/06ZIrmg+FKkc=;
 b=dzodu6gJJM6sbfETHmPdSJgnCGLUzC5pjttBHo2cfrilfJN8RW4fJrUAXtjrZt9T0UK/Y51dTJQTIKCfe5hWv8zaxlUwciUCHvHKZ0RrapVDJVMYrEPVKD+qew40caPITQh0f5J+a7MB7Yg+c+7x2LeerLFzrVXOLpqwkXsWnTU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ2PR04MB8962.namprd04.prod.outlook.com (2603:10b6:a03:55f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 07:01:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9611.008; Tue, 17 Feb 2026
 07:01:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai@fnnas.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "nilay@linux.ibm.com"
	<nilay@linux.ibm.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>, hch
	<hch@lst.de>, "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Thread-Topic: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Thread-Index: AQHcnXTtoi1VAk+6qUWZ+Fw3NN1xPLWGe6kA
Date: Tue, 17 Feb 2026 07:01:51 +0000
Message-ID: <aZQHcyYutHqrqGYl@shinmob>
References: <20260214054350.2322436-1-yukuai@fnnas.com>
In-Reply-To: <20260214054350.2322436-1-yukuai@fnnas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ2PR04MB8962:EE_
x-ms-office365-filtering-correlation-id: 86ae38a5-881a-41d1-fc31-08de6df26d10
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TXX+Q1B5mO3K290y0frTAilPohVYnGCG+99DjFhaq1MXcwcFE0xTMe7GRecK?=
 =?us-ascii?Q?JPBFHDnuKANISANYYgc56J6ktJla3E5OzswKOpGvDBOVJ/UjBNoIZx8/VdEf?=
 =?us-ascii?Q?+/B2tZfUN7ls1652kXhXvsNnfLe5SI1UTf6ruiloNnjZnaIDgxcXWkndD6B7?=
 =?us-ascii?Q?jk9rJl/0PH/HwVr1kJoRySdlEswdYFHKuR+slQdIIs2lMzcVGw5LnDc04gS4?=
 =?us-ascii?Q?Zh/ISciXkQUfwcZ2aHr471OF1dquTdSXpV2kf+vMC/CI3YVMHBnNAYABzr+Y?=
 =?us-ascii?Q?T7R495WVOniJLlWK31W2ANxD7pmElPuSBCTFvubXsx2+4U8+CXVReW8TNOo0?=
 =?us-ascii?Q?Sqel7+ShfE43qmwW646LKpjKGg8Jh8ptCkCceA1Xlbfb5APx3XCOPBKBPPq1?=
 =?us-ascii?Q?XpMhH9/a+Ng7LHGDqnFYjV3kZG658E2Omyxu6VhHUyXfnvCGqSWIKZ+rVI/I?=
 =?us-ascii?Q?tU03BgqX2irBCu+wF7505b1FK60zUChfbidW9/rRvAEQPSTXNro1vVjLe4/N?=
 =?us-ascii?Q?m54rU3/H5tf1UCwyzcXU8EIomD5Rz91Yw0I/FF/VK0CmNjIrZauSnuE9S5uo?=
 =?us-ascii?Q?TTxCJZZ4aZmkLFENR8csATqFsGL8OV1C1v2gnrSR6arojW2xAee6ROB3IBTR?=
 =?us-ascii?Q?6Z9oDcUMLKXAibG8jSgDGQHfnCiXK4mdL0eSZqRKEuW2F5KAIUXyqOlz0c9p?=
 =?us-ascii?Q?6yo49mvhENMt6SDBIRSpOxSKL6NdJMQfntw8r0TCAskxVdcIe31vaK81o+zs?=
 =?us-ascii?Q?iLGL6hevmTx/1NPGEFlwDrHaBw7OebfhMDclMg8hQZOtZXCgpg5CwmP6Ku/4?=
 =?us-ascii?Q?IDvBgd3muZOvmCo96GseQewBCT43L9f1kgRC28EAo4kX08jzS4fiYUXndmpk?=
 =?us-ascii?Q?3Me/57/qjL57lg2QGFg4GlXKbtNxcy9MHCQ42/iui7TH4ntvHVk1uZBl26vF?=
 =?us-ascii?Q?4cX6Yuj/llpeJTToHDCyumubAZBgn/5NsVUfHBz2DfBE8P8/ZpETJ7GvzLPe?=
 =?us-ascii?Q?W/3ozSR3lFAOVTW9lQkhRhVlXdr452122BoL757cOUzLJjIjr4TamsF6snPN?=
 =?us-ascii?Q?qvgrxbDNIqHK1g3xRPlmVzUhhG21fd0cwSFXQMElnQrt2mJpmaaPcd1RxKyQ?=
 =?us-ascii?Q?ItWK6NjHz6mKul5lVc6qYyHphdHFHXi3sxdWyYQYERKCKeDQ2fHVhwBwyVWT?=
 =?us-ascii?Q?HEW53QJnlMCpwvJWGqAeBNDgF81O9uT0cj+AuUvoN67Ss48/0+QBxbd58GkH?=
 =?us-ascii?Q?Bf86nVlL+s/eEpjHmhCH4dcWi8aGcFUsfPX5r++m7p76trpiV18t6+Y5XUTQ?=
 =?us-ascii?Q?BBBvQcrd0s5qvwKYtOsPKTw62iIhskcei60GEAgVB09ZwogGW/4BF+ykVNlH?=
 =?us-ascii?Q?EludQqwiFHbwn82UzqCx1OnJ4dm45Uqjm46ZFJOgSmLhzgKn6YlYwU+AnF4T?=
 =?us-ascii?Q?aQQIeaJOkhr4N45FWBo52AzcIcJK9BI73SnnHZiv6dpj9+eDvHSUE3Q6WM+k?=
 =?us-ascii?Q?crJKUGabPG+vbvLA/NXfsOFfnaNFntJ3DwddNHpAzwQAZXlzl3fL8nidVzYj?=
 =?us-ascii?Q?tsDMgPL/7C8XW1J7/J05/k4c+Yp0JXP8usAA2gS9096dm/STM7upfbi/BOsd?=
 =?us-ascii?Q?36Bx1wquJFOshBaVWWLoJNYMHfoziysBP4DW379Ga17c?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tcwm1S2CYOqvP12Daw2Ll4+/VXkxyYa/uNCS1tU1vjXD4KwkXSSuqkZ69eYz?=
 =?us-ascii?Q?ytkWewFoQDPl/e8wOn9SQ5HWLOyiu6voTvc8ldtNkrAIWZsbBup80VgNMQKs?=
 =?us-ascii?Q?YZsm+Z8gDp2haSYlxH6b7oP/0eNXkJLFS3lk7EKnjGDqFlRBiXWnJqynSK5D?=
 =?us-ascii?Q?Ebwcr8YW9tog5sHQBGCB82BYELCfm134pnaDNjEUVi0zDikNBTjtMsV4hP+w?=
 =?us-ascii?Q?abkeb6nDIwd+7v1Hb9aCBPK0AyMoQFg99lKj4jv82aP3QnZ+loqYbdGTrVls?=
 =?us-ascii?Q?bl76RxVrkO1let0BQb/OwE8NQt4G72R/wnowmZSkfkXTgum2jjfvJ2sVmLmH?=
 =?us-ascii?Q?h+VFiElgjv2gKDkGNM9KE3DnFCtU6UkdzT4z4OWCTIodzr2GEssn1LWljBG5?=
 =?us-ascii?Q?nWI5SnCPhngFNhupCUbgAvYF5vPAaEXRZgdex9LzNuWlWs6dr4yJZdshCMvP?=
 =?us-ascii?Q?poWTZfnt4yQdByoHS5sgMU3132nnA97F0TZg7ocoHEDAQhS3kEEX5vjaw3rk?=
 =?us-ascii?Q?ETRbH9QKQ54jqaexwWqQj2yCWNlb9s0f0zHFhJYHPkqzd+wN5Z6HrK/ndfU0?=
 =?us-ascii?Q?qNubuzlEZDSvKn1ZQkD2QVR42GGSFJvc5K9s7jo+weZJ4Lq4kTfW7P2qSoEI?=
 =?us-ascii?Q?gdEEFz7RKSbvW4nalGzy6/xYxqZRj0gmfLdgu++MawLem6C7mGDXYLttWMCt?=
 =?us-ascii?Q?LDClPUpmyRgU6u7jTFXR/VnMyTsfs1QbwUJreG/8ww5LTScCUTAN2Kd7rjCg?=
 =?us-ascii?Q?O5eBxv926dyOp2nqZBPwnL45fg5TvI+eDw4iUcUtazEyr6R65FCc09wVmCfs?=
 =?us-ascii?Q?jPndAgVPet6FR9lJ8Gu9X1zTBx17QjjgnfBTbtpKCP35HJgVD2WYKc+gA3lW?=
 =?us-ascii?Q?55IxnG8J8D5VhPXuxZ/KBR8DS+jue4tUFHLoqnLpcSY5NchHvHpmmKFH1us0?=
 =?us-ascii?Q?MTP/21UiL01Rc2iD6hQF7qSorblNeA147GJoo32T4DFiV4zY0ADZu24nwtVB?=
 =?us-ascii?Q?R25lkokGk22HtBuTzDMPYg7ZHPnysbPYcHX9IKGloeFRTqKNln4u10c97BGF?=
 =?us-ascii?Q?aIr9Oxb7OnUH08/bu4TeSY0OWRPLkheUl8P3Sp669XhNTWesaXYEh7ZOub6T?=
 =?us-ascii?Q?f1JFG09mXHj7GwfWGGf0nMuFPTF89p4wXQ2nDrSdo3xPY6F+WyX7A3IisEJC?=
 =?us-ascii?Q?+3uibvVA5D+wOKw7ZLkbdF/F3kBPo0kN9AmHpGEia940vjy7KKLGLA1qPyMT?=
 =?us-ascii?Q?EOhJV08XXpRkuEgrXqjNjxOk9NDJpJhzyu+ugjwQrbnNFylBQlCPjKibarv+?=
 =?us-ascii?Q?RRJYLuPolxBaS39ey/js04VZgRi5qZhAfvMGNPLA9Vvz9rnjVYUJzc7coKaE?=
 =?us-ascii?Q?EsNknPt5/PRsvP3wBfpsfDJwF1Q3XptR87YvIupHlaQ2kg6Zp3UmeDagTQAi?=
 =?us-ascii?Q?RVmat6l0OzPkphEgIrSofcmsFTQtTVKyOH3yv8BQ9x8vZcpV/6rYskryeCBb?=
 =?us-ascii?Q?2owNHdRAuxE35YqClvPpIzcAsIeyy5+l1Nx+PnijFCIYPv5dwll8Gv5sg85v?=
 =?us-ascii?Q?8z0/6TvjlIIis0voB0lVHeBznTl/ANTbrttRAYNvQWGA2/6lXUALPNqWIQSY?=
 =?us-ascii?Q?g4KWHyo02TVDzec4T4n5t0vH+A5v03pWo8j8Iea1B6mgnz+yYSdBjxzp/pr8?=
 =?us-ascii?Q?tyVGjEEb0YaE6gWVfo1HpZ1fMzVuhicEE9++eXqpchVzAe0Bl525c/LfjSRy?=
 =?us-ascii?Q?e1BJBZPIInmmxo8XFFDWWIB98rfQvtM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <167871B9E5E1F647BB350ECC02049B4F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	36wQ0qNSlmSymfZHXnaKyET8nFffo3IfCTdUe4x9GiUB7HiyTjCJtTvwrZM9rgIbeIi4+qPyHRLxtK0/HnI2sKrIMSFt+JQtZz7DmsTpqUH9MO+RH477NeRVA4qZSEcHBwTzqJWEgtL9oNi6mjRRWxzXTDkPQmJURbEzZeQG9CJfCiL5rcDH7jeLHMxVaV9PX74a5iK0iyTJygQNBXNJmrD/TavdN/xfCnGK/BNHJns6oXi4UlnikUySifgx/wxRe6Ai9D0a6pIZ0ZNi1ahZGpSUj9lqgr2ajA3NHIJfyE5SI9zzgJzgxpOiTY2sShWxi95qZcHJkhTvj4isjLy5Kq389kzyA5omqj1rSwICK9qqzZtPbD3fwp5LIkca8Iavi1FMxVI5wVe2Y9pUWD4LJc2QznYGbN8nGQVa4zycLxFtCJzbPuUcs40Ha96lV4dGo7mM3Lgjm6U0SUit3iGCHtz2FZOUvO5m+BfCB0Ylhqx/gM/+p50HOa9/NPiHEhK+jDewBiKItPF3ZMWqF2PCeWFEWvFUrVczYtBjM1FzYYl413VJUEXdnQ57rEEkj80atu8XQT+43B7jVeg9eZbsOTY61sZDfHsETExR6M++s/LXWJfFvoMNctKYGleDICdZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ae38a5-881a-41d1-fc31-08de6df26d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 07:01:51.2372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qv5ijjXXR26Wzvp2FZIPArsKlAB9qRuyCjdAtA+Sw2lgc5PnSlquMYV+oD9rygr7Pxa6l3CvSPqZ9NJQ7A+sKHd1QMXTF1KYvnSuxJ2BHDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8962

On Feb 14, 2026 / 13:43, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
>=20
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
>=20
> Introduce blk_debugfs_lock()/blk_debugfs_unlock() helpers that combine
> the debugfs_mutex with memalloc_noio_save()/restore() to prevent fs
> reclaim from triggering block I/O. Also add blk_debugfs_lock_nomemsave()
> and blk_debugfs_unlock_nomemrestore() variants for callers that don't
> need NOIO protection (e.g., debugfs removal or read-only operations).
>=20
> Replace all raw debugfs_mutex lock/unlock pairs with these helpers,
> using the _nomemsave/_nomemrestore variants where appropriate.
>=20
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO=
2wjpfOYeM-RV=3DA@mail.gmail.com/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Yu, thank you for fixing this. I applied this patch on top of the kernel
next-20260211 and confirmed that the WARN is no longer reported for the
test case zbd/012. I also ran whole blktests and observed no regression.

Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
