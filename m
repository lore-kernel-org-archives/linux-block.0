Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDFDC433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868EE20663
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 07:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fD86fQmj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kl15JkDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbgFYHmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:42:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21907 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgFYHm1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 03:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593070958; x=1624606958;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=fD86fQmjo45MgTT7CCyIEd09YVHHFN2wSzjlbOOFUMngBlpiYsdA66io
   hf7QGn9NuPIraZkdMoV6kPY4DIJwQuVuS31ipjnApE4X9Ri++Io90aHXa
   5t4Ztg1eYwmUfUNtYCe85wGs3/CUx5MeGFZXe/dy3kOG6tBc5CGNETU0h
   MVu3BmBQo4Ayr1GPoOtKKSvQHkL6faVpLktNz47hadCCt2RV7JixXdnTI
   Qrspe79yNVIlk3tJiFnfWcvWpeJRMHHmUJ0hLHxJtYuvjFbRZ8Ew56hpt
   pEYx1kYov1pap27bLF7yeO6qn2fJ82D/hpZCyVocsoxRpiozlByNLQh3r
   w==;
IronPort-SDR: x+luEO0430ilk9C4gV2EPVccfSoCl+h0fZS6M+q2puMSqxqmQpKI8zuHOsnneo9fZa+GdjBjYY
 +asNYnZ1L1t9veTZD+h8AuQLsFrs2vAIMz42xZLd2WzlL2VNgKbydXfcDHNc8/QLLXo2c//62e
 aDAxqtU3dfQR/JUSwAimOBAO9aiFYfa5IFyZhdaH+KC1DH/+V8jLiSrSoi7IshmC/pDdAisVNb
 NanoCoOpOkHxMl1SNy++I7hNGpP55DTXMhUVwI4ghcTPJyECTYotaxA4it438swpfc+DFFyQnY
 pcg=
X-IronPort-AV: E=Sophos;i="5.75,278,1589212800"; 
   d="scan'208";a="243886580"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 15:42:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4Xf6JXbobu8pTnEnzWaompXOrwjr7JWwbzoFp27Gcayn6Joj/ll+bNelilyeGWeJULf3i6o64DB2Wh2iwe4ApkFNgW2sMh6vmTrST3x9Uo/FhGKpldNshOqvxD3Lsb0eRPDSCeCNDlZLRh6AvGjKqfEE4Xwy7jhOFTo4vN9VQT0M+/DH1PgeguRw19fnbdQKDjQSvlLM4JTsHEpq67ur1J2mXsb4VLpTNahm4ZeLrfvgRCovP4KHabuWef3fKn9EGo9zmE5IWTctQtHX14KlZkc872zPMP0/Vb+LFN/i1g8zWaCNMYqPIeui6MnSBZsFejaShwjGZFS4RokvC/Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MFfLzyraz/5pj1CxFyfHdAogFOCyS26BJvUFA9QuARNMNuK0xk07BL0jm2lWzlqPZqigcnvjZVnkVv20hS1XCW0N5aY6gw89KGfXpngoPsI8b3U74ds2xl5hCL3ZfLMycmE81vfZgkWfCc3+u6tIuiIfjPuQI3hKVI/8RGijez9MjPLJVWoJc0e4lIFYNvBz3n1SSRuF6aqValwqmqf0n/3gQDEGf7zCFgTIUvTp4M3iwpjbweg6IvDyiWSUzpMS1+C4tQ0xIvzChP8EeYsPq67AWqy/UwVhxnnTcliTN4aeEuMehmfw8Q5nrJcsHGZIAE2smTZ8y6WB0wl/0CT3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kl15JkDhouCidC3lI5mzUy/lcpoGA6vLBPU1bAUxEw+p8EIJa046yRnebInEN8MPgRMM9iZMdNKBKEASAeKtQAp0qp7j7cEV4h3cBo/22oehqvpvY5Dxw9B/dJRsLfPcN6nwqPtOh7ohPJ5Bwd+NZh6UH/m+cwQLervRR70kNlM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3965.namprd04.prod.outlook.com
 (2603:10b6:805:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 07:42:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Thu, 25 Jun 2020
 07:42:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V6 4/6] blk-mq: remove dead check from
 blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V6 4/6] blk-mq: remove dead check from
 blk_mq_dispatch_rq_list
Thread-Index: AQHWSnvSAt5E7V99fEOLHvTZgySYfg==
Date:   Thu, 25 Jun 2020 07:42:23 +0000
Message-ID: <SN4PR0401MB3598A4C479EAD3E37D11C8FB9B920@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200624230349.1046821-1-ming.lei@redhat.com>
 <20200624230349.1046821-5-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66e446ee-d0b7-48f5-8c07-08d818db4cbd
x-ms-traffictypediagnostic: SN6PR04MB3965:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN6PR04MB396527D12A2C96046F013B1A9B920@SN6PR04MB3965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9EXFf/HDJBNxmslh+8WUFqu3dF5NRk4mZNDX/j43s9eSzwJNkRJbJUTgwLcDzXzurHNtNOCgd5N4NhMzaHxPKRcVVCL9GJgBbL/jkpKof5NBylZ/HbjiDO42L1tbLFUDSsSEZis1J0+eD99WaBQcra7WRDD2cAMfR/eZMctZ5Zp6B/JKU0F0fI8dMBZ5oz5gF50JL8uBNO9y5CXVlwpnv8ouhTqJDhl6BcOonI5KWRFHr3bYbCVtYNUKUPpt7tNWCwG4NHTuvO0RGAjCk5QnxhGKLMDBfKpuJjidVSPbBjW8WireKIo/bFMnQLDflTIndjuNn1fCwvLTQyTjvGVLdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(66476007)(186003)(66556008)(76116006)(86362001)(91956017)(66946007)(8936002)(478600001)(316002)(4270600006)(110136005)(6506007)(33656002)(52536014)(558084003)(54906003)(71200400001)(5660300002)(19618925003)(64756008)(66446008)(8676002)(7696005)(4326008)(2906002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mbyfAF79FOa4YsYWsvjyFQbY6pO14ve9Cz9VxZn/qFkNUJG+P+dbPQfjthPXhR6TKqH3hILzrbef4JBapmOdGT56KLJhA7IDowboepVj4TBgGyn9dG8EKt2h7TRVknPNZKzeLet/tmZpZ5Ckg8fejKhs+dHQxBqjV8Ys0qKMmYiFmfmHHwNkbYJ9HJenFViE229hgUcNuaCr9d0Tx5zyZjUq/PENbElbRS0e9Z1Z73X9zu/o8phInCVs7SujlzAf10Ldx+vc+MtjtnjWXIm4/lOWkhuYeq73xR6fTE0LsXUm01830c1LieKVhElaxysGby3cnPN5mSWHvh6+y2nUL3zIiIPX/1ZygZvySQ1YEgKMHvSYYq61GE89QIWfM3xKSAV8O8/T5wB3PxTf4pTFqD/A3UVZ4/MxqvnVsIp9EIFAanqA3+fTxeuRtZ5BSrF34fCuBwGuUSoQVS2TZwsNLeZSZL7/ORKCmPR4zyJr1rYQw/MOCfbJ6cEgyzExJMW0cFBgOtlg/xEHHmT/Hx60vufDkWXo5PgwKG2VCQxVw/U2Aobb+0N0klv+yBWUiKWx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e446ee-d0b7-48f5-8c07-08d818db4cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 07:42:23.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwvhbH1i7hpyoR125FEdGSA+hGtry5Q+GMCqlU7QaZG9Gr1Mt28tE+TEhMDQxKoc7j9PJny3uFDl4fnTo+7Lg7em4lphr68Thbl8iCBSHDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
