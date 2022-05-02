Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0287C433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbiEBUus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiEBUur (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 16:50:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B758C60FD
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 13:47:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242IbwJU026110;
        Mon, 2 May 2022 20:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8uZk+ymJ8TeOEjrZ6jEZL0WuMF8+01acd9nTSI2+Als=;
 b=DdtKsBAJXo3bUitmlqSD1tRADEzbuUO8LyUTCu5pn1k171QCqLOlqpIiXXpPB11WFu/T
 EpK2vLZ3B5BGXV/0QFSiwUZEDsh0JY/cns40fcwg5PIHcv6HF2ZoWoJQD2+JGnk2xDaH
 C5Y7nFCEGxRFKKDglqR34W3BEqxLBPR+mz5p6GISdwd7wWsUVRZgZ8jrBG8VPedF0ONS
 LP1kOUkb1Yo6H+sICUKYegh+O8Rgkw9e57WxYo+2peQ4YWZ2b3nBVtEkJ9CTv61tZ5Mk
 hOuvC21C3qhqIGIQ8ZOXdfbN8iEXpinxZzql5dqAapfeZGEqqMe415AQ4A+VkEXaQzDc lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc49sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 20:47:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242KZOBG037858;
        Mon, 2 May 2022 20:47:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbkrrph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 20:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ9C9eKlAI4JrWl67kQIyxm12u3PjUMZC58uSEMAloJbdwhJPtXDMvoXv+T2sNTM2MrlzvEh1zGLo4is5A3V8YuwJH+yKbuNdbPoy7F+ceU5lo9rd1nFxo7T3ne5IHWZZLbpEo4YxQb6LJgvM5KDA8BwypChAJKXRES0TGPnFRrhUTnrFgoAxtwhzsrmAy6/+Y551zv8r2JYF2muOh9BaUs39X+IGRin0AoVYXcuBDTmkBE0nGLWnP9AGTNgBrzyukJcYkcSXJm9eBPDnDTSHRNzw4VFnz2FACByZI28EwFBZWt2RaT2p28pEQw9k1jU6LrjPdMwcFgW7WQrpFWWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uZk+ymJ8TeOEjrZ6jEZL0WuMF8+01acd9nTSI2+Als=;
 b=LLyZr/5MsqBwfOzAhv3lWJjjN5sxnqpfCH1Q5Z3Y1clYFkY2NY3QSgC4UipTPtGDe8+6DWX24IOSAnf3lmM0NmOyTwMNDR3QlFyQY3iYvU/8agTIWsLQ7L22yIGlkd4ooIrPCGm41UyUdjtk7FAQTloRbY9ckH5OMFFFspQvgo/aD35b1FpSG4DnEQ2rxTa1iPj9bDz8L4nieJImrpb5manYQdW4Xhzh7pu3VvO+xbeqMjpguKV0SuN5XICH07UWkrwUo/3n79EUNaYaGPy+4Xp8UiJunZPqFkPSG/LX20Q7XQfUHDLkdjHHlh+kwBygzHScb9You6KBNfLL3tiJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uZk+ymJ8TeOEjrZ6jEZL0WuMF8+01acd9nTSI2+Als=;
 b=x18+2syIMWiF0f+r7w8NE4MgrUgpuQAxAXOcWioG+Xd3PeWfGH05X+pZko4LfwHqLl/RY2iOu4vS7IhXXWzFSLHjHX49BJyY1QoBKLfeDAi8r/j8NAuR5gJ5XkgDozCQDa1KxSXR6l7HF7tCPLHSNwnzzIjmB31FWdVahC8Bo6o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5187.namprd10.prod.outlook.com (2603:10b6:208:334::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Mon, 2 May
 2022 20:47:08 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 20:47:08 +0000
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfprd5so.fsf@ca-mkp.ca.oracle.com>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
        <87y1zjq14c.fsf@collabora.com> <yq1h767epmx.fsf@ca-mkp.ca.oracle.com>
        <CACGdZY+=Ugn0vd4+zsFoKwHp6f3Rv27wdssgvSoS_Onoi1yXUw@mail.gmail.com>
        <yq1y1zjd6am.fsf@ca-mkp.ca.oracle.com>
        <8b731c39-4b41-6b41-08c1-9467f9dbf293@suse.de>
Date:   Mon, 02 May 2022 16:47:06 -0400
In-Reply-To: <8b731c39-4b41-6b41-08c1-9467f9dbf293@suse.de> (Hannes Reinecke's
        message of "Mon, 2 May 2022 13:38:46 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f68fc6f9-c9bb-472f-d90b-08da2c7cec5d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5187:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB51874B1DA800F0B2FFDD77BA8EC19@BLAPR10MB5187.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRFLy0wtBNU0twvPlwbrQfXYWDzWeZYkZfiKv/m2kMxaXWHIFg1+qg8WandrtYX+lryckJ5AakmGIGi0+PYY4fgd7IoqqNkjCSSYK/1wD2hAmMJAACFRYEqVl2Xnwak4UnA72hgxyeqDlit79U+EX4Q9Ib+Y60f1uKaQrgvijpLQvMNuVLUDHX0g3Zhhb1xwNnLd5j2yEFr+sPdWhevRJUHYruEYk2BXWy1V/vXLczWciYVkkAfcgG03+OUymCtB9YrNv1vXPbaoHBhBYL87mYbmjJhEfvbVKcr3nHTc0vR/2JhGjwV+mDd/ZioxVFO7wh9ePoNkkgwabSEg5SJEOBVa1vNV+H+f0grnVXzR0rR80+UOK2LDkKBxgo97GYZPvBDQzP6eG08Ve7aR8epa5czauoH+ketJUE3abtmZCMaqecAAapj6z/2Ywam5YNswHygys0VoqK9aI9OrQoXFOMNCgDfIIJdSb9pI21MhXQazYEUhZXNmPlySEAY08qyb5Vpt59werHTHMJP6MNTJJYywNHBkcOqYVT03cIXgLNmudt8WLj3Gp96q2qE3DmXdHe1H3Lo393t3kQqozZYo4qLohxtDWBz88Pi1pkobQiy7eXU8whzSDpR+3+fDlhHzeBLAvdWQorZtLe9vep1cbxIJzeThSqShqp/cElQWttDI2IMsT7KUKh1Rt54HmypSXg91ErpAZP4nFBYil/2MIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38350700002)(54906003)(6916009)(38100700002)(186003)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(508600001)(52116002)(6486002)(6512007)(26005)(36916002)(6506007)(5660300002)(2906002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19paW9R0IuNE2Hx/HzbvrM+Zx8s7YlFDG7jDahAiNcOO+1/uNxvzvWF2jvzw?=
 =?us-ascii?Q?n6dPoZ2ACvf2G4ipdx/u602X6umYcPcFnCLZ+yxgNTYTRNfAB3lFN5KYyjJn?=
 =?us-ascii?Q?9jguSYHGbGepOHhFvkP8kXuPn/V/pFOfuMPhGXSA/L0/AxO/En45TrABmiKj?=
 =?us-ascii?Q?4RIkBGpbDIJfOJCvIT5QfyWkKcAfPDtgma0RU5XlF7tPDnyMj0zIshqaV6qv?=
 =?us-ascii?Q?k4Bx7JABqI3T3VVR0dfiCOQ38HPrj5B5dM5W4vvJi/bwuqWjV5YSe5h/4n4F?=
 =?us-ascii?Q?h/okuWjaHsUZ7hXYHDoZWZu6TRR/Ap7HlRtw4VKAZMqI1mW47ejH+894Kvav?=
 =?us-ascii?Q?DgK8d6Ax8sps9FmRKfGd5FTUWAOyeMxMeNkh/waMHBOdZl1PlP9zEgpycP+M?=
 =?us-ascii?Q?Zunc2NJ21xXDhezi6NJYqwHTObFXUAOtbssCnQxDAU6SZMzKFoGoVzEAtsqE?=
 =?us-ascii?Q?szpKkhc58Gs9heHSJgsFBnP49WAdpEn+ixKYgfQEjCsCQ6TjV57ZqV22WjAz?=
 =?us-ascii?Q?lv5eibBm7aTdHaFi+FB5/6L8f/XTeudCprRBpKqTi7PJY5v9oEz4k6LrTPYu?=
 =?us-ascii?Q?rJn73b8rFP5qXoatcFbb4HZ1Eo9NWHjaig2Hgtxq+FUQrj3T5sJvoF7OCw4z?=
 =?us-ascii?Q?QH8WNjKQPNfuGTvUPqpLo8aDingspvOfei7SVk1fpz1X+d7e67KhoE6RjDAu?=
 =?us-ascii?Q?zZMeoEDZuvGRByQUh8SMUsyyREH6zg5ZoC3/oEySYht+DOvUoqliTikHx3FL?=
 =?us-ascii?Q?CEUfEuA6O4NL7sTRN++Mk8mLnzQ6onQd7jbmU1Kdmu0JQFlmi/zk4fyao0NF?=
 =?us-ascii?Q?eS4LP8gD4UQJnjW/TorlIFOZNAkON7mqusX3QYOsJ0iqqGXs3kk/BPbT+3Ny?=
 =?us-ascii?Q?6D4fJQVHiAvfKEJz+z5/3k95b6ipWziZmUG262AeTwj3f+lb+wQO4bTYKRMA?=
 =?us-ascii?Q?M4p7H03OLC/n9GSYs6ZH0dG2ro8+H9lJppm56OPa0Q5pNb84idGNNG9yxKST?=
 =?us-ascii?Q?1A/leHii8q7PcX2rGumPH4sXUzJTTKPgG8yXc2dhZFIjV9arwSnzbxSZ94Vo?=
 =?us-ascii?Q?i3Ha4cyjInZKhCk+Yuld/uCR583dJfJg4Anh1n/rf0r5FhHv+dcK12EL5Ws4?=
 =?us-ascii?Q?88P8Yipod9nJjPrxaGvLHTG6BwP7TnSjHYzmfiO5xQlTzEwdpYjXK51Vv5aN?=
 =?us-ascii?Q?M1zpo8+2xsHPQFrd0vzi/3s+XhLCy/j2RU5UBMFYiDyq134ejq2pX7Q/1sbR?=
 =?us-ascii?Q?bMb6tNinfG7hlN3tie3R/YujuLaqx1GqakYnuBXLAy0fV3v/4s1NhOXXhEYt?=
 =?us-ascii?Q?Q973afEzL9hUrQ6/Gy7TmYPrde0ANWFUM194SJSVbS3O/b+IT2VMstxuNzaA?=
 =?us-ascii?Q?DijkH4Ec1aPf8vbEjZ9kJvosHW3APSYfifBkLQ0OIHqT/M+6F31rj0zqrD3Z?=
 =?us-ascii?Q?+Vh0qzWHzdnOA42LLRe3mc06SUqCKQj0vzwDM+trRQxPzKgXQ7avUtU2JYkg?=
 =?us-ascii?Q?vCs0zKtrYAZxWfeEeKirG8pADrx27itLC3TJbNMra30ycXiNoLXZqgH1H21o?=
 =?us-ascii?Q?ol4IYfxHGpjZWyPg4d9tRBflOqCsycAb4HJ+94kROJimf/IUOIPdm+E57Ed/?=
 =?us-ascii?Q?8oPR5os8EymHkc8rtwvaX/B5HaWCyO/wq7URtaKUmzNoytX5EBJZI3UywdKJ?=
 =?us-ascii?Q?4tL+2UHWi36v6Zf26MYM9ncm604bXXiuXwehyEUHYyBnPWnIk8/R02UV6vux?=
 =?us-ascii?Q?Gn/02asea1YvTzcGuroR07VI6qHUs4w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68fc6f9-c9bb-472f-d90b-08da2c7cec5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 20:47:08.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpCsXVjVCup5Sv4sd6SNCq0mQXngaVdktZobnkC2DO/0NeUOmVc3H4sJnJon1haJx/DdTCXNuntWl2j+UQRTMI5PDZCpMb2K6KMrkbsSFmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5187
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_06:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020153
X-Proofpoint-GUID: dURboSDQtvjsUqJciguIv2MScNhltcZ-
X-Proofpoint-ORIG-GUID: dURboSDQtvjsUqJciguIv2MScNhltcZ-
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hannes,

> Actually, I'd rather turn this around such that error injection is
> running _on top_ of eBPF...

That would be great. Relying on eBPF does add quite a bit of complexity
in the dependencies department compared to 'echo foo > /sys/debug/bar',
though...

-- 
Martin K. Petersen	Oracle Linux Engineering
