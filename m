Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC779187F;
	Thu, 23 May 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489562; cv=fail; b=jvWcapbjigD6khmbM8Ub7lHlFWlW6x9oWnAJIyD5Ny3ZEwTzOh8DFb8dJjQqBArAfidqTZF9uFWuvbqEhTFY1uCFfY1marWzJV18x73ZmvMqhJDPVJhkDSL2qbK3IqCa0Ah+Fwk/sT+lkJkCWfI1B2EaFt77YOyvwM/6jGJLl10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489562; c=relaxed/simple;
	bh=lIWSH2woGXehQkQSrwR14GjDHUB7jc/viSw84yUzUJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVV6Ea3mW390gHBZ+KN5mjLPm8czf09FGZVjupuYzZFJ52JpFp07QisRSiRosskD+KBzpoooXZAppUZedX5wzYE/1h+kNHWCLtOJ+Np/a9n/EmnUUJp4XO1btTyx+JQV4APGT6cHS5D0Qji6mtsGWGDhErPhdj8KHvyBWJjburs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cDa8cn2N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jfvpFYBr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cDa8cn2N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jfvpFYBr"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NI7PlN030257;
	Thu, 23 May 2024 18:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vVq5y6+ealEXR5DHGp1XOhX1jkOguxwhIpOnD+anIGc=;
 b=cDa8cn2NEOUq9kv89S6uCvKTI2vMdiNEbQEbjPmus3t6cAcef3WOttlgjofa4X6ReseA
 GmvGix74y5uiaQxwGfH9+E7cmZgu2WWcVPzIXLaK2ZoTJ5+MHwVvvUeyuNdoBK54Zjk/
 zdTdTKkC+rUa/t30Vp4WDWEmqfZAvb23QkRPIA2Rl1IPG/77wf6V+6hN15mlE/OyzBzy
 Wv7IFwwDU9zhTyFUFKqAuoNUYaunT8jEcBC7Tl974HsNp5pge5q1FrnI4kr/0M4Oomp7
 kEz2OIRaZMRP4x6Gsy6iXDhmeSQGtHLTWSAh9iTmaZuhVtes09efkNp+5O9GzMrdQ8C8 lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jretrn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 18:39:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NIE4i7005043;
	Thu, 23 May 2024 18:39:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbbgah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 18:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2JTZ8Iy30LIG7G4pwrIpLfeuRfTapNwr70PtIXVVSs9FaINmXLuH3kRO4bI7BPIya2N6QK1rNNt9hgRaWG8blN6s/KPeopTe+r0J/YX7HfEe4M9MHJDe20LC7ealcgaebsxuT3jaTkR7L7GFtMHCb3A9INCSEG9a7Q8EQjRi57iHyWtIUI8gFqxzsTllCH2QJ7bhSbOaacTt7h8AAF84d1sJNIBi93fd6lORs+vXH6H3xzvsxUJKWgFjWrttT08veVBbgaCUMZrODoI5Z5dwxo9mst7mY5xNG/Re70+F71NmDl0cYDTPqk5MZOsAhgjbNVA8U/G8NmuXIRz5yBm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVq5y6+ealEXR5DHGp1XOhX1jkOguxwhIpOnD+anIGc=;
 b=CD0IwiJBNJEW0NIWDUVObQYboNpqzuc2Pvk7bFZ/MBG0fO7FYbwgpYI5JSZbEyfeeCQSc1NNd11+BvG9ZxAVVsgwTrizzrXbax+6tAAeWS21PBh7H5PzNTzjQShoaKDczAjfzEIcWXB01M+rO8at1jamSmJdOIrA+w9xIbToaAHmVtzu0AfbiFVZoo1q7X9WGFqd7+q4iYjWUbk6cyk56IydyGoDHny3jeHuqc9SVx+8c25QWFFvgZrH49BqxTtOl0RLtelijaPKgrlg02X1zVj1wCmEsJho6e4PqFNpQXrtoCruihFKqe/PXxpleGbwkmpGsY6PajVAYtJMS9ul4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVq5y6+ealEXR5DHGp1XOhX1jkOguxwhIpOnD+anIGc=;
 b=jfvpFYBrc6lpQNL6uD7HMXT/5iRxACMBi5hlgtRNhJ9PzeYpLmKf6NaugANgYkaZ9CwJ9hNuI6Y0ax6WTmTLPMu9suA2cg66DDfBZ5tkVV//wVxXnWY0UlbPSiEx4UBh0wkyqFkK2QyA60Y37X1T4FWM6rk8Kmr/IyL1MfiIj7Y=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by LV3PR10MB7772.namprd10.prod.outlook.com (2603:10b6:408:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 18:39:10 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 18:39:10 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>,
        "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: RE: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Thread-Topic: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Thread-Index: AQHarOjn9QOSb4ihfkuolttTouVFhbGlI/Jw
Date: Thu, 23 May 2024 18:39:10 +0000
Message-ID: 
 <IA1PR10MB7240F50A15D30D77DA7DAE8298F42@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <20240523081207.GB1086@lst.de>
In-Reply-To: <20240523081207.GB1086@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|LV3PR10MB7772:EE_
x-ms-office365-filtering-correlation-id: a839b0c2-6e5a-4264-b7e8-08dc7b57a311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?GoQC9ZfeNHmRdEZkH3XthgTrbRYDQStDdOsrr9Zn4Ojevzc7l+28BA7LU5nt?=
 =?us-ascii?Q?YbbJwYmLLoky+ivNSInCUw9e3hzRgA2oNKDFCtv9dLdZB+TYtno7CzeV7hVn?=
 =?us-ascii?Q?O5k6bNJ2oQreQGumhFm9v2q9EvhsEGOhnUV5eWx6GDlmr2ldigJwJuG629W2?=
 =?us-ascii?Q?4lzFlpSE14O+oa2aKGdDqvZwPWvJZO9MgXrlWS0cdHeU2oNXYquEgJz9igBZ?=
 =?us-ascii?Q?DWcdd1i/U1loMQA2i6McaV2AGucOaSqDG1blsx+8v7H6da/5/8BOUe54BI9K?=
 =?us-ascii?Q?M/B3x9lIF8HN0kiUsWfD6kSNYMdd0keNeVzWvGwM56UWaZkNu4tsGwz6uAxh?=
 =?us-ascii?Q?bQJnQd9yDcNRPktk9fQGKWeoVjaDwwiZuinBzDJhDvJoCqojzBfeCeBSJBVb?=
 =?us-ascii?Q?hFdU50Dk8eCAYkkDgRp8w9o5+47tm2bhOWCbH0HSqMgwvry42i032seNMDs8?=
 =?us-ascii?Q?qhAG3fc0JFrs1kAFfSJVqYNwvSbGlPGiR+Dphg4aHmBnDMfgD1V0Z61OnJab?=
 =?us-ascii?Q?lYVUIAY4YyKN1Q4oKu0KdfnE2dGt7MXiZusJM4b1QjXUt5uHODzY0BN7pyXe?=
 =?us-ascii?Q?wKG9fSGtnWp6Zt/bdBYO9Wi0pMQ7BHF6ioY+H5mq5GrPMbawOdPsEJnLWbOn?=
 =?us-ascii?Q?6lgMUHQdiiqsV+eoSmfwBGhAz4GtCRLFufFg/CO9S4jWU+IueOdGRtrK+hWn?=
 =?us-ascii?Q?GzcsDfq8qC2K/14/tC1yE8ASXS6xQZqwqhZ3U8rC7AdchzjkuJJ1G7in+COe?=
 =?us-ascii?Q?WOGoJX54UZFCtiFiXfNU1fiA5dFYqarcZ+57n+aD8bo8Y4NAtBhu1YtZw0Mt?=
 =?us-ascii?Q?DPDdQ50fwkhhoT9JwsnGsmZh8K/Tw41dhaj704b0jmVH4Fcr1krGMGF8hYwK?=
 =?us-ascii?Q?IvOrvl/k/kHX0FRiYVk9sAgfDfjPVYurwKSCOViYsgCcWc2xArYQp8v+L03v?=
 =?us-ascii?Q?Zzrmknv3ya4Dl/mmZjACXDBazhoZNCh2dzcqdehiA34NJisF9QVEaQhyhd32?=
 =?us-ascii?Q?QKyje96qnxDx8G9xxSMe4cRTXGXM71lpIM/3nbMh2HkzKCactsThMs2cBc3y?=
 =?us-ascii?Q?kMIszIe1V2rXpGFqF1+Dert3bOtpNOs+6xkAdu0Iyhcaj6t+PoxXTzztArcA?=
 =?us-ascii?Q?8p7Tk4hXg0FuNjLt5YEgq5si7ELqPuo6jul24YI3T279K+25RMXYO54Y8Gr5?=
 =?us-ascii?Q?STdyesTDukDDIHRAsvWF2TYlL89B+OyIu7QFIpx4Z6BqKZ5PCoGTzdRaz37U?=
 =?us-ascii?Q?RevqBHcIRF9YOGRx6IluXeCk4EOrbQ7l8ZEAxJ7X4dxufZ8dO26FZBI8FJgp?=
 =?us-ascii?Q?ptyAIf83ZvBk6cjbE9QZsGqQMVdADV0ksoXezY/KOv1xRg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jFIFr2fsO1+i1FSkWxCl3tc3mOym61nR+rUGyNaVFCSgreBrFtxRjgNblU7j?=
 =?us-ascii?Q?rRPEXkta+3XQExayl4JesN/3zpZndZ20PDfKfQQNVrfponoTWoC2/1WQLMSU?=
 =?us-ascii?Q?Bf/+4ljePgpUYPb8qZPNqm9zXQaKuMUq8JPozSDxhe5gwvROgJe8ep9ZrV+x?=
 =?us-ascii?Q?DwcW4N0Kxa8CslBQZx0HH31qlVc9NocoqX2J5mvg9XxUVIxRBMWsApJCTqxl?=
 =?us-ascii?Q?4P1IK9/purgMODrfhnQGqcWseH1gtny4gCJcVoNi6kgIVwi0+9mzGkJn0K82?=
 =?us-ascii?Q?cK7GnBQA0ZUnUsND8SY9JUrvwLUsYe95uL/fLuRIiCSvdlq/0jBJaU3wgYmZ?=
 =?us-ascii?Q?nmPJ/Uy2aS4CKVBWmwRz649HT/aZky0FchESSIiJG9adsGrRDyeWzpYcIheu?=
 =?us-ascii?Q?/izjIyZOKQTjA/ak6QqR7dQX7HhA1wIWXHx0DyzyhAZwYhdbGqB9ldTGExW8?=
 =?us-ascii?Q?tk8qkjOmneqn4CTM3u03R372NUoXpBpMjMyHXBbsUfuKEa+vyaneriTH3/Z3?=
 =?us-ascii?Q?3+KFtqP9+kSUwucFOsC+pbUorB16NL9pFp3u6f6Fnm4s6q2/NIT/4IN6Tmte?=
 =?us-ascii?Q?mD2ZcNNQKiyRfb+mC8Hj0Yp+G0hIe1UAd/TPRCiQkulnCzPV4hDCqxE45Qpv?=
 =?us-ascii?Q?MFXpIQju/fnc8ifakw5b3xMO+onajPKlX8fJ0EFXFf1zKQMxFCmtjeQm7mry?=
 =?us-ascii?Q?kQQ2TDWlkk2hufjRQdPCZH03J+jPZDsSdQtT8DynTpeYS4dYby0gWTFmBeLt?=
 =?us-ascii?Q?cZuqWZR9vqo5/KSNLA8nyX3tRaOlJ/jr0gNma2+arK5FVFDUkHmZhzl3uLLm?=
 =?us-ascii?Q?+NA8yF00Zl9e4+Xpb9z1KlkwGUvBsPcVWkRdwin/uvw1Unjb3XK5TJhkaZif?=
 =?us-ascii?Q?ToeKP4v6e335sH87o+8LvZEDsr47S0qeNiHYKjyCf7xq07tXhx6rEM+1MnFI?=
 =?us-ascii?Q?enMvEP5v5bx/Ci3/VY1Zpe6QCn41332joQS6ElXJbH8CzDaRbdFFDx/LcwGB?=
 =?us-ascii?Q?0DqXpmrnVIrB8rx5B5a4MlmN0XWPANusQRFze8dqNss3Y8YgWBRfU7JK5Bfq?=
 =?us-ascii?Q?UITIHHj8sWx7o4bnM4gXmeKdX1/oPY9xEhM1gNTrJaxp6rKg8BmnAFm/qN+3?=
 =?us-ascii?Q?N3WWXPti5ngbxekEn6TgjT9qDbKnvLQT+9NqlqoX5uHxm5J2Fl0MS4y/NOUw?=
 =?us-ascii?Q?ZVb2sBJsX3eDWNfa8CLw8iPgejlDJcdSD6zGQ9rzKrbIavpNX14V7yoqQBPE?=
 =?us-ascii?Q?2beEprKsOS/LhaINfhNNtXnel51A7Xd502AEnVo4FbLNqgj8OskH8bkz0nTD?=
 =?us-ascii?Q?4wiBUadQKjzwB63wYoZPrL4N8kLFM1n5GWN+8yhazg5O8AiAAl8wnhq6WJdp?=
 =?us-ascii?Q?ndnoSeY8x3MrijTAvYooOwFanjbvVkul1Mhhd1jZG+OoomSIx0hYdLtrZrte?=
 =?us-ascii?Q?+Ktkl6lLkXYk4rt2opHxbHm454IH+79KMYn/TxbMEQOcDYaOcQHXw430Llnk?=
 =?us-ascii?Q?RPxH6fJt82jYkzjh9ISJVPcHaP/WE0cAnhvcW+UR6dIcI/25kZ4xGxmL6Nec?=
 =?us-ascii?Q?2xUx2mUA2PD/+dEcm6sx8azmPfqcH0wxfRiOiu9a?=
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
	W7HuVhNXqDZsc7yIDFIf1bnnCq89RaseCcezYuvCGI6/NO2RIfzkFFLFunLVVy3r4OJuXb2/0BsES5lBgWWknzb7ytc1XovsvlkTa0ihKnZdZaxy8AEjkKO5cULBFQDNdBr5DKVEnBg8JNjP+DQhYoTzpOdstX3cOIFRfikZU80TGJt67V15oJ/EIOaHd1dqVajObk//1CD+bHRuyyo5WKnz1VhwAhKMIq49twLkFbQpsr0LUUo34/LjnT5ODaQOiHiuU3dgnOBsirVb7nLslECQoitCDHQOed1hE2BqvDaa/pnBz5U7B5qLU7+45l5j1MUnZOlu1RKZRgKieuEgy/qAuUZ5D7W+w40Pd5cr1TNrxOQfTPVqfAVgZ+vmjTy1yftldataF1m8wYkLV9FIyf/3IXuqmqCfT+UYQM+pKA+YP/eMnPgqLNY8l4Jo2OOHulXUR+SInvnbHi+/VyfCEystOEgzO4f2iJ49kMauPqvxy51EiZ1VTExJUBGaGgki8hZYha91hn/UvRHQnDSaUBgU7AFy1yZHbVV+tvHoCo3FEioUKgOw3KB00XdlAh0O8gPd3qZobC0TY/5qbw65T8HmQM+INAjrA4ylf0NEU58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a839b0c2-6e5a-4264-b7e8-08dc7b57a311
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 18:39:10.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HL94gpioTZZjNxArZznX8W43HEFeSGK8QS4EppER+ZyRfoFQv8Exl6AH0lTrEPAfJixXRGnGz9q5716Wg3RWnRIJw5hNYko5C9s3pslv1ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230129
X-Proofpoint-GUID: OLuQ1K59yuKDogx7U8My6GMhX6_s740m
X-Proofpoint-ORIG-GUID: OLuQ1K59yuKDogx7U8My6GMhX6_s740m

Hi,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Thursday, May 23, 2024 1:42 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> axboe@kernel.dk; shinichiro.kawasaki@wdc.com; chaitanyak@nvidia.com;
> hch@lst.de
> Subject: Re: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
> detach and loop open
>=20
> On Tue, May 21, 2024 at 10:42:48PM +0000, Gulam Mohamed wrote:
> > Description
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> That's a weird way to format a patch.  Between this and the odd subject n=
ot
> matching patch 2 I was tricked into thinking this was just a cover letter=
 and
> patch 1 was missing for a while.  Please take a look at other patches/com=
mit
> and try to word it similarly.
I will take care of this in the next version.
>=20
> > V1->V2:
> > 	Added a test case, 010, in blktests in tests/loop/
>=20
> These kind of patch revision changelogs belong after the --- so that they=
 don't
> go into git history.  Or even better into the cover letter, which is miss=
ing here.
>=20
Sure. I will take care of this in the next version.
> > Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> > ---
> >  drivers/block/loop.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c index
> > 28a95fd366fe..9a235d8c062d 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device
> > *bdev, blk_mode_t mode,  }  #endif
> >
> > +static int lo_open(struct gendisk *disk, blk_mode_t mode) {
> > +        struct loop_device *lo =3D disk->private_data;
> > +        int err;
> > +
> > +        if (!lo)
> > +                return -ENXIO;
>=20
> ->private_data is never cleared, so the NULL check here doesn't
> make sense.
>=20
> > +        err =3D mutex_lock_killable(&lo->lo_mutex);
> > +        if (err)
> > +                return err;
> > +
> > +        if (lo->lo_state =3D=3D Lo_rundown)
> > +                err =3D -ENXIO;
> > +        mutex_unlock(&lo->lo_mutex);
>=20
> What if we race with setting Lo_rundown and that gets set right after we
> unlock here?
Similar race was mentioned by Kuai in his comments. We think these race con=
ditions can be resolved by bringing back the "lo->refcnt" ,
by reverting the commit a0e286b6a5b61d4da01bdf865071c4da417046d6 plus the a=
bove Lo_rundown check in lo_open.
