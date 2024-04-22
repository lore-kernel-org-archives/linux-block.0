Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12B1465A2
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785718; cv=fail; b=kh7QnlWhnOLdpEhChmZbL3r6r7X9fpAh75WsptYJ2Kt1vk/uKiHuk0Ts79Dco0qDLaA9SRH7lGnh0qq0VZIGDqsaJ/R8itpMovMt/1E1z0bGrZXUr9yAO+pV5K92P3O7ISRMaxn1atF1oXQWdquGkP/euIDmaeaCyIEZ0ekobXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785718; c=relaxed/simple;
	bh=HD5/y3gFEAIBenqv5L+7+2yi/4l+50xZN6lEh8+uhcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UomnCUKOiOpbqpde0g3woLIAxEd+de5djX2BEfHHxtY/4sCTlmUXSL/iqwDatICFilzqKzU3gbpiNTnA6lN0Y7Y42MDy3anecTsQLviUygB80QAbehwQ55NrY1tuc3MVqFEqixduBLyuvhd2+jwRQhlgY4gmnxfA/DL+9uWtXf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pe++WE0j; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JPym6ruZ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pe++WE0j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JPym6ruZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713785715; x=1745321715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HD5/y3gFEAIBenqv5L+7+2yi/4l+50xZN6lEh8+uhcU=;
  b=pe++WE0jgOYGj9KCDl91gPgqtjd7wELzzzFAEYdO9HHKekFmbeJKRaK8
   hawJKVCpIANK2HlWi7BEXkgiBc+9yAXAid9N4aj1asakQU9Jiy9l+B3nE
   B0CyVwaPGfhjV1NIpWz5XQKGImwja/Z2LPn2E6srE+lkfCMDWsYGLbQJF
   f5/xrpotse1dVSCx2Gv9v5OuNWHIBCKLZzybvUs4cqO7Kt3eBbyBQsFJZ
   neb08YJmRNkMVAP535957rREA207sEfdSh9CpXXCOoLgRhDjn4GYMXuZL
   YfUXsLgq1xkJyuzwHl4MlmddZnI1+ncqBY0jxmQjONecmUDi04+nv6feA
   g==;
X-CSE-ConnectionGUID: iEywpUS1TYeQ4LzvSPMVjg==
X-CSE-MsgGUID: E2iAwMZKT2q2tZk3gHHBTg==
X-IronPort-AV: E=Sophos;i="6.07,220,1708358400"; 
   d="scan'208";a="15277050"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2024 19:35:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2UkB7Dm0TkrsBnprNiaM8I7kmSrleLgeylaB57HLH3QtgFyxNU9n6+BrXQB7bvL8E5sJj5XOLiDJqIcZgpDDGgcdwzIX1Ys9R2viqpK8lFjy48HdtffGwBx1CE4Ha5+eYIZnL2+yv/XtWfM2DGk6Vgaxgq8F8yUMDttnDBZHqtm/i29V5Q136ymxS+H6R/5xLKF7r+VN4Qo0gd75U4HIxzuNqK1C8o4q8CT+H/NSOIkeJUQnV7965Ku/XS+IPX6a8AtDfoVBA+K2gaesx4yqafagTFu2LrqTydnT9SRUftZMja3oW0R9M1wUIklwuUzCRlrW2vTHF2/Ptv0DLvw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMu3bXkUDL6lSTVMGKnBPds/FdJU75AFJjF+qBomfPY=;
 b=G1mp2WArsKcO5U+mBm0eCleXpKR2jCdVbHrXB3c/tJZjrP/2EmpDkFDuVLU/oGFNrEOFDKYsLDqIr6FFRejSsg7qmIiatQEyihr2UPv3oYhwJkcaFr4uipte47D/p1SFuPMMhbXeavNwhQclhOgmzqxIQYKPMV54VZvM5GcHo5ViZDsbUpATvWYFZYX0Y2OIJY6BsBtTpK6G2fTpCPa0nez8nnB2iYlJ9rmcgPRmuI30UVrVMK8POLexFdlktBOSk9TTg3AhOzEsf8pLuyNezGxBBO7RhZ0ilkdJpfZc8Fbc04cNIHKKmi7DTnJO5IP5Z6U9fZblc1huv+w29yF/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMu3bXkUDL6lSTVMGKnBPds/FdJU75AFJjF+qBomfPY=;
 b=JPym6ruZSg43Gks/fwLUqppTym3qYt8UA2VLVvsdANzbhgNJyxJhFmVhHSf5iJrKtuZY2dy6gudxCP3d0KKf0R9DU5omBg8rbhrxwcQnKOONj4VjFJ8ZKPuABeDu+3grrve8iFZgBydkdRVwP7trkOKldBABOFe3JGpp4FRot78=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8117.namprd04.prod.outlook.com (2603:10b6:8:c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 11:35:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:35:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v2 05/11] nvme/rc: introduce NVMET_TRTYPES
Thread-Topic: [PATCH blktests v2 05/11] nvme/rc: introduce NVMET_TRTYPES
Thread-Index: AQHakXRkuevM2ZZgGEybNCn/HW/s2bF0L1WA
Date: Mon, 22 Apr 2024 11:35:06 +0000
Message-ID: <k424ljam2uapxaehubne7xjzbwyrmmr4wlhdpwjjru63lypecb@4okxgocttvwp>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
 <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
 <35a9cba8-776b-4894-9dd4-122eccb68887@grimberg.me>
In-Reply-To: <35a9cba8-776b-4894-9dd4-122eccb68887@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB8117:EE_
x-ms-office365-filtering-correlation-id: f8714faf-2813-4774-fd07-08dc62c0420e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EgCVQ6OZDG6BTsiD362bfsJ+Q/FL69OaaZdNB31zxkzXFqKXuoYyuDhY2d8l?=
 =?us-ascii?Q?+Lo36EL7a7m9wyuSo+98YwTtQxSt3pZtjyHIbx5hNRsJWKhfkR9pvKlEdZ4R?=
 =?us-ascii?Q?/XD1Squ5lVHG0a8V5BbERVjAEVrfsgdmj06EAs/JDF4YBhfj19ygyIuPsOO/?=
 =?us-ascii?Q?ChuiaiMIiXGVVsJoCoI/xsCmrAoHgnXDtmzhOjr51qEuofD1u6DQExDfA73f?=
 =?us-ascii?Q?R/Kvk1SDgrGzWQdxQfMd+ivhmr8l1qkEAHP5scGjdnBUOKH+Uuk1jgkcOlha?=
 =?us-ascii?Q?ozrM8aPWjk1Zb7kGybelUlGXnklWT63yv8Epbhiw1lA9cBglkFOm61iBtPN+?=
 =?us-ascii?Q?vx+iVeuy2SmwEKXloqlKB1shff0ROA4euru1f0FrM/mmZ71hNqeAjdxjHiTz?=
 =?us-ascii?Q?dAZuSgDboqaJifC8J2I7XQIPTqRpzH5+TQT3uXj6w1VEpy8WqTzGZYb5rUJi?=
 =?us-ascii?Q?o/rf3Vm2D3sD5USWitcx3nPEJ2pPz6cdj5a58/xJZ9Ml48hBa/z8sdQVT3kE?=
 =?us-ascii?Q?/Nn8PrVEw2mS14DLiKMMaaSXlkjh7ktWUKuM4Tg3oZd9WOQ4r/5jiYgHxmKW?=
 =?us-ascii?Q?QllxMMkqCatGqlJ6UDjvxsqKmizLrVX8+0N1soQZQQ2bbcyhVY/MQRBJnzMr?=
 =?us-ascii?Q?Fg4ltroCddPz5IE6iOTp9DiByknJAtcCW+uPqxjnvcRPrgNVp7ZPk8a3jfXQ?=
 =?us-ascii?Q?Lo80DYKpJT68ZjYnvWfOqtXkxng9IJWd2ivIWFnKmcXtXivnvkPSFvFAMkB0?=
 =?us-ascii?Q?3iUC+g+LOcpEJTJGrvurRiaa9MUvwC+bBz1o+yy8M/l4xd4Q0lUSdALLQzSZ?=
 =?us-ascii?Q?vN3rmWpJDEZikVl9WxUOaVFRLfm3BtMNyo6QgxhUbDPYe1apMs8uB0NTvQw6?=
 =?us-ascii?Q?lYM+KpFAJs12wRzQzm39USmuaZR0hWiBZuqvWPcVUUbIdy4AQ2P53lY7nAgh?=
 =?us-ascii?Q?qlmczewv7FmTH91xvpWIXk9yu2rN4Ul9rIrH0Re2jh7NfVvaQi/GXaDrmTGn?=
 =?us-ascii?Q?32N8EIC2Bv67vgNmXbLtsMp1IkzmNwmpz0I8nGEM7Hsb3/qEDdTxCXNpsS5N?=
 =?us-ascii?Q?fVgVGvMjosF/eGzMeMIs/4wvxxD1tRrC4Z0dlbJQR44XIgQZbd6wWpp8Xl1y?=
 =?us-ascii?Q?KX3NxJDHTPor+XqPA4VWriSJwpw3oQ12eTlqwX6SHTcxa77jLpS6sweX/v68?=
 =?us-ascii?Q?KGidLbssFxzZb31fpl9ANAmoijZNoBF06USgsNTk7Q3Qw/sdFifgvKLLk22e?=
 =?us-ascii?Q?OIu946xGwwWIBFyzJiapFb3EVe7KnF1y0etlHXQpBzG5AclB/X8pdk23uTwW?=
 =?us-ascii?Q?4bJ0vs3ExxX9x7ZlcXhCdZiNvHteHrmi1+bCmATPwft5Kw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dwJB+1wbvSv7mIgDmvSZ2NN8bAOGItj1187n2V9OtFwX4Q702bPV37o5npYH?=
 =?us-ascii?Q?0wvQA5/jMjCqFueKgDLs3W9CgvaN+BECBuzdOcoN1QalT3lFG0cksLNogtF3?=
 =?us-ascii?Q?sIUiHemnPOeCTb2v7Vn6YFstSHtlHbk1qWsZn2ZzSzTmVulnZPIzeUwskh94?=
 =?us-ascii?Q?Q7TVjSt3PmHvBYL+5Ig7ABa59FETu7022abxqvwyywq0B0pMhGq8XJeLFfX7?=
 =?us-ascii?Q?e+UA2ToFTPSLTVhtJ38aHLn1t3+Cso6hbxGR8WrsxQDoiVXJvjDysHuP7zph?=
 =?us-ascii?Q?jzT297z8oZIh/K8ZCwfbEQk21EIlLcolx9TllLSEU2GQjDff3HrjsitlEiFE?=
 =?us-ascii?Q?5U2/faIn3D/R/j6bQ60+faWspnYLGf/9zPdhVkpsJ0098OI2ePDPkXE8ssXL?=
 =?us-ascii?Q?YrVl2kzhuivHMYtwJl5ttz4/uKjXntTn0Z2BFXnFBocFQC+q79VJcOg7wG6R?=
 =?us-ascii?Q?7schezO/+IiSPK8uGfiY5mkG+Kew9dh7d+1fBVOgQ70F3DrOhB8HqE3WSNf2?=
 =?us-ascii?Q?WYpVWZT8KgDwStDD7uJcNcOEBnTDiRFEZqqTkQeBHLtGE1evOLHXgY7FOcXN?=
 =?us-ascii?Q?v676V7yeGoDMEF6CElvbxQhD0mldXtLgnShzyaOXdxuPZmLDkIJqv+C4dHUp?=
 =?us-ascii?Q?r0LBdEd7QeWNHnR+ttPWUzTIYRzeS5GQ3/pDvir8XddqczrdARpUEwOr0rGV?=
 =?us-ascii?Q?L5pelQTYrzqsq0JLt4mzuJM1D9zdlURvoCHAD+BahdSH7v2S21+arwM3p3ZA?=
 =?us-ascii?Q?rdMfnovTnR8TG3FL8g8fGn8BTbdWFMFtEJ+oehU/v6HaVR/t3xvPmBF25rra?=
 =?us-ascii?Q?rKnIqSTheQTbDvkMzhQXggjcMR/WtkSWQSUPImiSfro+MP+C6SHMRQ0IWbhz?=
 =?us-ascii?Q?tAU+1ktkPoLhr8lx0pcTThinqub8kcQ2LZHleSWhJHfOOFOrnizDxIxi+v2d?=
 =?us-ascii?Q?CObl8QuWGQymo3e+b5FrqoRRlPy8MGUHnETUAPVCrtNeikMwfEHFcqufD++n?=
 =?us-ascii?Q?myRsnIO2ley0A7YpyPSs5X0P5FfYrfaobcaFeWfDBtRjo1HUwiJ2hoXqgGBH?=
 =?us-ascii?Q?rfr7XndyqopqDuB/EXpfum7lrArmF0GlS6HeOOupuBwVLHLfJnfXzozR4pc5?=
 =?us-ascii?Q?pl40wcujR/zDX5xoc1nF9smVv7xDl9NIW0rJaCJO4uFC8Tny3y+/HnneE96Q?=
 =?us-ascii?Q?oQlb9gOoHQs7cehLPik01QM+8eeBlpFykx66ShWc7IJosMxspBdmM5A8uSVV?=
 =?us-ascii?Q?eoJtX4EE35elX0j8cI/Jkj1JMGJweCaWXPim690WqFISSK36HHvJvXFlvL8D?=
 =?us-ascii?Q?HSQSGjo6i7UTRlnlg2I9jXbpHxOw/fYAUHUojMy5Yy73zcVs2GC5aKPfkOGT?=
 =?us-ascii?Q?PhPqDDvlLTHobLBNu8mdAqXQ3KuXuOPzuX18FPe6ChbGOMgqy12ufEDFJWXr?=
 =?us-ascii?Q?cFtvz2VVGfKIKKoosqckRcuPW3hvuT7CYWQ7czNAW3zQ5nKyVEqNA6hShQl4?=
 =?us-ascii?Q?dNmSoZ3ODcZmK5MAEsGN1MTtjDzhcNaQzfzbBbM/5LEHsSFHYmKkHjskDrwm?=
 =?us-ascii?Q?g83+xajD9ODjiYggMGUzC593GS6gLctqmsKKoSonCK2mkIP955wgP7Gh28bg?=
 =?us-ascii?Q?/3YyJQ8k5iyKW4ldETD/Zw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB27A0406943C442B01BE29D442BE3D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O+nRjR6J6vcqjnmjW/wPIYmzEfL8DsxV+Tz0Z7v/lp3CC3gaz2edM3Ku7U1iTy9lpBLTX63IMN/VVq2UbipvZdYjISu5181z0mXj35WrQyigSbCv6XVZ34SpiTLmh+cr+3F0UA80+Z7/dTUTtrL//nVqkjJeeetzlka0N8cgMN1p4G5nPOUgT3ZDT+0LLTchw1dGSW0TpannH+MBeiNQ0igjZMoKhm+nfutd9uhEP4M5khOk1cv9IPFexOwaZZO1rTYVLoOGvN3P/U2mW9qZ5jqEdXX5Ay8eD3I4h5lgaQOf9yZlq8PcaWWYJ4ElK3MKulvfE1HF/lIZEfeqsFITEsOWx2NwVMm0HXg1KaYEr7p8MXjJZ2d6yAV0zEoSh87E+UVCRsvbjQzHW7mVXiL1SPMAC8sjKqvhZlUcmX9xIYYki47t4jjbvHAnPHUEx7CvyMJoN1MwjE86VtGnVIGbwyX8Y6eeXgC64Y5ebrwgp2FEzIeZKh7UqS8BnEWckwfvi3UZwqA8wYK4AgPh/7WchlgGjML0n7zzbUZBB4y6qkePXAv9FyRRoEYvD1bINOWejOce7m93T11mHDt1iFgFgLlfbBlATnFGe1NCdhcAuqw6HH3m9oCAVJh7P0EyftUI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8714faf-2813-4774-fd07-08dc62c0420e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 11:35:06.0759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8UE5W3G6W8sPKCxmVZ/JalyG2a4BorKFzbHbuiqTNZdji456e0oc8X/VnIX2/NOc4terJjLO8yStwHoZB/uKfZ6Wf93Goh2uNB5STkarZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8117

Hi, Sagi, thanks for the comments.

On Apr 18, 2024 / 12:39, Sagi Grimberg wrote:
>=20
>=20
> On 16/04/2024 13:32, Shin'ichiro Kawasaki wrote:
> > Some of the test cases in nvme test group can be run under various nvme
> > target transport types. The configuration parameter nvme_trtype
> > specifies the transport to use. But this configuration method has two
> > drawbacks. Firstly, the blktests check script needs to be invoked
> > multiple times to cover multiple transport types. Secondly, the test
> > cases irrelevant to the transport types are executed exactly same
> > conditions in the multiple blktests runs.
> >=20
> > To avoid the drawbacks, introduce the new configuration parameter
> > NVMET_TRTYPES. This parameter can take multiple transport types like:
> >=20
> >      NVMET_TRTYPES=3D"loop tcp"
> >=20
> > Also introduce _nvmet_set_nvme_trtype() which can be called from the
> > set_conditions() hook of the transport type dependent test cases.
> > Blktests will repeat the test case as many as the number of elements in
> > NVMET_TRTYPES, and set nvme_trtype for each test case run.
>=20
> It would be nicer to keep the same name and just have it accept an array.
> Not a must though.

Okay, actually this patch makes nvme_trtype to work same as NVMET_TRTYPES.
I will update the commit message and the description in running-tests.md
to clarify that nvme_trtype accepts multiple transports.

Though the existing nvme_trtype and the new NVMET_TRTYPES work same, I thin=
k
this is a good chance to take a step to replace the lowercase parameters to
uppercase ones. Will keep those two and describe that NVMET_TRTYPES is
recommended.

>=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >   Documentation/running-tests.md | 11 ++++++++---
> >   tests/nvme/rc                  | 33 ++++++++++++++++++++++++++++++++-
> >   2 files changed, 40 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/running-tests.md b/Documentation/running-tes=
ts.md
> > index ae80860..144acd1 100644
> > --- a/Documentation/running-tests.md
> > +++ b/Documentation/running-tests.md
> > @@ -102,8 +102,13 @@ RUN_ZONED_TESTS=3D1
> >   The NVMe tests can be additionally parameterized via environment vari=
ables.
> > +- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
> > +  Set up NVME target backends with the specified transport. Multiple t=
ransports
> > +  can be listed with separating spaces, e.g., "loop tcp rdma". In this=
 case, the
> > +  tests are repeated to cover all of the transports specified.
> >   - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
> > -  Run the tests with the given transport.
> > +  Run the tests with the given transport. This parameter is still usab=
le but
> > +  replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
> >   - nvme_img_size: '1G' (default)
> >     Run the tests with given image size in bytes. 'm', 'M', 'g'
> >   	and 'G' postfix are supported.
> > @@ -117,11 +122,11 @@ These tests will use the siw (soft-iWARP) driver =
by default. The rdma_rxe
> >   ```sh
> >   To use the siw driver:
> > -nvme_trtype=3Drdma ./check nvme/
> > +NVMET_TRTYPES=3Drdma ./check nvme/
> >   ./check srp/
> >   To use the rdma_rxe driver:
> > -use_rxe=3D1 nvme_trtype=3Drdma ./check nvme/
> > +use_rxe=3D1 NVMET_TRTYPES=3Drdma ./check nvme/
> >   use_rxe=3D1 ./check srp/
> >   ```
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 1f5ff44..34ecdde 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -18,10 +18,41 @@ def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> >   def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> >   export def_subsysnqn=3D"blktests-subsystem-1"
> >   export def_subsys_uuid=3D"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> > -nvme_trtype=3D${nvme_trtype:-"loop"}
> >   nvme_img_size=3D${nvme_img_size:-"1G"}
> >   nvme_num_iter=3D${nvme_num_iter:-"1000"}
> > +# Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
> > +# If neither is configured, set the default value.
> > +first_call=3D${first_call:-1}
> > +if ((first_call)); then
> > +	if [[ -n $nvme_trtype ]]; then
> > +		if [[ -n $NVMET_TRTYPES ]]; then
> > +			echo "Both nvme_trtype and NVMET_TRTYPES are specified"
> > +			exit 1
> > +		fi
> > +		NVMET_TRTYPES=3D"$nvme_trtype"
> > +	elif [[ -z $NVMET_TRTYPES ]]; then
> > +		nvme_trtype=3D"loop"
> > +		NVMET_TRTYPES=3D"$nvme_trtype"
> > +	fi
> > +	first_call=3D0
> > +fi
>=20
> It would be nice to have the string check be done at first so you don't
> get any typo-related error later during the execution.

Agreed, will add a check helper function for it.=
