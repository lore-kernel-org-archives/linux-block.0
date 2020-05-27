Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F6C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44ECE2075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qTnMvUcV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mKDNMHnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391890AbgE0SOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:14:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6069 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388720AbgE0SOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590603249; x=1622139249;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qTnMvUcVSDl3C3o/hl47Cw1Mh/JfKPw+cuQDKBqVKAb/5cjmpBN8Pqma
   EGuXgW7exHMYkasIT7gJ0WkBfoHvOhjZh3Sbz9LrfwLZMKpshNSLC9NBC
   DsmZmlrizA61aWbY6tB+7RWdmTy43ZZouudZX9uGpoVtF2cqZDMB3D9DU
   qfJmNB9GJ04m+juvmtUb0+uzM1NgCdlP0ChMHOSvukye82yOX+3QTjHvn
   gxTtwpGcnFdRZlpg5zh3B7Delk+A69xlAkkBVEcNHKamZp/xUn3M3Sen+
   Svk7ZvRJ1C//SPB35PYB2vR3Sn80JLOBwy7sDmwJ74jwPA3Jyp6mlHTWm
   Q==;
IronPort-SDR: mMK0tGmUrr5f2qSBoiP4vEKU0w5n/Awy74s+NnzvP6H6jYUFXt+SzrxeaVDDxZ8Dxc2zelLB5z
 xzg6YgacIW0Bvhd91I0d8oUILw71BUzvqvFmMUzeFfK/GlNRqWpBOryHL/+TbvD1uo1LQXKLZe
 OEi4mqLR2q4vvCUJi2mbseMAi3RS+JHDQ/z08GasAFVdjoqw5p9Xq31WeWsSPWNRYsNdqxft/C
 +D7NjprsYH84DdPkzqCQFQThOeyVNePAztLYo4bZ3tCbwVwW/iQKfgXJ9pIAmjYIWmO6J6ebLD
 a5E=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; 
   d="scan'208";a="140068463"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:14:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWMNXtl27l5liZg1pBITSdYyWQXLdZ7cju5AqtqtBKtrCJWE0ogl1Qb5xTx17o36IG/s9sQMxEGUHn2OICa59wRN30qAYIwVvL8NFOCGwcRxYQBXf5PfUYcWodY7xeBQWVB50Ra48O/Osd0CvkTB68yvLU26iux1mox1UY8Pki7vq3K9KW0FuX25mv+HLmkdCg4Oe7XZXhL23Heq/lkm6iUJQT+9EBlNd1aZQlgkRf0nE09ZJQV5AP/rIphuKaUwBaoST3bVw9AJPB++O6qbh+bnhJ6IsLma9hpocn7CMJOVw50QwpvlOuO08+VsgoLEEP4pJVWLmQpYa7uLWNpVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EXf4aOc8unzbQ5k/nnRO+GfLuJi3l08CuIg7IGEAKSQqbaw/WACIJbHDNvb02g3081h/EV39bf60GFAdqBlze20RjdFE7Tvbwx0YM3hyAwzg9ddod1PViXPDyMwEFUdCB5X/u5D+r3SlTKw8OPX5Qks2su+CRS3vO67NHQYNTww2jE6fmX5atOkz618fRQKsXp8MewjhAR9SaTUKVofkfZdDBkW7QqCdJiWRanptV/MBYEKLCDktLcSlpKaGlisPRBEvaVlemu/GQ1MJZhkpD5o8rZVAE4iXFs4kbT/6hT6M57yc0WJD/WDQYnCPdHmVH9kqZy2nlqVU0IVq1Qz3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mKDNMHnxHqSOtZIO4qWSAltOiTyk2B/QQxI+bDekF35qyvdqdaxnyPF03Kn//Dlo/oS340AhyQoar7lNnhuySXYD+Hj5PJyiK134FVig6Asb8U2S6DwusMoiGDYvt+m/E8ugdLVS8A8jD1ygRGhAVKUgmSq/ZjWooek+wkeU484=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:14:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 18:14:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/8] blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
Thread-Topic: [PATCH 4/8] blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
Thread-Index: AQHWNFGfwzngXU88fU69phbpYFqn1Q==
Date:   Wed, 27 May 2020 18:14:06 +0000
Message-ID: <SN4PR0401MB3598D73BCB157F85DA72995A9BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cba39072-9065-4804-8ba0-08d80269bec4
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677AD90316D76C900617E779BB10@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQJ81ctjpMZU7xbJJoJVGnqytHOezwC1t8pkmA2v7qSARcAEBR8qQN3gW/gW015spK7PDueKasMDpYZ5GnUwms0fDx90+HfyBIUyyoJNzn0DL3cgcSuCFaat5XF+SIXEAdDbzdR2bPSERyL+dUnfaPe6FCK0JTPK1Yb7byrZqbp+96jf4QP2eeHOZBS7dWix4eH55p5sIYFOLkh20hL7GMfIMaYGHs+296z+JjvTCbWII3GRJ3Xkxbz73Gmo2kxHGOG9KBEhAcS3RjlcbKTuocLiCpvmBAWLd6QR9xHTpkfajwdGN4tq7qHWeyaip2+mW1e+IQr//Ru1HH4cBI4NLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(4270600006)(52536014)(91956017)(66946007)(66556008)(64756008)(76116006)(66446008)(478600001)(66476007)(316002)(2906002)(186003)(33656002)(6506007)(54906003)(26005)(8676002)(7696005)(19618925003)(6916009)(86362001)(9686003)(558084003)(8936002)(55016002)(5660300002)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nfxJ8cvONxi5oYPcrJVhpC5Y80s/yWbANA4MYEt+7QUvhbAWGD0MkqHbbBhK6mICnfMNKMv6vm59kFYKGs/fCWPxp2JPnONOd8BOw6Ms5lUr2oPXCobXWzJSmOpJD8xa3S9LvTQFQxbxEG6Wclly+R06xVX65wsghDdqLHhtLiKSZD78f3FwSPCWJlrvR5vXZugNFJSs96tXvA48EpIdz2Fbl1dzqS5kJt0ln0BsWdgOGEyi9wTY4WTsSgdLhPC48OhTEDkWjFjW88nIxX5qOtl8FZ9X8P6/8sQwF17nQxIw/hPvHmp6pgtMtzctTQmzwmejthr55gXwdJktFEvIp3mpdopJfZdYj746/TTiv/5VbczkYwpy8vEE+2BtNdKuu+gZgivZ0o9c6etEjlkDLFwRvXdq5JgQazZAgaU7ha6HQ398uDy6btsWbBcnKBK8mTgrNwjI7iEadXgczaZeigW3ybSu1GmWpDZD7jXJOpYEdtzgQIkuPjvI+zmyEHZt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba39072-9065-4804-8ba0-08d80269bec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 18:14:06.7459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxgBNB+SQljjEk/pvwFwsS3plich3HU209/nnSZeFl48OUe1xTeboiE/qAM4oZKeex0eUagNffupL712xbHwNBUyFdLODTuoNK9mcpBcuEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
