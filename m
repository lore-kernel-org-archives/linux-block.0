Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C59C54EBC
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 00:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAIAXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 19:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjAIAXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 19:23:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C5BC0C
        for <linux-block@vger.kernel.org>; Sun,  8 Jan 2023 16:23:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308LuS7j011467;
        Mon, 9 Jan 2023 00:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TD3FVAF+py1/NrmJVgsvvluGaNQkMDC4eV9TCCvfOfc=;
 b=kC+6IYx5btvvo+FhFTDdEGQ3B8eWIHgfQBVj+0g/c2fFI9Yg/cRr5M1eWM5JEjIXGPJu
 7VHF3ZJ0xYpMwUeFt2PW/MezJ0O7cc6hkdzFk3QNk2+Bx76FwGClm3fD67Q5W7I7KCE7
 hTfE/3XaWrFAU03Roz2ZsYOePMCrQhyhzhm7qZGqmvfYbii/zw/a3P56fNsUNJuLGQTo
 HHR75cwLqQSavRz1hbPSG7FJrUCw2T7jmBDymbZdydqRszdKPyDcaIxbAl74CcsviMBC
 wkFl/uPcbkcBfGr6z7TfsEyiP6b/gVCsKzDxDAMYHQ+4uuWPzeTIRG5gtzg0qHLEdwDt 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n033br5wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 00:23:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 308KghpP013385;
        Mon, 9 Jan 2023 00:23:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy63cre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 00:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E31FYkLHbzBEyROKWvh6LVfM5uO2CrLOUatahvPPGM63qhlaEKItAs6zZtcNIM8mz9J6evUJ0I95gkaBO7AZBIOIXlxX352+yMMzlHD+NgiohtweE84uFqPrViO0o6yabyKwW085aPyODVHySXXgS4ZYM4aos6Q/MLQrzzoQNO+SrekHsUPMoJdLwNCNNciHgAexsmR6Q2K1mQ2wzMr6WP/PCmIKl1FH6snQbd9z8T8l76i8/mvd2omhVIo6sj4PUaatjwNSgkKLkZAOrNd1M+q1tP8D7cClVf2UbjOZbURV9XHHo+DNFpPbfsmzeo54fgVk9hjGJR8zgSvbodi2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD3FVAF+py1/NrmJVgsvvluGaNQkMDC4eV9TCCvfOfc=;
 b=TCwcVhLp9y2aRAEkv1yzmjOfx07ZXXtHZhIRwXU23kDUFuppkusNBkRifCoBalDYtVUMH/lXNcJ6V/+/2/z5fpSJIzBan0TZjLUGDfbjueaOdAN4r2xdFPl4Bv/+GBDEIv7Klu0OEV7YOuzZV2lrAsjNVgmQC6HRiLZAUePFaTADYadUsEsz6a82b5dvrs4dTWUWAuuO/eCCJOQZABqHBx0ygc7uN70JKREyHuhrJIu3TeGptKqqR/oZo/ni6/9pHvTJ9dyoiQIo3E/4SytaOUlHRROyhgJWycqnUAZbyEjhT9HN7PHn2XWUJZ913gssGZnH4v4gDvKvIYGtTkotuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD3FVAF+py1/NrmJVgsvvluGaNQkMDC4eV9TCCvfOfc=;
 b=uyjlcgOClufJ9m5tYUEOsi934KzzWhCrBbwuExFsgfU8CwGP80a2FjGE9dx67xFPpF//ao3VhHZRaXgmXNxbeNWPTvPEYP7JUtuuftYFsj+Ho99yQqpfL7l3qXFYkQrQzvGAK7539Dt6FZrQDgPy3lE1ZVRGD9GnwebRQu3IT4E=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN6PR10MB7421.namprd10.prod.outlook.com (2603:10b6:208:46e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 00:23:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%6]) with mapi id 15.20.6002.009; Mon, 9 Jan 2023
 00:23:18 +0000
To:     Keith Busch <kbusch@meta.com>
Cc:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a62szhco.fsf@ca-mkp.ca.oracle.com>
References: <20230105205146.3610282-1-kbusch@meta.com>
        <20230105205146.3610282-2-kbusch@meta.com>
Date:   Sun, 08 Jan 2023 19:23:16 -0500
In-Reply-To: <20230105205146.3610282-2-kbusch@meta.com> (Keith Busch's message
        of "Thu, 5 Jan 2023 12:51:45 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN6PR10MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fd274b-6ada-4615-39f4-08daf1d7b51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yfjGG2HDpFmf59XLxJE68g3Yd2xGmamK/77lw/skZj75DjP+eNCKCHjdH5HknnqPfno4kuUg8c6fDCLgS8o30FGo8MY/vrlwq3DyrgHPjsBnkf27OTqZjc4BTHugPHKuMnl0YdgrrB3YUxRlQwS22VlGagBXoNk4u6f6tvff/8/06nAHD/T2osWKhUwxikWBIvBdfRhGlxqEvfMM8pGQjcEOuhA8TB9Ail2ztSzCR/yh1WvrN+PmPYdubciZRzRRvbygB2fBLd0TO0IAbc2YNZ4KdXgD1PFHEhm+8840Sk12WYVa2sy5oEDRup4jf9ghFlnpbV7bBxxdOUsVr50m02I5bQAni4mUMD14NxMURPO8gnpIfgCeS0k8BU5++SvOBx390xX8lpUkyQEpWQv2giJ1YNgDDYVc0pacEjde03EPBaCI9KRiAd2aKybWj0mw6VEYhsGZLrgN2kVnLXbLaG2+S9rgAucNmDbbVD5OqBtE0fgv7GMq2EO4xh2ov5773YdOJ5Tt/fXN1quViFIiTRbiAg4N5e4LCTE8mGTYhXHJiz4PktIFAvgL24Okzc+xtJvCwlXQmPqs/vvysiA70t53fZEIzpj5Pc+aQWMqfCNxGEOsWItz+AppSGLSUNeLEuuFn3ttPVWq71LfyHwYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(186003)(6512007)(36916002)(26005)(478600001)(6506007)(6486002)(66946007)(8676002)(41300700001)(4326008)(8936002)(66476007)(5660300002)(66556008)(2906002)(558084003)(86362001)(316002)(6916009)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8Xg/HceGL9rABFtizK4PtfM+q+2W0CE1X8PbFs/RtiwGSYT1qO8swnCZSjB?=
 =?us-ascii?Q?xw95I/a94xIBm6vLcRLhP9e2je0vjiZu2i8LJElUc8L/f6QAgxGNgDTrvTho?=
 =?us-ascii?Q?hk7zpeYiBlYgjqvxuto0UtOQkwl2TdAs7axUs773uAZ3o7d0MGOSBzomb4Ek?=
 =?us-ascii?Q?vD2yGIIMxUYsLd9jUiW3ZSFdJuMVs8dmE3g4S80v5ZbJDYJvtjdcpyyeJI6i?=
 =?us-ascii?Q?OiGdpv9ijnmo62Tvt+D5C0vv06Bqpkc1wS8qDXJHUUhjNTzou2yNhX2G9OeD?=
 =?us-ascii?Q?UrLQaXUuMSIgPmur0F9Jq5jD9VttEKoUZ3UBJVVmgca6r42H6J0PqYJrxMwI?=
 =?us-ascii?Q?WVMvXVDtJxP4AsMnEO2ar5lSr5uzVTR9Yp80KZLPOlUvJzpbSuUe7fsWQPpr?=
 =?us-ascii?Q?aNasYuuU55XO+ruM3ki75QWpdb1foyrJm/+qQOjU6VGOuFIitBybUT+oo/bG?=
 =?us-ascii?Q?CblrL3OsPKpLgFHEoqSXO0leFV29cxiaHy8tm58I8DJ44AGc9apwkfn4umOE?=
 =?us-ascii?Q?NGEqhd/WgX2rtWaj76Jg2ZBWEjIFV74y6560JTwy5iKO9KkJSh2PbLTv8QLN?=
 =?us-ascii?Q?E8oGRI2doe4ptLhpRlBsUcxMI2IZtjlEyjYG84dEDCxfm8sF1VheFhzl7oWL?=
 =?us-ascii?Q?E15EwPY1kH/TFur/gWFbvijwQt/9tPDnCvso/R42eyTdRBHCrkRxQov5Q6fW?=
 =?us-ascii?Q?tWEq3Qj0LcNmHYf9O4MRemSjk8jNKkbbL3o1vLJObXTxiz85GG9xyqKaUORG?=
 =?us-ascii?Q?wja3frXT2RuIuM7U/VKN+7abcKFVGef2wbq7PzRjq4vpL1/cyY/3U6m3a8KR?=
 =?us-ascii?Q?on35KZQUOOnQVIi4wL4/EcWIF9oidcD97C7+CE1S3Cfj1BplWCjCMzvdeORt?=
 =?us-ascii?Q?K12s5jdGC7lsYMT8fqoeGXfNNK9eo/xHIILuVZKsFWdrtswqgUleigYtEkSV?=
 =?us-ascii?Q?oms0pRqcLBOAW/yt8PNs+eAOn2H74BSB32jrQk4szX0rC1QpdAcyv15ozzAu?=
 =?us-ascii?Q?edTrgJ2BfNSg2OCjj1jslm+99uj/VtaHVj8wMTdbFdoGnc18PwZxtraKv6MP?=
 =?us-ascii?Q?H93xofLAlDEYxxN/M2FzsxtNYQEXduSnwxRJ8wmzx8y+C8iW0LxMKTNWCLTr?=
 =?us-ascii?Q?eD94+aNfMW0jeuEikhKdwMY1w2MD73jTe+DzuasWBbMxZtcX6anliaBfAYs3?=
 =?us-ascii?Q?zwczAKTXK6cO+z7Okj0uHca4XnaISeViZCrZ+C/Y1k/WcoIysiSc6qIu1lC6?=
 =?us-ascii?Q?BOJPaGITqrgQU1VAPVRfpZPoAcPt/GZhYNpzPslXKqqFMounFxy1lCGamBLr?=
 =?us-ascii?Q?HqM/NueN3dhQBZrcbQ30OMXyWAe3ZEppYORt6SIzj6FRXU/O25PlWfJB3hJj?=
 =?us-ascii?Q?3r+4CwREJ1THuei0XuByVuwUQ9roZhtSyyIV2dIokv2oHR4nBvxVlXMT607P?=
 =?us-ascii?Q?qskIxisYnmEgazmMv6eDuC9ohhSvaJ4QWy2OC6QtZadPm+tcmaVbuwh0WnjM?=
 =?us-ascii?Q?mYXG+pr9sSo+4WXxU/RvTMWNesWSh4E6DqAEBlM1m2YPYVFQxJCBCCJkgS8C?=
 =?us-ascii?Q?/m3+uoHZB/AhGDdPmrY1Jh5lMWwYsFLplY5icLT2ltfA2iolzILsuKyoNTRF?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 900SKqMjYhF6k9XUO5PKFW2DDh+aoW1GeGcn39KNX5AMEHCFjFI2j+/lR0yW8zTNm10CkgHikmVEx7eZEBwPO5luAm8CRmU9xkLBy5PDD3E3r5LqKe8BpTKSGa7S8JxZU3P9bnPwDpapsZUWnqpuRckxQ6wAMa5ge/NmxHNRqTHjqYQ6FWljxpxVe6+yO74Kdoh/a1rWggZ0t8AN1DYwWWZlad/6VyqBB+JGz3e5XQdS4HpU0tG78MC7y4fqnSLuecU6KCObC4EFmEb7HPkI074SdY/TFqA4qrg5Sp/9lMAReUYvfhHk0NPw38gSIo1GkGwc9iz4c95xf9ANOrHAyoItn/y79gHHv5OM2ZC9DqFuYu1PWb0h/2s8D2hxGe1fqQCbIjFwEZcZUnPV0xP+yYgyuFMeVvELrW0we4JfPw9RWU40ngg8m2vIw20MhrFqCcD3HSLEX5oDuMyip9YuzENqELxYpU9hVVaw7zWTpoBEvPMIf4gjcabO5JbBuPdA6hWrSE4/YhAKAEmsSTJgP/XfDhyhpqlNKMYnlJZgXjb7XsXVw8eQ0biF4AUs2huQWIJd4ptXFkOG+0F5B55xsr6RI3jG2KFINVMDA6G5dmKr7wW7pUg5/R4D0M8pp7qvWpyL6vAEZOerP1y3fg938+C5zvAw+/v7fVSqKEGrDAifKL8IoKtFi5jx65LD9hDq9SGSh73j7W5nS/gb11TT1c1iG2WF1sscOFzaSlbAWiUcXjhi30B9MXHJ8pMY5hxCly36avXeWkxi+jamAp/c5XD9A+KyG6aqSYmtauWsFTQi9zxQ2p5mnK9+UR0z4dWXfWkZdAKZVPcGHzR+ewv+iswMcWtbgDIr2TcXAhquk1gbS3CNnoUm9oexVAmg9/350tllW326fpuMS7VprONfJahm2WRhxyer3i/IN5KfTyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fd274b-6ada-4615-39f4-08daf1d7b51f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 00:23:18.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw9kb5vXQuJKjBah8F6xFUTqga2aGbJRcY3fIcq7GEjPpFwYpunfAvfI3YoYn+oPlO+oxr8nU+RtLtZhxE7oIz3WNah+4ShDEhvAdEpQKe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=992
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090001
X-Proofpoint-GUID: FeSQtw4Hk6qnnaRkmPMdkVnTQz1abNGD
X-Proofpoint-ORIG-GUID: FeSQtw4Hk6qnnaRkmPMdkVnTQz1abNGD
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> This is used as an unsigned value, so define it that way to avoid
> having to cast it.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
