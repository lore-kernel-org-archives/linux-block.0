Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B490C3F2CE
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0420866
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EBCsott1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AXjcDR3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgCEBzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:55:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35400 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgCEBzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 20:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583373342; x=1614909342;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iMmWTI7ZTIOCfPjo9tr3Crvd6PsV++FDzVou/J8g370=;
  b=EBCsott1IulMiMDHd3nWe+SfQnwga65XKxrt2Vz9HGXyrVgfA18rwIu1
   KpXsLFASlRvZzcrRtjS3Jt6Hkcon3GF5IAZnrIsxHe9IL6fhoZJnvL69/
   nl5SvTLgAAonB9bQJ/ixeam9Or1Whskek8BGmQW8Evo8FaTMQbfE0jBNk
   XCur4OJCqCIg7rLKNHH08jk3GwwuRZkjAny+8TSFQFS72D820ewCa84CB
   ScWW/KRnXJhfdXNJaa4MawkVONctf4KkngiLVFVVUszfwuPKEzVU2Rgba
   YF9vIm0+vWGehpkilrDe4VVSm5Uvgk3r/n7Um8arzqHs63Mf5E1JvcHdL
   A==;
IronPort-SDR: Tx3jjGXNQ4hmlkNvf+kKNjPkziaGxfKonO3VhalQQpEj1touO0T7HV4kOC+UwYlHMGhoQWvK6b
 +G3kpHpDvMEhjebDWUtHps03ZHJ8AN9oMEQxb7EpIPfMc0r5+SuUJV+YDkoa2dx0GuHoA1bDqX
 Y4+hfmme3Bcox2keusCkDSyq1nOs8VmXLeT/jh678bnHfomujVicUvXtXjEeknr+Uql6UObPLV
 lCTuxjmIKGUxyqi2hu2DnuOFYJfNIMC08k4Uq6xX3mu036V9IdIMvYL4SnjXHh6RdKbcq9G3u9
 QcA=
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574092800"; 
   d="scan'208";a="233479560"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2020 09:55:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW8zEaRkjKH/8pCXMJPMXFv4F+96Rqd1iFDL+UDvixn3mX1Y6CezxFceW4l/7Gh8GUyzZBhsR7tPvf7vrkT70KG1gt7n0+0AikK/ZcAZBeRu6UkzwvMsXwh3SSXFSCI8tk6S/ybuCsYIxH/hoYWjHwSGtBBAJkrl9rzbYPjfgUJaCCQtd6VEA6vnjAM40+L0DmTTVMfTnesDPZnxtAFT+Gvd+57qdPBu0p5yuI2jVcifZWybxibJzmCzND++9XfFcH19Yv4UIU8Qv8+3V9OcImbkSkcnJo4Z1ToyCPsHoR/U7e1vd85P/wH91ZZGlQiFBeZkOyF7ueGUmnzGJOJsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnlRr+MFcMrIcaL2v1345SWBHDUZzZ9xSEQ40ZT0Nr8=;
 b=h01vJJIuAP4xpOWQ8TM9you+u/aDeAQE99AP8g6UM5J/+Qpvrbo0/dtsTKoPExB1Y72gcvwkAdR4aWaZb4/wdwnvyvoZMh9l3kr/pcsnV/Yfm90svkzzI+GaWZcsyQ3wPjuFVISnqhiqTzSqPjgKTw+KZ0FDnMftg0tn/mLyHMQfJy2bcPgdTg9s5hqcTeog2w+y2XTZY/Ah9Yls/Gch8o1mkPpTsqMPiwER/1MkzqnLULGAm/01miv6P4FTr6Q5+lmeetYGQhIPsjvNPFd/7EKgVJxFM4Dr06XRO7GB0ZHfDS/VejMCHX0iHOjIC3P5MhC24tiVUoInfOBRLxc6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnlRr+MFcMrIcaL2v1345SWBHDUZzZ9xSEQ40ZT0Nr8=;
 b=AXjcDR3JvvZPkAacenrQNKbrfYtf4v7j3n3Jt5bTZddpUPasQbUWGmMJV/lrJuKOnUTKGb/9huItsZt53ragE057vadIvmI0DzBOkPxalKS8icS1G7TTjwgyw81yK5cTsL2Zug6ks9aZf+21CCNnNqwDaDU3wbONFlnbntqdq8k=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4456.namprd04.prod.outlook.com (2603:10b6:a03:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 01:55:34 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 01:55:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests V2 2/3] nvme: test target cntlid min cntlid max
Thread-Topic: [PATCH blktests V2 2/3] nvme: test target cntlid min cntlid max
Thread-Index: AQHV46CnUYWA/RKS506wmXbMEL7y+g==
Date:   Thu, 5 Mar 2020 01:55:34 +0000
Message-ID: <BYAPR04MB5749175ACC439858A47FB6F686E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
 <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
 <20200305013010.GA293405@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2817a18d-2356-4aed-d93d-08d7c0a84b57
x-ms-traffictypediagnostic: BYAPR04MB4456:
x-microsoft-antispam-prvs: <BYAPR04MB44562AAA24865D10FCB08C1886E20@BYAPR04MB4456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(9686003)(86362001)(64756008)(55016002)(81166006)(8936002)(478600001)(316002)(4326008)(66556008)(6916009)(5660300002)(33656002)(71200400001)(54906003)(8676002)(81156014)(66476007)(66446008)(26005)(7696005)(66946007)(2906002)(186003)(6506007)(76116006)(53546011)(52536014)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4456;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LH/c/TTrU5Y+A/HWfp3JQkLK358DPye5VMOWYOaJxjnYkOOoQR7f6SUe0QR6xwk0jL37N2wXrYpLnouGEqXl2st0lad+Nym4bkIjy4ToGSLas4eg0XX75JMFvDUSoMhNTTxNcYk+GL2YstLkLarqhOKC0ASLKZDjrDoA9qKHLip56fk/9bcTGQqaVEHXw+Y1LT/dpcPrvpKYsKNrYPzA4Hw84ml7F7r2/n8SPKhOuSt/bMqlPEtdAqknBRsBaKYBbZcT9dwSs98y7mbKVMUQ8LSL2UPtcvuXFjxQfCLb5paqB/rPK8fhcEHckJf2ydEniZUefQfLsRRBU2DVIJ/fIGpezQaVjOTThniaRf4iuRpqFtzV9VMFYQnJZAOFquUtyiFlh85BK+r0v9YGhilQQzrPQaqaTLeeoheB8GvsuxnoI29xYlOST16loiLoRGoDidyLK97FHQMJCqynOOm96q376U3CIt1NaRHqDfSPTIAOIgjHKtRuiKOgSKrZJrpSMHGa857rYBYnZ2kUDSE3nJjF7qNQQlKBwbUjsnELnqsRDUpase1JqhOai8iMttK0GJ7/PNMdb2MFKhGaGkZXVw==
x-ms-exchange-antispam-messagedata: wwzkYWikQPRwmvPm4lXO2XcDZ5bJIgKr8kjtmtFM3pH+0z0hBbJRDdyMgWwIkJL0Io5EDtVhRiLyKPyn9MQJHZJXRfj8YkXFTEBv3fJ6tqfxXhN5zPYTlvNAojyX7sX6GXfyIG0nNmR4vRckmLPAcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2817a18d-2356-4aed-d93d-08d7c0a84b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 01:55:34.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIqoeiPsVHUQr/E4CoNqHq8RxTl9+OrdPaQuGIScKbuRq3K8uksCAD0EyLbbpK359ZJ2/N1WpsOR8L5dawCXjDcAHZ2pwDdIom72K1won5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4456
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/04/2020 05:30 PM, Omar Sandoval wrote:=0A=
>> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \=0A=
>> >+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}=0A=
>> >+}=0A=
> Sorry, I wasn't ignoring these patches, they just made me realize that=0A=
> we really do need a way to skip a test from the test function itself, so=
=0A=
> I wanted to implement that first. Could you try rebasing on my skip-test=
=0A=
> branch (https://github.com/osandov/blktests/tree/skip-test) and=0A=
> reworking this so you don't have to split the setup between requires()=0A=
> and test()?=0A=
>=0A=
=0A=
Sure, thanks for adding this, will send an updated series.=0A=
=0A=
>> >=0A=
=0A=
