Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0314207D;
	Wed, 19 Jun 2024 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787665; cv=fail; b=rzJa/3S5ApUMzyg/nZ9zb3HqtBLRaMW2daX84DMNZP1H6pKJsLUnmp/WTx6q+euglLZjZuGvl1ffQ27Yzpcfty4/0TDMoDOtpQ6kIIuDRG2VveC4damjGhQmTEbsztFrkvSLFL2hWQcWIuU11qLz1p290MGEou5RrbKT8yf2bXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787665; c=relaxed/simple;
	bh=tuDJy++RudmC27HysljieUx2/ikAwmNUt86WOYXGF/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fzWMYNh1J/sBBLziLfpkLYV7kqiLUOrxjEnyRNYha6uMnb/Lz2E7HJRqu+1uwDdbFQ7nf1u+tj874F4ASHbEHmV3p7n0kyPRqvWhbdl1GKKwmnI6KHRWP5MsVbt4GKR0paVpn2BnTh9yu1NXUlrg4fPoxEk4UZ/Wha7Cfdy8tp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eB60p/ih; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jaZihZta; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eB60p/ih";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jaZihZta"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1tU1W005074;
	Wed, 19 Jun 2024 09:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=p0vdxHbb77mWnTRBq29MItKQZUIDPRol13+j7CcLz7I=; b=
	eB60p/ihrYKgpA7022ppRmMRB1QeMdMhkPk5k7NDXuqQ2LIgHigT8DvjkjoV6iTW
	IIIDp5ElETANnxiwiqw/iroNvkyDCkQWips7pt1hkPz31DU+byCphcaUbjWurCcP
	w4H03WI2FJbGTtK8GICU32d3rUefyH7yXtQY47i+f+G2GdqrBj1rw+1SrCQ4aD87
	sOPT0SY4WCyJEZhGjtswlE8HSvuN28lDLSweQWQob3Tj8nm3XOOeBEDWgqRr4+9c
	NDdRUG0RQ4UbBmzPeQbnCCkwuIUGQWnjnw6md2XK0tZi6cMOBiN0GUyIDlp0MIoR
	6pnI2pKARt1I/yaOqBkU0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9r0uej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 09:00:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45J8dcfB034598;
	Wed, 19 Jun 2024 09:00:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dfkaud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 09:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMyFbm0sfn9uWb+Y/Zoh4zfzJoa3Z7U84EHg64NjGEoBJ4xNvCbxkRuGRbhliPa7i6YPSXsmbpgoHrZfgsKhMHThIY6Muw8cyIfxTo8NNiJnHdVAM64E62zN5zkwdOISssB3uVkNjQvKiiEcEtKCJ5iP37ayE4cYqPhZnPxjkMxPAdh/542NwrzQqv4CJV/lTGaWTQBuy3WZQlpRgi/TKriv5iyM5mVEswptcVSs3S0Pj1pd/p2ORyYWhCImXE16eTULTBpiM+CX6m6wG99yX+paeHKSLssTMkROCUMyEl3lBCHTwV+8yum9I0nGDBZ+YQPEstKVvRhuaghTBmM0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0vdxHbb77mWnTRBq29MItKQZUIDPRol13+j7CcLz7I=;
 b=Clr9cZ4aGP+dhRtlswc0IRBs/6J40ZpWtCB12S0Usc15soTMTbfJayGeCQWqT48h/tRPdWxQgcpUl++O3Wnw6i+SVCK8Cz2RZOGUUe38MyE0SLipQE4Un8g83sBbQHUaYcGNedkONfwZJcqZmGgmmJCSoNzXozo0PXTpInpoIwRBEQAFugfm91p2Dm22Pj6w7udnX4a0QtUL7ctRSgyX0uEXLSgBATH6eGlgnU4c4hyp29OcQu0iJEOob56UNJZlxv1a3Ps8Ca3He5YH1WBioVf46azy3BqjVG8EzqHHM3qc3s2mpJg6pSwP05/znE/AlNzDOH91oSglRsDpU23rMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0vdxHbb77mWnTRBq29MItKQZUIDPRol13+j7CcLz7I=;
 b=jaZihZtaLgLpVvDAUgY3vLTsqoSMlq3ZuF2oGc5EyF1hr1ZOP1diNiKNKGcaAB169MJrJjTp1XJOyvYOJ02IB8V5AaSOno2jBc4kSeK5Ue7rDFx0QLLEoUdrymekzP+ovdvWhEtH9LM6sYu7+rCGuorbUGCIKN6nWTqWjNc4SRk=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:00:44 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 09:00:44 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHawiDxSOf+1W/UnkG1CxXEGa2wWbHOvoGwgAACOwCAAAjf8A==
Date: Wed, 19 Jun 2024 09:00:44 +0000
Message-ID: 
 <IA1PR10MB724097C91AE5905FE60D964898CF2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <20240619081601.GA5434@lst.de>
 <IA1PR10MB7240896628D86A86E91DE9E798CF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240619082718.GA6210@lst.de>
In-Reply-To: <20240619082718.GA6210@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SN7PR10MB6329:EE_
x-ms-office365-filtering-correlation-id: 9433bb40-01e7-476e-236d-08dc903e4da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?StXLE9uqIq7QNFBtKkmf03DNeuo2eNwwj2Yx/+abm9Fzanpwb2n+d71KeF1D?=
 =?us-ascii?Q?7lyo7gSwOUBodVFnyZQkbNqKXGvC6vJxMa1MeCnBw8sGeT78jybwM2EP5eUP?=
 =?us-ascii?Q?w+PdU9aiP81oIP6OfzVCEHmaUcfjmS2NDVVgA9rh2bM2CQ194b6ZkuX1CAHx?=
 =?us-ascii?Q?uxTyychF+0pPnWBZGlGYuCq768jhqWM6fB2T6uivxaiyhzCog/ITgmgI1n9u?=
 =?us-ascii?Q?ThsoVF07YJrwqy7bAQM5TDNhNuaGYBdK5zC4wJA7rRqLlKnb/+lvSa92Lhqn?=
 =?us-ascii?Q?eR+rrmmSekHXH9uvng1nIYQKtd+Ce2y6EE9XsdgG5n912Qiu99HNSpgjezLq?=
 =?us-ascii?Q?zrwNTynJVJAFZn2znSz3mGJajZcB3k9AqIpQvK43Z70+CXez/62AGaD2HrdX?=
 =?us-ascii?Q?2D8qoFP2x7y+2i/q7PUCALe9f7YoGYtaLgdLfAK9krbab18wyRngLx0+Y4Qs?=
 =?us-ascii?Q?JTaaa1LLaHERQG/rNe6KC4XfTzv2tpuxn6QBczV5lYDSS58pZj4xUnM0Whzd?=
 =?us-ascii?Q?1Fmz7/YR2SrotCIMFkjt3Misysl4+vR+eE+cJXu7DNMXspY7vG2LeTQFZS+S?=
 =?us-ascii?Q?IOQkQHJ82lakvsrbrfTYPXWohtXhSfngF16FfKDSQKM4A9R4/VqjwYhy1EAg?=
 =?us-ascii?Q?TCeOu2v/zrnoUtexJcrBgoVvu/LSzvVVWmlbsLAf/tNNpH1A+yIijEfFFKKw?=
 =?us-ascii?Q?s7BuMvoFw5WZaHBfddlYzjV32uaGdiAwnLcIFLPmzUGNh1ro8k/xLoNDEtNJ?=
 =?us-ascii?Q?01esQ7pRi0Gpp/3cCaGpJc/SEditW+DnflhYBzdAT7XpfhXZMIU/M8puaL6P?=
 =?us-ascii?Q?NW4g/1Tw//GPh3grlH6EACmtVq6bfpb314eu3EkfufHbA3uKYiPj0cfMJ4+G?=
 =?us-ascii?Q?gfShI7obtkTsHq+Zpuyf83BS+adoX/JSICKbJb/lf+noeD6tsoCj6LNN9DsQ?=
 =?us-ascii?Q?kHQ9Esb2qNH9ax2ZtOZEGOwj4klvwB4mQzu39TX81OfP7LuTvLP7Dy3KKIRJ?=
 =?us-ascii?Q?FetE4Xu9xgj4PMZWatvP6821AIoY3s2Fe1C7+7EHUIEikZm2mPs1RqeB8eml?=
 =?us-ascii?Q?ZBTbwWXuUo+YG7BXLOubI2uTYPQhQUZrOPhakgPXpS5j/lazeOtj3bVN4Smy?=
 =?us-ascii?Q?1TOqpzWZ9lOtbu0rC5VThS/QYrWhy1lVLP2Fb0jjaqt9zVPlExZfhfPHwO0x?=
 =?us-ascii?Q?W9TH6mpKTlghE2MqeJselYfcADAuFQOptSWaNZ70m8arwUPYGoFyHU0CFfTB?=
 =?us-ascii?Q?gnGzTt91+i6J4SV2jhmJ9GOeXe0VnQp4XP2GI5q22EXtNs6TZx0QkdrIUDlA?=
 =?us-ascii?Q?Vm50vWUMTn6cfW0N+NNnvG4VvfxL2jfC6WIxdKTbWwh6sL7wEkEdiOUFb2Zn?=
 =?us-ascii?Q?cACbuVA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tEO7R2EEB/RmEOuNyCi6nXK2oOMIrVBbL2HUPyEzWaeYpuEBlJNiIwIdPG6w?=
 =?us-ascii?Q?RJkq9oZ4DoQ53cyyxhp/If+k4IZnagS+sFBhBxEIVbiifWHD/TsokBv8lvP7?=
 =?us-ascii?Q?0GlEVewd/2Nk7mvUTtxNthdrZq7MCkYtLZ3+7QMs6eelPc4KkKuEoCeHI+e/?=
 =?us-ascii?Q?DmW6/owBQIys6wxstHLx1SGLv/7AsHICEpOsM/+23XSPb44RhvCm1N0c7Odk?=
 =?us-ascii?Q?8+Cs9c2G1Lv2XnHGz9WeVNU7ntjdqzY+cXwTjg7cZ8y9D7tCMK1o6dg5GEDW?=
 =?us-ascii?Q?LL0TIq1vo9ZlQ19KeAW0L+FFNzNLH6NCA5g/OIOxzC0ncl8dPElxXt7Ha4oR?=
 =?us-ascii?Q?9gT+SjoeYTaADi1/y1Uq7JuAC56DeK4GGj8rX59p3sNfapzTPY2uGqH6dbAG?=
 =?us-ascii?Q?vdjKFHtw7Oq6MlRJmr74FzPIPG41tSI/RfKd7EZP5UancWzLUKedwmd0o1Hk?=
 =?us-ascii?Q?yv6QbcwCOYl6rxRtI8P9KrHUh+VAIxHRFO76jtZRWbAczXB+VgYc09orOAK6?=
 =?us-ascii?Q?5AFxZF9+J3IKPKygVifFrRvnhhjfHN4DrP4K72V39tX9PtQJvWB574w7cn6S?=
 =?us-ascii?Q?CHRHvRRMA6Rf59XdrXNuaVgLN3Zc8W8zI/qp0pjM8qojtPok81IJ72wfalwu?=
 =?us-ascii?Q?kSSAHt5D4Q/+HVm9rz1I1YVj/xhXjcLdsgjcaMP+R6lsHyk4w+7W1BvSBt+e?=
 =?us-ascii?Q?YtvtnFZaYPYOLwvutvz5QCWy2w9jZN1SwyUAJc6q+6SsP51LPlmCC547HAZ6?=
 =?us-ascii?Q?e9JF6JL5/ztLcHC2ctsNjYWF9ezg6nnclZBe5bHZStq67L/E305d/ijH7Yb2?=
 =?us-ascii?Q?A51vleQMQcTUfr02pmDTN4NHakZQ42Lecs7xpu5keMYLB+uLxGLYM1LEnktP?=
 =?us-ascii?Q?AxqvLSAVaUyRFSmQemz0w862ybfxx0Pc7Ye9Ey9vdZRQHZW9vLaw/TSlAQ3g?=
 =?us-ascii?Q?IgvK9ciVkILA7xN5R7VNl7AqYVHQjMKl/1djA1E50rPGVEgYPFZEImof4FDw?=
 =?us-ascii?Q?KWB57+XlOxlrjpTGPYv3NbOIWbwG2sZ7Mjp+hMcxc52IcNnNdL3DDVySzCMP?=
 =?us-ascii?Q?xDrRhK+CD1SiJ1vfzyf0LkpDMxBWf4tAPkLCdVOW+maBACEgQfrULhOqP2L8?=
 =?us-ascii?Q?qvTFWBoKdsWYnetBM8TCeieKfIF8m0NYqrbdzJNILbdk9vDK1wUTcTdKBpCm?=
 =?us-ascii?Q?GiyGZi/xgqDMGn4BaL0HqEepcFsb2dKvSItnR72iVMo1FGR+HbVypXEal0cD?=
 =?us-ascii?Q?NQXCy9oy0Qu5B3qvz2s2G9fI+tWrhqXaqEjA2Qbu0WP6m7cGh3Go/svRbvpL?=
 =?us-ascii?Q?9SPU879fmfg2w6HS1o2rvwQMagVxAk+ygBSp+bE0OLO+c0bx5StgUoGgbQNv?=
 =?us-ascii?Q?4xC1WIUGEVkkOaIrAf/cThHGAms+sI2XXyvialU931aQogGtuie96DMIwwOP?=
 =?us-ascii?Q?Cl+eFdiCivyzPpMxX4zwasuIyUzkcylEuTEczxbNnrjMkwRNZA879GnYcp5t?=
 =?us-ascii?Q?qbUbym5VLCcTHgYgBRrNjbBYRALgz2ShMfMBjxSpvtI17VXky97J7mgpa/Vu?=
 =?us-ascii?Q?Su+ffDwVOEezhyErDryiBOkhsnuEQ8/INDaFDFXF?=
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
	L/qGnNFqR2Jjpj/+FB4oGHs4YZ2aXsMUD9CCXW0mCiAxjK1vXnDWHa60FN19fsOwVR3Y2K0FEjsY34NwhuIB0rAVftlADsTvG/21+BuUlhwxLJQkl+H05AeooRiazOKfUh46tSOvM/RAamTbGXE+pBncQ9/oNW5XhExBMxTLbeppsF7zrapEDWPgL53Ohb235+FnaqYubjUAEQSv1STBD5DEQIEwL8j8MlPngOGVuFYOs6cS1/sqOG9OSYvtT8trQupd1tsjZXaqsa6Xv/OJkS/2/jw3kD6OIP0rqlL1mjl+ruxF8R3poQw9kH3mE3z3T0B659aWxpYInyLb7D1ypGNwZdY/zBrbohL94U0UiAdhLTo5dQsbZ1Mu51MDaZftkWPjBYow92UKu4VOg4T9/QXAN4JGUhJE6NMhn1+CHr8CmtbNH3Usu4CyTEMPxAQDFsTY10lzKPyiuWnvu1thjl/52Si4/ZgnK+swYa7PurHG1IGB4DuEqfYEH+4qrL8QHOUrmWKzVuazZl4STiBPAP6hhxDo5Ak9s6IFt9ZsLe04L9n5u3dhL2IoO+muc1HMPG5fuE2dGmrQPeZQChUQtqSeeUJN2SoecqOsVJqTB4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9433bb40-01e7-476e-236d-08dc903e4da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:00:44.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/HXVommNwgb1OnmDu+OWdkk/CUDDB5oIgdkGAANOTqVqL0XFaPrYFVQZbBlPIzJiZkBLGPEpV6lw+KzOgZtmoN3DQpDbke/vscmji4dZpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406190066
X-Proofpoint-GUID: FvPooZv9l3ntT3WfX5KwilyqR6rl93bZ
X-Proofpoint-ORIG-GUID: FvPooZv9l3ntT3WfX5KwilyqR6rl93bZ



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, June 19, 2024 1:57 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>; linux-block@vger.kernel.org; linux-
> kernel@vger.kernel.org; yukuai1@huaweicloud.com; axboe@kernel.dk
> Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> On Wed, Jun 19, 2024 at 08:21:35AM +0000, Gulam Mohamed wrote:
> > > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > > Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk
> > > Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop
> > > detach and loop open
> > >
> > > Do we need the re-addition of the open method to fix the ltp test
> > > case?  I kinda hate it, but if that is what it takes:
> > >
> > I don't think its needed but I kept it because your following comment i=
n the
> suggested change says " switch the state to roundown here to prevent new
> openers from coming in":
>=20
> Let's keep it.  I meant to say new I/O coming in, but letting a new opene=
r
> come in and then fail I/O isn't really nice behavior.
Thanks Christoph.

Regards,
Gulam Mohamed.

