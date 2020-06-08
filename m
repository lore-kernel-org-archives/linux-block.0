Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061EAC433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D308C204EF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zejj2rmx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QuJ9+QTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgFHGeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:34:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1915 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHGeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 02:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591598048; x=1623134048;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/clTLzXOcrFjkYSorSkbQ3EPDQ+WGK7muVJ7bYjFk0M=;
  b=Zejj2rmxFMZk2FGgXKjQRWHrG/UFJ1GKREcrHCgVz0yJ1L+jyRxi5rrJ
   z1vslrgCEMDThS0yOjD0y+bWXVlPko6ZphtK9ICw0APBSlyeOafAlMIHA
   0JqnVMuDf+7oJxqMj4ATrZz62UaWUsZEnfJwVFuYxDaMgiaUcAm96sNiy
   5C5CuIqIvVH3RpsguzVFuVk2MmVzhGfyqckuHaUSinDh2f16q5HFUb7i1
   oxV2UZvykGs2GHy0o+TlfnCmv025NVGe+W06o/TZnrQXjFlB3XsPX/HUK
   E7H89JdY5At+mS+K29tHC1e3dmoc66qFAdhCQdHkmSpxby6v+boUfPTqa
   g==;
IronPort-SDR: eKvFKekwKgUCHLtVNcse+BOg3HfEifhv5g/lKHG5Ir+Z1kYZ5kJEn/mm040ATsBpXkS0OZ0Qb6
 p830KXlUQIOQPslqIdtTZBxFZQYqXCXdVeUcoKw5lL8+vLH5rxO1LKOy/hxPKnQGgDe8zm7LLv
 tvofKWq5S2VIE7bXAYC84Y5fuRh0fAkm+pyRMpNetsZHhcpyrQ4flUWMhAZ/U8XtD5dyEBgm9O
 06tLURhMqA+F/aVcVtHWcZdbxKOZvzpDZwhj47yqdtKL4HEgkCEPQa6EAFHwkoSHdCLLl+iEnZ
 RY0=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; 
   d="scan'208";a="139421420"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 14:34:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAia5s4tW02Ppdf4oKLpoZv7e2nZFPlDDTU2x3zjkiUW4jSi3jtPZn2nBIyiwlBMhtXEaCPzNuknrmWyeeBS7NWPxNoWkPlwgcWiySOTFNx3WZrH5Cfkfx7TWyg0G+DnEDIC29DKJvigF7QFTvHsQOQPVNnyx250n3F4zcyo2U1VECRCZoczUQhiMsZDhS4Gqgvfh+yk4YbVNHjuPItmjGrOz5+VbgOPj5FvE6rsZ2cqd6cLj/8g6Xx7mxHKqvqNy2Njl3rXI6uGzlS133orwQZVjvFiZJ9/Pb/1fpokye7lf7Axq3DG0tR/6DNEJMkFXXRGbPwgvjuTdo8iM84Q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7ircQ+9nbyFqGjzeCDSuIwK3GrX/eBa3dp0bAKebP0=;
 b=LC8laJUHmay6FNIlTJmj7Lh/DcwnxVL0WkCB6R340gDLaNWMPH2MV3Htp7eBb8UAZZoENQpzlEhqUGkWiCshTbxMldY/at/idcJFRaW93PCWFNsuNk3QVkhYeBEmBfn4L8Kqew7hOWH0xZwErGbZ0btGefKZskz3EABrc4nv4gtdIMrsAG51g8I9JP3PdCcjPdyX0iU+OWPAtRV5TmUG8xHKCIyRtvTUWmGwsmsEK0bsdI9dT7kH508yxE944Q21ZunaNEYSwn3yO0mpraXtopEZEtTnzYjXaxe50YAHqDybsKmDU00HRq/68zPrIchL8DaYf+bsBNBSzT8nlFpAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7ircQ+9nbyFqGjzeCDSuIwK3GrX/eBa3dp0bAKebP0=;
 b=QuJ9+QTL+Tco9/y2sW7GZe3k1p0outQYOSYy8i6HSyaG/hOoUWhGsdiEuuq0yzjqqr361EjLT8M8XgEc8WTz9C1shz5G3Meae4EAv3ArGU0HrvA4L9zMMpmGvp1pmabj9dfXRV4dXfd5zR2Fosn9RYZbVg9ivh4WUQv8BOhIr3s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4614.namprd04.prod.outlook.com (2603:10b6:a03:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 06:34:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:34:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Thread-Topic: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWOjNJLSEx3mlm6Eunc+X8pDtzsQ==
Date:   Mon, 8 Jun 2020 06:34:06 +0000
Message-ID: <BYAPR04MB4965B37AC6B19F51AAE291D186850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 785a43ee-04db-4076-b749-08d80b75f1c9
x-ms-traffictypediagnostic: BYAPR04MB4614:
x-microsoft-antispam-prvs: <BYAPR04MB4614E2E46885B233BBD7908F86850@BYAPR04MB4614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YlEP4vhaYUYTW/teQhpOoKD7gMLOF52Dh1o/jkX731RtAmsfk6eMng/w28RA8OpJi9nnve6RTQ2GBDpY2LV1flE4prdBfSSPQ9ovqcxdI51fsBVFq2+ZHiXcPAfcR8OqaS+LefYaG62KOfs7Xy6c5rEtlLNaZoPGxGVBbezXMhYx4Seo4KZZD7JdmW34khVJeTiZjumYlYyuph10PGzLKZeGfszrXqUQEDeBqDcl0LioAuADZpPdkVIiaVD18PE+euY4f7OHaJSL5o+LMzaq50CKa6CEPjo5M2esNnM4/JotXhaPBcTf6DNu10bVJZZO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(2906002)(26005)(316002)(9686003)(33656002)(7696005)(53546011)(186003)(6506007)(55016002)(83380400001)(110136005)(71200400001)(4744005)(66556008)(64756008)(66446008)(8936002)(8676002)(478600001)(5660300002)(86362001)(66946007)(66476007)(52536014)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NwJK/G517HxZlvoWlXh5HRiddghUbUAmpltiM9vU1sGVBhaSlmRKDAZN/m1sa2gg8GB5UQi4ZHTI8e4+/ePNe5CgPgtuOSoZkg5cUq2lf510gJI+rIgj2t4G2P8HBSvIkMXMPzfZQBQ7MIHf20ILhqikH6WXha3Wgnw5azfIY+JlnpRkGMro5Sv4EmIhUETPnuUBYgLShv9aBnehJiDTOfD8BbZm2IuQq4mvtyTg3LSEzFUo7w4DrKRtpTD5ytBp3S9O1DxFbW+j9IsUNLC6G1pQKWcnmfIaP8yPIh7CjJr/ZqWwSCVRECoAhogJK/L5hFAwLBMsi1UcHAQhna3Ky9Cf6ERnhw9iwI7tjmqWo1nf/wkWcvISDcj5vyDjvZV7yeSc2qc3PjoYQI57qcgJ3DuwVxWsUDNgoawKhHDVOaAl20XmjIicewOgAI+pzx8TnGbhAk5P0t7tUIcR6po86yI/MVyhbyZjIEaqy9veLWQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785a43ee-04db-4076-b749-08d80b75f1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:34:06.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kt2XILNqFYaOK7BGwnWiGnMhyPoP+/132HIzqpdFwq28akHhHZ7Gl3/OJyZDurykmreKw+WxHowDiquzowk85vA09lyQIPu2PpJDgRbRqWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4614
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart,=0A=
=0A=
On 6/4/20 9:31 PM, Bart Van Assche wrote:=0A=
> Where is the code that imposes these limits? I haven't found it. Did I=0A=
> perhaps overlook something?It is in blktrace.c user-space tool.=0A=
=0A=
   55=0A=
   56 /*=0A=
   57  * You may want to increase this even more, if you are logging at =0A=
a high=0A=
   58  * rate and see skipped/missed events=0A=
   59  */=0A=
   60 #define BUF_SIZE                (512 * 1024)=0A=
   61 #define BUF_NR                  (4)=0A=
   62=0A=
   63 #define FILE_VBUF_SIZE          (128 * 1024)=0A=
   64=0A=
   65 #define DEBUGFS_TYPE            (0x64626720)=0A=
   66 #define TRACE_NET_PORT          (8462)=0A=
   67=0A=
=0A=
