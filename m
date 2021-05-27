Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D4FC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A516961028
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhE0Ipl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:45:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35717 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhE0Iph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622105053; x=1653641053;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5rJKibo9Bd3pNEIrZ/kFtYQCFwYihoej8qmsVyUiGo8=;
  b=DIMTMHCYMv1AJSI80G7tdgstf/wwS7yYGmpV9rOZ6g3v62T/CVMtRmkQ
   Fy3nWZMnsyVmHxAksAuvPEwAiGccU0YNX2biSoeKWJrq/Y5/LKPTqZXfQ
   5bz8yq+xcECG5BD9acT5eV3qziRnU1aR4iB7qbIBgBWGHeoxln+4lg7pm
   iZakshi1WZOpAx0JNrRdO5/dehbD7+yURy0+b6FQ3HzESofhp020z4tId
   ARYOzDwaCrSjfxiqhAhUFsR+t9Y2NhJAl4ky1jLiFVsB6gvdj/NJGu4Ee
   pwe1hdtMcWdubRsYac2jjfgG+3nOBxPT4K6GA+ZfdPr9AZV/l0rrRPfH4
   A==;
IronPort-SDR: 5DozP0kXpmhmSOdjrwryqQrVR/8O7yXwexlSPD5g//S64H3aIuiyqGLreyWm153Yqice76pguw
 496u/oKobV4xogH8/YQ27dhRIEPn3G553Hycvk1lL+aJwZR7GkDJAJb3IZZrTwDpftNp1LLLBV
 YVnLbyccGI9RIWcCrXTciRUvxFuja3ST5dgeKe5TSjtiLekFel5+XluU/ShLXfCCqrAle9x6ah
 vOk0Y4SRR7C/5oGPTHGEKcsuFYTV5uoOiNsZhdFeu4enqW65lq9bQeLP02MYvOtEzT+rFd/nB9
 DT4=
X-IronPort-AV: E=Sophos;i="5.82,334,1613404800"; 
   d="scan'208";a="273538024"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 16:44:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1DaQlbA0jhAZ7CiZltsi3iy4KQCFoswNerAcyPmAoMSiyUCwhS+hjlqff7fiWhxgEN5BPp1X762WfsLRE1CNCfhOrANaenksSU8cJUW+4FoSFVMIWVD1TMRN2KauAZwTD0/1bp2zZSsnrvGuBH2FtFsYln3vMO7DKyLlqlFfwsW4jGpHSMOrqswnzy1/ROqNFopB2X1T5wEZ/PBa4Q7vqauADITuKwR78AQqcX8/2OIyrMFKVLsfAaTe9w0hT6BXPZJePcd/0oURh8EsIsncz7+6EllUqg75QFORbDvzzUmJ9hUHL1DELk1zrglxtfE4JSS39fSs9FaHB+INGIGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rJKibo9Bd3pNEIrZ/kFtYQCFwYihoej8qmsVyUiGo8=;
 b=nfMivUw+nESTtYxc/qhXPwkUmQtFv4NE/Vk4qlWFX9yJXCNmoc10msEfj/WykDruTL0sLgnLXUGx4E+FpHcfsFkc3MC6u1JKmCH+VB9FLtu+jXRgxFtjxxfVWGuuIrJITvggydJGf8yEDu332D6tbkdwnewPeVsxHNttDmSprbB2G92LRgA3y8pdcOPFY9z3u6ULeJgLIxu/07tl6qiqhaXNZH1eUj4ht7vd3G3tSwehHlKQp5Hk/0zMoexyg9PKtRP01E3sVhfGEMXYpiyYOc8rMQr2LNxwxHLhUq4Z/52Dcwg2soxqzl6S+1rB0IB3sU1SB1xej3SPxRd45f4/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rJKibo9Bd3pNEIrZ/kFtYQCFwYihoej8qmsVyUiGo8=;
 b=yCeHV4B6M65nTaHIdPMYC3VQEZ6Gp+FGKfgmwDn8kzTtdQlpaHweYZNnLF4xqQ1Jyr1VUekVJwrGGmQtD9KQgmP8p4z2Dx1BceaPVf3uMhePnQS5cAhWSydBhmiqwpykcrkTjlFc7OC4zKxxDUdbAj/NKuNK2Ad2rFhFxnkQ08I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7622.namprd04.prod.outlook.com (2603:10b6:510:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 08:44:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 08:44:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
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
Thread-Index: AQHXUpP1Bvm+bD3p8kyvpU980AKxjA==
Date:   Thu, 27 May 2021 08:44:02 +0000
Message-ID: <PH0PR04MB74164780262D17521561A03A9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0ec4c93-c94c-44f9-7d5a-08d920eb9438
x-ms-traffictypediagnostic: PH0PR04MB7622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7622431DD1AD2C322ADB2B7F9B239@PH0PR04MB7622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bF6oJoE9m1h3TTYv4IP5CGEIjnmxF1eYW+N7Q5TWswv0hn16EzqH9FSblJAwyiKy7j5ACUkekbuIHhuwZMhYtFDOcWFUoxUDZPGmDVyB+QU4NLGfFSzemg+xHTI7yfdMFL+TdcY4zsndFaaEQqmHDOy6HR64FpFNruEpuOgAA22sAX6kORBpHQ+0hjPQxdy+ScWUydn+hXjXcErgvwOrGd3lXQcrwT5asxgvUJ47jkPU4irHspWv145oIBYk8Jdi8kQVH+uU2Fo9vbOD1eHt1izmBuZkWsjdkUcygwwKqEKml5laRNoOBEIbdI/ya1ZdbBL8pgoPNpWfjaFC/eKClcJh6ohZn5b/xciTZZjIsZWHupCxPNt5qLOgHWO1Zz4z0Z2xE2KixZaPnT8bU8Fy/CUBqVBBOsGZzYTmI2W7dDMMICEk5Ea24l/oXjIzRozhN/puOj09qSLGSK5eJkhoYgn8IIffh7WpPT4UBVUjH7Map2lRJjZdqn/sIfKJc7PaO7rQxR4smQyXRdsf3c28yn+ks0hOlCWU5FQSu1pJa0hIfUU3fEY1P2Rea3PdiBIjFRrQpLNx864Fe/grXp0IPCLhf8C/kz9MXhCgSBHCko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(7696005)(478600001)(6506007)(86362001)(4270600006)(55016002)(186003)(558084003)(2906002)(71200400001)(9686003)(33656002)(54906003)(110136005)(316002)(4326008)(19618925003)(8676002)(8936002)(5660300002)(122000001)(52536014)(66946007)(38100700002)(76116006)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QgjMO4C26S6icZ5NxpZUcjwrKFfGKf6FcXRiVUD+/d1LAiyUpnM7iN1EZBd3?=
 =?us-ascii?Q?QYCHSQcOAXK+ZvdbCaB2MOce9Lh2RO0THennE5cB85BRDGLfg0kedDr1qU9U?=
 =?us-ascii?Q?aNmOxH7edzKt8mBK9NA8YgzDONzgiHezRzWFmHE+SsmYSl4/a+cKk5VVQ6Ya?=
 =?us-ascii?Q?8SFYiJcR97lPaeqZgOwbBfWCPZCaOfwzTIgA2FMEBlf4jjIY2pubu/Q0v7M3?=
 =?us-ascii?Q?S6sMQ6QjeZAUl4hm51pm54CKYNgF7u6YpbjKXcesuc8T76eEoXtfAV4JoNzh?=
 =?us-ascii?Q?DA5I4ZRmjiu4+BtbcTAb1cTJFFugckcUN6LAIBDl0cTWRfZko1LmbSRD06kE?=
 =?us-ascii?Q?PVx/nW3yNs6b9Pvv2EFFm4HbEKFMSr8sMCegV3DAAM2ntaTabcNSNQ6x86eb?=
 =?us-ascii?Q?TSok6xpS6pDcrNwUZEOCJsvoycVqNyCuPoWxaZ/Awriue5hHLAoAvDsYXkux?=
 =?us-ascii?Q?9qFaVo9baUGkZFPNC7PDO08PYAiXaFW6AGQy4wybgBPlS8hSgSH4G2a3fmzY?=
 =?us-ascii?Q?4+qhTmzfPvO5RxBb35rBi1kMSX3y+w+aldk7qGtD+Bm0i51MEh/lfp0c3TQZ?=
 =?us-ascii?Q?sSYJtyCh7qK5lylhdFIPFpK3rCeJBK23i8gfApKE+Zc9sKDvlJo8z2QOAGap?=
 =?us-ascii?Q?rXauAHnu2DHPMaW38Qi7nV3eC8hlZepSg9KDBEmO6kBl872F90P1Z9RfvvW1?=
 =?us-ascii?Q?fax+VoUgTvLj/JBG//RWIEhUTbJGwQfSXgaEscwMpo2WRS0FUqrsM5YELDqQ?=
 =?us-ascii?Q?xpqUUgcT9T7N8rV74DpNORcaXxBQ5IhlFoZqmJDAhpnyqe74Dk62uR5jlhkd?=
 =?us-ascii?Q?hxK8XHVdKXiEkDgCDAPe+MxHOs4+EFJPupVBvFi/g2tmCGBzIt1KslE4+dnx?=
 =?us-ascii?Q?Mja+sObQZs04FXMVptv2ELmMkY9CfevZjZG3GCmgs4bd7sI9fqKFs6VADYfm?=
 =?us-ascii?Q?IOXLQC8IbL/mxiHgickm7AldUYg8XyN9MwIJXaVqUK6lnyGssXEPVYmSkOhk?=
 =?us-ascii?Q?XS+4rR59YpBgQmmxFhMh4i5gb+jWt2iTmHS4MiAwYMokfex2q2q+L7h4asrg?=
 =?us-ascii?Q?TLjkXJG1mTZS6q6AREFJM96u0mRqDlED1Wrv3AzusmVoI4bun8NW9tmtlaiy?=
 =?us-ascii?Q?f5sgByty767EQj3nZMkrT/xRtbDqO8VJfnGM/i5qAeaxCnJf3+vxQIAttOG/?=
 =?us-ascii?Q?AUmN/9JskJSp+WnmehcqLS6H8sLAzUYCWDZ8hpp0Leaw3Wo9NmW1zM7O8hAg?=
 =?us-ascii?Q?M3rWtIlgrz9nYzG8hli5QED7iiSK8fX4EfOotunY7YwLeSDM1w1kUqt8jYm5?=
 =?us-ascii?Q?XiQ/B+KBrct2XMHY1Psgs/knd/nkz74Ctx3LKwGLcL4NUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec4c93-c94c-44f9-7d5a-08d920eb9438
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:44:02.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onJIOi3lCELJjXcCqHRyZBF8O2q19PVKNOIVk9mnw4OIDWQeQpAsS7rOhmVeIzgV7bDtFE6Ue7kphwLaGsdg/14Ml1mbs6+zN12BZ6S60vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7622
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com?=0A=
