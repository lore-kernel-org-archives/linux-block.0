Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294A4C77B7C
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 01:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjDZBXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 21:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbjDZBXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 21:23:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C97285
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 18:23:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PME9dX012721;
        Wed, 26 Apr 2023 01:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XIzkXusoDAfbTW+nuknJuINrKQCRlQh8SHTYh4aUGSg=;
 b=EYpSLS+7ZgrA0g1GHrbb/7Kas8/jcosoMwAxOrNVGTh0NcNsHU4wtJQW8/6ppCBCRTDl
 NPD1Mmm/dL67PNxsaOf8mknVCs2h4qBVONEMd8A4Ohf5+mL1JrbWQTc7aYn4CiGJH7ax
 L9GfXQxHCOhjRuWujFM2jCNu9drHU+MDoPuy1+nJQsEZcBITpphucuQ1I7milZo3GONz
 QR7YpTLwWGGUPrqzQMwcNjA6p3ne9EfypYfN+ScuqFL5378cET5tCw9BOfAChf9BWddw
 gP6lRVELAjJ9u3VJCqRMuhG34yz+/bAoKYqSRuvqREMUfgQdxm9YpUxLLbMe7MydUzkS Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d87e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 01:22:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PNjd1O013308;
        Wed, 26 Apr 2023 01:22:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q46171bwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 01:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL2USRMsf5Nga3hubOlSTaRnxK0czpZZE9w9beT4i9GgJxQwjbclH5SYSvrw/iPhCEZJws46RBtymg3NtI52qHXxFovzAh93mCt8w3nmq8+TzOjamutIS47d+RG9cpfcPSUeMarA4Wzk8Gu1HvRChcgsim24nBAV8xkKW+zAwBZrRodNZnbGjKuYxYppWNkJwrVFlp2RFlT4tfawQiroKVo17fgl1vi9BE+EuC+IlARN68nxvG/ljACj7tKcmEErx7L9K3ebtIZzdeQCmS1Lmwb+APqWS77Ku1vEexupbPcKCj2H46UgTfpx5s6hPaFcj7/apdONRg+cOyu9k2tLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIzkXusoDAfbTW+nuknJuINrKQCRlQh8SHTYh4aUGSg=;
 b=gCotLtS8/71MxNvSm5arZWfyjK+xQ4Q5HfB5oDz45QCO7s9FoSLEFG7hDWxxlKjMTUdYbO62GXEHHr/6g9w5Gq18G8fvJEM/n9vlj15lBTjeydhFIirrg1+EuiAbS3oncjhto8E1URr86T1DXUIf4saJNA5EkgMDvd5kaslXpiuBj4wMrtY1Y+jRl++/ivtndzJnQ7D0yD6Y3w5NTUXyLi0y5qv4DoqUbhisgtSk1fDgncFng6gpFBJYcjioiGBzMG/cX8cM/S4BCQmb4xsGl0yjMPjE8xlzbq5fpLr6ySPEOjR6WzMy47emimjeAigjRm2JTAYQ6I7vqdqO4V9i/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIzkXusoDAfbTW+nuknJuINrKQCRlQh8SHTYh4aUGSg=;
 b=MgzXsFuF0cYr4YuMZ25/p1pCfIlEFDTgfMIJXmreh9LnPfwC/5+VlhqRayJLjj7fITqJjZaabe5Iqm2lf/u2GcJb8FWtXaRqxQi2/u1ZpoSR9oElz9H2CnO7bxuklq1egTPRySPM7siGEf46JKNrPGQryxeyTngka8ZtQb+rjP4=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 26 Apr
 2023 01:22:41 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b846:21bf:b5cf:67a4]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b846:21bf:b5cf:67a4%5]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 01:22:41 +0000
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org, hare@suse.de,
        kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        oren@nvidia.com, oevron@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 2/2] nvme-multipath: fix path failover for integrity ns
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1mfihx3.fsf@ca-mkp.ca.oracle.com>
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
        <20230424225442.18916-3-mgurtovoy@nvidia.com>
        <yq1jzy0lnyl.fsf@ca-mkp.ca.oracle.com>
        <85974694-c544-be82-97ce-c318adacda49@nvidia.com>
Date:   Tue, 25 Apr 2023 21:22:33 -0400
In-Reply-To: <85974694-c544-be82-97ce-c318adacda49@nvidia.com> (Max Gurtovoy's
        message of "Tue, 25 Apr 2023 13:24:31 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::23) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|SN7PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af1098f-7de2-4fc6-c814-08db45f4baf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ilhg7lhoWGqLXbAt8021uYwPB04rtBTZZIo+/0ZEbi0Es1WNiE1uAaZkqGSa326AC9PB5wc1OEoxAslpcyYg0dHed3HjvPTdHE0h85uSIHTKeQ6npkhXKaQjAyhjECIcsBhP/0UUEMFp1StsN17GxAHwfGjijQP3u1ZU0XFjFXoQ6iSSEeP9CDOapMhPw4U53GIGU/+FTG525/MEBB1K0VeURj/Jdvo/y5wg4LYZmAn/Td+E+PZ6fNhRt6D/pAkj+nWQ7lMJwCUg9/+5i9+dZacCRaNejl3E0idVzjlMMF2QFja+WSCNi65llEInUxSqB1FUrOz0UHVJarhQUGe4gKX5a++xHocBHwYuPGTXYfVfTS0NdDP1eTBCjnyFHnSvnE9pzOsK2/H3+esZ05lY84H4pHTv0oNFgwFT4WTzwrH18dFWntmHkBEftHXL961SFANOAmDQUU7DD3qOfMsZHe4r7ASn9g/Hl8hsbP6/adgJEjZXn0PzOrCLhh/bGGbAyVZCj7C1bD+pm86BHiFvJxysCAa7ey1SGiIIe25dhTaXYscDVAufkECmLoNx7QlX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(478600001)(6666004)(7416002)(38100700002)(186003)(36916002)(316002)(66556008)(66476007)(83380400001)(41300700001)(4326008)(26005)(86362001)(6512007)(6506007)(66946007)(6486002)(6916009)(5660300002)(2906002)(4744005)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ay4E6FjZoWMrZrzaK0iGl42fa0TEvT3HfSs0L39uzIxJKzPksOnK/tMHQpba?=
 =?us-ascii?Q?0Y3qDf0c2l84Ac3m9GirDQ06aHnsMWUw1F7q8EuOrlcxo7eCgHSktpax42sH?=
 =?us-ascii?Q?Ei7qoeDhAzYLoU8ZU9smS4ETWVGEW8nscBpG1vDwkOzUlTfgPBOaXNGES6lY?=
 =?us-ascii?Q?o7+EAGPQLkNbSSW+Sx5fXguQd2kEQTA+jyfZh/k5VzYe/AmkK+WS5ghqr/IT?=
 =?us-ascii?Q?vXuPINfb6ngvejFfD4ROZi1t5tG1YXyL+5Qi4GLTo+cw5D4atiUdeac7aoNZ?=
 =?us-ascii?Q?Ni44qsLWzsmM/E4MqzVpPBsgNRPixG/zBVsZgiqmcTHCvlbZUYUXvU9j2tyY?=
 =?us-ascii?Q?jkazHRLa4NF4kZZ4sIbMQNY1jblGsS0RP5epkdClD9Jp/tpB1Q4OUikRtBX7?=
 =?us-ascii?Q?ThCV8jx1VDaVzGugmczA7+tpGwxKU7qCkEr2KoO25LJzlCSjJgbk8q7AX97+?=
 =?us-ascii?Q?bo8A1tKJlJTCLbx8XOS/aCXc0A3vszi9EPD1OCn0ff7BrJZws+Ei3lTorWJY?=
 =?us-ascii?Q?LSHwKL+iXxBoArZvoNLT7kWUAhnisbv0cZlT1BtfIHjTOhtDrIekVpLZ7EJE?=
 =?us-ascii?Q?cXBD1mWYLPGPzaVpMNkjDiML6e3cBRseEU3uv5RGx+INj1sVE/0/pl2nHU2n?=
 =?us-ascii?Q?8u6pavjY/mcf7u7rV3Gfrv02FPNafuq3yi+mty6g53gzyW5xFf9y5MVdJSiY?=
 =?us-ascii?Q?SlotCw69xMH+4wZtJ2Y/e7Uv2fvmLDPUCd/62A3OKN6pZ6BpIqClJuN1Y3qt?=
 =?us-ascii?Q?rs35eFo/y7y/BI4d/RDIQsa/nZM4/EwBGnqVr5D/MM4UP9VENV4wvZfWIjpC?=
 =?us-ascii?Q?DPzqkDBAVKxKbKIJAWG7RCEhB3JTkBuH6hzwQlwaiBBNo+vbZ75x6vGiD08C?=
 =?us-ascii?Q?5n8YvIMYENL855yQKA+A11Pw1Kk4z7sUYXGgh0x9YiRk//EVxfKcVw3EgLYO?=
 =?us-ascii?Q?HPIDD7ZNs/TW8Kk4eAs/bs5R+luE9xBl3oqzxGsdvjm4vKkv7n2Br73t2YR2?=
 =?us-ascii?Q?XhR5o3jcSnYUXn4FjACRsTvX7MtCw/xuwF1oy/brTAfox9tAnqbnNmm9g0FL?=
 =?us-ascii?Q?bPRpFyh8GmBvHQl+TZhMgFUF1HLMiEQM7PGOwzSiBSrYOAJ/sLowmOaxrGg2?=
 =?us-ascii?Q?oYYDNupim0/SyEkWS60nozVftzz/DVr75PzzF4vrgvo80kLGuBerYTFftRz6?=
 =?us-ascii?Q?LN+SIZJFt5qrnHAt/iFXA23NjVaQkhKwkg7hJ7lTbDZ6s+iKA535rpCIeH/7?=
 =?us-ascii?Q?NOxeTttijZsv/qsv2kokueqruUENBq+gPCS7VFIGj55gCmGXH/8hKq+slt3p?=
 =?us-ascii?Q?9kDQc0keyW0fKh+F2VgXXXeoRI9a9/D7kzeKUeLlovFAHv+mh88itpuh2wp9?=
 =?us-ascii?Q?gOlF1vsO73xAV8IRsRxfL9YffvUvmrZ0D9y+2dXWqwEnm/yWXKaoMxRvt51P?=
 =?us-ascii?Q?eEa83EEwK6C7Q7CBMlzOxDn3PEWYh/FUKI5U1eh3FojTvnkLtDUN1yVRhXyR?=
 =?us-ascii?Q?GVrvpxiRU1v2DjEFXY8aVcIm/FVwm6NCilJjxsElvAfNNh60xpTpEiQxLKzM?=
 =?us-ascii?Q?gh4uWmBAOIw/DORCWG1ldgsLLS8rRxWpKQKNO/QzH9FBlrbrJ0HivcvW3UdN?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dO+PwgYZ0ztKAlDygwr3g5fdyA6JiILqabBeLH9GiYHUENxFNN84Z9DFbHWp?=
 =?us-ascii?Q?29rddHoam40H/mfylKvDUlxU59LWd6qzQReu1ri7U7rxGQQSq75Empex6zlt?=
 =?us-ascii?Q?GYzFSE7fHgArBk7KXSfYlddlVcQdB1FNAzJUYVpGxtPYc9iWp3k3ihrhRXL7?=
 =?us-ascii?Q?H1sOgsAQySp6FZJyoSmWBV44CkJJMhZVdzscw5D6dxj6DCQxXIBAa7T12I6t?=
 =?us-ascii?Q?XEriYEeqzo9J1VwlTTzsEzcH4/J8mtw9CHdk7HQBgrHpK6OJfYkPOFWKx2JP?=
 =?us-ascii?Q?A6PN35dg2Ig6+ShiqJzVrNhC2Om4c0sPsGZPNqdRzQZZTHIkZPpis4dtAf1X?=
 =?us-ascii?Q?569Bicq+zVIxtRWVRMtHv3Ldt2le25jQJxMtWHjfLMiZ9nZZWugYMLuyRchs?=
 =?us-ascii?Q?n6MRCIeiqL0crv2Wn820lwuHZboqyxiN1jEFqtAmcHqnEYwQBzYTcWnP+XuD?=
 =?us-ascii?Q?LM8JaeUBdn5nbj7SPuxPApJ5BYPoMmZcWiMlR2cFr8w9mtUdkz+95QMbPg3H?=
 =?us-ascii?Q?90uYMI+SwXHXRo/VPB+nXUgTaMCSAy2CjC5BhTokBnENjmg7MuxrIEyrdW+2?=
 =?us-ascii?Q?/gmNDxd1HmvmzXAJR3QsdTKKxIIvPD0nX71ptROWFU/3SlNvDD70cF8XSGQS?=
 =?us-ascii?Q?RwYZ8tGxairzCq3+B3IpObf4zBPoGInEq/jd5YuRAkZdfSCJ8tTwQW85Hsg1?=
 =?us-ascii?Q?ZaF1NDb+n7ptyV+mExGM3jf1xDoaR4jxQhvfsb/P8Nxr4N4tnjZ30WmPeKM6?=
 =?us-ascii?Q?t5o8Dg75TQIMh3P+prQDO3EjE1xFhqZiU2mX2ckKsgmClMpi+sh8V2ie4s8C?=
 =?us-ascii?Q?6slwtvhtq/OB86d/lFNlxHW3AQT884fnRnubZwUzvQTE7pmmVnwVOsYNpdw1?=
 =?us-ascii?Q?iT8SpOK2MMTgFJyLUUkvT5vQK/Z9S9hb6pACv7Kgd9N1ucRi+BFLuYavDXnB?=
 =?us-ascii?Q?/SQ9923oZ1HmHcx2AbvW/K1v2kzBgDcH2ZhKfJvDloY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af1098f-7de2-4fc6-c814-08db45f4baf9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 01:22:41.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nL3ycbAQ50F9TbXTj7DxcI8bVfMSMVGRdkwZFro7yoLvQnAxc+mLngja4V8QWtPUFkpW/SXAIDp3EAkiK22N3ulHD16oKN67+qV+cht6jZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_11,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=744 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260010
X-Proofpoint-GUID: t-c_Ru2pV8WjeBYFtbGPLJYSVoP-ZZaz
X-Proofpoint-ORIG-GUID: t-c_Ru2pV8WjeBYFtbGPLJYSVoP-ZZaz
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Max!

> The way I see it now, and I might be wrong, is that the Linux kernel
> is not supporting application to store apptag values unless it's using
> some passthrough command.

As Keith mentioned, there are various ways.

But let's assume you are a multipathed storage device that says "Yes, I
support encryption". And then one of the paths doesn't and just lets
things go across the wire in plain text.

I think most people would agree that would be a *bad* thing.

The expectation is that when a device reports that a capability is
enabled, that this capability is actually effective. Protection
information is no different. The PI is part of the data and it needs to
be validated by the recipient.

Silently throwing away the protection information defies the very
premise of why data integrity protection was defined in the first place.

-- 
Martin K. Petersen	Oracle Linux Engineering
