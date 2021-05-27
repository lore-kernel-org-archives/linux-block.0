Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF32C47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0426D613C7
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhE0C0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 22:26:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59484 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhE0C0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 22:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622082358; x=1653618358;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mnysazS0xEILy5M60YZFEmxnw86Nvhqfae/qAtTPJM8=;
  b=eIjwOZQ7U1YJcN1LyHYLfeSOsTW7m83DXOy56AhTtmEQjPCLB1e5TeoR
   1bFM8kTBzIvDE8PNWfe/4Bok0z1a13wKfEqcPHXhSf10RGyjCFkGNpraj
   kgLG0PRr66BeN1cAXmwoCk5wKSi35gFAsbCBGf3R7aa9lvlTtAZh6TqV9
   NM7SXq3eHL05xYc5qbadKdO04NlmM+evNm6kXLVFgbwAP+nrJ1Z08juWD
   UUC1JJHjm90bxYTLdBdlkmV5vcjFrXLBkomwMLzZZLzNbyhBSvQnvHXEj
   AR7vi9AYrQAFRobusqNTR/GZuvG1O1Lac6WHXG5uvVl8ruJKSAXD0zNi2
   Q==;
IronPort-SDR: C4RJzBABc7bWxFD8I46EXuurS03lmdl9H7SeKsUdzc97j+qUwxM8DyaR+rccq9n9JhraNkR2wl
 5vz63KzNS2yZQTWVE0Ym/Hr+7m7c4XXs6VUW0JQiDOojvgpRbAVnKVyq+Kc4AGbRbhGiw2znTX
 4BXxBjo5BQxBk1FjHcEhLBL6sEQ95fnPmaT/iCE7yyJOlnfBbW4rpWmv4XPEoCYMkfvKOOTdbb
 Jkrc68HwGeNT4n6oXfRvFPHhf886kpEX43FMTER6jHjkkNryXBXrss9MgmekSYyv0HDfyNbTYX
 PXk=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="273492856"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 10:25:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkrOO7XVQZfaSlQOtlutPLhxY/3sAF6Rni9DC22veM4tVbij9Ny7RevphdBvOn/LS+exeHEM+l6KGvFR2c7MLEV5P/kkMhPmzQKBb3UiuNlisIXwtvvbwCleoL84FlBgJFbAHvlaSsiAgHrsO1lc6GAqFqUBEXXb+tLWfLmlBu6X1el0bXku2vUr7P4HMVQXMSZ59waS2mAKHilwi1rgJ38YLF3bQl9JnE6omF77Y1DrQ6WKstNODsOCEU9Xvm2HC592yR7dQYzCfSbw/3NaiwkJUiAyOPZwOlM4pfR6R7DoG3JMUclSTXV/xpfAs6Ac/VzrBgr7MQ1xGU4E9y4O8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnysazS0xEILy5M60YZFEmxnw86Nvhqfae/qAtTPJM8=;
 b=nbUEH87FvDUDpOQxcPqNGNVtXyoTOY+Zjo4TWouI0y+TRWVoU1HOaivL1gIyOgavLWcXvszwyUM3RgNnYBl42//JJ/SA6T338Igi5MyVPYUVqI1GahbLUxQjsmHfVk7fTTdjjEDWAl0HW0u9KOIjQBWDloWZmZcQjO6rq8UfYIG7yWyEUdycHssV0O/h2gwU0H7WOW+RY6JEvO4eleVOfwEivxn/jSRYD8861iLiQMmwUqi4VI2hA43AOXJP3LRqpWoZ5p3P726npUxMQpey0RtBmn4uDxfFGpz65bnoSrIF0U+UxOCYkbpSkDg555FOXoQMP0fNfOiTDVaVa+xQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnysazS0xEILy5M60YZFEmxnw86Nvhqfae/qAtTPJM8=;
 b=XAdMrnvGlfybhBUCvt4PnkWL1nOVrV0pprZCB66gdEvFuukidkyplE/wgg0uDsh965v3qfecIdk1Om/LV1Uy968YqG2CYcXJvHlTR4f6diutVudV5CkpH8FWdopd/5m+kmFpSZfPLiOQHneXOiHaEx8scGsCXdW57lS/ye9ahsw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 02:25:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 02:25:19 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held()
 statements
Thread-Topic: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held()
 statements
Thread-Index: AQHXUpP1va1OXDDQm0aS3cCQed3M9g==
Date:   Thu, 27 May 2021 02:25:19 +0000
Message-ID: <BYAPR04MB49652C94B687597797E80F7286239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c19fd667-74fd-475b-70ac-08d920b6ac4d
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3781D1D2C05091D9FA0B78A386239@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nT7Ze5nYZuZtNx81oEeUXxBG+PWvYvvI9qtWkXrdjYyZf9H5nWk5cDJpUg4aNZaxTFhyseyI71GkHBIVp2X/NMuDy+pm4gEdVfC5NaX43qhenhHLQmg6vOFCuJWFFd1wKf9VM5Ypo2ft34GPijcZ44Qd8CaJ5tudE6Jf/aNd2+hRmzKTm0lfBpm+ue1qZbPSEfaJRQLFvqs049KSIiVKlKlxaTrgsDoI6rG9sJTmKQqd6n8yMp9kH3Hihd1bh5n4Yc0P7LyrMCJElIiw3go9KA/iYRt5GDMJ07yc4C0XD9aneBkznFpIQV1DvAArYzg8GPqQXtBt/bUr94aAqsokW/tHyDBew54ydVWHw1FZEGdFz1+lcPz2vgJzWvfVLN3NT2nT+P1HtDRN+dOQRgRvUAfc5N5L69JJ9E0DS0tUiediqOaykAndFI5tQGF7IkQ+lbaIgxPaGgrlQwQ0Hd+OFsthI2bfBUVYqXtYgixzfCx0RV0jbOVkbtAmFdBYxm3xJsmQpEo8MEKl34IuWqdHI38QhbqPp05u42dQSlVpoRocPG+T/8pHZY5tNDwyMDn/z+0N/PqFfrPbs8BBdEKv5u/1tIgFM8Ta0TkApZC9FBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(66446008)(64756008)(83380400001)(66556008)(55016002)(9686003)(66476007)(38100700002)(66946007)(76116006)(52536014)(33656002)(8936002)(6506007)(478600001)(26005)(8676002)(186003)(558084003)(7696005)(53546011)(86362001)(71200400001)(2906002)(54906003)(316002)(122000001)(5660300002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ccpvu0ofTSmDhAkFwOKUVZa4BdRei4pIN4Zg2sP9TPiNtRgbOscp1/xvwXD5?=
 =?us-ascii?Q?Chz40YF7emN3NHDM96V71k/xUN/sm3JDnaMlC2kMwO5OQH6BAYI2WRX6ZddZ?=
 =?us-ascii?Q?MQhzQG067y8PjkDjhQP/KRQrBhETGF2SxAY/CEuXPT7rjAjNvroR9d2osdpd?=
 =?us-ascii?Q?LWEPKexmQs6M+OdKR+ktWRFb+714d85M/nk85veubP8Ve0wh0LFDkUwAWZEx?=
 =?us-ascii?Q?BsI0AN/b8h7iULWYG/BXz46MLgBbia6QUDL1pRRDO7SgQdI/3caBDlejqnSc?=
 =?us-ascii?Q?ykGMGiIGlidYpHcOl7VuCQLLmTdO8DfhOO3XEWPNiwUIGwwFc3+QqI+ZabW9?=
 =?us-ascii?Q?o290KDxCCeeiUuXjMXZ6LwCLM8gmjDCD8zDSxmv285eZ3ugdD+c6P1Eo+13n?=
 =?us-ascii?Q?vj+janfM3dWNwe5hyK3UW6NOLYoxxYH40P8UR14yeV/xT06soQFUJOPy7SRD?=
 =?us-ascii?Q?54Rj+FP7CWdiUhOeIYkkoAvavH6Fvsq38ADmNJCaLteeKL0rgPn08/pmcRdu?=
 =?us-ascii?Q?pd1gTCkzMAm9AefQd8JXrW2/URZRGez4Zycllhfljwd2IN7LEKRVfz/M8g/L?=
 =?us-ascii?Q?Lx1OF9jbo9dIBCFBWGfS+Sv2UAnkNvUhBu+DBmbxCnUEWwROayre1cpDNJC6?=
 =?us-ascii?Q?E527tOyMkOVjxgfSHlxWC+Vxs7an7B7d+04LS/sgTpkxVoV0GwqmnzwhlrLk?=
 =?us-ascii?Q?kIThmwF26o1ftbf1UIpCsB0MU+D40cBGW9el49MuCI8i8l+lWrl9N++C8b58?=
 =?us-ascii?Q?mKNAYpvZzBLZUc1ayxFVAg3OVuaCkPNQS56TSQ4HzWIjZz4YfdjDzCoiw2Tz?=
 =?us-ascii?Q?OmWUAR/0aAVl8SpcQwRYMXRVLaVFtPoJ642oDd3O2Umubf28f4u0mIgXaqiJ?=
 =?us-ascii?Q?fso/CUFrR2apK7xC3Q7Lof8wlmDccGMl/WE/jPTzDjqE34AjSZpxtIYR5Z4V?=
 =?us-ascii?Q?0WRXONZwrZuZ6D+TrFwePssqbQqZycknSU46StxNZRp+FiV6Asj0BepIlOFA?=
 =?us-ascii?Q?yRrk8+mpg9hvRfWbTQXn5MZ15mQf2JwOjEyzButMULYYFgypjfwoPVCFghWB?=
 =?us-ascii?Q?aVtB9slqv75rbJmc2M0wkggIMe04asX0wU2qzHkp2d8XXTGfQBu4eTQxkh2e?=
 =?us-ascii?Q?ZvDFue723wsTwuXW8La4eCrZKuA9IIork27g55wjTA5XHEdQ5FQhiyuI9lWS?=
 =?us-ascii?Q?bJsZz9Z658fUTjADS+PbmF9AukYC/xz1wzIpaF5Ai4mC2cbQgbOdY/SiOD8A?=
 =?us-ascii?Q?siniEUydQVvAj3EaYwDNYruEOsUFkhphGEu2FX7w7kG4piAuHbGG9cR7aMJ4?=
 =?us-ascii?Q?tazv1nRB96lBDuty2ei7BVAz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19fd667-74fd-475b-70ac-08d920b6ac4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 02:25:19.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKKML1AzT5lxbeltNcfQ5BdYFIujrZ6jY9oKC2AHs8ray/UgcIv6q1cPzyxMJowcVTGo1HFrGL6KRKmaCPSD2RFfs3Mnr9MyrXOJrnTkazE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 18:02, Bart Van Assche wrote:=0A=
> Document the locking strategy by adding two lockdep_assert_held()=0A=
> statements.=0A=
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
