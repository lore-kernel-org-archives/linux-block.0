Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FD45BE4;
	Thu, 27 Jun 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519232; cv=fail; b=UA0UEWiEFgcophxkFyu4EzHr+t9C1B3aE0FsM5uB10SUCZt8BhBUJkVTAOGc82+q1Ux2g1SKOU7LQgfa55WPF5U0i19WSPi4NrzlNqViwsu1mbHgCFa+z0EbRTbA8KqXZ1IamN9as5BU9oNz0sL0jiyIIZfn84Q3Dau9f6ZCIZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519232; c=relaxed/simple;
	bh=0K9TTg+Q6c3ON6r1YwIcfaAyOTIUaXrzx1Wts4YQ9ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8QU1DpaSR544jg6gyWtDb1Ke0keibILyWEFHkh9fwOatHOAOcEzeV9AXEq+Fx2RHSSFR3QBP3N56L3s1mDxDq9Aw2IF6Ucs5efw9L+bQzKeibMV0cgGJl9Vih2Ty+kYMuw2NjPdYQM6r11vA8m/7UGTrNDSnHA/XSJ25kaLuLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ba93GSJ2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R0xoLTtH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ba93GSJ2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R0xoLTtH"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RKBW8V010354;
	Thu, 27 Jun 2024 20:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=QIWAGT4PDXlsKQphSQSDm1aovQ88f51W8I8s2EBsM1o=; b=
	ba93GSJ2fPh8BbM5KGvmZ7nCK8BkrSQt70GqSSJ7uLPiC/uQXpHtiCR8ftct0bwD
	otg63NalRJFhmisfRoGUeBcjY5vZFT3PZrACUg7XVeyYHXWIa8M/VCX8jOTbMSVW
	5OGFaOXxiDjfTXx0UGzFO0OR6WdTtKHxLhEmHRXDhBRBDwNL/Ln1t5vCWZ63+CHj
	6npnFfXpEiFgUpCTw6oSAPm1JqsU/DRM7K5poC3NF8nsK7Bg5g14BW1bOCY7yamq
	S49DbRRPuV52f/bmawCsUa9EQvOjn+MGgGL4gUGpdOYPik8Xz7Br5xx4Rr41BTXT
	tHdhEIj6Au2jy9qi7Yazlw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 400ttnaj65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 20:13:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RJ6DqI037120;
	Thu, 27 Jun 2024 20:13:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2bgv96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 20:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNp4+1lhM0P3mjhetCJ4h+49Rgq1kpMHkeYh6glhGeT5QsRxUWRhQdm9/sm2GlHdkXBk6Txej5B0PRqt1eCZVjr5izL9b5tE1b9LF9cvSn/vyGr6WESIJtkwJIJStmb7LZ5N2Kc6SKsyQB48Bi9Y0eO06forw0lwvn2q6O5NgOOKQPo2uM0HONlcdv9eb8aZuU1Q7PZVQWQ9NqpKbHeyILmSzLx347iSdXN+PRMrpxm8QIXFckNmHPeMctRNYTmPzu9NBfKYgQmf3hugT1cALYFOE8ihWQqOtCisgXvpLWXsuD2uRzfCLzgy8qWW/hfDeXDwMVS9JqI9wqVcprcCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIWAGT4PDXlsKQphSQSDm1aovQ88f51W8I8s2EBsM1o=;
 b=T4cOgKfbEtZLvagKoAlr6Q4l6tJUdv/jv91QCyrdK/1R5kZup74EI3lPJY3EktIviowe870tMyOLqYmp7qwCCGj5G7soqPO6Ga4i9IgmAoY3h6g/5wY9v8j2m117BWBza+dwpBe0BygJjD98p3TRvi7IvSO6ZkNOEVrJrqDkPTPmY+FUnoMARfG84X71hcLmDkjPoJ/soIlfXoJIKTrUjmK7d2mT4WmxmZNJM91YQSM4Hn4E+FfVyd/X6LQilR9IP/NDxYDJKcIY8INHTfqCkrJERjgcJJCCb73NYU22cn/SnMs6ndhy+MyZqsUKGZFxBDsKhPHkwQbpyYTlV5UPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIWAGT4PDXlsKQphSQSDm1aovQ88f51W8I8s2EBsM1o=;
 b=R0xoLTtHwK/O8THUWgkE/w5mSOk4ry1bgaY69r+8EvKtGvayW49Eru+4WDee0PFxU8RJUGmL/ib5LX/PBq0FR+g5wulGwwZw8N7JjoXglN4u0jAemCD86DvEMK3FXHwPC8jlxXSSmn7Id0vdvom4iD0G6nEQ0pA5jfst2WjCm18=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 20:13:08 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 20:13:08 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        Christoph Hellwig
	<hch@lst.de>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHawiDxSOf+1W/UnkG1CxXEGa2wWbHcF+oA
Date: Thu, 27 Jun 2024 20:13:07 +0000
Message-ID: 
 <IA1PR10MB72407980A58E57E91F80777F98D72@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <20240619081601.GA5434@lst.de>
In-Reply-To: <20240619081601.GA5434@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|BN0PR10MB4837:EE_
x-ms-office365-filtering-correlation-id: e79a07a3-53b9-4bd3-69ce-08dc96e58f8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?c6DxOqwD5blAKgj1Tw6uCH4nwYc73cAoXnijYMM8o3oT4s8/6mcY/cj7nbwO?=
 =?us-ascii?Q?9NRClbHXGTqOdhJWO58qVR3TPGCHOTYI4Cgmw0G89Pu3o5HXBNVd2yiPwXnT?=
 =?us-ascii?Q?uYQd61NELeSgbm5uhT3ypZg20gaYNOMBbb7vUIvXS1hFiVfRXazkgf5u3W6P?=
 =?us-ascii?Q?kiDg5CT9OHKMoVqvHToBMgBxoXRFCGdbPfIgmaIa7tK08HmVgvy/2H6t7dVs?=
 =?us-ascii?Q?opxxw4Dq6CFd1wbmZo+u9qEUPPS4++/OP3RYuWl/YHqYy2l1tv83cQH8VXiH?=
 =?us-ascii?Q?ZVctFCi8q+y7es8jqsyuhp0Z+YGKP5gSDRTPBaj7J+kA8987WnF8+8zRwz/I?=
 =?us-ascii?Q?fAQqKE/9Kv/oFtXpyJN7xKrOzo2B7YYWV87q6pF8nP1ht47Lpq8PCToQ28ys?=
 =?us-ascii?Q?QsD0SaLuqApHL3/IJ1kXzIs3J+zRth5YiphtW0AlvhFNz9INfNsDm9Byd5Mo?=
 =?us-ascii?Q?NWwRM7Mu2Y5qKvW5f5eR05+Y+fYajiW+VyVgAkXSK2TH091gGb8W6oOuz7hQ?=
 =?us-ascii?Q?jeamjsLs5Nqfe1x3mU1itE1AeHN3lKSO6n9TSnAgCrR9rhtTP4s5RGrWZVH8?=
 =?us-ascii?Q?G6mTDP5dsi9ulHBu0eg/3O6viFgwcfyJdBtaC44m4+Gp0pzVui0pzcMwE+07?=
 =?us-ascii?Q?+Cy+MeIQURfwfmTcPybnBFb+QLAyHAPTKtKlPdYtEg0+y5oA6Lh7UlnYdypq?=
 =?us-ascii?Q?aYXSF6xXN9uTRlmzGOt9Hf0Fivi0YR7m2s5a9N//NsQSWVQdSbYTupy+uYvr?=
 =?us-ascii?Q?mO9rIzJUmaBM9hGagweWxLaAvHu7TXQsxiIqg3n/3gx0767K/N/qPNVGAVc/?=
 =?us-ascii?Q?6jJ1unTNIJPBy3FDHNYJpcwXoIQ/qPwVskMEzQ7LJV6GFQE0XjsaNI25z103?=
 =?us-ascii?Q?GRHOONELHajYSWldhu4c1uaLXrCJ676S8UPCOOumsyof3bnNbNCMmcpgifD3?=
 =?us-ascii?Q?26w3PnrKD+7K5XLpTLopHP9QkxYgOMbm53L2wvERDJDICcgD3JckWAA9eqOH?=
 =?us-ascii?Q?5smbfHa0zYhovWwe4VhJXh2Hf5+ce2cgbqlXayZbz+xVX70n5v4+bpSy+9Wc?=
 =?us-ascii?Q?2H/ua7Gg1lHGpxOcdRHsgzoEBFMS1Tjfjrt8CPNX54BVsf5IQqlVc27RTXVn?=
 =?us-ascii?Q?p/m3qGi9MO4zM0SzDuum37nUBcTJ6494L3C+UHX62bOq5v5GjiJOp8Yn4vCx?=
 =?us-ascii?Q?siuHIz1fTIxmZlcf80S7qFSXhvJioot9BFDW1aL4w4Qu15v7kY+W/icBv2D5?=
 =?us-ascii?Q?/p2K35V0UV53OEV/ES+QcvHCPNk95NcZjEniKa7p02t9nvhKPPE8t6rI93Wv?=
 =?us-ascii?Q?+Ybe+7FeVGhee7OL/1HL8b5Eb2L062pnHTxVEF9K59sP6yJAU0A0Er8rSf64?=
 =?us-ascii?Q?KzGAG62GJiS8NfGL8wIzuV1LfkoX8oIocpC/hY4wbcnoBsu5bw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?d+bYwkZcSf2YO6nSwx1CpLP2VXNXxX6mgsZk19A7khgMjd3DmAhZGgvhHEzJ?=
 =?us-ascii?Q?M5IAitjMsSOWGHCjf3DkR3G9doDF8DsM1ojbYUFxCyjPIpYTWf9p61f6UXsV?=
 =?us-ascii?Q?hNX7NKBpUKkdbDS0eNh/hNoJ+Nh2M04O+ItmPiyX9X3+XAldVqO5WcdrJyYx?=
 =?us-ascii?Q?+LgqwPeME2P/JdqosGYQUxbtLwaJZ3+O8au+8KqP9f/K6+wYGn5uPJRInT3U?=
 =?us-ascii?Q?3gW4MlvgJm6DSvAKBCDa74lcEYD81j88gzQrluu2Ck3QoTAjPihMh4QkvGr4?=
 =?us-ascii?Q?U/V4lisOFe0ONvURiqPWWiqlzezmNHshR/Wj6Rawmhnl6ZbTfJkFjkV/CZoO?=
 =?us-ascii?Q?dwTBF/bvz6CQF8fF+loE/o5Ai1mvJLsw1Lz5au3wQ9pRRsLG0XVSl/KqCvOO?=
 =?us-ascii?Q?yxxZ8BxLew9BxbRwOxwE8WyNEG7cONqSRX6ItcjyiY3fy/RGAD61CNJEkUlz?=
 =?us-ascii?Q?8gfZ9He1OAsu4AQtKMVLPk26xIo2bT075T20qltDNHnW4Qo6brp6Q8xdih9B?=
 =?us-ascii?Q?C4SwESfOr96vrdJnvQeWHtOyDC+B80EJ9AJFx3gcKYRUrmWUEE6mj3t0Whg2?=
 =?us-ascii?Q?sPAwZX8Ah67dmhRT5YROtwsvMCGMoI46W56PXkGU0Nt53fUPJFfnQpAplMWV?=
 =?us-ascii?Q?eHsMnOmV6kdxEkdhU1ayvvOB+13ZTgDtzWQyCTfJ7TqGWbLdsUARBr4EmZj9?=
 =?us-ascii?Q?CP5YkjP0i34iy4yi84L6bT1Sx45+zHeSNxkkRP82/quk91jsSfW575oY3QGl?=
 =?us-ascii?Q?n5eWxOD3fVargNmLFZ9aHlI9PpOTTq2jMkcoESTNPiyfa0CZpXOtfC4a3oiH?=
 =?us-ascii?Q?1l2OJ++fpVvM2/yY5H3E+23MLB3I/1Tfm3dJihXkWsoibuqhx1rFJM979KST?=
 =?us-ascii?Q?f3P8NEUinMtRbuxzWn+QfBU81HCMkAoN0lTfRukOANZXuB9P9ZvJmsfwXWaa?=
 =?us-ascii?Q?V3W7APbWzRFN/fYg7+f6letjQMoEoaHX4gCQ/XhMeYuTxXWpQAYKEqKVC3U9?=
 =?us-ascii?Q?j2iEcGAtdzayWVxx5m+nRvklqB5eL34TyqnpM/d0jfIEgNawJP4xkAic5992?=
 =?us-ascii?Q?yhECKI8loMxf64Uvuw7lz7fHEeTrdk2eyhpJTzzyEcGppCPM5WjIKIUCrCfo?=
 =?us-ascii?Q?gb7oUbWiA3ZVntLWAi2lTnoJXomE9stUcnlOHPtQ5oHKtjFfDtcMMVOzUpmy?=
 =?us-ascii?Q?qg9h7HLT2EPN0JkDSiFjW+aqn7GIIYU3JrWGZv4oHMzpNvgQxILWdJt4fq6A?=
 =?us-ascii?Q?qGcnPisozMN6UrUF5QEdN431SFsOKVUX/ocBdbN20KFPM5bllR/9wgAKALsW?=
 =?us-ascii?Q?OIMC8j3gYZ0YthDh1pI10J0O27pHE0eSmUDNTc8iKqjVdPto+69Sput2kfZR?=
 =?us-ascii?Q?yfq4dpVI0ZZT+0g5B6RWs4FO+4elDqmCkPAyIi2166qlHuGjNpM0dkuAOdKu?=
 =?us-ascii?Q?bdvLahYcqcGRh6XzlKYneXFc4ZwH6EMQ9nGNgWXJJgDdq9tCkzDrZJLSQJB6?=
 =?us-ascii?Q?qiq14z1r+4hBFQDrpI/I5p9x4cHUxosp9fKpCLV0R33Nk5VbYH0BmOaC8SuN?=
 =?us-ascii?Q?BUdtMgLsreHmYBdPlN/TMSoQDIR1eiq0bFqXykwB?=
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
	KSK9bbix1xSJ/JTYxwShx9Vubxr7StolRLfjPf4J6xcn0Viq06YBEEXpasvHHGKxvUAaTeXQEmCStHygQJ2RVmB6/XMpSwcz0wBHGUsA6U6i7xZEDXkZ6V8i9eXp3a839lZP4wh0wbUVPCNJNV/TwnLHgN7WjHPbl+RXwCMyy+UZUjnuAvrOUxtmsosGP/23KLPH+kjIAl8WlFKU2h5tJi6hjS+Tl7mtI1BNA0hrzF51/NhD1xsjCa3LrC9Z0ZXORIz1EBEVIuLutvk/htWJ7MX1GkgUwu1npaT9TIxa1FcjK72qagP6f3xafFBKQDlLBEy2dXnmjGy2m9siwsFRqYYlmVwbyUpVB1UAlz8JLq2YoR8fSycFDw/U1bItBCERt6vNVHnnKZrc6I9m2jAjOz6NH8cBt89/YVA9jioEWiu3zMJ2lf9ireZQI6KOwsx2O9xni7xhM/rF6ZAG3aiBufeeNCgzx3tbPD5ANFj3yX6okkCjq3GwgHI7QGUKaAJ9gCT0iCA77ONROxLxE6/uHkBH/R8Y5rONOdH5oHAiTavT07b8yTaoFOJSBge280axXwVw+9h4lkM+Gl+p71HuBU8/3plflVwiqyHECbffdSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79a07a3-53b9-4bd3-69ce-08dc96e58f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 20:13:07.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSlEp0gisal2eJBMKuxKRrurOyrCR+o4arzn+7bxRUuKMQ5ezHIUDJBdN6OI5HCwCs9Izul2qdqj0p7xLwGfG7X1HT6TfzWVsp1+rfjX60U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270150
X-Proofpoint-GUID: TPY4RFimPOdt5bDdsIBOiai9AuNuOpM_
X-Proofpoint-ORIG-GUID: TPY4RFimPOdt5bDdsIBOiai9AuNuOpM_

Hi Jens,

     This patch is reviewed by Chirstoph, can you please take a look and pu=
ll it if it is good to you?

Regards,
Gulam Mohamed.

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, June 19, 2024 1:46 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk
> Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> Do we need the re-addition of the open method to fix the ltp test case?  =
I
> kinda hate it, but if that is what it takes:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

