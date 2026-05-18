Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E3371CEC;
	Mon, 18 May 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137977; cv=fail; b=E4Z6WY2Qxc2+RbrFH/6fu/yjGb9bMH2KAM6Q0iUUtHwgZhYAsmmQNjrkzROqCaizFNkGsiVWCH552RMjVi1NU0zM/cZuqO7r54lNmydbTBBUHvHibIExd83CPO12tMAVs74m3HXlBgiwghmG8r8WTerK3cazxXFOeV6WN4eRyvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137977; c=relaxed/simple;
	bh=uUukpZPuffL4e1+WSEFE3IFBrLNqQZlephouQ0c3Xt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNzGa1RO8jIogaEZOyA3khixGG6WmsGx2av+27lMakcYx30saZDbupQH387u8Cm4loaue8878sim4xkmv8zBs3rOAAVv9aMq045JiCO0byJAvPrRrKHhLK+adGhS0hnTeeuQQrxFkPVfX61Q0Xa68e/FI0ekTUbxEUgOPwGGj6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=ynECj26/; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="ynECj26/"
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGdsw01748878;
	Mon, 18 May 2026 16:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=u
	UukpZPuffL4e1+WSEFE3IFBrLNqQZlephouQ0c3Xt0=; b=ynECj26/8ZolaqN/z
	DeAt1oqR72bceZwQB/9jvQ1wlgWBPQAUXP/mLE2NM8oAqkduIU3ohh7hjhz75200
	lcoNw8jjg+hTBeJiwmOzMtltRaM+ateaSXUItxvV0lMiwiMrrl53ArpPaw3OAXYl
	mYOiEE3IQCw7x3WBi0pAOFw4XxHAjwgUZLStB70zPY2W/p9oV522AnfrfAnqfLXl
	qRB6JbQgJPHOCfoTbSi43zhHDbrjiY+w/WQMir/xlhFfF9E6xHHAFvZez6yxmwVT
	piZ4Y+Wzi8pUc7AGJEEkbUOG1ECdruHgjmgfJhx31YESVyTYRH3POExOLYeTctW+
	wN+Cg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e6n8fhtwh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 16:59:18 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IKqF3c2269077;
	Mon, 18 May 2026 16:59:18 -0400
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8a6f82dx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 16:59:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIVMTGAAIu69bt9i59Sj9q6FQaLEeg/+sxHyCCKhteH2QeMaEkQhNaVP2gNsBSdp4iEG2iYcHJZIsGZtSToUy6zXd2mI8z5hGAtsWbgteZfH6pjJMZKbHEhpwdqIPOK1OU+JjTekc+CO+ALTJUveu8tCjPag79Axzrgk0k+4Fmg+cX0ydTvBfjq11zzsUCe3Hgt1jqTVFmHCl8laCnWDPg2JbPuWSJ75RwJlTQ+RNAu5r7hl4uLlA9LYA+rtpO6IKrBax6lbbni/fRkqVJelArY17XKZTrxLi872xwhAXJWy4UEa4vxdQyekY6DogPNTkF+YbLPkAMF0K1GFFyjjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUukpZPuffL4e1+WSEFE3IFBrLNqQZlephouQ0c3Xt0=;
 b=bXXkdaCd4iDW03y9maNq+rkpfzCzOuTgYURh+PYF9YzJ5VN1g8StABc58yb5GrOsvvkquWOHIOCQJj8vKLGBF4uLDKChgCm2B/Ci+wNrZWZespWLKiy+Ll3LeuJKOYJwbEWXERxgS/LpUg44TjckKDgLvMNE5k6Ygz/cUDsljZthgfs1QOHKyFWu0tM3Iv3ZQH2A3jBF3ER4rTfLolVCTru1B8wjE8QHVSfLRdD19HEOIKd0Mmm3i+Fa8B1OewPaMlDuUT5Hq32VPRXAMVQlKsbPQLPab0wAh4lJZJZTe4jvuKoKoHEMX3Jh4cshmeSQFP2JHpd98Thzx69wqG3QrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW5PR19MB5484.namprd19.prod.outlook.com (2603:10b6:303:191::16)
 by BL1PR19MB6081.namprd19.prod.outlook.com (2603:10b6:208:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 20:59:09 +0000
Received: from MW5PR19MB5484.namprd19.prod.outlook.com
 ([fe80::88b9:ee8a:d884:49ff]) by MW5PR19MB5484.namprd19.prod.outlook.com
 ([fe80::88b9:ee8a:d884:49ff%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 20:59:09 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: Keith Busch <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Topic: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: Adzm1dy/Cx6JquSnSUq/8UuX73jm6QAJeqaAAAMgw3A=
Date: Mon, 18 May 2026 20:59:09 +0000
Message-ID:
 <MW5PR19MB5484B015B6B1D739D8C5CA2FFD032@MW5PR19MB5484.namprd19.prod.outlook.com>
References:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <agtnJb5a5uIqH-65@kbusch-mbp>
In-Reply-To: <agtnJb5a5uIqH-65@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-18T20:52:50.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR19MB5484:EE_|BL1PR19MB6081:EE_
x-ms-office365-filtering-correlation-id: 565781d8-a6a5-4004-86ce-08deb5204e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|786006|366016|38070700021|4143699003|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 oE8BgdNaVtDQXx/TUsn1Vo9qiR3lF8adhfXgI+xjlsOGSljh7umYux/rcdFpLVaFYpH8e+P3NVLVl9FsbweXxExaKMe5cjzNsmVQ+YLozqs3RGiy78FkgbC+rdIse56X0XNa1EMonYe3XnL0Yp4cFQxjsFgn6a6ulxr3+9aTUsVlEd6CdDcuANQ+stFmBFr7Yu0iinB8ocZ7M0ufreAl7fmuzjY4qdwJTu4TCrD/b1rP32UWMY/pmYdFgKp0VOAE2+rA/w/5OHq1o1+a3sjkDvCGV9YMkQlHe1WAJvAneO1oXGA2VcQsr82hDfvYXeuZBaOjiFv//ZKyKVjVzx9KUsFc3e/QmHhwTsteUNZ/XdFPoJHqOn4EkfgT8tIqhy2uuUyrILntTXpytwh0FM9UtjDGtxxMtzbEtIoIbly/9YXpfRYwLYu8Y2s5YcsynwH94lq8a3r40BP5SalT/+7I3h5XZTAE+aCVPDmRjhcUQm+HD+ykla+rf7x3E+fSjGfXIWuR1Yol2iWbDQBlxuwRofj6NcKDSc2Lw/oasbaK4+NjCn1ru92ldskEmfPN9Quiy2zr/5BGvP72wGrpxV0yEkRarz2ZUmZJvi4GIZk7suRcZNu0pdMWZeFKu4yXNtMdOeHbFWh/he/UgLjiDdxEiVLPhsGndZijX9HfJtA2bbNasR6TXm0VTcdsEgPwgpH4h1fupdUipT3ysIlEZ8s/lEBMZOoCOb9gPXSbQqFCARa7ikB02KqI9nJPGW4YZwDv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR19MB5484.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(786006)(366016)(38070700021)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HY5eEI3DvAKGooR+bH4h4wAgWwhSjP0nd9lVKxKdXgmkiINFkcWA7RO9Dvh9?=
 =?us-ascii?Q?7lHr5H5fwZceh13DywSIitonECMjWowoBXaYcEvafIoHeawPHPsGOxfu0O/u?=
 =?us-ascii?Q?xBkm/PyWNk8IaT5dSu4ZLZC01FFlWGtyRJjEAbwCEjvbyW2xRPQRe+eVBy+h?=
 =?us-ascii?Q?SOQTeP8O4vgwdAFmM2+S+1CwL3xH3Ae7BejcgCm3zS7hlQSUXr1/OrFeO4j7?=
 =?us-ascii?Q?3WDuyKfPt9gTOhBlmR60mx8I45RueX7C/0JqyaBfhtc5BIoIzFx7oaqFhmLb?=
 =?us-ascii?Q?7ch5oDgqoGJI+eH18fDlw935Qa/SE+Np+eBu5cJCEKp69USHKpi7BM8bQ8Tu?=
 =?us-ascii?Q?1XN5pHIdQ17zPSkb/VsGflXIKOdudpeO4V01UQ/G3q5EZ6tt5kMafhbe0OpY?=
 =?us-ascii?Q?6onXRWwcaDGLVrUZmFRcy5PzCKbCTAo8Bpti5cEEzK5SW3el6bcB3FgGglJU?=
 =?us-ascii?Q?hUvqbrU0STcMDcJt4CPrXy4RsYFPU9Lr2mGVYrPCA7NXeypZmXAjsTXi4uuy?=
 =?us-ascii?Q?gBWbTCqojptCiP1aTYAHmjZzO8ooaeMDS8FlV2tFttsuOH/6vyS66Z7/JYY0?=
 =?us-ascii?Q?G4AG7CQgY1A3lKHU7pp4U5TTXA1gWQCfu9chZjv6uIC460/FatI0cH11RSdZ?=
 =?us-ascii?Q?QmZu4Cug9ae/T4yhN2lPCJ/eCAPOEocoUdGNuvi2b6roOccdmNxws0UMgbLD?=
 =?us-ascii?Q?9+GBhhBW6GNR+CvXSTuNC7/lA7bS40TBxzcd3PzEXkjyeQgNBiqS6tkZrJYw?=
 =?us-ascii?Q?BwCyV3b4pGyPkADd1/ubnt+qStN3MIg3IR7yWI5LiEnhzF/ecWgsvbMg3kVa?=
 =?us-ascii?Q?GzQnsrRp1xHLSLs4Eb2gcnlN1jgvXHHRsUS0oC1Yf0QcdA6huc5lUdyOXXCi?=
 =?us-ascii?Q?ghvUhyzd8kWIwMgEuFg0Vla0e78xQ5kortN0RFxsVGeXLp3g1XUuTqMDkFPb?=
 =?us-ascii?Q?7x/YI6qJC9r14RsyAs0AggDnfkskz/wR/S5KjyBcxsP6no45Vjfm1VBtBwry?=
 =?us-ascii?Q?pqPfJdphQyH7t8cGrFwZR45EqymooONUfxsOC3u6YZ+rxm1FiwZ7246k4ig4?=
 =?us-ascii?Q?rqby/G4u2KzOplq2p6NgpE7QCjpvNiOxNFOurm0449Dw+KUUmZDBHc3RY9Zg?=
 =?us-ascii?Q?3y4Qx7hiE1/9l82MVnV5dcb1DYdw0iRbA40+5tObKB742+0QCrabxidZa7TC?=
 =?us-ascii?Q?WwX3/idgYUUa6oJgkx0Rn0q9Ch0Wz1C+RZjYR38eNVnX2GY7/dlwcWGpnwBi?=
 =?us-ascii?Q?9aB269PjzjxneYefUXMdAJY46sqSGsdbu3NIsUwNWuYeqmUJNA+mb5itmrJ7?=
 =?us-ascii?Q?TPXomlTait9rq0uwvf02Ln9NeLut0YYnYtFPA3FrQCBcj/cd3nNwrg+WxEjl?=
 =?us-ascii?Q?BAhx48eP5IwGVGv3fgG0OkGHH80+HfnHbpRCP4HtOxQre323TnB1o59rti3N?=
 =?us-ascii?Q?HoVo1e/MtqN+fiZtI+vOa/fDafnOehY+3U3SSAwRBFAXbswX/oYc38HqIhjI?=
 =?us-ascii?Q?civTXR5wsksRV0671fc7MbJXiuoQ0sCRX8FVjVMesinymYnMz7TjdtLptOwJ?=
 =?us-ascii?Q?hPTT+VrRjYYdo9Icn0EPrdzf8LO2doBgEc10pNa31nSa9wrBJZn7hvkLMjMR?=
 =?us-ascii?Q?Gi+lUuejHyrB1kaECPsO9QExlx8mcTOqmnWeuHIEKzcvB4ZvJCGJ35Fjvs+c?=
 =?us-ascii?Q?AHerpyrC1hipNuEI3VzmObctzSOl/yukwL7uxbhfq9cuau28euBsG5VXez/k?=
 =?us-ascii?Q?EMdRl/LhEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	E1pc/T75dn0wAcIWc0l7cfVluvCW+/nhAPa5AYpwIsm2/Se0h/ztFEEgbogm6YY4LhR6zoqqZZ5+YoIvzSfnp1wrSPKLOWFlRHDiRvFmXsqC0wpykcTTULgg5JFoca1T31d84T2JpjDwUu5XE4QJjrK1igs7CnaSvPeI+PvMKgfB/K6uTx8/c4Pc+4C2j10HGuB9RDvh5BYZen0xPGQ8FVPlaeHc8bP4bbNdCea5Nf6cUNc95R7UReo1N8njau7mUZTR7nwWrT4yojyYl1c6SX9N3exRMR2UVSSAw9dV+fmOAeRilNqRUfFvcZhNjstUXheloS2vGGTVJ8C8Qi97LQ==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR19MB5484.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565781d8-a6a5-4004-86ce-08deb5204e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 20:59:09.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4qMqPXjDmTOHEw+qRADTWqAiF0dyJ2MQXT0Yd6+z/YuXrtSigop8+I1qysT2TqqOMZsphtKnfIDfRaAcXbN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180206
X-Proofpoint-GUID: Xl-LEXIW5LrKvo-TrMsn0F6lU-f37FMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDIwNyBTYWx0ZWRfXyhzJDDIXTUjA
 d9802PmVhK3t+HLkFm9oTRbuavLSjp/P/gPTgnPCZOZB/O2yUEjeBQzrSv6xJUuSzMBYTZtrf74
 iE8B5PRjQbYnaZJWHKtQ8Izv+teJSD9rTUb0Hc5045KQeGy+RmCMR8JLdbOO2eGOEMMNXw8hg/m
 AYz1K6JB14CV79wqnSH/y6quEymyLW/kTuhNxbgbgW+dzPD0FG6uuSo8AAUGlsaQtbFXzcBY+wJ
 3w4exmP635YJ/xVgqcNcu2TTZcr8qiXssSxRYfpdxC++2lINNW0HFgcrZkkDDQ1bNlupo5YQ98O
 0xoAiZDwtXMkXGn2W4FOEkOu8k0o+GWaS5+MV+r/T5MkIbDY6OY6fvz7gVMyVqzjtsObqTwlpvE
 5NqHWUhAuKFmwG092ku0egkBGhCO6sxPF+cjFSLz7dwdUU2rsNcIBtgr5RYq0Y9ZKemTBkcFjS9
 mtGzaCkxt7sDCBK442g==
X-Proofpoint-ORIG-GUID: Xl-LEXIW5LrKvo-TrMsn0F6lU-f37FMA
X-Authority-Analysis: v=2.4 cv=TZemcxQh c=1 sm=1 tr=0 ts=6a0b7da6 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=Qy6CKLcU0MZ4grw4BCWD:22 a=qEA9knx5ggU3XUQVk3EA:9 a=CjuIK1q_8ugA:10
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180207

Keith Busch wrote :
> Any reason nvme multipath can't call submit_bio_noacct_nocheck()
> directly instead? If it's safe to skip the eod check here, then it
> looks safe to skip everything else too.

I'd prefer to keep this internal to nvme and use BIO_REMAPPED rather than
switching to submit_bio_noacct_nocheck:
- submit_bio_noacct_nocheck is block-internal and not exported, so using it
from NVMe would require a block-layer API change just for this.
- it bypasses more checks than I see we need here (throttling, RO, crypto,
op-type), I prefer bypassing only the EOD check.
- BIO_REMAPPED propagates to split clones, so it covers all resubmissions,
not just the initial one.


Internal Use - Confidential
