Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74372853E9;
	Fri, 29 May 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018370; cv=fail; b=n9JsHGHvTmdGkLFX98m5o+6FDS7J7roOJ9e3kA4AA8Ax6ftWx7WQKQ9/igxknns3B4r1pq5DCF004+cHLGubDXwr8W3p4dYXCL0bJqMcsvIyfbsqVxQ11rIobG8YjTKyHbeJ2xMuXe7/MnCzCK6YWXIScH0aZjahQJh2Itl2FlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018370; c=relaxed/simple;
	bh=r0h1KfcICwMF8Wd0wRHvAHhByidy4bruf9kaUzBczeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WaNH+PA6xArZC8YI1HvTVKlwpcEHY21XJZ1+tZqbdHmQXh+KpeDaf9sfsP+/s59rHThxbWZbgnCS1ec4oSTtNkphTj25E+G0TlT7U16ngzTzzOufkzOaipqZs6L+KNiux1vvOL+TVpEQUza3O4DRpmQ3s149DO2Sh2yFzfg7PJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=F3fxYxXS; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="F3fxYxXS"
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SIGae61340685;
	Thu, 28 May 2026 21:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=r
	0h1KfcICwMF8Wd0wRHvAHhByidy4bruf9kaUzBczeY=; b=F3fxYxXSczeH0eeu9
	283pa9No33f+N3RaR+RqgxU83+gewwpqabv7jp/xKkdbki950LeoIO92wbThF1Qr
	8ykh9zm0Pi63odjkd1YFszSaSc+v0U76JdWJkWwfOKLBBcL4xwTScIOvQtTvk0bP
	Iiou2YWUTbxx/5hi2/Zyh/q5mzZZfNqNaJo/l06i0V64X88snUMpkEmRfajPurYW
	EwKQuaVf7GNSWqYWe3EviwRT/rYKAziv85DKxG5Sl8xHoCdLfBw4F5zgcLU2Ucub
	DT3iBgg8aPEw7Cc0HXAi9wJHYu6ofJsrMQvmob5MLg5IwJ8V/GorW7KftKJ1pi8q
	a3f7w==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ee7yjdm8m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:32:28 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T0XEKS2930070;
	Thu, 28 May 2026 21:32:27 -0400
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4eesafxjm8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 21:32:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eof5debkI0Q1Ap+AD/8ScDCiFEr5egMx9B3jbq7yv0UP5elNFFCZ5IV6EScDK5dl5MVwz4m5FxoW9SqjuuGisaUuM/UguRlvkf+9ChTodJaJnVXUBBGLDANt+yEuRTwB8PUY45+09O05aud2efOUGFdpawNiBsLzwstg6CUnd1BaUNO6twN0/6pNjIpeHgREOZGYl/swOJR3EN8YfHKmrQGKIcXj6JgOg0qYHvFeimFWXIHZW3VPvau8PxJw3EWNR1t6GuVM3GxWr1Frs2+DTaBBW1gq5sWGFNDqv6d+HHXQWRsWHXNWSk5Sy9P6k1SxKsP2ar4s8R707v4dJR+YWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0h1KfcICwMF8Wd0wRHvAHhByidy4bruf9kaUzBczeY=;
 b=DvDzGdO4bKEM0yu9IdqX/+HFmO7It5PMCVaoMy5BIzk5XQAffsccIdeydS8LTIzlYNlScD4VcZ8R0+OJPryBnWF0ykcf/HlW+yJ/Jnnb2PYVGnUfzhazvStBPz1O4AfLpIov5QV3dnjJuwz4d0T6WDBFEiq0JL9OoyCXzAvd90fWrPEtkhTbyOl0uhYuFb+9Ay+4YZ5KHdCOayooPrR3IL0HsEA81Ro6nyqDyxtzqqhHm9uu9a5dLdoqPLbIFySnMcLnKVvvpi9jsyndnbEzs7p8ccC777fnPZSv06wS30x+E6XNsv83O5Fq7eJQ14k7RSg0k9q/okRx13YrdAttVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS0PR19MB7696.namprd19.prod.outlook.com (2603:10b6:8:f8::5) by
 LV9PR19MB9110.namprd19.prod.outlook.com (2603:10b6:408:2eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 01:32:22 +0000
Received: from DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9]) by DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 01:32:22 +0000
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
Subject: RE: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Topic: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: AQHc7rYSFc/wmEX1xUeXcN5PEFcVh7Yjv4sAgAB4luA=
Date: Fri, 29 May 2026 01:32:22 +0000
Message-ID:
 <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
References:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <ahiHIEhsV2zuG5vH@kbusch-mbp>
In-Reply-To: <ahiHIEhsV2zuG5vH@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-29T01:30:47.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7696:EE_|LV9PR19MB9110:EE_
x-ms-office365-filtering-correlation-id: 6d4f5993-6693-4570-01e3-08debd222181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|1800799024|376014|366016|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 wWyarSbKQHkgSXtgv3hG46yv2VbFlXUGV6Sgd1LXAfBkqfv5csY3op3g/3+2NKMiGRlx2Gpthp5ipni1XgSrqx+Oi2GqIdqpM915WIv096NjhJ+DahJtZOPtHhak+R/XHanyqLTsIJas9QKpkGGg9ssFl8PfUc6Up3SHXSVr3heGsBLrzi7H1Bnz7jzPRgkC+FJ2cRayGPCqq5oD6gD/W9Nx+tU39dl/LI41M8qhU3X6q4D4agd0lD91vZL5x6jjZpJ2Yk9x6iF31z33GZ9m8wIiyD8dFS4gXmqxekM+rOfNIB8pLdt551VTIFEaWILyvOKvk+Slvnsl2Cadi3H3ZykQ4CFR8TXTcEsBAyS/Jdl8D4Oa44EgRjuJq420TbpzxsJ8iQ406ZAKtML8eTzCHST7EGpLolwbhxPRBvZSK1yOSUqemD6Gjz/mmWwsximGB2PMkVon8ch+efzTrpIVK7EY0FgnQ0FjEo7u6OaM4mFwqt6G/+tYbfCEwhZuU+mK4ditZ0xiDvk7pKpjQp7IM8nin24j8xkmXvQbZd9sXH2xHQqJYw62zbwYljuoZOTeO40QF7am3Wd9QtI4H6xj3UV1fAqN8PhGzLYcD7LH+rYCG2qKza6v781g5lly3aA7fOVbZXpIXBdbx7PtwIpCKAPMp+B+4zr0apibmKxMEyarpO76JUSRLW42xFJB3ubwtVwbs6KKK8eefGV3BPwNSAJk1bxJJtkKIsx4YFQuKl1c1Fw9tQ96tYHcaUCQD8Bb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7696.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(1800799024)(376014)(366016)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZIq1ohH7ZAZloZtPnO/9TwmQKnDlkkJuF9AXeXychz7xT0BC3CCmzXCmn+TJ?=
 =?us-ascii?Q?dLgq13vCwO4NwaRQvyredA09BEP1b74RpBSg0oWaWklCbsxTz06QmJVnSmx5?=
 =?us-ascii?Q?D/9Jq7Hp0SvqeDQTc2ggOPh+t1WSmjUvksp6Sn/FlsYDEECLqw+n0CeioDfx?=
 =?us-ascii?Q?nV9O9RfqnUTaeeFHJugHYiRbKWn2vO4SQUWttoEx9MM+1KEdFkQUxI9ghTA9?=
 =?us-ascii?Q?SA5jRzrGJlqWxa3HNj8FXYp0upUy5kaUMel+SM2uLrb0cyyl7cuZTl40qi6q?=
 =?us-ascii?Q?/EtXcjsweX+gOvaWv0h1GAnnHRYjj3xt4gLz8KND7q/GM3ezzGHbrwwGyatS?=
 =?us-ascii?Q?XrDrYKj8Qcx9yHAPDqh39Q9N7DtRc3HrDpph4ZR4qs0TcFIaqsIRfyE0Sg9/?=
 =?us-ascii?Q?alGgHtVuQAHx5Ci/XWCB8ZI/u0j0PW1FuCwsh3RtTAr3h+MlRUSErMIRfmGq?=
 =?us-ascii?Q?gWOlnehd/Ro5Zj9D/GrQ9pJq3IWcxml0g09Lv6ugErziat548g+8J4l9yOUU?=
 =?us-ascii?Q?CqJobXYLsutFIHG2uCIhWiBQUHwKKGgCH3AZLJ3EakN5bXkUA8ofPvwKBABH?=
 =?us-ascii?Q?if/08dhjZx5f8Pc5nGAEKUP3kBCIqXkFNHJWOaxv348+FGnPELfd4yXtQb/x?=
 =?us-ascii?Q?N6rt6bbjbck/PxPZFoDbxyjrqFEE1dfn6zzyTalwXQkOmZmbQ8HduB1yPsSI?=
 =?us-ascii?Q?qUUiQ59zmzj9czk1juHwgCRu294pNgBLTDO2h33wSEHGEDAOf/1gMQmwH5zS?=
 =?us-ascii?Q?wO0VLD4IbHYOc6c4iM6pna0RyZBrVXUqcHXwbcxgsA1ukwXO3UYBP/esUCEc?=
 =?us-ascii?Q?gVoeeIUUqsySBJnYSn9//DTUt3PR5b1X8auRy7l4XYpnggb4L73UxB0oy9ae?=
 =?us-ascii?Q?wIvlMwtxtO/SC3q4ti8VyaMHjnxGYfHVzphhlRw9ToUpJXgJZfh/Qg4nQJBW?=
 =?us-ascii?Q?fyoix7t9mbqHiKUN/00CWrQgTABtQxJAtN8BTWM17jHpY2dRJQ0jAVYXEr1U?=
 =?us-ascii?Q?ABPX1v4mHQb+KjZ7Qyl6WP66bOh1Q7S6M65jujxVnkyX6x49g6yHj8xYT1dW?=
 =?us-ascii?Q?L60f/ai+MTSU8sfgk7QZx+636u+R+5qRWKh0a8jav5KKUsPsObvH7QRHsrUz?=
 =?us-ascii?Q?A5OcjDOgWcASTB/18Xe5b9TtbLkPvlZ3QD3kiZTPypP3n98FzzQ+UTNuZqa/?=
 =?us-ascii?Q?smudynzRUXtpwooifkJ19AHqa6oo7VxarwFp78n3NpJuy6xNWOQNgxrFOlQT?=
 =?us-ascii?Q?rUIaUljC7lmzNjHPhuY7jE/3l9wb2cvIiwiCGj1pxoHL+T6sFDeQJRAGEgJ2?=
 =?us-ascii?Q?0EQfhlVB2+aNcQTuImoXDeM5LGf0SBQpe1Vc2zypSVyjOlNNcy4NiZIzcsUk?=
 =?us-ascii?Q?SMH51VzWoXCH4tcbQjHQfnGXHYJKtJTu5AD4SdW95NrwbLAUgrf7xi3W+3fS?=
 =?us-ascii?Q?Mfapzz8QQOcAXSxDL39dFzG2wwczofUi0mc+FqQ+WiazkNARX59ecBq3ABKc?=
 =?us-ascii?Q?Cc+wNj3TCqSv7F/jBTQmIwrzt2TK8dK7B2rv/vSP378rjHLKZwJFiN6jGLuA?=
 =?us-ascii?Q?dgVZIpLThX05Y1EuBcmEukp5JsWOEN3g936PntOi9lUFQnaf5uWoSVpkkv+Z?=
 =?us-ascii?Q?5CIucjnMor13y/Kt1IfkRUsJXRE0eVeXiE/68wn0rbek/LlHsUax0XXZv9gj?=
 =?us-ascii?Q?gOQdtClSW/maN3xUxoQShAB9EBmUbGqsdsAVdwVp/JxOXeSe6UElhmw6lQum?=
 =?us-ascii?Q?RZBbhHrHDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AnlLtIuICGbKCrivfG1mBrGdorJagw1KQJsDsPKA/7S+yCeLJ3MzJ8mlAng9ogjm3GMlT8W23dlekU9ZQsTk/JH4ydhNVdzcsRYfjLyoECDSarvU4swGFJ4HZ558Odn5b21tdUr1IMKw5mHN+B4kaT91hQZnbrOcnhv2nOze/FimK4iSSE79imAoyPxGi6loTAFrUpm+LCgq3F6QaFDGA/aRvral3BCRSMTY9xF+61Q4PkFRnBrM5se4A2AuM1ek/sHmozRbH4B5GxDTTRoFNx1I+9KB8GUerPF2Gj1kj9jCUPqKxgmA3ZvEDAMJ5u2/A+SwGww86Wv36JUU1MaFPA==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7696.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4f5993-6693-4570-01e3-08debd222181
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 01:32:22.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EOB/0/sl0plmlIO5i/VGKC0I11OADYrU2DqtRt02qwh9wj6GEMBhqRzYv7SYo9+RLa8eYrTvmK5U5A3XpSYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR19MB9110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290013
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAxMiBTYWx0ZWRfX/3FkvIsAoZD5
 uzxX3TZU1H8rmTLRKBDN2RBCmTL+4FBLX8ow9NrpcCnwDtjaThGjpFPIb4IC9t6Ruqm/Trjomfu
 Si6mhaLKYjLzwZanK/WGxVDKuM7BHREGUYnuqpIeUzB52u0QRPZkbZ9iYyZeza1Pg1aY0WF9fR8
 Dhh4iYxcdwNkw6sD/2EY+rxWPX9LdPwAYeFRlAZrhT+Aftw8+tTRxc/lGlLI6WVW1NnBMFXLVF3
 +KhhZF7sktfNuvbol7jpo+jX9uJwlsrSh5Iw0RS/cnfuxVLaQJ2O+OwJPN8YR0/HgwTFCnFYLoQ
 PPlgldLHf17hQdlvxLl69098kWIaIOv86f+REv8LpHgWbUmGdnpBbmXuDy3mR84rM+P+e3hiLKN
 +rcorkAeKoXWLs3oVkRJvmBgKFCVDOoRao9TCx6RyT0nxRZRfF3mpNkicScyAM9sUwFdds+KZUk
 FSxbNlv9CC2RcDRkFPg==
X-Authority-Analysis: v=2.4 cv=QNZYgALL c=1 sm=1 tr=0 ts=6a18ecac cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=aNt9FJNJ8fZyd9HhltU_:22 a=e-LuPWh2cHqUqBVw0SkA:9 a=CjuIK1q_8ugA:10
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: TY08fXAecNbgkQkpZZ8McJEZcHorzmuG
X-Proofpoint-ORIG-GUID: TY08fXAecNbgkQkpZZ8McJEZcHorzmuG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290012

Keith Busch wrote:
> I double checked the sequences here, and yes, I think the
> synchronize_srcu's already in place ensure every caller sees the EOD
> error before it could fail the bio_queue_enter(), so this looks like it
> happens to be sufficient. I'm okay with it.

Thanks Keith! May I add your Reviewed-by?


Internal Use - Confidential
