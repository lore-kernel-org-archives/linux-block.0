Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314C1D63D6
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884404; cv=fail; b=Q5+xO1+NcInzpwIiDinV9PhooIMGEKAW1VLVItL6W2QX57F0GAxKYcT5cas2BVDGinTvWQnNot853xX5JKvPHJsHEH4Y4Sg/WciGz0j4x8RSyE2hLx0iXbh3OjrYYdhzmj/910YC6IrLasARffuGvgQjTc/FGwjJSUFIGuoPvoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884404; c=relaxed/simple;
	bh=PjnJ6P+GFPtQnUmuChjAQ2lygITUaBUNKPbe+JGWs5E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g6ezk+DDT10K4Ep4hcm5MfPrj4JKA73HM38ZUc2fz9+LLZc8wRdn5iM35W4ogBo62hHAB0Ane99meHRJcO9tPhIvl8lLyHaY6QAAzCHC4ZOKOlxMsoxVTzo5LXB8IGVcUJBuc98Z6bC6/REwiDOFYMNz6J3KdMFR5zM7L5a1hGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=di+Q3/6m; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="di+Q3/6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDT1XrugVbXXe9SGx6h6fqqdEj+6UmJSMwW5o9gJE8Ty29Wa/4a2FnCxZM7chIzellRP+9I6+kkgIVFWey0LnFhYDXD/8Pob1YIvp051DvjZTPgLx3+reJfcOWUW3vCfGUBS+Ml0NDJULQ85Ua8nbd5LohERnDWH0b8GLdeWuBiamm4toDjxgzwzJvgegWiPXhLBvX81XDLlZ+smju7dsplLCBIbqGJSXBHVPlyL5iZMjPeWPm+3XLy5xoH+ytruDEuIjrvDltt9PflvfQw5exToZtl4KzHEkBfjvgGPRqw+UcQY/kol2eDN7ingzMUpeupfCMUCnAD58bhD4BZZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjnJ6P+GFPtQnUmuChjAQ2lygITUaBUNKPbe+JGWs5E=;
 b=Mp1nIITvUTCBEBUH35BXfLQDp5FuFJtTwjTnqoXuBPBNun3AmpxvbBFfQcBigIP3PgOB03044q63TFkWBkoOhq5zmmSV4qnTCHtIsvEp6M2jaErHER29IPp/dvSOHmdJklRwg6efPKGUOWpPoDswAxTQIIJuVdnSuj/p54ZexFkywIqRz325aQBQvZJqoNq5r/0vlIrluH8MFwOa5ORrH+lWecWuky5mhEjgbTty+BK5pat/yxr2dY9+YZKcX8y3s2KFGyn3CT1qxbKxtCiNLpg+V35dvwS53ukp0BI4FPcmLheAbO9es32mccQQutwLXqMAdYfRBVFAlN3EMSRSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjnJ6P+GFPtQnUmuChjAQ2lygITUaBUNKPbe+JGWs5E=;
 b=di+Q3/6m+ZgUq8Pww8/bU7bxskt1148XHz8q9kD1xCea4K5rOofpgpcmWnEuWXRQJArUsDBU/aQKJjoc9sFDAR0yNqJXY2hZ0R53WnMBhgZnONrXi/Ocgw+axTbSA/y+0XkkCHNrBAhk6d4DjrVkRHjO7bjD+ZQ1LyjHOnuV6Wus2Ij+diCryIn5eOEkhTI52a/cHWWjP+5sjnJ+3NwARV1qVTJH0fkjKh3lA4c6ViLmbwMk8xetAXoD1YEdceYR4lq2/bJn4VRHEcNtVtzHZD+VPp7EX/llgFaOgrM1TBfaVmuHVYaFDv8/drgEiZk6h/mUP9vmKxThBm9ytZRxdA==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 10:06:36 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 10:06:36 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, Guy Eisenberg <geisenberg@nvidia.com>, Jared Holzman
	<jholzman@nvidia.com>
Subject: ublk: slow recovery process when io queue depth is low
Thread-Topic: ublk: slow recovery process when io queue depth is low
Thread-Index: AQHbr390cHEjnmVK6EKmcPAYV2N5ug==
Date: Thu, 17 Apr 2025 10:06:36 +0000
Message-ID:
 <DM4PR12MB6328BA60A2F4C041C3181BC3A9BC2@DM4PR12MB6328.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|PH8PR12MB7135:EE_
x-ms-office365-filtering-correlation-id: 9be3e809-fb13-48e3-d2f0-08dd7d9789ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DxWGHBhRP0hB/hSbaCNOuYBB+eG3p/+enVaoA/4hT5fELMvxVdJIR/gHc+?=
 =?iso-8859-1?Q?wsBr6yuwBQDNyZYK+OQiptHc74i9G6lxzdJ3uJX1XGde5g144lloSMakmG?=
 =?iso-8859-1?Q?x98BvJ6GM8PLZFMpI11LaR3mVDxuASBTfW37B7yOSXa97oebtCNbkyGTfF?=
 =?iso-8859-1?Q?xU3WKWakWBAXR2HUKFu5Zs/85PbPGgrzArzpRAmmrIBpw66RH/kCvORI8V?=
 =?iso-8859-1?Q?/5Gedb7qZYr1q3tWF08V9QsBnHKg0LevLJIrL64ykwGcCJPJJlCC+qWrY5?=
 =?iso-8859-1?Q?Vy+BXFahJ3P192Ejxughj2TtV5Dc0TtC+qAZEl3Qjve6I7td6f6/WVWqqX?=
 =?iso-8859-1?Q?dBcHKxweoetJuNHU16xCigxPNvMQv/ia4NbH5FAS/jVsRgisZQVinc10xJ?=
 =?iso-8859-1?Q?JdDk9ggVcczkZEJBuF7y5DdfwEeVzMDNEgrEm1n6Q3wLANE7w6eWSZfkgJ?=
 =?iso-8859-1?Q?7YBQrg+yqJsdwsiAtYfZYTp2fh45mFcDp4wfYqT0TPrATzKThqH9/lwD3e?=
 =?iso-8859-1?Q?VA5JBRWCK1bveBK3Ewdf6+A01q5DvmLNpeukHfpm+V8p17hIYVZJ6M27kn?=
 =?iso-8859-1?Q?B1wqXrJokN9Dq6j+KEIb8RyB1HMmjDb1t1jmHWZMaip2P8ngv2PXTiEbK0?=
 =?iso-8859-1?Q?RnfYYnYF+YZkCyTu8dK4jHXMCpbZiTGsTSv8ZLT28p7mWGwxpXokTHpduh?=
 =?iso-8859-1?Q?5ZjqGXXujY5TI9T0AYX8fdvRHqgCOshir/ju4J8x7GFf3GktIWNx79VQx3?=
 =?iso-8859-1?Q?FQXMqEi2rEM9II6iiq4DLDeYZir1RcZgUwnVZdqJvhQi2DasBrlmRZtBBB?=
 =?iso-8859-1?Q?hO8ZkHAY+GhfhYeKTgkaYp87CpteWdbSDFA8jZlWguYLqds2hAXGvK9pdQ?=
 =?iso-8859-1?Q?eCQ38dWbOg+LRww2fdZQSkakJayLsSHk8cSFpwshFACu8V6H8r3+SJRWra?=
 =?iso-8859-1?Q?tvRVr9qEUvhjBrSfNBOYpy0ESZMDfIkwe3TBCOulITR4K+XjAS/mWNDV+a?=
 =?iso-8859-1?Q?Sv4XWa12FaTpIorLRgsmFaaytxJmx1QiyQg8H5VVpe2NdKyEh3nef4r5gr?=
 =?iso-8859-1?Q?mFZ9vxpVnynhIAi9gVFvM+WERPFKFMKN4mESOFZFvK14glQR7k6cSKCXTY?=
 =?iso-8859-1?Q?sRby3krwo+KLPxo4w3ast1j0YHJOkn4BLLRXN6DLC5VlX7bt7rzbVpxLZ4?=
 =?iso-8859-1?Q?5wHBD4vbzOb+/ntsGn6C8hJw4QEpDoElQO9329dJOF2mAzDpLMICh3OP4B?=
 =?iso-8859-1?Q?OppOzRbaIvlomqZ6BaeowVYwqyI1py+WgeMkm2Uht0fb8NDdczukF4rwhe?=
 =?iso-8859-1?Q?1Ffb+U0o4VIcGXycX857EiXtmGrQPHzU+0j7L7hG8cfJZPj2MO6uny7fND?=
 =?iso-8859-1?Q?ToRu5C9nJovB5Mmt6XOqtJ9q6DDBYhjq4MIYH0WoqJYaNZw7FND6KX0HIV?=
 =?iso-8859-1?Q?pMeq7p4ZsubUmgxv6QWeN9xHt4PD+E6uW3CGyNUWCiEucwpwTr7NkDqk5z?=
 =?iso-8859-1?Q?FydxkNBxEUHahn+hxjq0Kppptz5IPnrivx/m32vi2ndpiqVwnbhLvi5DhZ?=
 =?iso-8859-1?Q?f4mRLgo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+oYjV3bYZmCu2wZT5Cx+0h+i+usq2Kl7zOEOXJYoQ83/CgCEuavsLSlOVj?=
 =?iso-8859-1?Q?D71ZOL48ie9UW2+WkAenoriiscj5tp7NnRAPfOPYjNQvnliNWoby9v7Tr0?=
 =?iso-8859-1?Q?dpioENg0Ge6RkZj+q0L5TsJEGcBsiJ/4CefU0pyBIGxOLr8lhD3tqluqbS?=
 =?iso-8859-1?Q?Vh1EDKJixo1q+J0ZtJNydUbQv5a4FFISBki4aM1hlypt0INhLcBXf9jEx/?=
 =?iso-8859-1?Q?BrB8lQ4Y16333WFt7UdAbfctVx0TsR7NZ6rQOez+jOf+F8c5A+/JAPgvLM?=
 =?iso-8859-1?Q?2Ld267tnTxR6JWp8lBnt0YU8bePIq+3GXZYWXyXWlrbQ2/GyI6C6Gn+2C2?=
 =?iso-8859-1?Q?viqj8KvySEJT8ZPJUM9CN2bolNd+jf5mvWZVyBzqnIje53dud/k8uSjFxs?=
 =?iso-8859-1?Q?AzVeIRrqPQePAeYdJ7lcMnVpdrq/iJF0Z2nf6BC89xnJyy9g+CIQk8/TuI?=
 =?iso-8859-1?Q?j2SwwVfAWXecWekKSRsT9SruEX2Sa4jo4hHV+yqtJXo1HD3KqHaq1p153g?=
 =?iso-8859-1?Q?e9f0cgYjzuled9ES0wEvfpDOZR6d++bdByjKjLA5X0diFrRg8H3QylJ73d?=
 =?iso-8859-1?Q?OM4A8N5wbB2tYvn3cfpptlJpG6Va8Z90hPQfWiESFa5o617FOIumPdG4sK?=
 =?iso-8859-1?Q?6CRRs+tfuxDOFz3urQRbegKO0uikebtcfcX/woQFg1Ey8pOxm593jA5lv+?=
 =?iso-8859-1?Q?uWawvpDQhNvYj4naJn9nKHFUzRMQ4/Qmj8hUuUXdPKcDZWCRoBf26ude08?=
 =?iso-8859-1?Q?DdtEjiICg46TXBK9k/avsFes4MHjMyhooW1srepxdilyug75PNRkcD/xNH?=
 =?iso-8859-1?Q?mWQlM9jMLaPVB8oJcX5Peq2aIy2fzFbvGYGp2C1P0q6l+Byl2DOFrxkTIx?=
 =?iso-8859-1?Q?ojSex5LkMvdtZiLSF/8poip60TUgPmHo3R5ahjLe7GMVDoThnklqf3yZ/2?=
 =?iso-8859-1?Q?OELIlNeoecwE+FTLAbXVsuA/sxGugqcri5vUzB9hs+YUSxzY7ZRmWyLrvN?=
 =?iso-8859-1?Q?24vFP5xT0LbgGnVxsDefbdjUJ0ollYsc/Fwl8ucn4rZTYzudk+qulQsGgT?=
 =?iso-8859-1?Q?afzLG0JOdHKrnC3b2/fTN/u8tfqZz6S4j2smDnndkcfPLrA1ylNsbh2eiE?=
 =?iso-8859-1?Q?98nfG+5JeuzOuT3KeebOLlOAnwT/8TAMKBwbUJbI1JVBswFvkBPcmAT2aK?=
 =?iso-8859-1?Q?1EfXuhxtQ3ZZtQTVRGVZ/Ka6SwA7EzwJAQ8RdArMJr0PGu/pIYjAY2GPca?=
 =?iso-8859-1?Q?g3FLMaHY9kyN/WDeN3C0X2fz5y2Ofv0O4NpRxT8lThLVlm9rRBClVZIDTo?=
 =?iso-8859-1?Q?RYu9gFR29BqXJvhbbfK5HGaLeR90sKhlvxkllNrnB77xZYU+e7Um1CDA19?=
 =?iso-8859-1?Q?CZ125LchflPwjxymjFbB8akXAVcP9kKHeTw37FXGJFdP7moXI5ehhvUHU6?=
 =?iso-8859-1?Q?3IKI71Ew+PgGGX+QvYouQP6fhyIHfD3zCycmP6BTs9XCbBnmsjBOyXFFaN?=
 =?iso-8859-1?Q?CjFrtwv9r6KIw3On9ZlvDgACGXOtRvt4W1FluLOsSfgkQZnZA5yWLyohNd?=
 =?iso-8859-1?Q?k7haYBmLkTSmxhjC/iQSgaZMCawUTVNPQt2vp09evI/QVjlYtXdk7p9n7f?=
 =?iso-8859-1?Q?cOUB6ObRythsc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3e809-fb13-48e3-d2f0-08dd7d9789ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 10:06:36.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLQXpbrq65fkxmF6Xxmq8UvnEetuTsxZJMB8xVzLhf0f2EGINyY7eWM1/XdrExsW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

Hi,=0A=
=0A=
I'm running ublk on Ubuntu Kenrel 6.8.0-56-generic.=0A=
I notice that if I'm running an IO commands that causing the IO queues to b=
e full (at least the ublk hw queue) it seems like some of the IO's are done=
 30 seconds~ after they where submitted.=0A=
Enlarging the IO queues fixed the issue, and I'm pretty sure the 30 seconds=
 magic number may be result of blk_mq_tag_set timeout filed default(see blk=
_mq_init_allocated_queue where it set to 30 * HZ)=0A=
=0A=
=0A=
Can you guys explain the behaviour? =0A=
=0A=
=0A=
Thank you=
