Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB2AC2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07454207FD
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hfX8dH+P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a2gju/ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgA2Xba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:31:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53500 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgA2Xba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340690; x=1611876690;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Fs66KqB+cpSP0j7jBinXkDnQQkMCUYmXxe/d0bLb1Rg=;
  b=hfX8dH+PBDGT0pa1lBBv8iMIfuGJbDEYhb5zOpBxiKhpxdeJTMCiZG4z
   jXWwRhumkPWRtlOCMKRjluv/Hg03H4TQH7XFrmyZhvWkCH5IBuLs28SxB
   MpgotebtEJXdUBgmlSeC8NVSLc9w4ABmJ8nzNtRrsmFxnpN+D6JZzrZvH
   ln0i4MUcc1E+ezBxK+ZbNzrO87EJLfu4v5shoHlJfzcDO1Plxy9ZG0BSv
   lIX9J/9xSjBwYUXnVeeIFtugqBGD10eoThye23rsxfRfZfiEWf63+mpgK
   j4OcDQ9nli/kEa8sItjXkAA5x+94htPedmklXCyGp6DkIEKlX33WSKON4
   A==;
IronPort-SDR: syDLcz6YN2qZ/atg5ZuWkrq5C9d7RWZkJeIxda7KbDxOXf5VkHU2cnPK8piwRp9YSRMdSVEtON
 6+M4YPovnTi+TKL6FajtFVTvyjOS+JPFBHzElxpcUIbqUokMEOWTD0Hm3hX8a9pDc0Mh3vlnKj
 Kw623AwwyG2Z+m0LnxAGbwmyZVarflTopTQqoCgZWq/A8TKs3NkL51u575DMAPl5vh+IdFtYTV
 DK4v9+poU2wxsWalPK9jtPhv6FLK22/Nwilq+d+mh/o9M7fYKqTrd+LVVPGLcH6Vq5DKhuxQnB
 eD0=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="130160450"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT0TDFRT5yXHE/k1g9Y9Al47vekeshOXdlmEbk0Uq/PnPODJD3gWiUwFU0xoyhkow6rfDW4Mv16vaENzH5HfiBcuaH9vZ3gtjqojZP9YtX+iHNKOnatC9TgfRzrzk08f+1Ce2Vh1skHAHjC/Pq7Eetv50XzRItGSpZyzXXlata6LfkGppPNr5So2ObrtPGHVbmZDtppcimWYxPXCi9mojwqTmBvGYMaPkKEvqMo5jUXca6cNN04UxNst8sJGs8AZLsEccMOGP2h+y39qKo6sSrUmHRz8QjtK28bMmrCbMM74rtJWBeD6J4GATUzW8FS1IrBC3xlHV7blXk85DGCGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs66KqB+cpSP0j7jBinXkDnQQkMCUYmXxe/d0bLb1Rg=;
 b=kWkORj132lODV0uLeYTnEEh7vzAbiNayds3nfMqJSxwbSzJuOjUAtUJC2VH2Pum08hYIeYlNtQNG7OvefZFLqjfDlu2iJUe2wrxZmt4tJLTX+0hwXS7nPlf1f/gHfO6LlC72O2ApAJBdjD484QyQrbSCoQx/KACj7SlHniKaQ7AjIG157OxKOvGgUDu9JDY9afy0FMfIdc2oeJrv3UvYYLQVFrd8I3H5EJ2NqsMSOA4t4j30GGp8Ydd927eJOTi53wcphQ+tJk+v/7V5QQmdxZvflSNL7k1udDBwGGs3o+zynpTiMSFBTqZtRTnVfigenWo2AkFuJYe43yV7M7lZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs66KqB+cpSP0j7jBinXkDnQQkMCUYmXxe/d0bLb1Rg=;
 b=a2gju/lyr4hKuWU6zw8zjEDT5D81iguZ8YDL7SSzD+RrpnR9yW/NYIvsvQs72SRZA2pLf1RBRb6ougp1t6achBgrIONb+3Lr8L9QSW4VnfK+HP5tVyOa1yP1Z25MU8E4M5sMYt/Q4uDhXWKCE9COAdj7Cp2dTd2P8w/4v0hTw9o=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6181.namprd04.prod.outlook.com (20.178.236.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 23:31:27 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 23:31:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Elliott@suse.de" <Elliott@suse.de>, Robert <elliott@hpe.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v2 1/2] nvme/018: Ignore message generated by
 nvme read
Thread-Topic: [PATCH blktests v2 1/2] nvme/018: Ignore message generated by
 nvme read
Thread-Index: AQHV1rtGisXuju/naU2n8v+Ke+87bQ==
Date:   Wed, 29 Jan 2020 23:31:27 +0000
Message-ID: <BYAPR04MB5749448D98C7A46FCEE96FD486050@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129154619.103332-1-dwagner@suse.de>
 <20200129154619.103332-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eba7b352-51aa-423d-fe7b-08d7a5135cbb
x-ms-traffictypediagnostic: BYAPR04MB6181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB618123F45E7445C62F5499F586050@BYAPR04MB6181.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(186003)(6506007)(26005)(8676002)(7696005)(53546011)(478600001)(2906002)(52536014)(71200400001)(8936002)(81166006)(5660300002)(9686003)(81156014)(66556008)(33656002)(110136005)(76116006)(54906003)(66476007)(316002)(64756008)(66946007)(86362001)(66446008)(55016002)(4744005)(4326008)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6181;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOYt4mBQiziO7EIZ1XJxOwHD7QA9cOgYZv0zebRvFn7b+8hipEE2Gxb5uuEK4jZypDG+BH8rc/el2RdvxoCvEYlpd+4W3s1w5HiuOLU5W+EGyU9IMNtz21KIptuWCl4jPAMGc29u+ywakZ9zfRXndTAH8VcNtj1k0itjFIQbP4axO5rjE6tJsJ7r+ml3+3RF9Z87YTJvhld/FGWBL8diQSfM/bjwiVNO2zjJ3+w2s1ZqeY8LkHjNDUfaolBvMUMUFj7T5LZG8Xr3Vfshx+ItkEpkwjcCLq/BNB/hSY8vhSIRd20q3PZrZkVgGpd3+C6BJEgAdMpaJDV4haAHVdtl72GZ9qMWzf6rWhKPLL/Gk9qwzyGO5QP97Lw3pdyjRnMVkf7+8Jx0JO8exD5KDgrc+kdFgnPIFNcD8EZGNBTIOlIp12EWme8Jy+lqrDzsoZPt
x-ms-exchange-antispam-messagedata: G843lDY/fy/5uYLHwqHnRKehO9LusGwP1ZPbmGGz0332nCjcjz7duMJT5sAm7TsD3eQfId4PEkcLo8WOFI5hKpkZPX1pvegp00bNqXWoOK22bdMxHRwkPID+dOP+z3lUU+RIUxU+Em7fWNMyZPG3XA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba7b352-51aa-423d-fe7b-08d7a5135cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 23:31:27.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbRMBucvcGSoMz+5sK+Z4UcusrX6R1ZmfvEvMdcCfSY4wSvxhXNA3BlLbDgQD/9PBBADDd6MdIYRPsSk+69pnboUmJKjdp6MUeF7r7+//h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6181
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/29/2020 07:46 AM, Daniel Wagner wrote:=0A=
> nvme-cli writes 'CAP_EXCEEDED' message also on stdout not just=0A=
> stderr. This lets the test fail as well.=0A=
>=0A=
> Fixes: 1aee5f430b30 ("nvme/018: Ignore error message generated by nvme re=
ad")=0A=
> Signed-off-by: Daniel Wagner<dwagner@suse.de>=0A=
> Reviewed-by: Logan Gunthorpe<logang@deltatee.com>=0A=
Reviewed-by: Chaitanya Kulkarni@wdc.com=0A=
