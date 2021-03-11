Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6EC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 11:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C9564F5B
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 11:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCKLTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:19:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3296 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhCKLTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 06:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615461546; x=1646997546;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hLWQBAaxtn3yXmdfI76otB4JeavKfhl56mPs91s0Rp/2Fi4Mo4aZNf2s
   Aus4Jl9j9TM8eNA69u0cph03tRwpr6jpXu56XcJRwe9RuqX+U5yplElDF
   Bk+HFKc6ZUyST2OFAznl4/Lx5/pRTmrs0MhKo8dER6ScS5hN72RtjYEz5
   AbERDJ05/BxKxteHtgjkslavBoDUfIaq470i5Lq5UrmcDO24ad1Z80il5
   QkW9XnDg9/sFh/f2xvgxlsF7OJIO95+zvItOAmkChiA6BS9eOr9aPiN3t
   A3vppAqwgnC3eqSC5NdaRtHXOr0RHqDZaSZyK8P3Y1rb0ApEHBKrDcBJh
   g==;
IronPort-SDR: YmSi3Hu0fzhHlWJYraEoLacLo64uzafF/k8lmBgELoAoYvT17Yp2ywoDD73c2L6b0FO7g/qdPT
 HX7D5+BLxaL3utR/Pc4j6NOiQ3oD2c665Uz2N8xaHXeWj/wIszzrF9p6KSfz2m4zxCTLJg/3E6
 I+T7/8wU0Oest4QQ1BMAfayD+CsUAUAVZxVtQXvpGSBhspoj3sYGFueEaP1QWiFC2Z9co0oWLQ
 Z+gyjdTRlssgMamDDh+dVPmm3D7h4IeURonSlx/HCPM4LyxqUkFeS0Ve3SAID5R1Icb1TD69NF
 8yg=
X-IronPort-AV: E=Sophos;i="5.81,240,1610380800"; 
   d="scan'208";a="166406688"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 19:19:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8ZVPb4sHMiDFeh5DqUzgRoVPysBl4PQ0TQsckGQfwTBR21gSka/3bo7Q6cTjTA43bhtcBhEFwaW6HodExxb1fG7ZqOMeKDdyzX/PwJ1EXjVbP7Q94IzTEXTejdm0GcZQgdJDo7G8UuyAoAGaXwV4HMwfEEn+RWJDWdAfUTwToSB+muVl5HZkAwKWsBsA6F4spRqGF5dLVIuwfD6vX1a2W7Y94Ywy/1+aUTA0cCVaB4MIzE61G/q0bmRNAVKHYIauWo2cDAjbQDdWSENTrDR4CmG7IqerfvSS/JK984/JfG04+Ho+/gD8mz8O8BsXUbfAzI0VBPVoOxoAdeVoeeBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bFQa4MWZRVrAu/KT7VdFCYs47+yUKbpVeGRk038qyTHmzNTP/FWMblijCzCa7qR/lVvepzYrVYu7cHjz+/ACh7qfqkHaUjKd9TTQDbOoeYuAa0UdWoHGBNMcGCa6aWIecIuZKL9VW/KQBhHu57ZwqSpDQ8apiMjr4RPxh6SwQfv+aP3fgoBnA7WojNbFDHJL7AtyrEil+JISo7shjYw/4rZxWtI6CWpFfNC2Pl5KwOL+yMwJs44FDg72Ll+MeIFko3VSp0MzDUokviiU6rznhLqrSDubAwO39g9edv8uOWLV9IhJk1xrOCVwRyV1CmhBVKTXYU5DIvnniA30qbWdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hy4Odl9dWvfqHflTm5pzKC6BvKaMC5Fu1T6KvgzOfWgac1ToCd6srhckLKIo69Fmxl+NjlcEkfBmKEC8zsAQyesHQaNBQ8ReunCzcH97b2pMcJ2lLiJgOgt59IfqX9ONWJbZnOEBQzPYjQsWkXbcPKJisXzuGe93adYVP5NScSE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 11 Mar
 2021 11:19:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 11:19:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Document some blk_mq_ctx fields
Thread-Topic: [PATCH] blk-mq: Document some blk_mq_ctx fields
Thread-Index: AQHXFk8Yfk0REIBv7UKU7h2pk/E+Fw==
Date:   Thu, 11 Mar 2021 11:19:04 +0000
Message-ID: <PH0PR04MB7416B237A830612B38DD242A9B909@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210311081729.2763232-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:d87b:bccb:ca15:1ed8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0e4056d-676f-4fc7-2d3c-08d8e47f7afa
x-ms-traffictypediagnostic: PH0PR04MB7302:
x-microsoft-antispam-prvs: <PH0PR04MB73021105ECEF845AEE0CF6139B909@PH0PR04MB7302.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3gCScjGgX+u/ciwS8+l33rZP1LsACom4qH+iblqfkBNj+7gGBTfQaVpe2CmSI9FQwg+2CCTuigrYsB3S6oVWN2KCToMwOyYAX0c1nJMQ4eU+psrxU0q0V/93GswtNl1KihHPtylaUF6f22dOckJv8A4hx0vqd3jplPKZC+P9LUSOrwLnMqHEoAl6JKwX6hEObYc7mMl5lc+n706eVAkRUDddR4gG+NmBffgLNYmfdRzGlJUhMk2085ejhOy8THzQUflRk81X4MKbRgb2j+2Epqi+bSN0vOBsuuXg34NLF2KXQW1lhbnuEHF29v8jFi5cehCPYxOebKkLbXJ+GW2YSY/lay2CIJ9kiLI180PLUN59fjWKbQVw9J2AA7KohAhPLaST/zsek4NAPkIsfmYzKbRAZo9Yes7MLy9F1efr/YXRYJe9u6eo0kmovTse5qUpBqOXy5ZBUgl4yZ93nhHDoXsUcUlu6cOmMC3rTo7OJ6Ot+KrZs02lHkWv7AQD921sob4e3o0l8S2oHTcvZZ7jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(55016002)(478600001)(186003)(7696005)(5660300002)(33656002)(4270600006)(558084003)(86362001)(9686003)(6506007)(316002)(64756008)(66946007)(8936002)(52536014)(76116006)(91956017)(66556008)(71200400001)(66476007)(2906002)(19618925003)(66446008)(8676002)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zdbhZWJHen2V1UEOdCC4zkQ/YyJTw52ARQDiJRcBHAYsmj6oP5S8AV2pRBRA?=
 =?us-ascii?Q?i037/nqbgg+cBBL5pIUgCsKUNm7gwLIjv+DqxHHYYW9kfnR8IGOVKOUuVlMG?=
 =?us-ascii?Q?lG9307oJ8XdBADbHH+j45jwMtMG7C3qXiX4NZrTO6k/xF4QVKbZam+zA0CLK?=
 =?us-ascii?Q?/ScIC+P+etw49HyMVP3P4RZv3beiFGR374U6H9MKBkhJa4kqxc1tfcmWObCM?=
 =?us-ascii?Q?wSun1EtprtXygMKaYPqaf3IRDCMyBYz58fW8ecOy7BS5EQgej20Ebpfjvnjm?=
 =?us-ascii?Q?BS1EOjTtKSCLO/9VfjjADhx0dtdBqHcZwMnkf5hOc+a729NwS9Vj7tZoh+PK?=
 =?us-ascii?Q?cmT7Kn7+MnsfQ7aCZR2HihchSwmiLtihllPFCoRzWhTzhZK5+ZcYNd/ZArk8?=
 =?us-ascii?Q?0N8PzDvhpYEVn5oxa40KDLkom4nO15MftP9Srn00g1C1UY+3xk/GZK+v2dT1?=
 =?us-ascii?Q?XBgWgAPhLe6lVp/YXhzaeQpQVWok+2jw7EtFMyVgOF3N3HPsUecYWpuFyajN?=
 =?us-ascii?Q?WFzgJF3nGT8fz9l1GV/mleoki6Aueqhm7LoDxJZ82FKB1pN6pBbr/u05hh+b?=
 =?us-ascii?Q?tv7SJa9pZWaXVh73eRJQhsOGTuXlZIsMyrv/gRBpntJfk+GtHYiPaPPXmcOu?=
 =?us-ascii?Q?FpbvLZPPcQ6bYvHVrYup4u0hisiBR61PjyYnctDRd3RrErjVnewMfIc3AIYw?=
 =?us-ascii?Q?ue42Q84VzqFX53DoqdQOn9vjpbvDig0Ig23iXymjcW1l2qgQZLg7oOvWs6rL?=
 =?us-ascii?Q?oe2xNCUv4597PxxFUQld67SgI3JEN2wV4lWVQsUBJpY5xRbgRMCYFpy9UqJZ?=
 =?us-ascii?Q?ZP4xDbCmIgNi2WrdmW7y5jbZVECfaq0LlwCynFKCuRQoppn1Ra+NbPhOuJb0?=
 =?us-ascii?Q?A8pMbc/ZWgL+5b9g+EVIhY4dMC59Qg5vi3CCxlfi2tpeKoapG0WRHuV+T7mF?=
 =?us-ascii?Q?Eu+D2cIcm30IUoHo4wXHErebWLvWwfyjD62pZn2mftmXqgX+iugXRAHzloO7?=
 =?us-ascii?Q?tymmN9z06MLO/qXE9qhfRWo7RPory5Dg+MIkjj71cDEqifXRfei2ZywHpD2f?=
 =?us-ascii?Q?Gb+rtQRIBJHl6FboDSIuzktkhsZBc6d2guNPrf8vBtrjH37JhPZ5n/zQtiyQ?=
 =?us-ascii?Q?4I6+LmS7dL9Evea0fP3DPBl/5Ac/FvURhJpR6NqnO0bdNdVp8Oipe+g/2kHV?=
 =?us-ascii?Q?DYToxQ/PjnymCbFe/BnZo1ApAmkK33+8/efRj+szDCv6BWNqMm7DOT/BrvZ9?=
 =?us-ascii?Q?YSmC6vbhenmudSMvnksQRUoI+UchcgSnx5xPFXxVRcbgLGZUyxoBqhcgxhF9?=
 =?us-ascii?Q?Ukzc04q//IsNiuFzjCVr/Man1HKgSYC8ZUc06/SFSVKb76gXfil9z6npfdzp?=
 =?us-ascii?Q?ywalhV7KJ0zzoAFi6f0SpQOomHC9+zOW9Q4828d9ihfZjoTcRg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e4056d-676f-4fc7-2d3c-08d8e47f7afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 11:19:04.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lx5WXFp/f+FiO1kxiSqOMJMiFAMYa+yW6ncbG7oZWhvuN4ZePOs1dxeMuYu+xplyyRo6BNaSiBIQ8MwvsePjNZlLJnKuUjG1l+oTAniUkts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
