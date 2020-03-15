Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8567C10DCE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884F0206BE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 06:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WPKsDJkd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="swdioxTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgCOGIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 02:08:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44113 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgCOGIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 02:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584252583; x=1615788583;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pt/bEx/dtSYcrNM7ApbVoPyGAWYb7sH4SD+fQy42zdE=;
  b=WPKsDJkdWpiStDkqLF7EKpsN0NqirZ/Sl7uKTuWKR+arIGw4eFEp9WKb
   GE5zMfohTh4UK8wGjDSau6S1EPBiVqh1ysx9956w+5qNHpfqQzpoHcnAw
   SLjKQ57WjCMPv1REuIx/EAsnTd1UBWxxNYKhwV4LjiTjPJ2keTHOU2vgf
   Z8QfgMVDdSS2X8v4r6pgwECfrnmXKnknsrw3nmxnKcpZMbvgIOezhwXLN
   cQS3VRwhZQKOdCOTHkc8f4LjYChvRlQ14v/IiSXUD0P9h6p3q7urg7zx9
   oXcEfeZ8FTisxlKeheIpovu2WYG1p+IXDh0EU6SfbUKOmVHaZnfxIau9S
   w==;
IronPort-SDR: /LkH8J0ULiwk/OY9Kan8gQEm4/9ssRjqhUrYzlWhaC7j4zFp8eR2o3h10K1zo22ne39cZ01zoj
 Ru75BJcMkLfXX7Fd0uHtDhHVtvt9HKKa66VI2d/6doysTdraemfp5w0nLUeex78SaseuChPat3
 kIkrRN+soQ2JJ6A5mHCqGDNwrl148nLLdlTCAvnWvetWgX7HRnuwQWLJQDfja+UN6nSPRVAdnO
 2DkUjBTOWs+i2QC99yLaAiDmsaAluAwIoy2UzE3vhiMMCU1+3BlnWs8XAZ/+t7yCkumVpGNaCz
 vgA=
X-IronPort-AV: E=Sophos;i="5.70,555,1574092800"; 
   d="scan'208";a="234600142"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2020 14:09:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwM14C1yv+rWrrUUGhr0iOi1pu8h7i2U6YCsZUQR6ur0xeDbjikEytiBIwClMdnlvAdbqjVPui1RhH56BF88msOHkydgZpBUWCeK1/p7YJHbDJntxTLADkU0SUiNCeklocvhMDfKKIkuR5+Y7aWNw7tblo8yeQMKzz6OM9/g4VJbwv7Q3F7ffbT43TuUTcdD8YvniFoEXbRJISZRKUMfD6DCwSUX+i8DIGfn/vNuyiYkeT3IxlCdLUFrBKq6SbNkIhlwPvyvAE1gmqGrLaf01KdeOjUQMlDwqWcXqFlSm2GBVNJEDwxpUJO3aqK7JMavw59aRYHzws1+EtutQ3zV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feGrmLWAedXjQl4ojStWQTDG6cD095nsz+g/jkxjYRs=;
 b=LU7kmBcAFcJxvsiak9la2/8f/s4E+LDyIoxAcmkDSrH0Iy/foDUvGjArB/7lS5xOw4dsIlVYYGjaMUvuOq9RrcRvH24nOoPd56SF2XTxD3mQYDxywYfZF8w6vyy7CIpvqX2dS6zp8nU0OuheUaxCiY2CIK9Gw6ymuA58DS6tvUGTqO5ajf4x2gvH6Ryoz1JNrfbMbjn9F3OBLpGy4fgFBTWk/o+2ttXtEH5A/XJ6aLAa8ZBuq0GV5L3CSy7lqUMu5RYcl8Ui6k8go64ln5AUleSGRZ0uTX4F/qIpI85orn+AOxw7TVugNgZGUjCxSdezaQHSS8Icbv2+tEkm2bPUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feGrmLWAedXjQl4ojStWQTDG6cD095nsz+g/jkxjYRs=;
 b=swdioxTF366M2U4K9n72DaFM1Ws2b1nOnhUCUMqZ7oBclx6JFDhINmkd+40cQlK99MJQ3BZWY6ucKHgiieIL9xgbZG6F/ZtamKTTy/Ezfp6cnBib6oyAs8AEgz7rY/Kz1j2imEHwbNVXbRWpOarSIxajJbs1u90b1PuieMOV5T4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5493.namprd04.prod.outlook.com (2603:10b6:a03:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Sun, 15 Mar
 2020 06:08:30 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2814.021; Sun, 15 Mar 2020
 06:08:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Thread-Topic: [PATCH blktests] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Thread-Index: AQHV+nQD5LkXi33fBEiOs04annuABQ==
Date:   Sun, 15 Mar 2020 06:08:30 +0000
Message-ID: <BYAPR04MB5749C19FA8E68FAE8B787F6186F80@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200315024654.25174-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9fb46e5-e174-4b84-9d2a-08d7c8a7492c
x-ms-traffictypediagnostic: BYAPR04MB5493:
x-microsoft-antispam-prvs: <BYAPR04MB5493166E5268F6AA4074AB0386F80@BYAPR04MB5493.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0343AC1D30
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(4744005)(33656002)(66556008)(76116006)(66476007)(5660300002)(66946007)(86362001)(71200400001)(8936002)(81156014)(8676002)(186003)(26005)(52536014)(81166006)(6506007)(4326008)(64756008)(66446008)(54906003)(316002)(9686003)(2906002)(53546011)(478600001)(110136005)(55016002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5493;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3DwZZa3RoZvMwQ+S6RxUuc6FSV5NGsmmnAyCvR9U6FoeDZCUCEAXPVUWtGvaX9NZiouGsepmwfbPRchOSS2ev95AMbsUIktGcv0DS7JCqTdX9IbgOYWw3BdfPIP5CyBIzOTkVuydkkX9whnHSFhhuVfVuJs85jP+CEjAXC6MeB1Mv5l4ylsVmYJIhBg48CViv1Qv0Imk17Q11raPHmtWzKJqiyY9CxHZpihquB/7iK0qmlafQVg346ZzSAGpSLffnNueTE4mcTi5GXiNrUNXDm05kuQ+KeUY8oEWrtm/hPaQQmKQ9tl4XH9mQ7vLz/u+Vg0Jo9PmWsraDZjmsw066Gu7aKx3JI8ADNl4Dv3qwTsT1PvgWc1HOiVswhVohScv3arb5UF01ndNzgMpgJxdwa2aeoS/9VRbJJ/GjDgsblEn5kcb+igcBteM8ERmFZZ
x-ms-exchange-antispam-messagedata: mC0peDHMzLz1XfblZz1rH64XdVE8RV5nHblhSTpFXrxKAxx7uxE85oKB5fL841qKfGAadhptJov5UE+xW4vowfBpl/b+miMgDZR+zFGP+TYL3Q83BlO7KVnrc9hzkJySEOUQfOmx2JxT4TK3Ufc89A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fb46e5-e174-4b84-9d2a-08d7c8a7492c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2020 06:08:30.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7cpT8RiCaw55GUX2RupTGOXeASGCkek0xioJveqK550xYwxLgRvWWdhiFxCjVqX3mkfRlW1TDpoRSGPOd2LtIDAWHKesroyHhmubQEz1AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5493
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,=0A=
=0A=
How about we create a generic helper in rc for creating null_blk=0A=
instance ?=0A=
=0A=
This functionality is needed and pretty common, so that future=0A=
test-cases can reuse the code instead of duplicating code all over ?=0A=
=0A=
e.g. For NVMe blktest category we have helpers for creating=0A=
subsystems/namespaces.=0A=
=0A=
On 03/14/2020 07:47 PM, Bart Van Assche wrote:=0A=
> +# Configure one null_blk instance.=0A=
> +configure_null_blk() {=0A=
> +	local nullb0=3D"/sys/kernel/config/nullb/nullb0"=0A=
> +=0A=
> +	mkdir "$nullb0" &&=0A=
> +	echo 0 > "$nullb0/completion_nsec" &&=0A=
> +	echo 512 > "$nullb0/blocksize" &&=0A=
> +	echo 16 > "$nullb0/size" &&=0A=
> +	nproc > "$nullb0/submit_queues" &&=0A=
> +	echo 1 > "$nullb0/memory_backed" &&=0A=
> +	echo 1 > "$nullb0/power" &&=0A=
> +	ls -l /dev/nullb* &>>"$FULL"=0A=
> +}=0A=
> +=0A=
=0A=
