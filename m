Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61326F28D;
	Mon, 18 May 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116008; cv=fail; b=t7dp1wLF/VWib6dVUbtMSKw/SkrB2CF2XFxe4nnvNEsOni3bi8cI9Q5sugE+oyKBZ8ei0o2IdcSn9eU8/bFW0ubVsk0vF5qi/3EjTf2fNHJMh0pPmN4X+ae8retgmFhdR7EE8gMZdU+5MhHgeOyWSzebUZ5EyPm91+6UKxHTR1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116008; c=relaxed/simple;
	bh=+6h8upgwWBIqnXKWSyMaQ2OV+yD55CQkV5Cy4uuDbP8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HVqe29IJEdFFRgpCTKVytZp7gX03QnjruH47yUtJnVFdOMBRFVWLCjyfUtwekCMn9y/ADE0F+MLVz1LfBnh/WJg3liHPSr5xvm8ivBkS4b4kXvZW34mf113dP7bqRKYbSXPhfaUcrHhh6zn4NHJo6YC7mgMhByVlAqY9BA++ACo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=J5/P3kon; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="J5/P3kon"
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I8rRE92769914;
	Mon, 18 May 2026 10:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=2XEhqJmsgrDFlLug1XaoTO7
	gc/D2Aupmoge4tAv0cU0=; b=J5/P3kon/OGHwNg948BsbNIuyOAEfx+R2YBz/Zu
	irEO4liQ/OfMy+ZQmX9Vp8pd4ReESkwpeOma7Qw4aJhjR+ghDlhutL1v6+iAUDCe
	lrKEDwxSJUBEhiGGLvaMe6XQ2RL/DBdshKn0oHsgaEKC1HXGzKu7r5rTEN1+ApmM
	2pIDTQRCuxx5y1QySAfYReo6crXKxrtINsI/EIlfnwVNDR6IuS1ItvGtRZp2XL2U
	Z8NrbsaL2nQaQmlGglzgD0OT6NCQJt1peeCaGzeTEEvfn3dZuiRGYfQcZVeHjgRG
	RWxn0lCcPipAcInQxuYEqrUvk+PgV+Bwe7Phl2VYhDsdHYw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e6hnmr9dd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 10:53:02 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICTjh23993822;
	Mon, 18 May 2026 10:53:01 -0400
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e829atwgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 10:53:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr+iwqx/3M2rMNgHqwkA6SWs8kNGjChJsdPgDS21Yr41biu+KS4HeqS553Ex8S59VvvKCF3axycGnF46WhT9wT1N52rbjCfPGeV1qUPjb3iUyvSZOi6KjhvEs4vXOF/8ptTJXbYqp6UdctWkC2k6lkPTAM5ZTfLqW43GZNGo34paiCIF/69JcKHqlj8j9KyulRNQ6VcnYPc5oQfWdh87Sd3waB685NmlPaHhl8eO4PYRsUGY8DNeAUiSJb8MJnuOPoRNWXeVkY5lGX9FUTYrS/eYL+HZsEYbE7h3Gn2c+GEtiWexs7GF2XuQ9XMjk2qjC8Hx/wLeQdHvwAdXYfyXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XEhqJmsgrDFlLug1XaoTO7gc/D2Aupmoge4tAv0cU0=;
 b=ck4KT5MG1mw22suZvP2NtPT6boF2jE/VCyQXabO0qqq42LliSnpBpnJPy9WbcWM0KW2kAVSqMW0Lu1UcgZbk4ASNw/T41rsKiIyT1i1mZuKpX96VW4VGNJlJekcm+biWo2lFV2v00ye4TmNzDDwYmfFs913t31u1G24CCHsJTn35lblbLLjrZ0XJuvXECFDriR3aMj0uK256G+Bu7ayWQ8KEkGWbnCyZUOmZmExlg1V9VKtu7PdS8CoxeYhm7twTPRwDyUM0S+HvtdfFJJNQsTBC/wTe3MitvOQMdV3GIZ0+6VRw6qKGboIYc5HL6XVKKwjaGlVXBLe/v704Jm5NRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW5PR19MB5484.namprd19.prod.outlook.com (2603:10b6:303:191::16)
 by BLAPR19MB4307.namprd19.prod.outlook.com (2603:10b6:208:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:52:57 +0000
Received: from MW5PR19MB5484.namprd19.prod.outlook.com
 ([fe80::88b9:ee8a:d884:49ff]) by MW5PR19MB5484.namprd19.prod.outlook.com
 ([fe80::88b9:ee8a:d884:49ff%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 14:52:56 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Achkinazi, Igor"
	<Igor.Achkinazi@dell.com>
Subject: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to per-path
 namespace disks
Thread-Topic: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: Adzm1dy/Cx6JquSnSUq/8UuX73jm6Q==
Date: Mon, 18 May 2026 14:52:56 +0000
Message-ID:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-18T14:50:42.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR19MB5484:EE_|BLAPR19MB4307:EE_
x-ms-office365-filtering-correlation-id: e47af3ec-7068-4b38-ae94-08deb4ed25d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|786006|366016|38070700021|11063799003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 c68HO0UYOAN1rNk/knbWGcC3H93engg+rdULYuA/jKoc3UZ4JpTZsrY8L7zJTVG3QVQsiA2krbQi7quAt7WsYqajbBagzE6rjIlMUaxt0PZB4LJo5rpbySRLRrheZv9zwAHhXaILD801YT3CfQRs5fUN3DNaO9a/BPODd7BKA5mAs4NV5328t17SeilL4yX5xzdqsWgCqiX/wznGTbFW2bBU9Ap55K0WCQLW0FDXrl2I3Ih9BEQ9YBRen3EmWeCM5PdNUHTv2FLiCoXLLotCmX9gAIRVp2jJNAhSVq5gBHHed/fSE3C52KHU7yyhJd1WKqBh4qXbM/fukb0iop5e/0o9OyKo0h0Gaghvx6IooNaHUrmYteinrfPlGjccGu0SbQGGlUzquPeQqwWAfjmlrkGWxXunL+Yeyy7GUlz79HNflgPfHsgzLrdjF/mNS3G3MjISzxy2670Rcr4BLOpeJhQI6BUrIvrBAhDipJXz20oSDQqbPgWqSkdhT6yUMiyuO1CmvAaNG462ZtU9vFDthODrdrBjnAYK5fS4niTA72FRaw49C4Z1hCmkTleKRBMR1spwhfeQhNC9KnXXEKOz0PrYZqIypFrDkw3ISwFdPVxesCknbQMCbX8ybERiL/wR4ImprEgxZEE+DfLPlgUiwu3BazR7svVHxftwVDpTBp3Q+3tXW5zfw1pPePMWi0aOb3yXOimPjEKIOAz13uJZ3bCK28rOU4WJ4Wwbkx1o00AAa/RhiLBsN/r2xQBUmWP3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR19MB5484.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(786006)(366016)(38070700021)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dpLXtEtke6UtA3VD4IMqZn7KBn+dzMLosECF35pevkOHLsjnVN2m+U41wfDi?=
 =?us-ascii?Q?ruBRzShIR0VR6sDB9caAHhxWTOu639p7/HEaQqfvF9NOxK7SAucMAIEfLmUI?=
 =?us-ascii?Q?OMaOjCm8WM8jT77Q0SJn91p/1JFR/kGQhZzYeJpu8fQBpdG7OlAxM23iz9VA?=
 =?us-ascii?Q?1Spxs4+6NZC3+gYtkpBpa+bz3CTldJVkL1p/HwfFAm3dpttLMdgw9gPyi28n?=
 =?us-ascii?Q?25KbD+boEkLXdWUlxmPMPSeq87vZzFdVZh8SjM5GZF8pt8/pExcoPv+MBL+D?=
 =?us-ascii?Q?8deBoi1rZAr9Xx6Pve/aygDxbnRVclqiT0yEQ55OH58EEJp/NYr1k1mIJfgz?=
 =?us-ascii?Q?ck4n/hSEAWvPm31ckviB32YPAv0X4nH0UL2iFFc09oS5z8RwEMKa5HLV3rL8?=
 =?us-ascii?Q?W/l9ijVqlHpjNC396Cve+ps+7Dj0XlHTUp4NygX7qYAS4mwlRBy5eyVyBRAc?=
 =?us-ascii?Q?vp7TMJvmB0Y2gju0GgdBaweXoFnTpX6EiJv53aOdSf0a/mI3vGSvFCv54Rnt?=
 =?us-ascii?Q?IbXzcqVgNHgXcvkwELQ747Yv2Wl/xc/1nR4mhcTbMJ8esTu8M8n8h70paSJA?=
 =?us-ascii?Q?gjQpg/1Ooehvz2uWeNCEPf/DhA3IT4mts46QSUyg3hpINbAZP5hGSTfqp1oB?=
 =?us-ascii?Q?mBz8uLvmkQAz9GsLLfwzT3TSNHY4j6DwPQ44RmgOPvatvdCJwPJMBdKllozA?=
 =?us-ascii?Q?tzI/z3WWAvU/PSIid7lZaZSaGKuOa1aVMqv0prY/hvk4Ugs8eOSbLzkHv7Dy?=
 =?us-ascii?Q?Q9UtzMUjQRVUwtN6KCV0fFamHD6edL6F6CEFsMju39zHQHsgdPBYrvuqNVaW?=
 =?us-ascii?Q?eSi94PhV/nNQOPri58ZXSCZyOwZS6I0F50uItleStRBMnfAaEM5KKqRSt4A9?=
 =?us-ascii?Q?sOLPqrvJhQkS5uyNrbHMrTrsiwxjgVhaw6i6yWOoNLzEAgtJee1BniOniE5l?=
 =?us-ascii?Q?VaTs84gCR870ldPO2BxG48dd1szkWP6T/Z/gA4xgWvlHTBoTIu8LiOpoK67e?=
 =?us-ascii?Q?Gv6Za0xM6xH/eUXWCi77I0I4tGvMl2upz6WG90+DQhogBZfxQfH6spL26rz4?=
 =?us-ascii?Q?jojXE/e5iKlaGjK1Rwa1bnnLVglcq273ThxQZVBQ8mX6r4jRg3nkNjik8/6m?=
 =?us-ascii?Q?2K1yQfQhov0rpqyz2qaFQA5bEAjMREWxca4FvuvwehDZp6/TQfzvq8xcWEOQ?=
 =?us-ascii?Q?bUSGrafuR+euRvW4FD2KIVMhEONQeBdVzvoIHHdzT4jRltgJXQv9w/2MGPxt?=
 =?us-ascii?Q?hgNe8Q4i6VT5bOVX0p3SpxzTbFdEizsWMW/HrZv/IZ31Z1u0L8N8SutLopus?=
 =?us-ascii?Q?rIe43b8qH5aOhrl/Db1Sesh56FkoqTtgn+PyueZaGHOXnMAlC3hgsOFI1H0J?=
 =?us-ascii?Q?3F49wyHcafLhZA1CcEVfYujn8y7xE9flgr8w8iyYcFrlrQPpFRa9U7HdRZKR?=
 =?us-ascii?Q?ns4LdW7uEU2xwu57OA1zrfSwWjAiPq+ooxW7ihKSAGH3Ywsel9guThYL4lux?=
 =?us-ascii?Q?CNnoLRxkSlQ1y+/cwcYN5cl0G+AkOLDk6vIhejMvcGhA95u32EkLz0/bFRJx?=
 =?us-ascii?Q?9EcpVza/45E06jmFMAnRCu/98Wm8FLSWM3N7urzXDdkf/Ds8fB/ikUCiXK/0?=
 =?us-ascii?Q?1nwdGemUXSc39XYJwE1bJuLydcGlb5iHfqgFrtIhL4xk4MqydySs2Q6Ct8qn?=
 =?us-ascii?Q?5emBgLqKb7Dld02cLtyTO20QdvOslB7Qw5T4nu2i4ojrczoGz98g55aD6NcI?=
 =?us-ascii?Q?FDcEWaGFcw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PG2N39Z0kJsDngIwtR943Xfw9bxwlkMZo1sefPeMiwXuTAxgkmrWTzMbhMzSY6NmJFE06SpOEqlQ1p6jcZtYtUJFh0GY5t0P9ZsAOmqqhc3G7G3uO+ABmZ4Oo6TgvdvztaN/77IFT50Kl90h59//YFKZ2qt2swVawmyJO75kYWv3lpij1YrBYkb0FsKm+Mz7NMR3S3PhbSOpCbBIv0wi5eTK95fDWT1LwxIOwdW/4gQRIvFifNkPKx05F+RnL+a2XtwPPX90doiCzKS6nuAB0F3K6TPWavYKHOrdrNHKAzONH5Gexp47JCGQ3jEckHmKV4wz9CGWzq8AgCNQs8NCYA==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR19MB5484.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47af3ec-7068-4b38-ae94-08deb4ed25d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 14:52:56.8169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihqn/AWL1hvwm/RPv+v5pLCWTLXjj7HZNQKKftnPSnYGWx26epMvBQory2ogclWbWNhnRw1X6f7Cljwvf/Yrkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180146
X-Proofpoint-GUID: dtcLSzU2gOsIwgj8wzeELR3gnJbMIJbO
X-Authority-Analysis: v=2.4 cv=VJLtWdPX c=1 sm=1 tr=0 ts=6a0b27ce cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=U3ti1ie9CgboSd2qXsAw:22 a=VwQbUJbxAAAA:8 a=iLNU1ar6AAAA:8
 a=n8P0Md7YgY-1yq5sWS8A:9 a=CjuIK1q_8ugA:10 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: dtcLSzU2gOsIwgj8wzeELR3gnJbMIJbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0NiBTYWx0ZWRfX4aBmy5aV7aUO
 BK5UZA9+pP/ESkH0nEvYl2CYJ2E+f8Tq8INK+UjM8bwofBx5Ke0kP7Hnp4JKGzHjK6uatJRQv8B
 aK+Xp5RXPySdi+C3kMUeN2W+1eV/tDIkGm8InjVovz9vZNIq3dGj6pXlx9rQ014zI5+Vpb+DjxH
 uagWbeRPGv3NMpsxwrOwHoVKhQBZxvpnrknVRism1jD7auCdYHdM7cpjKfFPMvZWvJ/1l13222w
 OsbV3+HfpqaDKazvFbaVGySN3mdh91N6bgz593QuF+wkqxXK2M7cFUbTRRxFmQX3INAtv+dy/df
 e2ZqkkTShQIP7qBs9ajQM/pZ2IF2WBgCLuajA1mBYtBJfGZmCU6QDYNqD7Zs8bzbf85Ez6rWkfl
 eYBzn5lwe9rAWPRaRE0McnCQBbP8d4pHilTyPbPp9rfqp3Dv3Szj1ZU7LIVZD/lgL5K/orIcDlJ
 Eqazwn0hLpowkxyVcMA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180146

When nvme_ns_head_submit_bio() remaps a block IO from the multipath
head to a per-path namespace (path of multipath), bio_set_dev() clears
BIO_REMAPPED.  Before commit a7c7f7b2b641 ("nvme: use bio_set_dev to
assign ->bi_bdev"), the code used a direct bio->bi_bdev assignment
which did not clear BIO_REMAPPED.  The block IO is then
queued on current->bio_list (deferred, not processed inline) and SRCU
read lock is released.

The deferred block IO itself is dispatched directly to
blk_mq_submit_bio() without re-entering submit_bio_noacct(), so it
would be fine on its own.  The problem is when the block IO size
exceeds queue limits and blk_mq_submit_bio() needs to split it using
__bio_split_to_limits().

The split remainder is resubmitted through submit_bio_noacct() which
calls bio_check_eod() again because BIO_REMAPPED is not set.  This
sometimes races with nvme_ns_remove() zeroing the capacity after
synchronize_srcu().  Result: bio_check_eod() sees zeroed capacity and
fails the IO with "attempt to access beyond end of device" instead of
letting it fail over to another path.

Observed failure scenario during tests:

  Setup: NVMe multipath with multiple paths (e.g., controllers nvme0,
  nvme1) to the same namespace, exposed as a single multipath block
  device (e.g., nvme0n1).

  Steps to reproduce:
    1. Run sustained IO against the multipath head device (e.g. vdbench)
    2. Delete the namespace on one of the paths (e.g., detach the
       namespace from NVMe controller on a subsystem on the
       target side).
    3. The IO that was remapped to the removed path and requires
       splitting (exceeds queue limits) hits the race.

  Expected behavior:
    The IO should fail on the removed path and nvme_failover_req()
    should retry it on the remaining healthy path.  IO continues
    without errors visible to the application.

  Actual behavior:
    The kernel reports IO errors to the application.  dmesg shows:

      IO_task /dev/di: attempt to access beyond end of device
      nvme1c9n1: rw=3D33556480, sector=3D476160, nr_sectors=3D256 limit=3D0

    IO errors were reported to the testing application, causing
    it to stop, despite a healthy path being available.  The IO is
    rejected by bio_check_eod() on the split remainder before it
    ever reaches the NVMe driver, so nvme_failover_req() never gets
    a chance to fail over to the other path.

We observed this failure during NVMe multipath failover testing at
Dell, for example, on kernel 5.14.0-570.23.1.el9_6.x86_64 (Red Hat
9.7), kernel 6.4.0-150600.23.53-default (SLES 15.6), and others.

The fix is setting BIO_REMAPPED after bio_set_dev() in
nvme_ns_head_submit_bio().  This skips bio_check_eod() on resubmission
for both the remapped IO and any split clones derived from it.  The
EOD check already passed on the multipath head.

This is safe because the individual path for nvme has bd_partno=3D0
(NVMe per-path namespace device is always a whole disk, not a
partition), so skipping blk_partition_remap() (also gated by
BIO_REMAPPED) has no effect: adjusting bio sector offsets from
partition-relative to whole-disk-relative is not necessary.  If the
per-path queue is dead, it fails via GD_DEAD check in
bio_queue_enter().  If the per-path queue is still alive, the
request completes with error Invalid-Namespace coming from nvme target
and nvme_failover_req() handles path failover.

Same approach as commit 3a905c37c351 ("block: skip bio_check_eod for
partition-remapped bios") which solved the same problem for partition
remaps resubmitted after bio splitting.

Fixes: a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Achkinazi <igor.achkinazi@dell.com>
---
 drivers/nvme/host/multipath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..04f7c7e59945 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
        ns =3D nvme_find_path(head);
        if (likely(ns)) {
                bio_set_dev(bio, ns->disk->part0);
+               /*
+                * Mark the bio as remapped to the per-path namespace disk =
so
+                * that bio_check_eod() is skipped on resubmission (e.g. fr=
om
+                * bio splitting in blk_mq_submit_bio).  The EOD check alre=
ady
+                * passed on the multipath head disk.
+                */
+               bio_set_flag(bio, BIO_REMAPPED);
                bio->bi_opf |=3D REQ_NVME_MPATH;
                trace_block_bio_remap(bio, disk_devt(ns->head->disk),
                                      bio->bi_iter.bi_sector);
--
2.43.0


Internal Use - Confidential
