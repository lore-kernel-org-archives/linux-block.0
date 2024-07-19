Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFC6F30D
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389395; cv=fail; b=Q/G3iZ5O2whAxjTAjakMjr7HfcVdnMYRnsDq8Lp+czQq4MTu3mhz3Dha9hObtkN5q3n1hMPj5H+MUKVBjdcA+f+MSDNFlYTToZmaULZXjTAJqJVsnXZ9QuY0gnCnqhpMKFulj2/UeysBpRgOkTPMJ1+WJoITLl9/hlDlv8gO1fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389395; c=relaxed/simple;
	bh=E1xLET5Veg9AVrj2BYoJUoEdzwu9oP4MMi0dsBiszhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZCNy6PdTikjDpwKaFZDQL//8yvlfJ7C3hB/Uj9GyyHKf7lGOxgp6pZBp6r6CdqmnfxOqq3ltb5dbHCKj6fxEFnJza/WoFGJAlDaJ8tSK+Z9x3+KOTOE+xJ+3ajPcgmdrqWmStrkdDAKsuNojifbooYh1yS6LBMFjgqF85VVs2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zer09ZUL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s/dfzJFp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zer09ZUL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s/dfzJFp"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBe22T026231;
	Fri, 19 Jul 2024 11:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cdZUiJ1vVXWVE4Us1kpjlWyD5nqXoLUJtjw0QY1IVOY=; b=
	Zer09ZUL5R3s96KGajUZA2l8xg6xKqPB6wDjQMQjRvMSj8iIFhwLHZhsYVBXHhlJ
	qmLJ/3NODPmkLEWWFtF4sjpQPQWfZMGgfWJ2crUQch2mqxnKuBZcey7eNZl6RbDY
	KYOC4Z+0wRC14XOcPcx7OKwveMEZ9ySmPOQosVQMoHQTAhQ8hUSJn7n/FaIcYVqh
	nv+3lhgMK7h+juzIqALzVa7dFo90/nkDk87vGz1SQhQc2A3Lx9bpdze41BsBDVyj
	3l27GArOm7LI8vXgDxFgTNZyFMVKUkwl2fTnl4PiKnNFOZEnw26+rV/GAmpRUZMu
	yjGCQzMd5G7w5Bso2gC/ng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqfkr04s-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:43:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JBIh97039597;
	Fri, 19 Jul 2024 11:30:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexj2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7B00us33s52NUw/Fa96a0vdjsuMvbGNAjm/RFpEr81RUAfRxKEc0So0H9FBWv/0GejKYSTUtIBGTZAyMC40jPWpyGzbwCwqMkqEoKmgVtKbnnD02kpryv7Z/MxJi1hA/vyRkD5jVFFStozZAkzxN3zCgXtmX1YvYcyq9+dg/NyMzeL0rk1IYhGOwqtIjIa0YuOMNx9zxfNk84tL2raqP6blbw43Pi0BxbrvChte9YXk2ihzzYb6+/oTgntKxyxk2DrKl6vjZLoekZg+swQEmfsCvQOcVGwcp86vWXXK7euiuFdqsPKazX9HcXMQEwAHRzWEuF5kHr3lUT2fRFJ4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdZUiJ1vVXWVE4Us1kpjlWyD5nqXoLUJtjw0QY1IVOY=;
 b=ZlKZNmv5Ag32M/W3sHVT5Tfud1FL6Xj2/CTjAiVkhCcVxDT+Jqi/xuFImEl8nO0ciC7kvJuTZOiW2yigIA4o0vEXtWnnaNDv/V6Kp+BpzisVXUYdiNA+nYle1NKInM8rHNkpPw3Db4TxGk3XFC+dhUAaDhdeopy2T4bUFC4okntm/F2XXvbgqySxT31GZtXnVczFjQzEqBwHm2AbSVEfnty66rVcRSTRXIgD0WBXu/gqMQMtguyWTHGUy2UCwbDADJR1l3Hzwyj7bRhNWK13NH1xLkOtN0xU5wxywuitv54njMbOUysY9eTzOa6YvQeqaQpltBuvY/jcJOktkUMrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdZUiJ1vVXWVE4Us1kpjlWyD5nqXoLUJtjw0QY1IVOY=;
 b=s/dfzJFpdR2Ully0YwirPHNyaJrviIQalDBdhDpDwA2VsZhSeBJHSDVvoBF7hRn52kmQUfzRWO0P3b+gFKxeixn7Hw0s/pju1ZX+gbJ5A+tfyIx9Wu3mvpuk3HfyHCIqf3YInYBA78wvOd3K5VX0aVcZrqbhwDRccPblDj0/mmU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 10/15] block: Catch possible entries missing from hctx_flag_name[]
Date: Fri, 19 Jul 2024 11:29:07 +0000
Message-Id: <20240719112912.3830443-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: d3741568-52ff-4aa8-1e97-08dca7e61ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?O+JD8uI914MXktBz/ssq2269kM35yRKvrCw45bplf3RKjtlEp8EQqAj/9DjZ?=
 =?us-ascii?Q?EawzeZoJy8EVWxujaSfOKVRld1gLMlyr9b1uheltSCnCtSJbERn6qAijkGcs?=
 =?us-ascii?Q?af0237KP8EOg1AkgDfGTa1hlkOoRFRVO5umXFj5jBH0/orxpu7dpWqn0CSwh?=
 =?us-ascii?Q?JetyxFYj2K/01p+8VcXS9/gr6kk9OzHmxUYKAg4e8PF9UkMc4o9/w8V2UkON?=
 =?us-ascii?Q?M84RP0aosSJ3ulZj9mO2DGZX5WDl7Ztw0SAVbsShg1Z5fZZTDL7803mCCgVy?=
 =?us-ascii?Q?sWnuHSW8QPOpRaksATrc0YjTeQf6YZOBB102AE0A3iVKXLgHThQofuK1i8rk?=
 =?us-ascii?Q?nmyxyJp8vq38sWtiQckp2bGu4e0TMWAULTYi7vomWLPFAEnUgMNoxJcXFNDY?=
 =?us-ascii?Q?r+sIa0FVEflhHnyj0aXX7Xa2njxZtuuvoblCmkb6LLBlkPmM5iszjmtA5Ppi?=
 =?us-ascii?Q?9jB62gnVP8wysdLKAI8v9CS1PVwhVn0ss8AuxncjN3RPVJhDDOC4ctjDNXkD?=
 =?us-ascii?Q?L1sQ1Wj7MsUOS0XROp0U8R3SbiVuNeJs018cnm3gT7BAjKDJwkoHUF7PhnjN?=
 =?us-ascii?Q?V3ht9zQSCCAzrpCZj1J/fUbKAeEVc2AVRXdxoOeUG6DKe3K3xp8INzVugUdC?=
 =?us-ascii?Q?QkgUTFv2S1b/ZX5JR1F0fYYsdNxGJD1lmlKZ4TZQ0qwPoZWTMXwdT19fiBoK?=
 =?us-ascii?Q?7MYtwQtq8iHc441xWeNHasTVZncEQCsxRJnVyuQjrLbudWdGZpJ9OzmAZF8s?=
 =?us-ascii?Q?sM2rwWIHfBU3DksZRCJ5ix+DzlMaf7a7qwqb9shRt/qgqnWUOoXgQ5kkOW50?=
 =?us-ascii?Q?qI3Q6z7TNhLMmQ+gusIH4krgGAFj6FGu3mwHNdGd8u7qzVqxkP51lKh+1UIz?=
 =?us-ascii?Q?rYx97I54/Fr8sLD0ZMPE6XSdxbANJO9AA/2YFY/SX/UvlDZ+CpIVc0QQYwGF?=
 =?us-ascii?Q?WqpWZm3Iv4kN+QidMDxpReezUE23TePBp4kXl+LpQxu7bJSj6bPvP44Ay3Cz?=
 =?us-ascii?Q?EpmygaVfMVgLWNdSk1YNrhIet999HJH+8/ieZkHWam9TTfsNNIjk0L8zMedu?=
 =?us-ascii?Q?MlKYPGR6tKgJ0ZB6VcXN7/RKM6sWC/3Vy1RY6e3llJ6ZYm33D5QsN9SCMDTr?=
 =?us-ascii?Q?OpffqTVhOFSoaNdR71JEDPeX2Dqkj28DZGSsT1V+jwhTj36F/YEtM7l0Oq21?=
 =?us-ascii?Q?76Z/cqbOHdqRG7JiEX+zSOtL4oDPo0Y4xgfjjD2AErzMdUCBqXiTWrAhMYOz?=
 =?us-ascii?Q?QDiDj+JlV9oFXetqcPmhDh3f0Pe388ixwocqyg3fDChKOxK82fVl4M0JK+Y5?=
 =?us-ascii?Q?uqjDATDRb805FPiIRouyzhICIKWKp8GfdKukPfbzi9QesA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EPDMkA+Lf/r5z8M1ePMshkZpu8m2KbEAfhfkyKKojRTEmWHtgjic+x5nfYBO?=
 =?us-ascii?Q?yPeU/u4gxs/MwlUYnsPIClReS4DpFrE2C4RzYB7nItMPrh4S8IoOSNX6uZlf?=
 =?us-ascii?Q?qBz7GgI+Nj041CAwOSfmfQMVVYbqj8OktbRd5g88fr6VZMUpEfHFnTV06KFn?=
 =?us-ascii?Q?KDMQx2X0gC2WJOvuwHrJ8AyNbgyjZWWslEIuI4ctyoibETfxFoOIvd6iH5oF?=
 =?us-ascii?Q?kp+9KRdLOKiqLRDwy9OPvj1EvGBEu038DOFTWeJbi/fSxBLt9F7v/YpDiaxO?=
 =?us-ascii?Q?2OFb2BjY4cCeNpDhICwIwTHI6IYlwcSFBol0y/pOnS1XtxFNaVw8vBQECtbc?=
 =?us-ascii?Q?zbR+l/DQ2zCCHi61CxUM8tulABSq4QMEF0stc/qtV5gHmaQhcBBuESpV+AYO?=
 =?us-ascii?Q?cijQBuQV5kLcWbGDlMzxWEuqdIu33YHdrIZSg/evqLVuHs6lnrbl3VojFh/w?=
 =?us-ascii?Q?CdJkri93bpZAI5PBojY+DiSCvAcUwEhaM1lbHlSsOIMbmQm2y9mij5R2CS/d?=
 =?us-ascii?Q?HwjgX9lghk38Q4xXQGodByFClOFwbxs9GkXzV9GfHMGXfY8elH7XVEvnI6CU?=
 =?us-ascii?Q?W3khxVjeCQsATsm6WILCfMWr5PKBQPRRBHTrB3vo9XovCiAhbzU8tAZQZm/V?=
 =?us-ascii?Q?3Gv507BtmiVh9mch0afyXHNr+c8yZV+ZOEj04y04N37gPH44mtzS+nOXBCcD?=
 =?us-ascii?Q?oopHdU2CYOXD+TW9aGg9bQB6DKOgkKky3MMC7qSIV4Xqj3aZgZnr8U2+1LPi?=
 =?us-ascii?Q?d32Rl2ahjTEqYJPkAAZOD9HgjCKza1dom7nDe8OL+9ORqRMr62UXxrDDEZ9m?=
 =?us-ascii?Q?b7qxolIQhTAbveDgeF9NUk9eQxQb3t2z4O6dq0u0YVdi+3uTPQBKxObzOcTW?=
 =?us-ascii?Q?hdktQEZm/fE29MStBxEYrPwrGWL3zNtJcS7Z4K3yOAlkUR1AhEgzlMqK4V9Y?=
 =?us-ascii?Q?INT4ektF87v9HI3a/GhzpDPwWp/UIgd06//Vh/Y5jQsZKVdbpwkduhmZwqTL?=
 =?us-ascii?Q?bem2ZqYkA9w2k2FltT6PMvA++T1UBURxdYOltT02BSTdG4XwyfcnLuLbcPsP?=
 =?us-ascii?Q?kgF6FQKRncq/xAABLWg18d6wpn/dBz1MVFyBBUTlBkE/L+N0c13zrnrZ2KPa?=
 =?us-ascii?Q?IltqjAfjA4xjI2m89qxeiH/DNXNozskz0e9W2OSLd2xQUDLVyMlQfQtMnxg/?=
 =?us-ascii?Q?HBhLZy7Ahttiyf+VZzf06efU3LgabTPNo+B/0uKZvxooQa3GoRyNZLdilR0v?=
 =?us-ascii?Q?oLyiNQ2Sp7mPwhquDHcg3Qlvv7JzrbPp8v7vbQro0d4kML/EL/vxU9ZM7u5O?=
 =?us-ascii?Q?3/ihnO+y2bxanmzsgWntTBzkbhYBm2k/4WxJOxhZdoEEkZsnWgEAMqH4dGkp?=
 =?us-ascii?Q?Ql82CqgUZGzSdn15X46A8d5W4hlCGPuKmhgQgtWPjdpxPwgJMe3epJGAnJVi?=
 =?us-ascii?Q?4kbouvhvc5vkzjvb5trrWPcJJQoJutj51XNxwfkPBBMqg1fg0r1y62fopUNM?=
 =?us-ascii?Q?yZ/CN5Wc1Ab+hMyrK7QmofVuo8qlnkJZdlnwnnBVxyelXyBKn0UFTzidrfKi?=
 =?us-ascii?Q?3dSrr+s1NP1ReTWlbYItWQYjV1lxrLhJhKCsmN/xlBSAInWpRV6diIaiwgIR?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	48g81T/bvOy11Fy9LoHb57dhp1v9YMhAqt/f+wrc8fO8kZFl1Xpz4mXTiS4pCY128L0lvCzavGJfQByW8Bq5rJffpLOaGHozbxmAH7dsU3heUavAlhdrd6BJNaRlzt4jRA6bsmqvkE7FhURIj7PHj4LLt+Pc6CTq4dkUJnurPYlpbmU1aSxKwTCnWRtltn2HLwG2ZHQkRu4NN5698SRAD2X86uH8ZJhzC7tDJEgXALFPH/IdCP4IdXrk+x00c5mjfTio+Ou4V3Stv9VRodDd/7Uc160rUBXJ/5Tb0wtJHc8jHkTH3dhGAwWCA1gfSawdLgwl/T+Rl0g0+BNGVvR79/I71wNESrbOnyy+q4j9/NlstcMuTGEqiUa7Q6pRhFMTjCF7vyC8G1YyJJcmrox2i/1khQyFKCHxYM4jaJVMLA+Qa8o6KUs9RsC9/V2WTZJO6GayC+kS9o7WqPCNIb28UaW2vXuTAQFlTRqfZwrY5gDmLN1QppMsq3HHJBBIDS49i+qwmspcbS5R6nwgd6FfBNG88ekbQ4jnxgrDKlbNerLC8HNUS4yxZm1c1kkWTK8E/SvGbD0tyPyrHzrVSUXB91P3wjOZWrJ7hgQuZYoo9NA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3741568-52ff-4aa8-1e97-08dca7e61ef6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:58.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYuLF0xMF/0C4OqsScm7y8BaTpqZHZn41G3xkFIavPmaiwytJ/OOoWR8igYAMsI7HmG1bAn5HGy9yEyX6Ozqkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190088
X-Proofpoint-GUID: SE4Sfy2ds_tm7ioYVdmMovRrs19kfbHL
X-Proofpoint-ORIG-GUID: SE4Sfy2ds_tm7ioYVdmMovRrs19kfbHL

Refresh values in BLK_MQ_F_x enum, and then re-arrange members in
hctx_flag_name[] to match that enum. Renumber
BLK_MQ_F_ALLOC_POLICY_START_BIT to match the value refresh.

Add a BUILD_BUG_ON() call to ensure that we are not missing entries in
hctx_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c |  3 +++
 include/linux/blk-mq.h | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 85be8aa39b90..8618aa07ba2d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -196,6 +196,9 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
+	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) !=
+			BLK_MQ_F_ALLOC_POLICY_START_BIT);
+
 	seq_puts(m, "alloc_policy=");
 	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
 	    alloc_policy_name[alloc_policy])
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4905a1d67551..27241009c8f9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -644,6 +644,7 @@ struct blk_mq_ops {
 #endif
 };
 
+/* Keep hctx_flag_name[] in sync with the definitions below */
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
@@ -653,15 +654,16 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
-	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_BLOCKING	= 1 << 4,
 	/* Do not allow an I/O scheduler to be configured. */
-	BLK_MQ_F_NO_SCHED	= 1 << 6,
+	BLK_MQ_F_NO_SCHED	= 1 << 5,
+
 	/*
 	 * Select 'none' during queue registration in case of a single hwq
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
-	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
-	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
+	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
+	BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 };
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
-- 
2.31.1

