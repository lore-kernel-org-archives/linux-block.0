Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794844641;
	b=Pnpzt2dbf0cPt7N7VZiqFF3fokPUtryLzj72Oyr1j/dQiA37qj3zB0gW5HDE+ssR2B7I
	 0CX7f25dad0WTthjtTU+hm60xm6DfBb/hRaePeM3z7auRoyM+SLxdiL0j9w7ZYKZsNoLj
	 nkpeP+UuEUeTiIfHiB5kaHt0u7oFgt7pjoMVqGVSWyfihFgFCq5rY2STYEVBp98t0uKFG
	 D7zHzAb3PrkqxMa6JOq8tC+JmFr2FjZ5XCQ83qENr2OsQOqnKz7y9rDAaVuTskI3m2QLg
	 oylvnhf4MD6TsTAD+ufAGHov0tjUvwwoQUDneMknqEiFHQv4vHo5m7FwbX7Hp4MXk1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844641;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-RemoteIP:X-IronPort-MID:X-IronPort-Reputation:
	 X-IronPort-Listener:X-IronPort-SenderGroup:X-IronPort-MailFlowPolicy:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:sndkipoutbound:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=s48O2dlozCREpyddQRzqb15uXBttTD3f5/pWk1vhE7M=;
	b=H1jJcnwstI6LU1+D7dMtnePOu3VWzuCrVR5aGL4hrLzGJXlEc9v57/OYSCbwPdlr9C6F
	 mfPisg2ZViMsGPT7vuwHC1k/4bVuWMH4EifU1A/nb5v2dlhDdnLqa4Wp0P8q/3T+6S+Nd
	 ttN8N37atLTZn5ayFZ1VpK47hkHJFlY2+7Ssqt/LXrbFounf+mvTzD3l6Vi3XBoV35FSX
	 YPEw11PhtqrfmdBBRHIUaNVHbdQfd29cyi8W4vZJO6eQM1cQEt/sB4nI8d/io5mwbDwhk
	 67QaSvTpQIww1t5KWUiY0c3MOj4W7ZB5GSLKxbvqybcbE+/cO4YB7FQcybr2kzCfg9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=UhsMRd0L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.88
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3B606A31C;
	Mon, 16 Nov 2026 15:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=UhsMRd0L
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1794844640; x=1826380640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s48O2dlozCREpyddQRzqb15uXBttTD3f5/pWk1vhE7M=;
  b=UhsMRd0LAkl7YOoM1rbCj/Xn4pAubTUmhd1mPtgLCC2ziLUH8osZNtow
   JwqE8jDtSthRoK71EQnTeqmHuks/bMhh/FMf7ctTf6QhAZeGRZppatnAS
   28u3mS3rO4cznnoChBL+QFGP4dVI16bH5GqMeXFdMNc1TFRu4IaemFdIN
   FSyYjVJ8WyvXNPT+9EIJ6KQfrZenQoJIVZs/jNEDZaAh5xifkWUOEa5TG
   165BIu+K7eV7SkxwdzO4kmGtnmAAnUMdh3/PFmhrUziUhUVwRJIK/hde3
   /j4sg+G/UtM2YjIGmsrK4/Df3ME4p5h1BOIxLKOKOoe0uA7K2Q9AhRXJx
   g==;
X-CSE-ConnectionGUID: zspTDZWwRhGmqHDcFAoPQQ==
X-CSE-MsgGUID: Akr+/ehpR5WTYDQfp9Pwrg==
X-IronPort-RemoteIP: 52.101.201.83
X-IronPort-MID: 34306693
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11020083.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.83])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 Nov 2026 07:57:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4NZq4Xyy7rg3XEhsWjOG0Tsh0BInpP6gqJC3bUtKU5PoIDGxDB5dhqWV4RKjoQjfTWS9XrXU51Amf/81gXjxTH25FX8CXb97X4EbN/BrVAF3OcIYd97D5r8wxVHWctuqapHqHowwI1xHcK6w1wt69h1SIshBKndTQR+EZ7LApaVqxGqGIgueccHxc2D121Yys6z+uByUG5lt6FBX8d7YQjOt7ll4HKjfYqBhqW+ZEycm4ilQVfZc9OXM8ESo49KKTDdBJAZmIY921Jhq6mcXbv9rLGh1WqoabN82SRE25WUCWL1U2wzVtI+tamZ9AsO9Q1ukt23bZcC324GRoTLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s48O2dlozCREpyddQRzqb15uXBttTD3f5/pWk1vhE7M=;
 b=lh+XtfHLBP4hzv2uxBp4vB1T1w7HWgOPV7FIyQ1JWogQrMjgpJzSznziotn3jMy9FgT/X7m5Q1hYt5gwuAmwZvpU8QPBb7uxVXmo7EMB7ve4V6dBO8wilvipPTlukBc8YdWS7nNLowwizirzIgECLUkqOIfREHrq2hOthp42A9G3rrJ8ywXk2KScCiezEjLFLXtZvK7yihME9dfcN7zOhfnUyoXB6LL5Q8ZmH2ZN0Yy0pkcWEygvTXrzZA3hXyfmhU6x5ILp3zBvATImHwrXBeOhgI3FePdYyVz44THPlvjk6Q7L7OCU+M1mISs5/fzX1mHNF2jfyIA4BhZ4of8zEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from FT1PR16MB489006.namprd16.prod.outlook.com (2603:10b6:170:33::7)
 by PH0PR16MB4277.namprd16.prod.outlook.com (2603:10b6:510:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:55:50 +0000
Received: from FT1PR16MB489006.namprd16.prod.outlook.com
 ([fe80::b6c7:f5ee:19db:cddb]) by FT1PR16MB489006.namprd16.prod.outlook.com
 ([fe80::b6c7:f5ee:19db:cddb%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:55:50 +0000
From: Arthur Simchaev <Arthur.Simchaev@sandisk.com>
To: Daniel Gomez <da.gomez@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Andres
 Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST
	<gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi Shchislowski
	<Avi.Shchislowski@sandisk.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Thread-Topic: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Thread-Index: AQHda3cs3coU8tMIKkasF4HnhBBHo7cr3UyAgAURVhA=
Date: Mon, 16 Nov 2026 15:55:50 +0000
Message-ID:
 <FT1PR16MB4890061339D7B4AC2D46BFDFEDF47C2@FT1PR16MB489006.namprd16.prod.outlook.com>
References: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
 <20261103093856.203861-1-arthur.simchaev@sandisk.com>
 <20261113104220.2-da.gomez@kernel.org>
In-Reply-To: <20261113104220.2-da.gomez@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FT1PR16MB489006:EE_|PH0PR16MB4277:EE_
x-ms-office365-filtering-correlation-id: 07439097-4cbd-495a-47b5-08df43fa164b
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|55112099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 JpO0uNHTUUxNZZigLx+EzRi3j6XJrH6zQORFmIlbeo2olptIrXF+1TQaWfOQtwdUQby3pA03eFNKW/NrKATeGSCIfQVHJCsIoL7zPlQRApM8tOTzekwprJ+8zeeaTRw6anT7w8NRSAIJaynuo9uWMIllrotLASE7Wzp6X1b63QRgaPZQITrvJH0WtDh36/a/htWCNpQNKQnJLSCK0TBhop42Qep4pn2jc2V4t+s9bqfJLKGgmwdz0s93pWi9fMNT+WFTaQyZwqxR1HquTA8Psa18t4qBfYVINavmD849h59EdQ5jE28PKWuqxI+TQybWL35CZZsKvaF3Xv/kVlEFmaXWyUcefG7ZUySBjK011Z7jOw+9fGSGCtjGwHSrfxa1YvBbaouap0eWrOYCtkYFxDo7GDHdqRQQwNdPND0nj71nZg5n4TkXWiRHKrCcHLHwpMXzyn8i+MjKOcHeoub15ZBCNUddpxU36+p7ZVUbC6IIyildmeO+IQbjEdi7WTV56M3lYLWQk1pF7nt8zf5dWOb2T6/QrCfyVEEkc8hb6HVCYIPZDvXIMlypxYVpSchO53gb2cfNrgru4ScvXeE0opkEADsIAFcCx58KyJvguPhd2Bpg0SVsXfDGkwNmLbYU5zldae1pjSK2X0aPMoN5Dliti29/N4lNv/NZlt4tkM4euNRNRH+39oUhwwy/zDg+ysaSCs2GadzBI8A1jW+IiqRFOuKIccLZq9CZgxD1b/E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FT1PR16MB489006.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(55112099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3JIdUN2NHpqVXNrUDlDeVhRd3JEd2x0YzBITnFJVE9sbGtURkhnWkQwWmFT?=
 =?utf-8?B?Y1hlYnEzZCt1NmdHM0M1TlplTTVTb2gxbXk0bU5HbEFSWE5NZytBZHJ2SENR?=
 =?utf-8?B?N3U4TnNRNXliZkpoZWRoMkVWVXpKWWpjVThLTUZIcWpvNUJXdDh0MUg2bVFO?=
 =?utf-8?B?cnZXOFZUbWpzNDZOMWRHczd0V2VsYm1UOUlhTko5M1FIZ3ZYK3pIVS9iSVdo?=
 =?utf-8?B?NUVMY0JJKzRvRDVKWElwMHVWYURSWnhDaklScDd4cU1IVmtJcGh6dkl1TFVS?=
 =?utf-8?B?OG8rcEI2OUgzaW1tTWpaUjdKMm11aWtLa0F3YmlaWm85VUdIZisxa2JLTXZw?=
 =?utf-8?B?a3A5Wkk5MnBGSHRsaVlDbEtuMjVIZU5xQ0hYdGYwQ0xxY3lRemNYZEkvRVha?=
 =?utf-8?B?STNsU3hleFl3NXNFR3oyNUFrdXEwd2w3MUdHQ1hGY2tiakNNS1UyMlF0NG50?=
 =?utf-8?B?eVk1S2NsOG1nNmFKOHF6OTZEaVR3S1BKYmwzek16MkpmNy9BV0kycC82MENW?=
 =?utf-8?B?em8rT1BvWHJGSFFxYjRjaUZNcW1IelRFY3FLNnVxWGhvTHVhZHpFNHRoUEVX?=
 =?utf-8?B?ZEloNWF0b0FhVmtqaGNudjcxV0ZOUk43VC9hWitFemxXeDBZa2c4RFAzN0Fs?=
 =?utf-8?B?TDFDUWR1U0VDa3JhZmVwQzZYWmRqb1d3SWJoU3oxQm9BTkFnaFd5enVJWkZS?=
 =?utf-8?B?Ri9nVDR6RHpuRGxjbE5NM0tGZDRqQzFZRnZQT0NiWmgxTkZXN003OWdtQlhI?=
 =?utf-8?B?N1FUVElMOFdQaEIxaXowaWlvOGw4eU9WUVlMRVp0WjRQZWJmejRuM0dLNnlC?=
 =?utf-8?B?L1cxTkVmdXpDZDJlSjVXL2RJdkdDdWZ5bEp4YTdWSlZNNzhQZzZ5RDh5RGtC?=
 =?utf-8?B?eUNNRHdHdUpQVHdDWVU0WWV0NWIwOGNKb2hLM2FMaDRBUlA2QklMR3llVUhJ?=
 =?utf-8?B?aWRNSU53QlQxakNUYTlLeVk1ZjNFcDQvc0QxT1I2QlQ2ZmNIbmloS1hxdS8x?=
 =?utf-8?B?UmFiNWg3OHgwYTBzOWlMbEtVVXBXNXVTQStsRVBjUlUyS25XWmdKWGJPUG9Y?=
 =?utf-8?B?N2xGTndNTFYxcjYydTlhRnQ0UFBvUXpsWVMvY1IvZE1zOXEydXNiM0RTWVc4?=
 =?utf-8?B?VkNLK1hsNWNoTFp0NFBmbXhkWGl3UWR4Q1BXRlpSN0xtUHpzMnFXUUlSZG0r?=
 =?utf-8?B?MGV0TjlNT29tUWY3WFVCSmdPeDUwSTF5WXdUTjFnM1FZd0VQQ2dlZDlzVElo?=
 =?utf-8?B?WFltSVNpMERhNUtwYzkzNmhvdlRoOXJaNWRodmFlY2RKa3JYVjRNbzNlaFRj?=
 =?utf-8?B?eUNKRkpoTmFIVUt1dXdZV0dzYWdGeS9hdXhsbk9lQ3pFVmg2MDFBVm0xTWpu?=
 =?utf-8?B?dGF3Wi9OVkxzbmtKNm9GR20zSnlIcS9SYzRkOFNoWDBhbDFpYTc5SzdUdW1D?=
 =?utf-8?B?UlRUNEtOSEF5dFZrVG9aZSs4Y0h5dnN3dkpHM2huZnpVY2M4R0RjMFFoYzY3?=
 =?utf-8?B?SFhTODhNajF6YVhJMmhVdFN5OFNDUU1HdmFiVjBtOTRMVUFhckJ3U2JTM3JY?=
 =?utf-8?B?VENSREhhaW8xa29FWE5lUEtNTXBZQ3dnOUhhUkZNcGhpVlQvamlLSlFVa3Ra?=
 =?utf-8?B?M04rNDVDaXh4Q1RISWlTY2RMTWpZQ1JDVHhkdnNsbWQwRE5zT1R5c3cvYmli?=
 =?utf-8?B?TzNLWU5TZlVNNkduejFBN0lVTE5GQkhUZVRhYzFuTWZ6enBmdng3MDFiQnZi?=
 =?utf-8?B?bTV4aTE2aHRnc0svZUJRV1JRa1A0OUE3SHBCdlZINFMxdU5LOUFMWnF2Z29N?=
 =?utf-8?B?YlJQb0xXOWFFampEUzlpNCtKdDFhZ3JYSkt2bFNSRC9BaUhuc3BUMU85WnBj?=
 =?utf-8?B?RDQzQzE2KzlDQXZnMkpyeVZOSFlrK0VOMUc2U3c4NGlmQmkrVkVUZlE1QmlS?=
 =?utf-8?B?U3Y2ekhNQjlKUU1vK0xnWVFrQll3a0R1UGpPa1VwWU9CeXhYQ0hoclowYTdn?=
 =?utf-8?B?d0IrbWx3Q2hzNk1Uc1RKL0hxM01PUlBZRFRQV3dqYXlMM2lVajdsTE5KOEI5?=
 =?utf-8?B?dTRnTTNWYSs1MDhnWlZWVStPTk0wSDFmdDB3ZmNkUnJUS0JsNTNFVTJObFVB?=
 =?utf-8?B?ZlNKc2hLQkZPWW4yMVQ3OXFlUmVxQ2MwcGZUTDAyRDgrOWwrKzZFVmdIRXhr?=
 =?utf-8?B?RzV4blFicWo2TWRoSU5aSkZyQ1FkQVJ4d0NOWi9QdWswMUx1cXlBWVJDL0FU?=
 =?utf-8?B?OXNObU5ZYWk0Q3lGL0xXdm9pTldmMjlrdG8yclBYUENvWTZzaVRTWEIvb0Fo?=
 =?utf-8?B?NTdZOXZmd0tqLy9uL2RXL2ViakxFZi9PWkY4QnBpUTQxRG5PZWZldz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZzaWj9AEIdrjA3Vksp5GGTDM+OACChEOUSBJxOSYmH2pyudaUVK7bcCQEgq1QKnyvi/0RAFjY6e76jOGbM5i/PTKlDTbKAYAALT/dBVkHv+qAj+jXGq4pgfccHtKe13YO8z09OI8Im5rc0jcaPCB3S8zE4XJl0RWySDvgRnPYzDS+Guq+HJlcrZBZot4Su9FCUp0U4Q2P8PbyKifY11/buHqbuXGLLEPXipqb38Qyq+FUF6UdQJlUcLif0JygfcdDcrnyKEcAV4fykjAvoOGHq/sliwirLq90nONx3o+PBF0gZ2pj9afJLgwTVk7VxeZH9P81lEcr9nOwDUOFjpHuQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JSESKW1/SLml7iHaD24XKvB3k5MzVSsRdUf/S4PGqxktzyyvKvqrRn11mKez2LAqw2ID4zTpadVYSWuVqo/WJdlu6HwwnYt7uwNzp7is+RauI7hIrEFOg1kSSieTA3AuxUaFF7kmzI1y1kUlKUgiTVoZ6hRNRujAkWwatxqM+dLIM4662JDllogqvnYqj1i5HlLL/f9rfKl3t9uXrMuQeYpOtc3nl6FXeTtq9YFac35JBXM3KA2GJ6I9jAhkrqxQN43Nlu4YqXzsM4UxiNIGnw2451dmpn9DpZDRbfDwYaMOjGO6B99MUWdBpbjKOhOpsq/vtaXOXUqtRkNvUyFUrtWppjKo2tVCAYRIF7ZV1t3uW4zkmx9wGvdgFX1jPh5mAzjySYAWStynbleaZMizt6AxGYM4MveZThNokTMuTK8iUj6NM5JIC5VkolPx5PaP9zA2pcNNhQKHRSaojxrf2f2knBdL6U8p3q7kjYbeElebIt4pb/a4evghmx81kWXRwye6/xOBd64GDo4jWsYACNd4isdNkRy+Jru2Wa46Ic5legz6DyeW47IxrQVdXe5pCMc8n3Ofe7JMpr1AhkfAgpItz1xb4VxrliaL+vSjp6V+rU9adMCwHZTtJqGSZRDct13JrcVWDg0GzF/aW21V1A==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FT1PR16MB489006.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07439097-4cbd-495a-47b5-08df43fa164b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 15:55:50.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsVT3bKU49BfC2/gTMdKBITkb/tBXrfY2RQGXfksBVHLTkfJpav/dAL4OHUh1eRqMclIuLm/QISd1i8CADNQOf/M2AXf2+aYA95HNe1aE/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB4277

DQpIaSBEYW5pZWwsDQoNCj4gRG8gd2UgbmVlZCB0aGUgNCB2YWx1ZXMgd2hlbiB1c2VycyBjYW4g
Y2hlY2sgdGhlbSBvdXQgd2l0aCBudm1lLWNsaT8NCg0KWWVzLCBudm1lLWNsaSBjYW4gc2hvdyB0
aGVtLiBNeSBzdWdnZXN0aW9uIHdhcyBtYWlubHkgZm9yIGRpYWdub3NpbmcNCmlzc3VlcyBmcm9t
IHNhdmVkIGxvZ3MsIHdoZXJlIHRoZSBkZXZpY2UgbWF5IG5vIGxvbmdlciBiZSBhY2Nlc3NpYmxl
Lg0KSGF2aW5nIHRoZSB2YWx1ZXMgYWxvbmdzaWRlIHRoZSB3YXJuaW5nIHdvdWxkIG1ha2UgdGhh
dCBlYXNpZXIsIGJ1dA0KaXQncyB1cCB0byB5b3UsIHRoaXMgaXNuJ3QgY3JpdGljYWwuDQoNClJl
Z2FyZHMNCkFydGh1cg0KDQo=
