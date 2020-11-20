Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BAC5519F
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FAC22253
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FuuIvLhT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a5bQO/6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKTHbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:31:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56083 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgKTHbi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 02:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605857498; x=1637393498;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FuuIvLhTRJONGF9vua/o3/J+0qRz8T6wXUGHfNsuvVD0lkAiyWgwjwYi
   cNwmruheXPnnGk9ZKOv3wpzSz1rWigUkRsCiLpzHzKl0fRwB+KmZ5lKo/
   t1/bv689b5QMVT5Awl/pk2Eb3hunAs1pEV/6f1BZ8GUuMkM+PzfXcg4rW
   BCP/btYdQl4RD4u1IDR3kDI647EgTwKIQQKhUdjxADCHN2QHRTTH6OLcQ
   +7sMmo8BJpYQLDr2KkUrODrqYBAckEUH8JGtx76K82xPslr7pV4Qwmv+n
   0+ufrjYerQ6YqUnsoFI19ps9eZxGGD1cuWhLtbAkD5HA4JyS9a7pOJ1cU
   g==;
IronPort-SDR: Z9nxYRgKTWP9Opo5M0bgYI2Q2fBZomyVoywcD0LOZuL7ONmB32ajkscgSFFCdn7qwz+pnu16dH
 kxnl9XD3TOfOXhCsPqUtCpSk0dSgo9VqGilReJFHAXI/zbkaVI2LwsBp7yo/QhyfseW8Y68mcg
 EEs/Zg0LzYpS0SxUZDmU5wKECnFbnAtrMz0UeLY62Av/TAnxjOuYRdmVE3Gne1h5oz+Rujfx82
 OVutg/SdlRihXsof5od8neTJtKyMDwbINPzDrpFJxkOvcDXKLp8SClKSHCV5CiT+JoI6SMvD+/
 894=
X-IronPort-AV: E=Sophos;i="5.78,355,1599494400"; 
   d="scan'208";a="154263193"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 15:31:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6dsPf0oJG4FFfbHxtI/sGbYWKp/zMxsSn1HgBy6I3yobOOU3Gp0evfPdBqmlLgbqYO4ZRy0coVfvaseyls4qvr/c2Rm6u1qUEjDgdtY27LE0lHhlgUWci7kOK55TvWkpSu9uaQpt1ldHUHy3hCSCTi0VHhz8tsmBQtTqNSidJAZ9evYVzU22iJmM8HrjsfHSEeB1xJePhvJk/lozT20Bt7Z3MyAIrd06qwvInEjzKEEVdgNWEeApGqcuiZIn6jqWJfFTfHG7y79OXkpI/LGzidydAAEj+W0hiuTE4EafxbBmseptIY7hnk3XMObxJwy3Ga/AR7tbTPfWXuYrhnnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YEuQLxNKXmb6tpnHbo04TVqxkkneVFwfXHwGb+tVJwqen5FVDqK7G0ycjVEFdr/cO16HGZr/FU2P1dC7jEPKPfMNq079nx8J+YcePK0NFgsYe7NDxmJo7QpH7ijyCb6lGFteHr8Tup3KvVT8ERkpV137A7Nhpca+z5YM28d65gfkCI1uD3kAgKBsBZMaxFtX0SE3HPO8Ln53S5TdlkgvlulThTgmgWWwYhjDJ0abP59ZarWZM05QBOJvcagrmTknyX5imSdivAMK9Mx37ye2D3dw2246PCMSIN3IFFtN2qJezCLDY4iqjx9w77O6rqVbKxtmgiGO8vfdlhsmQzDM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=a5bQO/6j9iG+OwueDz5jpb+sJzyjqFbDAz47EtDsIDIZAb6S4V43PMtHDUR+R1ZesUhbzXnipQFVZpFRW7kHavyEsz7uc2Ige4CKUrLXeYDHOFgonzooqYWPrvqo1xOFFnxHeehW1Nl/apCfVzVgSG1CqDnNKAykO+XehOGmrFc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 07:31:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 07:31:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 6/9] null_blk: cleanup discard handling
Thread-Topic: [PATCH v4 6/9] null_blk: cleanup discard handling
Thread-Index: AQHWvuCH+n+BK2RAp0+c5/qsKkAogg==
Date:   Fri, 20 Nov 2020 07:31:36 +0000
Message-ID: <SN4PR0401MB3598A4AE22DA5450FD4C8B299BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
 <20201120015519.276820-7-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ffbdce7-4195-42d8-4c7d-08d88d264fe9
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5326B017F329C16F6F84732C9BFF0@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7hWqqt50ZnDXU8lWbJo/dYOipcps8GSeCgf3PmMbXCsvKJnTZEt9SlWrcTdbuDUDxBishb6W6pNvCUuNX14EXuCUNybxaEAshDGy4E5s7WfaBPCp8hkzUfgu7/61aQMhZ079xMso4sH52mI9hAuCPO7QS6qXzTSPCHRnflWwKAHaDg4FqV699n1b22XmiJ/csSvWcC5LlvkeQ7YzMODMzg2WDyvs8+RWzrQ9/sZVgANARlYwJtqzdhuzSq9/mh4/0yfw07oijMK5w/4raSyhUwlrGkawORa9B7WgUXf5pXxpw9dbC2JCT1tq7u8eCEoT+9fwd9vGstvtZT99viGQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8676002)(91956017)(66946007)(76116006)(66556008)(86362001)(33656002)(71200400001)(4270600006)(7696005)(64756008)(2906002)(66476007)(6506007)(66446008)(55016002)(5660300002)(52536014)(110136005)(19618925003)(186003)(8936002)(9686003)(316002)(478600001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ScwtzUZwHQsEpXKtIc3wCvuBrxiYlIuhfkJLAwOGWDYDGIQqPpn9A8CgcSlOxTd40yiiT4rb+YpX3jzRnlvX1KjeVkkoHEMR1R0SYy1WFXAEAd48pRBFpSBiElWSAIDUxnBDUZLo3gn82buwrhIJ8GvLzDGfRZ57hnC9er3jxEIEs7Ev87cVdubRaPJVJFcmUyEPpFNSd1txtjrjmSdfbOXxjxmFPR2J+LXiJ8wTiL3LU7ag1BxnB2OqFAqysyBjXyymeBfm2Df6wf0sT16qTmcpwFCZtR5Khv+n1w0NRcAo5RuXxIMCNc6vHQswcz3ZgO/e4xcV2+K/6ijiCb15CxrJscpxVn2zleVns4k3OFsYD8CziYpBuLgzVnQAfljqgwWrsOXfR2YLIgPDd+tU3TG2e1h5sKfeW6MLtfJ0CjQ3h5L+pSYDyAKFrzWKbny99/fppsRoafcxHjgPkwQIA0gIFMfRb4B6cRnOTs5dNLNckor/IQUUCBG0LlE1Io60z8LNNyAmtYVJnudbmsM2RGQZF9jkynd1ZII0wbShnkz/UOfeM9QDESznvQDtD+zy5u+Os9Jj1z/9tw7c/G1326DFIK3IQ7XcwneKFLLFvgjsWW+IbC+Mwp2DF+lwELqaElfv72pOqdLvsxwPxULnR9CbwNsH4lfusBbOUPfh7ebl2Mg7vNYimn8ErjvmAlVMDSoT5T88ooUshMg9RzR/9A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffbdce7-4195-42d8-4c7d-08d88d264fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 07:31:36.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQIh/TO7XGjaX5wJ5Mk23BNn4vxyQoCxIW71gt309WoJVb+VGfLXS7Flz0ozUixpZJXwhbvL6qMZaLz04240xfJP0jbjIwVAB82Bxw6HB+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
