Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EAC47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B93861074
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhE0C3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 22:29:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6543 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhE0C3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 22:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622082457; x=1653618457;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5Uo1M7MV56//OzdBYC0FoSFocsOx5CU6RA3cc0Mlylk=;
  b=l4U5Uzqewq/jpV9OXHpBYaruphiUk2BExj8Mrs/7wYdbEhg5ouFck1Ti
   65LiFqXA+Sr1ZhGkP8RlIFX6/FSCXFb+ju8VZxeh2PyISttMW+ox6YOce
   eRBPTSVBbOFgCSxpsFEuV6iaKlOM+ZAzwa2i6EyUioYps9lBadXzykEnu
   otuJwBEBllZW8oIeWxshj6oeRvdjCGZWRYeGRPHxmyQWzTAQ9K7mGgZNO
   Mjelsqn+zkx4QxhVPXIQXPZRhzHOBuYyf9IkiL1e5vXutYMqDU0dNMd6T
   mI+v0HyJAXRMal4InJs3C9Pw1BOj3r/DmkcpSm+MOWmZIo9e3tZfkUUbV
   A==;
IronPort-SDR: rDXZwWCa7jlIVTTXulgYI/+lq4t1XSZJoLOmak9Ggiy//5aloWoPxkz4JXbaiCwr9DeJLPCAPG
 RTLgxi7G7bexy2uAUcO0hW6MWH/QSr5jniZJIq9z+vWIbM77RZZpoo1iCSEbu2Fi8AfICqOqbW
 UKiRm/zDPe4KhxouVSM0UFSZk1tgQhwI+HwsdNxMXk2inBruUPr5CVCNr3x0SskkGkI61apPa0
 PiZuNZIw1KVfvZotxbKyaeOLEupEQ+oFyWNOK9DofWqPeOC5JLxyccp9u9uIJzGO+lWCYvzqcT
 UUU=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="169580641"
Received: from mail-dm3nam07lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 10:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOjDX1xPa2v4PVAmSaBYQaoZ7Rc+D80mWPYHrUgt689oHkLRnrOHANmUD/bn7OYL+l8f1Gg6H2Maj4O/0cVQbfO7mu/m/aVh7HhT8lTO2QnTdpZk/8govuS5D8FnZyssP/5hU4Cs9RaiOhhUqJ1wuwSgLiqOnt2fgANNQ3fW++DjQNM7PHlR4+eks0XsO5zZvRFG+n6jDV932vxwM8mQuMywq75lLHvZ84t4BDge0DXCG/rZ4ILbO9hGNiMvYfMiO0fRVZ1LIWM7GWntYthw56ADaHVWgQneRkUOSAronJlFxOWQbk+BxrUN4cwrJ6yOpT8ka2+zmeKFtAel/pwXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uo1M7MV56//OzdBYC0FoSFocsOx5CU6RA3cc0Mlylk=;
 b=CuXmLx4UlUkonUPhLWguEFrKNg9IG0PIT/ImP6Ip9z6vf51f0IvKQoCCHzIkzT3ptiRaxJawZSlhNixgrHXU50EVs1Or/J0a+ZpEecNIvIw4kZWhoO81+3hpTz125WCF6DcnVUsG/giu/6gigjOLUz0Ofxb9xVKlgK5Afbq6lF1EOeR9FSLDC1orTeoso8vBG/YziddKsuNPShBGjtT8bdKxBCsIEbOpfPWD0dsLdMS8XKmGuRho6K3B1/M+TzT4eS2px0oZrCjrd4Re6ZEKk6ctS1h25xw0gPxz7mbnhnhlEjQSYkaQ2RokEsjESA5d2Gl70NmpG7aNSXxIdM9dsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uo1M7MV56//OzdBYC0FoSFocsOx5CU6RA3cc0Mlylk=;
 b=ID0XH71y+wM6YgF021bj14UK0wvtiBOSJUJR+G9E9NMvVQn2fcKURjYXE2HXu01ofZb8Ju+VjdG7ZwLf1jKIGZqMB3nQiKQ9Wy049zCqY6ckEmibd57T/3kPpcr1tr/Y/NvqQkGxrUpTE4aSVhHK2SVei1NPC0GqVb7faGIu+Bc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 02:27:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 02:27:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Topic: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Index: AQHXUpPl1DeI9JOnAU2p0u/U55WEDg==
Date:   Thu, 27 May 2021 02:27:36 +0000
Message-ID: <BYAPR04MB4965F2E328794C5889B637B786239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3615f2fa-b04f-47fe-a28e-08d920b6fdb6
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB37818DA95793392B00637C4386239@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oA1qrmxRJVmVbx5MJbyC2c8Z+2ghbCuyT6F/8bIj6U9QyPaEND/ctR++e8C454vmoPQhYTOdtG1sZawubK/VfL3Z6YjbsIZz+a51z87ullUkKS0nxFODQt4V4feXl9EW2bLmgF8ngu6dDtD15Qqy1jjbuUWGVYvKvlpTzZ3mgfUsLeo/eYIFq+uZC+I459Xr7XMhJvDRdbjF4RJ1kxCPV6ez6IFDAfHVLYoWEu4svz/YGm3jDvbl5DJRHnLf4lvy8GuTYTYYieNNS2K16Tjl+dDDQXsLvdRmT27aQVAOU2ewnb7DW79zRZiDSOzz4M5m/KFd1+0cy934mKHXFQ/XXvWIJPlker0tqo9Xsi41XY9W61mM+chABsDYNhXsa1y1U05VWrX1MlfwNgPzjKSXy8Gl1AUFceOJat/h/901xyzztxYLlAqc7OX7Nk3hORQfCLaxp3Q6wERhgPEkQ9xHSEdqj+60Pv87VkAf5i9EviUFlnzpoZ65I269Sd+phWOIY3xlDqnPsq8OIUyTXcvdFVy7V8m8tB3Eusqmug9lad9xEkho4pnGp2JggHqldrk6lZgOEK9Sy/WGnWDXYTSHIV4pKo8qwn7Aw2cdq5v1C4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39850400004)(136003)(66446008)(64756008)(66556008)(55016002)(9686003)(66476007)(38100700002)(66946007)(76116006)(52536014)(33656002)(8936002)(6506007)(478600001)(26005)(8676002)(186003)(558084003)(7696005)(53546011)(86362001)(71200400001)(2906002)(54906003)(316002)(122000001)(5660300002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eZp/mC01iYDiVdUDAS1grm4YGbsuE50K2pjZ+6ZGbtNpNJJeRbBvcHJKY/HR?=
 =?us-ascii?Q?LATgJr5vAsyDE+nHerspxMY5/m5+tJfqwweceyu4VSsogcJXSi2U4kiEyL4v?=
 =?us-ascii?Q?07O+VgWqJSPKWQBeMeZ5FBU5AXQrsbiu+Js9Ud2WMBKnhPziqVMjMOgvfulL?=
 =?us-ascii?Q?IeOC0xGHQEGnY59U4BBAHAUxamSFCPfKyNntwhbMMlTIjdsvjJy+KFaLFzW0?=
 =?us-ascii?Q?DGE0NAE6tbrzKXGt/+FEXe1lzhNV9hCvAYFD5VB232+l5me3GllwTt9IWrc1?=
 =?us-ascii?Q?Ygctx41rLut7+PXSZU1gUAXf0ztdspRvXaGygdqIy/yBpqimeM/ZQBZjPYlh?=
 =?us-ascii?Q?4N+F7OirI54vUYLG+5X9GWI7PNIvIFnghZVW9cwGyeNjSuPYNbOeIaWXrQVd?=
 =?us-ascii?Q?2h14oa8J3m9bgU00jLz+FTCH34oGDg3Md/riJcnfzrJfD2rxJOK/es9YXn/p?=
 =?us-ascii?Q?hmsud/sEDCq1fuGu/XuNVAY2crhXdWAgJPXV8GjBb7yew54bZ2Co5/0XBmds?=
 =?us-ascii?Q?4wJpJZwA4pykaJDpN2LsHv8+JKpMMKCHnrLsl0N3HOWjN+LShg51+RNM8SiM?=
 =?us-ascii?Q?SnsoYLelcry1YKND2to0qSMO4uqX3fEMWwIqTCYXhtFU5PJ284kS6yvDXCfH?=
 =?us-ascii?Q?oJYVyCPLejmEN2WwCzzjbNzaOZY29zs4XzMoccCo6ogE5SYGS7/1XNNEtHCF?=
 =?us-ascii?Q?CHcrimTJGJYQlCjlEXB7qMH1h2vrh23kucUsQRundcAxQbLmsj5cSNNbJLbD?=
 =?us-ascii?Q?WN1cfESNSGrecA7ehJd1aJcY1+8gPPmSE5p7H/vWymvOl5ZEdHOGP40ui2bI?=
 =?us-ascii?Q?/zKdP7jEZfwdb2rq5hon854P0+OyDR/nZ889RaTVd71eQ2Y7RaFtvi9HpYEO?=
 =?us-ascii?Q?bclCRZJu25PtN9fhIvdIHpubRG2N9PkTglf8xYv646iB2CvcrN9I8IkwoWda?=
 =?us-ascii?Q?9SFP15EYb7cJhieAyjlEfZ7Rl3PDeZ/AmrazToiOFmqROXkrvshWi7YOVsz2?=
 =?us-ascii?Q?LVhxtZQcYozH2eD6lAKdXYdi+5ThrtTRVqIHrbBnFIqedRK5ETgtIp0fpizC?=
 =?us-ascii?Q?8M5vCwCb7NTEMll8+EtdVCBXMhGhzyc0IwpQ0jKBqS47m8z4nPDpQ4/3/VPo?=
 =?us-ascii?Q?9Aw2udAO/5AL6WMMihHVfShEw/JL9c+KHWEVJO5pt46m01BY1DJuNae/kNN+?=
 =?us-ascii?Q?sgeVo40KmT/k8xi1RfSJhy6Vvc/Jh9SOTBsRUb9MXbvPA6lJ3mq5+ThJvfsf?=
 =?us-ascii?Q?181T0tCqItZ4sLDCyIfAfnnc9YOWLEdPXQBT/OO8hnuUw8vyeqj5/pejBZK2?=
 =?us-ascii?Q?i1TqDcFSnCjveIkuJDNXO1nR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3615f2fa-b04f-47fe-a28e-08d920b6fdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 02:27:36.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6p4cy2FXlB/R3zW5rwYXg1LunL66qvObfb01atfOthz/1A8MClP0EuOoiCSZKxYkBQ/M00Swa8oPlL3bce1uOtC2eZO5gHveO05bNmJlWHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 18:02, Bart Van Assche wrote:=0A=
> Change "queue" into "sched" to make the function names reflect better the=
=0A=
> purpose of these functions.=0A=
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
