Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709E1C433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3332C64E75
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 07:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGHQo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Feb 2021 02:16:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58182 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGHQn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Feb 2021 02:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612683256; x=1644219256;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4/P/pOv2rB4viRD8NVzJl0OwAWkOBL063IoG3rd/beM=;
  b=oKmX460KrPFKWApki0+poZlqIg50DM1a176rzKFeSmRZu/TwwE9yayqh
   +60wAdfVL1vzKUdxOhIDpUZ0APLUe0l2mv2kI2tiTgGqVN16F4/L1LiB+
   2KUp2zbm3nJoI0wBMUx6WFpsfhVV4oIiMPH4QPS02ROkeTMbcJc1pL2lM
   r6dLi2rIbQuYxp9qY5auNjILO+EHor9fVYat9wE0cNfNmX0zFEjI9PBRj
   8ID6cTHyULl8oWsCWtWuhbLxtbBYV1pYDTRRGvhpLUiSyMQkDifNYQ/Qb
   HCV+mweKM77j8Sc3XU0eodDlrbVNrvx0p89DZ4tnrjkWyFepcAPZQ+g/f
   A==;
IronPort-SDR: B1l9ldBHpdIGhhTH1bbqQ5BRb+Mv4G64pR3se7NH8x9O6pPGznHv1720q7Pf6n2z6m2nSrtPGd
 idjoRPoQgdxpC0+jZSUC4L3OYJkl2+lo+gAOTekfc45r/thq49sA+CHMlSBU1+yp3R4Fe/JCUO
 LK3MXtgrpqg8Xh87Bi+vI80NtFQgq767Fxz3z3jdonUSMidQ/jZswtLUPuereC3OBb3HDieHOs
 9EWVdh8SXyJIwfJhwpMbmIPNDF9n4jZi7Aikm1oVlzmSnWhf9OF4L9pBTbmHRZb7fJYN5uQvnu
 KPY=
X-IronPort-AV: E=Sophos;i="5.81,159,1610380800"; 
   d="scan'208";a="263474473"
Received: from mail-dm6nam08lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2021 15:32:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AusBaAvNvBWoiSYTWxBeTsPLS7+AtTSRat4J1KqNwP+c/SjdFr4Ku8045XDjVddACd3mvLFDgkAuHuTM1xvX74Rko3z6b4SBfRWuCLXWWZGZsxtmQKt6TUZTNy0U8HmlZjTm1CJ5Am2FRq+2kHYZIDIOWvC5a4kalf2CdtGqVCIxZzgDqNUTTdzwhlHcow7T3L6LwgOzUGM9OZG/9ppVttd8Joz9TZGCTi52bqCQSoK4gF3Axoj+Re4jhrxdfPt3fRRyfszyVdzhBUjfeLv/ACajB/f9V8hk0zEjYSbmGhCUPxmbyS/hNJ+aGNVEJk0Po9kxt23jhnw3AVVkERzLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYgztG6x3QUQNeeyfFiBQU2vzTDgThOxXEUHJcEp6rI=;
 b=TaBv2HtQZ/i/tEdjJl4ugv2VAa5SiFr3CNgiA+t+NqIy43Xr1n0nsVhBYa5wLJ0NNdcbnB6+s2ONWuqa5JWXZlqbLgJOHpQzT4ND1gBfiegNkmilsKBVO8XpGJyWuWurOj9wRAoAJsm8M6pDScDoe0oLWeZNOEbQkinQIiDbL+ZiX3qI9LzkD345oPST7ZTQTKZawfEE11A23SVA/TbQYI85YTSmGF8Kp46YdnW7t7n2Rf3qezXYh+j/AOJ9scYgS/06wBPS843aAb1gi6V/vueft8tnZSP+blPGFTCf0L0mDSwn+/b8o4/EQouaoLCy1tWpxGv6gXf/Z4JTGhtr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYgztG6x3QUQNeeyfFiBQU2vzTDgThOxXEUHJcEp6rI=;
 b=nORtVLbDKfi+4jETUWUvZQZb73Xh+By0E5f+Livl55yLKfTGqWKJri5MM+WR1zzzQ1NYewFp5b0vEqlM2tPF4LxpyTvTU20iLlTiTbh7H/Y5Zdp2AHsM4emdalDk9ojEe3ZzajYi2dnWDXTyg0YGfe0E7Ds0uXdYZijXz5IrP4Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4760.namprd04.prod.outlook.com (2603:10b6:a03:5e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Sun, 7 Feb
 2021 07:14:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 07:14:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Topic: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Index: AdBd7/Jehsbeb/mKAfYcWAj9LaDbog==
Date:   Sun, 7 Feb 2021 07:14:32 +0000
Message-ID: <BYAPR04MB4965E82FFD9D6FC443C8E67686B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 972ece25-982b-4859-7cbb-08d8cb380481
x-ms-traffictypediagnostic: BYAPR04MB4760:
x-microsoft-antispam-prvs: <BYAPR04MB4760F26DBECD9765F3A3F92F86B09@BYAPR04MB4760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jWg1wKEvUGhAwO6A5HxxTbkn+qPJ0EbnZi61FEK+YN8ICKa/xtlLfbcmj5zWrhqKQi3m2ff2NjTyvHLwC5cbIwMTvqbICZJdjBSvZytcSrhXsp4FzN4+mgQTfTMAHRJmi9n3tXv+f/WQsKN2nKrAyFBIfTmsuT607YYtCAQCjPvsAIbWFVeP/Qq+JqBHuNvlgsy2VI88yEJQLzsRGMAeMubrpeqkYzbBjl08RFl+YH8yLbL8YXwa8f1Y3BAQfH//w8nnPspgeee/kpLUXYRs/Er4r5EXi1eXrp0/uvPY+E4fbLhAXPYsUQ8YlCLuDTxABJ7S7DqP7afM5gJygOPcqwEqd2/Tt/nSS1dp/u4k0wWoXHzHkQgt12ZLjdpIgURbRy5BakyPLIMdmUc64YnC+zUnOKO8c77YHenqEUAet4ffwYRR3jyfOeLSNSwjNOoxqnbaOkA+gjNTC3AZPyZM2OGPcvsbjE/j9ThDBR/VjPAIxFz/H433N/bwFdjqnmuMigwX0bfjsXu6sQIqM2s0q7m2GfbQu9v7MN42wkLgEvUoOhrKeV14mmyMfU6szZEdD4gLafU3c0N82TGZWURt4FEmpgfERxVMMO2zsjyXh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(6916009)(5660300002)(66946007)(64756008)(33656002)(86362001)(4326008)(71200400001)(76116006)(53546011)(6506007)(8936002)(66476007)(8676002)(52536014)(316002)(7696005)(478600001)(83380400001)(54906003)(66446008)(2906002)(66556008)(966005)(55016002)(186003)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6gKTHqIzXTQdUKdW3opxbj5/3anxt9ebUY9pHMTsh0Z/PbltI0IlO2fiV/EM?=
 =?us-ascii?Q?he04/Pw5lYHeKjFOUe7nKFRgM6i+quPRyKoTtd+MsiedjtMlMcpFkBZbxhqL?=
 =?us-ascii?Q?vES0zyoNrzktoOLMEpYuYOCMA2FvX8pyV4Yr56Fk+Hoq2Vgvr9zTNyD+yHPU?=
 =?us-ascii?Q?jok6UWI0XI6CeNQ2yNP9gJoRzEIWipuKdxtbElLVjafEu9xTb4mAWTuPQRTt?=
 =?us-ascii?Q?XZjUJ5Ra8WucLcx9wfPEPhVhqEF6Ngu8lypo15j0vmtYbkD2i5mU7NGemUo3?=
 =?us-ascii?Q?BTy/UByq33AnU58IWFNXhkzzoMwHWLgv2NuyweDg0iBaLpU+hwo3BynzBEgO?=
 =?us-ascii?Q?D9Uqq3N2ruRD7ko92pMZmmtOA60VkMK0HXHmJdC1pLb4tzHq7PesMC0PigzF?=
 =?us-ascii?Q?x2F6HOpFxxXGFlj+sAXSv5qXR+R/Rbug7Yy7HkYjLfyQKNA6uy8BtICG5ZKN?=
 =?us-ascii?Q?bSvEikrPnvLLUdfkkJpbti/yruXhWLv8qQ+v7Vlf58vqcQz2hzVNr+VN6Cgh?=
 =?us-ascii?Q?a9nCX6mAUWNAiEDXmP4SY3xFHbAe04GvmuDDvMrakPMsyYSiQOb+aBDEorS1?=
 =?us-ascii?Q?Mgt8rdUGBOEtutljUVgkVWrZhv1J0LmgqTpj5Sqc/PlkgNZCR4ye6vjrhejF?=
 =?us-ascii?Q?/ZOBmf6B/KBe6PLbscrn0Sl/QxP96lQrKeojxerVFcPyY+T8fIIaAhbrYwNp?=
 =?us-ascii?Q?NaOcRHahH2dF8bR0z5Idk++VffAt+UizQkU+ipSEirRj38FvnHMT/S2Ig43a?=
 =?us-ascii?Q?0MbH0+1O/Bxq2LKm2NWyfCMOHoh1W49atnNe1xAT4l1vkZQqwnuhLZRv268Z?=
 =?us-ascii?Q?J+RkQDEfpx+kmare7eJKaIlAgYkwT/TGPyauMk9aj7tqQo7T34Kgahjlv0Kq?=
 =?us-ascii?Q?KwWkW3o/zGsf8BNrDKLxg+jfWZ5ItpDak5RPdTfR9Y6VWIv1Gq8zcJds96nO?=
 =?us-ascii?Q?oXxxtMcmHJmLFKKaAFiwRgVCVChZXDaqs/eOaQLsxrEg3RqGL/b0YkpP1v2s?=
 =?us-ascii?Q?QroPB1v5sgI8rUPficNwAt0gyXvv8vEtYaEqpwpvQh/8Ymi5+2ssV9pJ1oWv?=
 =?us-ascii?Q?pRj5I6WOTWbNJZS8S0P2fte/kT+O01+DNtnTjtykh6Y8/D61sTCFf2Jd0AzD?=
 =?us-ascii?Q?jCiLYtqbkzw4LSBwpYiKWX+5npChMa0GmEZsLGFZWnk6Zj8sVWDeYeKgX3cx?=
 =?us-ascii?Q?TAGp58HkKyxj/868pFFFOcUmJXIijgou0zqGXDRYILA/tLlAzLDVL8WV4FLz?=
 =?us-ascii?Q?gQmIf3BYJ2b+AGAdA19mujkb9EGfpNE7Sj2yj0m1NywajkVxLR23NGsNTBc2?=
 =?us-ascii?Q?xiQsBP/8RgxJhF9hoznrnoSt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972ece25-982b-4859-7cbb-08d8cb380481
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 07:14:32.5897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atXHldjmX+OfMUNFnCCrwZwiSNA8L2MIGpg1xgFcIZPAqn17g+Z9Au//odzt+5M9OzOCB/HB9NZ5cv9k9552COWxNca4MH9hKQtms9aT2FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4760
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sagi,=0A=
=0A=
On 2/5/21 19:19, Yi Zhang wrote:=0A=
> Hello=0A=
>=0A=
> We found this kernel NULL pointer issue with latest linux-block/for-next =
and it's 100% reproduced, let me know if you need more info/testing, thanks=
 =0A=
>=0A=
> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-=
block.git=0A=
> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next=0A=
>=0A=
> Reproducer: blktests nvme-tcp/012=0A=
>=0A=
>=0A=
> [  124.458121] run blktests nvme/012 at 2021-02-05 21:53:34 =0A=
> [  125.525568] BUG: kernel NULL pointer dereference, address: 00000000000=
00008 =0A=
> [  125.532524] #PF: supervisor read access in kernel mode =0A=
> [  125.537665] #PF: error_code(0x0000) - not-present page =0A=
> [  125.542803] PGD 0 P4D 0  =0A=
> [  125.545343] Oops: 0000 [#1] SMP NOPTI =0A=
> [  125.549009] CPU: 15 PID: 12069 Comm: kworker/15:2H Tainted: G S       =
 I       5.11.0-rc6+ #1 =0A=
> [  125.557528] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.=
0 11/12/2020 =0A=
> [  125.565093] Workqueue: kblockd blk_mq_run_work_fn =0A=
> [  125.569797] RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp] =0A=
> [  125.575544] Code: 8b 75 68 44 8b 45 28 44 8b 7d 30 49 89 d4 48 c1 e2 0=
4 4c 01 f2 45 89 fb 44 89 c7 85 ff 74 4d 44 89 e0 44 8b 55 10 48 c1 e0 04 <=
41> 8b 5c 06 08 45 0f b6 ca 89 d8 44 29 d8 39 f8 0f 47 c7 41 83 e9 =0A=
> [  125.594290] RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246 =0A=
> [  125.599515] RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 000000000=
0000000 =0A=
> [  125.606648] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000=
2000000 =0A=
> [  125.613781] RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 000000000=
0000000 =0A=
> [  125.620914] R10: 0000000002800809 R11: 0000000000000000 R12: 000000000=
0000000 =0A=
> [  125.628045] R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 000000000=
0000000 =0A=
> [  125.635178] FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlG=
S:0000000000000000 =0A=
> [  125.643264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 =0A=
> [  125.649009] CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 000000000=
07706e0 =0A=
> [  125.656142] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000 =0A=
> [  125.663274] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400 =0A=
> [  125.670407] PKRU: 55555554 =0A=
> [  125.673119] Call Trace: =0A=
> [  125.675575]  nvme_tcp_queue_rq+0xef/0x330 [nvme_tcp] =0A=
> [  125.680537]  blk_mq_dispatch_rq_list+0x11c/0x7c0 =0A=
> [  125.685157]  ? blk_mq_flush_busy_ctxs+0xf6/0x110 =0A=
> [  125.689775]  __blk_mq_sched_dispatch_requests+0x12b/0x170 =0A=
> [  125.695175]  blk_mq_sched_dispatch_requests+0x30/0x60 =0A=
> [  125.700227]  __blk_mq_run_hw_queue+0x2b/0x60 =0A=
> [  125.704500]  process_one_work+0x1cb/0x360 =0A=
> [  125.708513]  ? process_one_work+0x360/0x360 =0A=
> [  125.712699]  worker_thread+0x30/0x370 =0A=
> [  125.716365]  ? process_one_work+0x360/0x360 =0A=
> [  125.720550]  kthread+0x116/0x130 =0A=
> [  125.723782]  ? kthread_park+0x80/0x80 =0A=
> [  125.727448]  ret_from_fork+0x1f/0x30 =0A=
The NVMe TCP does support merging for non-admin queues=0A=
(nvme_tcp_alloc_tagset()).=0A=
=0A=
Based on the what is been done for the bvecs in other places in=0A=
kernel especially when merging is enabled bio split case seems to be=0A=
missing from tcp when building bvec. What I mean is following=0A=
completely untested patch :-=0A=
=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index 619b0d8f6e38..dabb2633b28c 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -222,7 +222,9 @@ static void nvme_tcp_init_iter(struct=0A=
nvme_tcp_request *req,=0A=
         unsigned int dir)=0A=
 {=0A=
     struct request *rq =3D blk_mq_rq_from_pdu(req);=0A=
-    struct bio_vec *vec;=0A=
+    struct req_iterator rq_iter;=0A=
+    struct bio_vec *vec, *tvec;=0A=
+    struct bio_vec tmp;=0A=
     unsigned int size;=0A=
     int nr_bvec;=0A=
     size_t offset;=0A=
@@ -233,17 +235,29 @@ static void nvme_tcp_init_iter(struct=0A=
nvme_tcp_request *req,=0A=
         size =3D blk_rq_payload_bytes(rq);=0A=
         offset =3D 0;=0A=
     } else {=0A=
-        struct bio *bio =3D req->curr_bio;=0A=
-        struct bvec_iter bi;=0A=
-        struct bio_vec bv;=0A=
-=0A=
-        vec =3D __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);=0A=
-        nr_bvec =3D 0;=0A=
-        bio_for_each_bvec(bv, bio, bi) {=0A=
+        rq_for_each_bvec(tmp, rq, rq_iter)=0A=
             nr_bvec++;=0A=
+=0A=
+        if (rq->bio !=3D rq->biotail) {=0A=
+            vec =3D kmalloc_array(nr_bvec, sizeof(struct bio_vec),=0A=
+                    GFP_NOIO);=0A=
+            if (!vec)=0A=
+                return;=0A=
+=0A=
+            tvec =3D vec;=0A=
+            rq_for_each_bvec(tmp, rq, rq_iter) {=0A=
+                *vec =3D tmp;=0A=
+                vec++;=0A=
+            }=0A=
+            vec =3D tvec;=0A=
+            offset =3D 0;=0A=
+        } else {=0A=
+            struct bio *bio =3D req->curr_bio;=0A=
+=0A=
+            vec =3D __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);=0A=
+            size =3D bio->bi_iter.bi_size;=0A=
+            offset =3D bio->bi_iter.bi_bvec_done;=0A=
         }=0A=
-        size =3D bio->bi_iter.bi_size;=0A=
-        offset =3D bio->bi_iter.bi_bvec_done;=0A=
     }=0A=
 =0A=
     iov_iter_bvec(&req->iter, dir, vec, nr_bvec, size);=0A=
@@ -2271,8 +2285,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct=0A=
nvme_ns *ns,=0A=
     req->data_len =3D blk_rq_nr_phys_segments(rq) ?=0A=
                 blk_rq_payload_bytes(rq) : 0;=0A=
     req->curr_bio =3D rq->bio;=0A=
-    if (req->curr_bio)=0A=
+    if (req->curr_bio) {=0A=
+        if (rq->bio !=3D rq->biotail)=0A=
+            printk(KERN_INFO"%s %d req->bio !=3D req->biotail\n",=0A=
__func__, __LINE__);=0A=
         nvme_tcp_init_iter(req, rq_data_dir(rq));=0A=
+    }=0A=
 =0A=
     if (rq_data_dir(rq) =3D=3D WRITE &&=0A=
         req->data_len <=3D nvme_tcp_inline_data_size(queue))=0A=
-- =0A=
2.22.1=0A=
=0A=
=0A=
Feel free to ignore this as I might be *completely wrong* here since I don'=
t=0A=
have a reproducer, everything is working just fine on my machine.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
