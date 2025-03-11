Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67A1DEFC6
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662187; cv=fail; b=a/qoP0sTeY7H4M37OjVNy8nVIpGV1a54BWRZCdnPEsCq5uEcTGc8QO6nWnXpJsUN1TNkgYkjF0LtzuHmyy22Gfx6EhfIlo0GEdEjv3UVGLN8xfnqDvd2gcsafelYrLum8Dw9L4gxtlN0Xke2xG5TrIdoelLp3gPS7NaSWNJj3PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662187; c=relaxed/simple;
	bh=2YG11svB1+rJzSyw3a/EITmnRWiJlpYS65VSHyNq2NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N3SwLm3ttlXwXIYgAeMaoS0Spof4QBtYB0y9Gw66BlzDxPwcQYFdY42zsr61tyvKCWThjWh0uMSZQw8eciw8Q7keZttjqR7+4wEwofT8ULri/cC2IdsizOV7UmJ9C7kvtDhArCSARCM8hO8VeY30PiXBZTa1ZkxAt5X/0EkkmOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ruVWBp0g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qcWvaF2a; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ruVWBp0g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qcWvaF2a"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741662185; x=1773198185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2YG11svB1+rJzSyw3a/EITmnRWiJlpYS65VSHyNq2NY=;
  b=ruVWBp0gTM4QbIH8ayXwCXBqnh7anDZ4EOuzDtIrObSqgKLa9WXacsk5
   6Qb47j4rWaAx6P6QJljaMTEmTFZhSPhVYZeAQoHwRn2N0QNx563trYFEm
   6rHUYxC2e4PJIQnkz5fi4zfXNtYju7QZFa0AJVZ+Bxfj2fr2m8OVy8iAp
   EYySs/JXb/8wzL27VZXs1zgFWaEa32lKD+M+zTj0twqQvbV1WUzPy/3GR
   neZZMm6lUqVpN28ALdyiG+01CtE1Hr7WI7qwsKEW3YcUbsM5OWH2qI2G5
   Xin4PAe7j8/eOHad7lrk3MtqIMZaFv9YEqBDUSJHt4/mgp5ddYQ79s6CO
   g==;
X-CSE-ConnectionGUID: zfUNLOWQQqWBn8UEOWXo6w==
X-CSE-MsgGUID: 9Av7otCCRfyPuNgI3zoG5A==
X-IronPort-AV: E=Sophos;i="6.14,237,1736784000"; 
   d="scan'208";a="46838594"
Received: from mail-northcentralusazlp17012053.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.53])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 11:03:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeeMGjgtds3n1G4+zWuXEA2K3OGpJx6hoYcbBjt71RThmKyW2YH30FrZEs+QEQ0GdEvchrHcK8TzIZtpPfE+U0HqSPpGgvom/Vih/b6IQH/AeWkh1zOHxgU1EBbQbHJaGHk6A8fyMWpDPpZfCkzSnDZeCozKzlYUdWZCpSV2Kx96LnC5eS2GAq68lTPVQg9nYYkbomWR/7gKS4lIDFV/EKQOz80SW7lY034zqQAfkkuegjRFIhmhBQog/DP/LFG4QpEwQjxZWYK1JzUImeq/cCo+gAWomRPvBs1doBk4ogM8ofAIFJ3wOOhpb1qFEz43XKDRvTKtuowhNp4rIdX8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YG11svB1+rJzSyw3a/EITmnRWiJlpYS65VSHyNq2NY=;
 b=Cs94W/TuEU3qyfdkP7/eW5FWyYCZfGQdE3AoS+DQKZzKMCS8z+eJHjxOxat6HnsDA30wszG+LhbGpVioya05FQr/DaZIlb8TS/kM3MdZFmKoHvz6EMyZRHreijFK1oYKED9RZ9WyxB3RDrs/ciLBNauMsMn8JA2/JcBH7xbA+iEeQVbmo25HioLQ2lCR/jJrEkjI3Mgh3Eh1z5u49TvURUXuCKtMKj/XVHM1dJpHYgdquBBZoocER93kLcuhHkQn21/YbE8JPSglDiG3v00aXBT2JsgORVgzqvf2lBKGbovQK2Ou0okfYCbinl1rJdOhZuMKt/Hl1ED60lACtAxp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YG11svB1+rJzSyw3a/EITmnRWiJlpYS65VSHyNq2NY=;
 b=qcWvaF2anToCCcfezPXI35EqVC2WpylWDsHtRaQNbS96YmGLH8sBBxImAO9j7LI5knKNQ0s9BBOQxDGEPhMrMaLNKG4nm/FeWiEJcwYmetGHuI/qnSpr+ZxiRGWfN9p4C7IWRsIeHKtKXoE23YQTatgEpEN9sNw0tPpJ52IFZ3c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8470.namprd04.prod.outlook.com (2603:10b6:a03:4d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:03:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:03:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Milan Broz <gmazyland@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Ondrej Kozina <okozina@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Alan Adamson
	<alan.adamson@oracle.com>
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
Thread-Topic: [PATCH] block: cleanup and fix batch completion adding
 conditions
Thread-Index: AQHbkjIZxXMtnOmsDUuYlfs8n/vnWg==
Date: Tue, 11 Mar 2025 03:03:02 +0000
Message-ID: <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
 <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
 <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
In-Reply-To: <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8470:EE_
x-ms-office365-filtering-correlation-id: 59d6db24-8582-4526-84e6-08dd60493cf4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q7GSynpudNWj1pWtjpNsZ1+/dZmYI2PIeOasUpngLuGS526Pd0ycktLTi5n6?=
 =?us-ascii?Q?6Cw8BtGRZu7Dy+lhhiz3nQ7KgOF54AEF+NC0/suGqpSL3BQ0Phe3IBWBowoi?=
 =?us-ascii?Q?d15iUgJ/HNYW63R9TGdqbabHxB+Y19wJTGTrkSULYvcpw18bInDHOgSHYZ6A?=
 =?us-ascii?Q?/WSLuWHpPv8tczQy4wp9S2U8PPrhXDXgJrzrd0YplS6xKc+Iykyurz6R0uHl?=
 =?us-ascii?Q?GYLsK7wP+hSVdq3qGdKzC8KLngKxMJof0DNm4NNm/OytPFgQjxfgTiIYrNtP?=
 =?us-ascii?Q?qy+3+lDxPCu8EOLphVt24hnQ1/XTgvNEg6+pS5Tyk9reO53kYWHZBq7qhmld?=
 =?us-ascii?Q?7WO1lztqBF0xMpPqePKwdQMtkiXgRsPAAlg1qBznaUzGjK2KCZdbyTt2yIAx?=
 =?us-ascii?Q?QBBIAAdXR3AdLu7SzDI0T0zauNbQVVFGRqqcK09+wUH8C4+a8o08avakH06m?=
 =?us-ascii?Q?5/WCCBD8ilNdmEc3c8HMycE3c3B2UWttz0e/hinomyb0Etof6+XhGm46kWS+?=
 =?us-ascii?Q?kiK6ppOgEJv4eywpwr56tdJzTrf6c1hCNcODk2FgUN/UPnELfMthbFk56s1M?=
 =?us-ascii?Q?/kfwp8dZNGnscN3qFGPC2yt5Ucnpl+6uyt7hMxkShf/rPr14prQpa/tIXgQJ?=
 =?us-ascii?Q?IvRu9Wi/kMdNrzlEaCfzcwvzPLrNAV/bP2viPwrbCQIj1xARJRI7cFjzDiCX?=
 =?us-ascii?Q?ou8a5asCJK0nL/Qa+9k43EVtCKeUIfrDvWOcqJVdv9+7ajyJ31PJeqGr/CXB?=
 =?us-ascii?Q?EpA/x58n7V8vhTNmi8+hNRhQprnDp8yi+zgwiz6R70oEnpCzABeEg0mqyuec?=
 =?us-ascii?Q?jFC0k81Ra1kzEvMlwPrDSoqf+qNNFH/T+p+XaWxcFXAkqguIBBD+l+cb8tJC?=
 =?us-ascii?Q?RCbBlFtdvG3E+7NQcCCd68yxh4FtXmMbYRx+BQkAkJ0ym/OOfORg/i/W5N83?=
 =?us-ascii?Q?0NJIjBw+CdexkjEACaUxoOdr1nq2JBOjrfSuFtThP1JAO9iXwLHw0eW8QhzL?=
 =?us-ascii?Q?WkmC+4gC9nekpcmR5GmE5Zq3/s0OqYL6qO72IlyerQJsGAdGcLLouNsIKxgA?=
 =?us-ascii?Q?ghXdNwH8tplXBm3wDwlG2EpHYsWpWu4M4qj7KiQsTV7MjVl5Qe6eeZZ9pJaV?=
 =?us-ascii?Q?JRbOQgL8MX5ftgTutOFAUfKaiauLHj3EhKgZqtNdk+mz9y4/njrfw/Hut5zS?=
 =?us-ascii?Q?cDcVf+41t1WCHcj7ROVr6FkaCPRg9B+L/nbYQn1LJ+z7PL3muAqbVv8CL5xA?=
 =?us-ascii?Q?na3MCOclXlJaayxbNJbhC4rSCOinrNPnL0HQGkns3ihFturXKODGC2Iv0Y3U?=
 =?us-ascii?Q?B4qaitHm/UJvROsl9gaiRdVqmTI42fKVTuFhX1oB1cRjvZ1AWMek7Er2WaG9?=
 =?us-ascii?Q?yEj0C9kslm9lkGkPLU5+ycqGHsmmb/YZ7RElhSxcSl16hyf3oxUQoXd3OPDe?=
 =?us-ascii?Q?LxGFZJK86ag9kVUSp9vKxI3YbM2QN0rc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G5+zAQJgjY/YGTxeQHW4qYctowdP2+dsl/OhaJESr6MOfUiqDHaruSr5eVX+?=
 =?us-ascii?Q?N6KoGg1IsrCb9zr1AoKDMHifHfM5vYlrD/FS2lmRlA04vVgp27FzT163I9wW?=
 =?us-ascii?Q?M+CgidTtAuqkUrOuoGIcEaNsB6dskGs1GdW6mRYjd3B14EBnxkvS53M6/5ae?=
 =?us-ascii?Q?ma+ipMAlBh2StwvWPm94G15Tnd5PNEytA0pchuTOSpZ02IPdeaaL6uI1gYMx?=
 =?us-ascii?Q?EirNM4Icx7CUG41cZmboaX0Lb+96Zanvh0LbCr2sjSQyaGlWBEnpFU1rbPPn?=
 =?us-ascii?Q?mXwne1IV4tUZmZH/x5wwTh5oY7lTz+HF8poUWaMhJSzJWPsqoq9jKBMGpEIl?=
 =?us-ascii?Q?pg9GmAq9mNj0n9mTGrNk/QgLA4y/jSdoRiRI/TvI8lUX1MfFewOsY0nmrlc5?=
 =?us-ascii?Q?uGCXr1uAGKPneDwrfBoYQ9VBAcro0dpb4fBygt1J6/tYjyyG7D6B7KM+qVWH?=
 =?us-ascii?Q?0HkMsJBkWASSbpVaQGBhYbWW2zfi7cRtbRxyUOyw94g7ZAMYxGrcOn9RtReW?=
 =?us-ascii?Q?nphzUzB5Vxml5/hJGt+YRKeeOZZoupBHmtcVLv+uhJUzu3XtHlAAHZPJxDyj?=
 =?us-ascii?Q?QVncgAfxaQ157Ft1rz2fV1fP5QGbrNX4f2SZqDtA+ek+65H50y/yQdiNG5nt?=
 =?us-ascii?Q?9tV4HOCLpfD9T8Tn+GOU8n0JTHogUgOsch15KwtukRTlYlcl6SXGipjuFgJh?=
 =?us-ascii?Q?w6c+x1NCu7E/jXO85pIQfpyiKH8mBEPVxi7dpScGpwcOqOIsvHw3r29oBDVz?=
 =?us-ascii?Q?SmCpFRd99vCFMCNL3a1wXAsX2XQgsRxLtC6fITPCMtTKzd6wX0moXxRaLZyw?=
 =?us-ascii?Q?IqSENAr5exs5q1O52jBZ7dGG2G/APVJdxnUZnETvVkSQTwNkpbHfJa1Mv1G8?=
 =?us-ascii?Q?CR7HTM2i1MwVsju6+j4cPVKR3fF0Ly1uIXBkG20/oofCEWCIQ2tm7RPP2znm?=
 =?us-ascii?Q?CFf53kd6OXDP9jftgjKkqpCUhygaWzvlxjm29F2HobiJq/sS+pyIXYod2VoR?=
 =?us-ascii?Q?VLGd9L+VWgyQwju5K4Hda/AKDJsw2b4HirkhvFLe9YKbWArnfybU+J8jJj9s?=
 =?us-ascii?Q?dQSP1f9ciOJJij1VShobYtz/VCeP31+R0We57nX0U144eGfg4p3z7e3dtkMm?=
 =?us-ascii?Q?Wsowy+mpBz/pDnnqTxHo5P7ltxkzlmJateuedTfamE8VhUmXEHvJqyEmamNp?=
 =?us-ascii?Q?SrAusJMuO/TKFazsNrXa1OLkbKj3gIzsQ/+kDTObXp5Plk09eUkPE/U1UKuy?=
 =?us-ascii?Q?uAacsZEa+5q+FTXoQGd9Iiv3R8Y8y41LgcPeP5NKIb5Bh8LBZNW++85WYl0h?=
 =?us-ascii?Q?2l7tZY2knNHx9/tFnLoR3AcQGeMCFSQJZcK5KVPtF/A6tU3r/Ni1cdQQxTtJ?=
 =?us-ascii?Q?CpeiuNFBzLgtoc1ljAAyWGMNTUcfkHWxWDnTlyJlomVtbPX8OSGanpC9sUSE?=
 =?us-ascii?Q?tZaAyUIZCwE+BKbcS5+vHVV3U0lraPJLhs77LHjqEhBmpYAkMBgM33R2kPI3?=
 =?us-ascii?Q?qG3mOMUKuMv915V5VNNSVbUVuv3GIAwXoHxjsE+PvNvILsWvFuUZQtT6vILd?=
 =?us-ascii?Q?4jUTYUUcaEnKopV/qNwshOCeSVgcsGcIu9xKrszjRF6iIUouinOCd8Tgk00Q?=
 =?us-ascii?Q?O9H2jaregAQMGeskceCnWo4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3EC15BB00E9C34F92FBE93776D7488A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	93dL7sqUl1xmu9DYE7C5/Xas861UIsxFzANYD8xvLFzj4fryY35fW/IuFZyu9ErD30ULEdNYwCxv6Rq2qkj7agaiea5ygQxS6CUIOxzNKx40qHBrDcjsayvrtWbVVDrPcXUiR6SYgRxdlr1k6xM/SAGNx6k+hHENRdQZY9faedx3RzVhWCh4AUUs9VxAbKLpw1l0YmQ2YywE9HzvkwgTZQoqkr29nVOs5iVdAJ9v8UhX1uGloLAGgd0AFMvPTo/PaXku+ziYs0N9KnmEMU9o5f79Vd5jg/9M6z3rUAgkaYuRLN7C8XPTz+if8UPVCJwcULNM7tL/c6uTgY/6ExOULX2aMd3Jx/Ryxlshy8fmS9IH6LiA7hMQFHmg331d8bYjVmTz9KTZYm/nZIisAuGzIWyrWXJDq57xgM4d+fr0q1sJCsHiYxI7g7z+NzvWWclHYA8880CjFnVPs7gS1F6QPX/hQ61pFCW0J0NvrQfgZiyMfPTVyi4kyNS7G/RUe14MPdIHSWRqWNtuOd6KcJH3lYftcFXJhaumjMq4nc8dD740+nKaGYUJsIBNcw4CWSRguUGMkQUwJVDCF/61mVeU4+SOQ/eb5gECX7cKEDrEnzDeaeDNdRQh8Xb4dqIiPMOV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d6db24-8582-4526-84e6-08dd60493cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 03:03:02.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K5DHcQp7uozrj4btCjFrd5nkBroiPIBwTWHCJGCt8+CAjWSMYRdihvdKKR7LL1NWGa5gajXKtlMlkleISIN4sAtExVtJjwILX8cQFNgfEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8470

On Mar 04, 2025 / 10:25, Milan Broz wrote:
> On 2/28/25 3:32 PM, Ondrej Kozina wrote:
> > On 28/02/2025 15:08, Jens Axboe wrote:
> > > On 2/28/25 4:59 AM, Ondrej Kozina wrote:
> > > > Hi Jens,
> > > >=20
> > > > this patch introduced regression to locked SED OPAL2 devices. The l=
ocked region no longer returns -EIO upon IO. On read the caller receives bl=
ock of zeroes, on write it does not report any error either. In both cases,=
 previous to this patch, the caller would get IO error (expected) with lock=
ed device.
> > > >=20
> > > > It was discovered by cryptsetup testsuite specifically https://gitl=
ab.com/cryptsetup/cryptsetup/-/blob/main/tests/compat-test-opal
> > > >=20
> > > > I've attached a simple patch that changes the ioerror condition and=
 it fixed the problem with SED OPAL2 devices for me.
> > > >=20
> > > > #regzbot introduced: 1f47ed294a2bd577d5ae43e6e28e1c9a3be4a833
> > >=20
> > > Oops thanks - does someone want to send a "real" patch with commit me=
ssage
> > > etc, or do you just want me to queue something up?
> > >=20
> >=20
> > To be honest, my patch was just a quick hack and I'm not sure if it is
> > the correct one in general. But I will test (and report) a fix when it
> > lands here.
>=20
> Hi Jens,
>=20
> do you have some fix for this issue anywhere?
>=20
> We can easily test the patch (at least for Opal) as our CI is currently
> completely red because of this issue :)
> Thanks,
> Milan
>=20

I created fix candidate patches to address the blktests nvme/039 failure [1=
].
This may work for the failures Ondrej and Milan observe too, hopefully.

Jens, Alan, could you take a look in the patches and see if they make sense=
?

[1] https://lkml.kernel.org/linux-block/20250311024144.1762333-1-shinichiro=
.kawasaki@wdc.com/=
