Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C918C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 02:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F06115A
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 02:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhIJCir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 22:38:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36175 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJCiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 22:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631241456; x=1662777456;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BWtePkt9PqofwLtfWCZGDbYW9YD8b8ZbKaVXyrz3aAg=;
  b=rh7vjvPrOOMInQtUE61LrJWJgZrgThIsLkgMcdNs7YAczzTCk+gV+wOs
   +R0FBC03JzdhRXO46M/u76vmgHIrrOPaM1FP90zQuQlU8dMYH9mYVTZ65
   17W31LWAwMb+dbdwwWdLahs4ssFAe+5X2L1PXlKv8u+5La3+qEfvm9nI0
   QdVtEr83KhHDjqFD6b3MDXcYdE+7bjfIErZ6K+rkbrrrk/bgai7j8F5G9
   T8flZex7gEJ1wwS9eUUYG635EUKlPEGThnCyqgFqN5SBzu3ToIasrk39J
   P2aA4xDsL/VQLTyAywrJfebi1s+vZZRqtUUB8fFqM8MaLf0xdFDaYMV6b
   w==;
X-IronPort-AV: E=Sophos;i="5.85,282,1624291200"; 
   d="scan'208";a="283438093"
Received: from mail-dm6nam08lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2021 10:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJm6Pj0ylW4qumBod0yYvP4JZqaH+MpFb796W0DF1friqlQZfwBS8fE26325SlgdSsIPPHJFzwtWhYIg4ERpHHexSOSS+1VydCHwFReK0TAJaeFYQLSVKwTj+HkP5ArRRMQafjM1E97AZS5aFYijBAs63g1+1Lv87avNy/N+ag9ToD2fPFRHIe0HYmYjsvuEkhJfTEchW4AT6MuvfqCLfasV6yyniD7naiN15gg4DDBwPX0sQQsklxG8n0luWx8Ish6vOBvBUXedo9rHJRiUFmNay5VIRpM8xSOTjeOcp+iVMVCObTOAQw4vPtt9/l9lddYFmttdqngKNrmlu/TTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a932QBPzLDfxarVXbsNqNaEU7H/Ny5RsOuK78mSbhUY=;
 b=WKrb47leA9cEri7Y+QJ3+SgAkFjIRWDSQOhQ4Ymh9RnErAGhQZ0DAaRh9MR4S3IVKGj5zk/5944RySanJaJ3QTdTOZ4HjxfrG+I43sDHjB0ITsIlyRh2ugE4w/NY3wTcgNwJIZGyLArzlmMR5Dq6mnBAC0buyr+P3pPRcojpNbz6T+k+x6u9BJ0qnzSHrrIqDS6fupNMf89qqxayzp78/J9yYXIzEUJkmml63gO3sNHyVdxsjVwKWPrsY9OWi6g+59nM3x/wIe8KodOj/Jcqfyy2ccTs9sPVQHWgcB+gsJtqsfTkoEYGJhTxof+rrW2JWOFVcyeBshfFPB5R+Mk3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a932QBPzLDfxarVXbsNqNaEU7H/Ny5RsOuK78mSbhUY=;
 b=oONdsTbHnm1vOQLV2hkVhfNLt1Gt4vD6EF3F7Dva4KA7ZH/C5xyUBatzLrRDFaNwqRxULadaWdSMQ5Pr3kqthjILa1Aq4Q9zJwwKhRx6C5jLSjEvDXL73+/Denff3ndMoDdzu4AVEaLVsD964ksr/ZqH2kNkMVYWT/tikpsGi9I=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5372.namprd04.prod.outlook.com (2603:10b6:5:10f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Fri, 10 Sep
 2021 02:37:34 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 02:37:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Xu Wang <vulab@iscas.ac.cn>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: Remove needless request_queue NULL pointer
 check
Thread-Topic: [PATCH] xen-blkback: Remove needless request_queue NULL pointer
 check
Thread-Index: AQHXpewIpomVCHmkEEmflQIfj6rk6w==
Date:   Fri, 10 Sep 2021 02:37:33 +0000
Message-ID: <DM6PR04MB7081D2E353283692759CECFAE7D69@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210910022457.22963-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8351f02-c6b5-45d8-ab4b-08d97403f1cc
x-ms-traffictypediagnostic: DM6PR04MB5372:
x-microsoft-antispam-prvs: <DM6PR04MB5372D497BE8495BDA0973CD9E7D69@DM6PR04MB5372.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Olnaf6l0wJxiCrkZd1P+rmP1Sk6v+hljmxOhTi+2//rk23Eowa5mj+V4lazZFjizZSW9udnjzyHiJMHMHt5QBv21IKvSc6iORRK57a7XUVSOl+XveJJoAub+tOsVCjy2wZ+1DMAbGxq1BwzBQaWrmi2o+dZR7eFmyKyUN7mmDP6cJRQu8pnMQfu3+MmedpRaK+B0JDDoyt7b0Hih1ZriSmo5/T0U8BqE/BOyUpV0vvKV28b58YAnZ+5MtduiI/3mJFdCVmprxSVf2Y93d7j9BDECDoK7jYMJHOQfddDglqgg/TEwjH9xHh/UxcplWAajJL2y2BQlJuZaTtk33v1BeGjn0zTAoE167qmIP8kJNsT8pjnJBbrvcEUSCtYnt96IWsH4JcgaQKbmFRhdW4MkHLMCqI4VN3TyKSY76UX45mRkNEwcZ6Xu6oS1tBvT3G+YjVFGMIw5oGfJVEz9u1/4QVIL2Y1AINAaZ06M7tdHVwK0DqukCFsyg6n/d62GTbBfRgourvkrOvWK9nhGI/02DVK92uPzXXDGdbhL+eM0NwwzjAPouKzvV7JqjgixlcK8nBhOw0k0+vp7onsW8aQ7i0YofqpqNKeDvrKyjWKNHQmtMBzrIJcuRjeijtTzHUKmUJJC4eTGAFHCZCo34dLaDtAoliafYAK9/g/ThStarkmnF7hQwrc707YWY5V1yMnQWz+9/EFQpZfRL++4nIsadw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(5660300002)(55016002)(38100700002)(186003)(54906003)(110136005)(86362001)(52536014)(66476007)(8676002)(4744005)(38070700005)(9686003)(83380400001)(7696005)(478600001)(33656002)(71200400001)(6506007)(4326008)(316002)(64756008)(66446008)(66556008)(66946007)(53546011)(8936002)(91956017)(76116006)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xeAtoRMah3qLQB1367F3KDHQBBt2S9K6sQw0QoizCTVB3o35LiTp+JsbbEHQ?=
 =?us-ascii?Q?M3ks9w170AbvbfqfPNlvBxvR80v2Cy1UpHbOMRiYQ1CsLO1X7zuGsGX+cdtF?=
 =?us-ascii?Q?hsv3OQ9MP3wHCm6lXpnDCo37nCChqanA+WrWG4lbcfQkOWLnPwdeznB1eb5A?=
 =?us-ascii?Q?pqx9QlJ7CpZAt20oREfJXU/DfF6UI0BtpJYq9+pcAHfXCuTnwLKG3Zt8tmBz?=
 =?us-ascii?Q?39V8kurg21WL+KjdiYjx4sFxiR+fVIqqwr2MwD3VYlsxrLFx8eLz3gwFo8eq?=
 =?us-ascii?Q?oA8jz3H+tWMHSX/kzZC9q+n4WzhU7i+VTRagZBQUjAJkAJfAU5p6KL3fuhpp?=
 =?us-ascii?Q?f1k7M3aQffd04gZek8Kz9Gy8VZTtzXqGOUSWhcdexTeAlzLEDtOzqQHcD4zF?=
 =?us-ascii?Q?WhUA0ytC9RJooOKXHCvvyinf7vmZtGrVw/B/GBUh4Dk8ai4/N/KFqWLyoqPq?=
 =?us-ascii?Q?9LxXojKujNcJ0VtFCCJDYfg8y5QqBXLEe3PvCp0WzIta8Wa4U95heR+Kq+IO?=
 =?us-ascii?Q?vKZPXZFJImvYlJ7dSfdkjWjpHb9VGOLMFkQya2ejeB6sI0hHb5jZis5+NCy/?=
 =?us-ascii?Q?GX7jnBXmfvaNRRsH004koDrTV12M1uZmPYbcwSnN8/OcO+M7xFzGgCzdbNGv?=
 =?us-ascii?Q?9JEMqtqwoxWdENx0UCTYLfzE63v40iMpVcVKMR+eJc57VhK7fNPIOADnuPAR?=
 =?us-ascii?Q?gVhw6DuoUip3W25VXiCGOmBC5YyrjHA7nxmFC3zKF7z6cOZhSLipwYgy249T?=
 =?us-ascii?Q?D1x462NWmBXXp/nlMeIQ5J6BZ8CY7lJaHeYTUdu34rykeJqk5C9w1bWEG7uu?=
 =?us-ascii?Q?swHUjFvHo3HSYJMt6Gb9Dez7hiP8xAssBL6gOUVQhH43zWGZRWH93C/EJ2H/?=
 =?us-ascii?Q?E9/FnjcqMMDwEdTlRc1UevpW91YtdjrNcoeJQYfiG3WYkvpcneC2qWTC1KM8?=
 =?us-ascii?Q?A6GaJ4ohX0JldHtrOZAiZTrFYO5+kURkDtZX612NroHzMHVcVCc35msY7ARR?=
 =?us-ascii?Q?S9sqIbwkRdG8lj5emk3URedlrM3sVYYN2zSCs+su3Uxtp7g3nXl2IfTv0r9B?=
 =?us-ascii?Q?9HUB+FVa+0JO4yp6FG+2HB5Zx6xCkTg6C2n3fpYr+xqLygd92smV07Vj7qSZ?=
 =?us-ascii?Q?mQnGPvXWTrQqcnrF/KZPmZfUPLHFZnouF51k50TmYg2NgaRapKN7Ez+XGUfd?=
 =?us-ascii?Q?50rxGhsqxM6MHoHqmbmk+KFdCfIJ4o/aDbWAloKmY695BNQrW7r6muGOuUf8?=
 =?us-ascii?Q?mA2ztVaOB+eaYE8UpQUCJ01rf/LMlxfuPOeB3zxZLig2h81dYDMd5atatD4o?=
 =?us-ascii?Q?5BzBZnxRUuYWwSOEcKKgmE6DRxEI9oV6ShW1d33L20Fd5B/HCMZQvpqq8Uci?=
 =?us-ascii?Q?XXkLw604nlot2VHzgDgVUeDzpHMqOj/sM316VLgmRGONjCB8QQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8351f02-c6b5-45d8-ab4b-08d97403f1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 02:37:33.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pF7HjWnuwerALbxpOaiWw1qasGv50ELlt80EJfm8h3Fl+v5N4qCTSMDd66gD3Q5ZD5PVp/d5qAipYiCVMD+tPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5372
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/10 11:32, Xu Wang wrote:=0A=
> The request_queue pointer returned from bdev_get_queue() shall=0A=
> never be NULL, so the null check is unnecessary, just remove it.=0A=
> =0A=
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>=0A=
> ---=0A=
>  drivers/block/xen-blkback/xenbus.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkba=
ck/xenbus.c=0A=
> index 33eba3df4dd9..f05132b9ddbf 100644=0A=
> --- a/drivers/block/xen-blkback/xenbus.c=0A=
> +++ b/drivers/block/xen-blkback/xenbus.c=0A=
> @@ -516,7 +516,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, bl=
kif_vdev_t handle,=0A=
>  		vbd->type |=3D VDISK_REMOVABLE;=0A=
>  =0A=
>  	q =3D bdev_get_queue(bdev);=0A=
> -	if (q && test_bit(QUEUE_FLAG_WC, &q->queue_flags))=0A=
> +	if test_bit(QUEUE_FLAG_WC, &q->queue_flags)=0A=
=0A=
Missing parenthesis. Did you even compile this ?=0A=
=0A=
=0A=
>  		vbd->flush_support =3D true;=0A=
>  =0A=
>  	if (q && blk_queue_secure_erase(q))=0A=
=0A=
And why not change this one too ?=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
