Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD9C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F3C206C3
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KY4zhL4R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RTX7yRT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGAHdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:33:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19813 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgGAHdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 03:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593588794; x=1625124794;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KY4zhL4RDXVBA2OoRf1c+2MTMvkSScAWa0PwXWpkjF7/V83XMteSByJr
   I1pFyvh5t5QiMhz73ocIQSIgJv9MFQ510TM7F3AoIMBC3qiwuRN7w4ntG
   0NR7FriehyWPpmQpdovULRVApTNYKIUUTyl1NpUbdDxKNX4NuIbevUrJM
   ATYbJjY1W5Tq4p0pc7ERoKnxs2NLL3JWc26kXbFrK93f4Ean1MJG2Ild0
   hUh4jHgqU0RmxgZlsx6OBksJXtKxEhjCXNrM1L+C8ulMrHM+kP01rAGa2
   C1Wtu/1p6gcUS2u0M+1LCNdF4xD044DAEVDDQo1gPtZwTSp3FDFY8zsgV
   Q==;
IronPort-SDR: 5RfjSmpU828QqkKDlZR2KQl5zp2CH+NJyK6Eq8C/TAAOAA/5ufZG95Is0Hw+dHV5Dxos1G+C5u
 /2GoLMVkl4Ta/GWlL0cwugsHhsqYuYpvevNacClkKw7RAAcGaLQJdurc/Uc59fBiLvur4UW897
 jKvzNoyMB6wQrHa3x4VnF7QoNPBLu56NvYkKQ59Kdj4YWns8wrnJatlT3SmD7IUudyuVPYrtu2
 9FgynUYHDNwPsd83AMg6yVhcyF9juCrby5CYqQJzl9svESK2uwkOQr4DcqtCcrTVXEk0DIUDF/
 7sc=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="141353595"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:33:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV78eFt22e6WVMIFJ7Qeu6BcwNxldbl33OnIcTXZt9JPmKbL+FedAm92bR6Ww49yLAw6wX5CCkvMhkYi3I3neC0fUGkn8T7gXXvDqn5FOJWVhqf3V32zENHZP+61+8bAuZlrwgYE9BKpf69poIJP29Csy4eHlbnT04xqptTomLLTHdl/JSSns1N3IYwqv/seZsMC0qoA8dMQCnfIquJkg6wo9GUI26LQSRYU/EyiWZG/ErT1g4RzzsFMxAuPJquEfxjRCQKYSyKHyXCydu6qDu+J8Z5IXTx6kPiDUYxunu/S2AsRTrp3GuzuUwvXPgYKm6MOcz3CJoBWm9iVfdshhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=N/UW1YpntyBzA5x2GdGjent9ES2LR19O9CqvdoUaV7LmP6viYHgKvKhUReSdogVjF0XBi7ZmzVDtt2pS+6dTyWjMArSmeySH5XOm3HrxwUbqi9X/D0maghMSX1Xoy/I8YvfO6BBw1s1/mFTuy0rfsvjtwvaAJdB03sVBtT/qNoTlOp2aj1qLefrBDBKEsIELrvdWHsrxWdNeURzRvxxlNZ/f02V0SwI7bGG579W4bZYYHmN3Se03fhPbxbo59WBHd3cY9JSLJg1GAsohvvYK998M1hqT/JVL+gmTKYhVyshkMZdCHfciDDFgx9O2kL53BQKEybgd5Edjzlh/sxEKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RTX7yRT04jEV9tFJseEk0WFfVHaCweoQPZ7fG4D7AIyG/Tc6GP7Qszt0bZpiddspHinbr3/H8w4KpbSxzG8HOwG8706Qs/wLgyj1ctXHS7Di6WMFx/xZU9j3z8owY0XDwoY5TQVK74Q9oTCq32PAvFlYZqRpx6u1YzNx4C4kIlQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2320.namprd04.prod.outlook.com
 (2603:10b6:804:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 07:33:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:33:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] block: remove the all_bdevs list
Thread-Topic: [PATCH 7/7] block: remove the all_bdevs list
Thread-Index: AQHWS5Ax20wBDXPlUUGsU5x1jPm0QA==
Date:   Wed, 1 Jul 2020 07:33:12 +0000
Message-ID: <SN4PR0401MB35985A9F315386525DE24B1B9B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:85ad:d97d:6da7:d614]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee7bb8d4-72e7-4963-054b-08d81d910303
x-ms-traffictypediagnostic: SN2PR04MB2320:
x-microsoft-antispam-prvs: <SN2PR04MB232048AD7E07D3A659F4CA2B9B6C0@SN2PR04MB2320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2DX6On2zIbjWX7i6+uuL4WJ8felbHGCWyXtghmiF4vn1BVa9N6zKsGSK//WPoM8zfg6Q99xcbB21E86ksz9kq13Gb1/DucYv7HgW5W4foCBuxXKhmjS8CHEZK2f8UhM2WMpotSvCgJVC7vR00YelHwZvP0moRlIASxE4eY/n3dhIEiBb1lg1lopiQZ/Sj7zrRTw/lC1vcjn0jHf4lrsW0dXr/Jb4wHEq8yqC33KEiZ/unfuIi8FVbHPxZSs60T7BGUR1UJLDmIqonepLAaErga0mOZ7aVSYeEi6pktnJ+ccglIiPJwydf4Be9hBo8/tYEP0iED12RTh1OMNTr60Yqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(7696005)(478600001)(33656002)(6506007)(4270600006)(316002)(86362001)(4326008)(8936002)(5660300002)(52536014)(110136005)(8676002)(9686003)(55016002)(186003)(71200400001)(54906003)(19618925003)(91956017)(66556008)(64756008)(66446008)(558084003)(66946007)(66476007)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BKmmOZcFFNaPrggGUNdjhKNRMuAqnmfVE76t7gul5ooMpoo5kV/T3DfFWkOzEWnlxE6XasSDGv0+GiOnGOQNqe/jIhdDp8o5rE/Fr8E3lVb8auAoko8MX7FEsuuuhp10lAeFRFFwQ074JeRF/q0x86K0WZ6tJwRBg1IIpP+IZQ9ahnT4FdEc0F81R035A5wv2drxxgjX2HQiIHZ7KaQezGqn2NXrYRv82Fkt44GM98RBrl2niv7nwNQBAeBnVUyUJCtepNf2by/CKGqTv0hQdB1nNJdphd1QBk3U+cKSzBy6vq0a4BGhjUyXpiGde6J5kM5jU0tAJkPwgj8L1XuTFsATJbEhew2RehYFHB/Vnh1nOj67fmIDlFr1BJAl/tQMSNXA1lmfx9vsyje55iWF6kcBQOn9vmUFEmT6f87wneDmXxvJ6p1JRrDXGf9kHncUck0yvTu/H77o7PfvYj6v+nEU6YpijxOgKPp30lbk6vTUowq0n33hYUN+xBe2fuq08N9OX2kPa+49T2SX652NYbVdqitEuB4AFTE2weDmMtJ6O0iUZPKy9xsz9NxBUk9b
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7bb8d4-72e7-4963-054b-08d81d910303
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:33:12.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlXsm1ZePf0bUeQSDMvALl0HEeDsRGRUbqliHkXlmfAcj2ZbFfPL+jLhCWH/6rJVwkdA5sIFXqhAuLc5iOH8PFk68yeVZizD+jlW5VoUAiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2320
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
