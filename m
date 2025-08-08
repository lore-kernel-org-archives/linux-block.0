Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C2246BD3
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639440; cv=fail; b=rqnUFlGE1LMAYajbA5Kh8v59jv2z1/+kUghhB0LjXmmWNZi2+5+hw+0xuHIl8CzPbiZ0eBAm86+hJHGRQh48IcQAEpeIvpmlw4WgyvMdU1T26Vjg98yegUjJRhIj+BvtLbwJ2GfEsyuJVVTNiD2cWdF4Jy0W+dJqnj7QumHVAs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639440; c=relaxed/simple;
	bh=Lu1JJGrCWvj2zWk55JaSstIOicZLhF4PrOD52qMCxyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQTyproCWK9NOC4NJL6MLinr3wUXzkL1H7AeyPxQkH7W+hXrENTYfHl36Xlpw6H7Ajr/lSkPCLRd8Ft9hVmuBnHwpP7YAo5fFIxYIdCpVBU7iDnQriEjsZc3qhDTk9dQXAHQGIF02cIPwrhonjzOVvub8oVYlkosnNFYExNMaNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DpME8qen; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t2ls24dn; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DpME8qen";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t2ls24dn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1754639438; x=1786175438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lu1JJGrCWvj2zWk55JaSstIOicZLhF4PrOD52qMCxyA=;
  b=DpME8qennJmHJm71/MDDhbPlzNbypoaBlstitNJLdDsTO6nXB37gg/gB
   3veOHL+SxokR0mTsMO7mVr64YgdfL4Pl/UWZmRligdW0XpNlg87HCxNJM
   a2iSm1TrQym5jq2xlmKSe+yChhs0wHT83mEAhKINADBwEZW0dF0XhaOva
   +vHCJsYLwAq45ITh6WGRWs4Xc7MP7w1IKz55rVFPgRDwIvDxAm+LYaTJT
   n5jePgD3GVN2n9mJ3/BIjd+0+44toW9kdyz4N1XJ8dgM7bH/D7sbfQKF2
   AjMDA8Sy4TOda+cLiP3K7DwoJ4xGyaXnsnW7AyEP9QEnjbmxl8E1dG6sF
   g==;
X-CSE-ConnectionGUID: K2dkOFP8Q+SHghBMOL6w0Q==
X-CSE-MsgGUID: yrDO9voAS5Ob4dcO8QbGng==
X-IronPort-AV: E=Sophos;i="6.17,274,1747670400"; 
   d="scan'208";a="107607641"
Received: from mail-westus3azon11010000.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.0])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2025 15:49:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I90j1u07vlEC7KR2p4UaeV6emAEfYGSfgfFl4/vnP7t+dDJf++gkbtyPQxOMBb70PJOnnorOQ+6ocDJmvPrr3WTrS3iNRfiqZlwU8oxqflZ3dsmh6Q5dtYZUVivMSCLqGFMDPDNFj5SuibYTnpGCSBZg6MLQlhIknqav3/e+fjRuBrSe/+KllitBYYIAuz0Dd/sx63hr4vvEKHcoPnz3mIz/9fjYVjLsBfki1bxrBJUleqLdm7KN8IxOMucmiHNxPGsStIukTtxyZ3otpYaFyl2BhbJgxZXw9Z60XwlPb7e7b9TcShHGXQ1EDtUN2GvwuWJNyk94EezMlSs6jGl5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu1JJGrCWvj2zWk55JaSstIOicZLhF4PrOD52qMCxyA=;
 b=hGv760o+CjvvRSym0NWjJNRqdYeOrLPP3z5Yh9q2I9uGhLmeXqx9EzyTR9HgEjCedAD8wcq0KkUy54lAMQUiTOfuSyVbPbUGa2tZpi1ML8JbFWnokOmU+uiRpOZynbhYYIMCsgm7uYWQphMCyjp3i2xMVnSuDRe07r+3lXl8iV171XFXWTI4RT731e1G66H84RneZDTQN4+wt9SmLbIdzGPuqlapNy0H8mNM4ybzA5mdIsWZPy+aCF2zEJLfQ45CLY5klwdprNKxv4iPPXKl1ePuT2iPkekeHw4I4Wolc8rz8JoB+8ZA1WRHn+S0mMCme6BREtf5bAs5R04dxMFEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu1JJGrCWvj2zWk55JaSstIOicZLhF4PrOD52qMCxyA=;
 b=t2ls24dnxgfFva50dyw01tGPqqsLDyt9SbKGfs8D9f+jnDmxAEj6ycf6mXmti8eUIs3B2Qyfwi7eWKvCo4IYuwrqym/vIi1dWwkR3pNfJ3MJrhgvJ1q2Bi7dknoq5pYA5b5waTMmtx3/OcH1OcRaldYzhs5hsvQXM9UJo1U+qUU=
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com (2603:10b6:a03:4f9::11)
 by DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Fri, 8 Aug 2025 07:49:24 +0000
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::8820:e830:536b:b29a]) by SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::8820:e830:536b:b29a%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 07:49:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>, "axboe@kernel.dk" <axboe@kernel.dk>, hch
	<hch@lst.de>, "kch@nvidia.com" <kch@nvidia.com>, "gjoyce@ibm.com"
	<gjoyce@ibm.com>
Subject: Re: [PATCHv2 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
Thread-Topic: [PATCHv2 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
Thread-Index: AQHcBizzNIYQzoHEIkGeAHIo4V0W+LRYZY4A
Date: Fri, 8 Aug 2025 07:49:23 +0000
Message-ID: <o5l6qzl7jju2yt7fcy2k33a2jp5fprc5zgmhxz4uphdvy6v4kg@yhl3x3kktdti>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
In-Reply-To: <20250805171749.3448694-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8536:EE_|DM8PR04MB8037:EE_
x-ms-office365-filtering-correlation-id: d5fb9e2a-566c-4663-b75b-08ddd65017e1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S4byTdrLUs8oa3DLA53lwZNk2RA6ha1J+IYfia4DxqBT47GE8bjy4h5mi7KY?=
 =?us-ascii?Q?KL3Vp3NZ1q3947drYkZLzUnaEdWrb8+ddDBMzOV5th5UcCy+wf/Q1ePAodEV?=
 =?us-ascii?Q?D8AJqi0HE8Pg6rtCsDUeVwyyWpNp6Rbh6nlbmu84bE0qpsvUpt3gGnD8LfZo?=
 =?us-ascii?Q?wpyCoaltQdrmuSx4DjTHBZGwoy55iabNC8ZK3QoWc8P7V6H4Mrf9kSSvsmLX?=
 =?us-ascii?Q?xA1eQEALBqn67BrkXTG4jFSvwYhbBjDZn6eneXA7+QwMHY0/Qhnb29F2iHf+?=
 =?us-ascii?Q?AqQW5z2YuuoykkmYjMqFAovmbepwIoX3gf7k4PIIZByzf3J/gJqBU4DRUbte?=
 =?us-ascii?Q?fSApxeeIAzl6BzyxSx4Ko7dT2vOAYFc/Fc6CJZsY/o8fhQ0zb3LAdkZpIe0p?=
 =?us-ascii?Q?CvubUq42H6FyW7o1xntMXX3cnJINbQEkN8Yt9h7nE2dZtrDyxBc3S2RXlAFL?=
 =?us-ascii?Q?lrW8lOZx+uKr3Cx2GP3FVIoyQf+CXNwLx306yH2i2r01eOSXOsEDGPN93457?=
 =?us-ascii?Q?Lst14+vUc+pkEFfUkjUBYJIND+fIHumcTOJZMeh9DtJrYyIGdvVKlee1b8+C?=
 =?us-ascii?Q?E4A3lL3UN/QZKBsCL2HV7SIQgN6UDVbM1rEsiQeXA0xxsLADjkJyaXG/izWC?=
 =?us-ascii?Q?yUN0uD/7AMmynu8ctHAveK+/DfC6nAWhG0Rc9u3qlFyOzGaYuKwUbKhUdg0p?=
 =?us-ascii?Q?n7beD95PHmQDm+nDwk/8JGeXIhJ3d/DtfemuNXvMQ/o6LTgauNrn9fqDCD3D?=
 =?us-ascii?Q?fJFJjONTfVeojtqsXX/rtVXiObm624NRRrLgWwTn0ni/Eu1xXtlmhFuc+Sme?=
 =?us-ascii?Q?7OG8Ib2Lwy//bRQVMIKiN0vJKNb6YXyg9i9e4MmL2S2NDNxKdijSMe17lAC+?=
 =?us-ascii?Q?h8q07ZCuha9+Np3FzoIjjXPkvK1/EfV23fd2f+geuYCYP/tdB/4xj+PSOyli?=
 =?us-ascii?Q?5cuOxsCJz9wOXpMwxldlJQpdAQs6BBwAZcTqRBdydDAA53UqtNo43Wf/41OH?=
 =?us-ascii?Q?0n+wV9AmcWYJMK1BwY/Ev/NP/6ZEHSzPtOYsaSG2E/GmgqZ9kZc03NkcFhD9?=
 =?us-ascii?Q?8/4AGoxdtF3jjx+JCOTubYMv+f7oipn/8zRQngfngO6178pvNVY7ijmT+ux4?=
 =?us-ascii?Q?JFkh/3API9rWnVx3VY6PnmlusSZxUhdEJCHBKhEzj8nqBi2NdTjkHChSPC3m?=
 =?us-ascii?Q?/o8NBq4/vzEwEAAb5cJugDwJ8Wl9VbsJ/4BA079oYSadsz2EkKUl140LLiMs?=
 =?us-ascii?Q?4KFn596t95fsPi+DnVq/3Nq5Zi7xNv2df0hl2i8/f4OPvBNZlWE4bRwu4vNI?=
 =?us-ascii?Q?gtoCXiyE8CguQ/L8EoWOt2lcINRMDZZL3rzVogqzwmAARAx5Ng+rpQ49NzX8?=
 =?us-ascii?Q?F7RuEzdO5btndGUqKWqtLGGNSDuq0HOctHezxlkQAU3itVYikaLPzBoMhYOb?=
 =?us-ascii?Q?kV6mmaILB+9wBzZWqfYnVnT+gWEFEqaO16xk4f9zwell/PGWhf3PwkMO11IB?=
 =?us-ascii?Q?J19+tEaOk9XybA4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M4xBedPo9JT3dJXocCL4GIQzUm+xDc8OEYDdk9mVS3b8A2FqaNOWV5+VVmmC?=
 =?us-ascii?Q?Ap8hwVJD4GH86qFasIXWPis2Bc0zDJX+V6T3u/SB6iOqxxi46ck2R7vMAgte?=
 =?us-ascii?Q?5wY3kidkExsPcxXi/kbcnERVZU2sTs8l6Zo8guxbLB0bS53Z8PFuxGIEznBk?=
 =?us-ascii?Q?6XkTRcKjZI4anC6jEiXcy6Jo0rINcEKnlp/tT7cr93URzXNVAXc+NAQxChfO?=
 =?us-ascii?Q?SDz2JI5izpktH5aw0/W6sgNpK+Vee7ea+tygEcFA4G8XzBq3OSMuHtjBD7ss?=
 =?us-ascii?Q?lpMWsJ7eZnmGl7V+HLGZw07CKGOGklZW0lKaqjL8fSNGXmP2EWr3JcS4bEd4?=
 =?us-ascii?Q?maO2PDK9nF5ySgYX2uT1rAuLJQ1CSbCARGtSX/unMF9Vhhu8HeLjBMougULO?=
 =?us-ascii?Q?FGyeYzXVcL8rsNEoVzZB42MWj0PIQzkINocXGeR9KOxUl7pp/281hYYUn3RX?=
 =?us-ascii?Q?A2VvjOQ2OtX0iZMXLg9wTo5XhXCCveGElNho7Jue5Vv4RmFsPYBWej2IwF9c?=
 =?us-ascii?Q?Jd7Ih0ELNTRdfCQRU2FX/PQ3O0szxEYtvieOZD5v/pf0+hdQKTYnNmYHSdgR?=
 =?us-ascii?Q?+WCYHMz+RsGV8tAbYEq/W6brma3Gn7ZrKiCUcvmyWkRQTQj145LbyPenLZJf?=
 =?us-ascii?Q?JOZrptdU4/thDCx2yacFRfXzbwlbD2ftorggkvqg55JiCjF8NedxIo7Ei1a2?=
 =?us-ascii?Q?As+IADxJaRMuPihy3Vlyj7QzfLl4VTB/spgLLAezJ8Xs9Rsip/0bNBSimDzq?=
 =?us-ascii?Q?ZB5Yc4+TYcq1EG61iZcLSPnJbZ+bU0IRT9hHqEPADrEMn1h5B33QcMJ/G1/Z?=
 =?us-ascii?Q?iiA6PqY9jTX58LHvjJ4D5lqfV9B35ex6n/6aIMc9rd+KbMYxjJldaFvr04cu?=
 =?us-ascii?Q?NKkcmkjbSP2IbDFzx2QjXpr/qEnbutZ5VtLLnUiHEBv8KpFlypzj27jVJWBS?=
 =?us-ascii?Q?YFxBc8j4GBxuyWtM0WkycwMCCEWYQUK2Li35LkGC6vjwtE4A8OTNT4qfFC7+?=
 =?us-ascii?Q?j1ZaPFt4gyGieyOCPo1diiG4pEIUpNEvIc2KNCq05WGliYSLO8is/tv10GLp?=
 =?us-ascii?Q?FhBWGShio+PxS6cTPdKO1Qngmfuq3qIC4gxexFDps4+G9PdmdE4Ppior9QZD?=
 =?us-ascii?Q?S2g326BhIn1kG8mGMxLPYCc+ilEvuAfMhhJA+wiVmuq7FkzMRZ/xVFz0MHCn?=
 =?us-ascii?Q?B3ByerPYk4MYmgmLGxK7ADVsrdP2BR83Z7n3xo0lAbJkjtx74o0W27PfgUwi?=
 =?us-ascii?Q?4zLJ5EF1IJhbh5qA0hAItYYyXJ0r1GnayEbGfSwbpOTmOy9LB0c5bHtdURzb?=
 =?us-ascii?Q?vjFm8IiqSr2YZSWKXPTAHZ4n+GesBhAVJLtIqwKHY1yBwxV04Lu4RP2Grsp7?=
 =?us-ascii?Q?mDPf5Hf//rYLNC1i4i07uMG9VMbybEPoVfm7+RUN1GP5b+x2Ru2gRMOmCG+9?=
 =?us-ascii?Q?VuLpDDcE3z8psY8hLOiqzoB1LT8OEBGEX9SMEBg9Zat86umFSH97wXqqEUn6?=
 =?us-ascii?Q?lgf/0GdpSHL2GGFE5xCtDG8fwgqrkVyvqJ9UzAxyDmyy7bfnwpk0kNBiajP3?=
 =?us-ascii?Q?RULfH0SRiwGZYKT7or80DPXCWLOuK87I1gWeUp6nLy3B/knYhf5yU/HfWqI3?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4882382980C4474DBC4486CE7D7EDC99@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sNdNiwVKbm0X8pLwz0Q3uzWcEwIfmsDGbF64tEqng+sjex66nPjj8uwKg2y3JIzZbdPCGMbOUdWTsNKrfCqiY69AXirWnYnjsxCFEOdY5HLwgGV13jB2WQGcVrkjPWwciOqSdnjyQmpE9Tp84ogJNrE9PjzQX792vlL88pdW2/njY9ES+yMErpV+YVzYKyUyAJ8oviL8J5qu35beIahZUJ+NkcwhYsQAZLFYSrKSQGmy6Oy/1sx8z1+9GySm+QifnGvEy/KTVARLjOtreBJxwBkcCiqk/JlVltwNj79xmNBK72hGjN3ckknlUT8Iq/W5NymhEB4XjBoKLAj2yrMio1f8D4S8bwthVQi5EeTjMkhpVEm0JZjYgBWt93I7oHpiiNNVqrQ3oAofg8jiMZhPlk0yOE9xuSkeBOqRuulW+ki26dV+VdnZitKXHQG75u2zetCqzasQvlA33cROlVY3qnkg53lvO5AGKpdt3+JAQIbQvoEFKQifPGPKKs21pSohT/DE108/loXjmCc1wC1tF3EcJ1ERM1fXLo3/Rv6F0D66MjmQx8TwhvFfD+nvjTMysORGdZVBjIc8njXs3leVhiEvoXfkH3LNA2k8xcvyZ+e8c5exbgHwGE+7M7QIyH+T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fb9e2a-566c-4663-b75b-08ddd65017e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 07:49:24.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E91thAa2DUI1X/l2qoo2WwmJvTTrY76ET2ObTEw+aEHiQeanBA9JOjZmCoNse34rXHFX0r98vIwD+lp3aCcA9UdkwcVGDD3XxM+zMWggKyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8037

On Aug 05, 2025 / 22:47, Nilay Shroff wrote:
> Hi,
>=20
> This patchset replaces the use of a static key in the I/O path (rq_qos_
> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
> is made to eliminate a potential deadlock introduced by the use of static
> keys in the blk-rq-qos infrastructure, as reported by lockdep during
> blktests block/005[1].

...

> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3=
ua4e5vpihoamwg3ui@fq42f5q5t5ic/

Thanks for this effort. I confirmed this series avoids the block/005 failur=
e.
I'm not sure if this fix approach will be agreed upon, but if that is the c=
ase:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
