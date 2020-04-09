Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04834C2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FE42145D
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RIkZD2l4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X7Ri3ZGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDIMCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:02:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47668 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDIMCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 08:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586433762; x=1617969762;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LKcz0WG+goMawlRfeYCEdILkpEW1tcIYfEOesfftnDI=;
  b=RIkZD2l4TZEwylqmfdADqDxlnBqGzwdchuICeE7rQ8MrNe4M2leR9dMv
   r1TYOpbGS9lygAevIrw2Y8pJ7odvwz4ZiRY2dQqLqlOQw0VvE3eQCzHCI
   L/LOGwuld1z//VQdR7p/xQJICIKn1CIR/AHs+vqjR8GP/HO4TzTOBYSP5
   t3Q5NC/3CCZ9WPsghXqy/HuCZsf70uy2juIaKny+ugKSHYh4lHQASQ6zN
   ihYSbgKGGzYvDZPInb7lCwEVexc1uta+xjTpUsy/OEB1eMzhXKomB8ADQ
   sOYikT/IvJXp1B7fCNP0whgdzExr2jqjzkJ9xlKNPEI7J2zxK13MSKO5L
   A==;
IronPort-SDR: pmkmjSDSOMKoCNB6suTe4Vlc81ukcev8IEyS7pyN7iOSpQtJS7xJJShmPj7/mtElP9YRfx6+xa
 DputtTfrbbUriIsL5K+r9XjfOqDimWV+Baq8RxUosmicDk1rn7hvlPzhAAaQkHgD8D5JEOEcd/
 nT/w2c0qobvdcu6TKkuILoX+w55xwWXV6qkY+Vg7Bjju2YMcHEVKjqMkuFncE/E7r+CjwAZoF6
 K/xs5g1Qzob7Iql5ElErAiNK11E+wbemKrB07Ic3T5XLvfPU1uDGise+BCAPTRrzZx2Sm7RbVb
 bak=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="136404164"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 20:02:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFkUBsGvPNXK3/rA8GS9I2/lsIPtELsNs+zVMUsAio21nM6v0pgdQyMPA9fmLS5X+AXWZSi5rCsy13OE+dZUJXYk6Z+QgI/qerZSsWXdUxtP1BJwAg9tJlINV4tNlqfzqkihTpUEJmhSX8zzKzBk2YQ8jqIxlqxRYBBx0TGaw43SsoqXomOx3r5B0gbeNIkwnhyBClak79n5C99/0j3dYueGg5D9QhzREaDQcvGrMeYtrDw8Qmxk2j0yzDzfEWAR/qxJZ0tVpKIGgWdWR+fE0Tbx/GxXfcne7T5/IBzlr6lFzHI9F9mu3e1+ShogvSKR8e6+ULxEhRUOa+GDcOu+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKcz0WG+goMawlRfeYCEdILkpEW1tcIYfEOesfftnDI=;
 b=RfbIsrQ3lfTwd9ACRJ2FWbN9hTF8azDRsuCDZCIQ+Cikax/7UoB5C2nCKM1m5H8NRKAf84tixr+3fhHr3maLixW/XBZiFcNUkoCxOo1QL5d19Q8uDe8ix8FhiADFCDdXKpFv1WejlgtrWUPb7RphECYWQSU8eGw1yl0Hps5cSaRML0K0b7ZVny2MYm0uVRbHgUkU6PNBcAapKhV37IFXNRmPCMhKdvcM9coI8v4KvlI6L2HEyAqeAFl/0j2pX9cEcG6QFZDb4iwovTgd13qa2yWu99oE1q+SeOIh+oNclEpIBju0olmAWZu/DNYDztmQgyjjgmUZ9BD8yKGScPwbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKcz0WG+goMawlRfeYCEdILkpEW1tcIYfEOesfftnDI=;
 b=X7Ri3ZGpXaFvxlw/Gax4z+nHCnBwFvPH50H9IPa7/CftMSjqCeYp+95R8Tihs/XCAnsTxOTc6Kf85lJT8azDZGbib7g6M0+5s/fEokKMPqhkSQUw1JQSnor1MLTYe6VeB7mHldGcRAkOhp+QP77sA4fs4W2ZdmRlfMLLsydFQhk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3631.namprd04.prod.outlook.com
 (2603:10b6:803:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 12:02:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 12:02:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 02/10] block: pass a hd_struct to delete_partition
Thread-Topic: [PATCH 02/10] block: pass a hd_struct to delete_partition
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 12:02:40 +0000
Message-ID: <SN4PR0401MB3598AEB9E6A034AEE87A606E9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 227282c9-869c-4514-ba4c-08d7dc7de772
x-ms-traffictypediagnostic: SN4PR0401MB3631:
x-microsoft-antispam-prvs: <SN4PR0401MB36315E8837448208B26C648F9BC10@SN4PR0401MB3631.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(5660300002)(2906002)(66946007)(478600001)(76116006)(186003)(7696005)(4326008)(33656002)(52536014)(91956017)(53546011)(26005)(6506007)(66476007)(54906003)(55016002)(64756008)(66556008)(9686003)(71200400001)(81166007)(110136005)(81156014)(558084003)(8936002)(316002)(8676002)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YTYP1v11stICyw8Sq8i3ukJ2aEoLCItyB0BWMjwx/kANGnHLAg2Ij+LUOlJNBcM6Qk3uKJ/xVUkwB2iQADKw4SKuXLldvNHaGvBfNtYhVrGNx7/guM9aLZsfUmO9cqV6cDkCura0ILJsn3iGrHraqlSo06sUn1Xa6gpM3Y34Tc7bThZX+spvn8IxLyh/c6ohqgHljt/6xD8OFmrZcIHw3PcnFbQRH0IqX8bQChEb3OnWDeajVSPZ3cS90G+cD3c/OWI6myiLvZgjk7IU8W+SP08RRI+gpMYd1edG3EouAaA1HquilXQ6PauLsCN5zc4PZNxAFLN9B8liA3qSskmLUj7jxYm4WDwkzNq5165aq363CqzjCt4P78Az0WlkhyQswsLT5y75du9JIHt1Xmt5xdLGLkt28mu/nYoeO2Z4tPUgh6WGyI5IZubuyP4blckJ
x-ms-exchange-antispam-messagedata: EvNWId/QCSqpOuJ5IrZHaPVj5g35NEA6QbVBLqhdVty8bopoVbLhiYVXXfnDQQYSRx2wlXN/gri2ZN1z7Szk1x5/1U1PhS6d95lNif/LtExLqmKqaDtqK8Sku4Q+f8YO3u2dINB4HeSv2YEaw9xX4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227282c9-869c-4514-ba4c-08d7dc7de772
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 12:02:40.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wJesdDE30sDDUtaUBJrEki3DNMiKLFcEjly8uttREZtj4NN4xAdciGB/KPTsfsOZ4zAvGVnYp29IjnxwKUTk23TupembwHWHe3NIppKDrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3631
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> All callers have the hd_strut at hand, so pass it instead of doing=0A=
Nit: hd_struct=0A=
