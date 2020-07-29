Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4137DC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 11:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1681C20829
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 11:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="icJt7jnr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gUdqYCWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2LUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:20:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13960 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2LUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 07:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596021650; x=1627557650;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xUrfzfxr6U6IgESfYZHxly14hwXCkFcMXcym2sBSVGw=;
  b=icJt7jnr4uq0v48564Wd/fG1sylBRiNQxjguZEmVqcDa0FoXMy+NiUwQ
   1315W4SpKRhQpwv0FCxfHf4Eoug8uOSeF5bTOxzC8LDkdN2fLIEgXnfBx
   +IOKkk+rdOz3+qcgpoTuh8kLcF6E75iFCm811vLzBVAPAGGH7KG5m5gBA
   Xi9gggVIRctE1nq2at/zEIQ1Y+PEDlMSiphS92ETpIFmWJ+xL+uhBvwC/
   awffV1/80hBc5Cy754P82C992UVoo7++oXpa5rxwDFhltkGIgYvpDthmD
   cyMPt2wK41oZK4uAkIMWtK244NL0qSSN0LoEtB9QJ91ZEAKpTRJGD0OG0
   w==;
IronPort-SDR: SBIqCX+UwwWnb1kcc8It/VlJpkG1/KFLeqpUGJtJVL3K7nSrGqEAAmhp9hjDoi2mxVrFNspRK+
 eRXug5vEJcS613kqwJm1Wv+klxBab/Q3ygO14YEfmN71X5zCJGnDNI3E5ZmY+EPf2eJ671cUQC
 VWBO67UKMOFtVQvIZqg3EDe/lKetWiywjvxAN6PR8OUMTtN2Ut0AA1fg0gLw1AQxSQDvO2b1Rb
 XCH06J/LpUudoHWmOHQlMh2XHD3QrDaEK/zqGSN612n88WMup9yI84REimOaIhwEs7QFbKB14H
 SrE=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; 
   d="scan'208";a="143643564"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 19:20:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePDe3ADPHcw0NY3YO8QfAlLEV+/sX/sF2ra6ABLFlCuFVmq+F6xK/rpclIyZ6/r7EvwiEZbZRdpereQVfQpk3RvRwQjewYHCv5+KXnijq9LcwSwoU2nkj0QaWH15UzjPIqwrA4ivNb8ScL9jGDc91lmwS6qUT8zbnKEnhy74boFjQctjXXgz1HIRWy2Le5yVx8ZmHSRafbbSmg2DTajcOIo4KMyzC4H8mEeY5ODV6QQOuJasLTBT7lfz00bDMoOh/yGo2YCFRvReAAg5P7fR5RKJEo/AqV/NRNlrFanl3E3+5rehWQZbkT9JIO6JSZtULdhTPMs4DeWtimf7Iw46pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJRe9q/dLXy+5U+inNIbLH5Vp3hWGYefVsXNO/EnnG0=;
 b=KU92pfzMgXwXkfiOyZdkgXjSo6QC5QenDKrUkAta7GIpjuuF0G1cYuua0t+ctmc/GgIUJqBR66gGq0nliHNmkxAM1iKJ+dovnQZJtIgDPanitZ2Bvbhm48N7zVpw0Ir6jjz9NZJN+lUEqrSaQde3PGa+mujbCVJxvdR3UUzV+mF9m6ULu8DEUuAI4Kp8SRdrOoX40hHN/lTnTs+ugT4hjk9K2onErDyKebYWG2XmNx9U+yeKNx4E2mxN6jZ+yYrcL+OuUo6+xZYdhP9JYHLk7dw6/QVbdCaICPYdE8VrA4zYegvw7Jbvg0GRzHj55zGnps0d+TMp/5KXrSXotHGRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJRe9q/dLXy+5U+inNIbLH5Vp3hWGYefVsXNO/EnnG0=;
 b=gUdqYCWzjJ6leNFD6juzro9Dkq7YAUfXtZJ7t5ZlegYvkMFdJWVHuizajgg3dFarHYHFsiQkSi2JUKi8BRRlyo24UFMxOOp1kcQuJDE7hmf6lUt1TkU4MfHnHhiQBEaP5UpI8ELmwhzouhoHoYp22t3840EO7MCiE3GQxBN+grc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4688.namprd04.prod.outlook.com
 (2603:10b6:805:ab::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 11:20:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 11:20:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Thread-Topic: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Thread-Index: AQHWZOYDnQug+Z97T0+gAjE+4hhaKQ==
Date:   Wed, 29 Jul 2020 11:20:48 +0000
Message-ID: <SN4PR0401MB35980A2B94FFAC8272BD076A9B700@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50c7bd57-eaa5-4ac2-7beb-08d833b17208
x-ms-traffictypediagnostic: SN6PR04MB4688:
x-microsoft-antispam-prvs: <SN6PR04MB46889D797889AA8618ABE49C9B700@SN6PR04MB4688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJ1Xe8tJr26g7hbpqqGkI5Ey+Gjhvp7DO5t33JCp7tt4gTJCo/m5WmqqKCrr2B8ESZlCR9gY3YOIPmWUU+ZSO+nDfd/G4TJTwvBU4b6i0mdNUngOfGUvgqDwnE+7F4w2AzB/8DJWnRBVZqz8znWI568wzvrSBeSmspeHY+nJ4A6BYXOQPDG5eR6R4e0Rze9sC97JKxoSRU31Vys4MwoyCFlB8msRrM/WU9Xv9kuJ9dMQKi7aXDpIDgNxxlF+UyiwONL+UVRPIbe3dIrDvLw7cNLTtEe6XFlBRcrD9oIUeiiZXSAKEgbAWMw82WCjuyKn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(6506007)(53546011)(26005)(86362001)(66946007)(66556008)(52536014)(7696005)(76116006)(91956017)(2906002)(186003)(478600001)(66476007)(64756008)(66446008)(83380400001)(71200400001)(110136005)(54906003)(9686003)(5660300002)(55016002)(316002)(33656002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3/Kot1BgdVJaFRZbfXGZD9hQ+2oUFUNAXjgCDuVhCR8XG6n40vKepZDW2qJ/Z3Hwhd7Itql/ajQT4IHB8osu0dotFlXvi8RnWpgNQkcLESmTKa7MgRC/q2XuMrLGhlvgw4SlHlyosjp/nz7diOTqVbfVTa8fEUN+khPvEoVp1HPRLN5Qs38xA/z4+eDJOSrPB/1ALK4PAmAntsYmnTWgTR0UAWCBhjeJy8qiN775uAIvpua1S1R5wlAY0n+Zjp0E82RAILicI4wjcQaCU2tVbHp5uQEcxxreMp3ttq0Y/zMz61j2Ua0uVPdGRTSnp8Th9ejOr903a4r7aSkYqeunHo7AfKXqMl52ledGdfbNiwQUd+qLH3WqacVBRkPw30vwltQ4cOw/sjNH5jRUcPDpcoOqFVfyW6Ggsm33LMmNx6YD/lqFJj0vnNf/CLYdvBleXtCbagzyRlZ/gnvzvo/rAiY1XW+Hw81ZihUjTbQFIzMX+3sKchMrtLo2OLWJZ+WL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c7bd57-eaa5-4ac2-7beb-08d833b17208
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 11:20:48.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyri9zLo9UoxTPYGq1PdoSCnsXwujPYTbKHyOFJuLd7ebgqNfMarFilyJbWZg25vyzkZ0XI53jVztnpyQiZZfViI3wWRzPXS/FPGukko5jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/07/2020 15:50, Ming Lei wrote:=0A=
[...]=0A=
> -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)=0A=
> -	__acquires(hctx->srcu)=0A=
> +static void hctx_lock(struct blk_mq_hw_ctx *hctx)=0A=
>  {=0A=
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {=0A=
> -		/* shut up gcc false positive */=0A=
> -		*srcu_idx =3D 0;=0A=
> +	if (!(hctx->flags & BLK_MQ_F_BLOCKING))=0A=
>  		rcu_read_lock();=0A=
> -	} else=0A=
> -		*srcu_idx =3D srcu_read_lock(hctx->srcu);=0A=
> +	else=0A=
> +		percpu_ref_get(&hctx->queue->dispatch_counter);=0A=
>  }=0A=
=0A=
I quite like this because it hides the internals of hctx_lock() (rcu vs src=
u) =0A=
from the callers.=0A=
=0A=
>  /**=0A=
> @@ -1486,8 +1479,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *=
hctx, struct list_head *list,=0A=
>   */=0A=
>  static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)=0A=
>  {=0A=
> -	int srcu_idx;=0A=
> -=0A=
>  	/*=0A=
>  	 * We should be running this queue from one of the CPUs that=0A=
>  	 * are mapped to it.=0A=
> @@ -1521,9 +1512,9 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_=
ctx *hctx)=0A=
>  =0A=
>  	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);=0A=
>  =0A=
> -	hctx_lock(hctx, &srcu_idx);=0A=
> +	hctx_lock(hctx);=0A=
>  	blk_mq_sched_dispatch_requests(hctx);=0A=
> -	hctx_unlock(hctx, srcu_idx);=0A=
> +	hctx_unlock(hctx);=0A=
=0A=
=0A=
blk_mq_sched_dispatch_requests also has this comment at the beginning:=0A=
=0A=
	/* RCU or SRCU read lock is needed before checking quiesced flag */=0A=
	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))=0A=
=0A=
I think the SRCU part needs to be changed to percpu_ref or the whole commen=
t=0A=
should probably just mention the hctx_lock().=0A=
=0A=
