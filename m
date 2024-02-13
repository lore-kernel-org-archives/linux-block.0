Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5492BB12
	for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821656; cv=fail; b=oZq7AMLw/38HpGxY5ekMIg2R3hiEBNmDVhDsFmrOw9DpFiaOxuS/hhjuw/FfMrclZyTMdcx/bSJfh0aHRW4wGCjTjQ0MfSdBsjKhBIZkdjQF1z016VDDspAeXI7ecvOEOUQPpzf6hP3h19P0vsF5XgpCJlzRkD6H1yPexAimm4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821656; c=relaxed/simple;
	bh=/jkOoKjCOh1cy3sbIGPdeb+jHSTy3cTW6tJPArO03OM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UaaX1OAkgtlUtt4Rm9jo4jJrxXLPyEFFYhNLyUOT86UN8eF/PkpNFSTPCkxin44IeijeeS40WI1iE37QHXSn+v161eULhdp8Bz/t+Zl7gvvU/+A1J8nomTI4pN45/vB8b9m74+andRgK71AbIKBEk3H5+YG8w++PmGcBPKsUBJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l3nwN3WM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G2keHrtc; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l3nwN3WM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G2keHrtc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707821655; x=1739357655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/jkOoKjCOh1cy3sbIGPdeb+jHSTy3cTW6tJPArO03OM=;
  b=l3nwN3WMsC8YXj95FtwxQG3LKnvwPb45xUNgBm6qQ8pAtldMQfKHM8Gu
   8YxD+dsPwA/BIPQ41LJf+2q28LNniThTnXQ+Xwx018Mv/3+Shvgk73gH8
   IVPMUSAf1KDx2/hFQ4BEdxQFFY+Ht5QQQsh5Ii74sUHCYa7S4IS35Fe8q
   OjQzIwHrUjHhLGfXqSI6atXzcRqAUWoC1Ite7aP/7JnsDqXJMSk0UgpYv
   apOq09RGW023uN44pVZhO+7iW1ZMJLMX4LGVjVCuMu0R2N48sMCKAB9Gb
   RK+xog49cv/jAzPQZmQ69iFPZsVM3NVHaenubKUkah2s0oo/QNM4I/ix4
   Q==;
X-CSE-ConnectionGUID: zunDDBZiT3eo9TEdXN8XCg==
X-CSE-MsgGUID: MYKjMbvEQWuWtizBInfxTA==
X-IronPort-AV: E=Sophos;i="6.06,156,1705334400"; 
   d="scan'208";a="8786463"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2024 18:54:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2hjSh82isUuGmkOGJydWRugEpmG+KBsEAbEf1IJyuLzK8aMfZxzvibVJ1+sfxBVc3iLD+s7JHLLUv754/N7xVwNrLKoyO0mFe3C1aHtjhikSw+OQyctBJNdbSnHdwPA/ZJmpulPZkybQhozDPlhivnAraszK9Vyed9/H3UdF7vrQ1w4D1WfZD7noXp8PpwxFO3yJAjiag8KyihNHNR7YZqxVZMeegnmgSxQR00gWeB5UYAdrShgjhH3w790DlA1P3kS9HV/OxGoM7932WcyKMH2+KSL+8iDgQ0M23LJGr8Y4jhYBX2N4zxpzBI1vleU0NnDqz1X/AlzTax3l88SnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHZGgFlOThudMeS33Uq/AE5G4QQoR4sZd+FQbuz82VA=;
 b=E6SmJSOgGVjoNZrJ0HqLyi5YiIjWs6mQ8XWV2nEiQ+oEoJryDKvav568Vzmd6SgQjyhtWvOuSmyXg0h8RLLsICT8w2UoNvagzDA78BbwQAsIo+p0durSqqfSdC6cTumzOBAT9yCJHvn0J1m3/77kPpS9EFj/0W/lJQQDUZx/RAAT4+0lIhYS13qsc8Vje7Ioi/0oEF1HX6ozKPrzpaNtZt6X5ZhjTILqsrVSvZrOKOqVkJxVuLSbxEaY9WKymGwMbJlQBBkUdwkiGummyBzIIXJ2yclTOdaXFnz1qQ3fXQjmmW8aeSp0RAvEY2DB4vL1rdal8XmZMq+U/twm/X5W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHZGgFlOThudMeS33Uq/AE5G4QQoR4sZd+FQbuz82VA=;
 b=G2keHrtcIWd1B/GqRrarSNZDJhwpR7XlJleBaDPCw/d86f9sdvnf2GApJAJe2bDaMaiO7kG9Yx+t4ItaOVoZbVeFCufvt/Iqno0WenfRNgjZwzU3zqC+pylDIymEX0lSWJT9FxB97wDmdaK1bobmETbI3nYwBBEsc+Wi0spFPv8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7506.namprd04.prod.outlook.com (2603:10b6:303:a8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.39; Tue, 13 Feb 2024 10:54:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:54:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 0/5] fc transport cleanups
Thread-Topic: [PATCH blktests v2 0/5] fc transport cleanups
Thread-Index: AQHaXZ/1Vyhp2KF9UUqprSsVPYORxbEIGqmA
Date: Tue, 13 Feb 2024 10:54:04 +0000
Message-ID: <j3zyhflzekntg565jzo4bbpbcxvaxdafm7xdgxxutilfovzdta@hxt7gx3r56sx>
References: <20240212104046.13127-1-dwagner@suse.de>
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7506:EE_
x-ms-office365-filtering-correlation-id: c7470861-4763-4499-e0d7-08dc2c821821
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SXwmUDXPj7ABchylUad/HpGbwu9kWGFIN7kiqVWoRuTZNmV4bOH3jvbjyPb3SndU0oo9fSxddIWv0+xI2S8Y2uy7T30wx1Qf4EFwxmzmfDVLm9//4q4JpuLLz7UBF++euVrW0219rgp6Rw8RASXhzCKP727YhGxtzA1xGvENncvJrauYFTUTSwAw07CNz3U4EHRCqMP1mkZxTRgZXBVdJCH6B2WrwIBJ2tBnPZft+erdjGuHOSv8phSqWIRRc0rPSPRU5zA95uPs2yBq7BQA5WPa47TEG7PSzSip/aiXnWgO4EIHYMHufZVQU8xGNO+RXM9TzLGxye+av+7Bc2FNtqqgyvsq9mjm5xFjJv8Yhcg6onbwaYtbho7Pbn7czJ1XXjSpl9O1AqfIXmlziEebjhB0ei5Cju6jim5rPDe4jCdYf51wCm4e26gQ2nn9EWHGXiV/Wg58Byf+yplQUVfQ+k7hFL2dxD74SfXR3jIcPe57pT2g6+a0QmpcECs1IY5zoLahKtrjtjnOyPxiOAGYxthHS/zTCywvGxeuOjkMfSy653fnUVLV9sucbAY2h8e2Gn3I/lC6cQCMQW9i2EkuFV7lXfK/eEbcBcbM1NyIj4K5CbT5R74B+bjjkFVx3Mvv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(558084003)(38070700009)(6486002)(478600001)(71200400001)(9686003)(26005)(6512007)(44832011)(64756008)(4326008)(66476007)(2906002)(54906003)(5660300002)(66446008)(66556008)(76116006)(66946007)(6916009)(316002)(86362001)(82960400001)(122000001)(38100700002)(8936002)(8676002)(6506007)(33716001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iUDW8o5mSQPUga3BsmUFD3WRv1AtzxsOUoIZYy7mNZeCf6w5fzjMuRSm65IC?=
 =?us-ascii?Q?+jksNlHthG38468rQA5BysEjOtI52fnONO3hskFYpuZGs42q/sXcRRLrZJDI?=
 =?us-ascii?Q?BwlFn92mUUgR0mwF00hnoVkB9bIveUyQ5RCwWD9/YM2xX9sQR/tcDo9wbtW0?=
 =?us-ascii?Q?MFi0EByyuQtJ1XWVr5tmPKh8JcNpPsJQqiKp37MqKt4WGmJ2gQ42MZ2VgNTF?=
 =?us-ascii?Q?LNsTkRkLvVkMGFAUGNr3j5rVUSS12tQ5aUeKvls4+tcJ+rnPw/F15rFXToM9?=
 =?us-ascii?Q?xMF0XYrOSrJ21DZEmNz7MdUbAuvzkYUicXivXpl24qj2pP8cXCuwsGYv0pGo?=
 =?us-ascii?Q?i7oztglvzBI8wS0aT58ryK0TG2ymx6UGg+xvTB0EuTAlH3eNoNzp9YmKvBc1?=
 =?us-ascii?Q?JDz8TTKmyXgmzVpyhdJX9b3tSXDIkznzBgUb8mdxIQh5dfUuEItksgjqVezJ?=
 =?us-ascii?Q?XofoQd6C75FudEy5k0TbEyzsOIiBHTQEx+aRqQethMunHQ7H5/8E1haO79R8?=
 =?us-ascii?Q?gOgpFgOW1SDPwf/ZZ35CcooYfCQtyb7PnuKYMDULhPU3z9LJInDG9OTGvhT0?=
 =?us-ascii?Q?4Z/K6kGkq7TFDBHzAmk9wzv9q/zF9GpIz095YeKJBvYZ+QhZQlJqnUjEfjrB?=
 =?us-ascii?Q?W4rc5WIOKVydd+7FbVs/YNMe7Mde+Kj//L5WunEmwcZVNRKhYrv8F+z0xDDp?=
 =?us-ascii?Q?i3nmd/3XEJtteFxAK/ME5TzuzeT8pICnad1ZaK2box2N3Kh9LYIdoHsAsQlI?=
 =?us-ascii?Q?X/oHhWTXbnkGpHzjraT3Jn0E3zyLpf3K9nZdUX2Bjmrp++kd8Y1BnZID6akC?=
 =?us-ascii?Q?kl2hudJNaG16VWrFtWlPgdcBAJ/Tw764zEA2sv88AtXcMNnBUm2jlZMcxEYr?=
 =?us-ascii?Q?t9DkpnXc1L4n92Wjj1MLWEfM4ABmV5wYTPjUXG/q5Vv/QEOKgdla2dgX1o40?=
 =?us-ascii?Q?/6sz5BXV0h2kt1ZwDkdMmL4mZ0jZtfFyEQDj91wL4UTh4djAvGvBIbx7DTge?=
 =?us-ascii?Q?57WyKr4xH2VFPH66gHSw+qDMPG1ezLnycphUaro9nmwmd9L+VHxKcLxMbAFn?=
 =?us-ascii?Q?twJONz8rN674GZbb/oGr2K4CYyiOlAujdC6T9TXgStJGMiZVx4RmoZKtFAcb?=
 =?us-ascii?Q?0tNJh0FiqQlFuutd0TnMlbIeKfklsSztKciWp+wyY/4AJIzFJqB0GmVovdGx?=
 =?us-ascii?Q?/8+7jnab/ndk8U3sXs/uaEEuD9oY2fdRDZfVux+57oRgr4e6JnaqTsAmSRlY?=
 =?us-ascii?Q?OhYsfD6DdtBQvkRbL00qZqBch7tmuzlO2cFdEwN73NaN2YooqTAY8JIkW6Bo?=
 =?us-ascii?Q?+3XIm90BYQqiAd3iA48y1l33EAe94tf0IN+Lput/l3N03Xwtj9PKYhQaxIeq?=
 =?us-ascii?Q?h459aZQhzVvNy9Byk/uCaJDUHX3gO09HB6IyML3wzM6msad2htrGyC7MpQlb?=
 =?us-ascii?Q?do4MB7aqJCbTVx1VE9WujpuYd+aR4vzZmJFOnerOcEE4WQ0NVBztMD+QVtnO?=
 =?us-ascii?Q?RhlZnQkeqtuwcBOCLmFcNs3Fqrv0H9Wo2zMhg+2oNLuBsZz+YFpDZE3VSsfM?=
 =?us-ascii?Q?aRk1IOh5ah6k0FmWuJShzukP8xUrkmBm1o5LjYtxr+WeZY83mJePS+PnMaac?=
 =?us-ascii?Q?NEBkmxhaDbOVtg6ocgo0dl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2363BBC88100024E81DB996F96807B37@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7sTmoX48dusv+vow7KX8/KYwAWDsO/3q5hVVhzMhzKY6CYA0ZLV+WulKBYPpWpKQj/LDB57DSG5u2I+9nqtBmz3lBXNZXDe1mdmkJMtfCetG9QoQUFx3R3y5Qs2GKRndCTGOFQZ3t+kGtncgw6HiSOGcvC/jLnm03Sw2+nADrhsFazFWMWX16gYjTQKiT5ZJZvbXP/mO8Na1zteWJgu8pouMZ2ifuw2HMbF5MgmgQgGoY8vB4alm7Yrdj9Hrdaj38K1Ue3/rTgysmDzZ4CpU22iGdPHltFr3C9a4BmKzmEavk3d0NQgqVkCIbpV5eU3GA9+0cmFAKdsVrs/LzOy4XrrunKITE0VT4xrzj3V5yYHrV6PpVh/RiFQ3U8nS6npIiNkqMOGpdYelwmNYkKUwZ1BxeAmvRVzmX21ZpJy6KIPa8AGFto7hY4eD1dRyWYroVYB3j7mfasM/KL2gFz4mqHWVBY4wF7FyAORyad/aEmKNv7FgisLKDcoR1UHXSPJLMRmLZ59i96mG/bdmC+iO2us+E+0K6K1kl9MyC+x6nD5kPckAyIO9C0/BsayhhaC1GBB7VcKrffm2ThXoCJs7xyKUivAiX6rcn31C4sWvmZMFyBwdFUpf+9RpLFJV/Hgj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7470861-4763-4499-e0d7-08dc2c821821
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 10:54:04.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76wjTfJHeKcriruHzuVb5EzPlUWtpx90qSxmxdwzQ0VG41vJtU80Hkvlp5ZSFg7S00VJt8MPrEQBWgeXOjOpAiAtNP/PpTUSfqKD3KwnLus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7506

On Feb 12, 2024 / 11:40, Daniel Wagner wrote:
> Fixed the typos and collected the RB tags.=20
>=20
> changes:
> v2:
>   - typo fixes
>   - collected RB tags

Thank you for the changes in v2. Applied.=
