Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7617BA0
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602164; cv=fail; b=kfveNCCIxv7TqR2dkkobXO+IvTYFbd0ZfqAO66Pjs2w2yCATY5sAHM21HoKv42lZQ1wtm+1YhJcycT3OTbMrqkUVgredIsKWe/9uVn082MVUaRviX8AkiCOyxJ3+SM2acm4XkLvLtSj0XSUpmJNJJZ2FlYOMPM64puCPZlwZX20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602164; c=relaxed/simple;
	bh=FH6wQtMb43y2Rvn+W4m132dPihgXxq1UbFR8Ltw9Tc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0vgqzf2Y5avZVAEklapygHP/2UlXMEHG3w99B2B2cN5fTbr5oI3HGJupsziJWKgFU0ieVCTF+TJv9Ez6ItfbPKNKsDCvigkC/IS9mMVjm6YZUN28qn0mjgRHexsX+TQ7M9/WD8AojtbJIq816ooF1mpiK5JjI8qQnhe/LDyObc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iK6OSoCC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WYfA5v7C; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iK6OSoCC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WYfA5v7C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709602162; x=1741138162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FH6wQtMb43y2Rvn+W4m132dPihgXxq1UbFR8Ltw9Tc8=;
  b=iK6OSoCCVHlZ1b/RLx4jzSA2CEaIPHTAhFMnZQiJySJuBB171FUUL14u
   bPnk7wbkyHwG9ha7E7smIfg5ry2kQWhXVGMVvQXWjYiucTmu632UzHGoH
   eF2ruMPUKrEotiQc6ceNGrCAMOHIYZcgwSTCdzcle1IGaMeNBG/LzAViu
   iEgbc7lxJOFho09zUmxutRkGjbtoNSmVUEtoI2VMC0+XcAZFMuFr5ylfQ
   gIF/NTy3Pq+G8j35e0s3ooIQav/5DIjjgTmzVWRRRqhSyxrTgg4NSMnCp
   Vb+BVLq4PF2LIjPXAf8VRrcoRSfmkWIDWmfakVVnVoSxX1SsQAWzqlNpN
   Q==;
X-CSE-ConnectionGUID: VT5J1zDWQ8uD3tbQpI8zfA==
X-CSE-MsgGUID: zI2zt3DMQWSJk0uDBw73iA==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10774980"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 09:29:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBaIkOyHkXJpMmqrWJ1gAIQoZBQbLxqm0Wv6m8TtZqlcGNPMHNHqzcVKFry089BChiy1H1385wBEJw3b5hnfOJx3jySVQr1LD6CAOFI6WZqvF2SyGjdDJbKTBkYLhbceD0AfHzXugL1UctniFzcTW8v7YfGcRLsXySDvh7nroYIKVG1Bt14aGUUFr50WXNtF0crQJvHvzyXP8s7ujx7EUOJbgZtSDinmGl8id+Zf6ClAq4U95IRhEzPVcCary1+myC0GxH1nng0BEzBxlMVLZx77y9SKGCvK08qdbyfU0aaPFcNVfalZoLDgZKESi2BZAdb5bjAhcSb9Xobt9G3K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlZErS9awIKsXWo7aqvqqoD7P/haSF/cuXcIitbmqxQ=;
 b=ffdZM79lDEVlp3sb5RnLMmlnDbw2j2T8tiuXltrzWs5xppo2HqVZ48JIQw1rwDInMZqX3esoNTBseCvNA9p9wLgfw6qJQfBYXlon7UOr99m0uPneVKcriRHMAfe4O6LVR1UFsHlw2hy/sJWZC1eh/+iglHulcGweUFMCCm2zRp48xDGEckYXuA5Ty7tff7AFooGGLSXKXE2ZhT6abn9BaetcfLUPl3jHoQl2v7TOjp/BqGjj7aTIwkqn9oE7tTc7nGyUw+9eIqdBji4M4lpznzsBBd1uQwaza2o2dy0VisJDt0FgVWeydQLiF9uB6apWLqsYnFWKeq1J4KBCiR/avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlZErS9awIKsXWo7aqvqqoD7P/haSF/cuXcIitbmqxQ=;
 b=WYfA5v7CHIDqFQ2JzxnHTXhCECFMgmfpWTdC8XcZXLQLNC434+pnjtXHajnpciWhOBm6spAGhD3DwYsxGE7mweVlZyjqD1p2VaDIhOntSpUJ21zsXovGhCgQ19BKxSFMyxX0WX/0Y4vrJlCn+glW4n6WoKXnsW6Pris/Ttpwwn4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8917.namprd04.prod.outlook.com (2603:10b6:806:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Tue, 5 Mar
 2024 01:29:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 01:29:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v2 0/2] make nvme/048 checks more robust
Thread-Topic: [PATCH blktests v2 0/2] make nvme/048 checks more robust
Thread-Index: AQHabjqmyc9b5eArfE+jTzsXHP+L27EoXJ6A
Date: Tue, 5 Mar 2024 01:29:18 +0000
Message-ID: <6ijuychwshzssoorymvko2b2aycmu5x5oc6zi6j2yzubsegkac@qlg4hs7ii7kp>
References: <20240304134826.31965-1-dwagner@suse.de>
In-Reply-To: <20240304134826.31965-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8917:EE_
x-ms-office365-filtering-correlation-id: 4dfe4a4d-7f24-49aa-58e4-08dc3cb3ad62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1m8xFLgVbAEJEzohnrfLuEQuvE5uQYj3aQs68quK7vfQdE9/CoR2om1vimCHRZtDelPBLBcco9TLHsIvUeZT4THEjwS3DhpfGnGFHkOYC88oXycLhB5xzVUg3Qu+QNlj5y5hJuzQojbszYRYWHxcnCcJCe9Qzhvx8PbJH5AyYzDjFTRAEB2YDcnlF1heb/7t0p0jgOX+WN2PzE37SituG1Y1apXD6YRtYn9xEA2intwyfjD3xBP1aNqp4KWLdDtUjh1fLtIrtXVLGX+/ftTT4rmCzf6kFTgMrDSEVvDEnddxl1WfxOP7+TXGQy9mj11Ry+4S7yPHJDZ7SA/p0OLEQgsQQU2YPnE9t2YeMA+/004eaGM9M+3LpcgRQrItasonW/b+9E8P/rhu2IYtfK11YYUHK4Fwh+IhkaPd1jtrPFLHf4HmgPnWzeGbuYZSNWOfirOALMUZ8726+X68lkw7m0j7XiGgYlctAZ19vjArIePgt41rApfDOdKkaXTj8gApdOfATCaUIn7EY5QZmT5HIR+81mCzkrBGba2lbguzZp7pAtOan9qR9LUmqVQ1DxXtCh6egndOnBFO0NCFBP3OiX0whE2swYXwCLF1fGU5y6tKBibVhxG1jcMNNoqSWX1AAJi+qjrfgMEG05j6qQ82M3NQfNMM13170W8SFcj2RC4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7EMKcpOrdil7h39DD0jAGwe+hm5gszzjz5vNdASTIKrGmN8iR3h5gT9+0AUH?=
 =?us-ascii?Q?iymF1Yntc3GiM1/YyMkTTtoeeFRLgW/aOx3IMFlxm44DkKUaw0WwTviJ0cq4?=
 =?us-ascii?Q?GVQE5r2n4LuNZsqfISFGRRU/e7qpiU3y4pqJCg5OuQ7y7isdoEW1/fsSvX02?=
 =?us-ascii?Q?Gt1N8bhOwOV3sdA79So4e81QVVb6WuK1eSQW+TSRbk7UafxPpt3CWyVxO0m4?=
 =?us-ascii?Q?RM90ka99mDmJtiQ3SUva+Eu/Gw08bhr6tsSecQUWNxnDaVxIZGuu1LjzHyaz?=
 =?us-ascii?Q?K34eUJMY0VJtHKu8FG/U59PwuXZQI8gZeZ7KKoaWS6Gs4BxmApKVbRavbFV3?=
 =?us-ascii?Q?MSOj+EsqLuM749q9ra8ys9rlNmKBTIplZS1y3OBQiXt6W/q6j7isD+jSYLAW?=
 =?us-ascii?Q?eLrrtV3Xo6CNXHOiAHNorARJNzu5kSTwVIYyK39fbXigPU3n71bBYLp5AEMD?=
 =?us-ascii?Q?NHC9zsN0nJf9NQVauJ9P6iWPAZkMpvO0p/IzXDGRvnlnXXrvGmjKu4U/cRNo?=
 =?us-ascii?Q?GjOhpGvy7jHdjlmh9DPBHaF+cSLkNWlzKVOgqImR9GvPYVN6TlUi9Cym7MAv?=
 =?us-ascii?Q?vLkP5bI6LiOQNqW+aAyqXx+oOM4rpbLKiCvpwsLjX9ufOsrKKZuwO5FYgCO5?=
 =?us-ascii?Q?9HZkuAmMjBa0N4qWcsUDZl2h6+DNge8u+O9ILzJ17oxUEgReGRl7zEqqx7Wy?=
 =?us-ascii?Q?WRdAnljyAYXGVqj2gYZssE/7oMa6DB5mN4Uo49JdNHoYc7Cm8F0W3J61X7XK?=
 =?us-ascii?Q?kzo+dWDgSGnqKViCa2T9ZgsI0Bg+cE8zgN5Af5WAapwDMwTWBiLCYsDfd2ld?=
 =?us-ascii?Q?QPHet3fAa3EOJqOmkCPEOvXkgqQ+u10+KltOyWN05P+WfiVsJG7UxI2p2KG7?=
 =?us-ascii?Q?VH2XD2ZcHjTXMQZ5/SKSRVESoSpuJdWEDpWenMa9rPViN6EiTE0RPqMehv5k?=
 =?us-ascii?Q?vI59XrEY81DFzLCrrXoSxZj5oWKtqx2xJ7RS3jdgoTKrKcHVRQh1IBLxDmM9?=
 =?us-ascii?Q?hOrNB7XYmraMVN0TZy1KHtc1tkDsZvdgPCv8LXF/CoLZrIs1zeqTMB5RI9MR?=
 =?us-ascii?Q?VwgY0y1+NhgmdDJ9PR8O6tn5lUSS9PgP88aps07+chdODuZUTXfngyFpH4k2?=
 =?us-ascii?Q?9uhIfQcj6cpq/OEI3pa29YF98d5vGDiVZX4tq6/AMw7VjCnePQZE4Wwny8Sk?=
 =?us-ascii?Q?wGok/aIN7oZ7GXqHQZ1k3bBGSqbpEd8CfQ4u0DtKisItwSHp/VbuGDovKfQx?=
 =?us-ascii?Q?NBLVq8KMjHX0YcLV2OqbXvjtC3kdNLccGxWsVCpOUOiV7B6CBtTfLidH/cUp?=
 =?us-ascii?Q?C3/lEdIWzRoDKLZNTPIqg+eNphs9Ez5Epa+hMhljSPuoZTUF1EDgZxb3bFAJ?=
 =?us-ascii?Q?vuUk3cLYpV4Rgjd7ZE1dhQlOx6OwFlwsaMoxtdRUKJPGMAG3UFeX/8obk4rT?=
 =?us-ascii?Q?+Mvrp9yo2TUihF/WKQeBuYyVjSoSwSxWuSK6K5TCmA27Xup6xBGfj4Q4UrTC?=
 =?us-ascii?Q?raLc8Th3LlqCvBUq4atNBnXP3ZQIYJeLXWL0jtmZbXX51C55nn7ZgxOd7pgM?=
 =?us-ascii?Q?+u10XLnFrDKHtTkWxwyzOqnIT5PTn0wjP3IRiB4hW+/RDqusy52C5ASwRYve?=
 =?us-ascii?Q?QxYC0qI36RgURwok15FnZm8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <963A3796CD0BB84F91256E48D7879D18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jz/LS9pSpRJmzaewi4xLHEkeWTdfHgGhOcFYmoKZrdraTa9I1ALRrVMSslyyD3k3e9ZJ9f4sZaWqhkwGhuO8RGj7Rk5W5vbMY7ofcslMoTpWxy+vcKD3YZOb9jyseIAyIDEDyKU7/z8/JTD6+hyLyQvYPh6Ov6kbip4eYMtKp0CZ9mpYKAZ4LBzbUKadzx6b3OYkcE1iMasMmtm0c/ZvzLom3dd+CUK8Kg9Xh4NokB6AvmncKjTKgUhfruvYOsh4Mi7oNpHCqCSyk46or85g7Ob40PEQRdfsU5a+Cem6eWzUQvrojgqGpGL5kxh5yJIG5b9ZxSSdnKvo6BKRr2UjJTsF+jjZkQyi0yHBI/x89Hxkcnp/oT2KqbuAjyVZ6aaUq3YhEVb9oFeJUNHDZfgSfb9+NupeKt9n9L1hwAH9veU+ipLH9ANxgyp/9xDvDonweR1TwGgphDKTFe+Eu1iCRj+3exaytIlgQuKPaqa9rJcnohBQ2llhzorEHS3WvWN/waxP+0pp/iFMVhnQ+33zAS3gSRUorSghStq8g9iw54Y15qMCzZsD/JinIQbcURvWTkRsmvV587n9rS1L5JazqfbQVb/Etb/uuyB/UTo8yLDYhv46BFi+dd4m++cs/Io8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfe4a4d-7f24-49aa-58e4-08dc3cb3ad62
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:29:18.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBRLJ0Ce2XEeAKDu+cl/SH1kygJoJbOXzXl07QrqPv6OKHR4IP8Ms+9IdOytU0hwFxxdh/3y7Q3e8wrhBwYe5oASN6MRYTdljVoKqHjne/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8917

On Mar 04, 2024 / 14:48, Daniel Wagner wrote:
> The nvme/048 tests fails with the fc transport because the check logic is=
 racing
> with the reset code in the target. By making the checks a bit more robust=
 in
> blktests, this test passes for all transports.
>=20
> changes
> v2:
>   - added RB tags
>   - refactored exit path as suggested by Shinichiro
> v1:
>   - initial version
>   - https://lore.kernel.org/linux-nvme/20240301094817.29491-1-dwagner@sus=
e.de/

Thanks for this v2 series. I've applied the two patches.

Of note is that I removed the left if block in nvmf_check_queue_count(), wh=
ich I
believe unnecessary.
