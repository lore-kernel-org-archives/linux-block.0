Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25893C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C4E61181
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhDHVTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:19:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22409 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhDHVTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 17:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617916739; x=1649452739;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M8kaYVjH+giBOeWDkwMjWKk0kz2mBTLyDcQhKvxyVWQ=;
  b=WmrU76u82unxfx5AnzDcEesFoQN77ZLJL1botpj5nSnntn3TS8lwqxWE
   L+UBQTyOfor4ke2xgqtANqST9WFdY4w23H6ue2k165lmt6Aw7rIONBz0B
   FUfey9CBNccDPcZDMWMJT0a1W4IHuXQV5cX6iDznhiN9+XLeP9iZr176e
   Vo0wgOF/AZsMF/N3u8eGmiobDmSsX3acnPvBSDYzheoq65f1AWQrr6ntR
   NS2n8ncGMrLyA0J3lwPAMbCJ8BnYQA39PzCB3rAFLjEJth+TaeQrnLtLe
   ARw1fjUlUXcuVZnMCcEOg1QpFLjfWhjI96aIeFJd/nLDZwILPMQtdnz/O
   w==;
IronPort-SDR: 5qXNS7tLq6fLG8oYWhfKhivHWCYRvuRK3OhnxCywrpC2T/4L2b9lYIGtb+hrQVOKn8kEwWDQSQ
 Ss8LfFwBzdTrmM/Wr2H45xc3+My30nQub9GLwAEbCsPkTgYSd3l2LutbH0jcHnppPOtmZTCPBX
 osbiYoSSNf86N19tVybAQ2fcGfY419mxYkFLQc8TGWPxxMv/Bk6xbeZvyVHG38ih89oSoxZgFH
 +sfyldbgCjVEl56130ZOpZ+5k/h0gvJHegYOxEwhdAsxSrZ4L3hSeMz7FgazY/3qJ7+ySSPzm9
 okk=
X-IronPort-AV: E=Sophos;i="5.82,207,1613404800"; 
   d="scan'208";a="165114665"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 05:18:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZqyb+GwLokawk4BeEOg5aqKhWrpin2bgvf6NYN0Y9zPlX90y9kviXt3jv86/ZMz5ITYkEqvk9QjREE799oSqplw0gLzhA3ykeWRzQB7BJZEgXBvYLojD6iiPLm9VMpBfM37eEc+xZhMSXNbuOLIc7P6oRbJigAk1fe4/q3d3KsLtwfd59LTLgWRKOCyulV7VwpBf8AzWpjYxH9KRPi0LZ9YfqpC/rYxDhkF31UsiJ1/STDp35G9Io/XdvA5QTBV06Xg+hnodYWT+uXIxja1mNJjTLqq9fTzcHrzfA4TtI5O+154Tfddgtwf2AYijV0d4T3v1bM3ntN7yyOvDz1ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8kaYVjH+giBOeWDkwMjWKk0kz2mBTLyDcQhKvxyVWQ=;
 b=WnawDuyK2PktlAaUnJcpBDtC6AjxBO1X7wPSjXvbMlnLYDEA6KEWMzfGtBWFxAFv4gyhDl3AnQDBj4YuCSDbTwXqJ1ALFPuVlti+vYRRQb7yCz+mpL9OV42AktiPG3xKixL/Tvn4HTTylIsrq3VlexBAe5ScaAc9s8vDuQ/YVz/oihgaxN/g/O2jjPqwT9VCOFWNS+dV8JsYUeQMDEMoEao4BsIiG6nXhr9nNvbusmMaWv/WgumZJGmcFU/wf+mWuUuoeYa0KH8KQQiouMsrqlifY18ZbLQUhRLDeyxdQY80SbWJzdLcpGgORln8FGYYgSW0r5oLXW7UJtUunl8jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8kaYVjH+giBOeWDkwMjWKk0kz2mBTLyDcQhKvxyVWQ=;
 b=Uwj5K/liTF+L6t3Z3YSiLbW2eOv50EEYkfPpWgVNadRWW6JzLlaxMA9qnAOjew/iruLNV0MIqyHedyNgFOO27GtTwydfOm8aA+LABmJyu961vbx5Ryy+cT7ladA1+rZxzE/ZB0nZ5VjF6t4AxqJD4TQaO2XcywTWzOeXKWKOaFo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6803.namprd04.prod.outlook.com (2603:10b6:a03:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 21:17:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 21:17:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] block: initialize ret in bdev_disk_changed
Thread-Topic: [PATCH] block: initialize ret in bdev_disk_changed
Thread-Index: AQHXLK+GiXEWSol93EufkpfY8Cay6g==
Date:   Thu, 8 Apr 2021 21:17:51 +0000
Message-ID: <BYAPR04MB49654DDBE3CD0DCA6E475C8286749@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408194140.1816537-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b66bc8-91d3-4af4-e96d-08d8fad3c454
x-ms-traffictypediagnostic: BY5PR04MB6803:
x-microsoft-antispam-prvs: <BY5PR04MB68036B83AACD9290581DF14D86749@BY5PR04MB6803.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GP9lhiNBtz+UrCZxpkQeDqBLdBhTIMaY18933C/NB9y+Kmd6BYhLzSq9x8qZIt+5RIFeKT4VgdvnD3tXZVuNWFEPBrSf2sb2bXzRims1lEA8tuFjCj994t1W8TSpXFP+op/+m/sLYGZ4i+pWbBNxNXnc+KRYYmSDM9JCby4iZTxehvyyjWSsYPMlUt2dlDvkPysRBXdKNq9SdSvYp63EqfttJKMr/Xwd3RW3ElEZy2Q7Zpst/iauu5PJtPIAK57bit9xU6tYxyyLZNZO6dQk0QneV4dFok80GMVLiH2KG0/I9K6jfJNNfoSejPZ8KU3KwdCfK6XZoR0vY3IswIKRSYNA/Pp4ietYacTJSAqlV5aY+Cy0QGzofc9/AycnyS14WE7jw5xH7LA/OBJJW76mTp89cUQGiqOuYMa34ddLERLT+rSPjjceB5w0+sHoATBZe/lOxMQhP0pMoKGn8BH7r0tNlNvQaSmWFI5NA2t6SnX6A2/XGeLrZJFFJUQ2mNf6BpLD0Jm2QqIyRPAjiDqam6N4RcpY7lpvmCuCoYtMcjEaB8WvBy4jVEdrddNT3px3JxU6buiY6l3mxmen9JY60nsT6E8S1uQ3+1VeoDsKWV8H0MLzeZdLsiOyvFaUJ61hmwOIazloFl2a6u7W3i0UGBc4DklvVSSOuMWOLJQwkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(86362001)(9686003)(33656002)(478600001)(186003)(71200400001)(2906002)(7696005)(83380400001)(316002)(52536014)(38100700001)(8676002)(8936002)(26005)(6506007)(53546011)(558084003)(4326008)(66476007)(66556008)(54906003)(110136005)(5660300002)(66446008)(55016002)(64756008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ylZlIR6KhcwhtriaWdAPPH5FhPYQ8O0QgiyQXf8MCcnWFLyOT+btHiGoGcc8?=
 =?us-ascii?Q?Iru9BppyEYYHRudXld2LR70an17VlxlaDFFR51Fd/ex3T7N86nSmNZzQyNEd?=
 =?us-ascii?Q?xFRPt4OS2lwZ6bWVyRcq471cTWqSdrYdDLIBdxt0LND6uvlSXmFZzdZv0g70?=
 =?us-ascii?Q?qWvg3H0u08f5fK0pZ/9y6CWlCyJKCcO4D7vZ/qRAyR5AnHxC8djb13kLyh6o?=
 =?us-ascii?Q?rZ0VyQHPoxSWlucDtkO1azItEPaYUpp2yJd6n0Jb0V/ProijbZXIzsc0fZIi?=
 =?us-ascii?Q?0spV7Vu/Y3wcYbPyFmRcB7XMrr42EXW/U1XpaWJQhIajZDTFz3Xc8Gi/eU8/?=
 =?us-ascii?Q?fM2tCyFuWGTSiWsr9NjSdSS37kw5B1e5853+Eo913X3yP3rKnQEy0xV1Ec7j?=
 =?us-ascii?Q?k8yqfPy2KVmPCbCUUWf5nzkL6CpdUDv2EdAvLrG/wY7ofWbD2pimcyZKuJrf?=
 =?us-ascii?Q?26iqwgu8KvaaC0a086N67BYNxgQcCaczmOwwJvSxrQUhaOw/qUcBu8/3JDCv?=
 =?us-ascii?Q?ICmlLkr6i6dFFCrK4SqQHtDVpbCsONA846y2eWY4xuWwP4LS97t12R5gEL1w?=
 =?us-ascii?Q?zAhzy1nvtwHXOvpRFXfpHCmAlB1+fN+Rsk3C1qkVTJJwsctastd+xffErL1J?=
 =?us-ascii?Q?cB0bQm1QZuLI3otFcYzNQ6cpnz1qZdD5lX6CvEesF7f6N2mhsjxCvJUXV3yC?=
 =?us-ascii?Q?bLai71N/qfWlDtnMLevdEdDqXkCt6LQlAz9AjNnqKBVNIt1EuH8zF67n5ekq?=
 =?us-ascii?Q?dM1AcM/JO653vJcAcEKMwoHvrPnNEHZH7m2LluBo5NykYSx5O7r/K24c3sKf?=
 =?us-ascii?Q?+2Eza+Yj0lW7mvT6wFmpOCLT54dWsuK4b0l1GKfO9Iz8g7MANTkr+MmiLnBS?=
 =?us-ascii?Q?buKo0CMkcOzm5qFRc/ngK8VxTWYWCc7gm0eSYj9O1O50zAOth5W8iKMOaCm8?=
 =?us-ascii?Q?2cKcAIbIs2HQKMRszG0JVJ2emKVYNYzc/adXxu4/5jwPUSs+JJZCM4XU9muc?=
 =?us-ascii?Q?rCzgT6DEN7XnPnh8zjxMMY0ihz81ij11Y6fg1ATXH2xXHlinbQAq4rbL7z5G?=
 =?us-ascii?Q?op3W++jAjbAWVSz9cmOWIQLIE5K38UvaN05gvMpQkHV0DQzjxWhGxE+5zewZ?=
 =?us-ascii?Q?CT56MGbQLq6tsDNB9E1ABSXMOTCuifE3wtnwS08UzAKVtIN4YHKvO1mIpCgz?=
 =?us-ascii?Q?9YIEnTIhSdCArEmE0gfMuNVJiitLiad8/jEhVOZy43lD288m3joT/SLF1ubU?=
 =?us-ascii?Q?SH9qMwACfOf7L2ldTdRxs0DuzdVzUjAAzJU5LPBv4OFD0xvIDRnTST9uviHN?=
 =?us-ascii?Q?ZiLaNyYKjFEsJJdZginA2rEC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b66bc8-91d3-4af4-e96d-08d8fad3c454
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 21:17:51.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jThtajID16wwtGa6lap63Pe7x3MdLRVK+6wtV5Os0yRQ33yAKMZnBQnX3zlfT3Uo0nJz6rDlJu/JmrkitxQUWjeD8PXUxDwT22stbA8IUEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6803
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/21 12:44, Christoph Hellwig wrote:=0A=
> Avoid a potentially initialized variabe in the invalidate case.=0A=
>=0A=
> Fixes: d3c4a43d9291 ("block: refactor blk_drop_partitions")=0A=
> Reported-by: kernel test robot <lkp@intel.com>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
