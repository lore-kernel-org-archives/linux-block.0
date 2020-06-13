Return-Path: <SRS0=0cAt=72=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B73C433DF
	for <linux-block@archiver.kernel.org>; Sat, 13 Jun 2020 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00D1206D7
	for <linux-block@archiver.kernel.org>; Sat, 13 Jun 2020 00:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k7r8HkyN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k5yQ/E1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFMAJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:09:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10961 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgFMAJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jun 2020 20:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592006988; x=1623542988;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QL4FMN9OjUevw7x+MR80+di+Y+00qIlZtyzQvmk5wVo=;
  b=k7r8HkyNFKiVRQbysftCl/sv3DeKOOa60ZBdz+iuef2EBJMdZaG+UWYj
   qJv4O7rXyiwDrdAfRIQip7IusIf3QPtJrXOgeRoQ/wUVZwqlHT+h+DRAV
   IMOAuN/s59qNO71IqRgDiLpakwp4oGGCx+akGHrTf7MgUMsiIbTlZ0EeB
   lvs2pPLbzmYPEG/Le1bXzYYTa0J6YNeEEuz/qMYnd90LZC3DG4ATQtXGT
   49UUQ6tE5UXfKHlmyLGVJjqAAOJwMdlHoJhf4ks1wH2DHblLCru0Qt3c1
   zhLRYR9+q6zJ9/vjMisOQOyA0wHaVh+T2EcR9v6PwSX7+qe8O5U6Ewm/8
   A==;
IronPort-SDR: NATbk3B2/1CmG25fe1S97E9SX1cPqmuvxLbSRoxL70RfMwBY6CyypMj8cVNvV3pGySqV5EQGNi
 i3Oz0diWkpBhHwljzgLBsCpDopzsZTMCiWxgLE0zDswkBRdgMce0quFuq/s5wIbQW4rla+T+g7
 qXjvX5trgLFuhUYYZ48xdZ3cCtbyOo8WwTsdqLf22fGlfobogbvSLJEnXhsglhBPCP2YVMWP3m
 sXrt+btL0tyXw+eBzn6LR3WE6fVB/TvGBAzg/RfiGKMS0h8e4KKP9yo48lLAlkKKakPfZr3rKO
 vyM=
X-IronPort-AV: E=Sophos;i="5.73,505,1583164800"; 
   d="scan'208";a="249028715"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2020 08:09:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns/0Gf4fIlTs0pq4iZuoXopMNkUaj7gAe1hkjEcpRyqxDXoU1/Tk6GAYj4fWulaAHsOZYWLzvb3l5M/LZ+dN6S2dznhM/wcl8xV+7sDgeOlTtl16Rz6vxx6bSLE4wcUcugINUTW2jlMDTl5oLE2UKrpqUYNMjipM2BI8p3mEaGdiIFXZ+vJ5OJTlip3qQH3T7gGLF6YskU7YULpBJOhSBXwMSvEpWKUGPEcq+uGs8sLWcm3K62muoOt8s6mmDhpnsarCKa1fKrAMWYK7J2QpV5FvLKGd+qepzD+l+kqeibyPHldfs7ktD4/D9pSsnWj8JdMcjakN3Mau7N1hQupWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL4FMN9OjUevw7x+MR80+di+Y+00qIlZtyzQvmk5wVo=;
 b=RBvqtUVGotD41eTxBFoSjRzF4u+epH2LIO7UC0zy+wuML4aPcfIup7HurD7d5QzpxSQmEYRPCRBMQjdYibbd7IrI6HVR0gpGZ6NtGYGvsMqykkzuPuA4jr5hfP2km7na/GwGw701hgKsRV7HjT+aF1qKpnfyeKkS2iX5IiqoZyWXYFtVvk2mmyA96oJWhlcIoRXHEX5V2vwIC0CtlmZug7TU+Cbz/F4PTI3AEDZ6Mfhjolj7DGU4NB3Fp0KF7Aobq/ckpguo+frIQyFQmxJCIln64CVbpytzXA1iftmsjPoy26He7mbM1wr7FSBBGEqoR9kyikpitcaqYedR4Z8m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL4FMN9OjUevw7x+MR80+di+Y+00qIlZtyzQvmk5wVo=;
 b=k5yQ/E1JP8Jh9LSkFdEYxAMWfX/PI++Hg/7ry6iL84FY6yEOsC6HX9+gxh0GHCa2v4IymEF5flRmP86IlW9S5XiSLq+YQSnXB+b5t+aMewNJ9fTdV2iF/42WTwpNT0ogUONkKWKsJdgajLahp2p9j7x97cY36x8ZJ5Y53HCdMEQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4231.namprd04.prod.outlook.com (2603:10b6:a02:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Sat, 13 Jun
 2020 00:09:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Sat, 13 Jun 2020
 00:09:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Topic: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWP5BXDx26ID9vUECrnGzQKUaQfA==
Date:   Sat, 13 Jun 2020 00:09:43 +0000
Message-ID: <BYAPR04MB4965B7894160F6EE0861D2A6869E0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
 <8c37b659-30bd-8308-8697-27868b2a4ac0@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e081957f-981b-4148-7d80-08d80f2e12d9
x-ms-traffictypediagnostic: BYAPR04MB4231:
x-microsoft-antispam-prvs: <BYAPR04MB42318E2111AD5D3B68163C46869E0@BYAPR04MB4231.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0433DB2766
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4r4AIWXalZhhqTECtcKyQ6iBaJ2KmIPbhXz4YoiThas29gA6h5BnVwgRtTcdUAj9obypGzgnrx8h/K3LTaiF/ZOSgZqQpO9sNE92TzMwnwCXQ3/AUzsn8FgO/RlpJRHTQjJ9bDJamE+UyRXwSdyxXA3rMqawYjCI8MENpAccT6ze0Zb30ewT3S/XhsmaUTQwtkwGyNpwITLM4iJfr24D2URnTgo5dRAJ4V+tEnr2nIC2q2iJTMItMVgByMEuSJaFB18NE7YGWT0PGEckK4oDp16nBnETog5tCuaJsgDopmiZnw2Px8zlz3V/GAnojbcT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(7696005)(6506007)(26005)(8676002)(83380400001)(5660300002)(478600001)(76116006)(66946007)(186003)(4744005)(66556008)(66476007)(52536014)(9686003)(66446008)(64756008)(110136005)(55016002)(8936002)(33656002)(4326008)(71200400001)(86362001)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HjzGPKgJ7ZfGRmvwMTFUAnfwxjMDWnSg/LQsatgFkJikIKyxEqvR8zTRE+r28+Yq+W69klYXlRz/B/Yt/7bVMT+BtESlW4uljPnNkU1aUiIhRGFkT10ricpPSxKqf4CX5WvZp0hT4tTVQW82TAdKsjIZFG2vA727qxw8VVo7TKXQeYls32AGyETaNgnMc45WgIEKhOT2dfl5Btz5Leq2T2Z6Yhz2p+LvzHUofapZIsTSb4UMlhUCuawLkX1SbbO9ePmSHRTrj3J+/1TgD9+TqyLE4KfBS2s86slsC6g0QhX3zOx+Q/JTw4+jZ5Vo7sr8FS7TcQC7CEqvwzlWMxaig1uGLTDtsUbUPRMnnqenI2hageJa5ywULQ9q+RheeBU52oVt6J2UJsbEjSxStaLM+y4KDLZb1a+luxnVmtmhdhaAe/HtuRb6sJQLT4y/O2p+X46zbKbcrIyIHAyrcgpm6HSFn6OfzypQWD7fZeaRKXY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e081957f-981b-4148-7d80-08d80f2e12d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2020 00:09:43.0341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+lVVotyXmya0SRXblOSrDtAHo4XYLSp3WAvebf9WBQ8w2rz7623igkxOrJCNxKuaXsL6p2Tn1+7JaVZwDO6jJHoOKUxCtq5r9b6y6VjRUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4231
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Is this the wrong structure to add a limit like blktrace_max_alloc? As=0A=
> far as I can see struct queue_limits is only used for limits that are=0A=
> affected by stacking block devices. My understanding is that the=0A=
> blktrace_max_alloc limit is not affected by device stacking. See also=0A=
> blk_stack_limits().=0A=
=0A=
I can also see that, how about adding a parameter in=0A=
struct request_queue under CONFIG_BLK_DEV_IO_TRACE if we are going that =0A=
route ?=0A=
=0A=
