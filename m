Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EDCC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 02:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1337E64E01
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 02:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCSClm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 22:41:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhCSClf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 22:41:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J2e6ED013073;
        Fri, 19 Mar 2021 02:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=GTrNvhe8+Y5Vq1ceWzrEC5+07NuJTbQXpCgZZGL7LYs=;
 b=bG6cb0whij1Gf3b8RCr+MmapI7v+LPCkembBBC/BfhuDxcHPislgx4VqTIKPLT9V0u8Y
 Tiz83MLsEetDkzFxxeLbM5ZuvLCNj7zz5iTMcXE1r5bfDrh6wEDifJK3cLpZplWxP8o3
 ZUCOSpLwcZhneeyIJrD2iBPEBPxHgY27oj/Vb2g1oEvgDPeylVhOYK8EIM33V5Hrs8/a
 VyCueSYrZG4Gaiy2R+J2s897xfgM1hzbJoahudYYTLn2//tPp1EhXEPo+EqMycUQnLqL
 cZ5ZGOZ78T9Biph2WMKivGklQgVdjyDoWN1sentu9eZwBIF3lWDw0Dm+BbmgCfINXp9G 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1p1dgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 02:41:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J2e9NL188880;
        Fri, 19 Mar 2021 02:41:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 3797b3qa1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 02:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxZWkRaASu81SLEh9tSLdFDvWx7yby+RNvillt/hQTqncBXzWmjzBklZTtgacRMFSudOzCeK7SmiXxVCTLucgeQBwYBIpTOfS55Bx8p5dyjbLmRZRIh4bXOyapSAb/aum1SlZYy5UcIrXuTg7X4mGBeMhvrWmgeDaadJQOF/EqVxK0yEZJXs1wk/y4DkZgiFFESBL5rTK82cO6EzW/xXf//j8qf+QE1OCuthS7+pvV4/NGG7H9c4fmAc+06EsNtceOsQBFJ3HkleQY9uLOPeKmbR0DBgeyWP4g5i8XlVEVWosQEGHV4qffWcxoDIPLRwY8zAdbn5PK891EOE8t84Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTrNvhe8+Y5Vq1ceWzrEC5+07NuJTbQXpCgZZGL7LYs=;
 b=MEt8yYo+YOvJuufDJsdn8yTQAuOayZlspeub6OIbYInZQ+zvFHShOlO44fvioVfGWb+XhTmoXiR1nrwi0HE3LXHXl/weF+k7Ye4iFZNb0o1z1FcNvjCAJzYrzFInJBpc8Y6bC1+Fi7DdHoomOMrpmBdwf8uqvBUciwcRjJnAp93CnQ8DhIXc2WSAFdtGtFKrlUmQ+2e0nA96nlT6qHUaZL8n70yKVQTb3IPPe6U8kxGbBZqrMLTcRR5fg/6KC4zLcFPY8hQuumjjyIgCe2xPJ9A/Na9z6ksX5doKtnUsCmADrHa3fcLgjMHOdcSch9juet8fRgv5D82RwVWNrLpSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTrNvhe8+Y5Vq1ceWzrEC5+07NuJTbQXpCgZZGL7LYs=;
 b=oTZZe8pa6cnttHxc+7mHXWIXUcAo/cNsvpkMTrqXBqbYr1FE8CuDM0dgkBZNIYvKsS+IKZolG8e/cK5lGBCwfKoEB3qcDoa1EhXtOtAbodp8IxRGHv8NK+A70R82L0BFLKonuhE/6wvlBNPoLwhvBeRvO/OMYasZ5+/K3t6sYBI=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 02:41:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 02:41:20 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2] sbitmap: Silence a debug kernel warning triggered by
 sbitmap_put()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1blbfq32s.fsf@ca-mkp.ca.oracle.com>
References: <20210317032648.9080-1-bvanassche@acm.org>
Date:   Thu, 18 Mar 2021 22:41:18 -0400
In-Reply-To: <20210317032648.9080-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Tue, 16 Mar 2021 20:26:48 -0700")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 02:41:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e61e33-1c73-4c8e-f30f-08d8ea807a75
X-MS-TrafficTypeDiagnostic: PH0PR10MB4535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4535110D144463AE165299328E689@PH0PR10MB4535.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rupNBvDY/FJrG/bLeW8h3iUaZI7LPLqIxcq1MxJtch/CUNnbkQZB7YkcOTrqjn4mXzSNvWWD5TMg50/qnksS5aJn7xmy0FDlsCfhmqzvweHMQW6afKUObtWSP4f/VT8OfeQf85LqEaN4jPKP7A7wn/OygMZDkYy+9TRFq8lbqc/fLRJ68riEXydmWx3qmC3+CMc+mFzaLz8wgmhyERrJ+LS1KpjS/Vz2HlfmCMCDtyv0dP1w99sDYo7IHrDlDFVxZBs7758n8yasd0vo2hTb6BaDtRhaLXK20o539WGsjbytsHrOKhq8SxzS1QlZYsvkUomTF/cuAhxHnfv4cBqu3N3MJCopZtLkxhctJQ16E0xEFr9YqiDjEqFZibo48dyQO2BEFn+7XO/vgiNYaMtrrdsRBIk07tq+bZlF9G2t7cVqo1dd/g3D6ygVdwK5iAfHtioES56RZehyRIJhUXar5Z3kFjdMSrxBnLc3x7R5uQe2ORX+9OXxeUGSn+NLzPmjmoYADUrHo6jsknltNqCcemYelXsZj55OfYXVi12TQkR7b87JuOLQxebvwnMjGTI06FgBwpqP7hjL75zZryYZZohh8s7w1UVTsdrOp3k6HunJWhIyDTh1FmNKumapICNvvF2vHidkpNyn78luFZx66Lj1IUIKjQd3pEEqRUn0G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39860400002)(8676002)(4326008)(186003)(16526019)(26005)(956004)(66946007)(2906002)(55016002)(6916009)(4744005)(316002)(38100700001)(478600001)(8936002)(66476007)(5660300002)(86362001)(7696005)(52116002)(54906003)(83380400001)(66556008)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9MXhkTruSkzyx7qHU+ZM9p5OEhd+ovU5RKwuJlNdATeIRxXnEuyhA1ewCAW4?=
 =?us-ascii?Q?08yzrRnsSTTvr8bZQYoCejviNeQsAV0e4CTV9zAfTvSDr2dqpYzcEHW0j3by?=
 =?us-ascii?Q?RI6nmM/OoP7D/7J6KxnTtGz2toY56XK3rJJupT+xMmgIoyfY6g76MOjr4IQx?=
 =?us-ascii?Q?IyPQd8M/OnHODXET5prOhWs1HkuOyUrLsgQ+uGwbqxgYLXV81Z0ke6/PzKmU?=
 =?us-ascii?Q?vphfgixY67KFIuL9sDS7nnuPiu+D2US23c5EHSoq6qw+oJWe52tL3Wgdi3Qo?=
 =?us-ascii?Q?PJdLzksagSLfO+RumlATd4QYjKRyItZQJgGvFmBn69H+caBVGIp91IoAS9H1?=
 =?us-ascii?Q?ge74t/fcSGF/4AHo8HGiweL1Uui8Sud4DhojCGRDCaJR3nG2Ido2IIqkueO3?=
 =?us-ascii?Q?hoiJobMn76a0dZZLl9vVql82rT8FkKHxm9DbOrF1aorh8WHJyStCxYGuXWHM?=
 =?us-ascii?Q?zN5el8Vf+AloFyxMJhWRkwN5FFN/vV9vr/ZrUYQf6cCy/KfQ5ah1RvZmzyWO?=
 =?us-ascii?Q?NaqCC5vNWJAInhurWsARUmhOH6Co0mStI4M8yq0ycTOCXMjFup37ca04YsR/?=
 =?us-ascii?Q?Phls48xRtOQIdZr2myaZuSBUxNh9Bqp1nKNmZow4ltR+kK1LGoFE8sILqGbc?=
 =?us-ascii?Q?ju+CAMMScPxc+Vw2UnclGsmZ2xqvJlLv6e5b9EHqGrhXS3PlTXCH5luRfipi?=
 =?us-ascii?Q?BGvVRtenDpwpAc4Js+gjy6VckZnPbTmjRnMPGncJKYln67m7XTBuTTB/agFe?=
 =?us-ascii?Q?nF954D/RruuYwI54GkkwuWCDemAtR4LxR1BbFIWHuVWeoX2qAJ4XqdudtqZK?=
 =?us-ascii?Q?QS6SvLQnxJY2yKPlktZxCyubG4dnQAfoSr4TpwTAWYFOWpZd87pCub8/Wf/F?=
 =?us-ascii?Q?4QUMb0JSGnC25W9zb3VipCtKRxGNlb71e6vT6oCJ9ZDrZIBEIBMC0+XOGZ+k?=
 =?us-ascii?Q?UnLN1CvcLf/n9qGCaBkQT7zIE1poJSzS0+7Bjg3IxOYqncW9PCnIDb74Fyuh?=
 =?us-ascii?Q?YxhZXrsGKIhUDH5Z7j5Y4WeBgxP5oiM5g2PIfUqrD5VQHGp+NxMEGSdM0GeO?=
 =?us-ascii?Q?YME+eOMzHIbk2RGWot8z066T7e24aYnaZQAaEWpDe05scduVqiyNzPev8BMD?=
 =?us-ascii?Q?2me9T0AEcXCJ2DLkNBDq+qLHzkedNjitLRhWej8CzVF5O+Ywgw/mi99OXmFD?=
 =?us-ascii?Q?TwZO+CTYozRbH6KGI88Iy0YQuz2QjveVLGVAZznvWuybLq7rEgOrGcO7CRKv?=
 =?us-ascii?Q?KbvfqmDDH0NYdHQAkFJAfC1VHF3z05ir9uj7PiFDcQRBYqdZLHIHVgJaolSh?=
 =?us-ascii?Q?70sMFyTCRMOME3ibzKuPFOwG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e61e33-1c73-4c8e-f30f-08d8ea807a75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 02:41:20.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaA1s7p2OE9zASf2I0RldXHBxbevUmTfRmQDsLekzI6OGCz0nZJG/3/kcrkc1Iv1NTbMBTT0ksh32CZ8OLAKwqMLqWFLqDX06lBu7tZdTQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190018
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190018
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> All sbitmap code uses implied preemption protection to update
> sb->alloc_hint except sbitmap_put(). Using implied preemption
> protection is safe since the value of sb->alloc_hint only affects
> performance of sbitmap allocations but not their correctness. Change
> this_cpu_ptr() in sbitmap_put() into raw_cpu_ptr() to suppress the
> following kernel warning that appears with preemption debugging
> enabled (CONFIG_DEBUG_PREEMPT):

Applied to 5.13/scsi-staging, thanks! (Since Ming's series is queued in
the SCSI tree).

-- 
Martin K. Petersen	Oracle Linux Engineering
