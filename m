Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 17:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352310AbiCXRf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352293AbiCXRf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 13:35:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F79AE52
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:34:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OGYjQO007608;
        Thu, 24 Mar 2022 17:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r9USmmr3xUW2eruT3eniELbHYvr26HnL0kNkitAOfeY=;
 b=TooCSOmUrkoJl4lw5/RXIhb2rWVJbWJg1Zw2aYDmv+0YofFV9EDGLFFlkvjl2cOGNxS3
 RxELbcuHuIsoFltRxoQ7jlLf/20m1fAwPsMZEBvXfACRPis3bFZaxt5XrnDrQ+kgbxOC
 zcBosTQC2Qyy+OWc9QuO1M4y12Fpz7yZO2V/1pebw0+4Jnz1J7krr4P8vwTzIa0n/RNI
 7djmdPGTL+NwTqJJjcYtE8gCRm0bl6rJA4LN/WyMFjAFEi03Rnhsbbj9292KQmFle0oX
 1G/BCi4UO0fST1kHm/dlbUAI+t5tnNtl56R8VjFv2KXhyl/a48WmuIafLa6ZNKqHshNn Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcvxfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 17:34:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OHGTh6092665;
        Thu, 24 Mar 2022 17:34:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3exawje4rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 17:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcP8PTGog+OoJTF7YQiOZrUGvv779KFU0AYRGEDavS+ONxGHeO5LqJCrsuSdFKV/asAO7iihD3clwPUofVAOe7Anf0xDEQsQHFqXF52K1yo8MvaioKOls1o1mVlRbPf3LBybFtAqv1YDG5YZ/gvtEPkLneyPRgXHMgw76D4U6esRNcnLJxbVSzSnm9UsFLeQexYLUZYitJhnr4xZx82Kve4/S/8+3/cHl1UF9JBMvKLaasAOa3Sh4ELJqqI/wCAykqz2xs8mtvdIz/P/F0OfhPJBBaIHjNMjjjem+t1woeyLOcR8uDMxx9pY0GD7H0D3J5Xj1xAttAHj2CDfOMMOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9USmmr3xUW2eruT3eniELbHYvr26HnL0kNkitAOfeY=;
 b=a+wVscFnPBDMYJ3UbUQNLfzoXdkTgw5fnZeisrBHpI70QRRSY0gCAiBQzu4hnxy8KPfu8pQ54NVupxy9LN2wi7lDdfsJLD3CIjt1cHzARqu5KkZLqpDSkvgvJLtjSZZy+4OwRIMFkEQhn3Zjjk13rlr1JhW9nY6S4SIOe7zQ8dHRLtJ/oBndkWU6njDxqOx4ZGc2L/bnacpHF/HVryMsMidmU+8h6ul1WK/wHF2j8JJkQskXpgfjNM7PlaeaIZjELrLmrpkn95gIa/O9J+dCLPCMvt1YhKTUvn8/j3zG8PIGufzpG0wjUfcRxvRlJgFp/bcSEozst650NCvAaTpkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9USmmr3xUW2eruT3eniELbHYvr26HnL0kNkitAOfeY=;
 b=aqSY4F0s+xiZoTVHFqyUjSnWNnurnbxXYEBIEuDPXiuxC/yif6yiphfjbCbyUn5ZXVG8DTqbXXmatwoIiKQwTnqYk9tja1s/Ik+G6W488DKNlV1FYkYVb7faH/czMeGKT67gE/s66HzCshBmPhy4LNc51hgLDj6knJ8CUK5O7oE=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CO1PR10MB4771.namprd10.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 17:34:07 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::6c4e:65d8:4e2d:d942]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::6c4e:65d8:4e2d:d942%7]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 17:34:07 +0000
Message-ID: <50bfac4d-5111-6724-4fca-4499627b909c@oracle.com>
Date:   Thu, 24 Mar 2022 10:34:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20220324140450.33148-2-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:805:de::37) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac3e1cb-67ca-4aa0-1d62-08da0dbc7f89
X-MS-TrafficTypeDiagnostic: CO1PR10MB4771:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB47715AFB196D1470516C909EF0199@CO1PR10MB4771.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DfchZs7H3fbEyWU5MM6jkt18llDg+Z3i035Xc2Mp7dketHQk2jFBNjWaknAejsDKpW9r2xKjmwER7RARyrxRFuH1LrccdBtJHfOfOpUqGtZV+4A/3+59nwBL8AlP7eOpoKTGhFyhGE+Y2BrbxPEFlDbxxqXA+6ck3X/tAxSbClO7eXXSBOm9O3uhRG4ARZ925x/fNvmJKevHmV5VUphUgi5vJOggPoKREVNmkfLHKmXJ4+49MIJcgTJ9i14HhRlx6K5UR6HgtB2nuWfOfLrm/6c1XbeRyqpFzXANaKsZz3d+RPSBVFlX6XQYB7dq5tyCmBKcvvu7MffjTfxmjS/05rlul1CKJD0fW4b4uGi81BDe0SziY5KEqT4CMwCkNnW814Inew3uJt8wu/mP+LcxMWTEtGzDuiY31GflmpFiJirKVYfXhK4Y/C3m+I0sCF2gVhcYKazFRiEkC2SPKKt6yQNOvcOF6Wxmo8O0I0d+ElKyIa030mDezFnUPC8Nkz9b0OJcaPMx0viKkx4SnJXcf4gKb0cFSI4aEBCW9yzKrkTbjvbCi/bXQohxwxBSyW0XEImSS3h5ddgnmcxYtH1bSDePZ68aH8PWr7dqpWmP5aMb6Rv5psmrhwxf/jnU8Szkwq9tnHAap4vZB7J5C68jnkp+QM2I32p3on9spfBUfx4AcHAKe8on8CXbkDhRw4w6oOrvlhl2Vklxgedqr00WB+AWlTqYDgynAxApvXjNbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6512007)(6506007)(53546011)(6666004)(2616005)(6486002)(83380400001)(26005)(31686004)(8936002)(36756003)(186003)(31696002)(44832011)(66946007)(86362001)(66476007)(66556008)(4326008)(2906002)(8676002)(5660300002)(38100700002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFscGlya3RNdEpUZFNLMG1jaDBpaWNqeGxxTWptUDNMWldvcWQzTFh6bmt1?=
 =?utf-8?B?eExxNjNWSElwaWZRd2lhN2pkL0ZkZ0hhUEhyNmp2M3NSYmd3VTR0UVpjd0E2?=
 =?utf-8?B?TnhEcEZkek5RL2pHdnl2cisveVlqR3o4amhra3lSbmZiOEhFTERlWFhYY3B3?=
 =?utf-8?B?MnE3dDVNczFOSGFYdS9hSDRYZTRXU25SWDZpVVlpa1EvZHFqVjVwS0RBNmxK?=
 =?utf-8?B?elFtTkxmZUJHbDdZdmlwZ2lySG9Pb3RuYUdGM3BRbWhtVXc2MW9sU21IdEhY?=
 =?utf-8?B?cUZVRW9ZQno2T0oyMWxKUFNFNlp1S3FRWEllUjh5UU9SOTZNdlFSZVFpaWRs?=
 =?utf-8?B?d2R5MW9GckJFdWpRcDFiZ2xWUlRZWUgvczR4UVRRZzdjU05rb2V0cVU1d3cz?=
 =?utf-8?B?YjhMMkhNVW85azVaRWVZR0I1UkZ2NEtGR1EvVFNBVllYRDlOaVNPdlp1ZkpL?=
 =?utf-8?B?RmU0cERhTVVIM2RJYmVuRERFdXY3ZENLZ2QrLytkeHN3K0doL2hyM0pwNGxC?=
 =?utf-8?B?aUhqUFR4dXM3UlN1N3FZVnczdG1aOS8vbGkzaVFveFNZWmdBdjhFbzVUdDNs?=
 =?utf-8?B?elM3T2FFTGFRUUx2T3hEVGRVOU9LSGtGS0Jnd2FBSE5hYmxKbzhFTmNQTmdW?=
 =?utf-8?B?SnJQdXoxSmhFanJ1eTB3c3FlMy9uZUVvRk1VQjFyTkRzSHQ2TnEzZ0xxQUVC?=
 =?utf-8?B?b1hlUW5GM21SZzdKYTZ0bkZGK3Ewa2w4SjhzLzIyeHpBZklCMHJySlZ4dFlN?=
 =?utf-8?B?QkpUSW5VVjFML29kK250ZnZRMmdiVmdjK05TUkd0SXVQYmtERUprKzR6TklK?=
 =?utf-8?B?OEJFSi81Y3ZvSW9TQlNzWXFzMGhkQ29zTFo3WTZDWnA4UVJlNmwzUnhaTVVT?=
 =?utf-8?B?VDlxdnhtbHBvbVV1dHpnL0NJejFWSTRZYldJVTM5aTdQQW8xbURseGhOZHA5?=
 =?utf-8?B?d1p4UEo1QVo5bXN5K2h6VTRmMmRRdlpCYUJPZFdRMVRnVEhnVkdyZFJuMStZ?=
 =?utf-8?B?V2wvdXRCaFloU0lXRG1LOFhGS1dHVUVMNnJ1OGx0K2RrQnFtZmQ2MnlQUnc4?=
 =?utf-8?B?d21hRk1rMTJMRmZZd2F2eVJrbFBzVmdNYTFTQ2dEckFPVUFGSi9hSGwxUnUz?=
 =?utf-8?B?Y0hkeDgrdFYyWVEyOUM0cHZCb0NyQzBrSEloMW1ocVk3aTFWYk5nbE5SWUdO?=
 =?utf-8?B?aWRZcmtJWnowdnBVYWhNTlBsMDRaRStzaFlqUnBzSmpQZUl0cHRBVTV6aDZK?=
 =?utf-8?B?MFdyQVVxdHZGMTlhRHhLREVRZTFYV3JaWlhpWEtrSjI3QXFua0ZoOG96Q2VF?=
 =?utf-8?B?aytQK3c2UjdXUytpZzh4RUxqdklteFN2WnowYWV0UXJsY0RiVExmM1EwSUU3?=
 =?utf-8?B?aW9FaGJlV3h1SEFCNjhLb3NMdlVncFQ3UEh6MjkyaGJUejhCUm9jdXRpamFx?=
 =?utf-8?B?a2RZOVdRMlBoV1NKNk91Vy9LQ29jNE1PRnRxbnJZMGNlUWVDNTQxS1YrT1pU?=
 =?utf-8?B?L09GbU5zcVlSMm1rQ3kwYjQ5QWFmcGJsSk1oRXhvaUhRUm9GZXRBS3pmdy9H?=
 =?utf-8?B?eS81T1gvWFh5MExXelRnWWluZkdvUlNPdjVrZnNSUWU0L0dmbnNXNUFDVXRk?=
 =?utf-8?B?eEVXSFNudWxhTVhIT3J0SGV5R25UQTZFaGlTRFRnamxEazkwTkt4ZDBmZ1Vt?=
 =?utf-8?B?d0xHTDVTUVhWcXdKRGFteFk5TWR5Y2Znd200NkkrbTY0N0tneTZ3N0FQaUVw?=
 =?utf-8?B?bGRyb0poNGZZc1IwQlJ0bzd5cTNkQmIyNksvMDRrazR0ZVJmdEVNTnJnVzlZ?=
 =?utf-8?B?YzB4VWo4dXdva0xhdU9qb2tOTExYN01lQXRDRGEyNHVIbjgwWHUvcmhCQlF3?=
 =?utf-8?B?cllNMU9UMk5TSC83YjNIS1RGdXAyUFFZbzdVZWNDYUpUalNEZEQycnhJazR0?=
 =?utf-8?B?SjliSFVVUXlBYTNUZFJtbTBocTA3dlVsZlVNMy96MkJKM2FIOFpDYWVNVUdK?=
 =?utf-8?B?QlF6UUlwdll3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac3e1cb-67ca-4aa0-1d62-08da0dbc7f89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 17:34:07.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQYd0qVj9c7tPp6DMn9ClAXOwoeXCPNfYvfFeca/iEOUjtzu79NagOowMhLlV5kkpDRg1JdEiOz/LAzFPkNaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4771
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240096
X-Proofpoint-GUID: ocwglE5efA6nlgbuHOTmuqFZULvEKpjH
X-Proofpoint-ORIG-GUID: ocwglE5efA6nlgbuHOTmuqFZULvEKpjH
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Suwan,

The NVMe prints something like below by nvme_setup_io_queues() to confirm
if the configuration takes effect.

"[ 0.620458] nvme nvme0: 4/0/0 default/read/poll queues".

How about to print in virtio-blk as well?

Thank you very much!

Dongli Zhang


On 3/24/22 7:04 AM, Suwan Kim wrote:
> This patch supports polling I/O via virtio-blk driver. Polling
> feature is enabled by module parameter "num_poll_queues" and it
> sets dedicated polling queues for virtio-blk. This patch improves
> the polling I/O throughput and latency.
> 
> The virtio-blk driver doesn't not have a poll function and a poll
> queue and it has been operating in interrupt driven method even if
> the polling function is called in the upper layer.
> 
> virtio-blk polling is implemented upon 'batched completion' of block
> layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> and later, virtblk_complete_batch() calls unmap function and ends
> the requests in batch.
> 
> virtio-blk reads the number of poll queues from module parameter
> "num_poll_queues". If VM sets queue parameter as below,
> ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> queues, the poll queues have no callback function.
> 
> Regarding HW-SW queue mapping, the default queue mapping uses the
> existing method that condsiders MSI irq vector. But the poll queue
> doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> 
> For verifying the improvement, I did Fio polling I/O performance test
> with io_uring engine with the options below.
> (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> queues for VM.
> 
> As a result, IOPS and average latency improved about 10%.
> 
> Test result:
> 
> - Fio io_uring poll without virtio-blk poll support
> 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> 
> - Fio io_uring poll with virtio-blk poll support
> 	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
> 	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
> 	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 8c415be86732..3d16f8b753e7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
>  		 "0 for no limit. "
>  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
>  
> +static unsigned int num_poll_queues;
> +module_param(num_poll_queues, uint, 0644);
> +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>  
> @@ -81,6 +85,7 @@ struct virtio_blk {
>  
>  	/* num of vqs */
>  	int num_vqs;
> +	int io_queues[HCTX_MAX_TYPES];
>  	struct virtio_blk_vq *vqs;
>  };
>  
> @@ -548,6 +553,7 @@ static int init_vq(struct virtio_blk *vblk)
>  	const char **names;
>  	struct virtqueue **vqs;
>  	unsigned short num_vqs;
> +	unsigned int num_poll_vqs;
>  	struct virtio_device *vdev = vblk->vdev;
>  	struct irq_affinity desc = { 0, };
>  
> @@ -556,6 +562,7 @@ static int init_vq(struct virtio_blk *vblk)
>  				   &num_vqs);
>  	if (err)
>  		num_vqs = 1;
> +
>  	if (!err && !num_vqs) {
>  		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
>  		return -EINVAL;
> @@ -565,6 +572,13 @@ static int init_vq(struct virtio_blk *vblk)
>  			min_not_zero(num_request_queues, nr_cpu_ids),
>  			num_vqs);
>  
> +	num_poll_vqs = min_t(unsigned int, num_poll_queues, num_vqs - 1);
> +
> +	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
> +	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> +	vblk->io_queues[HCTX_TYPE_READ] = 0;
> +	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
> +
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
>  		return -ENOMEM;
> @@ -578,8 +592,13 @@ static int init_vq(struct virtio_blk *vblk)
>  	}
>  
>  	for (i = 0; i < num_vqs; i++) {
> -		callbacks[i] = virtblk_done;
> -		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +		if (i < num_vqs - num_poll_vqs) {
> +			callbacks[i] = virtblk_done;
> +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +		} else {
> +			callbacks[i] = NULL;
> +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> +		}
>  		names[i] = vblk->vqs[i].name;
>  	}
>  
> @@ -728,16 +747,87 @@ static const struct attribute_group *virtblk_attr_groups[] = {
>  static int virtblk_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct virtio_blk *vblk = set->driver_data;
> +	int i, qoff;
> +
> +	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
> +		struct blk_mq_queue_map *map = &set->map[i];
> +
> +		map->nr_queues = vblk->io_queues[i];
> +		map->queue_offset = qoff;
> +		qoff += map->nr_queues;
> +
> +		if (map->nr_queues == 0)
> +			continue;
> +
> +		/*
> +		 * Regular queues have interrupts and hence CPU affinity is
> +		 * defined by the core virtio code, but polling queues have
> +		 * no interrupts so we let the block layer assign CPU affinity.
> +		 */
> +		if (i == HCTX_TYPE_DEFAULT)
> +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> +		else
> +			blk_mq_map_queues(&set->map[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void virtblk_complete_batch(struct io_comp_batch *iob)
> +{
> +	struct request *req;
> +	struct virtblk_req *vbr;
>  
> -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -					vblk->vdev, 0);
> +	rq_list_for_each(&iob->req_list, req) {
> +		vbr = blk_mq_rq_to_pdu(req);
> +		virtblk_unmap_data(req, vbr);
> +		virtblk_cleanup_cmd(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> +{
> +	struct virtio_blk_vq *vq = hctx->driver_data;
> +	struct virtblk_req *vbr;
> +	unsigned long flags;
> +	unsigned int len;
> +	int found = 0;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> +		struct request *req = blk_mq_rq_from_pdu(vbr);
> +
> +		found++;
> +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))
> +			blk_mq_complete_request(req);
> +	}
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +
> +	return found;
> +}
> +
> +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> +			  unsigned int hctx_idx)
> +{
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> +
> +	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> +	hctx->driver_data = vq;
> +	return 0;
>  }
>  
>  static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rq	= virtio_queue_rq,
>  	.commit_rqs	= virtio_commit_rqs,
> +	.init_hctx	= virtblk_init_hctx,
>  	.complete	= virtblk_request_done,
>  	.map_queues	= virtblk_map_queues,
> +	.poll		= virtblk_poll,
>  };
>  
>  static unsigned int virtblk_queue_depth;
> @@ -816,6 +906,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
>  	vblk->tag_set.driver_data = vblk;
>  	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> +	vblk->tag_set.nr_maps = 1;
> +	if (vblk->io_queues[HCTX_TYPE_POLL])
> +		vblk->tag_set.nr_maps = 3;
>  
>  	err = blk_mq_alloc_tag_set(&vblk->tag_set);
>  	if (err)
