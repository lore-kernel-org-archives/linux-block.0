Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE3C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 17:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BE0217D9
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 17:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="hh+U6xGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbfBRR5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:57:03 -0500
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:12640
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389053AbfBRR5D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 12:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehhqHTOk/PCzMkF2U7VL6n/KW4Oa8FXEYUXzqyy72/I=;
 b=hh+U6xGgqr9Z/lqS46UKCxuFyZqAXz9MA8Kuq2iBl/CDAarkN6xrT7JFH5S95KKlVadiff5vTCUl1bWXb6CIX3mvUshzVur2MYkKRFvE1CpqErBOu0ezzy3Nmacb2BhRoOXvGTN3vTETfsNZcWzGR8ItXRvlopmI7uZoVcknlMk=
Received: from SN2PR01CA0042.prod.exchangelabs.com (2603:10b6:804:2::52) by
 BYAPR01MB4854.prod.exchangelabs.com (2603:10b6:a03:91::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 17:56:58 +0000
Received: from DM3NAM03FT052.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::200) by SN2PR01CA0042.outlook.office365.com
 (2603:10b6:804:2::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Mon, 18 Feb 2019 17:56:58 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT052.mail.protection.outlook.com (10.152.83.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Mon, 18 Feb 2019 17:56:57 +0000
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1IHurB2016875
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 12:56:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A03527A5774; Mon, 18 Feb 2019 12:56:51 -0500 (EST)
Date:   Mon, 18 Feb 2019 12:56:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bob Liu <bob.liu@oracle.com>
CC:     <linux-block@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <shirley.ma@oracle.com>, <allison.henderson@oracle.com>,
        <david@fromorbit.com>, <darrick.wong@oracle.com>,
        <hch@infradead.org>, <adilger@dilger.ca>
Subject: Re: [RFC PATCH v2 1/9] block: add nr_mirrors to request_queue
Message-ID: <20190218175651.GA5210@mit.edu>
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190213095044.29628-2-bob.liu@oracle.com>
 <20190213160408.GW23000@mit.edu>
 <56d2dc78-01f8-9991-9199-372fe864d9f0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56d2dc78-01f8-9991-9199-372fe864d9f0@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(189003)(199004)(6266002)(97756001)(8936002)(4326008)(229853002)(86362001)(6246003)(8676002)(476003)(246002)(2616005)(126002)(36906005)(7416002)(33656002)(217873002)(103686004)(47776003)(5660300002)(486006)(6916009)(478600001)(50466002)(36756003)(106466001)(26826003)(54906003)(786003)(305945005)(42186006)(106002)(1076003)(2906002)(93886005)(316002)(16586007)(26005)(88552002)(23726003)(46406003)(90966002)(11346002)(76176011)(75432002)(336012)(58126008)(186003)(52956003)(356004)(4744005)(446003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB4854;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af35365-1b5b-42e9-fa9d-08d695ca79ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR01MB4854;
X-MS-TrafficTypeDiagnostic: BYAPR01MB4854:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4854;20:LD0/ERwgkrL5VewofrypMT/gEDWO2blhLmPCoIk8MKSdogFTgvGKSe/dx2fnKW4LI53DQcUCJAAtPCkEONkTdcllZFyQYHSccd0Fk0lu4/1oAn86oSbh0Yax2k2wfsu7FXAonNhTvoQ0FZB2FfvufcJh9fa0LY6wP302z6jnkVPO8ZiBoh7y+V86YJEQWb6bMMnnz9L7ekhdctP1OGZfDRdFQd6vUi2BcxlG5zwF1TNllU8WC48TN/kREJHbNN7UEWfsUA3PdTrfIBgFBM694Gz9omdu32knNrSDcleiM+WdPIea3DUiKsG4Ge3WWsz5LqTXUPRsopgGe+DWectPO+xnP1Nr1o/W7em4Yb35oCVz23VAwbIwHNPMbXhAQSCWj6do7Bwbg7xGsR/R5seHjlMl4ezV0vCZVF4isK0+PFjKx0zugcvO2+CTth45pvc1bODrw8lNnk3z1IHGt+Z5nq49ZchbZ//+YWiZpXgNnHsneeRAcpsvoZIlLxixEfYSl2QC21ZJIxr1zT0jQdCHtvYUwuMQ909m4ILBndo+cnl+13XV7HFdJ+HN98CRMQ3id+2XAs4+nkknSzEENahTScMOx5sqdAImvlChiw8hgFA=
X-Microsoft-Antispam-PRVS: <BYAPR01MB4854F56496CF7AA4613F1FA8B5630@BYAPR01MB4854.prod.exchangelabs.com>
X-Forefront-PRVS: 09525C61DB
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR01MB4854;23:8BsXKRSVehdQ4al3DKUN3BCW1Ngw43fzcKBm0CsMG?=
 =?us-ascii?Q?j5M8dJg2nX/d+g/9VsgJlNJV6Yv8HYSV0jo4TsuQHZQHLtO9KOWTTDZCckYL?=
 =?us-ascii?Q?i8cEYx9DS+kXunGfEDLCZ1tyzKJbp4nILK8jpV9lBQDO20DgZoA8rI+KUuZT?=
 =?us-ascii?Q?a+JHEQAw/pC//1ouacscyvT8sxCzBpVxY3G9q/nfKhtb2DVr2+DGX0j5Ps7W?=
 =?us-ascii?Q?iI8ogG7Hj8laPyKtkdvjCyriWeNqnS5r3i6o+mvDjVImURkxsVYSIK7AOpWe?=
 =?us-ascii?Q?MVonjERcNe9cSeVeu2gEEIHEBgVP4/dWR4/srei/A97e6frwyO/RR0hJyHHP?=
 =?us-ascii?Q?eL4fzGC+4b6kMg7RuhvnQjC8eln4XitR/JAq6pvQhnqrsw7/k4QejPTZPs7G?=
 =?us-ascii?Q?1OlwH94JT+isgEhO6MRQtu3QQ0d2mNasv386OYF1W/XNSn/yVrKlK/NCd35S?=
 =?us-ascii?Q?MT5738Bix6mBd/X63LpaCXpVeVIGU+FkMUkpg2UvbTYXYlliGkHHnDDV0IsR?=
 =?us-ascii?Q?pbKlER1iMfLpPsSC+YkkzrnQ1usrs4BA2W1Ed0H7AaKvDGKpPa1L+XkNsDnm?=
 =?us-ascii?Q?FovItDEnhMrQaXRGKdYwp5xey01KpN78J/5rS6v+VARhnbt3OCGeDu9P9De6?=
 =?us-ascii?Q?80x0Wi6Z711bufTmpxfBjhPiWJcgOt9kPdnwGYdvmzlwNj2u1mJ3rHh5hkYG?=
 =?us-ascii?Q?ByCKhmI/5TpX7W0b/YtpWoJAOgsTZ1v6vF6hSr/pbqt0nJbs910X8dLTWu6Q?=
 =?us-ascii?Q?JEW/WrXePUCDqvpXnFB2q+qriLP3uCN8ccZtzSLGVCH4SJXtS/AitUnMCznc?=
 =?us-ascii?Q?l5sk22HDulOJs75HBvTEekyOyHBL9k/1/EKvXPfr3mAiSHbDCqiM5YB9x4QU?=
 =?us-ascii?Q?Qgtd1rHzETLOfRrnOds8yUD1YfquU4Tlsk88OgAEN/7FKruf3HDXoyyjK11/?=
 =?us-ascii?Q?7E75spmLLhfuf7/hXDajNM0SLcV5g/T1iPDFaFamRpWcQe/BHwkCO8GdIZrM?=
 =?us-ascii?Q?A4XJqWmV75IQ0zI8PezbwNLhIxDbgs6dNZ9jNEk5Up62qrpUiNwr0HN+ycAq?=
 =?us-ascii?Q?SrIygXMjmW9YJSBQw7EQpzuKQoO4yfY2m/VuegMziZni5iBvZ6qycWp8OU2F?=
 =?us-ascii?Q?ZPkmE0qiT2U8+J1Ctb+85BVgkaE5bQzsV0lSE8wfM1oe/pVW4a8A8j8kVmAf?=
 =?us-ascii?Q?5zK3vW2VqH1++kX3WvR+DIN8CZpyV8TrdC9eEXnxZBUiDHDYEy12n0NedTg7?=
 =?us-ascii?Q?06QCTphnZEuJyZENFtSNXMqmFcKh28ZhWXs8fXtXR+nMtcJckeNX+X8tKzS/?=
 =?us-ascii?Q?Qsw17VRvtExuowi8iBBc9Ku1V9WDpkO86VAQ3uImBo2?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hfJRjEvagOisZn1LsIdUUoMZ+aeGaTzEQMCfpM8ZrvOG8HAB8q0y7LGoP4F35Y3klYW1a+vr9Zcir0ErDQ+MB/hPMdZII1o0/jlyvzXk3Ki0xHLEdJGV65BajkVHMhp6TNhPb/8VCO7CQSUXjCWB750XfJtE3kJYmjiMsU8vwbqj6kZYBW9kgMOHk+Gri31YU61Nr4iOi8yu+oo8yRssHIcuNO5owFb+n1ijNshH/NBH+12Y0csK5TdOUGUibkT6u6pjYu845Om6hbi0fWdGJeGBN3cDdn3nVxQwi5XPTvRzUTLK7pxHbMCQi7YZj4OhSvc8dgjvKx5g5jemnzMO6jT/PRpN4or6xC9UlRKKeRLrJGd1+lVFGOFVqIVv5f7gw+I1XdV79zwA2lbyOStNt//TXWpU+aJxCLByqtc6kTw=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2019 17:56:57.1193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af35365-1b5b-42e9-fa9d-08d695ca79ca
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4854
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 01:57:20PM +0800, Bob Liu wrote:
> 
> Now the initial/default value is 1 indicating only one copy of data.
> Would nr_copy be more accurate?
>

Well, it's at least shorter; the problem is that it's not really
another "copy" of the data, it's just that it can simply be different
(multiple) ways of reconstructing the data.  I suppose we could say
that it's a virtual copy.

In any case, I can't think of a better term, so nr_copy is probably as
good as any.

Cheers,

					- Ted
					
