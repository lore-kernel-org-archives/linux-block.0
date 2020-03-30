Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE9FC43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 05:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154620732
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 05:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AXGZl35y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fh8SOeh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgC3Fzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:55:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31026 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgC3Fzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 01:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585547736; x=1617083736;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=q5Z8PaxR3Ftr9hAG9ex+FjGVcHgf8zTYASoxIRynNJM=;
  b=AXGZl35yuLmUyuLxuNyY9TC3IjxWDEutd6uW4NkJv/5/0LQjJbQoe+rn
   H8F4/KZ+IioqeXrMYUVeuN68yHWHrua69IG7kHOhWa6Qrlz/wMS9n61K4
   Pch9he3mJ4TT2tCBC4Y8wLz8r6V4gH6olor0DZlHtNw/fOhm4W1d/9O+x
   AwCv3KVrwxEeNc3iflPJWaNs1cInffQ+NCP/2QMy6LaQasvRaxSjh4gWA
   WUKzBbotJxa9T6Nw5tvkuFWrm8Ft3S2dmFQHHsWuvshOAk/Z9euykgSXa
   bWsiRC3IWw9VUeDSElzLNgclILW21znoy+RV1KCCqF1vZd7O1o8C4AuA1
   Q==;
IronPort-SDR: 9GlHsCtm6NjfbhwlyIUIJmZhfau+7VD8KQ2rAfBBS5IlXa9svrDNZtvbKhcenIQus9Gxg0iyfs
 uNGm2smOpjhasvYEUomCCwknxFMvH3BLSgN6Jwql2u8vNb23x9duqweNcLwmtY1dprFlwdNqsv
 cUB5GBlPbMIZKiSpyUlTEKk6za4ccSTWHDDhuv9OkhwSJEbX1G+4wbauc5rLarnzYpkOjMmqMV
 G/hmfH/0+u1JNYErP9xssycViGCcfqre9zRcWLchPFAIrMRaklvXOTgIe1W6nW+toUtVtigA1M
 ZCc=
X-IronPort-AV: E=Sophos;i="5.72,323,1580745600"; 
   d="scan'208";a="138228920"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 13:55:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrcAKJ5NyodpfJcpnIP3H9fVGYoA77bF1KlOlVFl3kZr0H9NO2QBTrbkZIybYpxQrRDTHd0cadMEMBbqy9PPERi5T6G6sJ96rk8ytBBGDKvpvIk5eDvZdNOyaz5dVSHtiAsLL27kWeDnGrYoJKUtANhZbqeSmxYmeMsKET+cWiL8dl5V6udgJ5QkA5ebQIAjjQ+D+qTj0q/9ZZFlQ3Z+ys1RIqy+6hO07bzblJl9xzwe+W6EsJj+PUt4uwedPgaSMvP5TekegDDRstnx6YG2Ij91LYS/SMIlE0zlL1iGUrQYKwRJgGNPpAt3dXwzW9mB9IDpHRWGxMKP2fCRCe+lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Z8PaxR3Ftr9hAG9ex+FjGVcHgf8zTYASoxIRynNJM=;
 b=Qah+BHwiO776tUhFPqwaEQWqFOyy2IJ9FHL4Cl8yT98clhmLixwZW1aIAgFwNZP9Ieuxxy6KR2PdKLJaRJWkgqkBvaJxIAOBqUGC3XXXimd2wC4B0iMKL4fEYLCfNceQe/xp8TZEP9ony18QZQW27Cr1nLtGG2gCOey+BnKyFkDxdFjlDe+kpoqQrQFGdq2fHHWmnnDBQJOc8gl+TXaaHG51cOi3w643g0X7cu7Ip9AshddT/wzyo79jlRjeDiSM4QzjOWLaore4NZs8Btq59Wtd6QhvZHK8zXVEdwL7urt2+gPv2teq7Zb7vk1Lwj1EZr4S/Cd87Ro+Jo6fmUceSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Z8PaxR3Ftr9hAG9ex+FjGVcHgf8zTYASoxIRynNJM=;
 b=fh8SOeh2/Hp6fIfsdq27Rkm+YYPpdqABf4stchE17qlOMRLRqKkKG7vmac5Wa8zJG0QLM7yxpxapGpD55I28a26TMgPpfHyQVJC5lsNkaSISJ1nmtJcVSqOtt9t+WaD9Tx3f7TKHc4j3RsZIMP2BSVX/dbTqXxvwyQ7dZ56I3oI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3599.namprd04.prod.outlook.com
 (2603:10b6:803:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Mon, 30 Mar
 2020 05:55:34 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 05:55:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] null_blk: Cleanup zoned device initialization
Thread-Topic: [PATCH 1/2] null_blk: Cleanup zoned device initialization
Thread-Index: AQHWBkfhMGZYgIm1gEyvU5oxxuu74g==
Date:   Mon, 30 Mar 2020 05:55:33 +0000
Message-ID: <SN4PR0401MB35987010028DB719D8DE63A19BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200330040116.178731-1-damien.lemoal@wdc.com>
 <20200330040116.178731-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c525a859-3f1d-4cef-a124-08d7d46ef662
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3599749539B0B0496F78B3B59BCB0@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(66446008)(76116006)(91956017)(9686003)(33656002)(110136005)(6506007)(66556008)(558084003)(66946007)(66476007)(7696005)(64756008)(2906002)(4270600006)(52536014)(86362001)(19618925003)(81156014)(71200400001)(26005)(186003)(55016002)(8676002)(8936002)(81166006)(316002)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHK73YOnuk1ap8Ee1rkkN4tndlukiJTekgplPBnZfvLrcASJgoAmzYpx/dSqWV0ORdjuGjtEBSPNSWESZHn297Ttbph2+v0El0TC6Flo+NfuhZjq0unUp/w5+X73Bps5eyZlWnqEXzvnfJDTGAMoc2vT6nLhKQONufpy5o5vAwRFsUuak61sJ+bVetn4JGxlArpwNvFtAw9UJE3DV6p5uAVGO9CgnUVb8rlJHLVbeHrui4VBQ88RXP1Jwu+7xt5EYvGli0nr+MuIOkk5mTf6eg9TWEzeN549vLTz92YFgAly18p4wCLg4yOi9WVXLuhIs8aLRPVAxAPttD0wV4AXcKMd9/lTNTKwweo/U8UmpC8o71PlQdSqdZZ9wgcbWgkOUKh8b5Gg6kqj+ttdaPzaG7xI1cyt88qcz/z+itPN3bnAdL7/AJGzOiIzydwb9P+j
x-ms-exchange-antispam-messagedata: TBVkBziOKusOL114VJ/Y4nHZ3TVtBqMuy9NGGr/1PvCHQeahAltchlqkV9I6IbsLC7jM+G6cT+tO+h5J/ELEK4zk5KKJzAD/l9H2TXXvYfMpTwUa3QaiTbMb2zCpzCXTYPqqqS/9CaZEL3/3WoGqBw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c525a859-3f1d-4cef-a124-08d7d46ef662
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 05:55:33.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXBGkTj9UG/bnCLQQtMv2dKb5KvGiYYsf/bwh/mjq3wAKD7Ui5zWU8t9mOjZB/pHH71qHC1AjBziLfFIcwzR4smH9VJAh2lza1Du24t7WUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
