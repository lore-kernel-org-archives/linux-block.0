Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5A1E4A2;
	Mon,  3 Jun 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422857; cv=fail; b=H5Y27mt9qnT9NsQn43azV5OVFi0nS4m9lH2wKJO1nYQKrflWj5FNZd7FeeNag6Jjc5skOiy+Tl9DzL6qMYw77LMS7lMaoCtaeYFt7WOdANdxaRCDOn9gYT7KU5AqNCBOoeyaXPcFyNy4jFwWMJJwG1JqNrZ/Y4+SmbWJyvJ4yWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422857; c=relaxed/simple;
	bh=9EJsyAPAIZnZ/LMfuhp5xM60Dx+5Wz/bwOvAs7xGiTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h702FMWD6GQbN+s7Aji/Q3Xvcjlzzc346Zd7RVwwTxEcTBv+ctNA2EKvQv/C0kiTdRaubQtxSwKnQCvjZmfvKkEi6hQSZI3kITfhBLct7zHhrf2PEw/rDBsSBLHO38eIPxB8/ts+zJetNEIRRd91uEg6AttpwcMFc2Hf+Da/b+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CbMXD025852;
	Mon, 3 Jun 2024 13:54:08 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D3klZcE01LPpN+IquYj90sN8VQU4rhDHx/5DF9vi9nFM=3D;_b?=
 =?UTF-8?Q?=3DmkP9ipg0vJ0F2Mk7w2BJiEA7PIve8hbPOf/WEA79VSNoBYigVPQ2YLkFJPuR?=
 =?UTF-8?Q?wvEgz8nj_mWQa7xxdcn1tN+F86wlrYXz73Kpqp+e+MHt3TvwvPU2BOuoiVc+dJn?=
 =?UTF-8?Q?/6AMdw5jljri2M_s1PCmFA3hPsaI15jfgQ6Mj3FrP+LHmENvBMOsefTJGTLGmE2?=
 =?UTF-8?Q?UkK5ZdFLW4OuQdRmLeYi_JXUAiW4iZIz37N7rV+ExBuso+f9EEwiY/owd4w7iPr?=
 =?UTF-8?Q?4+9JbWvhDZ4X3I5MUCql80q7F9_MawN/BPugsZjyk09aB0+d+pT1iOhtgYHYImZ?=
 =?UTF-8?Q?k/4NTL37rvV5EprBp07V1kw105an3aiY_8A=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu2vfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:54:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ca6nT025127;
	Mon, 3 Jun 2024 13:54:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt771dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoKdZ5i7h8uIhV3YgLxuZREMy10UWIkbtca57WdcqfdWK7TyRl5BIZ4w3/ia/V02tCF/r1LhlcZiNUxOaugWPTDhCP1ST+0royWAl27HS9JLBp/fHELJ1GZtH2LU8C8rRdPhM9XI4l5Y44bq02njH+WVc5D2Efw4YhjG/GJet9HTjX8AQr3qFsAmJi6pVVZovfNE1magcRwEu+HYufdYXEDMrwBChzFnkWE/r0zpLwH0//S7kYC+h2m/C/7kB4WcEssXUYxh84fgabJbsVBRgyV4UJKjpXefaWBaQ1IYpHLuTNbF59k894ZKaplt+NLsZX0ExYkPyIsMCOH1Mw320g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3klZcE01LPpN+IquYj90sN8VQU4rhDHx/5DF9vi9nFM=;
 b=KqKYltlzFI3sBpxbXEei0aTvMHaxe013mBB/wggQb8h3BY1aRiOBQ01js/DccXVIWnryfpufCh8/vgwb69/cG03gs87L7yKrq5kyzjJLhTwO0nuAI5bPBEwch3y9kssWWBusEk9EtiRncw1nplMpnpaS3b+LX6m0uWSCGbrM8EZXNAja/oiXlho2sdCE0JcOu2oRmnqAZfGs/ntWloT0UKtZKsSASTlQLVp9c951OD/zK9awJOgK0PXYUIfYKxhANCmYPS2yaf+Vuxt8xUyMIfrutgBnA5qbYr2LmY30YAnyTKuD/cZAstu0R4+3mf1Lvv7gusUPnxuh62DeiBQKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3klZcE01LPpN+IquYj90sN8VQU4rhDHx/5DF9vi9nFM=;
 b=s4p3DsHh5jUonrvSe1hDebGh/rgKPuwfW3X5xIpiVf2NFJDZW5EsOGnboDAZoWKuFDO3zF1vZQyEBjMnfZ2ntzlLMYzuRU52o08/b3N8/PPDvAl5DD6YJYtb5OvfqDE9fKTV7LKgSb/JMLlNfHHFGJu9lVMZRSCLIJU6prSzEdw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 13:54:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 13:54:05 +0000
Message-ID: <f3ae00c4-1db5-4aeb-ac85-5dfa1d69354b@oracle.com>
Date: Mon, 3 Jun 2024 14:54:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix validation of block size
To: Damien Le Moal <dlemoal@kernel.org>, Andreas Hindborg <nmi@metaspace.dk>,
        Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
        Keith Busch
 <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240601202351.691952-1-nmi@metaspace.dk>
 <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
 <9d68c7c1-b1e6-4f42-8d4b-8c986ab688b5@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9d68c7c1-b1e6-4f42-8d4b-8c986ab688b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0459.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d0fcba-5def-4a89-5444-08dc83d4a1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V3YrYk5YeTBZa3dPZit4TGxVQ2pOVXBTcU8zR21SNjFGdGVuSm5aSlVWMkU3?=
 =?utf-8?B?OTNJc25YeUNjV0ova2VvMXM5eHFLc1VPbkhnM2RELzlpcDB2QXZlcEttUW1y?=
 =?utf-8?B?L2l5ZXh6YnEvRDlaeXpvUjZxSzJJYTBzTDBkczhJV1FsQWd0VmttNFJHenBr?=
 =?utf-8?B?dUh3d1FDcGlkWjF4QTM2NHJaQ0pJZTkyWitTN2lUeXRySCtjekhzWXBwWktO?=
 =?utf-8?B?Nm5kZFJBYVBPaGQ4MkR2SXBySHA0VTJmaDZpdnQ3M3lPTldZVFlPV1pFWFdU?=
 =?utf-8?B?Ui91RUVDSzJMbU9YdmRXQ1NtQ2NkdGZ5b1ZnamUyOHpGbXd0Y0pEMElvQWZG?=
 =?utf-8?B?WjVabjVKMGE1cWducjBjK2pvMFJoQm5sNWtHd1cxaGY1K0ttSE52bXQ2Sko5?=
 =?utf-8?B?QUpSKytSVG1VaFJtY3hWWEhHS0ZvYUJ2S2xnU1hoMXZ4WE0xWHlKdlRWZG5r?=
 =?utf-8?B?NW1jMW8zaGRzSHJ0TENTY1BDMmVUOTEvd1hrSjFqTWd2SVRvWnlyLzhLdFh0?=
 =?utf-8?B?cEhPU1dTdk1xTVo2NkdLempJbG55cmRIaGN1Mjluay90TXAxbjlEbnVaMmVp?=
 =?utf-8?B?YVYybWF4K1VUdndRdlpYLzBFVXAvOWo0MFRac1AvYmNzb1NTU21mbm5JWjQx?=
 =?utf-8?B?dzRPZVRlTTM4YzZhblB4eUJJVXc2QkUzam1QWERicm53WHpRMDNydjNQbVZ2?=
 =?utf-8?B?Wm92S1hKSUgybGZxRlNyOHZhT0ppVGpkSnNhS3FScUo4ck5yQTBGMTgwbVha?=
 =?utf-8?B?ODlGYmZlcTg3Y2wyUXgwWVVpSnorS05SUVQ0VVBwM2FYeGFVWjNjcU5Gd2wv?=
 =?utf-8?B?b3pqc0V3Z1h2VWora0dheWx5d1doQ0lMMGtXaVRRK2x5ZUx0QXF3cTRMWmdQ?=
 =?utf-8?B?aWgweXZ3OWQzSzJBRHkzczNwanBFVkxPV210cHVoM0ozZk90VUJzditXeXk5?=
 =?utf-8?B?Mm9pc0RaZGJjOHJjalFhOHo2WEUyK2czUG0xeExmanI3RENpV1dPeU01RFV3?=
 =?utf-8?B?Tk9odmFEZ0lVOWN1dzFnQVJta2VMWkRoOHNrYTh5bUF3R0p2VWx6R0VXR1pu?=
 =?utf-8?B?bmpuSlY1cmtzZzdUMUFNS0tpM08waHNkaXF2aUlsU0t4NGU3NytaUkhKWlc3?=
 =?utf-8?B?alFPdzhvL3JIMFoyWVlLYnpSVnlxc0Y4OHFZQ2NtWjJwZVhoL3ArQlowL2hQ?=
 =?utf-8?B?VHVJMDdPcmltK21wa1BRS0ZCQm5USWpUbVZnNytFRjd1c2pDeXZHdnZRQmxh?=
 =?utf-8?B?Uis4ajZva2Vnd2FRZkIxYlF1Sm1pMVJGeGN2aGZ4K1ZSWUlFTWhBUEs0cTQ1?=
 =?utf-8?B?dGo4ODZvNlg4Mmk3NE9qajJwMWUwSEp1a2dnbjhnVUJ0enF6NUxuUmhlbSt2?=
 =?utf-8?B?OUpoT3pqRFUwQjVRbWE3M2ZMV0pEUTV5T0hTM214ZU9NZkZ0aWg1ZnpFRnhQ?=
 =?utf-8?B?dUlxMzFxOFI4VmxPSWx3UG5vSHIvZXdJOUxpU0ZDMGpFM3duaGUxTVFlYkRn?=
 =?utf-8?B?RC80MTZMaXl6ZjVmOWttTEZCV053ZEtkVHVaNTYrODd4d3JsaWkxT3VzVXFB?=
 =?utf-8?B?dkFzaEIyWWMwcE1HT1ZqRm9ETzZsL1Q3eHVmSFVzT0Y5bWE0ZnhDMlhhUjFn?=
 =?utf-8?B?My9aSk5CUlVpMjhFK0IyVkJLRmJQczh0NmFZaG03eTdMTHpuc0dHQVNvTTVU?=
 =?utf-8?B?elRpV3NDemZQTEFnNGMzTmE1cVYzYWpYaEpia09tUWZRNktFMm0wSkZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWJ4dHBlSXdjV0JYRDdoVW8xS1RNT1JKZUxRYk44QmZLMkpQK3piaUlzSXh6?=
 =?utf-8?B?RHpqNXprOXNvOHRkVXQ3cDh3MU00eFVxTXBnZkVaSzJDOXBmaklKVTdiKzhK?=
 =?utf-8?B?VWI4Nk5PRzhxK2YzNTg5ejBCLzVTWVBydFdhR1R4YXpzemtoR21HeG53Qm03?=
 =?utf-8?B?cjNOV01sOE5GeHZiZGRydCtXVUgyRlg5VFZQVHZKTFdPTlo4a3lCUG1kVHQy?=
 =?utf-8?B?cFlxRGc1UzM4RytMQzFDWnY1MHh4d2lSRVJrN0tiblJ0cXMxQjBMYjdJOUFV?=
 =?utf-8?B?M201dGlCenhBMEZLdHU3dzgrVkREK1lZN3N4MGFjenFrOFNnS0NCNC9INjV3?=
 =?utf-8?B?a0lGV0lNZWwyYUtJVTFjbTJidVlLVDk3QXRaVmtpVkNxWm53Tzd5K0RjS2I5?=
 =?utf-8?B?Zm9ab3dFbnhpRUtqUTlNRVY4VUQ2Y0ozYUdZUDQ1cVlPQ2luRkpSeFRiSWZk?=
 =?utf-8?B?eTcxSVFRK21GNS9uYitpbWR5VTJMb2FKZUJ6VFVUR0JQSjdqdTk4SVVaRXVv?=
 =?utf-8?B?RzFIL2VheUlMWUVQa1ZKRkdnOFgvWVZ6UWhaRWNOcE1aN1laS1FJU285TmJE?=
 =?utf-8?B?Q0U3aGlpKzVGdUhmUFBveWMzQi9FdnhMR2hzU3A4VytEL295UU0vWnZWT2tM?=
 =?utf-8?B?RTFhQ1A2MmtPLzNYWWJLVHQzRUpMSHB3cHNZaWFWcERXT1pJQjE1NHFVMWFs?=
 =?utf-8?B?MU5nRE14SzVFdzhpcURGVnE2TFk0bi82VHpRNmtMRWFDUkc5UmloUEdzVVlZ?=
 =?utf-8?B?bUdwWE5vd2RKbUVTTEtDN2dQbFBLd3BuUi9sRy9Bb3lUNVV0cldDM1pzRFZB?=
 =?utf-8?B?SUVDRllnQnBNUHExSVFvMEhiYnhjNXdQTzlNMXBmYnA4VFBXTys0VE9aNjc5?=
 =?utf-8?B?bkI0ZW9mZkZZaEpRWlBETEJNc2ZtaTk5NU9NdW9RQlFyYWNiZDlyV0pGMzdF?=
 =?utf-8?B?ZWJrUXpSRnJGczVnaXAvcTQvOWNHOEUrMlR0SXlmMWN1MXFDcnNpVFFubFpH?=
 =?utf-8?B?dTRCME5JWGJ0djdVRzJBQ3NXVTFPT1VHWDBYL1JrbG96ODcvT2lrNkN6aG52?=
 =?utf-8?B?VldHNjBRY2ZKSmV6Kzh4MWdBdldvaUwvOWZhSmFOd1E4cUY2bGRjT1dUSGtz?=
 =?utf-8?B?S0dsSkpTL1BTa0tZeHRhSzl5M0hVY1JIV241a3NxNVY1SUt1Z0M2bHM0Qmc3?=
 =?utf-8?B?Y0RQNFVMaGxoeGt6eHU5MGxWVUdEb0JiUFVBSEtBeGc3cm5FZVFjSHhxYTUy?=
 =?utf-8?B?c2oyS3Y4SStnSzMzV0VDdzZobUg0ZW1KUXRUSWd0MDh6M3QybmFQZi9Udm9N?=
 =?utf-8?B?SmdlWkFzQmI1TGFvSzgwa3EwbHpXMHZiOGdJTkxvTkJ5OUxmMVQvbUpuaFJQ?=
 =?utf-8?B?NzhEUUlPdGl1RW1LY0dlZzFBUHdpYVlVdEtHNldEZEdtc2tMdUlLTGFCMU16?=
 =?utf-8?B?aFNHeUp3OGw5anZ6dERFVnZPYURqKzlGWmV3OHlWRHNudThjTGl6YXBoVG1n?=
 =?utf-8?B?ZmhPK21tRmVPcTVhRWxCV2kyZzhtZjdxc1pXL3RxOXpoNDJBWHpFaTRGYTRq?=
 =?utf-8?B?bHZDRWQwdDZJSy9hRUlJZE9Eajl0encvYmFhNloyRktkUCtqaVhZZXpnaXI5?=
 =?utf-8?B?Z0N0YTNHVERQZGdSanVndHNSbGhOc1NDaHZhZEJSam5JTnYwS2ltS1BxVXRS?=
 =?utf-8?B?UERlQ2VYeG5XUkNYM1ZBbVQ5NWpwN2hWOFEyRXJEejVjZWhHME0xUlVqR1N0?=
 =?utf-8?B?REo1dVFlTVpiUmVWWmN1Y2h1Q29RUFhQTVlma0RWOU9VVUpQZ0Z4T0dabEFC?=
 =?utf-8?B?QkFLRFZkbThYZkd2bEMzS2FUakR1c1p0eWdaMnJmNEtEUmJtSnBXSXhMSU1E?=
 =?utf-8?B?TEVyMml2dWFSK043dXZSWkJHdDBvUm5Xd2E4cDNVT1NYaXN0bHZwZml2SlRl?=
 =?utf-8?B?b0lhV2tFNmNiSFRheUtVRko0emVEUGNIdGNaeWFzZ1A4NWtWK0FCaldrSTFJ?=
 =?utf-8?B?ZmE0NE1sQ0JRa3NkRTJJR280cDQrM1V0Vm4yK0xLazhvWE12eTl4NjhKUnNB?=
 =?utf-8?B?M1gza1ltNWxTMm1nNnRPWUFWdnpLcGYxTHJTaXpCZzdBRFMxOUVSb1JlNmx2?=
 =?utf-8?Q?96o6jVB8ZC3JROFDjgsbuIn55?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nKzYRH3G1EstP0hxSWGi6TJiQCWNob2LTXmb2ubkSJgw4bjVzKoB4JLuurS14RG1H/Uzz/h2QzQYyIau54HDnG1PTaqaFUfqcDujEz21k9Gm6lvP0hBNV10d0tNa0GGkEggLAdZQlee1bRxZA+ljUlavjV97E+qE5LWqZoE3llb/7176PMYZIga6di/P/KlOZ+eL3F4kySgFatImVaRXhDjUCuQLoW/qhnMsNR33mvAaA21OX8j7bQlnUJu8usnMEFERMn3AE2thCMbjolUYhEb/RLlDnyUiPVLBzToqGS93neiJKo/kK6PyEroK6+oMrwy8qJY4YsglomlPCToftrQNjCR5JYbI+JhOzWaAzLkpfq4lP7Ab1sk1hnmDGgnmWx4kdr1WeE4tjgH7Z6q5Fjpd50AI7e/XlzRjr7EOF/ToBC3y3ya+WqQgRxbPS5Ef807piGWBfFRcvYJYn4Apu2K7A9bXbngI1wveMzU/CraS8dHeuYUPFdgAodusGTgaxNK1NayucW8HJLm66DbqzDJityT60yFBkw+gp0jhLH/8938k/VqE82NDs7j8lqrl5qylA7e15A8HEGp5uc9L16LgFQ/6iuCgEIO65IcvaWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0fcba-5def-4a89-5444-08dc83d4a1ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:54:05.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ACE/vLmm/cgWrTvxbaUmXm/tGc12L2qoDcQbQKqQDwrAs4NyMvLZVPXNfgAYsWPJ3IixbyurtlrSZ8nFs7AYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030116
X-Proofpoint-GUID: U0UBTtCrwhhvV3QljGSmKdBgHTBbcCts
X-Proofpoint-ORIG-GUID: U0UBTtCrwhhvV3QljGSmKdBgHTBbcCts

On 03/06/2024 00:59, Damien Le Moal wrote:
> On 6/2/24 19:57, John Garry wrote:
>> On 01/06/2024 21:23, Andreas Hindborg wrote:
>>> From: Andreas Hindborg<a.hindborg@samsung.com>
>>>
>>> Block size should be between 512
>>
>>> and 4096
>> Or PAGE_SIZE?
> PAGE_SIZE can be larger than 4096. But most drives are 512 or 4096 LBA-sized.

Sure, but maybe someone wants larger than 4096, like the LBS support.

Having said that, is there LBS support for nullb? I don't think so. I 
assume that PAGE_SIZE or 4096 limit would need to go for that.

Cheers,
John
