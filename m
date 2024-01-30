Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271A605B6
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603272; cv=fail; b=mUeAOaliAa4jFUAfDHGZXnZmWxoGdbt6Jaa7xpvWzGpVhLSbw7HxXRBzvimqJl7pwdeIbk1Je2bP9Y9A3/qQSROuLNgPFBKGvBExsi4EkYTe4rhjPU0NJsRf+s03uoGwScncAA1Fhf8QmJ2orA46q1kU1k9gbI0wyTqsePI1WJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603272; c=relaxed/simple;
	bh=IEvvTQni/JR4TYHFUjJbB9FeSltW5tgwYERGy0hrjTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbvObx4gn8c3KYFwzRhOw12o1J0wuYNqn3ZQ6AQ+ib7Xy0Bls64/n8WeLIrSfwawHo/X0C0cnbg/k14kSDPM0CgXSYqUul5GwzU+vSULkZnvJVMhI+rWrc7IJPJPaqCQxADxcOnQRiIniQR7a+OTH15SR4JCZIDfOIsd9mXg8ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bHbt0qgD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zXi1oYf2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bHbt0qgD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zXi1oYf2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706603270; x=1738139270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEvvTQni/JR4TYHFUjJbB9FeSltW5tgwYERGy0hrjTo=;
  b=bHbt0qgDAY/LmM1Ol/uQltGHhW4rttLKblCRTbMuwd2TqIiFmm1XorWV
   lg6wodr4RL0BbjxPKHHjr6wOqb3jepBHtSSz41mXRVBKH8k8OSaWp4N6k
   VHT5GDLOt6+NEmTpNcTyh72DzcJnvy6z5RwS7SQBjwDUE45jcO/gENuj+
   bUhURQON4IXQEXakVWJnrbM94COP+hzPHX6gzvgdWOdPMsiwqoHStcvT1
   48lwJWbY2hvg8N7r/vbGHLqo2sJrzTS1y10EJYsW0mLN6Nbh72EkpE00Z
   KTlgL1/Qz8MSe9EfNTbb2SLvZz8c69vKj/xs0rIPz5IRprFGoAmpVem8F
   Q==;
X-CSE-ConnectionGUID: XmwMx9dZREO/cZk13dlZdg==
X-CSE-MsgGUID: B0/ld6pRRNWB10v7b47CJw==
X-IronPort-AV: E=Sophos;i="6.05,707,1701100800"; 
   d="scan'208";a="8053321"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 16:27:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhWVKurGlkybgVLlpWxjavHYJ8fBVQuijVEzGS3V2Qy3LiBqA53TOrKYo6BXop6AhvwkUyiCYUWZgLFYAyCWdCdEGLl9RJ5z80ekodeKk/uw7piTNhVSKl+Cx/0gZ1yKDaCfV5S1kMasZPc/OevuP9AiTQvhJV/4mc1jZtHd7GmmcfcTNZLRXIGfkO4SF1ILXU4gwOYqvbGH70T+vwm+oWaWXZvBTNNWKfvrbxzwUOKLQSBymXCQHHh6ylCXJXwtV3iLtbrKLSmdzQGfeDm7KigC3UhtItI0UB8C8zoyuFYIgtxPm31dV+9igt9zZ1qnSQDXJaHbIpVhwXnTM4lrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEvvTQni/JR4TYHFUjJbB9FeSltW5tgwYERGy0hrjTo=;
 b=I76eZsZZDQHqMpAJjw3YkHwqRcx0SstSeAVdtuy8kn8PAEv2WnD5WRkIcW0nB/UAb4GMDUJvkzPlM8N7cTxblpwqJdSJ3Z5Fp000TRV3txH7gpeTZ0dlcBxuN9Frk0e+fnJXDmohKM8Ssp5/NZjf7UaHSDXMhvPsu4yJa0Xmh6pKgkMPsUMEwGYcrLyBPX79bO8D4fL2pcOu0RzEIFcNmosu9H03p/H4470OJDN7aBKQ+9dX5dKERzfSNwVKoInHN7xDeHnQSW2ZIUe+dU3Dt4uFR+DkkAJDOZbf5U0c00a5r0zRtIcouWoTRfsUhru5Pj4rK33LnvZhx1hlEn7f7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEvvTQni/JR4TYHFUjJbB9FeSltW5tgwYERGy0hrjTo=;
 b=zXi1oYf23OQmn3m60YNiPKrAe70a0w3VaPgaBrrgtk+/5pGKc6SU0/2QEcKff4YwKEG2kcLCkst8Ho5uOVJ7p8Jlxel3o4LxQCg3c9q+IeiYYlQy9lx7yV+/5QpwzbMTUwE6F/tzCArdDhji9ZRtSRUYnZTb1rkPimdITKcAGvA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6776.namprd04.prod.outlook.com (2603:10b6:610:93::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 08:27:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:27:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>
Subject: Re: [PATCH for-next v3] null_blk: add configfs variable shared_tags
Thread-Topic: [PATCH for-next v3] null_blk: add configfs variable shared_tags
Thread-Index: AQHaUzPWtb8cZZQ2mESnFn7A5zez/bDx+2KAgAAKnQA=
Date: Tue, 30 Jan 2024 08:27:46 +0000
Message-ID: <2hy4pyvw5nz4imist7aprujhqdmzbholenct7vixyzgfh3a3vg@kmdssh6vkxuq>
References: <20240130042134.2463659-1-shinichiro.kawasaki@wdc.com>
 <ea97f700-45b5-446c-b58e-b77c896deb46@nvidia.com>
In-Reply-To: <ea97f700-45b5-446c-b58e-b77c896deb46@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6776:EE_
x-ms-office365-filtering-correlation-id: 73329ce8-87cc-4050-1782-08dc216d56ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nlq78ejbrYnhKrSiTj3HhElq7WBgp1UkYfswKczZ8RIVUa9VRSp6ABRUnU2IIVJqr4SB8bTv7u0VmEicO0utpJjkK8tvEzy4pcYG6JQHxIhH73X646iGkr+aWqWoffhFQR0Ll8VGKcwevqwoxWNLHsvJK5BaXBSRfiblWTsPCbfB4YZPi1iPmIS1miMUssPP7BpeoSLs7sG5frRWkB7ckkQUtm4Q146rmAIuWno9q8NaGbWUGTgRpX6rKLHa4bg7w7X2kDht+iSruh7GCVuuJSIHhlLHrh6MNNZLfBvOE0Fa3XAZxmN0jT9iwsTGubp6dLvGaF0Okn3fO+PdVG7IYsTJ9Wjg3OFDRPtMf5ary0rnG/qhmATemeneBhh7SrJiaTHKUM3zU7g2EOf3LXQwsQc8cTkTfYAtD9f4nnzSmgcRHzOurkMwG//tJWolQppYoJJ3UWjj4oaRo1gqzGnZg/V2qQFmmb8UeRL3Kl7dhWmuEh3DCiiC1jEG6GywQ8ZBiNh/H3xzMx6+EoyJaFNX4+JgulJCvel7RYX3w3v8z2RGz3sPbsIRhrwotUON5E5kFtJXp+m9iwGGM6yxlp5FatdlzHyvn5juICLeHBx0Ac0TVBAyCdHpx4mzlOkFXdfp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(91956017)(316002)(66446008)(76116006)(83380400001)(9686003)(6512007)(6506007)(66476007)(66946007)(64756008)(66556008)(6916009)(54906003)(8676002)(44832011)(122000001)(4326008)(82960400001)(6486002)(26005)(38100700002)(8936002)(71200400001)(478600001)(2906002)(5660300002)(4744005)(38070700009)(41300700001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vrrDUvdiX6MbTW4g5YvkK65maNogLKTJde/cmfUVraIGhic6gGTtnKq3QhZ0?=
 =?us-ascii?Q?+vDzNs1opKlwK1WhBCeOHcZCTnniDViRWGK9gnEo/0LaFs5UCXZIIF567xNV?=
 =?us-ascii?Q?dYvSX1WoUhOzxflnZTflglow2SaADQsLhCcYuU/rMAcENAaSUNRoHfQLLP5e?=
 =?us-ascii?Q?+Dzh3Ib2LwxtMofxvGbxS+8uOxMBQj7lwVjn8JK6HZC47eMR+Awp+bAtkE0M?=
 =?us-ascii?Q?jVWmqIrvDCbYgJbkPI38toVy1HpSuBTvcS6nF+o57VYuHxm0VLRRlIb5pS+I?=
 =?us-ascii?Q?jWs8pwLfIb7GhB54YTeL4jD+6tyWLVBk/gWm5BuWevgvulCycBTILtuLRMFM?=
 =?us-ascii?Q?bcEvOuPAuHykTPiocG20E0iex+ZoSm57i+dfifATuIKlmjdIYbmBcKHfikOW?=
 =?us-ascii?Q?XrwRjcmcR1F/gvabXzPt8lWipO8eMzZr1NH+vS9mT/CaVaCVOs4Hs17Bysoo?=
 =?us-ascii?Q?67yFlsoNT0CVha9dj7jrNnzSgEfEfbC72EBEt/jH7hssjA3ooCbIVH1HeBKs?=
 =?us-ascii?Q?khvOiyGdtoUe0eZaQRLMNPw8cEGb8dn0q3vKiWP9BP2VgZAfVBvQR06feics?=
 =?us-ascii?Q?gLG9EyxoBNT1shQ9tOKo1ELv3sb9DhHG5xxxsxNBd12P54XFhHgjL8qdMhBD?=
 =?us-ascii?Q?2oaWqVnJtWKKEc7JheFo+8wicNNGYRWGm2uvEmorkyVYCfEXR/+4WtMon4hC?=
 =?us-ascii?Q?2rUBVOyRY5ia6CqPUlLxdHP+uQrtYS4INBs3lRz67gh8oQTjZtNtP5g6DA66?=
 =?us-ascii?Q?Fe1KXBjbQPFKetIlr2+TSYKdLAzX3LECE9b0jn+FEJkkGsZROMH73MkeA5e4?=
 =?us-ascii?Q?QjKc+1LWg2ntx0QG/1GE6cq4qC0swyD3PoEq4RtIs/eyl9+1LUR637UWMRFh?=
 =?us-ascii?Q?4V+UDGpOrvW97UYdTiRaocE7NTS/ObXxvoSyaihYOlGb5JnLa0wVXjbPOmlM?=
 =?us-ascii?Q?jnEVJ+GD4A6tRxORx1FZVP/AXQaNhkVCj7XRISEGZbUdQVFniP9k4vZlHIEv?=
 =?us-ascii?Q?laUUqD5syzvh/B+MjrL5kDcwr+jT+bznJL6OI/GhYk97EfVIDH3uWwIiICSU?=
 =?us-ascii?Q?xxTKD9ePFChYVc+PbH8hI51C6oLsIK8Wqut8ae6vMkkx5Mbja2wHkqjCnwdq?=
 =?us-ascii?Q?1M9I9wUGzou9dtsFwVs0EleUW+vIEKAtq7nc5QwKUDmXc2LxXVysZ7THacz5?=
 =?us-ascii?Q?BI8rFSiPlHlkYAstX83FadOTG4BU+QqZnfOMBhfsD7htuk76SJeLn0dTq4bw?=
 =?us-ascii?Q?tXNF4SqTYG29I2HvzUNUCbHHWNmHJNtgdo0eUEGkqYc+VzBs/dBuatldB9kt?=
 =?us-ascii?Q?uFVQULR3EZKdq7/OO/ywZguY7irbg+WEeDL0lguEYGv8q0R4Viv4aAmwZu6A?=
 =?us-ascii?Q?RCt546iwyZV6ld19wCHQCjcFJ8N5WkQU12t1cZZbffOt7XqChjf1XgR/WKCA?=
 =?us-ascii?Q?NQYR8kSBBPoN9cw8PoOI+ej47gyBKZKzUJEZx9L8WXw4t5YJKejAf8u4Qsvp?=
 =?us-ascii?Q?QBSsZcLMatG4M9GCGcCWPm5j3/H/l1c4PoUtmQDzLMU5OSqod8lliiRf3JGa?=
 =?us-ascii?Q?IvtJw9JDfvi5hJIRdjSXzNWetkDRN5WMLRCJJ142ekri58ssNkF0OPgKdxzn?=
 =?us-ascii?Q?3u1hdq9atePp+rVvjmK9WGg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <972EDE4046F95D4781F0B374B408DB47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AOmAMbmpyS+b/cj3N5BplInCefeYuCXs+SOeqLn05Njht9FKnoNfO+QHJSnOf9egR1PAw951IHP0hqQZ3OUduq6aVIG628mngEkJlWdvZhkeUtaFr+kEyw5+kHCu9zvaV/cgNo1nXMGtfKl7y76s/bwnTT62wEg/BeQYfhBGy0InPrCgFMCt5+5wTUmkBz/2Y4Oy2NyYfCo5FlZo9u/eQELdGiQyci0DUU+V5fiW3q6SXiPgcsj6GJ6d82IWd+VzmX69Vpc4WbU/ZaFlwFc2Chc/RbF9VrVZH4m1tbmI0sw5rhMT218wfFgQpVTxbK3jTV8hEO8SEMQHEMp61WEuWMyYJOPnNWHyldAnBPtSmP3X/d1B+ZqoGmijwBK9T6m2g8NVvslkJ84GKF849J2GG8WlLlrv24Y5eMFzK2G+4lWY5Rh5DTQuwJBAd7V8S6X+ImnD21MTnwFhEBqO3GfAzPC44nzskqI/5OoRtrnWRKaddWqEy8LZHlPgdxVoemV+KiWTnyrhtOKf8YmEh5d4fNCkBU9FmBs0hG4WYgRwPCQP1LwebC5RjllRsqM/PO7Pry5CJRedRPEnSHfF4Tny0G/rFnTPmXsoQkYgpHCzy718568UxBEoyaOygmHfg+mi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73329ce8-87cc-4050-1782-08dc216d56ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:27:46.9916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OrYpj4q4iO8agqLfqoHIFg/tuqgBblliIuSn306UvenkhKK6erGJYAkfd6lJalPNnPF2pbiZgxxeMG08jO1EQIHgrfs/Cg3y4o52+WCog8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6776

On Jan 30, 2024 / 07:49, Chaitanya Kulkarni wrote:
...
> I believe it is passing shared tag blktests, with that it looks good to
> me.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks. I tested the patch using block/010 and block/022 and confirmed they
pass. I also added some printks and confirmed that null_blk uses shared tag=
s
(or device unique tags) as the test cases expect.=
