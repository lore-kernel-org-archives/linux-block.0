Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F31D9526
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688761; cv=fail; b=mhn9Duaob91QnnEdlD9t+wnbO0DcFp65hPZTk5Gtn3F0YLkq3PDWayYJv8yEHIXrfEvzP/vIIXvxFlxNn8st0SPhOo8i3GRmlEshs3PETt8AHNOvVAsN0wRxpTbOSCtpyW9Qf35i3TjTNUWseIYaDTCiiYU98jb1f6qTOQoWUjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688761; c=relaxed/simple;
	bh=wGSCBf6gj3Fnk9gFVmBpaHvYPqKyrQispGiZIYzXnYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SF48y8ErDHNsEN4eauLP1BGBzMlvhcnhPFMn4dZgkFuP6DVIiaPs7kmUYNda5+NF9QW9LAds/343yEWHClK/UjzcaQNbBEmbYi1MwE0HjXH+KIMqotD818LmPoCeLA01KmzhahP5LwpuDWlsoI25Keqx1mhlSeQ3an+vYLwSG0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VzbvwsVg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QP9h9J7r; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VzbvwsVg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QP9h9J7r"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718688760; x=1750224760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wGSCBf6gj3Fnk9gFVmBpaHvYPqKyrQispGiZIYzXnYo=;
  b=VzbvwsVgOLAmGf7OWKg4vqRCcVY/2eqYZhXP2BQHvb2LHLlC3IgkxleI
   C/Lf1soIhUoN8n9hNkzQzi98bvF0hcBQYS1A8KjzzUyDTuCwDu0d3Uqpb
   /s1WsZPLu4hdQ6UnplJxJH31EggagsN/VDM12sxTMu4/bNkYBK/BQslRh
   2g2GXWwlsoK6QKDIRY9j0q//q4RmGScSiRcNR/3FV6eh4TeSom6is+/HI
   +otwAnN+pyst6Ooi/dZL2i0k/6WMoSe7QS3lph1U9zdoW9eBzR92kmEsD
   XyvDWUy+zQEfq3zQ0GOeiFeFoXM69ItHTpVGj0YGprstQw9GhUMAebB1Q
   w==;
X-CSE-ConnectionGUID: uwy40mUEQtuiEj7BO6eJog==
X-CSE-MsgGUID: Jmwmzp3xSMOm/Ol0ZavkLQ==
X-IronPort-AV: E=Sophos;i="6.08,246,1712592000"; 
   d="scan'208";a="19079792"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 13:32:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocnMi64yZFhA0oZGxHQcTcwz/wIGglv9K80bSPtFvoq58IjYgIlCAUyrbYGEJwl81qE9QUcSACi21GZx5Z1+kmj4wGNNAXCS9HAp9ieJcQSSaMaBQZKe9kxLvYkSmlEzyI9Pii5I3gGLYBfJUZ87FxQyEo8Sxl0wZRYcOExvKwdIxwNCjFCgfKSdLNAFLqlukjz/Ftf337UgGMWkzEErt7FYvHRIBIWFZox6JRjvxiVeBh3SN8RW8aKRs5mNaxffuX0G3pOmm4rhyIobwJDsgNJsRKs2eHMMm1ou6O42u3ImuX1Xx2ZzdkopHPd/mNiTS7NZlsfllOX1XoJNRHrb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGSCBf6gj3Fnk9gFVmBpaHvYPqKyrQispGiZIYzXnYo=;
 b=TVEK/OThJighL+i4qZRwHjXOtBo57mJpZRZY+PRvI1lwyLZYFuz9R/VC0QOTeVxt7Qx5dlyTNat9oEHFiMREK7SI/oMWlzGD3BatETdy4rkN7FJaRgzfeQAbY79vdUN7HYW7B+COmZESH1DLQGEB5WtYwguh3EOTWGTvAmXEqglfx5xEjNH9Tl5TUGm0+v5/B5imzb5DJyIL3OE9sY7UwWvM6mYM6ET6RIHUaLdK46Hxe+AD2uQ+vjfXL90N4TQGRUqlIIv/8vlJIuz035SFOHozd+Ub2d5pTtrJq/HVW2repe2l2jXdHxsTqxhk4jDi4VlKGHvH+iuZij9lw1Bg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGSCBf6gj3Fnk9gFVmBpaHvYPqKyrQispGiZIYzXnYo=;
 b=QP9h9J7rWRvovhpf+8Nn3Qlj20a2rQ7O6fBG30w/xXFzTsk54UPZv9F03HjMgzdvdP9HIxqbs+IQSwl0Y+2L4IcYPN7aOdsUkR6JsEY1BligIPDwBlZ8c5KE483K8k4xQw3/0y+6dMmEqihDtPX0i+JMudmUiIJI59ue/cHvdhY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6935.namprd04.prod.outlook.com (2603:10b6:610:a0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.18; Tue, 18 Jun 2024 05:32:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 05:32:30 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: hch <hch@lst.de>
Subject: Re: [PATCH blktests] check: confirm dependent commands
Thread-Topic: [PATCH blktests] check: confirm dependent commands
Thread-Index: AQHauJaNUPBCjW75Gk2kLlheUYVPQ7HNEKSA
Date: Tue, 18 Jun 2024 05:32:30 +0000
Message-ID: <5zfxapzzevzda5yhrucumr2tmf73otwvijx2nxual774hzz6ex@7eb4zgkpleed>
References: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6935:EE_
x-ms-office365-filtering-correlation-id: c95394d0-d0ed-4826-56a4-08dc8f580c30
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3/T3K7Srn76qF3MNcw9LmDVs3P2OzEQKT0sKMiIZzgXUK/D2trmGU5+Ik7cj?=
 =?us-ascii?Q?OwHwqD8mG9kgAkRQe1X+IZHdZPEcW0jXKZvprpMlKuWo0lifTa5Az6M3qGn5?=
 =?us-ascii?Q?tyblZOvnY2LuX1qSR3I+wdlVPEwNPPzjwKWcUU6BNN7r0qt5hNDaBYSmd7lv?=
 =?us-ascii?Q?7IoZ7BjkmvRaYiYA7QuA5lC3kUKW7eAhbrlJ3Lli36BbtEC3ESjblWwJSgFz?=
 =?us-ascii?Q?tfmm0zIt8Aw51/4be934qED6MlecjCEL89KaQn0o/fNkW62yD87t0OMEIh3k?=
 =?us-ascii?Q?lZM6wOzpEfHhITlaHT5mWVbr0Trd8txOxdUqEh41otp1OKQf6QTic7sFSyFE?=
 =?us-ascii?Q?enytSZalKoiixkdzLH1DBIzcmhitszW29y30N1tB+ktkXAEp+ncIi4Y5VTE2?=
 =?us-ascii?Q?TXWPRRWgWJgoI80+g97nFzWjdADOc1mEN5DGviWTKe14FIyD0JUg643LB9Bx?=
 =?us-ascii?Q?uE/km/K1WK8nGQAojihjhwejzXBr0j3sKKX/Xjz8Kd0JGZbMFPz0dpQAAMpx?=
 =?us-ascii?Q?Q7xfVwAeYaabz6mcFDql9IKB7HvHac63/QSmX8+D/r4E+bBal4pgIN74GzWY?=
 =?us-ascii?Q?i4HPMIP+lHTN29wuGhW+L6l/oWz2WFS/MY0z8yV/KVHVYci6ftBLBGIPZI0l?=
 =?us-ascii?Q?xSiw7uXt2acMYVSU7lB3EwgaNI/js3bU0IlbFfjYZXPEiIFrvRkgniLyQYBz?=
 =?us-ascii?Q?FfUKA7GLefkRhH207cJeceFO8PT7qHZVRWVcHdbLYxkOeXvVnZZTr4LI+0mM?=
 =?us-ascii?Q?lkqERhSshIb7PyN4eUNq2xoFDY4oyVbmzuj6y2IjweooFUieJgLfI9mqGxaV?=
 =?us-ascii?Q?ZTGlR5s6qr4JiNcOE3sWWWMZY4eJAg/doPK16MfRAMMN4fQjrF5STa2KoM1L?=
 =?us-ascii?Q?oAC6l33KXPCOYzvQ7gt32q4Nne4RDiESZSxzGcoJqPnxtDqP0ZgEO4PpJ0yc?=
 =?us-ascii?Q?soVPyJ0WhVb0xIZL4GwADe3EAyaPnkw2OO2amPBuIRdtAXBvZH8T2Rva9c4j?=
 =?us-ascii?Q?Rvsc1H5R11Aywc2JSasbOqDmN+drpRp7KSUCTqV3iFz9dDUjmDnDORCE5YBz?=
 =?us-ascii?Q?ySu0ADwKvEfkk/nkL6ZyUaDpun0DCN9QXZrVpJ7U8v2WAqAc9BMjYk+xpSVp?=
 =?us-ascii?Q?2h3fdX5oR7vFdZ6PlKBFkT2UGbag4JxMYuqvwk2PukwPR6GjIDuj21rdcuyh?=
 =?us-ascii?Q?55CFr8eBhdJpqye0zn3ByCN91pvqQclozjUuGmuYdi/BdAHd593YY6lf0qCx?=
 =?us-ascii?Q?CEO6rjpbXZ3fF25jVNkCf2gQxIL0bmH05z+tinquyS6ZWxDv/S/TXDxDXa/j?=
 =?us-ascii?Q?hcgZvizTUFO/8evI8jdcKnaeswoxjS8yP9187Q3wlDyg7j3mNsIaKaon8h1A?=
 =?us-ascii?Q?QJvvurU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NZV3E/W5VsiExbnxwI1lB7Zo1eBtu1PUkVKx/g+tThYl9zu8buGL54p/YX0m?=
 =?us-ascii?Q?NzjFAf70KnQhoObJuLywbqAXs1frhTvY83jauHeVYNRibDgSaWe7Jcy0gOLe?=
 =?us-ascii?Q?amA8z9rdAuaKkYvAHoQ+8otKm+3khKsjuojffllZ9rlAzLfmd8H+7wT9lvAM?=
 =?us-ascii?Q?ohV/oa6TXD3UAMU3IMk9XOgSPiyIEjq+Cb1GKPQSwIb8FKTa0QQet3ZYugEN?=
 =?us-ascii?Q?+hy3ypIBPvtsDRdLEB/50WBC6tCBpvf+BlMS4+YjbaoQPeRWmiZaR52mUrwL?=
 =?us-ascii?Q?KyvUCVQl92/t91qTrsmve/nMLbm6rhFQVTwWcpuEjugCCbCkv0okg8YVgY4T?=
 =?us-ascii?Q?d/3bQewnO+Q3SxqqgfuKY4/HDMchwTviitfeM1K8fAuRW6kAN8OLkH3fCpa2?=
 =?us-ascii?Q?33pDH1ZY0S9WY6E78pkhMDAAuwCb2y2zFzsy9Ro08Dk+uvdZ0+gdaI5aGMkM?=
 =?us-ascii?Q?LJYJ3SfNcr3CQF9Z4QbGhItBcTWJDh9P0SdujMWAIJXetx7JLV9lrk8zr8F7?=
 =?us-ascii?Q?uBbfh2t2N9DZarayvrqEVkMHSJHg/3cy4Ow2YY/1AHUmnuhsJuGslo/Rnkeu?=
 =?us-ascii?Q?gAACNIFBv/eW4YnaaGhU3PEYsXUH7TvbsxzHZk3sR0FoCM171c4sKOMkfn2R?=
 =?us-ascii?Q?/pT/dghOwUSHPSxj2fBaegis+M/ZeERW+3KkUFm+R4k0ih1WZQ++JvmaB/Md?=
 =?us-ascii?Q?ZKBZm+gT0Kgj6lRX77K+aJfP+DF9rQpA0cNOBAT38kvgFn0nqk48TquyCHnO?=
 =?us-ascii?Q?Q/Y15Cgl87v7BiXqQP2ybqD3y4AdqergndycVGb6SxMXVMUkaEfVM8b5jNY+?=
 =?us-ascii?Q?MeXmeQhsXwA8wkAOU4I9gfdxgQEPmpL0gjABAbBc6H474El1EfZZ7hFmLB5V?=
 =?us-ascii?Q?PH8ZP/8ZUiYHnfG3L4PX3Zl1YTA6rnRdDTE1+3g2dMRW4pMk0s9p207liWlq?=
 =?us-ascii?Q?9RND8E6M9rBe7IktBUhyDq2huqOdKh42l4GgEkZlYmOWY+i8+x+ZmdVIFcLY?=
 =?us-ascii?Q?q2lcGTksRui6CFlDZhxqSNTw6NGmEr9lrlmMMBD7Z15zP2eUmhmooY8Xyoky?=
 =?us-ascii?Q?Xc+HfHulGGIgIEcDH9KuZHcEqvtNhRh8waDbNWR0HYfSWOfVVR1RxJ3iS1P7?=
 =?us-ascii?Q?oKBmCIYSUCL7GNtl24pk6DsZq9LSdFoc+tenrskGhb0Ld10y+VwrZzaEw10D?=
 =?us-ascii?Q?PUltc86y9EVNu2+4CEHpAnAOLVCjx01lZXBn+K1MICFVbI/F8Y75zlvVi1GQ?=
 =?us-ascii?Q?iyj2Tam65AmymvAlBp3KB7CbkKUZBqAxqwbaxcpTz5s0ew36WMXU0Ufaua5j?=
 =?us-ascii?Q?kwRNiro+f4HXe4h4Puwy1Z06P1NG6G92SV3wppwNa/d6r6tq5LFnp8OVOdxU?=
 =?us-ascii?Q?NpJW5yHBi7dxLeNA2kaxFo8l2rzNKuSG/mw2DOQztI2Lr+0h3a7RxqPojj9Y?=
 =?us-ascii?Q?MO6kRNbB7wcXbsLPPFQz2+BtskiEvqVgU6lZdKrlcjXgKTHFxibzfuPbNthi?=
 =?us-ascii?Q?49uNEKdp3djc3l6gwX5kFzH/659b2TwgUaRp3YVGfOviP4OQ+JtOf3a2cZlL?=
 =?us-ascii?Q?4DvOTEdrz1RmZo2FK42tRsMT8GBzKtqg8vb7DW7Tp3qFXeWuEBa5++vwBef/?=
 =?us-ascii?Q?pDm5jvw+PpQDUDcbKVvI9d0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F7E1F3D7EC4604B89AB11F9F2A5A6E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7lDkBV/wc5dpiYEpYV1DCwwInbXyisGK1tDqazUkfHpcn4uTKznL0cVGD9yImdt1U+xCgeqdtPO+SRYltLe0AXexoeV42W3eZZsJoj43SE7x5/KfQBCyM9De1yudXmUnyr0GHRJZFto3Env3FHxSnmamHfJ10gtpqLn/fjXrr83zaIsVBdxjPHK5DeAaAAARftbpBR3Fsqgw/ISW9YJ6ECuX+Cmq9wDBlBE3Sy9lyyJLFIwEbAKTaVauwjGXrGcrYgr9sBQbJO/n5ovsJoyo6FaGKnoZagAwFMRmE20ppMhx+P1Xvs2iT/Qu8sSphp0ukUJxCFKYWUiQ0AFtMrli+uWH5zLJ5UinkjE3zhTHsUmW0vG9sIpF5tzCXnJ9713qRgSM53UIZQlZxaLI2NZyjYJrU8nSes4oRKcJkT2h9oO8GgCNlc3ZMOOgj5vYSd/nKySi6gGYsg279V2sb7TUSW3jIl4rBHMRwp9dscNa9Vedm7mCLXh+lJKUR7h7T3Nt5mbvG0SFqUEXQQoC5iNpqHeGTA9v3JN8OlrWL1kyrCgTD+xxgcF6CCGnTw4dnJPYab+7lXEaZbkd0ybAXfrFTYtGJvtgl2xVh7zNUNZOglcPDW9iXRjIr+BkfCfECgwm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95394d0-d0ed-4826-56a4-08dc8f580c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 05:32:30.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59KlPBmdqdK0zxwGepgWFupuSksO/1JsheWV93tZPA9vsuUXdjuTW7dTheT3S538pWWHFsbZswAVpzp5DiDFl0Qec7C01x9ifNMFrGrgRBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6935

On Jun 07, 2024 / 13:52, Shin'ichiro Kawasaki wrote:
> As described in README, blktests requires some commands to run tests.
> Check them and warn if they are not available. Also confirm that the
> bash version is 4.2 or larger.

FYI, this patch has got applied.=
