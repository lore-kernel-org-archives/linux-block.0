Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF7DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 15:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiCVP07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiCVP06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 11:26:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7F7665E
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 08:25:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MEbNu3022808;
        Tue, 22 Mar 2022 15:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SIoKNNgPg/eP8sIh56tIYK5nc61VrjgxPNZi9SB27D8=;
 b=U1dAdAc9/Tw8SKa/G61ORsAj2ZLyr05rWBK+Yags4+D5vweuEwmkqPRJGhHC8EdIq50U
 70J1kw6tSzxdmFTNtyR8H9qs3BeQUecLD6VG2quop26VtFPpn1PrgSSi1D6RgRsCHiBC
 I0R+N9Hvi2278AIim4heBv2eeKaMY9JJx0PPEExNOULFVyrdaxkR4w6Q67BvhvQ1pl/u
 B+SFxgkfzfqCRKZ03SPXWiy3WjgVO7hbjVrtRamBU/NZiu55lByptCsFLr2v9eBYvCbZ
 esbJTwgWfYiHmLpTAmQjyDRR7ZfhEBK8fOdaJBstWr/eUHqpxUiEmL0DciR+crUHnF94 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1xtg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 15:25:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MFCCxH071493;
        Tue, 22 Mar 2022 15:25:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 3exawhmyuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 15:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8U+4UasZKiA0dK8kE+NRARluJQ43AmPa6Ja9MXiUfuapgKmDkUeQJZWm3wfshpf02Z+Y55xOGtDNDDSSQBq731UcdUxklwWD8zEhH0Ok+aip3K0F4dTcPUOBI8d+CbrW/ckgVsOHSYcduxalyJY4IzSf8fAImMAWAZ9ON5299ovyeMdKXW7IL+RsWUA3tB4YUaNC4Bru6AwWF8RNzJi9uY8Sh5nzofqGEQILY3PB2gmKgbjwd5Sr3bnyqfpGHQmhdf0QsV/ZY9HIZhdoFucP4eiGtQPrfosqKiDL+nzIRkfR7QxzAxZMPdfhb0LRGLzEzfPlYFMxkfKeoUYYvXKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIoKNNgPg/eP8sIh56tIYK5nc61VrjgxPNZi9SB27D8=;
 b=LMrCKTLfDzk/39Hib8bmwqjUAcUpgKNDYY1u80hXT7LdPupZauVtYk0muvqytYI1d1h6ZWSr728zKyqRWUNMR7Tm5RsMbtYQCM/1KBJXwipEPEKhvpQu3wnWBd26oDgh41OJkR6NLBE0kqr7VfvSwfvfTgpu5rMrKo++OPo4GIlpW8fTnf+9Wfjh5Fii0JIYfCiP/VczxY3mir+5ddB0mHVbMAEzEcP934LmMKMjSawfyJ3JfedAKCGn8HIk3dm1HPAqgeusVPlGOXj+SN0OBrb/DG20/4MJlI7mPd6+XY3JWGgjd4+tkmRO+6yYFxskFnxQKrXIrPI6VXKQS2sxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIoKNNgPg/eP8sIh56tIYK5nc61VrjgxPNZi9SB27D8=;
 b=xrBb61dA4Ki9CDia7VbavgPov5MrTx5jQh54uXcXRaO0azJc40iTcP2vazNtG00GksnMkVweDJxIKNbsPs+4tUl/pqef4BzGe0UL8Go4fSuwjVhzZrl62KXMwb/F5IZAtL47qDeOeoVv8pQH9WTWK3u9QfWm+2MtgxQW4DZTPIQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3418.namprd10.prod.outlook.com
 (2603:10b6:5:1a1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 15:25:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 15:25:24 +0000
Date:   Tue, 22 Mar 2022 18:25:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] block: avoid use-after-free on throttle data
Message-ID: <20220322152506.GY336@kadam>
References: <20220322065504.GA24523@kili>
 <Yjl95JV5yANdC/QK@T590>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjl95JV5yANdC/QK@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a0ab68b-9a2d-48e2-b656-08da0c182f48
X-MS-TrafficTypeDiagnostic: DM6PR10MB3418:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3418F4551149DFE2A0D35E328E179@DM6PR10MB3418.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqUfitgXBlT1X0abpkHJBSQX03kADdMTKW0mVIALvmydHCUUQm57T/uD52EiVbxWyk4QfrC9elaouZLtZFg1YulGlkreoL4X9hJyXaMKI6KMMi0uUBcb9H1D7AHIDV5swR9ZXjTUgK8CYvXnyKJvRKcHBqN3FJDr7Fr/ByinBMb+AL/AtWGHuYEnEvPAOA9Ef1QH+hTFXQ98MsJSjqOa5fa+OdPN1GrgQH7RvwIce7AjEIqcKLdUmKwveqyNwr7Ky+bK37qNt6UaH25HIVuuUZ9i3h6W3OpoJC+hfNINA3TlHu0N26e9iDdCS4XCFvzJMcOo0lLfX+SLwZFJN3pOhpxKc7/N0sgGuPNqhxPaonJTPGCgQunr9eQFj08V4eDz+4BGPqjlvnyvHdWLTEJftHpidVDsWsXk1TNZbpXFjnGBF5Uy1VnBZhpxaDjoJ8dksQEJH+gZLAqDlmYZS/MhSDr9L6X/XgGgfVnNAzRItPMPDvaYoTHsAG0YUUY+L0cE/SH8E9cfr4wmcmFMwY2t+DzVPnvCrj0RIOFg6uNBwS8W/8A63inNHYxgA9lSF5y542Z7lks3htnec5UTRtuWddCVCtIuf3YMBi3ry5e5E2r6XgO/naJFeOmMLtZs217Bj58yKHLZNAliFKSrmBn79V2NUYQhb+V9TtveSQUAac1pztqBj/7uSbpW57bTswd5pCUh7Vm+mlTA23F8YjECuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(2906002)(6486002)(6666004)(508600001)(33716001)(316002)(6916009)(86362001)(6506007)(38100700002)(38350700002)(6512007)(9686003)(52116002)(26005)(186003)(66946007)(66476007)(66556008)(4326008)(1076003)(4744005)(8676002)(44832011)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2yF7yhGGM7y3hGN2POFWUhUvxNECfJhRWP+SJ+4/lIZ8/q00J3YjMPntAHy?=
 =?us-ascii?Q?aMak93tT8gQwnUMaSAVDg+eaxEkfiixDq9ttnAdormg2+F1fbu1YvxWB8oiL?=
 =?us-ascii?Q?yx4x72i2Gti1PHmhp/6/ncAMmiHUldO3gc5OyvbIQezmqcvLNUhJleicqu+s?=
 =?us-ascii?Q?vM+F2b66YJpN3LNaIdSijcEsAFKDghNnwHuBr2L2xRFTnpLebQY+ftE6AGxf?=
 =?us-ascii?Q?M4o1pT1Ag5FuFZE3GeU9Z7I3zTp4sa9YSZlyX6RSy1cNSJECZqh6me8nGgF5?=
 =?us-ascii?Q?o3NFwE9pe0JFhKtKGFWJvqj9Vd+krTNwnzkV9fbfyrVijS7oGFSddmgcBHnY?=
 =?us-ascii?Q?sjGYB3IECWJSxhoe+B2ToEX3vEBzmLIsFplfuQW9JlBbYoSBT/fMfiIwU6An?=
 =?us-ascii?Q?tPRQawcUezIanHCtauya7uhfs56Qu46uSFCiGmcob8vpOkrHy7dR+vXVEuiL?=
 =?us-ascii?Q?8t6Xt2tOLt0FVGXjZKu25BMSiWqq60MRZ8kG9Mxua5WTJm42yGKGhLm9A89H?=
 =?us-ascii?Q?5/T5ympHLhwaYwc+AbU+ZmgEZ95KAgK8zJ/9/rspH+XSqITKxIV51Tdv2dco?=
 =?us-ascii?Q?HLPODI4uNUYWpj/kUQnPoUoNuR7X7OVXesdL5awkWsLt3UmPWPSUcGiVlN/x?=
 =?us-ascii?Q?a/N4DJaJ5OdaRDPgOtVSoAW1agAn1lsejWhzJSYr8EFdPGfDrf5zL32A5z9G?=
 =?us-ascii?Q?Ppfy4dsFQkI6Quk5S1d7eDpPcEzNx6q/V4hnDJ9+0BylwWvURoYWeHBLgyex?=
 =?us-ascii?Q?1k2DxTNiE+a/NFcB7D+8WKADUIR0msyYcIfaG89mdQsGLtFLfvhwCHGdhijk?=
 =?us-ascii?Q?LTnd1xueuqC/1Jh/P5sX6dU3WD1ISjAXQIzVLCR2Uq4DoKw3PNSylYZipJyv?=
 =?us-ascii?Q?2SxzOSAmsuBxccwj8tdIckcpLYSp87P8jTL3TgoV91orw5w8ioKtFayfj0oq?=
 =?us-ascii?Q?Z7QKWQ4km0G6qWgJ9eOJnv5HfLR7MVzpu5+9NDt2yKIckh7XejJUGNvLBNRc?=
 =?us-ascii?Q?EfUe8rf/XqB98pGovGB2aSFuwpqiAlpvt3EMb+WF9rfG/kM9wSxGCT5ppp4/?=
 =?us-ascii?Q?c9d3oOiu98vdJr8JAYfeNwZdg6qYzKkMzFX3xgSiqAEvd+5R1Q11RNkfyBp9?=
 =?us-ascii?Q?Siq6kmLedxgVf44xYRx3sFxi/0JU7drO84mqlTnYtctJmp+2V20D9xdxTL26?=
 =?us-ascii?Q?bC4JQIH3AwDczEQtXwnuHYIgVoYs2xPfObrNJp3B7tYtYkt226NeUDpgl94w?=
 =?us-ascii?Q?/nBzJJspmlg9VN5zNcBCVYo2D/WMl0pxLj/6nzKHT4kov/m3Sdy3XEshYd20?=
 =?us-ascii?Q?6hDLZtyMzTAntVDvZgiRXN0F72LKnGRVofxAXjEmjOyXHVeFXgtag+7B/qaa?=
 =?us-ascii?Q?M40fbGeNGZbzCJM48CX1qvC0+yoIShvjX0xZqxxRckUKRL0IsU930PdMAjCz?=
 =?us-ascii?Q?2tpOBXf+GjYCWIwZ8qoD23Iack08/lInYOwqUXAGonOhbzRUQEX7ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0ab68b-9a2d-48e2-b656-08da0c182f48
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 15:25:24.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcPpQdrXiNfuKkUPYqczIyMeVzmiQGtqD0QoSgLRcc0/NaUixFCpMWw+z3PGcyKpB3b+XMHKTK119WYhDFXVmONvS4rcJARV8CiSCLQwmmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3418
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=745 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220088
X-Proofpoint-GUID: RNOZc5XrR_qQjMPecWKwWGHoBhl6i-aL
X-Proofpoint-ORIG-GUID: RNOZc5XrR_qQjMPecWKwWGHoBhl6i-aL
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 03:42:28PM +0800, Ming Lei wrote:
> >   1187		if (parent_sq) {
> >   1188			/* @parent_sq is another throl_grp, propagate dispatch */
> >   1189			if (tg->flags & THROTL_TG_WAS_EMPTY) {
> >                             ^^^^^^^^^
> > But the old code dereferences "tg" without checking.
> 
> Here if 'parent_sq' isn't NULL, tg won't be NULL, see sq_to_tg()
> 

Thanks.  It would have taken me a while to find sq_to_tg().  Smatch is
supposed to figure out this stuff but somehow it's not working.

Smatch knows that if "tg" is non-NULL then parent_sq is non-NULL.  And
it knows that if sq->parent_sq is NULL then tg is NULL.  But somehow it
can't figure out that if sq->parent_sq is non-NULL then tg is non-NULL...

:/

Something to investigate but I ran out of time today.

regards,
dan carpenter

