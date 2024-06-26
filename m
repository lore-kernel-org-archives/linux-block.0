Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB338248D
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374731; cv=fail; b=pgy7VahhEgMnffywpKOysCxV/oaEu0AbuGZ2WaQAF3ioKucFgpPPWV8XuDyeDEB11R1L3pN7a+ACbvZqnyZMPFpf55wi+QR0lo3GKHBg8eR/1WxJ6zDGT3HilWIq3SnjG6PnksqStX/hipcLQZfM22mw6FJJ+8eL7ZeIcSL0OW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374731; c=relaxed/simple;
	bh=lf9HAzuDHNj9WvfIdRKrttc90KiQ1tA0kbsDfKSF9LY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnebR3jJ59iyR/tGkgSBnCizLRX0kcVAJGRxypNDh7VZuLF7ZgJqvlOO4PWzhuos7ZaVqzbAHsDRckLCpTCsnTQlVqqL2qX0uZ8VmfpPaNP2i8Dm5g0OFCAlgWr37nN87e8oiMNkuQxKUiKhl8GIfC6ESpE/fyxjc51lzGjebWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZiAnAieu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mx4Xw3wa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZiAnAieu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mx4Xw3wa"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMC1ZA023005;
	Wed, 26 Jun 2024 04:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=5WWPsvloA+EFE+2WXf/gZoRUP4RSCEv961KZfSE8UoM=; b=
	ZiAnAieu4Wjh2TjviwJUZvM02Nzd9bKFeuH/e011h/qeDbErsY7tK0TZAZydCpyk
	G7+Y0MDdjEjAwUMfAmf/Nk2IsHDoukH4PgJhZuZ7xmsFelJfj2XBndx8HGMg3SzH
	Qs+qQZ6N35+SYQflJze8twicATsHhuyIDJsUjIdbx/7WQJYdr5U9oH02vDeA0N8q
	TweeXL0FYfCHp44MGhKyog8CGDFUJwzjdOQxWTlgi4VDGB10vBkaA2+JJBXCDnvW
	1kkKgEbLSbuFRZ54KhKWRyISQpmgyAUY/v6R6iFDgznUfEZIHtr3XvXKfsK278U6
	aF+p9lAtTNdg6k4NCCmBtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb28yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 04:05:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q2UFMc023336;
	Wed, 26 Jun 2024 04:05:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2f0jea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 04:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgRp9vBrj4L5aDZKz41iVJfn/qITxR7rc8nIj8j8FTDhyoOvTdJhBtqqxX9A1giFfNXscNxRBFFkSYRO5Q0Mvi3x99GvDPlQnfg5zMYIaEvHkfz25gTZ0E3v36/w+pvqRP/aJke6JG9weMj/mkqwKf7Y04DkES1C5v9bWTsZaeEWDnm/Yg2WWoar7C3KI0HhC97IrgAf2XI9NRbLoXyNyWShaJO/t6CRhRd1iooqLypggwV3UZkCbBRnIuJruBwGqo87xSuU8HIWPUSO8EjWsxDMWf2PW0FROuJ13oEuJTfhdgSNZJTYenCfAcvqQpJVk//+djlAH26zx3SlbeGFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WWPsvloA+EFE+2WXf/gZoRUP4RSCEv961KZfSE8UoM=;
 b=m2f56z147FuNervY05Vq/NO9ToFfCb5C6OgmACs+vRoAnwZ7IxauTDpdPXJwt8pMQFN3apBJ7HyrbJf6NE2K59wy6856iGVv7W1JH2j6qZj4oeRXUeJ0DChTs0baEVRk8yXeb9rZ/Yz4Uz61c+lHxrfTiEgxlOgkPJQHLUfDpC71ML6OLaXySiPuc8t3CwZ+XmEeyGVR2Hc0TTtjER+kQLLT8ttMNQD1wKuwRedBNl2G+eTwUzU5TmPAmXtw/Ny/+GfBStvoF1iA1QnlML/MGmjvZVQdZJdPbQNrPv1PmWgQig81nBVeXTzOtp3LsCXHfffBwd4a7Qu9N+uqjHEwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WWPsvloA+EFE+2WXf/gZoRUP4RSCEv961KZfSE8UoM=;
 b=Mx4Xw3wasWHFF1utRIErhvOse17Di+nLVGwH4Cy6w3051EqoR8c28kNbP/jN/3P/cNQSlkfANzrMdYOd0wzUB0wmoQb36bQIwxK9f2WSBdQHTwv9EGA+FnabzdtkIp5jMV3ngelrTTGo57Psh3ZG+IClP+V9jPce+a89EzNANvw=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BN0PR10MB5205.namprd10.prod.outlook.com (2603:10b6:408:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:05:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 04:05:20 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: RE: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Index: AQHaxvGqU8FGkoz8g0SYpqchRgg6QLHYbczwgADlKgCAABrjsA==
Date: Wed, 26 Jun 2024 04:05:19 +0000
Message-ID: 
 <CY8PR10MB7243ABAB4D3AAC5CF184517998D62@CY8PR10MB7243.namprd10.prod.outlook.com>
References: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
 <IA1PR10MB7240EC86C6A11788A324915898D52@IA1PR10MB7240.namprd10.prod.outlook.com>
 <guygrhoo3xlu2h7jcyaijhv4ygg6fiv4dvjgtxb654haoqgwrc@ob4utekymehs>
In-Reply-To: <guygrhoo3xlu2h7jcyaijhv4ygg6fiv4dvjgtxb654haoqgwrc@ob4utekymehs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB7243:EE_|BN0PR10MB5205:EE_
x-ms-office365-filtering-correlation-id: 2212f111-98b9-49a4-1860-08dc959531f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|1800799022|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?oEArf61WscLslPHcQ9S9VT8brv8i4vjm4xOvS0KOmzNffaZgyXNDR/p9KvWb?=
 =?us-ascii?Q?pJ+IctPnMAmT9VH3CMnMTj+UcDwceIRk7qUQI9Cv12NXcbNGwMFFyIlEwSn3?=
 =?us-ascii?Q?IGw7huVqoHzlOl7QRMz9l1jUKBiqbOwiDtgCntiLvWxSZKTo8oEnoB4pMDdL?=
 =?us-ascii?Q?XnCw/KVal0bWn/4XMFV4WDw2ooVW/PhRwMNtxrZXwbJZjoYnVxkfPnRjZn/5?=
 =?us-ascii?Q?Up5y8IslbnUdSzW1/Wz1o0UIJ8IEl2uLRI7gPM/IfIek18WJ+bLg0G9OKIU/?=
 =?us-ascii?Q?eUU70ReFfwq9IctvhrogHTQZgGXRT8WV3RhIMqdk3xvMgo3C/TWFxzVww49t?=
 =?us-ascii?Q?xBvcQ/R/8GvCtOX9P7M24CmYWiEUPOXsTVo3KVmA4+SYZ7Gky+HIlEDav3+o?=
 =?us-ascii?Q?t4q5XfyC3rKd0YeXRVSZXlSos5kswl+eg/jpSSFj7dgVU3dyCaT3kMdPZpMa?=
 =?us-ascii?Q?apBjcepiOuFQa86oT8IdD0l0vR/FL6jOCViMPmBE6iee03wV0Mf4Y6oUF2Er?=
 =?us-ascii?Q?evlePEo6HRIIRZCNnYbYll2+5YbxdbY73aHJNKcUuFrHcxj85BEGAjZHuz05?=
 =?us-ascii?Q?sCoOPXUBfkBCEwHO1+++lr2jhHrZ+C2uMks36GE4dSolg65MyUL7f/A9mwxb?=
 =?us-ascii?Q?0vP1xW43dKISvy6Si7GvZN9EGKTmtz5GykELYXK7PN9tLf3xAeK33mcaN3Lt?=
 =?us-ascii?Q?SjMcPyH838LjoltIRkP/8+F03qwCr0bXB+PDoPVefgomDm4u0eQL68PLcDrT?=
 =?us-ascii?Q?Tdq1erJ+9QLLOQf3wczwU8vgPzZDvMdG+urKbLS2ZtxpJIr2UBxTOrSE5FE8?=
 =?us-ascii?Q?wXIUEgLmPq+LSCc0S3aqPELwjTq7lWraEUgl50Al1SZwb2yBYgewvNJhRvsi?=
 =?us-ascii?Q?U6rtI8F3Du9U+qMeHgz8jClfzCwbbk7OR8n/rSboHjwJcc8gjS3iU5yBABkp?=
 =?us-ascii?Q?EVXp3MYNrTNGLYhS6fXZTbSIXzdL0z+TDUUZ/47zsgVv6cMAYNq6nKCLLKit?=
 =?us-ascii?Q?5YKU2aU6sYgrjtXyOxk0d8Q4Z93a21gyOhrZoo8KDOLj8QXyZQ5Xl1F2EwKl?=
 =?us-ascii?Q?ts6uEGJgNnvWCi+ubvRulCv90s7aro7iWAotOVo2xa+iI4x38ODPoXEcEFZb?=
 =?us-ascii?Q?HAVmw1dCDXpqdbItaGKxl/QLMBgWBLKeqtCRt+HjISZWxLs+8hYDqFLm4+TU?=
 =?us-ascii?Q?Bc4XCNgOHJnr33ShMScaQf3gm26K/q9QTZzLdFtMIPM060RWotaLuEgfvdks?=
 =?us-ascii?Q?byPdGnVlBlPPm/QuGmBexogq3Us/XUYtdZ+9LcuRxGlkswec/h/W9OR8nVIq?=
 =?us-ascii?Q?voWlPWQgF7kat7HR28AnY+gfKS6qHlc3HGN4PaBLqHpz0w7SC59wWRH2U8Tu?=
 =?us-ascii?Q?0cChzpx/IE1DR0kYrRQTao8PPls33UKwPFWycAETcib/RougkA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?nW09Q3tNihHj7eSjM6coHCU4X0VvIZWmTMGKoua30OhFzpb1MTISh21irnIZ?=
 =?us-ascii?Q?iYGvuHuvftIS6cospz5k0bSdFuNJRIMitJq0X4vPmTYAMVOpsYDgGfpNZ5wz?=
 =?us-ascii?Q?JIP87R2Fvv3hnUCoHyW8G/vjWAtM1DPIygfNhznQGRHQmXuO3sUI2sZmxeI9?=
 =?us-ascii?Q?QMm0F1JDjo5WsbtafntNitnHnVP9rgRozJz9OgU0GM3rJC0zAJB8y4E6plPe?=
 =?us-ascii?Q?ghpj3/13OtX0ZaUW3rp9rpeHaiVSGlbcZi8qVh3Mu/3CCe1dP9Hwr2ymY8px?=
 =?us-ascii?Q?mPNeZiULUSBvrgex5XsQJwFt1rsmuGL9QhzWYe7pOQceNR7FbSQ1SGBzvB5e?=
 =?us-ascii?Q?bics+rQTUIpyT/2MvDA8GXyjd9iZ+W13x4hROjLUDiw0mlWyrO+COWlR7zKe?=
 =?us-ascii?Q?55Y/OVehOdyaQB0Gm2S4j7h3w5hoBAGhYkFd4drbb/PHP2VMvnvbuCnGxW4W?=
 =?us-ascii?Q?sjefuJdMRqejR/oxv6kCTWM6sqRipCUy3RqbBePrbOULPFW9830rvUDXVeAw?=
 =?us-ascii?Q?tgs5MrhZ2D6jE5rIuxR9roDIiIewHWF5n/4lxFrpTQrpe0MnTdmVPUrCArhN?=
 =?us-ascii?Q?6w4bcjzr/OxZBRn+3Ww+LM4RDW2sW8/iQU5JMrAvOgNgheNxkLFuCtBACwmS?=
 =?us-ascii?Q?x7ZpOBYgkLVASI8LW0ccZhvikoDYWXqoyCdh9IPUlq+aTZkijqtpEQWi3GQf?=
 =?us-ascii?Q?8uetStWkYwfL71xIupv2YV7dsEdovhTCoQFHAW7P/P0Ad3t9CG6jfu3x5Wue?=
 =?us-ascii?Q?nHdvftsvawO9jbzlbWnx8FMt3Hmqvgj168/nMmaM6Dd94nNmoACWBF5JPWFP?=
 =?us-ascii?Q?g6AN/p2x/gdSd9Ijqbw1goOj7cwKU7mv+cI5LOo2WT2O29UXzHlXSmHTZnXo?=
 =?us-ascii?Q?SawGXy0V1Ue/kZuN98wQb1WF9TjiXrVapb71QvDTfstOZ26fA3zSuDEdNu0C?=
 =?us-ascii?Q?gI7gbOkGsucVbCmfoiRjc1cPtRPdpRbVcHFnxfKXmyqz0fxXrX5Hi/t16Dc1?=
 =?us-ascii?Q?plNPYE+Fxws2dtP2O+w8X4GKB5jRsN7JfeIBOjdl4yrDEwl+rvfEIKVDl8UE?=
 =?us-ascii?Q?CjEjSi7AWT/Bbdi6poKYRDCZJTCCXpk+L5ZHWPCqKEcaTVKnUR0e8jashPaF?=
 =?us-ascii?Q?lGexguFIfQbvtHNsUNrF8jkwLOzUUKgvSx73nkbvbJjxOeipkGCSIqWrkMRg?=
 =?us-ascii?Q?dXJVgukVbopFy8h9yMt/RxwAbfRexCCBp/yfmRTJKbNATYNVyZ/TLtl7f9Fo?=
 =?us-ascii?Q?FnLNUol9Xbc4iP+FLxPTyzukNkV3w1/92qSUZXmQzobEUiD/GHvMAptjpUQD?=
 =?us-ascii?Q?x6X7FiWKEL+FNnfQPIM8/xTSIyXZODLdRmw/jBLQu7ubKTYmnA+UR2iU5r2Q?=
 =?us-ascii?Q?0z5wy8eXiX4+7U5NqI4cmsMOHK0+swOnhj7aSES98dJxsdwv3RgT4JvGD4W2?=
 =?us-ascii?Q?9ykE8uTSnfzaUJSiusTzGpv0OZblAM8XmcLZnmnywvQxkHR+4eSlJuwi0iI/?=
 =?us-ascii?Q?GGJPfkZS0T1JMmhXkohAiOc9c6eCWOqGJRwI7QIxpv5TQKEYgONXXqOc0ZUY?=
 =?us-ascii?Q?Yj6q5yGpBUa6aQPvbcwXuj7HFli6qq/vqX58ERWk?=
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
	JdMmOOp7F8XeZr78RAYjvrAfBZwByDBVj7WJk03KU8FsU5Aqw5pWvyNQGS2+e6NrYWDYQN0rxJn60rXG5eml0PWdfG9TEDzhpiRLb8ypUktahY25wLnxgcpBlgzPdoG9BwqZkSCJi7Rlfc7T8i1EDd6rjQdu2+yfDs4KZq1eLMSRo73rbYxb+A2XjIglsRvIpj61P+l28xBt9FLWDv5CPHSq6QhfLRq7sNeg89uiOUu0j3NjGs/1TD+p1wwbxLdLco9PN5tTNl/EgOo2TXX/Qr07xvPz/a17nWUWuAfEqks32Mpma0OHkpt12c9ybQAKlRfmjsiNrSV2qyi/2AYlQSOxnU6jq/bdawQOitr414cglRGaawvabV0N5KLNTLCV2+5XiAm+IxlI16YuGkJ79h6IlSA+q5GcDoj2wQnPU7iRy7d/qLtBX8xHboRIVI5DXW2A7BSGGe3wUp7wZhML7dVKr2wCkYaxVU5AroHE022uNgX6LWW7G4ty+SOh/3QmgLjE/xcLBbxCxsTUbWcRNTLFjBQz2vrkt5aI7qv0JHdHLjbPrduiFZPnCsdX7Ba0/8pp04h493fprE6t8LM6rTh2P8bovDcJM4z1KEzUGco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2212f111-98b9-49a4-1860-08dc959531f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 04:05:20.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+mWTvgW6vhwiLvrxhCi5slxJJLrLDE5o6iB7PajU9rL7ePAS2jdHLTpxL98g6tr9OkbZAPnEEFyXhfa3zopX/nd/US0KcjdCDjhbxjp2yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_01,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260030
X-Proofpoint-GUID: B1NlspGJRheHoy1ogqHF_2JYIbyMLBqk
X-Proofpoint-ORIG-GUID: B1NlspGJRheHoy1ogqHF_2JYIbyMLBqk

Hi Shinichiro,

> -----Original Message-----
> From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Wednesday, June 26, 2024 7:58 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; Chaitanya Kulkarni <kch@nvidia.com>
> Subject: Re: [PATCH blktests v2] loop/010: do not assume /dev/loop0
>=20
> On Jun 25, 2024 / 14:10, Gulam Mohamed wrote:
> > Hi Shinichiro,
> >
> > > -----Original Message-----
> > > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Sent: Tuesday, June 25, 2024 4:50 PM
> > > To: linux-block@vger.kernel.org
> > > Cc: Gulam Mohamed <gulam.mohamed@oracle.com>; Chaitanya
> Kulkarni
> > > <kch@nvidia.com>; Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Subject: [PATCH blktests v2] loop/010: do not assume /dev/loop0
> > >
> > > The current implementation of the test case loop/010 assumes that
> > > the prepared loop device is /dev/loop0, which is not always true.
> > > When other loop devices are set up before the test case run, the
> > > assumption is wrong and the test case fails.
> > >
> > > To avoid the failure, use the prepared loop device name stored in
> > > $loop_device instead of /dev/loop0. Adjust the grep string to meet
> > > the device name. Also use "losetup --detach" instead of "losetup
> > > --detach-all" to not detach the loop devices which existed before
> > > the test case runs.
> > >
> > > Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop
> > > detach and
> > > open")
> > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > ---
> > > Changes from v1:
> > > * Replaced the losetup --find option with the loop device name
> > > * Added the missing "p1" postfix to the blkid argument
> > >
> > >  tests/loop/010 | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tests/loop/010 b/tests/loop/010 index ea396ec..ade8044
> > > 100755
> > > --- a/tests/loop/010
> > > +++ b/tests/loop/010
> > > @@ -16,18 +16,23 @@ requires() {
> > >  }
> > >
> > >  create_loop() {
> > > +	local dev=3D$1
> > > +
> > >  	while true
> > >  	do
> > > -		loop_device=3D"$(losetup --partscan --find --show
> > > "${image_file}")"
> > > -		blkid /dev/loop0p1 >& /dev/null
> > > +		if losetup --partscan "$dev" "${image_file}" &> /dev/null;
> > > then
> > > +			blkid "$dev"p1 >& /dev/null
> > > +		fi
> > >  	done
> > >  }
> > >
> > >  detach_loop() {
> > > +	local dev=3D$1
> > > +
> > >  	while true
> > >  	do
> > > -		if [ -e /dev/loop0 ]; then
> > > -			losetup --detach /dev/loop0 >& /dev/null
> > > +		if [[ -e "$dev" ]]; then
> > > +			losetup --detach "$dev" >& /dev/null
> > >  		fi
> > >  	done
> > >  }
> > > @@ -38,6 +43,7 @@ test() {
> > >  	local create_pid
> > >  	local detach_pid
> > >  	local image_file=3D"$TMPDIR/loopImg"
> > > +	local grep_str
> > >
> > >  	truncate --size 1G "${image_file}"
> > >  	parted --align none --script "${image_file}" mklabel gpt @@ -53,9
> > > +59,9 @@ test() {
> > >  	mkfs.xfs --force "${loop_device}p1" >& /dev/null
> > >  	losetup --detach "${loop_device}" >&  /dev/null
> > >
> > > -	create_loop &
> > > +	create_loop "${loop_device}" &
> > >  	create_pid=3D$!
> > > -	detach_loop &
> > > +	detach_loop "${loop_device}" &
> > >  	detach_pid=3D$!
> > >
> > >  	sleep "${TIMEOUT:-90}"
> > > @@ -66,8 +72,9 @@ test() {
> > >  		sleep 1
> > >  	} 2>/dev/null
> > >
> > > -	losetup --detach-all >& /dev/null
> > > -	if _dmesg_since_test_start | grep --quiet "partition scan of loop0
> > > failed (rc=3D-16)"; then
> > > +	losetup --detach "${loop_device}" >& /dev/null
> > > +	grep_str=3D"partition scan of ${loop_device##*/} failed (rc=3D-16)"
> >
> > Can you please add this also "__loop_clr_fd: " to the grep_str (please =
note
> the "space" after ":")? So that the grep string looks like this:
> >
> > "__loop_clr_fd: partition scan of loop0 failed (rc=3D-16)"
>=20
> I'm not sure if this change is a good one. The added string "__loop_clr_f=
d: "
> will distinguish which function reported the error message: _loop_clr_fd(=
) or
> loop_reread_partitions(). This will make the test more accurate, probably=
.
> Having said that, the change will make the test fragile against the futur=
e
> function name changes. Once the function name changes in the kernel side,
> blktests side change will be required. I would like to reduce the possibi=
lity of
> such work.

I agree.

Reviewed-by: Gulam Mohamed <gulam.mohamed@oracle.com>

Regards,
Gulam Mohamed.
>=20
> >
> > Other than this, it looks good to me.
> >
> > Regards,
> > Gulam Mohamed.
> >
> > > +	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
> > >  		echo "Fail"
> > >  	fi
> > >  	echo "Test complete"
> > > --
> > > 2.45.0
> >
> >
