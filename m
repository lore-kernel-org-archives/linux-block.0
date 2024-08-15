Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC966BFC7
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743851; cv=fail; b=uaH31oGOepuvpYx5hANRA21yOTmO56cyJLtgjonLdIRfR6ERcBcL7OihMv3QLmZcZ1ZKZ33J3AWYRkhpz3YvU92Qul/+TC4DgjSPalznAvtONxfsHk20sGhEibnmYspMxD+8uGlg1RvJQhET545OZjy/eOlj4je9pF5qPtv8aHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743851; c=relaxed/simple;
	bh=jGhsrgKcMOhocfrhGpBtZNdV2WO7jpZc4hihjDSTg/s=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=C4avLx14soWY33zYlVoTqAFTYvnEorJC5t5ZFIp1NOIwB2O1pO9H/PsjodnU91Fem6ZRKxnxmEx+cwDa9iiOtHEP8pzyQigM+KyeIEAZIzu9cJSTwlgoPcj/zqtiWmXzUODMJo/PWjQN5AxJp39DF773JMyfak1Q5OU9usvJE7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BgAZpZAO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vw7rGLbS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BgAZpZAO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vw7rGLbS"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtaku016228;
	Thu, 15 Aug 2024 17:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=tSSzjCaH3N6Yis
	/4RmWSFfmd6MVq0VGWv0v/So+2XJ0=; b=BgAZpZAObpwxj0maBM6dh1qSveMMoS
	kdq6hcNTiR92pm0oLnkPPqHTRO7A2KaPmVSNevEG0OUrA3ZRp7YmXiAMSMc+zEBg
	2RR/i/Hfk8Qp83catSjL5siDmwpxpxFias5kCWhM7azrkSUJR7KdJrzlfbQaN3Fh
	jLC8t1lMiNzYi3a19545ARhju4RfcEgfaOXwtJasHiRVYMKMNvr16H2LdeDXlRR2
	PAAoKCddWDkpgeYLdq0dGEygTxIHuVI66Z6+YYR2mQPwxBGS3JwLt5LwdtAtcCng
	xq71K1U2XlHC8iglZKY868xOXS55MXMoF7XKb+xGhSa/okhVNSklPRCQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmd2w0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 17:44:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FH8MNC003350;
	Thu, 15 Aug 2024 17:44:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnbap0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 17:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWDA47Tb7/iiUcM+ktDuJgSHKyXE7doH5Ksr/QNxPnrPfymf+iptji2M18psMJHPZETRKjrg0zqSqWQBMvgX9n5nwLbA1h7BN8akb3GKt4EnaV0qvH4dT+Hcipv22Gbi5+Z4n88ii/YiODilxW1X+L70mE9VOJbbqLKEmPLCzLKgmMcJAf2djkfhbP2nfg6KyQG+jnSuPKTTtJykMAOQkVrODBDPuaqY9KdFH/ipQrXPAW6jBu2I8LPK1mNhhSp1NW7BQ/MdHESq9NdKHfBgjxb7G1HC2j4ldXas7bDApNbnymr1wSdSUcVK7fkQZqS35LHH3aNpuviyJfQp2CCliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSSzjCaH3N6Yis/4RmWSFfmd6MVq0VGWv0v/So+2XJ0=;
 b=wXddNiBm/r9LQhz3gO1RhrEWSpR/HSB6v+DU3z8QisVtx9rwhYmaiVVxgbC08tdd05qKI9TPJGWZ17GYp/cqJugTEM/xgb+4YLDnaPvaYQdydWVIp/WMVi65M7rpfqXX7TQMmofcRRru8l7oQZcLVDKHU11IQANHTDKS7xPSMDd9x9eHl0gnv6v3SW6oXGdoiraiMmxj2/k6GOIitml/EnnU15pKYKon9Wkvr4aVokQ0TJ7/0FywSQ8VbXyXEAjorZ0kxfQHtLuAL8DU/rg2hr4RWTQxOwn7AZgvMbek8Nprb/tsbAJU+Mr7YLFPXaTPC0KXhASuzKGhExO+7IPUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSSzjCaH3N6Yis/4RmWSFfmd6MVq0VGWv0v/So+2XJ0=;
 b=vw7rGLbSQkmHGpIg1x22AYX3sxFswK4RiyLYWl15cLbIDJs/5GNoUYf+rwOUYX7JKSthVWkfjigb0/gpP4w0jXeYFM2yoArkvleXcycnqDM0MDANmZ1Y+3ka1rIwAoC0E8jz682WSshDWyl1Hn/XL1jLIZTcHw3LB+qWbZ67U3s=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS0PR10MB7430.namprd10.prod.outlook.com (2603:10b6:8:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 17:43:59 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 17:43:59 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH v2 2/2] block: Drop NULL check in
 bdev_write_zeroes_sectors()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240815163228.216051-3-john.g.garry@oracle.com> (John Garry's
	message of "Thu, 15 Aug 2024 16:32:28 +0000")
Organization: Oracle Corporation
Message-ID: <yq14j7lsmui.fsf@ca-mkp.ca.oracle.com>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
	<20240815163228.216051-3-john.g.garry@oracle.com>
Date: Thu, 15 Aug 2024 13:43:57 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS0PR10MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 475a6fdd-af6f-48b1-2d36-08dcbd51d7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3pxLTU40r+SWvIXUFDXQ7TpaEM/E8syZCGnvcN7VMjN9YM+pfXEsnHO/hGc6?=
 =?us-ascii?Q?6i47mT+aRPWsoe2P8HhAq86E4dCv/52tbnjeyTnNOfEk666Y7S95+Z7HoySZ?=
 =?us-ascii?Q?FxefESZ4ctBmibktK/o0ycSNhqszuL23xP+cEamCYKWGsIjNPCncLXDfp01G?=
 =?us-ascii?Q?dXnbXBjs7mlEA2RyGPKII0R5FBnmyhcjaJuGFqBc/LQIQt9e2EHfjSmddbuZ?=
 =?us-ascii?Q?bNkGo+uowM2Q7LgnvrDGkgRAlILFnoRrTx2mpwsNFdlym8tNC5OR6SWR3fEt?=
 =?us-ascii?Q?SRl3RrtusDE5HKi8Ju/liEzAfemwJBh7zF0tp+fJlFGE/nGeToUco4LGAAsB?=
 =?us-ascii?Q?2yMY/9+4AyV8wZY9j9iga+dAGq7drFSKgpr8svgzUjL0XqENoTuuj+F5EPtR?=
 =?us-ascii?Q?wttnLTYXZaDSHRDaS8/i7aU3nbk15LB+oC4hHReywg+/699SdcsrFj9NqQJF?=
 =?us-ascii?Q?Bekxg18zK4zJayzbDFl8ndYwZ/9+Trs5mLX+mEKOeaezBYYKPSQThvZr3RYC?=
 =?us-ascii?Q?sDN9IDNAaM+hhTPNfxNaPV+pETfT/g/J2jc5zjKoFkppAVwLstXMgpTdl18i?=
 =?us-ascii?Q?uojiOm/hpegw5ejGICEAgc78PMBH+cKNvqN9BtQV2Nm3g+iUKyvxgzffwnky?=
 =?us-ascii?Q?/KFOZFLNZcgx6vnv1Ei/ojQ6f3HNdb90IpIEtMI5shHr4KEwju9r8ehz6Wot?=
 =?us-ascii?Q?bDwBo/hDBrDwv8tfm27HjPhsK5u1mhJSLvRfSWCFupdIdCd5nLCCxrPT7kTg?=
 =?us-ascii?Q?MWrPx8FaXfl4fG8LcMrmAtnADFCQE1b3/HKwNZfv3ArH0wwSqQzXylUhobvp?=
 =?us-ascii?Q?6Apf+Pnbl0aZl+BTpXee6AHMLD0WHx+J3+cNZ1m07yh3KrgNxxKDYZoDmPRy?=
 =?us-ascii?Q?ZjrZSV6yiM1pYvWOvyvVSCRVuJN6HK3rPFnPyqaYYqlHBjXJhPb7biWsXnJS?=
 =?us-ascii?Q?tPLVaG7OS2WGZRXx5nuLylHE6KANVP9JKGdsJsvWCPf3ssY7r1qh1btcrrJ9?=
 =?us-ascii?Q?UkqFETS3PpxX1OdgXlmCXI790vnsvl2wLeaN8HA+3TkGpk2YOSYskGFvBqsi?=
 =?us-ascii?Q?lBqfAe+jn4q699P/xr6XtNMXa/dSZH+1ehncPcJhJghSkLZLuHRG9Hek56Tg?=
 =?us-ascii?Q?TiSi7SS/ZUhPAlO5gvWBYnv9de58oM0dv17U4th7MgFf2Ngqe2UffcCCpBGT?=
 =?us-ascii?Q?8JnQHLD2qxPBn8j/vpJWSYPHNwOIo/Y1Vp2S7g2ps+weXBUpjOPDc1DrGxXl?=
 =?us-ascii?Q?wOjU3oYmQ8lFHDKXqJuymYGG+oPvWN+jG6GI/3YJKorhFlXavvBKVPnugxTx?=
 =?us-ascii?Q?wHCq+CgBkrzVs0mgmzYt6FelaC5x7ZQfHKSdKSjhkDviug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HuQYMtldfxDtPh/5fna57KfG560KjZiUUKy/Ad695W0PbC4owK/o2cMwJsHZ?=
 =?us-ascii?Q?mhwXGcUGhf4DIof0D49q5A5d5IrEvfuPpov+cvxrKQgcdaO27M1Zvkv2tuFY?=
 =?us-ascii?Q?efmeeIpG+jvfWFZ4SCXNnzvkRYh5/BNPJUgMaZ9246C7DkfsV2ZOQR7BcLaw?=
 =?us-ascii?Q?VLJG/xGMDxt1cocKm69gEgmNlWPIaZEyrg9O3rPKF3/xsH5OaKenn3/Clkr8?=
 =?us-ascii?Q?QDVdGuMO8b4RN5YMnHhaFdWyB5Iz9NTcVkbyQ4rRwBBXrtfT3YQVQMezfxXJ?=
 =?us-ascii?Q?1/mTQ26hyqEbnIovHdYDvy0TCiWlxIPUefhT5QF5OPnNDF64GDNtIYn9DpWc?=
 =?us-ascii?Q?wwzt6x52fv/8Gns0ry2O6q0Q6P263do6zlnpv47t8JFQawok1Qwny+tweoCp?=
 =?us-ascii?Q?Fax//4ekGV27uVex+y4/923gDjvb1eK5mdGP2qC9UloFU+oF6QInrt85Fovk?=
 =?us-ascii?Q?mew3tFZI+E/0QdR2KTnEbB9yELvUBSq3DwttvsATVB4fjFBYKu5rh7ucV4ax?=
 =?us-ascii?Q?JJXT3W5huld+NoVWAhlJA0cdqJ9/9DSl4oEH6crecHExNZeAF/GWfeKb0uoL?=
 =?us-ascii?Q?o3+KoeGPoPBK2/D9kHEH96v/MtIvXr9sGNDsuKWRRmoIV9Q7gmF3NamuQsCR?=
 =?us-ascii?Q?DXef+dO0XKhg4yD/Lp3LDAxAeYi90A5hoa8epGpOqSQ4ub+7lr9kf5jeoXBu?=
 =?us-ascii?Q?dtpcD0t1CP/zH0jfAYuXsk2ir5uIjUj3dM5E8YjCFb1tGmwa6jjOOiVJ/tl0?=
 =?us-ascii?Q?6HtGGZbBoAYh+6H0R1X69rvdDi7R0dY7ZlfW1/Swny36xL6oGlJDmA86SJdb?=
 =?us-ascii?Q?0QSlff8tXgaQHbMtEgKhFJdDAGzBUncmfX7T8sAHSoyBfwWtValMPJR0NUMH?=
 =?us-ascii?Q?FrelGvHgnTQj7NQ5QUJZSpWN7AGvQIotzqC/7WOv87Wql3UeGYJSeU3KRgua?=
 =?us-ascii?Q?5bKwPgE+fLmgck02tPXEAZ2vQoWE+zoyAoIPW6KZv2x7Na4qcsJ7+lIEWuVh?=
 =?us-ascii?Q?Tk7jyVm2gMQfsE/CwR4bd2VhfHjiZDhetKmEPbhVIaf7QLeBlMNJ4JrdYryl?=
 =?us-ascii?Q?7C97hY0XsqA1jXk7TLpijcBZ5gOTxpBEdOgeQCqNNFM1kgvciZ5idXY+xeaF?=
 =?us-ascii?Q?EYZz3MlAJyIpAy4j0OC6YD+9VQVWpKaOkUSqxFbOjWqfX/yN6nd96NkwAWoG?=
 =?us-ascii?Q?RCwFAxeZMp9V4EM/VLc8/sWHNTClX4xpG9G8vzI9Fn5jhZsIkCG9Ek5Eljm8?=
 =?us-ascii?Q?GB3VPVMg4jIvnbhgIGjbmlLAiHIcwKk3C/4btYCaIG296AG+vzcy7MltXAAF?=
 =?us-ascii?Q?TNhBXuy07w5H2tEq96xUny4PTO6YpLqr4yHchP1UQePw0sitBwMx5+4vRuTn?=
 =?us-ascii?Q?d1lAXIJGs4+sbAbHLKuV/Ln2HL5jgpgh5/D3XrylSgZhmR/V9dCOVHqDsx6N?=
 =?us-ascii?Q?9R3YB3hzKFW7649Evx9L1tOoa2BB4omHAWHzqgDnf3eGlGxYvURF/9cYjqPo?=
 =?us-ascii?Q?Rt0ZRzEzEKsZc9xpDbBVRfiN8EDoFnhBpCY8IaZAvWfLdTHKe7Iab7jK7sEp?=
 =?us-ascii?Q?Odr6XBp9VikJ00jCKjmdlyoulKrLad1b501L/Uv8nOVtlkgp4j38FdCR0e80?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cZbqk4I1S7z5v+mkYXFrr/ZfCQ+MbjRhF7/Eqb+mfdI3YWZI1YsuPnoESyhkgv5y4fj9/g91s0HMjFKWjc13mwohHSxjfkQ3zZf0E+D5e3Q04yzZ21hj/8NxprXJ+cfx7zRMl6oRKVGXZ51ID/ysqYfoukwAZ9e1Md2QE8c7MvHVWlkDAljEdxK9nsPv2YRmhjiNrKJz+mg23XzRasYqO/Z33Ugw4uCypMm7crBPHuyHQncXNWJyEknpIRte8/Ns6FCHkCwUItLLNPUV7+TmkA5zsc2rJLou0DJiZ6dbW+AypIERxRYgvTmccetmTEPMOJuQbd9yZRa93V5MngiKE3SOXbE+YUqCdNymVBVGFDyn3YjAKXdifqdMxcDzrbkWRwBpQwS5zOp15CsOoSZCZyrNSmAUx8bWRgqNPzcFJ3rcoEJ1r4Sd5o/wvsC6KsvJX949A1F8iWk4e10aiOnHoC9rQXl28se+SXkOT8qM/TCFpkCGyoinVrMfJAoo+1IqQn9Nq5zgfKHPhn/jY+guUtkvfAVff33vYCfqzRLU1OwNPjx2tQjDq4wYKaErenPiACwUcaDJVBYzmVej6zIgRTtiuirQVlfZfQ+m4iRhccs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a6fdd-af6f-48b1-2d36-08dcbd51d7fd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:43:59.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qyn0sASzJyDjmKcKau/yLjfe/Rl56n/YWoyLJI1tNGUufUrWUHrwRooqEPXaprEhiPaenawUhvnA9iJUsdF0l89Yf1519hGvd8z3U/4GyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_10,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408150129
X-Proofpoint-ORIG-GUID: eL2bGHajNTMkEjpLwOlMzeF1V9QhWdFG
X-Proofpoint-GUID: eL2bGHajNTMkEjpLwOlMzeF1V9QhWdFG


John,

> Function bdev_get_queue() must not return NULL, so drop the check in
> bdev_write_zeroes_sectors().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
