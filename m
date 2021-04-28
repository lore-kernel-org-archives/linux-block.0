Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A7EC433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CFF61446
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhD1VKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 17:10:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhD1VKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 17:10:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SL9SNx000840;
        Wed, 28 Apr 2021 21:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JlXWq/cItHMGrYj1eiuY6NTg24fA3Z9q1xeFayR5Qg8=;
 b=yLpjIgHm/IDAt4ROdBqAAHfuIUG45LVXPAxPPLHrhzPpECnlRRyH5UylyQtIr5tjBf7L
 3z/soaC8swySLNjbcjZn+L2LcDNSCZqsuAdO2uhX3Yk5jEGsTn6SxC1gLQ1uu6hL2/5o
 5GyGPqPHyvpNilYWI41JEnWN7wU9b+3o+S/cH16F/sO9U8eMM7OP6Fn6O1ZzDB9D+hCm
 6oPcS7Qmy+MjPVHh1nJP8XY2RiOFemL97pOxmTjqDWsZ9vraMDNPYh8FYNnFtUvG/eGz
 gljMXHedWQHMP27DVpo5a7j8FSd3mFjfviDZGA9oDMRos+8entmIMvSF0CoMPeRkr0vi qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 385afq2dh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 21:09:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SKxp9V051619;
        Wed, 28 Apr 2021 21:09:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by aserp3020.oracle.com with ESMTP id 384b5975xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 21:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoB2DJK1LyJPopZq+kM8LznCNt4yFkItFHjZHCI08w9LUpwtohr20LffuCBGEgJQB1PAV8iFwMzcJbGiTAFIEV0xOpjsFkAWuRO9gPnQWZqC30IJKg9Rayl6u2lVhz0Z58my6esmKTOxlT98Dy0WRp5FThV2tUgSd0ZZuLEM5B9QFZPYLf5t3kL0jSQCQNxCr6RD+IMTsScTYf9SI1InBk/huAk0skET2hrE9o32Nvymw/TA2IeL6pRXANY64+lJsoJY5vJ3icIQcCZZUQ8gRwihHznnM3Q+D6rkiv0EpsUPEYltSaS9o30YrsWGDs4OC/71MK4oZlhG9Xp9jLiTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiOXP7UB5qKREnHN1t2+UxFu3RKjU7KPsRdv4CC4Zno=;
 b=Gkh0tefvjsB8yRViGBo/0zKFWZB+02PUfRT/2oDNyfSy5FgOFm3248uxpR1ZGTdHtu/yuU0SP0VBR8c1c9lRB8A4deumdwuM3FUBMB3nmsZs6C9ZcfLx9iY3j/OQsmzTKZ5XP/020CuClq8gwALUVUbYI9CH99vr7IDaZqcELDHyMO4C/4NxG1QZFngXJkw4m1qSQEJCjTKs2Rhid8Du0Mw2jShHd0fzZpKA/2HQjka4xo5IdiQ1SEUd2pqQZ5IS6sm055ZxKG+hZJOPn9BffHIVh4/gJEVzYYNz2B2HWHnXKR/Hbpqzw7V1+YjpczJgFf/8JX757CwPukxCsXkSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiOXP7UB5qKREnHN1t2+UxFu3RKjU7KPsRdv4CC4Zno=;
 b=hbzzh3ZCupJdgBcT8kjd6wrjh/mCjHSo7Tn7nVYCITQvUa9j4bnGgI3myHwpZthdyhU0swUZ0rrcxgm3isAnq4JBajmi7fehcQgfB612qIQEAltmXVtK4mlNVp/Vm87ZQzJ+ib+4fKZJsc0DLkrBX4Znd3RNHAbNxF6bC7WhXyE=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BY5PR10MB3795.namprd10.prod.outlook.com (2603:10b6:a03:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 21:09:40 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 21:09:39 +0000
Subject: Re: [block] 658f2fb7d2:
 fxmark.hdd_f2fs_dbench_client_72_directio.works/sec -21.4% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20210423025518.GA13944@xsang-OptiPlex-9020>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <48f516b8-8c33-e0eb-b608-401a100238f1@oracle.com>
Date:   Wed, 28 Apr 2021 14:08:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210423025518.GA13944@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-252-35.vpn.oracle.com (73.231.9.254) by BY3PR10CA0022.namprd10.prod.outlook.com (2603:10b6:a03:255::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 21:09:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c114d0ac-d0d7-4280-80b5-08d90a89efa3
X-MS-TrafficTypeDiagnostic: BY5PR10MB3795:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3795A72713016D1B09FF619AE8409@BY5PR10MB3795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7HS1eEeKp6CU5V+wV63C1dereDl2g5c6gg2cytogPibpOIxQmfi4OJmI4K0F4Q6NSs6Vkyobmuf/OtWWkcYjgHLNYCYO83C/gPRShWeAoBjCufTH+0w1HYpLndks/YxWw4rnV4hO41fmMeq0MhBnMHhh/Tr48I/Kubc+xSrOyJIRm1qpZW3TKR6Js/5JkNbsl4qHQqWU5lIYtE5CVpIGHmZEuaX12InvfkmV4WQQ8lz+pDtgbAZDVnKBn3hkAA01RBEjU9bz/I+lyDZG7r+gFMB+MhL3w4adTnKEZFmy3a1Y1gy3LIB18pOuhxpGY2Gf1w2vIfbCKcXBzGeGiYVwSd2URCf3H8tV+Biw4VheYaM4xf6JTVP7Q4vSSe63Gm7f2rRTeHNGcFqwYLzUJakPEo35jtBSTC0AQbK8KgLcTPraJ0Xo/2Rb5OHiLudddgQhJn87NlQQiSRv7xImjIy7KSywjLQ1bR6b4qG2u3Y6djGyR0WG5WwiuoIONM5ykEnWeW1qicFzm7LviNbZSZ+aE5qEuWGwR3vKhX+jKxcG3FT7TRMz/g3BRazz4Hx7q61TiTGRD/GOJ+uM+fRFMr6tEOa95v3+i3hZJmuXlr2NCmW71tVLY83nCFLYMP88KMfYUZ3cdRmEOLLe9QYGXzWgkziYqw2VrON/y1v1Ru5JA6HFewgrJV0F+CAqs3L+6JR32u8BQ+3bg4ZugYVHC2YWe+2GmznhmA4uy+eliCvZZwtAVZIl5sJOdqMhM7OqDkuyR8liqI3wb5uLOKnv76uWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(376002)(136003)(2616005)(31696002)(956004)(86362001)(4326008)(30864003)(83380400001)(53546011)(54906003)(8676002)(6916009)(7696005)(36756003)(66476007)(186003)(316002)(16526019)(478600001)(66556008)(966005)(2906002)(8936002)(44832011)(26005)(31686004)(6486002)(5660300002)(38100700002)(66946007)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?inGtKSZ3ULl8aB1kxTa8RvE4O3dU9Pn9mNVHmMmc0S5TTxILCbIm+fsP?=
 =?Windows-1252?Q?fwxIFOgyMWlhp5dY0sH/D43sgRhPzR9lo1IczmhIXpD2bce+jeDcZddk?=
 =?Windows-1252?Q?EPtLQ68oC20LpywDKsO5YwO38dyx4ENhDZh33uGa7C2idGqYgdHEhLUh?=
 =?Windows-1252?Q?W8i3zGxIVa9/UliB1xmi4hDx1hPECKwF9J1/ohNRGIcBxzTyvcwVyr8k?=
 =?Windows-1252?Q?vqsPiZj/gcJM4TH22qI30vjq0cDSpwI9FnGAaTu/o8meYLEyDClz/z2Z?=
 =?Windows-1252?Q?E2XoRw9m3wFbkcKawzfVPHPhIKlsnyJHRoRUFtoSdUTBZlfJZGVXbgXH?=
 =?Windows-1252?Q?pcoUd5j3LWREZHEsJrBlzQ0ktMX19TWUxuyFckFO6ZkqqoUiA+SCFUKA?=
 =?Windows-1252?Q?8ldWi8yiYH4pvfBOOQau74FP0G39fX3QqX0vw/KNCjyRp7VhiN9HAOnS?=
 =?Windows-1252?Q?pE/mMqnYwwit/rWLjKCDuXCqbjpxmgJuTIasDblvfYXZo7NVMlsmq/S+?=
 =?Windows-1252?Q?nYJnE20Frzn6d7bnyODnRzxOu8jzE0FLE+LWuUZuTGfEUVKB6hhmFfwH?=
 =?Windows-1252?Q?JQiqrxmwXBYd09u2nCJxWlcHCO4j4VAuoiTpi/zRFtgIUF4xJf+xudsB?=
 =?Windows-1252?Q?pAI9XJwberF+e7gWcIT0L0b+P9vJZHBD5dgwMOaxH4NURWCFepyE2ok4?=
 =?Windows-1252?Q?rrFiS7Xs7Iggo7lW5sbjZPieopi3Lp2cdz0cSM//EyjfxZKkAs4NJOSB?=
 =?Windows-1252?Q?gZ6AGY1uitEusqTFFrJkjptEHFFVwTEsAldkib5VfwyqYxf5MTc+NBz/?=
 =?Windows-1252?Q?MtUftPkFRpl6iu/Qkj/wtau43LmD9pkUTikTofPiV0w65AhuG7Rn0gPr?=
 =?Windows-1252?Q?oPkq1r9pHguqt7adWAJjs7aCfnYoO+PWYlOQB2/+/tJopmR3Sdzyjl59?=
 =?Windows-1252?Q?rrg2tDcxXxbMWS9dW3W/ytMQNwXKc1KECCl52aS2NpMjTv6o4G3QDDHJ?=
 =?Windows-1252?Q?MPynVMH9M85oXf/a4xpEHOpcZo8PYKlXZ2XdKCnbSyrm3h7pdaDkLQp6?=
 =?Windows-1252?Q?vudsYdymlV9r7CNNwpoBDcnu7Yp/671/CH9tJjTne8cBR/G3CEZbfce7?=
 =?Windows-1252?Q?hZXMuLMWGq8LlKwE75IGaQIYClpgNcqYNlcVJC2FTJqDR/w1rcJq5tWS?=
 =?Windows-1252?Q?CdNNGJaBtQX/KtO3uBx+SM1+OMZ9J/z6X2ctHpPWRAe/DAHfyzSB2K22?=
 =?Windows-1252?Q?VWvTKv2lQobUXl68U5hMQg1KkKExE76tz6cBmHJLLCN2NnxYTpTaw4YH?=
 =?Windows-1252?Q?mSCbBgA8PGSvMEsZGuMlpEb2v5sosp+cvA9ksBRSbjY0aiDK6YwT1Szy?=
 =?Windows-1252?Q?gTISqY40g30bRGxKzZgeBWR80NlEvYbZZgPPOTf2+9bwkIKOrX7uLShX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c114d0ac-d0d7-4280-80b5-08d90a89efa3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 21:09:39.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5QOaTk7mBLAxMIwDQqmyb88A9wIhv8ETWl86io2Mzini5p1pebXx/If4m780cbxRLozdkOSLwnVj8QnkrZtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3795
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280136
X-Proofpoint-ORIG-GUID: rmo7Hcm1H47E5lIGjucyDNBf2J6hMPnQ
X-Proofpoint-GUID: rmo7Hcm1H47E5lIGjucyDNBf2J6hMPnQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I am struggling setup a working lkp env from ol8, still not working yet, 
dbench not build as rpc header file not exist. Is there any way that i 
can run the test case manually?

Thanks,

Junxiao.

On 4/22/21 7:55 PM, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed a -21.4% regression of fxmark.hdd_f2fs_dbench_client_72_directio.works/sec due to commit:
>
>
> commit: 658f2fb7d2139d7a218083b7e8688dd288c6512d ("[PATCH] block: fix io hung by block throttle")
> url: https://github.com/0day-ci/linux/commits/Junxiao-Bi/block-fix-io-hung-by-block-throttle/20210415-052219
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
>
> in testcase: fxmark
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> with following parameters:
>
> 	disk: 1HDD
> 	media: hdd
> 	test: dbench_client
> 	fstype: f2fs
> 	directio: directio
> 	cpufreq_governor: performance
> 	ucode: 0x11
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install                job.yaml  # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml
>          bin/lkp run                    compatible-job.yaml
>
> =========================================================================================
> compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
>    gcc-9/performance/directio/1HDD/f2fs/x86_64-rhel-8.3/hdd/debian-10.4-x86_64-20200603.cgz/lkp-knm01/dbench_client/fxmark/0x11
>
> commit:
>    901b8e44f6 ("Merge branch 'for-5.13/io_uring' into for-next")
>    658f2fb7d2 ("block: fix io hung by block throttle")
>
> 901b8e44f6b08436 658f2fb7d2139d7a218083b7e86
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>       66.02 ±  2%     -14.2%      56.65 ±  3%  fxmark.hdd_f2fs_dbench_client_36_directio.sys_sec
>        3.04 ±  2%     -14.3%       2.61 ±  3%  fxmark.hdd_f2fs_dbench_client_36_directio.sys_util
>       19.47 ±  3%     -13.4%      16.85 ±  3%  fxmark.hdd_f2fs_dbench_client_36_directio.user_sec
>        0.90 ±  3%     -13.5%       0.78 ±  3%  fxmark.hdd_f2fs_dbench_client_36_directio.user_util
>      128.18 ±  2%     -18.2%     104.90 ±  5%  fxmark.hdd_f2fs_dbench_client_36_directio.works/sec
>        8.65            -9.0%       7.87 ±  3%  fxmark.hdd_f2fs_dbench_client_54_directio.softirq_sec
>        0.27            -9.1%       0.24 ±  3%  fxmark.hdd_f2fs_dbench_client_54_directio.softirq_util
>      103.82 ±  3%     -20.8%      82.22 ±  3%  fxmark.hdd_f2fs_dbench_client_54_directio.sys_sec
>        3.19 ±  3%     -20.9%       2.52 ±  3%  fxmark.hdd_f2fs_dbench_client_54_directio.sys_util
>       29.38 ±  2%     -18.4%      23.98        fxmark.hdd_f2fs_dbench_client_54_directio.user_sec
>        0.90 ±  2%     -18.5%       0.74        fxmark.hdd_f2fs_dbench_client_54_directio.user_util
>      162.84 ±  4%     -24.8%     122.39 ±  3%  fxmark.hdd_f2fs_dbench_client_54_directio.works/sec
>       10.29            -8.7%       9.40 ±  3%  fxmark.hdd_f2fs_dbench_client_72_directio.softirq_sec
>        0.24            -8.8%       0.22 ±  3%  fxmark.hdd_f2fs_dbench_client_72_directio.softirq_util
>      132.66 ±  2%     -19.3%     107.01 ±  2%  fxmark.hdd_f2fs_dbench_client_72_directio.sys_sec
>        3.05 ±  2%     -19.4%       2.46 ±  2%  fxmark.hdd_f2fs_dbench_client_72_directio.sys_util
>       29.72 ±  3%     -18.2%      24.31 ±  2%  fxmark.hdd_f2fs_dbench_client_72_directio.user_sec
>        0.68 ±  3%     -18.3%       0.56 ±  2%  fxmark.hdd_f2fs_dbench_client_72_directio.user_util
>      183.55 ±  3%     -21.4%     144.32 ±  3%  fxmark.hdd_f2fs_dbench_client_72_directio.works/sec
>    26566804            -9.9%   23936362        fxmark.time.file_system_outputs
>       72184            -2.6%      70322        fxmark.time.involuntary_context_switches
>       88.33           -15.9%      74.29        fxmark.time.percent_of_cpu_this_job_got
>      357.13           -15.9%     300.26        fxmark.time.system_time
>       91.39           -14.5%      78.18        fxmark.time.user_time
>      930788 ±  3%     -30.6%     645881 ±  2%  fxmark.time.voluntary_context_switches
>        9.40            -2.7%       9.14        iostat.cpu.system
>        2.70            -2.0%       2.64        iostat.cpu.user
>        6281 ±  6%     -21.4%       4939 ±  8%  meminfo.Active(anon)
>       71273 ±  4%     -20.3%      56818 ±  7%  meminfo.Shmem
>        6267 ±  5%     -21.1%       4946 ±  8%  numa-meminfo.node0.Active(anon)
>       71236 ±  4%     -20.2%      56833 ±  7%  numa-meminfo.node0.Shmem
>        6729           -12.4%       5897        vmstat.io.bo
>        6385 ±  2%     -17.6%       5262        vmstat.system.cs
>        6088 ±  2%     -18.6%       4958        perf-stat.i.context-switches
>      176.01           -15.1%     149.46        perf-stat.i.cpu-migrations
>        6074 ±  2%     -18.6%       4945        perf-stat.ps.context-switches
>      175.89           -15.1%     149.36        perf-stat.ps.cpu-migrations
>        1570 ±  6%     -21.5%       1233 ±  8%  numa-vmstat.node0.nr_active_anon
>     2302914           -11.0%    2050036        numa-vmstat.node0.nr_dirtied
>       17815 ±  4%     -20.3%      14202 ±  7%  numa-vmstat.node0.nr_shmem
>      540895           -14.6%     461814        numa-vmstat.node0.nr_written
>        1570 ±  6%     -21.5%       1233 ±  8%  numa-vmstat.node0.nr_zone_active_anon
>        2679 ±  4%     -15.2%       2272 ±  4%  slabinfo.dmaengine-unmap-16.active_objs
>        3266 ±  7%     -13.0%       2841 ±  4%  slabinfo.dmaengine-unmap-16.num_objs
>        5826 ±  4%     -12.6%       5093 ±  3%  slabinfo.ext4_io_end.active_objs
>        5994 ±  4%     -12.3%       5257 ±  3%  slabinfo.ext4_io_end.num_objs
>       18698 ±  2%      -9.5%      16920        slabinfo.ext4_pending_reservation.active_objs
>       18783 ±  2%      -9.5%      17007        slabinfo.ext4_pending_reservation.num_objs
>       32425 ±  2%     -11.6%      28671 ±  2%  slabinfo.f2fs_free_nid.active_objs
>       32622 ±  2%     -11.6%      28825 ±  2%  slabinfo.f2fs_free_nid.num_objs
>        1584 ±  5%     -22.1%       1233 ±  8%  proc-vmstat.nr_active_anon
>       20434            -2.0%      20027        proc-vmstat.nr_active_file
>     3316154            -9.9%    2986902        proc-vmstat.nr_dirtied
>      405121            -0.9%     401332        proc-vmstat.nr_file_pages
>       82265            -4.4%      78653        proc-vmstat.nr_inactive_anon
>       17866 ±  4%     -20.2%      14252 ±  7%  proc-vmstat.nr_shmem
>      850118           -12.4%     744638        proc-vmstat.nr_written
>        1584 ±  5%     -22.1%       1233 ±  8%  proc-vmstat.nr_zone_active_anon
>       20434            -2.0%      20027        proc-vmstat.nr_zone_active_file
>       82265            -4.4%      78653        proc-vmstat.nr_zone_inactive_anon
>     4971269            -6.1%    4667688        proc-vmstat.numa_hit
>     4971268            -6.1%    4667687        proc-vmstat.numa_local
>      293150            -4.6%     279668        proc-vmstat.pgactivate
>     5110253            -5.9%    4808331        proc-vmstat.pgalloc_normal
>      144088           -17.3%     119141        proc-vmstat.pgdeactivate
>     5087969            -5.8%    4791351        proc-vmstat.pgfree
>     3400472           -12.4%    2978555        proc-vmstat.pgpgout
>      126836           -16.8%     105510        proc-vmstat.pgrotated
>      616731            -5.1%     585318        interrupts.CAL:Function_call_interrupts
>        6785 ±  4%     -11.8%       5983 ±  4%  interrupts.CPU11.CAL:Function_call_interrupts
>        6543 ±  3%     -12.3%       5735 ±  3%  interrupts.CPU17.CAL:Function_call_interrupts
>       34.17 ± 19%    +185.6%      97.57 ±108%  interrupts.CPU18.TLB:TLB_shootdowns
>      402.33 ± 33%     -42.1%     232.86 ± 21%  interrupts.CPU2.NMI:Non-maskable_interrupts
>      402.33 ± 33%     -42.1%     232.86 ± 21%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>        5327 ±  6%     -15.6%       4496 ±  6%  interrupts.CPU20.CAL:Function_call_interrupts
>        5017 ±  4%     -12.6%       4384 ±  6%  interrupts.CPU21.CAL:Function_call_interrupts
>        5106 ±  4%     -12.6%       4461 ±  6%  interrupts.CPU22.CAL:Function_call_interrupts
>        5046 ±  3%     -13.0%       4389 ±  5%  interrupts.CPU25.CAL:Function_call_interrupts
>        5126 ±  2%     -13.7%       4422 ±  5%  interrupts.CPU26.CAL:Function_call_interrupts
>        5025 ±  5%     -14.1%       4318 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
>        5074 ±  5%     -12.3%       4451 ±  4%  interrupts.CPU28.CAL:Function_call_interrupts
>        4985 ±  3%     -12.0%       4386 ±  3%  interrupts.CPU29.CAL:Function_call_interrupts
>        5168 ±  7%     -14.2%       4436 ±  6%  interrupts.CPU31.CAL:Function_call_interrupts
>        5390 ± 10%     -16.7%       4492 ±  8%  interrupts.CPU33.CAL:Function_call_interrupts
>        4929 ±  2%     -11.1%       4379 ±  5%  interrupts.CPU34.CAL:Function_call_interrupts
>        4942 ±  3%     -11.7%       4366 ±  5%  interrupts.CPU35.CAL:Function_call_interrupts
>        3625 ±  3%      -8.2%       3329 ±  5%  interrupts.CPU39.CAL:Function_call_interrupts
>        3658 ±  4%     -10.0%       3290 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
>        3825 ±  6%     -16.3%       3203 ±  6%  interrupts.CPU42.CAL:Function_call_interrupts
>        3665 ±  4%     -15.7%       3088 ± 10%  interrupts.CPU43.CAL:Function_call_interrupts
>        3664 ±  6%     -10.5%       3279 ±  6%  interrupts.CPU44.CAL:Function_call_interrupts
>        3788 ±  7%     -13.4%       3280 ±  4%  interrupts.CPU46.CAL:Function_call_interrupts
>        3895 ± 15%     -16.3%       3261 ±  4%  interrupts.CPU47.CAL:Function_call_interrupts
>        3945 ±  7%     -15.0%       3352 ±  5%  interrupts.CPU48.CAL:Function_call_interrupts
>        3838 ± 10%     -15.7%       3237 ±  4%  interrupts.CPU49.CAL:Function_call_interrupts
>        6927 ±  5%     -13.5%       5991 ±  8%  interrupts.CPU5.CAL:Function_call_interrupts
>        3459 ±  6%     -13.1%       3005 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
>        2564 ±  3%     -10.2%       2302 ±  7%  interrupts.CPU54.CAL:Function_call_interrupts
>        2517 ±  2%      -8.9%       2294 ±  6%  interrupts.CPU56.CAL:Function_call_interrupts
>        2517 ±  3%     -10.7%       2246 ±  7%  interrupts.CPU70.CAL:Function_call_interrupts
>       20310 ±  4%     -13.1%      17648 ±  8%  interrupts.NMI:Non-maskable_interrupts
>       20310 ±  4%     -13.1%      17648 ±  8%  interrupts.PMI:Performance_monitoring_interrupts
>        0.06 ± 91%     -86.0%       0.01 ±130%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.__get_node_page.f2fs_update_inode_page
>        0.04 ±  6%     +16.1%       0.05 ±  8%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
>        0.03 ±  9%    +110.0%       0.07 ± 97%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
>        0.67 ± 66%     -66.9%       0.22 ± 43%  perf-sched.sch_delay.max.ms.issue_flush_thread.kthread.ret_from_fork
>        0.19 ± 89%     -93.9%       0.01 ±127%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.__get_node_page.f2fs_update_inode_page
>        0.45 ± 43%     -56.5%       0.20 ± 68%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.f2fs_submit_merged_ipu_write.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback
>        8.98 ±198%     -93.0%       0.63 ± 28%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
>        0.08 ± 34%     -41.0%       0.05 ± 38%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
>       45.26 ±  6%     +28.5%      58.17 ±  7%  perf-sched.total_wait_and_delay.average.ms
>       61502 ±  6%     -27.7%      44475 ± 11%  perf-sched.total_wait_and_delay.count.ms
>       45.23 ±  6%     +28.5%      58.14 ±  7%  perf-sched.total_wait_time.average.ms
>        6.59 ± 10%     +39.7%       9.20 ± 10%  perf-sched.wait_and_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.f2fs_wait_on_page_writeback
>        4.48 ±  9%     -53.8%       2.07 ± 71%  perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.do_fsync
>        9.17 ± 14%     -31.8%       6.25 ± 11%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
>        7540 ± 11%     -26.6%       5536 ± 17%  perf-sched.wait_and_delay.count.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
>       19838 ±  8%     -35.6%      12768 ± 15%  perf-sched.wait_and_delay.count.io_schedule.wait_on_page_bit.wait_on_page_writeback.f2fs_wait_on_page_writeback
>      911.33 ±  6%     -29.8%     639.43 ± 10%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
>        2795 ±  6%     -43.1%       1589 ± 20%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback
>      491.67 ± 14%     -46.0%     265.29 ± 49%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
>        1726 ± 28%     -48.5%     889.29 ± 42%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
>      839.00 ± 31%     -59.6%     338.57 ± 56%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
>      509.67 ± 12%     -46.6%     272.00 ± 48%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
>      497.83 ± 12%     -58.8%     205.00 ± 67%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.do_fsync
>      267.17 ± 23%     -75.7%      64.86 ±128%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.f2fs_merge_page_bio.f2fs_inplace_write_data.f2fs_do_write_data_page
>        1539 ±  5%     -49.4%     779.14 ± 15%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page
>      791.00 ± 13%     -45.2%     433.57 ± 27%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
>      910.67 ± 20%     -54.1%     417.86 ± 38%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
>      856.83 ± 29%     -60.2%     341.14 ± 57%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
>        3465 ±  2%     -21.4%       2725 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file
>      142.28 ±  8%   +1126.8%       1745 ± 97%  perf-sched.wait_and_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
>        5186 ±  2%     +22.8%       6370 ± 11%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
>        6.56 ± 10%     +39.7%       9.17 ± 10%  perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.f2fs_wait_on_page_writeback
>       15.00 ± 88%     -75.6%       3.65 ±165%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.__get_node_page.f2fs_find_in_inline_dir
>        2.74 ± 17%     +90.3%       5.22 ± 24%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
>        4.46 ±  9%     -43.4%       2.52 ± 35%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.do_fsync
>        9.14 ± 14%     -32.3%       6.18 ± 12%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
>      142.23 ±  8%   +1127.2%       1745 ± 97%  perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
>       33.23 ± 80%     -62.6%      12.44 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.do_unlinkat.do_syscall_64
>       52.12 ± 53%     -73.9%      13.59 ±161%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.__get_node_page.f2fs_update_inode_page
>        5186 ±  2%     +22.8%       6370 ± 11%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
>       43.08 ±  8%      -8.5       34.60 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>       41.46 ±  9%      -8.2       33.29 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.91 ± 10%      -1.2        3.67 ± 12%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.94 ± 10%      -1.2        3.70 ± 12%  perf-profile.calltrace.cycles-pp.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.77 ± 11%      -1.2        3.57 ± 12%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.72 ± 11%      -1.2        3.53 ± 12%  perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64.do_syscall_64
>        5.97 ±  9%      -1.2        4.80 ± 11%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
>        6.06 ±  9%      -1.2        4.89 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        3.52 ± 13%      -0.9        2.60 ± 14%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        3.06 ± 12%      -0.8        2.30 ± 14%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64
>        2.62 ± 15%      -0.7        1.91 ± 16%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.52 ± 15%      -0.7        1.82 ± 16%  perf-profile.calltrace.cycles-pp.f2fs_evict_inode.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        3.45 ±  5%      -0.7        2.79 ± 11%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.16 ± 15%      -0.6        1.52 ± 15%  perf-profile.calltrace.cycles-pp.f2fs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
>        3.30 ±  6%      -0.6        2.67 ± 11%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.43 ±  9%      -0.6        1.84 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>        2.37 ±  9%      -0.6        1.80 ± 11%  perf-profile.calltrace.cycles-pp.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
>        2.19 ±  6%      -0.4        1.75 ± 10%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
>        1.39 ± 16%      -0.4        0.96 ± 17%  perf-profile.calltrace.cycles-pp.f2fs_do_add_link.f2fs_create.path_openat.do_filp_open.do_sys_openat2
>        1.34 ± 16%      -0.4        0.91 ± 18%  perf-profile.calltrace.cycles-pp.f2fs_add_dentry.f2fs_do_add_link.f2fs_create.path_openat.do_filp_open
>        1.33 ± 16%      -0.4        0.90 ± 18%  perf-profile.calltrace.cycles-pp.f2fs_add_inline_entry.f2fs_add_dentry.f2fs_do_add_link.f2fs_create.path_openat
>        1.71 ± 15%      -0.4        1.29 ± 12%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>        1.02 ± 14%      -0.4        0.60 ± 43%  perf-profile.calltrace.cycles-pp.f2fs_remove_inode_page.f2fs_evict_inode.evict.do_unlinkat.do_syscall_64
>        1.69 ± 15%      -0.4        1.27 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>        1.59 ±  7%      -0.4        1.18 ± 11%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
>        1.47 ±  9%      -0.4        1.06 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64
>        0.94 ± 14%      -0.4        0.54 ± 44%  perf-profile.calltrace.cycles-pp.truncate_node.f2fs_remove_inode_page.f2fs_evict_inode.evict.do_unlinkat
>        1.78 ± 10%      -0.4        1.42 ± 16%  perf-profile.calltrace.cycles-pp.ksys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.74 ± 11%      -0.3        1.39 ± 17%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.77 ± 15%      -0.3        0.45 ± 65%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
>        1.07 ±  7%      -0.3        0.75 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write
>        0.61 ±  9%      -0.3        0.31 ± 86%  perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.62 ± 12%      -0.3        0.32 ± 87%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.f2fs_evict_inode.evict.do_unlinkat.do_syscall_64
>        1.46 ± 10%      -0.3        1.18 ± 20%  perf-profile.calltrace.cycles-pp.f2fs_file_read_iter.new_sync_read.vfs_read.ksys_pread64.do_syscall_64
>        1.39 ± 10%      -0.3        1.11 ± 19%  perf-profile.calltrace.cycles-pp.filemap_read.f2fs_file_read_iter.new_sync_read.vfs_read.ksys_pread64
>        0.91 ±  8%      -0.3        0.64 ± 13%  perf-profile.calltrace.cycles-pp.f2fs_convert_inline_page.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write
>        1.40 ±  9%      -0.3        1.13 ± 15%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>        1.00 ± 15%      -0.2        0.77 ± 14%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.file_write_and_wait_range.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
>        0.95 ± 15%      -0.2        0.72 ± 15%  perf-profile.calltrace.cycles-pp.wait_on_page_writeback.__filemap_fdatawait_range.file_write_and_wait_range.f2fs_do_sync_file.do_fsync
>        0.94 ± 15%      -0.2        0.71 ± 15%  perf-profile.calltrace.cycles-pp.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range.file_write_and_wait_range.f2fs_do_sync_file
>        0.91 ± 15%      -0.2        0.70 ± 16%  perf-profile.calltrace.cycles-pp.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range.file_write_and_wait_range
>        0.90 ± 15%      -0.2        0.69 ± 15%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
>        1.16 ± 10%      -0.2        0.96 ± 15%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>        1.12 ±  9%      -0.2        0.93 ± 13%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
>        0.83 ±  9%      -0.2        0.66 ± 10%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
>        0.74 ±  9%      +0.1        0.88 ±  8%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start
>        0.82 ±  8%      +0.1        0.96 ±  7%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu
>        1.16 ±  4%      +0.2        1.38 ±  9%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
>        1.36 ±  4%      +0.2        1.61 ±  7%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        1.53 ±  4%      +0.3        1.84 ± 11%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
>        1.05 ±  5%      +0.3        1.36 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>        3.10 ±  2%      +0.7        3.80 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>        3.54 ±  2%      +0.7        4.26 ±  8%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>        3.35 ±  2%      +0.8        4.12 ± 10%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>        4.14 ±  3%      +0.8        4.97 ±  9%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       43.33 ±  7%      +8.1       51.42 ±  9%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       42.38 ±  7%      +8.2       50.54 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       42.46 ±  7%      +8.2       50.64 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       42.46 ±  7%      +8.2       50.64 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       48.00 ±  6%      -7.9       40.13 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       46.03 ±  7%      -7.6       38.47 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
>        8.17 ± 10%      -1.9        6.28 ± 10%  perf-profile.children.cycles-pp.__schedule
>        6.38 ±  9%      -1.5        4.89 ± 11%  perf-profile.children.cycles-pp.schedule
>        6.11 ± 10%      -1.3        4.77 ± 12%  perf-profile.children.cycles-pp.perf_tp_event
>        5.66 ±  9%      -1.3        4.33 ± 10%  perf-profile.children.cycles-pp.vfs_write
>        5.49 ±  9%      -1.3        4.20 ± 10%  perf-profile.children.cycles-pp.new_sync_write
>        5.86 ± 11%      -1.3        4.58 ± 12%  perf-profile.children.cycles-pp.perf_swevent_overflow
>        5.83 ± 11%      -1.3        4.55 ± 12%  perf-profile.children.cycles-pp.__perf_event_overflow
>        5.77 ± 11%      -1.3        4.50 ± 12%  perf-profile.children.cycles-pp.perf_event_output_forward
>        4.94 ± 10%      -1.2        3.70 ± 12%  perf-profile.children.cycles-pp.ksys_pwrite64
>        4.72 ± 11%      -1.2        3.53 ± 12%  perf-profile.children.cycles-pp.f2fs_file_write_iter
>        4.99 ± 11%      -1.2        3.81 ± 13%  perf-profile.children.cycles-pp.perf_prepare_sample
>        4.50 ± 11%      -1.1        3.40 ± 13%  perf-profile.children.cycles-pp.get_perf_callchain
>        4.52 ± 12%      -1.1        3.43 ± 13%  perf-profile.children.cycles-pp.perf_callchain
>        3.69 ± 12%      -1.0        2.73 ± 12%  perf-profile.children.cycles-pp.perf_callchain_kernel
>        3.52 ± 13%      -0.9        2.60 ± 14%  perf-profile.children.cycles-pp.do_unlinkat
>        3.54 ± 11%      -0.8        2.72 ± 12%  perf-profile.children.cycles-pp.__generic_file_write_iter
>        3.31 ± 13%      -0.8        2.55 ± 12%  perf-profile.children.cycles-pp.generic_perform_write
>        3.08 ± 10%      -0.7        2.35 ± 10%  perf-profile.children.cycles-pp.io_schedule
>        2.64 ± 15%      -0.7        1.93 ± 16%  perf-profile.children.cycles-pp.evict
>        2.53 ± 15%      -0.7        1.83 ± 16%  perf-profile.children.cycles-pp.f2fs_evict_inode
>        3.14 ±  9%      -0.7        2.44 ± 11%  perf-profile.children.cycles-pp.wait_on_page_writeback
>        2.93 ±  8%      -0.7        2.24 ± 11%  perf-profile.children.cycles-pp.f2fs_wait_on_page_writeback
>        3.11 ±  9%      -0.7        2.41 ± 11%  perf-profile.children.cycles-pp.wait_on_page_bit
>        1.45 ± 20%      -0.7        0.79 ± 22%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>        2.16 ± 15%      -0.6        1.52 ± 15%  perf-profile.children.cycles-pp.f2fs_create
>        3.93 ±  4%      -0.6        3.33 ± 10%  perf-profile.children.cycles-pp.__do_sys_newstat
>        3.79 ±  5%      -0.6        3.20 ± 10%  perf-profile.children.cycles-pp.vfs_statx
>        2.43 ±  9%      -0.6        1.84 ± 10%  perf-profile.children.cycles-pp.f2fs_wait_on_node_pages_writeback
>        3.30 ±  6%      -0.6        2.71 ± 10%  perf-profile.children.cycles-pp.link_path_walk
>        2.20 ± 13%      -0.6        1.65 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_switch
>        1.26 ± 11%      -0.5        0.74 ± 21%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>        1.54 ± 15%      -0.5        1.03 ± 17%  perf-profile.children.cycles-pp.do_write_page
>        0.98 ± 22%      -0.5        0.47 ± 18%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>        1.96 ± 13%      -0.5        1.47 ± 16%  perf-profile.children.cycles-pp.pagecache_get_page
>        2.11 ± 11%      -0.5        1.63 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
>        2.33 ± 11%      -0.5        1.85 ± 15%  perf-profile.children.cycles-pp.newidle_balance
>        1.45 ± 16%      -0.5        0.99 ± 16%  perf-profile.children.cycles-pp.f2fs_do_add_link
>        2.02 ± 11%      -0.4        1.57 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
>        1.39 ± 16%      -0.4        0.94 ± 17%  perf-profile.children.cycles-pp.f2fs_add_dentry
>        1.38 ± 16%      -0.4        0.94 ± 17%  perf-profile.children.cycles-pp.f2fs_add_inline_entry
>        1.74 ± 15%      -0.4        1.30 ± 12%  perf-profile.children.cycles-pp.schedule_idle
>        3.00 ±  5%      -0.4        2.58 ±  9%  perf-profile.children.cycles-pp.filename_lookup
>        1.48 ±  9%      -0.4        1.06 ±  8%  perf-profile.children.cycles-pp.f2fs_preallocate_blocks
>        1.78 ± 10%      -0.4        1.42 ± 16%  perf-profile.children.cycles-pp.ksys_pread64
>        1.02 ± 14%      -0.4        0.67 ± 18%  perf-profile.children.cycles-pp.f2fs_remove_inode_page
>        0.95 ± 14%      -0.3        0.60 ± 21%  perf-profile.children.cycles-pp.truncate_node
>        1.10 ± 16%      -0.3        0.75 ± 21%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
>        0.78 ± 19%      -0.3        0.44 ± 20%  perf-profile.children.cycles-pp.rwsem_wake
>        1.09 ±  7%      -0.3        0.76 ±  9%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
>        1.38 ± 11%      -0.3        1.06 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>        0.76 ± 20%      -0.3        0.44 ± 20%  perf-profile.children.cycles-pp.wake_up_q
>        1.50 ±  9%      -0.3        1.20 ± 17%  perf-profile.children.cycles-pp.filemap_read
>        0.81 ± 15%      -0.3        0.52 ± 16%  perf-profile.children.cycles-pp.f2fs_submit_page_write
>        0.63 ± 17%      -0.3        0.34 ± 42%  perf-profile.children.cycles-pp.f2fs_get_node_info
>        1.39 ± 12%      -0.3        1.10 ± 15%  perf-profile.children.cycles-pp.__unwind_start
>        0.52 ± 29%      -0.3        0.24 ± 50%  perf-profile.children.cycles-pp.osq_lock
>        1.46 ± 10%      -0.3        1.18 ± 20%  perf-profile.children.cycles-pp.f2fs_file_read_iter
>        1.19 ± 14%      -0.3        0.91 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
>        0.91 ±  8%      -0.3        0.64 ± 13%  perf-profile.children.cycles-pp.f2fs_convert_inline_page
>        0.95 ± 11%      -0.2        0.70 ± 15%  perf-profile.children.cycles-pp.__orc_find
>        1.18 ±  5%      -0.2        0.93 ±  7%  perf-profile.children.cycles-pp.__submit_merged_write_cond
>        1.00 ± 15%      -0.2        0.77 ± 14%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
>        2.31 ±  7%      -0.2        2.08 ± 10%  perf-profile.children.cycles-pp.walk_component
>        0.84 ± 12%      -0.2        0.63 ± 13%  perf-profile.children.cycles-pp.inode_permission
>        0.78 ± 11%      -0.2        0.57 ± 20%  perf-profile.children.cycles-pp.add_to_page_cache_lru
>        0.65 ± 12%      -0.2        0.46 ± 17%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
>        0.64 ± 11%      -0.2        0.45 ± 12%  perf-profile.children.cycles-pp.orc_find
>        0.36 ± 24%      -0.2        0.19 ± 25%  perf-profile.children.cycles-pp.f2fs_invalidate_blocks
>        0.53 ± 24%      -0.2        0.37 ± 16%  perf-profile.children.cycles-pp.generic_permission
>        0.58 ± 21%      -0.2        0.41 ± 13%  perf-profile.children.cycles-pp.finish_task_switch
>        0.76 ± 25%      -0.2        0.61 ± 12%  perf-profile.children.cycles-pp.kmem_cache_free
>        0.57 ± 10%      -0.1        0.43 ± 14%  perf-profile.children.cycles-pp.sched_ttwu_pending
>        0.52 ± 14%      -0.1        0.37 ± 18%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>        0.48 ± 24%      -0.1        0.34 ± 14%  perf-profile.children.cycles-pp.make_kuid
>        0.48 ± 14%      -0.1        0.35 ± 17%  perf-profile.children.cycles-pp.sysvec_call_function_single
>        0.60 ± 10%      -0.1        0.48 ± 15%  perf-profile.children.cycles-pp.__entry_text_start
>        0.32 ± 21%      -0.1        0.20 ± 21%  perf-profile.children.cycles-pp.filemap_get_pages
>        0.67 ± 14%      -0.1        0.55 ± 18%  perf-profile.children.cycles-pp.step_into
>        0.45 ± 24%      -0.1        0.34 ± 13%  perf-profile.children.cycles-pp.map_id_range_down
>        0.60 ± 10%      -0.1        0.49 ± 10%  perf-profile.children.cycles-pp.vfs_unlink
>        0.33 ± 13%      -0.1        0.24 ± 16%  perf-profile.children.cycles-pp.do_renameat2
>        0.24 ± 16%      -0.1        0.17 ± 24%  perf-profile.children.cycles-pp.aa_get_task_label
>        0.17 ± 26%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.filename_parentat
>        0.20 ± 15%      -0.1        0.14 ± 24%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>        0.09 ± 24%      -0.1        0.04 ± 63%  perf-profile.children.cycles-pp.xas_create
>        0.14 ± 10%      -0.1        0.09 ± 27%  perf-profile.children.cycles-pp.set_page_dirty
>        0.15 ± 18%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.path_parentat
>        0.12 ± 35%      -0.0        0.07 ± 25%  perf-profile.children.cycles-pp.truncate_cleanup_page
>        0.17 ±  9%      -0.0        0.12 ± 17%  perf-profile.children.cycles-pp.__f2fs_find_entry
>        0.14 ± 11%      -0.0        0.10 ± 25%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
>        0.11 ± 19%      -0.0        0.07 ± 49%  perf-profile.children.cycles-pp.set_task_cpu
>        0.26 ±  7%      -0.0        0.22 ± 17%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>        0.19 ± 14%      -0.0        0.14 ± 16%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>        0.15 ± 11%      -0.0        0.11 ± 15%  perf-profile.children.cycles-pp.f2fs_find_in_inline_dir
>        0.08 ± 18%      -0.0        0.04 ± 65%  perf-profile.children.cycles-pp.perf_trace_buf_update
>        0.12 ± 16%      -0.0        0.09 ± 26%  perf-profile.children.cycles-pp.__test_set_page_writeback
>        0.14 ± 13%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__mark_inode_dirty
>        0.15 ± 10%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.__list_add_valid
>        0.15 ± 14%      +0.0        0.20 ±  8%  perf-profile.children.cycles-pp.nr_iowait_cpu
>        0.30 ±  9%      +0.1        0.37 ± 11%  perf-profile.children.cycles-pp.mmput
>        0.29 ±  8%      +0.1        0.37 ± 10%  perf-profile.children.cycles-pp.exit_mmap
>        0.16 ± 11%      +0.1        0.23 ± 16%  perf-profile.children.cycles-pp.rb_next
>        0.03 ±100%      +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.sys_imageblit
>        0.03 ±100%      +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
>        0.18 ± 10%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.trigger_load_balance
>        0.50 ±  5%      +0.1        0.58 ± 11%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
>        0.05 ± 45%      +0.1        0.14 ± 42%  perf-profile.children.cycles-pp.vt_console_print
>        1.06 ±  7%      +0.2        1.26 ± 12%  perf-profile.children.cycles-pp.update_blocked_averages
>        1.43 ±  5%      +0.3        1.69 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
>        1.79 ±  5%      +0.4        2.20 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
>       43.33 ±  7%      +8.1       51.42 ±  9%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       43.33 ±  7%      +8.1       51.42 ±  9%  perf-profile.children.cycles-pp.cpu_startup_entry
>       43.32 ±  7%      +8.1       51.42 ±  9%  perf-profile.children.cycles-pp.do_idle
>       42.46 ±  7%      +8.2       50.64 ±  9%  perf-profile.children.cycles-pp.start_secondary
>        0.49 ± 28%      -0.3        0.23 ± 48%  perf-profile.self.cycles-pp.osq_lock
>        0.94 ± 11%      -0.3        0.69 ± 16%  perf-profile.self.cycles-pp.__orc_find
>        1.07 ±  7%      -0.2        0.85 ± 13%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>        0.60 ± 10%      -0.1        0.46 ± 16%  perf-profile.self.cycles-pp.__entry_text_start
>        0.29 ± 12%      -0.1        0.23 ± 15%  perf-profile.self.cycles-pp.__schedule
>        0.17 ± 15%      -0.1        0.12 ± 14%  perf-profile.self.cycles-pp.update_curr
>        0.14 ± 16%      -0.0        0.10 ± 20%  perf-profile.self.cycles-pp.path_init
>        0.21 ±  6%      -0.0        0.17 ± 14%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>        0.09 ± 18%      -0.0        0.05 ± 42%  perf-profile.self.cycles-pp.current_time
>        0.17 ±  8%      -0.0        0.13 ± 17%  perf-profile.self.cycles-pp.f2fs_fill_dentries
>        0.08 ± 11%      -0.0        0.05 ± 44%  perf-profile.self.cycles-pp.path_lookupat
>        0.10 ±  9%      -0.0        0.08 ± 21%  perf-profile.self.cycles-pp.__lookup_mnt
>        0.09 ± 20%      +0.1        0.16 ± 24%  perf-profile.self.cycles-pp.rcu_core
>        0.15 ± 14%      +0.1        0.23 ± 19%  perf-profile.self.cycles-pp.trigger_load_balance
>
>
>                                                                                  
>                  fxmark.hdd_f2fs_dbench_client_72_directio.works_sec
>                                                                                  
>    200 +---------------------------------------------------------------------+
>        |                                                                 +.  |
>    190 |.+.+   +.   .+         +. .+.+.+.+.+.+.+. .+.+.+. .+.+.         :  +.|
>    180 |-+  + +  +.+  +       +  +               +       +     +. .+.   :    |
>        |     +         +.+.+.+                                   +   +.+     |
>    170 |-+                                                                   |
>        |                                                                     |
>    160 |-+         O                                                         |
>        |   O                                                                 |
>    150 |-O                   O   O O       O O     O O   O O     O O         |
>    140 |-+               O O           O O     O O           O O             |
>        |       O O   O               O                                       |
>    130 |-+             O       O                       O             O       |
>        |     O                                                               |
>    120 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                   fxmark.hdd_f2fs_dbench_client_72_directio.sys_sec
>                                                                                  
>    145 +---------------------------------------------------------------------+
>    140 |-+     +   +   +                                                .+   |
>        |.+.   : + + : : +     .+.   .+.+. .+.+.        +.   .+        .+  :  |
>    135 |-+ +. :  +  : :  +   +   +.+     +     +.+.+. +  +.+  +     .+    :  |
>    130 |-+   +       +    + +                        +         +.+.+       +.|
>    125 |-+                 +                                                 |
>    120 |-+                                                                   |
>        |                                                                     |
>    115 |-O         O         O                                               |
>    110 |-+ O     O       O O   O O O   O   O O       O   O O       O         |
>    105 |-+     O     O               O   O     O O O         O O O           |
>    100 |-+             O                               O             O       |
>        |                                                                     |
>     95 |-+   O                                                               |
>     90 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                  fxmark.hdd_f2fs_dbench_client_72_directio.sys_util
>                                                                                  
>    3.4 +---------------------------------------------------------------------+
>        |           +                                                         |
>    3.2 |.+     +. + :  +      .+    .+.   .+.                           .+   |
>        | +.+. +  +  : + +    +  + .+   +.+   +.+.     .+.+. .+.       .+  +  |
>      3 |-+   +       +   +. +    +               +.+.+     +   +. .+.+     +.|
>        |                   +                                     +           |
>    2.8 |-+                                                                   |
>        |                                                                     |
>    2.6 |-O O       O         O                                               |
>        |         O       O O   O O O   O O O O O     O   O O O     O         |
>    2.4 |-+     O     O               O           O O           O O           |
>        |               O                               O             O       |
>    2.2 |-+   O                                                               |
>        |                                                                     |
>      2 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                   fxmark.hdd_f2fs_dbench_client_54_directio.sys_sec
>                                                                                  
>    110 +---------------------------------------------------------------------+
>        |.+                          .+.+   +.+                .+    .+.+     |
>    105 |-++ .+   +.          +.   .+    + +   + .+.+   +   +.+  :  +    +   :|
>    100 |-+ +  + +  +.+      +  +.+       +     +    + + + +     : +      +. :|
>        |       +      + .+.+                         +   +       +         + |
>     95 |-+             +                                                     |
>        |                                                                     |
>     90 |-+                                                                   |
>        |               O                                                     |
>     85 |-+     O   O O       O     O       O O   O       O O   O             |
>     80 |-O                           O   O           O O           O O       |
>        |     O   O             O O     O       O   O         O   O           |
>     75 |-+ O             O O                                                 |
>        |                                                                     |
>     70 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                  fxmark.hdd_f2fs_dbench_client_54_directio.sys_util
>                                                                                  
>    3.3 +---------------------------------------------------------------------+
>    3.2 |-++ .+                    .+.+  + .+  +   .+   +   +. .+   +.+.+.    |
>        |   +  + .+.+.+      .+.+.+       +     +.+  + + + +  +  + +      +  :|
>    3.1 |-+     +      :  +.+                         +   +       +        + :|
>      3 |-+            : +                                                  + |
>    2.9 |-+             +                                                     |
>    2.8 |-+                                                                   |
>        |                                                                     |
>    2.7 |-+             O                                                     |
>    2.6 |-+         O         O     O       O O   O       O O   O             |
>    2.5 |-O     O     O               O   O                                   |
>    2.4 |-+   O   O             O       O       O   O O O     O   O O O       |
>        |   O               O     O                                           |
>    2.3 |-+               O                                                   |
>    2.2 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                fxmark.time.user_time
>                                                                                  
>    96 +----------------------------------------------------------------------+
>    94 |-+      .+                                                            |
>       |.+. .+.+  +           .+   +.+.+.  .+.+. .+.+        .+.+        .+   |
>    92 |-+ +       +.+.+. .+.+  + +      +.     +    + .+.+.+    + .+.+.+  :  |
>    90 |-+               +       +                    +           +        : +|
>       |                                                                    + |
>    88 |-+                                                                    |
>    86 |-+                                                                    |
>    84 |-+                                                                    |
>       |                                                                      |
>    82 |-+         O                                                          |
>    80 |-O       O         O O     O          O             O                 |
>       |   O           O             O O O            O O           O O       |
>    78 |-+   O O     O   O     O O          O   O O O     O   O O O           |
>    76 +----------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                fxmark.time.system_time
>                                                                                  
>    370 +---------------------------------------------------------------------+
>        |.+.+. .+.+.+.         .+. .+.+.+.+.+.+.+.+.+   +.   .+.         .+   |
>    360 |-+   +       +.+.   .+   +                  + +  +.+   +. .+.+.+  :  |
>    350 |-+               +.+                         +           +        : +|
>        |                                                                   + |
>    340 |-+                                                                   |
>    330 |-+                                                                   |
>        |                                                                     |
>    320 |-+                                                                   |
>    310 |-O         O                                                         |
>        |   O     O         O O     O     O   O       O     O       O         |
>    300 |-+     O     O O       O O   O O   O   O O O   O O   O O O   O       |
>    290 |-+               O                                                   |
>        |     O                                                               |
>    280 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                          fxmark.time.voluntary_context_switches
>                                                                                  
>    1.05e+06 +----------------------------------------------------------------+
>       1e+06 |-+                       +.                                     |
>             |.+.+.++.+.+.+.+.    .+. +  +.+.++.+.+.+.+   ++.+.+.+.      .+   |
>      950000 |-+              +.++   +                 + +         +. .++  :  |
>      900000 |-+                                        +            +     : +|
>             |                                                              + |
>      850000 |-+                                                              |
>      800000 |-+                                                              |
>      750000 |-+                                                              |
>             |          O                                                     |
>      700000 |-O                 O     O                                      |
>      650000 |-+ O  O O   O O   O        O O OO O O     O  O O O     O        |
>             |                O    O O              O O   O      O O   O      |
>      600000 |-+   O                                                          |
>      550000 +----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                              fxmark.time.file_system_outputs
>                                                                                  
>    2.75e+07 +----------------------------------------------------------------+
>             |                     +                                          |
>     2.7e+07 |.+. .++.+.+.        + + .+.+.+. +.+. .+.+   +   .+.+       .+   |
>    2.65e+07 |-+ +        +. .+. +   +       +    +    + + :.+    + .+.++  : :|
>             |              +   +                       +  +       +       : :|
>     2.6e+07 |-+                                                            + |
>             |                                                                |
>    2.55e+07 |-+                                                              |
>             |                                                                |
>     2.5e+07 |-+                                                              |
>    2.45e+07 |-+        O              O                                      |
>             | O O    O         O        O      O            O                |
>     2.4e+07 |-+    O     O O    O         O OO         O  O         O        |
>             |                O    O O            O O O   O    O O O   O      |
>    2.35e+07 +----------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>
