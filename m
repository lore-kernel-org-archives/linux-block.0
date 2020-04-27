Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D389C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 10:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A6D206A4
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HvIWbBtZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A62vLsNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0K6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:58:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36862 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0K6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587985101; x=1619521101;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qcj5yX1cSUjuXyKRlZRB/0nKmk/ZHYNmZbXB2QYpeVw=;
  b=HvIWbBtZtYMVcF1jFbKTHvWp9eJHZ3ZSxKAiP/Xez//VAYKVCyw9e448
   jNpA4Y1PNFpJrVNi+fcndyen/03ZwH8hPrnuXH48CdJO/LeB6wPLyWDY8
   8cLpovy6mtL11I+csGyvVq/5ZtXPawJmgJ0Qwvj7s6eKUZpgfDCq9H1MM
   vLi6Ztw7kmsag4iJsTdqwjCFXEk/1JGiAElD8mhvYu4Zhtt7mp4mvY1K2
   5uk8DRK4bb4uBeceasetE/NcaXvT3AElfpmZlW0+I/5Yb7FZBOhPRShZF
   lBg/LXb2kZKfbnqkL4aBzApkxdEj+sG2o8XPLHoW/U7YRyi7ltqeEfCe4
   g==;
IronPort-SDR: kD1hG74Nshgd1E3BPQYhQ4Ea22RMwFplwKHCd+jCnB4BdZRFVLFln2b6SXVVg5+aRt2TJhSP1k
 Zu8eGSs2fWi+LEf3k417BADfs0r9jGRanHbBRkQtU+Ukch6cfHaMQXFd3BzMLqZmCdZfmkb409
 /Klp0p4epXZ3iYXFZiD9f5sjuATd2q3bHdy5seLaAvnhFXuudlZUswBQTShmPYEjrAr+OpVRM6
 XQiONBrWl30vW+Sed9W+LuW2tn3nYs93gk/cx077MgL7KMKaxGflNwMFWoHHsksjFbz04/aO0/
 DVk=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="245013735"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 18:58:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh31jQ6eaQ59WKgH+HLwxnPH4VQeCFwzObJF3nALkWuL+/fXZ0xXJNmyPSQf5qJ2H3ZK7JtZHMDL5CR8fBQgFYtR5eFYmjM416iHmj6sRPJpiLHrbovcXVgcO7yjLwlxsYRJ+0cC0N0LA5l61GQD53n7QZWyT5rKN/Jv5+XWV9BGMcfWu+jivHxqCUaZG3eVxs3EWKGCUPeKifOm0yzCOZ+RqT/vZWKYRBE3Jb7oOrHcNgIE6yfEiDogBzDd6UMyBQzUcHDG7RpZZNqn1YLPGJZyVYCMSPWR28v/e3pYi218snGwJ5hNFlzI7qsHib2TxyvbheS6Rod+llWX+GEoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcj5yX1cSUjuXyKRlZRB/0nKmk/ZHYNmZbXB2QYpeVw=;
 b=h0AaNjVE/ll2b9tEYeKn/FoVYfrSYcVT+F4AkRsMGjkD1dFsLapsMvAgExbx66xw+PcswiJ0nfxHk91mUwqlI/yYE0G6WV77FkVlNFVE3fV6Kn96pVG3F0BS/VZBeuwUr842KYqYpIlU2vX4NVxQzhzc426iir6wIhFqIFuUX8hYWjPnfbDG88/D4x61jzJEBB063P1l6CwZHcXUNIFKvuLcJDRDm7zRVYVQx5KUZ6QFQ3dv7TyJHeXCtGpsYd5QttJ/iyIWkcGDSkVl2RkCPgFOsabUMfXtsstBvqZgruqND8y7J4cB00YFP96pX6yw9zngr6bByG2Zo6knoduEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcj5yX1cSUjuXyKRlZRB/0nKmk/ZHYNmZbXB2QYpeVw=;
 b=A62vLsNQUlLVEdeBDu7+jE8E/u8y6qbBIZt7cJ2ic8c2PeOOzR95kSMUtpzuYSXK557QlTDTbp1WLykAqt7nzgFwTfSHzQ16Mjcs7cfeugZYssWuClVulWFITFh87kgWXOoCF6TPT827udSJ1s5gNK3ty0eztaGLOvV96cR0R2k=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 10:58:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 10:58:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove create_io_context
Thread-Topic: [PATCH] block: remove create_io_context
Thread-Index: AQHWGtbh6jfEt7bZtkis2YOHTfz/FQ==
Date:   Mon, 27 Apr 2020 10:58:19 +0000
Message-ID: <SN4PR0401MB35985A1BC8F275C47FD0E01E9BAF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200425075516.721532-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbae018f-96ed-4190-834b-08d7ea99e54a
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB3520908EB1A33C3BA2A644509BAF0@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(5660300002)(76116006)(66946007)(8936002)(66556008)(64756008)(66476007)(91956017)(478600001)(8676002)(66446008)(81156014)(86362001)(71200400001)(2906002)(52536014)(186003)(7696005)(110136005)(19618925003)(55016002)(26005)(4326008)(9686003)(6506007)(558084003)(33656002)(4270600006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GM5jZ1jaXobMgt+D9xhEQ0rxwP+LuWUVIjaImnIiRs0CO2lRVs5c7UD2/ERoCYNsdN3iLtgk771lVfS7x2FaU2KUGJ40ItP7QkhwAVGBdomtpT6n4r1YnJuABZKcvEJCPrmXH5mLoynbREqe6112y1b6Q9lbu+Db5xKiLdF1nPH9QJyL5LYlIPMzWHEnJmsyEtANZlDo9ukiKKm4fN4SPNU3D5R2eGSI8rRWTQdLeRfw6IRJK8aZTjZASwMPcRUfJPFixPP6FNvMf7NBftIuyJDjzctmksiBrtLPUjkn3lHi2djeimmgErixRc7+QZdOt/C5oGa+pCpXvpRPGYcQYTi00lCqEW2OG7VE9z3y8B97jPDBeALpkA04dPdP8Y4xfNjXQhwtCDH3nYgBq2RdsLZTDslpjo3d6nq6XUNKLweEXxaj4f+U6TO2Jxw9R0S6
x-ms-exchange-antispam-messagedata: C6WmczQItg4+Ru05slPkGkJvrswY9X+IzH/Buh3FEayjFoWV1PPhkP1IgLwkQneCZI3ndFPGkG670CtOPu8w20IUo3AmV/uigxFTMkb2dYRqlOm1E8VEPPKYJgERrsEHM8K2ThEBjXdaF02JXws5z124kiYm2JaOLuBwkQBlXhegKJdZC4XcSkIHJ8bU9kM4rtClwMnKenS+59LqLQeDVmOgeKJJp8OSjuM1UK3jY6JExb2wASu8UMWUSFLcgoYJsLcwAzR8w2TauNURmYrWxFGefC7Ev+Q9KlyxNL6eKGvzHoekddn3Zs5WMh+Vjexy6Py1nZaEsSzzxcDtCXHbDq9CcRS+TmRb4ecpJbI81nCTNy2FHiEUHrC8KNj+ZSH4Y7TaSDgVVI7okEqcZRYBYU8/9GdOftdLMQixoQH/H6ZWWcZSnLbHQRTacokpEpvEtv5xtsddqXcfsv3IEoPpo1Qz6JpZASZv6eQgddF9YBiyJO1M4mcPMXevVcL7Q0noG9alY1l507Cnwt29YcE1g3ZhyYVRXnEhCVFMpkxcTmcAoMTb5vsMTRQG0auNWchhsDoYdPgJeRmDyf4Or5b643Ad/edvs3+clv3BCzNhiVZKsUqByDUbElsSzbaaaBthIs2DP0rXvImGWdLNAm24fCvktaZVDGbXxCNXVctSQpAbsVh4blK/XKRfA6IMBWEZKiI6l6bc0A95b/hOYUYGyHqqnWNZVVlQFtDa7/dJJ6jkTzvqjpAbezGd8faWgs9UIggtt5yygGywwU2iTfk0/KwUp79kj3KlSLxoB27SqjE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbae018f-96ed-4190-834b-08d7ea99e54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 10:58:19.2766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2izvQynbTWHYky0ku+rakugpodvj59W4GsH9iwxeX3DQRQo/jW6Lsn5svm942Lz/AhlovIIMQMhNSpaY+sgg3Zi1El5cM108wOIuzkdpR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks reasonable,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
