Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00C22F16E
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476992; cv=fail; b=jc79rqwRpQPI8KIROJOu66fEHcpX2NFpeCPxgF+SofnJaecTumPKkb05AilaEGTuIeN2UjhAZod7M1aFn3C4fUwq0YtgWUGZ9PO7VA4GgC6efoqObJBk5t0ADEn9chIYDXw8Wy1b+XyMMwraMBX1zmCfyiMvAfs8oXfg020puL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476992; c=relaxed/simple;
	bh=ejhKtZuBlUqO1m99oTrc0hAJlqIoYeq/LGXuJP5KkXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnFbQtBLwmBi75z+ND9/XdEelHro1/gC6UuatAt/TD1IZSP0GQjYCoo5R7HPzD9lD3cBU+24BFJ3qrb5yGZxdBrxriOqabRogCK33MzMKSXRrtQ14oyNZUydxplv/ArgwZ0PyYUhiwVWraxuSRtvXOIqruVGM865P6gjirE96Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AzGQzhni; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hMxyTqEW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AzGQzhni";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hMxyTqEW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752476990; x=1784012990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ejhKtZuBlUqO1m99oTrc0hAJlqIoYeq/LGXuJP5KkXg=;
  b=AzGQzhniiiYbd3qFtiOnsOAykjFQ/qW4R702L2ba78UoRzV8i3XRhFQ1
   N1tCy0/w6IXOKdSBz21w9WlkI+OLCT1NVXTA3do7RJfxmbbYUCkdM07iD
   Iyln8VE9XvkF8YRXkCCN0HKtbqfsbUKO7uqYylRDpmAZqH3d3/CaRUIdR
   KP+a3/6s52ExFBDTMjUVg2sRcd33P/IGyXYWMAmewaKtuOdJjJk9m0R+1
   B4MdYieBh9PGkidw0E+k0UjIdMlEvMFLOMuzzLhbd3qkKR4GUmav6iipb
   stNyyWDBPzRh0gQhKgUhMIoLq/mEG4U8HoF/sMe6fLlzGij/L/ZzpEvrG
   g==;
X-CSE-ConnectionGUID: P+ge3sMeSnq+Kin5RKtTHA==
X-CSE-MsgGUID: qwgBfjFcREO25/UUu5dd9w==
X-IronPort-AV: E=Sophos;i="6.16,310,1744041600"; 
   d="scan'208";a="92913634"
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.88])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 15:09:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDHldQokkgzb5B0usjJ14Xg1oY5iQCDa/wL0jmHSQ20qGfI6K2MPviJvAVLAHT3SU7OW5+Ft7Mgkdy0RALmwzRkVqIhFP3HDpNaEvJX14Q2PvC2eWXoLqSIksDeL/2NrwpsvMjFa/M+EJmM9OP5xLjudlBrylpbTqtNvU4aDLb5fj4b/dZxtHkx2cych+9y8Tpht0q9inmIRjTA20qcIYZPznXy/0GJfJtukzb/064MFHRO4Ez9RFL1xs8j3fuCap+YV38Knl5VJTYS5aH61CO6axLNMo0VlC8QjlBydtDal9RNcVYtAwbpBAdvDJETHYaX0cYfpRMUz/G60U5/BLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcYoRB6AQyN/SbiFfkQhlnin5C4mDPN8RgMNvKhkpyQ=;
 b=Jo3oQL1GFmVlnlLOus9k4oTI8dk2eY8qzmTBm5yLFdm+nig9lzzScXkrLtU3jKXGvaEPF28/q6XiCmhlA6NuU8uvR/ajNt4EHsL2wCIfSu8TewnncjFzRwrNApM6bU+UZHd064OejbIACdHygV9xd78e+tZJ7NQ6bSM7c9RFQ2ypMHEf768H6ZjzgE2v7xC6AAjgB9G0edowSRMGTulCzvWxPDlA65gKvS5YcM80UnJa/gT0zUHmRBE/SeNzRoiwVp8P66aVPhjbD3s061aiETBxZd/eZAu+MUPXHqkzt1DtgJ1yCDY2bPITVwLgdrHl+YyyuKoi0P407zEiLuSbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcYoRB6AQyN/SbiFfkQhlnin5C4mDPN8RgMNvKhkpyQ=;
 b=hMxyTqEWoHZ1NFsudBgjjVY3mouhdBkSuE2FcygRCoXe1in2AgVkuSj2eX6wRSB9K15tSHg31ZAkTUwyK9GUHWT5wCBKtwcqxav8G8CpzFCpW+J1TbV32mxLcbrW8A3aFYbnU8FTcxHyfFTLyLGmHFohLF7b1E83C161v2gkIZU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH4PR04MB9155.namprd04.prod.outlook.com (2603:10b6:610:226::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:09:39 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Mon, 14 Jul 2025
 07:09:39 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Alan Adamson <alan.adamson@oracle.com>, John Garry
	<john.g.garry@oracle.com>, Yi Zhang <yi.zhang@redhat.com>, Bart Van Assche
	<bvanassche@acm.org>, Gulam Mohamed <gulam.mohamed@oracle.com>, Daniel Wagner
	<dwagner@suse.de>
Subject: Re: [PATCH blktests] loop/010: drain udev events after test
Thread-Topic: [PATCH blktests] loop/010: drain udev events after test
Thread-Index: AQHb9I09toVb8pO2h0OhtfsAK1jtU7QxM2sA
Date: Mon, 14 Jul 2025 07:09:39 +0000
Message-ID: <auydt3njlbdh3ths3hzyiew46svwxxtd37dxzjbeyoqfk5n533@mpm2seuds26o>
References: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH4PR04MB9155:EE_
x-ms-office365-filtering-correlation-id: a3b31857-2739-4239-2a65-08ddc2a56619
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O/HYDNPmFg9Te30SBhWaEcY6AnzsweGCHfziibt/3ONuJyfVpdrfawANuWB7?=
 =?us-ascii?Q?ukQ/rzeJY/X3lkbsF0FWfuZR7X7N+tlIBU1CAUJKbm9rSgy0EVIKwHXixlSb?=
 =?us-ascii?Q?TufWsEDOtsSxMnY5QqYOT5M4IvW5NIADTS1RE45M1WU/YgVaMjfgk47zsZHu?=
 =?us-ascii?Q?i5Q39kgUSLb4EvI3mgs/Eh7BoNuAqvkLgbbiKqsyIEmf3v5r2Q/3lAjOvvDw?=
 =?us-ascii?Q?D7iL7XEYQw2VwfJDSqgORzH3nfUgcdTFKme1XAfAA3W0QbXp7EsS8CpzkmfT?=
 =?us-ascii?Q?jHqR5NJiPCGGINR6pguy3XZbFTqo3eN4L5fqPBNzHU+soRIIYZ2D6gEjimrO?=
 =?us-ascii?Q?DVK54sEAmDxBoTZonU7eC0403TGJlBmacOQVialZc2LQjGuVyLefO3Ap5o3R?=
 =?us-ascii?Q?LPFqA5At/nHdFX+27jpZXcOOBosVwTZUkU5yjYOD+Y1mAxfgrDwBOwNNAoaO?=
 =?us-ascii?Q?aOCudOxCmJVGp6Ib+n8j8TOIHdeKPZYUp8yCFGfjefrIN0KPX8UoojpmrgZt?=
 =?us-ascii?Q?Nt6pIK8uIKGh6J707rcDUvFOZAVLqehTV/xMvAvESPbZRgt9Qm7YhLXK1ZZW?=
 =?us-ascii?Q?SqRtueeCZ3KtDRbXRccyWJWP1HccNe3fDprjkugUz5A5OjtHxq6+G6WNfNqq?=
 =?us-ascii?Q?wtWgQwCC1dQa3XQOVSy93zgODk2ez2DbfVTT89cJ4YxYk/cExCS/ihGHvK3L?=
 =?us-ascii?Q?DdFKhSo3gMowP7tJpYkp4LcCVvKaYzSOnt0c8qXiM8mFth3ftnw3drGZCm4b?=
 =?us-ascii?Q?+EI0+dY9a9Yq+1vG86CilQ31E1vYWK9dJ1Fo7JdgxvjENBukWqhr9hZeoRWh?=
 =?us-ascii?Q?wNoTzn9ZaTmxYxsagGJe64fz+AfVTB8JSxtXUvQDzoU7xJneCH1Ahwp6uFns?=
 =?us-ascii?Q?Z3qrFSsnNSsvQKaLY2mhuMcib9Vxgug4OcLDux2paEb7HCnWeAiBRJeCWVKo?=
 =?us-ascii?Q?ucYOoBxPHmEM1xsseVWn4JJSBw6KHWp4VmGClTb9Rlgzp8FDhHkwqcV3SMcY?=
 =?us-ascii?Q?4Y78gqvCMnQ/iJoEIeXAxdtb4dEjKkDwZKkJsBf1Hhi6oK2aRCayEEOK0s9U?=
 =?us-ascii?Q?59VAm6PNwSvqGTii11bLUAEGo5+f1slIZCHLmHPBunYdW7hHcFZ7+5yq0dBO?=
 =?us-ascii?Q?kOKxI6Ty4xrGvpiNtJ5z+atlTUA13uSwXUBjc/H45saN9m+zLQEH2UOHTeUz?=
 =?us-ascii?Q?B/BusO8CX7bAydPtvGa1lkLZSBQKwegoWPIsUNTPYbxp5ZPmSV58f+FOIHRE?=
 =?us-ascii?Q?ekDbRI/loB0HE4osaOGYahjWqc3LjfwUInUgxpZnVh+oOmVsd83KUX5Xuoyw?=
 =?us-ascii?Q?L9eY2AZloDnXsJtpj7dVo3xraprTxltI90i6IJgfBa1C5lW5JjgiFQsF9pdH?=
 =?us-ascii?Q?4BzZjJhpnnhgvEiYlTw3wLRFeFnWx3i3B4yaFpBp87YEQ2/A9fd2EfCbUWlr?=
 =?us-ascii?Q?gk8yY+m1hdwU+fdAAH26EQ4OKZJbfelyKlodEU+zkCqFRPaOPB6wjw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ISsl48RNk3EsfKxb3l3okZmx6eexnGoS2aKvio6hOsix7D1GV9dTUTuZVAQ0?=
 =?us-ascii?Q?lwPoNOQI5UY8YGvWqk8fzFlhQ7oDauOq2tTQi08+3Fc6itTcOsHttrOlzDW8?=
 =?us-ascii?Q?wfB5DnHrHszg7zthq1w7wtwXt3F9/gxG7PVpJYj6TqpQ4UTTq5NelH70IcZh?=
 =?us-ascii?Q?sR27m5VZ+4MCgiNCXoASihryEL0YwOpU5+VQb9VGjoz6XsdQCva/BjsQUc4U?=
 =?us-ascii?Q?wWu8giS49e+aVk1WkweXkTfU72uumSGqvP7kl3e0tIlsM4fYAZf1/BCsCBcG?=
 =?us-ascii?Q?+hrtT4aPn73bv9nFlIGHZ2V8zBZ+tl4w3ZN34HXOTHkM4E59pW6xCqHv+gZ1?=
 =?us-ascii?Q?4inZ6zb5c/7FIsfpslDHR+BX0YPJe5cNIDjt5gNzu8+FBhQ7Kh7BmKtzfmS8?=
 =?us-ascii?Q?bY2BpJFNrryJjv8AJY7ytAge8D4yZK0BIm4AV3hSoLKMFvVW7XBiFCWgnyfx?=
 =?us-ascii?Q?hClUmJNBxkGrDd39Z797jbqV4dhP+z7SY9xxAgXj5RTuGkfLPYx1A2Fbncrt?=
 =?us-ascii?Q?ryOABAiwjGcvgOul5HtOTRNcs0bR0+NZcc1GVXFHhqKsNQvC+2xQtLUwZs9d?=
 =?us-ascii?Q?QmLlmWxjfkjH/7Jil6l51AY0MtoTv6uAHNalmKMV+qgcGQ2lYO6mV458AOA7?=
 =?us-ascii?Q?2OU74qHvK5VNxs4u6AAfBPI7FgowkqJQ3IsUDfpNxdy3g4rXi+cOOH4uVBP5?=
 =?us-ascii?Q?00yp3fFvzTjfSwGnZVEIWE0VzO9a5Xwa9mEhTA3z1JqqNE1/p/yEY9hRj/cS?=
 =?us-ascii?Q?nlmLwvOEJiv23Kv2/m5FZyEuQV/uJxEEtz8QZYASFO+W+DQficvW+7gFPi2T?=
 =?us-ascii?Q?9p480bZQWdrVyEcJYmqkkMLpfaYGZ1jdgX85owylUDlg2cZkDf7loJO/yDlK?=
 =?us-ascii?Q?Qss/jL4Qz2CBMsQyNgoiGmjc63cLyTGcCRHTTuOuIS83/Yl9HUp5h/1+h4hK?=
 =?us-ascii?Q?9WA16+qdOoJhmaqnI6BHT+ozMTcT1JGdrK2IqxVDU4zz/TpP8JcCtve9OYjp?=
 =?us-ascii?Q?FyybUumWJL5kIzfx6XwL1hjSv5VHTi1+9uw0Pv82UUbJSUfF4bQccWnYhD0+?=
 =?us-ascii?Q?6dXt7z2tCW/ZWOtDE4GMIqsQgDZGQ3zLuncYxEcK8akX46v/e81dHXlhPu/8?=
 =?us-ascii?Q?32XcoQHloTO/zibDjJOI2LICHyNXxqaYOr6bSPZPNjOTKOqd6n+/skpmQdD2?=
 =?us-ascii?Q?rDHeCVSHRqR+eWyJTckIk0m9E3j1NWVJWQQ1IsmGkiKBSK4c/GSOv41Ydwlu?=
 =?us-ascii?Q?Q38L5bWO2mTfMAefWkncXYfIeHA+fPs/KT1/WdeKQ+niMreM1j25/Uj1jV8/?=
 =?us-ascii?Q?/WB5lBEBqG3FZ6dL5muPgpjDCFa4YozROjOpi44KKikWeNZx70MYgFgu80LN?=
 =?us-ascii?Q?0AtB9p5WEVPf6B4wdkdzfk59j4zGpUpBPSjvUDL5BcJmLeGk3pXuwOp1yu+X?=
 =?us-ascii?Q?rhNtr1MQVjMHN6Sar4qclL7f5GlcUZ0jnTPHjKvw7jsCGMemDp06gWdNh82Y?=
 =?us-ascii?Q?yTMkqcYnCwQeoCywTOR+mkWWU4qHQHw0H0SKnKH1W1/+aqkrYeYf7DfXLVZQ?=
 =?us-ascii?Q?YgErHdM7Vh6O4dkNvKUaG8bthoZc1i2Qg371B9VEUL5+ojaEUU+03CtPPKh6?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AA2CBC66D939B40A852C7019B6F0D33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XOsv47BKOnFUKjwrsz6DNDfEIoG+nrBBh5YNd/KV84dG9uRGT+3EMEYDauklHt1HC+0+Z3XUnZfnaT4mKcroQe/2fhL/99SIql0PTayrX67wIrRevZsfYWBVxsZzLgF/vua8An41pGrU8I4xMncBqm5oXsFJmYsP3DFKCvCu4mZbEmO6ZtpLeApBYa4pJ5KLeJHvUHTyY9yrS8ATtHkDHAvLU6BHmUa8hBVtemd83UWszdvZDrZ84h+czpaTsgLlLZdJQkzUNa77wz+WcTpFnqX5reJJc/wR++hABQzcZyU9Ytt7y3KSibg2TgI2UISHAuqc/MxwA39UnVeuMyHSYmAYjWF3FRjUy2asldOy96pFR6rGyoXCBwvGttcBbVaMWaMNIiprRcUj5gmsssd6iAmpNUbDvqpYxi/FqpMn5Fjb+CNcwqQPxwHSw2aTJWwtVjGIoEHeUIcvyCE56/9VBXK57UChNyinFH0E6ppjBuM6dPIgD4CXlMEE9RTvs4wCQW3JnU1pttWYYD+Pe+MqL88vDkfcj1GErsOh6IQvlhN71fipw4NVIi4/q5Im5CElXqijhS/G+eSDrmY8nOP0yDekUWu8hssgq2WVyDcUeViB2dvSnSjdnD6NqMAYFNuD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b31857-2739-4239-2a65-08ddc2a56619
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 07:09:39.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRxVFap7WbzAwSphvZxNBP+l8zu0IOD0e14YByAm93rfyXQXP6Qd1o6Jx7ZtiIEOoxGrmdWcwzhGw4o2XCGt1kspi9lZauwUQVGt6HgAisg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9155

On Jul 14, 2025 / 16:02, Shin'ichiro Kawasaki wrote:
> The test case repeats creating and deleting a loop device. This
> generates many udev events and makes following test cases fail. To avoid
> the unexpected test case failures, drain the udev events by restarting
> the systemd-udevd service at the end of the test case.

Alan, John, I sent out this patch with wrong CC list, then it reached to yo=
u.
Sorry about this noise.

Yi, Bart, Gulam and Daniel, you should have been CCed to this post. Thank y=
ou
for the fix discussion.

>=20
> Link: https://github.com/linux-blktests/blktests/issues/181
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/loop/010 | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/loop/010 b/tests/loop/010
> index 309fd8a..6d4b9fb 100755
> --- a/tests/loop/010
> +++ b/tests/loop/010
> @@ -78,5 +78,12 @@ test() {
>  	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
>  		echo "Fail"
>  	fi
> +
> +	# The repeated loop device creation and deletions generated so many ude=
v
> +	# events. Drain the events to not influence following test cases.
> +	if systemctl is-active systemd-udevd.service >/dev/null; then
> +		systemctl restart systemd-udevd.service
> +	fi
> +
>  	echo "Test complete"
>  }
> --=20
> 2.50.1
> =
