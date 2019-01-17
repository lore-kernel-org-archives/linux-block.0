Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25316C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 06:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94CC20856
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 06:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NYyU8/Rx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PeU2BGiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfAQGVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:21:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26868 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfAQGVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 01:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547706076; x=1579242076;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/oGKpV0Q0Y5YM3qAXtrYBOHKxWy5a9rjOFI6SUyTWHg=;
  b=NYyU8/Rxp7Nw9Fi/14+P9s2h0j6PtILltR90RTNimraS6Ni9OIFYVSf4
   cetmc3DezzsRlC6R9bMB4PzWVLXcY19L9jHGnEYbe4c9XjiiEOCvqSdKP
   WOBUvmeU86KyLD2YvKlE14Zwdgd8WqU2W5DsBbedjppQLntwODey7CckA
   nJEm8gABz6ZgajwZMYbQ5qlGrcAmEfDRSNTHf5vVQu7jsPZFisz8Hpb0x
   tDldFc9P7ebwqmiNHzsQRveHc7iPZp2JFqgR4NkQF6/FwsY9F2Ac9Pqy0
   SdwpeYxb7ImK+puyUSPH9p/tr1SPElQDPLkY3bbsW1UKZs8Wq70EE1BVJ
   g==;
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="103955631"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2019 14:21:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gheEhEh1Y4mD8eY+oOjYsEevp6BOLSRvrUAuwoosXhE=;
 b=PeU2BGiP5mNyjfFMNc1WEV/eVQUNM+j16YrXe0E9Ehsi7Zm7bAUuBiBSkO70yVsI4mvps898NdIDXLiVdN9Dvy8oU4HMSi1S7azQOC6KxO+xXsW+VVZQ5MCu8vaQPCLJR5oQ8NDr3cLwxEKxfkkAWJRjKgWYe8vRhwZdiYISBDk=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2042.namprd04.prod.outlook.com (10.166.191.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 06:21:14 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 06:21:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 04/16] common: Introduce
 _have_fio_zbd_zonemode() helper function
Thread-Topic: [PATCH blktests v2 04/16] common: Introduce
 _have_fio_zbd_zonemode() helper function
Thread-Index: AQHUqMgo3nLxctnTpEOLw7CzRdIglw==
Date:   Thu, 17 Jan 2019 06:21:14 +0000
Message-ID: <CY1PR04MB226888D625A90F0A1DD0096FED830@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
 <20190110093725.32675-5-shinichiro.kawasaki@wdc.com>
 <20190117022258.GD25494@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2042;6:IG/gQxC3SfIPRrRcbUkj96LXf5aGEt0eShhfz2iZoREyEDvt6focCKwEsRIh874LSvTOjX1bBAE+dJLE+e10aVW8WdjedHLSTMdggvhLH1qhPK9mw8kQd9GHIxLW9qDaeX8sG5r2mY7yPMeIqPLZ6wQyIpN/ZaKbNTRR8b/WNj0Mpz5Pbuta/2UMbXxXWig9ewzO8S/ugxYSjWSqKNYNFyZ0w+5fAFKiga5Cs2B1wvrw8vFYi0p38+CQfn6BarVwdqLaaih5AC5/u/DJiSEJO/sngjdzI4/1/AhVfQSI2uuaynnGZIOmAdFAnyUgwKG4q/CQY7/UtCLu6A9iEtWAz/YhsDcFicVUs3V7l3uwdbpkossPzSxZnAO107VobTudQfIf4yYk27GKIzlryPz3NhIRCxQZz28eNsZCB/MOJbv0+IL1DYRLe+rHBLuaU6l5lO6hLZpTlsA9XnsOwe3cLg==;5:jaOFlIOjVXEbb4DAgMwuyOYWmnmH3W76pu4csZ/MjYPXDMx4GA9kX+rSTqb3myGJgFsO7P9Md8XEeS+U/EzKSRhtgm2vir/FCKlyd60/MXyyc4sl6+xt0f8Xxh29xPKZBiFe7WbTlZMFU3+uXv//6Tnd+NWat32R1p/yY3BjVBsPe5S32XHh4qaQK9fBqyiWVrRz1MNCb1Cuzd0LOmU+aA==;7:lCWiqFT3R1L53LkrKpGYEeUGAbZPyvkns8r5q/HGddYKbbqtnY5GMl9tO2LiG3/c76+4XHMxLAIOzQLjADUPMxKxlxvy0ghCCf3ffTxlAnvjns+zpCEwQfJDFWHhnTnTvd5buoCXNMsANBNve4PDdw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e46baf60-fe4f-45a1-4653-08d67c43fb88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2042;
x-ms-traffictypediagnostic: CY1PR04MB2042:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB20427EF0DD3B9685F8C3D175ED830@CY1PR04MB2042.namprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(305945005)(7736002)(8676002)(8936002)(55016002)(81156014)(81166006)(53936002)(9686003)(5660300001)(14454004)(44832011)(97736004)(86362001)(2906002)(68736007)(478600001)(6436002)(3846002)(6116002)(26005)(71200400001)(6246003)(25786009)(71190400001)(186003)(4744005)(74316002)(7696005)(76176011)(6506007)(53546011)(33656002)(256004)(102836004)(316002)(54906003)(4326008)(99286004)(229853002)(446003)(105586002)(106356001)(6916009)(66066001)(486006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2042;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: thG540v4IBdAhhFOIGJBIODgRSY0NDFVGXQmFVjsQVVYtZJtjLOoT1qHLGYyMgbE+Jc3ozvKtz2Wg1AB7PeFOn3CQaT8H11f1h4lze2t5xGgKGzMB0xE5V/9VoEFuzSzomJOOU57Nq+/3ghze5Go4CBPVMzg3BYgO03VUYP9iQXJ3I/gvoZlbIGJf0k6Lm3RNsfRawWftqyGp35FWErSo5sr43VSfUz5AB0WEjT9/43BqEVBHBU5R/L19rR2sttsnUR88WIs4EMJNF1ECaJ9iHBPfhhjWk6ZasFaSdKtjE8bkulaxQafNQLXMVx9co/PnsNZodHPcjR68eYDLJBCHlQ4dOKrHG89b2wHYO2flo89cy9ktfU8eusZ2Lv219hoaQueqh8EyyYFvn12+S6XjTP5FxRr1Bp7j53nYLUIfUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46baf60-fe4f-45a1-4653-08d67c43fb88
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:21:14.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2042
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 11:23 AM, Omar Sandoval wrote:=0A=
> On Thu, Jan 10, 2019 at 06:37:13PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> Fio zbd zone mode is necessary for zoned block devices. Introduce the=0A=
>> helper function _have_fio_zbd_zonemode() to check that the installed=0A=
>> fio version supports the option --zonemode=3Dzbd.=0A=
> =0A=
> Testing version numbers is fragile. How about=0A=
> =0A=
> if ! fio --cmdhelp=3Dzonemode | grep -q zbd; then=0A=
> 	SKIP_REASON=3D"Fio version too old (does not support --zonemode=3Dzbd)"=
=0A=
> 	return 1=0A=
> fi=0A=
=0A=
OK. Will change as suggested. Thanks!=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
