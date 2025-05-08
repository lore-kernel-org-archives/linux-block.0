Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED131156C6A
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746678724; cv=fail; b=aPT92KJO5+O7RlUJOekvy2FhQAM1ZRzM5opfnxuqxaZAZA+DMHokipu0NnBX0DSTOLLJh3hTuYK/sKZVHvF0Uq6hYvo4knEFdTomvRhjOJoeGLEjA+WjLDWUKrETRYTIbJg27C2ftAIo3Ve+tW4oQVy91We1hPx4mVVr2bdrcMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746678724; c=relaxed/simple;
	bh=2huERPmHU96RekgOSjMEbJjOh5NtRt8LS0iuMnZgBZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SwNe7UCVOJ7HcCPCb4Vtn9xhkDeJMCCUcIYWo4YmsC0ByhQs3GZyP7+nS6T+6BLTulknLYVGUPn4vGlSyoFj9BBmG6NaDctu0M3/87zWAGseC45bYMZuJmr7aLg/aYqpdEEBRU0X9vkj560wb05oXt/7VkYtTj1uKMo8WgOokpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HMs43XPX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zFx2TzSg; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HMs43XPX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zFx2TzSg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746678722; x=1778214722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2huERPmHU96RekgOSjMEbJjOh5NtRt8LS0iuMnZgBZU=;
  b=HMs43XPX2H4XTeCDi37w8eHg8/S+bzWvbGBYSrjLymvw9vITfuXd+aAH
   uSLT9H8VxdCLwbJ4dD4fmC0vUi0bLttypxxvP0QSHtvIjuK3W4MBCzPGd
   wMpdQLl/OWN8PgMdevfWFaFCg//enMvsH6qgB6QzjzLKUNWfipvnOe0zG
   9c6Wn5ZOk6JndIaZRYOnNnLIKZdZMK0G+aeGfR9RoQN/sCFD1I8AKclNt
   iDUMWtHDIcunNQtcuswyAE7u/x0u0QZ+3A2jluhURA40OTRAehblIvZzj
   jS/BhHayCAuxcrbfSuvcRu7jyVyngr7wEDpAjwfe+0rJuS9W6ZTG9GrSb
   Q==;
X-CSE-ConnectionGUID: ZXzaWtM4RaWdBMUkV9X2BQ==
X-CSE-MsgGUID: mM+2bvztSM6+lIRCU1yqEQ==
X-IronPort-AV: E=Sophos;i="6.15,271,1739808000"; 
   d="scan'208";a="81535210"
Received: from mail-dm6nam10lp2046.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2025 12:31:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOY74upyYs2SluF/QJJXnUVoOOn4hu4iPV4a83F+DvAQG4V3luy9C/uEzdSP12QtnuBbitcGSN/dH3Abd9laSWbrRcW2GTA0APs9X0K5wYsRHWqWGuqllL/IShFpZGcZWwuunvRxxOgttRKccoRkoXH7/w8TaxkP27znRn1qOU/pzoqt02TYiWHuLK68zd7O2DxWDI/Z/qLxgFGxRlePy47hHE4m6j8eoTwk9zjTebt6u/ftTgzo0QDuw3Y6rRY4l52bQHqfsYIxxnxUzzI3Rmun4RKpM83FeXubPzHgwXa+yiA+nUcSIFA15LjdVcHkqFOFWg/RjV0dgM/hOSTy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCqPajmBVmZLujDhf0Enl3S09AIsuaONk6smj0YBnXY=;
 b=YaB74p+NQWsnXReRQcDmJrfP/ac+FSs4C7/U71SUHVxbbCIumi91tb+63qfhWs5umhAo2GZW4htPQMy3+NMEqzFSCZlUtUcFfrUogEKlq58+OOGeI2hoN5efTK3+wGOlHalouBMU4bSIHlxMPjNvSEWjDLqEJc6iMv415o+YfFj1N3nq/IWAaADeZUZ8tGIGDB2vp8rxouuWtmAT63qmoB1pnj+T7MUMstVb0wlp7C6eV00OTZYAmv5p5rWxw3pAgVsMiBhDopOBeVkzI1OHqMKvbWKHa6Me/K7sS/Lby8nEcM4THxfEu1i2xiY7kk4lo6FfsnmUjjjJdCOe1cNqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCqPajmBVmZLujDhf0Enl3S09AIsuaONk6smj0YBnXY=;
 b=zFx2TzSgdTveR3sIJVUYzVRcXyvfG3YhGfaWR+cZsEZEAy0/UpfDjBO/YfWemGoId3eR9zrrs04NngEYJEA2eEge8B+Nb2aCt1PqiD3NvvZHQFT189lXyYnHLKPRd4jWmNhiGb278GE205/IeBEZeHJZvWv2xmGanZ2B4W79liQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY1PR04MB8751.namprd04.prod.outlook.com (2603:10b6:a03:535::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 04:31:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 04:31:50 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, hch
	<hch@lst.de>
Subject: Re: [PATCH 0/2] block: fix hang in elevator_change() and improve
 elevator_set_none
Thread-Topic: [PATCH 0/2] block: fix hang in elevator_change() and improve
 elevator_set_none
Thread-Index: AQHbv9IdYUAeaSVYMked7vRiwRk/MQ==
Date: Thu, 8 May 2025 04:31:50 +0000
Message-ID: <mlycu6p6zl5z5mmqau7otbfw35kcvnajpsnm3hokpfnafc3bwh@m5dp43ypdfpz>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
In-Reply-To: <20250507120406.3028670-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY1PR04MB8751:EE_
x-ms-office365-filtering-correlation-id: cc66ed0e-b46b-496d-1580-08dd8de9407e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5nzEdSR2Whws8gt1fWgjug67OMjr31BeAjAHQ4FvlyUB50G6sH9VoYz2tJiZ?=
 =?us-ascii?Q?Wf2axPeMVfGYJH391U1kbkDKDGIzJoYlZHQKXSj4+NMjNDm1r2AA+JwNzMEH?=
 =?us-ascii?Q?ixCoHBlamW3ZG84UVlr/kYaplgLsVwEFglvNyNEMWrIl2RBywQxPBIkBqMNh?=
 =?us-ascii?Q?HWEvetLKFZztBdFMSUNNW5mBES0ObfG7Cji8iDjHhC5iBmuKVKZyMaWQbclN?=
 =?us-ascii?Q?Q5gEUf7VFa2BHFmVqNETuXmozXb2kLXwBRFsNtAYeqjosxqlZ1d2+7MXlB/p?=
 =?us-ascii?Q?HxwgmJx4dnZMWLySaiAP9DOjjPS405/sGaat2JgUuXnZHaXGMpZeZZJMbDEk?=
 =?us-ascii?Q?vwOcPq96PBw30JGcnp1ryunPlCR+X6Gx7RNQlVeWwISPV6/sASZnWhXaD7wv?=
 =?us-ascii?Q?5tM0Q+qC9tg3FoRT6k2lhFsaq0ID59I4WZleA+qWr5KpIeFYkVBhkhnuwSAF?=
 =?us-ascii?Q?Ipeho0ziP9+OKPnsJ7M0+CsLNm/hNltKb1UYPU/2kAb2nH/iK/8aZFNUZdD7?=
 =?us-ascii?Q?GUiaw63VkKHJfHxpDkPpKEN+upI2AqUOiYI5iEwuthQ48mQlnWpfqVOschKW?=
 =?us-ascii?Q?cmvr14PuJrfEYjGZQ5/vRd/wYON0FZLcXHF7enJKOSI50BaalHntXz8Wuboq?=
 =?us-ascii?Q?ktoTTu2aDWAhPRvyz8WBIiXPFmnkaq29wop6FygQH6LiVAP+6m3fZ8QDSAGk?=
 =?us-ascii?Q?SFecTE71ZBcU0uM2uO9pDrnMFNc4rrvmUww5YsJMeZaOV4oQiRe3Z8kuNVZq?=
 =?us-ascii?Q?oMmUastgb5EWBBdvLI1BvIz8nbRmcr3ZSpD56bwX9LEUxSxjZXxBKm+Oxisj?=
 =?us-ascii?Q?oCgu6CC+T8ERDLKH+Mj7NcrsVV9dIdrkIUFU5jeploifrMPqKru10vZQNElZ?=
 =?us-ascii?Q?Opp6cQGilMMl9rIAhwh2BTikT4Cuv0Re2iacs3O6uSx4jqXoIMs3ciCkrqRb?=
 =?us-ascii?Q?JR7ezaWc3nI/Y+5+U2GhdLMgs1BEgbkNogifmsuQKXhFAXnlOf9QU3D15L8Q?=
 =?us-ascii?Q?KH6EQWJ+A9DbKfMwRF4USrzl+7HaovlYLgMFeebbfmqBF8b/VGIIM5/E9gVf?=
 =?us-ascii?Q?aoexXfDgE9BZ0K9h/GpTsYbFiEiWzmPkFsLeIhS/EqtD+NvDKa6/M0gDfkL6?=
 =?us-ascii?Q?79v0Zj2xhIogZ6Wa5/OmZqPwDAyUvfbz+rcx4B1KqIexdECE3fJksX5fI2du?=
 =?us-ascii?Q?g8WRNXaK4nk90004vSNky42a3asMbFcqapYxnH5f86u2XDx/cjjoAdwhVz1K?=
 =?us-ascii?Q?6Pyhoc/1++4df1ePLz5kujY313RzebocvF1umWdxBTGSuQEBth54S66cGPVQ?=
 =?us-ascii?Q?cafDhJS8P8O+4ZQM3B/9iJbgHV5EcCZ6xjrJcaCVMr0/Jxgt3ut70uFluub/?=
 =?us-ascii?Q?8M7OuIX5P5hk0s/A3feDIgve1wOTRWS6bQuulcbGcaqrppm23SirCNIqGxpI?=
 =?us-ascii?Q?uy+o1jnQ290=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lLikLqwFdi49vKYLPySYAjq7wbaIEno5hjIRzBquoTc0fAmACnFsf1cI1eRL?=
 =?us-ascii?Q?xusZ+Yk1PsS9EPJDdc2Dv7Uj7uKGxx/71BLnY6nRqKICeKTL8922F3qxNYjD?=
 =?us-ascii?Q?MsO6+zT2RBLNVg8vOTQCGwkpeeZiCdA/us5Zo/97xzQioapDX02cvRXwXmFq?=
 =?us-ascii?Q?VNHb3J6RrcvIkc43WOwKhYBVU/csIEUKEdb+Sa+XL7S1tsKiv2GU6I6fNsR3?=
 =?us-ascii?Q?Z+ZWZ2bsSSvuPUaTCfC/JD4Xo9PBz447tXFTzfT7VrVtUXtkpd5rU9CKcW4z?=
 =?us-ascii?Q?L71v/jAMhUISfNDI+JWUQ6KsGihNaTq0/weUFSAB0AqtamQyzAycmSQrl25t?=
 =?us-ascii?Q?YBMtXjEXk7OlaaoNtHVopcU/9ryO/TEnggx7yKj+FA2xozBZioYJQwJC5Snz?=
 =?us-ascii?Q?sG3SB0gqnJhlavnomr4lxBL7WyWmtcErUvne4LQ1F4WRwP4ogahjxmj3ivSu?=
 =?us-ascii?Q?IpCKUTtieo7V5Ng3CiPAvEHeNHI9vooSaQ0Qte60V9QQSf2zC057Zisj4LiN?=
 =?us-ascii?Q?bJwjdRWQTFvV2m6bSa8yaZSsmMm6gB3KEqGFtuSyBEnzML/IyBIgvHrStzWz?=
 =?us-ascii?Q?LLi0ge+yxJq11iiE+iQxBc2GZe9kjZv3oKP5O9/XiYY63KnsjPD8SWeMTvlC?=
 =?us-ascii?Q?vIkFZ0UiovG2pa4UXtLHGq+tQcREgWQP/LRyjln8bm1Lc5bBNeLvn9U58cKO?=
 =?us-ascii?Q?KoGOn03sk6FZ+eIYlxdKYnI4KZCXjzOqu3eC3tfHce1mjvYoP0lJqDr12nc3?=
 =?us-ascii?Q?N1ruR36QXRttKUf3YsIr1sfuy0jz0AocE2YY6ddU/wMu4tqSKCLUuCxFq8UQ?=
 =?us-ascii?Q?vEPMzOdximxQ6BgL8pltB041JiO/u2o6BTXkl8dvAVo2zWqh0ohapLX7yM7V?=
 =?us-ascii?Q?/cXtsJ3tSCv2Pq9hu6hlKESYy8ici5lz7vjgMTj6Q4HIHNJPdaxdPFdQinZn?=
 =?us-ascii?Q?0l/NmY5Had4u2Rm/BQmGVmwC+Z75H0ugvZF6NpdsCccTLBicgHyoIU8cMj4M?=
 =?us-ascii?Q?HXIyzCQ7RuiguvHXGv21CO9Uw+b3fx2+ujOZuMys66rrv53FbJuXhsGdftAM?=
 =?us-ascii?Q?eDGfHEWHjhSExQvCuZpxIahhO6I8yxelgPcucyRHCe7txArNORTJk9qAkNl9?=
 =?us-ascii?Q?sJEVfROsJM+AdqD1NrdW+c4CeoSfz7N81V3qHkEPPYp3nrvrr9D4s9uYTBpt?=
 =?us-ascii?Q?PuYWiCqFKm5jz6KS5xbItIA/R1KTsRUWeoz76TWHywGrWg6Swt39x+VaJsF9?=
 =?us-ascii?Q?DvLwMgUZpsoriB/+pAyFOOD5fPPwtlEcGt/VbxEcm8ciyZ4xpNpCqFbgOaeH?=
 =?us-ascii?Q?g9B5TAIf/vmoD7OxTSqs8wC0x4xQv9WwZxNBkpAGLL1uVWEEJTl01GOIqP+k?=
 =?us-ascii?Q?AHOiadVk7HWLtCwpfv/ru2JEQgQ9LLNV4ETIzUFpivBMwoiSIPRyrrdHju7F?=
 =?us-ascii?Q?aw5MvKcTaUgl3mHStFQQjiYplGtk9D+tWs5AGeQG234tE5Bpt07nof/bIN9x?=
 =?us-ascii?Q?bYxJdwi05lXSeMCZnf+NNJkH5VDtKrEqhH4u0yJtasPO2+MIPfcOWHacvf9U?=
 =?us-ascii?Q?JLiAhuZt4qVZYEV50py8aNMK7HZfNIAlAZxq4eyqlRwUN0WhYSUXYfWNTeDV?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBA94E6448F678429B3D0653BFFA2B3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P5eiMpEKR0rn6PD2jwTmlxbMPOv/VeQGclFJoCxQd7OiQCDZT/d2X65U98kC5LVlN+YnW5V7ZAHmAXwKQe5swzYUu6PhV5EyWwkzqju1zzz0goOMZ+zOg9g6rdeVxpdgcviXO6BYWo8q/MU/aORJRcVNk45vDza+qJk+adUOsfSmWoLnI5IUMnQ5FPTdkMct1W8ebbCgOETwcbokB8EeCojh1GBlG3Z9HfXuvlopscL9kSDQvrB83UqfCwhAY/ibmcoq3G7WlIFMsO4JAck2nbSmk3l2UuNP2BVvPfiOQTIF+rO4mm2KIHrx+MNQCvC0NjCJbkTubdPvW+Gosw90sI/tbIRwbuVoSK3u4lT+FyZ7YGHACgCvozHNbK9JI+W1O378faUNqUCiPk6NTjX9rnXUcIFKZ+QEf6mDMlDPPeBcaBYEIaTPwVIamP3gqAkfTSkFGXHwgbRibRJ2hbO6BWjuc/tWCduAQNsqZ5BMjs5+4BZFT/2mQfSSo6zMAUnU+RVsZXBajv9oVtQ38JtN1CjZjH7uVLpuns7qimE9saOtRg6eqyTR3SR6PxZ9R7a1im1PPvdl81jvurAYEk2GiygjmQxQudhdCFCORtuYEwAZfpF+DxF6Ice9I7tymdLT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc66ed0e-b46b-496d-1580-08dd8de9407e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 04:31:50.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwnyXy51GXQ1wdonP0AbxRhmrMcAj3dCfjqgeXJTl8Wp4CoGueVa+qnzOTNdWFHXRYBMhrto9naChbCkdkrTj3WI9VDS+iuOYDgwPgezSR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8751

On May 07, 2025 / 20:04, Ming Lei wrote:
> Hello Jens,
>=20
> The 1st patch fixes one hang in elevator_change(), which is introduced in
> elevator unifying patchset.

FYI, I faced a hang when I ran blktests on the linux-next kernel with the t=
ag
next-20250507. Kernel messages recorded the hang in elevator_change() [2], =
so
I guess this is the hang Ming mentioned above.

The hang was observed at the blktests test case block/027.

- The hang is recreated in stable manner by repeating the test case a few t=
imes.
- The hang is also observed using the kernel v6.15-rc5 with the "elevator
  unifying patchset" [1].
- The hang disappears applying this patch series. I repeated the test case =
10
  times, and the test case passed 10 times.


[1] https://lore.kernel.org/linux-block/174653930720.1466231.10850055937176=
78595.b4-ty@kernel.dk/T/#t

[2]

[ 2058.093128] [  T14410] run blktests block/027 at 2025-05-08 05:35:23
[ 2058.225948] [  T14462] sd 11:0:0:0: [sdg] Synchronizing SCSI cache
[ 2058.407456] [  T14464] scsi_debug:sdebug_driver_probe: scsi_debug: trim =
poll_queues to 0. poll_q/nr_hw =3D (0/20)
[ 2058.418343] [  T14464] scsi host11: scsi_debug: version 0191 [20210520]
                            dev_size_mb=3D8, opts=3D0x0, submit_queues=3D20=
, statistics=3D0
[ 2058.453556] [  T14464] scsi 11:0:0:0: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.466059] [  T14464] scsi 11:0:0:0: Power-on or device reset occurred
[ 2058.478338] [  T12862] sd 11:0:0:0: [sdg] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.478978] [  T14464] sd 11:0:0:0: Attached scsi generic sg7 type 0
[ 2058.486785] [  T12862] sd 11:0:0:0: [sdg] Write Protect is off
[ 2058.494912] [  T14464] scsi 11:0:0:1: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.498400] [  T12862] sd 11:0:0:0: [sdg] Mode Sense: 73 00 10 08
[ 2058.508638] [  T14464] scsi 11:0:0:1: Power-on or device reset occurred
[ 2058.511441] [  T12862] sd 11:0:0:0: [sdg] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.517270] [  T14464] sd 11:0:0:1: Attached scsi generic sg8 type 0
[ 2058.517530] [  T13564] sd 11:0:0:1: [sdh] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.517648] [  T13564] sd 11:0:0:1: [sdh] Write Protect is off
[ 2058.517678] [  T13564] sd 11:0:0:1: [sdh] Mode Sense: 73 00 10 08
[ 2058.517841] [  T13564] sd 11:0:0:1: [sdh] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.518238] [  T13564] sd 11:0:0:1: [sdh] permanent stream count =3D 5
[ 2058.518361] [  T13564] sd 11:0:0:1: [sdh] Preferred minimum I/O size 512=
 bytes
[ 2058.518376] [  T13564] sd 11:0:0:1: [sdh] Optimal transfer size 524288 b=
ytes
[ 2058.525268] [  T12862] sd 11:0:0:0: [sdg] permanent stream count =3D 5
[ 2058.532668] [  T14464] scsi 11:0:0:2: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.539401] [  T12862] sd 11:0:0:0: [sdg] Preferred minimum I/O size 512=
 bytes
[ 2058.546074] [  T14464] scsi 11:0:0:2: Power-on or device reset occurred
[ 2058.547978] [  T14464] sd 11:0:0:2: Attached scsi generic sg9 type 0
[ 2058.548835] [   T1363] sd 11:0:0:2: [sdi] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.548980] [   T1363] sd 11:0:0:2: [sdi] Write Protect is off
[ 2058.549011] [   T1363] sd 11:0:0:2: [sdi] Mode Sense: 73 00 10 08
[ 2058.549178] [   T1363] sd 11:0:0:2: [sdi] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.549607] [   T1363] sd 11:0:0:2: [sdi] permanent stream count =3D 5
[ 2058.549728] [   T1363] sd 11:0:0:2: [sdi] Preferred minimum I/O size 512=
 bytes
[ 2058.549743] [   T1363] sd 11:0:0:2: [sdi] Optimal transfer size 524288 b=
ytes
[ 2058.555444] [  T12862] sd 11:0:0:0: [sdg] Optimal transfer size 524288 b=
ytes
[ 2058.563164] [  T14464] scsi 11:0:0:3: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.688094] [  T14464] scsi 11:0:0:3: Power-on or device reset occurred
[ 2058.688137] [  T13564] sd 11:0:0:1: [sdh] Attached SCSI disk
[ 2058.695209] [   T1363] sd 11:0:0:2: [sdi] Attached SCSI disk
[ 2058.696189] [   T1364] sd 11:0:0:3: [sdj] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.696247] [   T1364] sd 11:0:0:3: [sdj] Write Protect is off
[ 2058.696262] [   T1364] sd 11:0:0:3: [sdj] Mode Sense: 73 00 10 08
[ 2058.696325] [  T14464] sd 11:0:0:3: Attached scsi generic sg10 type 0
[ 2058.696351] [   T1364] sd 11:0:0:3: [sdj] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.696577] [   T1364] sd 11:0:0:3: [sdj] permanent stream count =3D 5
[ 2058.696693] [   T1364] sd 11:0:0:3: [sdj] Preferred minimum I/O size 512=
 bytes
[ 2058.696708] [   T1364] sd 11:0:0:3: [sdj] Optimal transfer size 524288 b=
ytes
[ 2058.699204] [  T14464] scsi 11:0:0:4: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.700288] [  T14464] scsi 11:0:0:4: Power-on or device reset occurred
[ 2058.706172] [  T12862] sd 11:0:0:0: [sdg] Attached SCSI disk
[ 2058.718223] [  T14464] sd 11:0:0:4: Attached scsi generic sg11 type 0
[ 2058.718718] [   T1363] sd 11:0:0:4: [sdk] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.718836] [   T1363] sd 11:0:0:4: [sdk] Write Protect is off
[ 2058.718887] [   T1363] sd 11:0:0:4: [sdk] Mode Sense: 73 00 10 08
[ 2058.719057] [   T1363] sd 11:0:0:4: [sdk] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.719490] [   T1363] sd 11:0:0:4: [sdk] permanent stream count =3D 5
[ 2058.722369] [  T14464] scsi 11:0:0:5: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.726442] [   T1363] sd 11:0:0:4: [sdk] Preferred minimum I/O size 512=
 bytes
[ 2058.737127] [  T14464] scsi 11:0:0:5: Power-on or device reset occurred
[ 2058.741779] [   T1363] sd 11:0:0:4: [sdk] Optimal transfer size 524288 b=
ytes
[ 2058.750466] [  T12862] sd 11:0:0:5: [sdl] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.750984] [  T14464] sd 11:0:0:5: Attached scsi generic sg12 type 0
[ 2058.753126] [  T14464] scsi 11:0:0:6: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.754438] [  T14464] scsi 11:0:0:6: Power-on or device reset occurred
[ 2058.757198] [  T14464] sd 11:0:0:6: Attached scsi generic sg13 type 0
[ 2058.757474] [  T13564] sd 11:0:0:6: [sdm] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.757574] [  T13564] sd 11:0:0:6: [sdm] Write Protect is off
[ 2058.757599] [  T13564] sd 11:0:0:6: [sdm] Mode Sense: 73 00 10 08
[ 2058.757737] [  T13564] sd 11:0:0:6: [sdm] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.760015] [  T13564] sd 11:0:0:6: [sdm] permanent stream count =3D 5
[ 2058.760173] [  T13564] sd 11:0:0:6: [sdm] Preferred minimum I/O size 512=
 bytes
[ 2058.760188] [  T13564] sd 11:0:0:6: [sdm] Optimal transfer size 524288 b=
ytes
[ 2058.764451] [  T12862] sd 11:0:0:5: [sdl] Write Protect is off
[ 2058.774374] [  T14464] scsi 11:0:0:7: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.776195] [  T12862] sd 11:0:0:5: [sdl] Mode Sense: 73 00 10 08
[ 2058.776270] [  T12862] sd 11:0:0:5: [sdl] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.784899] [  T14464] scsi 11:0:0:7: Power-on or device reset occurred
[ 2058.790862] [  T12862] sd 11:0:0:5: [sdl] permanent stream count =3D 5
[ 2058.792322] [   T1364] sd 11:0:0:3: [sdj] Attached SCSI disk
[ 2058.798540] [   T1364] sd 11:0:0:7: [sdn] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.798697] [  T14464] sd 11:0:0:7: Attached scsi generic sg14 type 0
[ 2058.800961] [  T14464] scsi 11:0:0:8: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.802281] [  T14464] scsi 11:0:0:8: Power-on or device reset occurred
[ 2058.804437] [   T1833] sd 11:0:0:8: [sdo] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.804507] [   T1833] sd 11:0:0:8: [sdo] Write Protect is off
[ 2058.804524] [   T1833] sd 11:0:0:8: [sdo] Mode Sense: 73 00 10 08
[ 2058.804536] [  T14464] sd 11:0:0:8: Attached scsi generic sg15 type 0
[ 2058.804730] [   T1833] sd 11:0:0:8: [sdo] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.804997] [   T1833] sd 11:0:0:8: [sdo] permanent stream count =3D 5
[ 2058.805140] [   T1833] sd 11:0:0:8: [sdo] Preferred minimum I/O size 512=
 bytes
[ 2058.805158] [   T1833] sd 11:0:0:8: [sdo] Optimal transfer size 524288 b=
ytes
[ 2058.806506] [  T14464] scsi 11:0:0:9: Direct-Access     Linux    scsi_de=
bug       0191 PQ: 0 ANSI: 7
[ 2058.807211] [  T12862] sd 11:0:0:5: [sdl] Preferred minimum I/O size 512=
 bytes
[ 2058.807841] [  T14464] scsi 11:0:0:9: Power-on or device reset occurred
[ 2058.812469] [    T218] sd 11:0:0:9: [sdp] 268435456 512-byte logical blo=
cks: (137 GB/128 GiB)
[ 2058.812565] [    T218] sd 11:0:0:9: [sdp] Write Protect is off
[ 2058.812565] [  T14464] sd 11:0:0:9: Attached scsi generic sg16 type 0
[ 2058.812589] [    T218] sd 11:0:0:9: [sdp] Mode Sense: 73 00 10 08
[ 2058.812735] [    T218] sd 11:0:0:9: [sdp] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.813117] [    T218] sd 11:0:0:9: [sdp] permanent stream count =3D 5
[ 2058.813326] [    T218] sd 11:0:0:9: [sdp] Preferred minimum I/O size 512=
 bytes
[ 2058.815011] [   T1364] sd 11:0:0:7: [sdn] Write Protect is off
[ 2058.815039] [   T1364] sd 11:0:0:7: [sdn] Mode Sense: 73 00 10 08
[ 2058.815186] [   T1364] sd 11:0:0:7: [sdn] Write cache: enabled, read cac=
he: enabled, supports DPO and FUA
[ 2058.816236] [  T14464] scsi 11:0:0:10: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2058.817650] [   T1364] sd 11:0:0:7: [sdn] permanent stream count =3D 5
[ 2058.817783] [   T1364] sd 11:0:0:7: [sdn] Preferred minimum I/O size 512=
 bytes
[ 2058.817800] [   T1364] sd 11:0:0:7: [sdn] Optimal transfer size 524288 b=
ytes
[ 2058.818822] [  T14464] scsi 11:0:0:10: Power-on or device reset occurred
[ 2058.822197] [  T12862] sd 11:0:0:5: [sdl] Optimal transfer size 524288 b=
ytes
[ 2058.822964] [  T14478] sd 11:0:0:10: [sdq] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2058.823055] [  T14478] sd 11:0:0:10: [sdq] Write Protect is off
[ 2058.823080] [  T14478] sd 11:0:0:10: [sdq] Mode Sense: 73 00 10 08
[ 2058.823141] [  T14464] sd 11:0:0:10: Attached scsi generic sg17 type 0
[ 2058.823221] [  T14478] sd 11:0:0:10: [sdq] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2058.823573] [  T14478] sd 11:0:0:10: [sdq] permanent stream count =3D 5
[ 2058.823778] [  T14478] sd 11:0:0:10: [sdq] Preferred minimum I/O size 51=
2 bytes
[ 2058.823802] [  T14478] sd 11:0:0:10: [sdq] Optimal transfer size 524288 =
bytes
[ 2058.828884] [  T14464] scsi 11:0:0:11: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2058.829178] [    T218] sd 11:0:0:9: [sdp] Optimal transfer size 524288 b=
ytes
[ 2058.831324] [  T14464] scsi 11:0:0:11: Power-on or device reset occurred
[ 2058.835542] [  T14464] sd 11:0:0:11: Attached scsi generic sg18 type 0
[ 2058.835556] [  T14481] sd 11:0:0:11: [sdr] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2058.835653] [  T14481] sd 11:0:0:11: [sdr] Write Protect is off
[ 2058.835679] [  T14481] sd 11:0:0:11: [sdr] Mode Sense: 73 00 10 08
[ 2058.835827] [  T14481] sd 11:0:0:11: [sdr] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2058.836189] [  T14481] sd 11:0:0:11: [sdr] permanent stream count =3D 5
[ 2058.836404] [  T14481] sd 11:0:0:11: [sdr] Preferred minimum I/O size 51=
2 bytes
[ 2058.836428] [  T14481] sd 11:0:0:11: [sdr] Optimal transfer size 524288 =
bytes
[ 2058.839928] [  T13564] sd 11:0:0:6: [sdm] Attached SCSI disk
[ 2058.840436] [   T1363] sd 11:0:0:4: [sdk] Attached SCSI disk
[ 2059.355076] [  T14464] scsi 11:0:0:12: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.368193] [   T1364] sd 11:0:0:7: [sdn] Attached SCSI disk
[ 2059.369823] [  T14464] scsi 11:0:0:12: Power-on or device reset occurred
[ 2059.370714] [   T1833] sd 11:0:0:8: [sdo] Attached SCSI disk
[ 2059.391641] [  T12862] sd 11:0:0:5: [sdl] Attached SCSI disk
[ 2059.392407] [  T14481] sd 11:0:0:11: [sdr] Attached SCSI disk
[ 2059.396276] [  T14478] sd 11:0:0:10: [sdq] Attached SCSI disk
[ 2059.396329] [    T218] sd 11:0:0:9: [sdp] Attached SCSI disk
[ 2059.397480] [   T1364] sd 11:0:0:12: [sds] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.397559] [   T1364] sd 11:0:0:12: [sds] Write Protect is off
[ 2059.397581] [   T1364] sd 11:0:0:12: [sds] Mode Sense: 73 00 10 08
[ 2059.397703] [   T1364] sd 11:0:0:12: [sds] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.398026] [   T1364] sd 11:0:0:12: [sds] permanent stream count =3D 5
[ 2059.400715] [  T14464] sd 11:0:0:12: Attached scsi generic sg19 type 0
[ 2059.402998] [  T14464] scsi 11:0:0:13: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.404655] [  T14464] scsi 11:0:0:13: Power-on or device reset occurred
[ 2059.409121] [   T1364] sd 11:0:0:12: [sds] Preferred minimum I/O size 51=
2 bytes
[ 2059.417442] [  T14481] sd 11:0:0:13: [sdt] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.418286] [  T14464] sd 11:0:0:13: Attached scsi generic sg20 type 0
[ 2059.421955] [  T14464] scsi 11:0:0:14: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.422764] [   T1364] sd 11:0:0:12: [sds] Optimal transfer size 524288 =
bytes
[ 2059.427967] [  T14464] scsi 11:0:0:14: Power-on or device reset occurred
[ 2059.428505] [  T14481] sd 11:0:0:13: [sdt] Write Protect is off
[ 2059.430198] [  T14464] sd 11:0:0:14: Attached scsi generic sg21 type 0
[ 2059.430731] [  T12862] sd 11:0:0:14: [sdu] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.430827] [  T12862] sd 11:0:0:14: [sdu] Write Protect is off
[ 2059.430853] [  T12862] sd 11:0:0:14: [sdu] Mode Sense: 73 00 10 08
[ 2059.431015] [  T12862] sd 11:0:0:14: [sdu] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.431365] [  T12862] sd 11:0:0:14: [sdu] permanent stream count =3D 5
[ 2059.431576] [  T12862] sd 11:0:0:14: [sdu] Preferred minimum I/O size 51=
2 bytes
[ 2059.431601] [  T12862] sd 11:0:0:14: [sdu] Optimal transfer size 524288 =
bytes
[ 2059.438581] [  T14481] sd 11:0:0:13: [sdt] Mode Sense: 73 00 10 08
[ 2059.446665] [  T14464] scsi 11:0:0:15: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.451125] [  T14481] sd 11:0:0:13: [sdt] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.461086] [  T14464] scsi 11:0:0:15: Power-on or device reset occurred
[ 2059.466682] [  T14481] sd 11:0:0:13: [sdt] permanent stream count =3D 5
[ 2059.475132] [    T218] sd 11:0:0:15: [sdv] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.475420] [  T14464] sd 11:0:0:15: Attached scsi generic sg22 type 0
[ 2059.477071] [  T14464] scsi 11:0:0:16: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.478157] [  T14464] scsi 11:0:0:16: Power-on or device reset occurred
[ 2059.479761] [  T14478] sd 11:0:0:16: [sdw] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.479797] [  T14464] sd 11:0:0:16: Attached scsi generic sg23 type 0
[ 2059.479820] [  T14478] sd 11:0:0:16: [sdw] Write Protect is off
[ 2059.479835] [  T14478] sd 11:0:0:16: [sdw] Mode Sense: 73 00 10 08
[ 2059.479933] [  T14478] sd 11:0:0:16: [sdw] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.480152] [  T14478] sd 11:0:0:16: [sdw] permanent stream count =3D 5
[ 2059.480269] [  T14478] sd 11:0:0:16: [sdw] Preferred minimum I/O size 51=
2 bytes
[ 2059.480283] [  T14478] sd 11:0:0:16: [sdw] Optimal transfer size 524288 =
bytes
[ 2059.481441] [  T14464] scsi 11:0:0:17: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.482000] [  T14481] sd 11:0:0:13: [sdt] Preferred minimum I/O size 51=
2 bytes
[ 2059.482517] [  T14464] scsi 11:0:0:17: Power-on or device reset occurred
[ 2059.484733] [   T1833] sd 11:0:0:17: [sdx] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.484809] [   T1833] sd 11:0:0:17: [sdx] Write Protect is off
[ 2059.484822] [   T1833] sd 11:0:0:17: [sdx] Mode Sense: 73 00 10 08
[ 2059.484898] [   T1833] sd 11:0:0:17: [sdx] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.485071] [  T14464] sd 11:0:0:17: Attached scsi generic sg24 type 0
[ 2059.485185] [   T1833] sd 11:0:0:17: [sdx] permanent stream count =3D 5
[ 2059.485357] [   T1833] sd 11:0:0:17: [sdx] Preferred minimum I/O size 51=
2 bytes
[ 2059.485378] [   T1833] sd 11:0:0:17: [sdx] Optimal transfer size 524288 =
bytes
[ 2059.488238] [    T218] sd 11:0:0:15: [sdv] Write Protect is off
[ 2059.489294] [  T14464] scsi 11:0:0:18: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.490737] [  T14464] scsi 11:0:0:18: Power-on or device reset occurred
[ 2059.493269] [  T14487] sd 11:0:0:18: [sdy] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.493331] [  T14487] sd 11:0:0:18: [sdy] Write Protect is off
[ 2059.493345] [  T14487] sd 11:0:0:18: [sdy] Mode Sense: 73 00 10 08
[ 2059.493448] [  T14487] sd 11:0:0:18: [sdy] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.493611] [  T14464] sd 11:0:0:18: Attached scsi generic sg25 type 0
[ 2059.493792] [  T14487] sd 11:0:0:18: [sdy] permanent stream count =3D 5
[ 2059.494021] [  T14487] sd 11:0:0:18: [sdy] Preferred minimum I/O size 51=
2 bytes
[ 2059.494046] [  T14487] sd 11:0:0:18: [sdy] Optimal transfer size 524288 =
bytes
[ 2059.497143] [  T14481] sd 11:0:0:13: [sdt] Optimal transfer size 524288 =
bytes
[ 2059.497221] [  T14464] scsi 11:0:0:19: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.499748] [  T14464] scsi 11:0:0:19: Power-on or device reset occurred
[ 2059.503212] [  T14485] sd 11:0:0:19: [sdz] 268435456 512-byte logical bl=
ocks: (137 GB/128 GiB)
[ 2059.503260] [  T14485] sd 11:0:0:19: [sdz] Write Protect is off
[ 2059.503271] [  T14485] sd 11:0:0:19: [sdz] Mode Sense: 73 00 10 08
[ 2059.503334] [  T14485] sd 11:0:0:19: [sdz] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.503524] [  T14485] sd 11:0:0:19: [sdz] permanent stream count =3D 5
[ 2059.503615] [  T14485] sd 11:0:0:19: [sdz] Preferred minimum I/O size 51=
2 bytes
[ 2059.503626] [  T14485] sd 11:0:0:19: [sdz] Optimal transfer size 524288 =
bytes
[ 2059.504037] [    T218] sd 11:0:0:15: [sdv] Mode Sense: 73 00 10 08
[ 2059.504265] [  T14464] sd 11:0:0:19: Attached scsi generic sg26 type 0
[ 2059.510373] [  T14464] scsi 11:0:0:20: Direct-Access     Linux    scsi_d=
ebug       0191 PQ: 0 ANSI: 7
[ 2059.512917] [  T14464] scsi 11:0:0:20: Power-on or device reset occurred
[ 2059.517673] [    T218] sd 11:0:0:15: [sdv] Write cache: enabled, read ca=
che: enabled, supports DPO and FUA
[ 2059.525556] [   T1363] sd 11:0:0:20: [sdaa] 268435456 512-byte logical b=
locks: (137 GB/128 GiB)
[ 2059.525589] [  T14464] sd 11:0:0:20: Attached scsi generic sg27 type 0
[ 2059.531486] [    T218] sd 11:0:0:15: [sdv] permanent stream count =3D 5
[ 2059.532238] [   T1364] sd 11:0:0:12: [sds] Attached SCSI disk
[ 2059.534441] [  T12862] sd 11:0:0:14: [sdu] Attached SCSI disk
[ 2059.538052] [   T1363] sd 11:0:0:20: [sdaa] Write Protect is off
[ 2059.550328] [    T218] sd 11:0:0:15: [sdv] Preferred minimum I/O size 51=
2 bytes
[ 2059.555806] [   T1833] sd 11:0:0:17: [sdx] Attached SCSI disk
[ 2059.557742] [  T14487] sd 11:0:0:18: [sdy] Attached SCSI disk
[ 2059.560125] [   T1363] sd 11:0:0:20: [sdaa] Mode Sense: 73 00 10 08
[ 2059.560297] [   T1363] sd 11:0:0:20: [sdaa] Write cache: enabled, read c=
ache: enabled, supports DPO and FUA
[ 2059.561407] [    T218] sd 11:0:0:15: [sdv] Optimal transfer size 524288 =
bytes
[ 2059.562159] [   T1363] sd 11:0:0:20: [sdaa] permanent stream count =3D 5
[ 2059.562378] [   T1363] sd 11:0:0:20: [sdaa] Preferred minimum I/O size 5=
12 bytes
[ 2059.562404] [   T1363] sd 11:0:0:20: [sdaa] Optimal transfer size 524288=
 bytes
[ 2059.568521] [  T14478] sd 11:0:0:16: [sdw] Attached SCSI disk
[ 2059.578734] [  T14481] sd 11:0:0:13: [sdt] Attached SCSI disk
[ 2059.581764] [  T14485] sd 11:0:0:19: [sdz] Attached SCSI disk
[ 2060.106344] [   T1363] sd 11:0:0:20: [sdaa] Attached SCSI disk
[ 2060.107143] [    T218] sd 11:0:0:15: [sdv] Attached SCSI disk
[ 2068.306807] [    T228] device offline error, dev sdg, sector 240029840 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.306873] [  T14725] device offline error, dev sdg, sector 247308192 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.306917] [  T14726] device offline error, dev sdg, sector 224634144 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.306983] [  T14726] device offline error, dev sdg, sector 124187600 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.307045] [  T14726] device offline error, dev sdg, sector 228636432 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.307103] [  T14726] device offline error, dev sdg, sector 148430040 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.307159] [  T14726] device offline error, dev sdg, sector 199986560 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.307214] [  T14726] device offline error, dev sdg, sector 203109272 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.307274] [  T14726] device offline error, dev sdg, sector 129162896 o=
p 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.307335] [  T14726] device offline error, dev sdg, sector 47078976 op=
 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2068.540859] [  T14410] sd 11:0:0:0: [sdg] Synchronizing SCSI cache
[ 2068.800785] [  T14410] sd 11:0:0:1: [sdh] Synchronizing SCSI cache
[ 2218.084237] [    T143] INFO: task check:14410 blocked for more than 122 =
seconds.
[ 2218.094422] [    T143]       Tainted: G    B               6.15.0-rc5-ne=
xt-20250507-kts #1
[ 2218.106947] [    T143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs=
" disables this message.
[ 2218.116296] [    T143] task:check           state:D stack:0     pid:1441=
0 tgid:14410 ppid:1685   task_flags:0x480140 flags:0x00004002
[ 2218.129533] [    T143] Call Trace:
[ 2218.134258] [    T143]  <TASK>
[ 2218.138356] [    T143]  __schedule+0x8bc/0x1ad0
[ 2218.143896] [    T143]  ? __pfx___schedule+0x10/0x10
[ 2218.149865] [    T143]  ? do_raw_spin_lock+0x128/0x270
[ 2218.156000] [    T143]  ? do_raw_spin_lock+0x128/0x270
[ 2218.162093] [    T143]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 2218.168553] [    T143]  ? trace_hardirqs_on+0x18/0x150
[ 2218.174675] [    T143]  ? lock_acquire+0xf7/0x140
[ 2218.180278] [    T143]  ? lock_acquire+0xf7/0x140
[ 2218.185895] [    T143]  schedule+0xd1/0x250
[ 2218.190977] [    T143]  blk_mq_freeze_queue_wait+0x125/0x170
[ 2218.197487] [    T143]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[ 2218.204532] [    T143]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 2218.211608] [    T143]  ? __blk_freeze_queue_start+0xa6/0x490
[ 2218.218196] [    T143]  elevator_change+0xa0/0x380
[ 2218.223878] [    T143]  elevator_set_none+0x85/0xc0
[ 2218.229622] [    T143]  ? __pfx_elevator_set_none+0x10/0x10
[ 2218.236006] [    T143]  ? __pfx___might_resched+0x10/0x10
[ 2218.242282] [    T143]  blk_unregister_queue+0x114/0x2d0
[ 2218.248424] [    T143]  __del_gendisk+0x263/0xa20
[ 2218.253921] [    T143]  ? down_read+0x1b6/0x480
[ 2218.259279] [    T143]  ? __pfx___del_gendisk+0x10/0x10
[ 2218.265274] [    T143]  ? __pfx_down_read+0x10/0x10
[ 2218.270896] [    T143]  ? __pfx_down_write+0x10/0x10
[ 2218.276702] [    T143]  ? __up_write+0x192/0x4f0
[ 2218.282087] [    T143]  del_gendisk+0x106/0x190
[ 2218.287406] [    T143]  sd_remove+0x8a/0x140
[ 2218.292539] [    T143]  device_release_driver_internal+0x36d/0x520
[ 2218.299531] [    T143]  bus_remove_device+0x1ef/0x3f0
[ 2218.305414] [    T143]  device_del+0x3be/0x9b0
[ 2218.310663] [    T143]  ? attribute_container_device_trigger+0x181/0x1f0
[ 2218.318127] [    T143]  ? __pfx_device_del+0x10/0x10
[ 2218.323841] [    T143]  ? __pfx_attribute_container_device_trigger+0x10/=
0x10
[ 2218.331699] [    T143]  __scsi_remove_device+0x27f/0x340
[ 2218.337847] [    T143]  sdev_store_delete+0x87/0x120
[ 2218.343608] [    T143]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 2218.349748] [    T143]  kernfs_fop_write_iter+0x39b/0x5a0
[ 2218.355956] [    T143]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[ 2218.362758] [    T143]  vfs_write+0x518/0xee0
[ 2218.367931] [    T143]  ? __pfx_vfs_write+0x10/0x10
[ 2218.372630] [     C11] perf: interrupt took too long (4051 > 3946), lowe=
ring kernel.perf_event_max_sample_rate to 49000
[ 2218.385314] [    T143]  ? fput_close+0x137/0x1a0
[ 2218.390981] [    T143]  ? __pfx_fput_close+0x10/0x10
[ 2218.396384] [    T143]  ksys_write+0xff/0x200
[ 2218.401111] [    T143]  ? __pfx_ksys_write+0x10/0x10
[ 2218.406434] [    T143]  ? __x64_sys_dup2+0x6f/0x580
[ 2218.411640] [    T143]  do_syscall_64+0x94/0x380
[ 2218.416575] [    T143]  ? __x64_sys_fcntl+0x10d/0x1c0
[ 2218.421958] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2218.428211] [    T143]  ? do_syscall_64+0x158/0x380
[ 2218.433429] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2218.439685] [    T143]  ? do_syscall_64+0x158/0x380
[ 2218.444895] [    T143]  ? __pfx_do_fcntl+0x10/0x10
[ 2218.450048] [    T143]  ? __pfx_locks_remove_posix+0x10/0x10
[ 2218.456066] [    T143]  ? fput_close_sync+0x137/0x1a0
[ 2218.461466] [    T143]  ? __pfx_fput_close_sync+0x10/0x10
[ 2218.467225] [    T143]  ? do_raw_spin_unlock+0x59/0x230
[ 2218.472802] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2218.479082] [    T143]  ? do_syscall_64+0x158/0x380
[ 2218.484313] [    T143]  ? do_syscall_64+0x158/0x380
[ 2218.489534] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2218.495796] [    T143]  ? do_syscall_64+0x158/0x380
[ 2218.501022] [    T143]  ? clear_bhb_loop+0x15/0x70
[ 2218.506173] [    T143]  ? clear_bhb_loop+0x15/0x70
[ 2218.511312] [    T143]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2218.517656] [    T143] RIP: 0033:0x7fb767562a06
[ 2218.522533] [    T143] RSP: 002b:00007fffb0f33340 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[ 2218.531427] [    T143] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: =
00007fb767562a06
[ 2218.539877] [    T143] RDX: 0000000000000002 RSI: 00005648de664130 RDI: =
0000000000000001
[ 2218.548203] [    T143] RBP: 00007fffb0f33360 R08: 0000000000000000 R09: =
0000000000000000
[ 2218.556517] [    T143] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000002
[ 2218.564837] [    T143] R13: 00005648de664130 R14: 00007fb7676de5c0 R15: =
0000000000000000
[ 2218.573172] [    T143]  </TASK>
[ 2218.576543] [    T143] INFO: lockdep is turned off.
[ 2340.963556] [    T143] INFO: task check:14410 blocked for more than 245 =
seconds.
[ 2340.971224] [    T143]       Tainted: G    B               6.15.0-rc5-ne=
xt-20250507-kts #1
[ 2340.979726] [    T143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs=
" disables this message.
[ 2340.989157] [    T143] task:check           state:D stack:0     pid:1441=
0 tgid:14410 ppid:1685   task_flags:0x480140 flags:0x00004002
[ 2341.003091] [    T143] Call Trace:
[ 2341.007396] [    T143]  <TASK>
[ 2341.011333] [    T143]  __schedule+0x8bc/0x1ad0
[ 2341.016799] [    T143]  ? __pfx___schedule+0x10/0x10
[ 2341.022709] [    T143]  ? do_raw_spin_lock+0x128/0x270
[ 2341.028775] [    T143]  ? do_raw_spin_lock+0x128/0x270
[ 2341.034846] [    T143]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 2341.041255] [    T143]  ? trace_hardirqs_on+0x18/0x150
[ 2341.047327] [    T143]  ? lock_acquire+0xf7/0x140
[ 2341.052915] [    T143]  ? lock_acquire+0xf7/0x140
[ 2341.058495] [    T143]  schedule+0xd1/0x250
[ 2341.063543] [    T143]  blk_mq_freeze_queue_wait+0x125/0x170
[ 2341.070028] [    T143]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[ 2341.077113] [    T143]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 2341.084203] [    T143]  ? __blk_freeze_queue_start+0xa6/0x490
[ 2341.090822] [    T143]  elevator_change+0xa0/0x380
[ 2341.096468] [    T143]  elevator_set_none+0x85/0xc0
[ 2341.102214] [    T143]  ? __pfx_elevator_set_none+0x10/0x10
[ 2341.108699] [    T143]  ? __pfx___might_resched+0x10/0x10
[ 2341.114990] [    T143]  blk_unregister_queue+0x114/0x2d0
[ 2341.121165] [    T143]  __del_gendisk+0x263/0xa20
[ 2341.126716] [    T143]  ? down_read+0x1b6/0x480
[ 2341.132092] [    T143]  ? __pfx___del_gendisk+0x10/0x10
[ 2341.138132] [    T143]  ? __pfx_down_read+0x10/0x10
[ 2341.143916] [    T143]  ? __pfx_down_write+0x10/0x10
[ 2341.149750] [    T143]  ? __up_write+0x192/0x4f0
[ 2341.155184] [    T143]  del_gendisk+0x106/0x190
[ 2341.160598] [    T143]  sd_remove+0x8a/0x140
[ 2341.165732] [    T143]  device_release_driver_internal+0x36d/0x520
[ 2341.172754] [    T143]  bus_remove_device+0x1ef/0x3f0
[ 2341.178636] [    T143]  device_del+0x3be/0x9b0
[ 2341.183990] [    T143]  ? attribute_container_device_trigger+0x181/0x1f0
[ 2341.191578] [    T143]  ? __pfx_device_del+0x10/0x10
[ 2341.197419] [    T143]  ? __pfx_attribute_container_device_trigger+0x10/=
0x10
[ 2341.205375] [    T143]  __scsi_remove_device+0x27f/0x340
[ 2341.211577] [    T143]  sdev_store_delete+0x87/0x120
[ 2341.217414] [    T143]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 2341.223526] [    T143]  kernfs_fop_write_iter+0x39b/0x5a0
[ 2341.229798] [    T143]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[ 2341.236595] [    T143]  vfs_write+0x518/0xee0
[ 2341.241765] [    T143]  ? __pfx_vfs_write+0x10/0x10
[ 2341.247472] [    T143]  ? fput_close+0x137/0x1a0
[ 2341.252946] [    T143]  ? __pfx_fput_close+0x10/0x10
[ 2341.258713] [    T143]  ksys_write+0xff/0x200
[ 2341.263860] [    T143]  ? __pfx_ksys_write+0x10/0x10
[ 2341.269648] [    T143]  ? __x64_sys_dup2+0x6f/0x580
[ 2341.275206] [    T143]  do_syscall_64+0x94/0x380
[ 2341.280529] [    T143]  ? __x64_sys_fcntl+0x10d/0x1c0
[ 2341.286276] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2341.292862] [    T143]  ? do_syscall_64+0x158/0x380
[ 2341.298442] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2341.305135] [    T143]  ? do_syscall_64+0x158/0x380
[ 2341.310788] [    T143]  ? __pfx_do_fcntl+0x10/0x10
[ 2341.316458] [    T143]  ? __pfx_locks_remove_posix+0x10/0x10
[ 2341.322641] [    T143]  ? fput_close_sync+0x137/0x1a0
[ 2341.328001] [    T143]  ? __pfx_fput_close_sync+0x10/0x10
[ 2341.333709] [    T143]  ? do_raw_spin_unlock+0x59/0x230
[ 2341.339247] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2341.345497] [    T143]  ? do_syscall_64+0x158/0x380
[ 2341.350705] [    T143]  ? do_syscall_64+0x158/0x380
[ 2341.355891] [    T143]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2341.362119] [    T143]  ? do_syscall_64+0x158/0x380
[ 2341.367295] [    T143]  ? clear_bhb_loop+0x15/0x70
[ 2341.372406] [    T143]  ? clear_bhb_loop+0x15/0x70
[ 2341.377509] [    T143]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2341.383830] [    T143] RIP: 0033:0x7fb767562a06
[ 2341.388679] [    T143] RSP: 002b:00007fffb0f33340 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[ 2341.397534] [    T143] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: =
00007fb767562a06
[ 2341.405949] [    T143] RDX: 0000000000000002 RSI: 00005648de664130 RDI: =
0000000000000001
[ 2341.414385] [    T143] RBP: 00007fffb0f33360 R08: 0000000000000000 R09: =
0000000000000000
[ 2341.422829] [    T143] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000002
[ 2341.431257] [    T143] R13: 00005648de664130 R14: 00007fb7676de5c0 R15: =
0000000000000000
[ 2341.439709] [    T143]  </TASK>
...=
