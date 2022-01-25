Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 05:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiAYFuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 00:50:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236412AbiAYFsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 00:48:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P3RA0S005555;
        Tue, 25 Jan 2022 05:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HJIo/lLkgeM8lmhfteZWQSNx7hWI9yDLU1yU4vi3Hrs=;
 b=euIlaKGo6gxopNHj3kNRzj4477PoDpAx17p8Xz8WlI8ynDEoBAHoynzvAuYvHhwJjEQT
 MuWZMI5NoDm2WpNbmV2YVgKxF4NaJe1oXYbXw/oKFS7MTKyaws/aEftmUiGxKTgvG0Jy
 JR74nOGE4u7xxvNqLCeZ4+XqDn/upNNo1v8Day5NR26uS/DsfkfLPdutp9CRADmt2Nh4
 eFkWJzzNv1+l563BTFfjNP9srEE3LNEHApmYEYVAYLT6GFBOa7ksH1N1H8Yn0wyemb67
 3y6zQdDLHG2i8YkTGXsh5V0BIj0g6VElKR08hRGI1A05RkNbFB6pf56a+hjPAITOATPc 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9j886-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:47:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5kOb5162249;
        Tue, 25 Jan 2022 05:47:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3020.oracle.com with ESMTP id 3drbcn21b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5mm7wiqlJBeXOqmoC41o7dSMqqSwTzx0jyJGJ+Iv6uEdqEbgc2E+FLqRpjlZurP2vKij0kkSzHe1KG5oJzEj2/p3noFcYVldHjw/8sUeQsmXd85OCqr1mSorqiCGq2XPD5vkNxJ94NNCp5PLGHewG6afm93K/0Hav+Pp66DxFp3WaJaE1DykooS+n+2VMWOr9VvW6hN+yVy047dx9o/mS8Zx8IhogakZSREE7t27xHpPbEAlxzDhgnzhNevAq5+QCvH10YjdyzBrQtkf0v4Zgc547p75kpXHiJd9ltUPSCYgohYwNABnZKgj4sEQLrOg2eHFcaLNl/FSdwJpae+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJIo/lLkgeM8lmhfteZWQSNx7hWI9yDLU1yU4vi3Hrs=;
 b=fJCn+Sw4c0FfBjVYkONrE4joDx9N9FvkJT+HC0YrOVYUJJmvv9wLWPd2gq/u4wzZDeL39GcCdJjYTWQgycQ4IAKYbc0QD1hXu6FwF24w7mJraJI/36/7iw9wO42RPFYNvcUZFPZVOyxpk/QovDYlU7Rqa05oa1FSBJGQ1Zu7Iz7P90T2fbesrk8LpxBM+pFtAhXrsksZLUXR0tCsknD3V/UUWmE2/cZbmrIE3OylnoXHwrAbns76I0UATFmp1aIxjwaiSJj0Jj3KjDSKZ4Zh8qa5XOCP+aMkRQeU6guEQIF041q1XPDg1E0yGq/gy8AInU1lzfXIV6j/PcITVuY/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJIo/lLkgeM8lmhfteZWQSNx7hWI9yDLU1yU4vi3Hrs=;
 b=ukssf98JYPXt9qcs9AmL4Rq3tro2JJDojhGwrq7fOXyvlF5LmamJMpzlpXLNmShayQfdyr7m4r/BcIPtgpK8iKFLUVIsUhq0/cIchDItTSegfRcWGNb+Z4/wzYim/Jc+7FoZcgvTGLn1nDKF80N9Kt5OSHwcvFxnd4R3jL0gFxs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR1001MB2323.namprd10.prod.outlook.com (2603:10b6:405:33::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 05:47:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 05:47:54 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: remove <linux/genhd.h>
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y234fjy2.fsf@ca-mkp.ca.oracle.com>
References: <20220124093913.742411-1-hch@lst.de>
Date:   Tue, 25 Jan 2022 00:47:52 -0500
In-Reply-To: <20220124093913.742411-1-hch@lst.de> (Christoph Hellwig's message
        of "Mon, 24 Jan 2022 10:39:10 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0123.namprd02.prod.outlook.com
 (2603:10b6:208:35::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c67a51c-f5a2-41bc-594e-08d9dfc63b9b
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2323:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB23236004731C6F7458E93F4F8E5F9@BN6PR1001MB2323.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUSnML+nPzywBqgyLmvPPx8NvysQWZPI9SH3DhTRMfCLE37FjpiUX77Z6PfgjqGvE66brAteeLXm4lA9ZwJyg8M0I54idkApk5WXno2mL8t9QQRrN+LhYlMAZEYzXPdH9l8hvrQdlpJX+c1htlmoORIemFRZD1dW5C7Oal1gVoVBzwHA4LLzPFfpLTQp4Zq+anD1vpUlGu+txsqYdN60NLyK16vhlzADP1tQQ3jG6Qj5W+eHH4B5lAaIjni+1oZOc53K1rNaV7mZsf/SDPBv1LJOrw7IaLXl6EcT4Ynb91JrMnauBBLGg2L7t4dJwwdw9xPgFYAIyC9LS9heCeb/13jf9+aB/8JaTCs4CkbbvE9t0Bwr2MbW6NXfU/clttNf/Zg/4nHIdzEpMWgUC2YCRGHAFRvRhmr5hTx7GQtuW9Vincy7mItsZTwUhVqpMsRz+zfcWMlYZUNYZ2LYSPkBD1ju7Oj5PR50Sfmg3DCmhQch/+ZomwMSREdBkDPqBWaZ+zkyIKS5IORkDSMvdyAWCIo79RDIoTKfRHQm3oF7JDTgSp+Psf0D3XzFxHmyvhxLMHlupg6ACsC/Esj/avPDKr5B3NXREDuuTFnflOHJVI+VpoqEt9B6UeQbcDWFh41TXqF7fZUgJPc7+1WeROK4l3xokEKw1+gCxugxAPVPReN0isSgTj/2xwZCHmRmBdpt1AbHaC3SVGeSoVYw3H/njA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(508600001)(66946007)(66556008)(66476007)(4326008)(6486002)(26005)(316002)(186003)(2906002)(6506007)(4744005)(8936002)(86362001)(52116002)(5660300002)(36916002)(6512007)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XRdiF7UxCr/GRnKqDIDJ9gsvCyKeVQZvX3fPa3ClmMzXRYa2ktYsx+MPjh+?=
 =?us-ascii?Q?aMxTEXHBSW88SZPz3rA/omFmCPdCaPs1cyXPbkTPtSDtEnvXJk+1QsWn7+f9?=
 =?us-ascii?Q?3jpnk76E1Hf48wcEcYoloPRFowbrMAvG66ndZCZnF2PmPjr7zo2zTYM9mxnu?=
 =?us-ascii?Q?WXdF+cFeEaT2JeL/Qe3AE3QsYkO1dbEOuLOTvpoevcpyYXcM8gdH97KsqNTf?=
 =?us-ascii?Q?TIFcrQKr6BF1/KBaKW8UYH+ixxG1+dIPBcR/MOpWe67ykHH1+FR2pKmKXOLg?=
 =?us-ascii?Q?we30H/56bVG5tSM2fzHAo6I00BQDQ/XeRw5xVOJthDr3C9ca3YoaqeZC/fj7?=
 =?us-ascii?Q?Tcz1Qugc5Lb85cakPf4v366rqrzy12zVv4XT/7rXgmlKW4IQVeiJzbhMSp+2?=
 =?us-ascii?Q?ORQfzqkmSb6qJN7qCJ50AaJgPB9PmxMYzWRdNh9vbjOvk1BffmUmlMSubJon?=
 =?us-ascii?Q?3mWgqBxrS7nZaXVHjfT+TNrWG4m/Z8HVWcnDQNq6w/raTzMzafSZzzV6SKj2?=
 =?us-ascii?Q?TsXT1IM3cf1MhG4J2TneXVWAE0mmMaeFbae6etZ6dZWJB8GGoRCgwau4IoWw?=
 =?us-ascii?Q?PNihQv27nxI7Fbp4MSJ443Ntvq63xqNlvI21HzaNv7WEPfstBIznZYM8RDzQ?=
 =?us-ascii?Q?nchWjyZXrQbEvYaLz1He6f3isgh+71OdT4x5p5i3Z5goOg3SLUupXMCeaxKw?=
 =?us-ascii?Q?aPh89ltcGp/dQDixY7uxA1l6FzmHsru7FzFXu1GRE1ixoQeBr9ISs2DEOgIW?=
 =?us-ascii?Q?0FZO/mIRQ81UAdqRiJQcR8jlpGNnp9oa3Dn7Q8ImimmElNhZfOoTtO7dhRc1?=
 =?us-ascii?Q?9671q2g5VIb8VXSDZiG3SrPXdcD9Zx+2L14dZnt3UNgVcyjCVoC16bkpQ0Hv?=
 =?us-ascii?Q?p2Tl86bJapGd6Vpb9hnMGYbCOAzzw3jCBwWinydj+/IIYq58slz/+vHSfrB8?=
 =?us-ascii?Q?KO2yTntnpU+SLpIuU6LocLUPRU9dCVD2N2U5KNY7hNMjS7Ed3xeYrhiQHTxL?=
 =?us-ascii?Q?PDI/YzKslHr0YxILbeboDijRLnvfZVJL0MzDM4fLaiQmsW5PIfcRhUtB8NmG?=
 =?us-ascii?Q?gAJzHJJGYNhapQ/QCnnxeipWESgSAISD5lMIIZawyywWwdRu2b+0MKQRziSb?=
 =?us-ascii?Q?oWCdLxnQI5j5o0O5PsejMSlls0O2ChmON6P2orrd1+AC/jNbls466ugpXlJc?=
 =?us-ascii?Q?tTItD/jE82CQjEGjuy27+RPxE+ivAxRW0bOqj8j9hhj544BL5DH3PQK/AHBf?=
 =?us-ascii?Q?pP8MZxd4rRMIMex+R94lUnPmghvpr8uG9ambzMdTPkX//bR30/zcDHU05S3W?=
 =?us-ascii?Q?QWk52hEK005AbiSj5gAzS4Q2aTJl+2V9fVbzG+sxpIYAW8TNKMA0qOL+TFde?=
 =?us-ascii?Q?+oBoxiNJ3UmDd3bRQibW+GPezet99rKkJtePodNKl/4nWgAMXKvTT1H1JhCy?=
 =?us-ascii?Q?8coYrCvl9huGREcNZ8NbCMZLZkDPb0dUYHpCcsyrQgkg1E5k0vhr6dS5QYId?=
 =?us-ascii?Q?5tsy4Ct3SCPfLfpwz6ZoQA/Te5na58E/4zQ+42jAmGfe5dgOPGrwb1dl8En5?=
 =?us-ascii?Q?6x3Sh9bSr2KbiBEFjS+Dqmhc7Q+5gSx0cQuj1ytQtF4aS6gekkFYCU70OYBV?=
 =?us-ascii?Q?U6R53fZdCuz2TSOz4jzoNJAhPfWvPX+95NhUT/XhrrDX/X8oV/qGQ1moOxsg?=
 =?us-ascii?Q?IkVhYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c67a51c-f5a2-41bc-594e-08d9dfc63b9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 05:47:54.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9LDK0Gbh/V/5HzsSmQG3wOQXvOaCvQthSV7fLkzVTdIW0tDfT22bKISXP22wbOxlTdQQYaRkMzTV2SsYSZKF6HamoIRLZer/mG0tmWmVZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2323
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250037
X-Proofpoint-ORIG-GUID: HX0UKGWXBfpDqoyvCvLhz2lOzbTfEDWu
X-Proofpoint-GUID: HX0UKGWXBfpDqoyvCvLhz2lOzbTfEDWu
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> this patchset removes the <linux/genhd.h> header, which has no clearly
> split responsibilities from <linux/blkdev.h> and is included by the
> latter.

That has been confusing for a very long time. Happy to see this cleaned
up.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
