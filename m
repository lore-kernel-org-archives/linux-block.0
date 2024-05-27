Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512CE13A895;
	Mon, 27 May 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803798; cv=fail; b=L0ZEl0jzwXiL/QEMCtM/zUkxyMN/qwjunNAScowBbcUVA047T2Olb+GQ3F+Ng/pQNsJPFsVTwBq3qV6RZr6+sGsuI+j82Y2eHGGxzlfZFsufDKNQo3/VGC4Pen2Zy8gwbT4d2H+82ZIqOvHyjRqLDZ7eV+JObnKzm9XAWRjSiMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803798; c=relaxed/simple;
	bh=sLUxJtlJkdHjHegRYf0VzdwFmA92r8CVpUPMrYx5faA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYS/veJN7XZ9yAcOrpvB3gUa/+bRMfmWD65F4ppxr6tG3b7RVvtCCHzMNivEWrFmBgA4AepvndH40aAOioIpLpVDgDS83MTViUtbhLgq+R0Qa5RPFiejeTeID31n6jpfnWtG/i/svrNSXK2BJ8sHNdt+Z365qqadtlo9Y9I0ax8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44R7nPAC024015;
	Mon, 27 May 2024 09:56:23 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DwgrRi9ZYNRXMJhHngrg0jSmUo6me4xP5+vAOTv7YI8k=3D;_b?=
 =?UTF-8?Q?=3DHmDwFfn1SDEDQUrezXalytwrEs35g45u2GTOKM/qXW+azNg5m/2Gkk/yUYhc?=
 =?UTF-8?Q?ld6paLc8_LQD9FjWfpkifpko/IRoBFdErCWIMKTXNABv3J/P0oDXZidz7GbeTDl?=
 =?UTF-8?Q?WYTo6NLGQAM6M7_AX/GCLo7VXRN3daY/iu9ZzDNfn5HHc7wNtOFbk/ZB1P/43XM?=
 =?UTF-8?Q?WXhF1IcOk26RRNyMRBt5_sWoJmSUfvZnWKx9om3q5MXy+VRO6H2zO/PDbPLa6JQ?=
 =?UTF-8?Q?890XjV9pAs6VwHq9g6zvtK30+I_uyxUNE6SDG1KXVQ8+HBJ/bI+orC4nwB+7f/r?=
 =?UTF-8?Q?wdH81elkXd5iR5r3lmUzkKzw9+ZB9m3s_7g=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu2bgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 09:56:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44R9VPQS009274;
	Mon, 27 May 2024 09:56:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc529wha9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 09:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX4D/p4GilmjvXlJQdIpWC1GaDkBp8JtVeJeg+TAri/6/u6oHMEbwVWQNtW2VX2/EZ9OzpGFMb8vBPpydVfTvDmAHhfj/k7+59xBlxFoaJ8ALswr03iIYr0XIDKogBzGTUoZcqaw7UYIDfxNztx5SSkIqfchaYIqoIwxXTxBZhP9BvTlAamGosrij44x8YdK4kMYGZk9NdL4XGrY2iqizPQocrI6zdzk0SZwOb9GyhJzvNut+dlwDA/OYNjMB6bzUDlM6CBtdqB2xE9pE666Rrqo6yxwks2+VInoM4vA/s5To7613FN0NdaI6QLE67vggInFe+8VQcOmsmZs8K2CJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgrRi9ZYNRXMJhHngrg0jSmUo6me4xP5+vAOTv7YI8k=;
 b=jmxBqh9FVGCc0xVes7MaM31oyOucwflwBkDEmkOv8q67/pTIJ5h9e+JAYcLT29ydLsxq2rKyRmzBt/lOGfW8vWCcoS1LwKRtql5w1KjiecbSrei8anoSivWYzb7GAQJfCV2LKJhhqHlL6DO3x9CR/WTb8ZO/yYnQYHQgr98X6xqOe65pYJFpanbBsDpyMm4PXSrcHONWRbBwhT2dD0NSBn3d2JbdZJsbcOc5MsHm2SIfGACKTLEcNAGgW+91pNjZsAkIuCbmk0pf1fl7P8ydad8gIiwgNdfmR+5CbClx3O+vnJqdGIONasBugUd9VKFD31q/IPmkRg7pxUismF5QcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgrRi9ZYNRXMJhHngrg0jSmUo6me4xP5+vAOTv7YI8k=;
 b=XQWeFjGwpBQ+nUFXf954cFRghwEP+DEgBQy68VZfNaWapNLCXFPG6SSlU0o/6GnWs/7iQOAlBFJ8uDuEVekVK9+CI1yvD+VTp9fH5cK+e0KLQtBbwIWuKdPEOrNBeRcd6OQZzsqQDWPc8JjSrfV044GUcU0XWsBMPRN2GG3HmJo=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SN4PR10MB5608.namprd10.prod.outlook.com (2603:10b6:806:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:56:20 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:56:19 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH blktests] loop: Test to detect a race condition between
 loop detach and open
Thread-Topic: [PATCH blktests] loop: Test to detect a race condition between
 loop detach and open
Thread-Index: AQHasBwf89t+k7DPDEWtt0I+km2kdg==
Date: Mon, 27 May 2024 09:56:19 +0000
Message-ID: 
 <IA1PR10MB7240890CA0B9A1697674D84698F02@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <20240521224249.7389-2-gulam.mohamed@oracle.com>
 <g7c53po5btgdyxr56c2vxmyv3fdkcrq7qwcbeowjd5bulgqlvc@d3viig3wwgo2>
In-Reply-To: <g7c53po5btgdyxr56c2vxmyv3fdkcrq7qwcbeowjd5bulgqlvc@d3viig3wwgo2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SN4PR10MB5608:EE_
x-ms-office365-filtering-correlation-id: a898f06b-f848-484d-e28a-08dc7e33422f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?d+FhHnphUnKVHMfluMKeheyh408ia4v/uynOxLv5vBwW+qIqtY/8fc/l2ady?=
 =?us-ascii?Q?UDe5JJAHFBtCgODHZWVi3HPWkgtFKS8om5NtVt46kfmxDSV8EQHJRezin0xi?=
 =?us-ascii?Q?+RGbxFf8PldJdAsZmEN1bn8bnHjVcS9tIJ6UkKLplZ6Cg2dnMv7RmQSTxS6j?=
 =?us-ascii?Q?zwGnfkPhBKJ5/efJ0zyuMhJvr0cXt6DS9QbMuNy+YzFmI607EiBx70WoZEn2?=
 =?us-ascii?Q?q7XFsYYgEubAUGhTkBp3YezkDflmpxLwUijOfvCMWV0MLIb/SOUMqHkFeCFO?=
 =?us-ascii?Q?X86GFLXJiKRWB3JD0cOIvyD8iLfGhWmawgCeYp8Rde83UAl72UhbaX7ccOXR?=
 =?us-ascii?Q?LAOpKY6AyQS8mQp4tskmxqYx5/XT8UNj7gdE8UAADBiY8MpkBsSwqohYkmln?=
 =?us-ascii?Q?IEhZp81jFes4C8aJaRtahjsigGwvlz3JZScNPJKOxSPcmjkQ2Pc27L3PMEYa?=
 =?us-ascii?Q?DpbDffeFcVm2TwMFkBpFOPdZAbukOgHgqlakn1f/+yt4kI15J+J0VTQrDCjB?=
 =?us-ascii?Q?ivTeuQlWedjB6VRUaifRNQUOUgO2pHPIDhhwAyC6/rLKkVoAfkzp4H/rlV0o?=
 =?us-ascii?Q?r58YyYM4uh9QS8sFSelKxsh8lTOuXfEL8Xzyz2+02u5cfq77lv3easTimfJ5?=
 =?us-ascii?Q?bZ4tQ4Xeph48rfQOK9G+Un0GnDEKZF+66430NpcF952Cz0T76bG2tafR676d?=
 =?us-ascii?Q?m+yKSLSAHD8N+1IsocXcnXmHjAVmwrpo320550pfNmIMRQkoI/a95CVJ3v7j?=
 =?us-ascii?Q?9ARVf7KhrVp4TpPgKT559+5iFdroV7WKjN7NprVStNdt92sQJLKw5d1xlGX4?=
 =?us-ascii?Q?fPNFRN6eIkBDWDW1QRHJJajfWpOyaZO4M/UU6vuJB/MVkryIvLNPbQREWVqa?=
 =?us-ascii?Q?1/zluldtF2oDamtuxrssQCmZuhFpcGeVNIQAcUxOUAmkZG0m7w4atIY9ErTm?=
 =?us-ascii?Q?scExV0H1BZFDBSIUJMzO+t1ZuxTg+PavXiQBwEKAnKv5w3UleHDGfxcGn3ZH?=
 =?us-ascii?Q?y1zyHnQKIlnNZNLQB/pi4h5cfdjBl/c3VrOP3mhGEVUVL6/UzbMXviOAr2oV?=
 =?us-ascii?Q?PTfoc0YaifCHkqTsGv4r9Wew2FQn6i+vBpVQ8bvtmYRWBgrfcYkLo3FnlXm2?=
 =?us-ascii?Q?1VoI+vTB4xCF+ekXQw8DQqb8FOEHdaetHEyZnvPQ976pfj6dtVkrZWbRSFA+?=
 =?us-ascii?Q?qAP7zhzimg8OVdiZHo1pbiM4mThJJ9ZwtTXL9X+Fz2ziu/0+AC/WqbGAX31N?=
 =?us-ascii?Q?rwKSQ9OjaksZ63o4gp18BE3L3swj170BvC1HtSEsT3JJDJsWim55ulK003xo?=
 =?us-ascii?Q?wz9skT1+Nc9RrvkpT1c25tZtdDQVCdeuaoilfKcaTVEVYw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3yvBgg/bLGNOjHbMJU+5xIFUpp8fcjBM5QemlWwc5Pa3usot4wjbdhBqNS0x?=
 =?us-ascii?Q?5SAGVkH2dBbvgIzS4GoVj/Ray+NDpo6epuDukp4YQACnfKYv9v5zE4WkVyvI?=
 =?us-ascii?Q?D6HlTBGFpe2MztfRYLlB2FB+FyyroMa3NmHfDs7vxRwOUNWHzZMoCtzoGFBt?=
 =?us-ascii?Q?tipHY9XtrgdM8BB2t1XaP00HIhZohhhcahEs4IsTnWhy+NXG7RMrrVj0XaEb?=
 =?us-ascii?Q?kbsYD89ThUXoDPbDlXM8/EVnx9lwCA8+Y+68an7XjWVvwocSmwHgcwBc9dJK?=
 =?us-ascii?Q?HzV9iXYEp1zkC5RZ9ocAmznpg3e8+6IK+ljp4yN7gp7bM1x8+SJU0nWSniAU?=
 =?us-ascii?Q?cwVFImm0LHYflpfMn5tXrIdehQQrsZnBP3cm4C/nwfK00gUxz2z5dGVp/lsa?=
 =?us-ascii?Q?fNjsmjmwZKXU/3lbd91uVEDmtbtDfN539fnPlEWr45BlqUfz61mqalRxLsNN?=
 =?us-ascii?Q?u0f+RTgm0L8tK5suN6G8lprzP/xcuqL285vw1XPAm9yLOBFX91TBVE3x9KZa?=
 =?us-ascii?Q?u9ur89mNiup1ymq8vSJJLfeAL0ePZ24uSQRmaF/xwghkeYEnvaAKj4lNt4dr?=
 =?us-ascii?Q?6o4LBbn4nLpJ9PvXks/2ORtsMAy3rNxnevAf0LxnNzWLL7OEJy5dkJoYZfiZ?=
 =?us-ascii?Q?DacdsX9FtDUwO4aIFNqxvDaoVB558cl0LhfMXMENOBncalUq5vfXl5gS36AB?=
 =?us-ascii?Q?qsAUsURwTNYNSDlwuUO8/gzielw/FGWlAP9IA2UtYNzgdx42Ii9InhMjVJ3D?=
 =?us-ascii?Q?NliRhXQj4UunLZj3zFfCYjA43qhRsV8Yy3CoAXw0giAU06qws+Fhq0uFh49c?=
 =?us-ascii?Q?ghGlj2BPjnJGn7yaiEMZZ6ah9W/xXdQRcDye0wf9jXg7CfQ2/jjfJPSrLW3n?=
 =?us-ascii?Q?oS3ej5f1JuRYyVX/4QLCsz5KVDpGlDzQmIx3U24RhrsBJazfStsbi2jHshPW?=
 =?us-ascii?Q?coy9QRUCbb/7qj7p/URlAi5k3RAB+x4claFkKRmc7uM8U5pgbQ7i72FwzrAh?=
 =?us-ascii?Q?gnHNv2baEgN8FqGRLpy+OltjxZp+MtcnOHxroIl29f6WfL571WCudyBM8l/K?=
 =?us-ascii?Q?d9/GKv6IrCS6crpJa3gO1J3kxK75HlHij/p/qj6tt0P7W2BkToVnSAlM6PCA?=
 =?us-ascii?Q?d6i4CVRp3usDCdfkCaYIhR2RIgYFgwjtNWMxbp7EswTkkjq8rREd4a+2d428?=
 =?us-ascii?Q?yx8hlBHoEPVY5aN2Gl9YX8WDR83GBHgx7mNb985M3U0ywIh9h0RTdpWP6Id0?=
 =?us-ascii?Q?6za+c13dlJi0taj/JvpuJ82L20TVlTt6Dr6EDlhVixcNoI1tywf6/zAWrK1d?=
 =?us-ascii?Q?7necKDfGXiOYdOBAz/zZeiLF5c7CtwNDMMqFyq+jZSrrllhLBmTgUW6lfpqJ?=
 =?us-ascii?Q?ZEjvAix2DV6UM0YPRuxy7xn9WZjix/zu3S385j71xLjuFi4d2GnywUwfMQpa?=
 =?us-ascii?Q?BRrBLRHpVi20I3E6uH9oed81vs8WNUYgKa7fU5IocFdrBm1LmUgDvoC+eEn0?=
 =?us-ascii?Q?oogDkEfWtFIG1vbUgRYUqxS4EF4o5/DkDk2w00yGkX9kpnPNLGhGJ/h/w3sL?=
 =?us-ascii?Q?hXm3xcwG0MRy3XRjwGWTR5PIxBZdP63JNZUXFDit?=
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
	lE6Il9FSmkOFttkRS+cWi2Pzs5AwDwtNEiSgYtiac4YjnGz02MxuZD818/GCvnZI3JLlQGZU4rrODJxIEMy5u6S+eOuaiHR2Acic01ePAar6QiB3o6xfaiHURPSDh79ENChyHx8KxHzDG96Hqm6HZUFSrGxb3GljCJyLx/zErwu0b2SNEMijdfvUAfym5W+01pHfUFuAn+UVFj9zWJZK3jQ0aej2BJDY8KUIwZq8hBhmmLLWXpFlc7pnXSZvz6EXvP6kzvb+8aUb3PZc2tka0br6sUh4HOXBYWNVyEdN15aedy/rWL9Fd2SkFjNKnk2Q5gHzYtnTfgDszQzsRhqmSPWuNcl39fSTow8/5Nck0q4gvqexO4MPSlRH5AV2bVsQ7Flhqq7VVuhKSqxtdxJTmkciiUCBtNH7B52P7EbDcRos0ZYAwTj9tCJHYMCL4OkGBPBloo69gxglEYjME5UkKsvH5yOOmlrHDuHcXQw5uQoBQHNkuhv9kaYxOgL8h+E5bzIYHh76iLO/PfvtO7+ld7c9NR0Lwot9xXxTE2nRIeebhpZuDpFN2Zn7GJRiapLohsmonfcUJl/HDDHHZhaxPxiq4ikf7/WZ6OMQBrc40xA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a898f06b-f848-484d-e28a-08dc7e33422f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 09:56:19.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcZfkjOJMMMKXJM00Y0l3BCRlDSK01ZzTHmRPhVXDsROsU/u1hGxqx3nrX3DmFuQ7PHyrpx3hGXTWjCeY/iN4ennhG25CO9h3HufAZvfXvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405270081
X-Proofpoint-ORIG-GUID: KY1xKobOvx0sFZwpixJvTzFhQcCi5xEX
X-Proofpoint-GUID: KY1xKobOvx0sFZwpixJvTzFhQcCi5xEX

Hi,

> -----Original Message-----
> From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Thursday, May 23, 2024 4:45 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> axboe@kernel.dk; chaitanyak@nvidia.com; hch@lst.de
> Subject: Re: [PATCH 2/2] loop: Test to detect a race condition between lo=
op
> detach and open
>=20
> On May 21, 2024 / 22:42, Gulam Mohamed wrote:
> > When one process opens a loop device partition and another process
> > detaches it, there will be a race condition due to which stale loop
> > partitions are created causing IO errors. This test will detect the
> > race
>=20
> Hello Gulam, thanks for the patch. I ran the new test case on my system a=
nd
> observed it failed. It looks working as expected.
>=20
> This is the patch not for Linux kernel but for blktests, then it's the be=
tter to
> separate it out. I suggest to add the subject title prefix "[PATCH blktes=
ts]"
> to this patch so that reviewers can tell the target repository easily.
>=20
Done. Changed the subject line prefix to "[PATCH blktests]"
=20
> I suggest to take a look in the "new" script. It has some guides for blkt=
ests,
> such as "Indent with tabs" or the global variable "TMPDIR". Also, please =
run
> "make check" which runs shellcheck.
>=20
>   $ make check
>   shellcheck -x -e SC2119 -f gcc check common/* \
>           tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
>   tests/loop/010:23:17: note: Instead of '[ 1 ]', use 'true'. [SC2161]
>   tests/loop/010:32:17: note: Instead of '[ 1 ]', use 'true'. [SC2161]
>   tests/loop/010:84:7: note: Double quote to prevent globbing and word
> splitting. [SC2086]
>   make: *** [Makefile:21: check] Error 1
>=20
> Please address the shellcheck warnings above. It will help us to keep scr=
ipt
> quality at some level.
Done. Resolved the warnings
>=20
> >
> > Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> > ---
> >  tests/loop/010     | 90
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/loop/010.out |  2 ++
> >  2 files changed, 92 insertions(+)
> >  create mode 100755 tests/loop/010
> >  create mode 100644 tests/loop/010.out
> >
> > diff --git a/tests/loop/010 b/tests/loop/010 new file mode 100755
> > index 000000000000..ea93a120d51a
> > --- /dev/null
> > +++ b/tests/loop/010
> > @@ -0,0 +1,90 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2024, Oracle and/or its affiliates.
> > +#
> > +# Test to detect a race between loop detach and loop open which
> > +creates # stale loop partitions when one process opens the loop
> > +partition and # another process detaches the loop device # .
> > +tests/loop/rc DESCRIPTION=3D"check stale loop partition"
> > +TIMED=3D1
> > +
> > +requires() {
> > +        _have_program parted
> > +        _have_program mkfs.xfs
> > +}
> > +
> > +image_file=3D"/tmp/loopImg"
>=20
> $TMPDIR is recommended instead of /tmp. $TMPDIR is cleaned up after test
> run.
Done. Using $TMPDIR now.
>=20
> > +line1=3D"partition scan of loop0 failed (rc=3D-16)"
> > +
> > +function create_loop()
>=20
> Nit: the "function" keyword is not used in blktests (there is one excepti=
on
> though).
>=20
Done. Removed the keyword "function" now
> > +{
> > +        while [ 1 ]
> > +        do
> > +                loop_device=3D"$(losetup -P -f --show "${image_file}")=
"
> > +                blkid /dev/loop0p1 >> /dev/null 2>&1
> > +        done
> > +}
> > +
> > +function detach_loop()
> > +{
> > +        while [ 1 ]
> > +        do
> > +                if [ -e /dev/loop0 ]; then
> > +                        losetup -d /dev/loop0 > /dev/null 2>&1
> > +                fi
> > +        done
> > +}
> > +
> > +test() {
> > +	echo "Running ${TEST_NAME}"
> > +	local failure=3D"/tmp/failure"
>=20
> Nit: some local variables are declared with "local" keyword, and some oth=
er
> are not.
Done. Using the "local" keyword for all local variables now
>=20
> > +	touch $failure
> > +	echo 0 > $failure
>=20
> Why the file is required to keep the fail/pass status? Just a bash variab=
le looks
> enough.
In the beginning I tried with a bash variable but it was not working as the=
 variable need to be accessed by other two child threads also.
>=20
> > +	dmesg -c > /dev/null 2>&1
>=20
> This kernel ring buffer clear will likely affect test harnesses which run=
 blktests.
> To check the kernel message generated during each test case run, please u=
se
> _dmesg_since_test_start(): ref nbd/004, nvme/003.
Done. Used the above function
>=20
> > +
> > +	truncate -s 2G "${image_file}"
>=20
> Other test cases in loop group have 1G file size. Is 2G required for this=
 test?
> If not, 1G size would be the better to reduce disk shortage risk.
>=20
Using 1G is not an issue. Done
> > +	parted -a none -s "${image_file}" mklabel gpt
> > +	loop_device=3D"$(losetup -P -f --show "${image_file}")"
> > +	parted -a none -s "${loop_device}" mkpart primary 64s 109051s
> > +
> > +	udevadm settle
> > +        if [ ! -e "${loop_device}" ]; then
> > +		return 1
> > +        fi
> > +
> > +        mkfs.xfs -f "${loop_device}p1" > /dev/null 2>&1
> > +
> > +        losetup -d "${loop_device}" >  /dev/null 2>&1
> > +
> > +        create_loop &
> > +	create_pid=3D$!
> > +        detach_loop &
> > +	detach_pid=3D$!
> > +
> > +	sleep "${TIMEOUT:-180}"
>=20
> The default 180 seconds sounds a bit long. How about 30 seconds?
Using 180 seconds is just to give more time to reproduce the issue as 30 se=
conds may not be sufficient for the race condition to occur

Will send the version 2 as soon as possible, with all these changes
>=20
> > +        {
> > +                kill -9 $create_pid
> > +		kill -9 $detach_pid
> > +                wait
> > +                sleep 1
> > +        } 2>/dev/null
> > +
> > +        losetup -D > /dev/null 2>&1
> > +        dmesg  | while IFS=3D read -r line2
> > +	do
> > +        	match=3D$(echo "$line2" | grep -o "$line1")
> > +                if [ "$line1" =3D=3D "$match" ]; then
> > +			echo 1 > "/tmp/failure"
> > +			break
> > +                fi
> > +        done
> > +	failed=3D$(cat $failure)
> > +	if [ $failed -eq 0 ]; then
> > +		echo "Test complete"
> > +	else
> > +		echo "Test failed"
> > +	fi
> > +	rm -f $failure
> > +}
> > diff --git a/tests/loop/010.out b/tests/loop/010.out new file mode
> > 100644 index 000000000000..64a6aee00b8a
> > --- /dev/null
> > +++ b/tests/loop/010.out
> > @@ -0,0 +1,2 @@
> > +Running loop/010
> > +Test complete
> > --
> > 2.39.3
> >
