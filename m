Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91716C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 23:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AE8207E8
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 23:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hqtfypK8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FPm5+q99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgGAXjy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:39:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25025 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgGAXjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 19:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593646797; x=1625182797;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=e35h1BWpoPJ891JnwqZ8sAZ2xKs69/MRORqSQZFEnh0=;
  b=hqtfypK8+MKu2PkO8bXDulPGBUpMlic9+efcFVlxS4pg08PR23xgBUEu
   JUfhuaQNywmcqYMQkS7ngtI1kUk13SRUD0zI6pONKLZHeWT1jh0YlR3ns
   eB7jJh3pb4nLgKzaTugnPhR69YP0WbnXQc0EpcVYdElBQsdIpyaGTGmwO
   rRIa2/RcU8dUi1+xCrP5EtbDGKtbxtXr+OZA18HZP1pyuw5OIAkNIfVpw
   tB7Kh8M187bkUvMT3FgwMzsgjXIchO7SG3hrzrIvCE8rtP3M+9CsLgNEO
   TcuP4zeZzMDXtxLu8uPuu2F/86OVN2qhuuJqJVIaBC2CnHIX8c7512Ssp
   A==;
IronPort-SDR: unLtmBssNFykHSCJt9JxeEX0VVb9gZXOorM2cKjwFQguJyiBc1VLSM43drptMn1R461mynzNAz
 KnqNK9pj+fa2RiHGNAtPJtBfCJ3d3LoRZiNw90SEik1kDZAF/Gy2rxXJ6oy4vP7lR1iGqDBFSb
 p8psHZ6yAGue6wlJdpQfHVd1fg1zAwIvN0r/ruaCThVwG0b1I3z2yPrii58K7TIUupAHlF/ind
 WpI1t1yxzL50Ww8fg9IbcjRwJ8eNWWbEoGbv5mNk1iyChK0tH/so19hfPv87jktj4OEBxU2KQm
 gPs=
X-IronPort-AV: E=Sophos;i="5.75,302,1589212800"; 
   d="scan'208";a="244448302"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 07:39:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOk4gd5rKzwaj+lgs+G6m9CVcW2W1svhTs5nYG7mP3vqSU0pqasx2hfDKyJLrxxjgaGU/l/boQ3T+zrH/izLmE18Z7Iha2IkQNOSbEiwU9VU+wqLotULRf2W421Zryi9vTzxAx7VVMa+puInMbQ1/+zipSaAi+tvxc2og+G0YV79hflZR5+UaFYFd2US45RcWzpMqZGmxrXVjpNDyoprA+tAEg0klcCnTwyuZFW7VpoaPAJFZtdhu1RfZH9zRD8uE/lnHQHzLJ3TDVLhx/IPKWygcJF0kqnBydUqI86TVesHs4IMpk44TlZzwSI6XwIPlCE1moNSmXi5k2dDGm49Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e35h1BWpoPJ891JnwqZ8sAZ2xKs69/MRORqSQZFEnh0=;
 b=kZ9ewQ9Zv7Q/ockcn4lTwmF4criT64r1z/fEWbZnGwI10ExlVsDfGLCRpdAaVMIlZ9y07sDSY9Tp6o6fW4OFpJqdxCCmB/WK+Jszw65kcobIUYBUmtfh19wi58bB9CVp5gt7YH142s6Zn7nMiM9P25VYgC/s1CxEHT6AkPWZw4yaTOgOk40Hm5PBvPgmYScPZ/7A48J2qEOuKxoA5M8X3fN6SfNeXJ4JpMQeWcJ3S9Zn5R6AuypIcnZqEQrfmYOsL+iTlmEhwwGM0JCfUyvl+y2dQvur+bCIZ1NLhuDP5uwlSjNjQM3RGEokqun17dh3+NLUi4bqhKHBcrlaDtgSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e35h1BWpoPJ891JnwqZ8sAZ2xKs69/MRORqSQZFEnh0=;
 b=FPm5+q99pZGY+eHtmHnQWNfIOaG0UpLOcCtt66B9BWmcOK+Tn2+VJ/Hwml44BgXD5ILV1Yfysh+/KUosoE7jIiOkN7BDwxdVdhudDH9u9zSvlweXjOtshyLofGLsj7W2I2KFqR5aWWX0kCeq944nUg/qk31iYL2fHYlHNPvP7vs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6852.namprd04.prod.outlook.com (2603:10b6:a03:225::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 23:39:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 23:39:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Topic: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Index: AQHWT1/biaZTnaGKVkig3mq80wjSXw==
Date:   Wed, 1 Jul 2020 23:39:51 +0000
Message-ID: <BYAPR04MB4965EBC788D1A0BFB3A4611A866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB3598CBDDC91C894992996DA29B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB49657173EED97FAE92FEE156866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <812af519-7bb3-586d-14dc-d3a529b49b69@kernel.dk>
 <BYAPR04MB4965B21154FC796B1D4AAB07866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fe505644-0cd0-0fa4-3dc9-aebc3e299660@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 224ec729-5f96-472f-8723-08d81e180ccd
x-ms-traffictypediagnostic: BY5PR04MB6852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB68527DADBA9E9D1A87F3409A866C0@BY5PR04MB6852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHZGTuvZDn/8j6nbSmNd/xT4qVBseTa6KwcEdPXySckysD/Wp9LTRcojqugZGvMsUMXR5hIyk/wmItjgVqnOjA3I8LdfxNFBae/okcYWxn2SjRUpDloymBIrBvFn8342ytpSw+3hngz+gWNyZhinm9EjFvH2VlDtmjz9wUYiBqpdb+ZHaTRmeY5Ndqu77DIDKYhtKjY/+GzvVcx2dDfNZDkPAJZXiP9FtjYE8aAs41e7q3A5yZYBNu6ecQLmkQlv9Tpwwqk/GkyA9iH0IvtzmZQZtklq3b+IlryHJY76480ccZlT+KvtUmNum2yyuu9/3K8slezxaAyfV2mXKg7YHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39850400004)(71200400001)(2906002)(55016002)(5660300002)(478600001)(33656002)(86362001)(9686003)(7696005)(4744005)(4326008)(186003)(66476007)(66556008)(64756008)(66446008)(6506007)(66946007)(76116006)(54906003)(6916009)(53546011)(8936002)(316002)(26005)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qWYoSdJRs5aM3Aj7l7LnqzgEqkplO+lpFKwuevzUGBdHPXfjRlgKBFIEpnEsDbE3jWPHCfdIFVsMCVd2PHYRg92FYM/P7xo/DiDiTj4tcJ3HAQz96XJ3cfLgFHW1maCjjMKNtYQin1KEc1RDhXD6qEQBv7dx/HmQjeft9HNbxI12scA7DgtoviXdIFAdm9j9lUGIQX+/CjaQQbgPUIuoGGQSoWT/mlE6IOCAaStJ4MKGryKvtgcwwp3w/tdoL6e1nOgIh8v5VAFC25QWxkuS7sckI3O9tprJBFrtOwJdDF5886FRfUilDIkSm0oD2GVOK/SMMMD+X1y/KqAv6VXmKHobO9GwKtYVons1hiIF7JfUZo1m3vS54jelL2+hPHX9JmWjLp+t4EZrWBVR3lSr+Efw0r4FBkQ8DZ3hXIAyV0iYlu0o8yDf4TMy0HcqroJWdBts9JZRuGxQyNN4dUToH+QbAcmhRDqccbe7c8mHRT+zQg05cDRnJeaIJT1YLmPj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ec729-5f96-472f-8723-08d81e180ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 23:39:51.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaekbZknSWkUSJFsqr5gYIICiJVsDJMT3PJTOG+A5OFmihbl3Azn02cGtiO1QtTmXOhqlQ2J9tQUKVDInzlJ9wL+bt8Z9zqusN1M4V63FNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6852
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 2:46 PM, Jens Axboe wrote:=0A=
> On 7/1/20 3:38 PM, Chaitanya Kulkarni wrote:=0A=
>> On 7/1/20 12:08 PM, Jens Axboe wrote:=0A=
>>>> Can we add this ?=0A=
>>> Please don't ping me for something trivial just a day after posting=0A=
>>> it. I'll queue it up, but it's not like this is a stop everything=0A=
>>> and get it in kind of moment.=0A=
>>=0A=
>> Okay I'll keep in mind unless it is stopping something important.=0A=
> =0A=
> You also missed a signed-off-by line, so I can't commit it as-is.=0A=
> =0A=
=0A=
Let me send V2 with reviewed-by Johannes tag and sign-off.=0A=
