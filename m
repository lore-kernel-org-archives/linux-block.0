Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDBDC47082
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0B961139
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 02:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhEXC0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 May 2021 22:26:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4346 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhEXC0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 May 2021 22:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621823082; x=1653359082;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rvqmz9bTMt9uj9NrV3V9kRfqv9CIi9lZSHrEW7DOdCE=;
  b=labCDpnZpOuUZPX+A5dj4CmYKfRqrCOQwgyRZC58EV9lXgImhhZoAGY9
   RqK6UJ5V8yuDhH8v12YUsHzcs31bH6+j/0FX7T0FQYHntMTCyA/HLs2Lf
   +Tdwzit5R4IXmUM5WfwEVgIrwIPrNFy32ndbol5M+inbIU/RsV3aPLfGz
   A/BhCya4uqEoBlJZoArO1VHMrkvQhVSOA+FyVHX3B7iSqLhIp9CqePLYf
   fSDW+y+JM5HRMfi02UFw5F2JGUKAPSm/fs9+h/x4zDcmXYAcg1fpsH0yn
   v/Su2ubHpwsGBWg1qGehJmo7kP94mhY2bWbhxR3KZIxG6ibyfWtZ8fhdv
   A==;
IronPort-SDR: 6f7TDbGVGnlffZ3W53gqyHxNVyx+OpVH6/X5l4y68p2zfIvxS3B60VmxQpYGEZUyQB5sTzjz5D
 pMK5CwbaqCsPCDOVUlDS8NHjwsSwNUq8Nh0kg0NDH7z8n7EcwWiaRWzjCknBJX3RoGI1Tkc+fo
 xyozfNJlVWyIA7SOukImxjAy0pt8DSXD+lmUwpAhz2waw5dRcs5d1ho/KuDGdAVVnPs+NXRXpR
 ECzWtSCokc3mHdL/mTJb4AkI0amqzljqUE6pYAc25haEQuUlGc9NETy0064RIlU9YlLykgQA6o
 zjw=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="169192667"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2021 10:24:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnrX4PzfksEZ+UIfmtD4gmy+7vBmk2p5ZLYvBL3mono/NXnoWoUS14DZVcXmd/Nvxe9NxnrgqHL4CwTmrB00M4dCR4+vIwmLZPG3hHuA2cyz8qSOM0zjNwgwaSTgLrNGYoM1Uk88nGDeXUZlX+OmnNo4Am/GuyWNhm8SxDWOWd76xlS4jNUqRj2L8fOrF+Zdt1SDmM2oL4wKLyDsEH7agy+4G1e3lLXDx2FCZmTYiaErU/FphvMeDUrBYXqUSbf2UiEYneX1CWW3jXiaiMCPwUasHGGL7ZcpXDQefb/V0/Ya5AAlAee5wD/nN/FRxkg3LeLxSH+B5N+303KODZAGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvqmz9bTMt9uj9NrV3V9kRfqv9CIi9lZSHrEW7DOdCE=;
 b=ae/tH5tuYuSrSEnFA6+OZTkMyX1G/ovtMaPM0xXkV3KzI37jQyTDeuxTaS2kDpIJcrKePTDIswiSxOaig7xp4rtsLsWYBCaD6bGcDCRsJvTg+Tcz/3gXfYfUTFVzAXzAnqFiUkNZ6mrhoyCbvE3Kan5ZkimTiniAH41KCtsIodTi7PYO1dwG4EFBgAlKkyA1EK3NSvN01MzjDTtPtb549sn+oQXu258JYCzprDszh/O9M/fttojL9KhCe7nkwydgV2MYsulbkmYhXuCrRLYwZExBNPtttEqTDY1bg9zwBc9rWhkHJF40rbekVjflWdzCo84AqBLHZ6FYgCpBmoou4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvqmz9bTMt9uj9NrV3V9kRfqv9CIi9lZSHrEW7DOdCE=;
 b=DEBiqbrD/u8vxe0YJQAbs63w0IDEg8eEZCwNIQSkltcn1lLnl8n1kEsvtf4aYflk5eOL1ynBBYq9bB5GF+6VrIr12armbwN6cYT2j6DLCF1qii6yvgbMWeCTIyt1/Bk+ZN/q8oYWNLaRGxacv53HIwDqUOSM5ABw/fz0QbwxaW8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4229.namprd04.prod.outlook.com (2603:10b6:a02:f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 02:24:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 02:24:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Thread-Topic: [PATCH v3 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Thread-Index: AQHXTe2ZDmA1EJRz1Eeaai5icAjieA==
Date:   Mon, 24 May 2021 02:24:41 +0000
Message-ID: <BYAPR04MB4965C7A1458171847AD1CC8986269@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-4-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59bec431-8d96-4334-5dfe-08d91e5b169b
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB42293ADB24E4B6A1D47306CC86269@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o12VGXRXgqspH44hjnW7kItAMTxA+zDyklgOwXMaKMoys6cwdrlt32EWNuNf2NZZaRwuRtgs2T5C2Tp874UMO6sn863w44c/H4CwDMJPNyo4ORxxm+t/CQCmY0FwtK4ZCWsKJ40XA2Okx/ZO7YaueOsZ9ptKhhf86CAMhzbAYR7uxTiMV5wQKTlAs0TzsNGk/7RURGAByGqJOP3qZJSjbSo/5/9BtIj5vIVR0Rx38ibB4VNBBEbyEtfyi8yZi0kGr7qK9elZ1/cspuZQr3iuHkzabqcpeRA4rL3F11jMvIwN+ECQuEuCti3wvVVL1a/KOHdFbqmLscXS6s+8wQMPOCN/9iZylzI3TsLtlpblH05zWeaaetehLd68MnraSf6LZc/fRVqI0bXDGJ2s6hxzNUWeH+W3lRVr1x+ROD806+HP6glpFfgdDf4IQFM7/87xc3A17158Qz1oYONiDU+SW6ZkGbnZg08SSCsRh30XgD95MTOyvvWkbcdmYaEDuk1Ta8RKQEsUiTqxxTrfXb9aGsTxdfnliZYQKnxuh8xg0quBSkcs8DYkAvG+Xs4DnXO4KXCMU7KIJGctsT8EDk9Y6o5k6IboF5jBn/jXe+rbl6fcOjE/Y+JC1FXVC9l2subzROWGCooKyF9TIIKraLQWjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6506007)(53546011)(83380400001)(55016002)(110136005)(186003)(8936002)(8676002)(478600001)(316002)(66556008)(52536014)(86362001)(26005)(7696005)(71200400001)(33656002)(76116006)(66946007)(66476007)(64756008)(66446008)(5660300002)(38100700002)(4744005)(9686003)(2906002)(122000001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JYJIevQGRXkZY4mNFZdBrAxLh8T12Rgo1Dh53t2/K66dAG/avnEtmF+w8FDt?=
 =?us-ascii?Q?n+DCgj8ESohQ+iPPpY3PqJK2sgQxM0mi0OTwqr8OPpTVQErfvmj0PtPKElPC?=
 =?us-ascii?Q?Bfgr2GpeJAYUbCTEX0k1fqVphUbT9wke41OLWAYkWIAY0ikX6JaGhJ8h5zES?=
 =?us-ascii?Q?P7p8Ff97VZprZ+DsDtbOmW+WGwf09ISq88Q2frFxjcSAUOTU9L2VpTOGQW4r?=
 =?us-ascii?Q?BlzmqWm9hTv53jD4u5hIJ581Qj6lFj/Jqkm0kQHAjNgqAEGFO4pNCyjW0p7Z?=
 =?us-ascii?Q?fp+dwjaQcfDjk4DW47dASy3EJLVFAuhClWBhiBhQ0aqatHCXhf0vj+jjzPEQ?=
 =?us-ascii?Q?BeZXYqGlEKEuBwZeIlXGI4HRjw7dBsT689ozuQ1AItB7SoK6itAA6z3UU7xX?=
 =?us-ascii?Q?V8tE1W78SQzcplxgQkXvrHjvzbKBjbl3r0pzN7Edqn9F7Rw3hhO5Wx46QuGJ?=
 =?us-ascii?Q?zHjWlgYOxjKePkr2X2ir15uRWv3XTpuF79F1STBJvSRJPr3wBFSMQW9avXdS?=
 =?us-ascii?Q?VQpItRUQIRPJbFzlr+b5IDt3SHU+JNf0AcMJpzv5OLjS006QJvbJfSJRx4xz?=
 =?us-ascii?Q?BgfqTgLzUuwC7giIjQv0hv2soxxXEbVMnpcAKZwgg/fFtQDjiOR8/yYuoUYL?=
 =?us-ascii?Q?3Y87pQL9v1KQ32Ztdd8tr7NwC1MVH7uzjqyhniM1KDDVel7k1/1slZCLkGw4?=
 =?us-ascii?Q?R+4dCxvGa0TDpGgX3uVy2tvi/yxGwzNGxOxLQ0BX3pFsd+hno1dvuuok9kSZ?=
 =?us-ascii?Q?E0+JZ2leYHbUC91CPQOKVwIBO4MMElFTBSJDmFhsaqkxBLZG12JTs8kkhbED?=
 =?us-ascii?Q?JWyuJZNXDE8McEeHPCl7rq9+OfF94qEFA0yECQaHebt9YwJQwB5v55ekHz3b?=
 =?us-ascii?Q?JPSnsCOFMa4/JkBGGeRIj6mhkZKeY9QYg9LxLIkKnzA8s7HG+7vctcHa/DD3?=
 =?us-ascii?Q?r7gT5HcL0zxoZ9P20/X7P+csJqMOcy/KyG4iPv4D2+NoKVYKA6ktlG1ZMuBC?=
 =?us-ascii?Q?GS7HRrdDZhhtOCRM+uEUcGct/NF+oXNYoDIjSnmxyC10iOixxkdYuGhomrjI?=
 =?us-ascii?Q?A2Pxl+V+ZgZ10970ilbI58mZf94/AsNT4nWjjZbrdTjOPA+DPda3Ce7Y6ebz?=
 =?us-ascii?Q?6eWBmcL2Ke0jA5vx8lMyRW2rTFMb6qEnCQ+eXPu+K7d0fX4gzZXT5d95flRc?=
 =?us-ascii?Q?GRO15NLhw6d9DG++njp+dI4d23+wEsGLQSnNx1OqULeg1J7O2UBCS5yCkRr3?=
 =?us-ascii?Q?AfNu0wZq7+zw0TyHmQJ1lqPsN1XVL2Zwy6ai6vRHOqprTpIyL66VYM8TTQBE?=
 =?us-ascii?Q?TI2ydDW0ms3o1xIlJJkGl2KK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bec431-8d96-4334-5dfe-08d91e5b169b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 02:24:41.8094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQLlBYWHcUf0Nb+wIsz+4bHeWcDJeZPnrSrJv/HwJWNHaQiasv2jZFcVjKaw/NDdHzXkfIKIgvor460tRefB0gMSYftTwt0vuI8FyVdma8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 20:01, Damien Le Moal wrote:=0A=
> Introduce the BIO flag BIO_ZONE_WRITE_LOCKED to indicate that a BIO owns=
=0A=
> the write lock of the zone it is targeting. This is the counterpart of=0A=
> the struct request flag RQF_ZONE_WRITE_LOCKED.=0A=
>=0A=
> This new BIO flag is reserved for now for zone write locking control=0A=
> for device mapper targets exposing a zoned block device. Since in this=0A=
> case, the lock flag must not be propagated to the struct request that=0A=
> will be used to process the BIO, a BIO private flag is used rather than=
=0A=
> changing the RQF_ZONE_WRITE_LOCKED request flag into a common REQ_XXX=0A=
> flag that could be used for both BIO and request. This avoids conflicts=
=0A=
> down the stack with the block IO scheduler zone write locking=0A=
> (in mq-deadline).=0A=
>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
> ---=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
