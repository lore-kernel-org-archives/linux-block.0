Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23612C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20082075D
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MeuGppGY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GChLKHGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgFZPu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:50:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20102 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZPu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 11:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593186657; x=1624722657;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pj+gzKNJKJhAOatjzvtyafSjaFV953JccgxzeyNZzf0=;
  b=MeuGppGYPwdHQM1SBL5fctIcbnw9mnloejrSAWdDsmaXzCXTTTYtWxuc
   QGmM+PFnISqbdwta876KN869+i0ZUlfq5Fiyb1q8OP2Jt6GKtd+Zr8mmH
   ljmN0zZaVv4OmE+gM9zZOOc7AOFlAG3+3nAuASZfZby9i+bVv3jxjU12s
   o41kO/jJe+MPnB/OyWmPc+0mAxqYgyNqMHWK2vHD409RPcH4u029xB0WT
   tnGG+Bc99Ay2u5AysamQkClv9fxIQEHUa+hzjze1fpfb73XBORJs61OX3
   eeMw9bxfgXPhXg/xiFax/jA96UtUK4U0zovA21TTe/NeZWcpQEmMLwzFD
   Q==;
IronPort-SDR: CUCDwmya8/EMIK/EWNOvoSnORUbPHbGvx57qXzTd/CxEESbxcuUcc2flxCfIV7TfzqNrEGYn72
 /q9FTAxZwS+Wf0nyZPW0rRG7MGvnZG/6D5bhM9N1l5jV7sTk+xVCPDL6X2ndKmgBhXpPfkCzQ4
 inGz3RsByYRkKBmvwEnEHfWvmYm6pj+eM+XxdDMq1Hz9mvaaG09XJo/1Kcy6j7qKyGezGeu1sV
 lWdOZfYvez7oCYPtfhpqrdMi2Yul6tWhFQY0/QlPXeoaVKNJwBFoS8t4sBUqJwVX/MiTKBaf8G
 Wpo=
X-IronPort-AV: E=Sophos;i="5.75,284,1589212800"; 
   d="scan'208";a="141242681"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 23:50:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqRjan3m9EzuuPJisyVbEc9RAzXJ+gbYaZCXWNR65lO/yPN/u+bsZ4SMB2j9MxqFALXiEtYs032TAYHtD0KHdP7kl2JSKwc43ieZ2bHQY1prUpaqthf4elXmnEljxKxVoHgZBa7z8pGHarBz4IBQRMSTpaJ5DyWU/O3CmOs3eylEWk/uduYEAfPrqUwnxQWNRij471ExXMj+XpVNoqk19o+JgfwfKbk530l6qTmkXNgGHFeSRRGPTrTN5iVURcfMvsRQsZxMxCyyGdKOVMUL1b1cpOBg3YvUMTLwp+hWpLRms20vsKO86nHWS8XSiN7JFhZPyI8v2CPq7H/6NfrsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f3uvX/BSiHS/OAu6C3UPNFmvNDRuicOynZeZkecsYg=;
 b=OH57m9RuMY3Jr0MVG6i7A/nIouXuKfc9d6NQsblJ38LrNRYnj7zMR7yFI4o7FfpchlhDj+wPZ2vuihdCM+nHtZQWdtF/rg2T+Z0BZwFUYS6kVyyivwoSQctmZ7dfu63416+Jj0qL/Ngirio7SSy1LFeoQ4sqCsJq1VGdF3O0q7chI8vznBHfm3F80zREtK3hZhzRpbMN1ydrxPucwGTffnuoi1OyBtGkqPoMjJMMJhs4OU3EBEmq1OGqRLDM2LYgsdjR8NshEvzNvEYv8ZdlgmCAixmrZ8sOYGDB4nfbW7qvnsy37hs9zfnnDmvBZFxx6xG5DnbvcknJ3w/D9NCVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f3uvX/BSiHS/OAu6C3UPNFmvNDRuicOynZeZkecsYg=;
 b=GChLKHGdA43N7o34cn1PCw07DIGbRT8lY+GTw3qUFeSnx3u/5kTlHeGfWt2N7Qm6ehVz8Vv8QcJUMJSUCFqiJ2pIOaAMcv8AivHkGiuFs/VqZIiSEwsAkug+FKLJzxW2w6InULAVJfLfYVAphs7nTRIpha0Op6uzR415Qzq5uBI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 15:50:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 15:50:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] floppy: use block_size
Thread-Topic: [PATCH 1/7] floppy: use block_size
Thread-Index: AQHWS5A2R4KH51VBRUONtkChHUIXnw==
Date:   Fri, 26 Jun 2020 15:50:55 +0000
Message-ID: <SN4PR0401MB359889D1F40B3316A3E71A649B930@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-2-hch@lst.de>
 <SN4PR0401MB35982FE9416D43ABF2CDBBC79B930@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:a471:867c:4e70:8019]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e360df1-6991-403f-5474-08d819e8b629
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB396699EAC063AFBED6CAEFF79B930@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1MnHeZ4IRDJz6mOqIh1BZenw5ME5bO8rWTS2K97hMxYHR3TExpbEAchojjZPaImMaayA6MkbAiCwvGYfVrGlhZ9//bKs3HdtZ7BC0Mewu3pCDwey9lVwKqjByaskykOCqEurJkoLaTPqxtD+AOQb8qYOcoi8mi8r1cbx5pHoIuIHIHeYNOHBovFkHIesb141lpdGhXNI9VQIP0kvbwrN63cKUyGCCYQPoKbHNON2+cgigHqtJGJtDhFXmTftcTKMRxqTPkl1MzM9pG4DhzcwXlBTz8rVoSRcU0s37cmtElnsJ77vrVFkRzJNP9eHpCE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(52536014)(66946007)(7696005)(4744005)(64756008)(86362001)(66446008)(54906003)(110136005)(66556008)(8676002)(5660300002)(478600001)(83380400001)(9686003)(66476007)(6506007)(53546011)(316002)(8936002)(91956017)(55016002)(76116006)(33656002)(71200400001)(2906002)(186003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bLerP014fqb7srBJDIbb4lGzDMUoz+I7aH3yLXbpyu/AUpG/2NLx4Kje5OoM0EyKyKAZwDuBRXRhkfptSoO+11pJoduLIp2Tu1PH95i5afK7clI1xLNiVDHx8IKdGIUEcBfHFVYgEQjGF243joyxkTcAKvadVWmLSXKPjUcNMoeQl1dQeQBLA4cuPJZaXnIIEaug+20jV9Xn+kKQADZ89FLGC0+cWnXob1PiLZ1pFMZxcuMtowi16x0EiRgqkBne7YHyQQGfFA2FkMfBXZ5fF9JV6nY3rNupU2OGu+Mmjekr9+EW97wvYip+i8HyhDAl52rq5fUfh/gATr8QFPEoguHE9q/A5NhKnuCQZQL9QOiOJkrkV0imG4ShICNFCQ/zjrSm0hoRcESqSuw+0CzgHMkQFoW2dCLekvcOlSCqStZBetKcn1o1Gngvshp2xt35bc21wGQkU9xodfYSGsY4OREOmfHKWEWiDFhSwziqKjR8rMWhnedmDfczCICUzB2yfYBOEiXFlC+dEiWZRBSMSwzzFeFvbC5o+cIgZINoyKeKPI0K7unbTuN/AA898RHT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e360df1-6991-403f-5474-08d819e8b629
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 15:50:55.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xoa0nUCBYi7zS93lxx2WI12jqWcmRuYRM4DygcZusr7nCCocZaqIUuw4Gv6A3e8tUz7/34BsH1J4lJk1hNWFp5LfjPH+P4Nvo1HpyyP1Tn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/06/2020 17:49, Johannes Thumshirn wrote:=0A=
> On 26/06/2020 10:03, Christoph Hellwig wrote:=0A=
>> -	size =3D bdev->bd_block_size;=0A=
>> -	if (!size)=0A=
>> -		size =3D 1024;=0A=
>> -=0A=
> =0A=
> Why is this correct? block_size() only returns 'bdev->bd_block_size' but =
I cannot =0A=
> see where it's made sure bd_block_size is not 0. At least no calls to set=
_blocksize()=0A=
> =0A=
> =0A=
=0A=
OK answered the question myself. =0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
