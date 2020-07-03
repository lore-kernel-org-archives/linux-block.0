Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F6C433E0
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C94D206B7
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 13:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G7PHcRIc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zAbiGc+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGCNCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:02:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56667 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCNCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 09:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593781367; x=1625317367;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=d9wQppb/ZvEDda8ooX3NUuk0Ma9Oy0G2WC1EJihT9RY=;
  b=G7PHcRIccTwR2ytE7b5T4lIWYsXWuLbtswFM8omFa/Rwd8DQQ9qn6Z6n
   z75hpmtAUYp9hbpO7SxdAMV+U/aKiKwCzjGIh6vol5z5Glb9arUEQMTFq
   Tjn8PXjVIP0OdQQPfu6DmEJkH7WeAdAfW615t+tGqCX3Y4QQlstWkBKm2
   R+4sGfl3d3cd1vdBve/714CcDORXziRQvyO8HnSENT5n5wsay5+WkX8cd
   OCbrS5MWYcx4OpxOvE0n9rC6bT56+JBs+z1osrsrN9dA4lveT2dKpyRHT
   nf9SYmIOfXqAEbnlmAoU5hW/5JyB4cEqh6J+7SyKe/PMqwJHtzjS+ORQT
   g==;
IronPort-SDR: kB0a1BOwfldlr+Cuw+VKcVrrI4DP5Jx1SdXFJHjOC3rZgZe7q6+v7TyW0SESPC0fFmfJAW5l0r
 Uz5yL+nMHicURY6E5qbElauqAvVfbvk+5eg03Z69Nbd0NZs7/Jdhw56SCfy5HgmCFzWy3XhVbU
 WMLts68JRTDr6t2s13hHkdRWlrXT8jdM1faBADNaV3wzcC6qCn1eK1BQ/5u9u0BVhACwsgZJaR
 nZyY+Ay6gRwP3WNvNwiu1s28Tj5Fc6R96xlTxu4ZQlBhc+IGULfQL2l8Etn+FVJQ1f6P2FGp0X
 hcE=
X-IronPort-AV: E=Sophos;i="5.75,308,1589212800"; 
   d="scan'208";a="142922802"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 21:02:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HObZ8QccxtmbopyWfd10emA4pVqPNo/ItmgB4iCyEVN6jhKjr3Vg7yYjp/lxaHZFOo7pHLpwftkysf1n8cuJCLxQypBgsrvcBzELpgH0ehPkyvvup6XK323w5TjX4DSbbaNZX/rNkTUkv3/XQOotABbDypBwEWfN2aaOb2xKaxn6/cvPBhRk6gvDRHN4eiV1oGE3kXgZa2cje0zoGk4LQfTGBrl67GGFyRr/xY15o6FTTB0UeUd8Vvc02a0WTikNIQc0pJATHx++LDwEAwNq5p0l320Fbtwro6lKH+D08ug+p4Hf5ZLtH5Z8hG2ETSswW8M+4poE+dlVbhoSYivNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9wQppb/ZvEDda8ooX3NUuk0Ma9Oy0G2WC1EJihT9RY=;
 b=a1eS7ApS97Btiqb0vADmHsrURdgwWFvlQZ3Bai9Vy92jPwEZf151E/sS2UeIiHEMVr+XE7v0NgqahByNe3YCYu2zXx4p8E+6cJRecV4sPGtpV9WNgcB845pSKuCnTGX4StUK/GQsbNzuGrwe8ISjQD8FW9IutNwxNIsaS4PlZCFBdHONM6nnS06qYvIgxad47EQhB++osSimMG+L6h0xPHaKR0LLa1pJTNNV7c39rGJNxcf081roNN2Y5/TzCSoj/wSPMlQNK9dzxMRRNHJuBSMGGwKNKngsQFrRgMlG7I+Ovqjt+tepN56dsnF/h98u/44hXmI0nKBD4Hcsl0HqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9wQppb/ZvEDda8ooX3NUuk0Ma9Oy0G2WC1EJihT9RY=;
 b=zAbiGc+KZhdr6Oiy+tWkOx0RkR0NUgM3lOClNabTk++LuD06I7V4Utujo82PzLJVtfaUJqHWVhkfX+CzmCW/QLFyRTvlxBTAp71C8Ftxrxh7pFvstEHaeM3BLsIXnXtcYcIu8CeCPpwmZjJA4Vca04OVugDm7EjD0EBaUbHVXKM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4159.namprd04.prod.outlook.com
 (2603:10b6:805:2f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 13:02:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 13:02:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Thread-Topic: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Thread-Index: AQHWUIdr8xWbLJJJdEuR1V88dlaKiQ==
Date:   Fri, 3 Jul 2020 13:02:43 +0000
Message-ID: <SN4PR0401MB3598BB905AE2F34D3D7C60749B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
 <CGME20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304@epcas5p4.samsung.com>
 <1593704330-11540-3-git-send-email-joshi.k@samsung.com>
 <CY4PR04MB37516E788EC8804D7DF9780EE76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200703065311.GB26058@test-zns>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c72f9911-8596-4aad-e294-08d81f516043
x-ms-traffictypediagnostic: SN6PR04MB4159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB41599524431BE50F3BD1900A9B6A0@SN6PR04MB4159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVenqDRNcNvvze32Yv3Hk7p6i1kP0PTc2xyd9Q5+8fS0t9lrvgsmpsIam1ptpzYNgJtVWRYi14zI9H2xmwb3UEzZ9uBlZ7gN+e0JfuCcnE4yIkAkJRNDB6/y/A6y3Pn0Do3tXmKT0yEBqRoYKwZN1Q4akq+Wrk/gM5SJ2a2F3ctFqCXAbtJ54l2p5mzvELwpuIIbzK4kuvIOdhe8C73HZ9GHV/E6dWe6/nWrB+EUcA5Zrr+BTc7xZ7Ir8eLzQ0ZZLYEuDNlnwA7BjmBm7WGGNLyZ6cVzdHVde6bd9t2K285/wR5aYLAzki8km+1njNABuhv+aN3in4LqjC26j4gijw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(8936002)(4326008)(9686003)(2906002)(86362001)(66556008)(83380400001)(33656002)(66446008)(66476007)(64756008)(6506007)(53546011)(66946007)(91956017)(7696005)(76116006)(26005)(8676002)(55016002)(71200400001)(186003)(54906003)(6636002)(316002)(52536014)(5660300002)(478600001)(4744005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zQNlfDd7lm1SaxJp5YH6sg8Y4bGQte1YrnTG5ikHAUc974mzWJ7fzC+n0ahZQhbS8B8ce2DfhGm1lHrchsopnt347RxDFyeNtCjz+HW7RnK73zXiipQZvBejg40GLHopDkKNIkQ0uTwvHbeW1OqVFhLWywLIDTSH8YGXpttV8yoeSNQA+dSV0o4yP+9/SfWejFh2McUFwzp09w/ij+/O+Cfzh31MO9C6qqrWvumfk4gKrXJbJdR0gFtqFrY/yajH5O1B9QPVnignm3rHB3FHsk/BL1kd8qyznIEjbzDJIsCgYhFJtZyyaTwFgJhrYjBMqQHZcR17OKLW4xyUuNGJTr+VZzpkblQj8mQBsy4ZxIngmFpBYSspKX7D+0EY1QA/5s1brZv0QMIhdBM0F3QYN8QTM1P4ND/4MBXt3xblMnBvP+CbxtBc94BsxrhofzMXw93BBeD5CCEBRb+86/1QtuhWRUni/lbLJbYgqGnzYKBvANfw2C2KYEfzOZOf6Fpu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72f9911-8596-4aad-e294-08d81f516043
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 13:02:43.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hapokm7eCjIVhe9xdPY/CuU18J0fKnkk4PyVda1rsXu65307QO5wILa8jWBkA8+f3sC+9hJ1RWEHCcxq4m8GWkgU8ZHpx31F6hKhqB+CxHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4159
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/07/2020 08:56, Kanchan Joshi wrote:=0A=
[...]=0A=
> Yes, zonefs does not use bvec iter. But while enabling io-uring path for=
=0A=
> zone-append, I hit into this condition returning -EINVAL. =0A=
> =0A=
> Reference (from user zone-append series cover letter):=0A=
> "Append using io_uring fixed-buffer --->=0A=
> This is flagged as not-supported at the moment. Reason being, for fixed-b=
uffer=0A=
> io-uring sends iov_iter of bvec type. But current append-infra in block-l=
ayer=0A=
> does not support such iov_iter."=0A=
> =0A=
> And zone-append doesn't have a problem in using bvec iter as well, so=0A=
> thought that this may make infra more complete/future-proof?=0A=
=0A=
As long as it's no problem for current in-tree users please keep it as is. =
=0A=
Please submit this patch together with your io_uring series as a preparator=
y patch.=0A=
