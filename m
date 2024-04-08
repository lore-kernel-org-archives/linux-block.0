Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4242F2F
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548982; cv=fail; b=fIft/3qScm9NDG3Bj4cBfQ7NPtqLnJvzJxM6sC2NybLB9c1vY5gBLe+F29GSgnvRjXGKynvVEMjVfe9e8M9gz+rNp959q2YevWAM7yU1TeO3mHmYnjzLTcXASLhWS9M2+A4QApdG4PqYxxi9+mzijySp5u5OJ1TjMtHkhmAT/zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548982; c=relaxed/simple;
	bh=VlPEwwUfdA+n03vY7XyTdN2p554KsDFcflat7aoI8Ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/7nVRkfmr84WtmVE2Ww1kfS8qgS+9F917HKtIN1A9TjU7oQ/jSgochhALn55qCQqRQpQRDsPdaPy2B9SdxgmoycHh6pzogzwEcDGgcYblQL25HO6QP3iwxY1oHk/nphfuovGFNEkwG7C4KLA/P6w6VOfbgwiayBr7E2kN/k0aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ksmAJCAn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qWoS7oYq; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ksmAJCAn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qWoS7oYq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712548981; x=1744084981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VlPEwwUfdA+n03vY7XyTdN2p554KsDFcflat7aoI8Ks=;
  b=ksmAJCAn4y+zy+qxCSRFDjcQXgRFlkrSJV4JVkpkwsdakyb8y9Kx2io4
   abj4oQkl8F64l1cFsWKB8kexkzdi7FOiiutwYqVnZvrE/FD1WsuwmSBeT
   /iUl1557Ne2N2v9gZcX2gwbDtIq7xonNJUNM4rXuF44MzR2hYHFJiHRFj
   Hg7+V9UxbGv8WEkml3imV4J5TTqj4H4+rCf/8NUGrYV7IU1SdJlIa8+an
   3FpBYQaLI1cSVvm+rh++uFnJ8aOQ6eNd+EF2/QBGVAVcCjR3n5z2sP5Nq
   nOMniwJojXFGRmoDra+49JZ5zRPhDWBAH7xqhyf2ucDQn1M2y8oPOAx+y
   A==;
X-CSE-ConnectionGUID: 4lYuCKFtRbKJeOO+CdbA2Q==
X-CSE-MsgGUID: 2VkNrCezQeOR3MdyLwenNA==
X-IronPort-AV: E=Sophos;i="6.07,186,1708358400"; 
   d="scan'208";a="13299580"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2024 12:02:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3pIiUzh/shoVGJZTOPVHyVSHG5oYB88WIsnZdYqqv3pHKEjs4LJNu+0GQ082GHSxdwOPT/qfXPRF//YtJq9pV29JuNmBURP4pg201JuD7KUY+RMJkeAahNQhxPF2FkmmDB1HU3dBxnukRknvSUGP3rcwLQYfOY1F0YNyHuwpcP1yAhwft51It0tPZAEaUNBEfYLwiMOZ02xyKai5ar0GacFr8l+63/KWbAFCjIsvRrXb9BvZ6DUq+cxkFJoTl8Us6Zwscyvgz5tlq+FC8rJS44xin+9JgWUuTtePzkCZ2/UbBCtX7gs24k36Poi+bWGuy0SYE08zIEmCYfqyLJ2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlPEwwUfdA+n03vY7XyTdN2p554KsDFcflat7aoI8Ks=;
 b=nWU4BPRrwV52y4djnhAr8YhumirGm/p3H8R0wIFUcQFlPtUSMmHzoW1+YW0f6/NjA51m9Fov+mOxSzUgi7dh1uTs2wLPLOoV9HrgPanKjm18HKdMpYs4e7pYsSWxSMy0BwiCu7mrUjzhLNP5TQWzHfL4bz7wr3JUaXwmrqJEUJUZNUqnxIcOCKrRDDmlkBjkSeNKQfZd8F8olOiHHO7srhV4fexF6sGK+HIiWsjYY4Kee0BZ/sjUAx4eBxDW7biA9IU5SGezTFMR/Y+nOUvaZ/jbwLPaqFt3ZpL07HaM1VLIU9j+DvtZcRziJhldp37DeB2Bt1QkTeBglOfMvaUR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlPEwwUfdA+n03vY7XyTdN2p554KsDFcflat7aoI8Ks=;
 b=qWoS7oYqCwbxa6w/+dKPTF8aPUdUvOATiFzHw7JJ07t2vKgmcFBQjumyrO5v9Ko77l0zgI/nhXgKUtbnrlOkHu32DAGMcGwIStGOWJ9cvKaYk59v1CJROqf+Yg1Rt0Iq0HiBOCGVscgaFYcscphVu9wB1aZldcKf0eDnBMrbUNk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB6484.namprd04.prod.outlook.com (2603:10b6:208:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 04:02:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 04:02:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests 1/2] nvme/011: fix filename path
Thread-Topic: [PATCH blktests 1/2] nvme/011: fix filename path
Thread-Index: AQHaiJoguqjk4Ewt+U+noDtz1g6eabFdwgmA
Date: Mon, 8 Apr 2024 04:02:51 +0000
Message-ID: <gawy4jjbt746lqhpeoouru4ent5wojuo3vcb52q2zxfxcyw756@2ecxcxkjzgbb>
References: <20240407031708.3945702-1-yi.zhang@redhat.com>
In-Reply-To: <20240407031708.3945702-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB6484:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2QQ2t1WwV4+jzLiLIhMoEMr1IsS/mc/AChuIBBvz8Kx4i/RmD6AvpBx2+neiSQZ8A3XLPxVh0DWVK5Hxab8/Hh2besobROmWvWNZpB1XxcwUX6ehgUOvKF6Y8DPM/OlnARwcjuyLyReaMA5m5tep2aVNL1eBKdQUfavPCTSkLnuFOkFfWohcBCl905tw0YWZsQxuoFAsijWvpt2SMAG3Jv339gNICKOSR45KAG4G3jI2qhFVzQ+pPeaghENLuZHQSBUNRNMn12pbOjDA1Zn1Li6u9YcO2Z31ZtDA3ZUvVgAVFXebnBMq5qCH2wRQN/H5Hq9kP7dTJZTubF8KYsRq2JKFkgtw/CfXpItoszcQjNTifFnax7OkTNMrzE76AGpfRqckn0LeAD6sz5VaqltL/S5NhACdU3uxpQ4fUqdo8CApGmIoa7/g0lbZiV0XQgR6faLh5mWqm2ggYgugWMMeQ1q06tagsd6TV2KwE3mIeHUtjW19pWSyBVq2AqXpGKADjROR+I7dDAzGwXtTDzoxyrUJ1MwJg9AcqrEYoIdkUXnAj4V7XSj4peztcItUNH5EdLoM0nO8Rs96AOzQQizaDX56rkFpYuK5ey/MdVXGFXSuf7CQ1XtkaO7yesmD80tccUyPt5NB+mz5sIbSBDrg3qfATdn9FTWJYMa1fMyQ6EI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zZMlYp56aU7975SB1OCD5VXSfpoC0FGpYERYztVyJhpBFE4yIhH2aBfo4TKq?=
 =?us-ascii?Q?2gek9hV30LvKCJpwkhigL5PfyLh+ROwIqk6qujrAyMW4utn8EUDHY2PK+coK?=
 =?us-ascii?Q?TYvltft3W68bWTd/DiSDqRo1PIUlFLaQZu7aOjUAb33X1/TG/5O9ByPebckY?=
 =?us-ascii?Q?0808+ijpi3Q+PwOPlT5slWQKRagC+fYKt1av992DH/PNNOQVt2ckEWxvI5vS?=
 =?us-ascii?Q?ZqniEWf9dehVEAADKsp/Hf0SksXRp7jPAnpGQw9ds/c3UhVQz40A/vQwFkb8?=
 =?us-ascii?Q?NDbb4XNoEw6eNMRAfH52OB4WoZrmjqPsquYa2L7Y2rdn0Dj8Hhsrzp2Vy7Mz?=
 =?us-ascii?Q?VzmOU5+hzj3Dv7E2rNISnHEJwhhTcfFsLTN+V/duUIztusJgOG64MBkiGhQR?=
 =?us-ascii?Q?tuMCklTjYjW8acROhCe6kLQxD1Z/VMD1SpaitGDo7GaevrnaTljz74+EyT//?=
 =?us-ascii?Q?r4CJc951DNTpOG91mqGt8oFk22gawdAoDu7r/KnUpTHqW/ekzbx+qge/cFVh?=
 =?us-ascii?Q?OJXo1h5rllcHEEcQW5vitpqAEunW512vz3A6l5/UoY25ZbWUQ0XWZrNVZFoN?=
 =?us-ascii?Q?qMsdhOUN0Dx3tHeG2Y6bMzDA7d442ZpzwCCDhRYrL5EU/me+MPOGCq2+GU5K?=
 =?us-ascii?Q?9T6RbMBbs5waA3bhwE4FKXLS0XKJxssU6F9rcADtvt3eHr+fLbcd7WWEmRrj?=
 =?us-ascii?Q?3YGLkO72rLNkrglSYB65zo/tz5PcbsyhRy6sbCkiK2MPc3BuWd9d9c9pZZRZ?=
 =?us-ascii?Q?6P1ak/unYkJjDEXl0DBitUDy7n7ujN2O9T5zPa4KF4LWaXH7AbmlrvxUUrHY?=
 =?us-ascii?Q?L3Jq/mzsJSu5B2x9jEhxkgBMFtc1BP6zmCQbIAR+k2gU5Me3jKsfYtXat2nC?=
 =?us-ascii?Q?raDLmRX7QYJ4U3akbeDPdNKPzKH63FsB3AS5o5toFYIN22cJ/CSASxNemkfH?=
 =?us-ascii?Q?rRJfl6DSqLXsa2gF57ccQdeSjM2jv7+I8lyF9M8YGf/TEaxWojZVAmGg62Il?=
 =?us-ascii?Q?6gpaCF5Y9H16qLfpA6n3kmDfuwgZGup88Q9MO3CNcqsw323zQyI56/6njBQJ?=
 =?us-ascii?Q?STuxakesG0TDbWxr7o5sFG6OuXGBDVcTBO6Nct2UgGwgAZDipFZik+o/UxIQ?=
 =?us-ascii?Q?56LF444ci/nHI16pFg50r0uCv4FXy0sroLdL6Bbz8RatiD43hq+H8y2IkgSW?=
 =?us-ascii?Q?L7hXtr7vsgEaUZy/OzQQvEMPERsxPv0m41ikp/zCJNhwzwt360BAj8Li1xis?=
 =?us-ascii?Q?BTbTpz0k/To2dwjl8bEeETyBY8Cl8Xr1ErRxuXZKXegUUKhYqmhks2NezDFa?=
 =?us-ascii?Q?BJr37iEeKtb6ymrFkRj5LAeydfIb8xYRxBia1VcSlmCRxGVg7sz4iq0eHPF6?=
 =?us-ascii?Q?VaxtEeQF0R/63GAhoAOdWPuWnt1rhL4wJr0+lkeDG9MbepcdDX8lFxqSDMbt?=
 =?us-ascii?Q?BGiuoYAgIpk7UeoTbr53m/dh4vapgH5F/qvoJ+9WAO3xmRMWe/O9bGqLL3rd?=
 =?us-ascii?Q?1ogkdkUdOkWiZ3D+gFzihATuq8q7EguDGdnYFCBKfPRbrSv0MwF4vcX2KgCz?=
 =?us-ascii?Q?aRgg5jiOE44NwZif8GOQoYry6aDUC2CtWQ2Mw7iKb+lZJib0WRTvp5eMDR3B?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD89DF78EFE3CF43BE9A56C3EFFBC4A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iTC13WQ/o1xxyICa8KuCSzTErSc2s9PoOPq/0teehJp19ssJNhWd4Gb88dQqBnQP9+j1YF6SDQr8w3GRqJq+85laPUmrXI3HsCQeaKPhfGqXi8Ex3oxuDLTjS/tDmzG6XZiQALTzvYJA4tAzZGVsxyBuvs+ob697bQwtUMVMPeHzgRwYLbUVqP3ZhEmiXS9IjNMhI5wLEsjX/oaeT/GtOQGwlNqdZH7LylrDi9+mHBzfxI1rQlItfdQMpLX4f27eFRbrFGeAekveFQ7Ai8UadDzkuxpf/Y/8x89fPncvSwCBtgTE2QO4uoujfFTI62h/JwXMBVIdOpExG4Uy7uhWpV2u8hI+H604dWy/8wFJ/9Mid6mA6x6QNKzqirBLFl4v7iAp0e5g2DMNWu+S2xGzq+9UiKle91yEjXK6i01wd0fdBSWrC5Ufp6RSEiTDw9Oyok00PXzEVde3nKLV9OiSUqmQqNKb0UealyS7Z7lEdqa7R+k1HmBDCcyclCaTVuHYVJGdx1ZSVZmw8QkjAbwsxh7OvrtVITheauJcUso0KZ8kT/3ehGo+DC/VI1x7cp17nUDPMZHjguuWxjsPO0vpKm4f73ao3lhTQqkItU4HzB/6fAmONBZbw3PdOCC5GoRI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e1d14e-b230-440d-8f24-08dc5780c296
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 04:02:51.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rrv+zdEhEiqlRrpLj3m1L3q/Ej08+He5scFil/V9FlpuL+NbSOOzSHYUGEcK7FHWCPzTjjKW79vsKDVEJyDkO/CphUzgrBJfQizIinw4WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6484

On Apr 07, 2024 / 11:17, Yi Zhang wrote:
> Fixes: e55c4e0 ("nvme: don't assume namespace id")
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Applied. Thank you for catching this.

I found same mistake in nvme/013 and 014 also. Fixed them as another commit=
.
