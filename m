Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB305C433E9
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD1964E38
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCACtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 21:49:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50055 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhCACtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 21:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614566949; x=1646102949;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O6SKEL889u1yViTaUdJ0cwuBnLE7fNHO6g+GrvJXrA0=;
  b=M/KYazT0DJtgXq2Sx7v7GvEslsqYGMrdToU4vmMYncCbnnaahl065MjJ
   AvIJbiXysvtGdp/GHrOSUJRfufK9IeoaRTd5FhONOGoj1bwh7sYRtkKVs
   pvbGUqMHcwLASJlFAU4OrgqA6/gqbI8T3LTKc5M3iCwP07q99p0SmbPCI
   2HcRE60b4IxD/LSiRnHAcMtBczHiDeDbPV1T5E8hEPtxpGxBbABvbg1Aw
   tC/L13ctSrEt0Ldtsiom1FOPP8CnlY5PJ47TmzTzcFd9qEA9IKrOEzGqs
   pv4WeinFfvVVdS0B01F2geCz5WResy1A0tKAzZ7GSy/1yTEkGCxPogQwd
   w==;
IronPort-SDR: ac/iVjKSI0cvN6t11RVhCB33rmbQXB+43eIBQOpJ+5X0UrtcwJeQmTXgnZXywBkDbSzVpzSnkw
 3E99OU39LgQh19gWYQqsQkjJ5uxC1sWihhMlxMTAlsumd2g+8yCAEmEh/jbXavJa3dcb/oeOsO
 HCAxMMK9rUM3FluVvLRpRgufHUs2HwOJNCVetcEwZk98rk2Oz3S2IojjKBz6PSgEwSh4fXjDMd
 wkIaalef5oGjK3/PP0V/7K/Jb9qkan2GgAhAGeHObUcdfMSJ0lac95Rc14rp8zVA+PUlGYCIYm
 iPg=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="271617907"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:48:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnf7fHpwS4PzG/5H36jui9e3cOBwg4A90ofPlkIdWdmLl9dKk5U1XUDkfRxCjhp+Cl3RuiLtdGLkAlo+Qj02sJHlGeUJteGEqjFN5R5F8qtU07Jr1hytiGgm8QhueWl3KkhvTF3FsMHH5NI2ixg1Ejlv9RO38y1w5SV2gC9bzolfjaGJj+IVibATRaa84Ph0DchG2KmBcpULsGvlfY7DPE6mlYy3vBlESaiuzupz3pEXqXVFbuD1mEs8QW/CYRKiFehRLrpbaROydeJCKIicWD1vMWnQ5dlYYbIn5lNQYXQv+HCJnCw6KRaGP3sn7TVcrF+zCd2jfwzWVcNb8CEBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bC8/8dIi5Ac4fZdfpsshIaIF3BwbtczZVtakxnDui4=;
 b=gOgXaJi8yHImCM8hSJaCaJNjuAhIo12LiD/bDuFez++Etx5M+UWNYREhLKtJ9RkH+XNMLAQsonDPKJ6rVlBcw8gTwo0OAqbCd4OBmaBhLMD1SYMB0drDQLsdon8R7Cl8iCyhqB/nCIAMpfWdH6BUfpsFFk3H4X/0HTWFdJ6+G6NtD9zRQh70xUploiuptWIsccuCrYGZOVvTkmM3ynBvmo/5NnqB5Qjyfj/J9v5LUxdsJjYUEydGymyKeJUuZxbjmNrO5pSMpf4nNbCBeUhRXGkCX4ouA4/0KcM4eLMd1kMxpKxNcE+fCjU1I99ppzcjD0CMMxApwsINx3s4PHN2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bC8/8dIi5Ac4fZdfpsshIaIF3BwbtczZVtakxnDui4=;
 b=N/dZxBEZsca5qkG28HqX4+P4JNHdNWR9yQ90WqCEaHZWhdGioS+a65yOj/Rvld40kadrVeq7pTYeXHsOjldJM1Kh15beTrrp3efwgFXDG2g5brrT26OxhAcB6NwQtEirkE6Qr2Fs+fl9umQoDoc9ujfPeqnZNyGTexLD2hDo4WY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4770.namprd04.prod.outlook.com (2603:10b6:208:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 02:48:01 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 02:48:01 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Yufen Yu <yuyufen@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [RFC PATCH 2/2] blk-mq: blk_mq_tag_to_rq() always return null for
 sched_tags
Thread-Topic: [RFC PATCH 2/2] blk-mq: blk_mq_tag_to_rq() always return null
 for sched_tags
Thread-Index: AQHXDkBm0FjhbnBgI02FWGnWqx2hCg==
Date:   Mon, 1 Mar 2021 02:48:01 +0000
Message-ID: <BL0PR04MB65142F0F11976A47F33FAFC2E79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210301021444.4134047-1-yuyufen@huawei.com>
 <20210301021444.4134047-3-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:347a:bb00:3286:307b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40638d72-b78d-4d7a-aa36-08d8dc5c6e36
x-ms-traffictypediagnostic: BL0PR04MB4770:
x-microsoft-antispam-prvs: <BL0PR04MB4770023DC861C5665BC98BD9E79A9@BL0PR04MB4770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7Bp7KKSR0AP05ce1D/KURhdK0C0uEiywx21w0lZBmXVSebAAwKoVdAozZokEgtm30lNsNqAYhzRkE/qfLx41rsXot1QAOhdHJ949ixz0Km5/ngUHN43dQRm12vOcT8fZlTi22G9blmBV31R9IG4svNiZqvbT76cAiWdyOLAj+Rdwjwxn+sO6cly4NRq6Zl2xP3HJV3HAKhIrVwGHuHKFNRWkiZmx7UOuM/iTdHpsQeVn1BjsZYZw8AVWPX8HyRcPs6wEODInpiAOYbXH/MLYvlRqt4FU8A0hHW/bTfUjhiuZX/QfS0hMzHjkz7WIsvs06hnWucU9G/IpOfYwsh4WWlg1GIfr1qnTxrLIBAA4npRyQBhQQ4zNxcT8d2gYFfKQS84u/+hR9Yb2phECPiwbR4xQH2raprSmK1EZQd0f3yvhvzRBbtptTcOzPBgC4yUpmrputcMV/41NlYAdOaKK1sOpFdBhWCz8/pKNHsOJd3GUxyPoUsU7C7KnRgNFhCI262EXB8Eq9tqJZDMJUcTBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(8676002)(186003)(5660300002)(6506007)(7696005)(71200400001)(55016002)(8936002)(52536014)(9686003)(86362001)(53546011)(33656002)(316002)(54906003)(110136005)(83380400001)(4326008)(478600001)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sUz8GibOrRR3Y/GwpFCdjw8ia3/F4gzOIYjFmhD62Lp7dTSigbCTMXvkU5mj?=
 =?us-ascii?Q?qs53QWTr6SfMPW95xyktDRnxiJ7hIeLkkswbt/G+Vq+W7AGgTJt+lOAdtvO4?=
 =?us-ascii?Q?bdc9qFAekLFAnl/K4LnaYezLzoK2MOhyQvqMv2PDXnNE/7aNZFxwI5ttdqjs?=
 =?us-ascii?Q?9uD/2pcP8E6/HeSxXlWFBNbjz4XoUVBmyvOQK5C+YSuIIptyof08tFaxTnKX?=
 =?us-ascii?Q?iAme2GnhmwyuRMvnU0TTSyqdUe2hp8qUw+K8+bj/5y8BJQG86/ANr2Exvbws?=
 =?us-ascii?Q?3Ohc94LSpd+STrwqM0UHvtb1I7cRDvztUyC2z0mAQxqVuPVYzVVIhmxMwxbr?=
 =?us-ascii?Q?aNo9Bwd6PzyQF6Db9lHa312XLkEsFlJdCd6eT4beiHFy5c6jB2IYy5dmI1yV?=
 =?us-ascii?Q?F7B32/dIbudRchPBYXL7+e+eeWUyPmWjlGDSq8JZroFOZqsN4DDJGwYOqAk5?=
 =?us-ascii?Q?xqGtBk4m6GNRzE0ppbZX3888KuEd/iE71DUs+m82fIxJGNTxihv03UTU8DA1?=
 =?us-ascii?Q?j9bgxer9FlEltkOY7jT6t2IoP1R7henS8bma0yaZuzsjmHaHbK7loEhXc+TV?=
 =?us-ascii?Q?TkKyNlYv0JRdl6ZSK2vQi0kReVe3UTfC1ggGtTA1H357JvvHnMlwMRMjpH1A?=
 =?us-ascii?Q?BT59NVFriaxQdXwWgq2VdUGOD59VwgYInejj3ur7z7ylmi54cXsF4as/BVnm?=
 =?us-ascii?Q?2Du4Xw10VyC/QbXU4NNIKrGcqUGfQ+jbFzpJC+ZMGjhGSD6U3aACCyxB9Tmc?=
 =?us-ascii?Q?xB58EXY57scQbEv2l3GOnknVprjbByNDokMe+0lMwm+6/pG9EPS7SkfP5Ktc?=
 =?us-ascii?Q?l2vNWo2a/hqMSzrIHHUE/1llmTb+GVd7jZMncWMyHAacsDZ8X6ZfQ+LSGvaR?=
 =?us-ascii?Q?kcU4cxJyxROjEJ+djP8o5SAs/LMAmBsgn4YTHwx0AdxREVw84Hr2qC65BlDd?=
 =?us-ascii?Q?FEWmUMObA8CLgmZJPUanCBQfP9n12nPj7yRYnmdFoYVecO3t3sv6KJIAehJP?=
 =?us-ascii?Q?JRMrg8ncDBTbRSic3YCMOi7OuWUGPgq8pw9ye9vMabMxsp1aPZFJ2ZYUFJob?=
 =?us-ascii?Q?3GBvZEf4Z9QtASwZWTztFW3pJmO/TuCdzJlMS3Q0CZL8vy2Wjy/r2Q3DcXyL?=
 =?us-ascii?Q?pdp+yYq+LBz9JlACPXwnU1ffuNl4ndzSKFkHk6Q46buBdK1U6j3VvZaF2Uh6?=
 =?us-ascii?Q?xYreP2IUiW3RY7Uy4aephVK3ikmcbLE2XrFeZBcZH/6/tnepyzM2WLo4vTEe?=
 =?us-ascii?Q?YaRo0BtUd8f3/2w1m591nOV817/MhoTn1uNISlvCHHqeyJ2x8aSIu0YyXjUn?=
 =?us-ascii?Q?D5Hozqv7AfGLRbW/ra4ZNW3ly5MX/COaE5bmxZXHNprpEmCelGYh1oQcb/Bs?=
 =?us-ascii?Q?vlnn2ZGZ7SGttMx7SyfcnQ4EsPu3RT1qGEeMcTNYgRuJdPHfaQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40638d72-b78d-4d7a-aa36-08d8dc5c6e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 02:48:01.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4R+RzHeY7cHA0bSwzW5nD8xcp78Kr1pM3KTNQWwLeSbZ1ihMLTLAcmRCbwAULJ0UUxQpbP9Kj8TV0960SuR2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4770
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/03/01 11:12, Yufen Yu wrote:=0A=
> We just set hctx->tags->rqs[tag] when get driver tag, but will=0A=
> not set hctx->sched_tags->rqs[tag] when get sched tag.=0A=
> So, blk_mq_tag_to_rq() always return NULL for sched_tags.=0A=
> =0A=
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>=0A=
> ---=0A=
>  block/blk-mq.c | 14 +++-----------=0A=
>  1 file changed, 3 insertions(+), 11 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 5362a7958b74..424afe112b58 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -846,6 +846,7 @@ static int blk_mq_test_tag_bit(struct blk_mq_tags *ta=
gs, unsigned int tag)=0A=
>  =0A=
>  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int =
tag)=0A=
>  {=0A=
> +	/* if tags is hctx->sched_tags, it always return NULL */=0A=
>  	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {=0A=
>  		prefetch(tags->rqs[tag]);=0A=
>  		return tags->rqs[tag];=0A=
> @@ -3845,17 +3846,8 @@ static bool blk_mq_poll_hybrid(struct request_queu=
e *q,=0A=
>  =0A=
>  	if (!blk_qc_t_is_internal(cookie))=0A=
>  		rq =3D blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));=0A=
> -	else {=0A=
> -		rq =3D blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));=0A=
> -		/*=0A=
> -		 * With scheduling, if the request has completed, we'll=0A=
> -		 * get a NULL return here, as we clear the sched tag when=0A=
> -		 * that happens. The request still remains valid, like always,=0A=
> -		 * so we should be safe with just the NULL check.=0A=
> -		 */=0A=
> -		if (!rq)=0A=
> -			return false;=0A=
> -	}=0A=
> +	else=0A=
> +		return false;=0A=
=0A=
Reverse the if condition to avoid the "else". That will nicely cleanup the =
code.=0A=
=0A=
>  =0A=
>  	return blk_mq_poll_hybrid_sleep(q, rq);=0A=
>  }=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
