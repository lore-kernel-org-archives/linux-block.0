Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E6C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 07:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D072073E
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 07:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="glOTYJ4H";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TA7iy5OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbgFXHWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:22:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11849 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFXHWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 03:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592983355; x=1624519355;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6HB8eUn41Jde1PHOpos+zEhIqa6iSTu75UCGqoRTR7E=;
  b=glOTYJ4HDUJE4vsdx8oeRZ8Hut9IYFD8Xe1/a6ciAzqjPOdI0cCWm4gh
   gNtwek1bVJrLR/jc7NuBoI42Xt31OWNJ8nzvcU8TcpdqH50u5kQuEHLis
   +hAqaN+PPSjCMTmFdIfoJpQ+yoqL/SCRmAPVlSki2E4T5KP6i7KvE3tal
   Mg/p9Mj0O2ZToKEx7bggNtDYzZp9rVJn9QesLAC9rocGiq/zW2cmr6RXM
   bspU74rHdrehKw9ramwjW6w0UM5c8E1Csha6xQVRc8Rhi+GWjY3JD/0a1
   Tg4Uu/tUcC8dCiKEwCwHNUc0CwnYj4F3xC6xZqtjPBEu1vncUmh2lriWO
   g==;
IronPort-SDR: WlqxuMlrNjGr8IKtrBFcgZDkbYjkRX+DV6fPKP67j83ZlVcn2YvckA4Nw0jTAVYOCCN4R1F6HN
 MogBJwuJENr3Yuu79/bNZT7LUblv4vmDovizJA8x9fD9x0aOXfOszesTBHBvj0Ay5dE+71dPCp
 nOwJVJMXKvWQlBdKwpOXUXyXVHTU80MFBaZaPjWPDt8KRyaUuharvgVoR/dlsFzeoCg6kMSPdG
 v4ocn5cIsV6t4irUdwGsFA0CrOHHhQ4C2gn+B/oICMT2Mh8AXJO+mQAfBNtRMqQdkrv0j16CVp
 Mbc=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="249987181"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 15:22:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rstv6bfyySJ1lLETPvc+vGPSeSoH/fMM7K2Tk1912NHRwOXGqtyNtYf4MdTSQeSKDFwdynubZUc+Dmn90mlH6STV+9RRuVeJ7A69POrRnUAs/nEfHbeHKfZU0OZGy4FlFDHvKPd3jo41d+bjHvatIN0fe01h5zTuR2uENl9H3voVsg+eodpn56iMR4HyGTerj6RXYafNF+6x4CPFQjwxvu5QsdxVaSraKgO5E3ztmsEc3qU/Oayg6o7hlLbytST76OuqfeBxq4Oxl+5Fwtlh7bQcAEOIhkaW2AV2IOzYODTcJloWraWIUdCco5OAi/a2Gn8xjpfmUqU/Yg5CBBWwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJCQ9q9lOec86gRWNWdg0QGPby+3jEU4w+kNd9T1Sk4=;
 b=Ct9OFDIp4KRjX7TP0Aqa9AHQOQOJ6DP7dgU4s5/f+spSxpjS4Is94cj71Q08Z0XfU6qdYEUH7AIAaiQUensIN5/1G5iILZeaJxZCLLKAHeYfB8+fcyzqxjhna6UYXTsYQRfwW6lUJ+twJXM2++9CNMHMqHvLVVA5wVeXQFxCwepGJdCMAgxa24cCVeR4+dCSWlHoPlwAJ/S80k1pGQvVFMHXoCz9ugGwLrTyZFQ+0wWGiqO3QJykJtse+xT/tSVYAzbNxaW84tkAdwm+BBR0TK47YGu1oWH9Do5KrkkKBUg60nrWvdpHNAAd4jEZ3tIeJboS7XK0FOqYEpyDzGtu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJCQ9q9lOec86gRWNWdg0QGPby+3jEU4w+kNd9T1Sk4=;
 b=TA7iy5OGNu4ZwtnGQIRHc3BlA1WVjEdWOhNCLEMJy29NyEUx+b4nhbn8c4ZE7HMQEepwwIUq7L6tQPFopid6ltikO4pXeiVvQUrL3NZhepUAGV2koDIaW2EHlv4Y2xMrIio5pg0ZOfmrxJllTM4+pIGTYgMXaVlP6zCLR3kp8Is=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5770.namprd04.prod.outlook.com (2603:10b6:5:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 07:22:32 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 07:22:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "satyat@google.com" <satyat@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: add initial kdoc over the request_queue
Thread-Topic: [PATCH 1/2] block: add initial kdoc over the request_queue
Thread-Index: AQHWSapQTF7D0wyEUUiLTjdLgAAWWQ==
Date:   Wed, 24 Jun 2020 07:22:32 +0000
Message-ID: <DM5PR0401MB35912D2BD6DA885B698FE8349B950@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200623220311.8033-1-mcgrof@kernel.org>
 <20200623220311.8033-2-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b53b585c-cbd3-498d-759d-08d8180f5c54
x-ms-traffictypediagnostic: DM6PR04MB5770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB57706D7ED534C5A1708D292E9B950@DM6PR04MB5770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yc7rsw4e5v6Ej6nlFHp5J5N3NnpF6ZEeprto82IyxIE3nFs2Lt8o1GKDBIxoX7SZ4aKML+HeztkIoJ6NIFO7Qc+ogvz8CtCXdeBQf72AxzC3eBFN4jhza5mFXuOgVcmrSwVtcSf0+D1bc9QVrKMc8Hx55M2U3grqYyY7KBHgTl0qLb3j0w6mvBx0TRCkCUK5CHoFGylTkYKj8B3NVGajYy04hPqWIZlVcEXo1PwrwgDRqPOq2uuLTRwVRl8gKq9rbqFH0d4sVdWD7DUqkmiKWpKAL2lsRvSDM9caeKXOT+3SbPVoNTPmEVOsgsLWSlzuWPo1h6gmK4i8nxKhrZqCcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(86362001)(8936002)(33656002)(558084003)(478600001)(66476007)(66556008)(64756008)(66946007)(4326008)(66446008)(76116006)(83380400001)(91956017)(55016002)(9686003)(5660300002)(316002)(52536014)(8676002)(2906002)(186003)(6506007)(53546011)(71200400001)(54906003)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bIGD69yG3FOz8A40kjU5jhbaX1p7QHAkBNWESmu0pocDmI8+yZfM4GOdRziqeFZUY0HDXIEQn4yr0j3gaOABMKwUDnALZ5DukDiUfgrhe3ulMXFcNJZgAqxwvNmZ/oJpk/5EgKPyZ3txPKBl6Ywxp5xaMP0MS9hYBp0SmUxqmz+nBnSC9tSuG6aQIjLoMvyXdHd0FsyhXwJky4tIKkAPaVHXu6zulu5cgXK0HILPu5UudGNIWMePN6+YwPcODTosMY8PCmmblYlBTim6BgIN9TCogT4OE70RbZZAz5bxiiY/0OYuKxVuOCru5mSnqp3K/6GTZKpr0VBoAmR8mFt1STJxpD/bI4oOr3nruhL1UZFqyJB++zdb0Updmlw4BYZ/1OWmyHvTw9W4reT9PTFn/55ahyqUVmghG5UbLY3rev/NVvGdGNxaNSSIGzQw+SrgKeB5aCvV1xycz2M1FjsUXrCwyyW2FX43WTCGeMI6ncd1WgxngY/j3GKOLuTqslHa4Vqlc7wAcFLo+I2vlD2aHlL73J9oREllyor6qh6Qzs+hkcIl69cHS+6/cX/ZX6tT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53b585c-cbd3-498d-759d-08d8180f5c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 07:22:32.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pub9zyYFfIbc7RidBz9ekHUOXshSTmQiTmfY/l1tGLm/0fWj99wToO1zFAmRlIKyORtdkeIISt+0VCCuCa0b7J7VzBn0r/AP01XPDtXx9tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5770
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/06/2020 00:04, Luis Chamberlain wrote:=0A=
> + *   o make_request block drivers (multiqueue)=0A=
=0A=
I don't think the differentiation between singlequeue and =0A=
multiqueue is usefull, given that the single queue block layer=0A=
is gone for quite some time now.=0A=
