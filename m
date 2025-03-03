Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739123ED63
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022773; cv=fail; b=lwfYoDL7f01xOTKkwP4XiW/IUcoOZQVq7yjnab14iNeBp5OJMVLF/Kz1ffC54FQqM9sT1C60BS05rDB9GyI7jZ4UOZZMf/2+z2J9X6p6U39gJDkGJbxljvdOsjJrz07lONDgzFmTR4f6ydugHrTGFpWfCVXk8VLBF97vXGeCVLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022773; c=relaxed/simple;
	bh=dAx28cWya0Bq7bFJKqUTCgcANxjFuxbPFY8rJFVYNGM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=OsboBINql6Mk6qC+grLojmDWkAgumKIqQ4Q1gP2r9uJT2BtYOtGbWnruzKTonpyRFrIMQFLkZkW32TL0Awjm7nwXKMcqR0hPcGBPGbbylg50tr/2N/+3fzo6Fwx31m0ng/eRBYJm+YNV7J5mgYnIUSr8+/SXwWi0m7y0lzy1bFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dh2/p47H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApbW2Kvs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dh2/p47H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApbW2Kvs"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Gc8sj016064;
	Mon, 3 Mar 2025 17:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GfPt1+TsXWzmhK/sz5
	FfVkaVnv9qtlK4sOo3knTodDY=; b=dh2/p47Hl6AFewt806k6KlHeS21AiwdtUr
	xigXdOojj8OYD1SfnDHGkT+ni6ffnv+KjkugNMVjxb9G1M2jekfjUXfKAnbTz4Da
	uU/W5HzzYkwgjWF1CWkP8ZT+rNP5aM0vMKPwvK0F6e/FwTu2yxMRlSr9+CnDU9CY
	7DuWJlTE35+VuyJz4ypCtt7/0qEDXuqvbSrYxYyHcLQn6DSlhpg5jYPhL6tJ9zGH
	STeqQoJYwcPxHChbp7LgorvzvoqGZp9fet/iCMnqonltFz6ajCFKt7/eXV5Hr84S
	2YG4Un0QcdrxOrnTvF5OCK32JdnRYFswwVtOrukBStmx8AaQ0bgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavu62y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:26:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523Fvk5T006037;
	Mon, 3 Mar 2025 17:26:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7t4w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTg6hVAKCXUogYK50DUQW4/b1Wd8U5IWwRrQoAuCHQ0SAOxfLlhGN3UGsL8WXq6B+/JkX9pp+mScNROuv7FtM6ggs0ZvyXaFUWMSbXriERbB2Ts61dVZ0Kh6t7UpQHx0C38vt5PFv5ZEkUvHZjnzBegOLNlmbMJU3neOjkmQNJfgVEjSvs0NRCg7UIvlgtGGIKTh7UHDK2eQHnN1oWshE/t7PfvB0dqWNPY43hZnc/x1QmTlSoKXyW+x06T7hBTo1ULlh5v/t2ldtkkVYKSJOqFV+eM4WvNrX9mhe5ZGKr1RAuxhsUk4XWJVJMfueTJXbwbG1IuA/ZpjpVCE22s1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfPt1+TsXWzmhK/sz5FfVkaVnv9qtlK4sOo3knTodDY=;
 b=AK4I0XySxFEocI+mM8BRTV7jSyw3TSurgNmVAa93iAI3IKYVSykWcIqSy9I5smgcgA+RpRZVWLUo90U7XasjUlWS8TDu8gycDwMUuic+gTL30juweMQZ+b7jjHTHr5+0iZRcZ7czIPyJGa81f9kIaO0SvtzJI/r+a2vXJZPSKRCZS8iEkJPzAj+X990oYdAq6dg4ra8airEjXDP+0ZLPYPTVRFy5YnhgC/S/6lWjqg/quS/rWeoo0LVKQG8CnNVXY+PnJwLQ9tbOwMOAWQx3Sa1UcD0Hh8nQXiLEFUfxt5UCFqcyO4Iy0lDOBMxJScnFUb0779YzgC10nC9IMG58UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfPt1+TsXWzmhK/sz5FfVkaVnv9qtlK4sOo3knTodDY=;
 b=ApbW2Kvsigciy2k3bN0XYU57shfIih+QJf0uBpbasSYXdTARYD0kLj5eBLIzYYvhFE6gX4Jij0ckcQRLW51Q86w+AD9/4avHAdMVAEmYZyJc1t0I06Bb1ChN52SDLrwdCAl/hJiw0CZVJqeTuN81Foujlq/ddPUqQLnRpDxC9Qg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ5PPF9BA2D2998.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:26:00 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:26:00 +0000
To: Milan Broz <gmazyland@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org
Subject: Re: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes
 for non-PI metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250227144609.35568-1-gmazyland@gmail.com> (Milan Broz's
	message of "Thu, 27 Feb 2025 15:46:09 +0100")
Organization: Oracle Corporation
Message-ID: <yq1mse2xdlk.fsf@ca-mkp.ca.oracle.com>
References: <Z73kDfIkgu4v-c9W@infradead.org>
	<20250227144609.35568-1-gmazyland@gmail.com>
Date: Mon, 03 Mar 2025 12:25:58 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0498.namprd03.prod.outlook.com
 (2603:10b6:408:130::23) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ5PPF9BA2D2998:EE_
X-MS-Office365-Filtering-Correlation-Id: ecae7941-94b7-4aea-0846-08dd5a78775d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gA21r9XdZMtOgGBL7mz/E7F/zt+I5cIxKqreXCYO2kzh4xPeBJuLY4BVQOOE?=
 =?us-ascii?Q?3bSx8PCWautG7sKsTvzPhYwulsikbLYHMEvnHgpMmLYaSaUpu++k96denzSD?=
 =?us-ascii?Q?znxJElt7Sq497wgdwg1zFnAMnNGoRzGkViUIjnhqiGgja/sYZtlPmul5sN8u?=
 =?us-ascii?Q?GmXAnt+zvwUDQpTT189UOq4Mrb00ETc4kck13MrFLnzGRFo+IBL+pQLGP/6W?=
 =?us-ascii?Q?E9v5o86VLy6HWtnrrWPUVIJl35Dgcz7Qe5QmXSQNONSmX6i2Esjn9KP5zN+m?=
 =?us-ascii?Q?OSiWkJq4qaFZH5FEc5K3efKi63cZvL4DGbcAfU5D+qokRPiEqSquIS0pF561?=
 =?us-ascii?Q?173EZ9Glfu0Ajty2+yKC83q4JXDDalTewfWe2cEU2DgKlWgkkf6f5hF1zJg5?=
 =?us-ascii?Q?WTJEoKIZtvn2R9ILSYHmINymGs7ZF9TyyvQTqWlm2OcwLP9VHUBKHVPvrtEM?=
 =?us-ascii?Q?jPNYFpFiM1gjiJ5izYk6iQM5CweBMciFWK8d38HIVG5tdCtULHPJ89/eLDtn?=
 =?us-ascii?Q?mMXgwlZLbfKbwRvcgG1gv9zOPPcI7T/VgQacoPPe7Jy4xl8ijVkAVZdzdUDI?=
 =?us-ascii?Q?zByzOJKZfgj007THiQj1xVBi1dcttwOJd18PA1fDFFVpgT6jdXsWL3XKazQF?=
 =?us-ascii?Q?elbMRC2ODqkNVYD+0ZfKNFrX3ynwZid6VieProLuQLMFJtCVxYnqwF6yChe6?=
 =?us-ascii?Q?zFi8KdMa4jqzcWvEEc665Yi3+aNUSEn3mEUNmZhzusCTOvZe01tewf4wBplM?=
 =?us-ascii?Q?JVFKwB6MPiDXfL3r5I3m1YHjLw1QyI2qRgHmFfYCw3rO4FTZQXxo+wJe+ygk?=
 =?us-ascii?Q?rc2ecLi1wzw5/T09HgNHKg1qqQViNMJvNbXmtzfbZAaAGauDzIZcHpFXTv5I?=
 =?us-ascii?Q?AgjgYkq5cGy/pAcq7IPLPUisBSbrLVWP63cp1DdEwGzcHChjZ0QWo+LJ9m/U?=
 =?us-ascii?Q?PIR23ggwti8uDGWfATbjra86DOaNBO+sRtoVDcWG5IvYOoEItVJhLn/c1qTx?=
 =?us-ascii?Q?ZYkf5fwuge3f+2a9ty6wZHruVgmy5uYOSyDQfqqizamtGuNKhIrUkXYmvWco?=
 =?us-ascii?Q?2OmcEzAClyI1vNUHwpDPHtRaqz5VqJdH86mX7YgjSKRwJWXUE9bY2i3KKYx8?=
 =?us-ascii?Q?0jyBCMvSBZIrmthprP29yaQN+iiI18wXU5RjXRFnCBk2KhsUn8exxvvERmIY?=
 =?us-ascii?Q?eSTm+kE2Jxvdw6Kadm2gOW0Jr6znyDEpHy3kh810ZwmpNQvRQsd68K4GHHMj?=
 =?us-ascii?Q?2sfrt/MpPdA7+6wCTQPIM8HxlGZiju5dlM1L0n5E2TKI7v1cXsXSyKzeytnG?=
 =?us-ascii?Q?WCoom0I03aI5/+GmsE2bfQbVIIG4WK9uqFuDRRYP9UJF2vDWDndElzfHRpI6?=
 =?us-ascii?Q?IDylNHj0yxJDzWc/gpWMUxz0xTVJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I4Xel4GQF743w86x8vU700aNPxtxb4oNIqwW1mznOiNHqwGjLVV9T/OFZRvB?=
 =?us-ascii?Q?oZ0TWkCWQGdZWS1q8s/r4HVvexC8rMiEfPZaHXl4GWEzTGaoHdHCfeW3wVMt?=
 =?us-ascii?Q?wCtCKybDJAGPzF1zRJbiPthHv6lYhwFpsly0Sw74gytvUinkVcLeIOfCBf4P?=
 =?us-ascii?Q?J7NI0OEWj5xQr/LQ5iNyb6th1ihmiBBdR/LLqoOkwOVsvq/9ZaXhhWhQerH3?=
 =?us-ascii?Q?peTuGwex+bWII3gyWqdcu2H1hXpxqvZsUViS1M8p2xVxXoNfLFhkSZDfchHA?=
 =?us-ascii?Q?Zj7m4585fFTH2/3vvcKusIaoorDerIRDxIiYbkK3/EYTUHhdYDS5ZSNxhCYq?=
 =?us-ascii?Q?O7K2uU/jeR4UBPY/p8BNkzWnfhYZ8EN42PcDZO13rOj2i12aooLkXgHNuEPr?=
 =?us-ascii?Q?G1sUTcVOs++eWAQRatIWrJWWLQ4KLFZpvA0bdzTrYeOrSbQr9F4UbsaucSXZ?=
 =?us-ascii?Q?gPf3RLhXt6yJ5W/WCsDZkTux20WGRNKnGfhm+9JyudxsUyIf2Xw3JoR3vOdx?=
 =?us-ascii?Q?fm6/6hbaaM7J0NZSIPFNsW7E2CHxFe+4UGkaXBzttrTi6QCwMvktFwdVmDBq?=
 =?us-ascii?Q?ZkM/5W1vIhtVDR68TtV2asmvS7NaUvlBqGxflSsEzagpzr1OKwQ3/Xuf9Z0G?=
 =?us-ascii?Q?H5FIuVJx13Y70PoZ6SY8Ll+/HONKRUau6owTdI/qJbKx/bmFcxlkMU3sJKr0?=
 =?us-ascii?Q?OaLSvV7UrZIOq+mQ3YBzAPvmsNMsSV9D/Mrnss0G/mMD9lGBGbCzklZXc02F?=
 =?us-ascii?Q?Yp001lD2/OoJtyS4VS0e+bzNem9fpsWBl9g/KpubkbrHoQwWXJcUaob7/RrF?=
 =?us-ascii?Q?RrFZrI1OB1+9FtCPHPpfdS/ZBR74HQqeuPESJt52Z5P8ORUt4rs04zxNV85b?=
 =?us-ascii?Q?bJbdHKsXBaZQUDLqZu8odrowTg4Y2JePjVW/5ZL6Ho+FwwvBcfw1ErBnxtzk?=
 =?us-ascii?Q?say+7FxmdZOyfFkGjLKNEeGdrpskiYx/El9HDt/kq5C/QlZZyFzzz92CR0rC?=
 =?us-ascii?Q?azqvJTkWFLU9IXwwyLwDBzZhsyeMmqRtYhnzxkg1X2yd0ECK1Bbr8fwha/Nj?=
 =?us-ascii?Q?ijzCc4HuJBYGGDxgXHH/QTyRHz5qmWdvs3yOl6CtJVL2Tw2sIcm0jyYp0kC0?=
 =?us-ascii?Q?aUSR08iL9bWqDOBYKPsFH/gL8877dRJYe3yFzXLVDGTFiWFSw9g1m8Gc3st9?=
 =?us-ascii?Q?puoXdDjycU2mor44WoV6JwUO+NTNvuwA0jBJx36+jncJnI3PD8TY4TB1XwzC?=
 =?us-ascii?Q?UmHfCv1EdoSjcdNlmBajm843K1IxX9XOmRNXeOntzK1hqeozbCDJD7P/07xS?=
 =?us-ascii?Q?RzWNA3TrSjDYQXiUOp2uG2Z1OBKZXGFBBtlmRHdSRU80rYwzI/rpAa1MbxJM?=
 =?us-ascii?Q?Ng4QkWHV6YRZ8PLWIqhQL3/WfwwQMECHwO9HwlcB/vBOndjgENjd3q3XP+HM?=
 =?us-ascii?Q?xqWpSVlA9hUa19psR906+y6+pbXfW9MOVJfKkA2PJEFrjwuh4UMVOuSzHtap?=
 =?us-ascii?Q?y3Ai3Qwrn8QRilb7ENU5t8+8cWM+XmqDDl5viVmV5VjqJwZRhxPAcTF0wwXp?=
 =?us-ascii?Q?wO8R3pf/ZKfmeHR6l+iqJyxf8i05ZJw4k1nh0U6lsy7g+KIRUGnwWInX93mN?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l+WxJDgTsjRx0WVPknZKtdgBcEqjwKP6EdydgGe1fEtyXN3nhySOp0LRVs50MVHiDa8T53RQug0NHVNLSDZhXGVDRvLbCYla+ybKO9TaawZjTxL7QcJ/Z959VM1e1StO0C2BZoUxUrQdBKXYhStUjlxUxrLrubaHya8Bp/uvGyntBff8HLoiPGArgJmdtDeUctNBUSfueMRgA50JxtlzhPup2fvnPNsV5/rtHbE94IVBeLGQffBE1EyhLZCP+EA/8s+k3aI7SxWqMrfSpuo+IWv+f7X5s6uCjEWhmLJTMM4j3loydfBE4fvEm6RHeabNbTTKDFiONfdgns9uotl2n3fRLaMIijz9zuiOIq5MiQ0HtH8HWGfv+tdpxmw1o9TGR/t/VSi2+IDIJwqdc64YXAGF2Wo0kVuY01a6cvJ/PE9s6hKnQe3fESh0CoUyVV0DsWXUw0LAi+JMKguIyGqz0PCFZ/a/a2MmGMGBA8lakRsRjkCPFXaMJ/Plth9yKuSjO6RowIzZrJOSuPK1SREciZrFYfVagmhieYcYX16Fyy1NbRZFcbG+fkFvzddVYCU7R+27UvtZpNaam3w6iDygKsNCu98mn7+gzAZtRgM1m78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecae7941-94b7-4aea-0846-08dd5a78775d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:26:00.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8sV3SfC9EbiPTKxVTX4Jgzx9SdQH3SFBZTslKahYGQ+eLIyJRUSiS42ETNN87aVUr/TOBU0paRvjriyPSv4JH9Coyy2hb5ZEvRx4Z+m6zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF9BA2D2998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030133
X-Proofpoint-GUID: kTRkjFQQ-0D7_4hoPoxEbSpQQsdt3f_l
X-Proofpoint-ORIG-GUID: kTRkjFQQ-0D7_4hoPoxEbSpQQsdt3f_l


Milan,

> +		This flag is set if a PI profile is enabled.
> +		It is not set when non-PI metadata are used.

This flag is set to 1 if the storage media is formatted with T10
Protection Information. If the storage media is not formatted with T10
Protection Information, this flag is set to 0.

>  What:		/sys/block/<disk>/integrity/format
> @@ -117,6 +119,8 @@ Contact:	Martin K. Petersen <martin.petersen@oracle.com>
>  Description:
>  		Metadata format for integrity capable block device.
>  		E.g. T10-DIF-TYPE1-CRC.
> +		If the storage device supports metadata but no PI
> +		is used, this field will contain "nop".

This field describes the type of T10 Protection Information that the
block device is capable of sending and receiving. If the device does not
support sending and receiving T10 Protection Information, this field
contains "nop".

> -		512 bytes of data.
> +		protection_interval_bytes, which is typically
> +		the device's logical block size.
> +		If the storage device supports metadata but no PI
> +		is used, this field will contain 0.

This field describes the size of the application tag if the storage
device is formatted with T10 Protection Information and permits use of
the application tag. tag_size is reported in bytes and indicates the
space available for adding an opaque tag to each block
(protection_interval_bytes). If the device does not support T10
Protection Information or the device uses the application tag space
internally, this field is set to 0.


Wrt. the size of opaque (non-PI) metadata, I think it would good to have
a dedicated field to describe it.

-- 
Martin K. Petersen	Oracle Linux Engineering
