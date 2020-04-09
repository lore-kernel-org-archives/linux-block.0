Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF5DC2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFD620857
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mk/C/ehY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fZKvyJXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIMGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:06:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48142 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDIMGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 08:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586434003; x=1617970003;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Mk/C/ehYXLNyUxs2d/u7loVjpInXg200K4AWnCVXnAz0qXzWWoy11KMZ
   3+WkDG53odHhnMHT8aKj15w92k5OLSCB6tNY7kM3pFqGU2HNqcERlUokv
   7NhbtqovEVYhrmPRydiqZz+jsspaINPCq5Ov5beuSM/ip0u2hBw/xnC8F
   nj06efCzqM4SryqcOjXZYSNMYI/nK2APsvyK1F+OnyzkrD9xa2tu+UkgR
   Osw5I8WLH2iTD+rBKc2Ft7YSMANgyCjFTLqgblwI2ZUyCtmg6Q2OOVLVT
   AkcQA+915VZthOXmWTCVJNlOvgAVCS0gkIlihMF9ERe7UyCp1dlGRObOX
   A==;
IronPort-SDR: x3+PneAE+0ZiEXnPp7vhPQyTdDZavGedlpFXfI4ayxqyOiIbdQThHajdDc2fVaCr1DLqNhOcyk
 NB6HQ0TiTYTpKpxKWVd5az01kHm9b/OoBiCWWDIWVPPJtK9JKY98K+CIwGNqWI6gNxpN7DqqHz
 Ng1c2bPoes3Ttalcd3/PNi5vqS8iGRtvHXEdPUBwzcPRKQ5/DLAEucWC3iN33OQOh6GxehhImn
 p9dZCV5Gqvc7KOlqY8z0jOvbgrP2Ud4flbJlaBPsLD0tBTvyVd/JM2tvlOUN1rN0nIcha3l+/e
 ChE=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="136404459"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 20:06:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbqpm9B49px+ntM2pWo44xjI2dztg4WvBSZLJhklAlomRvl0dxLXw5oNl36tq4tfWOhRJXO6ZXCw1oi9KQ8qjLXwpUcw0rDxvAcct585lBd3ulC5VnJb8PaT01QILBnET0e7IHJt/scX1eum/L4YQe5cYQxZ7UTZPkPrpuI7l4bUrVDTfEyPPAku2KNjdVUSyGS7c+SFkCD0/bPMXNOcbEfVCDX/BW5471664sWAsO/MyasQGZZsbXcO3gl3ZMc98u764AegD7y6y+4/oe4eiYniVYTEPmxLYt1YG1ItloTlPeGTGOV+IMOsmtRRiGU1zBoBuKoj5bPVYBhi24g7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RT7EbrrCYP/JSrgCXaKAnYa4DC6fNmx5xxgwOr/YG9Akh9KN3jx7GCebMz2vv21oGoiiNmYxkoHx32bpRlcHmBWVxLVJ4ZyYU7CazDTfOTaKiVroa8bF1GDyxM2Phb1OXUzRqgpP1TPHAGf7gMw+imjXTvpLNrJ/xMRbtGKUijXaZGgukYCSXOL5H7CsyA2uxtkIY1MIVDtkXmTW7oTYqXczVaxvkJAFjFR7mAnZPFbiqyhGE+iNTtucKN86pE3aMuCB7rqGF8Ca3fTL1o7Xw0rp1xZuD2JIXq5iHI9CD6UWHsZ4koyoutZhV/fOcmDqe/Ehjvdf2LQixJQNPTpTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fZKvyJXxSDlW9jbwDuvEMOUYuPldm2j2nUBba6Rw7GHnyHaUpYPkc7ffZ37ClBuPONbY1RGDlW+6IjuL/iAIIxXSWjDMs3Z96+L9eYmmvoDrqV9y4S+pa1GhLUlRM7D1oXQNjlxDKDD0WRYj1yzvbzt49njPME08ojCNtgTQ4iI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3645.namprd04.prod.outlook.com
 (2603:10b6:803:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 12:06:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 12:06:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 10/10] block: fold bdev_unhash_inode into
 invalidate_partition
Thread-Topic: [PATCH 10/10] block: fold bdev_unhash_inode into
 invalidate_partition
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 12:06:41 +0000
Message-ID: <SN4PR0401MB35988B410C2F050136FA1E579BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bfbd518-1ec6-4552-63b9-08d7dc7e76bb
x-ms-traffictypediagnostic: SN4PR0401MB3645:
x-microsoft-antispam-prvs: <SN4PR0401MB3645C9B989255AC209CED54E9BC10@SN4PR0401MB3645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(478600001)(86362001)(110136005)(6506007)(186003)(8936002)(81156014)(4270600006)(316002)(64756008)(66446008)(71200400001)(4326008)(66556008)(33656002)(54906003)(8676002)(91956017)(76116006)(9686003)(66946007)(5660300002)(7696005)(19618925003)(558084003)(66476007)(26005)(52536014)(2906002)(55016002)(81166007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwm3nrQlS/+EtMidL2BAOs6T4vELvIKMVOqaiMF0G3YNnC2eTHb18gghu/4GnoK0JGB2oWr11KxWr8s75S0OUZjI8u7JXwQTCEJ9GXPE7sgwV7e1oG0COAfiKkRv+YFUQyOr2mXUPy7214+8GJcKCM4wEENVmpw7BXEQNaQ5O8MYKX5lYwlvjkrZE70yyZ3v04gr6VQLKA47yBd4XmELF01NcB8WDYmUtmVQ63oFiVpnb6DpRGL4XUTH06vBdVSWRXWdkiwM0xijLqouRjD3o1IKe8E3BFgSBaVmQwYxbyn/RyHAVAzQylgjnuZ68MwdME55mIyhXGufBGX/8bEhtG4ID3OqHFIDhpGksDJs7j5PEIoIkIukeLPzVRxFjlQCjAJccaI/jtm5ahikoFEm55boDct4MmnpxUCywCqT6hRKxt8PjZ2GxdByO/Mdws/b
x-ms-exchange-antispam-messagedata: SgeAbKzZiYua55zgJh/ZgIVoX+dfpXFA8Vh/cwqY/3sB11KQgDEYW93OiqaQ8qKxbBTv0gv7B4DOEZN/qr7cLQmoZOEz6DVI1gl23AK5JR5JcD9w6oTo2zAE/adrEtZyRHSq9cUWTnE5gwY4BxruWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfbd518-1ec6-4552-63b9-08d7dc7e76bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 12:06:41.0767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DV24OxRcHl2rAeL1sMy3Bsryc1g7kOtevpoo5dBf/S6oonHmNMAsbO5efV88h03g8TuR9EYfifU16sOcvQfWTzb5aWIj4eKyQ2BtmNu6ySg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3645
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
