Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFECC433E1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9AC208DB
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NzywnR9e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bcd120Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgE1I0u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 04:26:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30521 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgE1I0t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 04:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590654408; x=1622190408;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E6YuUXbH+1eh0qCrp7GYmUjVHYfZSBHsgNZtuNW7PXc=;
  b=NzywnR9ezEgwbnOG0nj1kIOkhTYSaq9Ziz0Z/s4kpFi7iCqvIwzH86nx
   jKelvXENRwqDCtBhJ26KWZ119KnTnMxgJ5c0zb3X3WXI72aVH56plYOBZ
   CavNKs1ts2wB5xMhP34GtOGBf+0DqY+JPUNvAUTgZBudCh/qKqa5EJupr
   5Izu5Appq57UD78TSR7NTzc1q9Zq96hPPE6GR6OS7XcX743qv/0P38ty5
   jNBmY+dgmYP53uRm3XzlcybbwvsSrp0L5wEEcWddOUUO9yotXOZmWxA4A
   NuRheRJT8xP67IVwYAdp67sogWlAiAsWq8/P5qFgglysqWBc+N4gfWsNs
   g==;
IronPort-SDR: YctvxTecx+QLNfUq2bJ4A/vX7ge9B86JaQkYS5tNJld/VySeJ95zxOdbrqwM7stSpsTnpzsvB9
 UF+a3ADMHPAki8ZVRBoOAjLjZWV/11u1lL7JEOSO4zUQ9q/MnzWNGBmLz/twug2MjTxQasU6Vk
 V7V1XFIZiMXRxnNt9vrCdaIuSRrGssUBRqtZbe5pORXeVRMgOTtlCZql7yuS0uZBqqlfxDqvC/
 M9pxb2AM/iFFcfn3kVUSOW8ARPrK0QGD5qQHqJnCHa8t9cZ8iPRuWswyq4BX8Kiu8YSQS6hWlV
 cQs=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; 
   d="scan'208";a="138687082"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 16:26:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YadCABcx1sRPvPOQ+iWvs8l1t0Fj7YWAngttwkTj1DKw9XtFYsxM7McPomRydFZE7BDwL4pNg0p2kiyv116VMS814QZRa6CO8RBwXMM2r2fopZPXIfd5QUNHU3X3iKf7AO2tDoB51tfIrvCAA5vK6Jw2jYhsvJMLOB+YIcqCGY/NxDb1lUp3tWEo5BEdQAumWMbqTwZb8IOgD4+mzLpgzTg5ju17kKnz6ZvQcHrQJ3GMcxj9bhKLIuoaLTddZvGIXbpi2KHExkRqEAJBinTI5IkTZwHfEuFH1wsSaZYiYHyt4gsryFs4nwxILhYMRPan5e2y5M0jfzdtc/Qpw2nz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2lkjChe3EYmR9HYCWU6oJauhDhaaRkjmpxxMnv+irE=;
 b=H3j7Dbnjt2LlTdYtTTboXGId5Y301ooVsascixFzH8UpnHe9TBL5KbukqBi4rrFpLBP2fb0N2JYSXcv9ofjfAprnA9yar4oRKmq5pFhTbWjb3ajEjdLORAkfIyKdNRzWLDND4PfRjkeIW0XoHinQNr0NLTisENv8e84/bkbug5HT5GqMEmM5iCnD8aEmo3Qo+7J/zRcjLfq8kMFU2haZKMxGE7P5QeOC6I3gHkegGuc8eAK0l3CWv3E95+TKfnYr1tH4zjlakZD8dicDx0GGCVR+8FmIr8KWt2GzMfU0V2MUl0pfNrhSdJmIC5BWSADdrWZj9W/4rM6SLTYBEvNsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2lkjChe3EYmR9HYCWU6oJauhDhaaRkjmpxxMnv+irE=;
 b=bcd120Ee0i9Fphdd2Fb3OJ51K7xO21oUtHEiVRE8jAmjgOcoC2vjdjeGOw2xc16g30Vuo6DMvRPmsvzJRLt8mhTzm83HkA7Bk90KBhWey02WNVc4JexpX7k2MvaKt21DqRSfM+lA0imaF/nfHeTjPtlisE9Gfkfeqi+lh9jF7t0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3536.namprd04.prod.outlook.com
 (2603:10b6:803:47::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 08:26:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 08:26:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
Thread-Topic: [PATCH] block: Flag elevators suitable for single queue
Thread-Index: AQHWNMezYzSAX16QAkK9TfQQ6T/8FQ==
Date:   Thu, 28 May 2020 08:26:44 +0000
Message-ID: <SN4PR0401MB359826C471B9D331DC79E4EE9B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200528081003.238804-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8ffc368-cb8c-45f2-6f03-08d802e0db6c
x-ms-traffictypediagnostic: SN4PR0401MB3536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3536930AB4E426F3EB4DD3F89B8E0@SN4PR0401MB3536.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfi9lnl9KxkT0uCT2X6YdSZrGK//23CIA1fFxTIOVgA9Ue9zXZIYuYC4SyGThbKE0AngYCV0bQIr2FprRPaCwvQaVbf7+e1KOnhz13z9xwSsSdCJqEdV9ZpFRjquJOt4j4+lhnhpoyYYm2p6eqAcvf096qHTRZSICZHKSCRpdonTcXPqDoCWLW6EXdfOWR0u7ORSgPAs3H1uolx5LYaUZa9xJrO5fCUXt5rAq9E14XlosLZchJknbXe8LtQaUCGKwNl93i1Nf/w/g/2DydSYxDOhW9bJ5kkf9GILCuqdiYrXcAhWTegtIesuvQM5cn3yh7Q0YYmxFLpwg11pq3Fg1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(91956017)(55016002)(7696005)(478600001)(83380400001)(186003)(86362001)(71200400001)(8936002)(26005)(53546011)(6506007)(8676002)(66446008)(66476007)(64756008)(66556008)(66946007)(52536014)(9686003)(4326008)(316002)(54906003)(76116006)(33656002)(4744005)(2906002)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xR83zqY2gmdKa+eyio2UcHyp2ljq0a03lgZCGPfdr84Fq3vPAoZ1O1AP13HUBhogcuxIXnYG1HmDQPzy6kAWTIrqq6jZhrg1w65fUNd11BJrBvOhAo81wgeGbinx6RgHjNZAeLUNXHyELU4MNNSW9qqEVmadSttBOnG/a29R4VmxjzYNYc9+ZANr2HVfq0e8uHDblxLabw6TInGGEiaRJhbNvJmevKZV4SWucMA9nzlfmwh6koGzvf29VYxq54JEBQ2joXnZ0lGh8XkUgcLvcIJSje7TbAB8T8mlORir/iUHvJ/SqkTy6gipDAlbVD/v4361+iCF06b990+RkUwo86aP3tEgQSxp9X0fMfYJD+NlAqjV4TwiJ/Begv9y2oNaHktBrLEEJQyWI/i5QWfcQfM+xwTq18ZTX3Ys3MDn6LTtkUqa+N9O6iHznkOy22W3pj8OEl4xCPMjsFDdpxgykHv9+PA9jjk/jhWz4Vu1zHe0bJYeefimcapvWofkpXvH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ffc368-cb8c-45f2-6f03-08d802e0db6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 08:26:44.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkuZdUfIhco7k8r4YNQWju11SUkOI6eKadltjJIoDnaXIj5MHkQ3NT6uIAxe9+gmlfW4RojLcgxFC9CuBbl6+E6uaTageA16iphz5NuqUuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3536
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/05/2020 10:12, Linus Walleij wrote:=0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index b490f47fd553..324047add271 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -794,7 +794,8 @@ static struct elevator_type mq_deadline =3D {=0A=
>  	.elevator_attrs =3D deadline_attrs,=0A=
>  	.elevator_name =3D "mq-deadline",=0A=
>  	.elevator_alias =3D "deadline",=0A=
> -	.elevator_features =3D ELEVATOR_F_ZBD_SEQ_WRITE,=0A=
> +	.elevator_features =3D ELEVATOR_F_ZBD_SEQ_WRITE |=0A=
> +	ELEVATOR_F_SINGLE_HW_QUEUE,=0A=
=0A=
That indentation looks a bit odd to me but for the general concept=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
