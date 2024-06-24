Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77A11CAF
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206738; cv=fail; b=dWap0upWB9VF3vEwPgD8Hd4XFQPbKesn2HAo8m7yag4pg5rRT4k8wafb0XzrH7NmosGXOUvvyiw2r2JnK5tbR3jLilTpaidQENpJQHOytQEHxb9gBdPhqU+1X5RCkyc9voD7BqAL4uewT0PX9jaij1Izcvt5ukXDRx+h8wkYps4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206738; c=relaxed/simple;
	bh=wSsouFRYwhbm56WUNPk52WSbY9w5ALdBS4nxZ4VYRsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgDnqTCdTp/Pg2FGMSNgE0Q76z3+5rkm/CS1Nf/bb6Ee3NexY1d1DWQgLF8S9oCvfLE1vf1WM4GTbqTqDsb3scuOi8pdmU8+k07UksDslDo3/qcjf9jSxG/kBhpTnkUoWoNlzuucAHuQxiZQUDszNKCybHRi40AnqOzi6HZCyoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ecPxR/RH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VnzPQ3sw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecPxR/RH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VnzPQ3sw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMjmQY005021;
	Mon, 24 Jun 2024 05:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xZRD02GXe077ODc/VU5hJAi6E4lTY1JFkjHOdeOhivc=; b=
	ecPxR/RH4QMPVlo5nYNGQHep2pVVxPt9mhEmfQ/Sr6VuxyFUTPDJGXlKWzPxTA4n
	mYYp3xJVMWxkrEuwOKi4DwTwCBUqwjkduFEe2Kg9IXmKHTasB6Lc9uyw1JYue+Ie
	7kEGIOjldj97sBUfrC/EqENAm6JLflUwXNo7jQp4uU4eWkpw5kVAZThr8P8vCnm0
	ao7mr7NRQlojK2lQj3rHELreUaSM+LXeA65xP/wKB5P744nu65FJMwYfLYPBKFsq
	WCGQm9lwKy0Kexje5E3E+InjfWEzC94VnD0dIhxOkw7pauAeS5K5bqj4Cc4i+NEE
	w2pC6sVm8b0oqfUOMSyeGw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7s9s78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 05:25:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45O3LeU2037088;
	Mon, 24 Jun 2024 05:25:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn25sdvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 05:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfQOkVong52aL5VNcxsE8iAJXJLNh3aTH0ypfxlFEIIjfkMdYVbzD7L2I1ubAaeu1Cs9pqt4nuDiJgdBiYy7axnNVvBZPAnU6N7KbLjuYG3EdV4xvRh0VvFNKWQc6VGa2610yc4ESSypjMZrfUFwWbTg2wNzKFhSisOQd5pOM+nDwjhTIr2CrptjBDSSkoUHrIHELplTFi7r2AxdlIBTPPr7upytp+kFwmVEPS7GfTwi8JyuJZvrNASXATHRB1qgGS7TaD4P0Ka3xqgiZLRCeHlYmHCuMHVSSuUZSroHC3wR6Oh91cMDir6eNgZcWdOtnAlRWxytILyj0wZ5xeRCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZRD02GXe077ODc/VU5hJAi6E4lTY1JFkjHOdeOhivc=;
 b=C5ITZDLSzFv8QdLsQkUTz3C2XDMT4MqXqHl4HcVWjkQPv2AsBdlHx8sZrnghYA48daC3BCVwj4rIYcENF592irrtR7D3pI1Du+T8f035GIOFR2+4Rmu7/sKnQAdnhGtZTg8VjzFqKuMKODrqVNcPhnZp1Bv+Ae4qf4zUVdhkpLNNqMZM1xsFe7/LdF1HH1Lu2v3DEwxHSONQzdU1iw7XlrChxs/kotYFTx5o9Zt5T/1ktstmWvz4V00hwCI3KZWW/1jvMm0BFdEoDxjqHrkbtpY4qdyEuxmR4hnsQItyrAn0+DUI0b8wvdXxLWUjWFrU+Z6It8uL6LB0yHgF54gzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZRD02GXe077ODc/VU5hJAi6E4lTY1JFkjHOdeOhivc=;
 b=VnzPQ3swqSVF0sRatATE9E+/ZrSdzbFP48BCVQEF8uOz5xE9azfatxpTp651C8t2VX/fWgVtRT9TttdbCcR/6Q0DNmO6bk4DSRBVSdKH7f+NBwfsKzauNRd3kOUqWZdi82xp500Qa0h/RleCBYxpbAIn9T69nWftrkNHUx7CsFk=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 05:25:28 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 05:25:28 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: RE: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Index: AQHawv52CVvzP0ipbU6SWE7llrWRwbHWZrCQ
Date: Mon, 24 Jun 2024 05:25:28 +0000
Message-ID: 
 <IA1PR10MB724022648B6D9B63293B719498D42@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|PH0PR10MB5847:EE_
x-ms-office365-filtering-correlation-id: 54972965-a0ed-4499-1005-08dc940e0f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?BIM2FbGXZrvVjcK1pnyS2y6BdzRsAWstonqC1NKYSHPIPwIjfijWqoX8SUnn?=
 =?us-ascii?Q?cf3/5qiryHhJKM/niRVWMo43QIVoHzQgiGJ2vxYwwYEdzdgbpwXL7UDiOfVi?=
 =?us-ascii?Q?+fVui5iBSwBmmYO9IA8uU0uy36U5tROO/QP7fghn+4NTFhDbmLfBAqzpyfIK?=
 =?us-ascii?Q?I9c+IxhqQkDp/9SIegSa8aOWpV5MCZbFcENRLW1ylwcUUKfdDHnno3fZ+PMe?=
 =?us-ascii?Q?nHavs83cKGhLfuyxLYguR3MeZJaffrsG4R81hkZY3JVZlBG7FiOF0UY/PAg5?=
 =?us-ascii?Q?Fq6DtDSSHQ+rvve0xzSQ/IX0hmBwvOfam6AIF4vIyTlll8UWo8iTnas/8CJ6?=
 =?us-ascii?Q?RVldm/h5hA55Mmmh70B76d9GUI5igpCzxQk+xRUxqK+qazEnwRd9gJgMzQKb?=
 =?us-ascii?Q?AhVraQ3MKrKejJfbYlf5ZkWw4C6iGfZ9K3Ic48+TLFwWEnqo89j/Bsa5x0eW?=
 =?us-ascii?Q?AjMsL4+uaP9Jn4azflQHwQkNr9Vjl9W8B/ZCHOs2zddrg9XdtSjGHy0n86jH?=
 =?us-ascii?Q?0eOqOynyr+Psnn8kt4OQO3m2t5oa+3oKe3oL0ERmn2QMmQgKYECAEvYKrE2G?=
 =?us-ascii?Q?O+9O7249AJVW3vGiE042E3QazVCMYs8CKbY0zcn+YfOhqJzxz3AUeJhJVcK6?=
 =?us-ascii?Q?da06LdLO/cpU8thxjtJbejvnzWxOLCd3Lhs3k8guvR8bKjIcRWZzG7irJEti?=
 =?us-ascii?Q?5EqCbI1r7Irs1jsdJC37Ha66u4KtW8C0SLJEFTcPrnHD+FR0jxLO0BMrcdXq?=
 =?us-ascii?Q?uNQoV9Lkffjl/vu+9sVjhPJCSNOlmEDjpWzQKMFq75GMmwWAnwrATVzobwOk?=
 =?us-ascii?Q?PBzl1pQScf1TawFlbRC6zeDrpPO/GgNrri12mWGZbtxU4z4gFL6wi/yy3mIi?=
 =?us-ascii?Q?uhFA+cBTllHthVsh+K18oyd1ohsLvgb+4bAU3Gugj0qgyDtIoYkZFlMoqNVb?=
 =?us-ascii?Q?Fc7nxWLykR5+awwgqpPLOUdHTrVlFiF0FDbKc6tXn2cVFLZqPfRnDRJYLBX5?=
 =?us-ascii?Q?6GZsFZROP4+WILen+yHfTfq0fgIgg4pouQPHamExa7Mlaaz94nkJEOtaIocR?=
 =?us-ascii?Q?4EcikAnfFpjhRKxRjUu3V3SeosaiexB/3Fy4fFdVcR2A4U6hh0Lo0ciYv7ZP?=
 =?us-ascii?Q?0G+uiNpVSbuhEerPzNMMVG71F7MsDjxRwfXGC1OfmM5ThTfizQm73BBeVV0S?=
 =?us-ascii?Q?XD60oIgKF4HtPBC1hd3/FX1zo++2vlOpC266dTI6cr8W0Nv26dsLPYK4dTKW?=
 =?us-ascii?Q?IcwYgFoIt8gkiwJ9eleAoia6F8Rs9y+QOv6N4oOdhZKDBm7eUWVnHZ236EFw?=
 =?us-ascii?Q?wQh0pw/eZUdY25TR7dt3zKlcXi3FDlFsd1octI9+lCjlUE7N8kIcMLF8t7x+?=
 =?us-ascii?Q?olLfOdI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UlqbGQMubmDtsMRkY78Tfr3/UC6zcwMAsKfwaLxrDCus+dLFxnwqUw5wYB3/?=
 =?us-ascii?Q?ungYWuJDsyGReJLh6AQDW6MacXQRuLVQtwJX+a9k9FyKLfMa92V2FTC/4mbe?=
 =?us-ascii?Q?wtDPHZ2sbsnFUKUR2D2Gmav9qteEmyKvBmGaN9PMVmYsKD0+M3mVOCA7Z71A?=
 =?us-ascii?Q?xwZXMl29uql+stH2dinJ54qMCyx3cp9TfLEdd36AsVmcicrc1EheSPXUszbl?=
 =?us-ascii?Q?JurHLwjrZWcuc+zwMDY65huV2iehlmhbNOVxFVuRlvV28scTf6eiCHl5SyA+?=
 =?us-ascii?Q?IYrJm56o+jKWeeQgKZ+oj1JFBweW1PoI7Tegp09iuJ4bEEyT9Xo1Zj430gic?=
 =?us-ascii?Q?5DMOczhIkKiiAzIbZJSgyl5RX4Pkmi3fR5KyTmw4EO03vwkw0gO+EL4zIDbv?=
 =?us-ascii?Q?dBIAyMXmSt6WgwiUOh8pKBuCCCi8XoA5VcSn5RrSAES6ohrUe+bl5GWvEnU/?=
 =?us-ascii?Q?iJgO/m+jJVZRZ/YubOhYsYDuAae2+l7CSivUFv9Uwhizw2XDARUw32bC6FH0?=
 =?us-ascii?Q?SulKC/9g0d7C50ScwhEFTfpyxK2Co6aORO9/Qli5OmM2Tvp7eDb1owfI22N1?=
 =?us-ascii?Q?WwufbbtKTguFSy6IWJFJZFxHTnrYKjh36bmXNVwrs7m+09xbXFDAV8en6ozY?=
 =?us-ascii?Q?bE7AsHfEgFe9RXuJ7/DvpUzrt9MKPJcn/yL3aeU4VQiw9Y93v0hhUJDh6FPK?=
 =?us-ascii?Q?uHUttxK1TFbTIRt+5HAggjHgDx3ZKLCeRvaFeQZNMAJw3GOTY6LTdil3usXf?=
 =?us-ascii?Q?v8b9TshxFnkhzk+14hMQL+eYT6+ZeBN3Ozi0UomMN4U4D80G+EgoAm8qJME4?=
 =?us-ascii?Q?nGEiu+8k0DHGs52wuaW3aINUOTFubJqB3Y6a5ICyDLSX6q+CBsN1BUzkpl64?=
 =?us-ascii?Q?yw4foro5+thSrCOr/PPKdUFVrHv/UTkXHMJ+LYpyYcFbDvasmjCyCiqE0JGA?=
 =?us-ascii?Q?CD7+xlgxv8XN/WonSgmTqvbpdXkGN/e1cBrAWCckYi0PGzbT99mU9BZYX2/V?=
 =?us-ascii?Q?jfetplBPOWLPJB2S+pLiJR5mAe8KCFqemcPTiw+fj8DnKK+8MKLyE2vRl3Qv?=
 =?us-ascii?Q?GPwte8z9gJqc+kq/kkywVdtfXrZnTpn+Ur3XjV6Z4CsWj7xSvmPOjhvMIXFJ?=
 =?us-ascii?Q?PZU5aRF9lRpWQ5l5Uw8thMzac/RGSFlnwQO9tpojUu+q3AOcciP4ZU2qeO0Y?=
 =?us-ascii?Q?Y983uPOLz4mKuru/YmMgqASuIoa2W1m9fMyk7LwLj6uE4hyi61JE+qGCytix?=
 =?us-ascii?Q?j75Ul3t0t+y+c7gzricLh+SplHxmCcVyjotH36qzsD5/kviD8ePJfku/a918?=
 =?us-ascii?Q?zlH4WQcoWTnJ5uWv1jg+L/6zD+FwoFaiGlBY30estPMUuz4qCYhMoLyLjLFP?=
 =?us-ascii?Q?o8aef/w8ZD3fwOcVirzT0InoQRRr3bSLzef8LEyu/8oV9lMJt/rlJ5fZPEXY?=
 =?us-ascii?Q?V4/9PDe+mGJxNZ4bPjZlGCXEcfX7avHgJbClUZnv0XEvBAY2jpP0gzdVdaSd?=
 =?us-ascii?Q?e3f8/i1RrX7f8Xx1NQpihFTWIeIAtm+7Gcku+f/Jc30lykLma0ntofYxmIgD?=
 =?us-ascii?Q?8oS0FvD7t0+IZhcFXA5wpmXxbEHC5RhEph5PNOJ0?=
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
	6nQ/v3SkBvyis8CtjnTvH041nbW2EafccECyZTrZ1Aw96xo9IcOJ5JITVd6+VKddFbSqN7ufyrNS+zxv91G4vBhu1qpQjRjfeqc3Q5d1hTalx1Sf+iAUiJXc6x/nPKNpKcms9Wts//L6yXyuSPhC3ITS5AYe7Y62JjeoRS+4XKjKbBnBTgd5h1daMRbfVHjcyTgj+2R8ghbDk8VHqTShqupYqkOgS/cxVMdgNSkdJASOfjr2nvkFvXkPaJyCEaXC3vbmtALqzr3upQ/nZ9iKU8hraZF48VU5unoMh/f2LKclDVOtieDFhBWsK5o2hymBG3RYH6f5G0T0fDx6vSHd7YyCKsYM+BjN8YOZDS5msoRO2gBDiBlQZgDxxhjaw7s9Xwt9wCtAdJss5+sPX4bCfvEcwqZbCvQ7yPxcpCaSRJjtA2+zs5trqR2mrMkzA/xqWLtSdLYNLdoCySyPJHb8gbm3dNJoprcU7Da59UcuPMF2axuH6T6g8NWLcq9yUDhXYcjd5J8ueqcEKYEL8BC3xe02WzDy1hgn80T2ksfz31QhNm+nIBt4tnBu7eGr/hP6ZZIV8O4gZdqCHfa5HHRzdJ19VqFIMy6esLOwbhJDteI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54972965-a0ed-4499-1005-08dc940e0f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 05:25:28.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPIS/p3UOte6cgcQ8VkBaUDZwrmIyRQ52Sbl3Hjps6W4TyPOHwrhOSeeQ0QWyodSTf4esswX68Csw8ZyldhnQ+A2x0FjZcu1ydKhJQy273o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_05,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240041
X-Proofpoint-GUID: uKx32jnpOHqCq7XwlixwD6cwMM-o6OkV
X-Proofpoint-ORIG-GUID: uKx32jnpOHqCq7XwlixwD6cwMM-o6OkV

Hi Shinichiro,

> -----Original Message-----
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Thursday, June 20, 2024 4:12 PM
> To: linux-block@vger.kernel.org
> Cc: Gulam Mohamed <gulam.mohamed@oracle.com>; Shin'ichiro Kawasaki
> <shinichiro.kawasaki@wdc.com>
> Subject: [PATCH blktests] loop/010: do not assume /dev/loop0
>=20
> The current implementation of the test case loop/010 assumes that the
> prepared loop device is /dev/loop0, which is not always true. When other
> loop devices are set up before the test case run, the assumption is wrong=
 and
> the test case fails.
>=20
> To avoid the failure, use the prepared loop device name stored in
> $loop_device instead of /dev/loop0. Adjust the grep string to meet the de=
vice
> name. Also use "losetup --detach" instead of "losetup --detach-all" to no=
t
> detach the loop devices which existed before the test case runs.
>=20
> Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach a=
nd
> open")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/loop/010 | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/loop/010 b/tests/loop/010 index ea396ec..f8c6f2c 10075=
5
> --- a/tests/loop/010
> +++ b/tests/loop/010
> @@ -16,18 +16,26 @@ requires() {
>  }
>=20
>  create_loop() {
> +	local dev
> +
>  	while true
>  	do
> -		loop_device=3D"$(losetup --partscan --find --show
> "${image_file}")"
> -		blkid /dev/loop0p1 >& /dev/null
> +		dev=3D"$(losetup --partscan --find --show "${image_file}")"
> +		if [[ $dev !=3D "$1" ]]; then
> +			echo "Unepxected loop device set up: $dev"
> +			return
> +		fi
> +		blkid "$dev" >& /dev/null
>  	done
>  }
>=20
>  detach_loop() {
> +	local dev=3D$1
> +
>  	while true
>  	do
> -		if [ -e /dev/loop0 ]; then
> -			losetup --detach /dev/loop0 >& /dev/null
> +		if [[ -e "$dev" ]]; then
> +			losetup --detach "$dev" >& /dev/null
>  		fi
>  	done
>  }
> @@ -38,6 +46,7 @@ test() {
>  	local create_pid
>  	local detach_pid
>  	local image_file=3D"$TMPDIR/loopImg"
> +	local grep_str
>=20
>  	truncate --size 1G "${image_file}"
>  	parted --align none --script "${image_file}" mklabel gpt @@ -53,9
> +62,9 @@ test() {
>  	mkfs.xfs --force "${loop_device}p1" >& /dev/null
>  	losetup --detach "${loop_device}" >&  /dev/null
>=20
> -	create_loop &
> +	create_loop "${loop_device}" &
>  	create_pid=3D$!
> -	detach_loop &
> +	detach_loop "${loop_device}" &
>  	detach_pid=3D$!
>=20
>  	sleep "${TIMEOUT:-90}"
> @@ -66,8 +75,9 @@ test() {
>  		sleep 1
>  	} 2>/dev/null
>=20
> -	losetup --detach-all >& /dev/null
> -	if _dmesg_since_test_start | grep --quiet "partition scan of loop0
> failed (rc=3D-16)"; then
> +	losetup --detach "${loop_device}" >& /dev/null
> +	grep_str=3D"partition scan of ${loop_device##*/} failed (rc=3D-16)"
> +	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
>  		echo "Fail"
>  	fi
>  	echo "Test complete"
> --
> 2.45.0

Thanks for working on improving this test case. I tried to test this but I =
am getting the following errors:

     Running loop/010
    +Unepxected loop device set up: /dev/loop1
     Test complete

This error is from the following "if" condition in function create_loop():

	if [[ $dev !=3D "$1" ]]; then
                        echo "Unepxected loop device set up: $dev"
                        return
                fi

I was trying to understand the reason for this "if" condition. Without this=
 "if" check, its working fine (With kernel fix the test case passes and wit=
hout kernel fix, the test case fails which is expected).
