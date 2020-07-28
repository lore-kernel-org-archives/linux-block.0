Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65EC433E4
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B3220775
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XotiSCIr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WJmvyeHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgG1KsB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:48:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23493 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgG1KsA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595933297; x=1627469297;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XotiSCIrkwAZguusPDR8FwRfgxN0uTRSWWFZx+BFJ+04/hqe8u80yPH6
   dwrSpNjpSEV03+Lhdx7AZ8TtchruXU+uHv4ru2jvxXnIHcXx4C+CVx4NW
   xSEnTxNt+AfvCNeJSaKiAO1+G7i5RKekejmKKvcWu4i+TnYO/PicYoZzO
   x22iUgfT4IAX91Tcf16P7jXibqnc6l9yZKR03O0lNggGAL6JqYzrWSv14
   T6Za/FhbEOzE28InSIGBzdEYY1sJsT8xv+x03N2Ui6gZZWI9zi7K6IFip
   3gYLgPa/0CZWXiG4sRdBh+mfuuulxW5md/yFJF6xMAVxfsNdHP56olIkk
   w==;
IronPort-SDR: BuKEqj7l0jyDkr4SRRSg+Ze5DHK86m2VXGl0PNirW5CFToT2AovTa+0EhM/G5fg6UIiwMT/p8W
 l/4IrHI5d67OViY94s72Usarh0oLa6nNL7aPrkBxxCU1mBZCalReGrfY4bT5wNAfDFYetYJj75
 sujGO/fGHirsPGv3yuzr0sGJAmbzMI6RVJtcFPS/uM5iM/p/d9kBL2mcIX6XOZ/o8b5FnGfkLx
 8hGl0wLQxcm07iX/BBXYjOW2LUDj+Vyvs+/6YH2pKpV6QIWa6BWxiD/iKjQ7co3i4lYiVbAFlu
 9fM=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="246635993"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:48:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQI5GoKnLuAuptl6KbqwkGfM9HysW+ZFSygMlCNSUMvVN1NfTcltJfmjIrqufhGeog9FEllibvPnzRj4XZrh4FgyU5g0J8Yung8Lp805dbm3KaaPhCY8z5GNbLrpr7VBw5GaDaIbHeC7KNqsNFPlbNdS+XNI3FU/fcVEPqCDoD5QHGbjiH/4BMf5GKQY+7j5G5a/TtXo2O6+S0Xym79ovXgcwn8pd44myT2kRWXEJQMZ2tXv/vYggo/0DNqz/GOF7uHfr8z4u1btx+BTBeqsmNWTuNzQj463CIkswQ95oBZqMEqfRz+VYGdEymnGrno8g0tZl4C2eQtgImFrPse7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IVoIn+I6NReGseObVsO7fJ81L/zTHnuSu9JHSI0JFBsTt4MI0A1Kftgm3H7vHt4Y9b62uABrIdwUU/0RrMuTzJtKoY8EXLLFZ/Ox1c4BOXtPCqTz35qVNsPlIVkLQtowInIdb3PsLLKZGCKt1Scr1IpH8BJHcHlHAWAirDRJSVTe+sKzq7ksO9+LgMNkH8AhDpN8MjcgLtfcIG0JTe3vDX/hwY6D8Jg43Ie0W1MzzH9tDT0XSPG/EGqIhAr/PPH1evsEuDzKUoXEGTzqGEYDs1bDqSUw5CCR4sOr+ndFqqqh+HuytfdkfWeqJcW7BB0LhAgQczwojKYrPaS0V6MIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WJmvyeHIVvdfOxTJaW6ddFZlxvnxv44eZnuRPjvefRhoMV+ndT9JKg5T4hVys6EH543r9/ipnkxZjuBgSk6lfUGZT582pxp+T6ChZdBLrBuuf35sGkBnmj1MyX30PNk8CXtIVh5eYJLfZL4l0yWBJlN4OvzzE1EoMQ4VJjNePqQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5325.namprd04.prod.outlook.com
 (2603:10b6:805:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:47:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:47:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 5/5] zbd/002: Check write pointers only when
 zones have valid conditions
Thread-Topic: [PATCH blktests 5/5] zbd/002: Check write pointers only when
 zones have valid conditions
Thread-Index: AQHWZMf17UVT7q57t0iSIIFZ3m5t2g==
Date:   Tue, 28 Jul 2020 10:47:57 +0000
Message-ID: <SN4PR0401MB3598CE23394BE16ED685A4B49B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-6-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe5881d5-e027-49f9-5811-08d832e3b0bf
x-ms-traffictypediagnostic: SN6PR04MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB532564A97200E7F58C655BB19B730@SN6PR04MB5325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9donBzIqyC2Ifdgu7n7EftKc8ehdxXSqK9CEOGJVO/osGIrQA8z3bzaj8K9faFAFBqkir4ffapDignUzkqCcxZToP0BEwoY2oCXuYDR5b4nCOa6wDTItNdhshj1sj5ENbNwAfPE/b0tNPBE3QMPzIuAAwihX8gwLIj5H0k3ufCI/U8f9/k7OTrKsOes+vjVmLJivI3rq5+AbYvunQiBZ5vsr29qUP7v5u0PVfBLqU0tJWded6PgbJNwkiIS4jQV4vI/9gWEs+ror5KWVhqmIhlQAL4ZyOF8Kro9hsF3RV/GYKoc8RcohdNKTnt2BBDpKt4V2+DnSZjmXJaRx2z5TpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(86362001)(54906003)(110136005)(316002)(4270600006)(33656002)(558084003)(4326008)(71200400001)(5660300002)(19618925003)(26005)(66946007)(66476007)(66556008)(64756008)(52536014)(8936002)(9686003)(7696005)(55016002)(8676002)(478600001)(186003)(76116006)(2906002)(91956017)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AzLnjjaXo8l6f/zo/L5UTJj6fUozxX/jL1YiKxQLDqm8MbpDWjixQVIE3A96ooOfQ079MEIB1Af0+MDS8Z2dc/EF3hfmhN11p6C2RHwdp7DFHLtcDj9ZydS4EXNfttFmF51P+K3F0yPXz66AZX58pwLFCJci7WndGO6vA7NHS0CzZ0SuYFiTQTbQljG85HHnwXctTBd1uUkvy59uoSkC2YYzp8fDYo35ISKXlahxr+2Ez7TRPmH3Ge1BTmhtu+evR6BkSuUcJlpgeMbYYfjXpsjUO7Ajqp6w+17rwbL2WoeI5HQOlMHfqrmZGkpaEKmNOFt2jDQeWw2QT+y5wwg/tkPuCOul/p1U6aQmvKuUa3JWDVmj32VDNPToj5qx9uAABVEAXZWz8k/pkTqvzztyqfHkIJXJJAiLT+bx2z64KwhgikVdvMYP6DvPyo5D+nLZ8MsUbUNlRtsJTf6adqAIlRAbUsBB+fxxDGKxEOidipvehBYQxXXpXtNlzlKC2G5e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5881d5-e027-49f9-5811-08d832e3b0bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 10:47:57.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XX04gw70n3SbeQ2YvcKIYtCZSAblOZHkg3QWJbxpAkT5j4QF0ZSi95bQKrlyTjCW+K/mJmmYxUF5t9C67MU9n9OiqVMJ0t7RcKi3Fr3x+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5325
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
