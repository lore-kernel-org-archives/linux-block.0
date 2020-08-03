Return-Path: <SRS0=nSht=BN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F09C433E0
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 07:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F181206D7
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 07:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iNMllmNJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PJJ6zOzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgHCHN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:13:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26665 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHCHN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Aug 2020 03:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596438806; x=1627974806;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=iNMllmNJ/yF3B6Ig6JXL5MUuweL0UGshMUcqIS97UskvIY7rUlxX6k6I
   /pQiiGtE7JvnWf7DqUOL6zaXqxTkIGbBiM4EOIWkFn467aFRmjuEHXxki
   MlgYFfWBgZZ411R6aCnLXVQa+Zw59I7ZtLOMJrzyx5PuJlNqSJkWzxdwX
   Dwgrz1fBjaOCsnhkjv9kPsQ5Tr9jLUJICLLPlhB7XT/Cvui9wUt8M4gRe
   JMQgYTTZwwHOpbWEE0BW8xBVzhGS2HdTaETq4zahl8chOfemGFbWDVAd6
   PNcBbnAK8Lf0l7E63+F8wGZ2Uu9kMR8+5I9vuxuaTzj2up5slr3+QGvwV
   Q==;
IronPort-SDR: dhroqEuyp5MZ+buzoIsSq1fgannncsFKvbRDO/IN7HOJqm7sn57Somq1qSsiBUfRGt4ivf+aFG
 jNlDOwi6vbY52MeY5itIfFkrqxrxZOwWTMuK26FLczivSSLxgxaPdqbUAwF2EwOVf33SblSFyh
 v6IJcojQMpCC8QjsLdsa9Q9sY3qB5J0KofXkkLCUKeDCcFa9hWHaYINVOCjQISwuLmfHUXaLg5
 IO1fAsmp4wzwkkbnFpGMnFgvjpXNtWzNWFzhYTSrVcL3HvdHV+QS0JZCrYTzs/f99WH+3zjqrd
 Uo8=
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; 
   d="scan'208";a="144068119"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2020 15:13:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbTPAjHmz/lar2H8kFKcnMYlQ6E2TvVqWVUh7kPoZLivkEeV2GqiMoS6ftqtSdacAulFMBefvyoJZCGB5q1djf7AlszIK5cmBqHRgE5SgMQCziVrF569e0FAXgbKl/hFEhtW7S9CfzUx+SA/oZK+fTEIiyhA7i1AtIHFncY8NWfSBoIZuCh56WgjzhnDZmhXsIfA5qDN6ClLyVtKSHgPbl3MsHuddyp/wBACC1FFg8Ir6vtnVGIRZ7hghkWLqtlX+lDWp9y/oNDZAMCmRpMrqvZmFgWIRo0Ln6rSxNDa7XmvcKWYKr3GFBeGQLyGUyiXa6MovdcLXicWzVJtCtrvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=l69MFOidKCl6bNPh2fkBeMP8yPvBQq5kj46flfbYhGbF8bV6c58aclGaIGHRIT45G609RyIsFXOrsfe05zeMj0yk4ON2qM2mWKLf5gMuoFepc4H6/WZYaJOHY1JDOpyHTpQqOlgUwCDmDl9VtS5J80IouRV4w7uE2H23dwLs8YonW60wqmdrH8hiyQJMucTZz6k6m/qfCwFQ/EGPuv4MlGiA4NSA6Qho4orwkfLbH+rcSddR2uJPdu6M6zWdOnSjgRI2s9tvofGGGkY1V91dufw7q++rQCdyuxfqUr23mmQHmtTWQe+qQYwpJGqQHxahehKh6iP/TXhgklY334R0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PJJ6zOzDRa43XwiN2ISqDSoJdnm5L8trFR8nYoRV1U2KIn1dhzcBAxVp/PEZJMv1P0zYEblgPnhGltibxnioGs88J8x3hl7mYisV9Th1K3hrI9KyjsyhV5Ok0OoLf0+ZFXC8PhrXax7oAleIrbXhCVvmCUobeiXamQENWq7leTc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 07:13:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:13:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH rfc 1/6] nvme: consolidate nvme requirements based on
 transport type
Thread-Topic: [PATCH rfc 1/6] nvme: consolidate nvme requirements based on
 transport type
Thread-Index: AQHWaWIq1FotgVHbLkmZ3HP5gW1Dhg==
Date:   Mon, 3 Aug 2020 07:13:22 +0000
Message-ID: <SN4PR0401MB35985B07784F73DD9C27BC879B4D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b87b110b-086c-4c88-7dbc-08d8377cb558
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4464AB0B4B46114C5B7B7DFA9B4D0@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NA9fIq8pFKfrNRlFo3RX6WgMdJNH6z/r3+TySF3Nizw+PcS3PX7J0vgkdpIodKY1TB1rzo0wnaQBpDf1wHdI3obbsVA7tZi5sV0jZRujxD72jpColHZW7PNTTI7R0DTqOws/YhidufENs6ys7z9pw4TBRH7jYcxo1lMWq/z0XgdK2BvNT9T+7Q+z9Pz/l7bwWXxIqNNUa9PbJLzbPPmT82svQjxa4JEixIA5mhRpIrJKPaTLQTmeja9mJgTZ7AVP7nL4PMI3jQF2/+ZKBT085Y4xetsrJ9lBSzyvYuHdkud4fdYP83OSKc3USXo+6jFoJ579hbL0U92qB156GCsD+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66476007)(66556008)(66446008)(558084003)(64756008)(55016002)(8936002)(186003)(9686003)(76116006)(66946007)(6506007)(7696005)(71200400001)(4270600006)(33656002)(26005)(316002)(91956017)(2906002)(478600001)(8676002)(52536014)(86362001)(19618925003)(110136005)(6636002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3Jeij2Cg1z65Ct9Ju3vTPtSa9ez7PyBvuc5gEJCpkJmrerQPwRadupmzKRH3ZoPVAqnYOMTOTNoX2uY7Gq+/kJlz29C9k69v3e33Q/S0h3txFXO3JWRXovBuvRRMpl2bhIFZZkJX1XMRmelK5Ncey0SjUxoVaaBWI62gJelm6okk90PC+e20R3MQehFHFXa8slODAj0Ur8xPQCRYgF9z21eH3HsckTahGCBu7LDIgSmulv2S/peajX5i7Fkw4X8E6MkYgMqmfPmpOTIU/wvWGbaF/H2EJV6kJ8LbKwQMfTlpcvra9ddUDtqsEHxNzrbZ62BX+RRrr+LOoGQpAaFKlng2riqYhACNPKe2rtzlnLHggnNbMwMztXTwuOcltTfenkXLfDt1sI8XTdVfwBUqvBEFY4oNpNIVvyuC3q3nrnRo+s/c8eNxZDElOgOq5Z1ce9AhS6cl84JMEJoGSRIgA05dXZH6ak/KE7cqIicOJnsEbAUkmAH9yf4SzIrE3boGLc4G5C9hjZGkYyUhgqWh3UcNjc1ouSXmnKwj6NqnH9GrxTJql1vCuRzk8mi8Wi/miPbC0iZJUsA+yjog4G4yoRPQzt+DWq25wzIbDy/QOb7cgjrhdOFx0cNjjtGec/pr34htHCTH+tSvIwY+3Qv1nQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87b110b-086c-4c88-7dbc-08d8377cb558
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 07:13:23.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noTEhBAdKx5zNqPRiaACYKRTuvIXWa8emEOkqRkDDFStG51sKnVmVJCBqdT0s1Xv3jB5wNvfCC7HAsRdLi+gYtVXC+gLmq8AiejQrCqKPvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
