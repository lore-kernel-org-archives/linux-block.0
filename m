Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E61C73C63
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB42720651
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UzroVSaS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hBtA+lpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfGJCgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:36:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52349 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 22:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562726181; x=1594262181;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tFDISIdXTuql1oTT9eMxfjkGNRDIJEKRzuvDCSFryA4=;
  b=UzroVSaSlP0PW64fScXnWnXLplt5pTWag/m/mgUqahGNYja4qzXq4QHB
   jY6vZPunGaT1vmwxojJTwTuefjhXfkIKKbo4Vd/PUZiCbiHr/Z36x67ui
   T4N/gVnQ5NTdxkczaDmJwnwyY7GWrHgI6Br+8FZ3xuzc389W2DexEzGQQ
   UdY/b74panGu6egKqi0DAad0kYSNKbWq8oM3HVs5iPu7BwPiTc/UEhLhP
   iuFOzWxUjOAL/gUGJTFpbr6V59l0NG8+HOGZt6FuX28CmZS7pQE7T985M
   jVY/jYKg34lkkjX7f+Bn2OH5ptl1Hl9B8EfjOSECN4CGPSFZ2TVGYR+4D
   g==;
IronPort-SDR: xVXpnVNh/2Lhsu3EMe6Mt4JwP5Lwiq/F3KquZyvQwppEDm4DsAuQ+6VWQGvPZzEjWRR7hkutXg
 tZEFqLKQ9wYlOwY4O0MhTmMOQbcmMzWtFSbobIozxpp1TE3LiMznVGq9F5OpjadfqoPomXTpSO
 +gQwrkFp5FChpmFoj3Aki4zxt6YkU/Si6VafDzohSp6PMHOjLFnNwGW3Ix4ccYWwhwHk00AFds
 S4snwq51yRlvrra9QYYramCC28H7rfpVqky/1n61dy1uzG9qA+QtRX/aICNn3kj1ZKdor0Uumz
 7A8=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="112626081"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 10:36:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BneT8Aq9HlgkA5y6zbVrhefxuc1PmIxrIn7z5aeOQVqXm2aPaia28iIGhfIPx65UMA4lOJDADs4lojypOyaR4RtFvKDQOvWGR8ESnT9kd0+FTF7JeiSXO57gFrcZN9p528vyJWTB91sZaRX4gv9zc3ejpv8ahHRvp45vMW2g8M6m+cjpjQ9hDFpaoGDL43POHD9VLvXzFzZBTonWXfeXVhoEeoZveOb2kdgiYCa369rAHcniMuxG8FrJ8p6AEVQzeQZM85xNZQoMvQQfd5PkeplZy6NLS2AYYYkx8a4OeEa1i+NW0683BmBvgf8Rft00XbdztlZXWdqqgFNABzohRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNzFxxm/v149XSpZp+CjrHal4R3oEDOAxcN53mcej3w=;
 b=llwP9pfEuqLHPjdBN+7kL+sDKadQKkjmhJU5WqXrbZGdIsUdhz/GQe7sTAfDqW/5jTjnrGnH0t25fT+AKipnQgVbumtQkLAL0aLO5X5KTepXZ/QsPMtqpNg8A8DLVneM43NoDorhVEnxF8Bh9crAjnfV2OvwKgwyGUZaNhvgfuIRCtK/THsgZ3fQNbHrZtGNQODlxQHJyAEoxZJF6/vXAkBUMtHKRH5xdGVFwHoO8CqFRrdH/u/e30RZk7Kl3ejWDDUvWW3SAdwMj6FHyTDW7kzXHww1lo42JP3tmaNs64gFtMfpFZLA0p1wxRbYAesn28O4WOnq9gvpJ9QeCSakow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNzFxxm/v149XSpZp+CjrHal4R3oEDOAxcN53mcej3w=;
 b=hBtA+lpIRwxieXi1vaIqxfMW4oZE3djR52bCSIadryS3KUjJRyCjTp1wGEDv70BXlpUNDnhjBLDPnX4JmGMpu8qwN6NTeGYRkmm1kd7fItXlKtLd3lr94k8AswuhfdBLe6jJpo24LTIFS6erJu30cGmkTfuCZqD78LAlYl25+gk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5991.namprd04.prod.outlook.com (20.178.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 02:36:19 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 02:36:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Thread-Topic: [PATCH] block: Disable write plugging for zoned block devices
Thread-Index: AQHVNjUIGjEvOj9COU2i4snLn/f5ow==
Date:   Wed, 10 Jul 2019 02:36:19 +0000
Message-ID: <BYAPR04MB58169AEA8E4A1C148E53571EE7F00@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <29cfbb53-36c9-1e03-183d-572223eb01f3@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6cf89ae-65c9-4da6-7afb-08d704df63d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5991;
x-ms-traffictypediagnostic: BYAPR04MB5991:
x-microsoft-antispam-prvs: <BYAPR04MB5991AD4EA8C87C5425A87830E7F00@BYAPR04MB5991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(66946007)(71190400001)(71200400001)(66066001)(66476007)(64756008)(91956017)(76116006)(66556008)(66446008)(55016002)(229853002)(6436002)(33656002)(14454004)(2906002)(54906003)(446003)(25786009)(99286004)(3846002)(53936002)(7696005)(6116002)(4326008)(8676002)(305945005)(2501003)(6246003)(74316002)(81156014)(52536014)(9686003)(14444005)(5660300002)(256004)(186003)(26005)(6506007)(478600001)(53546011)(102836004)(76176011)(486006)(4744005)(476003)(316002)(68736007)(86362001)(110136005)(81166006)(7736002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5991;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6zg6TpMKPwuSSRPbZxqU1DR7Wwezse4giuFPRwvUi2B97UDPPclVQxeo0XRpP9mxXaZagQVyQ7gULUVNlTNRpOTO/FQvP+K6VjkweGhmYE3AjNm8+Mr+v4HYLiUzKRLR/vtJrXw+BfYIHCpsXX51O3c/UQ81RJ4YGPCz8gVbllK7+1MjhnDRsvPDIlY+nN8i/K8b2kR8J4j8PCWxZxezcnj7LlU9JnyI/JNeEUbpvvZOACXVvInZmQk/MJOcm37NgpH1IWPXpgLNHDhNVKaMMaI4iJiCnEyOF/45tB4FrFBue0azTQxNDc3lTOJsctiKPX3nn/k2Wxt44kw8qetZnqA6vSbsxZVLfqmmIeRAQqn8aCcEEXLIaBpxxncx0OHhP+37jf/CGvBXVjldkLfvitGhdXWwEUhHtiCBX6liNzE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cf89ae-65c9-4da6-7afb-08d704df63d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 02:36:19.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5991
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 11:32 AM, Bart Van Assche wrote:=0A=
> On 7/9/19 2:02 AM, Damien Le Moal wrote:=0A=
>> +static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
>> +					   struct bio *bio)=0A=
>> +{=0A=
>> +	struct blk_plug *plug =3D current->plug;=0A=
>> +=0A=
>> +	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))=0A=
>> +		return plug;=0A=
>> +=0A=
>> +	/* Zoned block device write case: do not plug the BIO */=0A=
>> +	return NULL;=0A=
>> +}=0A=
> =0A=
> Can the 'plug' variable be left out from this function and can 'return =
=0A=
> plug' be changed into 'return current->plug'? Anyway:=0A=
=0A=
Sure, that would be cleaner. Will Send a V2.=0A=
=0A=
> =0A=
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
Thanks. Can I add this to the V2 or would you prefer to see the revised=0A=
patch first ?=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
