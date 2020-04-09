Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13542C2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED5120857
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DsCJ5Ut7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oElHu0rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDIMEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:04:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47832 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDIMEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 08:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586433860; x=1617969860;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DsCJ5Ut75GGAHwX+W7aXcznK8vF832+PwdC/F3/Mu/WuMv7qXw3DepR0
   u4kAlnF1qcKIf22xkKEDT34kD7aBI4qWOpZmuEBBgc+1bggrJShP4vRbj
   OsWduBTk7H3UJJIySUPG9SqES7LHeJHgkLsqyYqYqxxBtWnz2iPKW/YcE
   ydl19xcyFc6rWUd0hzB3vlBiHIdTUMI05CGXOP8mix1FFT29cgm/ISZKN
   kGaXFb1yqKBdYaZfKYY+PbMoj5ihgw4AEPop5KXgAfLJEW+07DX79l0zJ
   MFKSC875fKt+3zw4lxW529VNvmTOpLVvjehEoOJnpiTcGFv7CxQYrKQGS
   Q==;
IronPort-SDR: Eww0TV0dOvsMs+2NEvt2Il42QD+TqNWLdi305dkCupnilKntVdLRJAXbdexyLelqHR0qFNf1pP
 s3s3Pl703g+OvClcgsIGQ9Qu9wUnZAmWILOq6SalV7HfOmwBrgJNwKnzRTaIHDQZlWP4Wxd571
 UKAIm+NKmc8uMwQbij5aROHgzGx5WZp73kFgq8kz6C20244cK16niX7+V9fGrDKzBZtFoLfd5T
 rieEVzmpYOn0/kSLll4NjTo9q5jAng7wvo+cxD7aFZZ3BRBsd74QRx6utptP+vUJJgK+WxNzUz
 1lM=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="136404263"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 20:04:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWrX7Xh4eC7DF03N9S1HBUociDrpQUNt5McN/HzHsSQDbWlIraBnbaGgZ4cg2hjl9G/V6+hvbzZoP9zL+j663M9HbJsh6JSfvK/HnPTa/3Os3T2yglRidFRRN8g+e0WZsq4T2crrayOUNXA7gC3inNbzW5M+xbkMuanhvhYv0NqLsXXfg8k/1sd9PFLPK4tMUux5XzctlnMckEvZyFakN7i1NgabsydtoisTAh+2BguISxS8HtYfyLeB/BfosL1iCdmUtdCXgbAg7YsFkNiWfQXKTaB15yu4V+b6g+LGPj1QrwiwZuvpknk8lzDKPhAe26GOAwkWhsKjF5GFNP+UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gHcWvAXFwumXzjLD7TC4VauqpNOdwi6Ya8JZlMC8dyZgD5QpBjt1zlYfDvJBsl6UOKj1GBBYBo43eHce2aPA8RCZ+/uU2z0Qmm+nQdWCIrZE2ujjGwuW+Oi6sg87trBTA68Jy2SFIWq0Z0vg27/zOhjnWafMdhXzMPxUYhFLCbwrxpS06CmpXjEyK8LHXqcg7f6NJvBMhYivAySmwF0RT26fImxSOBG2y14HhctQ0fmTTFkrSBOA5Vl/R8vp/cH4XHCQ6a/CeT2ge6YfzZnc70h9GNr7bQ2L7kfCM9MlJ792CwZhgJ8ZcUYF3rbf8GrkASv22tJmOQlI7wpiowbpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oElHu0rHkOkzQOOgiYnFCijZ29T8mVP6BVtypllhwxBzyA71iYhv6MrTfcPViKJAqPo1gj0dIzO9qCoq1WaGWt2QyOVq0A9EMh+TroiV5oub7p5jNOfv1mfGSRwEEwSsANXdoykvG7ow6OSoNMm6mMROCXeCID0JZg+F2yeRuLY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3645.namprd04.prod.outlook.com
 (2603:10b6:803:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 12:04:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 12:04:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 09/10] block: mark invalidate_partition static
Thread-Topic: [PATCH 09/10] block: mark invalidate_partition static
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 12:04:16 +0000
Message-ID: <SN4PR0401MB3598A312E1D037F42A0F65239BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b5df2cd-b063-4542-63cb-08d7dc7e206f
x-ms-traffictypediagnostic: SN4PR0401MB3645:
x-microsoft-antispam-prvs: <SN4PR0401MB364535EBA0C386662B86F6D89BC10@SN4PR0401MB3645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(7696005)(19618925003)(66946007)(5660300002)(558084003)(9686003)(55016002)(2906002)(81166007)(66476007)(52536014)(26005)(316002)(4270600006)(71200400001)(64756008)(66446008)(110136005)(6506007)(186003)(478600001)(86362001)(8936002)(81156014)(8676002)(91956017)(76116006)(66556008)(4326008)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtAYqlLKgQxElJKS0SNlsqCQjvaGmrJRIU5AYvhwiYlBaJ8qaPU6WxVdnhbn/7VTHda0Hv2pGPdatfwp4whgnslq3IeKoxrluC3Yv/ARmuCHApSmOyoSbiRB9s2CG9cTab0bj7IOflcZ0x+M+pN9RJ4cLl87yDr1SfD3/mNNaZkjF0/QMeImziT0u39C0kOl1oCEdKgkm51eXhxqA6sUP74HnUus3cm+DnjTalVNcdSr7vqwkMQOZei53SVgBB9wjPSqWf6zQzqbrK4v9l0B03yf5UDLLTD8sBSwVUTotx2uJ8At1/xkyPITE3yMHJqJccvXH0MkYGkOovoeHjgsrv8gDULcKJ7FUiVyIbq5Is8c/z6BE7wPfMHpHvjZZCM0gTsGwbgGoqWdn/HrBE2Pi5H0m0dMA5lvyjoZ0SxoOUXiJ8tbLLiEMfN9fkcpPZ71
x-ms-exchange-antispam-messagedata: bJad1KkLmWcRtidwmm5eo4HkQCWzouyVdL6WXlkE4PeMfJhWSMDLjtBiDawzft2HNj1a6QqpExpiWBS7NJnZz1mb6AGgHjvupn4v3hUnu4ET14duNkljlRXDhNe073cC443IjpBlSlkfeObH0J5piA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5df2cd-b063-4542-63cb-08d7dc7e206f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 12:04:16.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDezKZZu3ShzkIQAOkAWKQbc+Tbz90xcad622BLubaOsO9T1FulA7SYqCzEwGpHrZxVgS8Z/4QYL7zdW0hoSNLVkARYVnj676cwWo6gm9N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3645
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
