Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797DC43462
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0356101E
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 19:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhDATWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:22:52 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:47041
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234276AbhDATWq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Apr 2021 15:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqfEg1MWYskkMbQDp+voPLAUqtR1SJoXdSaE9PU+b8Q1r8JZ0b73GsoniYzOjEymgzWXwkHrE+Lkt7LfWUc104NvTeEmYL/2/tPF3iuMQ+m03/fFeGr2sXApcbCHmxQBThk9DDVdAr4oLhkZ93aQW54FR4XlV4IN2qnSLhFEz0zOTXL6OGKFzRkFQukqUpXXJz1gZ0amLIb1W4NP8EgAfAC7cCHX/Ty2WqLRdFmPp/HEsDTf1uCxGfuQN2Ek/ga5Z/xguNKRhiZuSMO3iE7lzjH3sJ9ZS0Bc+MBwPeozeWnOpphVv0XYY63WgTFSh9Or5ib01+x7vAL6FcfohOPhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+1M5YletuTivNgkkvY3Cn6rlRcoFsYZbAcpoEOPnII=;
 b=iEVing+B1H5cliFLba0uKrHdr1DdycqAinF/ctiVzhfiQr4Gq5HgbFnst4Dz6v93zFZqju+OUBgqWtQ/n0jtg/lMJJnGcFhB9r+qwGrmGDWA2QUylEp4+6p/3oJ+Fl0gchdti50rBQukF8c2RcE9gr837BjY7F/BcCKA40qTRlQhhnO2p0nOLuIRK+ULWw/uU4Qw5zfKM9TIU6WaDcYZb4bN5zR3MWCWMkU4r2yF9pXx5s8nwsQfJyZMm9nRmSQte8rd+BgOFEPua+drO+4BDbQ/Y/LCyfSJf4tiero4L5MjZSlxgeGTRD+V3pQlH0bPERYGsGZs+IIODcHF+bpenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+1M5YletuTivNgkkvY3Cn6rlRcoFsYZbAcpoEOPnII=;
 b=HvZncUcgLtN5Ha1kaj5ojpU3wLiWi7cdJ5rh2fyiwDujeKJmQN/Pbp5XZNLptWrV5Re0wuF1EwRK2BVcFkEoAEJebFYLcBseKkiq5j14suREbxZHZrUNQU+ELgYqUSSTAZRoZpcxF2YlaQIrnTO6p9n+uu8agERDXNu2qZPt++DRP5uS4845m0roqrQ8xkiQuPOxnGGWA+02IOCIjcyKStQzgDTPAD8wprry99DMy3cNsGrpUUTnDQjbmM7P1LLgOaVy9kJUkdVeMKEb9TgtIWX7nro/AlaiBSLbQmQa09iG/s+J12/Yl486AQ6dwE05YNyIeMG3aWEoApE3Kg0GHg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 19:22:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:22:45 +0000
Date:   Thu, 1 Apr 2021 16:22:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        sagi@grimberg.me, bvanassche@acm.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: Re: [PATCHv2 for-next 00/24] Misc update for rnbd
Message-ID: <20210401192243.GA1676876@nvidia.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0065.namprd19.prod.outlook.com
 (2603:10b6:208:19b::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0065.namprd19.prod.outlook.com (2603:10b6:208:19b::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 19:22:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2tv-0072H4-Kd; Thu, 01 Apr 2021 16:22:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 146d1ca0-d9e2-49e6-bfbc-08d8f54386d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383614ADAA6AD6AD9C55C716C27B9@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PRkl5825AQSAzDn4k0qX7rcqMqTii2iZ38HUlj1iqjmxaF8q443A5clbWMGreBLwry6FwCLF1m1S5ichs7PVtaX85maEquK2HXRcgIZtD3OzU248Gj7eEt/VEUe9UF35x2AziTxlUPaIqR2i2p8z+rtA2N0mnbx5lX8F443peq90Tl+o5h/mT6ZwcsZ3k/lyTHzR7Bi3FEjVuNPW9s1uPLF0lYmFGxtUoPAQPANzXBbP9GM6OcYxcY0vgLTN5Y3iVIppyPb9rmsLWDv7F/obLzcEGEJLQGeS4BSVfMtaQKsVynAC3Xznfz7UrtKze1pUC+xRDrTcepPilv65MbtuauvND8TCqN3MwHv8ceZjlzMTOSya7eJAm/D3SaQhVka3AnLAC71fHdLnlJvDP5bvBBVoL2D9Ku/OiJIu0z4uEmR0hGC1Vm+97FnDCksBkK0CVXegE34RMKUbs2/p1Q3qm58+B8PvXUWF4ugtDCvm+OFgZyoAPx9o6DT3CCD2vT959CqYajGY0/OvmiTxZwZfAcCmhOn8Xi1xOJytkvZV43D1OGXreaUFBoPAqlobP3MQXLYmSWfG2TwgrNM4T5H7n1oHR2sjJ2PgpfIEOBldKuBy3pawXt0cMnllj3mRv5Tx1LXW8bCnPnpilAIF5Fu48FGxZgz/JlKYFjfhQ41Odk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(26005)(36756003)(4326008)(9746002)(9786002)(2906002)(1076003)(5660300002)(2616005)(186003)(316002)(478600001)(426003)(83380400001)(86362001)(38100700001)(6916009)(33656002)(8676002)(66946007)(66556008)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z1q/Ojm/+hPHRHjy9z59TfrSWzOD6SikEc3IAYd7zKdiq81Xtk/hvTYr6vUe?=
 =?us-ascii?Q?Iergvqd4JNwS2s9Is2iSResDeyZlBCb5zr/6rdaiNrv5XwI7Uq9ktbQU3uVK?=
 =?us-ascii?Q?KJkZmkE5bbUCYL7mcaQM7txVBCUpNRgXKURlDv6PFNBnLnzqedrcuSwa/vBc?=
 =?us-ascii?Q?TO8lp9Y6XWdmaN9Y6zyTQ4Rz+j0L2wkTf/5lOBi+lnHOdAHIsx/6/Sgs1iGF?=
 =?us-ascii?Q?aXiveiOytOELchq36D2adEoAb0tiibdmi4LY9+YE0MZwoa/TjDO0cFa00uNZ?=
 =?us-ascii?Q?/KtOXfjVRWR4Przjg1JJUBFG9YQIAG/pg8fjdu6XtoZn/NiZgokNeYveGQ5D?=
 =?us-ascii?Q?mFsKXuevHC6AKd/MQ85UWIPOOHX/mAeCm4102uNwdbAP/pNB38STAJnavbe6?=
 =?us-ascii?Q?JDCtKbyfhtoAcI80K1CvHoyH2kxfxMjJEQiI2kix7XaZ89mZnOJfcuFkwiJE?=
 =?us-ascii?Q?SsrozJ8q7E0tRnMxv55ylsSWRULjPWwWg+db+LwwySHbJoCHK9rs3hi6r2bB?=
 =?us-ascii?Q?2B4bF1wXjg6MNdRZhNQC8H5xw7Vxvs7t5NMix7w+9C+CLntb5F1HiZxlLdTY?=
 =?us-ascii?Q?0xASxttY1N5DjaoGWINVt5zPqEevSQJ6PZwhFPf5js0fmylxundB9LnqJeZo?=
 =?us-ascii?Q?Z7ixGL7RcB/T+/b0hZwKkkPmuO8r9SazN9gyLac2Hl1DO+zmVacIw8KP0WTN?=
 =?us-ascii?Q?evbMTyiuqAwTxRj3dH5A6rK1CgplvckYMp9EOe1n425r/pPHR/ud00F/MZ2n?=
 =?us-ascii?Q?iX62ESw00wHMsVi5YynvrSE1FzMuTAlRB7PGFmVy05MDSRrFOVbDuxXGzxwH?=
 =?us-ascii?Q?yF/wo8dJQC8oVNh2hRewjT5Z7RgcmBEsf10WP2JfDG2smX6KBd2MC7Zg8pR4?=
 =?us-ascii?Q?hL4wfn6VZPk9f3BTzj9ots2Dg1GCxoE/Zqp2GXrzgOUAZyZKKYA6RuzZeEvV?=
 =?us-ascii?Q?hj8FniGKK/qtkc0ydM10AXh7EjjjBZf17PzoNas/qZ11KkT1L5t5R/YBHLGD?=
 =?us-ascii?Q?xkD4tK1qYTLXe0enaje4CWwTHJz/ftlvYkS6FbnXIkun0cqxZ1A4rff4rHZj?=
 =?us-ascii?Q?1O5wkYsDH/q3K38cVtzG6Dr/HOcbBDjukG0pJfZCV1Pl+zsOEAhju+9+qoTf?=
 =?us-ascii?Q?ok5Nnio2G1VHUQTraFTwXJmwlMBRysNxuFgPF+b+8i/SiSWEal99lSFLxVot?=
 =?us-ascii?Q?HF2jZN34h1mI9zmEfQcO9iAbCOEL7HvnttOZ+WyfuLFVaKXFFZkvWjNeGO9O?=
 =?us-ascii?Q?GEJVuR0VV88JFqWA+Koygh1Y1GaeGqZnbj3Xqvlr5Qh4vwqwNHAWXlVat6l/?=
 =?us-ascii?Q?FtPLz/Rm+eE6j4H0G3k63u3lQkG5ApFIHMubIy32sQMyLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d1ca0-d9e2-49e6-bfbc-08d8f54386d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:22:45.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8tKlgpmqiP4s1/dQZrfEVIMIoT5FKT4Gk0NVEbI2uTd7IdtSvVPO+TbwGuEE/hL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 09:37:28AM +0200, Gioh Kim wrote:
 
>  Documentation/ABI/testing/sysfs-block-rnbd    |  18 ++
>  .../ABI/testing/sysfs-class-rnbd-client       |  13 ++
>  Documentation/fault-injection/index.rst       |   2 +
>  .../fault-injection/rnbd-fault-injection.rst  | 208 ++++++++++++++++++
>  MAINTAINERS                                   |   4 +-
>  drivers/block/rnbd/rnbd-clt-sysfs.c           | 138 +++++++++---
>  drivers/block/rnbd/rnbd-clt.c                 | 184 +++++++++++-----
>  drivers/block/rnbd/rnbd-clt.h                 |  21 +-
>  drivers/block/rnbd/rnbd-common.c              |  44 ++++
>  drivers/block/rnbd/rnbd-proto.h               |  14 ++
>  drivers/block/rnbd/rnbd-srv-sysfs.c           |  41 +++-
>  drivers/block/rnbd/rnbd-srv.c                 |  76 +++----
>  drivers/block/rnbd/rnbd-srv.h                 |  16 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  75 +++++--
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h        |   1 -
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h        |   1 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c        |   4 +-
>  drivers/infiniband/ulp/rtrs/rtrs.h            |  13 +-

I did not see anything to comment on in the drivers/infiniband part,
so you can have an

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

To flow through the block tree.

*However* do not create merge conflicts with the patches you already
sent to the rdma tree. It is Ionos's responsibility to prevent this.

Jason
