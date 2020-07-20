Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59745C433E2
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E7A2080D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NO7r3MHi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="krLkY5Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTIN2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:13:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26567 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGTIN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 04:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595232829; x=1626768829;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=50VKRs6PP3DMV5tGSXe9WhwMva6wOsXu1yjTKjdUYhc=;
  b=NO7r3MHiCY2HwCs6KJoVIltu5gEHkE/aHSmnmugrJPTmB2sbplnDC6NP
   igwKjiUkSSfbuCmiwHA8MMFULHy7vkX7OUx8WDaMPX2kK0f4Y62DCDoN+
   hkE+Diyj3QAAK+1IbkAipEq0LJxR9I4HDmQdP5XykGztnIKcYr4BJh2HQ
   XzsH/ucfO8WbnVJppicSxQigDqHiIgvA8tsKju9sCbAI9DQFYCXZtB723
   Dm+FCgkkue03M3nZ9GgP9THp/6D+Qhj7Awl2sOnMOPia+m7qyAhymZ+lH
   egiVGXL3BOAKbKlqKU9ufkbdBkphMMCCV9OOa2VuGMGoAE89O0zddb+nx
   g==;
IronPort-SDR: mbD0LHmvs3e9DYdeaCisNne+U2VKE1sXx0DnRQXK1QxeYjAQBJ1tX+WcoaxwTztGnbnAhjjN8q
 D5TAn/rAfyrqVpVgp9P81EYoJs1Y6WiP2U0j6DoVDIHARi0p6+T91QvHp2BbBw6fdPUshQiHqr
 NBOF9xmI6G4dBu21MNFVQXyXlO/N/khvwEON3Qb7YPgnUvJIbiziC9chomMpSpsNb/e0VoDV12
 D/+v28pe8iwPKYbRPvk4NyHEfrvUzxreCXwMwshb7VDA2NEDB0rg6lCO8rnHMpCTWBAcd8AWq6
 7i8=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="245934841"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:13:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv/nJaajFHa8GfkewMVHfcIeimfNfvwN3bSQqC3MrG8pTEdjXwT4I5zKfEkYlKC8URlYAa5XwIcNcPlf9Ru0fX/pGNSFbGq0USrumJLEqYPyC3X2Nv1kKQYd6vFojO1Ota99nj2Lce4A85njDCWKVK7i02VU02xWtrbrpA5uwmlNFpfg39Z7mwXHL788F2h0eq+q5X/hiRJqLIYjvAk+Q//rDPdCPtZxh0O5nHmsFPTvL8D3fgJANv5gLZMksnW3xSFfJr3ByfN0KI+xqxBriuxqqiSaiKXIBA3FyKyjhUKKcxh1lTymZVSRcY6CoD3mLtnu1hjzBv3q2J6cupTpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50VKRs6PP3DMV5tGSXe9WhwMva6wOsXu1yjTKjdUYhc=;
 b=IIk7jmrZsJFBfggD5scTYuW1k0L0neO+3t5NePtxay9dkNyh7Lq52SXrYo3I0uudV3cVh45fXNHMzfI3uS1T7qSY99U3ewFTJJ1gwrdgy96vPxlQT8Ha8Jh1EEmlKymTfsk42Qs/7e4ytxnwwgx0FfPaspHzfguhKdXlUjAHHALn0XTwnxotQ9Wp4FOOVGlh4ZUflv9X9PmcuwzYGWE31yNJGhsTyV3o3h8iig2NWTe6Ta7Xu4pe5tR1h1N48cJLezjSEpTtwLSfpeiE4Eddn/0cBaVIgcvuUTdhLRd8CoiesR8uvWqfg4Ecd8Wa0Xkb2A81WeI34xRv/Dfcfmp3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50VKRs6PP3DMV5tGSXe9WhwMva6wOsXu1yjTKjdUYhc=;
 b=krLkY5EpxuslbOqAen3eIJV3cSp2L0nbLQ8HlhL5mABgB2kBRnVAQr7w616SDqYEV/x1Wp6gK383Jx0PMN1ucgHagX/W7in7SQn6xUkqRziSD0DYHcQW8PqFynFM9wdJvJ7hSRuaCnrcpIDpjr/4PhJfqlljeJNdyJSGJhH8XCg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2220.namprd04.prod.outlook.com (2a01:111:e400:c60e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:13:25 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:13:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: a fix and two cleanups around blk_stack_limits
Thread-Topic: a fix and two cleanups around blk_stack_limits
Thread-Index: AQHWXlzSo6SIEk/VxUe714FCmwMHuQ==
Date:   Mon, 20 Jul 2020 08:13:25 +0000
Message-ID: <CY4PR04MB3751242EF7AE2172A719F201E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4023288c-0cfe-47a3-828a-08d82c84c6e3
x-ms-traffictypediagnostic: CY1PR04MB2220:
x-microsoft-antispam-prvs: <CY1PR04MB22200F1BBCF50B9BBD4258EDE77B0@CY1PR04MB2220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGVSv1pcDhicHPCFelzhY2O9cC3rLmsUFaVe3yL8PDMtAu8FfJ3V2dSNCrx4KEPfdpZGv/d3Iso5RDd1ToXz+5I4eoXs1mCtnXR3hzeSyAHFPxqBpFPrW0wxKM0dCSq3Py0rqR/r68EjxG53wscaYt1I56xLXLbTIdU/Q8IMZKQf1jtsmxbHd5aM4J6rEoayniG/D82FbWSQzct54d6dsAiOdQY1/iahUSdoSqp1g5yJI14be2gPePj/yjFbZznA+1s7c351kTZGhtxtAgRv6q1yH9VmK5kH6Chi7qk4svm6iCQ9PA34Crhi2xJN4n0p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(6506007)(53546011)(186003)(2906002)(316002)(55016002)(66476007)(478600001)(8936002)(9686003)(4326008)(26005)(91956017)(54906003)(76116006)(86362001)(5660300002)(33656002)(110136005)(52536014)(66446008)(64756008)(66556008)(66946007)(4744005)(7696005)(71200400001)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: D2nwjhA4GRlR6LIiZqOQcaV8KisqqjVJPiL+G3Dzvi1sjrynV6+IsXvDkgBSMuR0omLVYWsM32GCKCthS6E+9zBTiE1PMNHNQsSFI3f+qQ43sjeI/d1XHR3r5nGrwZ19Y1I8kPsSvV51/ZePp61i20oxWD52jX2+vJ/D4ghsyBbMuczBjnkVpc7zsRcg9V8IY8DidGFAJk3W32WjniqK5vDOY9wpR6CT7d8T2GomO21vdDcxiHOmImFDSb31WRuI6RHmkA1i87P7HVBfa+Cyla18OvvjfevBhy2+2ICxjiefdijx3+eBmqD8DXD+Gmd3rQxWEyYJlzF8Q5oP1rhG5mIuDDk+z++dejI8iAmBZlsafZo0o4U1mu0qXCmyaYwabB9/OhSMAhlt5BSIivs/BIqCqsHjQIANjwl8L2OXA1+sUUJPrXGpUKdO1cx6RMQyVvVaK4u6E4ijPQmLG1M5eYffts2xA2751PvhPYsbvCQKTcpuP5XXWV4ifO69d3GQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4023288c-0cfe-47a3-828a-08d82c84c6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:13:25.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMDc+0yXC417TPpfT/J8n5RNHwOocazEESzip8O/VUPaCqEi3wqmCtYd2Y3Xa1kRH6nOBGNimWFQiAkosUPRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 15:13, Christoph Hellwig wrote:=0A=
> Hi Jens,=0A=
> =0A=
> this series ensures that the zoned device limitations are properly=0A=
> inherited in blk_stack_limits, and then cleanups up two rather=0A=
> pointless wrappers around it.=0A=
> =0A=
=0A=
Tested with dm-linear, dm-crypt and dm-zoned multi device setup (from dm-5.=
9=0A=
tree). No problems detected.=0A=
=0A=
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
