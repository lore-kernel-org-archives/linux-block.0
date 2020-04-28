Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A48C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA773206D9
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m9UBroGp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wT3PcWci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgD1OMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:12:52 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21615 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgD1OMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588083171; x=1619619171;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xfbtJtvk+0lCRNtiX8P33cXmrtg41+8Z3RUl21nsth4=;
  b=m9UBroGpinO8pXYalt58AJa3l2/QJTRLFa95DWysA3+11FN7w24MDTfa
   7huwM+UQkFmBarDUZK4hmQGVhfLECoZmwYlmQGQpzNNP7fmpaW7W+kiRc
   utoRoELE/dMTMAmWMi7YFxCKLD3x0KtYFAf0oxNlP3atUAW3OQLgc/Qcf
   xuzMph20w/IkndBPg5PZPFLr4lBx2GJwgmizdk31dvZfO/csfUS0SAHOX
   KV79llCV7G/rddzWHUe8cPUk/Q5oSyKEZMs104Sxr1F9/Dkcujn7dXs7j
   OsOKu3QdlSL1UEWlJgJb5Eg3pWDMqQN5cSbTCWUlpD4BamA6qp+XnbCo5
   w==;
IronPort-SDR: cSsHvG827GUfPXGC4NHtEWl8aTM/RyvRZZRqNWsWA1zxw7MF/VCysAs7aPi9G66PKj6VosXWTm
 +PgmhGHb4TXCe8LtLOjoovREfeck9huMfzSsPpBt2fiNYPxiaddwrSe/NXyE1am9NwhR3uuwTy
 Juwf7PjjuHIp0U0lzYBSXGCvPhsidNUIA3hmNQhfD6JQeEziluNb/LxLUCQmfo787dSP6mrBbH
 8wN2B9iDeLpxUBIV7uY+ZfHj0zKvzfgi3fwjVSluRBwX3EPprHA9tGRCF9d0/Umq3VhVM07Ccz
 NTM=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="137793030"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 22:12:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cez/JSHDewW6inQeMrmiHTFFVD9qRCZB1nQwmdITUyKfbEEUiv1X/kSf06wpbvwghV/gSarLQlLsGpn8NJzFIVEXbNrdB382ta59t0h50TuXTNto+JcYdaWeK1n6hPJs/0BLn9I319lgg62qRxdqwZE1rQg6ykxOR69uHjFKip+v4clkJIzs4o+xHLErW9RLhs5tX/EiGKnKVurUjEPC/AEfeYZrbOu7x0TYsbsppVZs5kAay7HdI9TBVB8FG2Vw4RUw/n/qhgUrecYdRGR/PC+N8ISGZ96/Sm6LL4a2u+oUE9topUL0mYDwqlNOlM/pVPkP59i2n4S/x58JmRCasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfbtJtvk+0lCRNtiX8P33cXmrtg41+8Z3RUl21nsth4=;
 b=HHsd5meZsDdftXqMQF1SN9TJ5mZlNzgFBGuFDbtOwG3qgmy4UaXTLRkiaH4Z8TQWEUsJchX8m6Xhwr3MOhODdG/VZYk/U/3MhsB4lVPGyB0joircHb/VFYO9Pudf9sNOjW3rD7M90OSU/KWfsTltEBeM13ey6azqSIZaR3yyJ7YZ62y51wPR7MDSoxkxnouzAuVfzCsORO68V5J85lmnATsUThKgfFc67ce2oiEy86Yt0UZ2ZE46qU68pkBdc6NdW36iw8rCs86ihWul68IBQxZELsWVpq1PsdUrYBE34ksOLKsSUxQ6DiSnI+S6y60aYApEJyVOEd6d1MHH/uHgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfbtJtvk+0lCRNtiX8P33cXmrtg41+8Z3RUl21nsth4=;
 b=wT3PcWcitXMZ1uO2FQl6nuDRIzIA2rau8Dafmdyjj2Kovq9LOrIas1QpD01oG9Kv7XOPqTdyhTn4E5FhcRnacjTUao6kGLRVTQ9ZLVXRjXvy8Nb5GPVEupYyBLeWp4RQ+rc3l8i3O2YfqiftNqY4ifRU0t69/19m4QloBRzjyQE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 14:12:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:12:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] block: cleanup the memory stall accounting in
 submit_bio
Thread-Topic: [PATCH 2/4] block: cleanup the memory stall accounting in
 submit_bio
Thread-Index: AQHWHVAdOHeUjJWbUUKeR8aXg9Erhg==
Date:   Tue, 28 Apr 2020 14:12:49 +0000
Message-ID: <SN4PR0401MB3598CF483E12950DE63C1B719BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52e7b5cb-86d3-4802-3a14-08d7eb7e3b75
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-microsoft-antispam-prvs: <SN4PR0401MB3630345A2FB334D6498FC2DE9BAC0@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(52536014)(66946007)(53546011)(6506007)(2906002)(66476007)(9686003)(8936002)(5660300002)(110136005)(186003)(478600001)(91956017)(4744005)(54906003)(76116006)(86362001)(26005)(8676002)(316002)(7696005)(55016002)(33656002)(81156014)(66556008)(4326008)(64756008)(66446008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VjBSoRKiMbZkhoJ1Cdrcd9TA14cGH9KxXTV2Gl8yfR80EnpD0NoXAM2rHPLYHcWh+e5Zr8mgt4kIRN8fA/zoCI3U3PoMzdwryQsC1+BkknZfTyNCbhCkvUQaCBPNpEuE1kNnVLYYKMOWzDdOqvb75kirZIv/NDg97sfJcf49Fo2Az4f9X/6X9Jyz5SaDCsQvphCqKD76iKAuiGqGcwcpprsyMWFo5bQXnGvlEsGvJF2Sa0WUaQdlj4oqdPi+SCk3qc84Jxf96gh9lyM/CmtKlqsIXYhEz9MV5fPTabQ6kX0zCTXs1vyvkbHx4UwBCEnc9f8cPYhv+iV4CXflObnLH+waeL2mqPMNDAkqjtDmQkT2FOeW6dltuhHINV2Or9sKRpA/L5mH9J71OfLCgj3QlEUxzSdSzoAEYQDdwbTPwckxHOISSNEkwEhKhLapP70n
x-ms-exchange-antispam-messagedata: p64SSGEDtytmVXs2JXp1Y5ZNs2+77XdTnKsXyCOCwcNeTAHwJfM7NDRh3YKZ3n5LQ9fJUHp6Z1dBj3IMLAhaRuzUWvjL2jDTjW3CTOy4IvMKUarU2KVXSJEwOtnhW2q4zSCBAc6ifkFkbeZviABqGFMmPIAn4O+fPVTgNzSr8koKkgDMCMoy0PZQCRdNSDgE2h8dbqj10cTW65rNCR/2gv1ImWDzM8RlF4CPM4dfPrVzmUWJrAKfMf8vMkL9/lujy0uibLORHOi6WHgVCioxQUdNFm4E3MtsXzdRXVha/9623EHE3L0uU51JKDHZhG+baU6Rb2HwpGg5wDzzgMkfdr0KyZChBCUdx/XQkidIhryNIKjmRN8JuGMa7RdRSrUJZaYU/GSwUuCZO/fFzHJPTJoCP4gdXNfYcHoLKWti5dIyMRG61p6YshJB9E9sU7Id3iMCtEtWS+ZzHFLGN1KZVNi9MMLZpZEZMqayq/GDICz7NqcOF3+iWepvZurbOHbrKyq6PgeHOf7t6niffZ79EtQB15r6SKeUb1VrWTi2e4zq6pX3zNIOY4+O9KDsrVGVPkiGs40zAJ2IXZdc6OwjMJM5aiFqZpSygYMMAJjLmE2zsuDHbMw4zGrmhFU3rAh0+L1TifLA18hm3WeRsZfcL686wFjeBsOuXc9iyxh4m6XH8pjuMwBWrXDMf3Y2FEijUVDd0oF0hkWmErKO4jJ23efD71L5n1Kd6wH+XLAdJloSC54EFhLyzEzIN6VzP5joCoJ2uG6mLaDdhIbDXQkQi5Esugxr/kwtOxdpbfhWt8w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e7b5cb-86d3-4802-3a14-08d7eb7e3b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 14:12:49.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6RV/0p273quX1l0zihoA9GeWhb1/Ya7+/LIf/BLRB2Q39AhHH2Grb+q/F6/1CAbHMkh+5ucg/OUSjGjpAZn0B3oWwKBIUJyMbYwbqUi6tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/04/2020 13:28, Christoph Hellwig wrote:=0A=
> Instead of a convoluted chain just check for REQ_OP_READ directly,=0A=
> and keep all the memory stall code together in a single unlikely=0A=
> branch.=0A=
=0A=
Looks good, I just have one question, why the 'unlikely' annotation for =0A=
the psi code?=0A=
=0A=
In the current code, the psi path is not "unlikely" (only =0A=
REQ_OP_WRITE_SAME is). Is there any measurable benefit coming from the =0A=
annotation?=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
