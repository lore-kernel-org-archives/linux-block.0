Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171C3C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F143E2075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FBxNeafg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zWE28zM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbgE0SSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:18:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6381 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391927AbgE0SR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590603479; x=1622139479;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FBxNeafgzYMALwcfAiJkw7nsTWUrumNatNYlsknvoUoQRy3gjFHSM/0O
   z/TszOe62frEmYn+wzAFp7DlgopuDG+/j4yLyXQpIHklbOkkCMpnxc9mH
   sL7ghCws1AaUHs9XKmtvGPKGy0C7oTe4dyLs1KdVIa/PYaVWRdRzLdpdN
   33iJvr//DArBSppwRQN4OMW1Pxg+eSwHL+nPUp9If94V1TOwpfCkg9Ryj
   JX0Mh7DLmyilWEc10ctA629ug+GL2yccL3pr6XBrombVLJKvwFoxcFC3c
   jc/VqSs/8Vqfel0F3BIk+4/73jZbkj0J1WC17yvyGx0tf3rHmzqZ5lu1E
   A==;
IronPort-SDR: XTP3mlC6M3DugMxyxuoA0kZnY5Cl5tQNilmYvUyyK0cJ+ixVhNxdxrM2NSF/Rt9DlfDH07O2u8
 NmSwofpJGoPck2Wpgkq8xaMLallt0N0gG369oGU1UbwvMniFzH5KdGAauKF7+KMUy/VJEaGHqD
 doA6ztx+HjbnF1d89WcdEwsFp++n2kyFIodz2a7x0pGsTgcXrUg318+JKbrq9NyOBU+7J1aM6x
 wuk+8HlepAhbKQNy8GRoFCPfwx+tKzM4Szv2i0SSZu7ZObMoZ5hdjYP5+sGw9OAp6G0GdpWv+n
 C7c=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; 
   d="scan'208";a="140068731"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:17:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGuwJpHpT4zUz0BsKP47N0fUjwVr3B/DTSycUshj5ZmNoQtFm1JHE7TazKfAgeGMoBxSMRb8e41nCEZwxSFiCc+fkYTx8Ee4DeSsS5itnzUZeplui2swikCfeoK9MCDzWjN3UeU0A+UiG6ue3331oMB4h/xV2p+Ot5nha3uL66QbonN9mM7cBat3upE0hcQINsTUSrf2x96+HHRHFakS8kBEtgDhgowwl4C4xOny5sKGKIPH+Ss7/qurmGdW9tE30V2LSCoOT5JQHup2+ZE9UrltaeuUqz/q975cHtNPVEdaYUOADaMD0UAIJdl9dgYgAnauufIratEHAsmEFXy3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JDVUm2+mgse/xLhtws9w2pkRCSE/ARVBg0Qc9Sr2BKuen85QzBSUH37PuHYAqlJpYIu29h2zC4JwFI1X+0S46RkqAzgNs51/IJR/y+Qkhxo57LM9mKGGKYsBbuJm1o7NWGEYJiSXshi6TPr755mCOq+7b/idECk1aunwnXs9ATCKj2i0c2B8CU2E6WFb+oZ0olHmkQaNPlYz42EoC/g3s9ljEkGwNVQrY9FsfL9zHycFJcJ5QvNqRRcVXcgoV72LBVIpbljGYjnQLmG5N0zBiK42F+A4+NZmpE49CJyeAxBxEW5oYte4go+tQMRGoa6xL13Utg3oeAQ+6Hxja2EfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zWE28zM8faslrCvyL+C7J/R16DnbdFzXL3HR7Q2L7m9Fm00DuNauX1LA4KLqf29wlZinR4vtzpemOwihXY1ahbX5DvhW+u4F4D86ZHy0F5Uic7K8vDXm6CJBmmmfHaEtT340XN9S6Mp7fc2cKSvfejvSnSF1XyBjXBZcfiivHOc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:17:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 18:17:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 2/8] blk-mq: simplify the blk_mq_get_request calling
 convention
Thread-Topic: [PATCH 2/8] blk-mq: simplify the blk_mq_get_request calling
 convention
Thread-Index: AQHWNFGe6NYpnw9iREWZJt26VAxkOA==
Date:   Wed, 27 May 2020 18:17:56 +0000
Message-ID: <SN4PR0401MB3598846E34D2D163AC0AEC649BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50c0c21e-71ea-4024-5c2a-08d8026a47b0
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB36777E990795113A6AFC3F2F9BB10@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpSWi0tKhjjd4RFe5XOFIJodp91m2C8iiCfnA9EZ1OcCfXpHv0kfY2noLyMQVxKIfDamu9Kgo26rRkSPTWMo1PwNh4iQXoTAggeLuK8+adwdHxJZzPLYuH0+CQDKpwybjsxv2NmjHfa9wvayRnXpjoR/WM9wO7RdJtYbPJvoWK5e+UvlgJs2JxwVnA/+UGjzI6hhRrE4LTtzQQk5dYbR/eAMTPogad3O4MjN1HeK4mGqrMfdu6GSGqwulXGq5CnxEk+3H8TXgMz2UoC2M6FETUYma9nQRZJXLZIX7OrApThnWkZqmtgl+QQoR5VT5iRAUgdH9Dgp5oOb7I7pL88U0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(8936002)(55016002)(19618925003)(6916009)(86362001)(9686003)(558084003)(4326008)(5660300002)(71200400001)(66556008)(64756008)(76116006)(478600001)(66476007)(66446008)(66946007)(4270600006)(91956017)(52536014)(54906003)(26005)(8676002)(6506007)(7696005)(33656002)(316002)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dI5nTABw3L3lueFiHDOVms0NLfxPTqYpNRgrleXB2YkRih2hT4SkuWu65WCa23nxIt7DDHuPZhe3j7IVpLcLaV4nMqfSy+oqRR12LLWeJG8wBSNNC3KJM7qNRunz77RpcpXenspgfjGC0Ra4T5BzKU3RVsioUIFBBznMSN+8nTPeTM5k8g8v77f4hVWjuVre3W7CWmpn9VSQycmsUqispWlqNFASHM9MFCv3TWNq4SVyyV/T3+CUKclGdJ6KB+p5dwfd6PcKvnkveriO6gQHLHAJctL9AyjtGnCBINt8WK0LntiuwLIChgyA/D2evgioXKLoBJDFhq8DP6Gf795gS49H1dcPpfIZoVJoW2Gwc5PO+8tLMyRnEdfu3tZdGt6y3LFuyIRpNKhE/6Cbw5FmjMo2TiNL+u71vIt/Q12hEDhrWj2SQtrse4OoBIJ1bjyL00uk7AkVrA8PajzbHH0CqDRF8XUSEW34NC8VDycUZzybhUzY3Y1E0lvHUtskqrC7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c0c21e-71ea-4024-5c2a-08d8026a47b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 18:17:56.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcAD6YQfD9VaPbEUMwkULwhJZkzHl1oTHOdH//wjubex3VsVqvfTiZxa5too/aLqun1sKkbUjIM3h+2CurGGnyXQeVQ6a4oV379+4mLUw9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
