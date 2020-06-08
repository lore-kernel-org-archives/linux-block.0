Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B3C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EB02078B
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="htbnOVFL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vq02rH0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFHGpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:45:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8012 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHGpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 02:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591598716; x=1623134716;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GT3UzYfrKGp8mgqcao8XHV/HLe0LzrcykjsHHZt84RM=;
  b=htbnOVFLk4KetX7pWvIyJ8uNc8qfbT0gR7ZRQ7TPt9UpaXF+AmnCFu03
   gGpjvKv0YzXGz8gQ/7HXSsfLWIvTT1iXFfdifRDzWp/4Lcg0xqLA4QoKj
   f2np4F9UCTFNofgQ3kMKGQwqXgSarrWiPA7invE5tGNOI4XgEMfAu1MJS
   6aHoIQlp0mojWRdoVrr/FgyHhFZNEgCN4wTn4aWkoL2FNh3SAZs0CixTj
   QDDDr80ZHaQ2nMbZgf1AeFXQM7nENvN9sLsLuniGexeU4ioMDJkIPxLwA
   ZRIQe+VkP6Vrx1+Cbll5msPfws5QrG2FXHZYLhEnQ9yqoSwQfErmtrcnh
   w==;
IronPort-SDR: xVS+DMzSbediy0zcV5mkOvJ9p02p1UOZUKevFRuA6xOHzcsH9ZSw/AdSNHeFZ+SIJ3tCUkGcde
 yvtA/ILl0bbdaReol5vJWBFJ40C4+msMBuAm49mEdWewnYTODWinB7QLRKWj7kBQy8aFke/aJB
 YPl5YMiHza5HckYYfWGrXIvVTKUcKZ6LD1ioCgWwMO9a1l1FNvpbMbv4b48pio4d4uwn/sTcrW
 1gfmtDBsrhy/RkIX8Is3ihkp2WDxjSqY+/kPGHJryPUoYnm2lXSo3ZF8FII3iivksg3VN/bCHx
 aSs=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; 
   d="scan'208";a="143749178"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 14:45:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESsb7rLKevUsRaOTuSzNQEV2XGQigD/ud/PBOq8MjZEbdx8GPZkQUIMFfqMhfj8zOqEtA1axI7Kuj/vjxDVXJDPq18fJiKU3KAjrM4nkd6O7n9b3akiJPnJyW9zTQbI6uvR9uU2N5szaQOj4yIHMDTR36+g7s7QRpj+DPPSxtCpEPE0LUNgeptmX8Zx3CS046WCHlFyvGeE6p0iY3DBACTYUucpBIWr5BLMjWvPf/gne9cQfZ7Ad+FcppcDLTIj0QLRqPLVZ35DzN4hRlQmR801pXxeEdCdUshLCWW4zE2kuhVjRBRqJxsWCCdVpntuUUu7mG+4c4DkC73jQO0QU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i39jmTlEI/YWA36moUFtACMXTP8+AeeMSwAIv2/cOT4=;
 b=dljWlFqYjNDQKgMaxsSo1WIA2TYjf1j+UTlds8Z0Fh5DoqILWWYNMHU6VoVpstX8SQlRS9Xg7pgMgDiCrY7o0zGAYYp23WtVGiU0fYePCzkXDnHbahLDq/JQcCmqcONiKhwRb//Cx26QgMImKdE5NKvXWsUSwg3XKpRV6vdo/Rfogm1IgSXNcd7ax3BrHGSXdgtP4h9pOJz2aVt1L4iL7zyJwypcYjhRn16phBaNgiIp2rTiGKzVGGZLPmXynRc0arfK/A4RZJDm5JWn8BA0lWy3CpBm5oIqrrnnEcjBVayUd/y/6bX5zYMNVI3w0abXVahL2FaKpVmv/YX7op8ZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i39jmTlEI/YWA36moUFtACMXTP8+AeeMSwAIv2/cOT4=;
 b=vq02rH0ZxAOiDYO4H4xDIndP6XgBdgW0LcjarY9/RQusralZyfUMdj3+8NjOgL44aIfCAuP0gkMv1rufQgNknxv2OMzS9IfbX9mvchO2EpLOmKGCmi5T2koCaPSRk5XCc10fRUjSofDIYbhUGxJeXgRXI/bwysqH6dTzPeoQPoM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 06:45:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:45:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/2] blktrace: break out of blktrace setup on concurrent
 calls
Thread-Topic: [PATCH 1/2] blktrace: break out of blktrace setup on concurrent
 calls
Thread-Index: AQHWO0nTrUdVJ1iirkGF+dAZ263BNQ==
Date:   Mon, 8 Jun 2020 06:45:13 +0000
Message-ID: <BYAPR04MB49656BCCEC45B3E866C5B59286850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200605145349.18454-1-jack@suse.cz>
 <20200605145840.1145-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb08f8c0-e7af-43f7-13a4-08d80b777f4e
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104CF7D579D03B8379AC39786850@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOwQksJCpRew1SRoZq9E86d33gK31lkzQ8HiAma/wICCca0zsEyNaK1HHLOfMDEp/Rj0MmEZ13WzdD19g0zC8U6dPjYsiYjb+Yi/qr74Y65agOiMyM2A/8Ume0tyCrJ3gSWhEpJ97R5t6NLvFdfNLWees/HaenRRiS2JGXMYXPwfoKWI4mvH2H+X2lduPebP35e41qBgoD4fJ9GvwdveaHoKfeE143kee7fplrBIZXboRnk9It8K/maiVTv89gt5Jy4e8lSVHQfXpMyCseEJDgyyFEnoKCnMXWL/B1As8BeL799UGmTt88w9TyzT5Q2Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(52536014)(26005)(8936002)(8676002)(4326008)(4744005)(478600001)(54906003)(5660300002)(66446008)(66946007)(64756008)(71200400001)(66556008)(186003)(7696005)(66476007)(110136005)(86362001)(55016002)(76116006)(33656002)(83380400001)(2906002)(9686003)(316002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Cef00HVfujmJVN/KnizjrTgh7GUArTGloQDP1axGh70qBTziMO6bxuG894j/MYW3KxmtzHaqOVwokShevoJwtk/Wjw6VEQQHMU+vx2IjkIIlowMs/ScbnGFvPJ8YI3kt07La8vmPjZPekwRIfQW/42oEhU05mCGPdK5yslHWQRWS0+r84R0xsj8G6mMbF9wRYfBS/CdL7/F6fOvAKS3goBTiMQahfwDx5W6kYC3GivmZYRCQBJAFK3r7OXRoi98hUGuIOS46OmkQDHCJH31dhg7MlOqaHslntZTHAzOMU8ewZTTZD16nHHEqvSCo91BKMGg+TUgh3YFVpr5KeF2/1A6CNwxL76jjtUIvoA0RwLHhv6aR1nj8SaYFf6ugH/qzNnJbxuAcMGdJ2uGn7flk6BsNsOOnKZ57s5bTb+jNpjWIdnC1LFCDpM/oskrW1O3CNOCKaIAV1a+6Pm4KuZq+e8Dab0FhxfglEOETzNSnVwk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb08f8c0-e7af-43f7-13a4-08d80b777f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:45:13.6842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0DJ+E8M/+qIYT6v/NqlP0Wa9xlB7Aex9fMKPHb8Z+63iboLftLCdT18wz47bO9leZz0t9xrtPDzMkJWTPuizdP8XHr3/I3BzmdkBb4qb8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/20 7:58 AM, Jan Kara wrote:=0A=
> +=0A=
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
> +=0A=
>   #include <linux/kernel.h>=0A=
>   #include <linux/blkdev.h>=0A=
>   #include <linux/blktrace_api.h>=0A=
> @@ -494,6 +497,16 @@ static int do_blk_trace_setup(struct request_queue *=
q, char *name, dev_t dev,=0A=
>   	 */=0A=
>   	strreplace(buts->name, '/', '_');=0A=
>   =0A=
> +	/*=0A=
> +	 * bdev can be NULL, as with scsi-generic, this is a helpful as=0A=
> +	 * we can be.=0A=
> +	 */=0A=
> +	if (q->blk_trace) {=0A=
> +		pr_warn("Concurrent blktraces are not allowed on %s\n",=0A=
> +			buts->name);=0A=
> +		return -EBUSY;=0A=
> +	}=0A=
> +=0A=
>   	bt =3D kzalloc(sizeof(*bt), GFP_KERNEL);=0A=
>   	if (!bt)=0A=
>   		return -ENOMEM;=0A=
> -- 2.16.4=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
