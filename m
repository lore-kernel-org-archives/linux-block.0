Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DF1C2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F3A20740
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DCa2ToMq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ih9QIdX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgEMLys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:54:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10141 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgEMLyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589370888; x=1620906888;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DCa2ToMqzPYhB8ques7EoGIZE5mVpNvpdtUeca7KVo1N9VQP/YzKbklo
   +UyimpnXXtY78eE39lONSSRz4bVy3MmjJG8adReUwreAPlfdq4zZFt8vN
   rtgPtJVuin+A3uVUZ7YwyGfW8t9s8NsIxvnunPOKOM9NbBJgrmyGy11Dm
   oA/vuXcTT02rt5JpFurw1c/NnRBTJ9tpCD+XS9fGaXXScX+ucaDZVCJUT
   ZFGie5AFCe8PnEv+aoFj+sul+REiH8RsgJoK2Oc8pW6G7shpwHs6TQUMU
   6Yk3VNM5yk+g3m2dUsdZgtGax9A/wDgmuECvmRsoFTsURYXYOBgMqDsnP
   w==;
IronPort-SDR: ek6QQ1saZz6PKdYDOTGuxgKZeHmuM6LC+4nhyKXDzeIuy55pWD74q2gNs07c9pRQzm6uWBv/ZW
 eTPP34hf7LLe3BGAmx2WSCCZgnEEmJ7Oxh6wWdhFpi8bcIPTbmG7+lL7FdBUesayyUaDZ+NE3O
 jRAnngXBPZT0ST4UtZKBacqHSytWYQ9bacay0e4uJDpavsmOn04/B9X/KM7XcquU91KwHyadyi
 N/UbhqERQYMUk9v8HDobnfYMgPAnclAsoRBaC9vhjt7e77sO8OPX5BVwyvcXdFcp3pBdcZBEQT
 TRo=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="141923003"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 19:54:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAWSKrtqqlEPoxUtATTPHmEw/2l9H4dscZe1ysC+nGYLMHUCPbpsEsOJw/ZQ72/DIIJFliUuIIusiv3ZOue5tCc8embKmWVXSAzWmbfKNNcy6lOlJVxYP42egR/a67ujfzgyiaxtv83p5ktetcDBUvHaHsSoRagWzJC0dyiaDLvGojEsNCNiti4OjyEJYHosRGVcUeRBxePTWCvapcrGrGcqPo2p9GGhogFKQcyonm+qw4nE5r0V7SUKZk/QiDUZw1iB6edx2N3Greqg4Ds11DsQ/OYyjLqZ0KEYnFif3n+XM1a8vki0aDNOx1+GyXjA8bDdcV4U9ABgthw87a6h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DIszVhKGGJ0k0w2PQUMgPJNXFPb3PyCHHPM9QFTYnAIENmPZilcSbobj1zFiSh3z5PdZ/Ea30JAUNJhmuolDqqSsl/neerYbo7qbSNu3AIi8AUu0KhBDKc54E7l+aAuq17MNFyt7tPlLlz77u+DCuKrAKeios6qFKIwm+x+1+Fnbene/PRAy1M6o0vkE8xPAOljgpUjX1EFz0hy1nxwjDvAbLXJZHleW1S78mJllVW6GJDJv8qeeMhku2VfDeaVLNvnn0jiYTj5EeCByocuelQjxetNPqrdHzEkIu67V6RCMtB2GHoI0T4v9gWt9Z9d+LzLgf/eqvErL35FxuBGX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ih9QIdX0KvRyxPisepE+Ym+W6hKncXdYinfvSWkBRrppI5EG2r/o92h5miGkZ+XZvetnl5KTRhcyIFTWXXSVTkenOAnwd+L836Q0tTh45addD45CyhJ9AtNEiruiye1VfrwuuNR2A9SBheEKbIqOX6Fssw9bGu2MgpjRJW9P7/w=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3550.namprd04.prod.outlook.com
 (2603:10b6:803:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 11:54:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 11:54:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] block: move the blk-mq calls out of
 part_in_flight{,_rw}
Thread-Topic: [PATCH 2/4] block: move the blk-mq calls out of
 part_in_flight{,_rw}
Thread-Index: AQHWKRQ55dxXiX+zCUe1lFCrZvRxzA==
Date:   Wed, 13 May 2020 11:54:45 +0000
Message-ID: <SN4PR0401MB3598AF18F6D718285761237C9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200513104935.2338779-1-hch@lst.de>
 <20200513104935.2338779-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b2f6f8c-54e1-4634-898c-08d7f7346e58
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB3550C3583D46862AAF0EB0AB9BBF0@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g54EkbHq9RuMiByDyGYGdUOWyag9yx2apB0pY9TDP/hEU0NRVmRMwRdZykP333OEsnnxgNaKWzTf7zL31IH22r3FxvuS3xZJATScuHA/H8q/2tH3WSX2oe1ASiNGqJ5osQ8mDJqwwJWPBRY03OZsLkynWTKBTf+ciDO9hgcopF88cv+GiDFV+KjMvgk9hFhIAHKatVZD7vPSA1CQRe4HPTAxDLUsriyJABLmaY5wJrhFYxT3CgeTxvfs3YhlHpJSR+g2SPQ6KM0W2wPHJ5USD6xCwtyKRiVCDdOtvKav2CHG/STOxdoY/3X3s9F/TaTbI4sOqTbGFRvqtloHiTF/DvgPsLSgI5ibWy9j4+I6WWGDaeklZkV+H9xMOI2LZ45QclSZpBzsqz3K0lfI2trQyNBbRbzWHGeZ6YCibhasqBKquPuF+fLA+Kwu05yH35b7MOC1DQDt+UfPmTX4xOMfr5Nr4TmH+sgkCyZ5Upz6YT/qmThkq19cntI87qJtx2Rn3pO6XV54IzmwPTHxp0105A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(33430700001)(66946007)(55016002)(26005)(316002)(6506007)(4326008)(8936002)(8676002)(558084003)(33656002)(86362001)(110136005)(52536014)(7696005)(186003)(4270600006)(66446008)(66476007)(9686003)(19618925003)(66556008)(91956017)(478600001)(76116006)(5660300002)(64756008)(33440700001)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kLUgTe/ccErKFkKZRXwB2zfp4SNqIM5HXXpV6sKzCNAzsunEORPKoaxH6CRiKLW5rTEuNvx+NmgUF+dChVtkaP+olmDwcd3ngQNOkLFBZ/Kvu0Uw6U+lwR2dtTJFUESN2epnExAAptTr0M2ljtcTdfTV6IiDrUmWbFzzpGoiCnxAvWWjxj8ckX/45LVjsVah0VtjOs0C6K+CflJc5o8FqYtlXScKQ3lbJpvt9S1rTMRgprTDqHzxgTA4tBixRKY1Ewp6TJ5cY69cTtQfz37U9hwFc7dcJ0jIh/1BKuCYV4/xu/THUcNIHVZ1vvxEO0o7f0EDEE3ULfcSvT6pQ6FUebt96GjRcIlRrkYVk9HhT03dHgy9izD2irnjmygV/xcQtjDAcS/t0Ly08+O3zSj9euAukHGg2VBUoxAoTHcbwi2gJNf6bk0nrufzYTSpKP5BLQtCohvqNliEti58LNkLQKctY7CctbW7JlR2S9bWKvabSS/N4/TgRqm5vE3XgqDo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2f6f8c-54e1-4634-898c-08d7f7346e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 11:54:45.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5xYS5XMrYxAqDe8dfowl78liyEt5JHyyNXYdMrb9S5WAZfB/PmlPUINGEhtyp89SZKdvUmYLAmAs0A95N06mgXi3aYPFmW8Y+9WH8izYxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
