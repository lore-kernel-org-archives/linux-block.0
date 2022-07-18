Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C1C43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 11:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiGRLN4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRLN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 07:13:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B48100F
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 04:13:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB415c031994;
        Mon, 18 Jul 2022 11:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=LjqzsHAphNmP8O5f7NrDtzJYOg7zUymUDZCps4PDQg4=;
 b=oL5aL40XBIfIvvnYt0BTwY/o8fXfYsCdu167EpKMRb12pWrNMfoWrW0seMsreefPR2Nt
 FRHJeHs/RUQ0/8HumcNWjxyU/jBCvmWqDTaNncqoT0EnNYl06WvfE1MmoXXuCJH+vY7+
 3CgUUqidE9DjjeExbN8ZtI0y2wbjmp9szMGp2FUuG8vkhJgWw5urMlSaLcsTz+MaWm0U
 QXKgXqtU0PZ5htCS2PumVYC0QMG2HifsOT5Pxw3KJdatpV18hSv3IpqIorfw4VzbjCCL
 SaSzC0o1Q08ZIXIYXjccxqtDeI7iTsc6o7d9tYwsoJTpFLAYKwNh3tmSdFBskvkfFH8D 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs2x0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:13:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I8ChXX002026;
        Mon, 18 Jul 2022 11:13:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2cq6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+E+1atbm+XAYs7O6y8kH/LcaN9FgraKFCFp+boTuOCug69it8vKLc9drgqbZPPMHYfTR0Cb/uWc7xpCcPJdY55z9RsH4GgTRPdEkwsPd+u1GqRyOmHlyOLbTB0l4Te5PoWq7bLFB63pL3cUnQMehW1Az7vJx6OPtghkfCTOtinEmijUCC4tAveOtORq1nZHXF7EntdIbGHEvNNtj5NJFGHrzHu6TVv6gfA9BGkYDIUkep+m6iqqCyUEuNIboNsK9tBgAzFdsAzJdgrx7TcdqsE09inLnEOnGTtExvR59eAfzjz2CkQd6jauXGdETuuM2FJW/gM6gWQLboYzVNugsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjqzsHAphNmP8O5f7NrDtzJYOg7zUymUDZCps4PDQg4=;
 b=FQvaArwybK/pLP8KuWVnrguwc/v+H24MRF26Gp+MEacStpkmqelu6fmpnzJedJuo4MQdl6AZtrdQ1yusxT+JtkBrxsSmbl9xAdWRD98tU17cGlLL9hZKnE8K7QeS0T0lrKEPwvQz9PpEWArx0bNw3g+/lpJtvLAAkmfDfd4NoO8KLYkKLMX0QZRKTqVMvY4ig0sREqiyH3pEyJRy6knE6Bp/nn3yImqtE8y3sr1dMUDoV2WdkR8d3IKxHMUfbXJrKQdtBqkE3B9E2x2FrnLHvqW+KB/o1w8R3JvqVrwSci55I934vnOC0jvEelZzLpPMkGr5F5OJa/uTMncH470UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjqzsHAphNmP8O5f7NrDtzJYOg7zUymUDZCps4PDQg4=;
 b=BVatfNovBOWwbVAFF71aZiLMQbpoq8Zi9dcnyeNdG1ChBzzd78df+HUR5mSK32HMFMf890BttWCyyM6JWwgL6pRDvlgE3RXokW5nN7NuguW5kWV9BOj3aQnjx4dT1cUGebrLsEQ+CIoY7FE/12H1ydG5mBMYt/OaHTcSrl/Y3XU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4757.namprd10.prod.outlook.com
 (2603:10b6:510:3f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:13:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:13:51 +0000
Date:   Mon, 18 Jul 2022 14:13:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] ublk_drv: add io_uring based userspace block driver
Message-ID: <YtVAZlOkteVueVnb@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc94df3-4969-49ce-bc71-08da68ae9822
X-MS-TrafficTypeDiagnostic: PH0PR10MB4757:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfAL0QgvPLkke32Nv6+h0IuxHsaGHpb6dBNxUhkM2gtSCjKLnJ4twmwUa6ch4hBKX2Xzj8c2SfciYZRDku8x1s254EVDYXhR9SMwD64BNFDY4MTZb8I0n2yNLeZglahByC5D02GkoJPWCt4ZMa/H4/LJw/fA5qjP7tQdJ1Xox8S3yOl4V3q3NylvppXL2UtdO1dAOlPuUQlPQLfcna8PDsJDsWDw0F1aS/OLHHNqHIAUJyRmVm3xn8vImDPxuqWfbfJi4VdcBvk5bH+HVA1TXpANLeBcJy21E7yk3Z3c5AzWo48kmcKUWvveWtxDvKjuanV1yu9AV/p2BI7TDpuX8+nXXggI2VBqE/ZHeCUsKJ4OP9qOLkhAOJfni2rOEFmEJAZt47vQ6GP9RZvIzNVtPmF6qXknf+rSTuJ/kiGwFz9AjILFN6qHe0RnALxsSU4oH+7O0yx6mLlvdXR84B8Bhn7zd8mERHxKHu8Cnluj/W9A4Crs4Hxlnpd4xkNy77RRWr66PmKk/EPcFXrBrK3wszVfJEFNhE+3abniFpaogQ+W6xAmnOqtXVmxn3qtE75zmeuM9GTDxsWnWLp6aoYz2koFij+QbQDCsNUThxAKNSWKe3MdIZYLbT1zTek5/WxKUX9hids/zHqP0IKPDisNT1E/VI161Fh5pXVJlMjHILvflsC/EaaKauNQjtJq1CEFvDiSjgjxBnB20OVG97kym3gHFPpXJ0uVxkhTtos8+v9OyicK7d4ywhzYBdqlElO7zUBH04Fu8xtKHqDM82Obbc9ivCq0da4+RsKau8KIqzRcI1MgToo6ER9cHPUOuKEs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(186003)(6512007)(9686003)(33716001)(52116002)(41300700001)(26005)(83380400001)(38100700002)(6666004)(2906002)(6506007)(86362001)(6916009)(5660300002)(8936002)(478600001)(8676002)(38350700002)(66556008)(66946007)(66476007)(4326008)(44832011)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2xNtoo4U6CDaZ3Gl/TLDgVOItaJ+zbrddIjDYQqYVtDNSiHcfS04ZVP0Ev3?=
 =?us-ascii?Q?1q40V8pouN+3vHWGskukMerxj/i+DQthHOd0N9mxfHjPBCnDz8f8eoY4kjqk?=
 =?us-ascii?Q?dWKtW1h6D7n+S7H4v3xJbPTVmlH1sZT4LPrQQnZDi/DTbhH1w/0NnLGDxaMQ?=
 =?us-ascii?Q?RPtBxiON4kUUCsGOd87rCZg4fSWYxl4ENOfvNvknJEmjKkxj5q5Ue+aXV7Vo?=
 =?us-ascii?Q?8Za/pr8HkWCaHHxNda0Ekf+o/MUqjQGO7sN3bhjGJ21zkarmfQxwnM/W7EFf?=
 =?us-ascii?Q?aQeQ2wOZ6vS0foxv4fuBTf5r1NEeAL08RaEEiDWSTA5P6qpQvonJzkJOnOt2?=
 =?us-ascii?Q?SZJ6BAVaRCiB+ZpVAJQjMKjfEmqRlo23z2U+Ynjn2ly0NTji2vjlSpJcgp0q?=
 =?us-ascii?Q?8ppCMl/MoUkEpOnpsgne7q4aZVXsCuOcvXfz9MtDZornSQqBE/NEvdR01da7?=
 =?us-ascii?Q?DTBucIaw7G6ZqC8JcVIkgmhpwKKXwEOfEqRCVcvU2kIhlHSiMOMeq+qCPcYX?=
 =?us-ascii?Q?Bb0LXYfdWa3PzrIOYDAJQ/L1fn7dNPENc26eh7HgtOhA9iCbZ0mBbQfHx6i8?=
 =?us-ascii?Q?BFMF2vZGVcKWhedACWlQpiFFL7eMll0gI3VV+SG7AJo1yGgG4gKZbK1xCpRE?=
 =?us-ascii?Q?a4+RD5EzI2skHsq5+xLo2C8CunPomZe8mlfiAsg9isXs/eDnPmiA/tbeFrFX?=
 =?us-ascii?Q?ZUIJSm/QUKdCHIFfIieasoxiF7obk32JDZ7cibG9tGx74Y/JiR7WhgJhw2jl?=
 =?us-ascii?Q?A6qeLu/U38Vi02H/9P1bXwgJJEIuJxQCUdq5UdLUsEuAM40id5X/X3kA7xvO?=
 =?us-ascii?Q?og69NYWwY568hhHJw4dISMYc12Ty8Ro53XBqn0U+HrIPMKB/DKzTwfmKpA39?=
 =?us-ascii?Q?RUjOjbUk8OEtpiMySRPxgA+RxX6HRj4lzvfdwsRwxVnjfTu+ivj0MOxa4zUo?=
 =?us-ascii?Q?IzZoV4g9SqBiW8htzfJVnYyOOeJuT1uTkoevfqXhLVpNfFPL7lBTyMmwMjxZ?=
 =?us-ascii?Q?r2GBhzdwgKgWC1Kh0sx8XABEtj7x1xs6xuFvTCgmw73gjvkcscjSmgDZoyt3?=
 =?us-ascii?Q?KPB6XX+UspL+L0z/LCz4o+7AKVquhi/4F89L8MBpxjrx8eYVMYOZlH6IIH7L?=
 =?us-ascii?Q?DK886yLQmdVNua0UAzXTLmyAefdlf2OZBHvk4PPN91GSAW88Ex2f76NtOpHN?=
 =?us-ascii?Q?bvavbCaQfzDUOkbz56BVekv0h1YMRDjeIOqr43HjEZ5zC5lUKyOg01x48UkA?=
 =?us-ascii?Q?lvpFGAX44bPvio5YNexPklAWXh7YKqfCWX1eZDK3hD6mauVzj013dq4a5PuC?=
 =?us-ascii?Q?lR+l11sPQMIqeo6aSAdVZSoJL18ay2Jv3IPBED9KhuQDxwOH62mG+rmqcSo8?=
 =?us-ascii?Q?bN18IwTqLWKVJwWmaLz94Q7IteCXFnm0k095sN3P+yHXLHT3uS8jvBzapnGM?=
 =?us-ascii?Q?YRbX/eXv+mJyjpcvTImDrRLhWIuxRbOX8+WI1XVodez+7Jg4PBx5tnhY6xkO?=
 =?us-ascii?Q?nqKve6kO4lmYBdsv/DE76ju0QQLQmh+QoXTsMS2aKTRg2oPbIDNA02VCTZ9L?=
 =?us-ascii?Q?ZL3vdVg+Rj3DVGBuCWmyPAGJpzV7frxD/7e8vgEiFuVI5dYE1vXBXWL5KfOV?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc94df3-4969-49ce-bc71-08da68ae9822
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:13:51.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+WUIiYb3dQLu9KIOaz/L9zYgqBGQm7BXC0zaFldAg2pKGF7vgvCTN8E7sjh3pjQYrlqCzrjHsfrVhRhjENS19a0R9cpbXvoP6U8e8fp4GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=940 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180049
X-Proofpoint-GUID: MYG_2xuWgGsbbzLRyR1RQRc6BgPDg6vm
X-Proofpoint-ORIG-GUID: MYG_2xuWgGsbbzLRyR1RQRc6BgPDg6vm
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming Lei,

The patch 71f28f3136af: "ublk_drv: add io_uring based userspace block
driver" from Jul 13, 2022, leads to the following Smatch static
checker warning:

	drivers/block/ublk_drv.c:940 ublk_ch_uring_cmd()
	error: potentially dereferencing uninitialized 'io'.

drivers/block/ublk_drv.c
    863 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
    864 {
    865         struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
    866         struct ublk_device *ub = cmd->file->private_data;
    867         struct ublk_queue *ubq;
    868         struct ublk_io *io;
    869         u32 cmd_op = cmd->cmd_op;
    870         unsigned tag = ub_cmd->tag;
    871         int ret = -EINVAL;
    872 
    873         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
    874                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
    875                         ub_cmd->result);
    876 
    877         if (!(issue_flags & IO_URING_F_SQE128))
    878                 goto out;

"io" isn't intialized until later so this goto out will crash.  Goto
out is always a red flag becaue the label name is too vague to say what
the goto does.

    879 
    880         if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
    81                 goto out;
    882 
    883         ubq = ublk_get_queue(ub, ub_cmd->q_id);
    884         if (!ubq || ub_cmd->q_id != ubq->q_id)
    885                 goto out;
    886 
    887         if (ubq->ubq_daemon && ubq->ubq_daemon != current)
    888                 goto out;
    889 
    890         if (tag >= ubq->q_depth)
    891                 goto out;
    892 
    893         io = &ubq->ios[tag];
    894 
    895         /* there is pending io cmd, something must be wrong */
    896         if (io->flags & UBLK_IO_FLAG_ACTIVE) {
    897                 ret = -EBUSY;
    898                 goto out;
    899         }
    900 
    901         switch (cmd_op) {
    902         case UBLK_IO_FETCH_REQ:
    903                 /* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
    904                 if (ublk_queue_ready(ubq)) {
    905                         ret = -EBUSY;
    906                         goto out;
    907                 }
    908                 /*
    909                  * The io is being handled by server, so COMMIT_RQ is expected
    910                  * instead of FETCH_REQ
    911                  */
    912                 if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
    913                         goto out;
    914                 /* FETCH_RQ has to provide IO buffer */
    915                 if (!ub_cmd->addr)
    916                         goto out;
    917                 io->cmd = cmd;
    918                 io->flags |= UBLK_IO_FLAG_ACTIVE;
    919                 io->addr = ub_cmd->addr;
    920 
    921                 ublk_mark_io_ready(ub, ubq);
    922                 break;
    923         case UBLK_IO_COMMIT_AND_FETCH_REQ:
    924                 /* FETCH_RQ has to provide IO buffer */
    925                 if (!ub_cmd->addr)
    926                         goto out;
    927                 if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
    928                         goto out;
    929                 io->addr = ub_cmd->addr;
    930                 io->flags |= UBLK_IO_FLAG_ACTIVE;
    931                 io->cmd = cmd;
    932                 ublk_commit_completion(ub, ub_cmd);
    933                 break;
    934         default:
    935                 goto out;
    936         }
    937         return -EIOCBQUEUED;
    938 
    939  out:
--> 940         io->flags &= ~UBLK_IO_FLAG_ACTIVE;
    941         io_uring_cmd_done(cmd, ret, 0);
    942         pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
    943                         __func__, cmd_op, tag, ret, io->flags);
    944         return -EIOCBQUEUED;
    945 }

regards,
dan carpenter
