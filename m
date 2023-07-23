Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60456C001B0
	for <linux-block@archiver.kernel.org>; Sun, 23 Jul 2023 20:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjGWUwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Jul 2023 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWUwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Jul 2023 16:52:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF90EB
        for <linux-block@vger.kernel.org>; Sun, 23 Jul 2023 13:52:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NKMpMn016570;
        Sun, 23 Jul 2023 20:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Qi7DF3t2cNEPB+QCjPSChz20KoHvJA71+/0F7lOqegY=;
 b=HAyIHncf+H+zYbhRmq51Jq6SjXQrgBJZeC1yCPTe5cCIQn5udYdw3GDa/WypINhTKeMY
 GdlCXfosGHvceVmZjA7Baij+bhFtwLUfCFwpn3K1zadRqU+YPk38rqEgGaC83rJdk1RN
 VuYzaeIFm8MxmCfdwox/6x+axLzkW8EDL5PibDiIJURClV8YPYvb/6AgrLbdSDkc6lzl
 7bQ4/Cedz5Lm0XMQKSkFUiFQDp/7gWnPZcUS4VrtYgYxu5/W2G+iHdXh6e4IMlbCcBvQ
 jTZsFg4eEW9WSQV+t2ME/xVhtH78A+g0roTN6vgSX8+7tdNRbF/Lw82yaE+EB9NagpBX kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3hhyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:52:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJnUWL035440;
        Sun, 23 Jul 2023 20:52:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2q5uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfCSQl4B+qdDIpqu2+taSt6tqoh/EyzcDTavUrGhhNoEulFDY35hpghGIfXgPl82Feq/0giI9pvqlRIG96W1ufIFJJIBNFPl7/ruRWekGk8kRQ/QKgBysXlu5qTT94rRFmvV1pTJoREl98fdUngVznMcTrdbGAuKz9HQMpE4kXqqj3fX03DesW4lle9xV/X4rJDvwa2mHj9MjWv1RipCGZvcAecA/dlCCpDR3gwfVcdvWKy6RXBbfwZJdLhEtye1gSglYMvxhJ0h0AZgacIEwd0DEtw6LxrMI+lTRYs1QgnbAK2EwQF8y/cwqGKTmATq9LUELBWP9FMu19yWgRnM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi7DF3t2cNEPB+QCjPSChz20KoHvJA71+/0F7lOqegY=;
 b=SW4GcZAKgmnDAv+LUKr07+oBNXRfJl048/YftsSu4M/EfwYPOLeCEkNHYkdCvvCxWrzPCGhn0+FqvxYEzjjFs0VPeGQBn+5QV1e2YO9I2MAOO8rPPfE24GcDE/ahOwHxtrqeh/CE7702J1zxuFMRvnsOKZykaM6UrfQ+sQmi6T/qtxnGpydNf/pomTHqPqduepkp68JS5jN7vDhzG3mb6CqbWUXCXMftDA3so/pFjn716g8XQRojxXlFOxkiqSLzAkU2wTzL00AvecZiRJnrtGKZ29o+P/Prb1bQjHnVxjaN+P2Lm9L8pxraHS6ZcPwIN9lnoNH27kIEaJpRTsvA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi7DF3t2cNEPB+QCjPSChz20KoHvJA71+/0F7lOqegY=;
 b=aGHhYAbTYSraWpJ1Djyjfc0IwTsZQrQMn4Lv6+3I/kuKHvxbMWZ3EmnQuAnZgQDlCtxVhAqW6UGd7B9fhZinitJcVt0Hc2vB3s7YP4iFfKBwBUo7HI3QzMnAgpvHHZYtbF0qYgQeRz+5E9RqEss1mUCGesGLbx6LEhFYkVD0zFI=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 20:52:05 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 20:52:05 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] scsi: Inline scsi_kick_queue()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq11qgy4ahw.fsf@ca-mkp.ca.oracle.com>
References: <20230721172731.955724-1-bvanassche@acm.org>
        <20230721172731.955724-2-bvanassche@acm.org>
Date:   Sun, 23 Jul 2023 16:52:03 -0400
In-Reply-To: <20230721172731.955724-2-bvanassche@acm.org> (Bart Van Assche's
        message of "Fri, 21 Jul 2023 10:27:28 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 4199e0da-31a6-471f-f3b5-08db8bbeac3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhGKSgZFYNY/OOGnh+rPhJkoO4HgFvCVJ83y4hOpO3wYJEVCAoC0+L1xEFYFbM+1MjdLSOmsbDkH9cpme/bwDrN9QXRu/AMeOtmeiaU/0z9ppzBBqfp1LtPjQMM2GrTC0RR2FA1Z2iw0bQDcUSU2qJZK9d2CxratMdkZSjkjZwy0TLI8nboddHwKniO6VGPvD7R7iUwHYlSGiDVhxNY3+IPNpW9z4WMzlHSN9AKWoRh93rg0ax1AILjC5QiYAgYlEQcMRL0Py5hevnMYQL4fL3FOVS9E8ZmoVfRYyFmnZc7HOfbB59pFcvOqdAzCN20ar+Z0f9b17sX01sVBJncc4Y3cthtTBF38I8kBjf8AmViR7qkuB4HRjqDf2lJsaJoj2ZBy1eBc+ggowmsjUoCNdhhzHLoK9xboN7o3Ec0M94tepG0AWbbH5ktVjzKqTZH6LA7llkd8iyjt4ox+NwWOKaR0kFV24kflPYXRif5tKuKWT2hWmv9VLdsIheK5NHvt5fR35MUm8cxCj5W2ANCV5wfH/x7zJj2tUHWUavXrqm+JD4skBDtBYorw4+g2ILyR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6916009)(54906003)(66556008)(66476007)(316002)(66946007)(4326008)(558084003)(41300700001)(186003)(26005)(6506007)(6512007)(6486002)(36916002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GHMjw0GxWu4nPgiKvWtFBCZXNvJjQH8bd0rpjKA4g/w7MrRilhB6LOjwX75S?=
 =?us-ascii?Q?RAs03Uz4GTi58e8SR6DwmzsUc5N5WaInNt+XchXcMvT+rvHlcIBxMLT2avkF?=
 =?us-ascii?Q?65F4Hcz4+RIGqnwiT5+yUKCI/6AmEiV3XdGpW88c4PA0gMHTY0t+xiPhzri4?=
 =?us-ascii?Q?wauJai0xELitQG2Bqni7DpXrB1Df0HAUUuTA61FKMDqLAGccgA4Tg3a35rNr?=
 =?us-ascii?Q?kI9etLeRdNpfKS+0MUfJOAFJ8vyWdVjT4MQ6bFexZzHD5UQ6TzPkpcEZGlkj?=
 =?us-ascii?Q?FpiOMcN9MAZ8W8pbLHgV1wqwb1mB0r0QrykXercAbRPcMRtf2S9OApr8XuQy?=
 =?us-ascii?Q?f8xJYjJZHnu0R5mbsU+NrAhHNDsh5d9m8u5pB8FcIPcERdY4Q9FuT6NiF23J?=
 =?us-ascii?Q?sSF2lnQU4wLh8I/1A+f2yVD8tgPz0jW97DaeuR3fDouTee6ZP9HnWaZWp3UE?=
 =?us-ascii?Q?AgBH/Cy7R/E0rSM3G7Rcjbt0C0PneLf6u8pePJbJk7TkObvMHVrE8TOaDIjZ?=
 =?us-ascii?Q?FYfctrFYl9LofLc317NctvcjyqI4ZU2ASILtoHFmHo7gESu5RJq9RAMdsLab?=
 =?us-ascii?Q?UeHBLnbiOJ42mU8MR2woPUpNGdKFKcW1PMVn0idlgZ/P8GwwquzJeaIG0f91?=
 =?us-ascii?Q?qyhOCkRuIPf1/VpyDL8ECaxtTiw2GPOhf6iZZ4TqN0SowsllLSYvj8+2thgB?=
 =?us-ascii?Q?6VUaIw/pW4BWVajyBDmboI6bRBZokUm4Vg5aNScrsDAjTbxGaluZmZAU5slk?=
 =?us-ascii?Q?MzY1NDqQnsmNM66XcJQmefOPUUQTgxSBWojF15nMeZ1r85gwihJPoz0ePTNq?=
 =?us-ascii?Q?Wt6B170h2rOpYfvDJ/9LS8tmQzMK0Bl4om28FsmEOemHxmPCoqMPSg2AOaE0?=
 =?us-ascii?Q?bZPqVBooeK00S41a12YgjDmbvPNHwi+TD9TTCwHcMTTwFwDvjPtjKgvqCN6a?=
 =?us-ascii?Q?Jz7a1JbLeDK7gRytbFMY18ywoNbn0b3sffJdaL1Q3iQxGhmMNX6mypI109sH?=
 =?us-ascii?Q?7E7r08M67ztl8isurbdF3NcYwf5RzWh/0xJaRy7itxlLVwstZ2TuOf9Sm8LZ?=
 =?us-ascii?Q?OR+nRUROCsNtb31jgBn9eODi8XHS8qYU6bookYvsgvQfkFiTDIk/wMzxquQg?=
 =?us-ascii?Q?aSL7PGWWygAneHihH1/W1wRZtY3nXAlPXAjFFU1gizicleOjM9zF36ZulSdI?=
 =?us-ascii?Q?mjcrS6S+al2382BuNB0miXV4eA7StVlKaFzRrtgUmCkwAAsfRj4J2OwUDnTM?=
 =?us-ascii?Q?hCLylAAdCaZCuKs3yfayliq/flz4izCHQERT+EGEN/Q/sbBwJGNNZgwkdPal?=
 =?us-ascii?Q?QpOn1lASGR9baHpyflszpZsvuDpH0vt7l6bksTqvpTyUracpsz1LWP7bSlcc?=
 =?us-ascii?Q?oMnavkokY4EDDbVBElHYmOPhmebsMD0dVeolRm/0+V7iI9uYoyw+QabYT0V7?=
 =?us-ascii?Q?feSLlA4nuaGS+TXkQu5GqqSj+rUkA7aceJhO+MCy1p2UZADbLYI2wW1uVTAT?=
 =?us-ascii?Q?7CCqgUIYg9/OtfeWbGd5iFl7rl3HUPOY3Eu+KJbFiUHYY2mgD0+cdwLjWQJF?=
 =?us-ascii?Q?x0OeJ/KPWKjGSIVDu0pte6Z8moWJWHZoVzzhS//jE2bT/95HXB3RnqG7mhUj?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DG7Duff0g0CtAYIpYc2I3NZ7IvxfudulH5TXdQ/NRvYOMSdw4ijgB4r7SI0xMCapJkJ88KfHSshszPjrvIzBxzqVqNNxDTlKzoBduNm3t1UE3N14Q2sBy+UCTZnK3gKXP4ddQ4B1pOo9VZvYZMG/BVt/qPJL8pVFc8+vENP5OylAlUJqKfVMYUHR9bO46tsMAOc5IXvFXYub5QESKNr6SN+3w4nb3irxH7VySEbVwTnZGjb5Jr0WowbPA7YXzYXw55A3f8SomZ2ynx/0Q3FkKv4Yh2TJncJ3JPCdbevKNPtN9lGQbQPa/WhmrWETZ3xo6zn4k6Ml4Jzhy9Mmi/sxFkx0lLgaacx+PYTgXkkoFj3J4IfihfcFy+1l2IJoli7arBesYuBfXOMJk+di17lyjoi8hcYws2Q1JBVBVVpXnmhMnO4rdcl+zoqjYnjjvpbw5b0SUpPs0cugyvxq9ni0J4nTqDTnCh2oxL7zRWz10oUiI8pdh3P2xTNjwa8pXM0bx7RfN/9ZP1Xb7yHvK81jkEpPSMfEFsk7iJKklOOhpysvJaYyTw2QuJt1cZ8gr/nM5qAc5WcMSRjQCHtl5ZxMIxDPaTMSPQYgKOBe/EEdoDvtRtc3Hlq44P0/HNNSS3er80ZuBs0T6QzOIVCMP4l85lNYJz2SKcvjbfiTS1fjQVS+Cfjn5oOU7SwCJ/K3weLmmuHuP1oqY7hUJGWik7sRP90Z/OWcazS3OwNcQ+aP0RPxCsxQzLXM3zCuB5FyEoObdsCzdk9DkPLrWIK5VRI6k8xwb4P7lCxS7zT/s243I0uMr+Y+U5jRYyzG8N7Ga0JKsfDObAOAH9mMPBaz+LJZc0RJBzN2MphMvWiNIJ0FEUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4199e0da-31a6-471f-f3b5-08db8bbeac3c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 20:52:05.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP4fJQok7CqLP6swalpcXSS2kVN1SfnOc7rc59SPKNg47WwYpUivrYDMvbeg7lAxgkKWyOw/nNLvXIZs3Ocv9Ku3/4ezlhUzeF/iiU7ZRlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230196
X-Proofpoint-GUID: ApXYVEMXHq5wxKqMlErSvR_iVfktOKHQ
X-Proofpoint-ORIG-GUID: ApXYVEMXHq5wxKqMlErSvR_iVfktOKHQ
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> Inline scsi_kick_queue() to prepare for modifying the second argument
> passed to blk_mq_run_hw_queues().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
