Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE30CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273BD206D6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S9qxwkal";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C11BRO6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgEMKGY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:06:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgEMKGX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589364383; x=1620900383;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=S9qxwkalXFNeADToDzTK/4gNa3rd54GbnIPXuT5lpF6wByuSj6vbGbP4
   i0m50YlPsVRkQXTeDHaVXGLNZGR2y/HNXgHRKZIXEkVmuu2nyUXVoOnT9
   VNJg5E/IHkhbT88TXtu8GFrbu/TPyEFSM8EleQc45Q5PjHNM1BOOjIMmz
   s+i2HJN+aX6IulpJ5O62i76JMoTZHRi5QpbmF38iCWXbVBIjcnp0KwOdv
   tKHHS1dgolUmY0NeKfJUFCpPtAN4Vl0JKlXxK7v/mUWlLiBhzd1Fg2vX9
   BHMJIQ1kbajjdr8u46siYBxz2ivenuMWz7VsuKE6E01v82QQfjsRaQWbS
   A==;
IronPort-SDR: 8xPD2u+lMR1jO3c5LUBum3Hw/0LU/225aC58goHbStsucuflyHiRqJZ+gGev8yi0Ypn799QXGB
 bHRE+NDH/yMrPvMBoRuLk2gtorq8LehiqhL4czqdkzk8juwl9mICR72b4Gk1DqTUZDqXrUj0oz
 rUt/HUnOyUgTeAQAdDgQGmX/CehbTRDZ1/kDNLCGYrfMC6alfxEsel2pbyZvpM1/5Rt8PDyXyX
 4tlwLF866PeYTJlzibo+0H0P7xP72mTmnpMDUbdtFkyloRa1Xyc9ixZGzJ2XOeZBi1maR2N6JF
 KuU=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="141917818"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 18:06:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFP3ilS0Pz1H4QIa2sZIgcaOFQUiPWhirAZoL7lNLb0T0v+cOFhf9e/nf3elWvNXwgV4+nWZIH4eE7+StEkwvooG+jyEm6xy6qoL+tF8SYqf2VPJ18Rush+ChB9VQ6LhT+UHihb9MfoFLp/N1eqT1HDjXPN4YiVluSqL/hKMDhsBxCV4FBn0NJyrk2HbH3+u3VVLzKVLMtf9Bp48zyILExuflh8kE1Hi3aTuuy5xSbD6qeY3VWPWtIdBS8SgfW1n9SLubHXQYTNLpwzLHR+FFAaY1LQTgf8BzT24GDnMOBgnT91nxFtdgOLFiLJmrNNTkEE+noeScEsK+wMSv2mr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=S1n4mjogiwMurCiIZ0MGBBKNMG9SMPDKPjr93C3b3H4zJje/vBxx0g18Lt1XDRESuVtZMPq7TAwXKeFhODfmfhJB8bgrD4UOGlHCVlRIaf/aY9d/ZsDQqPtagacNYSSuQNnzWsK3blsCOnXAQCuqqSeE75NfgMuP89273+oF3Z5UESEvHXvQe53/8Ar0etwX2tzzFYACHfwdDL57zxMLbIWpL3ZXHI0hz88BY4Tojg6clAf0FLpgL5CrVOeB9UT75MQB2ZqQctA6ZT4xSd2FB9kfRKi2ifnDszX5r88dntfVBAtg8JdywZwA2CtoJYAIk5lJKTjc1UnKs3axsunibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=C11BRO6Mz5dRJIq2az4vUxpaaPca5x3M2T4GDaWK7V1hOXSqpyjc1hjJ9wRhpGAJGOeoGVMItImwVdDFTGRBta3R8pk06xUKmuoZsl5QZpk/lH3x55Iybw4mcQc0nsiQFF4B70VSkrehLei/VKCun7kIReFOPSmNoT8bn1FICEo=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3544.namprd04.prod.outlook.com (2603:10b6:4:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 10:06:07 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::3c00:be66:e289:10f7]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::3c00:be66:e289:10f7%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 10:06:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/9] blk-mq: pass request queue into get/put budget
 callback
Thread-Topic: [PATCH 1/9] blk-mq: pass request queue into get/put budget
 callback
Thread-Index: AQHWKQycH/ny1yur/UOEoxxJcUHmaA==
Date:   Wed, 13 May 2020 10:06:07 +0000
Message-ID: <DM5PR0401MB3591370876ED3768E49FDAE69BBF0@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31d93189-cd66-41cf-80d2-08d7f72540fe
x-ms-traffictypediagnostic: DM5PR0401MB3544:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM5PR0401MB354486F8D1EE9A9EC6CD0E199BBF0@DM5PR0401MB3544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoIohLhNpqx8vukG4bfHnHDJmT21HRfJ27HbUx6jkO+XP+PnOWgzWk0FNxlM4J9QWuksJ/dC5eRaKVf8OF0709J07STJldkZ++35E23Yw7adAo7/3qz4V1kSGXNfG6IYJbz/eQoVxePevUPfsS+Nbi4oBt+gt4BPu/c9tFAI7IXwZfB9OfIFMkwtG1rjwK080048sEjs2NoMSty8lUh9D/BSt1vi9/t8TIzNIRQTjIcix/bt4QlL7VWM8MDcORQEIU2YlSW3halskcmcsqUgci+4eLuycYSQqq89yqI1IH4mqMENtMeygVxi2EY6J6X0CiExVioX9d1IUT6Tru88p0XpPUvHANyhsKPXncmVbIuL3VIhbSh1IR3sVRl+pEC+TAg/ZJ26cIpPDDq5AiinYFjMqUAEFWM3n9wzVwIvZLiWp0wNMrJrXm5LGU/R0RpUW7RB1aaxtI09DC6alqeNHZHbqyhVKrzKAmd003S7RQ2QM2YVbpSyzF4B1dbOCDjr0T3V0oTdwX7yPzoLa6PVyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(33430700001)(316002)(110136005)(52536014)(7696005)(54906003)(5660300002)(4326008)(2906002)(6506007)(478600001)(186003)(26005)(55016002)(9686003)(71200400001)(86362001)(558084003)(33440700001)(19618925003)(66556008)(66476007)(66446008)(33656002)(76116006)(8936002)(66946007)(8676002)(91956017)(4270600006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Q8HKLEgnsHGMNneKd2EBxEO1MLAPGzYV5+QKkaI5epUNN3el3bDMabt4CRJWmqF6fUoEFWgB7iyGSsjTic7cA0O7XbobfjDLmuykpM3LhnjgAFni4U5UPjcLKnl1zrN8D+7KyY+yt+ItXyEUg8fjXqofiMqjB9Tqnp+BaNIXe3kiPn2MYGDuYNg26PsSSsAgDuraBhmI5P1h2DzWEKhzi7HLvUH62XBv23TjhVQV+hVCm+LzYRag9PmnOLdBMzkEG9JU76nDoThpPOpBIw/kEWB9jRJDCtBT23RzFVj9uULzucMfKuvt7nDkR/h7+eQqY49YMJNxRhkCDTH3Kvxp3/FPoD2FHInHWUZSlfYYVieuIkbdZnQmbWqk3U0IBP6ztXy+NhLShU77qkErnq7heHrYx0dimzynGnjKqy8XcZAhI8s5LV5nb8JZ3CMie0Glo96GWs0zRHaLFNefSST7DR2NRZuH1TCk9i1ESTbKQ2WUYIXSwk7wbnfgHAIp6k8b
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d93189-cd66-41cf-80d2-08d7f72540fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 10:06:07.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNPV4cCKZsCWHDWzC05MTXJmVgIyHvCzXon82DrXFKa0p4U7pedfOGEzF4eExt0MjMo1aw8qF76EbTj8dUMEc8x9VRRG5GKz6yhh8z6Hn2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3544
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
