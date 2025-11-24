Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69921A285
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001932; cv=fail; b=BmQ2oPdO4Jc+WPd+c6C0lUff9mVHMxXJwTdw8lvTUwT23UIix2N4OHbKPrJPnd+rSPrZXsDlvpI7HIg+63K4WyIesvtLO5jamNGSCtJT+QNcAf/DrH59NUwUCBKBiaZB/ohwvAB3laikU9P+p+wYhYFDXFSrbbJQAg4CIE+vlFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001932; c=relaxed/simple;
	bh=KgJXZ7zj7BBLnAMhqb7C3rBeHawPyn0osfXvZFpEFYU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=AhXjgPk3K9wImQlKRLHIkrHrdDF9AlJNP5VJVAXgC6y8AVxg3BpeTKrdTvcnDU09lbJ186rGUDuETWlzic5d3WwQXoElAxYuEmNGUajmLazZZ8IrtL8H+1TMNzsBBjZRuMvGjow0ZkL1J7i/MLXdd4eXbDNZ0HKcGPasOoY0C+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CfpkoQ0V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ODb+L85B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CfpkoQ0V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ODb+L85B"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVD8K1078620;
	Mon, 24 Nov 2025 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=a4qZDpas4DlGMUkHfh
	1rfLUmRHW5KOjAlNKp71NmHss=; b=CfpkoQ0VNjiMoWmhj8/NQGmC48yrnbpX3J
	o2sIqwviPDj6uxEJpMX8kz8gcq8Nq62+zrYXlLnMd+Hlva2IGoGvaW4LN561f/eY
	pbdjd6qiyXeqG59G7rJfbunRN3hbfrbQQuncup/9bZUS0fid4nRyVSG9nmjdVsSE
	as21UKeeGnwU7o8mnJw+DqD9k+geYqzB6RXnhwvp3MXRwcpPscRxzTYtzDiMoGE8
	V53ZVXfUVdlpTOnQUoQ2Oe6m9mSI3hc7lu4VKPAVyzn8n0DjocO2q4tGeXRjXm9p
	4Odj5YHNaky41wy3TgYa1iKXU6H984MVXqcecQOogOCzZjRNeo4A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddae04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 16:32:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOG3vZN018887;
	Mon, 24 Nov 2025 16:32:00 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8amfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 16:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VudM5p7/F0dUYpnp2TP4my63d3Kd0BMswLea/eJtzaL4pg2gm8eJdoXzLkvs2/XtN37Q8idVnMpyM42dIjoScWwngysIuMHArfX6lZM0zbOAVV1yKWgZJjDku3p1HyiNYCxvjn/X8EgSbF5w9CNedMcp3NSdaeytEET4IEDgZD4Wfqp/eLND0yDNo52s9tVzVmU/1OPngkW8DA/0yxKz5ChRLCFjKamEPH9v4TM+leBcYl5QNviePwFvmsozqEuZxg66TUY7jJ99Q1A2tPMeAnKfm86qJulPaxR1h5EiZkVko/QDZW1fTTtaWs7tuvhJQwyxmcRCto/epwvKig1g3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4qZDpas4DlGMUkHfh1rfLUmRHW5KOjAlNKp71NmHss=;
 b=RO8Hsyo/BTuNrwNWakNfrEwp4LQg9WKnTNFQi+Mb1xHcw4n4yuZC75imNZj4z+/BwFIJo4+lp9I9fld/Got2YqvXnU9GnnpX2ipvnWXdA1fUWaD2xh5QLSSZcPBYY/5K+7VDyloTlHigW1O9yb0hEP3Wn108n9AKh177j30kTMQls54mfB8FuldGijvLSCPJQFdJyHXLh2JYSth1shk1ZYIubaqRmEjYSRIu8Ao3oPVJV3gcQgBxoYEN8P+lC38+2g4ZbN/Uomsj4IWwA7Y+okOGd4rHRXJfySG5LlrcnE/R646KX7kF4erdIukQALGK0BwoCdgeseSjRJUBSzi29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4qZDpas4DlGMUkHfh1rfLUmRHW5KOjAlNKp71NmHss=;
 b=ODb+L85Bh0tDLn/mtJcLc5k3FQlMupdWUN+e/IAoWnhQrBlEqBVVoaVEDZ1jEbwRSBw3r4P7HUsbRzPg5a/cZ9EjsZHwrWAfK++XWNue2DyYLLRYPyUviRhfv2UhEiDviaiPUEN6Ju6N4Hj7duYlI/R+EtKVckJOZMiyt9JtiIM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:31:56 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:31:56 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251124161707.3491456-1-kbusch@meta.com> (Keith Busch's message
	of "Mon, 24 Nov 2025 08:17:07 -0800")
Organization: Oracle Corporation
Message-ID: <yq1o6or2y11.fsf@ca-mkp.ca.oracle.com>
References: <20251124161707.3491456-1-kbusch@meta.com>
Date: Mon, 24 Nov 2025 11:31:54 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 346a77d9-ac64-46f6-57e6-08de2b76fbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FbCt3eenyDHw7m/k0P7R1oGLhxtYHz8fnaZE5eqJF92NVJipJbpCgTWZtUB?=
 =?us-ascii?Q?1/jQ94JVnhFqDL94oVZuYeNIb4C1tk0/vuCdtzF8m9yIcjUptC7jShNR/J16?=
 =?us-ascii?Q?V8Ob64jN8GvEQHA17zNnlhpmuxJPAreiBOIOHGw8enQsgDxmixJx8k8j/8y4?=
 =?us-ascii?Q?qMlDBPQ+irlyZcjCcg3NkbflzCUGnf9fQYRRSFDwUUF7BDnN5QXU+Z8wwXbB?=
 =?us-ascii?Q?uIr12i0ZuFJ60lT88+0JK2EkHDivRllXPjio1zPCPY7RWpBs4btzbO82WRkS?=
 =?us-ascii?Q?TP4iHGycmi1giUPg8DoYOXvlfyvF4tnWfsXBWYzxFI4NRqDmc3Ungc5XZnZQ?=
 =?us-ascii?Q?VlsPZ+CDHGVFbf/ZBz2VRiMaTOQ/BQ1GGC+HC5x99Sf/MoZtBd+p+VzIGqQr?=
 =?us-ascii?Q?lyZnXD9O0Gq31qK7NcqW9M0NKp4YFqnrN1yZ53CvM0hJ5+q2k9jyReWFlYa8?=
 =?us-ascii?Q?Baok8VDl+Y7A1Ffm64U9OQ7O50QcCzNhd/y9QWPySxNaJD98+dgkntiFdpwk?=
 =?us-ascii?Q?IwAgQYNJ2bVIugH7bjR1eRAyr0ATeEZaLFq8KFsWMWCJB/YLBBwAu1NykQ8p?=
 =?us-ascii?Q?l67NaPfGpuqNXljWgim/CVJbdfh/DB8KfvnDViRw5aWMG7Eq0NWo6FyFHTD2?=
 =?us-ascii?Q?ZQixRbENn4xUZnG/YVJtuDfjqyIpPzE3MS40DVSum7wm4HXeDl6yFIw+nK0Q?=
 =?us-ascii?Q?hmMo1MAadjjMlTFaFUwk5izv/+YAAc5VWdEjg1c+6/ThEi4XiCR9Uai/tXTh?=
 =?us-ascii?Q?kgGODNiK1sQro1FCq4kyllx9o1z+puM5zzABDAIoAyK5zhEmNwEExAZfWKf3?=
 =?us-ascii?Q?cY89CJ4OOO0Fl89bHAAHIL51Oq4ejV6yKVxIfpHdsuT1VQmwkEAN8mSthhxH?=
 =?us-ascii?Q?JbpA9Cg6XeWVElWpvL5tDWmno2D2jLnWnmdNH6IccYnMf021tuTBXP1HCQDs?=
 =?us-ascii?Q?6ORgKS8Ay2BSUfwPF16A0sXn2YxF5bSDo0gFGWje/kolTHBZWtweUYY/nF2G?=
 =?us-ascii?Q?CY9HIXGel2z9D1dn8sTZ7uuAL9OV9zUU+DZ7a1glPYOo62mo9S5+InOuIOwW?=
 =?us-ascii?Q?C82wJaoSznb8XuWAoZRWT+OzVRUJt5CWKiWNcrF8bwM3xE/CgjT67kbcA1rs?=
 =?us-ascii?Q?/I3My8c0aLi7S/xlxnY3GgHa5zr96jzJV6hCQlvkk9T/eu4v/Z/e7Lnd8Rjm?=
 =?us-ascii?Q?LfUt4FWvESSPvOyfuCMHsOee0KDjc6HcoKhMyt9umj9HSVDekDOjcslDWuth?=
 =?us-ascii?Q?RG24NkI740913gcDkFzDMMO/Xowtl1nz4wuEoq+/6gpw4OmDJmm0DsM/l5hj?=
 =?us-ascii?Q?uXfrEXHSYGV1qdo1bTwOAdy0zMNfe7hu9+/bj4lgEyRW1EGBtkgvqzfy0Zth?=
 =?us-ascii?Q?Hw8VdTZdLizcgjcBmlTnq365snk4Kx5Cv+O+emL8cFVOzoZnq6AROCRsB4uk?=
 =?us-ascii?Q?xL51CarfjOQKGGXNneyyQc732waQEh6K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLwe0h92XZu6uhX27Kc1ZYuAFxOZWo9lWAtoqRy++KxD4L2pQTET91whj9FO?=
 =?us-ascii?Q?tqYmGynQ3Tvh4owLli2HxQ0LpU4tsq5lHyQuvcJ3T1/HZAcWkm8J/VUasT7L?=
 =?us-ascii?Q?pfyJTK62EyOxnh2C+AqUgZV5y57rTZZdl08JrvwwxgJBNtkp7SVy6F9st7O0?=
 =?us-ascii?Q?pDHmJNxvfKi3I2jXoQ4/poAW9WYIxFhBZ+vLSJv08WfYYAX9BktXECppwgxc?=
 =?us-ascii?Q?LDk9sLNDepyqDh1tVbBTVk40NZpJj7DCD1zVIxxGN0JOUKWtklsRu9Lu9dzu?=
 =?us-ascii?Q?bOHTdcG7tE1wJmKCqW8FkhwybyAnDwsJshIlZbmJe7VWR5hwRcJMMghmocEb?=
 =?us-ascii?Q?HUvXsohW7xrlbPosHDylya08tbbYyj6cnvAaBBiA6984mL0uuLJMTOr4YDyZ?=
 =?us-ascii?Q?XwPynKVxXw3QwYhI5DQWj+uKa/EIoqNXEvwtDgokQybsBAVPWEV7xWwhu+wB?=
 =?us-ascii?Q?kHfgT3Fz7aMFXlMIk6hZPvFeSyqR49mZECIr6ehYkBmjtXi6o0wdfAmxueSr?=
 =?us-ascii?Q?LcdCd6U1O/qrRWyvqmdayGdkdva1TsvHRAN3X2Zkx9EMLra76jy5eBSbIKUF?=
 =?us-ascii?Q?3ODN6Dk/mTznNDUFBhek33PqyXrQxyvrJzAD3+UObsbc4F3jWYVG8qsaOdww?=
 =?us-ascii?Q?o8YgerVQ66KPn3+k7SRzNpUC3AjJKXAtOGY/lrrJxTm6oyr1I39Gw3jrPag1?=
 =?us-ascii?Q?jqouFNNLQGjYAfCb99vWuwzKnrd7QWS4rKpCVS07tC5BqxSlMgqUeLH+APar?=
 =?us-ascii?Q?JSIqpkeHosapah7YYq0prsYqE5kit/4dm86YPAschVKCQKLa30WyDH3qYO0o?=
 =?us-ascii?Q?DdkYGT0dDcn4+3dTrSitmnvcfrENDsFOt6KrDc6FT28xOJJRGZIjCzkI6dmJ?=
 =?us-ascii?Q?BxBsxXioE7y1wVIRVZFNGIBjTi+pxdfTDAfa5g1NIQNGFBFozTV1eM3Rk3x1?=
 =?us-ascii?Q?LgYSltUs0aXnjpIR7sUZvlUUfmk2QJfaFnPZAUoM4HXBItpZ90cvh6J7STZp?=
 =?us-ascii?Q?fpIqH+ocdHGoP4eB+0SD9M9tSnaRIk0Qy0RuWcbUnEcMaQZKdK2I75jiVO3b?=
 =?us-ascii?Q?W0r6pU7+TKC3DxbrpBmkX/EK9bhYuO5+4ubti8LUID9FDvKQb0phoRtcehYm?=
 =?us-ascii?Q?wsdhLOyU1g/HxZaicpd0zop1HPOR5G5QSIS7epqRCHfOIEO09jdUv1Pj+rxE?=
 =?us-ascii?Q?c54+VKmAuyRgM4lyTH5XD/eloI5D5Jbt1OWqJOzPTNLAlK1EFM+4HY3m8C4y?=
 =?us-ascii?Q?AfEmLJpEqj7iE2vaRAzwqv4x7OfTg+NaOwZ4W3tw6AMbFo98Ukv4Wrmb3BBy?=
 =?us-ascii?Q?XGJhqri+sDk7hTYaC7vQkNAqEcR50HrEhShrUXFVZfQ6tZUZVdCPzugsyvzB?=
 =?us-ascii?Q?ZCoDR4BYtBSUlJWIJ3kouzBG0osm89rGo9DDJo4iBANvmOgRtG50UjtLU2tv?=
 =?us-ascii?Q?kJhw1gmK5UdKZ2VdlOsBM+Jk1ywL3PRy609i4Tmzimn2/E/HDA8BGrG6cEbh?=
 =?us-ascii?Q?b1hHMIfQOhuYEjCcGhy+c7KR7npD/Yrt0g/dsOlvCqoakPU6DB5Q5l5FtZs0?=
 =?us-ascii?Q?WIwswUmthVxxctrDLy7X2nbr6RjraBiJ4E54iqVYtiAc4RLVPDhGzpfqYKU1?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4h4fp4VPUOYcMa8RqcrxM1BtLzNU/8GrtsMdyYWa0KsyGpjsLfB1kqjM6Aa8jiHoWhI2Z93qiwsXD32PURaJACmvCVnFzx0orBBGDoYfS+NS+xm6MNP6rIZth8J7C93XTzNnLntccgB71lPCv0CTZtHLA+MtRC7Ms4qYoYJmwkgV2KVJi8JnsM0/6vwbuepqnuVO0e+IWSC1rl7S4XFdVf28UKWswoNo4Xa9ELa+VuQuGP2jGm11KYxyTEkG3jFDrMHikrNvmw773SNKFvVRuSIJnwlVXDWK6udY9X+ISTjYezQDSBJY6/aOO7qmpCWJWzp2kQKF28QhBxOWk1c0zOFQHPkM1ecqyFJoWU4FKujidZSiyRymkqPgTFA9kd5kXvV2fgJIqhWJBDe+0j88Vs9ny4cCd/Cda5+DF+oM60DVfHCJdwZMtDEs+jklpN0qBlCaD5VOcb0XcaIiA7tRiA1VEBVUZmO2wq3tb3biqGikxi8FpxZT7/WV03Hrh7bm+KDrlWtqsGXEjiwKYG2fd7AVkkkdq7vGBPNMzLwSMYaQDjEaSQLYa3eQnPseTxvhTNEgDGhtZuAXxk3hQzBRl2e4Hxa7jQYprbzCqzl1j/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346a77d9-ac64-46f6-57e6-08de2b76fbb4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:31:56.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDx54MJxJ9DGjwxuPbG/agUKTJuWmysN7r/rQPwXRuTUicySyKEQMtvPFGwAdor/d1bHZbvViLeyFv46IV6ervx+KQxIM0rpMglWq5gV3js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511240144
X-Proofpoint-GUID: RANbXjpQcB0FgzJNLfhPmlpQ-CDE0tUL
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=69248881 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=AlddjAPu-CppdjTIOvcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE0NSBTYWx0ZWRfX5W0nT//g7qwV
 uk0nrzpNhruVvlGU7p03Ze8W+k87o10Fd4LlfvldgecYz+qBFOMFFDeo+7OKohg7IxpOmXFWr8z
 CgTA4gHvqgH12bMBT1Z7PDlDdhVbJsinAQ6VE9OIfGTm58ojoPcPSzeDnnP7sqzjR/6TAZF0nXQ
 BDwGM/3LjZHQrlcLbeS3p56VxtmsLLFnAnv45WpFaPzo2qG+N980wtGMFwxjdDYuNcgWJ+EM7d9
 HbpIuHH3/YKUs4Ml3k6tPf1M/9FAiKclI90X9HLf6XO6v9CHFFL2w4Da6ZAxwkJ5ltx3dYPvgd5
 1D+ANqKkNGr2bylJ0cvdJrIQhCpeElWcHA3TRRX0W+MRUdeEctt9coiy+3b94LxofkjBN12dGdr
 ZS4KJU5PyPb7L0Cl5JWlY/pE2cExDQ==
X-Proofpoint-ORIG-GUID: RANbXjpQcB0FgzJNLfhPmlpQ-CDE0tUL


Keith,

> A bio segment may have partial interval block data with the rest
> continuing into the next segments because direct-io data payloads only
> need to aligned in memory to the device's DMA limits.

No objections from me if NVMe needs this.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
