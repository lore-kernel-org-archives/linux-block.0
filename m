Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2379C433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 05:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A6364E8B
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 05:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGF7K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Feb 2021 00:59:10 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7447 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGF7K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Feb 2021 00:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612677549; x=1644213549;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9DdhWcFrRqN4EZS3rSv6l5jOVJxF1n+F0b3SHvz4ihs=;
  b=DLc3dlmnc11sGLKLv7IbyBga0c0loNHL5dXQ47D05s76PuG6sBV7ioXu
   RfFO+jYe8NNu8nB0xt15zQ62X7GR/QS3eu/JopCq6YIQvfVwvLeZDHWG2
   revfHH19FiKSNIrGkBqcrP2xS6m1ccgIRD5NT0wic1b39+1WxEg2xnaWe
   4SfpEEJbJAXSHdmDh/wx34p2whnOG9mqEy8t2dUi83KUfZemJUTFne4fu
   hg/G299XuZ2zZ15SXXnYROj8sddwkeHx1K6OLItMIXyQYnPeZ9HBohEAu
   bGipfga0KmoWaONR+5BhOQ5tjOBMmu8Na+AdckT7IiWY+CaS7eW5kwW3M
   Q==;
IronPort-SDR: /j/RHtkvskd1LxJmX0fSvCqJCYQXpt1qcIgbLL0O9Xs0ONpdIqD0d+upqrP/3O2y4u3DeLgqPB
 j8+rZj+8JPqgjY/mSIFW4uvRJS02lu6WZIhG5slr7Da5oYm8z8lZdXhEEpYPWUkOGOXDuO76Mj
 gg6ZvpjbUp/UZn6uOeNeg0XGep7opIGGk0aZQFedQyj6G0CDPoyKhpyP3hsGeneZDyVRZD+pzX
 xMA2RP22EVVh4By+4XFpAb0mKsYSFzQvu/ViAQ34yCRd3CU7EYNPBdlDhuDMhBDYIZvoyiVlO+
 Dso=
X-IronPort-AV: E=Sophos;i="5.81,159,1610380800"; 
   d="scan'208";a="159377874"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2021 13:58:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4cPHNC6BUUhNgNFCc9brpG677oKmGpia2a4ly/AdVoZOFpJmeY7AyUHii5cxCgze7Hj8JR0x0iefa5unweoCmk7F7/aofCk+lF/34vwN8TYkkFBmNCnbNzA9mOs/46RgwC/q6yJFt0005G/9LSHtNq+/ROm/uy0uszFFi5AT+TlKbVE9lFd2s34KAmK3X1VNm6K+tnV5OSpuZ/TvN5IziAyDLV+1JviEWOGs+fq3W14pixuKgxh98rIeEIcn5+2NpqD+C12cJKYDGCvpGcIhYDh9dOU6xwPTnodzaFBLUzeg81QGedRpzEplchZhk0Anlp0ymT848nAXswNNDMWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnMSlhtlOVBjIRxQi0hDHbqZCZKRVreljCFJamKssWI=;
 b=JSLiJ5sBb1gF0AnwrYInJZVMmLQfWiARDZc6LTML1ESsvOvbNYE3fTOhDs784nxe61B1ygVe7Ox8WRdgst/0Pj8bnfcgERQTnZ/cQJQhRjR8K711bMbgQ6s89WvpfBdIUiyrTn3GFEWJdVbgFLjOnBAx1v0GWgYtrCOTHmsSKR1nAy2T1aUUzrLsHK7wYIapaSvpgrKDN/lpkMp8TaQVEjkXFrrHt8AHrjOtItrx0hJDK7yq0poP7ebw5Mx8zPjvbwirHDRemW+N2O6NfJTbuxx6usO+SLcLDBuqW34LFv2ZZEgfYm2s1MtJCUzGgYDKT25UCr4ly7QkReZA/zsD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnMSlhtlOVBjIRxQi0hDHbqZCZKRVreljCFJamKssWI=;
 b=hMxWaXNwFDt7KkUV7TruzSJ539Qn1Owu2pktb2d48LQw6GsPwNvUGrNorxxvGq6RiOrt7Ex7hUkZWa11o5sVyhJRsqiQDBl4kzPXOisqyWNsSLacluBxDiNsG81M58pvt7Td4Vdadc0C9Hc+Uf7bD/c5Dc2bADtx1i3RjpOd+z8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 05:58:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 05:58:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
Thread-Topic: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with
 blktests nvme-tcp/012
Thread-Index: AQHW/Qz4wyJ1jVpJcE2ugUQsAFy3zQ==
Date:   Sun, 7 Feb 2021 05:58:00 +0000
Message-ID: <BYAPR04MB4965F26763967C4EC93A73A286B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 329bd7f7-f8c4-4f8d-fe86-08d8cb2d533b
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-microsoft-antispam-prvs: <BY5PR04MB675399B900007F1F9C7F964786B09@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCCBBZUh2SL/w7NLxQuez5+NqYgXOj1cEgKkYKJmLrHZ/ghzoa4QRdb5p6VTjXkUdXLjeiHI/sDE+pbdlbMHSUHUh3aP7q0gfDLmhEWzj0seM4iB9Bnfb1Gm73TRIbFTe3liTs66AIofFFrHs4+9g8qjLYwFcMg+eOrFbUl75OX+ZlHQBDLjs/b10y+im07/tTp8KNkRECdwfpErOamgmll2wl3Wt/JpNvwPV0JV9RuqCxi4K129vRMULZqPf0oGPUPhlCpajhhs6MrazNjH7EmoPEnwwaTl3SDs4KPV02FX621VQF7zhZyrRWXoWd7MScFfuI+4WNlilOfz51BHcwbOPYB4lvbQdQtMDfSwfUSCEZhego2RjYOehvgy59u7P0FAbGLUUoZUJzOXs2vyzQhR1sB9d8invgFMBeBDEf41cDwDyReFeuya/nbulGT/95L4sExq6Ov6cYbOm7jEuDu+ih3UFWyXcIG9fPb5YLT6lJfc2s1UOGIRRL5+f6SIgJwDAa1Wg+m8hiqFuOJvLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(26005)(186003)(316002)(55016002)(71200400001)(66446008)(478600001)(4326008)(53546011)(6506007)(86362001)(52536014)(33656002)(66946007)(76116006)(66556008)(66476007)(64756008)(110136005)(8676002)(7696005)(8936002)(5660300002)(54906003)(9686003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?77vGhAIp81ZjKXTS08V+8DB9UMjgdDklFfYn/FXCUexeQiTATf0cyV10PZu8?=
 =?us-ascii?Q?49ZN7/SxwLgNJw5jX3WqdQvUv4F2C9XtXatn7nRM4ccKqc2/NdNqWdlgIfjH?=
 =?us-ascii?Q?l2IaUJLeOUJAE8uCLrwo4Itv8QoAwz/y06hdnPDRvSiZt1JK+yDcs9dwr17P?=
 =?us-ascii?Q?mAo6pu0/a37Z/NhK7f8yFRlfiV/ESpXpMWcxA3cwaKtYA9tT9in1uSXNgEls?=
 =?us-ascii?Q?r+vwU0i9P/Zs2lr8vnGxCaeTHV8R+ckirnRULVpZIXkAMJTULFLL5/7J1exy?=
 =?us-ascii?Q?XRovr4MsrwCKIAbtCfYPJ2I1gyGqo6r4P1ZpOHV3V1zX9sPg8EZ+cd5lPQ21?=
 =?us-ascii?Q?TWRgbdgfYeNhMI4675NV69ZhBIoHBYID/Pe6cjClkT+LbvwLM5laTv8oBtJ1?=
 =?us-ascii?Q?en/uzAY3RKDtXPo/Ibdoc3HDuT16nmmAtPmQ4Ls/zDWECEgl4XvmNMLTASRu?=
 =?us-ascii?Q?TB/Ix9v7hN0UpdyRu5xZjBmi0yoluZGChlu6+xJnUqbFQ3mQGCOawrOeucRo?=
 =?us-ascii?Q?Xx9aDiEQK8hCKng1rRauQ0JZcXf9m1uYwdg6MeXXY8g4Ea643/jR0C6PwH2W?=
 =?us-ascii?Q?7F8D6u2SZ2a6H8TlIuxb4IpKuWyVBx0cXoShNEVywjuY1wTPmTJhTUzMi+wN?=
 =?us-ascii?Q?imvVlgC4DAOmOogeYf8QPVxgCoBLFaizpJG+dSxegu3GxHQt1DQRrZmVDUqP?=
 =?us-ascii?Q?vqe3abz14hxkErnhzu8LYRyOHPzvAPgfaM1wO57FJYE2qD3HL+2Va2+qew4R?=
 =?us-ascii?Q?rWbTAyEC3K65ZUo2CxxMLzftepEhoaXb8n+yuGC18AiTbobMXemE0w0l6vgF?=
 =?us-ascii?Q?f6nCrUrl2DNr2FC51zYluzQDTv1ejdYIKVmLH9srGLFwkut+uzDjtxMdj5oz?=
 =?us-ascii?Q?wm97WJjewK9Dr4BbWRRSNeV38crQHIr5QOGywr0En04oAALJKqCyG89+42i3?=
 =?us-ascii?Q?d5+YRw2aOL+kUT5NNoGhJnPkFmZajhxcaqE/8bcyNzc3pRAjy4HMkHnKOJci?=
 =?us-ascii?Q?Tol8T2XQJaG4OocJGbyBNnU9O/bfMvZX96rgpFNzgZU+imNh2cslouv1Sc7F?=
 =?us-ascii?Q?ckMh0HHO/De5yW3k+NFHVzHClaNcA9raK7OnkdBvWnZe3y2SV6oyHP5mhteO?=
 =?us-ascii?Q?ZNG18ORO1Oc7tWGOcIN7h34JfrfM129XZaBLU7S0mTc2HIAGnnQqY9YK83ye?=
 =?us-ascii?Q?t3UmiHOaDTsQ/UOiz4hWWqPJrOYdsZOPJR43ie5lRfk32kzfyFP4wVVXr64J?=
 =?us-ascii?Q?Z3L7derfLU6HEFO83Y+8d4mVhs+NKCUJq+Ge/zos8FbBZjRz0TawEkjAmwsr?=
 =?us-ascii?Q?N3I6aSCtJH65JeTUhHqhEtKi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329bd7f7-f8c4-4f8d-fe86-08d8cb2d533b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 05:58:00.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS8qnDE6iF0XifLKX8pGqFgFzVQidzeZwOuyFSHcI+X0AgiwA7E05RhKf9vqwee1Tji+SS7gInb/DOlCx/nIkCMnej8t6GLCDLByzhAi62o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/21 20:51, Yi Zhang wrote:=0A=
> The issue was introduced after merge the NVMe updates=0A=
>=0A=
> commit 0fd6456fd1f4c8f3ec5a2df6ed7f34458a180409 (HEAD)=0A=
> Merge: 44d10e4b2f2c 0d7389718c32=0A=
> Author: Jens Axboe <axboe@kernel.dk>=0A=
> Date:   Tue Feb 2 07:12:06 2021 -0700=0A=
>=0A=
>      Merge branch 'for-5.12/drivers' into for-next=0A=
>=0A=
>      * for-5.12/drivers: (22 commits)=0A=
>        nvme-tcp: use cancel tagset helper for tear down=0A=
>        nvme-rdma: use cancel tagset helper for tear down=0A=
>        nvme-tcp: add clean action for failed reconnection=0A=
>        nvme-rdma: add clean action for failed reconnection=0A=
>        nvme-core: add cancel tagset helpers=0A=
>        nvme-core: get rid of the extra space=0A=
>        nvme: add tracing of zns commands=0A=
>        nvme: parse format nvm command details when tracing=0A=
>        nvme: update enumerations for status codes=0A=
>        nvmet: add lba to sect conversion helpers=0A=
>        nvmet: remove extra variable in identify ns=0A=
>        nvmet: remove extra variable in id-desclist=0A=
>        nvmet: remove extra variable in smart log nsid=0A=
>        nvme: refactor ns->ctrl by request=0A=
>        nvme-tcp: pass multipage bvec to request iov_iter=0A=
>        nvme-tcp: get rid of unused helper function=0A=
>        nvme-tcp: fix wrong setting of request iov_iter=0A=
>        nvme: support command retry delay for admin command=0A=
>        nvme: constify static attribute_group structs=0A=
>        nvmet-fc: use RCU proctection for assoc_list=0A=
>=0A=
>=0A=
> On 2/6/21 11:08 AM, Yi Zhang wrote:=0A=
>> blktests nvme-tcp/012=0A=
Can you try following patch and see in your Oops if you get that message=0A=
so that=0A=
we can at-least eliminate one case ?=0A=
=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index 619b0d8f6e38..13d44d155478 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -2271,8 +2271,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct=0A=
nvme_ns *ns,=0A=
        req->data_len =3D blk_rq_nr_phys_segments(rq) ?=0A=
                                blk_rq_payload_bytes(rq) : 0;=0A=
        req->curr_bio =3D rq->bio;=0A=
-       if (req->curr_bio)=0A=
+       if (req->curr_bio) {=0A=
+               if (rq->bio !=3D rq->biotail)=0A=
+                       printk(KERN_INFO"%s %d req->bio !=3D=0A=
req->biotail\n", __func__, __LINE__);=0A=
                nvme_tcp_init_iter(req, rq_data_dir(rq));=0A=
+       }=0A=
 =0A=
        if (rq_data_dir(rq) =3D=3D WRITE &&=0A=
            req->data_len <=3D nvme_tcp_inline_data_size(queue))=0A=
=0A=
