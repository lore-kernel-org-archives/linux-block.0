Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C22F60A3
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962127; cv=fail; b=h1vDAXuQDZHIfnseFewvzYjS6cgatlNwB9hEDFS3zRUGT/WI/H16fxSsHtfHLiqLf3HNpmsZShDa+tuDMLDMT8L264YgGJcAvudojnVmIIOweAPbfM46qV+tJ6BZmv6ldLxL/HWg80P6BBWNDJLhZyHuWNc/CLtzxjofT9yiYsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962127; c=relaxed/simple;
	bh=4MMcsaDMyUKSBmOQ2cJYD76kfbFmWzbc6dXI+/EdWkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFFCNmmSUROAEW+92joNuX4iNXHFh0KYp0wx4KoB/k2irIX7C0EQQLbZdEwjqkCjY34GDg2Q/t3w9sJYSXYoG1Ox7UWd/XIMlTRw3/CHgQOb2KqzZduCAIMjaGdUPZ0FxcMfcG7qpP4/3zdvfeZ8K6UTYIXSCQKyJn+2YO+dNVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ixQLVzty; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uUaPqijY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ixQLVzty";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uUaPqijY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768962123; x=1800498123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4MMcsaDMyUKSBmOQ2cJYD76kfbFmWzbc6dXI+/EdWkI=;
  b=ixQLVztyTvnyQ4uZK7AOm7+bSU/Q6aB5itgQlJFacVWkBr7g8lMzvFbV
   HLaMW9menEPq1QHqp5+yeJ1n1dMZkRm49SqijNDn2z/Q9j3/VQg96Mynx
   RBqLeb4fErKNRxhrhkLlcMPde98CXoqeFYwE+4KB+rMxFT43bcigd2O4L
   mGuLLftYw3lpWrOmY3tL6Y6YW1XD9MGr53OAqz2CRGVKZpONLrxwmdiIX
   aTQ2J+2LLv7b/QF0xvZbe4Gcx/IItreWttVHlkQdcaccCS59rpfIp5Ksb
   qB66eJgrcUjYT0J4yzD313KWgWSkimAdKCiMpjiO3R4DblLD824C5Pn3I
   w==;
X-CSE-ConnectionGUID: T8GO4p4DQMidKrb2I/YWZw==
X-CSE-MsgGUID: i955ftbnQqSKyZXJ+tUWlA==
X-IronPort-AV: E=Sophos;i="6.21,242,1763395200"; 
   d="scan'208";a="140347942"
Received: from mail-southcentralusazon11013014.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.14])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jan 2026 10:22:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTuw9uHPeJpC5X3vMWQzS4U212txmbodxRFQkwXbuqTZrgdxyrEuTstM4Ofg5Zm+Pr9FakDVAtOeePmVMd96K/aNbw5Etx3CF6j/SwEHVTKjNqVjs/DV5no5gyQUjpe6Psre/3VrXPJLBfYXxvDHdFxvHAHwudfbR76a3dmDZSTJ3p0RcHpzHGObstvzk/ayOoR/X9+XOMIfSNin3sT/OGqgaETwrzRcHPy1auxq94P2QHnZ7lihVDmy2wPcRcUZZWBMxmjsgAgzqNJj4HZrAYEAligLsB4Bdu5X2bo07juLPPAR1sgac/iJEA0Acnym663YqIgKjdm5XLJdI3G1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MMcsaDMyUKSBmOQ2cJYD76kfbFmWzbc6dXI+/EdWkI=;
 b=I/2t93QNL3TAJWAysuOK7k1ZYLXvzP7eBH5uNzCWiLwBXIApg9RaFHM9FdfuZc+dvwviwi6/dJrvQxxpez1L5ucP7yVfBPx2+k5975Tk81maRpxCdTg9WD8mXOxjjUqnz0N8k1uEJIqUziZxzDal0etai0sEbCmBuaJcU3V+ZdtxCV6jOEaOOijZkqpZ+M0k1SM3p4MAypjBME3rGCbrLaqHP4Ha7nl0WL9IC2i6lSgB8Mu+mc3uqdpeu7NxTjjYEEkT/EnvmuUx/eybBRfaniO2U3RP9+nzgUo+0FWwY3m5vT2WVc3wvVKBSfyIrLn82FtAVPwdjj1vURfglDKnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MMcsaDMyUKSBmOQ2cJYD76kfbFmWzbc6dXI+/EdWkI=;
 b=uUaPqijYVLsfBkL8Y+lBJfqDXkpvX0DF+Qtp3RPypBAhvkh3wPBseWeRGJXawlITJ9ohJTQVZyFfubePu89ep6RJrnCLGNDwysIQUpmW7E/kMRqoFJYRT7TLRH3ugk/MluNFDaG+o7Zjl5LmHwddocBjk8XARdPhhFd0ovU24b8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH8PR04MB8733.namprd04.prod.outlook.com (2603:10b6:510:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 02:22:00 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 02:22:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "mcgrof@kernel.org" <mcgrof@kernel.org>, "sw.prabhu6@gmail.com"
	<sw.prabhu6@gmail.com>, "bvanassche@acm.org" <bvanassche@acm.org>, Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v7 0/3] replace module removal with patient
 module removal
Thread-Topic: [PATCH blktests v7 0/3] replace module removal with patient
 module removal
Thread-Index: AQHchf7hcU6VnZb7f0aFoRTePcWwkrVb7XCA
Date: Wed, 21 Jan 2026 02:22:00 +0000
Message-ID: <aXA4ElGLfsfv06C6@shinmob>
References: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH8PR04MB8733:EE_
x-ms-office365-filtering-correlation-id: 943d99a2-fb69-4820-b2c6-08de5893dbfc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gt3Fi9CwUxKUYIOET0GvOXzTYpAhFrFQPR65UGWjGinUDg/OTosUb5oTZwLO?=
 =?us-ascii?Q?YnlVs+fxFrR82vmD13eXDsHSDky5mKw+wnmOqu14v50O9uhPLYZMMdyFJzPm?=
 =?us-ascii?Q?Idlzv4VnXF6P6kE+NMahpsPK+Kh1cWMCKMs107H5Xxw5XLIR0aPGyQHkfc7R?=
 =?us-ascii?Q?DN2mN1UGVEn8HgNLlBMUA9BrysoaWB3OgpjmHBqvWknCzXPMiDo9zb+ejnkD?=
 =?us-ascii?Q?ZFsz147SfhuQVSaFVAy/aY+8fYwFSMRec0RnFLBqZK5sSk6xj/a82Ti0GJUl?=
 =?us-ascii?Q?bDxiNZJhXcjEkDtYpcMMegbiPOeWPQDDMxLuNlxSfM02P96kS2VPRba/PU23?=
 =?us-ascii?Q?wbLSlq7KkhwnlL4UIcVsVf7753KutMtdBIUhkeomihJ6h+9de5JWUZyO/SOJ?=
 =?us-ascii?Q?LJe39BTVYPcQ9oRPEYOn43JgSGbAF0QcEDz/mAjs3zDW7324BODKF8fc3Xl9?=
 =?us-ascii?Q?Kn5FihBe+Oql/yArZzo+r8EAztfjSTSEDSeRh+a/0Dfx5jD0mAy6c2lopPT/?=
 =?us-ascii?Q?1JVDFQ1WYmZF8mfEZaF4ohyv8WLAZQSi2g5t0qGmjNckWDNh5WBMEav01cDX?=
 =?us-ascii?Q?M58C9toyAuezhDxxhZeQp5ijGxd4sm/c3WtrGtDGs8upfG7bB8jsppE+y/IW?=
 =?us-ascii?Q?x56RmbglLjUb3rGHObs3fGUq5cmtos3nWOd4DdJSFinKUcocr2Wbuu4XScjl?=
 =?us-ascii?Q?BfOK5Pkdmr3D4wcpvjYFVKUb71OeNh0Gc4rsAz0r7evmWVp/m4NsOcDCzoCc?=
 =?us-ascii?Q?mCib3KMdHmstjdepTIyX8GvsVNOdSDjG8hg4msHCGgz30uGdbNUiHt7wrk9q?=
 =?us-ascii?Q?2l2oCCwudAiGWS1ACsSgd2Xa2jqZinvlXhhkFDRed4Xu0CISh1TcDVGhz36c?=
 =?us-ascii?Q?aGKRSAWVE/bZ6lgqKroiYBT7GRgRXqsib9jkI5rrmO8nvu9SC+ddFVytXsyD?=
 =?us-ascii?Q?F90hU6YUcTXeyc9Azdnuvyzmbygy0RXK/xyltAA7NDkj7z9dyuc2RrUAjalo?=
 =?us-ascii?Q?J4f69Z4qyrabWPBxGqJN4Q+bFQ1pll7fVw/94psMkvvcXu2ecrcgVEfT2PHA?=
 =?us-ascii?Q?EZctYUVgN6/iO3hxkv15+OvcTghxQTt4NyhG8P820bU+G4WWZfdMhZAZZ5vP?=
 =?us-ascii?Q?PT7zly1x9MeZPrCa8zW2tD01NJuqPzooj4jxIJshkuusT+TSkztPLu5SRMsU?=
 =?us-ascii?Q?hZw2pZqbX70yMTUJP2GtccwVbyFEHM/x4MPQ+NSrFWeqfOcuJ8kWDevOGrYV?=
 =?us-ascii?Q?z2zScK945fJc7q6c6ApM6yBHLTKV78FFZNEVVU6uj/pqUdhhCKpJHh5chhY+?=
 =?us-ascii?Q?wcHDhbdMIxSFGULZFfXm78mjzXl3OYTllBTowj/pYmBzusliEmeEQquRtjm8?=
 =?us-ascii?Q?EPK1jxqPzIRblCmUV7srP5HcPkezp6JeTvsUJT/ZJtdCeC67JBDH7peDXNrw?=
 =?us-ascii?Q?hBFSUeJECgWaPKxcvwZOM4LWm3laq5fT2Q2xQLNbiJhbop0SLz+wCw0WziHQ?=
 =?us-ascii?Q?z+j9UOtEV6pjAfG9xAa0SsFd2Ing6TjD2jD0lk9je/0/46bgJmyiRVB2zyUU?=
 =?us-ascii?Q?GSFnfOsPrCvI3QEqJSwpgZtXCfkdtJQFGTIuOy84nwCuJujt4yFI78pEWXgj?=
 =?us-ascii?Q?cu7dM5M8Al3AzxzSByTRTICR1sCXCDIe5pf3wNpKOPav?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k5qq5CoeJw/69QDsWSp9Jy/JWe2nM4tsZ+XucotFJSp2Jwbq4UuifWGAfRU5?=
 =?us-ascii?Q?fXPMBqVzummi65IWgwDRPcVLokX18Tq6tt8ZMTYMZWAcT9HAXn94ZtHjGN4S?=
 =?us-ascii?Q?bl/JeVglXV2sQcx0W3fZJuKziVk1aS4XUEuiGcJ47di/ebsmzjvavQJb/J6N?=
 =?us-ascii?Q?PPkPH8jBG9UHSnuaw94SIIwB34Jj4to+7W3JY8zWc4DeQeMzMp59Uh23rbc+?=
 =?us-ascii?Q?GDpARbCkP0bJlUrZIjfgQo5/92aOq1GWm5KPvmdyr926vaEzdddjMQb4nKZX?=
 =?us-ascii?Q?uh/jLSn+6OTXEeqnP1CQsCBprWAzmio0VS0Lc8f5s5C2fu4j6JR3W5P4m17p?=
 =?us-ascii?Q?UfvZKMYijiUard0RYqUoX1zUUODmx2R0dKXfxyR5FOkElCOlL6z1tfIg7fab?=
 =?us-ascii?Q?AFf5mQ3uXMijPLn5k+aBmknUDR3n37ssyDUI+hacXAoYsFXVyQ5pmanA5lsS?=
 =?us-ascii?Q?5xqi/aG5KYGaUDlefSb5tvxt3ipFkTW6xL4vd4vjv98WSjxR9DJSxDAZ9oMK?=
 =?us-ascii?Q?jCM2dNA72vKHsTkIb9UdSXUuIfqKeeS7zOfYRsONznzH+HiV6vFDO2O5r0bh?=
 =?us-ascii?Q?5iqlOC52VWq9vYU8rIVC+yfWrJ3BPTv/aCQpm9EOXV22HRHODLcZ15BQHfQd?=
 =?us-ascii?Q?Shmt91a4HFJWoV8hUCTrRR/uYUBH74NjPttt4Dc0184/dskAbRd8DcWKx+OF?=
 =?us-ascii?Q?aNRdKjp4o0DFDTXu13qfrhw1KF7uNHU83JHMX7yCc0uhf3z0apxhXgDmMsGO?=
 =?us-ascii?Q?5uzIJ0QsLhAhdpLqmHdOyM5U4DUkR+e4jtlQrcOFO8o6+xYmfKD4J9C4MJMT?=
 =?us-ascii?Q?qmg6owuHE2WtNvV58klWjBstYLzuwfzZqtoF0egJ05o6e5TWLPyHZEnY0Zdb?=
 =?us-ascii?Q?GEjLUPE6BsnPoq58QDZ23UBXzsza/Xtk6w/9fcdIOomoGI3ywSKLeXoFBavN?=
 =?us-ascii?Q?PfJEuOyrr1S4wLF6bTsIdcJnMv/6Vpr9Z4gml4h4hBOE8qCDDOog9X6OOIMq?=
 =?us-ascii?Q?9ATkol+nsBo8flyZ7UpoZq1XJ7sVPZuia2vSLk/Tu4l5fQUn5wOzDboc6phW?=
 =?us-ascii?Q?TRZCFBXhReA+33+qNzSbGtfI4AaLyl1oeUaEcfr7ERtgR0zLME/jb3P3lErt?=
 =?us-ascii?Q?GaMD/XVhWMn3A35pqV30o3D/65xUHJzMMVnct2bXpkYFaKaxvBixwnq+vokM?=
 =?us-ascii?Q?gwOR4aRKsLptJaSydKn/ws4jPpdZ6CMA+nsw5+izRVrQBfw1rxMNqxgiNQoG?=
 =?us-ascii?Q?PJApg+jXiK9zfOP8AoTQ7bO/0xX4f9jwmMzKaugWn7AwY6uV70p47YfRwLNH?=
 =?us-ascii?Q?faaYHfekrg3Tncq+onQBNVVaYc46XPaxtysmG4jYUOXKegwwVGpmJ4uvLKN4?=
 =?us-ascii?Q?YWU4+3NNrxR0i6dncGLxtCSRAgkk7B3ohCZ7eg3RsJDF3NxoZWi4hKG8uRib?=
 =?us-ascii?Q?HzBkeuiPbXoTKv6uTauID48pYmnLk3m1EBj5DyjyKjpjXyIWLem+vJlf4FSM?=
 =?us-ascii?Q?n5rW2YRcsXmXkjWC4491KwqN2fdxQv8k7kTRb/bclCqxeQLksdwQk7AJpWCl?=
 =?us-ascii?Q?ebUsoc6eNL1sCdoFeldAuT1FHpZT/Bq2Yy2GMNVmeSmDiW2y5HEoakbrFor9?=
 =?us-ascii?Q?sgTit5HAAOWViJbPLIUWDpWjjbxxViOiZoXzZbnXqxOX2U5YzOJoNwmcWoQ/?=
 =?us-ascii?Q?sGF0OdI0obxu36ZYo5TFs5TgDGWG+KLVnS6zSWjSbfXNYoxRonA6mQNFy4Cl?=
 =?us-ascii?Q?uBcqeSe7UaQDzv4qxKbtjlBMEZQ7zvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A065F57DECD48E4F875345CBB2ACAA0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6SW5jQt8kkUWlalS7d7akuFc96mS86kzMZRb0Iuv8yCVF82eGRy5wv5uzGJuMS1Xldio1xdax4QqFXYkropj2o/rGAPzd168hkJ3S703APhkCivUWKdDvnynWCxg2rSemTpLR2456meocfcDmFrrRDeMvOL3W3bXrF5v/HLc7D3C3Ay+3PSt+6GdRfjf71SDqOuALrPKv6AVopD7t2+hHWFCdp5Zhj8hddej+4uoT72MQCLbeleFC6r6BrMCq5q+B08uRHklPgZ1Psf9dXBXSwUUXfnDJycUn+86eqTOHmLp9ZhkHh9Crt+qTy0I175CoX+cgi0VJTUfOmy+7SXomC1/hFgP1ZEV8dzWEZ8scY1AzdCHzrl0gRKtFpGMwIEj6BXoWfEQwfc/UBuBiAj+K+utR5txmPSkz79nwI29bDH0Ai4ijWN/Fxs9oNLUi1ezseiNxjPENEEnjEtA6wKqRIYQBg1nrSySKDaR6A8+qUskF9gLaGRygCinuJXgxcewUlXSHWbXE2TJpP7Sq5qZYIW4ASHcaJuzaIwgO3CL7NgM3gjbnRMk/3jEz1NU1MGQ8Lt+AIv0A0r/5e5j1yJAQ0w/flHMYPQTafut4lVEADsp50WI9CAnsHRnsUM1Sor5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943d99a2-fb69-4820-b2c6-08de5893dbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 02:22:00.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTzyDkCkB3856G3cKmVi2SH40masgRLHVbpmKPgqTxFOuJSDoPyhC0NxkgPrO5jjtVpQu37nSwnsUhomlNUeWAvYg2PaSgWlCgJRXKhlWd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8733

On Jan 15, 2026 / 18:10, Shin'ichiro Kawasaki wrote:
> This patch series was originally authored by Luis Chamberlain [0][1]. I
> reworked and post it as this series.
>=20
> [0] https://lore.kernel.org/all/20221220235324.1445248-2-mcgrof@kernel.or=
g/T/#u
> [1] https://lore.kernel.org/linux-block/20251126171102.3663957-1-mcgrof@k=
ernel.org/
>=20
> Original cover letter:
>=20
> We now have the modprobe --wait upstream so use that if available.
>=20
> The patient module remover addresses race conditions where module removal
> can fail due to userspace temporarily bumping the refcount (e.g., via
> blkdev_open() calls). If your version of kmod supports modprobe --wait,
> we use that. Otherwise we implement our own patient module remover.

FYI, I applied this series. Thanks for the contribution and the reviews!=
