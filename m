Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42AC63777
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78112158C
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p1x8c/5c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hzJTmC3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgKTHcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:32:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32939 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKTHcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 02:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605857607; x=1637393607;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=p1x8c/5cpwJPMeyZ8XaPgfZQRbTfe1CJRaEOooNRCy7931j6137ImaPl
   cE7R4SYc11i3jHN8g/xjWl4Pptb8ykGfEbspeB9TIX3psEr0RL7vSJ+k0
   GD5aAf3C0nOZOfjB9SUmLr+rwOwU2SP79cb5NOZy+akJaX9ztXkHSIBO/
   ol4bTrTfxOrgfhe/UYI6KTHYjD0+pi4g1pCeivu/Th6cV2xCcrMzd3Wgt
   HQxC8dXw+Bt0LgmewyZrb0Rk/V/+pIvenBkzpcpyvSa4EAM5pRYF2tnI+
   VJMeJSJKxjOrP+ROQ1DUZ6dW5JijI2iKUxPNrMFlxOdschyKXMDVKHrmW
   w==;
IronPort-SDR: zA3way7gZ0Ip/3se9k1h0tyXV5lSl0GiXI+zHtzTGdI48+fM1fe3Iie9sxCZpa0RX6v4xsSe92
 WmNSHl2et87uLPXEojzHf6QGFXU5zaFK7jKMyOPopOVZxmZdlti3EtZq93QL2qpvjydf+4S3nJ
 WEu1NZItSQf47909/Wee5s1GXC3D0bCEYF+Fx1/XxPR/5lEOwozrAF8O4WAkHtylNuQBdms7Mg
 DrwjiMjcOx4edp7NL+Mh0y+DWZlSOGzFc6jWHT4ErycA6EZKho6ni05QyWlhBVIMe7X2mXErtD
 ZZ0=
X-IronPort-AV: E=Sophos;i="5.78,355,1599494400"; 
   d="scan'208";a="256661053"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 15:33:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqmENZzK3CsnPheeKuHkyO7ET6Wm1l+hXjprIoB9EzxaiGQL6XDXJA2ID6HwY7RAXWBRQsqbJgQv3ZTZfAMs4t8FXvE0efxWO4iJboc37kAbKGDOOY/anBZfA0QlRcD7Bres8hoGZTBznR7SiFZHj6N2Tzs0tZz9/waE2sROU1zQ9NvcRCAUuJzSoig7IJKW6eyjPm+jC5Fau5oLf+EcGBAFXyjvaNwzremDrvZ3hS3QGyB91qdm2dxoVxhj+R5uAQdNvTXuc6tADgzfroQCbpAv/wP10pdsMp2G5FBOriRH3KrizXzr+okOoX5DEeBCeMK9YzHkZUO8mtkKmPRVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IWcDcKAE6+4TDRfSq8i6AhflQD8B6+0cm6hcJZD4rmAJuk1aWv1eSdQEIiMu8rPEzSMRmotY+bmRKPzt0KWyBJqlH59YsmxBaPGz1ZTAVNfM2KtYqQZeTeEpLKibiMPDxbiaaFA/iT3Q5F9YP0H3Qa3cwH8EHTMsEgcG1jsbO6qLVuB5mQ3GG1IJUOA61YV7qpJaoOgtd8pSO/2xv3natqFHjEYrTdTWdQuFAtOChRDjOtc8pcKVawo48kn2a7efqgWYw6i1sNqRu0IPvaalYah3cr1leKIdtYC4RkJTkKSgnaZDnvglJC+Z740j2pLEb62ZLkhVu3eK6ZFLfJgcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hzJTmC3muw56cmuGwKbXJ6evszBiIKtLMD8J71iJBlsCDbWvrUYWKlwuWLmkcTWnZDNtxDRqRtvQpPy0C+7+Mit7QfPBFFLgCyNLRcf60OwpTJW+tR//uEqcBqiEz6fgfFQG8GPaxeTjNVT3Nt+yWO9Br/Xe6af+Pj668tgN2w8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 07:32:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 07:32:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 9/9] null_blk: Move driver into its own directory
Thread-Topic: [PATCH v4 9/9] null_blk: Move driver into its own directory
Thread-Index: AQHWvuC824xedKXidkWgsI4gurp0ZA==
Date:   Fri, 20 Nov 2020 07:32:49 +0000
Message-ID: <SN4PR0401MB359897107D1E1DBC34EC36059BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
 <20201120015519.276820-10-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c9658ba-d82e-414a-a591-08d88d267bc9
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB53267D9D4D9A381A0AAAE29F9BFF0@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pi+kTtH6FIKf0rbWFrEnssHtupw0C6HE2UpQQorJD3zJzbRfzhGWNXaWLuMqDoJlIb8ab8oQUV667BQIbNU9dg4QBbo717CIkP99kQexqA1JbaTXg2OFI+CqFBjdqmi9szMvefFi/gTASKdqN5Z0JLSvwrfTgK1O72jJdd69Cu8S6sXG1HdcGt4CA7B0QqnTtanX+4GLloNbjcPvinBq6ypJGj/iXaFZwDSlDwNa4d6x1X9BTSWZwvKaS1k1zpbSB0s9j9BggJgOOPAumuR4A0L7BopiX6ncVypweCptgT9kfRxipm8xDNxUl137pXiZ+0lpyCdAA5yrgLj+gCOBVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8676002)(91956017)(66946007)(76116006)(66556008)(86362001)(33656002)(71200400001)(4270600006)(7696005)(64756008)(2906002)(66476007)(6506007)(66446008)(55016002)(5660300002)(52536014)(110136005)(19618925003)(186003)(8936002)(9686003)(316002)(478600001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dQ45gjoAcgY17SV2yijblQTiqRUEZQH29plewuqFe9L+ky+0rYmzH6KhoprMtCEvMncSbZXbp4g+Nivr440W6gTqgH4IHNNDtIsDWA3QmnI0dmXprMxgf/rxJyKghjN9dG3/0GqSdriJa0QLXaltj7RklBcOesnHxnkxZqow2SCdQ8sgmblWjw8UpE+dvIml4NGe05NAqveMhuTxaD9DBQ/d8BrU6saZWmn/Zu0ie70fzvX8oWVicXfLQ5yDOdGnoXP4vidTcO/y/bqZnlBNQcBR5yZpmYbX6XpTuJ0Uv8hADHhoIFl6NJ+R5ixqSVAPu3PWHLiz+mppwdMUlJz9EIWn4vs3UN8Yt/UjHIcSUhv0tJ+xiKwc4Bz7n0fDxrllc5fQb9txXu1LWwtsZH+4J3mOFb4MTdf+TOka6O/uyaGluHwYN8nvb7t30qrU37JAIZlzTxXw8LvgkRM5dVghNjf/0HJ68XBHXgSNX6+KAHbTM4Q4Xbiji1G/geXxmomI5apYRGsm1pHfBmwCr/CJlP61Cj4o4UV+a1vVWW9Fs+AHvsy3mCACfO4Hje7/EX/b50IXPYXIxa1/1KgnCXZ4TVGmjq0uHPX/DOigJCiG8smAMAXm2+X4RE3rsWj42yLBDGiVXSzbKxll+o+nBxyR4jwqNkRG4tbGTCyfn6UY1AFVgnASzeSJlZRvk9i1JGHj3dNotAkc1F+potBFsbAgVg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9658ba-d82e-414a-a591-08d88d267bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 07:32:49.7082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlLphqAiuyDkdufsU6lsGdJDwlVBfe3IhbzQRwB4Byqhj4aaXbXfSNe1iJ4AM0TxYD9IPNans97wzlhfzkObNjGv4zD0f7v2AZ2d9PRI9Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
