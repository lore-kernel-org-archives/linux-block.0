Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E621C606C9
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7AA2086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 18:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F7TaalQP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sWN/5kc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfGHSuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:50:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51538 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGHSuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 14:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562611804; x=1594147804;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rST5XtYYzjECxnkKVAqUnjUvKpHGltzEEbbJcGj31cM=;
  b=F7TaalQPjh6x1oNZqIkR/sK6fUgc9L7PjG2pqKgwnCwAGsfKOzebQizF
   Qs3QfPfzLaR+eyPK9WBi2IviVMxHSH/LuNaWotTLoSuKKEsHxmec+1xzz
   Z1+5+CEik7xMLUe4Aps5CUIBWJeonaNKb5BL7JMABsD5RyQIPNhyPQ3Ef
   9VhsVOVjZhzk4eGv1pfinM59VCMYcptQ6+mRa4RMkfsGfdnfn0aehqa8D
   MUIZx9DZxe9QeQ0jMFqvUPC3H3ELWnGHbpWEmiCRGN5qCSibsETJIS1Xd
   QTHy/qFupMVnRLyuOdV1zoin94eyC6nI0x4u70S6GSFLAOqN4oM9NmUEm
   Q==;
IronPort-SDR: 3zMbtjeW7EbLH58MixpHqp17AFZq1Xu1MBh6oOxYa+RdoUuvnmPfjIsbIF3Tn5wFtqtWc3Puz7
 18BOfo+XQhiqC5MiFqHrcbcxdJb2SnFZw/maDHSRNxxrbB2lL9QSqP6OQ/eZTrQFN363GU6H0l
 Im0X7UwSAEfLhxCMPcXfW5RNsQgQw6tZmZSb3Uv+TW0Nl0VXGcY2YdxhPrkNBWJ3zuigY3hhVY
 APLHUET5W1vERQP5jLs6T95XWLGkUJArlg1tVtrGh2F55sH/zXtQPsh/e2fNECe7tnS5av4ioF
 7Ag=
X-IronPort-AV: E=Sophos;i="5.63,466,1557158400"; 
   d="scan'208";a="113649593"
Received: from mail-co1nam03lp2050.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.50])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 02:49:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYrAhknFJrfgVH7tUTas/304tMGKs0DIRpYx1FvCIZo=;
 b=sWN/5kc9MS4fu+k3ou+ky2rZAayjroNZXvg+/zB2dZkpSK0P3lfBQGgmGL7C3yMDr18c19aHYhaLlPcNSJSvbA9pYLIV4EInTAv2q5c2MgqlWWeH0OkJvuWCFCeCqkS7QwjGo8aprEsaMuz1KbSULKnpPWIuGMTMiC6rWCGROGg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5079.namprd04.prod.outlook.com (52.135.235.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Mon, 8 Jul 2019 18:49:54 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2052.010; Mon, 8 Jul 2019
 18:49:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 5/5] Documentation/laptop: add block_dump documentation
Thread-Topic: [PATCH 5/5] Documentation/laptop: add block_dump documentation
Thread-Index: AQHVMFgWWE5bmQUoIUGPWjB0oh8vEw==
Date:   Mon, 8 Jul 2019 18:49:54 +0000
Message-ID: <BYAPR04MB57493225F93F43B6271DCFDA86F60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
 <20190701215726.27601-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a41eb6-a965-45c8-72b9-08d703d51133
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5079;
x-ms-traffictypediagnostic: BYAPR04MB5079:
x-microsoft-antispam-prvs: <BYAPR04MB507971BCC432BD0F4E190C0286F60@BYAPR04MB5079.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(9686003)(55016002)(66556008)(64756008)(2906002)(66446008)(66476007)(8936002)(76116006)(73956011)(66946007)(71200400001)(53936002)(71190400001)(33656002)(229853002)(81156014)(8676002)(81166006)(6246003)(6436002)(446003)(256004)(68736007)(25786009)(52536014)(316002)(72206003)(54906003)(110136005)(478600001)(99286004)(486006)(14454004)(26005)(2501003)(476003)(7696005)(7736002)(186003)(5660300002)(305945005)(6116002)(74316002)(102836004)(6506007)(53546011)(86362001)(66066001)(76176011)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5079;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e3+Yd+M84TMfEYFpT7yT9FhDWjqLr+RGRnANBARTrU91cIC+3/t+ECJQweVwJal3MlpClKy4iAkhYhMoy9+ojqROuBeZHGtDuxquGR3XTYnuuvEFxuyrdiLifGQWhe9efKP2Sj6r2DefXQW5dPiAB6eLr9WEplxS7Jt/HXq/BxG8CbgGfrS4OOY12S+M5zWnxiO4+MAhikg9BV7SYCFsc3EurC1ZQAbGwcnwELqZHTKiJfIwG4PyC7s+XM+U3O0xFI6Sz8nDWctDplinjBFy7t/HdzQt6n0XsM6m1bwbYYWSNIhpCMXIVQXOE9eJEDDWif4nBTp6peMZ2h7PZsjpQ2W6+FNfW+zW9WfXXqQSrlZTpsZ4fHTAeT5IhmlTxd8Vyn+wLA7qUn2dNRvF2bNnqY2zEhX+ioLhJWN8pXm/9Sc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a41eb6-a965-45c8-72b9-08d703d51133
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 18:49:54.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5079
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can someone from linux-mm list please provide a feedback on this ?=0A=
=0A=
On 07/01/2019 02:58 PM, Chaitanya Kulkarni wrote:=0A=
> This patch updates the block_dump documentation with respect to the=0A=
> changes from the earlier patch for submit_bio(). Also we adjust rest of=
=0A=
> the lines to fit with standaed format.=0A=
>=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>   Documentation/laptops/laptop-mode.txt | 16 ++++++++--------=0A=
>   1 file changed, 8 insertions(+), 8 deletions(-)=0A=
>=0A=
> diff --git a/Documentation/laptops/laptop-mode.txt b/Documentation/laptop=
s/laptop-mode.txt=0A=
> index 1c707fc9b141..d4d72ed677c4 100644=0A=
> --- a/Documentation/laptops/laptop-mode.txt=0A=
> +++ b/Documentation/laptops/laptop-mode.txt=0A=
> @@ -101,14 +101,14 @@ a cache miss. The disk can then be spun down in the=
 periods of inactivity.=0A=
>=0A=
>   If you want to find out which process caused the disk to spin up, you c=
an=0A=
>   gather information by setting the flag /proc/sys/vm/block_dump. When th=
is flag=0A=
> -is set, Linux reports all disk read and write operations that take place=
, and=0A=
> -all block dirtyings done to files. This makes it possible to debug why a=
 disk=0A=
> -needs to spin up, and to increase battery life even more. The output of=
=0A=
> -block_dump is written to the kernel output, and it can be retrieved usin=
g=0A=
> -"dmesg". When you use block_dump and your kernel logging level also incl=
udes=0A=
> -kernel debugging messages, you probably want to turn off klogd, otherwis=
e=0A=
> -the output of block_dump will be logged, causing disk activity that is n=
ot=0A=
> -normally there.=0A=
> +is set, Linux reports all disk I/O operations along with read and write=
=0A=
> +operations that take place, and all block dirtyings done to files. This =
makes=0A=
> +it possible to debug why a disk needs to spin up, and to increase batter=
y life=0A=
> +even more. The output of block_dump is written to the kernel output, and=
 it can=0A=
> +be retrieved using "dmesg". When you use block_dump and your kernel logg=
ing=0A=
> +level also includes kernel debugging messages, you probably want to turn=
 off=0A=
> +klogd, otherwise the output of block_dump will be logged, causing disk a=
ctivity=0A=
> +that is not normally there.=0A=
>=0A=
>=0A=
>   Configuration=0A=
>=0A=
=0A=
