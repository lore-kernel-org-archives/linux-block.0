Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F965C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 03:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CAA2084E
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 03:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QmVFk83r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H5RWP40Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLD70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 22:59:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48955 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLD70 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 22:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573531166; x=1605067166;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3hSz+0qBq2Ga3CxBDMFi2oehr3ojDAu3jnveqzysVHU=;
  b=QmVFk83rUFdlvsszTHg6MJo18VrqURNLAWDFGdsBPCSDlgxTrjob+ODU
   EzoMZTOEw1gYJftCbEgaCYtwOaMJourIuE69tYiaWtRC3maHlddl6l770
   Y4Xld4+FdcicJdGwGqco7Aru0hPr35UJO0dfDf06ebI3XNg4afPaC/pVP
   vFnefXFL7vA2l64blXin70Eic88bHxwH6Bneu5yLtN3stDmGBJJ2F0lqi
   rLO3frxtpN9EA5SMZ4iLDy6nfJ8dl/KIbQTFecM0pgEX/P0aw7ZQGP+5r
   jWNLr4OP2gEmkOwsaE8gWSzceK+2vZcbmM1dZ1B7COdhH6YA58PAhCKDJ
   A==;
IronPort-SDR: rdmQcMtXKVcXohadE6hq67zum8iBpORW1hDj9q4OGcI9+i+NXt6ZvPjBd/rs32kMll/jqnwUBn
 CL2rMpTdNWx202ZsptKO7JXzItCBb/q3oGJ0n6txX1GSaar8ulm8qbS6fCdREbRSlLj6cjzCDF
 YgekPQt4tbkN8hr/1FFltZ5yPKo515fa77+a3tBRO3Y1D13LvZTvsDmsxgg8dRg12fLnMzl44D
 zC3iSRKaMzaoyoY703dZILW4uEbmEnzY+BunoQNtA3ATUufA6i6Qtitkks6kNozhvjzqiwAAkq
 cn4=
X-IronPort-AV: E=Sophos;i="5.68,294,1569254400"; 
   d="scan'208";a="122714520"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 11:59:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLBEy4FC06RCiWy895FnTj3fiwFy/NvWG8I6e3IA8elkEVSGU0glsZJ+WSMZJx3iftLcuWvHgqquYi4cQj633hJ8pPlm1SuST6zGooCm/sO87MKzrWq6o1NqFMyZ6dvtYGBzYNsXgDD551ionrKXftSmW65dHVrUrbIw7NkhGGtkzTafP15EfIhQBElSbHDL7p/n/oBTUQw17hgWcVMz7MSHZe5ZPTtJ9TGPaZXYbSAE8B+m717oNEK0sxXHmKfiOVMwO6vTFZGZYYPmdDvOusgsmCs0QQQarWX9l5F629pr8Nc4X7SMMHfEgAq6jGJ9eePOA0lxtEWr89rcMU0hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hSz+0qBq2Ga3CxBDMFi2oehr3ojDAu3jnveqzysVHU=;
 b=iqNhewaW/gHZ8aZ6cSn5rDrgsJZFOekVlCn9fKRuUPqkbXTUrUNBpD9k1/7GCQL0xAA6+MbTaZLbO31PVYirCEl7LITBn1doIRPMNNBAMfjPdMZpg9L/HJzL37nzv1YuZUhgeanwpUyGj9yFD2iajmLPj8jMpNhsxiqy48LPfEFzAdU8TgSkK29e4vpeqCqYdgXIOjA06UtsiO0p8VUBf5EO8xuJk+zuG6sylShrv5Qr3J0+jXtCrE2BYL9ofK7DLKL9mXGyA9tTSclpr/2bx3Cabldu5y3ehTC2OGGlzKdYjE5quX3N092oL+6a0RhWGYlzgOaMaIQWR+HQRX8zDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hSz+0qBq2Ga3CxBDMFi2oehr3ojDAu3jnveqzysVHU=;
 b=H5RWP40YGE+dQGrCbNG3wcLT27/KA40DtrE+ACeQ6s7wQQT4JAeC+Nk4KDvBz0rbq/Qp3+vlumtyyd46+Bxe1yszCjvDEJRj8bM/KB6hntdxinqngubZ0nt0pGQBm1Tgzu0usoBDXsOs5hENcxtMDHVrI7vewSRy+lJarBN9Hdw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4422.namprd04.prod.outlook.com (20.176.252.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 03:59:24 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 03:59:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 1/2] block: export blk_should_abort()
Thread-Topic: [PATCH V2 1/2] block: export blk_should_abort()
Thread-Index: AQHVmNWelq+x+nEUgEWYUOaMSU0ACw==
Date:   Tue, 12 Nov 2019 03:59:24 +0000
Message-ID: <BYAPR04MB57495D6751683892C573212386770@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
 <20191111211844.5922-2-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5816C47CA07F4A83CB160E10E7770@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf0540a2-7322-48de-56db-08d76724b4d7
x-ms-traffictypediagnostic: BYAPR04MB4422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB44220D763BBEA1F192B30E6B86770@BYAPR04MB4422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(229853002)(186003)(2501003)(66446008)(64756008)(76116006)(478600001)(9686003)(99286004)(6116002)(71200400001)(7696005)(66476007)(71190400001)(86362001)(446003)(256004)(66556008)(14444005)(74316002)(476003)(66946007)(486006)(305945005)(7736002)(3846002)(4744005)(33656002)(6436002)(55016002)(6246003)(14454004)(5660300002)(102836004)(4326008)(76176011)(8936002)(2906002)(53546011)(110136005)(66066001)(81166006)(81156014)(6506007)(316002)(25786009)(26005)(52536014)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4422;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dGm2HIVQOW/Z9kmwSCN0PV/ZuTLAhJf6tE4NfiVJaszlRgir+egVOfWxBfjO+iEO5+63120X2MINlnkqU7kGTNR3OCFGrJ20pYJF8xXhhdf7YEaMCZSC5r534xERNJeyA8Q1tDAa/VvvQX78pFJJbfJBHbUlOOxKvfUE/aVCYzfkQX+LQ1G+0sAwzfUyBxrnqB+Ozfya3+w7Cu/WFwTpmT7PFs+vj9BcLwWQShdceKHTKreBiVmmljOLPm+okGsCmA05CCS6utzl4XBG1asKHyT2Wuy84ttSimiXA+zVpr3731hl6JEFWsI0Pm7l1OUPxMh1bMAVRcjpebq3Q5qd+AqE5s52EwBBWPm35au3BAmOTOwDKDz1zKAyyhcuSLwH0G7UsS/mEQEEUQCcuilli+pI8xgCfXUbA5izG6t/8rxI9a49sfriGhSPVuPL8JX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0540a2-7322-48de-56db-08d76724b4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 03:59:24.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqd8Los2MOcg6DVjOM0e1OYLxizeI6vTeMOCDRNOiazQnh9nCxUIOejtDKYvvxFwZB2dLcBo0vJhuWhxwkm/oWwrowMvHR+4LBlaLBBEOxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4422
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/2019 04:01 PM, Damien Le Moal wrote:=0A=
> On 2019/11/12 6:18, Chaitanya Kulkarni wrote:=0A=
>> >This patch exports blk_should_abort() function to avoid dulicate code.=
=0A=
> s/dulicate/duplicate=0A=
>=0A=
=0A=
> And why export this symbol ? It is not used in kernel modules so I do=0A=
> not see the need for it.=0A=
Yes we don't have any user for this function outside of block layer yet.=0A=
I'll remove this in next version.=0A=
>=0A=
> In any case, the export should be EXPORT_SYMBOL_GPL().=0A=
blk-lib.c has EXPORT_SYMBOL() so I kept the same pattern.=0A=
I'll update this in the next version.=0A=
>=0A=
=0A=
