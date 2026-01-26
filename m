Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836D335575
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432516; cv=fail; b=Egh1YL/6AAhD903hQkxpn08trRtuwU1ZCi6e4hRGed4QbJb1Oan6HmLHAebK41kT3czZLLiWVNiUz9ggazVLWjjRM8M5q6FOISLKMEMcs/dmNuN5Y1qJQKlaIX7IvsnoIbEeeFHUKaTwfsggOXttlnRigmTkoFG2RpexoA6kTsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432516; c=relaxed/simple;
	bh=6gKtgGhpxSyq1thr8o8SMXjVYLpn4cutEtSVsV9Gv5k=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=XC2/ag4oyiGs4X3+bIrLIMTtYBTWmbhb6QYSbSVZsr3RAWFIamV/pzleR3o9n/7ySUj+C05RaDqZD7oPHYfZ3XSvBWZGXxOsnsE5/B0h9H3JugLeJiuzvDF9BpH+odLX2+5jZXBAHdmsRvcUjeBPw4fEnxA4SGijIEzwptDKk6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eyKYnXOm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m6H85HUQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eyKYnXOm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6H85HUQ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q5A1RR924035;
	Mon, 26 Jan 2026 13:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/P0QCkk3plWN+75wfg
	4Xq1MxgIq7V3XOQ7nUdMpxDWI=; b=eyKYnXOmhf68FpupY8ci5DnGvqJFqce1JD
	0AzteQogdZSdUL+uGhJQvn6MN/XE0GrRM17/0r6aNA233q0MEIUHnRDGn4Hn/7HN
	UTZMyb4309tOC8aA/evj6E80fhB3+nV9urGMKhb4N1I8zgvSpufQ+LVM/AGts5PN
	/54gA8RY3COoPnepvwevjMwu3CbZLZY8W1yocn2hDFuFESlKIE2ayChs/Y5SnJlv
	YL3WDkNTPN2c0ElEr+HVIefhVvRV/new7R7Fifat21Iy4//T/9GweQMd1lup3Ctv
	w6ISYw9FQgKDMdUae1aWSfdMKOHl7EyIazYy8E0RTLwfqiIEfkAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmgbst5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:01:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QBTbRT032686;
	Mon, 26 Jan 2026 13:01:40 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7wmsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVUqWWAsTxFt9Y1kTidk2I1id+7ogWgmb9tVkx9C0j3gGJq4e7xu13351GItqN10KnkaoeBgW1Zf4enw8eixgorYnbim6HwkD4VKBtubxe3Z2Lcgd6lLWLRq+lwiboMt2Ck3FPbc4GTbhMxmGhxkXtKOcIBPuwj1zFAGcPVSfe2uraSK0bZKqClTmQmKIws2x6b46jQuD5/2+fReUth1gWa3bHOG3VSzs1hMFk/yFBps5ouLVDMbGXzaVRbUGfKFNaXv5wSCgQOVukyObfcGHrPVLH06d6kizKAbR+i93qEmpH9GA9xMS6M6rfY0UijToe8PzwQP9kakL8m+2RdglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P0QCkk3plWN+75wfg4Xq1MxgIq7V3XOQ7nUdMpxDWI=;
 b=qq9M1xbnJT4mneujjN1uCpphQHS9MUdtdz8aXnAF5ncjZ1KrYrzuL8CpkkGcgynVIOFg3diWERSP579uRpa6hqOdaPwDUn/ccyZQxiAiTpsXQ78ne+QtgPTxs/m+5beLR89rDlMtYm53O3+XoRir/y5OZvcZg3B0jmRKCeAQ18XpT7otmjvlafb+dpwa248CAmrMkCGwqlYPs7riZLil6L+mkQICFIHUKY1oN0LKqbYlXZHH06wlmZenwN+BRKJx96nXFgyUOdhTZ0cddInhImM3fqd0OHgmKrMuKUBqMyMm9i3KvDWk6ITmtJuQ6Gh+saneZVlRxszVLxsRgF0Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P0QCkk3plWN+75wfg4Xq1MxgIq7V3XOQ7nUdMpxDWI=;
 b=m6H85HUQ62OnkH7nrTAaMIIYbtP6XBKH5HsGlc3n5ycqERnn5tYEbUWtORcQLUdvbKAIcEtfUexhMfVFrxPkioCyQIbIOHRyG1BRnRrNbEZ3++WGCQEvMxjO7fLgIp/hZAoINGaRWgeLQFt53OIUKEZ9ZdBxkISOYaJ0+WxaDLw=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA0PR10MB7384.namprd10.prod.outlook.com (2603:10b6:208:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 13:01:30 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 13:01:35 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, Nilay Shroff
 <nilay@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126125606.GC28035@lst.de> (Christoph Hellwig's message of
	"Mon, 26 Jan 2026 13:56:06 +0100")
Organization: Oracle Corporation
Message-ID: <yq14io8y1ei.fsf@ca-mkp.ca.oracle.com>
References: <aG7fArgdSWIjXcp9@kbusch-mbp>
	<27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
	<a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
	<501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
	<e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
	<eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
	<4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com>
	<d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com>
	<fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com>
	<c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
	<20260126125606.GC28035@lst.de>
Date: Mon, 26 Jan 2026 08:01:35 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA0PR10MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: c3263056-6fa2-4214-e930-08de5cdb0916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EgvnpJdNyOwqeunEfydDCmRcJvPK2Pafhtx5DkHLLDGdShuVOt+q+7Knm29h?=
 =?us-ascii?Q?KvRzaJtiu02x6eb6Z8th+4p1hfqtwdnnE+M6UKIQED2Uxilx8omcoisI76m3?=
 =?us-ascii?Q?70xwRZdcMvCSTd608GgJDMsKFgasXac5RFO5g0W5wgrc35gZO3UI5Rg5sKYU?=
 =?us-ascii?Q?RLA45amC+ylpCc9Bp+TnabdtqcCPTHBhm+FeJW42XZVaOnCNglUHYWgJn9qd?=
 =?us-ascii?Q?V7wAqc7AcvQmvlTcdMwcvWAmbyUTPvquVcv5VjQozuX+dy0oDnHLHufbDkXY?=
 =?us-ascii?Q?jV5hv1khQcA3f6NEFboUtTbcEEQhG7iMmeQOmWBUxLVJnwCdGTfj/TNc3TAO?=
 =?us-ascii?Q?rqre7LxDigjY+6XmuhtIaN0ryzGVia/zwkY9rRNgX1572ilzoVU/UyRzuiLt?=
 =?us-ascii?Q?o4TnNv6VGYAaEKPKdCalZ8pObfcVKlr0oB12zjPf7qKyYm+3zCG4PhTaUJEu?=
 =?us-ascii?Q?/d+swAhQ00r3q5zcoOadl+PwdtV/TDsw1PYUabEqSNgr5sko0TTQ49dHvrXF?=
 =?us-ascii?Q?etRNa4bqDFJ5HQnyxf14gtMuCV0jLy5LCuys4vd886vKhQAvH5VppSb3M9du?=
 =?us-ascii?Q?Rl42at93p+UeQqm+XZn0nEWgcRm6cCi9G8sOaLHCbGWQqhD48Qs35DMCYuh0?=
 =?us-ascii?Q?wZ0lwzmI1g9XoxWSq5O0iHPDs8cfyPOMSPzndcwb0xRYjFoAVDr8D1gQdN82?=
 =?us-ascii?Q?ygLmDRueYQep+58i7XGpCqC3Vmn9vqh1UF/C6cdMKLefTZ14P/KWC2t692hB?=
 =?us-ascii?Q?CAmJCxsE/TKxxmhlQmXtgjPF+ifJQfmlhsJCj7LC+WxsR+PvXjvGPvOzSr3k?=
 =?us-ascii?Q?TeJlcAyYCiBJLdC2M5yPuTJddo7qTw3qru3A2zmoKp8S8MC83wfdcMTf1QRW?=
 =?us-ascii?Q?2OG1XGm4yQ54e1j5eUY9qt4UkWHXaI/qqkW8qnilrC35RUSB73jlzdf+aldR?=
 =?us-ascii?Q?6nMQX0H9VITce7BLLnRoiVvmjKdAoWoQ6sQ7aaIhhxS8cPqq0nWgVv56NIx9?=
 =?us-ascii?Q?N23R99Hx9lynetKjB4e22HemnXCh6WT8ynW6dEVZJL2RI6iMz3mo2yW65/35?=
 =?us-ascii?Q?1dfMN3GFo5ZFZ7s4uq3JpOQkRW40hW+xCncC8NhR/57wjdLdZq2siPyXmI9z?=
 =?us-ascii?Q?fRFSMY6S483yzMlN9+Ju5yVuL/zWQLGEwB22AMuhmkYs7kKI7PzGTWglhp1O?=
 =?us-ascii?Q?zZiC7STDYb1TlgPKj6DNXCxiapD5z04hu84RTAZMDhyuGTboaBxcuD4RKdwJ?=
 =?us-ascii?Q?iKJw2zjAxevtE9JM0kGiaKINkCKpCp3ca/2z9Je4rkbf3T8byc1aHz1vwVy/?=
 =?us-ascii?Q?jUMYC7+LKPx9uhNLIOYGd+LYS3WWd3+2VJ043LiJWO1Z+JxCmfFDk4q/29oe?=
 =?us-ascii?Q?cBbWl+oZipgatTuc3Q1oxWO0hfRri5DFT8YAr6YKiDjNtR9yFAXMQpOjhz9x?=
 =?us-ascii?Q?M66y0DixjXs5ymG4ljqxW+9I8xK0Prf8TjAySicgPV7XkMhEMeBJqAjUXmkL?=
 =?us-ascii?Q?69PJCS+z4Vh7vJhAUvuqropfoG1rZKnyuRoNHwyzbt/CoKawfMAu1mp/Fwg5?=
 =?us-ascii?Q?CCNNfyHZPPK1V3OkgfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6U9vAkl5VriKX1uuAFB+UNjwpbLgnZNwxAegNnvwUrHd0BA637UNXhJQnkf?=
 =?us-ascii?Q?uYcKUdRsswFO5ncDA2EpWh6k9s895zgyBs4namlU1AQ0vgMTdbcvxOQ4eJu2?=
 =?us-ascii?Q?hwWFiQHunRO5Tncyr63Iaq/VdTiHyApyWEh25BHZd2QdglACX9hhMeztaiw0?=
 =?us-ascii?Q?5rKUSorrDKQwd7Z68Nb0I1gjd8dlWNu7sGbIcwLoRXz8mONRJmrX4Ww1Id/n?=
 =?us-ascii?Q?JzBdcvHYMgrnQTMWHN0DiXR+vyeZ/e8H1Fl5BWhASsSPK4cmKLYDCmXP3sQk?=
 =?us-ascii?Q?c5fpO4m3PuEzGe9ZOjIsDVXi++v8ZuSjuKMfGLIlS+iszbqul3pbbI/EHOcz?=
 =?us-ascii?Q?uRn36jDYT2wPVP5zoiWwTO2FRoGSjgBGyqHwJJHm2y+6VSTqZuXBw6VRSEBU?=
 =?us-ascii?Q?r71WquRAEJkz5UAU4ekXg/H9k4fX/0x2zA/jtyirh0ZDAuV2bVuzimfn1B5y?=
 =?us-ascii?Q?9lqQLNlAfQzFcDPy2xKZTgqofRp4VU8AFLJEZ0Z3gZvpjZxKkbmW9cettiXO?=
 =?us-ascii?Q?FGoSSjrihYsybClzyIJ3zYqHwNBmzksyxTBlNmHFOJRBw/XDlHnRk17BsRkI?=
 =?us-ascii?Q?q+iKfs+KNlyN5ymJMemzNvHJcRAjv5PUIiR2wgmi8T5NNRZnp4RQEKiRLmWM?=
 =?us-ascii?Q?6f3DwfjW5PySdne/oC2rd4P7rvAaXRX7KU+xqk/tkRGhNOTlxTApkQIgswk3?=
 =?us-ascii?Q?rZTDbtfqeJs9JHMyDkRAo5uc2d4nuYvrIbHm53sMZCgICr2NoYg/25c42j6C?=
 =?us-ascii?Q?prXBMTnwNlvFoPtDF5/gkzvdxz/A6t5toYP58m4UcR8unHdcKDN1ZodSwsmm?=
 =?us-ascii?Q?6Pb/SX0aEiEP2Dd3NUeUfTrn4Zw9l0HSBS8rKPNZaAlWJbUvtI6S+0X/2pJ8?=
 =?us-ascii?Q?jOyYYSI5KlXQYGk9nTG/qiHH4buqgScz1IFBErOeA4HjVjfu7wCb7uK7GjMM?=
 =?us-ascii?Q?+E1reDUNCXsChAJzeJZ1RYACdtv3JM+VAyGsm7t4tgu10Tg1E/J/d8sghuj7?=
 =?us-ascii?Q?C0T7ezQo1aPH6b61UJN9iw4VN1THerpp1VEWSHCcMWF/ORgG3mEqm/qV+4n+?=
 =?us-ascii?Q?S1edxoyhWt2QoR0fp3qsOGIaCg5+qYO5ATpHEH8Eufq6DPfO/wG8ReMSIswD?=
 =?us-ascii?Q?syjppTdwm4Fc5pjPFA3sS3pRHpXEkIh3SJMWyVUAvXYG1BM1fq2TycIZVz5U?=
 =?us-ascii?Q?sP5w7FHynVu/C6+ZKPPgVEzJj5FwsKdkJZl6J4mlr86d75DdKZugx9U20DJf?=
 =?us-ascii?Q?53bqJ9bg2AUk8P38Ii3JveVv0o2pVsfHFz+1wgNhI2oOY5uxMLHvONxygriL?=
 =?us-ascii?Q?uOXjlEufc6HCUuEjtvuDhcyvK29E2gKkFbCeFNFrmxLUj572QFyqv5O+jqwT?=
 =?us-ascii?Q?jQLIt/8a8sSYfeyBhtLpw0jX+d+8I+MHv/DIhRZ8B+PY5J2CSuY7ucsK/qlg?=
 =?us-ascii?Q?VBH+/obipuH+gm3U3p1GLDy56mwsixoqAAMemERciZeeYqz1P0303b2yRgAu?=
 =?us-ascii?Q?FN9uX1wybTLXLOPOimyb0BQ+y074dqPO+L1VNsEEUJ0oTAuuyoIPxj+PTPH4?=
 =?us-ascii?Q?QHDlLhrxkZhot5RqWCtazZF3P27EeehRlRr5nmUVWRbSkboctf7vb54VTNDb?=
 =?us-ascii?Q?qmvrXA1WGhqgCAGhEKRDqpz4HgfAAYRSwsIRg9+2ZQIDAgZ1/o1i61qbvXsQ?=
 =?us-ascii?Q?D2QTQUrQzvoWqczpia3h3fjcWwcmA+qNc1L/etVuJxeYD/pFHmmtJ125hKBt?=
 =?us-ascii?Q?IK8cizHqq8CoDr524chewc58DiSgR4M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dJw2Qr7i6PAab43PVN8kcjeXV06TdokdvP815xiceh7QMVZGj3sZhU/Bp3+BPO8W8/KoFAItiSx6hEne6xSlR4qrrRwQfM4nUm/kcowjI0S4bFyRAZt0lSwHQ+EUvjk0ZBrWqvAYX99ogvrc2Hzhd2Q21YNumFrx+o3OEArsoO9170XI+BjKY1Z3QDaSrf4svKy7MU64/yxEIaFJWLTzBX0+DeP22FibqxeQtQKEHX7XVSpx99AVA4YenaA93rWp+CsBZk7EvZI4osnOKuI/d8l+Mbvx0HI1tATwaf23uNR59JQ0mzbKznKfFiEm1bDt/gLS6+tCY5XF5lIrQhWJDO2FLBPY+wJ9nHb0sHPIxcfhjp5wtGXbL/y6qaUQAzS7ZyeNLBjtDuiBDSEfIWIbkrdlZhZKGss0Wuuk7xY9mtTshT1AdjB6g55ijCFUyk7hPxj9pghbTj1etEmvLQhAi9tOi2ZezqckTT/r6WvAPPQhCVEn9l3hYb4pcYWTw0EiGCj1clScau5mjZvCJgGIbYylKIDbH9IPcagrb7d8UAO/Hsz4Z0jM6owcPuchkUIirEOtCvmTL9GS9K2mMsbqh1QY8ifGc4NoLewLNL2JBSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3263056-6fa2-4214-e930-08de5cdb0916
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:01:35.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O+niXNp1wWG2Pvk/YRNsw4u0lVLI89LasNjqcylOkl5aPLnbWXzqHTjbZVBboIrd5TLw6cOPa2TwxDLogvDJU38oLAOYOMDmSzcxGZGenY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=720
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260111
X-Proofpoint-ORIG-GUID: hSsOa6ftNIXrmZ0IgYI4In9bhcbmznBA
X-Proofpoint-GUID: hSsOa6ftNIXrmZ0IgYI4In9bhcbmznBA
X-Authority-Analysis: v=2.4 cv=AqfjHe9P c=1 sm=1 tr=0 ts=697765b5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cQJsDA8rIU0Yu1T0V_0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExMSBTYWx0ZWRfX0B19Sb038Cgv
 1PhbVS+DbpZzQuZ+v4FZAC4fufEeAohsoSsU9o3kC1uEQB6HvRKub970khADXnrAVJ6WPP2fgGZ
 snyo8GLNoIrxxMjaj8E9fSFdp03SYBJi5MKC/n7E3wu1f7+H9VJMP35yKt+8ia0zsR/Ob8gfaXF
 l/9prDNaQo88fuLCXhfpDZmbPsLLCKEE51KJ6d5+l523RpWhyhb9QK9IRrYp49Mre2Jb8LWxbsv
 ArqarxTPy4w2ZLLU2c4W0Nk7RHFy9VXAy0/RIxHIDgSYHa4Sb6+zgz1UURbKEERE+oHXsNVfasi
 EJuMDWDB0uN+KCmb+XWGpLnCBqGMcSpRyq5x3uRmFA17iWsFrEDICNN6IcKWVtxvqOAUZ4Izudl
 X2vcfXfVrglLsMHxeTwqvhg5OMFzh28JQSnziXDLBpVkSu/3vMdgmClUthVykN/FZZdTE9JQQHe
 nxL28XBtmsXWmdVDv8Q==


Christoph,

> I'd love to drop support for the controller-level AWUPF.

Yup, I agree. It's utterly broken.

-- 
Martin K. Petersen
