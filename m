Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD3EC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4246620692
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aoOnEeTN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Hg7/Zg67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404136AbfIMWh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:37:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48943 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404123AbfIMWh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568414247; x=1599950247;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Fym3AEh3SFKGgXyTk9/qVAD19siuANlY5H9t5ukh1Zk=;
  b=aoOnEeTNbEx6gloHKLnD5jQAztLoRtfMN3on8zpK25xLqN9goFoItoDJ
   ukKZwzTeT2T0QKGmPPCEZRHYFwKp64tH7dNiWZLuCWsSGNcjRuF/TNFgr
   /mG9Rq9c3edQd+DZRQOKujmByoJcXTFb370W/6YXvduTf/bhW8jeSQ5DZ
   gY9eluzFBJidwzYuWy6CrtAA9Xo5MCzP/Vfj1xVmm6v28VRXa1To7lIlc
   qLUp8Uq4uNPKhzgesfbTEX9XNN1FmhIt503sRwPhwVvs6pr0aTn/w3opE
   afdgJRcS5SwSXRdTGI/dcJb8rlMUwa7MFDxb+VcxhMFMwa43ta3fk3Hjs
   g==;
IronPort-SDR: ZabXXmtCy1ppYN/rEtUOF6tkavCdAe8GLqAdWKqLVqZ52AIZpUrQ9O7+TrQiU4r1F2qm3/65qt
 RTSXAL94Uvlw78Ve4QmrQ416waVCKPkFtHl7AbzRh+7cTNs23qGhdLcbg6E7dFGhNbVGu0bAc6
 3zSRYPCYzq+2P9jOeOT0mOiT3pn4AlcTnXOERuFIKY/Pkz3tgwpc2HrDvusTD6Vozs2+slJvJG
 dpeoEF/YuA8cCX9wZXqDenWV90Z0VaX0pOc8ZKCv+gwwXA+wgGwff91BtWipD9yU4Sc9K0i2WT
 KuQ=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="225004220"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 06:37:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM+UgqIgZ/qTBsxVrBJICAayyRzKa5cqjwGBYaL9A6QjM/IY9R5eATfdsAI8lQqWp9z6pe/2iBL3ijyAECRASn0bKLqQuWOlCfbYyNXiROnBQTO/OYreeKOAePcIB39xF9vufie36Fe2SXzqac0tm+t84WeWYWMQ3DyjGVleEPj8GqIDNDCJREnoVZ/R67+vQ0/ctVZvFiXepQhZAcM4eMMYq3PTTlv3ghENMk+UFZTCWGGdSNgKSGKUy+SlA/YCwiTGzHYgWiA13HERGgIK4Uu4UW7YQzkLwK5tceNisU1wxVEMuDbaitW3idKYjdJ7kvoDJDFUYjR8UDPFTUxOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cLXyz6O9wo2sX1CWYn94706vFX9/b9xJl8ohWPULUw=;
 b=WubZYufWfxLnAUx+xo7xkKnYH9wwc1x9ofELF28/IHqutBIU+YUIdtf1SN6aogH4baQe/7SXybZqolWKiS+2OSY6gZzqm1o1ohkde/+7BNmRqD++QSB0wj4Pu+/ztAdAE7XKVJr50kbIyZ3bWfHMO1T39pZdJ/XdMH8AgyD055y5Y5hsXNWpXOCOvWDBpxFqFOeX3AAEoZN5cFs1cRh5IacT6eIwH3jRYVbgxrOONwq20t+YuFuDDTAeLqiT53YExabTwC9R1khxqDWNlM8NPtAFNeRBU4v1vfuD5pA98dnqobX3GzdnkWORYnH+2dmTe2g7NOKTRlMIR1z2bS033A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cLXyz6O9wo2sX1CWYn94706vFX9/b9xJl8ohWPULUw=;
 b=Hg7/Zg67kEcOMF0pF9F4zMuJlofy0taQIef/F/0xy/RL0lXtyTShVxEBT4+I5QGAlNkl1xaIg2KKtJ1CgX3dGlzp3A+pY6bHzKjHLuSfLWgIz1V0P0LhTXlmSr0Sr8Uso3HFWIcMoHy84FOiTlWjU+VtSym6hF+EbS8/JGg+c5Y=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4550.namprd04.prod.outlook.com (52.135.240.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Fri, 13 Sep 2019 22:37:24 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 22:37:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH v2 1/4] null_blk: do not fail the module load with zero
 devices
Thread-Topic: [PATCH v2 1/4] null_blk: do not fail the module load with zero
 devices
Thread-Index: AQHVan85AifiRz+yRUqzbl6jvX3qQA==
Date:   Fri, 13 Sep 2019 22:37:23 +0000
Message-ID: <BYAPR04MB57494AD6FADC0654403613CE86B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-2-andrealmeid@collabora.com>
 <7c0f4547-4193-bd3e-85c6-d950a004ac46@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b69170-f7d1-4d55-3902-08d7389af2a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4550;
x-ms-traffictypediagnostic: BYAPR04MB4550:
x-microsoft-antispam-prvs: <BYAPR04MB45506AFBBA75CBCABD6D449986B30@BYAPR04MB4550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(51444003)(256004)(26005)(2501003)(186003)(316002)(3846002)(6116002)(14454004)(53546011)(25786009)(4326008)(478600001)(6506007)(7696005)(99286004)(102836004)(76176011)(8676002)(8936002)(81156014)(2906002)(110136005)(54906003)(66066001)(81166006)(53936002)(71200400001)(71190400001)(74316002)(7736002)(6436002)(9686003)(55016002)(229853002)(305945005)(76116006)(66446008)(64756008)(66556008)(66476007)(2201001)(86362001)(66946007)(476003)(446003)(52536014)(33656002)(5660300002)(486006)(4744005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4550;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eSOYLC0LyxFMDB/4a740q83PCMtgXqykuzIpoNrq9Ioz2qDclJ6/RVot5debf0KeUCCCIP0ZJd8s87mOOugc0HriyxvVGDwXn2eFxqd1SQAeTkwd7LDnEr3udPgvt9gwgm+2XyNdzSrq8qaWjdkXpr/BfCtRmVfueOHnlioZ+cAmU1lqEztjpDh7KCmFPo71046N8llbXwEkuW99nGzMpqNNCRfwTw1m7tc/pqbPZB16gBV4HvtvB/g7O3itqlD9lcpV9EsWyE0gRQQ6irF5hCS3oinUeo73cZQ1ClE5e9+tV9uw/O2P8PGlX3bkRKs6ya6sKc0ySlEu0wxTVRDB5BGI8M5Rc5hJMXqDNVgXOzKKNpa4GaEoRRYvM4SMDha9TDVUccfia1s/He7S+1GC33jL5DMOBXmSA1U3PELbNVo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b69170-f7d1-4d55-3902-08d7389af2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 22:37:23.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o60mFgev9ke0qyDkHv7UZeKI3rtnW9OpFYLatALGZ0TCL2Zw99HGyFTq/bINX8dfUxiPdJ+KQa9fe26j1GLf4horkeA69RUs5lyw5BIBLXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4550
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/13/2019 03:18 PM, Bart Van Assche wrote:=0A=
> I just noticed that this patch is necessary to unbreak blktests. The srp=
=0A=
> tests fail as follows with Jens' for-next branch:=0A=
>=0A=
> modprobe: ERROR: could not insert 'null_blk': Invalid argument=0A=
>=0A=
> I think that error is triggered by the following statement in=0A=
> common/multipath-over-rdma:=0A=
>=0A=
>       modprobe null_blk nr_devices=3D0 || return $?=0A=
>=0A=
> Bart.=0A=
>=0A=
=0A=
Not only that I'm sure my membacked null_blk testcases will also start=0A=
failing without this patch, which I've not posted on mailing list yet.=0A=
=0A=
