Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020089.outbound.protection.outlook.com [52.101.186.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6C2882A6
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209603; cv=fail; b=pmQTcFPmwhp9+PZEoiEAtJL/2uIOLR9+YAFJaUpejMa/ylEYWvpzrWHlSOuZtTyHuqO75Y8fPcJVMKvgWt3Pi9+Ci3dMbXlCCS2NVWIu4JOKTdHNOkdoqpFlcQNhVGPFIS1xtBoCuyMoRV2Oxp83SFHr9lcJPnU+bC1lSX/jhzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209603; c=relaxed/simple;
	bh=Ihy5+JaMOhO12v1drwkGG2Xm09PhcG8xz+Qayia6R9Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pLUajeefA6vIEl/Pj17fxTLMZOs2RsC2ktK2Xq/XSdmkfTh13PDTQdQ6VLKY+H22YFv/j2Q9vFMrkjCJOLPtS2d2l1Fi7XxwUv1U2OjF8gAwNhPv+TmvDSFaGWQZyMNqEiGvs9TZ/fvM9J2+3mYPHqDQxCH4p0IRU01Pc17bIaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com; spf=pass smtp.mailfrom=konplan.com; dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b=fykEJ7Nf; arc=fail smtp.client-ip=52.101.186.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konplan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b="fykEJ7Nf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HANKD6A8niCuZnDaiO6Z9cZYjonMtLRfUCGPZHBgtmyTWx5l2ZbwTX5TV1LGjoZtkwXqWMhT/RbJLqMf14Rfi9jDSR9W8eDVBFsN4LMvD8DjIXSZEzareTSerTUJcZMj1Mt5XygTVdP1G9FYlOzRw2wNEQIzRYUC2ZlSKojcIApf39IaUH2ndbr4jyU0+39TndzEDygo28TUJ04tTUgHNQMyooF8cesmbweFCqqkslvX8LN1/1QC6uqWD50WdtPM5RdgpyOhSzilH6G9banoFHZkGWgw3eHPPU9Pe4ZOSYddZdcMVNtrRm33wnUT0b5H2P35E1qzlusxd1gZdCb3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ihy5+JaMOhO12v1drwkGG2Xm09PhcG8xz+Qayia6R9Y=;
 b=VrSeJxIVBgZMgTS7aKbhk679EJArZ3h/vmFdZNhr99/5lNUGhhkjrBemLGnNsJNOh3VRqWn8b5h/vfOKY69vYmj1hKlqqiI+etf/qS7iCGBx2ynTHTKxUQL6xtRGYr5hLy7p9S5PQVEOabb7SPk42FX3piJqvL471RqWzdGuCTJu9kwn0NNfhfhgXupwclG5pR/aB5hSweKu3eHpzDETDGZBcbYvV3aMdHJ/WSdNrEFUyckmBcLoCHZbdyvhor1hufWarCpy0fZ75ibws+nXPHF4ZjHaW2e6V415HFf2tKyzcBpFu1Bp5N1Mw0LEK6q0P18xXc2PBl+gtC2RdVMHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=konplan.com; dmarc=pass action=none header.from=konplan.com;
 dkim=pass header.d=konplan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konplan.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihy5+JaMOhO12v1drwkGG2Xm09PhcG8xz+Qayia6R9Y=;
 b=fykEJ7Nfze/eZTq+YVkGly+EPt/eFvVMuKO7gHirpcHUhORstcttnKgRz44az1VdVXzySQ4H/jI0H271M78GmVvjnWVBjVzmZeW/hDwI0lEkOQMp76MyQqdwwdm668WnsNDOkYsl8hcqIDPOb7D2K0RUufMEpQH4gtVJD5aOIPk=
Received: from ZR0P278MB0743.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::5) by
 GV1PPF29B75DA31.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::20a) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.23; Fri, 6 Jun 2025 11:33:17 +0000
Received: from ZR0P278MB0743.CHEP278.PROD.OUTLOOK.COM
 ([fe80::5910:34b8:ee79:cdb4]) by ZR0P278MB0743.CHEP278.PROD.OUTLOOK.COM
 ([fe80::5910:34b8:ee79:cdb4%6]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 11:33:17 +0000
From: Sebastian Priebe <sebastian.priebe@konplan.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Topic: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Index: AdvW1aaQBxx+HVyZTOy8fPvAxuoYWw==
Date: Fri, 6 Jun 2025 11:33:17 +0000
Message-ID:
 <ZR0P278MB074311EF693354CBB59FD5029F6EA@ZR0P278MB0743.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-bromium-msgid: 9ebbc266-0686-49ac-a764-d1e5a821a092
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=konplan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0743:EE_|GV1PPF29B75DA31:EE_
x-ms-office365-filtering-correlation-id: 25e15123-91b9-47f6-b27c-08dda4edeea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FncJ/cOYUFWEaKoKWbXB2OfgdGSNIA5WONLM5FiNbLvdQF0O0uJfFXR0PXgF?=
 =?us-ascii?Q?19iu+ZjA6ofPDsfS27ZBy4JUkvbxK1HsMltrV/snaV28Aq/tIIdOKTuvIyRc?=
 =?us-ascii?Q?9Ry2W2UL7y3adJl1pFve+eLBuPyUEWy0Hp7RL+sMfLi6YKLpATHNqomdHeXN?=
 =?us-ascii?Q?MJ6Hx5y/SY/k7tDjzasBICU2mipAZMsEOHD51TsuT6zsb7lpciGPyR0PaK/F?=
 =?us-ascii?Q?fA+wtGnEr3cDWtnD014rZTAVfRH0mf3axrmpRvI2tzK/0yt5XmtWJ7O19KOw?=
 =?us-ascii?Q?/9HY+fzdAeGG/FBf7yf9wiPm1RGMOPJfvlsLxizbEoDUI3+19zKQaOsn0mlD?=
 =?us-ascii?Q?470nDaFXKhDb2yYyfej+QWiXH45HtECXRBWXLIaGZ6rkw2YxvAOLzygK5lX+?=
 =?us-ascii?Q?Qi0p3AcF2atNAfnh34TNnp9vL1IdHhkkmloRQdBlcmI3hw5THvxm33Q6Ouzj?=
 =?us-ascii?Q?1TJbkAON0sqGzyRHKr//9Vs+9O3jWOGLDT+9av/AxtGPCK3QJ7Z3704bjHig?=
 =?us-ascii?Q?xhdMp2eNR/VOnsY3DNeMwIYz5xn39Cu53f3u13tNpm9dNwBnboJ/CMmHOtB3?=
 =?us-ascii?Q?fyIKJeZ+H6VOrWU9+uL8RqYDB9j5RW/tutTvYDB5kVHsxbh9sHhF/fqRE2D3?=
 =?us-ascii?Q?Gs2attU5NDdIj481cYqNFHeReZ347rjM7bbBwBg5YT2XAEcq2djkwaWsjENM?=
 =?us-ascii?Q?9fXdrWiY80eKutMQMLEBWBAohLKLc7fuxgS9/7VlssDjjONrz922yXzAEURa?=
 =?us-ascii?Q?rdp3QHkKocTvLchmuhco7vytI7ZbaI3lnEHIH3PWzPabQMHuyFjKRa7rn6ZX?=
 =?us-ascii?Q?Wpu5CbvckwxuhIktkbwBCY7VCiRNI2vLjSy/d76tKDesE6MMkSR1usTQu8xK?=
 =?us-ascii?Q?6OkSnkIPANbNtHcw57cg1Xy/vhTKQKGbnE12xA2MUD5u3oD7xJ/7JDIr5ZUB?=
 =?us-ascii?Q?BjZHAv6EwqEfLMXttX89rODDpGujfaGSu3sF6qqgFN78DZP5VvGm0+1nHePr?=
 =?us-ascii?Q?2h7oMXTWAnQn0PrVGj2LSZDTQeRevcT8ZAm9gnBHxg1H896uD2DTjvrzr2WF?=
 =?us-ascii?Q?obocz5DepvEjbbxZ8rSM6JMxXGCuTMlq30DvlAb8/zVzFRSF6Y2lw745x6k0?=
 =?us-ascii?Q?v2OTDk1yMbtV2ft4+GcZzKLbTKjS8zY32czRFbXCZ+JD2vv1r2AjzjtXX89d?=
 =?us-ascii?Q?hyWt8N3fuqnj39QDAg5/XoLqzjNuPnPfzltndS3DPP5ZTesh8BBVw5KK1FCV?=
 =?us-ascii?Q?uwbuB/GA4mjllcQZn0lUyuaRdCu4W1yYgXwGzAFkKBTnMP3MdGRKhC1JMT4Y?=
 =?us-ascii?Q?8zUb7AkXyu4l7wCkmI1MlLF278SiEEXFdKV3tPEw8w9KnK3Ghd417XlEvTT2?=
 =?us-ascii?Q?uGHgH8bL8XMkxQqBp3JgVNDwVdUv+uDEYG5+aj3l2t1Ya+S0j6N6Pinuh4fY?=
 =?us-ascii?Q?qGJNDROa3DaRQ19lpamQH3g464M7OIqtIwvbTC9+DElDlxMqyqzg0pitTdXz?=
 =?us-ascii?Q?ScuIIU20TaNsKlI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0743.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NrbrxKgBrGRTzuqrPffgDinLp3I27Ym6bQcW/ugbny8nhFOVPmSIvBtpMtHM?=
 =?us-ascii?Q?hpfNDLzO0IuVymTxYA9/MDWDUOLvFvVRhtK9D4StrVQGOx/iiufqECVQYTMi?=
 =?us-ascii?Q?DAi44FQeFQGIf8lqV9u3a2ad0WLa28gY025LTgNB020ngDd/AKXBJryrVBnx?=
 =?us-ascii?Q?pZXt/eYXVXaZLJJYz/PfgMO2eTrQqpofnmF5XmPXNhVALuATCMtw5DF+6d76?=
 =?us-ascii?Q?Pd0yJ0XGitjr52X0mgeEYUrPfjOgI9MZ/vquEURbd7fbrPiT1gmGWe7NgMX3?=
 =?us-ascii?Q?PypATb9mEIPFUX+SQYvSHIh78Yw5j+7SiMyYsVPb8iguY4EqF6btCURHn/jZ?=
 =?us-ascii?Q?vbqhKMADFzCu27wL90/OY5OUarqhpLOpDNn1QSXstVXB2ZPqpRB4ROt5kJyW?=
 =?us-ascii?Q?uEk9pCLV983dCQ7h68dZcDZvG3UZ3e0oIObmO2ZmBA4TskFMAMOsGSG+4hzs?=
 =?us-ascii?Q?ZfwV1mLcikUe5Wy7zu93dJUvOBUuy4zHTuxNuTou6+HRBcMEw28Q9Zyeoswu?=
 =?us-ascii?Q?hrIwqMBGdLLFS9MJPY//wcd+lJnxODZeI0qZLcc5V/oR1h9TnQT2A1EApIvt?=
 =?us-ascii?Q?qEvjUTK2fdP3H0JXXCqTT7wiDRrVQfTVMEEG5/j3Jp+YcEOoIkZ7BSeYjhv7?=
 =?us-ascii?Q?ok+nK3fZrEJ/RjdA8fDF36C/S/VjdWXWltVnitvb34/nALYxx3HUFsgF+sw0?=
 =?us-ascii?Q?Rmn48pRZPrM+1nV3Q6vIqn2tbiZnFpe221Re1TBEHrQ1h5HtqOC5FKJRRtws?=
 =?us-ascii?Q?a3V2aFp1tyExsHoxwlHp1Rj+etDg0Kw0qc0kuFRCPeZOHyerVuo3eUpTcwl1?=
 =?us-ascii?Q?7DITy0U1P1+KBjXfYL3YC4A2k/gNLJIIavB7LkdC1z3rrNhrKQza6zerK+9k?=
 =?us-ascii?Q?SFMgfR4G24Kt8DhcRxukM1awAQCy3fHudhYxISlthj62jLorpiymQWp2i38F?=
 =?us-ascii?Q?ojwTaA8sDjOLJIDwFOnFny6ivcUljo5eYK8T1+8fGAM9P7QtDIsNGzqQgmjv?=
 =?us-ascii?Q?RJ9bJ9gJYgCrB/yHBaYqqKBgKHxFPcA0eQLr8rDSVt5A0cW4Kll4j0XVBTx6?=
 =?us-ascii?Q?J19G4/GW8lqBoZJb5e5tGpFmTHKZtppKbwA2XBrpwxsaxdw0/GLbpDjmzu9J?=
 =?us-ascii?Q?LuLoDGi0raQNdGg2rcN6PRatpLoHZYWv43JAkKrJF+RM978wTJYuC1TEAH0p?=
 =?us-ascii?Q?tkl5a4uhR2bUwKvq8XYWG9uZTRSM1SRQCDb0xz+7HxfKnSwHyX8W+OeMs3hk?=
 =?us-ascii?Q?Jmur3tCZtkTHyv82unmBhsz8ysDqa4UnuSnb2aakDuYL/yogpCiYVj7838FZ?=
 =?us-ascii?Q?lZn+r0iSFtJYlvXdyQGsqDHJDI1/vLlxm1uScFzaSZXjYpFb6Mz0iQDfZJKT?=
 =?us-ascii?Q?Ts0DpuAldEBxeHelK4IEpg6EKLuAE6Nw4YMxF/fn/0X73Lcy9CHGow68hCqc?=
 =?us-ascii?Q?YomDx5X7IMd2S77hjXju0wImoy6TEK9Lmzgp8jWy06djhBJ0tAIUANTCcK9N?=
 =?us-ascii?Q?ev+FgPfIAe+uv44pA8441AU/kL7ZCA05mCbWSTjEs7lIhkEvFba/J1paeOLk?=
 =?us-ascii?Q?aPhYObzU7QdR17FVMnbesuez5+G0hEp15XaQ89P9B+usbbJi2phl7fAyxUJl?=
 =?us-ascii?Q?HfXncvDd054pGrshohLYg3v/2UpZjNVb5Gwn1oUqYPOM3V+CkVmMB1BcVOhK?=
 =?us-ascii?Q?6YGSGA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: konplan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0743.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e15123-91b9-47f6-b27c-08dda4edeea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 11:33:17.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b76f2463-3edd-4a7d-86dd-7d82ee91fe05
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqGoA0/QZGAjva0EtQo5ESdDEl+sKVCgx5/Jip4KEYmAwYof9uC26qot62hXC5pu563IxXPSzA8d+Y44MYgeM6fYAHBY24deX9TzehApNas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF29B75DA31

Helllo,

we're facing a regression after updating to 5.15.179+.
I've found that fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296 (block: deprecate =
autoloading based on dev_t) was merged that disabled autoloading of modules=
.

This broke mounting loopback devices on our side.

Why wasn't 451f0b6f4c44d7b649ae609157b114b71f6d7875 (block: default BLOCK_L=
EGACY_AUTOLOAD to y) merged, too?

This commit was merged for 6.1.y, 6.6.y and 6.12y, but not for 5.15.y.

This is a regression.

Please consider merging this for 5.15.y soon.

Thanks.
Sebastian
