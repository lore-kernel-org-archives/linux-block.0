Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE67AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 04:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F460E76
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 04:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhJ2E3k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 00:29:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7448 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhJ2E3j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 00:29:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T36q2w002213;
        Fri, 29 Oct 2021 04:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=cxgQb7jVqQjiI/yu2kpQ7xOOef17FWVJaTFk2qPiXP0=;
 b=fzVlGWyksjAiQLzJdanYrcnUphhlJXj1Z14qLL3hTWsdUaVzdXI2ouUE0trYOaqhLwfU
 v3qTObbFLz4kIsp38GgugiKC+KzSWKFG2DropXlSR8cr+oKloXVxmu7zDpkGepHEwhsG
 SWj4b8mwiyYDku5Zw2Eb2gOvnR9S6+tsJajgmyngZcIRSAzXCfmU1Mm1uCgSm5av6VSN
 4plPtu9xrGHcMaI4HSMzhWvQ4nKjoUD9XXxSWxNlpsY805EDXsSJ9x7MgKlKtFD7a0+9
 TLKgQJp5ABMc4ygTFysC0WULh0nwwRCDWs68LkQbdsvMabkRN2iB+hbMeEdw1AicZg7T XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byj7rxqyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 04:27:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19T4FeNQ047709;
        Fri, 29 Oct 2021 04:27:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3020.oracle.com with ESMTP id 3bx4gfcnf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 04:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epOtRbn92ezijMJaaw1NfiU3jIlgxzkM/LB8jdymASMA2OepCav7/ZLmf3W6l/qm5qkPSr2bh0EnXmrzw5LEfmi6yzi2ycCkZdI9fCXK7X888yxzal5aP2lJ8WQQVsYo5viGzIqZTTYBVK+ylXCLORvJwKEvPglBT7x5qcuIkuzCRitydQJx2g6UJVje1TbFe+Gd2qPVeavjh6dPnwKCaYRBMJaV81ePs48+rmCXgXo1OMfuMSWBlY8goDxCw/+3W76llHva4FXslRV/vBUIfrINts/FAV6y0ORVz2fE3cVhvX/N0C9eoUddahzcaq8/JHHYTSECPCei/zANl1clkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxgQb7jVqQjiI/yu2kpQ7xOOef17FWVJaTFk2qPiXP0=;
 b=LD/vbDIHnOOn/gYY4mUmoJCyKOfs8pR7pL6T20nLJjmzzRV5bImg6q5owKVKwdCQ0riX77ICpJqsMuZ+h93eGXaOBU7PGKehz6SxrmQ7Z9667cvtCFRtTGXMCf5DjPXOFtTiiO9w4RGTJOzgeiAE87Hbru384VilYVQ+kEa5Fson7i/3dGM8gGsESr/PYRFwlW6DOCmWIw8RrySTFg8tqhVLjFBGBS6Dzkh77seUzV3+o8/hwMY2d6TyBx83sZvl5O4HTYvGtruoHg1eQ52a5UZ2M618BoI/1ghfqbKH23wrwpQMRVUh1tZU7aQ6l4Sh02opwjdgx9bvhHZcYWopfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxgQb7jVqQjiI/yu2kpQ7xOOef17FWVJaTFk2qPiXP0=;
 b=nGAwpSK/4kxl4Kk2Zl27DWkrBG2bXAMq4uV9SwNCGzuEAv2uIZwvpQYOLSd1trmJGudAy44C9O3+C6PvwbD3vtzrJRzrVxaghIDeogzy3bq3nTuu6okFevizpJaoteK14AayZC6yeTBuFrubvRFRie3YUk0DqxNN1UsTIWp0+Lk=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 04:27:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:27:04 +0000
To:     "Alexander V. Buev" <a.buev@yadro.com>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, <linux@yadro.com>
Subject: Re: [PATCH 1/3] block: bio-integrity: add PI iovec to bio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cznov6q7.fsf@ca-mkp.ca.oracle.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
        <20211028112406.101314-2-a.buev@yadro.com>
Date:   Fri, 29 Oct 2021 00:27:02 -0400
In-Reply-To: <20211028112406.101314-2-a.buev@yadro.com> (Alexander V. Buev's
        message of "Thu, 28 Oct 2021 14:24:04 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.52) by SN4PR0501CA0011.namprd05.prod.outlook.com (2603:10b6:803:40::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 04:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279a7514-f7bd-47ea-17d9-08d99a945c42
X-MS-TrafficTypeDiagnostic: PH0PR10MB5626:
X-Microsoft-Antispam-PRVS: <PH0PR10MB5626B27C3420AEFDCBAF30E08E879@PH0PR10MB5626.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXs4eJ99P6N1B49GYbe2k46agaQZgI2IzoNBlEgg5BcJHhKl2dRquPA1XgOw2wwLzuD1xa/BWPqug3MEN0I/5CpNmUUgbfjy2dPvWPFWQba3pcwBYVGTBE1BmaHMgY8kCL005ceKAriL9THrJ+Up9DO1KRxDCzvMYoc5j7mFhZtoZQmWDZd8/XypicYwMKV+LppKicRc1jMc6hfm67UkZErwhFuTJ1zoFcpYc1ReQIZZjlslm5IC8f8uIUtCE5z4S41rHwNHpB+SPDUZf+w/aMRhTg40xmHFQfLzk3+LP22ecZJg/WqW0HXt2RP3fb18Xx3mOOsyVEMbDMau842MU01ExtoTjGNxMkhKXKFo0G4svqh9TJGOu7F1xW4YdlSm3Tsec9KjDr2meK86R34kFRJbvjJCdVESFCKL4L7lRQvAvd4Y/CLbx9GTkg/Lp9bHGdDYYok58CcQDFsz2PsGkLlCto3fN/NaXz6c2dhYLq5/H/8303ez7hoU86yqMFBioW5g+YhwgHZrVg21yzQGzuwqDJYQ5M4r80Ez2elY4n2twfd7+rqHWdJXECEiE2+TqFvtu4YchI9dKWBg40vOaMFfsXwR2xuv/X5qtbnzhTbVPXcL/JgtWrRx6WEvCgOR7l/7/WVBdKsErKoyhfPWwX4aL7KtSsySnQpa7NR8jBWQ64SOvWPQuTWxuPqDAAdoyg9SbjKAyXJH+XWMKuLf0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(52116002)(4326008)(7696005)(54906003)(508600001)(66476007)(66946007)(316002)(36916002)(66556008)(8936002)(6916009)(8676002)(55016002)(86362001)(2906002)(186003)(956004)(38100700002)(26005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHqG9IqL9VVl+AQIzVNRj4LmYMtWW8PbCFPkg6KJsTpBYl+52dqPD3xt2dYI?=
 =?us-ascii?Q?poC7B7Pazm9u87VtFq8wgUxO5tmj00XJgEszSTFsAoC/t23PwoUeV+lKXzBK?=
 =?us-ascii?Q?cgoIioNAZZLwpcLFhNsd+XIJCTz5k2zXUchZQ9PT1a3h0zUv1UmklbtvsdqS?=
 =?us-ascii?Q?36YcgpBG5HpFQbv7D3OODVmdlBJrokpqyG1N+ycRSK0CuKIGBb3yxr3dHNKv?=
 =?us-ascii?Q?Qs9djEdJB5bs8Vm2xZURUZtSSgKQupJfq/eoUtJzpisxN9Ic1QSjm7/6VgC4?=
 =?us-ascii?Q?C6gLAOo6B/PHnuJ1l+JqQtjVp3GlOOXfsNBfj4mG0W8fKpvCFljUDQzKLLqY?=
 =?us-ascii?Q?xPqJkCY0EbNvwk15lcBUXZt4UXJxC1MxxpDOJHjD74vUt4FSTG+O3GnFqLOK?=
 =?us-ascii?Q?i/nSrCMPcJLdfmVZhJrtoY0gZsrwjQ95AnEzy3IoDJyeLUX0Z5UJt+2l9sxu?=
 =?us-ascii?Q?ZkbFItJvJLPXnL29GQrAn3ZlZgr2WYfRihABq2Rf2JhC0cCYZ7VpOp/+CY5M?=
 =?us-ascii?Q?eEOBMh2CYMmBxXpBdTpZ+WmZOi13K358x7vT4f/3Yg8TozGPh6zHGPuShb90?=
 =?us-ascii?Q?P098sLVOrqNM8uyJtpulH1M68JF0vzZWNUiUlEghUCERZltz8u71ntkNXzUj?=
 =?us-ascii?Q?SJJ5527aX/5NFPVT0NUN+5gajVSGL0iEPJtp9wAIE3dEB6emfPZcWBKKfgJd?=
 =?us-ascii?Q?1Zb0qQflOjD3dYHjAkQsFLr96Qv+uvpwpay5qjvij8u3Dzz0YQRWrvSa+UqT?=
 =?us-ascii?Q?6w8vxLIWwbHiU/yff6tGqQPj2vrxKPf+GyupN3AV+FFgIR26HfUnfm4iguqg?=
 =?us-ascii?Q?w7ee+Q4YhAKzG9lkLDLLK4iPf+qhwvgIftGYkp9pfvmAEmjqbY+S6z8ZCGs9?=
 =?us-ascii?Q?B6ucb2ZyriwaG4/LX67Zy8nQnRvzDEpeCiBRuXv2Cx4ZEGK8/lMqNHO6brts?=
 =?us-ascii?Q?ojAeZKRZbH9pKAKmCiDNqeIGD/8MTFi84DFNnCmyOlOpVi4XbLpy8IIxw6mQ?=
 =?us-ascii?Q?FPG2huID187DSf/9xHk9LH0E+REpPGFixStp2MRDXm+1E2s5YqmZ5FxeKYng?=
 =?us-ascii?Q?AqK2uvFV711Zrlx/Jvt7HDMTLxOPTgUwOlJtyvUeb3IgkdEP5FkwdtA9RJuU?=
 =?us-ascii?Q?WFXq85q7eVLFGCs01T/jy2O43qXJvY09YWHrJ4nY41TF5DhfRXNjXsIIaOV+?=
 =?us-ascii?Q?GBY8g0ZMcuSVKu3Cse9pPQ9MDHnuVCKSTsKBvloF14rJGWTHk5vpXRqf1Ted?=
 =?us-ascii?Q?FRnBn+9zdyYkUU/uO16I8u9y3pK1lTfjdqMnVOTLWqjXMGkjjscqdhImq+3M?=
 =?us-ascii?Q?3G7YNGWjDQSIzSOBcaiHrQqx0fPRJDA4oOu1fDvhGR8upnJ95AwXUZY3Ddzi?=
 =?us-ascii?Q?I7T5HRDdyk9nCrovbV1dW79aKYrHC/qUAEyJlGPlod6fkRhZhPBXEh8MBp0K?=
 =?us-ascii?Q?GVeHyuJQN/7LAkMx2RMkz1K3zrkhsiOYBmBwhvZFLsPxI+0z16i2NDPpBfyh?=
 =?us-ascii?Q?oMS4qn5PXOg9ciGwcrzQ4HQoh6NHNUKR9cxcPZTHzBkfzMGdfNs/gWlUaztV?=
 =?us-ascii?Q?BtrMBxVbJGYja4UHUdKzzO5Q3O7m//6uhvrgEmbPNI8ib28HvGLpeGD4zMNW?=
 =?us-ascii?Q?Fr9DDo2+nkJ0E5prNJa8JpZqcwtRnoXA5ngtWS8/eSjgqsBIDbGXTdySSHK5?=
 =?us-ascii?Q?zC/YJ3uu5tcpXOE0dkRNlnlsgco=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279a7514-f7bd-47ea-17d9-08d99a945c42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:27:04.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX+IT2ZzbyMbfrbGJIlvuM7bgqkz1nX1ZecGbVzAloSe7ewMoysNARyKcucYW2Bw81rRf/DZGnH4SI/ENgTe7IY+nhpPbpfDZ+r5hn+bK7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=975
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290024
X-Proofpoint-ORIG-GUID: 95D15ctaY6Av4AfxNP7NfKHshnY_b3zL
X-Proofpoint-GUID: 95D15ctaY6Av4AfxNP7NfKHshnY_b3zL
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Alexander,

Thanks for working on this!

> +		if (bip->bip_flags & BIP_RELEASE_PAGES) {
> +			bio_integrity_payload_release_pages(bip);
> +		}

In my parallel attempt the flag was called BIP_USER_MAPPED to mirror
BIO_USER_MAPPED. But with the latter now gone it doesn't really
matter. BIP_RELEASE_PAGES is fine.

I find bio_integrity_payload_release_pages() a bit long. All the other
functions just use a bio_integrity_ prefix and take a bio. But no
biggie.

> +int bio_integrity_add_pi_iovec(struct bio *bio, struct iovec *pi_iov)

bio_integrity_add_iovec(), please. _pi is redundant.


> +	bip_set_seed(bip, bio->bi_iter.bi_sector);
> +
> +	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
> +		bip->bip_flags |= BIP_IP_CHECKSUM;

The last couple of months I have been working on a version of our DIX/PI
qualification tooling that does not depend on the DB I/O stack.

For the test tooling to work I need to be able to pass the seed and the
BIP_* flags as part of the command. The tooling needs to be able to
select the type of checksum and to be able to disable checking for
initiator and target on a per-I/O basis. So these would need to be
passed in.

Note that extended PI formats have been defined in NVMe. These allow for
larger CRCs and reference tags to be specified in addition to a storage
tag. So we'll need to be careful when defining the SQE fields here.

-- 
Martin K. Petersen	Oracle Linux Engineering
