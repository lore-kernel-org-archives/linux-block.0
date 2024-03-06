Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9364A
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714700; cv=fail; b=aaySaXCZwtkJDNoeJ1pc2VKMwHR0Q3XusSoMtLXoAOJb5WlI7USDDwDapbiCzsCl/zQkcEYiD2QSeYwISuH1QY9bS32Sze17GoIt6KAGZMVAwFThw7hE62I7HqI2BY5UadtmAx41J2DQxkACWb45DzJMa/+vIV63MlUIaj0dCd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714700; c=relaxed/simple;
	bh=tJaeCNId6ucTWrqdVjyK9iAPZr/Hk7ImgatXsRi/YbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOoMDazkf0y0hHaarKYsvyWrI72aOwTLLIPndg4Rw4Oh1OLpJKkY/3Xf6NoslznvqOvfoJxZhb8w7MKIGRPAugs8GqmBOBk5Y16fVZW8dQjI7bL2HGTMJ4m53I6i7TDiK0dfzynhvsSk9faTDT9jsjfOeR6qJhz+n38LpOoPTVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nyzQajrx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WPBxrm8j; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nyzQajrx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WPBxrm8j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709714697; x=1741250697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tJaeCNId6ucTWrqdVjyK9iAPZr/Hk7ImgatXsRi/YbI=;
  b=nyzQajrxkDkXbbJl8uEAKq25mvWSswo4C1tpNbuXIg4nFimB3dneXp/s
   ShlwKKJP7AiCrsQUQsUY2rZubTk/tCmV7VSU4fGCo1rEdNoTi9sCSLMwk
   Hkfw+jLdrLvJGfTmWrdQNBeOaAysdhFo771rx+zijaVsjOEn9VzxsHj3D
   ydd75ztYQBJvbC0KU2CFuQL5Co+buDHau4B9kbHIbE6eHU8QEA3eEbt54
   XvBUXkS/FKuMVOvblrKG345JOTviUcn6quJUzaL4TWHg32M/5MawrpwU8
   N65o+yN9sJwVT04F30YY0QqW9f6h9nAJk0ExPWkFhdbFE7AxEj/MYvafK
   A==;
X-CSE-ConnectionGUID: /DH2JBceTWSuQfarzYCpPA==
X-CSE-MsgGUID: vlefZfETTjyLnsLlpcAtwA==
X-IronPort-AV: E=Sophos;i="6.06,207,1705334400"; 
   d="scan'208";a="11520299"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 16:44:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmxCbnsl6E2b8TB0DxVWib/6hhY+fShGQ3sGiWmMgWZTY7IIFEUTtUfRcBDb0OYiKw/L4Uz84sR8pnVtmOikxkoT4Oza2xAbYqDi7dsW6WTrhL0op/yT7vEYRWr4tPqsANC4icozrsqVwsTAuSUrayAkdDgK0Kpy1u7jAiBoYtvtXXgft55EQpvOwm8Z7UiPRyaNbJhIjmyS6TEwCHnJ52pFuj8NWduJJBI8s3xIcFKv1XWvWoybUDhcuW2KIGzlpMWu0YKT1BxQLiTOSukLd5wcbYP1x0bs398+h5HL8tM2zpZLeyroxy8TNblPVtVLKlUgQN9qU8fETcoivf8CCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j166oG5u1UgAFrjzuXPyBNPdNen6bawnPPNDPKTCRSk=;
 b=gm5GroGUru4eeWbZzUfY5y0nWyH8HO6aGh0QAqSBmqNuxMY+kTvXKnbk2Xy/RF1iu4HEU6r3GCJHx3cxfLSxi0GSigLqZKMKMcgLMh4D3l1i9LGKli0K12p9rYPjgOLI2Vy5szShre5vswiA3btbvaNhXYu5sHymf+vhSxUPNiD+il6+9sCYepox0POht9hV0NedbfZZ7CS2zTt5wJDZ43fy127XKIXSzjjYzAXMcikBPpcCdt6edYtLS8AASpqUKxcI5gKVmG4o/1Pm+HfWIxPi6UK9QYlrGKaYiVSi8a/7KsuhDbBAN5n3HRgrDCr+sWkxSa3Zad0NSvgI/iunNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j166oG5u1UgAFrjzuXPyBNPdNen6bawnPPNDPKTCRSk=;
 b=WPBxrm8jGztJnr8kT1dxvoN4F8/5YrpeXaf98GNWkT1j0JZV2YfuImiwc6zPl/Zj3UcMdCgSxivFJ/SsxZMZQOwRsUJULAswOe12BqQm6Zi2tAteKq4x6yln8FnoRisu/Ke2iiqub+mnRV00ajdTaTo2jOH4yOA+5b+2P3p49qI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7094.namprd04.prod.outlook.com (2603:10b6:610:98::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 08:44:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 08:44:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with invalid
 key
Thread-Topic: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with
 invalid key
Thread-Index: AQHabk7cqNwSTpUn+k6UjReb5QwC+7Eo5uSAgAAaOQCAAWdbgA==
Date: Wed, 6 Mar 2024 08:44:48 +0000
Message-ID: <bax2kpeovgvf63rrtycsgpbi7wmvjhpmcbfcpoznldkowczom4@czjddqccdsba>
References: <20240304161303.19681-1-dwagner@suse.de>
 <2ya2o6s6lyiezbjoqbr33oiae2l65e2nrc75g3c47maisbifyv@4kpdmolhkiwx>
 <p5xkwz6i2lfy2a65pbpq3en6wh57y75qcoz3y3eio3ze5b7cm3@zgfn5so4yuig>
In-Reply-To: <p5xkwz6i2lfy2a65pbpq3en6wh57y75qcoz3y3eio3ze5b7cm3@zgfn5so4yuig>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7094:EE_
x-ms-office365-filtering-correlation-id: a5d29a8c-2bd2-4ca7-11eb-08dc3db9ae61
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mBUN7MoldoP2XFgtMjyNpBvx4ddeXJu7Io9pfPqlZ05u2Cqlg0RPLKpooDDXQ4ONdZTpH9jpGWnXsvdSF4G8O5XnvWepJOoqbBMLL6RhH1VGH1X9wX2bhBH9g1wdk27OXbdQdrWgjJtbGc+ERis/31X0Tjbv//WyXOvaTAXY3q6ralz7B6HNMugeRPU5U9LhgmAfgI4Ly0h4Ew2dd/+qDAEf564L0KOpukFL7CTs5hFv1vnKJEyfnpYv+LK/QQHKE39zzoaItpwBGw/rw7UI7qkXbfFCOQfrv/gbax+h1X0I1fnnqNqwPWNEsQzRopjhKdSmsodGEwlPWVpOMDxg5Ik25YhUtGY9IrdiSCiguRDSvxMrA5YiMvlf3clxSuUe3TsZJLX7qVLzHQ4mXqG0DK//2bcKFPHuYpIT7hEW+Bs4q3WVdfqUPb60EAzTEUwM4Hcz8r9gkao3U73LtKXQHO4iBJ3JsLQNwIJpMu5Yzr5PByRosgeAq82lh/DVTFEnr1SfHB8kpvdxHz4vM5NO2MH0VSrMmHrRQ6rTG+fB3NRg6iwl0TQDA2fWXDLLJyTTCLi0hHui+8M4+Cc5gqRhwCT1CgHiMaSS7Nb5peO6OlfFe9LVD1zfhXOzwj4jLPdhmxPVEX9oOLVPWXdaTkSOrCLTnhrJS5M08hv+UG8CGSFyhx4+zgmYPWFJtQ4YSs/T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(27256008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cgFBUCto+6m7BVEVpDzJPoLPSju/KiCBWtWnEkv4tx7Czz48DG2+RAx6MRFG?=
 =?us-ascii?Q?uUXvF+7/jA5lQH2G7bWsYCy3pyLNSMXyalxF+tF/uK+Kv5RFOckr1GpT+xv5?=
 =?us-ascii?Q?+KOPX+aPsS36sutlfz0efdIzzVvSAQtiXOuM5xlRjebsD3FSdcIGhAVdsA0W?=
 =?us-ascii?Q?2SB/a1OKzpM9b98EY0yAz7kdOROOs3zHjUQyVFx2V8UKgmtJ8ok2KCTurUuN?=
 =?us-ascii?Q?4BdyRLfaaRIdhB5od0iPrw3wt1acw0xT+YBZljBxUOcB1Ogg2bCag8r00iNP?=
 =?us-ascii?Q?MEU7B7SY2Slh7YpfiV0kFjie7vQckDOZ5jdW1M8EC7RwPMerXjV6UcGcECKU?=
 =?us-ascii?Q?LcrgqjQnXuF8RrA/EivC6B7bv+nbUtCP2T+TB42EIO4EnbfYUG+x0P17wN8p?=
 =?us-ascii?Q?W4x6ut6r6xD05j4P23c0cVUWPbHnHUkoTyfBe0QEMVBuc3raypv05amHM3b3?=
 =?us-ascii?Q?qbU+DnjnWXjQewlj+qGZpNbTlc0/Ipg1bOgbZtnk2/YLUfYh8Ogt3YiyPg0W?=
 =?us-ascii?Q?MH3SKNPaGR00uYgEnNT+nF/pTndxXEykN893xGqFO6J6BNw3KtTUzZDJDO6n?=
 =?us-ascii?Q?n7dd+mTRZ8s9aBgT0HeDZKS96q7kDyjfk8MnnAQxAIGrvhZQZJQle2tOrRX7?=
 =?us-ascii?Q?jNdU9g4bjf1TlAAL+0di16GRu6jBwGZi06smoLonLOQ73iSDkj2Y60gUdv0J?=
 =?us-ascii?Q?MKnvffJxE5U91rrl4bO5Lzg49JjD6vBMOKnJoMHazc3ON5o/AHf0tYUgDPuI?=
 =?us-ascii?Q?2zYfuSDVGMQ5VCk9pWAEpp/Umli5T8m97deSsOjveVwoueUcvfnxpLvbJ9Zj?=
 =?us-ascii?Q?y/b7E1Ri+E/tnuEduQ6pYpOZvBIRskwbvXjHd2nudyEgmM0TIY23bx4eLCc7?=
 =?us-ascii?Q?rgBAIrpqLVGP6L8kKUCDp0xaw3X4NOjkRiYdzPaQufEYnF6cYpN5hsjKzknS?=
 =?us-ascii?Q?QzB1QSZkeaIYWY5RqQk5YiqepP6OcMNDWIqWDY6TzWD7BpLVfdLtDyhM7hCK?=
 =?us-ascii?Q?LDUvohtkzIPIROugNLjH3wiguEiJy0Ur0p98ceoT6e6s5LXL+H3fw0m2GwhE?=
 =?us-ascii?Q?PP9i4VVhGsX4dbBgSvezsqpuJHVmBRUcEl5JMKRyMdUtnW0Gt5L090SMyCEk?=
 =?us-ascii?Q?WVD5Z6l88JWWS7VhQq4E/24kBX0XRd/UaANBV7y4a+mdrnHRgm9xVvzFDjfL?=
 =?us-ascii?Q?j4p3v5AYDFgR8Cu3LO2XUdG0QU/Qoa+itbJUO4gCm4ZBmgW9QIre7ULQI18T?=
 =?us-ascii?Q?4Befdtcp2R+mG3amzdqXxNbvrIw830uwS1UhPOQsCoX0eof96WCh6Tw8or+n?=
 =?us-ascii?Q?5bAr6j3I3fXZtr+qOcRmgrM481omZWOV2eDw1lq3FO4Bu8OhYmTK+YJYbW52?=
 =?us-ascii?Q?MonLgHuOZQhv8d6VigabzWEtEL/2hhQBh/db5aMUgKkC2OePmj4Rp1EBEM3F?=
 =?us-ascii?Q?+/pT6lR9fnQ0O3b32r8vQVnZiUi0FhM79CUgIyM16ggKGbjZJF+j2x0yUXw6?=
 =?us-ascii?Q?b95Jgfw2993zsktxxvSux5Sg5HVhdA6g6C+t/xJjUBnzWyk9bN4bc4lOq5Fv?=
 =?us-ascii?Q?pvyiDZHRT2Pa68HGPY3i3JYndpu7IGGt17SvisORodZ25PYGxh1+nOVDmKCc?=
 =?us-ascii?Q?JAu7QyGyXMuTfEAs2eNPmaU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E246DA9529D8048B69C0AAA77DFA5A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Om3C5k6RiFV81GpzKcqAtAQQjYViLViovfNKpXOCr9Oy6v22G98EHVy4SIMi2ojlmDTvMpziK6xYiCA4s4vcXqldGRCEDu90Y2GV0Ok3w4EfXWb+sa5ReB+ZENT8zYatftkZxBBmgkgV3R8kwHaTnCcOtkQsJon4KxcMZ3qRmBY48d/CtHWuw240Q/L/zyw+wm+dRCBhxcuML38MzE1Qb1UrjPLf535ikukHzglAToOB1UGW6av/wwE+tnd1/GI2reTJmOO6kIE7csQl62o68R2QdWtiHq1d446U0LM4C6TPQTXzbPSpRIVRGILz5iQIJgLoEUdUxTqieXOF/zRv4yu9vDmdbK3Ci4ozjFLfThHe6t9YYF9NNZOgojdSwgiBNM+ZMVSxvuO6LGO1ukVbrlfqbXTIv0RY2QcgssZxo7rUyKpXtgATk2QsmhSInCqt+fTdU8FUllM/lrw/KzkYNjXlbVLdF4VyYBmHfccq4iq4Ex9MTd9iqJjn6KXep+QnyGQt9Ncgn3BtOxMQsenwLu9gNrem4sU8oL/WAC4v6ki8F98U2EjBf8oq/WZUDKKXLb1Oht8nKykXklSo2hKoOidI9ka/jzfWFiwfuqV8Ngs+JyEBTnOCd/84Rzo5gCtC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d29a8c-2bd2-4ca7-11eb-08dc3db9ae61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:44:48.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiBF07buldAl28qOn6PXZSBUypAUg7OrmGXH4tLGQWBnxrgBJfbTr5TTjAJjk4crQ2Iu1dcX6ay0+5hQ46Wm5MIhit4yvDDXrKKaQK5ZajE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7094

On Mar 05, 2024 / 12:18, Daniel Wagner wrote:
> On Tue, Mar 05, 2024 at 09:44:45AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 04, 2024 / 17:13, Daniel Wagner wrote:
> > > The is the test case for
> > >=20
> > > https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@sus=
e.de/
> > >
> > >=20
> > > Daniel Wagner (2):
> > >   nvme/rc: add reconnect-delay argument only for fabrics transports
> > >   nvme/048: add reconnect after ctrl key change
> >=20
> > I apply the kernel patches in the link above to v6.8-rc7, then ran nvme=
/045
> > with the blktests patches in the series. And I observed failure of the =
test
> > case with various transports [1]. Is this failure expected?
>=20
> If you have these patches applied, the test should pass. But we might
> have still some more stuff to unify between the transports. The nvme/045
> test passes in my setup. Though I have seen runs which were hang for
> some reason. Haven't figured out yet what's happening there. But I
> haven't seen failures, IIRC.
>=20
> I am not really surprised we seeing some fallouts though. We start to
> test the error code paths with this test extension.
>=20
> > Also, I observed KASAN double-free [2]. Do you observe it in your envir=
onment?
> > I created a quick fix [3], and it looks resolving the double-free.
>=20
> No, I haven't seen this.
>=20
> > sudo ./check nvme/045
> > nvme/045 (Test re-authentication)                            [failed]
> >     runtime  8.069s  ...  7.639s
> >     --- tests/nvme/045.out      2024-03-05 18:09:07.267668493 +0900
> >     +++ /home/shin/Blktests/blktests/results/nodev/nvme/045.out.bad    =
 2024-03-05 18:10:07.735494384 +0900
> >     @@ -9,5 +9,6 @@
> >      Change hash to hmac(sha512)
> >      Re-authenticate with changed hash
> >      Renew host key on the controller and force reconnect
> >     -disconnected 0 controller(s)
> >     +controller "nvme1" not deleted within 5 seconds
> >     +disconnected 1 controller(s)
> >      Test complete
>=20
> That means the host either successfully reconnected or never
> disconnected. We have another test case just for the disconnect test
> (number of queue changes), so if this test passes, it must be the
> former... Shouldn't really happen, this would mean the auth code has bug.

The test case nvme/048 passes, so this looks a bug.

>=20
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index f2832f70e7e0..4e161d3cd840 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -221,14 +221,10 @@ static int ns_update_nuse(struct nvme_ns *ns)
> > =20
> >  	ret =3D nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
> >  	if (ret)
> > -		goto out_free_id;
> > +		return ret;
>=20
> Yes, this is correct.
> > =20
> >  	ns->head->nuse =3D le64_to_cpu(id->nuse);
> > -
> > -out_free_id:
> > -	kfree(id);
> > -
> > -	return ret;
> > +	return 0;
> >  }
> >
>=20
> I think you still need to free the 'id' on the normal exit path though

Thanks, I posted the patch with the fix.

>=20
> If you have these patches applied, the test should pass. But we might
> have still some more stuff to unify between the transports. The nvme/045
> test passes in my setup. Though I have seen runs which were hang for
> some reason. Haven't figured out yet what's happening there. But I
> haven't seen failures.

Still with the fix of the double-free, I observe the nvme/045 failure for r=
dma,
tcp and fc transports. I wonder where the difference between your system an=
d
mine comes from.

FYI, here I share the kernel messages for rdma transport. It shows that
nvme_rdma_reconnect_or_remove() was called repeatedly and it tried to recon=
nect.
The status argument is -111 or 880, so I think the recon flag is always tru=
e
and no effect. I'm interested in the status values in your environment.


[   59.117607] run blktests nvme/045 at 2024-03-06 17:05:55
[   59.198629] (null): rxe_set_mtu: Set mtu to 1024
[   59.211185] PCLMULQDQ-NI instructions are not detected.
[   59.362952] infiniband ens3_rxe: set active
[   59.363765] infiniband ens3_rxe: added ens3
[   59.540499] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   59.560541] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[   59.688866] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[   59.701114] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   59.702195] nvme nvme1: qid 0: controller authenticated
[   59.703310] nvme nvme1: qid 0: authenticated
[   59.707478] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[   59.709883] nvme nvme1: creating 4 I/O queues.
[   59.745087] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[   59.786869] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 10.0.=
2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3=
-51e60b8de349
[   59.999761] nvme nvme1: re-authenticating controller
[   60.010902] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   60.011640] nvme nvme1: qid 0: controller authenticated
[   60.025652] nvme nvme1: re-authenticating controller
[   60.035349] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   60.036375] nvme nvme1: qid 0: controller authenticated
[   60.050449] nvme nvme1: re-authenticating controller
[   60.060757] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   60.061460] nvme nvme1: qid 0: controller authenticated
[   62.662430] nvme nvme1: re-authenticating controller
[   62.859510] nvme nvme1: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[   62.860502] nvme nvme1: qid 0: controller authenticated
[   63.029182] nvme nvme1: re-authenticating controller
[   63.192844] nvme nvme1: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[   63.193900] nvme nvme1: qid 0: controller authenticated
[   63.608561] nvme nvme1: starting error recovery
[   63.653699] nvme nvme1: Reconnecting in 1 seconds...
[   64.712627] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[   64.868896] nvmet: ctrl 1 qid 0 host response mismatch
[   64.870065] nvmet: ctrl 1 qid 0 failure1 (1)
[   64.871152] nvmet: ctrl 1 fatal error occurred!
[   64.871519] nvme nvme1: qid 0: authentication failed
[   64.874330] nvme nvme1: failed to connect queue: 0 ret=3D-111
[   64.878612] nvme nvme1: Failed reconnect attempt 1
[   64.880472] nvme nvme1: Reconnecting in 1 seconds...
[   66.040957] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[   66.200862] nvmet: ctrl 1 qid 0 host response mismatch
[   66.203005] nvmet: ctrl 1 qid 0 failure1 (1)
[   66.204873] nvmet: ctrl 1 fatal error occurred!
[   66.205148] nvme nvme1: qid 0: authentication failed
[   66.208609] nvme nvme1: failed to connect queue: 0 ret=3D-111
[   66.212033] nvme nvme1: Failed reconnect attempt 2
[   66.213837] nvme nvme1: Reconnecting in 1 seconds...
[   67.327576] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[   67.485392] nvmet: ctrl 1 qid 0 host response mismatch
[   67.487440] nvmet: ctrl 1 qid 0 failure1 (1)
[   67.489403] nvmet: ctrl 1 fatal error occurred!
[   67.489565] nvme nvme1: qid 0: authentication failed
[   67.493015] nvme nvme1: failed to connect queue: 0 ret=3D-111
[   67.496909] nvme nvme1: Failed reconnect attempt 3
[   67.498692] nvme nvme1: Reconnecting in 1 seconds...
[   68.610640] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[   68.739298] nvme nvme1: Identify namespace failed (880)
[   68.742833] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[   68.774125] nvmet: ctrl 1 qid 0 host response mismatch
[   68.776440] nvme nvme1: qid 0 auth_send failed with status 880
[   68.778133] nvme nvme1: qid 0 failed to receive success1, nvme status 88=
0
[   68.780300] nvme nvme1: qid 0: authentication failed
[   68.782490] nvme nvme1: failed to connect queue: 0 ret=3D880
[   68.785335] nvme nvme1: Failed reconnect attempt 4
[   68.829188] nvme nvme1: Property Set error: 880, offset 0x14
[   69.634482] rdma_rxe: unloaded

