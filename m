Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D4C433E1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF73C206F1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Df9F0TaV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YERVO2VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgE1Oud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 10:50:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728603AbgE1Oub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 10:50:31 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04SEkwAS027123;
        Thu, 28 May 2020 07:49:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XXPkVpGs6JJ3e1yEI1OkF05psluYykW7D+19EjTSaTs=;
 b=Df9F0TaV8esuXx6ThT3zhuJqP3ER4zPPSC1dfFErY66jHPk8yOSMLp0LjCXe6KbVa7Oc
 YzJhOCF8MyN4NKQhecCnufdk5Mp2MZPHxhvZntRBoZyov/WzUeW9pGWm65XPU6XTXLAT
 VMZY0jz0qXwn6O3SCITdTgQ1xZpr88W+bSU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 319ybhr72f-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 07:49:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 07:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2OTPW2J3ba13vHe3fQyKwJoI5ld6KpKM6Z4SpMOZ5n4HJto9PvcLVFOURtDEWkY3hDkN6HgS92yyazv3k1lm3TWb/OanTQxmi3sriaGTwSrpkJVAYYm/0e+b2IpQpuiEADvgQpZTNZ29pjAMBUSCdWMwNYhXBXEKHgP0oP9U0j3fnQVK0TwKqze/lGRkepn+Zw3Sl+r2OQVTR74460a21jDZ5ZNa2p9aQD5DNHQB94p6nTQTh30zPbqV27L2+pNSDjMeQgmilmmGSAfSFhkYo41mm/Lx5ccFhAWH2GOPHP/Rz5F4SUhm/Nyq8NGRpfXWsKquLgjUt3chluds48f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXPkVpGs6JJ3e1yEI1OkF05psluYykW7D+19EjTSaTs=;
 b=bU+UwD49EQIbXq2fMNYsC3FcYBZ2MZM40bhmuC7EY5wqSU1kt64bJq9JveGbGSFKkaJFkAyL7TP8rB5kHUVZsalmortOrZLt5MGOAnMUw5jQuqu2tXshrIrZNaZbkwvlKnycpRAT5cp6pOh4KeDpSqLeQCSrxV0dCGISt+YPtpn1r18y+O8Z6HOsobvrmLsKuEYAFEFPxyy5tpx0XVsgISolpC+BihCLDWdKoQmNrEl+pW2/4l3EO2lZXFPvj1MD5qlBlM3GdJ2iR9B07Larka5vg6f17aPpBlofffyyy7k6rKLpZ/XxM/raPjIXn2isgQ3t93/ucSFoF+R+pk0nvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXPkVpGs6JJ3e1yEI1OkF05psluYykW7D+19EjTSaTs=;
 b=YERVO2VJlrlQ8uDB5N9zlCBD+48+4sCNSGdV2iX7ezw8TmZJEXIQv0RCgmkR6bAEErA3mVpmkBG+i5jX3qsWDzsDxrazzsAbvOjqj79RQ2dzJ1bg6PpEHseZWdQj+zmxds0KGABeloopD1VG4gdFrG6/W/GNAKNuVa9kLv6LKIY=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB3414.namprd15.prod.outlook.com (2603:10b6:a03:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 28 May
 2020 14:48:54 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::c0bd:87f5:aedc:b739]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::c0bd:87f5:aedc:b739%3]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 14:48:54 +0000
Subject: Re: [GIT PULL] nvme fix for 5.7
To:     Christoph Hellwig <hch@infradead.org>
CC:     Keith Busch <kbusch@kernel.org>, <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
References: <20200528132231.GA837884@infradead.org>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <e1acfeb1-8797-a0ac-0187-b2a2035ac302@fb.com>
Date:   Thu, 28 May 2020 08:48:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528132231.GA837884@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:610:56::11) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.159] (65.144.74.34) by CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 14:48:53 +0000
X-Originating-IP: [65.144.74.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b94fee72-0724-4f54-dfbe-08d803163e51
X-MS-TrafficTypeDiagnostic: BYAPR15MB3414:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34143FCD793F548C752D6404C08E0@BYAPR15MB3414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYZiipo2bCkEvYEXPht7SRBm3Q3YJyYQNxef7ixqYeoOQU0/nxAMHF6xxijZ2t8eu9o4TEmWfRZWDZjY2L6pvTh6ZGk/ZB6l0mKmh+3qAP9Uh1xvmlKtRyJdkskSaPFe0/c5oDHcuoXjaaAaAIe8NomA4Zk8uEtwVLczYZLmYabdasjLTB3k8gKNAL0mnwJGL+YMQVmulP+XhkBrnPk7IY2apaYcC6orfjLZwIeOeMCqI5QfAAtIG9vSwfbFmO9fO8pf8LtZN9WqLoJXzilE4SSDIAVF+rggCmNBwCRLdy1kJO7P9n07Yj9oVxNY94rYSVCSXzOKKip172GYi0IMJZYJmQZmcvBnnWxfdykoWxZHCHxCkKjye5V8rp/w5MAP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(16576012)(31686004)(316002)(86362001)(2906002)(6916009)(478600001)(956004)(16526019)(26005)(186003)(31696002)(2616005)(8676002)(36756003)(6486002)(53546011)(8936002)(5660300002)(66946007)(4326008)(4744005)(66556008)(54906003)(52116002)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dJoWDlB54aIyBnfJHCPMxnMQ6eE6bpmucQ/EpGab8bIlQwjzlB0ivopKQRmfon1U3skrGjHinfvuXKjHPdF7x6zn4JD+ci0tuApQ32Q3oqNigQpy4tPmtPiQ30IAREwWTPfeh8xOx1eQrvyvZ2WI1JV8LLs3Xl8HKtEXAQ5g/F34DdW+aeISYPa7bSqwTGwr16R5Q3Ii3S4DyXMBUUmoELAgr8rrSwHFXEtGpMV/o31IDR8bNbpfC/ZwlM31XGbGkffCP4LGlKdXsjlqMMNLJG5c0bxe3aGEdx1p8oQKKMHJP4Vo1wfyxvAm0BCJhXdmK92vRNkcTVOmvW52sl0LTfzedsfMeklrycupDvIkn79dznu1Ke8ncSL+OUpKDr4hMDWbPGZlLVckidGRSkAiEmj9CODunNGqqrLiD2hiQKTcQH80bnlRecx2o4mNgJqtuKkXLmmc8tZa/ZghLdYK6OcqPTEf7PbTn7W1X+kiFEg=
X-MS-Exchange-CrossTenant-Network-Message-Id: b94fee72-0724-4f54-dfbe-08d803163e51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 14:48:54.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6hDWnLnEtZyLCVLL9n8pcYk/nU/nZaREXWmQq6P/w3BdC570KBaVkMXx3BnHOmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3414
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 priorityscore=1501 cotscore=-2147483648 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=868 adultscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280103
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/20 7:22 AM, Christoph Hellwig wrote:
> The following changes since commit b69e2ef24b7b4867f80f47e2781e95d0bacd15cb:
> 
>   nvme-pci: dma read memory barrier for completions (2020-05-12 18:02:24 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.7

Pulled, thanks.

-- 
Jens Axboe

