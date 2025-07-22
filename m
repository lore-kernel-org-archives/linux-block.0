Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500772DE1E5
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180009; cv=fail; b=E8SVT7H4SRyb+xSy7SqUBh4QgVEAfVDI4PHKxXwoTQIQoxsZI9I9bETPMMf9uOps/1HsHtmlp5T0s1QNxWMoYYiyC2g/17YjYYmzgg5zlJBoTXF1oPMCD+92r9IWlRAe4LQ729ECUdImoUL0hVIwNmM9EsvfX1D5ioByF++zGUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180009; c=relaxed/simple;
	bh=q3ztvAlwhZJKuExfXtK9b0lhTJPBKr++xKIu978MMbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjbQQBNev+9GwtCSo5yvLWVpuMyxpln7ndjhUglWSBYSP69mLSPInoKA7LIz61jLTig9lEKRygiNH+KvZiYmueor0SDf/VBLb4EOi1xtTVR1iBRv0mfAWpcjGu5TATjCpek5uj/MRybHebTh8dHjJ83ITTrVD7U0qY1h6P2xssc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gNmxhb1F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P+lH7+sZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gNmxhb1F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P+lH7+sZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCuA031648;
	Tue, 22 Jul 2025 10:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P+Dlv0s3EILA/Enf8BSIaQmGqgWqSN94OxiScy+Y2aY=; b=
	gNmxhb1FwAUKGo6yocT+SobU7KhSG7iOl7p4vWIpip3R6o/h6f90QtiUMPPU9wSv
	5xThx23VW0TFsq8hsITpmB1v4jjG10823hosKIEy2ezXzYg0heWovexwrUN+FoZV
	Tmry4IHZtzDUzda/PwPUYmWFVkKtT/S16wwGtcWZoBN2VKu8qRAzqWdHKbpJ6j9T
	CCuLSeKuIkBVICiYw83f/u+lW1P0tpaiv91RQllZgX9gAhuSS0TxVkyqW7MayWTo
	5H9ZT184T5zcXNiThrkMAzeMap72zV0fDKAaazy8QkX/Z+qbAFkJL2tJoXI10SKk
	jsweP/UuQabJZs8XQwghfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576mtge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:26:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9Hp5I038405;
	Tue, 22 Jul 2025 10:26:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t95p8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN69XkKVWl+LXjGKmMoi88uVgbiAW3vqM1VZEig1Jngl9MW7XVGyG7YEGDuXA8AqkBW0C/ZxD2m0MCrWpNNJSR2fRLeI2ZqiQp2y55nFLuqYxEME+6sP9ukS10bVkf2dNcyP7QMvhs8qPmaoaEbgUEq4+zfPOeGk/qNBuG4tFUIHTMBYYoY1EMRItywFol+P15//0+dFbK0DoiuZ8/bl6mioX4BLRJFmpUwn7fPZoV/jUI6GxfPEpWV0uSLpbVkUx5A+Qn69IGNWVGoVU6Q92YW3cg/IaSDme8eDL+/8VVKEs/zaesu4mOXFetnb7jzLevmu+HGKwVJDHKIWRW2WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+Dlv0s3EILA/Enf8BSIaQmGqgWqSN94OxiScy+Y2aY=;
 b=PcRvf+gV5O2espW6sTvTYurxG9bZ8IeNY7ju9UmbYBa9qa9OpiGvFAIgDlfPbNrFDMEgvGXNcUiwmJ27QRjHthPsJ404SJ60xd5L5YJm5S1o7W4aOHKZFZxKW3vj2UeHvdZfzyuGY5JhVBhhcf7g1BsNoxK2ihYk1B2n/mUf0jYLlGUznDn2h9MBRD/905uxFMSlrB4fbAIYqTLk4WMUr0fd5b/+Mh3/+neZ3Hc1od3IGIUnSh170wF4wFUPk8wzG9xQ16pxoRjMW40xP1ja5BLL8KCyf5IH+ep2NWuLSxjBRTeNXVEtyG7HNfMKZrgKlzZSVbO4dY6yFVQK79rlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+Dlv0s3EILA/Enf8BSIaQmGqgWqSN94OxiScy+Y2aY=;
 b=P+lH7+sZuBL9JNjolG8EulGtDtZrrhzROq5BR9STtwQl+fyxKKbNnamEstR5A11+WnJwYBY8kaSHT7tg50v5+47TkxMhxuNEfAPbHz8bS+HtC/F1DOo58uzvVz32SbEHAiSt+CBo7XWAO1SU0ymPUoH5HsUgWBcgFpwCi+l8IBA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 10:26:41 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:26:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
Date: Tue, 22 Jul 2025 10:26:20 +0000
Message-ID: <20250722102620.3208878-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722102620.3208878-1-john.g.garry@oracle.com>
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:510:33d::34) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6463b4-ca8d-4bf4-ee36-08ddc90a3fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKQJ2nladwypVAX5Q5fVLaouCkRpqRG7l75xmiFHTOJDefgSx6/9HwgqKk8G?=
 =?us-ascii?Q?CGOYYEYZ8z4y0kdz0VU92AdlnuKSgOScJFvosB/eORIBBG35b4Efu8uTCYjY?=
 =?us-ascii?Q?sDCaCyeaajIO8sJAchTgFSTcI3GUwsLTc5ENeF62Uxs2zwze1VgjSOaYpZdV?=
 =?us-ascii?Q?z7A8QY6WAxuD+HVZBrUab6CBZpG1oQt9HVvY28QwjBwgq+xeBB4ymsqnY2sU?=
 =?us-ascii?Q?rQoCjsRfBPDilK81HmhA7R5IeMnymmMTs6qEhvbxQ4elWidaBEMT0rfIFCGm?=
 =?us-ascii?Q?FltmxgYHEMijavJ3e56Zxwl/62rXSK4gS+5TLoJoybHPoqGcrOFd6PVK3VEL?=
 =?us-ascii?Q?2BpN2Fxm25nvPTqWLoGN1dQaBl5k9LeLhbNsHnJFPJWfYUb+w8+UTKR4+PUU?=
 =?us-ascii?Q?4dXZjjx3ZCEEkHzrVI/xZBklrAuiv9AqzegoivUtzbYXYrJ45UUO4FmP+VBn?=
 =?us-ascii?Q?0ZRfd/wzyBYJRjJ4JnF5dOCU95f58ydYQwtdXL3ngydueVtABNwE5vTM3cGU?=
 =?us-ascii?Q?dgXBXiHBzd69jgGqznTrJKuEcz8wOVcjSUVl9424t7uH5HngTx6We0xblFir?=
 =?us-ascii?Q?a0pD7jQ2Np/ITBLhajljeNIcNAVoM4drLIbM6U4hgq95MInKm9Tw3a0OACIf?=
 =?us-ascii?Q?vtOS5BWxTDRBj0sw3+XQYfdnDpFdV/jXe+5A5QSBlaw9jMO5I2Kmr9Ykgb4f?=
 =?us-ascii?Q?biNb0urewGLJUe/ow2HHF+j9BL5LcsZFHJhZfgRmEJ/lH0/sga/UGP+eTY1F?=
 =?us-ascii?Q?PrPor7TF6K3x2C4+8y7q5QpNvkIOzBL+nPoi3JFs+EpOGUrQtoX+BYm+Er2X?=
 =?us-ascii?Q?tL7p7sg4oDtw0lL/mwbcNaxDg9SgLdQoSOEViUJJr4nzonuj4WE2jbj0iBs7?=
 =?us-ascii?Q?7rxlN0WvQRxkgQ+cMrTBtWeoo0fOhaWssEDnWQdNoZcbRnPN45mSh0RNcB1I?=
 =?us-ascii?Q?ZrcqEU6GldPFsEORXnS6zss5KgkGZYR7AplmXsUSuTz9SCrVIqCcs9d/2yKv?=
 =?us-ascii?Q?RVRpv+Qt5wqmFlVWSEkKEuBJJ+FE8+6JRejUCuNQ2REoP6U7OpH6QhyyzxAh?=
 =?us-ascii?Q?gq7B4tTvaqnvWLxCzF2Xsk5yW7c+lWEDUh0GBE9v7976jzeaaD5FC+1UDywC?=
 =?us-ascii?Q?WVU8AqWxyy2DoYQDlhUzVF5rS+nPVlPCR8y44Ww5hoHoDXEKuHCOY2wXUdH9?=
 =?us-ascii?Q?cCYDaVU6jijJHkG6+psZSlbZQjPUmKPOaYwKJsM342F/5Hv6DwwCKJP20bqU?=
 =?us-ascii?Q?l8SWAQoUu0fNUH8cl0g/iLkVaLYcrjq59mgHsQezBO5fJKaN3bwNcoDosyoa?=
 =?us-ascii?Q?HjSofqaCzkiunl9p2DJ5C6URnjCx7TfwMLTJFSy5egadjdl7+9TdMPu/w3KI?=
 =?us-ascii?Q?VeCOPzxcMhlj8HUGTgWq9d9bj7pLxNCBWsR4cOpYFYezRlqlSLDVT0c+tM2m?=
 =?us-ascii?Q?oVnP4wnqMNY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I8OwMdYnnyCZ3jmfLSVY4QcW20c2LkkthSPUb98osDys05QuSKC/B+oei8P9?=
 =?us-ascii?Q?qrS1fkDPz51zj/SAOd0R8186HDUsuNV4mbM5EbMyy646Jdg+Qx4iqrHywhDR?=
 =?us-ascii?Q?KddTSCM/HItRaB8uWIdKLoS9YD29OPJc0/IL38hoUK768RvFgcOy5JX9Ft9n?=
 =?us-ascii?Q?N2c8gKysxUlYghhNbd1eOClOFl3XAkijna14dZE9IfRKLT36oCPobsPY8UoZ?=
 =?us-ascii?Q?SYyJBg3zNm15M0S5KR37KEMT9JPoRxk8u15kgGAw3jUb6T4bQmEh6PTjmA/x?=
 =?us-ascii?Q?toaRjLwGzHT+4uBueNvHwQZM9g/nJL00Kg44IId/sOkceOIsIVU2SyHdyelo?=
 =?us-ascii?Q?F/Pf+KRkwVBYN2tPDJRaRQIwab7COT+n96MMPKm/qqnJrPcmfCBO+lAUgNps?=
 =?us-ascii?Q?PyNta0K9x6Uum46XtUUxklPMqcF9qg1bdpU0wO+7teM+IuOygZIoUmRGZkIX?=
 =?us-ascii?Q?D+im3ZFTWJQnkJSWq9mB3Db19seOgrpXJ0+UZrOn2jBgl82VxrI6TiKM2Mvx?=
 =?us-ascii?Q?iwESkx8oZXxq+A/0ltmwQepp5YUHxoDVht9r3S2uLw3BZkpFlhXeCEAPj4qT?=
 =?us-ascii?Q?to7qunbOkiG3ptxbdZq58+dEFNI86SL9v0EA812giZKMhoayzx6a8Vzd8XNf?=
 =?us-ascii?Q?Z/At7QJGbJHgfT8LZJUz9kzZG2wfRskuF7n7zdpiKHnuzNckdhyAEScX4Qdn?=
 =?us-ascii?Q?1aoTHHF6unBfTPapYa9TSERpx+msLJ2fR9evc/yseWiuJ/+q3WyUsQaJdpZ7?=
 =?us-ascii?Q?K9OOL7zTxTtKYHAIHqdiqBHs0+g3GRp1ZZc5z+uK2EC+wEA8ATM/L7TFNSpK?=
 =?us-ascii?Q?RiXHGUGDZ9pGknQIjVDMSIRj2hZPgsbjFMzq06jn2yoAboiQ6mui9SdtE7QD?=
 =?us-ascii?Q?VG9cmgANKJkUMzMeToVAmzB6l4xBKTtd3OQzdNT5OlwEphwM6Z85sNw8wMtR?=
 =?us-ascii?Q?idjzLXZticb2FePCCK3N0K6FQQSdOZpGVWol8pBe2u7RihpjVj0UJmx7idFZ?=
 =?us-ascii?Q?fxJ7L9x2LjAbPZDDfi+r36POod5yAog4l+isVd4WJlHw8EXZ2kQ4bSF64Wg5?=
 =?us-ascii?Q?U45u25rlqM+H/UeAqNfsNUXcXKQGL+i5oQySOiol2/fvdU9JsAT1atJ1pGxi?=
 =?us-ascii?Q?I0oK3ofs+VSlpTni8q2+FNtwUKuvm6s35ys2aMSX1+P/LLLa9ijYqlc7RAKZ?=
 =?us-ascii?Q?kDPSr2Vb0RlJHKFE/+IlIfu44AYogKy+qx9dquZdv6yUpAkqD9xjvtVU1dox?=
 =?us-ascii?Q?sDw0ADbW9XP0mrc+TApmk8vSJBqq77755pMSfI95+l4ghCByYSByBLfj4xYk?=
 =?us-ascii?Q?IFQwelzaGysSgNtoCxfhS8J3W5lLN0J5iaIxcbeQJz0wNRAWZVOuOMz+578F?=
 =?us-ascii?Q?UnLq20J2USK6rBiRhUHThrDtPbbSUdkrBksj/iqLRqm63IE81woLZFRPgKkH?=
 =?us-ascii?Q?ApnrrMAcNgZPAYE1W6xSxQxAKOA2WDluAmH8+ZecyHz7P4TJIfxJ2C9tmDr8?=
 =?us-ascii?Q?DGfYRPa/bJKczdwf754MaJa8tZKl9Fh3Jjl6N8RR2UGn1TpaFKVd7xlakhY1?=
 =?us-ascii?Q?UTXPQzy5igOCrp0IdRpn9FZ7BfANPuiePwinP7x5KsxUnjH7SeaUB32YpQrT?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uBxsHKiIh3m+vOiq19BZbPviTJQt+v+51WMqgdw1gteDTOZCVKFtxiEmC1Zyb6OV2+4MNb6e3oVe/Ri0EOkbYswsO2Ih0hB4/6X56LMMOWYyyXHyYVT/VQV1J5k2jzFnWW0MvXvuGgEo2zBAAlVN59K5nVQ2Y0CfUDcBoynGGlkZmar4k5//6jkobRhnxVwDvVMi0A868dANA8QPqgu17z2Wk+ZAGopMy28yw+qgtuPLrAO8Kk538j02xIwoZciSBlGaOnWZ+Vd6hCN27fC04+/YwpENHR1iu3rStq/SF6BXqsZsh7JVJ9am8kZ7TF/09hLdtkscXeyCfAJsulrsdUIJWDeXC1CIXztd8RjqFvB9shvtSa40rV78c+sXr/SgdL/mJr8YSXhMEChNl3xGvdfBBu1cxYo/wVktq4Vi4VUHdOkR1tFMA1283Ayav84VQsM66eYU1QP3X2/YupKuly0zrTu7yPnQiRcWbfmtMAzGUV/4rsFD9076LOqrt81XqCTHUE/3JF5qBL+YxAWjkxKwFgGucQygzVXnrB3JR/of9730wmtOIshX8HtEXsTWoXbmoB/m3dTNRd9H8KGdcD4W97NvX5yb0S9q0iLXua4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6463b4-ca8d-4bf4-ee36-08ddc90a3fa3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:26:41.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: comETUl1UlkyOVueRYd7/+yRa5NhKK9YnCxKEbDPaOZ+KkGJjBD6o6+eheMzngFZwg7wE2sFci9M+LRT2LkfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4NiBTYWx0ZWRfX9kLCUrDFGCgH
 83oFrcHKxvXWFftsxyMfpYxBkRwz6Ourjs/2egOelctvltV8CPBq0kGqE9KY0PE3tCEjCK2VpxN
 774EWhtCvTPSi4/Y8DwjIpsoK6QZ/7rVSLWAomgnShVmQGTOxUpEKGLCy1lO2uNsmKi5ryclBmx
 jJ27DZeY/9KMXrmEabEaI3vItBIMxHEJnY+6ZN8QEwzDUpnNoGVnkrJ+rEEleFLuOPHoD6i9W0U
 7pbx4zo/g2WaRK3kq8B1agTQzYpgqAB2YLR48TIYw9Q7LQ78mWjsVr8S5rwCaJ3wAhfW7ck0yJ8
 QI0UWNwzBAL42NgIO+2fZfryPLIp9zSZa/i41LocMuIzcKwFYKFiz4UR7AogYKY0zBfS6lt865n
 FCE6ZtLOMzGvPRoLbVVRFViam9TDx39MvromVrbEqp9MvC+zgea1fK/3ZFmv41e33KjkAwXL
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687f6764 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=Sh4RhOsKXrTUby8kZCIA:9 a=zgiPjhLxNE0A:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: 30HoikLqLrWnQtCkc9Zl_AmKJ63oU1T0
X-Proofpoint-ORIG-GUID: 30HoikLqLrWnQtCkc9Zl_AmKJ63oU1T0

The merging/splitting code and other queue limits checking depends on the
physical block size being a power-of-2, so enforce it.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index fa53a330f9b9..5ae0a253e43f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
 	}
 	if (lim->physical_block_size < lim->logical_block_size)
 		lim->physical_block_size = lim->logical_block_size;
+	else if (!is_power_of_2(lim->physical_block_size)) {
+		pr_warn("Invalid physical block size (%d)\n", lim->physical_block_size);
+		return -EINVAL;
+	}
 
 	/*
 	 * The minimum I/O size defaults to the physical block size unless
-- 
2.43.5

