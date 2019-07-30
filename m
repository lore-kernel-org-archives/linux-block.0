Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466BEC433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 04:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8807206B8
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 04:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VSAJ7Hlw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gA+GiDJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfG3Es1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:48:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21492 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfG3Es0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 00:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564462106; x=1595998106;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q/rkWd76Y6dQ8rXPHJawFDuEwjLSjibo+99/d/WPGXw=;
  b=VSAJ7HlwY/hiX+EH65ilmINdtZUsdOwSr2y1dmYehpuPD20pRzRReHyO
   nhHZF4szluRpcwGx/VNzkwY5rwjwIwNPh06w5TWHRA8DAW4y200i0Gqsd
   6qwTym38KLZO1qZB/tWA+EFDJmeY8zff8u1mj93aU0EeM2J8qZ15l+HLe
   2rUgJoj1cQzROsZvxPge69fltv+UX/yuR4ItRn3FXIGRlnKkzyGsZNmaT
   ZXMXifBlEbwI4KjyeeEBoD2dJUH+rK8Uxmvf0xTbitYJ9Ds5NgETsocYh
   rZWn152o95fe+EvKvYYp7UjIEdy4T57s9oaCJVHZBxM173X1OKlRx9ah6
   A==;
IronPort-SDR: D6hEO4fPQdwwP+jxoDe+BtwEe0rpmmbKytDD55s5QdY4KRcqeLDkG/5O/j52fVQxWnJtGNqz7t
 K5F2xLM7mwWvIdomfXYq0Zh9ydhI9wIPo4uq08iGjxi3AX9aEbOGXEFtnhV2OZKbLALspWww3O
 JQSyxAqwmaZP0XWe2x4SkkkBhs6N0hcys1V5Sut9esXn/99jhp3ygZD8Pa9aINbY5QwhEmObIq
 NcQxIHCUUbcYqVf+6oYF3AeuVYaXPP6bgiJtcAgucqfVHQNObMznxrtSAlamTy4UsDQChqD04P
 k4Q=
X-IronPort-AV: E=Sophos;i="5.64,325,1559491200"; 
   d="scan'208";a="116045301"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2019 12:48:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahJvJthtlEVtnm9/NwYnlO/YBmaSbcv3v8CV6mfWoEyXa4hIEce4V4d9du7rfH8gK0eb2v1QPS+wCvhNsHmX5fvaXnajDStmyEAahPRKdUDPrjoKt4AvFkY2XnO8gwgUbhe+smBnXdpjCokSsuAdqEEm26cU+EKskIaFnIQOPX2AH3zinAKuaiiXfK2E63RwiAcV3xBg3KARUYfVAXFIG/WAI1Le+E/vRLHgKUzuL2+lvoin8kBmF+q2j1YozXHaV0gJsm0EFN7aBX9lZKYCjAj93fZ9xYgJ309BQFrWkHcyViTF/Dx2AuHp+rbjuxmT9Zzk0+twpfTvzMOonsEgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9oY7hw2vJj7+qLA98d3xbhN4vTkmbrDSlJrvSfhmeE=;
 b=B2wAFSk+va8A2+5dmHvPa6+QEthN6M+OAsOGsH+AkuWHRCoR9deUjIe/piFrxiuBqMRq8Wb3n2QI5Ep7BJBq0LDHhnpgBZuvOrGzYTuNXViaTbuwiHFF1nat34wJnppye8CMTs7WaTDumriMEvYTl4GFG9F4qmYc/uEjVAmgZHQ1ELEYiinxzJF5LWonFSbOxyvPaKp0v0xu7em02of1xbb1UZ8sB3WXYEd4ygGFjb35qoFwBA4QUMc1M064hLlyrAQ/pNMXAy3IC+38Kypu5WhD26rueR87n/XM5d+9HYz0K0X+CyM4XT6kjIA6cndHZ7yPG5ImOs1Cz3Tunm87nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9oY7hw2vJj7+qLA98d3xbhN4vTkmbrDSlJrvSfhmeE=;
 b=gA+GiDJ8in5sI94xHad6JQcfmgCrHzB4uBK0D4LdFSB6WC0Y5FhgNd1PNsc/1Vc9G3Cr7EsUDN/BGLzTWNNBM7UmzUNl9OaucwjMuoTRrmWS81ZO995OEApZ91CBpXwpo6nSR2wBaFkZ+slDmZz9UPAksPDVTFqJEMFckk+7bQU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5301.namprd04.prod.outlook.com (20.178.49.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 04:48:24 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 04:48:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/8] null_blk: add module parameter for REQ_OP_DISCARD
Thread-Topic: [PATCH 1/8] null_blk: add module parameter for REQ_OP_DISCARD
Thread-Index: AQHVOBGZHWkWPsWDJUuF0rqYYzeQGw==
Date:   Tue, 30 Jul 2019 04:48:23 +0000
Message-ID: <BYAPR04MB5749C04B18617C18B1BF64A686DC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-2-chaitanya.kulkarni@wdc.com>
 <20190728060432.GD24390@minwoo-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76152b19-2da6-4d28-b54d-08d714a9277a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5301;
x-ms-traffictypediagnostic: BYAPR04MB5301:
x-microsoft-antispam-prvs: <BYAPR04MB5301B4D2B1A38CD12B8D203E86DC0@BYAPR04MB5301.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(478600001)(316002)(76176011)(186003)(99286004)(6116002)(6436002)(6506007)(53546011)(26005)(9686003)(66066001)(55016002)(3846002)(305945005)(54906003)(14454004)(7696005)(33656002)(2906002)(53936002)(68736007)(446003)(229853002)(86362001)(66446008)(52536014)(6916009)(76116006)(476003)(102836004)(486006)(25786009)(64756008)(6246003)(66946007)(74316002)(81166006)(71200400001)(5660300002)(8676002)(71190400001)(256004)(7736002)(8936002)(66556008)(66476007)(4326008)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5301;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p0cFcr+7Iwe5VtfMYq205WYsOiLdNW0EMYkg1+hDqnXWpnEbyBehV01XD99aEZHij6KhTGatoINesRpCXVV15dW+rUtI0ZzZ35CzZOiOEVcUo8MzXzRfFBHzRDj/U7BNYes2y+y6yUfTRGITgwbrW+zwXTQTQMXLXjpSzrU8yM84OwCtK5Onqk21ufvalDtYk7QOuXRjuIRUQsz8Z6arg0gf1LbOg2j3lyll7mI2lS6h9K9TF2UKvmqurJTsMkZCibnBzACc9jOIeiVCELKdbhfbSpdVov6ATnHPI/GfAORifMN10yksuDEWCn1NsVZi0kITexaUiygVAURGc7c5y+VB4hB4KkML1eHPS4zzdaQ9GeY7ySOYFIVw4SvN9HidEGD5y+M7Y67WHLbM8PizSUFFEt/ECd0LfIRhT8KUXBI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76152b19-2da6-4d28-b54d-08d714a9277a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 04:48:23.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5301
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/19 11:04 PM, Minwoo Im wrote:=0A=
> Hi Chaitanya,=0A=
>=0A=
> On 19-07-11 10:53:21, Chaitanya Kulkarni wrote:=0A=
>> This patch adds a module parameter to configure the REQ_OP_DISCARD=0A=
>> handling support when null_blk module is not memory-backed. This support=
=0A=
>> is useful in the various scenarios such as examining REQ_OP_DISCARD path=
=0A=
>> tests, blktrace and discard with priorities.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  drivers/block/null_blk_main.c | 7 +++++++=0A=
>>  1 file changed, 7 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main=
.c=0A=
>> index 99328ded60d1..20d60b951622 100644=0A=
>> --- a/drivers/block/null_blk_main.c=0A=
>> +++ b/drivers/block/null_blk_main.c=0A=
>> @@ -3,6 +3,7 @@=0A=
>>   * Add configfs and memory store: Kyungchan Koh <kkc6196@fb.com> and=0A=
>>   * Shaohua Li <shli@fb.com>=0A=
>>   */=0A=
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
> Maybe it casue other pr_ family prints "null_blk" twice, doesn't it?  If=
=0A=
> so, can we have this change with the other pr_ family updated?=0A=
>=0A=
> Thanks!=0A=
>=0A=
Okay, I'll add this in next version.=0A=
