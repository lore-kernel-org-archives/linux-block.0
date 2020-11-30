Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE946C71156
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8213E206D8
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 14:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue0.onmicrosoft.com header.i=@purdue0.onmicrosoft.com header.b="H5GOQMuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgK3O7S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:59:18 -0500
Received: from mail-bn8nam11on2120.outbound.protection.outlook.com ([40.107.236.120]:17505
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgK3O7R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 09:59:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCdTkDYi6UNBK6z9Le4Sjurpz6uMaxtZmrVpanEvvRthBDu8mI9r1F+7X2jCOfScUFY3Gsnvyp1j4vUYOqoy6qR2OtrzI7iBjQFKIXuyXKqqbWPjO4KfT3kBWPNaRSUEPUzrnDjEIKAGxeUQFB+aHlQZgMsNlXP3mg+SOUtwK2OKLMKl5JaBT2XApG8LqfuoAyJgqAI7MCpcxO0h8bHTSZa3Sxau9hMS32LbTEWyh82zZkfm8FrYC4hwVDmf519rqDW/GMnnzLUtCSQEehpFWcUjx1jIfzJgezL5GfzuNWUyKWjnpoAm61O6BxCGg/tWmVQVqfsV/YvIvIgN6Zac3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usxqXyGMjQ/fCKbTVplbb25CYFelVwJuWP3F5pbab10=;
 b=MA6ogA/bBRnZfZA1C2IenkY2o9d1OBiWbOgE+guI3ytrBBodzHLRRCCBzY3GeHSPcL26pG2S5lnA0vouOMKDm3oCzeJX9TI8RV63BizSkB2otbQ0tdCTYFeCYd1bc+IF54FBTHT1T4tBBGFC3kqAK6xmZH3JUZKhZ1oySrLu1vxBcT41ag9N/zxGfablif3CADN24Kq6GxcExmgkpaRM56ZRyOfp7eEvpr2lvl51KZpIR3ZghYBPzROABd2X4kDxoya+UItxGK80hWGa3/WY8HPKZ5ms8CjvU4mypBCPStX/bSfvYMOhA/lYZjpmPKPysUnMXEb/Qp90usLKNiVveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usxqXyGMjQ/fCKbTVplbb25CYFelVwJuWP3F5pbab10=;
 b=H5GOQMuGs13bwn4MNjVJftiVXb/fvCKqjp++t03s15LYcQyBq9zC/t8okW5JJM0iMNis1po5cDG8LiGtcQjmKtIub3Hfr6E/ZutIQpJ6tytthE1P6mV8sl99AbnS+TJHsJDjZoZCrvAppfE1lQ3smS30eakZuySyZOD81I2Kkhs=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB2006.namprd22.prod.outlook.com (2603:10b6:610:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 14:58:29 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa%7]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 14:58:29 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [Race] data race between blkdev_ioctl() and generic_fadvise()
Thread-Topic: [Race] data race between blkdev_ioctl() and generic_fadvise()
Thread-Index: AQHWxylDhf3y7x6sF0qHSBkQW0hI3g==
Date:   Mon, 30 Nov 2020 14:58:29 +0000
Message-ID: <7F866A14-69D1-4F05-B521-05212A3F7ED7@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e226530f-ccf5-4378-cf48-08d895406603
x-ms-traffictypediagnostic: CH2PR22MB2006:
x-microsoft-antispam-prvs: <CH2PR22MB20062EBD70F19A006DA3431EDFF50@CH2PR22MB2006.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJ5AvxIMVxK3UKBiP/U5jecLGLig5dhQndCQhh2lpxHKPKL2z2Bgmf+7+AxJgvCJnPSCBu3te/Vqf2z431+vciv6dtomAjZ4XtxpXd3YwvcnLzqscoqlC+/rb8Dc8EMJJgzgvQBypqor3RuBrmgrBrMFqhWSratULUj83NGmvPtWvLQVjYWfwLl+zgGV95C8tI0FGU0ra86Pcls7F9U4O6ftchGaHFeUc3ZavPfeplz4Q9Y58q2KM/bT3exidaHNC69trnrXU7t5UdaaXwjWzAW3CFdTJcgS8UNu0A4wzExzI+TcvwHaKPFhzME9uS6k0meTVOrDOZ8A+UyBPb2g0Mp+KqIFWGVuIvCNdWpnt5TSzAN0jEC7r6JzWBxzi2+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(76116006)(66446008)(478600001)(64756008)(66556008)(66946007)(33656002)(75432002)(6916009)(6506007)(5660300002)(8676002)(8936002)(66476007)(26005)(186003)(2616005)(4326008)(6486002)(36756003)(71200400001)(2906002)(316002)(54906003)(786003)(86362001)(83380400001)(6512007)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y6kjYNTll01wabKLT/t1aS8NWHYSlpooWYyoMzFe+HFVD27TfNQMBXERohN/?=
 =?us-ascii?Q?vDDayTVtXCFH315JWH8Sv3M9tmG+U4fn7Y1l3XxEgugpEzcanQEsS9IofW7r?=
 =?us-ascii?Q?0V7Suue29oogDHVYeJ6y9A4VqBE30HwKNJ6HAv8BFL4TSrfPIhiSx3IbuYgr?=
 =?us-ascii?Q?mjWe7gqUsFoOioWwsDiQVppsYIyeQVCyBhP6roD7XeYnd8Oha+m0g1vm+rr1?=
 =?us-ascii?Q?ozH9lSwmQt8fgoPCN6XsgrJZgBxs0AXmhxLidyZfvnwjJolcfKmSg+nZpjIx?=
 =?us-ascii?Q?eMIyTN6HNcm71ALGUlvYkngFrLYEmVyvc6E+YdN5rJNdf2epKg5srslsUXWl?=
 =?us-ascii?Q?t1s+zbJSW8Ani77R2G0BEyIbLSSlp1CqJiMh/0zkdWG1hsqci4BarP+rsaWh?=
 =?us-ascii?Q?/GjXiBISq/HScrF08LUpi6MDC8xAI2Kt9V4OvNPEJs8JmNK+nTgdF94lMY7O?=
 =?us-ascii?Q?Ueba4gOg68FWrCLGpqsOg1m28rISJFERSX3yqwnnY97+VbttMegKakskkS7A?=
 =?us-ascii?Q?2eUeQkZ3A2VoDwgv3KgX7Pkn9PqrXdjjsYzns74xTm4aIVzViNGBmMEbNuxm?=
 =?us-ascii?Q?pxkFyuyRoy3d3vTPNI7CF++FF7I5PkxEuDDSrXCWSXa9csamatleYIA2HRor?=
 =?us-ascii?Q?oaQPaHdU2gN0y2kfvLM7dPS0YTdAWbi4cc2mnqojdXOFzWGVU05feykf38Rk?=
 =?us-ascii?Q?yasslnL+ee0hmcwnWYB7mDvQ2G4ApNPOnioiii0l225zROffsbP17okympBZ?=
 =?us-ascii?Q?wqcLCoIBaNSCMJ8hFIU0AcLIstMFtOo6Nbcv5gr+/hUpB2HnA1pW/4tzZuB9?=
 =?us-ascii?Q?iPy1gY38a6t2JnFIq9dGBbXV7O9qptU0wdql0b2Uy4QXHTjzU0sJ3JLgAXqP?=
 =?us-ascii?Q?IwiKgz9TVLjwwhWU84SHH+V0fr+7Mr3uMuH2uBiw0MEQiK5Svg3387vmyZpC?=
 =?us-ascii?Q?P+VLAKgVP+59o5xDOoa+NbVoStWDp4XOH0k0Ymc2QWw6O2pA4/H6pAjlJMN0?=
 =?us-ascii?Q?dSKJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6880775AE241594D9BFE5CEEC7046F58@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e226530f-ccf5-4378-cf48-08d895406603
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 14:58:29.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zm++pYQUQWz57wmhPJSpvTF1hmnSwZYYj0Xrl59Wt5pe/46Ck/XeaastfZHYXFh+EuiyDRlVIWf+j2JKj+R5sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2006
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We found a data race in linux kernel 5.3.11 that we are able to reproduce i=
n x86 under specific interleavings. Currently, we are not sure about the co=
nsequence of this race so we would like to confirm with the community if th=
is is a harmful bug.

------------------------------------------
Writer site

 /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/block/ioctl.c:573
        553      case BLKPBSZGET: /* get block device physical block size *=
/
        554          return put_uint(arg, bdev_physical_block_size(bdev));
        555      case BLKIOMIN:
        556          return put_uint(arg, bdev_io_min(bdev));
        557      case BLKIOOPT:
        558          return put_uint(arg, bdev_io_opt(bdev));
        559      case BLKALIGNOFF:
        560          return put_int(arg, bdev_alignment_offset(bdev));
        561      case BLKDISCARDZEROES:
        562          return put_uint(arg, 0);
        563      case BLKSECTGET:
        564          max_sectors =3D min_t(unsigned int, USHRT_MAX,
        565                      queue_max_sectors(bdev_get_queue(bdev)));
        566          return put_ushort(arg, max_sectors);
        567      case BLKROTATIONAL:
        568          return put_ushort(arg, !blk_queue_nonrot(bdev_get_queu=
e(bdev)));
        569      case BLKRASET:
        570      case BLKFRASET:
        571          if(!capable(CAP_SYS_ADMIN))
        572              return -EACCES;
 =3D=3D>    573          bdev->bd_bdi->ra_pages =3D (arg * 512) / PAGE_SIZE=
;
        574          return 0;
        575      case BLKBSZSET:
        576          return blkdev_bszset(bdev, mode, argp);
        577      case BLKPG:
        578          return blkpg_ioctl(bdev, argp);
        579      case BLKRRPART:
        580          return blkdev_reread_part(bdev);
        581      case BLKGETSIZE:
        582          size =3D i_size_read(bdev->bd_inode);
        583          if ((size >> 9) > ~0UL)
        584              return -EFBIG;
        585          return put_ulong(arg, size >> 9);
        586      case BLKGETSIZE64:
        587          return put_u64(arg, i_size_read(bdev->bd_inode));
        588      case BLKTRACESTART:
        589      case BLKTRACESTOP:
        590      case BLKTRACESETUP:
        591      case BLKTRACETEARDOWN:
        592          return blk_trace_ioctl(bdev, cmd, argp);
        593      case IOC_PR_REGISTER:

------------------------------------------
Reader site
/tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/mm/fadvise.c:79
         66      /*
         67       * Careful about overflows. Len =3D=3D 0 means "as much as=
 possible".  Use
         68       * unsigned math because signed overflows are undefined an=
d UBSan
         69       * complains.
         70       */
         71      endbyte =3D (u64)offset + (u64)len;
         72      if (!len || endbyte < len)
         73          endbyte =3D -1;
         74      else
         75          endbyte--;      /* inclusive */
         76
         77      switch (advice) {
         78      case POSIX_FADV_NORMAL:
 =3D=3D>     79          file->f_ra.ra_pages =3D bdi->ra_pages;
         80          spin_lock(&file->f_lock);
         81          file->f_mode &=3D ~FMODE_RANDOM;
         82          spin_unlock(&file->f_lock);
         83          break;
         84      case POSIX_FADV_RANDOM:
         85          spin_lock(&file->f_lock);
         86          file->f_mode |=3D FMODE_RANDOM;
         87          spin_unlock(&file->f_lock);
         88          break;
         89      case POSIX_FADV_SEQUENTIAL:
         90          file->f_ra.ra_pages =3D bdi->ra_pages * 2;
         91          spin_lock(&file->f_lock);
         92          file->f_mode &=3D ~FMODE_RANDOM;
         93          spin_unlock(&file->f_lock);
         94          break;
         95      case POSIX_FADV_WILLNEED:
         96          /* First and last PARTIAL page! */
         97          start_index =3D offset >> PAGE_SHIFT;
         98          end_index =3D endbyte >> PAGE_SHIFT;



------------------------------------------
Writer calling trace

- ksys_ioctl
-- do_vfs_ioctl
--- vfs_ioctl
---- blkdev_ioctl

------------------------------------------
Reader calling trace
- ksys_fadvise64_64
-- vfs_fadvise
--- generic_fadvise



Thanks,
Sishuai

