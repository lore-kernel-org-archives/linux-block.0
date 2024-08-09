Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A6D517
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169815; cv=fail; b=aeNGfloOvdl/LJXxvb5J/vg4icJR/5YCGX6Tsk0yQW4W5+mk0X7MHBY7ymOxUMCggdPQWz/jWo4PgRuQ04ZpmyjUtD9USVnkfQ4CKOf6lZlyuVFhjyvC4aIFIBFrxS3zgJTnZXmHePE7885Bmafs4reucheyrW1eee2KEfn7ymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169815; c=relaxed/simple;
	bh=cPzNNk76iJ16FaGW8SkERjOjJOcwldQSJBhzFyfQVC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQLY7ew1yRomZb7Du1QyYKqLyCpriJcQ2bEeYlLmSv7YWYRNOA1st8y6COn0seMtIJeFVyjz/a5R7c7PWsSIcPM6bMloaHtsw5Yklu78gMBeA4/36LJX6SSfppeghZLKUBTTQRe/dKHAA2WqukCJU0E7pX7l2yucKsw5Cge9wkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kVuByRFA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ndLtLCaR; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kVuByRFA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ndLtLCaR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723169813; x=1754705813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cPzNNk76iJ16FaGW8SkERjOjJOcwldQSJBhzFyfQVC8=;
  b=kVuByRFAUMJ7pwjEr4slyMoP7zrtonICfUXqfmw4H8X3fahSzb8+An9x
   83gC+g1sjvWDyxB4uEEhAidCGphcMUK0Q0fPXo+i3ZE0iiVoJbfDXxD38
   i1MAit4924RFR8ni8vygrYuDb5AcHHRpjhStjjosqxKO2GE+PRezXditK
   RNBiVhJAQUM8BLq2IF48JDEfhurb+iVPIVbxGYdF/AlqKp2/SslyGpu50
   ZadfXbac8ivzWsD3evfwfR/yCVFgoaQzT5jVjHiAaZSfy2Fl+9wSkb2Wk
   VqZ/dLnvWC7fz8DDRoYnrqp7i9LkccBebAjkhY86z5P9YpfoZPOUD+HjB
   g==;
X-CSE-ConnectionGUID: B9vqsSthSQe9KnHl0JLaKA==
X-CSE-MsgGUID: iBFcXGIkTsmdSBhpp/gQ8g==
X-IronPort-AV: E=Sophos;i="6.09,274,1716220800"; 
   d="scan'208";a="24544797"
Received: from mail-westusazlp17012032.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.32])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2024 10:16:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEeF2CxQS8dVF1bUXfKdNs5Rs1HVXGC8jsTsbS2eZ5QG0LrqtOLUn1BxBTRILCGOgc8etTvqXczngGgGfc32QYTKP1DYpWntN09fKWK1CMUs3s4phr6+tCbKQNAaMyiTQQ1LFfF2VPlwn7zMIQjRFHGeFw1tINrOv6RfHK98MfUtYX1wS4wR0hNMc8fKqldkgzC5JrE9LthU140+HBDbuP+7um/OI0dRCHUP+aLSuhrrxSWDqjqFBPrBd6mERfvvBF2J0K1vUgavQEVLmC94eAIHZnk/AM18eYI2Um5dfj/mlMj90Fkj7k9Aias1GwkRamK6kPbihrtg+NqhURs1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPzNNk76iJ16FaGW8SkERjOjJOcwldQSJBhzFyfQVC8=;
 b=rrsG3tf9L0TUdxUpxB0Qli+p3a6KYaEqwpw0iOKl0UCxtwj2sGPvTN72L8LYeeA86aJP+CtFjvlXM4boH9hfMmbt5dABnycmorBp0HFrodxKvB7Z9JSNop48ujG746nzPNN4Tonq994ucbFDCH7HiFNMPRNNXnRGGhkwyTigoNYJpWLzlxEraYxR7T6OcwfsFxYIbgc4gudfR4UciKTzRhovLMh3gnoT+3VCBRMsIalzJfwkx2Jt1F2Oa3XqpSU1ZUZTQrxJ2PWP8lMMPh8SRBxKgM8C4ed88lUZaMtooiS/vRRLg7bVZ1Q1Z57r+4W9XUfQ4Z4Dpmg0maJ5/muJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPzNNk76iJ16FaGW8SkERjOjJOcwldQSJBhzFyfQVC8=;
 b=ndLtLCaR1JkyRiar9C1st/cDIgnCvfOfRR1u/sLtOHMVutaTweFVIf8C21ZvJ/ZUCVvO9MO3xtTM4GgYbn0X89b4KDlub0A7ypBxjFJzTvV93L6bwCXzWWcscH4KjMm7QBnyQWB+nZ8Vw+i8ibMC7Js9/hfnYpoWuz0GCyhUoFQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH7PR04MB9641.namprd04.prod.outlook.com (2603:10b6:610:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 02:16:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 02:16:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chrubis@suse.cz" <chrubis@suse.cz>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv3 blktests] loop/011: skip if running on kernel older than
 v6.9.11
Thread-Topic: [PATCHv3 blktests] loop/011: skip if running on kernel older
 than v6.9.11
Thread-Index: AQHa5J3EiqeojlUa80WOOSs+2bhW0bIeOxCA
Date: Fri, 9 Aug 2024 02:16:31 +0000
Message-ID: <mp2msbbaf6wt3mkfq34gtdaac5bsgglopcvs2ivfccdo5n7az3@hkjkeheclh3c>
References: <20240802053421.1350297-1-nilay@linux.ibm.com>
In-Reply-To: <20240802053421.1350297-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH7PR04MB9641:EE_
x-ms-office365-filtering-correlation-id: 1e43f602-a594-4cbb-0921-08dcb81948ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dXfaTKXoBgp1ZseOvn023WN8h/4jHnNcWXHTVvBorHvecANTL4D6Po7lBAmb?=
 =?us-ascii?Q?YA7VibaNt6v4beIIIZCy7DmI1xFQGDz7vLAqXGMS1nlcSdXBs0XJCrUTWFJf?=
 =?us-ascii?Q?koAQNddLxKvFxCJr14IQaeSVKWMBdsh+OEVquz+xSzpwGVf5PX7fmfpdEmmx?=
 =?us-ascii?Q?mygCO2PMqZQ00D7TwLgZBWk3EloMxWN9wSuTLUC8npK95halU+AjsO/KvOu1?=
 =?us-ascii?Q?qZNELj/OWHjsF5CkArOGxM2/LpdxERs5YSWTqOg92zQsuEb2Gs9KTjKgGmC3?=
 =?us-ascii?Q?eg42ihnaWZrDpVGaupTePBcL6bwCmOK1LRI0GDo2XFVsVBahNscYgnB8STCe?=
 =?us-ascii?Q?em3sPE7e4917f/rldFTLTjCGV1hk61xGpUW6dbhiiNB0uuX5b0dUjSoTw2sT?=
 =?us-ascii?Q?twVVrW8Wjn8oZ6LkFtqHPPclZYEkNE6xztD2/Bh6uo05OXrpIt73A19GAfFn?=
 =?us-ascii?Q?glqO2GY8znFqG3WC9i8XzUcY//NqICc6xaSXxDvkyxMx++YKSklqim9d/lnC?=
 =?us-ascii?Q?lxO78ftBZ6SjfCd9i8xYg504eTK+Y25hQKkqI3kH4LsQwVr2/atzchTSOc7L?=
 =?us-ascii?Q?4gBQv/lhJegNiccp7HYGbpklrZRGBlLgSJASfChothdLSuQkQYU5CS0R7qGg?=
 =?us-ascii?Q?/aElaojW6CBC0izDAon5wJgD5EklbQhRhARosidEeP9yRQVqmhAWB3nPXdPv?=
 =?us-ascii?Q?+uFskymDKpwXOqOE5kwlOl10prI64F2k+RSiuWs+oIPhFsq4vmfzU5jW+32V?=
 =?us-ascii?Q?8wfHd3Ap6WvITlotUion5U20JqogTRtIr7PlPelUS5u+XaOu+4yq/e3o4/dY?=
 =?us-ascii?Q?Pxalc7z8AmK5hxFfXgRsjHSI1k3qTZ2t3JQtX9f7DKiHCJ/ol3NjvBuMYW8V?=
 =?us-ascii?Q?+8chaCXJfWYLTV4fr1rpNn/YBFbUZTV3kMTcoU4iK/GEPyLOExivInqELZrE?=
 =?us-ascii?Q?KvDCSu4YZAJLLpPjsjGQf61Cgzk8d8pEghx+DHp2b0fB+R329+zeKzePOHRz?=
 =?us-ascii?Q?ZRtlesqUN/n6Jc5xH4c0obSeHPBHlpAcm87WFzTD5FYULGS2RPgzW6P2johl?=
 =?us-ascii?Q?4PAW4uZ3mjGjDsmkhyQ7LJc7WT3el8WuYg9trAJcCSMmbBBXAys7V4lRqEwN?=
 =?us-ascii?Q?86VtoGkTZhlOsA7kztUOhY7YDFSnhTZczq3N746guneyNp3y5fVJhKCDxtc6?=
 =?us-ascii?Q?U/AoLwrD/xNK7QE8u6zs2+e+5GVUaBApwLAtcMDYogz2Z6NoadVk2b/RusxD?=
 =?us-ascii?Q?SPwuY+o2vluf9zuSID+uCu2DbpfCXkEWjPlv+l/YRTNhr8A6Cc72UIoiL76q?=
 =?us-ascii?Q?CGTUGZKMY27LVALLkcrC+KnvvcWUnz/dLtu3nmOvY7fAQjJ8QBFX/3KrPN4G?=
 =?us-ascii?Q?576p+WU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ykx2pfGcS8ojiNtDTVr0BF0CRlotjtPFD+tZxUASnqLtHrmkRO9z1me4Eo4L?=
 =?us-ascii?Q?16UY2YH/QXDC5ui7LdeYM/DmZ2J/Qr1XNxUFMWGiqtMUzDEYuaYpAPYhhOD9?=
 =?us-ascii?Q?xCZTK7pjq7A0I/7AxfpGoab2OBD9FTxE5UIaOBXUlkgSAeoyJcqiHurmpPX2?=
 =?us-ascii?Q?1VHUu6Ndg6RhDzCPm2KHgWi41lEGG66wf0D64F/Is5avReBcYcCCF/N8nBKU?=
 =?us-ascii?Q?W6syxeAimCjamF/jdbd9wNi/TyjiwZMqj5LsHmzRtw2/gGAx+GG/SP1rKhnW?=
 =?us-ascii?Q?gK2hESaMEfBJyQ+T/gkhFC57afJova9ONRwPkANu/6ZRpjio/dtJcphGkFhz?=
 =?us-ascii?Q?j4/tmMJWyX7FRlR0R537BJZugLhsvJqJe6e9C52naVNaWZ/y63yp5LIazLuW?=
 =?us-ascii?Q?qN496oj/B6oIV7tdNiiLMd9YzkPIpC8IVnpc8EhDnyTy25os2sia8yQ/IU3I?=
 =?us-ascii?Q?uixUYmyk1na682CriTNt8e4ai/6H12frJ6NVfHO5ly4wpaJkjoYL2+3MRi1r?=
 =?us-ascii?Q?cI+lnrSNi1UW2aJgnAUEA/Vvhj+bdApo3Xfb4mz71x+Za7MrHWpMEm9j18/G?=
 =?us-ascii?Q?ukV+3iMlSsU9EqoJXSU7LOb21/VHIzFVkzz3B7Iua3xWnPNsMPoc/UHqNHD1?=
 =?us-ascii?Q?lvMnY88NgJ70QJGJR4HbEWsf4PzC0QdG02J7DwzDsr99vVFQt9r+kcfX10mz?=
 =?us-ascii?Q?PPVyHbpx/mhGba4pBhXVbvt5YGWV1CV0KKTowhOyCyjwAQJz5awxeoTwV68m?=
 =?us-ascii?Q?HMWuozY8HIBzFZMeBxeuAa/iWklcQDget+1cag7kE3Qp/Z17MNikexsejhcz?=
 =?us-ascii?Q?i8pjCTh9qtG5JZK/0O0RpKUw3TAKaI5dctHAHmYf9TwaJBRXK0jBMXd7vf8y?=
 =?us-ascii?Q?M9FGFq31j7sqxLgcEPuSaUGnTJjm9qw50Ms4L6Mvi4hwfBos5rqVSWTcn4Fj?=
 =?us-ascii?Q?A4+vjiO6o2nxsDVRpFv0EQQ2epfGmehR8mBLtF2cgQcyiTPSdyhStmoPZK+7?=
 =?us-ascii?Q?CIA7kF4jbrqGrCSd7V5sds5smG3E6pmcMXh03C0/Zmwi68hNV5/GoTywq8+A?=
 =?us-ascii?Q?klW2USQfGdGhrt2+roIeZHd/cRQFTVO/ZSdn6/FVjtdJxFCfwNw/5Pfvj68c?=
 =?us-ascii?Q?cnHY61N9gGE/1lccfkO6Z+ODEFunHQGzxk5qc2WJBVoLXpzo6sjw3eu8Nll2?=
 =?us-ascii?Q?Mdr5d/CyGh5fgpDqhW7qQTZ7T09a5K+vhDk0hQN3MoG+EqrfRgfiG69ulqEE?=
 =?us-ascii?Q?zC/dKLRoY9gSBJU8SEit+2lEVmkUpBrpAIjTXYQdSbaD/mrPyf1GN51D5iJQ?=
 =?us-ascii?Q?dd7rkwlTiGEudgzFDUt/FSlihVm0AXyGe7pTkdv+H2f5qCLylfgiGmlU6QyY?=
 =?us-ascii?Q?n5L2YX587zi61IQDpaleA0rwq3i4YwdrZHJEEaQoERnQKFP2f1c1lAEC8rJx?=
 =?us-ascii?Q?38R67xjp8WUlqUjBEIBESuaMb1g5KYmu50TwVQXCtOGfZ+7aDqG0W6ZKBDlf?=
 =?us-ascii?Q?LYFPE4u3u5+MWkyH7VaIf1M3XBnUUm+N7gWDXn/YjRvz3W66K0i13mi7uBov?=
 =?us-ascii?Q?M04jSFbg2qA0QBC58ijlCrgHNWOoUgqfCW+TzY+3O20WjE44reYf1j2qCIky?=
 =?us-ascii?Q?WVpPfmzgGo2fWRbVHdox2n4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <422CF8D8A6FEB048A4C5215A7DBA4DA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tFEdhZO1MB8Q2xRcAOGv2OBPqwi1cj/GWxNgWN3DTj+DF/TMyHW9q3kmmbo9gSq5RkXv+d2iDemI6pJ8RdqjM4l+GEVPtEpNqM94720MUqiZngeYPKTobHvRQXvecGMN2t30pWJYlxDaatZBUB8KoXZsZW4yY6JQUWjScUQz11fsLG15R6vxOxCBi2JvfJuWUNVc5/Q/Brhn+jRogJlQgNUs/fBvIGQJpWVR7s3ZCBqBrEFk1nrJrclNOvnUFdzlcvCL/nqXMbZ9Qpbss/3Omcl23pna0XETZNtrB6fHZ5/fbmQUuLCWgswKRhWP9VH3YX2uNnQ0+AQuepn3i3Z+jIDLSooVPKfWu+gbSPLtH8S9cwxFJhwiVuW25udt6zpUo8itKw+9P2SYH14O6DPBnFdPI6ZbcFr/E+W9fUoFF0r4ab4y/gIRPsfHwqhzyUNaNNSa/d5BtXpcHiWXIJmxrpdB9a41sPMgPexYOkOkpNt1ljX5O8G8RwrKgiezBGxcXpC7a+ogLu7Ti78Nh2+cbWIdGFgwdqRWZKTzZcOzc7NGeLy9wwEIwPpsc1OZx3YOIP5JBrUrkQ1fAI2x8im5XKjU1wx/aI9CssrlRF/O5jbJW+Jdm5nK+/xBbeedcemz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e43f602-a594-4cbb-0921-08dcb81948ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 02:16:31.7741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ca6a7VT2ZY9eLoeMdCOELvjvvk5kPmhCbFg1RuSgyFKKREMXQVoacxdQI60gxE0yUAMkgOvGcpRIIhSFHMTgEH5PNjKdXHue1O54Hss2mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9641

On Aug 02, 2024 / 11:04, Nilay Shroff wrote:
> The loop/011 is regression test for commit 5f75e081ab5c ("loop: Disable
> fallocate() zero and discard if not supported") which requires minimum
> kernel version 6.9.11. So running this test on kernel version older than
> v6.9.11 would FAIL. This patch ensures that we skip running loop/011 if
> kernel version is older than v6.9.11.
>=20
> Link: https://lore.kernel.org/all/20240731111804.1161524-1-nilay@linux.ib=
m.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I have applied the patch. Thanks!=
