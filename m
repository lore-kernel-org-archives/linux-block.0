Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36053C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 23:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2F020859
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 23:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UHhVNB9j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZYSH917m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfGJX6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:58:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4802 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGJX6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 19:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562803098; x=1594339098;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ALodN8WFjVJUOOoRgCiYywofiWq+x0fv/0Whw5MV+1U=;
  b=UHhVNB9jzX3xNuXQJdBh88PwrV+nWWUiLavXJdkrGOUSZnHdTV7UECJ3
   5oX6AwJXeKC2FfC6QTwwYVNRzIqxPhvaKUriKuT9FxhfWZoU7HRDqaC8m
   MKzhxLbBc9q30LIHQhYGXpEbTAys7kWB7gL16W1wxkusAa2IZNrBESCMk
   FWvB35WPcIgLnAjqetuRTp8NAtbWnFqOA+mxiqZa8lt25WKd0WgBk2W2a
   f3PEaodLR9kY81HBzxiFFuj0qAKGVmT6YBjLmqklp6s248ta0I01mj3pg
   g85FH/0Ao6Xubv59cfZijzMSIdhk0sarBAsQMx30ZWjwzXIXSFj5rIXnI
   w==;
IronPort-SDR: abc3KyVzGMOlMEH15JaYbMTlS7D3ya2/vdHBQJ5VV837/ldzF92aM+3esoqYaN4bsF9ko2d+wE
 41Za+tq/oPsYT3xbgu/3ePsWshrGbIcQJbltp7P6hghwPK8jRfwvbyLQQCvJPX31jZ1SqYo0DC
 32AmnYsiX6nEDribSms2MtVVMmHBI0PY+EeyFlNUz5EOJg2/aIS607OHgkAMvH5Wcc0g06MAOl
 OEqEfELmJT+B/a8s1V+gzrVfq+C8lzc+xZ15lUVo+Rs+22fkoPFhqQTmz0afJ+KYc39AAnl7CI
 wZE=
X-IronPort-AV: E=Sophos;i="5.63,476,1557158400"; 
   d="scan'208";a="114334321"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2019 07:58:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALodN8WFjVJUOOoRgCiYywofiWq+x0fv/0Whw5MV+1U=;
 b=ZYSH917mqtwWtTdaNcb6QPy98Fu9aggHLLnTketoYISLtHSk3lETzk/TIJM8h1G8OTGTPUmg84XaRfxyXX6gVlUUoTFeE7F2GsMDvib0I3YUhOfrggHPdWkwvg7zeePEISefpoV7tCvN8c3piZTwOCipWHF27PsW7VqZuRDJzis=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4197.namprd04.prod.outlook.com (20.176.250.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Wed, 10 Jul 2019 23:58:15 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 23:58:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V3] block: Disable write plugging for zoned block devices
Thread-Topic: [PATCH V3] block: Disable write plugging for zoned block devices
Thread-Index: AQHVNzsnjQigOjycPkaflPwYWsh5HQ==
Date:   Wed, 10 Jul 2019 23:58:15 +0000
Message-ID: <BYAPR04MB5816A8552060E715084F943CE7F00@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190710161831.25250-1-damien.lemoal@wdc.com>
 <c9b5b4cd-68d5-7c29-8f76-ad5b04007594@kernel.dk>
 <26e4505d-7de8-5e7c-d20c-3d82b9cff2d9@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e352bebe-e06d-4d23-bbab-08d70592797f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4197;
x-ms-traffictypediagnostic: BYAPR04MB4197:
x-microsoft-antispam-prvs: <BYAPR04MB4197B374F409C898872D7C11E7F00@BYAPR04MB4197.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(66946007)(66556008)(66476007)(71190400001)(66446008)(71200400001)(76116006)(64756008)(91956017)(316002)(7736002)(81156014)(256004)(110136005)(476003)(446003)(486006)(305945005)(74316002)(6506007)(8936002)(76176011)(7696005)(86362001)(81166006)(99286004)(8676002)(102836004)(53546011)(186003)(26005)(66066001)(558084003)(478600001)(2906002)(6246003)(229853002)(55016002)(9686003)(53936002)(6436002)(2501003)(5660300002)(3846002)(52536014)(6116002)(25786009)(33656002)(68736007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4197;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rQ1KWUlFtH7N2PHKhIM0kQExswka3L/A8QSlRbjnRDlCgH98mPJ24BeNyLG9RZxsc83e7yBFb5wnepg1xqcl+pMW4T/VxDkkjown/muMasIGY/+Pa4snqTqHAmFS6FBpqZB7JzQNbxvB5hX7BJN38dgZ2fcfA1N6+C9TKYitIKcIoA6fXTtTuzbOoLrfaT4+osXVDPF5lgnzzijnWgPiQ1BanSpE/p+5WTeilBJaJYLdSaCfNRcI8AiYxX7UxcQzLZvPMtmbtcpKl6H2uP7UNvRtA+Qr06OXxffVCqecfTnSVIXhbCydciSCAG0SX+3WqxeEiFpEMfJ4V2LA+KKwFt+hdh4YLoQ3icoK5SSToro9QD7K8CGC6zeY3tLqMN4CFBQZH66q3heRivST9duhBxhmlZS5fvg7s9VCvsFCF80=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e352bebe-e06d-4d23-bbab-08d70592797f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 23:58:15.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4197
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/11 5:18, Jens Axboe wrote:=0A=
> On 7/10/19 2:05 PM, Jens Axboe wrote:=0A=
>> Looks fine to me now, but doesn't apply cleanly to master/for-linus.=0A=
> =0A=
> I fixed it up manually, fwiw.=0A=
> =0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
