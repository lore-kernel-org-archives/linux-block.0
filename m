Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7528727D;
	Thu, 28 May 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987603; cv=fail; b=l6nwfhz89b3wcEbR9utL7m+cq0aVuz0UsepiWmNNYw6ecSzQY6fOm2baiNkY9dxYzEZPhth7eKUbWhVDyoL1geE8yuiepbLO0lrkggK6TMfKGZk6B4mAIW3gtuhn9dB9FBCcdBAxA8UYEdMUS3kzvrpJ9QvjkZ5HzbDoMUT0wDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987603; c=relaxed/simple;
	bh=bOekgAa+KuQe/hOkVn3vMLhsExrY2CHgPEjkgRv7iJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hXzPL/Q3N0UKJjKvcYSAqhob4a6tWHaY67+8gUXdpQ0+FzJM0WfdvYah19CzPyqtuwyQvJyBL/3AAerDlOxESjBU3ZFauG85rxo2bNOgJo892IxFcwCFlSQEAXIdK71rYwvl5eEUVOpwkiiKtGFMkfug+WJaKEAdS6gbGDBw0SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=yePlNNRH; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="yePlNNRH"
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SFJ2Hb2109283;
	Thu, 28 May 2026 11:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=U
	VKDTefhl9FpMMforkQHVa9zlcQa7B6QB+Ww23T+x2o=; b=yePlNNRHYsnkcL+4p
	XAb1x7k6tBTrliMPZ/D2R2hjkAIluKjPrc3o90ESiDkjRw2+3B4VpePymDBkV24K
	IVb4RiEiXF46udUtO+EUNi7uq3rxzquXF7Lo9bmsc0WXuPjPslHQZ6w3tH2lrzB7
	IfLOwBKhveJaB5Y3d7LwyRlYdB1etOuGH7S52SDapILpTHIfD/yyefofJAclTu5L
	QCm4ztKtEIOAPNMCYafpjPvBBixeHOP+php8Fi7XNlUmyow3jH9KvfKleEAfT51j
	amUZ/bhNelXh+QxnBVY2aMeTkkA6OVFK0hsHUeWu7I/0otS34NZ/v5m/zX6CpeZ6
	/T2QQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ee7xrbfar-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:24:31 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SEi15O286172;
	Thu, 28 May 2026 11:24:30 -0400
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4eep972agj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:24:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ3TthABX/4kWMgNeIxtiS/sYk3749p7yzMi7DWvZqy7xS6qW9G8eOJzMtOte77qCe7UjvX2OhR1xHBA64bNg+9kvDR6Py/TXqqaXOS4ZqHL6PmqKbQ1XTZUJDDBEqivyzY2lcCNy2eMDOGrAwO1EUZPImBw7XXlVcvbT44WOAxi1XFf2HTFkNbUNE1+BNThUC7g5TDaZK/0lPPq7vNlaTRLNdc8CtePwvLG0lNYiXPvwcTmdVMBwGmhgtb76nO3PHPwH0y8iskshCcqr4weZNFQ9FhW0dc78Ri09wVYG56354gyTFLMhjSDYlCI0CkZh3mLt0t/HE66p0rvF10cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVKDTefhl9FpMMforkQHVa9zlcQa7B6QB+Ww23T+x2o=;
 b=ErHcuwoi9UX4bndaL9qnJtzGh9ZNYFzlIhAKIIm/1RW+4q5fs+3dOojfS4wVS8S6ci1h1XItS5AnE+co+uAZjA/tyt0odfBwr4eJ5lFYibEf/HAVWSUWWo/ReiCErVtnSskX/oUzfDqNbRj3QF8Nko/yxOUdn68C7J3Vs2M/Ulnw1e5IO+VJJhUXgE/n7hwjf+QsthKnGCnovKrCC9ogTHtQ3hj9osNXZH5COy941u7V+u4A2HcWhUSJKqo3434oOrokcQpKirQr2nb7bLqmNBUwDBxrk4k2PgRIKLgfSGWcTzGYTSkuVM/vSVhgzGsMqdqtPDmLnxah5v6ji6a+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS0PR19MB7696.namprd19.prod.outlook.com (2603:10b6:8:f8::5) by
 DSWPR19MB997315.namprd19.prod.outlook.com (2603:10b6:8:36f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:24:27 +0000
Received: from DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9]) by DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:24:27 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Topic: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: AQHc7rYSFc/wmEX1xUeXcN5PEFcVhw==
Date: Thu, 28 May 2026 15:24:27 +0000
Message-ID:
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
References:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
In-Reply-To:
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
x-ms-traffictypediagnostic: DS0PR19MB7696:EE_|DSWPR19MB997315:EE_
x-ms-office365-filtering-correlation-id: a6e38231-e635-468d-f19d-08debccd34ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|1800799024|366016|376014|38070700021|22082099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info:
 1R5XElb4SnSL2Hg3kFOrWhhIElM93JxZ7irWK1MyePbnIrYOBYt7rtMDkKYU434dEh8A/NKJckmXyGopp5DZx5hrDGwqT9TYLsihhzASK8Lyt9oVNFgZ9ytY7M4wAXb+EnRhmFIbHXz9zuNwjR1Km2h0TcJdJJ0OoePS9LwM8hYKiJOnExsy5FI4Cr287wXv4l6UWMCoHnYZtyOOmBI2PzN/MMFsKv+EelHTQqbzedVNvj7vTboPn48d2Q8HqXehvXqJwlZJqkiB4q/ZMRc5rcGoDRDkSXmRK9y8XJAixXHV6aLWAko7TabUeHfksgK53TowKGUqjaXUlMLyiNobQhwfAfw5Ro3EP6S2cTap0KNikBOW1f4In5Tln8L6vO59VKaiD1vLYjt6Lrc7IwoC1dFylDyRPSgdIIwzkGLGgZHrehxlHTil8WXSNZx6gcauWSNbWLQ02eiWMhPHy/Yy35ICBG056N2Mtru0LDCnbK10AKX2cajHfwHPfvWP6vBYpSZbKcflVSVCssmXN4RpjPDMkfM0/+sjIDjLiAbnBLCPxnnELCpQHx+LzZuEunY80yIYrmO1fcKVs5rKQPnwVCcDDi+/kL11vjJI1tWFmtF1MawuvEcNpy6yRshewyls40KzD60CSGy5R9lRNNc5jNV/fHpzCbkdV5D9KfRo4Jnj9cL01fdk7xIrTRvCevZHqiLeInWWvMHgwrjbMTiLUUXCS+K3aAWlrnmUwUX/5OVrJb4KibuqBgpg29OVMAh+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7696.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZX0RZ/r0nxE3xgHY6CgEoX0dv/FPVQ96e+omWE8gzchwRf6GHLaHtpR9gChE?=
 =?us-ascii?Q?FZQjGQ1RV8OxlyDa6YFWuJik8b3+HWDFkcLeqmrX2nkXVmKYw/qe6wE+CF6b?=
 =?us-ascii?Q?g9HxJbQH6Xp5W3dnAyWXaFE9SHnzvkS757mdQj75umvFkzTT9Ral6+NHKI1J?=
 =?us-ascii?Q?gRqze8i57+DR1UEGuKDQwPzckr2JYO+hBhCknma27qpxhRyp8MavP3VBqO8e?=
 =?us-ascii?Q?wHinwU+36tdtJV8V5Chm0Ay6FcVr7LF5PTSV23WS9HYnYMic3jL62mkVpMgO?=
 =?us-ascii?Q?gG+3RW9jxfHRub8aKFo5NCLv1nj7LLszyn1bMDGD6kEtoVpkkNZY2qCCZVxi?=
 =?us-ascii?Q?BiuopNZ42f1Yp3GWw+AyiaT+t9jXlJY7FUNK/RQGx73r8d0UmCayIhY0R9xL?=
 =?us-ascii?Q?b75y66R1CjUaG7yEdugrdVp4TmZlZS+IrNq4EwnzSKwaoZX1GbFsAlKDRop7?=
 =?us-ascii?Q?8UpXS7LVTC5TDA9XK2BBGisD139HelHAPwuziLqv2KQ6REsA1M2/fq/529NC?=
 =?us-ascii?Q?w/XsVQkqCw8VnIznpnbE/ZL6SrPM5ibWQWDEut+s+tY4mqv7cjjVsUnjJmzP?=
 =?us-ascii?Q?Yc8U6bOHInehvtLh7TcMIiXqe0O+TBz1WoI1ffRexi3olWRO56+jTYk3hja3?=
 =?us-ascii?Q?t9UIgSV4pWaqhK1V0LM3kJZFTUNtoHu+SI52l2J6WHEoG+9n92v+DOgVMeVU?=
 =?us-ascii?Q?4+HjUOp24zTA4f+HrwGFoTQBsE7+amt85GVQxkf6lzSsVaD379vbbnHEH7OA?=
 =?us-ascii?Q?kh9yNwjqPtvPcUqrpMrLymDmGG8WurPv5FrqDnZOXni4ypYUCT2sao5YAg6r?=
 =?us-ascii?Q?2YeI3ar3tSM27KKxLXhA86VZCx1tBEXCUbhn0Gh5N7VXn3/wz9zNW7R6/rKX?=
 =?us-ascii?Q?zq/ZZ6M9rqbwSt/QTtmtiQ4+wUPFJRu8FFbhWpi9DdvvkW0tegJ7yV4KOvK8?=
 =?us-ascii?Q?7Lqh9Dgs/vG/EW8pqy0x8I4WiNfTG4kkG5AnXUfKGx+2vHyv6hP4VAPwocZ1?=
 =?us-ascii?Q?fq9ni2qyX1rL4sN0bcTxqziq/LOj4K6XTenBKvEBJt5br1i7AQ3ogvWK4S1p?=
 =?us-ascii?Q?BPsnuqLyxgcnxsUSY1+aQoZm5PYYBXtSUc2GnHETY4paCzrVixoefAoL9xqK?=
 =?us-ascii?Q?R8KrDLClkq95YODzfurLP+3wOrHABV8XDBGDZvH8PJBoksEGkDpLJ9NumhUt?=
 =?us-ascii?Q?d3hxJSTP0+EvPlcMjyK8ZP9lDF+9QCjZysDjYHWwe7jknYZXmYf2wDoMoorb?=
 =?us-ascii?Q?wHTXAAdxy7OXg7rPyF8sJmWRX3DDGXqCTpHRHw3sQoPeSxGXG3LDxzEDJUN9?=
 =?us-ascii?Q?XoVlSeOpUwuv1EgBqESEevCu+5m6VXmaEB8QuslksUi3yKkAG2grYhJucBzG?=
 =?us-ascii?Q?H2pcRb8+haAITxEBd7NyPKWiaOKVl8nh5tuFXq6WWTNA37Nje9fEeswwwiJF?=
 =?us-ascii?Q?Ajn186qnVdSs1JUCFmv5O6t3IkYv1ejWIj+q6B1FQiZEDFJyU8PrL3lAGUza?=
 =?us-ascii?Q?8vKro+igBWjCrqgQYnubZHvufH2HGZQ0EV3KconMqnW9Ilt9DXs0WkMTHYCz?=
 =?us-ascii?Q?chumvMqkwJhp3PmKHh3UZ2BuxLd+f645gH4J+GPCkmS3NouBSjBZoDCadIRq?=
 =?us-ascii?Q?/SnS9F8hNtioPvLGao+WMt7lzyGagA1GfRvFSkHN7073QwIuA5g0YRVRx+A5?=
 =?us-ascii?Q?stK1CcKPReVVnRwHGmzCptF28dg7moJnzMu0QxpkOSHPxSZFxNiBjuimpYDt?=
 =?us-ascii?Q?G8bNvznZ6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	n8Gw7j0zObRdZcg2ePNVJQN69j02eDlrsQOpdWHzuZemeiJIjbbfCM6oLvykVPVLQq46RBVPRtruevtD5JMleZDECqy6dlBsqjI1GV1yv71Fj4p52HBuIXXED5okKwZmvfTH+nd+NOdcDq/ECnn8zX+nXvBGOn+DhWc2X2s4xfj/M1rvTXAG/cbDTdT8c8qlSOBMq1K9R6lZsMG9WdVNTLeEFg7o2bVg2AYQbjUEmSgaIVpJ+aA3rvbmkS3RVka+fq5rzRd33afWSn9FqwYO3Fmjfy08dponujfF93V1VLupamn+k7jBPgnScYI2foq5XayEW3/gFEVPL64LqNaJwQ==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7696.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e38231-e635-468d-f19d-08debccd34ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 15:24:27.1186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oE06EcpvTKSksIvOfNEMVc2mMnb0m5VyWTDa8NpZsIZ2CgeA7OwBzPjEUeuev8iezN6ch+MRIkPc+fERZ8AtOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR19MB997315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1NCBTYWx0ZWRfXy2dQozYorbZ/
 K51u7U/mfijcDxr1WMTBDildkBqbFwX9aMrX/lnsDhqe+hTQyITaD9zOyHXacuSL8Yd7bWh2FeL
 I3+E3YgBGOlwQ4PtaKuKwH+ClnjLIUx54JQZkglt7T99Q3gIjAMkXOs8aewjx7XsomGpKdG9sNb
 0L7BIr8teW3CIUM9D5GqmAaNJ6BO7MC3svr7r/v9LGI9nYIt+3HbG973WqJ+n/SQR7lD8V+ogTC
 JqgNcPWmI4L6FByzwuZi2zu4cQ6N575YJ6eZXbOjPebk36wVqmWsa7kahZBvD/5Qai74UJX0x1R
 Pqxdv3eUU0YtPMd+6vinp5BF+blg45NcbLdnf6vw18ervnNh8TzHySmBcvfX9vT9Y8VRmJVIYBP
 0HLVOarhloJAfTND5iOvaU30shMkB5icI4BCMtxEu7wYsyy9SYjK6D1aN+GlwwdaMP/IdnSjzaA
 tCuDuFkMtHbgI/7eE7g==
X-Authority-Analysis: v=2.4 cv=R4Mz39RX c=1 sm=1 tr=0 ts=6a185e2f cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=sEWawkeXllE7TocFc0N_:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=iLNU1ar6AAAA:8
 a=I5ez-9YcqGaXH_xP4T0A:9 a=CjuIK1q_8ugA:10 a=gbU3OgOOxF9bX48Letew:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: dpGZgTQBui_EqAzkXJnFv-cn_v62yLDc
X-Proofpoint-ORIG-GUID: dpGZgTQBui_EqAzkXJnFv-cn_v62yLDc
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280154

When nvme_ns_head_submit_bio() remaps a bio from the multipath head to
a per-path namespace, bio_set_dev() clears BIO_REMAPPED.  The remapped
bio is then resubmitted through submit_bio_noacct() which calls
bio_check_eod() because BIO_REMAPPED is not set.

This races with nvme_ns_remove() which zeroes the per-path capacity
before synchronize_srcu():

  CPU 0 (IO submission)
  ---------------------
  srcu_read_lock()
  nvme_find_path() -> ns
    [NVME_NS_READY is set]

  CPU 1 (namespace removal)
  -------------------------
  clear_bit(NVME_NS_READY)
  set_capacity(ns->disk, 0)
  synchronize_srcu()  <- blocks

  CPU 0 (IO submission)
  ---------------------
  bio_set_dev(bio, ns->disk->part0)
    [clears BIO_REMAPPED]
  submit_bio_noacct(bio)
    -> bio_check_eod() sees capacity=3D0
    -> bio fails with IO error

The SRCU read lock prevents synchronize_srcu() from completing, but
does not prevent set_capacity(0) from executing.  The bio fails the
EOD check before it reaches the NVMe driver, so nvme_failover_req()
never gets a chance to redirect it to another path of multipath.  IO errors
are reported to the application despite another path being available.

On older kernels (before commit 0b64682e78f7 "block: skip unnecessary
checks for split bio"), the same race was also reachable through split
remainders resubmitted via submit_bio_noacct().

Observed during NVMe multipath failover testing at Dell on
5.14.0-570.23.1.el9_6.x86_64 (RHEL 9.7) and
6.4.0-150600.23.53-default (SLES 15.6).

Fix this by setting BIO_REMAPPED after bio_set_dev() in
nvme_ns_head_submit_bio().  This skips bio_check_eod() on the per-path
device; the EOD check already passed on the multipath head.

NVMe per-path namespace devices are always whole disks (bd_partno=3D0),
so the blk_partition_remap() skip also gated by BIO_REMAPPED is a
no-op.  The flag does not persist across failover and cannot go stale
if the namespace geometry changes between attempts: nvme_failover_req()
calls bio_set_dev() to redirect the bio back to the multipath head,
which clears BIO_REMAPPED.  When nvme_requeue_work() resubmits through
submit_bio_noacct(), bio_check_eod() runs normally against the current
capacity.

Same approach as commit 3a905c37c351 ("block: skip bio_check_eod for
partition-remapped bios").

A broader solution that moves bio validation into the queue-entered
context and eliminates the set_capacity(0) hack is being developed
upstream, however this minimal fix is suitable for backporting to
stable kernels affected today. The link to the mentioned patch:
https://lore.kernel.org/linux-block/20260519172326.3462354-1-kbusch@meta.co=
m/

Fixes: a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Achkinazi <igor.achkinazi@dell.com>
---
v2:
  - Corrected race description: primary race is in the initial
    submit_bio_noacct() call in nvme_ns_head_submit_bio(), not
    only in split remainders (which are no longer affected on
    current mainline since commit 0b64682e78f7)
  - Dropped incorrect arguments about submit_bio_noacct_nocheck
    export status and BIO_REMAPPED propagation to split clones
  - Added analysis showing BIO_REMAPPED flag does not persist
    across failover (nvme_failover_req clears it via bio_set_dev)
  - Referenced upstream RFC series addressing the root cause

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
+                * Skip bio_check_eod() when this bio enters
+                * submit_bio_noacct() for the per-path device.
+                * The EOD check already passed on the multipath head.
+                */
+               bio_set_flag(bio, BIO_REMAPPED);
                bio->bi_opf |=3D REQ_NVME_MPATH;
                trace_block_bio_remap(bio, disk_devt(ns->head->disk),
                                      bio->bi_iter.bi_sector);
--
2.43.0


Internal Use - Confidential
