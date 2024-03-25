Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963B149DEE
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332865; cv=fail; b=P2VE49VJEQb27V4r1Lr8BsKCXyA/b2wttyA2b6YpVMWlt1zsfoC9J6jGxF1q3VnJv5vDhjXR9Z/IexGm9lCYeaMcwRIItO9GOtsYUf1n2lK/grnMTRkRUkoE4tZanzp5WVVaa/NmbAiZY5wz7lrkMSXyxbcV8yGFrh4RC7ERa18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332865; c=relaxed/simple;
	bh=uNC6WR+ZaorGaW8kYW8AVdrxzRjdSw2GIE01g7q27WA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usdajzRWQNZ782UY1xosGFdpeo59zQT3MPofVGo88g4wwzgQiwQB7ILvr7yKrY0CybFO1y+OLMRAI967aY0ndq65KuIriR/mFS/jZ9Grao+6swQm9q0OLk2Y6/JKB/6y/JU6TkmPKE856yR05awd6d2BJ2zTy9XMdXjGz1IU7ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SwQ0EmCc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IGZqQg91; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SwQ0EmCc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IGZqQg91"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711332864; x=1742868864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uNC6WR+ZaorGaW8kYW8AVdrxzRjdSw2GIE01g7q27WA=;
  b=SwQ0EmCcOe7BEGo88gHoooqq5Xq+yHmKeGTY1CVO0ZcnBevOSPv41oW1
   Rj7mpUcKnyBWWa/XrHmDjHRjUtRaruxKSQflvXxVxIhaFXArQ6ORMp4Oy
   aMNELT5pjKf/dcI9UgrLrr7fl84cA0GUVJ7X7ZOW6RlHXDzou2fDRDOx+
   KM0LwStOOWBin7EJPv7b2NbB7WHSxwZ5z2cELG6gJcQlsPv+i0T+AJQGR
   6JNcibwp/gJnbT5ZhiZky14coYHoEGJO8ZOtSGkY3JX8i9h+VU7Krwm0n
   OStcJv0fd7+dZe68NNJHgEgBZKUhRDKV4pnnQHKvLrl1Bpgonu8m2Zoa/
   Q==;
X-CSE-ConnectionGUID: qsrYIfDbRSaa//kkHAkB7w==
X-CSE-MsgGUID: 1S1J7XAySgywreUwJW9FKg==
X-IronPort-AV: E=Sophos;i="6.07,152,1708358400"; 
   d="scan'208";a="11878584"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2024 10:14:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqWuCOcMAfbr/mnIteJm5pZliKivN+vr08jLyTNjLgLAlJS49Lf6wznFu9scYLeSaJtmHLAKM2Rjdexmy6hoSoV9w/DkluBVp3jrWJI0bjr1rLODzS9AwxJjL+OXgj7+CnamGpMpST/dJ1dOqB65Oxsi1GudePfqKev4VZYjpYTb+eTQAPZGW4qstqSk7x7whI2wVUeBQ8FqY+Dr1ka6AH3shO+/eZtBrtX3s2k16yEQlvfCIRO4X0GZfCfds7W2uSmfyjoC4cGF2bB6y1joF0vjQonyZ4E5oCCoqJzs0pGLqX9KiLDqGBc5z+PkXMGfpEremOXxr8BshwkVdwswNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YtnQkOhPWODY3p7Jv132YanV+riTbbVccwQcOpB2Ck=;
 b=l650zuXak7yITz7jjnTkc35jz8NyvErLjerVlThYXemfXrGqncHlkohlHj5Rxf6q/Jc7uVt7K3lkQjuTDQJqTXzh9qhQ3SZH2JKytjdzrHHPaGJjIx3SkWPSA7EFt6RKAR5nboIFb34+S2Qiqw+35Pff4dGfYArmXEuTr1NLJuOggEYEYM5eFN+f6vT0wGkcHVKJF8qf5QDtU6JeIy9kWgmaeDyCziuAuTKyD0CxyJcwooQTcKyR6pNBHu/3vJo9SLfDjH8c8Uux6NmVECzfhUCUO+79I/5sGesE3ly8RP8TMOCj1mh90qmPEtsbW3Kp3k9lPRpvpSTP89y4WNlQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YtnQkOhPWODY3p7Jv132YanV+riTbbVccwQcOpB2Ck=;
 b=IGZqQg91bacsERq0GOQz6EXb1Vxf7tgEG8Kz1403HieJrHqdAHcfyTgZV6Qa8RVeY6WMTgRQe/+E9nP8QgNQiYiyBXxONVYU0EA0MDQ3AKCCPvBTvMjMdlWgk72O8O0kdyrgSa/ToTbUhGOfZo5eK9uViVZB00GJwubeGwDMrJ8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6716.namprd04.prod.outlook.com (2603:10b6:5:22a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 02:14:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 02:14:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chao Yu <chao@kernel.org>
CC: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Thread-Topic: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Thread-Index:
 AQHaYovQw4Cp4i7GhUK8xyPo7C3fjLEfp86AgAAQ4ICAAtxGAIAQ9nqAgAAi6wCAAE15gIAJLoeAgAFZQQCAAJQmAIAH7J0AgADqy4A=
Date: Mon, 25 Mar 2024 02:14:14 +0000
Message-ID: <l7n5vbvpfmeutotnznxubhdr3migk5kpxgm6j5n265dnfgdtzo@iod4gcsfy5om>
References: <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
 <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
 <f4f1cfac-8520-47a1-ad18-b9922aa0545d@kernel.org>
 <jpgro32y5r3mpyh24hoqnwkbcg67twbmcxeicoa5qt723u7ehk@4imddarhtt74>
 <cd11bff9-46cc-4148-9dcf-4087e1621985@kernel.org>
In-Reply-To: <cd11bff9-46cc-4148-9dcf-4087e1621985@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6716:EE_
x-ms-office365-filtering-correlation-id: bad69cd3-dd2c-46b8-28d4-08dc4c714491
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GfA1XCSTdqWgnDCIHy10Ttxp920mzpqC7Q6PScKNrpCjCX6qXRVX9z+5saKMzCU6U3i8v2ROK/gwlIKg9u167LgI/8GFJeHgfxf+rxygOcrGs+NfeUNDuUFJyC3FbsqpjVBjs0xdmzKA4NfpeQpidjXNejNG5fFozdITFRpTWUP5Yf0RjSVr3ZF89b1gJelFziVdXaLhAOY9o5PVt+/hSRKNf/5u7SyBLiqv862aS8sU4Jt6k3+Xk7hGACtcmXLMYqFQr06SFwy/B08PTm5+VQlnboo7ncpCm8AZjWTA1Xf7bWOSKSTbkrO0wigUTj6duyJP/xU2nFX4PxitjH/hMqa8Czo+jm0GPckCxpGAGhFYMzT6AJ7XGlNxU+qloQiplnGnX6KleD8vrjT4mr0AueGs/QpP5z4y67ySkyEuX0NE9mjch2dKlWd4HlWh6e0FN5AB1yQQznWh1AmiInTM53ilCevdPbkNakBAwQHqgef/0+w8r1kiP29xChPR//OSo1cmoFYOLhUYH4DosWFG39TF5kGerrQ70vUSLNPKaWPh0n83xXyl5eBoXqSSOI6zE4iXfu9dMgX8pltFs5K8JbipDm0GEotSbYPawLGWAORDY5qODY0lroW0HLEk/RTWQscgmOkLZymF7PQ1hh+DmeV9oEQDszweP0NQNoCt2FBY1v/ppIadnuAEJ/AOZQjbKJf8+W4gnzYP1Tse0XYuAg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Xwl+nauyK1IbatAF2xkTqf9Cb300DYbPFjojn37FI+WbAASZlB4EHkE05u5/?=
 =?us-ascii?Q?oWCSHPb7vIe7+v8TWYFImgnMDU4vKa113csmPwgjjdaDz2gijBqV57NUtWKR?=
 =?us-ascii?Q?RJ3QRpirgAWMUsplcrlr2NxqW01LCF4PLJ8W2bVTFsFu6bTYguKGvd8ax5P/?=
 =?us-ascii?Q?/RGFzBmQhzqGu1duNAOkY2XbWzTVZmzPJSJbr9OczBpm3HKhuqBSXGUjkbKw?=
 =?us-ascii?Q?RMFRbSnq8Jrf/BnUtEsmNUliYyZEzOGUgcmtiP4IgO+A+LcwXlaDXvkgu9gp?=
 =?us-ascii?Q?DH1VlOXq4r7vjTtu9mWAdueYVhL1lriw+68H5n57GY/iapweYQmQkALUecuK?=
 =?us-ascii?Q?74Clak4Pm9RzsMSJEgOiszxeVCgM9LWdYXeII+evN7tAVpN8ylpKUOt332EA?=
 =?us-ascii?Q?5kbkwjr1zvdSH2yQ9mZyIj1c5WoW8cO0aMWmBmTujO/c/bBKjmH4w0vq70a6?=
 =?us-ascii?Q?bUkQNNtesxlngXuAamtbQ+PetrgAz0bf0a85PROiu+KWm/FfF1T7cqAnvxQN?=
 =?us-ascii?Q?RdaLv6e9i3zsrxfJTMt7+2BpBcJr3fJVg/5Ji3IiTAYO64RQNuO3mphdz3XF?=
 =?us-ascii?Q?0+UO4uJFarKlDwDVpJeHNRVP7ckO45QbebfErQ4CsiY7pO/+9GEiYUhbD2Sy?=
 =?us-ascii?Q?mnuEz++rQfMDlxmGute6pPucn5SLLZ8oowImFqeuvbuVgVMCacFVmHQ3pLc9?=
 =?us-ascii?Q?58xAn24R7PpnmXhcv3l98hmMt2rGCVy1SdsCQlNxPgTfSj8U+uGIRRpaweVC?=
 =?us-ascii?Q?b+rGkX6GGwKMNIMk8fIqvMUOsvF0/7JyUPsnXm/Bl9EjoqPPqy6Fxk8JUQQb?=
 =?us-ascii?Q?36f1qlSBCSr/MLiWH4wPv0PcVOLT/Vu9dVItpYtx4sfKfEbR9BXbJ+jTNRUP?=
 =?us-ascii?Q?uQss3WelfOnbhIIDbcLu3eOktg86k2vCusAZBA7fC3BH9MkvNFI15PbvGio5?=
 =?us-ascii?Q?gDVmQPs3tZaGkxuZQptChgrjZ2ppx46k05BN2j/HZCOL6XCjyI4A6rdvXP6j?=
 =?us-ascii?Q?zyDNDThOatrUyWT5QKrcPD+gpJ4YABqzVSWqrCmmcpAqbEPTTXYW4iWbGqs8?=
 =?us-ascii?Q?WJO9xCjxcq9Sl+OscVotcoxXgNpViDn5wFJO7AVa4eIVUUBNt+3Dl19jd3in?=
 =?us-ascii?Q?GAVmN15lAqSw41SSKkrIGshpryDCx38rBvxT6Gt1TQmsXT2UL1K7Z7HuePmp?=
 =?us-ascii?Q?26+y0GsKeCMbBjFEwen6P/AeFY1HFWbspMXu8IrbRPtNAnzvB9MseMgxYGDk?=
 =?us-ascii?Q?uq8Fz+s6Ss+6/lew0l5N+mFKVCWsXP8K1mzUYan7uy/6lInuRoqgbQSxZcpt?=
 =?us-ascii?Q?x7XwT794/5F7gh8cmdgM0ilL0k1q4MiRqb+OLIh68N489hbX12/qj5Z7FtlR?=
 =?us-ascii?Q?HGbhKZbzs/YmwU4vhhyR4ekVyi/AsCfBBTcINOc7xAEDxqjUaidp0rg1l9Zj?=
 =?us-ascii?Q?16cj142I9X2TQ5J1t9eKK4CNy+W83ZAZLcmVvJGo7uX6yTFneiWzvmV3DQeU?=
 =?us-ascii?Q?4rbWI34FG0GwSzuYcuydr45mHCpFCdHIOwb5DWKD14Nl/96qzy4Fpua7C/4p?=
 =?us-ascii?Q?+IpyciE0NoYLi8OYH6lin16imct370mHtXQ/UPhfxIFq+kO8hy56p6tW5vRZ?=
 =?us-ascii?Q?FtWQI5ElQpz3SsXCwEIwwuc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD14CA048A6CB24684715931F2E01C4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kgjM0/i/4VRf2w3DSY8kpmZFY+yrL5RjIaCE6brJOPUPykozI0s9YLjN5VmD1ZJ0fT2mO4D2p6QKR+Q3krlALHs14NsFr8MhpkPW0eT7iBPw1zQL7Z/4mgpt6teBXKioRz3am2PM+tsrlP28rbblKnoRXuPQ33TCt2kEY29B7MdJ5Tg4TpTrdM+SI7+qQileHuszjv0lZjkYdy3Ftl2SoIuXPha3+VMjKQBVH5vh9xzRxpV2nSDM66/hn1SGvG+WaE5ngD4oxYL6CJX82rocF4qxAV8s7Lqoq5/XTsZJ6P7VpN6M5cYu+hWI5NLJk8OqzLC1FDFzxwGtVjoNBw/jho0IYSxGixQH5HMRmalFaEeVdozUoBNH1iHu/LNEQm4CY0zcrnrZMR4Qg5X5Xgb7giCQW4lZvcmANuMUiA2Q3cEDewNYS9Yk95zbZX6I3E5lSNMe5+SxsVjgM0hVlX5Gaw96pLNY2ZOkCUOoby6UZ7RGg9wTmJazZPxQ8FrFZmf9MWCKR5lOhxBmG37UtFLbfmJTJrLItN3FXezaRJc+OBVpPgQClE4xei91RG/Hqoo/kQD2DLjCRaIZ72yx9YVOJP/0IEY9sAPi8QO+HmJaGE1IpgOuStr0mROScP40gLZB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad69cd3-dd2c-46b8-28d4-08dc4c714491
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 02:14:14.4917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsoS2GW1UU91t+9zHrjr+T5br2ffmJeHifcVN1AwP0eYT3GwtppaMBUxVSNGXFEJOln7ATX5pOuqUSAs2Lagntl8FRUnFW2v3wdXL0j24oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6716

On Mar 24, 2024 / 20:13, Chao Yu wrote:
...
> Hi Shinichiro,
>=20
> Can you please check below diff? IIUC, for the case: f2fs_map_blocks()
> returns zero blkaddr in non-primary device, which is a verified valid
> block address, we'd better to check m_flags & F2FS_MAP_MAPPED instead
> of map.m_pblk !=3D NULL_ADDR to decide whether tagging IOMAP_MAPPED flag
> or not.
>=20
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6f66e3e4221a..41a56d4298c8 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4203,7 +4203,7 @@ static int f2fs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
>  	if (WARN_ON_ONCE(map.m_pblk =3D=3D COMPRESS_ADDR))
>  		return -EINVAL;
>=20
> -	if (map.m_pblk !=3D NULL_ADDR) {
> +	if (map.m_flags & F2FS_MAP_MAPPED) {
>  		iomap->length =3D blks_to_bytes(inode, map.m_len);
>  		iomap->type =3D IOMAP_MAPPED;
>  		iomap->flags |=3D IOMAP_F_MERGED;
>=20

Thanks Chao, I confirmed that the diff above avoids the WARN and zbd/010
failure. From that point of view, it looks good.

One thing I noticed is that the commit message of 8d3c1fa3fa5ea ("f2fs:
don't rely on F2FS_MAP_* in f2fs_iomap_begin") says that f2fs_map_blocks()
might be setting F2FS_MAP_* flag on a hole, and that's why the commit
avoided the F2FS_MAP_MAPPED flag check. So I was not sure if it is the
right thing to reintroduce the flag check.=
