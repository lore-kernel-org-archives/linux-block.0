Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F4C2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD10206CC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hSW3fsyc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rq4oLHXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgEML4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:56:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10300 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgEML4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589371012; x=1620907012;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hSW3fsycGYbLuxT6pBcYBtDkg+ApuLyI8/iApUVlgrydZSk2E0jmfrb+
   aQjgEeRxrTgrpn5726tqeMyrxoIYpUOxCh8UkNWBBNssfOi+ajQ5t+tJl
   qwIkhqR7+udIBfyLo+7oKm8VhAAUATBQZOsMQ2pchMXd6OKEDsG2AKesd
   SDWwt0kZgjumte9NNEwURCGSiCO9tHeEkZDAZKyCxw46zrhFQRUUcS16V
   I145PV+vMliU9kdURdWPw9L29K+vhrAlR6PEXlS3/mjrpb1iKBKcwG7I6
   bfk76s8wALykL7MxyThHOUSagV7aRyLefubJwG4gMgz38PeH9LLfa/mMk
   Q==;
IronPort-SDR: 44NHoRhe1dTY5t/CCEf8PlmnPdOVZ0MaeVt5dvCMmXu144nIplxxu0BMkcm509vGHWrNxbyNwK
 9LhaJvGpqiMSBf8ZQeAMNdOvGXbJYrWkaJj2LKKAgN0iueC4HASxbYzwY1QnpMD+cvOm6m0B9J
 ao4nLKkgCGkvxv065YLTlpQ8CzRjx41r4GpvQxDoTOYLOy1cTp+pAlE5KRgzlAmCz95p2VeYJR
 EsJAa26CkRfEAORV+yjCLCtrC/i1T7JfCv6wa//kh309U0YMNuXlbjdJCNxPv0kY4iDXsabnum
 c2Y=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="141923076"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 19:56:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZGMDnV8rFKkyOPFdSwsHleJAUIj/BqdnxuxWOb0YOpT5UB6nDPbyAwIYtYQY91S7l0jgZEJSIeVBsCZsAEMHSeGOObSyMi4BBjfh/R0ZSuVzPgIOtyCu7NLwTnDOQD5v0Mpa7Dml/HRDyPee3LueEBTCoKtoQCGrlcItP9huBWCgWJ5HDUib+iOO5RwPiOvOlrzc/qth5qHTtuqNNOl0HzIkSRfIllRNJaKhMzhfcrweBnoeBwv4NdGBP0zm/vamaUrE6zg+jdFqwp7Qjny+X7qmCcd3Wjkx2sU4+2bzyAf6xgoSsxKJAkft5FTJqV5ioaUVgPCFDzrRFbH05zK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=guxL6uZXF9m0LkDstQlvqRsV0wHCqMdsb1DIfuqAQF1DNENXtQj9Q9b22LvY6OEZnZVwQgyQ2nxQh02hIo0vI5aUKotxOEuCAiJ+y1bsbYsXzG6vhu83Hxowpiu76SlB1w2WQUGRHRiV9N5rJ+uRLI25NqUT8ffMRxLyy2uQepjiyxo32lZdOJeA5ztS01zmpo8W5LU8oL67LijGqnZ3i6amCcrx66ehYBL+8gmMbbRdWdekPwKRL9ih6CcdBjFO/0a34khAvYLRg4BkD/UhOrnoeZ0ZFLaesNmp62Av/T34QoknXyZLhfoflBA1VSKvvfxm1ZbV/mPNhGqRlxPdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Rq4oLHXV4tmM1crYPBta9YhJZHD+ehngNkKf/lwovdKYLh3V39lWnW8wu3N975zuDPayqnoLZ7OMKKGgfFWrElrEksSiajM8+vcJEAW52H7oKSivcJTHcimStrhy1YxsNDdR+tHr1YJ6L/AKWScUDH3mdLBwNzVtx6hxTWLw/t4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3550.namprd04.prod.outlook.com
 (2603:10b6:803:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 11:56:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 11:56:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] block: merge part_{inc,dev}_in_flight into their only
 callers
Thread-Topic: [PATCH 4/4] block: merge part_{inc,dev}_in_flight into their
 only callers
Thread-Index: AQHWKRQ8IznWfhTeG060XObhiTRoKA==
Date:   Wed, 13 May 2020 11:56:49 +0000
Message-ID: <SN4PR0401MB3598C393CBB79814A07249CB9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200513104935.2338779-1-hch@lst.de>
 <20200513104935.2338779-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c945ab74-814f-4bcf-4c49-08d7f734b81f
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB35507E8E0386EE4F382FED889BBF0@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5n7JhCWuz5UFMlVJ8nIOAuomC+2lHrKSC954nJktcaJ/EtEr+e6ZnSx0ltU/TW/b27EEki54/nfv6037Q3HyndXrgFLGMDIDCVX0G2IHmHuy5tiT1j70qZsBCCAB5FNlx6Ctq2Y/8+xbMrFfpXgLGqyk8iHWSL3wi1B+NdzQBqb3vJ6w9nADek4PinSuc04TdfvoPYaB4H0hdUyy2tORt4KB7hURTlpWRX2gqoai+0L9TAbTQbiV3K2vB6mJN8WT95M1TeCzKywbPUUt3pqqFoEXvfCwI9uiNROFySWxeKJVbvQMMrTfYxjRr/m/eIPAkElLP4FBseoupqXhNP1oKmubm+ll4e3ERK3ixOuS/wqIKl1Dyssa++p2z29ZJtcZ2lduy/an/OCY+if7FWX23OqVrMV3acA6efpZNCmK3tgVLqYtqQ5J49YD+M4AlMDnJkESj472eZtI2+0dUE56AIPwoX8Ph+oOwSIPBYLDaanyizhr8s6a3i+UyFSxB1oaQhat6lnFiF8Q5jXKAtsOdnVPcTob8nD+lfRObTSAvK/6cRo+yzAMw86RrEmYXR5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(33430700001)(66946007)(55016002)(26005)(316002)(6506007)(4326008)(8936002)(8676002)(558084003)(33656002)(86362001)(110136005)(52536014)(7696005)(186003)(4270600006)(66446008)(66476007)(9686003)(19618925003)(66556008)(91956017)(478600001)(76116006)(5660300002)(64756008)(33440700001)(71200400001)(2906002)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FAd3qq+bUsnHdU0XBGQhSw689VomWbmy+NPpcvgSAA9vrjt06MF8RCy5SRANd6NasIlahY3GYLflfaz0StFhs2ACU+5bfOxmtlYCOjQDlPG7r6L4lvEZMUbvqjP8b4DsJx32ZIzQLuUFYOHrdeAl0dX/RIWOectUXi3/odvEiviVhJ9MXroqGB62/SCGrKTGviuozH3cC6AjASmShH4LkunKcM1skURWxmcOZtsgNkqTaEhH638yewC9CwDDJ0VD7Bxyb5GGnWnCGTfakDwQFvFLgE6ynlx2blUx/Nam6yHS+NZEnf3Pv4zP1kxFJUx2g5Lfwdr79+f1VRyaT6Y9YNS94+z5Ua+ogjXHD/c5Hb2E7EieeOMfKvTBre55IRXzOi5Y0oxxtUHCeU9fwXXdCuSz1ax+xt3O09oqk27C/LZXeQk8SWEvyGKTSLQIfbe/hXDsdL5Z8sNapU+lat4HEHjYGe1IE5MhswHYmRblky89tWeqPB2iDkJSveybyjf+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c945ab74-814f-4bcf-4c49-08d7f734b81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 11:56:49.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2T4joofrplRUEfBiG6f8n235jJDPcl12zBie6pcxHVTa9GLBf0zwPEcK3u9qHCgzwDcG2KHyg8HevogZ1kw7CL+XlHic2r6QMrI1yifQ/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
