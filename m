Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D78277026
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908357; cv=fail; b=duoypyrFxwOiXHRz/WcpVAHv4mPw9zS4BX/QL+yz7klwydk2JBxVvTkGcBtX5ouer6FWsK7eqhmnZcjlnFoKTQW+oDeL2BDbcjtdPT6wvj5xyKMfL0lN5NtNcN88y+RhqwgnOyrNHxi1JoF5vGCeQzn7urb66AJ1mEkTa6V/5j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908357; c=relaxed/simple;
	bh=at0MMogXjn05LmuFwabg5+BkyUoDb+GE83Ic3Nr/6Oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftHL9g+CYLyhxtl+F0cE8sus7yqRCXqvWsB+Sxs9kIgUZrnuPVMQ+Qo7/XZCcYil+rE5sbqMSr3jQmqKpdiKi/68sE4u7b/Xe/F/wvtKqSe2jf7bfmrybeYkcdDj7K4V5hZtgXwrOdM4TUJzYkrnXxvcGLgraUAuEZhnml5/Y3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NnU22ZLE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pqpv54Z2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NnU22ZLE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pqpv54Z2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761908356; x=1793444356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=at0MMogXjn05LmuFwabg5+BkyUoDb+GE83Ic3Nr/6Oo=;
  b=NnU22ZLEXqw0NKCSfPGNxZUO5SzBIa+j3JT0DymRmfAkvCzs0iZI6SJa
   1Pe2xld2NejnotqfaA9oM04terR949gc6ADZp2mpmha7rNc0Frz60ql3g
   nGjslDjzqAecHMvXFwuTlVfu8KUWLh2VJj5A46V0kZcDfvvyqRYGU67c2
   aq35hXI52/2nfOA1k2aDrO3FTM6K6HK4iZ6xG7SskYKelbvltQTfOzJJh
   n6+YbNvrmo9AnFnzazEcMOqS/W74HwxkLqM3XOTfGXV7CGp1ihegJn8s0
   hNYWazxFRYXBJWglqIKZ1R/34XmrrpiFElon1npnuuMfqtCuT0JaMnq5k
   A==;
X-CSE-ConnectionGUID: 134PfZChRwyjEpszgJzNoQ==
X-CSE-MsgGUID: hONjKZXAQzSFxqpxZDWIXg==
X-IronPort-AV: E=Sophos;i="6.19,269,1754928000"; 
   d="scan'208";a="135529732"
Received: from mail-northcentralusazon11010012.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.12])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 18:59:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrUVCH49BW5S033mCqDPnWyZU2aRnfO6FLzgnmcDPu/cIBN04l+z9n1jJ2z+weY5sFP6i9vsEWt7gy/iZD2oUmUEBTe3GE5+CMHseaZolSynVk5Oh96VQX7zGnKl0FwJQ9GXiWof6I1ixDvjbuPjn/qCGdA5dQ/D5sl9QSEg0JGzBqJON6OLHtv99nBGaAzHcyMnvkzMVka/56p0M2mkUpx5KJplmuauSunCFhY8G9HCC8e12B0QbQ1ToTjOqx1RwyIBUvCa7EkYSQ73gz118ruB6J+6w2lqcEsW0qaMoEKh9NxW9vsvAzS1Iiho+4W2SC7tBnq5OG/xvcKzOSDksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at0MMogXjn05LmuFwabg5+BkyUoDb+GE83Ic3Nr/6Oo=;
 b=EIW/BKLLYECWj25aRroNlfYlsm+apidIaI0wEfUBVoTq43vbTawBoCSqI1OPWaxn0NSw0rlTnetlgBbYWgpAM9VVxZEUrc8tISdttJf9iJZGEPuZrUWsMhLCaMAVdje0WTz5Nu0sWcrQiegNJ1wjjfGmaShVyaWNJtKy9/oz2rrlZhfHc6FIWV50dNX6PkVP+9YqEBk6a+CHZFBIL/TSqtxyigAsmhaIXSyzUXrRvgj/V94gqfdpeT3/zp6ajwKMzz8q0v8fQtSAVvX5XnH4Md+7WAajGTp1n9SnsQAc3cUBqs7s09seOf7W3FNRqZXvDJ+jmbFwIQzQOC/ATd9IZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at0MMogXjn05LmuFwabg5+BkyUoDb+GE83Ic3Nr/6Oo=;
 b=pqpv54Z23odXtj4FB2YNOpTHnrgqHGhJF2YFHrO+fVT4anbQH1m1k9VjNIbhVfkmlvrApIAJBcI7OAWs+9KPsMNOTOkmtnL7S3yDmcbSd1E+R/whyGioX/LhQ7IV/1cP6z3N4z2N7BbQisTFDXOz8rMUJwrun9oGZCGoAJGQ+no=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MW6PR04MB8842.namprd04.prod.outlook.com (2603:10b6:303:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:59:10 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 10:59:10 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktest] Makefile: add check-parallel target for faster
 shellcheck
Thread-Topic: [PATCH blktest] Makefile: add check-parallel target for faster
 shellcheck
Thread-Index: AQHcSEB3AForjEJNGEOqMbQlHkj1IrTcGkEA
Date: Fri, 31 Oct 2025 10:59:10 +0000
Message-ID: <ssbymynn2b25do6rrm6kogpxyoqgsvl3ljf6iaawhkthus6qdi@6336mp6ppuyz>
References: <20251028192411.19144-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028192411.19144-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MW6PR04MB8842:EE_
x-ms-office365-filtering-correlation-id: 13de6cdc-fa40-48bd-6264-08de186c8523
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?87ooiENSHGXNgjtdC4lTzUecwSW3pmYMFDDdqevKA3Y6TTLsnXCQqtJX6lhw?=
 =?us-ascii?Q?GZyFs20kitnKlrhWndgX9Ij0FU56SGMXAD4AY2j7csY4c5VOakmy7BGhUH4j?=
 =?us-ascii?Q?YxtW2J7cH7F78cahRIRkHsvs3Jd6pA1tBzfa5mDY/pXOzEv4KMFk0s7Nywxo?=
 =?us-ascii?Q?SbGfF71xdL59Q1fpy6zYPC+oA3yZHsCAMcUhxVjjSKfjiSRcYFAg5RLWswiN?=
 =?us-ascii?Q?oRUd8qXkJjMeSZFWnl569Z/PTwLsSRBgGt74pmDUd1OPm5QgbM/zYFfBF1sV?=
 =?us-ascii?Q?J+L+R5SUCT0kB3fmXDWTYcJc/MXbGU/JEhPOLbXFvyrwfQpheBlr8GM4Apkz?=
 =?us-ascii?Q?z5yI+P6b87WwjyDl+6jIq51kuKlgyCsrh8nAATytUNTn4ZhpKgbWnC04ZAU1?=
 =?us-ascii?Q?17NrZCAHlwrFVAhr1kniXbqTVogPlkqXg95Y+2OupfQgGq1knyz4HyFlTT/4?=
 =?us-ascii?Q?Ugwwe+Zvq6xRU8AwIxdY2/FsMRy1hJddEorKqcIn3WsYQtoR2mFhPwuztsQF?=
 =?us-ascii?Q?65V8TPzDUeG6YQSg31buZsrqTO+WPUG6EkikWYnTsJ1FNi/J44r3SnNI9qSi?=
 =?us-ascii?Q?XvsYBc49zxEIRJB2MfNsrNbWO/B0gkRZ/rRFWWK9IG5tEq7thHpPPCp/x6Lh?=
 =?us-ascii?Q?+N4fqOxUe3n3ZeVw3qYOiXqSnSGC4BDKIhSEZXlnVRciDPeEdiZa2kPkIMuI?=
 =?us-ascii?Q?SO4WxlTDrV034yLVzY0BRUGZ63JeuHGCx3OpWajWV68vdCqXR8UG1JY/qTks?=
 =?us-ascii?Q?hRoF+qmHmACqMMQD8mw4tvtXMtyndAi2t1/locV9Kd387e/OGQxXMcWtlBwh?=
 =?us-ascii?Q?Gyx1KNsdwCcXizDA1WCMKGqWcHjub6Ushjar2HwDGm1gzhI8oXJPLG+yQd90?=
 =?us-ascii?Q?wV17p65TsSsJpGfRcFJld9A+a9BXH88WO7PkLKSK3BfoPu21uEuGFIw4gDGe?=
 =?us-ascii?Q?hDEFtkHyKxKQBC+XC5K2KDorXiEajkJ3LPv3VNDzZkKQPtUSo6Jv0zgL+yDV?=
 =?us-ascii?Q?P6YPuXYhwTAGuA0BAFT1GV+b6m+gjEw601lNhcEKSwzs2NeXxeedUPlWQeOd?=
 =?us-ascii?Q?Q4dLJvziYg0PYathRO0ZvyB6eq/r2EFqsgF9kXCDd1uLBwG5ozeh8yldWYBm?=
 =?us-ascii?Q?YIVNVZy6pebUzTRe56FJc+EeA1fNJIdRmS6FA1lQoqd4wXnR3LfYCXvwwrVy?=
 =?us-ascii?Q?1e77eUfsmSBL2YCP+bmNEcjcvVrDK/nAcQvwjDDNMmS4Oovur1SUbV+sVjwT?=
 =?us-ascii?Q?s7wztMDth2D6IK/uHFahoTD6RAOyFmUna/YcGhABtAnOY4M+iAv6i7H/hVmD?=
 =?us-ascii?Q?RzxUIO8zuB/e/AwEGbFDGexmUlAVoWCf5cqXXZY3pLeJn1K9sBpUTgFIC6DT?=
 =?us-ascii?Q?hHdCLGc5q3KMC5IadX7yFofk8SWi5DSg/vjF0Z0comWl6U4iwtfo/YAJdh92?=
 =?us-ascii?Q?jh4bwbZz4eQKaH8G6rdMzCZmLxetbPCu+H8xc5EvKKqGA2g99lNDX8krrFH1?=
 =?us-ascii?Q?fNR2YrnyoYBZJ+7cdLdRiUf4xkpQF6ut5cTD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Thx01o/Qsnn7KSUiFxE2zBMBsLed0raN+WDQ83q5w3xlDLoM9mtqbipmGfyl?=
 =?us-ascii?Q?VgEw0VK1mjTsquSmETmqxi1AD34so6xz3qrGKf0xEw8Vgd/Th0iXooXeKhG1?=
 =?us-ascii?Q?GFdDu/SJI70tPdDeeTQPGyj2YpNFIP7EA8tMxrfCIOY2gQTGZreDXP+wCnVs?=
 =?us-ascii?Q?0kkRH5/UshTDtICLGFLDIoF5BH19NupKqDCdpXVUEtYbkOTNiEyHjRgqPjlM?=
 =?us-ascii?Q?gigMne7s4nyNqnq/BDWqDHu+OphtmHnmDxQsr97dhm9A60sJct+bmxFJIyVX?=
 =?us-ascii?Q?GwPXFSzbkIJvsVqKGt0qPTChsKlurrkjBcUpdnaVAg8dnr6t47CkcVbTjJgC?=
 =?us-ascii?Q?qrrm3mV9cZy3XQqGWTBRChm+VX67aVsdIPM22a4o/uxu7G3vM5CFhSd2PiV0?=
 =?us-ascii?Q?8Ahamh25MDW+mO1nFWhKLqkNpdJcNLfG9W5oxo8rCR9ogqHR09ru5BS5QkSl?=
 =?us-ascii?Q?5hnkxig4QnC5V31g7Kd4HV8IEs3sjmZoLLhKcKPI+arxEwlgPAa1k7EWSr2Y?=
 =?us-ascii?Q?Sm2EIfo56L9LjXXguC2BWNf1toynLOZnQoChDsb9t1yZVxN7HGc/uBTaotiJ?=
 =?us-ascii?Q?gITPHGuoYdnD97A9a/nUPokOWGXHJWET+ywcayGBopzYdcM8scJjQF1ue43L?=
 =?us-ascii?Q?IwXyo/+aN3gPetBh5mSKKWqIpM5AmKmqRffNMh1lH4w7yL86DLK7+3ra9eyz?=
 =?us-ascii?Q?LgEnReZcnr61i7xIXPjrCU7UGjvgkk6JMEoLhZHbColo58z5EPj26vSDp4Tn?=
 =?us-ascii?Q?L7PtSQ8qNKq13AktC7dnT/a43cc5hyW9uNKJXTzXq2hkB9GQ9RrLiWTdQ/w0?=
 =?us-ascii?Q?jdW6TdGx+vlgUwEfp1JCdVvirMHWB9zNKytO6ZtYhxslBwLPbwX3PiSxNGD0?=
 =?us-ascii?Q?gw7P3CCzbt80eLteAAbrlJVOJmcxzS4epjhuX2fJZADYQYCZvSjdvMQWnFHJ?=
 =?us-ascii?Q?tCLlA0fM8Gm/ilK8YrqAR8GnTY3TGxdIM3DD7kHFsZRwm8b6rJRQtdUaTDMS?=
 =?us-ascii?Q?MPhzioqO1EBMSjLCtbskA+yQjcd3jef4T30da7+u1Dv+UNKPxVHaisFx19dj?=
 =?us-ascii?Q?0ss/vZUkavXaw+ZDbswB+7HlPWQ8doixaMKxs+7IGTHkeEkshy0agghO+JsE?=
 =?us-ascii?Q?o7bp9lP7XFZrebse38jAtY8oK9K9AhpuDvRkOjEmDetiEzom2r0J/HXPLoWF?=
 =?us-ascii?Q?Evx36BQuw/7IpuehrVkqwGSqKPHFCdjK9ouCy+w+EMwrk8HMc+pa7T6dgX21?=
 =?us-ascii?Q?0EwwOSGigk2yWnEUlQpfVOl73Wito5OlZwP2fsUUT5uhAbun14t9E0FwGqju?=
 =?us-ascii?Q?OVRVBYYOAt3vflem6/adxfjaZrHS7+a2Y3VzyUUVsJhEHoQPAEOPDB7SQn6t?=
 =?us-ascii?Q?vj4mYoPh8fYtMS3mPjlMkGU+NRXohUJ6yNfXlAKb6vwahKcBLukHcBImFolZ?=
 =?us-ascii?Q?eW5RvBhEXb0MF1uV34LEyz8chqVXwEmUUU/m2wPpaVZnoNrbGBaxsup9k3Ai?=
 =?us-ascii?Q?zxxv4Jve9z66HbcYVtrQhHEqurRcFaiGG0I0MQG9QV6dZq36ir1ZuJFd30Vg?=
 =?us-ascii?Q?GB7PeSWFgmqWcRhHQrIB9yydAxE8EP2rmUbNgMEg866jbmNqqg9pIikrju2V?=
 =?us-ascii?Q?gN5LlrSQjHsnETAek2vxg+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99769A18DFE79B47BBCECE29A9BFF5C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	syNaUk5wnWtEoHBTJdrum1Y76wms9fkJrW43Rk01nDyBsqA5Ajf/nJ8f2M+IObgOB0ZKSuSi/6i9ZLSYDPaW6tStyhYmpHgBGH+GfbEugu0XuZVMeJSDF+Kv7q2TppOi/EPUyu+LXV0mkVEOhh2F9B5zcDFek4YJ40ZQulXjsIe1FAS3ldjvS8M/sj8z1QHQyjCHMElhv57D2Pj6zKsvg6YxMxjE/zlikf84yqoWmtI6Ea/Hs+L1VMZfrQRHuev4gfJpDdyk1toZNejQwqRAnLO3qEq1toibHGqQuHl0qShhjZpeSSn2ykUZc+ihzQzikQj2HdE/OXaowjq8wAE0sxM+Kr6aua4b1L4tGwMxTuebByEz86l0466a5dqxI8i/yLTS7NqNdLNCi/cYIE7JouDHXcSa+zr6FYbpqCwvcBcQeYTx+nlzGd8u1g7D4NUa6wT664x4Dl7Xp8AnaA+szAuY8kTCE352Kh8uXQSKG7WjCNeZWmenepzcz753dT/xeWqphXicITkM8ps6ulIQuC6ijqcK2DZFI03r4a0+6B2bisMr6c4FU2lYFa7t9iH0VdjfBVv22DbdF47E5wtrfSozvPtydNUc56p63TJJf3XrL4o7GOzYW8zjAJ+WynFq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13de6cdc-fa40-48bd-6264-08de186c8523
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 10:59:10.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtTvGEOGdiapANHD7CIzRs85KzVonOSzZD/dcOPEGvhX/Bcw1VLB0X/GpKN8mUh0GtRxfCB+wumMihiRS0tE03YAhavaCoPcGP9TZEkW8RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8842

On Oct 28, 2025 / 12:24, Chaitanya Kulkarni wrote:
> Add a new check-parallel target that utilizes all available CPUs to
> run shellcheck in parallel on test files, significantly reducing
> validation time from ~40s to ~11s on a 48-core system.

I love this patch! Thank you. I have just applied it :)

> The original check target remains unchanged for compatibility.

The check-parallel and the check targets have some duplication, then it is =
the
better to factor them out. Also, it's the better to explain check-parallel =
in
the documents. We can work on it later.=
