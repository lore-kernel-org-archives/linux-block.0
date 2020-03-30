Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B099BC43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 05:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FFB20732
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 05:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rtBIomeA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gszVp1qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgC3F7E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:59:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12709 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgC3F7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 01:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585547944; x=1617083944;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rtBIomeA3Ztkr/DpL0pQtPwxHhGkbD0DIbULkDZBR7bSCcWi/Cf4+EC4
   iCnJzVUjFkdtQOv7NMTQDvRvUPlKCnRnBqIWpeM98y4vn1Xortz3Mkc3F
   M+BBfxKeAk6je8qHm4nPRDkeVJXBWFB34Ec11bPJDeIwc4Pb2qzKVi5fE
   8FzNw++k0y3ka2H0VR2LYIcMy/aINJgc/DuCD7nPC0nXyfPc2QsGhh1sq
   BtKBX+0b3TJR5cEBNwdq/UCDucbov4xNX1n6bz/Ysow7Z1Shs53iptBZt
   KtU3/FCripvtkdH6PTB7sqf9dDxWG9mYrcJ3kKCLQG9JSfJqPAKuY9bY9
   w==;
IronPort-SDR: pQCiMRZd3NldwZO0r4frHPZG1d71GXi0xFMd0BTkYQQL4UsxpmVPATRcV5/YSDhXh4ROb266hC
 dNbU0RfveiiDTO6JwKucZCzauBZbHFeKkRhtK/lbtJYk80MirPXOAsSLq0vNxpgs47Rbzd25RF
 5Xf0iCRZfKzIa/uqL7Lc0kWgMYFvDqiV9WQOMssxmQIPs/o5e1Tv1hD7klxBoCIG+NJhgjaNNO
 F3YTJ7n9MME6rSjYl/l9ENFiAuQMsrbfFSp819FvWkw0Hx2jtJkGimzSylvfu74VKF+dlq9xd4
 kSU=
X-IronPort-AV: E=Sophos;i="5.72,323,1580745600"; 
   d="scan'208";a="236124768"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 13:59:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4h97gQ4SqahWjf88zCRAsxYw8xx0148yzf98gDJHDWtO95dbVgXIOVnofYNIzwIbWoHwIWkub/kQ4NxIJwLow9V31Q7eQQ/km+LVVmE/A7Dd/SfGjDSNhOFlU9FR51BOL9UNq9bxDkGbEDHif+/zgHlmCk0CbLAO9EeujyqjYZ8lLED0r+yH8yAY19iBegnw80jaGaKTvI18JbrvRq8Ef0ehCGk49mSAqNLP9hhEMoBozV2C4tUEJQsKj7wqwo7jST1ad9Sf/ADU8encgxuVcuHdkek5k7VEUEjsvgXTlGYVxZmVv3qJl8Chzm4wd0jOw9czXAN/WMmqHNKHlCuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VT+72EeozCyZXtThmAIPFxOuxOibuHU3GzRq3+egH6ajq1/jqr8JcF8xR99TQIQ3HNtnEjYr3Y+jI2olp/C1A10oTS/zSgRbSWx6eGkQqlN95qtm3zgMCe4hWl3Ky3taT2rENgu7/8LkKz2dtpfgcnHT2i30OKcYA+qfKeON19F+o0b4LkbjoGSqTBAIW9ajuhXxePkol//aQozrV8ED8GKztJoD3+LZIAEkLWIVUw4Hf53SCHF+mJDyZxz7GBGEqHfkMnQ9jlDUnduRt5kpLPMFqZwd+W2+1wUZGmzafl2j43lvuGixr69AHcgKgNiWGbUusx/aQhQzdIc+iDk8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gszVp1qO1pBduB+wcZ7K6ezxAOehIaDM+0D1a48dz5CKhD1qMu796tTh0VQL7fvat1lg6szcYY4XWfhUrQz7f2msLp5H09lHL3QokWNuh/YiFV77PP9HVQ6JVQoj5FfQuYeDqOPPs8gYucB7sR6uclVJmdFgiYnfd6ie8c8riCg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3599.namprd04.prod.outlook.com
 (2603:10b6:803:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Mon, 30 Mar
 2020 05:59:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 05:59:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: null_blk: Fix zoned command handling
Thread-Topic: [PATCH 2/2] block: null_blk: Fix zoned command handling
Thread-Index: AQHWBkfhdvu42kpQzESdpZbrZfddjQ==
Date:   Mon, 30 Mar 2020 05:59:01 +0000
Message-ID: <SN4PR0401MB3598E3421B8965A3F1BA81A09BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200330040116.178731-1-damien.lemoal@wdc.com>
 <20200330040116.178731-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ea59a89-0b24-4c26-766d-08d7d46f7254
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3599A2A7EEFB7BCBA1382A399BCB0@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(66446008)(76116006)(91956017)(9686003)(33656002)(110136005)(6506007)(66556008)(558084003)(66946007)(66476007)(7696005)(64756008)(2906002)(4270600006)(52536014)(86362001)(19618925003)(81156014)(71200400001)(26005)(186003)(55016002)(8676002)(8936002)(81166006)(316002)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+CcEHLLpAsBLV20QXyfVrlzrHvR8tpCWkVSipu6kQL+7ryBoZXU+bFMTD3HmS5Nfsd9q+T6sUWnWD+wodvaPJGguKFGmo1+WmjuN+Bul3aEHYS3uRboH0mSq4a5/Nzx3TrRZYuGNi8XKFIgc3iCXJQMt3+SIXDUbdIkxWIC3wg3BxvTQuklSwCpgfAqKHHWaZEVqEeGerg5xabWFekL+ObPI74rAMr4VDsIArdlZ6k0gHp8+FJtDZQMEhsg+miKRB0eTobCcTmf/8y9foCQPAVuCYiF9J92qXr7WqGjiudoX4qm2WMK8HL47AxEuZetVVxZrB8ZftzwEsk6qlM1pr1jHa/xLTfEohr+Cri5PbPYUz/4CTATYyYZnUzmBxHVZBaiW5mIoYBzxrsI1XwhK/bqNhdwPuTEPSsl/CSjQb8qCd3DFwE7UPFFWCXIrE3T
x-ms-exchange-antispam-messagedata: XIlINELEVNwzm+u35kCrthYm4xzop97dMf/YaMj7QNy+PpgmeaZRpfWHQaHM2YL8G8uQuTcLR2pg0iMNxMMxFgpHM2SS6uaijbwthJ1asDAGmBdmHKSt2IvFyGMRzEVyh9ztP4Pia2f726IqaRGEPg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea59a89-0b24-4c26-766d-08d7d46f7254
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 05:59:01.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXZJ9aB6+cTbFSgkF0ECk12SgbgHu8VjxxdfIaY3vcGTUerwHUhPXKUJz0Io7nAcKUKQmOIVbqwiHGSzMCxmbqLZiCUmbIysiz9bPM+lzhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
