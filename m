Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB88C4BA13
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 17:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EBE24685
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 17:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NTW8xscj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bLME1w1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBZRID (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:08:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10762 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgBZRID (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 12:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582736882; x=1614272882;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NTW8xscjDLseTLoS2TvQi/bKmES6YYO5/6XDrmlGXV8rTMxmsFd7clzW
   XuBiOF1tL6zItp9KhPi0PQ/OI5FVJT22curuWVngnQAG6vECscugXaEO6
   FGs77EseHT5QOjMrt8EHTsh/Tg9OR0cBzlBWcYXxmvAiywJ2KeVM/DbYs
   6hd/v/A7k9hIKsArQTqB4yteTdI1T1262B0q594gbadNyrkBGOjXKBIUJ
   gNLECVVl9H+sIjkHkmxMWN/kno7y8zGD4udcnDAdC8zEhsMMCiiSFPjzb
   doXJXEgohNEctBqAxyMIszbxh8qjqqsI4uO13ZiKCPNaFZyxLcYSzVYVK
   w==;
IronPort-SDR: mL4uAzYy50EP7koR0QYWe+imUGozowGIKY0GTrZ8fzEjbeg1JaIsCwNx6nWcPxE+R256Sheuda
 DQR6zfsv8HXQohSRUTfrMbkEyeOl4gUIC3EAmE50tVB7n95cnABwbikrXT3Y9QCsPusyJ1DigE
 66t1zUci/s3aYWcdjQ0iUHBlw6ADNN5fyPtnzYHX7lNnKcqwN6n44CVmULx9DBzVgGt8mvOUDW
 rdqbQVtbXWe5zMzKAv9kJGbUsfGKZGE2lJt0uBNrU0wruxgEyFVXO0klvzG2uogWGbTfeoW2ck
 714=
X-IronPort-AV: E=Sophos;i="5.70,488,1574092800"; 
   d="scan'208";a="238957754"
Received: from mail-co1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.59])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 01:08:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3o+W73hfGSLXSX+JNd51DK5nEMe0/pHtfcL+vUq2gurURRmrOsHwc2lel9v3kFa06dC16bbhoyhVP7kF0sLaSUxqXmiJZ70wJkwGi1jmSPunPy5ZI9nSSdfoLjVmd1P0YV3aCOeuYMJbybwsVPsYFHkCXabKYaYoMgY34yGyRp0nbxIb5nFDpOrghr1r+UJ0QZpfeFHYcAkIVH7eeqeX0YYtQtb0pcNW34Ta5xgbqpR6gN5N61DJtQeuck2ENA0MngEWvgyGflHFcgwK4DlKxPf3W5dH20McgsTkcS3yJsY3tvJNSu1ISizna1mwuQDPJA6E9MxK79qByJAsAY6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=H4vptbNdnOYveSPq97tScz2e81igY2DCDhndRoxBoXufUH720XvucSRjinbqy8NxTi7YyoTfZygrcV1sVDZocedJDe5nEC9SqE3aza/xi8Vsi9e1+hy7wTk5+V76/q97rqsXAONqBC4Q4eLRBYl1ITdKL7ibZa3HSVocnvwVnoZqaX8xFKYVRAemScSGFaFesnBssJgcHgMnTmtyR/NnIBJ+RAk+Y4SXPshqH0U5nf1Uvta7xOxtDDzCr5NZp+wsykGjkNdG3XZDeREMcEjsAUJTlT9MpLK9XCBNNVGI2r72oFZHtJL2LRf+ABZdvM5FDEIbEiN+yM3i3bxcFskPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bLME1w1oNHvtXCTxWXRPhJaFAwjVlqqPd23+idVn7REWlPXryhz2Ge243wUU0Dc3AG3+mSh+jrb4VsCRK93PvKU3/A5E1pmJXX4uvLuQj2KhHnkXBASfKwCdkycg20nKElYPrWK0cwJPND3+n7axHdrk5dqRjTuc9UJgrAk5jZA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3550.namprd04.prod.outlook.com
 (2603:10b6:803:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 17:08:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:08:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     John Garry <john.garry@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Remove some unused function arguments
Thread-Topic: [PATCH] blk-mq: Remove some unused function arguments
Thread-Index: AQHV7J5exc4LYokoHk690KRkFSTqLw==
Date:   Wed, 26 Feb 2020 17:08:01 +0000
Message-ID: <SN4PR0401MB3598520BF9F4F04F1F98F4469BEA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1582719015-198980-1-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69466a01-fe49-449c-8154-08d7bade6fa9
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB355048072B55B987C352E90B9BEA0@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(8676002)(66476007)(71200400001)(8936002)(91956017)(66946007)(478600001)(86362001)(66446008)(5660300002)(19618925003)(54906003)(66556008)(81156014)(81166006)(110136005)(76116006)(64756008)(4270600006)(316002)(558084003)(6506007)(52536014)(186003)(26005)(33656002)(2906002)(4326008)(9686003)(7696005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3550;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmmP76Omp+CMxc/DIw4o0QlRFZtZqibnFYm1Ngg5JUJxS2NfveJp34stXjUrJl+cw5NkeeeXzyuBuAEqglk2JJgQhYactdlDYHnIYvMQ+D3OmkZM8w1ZLJ10We5vKPZQOtnq5YW+1YQyyzp4uc9EtWaekKXd9wIu4YYzJ6L97MCAfpawLOicIHFq7DnUFRKPFqRIoTFEgTwUHTNt2zLF1aIAH1lFSGpolCSX95gNkX9oPMOjkDp40eGfcRp97Kg+violoTdKNRcwZZJH4nUutHL58ZWuYCc1JEeQYFq2LpxejhY8tkS/QNJC6jGNJ1AtKv0CnZf/gdVzttss/lTB1/F2NoceuZnTGsCiUSNCKPbluUvhsVEDSqBE8TuIgTQWaVTsLILcxHri5VSAbPclSzNpIWELLcmk6GAro1yYaqeT+MGoTydKLPNooutWhQou
x-ms-exchange-antispam-messagedata: za41K6L6micOWArWV5BxZFKfow1tddOG8wcjfANpoYptGiOXFfrRm+epq+LuqGaB5t9UgqXMe6phgSDuF7e9tlJLpoEGcRvyHVWWsLkZe5RW5FkC4I26ZIskxnZQ6BVOfMIDalF7mFjfNQgrLP/xag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69466a01-fe49-449c-8154-08d7bade6fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:08:01.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjqT2bw5l5BFHSp3MNIG39b/n7N3S8zRQBkfe4YHGD6BQusQdKCa/LfYKd/4d1K7hDJn9JgMWrrpeWLinCnGkJ1WnhQynSlz02AtviwY3O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
