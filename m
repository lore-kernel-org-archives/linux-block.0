Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51C84DFF
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686245; cv=fail; b=pKK5Rtohy9hROitpe3xjvOx9eVxsrzv2Y017IX2oJRoGgIYUac4xAUMXIymnsPg3jYM8L+eWeXz3Il/WjG0pkpkTKvBVY/sl/Ae9Z47n0dAwOvnrcTxOKFlVx5rob819d+hgwWg4wKxg95CFGil4xuJ19eG3+x4FYkrmOAF1aNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686245; c=relaxed/simple;
	bh=9sqXZLekNtaGSOC6zW/egS5HjKkoYFWlyZ684Hze1Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyJ2iKKHtl0Wkw0ZR/Z5PiZnA2VN8r128mPe2nYUcRuoP2LRxMHMXVgptMHE0IJ3aXjsHU3AcY8UckvNaVZMYH/eeio47tBTXg9KbWMujlRReh3C1nXyKyPC8e84wdpUPOijGNEI1RhFkQGADXLU5bdUuua92yCd/LUT9OTqJnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kpsP8+HA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f5WT33Ti; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpsP8+HA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f5WT33Ti"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tU5t016832;
	Thu, 11 Jul 2024 08:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QwdOqKpvTVnfd1A8EYWwsx43OdRgcMdRLKimplroUXk=; b=
	kpsP8+HAeLE7hggi2QztIVKm7/ef+Kuf1BxGJhzOTdS9qMx2VqzpleYIw6mi2zAX
	KUvydUw4wg6N6XggY4fMMIGs7jP8z93Inq75ov+vmHn/dysTQdjSqEylegMVRXfJ
	N82OxyYebWaqIHTqWtmYzRSWZevcoeBAGZadHoVv4lzp6yppGkg9+gQhkd9sAaCd
	9P5sJClbJEBbCY0dFFCX1Qz6f11qjrybPdX9CDYRfO3+7YNQIinXgLKasM93Ee3M
	vRk1aBvk9w817xjnjWCwZJov8VQHCiFj4HbciAnakXXyH7fWP4MyJ9SgMZpqpLny
	DQRmDzABZUrx7/Z9VIfefQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybs4p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B6rJ2p008700;
	Thu, 11 Jul 2024 08:23:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv47894-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQiBj2OLSOy/HVy93Ks23IiyGkIOD7CreYSqd0p2oU3vjTj+4jc6OTZ5i88shVWDsWlUnejAS8k6MdNOsABlsERsr3jQlQYh/OMAQ8XTVcfJA83VJxeakVhLguvCtmPNVX8OX04bgBTQ+H+hHXzL4j8odZ3aFfYy+nec49+hwQ8tscA6x/ng0Kx1ARFvtFNMJI2A1KC8+l8LAK+2Xl+JiZzDJInBVxpb306nlgRd7RQnKo7x2zy+FaK0ELITJQwimhElpS25EJnnLzpnV3iIeeuVWu4lQi4dcP9A4iSCuE/kZVExs42AjQO52A8TvJxukNZt35q2W7qC/cU6cdmrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwdOqKpvTVnfd1A8EYWwsx43OdRgcMdRLKimplroUXk=;
 b=riHzIXGo8b7pWsEXFnC2WYZRtDbs12S2/CIqcGRiO2/cbW97b7ncxuN0XYFauCdIBq8HumyH1tj7hQDnwLYwbnAUq44my7NAwReo/DV59obWRZIsq0tXzT24/oUF/A/92frgSG9f9ZUkv3P88m5vITFOQFA0OXmobXTdgGTUKnq7iIwXdEXYfMSuzVOC6semG7mm+eIVHG3CoMSCcc5+4+r/FK+9SMmIx/ZJ/hlo6wPMePgnY7O4VPMCpsQWI0cGm8VwUY1VEcZmiC39Q3WTvmYih4sU5C0kWt+0DqYx9GsqFqawkvWu5aBpFRqXllrdFNbYnkLunaUjbQ7FDEZX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwdOqKpvTVnfd1A8EYWwsx43OdRgcMdRLKimplroUXk=;
 b=f5WT33Ti5cQ2DCBs3JSB+UoEl0MSlhZHxjSY/6FKzA/I8i/BGDLV5DGxCc1sOxcejlTzoeUayqTcJLgyqiJevB5WU0wNVCF63X/rg6w/bdGwXV9kpTrt3XFqYppHcCfh49c6wOMKB90L3gM3gIf233QIb5tpJLwCehQY8iHWoeo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB6970.namprd10.prod.outlook.com (2603:10b6:806:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 08:23:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:23:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/12] block: Make QUEUE_FLAG_x as an enum
Date: Thu, 11 Jul 2024 08:23:29 +0000
Message-Id: <20240711082339.1155658-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdeec26-772d-40e3-7009-08dca182ced0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zSmir29ywoJvz0+pUTj+zcD3VFY5Tf38nixTQQXUG2u9uUjzliWj9syMhDBB?=
 =?us-ascii?Q?Fze0+JPxkfIXfVQM+BPUqQ1A2NU6IRkWxi7nBgKXr16epO2ws1JJKcV3qauG?=
 =?us-ascii?Q?WXcWtpYh+rIpgRcHwIXHyaao5ONS4XhYIOiA5zIngB1O+11DsYWEIJ4MMXN/?=
 =?us-ascii?Q?xkjOej1Ob+MMo5/Dpo8gph65Jsbt0Gmu3CikTaToRAUs3YUqdvce8VAomB17?=
 =?us-ascii?Q?0u2NfVeIWYiM7PBRSaEO0ysMwvT+W95xTpi40zgEkjtOJ8fFBICNXRSfURuD?=
 =?us-ascii?Q?8ExIpHdh/c2bCwbFscoollv8SIZee1033ZTKeanCl85WG7Xzn+LjKZavUHMm?=
 =?us-ascii?Q?yx1nxoFr5ouORm4tAgRS2X+naHWuPQhDZUB44YniGVlX7gD2gCGwX4/EVm+e?=
 =?us-ascii?Q?bG8MpLJskKtzjt3DLAKiURYfP9zxwtOe6N1DLoyRp61lBErD9yYIutiEfGK6?=
 =?us-ascii?Q?k5oJRxwpA+7PyCmg83KjoQdcPLfhKza75/edBIEKqI9ANul7MizcBjo+w79v?=
 =?us-ascii?Q?Ita37UXFqbdq/FdBmjKVNe/M1Z6V0gaz+C78KpW0thhWK5fFLNE0/mwJT2b0?=
 =?us-ascii?Q?pfg74ImeXX5uFjgXs6HTE7oMDYWHKdr8e8LXCYaJ2+aR0jT6c/X/MwKwaSq9?=
 =?us-ascii?Q?vVFu4CV/ON6jAiBJktf15UUWEY0tm5cfijPmItK7hvCEQVlC+PjoInqYNzaR?=
 =?us-ascii?Q?7Zp8ObHeRWn8E009y2IUYrL6R53oZwejWLSdsVWu/u60FVay4fQsQb4t+6f0?=
 =?us-ascii?Q?6CPOoltUhe6MV0be7X2eccsB0p6lrWb4a+H7MkdFTW28DNFedVyHmfwVzobv?=
 =?us-ascii?Q?K8QIiSQ1417fCRSSn2/JJr2TQRJjN6NwE5xWilgHzK91olr5KcJ6XtCc7QM5?=
 =?us-ascii?Q?aKAhbXB72KZeo1I22EC+ognPBZ3Trby7ZuKAmVKu0dmhusZ34lg8JBuyAGiy?=
 =?us-ascii?Q?WkuJRrA+nx+hbf0uvSy+2KBEvrzHdxKTocUxLoNXs8LzMSAqrBSGQaBgAO15?=
 =?us-ascii?Q?wY8jnNf80SMxOIs5qoXFklOekQ13hwgOFrtClr1EOtLR8gJw+Tk0qdFuTMU0?=
 =?us-ascii?Q?krs/eMld4Xw6SO8k49tSJfLHLeeo+W1CXjhSasyXV636+iwE5L5vhaaARRnK?=
 =?us-ascii?Q?s6v/T+lb7EohrMMdUBUJBQkrkco9yylfCZ8ajCjTWF6FW5ktnSM5lPSsMr+z?=
 =?us-ascii?Q?FfEo148sRQdf02908u5DJIsyCC/1S8y1V6qPcJnIuBkojylZpeM1RwUEZm2c?=
 =?us-ascii?Q?ZQT6UKtJZeGpT7XvsoC/4tuRQAkXNoWkyJkTHSPByBr01N/80q4AUcL1Htey?=
 =?us-ascii?Q?mYhVuX6o7YY5RxtvvMfDtuz4Wg4IM7M1jFKXEQ3NCTa3qg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zpM+ozNn/VbpdqAs+CvFZOhhSJgqHpO+XULMNj92ei3j8uRLSENzJ3Z8yH4M?=
 =?us-ascii?Q?dUHUqvKYlmA+nC9bAf3P2iFgpVyaZfCIrtt6hFRMXo18JMa1nI7snX7YsB/1?=
 =?us-ascii?Q?Vpwp7MpF9wBYj2SB63Hgaksp8dd+mqONqKGL7N9Us2v/+4MXEOdElgnV+Dmc?=
 =?us-ascii?Q?JEr+hSvisQhKbGDj2H3LYsvGlGsaFzt4NcJMPHDkVtH7OVfRh+30kFmqwC1k?=
 =?us-ascii?Q?XDAF1q0nV5mGIoVTjugxYsG52zgSrkvm69la8ExzyuuYadBP2+4OBNL2S5ju?=
 =?us-ascii?Q?YtEuc+5GrGFrtHy3sLqlv+MXOPJIZgo9XBmiQdFc2BZu9TcNuuNb8d1uHSge?=
 =?us-ascii?Q?SVxZIdvXSB0KODS0+ne1tRWudUGrSvbbdutyyqxfEZ4OsIN1H7UYw7if/1Ic?=
 =?us-ascii?Q?WGGR4DjMBsj1f++nIYZVO1Ln26Bwlcek3HERSUeebWgSoxSFpDynhXzSa4mu?=
 =?us-ascii?Q?Dagdi26sgGOJ1HyAkMmHgaud9J1sAA1a4PIrAFwI1NJYtpXk5gfIQnJAxQml?=
 =?us-ascii?Q?pmwDupfPXE6b/ezLc65YdfKOheniGqaKGiNF/ONwaTYQvWdx6zKItu3gQJ4l?=
 =?us-ascii?Q?sp8FCX4UOtG12tyP5ULwIhXj46bWl95JLK7FSlA85kAjI+NEj+h3Q7gz42UM?=
 =?us-ascii?Q?KI0O97SZ2nJjkmuCjBOuDXjuTgwIjMQRaNT0RNu6KzBQPXQdHXShnfnealh+?=
 =?us-ascii?Q?3s6+RxdrEH6ZLxMMaCpKrNcc8C34xSyNmzWjC4MvIsLfv6a1fT1qZU06uImE?=
 =?us-ascii?Q?O0PId3il4miGc/9VJLjzbGPqM4X+GoFtIL4+XnP+pV7kzwaDsUo5p4Z83qZV?=
 =?us-ascii?Q?0jbPzKNTO60sO5Df4zZbRj8+iVFh3NX0eIUyw1Q+/jGLTfBaI/uwwSAt1gJS?=
 =?us-ascii?Q?+mI5RYYb9jZnSzjTXL3ABu/g1h7CZ9xAv7/JHdRaWAnC0LSP9NhSuKpA4JUU?=
 =?us-ascii?Q?dtdBwfhhjyCQTy/C9uNfxHkbMrbGh3NubBIPw2nn3xjy1C/J679QIvQ5RnlQ?=
 =?us-ascii?Q?nQaBLvU15uqRBkV74SUftnb/6Tl3ckogn0ZkeZT3RQRfSJdcxl/UdKdR31WR?=
 =?us-ascii?Q?Yo8anAnHf2l8xe5yeFcploqUpRpLKU4nS6s4GPLOLgwtcISjixZKPZ0zaMnK?=
 =?us-ascii?Q?Uar0RdxQINfTfgZv4pUi+CqDDRRClM2iLpv+nkUvGCW/nwPpDUaiNgDa7t1A?=
 =?us-ascii?Q?dFZW6jDm0SBvTI/e0YnLfhJvJsSdQ6VfevlYGH2vl8ISWyWWcURAjXiDSFQl?=
 =?us-ascii?Q?jLjcv2/bd04yoyc/aFwxcu/Kj2ZQw+O9HERLVjdmMwhzRqm5IRkTuKj3o4P3?=
 =?us-ascii?Q?rOvHQUzK/8i3mTQtzOdPstjfkNUK2DbXumsYHeaNlBvDBa8jbqURLF1KyZ60?=
 =?us-ascii?Q?6MJl62huhrc+iBQfHs4GLiGD9+FhKTR2/jv4BkuojVhm5deBo+tiAz3qjI/5?=
 =?us-ascii?Q?zA6D6BRTn+m7MYpRh5vAVsnO52ryW9G5e2u2++v3AoI44KIQX3DYlJ5jDN47?=
 =?us-ascii?Q?Z81a2YQXKWtAx1ksgJ7CzU0GUmMOmOm00DX2JNjE7VFK3wVggt6ktWjqY3fZ?=
 =?us-ascii?Q?xzJ30PbX6uGqt5rI9Ry8SZj98WE1XQ5cT5n4UMuqwzRLdbptE0dKIo/Fx7gn?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ado/m1/P3vmwj+SM7kSMUMVavap5OFRrKtapzqwitMNLLkJYC3sdasijiM4WWNneanWavel6kBwRP3ZZNl6l5oCDLbOXxE08fIDAwOo59oYsvsD7+OZREJ/zXOgFbIjW3Kq+rS8HViI5KSaexG/UtgibWGDI3qbczzXO4PQcFHytE7LLukRDB3cjlnUs+uN8lWIQ6JynVY7nGIiM7lC04yeCNc2Nomdh+1B4Q9/DJMU7rs+A50dg9BY6qgitUexxvCsJGiy2s8A9nV8VvBKqeAX/LSEQ0lswx6FUhEyoq+8z2vRFNch1zrov1qSqPCk5nWrkYtvceKN07x1Lbz51hWl1e67lOmYwnK4qbAAPnK5X8fzUmEurBbsDawbEsY/enA4Jn7bdYOs/GuWh1WfwSydJ6AIeQaqS7LgCW8haN4gceb0jN6yNdKRCHndP0Bzr06DEW8xPEVf4m+xn15d2uSDFm1/FiSufM5x0CwP9iIHluS1aw0XNjRlYS5phPuuwYrZFPXYgpIFsQIElB6pBoU8W6VctviKnLwBJ0B3ara8Ovj3y36hRb4QHVEvrQy8lpz5GSaZHooHvk/uyGjvT2FzbC78vcKWn1tRMsjKchr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdeec26-772d-40e3-7009-08dca182ced0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:23:56.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0owSVZuVEqTZZH+W7uILCGYdvLk7x/adumXetpNef/cRWgQJIPKMoaAmgaD9FGRO4jXFETL/QAfAtGQg0sTQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: nXm07fQghecCDdbRBtbvN68ETEXKYLNP
X-Proofpoint-ORIG-GUID: nXm07fQghecCDdbRBtbvN68ETEXKYLNP

This will allow us better keep in sync with blk_queue_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 942ad4e0f231..bb521745c702 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -588,19 +588,22 @@ struct request_queue {
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_DYING	1	/* queue being torn down */
-#define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-#define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
-#define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
-#define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
-#define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
-#define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
-#define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
-#define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
-#define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
-#define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
-#define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
-#define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+enum {
+	QUEUE_FLAG_DYING		= 0,	/* queue being torn down */
+	QUEUE_FLAG_NOMERGES,			/* disable merge attempts */
+	QUEUE_FLAG_SAME_COMP,			/* complete on same CPU-group */
+	QUEUE_FLAG_FAIL_IO,			/* fake timeout */
+	QUEUE_FLAG_NOXMERGES,			/* No extended merges */
+	QUEUE_FLAG_SAME_FORCE,			/* force complete on same CPU */
+	QUEUE_FLAG_INIT_DONE,			/* queue is initialized */
+	QUEUE_FLAG_STATS,			/* track IO start and completion times */
+	QUEUE_FLAG_REGISTERED,			/* queue has been registered to a disk */
+	QUEUE_FLAG_QUIESCED,			/* queue has been quiesced */
+	QUEUE_FLAG_RQ_ALLOC_TIME,		/* record rq->alloc_time_ns */
+	QUEUE_FLAG_HCTX_ACTIVE,			/* at least one blk-mq hctx is active */
+	QUEUE_FLAG_SQ_SCHED,			/* single queue style io dispatch */
+	QUEUE_FLAG_MAX
+};
 
 #define QUEUE_FLAG_MQ_DEFAULT	(1UL << QUEUE_FLAG_SAME_COMP)
 
-- 
2.31.1

