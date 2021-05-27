Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1CC47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A473C613C7
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhE0CaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 22:30:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33455 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhE0CaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 22:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622082532; x=1653618532;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=r4CxrW71PaF3SKoNxs3qVL5Xn01kf9531sd3WAtcCXA=;
  b=CwcH0dyKxgaPvOHcTjUkQuMSVLiiN5NVu7TvkpGcmajprt9e5N1ikG/G
   yIWpcZUE6HjHzYV6gC/GLj6LXmoG5P5Q9v6x4C5TuPUDO18zE1fjkOG1c
   1JSSziFAQ2WKg8vjU3KvCHe1iFADQd2l2xyScky0ipr7v/W8rKCpbra5q
   HuYL8gCp77cLhwr6nPwtHV1N5vtPCLE1HoVKkE3rJCIHTWKWL/jUnJron
   eL3+YRXeW4vXcotwRICDTVaHNw7xzCMr3/82X2+bZZ103I2wjpbrk/pJO
   x5nvXI/fFGgsLMvNCR8nm6OTgqZV14G9GW8n6HSjQaYlMnroin8DmRfN/
   A==;
IronPort-SDR: k3SyyJRDNNXU6aMx4cwsqASmw1XRFKGGCdrqKooeIuZ+o++jgsDyV2k94ZrKozz8QFzHvwe/po
 E5P//Mvx9w45xx/I/GQgEEgRShsLCBTdRouHN31M7RwzgkCbkaBtH8Wl32t4bEYFvALvcVG6gr
 LNvQF6vA6xFi7Bzypq2eh7qLcmkYdiC7Iv8lPgUoDvoLp3JNPBEGPm7PswzRtb5cbSgdMASHSX
 zsb5U/d6mZAdGCeV2TG8DQtR04aJ3ZckdmuzGaVWcxYSeepZN5WGuRFYZvoX8sGFO4fDN7yZZ6
 sHw=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="280896940"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 10:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsLRsrJaFoia1nGSPNY37KQrhpm/GmsSyDGae9ulMTUZFlmcgayllG0pyaz17VD0jN0lztz/ULzZPhM3sJgYRtp52fGE79rOyemgMG4luxfoRHKowEqR/jvnOa/NySdrc76Yq3KXmDssggSSjU8e6MDu4dv9L3Refo2mMh961UfSy1M2k5EqM0hQKCKzBlqagltO7Grgwbjgfrsch9AfDSKpP493mQuO2riEvgEZw3DO1AfeMuZ7ENBGXWI/a5KZMNLrRi6VGo29PrRyiIgzn04aajKxwY/kW/dcuzG+22H/n1rOrToQRX9lliH6EpvIvYAbj5GpvzdPUMvP4TUU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4CxrW71PaF3SKoNxs3qVL5Xn01kf9531sd3WAtcCXA=;
 b=Jicg5J5aHPg/Lq3I6eUHO8Dda/iFhpD8DPuRVLVcybGJpFeEO5YuXQBiBYSXUu/zSCyph2kRaEku3TRFoHpZRGNasFQjB6ONAlVQKZKov+Zfcgs9I4B5k+J4wKJlCk9HlUzFe+lV6OVwdi+k8iVKsqaGCkfFXAQZCFYKBoN+O2zZflBag7Fg0t6BEx7cv4UxmlMUjgOxAsUe3DjfsbaCe1X16DkQQU7gJS6dZzt0X8y0L4OM9ro32kAp5cNxV7mRVI0yHlzCJGr+RZW4SZXWne4mJU/cq2cDB4xmUBAIk9xOlfIoBfJCUh5O+V6BQq84BNVGcBL93m1+XebtU/QAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4CxrW71PaF3SKoNxs3qVL5Xn01kf9531sd3WAtcCXA=;
 b=SH0TL/S2Fn6GwqKPPVEbJGM81BOBDR8bWISCJqOSpAu87jwHRTSN8biyF3ea+vV56VorL3MUnmXKLrZ1rkNyOAJK+o1p29JQ2pj9vgnaBcvgMUkHnMo2fRMhsdG8MHgxHPLWax8M5pf+0LGQVO9FV9UsF9edqYeC4VWgROflob0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 02:28:50 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 02:28:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Topic: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Index: AQHXUpPnkabJk79tpk+Q015bpXMDzQ==
Date:   Thu, 27 May 2021 02:28:50 +0000
Message-ID: <BYAPR04MB49659919218722CF04B645CF86239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e2ea0b-4d0e-4e2e-8856-08d920b729fe
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3781694ED4547517F61BDAA686239@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HNpL0KBhafc1Qfda7y6AxLilPMcDTrtis5OQheLnljn+9uHOAZB7RCRkkSzbFGZ9+4qQv8T9Lde7DBAIs+VEW/Frpj0f/oQuDFdnF0KeT6CqElvrXL6mnNMK/RIlBoewfwIzIecS7y4C8HN6uKz9ZTCnoEdjZpoIPn9+5RKzTxebo+CzZESd+jyNl4iADOE5NKerJocrYQbygLdWDnZMDV1cLd3BsboJzB2S9UVknV975wdNujqXajU9gECtrrDdJ/e44ec2JJsa9TG85KQfdCp+jtJ9qVQsewInbL1m5GV/KqXj4y8mEKvYWbdTJOAjvd0X9NSqIb6WZbzAakOrUS/rk1IgEM3jSNZNJ0rh9aSV+d7cJj31Zgs+TqTD+WoT3D+RWdo4eGTjm1jK+UsmHbit9xCBo/Xrjr7ODGyidB0JgQG51rNdqcXsPxEm++XPBlG3M2xDuICNOtlJy8oNyXBsmzs5r/xNWnyAluoUDOKaZ9abTtUeTJDXk6uCU6SK9RJAdG6Ezajt53Zgam20lTEzHVDUDZP7HgRc/VLbroXl47t80KKU/X1xCAfaXJibuN6SbCYoY2cad7nNNSVs4/Ldh9aVVdXM5m7ta3tIxDo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39850400004)(136003)(66446008)(64756008)(83380400001)(66556008)(55016002)(9686003)(66476007)(38100700002)(66946007)(76116006)(52536014)(33656002)(8936002)(6506007)(478600001)(26005)(8676002)(186003)(7696005)(53546011)(86362001)(71200400001)(2906002)(54906003)(316002)(122000001)(5660300002)(110136005)(4326008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?me+Xm7cVffvq5Fp25UVd/4Skz/5LXHw33scJ/W+fBQTo5/twdu3VGp8KR0wY?=
 =?us-ascii?Q?yhAzyywfyd9XSOepOeRdbxkDtLZinSojatpVIz1ck6Yl/23HkzgwFaJnYese?=
 =?us-ascii?Q?+TK6sZR8OdoNbfdVkzykcPBUt/I9rsLt6CxSUznz2v5+rrVDDntxJClc11aS?=
 =?us-ascii?Q?NgMkujTZ21RTtsLuOVGxP34WXC5OuSICyvtqN1yNfDyVfUfzpyUivM1mwx+M?=
 =?us-ascii?Q?tRUZysIQx4AqNvjDzK10mxBqHrK2wki1FTcZe44rxq6QI+goADfYmb6UdHw6?=
 =?us-ascii?Q?OyfFb7HiuI8NalJ6zd6q1t9ZeeVAaDF7zpqS6vTnoe70BSfOJ4XVfYmyyVV7?=
 =?us-ascii?Q?j2QRhRuizJh+ridyTXHVhnwSHnDUqN0KEPEViwaOuo+uK9D3Li6IfWWaC+b+?=
 =?us-ascii?Q?W7mDlkpe+eE/QHxtBLsx147fNmiRrrOm5VIRZ/ixtdi61vKELxKk2rq+9DMP?=
 =?us-ascii?Q?H1YvUkDvz/i2uxvRMtu8Sc1zTa8xwJq7Sh7vj2XP4jxeX9rmu2ftid5B1Cyx?=
 =?us-ascii?Q?qRPxFJJtaM9rMzT41ymUk/jmvAJAOvdDPr6hDlIFcaM0DTcHqXb4zi1egGwD?=
 =?us-ascii?Q?D/kU5OkBFp0eqHMAFEFHMeIO4TOKdtniVDZRT2nxCceNnrGlnrOfhPOPWfbM?=
 =?us-ascii?Q?0TJOsVcCdqZ9kynBqbS44+6tK7WPhMrKyCBCsMGRmYR+dn5brTivIbQLSh0U?=
 =?us-ascii?Q?cj8whSYktQPrmUy3mpS/czWsmu/fF9Ngm0246K3kI9mQGuFyKPZhsy0En/jO?=
 =?us-ascii?Q?RmV0qBlYkT/nKKURRMpFT1lrVKCJ/Rc29wqhS+IPDqbesw4D03iIPha73BNL?=
 =?us-ascii?Q?K2KwjJNp0vgcDX+a1900pqrjHZjOSdjr6JxVNQsoHn1TGEWIDHmAXB3IsIk0?=
 =?us-ascii?Q?lYth4+4PdrC4o5R+h9VMMIgS4vjFFHP33ij0j8LEMTZSOJ38MRhLYeMlqJ4O?=
 =?us-ascii?Q?QrI9fKFZjwKgPotAbeJPd36AdQxsZy96W7QEBJV+z0f9ynar3sBeeQbgWiTw?=
 =?us-ascii?Q?PSCQ4c3CkSKjXAwZsSaJ/TpqDa6Su9UUtlOd46M0JIrydLrLhrf03g58C03Q?=
 =?us-ascii?Q?GnnstgPEPzEduTUoLA7OtsX0nav8s0ww1khUZBtUVJvpQzWf0slKtR1KLo3p?=
 =?us-ascii?Q?k4kuM7C1mcqgp8DADhkvghCL8Q7kGPfWRTjmXmIJ0cVdmcLD2BkfW4QrwvcU?=
 =?us-ascii?Q?flfCuGlfO00EXRWE8HicUgU5SVzvRxFV308UZkv9kYRcmXd/4T9xxggmJj0U?=
 =?us-ascii?Q?B6mEaYmERVDtaWxgG675haf5CmuPYylopo4veoAhLVxwWjkr7SDUulAvUzmy?=
 =?us-ascii?Q?G0OwhPO0b2w9/xjDM+gs4HR+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e2ea0b-4d0e-4e2e-8856-08d920b729fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 02:28:50.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KpqgBsU/Goq9WkhNQWqYwrrAqgmLHHUbEb6udHh+B5wjSqOPu54ImRChaskotzCPjA0JtgwA26kZC8Ka8lF5OsAlbg51wiURLf/xWmmtwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 18:02, Bart Van Assche wrote:=0A=
> Modern compilers complain if an out-of-range value is passed to a functio=
n=0A=
> argument that has an enumeration type. Let the compiler detect out-of-ran=
ge=0A=
> data direction arguments instead of verifying the data_dir argument at=0A=
> runtime.=0A=
>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
