Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D068C352B6
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DCF2072D
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eHTD2NRS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s0/ZJFi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407003AbgDNIJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:09:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64233 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406997AbgDNIJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 04:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586851766; x=1618387766;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eHTD2NRStZ+brLnwGF5+ui0nlrBjDvDIiOSbZf69XReUQp2s5R2/0aZK
   wxqa5Mld+hC8J0dp7QZZBQ84k/LPwlDMhoED38R0Hs17++OInpJ/OfLlW
   81ckkE47BLNZQzKNi4zHnuHDkyo5HgMb9IzskBsWTS5CPDF5d/9ilqfRp
   8+qIM+w3Kw50GRlm7Ro/jMga71g180HwnKb4cH7pbgLr1OUA9aMUkT833
   4dBMHodXn8sSQqRFawDSbarC4fuqrtovdpr9/gABvOjHBbH5xoVWVszED
   uQ303yruBCDwjCIG+3/UQ0hDGK/m4lNC7sAiEZpy4t1os11CLCzhEHO9G
   Q==;
IronPort-SDR: v7J4FENc6Nv3RNwwhBJIpUS6bHxUJFuqNvFwoxA9Cjtr7w98d9qImh+TstokF80hw5bqMWTBv7
 0s4SsgfoCtyvEM6ne5plNZS+5rnu1Affcwnsruy00hpqQrgfHM2SSsVaIAG/lHM8bDbMVgSuYT
 9FpA4wP+SedflP6RSGLRfaCf3KV3QHfChM6SKoaakb7HRHk+dK/glkMNVnNSmpO2G1yQm9HKAu
 e4fzHA952AFDVsFKRbIZPtiYnppUz5nhPCEdE1sNF4ksKU7DQrHpzYdxemexbYVmudkpfziuJn
 2Gg=
X-IronPort-AV: E=Sophos;i="5.72,382,1580745600"; 
   d="scan'208";a="135285831"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 16:09:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYt1HpqTqIQ08z9VachJ/m8PEvHKzZVQ4CNfWWlaertsygvi0uSSpJqtA/Cdkx/Las5HHVoC9/p+xdpRhITdHZWb1pjPwHdTiCrSFQgixsY8ZMD6zwU1wcBTUvDnQucvRFScwFSP2dl1kuXp0McTgcArLskahHLWDfeXL7XG01OCrLaAbrsV78JHeJalXMmqnOU/OPt2J0UVie4A9mKno0+YKhmS5U/V5jti6WMZNfNu9ASHOLmkZ18U2FGac5ZtKPb3xZNyAVr7l/90XJh3eVve2Qt/Fxlosccam7102MmWlxXi8GvNsCFfNQuPJ/QA5YEyJ3OgM3CGqIzbBlbq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Fpvj6GatHjep0G0T/B3jVWyqXxtoFtg8w/hygkz77R/wnmqhk5U+GcYyb4qi6848ZC0EzVjVHUPkqZDfFpDALkUvPksF/wqilcYFSGvhKUFSa7rDwpOLYJmKere9pPuS7RcIli2J/5leq4hl2Paz7SJpMfOWz8BA/wEsB0ar8WhRiRS/s9oWwx3v5Is2SHojPfeDqGziSgGdPW1GhVpr/wRIjUix/w9Q3Srs0qa+IYMUqE0QrkfqotUaG+h56zbvbajMoMdB5Hwmg+T6ihPlimRSwfiWAqtAGWBp+3jTknlTXwYUTCaZtFHChxIbjUHErt3M+53gVthjfNfwB0idPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=s0/ZJFi+Z3oW9/ppwMqPO38r54fEgnWgN0PM6j/PjgeEQGLYjRYjdmoK5KNbGoVzg+ZCBRPMGWlK+PVCRBdFnE8f7DtLQMUzw9C1RZWWrNd+xbBoW73sFxH0giv/RlwkiWSVtf8drlrATIAJlIDXKp8FCx4j/CeXhI2XzBBUmoc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 08:09:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:09:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 01/10] block: refactor blkpg_ioctl
Thread-Topic: [PATCH 01/10] block: refactor blkpg_ioctl
Thread-Index: AQHWEi5qZgCeXVhxYEGmuCSbijZSPg==
Date:   Tue, 14 Apr 2020 08:09:21 +0000
Message-ID: <SN4PR0401MB35983F7EFF5246068A3CECAB9BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414072902.324936-1-hch@lst.de>
 <20200414072902.324936-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: decfeeb9-22ad-41bb-83bb-08d7e04b239c
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB35677F37379AA8847EEA65F59BDA0@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(39850400004)(376002)(396003)(366004)(26005)(55016002)(5660300002)(9686003)(66476007)(8676002)(8936002)(81156014)(52536014)(4326008)(6506007)(7696005)(66446008)(71200400001)(4270600006)(66556008)(66946007)(76116006)(91956017)(33656002)(64756008)(110136005)(478600001)(54906003)(316002)(19618925003)(86362001)(186003)(2906002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3ovq4vM2zM/R0rqCQOZCqv9AwE4eYWVhWQp6BPy4StG/n61fafw/AyfacnX599Wo9N8DkBeT+YZPqG1cyP32eXv7068zc+8plPE4YgSjAJd0dB/xV02RR6bc4LfY4b3n0EdRnAQl5e7D+eEczLwt3Uj0KyDuz3ob6PhOcxQNnVDJbhWDJJaelcr9GRjZsDitAEZrJi48CM7p0jNStAHfLBB9y+L5ZVy25jRni7RoekeIY6Eyi528JKDhIyVxowiWrjytZh2EMjilYHboTwVVLN8eFjsEPqepQHj9WGcZX9hhI+CisPO8Mi3bYQg8dLyAHWpB5qkIbbKVIci0sgRYmpQp4g+oaLd8bTnsUWwwfEjDDFYEHwvFtgsvJwqTiO/fsSlQ14JYUUjB+O9vElimmLOzyzljsn+x73dzECPmp4JzGbG79JZEeqiSH88M+RF
x-ms-exchange-antispam-messagedata: 2UPeeMQ5/+4N32Vb2uaqrlHRZ3B1LrKi3gzCIoCDw2esKeLA2gxPuSh5UlNY0TVEdz86NQWrVa98YYbvRlXpk84TsB63IaehltDYveFRXfwrMMTOX5hybiUuNIi9HCiCs0St7Hf2M398kc7ibrzFDw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decfeeb9-22ad-41bb-83bb-08d7e04b239c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 08:09:21.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPaaaEka6Sz0ogjIEI7+w0/DqyN1OY55mk4tjmWqD5AV7jXHZBexgCLVjdTmw5HuThwzzVGEZxFsejow9xU/PayvdPA52xCpjkWAfr+siI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
