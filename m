Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CDC49EA7
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C361417
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 07:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhFYHUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jun 2021 03:20:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36653 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhFYHT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jun 2021 03:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624605458; x=1656141458;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SCsyjq2t5IiIaoT4nm3vSD2pvQbgn3e68P8VwS6s7RY=;
  b=i39g+mY7Cj4OHB5jddbF+UQdQlhZ9JE1FravvFkt8HYXlc0FqnLyy9Dy
   rs45vg4xGF222+qkr11rKReHHPeQAB6ltRz0VGg6SbXZhIhvwlzKMaN+m
   t4Sq0k0M3VSHSI+T0qzAkMJBPoHFz0z9yLkk21W3jSkSzrxEnR8USrBXp
   9ZJV7EhbrJvXCr511IbTWwZL6iieBJEf4xNgkAGifH1fuku90HMZhBOy3
   fT0lIOYMiLWBfdgmN5MgK3JXrmIzLB7mS3akhg63W0DU2J7aF6p5VdxdD
   KdrpBSwMA+NDt1S2Rm57VnL4bjKncsEtSs5rID8aXxeYx4tNQNzjRBcf6
   A==;
IronPort-SDR: 7dnXK5LqKVqr2LzRQI9mujf+mpcLjnMCJ/ORjiGjFZm0CpWBLjWgbVdRRfgHtw8dK1PRNOFvcE
 +KasOgRrpgHqJ2CImLirEGgn3hhC/kSqydZJLink41sBZUR8puE3YiI0UcF8gC0IWTORa/8S4S
 7J1h6Ry/LsVWCCLN1xWWSiMsfGIWJ+WopuCe1aYfewI6XJU5HObNYOhgmn/jJMhMdemTRuLvsJ
 qW4EHk/VeQH6RFjHh4P3mtl263J+UirqgeCca4u8D0cVJruT6N85aVhOabOOvkM7q3Pwg6tHTm
 sFg=
X-IronPort-AV: E=Sophos;i="5.83,298,1616428800"; 
   d="scan'208";a="172131568"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2021 15:17:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol3ax+Z/Q2eRDT8jtv0c2hp6dc7ifrwm3xloev7OJFsEOZbV6/oXPk4P+HBuJDecQhzC3f3DB4e9DLvTIfWDyMQofHUob3Hqt1IX8ycQiscgQzmZDalNCNX+MGeRbzbXYI1lddDs5NusCIAE+cFXfO87LxUVWQYmV/eyqodT/ztZv7HoSA54y8ETaMcurFh0jqfdgUhmi3BfbyDUD2FZf2LAmajWiUFX3ghaQvUpYxYQorbFN06qz8awV/kfH8I37pvjf/V0bdMvBiFd2KJBvZyZG32Eo/jheuUfMNkW1hznQfi6Y0SnwPEUQKvpvc2TscieOL8/CITb7fUXS8hMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxaIVPpzmAJOk1Me7Y5oQKe0zCwexnpcmZW37muvtkc=;
 b=LbRwseKmo2vOUz0mKe6whu9p+qqle5YDEvOPC8l2B5CojFyp1UbOO+Yd1DpPEPokMvnRJOBPMdTJye6exxhHleBXV/6XrXG+JMehefcac+lsDKAwgv1hjnuoBQSei2VSIxvsmSBrSozkzezE2pWbHriaG1owVtg9YZIVf0IEmXPtn/IefDlUAErqzsUdjbXkmiomH94kgUwjN8GgMe3g7BCdFEG17/9ssrTQDqn39tkqX8cCkOBVQF2mcFXXCSNFP4xhIonrs/HKPsluFd4qKqQaWIVAK9dTmc+RcOiqK123l6yg/iStMmGVElOT9zsxYVOPki7WGmbgSJQumIYnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxaIVPpzmAJOk1Me7Y5oQKe0zCwexnpcmZW37muvtkc=;
 b=m26kx1UIXrfS2LkJjDQVUK5kgqk+9WnrxxEwRSXmcTLlBpcBxKl91n5UetjZp08hI1bwnJ5HPC64LDpKmdoYwuovU0D+NzaX+YdxLYb1MNa4sq37rnhMkj2dn4RRJjWlUbHsO4JxmnaAh5rcysgw+BigkFgilgivjkC0kkr6Yk8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6074.namprd04.prod.outlook.com (2603:10b6:5:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Fri, 25 Jun
 2021 07:17:37 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 07:17:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: reorder and better document the __REQ_* flags
Thread-Topic: [PATCH] block: reorder and better document the __REQ_* flags
Thread-Index: AQHXaY4zN4Zr/K6t3k+qTJD0zEkUGw==
Date:   Fri, 25 Jun 2021 07:17:37 +0000
Message-ID: <DM6PR04MB70810BD375711217D5E6C571E7069@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210625064615.923862-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:65d3:f5e5:127e:5146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ede73ba-8d9d-470c-45d8-08d937a94f7e
x-ms-traffictypediagnostic: DM6PR04MB6074:
x-microsoft-antispam-prvs: <DM6PR04MB6074F0B90EFD5A06C2329E36E7069@DM6PR04MB6074.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0iifs1a+ICV49CRipJBVRjaC2CIc8Xa1ffkYpLM7ITbHGKTGswUgym0F0Vs6wqFmZi14rSyV9Ymv4nrCQ/69XaEC9oxT8I7xdcMTBUS4KoPG3yKwaymPiNvn9mJoZJASkHx7qitiWNLD2HWKEUgdAwgSs9cJPK1Nc3aotFOZgx06cWqGVqXxj0d1H5Z56teHOd8zPWU+ti3HwOHlWVsV07TRWc7cQBMd5dxVq5GOKV52UHlvwItEGWYMLBi9LcurkOhnUsXXkMQkrT79kzT+SpG5eoBUF+5mTS20gMie7mmn4FzZnDnSy+4rKpYqw88yvTuMBOQgF4AjHUU/M2xrzsBxz0Up73mp/W2x4JbeUhPZlYw7Ne5Qw1YC18GiMzFzAbkjnW0SDSuStX1gw3gJfUCXu0+gSnClDqD4/MffWsWUjdiNV5RLdmnXop/opEY7RKm11mFurjY6wbtt7KC9C22Z8EGNg9WTM2gUz3G2n2FBKeTQk5d8PZk9N7M/Eued8gTzO0v8jDfYIlinw2RMmlafjvj2iBXJ6/GKcIIn9KX9TUGmzTNX2AEz1zyIPbFv54o+p6MU3zog8151xp+BQDXz6PVJH2zEKXU/cXJt+nRXWh7hrfIWUlDsaSidI5G7v2utuV58UZRLDFdl/iGcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(9686003)(64756008)(66446008)(83380400001)(478600001)(86362001)(66556008)(71200400001)(110136005)(55016002)(66476007)(316002)(7696005)(52536014)(91956017)(8676002)(66946007)(186003)(33656002)(6506007)(4326008)(8936002)(5660300002)(53546011)(76116006)(2906002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZMYplY+lyWiKcjcqZSNLNScOcztM7dSS9Puu9pswlGCB0dbmkVzk3gcZ9a6X?=
 =?us-ascii?Q?gYIG8k/ISO5mQmFzEros09V8N7Bv8GO4jpGK2K8+4IVJnRQ5UJWlW4SzDKMS?=
 =?us-ascii?Q?JVMnnlI67+udmBFaykA0qL+V3PNr2oZfEPiym33W1NWnwHy3cXYgOvzKvFOb?=
 =?us-ascii?Q?ki8XmCsFc7+P/nhqLp1tS7xj5HHbHCYzMxx9/a+o27GMcPLQsTLXqbHwA6c7?=
 =?us-ascii?Q?iOL1BadZGtaMsgKH7dMA/hGQg30N+0+s4qgRuzw/lz2hSUUerGk7tXeSS16y?=
 =?us-ascii?Q?rXemyL8xswcyxmIAG/8fAgJIJ6IfWhHHOTXiAfAMyn8u7QZfQQwdMArU6GTd?=
 =?us-ascii?Q?ZXoiFEDSes+2uKRf8CGN02iAE8GKeaENafk8qMUljTqYjV2TTP6cdsCTr60d?=
 =?us-ascii?Q?OOAdMyiZl5tJhkmHfoU5MWItpbPS4RcLpEQ5TOYaudCXF79k07ipBB3pVah7?=
 =?us-ascii?Q?91BOSVqaBKJTAeEuHf+B5QuMVao7xpK9S0QuL1s0aNlEUs55LXU3uLNwu0R9?=
 =?us-ascii?Q?km/Opzg8TIhy6soQNXT/fR5P8AC79CYoP397xK9UI/U7yGHK9p7c9SO0Mntm?=
 =?us-ascii?Q?+ZJGeVAFucXyVGOAP2pTArkgLslI9ooQaX5hgb30wwQMAhNXQU0Py9yIGehw?=
 =?us-ascii?Q?gjT3UJ6QFB6f+2JR2mKFNiHFzUzJ+wZnrJzqDqq7Em41TqrQCDcUlxPUvjxp?=
 =?us-ascii?Q?V0VPFX3YXz0OdMS/bPXu+LzjLidlViuwgOCWdFAhkFuKOMXPvDSHKFOzpKwE?=
 =?us-ascii?Q?rMHy6dSVL+ffNf5NiPrnX86MDagW7QAD1oGjwtf4vWF1bYL2sWffPo0yZwMX?=
 =?us-ascii?Q?M05YkZ6FRQeFBuzvhKo4LskooyThFVCaVQx71LGxtrJNi/zy6HMG+8+sdVWQ?=
 =?us-ascii?Q?H6f62cspFVEbU0+OReMjJqR6pq28ArHMJCCKwPE1m8SPlwjqhBmu4COrBZT7?=
 =?us-ascii?Q?eLZv5Hql/d1L8l0kwiUfgj88hDgAmaxsUYZuhS2ExqadjWVQPJPtHZ3MftRK?=
 =?us-ascii?Q?O5hkHBRgFB1TQ3XA6URK8mGifwLyvc6DKicvIepmz6wEEVT/eGUZIKPPfc+F?=
 =?us-ascii?Q?951T+iRQ9w9sUGB/Qpc5HPLtbFd2BpxcSc1O7WrE2qmJuMuqGE5ayp5+jcqz?=
 =?us-ascii?Q?8jZ4eYCrEDWYlzxoKq9Q04CSvaL0HC2M7cZm+UqB9/w1voqa5DmvN8B0n3Wy?=
 =?us-ascii?Q?Ic80Ji02ugy2YebyjIzt/GZbKBWyBMQRdsbSopGtP7oWzkXRGNc6Jsnq/xtJ?=
 =?us-ascii?Q?XHuslzTr5ZY1spNR9iEU98EGe8dIkGmQ1ZwqIiWlu863JfwD+y/y7mJrN2MI?=
 =?us-ascii?Q?Hzd9kMUFZ7ka4ay7/Rim/wm9QReRxGFCXiBBd1jX/100SV09BwyrkSxzXdgr?=
 =?us-ascii?Q?Zi49GuV/CBov7VDqX0avzGDvmFUaxSykj5yTZHNStm2fE8DCnA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ede73ba-8d9d-470c-45d8-08d937a94f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 07:17:37.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bchffN4/oXCXojLexljGg0wOachQzNkmhyP3+7+7SDieJZ76tDTterwTuuf8xOyVkxfoNRf8WU+AWuBfBgMyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6074
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/25 15:49, Christoph Hellwig wrote:=0A=
> Keep the op-specific flag last and make a little more sense of the=0A=
> comments.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  include/linux/blk_types.h | 11 +++++------=0A=
>  1 file changed, 5 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index db61f7df1823..c80756e9f16e 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -381,15 +381,14 @@ enum req_flag_bits {=0A=
>  	 * work item to avoid such priority inversions.=0A=
>  	 */=0A=
>  	__REQ_CGROUP_PUNT,=0A=
> +	__REQ_HIPRI,		/* High Priority I/O (polled) */=0A=
=0A=
REQ_HIPRI requests may not have an actual high priority assigned (rq->iopri=
o).=0A=
So can we change the comment to only say "/* Polled I/O */".=0A=
Polled I/O is indeed semantically somewhat equivalent to a high priority=0A=
request, but I prefer we clearly distinguish it from it the ioprio stuff.=
=0A=
=0A=
> +	__REQ_SWAP,		/* swap I/O */=0A=
>  =0A=
> -	/* command specific flags for REQ_OP_WRITE_ZEROES: */=0A=
> -	__REQ_NOUNMAP,		/* do not free blocks when zeroing */=0A=
> +	__REQ_DRV,		/* for driver use */=0A=
>  =0A=
> -	__REQ_HIPRI,=0A=
> +	/* command specific flag for REQ_OP_WRITE_ZEROES: */=0A=
> +	__REQ_NOUNMAP,		/* do not free blocks when zeroing */=0A=
>  =0A=
> -	/* for driver use */=0A=
> -	__REQ_DRV,=0A=
> -	__REQ_SWAP,		/* swapping request. */=0A=
>  	__REQ_NR_BITS,		/* stops here */=0A=
>  };=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
