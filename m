Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B848DC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A15C207C4
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nfYah+u2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XcsaoBw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgESIe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 04:34:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26242 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESIez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 04:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589877311; x=1621413311;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nfYah+u2Jc5on8oI98kgk5k8tqtEWQZbMvRJWwXyiY1IkN3mAaqURKgP
   RRXMBGWjFk0cub4jI2sr953y+MfLstx9mkvqq+0XozWaOQCMUeRuKJvc8
   j4IO7wx2upQW9ydaGAx9iKckFD+DpDrmHVs49RHKhDWs5UYEeNPCyio88
   d5V2CROPPRVBHGNayq7JcTqfS6dry6qGgdR+qY2beOyx6OxFqExJlAsc4
   FLSDQhHE6d1LLocc0cTeogZo4HXzaahPwYo1JrctgCn7ftxHspS3I0ugU
   BpwdW6X33aI6Es8BDzf5npIsYPbQDDk93GluH+bPUCPr6gOQX3T0Wso9T
   A==;
IronPort-SDR: 6Zkzsr4pf8yp6hXqr89ZlyVfxtEPh2hRJfSpr7r3ik9Bi1c2rZn3aSaGjQW2eIBGx2b6cOBUD4
 ZEAN/QnRWeD6r9oiAZuONssv3HfXsN0ZmPkfr2JrHHghZTLoZJQ1vexl+anCN/CKcfNrRgxsyD
 ab1SUSUBBby/n/beJ3ahT8XCgjg9dvC6R0OGyXj5uYARoMVVg9nPJNWSODU2XFeF7f9FJa0Zct
 oePHOzU25bLjELnu3IM9QMaHxRUiR33O9AGGiTWZDzkpnZWe6lvrmdwJaDlJu5oowEbTHoJ3KH
 l7k=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; 
   d="scan'208";a="240758875"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:35:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9zNPHcjscz+LeGhCe2ie+SUTAhy1jqWHyV4aZ1B3V8uLHDFXJEAUGWV2TZOBZMsE+6kMsQKu/zirtn/V0x/SIYlenb+rsRb3sVhYP2TKEULj4PEX2u76flVIrn0kxImq7ECBJEan3t7VBG3NGe2m2frIg7y1ZWC14zYLuYGEfGmylHtVQ1DxlUOc8kUohfb9LE6HGhE1XPw81rtIYwTDv21oRp4BHt319WQDBjslozLgDrtU9AKrVVcqN+XlVK8Iuiwc1K/S0PsaCOdkBg/lp01ZoyLGoHZj5u8dBO1hW4Bm/dkg/sN8v4JCNozhLr4y8xZVq92jyTXODwUdzPYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UQHFC86kZZlvbZdkQchAj5WD5euSxJzvAj797HVwat8zybyvuQG2xq8j5d1EhsXTsc1OL9GFg1fUcDhnEgsRW5+hUDZhWx+/+Z9HY0VR3CeaaxXm90mc4J4hiZIzNlF3DHoGFKMtshXk368rBB8WmEi5cub5fSeVqcvUbivAWbyapBItOaJhW+0H4rWZIa+IaTLDiyKBrmY7fAi02gVekx/YBpQJcn4o0VUUq8IYatocExtSK9k++SiUf80ngj9ZLlxPWcQ5gIInNs3egWfD/Rco7cDk0TImKHoL8JgxdBZXxxFrI237HgV6Oblbp2MZVhzyE5Vj8w15RVBHDi2cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XcsaoBw4HkbZb8ccuuEEylUQ5rvSvkdDOTAeqvH33NRFC7gTXfNSOxXWyS8aGc0pB/atAQXEkkjiGuwzaOKfZ1dWq576PZ6/esWSLlomqzy61K6NVkKIC/pb0VMbr3VHu/uXRp/bmNd5rGOVCU0233NzhDLkf6F6h5tZFkHxBbg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 08:34:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 08:34:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/4] block: Fix type of first compat_put_{,u}long()
 argument
Thread-Topic: [PATCH v3 1/4] block: Fix type of first compat_put_{,u}long()
 argument
Thread-Index: AQHWLZMRbaLjnJLAhkaQxgopTt5Kqg==
Date:   Tue, 19 May 2020 08:34:52 +0000
Message-ID: <SN4PR0401MB3598D504EFA3D3B05E27FDDD9BB90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200519040737.4531-1-bvanassche@acm.org>
 <20200519040737.4531-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c396a918-17a3-4772-2bb0-08d7fbcf806b
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB35670CE5CF9766E778F61C559BB90@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ci8qkMae7io5SR6U2tOAwh+FHNBOZ11DK3fumZs7BiOXbmjAIQVgLaEERV5kfKkj13Wjbjeok1lRrHpT8Si5AwMWOEsiKaNAwTgJXVMpyLBPktqkm9dr05UnHGGm7fEanhvPrrvWkdx9dbkv+N+FyAVa7tL8dZWqZYinWdz8FK7q4SNzr85c1JoqK1XM5inFGk1P9IyYCeJU2MK+3c96lIx1lsYqHkldFoVy/XA/jFjyPwBEQ8vyAPKV4+ybm/zbPoSQFcdGEmkfUrnphjXNXCx9WzHRMgSvQbhSLkqhQm5TBuWWKyrxrOGekAa/jzWy6cIDGfewyZL1+NiKFTmmgZRM8WOng/Kg87rrI16XkyjUiosEzUM1QHjPYweAo4KrRKr/pAgk2p1/bsf76tBZ4H7fXYfIheo6r3bhhpEyb2P+cAz4Fj20jBG0VB6jf/kv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(33656002)(478600001)(2906002)(52536014)(86362001)(4270600006)(55016002)(66476007)(66946007)(9686003)(66446008)(64756008)(66556008)(4326008)(91956017)(76116006)(19618925003)(71200400001)(26005)(8676002)(316002)(8936002)(186003)(5660300002)(54906003)(7696005)(110136005)(558084003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BgoF6LOiiXR7BkIC+ZtPBtrrx7XAJjazdCzxrtoRCxG8KA3flWa+aRmLlripOSLTm38PbsPkuQTGH5dcuFru95yX2esqEcHYpBsmsYaxud0SzsdzictTICY1Wi8wZE+hM5MQ4X/khmZwcWzJ2pshwkgzBQ4P84a2fDUAqU2GZzXD3DA2hIHIb7OAOsDtYvX0QAn+uglNAyIuHtN4omaM5J4TAl9aV+X4YK+MZW2w/morvtMqLu5RuojtRoYaVPmv/YS3HDbWIcgp2t4IkyX+WHN9ErrGTQQHykXDB2mSZdZ0m2N53Knvijhfr8o1SnP1pgeZF4OE35wsmxEs2jxfaadgpwbdqz676M+KA7RNicpfszV+fs4MIZ+OaHwpOue6J8bQP6uwbR0MM2Y4/Xr9NAYMpF7Vt89y0MCs/7BUkmcabYqmmsrd7XxXELVVXF59tbjbYmJ7zOCa2cXkmGaRXZq1lCuHAXtQht7ItXA7xk8GiYCgL5lSV9fmfpnMGKks
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c396a918-17a3-4772-2bb0-08d7fbcf806b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 08:34:52.6614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGMt3RO5Us0VgeGcS+4uTNnbgffiV7ACeau8LUXrzjjykyZQDcUiRU8zUB59bWQR1YTZWU9DscxXgR9+V85aGf438S873UHKE9/odOKAdvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
