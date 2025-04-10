Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598771E230E
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270726; cv=fail; b=sQtc7r1Z3hLT+JT7zgTmWSqIKZqcbcBzukMPNg6JkzYq1Ka6O5SAJMLr5nBtrc4isp+v0iAqQ6KhUYgVVNwKApAs9hfeojmeBXKLyJBCXhPVc8hZnyuBrhcx1tSLotT6ufdFAMPb/08pfsZ0qwIQ4s9LzZjH9NWd9uMdNaZo/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270726; c=relaxed/simple;
	bh=r9q94k16nN0wr7xi+/6DKnaRJe9R5WEX0+riOZPZ7QU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZDE7DZJLB4m7+E/MUMdbzasl6lZC/SdpNEzvP6uSli8Jmp9DKndPfoaMXHKVw8vIAfS2mwYRDoYeT1AJQasphIiZwoAleXyz/1DACIPcgyFxvcyyusb0yR4sQBVpyCtxE4MRYUp10DuyGsP7Zkp26bboeAdXMqmetDrz4M7Hao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GCTTlfm5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=THM1tomM; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GCTTlfm5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="THM1tomM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744270723; x=1775806723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r9q94k16nN0wr7xi+/6DKnaRJe9R5WEX0+riOZPZ7QU=;
  b=GCTTlfm5VUmAnqMs4VDHIZUsdZe2kI+FWwKrkbK7VcdJeWXVYZVyPPrU
   0QG38361nE4oEfQIUa6ZbkD4jLrIFCEpMaIokV5NCYLW109mEmU57wqGZ
   285rT+3ddu8wy5gmKrjPV7sWUEL9dsgWdZKT0jRJ6ktxzqfiSMcmXxFDn
   QTFwmekw3KjMJ88f6rWKW50L4sF9ONwb/hxhlpYFuvcYaTwHyFJ21E7z4
   jBjDNxWJ9OYmC/4VALTMH9GWHD5AEXXHSkFC6hPyJ9dqGX+fbdFZp3H4s
   b6/YuKp90DFFUQ4vzEHi/gYZdeRAOATAlm/aVHe+FYatIk2kxZMpH/xUj
   Q==;
X-CSE-ConnectionGUID: /TJksrf0RAqQz+N3jJcOHA==
X-CSE-MsgGUID: FhbYGTmfR+ujRfcpXN7LMA==
X-IronPort-AV: E=Sophos;i="6.15,202,1739808000"; 
   d="scan'208";a="75744279"
Received: from mail-westcentralusazlp17012037.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.37])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2025 15:38:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqr9ArC7ISm+huuQOiOjB+xzphVorj4mu+YMZ2HGC4FpuGeBWgllRf5Zx6hkMzCpq3ZtBLTu3UQHlc2/038ar7uzt0TikFemEDup+PaJRzsI04wondHPnHQfm7hPIGE2ZI5BLyLrOzT0bBHMWk8Y1ZQk4VhOgsSLlMez14XKgY24SMeMXMLdPquR/hLevbyNTW+sqSEwDEVJTxw/UO0BkxuxhvrvqZhHRzOeMwWBpFa4G87P+MRqYaFTVZ2hkI/BXO0wlUtAAoitQwAQP0dCKmEUkWnkDk8qChHXRxFj8B+a4DLSsVvpORglgCcvFzikA9QdLRDoVU9Kvs4g6etunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWw3pS9hDfknCFovT2Khqrmk3AzuLysMy2eQMiDbDp8=;
 b=giOtHyBpPAhkE+hm/KjuXBlqvscWNioGl/TyRmdItod6iNCq3iR5KeZkrdVif37D0mL1r/osn09D0mDdrttKSrkgMOqWT1FrVX/gVtVmqAUk+Q1G5CIdgYpkD7bWOyDZdI5vOr7NE4Nr3kb/O7YMYpsmPNh4Hhi+E954p2M/48pgfR8Zu3NIQo8148l8AB8pMVUPXHw6pIDfUEDb1ofKKKlJf867/4V+XT7beaPpPcED0bCm9bcoTXxmVmt+lGyQ8G8QT8lfTiuoBqYzAQAtWGmVCuT20aXytb6mjEcNBYzHu2NNQ4lUMettmMJ0hGdAiF7iVrN/U7AguYINYSqxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWw3pS9hDfknCFovT2Khqrmk3AzuLysMy2eQMiDbDp8=;
 b=THM1tomMY9DuzLKvzy1ZLZ21pMVM/o4Yb+bnM1hn3p+yBmz4xHy+wjvOQ6+IEklvmMQErn6T7vX8lq4MX3TVe5TNs4MuOGPFKlIMEwlwS/IyhjGQpxG3ToZQm6supTBmxFFPPDRffaVfdeR8H6Tf65LyDLK5i0O5VkYwyvrNda8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB9041.namprd04.prod.outlook.com (2603:10b6:806:384::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Thu, 10 Apr 2025 07:38:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 07:38:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: add block/039 for test updating nr_hw_queues vs
 switching elevator
Thread-Topic: [PATCH] blktests: add block/039 for test updating nr_hw_queues
 vs switching elevator
Thread-Index: AQHbo4XGukf+K9gx5EegxTSmPZdrpLOckBqA
Date: Thu, 10 Apr 2025 07:38:39 +0000
Message-ID: <mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc>
References: <20250402041429.942623-1-ming.lei@redhat.com>
In-Reply-To: <20250402041429.942623-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB9041:EE_
x-ms-office365-filtering-correlation-id: 249d0283-cc20-472c-ee81-08dd7802b654
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ICinRnW5FLp7WseUKhilWp+k04r8rH8UVvKDPkRWlVSE1XscvtZmrpyn7vwS?=
 =?us-ascii?Q?hrR6As0tc2D5thoKxqCZCPcOouNqyc2jrr2t4vu3Q0jpZWLPmdCEdn/r0zxl?=
 =?us-ascii?Q?pfGOIaxBqbBuDEWlsJP/Cj1VAKlKiApua0Tu/BE2v8NIjjMMQgUJm7zPc8sE?=
 =?us-ascii?Q?jZP/fQVYisjQm6mDMOADMSJPY7CXJ0F1ufoqNF+NKUBDS3FeQyoijUzXMtW5?=
 =?us-ascii?Q?USRvV8vsvXr/qI80EAZ/U36TQDFC1KWWd7umsfsfwIVOb8nUHI/oXTc7fUHf?=
 =?us-ascii?Q?K4vHlaHDap2wZVFFCZY4nyU+BKipkFN8TGn+SFB4Zm4fiP7MCW4SQhrhF5PP?=
 =?us-ascii?Q?Y258RFwrfYK70pt2fX3Ucn+sv16/acZ3P059WIQ5znGnMkpD2MGS4EGloJQz?=
 =?us-ascii?Q?Ra5Gb9QgcJLAiTzh+bZ7MhJMEyXHNTKRoeJIopXtmI37pr+FX4AYaBuUG4vS?=
 =?us-ascii?Q?aIvMYOvR9ZiTmzSAZvIBkceqLisqRGJKACs0hYXYz0cP40iuK1CCtcXd/9j6?=
 =?us-ascii?Q?3k9tLZ9iJla5v1ACCX/X/p+OOD1u0K+6N0yq8hWwxKPitXDrHhKJXwoUpQaI?=
 =?us-ascii?Q?Tb2ylG9R2Fkm5xXxLGldoTh6q/o8IBxXd+5J0BNkjl1jAzla764EJj8oprUN?=
 =?us-ascii?Q?8K1LODiNuF1MN0bUjTwqdiqDXGUHFzNN2jzJnL5s4gqmpUbQR45Ej8zuccPt?=
 =?us-ascii?Q?fIerdrK4AFY/Rnv54z/ikLZ8ucWM9oYiP0T0zjByJfSX/MY630vGj9nFQ5wL?=
 =?us-ascii?Q?DG0mvGtJcbBe8dWT3oHqYrB2kFbsRlOAfi5AOAf16umvVTZ6XuDZOxTQI9pe?=
 =?us-ascii?Q?6yDjmlRT/3gZWCti3hb5UHlmPON4H/SKS1nYTCdsdmty5DfUUFCebKKrZKfq?=
 =?us-ascii?Q?oiCRduAOFGiMkhFYmuBZZx6NPPHhW/hSQuBZWNyaAb3/OEiVAAXoFyTQKaVT?=
 =?us-ascii?Q?X4bj/FAehlblPjGXyTIWJZF2Pm8Vodqpx27c1EE/JAzs8JpqsZnRK9HCqrfC?=
 =?us-ascii?Q?MNEuun/HZimsGImc64G6L+fGP3VN4mUnlIQ0GiELz2TEo5xaPN5NklGxVggK?=
 =?us-ascii?Q?socYUuxJHR1ofnEPVmJAgOJrYurtyzYKs6JS3PHz81v7pEH40tH7xBnlFucx?=
 =?us-ascii?Q?M7LSo+0ehUlOYWFZxGoDprIyI2fo274SMtsUhgowZKXrvLVPFKR4r9S31sps?=
 =?us-ascii?Q?Tz3cEw83jWBDDZYiHyyZbqD3NMQJBLqGH//WAwkv1Ky0d5zMKsrlK5xY/PO2?=
 =?us-ascii?Q?PxuZrDHNG+rwCwyGuEgUd5fRQCOrx/OW9xZrLOPr2FhMOChVOo5DCBF8N53U?=
 =?us-ascii?Q?txpAsC553msENHpEc6VkZKSm9f1Kwj9h3wb9XyxbRUXSQBtkyn5Gpz4nJCbL?=
 =?us-ascii?Q?FFvuyGMaA1hq2KjzSIBnjvrHHo1nJVKSfD5wVNkn/yzXwbk9zixSq71n0/kQ?=
 =?us-ascii?Q?AijXBpoMniszIsDT0m4maIW1tfLypehc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2zjsV3XLPGAG2ns0jyue4BJM40knKmSutZcP8e/+RnDIMEmuuDwqBObfG/HC?=
 =?us-ascii?Q?ZntvaQ5in+4SmzKXuOKEEAPmM1cwZVg9+5zI6ujXda+x0QDkr+7tQ5Dq/2WB?=
 =?us-ascii?Q?Mm5CYkAPgeL9YlyK7zIMZzYoRJa4hr5ysEtQC3CF+JHQ8MspSbOo72LnFO8S?=
 =?us-ascii?Q?h49bJXf7t4tt/QqVB7ZjBBGU8TNoMm0gZVqnIOghIzx7eVb12qI+dzsS7lpT?=
 =?us-ascii?Q?sire/PHiAtPiA3bDCpHgeAFetrkKZ4AiYIDo91t2A8VtJKcZkJmtQq8/zGBZ?=
 =?us-ascii?Q?GvmojLMY06q+5XmQkBPZFjMJ3GKdd8ojhdz/ayH7QmLfr5cQrU4sUwODMdcZ?=
 =?us-ascii?Q?V2Eh2XmkWqDM+lbBVZ9kqNoasCrOJXwyX00wu1vTj3askJUFZbfEXiNy4vVk?=
 =?us-ascii?Q?wBivDwdnNccCF+LWMeRsd+TXGghmkgn+2k6d0u0fRCwrRaf01nEZBejQH4nZ?=
 =?us-ascii?Q?/1t1ZoZziHWfDzodOu49kqRKM8O3ZjvZOD//X8gEntQHZzzq1SUTeGHYK20C?=
 =?us-ascii?Q?P5Pk/FzphVcc+4MK6gDoZFs35vPX23/oBs61pZmKAL8roGeb8Q1Q2WWPncg3?=
 =?us-ascii?Q?DepmGgVlD7txmUYfeOH0X9PMIhRC3zo4CKs1KwVwPFYjOwOqvmewqJ/i2A3x?=
 =?us-ascii?Q?QL4CpEQE7mb1aK6rZPEj84SDTy2SpMbMU1P1rD3v0ivxbP1Ogx5+KsindHbG?=
 =?us-ascii?Q?lt98zlAvvCk4y31tu3C+7b8+bl1LIugyLGPPqQT8ePcHzyQBcJRN36vmrzRR?=
 =?us-ascii?Q?9q+/1/LE2MnfJBb0Fb4UX2nma1T5Ae4CaBSq+ko4V7rI/hjo3cx+uiV7n4gr?=
 =?us-ascii?Q?GBl6umcDzFtJ6C/4smy6nUsrfeP5uhnQrM2QG/E6CIAgsxCAcPbmJ3tClQVE?=
 =?us-ascii?Q?FCeBA3qBfqIdPOGCMAQFjIKaeZdh731ektOvKhzmJHikjbmBvgXhGpqPMcVs?=
 =?us-ascii?Q?iSRBqYGl2T110zIU+fIWyDMtcpoAwLUIPm4tCXwvWjaJnqLpbI+K5pKNrzM+?=
 =?us-ascii?Q?MjyGXRb/etYFmIgZlCMzlV6gDPVT6cV22DnYgYkStcoLU6SMY3PNRUkqKj31?=
 =?us-ascii?Q?ukV5ViraikXX42IOy6Apm5E2tm1HHvDGSQbEek8QBii2dR5qUdDPfx8DqlGG?=
 =?us-ascii?Q?eOxBok+JKllapsz7/lDgn/gkXUkOVaxmfXWiQvMBw3MuVDJ7TylQR0N941lc?=
 =?us-ascii?Q?+8sm/KW08xwTtNZMy/0aPYU7FEgrmkuaD1AzZEsc8KZIxi3XNHEejsdJd6LO?=
 =?us-ascii?Q?cG2OpWyHzG0AsLdMpzLs9RYQfRuRaz+lFDpWHahxBdMbHfUBhH/Kaa4xSSc5?=
 =?us-ascii?Q?Y1/8v83RJn/RTh1cpwOB3NRvMGU2uvKcs3nz1BvBz29l+BqrJdwQyo3w7AX/?=
 =?us-ascii?Q?h+KrfNggf+L/dL9jA3vPXTTrhN3eURlwTktdxLafEMX6+Ldb8RxOdeNWoco2?=
 =?us-ascii?Q?C3vli7eVKicwsgPDfMtp5z3lyi+n1KP71Oe9aZI6zGgfUjQjAWAHKk0UDxEV?=
 =?us-ascii?Q?AhByyUx4Ib+3IVbgBTHSr3XmrE+PDlvC0fnQ23aELeU86XzB4KLGnl9a1Ew+?=
 =?us-ascii?Q?xVLPVbVlzvGZeDCMnmr5AyRhURc7QWJiBQamDG3lyEttFbmTCey8iiyf5frS?=
 =?us-ascii?Q?0n9D1n0B7rCkDkD2+v0fbus=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EABC4C0A3F7B3B4DAB74C6C3F36D3D2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6HIOm2hYW5Ett7ggC/PvnPTC5xf5hAyQi+d3KvzhD7/sR7JZSeVjLFDO04C31B2VyaOlj8ggnsGz6Wb0Q0FGI5GQ0V+20IYDl4u6AX4VAlh8WjyM9706Cz1xKOXzmnt8MAtJISEne+Yal2GW59J4gjgvtk0kdhRJ9HRcmeD81lL6zbirFNwkKD3jA1DIg9JrxK7L4Wcq0BHyE/vYEM0f+EUYqui7fw72TQ9Us1JkqF3yXeT97kGkbrDAeB9NQUgICZhlf5g2UZ5OUqujSCy0ADcC/L7l8ptRHnfKcRWQZKSKB71sBjDQkg8FU7QtN5n1DEutV0upaiyTqidPh4ZUYWOKXScIe2EWv2aaM23OnDe6gKX+L48A4l5SvfoCl28QHK4TbLmOs3sLPzNQo5HRexXthZ+0zLh/bMt860PXC1iYcJ2Rm5VsO41VHjwGtu9vasmM/X8HpukT9Wl4bR/brYyhE0vcvH3/DjSASTFYvBO/P2FpUwJ1LrutSK4jelomg8emQGLXmhEZfwhgetpySpUZH6lE2EtU6mfEore6PYctnP33liJf2NVdqNYeo+H7XtXIQo/Y/x0A9uS9aF5KDKPi8oCqnjvJbZiBtPMQhapuy4CXQMhXTbefFzicB7c2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d0283-cc20-472c-ee81-08dd7802b654
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 07:38:40.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 592Atiycvs1F19hQ4Y8GDCAmQH+MDuBWbTv/jxO3Q8z44ayxOJTIdIvkayp5ZwGsrw82ZUNUcpgiBHRYjzVfQ7HWS2cEzQ/kkt0cAJqwnYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB9041

Hi Ming, thank you for the patch. Please find my comments in line.

On Apr 02, 2025 / 12:14, Ming Lei wrote:
> Add block/039 for covering updating nr_hw_queues and switching elevator.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/039     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/039.out |  1 +
>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/block/039
>  create mode 100644 tests/block/039.out
>=20
> diff --git a/tests/block/039 b/tests/block/039
> new file mode 100755
> index 0000000..d29db45
> --- /dev/null
> +++ b/tests/block/039
> @@ -0,0 +1,67 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

Just a comment. Most of the blktests test cases have the license "GPL-2.0+"=
 or
"GPL-3.0+". But I think "GPL-2.0" without "+" is appropriate for this new t=
est
case, because this test case was copied from block/029, whose license is
"GPL-2.0" without "+".

> +# Copyright 2025 Ming Lei <ming.lei@redhat.com>
> +#
> +# Most of code is copied from block/029
> +#
> +# Trigger blk_mq_update_nr_hw_queues() & elevator switch
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION=3D"test blk_mq_update_nr_hw_queues() vs switch elevator"
> +QUICK=3D1
> +
> +requires() {
> +	_have_fio && _have_null_blk

Nit: "&&" is no longer recommended in requires(). Let's just list the two
conditions in two lines:

	_have_fio
	_have_null_blk

> +}
> +
> +
> +modify_io_sched() {
> +	local deadline
> +	local dev=3D$1
> +
> +	deadline=3D$(($(_uptime_s) + TIMEOUT))
> +	while [ "$(_uptime_s)" -lt "$deadline" ]; do
> +		for sched in $(_io_schedulers "$dev"); do
> +			echo "$sched" > /sys/block/"$dev"/queue/scheduler > /dev/null 2>&1

When I ran this test case, I checked how the scheduler changes using the
command below.

$ while true; do cat /sys/block/nullb1/queue/scheduler; cat /sys/kernel/con=
fig/nullb/nullb1/submit_queues; sleep .3; done

And I found that the scheduler was not changing. The line above has a bug,
and the redirect to queue/scheduler file was not working. When a single com=
mand
has two redirections for single file descriptor, the latter one becomes val=
id.
In the example below, the redirect works only for the file B.

   COMMAND > A > B

To change the scheduler as intended, I suggest to change the line above as
follows:

   echo "$sched" > /sys/block/"$dev"/queue/scheduler

If it is really required to redirect stderr to /dev/null,

  { echo "$sched" > /sys/block/"$dev"/queue/scheduler ;} &> /dev/null

will work. With either of these changes, I confirmed that the schedulers
are switched during the test case run.

One interesting observation is that when I ran the test case with the sugge=
sted
change on the kernel v6.15-rc1, it triggered KASAN sauf followed by test pr=
ocess
hang [1].  (This proves that the test case is a good one :) I quickly tried=
 the
same run on the kernel v6.14, but the KASAN and the hang were not observed.

Ming, may I ask you to take a look in the KASAN sauf? I hope you can recrea=
te it
in your environment.

> +			sleep .5
> +		done
> +	done
> +}
> +
> +modify_nr_hw_queues() {
> +	local deadline num_cpus
> +
> +	deadline=3D$(($(_uptime_s) + TIMEOUT))
> +	num_cpus=3D$(nproc)
> +	while [ "$(_uptime_s)" -lt "$deadline" ]; do
> +		sleep .1
> +		echo 1 > /sys/kernel/config/nullb/nullb1/submit_queues
> +		sleep .1
> +		echo "$num_cpus" > /sys/kernel/config/nullb/nullb1/submit_queues
> +	done
> +}
> +
> +test() {
> +	local sq=3D/sys/kernel/config/nullb/nullb1/submit_queues
> +
> +	: "${TIMEOUT:=3D30}"
> +	_configure_null_blk nullb1 completion_nsec=3D0 blocksize=3D512 \
> +			    size=3D16 memory_backed=3D1 power=3D1 &&
> +	if { echo 1 >$sq; } 2>/dev/null; then
> +		modify_nr_hw_queues &
> +		modify_io_sched nullb1 &
> +		fio --rw=3Drandwrite --bs=3D4K --loops=3D$((10**6)) \
> +		    --iodepth=3D64 --group_reporting --sync=3D1 --direct=3D1 \
> +		    --ioengine=3Dlibaio --filename=3D"/dev/nullb1" \
> +		    --runtime=3D"${TIMEOUT}" --name=3Dnullb1 \
> +		    --output=3D"${RESULTS_DIR}/block/fio-output-029.txt" \
> +		    >>"$FULL"
> +		wait
> +	else
> +		echo "Skipping test because $sq cannot be modified" >>"$FULL"

To conform to blktests test case skip mechanism, I suggest to replace
the line above as follows:

		SKIP_REASONS+=3D("$sq cannot be modified")
		_exit_null_blk
		return

The same change in block/029 is desired, but I think it can be left as a fu=
ture
left work.

> +	fi
> +	_exit_null_blk
> +	echo Passed
> +}
> diff --git a/tests/block/039.out b/tests/block/039.out
> new file mode 100644
> index 0000000..863339f
> --- /dev/null
> +++ b/tests/block/039.out
> @@ -0,0 +1 @@
> +Passed
> --=20
> 2.44.0
>=20


[1]

[ 1946.004009] [   T4057] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1946.005611] [   T4057] BUG: KASAN: slab-use-after-free in elv_iosched_sh=
ow+0x21f/0x240
[ 1946.007251] [   T4057] Read of size 8 at addr ffff88812b5cd000 by task c=
at/4057

[ 1946.008987] [   T4057] CPU: 2 UID: 1000 PID: 4057 Comm: cat Not tainted =
6.15.0-rc1+ #22 PREEMPT(voluntary)=20
[ 1946.008996] [   T4057] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1946.009000] [   T4057] Call Trace:
[ 1946.009004] [   T4057]  <TASK>
[ 1946.009008] [   T4057]  dump_stack_lvl+0x6a/0x90
[ 1946.009020] [   T4057]  print_report+0x174/0x554
[ 1946.009028] [   T4057]  ? __virt_addr_valid+0x208/0x430
[ 1946.009050] [   T4057]  ? elv_iosched_show+0x21f/0x240
[ 1946.009056] [   T4057]  kasan_report+0xae/0x170
[ 1946.009064] [   T4057]  ? elv_iosched_show+0x21f/0x240
[ 1946.009072] [   T4057]  elv_iosched_show+0x21f/0x240
[ 1946.009079] [   T4057]  sysfs_kf_seq_show+0x1c5/0x340
[ 1946.009088] [   T4057]  seq_read_iter+0x2c5/0x1150
[ 1946.009096] [   T4057]  ? security_file_permission+0x3f/0xb0
[ 1946.009109] [   T4057]  ? rw_verify_area+0x69/0x520
[ 1946.009116] [   T4057]  vfs_read+0x6ba/0xa20
[ 1946.009122] [   T4057]  ? do_anonymous_page+0x3ce/0x1a00
[ 1946.009129] [   T4057]  ? __pfx_vfs_read+0x10/0x10
[ 1946.009141] [   T4057]  ksys_read+0xf5/0x1c0
[ 1946.009146] [   T4057]  ? __pfx_ksys_read+0x10/0x10
[ 1946.009152] [   T4057]  ? do_syscall_64+0x54/0x190
[ 1946.009159] [   T4057]  do_syscall_64+0x93/0x190
[ 1946.009163] [   T4057]  ? rcu_is_watching+0x11/0xb0
[ 1946.009170] [   T4057]  ? rcu_read_unlock+0x17/0x60
[ 1946.009174] [   T4057]  ? rcu_is_watching+0x11/0xb0
[ 1946.009180] [   T4057]  ? lock_release+0x217/0x2c0
[ 1946.009185] [   T4057]  ? rcu_is_watching+0x11/0xb0
[ 1946.009190] [   T4057]  ? count_memcg_events.constprop.0+0x4a/0x60
[ 1946.009195] [   T4057]  ? exc_page_fault+0x7a/0x110
[ 1946.009200] [   T4057]  ? rcu_is_watching+0x11/0xb0
[ 1946.009205] [   T4057]  ? lock_release+0x217/0x2c0
[ 1946.009209] [   T4057]  ? do_user_addr_fault+0x171/0xa00
[ 1946.009216] [   T4057]  ? do_user_addr_fault+0x4a2/0xa00
[ 1946.009221] [   T4057]  ? irqentry_exit_to_user_mode+0x84/0x270
[ 1946.009226] [   T4057]  ? rcu_is_watching+0x11/0xb0
[ 1946.009231] [   T4057]  ? irqentry_exit_to_user_mode+0x84/0x270
[ 1946.009235] [   T4057]  ? trace_hardirqs_on_prepare+0xdb/0x120
[ 1946.009249] [   T4057]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1946.009254] [   T4057] RIP: 0033:0x7fa43e4b63d1
[ 1946.009262] [   T4057] Code: 00 48 8b 15 41 1a 10 00 f7 d8 64 89 02 b8 f=
f ff ff ff eb bd e8 20 ad 01 00 f3 0f 1e fa 80 3d f5 9c 10 00 00 74 13 31 c=
0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[ 1946.009267] [   T4057] RSP: 002b:00007fff428aeba8 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000000
[ 1946.009275] [   T4057] RAX: ffffffffffffffda RBX: 0000000000040000 RCX: =
00007fa43e4b63d1
[ 1946.009279] [   T4057] RDX: 0000000000040000 RSI: 00007fa43e32c000 RDI: =
0000000000000003
[ 1946.009282] [   T4057] RBP: 00007fff428aebd0 R08: 0000000000000000 R09: =
00007fa43e60c380
[ 1946.009285] [   T4057] R10: 0000000000000022 R11: 0000000000000246 R12: =
0000000000040000
[ 1946.009288] [   T4057] R13: 00007fa43e32c000 R14: 0000000000000003 R15: =
0000000000000000
[ 1946.009298] [   T4057]  </TASK>

[ 1946.042407] [   T4057] Allocated by task 3917:
[ 1946.042978] [   T4057]  kasan_save_stack+0x2c/0x50
[ 1946.043554] [   T4057]  kasan_save_track+0x10/0x30
[ 1946.044153] [   T4057]  __kasan_kmalloc+0xa6/0xb0
[ 1946.044722] [   T4057]  elevator_alloc+0x78/0x1a0
[ 1946.045328] [   T4057]  dd_init_sched+0x1b/0x4d0
[ 1946.045897] [   T4057]  blk_mq_init_sched+0x396/0x5e0
[ 1946.046493] [   T4057]  elevator_switch+0x149/0x4b0
[ 1946.047092] [   T4057]  blk_mq_update_nr_hw_queues+0x835/0x1170
[ 1946.047745] [   T4057]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[ 1946.048479] [   T4057]  nullb_device_submit_queues_store+0xd7/0x170 [nul=
l_blk]
[ 1946.049282] [   T4057]  configfs_write_iter+0x2a8/0x460
[ 1946.049940] [   T4057]  vfs_write+0x5f7/0xe90
[ 1946.050521] [   T4057]  ksys_write+0xf5/0x1c0
[ 1946.051128] [   T4057]  do_syscall_64+0x93/0x190
[ 1946.051733] [   T4057]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 1946.052853] [   T4057] Freed by task 3918:
[ 1946.053390] [   T4057]  kasan_save_stack+0x2c/0x50
[ 1946.054015] [   T4057]  kasan_save_track+0x10/0x30
[ 1946.054604] [   T4057]  kasan_save_free_info+0x37/0x60
[ 1946.055233] [   T4057]  __kasan_slab_free+0x4b/0x70
[ 1946.055822] [   T4057]  kfree+0x13a/0x4b0
[ 1946.056366] [   T4057]  kobject_put+0x17b/0x4a0
[ 1946.056934] [   T4057]  elevator_switch+0x13d/0x4b0
[ 1946.057529] [   T4057]  elv_iosched_store+0x394/0x4d0
[ 1946.058162] [   T4057]  queue_attr_store+0x236/0x2f0
[ 1946.058768] [   T4057]  kernfs_fop_write_iter+0x39f/0x5a0
[ 1946.059395] [   T4057]  vfs_write+0x5f7/0xe90
[ 1946.059947] [   T4057]  ksys_write+0xf5/0x1c0
[ 1946.060491] [   T4057]  do_syscall_64+0x93/0x190
[ 1946.061101] [   T4057]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 1946.062203] [   T4057] The buggy address belongs to the object at ffff88=
812b5cd000
                           which belongs to the cache kmalloc-1k of size 10=
24
[ 1946.063689] [   T4057] The buggy address is located 0 bytes inside of
                           freed 1024-byte region [ffff88812b5cd000, ffff88=
812b5cd400)

[ 1946.065668] [   T4057] The buggy address belongs to the physical page:
[ 1946.066407] [   T4057] page: refcount:0 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x12b5c8
[ 1946.067324] [   T4057] head: order:3 mapcount:0 entire_mapcount:0 nr_pag=
es_mapped:0 pincount:0
[ 1946.068186] [   T4057] anon flags: 0x17ffffc0000040(head|node=3D0|zone=
=3D2|lastcpupid=3D0x1fffff)
[ 1946.068997] [   T4057] page_type: f5(slab)
[ 1946.069554] [   T4057] raw: 0017ffffc0000040 ffff888100042dc0 0000000000=
000000 dead000000000001
[ 1946.070417] [   T4057] raw: 0000000000000000 0000000000100010 00000000f5=
000000 0000000000000000
[ 1946.071271] [   T4057] head: 0017ffffc0000040 ffff888100042dc0 000000000=
0000000 dead000000000001
[ 1946.072127] [   T4057] head: 0000000000000000 0000000000100010 00000000f=
5000000 0000000000000000
[ 1946.072976] [   T4057] head: 0017ffffc0000003 ffffea0004ad7201 00000000f=
fffffff 00000000ffffffff
[ 1946.073825] [   T4057] head: ffffffffffffffff 0000000000000000 00000000f=
fffffff 0000000000000008
[ 1946.074666] [   T4057] page dumped because: kasan: bad access detected

[ 1946.075812] [   T4057] Memory state around the buggy address:
[ 1946.076470] [   T4057]  ffff88812b5ccf00: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[ 1946.077337] [   T4057]  ffff88812b5ccf80: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[ 1946.078160] [   T4057] >ffff88812b5cd000: fa fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1946.078961] [   T4057]                    ^
[ 1946.079512] [   T4057]  ffff88812b5cd080: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1946.080342] [   T4057]  ffff88812b5cd100: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1946.081186] [   T4057] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1949.678369] [   T3930] Oops: general protection fault, probably for non-=
canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
[ 1949.681175] [   T3930] KASAN: null-ptr-deref in range [0x000000000000001=
0-0x0000000000000017]
[ 1949.683292] [   T3930] CPU: 1 UID: 0 PID: 3930 Comm: fio Tainted: G    B=
               6.15.0-rc1+ #22 PREEMPT(voluntary)=20
[ 1949.685782] [   T3930] Tainted: [B]=3DBAD_PAGE
[ 1949.687544] [   T3930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1949.689881] [   T3930] RIP: 0010:dd_limit_depth+0x16e/0x2a0
[ 1949.691773] [   T3930] Code: 03 80 3c 02 00 0f 85 2b 01 00 00 49 8d 7e 1=
4 4c 8b ad d0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 4=
4 89 ed <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 84
[ 1949.696185] [   T3930] RSP: 0018:ffff88811a807260 EFLAGS: 00010203
[ 1949.697702] [   T3930] RAX: dffffc0000000000 RBX: ffff88811a80745c RCX: =
ffffffffaf6749c0
[ 1949.699289] [   T3930] RDX: 0000000000000002 RSI: ffff88811a807448 RDI: =
0000000000000014
[ 1949.700749] [   T3930] RBP: 0000000000000080 R08: ffff88811a807458 R09: =
ffff8881322e9d40
[ 1949.702017] [   T3930] R10: ffff88811a807470 R11: ffff8881322e9d58 R12: =
0000000000000080
[ 1949.703078] [   T3930] R13: 0000000000000080 R14: 0000000000000000 R15: =
ffff88811a807448
[ 1949.704118] [   T3930] FS:  00007f789a1ea740(0000) GS:ffff8883fa4bf000(0=
000) knlGS:0000000000000000
[ 1949.705084] [   T3930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1949.705850] [   T3930] CR2: 0000556aa4e2e164 CR3: 000000014762c000 CR4: =
00000000000006f0
[ 1949.706666] [   T3930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 1949.707516] [   T3930] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[ 1949.708346] [   T3930] Call Trace:
[ 1949.708991] [   T3930]  <TASK>
[ 1949.709610] [   T3930]  __blk_mq_alloc_requests+0x32f/0x1280
[ 1949.710374] [   T3930]  ? __pfx_wbt_wait+0x10/0x10
[ 1949.711081] [   T3930]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[ 1949.711840] [   T3930]  ? __pfx_dd_bio_merge+0x10/0x10
[ 1949.712538] [   T3930]  ? blk_mq_submit_bio+0xc83/0x2070
[ 1949.713433] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.714150] [   T3930]  blk_mq_submit_bio+0x759/0x2070
[ 1949.714886] [   T3930]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[ 1949.715596] [   T3930]  __submit_bio+0x36a/0x6c0
[ 1949.716320] [   T3930]  ? bio_associate_blkg_from_css+0x3cb/0xf20
[ 1949.717040] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.717722] [   T3930]  ? __pfx___submit_bio+0x10/0x10
[ 1949.718404] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.719060] [   T3930]  ? seqcount_lockdep_reader_access.constprop.0+0x8=
2/0x90
[ 1949.720003] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.720660] [   T3930]  ? seqcount_lockdep_reader_access.constprop.0+0x8=
2/0x90
[ 1949.721409] [   T3930]  ? trace_hardirqs_on+0x12/0x120
[ 1949.722117] [   T3930]  ? submit_bio_noacct_nocheck+0x522/0xc70
[ 1949.722849] [   T3930]  submit_bio_noacct_nocheck+0x522/0xc70
[ 1949.723704] [   T3930]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[ 1949.724578] [   T3930]  ? submit_bio_noacct+0x991/0x19c0
[ 1949.725473] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.726354] [   T3930]  blkdev_direct_IO+0x90a/0x2070
[ 1949.727242] [   T3930]  ? __pfx_blkdev_direct_IO+0x10/0x10
[ 1949.728121] [   T3930]  ? filemap_check_errors+0x56/0xe0
[ 1949.728851] [   T3930]  blkdev_write_iter+0x50b/0xc10
[ 1949.729564] [   T3930]  aio_write+0x335/0x880
[ 1949.730267] [   T3930]  ? __pfx_aio_write+0x10/0x10
[ 1949.730922] [   T3930]  ? __pfx___might_resched+0x10/0x10
[ 1949.731577] [   T3930]  ? __might_fault+0x99/0x120
[ 1949.732240] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.732860] [   T3930]  ? io_submit_one+0xdf0/0x1aa0
[ 1949.733521] [   T3930]  io_submit_one+0xdf0/0x1aa0
[ 1949.734155] [   T3930]  ? __x64_sys_io_getevents+0x14e/0x290
[ 1949.734784] [   T3930]  ? __pfx___x64_sys_io_getevents+0x10/0x10
[ 1949.735439] [   T3930]  ? __pfx_io_submit_one+0x10/0x10
[ 1949.736041] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.736665] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.737237] [   T3930]  ? __pfx___might_resched+0x10/0x10
[ 1949.737828] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.738400] [   T3930]  ? __might_fault+0x99/0x120
[ 1949.738969] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.739537] [   T3930]  ? __x64_sys_io_submit+0x165/0x2c0
[ 1949.740164] [   T3930]  __x64_sys_io_submit+0x165/0x2c0
[ 1949.740734] [   T3930]  ? __pfx___x64_sys_io_submit+0x10/0x10
[ 1949.741321] [   T3930]  ? percpu_ref_put_many.constprop.0+0x7a/0x1b0
[ 1949.741934] [   T3930]  do_syscall_64+0x93/0x190
[ 1949.742514] [   T3930]  ? __pfx___x64_sys_io_submit+0x10/0x10
[ 1949.743112] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.743693] [   T3930]  ? syscall_exit_to_user_mode+0x8e/0x280
[ 1949.744275] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.744850] [   T3930]  ? syscall_exit_to_user_mode+0x8e/0x280
[ 1949.745429] [   T3930]  ? trace_hardirqs_on_prepare+0xdb/0x120
[ 1949.746031] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.746617] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.747212] [   T3930]  ? trace_hardirqs_on_prepare+0xdb/0x120
[ 1949.747795] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.748383] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.748926] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.749509] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.750099] [   T3930]  ? trace_hardirqs_on_prepare+0xdb/0x120
[ 1949.750681] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.751271] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.751818] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.752357] [   T3930]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1949.752938] [   T3930] RIP: 0033:0x7f789a2e195d
[ 1949.753486] [   T3930] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0=
f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 0=
8 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 64 0f 00 f7 d8 64 89 01 48
[ 1949.754985] [   T3930] RSP: 002b:00007fff900de298 EFLAGS: 00000246 ORIG_=
RAX: 00000000000000d1
[ 1949.755702] [   T3930] RAX: ffffffffffffffda RBX: 00007f789a1ea6c0 RCX: =
00007f789a2e195d
[ 1949.756390] [   T3930] RDX: 0000000030e1eef8 RSI: 0000000000000001 RDI: =
00007f789159b000
[ 1949.757128] [   T3930] RBP: 00007fff900de2d0 R08: 0000034b66d0deb4 R09: =
0000000000000001
[ 1949.757825] [   T3930] R10: 0000000000000000 R11: 0000000000000246 R12: =
00007f789159b000
[ 1949.758522] [   T3930] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000030e1eef8
[ 1949.759255] [   T3930]  </TASK>
[ 1949.759758] [   T3930] Modules linked in: null_blk nft_fib_inet nft_fib_=
ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft=
_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip_set nf_tables qrtr sunrpc ppdev parport_pc parport 9pnet_virtio 9pne=
t e1000 netfs i2c_piix4 pcspkr i2c_smbus loop fuse dm_multipath nfnetlink v=
sock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vs=
ock vmw_vmci zram bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs =
drm nvme sym53c8xx scsi_transport_spi nvme_core floppy nvme_keyring nvme_au=
th serio_raw ata_generic pata_acpi qemu_fw_cfg [last unloaded: null_blk]
[ 1949.764286] [   T3930] ---[ end trace 0000000000000000 ]---
[ 1949.764925] [   T3930] RIP: 0010:dd_limit_depth+0x16e/0x2a0
[ 1949.765584] [   T3930] Code: 03 80 3c 02 00 0f 85 2b 01 00 00 49 8d 7e 1=
4 4c 8b ad d0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 4=
4 89 ed <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 84
[ 1949.767349] [   T3930] RSP: 0018:ffff88811a807260 EFLAGS: 00010203
[ 1949.768048] [   T3930] RAX: dffffc0000000000 RBX: ffff88811a80745c RCX: =
ffffffffaf6749c0
[ 1949.768777] [   T3930] RDX: 0000000000000002 RSI: ffff88811a807448 RDI: =
0000000000000014
[ 1949.769627] [   T3930] RBP: 0000000000000080 R08: ffff88811a807458 R09: =
ffff8881322e9d40
[ 1949.770470] [   T3930] R10: ffff88811a807470 R11: ffff8881322e9d58 R12: =
0000000000000080
[ 1949.771211] [   T3930] R13: 0000000000000080 R14: 0000000000000000 R15: =
ffff88811a807448
[ 1949.771917] [   T3930] FS:  00007f789a1ea740(0000) GS:ffff8883fa4bf000(0=
000) knlGS:0000000000000000
[ 1949.772708] [   T3930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1949.773474] [   T3930] CR2: 0000556aa4e2e164 CR3: 000000014762c000 CR4: =
00000000000006f0
[ 1949.774285] [   T3930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 1949.775058] [   T3930] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[ 1949.775804] [   T3930] ------------[ cut here ]------------
[ 1949.776556] [   T3930] WARNING: CPU: 1 PID: 3930 at kernel/exit.c:900 do=
_exit+0x17da/0x2570
[ 1949.777412] [   T3930] Modules linked in: null_blk nft_fib_inet nft_fib_=
ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft=
_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip_set nf_tables qrtr sunrpc ppdev parport_pc parport 9pnet_virtio 9pne=
t e1000 netfs i2c_piix4 pcspkr i2c_smbus loop fuse dm_multipath nfnetlink v=
sock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vs=
ock vmw_vmci zram bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs =
drm nvme sym53c8xx scsi_transport_spi nvme_core floppy nvme_keyring nvme_au=
th serio_raw ata_generic pata_acpi qemu_fw_cfg [last unloaded: null_blk]
[ 1949.782589] [   T3930] CPU: 1 UID: 0 PID: 3930 Comm: fio Tainted: G    B=
 D             6.15.0-rc1+ #22 PREEMPT(voluntary)=20
[ 1949.783665] [   T3930] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE
[ 1949.784394] [   T3930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1949.785407] [   T3930] RIP: 0010:do_exit+0x17da/0x2570
[ 1949.786085] [   T3930] Code: 48 c1 ea 03 48 c1 e0 2a 0f b6 04 02 84 c0 7=
4 08 3c 03 0f 8e 0f 0c 00 00 8b 83 60 1e 00 00 65 01 05 4f e4 6e 05 e9 d0 f=
d ff ff <0f> 0b e9 14 ea ff ff 0f 0b e9 96 e8 ff ff 4c 89 fe bf 05 06 00 00
[ 1949.788078] [   T3930] RSP: 0018:ffff88811a807e68 EFLAGS: 00010286
[ 1949.788832] [   T3930] RAX: dffffc0000000000 RBX: ffff88814d3cb340 RCX: =
0000000000000000
[ 1949.789644] [   T3930] RDX: 1ffff11029a79939 RSI: ffffffffb13d4780 RDI: =
ffff88814d3cc9c8
[ 1949.790582] [   T3930] RBP: ffff88814d3cc068 R08: 0000000000000000 R09: =
fffffbfff658bf8c
[ 1949.791527] [   T3930] R10: 0000000000000000 R11: 0000000000000001 R12: =
ffff88814161db00
[ 1949.792454] [   T3930] R13: ffff888124f62f80 R14: ffff88814d3cc060 R15: =
000000000000000b
[ 1949.793364] [   T3930] FS:  00007f789a1ea740(0000) GS:ffff8883fa4bf000(0=
000) knlGS:0000000000000000
[ 1949.794288] [   T3930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1949.795055] [   T3930] CR2: 0000556aa4e2e164 CR3: 000000014762c000 CR4: =
00000000000006f0
[ 1949.795871] [   T3930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 1949.796699] [   T3930] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[ 1949.797653] [   T3930] Call Trace:
[ 1949.798384] [   T3930]  <TASK>
[ 1949.799001] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.799729] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.800522] [   T3930]  ? __pfx_do_exit+0x10/0x10
[ 1949.801261] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.801935] [   T3930]  ? trace_hardirqs_on_prepare+0xdb/0x120
[ 1949.802646] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.803423] [   T3930]  make_task_dead+0xf3/0x110
[ 1949.804110] [   T3930]  rewind_stack_and_make_dead+0x16/0x20
[ 1949.804768] [   T3930] RIP: 0033:0x7f789a2e195d
[ 1949.805484] [   T3930] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0=
f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 0=
8 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 64 0f 00 f7 d8 64 89 01 48
[ 1949.807188] [   T3930] RSP: 002b:00007fff900de298 EFLAGS: 00000246 ORIG_=
RAX: 00000000000000d1
[ 1949.808039] [   T3930] RAX: ffffffffffffffda RBX: 00007f789a1ea6c0 RCX: =
00007f789a2e195d
[ 1949.808821] [   T3930] RDX: 0000000030e1eef8 RSI: 0000000000000001 RDI: =
00007f789159b000
[ 1949.809587] [   T3930] RBP: 00007fff900de2d0 R08: 0000034b66d0deb4 R09: =
0000000000000001
[ 1949.810495] [   T3930] R10: 0000000000000000 R11: 0000000000000246 R12: =
00007f789159b000
[ 1949.811329] [   T3930] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000030e1eef8
[ 1949.812110] [   T3930]  </TASK>
[ 1949.812675] [   T3930] irq event stamp: 0
[ 1949.813333] [   T3930] hardirqs last  enabled at (0): [<0000000000000000=
>] 0x0
[ 1949.814065] [   T3930] hardirqs last disabled at (0): [<ffffffffae4f3bff=
>] copy_process+0x1f3f/0x87d0
[ 1949.814907] [   T3930] softirqs last  enabled at (0): [<ffffffffae4f3c64=
>] copy_process+0x1fa4/0x87d0
[ 1949.815703] [   T3930] softirqs last disabled at (0): [<0000000000000000=
>] 0x0
[ 1949.816530] [   T3930] ---[ end trace 0000000000000000 ]---
[ 1949.817334] [   T3930] Oops: general protection fault, probably for non-=
canonical address 0xdffffc000836b157: 0000 [#2] SMP KASAN PTI
[ 1949.820559] [   T3930] KASAN: probably user-memory-access in range [0x00=
00000041b58ab8-0x0000000041b58abf]
[ 1949.823356] [   T3930] CPU: 3 UID: 0 PID: 3930 Comm: fio Tainted: G    B=
 D W           6.15.0-rc1+ #22 PREEMPT(voluntary)=20
[ 1949.826308] [   T3930] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[ 1949.828302] [   T3930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1949.830302] [   T3930] RIP: 0010:__blk_flush_plug+0x10d/0x4d0
[ 1949.831705] [   T3930] Code: 39 c6 74 6f 48 8b 7c 24 10 4c 8b 6c 24 60 4=
8 8b 42 30 80 3f 00 0f 85 7c 03 00 00 48 8d 78 08 4c 8b 62 38 48 89 f9 48 c=
1 e9 03 <80> 3c 29 00 0f 85 8e 03 00 00 48 89 58 08 48 89 44 24 60 4c 89 e0
[ 1949.834899] [   T3930] RSP: 0018:ffff88811a807a20 EFLAGS: 00010202
[ 1949.835941] [   T3930] RAX: 0000000041b58ab3 RBX: ffff88811a807a80 RCX: =
000000000836b157
[ 1949.837134] [   T3930] RDX: ffff88811a807560 RSI: ffff88811a807590 RDI: =
0000000041b58abb
[ 1949.838124] [   T3930] RBP: dffffc0000000000 R08: ffff88811a807590 R09: =
0000000000000000
[ 1949.839035] [   T3930] R10: 0000000000000000 R11: ffffffffae2f6526 R12: =
0000000000000010
[ 1949.839930] [   T3930] R13: ffff88811a807a80 R14: 0000000000000001 R15: =
ffff88811a807560
[ 1949.840815] [   T3930] FS:  0000000000000000(0000) GS:ffff8883fa5bf000(0=
000) knlGS:0000000000000000
[ 1949.841725] [   T3930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1949.842496] [   T3930] CR2: 00007f6e5397d0f0 CR3: 000000014762c000 CR4: =
00000000000006f0
[ 1949.843369] [   T3930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 1949.844263] [   T3930] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[ 1949.845145] [   T3930] Call Trace:
[ 1949.845707] [   T3930]  <TASK>
[ 1949.846246] [   T3930]  ? __pfx___blk_flush_plug+0x10/0x10
[ 1949.846939] [   T3930]  ? lock_acquire+0x2b2/0x310
[ 1949.847590] [   T3930]  schedule+0x2b0/0x390
[ 1949.848216] [   T3930]  schedule_timeout+0x176/0x230
[ 1949.848874] [   T3930]  ? __pfx_schedule_timeout+0x10/0x10
[ 1949.849561] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.850231] [   T3930]  ? _raw_spin_unlock_irq+0x24/0x50
[ 1949.850904] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.851555] [   T3930]  __wait_for_common+0x2ea/0x4c0
[ 1949.852229] [   T3930]  ? __pfx_schedule_timeout+0x10/0x10
[ 1949.852919] [   T3930]  ? __pfx___wait_for_common+0x10/0x10
[ 1949.853605] [   T3930]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 1949.854340] [   T3930]  ? trace_hardirqs_on+0x12/0x120
[ 1949.855017] [   T3930]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[ 1949.855715] [   T3930]  ? kill_ioctx+0x1dd/0x2a0
[ 1949.856332] [   T3930]  exit_aio+0x286/0x310
[ 1949.856902] [   T3930]  ? __pfx_exit_aio+0x10/0x10
[ 1949.857518] [   T3930]  __mmput+0x6e/0x380
[ 1949.858118] [   T3930]  do_exit+0x83f/0x2570
[ 1949.858692] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.859362] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.860000] [   T3930]  ? __pfx_do_exit+0x10/0x10
[ 1949.860597] [   T3930]  ? do_syscall_64+0x9f/0x190
[ 1949.861209] [   T3930]  ? trace_hardirqs_on_prepare+0xdb/0x120
[ 1949.861878] [   T3930]  ? syscall_exit_to_user_mode+0x93/0x280
[ 1949.862540] [   T3930]  make_task_dead+0xf3/0x110
[ 1949.863159] [   T3930]  rewind_stack_and_make_dead+0x16/0x20
[ 1949.863815] [   T3930] RIP: 0033:0x7f789a2e195d
[ 1949.864399] [   T3930] Code: Unable to access opcode bytes at 0x7f789a2e=
1933.
[ 1949.865145] [   T3930] RSP: 002b:00007fff900de298 EFLAGS: 00000246 ORIG_=
RAX: 00000000000000d1
[ 1949.866008] [   T3930] RAX: ffffffffffffffda RBX: 00007f789a1ea6c0 RCX: =
00007f789a2e195d
[ 1949.866814] [   T3930] RDX: 0000000030e1eef8 RSI: 0000000000000001 RDI: =
00007f789159b000
[ 1949.867609] [   T3930] RBP: 00007fff900de2d0 R08: 0000034b66d0deb4 R09: =
0000000000000001
[ 1949.868467] [   T3930] R10: 0000000000000000 R11: 0000000000000246 R12: =
00007f789159b000
[ 1949.869343] [   T3930] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000030e1eef8
[ 1949.870215] [   T3930]  </TASK>
[ 1949.870698] [   T3930] Modules linked in: null_blk nft_fib_inet nft_fib_=
ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft=
_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip_set nf_tables qrtr sunrpc ppdev parport_pc parport 9pnet_virtio 9pne=
t e1000 netfs i2c_piix4 pcspkr i2c_smbus loop fuse dm_multipath nfnetlink v=
sock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vs=
ock vmw_vmci zram bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs =
drm nvme sym53c8xx scsi_transport_spi nvme_core floppy nvme_keyring nvme_au=
th serio_raw ata_generic pata_acpi qemu_fw_cfg [last unloaded: null_blk]
[ 1949.876129] [   T3930] ---[ end trace 0000000000000000 ]---
[ 1949.876853] [   T3930] RIP: 0010:dd_limit_depth+0x16e/0x2a0
[ 1949.877658] [   T3930] Code: 03 80 3c 02 00 0f 85 2b 01 00 00 49 8d 7e 1=
4 4c 8b ad d0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 4=
4 89 ed <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 84
[ 1949.879919] [   T3930] RSP: 0018:ffff88811a807260 EFLAGS: 00010203
[ 1949.881037] [   T3930] RAX: dffffc0000000000 RBX: ffff88811a80745c RCX: =
ffffffffaf6749c0
[ 1949.881915] [   T3930] RDX: 0000000000000002 RSI: ffff88811a807448 RDI: =
0000000000000014
[ 1949.882784] [   T3930] RBP: 0000000000000080 R08: ffff88811a807458 R09: =
ffff8881322e9d40
[ 1949.883645] [   T3930] R10: ffff88811a807470 R11: ffff8881322e9d58 R12: =
0000000000000080
[ 1949.884529] [   T3930] R13: 0000000000000080 R14: 0000000000000000 R15: =
ffff88811a807448
[ 1949.885431] [   T3930] FS:  0000000000000000(0000) GS:ffff8883fa5bf000(0=
000) knlGS:0000000000000000
[ 1949.886413] [   T3930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1949.887227] [   T3930] CR2: 00007f6e5397d0f0 CR3: 000000014762c000 CR4: =
00000000000006f0
[ 1949.888193] [   T3930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 1949.889121] [   T3930] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[ 1949.890013] [   T3930] Fixing recursive fault but reboot is needed!
[ 1949.890822] [   T3930] check_preemption_disabled: 40 callbacks suppresse=
d
[ 1949.890824] [   T3930] BUG: using smp_processor_id() in preemptible [000=
00000] code: fio/3930
[ 1949.892952] [   T3930] caller is __schedule+0xea/0x5fa0
[ 1949.893780] [   T3930] CPU: 3 UID: 0 PID: 3930 Comm: fio Tainted: G    B=
 D W           6.15.0-rc1+ #22 PREEMPT(voluntary)=20
[ 1949.893785] [   T3930] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[ 1949.893786] [   T3930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1949.893789] [   T3930] Call Trace:
[ 1949.893791] [   T3930]  <TASK>
[ 1949.893792] [   T3930]  dump_stack_lvl+0x6a/0x90
[ 1949.893797] [   T3930]  ? do_task_dead+0xcb/0x100
[ 1949.893800] [   T3930]  check_preemption_disabled+0xda/0xe0
[ 1949.893804] [   T3930]  __schedule+0xea/0x5fa0
[ 1949.893806] [   T3930]  ? __wake_up_klogd.part.0+0x79/0xc0
[ 1949.893809] [   T3930]  ? vprintk_emit+0x185/0x650
[ 1949.893812] [   T3930]  ? __pfx_vprintk_emit+0x10/0x10
[ 1949.893816] [   T3930]  ? __pfx___schedule+0x10/0x10
[ 1949.893819] [   T3930]  ? do_raw_spin_lock+0x129/0x260
[ 1949.893822] [   T3930]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1949.893824] [   T3930]  ? do_task_dead+0x93/0x100
[ 1949.893826] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.893829] [   T3930]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 1949.893831] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.893833] [   T3930]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 1949.893835] [   T3930]  ? do_task_dead+0x1a/0x100
[ 1949.893837] [   T3930]  do_task_dead+0xcb/0x100
[ 1949.893840] [   T3930]  make_task_dead.cold+0x184/0x18e
[ 1949.893844] [   T3930]  rewind_stack_and_make_dead+0x16/0x20
[ 1949.893846] [   T3930] RIP: 0033:0x7f789a2e195d
[ 1949.893849] [   T3930] Code: Unable to access opcode bytes at 0x7f789a2e=
1933.
[ 1949.893850] [   T3930] RSP: 002b:00007fff900de298 EFLAGS: 00000246 ORIG_=
RAX: 00000000000000d1
[ 1949.893853] [   T3930] RAX: ffffffffffffffda RBX: 00007f789a1ea6c0 RCX: =
00007f789a2e195d
[ 1949.893854] [   T3930] RDX: 0000000030e1eef8 RSI: 0000000000000001 RDI: =
00007f789159b000
[ 1949.893855] [   T3930] RBP: 00007fff900de2d0 R08: 0000034b66d0deb4 R09: =
0000000000000001
[ 1949.893857] [   T3930] R10: 0000000000000000 R11: 0000000000000246 R12: =
00007f789159b000
[ 1949.893858] [   T3930] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000030e1eef8
[ 1949.893862] [   T3930]  </TASK>
[ 1949.893864] [   T3930] BUG: scheduling while atomic: fio/3930/0x00000000
[ 1949.921679] [   T3930] INFO: lockdep is turned off.
[ 1949.922322] [   T3930] Modules linked in: null_blk nft_fib_inet nft_fib_=
ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft=
_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip_set nf_tables qrtr sunrpc ppdev parport_pc parport 9pnet_virtio 9pne=
t e1000 netfs i2c_piix4 pcspkr i2c_smbus loop fuse dm_multipath nfnetlink v=
sock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vs=
ock vmw_vmci zram bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs =
drm nvme sym53c8xx scsi_transport_spi nvme_core floppy nvme_keyring nvme_au=
th serio_raw ata_generic pata_acpi qemu_fw_cfg [last unloaded: null_blk]
[ 1949.927935] [   T3930] Preemption disabled at:
[ 1949.927937] [   T3930] [<0000000000000000>] 0x0
[ 1949.929254] [   T3930] CPU: 3 UID: 0 PID: 3930 Comm: fio Tainted: G    B=
 D W           6.15.0-rc1+ #22 PREEMPT(voluntary)=20
[ 1949.929259] [   T3930] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[ 1949.929260] [   T3930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1949.929261] [   T3930] Call Trace:
[ 1949.929263] [   T3930]  <TASK>
[ 1949.929265] [   T3930]  dump_stack_lvl+0x6a/0x90
[ 1949.929271] [   T3930]  __schedule_bug.cold+0xd3/0xfe
[ 1949.929275] [   T3930]  __schedule+0x4164/0x5fa0
[ 1949.929278] [   T3930]  ? __wake_up_klogd.part.0+0x79/0xc0
[ 1949.929282] [   T3930]  ? vprintk_emit+0x185/0x650
[ 1949.929286] [   T3930]  ? __pfx_vprintk_emit+0x10/0x10
[ 1949.929289] [   T3930]  ? __pfx___schedule+0x10/0x10
[ 1949.929291] [   T3930]  ? do_raw_spin_lock+0x129/0x260
[ 1949.929294] [   T3930]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1949.929296] [   T3930]  ? do_task_dead+0x93/0x100
[ 1949.929299] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.929302] [   T3930]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 1949.929304] [   T3930]  ? rcu_is_watching+0x11/0xb0
[ 1949.929306] [   T3930]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 1949.929308] [   T3930]  ? do_task_dead+0x1a/0x100
[ 1949.929310] [   T3930]  do_task_dead+0xcb/0x100
[ 1949.929313] [   T3930]  make_task_dead.cold+0x184/0x18e
[ 1949.929316] [   T3930]  rewind_stack_and_make_dead+0x16/0x20
[ 1949.929319] [   T3930] RIP: 0033:0x7f789a2e195d
[ 1949.929321] [   T3930] Code: Unable to access opcode bytes at 0x7f789a2e=
1933.
[ 1949.929322] [   T3930] RSP: 002b:00007fff900de298 EFLAGS: 00000246 ORIG_=
RAX: 00000000000000d1
[ 1949.929325] [   T3930] RAX: ffffffffffffffda RBX: 00007f789a1ea6c0 RCX: =
00007f789a2e195d
[ 1949.929327] [   T3930] RDX: 0000000030e1eef8 RSI: 0000000000000001 RDI: =
00007f789159b000
[ 1949.929328] [   T3930] RBP: 00007fff900de2d0 R08: 0000034b66d0deb4 R09: =
0000000000000001
[ 1949.929329] [   T3930] R10: 0000000000000000 R11: 0000000000000246 R12: =
00007f789159b000
[ 1949.929330] [   T3930] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000030e1eef8
[ 1949.929334] [   T3930]  </TASK>
[ 1949.939223] [   T3920] traps: fio[3920] general protection fault ip:7f78=
9a2709f5 sp:7fff900e66d0 error:0 in libc.so.6[819f5,7f789a1f0000+16f000]=
