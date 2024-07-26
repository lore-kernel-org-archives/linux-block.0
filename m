Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA829A5
	for <linux-block@vger.kernel.org>; Fri, 26 Jul 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983959; cv=fail; b=iix2ARZV5V0pwax3RfReYBaMg/kA666prPjjd9dmSKGGMRehnEr42eWWSW3BQi7dCOrPqS9+ADawIoIzO+/rxgseBgwwG79YFPhuDfaOZQAGDIWSFXiQdn/ulTYlTzxh3N9T/hnyotpNTAV6vjp1G+BaBLpR2+biDAeQ2ZDu5RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983959; c=relaxed/simple;
	bh=ATcVSqgHdNzlkK3bleChxUAiT+lT4MDAqXMZqYQTJb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlhQEMvs3tDPQiJpU3iKIF4xogHjtNkqn97haNCEoTUK+xqk7JBWH055UymINf5Tw3ZWpM2C2xEkV+CTHxFIHb8fAilovfv7oAb6Ho3ST8HmQ+ikOqWW00FVo3Jq8Br3JHrGysEv23n1z21HNt/f9dfop6HB08oF1+VDv/vIvOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RWiKi+pb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SEzemJ6i; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RWiKi+pb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SEzemJ6i"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721983958; x=1753519958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ATcVSqgHdNzlkK3bleChxUAiT+lT4MDAqXMZqYQTJb4=;
  b=RWiKi+pbsgHmG78XXHPtobxiea2FUDCyXKmds4tg2mc3X8X/0w9v3nmq
   jwK/eBjGFbA/kIa5/m63+bu+Nb62eONs0inrbxCNkL1u7RTvlWE/myVb1
   r/dJ+L/ElEdljadIVQVUV72vuIsA2T2ZmwjRd2GQZVOtmpxX/Q8eZakNW
   biLcKoHs3Lvqh+ihauZxXbSxN5Q8llIdj91HwsrwlAYkNaRAuaW9MGGyk
   54lUwEiqApyUXicBJ4RuthQLqyc3qzlbDsYcoA6xcOphAPBxR4Jnryq/k
   GQ+lgEtGmB67Ryw6m6FPvzPZMsNG4l4Fugz9Pykr2xqaP1hpimY5bBMUX
   Q==;
X-CSE-ConnectionGUID: PLoKeR1gS4OcWHET/9eEsA==
X-CSE-MsgGUID: rBV66ut5Qa6FbUj44T5GFg==
X-IronPort-AV: E=Sophos;i="6.09,238,1716220800"; 
   d="scan'208";a="22702559"
Received: from mail-eastus2azlp17011028.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.28])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2024 16:52:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaaNZ/BzHN42f/juLZgv1vvNLxcy3fkBsNfNrIuCt0RYny2CY+/Odn3Yl7bs2rf3n7M4FpuLmdl9vqJjERmOJGPFoSv/HBZ+QR8lGPBEapQgBXVLLbZvzpV80XRJQPsc2j2hsReDc8uxXtoJHgzLW4oi+2vjKMe1X89RrfDmY+rEFeDobwD57tAUvOuIBA3fE7gK2xynvVCfYRN3NCEFgHzNQ308k93GfLMHPG6KzD7FZnxFE8AFiKA38ocEYUKoQAePAsKUmrcuKUkSMTmbzhbhjztT8VBwYbUwO/aS8bvNlkMyHp6aKfI3fZ4Z8Tcxd1y4qgJpBnGX/+NMAFwiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATcVSqgHdNzlkK3bleChxUAiT+lT4MDAqXMZqYQTJb4=;
 b=Z31aG6KPjFApSzg+BQRjmEgWSjX2lkYeMeXVXPWargMzIx53JhsAk6CYpBBQ39lYHRT4URSHcaznHWF/WXxya9rtUrC+4RPae5D3cKrTsSvyYB/gFYAv0FHmR4MIkSaFgLm/kBfPFyd/mI4lTABi2IBB4WI00QMkosuxxmI58U3gkjWLeh24a4CqGBEq8g3uagZ0to6ypEo7eYZHJa2ItJRDeacC//w+xiFOuiK8e1TwNGQkQ0zbTqzSkJQ9ifrqJZ3yxG6dlB7aqYpsZf2ov7jGxkIVJgIgJ9mCllBU7CYeWmzxMhDTS6X2KbGa9cThnYbl/5BSoZ7XmGTtR4fRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATcVSqgHdNzlkK3bleChxUAiT+lT4MDAqXMZqYQTJb4=;
 b=SEzemJ6iX7Pbe+biIsIE/URcku8m/RbbiY/cws3qh38eVB5fzwKuVjK3Jf+LHuRCSCcF8NRcunvWeb4rnCG5L/EmRbEH9zS1ZwEIFKhS3kdhB5iavMUFNEt+HItStOovu0kmeYFMH3qMWJZpQkVbIrO6SMK/3rQKjsjaTud6SI8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8321.namprd04.prod.outlook.com (2603:10b6:510:4b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.29; Fri, 26 Jul 2024 08:52:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:52:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>
CC: Bart Van Assche <bvanassche@acm.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests v2] nbd/rc: check nbd-server port readiness in
 _start_nbd_server()
Thread-Topic: [PATCH blktests v2] nbd/rc: check nbd-server port readiness in
 _start_nbd_server()
Thread-Index: AQHa2ZmSZ+ugpydVYE6Vfv3S6nGSYrIIvxUA
Date: Fri, 26 Jul 2024 08:52:28 +0000
Message-ID: <5wsnkq6pivit2v2gmzioixnopjsxc4ir6ogkfujatxwuryn4fy@2swh5qfjlqwp>
References: <20240719050726.265769-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240719050726.265769-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8321:EE_
x-ms-office365-filtering-correlation-id: 1d3ce0df-d01a-474e-7e5c-08dcad504784
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LzyA24YSqa4jsVMMwgzg0QQ57uOrWTLwyyESsZxdMwrTdTvydORTaZly2x2T?=
 =?us-ascii?Q?ltLUVNv4Kf/F3wrGg8sU8gIr5epPvI0DeIxW5MpQvRikoazmBB14XI8A82Pc?=
 =?us-ascii?Q?CjAdh2czn9Fgk9acOFcCCx/LkQdkwLxzOyewCPeFIBtwcBYhGzIYt1sNPq5t?=
 =?us-ascii?Q?IaszAIlEIcI1rbRn2M+1QRL4DSKhUvJjCZXjU/VpWL9wCDjPxx595nfaf6gH?=
 =?us-ascii?Q?ypUPnYcrKiUzWF73IAm9119jl4PVprlwDEP9jE5Avm0uABMZRWXlqyh0IApR?=
 =?us-ascii?Q?dAEHaEktLeGC+4Je98epzQ+glCDM959UCydt4/7eNrsspvH85dsRhHu3c/CS?=
 =?us-ascii?Q?GKAFkngN+e5xwZ57VJKdXmEuruuWPZ/vaPCfxIx3VeCBoliI655hwsYXNGoF?=
 =?us-ascii?Q?Gxzhb1AMoXqkzYWTdhz6zMGyboblOBsZGZIT9ZNKZFWCkjMxCUgLnnPj2Aj6?=
 =?us-ascii?Q?DTUxqMtab9i8z0sFaueW/ME8++E0YBzFFSrhLdxKUCnby3n6sI98KQy00+Fj?=
 =?us-ascii?Q?2ouJn5Iptw8/GaOm8EQd31CE3A+cnsJmTMnCoVt2nkZFeFDzn+Jz92Fl9Ini?=
 =?us-ascii?Q?V9D0Rnc37r1lJRmHnaWTXtWpoNck+LYhDR5lUXXsXMM32x/laX7goMAq7wIW?=
 =?us-ascii?Q?Cilc7+R/1NstO7c0F723NupNmO2f0SIwLoschrZPGz/k+Gnd4RNeHCf6iOWk?=
 =?us-ascii?Q?w3B3woTrXmvsz2uLTwgRmWdHl6PTRAvM63vRJorxd90U9COwMXSb456d7siZ?=
 =?us-ascii?Q?d5viru2EzpZ6Rr+vKmdclhW5jUW8QztABPPtd7C1Dbdwy+QueqI1uW4iyUHO?=
 =?us-ascii?Q?5CNtgG9oAM4RbrzyRig7qP22ztvP/RcVeuvHslgw8PAVQd/9NFw9wTJt5Rcc?=
 =?us-ascii?Q?x/qmAeipAc/DH0QYpLehtdf/Hq6Kzai0iZn7DZ9nZ+vqApWXLVt8wBrVUztz?=
 =?us-ascii?Q?y5y1H50upF3ijzJJ4yIh6NusxeJaMsognI9oo61ghmeNwqilqi8refvhIVEB?=
 =?us-ascii?Q?sIeibb0pdD66oqM4eNAA0XUdVkb3cTwckD6Ljp8cpp9rNfVeyrTsafRJXdyO?=
 =?us-ascii?Q?imjkZULQV7NRkS3qobjN9/AKR9GyEPxepyUQe9cPon5aLgbIMCRHNnWis4gg?=
 =?us-ascii?Q?W1mQSzRAQCJYsf/bNHfD/TFR77cH9ZJqsSnm4iyWQMYBzemslMgNrg0h2kO3?=
 =?us-ascii?Q?WzwTQe1fjb+GcfB3ZAmgG8HtfPtE+/I0tG7NcMK9kRVp5gJ/47tPwIC328j/?=
 =?us-ascii?Q?+zptChPY+qm+dfnUhFmNAzghZySLOgWC/2Q7EzdnKH6Aypod3Gblc9MDUZjI?=
 =?us-ascii?Q?+WnQkpDQgOW8G0x+VmkqBhX64rMIm6a9RX+CCklwBiucd4X61xHgjELY5fO6?=
 =?us-ascii?Q?/isFmb8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GaCbqc6iGuJ0SicG0rrFjWDeRcUirx3H5JXv0zZBDZotumtg7uOtADrd4aOW?=
 =?us-ascii?Q?rBMQdPBNfgJrK8wqnMyxCt8XX2qbO6aaN3fBCHUZ/9JCHwcFojCpO5KLAWG7?=
 =?us-ascii?Q?7sITnabRfnHqIX4xp8FE/RGD3Uea89xgRoatS5NmPFAi21tz4/j1QVq42e5w?=
 =?us-ascii?Q?BjvWNAlwlOB5e5CFS8drNH6aQ+qde7qaOw334+NC4kY6CzkGbqpGBUm6b2HG?=
 =?us-ascii?Q?x/048atDGb7ccobPHGGRI4x/LIFSHZF7HyXkoJSvE1rifbUZM3baaXwlseac?=
 =?us-ascii?Q?qfh+jW1e7S2bKFjirDI/PnQPFpNL5kTfbWuqrDTqZu5IG8CT94I7gTLOJSkx?=
 =?us-ascii?Q?JMor3QWghkX6WlKITQENt0kyn7yyJVmjgQR+ntRNS50awh0W+X/ZT7GvL3sp?=
 =?us-ascii?Q?/OhDt3RqGPP4Igo0s79C3HJajy+m+g/pbuvv7XeSfoZtr2tPfq8LoMLYo9an?=
 =?us-ascii?Q?qgS8uLQJUMnZAjodllaB1Tm8k3Zq9khR68sc+k4T+LRrbdYy3aPeOCBvLR+M?=
 =?us-ascii?Q?Z5QL4cSkq2bcCiMjFvXvjjEuMee3L9gQscRbuvJ0hHYFC9xTcTL15se1WtWm?=
 =?us-ascii?Q?t4jGpQDiNY2n04tKj+KIuouUYvKunYdDJL3kRosKtmrfg8SZpFUa2h8eSslb?=
 =?us-ascii?Q?wviqowknoZfFnIYOYUtUme/uwCAnu9+GpcJF6b/H5ZlU35DiacVM50eAebzb?=
 =?us-ascii?Q?s1L1l8dPxljCmYKg0exohbT+tpv4MDIeC3AFHBBIQeL9tBC6gQ6nznwNw7Mw?=
 =?us-ascii?Q?ZgL2Ghf2JYcI9hPigiSJp7SV0X7h+k2HI+LxbpIsyaNoO3sp0gYyuhIBYZ46?=
 =?us-ascii?Q?6xWzWw3LM3cOvn91dCIqJqTEatGvWrCnO1N75emR94pnwBmuqFKR0ImNR0Cx?=
 =?us-ascii?Q?IEjmqTvXhYttz/Jos5dBDcy+ozEmqBwuooR80R1Gz9a3ACONGNjNESIUa092?=
 =?us-ascii?Q?lkbq9UnTuhYu46NGyGPMmBo7617N090AKSqhxvyQM6cwOUUD/8UwTd9ebNqJ?=
 =?us-ascii?Q?DPcqWZS9iVGN3TUAExtkFHc2FC7d2PdUPNHclQOHS+b6pphhSefGMb0LRF0I?=
 =?us-ascii?Q?igjOu7YE0uY57VkF6+3aGwURKb/Iy+X9RmRRAs+rc+Ttn8A6vrW1HHBnvevc?=
 =?us-ascii?Q?dAZ6glO/vZrXrOeMSTCMuWvJvOZoqiWk6ov5HCovYdBLCKDyQxJp0a+KkgSt?=
 =?us-ascii?Q?SxxLI8q3YvowwYnolzehJCuKriBNhLMsedVewNJn2zN9bjyMwDTFyUaHzkVp?=
 =?us-ascii?Q?GOhVJ/TFEQtHKSIRPaSV6x8+hVM2Lr2HFlCn+4H7LgYEvZO85jVrvWsVN7Gm?=
 =?us-ascii?Q?elOedEZ9yPxgWL0sSBSNToXztJji9z3wRLoq7HqkEiRuTsZcWXidI87q3S6B?=
 =?us-ascii?Q?s9VBt85Wwnw1FLO/omOT5iyxs6glYw2RwV107zZz8HdKNXpWqHj1udeSegSy?=
 =?us-ascii?Q?3idvrArABKqZzrRm8tpy6xO0gGKLC9Ixw/E93lAi8C6y7JyCNVnqc3wblv/L?=
 =?us-ascii?Q?CMStINQrjWbhEO2pNEW5I45h4tRHpzPzEb2CWdjSZx8muIc6Me2eIcJ1XWzh?=
 =?us-ascii?Q?enkWl+NWZHturLFh96CNVlDBpmtEVL4ekwYwCCaIrDKjQaqn0VFzUy6AU28q?=
 =?us-ascii?Q?fUElm3xwkCbphm3yGZvkKkU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BA48C1903CF3F488EFB9EA07E2D22CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jyp3kM1+wqZaxG0X8MaVzQOGM5ShXy2lE64+qmPULAdDpCMOxNgh88IzJqI3lpNgBy8GqpkZd3EwHz6gdZSKOBN8VvaacvB3AI0ahUjrHkBkm0ojK/u3NLyStHeSO8IYiNVNT+1lcqT4x6/6GoPaTTLh6gcVHVZqR4JDdexCxFuj4a55Ptibx2S4NWtgHodXmKy6Pi/FReso3cXAdhATCjVqz+mSiPn6QDMo4VI39tLvu4si95qg6RDYWblqSxTdNvNnv9TStZkI0wtHXiAJbale2duqSOKd6dCMI5R1RKMJ3ux6MB1lEuVCQuF9RPyke9vErswTR7iDmnbkMOg1GqIVK/MJWvMME8pDuFfvfK+tj24OuuCzmTNjBCBmVkP2IZKG/AYGJHhKwsygFcrA4jzLljXtnFWNF06ClWLXrpBuG0yRc3x+eFrkfgfRyCu0c8CrNRAnulzkZdDRzFAhakJjPd4M9H69KwetSFOb21THWl6LLPju/6t2DO1GEcarp/3aQmbtVgdhN8rz3c5lTIcvYbFW/myGO25ytwjIVU5N0xsFU7PBCR7cmwO+DFm1uq1IMSIAFPi0bntmoXr5+rE01AtyguWWdCG0SQ7nLwahFMBDZJVk+PDTGecKmWkk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3ce0df-d01a-474e-7e5c-08dcad504784
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 08:52:28.8076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpN0ACXVHpMfPp7fopmxwfokQ7MUMrie6WXlFl9/+dyst7fKgRUENRKrEkBF9boCbfCADDStaXfrIn4AFzMwbS78+5SyG0EVpxCVccSrqZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8321

On Jul 19, 2024 / 14:07, Shin'ichiro Kawasaki wrote:
> Recently, CKI project reported nbd/001 and nbd/002 failure with the
> error message "Socket failed: Connection refused". It is suspected nbd-
> server is not yet ready when nbd-client connects for the first time.
>=20
> To avoid the failure, wait for the nbd-server start listening to the
> port at the end of _start_nbd_server(). For that purpose, use
> "nbd-client -l" command, which connects to the server and asks to list
> available exports.
>=20
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://github.com/osandov/blktests/issues/142
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, the patch has got applied.=
