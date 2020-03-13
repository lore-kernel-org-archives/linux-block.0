Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D9C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFB7206E2
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 17:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qe30X4qZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lL68MUev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMRtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:49:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7424 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgCMRtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 13:49:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DHdulY015841;
        Fri, 13 Mar 2020 10:49:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=to : cc : from : subject
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=CgjU215JWsW7mK1/5kZlejsppwaRHmmyPOQZCrh9hz0=;
 b=qe30X4qZ7UuOdxS35ipzaE0URma6G7Ubll7pAmF+ajOjFrE0s/7OT3nPrNo1Kh85GnfR
 ddacXXbuENDrau22fPUaZrqgVeWZbVhVGsR+cg8wmgO7+p+H+7htjJu9J7hppnlDGAQA
 vgPBi0+15nJryV4TQhYoELItS2szbvctENU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt96way0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Mar 2020 10:49:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 10:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOoB0KLCpGgKEtAKVtSaI7osGmx8gFq2SRfpkOMjali4oXAp4558OaTKM1vmUnb0ENCiSW5ZvQJK6n5meg+V2DVLtFlwnFmBiOzGqA6IaqiDA8O9aE/ZxLnwR+T1OySGuOJpNuKWTLVunvfLTkJnBsSV8/nfitlGR6KPQNr+TCr1ov7SDuq2ZOzPIrn4AbTw6w+Pzi7FLIPtNwV2yh5CKsauUqg0vBgUw+6UseBBOLEJlT/UDWm3HcetBMFVtykz/3CkWylHawUoiKndXoAG+AZnPlcOvf7PtfikPktbw2jdbKVTHLpNYFel/08t3UVcSFlerSFbsAd+5Xx8dZCjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgjU215JWsW7mK1/5kZlejsppwaRHmmyPOQZCrh9hz0=;
 b=F58mJLzwsAhuHvCbR8GR/tfFBKr6DhesnhdFstt/PwWHaXeg32uFHPiyWZT/AsOJHWM1Ttk4h3NJwYcy9vyZ2Z/I6VPlyZa1lCbzvwQ4FsVmKUOz5vz4U0gqteKG3wf70cZjJAlwA9JvrcjdCj5Lm16qw+iG4WDjZpT6FecJrYttPsKtD9kJcV0oH09n7yG3oJCcK82T/ZEGZSNrBTOz8oFUIzJk7QBS0oZ2m0EEwYnxvjRwGdY6/HlEYcKPWeWTQBEILdc2musyl9Ecry8AT1fwG9OffxUYdhQNygyhGbCQkCUgmPekzeaKiPSBV1hP0Ea1UpV4H3u6BrOZZhCF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgjU215JWsW7mK1/5kZlejsppwaRHmmyPOQZCrh9hz0=;
 b=lL68MUevP0Z/5u4S4eghTzjPP5iEnz9kaTSd0JQxR7zXT5izYFMMYiyhkxh+sx4wZRUg8k53fu+SMnYktQUKorTkCjtFncygBMRjOZ5MCjqJh30jivFUvYz7feP78bksP39u2hPEJHUdX54GAA9VaphOJdLTBQPNFTRO2P10YY8=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (2603:10b6:a03:15a::31)
 by BYAPR15MB3032.namprd15.prod.outlook.com (2603:10b6:a03:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 17:48:55 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::4c56:ea:2fa5:88f5]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::4c56:ea:2fa5:88f5%2]) with mapi id 15.20.2814.007; Fri, 13 Mar 2020
 17:48:55 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 5.6-rc
Message-ID: <37c30445-fd2a-f0a0-ae8b-f32c90f8c993@fb.com>
Date:   Fri, 13 Mar 2020 11:48:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.188] (66.219.217.145) by BYAPR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:e0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7 via Frontend Transport; Fri, 13 Mar 2020 17:48:55 +0000
X-Originating-IP: [66.219.217.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdaf633e-cb7e-4fae-c5ef-08d7c776ccc9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3032:
X-Microsoft-Antispam-PRVS: <BYAPR15MB303266F760F9295B32253B86C0FA0@BYAPR15MB3032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(16576012)(316002)(4326008)(2616005)(81166006)(81156014)(8676002)(956004)(478600001)(5660300002)(8936002)(52116002)(31696002)(6486002)(31686004)(66556008)(36756003)(66476007)(66946007)(186003)(86362001)(16526019)(2906002)(6916009)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3032;H:BYAPR15MB2790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTe+qS13fNBwIyPG0yF/kgVu5ibVgQ4iozbueN7OK9Yu+ng0vM5fREuu0sjIGGpYol7oGmKocIk52Ar7CBmqCNIBmyZ/g8MqQravMkdXaBUDNmRccGa+gePhW3hoEOuHP0p8klUUEhekoScVv9eaAZqtGdXFP948L6vBiB/3oTl9PIV3FQdwyg0nrmBYXaxvGRVwVH2iTthUD4jqCXj8HoTH5mkc0bMJ36LrdhEQPhijVeKeTD057mj8KNQknJ5yAQDhD6Gt2O99PE3GelJhfZpVlH02L4RhNFSi+MjaVoKC65mWTwhH5Te+FhwY1mcvD/asoiTw7pz6pDSCrFpRC9F4VGUQ8V4lTokxjdyarEAJ8hl8zzjrw44vnIomqY48v/3qkZlh6+ayPqgqQ23RP6ntibhD55y3Jbb77a2LYX+xtRRczC+BkR4zCdK1+wTR
X-MS-Exchange-AntiSpam-MessageData: AlvE0jPMcKclmHeWIAAI5xdPrgZ/QosO/5Jv0XfxHwhnODVeU5Q0mYlcaAWrSrKNQ8aFnAFbSbRE/dgJ4z8u2DijAzzXAbyQZkFSbOEeXz4L/pSK2Ksrcc8EtYCozpKM9rUEqv3u6wYcGy8yUA1/TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaf633e-cb7e-4fae-c5ef-08d7c776ccc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 17:48:55.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMpOMF78SBJIPG3UkPOD5FUPFwP1QE7kS/Oue7/CEgZ3pB8UxDhmBDa/WJ4eldcD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3032
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_06:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130086
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into this release. This pull request
contains:

- Fix for a corruption issue with the s390 dasd driver (Stefan)

- Fixup/improvement for the flush insertion change that we had in this
  series (Ming)

- Fix for the partition suppor for host aware zoned devices
  (Shin'ichiro)

- Fix incorrect blk-iocost comparison (Tejun)

Diffstat looks large, but that's a) mostly dasd, and b) the flush fix
from Ming adds a big comment.

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.6-2020-03-13


----------------------------------------------------------------
Ming Lei (1):
      blk-mq: insert flush request to the front of dispatch queue

Shin'ichiro Kawasaki (1):
      block: Fix partition support for host aware zoned block devices

Stefan Haberland (1):
      s390/dasd: fix data corruption for thin provisioned devices

Tejun Heo (1):
      blk-iocost: fix incorrect vtime comparison in iocg_is_idle()

 block/blk-iocost.c             |   2 +-
 block/blk-mq-sched.c           |  22 ++++++
 block/genhd.c                  |  36 +++++++++
 drivers/s390/block/dasd.c      |  27 ++++++-
 drivers/s390/block/dasd_eckd.c | 163 +++++++++++++++++++++++++++++++++++++++--
 drivers/s390/block/dasd_int.h  |  15 +++-
 include/linux/genhd.h          |  13 +---
 7 files changed, 253 insertions(+), 25 deletions(-)

-- 
Jens Axboe

