Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiJZOOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJZOOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 10:14:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CDA3498D
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 07:14:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEDpiu021450;
        Wed, 26 Oct 2022 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=nCxbbxabDcO1pKSqIr28tkLpHxVpO2SqIqArZtizB3U=;
 b=XFtKo/dxvi5YOEOaeYPavTVFOWcxtCVRhYEmjccDq7kLjn4wxBPFlAzkA4j8gzIFQazh
 zjIj3MF0YfPufv/JsvW1EyOQF7mNyxCJCFnWuLBZPzaPLSJMa76hxLqFEJOqn4xUu+xT
 axVZpHkmOjQ/nY5pbKeZgVRKs3PABtFbM15gxPg7USBvKOWLxhCZgdXFIyriT1PVQZQt
 /ZFgaXWCA7De1thwR56cZyKpohpdDGAECigHO6EOpaCpjNNVqeW578692hzL/23Nxejj
 UH3WkVKevrjBhNZt9DU5zNRgEruT0S35NPmcsTwmdRjNTqL+2W4m/RYyXxjZQGjT2MDl Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741yanf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:14:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1O9e017977;
        Wed, 26 Oct 2022 14:14:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y61dyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjkZEykrrX0XcH6rr4EpOb3pvXpTDrCa682m5Y3JKkHYCvWK6J+EjLU1DNCg4WKRa4TQhKb13Ba5I980ZAEru0SN+HjqFWoZhE1++Sg8X+f/wS9UJ3YA+bGgEjgqhum8HkS/hYJv6OMYGz5amvdO+Emn8OHy5xpDMmDtW5RuqaCK+f2rkSJpDHUYGpacptH3ct2iuqwCur+MLOp4XqaI9Q6GaVLbgAUZXbBC7w8HwB1hNVCPixdvTS1Ldjyu6jognHQ24R5eqiNdQqpyq5v0IyK1q6Zn9ddF04RsLFBrLsyS5V7+uryGA6dI4D3MIMQtzKS6bGsD+KNbtReSH8JUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCxbbxabDcO1pKSqIr28tkLpHxVpO2SqIqArZtizB3U=;
 b=KiYgScQGercIRQkEjuqxr+UQ1v5IUkSx8E8hj3nO831FPK0QEFCJsdKrpOoA/Ztrz+E+Bu2Gn3m/gs7xsWea4iom4jwujEI69H+lMQ8PTSGCsrI5LwjU/jCznRTvF4vyD03SMp1SyZJHvZVhjgWqUPu2GsZ314PZ2wFTaDSJZOiVnmZuYkyO0I/Csh3NRK/R0jNnZc2FkGZCgqAPFtJmHpLdJfJTBbNgG85a0fumcv1ZWnDVIBbc37eGdJVFKMDr8AZ9rODK70N9Mywg2Xu4MPAcoZgit42kIAAkXCtbIcP3lVUM3H8BVWECQgYnUh6sqsw59FK3QV1tQgHP0B6hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCxbbxabDcO1pKSqIr28tkLpHxVpO2SqIqArZtizB3U=;
 b=ZXm5VcredGUD+kLj5jBcVoOVsZZofnzF5ZKDbh9IpS0XeI4xwyV9aMhDv/5+5YRjTnwI4gbOe6cgmuSSaZWlIslAYDCq7KGWs62eEfjJ2l71zNPgoOpYx3SuGMRlwWaGWe3ndm0JWPXwCsVK1xLr6ATugpUZmWHylWm2qz22XqE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA0PR10MB6914.namprd10.prod.outlook.com
 (2603:10b6:208:432::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 14:14:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 26 Oct 2022
 14:14:22 +0000
Date:   Wed, 26 Oct 2022 17:14:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] blk-iocost: don't release 'ioc->lock' while updating
 params
Message-ID: <Y1lAtdAkRp8JYJ+c@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0159.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|IA0PR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e217c1-6e3d-47be-8d45-08dab75c60c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Vwhsv05jXkjSAeTuiO8WVl7KX2XwpagqPBpP5swewbG1Sb1Uue21kIiiWax2G++lxSuUX9S3cLOJpnnw1gv7Yboq9vFzCVexLr6ndNun8D+8wSDBhBLRGPuRXg6ExuxXEqXqIBvvIZhvzKWcV64Iuvozl78xYcnAGEQZ4TcX5liDgJDjz+5T/VKnUBwHGt4eX5fHn+RWvb3cMbMx4R659NF2kfOx2M9NKm5j0uXvV4WM4WnCOcE0XwXcVrUCZQV2Ec3LCmEFD7+5WvxSOs5+iGZAjhM/WHg/9ClqtP82EgjkKh/2D9mI0TKp09hSgFoumtKQ+7kq3SrnDPW07NM22IB1mhLSJVEXloYHVpNI0k7DcRrcJdNKaKGqYFhrlajfsayK6YRqUIikc8TQ7qI88F7Xo63CBnvgErpk0+JpM3xG8qhl7QPaUn4AHJCjqBlt/dVMDpRombuGWOclkrFrvZxEON4gFo+O0uPzXvmBlCFQmUgBImb2fekpKNWCnbXa3yIbTxecei/cnSfe11IQDYuoRiWhj5tjvsLOAV6GEsvEMqWQgdp9c1T6P36wC4cr30obxTEZukHC1BNLJFr/3i9DlZf5V6HKfg0cK6+mP6A92O5IBxcYRXunmV+io7D9JfnkVMv/fbTUfhQXa3Kwn7OyPc1iOYQoCRhj8tjjxNtI/Wp3zjcet0o6EkJnATqTaUdNm5TJFjmlkWUoX7/p5ZqSuqTV/jmvVkNsgEt3FNAmsosUz9aaBeUXHFztrJq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(186003)(5660300002)(83380400001)(86362001)(44832011)(2906002)(6512007)(8936002)(41300700001)(33716001)(6486002)(26005)(6506007)(316002)(6666004)(4326008)(66476007)(9686003)(66946007)(66556008)(8676002)(6916009)(478600001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPJBMDIfbkcOoDrlKyly4jWQjDrc/4c/urcUDO7BpxgCZQ8UvGIGyBDMQNE2?=
 =?us-ascii?Q?YY7ZKnWdNYp7/7RsB1izR6zxT+jk44PHzF36bN7DH1WMSOVDpP1c5o/mAwtp?=
 =?us-ascii?Q?RXMUVPwVnHHKCIHx4LkzXl9EEDsdRJY+elF/8CIz1JBjO7CcgeY7N/2CCR74?=
 =?us-ascii?Q?03XnwtbBAJRy/GV1Xp8VN04sfEJMaBKx5o+Atq7JCfcAhwfDxgdVgTya2CyC?=
 =?us-ascii?Q?I0f1SOcesJYga3q7PWgwrajQnkWKFisS+8854fHsG2N3EZIsLxAhR+X5ZiWy?=
 =?us-ascii?Q?jXVrnilGbAke4W5uNb8LzahmvPzbp9ELFbFzhGzdPdl08FIt+UH1Yi3adTA0?=
 =?us-ascii?Q?b28U7JPtpkFcThUp++VonTjipyYVqhdXj+UEu0+lEkLOUWATFHk63hQ2mu2d?=
 =?us-ascii?Q?B0QLGi8T46kqEu0ueD7QmPLdoyj+npEuhgDdHw7ToqQYurtlK+koHgM+J7QC?=
 =?us-ascii?Q?rsS+ZbnTPp/A6h99KXVlFEdzqjd2hBPw7p21euXq/epQ0idXzq6URDq9bZAT?=
 =?us-ascii?Q?hWb/UvToJA8jaLiKlYU2sCN6A52/jTPhw5Ud1z5k1cUg8PTpw8ZrHTGG2wA3?=
 =?us-ascii?Q?5jZlXAc0ZrT2piFL6gT4yF8VBXRNJpCx3rsvCavKHfwdUL80vufs6IAtSUe3?=
 =?us-ascii?Q?s8txeqRVvhUT6mahyA64yyrlZzIVT5SpE0BcFO7y3SxovSCnrNObEeqPUzku?=
 =?us-ascii?Q?XDUsu3k1U6r3PjZJ6KL3CsxtCrj9q/tqOB93kZTD5VC/7dU+yS+fga3ciJ3l?=
 =?us-ascii?Q?cH8c8JOd5r/smtnKicPjutoPhkizSM+vo6pfnpiHkEZsrg/3rgvwr2QmwoKN?=
 =?us-ascii?Q?o72UaBxDWGNeQ0wVirToKaHZM5/O8kWDd/Wtv/IqUaSdpUWzKhTURwQL3bVW?=
 =?us-ascii?Q?ud/cDdcblwr/5MyebJLGoy4aP1sUs7Ils2Q/0va/xaPVxyIW7SycSO9C3VvR?=
 =?us-ascii?Q?WS1oLUpZIfqsIQ/tuzrGdP1PyEtlXFsvdrRGqBG+DXyCU6sOrg9aBt7e+jTx?=
 =?us-ascii?Q?LPqiruS/pE8ruCJuAimjuzAKfNUaoWVAVyNTVP4tBCvflERDBaHRQoImu3r9?=
 =?us-ascii?Q?IhdCmKlVbPs6xrQOUPG3vjvKTtUGWpf/zWOkjIyERTAy8diDy7RpTLE9HUPZ?=
 =?us-ascii?Q?epSuvgFwAYVtL23H7DGnCg3dzY5G585w5NPNnMiec56SAUjX+FPL6rDPeuZQ?=
 =?us-ascii?Q?FdB1eQv4QgiANtn+4BBswO7xH358VcYSOcL0AOFcHdxWK66BgtAao5ovNij4?=
 =?us-ascii?Q?tKtvLIWxuUG8oxIgQr5maUK2sQCo1sC6MgW/v33KnZpjWSX9tPep/AP9TOtV?=
 =?us-ascii?Q?Hml0Biwn3ADVb00FgWdQ+gjefQ0ixapQQamEC+R5htACpeHD0LmH0larPLA2?=
 =?us-ascii?Q?UlkfkR4wqQw1OXW4+7hrbF7whY71aPkeDecVhuODhlnyx67/wJvqivq9plfo?=
 =?us-ascii?Q?ewiLUDaDnm5L6ZPaCgbmR8QIQpo/moPJgO1tZg9dVtY7IQDzE0rdTAtxnGca?=
 =?us-ascii?Q?pUCF0S3txBnwd3etOvRqIIFniVyZzdoo26XqwjBbyKjuclLPn6IZCwI5KNLX?=
 =?us-ascii?Q?aMd0H3XA5ErXlA3BEpfq8XQbh0MkQ5vyLKdIS0FBeU9qbeItGjS8bdnlUmM0?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e217c1-6e3d-47be-8d45-08dab75c60c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 14:14:22.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5jD0kSv4Oojhqs6PlQdgO8O7trUwY1qpl+ikxB3fWfnJavEDWbpyOJUbOMM5IjAJm9N7xUJ12elYvZSVMA2E7FfW28To9Hx+uqxTeBzs6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260080
X-Proofpoint-GUID: svqns7-BiOtuJdc4LOBG_eksh4oyC7eO
X-Proofpoint-ORIG-GUID: svqns7-BiOtuJdc4LOBG_eksh4oyC7eO
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Yu Kuai,

The patch 2c0647988433: "blk-iocost: don't release 'ioc->lock' while
updating params" from Oct 12, 2022, leads to the following Smatch
static checker warnings:

block/blk-iocost.c:3211 ioc_qos_write() warn: sleeping in atomic context
block/blk-iocost.c:3240 ioc_qos_write() warn: sleeping in atomic context
block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic context

block/blk-iocost.c
    3168 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
    3169                              size_t nbytes, loff_t off)
    3170 {
    3171         struct block_device *bdev;
    3172         struct gendisk *disk;
    3173         struct ioc *ioc;
    3174         u32 qos[NR_QOS_PARAMS];
    3175         bool enable, user;
    3176         char *p;
    3177         int ret;
    3178 
    3179         bdev = blkcg_conf_open_bdev(&input);
    3180         if (IS_ERR(bdev))
    3181                 return PTR_ERR(bdev);
    3182 
    3183         disk = bdev->bd_disk;
    3184         ioc = q_to_ioc(disk->queue);
    3185         if (!ioc) {
    3186                 ret = blk_iocost_init(disk);
    3187                 if (ret)
    3188                         goto err;
    3189                 ioc = q_to_ioc(disk->queue);
    3190         }
    3191 
    3192         blk_mq_freeze_queue(disk->queue);
    3193         blk_mq_quiesce_queue(disk->queue);
    3194 
    3195         spin_lock_irq(&ioc->lock);

Preempt disabled.

    3196         memcpy(qos, ioc->params.qos, sizeof(qos));
    3197         enable = ioc->enabled;
    3198         user = ioc->user_qos_params;
    3199 
    3200         while ((p = strsep(&input, " \t\n"))) {
    3201                 substring_t args[MAX_OPT_ARGS];
    3202                 char buf[32];
    3203                 int tok;
    3204                 s64 v;
    3205 
    3206                 if (!*p)
    3207                         continue;
    3208 
    3209                 switch (match_token(p, qos_ctrl_tokens, args)) {
    3210                 case QOS_ENABLE:
--> 3211                         match_u64(&args[0], &v);
                                 ^^^^^^^^^^^^^^^^^^^^^^^^
match functions do sleeping allocations.

    3212                         enable = v;
    3213                         continue;
    3214                 case QOS_CTRL:
    3215                         match_strlcpy(buf, &args[0], sizeof(buf));
    3216                         if (!strcmp(buf, "auto"))
    3217                                 user = false;
    3218                         else if (!strcmp(buf, "user"))
    3219                                 user = true;
    3220                         else
    3221                                 goto einval;
    3222                         continue;
    3223                 }
    3224 
    3225                 tok = match_token(p, qos_tokens, args);
    3226                 switch (tok) {
    3227                 case QOS_RPPM:
    3228                 case QOS_WPPM:
    3229                         if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
    3230                             sizeof(buf))
    3231                                 goto einval;
    3232                         if (cgroup_parse_float(buf, 2, &v))
    3233                                 goto einval;
    3234                         if (v < 0 || v > 10000)
    3235                                 goto einval;
    3236                         qos[tok] = v * 100;
    3237                         break;
    3238                 case QOS_RLAT:
    3239                 case QOS_WLAT:
    3240                         if (match_u64(&args[0], &v))
    3241                                 goto einval;
    3242                         qos[tok] = v;
    3243                         break;
    3244                 case QOS_MIN:
    3245                 case QOS_MAX:
    3246                         if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
    3247                             sizeof(buf))
    3248                                 goto einval;
    3249                         if (cgroup_parse_float(buf, 2, &v))
    3250                                 goto einval;
    3251                         if (v < 0)
    3252                                 goto einval;
    3253                         qos[tok] = clamp_t(s64, v * 100,
    3254                                            VRATE_MIN_PPM, VRATE_MAX_PPM);
    3255                         break;
    3256                 default:
    3257                         goto einval;
    3258                 }
    3259                 user = true;
    3260         }
    3261 
    3262         if (qos[QOS_MIN] > qos[QOS_MAX])
    3263                 goto einval;
    3264 
    3265         if (enable) {
    3266                 blk_stat_enable_accounting(disk->queue);
    3267                 blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
    3268                 ioc->enabled = true;
    3269                 wbt_disable_default(disk->queue);
    3270         } else {
    3271                 blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
    3272                 ioc->enabled = false;
    3273                 wbt_enable_default(disk->queue);
    3274         }
    3275 
    3276         if (user) {
    3277                 memcpy(ioc->params.qos, qos, sizeof(qos));
    3278                 ioc->user_qos_params = true;
    3279         } else {
    3280                 ioc->user_qos_params = false;
    3281         }
    3282 
    3283         ioc_refresh_params(ioc, true);
    3284         spin_unlock_irq(&ioc->lock);
    3285 
    3286         blk_mq_unquiesce_queue(disk->queue);
    3287         blk_mq_unfreeze_queue(disk->queue);
    3288 
    3289         blkdev_put_no_open(bdev);
    3290         return nbytes;
    3291 einval:
    3292         spin_unlock_irq(&ioc->lock);
    3293 
    3294         blk_mq_unquiesce_queue(disk->queue);
    3295         blk_mq_unfreeze_queue(disk->queue);
    3296 
    3297         ret = -EINVAL;
    3298 err:
    3299         blkdev_put_no_open(bdev);
    3300         return ret;
    3301 }

regards,
dan carpenter
