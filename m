Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DCC35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 22:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E5820720
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 22:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HTL5tq13";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xMIpLmPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgBCWsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:48:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9194 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCWsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 17:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580770112; x=1612306112;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bB91vEqcHN2d7XBDzoeiwxk0h+MhyuInXEi4t7jESI0=;
  b=HTL5tq13t4gxfKUDHfn8Zm7TXuUHG2T6TQfkqUISpjJeqSbED4AtyWAO
   Oa/svM9Rb+hsYgwvLEPSpJu0Eq2LJDTUMB9h7oK45C7Tw7psIU+AmuNmZ
   LphcSauIVAk+c2o4lh4NJHutl3SdthW9X7/yj+b1Nbgi/h69qW1oBMZjG
   lfUy4tnGspW9UxZXRlZZF0ZzjIbwIutJYlN8oFdIgfuEnBS8SaCnIfq3Z
   cqFrAOeDlB6ovwr/3XEbCz+YDHramisgPmsqXiJwuA7UWBsF+MBNVj34b
   lmOAnbH72tdHnfoHK7mofPloqUiNtIG6fOpCysCAEw/Flmo7LzT7pjQ2N
   Q==;
IronPort-SDR: TriN98imVN1RXNfWW279KZk/Y7N82ou9E6io1NmH5J5YkEU9NRZPdop+4dDwP4chbNkc8yGxnp
 XdzdZZYm9TPbw8Bc+RfzeGxlPzhVfYq80vOBE4lfu/BAMCqA1cgXWrs0rNLXvIBHv5aimlxTNJ
 dMsx3e8aCLfohA3MshSd3IQ426RbgF9ZXktLnXkHFQ7WeilTlMI3xqsi/ArQFlqctyENWJNeEe
 qVfhnS//LxeKYnwbKPfwNyEhCqRsjPrvqFpeC93+1I9bnyxkHmCL3iASCU4QR9q859XWd/Qfv4
 Lpc=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; 
   d="scan'208";a="129560054"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 06:48:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fftf9xj5Srav1f8kCOf+kk1p2PC8va/NSaABE3Nxzxgv1m+7RciJVHmOQXHXGQaLP4gJu8dAB5fRDqbroQSeo/QfrKIDSzG7kjhe+VJVfULOMrzuTly8JPyI2TO8d8ppUFAI1jm3gYrFJvG579DuB7IGTKpZEn3uH8MzkXM4jKSNFVl4HAkB9SyLI4BmCno1tbqMegX8yxTh3mGCZTudKlPYZK14Q4CVz2QSKnUfzkP8a8M+p7+rRwjPvNnR+P2UZaeWBD3BfK3gpardJEhoLoyWgWrSnxWi06ECYJXfkgHQIrT5e5iMyUNDbdneayWGBl/F0pz5VeyoVgbx9C4WiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON7Cwd1euX70wPLg8ZaxCKGOxMxte6GTv4l7oX3R60Q=;
 b=nH7P+uqbE3U3YBp44ifw35E2QGNejH78gOJe+M2HXrtcWyEyb+fkmZNEfAqf3uIbrlr6qKwvSLe/T7wyZzdWnBh6l7WFVWtJIn0iJEjRXgSgFKdkrPD2vy3LRJwuEQaUh56eDsXumD+fUh3Z7Hg8EbQUurvLxOidU9mT/X7v/1tvkYWbIvvAxN5JNJl3LPQ6/gcgJiXgQSoL9xUXM29QQoMf77VJ4ymaAZEiXYND9MPjViy6UNPJhaXCPq4hs7jp2SvAcXthBSY4R8Qc9yQ3vGufm6m/1NJjn2PetOYCp34OOvtK5ZMb/L23ySCJXhbSg9V/sIUDNXUzSYRjwm6F0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON7Cwd1euX70wPLg8ZaxCKGOxMxte6GTv4l7oX3R60Q=;
 b=xMIpLmPXScXAq/dHKLkagaRTGc95rlcs0o5gKptzG4DidhJWMnEsn4GZiYKn9YBOgJKm7BK9CjMxCugVJ74AxEi91JCKM53Iq9+P0TSG2J/MMmwFDumTXwlH6NWn8touUagl+V1s8CZ8r82vmFL19ewCW4htZGf8pLg3UxTTI58=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5799.namprd04.prod.outlook.com (20.179.58.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Mon, 3 Feb 2020 22:48:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2686.028; Mon, 3 Feb 2020
 22:48:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Topic: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Index: AQHV1vvxPjad+7sLRk2UwG5mK03ccA==
Date:   Mon, 3 Feb 2020 22:48:29 +0000
Message-ID: <BYAPR04MB5749FE36341AB61547C1218A86000@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 536ecbd5-d105-48f3-f22b-08d7a8fb3012
x-ms-traffictypediagnostic: BYAPR04MB5799:
x-microsoft-antispam-prvs: <BYAPR04MB5799FE6FC46E5D7BC029A2BE86000@BYAPR04MB5799.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(4326008)(186003)(71200400001)(81166006)(66446008)(66946007)(33656002)(81156014)(9686003)(7696005)(5660300002)(55016002)(86362001)(52536014)(8936002)(2906002)(6506007)(110136005)(66556008)(26005)(478600001)(66476007)(64756008)(76116006)(316002)(53546011)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5799;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0F7ds17Zj44fZJfE3OfY5ZjJXkkETuAfrxw7gVAMkyP+yHwtPYtJIuVRpfgZ+BTw+qb7lz5cwnl+7Gbdh6EfZ5zieTu8cwYD+t2u5sJswJjhgyXXvMvYJbZ54apnc+jYmJWb/qJhrCVHtX+gYKhTnMEFffihIofdQjFnMUnXrPO6+PAptGnNY/keioPAg+tz54YPeounYRpyFRCrECGfP5lCnsi1pS6Bp6b4m5vZjsnvcnJXye7Lx+HRFur/LVT0JhcSi/D40/fmbcDPijTE1191XWDqKt7stWLbJJ7UycFuQsBWg6AH0XcyRRFV/UXW/nSsHkjBZhlXb3dvTBa1aQA1k64n8N9OH4YyK1aBXDfw7BYUFTDs7hLlKzLEwjeCbFydVjODhuiqPgsXxlvmXYsZ+GF/Jb6M/82a+yfky8ela5P22zDYXWXzhc1Z/vzh
x-ms-exchange-antispam-messagedata: riXwp4jSA0ah1EFE4W9j4YyR4vKp+xkph1Ty/myjirwFCr6LxP2lobZuWoE2oNg/Ewt6vl+BDBSmDF5YdpajXdJQZt/+NZ9hIdRLF72vJ6VH4MvCU+SAeGIUqEMWTvA2HwfEWZ0nLuFmSydDcDFPSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536ecbd5-d105-48f3-f22b-08d7a8fb3012
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 22:48:29.1561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9Igu3RNEsVD5JSOmglFs99PSaMwx5Ar4KAS12KTzbDyO9QwWZ42E8CDRPH/DHAUZxnT57k3e8+hDzFloaAn7GGqkClQmyyz7/xdtbtVO7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5799
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(+ Omar)=0A=
=0A=
On 01/29/2020 03:29 PM, Chaitanya Kulkarni wrote:=0A=
> This is a small patch-series which adds two new testcases for=0A=
> setting up controller IDs and model from configfs.=0A=
>=0A=
> Regards,=0A=
> Chaitanya=0A=
>=0A=
>=0A=
> Chaitanya Kulkarni (5):=0A=
>    nvme: allow target subsys set cntlid min/max=0A=
>    nvme: test target cntlid min cntlid max=0A=
>    nvme: allow target subsys set model=0A=
>    nvme: test target model attribute=0A=
>    nvme: make new testcases backward compatible=0A=
>=0A=
>   tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++=0A=
>   tests/nvme/033.out |  4 +++=0A=
>   tests/nvme/034     | 63 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>   tests/nvme/034.out |  3 +++=0A=
>   tests/nvme/rc      | 24 ++++++++++++++++++=0A=
>   5 files changed, 155 insertions(+)=0A=
>   create mode 100755 tests/nvme/033=0A=
>   create mode 100644 tests/nvme/033.out=0A=
>   create mode 100755 tests/nvme/034=0A=
>   create mode 100644 tests/nvme/034.out=0A=
>=0A=
> Test Log :-=0A=
>=0A=
> Without cntlid_min/max and model patches :-=0A=
>=0A=
> nvme/002 (create many subsystems and test discovery)         [passed]=0A=
>      runtime  15.246s  ...  15.053s=0A=
> nvme/003 (test if we're sending keep-alives to a discovery controller) [p=
assed]=0A=
>      runtime  10.057s  ...  10.063s=0A=
> ./check: no group or test named nvme/0004=0A=
> nvme/005 (reset local loopback target)                       [not run]=0A=
>      nvme_core module does not have parameter multipath=0A=
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]=
=0A=
>      runtime  0.057s  ...  0.065s=0A=
> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]=0A=
>      runtime  0.036s  ...  0.038s=0A=
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]=
=0A=
>      runtime  1.233s  ...  1.240s=0A=
> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]=0A=
>      runtime  1.203s  ...  1.208s=0A=
> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]=0A=
>      runtime  14.572s  ...  16.051s=0A=
> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]=0A=
>      runtime  13.584s  ...  13.948s=0A=
> nvme/016 (create/delete many NVMeOF block device-backed ns and test disco=
very) [passed]=0A=
>      runtime  9.877s  ...  10.750s=0A=
> nvme/017 (create/delete many file-ns and test discovery)     [passed]=0A=
>      runtime  18.902s  ...  15.584s=0A=
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]=0A=
>      runtime  1.217s  ...  1.237s=0A=
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]=0A=
>      runtime  1.204s  ...  1.193s=0A=
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]=0A=
>      runtime  1.204s  ...  1.195s=0A=
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]=0A=
>      runtime    ...  1.334s=0A=
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]=
=0A=
>      runtime  1.218s  ...  1.231s=0A=
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]=
=0A=
>      runtime  1.207s  ...  1.196s=0A=
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]=0A=
>      runtime  1.191s  ...  1.195s=0A=
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]=
=0A=
>      runtime  1.192s  ...  1.196s=0A=
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]=
=0A=
>      runtime  1.211s  ...  1.191s=0A=
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]=0A=
>      runtime  1.204s  ...  1.211s=0A=
> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]=0A=
>      attr_cntlid_[min|max] not found=0A=
> nvme/034 (Test NVMeOF target model attribute)                [not run]=0A=
>      attr_cntlid_model not found=0A=
>=0A=
> With cntlid_min/max and model patches :-=0A=
>=0A=
> nvme/002 (create many subsystems and test discovery)         [passed]=0A=
>      runtime  15.053s  ...  11.918s=0A=
> nvme/003 (test if we're sending keep-alives to a discovery controller) [p=
assed]=0A=
>      runtime  10.063s  ...  10.058s=0A=
> ./check: no group or test named nvme/0004=0A=
> nvme/005 (reset local loopback target)                       [not run]=0A=
>      nvme_core module does not have parameter multipath=0A=
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]=
=0A=
>      runtime  0.065s  ...  0.065s=0A=
> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]=0A=
>      runtime  0.038s  ...  0.036s=0A=
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]=
=0A=
>      runtime  1.240s  ...  1.239s=0A=
> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]=0A=
>      runtime  1.208s  ...  1.207s=0A=
> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]=0A=
>      runtime  16.051s  ...  15.345s=0A=
> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]=0A=
>      runtime  13.948s  ...  13.977s=0A=
> nvme/016 (create/delete many NVMeOF block device-backed ns and test disco=
very) [passed]=0A=
>      runtime  10.750s  ...  9.698s=0A=
> nvme/017 (create/delete many file-ns and test discovery)     [passed]=0A=
>      runtime  15.584s  ...  15.514s=0A=
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]=0A=
>      runtime  1.237s  ...  1.232s=0A=
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]=0A=
>      runtime  1.193s  ...  1.192s=0A=
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]=0A=
>      runtime  1.195s  ...  1.195s=0A=
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]=0A=
>      runtime  1.334s  ...  1.340s=0A=
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]=
=0A=
>      runtime  1.231s  ...  1.218s=0A=
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]=
=0A=
>      runtime  1.196s  ...  1.205s=0A=
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]=0A=
>      runtime  1.195s  ...  1.191s=0A=
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]=
=0A=
>      runtime  1.196s  ...  1.186s=0A=
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]=
=0A=
>      runtime  1.191s  ...  1.192s=0A=
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]=0A=
>      runtime  1.211s  ...  1.187s=0A=
> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]=0A=
>      runtime  1.213s  ...  1.200s=0A=
> nvme/034 (Test NVMeOF target model attribute)                [passed]=0A=
>      runtime  1.223s  ...  1.204s=0A=
>=0A=
>=0A=
=0A=
