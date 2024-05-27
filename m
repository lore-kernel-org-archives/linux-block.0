Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774F8830;
	Mon, 27 May 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804320; cv=fail; b=luhdwKw57LHmwqFMPRvvTERcrAxZGNrEVeLo+97WcvPWr09foz5uNBSCL/SxXeLOtmPOqLoye2gPDoFTRAqrRBAn7dDT16QrSPxpDXC+m7/eJu7XI6tsoYG01zoD2P0deTLG3qV2B/k4ZAlHKY6Dh/BiYIhVkKA5en3zkOD5vjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804320; c=relaxed/simple;
	bh=np67qUQj9T+Arzst2j3T/XCw0MLDKvgRhlkRpKsWXt8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HaM1Xzt9b8oosb7LFZf+CG1ZYxK55byP96ybuXP0ipblH55czx9ZalgYIdL8TKmgGECibPHcthXsYrs1Weztcktj4h3LVGyACS1Sx894vHtNSJPeQlgXGplGMqwfalkVpG5bQTqzCtMjgRQ/fyNVP8qPDEeWLWxGkQQXix/8ah4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44R7hqQo027357;
	Mon, 27 May 2024 10:05:08 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dnp67qUQj9?=
 =?UTF-8?Q?T+Arzst2j3T/XCw0MLDKvgRhlkRpKsWXt8=3D;_b=3DOBA5MyoVz4su0jYPHRy8?=
 =?UTF-8?Q?0SpjV54bSrwaFest5geeCjiZQp79/4V+R7CTJAVVWP36os28_MJUlYM7LmyvKV1?=
 =?UTF-8?Q?U7LRmXF37jrl2vS1Hsy+tQjplWvqOhb2NJvpEMaOXtl4SCdBGbmJ1K_hBzsOZFz?=
 =?UTF-8?Q?BFb9auIg8wY+mrgvGbIO1WY6J+MGsWl0fk2UyygijFcNUchPDN9Le+Lj40a/_bS?=
 =?UTF-8?Q?151WqU8lkNyzRFGTOkZaadGqYZab2R8KwkNnPK1AtxsdqCS10soVqHtsSj/gkct?=
 =?UTF-8?Q?4p9_gEP2aJ63c/6julP593paxmOHupsRHF3Nhvf/4/LJH5hqd9XVq7qeYiqdXM6?=
 =?UTF-8?Q?xwinbCF4Z_2A=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fca9re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 10:05:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44R9f03p036941;
	Mon, 27 May 2024 10:05:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50vntvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 10:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSVA/ETBktGTveqMg+V7HSCaGkOUbCf3ayUf4jKvxyaCE/4s9uvZwSZuYbRRVtfrymCTWSlDV6hpb8+/H3RyTLAhCLCIUMTZBwtVcHaOhNuO7q3h8mSinpJV1zEArt5QVRP+5M3lVVFieULQOKdv9Ifejcvsg/lZVXwlJsCRJQanYXMqUjTZbbwuNGvHgC3awestNnXwfi5w6h2aXTDxLCQCiAMR1t30rYoXQQaB3lwsPd6Kwyqp4e3J1NrUDe/BDQaBJ0PO3/9i5V73u4Fs23F06Xk1LSzPutF8if7snZSZbBKrTizl79CkFjSk3j4PLS4Fcd7HiVuEEEsqS0xjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np67qUQj9T+Arzst2j3T/XCw0MLDKvgRhlkRpKsWXt8=;
 b=e+kvOKam+l0ixGRajQzaJPQYPhs1b/OLhUhUIGvn805QXOLagi4udIzo/QUd/isWSiWWfuBeqjNawS8zpCxBmJOOaLtTeudcse+KL9ZGaDFc1MJuPaOMl9TPWucOkXWbTbJLcAkcTazEIf8ap+t2xnme171WmC8jhgHIvUhV2qN+4JjtXlBpMZq3QkO1tm3lD0B3K7dlOLZwLLi3QTisH2FWaah9wKeZKVpFCitBMp1ZUvjmDeAzDzRhxlYQJFcRCF0fp1Z104t8N+PJKeArvVLlwvhhxVuu+i8NnkyyeYIdtS+Uv+c79mgu5iDBGbUis9z20B2UdfyfnhBmBQHVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np67qUQj9T+Arzst2j3T/XCw0MLDKvgRhlkRpKsWXt8=;
 b=tJTrHxSyXNiWDTu2628/uc4jyNvwixOE9NoqdHmqm6c3km/VS0q+V8aFGrkPh3SCzs1a1pmnyomeBjNAozFDWkkHS/pjnnV/3D98se1KFD52Yt8BX7bW7NDxlpT2ttp/7VAnp+bL0gtmw5n8NEHH8pwW7nKcqC8uFM/ZkYVOB2s=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 10:05:05 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:05:04 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Recall: [PATCH blktests] loop: Test to detect a race condition
 between loop detach and open
Thread-Topic: [PATCH blktests] loop: Test to detect a race condition between
 loop detach and open
Thread-Index: AQHasB1YwswUtbqpFk2NoxnxfHhDhA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 27 May 2024 10:05:04 +0000
Message-ID: 
 <IA1PR10MB7240F92E191ECAE52095FF0E98F02@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DS0PR10MB6845:EE_
x-ms-office365-filtering-correlation-id: c43d3a55-7c3a-418d-9520-08dc7e347b1c
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?0CsoeYkqffVow9lvy1De3okUhmAHboRy1+mech+pBxICyFXMJujViSUPLOPj?=
 =?us-ascii?Q?ZLkgmHLI8fWGN4X/BZF68yFf1BiTOeoLUpGU4lBY/rq6Srb1kbP/VaYE5Pp6?=
 =?us-ascii?Q?B0QXgfanScX0CuHlIuyjxlAvO+1xh283ZL5L5KorYjmcZK97LZMk++WMGlsN?=
 =?us-ascii?Q?oZt+gWDZIuIxbrRQabhvskYpN52wLwhAc0OmuINTT3XAXvvV6y3eaOAFnL+/?=
 =?us-ascii?Q?VaQjgYK3m7NZOzM2OPqdrtbbltLXgQQw2fpye94QmslnfVymBbuOwWWXR/L0?=
 =?us-ascii?Q?kpdPG6xnR1Q005ZRnq57gV2tD7hZDWSWh30BwQvx3afc+cGSI2stCSAU9Iji?=
 =?us-ascii?Q?2xpPi+kkG2eTYp42lP4H5OnmBffE4vvn+uJDl0/ITJm03LISVJGmdAuSNf29?=
 =?us-ascii?Q?qG1QTYKww2NKplsG4IKd6sBfABr7sUvpaah4uB7ZvgBFQZqq+ylcae849Bzx?=
 =?us-ascii?Q?eqIbPOgt/OzkMraZw7obu1J5rKm73rY+16rnu1+Jy2kDROl/m6bkSICyAFYs?=
 =?us-ascii?Q?FKqNUJrLIAeYgTpceF92CEUVp5YoldokyEwfLNokhfm191zcM8mWlMVCxuwE?=
 =?us-ascii?Q?jBAiI/+U0H1Cllf9bh+5q4r6mwzvX8lNZ8DVSjTYd1peYw+tTkbr/RohsVf9?=
 =?us-ascii?Q?mkwloMX2hpK3fu2mzC8hKhCumzOIpJ3vrCOwdby8HCHujAIZ0Z65/rBHaeoE?=
 =?us-ascii?Q?DN2Fis3cJ2B5/b8gncPoJnUcWZaPgtDYEHwC9Nk+gNGxFXV5AGx8kjyoSC10?=
 =?us-ascii?Q?lZN13/cTX3TAQJqyymxX3sfvALo3LqnuhZ6ekRQjqBwGsofZiAaUf2x6/lPD?=
 =?us-ascii?Q?cYk2PzLVjH3X5Y7322q+9rc5sQU9x4Kc04F+YaFI11abtcTAL86OrbxeDipH?=
 =?us-ascii?Q?QnTOZK+hhvNheq4sQYgPbksnMNz+UIWkdpdMzhLnHfTQBx98eQ9GKwEBjdqM?=
 =?us-ascii?Q?gxm7p0jlM843mGrzAeQ3or53WNjjHc2k6kGARSYLdLsZuFOoaDeQSiask1k7?=
 =?us-ascii?Q?F8sQmXYO6anVtgHui/eFa2fcGeXLOPrtT2GQizpoQ098sgQxU8jghgDdqWk3?=
 =?us-ascii?Q?eL0RRM+iQ2xZCHpnPzyQn36flNzV9AZiBJO4JSNXh9nYaK3eJKJ9cgGG8aqy?=
 =?us-ascii?Q?ZpjuxCbNBM+g9hLY3WC4zrFnNf7n8Vm3CuXBbv0ek8bG8u1i/af6BjutVlHk?=
 =?us-ascii?Q?+ZiRp+suybsGT8n39P3tPv9wD4wft05dTgnoDDXf8rqmf6gkIAjQ0vpeLOfi?=
 =?us-ascii?Q?ZktXMD+l6Re4M3dfWpNmOphlVAR9J4CTcZO1GZ1XrrzESnCrOy9vZjZPo7uH?=
 =?us-ascii?Q?XZPkWyrsHMOTfHITAzn1I1opTjuqCrlAxZ1qJFqEnw9IFw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mLGbYDEP4UQWxNkvLt8Gptza6B5mOnoqxaXA5VzFCSNB7m3GPm6o9mXAUo5+?=
 =?us-ascii?Q?Xjs0P1Zf+dnjy0MtUzl4OwWzL/wk1JJ/NFYu3zy59h2LjX5jXqhmfYtYrxSk?=
 =?us-ascii?Q?Y5mg9iKbOHSBJwS1EbWuB+aw5SnWs9oSbhZ14L9fqJFaLor6VPZD/QNnTmRb?=
 =?us-ascii?Q?eyg7h4fRAoi8JQRkuudmcmlzi4JiqrL2WfbLyaetwSW86A8gEjexNWU2pRmp?=
 =?us-ascii?Q?s6ksluSNpDaGXEKX5p9o7Jrw8SgdeSgOTukqNZOCcgL3xY52NOkvjjfaed2I?=
 =?us-ascii?Q?3AgXjIfpNxiBAL3eI8sWF/EAMWHKGczmdqhTDQAw3Bv0M2cxNfobYMpNfwlZ?=
 =?us-ascii?Q?GtXHQAkFhordmLSGgPA8R7mWz2VkwkyBXk1lYTzHzftQ+f+v9rbMU7vq93xX?=
 =?us-ascii?Q?AplbnjiXSE8nISpnlLUFClcRyIPfG1Pqtx5o1t5f8XfpfCn5mewUUbZumtZi?=
 =?us-ascii?Q?m3gvuEgnpJjtvaIO0GeJ3SAloCxHqQ3Z5Str9QPMqJW47330NOZS2ssr1vNl?=
 =?us-ascii?Q?/btYB3k3rPbpKZ2KBpWyL7w2WQTj0HgftxXTXUVb915WlpeGR8gbTDetbVJI?=
 =?us-ascii?Q?BX6/LM/GVuJnn6nh11UTOaGVQImzt2aeL5/UVXDPBr7Pbouz0utmfB3+4so+?=
 =?us-ascii?Q?ZrFQC6i6sTVmTZibEknLocVNTVPM8LAcH4fu42FQLsCW1g/EnNWXhaeBadqy?=
 =?us-ascii?Q?5co2g6eZ7VssuboTxvVZfwHOyKSNdzalzL6W1wYT3tXfLYQ7oXCaHg2u5R5f?=
 =?us-ascii?Q?Cs3oFyU1xxFHCawHmRhd6ncqTYpLISIU8o9x5N5F7+9JFf2po4s8xVQH5aQJ?=
 =?us-ascii?Q?Pgu7w85nrvFf7EHKrpEGEXBY8FeChvJq/eps/ojacEME/cF+vYeXT/ud1o5J?=
 =?us-ascii?Q?KjHi3ETXd1ZkcoAm6Td33uAgrF63nzZShK4YpBkmVx2vKOdr3rcwmYzVbUDy?=
 =?us-ascii?Q?xbt07F3OWqwySPaicRwSh66SEPlCiUVHCkb+zAh2/RUv6IdI+yHyw+6/Wcow?=
 =?us-ascii?Q?pNuMIasWWjFJUzWYrgq0NQa4wsbEA7eBJnMcqA3115lvxCRirCgBC6GYM/vp?=
 =?us-ascii?Q?dK9wa+vr+md3RaFp8D+wAT8C47bOSdnPVmVnMU3YjcC8BrqhgtcY9idL1Poj?=
 =?us-ascii?Q?lH+LPVzxKnjcBvyJ7HBHnUvkA5mrl3mSJPTK7dr1FyJ/FJeNpocOHGH2Y/er?=
 =?us-ascii?Q?5AI6RwrwD3R7JrOtxq5Bux4TxKHKjrZGf9H5+ZycAqvbh2QNg0cz9xT2nOrd?=
 =?us-ascii?Q?Agm0G9+Rpc54/oAQ+jb5wExXQPzGzwI4sozBbTKCpFc0+uNT5TiN1r4uKx2E?=
 =?us-ascii?Q?NT0QFG6s6kNtR1dFBzxaYwH+cbCUzxQuJXyfC0km9txpv8Bysb4T7TctSxJr?=
 =?us-ascii?Q?pGXr1GSBPjoqM03XIrUbdxbwZIZpb/xxRCDPW/LyJxqnT5c/xqCW2ogqk/pF?=
 =?us-ascii?Q?UL9h59sdzXFGYDm4wRcM2ShK/Q5+Vp8W/HSkCnpDyt1bNGwUfMdk0pJkX/K6?=
 =?us-ascii?Q?yzzvUV4tZWfAu/mZ8OzMmS54z6mtf0PMLOUV8gNHfjU2t+y30rGcR5QWiOWY?=
 =?us-ascii?Q?z83y6XwS6oBEYkzDRg5RjOAVhsQpvhYCgCAHgJG0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BuYwpgn5uEmIBFoB15mnAi7HikKSOu1Wh+KsOWJdDWW89KAXYZq6OB7m7ZwchnLi/deDW57NpK7Np4joZ7ovEljkQoqQZMz7+pWVqn8jDqeAl1WGAl9XdELdWRpJiArdRHicBmVJ67yQ9D/4+R1KXkrJH0tLP1yFaY81c9dxd6n4n1a33I+ZlVKRRn/oWFeN2NW3hOABUhmZ9hzNF+s/Y7IW5eREutXFZeiDIuHPrdSyctRRJ2Ex0guGM7YgZ+z7eAIFb233gFB+Vgo+b2S7ADyMg6m89tnrRgQJUu2By+KZKqwFsJmvgEy4mVU4OTu6DC9O9gKpWHmvQe3iAeLhAW8rOScc/8Xv5d7uHKnqk6M/6u5VVEdklH3aJK/xAPiQpDllgs+o+ji3WYBlHcIKAk+b5exlOuUkUL+SMXiVcS5eKed7HeouX/2y1jeRVVwbbUWe03Z/mqPJx1YHlAGMbmQ1sEBhr02tLjqQ6k8TOa3RRiJmLl5cpP2uM6KADE68GNZF+XkCIDiyBMMjS814BSASw+JW6LYgt3vQNIRu0+n4X6erEG8scPM+eHl4XGa99wXMOZOiZai9RXP4fL10qLo32wdM5judo6dYHxfj1XQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d3a55-7c3a-418d-9520-08dc7e347b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 10:05:04.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9D0bsnLKabXtlUm7YodDEyxaCoNe6gZjO0OdMhMDtxa0IoS4D30FCvi7fb80W7rVImvq/z1yGpLBjtFoPSeibJICraDb1/fg/94kFWYu+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=669 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270082
X-Proofpoint-GUID: 7nRSqOojLK4g03t51wrSe-QBYzMXYnDK
X-Proofpoint-ORIG-GUID: 7nRSqOojLK4g03t51wrSe-QBYzMXYnDK

Gulam Mohamed would like to recall the message, "[PATCH blktests] loop: Tes=
t to detect a race condition between loop detach and open".=
