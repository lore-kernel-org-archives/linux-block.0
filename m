Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE0192B6C
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585217; cv=fail; b=OjeqlnG+0gBtMOs5u3KqS9KVZmtbeZlddwAMKxbd+m72LRcFY7SveN1AA0B5BHx3du7+F2k9z3+weU/fxxfscSjVM6RcsrdB4xtGcW0++M5v6AfKsnHt0kT0rS8nGlz6btsP/VZYg3Hk3uu3Qg+EGbszPO4B9mbLm1MMe5X3cBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585217; c=relaxed/simple;
	bh=QgUK/HY/Ee8Br8LpHn0dLk+MjR5271KgMF5qv+Kss5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3MMjfU+DQcCKrWW2WSvdsNklaZ5hAWSJuMHUNdF6O5Wb/Y6wi/gN2qAQtDDpXTDIZhJ5hSqDj7Rrbdy06iJmwPexNUSjSEvq2SuMQJekUDmQYoMYlRL0qokfv2UdEMvCzQFtdD9FhALiW0uynp7GgiPrZN7FT6B52x5OXTYm2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNa4I+SR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n67auoxW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNa4I+SR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n67auoxW"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4551EYg5026336;
	Wed, 5 Jun 2024 11:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=VJdeJAbJ2cdspaxB41SssTKQqQJo28LsE+7Ndk3+2uU=;
 b=QNa4I+SRqullgU774p3B+qaQNTFGznDMGMdrJofHcKka4fp/hX7wPyLt6iREXvxnJ1NY
 wqCARJU42NSmbUjCafGJj5gaylW+fOOZ+iytFY2ePenoNvtX2upKXhrA7AeDAEcY66nD
 EuTpThPoZz56JeWGn2DiyzqcV8OGdvTCYZmaos0W5WjVLv7Ety8CzcO8Ouv59Kp1KyQ2
 +LQTffr61TQA2n58slUIxG0R4EzRueSDw+sc6FV7oGAAi4NIHViDM8IPy4sJRoD9G2rd
 TCeKr8TAWUZIaA+ty1yQOdgNpjmgEULd7kpPquAUEURPSjSaHQAd8lIq7cnVBINpMcXc Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn0y9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 11:00:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455AOMGN023966;
	Wed, 5 Jun 2024 11:00:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqy3kbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 11:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZPkROpEVWY7+QeoxRJLO7Wp06n9LKtuHHSiL6mf9twBtucKw0ehtpuL8Z4msMgsc03pFQWyeU3EyGIsRw4QR5LkfbjQmy/ZZGYwDLvI84/ZY0j4rPCsm1XAms9F1KgR9iAEW9H4+xgvUDtFIcTxpNNmT3cdEDTxwOtO0o6ai2Bg+d8q2BlbqPUFmnGpnhwldGTwf3GKMSVFtTw8vNJujcoorLSsjGs2WpoJfA+YkchlshhP5dv6sdR5L42sE1AFS9pOrFIlCzByGquYAETdEfrMhHsrhv6yL5W3Cu0exA9lYRYne5kbmad/LFt1YE/kxLTHCfvYTDPnWCg8aLNBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJdeJAbJ2cdspaxB41SssTKQqQJo28LsE+7Ndk3+2uU=;
 b=ZhYyLWHPj20+Z3CFXBWV+DNzksHkb+tDmbvyMq7sasCtxmsYPctBOr6ug48I6zfa0Hs6hralCipSLMYji521b1N1efZ+UKBk6zY5YJb2Kz53Ca6AQk1/yAPsylvOUiANnoDupyiKHfeZsCm46lMHgVvp4snW/gKnf8qRGSLgPcKp76TP0lJzvnZXas4x6aix5F3pNNSboSQBPJUE2cjmGeuXZ7s6cCXllgDc2XhboiuXLdjOMgTyFVWpfi5+P2CMEgQDoQY/pT2o4+ERjk/TmXs8qETlqCw4MRsmz48ZSyt+DKL9yDCzHcMNppPsmzscxCG9lIHBMWAGYJhpZzWPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJdeJAbJ2cdspaxB41SssTKQqQJo28LsE+7Ndk3+2uU=;
 b=n67auoxWRJ3kcgbHJJxJewsfhG1/lRoWhYvbEy9uiVX8iiNLpMc+44cPQ/YIMsUYEyWCLnS30iFiQo/7swjgaxYaWk/7Ijrx6R6SS3N3ip3jDtMhJJpEvn/GW8dUz97jzmZCg9Gmb1h0nXCF1auOpyl871sGjYKUBQ6aruoqloI=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SJ0PR10MB7689.namprd10.prod.outlook.com (2603:10b6:a03:51a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 11:00:09 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:00:09 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: RE: [PATCH V3 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V3 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHaslo7LGrJZSVauUiGTCt3iR9q9bG14nQAgAMm8yA=
Date: Wed, 5 Jun 2024 11:00:09 +0000
Message-ID: 
 <IA1PR10MB7240FC5DF67B94C82B35CA5998F92@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240530062545.79400-1-gulam.mohamed@oracle.com>
 <6wxosk3bjaxumrk5xsy7euifwvftspikk4q35m67tvryvculra@63zgrasrshxt>
In-Reply-To: <6wxosk3bjaxumrk5xsy7euifwvftspikk4q35m67tvryvculra@63zgrasrshxt>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SJ0PR10MB7689:EE_
x-ms-office365-filtering-correlation-id: 6cbb0a27-aa34-4c26-21ba-08dc854eaaa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?m9nSUYSXlpDItOOMQCDS35yeY02CunK5AkM0QpAtlzngs8DOnkbV78IKWvcU?=
 =?us-ascii?Q?TRsbCe+AA665Mmk7VkIzGuTs7+CVAairK8UmrF/Nvsl8P6wkbZGcztbib7D9?=
 =?us-ascii?Q?RNiYfezTJr+abdcoyggzh520mgkFz5uGISN4DNNHG73rli1M9sQm7bOUotDA?=
 =?us-ascii?Q?i0OiCfPQkU+97b7o6HQ1sCo5I6nxnFbdYpmbsdCvouPk2nh/nSwp6lVhH/NS?=
 =?us-ascii?Q?Sk16wz0L/RV6nZOAqlHYuWh1VBm9ib2Ar84fEkrca9g3A2wcFpam2vlju6V1?=
 =?us-ascii?Q?WaVaW2JWPWcsclwIMM+N0aMQ5SEL0DM/xqsxbCtCnUqJBmPGgLokrBxc0i8+?=
 =?us-ascii?Q?GApknDiccyLqTdPOLO3o4qH6FtaTUkMQXRGSo8frD6iefC8SYI/rDzCDVj5L?=
 =?us-ascii?Q?hSNmEA2TF5aL3OeHtAxJl/4tw61pqPXPMwuv2oKB6uMmPHv6BgYiLp+qn/Mz?=
 =?us-ascii?Q?e921dlYUvjbG8VRO/gOhbXqyZ1tECwXi6WNqcacLlqEGrvacyJBs8Mco8Rbg?=
 =?us-ascii?Q?HQdbVrkqXqMqz8Bx1ppjC1cdWy5iLY+PmbfDGSNs88F/gnmwDysZnhxjMW8n?=
 =?us-ascii?Q?QuUiuW7yOHom70OMDHBUz0gbbYPUPbAgvEjdTtg8if3XvuG2loAaZjmk/XJS?=
 =?us-ascii?Q?DfPsS3C/h90Puu/QD1wR6Nb2k5aNC4DYniAdPEkDJ6zSTT1Uq9rNMXCy3EtI?=
 =?us-ascii?Q?Uba6Yymq4JIZAIX96rPKFSbg9QbFoFWQW1/h8ETk2906B80eN3pU2or+DYEL?=
 =?us-ascii?Q?ExAKSTspDa6Qn6ZllpZoYgo5bWOR/pItCwbhDvMPBGX0luLx+8Q7R43AcM7r?=
 =?us-ascii?Q?rX9M+VebKawLA1fPjTsWRFD7BJgF1RmFuDoX4vKxyOBDLBSf1gqFv/TY8jRx?=
 =?us-ascii?Q?hW0TSOCWW48lntR2XYdO5nP8WoGKadqbUXI8ybtik4uH0mgz6TursojidRQx?=
 =?us-ascii?Q?efHN2q5E4KVuw3SsQ8NoNBXc8xx33HtL9lz7hOBBLiYGYCb7qWcRUYJfbYCY?=
 =?us-ascii?Q?R03he39rP53wG5mk+wQJu++P3rC0WOq8hUHPbEXxzzvfM9OlXcN0G5R0Lavz?=
 =?us-ascii?Q?KPmlE5ac8A++ZGXIQnR3Mtcoly6gDmi6D7ubMg0KXbmb5vth7SjlKL297Bzt?=
 =?us-ascii?Q?jAXEwEmuUBpWk2ENxa49QEfiICqt3nXMAIwaC/OxdayuA+Ze/aXHv41HyY7n?=
 =?us-ascii?Q?agaLz0gn5kjJqt1D83sFsvH+fsbMzlLruz/fix7v9gm/xxNq8aelfCGDv6UR?=
 =?us-ascii?Q?EV8RzREQrKXjXip3cb4CbmMJ0w8TM7qFPwQhuNqaqpAw18gnJO2FOzFuZjnW?=
 =?us-ascii?Q?7O4EsP/aTZcdCZQZM+4dOkpHI2Fy6jrLsVUBNwX0h43RWg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?42SAohda5I7OQyLv/3dXVuIBr+UDLYypUDP1eUZJ6j0ns7V/DThGpOP28Phs?=
 =?us-ascii?Q?J4SMBeOciwFTUMzDhiifv6d06JXV94JgMHu6LR1ks+juisCy0V60imoUx5Ai?=
 =?us-ascii?Q?+HcwptOTsfeZqVNcOEdDoGvXGMaPGplfawbkTVsNEZruScWAU0dlMRc0wH8F?=
 =?us-ascii?Q?HPrBdJTHc8SdD+9sMaNay15/BGCnUyn/yAbddUK+wBuxtZiUdDkDvJwQrO9D?=
 =?us-ascii?Q?nBQGePOeYZBQWSWLz5sWi1EUblxGZBeq/MYzzjKcpvJ9HSngN4R9hHmHKhuG?=
 =?us-ascii?Q?kLjoXOGDuIMlCNivy94gtZMNqYxTQSlCriCQCYDohp3Eq3rdiL3LplxvliRG?=
 =?us-ascii?Q?249fyBZJVCzpasF/b+0d6WD/Tj9YdfjXducL6hCsvHWGzbmdRhUyV2utc9QU?=
 =?us-ascii?Q?HHfS3Ih/R1PzIvD+4ZhqNu6S8IUgivXQzR0ZMs4GFJD+WgwEK3J1ejBVoZXd?=
 =?us-ascii?Q?oJPJN8/pH6W3CzhrQ4HCT4N31psE6Uq6GQvQX1tPmR1I0Hyo+xjVA24rjlng?=
 =?us-ascii?Q?8KzaFJvdCHiF2YrxgTfDgLhGJ4XFaVdsIjm8gnygqUYj0cbkkB5nqxuUjPT8?=
 =?us-ascii?Q?gPCMGBaxZoifJ0VHTGjxbMWhbnpWBqre96mBvyzcyIIbHxYeFdDxRr24xjGB?=
 =?us-ascii?Q?pBYxZ22iQhIrKtbAQZNaiBO9TPbE4PxftQVHVIKbJ4Q21nkQ5gEJSR5Ezuoy?=
 =?us-ascii?Q?hknn3akebl+gCpUIptPS2AJyUfo0gHQ3C/V3VupZ9HpkXaoXZUCOXEfOIMdB?=
 =?us-ascii?Q?x6l+JBNwhCwMf5ppwEq7M7bSNNClCcsjcOwsI4QwpsJ3Hq6gGFVQDqcf0+ia?=
 =?us-ascii?Q?3mTy1xlFBciMM1Q4KNpd6igm2bGncnQDoV6TfCtC8TKv54CVxosiFr1/pOWL?=
 =?us-ascii?Q?ydNfyij0uw9Rhsz525e8+5HhosnlVXuzSmn1hyVnaM3tYI2BUjNQimxKxHma?=
 =?us-ascii?Q?5cmO1IR6vam+WbkPyTA5/zbg6yDW08mspVtYSteR1EibwpCt1nHcKXsC1Tlq?=
 =?us-ascii?Q?xR8HJd1YI0Id/yjcRgtBA6E+DMxDcFzjbTKNaWn2ios4iLC7tjIp3mDzTSQR?=
 =?us-ascii?Q?tNGUmFUOSgih8QrfiROlq8i9oEaFMQ3eX7viWO1BXl0NSONISQpABku6tEdK?=
 =?us-ascii?Q?WEXHylJs0tx+WjLqPdj20ZvH4ZfKgC20gBIhG5sxc19VfW2Qr4v3y2S3OF/x?=
 =?us-ascii?Q?0ZxV/Dd8txvZ0MYEH8QQZo81OTS/bX4vtmmO98C4LvoN4l/ZtVRqzmVvGG8l?=
 =?us-ascii?Q?r095JV09emPajEB2Adi4HLu7XK6Qol0iM2f+e9VkH5aZvowO5ZhHNySvXVXD?=
 =?us-ascii?Q?fM5aeYxRm0TmZI4pLvJj0jKsJJd51DXklESvgWnBoVYKkXDixyhNfBJ+Ky6l?=
 =?us-ascii?Q?Q9r+KkM7IYE+4C1a3tH5F1OsuhOnuIXOvIQiON79BimdnUpjcKIuukJAoWeh?=
 =?us-ascii?Q?/tJcjpI+rc7nmQJDqEOV/34jiMPsBBlRsGldY3Ip977UCVOqTnLK+NpupKgf?=
 =?us-ascii?Q?88etEeaZZlqUh+X8vDt+1bsXJrYrIAFtlUP3AfnYrmPyUyGkv8nf/ix0oDMY?=
 =?us-ascii?Q?rnK4yvu/hKvE7pFCLrtROTSiwPPpKUUo+x6AJEy+?=
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
	f7xpdSPFn9zpTWLFZF6wqN5R20Qtu9lBdv4aUj3fNJnkEExsfBvfwNNQrTXPJDGH9Ao5f9kHLj1nk56cBh4dFYMSb4QP5KwfSqw36d6z5/7lP0FJsDQYKAvEZYYG8qSv1XLIauK3qzXiwYHQtzkwibM2UiY4FuS2HtJbkRIn+GNHEdeOJEc2ekpzPlPYUwcEptX+UDBosm8tGnK3HebOfBMpJcYk5qRF4sSr19kPUdPrDXvSgN1v5DvwfMie1s+OBmrfSZ5q9lgMt1DV+uBkwRx0nJrr/AX148F28Gl3VkAME0N6u0CXu9YXIcbmlb1V68+zIWcu8tTbzh7Tt1xNP46EDnZ+sb3ml4kLdY9CKBgiCe2nJxVRue/EzdM+08xYnsg7vXZgjQ7h7SzwsDTAI5sN6iu0GZ6VJ6QTbq/KCIraHLtwxpjniiOJ7/2uFygaLnnR1qAFKrg+tTGDB9YxjVltfA1MjbJPnhiHuyKwbWtGQaHyRmoeHilluRgwy7xcgZQDOUl+gHdEBnhXuxwJBcv0NKil8FjX/9SO0myHttwlDFGsqktt5l4wjZzCt2J843QnuRR0zbUx4QBLl0OywbHsgrmllkNwMp8eXcj/wIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbb0a27-aa34-4c26-21ba-08dc854eaaa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 11:00:09.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zibbMXf8rlpKhwrepMl/iUk9F+TesFHkTX/y+0G0YkOBNw4bIVzqR0rRxU1dbWVLffN90MMTMWIdYqdR9hsastO+qepnakLg8B6flihOBIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_01,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050083
X-Proofpoint-ORIG-GUID: BggQ3HMi3c8idBrY6TEHzm8x349QfiMH
X-Proofpoint-GUID: BggQ3HMi3c8idBrY6TEHzm8x349QfiMH

Hi Shinichiro,

> -----Original Message-----
> From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Monday, June 3, 2024 4:19 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; chaitanyak@nvidia.com
> Subject: Re: [PATCH V3 blktests] loop: Detect a race condition between lo=
op
> detach and open
>=20
> Hi Gulam, thanks for the v3 patch. I think it's almost good. I found some=
 more
> minor points to improve. Please find my comments and consider if they mak=
e
> sense.
>=20
> On May 30, 2024 / 06:25, Gulam Mohamed wrote:
> > When one process opens a loop device partition and another process
> > detaches it, there will be a race condition due to which stale loop
> > partitions are created causing IO errors. This test will detect the
> > race
>=20
> Missing last period '.'?
Resolved.
>=20
> >
> > Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> > ---
> > v3<-v2:
> > Resolved all the formatting issues
> >
> >  tests/loop/010     | 77
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/loop/010.out |  2 ++
> >  2 files changed, 79 insertions(+)
> >  create mode 100755 tests/loop/010
> >  create mode 100644 tests/loop/010.out
> >
> > diff --git a/tests/loop/010 b/tests/loop/010 new file mode 100755
> > index 000000000000..19ceb6ab69cf
> > --- /dev/null
> > +++ b/tests/loop/010
> > @@ -0,0 +1,77 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2024, Oracle and/or its affiliates.
> > +#
> > +# Test to detect a race between loop detach and loop open which
> > +creates # stale loop partitions when one process opens the loop
> > +partition and # another process detaches the loop device
>=20
> Missing last period '.'?
Resolved
>=20
> > +#
> > +. tests/loop/rc
> > +DESCRIPTION=3D"check stale loop partition"
> > +TIMED=3D1
> > +
> > +requires() {
> > +	_have_program parted
> > +	_have_program mkfs.xfs
> > +	_have_program blkid
> > +	_have_program udevadm
>=20
> I understand that Chaitanya suggested the checks for blkid and udevadm.
> Actually, I don't think they are needed. blkid is included in util-linux,=
 which is
> documented in README as a requirement. Other util-linux tools' availabili=
ty is
> not checked: e.g., blockdev. As for udevadm, many test cases use it (ref:
> common/null_blk, common/scsi_block), but no test case checks udevadm
> availability. It doesn't make much sense to check blkid and udevadm only =
for
> this test case. I plan to post a patch to document that udevadm (systemde=
v-
> udev) requirement in README.
>=20
Resolved
> > +}
> > +
> > +image_file=3D"$TMPDIR/loopImg"
> > +
> > +create_loop() {
> > +	while true
> > +	do
> > +		loop_device=3D"$(losetup -P -f --show "${image_file}")"
>=20
> Recently, we had a couple of troubles due to behavior changes of short
> options.
> It is more robust (and readable) to use long options than short options. =
I
> suggest longer options like this:
>=20
> 		loop_device=3D"$(losetup --partscan --find --show \
> 			"${image_file}")"
>=20
> The same comment applies to losetup, truncate, parted and mkfs.xfs
> commands below.
Resolved. Using long options now
>=20
> > +		blkid /dev/loop0p1 >> /dev/null 2>&1
>=20
> The line above can be a bit shorter:
>=20
> 		blkid /dev/loop0p1 >& /dev/null
>=20
> The same comment applies to some lines below.
>=20
Resolved.
Sending the V4 with all the above comments resolved.

Regards,
Gulam Mohamed.
> > +	done
> > +}
> > +
> > +detach_loop() {
> > +	while true
> > +	do
> > +		if [ -e /dev/loop0 ]; then
> > +			losetup -d /dev/loop0 > /dev/null 2>&1
> > +		fi
> > +	done
> > +}
> > +
> > +test() {
> > +	echo "Running ${TEST_NAME}"
> > +	local loop_device
> > +	local create_pid
> > +	local detach_pid
> > +
> > +	truncate -s 1G "${image_file}"
> > +	parted -a none -s "${image_file}" mklabel gpt
> > +	loop_device=3D"$(losetup -P -f --show "${image_file}")"
> > +	parted -a none -s "${loop_device}" mkpart primary 64s 109051s
> > +
> > +	udevadm settle
> > +
> > +	if [ ! -e "${loop_device}" ]; then
> > +		return 1
> > +	fi
> > +
> > +	mkfs.xfs -f "${loop_device}p1" > /dev/null 2>&1
> > +	losetup -d "${loop_device}" >  /dev/null 2>&1
> > +
> > +	create_loop &
> > +	create_pid=3D$!
> > +	detach_loop &
> > +	detach_pid=3D$!
> > +
> > +	sleep "${TIMEOUT:-90}"
> > +	{
> > +		kill -9 $create_pid
> > +		kill -9 $detach_pid
> > +		wait
> > +		sleep 1
> > +	} 2>/dev/null
> > +
> > +	losetup -D > /dev/null 2>&1
> > +	if _dmesg_since_test_start | grep -q "partition scan of loop0 failed
> (rc=3D-16)"; then
> > +		echo "Fail"
> > +	fi
> > +	echo "Test complete"
> > +}
> > diff --git a/tests/loop/010.out b/tests/loop/010.out new file mode
> > 100644 index 000000000000..64a6aee00b8a
> > --- /dev/null
> > +++ b/tests/loop/010.out
> > @@ -0,0 +1,2 @@
> > +Running loop/010
> > +Test complete
> > --
> > 2.39.3
> >
