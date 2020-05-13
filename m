Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C5ECA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AE3206CC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R792OPu2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YqkFpdkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgEMMCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:02:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30598 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEMMCO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589371334; x=1620907334;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZnzmXfIbjMfnaE8Z0yW3v1EYK9+b7eBaJACHrwcEP/4=;
  b=R792OPu2der7MAoSSEVTq07r8NM5yx2Xu+f19ixjz5I6yXywKoauItmb
   qA7OnF/zKhOy9tNrVguONW0MY7puri++PD1PHxsb5ivp21E8JwLgwAizv
   eGkIti8wMQdKQery+hYROb72eHCIN371/KTYXbJ116y1fPkGLZxc/3ynT
   2AXRgXGReB5+wEi3RZDp7udQeA8LXqx+oljtK80P/F855HgTnQZOkMjpa
   ILZV+KfRUNCD5q/AMEYq8/Y7cco3m1csFpnckMOrDyGi5SZ8uD/jt40uk
   v6jY+fmyO56wpaAldn1H2n2oB9kIpI1gKyDdBJB3e1xwtXXsU08j78MGS
   g==;
IronPort-SDR: lmUQYtGbwyO8CkGo2sDIs8KuAeXjsf64sR0NzGvxtKOBq9kMQdiuRSVbZu98yizwyeHNZm4XSk
 jPoN9pJLCzN+rpcg6N8K8P652s8Ty0dDHtGtQeGv5jxTttE3l4svEHz+KrMdoANed/Jn0a5O9M
 b+ArFlnpTZglbjcvDNJ/LLBf/RD3O8yOjDv9ppDHTmfWgCRDl8pX0GQYdTKA/XHCvR/EtJ4Ppm
 2uQURNpt23vF2Yo4N4oLpwMjuBF9aUvnJRq/GXHxvzUmY6Gmjzam+4RqEZnpUYn9kY/9LL6Xg3
 nS4=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="139009082"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 20:02:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja8OQ+M/OlYJ7sGAzXFJPKikPvSWYSpWoH0eeS+IbU7oYJI6/TfDZXvwAII0wj57pA/yjScwMqHdAEfs9ZjIXTfWTuLlsWn74+X6lpQmlo9onutroqslouOLkvUhntNDwCOStmPi1EjRYPRPQ/6Z5ufQjO2RySHEh7/wCvGiG+qG3ZnBr0HDWNZfrJYbmGdlcUF83pKvH3d1cy52S6/PrL2Bgw3LbMVmpdqYA0ylK1xAG7ZqfP4ARu+D10CJiI3srDBcSWcClwyw0BIYKu2nse/en/1kHenLxKddhJKqoGKYks3dIaHQWEwTQh1Yj+A8CdeOn3q+QEtU+/lOAoRzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5+ckyyFkZKYFrx8MjmtL41qnBBFzAKX7BvvwUroQMc=;
 b=forjEUf209CGpzYS22O4o4nMyDaJBxBqM3VOtx8R4tePGg5YJbchBqhzfBICVm2AseYgd4mqKE8NrNX8u+C1uWs+THAUIqGQN6NLARTWsDQoRjB3qs9MHZEFOWCXZtcz5j37WR69AD5qaTXgG3LjwWC1qauYJkxOboOVxVavD1vsgGKIdy15quONNP9oPgnWT0KboUjtDGW9c9wwMTfIf2Ij8rMsiQpH1zqgdS06hBJSuVjF/Y39hayvSIJ+V27QEsJvJV7IL/LzLzy03czKf5q8LUY/0z0gTKdxhfOIWdknOhwOb7Ft+tw5mPKWNDLMbpAONBKmrxrHQw3wuGA+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5+ckyyFkZKYFrx8MjmtL41qnBBFzAKX7BvvwUroQMc=;
 b=YqkFpdknfVdlrez6+CzvysxRlGzppPFOo+/m8t+9en7Mao6umI5AEy/U+Payz6/kbkPOnPzWdPw5P4LpSLQ0UUoY/OpGL1h0dFmAIvXwnKC/DtV9ewEDBPMuCcw41bhGSVrp93ku/cO59WGwe2YPrg3GDwvK5CqSneFOioiiRmo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3584.namprd04.prod.outlook.com
 (2603:10b6:803:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 12:02:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 12:02:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: remove a pointless queue enter pair in
 blk_mq_alloc_request_hctx
Thread-Topic: [PATCH 3/4] block: remove a pointless queue enter pair in
 blk_mq_alloc_request_hctx
Thread-Index: AQHWKRZNbHRQVDRRtESu3zpKwUKpnQ==
Date:   Wed, 13 May 2020 12:02:10 +0000
Message-ID: <SN4PR0401MB35981F543497561896B564469BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200513110419.2362556-1-hch@lst.de>
 <20200513110419.2362556-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b0d03b5-bd65-4dcd-5686-08d7f73577ed
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-microsoft-antispam-prvs: <SN4PR0401MB3584F58DCA9381323E11486C9BBF0@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N+hzcjhn2QNtqrkyDRwJg0InGCQ9gg6K5Sphc3bTxO3ku4L8L8yS/fleBaZ+uWyIqkqQ9d/30kvCHQzm6UR30tAAqj/wqNGz0vse7O4oiawjxqIRXAp/s4QTAOTEtkw6uSdxRruBEMAh1da6sXXBoRBHJMZMlwBfz9YBt+YbDyZs1YsPMg74Rbfa4gnRes7U6YL9uAaq+du2WhF/lxsvXuci5ksOG9wZahhquECn9Fjbldqkcypf7TWOalZh37i/9NrWlrzrZpiX7owUG0TZ0uV8Fo39WFqf/12c6v2aADD9tW3b/MlB5DCD+RnHFYq5Dh5q8rbpTS7IPHl8/hfCGsu6/l3fSMPXqvF0AupXE93o9KHFXYH6waeUPkg03l60EkHxIdu9qfCQO1lp4047H1/HMkZObozZoJNlG2QMbjJtM2mrya8jSPL9EzF93b9nbVrKpexjvGJZHwuBN4FU9rnzr8gdNEVUfORLFmAum4fPkmEp8JcjsQnFwQjTHaPl9D2Aib5Wngnju264hypRLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(33430700001)(66446008)(33656002)(55016002)(91956017)(316002)(9686003)(478600001)(86362001)(110136005)(33440700001)(2906002)(71200400001)(8936002)(7696005)(26005)(64756008)(4744005)(6506007)(52536014)(53546011)(66556008)(66946007)(186003)(5660300002)(4326008)(66476007)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Yti5z6reLXym6PigBZ4IFgrA2mgCGotk+GiKnwUZwOQzAS1mllbp4HAm2YFuicNvuWravcfUwj/DBAClk8vglHwSTteTi7LqZuRHKnbG2I5/DU59WeXQFLbMBr834AHcHNGzb0aDnDdIvD8ONUgnz/4edIyWC3rYAZ0IG8KLUmcCS3HJB4W7ky3l1ymWJt+hGS0bwdNwB+/BbaOO+p/FnXJhkMYU83cgKMJnEuasmxoVBC1Epkww5qblJta9wrWIpl7QSyhQGpd2QyRDRIgHe6F8Me0ZH8JFH+AWf3R303HJbazP8jL7qKlVV0S4AzP8VL+6L007BiCfWPwJB2p5hCyRvdZpTv1ZkGkdcggIqBKiEQ9iIfcMqMjZoB8otQu6moR4dIgbWw24xMdtNA/acWKBHCmnqqH968/qYj516Uhsug0ONmn3cR4O3tHrs3p0d/UvTQnWvBGMcGt1SujuN9QJi7nuIPmeqLbT0tI/tH2SB8dcmgGoPaqZW2vQfo30
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d03b5-bd65-4dcd-5686-08d7f73577ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 12:02:10.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIw23q3WyWVj02F2HW9o7NWycDQIyKBcujk1t7pnHLOipjqKGSrMji6FsDTJ5QX0YAKM608YneeWzuLjRtk7O17Ks8LunlJJ0JAwxKuXFWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/05/2020 13:04, Christoph Hellwig wrote:=0A=
>  	rq =3D blk_mq_get_request(q, NULL, &alloc_data);=0A=
> -	blk_queue_exit(q);=0A=
> -=0A=
> -	if (!rq) {=0A=
> -		blk_queue_exit(q);=0A=
> -		return ERR_PTR(-EWOULDBLOCK);=0A=
> -	}=0A=
> +	if (!rq)=0A=
> +		goto out_queue_exit;=0A=
>  =0A=
>  	return rq;=0A=
> +out_queue_exit:=0A=
> +	blk_queue_exit(q);=0A=
> +	return ERR_PTR(ret);=0A=
=0A=
I know success handling is discouraged in the kernel, but I think =0A=
=0A=
	rq =3D blk_mq_get_request(q, NULL, &alloc_data);=0A=
	if (rq)=0A=
		return rq;=0A=
=0A=
out_queue_exit:=0A=
	blk_queue_exit(q);=0A=
	return ERR_PTR(ret);=0A=
=0A=
looks nicer, doesn't it?	=0A=
