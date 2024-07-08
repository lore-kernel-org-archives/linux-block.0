Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19807710F;
	Mon,  8 Jul 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430253; cv=fail; b=c3B/0o8Erqj5bqqzwkiCFXC+ewlGkiqrFz4K3HQyjVkEJdnz4/0mtRstQ/82sKpw0bdx0eGr/zFbyqhXmDxyf3Lp3y0cRT30+NeK3zQPawMIkJPOfCreIWeWdF0BNMUBoKWRsvvySuv2QDakCqbpY06qVswz3gJ9qohJF8VuYCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430253; c=relaxed/simple;
	bh=3tflWZQLtRGG6xTnvfYoPxw/rXV5vbtF/V9aonOj6SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DhkpCWRAbTlTwuObw3lRSVc3mQEERp8sqtNwZLpitHvYGZvJAHb+DZBtWyJk4Ymqv6+eEG9U9ss91+kNVYFBzqjHuAOBi/8vQQDqs6kpDDoR9AjgOeNtsIJ6QiC3nw1BDzMjfpVYOouiqxhFNkTJkFNdPqfzDMFOnW2nY0v0KPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J2tcbxRs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f8uBIf0H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J2tcbxRs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f8uBIf0H"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fSPa011849;
	Mon, 8 Jul 2024 09:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=slIpfovpSQvVVayB1+m7u49dtx9OSvLetXSGxDcaX8Q=; b=
	J2tcbxRsPZdNluEZQcpPU7Zgf3tnKmOXcRQB5NcbHeFuzvTBYqTfeIC0VxRs9toE
	j0WZIDrPSmkzuDlEEBeZMbZLryOBU73UwxtW8ywDVVLQXsxUWWd6SiCE5iy5paLD
	La2pYlDMI0ZLyz7n8G0TARZkQ25Oaiu22sOYRqfR4BF4U4Eh0MXUWOCrmtjRZUyS
	hNWfS+BqUlPmqhD0mr/4TTlaNYegI0L30RKOgAPt+S5no0VjHYEpfekHpsPTdZoN
	pu0airDVfUo8lHNIfqfgk+ZHsPQpCY4jHuRxENu8mxJoN2hjUfRFsMJjCTrw91NJ
	ZzRMZV6xL9AMG/DQ5NRHJQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybj6rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46876pfi013662;
	Mon, 8 Jul 2024 09:17:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txf4x2t-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFbDiaZffyk/B72IOoB3cdz41/D48vvKLqCUCCuxO/WAjT3RPTMt59rCgvyPQnMwywoQLd8L0lw5u2RY0Bo/b6Tkgjp1n9m9lKU6m14oFpJo0bNv6YEXKttwHWEzx5sJ1CG34TzEMlqb9zmrla4OM1mzwJ2isO61A6VifDpyT4eZOnDPOTaaQkXq0helBa/Av5Mqdet8STeZocMJ7ZL7v1fXd5wO6MHGuZPvK5akf1pZGl9S9AW/HqlnykJWgo2PwE9a9ptdL9oXwhSKBucKudCGxeVzxEGbf5SyUT9YnVoE474JqNIWO9gmDw5yfXK7R5TkRyjRF6LxmXtOPKL4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slIpfovpSQvVVayB1+m7u49dtx9OSvLetXSGxDcaX8Q=;
 b=NjEPYlaI1mwGOiuGVetLpTCHMVVik8Ww4PgYBGoO2L72J3OoWAtFkGaaWKFCPdBRUiYK3NLPni4SVlvQ9PItvpdFSNo4M69FcSJmXJsvo/OT0jbh2p12H3rOS7JP/YQozhn/1LPxdMjTzjhxsi49AKpGr7FQUQ9lMZxmL4qshVVBiVUfrE5dMhbVfIIvS9AgesDoNUSy80LZ3n4U8LoswVEC1L0qzf0M75IUBlfkH84GxQkvw4Pi8ldLvVHMh1QpDnY8at1QwIaXaF0VBT2rNOYSPcDV6GZGx2WDBJOLmjlsyOO7irj5czHWhK/3xe2Hp6ZVLtAkx8Mn3tGdxo+pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slIpfovpSQvVVayB1+m7u49dtx9OSvLetXSGxDcaX8Q=;
 b=f8uBIf0HSQXgh43aZuGR0dwZwU1sS9PuT9ueJj2OqemHKbCf6B1s8yzVzP1x/2XCjMHkWQ0eQUuUtHQfGS6VXQ/r40EEQGuP8KfPRKkVNGVhburPABsK016ziKjQKB1ewppFRJnVntnFSrz72FLflZBu8APFx8tb0Zh3tmU1KJI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:17:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:17:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 5/5] loop: Don't bother validating blocksize
Date: Mon,  8 Jul 2024 09:16:51 +0000
Message-Id: <20240708091651.177447-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ee9666-6c38-407f-75ac-08dc9f2ebd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YoNlw8zXNh/3x3jvlSt7nD/1niMSD+cY+FUovfWmHZ3Xb4Rrj/hHDkvptlIG?=
 =?us-ascii?Q?ZGugOZluXbXtQuhAkStdQ7P6SGLF+fy4/zCE+Q/VCEmtJ8mop2zEWBuwdD+D?=
 =?us-ascii?Q?S09lu0pSSZffu0xUdsOEeQ/w+b8gXqXjN0FwpmEUWKQjc72Gnegdfs0Po5Qa?=
 =?us-ascii?Q?Qkodvy3ica4gAPaDtL2P/0g1AJ/j6RpKA7lMg+3vZCnWq6FedXaodIokmwjG?=
 =?us-ascii?Q?ZEnyXT6CMHytgdC8kc7wu/BmipQvZ3WRrhRKpfQkhcA61uyqwv9AzYKSdh8G?=
 =?us-ascii?Q?x/rXEvvD/QGT2yvK14VupkStooulUkNynJRSG1YW6n0j1QrMFJFV4g73096s?=
 =?us-ascii?Q?0f6geyEJE78myd1ZjbkKMcnqUDK4trNB1hXl/j4rMEmn7rOTUbLLOhKpD+y1?=
 =?us-ascii?Q?7xDI+ZNPMuom/tNseSb4abwXbgvJX3fDg/vSEde/NRUyHlehT0hww9AC6eFH?=
 =?us-ascii?Q?s1CTpSBL9RGH8JG+Ez8sw/DYMTJJ03Dx+v7ZmJ5HBEA5bMo36xBnhUbnSQnK?=
 =?us-ascii?Q?aZAyY27GkfJ9rO0CN63YHFCVeaSBO2+EMfdPErzlIa1Zp0XYOXsV41cQAlcU?=
 =?us-ascii?Q?kxtE9Wh4ekYUKo5ccJYk953tVA74B+08ZENHggjZcKkq3bt1f537/bSoapbX?=
 =?us-ascii?Q?xKdjIC8d4rSfRDTm47zaSOdPctUOalOOqYmDqX3Er/eLD+vuGTELye0uUSGp?=
 =?us-ascii?Q?r+40P2aJAmlww2Wh9QR6WUBuu12mB7Pnj0ZgadkFY3ccttHygQKawxF8aSAO?=
 =?us-ascii?Q?TdA8MHEFNk+pKdLECKMAk+eDixs/tYYPU2HSPm9ZwdK3porIWEfkKulfFcHd?=
 =?us-ascii?Q?xOxpAnDdjgHKHybvnS0v5vgqU+6kXcsVOm79ez9yCIvLKhIM9D9aNbS5Ku1F?=
 =?us-ascii?Q?m5f0fZRbbcD8eLzHeMKiH3ZEbq+Tf9J2rbwCbJOTkP/CcTAWoWYTKs2Sr8Fp?=
 =?us-ascii?Q?ayxrSPOTB3WGUAgCrxUN/OBr/gFsDR2ibjoprOZtnnnyDZ/jmO3XwoBc6HeW?=
 =?us-ascii?Q?ODYfvtpT8JO5jO3lm9CHcPsBndVqhyYCiJmIoShOc+zmV5Fq1a8+7sUbYEar?=
 =?us-ascii?Q?A4Ww8EHmiNW7XEfA21GpcC38KY9TFk2M0c6tGgO4GuVgV5KCLpXCCTy3vHDj?=
 =?us-ascii?Q?UDmX+gxlhqBrjEX0oN4rI2OT3BParQHMYxR1/JwGdQ0YGQ3yxmGFj7bixADu?=
 =?us-ascii?Q?DXZa4/X9GbvfgVwspRD+0+tyZB8dj9OfBFlKYLVFaAF6JvgXYbnM3otOP1p6?=
 =?us-ascii?Q?c03sHFM/UEforWDbPr8eaM/QYx/mifix968BnDDtAhQ0TVW8ql5OJRGNh5Ze?=
 =?us-ascii?Q?WFB8fnOkqKXTqS9xbEG06lQU1Z6yxJxpxfOYSqBorgsDJJQMAzHuXFAhOoGy?=
 =?us-ascii?Q?yDOebKG4ckK6VlbDxQXEEH6t0MtO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LjgmDzPHhTOWqqPHbYqENYjkMZmMpT+Ri6jMsdjdoUgejVy6KkIJ5w5gL8dz?=
 =?us-ascii?Q?OOx0sxGcY/ruVVBiHFlTgBka8rrhLTDJ86Be4UG05HEOpg2BD61PlEj7qa2+?=
 =?us-ascii?Q?GYO0UtlDF7GfwRxUodBAgY9SPLmc/xd5XyawoBDhZmqtbRaX0Y5W34/d55O6?=
 =?us-ascii?Q?tByyNgr2EjggynNG+OQu4PBlbOFt96m27/WcZJUeZQyZX7lj3BffXzDToWax?=
 =?us-ascii?Q?GXT8EAbkWG9j1hviqaVRiZ7bv5NJ4K5GcXOjDRPTtv/ZQMUFboYP1nwyi716?=
 =?us-ascii?Q?CyzgGU7KnZf0ZlYwvES6yfcst0V04wIip+M/MeiluuqVPiDKl4AF4oXRq+yW?=
 =?us-ascii?Q?cW99ennSj8xHNfx7KEa6v1wpGkCXkLZgGQ0uWiLykGWfaGDR4fjR2GEz/AcO?=
 =?us-ascii?Q?vzvsNA3HSNtHbOwB6Zr/Mdh+rmVT0/tKrhBtSaYDrt9bYgg/DOTZ7BLDW/mR?=
 =?us-ascii?Q?0YBzE29i23+3AMKhaCX/ZeGGAjm6ZxXKildD450LzYE7ic5zvPAoTaVn+feh?=
 =?us-ascii?Q?FEREaCA66S7dhTL3WQ0PYiFzJ987Q6wG0SUrdAqb1pMl0PBt7pLlE7PPllCi?=
 =?us-ascii?Q?X6XTl6XeSIzseag84ypcyAsFYJ2101Z/0RSM2XK/CrPzwe0zr4cfyl1yNeQh?=
 =?us-ascii?Q?uH7DqaDcjeWVgJVYlWu3PG8KZ0wJlU7vfrb8xFxr4N92CsFOPkC/Rderpp8z?=
 =?us-ascii?Q?u85YT2Oqm+er4CF5RgS43ZU/iwtn59RCf6k857aG86+V0A4qXXVG23iddmEb?=
 =?us-ascii?Q?B1C1Tkc1APiRNdhvJx1UjeXwS6XDJ2FwF7OVq0arMLIQpclwgZ/Y+m0MrceZ?=
 =?us-ascii?Q?rRN+sMMlr05kHfbBovLVCQW+evVzUV4nXTsSALMT7PUmQ2s/RMMh7HHMqPja?=
 =?us-ascii?Q?OAQmz95EBv+M9PKV0lNTLZG+lFP8BQUA/HXXUTbohK06UYdfiNlpN4dLdz6y?=
 =?us-ascii?Q?hcgGXXfVsC3Xv1wer/Oh6H0SLfCvTZ3Z74Kj0kkgwFSyH+zaE8o77b48j3mV?=
 =?us-ascii?Q?I/WoPREsgFJPRtL7nM8uTNEDgsDtAyR3e7YdJEHWP3KCZR9UoB65lPwVl3J6?=
 =?us-ascii?Q?RBwyjzh+0LjU2Fhu0d2iH6EneVg9MBbOsTPYN947wiJm6k2P0gF9dJm+ltT3?=
 =?us-ascii?Q?uTU32AtnYXcgfSJ5wzeenBnVWjox7qGTqEkLSMbZWmDtqcRSz5n3VHogcQLN?=
 =?us-ascii?Q?ACwQwVEjP+hbMHWo6bgEsAn3785Btc4jwmYIkSNHW5HJ60iawcKKPVHsRea6?=
 =?us-ascii?Q?PoczK1f/3H1eA53dZffGTRZr4rleUOFDKzvobyTyP1s5wql6I0uLhqIaHwki?=
 =?us-ascii?Q?dFf5jwaGaTtE/NUtR9Z3wrcjmAiy+Isxfb3C9/TFEZqaF1YOmWaScEuychSm?=
 =?us-ascii?Q?PbihIzXkJ7a5wrbT3pqyXpzv4qr+Sai+bjXJtilB3yVbGXVLJRfqd6zVCS5O?=
 =?us-ascii?Q?vE+Ro71JPpwJAUc9ed2ppZNfe+cfkCul5ARhDbDSmiOJStJJuMYJY41DuAMs?=
 =?us-ascii?Q?kCQhNRkOybC7+FkhDXfsJiJZcRTn5G67To8XaOe9C0J6zopqJpk5lwCPKGxw?=
 =?us-ascii?Q?2OoE1lbgaUK0fdKjHugb8HFjXkZUqqARuE0hAiEdSTPPnGZEYBxGuwBNkwQ9?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VaQ+Py/cS40arRWjTnbRHaiuMV9ycH8axbP62oYGmaAGKMunARb5kZpLmLwK5nH+CcLnhhZuNh2okPOSyMtyWAhgbsmJ48g1RjNywPtz9WMYwHEhs8leuoI3VoTtTmQeWo0TLcIW/4bRwo+RJp/wMrDQ+6v4h18sa+ig/5+WVazs7XRnYvNGQdcA+SyeYa+NDujSbLBsTawHSBxD+B77acyi1j9Gge+UStr7IeRGHyw/0rfJ300YG1218EPtkdq2xny6jRpbvEc5Zt40dAlfpNBm4AwbRw/1kDi/Ca83srlW3o0BmZj9t3FKc80gA6WyLUpHwsLCoZkgNah/cGuEXWWtR2/bR88JZCLI0iIRgxS4/q26oKKaQJI/hLHBO3JccNdrn7EUdgkeDnYlx5jhc4sPxn32i3YhKgWDGMzJv0xrFqfYAuPLYrgoG3YfKKRHLAzJRjwiQOujLIH1/CkOl4xCRYMf7IzbxnD9iLKJdoGokvTHpkXusus0IYlhQB3H1IVYwIiX7HU8cwRNy6kXZnlZELXMPxoyKFxkvAsxfl4ROH5TCU9TQI+Ovw/1GmKLtTw65S2T51wYEtO2OaB568qj343jAZDHK9kghEm77Nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ee9666-6c38-407f-75ac-08dc9f2ebd0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:17:06.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwGrp619uCp+BvwxJQnpwFXE4PapcsoPyX7ql3k7Hi3VPlNx1QYJf6zw7bCHBZ7hjeNkK3ac/1thzRRcDlEpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080071
X-Proofpoint-GUID: FXI_4t_ox04WqlG_kQfEdIChC7njUc19
X-Proofpoint-ORIG-GUID: FXI_4t_ox04WqlG_kQfEdIChC7njUc19

The block queue limits validation does this for us now.

The loop_configure() -> WARN_ON_ONCE() call is dropped, as an invalid
block size would trigger this now. We don't want userspace to be able to
directly trigger WARNs.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/loop.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1580327dbc1e..736467dc3ca7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1061,12 +1061,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		goto out_unlock;
 	}
 
-	if (config->block_size) {
-		error = blk_validate_block_size(config->block_size);
-		if (error)
-			goto out_unlock;
-	}
-
 	error = loop_set_status_from_info(lo, &config->info);
 	if (error)
 		goto out_unlock;
@@ -1098,7 +1092,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
 	error = loop_reconfigure_limits(lo, config->block_size);
-	if (WARN_ON_ONCE(error))
+	if (error)
 		goto out_unlock;
 
 	loop_update_dio(lo);
@@ -1470,10 +1464,6 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	err = blk_validate_block_size(arg);
-	if (err)
-		return err;
-
 	if (lo->lo_queue->limits.logical_block_size == arg)
 		return 0;
 
-- 
2.31.1

