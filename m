Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59B4C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7157611C9
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFIEYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:24:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29060 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhFIEYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 00:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623212569; x=1654748569;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=58D7pJVsoKvqI8YDzbAjdTHOprd5/eVX/s7s4YAZKPo=;
  b=V1JBNxscN6XIm5FwkNrDF4hP3MpgkDy/xCCuApFa4XWH+kL0NmFVUybe
   1TYG+cp28ceA5KaWaR5ORygqYaVF22jTh97aE/vb8YubZnxqXnv/ZeKme
   SupQOW6gSZaxtZcG8VxlHc8eAs2mlNANi0gnwv4RiTCvCFPd1V8jrFxT6
   kbZAQdPucs5JFrPvW7+5k8yKwgA/NamuBXVPC/UTjiMWYrmySEP8F/xib
   UqhmaYRm5Ibe9PaGJ1kilJ6sOn9v7DX0pPEGD0RRxO+/nCFMmy/QWf40Y
   s4mppylyrTi5G+W3TFTUe0S7NnN1Mk7ClE4WW20cMlKMnSGnSBFlwhxGu
   w==;
IronPort-SDR: 55DUgLNk4lWyhtjwIoBmxtKXlGHE8kA6zaqOTS4DFDR+WLChEPCohsi0nElR1Wo8Hf2BnHo97p
 P/RoqmteImZfpSQoyKp1ts6eboEjtRj1EhNXDYwpIya3uXsQ0LKmT3+kVT7R3ctOgeEf6932/k
 orQelVvUrvcDjIxnWnbTNmVnfltqCoHtpURTfyk/7lO54wbIfJiZ9wcKnt9lf2REkyk8h8Tiup
 YTiWoTL+ORxnlWXa7QW/Ya8ksl91R8B6mcSMxufgtuevp1AZO9GSnH4hy7gSiUliBU9wreVVCs
 1Vo=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="170529142"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 12:22:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0VU3FxNZg02zgRnIBq0vC6oaiIp4QzR7seYKeaKh46WRUROXf0RD2dK1cMkWT0ZAsmBqt36NxjdUI7/B/Fh8w/Kma0fdvxbgrvXegOIGIjtXYgw7L2JOZcrx2j2CRyipt+uUiIoNTEglvZ51Bs83Im/XmToJuSLFNPTbtSCSRYWx6ZSPNmgcV4zEBWqFEeqoE63R1DjZNRWzUiFKg12IPWqQfoUAYpAXdM2xKituBop6qWY4JUU/It2UoUX/K7kUWhIfqSS6/vOCuVvBLCCz2k2fziGOnA8Jdm6VKyHf9CFnWZuRzEpqrnIk7KdC0Vfb7bI7fUdVeV3eGleGN48Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFFpqiROybeLyykQkE8OhpU/ECGLpMX0Ue94eUyZ2iQ=;
 b=Xu1b2LawRQdSKik4SL+rhal1U4gtSVg5o5pT1qzWi4VVxw6qflXt/0pXkjFfPnA+igQ1fWOiqHONqZSNwKwkq0uEmvCS96go0aepV1ib7k0rToKeSDi4K48TYGqjm0AcvvfSJh0Q8sOiqBhq+5/oxptbQgWsOjJPw3FiJSHh280PTY/+9Bu780smx2lfmbzixxey0ORPAwNsvz7bA/ubbbLqBcC7ZwtWIDJIkkxXP4sGAd19MTvRc87HYtV9OP1En7XSZPZQKNEDdRm3OrUfZSu8sox5uEKftWCY2m6V2eG1a22qwPEVHQ0MUL+24LXzmQzkoOEVo8vPrvfrP+kGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFFpqiROybeLyykQkE8OhpU/ECGLpMX0Ue94eUyZ2iQ=;
 b=iwyvugqqRYqvW/5xpBILjMv5WY25mQ1Xv/ChcqoDhiNkcLB6buK5RhBPAOQnQFtis3chxi41WcOad7eaWTxAEphg/2uKeGTpKOTP1OFD21RRLWOofqYPcTg/Pu0UHtNjLB45OhWYq2EPXWhrd5PG0RwldRmg3Hnb4GawavaTn5o=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5243.namprd04.prod.outlook.com (2603:10b6:5:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 04:22:48 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 04:22:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 03/14] block/blk-rq-qos: Move a function from a header
 file into a C file
Thread-Topic: [PATCH 03/14] block/blk-rq-qos: Move a function from a header
 file into a C file
Thread-Index: AQHXXLsJ6sLCbq0hOkWnSTEL7ytm3Q==
Date:   Wed, 9 Jun 2021 04:22:48 +0000
Message-ID: <DM6PR04MB708138AC7FF722E2322EBA2FE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 793de9f1-9b14-44ce-d94f-08d92afe3cff
x-ms-traffictypediagnostic: DM6PR04MB5243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB52434F1C011E40587BC8166DE7369@DM6PR04MB5243.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZyM3BWe24O57jlvdbRDuvtn7Hpo8sOR8kP+8ICcfyXvSk9AB9mDNJc84lEAM6DqAoOAsX1Z0TjuwVewknzDxg3vvVoQ9/Qlgd9uAKtifI35uqkujm9aH8SZnmmeGCCE82JoEPSLqp3P4FATiRVhSHxmNpFvO3aV1FluOpRX6KjrZCIq0ZShTZdxozReFDJGXilmjJcQdBWskwwIvyyqgTObf7T+mimukTiyHBHRvHTQ3QgTbJeiG6fW5PinqSud9qTvM6wq9lW2tWHiVy6pXnKu4KBx69NNXW97IT67sBNq9yJgJRHyWqakV003cDSNMXjOX81zsYSXsLvTPmgRm0jR3Kc0Y91rDj7Qf4JH/22CZLNQQG7Zgkop5vVBQAnDhMkgRIbSrlbJWK9qTt+mHf5Ja/wBd63bNZq56LyfiZGLVHsPcKO3SwFLH3++mLjDsPzPhPFg7pdJh1u7ahIq7XDMGq1xVQyF6V+Wpl0PoO6jGs4wYOCjXmcKSnerazNCV35EqNpttVuyagDLF+8lqA66CsFCVKAfcjfCfeGJEGGXHjRVrPcGqmBQCuyJ4YsUCGKmomXMva/+v4aL1xM86l8uKp4gq2XsiAu77HRpHuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33656002)(91956017)(6506007)(316002)(54906003)(110136005)(76116006)(55016002)(38100700002)(66476007)(5660300002)(66556008)(66946007)(478600001)(9686003)(53546011)(7696005)(86362001)(2906002)(8936002)(83380400001)(4326008)(52536014)(64756008)(66446008)(8676002)(71200400001)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4o0n4gvbyp0pJrpH/l0LMHqEvJMq3XKCuvfz2MOWgH8d99YsUdq8qqk/TtcL?=
 =?us-ascii?Q?8FKinhzZnDcieDx19Sa9hmUSPcDz10gd71wTPK9jH/wZoZ8iZRqeZ9W09Q1X?=
 =?us-ascii?Q?v1XbRjlQXqTjBwgdLiJsLRVjWQuP1YuWzYGT+o2qNRwGWeFP7IJ52H9EcJAr?=
 =?us-ascii?Q?TNwS9ljZ4wJGBxeE+2iPHZD/t/bMcOP1n0lMZU8ytBddUHJfc6JV2Ed1M4yA?=
 =?us-ascii?Q?LlcdoOi9rMayaJDmrNUt5OpfiYSixNbBybI+Gol2WJMCJTD/BWTZxqlv91IL?=
 =?us-ascii?Q?cHIeuMZjazXraV2nnScZGjOiYZziaHUjnnVhEqTbDiHFKhReTGwXg/hqzoKs?=
 =?us-ascii?Q?am5tftlRe51iGXyYJPmItnsf3D4/2QeS1Axrvwa4oklsj760PoVEpx6Q1pHg?=
 =?us-ascii?Q?F1saFlmqauJmWLYi0ADUW6hKS5C723uE33jSkFiHZbVQMDhYJq+SKLYocg6Q?=
 =?us-ascii?Q?GBw0r4FJqIKD8xa5fXzMB1r6Hu8sbq9Ju37bPiLpsf6t/SQvhfvYAoszH5XD?=
 =?us-ascii?Q?iKIu3Sgqikc4PEw0i/9n3BLwDIBPtnvvqNs7J8My+KgEWAb28jvkuNB9oYqe?=
 =?us-ascii?Q?0qJlm/T8S7ToDyPcsWSmXSFwQcplCPOpkOctQiSsM5NqjqeDmf7YOep8pFLj?=
 =?us-ascii?Q?xd/LntSae6dMZyjfxvWJHTzuDAkxwUeOG7TNJaGK9pMKYzMuveGdHDSEyxG+?=
 =?us-ascii?Q?0WMrHk8JCMiwlzTmhUmLmKn5i53RlCyAtAeuqgFVy+Vdptp1v4m6fY8d5P/D?=
 =?us-ascii?Q?6OMOzt5RfexAevKgFfP8v5zFC8L8FIsKsaywh207bk/kIgmFBUAp2SzVhwJs?=
 =?us-ascii?Q?IzV20umoEQcP9q5n615YJAoIGcoPYSvTuzJDxtt8jNOSevtkL3sl+wzmCTvd?=
 =?us-ascii?Q?ZGuWHWhwRkt19E0QgrHpL7hOSaJaJ+Gt2e31fVeeZpTCZfGEtQA28N90tjkw?=
 =?us-ascii?Q?Shnuz6w3BpX7+GAvGoD0Po5spdtmN7CeEpOg0Xx24U/+9ETmQw5lvJnPulVQ?=
 =?us-ascii?Q?/gUCRq12ws58lMWbCAZhK/qCfO+VzW/zJBoDGLmje/2ICykztWR5Oe8JOwrT?=
 =?us-ascii?Q?HrfKKRMhPdSCJUxulMCD/Y5dm3AFdLABHjpD7qaKycm2m46iCpwjFiDFUF3E?=
 =?us-ascii?Q?UVlycAkwHc5lBcj+Viy+a/jWm2spzmfmwFM8w+mOgLWVr1AAanitcdZcBgPu?=
 =?us-ascii?Q?mYCErrCAyB9MFdEeTTSyPoovOSrfxD3EKPZR8t35ej4PvDdJtwR06cH2Xphn?=
 =?us-ascii?Q?PsdCSa/0bPMVuMuEoPVI6QFifr18UE56G5sD936AJDLTqUugHrrD30GMd+cN?=
 =?us-ascii?Q?vC9hCN4Gay3XgvH5KfBMpfrtQrD3zcn0tb9LerwJkEvHj4OHKVhQnzyyXgk1?=
 =?us-ascii?Q?45pP4Y2wBf0Ssk8unfWc29g+qryRvZEVz3plyJG891b3J8SzwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793de9f1-9b14-44ce-d94f-08d92afe3cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 04:22:48.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3zdJqfqqzn8Q3cUtASZekdPp+VDT7gAEQ13o4u8Bu/rkXDU7IQUhye0Vo4SC3cLwccX04SgCjjNaBDaGFne8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5243
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> rq_qos_id_to_name() is not in the hot path so move it from a .h into a .c=
=0A=
> file.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/blk-rq-qos.c | 13 +++++++++++++=0A=
>  block/blk-rq-qos.h | 13 +------------=0A=
>  2 files changed, 14 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c=0A=
> index 656460636ad3..61dccf584c68 100644=0A=
> --- a/block/blk-rq-qos.c=0A=
> +++ b/block/blk-rq-qos.c=0A=
> @@ -2,6 +2,19 @@=0A=
>  =0A=
>  #include "blk-rq-qos.h"=0A=
>  =0A=
> +const char *rq_qos_id_to_name(enum rq_qos_id id)=0A=
> +{=0A=
> +	switch (id) {=0A=
> +	case RQ_QOS_WBT:=0A=
> +		return "wbt";=0A=
> +	case RQ_QOS_LATENCY:=0A=
> +		return "latency";=0A=
> +	case RQ_QOS_COST:=0A=
> +		return "cost";=0A=
> +	}=0A=
> +	return "unknown";=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,=
=0A=
>   * false if 'v' + 1 would be bigger than 'below'.=0A=
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h=0A=
> index 2bc43e94f4c4..6b5f9ae69883 100644=0A=
> --- a/block/blk-rq-qos.h=0A=
> +++ b/block/blk-rq-qos.h=0A=
> @@ -78,18 +78,7 @@ static inline struct rq_qos *blkcg_rq_qos(struct reque=
st_queue *q)=0A=
>  	return rq_qos_id(q, RQ_QOS_LATENCY);=0A=
>  }=0A=
>  =0A=
> -static inline const char *rq_qos_id_to_name(enum rq_qos_id id)=0A=
> -{=0A=
> -	switch (id) {=0A=
> -	case RQ_QOS_WBT:=0A=
> -		return "wbt";=0A=
> -	case RQ_QOS_LATENCY:=0A=
> -		return "latency";=0A=
> -	case RQ_QOS_COST:=0A=
> -		return "cost";=0A=
> -	}=0A=
> -	return "unknown";=0A=
> -}=0A=
> +const char *rq_qos_id_to_name(enum rq_qos_id id);=0A=
>  =0A=
>  static inline void rq_wait_init(struct rq_wait *rq_wait)=0A=
>  {=0A=
> =0A=
=0A=
Looks OK, but since the only caller is in blk-mq-debugfs.c, the function co=
uld=0A=
be moved there and be static, no ?=0A=
=0A=
Anyway,=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
