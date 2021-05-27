Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F6C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BC3613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhE0D3S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:29:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60192 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhE0D3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622086065; x=1653622065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=b0JG8MR0tOJ38tEFIZ6o1ZsjmTeqzo3H10btqpcmlxY=;
  b=Iz9yK1aimDfb/8MErQR+SNPaSp2OsckimfC6G/KKeFSgN7xKmKCZr0Gb
   9aE66QvhviZp8gGJ7xZS16qLg8wQD4GQ6LXsu31+rAHRCVKhRJkuVu2Wh
   oYw5I6x5MjO9297fXyPf+fH+L7dvynGhQnxuTkmi4Tqh11P8XmYPL8/pA
   4RojvPmMbZ8LzlQ95emj9F7IFK464laAFEMNST5eSdu7byS093+OJRsr/
   JfKqjkMnIwLAOZD/C7xgbtDeO+ZHP9yEIdmgB7Rdee8i9xBNLsZdnHbnS
   uTYaQEeRlpzxqd+SfEudBjsw7X28kfmSbZhWuYcbynpxdunkmIdV+7SxN
   g==;
IronPort-SDR: Z/tKHXcoVtDQcscUg12HLJ1acwV79X5vRzqSkwirJbFqxAhYksf1Q7D9dfQhu2mA1HeDho4Pne
 dHBBELr9Q9IEG3F2DcllFW4fItZsNqif6aP83Mfo0ZnF+UAwEwNEWc8qmSPmqo/clJhgiR8k0G
 Ikh+tXh+muvgnUxw+Fh/tTLObqCGBYU//7a+0KGXoO+M2wKXX+I9Q04mQ32y3kZ+jrNsCFKrGD
 lQhxsPz8TRrGXtem5toaYn+AI3JBZdzEKJmm33Th5BpYCk+dV76gFmAZnX0eFYKu4hHDCS4oMz
 ElU=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="280905100"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:27:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcrGdd+KEcHl55ts7GfkuIhMxH1k4NoW/OY8xTKs/HnzbH26Zh1epWcIiUGknMAdwFCn8SC3ztMZxX1SGF8Pyvn9cjUEaV2qrKNQjPBLUUJ9cw9Aa7NThW3K0nVgxnIkfYD7gpRHNFBLxkQhe1GGadHeNMUTUyYkmE9ZoNvgAYKZ9QpK88qo5qxZDRR6YWEutsIsBsU8OfiGz/BYhJKOC7bIFNK5RrRH2LeDRMHv/FxRZIqjg/3VNbk9+eNbgnZJVP8sKIz9TaofZYsWBK3VyA28zx/ydNgDXS+yjRfsKjSPHZHm7/GADbIVGZVmzPrEpkK+4DPdLAM85G7mvsK+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48+70Qe/9R0wLsA4oh6xDudcLvj+JY0CdxhBYPHQKpw=;
 b=hXx4IXio44nAif2Yvsg1inOLOiveeemybHRSG/gqruANIyfSZ7yWVMfO3Ouj4BUC2Aj1IPonR8v2o9UVCu4p1k966rNASJ5Ps5DKSmy9zgUcoFrCoqY1g9hFT9mb+58M9ibyNi/ZuuKbX8ox2KIbx8zOAIevgRnEbubNprZmmVVJ5UwUWORbpoJodW8Oy7XWA7z3dKMt74oImjxR3EQX5+a+2JBwqNTsm229+PBw65DVG++MBg0cSqNoIA7dX4s6gVZ+DgxbBog6OP5VeixMVwnlzO7doFgiYL+YslNDtO1780gFX1XGWiw/eqTz/Vkw0lk7YJvuplVMddSkznNuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48+70Qe/9R0wLsA4oh6xDudcLvj+JY0CdxhBYPHQKpw=;
 b=rjTkEBVs6Ylj7xjL4/Uo4rLnDd02h1DV8drp+3VOmvc2gaoh32NjeMWEWIgtx0aft9pMXBJQOIFOaLMM351omcenKiaFKunT8frph75iB8U0vx5/96oFFhUSieOGHlXUrgN38IsGgBLUh4is8AEKsdmWdPtVhU7i27ojEwvUr4M=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0253.namprd04.prod.outlook.com (2603:10b6:3:6d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 03:27:43 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:27:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for
 non-rotational media
Thread-Topic: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for
 non-rotational media
Thread-Index: AQHXUpPnvsB7fzwtrE6mHrz2UNvIdQ==
Date:   Thu, 27 May 2021 03:27:43 +0000
Message-ID: <DM6PR04MB7081C2ED7E71979FED8CF68EE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ddc72f1-b208-4632-138b-08d920bf63f1
x-ms-traffictypediagnostic: DM5PR04MB0253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB0253E54A096143E1C437201CE7239@DM5PR04MB0253.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKEiH/FOQYctjCZJG9LxC3pRv/aSuh1jXHxsJhJY6ULKApZCP0cxx8oCtH+4EPzgS5VqIdPMoOWixQ6ogzCtlbTS78yl/Dg2mow0VesdBim6JNBaaiOXs1b29eURl5LNjKVM6T+PjPV/OMMVcQnLgH60nqhKHP1hWUr279qWd0Hk+EDMeF/EyX7KZhk8PXo128NTDzHbYmhQIg6L5v6aX38RoSJfzB3oXQAUGtiM6TiPMmWqqTmmbUkwcdiT1Iu8TYGbsuP7hVsvIFNQ1emAy8Ih9jUqxqNqSjQ8r8s6+yexsVaCc3vhdqxiR2OHFsZ4h36H2t/0TK/j/HkSR/QEawB3iesW3ydYT9DvzPgOA5KB4KLXnNichyWyJ/ESQuzykA3OgIhEMiXMbL7yjAAJPYDKpj9WSK7pOm/jWC0xJn87ZTwTl3ORZpavUYc5Oph/Y9OVxTCsIUo3hO6sYAkCb1iHGP7kvU/xjTkcFtO88x95srU5x/BmmHTBcRzwHPVOATK/z7tSv/w0a8a3oRIclA4MWA0DBHrbxMHpoHdUEZnC4n557FHGIsBFcuJO8tB04T6JjSCamlpceXR5o3CC3RHcLqGoWGxzECqLcFcXlgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(4326008)(26005)(33656002)(71200400001)(53546011)(7696005)(6506007)(55016002)(122000001)(86362001)(38100700002)(64756008)(91956017)(186003)(76116006)(52536014)(2906002)(8936002)(5660300002)(9686003)(316002)(478600001)(110136005)(66446008)(54906003)(83380400001)(66946007)(8676002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oqYi+cER48FCr+JJASmEXWGekRU9xOv5tDo1DV8jq1E0iYjxEaRnjUkyNcgx?=
 =?us-ascii?Q?9oVV5hAENJnBvNREqde/0ACqtX2gxs8YaG3iWuEm87LlT1c6wJa5W3otIjGn?=
 =?us-ascii?Q?KaQckvXO8NsALLPbLu8RRWCrwFa+vtN3gqRYKwvMDJim+w5afOvlY32IGvIJ?=
 =?us-ascii?Q?D3w2J0dL/FPQPqahU5+q8POMY3P1GJVJVt4I5O/T66I0DxSZZbWzw/F4xnI+?=
 =?us-ascii?Q?pIVum6ouhSH1Q9kWazbNlh73DxkR5wK5O41D4sgFIK5dSHgdxjXKzm5+u/d/?=
 =?us-ascii?Q?fkArRtyDgSuqkZU29f+o221yiPhdz7XL4v0bty2IedoYUOQSPAU4fsinxGp0?=
 =?us-ascii?Q?BvuUquN2qKM4N8vcoLKyX02bT8MRlBRIuwltQeOAw2cwOu1ZaAf1ffTfFYJY?=
 =?us-ascii?Q?UwIvq0AACzsFlwZvIn0cVDGs7dyBUsMVbX7LpodTlm+jYEKR5VoTW1yyTlVo?=
 =?us-ascii?Q?wCAr/9axPl5GW/aBto5BjOGyhfsAZ/Y0Uoe4u57rnQDytX5ovWOi8OsZA7Ku?=
 =?us-ascii?Q?bxapCJ4bC6NiANudtIe/kkG35eM03YUSuz/3iSrX59QVoK7iTP/zWHqEG4o0?=
 =?us-ascii?Q?A5AH8Foz+U2ouKMgHHOQq7Xx4QwsUdh6n6TEtRglSOEc8FS4rlUlP570/xUg?=
 =?us-ascii?Q?AhZRHG/1JZEazlmE5eJ+CaNud1O8dJQBWS3AV+/Zq5ke4gDt+KEwIIbssETV?=
 =?us-ascii?Q?1EpEA+sYnn4A8zsdwta08qtXacvtGvtbrGPkTItFU9Z3HTRBcA3mSHWOFRGg?=
 =?us-ascii?Q?kacRtR+kfPIVpRp6LP0al80orGRCqLBAUhKlzmJhGaA/gQs8EvNmPKu2qWKR?=
 =?us-ascii?Q?bkP5U9IExLoSDX74GY0eXpfXivc36ZElin5dOAtjbuwQf5PTp6zYgqjYMuhr?=
 =?us-ascii?Q?9m2cCAVWI3z4QulwMBDWYJLCd54MesXOk5IZ99ReewFjDZBN3BOxQv6/HJB4?=
 =?us-ascii?Q?3+c8XTDZWeXopmSd0OWDEC97/jY7m/oeCd14gGF9T/c3we81A9J8BymqclMS?=
 =?us-ascii?Q?kKPUq9KGSWQByrTvE3/LHKlOkkRoHEL8wzJT8VysmAAVKppm55FZFy1MUlq1?=
 =?us-ascii?Q?gELXg3fJvGBnN9uvW47eapmmFdd35Pfp/C14HGaeGEj2jhRqvqwoyB0ovVvL?=
 =?us-ascii?Q?J8+kSM9THufDiy7+meT8XtKg3Z7FlM5XeqOJfQW8iJSgBiQr9vQRoBrp8tiY?=
 =?us-ascii?Q?YjWZ67kDIm6kLQ5Eq1fXeIlfxzdnTr0ZDqXiYUAUZWMNMp1FX7WtDaRMZYKq?=
 =?us-ascii?Q?SjdlXRAfABOnJQbx+bVhpVpwizbz70UoBVtTvds7CoHnd6KVT3uju7osew85?=
 =?us-ascii?Q?4WthB4HmrC9JO9OOvSLkSCrsrcLmpg738/Doj6fKLV9efg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddc72f1-b208-4632-138b-08d920bf63f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:27:43.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXMUT/Azk8PVVh4V0szRvYBk0vy2IPMW95Uiy1XPk3hbChKbNGYT7i7YqP7qlrGb3HIttgsg2m+47vsRdzRPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0253
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:02, Bart Van Assche wrote:=0A=
> Rotational media (hard disks) benefit more from merging requests than=0A=
> non-rotational media. Reduce the read expire time for non-rotational medi=
a=0A=
=0A=
"Reduce the read expire time for non-rotational..." -> "Reduce the default =
read=0A=
expire time for non-rotational..."=0A=
=0A=
> to reduce read latency.=0A=
=0A=
I am not against this, but I wonder if we should not let udev do that with =
some=0A=
rules instead of adding totally arbitrary values here...=0A=
=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 7 +++++--=0A=
>  1 file changed, 5 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index dfbc6b77fa71..2ab844a4b6b5 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -29,7 +29,9 @@=0A=
>  /*=0A=
>   * See Documentation/block/deadline-iosched.rst=0A=
>   */=0A=
> -static const int read_expire =3D HZ / 2;  /* max time before a read is s=
ubmitted. */=0A=
> +/* max time before a read is submitted. */=0A=
> +static const int read_expire_rot =3D HZ / 2;=0A=
> +static const int read_expire_nonrot =3D 1;=0A=
>  static const int write_expire =3D 5 * HZ; /* ditto for writes, these lim=
its are SOFT! */=0A=
>  static const int writes_starved =3D 2;    /* max times reads can starve =
a write */=0A=
>  static const int fifo_batch =3D 16;       /* # of sequential requests tr=
eated as one=0A=
> @@ -430,7 +432,8 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)=0A=
>  	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);=0A=
>  	dd->sort_list[DD_READ] =3D RB_ROOT;=0A=
>  	dd->sort_list[DD_WRITE] =3D RB_ROOT;=0A=
> -	dd->fifo_expire[DD_READ] =3D read_expire;=0A=
> +	dd->fifo_expire[DD_READ] =3D blk_queue_nonrot(q) ? read_expire_nonrot :=
=0A=
> +		read_expire_rot;=0A=
>  	dd->fifo_expire[DD_WRITE] =3D write_expire;=0A=
>  	dd->writes_starved =3D writes_starved;=0A=
>  	dd->front_merges =3D 1;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
