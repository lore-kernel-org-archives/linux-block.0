Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F93C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28471613CA
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbhDFBx7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 21:53:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55756 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhDFBx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 21:53:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1361qimA045413;
        Tue, 6 Apr 2021 01:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=6cfVcHhCAyX8WxPoiBT25+XmOql8zrWABcjJjDI1IRU=;
 b=P2jx20bl5Cc2jOwKopLp7SLLgNCWYF6qIejN9ZjPLvuPsWR/KyVag3x7mX7i5ru1Cv5T
 DORCVJs+1MRR6RWMPjPhyETXigyzi9LDuJKSMJxyyygQv1lLzJzknirtQAN3GaA+Zf0o
 sOThGbMT1KhpBJVm+nC9CLVMCMaiDhBYaV6vdEh/LnKhRbE9X08yJyt0sgY2MDKVJinH
 6yFDHmY8RRS1DFgUTSzvDIsfBY3EStVCUw5hJqVQ2oD3fpUl4g9xG/TNXqLBXRC9xcJs
 JJHm8fKpTXqZMyN40/AFmSrjsXV6QSoxintoakTGBUUqZuvMR2SQEu20jMP3zFaNcVWF DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37qfuxb3qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 01:53:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1361o0aq067007;
        Tue, 6 Apr 2021 01:53:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 37q2pbws00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 01:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj+K+SsLF2JS1oyA/DJhQmljbBfqsfbDRvZ9p3o2TDsoPK4K8e8x0n33YoZHaTWxkM/0Lt+Zi0gk5Lnj3ql/2CCirqkD5jV+xSIe9E+MTOEMut8gT+EIWsrEgWIUd8JrlkagSN08XJWOYfBm2aGWNgCxojklvMsu/Ezkb9nbJWxDj3jOtji2u/5jK8C2jz3xTaolbXsOaUjUECyTUydFhFOntkYVtNw2huZPKx4aqcDEkE3YGxTj5UqD5JX3ZOumD359tJ+PP2JgGfdDGtzfeGblsNukcNZme/uPac537OgLdoSxTj6rw8pn0Lw3SjOtbJFqS4znKTMyogNDhRI+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cfVcHhCAyX8WxPoiBT25+XmOql8zrWABcjJjDI1IRU=;
 b=A1rujqOLlvmmF9R6ZujRcKvhdpw+k9TPW/npSu3Gve0Ygrlzv4vr0BOxMNC+Y1dWA74+Ph4XEWc362SaWPZhwAOKLKQQp/+1FO7fu1jO+bomo2ypwlQpW7eR7ZTNEIkMpOQeiXvikJmrJE878/wtZnoRmNTj7TVESvdB65wwJKT+cl5u8sbM6M4AigvGPrVoLpKdkbHn4j8nERdd9OQIC8YtgGweIAR5DT2L8tV42m+KMO+nA4uChqONJAGr596X6eQ4zxV35vP2wKtxvzKr5z8RRmOkftH6toJlfdUYBMI2REDRb+HMR41YNNFjcLgIH792lXL4DQuNdAE2Sz4j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cfVcHhCAyX8WxPoiBT25+XmOql8zrWABcjJjDI1IRU=;
 b=UCyPkPC6VICVjyex4mYin2abMXYzThayXgJWaO77Im4Exk+AAJtOWFKJYvtxWLwLjq56xtb9nwRq6FgL6I9kX3Bdn6/5AyaAHOKMRRZyzNrA8NdwFIsCEC5/Kg+VThuRnyFpiThp+3IHhgp9CyyROwo2JEgp2C/t7F3zTpiRcYU=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4790.namprd10.prod.outlook.com (2603:10b6:510:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 01:53:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 01:53:45 +0000
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] block: add sysfs entry for virt boundary mask
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v990ch7g.fsf@ca-mkp.ca.oracle.com>
References: <20210405132012.12504-1-mgurtovoy@nvidia.com>
Date:   Mon, 05 Apr 2021 21:53:41 -0400
In-Reply-To: <20210405132012.12504-1-mgurtovoy@nvidia.com> (Max Gurtovoy's
        message of "Mon, 5 Apr 2021 13:20:12 +0000")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SN4PR0701CA0045.namprd07.prod.outlook.com
 (2603:10b6:803:2d::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN4PR0701CA0045.namprd07.prod.outlook.com (2603:10b6:803:2d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 01:53:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc16b517-5fb7-4b6e-0afd-08d8f89ed03c
X-MS-TrafficTypeDiagnostic: PH0PR10MB4790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4790D0337DA1A900CAB6F40C8E769@PH0PR10MB4790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fftziDz/hD1E7vbRaTF/PVDXeszJsnAokFMmKAcIesdgdB5EKV8Q8xBhldi+4CBpqz80wVxpFrj2rPu4cQTn20mZ8vQ3/4FV8nj2GHdYqmdq6n4x72Lij6MsJXCrV8kYOdO1K41/IPC1JlyuSnUpwSG2bgDLY5qloCiTpz/QBS8DdhfDeTzMlnZDpViz97cmom4+gDp/EjrBxt02cX0dVj1D7ycRjznNnPMeSZZH/8WV+/bjzpgersUxHaHJqbqbQixqPtbjROK7mRqcfoZ+oHnKbssJPGflQ7/6M/wUz0DWZUwFoHX2v5PXHyIs0Hdn2Xxwccn7giDLUJosnOZuWFGkJJxpONdp76+38KUl6ApAXv3yhdzUOHYYbVbFH0l5ARHdcHZ1sHHhH1/dgwCuP4ld9KF6ALub5t2yHh7bbb/Vdw5AoDHMIBnw2YC1gHiF/FjmmjENvahvAz9GR+IF1eOmzYn4/AQB770Wr+JQ0qSqjId4lfoIvVxtwsYs6TIqJ9o4xtSFgG7jOf425t+NC4SYa742RztnYaNKduDxnFdUv+WsO3h6KMuTUH9VpwtUbsqZU+cmc7oFaRMh42EWo1/KzzvRxFc5hjyyEpduoKyxz1f5MwZ9aexBgTrZEHh31R9uhAu7Q1ufnHbyXwyDcBBNTK86+9pWd/uBOolUterRFoc6THfD8pShRboyJ4On
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(4326008)(5660300002)(38100700001)(8676002)(8936002)(558084003)(6666004)(86362001)(83380400001)(26005)(186003)(16526019)(66476007)(66946007)(66556008)(478600001)(107886003)(6916009)(2906002)(36916002)(7696005)(52116002)(956004)(54906003)(38350700001)(316002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ac3hhH0Sxvd9tJ3tR+Hv+PchpsqfikXKf5iNMeoOgQmghfU7jr8tj0PVpS+y?=
 =?us-ascii?Q?aR94kpeNaePLe/W8SNsk7WfS31NJWxpTh4dFJ51M8TMjw8PJf9qrQv0m+Vmz?=
 =?us-ascii?Q?l8k4UqDLA4XUs3IoZjZ+gl4S5ZV7O7OocaoJDg39AK5PTzTjpoU5MF3vcmsW?=
 =?us-ascii?Q?9+pa0hBV1ZvRm+LORTulUTNtjsoYDfqt7i1DDW0eMJVhO+uJu7Gtndimpf8j?=
 =?us-ascii?Q?fID/BULOg1E9l7/y/QFifYMhgknE9YW0onT+tzdzAO03irFqe3/bgvknlGol?=
 =?us-ascii?Q?xDf1+xn0IMp+yXEPDXdqJpmRGN1p11DDuFQRZyHfQjqs9nt8HuyPZc7rG78g?=
 =?us-ascii?Q?usinL/va6ksjACufyQvhjF3vHpHcm1sfxO2RdL7XjkC+x+wJU6oQYUbJg6Vl?=
 =?us-ascii?Q?MAJU68q8foR8ydglwLr4MVGmH28CplriJ5qqIl3sYXzAPe6LbN8zSVLwoaxC?=
 =?us-ascii?Q?U8XmtqWiiMmnRfsQK8g4vz17qD8DAhXpaZqetfIEIWweUwhWM2ILgsaMo7Vm?=
 =?us-ascii?Q?fCKsEpHTtON9sMf47QC6v01VYIdyG6BqiIo4bgWq9Xg0PRW6lG7MhXtfTDAN?=
 =?us-ascii?Q?m/parAOgGbWcwYecukejGTZKrLHIKrKBLJUeXjyO6p65nyBO3SmrPbtss+Pn?=
 =?us-ascii?Q?N2uOyYRLlmGsSK9o2njqtNL9SWW3urjvos3PeGskMn2eSmazLzkdEY8zQqFG?=
 =?us-ascii?Q?FE2n4QYxx7rp00KXjP5jcPypMhSxplriq0yGCcvatG0vm8J+qRGtl9XBI+UV?=
 =?us-ascii?Q?eXrSBjoWh7RhfNE4p2K1Z2x9y0irLl8h58nV7nLXkhNfJ5YQoPcJnTkR2yvQ?=
 =?us-ascii?Q?iY88K9VMP7W5wV+4RKvl9TkH+zaOibrMYT3dpy7NC6Y7lEa+7zV0ldgpIOkM?=
 =?us-ascii?Q?NkK4cE51+UI1W8K8jhG4hq0993WawGIitD4alM8SVleUBgjxqMm3dHHgrPze?=
 =?us-ascii?Q?PKy63G0/cBvRZmN7nprG5g3I2aYKEJwLD+jCoH/1inIzpn4NxYx452aFEoEn?=
 =?us-ascii?Q?11qzq3Xbw9GOgE65QXkkyQdvvjrbX++NcTgoTy9LQoHzLCliqXAXcVoMVBRM?=
 =?us-ascii?Q?CPgpDR98ZrW9ssnx5LcRE2Mc+yTuJMhlLxiLqHA7kecPHv32qBow+RXcvbQ8?=
 =?us-ascii?Q?+jMNJCkiVRJe+9dt+rR/znKkxZOqWOEeLOyKNeEO0GnGoYRkn5L9AeF0L5at?=
 =?us-ascii?Q?qGBzK9n3DwpzACd91vjFZ8mR/jSA1GaCsazzJsdV0Gj6Fizhovi6d7ARDRCQ?=
 =?us-ascii?Q?h++C0b2X6n0UPaZLIIreK62fW92PxxU8BWufJPpfKQdYP+H0VQjQGPtlhRWZ?=
 =?us-ascii?Q?PHYjuBIOel1lzqDhdgkg2W+R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc16b517-5fb7-4b6e-0afd-08d8f89ed03c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 01:53:45.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSPS6zYZF1zgpRI50vR9KPG8VplhfvWYbXrLbXm+/eFXisEqO0FWMardp12f0BgflgyqXiU6FDdx5khWSUd5QKQL8sppWCr3BiZwnmtA7FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060008
X-Proofpoint-GUID: mLGNWiJkaqbG4YPE2UKn7OLTCF9Y6m4x
X-Proofpoint-ORIG-GUID: mLGNWiJkaqbG4YPE2UKn7OLTCF9Y6m4x
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060008
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Max,

> This entry will expose the bio vector alignment mask for a specific
> block device.

Looks fine except for the (page) that Chaitanya also pointed out.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
