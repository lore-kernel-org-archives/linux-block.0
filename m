Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A1C32771
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 00:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5CF2173E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 00:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SwyN1mzg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k7Q7f9D3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA1AFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:05:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34682 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1AFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 19:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580169960; x=1611705960;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=v/6mNLUrrXn/zQm1tJiyZgmgNY96/kE/upq89oVZgyM=;
  b=SwyN1mzgCQHZ0Ry+kfqrBVVjtjQt2rimSx0Z+lM30KGZ5RN58VHNkrh2
   QJ4DZBFYUvM5+nfMYkcBiioHCM0noip3tp6cqKLoGlDkymAJwSKVz+rlR
   qkoxgpXFqsdlU2js6tIb8U1/DtVAPh5knybwykzmMSFJx3fJbwzZgFWRW
   Hk/rceZU24qMYE9MLywgEHqE6u8vSQ7QEZPw1yZtBN2yB3BJuPhazRx/C
   /vK4WLHhST4l3mufgGa1F81IodCBvTOqz7YIbeQbe9EauvwhbJeiG74Hh
   A2KVVdoL/loAct0y5W9mf/adY0C3sqXIRBGjwi+8orGsjLJf9X3sSdfxg
   g==;
IronPort-SDR: Qh94q11kD93T6na+NFEHgr0ufY6MY6KIIOuGQcBZIJFSUDWPbdM0LY1dq9xLRGHtcq6BEODGfN
 HWVVj+p4PksCyaWy66zQX5UUjk5FvNXO0srlUIEVuMKeg3sOQUNBxt5JgLHulunFiGtfCToguf
 ye/kXAeyV0SxD+smuqwUVn65ysSPHf50aAvxR74cFPlW5EluYTEqEDxMamRuejJ5gBBC4Qixc7
 enlrKBf0CvlPElZ7RlG11DQiJkQ7rGahyIbL0DT7PxWCRQwmggxGG3d61Lpmxl2DhuWvck/0RY
 DpA=
X-IronPort-AV: E=Sophos;i="5.70,371,1574092800"; 
   d="scan'208";a="230230550"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 08:05:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYd72EcQ9nxOz6NRKxwG3B6HMNewBUlmJFiulWr24ClaifZumkZr6vs6JkHwH9OwywPclgRrYnw6V07h3Zwv9cNCdwZ0iREeLuzAECyq733E4UkVGobPPU599NtUI6SPr4jAlI9uODOD2lJZF6l0+S2IsNNaMqCjUV6PHqDMbNmLd15bboWn+O13UF5Nij1scGk+WnmIaoEzkqPPxrgCFjw2vWkZW7TAGRFxoEylBH7UD/PSpLFSlT08aOxi0uG7lC0aByQPQ0jOS8JBsiEJbZhgNujSdrtGTuwybAuyzO9W1+GGloj9RYZLByuYBPXGSiG0aiwHraEcnOZHzvjHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/6mNLUrrXn/zQm1tJiyZgmgNY96/kE/upq89oVZgyM=;
 b=nhdx/8glAnIEdfm4uNbOfc5qukHVbZ9+zT30W4uf9XoH5KzS6b8Ie0lR1VGkYkORM111K3EO/fAAO5T3AaauAsXrbH2Xd/80UUqqsJ8FKXzpWNSQpdhS/9AfdPlvOB8lJoTvOQvt8W7jzWH5YlUbw+RVdGlJ+sBPJJL3nvY1ziHG16KuuEwkmQU7zsfu1p2Bn9zUFArZeyKHk3ucrixgSMdx5dPKwTspEfDSCi/dmad+FgOn2Wneflw2fGvpaL4EtQZoYafMY8qo/6D/xIxltUVCCprH2vS9DBZBiHgccagmpuQ60fSdeTlw3D1vMbFUACutSI51KUAeFnh6wuaC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/6mNLUrrXn/zQm1tJiyZgmgNY96/kE/upq89oVZgyM=;
 b=k7Q7f9D3eLdF76gyK6lH7zMuJ0rqykdG2/sUy5Evz2jWkDDqQKR/qRpk7xhukd4YuRRMSQ4vS9ZUcps1PGjb2XTjnuGFi6dkmUHIFgLmQA6SaBCYEBcKWhl98H1VJwPUvSuAgtJMgn4kKPxj0vukk+jVCwS7Mqf/vy/ehYEqLlQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5112.namprd04.prod.outlook.com (52.135.235.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 00:05:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 00:05:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests] nvme/018: Ignore message generated by nvme read
Thread-Topic: [PATCH blktests] nvme/018: Ignore message generated by nvme read
Thread-Index: AQHV1SGlNMsMkppi3UuzylVPlOUiOQ==
Date:   Tue, 28 Jan 2020 00:05:49 +0000
Message-ID: <BYAPR04MB5749C8EED424C507945446EC860A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200127145353.52129-1-dwagner@suse.de>
 <a84f53ab-3f76-df73-e9f7-fb57c03eeb2d@deltatee.com>
 <20200127173845.5kbzrix524bmwwa6@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6933df6-cd56-44fe-8df8-08d7a385d4dd
x-ms-traffictypediagnostic: BYAPR04MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5112E0E5F8AFEAAA4B3AC917860A0@BYAPR04MB5112.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(4326008)(26005)(478600001)(2906002)(186003)(52536014)(55016002)(9686003)(53546011)(6506007)(33656002)(8936002)(71200400001)(5660300002)(76116006)(7696005)(81166006)(558084003)(81156014)(8676002)(316002)(54906003)(110136005)(86362001)(66946007)(66446008)(64756008)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5112;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YA40G4bLsmXF5RWDQHu05J8FRK6A/Ekv3hpKRVmWLDUERMgnhWcVOac0Mczx0Xoascn5LDWXwRC3IcWryU6bxKrUqODf/4pEjmOqwvCnsCTFxjT6kzspbJKRs0SI6iOVUpPMMXNsOdIjxitpEQrjNqe2cuy/T/DQpmEnkZaR9elmPugOpedKXrJ3C0YVQfuRUPi2aPY5iO2W8UIbaEjfGMwZOSRMwCws0ovP4xTrgMsUsQF/Rkmmxi5t+h+wqi5yiwRzWJdxyt3+lH41vDhB9bkhX/WQBj5jslvCmf7Dfb5Uq3SW29rMxrXoKIhDYS7P7jgxfS3eVJ6h64jfH1KfGRC4l9VSNKvvmBMNNbIBhmxLc4FEQBqr9DAJ5bmiCmja7EEeIGU9eJS6fSDu2ib3Kw/ykLAtJo4qtgUMqFzn6H10j4wjdD81NM49JIfKwcM+
x-ms-exchange-antispam-messagedata: L8my/6Y4EJgCbsbf7k100ub6kGJDaqOpceiah+COoGy5FvYNq4UBaffqJSHuUiiNTNvTDLjs3ZSrf4ok7yZgO/KnFwun52qfYVmXuTiUR/tRu1zqDXOIqvP54vy5UTo/7x1e8IxUvuSY1o1Is1d0zQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6933df6-cd56-44fe-8df8-08d7a385d4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 00:05:49.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzmFBd/hWtPBw16m6do25dlg+Du/SQGgIr8sv3b/los4aru5TIDu3N+6w2JhooKDyD3V5sv2fDXtoZ0yJYXmjuW7VzDyGW9WZ2CNx+03eCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/27/2020 09:38 AM, Daniel Wagner wrote:=0A=
> "ERROR: lba range read was unexpected successfull"?=0A=
nit :- s/successfull/successful/=0A=
=0A=
How about ?=0A=
=0A=
"ERROR: nvme read was successful for out of range lba" ?=0A=
