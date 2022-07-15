Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062ECCA481
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 09:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGOJQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiGOJPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 05:15:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04C474D0;
        Fri, 15 Jul 2022 02:15:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F8tApF032705;
        Fri, 15 Jul 2022 09:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=azCdAHQqbIXK/9tG7QtLAELOiNzvjsFonh4uBrN2p9I=;
 b=fLufqcdaUVSuA2Q6xfsJIWPUK5e6tj1tn/U3S2+sPWcB6C5TJoJL/lBd9Byy39tbqGrB
 2eUsuY65LlGmdXhxXGD7Jkv/+Y55G/G5J9KBWctBWcEt8YMjkBGXFSvTXsdM7JZs9MJ2
 uLB96RX4Sj1BgXv+JMzUcli61Igl6OHplDhM7y+BxE53HK9lIaYVALko0IVgxwtmlMV2
 eVLfWgI+OrUBZpW9EU2MWQADixG7ywL+M03kMRHhmeDp/kbePzdhhIxAagZPUtvs6A8Y
 IHea+/rUGcPz1WuMcZSYxhkF8FrJdSx/CVFp1UPX5EIrBuWsFnjfb3vAVW+lnARhovUm eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1ew36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 09:14:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26F9AO0I024303;
        Fri, 15 Jul 2022 09:14:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h704793ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 09:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/WsWZhOXmZA1SSSYX0yeLxE0h55CASjy/eVCa8eSwQmojaq1yDzWOZwF5ql/3ZqSZzbsnvykyHNsfRYKl3kjK38aZjPO4hxvs8EbQ2wTt84v54lWvCVzUDrqACggGRlIzMTG/zpXMZ8pZbc04ySZeuxUDVgJbikZ8CkBdky6ifpE4hiS19ddm+lX80nIghwHi5ZpL8dIgV/Fu0MwOSlvSZL9NWN6v8PXXb8T8Q9q1kQ+KJESeE8T++C9I7oiLzb2f4Zertvj81hZiBtqR2tDsUHEf0SgvnqhzWoNzG8v3ZUICkEYP+ijmckAcGgTCmpHh+xnHlDF/clUmKI0bbF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azCdAHQqbIXK/9tG7QtLAELOiNzvjsFonh4uBrN2p9I=;
 b=LllbKbC3SuMcXzk4QxtDfQRgL8GK+RM04+fNz5OHJ/DZYveJsohSyOMFwSnL4QyaCegNWOLETvzR7N+caSAQSGQVSjY0Dz3DHY8qnAaQAilQLG5hS3bWO4rgdlgwKHoR/IEOczH/aMHQs/0ULuwDXt90noFjXVePq3lF/RqtzUvAfqOF6Nzx9gFZjyJ1bKKl0SRq+ZH7jh4IdBIe5H6VJbntHYZEQEYrzjjO/X9131m12oqj0565YamNThGNLgJSd/LsXEPL+G/Qtn/QXbR6HWBSrEbsHxW+NTcftZsvmqtg6MgoinEWKP3sGv9CL7wCfBP81rlYt+cAiNa2vxyVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azCdAHQqbIXK/9tG7QtLAELOiNzvjsFonh4uBrN2p9I=;
 b=AvyqcTQiV53GoErUzM9ZKFaRkYJGKkvB1XLBhBDJmfJf5oV3kwjsq8ZjdHIVTjn71aHbzc7lMhU2PQI0VwO0hRnKkqfDs0klksERaT7DIF9VdjxLlZy6tGSIh5BhZ/s5AdLS3SXud0PsqRn9q/k9p4I6+ysnQ4N33QvavN9wRFs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 15 Jul
 2022 09:14:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 09:14:52 +0000
Date:   Fri, 15 Jul 2022 12:14:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 2/2] null_blk: fix ida error handling in null_add_dev()
Message-ID: <20220715091441.GY2338@kadam>
References: <YtEhXsr6vJeoiYhd@kili>
 <PH0PR04MB7416C95D473D2F35A8A1F5709B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416C95D473D2F35A8A1F5709B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 598c71c9-a1ed-474d-3e21-08da664279ca
X-MS-TrafficTypeDiagnostic: BYAPR10MB2629:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peBxQHODA83TUvK6aPgbH/L5tpWhVlYc9wm4eKAyVpwil3ibafx3dhTCbAew8DSaDkNHZ4DhymHqT8+QkdKLjolfIW2k0xEnTVqWPP7vQ+1ch6LFZreMgkW30DKjeBfIGqAGkeICKyMtmeVK7XooUkhX2pyBcVIdxaIrVnuFie71lseW4nq1Fr2dYZXWPVKZF1Qo5T5LM9t6zmnU9r46BMxht1UcHzzcJhSiPKzmgKGoCeeVsLaf5/KFpzQ73apdcJi2FR5TdaeaQnpMeOTd3A+Q56USR1ul0W1Q6ogl2MfwSrXP0bHb8+NuerPP0GIcHBZR6Gvqg7RmLvu1WtDQJkSMe3fk1lO3wMHS8LA+lbZWmnY+biFvw3skvaVprbcw4dYugz+wSiiiprLJV0dEer0Klqi/4HGYUAn5Sygh37YkfNvPIvez3WnFx5yfZ5iVDWDkDr9IZ0rczGEZnUUuCdyezHPNySAICbH7kHFIhNjb+XBuKXJgzKbdVu8+/n5tIOvwo4+SH186N8B+oW4m1ke932p+2EFt56+yblSPxNbqsqJrBYQVbrortFtNpN0IbpF6pP3p35ybZs1Xw1LnrQ1VZausLTjjd4JtiuhJWSj4i0oBSMpuBNeK71wTSncO6FvFTUFsWbI7HmSSbsYq7beJx9yLC6bVUYJkpMgx6x34W3q3zoNk9qKqqpn99MspokLB5+4yUEkw9AVPx5hUFM4fl8M9i8hzAH4Nbu7jRbXjJMiKXTd5jlo352w7o/21XE5dBKhOPF2BhGqw4ZGRExEIsM+l/KVLiTiPsdCn8f7h3ht876kGBewTX/k8WRKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(8676002)(33656002)(186003)(83380400001)(44832011)(8936002)(66556008)(66476007)(5660300002)(4744005)(4326008)(2906002)(6862004)(66946007)(6486002)(86362001)(6666004)(41300700001)(33716001)(316002)(52116002)(53546011)(26005)(6506007)(54906003)(9686003)(6512007)(38100700002)(38350700002)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dTb309Hvdn/JMW77QWNkmRjSWyRGGLVsdkOE2btnThDFZKvYW+jDh6hvdeyB?=
 =?us-ascii?Q?ydckaJTyX+AxFlGBTxqmjIVTfCQTOAtlaRSRCB1gKgCTxKzNvh0jbeuybR/H?=
 =?us-ascii?Q?tUMA0bbbQrcZdC+mKgU/I1Z1ZNYAumT8DhHlZi/8LP6XHzk06DjFt1KL+9/y?=
 =?us-ascii?Q?BAPQEVk385TdqktH0L8kjpOBpJ+tojHqJDLB3383Yq3Rmf+4L3qLYqEjYJt+?=
 =?us-ascii?Q?YfJExCPD/6MNvSw2IQvB1thebFicwSqRaQyh486DfUmQ6/0wA/8HamdtUqVM?=
 =?us-ascii?Q?WDidwwZ1zHw0co//wzKd4T4R22TIuMCtgl9HZ2v/2/5lD/A1sy6gb5LGKCjt?=
 =?us-ascii?Q?ao0e/gcFWkntEHpVDt8ow0EJQPBX6xwZCS+3tc9O1sqzXuIQNLSTcz31mLmx?=
 =?us-ascii?Q?dqyBlG3jGTkZWKBB9eGL/BZ4T0hGsxXAx+FOyctr9St8u6Cqh8DaJHdHPsET?=
 =?us-ascii?Q?BvjPp5CpRYBiVWLzLwuXovKSG1Rt/iMriFc4nKDHV5Ujlp1cOPn0Kl+OKL0r?=
 =?us-ascii?Q?lydmfFsX2p38OC8nYoGGbbAtegA9NXszn2n96tOJA3EFphDP2ViyXzbvdoxW?=
 =?us-ascii?Q?4jf55gDKIUMM5PEMSLtuAu3l5SvJ4ArNVaJWel7pdOIOBPjcIqUlKSwgPOUv?=
 =?us-ascii?Q?Q++mChLprmpxysfTzGFigCrhbAiVnewxHWsv8eVwsKN5xnbx4bXP+HDFDBKS?=
 =?us-ascii?Q?2pj1kYLt4AB7h8DkgF9SzJxN3M+HSwk1tw5tGgudWYBu3scPCaLx+cI8Yzgt?=
 =?us-ascii?Q?S/WD1B0JsBJ9n2sodAS6/2d910c3bKpUbtR9XAfFmyeoqSVtJI31CvBSj2k8?=
 =?us-ascii?Q?02Fi8I679tOjAaVDe3lCLqdceTWP+cTeQbGOZ+oe0GuTMHkTl77isFZmWfuY?=
 =?us-ascii?Q?DoNwmF1EULCmD5QHEqYmMyVIMfT34jKh17/jes7p0upGfQSwbDXXv9rhf3wr?=
 =?us-ascii?Q?V91dZ5pwmRWlDMnUwzUw/o+tPUT4ZTBm2hNOBuMJ7xSxOus1SOODBR+395T2?=
 =?us-ascii?Q?zmANrrAmrEln6eNwuKdjUcINJEycoNa7/28MYwv2VWORbzLxjscU1wrcFvoL?=
 =?us-ascii?Q?DXQHZ8Joml3ZFaa+zBBpI5ZocEA3sqhhiwuGsCP6ysIleFtYRrfp92q3NSeW?=
 =?us-ascii?Q?TQu+l9VG3gs1SO51NZ9SOhVaQwtufgB8Z15Qu/+UKw1mAloLLWHW/0oj0sNG?=
 =?us-ascii?Q?Gddhtc+QDI/CKu7Bor7MXHYTGQxWwwwb2xbie3xfYmHx3HgLcpBE519Fa65U?=
 =?us-ascii?Q?rr7k4GZtHzmkl1ClJHL2bVihkzO+vD6K3aSqkrFijhxTIaoGo6AAumdxzksN?=
 =?us-ascii?Q?edKJMhkw/wFXEqwvNHClpYl8eM6/qmrnSlBFV7es9OGo9KDhj2DUuI7GUARa?=
 =?us-ascii?Q?Nx9Pu8pi5zg7klZZ2oVGA1K7iZV5+hb5Xg3M3tSMObbbTgTFp/ize9saFi9o?=
 =?us-ascii?Q?Dk1N0cV1Q8zyFzuXA10I/2PgVt6scxuOotlfdkJuv8I9KuaUDpufmogwYh+v?=
 =?us-ascii?Q?sitRbZGpw5Po/1IW94xM5SwkWPCwlae82iiv2mXKBet9S/+xSc5rlDESnB8T?=
 =?us-ascii?Q?W+CIox7aU5TrvX6oxTGahPXAHgkU8yqTB62G5oqvoORvbM3ZWUoSTx0AmDC6?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598c71c9-a1ed-474d-3e21-08da664279ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 09:14:52.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xyFXrGJnRB6BNGhRC+TG7xDTke43RX33fXFuA26oT+asy8Kd8LVa22kZW3jqpG9kXLU10DZTLs4fVEwEh63GH9NpgYg6RaZno+7a+dYCA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2629
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_03:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150040
X-Proofpoint-ORIG-GUID: 2m-VwuRcHhukF_rmzH1BJcMqDmN7o2J_
X-Proofpoint-GUID: 2m-VwuRcHhukF_rmzH1BJcMqDmN7o2J_
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 15, 2022 at 08:23:24AM +0000, Johannes Thumshirn wrote:
> On 15.07.22 10:12, Dan Carpenter wrote:
> > -	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
> > -	dev->index = nullb->index;
> > +	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
> > +	if (rv < 0) {
> > +		mutex_unlock(&lock);
> > +		goto out_cleanup_zone;
> > +	}
> > +	nullb->index = rv;
> > +	dev->index = rv;
> 
> Isn't ida_simple_get() deprecated? And actually the 'max' argument is 0 here,
> so ida_alloc_range() tries to allocate a number between 0 and 0?

That was already there in the original code.  I was just fixing the bugs,
not doing cleanup.

The second zero means use INT_MAX.  (When a function has "simple" in
the name it is always intended ironically).

regards,
dan carpenter
