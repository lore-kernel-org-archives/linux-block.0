Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4BC433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347252075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jeGKfOwx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cDh8nRKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbgE0SPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:15:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6169 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388720AbgE0SPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590603330; x=1622139330;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jeGKfOwxR7ZhFTy3BAHEWNe+Hwrw9EyxQ8RSB/Cgc9eyT4Z/nLqU6RMk
   dzQP/BzVKYU6z5TyQFRT4bpLhzDG4pBGOjx7t6Ftvhq6JRUdhyWdx9vIS
   hB00kObqZKnmNzfmg09TYDRJY8to4vcXvAIx/jKB85inoDcbOuhOVsKNK
   cbPBfUNg04jg83ZugbAPOvM3U/mz7BFp3/e3oW3Ckfswcv+kZnRjnw5wK
   yELOTuMf/g2eJrh+jB9uD/jUMBGxIKlmhRJ8EHXPndfmFFE9BJlEjhtwf
   r7SrKgXSdxrDflX2kSnjDYZNMKiAoi7O3MvzMJB6+KnoIoewIRmjsW40Y
   g==;
IronPort-SDR: 0Hmir60MgWxqGvfc4e3ZHGksANPv8VcLkd+N10XxkQNWq0gMTFt0/dAl+eCG0Pq4GbHSX+1mBG
 kQPDtVBiLtafKpX1AY1QDQQ+7f93Ih4Boa29nOFWZdUWwoG8Nq6BwtbLGexv2cPwH7Vkti+zMc
 slJAhLXPtO/+KSuZ/ELc6yv0njytDmDBBgTJc40OZodMpeukJ2f7ZS+xWrpApBgsnVFsLSkNRS
 t167QrKkVncxWvZTsg6nvnmBHd38IDr+MUKAclr+aQZHj5HkWomvwMdYba/iTIoTUKYsGUYIAw
 5gw=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; 
   d="scan'208";a="140068581"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:15:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPD7YUaw7KHl+WrF6ZMgCVHNWRUj/fJXyhjyRoOdjE0tGUHzGt4CAcufmmWwc0UZjw209hrApHBc8VlwQxZVVjQJlOlBcojeD6bhDmIIcAF0wn89RQW+rE5yot+4YB6gddkC8UdvRmtBbmVWBrFnR3BfMYE56Apkf56x3bB4b3ZDYK+ZykK5HN7aV5FUU1DMw7N3dXWPuKAhDfgp1M2kUaGYJMIlhFHtbcn7MTdJ6O0SJSa0Ihtmk9jnpFLAqU6YACv1OZNCvkG1tCYTxqNIYoo2ZWPweUqAAxRlPrFXmbXwjS8rIcRoC5IGfpaB44e3rZpes2aJSQqsGZ/92PswAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WX1YHk+ZKlXBVzcCsC0vUJExZCd2mY6BWvu5HMsZG1zOUC/2hDldDXmzHwMKBlqosVSA7DDnPyHPwrxUvf2ri8j/YipftMefeo0iCF388WXmb8Fx8nRhB3sMlxAvSG+DhO3baLOk9/UstNrkYO1yL34WRe4LM7RNwRZyxgFtWqcmVoCAQXizGs+I1xEs0+j99Qdjx3kY8ovIy3pd4KR/4v1paBQTvsUzfk8/lwnvg/dnNBKYzUYHaTI2oH3brEvUHh+hNeJ7uxJvP9ugPoRZYHea43eIgfUnQzPmB+xZlgtF2qJjJMtTRgdlxuY+ztLkQ4vDTqF+UE+px80oBNKKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cDh8nRKSvyzarj16yq88qOWxtvD2rSVyt8OokwJsLZ1qSjzlZq87L4gjVCyOU1p4tZY/4EgumNmqogdbfBTwYxCF41jKzCqQKNEhTrwD6u4B1OBe/qnvrlT5owXH2zlEp2dRAkLSr5fd3Y8qRC4++Gkj6V6okZMKGEsccq65JAQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:15:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 18:15:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] blk-mq: use BLK_MQ_NO_TAG in more places
Thread-Topic: [PATCH 5/8] blk-mq: use BLK_MQ_NO_TAG in more places
Thread-Index: AQHWNFGgsAp2Wpi4/0Gw5fJ/iEd8YA==
Date:   Wed, 27 May 2020 18:15:28 +0000
Message-ID: <SN4PR0401MB3598EA511797B782DB140C399BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d529b0b6-c341-4a4f-5993-08d80269ef70
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB36777646B29BD1A785B1D1689BB10@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vp1mjRLrIs3PWu9nGOvwYQ6xbflMX+7T9mE1Qn/AUgRVzVqWapeFt6J6cQVNmzgk11Hu+GP+ZQ4MOmpDTOTu21tM2GbI53Dqpo/u9JqtZuCOpdtnh/8QpsFeKW/INIclo02XlPYKtFrtnfcMSfRC7rkoWNfywEUENnOSJ0NBxg7cuV08L7laWU150MP9iVWfGrX/mB6j6JXtYfS+2U4pL4b/YBY007lz/STorunFbrUulFrfIQ7YvhurukOQgCPB+O3TEXXc8nQBp7EEJPLq5wsBb5VqU6Wz9wBJ3AiLcrVYSErgEq0KODvcfzZPQbVKALzlmVWhYAsNK/c2fWFuUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(4270600006)(52536014)(91956017)(66946007)(66556008)(64756008)(76116006)(66446008)(478600001)(66476007)(316002)(2906002)(186003)(33656002)(6506007)(54906003)(26005)(8676002)(7696005)(19618925003)(6916009)(86362001)(9686003)(558084003)(8936002)(55016002)(5660300002)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Y1QzV62gU3umDVpniu0723KOAwQfcfTCCgrUFWQgqyVnvBy4cDSysN1cNYK3eJRnMtNibEwPonGDs9EpEM0BxQFpif4HaCvmpd6nP/z2TgkOoESTQ5BlkMcWzEUnxR7cMpwLqnWxLkjXUclaUb6OihnqJOerVmXJAYFJGidkt6zyRRmFrbP97d4Bkl89No3kKegn29sC12EiE36Hu4Fhs7ISQ5Os4P1evZcEs88ghgyMjFPAhs9pMXlxJmAc/tXxeZC/PYkJevKEvmpFyBqA2+jQz7/u0UE7TeUFWZ7O5ccpzCsYwJpn4NodFB7ZXZdUyrMbQ4ookhFygJqAj3wtOw/QYY49zOFNdhCXPHWWf0X36qdwtFG+U+HoibmIx859VZ4KOyVSYaBbKmGSA7kDzZN4fnXxTh4zdc5ZG++Vsku21T/qyoD6SkQQlcENEp/mcyUt8DRMPQQCc7uBN8CW0Vt+Aj4kAerRL/zcTsk4OMXMKZD3W3MFwEarZBBmAmf/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d529b0b6-c341-4a4f-5993-08d80269ef70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 18:15:28.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUut0kSuZ4d3PogiIh2C5tHE1yQJitZn3N4mFWlWls5cquqiuWiCE0wII4wcEKQo/3uktjpkCNUxE4KUYNE6jtdaRyDzaBKNfBGCjuHzako=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
