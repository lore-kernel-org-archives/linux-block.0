Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FD5C54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjAIAZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 19:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjAIAZh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 19:25:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F0BC0C
        for <linux-block@vger.kernel.org>; Sun,  8 Jan 2023 16:25:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308LuS7l011467;
        Mon, 9 Jan 2023 00:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=orsVC9Yd/7VmVlg8BOL48CH0GIllzxstYEvN2KB8pjE=;
 b=lBJAeDHzmwMg/3slkRBpfCVOI2Lohf7DIBb7CRkY7qemCbYL8kv3u+uny8sPghfBmKMO
 jm59wCNp4rVGDCqi8rg0SWqAnLZ6c68EMX0QFxFoOXje4RQ3+cv2u2OfdutKMBNKvEDg
 zjcIiiwSm/QAqK94K1jITSRBWkvxgWoMz9czqURgDlAjyPAS/+S0eeNsHWSAIFzkXEDG
 3A0suS4CnXxKoGYVSadXTOSKJWpMJ7X1jsZCv5UbDDuE+3iSKkk1nfQCGNLCYpk4S0kM
 Qe9TPwY3Y2ZERBqRd2n0f379Qo7Fgi6NvACJdHSefVp5vuffC9mevOd6q6xM/koZzvOy 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n033br5xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 00:25:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 308NsGpE026302;
        Mon, 9 Jan 2023 00:25:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy63brqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 00:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbi0UdNUhUwJu1j4blIevOVsdA95K3MnTBG66TcKNFCN7FqIvagyg87xCULhNVnMsC6/7ESK0rPTrItyaXzpw5FUutY8UCZ/xXhQehh8evrli6hp5OinoEMu8eRv1cxggbbd5H1plh2F+S3W0/vIN1JBk4wwetZ6KVG/FQgxYxF8hM+VhKoYu7DAax+IGfXDhy0GmM7Y32TwV7B5ncV++s9gFVVGE1tUd9o+5pDCMmOYUY/+8trydx5GlmUyfAoMV7CVQ0/Mjf22/7DmUkwr0ZGtLfBIQM54wEmqG2VuOZiKthFxEMFHz5AN4rx1l9CSjxmbb3ARXjFhF9VWswBkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orsVC9Yd/7VmVlg8BOL48CH0GIllzxstYEvN2KB8pjE=;
 b=alr6h1uMYmmCIuaP6IW7I2j/fYkfYQMQl/AsX1UPlTo4qCwZTQ6oRPVK9ssAbn041Mtj0GHzUVL4U45ONNESkHWnj5W8LX0gFs6gsR1XFb3x24u1mDmdDD3v+nOspjQyBDg+nC38rzKGwcFsqAGnVAQ/mwyi4ls4DQL08e/YYRKbFieutg9r93iK3SHvmxfOfDOOdblZVWAFoHwHuA3j+RRkhjbcufwuyZpmiAjQnP41jnt6U2kdc7d8h/O9ciHMyX+Asrt/7R64oTBxBjmA6hQ0QLcoYVxYJF5u5iu5bPckCXbDy+cN6/LUu/UcNmJndt3XXS2nj4v3EpS6Iz7hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orsVC9Yd/7VmVlg8BOL48CH0GIllzxstYEvN2KB8pjE=;
 b=VCSO/3cZ6f8nyHbX/D9De+k9GudxIBVsVBSgO5165MFACRcyUVnxx5cQRWHnRB+RdynQG8onnZQRzHaYLWM61EI4RmC2G4aSSX8YqRRAaCyi+VUcPKncHmZAqWzrGYIYr8Fgru3DdTNrx9w+3VyTv95klmPjL/mbQIip5ZSiKKk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN6PR10MB7421.namprd10.prod.outlook.com (2603:10b6:208:46e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 00:25:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%6]) with mapi id 15.20.6002.009; Mon, 9 Jan 2023
 00:25:23 +0000
To:     Keith Busch <kbusch@meta.com>
Cc:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/2] block: save user max_sectors limit
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jt0zh9x.fsf@ca-mkp.ca.oracle.com>
References: <20230105205146.3610282-1-kbusch@meta.com>
        <20230105205146.3610282-3-kbusch@meta.com>
Date:   Sun, 08 Jan 2023 19:25:20 -0500
In-Reply-To: <20230105205146.3610282-3-kbusch@meta.com> (Keith Busch's message
        of "Thu, 5 Jan 2023 12:51:46 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:806:27::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN6PR10MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0bfef5-08d1-426d-471b-08daf1d7ff59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgnzTmP1QXhD7v90nmhEaa2oQ0YK4GSgo7KbSSAMgXDULeq+pNs+jn1k2oHT1myv4YHuCj/6/BLrXCXi1ifsgAizJmWmUMfHbUqIB90/Ief/zhhrPhEtO+Z+5VKDyeKNs5YjVdc+VrbpFPHLtfRREHqFrDe5Y4RuWi20267/m+O8DN8/iHEshaZ3FJRkukzPv9uIN4LOKVKJLPNBs7ETYeuqzAZJynDTCmCPFCRXRMVCRNSCcjh9QT+cAAQNZ1eezH4ZXtnMmy3DGOsTzQfTf1D3KIH9Z6W1ITZv2EJojIoXYqu2jFvhrrQUyphWUJdN8PcG0r+TI5jxSp74CTozCY1CE5FE4cy+nLMf1lvMY/qNIGe3sagPxW9vLQkkjNEIDzmhJigqGR8Z7wTMUDQ/yeaaDr8QzIg5zdZ584yk0zMKNW/+E0HSuHobQA/sPgbfepSv0cSP/7JqsPAyt1GfFA5VyS+BB63zAL2RKjlCOCvqH8D14sNgCr7dZoMH2YMBgGwH6dGiDqQtx8zJ4O5AJNVnDkRIZSBMuaU0LLO3Mvx1PTRQWR+uE6cJWKR0KF7JUxgwVRqzcw9DvfbhzXg9AHWGsdjUUkd52LYyUiRrTDf6mHpayWAL9xAgkWDM+0AFOmEzjPszBJCiR6MZs7pNCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(186003)(6512007)(36916002)(26005)(478600001)(6506007)(6486002)(66946007)(8676002)(41300700001)(4326008)(8936002)(66476007)(5660300002)(4744005)(66556008)(83380400001)(2906002)(86362001)(316002)(6916009)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmRLxRLYvTWa2OYLB6r+pok+T/lmzRGtQspLH1ZJWa5vmFc8pPSb9+2rM/n5?=
 =?us-ascii?Q?ZJoLzY/AtciQ0FRL4DIWsDf+WB6Y/vxh3/2qEUx4v/RDbH48IgLUDpHAs6pD?=
 =?us-ascii?Q?/67lZUIurTF93Gzm8E8dVfGztiqO2fAcNt4crHjWD9bdSKNTL916xZTPh3Ui?=
 =?us-ascii?Q?sEG7KPMUJSBysCkVCMK2OHMWDr4Yer8XfZl9RuR8jx5Gh+4d8nKXxJN/ZsDr?=
 =?us-ascii?Q?iufVhQmt0vv07OLmT2u0G5t1bVZ4Msj3QpfunFkWT8U0nunuNTP+aco2W/Sr?=
 =?us-ascii?Q?eTPsl4QefLLJVGfGEHfXaTo84DKrN2lPh7upH1ExvkSSe18PauTmFhT58jDw?=
 =?us-ascii?Q?4V9Qn4kffYk5uzYrV7KSaaP54wHkaUEfrYo/nZHWwBJTz7R4A6bmBAYNnBbg?=
 =?us-ascii?Q?iZEXfbuGRmbcv4F2hIjmXVrqKIJE3YgrqMhg49KVGm4h/TYaLOokfHjMojWG?=
 =?us-ascii?Q?4HkjltRcg4HvPj1iU7e8qNINvqx0DWbJ6KHCD2qEWqZGxjmXU4wBiZURBbp8?=
 =?us-ascii?Q?E0kq2VuhXAtlkyQ9kW8UjOedw+NnCvKwN6wb6K5bYzwYEMIQLy2rs2GIRsRO?=
 =?us-ascii?Q?mF7JDUL17dmiFtvP8ZxfzHK9Am/j4jHQ9QXd/tT4ydcUdl2jwhtM19USsfR0?=
 =?us-ascii?Q?aXr2WDvPTaIE8LIyBYuxojMmg+kx0bV6ewP8Qzo5NqcYo+y67gE5xSd9przV?=
 =?us-ascii?Q?n8uSQHXCgKrIGeMGzDLFSiyalH2lLsLIMDNbDTvJRZCGT4VlS8L2mQBcqt56?=
 =?us-ascii?Q?W5aPgnsYwgy5e3bpHwV+4TY9nZFeQXECblI7OuF9SCXG7Q4FvV9fROfnca66?=
 =?us-ascii?Q?A2eIAEFAbdAOkBIMiUr14urKHmSpTN698h29CQnX653+67r5ub0+fnIqwrad?=
 =?us-ascii?Q?xiBWDAaPAUGG5uwXZXj6d3HgIORdU1qiBPWG6wMGV+LKqdc5QVMffUyFIUT5?=
 =?us-ascii?Q?930M9sc47C8D8DQrgM4fucYoHgDNZcsw1VQf1fYI6YoV7H/BfF1rVZQeEFDZ?=
 =?us-ascii?Q?MoEHFmT6VNNqWOgWpP1SItJjrjHWcEORaj/XHlG12pvvr7ajlsfL3hwQ6GPK?=
 =?us-ascii?Q?Ov16izjmCt2K9zb3gih/tnAgqE2lGldIhOlmZxuqLhKdSkNj/5PPo/G796Rb?=
 =?us-ascii?Q?LtWa/BjCg2LVeLiPvRrDyLw6iBcTzHAOFuvMJpInvp+I7p4I1oujZ+1a6TW5?=
 =?us-ascii?Q?My6E3F15xdBwrJv0EWPrEDNvoZxn5IVlb5oS2UogAmx9XkXmqPWMCCmxR86f?=
 =?us-ascii?Q?q75qocg4WAPpmdF1AwCBgr2c4e+RqTYNLwClky8dyKx6UNXqNVlnwt9rrD7H?=
 =?us-ascii?Q?N5FPl8Mk168EcuGT5lqrCvfiNAwzYlma+IJYQsmou3A0tfKMptMYocQQvZjq?=
 =?us-ascii?Q?bW+xlGCmmifoTxe71dhAcH/4aGyVafGzEdygVAFgYpb0F2N2ZKriUGVMm4Gi?=
 =?us-ascii?Q?xnu5FIrz2xXqv+Cym2GHF8zloAZGtxmeejrHNESH1No6deAl9Iv4zfhHIzJ2?=
 =?us-ascii?Q?Yl0NZyxRiHeP6e6CT5s64Zp+gnUfc6ONcThNMHN5lfxqBJ75FIXzoWhKNvWj?=
 =?us-ascii?Q?BjLtXWECX300brdeNwTnHUK6Co8F8cmD/dgNHSHYc1fuONVXiPiOAVXdhx/0?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DN7/vgm4sCkzmj3JxVBLTnwBstpg52FESdq1cb3mHSR9ILSnJ3wsWhvytcyB64uLRuZZ5Ja49Zcsvb4CDAJiRhGK/jcUtqBKhUa9cCKRrmGmVSQ+z8B98hQKM6UDoNTQjXivbYVQ1Qju+FfW26Or0CYHHfcRJkKKgcjU+tPIdr1J1CUCqqL5ht3seiaMCDW58e45wNLtSX0HBxSJ8BX7jBGMTjFmFjaG1ou1BOE8RENNaFbnAwzpxLAq5ZRZRb3FREvUGLguhPP4+W087P0YavfjO4QhXC1L+0tqgPKaaDqJNL/4vi2Rh12MXLM7B1v5h8YZQoR21E7LhO6tt/tPtIDYmGuEgK2y9WDu09YgRf6vod6Km5VeB8jwZgLlddcJ2leqR88LzsrNpDztkxqY08OVOvUidOgeAkEgWJTBhuWTd7J3V0PWNxsuVm2c9TQaIfdGfebSZUEMJERqW5BrL+ukfDtw9A/22ZdYxsqZnE2lAdP8mICJF38+aVdbkGPv4XqrPlnCXsUkru0j6NtOlQOkeN4/9bS3SlWaEDiOkvL29FzbZyG2LYEmN8XM6q88R4YuIUUYj/aoJ58vz85SgfbfhUxoHKlp9yFXBJrJCAmLWDzgMALptLbTER8dYxgtGthaKsn52x/gZ5dKJnMfv0yZqfiQI2wCdLJ9YO+GKao7jIEDC6pvB7ve+4cIP3sN32a1QC8ZyqM0aVJLHW/1XUZVXVyltCPxPnSnHuRWEr/TIero4JVMiujN/1nZxFG4/3bZQnuTm0e14ZTt3Ra7mj7TFlmaWUD9uSzye6xQ3ma/RazGRyXgUTUhKW/7Cz/i4Vp/ezpwFQxKZlp/plxxt3KmMNmBfOgwt0bAAHc59MZx7maQY2SDhWwVpOAUlhWkm1pc380ctE/CKYv7JTX82bf0djszru0FU3WNPs6QmxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0bfef5-08d1-426d-471b-08daf1d7ff59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 00:25:23.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTk5Gk6uplkKfxqUPvcz+Q2EoctMjJD6jcvjl5Q3ko49guC59D3sBqOmDQic1aFrYCSHmE2NjGc3swLOkyB2xyMBmGyKI6ExNr5ytjZYAx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090001
X-Proofpoint-GUID: GCMrknzss0mggnYolxvGhB8DgycAlvT7
X-Proofpoint-ORIG-GUID: GCMrknzss0mggnYolxvGhB8DgycAlvT7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> The user can set the max_sectors limit to any valid value via sysfs
> /sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
> are ever rescanned, though, the limit reverts back to the potentially
> artificially low BLK_DEF_MAX_SECTORS value.
>
> Preserve the user's setting as the max_sectors limit as long as it's
> valid. The user can reset back to defaults by writing 0 to the sysfs
> file.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
