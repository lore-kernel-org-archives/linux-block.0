Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A599CC433E2
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754212075D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F1tcv11u";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xRsgaz5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIDAXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:23:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30400 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgIDAXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178994; x=1630714994;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xy7nsPXbGiy+eUF2Tq//KyiXuDfd1zma9vU+7LeNoHY=;
  b=F1tcv11ukw9aiciQbbnix7Ls68xvJ1eUlJHFL9ClMFFHg0E+MoU8VXcN
   xpS+sWLH5OhAiDXN4tPovifNqIhZzUPZKB96SPpunjR0ZE0Iy9+To/kOF
   VG7mfjXC7hEMeRqGVya+K7ZrnVPRt8WnMO0MXF5oKE4XUvrcGqfiJ9tWF
   BC0a6VbEpQ4HAwkT7nOZL3joWockQdQNAZVKJi6hGsBhel6LdR3ICn1m4
   XJvutymitZ/8P7u15bWJ4z/Pdx9Lg8xvJuSXJf3Ejy9JjDPCJFJNMVCGJ
   kgAyuRgyU+W3NOFNp0LB68HXkkgl6Q48jcGvds5Svl5Wlt+r6ScsDm8/D
   A==;
IronPort-SDR: fusH+guujrwLeGWaostf/wxEvIXNSGZAXYD1YtoCJIJIN8zG1iNtaFK0FMkpjooUnnqrofb6G0
 He03y9M3BYUclNOoxOLkyk8Vmv5EAcNTgcTF3+yPJ3j/QzbJeRo55VT0HWZ+bDwWL9dD3fG4PZ
 ih6jDB/QJdVS28piu52DMDo4hHBJXcWqOKjpyrqeUdx+vS6Csm0eE9ol4WRWWjbIHStKDEIsbu
 i/pF689Flz52XHdllKkph71uxSUAZ5QQWMXaQVZtVpCj1feihZU20itnvXgKxe7Wqz8Q9apWhC
 WIs=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="146469240"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:23:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbTY0IXh5guifowvRq1IrxtGlEVnIdbkvcu7bgKPZXGCuKXo9OXITTpCIGuJmgfc6bevcU34SSLmO68/W9GqBueYUsdpyzj5daLO3d9S7nM3bgxIHMf4zTo3xHBaj/BQtQVO6iVCAQH1owpfdJ2i4Kc15nW1Pmz0oIkExK1VdR/0I1GxQyQGMF/gkdJ+BDBnP7hF797uoCnZuEnP8q78O9uhdabN7jjVmfUHMsieBPC4eBwN+/VQenPVziuCzLB8GwMluGKzTJLx6If9ui11BTjBMmnXSWMA7h8fhFH0p0zCLEsJ9weRSRpz8a29S0eOyJQUSK5jiTubg1zSefYceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy7nsPXbGiy+eUF2Tq//KyiXuDfd1zma9vU+7LeNoHY=;
 b=Qs3irSpm7Xv6Pl4iVXXCLpQBw4O9WKHDOpnwlQK0PTv3wsEnn/bILt8hIS7wWswVGGCzsfOYujC+/cdk4FOBS2tvTO1X/6DYw8Baxno1gvRluSItjmn98cKASbdsoye8lUoDuIWtMEcY1pV3Tt5dNlf/1/fmKxsfnjy0QC2KYeqgQ9Q9dgn50qjHH1rqBc1txAph9vq6edJs/MDxWJnsKUCzASz3wTNve/YKmBVa73e+8sqOylUGJ5GPlQKgaBJAOxCGv+R7edBAwffZoVTDFDO1BZ/dewKvUU2ilnBmcEk8pKsLhtMqpb4wVMo/X2Zw9Qkso7mbEvsUhC9iQZeuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy7nsPXbGiy+eUF2Tq//KyiXuDfd1zma9vU+7LeNoHY=;
 b=xRsgaz5RLRLXcn1NC0gcmg/T+N9zkIX8HssjA0XPsuVFqCziTodFl7WwrHYhAU/C2gLz5ehL9xzAnVIlgIztMwDGb9r3fV2WzIqgoC/mceyVcJbyBmYK051uCfCWthVEVuKWcT7i1rSbYUiwMxWrpRR2lYN2A49TIaJnHllh1FE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:23:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:23:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 7/7] nvme: support rdma transport type
Thread-Topic: [PATCH v7 7/7] nvme: support rdma transport type
Thread-Index: AQHWgk2GEmV6e24DTkiZkG/6euyuHA==
Date:   Fri, 4 Sep 2020 00:23:12 +0000
Message-ID: <BYAPR04MB49653396696DCA55DED93268862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-8-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76f556fd-cfd4-42cf-ff10-08d85068b58e
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB442426B286DDE590B82A4F48862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wb+EcsJeJ5GbWdsaom7O0ofnRxjTyKqW9ZVsT67dqjdJ2q4M4rKj4im0EvrUYPV9+7jL4+zF/Cev/eqxq3Tx8i7/SM0n+OtxyIinp/4ruuYZxsLBcs6AgTR+Fss1wnDfAA4gQpjoMRYxEolCzzZ53wGtI/OJFlO/Yc8pLDV7+tfjLb4u/Wtsz7Qmb+kKRdH+dllIiJcvyzM3nCgrzbeP3BUVDCpo9G+Zv/BfX6eAUvbNUxkkFuUz/LnSCED1TIFhMK9xE4yZCFCzhEzopRKTh4YMsxQpFreRQasUiJB5UwK5aZn30VY1gm5TDLkMEsBCnd5Xn8YgkxQ6VLfXf+ViXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WF9EA6FEDM9+0ngKpEedzPemp/CIll8al8ntb0qDrXrqNn1Tt7ciZJva3XHAcitiztPZqkUOfrtnSvjUf5893y+DvgT2kGWcFdYqPCHd9LXAvznnaOPQ+IShycKcxWX6rRhacFPiwBfziTYfN0aEiqumkDH9uCAbKTWBWjwl3JEUSK+8Kv0M4hVEuYb5PNzP1tbS+zbI/LiihTCw8eSq+CUSczd23T1HvE+OppNrWbiZWNU4DwoLARmRwd39G0wAQxVrxAjTfo4g23PAvoQ9UfTJtuTRD+8ChHvb2nPlqCS2V8fOg2Y+TNjyQ7VSuVrMKnoNY8uaTgz+Tqd8FBTfV38G2x+vIL1/S0gBJ2udWzP5yEmpmHDbEgv0yHU+TXNTo+j7kJKZ2FZsapeDFhcI82aKgBogqwDrecUxvce+hTLsrrwGnE1JEgYFhUONUAC+4H+SZQL95YUwY0XG7mIEStlUGF2WOw8kmxl5wpvnGZySjizYjYQOkMgmt95xwBQ9/2QusdMrkSveXlrujzqUbDVhARPT3dBQ4zvYQXJS22D38cpcwj30ShWKPQaMLl3UDNlbXHsPFx/bMOV83xfKcFcbKH7vwRfUwGN4V2122E55/Vfs3zVVu/Badj3TOJHYiPqL3xx7oFzwwVQrelvARQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f556fd-cfd4-42cf-ff10-08d85068b58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:23:12.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0Q70avdrAIykHhYldP7L7pHqb5QaySoH34UlVxVc6SJ8bSZhZTKFdpP6j8HuE3+GZ+M8S3gvU9i1XHHDyWka5eaRyxqxMKNFTdUM52jbrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:54, Sagi Grimberg wrote:=0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
