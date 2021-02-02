Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C18C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5325764F54
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhBBJ5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:57:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33601 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBBJ5Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612259843; x=1643795843;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dspl7ZB7YH0ey4YlXqgtm6pPu7A1C1GqsmNLBi3+GGc=;
  b=Bt2N+4vtG4V/LVLE2vLzKWxFAoTu3HDEsrVubVDroFGc+WyGGy+JbzIy
   KI+cFqwKMgCQyrc7/XBrxnO4o18AGCirj3qbgdC+9I4hRU8IOZ1zsNbw+
   4IqNJoyB7VGTe1xH9gQsDza4WfX2zRkvEviVs14HL7EjYLSsEdrwd+OUa
   +ofalOf5bCxuJMTQN5cee9skzFddik1HcpKP231t9w+Le8c8KDZC0fOWY
   6gcGKuLu9RAUhmmcvq1nGqguGIuDTsUepHqZjuj1phLgBViEXZ5aJQv8B
   HbQZ2DO0UtkAFaUG4zC8eQvI9KGXiDubYPwBbIUVPD5Nf/08onUA7xdCC
   A==;
IronPort-SDR: +9nXiOXv35uppld4EFTDsZUbuOdb8qXwD2oFIR+I7X3C6hrAcMN/m1GW95m6tP0o9sPZbSDpq4
 cmokxezlsxoT6p2EaZH3zXOubEjenMSiAyOzwHD/PZj15oOeYaf39pTdLWbQAZsUXVgRK+QLfB
 sc2KStAX82pIOS91+Mq9fUYKGL+tAmfdDG84/NVpvBWAaE74dc2uua7UBNxvQMeYe0nusuQulz
 65M1ulSvqiDooNk4rxb+1nEOCRxzsbZK2bdG0UIUpSdofN0syfccMm0WohiouOVaZHtscgln2E
 Ka8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158906267"
Received: from mail-dm6nam08lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:56:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMQ/BkFJtzPrCvs2SDYkcLofI8k5ji1/GmNtqSLWpdsr9gfmmcC+o0nR0Bj0pLXu8+9g18gBpulAwmuEyN1M/Udor5ZxX4N5BVq5r+VQpqT1afYQ+i2nCHRf/onYHNyOdn9JZYKlQsJ0s9HVqqRmLn++XvRhlwaq5Tp4av7FIhhGHI+j7tM19i72+4J4dVmDZS24t6N6DEwNJrtnfZckBN9TLwuZPrqcGXdJ9Zu9F+UPkCPEyl/I3DjEiir5BASQ2zT6tdWZuufpLl3G/0KmTNIzSzsHh1nUJVKThRrHHuzsFESxuticf/bbc94xo5zmtp+Md+MLH5Snjm3fENQY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dspl7ZB7YH0ey4YlXqgtm6pPu7A1C1GqsmNLBi3+GGc=;
 b=Z1lUYlRd5VOW20s/W782RE5e8x8lhMBKFZfVmzzhuk5WSdgpHf5UvuzLqu3TXcz31NxPDaNYDrHDdebhk8hfAHq0YRlFCqXakQf7BZA+R86nyXZb7nCaNzVO2bAOVbqSF/zDBzbISn1WOIm/kkb8mxx6EVs7uufjPcX/cZKq2AAX8c66JqpUzZRfglKT0un63Exp/1NLTnD6CBzs0YwbJ/n02fmU20RhbO0MGBgJKBW7PqDICxr4AZ9yEWF8jEWxCStL4N0vvn1MeLMBBQ9sAl7qAJhw5xfINythshHt23F/KbCmMfG3yoWpJpzKTog+7awtlYwV1Sk8rThdJiA3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dspl7ZB7YH0ey4YlXqgtm6pPu7A1C1GqsmNLBi3+GGc=;
 b=FkrNA7pok9JiSDqeC7Lc4oTrVAItgWQzxhA1NChGT/CEMnNRkO6GTb1njFJxgprAHG62l8wp/P/XyxC3VNs5pqqIIZRRyvJbd6tj6wTqzhZH5I2RLZGg4YOQNHRpotynJy0eTKITTDGfPfOn9iFRQh9sbWeXvW43vMVaPIPHEzU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 09:56:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:56:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/7] blktrace: fix blk_rq_issue documentation
Thread-Topic: [PATCH 3/7] blktrace: fix blk_rq_issue documentation
Thread-Index: AQHW+SP02Fyi3jyUn0SHz8z2hC+ZOw==
Date:   Tue, 2 Feb 2021 09:56:39 +0000
Message-ID: <SN4PR0401MB3598BD1F1298D677D74DE1E59BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03baa53e-1ddb-4d67-9047-08d8c760d632
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB367988E901B32A891F93CFE59BB59@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OrAa89a4dYWSSMlzAzM6Q47KBiGxKOurxGYJTtXlBwGDcerk3W19tc5MohLey7PlpjRGLyf9frvt4VBM5zgIAXYda4lpiPX7Pu5ilJ/K7xF+kEwrBdi5ZL+QVP3tfvPR2s95u9vp1dhb0NR7iKcMEqOx63F8GpoQh1cZnVYGWyVXI/E0hCcykgTMkUOEBKCpJilNyxgDFwCy3SkxRLouZjwwkQ69RiBmm/XcmzvzK8EWLsgvv0q7udPD6rH6UgzxplcmW0QfM2j23O2oI5XXzcQKkMU5weP1ef/GbwQ3tqSvlxW+0EXgUFxHWQIQ4EaHoiB7eHrKaJ3l3SYpNDMBjLb8/iptAYoXCDLJQWBvgh/3dYiF79oH2yQ1nweDu/9owO6QsqxX1W5oU3otBfgf/0X//NZwndKTPLExCE3fbWxiTUPze+lZ/yBH1MrHuD9+jwrMHsc+sy9DxapI/lI5nDoP2SWUL8FRm6UN3d64gwiM7Njt9gX1ikPNyvEOLnYmfarIx9FnlXIvdW1PokoU0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39850400004)(4270600006)(4326008)(66446008)(7696005)(66476007)(71200400001)(8676002)(19618925003)(66946007)(64756008)(2906002)(54906003)(110136005)(33656002)(9686003)(52536014)(558084003)(316002)(76116006)(55016002)(8936002)(86362001)(6506007)(91956017)(186003)(7416002)(66556008)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Iv+ZtXrwlT/lQA5kqSj6UcelOwmheLhIsgUO78O1sInf/0d0YJF3mNAPVp7F?=
 =?us-ascii?Q?7sXtkZ4xkvPXHYJajntForCw3hGht2VR0oCzzOCIoPobxwCGRNN4j0KWVsm2?=
 =?us-ascii?Q?R7Dy5pD/+6ViMFhc+5octlQVUNdyVGbKX+lCd0UePFTyPrH5QVgJoFq5NnrK?=
 =?us-ascii?Q?rkQHjw6/lmrwmWiVAPZcSYYDtnV01yBvoBhK23ve2VFHUgsaFx59vWMuSkql?=
 =?us-ascii?Q?/Sl3++Xg6RH0GxgeJ1gMJnBfrE0OOydTKryFneClMh3ifR5RWMX3AcUZbNxV?=
 =?us-ascii?Q?FOFPItU2X0vdpZkd3XmfFKE1+dQP0ALkr0KV30JXRI7+I93JtdMSjrZjTtmh?=
 =?us-ascii?Q?lQQZIsr9Bhh5USJTlbW/D3FSxXx+VJ7h66M3FAPMmaV35JXT6bSDQVaYyxkZ?=
 =?us-ascii?Q?GLnK2OO2pmGrKqkdKgnP5kRIA+hiP0IYbnuh9yHxZCDrwFFUZ8DGQZ0Vfxlf?=
 =?us-ascii?Q?c9eC7nF8jrktiJ2roVysNIoh4b0L82UtbuAXwji9tJ6aUhox7g3Ka6+veBGf?=
 =?us-ascii?Q?YMISjXmqMUd346luUFl4wcOevK/8SiyBYkdyK1aAy9k7y8fiqUwipeVSKmwH?=
 =?us-ascii?Q?4LNTgB29tST0QzfSfrw8NTN8nOpNo/7ujHdYu1hQTVKN+P6PcHVWtMwC590v?=
 =?us-ascii?Q?MapwdNR6ft1tXSBu+kHuf8bbeO8GNZwG9jBC7LtofwtjBiVCBh18UKSZ3T9u?=
 =?us-ascii?Q?TlIqixBYKHPo8UCxfyxp/egXGOSTHtxjDbeorspLKu6tBRZBdkdkWiAvbk27?=
 =?us-ascii?Q?YYp7feP88AeRAbhVLQG6NAonLYzIe33v01p0qG/Z5edHIQoDDQVqrwcDWWCQ?=
 =?us-ascii?Q?jQr49bE00YI/NmKWI9lXHMiEhHcFdHjw+uV3k3GZxlzLsdEpg9yQY3dxASdC?=
 =?us-ascii?Q?OO9CQkHkQZAk0RbQq5nvQVvPEMqHoFaHonT3S+oP9aIOz4OWF1VwT0bxPbPA?=
 =?us-ascii?Q?rIPLfT27Y5HXWoJJ9LdWbTfObjG6uPUT9WpJ16lousBRWcp5wgHmiA+0LsJd?=
 =?us-ascii?Q?kS27bXFMYLW+UUq8rcUccz5qI8E36uM7lYJukCfrEfcgTK42nPJktMsetKRI?=
 =?us-ascii?Q?2Qgj1EQ/moDyQWClS3T6fErzAr1GtSCx1NWAMXZouN7oPw0OrCsdeUMlYIG+?=
 =?us-ascii?Q?p2Xpr1U1Jy4PiyvG9IuE/Sro8jGS9HUnPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03baa53e-1ddb-4d67-9047-08d8c760d632
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:56:39.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLRZIqfwt10MOduRe4QFs3b1SIssDdb3S9MDjx43lVFoGInoyvkZUDovnamB4q8p3NMKkeRwOsRka8Qh0kTve3+00cP9Noqx6Qcl+u68F6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com?=0A=
