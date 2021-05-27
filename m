Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E2C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA76B613BA
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhE0DZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:25:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48109 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhE0DZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622085856; x=1653621856;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1YQN3rqJ8tzRhMHhsc1V5G7iGuMOSWdANUeBa255yUo=;
  b=M7A7Orcjw7QaJ134D59lZUucCxwQJ3PDJOjgwXmRc/7It/HqfDIRHgwl
   +SHZE/bMYuS1AnRHFtQdPk60KD1DUKTU/2rhFUjKvrTKpod/zoR4FIEdC
   ZZ1a5XTFoEneHro+xGrPCLljuJdKqkmyfi4VwOrcEn5z4+OWhr4GHnC0p
   NQf+mXXdUmIwinMcwmeUYmRPFTxZsselDflfN1K11j+R/uExPXaeuWgx0
   3gLiGo+XdB0H4S3qQEGqE21MnC2v7y/qGTQAq36Fe7Ltned1yURj7EPw5
   mKhjfblfXG8uOUWqhreMCxviuVzJZeZBRpkvdOCw4kQEZcXK3FgCd7GM3
   w==;
IronPort-SDR: A9Vl557fpP4KyzW7lGXx90Eu/hgrcX22E5hODbM2FuKdDPUM2ph8QC9UpkZSWfa5FMIGbvHxxE
 LGVx6U0ZvBlroerrWk9pYeRUGdX1sn/Hog0qKORDQFrDqqsbadfKDOSy9kZ+Hc5jXFOpo0GaOp
 3+FHneQNKkLBcuKxIckhIIg5IyT5/vkwSh1egGb55qF87WmdB5G/L1rnQA95SdXzb2UGK4rcaD
 jEaad7KLtSngM72rnH/21mO5NPyH0vfQrkzVdtiNYJwA56FuhAiLA4cY4WjshivB7Asjuji6ia
 D3Q=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="170122927"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:24:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmpSZPWjnq4fEaj8IoWUPnGrke3SNIaSWHh5UXAp0jq1MmuM4oU13loKV9fd3VcdZtZ1wePWp8xkuZT6u5oX83afwMpkLhhYGCXY7bdw0PMKGXugdyD2MK9aF/sdBxFYG/8e/U3R+Y/YHY9dtdkeM1i9LK31uFXubVNIxYLeSSd4zxPeyj1m1UIo3rl/d8/mTTsTW/TtvLvFip1aG+95ckyQYQwtzqJTROikcB+ut26AgrNMMHCSxtMfI2UWXbPUAC3EFRm/rrgFT7A3D3dAK28Re+zKTEK/elGVZoX0SpZRh4rNTKzVNPwyPgS+LHnyTM5PACzd4AKK90EoKmqiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTR2kb6J85ofq76uby/DXrWL+Y72LnxTzbJiBEoHHZA=;
 b=S8zN7zV8YQmDQoBKmAmgnrKsu7/3ZWMMQp9TjYy0nQWwgEfdDoYzBJOuU8qHqianJYNrpe2EIlpRdqz0QotV2d1whe5L8Rlv8mugXHyY8LC2Ux4LQhlCruV9WyEGeaI39Znh/Fqga0NDGmJ2oiqU4cY7ahYMXYXRU1qpm8ybI6+Q7CisV8eitQC3ApHGYjURgIaP1efex/xN2xAop1yVBXgCijSeTIgL0uuG35sx31FXBt/yi70P9xIXxq8tXJypV1xZ7O64gD5smuyPAIxt8IqU8YWAzO2PZccQREFC00sEV/cKFtV5dJ3pKEjiimk9Fi8RR72bUXPB7TwybgLlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTR2kb6J85ofq76uby/DXrWL+Y72LnxTzbJiBEoHHZA=;
 b=iuMB4xiqhmV9toeSPq9atml6tA+bdd/3W04HkzaZEBCCI2kMTLEyL9XqxN+rvQ4sXoXQ/LGaQSfLW8ItNJdjrlM/wCO8nhKsMdP3NlQECwqnsMzNYtvATUhdQ1pMDuXsePwkWEQQ8sCd8iAbFRVP/sTmLSVnZ+23M8NJcrLysiU=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5595.namprd04.prod.outlook.com (2603:10b6:5:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Thu, 27 May
 2021 03:24:13 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:24:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Topic: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Index: AQHXUpPnRe2tZsOQw0aU6HOrY5bcLg==
Date:   Thu, 27 May 2021 03:24:12 +0000
Message-ID: <DM6PR04MB70810C07E70C25EF512B4A45E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc72143-ff52-4529-b360-08d920bee655
x-ms-traffictypediagnostic: DM6PR04MB5595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5595008396B27D41746AAD9BE7239@DM6PR04MB5595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QX32ArVYNMWisHTKdIoNZVd03iUM5x+Jr2lsPEMSMItqfdulQXMWLDOw2frWpWXeN2J0BBlnnZiHc+VNjPxSaShQeugOy7z2eY1qaw60gQB9baNUXRQHesBVfZCKM/d1C7lvwPQgDDYhHQuksLz3Uk2X7hx3noE8oBwpuCPhKojMEuC82mSALffOBIOL6CXaq0zWr7AOdZxVQnxPnFFEqVQJsSuPovA4CkHSh83xcKpaSPYmsnBFpA95CZveDcz/AjK0gC5NzaLIk/7LD57yHWfyR4T4MGzDElX4yLyY4o8ivo2j2NecMWeUUpO/fF/rGWi30yHlDqqBv/JkKnpO20IrdNcig2ZuJtYMQbXWGFizSTSbSBviNodHznJsgCGZNtIAw02uQ1BBsDJ/Ekp7B9l1K0RVIal20T7/REuOrJZqEb5v6Yb7MtidBWc+KAJOvncdtpPwhyM05265l5LX9VpgDco775qKYDhjJIyzFeLzvwlv/HEUUeX5MMTmiGmnTIadAXyox7MdUMU4m6F6CvGnzpxUkQuIwkkdDV1rDhJulE7Tyn+Gb8+q7tFH/inW9wh3WV0LHVcq1tO8QBQnLDGOTY9ADhIKJsawRyKNpw0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(316002)(54906003)(9686003)(110136005)(66946007)(4326008)(83380400001)(2906002)(52536014)(71200400001)(30864003)(186003)(66446008)(64756008)(76116006)(91956017)(66556008)(66476007)(8676002)(8936002)(5660300002)(53546011)(55016002)(26005)(38100700002)(86362001)(7696005)(478600001)(33656002)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tAgYTXXv2fQ1aNfOHqyXs8kbovWA7JNgXF/zlDOO+PNy6Ke3mv08naqv+0WY?=
 =?us-ascii?Q?juLYNhDHw9sLtk5L+h7zmWA4L0mtToLqw7Umli9nP90udGjz1G+pSgJZr9QF?=
 =?us-ascii?Q?2Bb5TjlceJpJXQqRJlsFEh8ha9J4h52KW/tSfkCWynoV82dtmdLxk74StTNq?=
 =?us-ascii?Q?GzHzlzrjaPiST/BfY+w2KjXIEEtxW1sYm/m/fyok6WhQCEGxDolycMMLhbA8?=
 =?us-ascii?Q?ATu+c3rTjiS79lV6j+4EC/MEa8k0gda8YD6Q34IAGXaFD6MhyGg0CjHxkd9z?=
 =?us-ascii?Q?nmMibYPLHVEGtB1DR3fe/pBhH5DnNpJliDuN6ZGM/yvlbMsb38d1z4LsCm8+?=
 =?us-ascii?Q?JMUnPM+OJ1Vk9uwaK1dy1/ormFpHZGlPMr4us/I6HAEpiDNeX6aixc6Xmur7?=
 =?us-ascii?Q?vNxiRRlb2w0CkXgAjecKNH+kYId7eih/UiFQyPzKb9txPIuA6eZ1QSEJXnqf?=
 =?us-ascii?Q?+e7UKh3jeGdIq27DAEQZYLGnQZ7SblrdVbx4c8HgwDR72gmKhsA5g8HLHBYM?=
 =?us-ascii?Q?eimegV/VbWfB/BBGMnx+iAn0vo7yfSsKEjgXEJeaEEK3dT1YTgGyt1vTPqZm?=
 =?us-ascii?Q?T87r7D+2aGK+cWlbdKDMqH8RHLOAxYuy/PE22FiQAHc8TC5zKVwDv7C54BqU?=
 =?us-ascii?Q?U4e2q/pf9Iq1h1Wpm2Il9kUlcqOrLiqDgZDBwx0p62x00Q15ygEyUNyJ6LOb?=
 =?us-ascii?Q?zjuJNtkQL6abJnTTjh/zqj12SM1rwESJk/1pGiPL+6q8Q+Tz+dIdlu8XLwGw?=
 =?us-ascii?Q?aM5qzp/kphOsHAMdOh9xM6fmLNms2MhdPALnJ4K/9jnOOWAxof/w6nWn6gj0?=
 =?us-ascii?Q?Npi56xV3oeYEDowM149gTmYtGNAmcPO6Sc5yjUuMJwqqejxRD5DgYhObtSB5?=
 =?us-ascii?Q?SJtGgYoa5w6dg87kFyAR17ZVN2+9xnfpSOR1ma1ZU7L8/CfxMM8iGH+m60sl?=
 =?us-ascii?Q?j666aFgaMQgUPxu0Kx4Ru4ufzl6hbM9zSrdmXp76eHde7IeIJXH4MCl9A3tA?=
 =?us-ascii?Q?P75ZKbZTISn29l2ZVxZAxlTS5EHMxgafjqfzhuucPUihZoYeAYKiKNmvuXls?=
 =?us-ascii?Q?ZMRDZZ2aXf/xw0zn67GBncOlx0Pf4vbAGBJA7ECI9HKgjVixIaZwVGNhp7I3?=
 =?us-ascii?Q?3xt7UoVu0KUNEikTvMUIH+Zu+5BUBSpOiUbXdvQUQAkleXDlWSAOL0Z/33ld?=
 =?us-ascii?Q?00ALON4y9D6+Rt5GabUcDisP8GTi4wvKsBDrQpKUaBzG2M9oZuCerBczFdmk?=
 =?us-ascii?Q?rC/HD35N5tqAdCNGr1ozdlqSE/PXdHBilayv8PRwV4jUQl6xikpy7gh2ODIh?=
 =?us-ascii?Q?+M3TOXCL7oSWRlcWK8JFgw35EKRWl9nmyv4+MZvAo2roXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc72143-ff52-4529-b360-08d920bee655
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:24:12.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llzwgL7/49WKJkLVOxRwNfPnkQhK3ChcKDB71eimNQGFCJ/UV3LLxa/mG4TS60GMR7sZ8sDp+tt+aQ4o8sW9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5595
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:02, Bart Van Assche wrote:=0A=
> Modern compilers complain if an out-of-range value is passed to a functio=
n=0A=
> argument that has an enumeration type. Let the compiler detect out-of-ran=
ge=0A=
> data direction arguments instead of verifying the data_dir argument at=0A=
> runtime.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 96 +++++++++++++++++++++++----------------------=
=0A=
>  1 file changed, 49 insertions(+), 47 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index c4f51e7884fb..dfbc6b77fa71 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -35,6 +35,13 @@ static const int writes_starved =3D 2;    /* max times=
 reads can starve a write */=0A=
>  static const int fifo_batch =3D 16;       /* # of sequential requests tr=
eated as one=0A=
>  				     by the above parameters. For throughput. */=0A=
>  =0A=
> +enum dd_data_dir {=0A=
> +	DD_READ		=3D READ,=0A=
> +	DD_WRITE	=3D WRITE,=0A=
> +} __packed;=0A=
=0A=
Why the "__packed" here ?=0A=
=0A=
> +=0A=
> +enum { DD_DIR_COUNT =3D 2 };=0A=
=0A=
Why not a simple #define for this one ?=0A=
=0A=
> +=0A=
>  struct deadline_data {=0A=
>  	/*=0A=
>  	 * run time data=0A=
> @@ -43,20 +50,20 @@ struct deadline_data {=0A=
>  	/*=0A=
>  	 * requests (deadline_rq s) are present on both sort_list and fifo_list=
=0A=
>  	 */=0A=
> -	struct rb_root sort_list[2];=0A=
> -	struct list_head fifo_list[2];=0A=
> +	struct rb_root sort_list[DD_DIR_COUNT];=0A=
> +	struct list_head fifo_list[DD_DIR_COUNT];=0A=
>  =0A=
>  	/*=0A=
>  	 * next in sort order. read, write or both are NULL=0A=
>  	 */=0A=
> -	struct request *next_rq[2];=0A=
> +	struct request *next_rq[DD_DIR_COUNT];=0A=
>  	unsigned int batching;		/* number of sequential requests made */=0A=
>  	unsigned int starved;		/* times reads have starved writes */=0A=
>  =0A=
>  	/*=0A=
>  	 * settings that change how the i/o scheduler behaves=0A=
>  	 */=0A=
> -	int fifo_expire[2];=0A=
> +	int fifo_expire[DD_DIR_COUNT];=0A=
>  	int fifo_batch;=0A=
>  	int writes_starved;=0A=
>  	int front_merges;=0A=
> @@ -97,7 +104,7 @@ deadline_add_rq_rb(struct deadline_data *dd, struct re=
quest *rq)=0A=
>  static inline void=0A=
>  deadline_del_rq_rb(struct deadline_data *dd, struct request *rq)=0A=
>  {=0A=
> -	const int data_dir =3D rq_data_dir(rq);=0A=
> +	const enum dd_data_dir data_dir =3D rq_data_dir(rq);=0A=
>  =0A=
>  	if (dd->next_rq[data_dir] =3D=3D rq)=0A=
>  		dd->next_rq[data_dir] =3D deadline_latter_request(rq);=0A=
> @@ -169,10 +176,10 @@ static void dd_merged_requests(struct request_queue=
 *q, struct request *req,=0A=
>  static void=0A=
>  deadline_move_request(struct deadline_data *dd, struct request *rq)=0A=
>  {=0A=
> -	const int data_dir =3D rq_data_dir(rq);=0A=
> +	const enum dd_data_dir data_dir =3D rq_data_dir(rq);=0A=
>  =0A=
> -	dd->next_rq[READ] =3D NULL;=0A=
> -	dd->next_rq[WRITE] =3D NULL;=0A=
> +	dd->next_rq[DD_READ] =3D NULL;=0A=
> +	dd->next_rq[DD_WRITE] =3D NULL;=0A=
>  	dd->next_rq[data_dir] =3D deadline_latter_request(rq);=0A=
>  =0A=
>  	/*=0A=
> @@ -185,9 +192,10 @@ deadline_move_request(struct deadline_data *dd, stru=
ct request *rq)=0A=
>   * deadline_check_fifo returns 0 if there are no expired requests on the=
 fifo,=0A=
>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])=0A=
>   */=0A=
> -static inline int deadline_check_fifo(struct deadline_data *dd, int ddir=
)=0A=
> +static inline int deadline_check_fifo(struct deadline_data *dd,=0A=
> +				      enum dd_data_dir data_dir)=0A=
>  {=0A=
> -	struct request *rq =3D rq_entry_fifo(dd->fifo_list[ddir].next);=0A=
> +	struct request *rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);=0A=
>  =0A=
>  	/*=0A=
>  	 * rq is expired!=0A=
> @@ -203,19 +211,16 @@ static inline int deadline_check_fifo(struct deadli=
ne_data *dd, int ddir)=0A=
>   * dispatch using arrival ordered lists.=0A=
>   */=0A=
>  static struct request *=0A=
> -deadline_fifo_request(struct deadline_data *dd, int data_dir)=0A=
> +deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_di=
r)=0A=
>  {=0A=
>  	struct request *rq;=0A=
>  	unsigned long flags;=0A=
>  =0A=
> -	if (WARN_ON_ONCE(data_dir !=3D READ && data_dir !=3D WRITE))=0A=
> -		return NULL;=0A=
> -=0A=
>  	if (list_empty(&dd->fifo_list[data_dir]))=0A=
>  		return NULL;=0A=
>  =0A=
>  	rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);=0A=
> -	if (data_dir =3D=3D READ || !blk_queue_is_zoned(rq->q))=0A=
> +	if (data_dir =3D=3D DD_READ || !blk_queue_is_zoned(rq->q))=0A=
>  		return rq;=0A=
>  =0A=
>  	/*=0A=
> @@ -223,7 +228,7 @@ deadline_fifo_request(struct deadline_data *dd, int d=
ata_dir)=0A=
>  	 * an unlocked target zone.=0A=
>  	 */=0A=
>  	spin_lock_irqsave(&dd->zone_lock, flags);=0A=
> -	list_for_each_entry(rq, &dd->fifo_list[WRITE], queuelist) {=0A=
> +	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {=0A=
>  		if (blk_req_can_dispatch_to_zone(rq))=0A=
>  			goto out;=0A=
>  	}=0A=
> @@ -239,19 +244,16 @@ deadline_fifo_request(struct deadline_data *dd, int=
 data_dir)=0A=
>   * dispatch using sector position sorted lists.=0A=
>   */=0A=
>  static struct request *=0A=
> -deadline_next_request(struct deadline_data *dd, int data_dir)=0A=
> +deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_di=
r)=0A=
>  {=0A=
>  	struct request *rq;=0A=
>  	unsigned long flags;=0A=
>  =0A=
> -	if (WARN_ON_ONCE(data_dir !=3D READ && data_dir !=3D WRITE))=0A=
> -		return NULL;=0A=
> -=0A=
>  	rq =3D dd->next_rq[data_dir];=0A=
>  	if (!rq)=0A=
>  		return NULL;=0A=
>  =0A=
> -	if (data_dir =3D=3D READ || !blk_queue_is_zoned(rq->q))=0A=
> +	if (data_dir =3D=3D DD_READ || !blk_queue_is_zoned(rq->q))=0A=
>  		return rq;=0A=
>  =0A=
>  	/*=0A=
> @@ -276,7 +278,7 @@ deadline_next_request(struct deadline_data *dd, int d=
ata_dir)=0A=
>  static struct request *__dd_dispatch_request(struct deadline_data *dd)=
=0A=
>  {=0A=
>  	struct request *rq, *next_rq;=0A=
> -	int data_dir;=0A=
> +	enum dd_data_dir data_dir;=0A=
>  =0A=
>  	lockdep_assert_held(&dd->lock);=0A=
>  =0A=
> @@ -289,9 +291,9 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	/*=0A=
>  	 * batches are currently reads XOR writes=0A=
>  	 */=0A=
> -	rq =3D deadline_next_request(dd, WRITE);=0A=
> +	rq =3D deadline_next_request(dd, DD_WRITE);=0A=
>  	if (!rq)=0A=
> -		rq =3D deadline_next_request(dd, READ);=0A=
> +		rq =3D deadline_next_request(dd, DD_READ);=0A=
>  =0A=
>  	if (rq && dd->batching < dd->fifo_batch)=0A=
>  		/* we have a next request are still entitled to batch */=0A=
> @@ -302,14 +304,14 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd)=0A=
>  	 * data direction (read / write)=0A=
>  	 */=0A=
>  =0A=
> -	if (!list_empty(&dd->fifo_list[READ])) {=0A=
> -		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));=0A=
> +	if (!list_empty(&dd->fifo_list[DD_READ])) {=0A=
> +		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));=0A=
>  =0A=
> -		if (deadline_fifo_request(dd, WRITE) &&=0A=
> +		if (deadline_fifo_request(dd, DD_WRITE) &&=0A=
>  		    (dd->starved++ >=3D dd->writes_starved))=0A=
>  			goto dispatch_writes;=0A=
>  =0A=
> -		data_dir =3D READ;=0A=
> +		data_dir =3D DD_READ;=0A=
>  =0A=
>  		goto dispatch_find_request;=0A=
>  	}=0A=
> @@ -318,13 +320,13 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd)=0A=
>  	 * there are either no reads or writes have been starved=0A=
>  	 */=0A=
>  =0A=
> -	if (!list_empty(&dd->fifo_list[WRITE])) {=0A=
> +	if (!list_empty(&dd->fifo_list[DD_WRITE])) {=0A=
>  dispatch_writes:=0A=
> -		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));=0A=
> +		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));=0A=
>  =0A=
>  		dd->starved =3D 0;=0A=
>  =0A=
> -		data_dir =3D WRITE;=0A=
> +		data_dir =3D DD_WRITE;=0A=
>  =0A=
>  		goto dispatch_find_request;=0A=
>  	}=0A=
> @@ -399,8 +401,8 @@ static void dd_exit_sched(struct elevator_queue *e)=
=0A=
>  {=0A=
>  	struct deadline_data *dd =3D e->elevator_data;=0A=
>  =0A=
> -	BUG_ON(!list_empty(&dd->fifo_list[READ]));=0A=
> -	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));=0A=
> +	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));=0A=
> +	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));=0A=
>  =0A=
>  	kfree(dd);=0A=
>  }=0A=
> @@ -424,12 +426,12 @@ static int dd_init_sched(struct request_queue *q, s=
truct elevator_type *e)=0A=
>  	}=0A=
>  	eq->elevator_data =3D dd;=0A=
>  =0A=
> -	INIT_LIST_HEAD(&dd->fifo_list[READ]);=0A=
> -	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);=0A=
> -	dd->sort_list[READ] =3D RB_ROOT;=0A=
> -	dd->sort_list[WRITE] =3D RB_ROOT;=0A=
> -	dd->fifo_expire[READ] =3D read_expire;=0A=
> -	dd->fifo_expire[WRITE] =3D write_expire;=0A=
> +	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);=0A=
> +	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);=0A=
> +	dd->sort_list[DD_READ] =3D RB_ROOT;=0A=
> +	dd->sort_list[DD_WRITE] =3D RB_ROOT;=0A=
> +	dd->fifo_expire[DD_READ] =3D read_expire;=0A=
> +	dd->fifo_expire[DD_WRITE] =3D write_expire;=0A=
>  	dd->writes_starved =3D writes_starved;=0A=
>  	dd->front_merges =3D 1;=0A=
>  	dd->fifo_batch =3D fifo_batch;=0A=
> @@ -497,7 +499,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  {=0A=
>  	struct request_queue *q =3D hctx->queue;=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> -	const int data_dir =3D rq_data_dir(rq);=0A=
> +	const enum dd_data_dir data_dir =3D rq_data_dir(rq);>=0A=
>  	lockdep_assert_held(&dd->lock);=0A=
>  =0A=
> @@ -585,7 +587,7 @@ static void dd_finish_request(struct request *rq)=0A=
>  =0A=
>  		spin_lock_irqsave(&dd->zone_lock, flags);=0A=
>  		blk_req_zone_write_unlock(rq);=0A=
> -		if (!list_empty(&dd->fifo_list[WRITE]))=0A=
> +		if (!list_empty(&dd->fifo_list[DD_WRITE]))=0A=
>  			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);=0A=
>  		spin_unlock_irqrestore(&dd->zone_lock, flags);=0A=
>  	}=0A=
> @@ -626,8 +628,8 @@ static ssize_t __FUNC(struct elevator_queue *e, char =
*page)		\=0A=
>  		__data =3D jiffies_to_msecs(__data);			\=0A=
>  	return deadline_var_show(__data, (page));			\=0A=
>  }=0A=
> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[READ], 1);=0A=
> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[WRITE], 1);=0A=
> +SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);=
=0A=
> +SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);=
=0A=
>  SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);=0A=
>  SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);=0A=
>  SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);=0A=
> @@ -649,8 +651,8 @@ static ssize_t __FUNC(struct elevator_queue *e, const=
 char *page, size_t count)=0A=
>  		*(__PTR) =3D __data;					\=0A=
>  	return count;							\=0A=
>  }=0A=
> -STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[READ], 0, IN=
T_MAX, 1);=0A=
> -STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[WRITE], 0, =
INT_MAX, 1);=0A=
> +STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0,=
 INT_MAX, 1);=0A=
> +STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], =
0, INT_MAX, 1);=0A=
>  STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_M=
IN, INT_MAX, 0);=0A=
>  STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);=
=0A=
>  STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0=
);=0A=
> @@ -717,8 +719,8 @@ static int deadline_##name##_next_rq_show(void *data,=
			\=0A=
>  		__blk_mq_debugfs_rq_show(m, rq);			\=0A=
>  	return 0;							\=0A=
>  }=0A=
> -DEADLINE_DEBUGFS_DDIR_ATTRS(READ, read)=0A=
> -DEADLINE_DEBUGFS_DDIR_ATTRS(WRITE, write)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)=0A=
>  #undef DEADLINE_DEBUGFS_DDIR_ATTRS=0A=
>  =0A=
>  static int deadline_batching_show(void *data, struct seq_file *m)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
