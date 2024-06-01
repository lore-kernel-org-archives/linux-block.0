Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAF37E;
	Sat,  1 Jun 2024 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717220876; cv=fail; b=ZXQFcdN9orkLODqXvYiRkzFLXQ67hSPYfb4+ISc02hR/RFKGyquhfR+7Tiv1RPFwGWkgE/OZg8VRKPK3C56hdBgJElFAQn8cEYQptvMf7tiLMpSF16TEXBIMy1fRhJ0AoORx+Q6emBJA+2VWshLNBTlIIhNY9eCRdtU4oh9Ptss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717220876; c=relaxed/simple;
	bh=HZAX7LMEgmu2vri2r8J4gOI6mLL0P7w+0xWV07ia/iA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pkKYocgMZfu+XSA4rk+NZHfr8VRAjLubXxQXi96nfifLkwtcIdXnM+ZpNmRhxDauz/TlRPvKM07Kf/JuqwDoJQOuFdWCd/lxESfSbOtZ8yD/lZ1QI1//MlZ3TMP2DxD60YauszwqYfLvi+x7OQsmIIfaE4y7xvcTAHe6zpaEDQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4515LYTl003474;
	Sat, 1 Jun 2024 05:47:40 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dda6mS/d29EbhHf4vNCDtIgz06obxk2hinwalJwuu9NA=3D;_b?=
 =?UTF-8?Q?=3Dg3h72Pus3i3R6O5/jZz8k6Ivk7p/1Qz1RGtOoinssqgHr1ZiGmBNfkf6Szr7?=
 =?UTF-8?Q?8KsHAcYH_Hba8WSVPwAh+yxZucEEph3opkTd6KcLr84ZA0bR76XemPR+pdbzF37?=
 =?UTF-8?Q?NFzxKqgdyT81Rb_DvcvqVva/5MbQsh1JCEbuxtAhntitiW/rfFOrZcq8+StBwaZ?=
 =?UTF-8?Q?p/J7s3GmMDY9wSnEqImh_aK/lCt6gcUuiELldzyRsqTzz5iqaAJCVfvZVtY4UC3?=
 =?UTF-8?Q?P2x627zd7mnnmemqO9QcnicCx+_kk0l5W3ghr4lzEAz9s1+NTJtbjmxmBla1YLR?=
 =?UTF-8?Q?gl5IptHkJyqXzC/yDjIf/mjbC6FUYfri_Mg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07r2wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Jun 2024 05:47:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45148pUN020146;
	Sat, 1 Jun 2024 05:47:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yft34c992-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Jun 2024 05:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIcIZYLrCKUklqvsdKQeP778tbVQb6G9D1W6ncB3N0Ybj4Dke5zwxzAyIfii1/jQl6nfm8Sil8ER3B6rv5vQJ+FtJWYXuB+acZgeVhsLhL7f7/bA6zJ60nPRA8Js6LmIR924Hfdqnlj/gwKshaDK5mwtp0teVjnrFdJGg8InfwVu5Zqqt7auVZaytJG5qsc8LGi+qszKGPEYng4BwPxxDH/s8QfP6et7zZPHQd0U071chbjlhU1DBAqTyGTtZoC3P7a8XKKHP4IsGjNDuJiYZ4QAZELcEb0wpScUKy34oNzFMgLEjs9XFW7A1boytYBTs8xi6YXJs/yH4g+wuIpCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da6mS/d29EbhHf4vNCDtIgz06obxk2hinwalJwuu9NA=;
 b=dwWmgeY3sD5kI+W1nGWF3z99XoWysaBCMYEMTZZyJNQoF85k0+mpbNov66SfA0EL7R8I4Uv3aomtXbrQbGZBdEXphiM83afzAsmIS4zfC9EBSt40YpeNRZfuNKOY1VkWGGo6T4n+1gEQ6nrkGQgbRC3L2U5qcggNfWMQo9wRHq2XsTAq+Kch7wQMO26z5sc1+QmkaGPYrlW545p5+rgx+/FS6dH5nCYIZdkskEZ6g4NDdgZJs6Sjgw8QuzHk2ZEHJQMf58gFLZh98cfDkpJWjlGz8vj5fv0RjOobmjcxZdvBhV3OU0MWlzLoJmMBOCpiNiDS8mHCGtsyT5q03M9LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da6mS/d29EbhHf4vNCDtIgz06obxk2hinwalJwuu9NA=;
 b=yYSHLCaXNrgP4nsqjah3KsO91Tm/2cPX5oOotUhW2nbP2vW/g2Wxe3AOwfTDxbIbGWCluGrPB2LD9Wi/T3g1cVaum1fX+oYi1glCVqdxxMcqb5J8rBoplnkzdODDz1TEJn69qaSu0Y4sBPOwNVE0AQstYI0FBXZ4CQqfe0Czkvk=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by PH8PR10MB6574.namprd10.prod.outlook.com (2603:10b6:510:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Sat, 1 Jun
 2024 05:47:36 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7633.018; Sat, 1 Jun 2024
 05:47:36 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHas1GbBcKZBLqJYUSK6DxXy7BR97GyZyrA
Date: Sat, 1 Jun 2024 05:47:36 +0000
Message-ID: 
 <IA1PR10MB72400391A961BEACCB257F1298FD2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240529200240.133331-1-gulam.mohamed@oracle.com>
 <20240531115644.GA23881@lst.de>
In-Reply-To: <20240531115644.GA23881@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|PH8PR10MB6574:EE_
x-ms-office365-filtering-correlation-id: 7c6daf21-c340-493a-bbcf-08dc81fe5737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1yiU43gBIsP5MfXiQ+UjNHgTfSTR93/ZqpGF687vLDBh1fgvG1RRg62uds4o?=
 =?us-ascii?Q?d+jIZFuxHgRj2kv3WPllmoYSUMIq34GLSsiFm/2cO84EaXB3szZd7lRcU87M?=
 =?us-ascii?Q?q/n6QofvvBzZT6uxaTzv1bB2gpVT/8C03bCQOoKovWPiyDRyEjVR+jU8wxD/?=
 =?us-ascii?Q?9zGKFRaLxbw1x5q6ieh63YMN8skbFX4izw0IFiizgdUkwFssJPVrzPmFiuTA?=
 =?us-ascii?Q?QgT8xQzRjT5MPRTkyPaFJwh89YCIZTXjSBqzi/KhBAOZnerBfHQp96FpzrbR?=
 =?us-ascii?Q?nfTVJA3irbCAqOOp8pmuU6n46DVTwj5RXkd1D3KAAClmYi8GCLCwDtT7a9v2?=
 =?us-ascii?Q?uRcqP7AfNYMwOASvboKROYZWkrx5JHNWMt6j7Q+LbUVPIznhit1Ojaz6NCNU?=
 =?us-ascii?Q?z8svqCK8MfUwVyHRStfKKLn3424XicGQZa/cLWMhe7K4Ljv8Phpl7n/4dE1/?=
 =?us-ascii?Q?XdfUGe1rgLr6uQT7lbZErxpkUlAE574zUNThGVkP2oS9LKXQxpbfkzERWjel?=
 =?us-ascii?Q?WDuot9g2ekNQ3JJ5LEviqtms2ap8Y4x1pSQEpyy4XI7svGE01RFDD8t7KyAi?=
 =?us-ascii?Q?eN/1KPHnS9tn44Cmwf9+6KalOc4qqFmnojmW4lvSpkZgIiB/RDOhsSq7l5zw?=
 =?us-ascii?Q?H6DcbJz2RRScWX2ecQ6S5DomaYWOQW02vcuz08HwmGyCaYssHAG9kl2nREtK?=
 =?us-ascii?Q?iRS6tarw1ZjguzaiWCaeRqU6xarcPylKZZ6U0K0EEtPPLwWpXriQGrhQEZNT?=
 =?us-ascii?Q?ZkcnhpPdI1hpr5FCZrStcWG0apqgUiNVjLhqvMdbVMXMZ8gxXP90PEQxkLSg?=
 =?us-ascii?Q?RLum0tyoZSqFGWm2iTo0EQr//ip+GWEjR4/FO1ykAGnhAsJ5gpq9HmBnVDfg?=
 =?us-ascii?Q?kW/uZVtyzN+VvZUdFFRWKL0S9T5KWRq8Lfj55qpQvukfdNSz0VilKSsDotHz?=
 =?us-ascii?Q?Jobh3jxKmAA2RAZyIlLiAc/OMU3m5TIdFWPSQJYKE+Z69TLJrgTE72gdaJ+J?=
 =?us-ascii?Q?OtXENJiDP/mIhwIbb9z4lFY6zwTIIf6EFujRHyYQVUV804NotBVl2jTD4Iv1?=
 =?us-ascii?Q?YOomfU34+hcQSbhRV6eIjPQ2kaXfVs7RxLimEMNo6eF9zSuyLi+Bth+LRhR9?=
 =?us-ascii?Q?PksiIv7FdLMZIYzAm+tMIrVwo4lXKYsTdVrqTDxWUFtUh1VPMhMaD8QS81Gh?=
 =?us-ascii?Q?JGCuRdIhaCBL6PfXpzMPZWNySlMs/XHFHzH8/nSiw8DXEO4DISUKJppV5W81?=
 =?us-ascii?Q?Bi+oRgXXdFYywVClN8/SMtUXmeTAnhdJxOhubepzeGG+43bnQ2vDTpqsPOA1?=
 =?us-ascii?Q?sVIm2cq39DW98ZvfuM2+C8HukV2aPUl5yRKidhkagkdNBA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eGtMfDSqnMZnhcs0Zr+MAvZiFC0UsJY99Vun3Wy5WaWa94xF6LCIGMBU2zJ1?=
 =?us-ascii?Q?Ajqk2vBUtsft+XPVxwfbLe5T7e6ES5VIjSSg0pMAT3gORpYC4e4xFESpokWC?=
 =?us-ascii?Q?Yz47o6d/QgZeTvgA6hVigixfLPTG7t/L4RMOqMisQM2xkUTXI5Njc1eL/tU9?=
 =?us-ascii?Q?GMST2sL5NsZ/FIFeVQ4L5/S80RWMMft9EmKEe1X0OYzo+7VBFLjiCKs7HQ15?=
 =?us-ascii?Q?Y96pQjoWz5clzlsMBRNrOckbpNKT1z6wrNwyBvQm3fY4O5rIHozwV6M2Zz6L?=
 =?us-ascii?Q?CNpnLOmuTa7mhmm/YkRdmp+vZdy1FJPK5MZDFwUlbX6aCwynJVySvJZUpAAA?=
 =?us-ascii?Q?s+RTAuISIWcrCKTRmc6+n3chyqpdfXeQZoBt2D4XXVjoa76Er1leTtbD/q9+?=
 =?us-ascii?Q?Wjg6DfyupmhHxWqCArzzZHgSZQ3QfpkETyAoesd+C9r281Y3wNsIQlUaGCxC?=
 =?us-ascii?Q?/ZArf6ZZyArSmSgO7+fkaLoJ8ZCKOqfQS1RTovn6Fdf+AYpE1nIlgFeZhueM?=
 =?us-ascii?Q?9BnBKLrgBuru7ayACLoD0EU0wUuZilQBC4xAuFfNT3Ed6LmJpDlsk7FgPgi8?=
 =?us-ascii?Q?36UqPZC8sLfoJbVGDSIhCTsuKxjdGmHZsSoOH2A1lnnr5pc1oFQUVnxaUEVQ?=
 =?us-ascii?Q?xIwZcEP/nEI4wCQFjXFsxB8d+ts/lGzl5ynCI3/BFiQ6E1y63UBaDYVEwX24?=
 =?us-ascii?Q?Ks3wHCv+0goFD8gMqQQShKlqKno9TVJL2GZaUOE5gx/fDt09VANghc6HMk8s?=
 =?us-ascii?Q?rFLGckHADsgKMKk3xI332KkiSr5vqI0k3uuGwsvHDtG32rSbSMtsQA1uJatu?=
 =?us-ascii?Q?slH759qwvxft1wlFMsCAPmGZ1fkg77vWbHiRMPAD62slqXNbUcfVYHeIUZxu?=
 =?us-ascii?Q?cZN5ZhR8bxNsoQVrk+kjAAgGB+iuZB66FRh2i1ftoxT4Lltqe4bBjA9Ib0oC?=
 =?us-ascii?Q?TbmHTaBK2HxWghMNx8/drYkce/DqFjDD078IZ04OZVdBhsujTfBr66sfu4Je?=
 =?us-ascii?Q?33Q4z8Nskka2ICychjPTtnpF+FoYqtq9LKG0D7Wm3vY+CvjsV0FpujhBcwW1?=
 =?us-ascii?Q?W364rbAx9rW6/4wlJ93WjWIYiTCEkKJGb7c+Qp4E7x6nHbirOCT3I2HwtkBk?=
 =?us-ascii?Q?zfoNsIChXOr2BmvSVe5dQOFVEzkz4HZw+7NvSVz2Iji5zbOZrvhVK/cdaR9S?=
 =?us-ascii?Q?SlR0gTQ3X5aq8Rg8QVZFEp/xoACtIqKe2rtIgCED/tP3EqyDeIBcJcs/X6Tv?=
 =?us-ascii?Q?lZC/3ZHf2fpEscS+CYuESBpNgKJRyHalwT9w+8yjy7ZIL43j1a1fSyp2AnWt?=
 =?us-ascii?Q?GVNPQXPjmC3zFPdN+swzVCmo3JDMwUI8DZ/MedCar6NKmVzc6jHuplVykLRs?=
 =?us-ascii?Q?yQyRrLyr9QHwgHVgXJEhht8+7kc5XbRLMlrXuKcug9oHaLSUUInmdjCHdBT4?=
 =?us-ascii?Q?c7dpJNlH/vcXyYzzt3Ubu14F3J3qCYxKgRTpvqyrFy/8DpoSPf3+7fbEmZ4J?=
 =?us-ascii?Q?T3QXnkive4po6dpPCT8DOerXmorzfSxmVWF4pn2/677fRC6DLIgeGMU8Aisu?=
 =?us-ascii?Q?fYewCzv9cZUhKkLp9ndiTEYRHCFSRycWHZ0TLhza?=
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
	GbOM4nqN+z7VurJMjbUBxrgbutU+trADJkMCpcXn/Lmw2st00DdiFzk9ras5AW1J80rEWZDX3lODWY2dVZ+vrlzZIjJWh36Fv2JF5HxEH64rYhrBa8bSEPfbD742cNNA318xPjIQAOqKOhsBfRLhwtiQHgLg/dNzeEv+JbxmuXyoNPPB+36bAqv7PFDTIi3DIhNbSFCI+BPk9u9Yzvr2Vqs2wx0wGKmN83brrz9+34/ZXcnoo1AeTruGPmZpMDsZsvYzVfwJqPjeTpsEbfxVBx/T8WG6OSX+valqe7fSBykOo6KXaiARnEvEpn1gA84dgcl6Ad57iNIlmxXNp0YeX+rGdmJlaf3fUuTR7IH2aF5d8DbSP9DdG3XLNw2lIRpotATL1+HjdZimyzflo00dCl4DsvOJzXCwYIJyJAu85gDjvTHVKcO4/LaPKyhBCi8UyQJMJGRRj0S7ma2zLCzI2Vinwyg0qD3xoDbpPPhG+vxTKLjTsiqnNaXZcipTQGAY/TVIfYih/u6UuJJCfTuDMKZ+DUqlCfjtDPimrkl1bXfyacZqmCeL/9mfVlT6tCQVaxVncXjvVpo3IU/Kjobx+rbt1OFfHDIr+38nxeHDDMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6daf21-c340-493a-bbcf-08dc81fe5737
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2024 05:47:36.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S18SWmpnQJT+UI6ezuv3JreuNhculSTng/UkO2pMl6gNfl52QI72VElbThYuixh0pdOqGqJuemW5UIljv3cD5fRGSbmXtSoSC6Bk2WyLcHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406010042
X-Proofpoint-GUID: hmb98iRSDsc1awNr9rAk1zOl8O6W_KKt
X-Proofpoint-ORIG-GUID: hmb98iRSDsc1awNr9rAk1zOl8O6W_KKt

Hi ,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, May 31, 2024 5:27 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk
> Subject: Re: [PATCH V3 for-6.10/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> On Wed, May 29, 2024 at 08:02:40PM +0000, Gulam Mohamed wrote:
> > Test case involves the following two scripts:
> >
> > script1.sh:
> >
> > while [ 1 ];
> > do
> >         losetup -P -f /home/opt/looptest/test10.img
> >         blkid /dev/loop0p1
> > done
> >
> > script2.sh:
> >
> > while [ 1 ];
> > do
> >         losetup -d /dev/loop0
> > done
>=20
> When just running these in the background, I just get spam of losetup err=
ors.
> Maybe you can turn this into a proper blktests test case with a sensible
> timeout?
>=20
Yes, the blktests test case for this is already in its final stage of the r=
eview

> A for the fix: I suspect it is bette to simply always defer the actual wo=
rk of
> disconnecting the backing device, as that avoid the race entirely, and
> simplifies the code in nbd by removing special cases.  Something like thi=
s:
I agree. This looks to be a good solution. Will implement this and send V4 =
for review

Thanks & Regards,
Gulam Mohamed.
>=20
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c index
> 93780f41646b75..c2238c1e2ad68d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1131,7 +1131,7 @@ static int loop_configure(struct loop_device *lo,
> blk_mode_t mode,
>  	return error;
>  }
>=20
> -static void __loop_clr_fd(struct loop_device *lo, bool release)
> +static void __loop_clr_fd(struct loop_device *lo)
>  {
>  	struct file *filp;
>  	gfp_t gfp =3D lo->old_gfp_mask;
> @@ -1139,14 +1139,6 @@ static void __loop_clr_fd(struct loop_device *lo,
> bool release)
>  	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
>  		blk_queue_write_cache(lo->lo_queue, false, false);
>=20
> -	/*
> -	 * Freeze the request queue when unbinding on a live file descriptor
> and
> -	 * thus an open device.  When called from ->release we are
> guaranteed
> -	 * that there is no I/O in progress already.
> -	 */
> -	if (!release)
> -		blk_mq_freeze_queue(lo->lo_queue);
> -
>  	spin_lock_irq(&lo->lo_lock);
>  	filp =3D lo->lo_backing_file;
>  	lo->lo_backing_file =3D NULL;
> @@ -1164,8 +1156,6 @@ static void __loop_clr_fd(struct loop_device *lo,
> bool release)
>  	mapping_set_gfp_mask(filp->f_mapping, gfp);
>  	/* This is safe: open() is still holding a reference. */
>  	module_put(THIS_MODULE);
> -	if (!release)
> -		blk_mq_unfreeze_queue(lo->lo_queue);
>=20
>  	disk_force_media_change(lo->lo_disk);
>=20
> @@ -1180,11 +1170,7 @@ static void __loop_clr_fd(struct loop_device *lo,
> bool release)
>  		 * must be at least one and it can only become zero when the
>  		 * current holder is released.
>  		 */
> -		if (!release)
> -			mutex_lock(&lo->lo_disk->open_mutex);
>  		err =3D bdev_disk_changed(lo->lo_disk, false);
> -		if (!release)
> -			mutex_unlock(&lo->lo_disk->open_mutex);
>  		if (err)
>  			pr_warn("%s: partition scan of loop%d failed
> (rc=3D%d)\n",
>  				__func__, lo->lo_number, err);
> @@ -1232,25 +1218,16 @@ static int loop_clr_fd(struct loop_device *lo)
>  		loop_global_unlock(lo, true);
>  		return -ENXIO;
>  	}
> +
>  	/*
> -	 * If we've explicitly asked to tear down the loop device,
> -	 * and it has an elevated reference count, set it for auto-teardown
> when
> -	 * the last reference goes away. This stops $!~#$@ udev from
> -	 * preventing teardown because it decided that it needs to run blkid
> on
> -	 * the loopback device whenever they appear. xfstests is notorious for
> -	 * failing tests because blkid via udev races with a losetup
> -	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup
> -d
> -	 * command to fail with EBUSY.
> +	 * Mark the device for removing the backing device on last close.
> +	 * If we are the only opener, also switch the state to roundown here
> to
> +	 * prevent new openers from coming in.
>  	 */
> -	if (disk_openers(lo->lo_disk) > 1) {
> -		lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
> -		loop_global_unlock(lo, true);
> -		return 0;
> -	}
> -	lo->lo_state =3D Lo_rundown;
> +	lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
> +	if (disk_openers(lo->lo_disk) =3D=3D 1)
> +		lo->lo_state =3D Lo_rundown;
>  	loop_global_unlock(lo, true);
> -
> -	__loop_clr_fd(lo, false);
>  	return 0;
>  }
>=20
> @@ -1720,22 +1697,24 @@ static int lo_compat_ioctl(struct block_device
> *bdev, blk_mode_t mode,  static void lo_release(struct gendisk *disk)  {
>  	struct loop_device *lo =3D disk->private_data;
> +	bool need_clear;
>=20
>  	if (disk_openers(disk) > 0)
>  		return;
>=20
> +	/*
> +	 * Clear the backing device information if this is the last close of
> +	 * a device that's been marked for auto clear, or on which
> LOOP_CLR_FD
> +	 * has been called.
> +	 */
>  	mutex_lock(&lo->lo_mutex);
> -	if (lo->lo_state =3D=3D Lo_bound && (lo->lo_flags &
> LO_FLAGS_AUTOCLEAR)) {
> +	if (lo->lo_state =3D=3D Lo_bound && (lo->lo_flags &
> LO_FLAGS_AUTOCLEAR))
>  		lo->lo_state =3D Lo_rundown;
> -		mutex_unlock(&lo->lo_mutex);
> -		/*
> -		 * In autoclear mode, stop the loop thread
> -		 * and remove configuration after last close.
> -		 */
> -		__loop_clr_fd(lo, true);
> -		return;
> -	}
> +	need_clear =3D (lo->lo_state =3D=3D Lo_rundown);
>  	mutex_unlock(&lo->lo_mutex);
> +
> +	if (need_clear)
> +		__loop_clr_fd(lo);
>  }
>=20
>  static void lo_free_disk(struct gendisk *disk)
