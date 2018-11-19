Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC6BC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C2A2089F
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oAkvktKY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m3nowW+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C2A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeKSWz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:55:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13917 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbeKSWz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 17:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542630717; x=1574166717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8PZaIcAIGt+UwbyI1Bm6F/RppXSsdwArC8P33C0GE2w=;
  b=oAkvktKYO/3pYvdxRnTZvnzKGbPICm+ob0QMZxLZYH1+13dK/v+zCpRi
   FBDaUrlUFDRCLm4Wl0o9PxqPQORk7lbFAFDvW09sao+rlgvCDjLL1bUpd
   ir8iEKEWImFX32qsaqayYGhZfRhlxdE1NTGO1tdcO/neShnvWEBx7vvH2
   SVgwkY6+4jjUHafZQ4ou3DoUgNT0CEZp8hp6dbrOtfdz/pkz6ECdnPYcw
   WHraLiwGvQARQyJ5hd92x+311fkQv6pFpX/8WVfJWCFwUrAzLqQFhBV1q
   tyJV3510NMQ3Lb55bbNWZvbFRrPJ8maq+InFozAUiWpvep4DhNj1OkKGo
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,252,1539619200"; 
   d="scan'208";a="99397587"
Received: from mail-sn1nam04lp0083.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.83])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 20:31:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PZaIcAIGt+UwbyI1Bm6F/RppXSsdwArC8P33C0GE2w=;
 b=m3nowW+yz0q2xB6DkEhaYVKzW/SjW4QCw1eXeCmGiEhxlLDA281l5l7UYZPlHpBYxUhbd8nZ12+Nwttk/IeNOxVPZDooyW/K7Lpe6UWl/PAt79TM0SdGY9YV7/AHyU3K52xLn9RpkCSYQ0TGeCBhYfqSnFJRrkCL3/zcuWgRsWg=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5360.namprd04.prod.outlook.com (20.178.6.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 19 Nov 2018 12:31:54 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::4c22:c9b8:6198:5fd1]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::4c22:c9b8:6198:5fd1%2]) with mapi id 15.20.1339.025; Mon, 19 Nov 2018
 12:31:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ooo@electrozaur.com" <ooo@electrozaur.com>
CC:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/8] bsg-lib: handle bidi requests without block layer
 help
Thread-Topic: [PATCH 6/8] bsg-lib: handle bidi requests without block layer
 help
Thread-Index: AQHUecMU3gflg7GP/kOoqkwq7SwNRaVXE9Hw
Date:   Mon, 19 Nov 2018 12:31:54 +0000
Message-ID: <SN6PR04MB49254C8E18E28233E904A006FCD80@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20181111133211.13926-1-hch@lst.de>
 <20181111133211.13926-7-hch@lst.de>
In-Reply-To: <20181111133211.13926-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB5360;6:iLksDwbPPp22/nsedwl2KgZySlAeLrHq/JPQG4e9QlcGgiiRD+DsMR26YxGyOWbzHmYOq3PED+1WSfB13O0WLzMKO/+lRdt2a5rd172LLXWnON8LG+CEFb35MSnJsy1j9swNcbc7clcuHiewv3ExaX/99F7gSrOEiT8KgD1xf6UUCDJWRYcECBW5p3w13NX6cQu0Ti9RY+9IVKoG7cHTDGM2FdOscU6KZmhrSjGYTwNtYlYMqoySKvEqKs3N81NCYWmC4lULLcL1JtXeLvSU/CiZBH2hz25jGNyNIXjhehV/mjEAaSaUK4xeJqgNbE8wmbZCSNqyBjTYhzXvLId3Y5iIZmHus6G4Bs550uIazxkJG+5xyvxuQ2w90nujLEvoCNXEFI/+NzbH/1nR4ntO3I0IA+enQWp/5AIOcZ6N9AXOep5zdZiXDX5hBvEJk+2p0x1OUp2/GFsJV72n5iHBgA==;5:FLev0fFqWQmBAOdLG7/FtyDSSGHf6SUHYCffQXM/cY+Jz7eo+KGIrqaKwH9QLJYAaXPeUre30dEyYbsRRAyNQPcSfB3Gd75MorlTolCUA5ZWIyhAyp0LWHoY0SiwNSMhG5QQGCbjqsRsMB0KUWzUgUOfSMuwnwJ/P6AkPrBskEc=;7:T6CKqEYo+/+KwFXmlb1Axrdwys41zDbWhtzUxERGHEBCUvshyF0tO+c6NQTOdiMHQOtX4Pwn9uqjD/lO8aln73utJWe0LlIsFF7qMT5cbyPsZiIIvnQVqiFWiT8I8/jQoLg4JZaaDqDhcQhsOio+nA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df472ce9-fea8-4b32-e374-08d64e1afd74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5360;
x-ms-traffictypediagnostic: SN6PR04MB5360:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB536047BDF1DD810161944642FCD80@SN6PR04MB5360.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR04MB5360;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB5360;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39860400002)(396003)(189003)(199004)(13464003)(68736007)(110136005)(81156014)(81166006)(54906003)(6116002)(316002)(71200400001)(71190400001)(6506007)(99286004)(3846002)(186003)(6246003)(55016002)(105586002)(106356001)(74316002)(53936002)(2906002)(8676002)(476003)(7696005)(486006)(6436002)(66066001)(9686003)(8936002)(11346002)(446003)(53546011)(7736002)(5660300001)(76176011)(26005)(102836004)(305945005)(256004)(14444005)(25786009)(478600001)(229853002)(4326008)(2201001)(86362001)(2900100001)(97736004)(72206003)(2501003)(33656002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5360;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rLXV/JrEVSDkB+ay+3pGcCoy80knvRGmuZss5HUze3s0zX9TDaJ1lgBqOkG1lJatnoZs1Q2R1yo0RZdk3kYFdEBOr24Rc0O2KSPzJoFAW7fGMv+T0cOMO81MEzJGMSfBcdJF9lZDEq7paiEwtJSKKX8wCiuwScc5PN94M+p0Zom85QE4xZqrzfCMMutHEIRQLFZsUCf6FKSibP7GBUMHZbuam4leArd3EbFi0XWGxsRNpCxt/T04QUawvScCwzcaioh2ZtXiLdOX5vfJyRJh4jHzVfqLyQODcd5QgqoRbNi+Ou/sftHD67y/tEVo3Udgh97VRZi2MreR5zJVURC0naMC83tN1tUGyE5xd4IohHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df472ce9-fea8-4b32-e374-08d64e1afd74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 12:31:54.6822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5360
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org>
> On Behalf Of Christoph Hellwig
> Sent: Sunday, November 11, 2018 3:32 PM
> To: axboe@kernel.dk; martin.petersen@oracle.com; ooo@electrozaur.com
> Cc: Johannes Thumshirn <jthumshirn@suse.de>; Benjamin Block
> <bblock@linux.vnet.ibm.com>; linux-scsi@vger.kernel.org; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 6/8] bsg-lib: handle bidi requests without block layer he=
lp
>=20
> We can just stash away the second request in struct bsg_job instead
> of using the block layer req->next_rq field, allowing for the eventual
> removal of the latter.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Avri Altman <avri.altman@wdc.com>

Regardless of the ongoing discussion with Benjamin -=20
Tested the scsi pass-through (ufs-bsg) path - nothing is broken.
