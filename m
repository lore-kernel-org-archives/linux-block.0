Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54489139CE2;
	Thu, 13 Jun 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313066; cv=fail; b=M+Mxe9vBGIQr1kCqXqVU6pKK7ST+dkOsNHundbZINni9O0WK9QF8Hf/wq+y9XAU9NmhfCzWky1cWR7FS1oSCNf9h+9kNDrYlAvdfDXx6GA9Uf1SetQjs1Z8w8ClEo/X7uFL76nhlF2JHULAfc49vOAaN8m9fiE6iEPe3YoWxoUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313066; c=relaxed/simple;
	bh=x6nATQrgIRI6UkqrKcGUQy5UVn6901RFuB1U9mJp6W8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+nQpyhFSsf0s+TwkwMqBlGMga3fSgX7TY9qWarShMVjwNpvZ83+SfuT90/tjBi8put9qKXJbZLKZ/Z37nLqKLQ96ConY8COORFaGJ1hwqIIyHBw1rurqOa3C6huo5p2U6BR0atebQnQtYTjlNukv8TpqQLbvQYDj1L9hOHNDTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M5EkXQv9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IhDfjRjo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M5EkXQv9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IhDfjRjo"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtPC3000859;
	Thu, 13 Jun 2024 21:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=3/0qYq5IzhzXarWdPi9a/5bQQrGstGGMONkQqhU4Na4=; b=
	M5EkXQv9z+cvW/9FZfV7gpEmxbPpjcaMkUddaZyiny0S9i0jDP7EPyWsgbsYauiA
	YrshbfGqnASmkRnLtTfrTSAyr6slSMJDiUeDMu12vvIJ6n5uEyzFeJ/3irbDxDy3
	HK41tkfMLVZHQSvB/qeOaijKqQCAm+fsq1Z6ZmtBjyOi85kif+r207AYgBNzoKSl
	A0266S6KiTFlTmJewFN5uB6lvD/Rt+iJs50trBL9FnM3QcECM3X273AYUiussbuU
	YWVUG4XaUmIwtzsn71vlEYphpSIXbj7kgJJQIT2FcLTnzxXEQ5fvcY/vJ3Hmuu4n
	9aZ4rIiPBToZinwsQ2thrQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhajah54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 21:10:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DKLAqo020108;
	Thu, 13 Jun 2024 21:10:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync91rdkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 21:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfwEXc3TRwdZZuVN9vibwMHoWw3hROpepbk8k/yeyFnKNqhF24fBEUY9Fxhz3YZ629fqTcO7DSXGRJYdRCWND0RDtmZ3+OkQ9lP3yyqPqCW1ah3A7XBFpacto9FTlIMJkLrheF6A8CRNbx7ERaoTglpAY6G+u3JnpIrxc9eC6OAf6XtbXzJNjLfNM9Knzp/EQuHXgWF+4UunBJjOfR6YdXjyYLLKmM/phzuN+zSQRm2LHR3l89dg3A35C/KMGtphbwi3K8Md+WYavO2KPuWeKQMAVZAO6ouIvDvnmRhjT5r8BsM8/qMHfdf1LixtfYrHmExOrtbfSBi4h2jDKD5RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/0qYq5IzhzXarWdPi9a/5bQQrGstGGMONkQqhU4Na4=;
 b=Zwlj5ccYjWfZ5+Zu0TVTnl4G4Yv8FIUFsMLFDpbTZ7RdY9Ey8Lnks8voLGAhOGISJif7kKbPVmth2Qmcuw3xbq0zHcUcRE8n/4wnBz8RXwWUb2Y8HcmNyytAW23/lFR0tPEI8AbyMXfvcFmPz3D7RS2pCXqFLacjBwe4p5MeFoG0SizecVDvAWgFmmkhfCCNgexUx3bswpkRbOCwdYJb3rn/TYQoBt4DZPU3JkfO3GwMpIvIwn8oUOVO1pArh6gZc8QtSc9OI4BFtk3wWMMAosK5CfBgQnXtuICCQIKxe4BtLgcV5Sf5QoS8hPvYQWOJ92uETQNu2ungXfiMBdC99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/0qYq5IzhzXarWdPi9a/5bQQrGstGGMONkQqhU4Na4=;
 b=IhDfjRjoIq307+HJ8Me8IOBMPS/k2Hbm5kgOPVcHarKbgFPtmtnkoxE0NroGxcoGuvQhHcrNUKtIg+8PUrgsdPsIJl1LcyethovDmWGwxtObVEGeOA9kJrgdNrYKWUQ9tnaNEexDmY5eyA6ZiCP4myaaHBTmcBn3n1EtItnZhdQ=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 21:10:37 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 21:10:37 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com"
	<lkp@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHavA/KpPG1Y2G/i0Skj77IBfr3QrHGM6eQ
Date: Thu, 13 Jun 2024 21:10:37 +0000
Message-ID: 
 <IA1PR10MB7240B2686664744DB0D8867F98C12@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
 <202406112130.a572f72-oliver.sang@intel.com>
In-Reply-To: <202406112130.a572f72-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DM6PR10MB4252:EE_
x-ms-office365-filtering-correlation-id: 9a8744f7-3c72-4892-c9fc-08dc8bed45be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?LzmuFoH/atcERmgAo/lBdN+vYkcE2IHXnDGgfHz2wJtFci9QGX9Jmtd+1GtC?=
 =?us-ascii?Q?P7MeqkFEi3lq1OxAERrhui9f0GtJaFghdjGk/vAiI6b7kmGP0DYc8ACangLQ?=
 =?us-ascii?Q?KdDl1SO09a705Lm3dI8tG6wpFv/86rmBDL2Zm4kpWHiGEdsDmpHBgub+sJ4E?=
 =?us-ascii?Q?WJttFjbkYrvUDnQrlxLwdP3jB9KZO1wEyDlz/q6jQU7CMaeEJsZ4oL4GFF2v?=
 =?us-ascii?Q?5QZSJgowtsVmOdWMTOH2cs/WE3Cx6vxYyqas8BRxYVD5kweSJ77cJDH91QMX?=
 =?us-ascii?Q?tMh+K/juq4OKQ7ERRg+D/f+IGTo9xxApKGBPlnenWbsh83ZN3evimNyBRff+?=
 =?us-ascii?Q?T0TDIWrK0snAEL07z1sWKhJP5xzxI1vIJMXhFaROKWtRBCg3lxyD3p/oCCpE?=
 =?us-ascii?Q?ZrWsqmu60c6dbCWBF1O5McSSpnYGYgBwPKwvyoAL8u17MNXC1Ga2LW7Lm9N5?=
 =?us-ascii?Q?zJnGakk4cAfMEDOSSYLRsOd5LxaCjtRFPyQLumGMSt7OzU+nHHI2NbdLjIjL?=
 =?us-ascii?Q?H+ZjQ09iwKEDg3bUxc13iCEs9L71a/gArgUS9CUm4avIwOZi9lnUzF8GtxIZ?=
 =?us-ascii?Q?/6IR/vfV7g/1h2GiHQLtOuRf+iCpg+lVF4MRe7B5oKSSA4nBnL/lvholWIyN?=
 =?us-ascii?Q?K/LVKP+SWHNsR3Qk8jWdXGI6fhDiJ+UP7f4xy7PDAQPnD0EemnBxBQ1M2RvX?=
 =?us-ascii?Q?EBwd8AxzJmhUiZDCjp+N5MRSDcyJcfqGUFJsdSPXjOezi9FfrXgiP5mQaftn?=
 =?us-ascii?Q?rkijPcMQi6J19RLoIMJktUA3K6FMvKx4QFEXFHyLeg4c/F23R02ArzvXRv54?=
 =?us-ascii?Q?cwZulUsXJ6ztn0zQYkNHfQsGuWNVBEe5yjYQBzL1DdXY1/gxKBubRkFj8Mlz?=
 =?us-ascii?Q?bNtmzJmiCjzvRFMnMvVDjbZX0KE7Q6JnTZfuZPtO9HVFq959A5pLgOaq/gtX?=
 =?us-ascii?Q?NPV5x3S4wnxOZaNH9xAVFi3CGel07UIOiEr+3J+vLzPvKGAJrMUpba1crqdb?=
 =?us-ascii?Q?WPAvWHkz9VwbD2vSixtHofQNSO+or+gcojDNE9ArUhTaTOcdrzH6EBEAP4OB?=
 =?us-ascii?Q?p0PWaazhxDosrTbuV8eEx6NzP/RrXRRVT9JayG9f6gLc96wOEY0cT9JhrC7u?=
 =?us-ascii?Q?e6HDFoWsx3szVEB/yuzikGa3lNl6/D7pTlziqafaZH+85B7EwWe+zEg+NhLI?=
 =?us-ascii?Q?/MWRjJ5ySGrn0mg3zGjQcSkzB4x/Rsdqw7ga2mvz3pkOeoWWMK1joP6W6Phs?=
 =?us-ascii?Q?3YZRn39qkgZMzL7YqlehPFuCmZGblMdsXUDX+es+nc9899MdDDoIu7wjPnCI?=
 =?us-ascii?Q?MXmedDfCiGpHpb1tKIEwVPm6?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?02GCP7ej83klGakkNVjWXPqxFMIf1WK/xHpPE6VB2xPRnlmLKJFB4j/RK2u+?=
 =?us-ascii?Q?v3EcsN4VmjRVCNPdqhPUIfWM3hiNYdywgqUI4J1HeDbms3zACYiguWmv2GiM?=
 =?us-ascii?Q?fBFgK6ZeuIsYoS457QCYbZkyP1svGZ4K3v0VYaDU5C567V+/WwssoX6DvKPh?=
 =?us-ascii?Q?YfEQes/Kw9ahI4jKoe1Qtpo44BOHyEZlVBfZ0GUoaZ/G/4n4oGDPUNFYbD3o?=
 =?us-ascii?Q?rVcaqiP9kVazFc5NZzM1XvYMB8tvydb1hHyjfy3wfYPG73EgtkktsiQ637tc?=
 =?us-ascii?Q?TIqmO8KhFyYHs4NzVlcP6H6yTfvd/WPEiXIIK3hxqKt3BWmi2FDFDNl4zIfM?=
 =?us-ascii?Q?3JZawnFKNjQsbQYFMmZkRVEl29bBwcsb2C/jaR5FODFjhqLx+qLECdGHAxyV?=
 =?us-ascii?Q?a/5pq965zPUha0w0hGQiZ1X5f6MRWr0+ILACldEPyq4cY4DVPGJ7clRdfL9C?=
 =?us-ascii?Q?kepcalvsAMce58S2CnqLoxtpysi6OdVSb+A5RW7JnVurA05EOVfsYRE5X2of?=
 =?us-ascii?Q?Rb3YpZvFQY8KR/nEsh2nwWTAM2bPbCvFD/TsqneVTZBLh4HJXxt0QaFQKTE6?=
 =?us-ascii?Q?DM5x+fXfDbVQmEizNN9CgYW4BPWOh+1zbguLWh4BQdeMlJoxTNSWJH+74B7J?=
 =?us-ascii?Q?b7PZzc1Hj/kVE1ymzGoCkQfgYpe2js8yC1v8q7zTZphF/bmoTHhK424fYthg?=
 =?us-ascii?Q?NeX7HbW+EmP5vcFg7rQrsgkj9IYmXi9AmCF1LOlNWeMROeDQgAuTwiCk9m2m?=
 =?us-ascii?Q?ZU6qaDtl1LyKPDPA63aqOuWNGKtL2Yz0vIFmiuQHLatKhYAu2LCZw6IlWlc4?=
 =?us-ascii?Q?uLe26G0y6WLT6JirVvidwbPrjipISD2wF3AeHXgUaH6VmcN9zIwCgihhLwRt?=
 =?us-ascii?Q?p2mnafcSEesmjHlhDnBiFid7iK0KbfbZXBl2TvUPkxC6IR637Wh+UVkq5ZNK?=
 =?us-ascii?Q?3vjNYR+T8aO0c5oUSroWBeaPKxelIZlLZv+UTVCYv8tCzPlTohrwpn5iHQxq?=
 =?us-ascii?Q?3IpR9kSBJqiIhjQwzSeUFfluHnSAIa9hn+2LuDNDomaMKkGRlz1aQ0Y3k3cL?=
 =?us-ascii?Q?c/dxQfBtZXG1I+f4ploJ/feU7TOGdtZsza2obsUo6/RQ9XFtk9HVJ1BQQH62?=
 =?us-ascii?Q?paEIgooT5rSmpiZXgwZ6Pc+E86VFR7hmy12OfLmoqRs5Z8W5YcbHb/GvpJR5?=
 =?us-ascii?Q?yMym8I99mFdmXnqNXTXa7Q7I1djAaOJquuxYXtLtpJxkNFLMP0MjJ7OpFzEq?=
 =?us-ascii?Q?hKmDkL0/DCeSRweYtpj+BjEGuIOJXbyqCDeiDpptIlOusdFlGohOCzkZbX/v?=
 =?us-ascii?Q?EKyQXe/X/Nuc5a1/ZZJiQbeNkkY2izdDW7eeHkTJRzRqM7hqCnDZRER4eqH2?=
 =?us-ascii?Q?M7N7yeCYWohTpo1PAGMNj7WW7emyF+t8Ryp38mzyKZc4oVefWgpRrnUyBuJU?=
 =?us-ascii?Q?ZV+WzY7Lz73vtgaO9HbbVyXjfJd1NMZpfNj5LKpA+9r8cy8oECPpqx7/PL1D?=
 =?us-ascii?Q?9AUWUtjPB+rzbTnACDdsl6EU4clooRfPeqYZIYqmKvWLvH3kTCS/qdAsyEoI?=
 =?us-ascii?Q?64s38C2s9xYaqNE3NCe75oAWdYMOC18esWub7CpD?=
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
	8a4Lum8kSchhR/+oS/zNeruKl8IZzG0Zo2hqEQvmT6hxAv3UAvOEpOvxhByjUvmbJNFvqY8Hp8S+UEg7+a/p2zESTzja3IPYD0bJwSZLrwIUaNbDHBHQ4szuH58Yno1xOxPOYNMGkSDYm/9K2ZPLFhZ+qvn+zucV0TK4bcJbAfhhq7qLdWmj0YD+t2lMW6ikq/H9XoXES+YG6En2sneVr11VobfbKspZ0nsUzsyC0rwWkpg6zz27/V88x/TOK3DL2fHno5XGFUmMi/cfs9sYkBwSSQOKzmraasEzEJC4m7zgbwdrzU/Mwco4e9a1VVCv0HyaLFWJZdWB0tdqeJyFszSAz3SmuqALcQMHoM+E0kCIDpG7PYmv84Pt8eLkcqiVZydNxjs5xG4NsjV7GIoG4CfDLwacUY2NwC9Bn3haGk1cAcpStTn9Ce5exlQcqAyfoZ9Z8x9ej35vfoCYTJ7hA0lO4sK64OF3mammFbjGj5XKnOdwxgaweudjK0H3RTJ722G9lRKk4u6xzQKDwOx1BNxyC8JgCAAZ5Eqx3qtBDm8vojYbc0PWNGLQuvuHiIMIxrLETaRZf2TLiix48UQjMGUBM/6hcudReR+Bm5LMijs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8744f7-3c72-4892-c9fc-08dc8bed45be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 21:10:37.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1M35BwPOlscwsymOuVZVXBfh5R0vG5HaFrPQegjV2JAjSJcEVXvd2LjaPQ7IBMYt6gYXcJP3kDo2bcFT570YYNn5u2zf8t1QZb8NLtSEmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130152
X-Proofpoint-GUID: hrhVMdZAcXN6CU5eW79s0LTUN_fH6GKw
X-Proofpoint-ORIG-GUID: hrhVMdZAcXN6CU5eW79s0LTUN_fH6GKw

Hi,

> -----Original Message-----
> From: kernel test robot <oliver.sang@intel.com>
> Sent: Tuesday, June 11, 2024 8:28 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: oe-lkp@lists.linux.dev; lkp@intel.com; linux-block@vger.kernel.org;
> ltp@lists.linux.it; linux-kernel@vger.kernel.org; yukuai1@huaweicloud.com=
;
> hch@lst.de; axboe@kernel.dk; oliver.sang@intel.com
> Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "ltp.ioctl09.fail" on:
>=20
> commit: 02ab74c165fb204557fe6cde80eda0633fbc4412 ("[PATCH V4 for-
> 6.10/block] loop: Fix a race between loop detach and loop open")
> url: https://urldefense.com/v3/__https://github.com/intel-lab-
> lkp/linux/commits/Gulam-Mohamed/loop-Fix-a-race-between-loop-detach-
> and-loop-open/20240608-
> 031123__;!!ACWV5N9M2RV99hQ!Niww5tWxpW_rqqBaG_-
> w8CbDvJjcC6AwSb4gYZL3tS7fUrBcYesefSCbVL8GrWLJ0R8W_jyMsgUDi0HVVA
> _7Fk4$
> base:
> https://urldefense.com/v3/__https://git.kernel.org/cgit/linux/kernel/git/=
axboe
> /linux-block.git__;!!ACWV5N9M2RV99hQ!Niww5tWxpW_rqqBaG_-
> w8CbDvJjcC6AwSb4gYZL3tS7fUrBcYesefSCbVL8GrWLJ0R8W_jyMsgUDi0HVSM
> 8EomQ$  for-next patch link:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20240607190607.17=
7
> 05-1-
> gulam.mohamed@oracle.com/__;!!ACWV5N9M2RV99hQ!Niww5tWxpW_rqq
> BaG_-
> w8CbDvJjcC6AwSb4gYZL3tS7fUrBcYesefSCbVL8GrWLJ0R8W_jyMsgUDi0HVEcY
> Yz3s$
> patch subject: [PATCH V4 for-6.10/block] loop: Fix a race between loop de=
tach
> and loop open
>=20
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240608
> with following parameters:
>=20
> 	disk: 1HDD
> 	fs: ext4
> 	test: syscalls-03/ioctl09
>=20
>=20
>=20
> compiler: gcc-13
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
> (Ivy Bridge) with 8G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes:
> | https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/20240611213
> | 0.a572f72-
> oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!Niww5tWxpW_rqqBaG_
> | -
> w8CbDvJjcC6AwSb4gYZL3tS7fUrBcYesefSCbVL8GrWLJ0R8W_jyMsgUDi0HVDgL
> 6MVc$
>=20
>=20
> Running tests.......
> <<<test_start>>>
> tag=3Dioctl09 stime=3D1717978971
> cmdline=3D"ioctl09"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> tst_test.c:1734: TINFO: LTP version: 20240524-32-ge2c52c5bb
> tst_test.c:1618: TINFO: Timeout per run is 0h 02m 30s
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> ioctl09.c:48: TPASS: access /sys/block/loop0/loop0p1 succeeds
> ioctl09.c:56: TPASS: access /dev/loop0p1 succeeds
> ioctl09.c:51: TPASS: access /sys/block/loop0/loop0p2 fails
> ioctl09.c:59: TPASS: access /dev/loop0p2 fails
> ioctl09.c:48: TPASS: access /sys/block/loop0/loop0p1 succeeds
> ioctl09.c:56: TPASS: access /dev/loop0p1 succeeds
> ioctl09.c:48: TPASS: access /sys/block/loop0/loop0p2 succeeds
> ioctl09.c:56: TPASS: access /dev/loop0p2 succeeds
> tst_device.c:263: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for
> too long
>=20
> Summary:
> passed   8
> failed   0
> broken   0
> skipped  0
> warnings 1
> incrementing stop
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D3 termination_type=3Dexited termination_id=3D4 corefile=3Dno
> cutime=3D3 cstime=3D42
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20240524-32-ge2c52c5bb
>=20
>=20
> ###############################################################
>=20
>             Done executing testcases.
>             LTP Version:  20240524-32-ge2c52c5bb
>=20
> ###############################################################
>=20
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://urldefense.com/v3/__https://download.01.org/0day-
> ci/archive/20240611/202406112130.a572f72-
> oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!Niww5tWxpW_rqqBaG_-
> w8CbDvJjcC6AwSb4gYZL3tS7fUrBcYesefSCbVL8GrWLJ0R8W_jyMsgUDi0HVsf4L
> rkk$
>=20
>=20
>=20
> --
> 0-DAY CI Kernel Test Service
> https://urldefense.com/v3/__https://github.com/intel/lkp-
> tests/wiki__;!!ACWV5N9M2RV99hQ!Niww5tWxpW_rqqBaG_-
> w8CbDvJjcC6AwSb4gYZL3tS7fUrBcYesefSCbVL8GrWLJ0R8W_jyMsgUDi0HVQRs
> yTxc$

I looked at the LTP test case failure and also the function tst_detach_devi=
ce_by_fd() which failed. Our kernel patch will defer all the attempts to de=
tach a loop device to the last close, to fix an issue.
The tst_detach_device_by_fd() in LTP test case will open the loop device an=
d repeatedly checks for error code ENXIO. As the new approach, as I mention=
ed above, will defer the detach to last close and the last close happens *o=
nly* when the LTP test function tst_detach_device_by_fd() returns, the test=
 will obviously fail. So, Can you please modify the LTP test case to accomm=
odate the new behaviour of kernel code for loop detach?
Please let us know your comments.

Regards,
Gulam Mohamed.
