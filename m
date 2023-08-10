Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396BFC04FDF
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 16:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjHJQDQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjHJQCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 12:02:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054D2738
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 09:02:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AEwvnh006085;
        Thu, 10 Aug 2023 16:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=OCh6oBSLk/W8JmSzKDJGnlZHHlTjCacC8k9Q+cUMerg=;
 b=qLPXgyOMg9/YZCLqOMhMh7tSAJOr5wWoBXDs7Q/KhEnfgLfP5K/wHGDujji+scElSnM1
 DXTH3lLTJucOUrYr/OWZ2gYyPtTSQ9iEd557BNMFiZFMUR1j2le2BYLRIVyuZkGeOyoH
 UXjGBn+lDFF4YVGlRRMStBQL4QXVwbFRJDVEzRme3ITiwnck+HFx9vLmr4f61G+C5HUZ
 6sWqoC6XzMQdWkHUYxIlEW7ozDbE3sr7y8dT6yM+LLaTNBpyw/CS6aKhXShRW3JDGC9o
 FaVAJ3G2mTvGKmC/d1GNa1S6oLdbCdUamf7BB2JdNjIL1HtskKzySjP880maYFmATzvr wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73kjag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 16:02:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AEox5l018559;
        Thu, 10 Aug 2023 16:02:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv97bw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 16:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgM0356qf13ofDXutbf6K8f0uf8LIPrgnUbSuetsxiHdl748kqODsLX8mtJ2CHxpLNw8uUPW45btskay38NqWFDr0+j2/oSNmRcrDQl5XOMQRm6vXwkaU8S08UngG+7LWQYhPwRPLjdGFgESsfVLsx+mqwkHvakytNB5cm5lwgnJvjMUHP9HMSj5a8JMyDIDmwio7wizqUrFdaFGfmqzp8gM5ydU3YgSUdWPLRBsRzy1uqUel97/LFQxdpvSBC1eFzXi1cBmfpaWnwFh3K807YeqHjbmdec606+Rx/5hm+i6oNY1q2HSLnTa35EVbOfJpVJdYCxxXtF0FBQ01Z9Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCh6oBSLk/W8JmSzKDJGnlZHHlTjCacC8k9Q+cUMerg=;
 b=i0vIvhAmSaXBw6Z7Swvt8Avb/+LHjAE24BRzl/4pxC21gzWB0sRRk6mVe7Vd5xWxcj8S9vvNJZzMoYZOLGyVvyMFU86IQdPNjxE5h2mlx/aK2yLazHKOFCxgLDos2JASQXfiUTPpH6mwOjtnAnIhMz71Kro85x8kP7PKM4xrGw+Ni4EIodi7JiTCB28inegkQzoSbNRw3MN45Q3hKLt+B5pE04pr/VCq8pKdgBhUzdx7K+ntH+5QG73G5T8QHUhQnYs7y349ZVbYdNDnnEvzIMEIKywqi+8YkNMaSYYtmyMLItlqa9y/CuINvnHuGo5tXCGPKy8iwkCTmPXwZSIi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCh6oBSLk/W8JmSzKDJGnlZHHlTjCacC8k9Q+cUMerg=;
 b=uU7hikd8mgQb+cGVv9u47Nq1AhA9GZTGkDyZx2sFCZDjJaVeFU+NgdT+C98ryF1/4m7HgKrg5y97ExcrKKv+Vv6lK7Ju9gKmkHafGwj/MNFjUurujMgScDecr4ODg8pKTZxGb3hdEkB5apHQ10u9pSbtSRTu/CQqMEDfB7D5I5Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7537.namprd10.prod.outlook.com (2603:10b6:208:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 16:02:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 16:02:04 +0000
Date:   Thu, 10 Aug 2023 12:02:01 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chuck Lever <cel@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Message-ID: <ZNUJ+Z9nK3s7kKb+@tissot.1015granger.net>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
 <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
 <20230809161105.GA2304@lst.de>
 <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com>
 <20230809214913.GA9902@lst.de>
 <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
X-ClientProxiedBy: CH2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:610:57::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 585ee571-3556-40da-3a69-08db99bb239a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WlRm+CPNA1wFkuUKdEEHxkfPdcVkOrjQ/tx92yNc3GG6aT7UVJ7h9lAGW9jB32q82C8TQmtKNSJb6UgW5UFzICaUP0YNr06d89+y2syts8RJtwK5Y2blpXGWHTWnJ8OdBFofxhvIjPU24UEUWGnZ0UyK4B3O3yIOCq7yo2saceJf7ycoRn7JzmFNPNQQ42OGCjY2ZCtB2yG9LR7WLWOtWpstn18Hjy6KDrPP2mAGyJXxJOUeIGV2mBVu2vwBfNg+Xk0KtLDu/QCcmKjtN3kLov6K7Xztp/wLodSekO9kd067BioNAkUICuAihGbaHcgdzuGZ2VH6Zjyg9+nFn7yMoRYyoV+1uXE6hiiHdDEbPOgLeh1OH6u1D4/1DfUwSdp4LrAEFr+YiDFuNcDnrIRX394WjPUuXALRFovaoWLaGjeJ+6S/IqMzMqglZcmXWgmxA1l3Xq8nIZGwEVWulW4x4It+bFU13ol+zuttcwrtv/6ynTlWZAZiLUXgVeVj8syElj5sVumeTU7i9ECxFfJja1Xre8hudeBHwhxszpU/HSa07kY92r+tVgGD0lWe6Is
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(1800799006)(186006)(6666004)(6486002)(86362001)(53546011)(26005)(6506007)(9686003)(6512007)(66946007)(66556008)(66476007)(38100700002)(8676002)(54906003)(4326008)(2906002)(478600001)(6916009)(5660300002)(316002)(44832011)(83380400001)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBqhImGbwQ/AeuftSYZJJbneJDmY1XPyWMJsc3raErG+c36Wk5+4f4Tu8hcs?=
 =?us-ascii?Q?QwaVRIiXKZ3GVIeKIOXHY8H71SlLxVBjYH1GX5V+7kdybofTL0kRAyemL+rZ?=
 =?us-ascii?Q?hy5mpf3TBzeTmNMMaDx5ztYxhOMu4F27aeBZsJU9i+USgfk1ABF+Kxt9u7FX?=
 =?us-ascii?Q?omVal2NDG+stlRiEm4zE+H8KGdr0TUC4YWn0CDgz0M28Yq2FfFvNjNu+E9KF?=
 =?us-ascii?Q?sbY/5UNcWGNzec/i6UOOgJVdK2SYavbauadReeYWeU5dZEW2SivZMn3KHAL+?=
 =?us-ascii?Q?8swFvzuMdI0JnIXrhMdjZ65ha7UXMkPIV1CdyC2/nftT/fFcMIyr3O522kMe?=
 =?us-ascii?Q?1zEetwyiKc9s2moAnJYTcD73K3YAoZp9lnFyd653tqPeWD1L/7LkrWBqes+O?=
 =?us-ascii?Q?nPO/crOZgL8bB73+4nzHmHB2DPxD2Nj9ZRqe64QRfUboQZVPwnmbyG1QBk07?=
 =?us-ascii?Q?9GwScjAN/DDP3WxBIH/0L52U4GYjO1HOAX/aiFnf52yN6AJ46ctcAE+5FsZg?=
 =?us-ascii?Q?A/XrG6dHigVB966yFgkaV2MS5CdD3uCB8kXMRDkMzjLcVnYVLha2pWIaZFAc?=
 =?us-ascii?Q?TdGFLVRSMYMNEXSHSN4pEvhdat7V94cLOi6TKsu4VR+UIvUzPCDmk8ZnWw09?=
 =?us-ascii?Q?WcShsSEJqpab5GFfUr8qz/adGg90Th4hTIA6qqvvk9mh9K6XBoh0hUqgkEA+?=
 =?us-ascii?Q?J/DX3sTUG5av4Em2+vk+gtCdUJDF0fajEPwO/FagfEmg6gNiNp0uw932M1mH?=
 =?us-ascii?Q?7vlwxpNLcd2BTffFI4EDWZtDgaEGwiSsZ/LGajzE5XoEloiyqLDfZ//3UWSg?=
 =?us-ascii?Q?cIBj4xUO4/Izkg7Npi/ePkgq38xbZ66MZwX5laKQDWmR3sXtGlSGpVXUBVgG?=
 =?us-ascii?Q?J7MehrxtGqdzZ3mbY2x9onqK+YyKsZNjiFSFcV04kK6xYuScdXmLJDT9LlVd?=
 =?us-ascii?Q?ovLweopzdp4afFUBkfJA/++d0179XLLjg4xXN3qkoRD9yuh02PxVhamXo/FP?=
 =?us-ascii?Q?L/Xl4bLzMVDDIPpxl+Z1rQPjy7MlTaztbNcRK0rGIHzNXIZS9kB0yWe0OZJb?=
 =?us-ascii?Q?1LgGETZrjMU6UbOAB6sn76dB8MdnhPDakMMogB2OqAQUnuZNraK7gCAqU13X?=
 =?us-ascii?Q?IDT/s7JGaYn1FQxFmXihUAC25s/+Jbf4nhR7YKNwY2nbXoA8CW2CVaO2tnCb?=
 =?us-ascii?Q?1FohD6nA7BhUYgCHhY93vJ3IAfzCBi0Navq9SO1UuqwzH076h0gBuPahyJBQ?=
 =?us-ascii?Q?cXjhdn0sHi7bB4872ddJmRE09XwtEqy9V5gPycgcs9dtyZZWt0guxU1sznBW?=
 =?us-ascii?Q?clSHP+suHTyb4WgW5fZRXZC1+r6Nc6tk23k+NuXu5GMdPYpv1FmLoZnG0M8/?=
 =?us-ascii?Q?xW/L6pw+DBeCVkTh17FeXhbf/RWZHZAQ3QpN6ciiStQ4rA8uB7rIsjR+Fuh9?=
 =?us-ascii?Q?JgS2zGIT3pdGlcO8zcf8U6OKFW2UVBqmNgpmtq30rhsff/4xDCVhSKTOZTIt?=
 =?us-ascii?Q?BwV12St9gYY48fPaCq68Z4J4OgrYQiTNrqnU9zXf5YkWA6LVE0VAIYCrEGvZ?=
 =?us-ascii?Q?jPFtIVvPSg77wInFxaNTN285vI3EnZp1RzUjrDn16+XTFfVGjxQtY+HzAi8m?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WcQIF6p5xbdD4Si+irC1WACgu4GlmkAvFmhVAjeV9WdwkAntTVmfa7PECeuQnrj06MEoN72kraPn4iUTTYzl85wICdRvTagTg1vZfbDxPiGCDxIKkIANRHgUxPxldW6zAPkPkX+7uSiSeXihCPjErMgk7rtaRNgsfnvmMxye5mGyrCXODzabRU2YEoND6osTH0yFf7DhgzRc9BYJCvrlGM+OXJwunlRuZh5vOWTqIb7zf4SAfOmy/538MFUfJbjTek7tQk8ZcqHmRBisDv0bWhCPi470mw5Edhn3/O5MXcWMWNwXaetFWw1JhcPydF4ne761o6GqcnikLxJY5nDdGiA8lOd+a8lNr5eGwRF4irkLP0BjwDn89IOpoWzwOuIxaJq4h5daqCltoDW0ouOr3y3SgSnMSggiiaE1hw42tuDp/fWeMWTUH+ByGSBlbwxL0Ae48KPhNsktMZKECvmT7myxPI9VHIpuNXhoFBHIwaMOJj0ydw1MfpT9mkoItslJTG7fwGo3ev21mvJuitaYde0VEVh88tEiL47V6u1fxbRMrHV2th/T/LJsQ37K+VU+ZuCpGg2pHQmVQ9g6Z/R6n9oWRGip8DT65TQ92DrIKnUBzHno2xRrk89K2cZyp4zJ1zLt8g+/Bwa5q+Rak5pDfGYg/pkXMxLBstp6pDWOh7p34YcKihUqRkDzDhkl8XU0zruRP1jKzJTlRcgyK7XK6nJCAl0Ssokj5EHuEfCmXpBXVrqPit3NPusVyn2xoQJIiWyk7U/eUgVwg48dEJe2LPrFH21UKO9n6Z4qm+WiD/oqSUZRCbFoY+CiBr0BVusZpf4K2+ENw5POuarvp/8dxvIGYNZfdnYSWTXoE+URP6fAhwudFL5XjbEplKI9gPNp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585ee571-3556-40da-3a69-08db99bb239a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 16:02:03.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gc6pzA1ycSzj3B4LWOPrDrLgL4C2EnZZSMvA5939nn1/NcRNIxKyAD3/0Wt8Ppdy/iuuypd937/lleX7KL6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100137
X-Proofpoint-GUID: J3RRchxkbK0ivDEkOJ44zFZKOA5hw577
X-Proofpoint-ORIG-GUID: J3RRchxkbK0ivDEkOJ44zFZKOA5hw577
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 11:42:50AM +0800, Chengming Zhou wrote:
> On 2023/8/10 05:49, Christoph Hellwig wrote:
> > Oh well.  I don't feel like we're going to find the root cause
> > given that its late in the merge window and I'm running out of
> > time I have to work due to the annual summer vacation.  Unless
> > someone like Chengming who knows the flush code pretty well
> > feels like working with chuck on a few more iterations we'll
> 
> Hi,
> 
> No problem, I can work with Chuck to find the root cause if Chuck
> has time too, since I still can't reproduce it by myself.
> 
> Maybe we should first find what's the status of the hang request?
> I can write a Drgn script to find if any request hang in the queue.
> 
> Christoph, it would be very helpful if you share some thoughts
> and directions.
> 
> 
> > have to revert it.  Which is going to be a very painful merge
> > with Chengming's work in the for-6.6 branch.
> > 
> 
> Maybe we can revert it manually if we still fail since that commit
> just let postflushes go to the normal I/O path, instead of going to
> the flush state machine.
> 
> So I think it should be fine if we just delete that case?
> 
> Chuck, could you please help to check this change on block/for-next?
> 
> Thanks!
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index e73dc22d05c1..7ea3c00f40ce 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -442,17 +442,6 @@ bool blk_insert_flush(struct request *rq)
>                  * Queue for normal execution.
>                  */
>                 return false;
> -       case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
> -               /*
> -                * Initialize the flush fields and completion handler to trigger
> -                * the post flush, and then just pass the command on.
> -                */
> -               blk_rq_init_flush(rq);
> -               rq->flush.seq |= REQ_FSEQ_PREFLUSH;
> -               spin_lock_irq(&fq->mq_flush_lock);
> -               fq->flush_data_in_flight++;
> -               spin_unlock_irq(&fq->mq_flush_lock);
> -               return false;
>         default:
>                 /*
>                  * Mark the request as part of a flush sequence and submit it

linux-block/for-next with the above hunk applied is not able to
reproduce the NFSD hangs on SATA devices.


-- 
Chuck Lever
