Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A34C001DB
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 11:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjHJLvo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjHJLvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 07:51:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85C2E4D
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691668302; x=1723204302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=apscChxlg7cvGLrYC+fEGMH8yNJxqEBD8K9QS/3I6QI=;
  b=Jo/YL0GP34T/UECFxNnOUAz0Yr/RuCY0K5pcdpJPug79wmSqfI1pbBx5
   CSDexUyMIPFNUFLOWWVfcUqKbn0G7R8fDW9q6QeoKYFqHJ4ffE1e2esJG
   sm1nRcLAolrlU0dtfpWP3CWvdFWIfw76QcBhFPPC+5VMLxRsuwYtNQgg9
   wgfg7uP9NEKOBNyKdTz9nYDeGQplqx54Uw+ln3Nmd3pJMq0f8SMkbedOc
   ci12YbDOhFw5ceLG00ITGND+KTDlT5lnT9FHCY71smsROIEQXrY2qyg/h
   vgdkJXq2h+dztr/tNpI8qKD43337PtJYJy2wobB1BLDeRmblsq17FwCnr
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="238951633"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 19:51:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFyIwmIDvfR3IZ1/ket8PYUKb8pTcH6qXFUzi9c5C8yYEnBXCwHRD0iVqfLPG5Cl4HWnHpUl1J/ESPYzxv0hzdlYz2zSgsW29nJm/+QWYSvh6kVUGLkP10CRUBiVCMc6h8TNJAkhmqfXXUHnCjw2f0vYGP1bGdj4GYuWtt3bnko5puFAEV2ZTf8i6f29JSuEXJkzEedQaeZ9WrHP2qhIkLPa8+Cmf7dFP4AFVGrb5NRYAXoQaAec+8PeIednKZbYd6GSjLv9rQFdLfEuhDaIW3jEIuAqydNZXzRP/jmXNZayvo7d0ALcwfxvzU2Txod0Yt6VV1HAxVzSO6zBsh2MdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L1DLnLNQBK3r3QoL2M0mKf43dSXQ/a0KaKQKK7Rlkg=;
 b=Jx1my5DqqyJPN5oZtjM9LsvgF5zKnP5fgWUqrSRXW+w66UcQBQrw4ogKl212hc9WOuov4aAIQZ9AUnicQy/IOA9t5XskDmBfUdyr4xtK9zEYXCEZBL/XPWRBvodhejJGLeSxvmTiX3WAk8G+k+D9H0sBp/9fPWnCcdEHXaK0/UTuCLmRgpd3jIzvKY8za83OuHSWhOtbqeeHf/ik8AX2ri772RLETqNUONAO8ezn3fjtR5uW/9BVc5RLW1gcWz43gEJsDOJhpLwJbPOJg0yY+4r7bV5CRcRErUbG6V/ZB4irPI3rcs1ENQqPfctqtiKDJypw8Ygq82KHUGyjRLNuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L1DLnLNQBK3r3QoL2M0mKf43dSXQ/a0KaKQKK7Rlkg=;
 b=n3XX/ayYJ+nHKU+5A79eXM1L1lxdrDvjkBrhGB0ioTLIc5vLjhvoSXEBXQ0G71qP8MAPprsm+0U+n/iSu5YhFplvpUFLH+P6Ah/zCwI9wrektaK+oSm1UTFQ62zEQiJxqL41eWaLdOK2HQ3p8mn+gYDvywloEMnHrhbuJrkuM80=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7390.namprd04.prod.outlook.com (2603:10b6:a03:293::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:51:40 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:51:39 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHZy4EFIu4e1EEyOE+gQcy8wjtL4A==
Date:   Thu, 10 Aug 2023 11:51:38 +0000
Message-ID: <ZNTPSQTDOgr7Ojn+@x1-carbon>
References: <20230810092057.288220-1-ming.lei@redhat.com>
In-Reply-To: <20230810092057.288220-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7390:EE_
x-ms-office365-filtering-correlation-id: a942b233-1b7f-49c4-7324-08db99982821
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZs2wEJyzgFjDnLo7cnekLpQA7wdMgc0J1k7tZvaxr8xSAV6OhNvYyW9tKrpRovRuD/amE9IJ0COmZnhSUzd87UWLNvjbn+DXOvU6Qx+7NCnUUDYg5lxU7QqOEsRfuX/kUUDtGqUIb0cRLR3h9aHbvlsvEkSbzK+9QPQAtfgBtLNTA8yP0WIJxSLm+vQj76K4DO8fY+JvHWrXzq+QWdKQCF73O9EOFgE6X9iVMzZhe5Antg3ytYJkM04X6cbrCnvlC16NpKgbAJAckA2WavG0YYsSIdqVL6r/qz/eL9rM/krhOmW+MiJWAh4Wo8rsSOilrqax62/Lvvio/FwzNh0a1L9M2XwJtkABxKiygcz/3HrwYCziQiTWyDVQIb35IDuaJrFuQsDoQHW7rmr81FCm5HeS8wAjZ5BOsjgGEhlYGnzFQIzx/AMpFYHZnxbKDXs/hlrMlv1Wnm7E4SDyw++f4tEjI2GtMlFfY5sx3rAHrIaZ0ss298rG9OQFxA/i4THGQwwg7DWM/cy84R1QxhXjqGLzQJGAfIj/yj+uhG3xcMZh19py1lN3Hgu8pIVODjkBdCNGbCGjd0xs9DVN9wwx4svUbYgRfJkB/MmLLm5dBiPbE5H0G6c96BX6A6tmlA96FLA/XVLWk9P1ZYgKD7lOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(1800799006)(451199021)(186006)(83380400001)(2906002)(41300700001)(6486002)(966005)(71200400001)(54906003)(316002)(4326008)(6916009)(33716001)(66946007)(76116006)(82960400001)(38070700005)(66556008)(66446008)(91956017)(64756008)(66476007)(122000001)(9686003)(6512007)(86362001)(38100700002)(5660300002)(478600001)(8936002)(8676002)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fmXAKk1TT5baB4bfscPyeZkIV4wTrBxN5VIT7O1PPmC2ZyLHE2v1W5q7BO3T?=
 =?us-ascii?Q?wxeeASR9zkL6iGD9kfUfhoUq61ycEOkQ6+Ic1ozqYTexl31ZPDwCyCS0CzFL?=
 =?us-ascii?Q?gWW6/FlNGZ3dwVfLXTMmb2S5Lo6/wKWKXLuw7r22YSkPKeSKN+46W27ca+Hl?=
 =?us-ascii?Q?3eTnIJQjVyzflTLkFhvq/As2F4QZhIQwiAaNUHorz9yV5kVhR380u0hKauw1?=
 =?us-ascii?Q?NOYZRFI8Pb2WfYcstVOupiA+6l32N7pXMwAJskcsMpBfAhV69obvrD8uviv5?=
 =?us-ascii?Q?QDI3YHZaNqsoWKDL96P3nVvIw2nneTo3979oaFzdJzzzTXjeqzRAHqvCP7mQ?=
 =?us-ascii?Q?+D0rHVlmWqDOR9s7naItoEKAwdartFSJhDxvlWnV6Niacoqd1LstogbhTQhc?=
 =?us-ascii?Q?06LxZ/X42Usd307Kqm6V3BjF0E6srug9/qOxp0G8FQCP9VamxgpkfG2Aooja?=
 =?us-ascii?Q?takBj8vfRAQfj9PJJFuJrntXClHdTUc4GZxEczdbtEoaGk+8yL7Ot6Ime9f1?=
 =?us-ascii?Q?WaJoqwAEK8K2zdC4IEuExoJZz0Mg2qB8OT0niicEcjxjtzrQMvKAfepzX8tz?=
 =?us-ascii?Q?V8Xg0bvgUJcV5+HxUptjaEwPy9nb7EHWHJTZVOpY7TqoX+rbDIAhq/UsXlty?=
 =?us-ascii?Q?RMqwDXscpLbm5LZpWVg1G2sJSrhaXP7qvXujgPVEVLFr17DKohbguz+etmsL?=
 =?us-ascii?Q?Q/+r/0jcIuwY0QDaCU88N4Vcbm3LN2sovwNrvfyeFERNgHe00H7sf3X2AeeG?=
 =?us-ascii?Q?f+uH2+F3mhH7RRdC8vj8MIVDmQijJ+DDVPVs59c3kv34YmxCcge+DUTT+j+C?=
 =?us-ascii?Q?O8ZYsuU37WIjUQTtrRLVqK7TUVMI02nv2/wQmrMt+5MFgMRP4L7lkEC9JHJR?=
 =?us-ascii?Q?7A1LrwFiHMTbwE4AECmDF337e1GqjzviOePO9FzElRz0guSt8UEmLKe46zxD?=
 =?us-ascii?Q?srgCCk53AmkE/IL2o0aKZGmrO0w0NYeAgcLltzr7/KHxHA8+gDmgf4k5fAvR?=
 =?us-ascii?Q?/C0pYbcL7G8cAYN+uj27+wiB8/rmaK2gUPPrHDr+qzBiIN9LQv9bvyQNe2+V?=
 =?us-ascii?Q?pytIfikOJr62ChjApmXUrwy+bub2/gQ9OhcpcbYy8K7MbUhTFDgOMlHRBSU7?=
 =?us-ascii?Q?/qePchlA4kOgPBElGUpEI5BMMrnd3/wozy0B+xxZTyq7UFrhOlJfb6YR+Z5R?=
 =?us-ascii?Q?pRDGyjnbGTj6RU2TfjYxSlG37iCrlJCexnu+9zOQB5z/HAIsdpcP+I1a2gN6?=
 =?us-ascii?Q?YQOXYsa7Iihwtlgc3MC1bahunBOiPJvntVOkYF+vBpYWZMoR+NherGRvijGi?=
 =?us-ascii?Q?Zm9MXyUe6PR7bCjtHWuGr8ZOTlEFWiat6zb4G8aUj8CH1Ns74dvWaW3oOUya?=
 =?us-ascii?Q?Hr1qYw9nLSNPlis1kLATrbgJEiT6zeh+7NESo3I4rYDhH19VttoqLH4oCGxB?=
 =?us-ascii?Q?sW3E7NVVpwmndgtHnIxipU2jOqIhMFEVP9n9IGL4gls22p0VTOxY9Fjad5Uy?=
 =?us-ascii?Q?SJ5lpdgm9OiNMFiD7YXv6Qgm/QybOwqDZcwryF1JQlFDlPwgLbk/uJX73uA/?=
 =?us-ascii?Q?/YZgcyMw+T6C8MCHq9YWtqdEVzBvH1SzZ04uwrTH3qJroEyM4CwQwiiDMUHl?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4705513304BF8D469D5BD2B83D150AAE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pqFZqX1Tg//hSqJiDpTB5m7G4D/acnROgIw4JuIq69HeTdxkmWp3r/u2Faj8Y2Q+ESossEElnGLZsJowSZ6d/CCSGiYAHBxvSotxj/d5WYoOs1PDcaTPXb448jhTs9QDerNNZLGuaxEpexj+JT3h6wtip4ri3RQsQiVWaJYzC+GODMflLzPBMDbKPCfP5G0Z9KNjFEVX7JE367TNXfE1LjUzjtOnKF4ZUyEVvEV8/pEi+E9vaV+G5HOCzrUb/zEe5JwpVGlK+GN3E5hzq3yUUXDAUQnwdGXZDfMUgDToLp753tJzE89iNz/qFxfjzodHahk7NunfciaKXmqv0e19ej2XxaoAXWY324+jySSivz3sk2J7Vd0xbOrLp8kkUwtKtcX0ZSwYPPV9+ufbbqaHNbCokp3oEDy4JA0E4Pdc+cXr5qbcNiyFD4AB9MGKBKqfu0AnJux5gqi0q03ormI3xhyJ6bKygqK0ipl+fBjSbxg8jOu5WGz3wtY+kn8E8yNvMm1WCSQJ9Ua+6TXk5oomprhApIQJQHpO6jXDs2NPICVJ/RXwstTEbqL/L5l06AGQnjQYFEBPxmz0nE/sjJ6EfPCgUBClOst2eNjwsnUzTHUjtnjPC6jREc029f7vuwIejSsEExnrbJMCDyC80tUOFn8qC2r+HCtaJK/wSsh9jOVkQuM4vUA7olWEgFZ5W/frqIzePygUWd9ppaSdCrbD21C1sVRBVNMly6vJa7qjTISuZw0lvIG5xb44SMhNnzIRcvqRN9IcVU/7Gb53ohnBgrfauPljait8WOaY6k6H7yRwDrJTm0FVaT9M2PUrWA0+ywZ0p7M7SxB0fnUyRCHUR/CFhg5p9AqBGQn1S3/ymjDjl1sNnLi1ymsaruh3/mVNoqYWuBw/ijlFbu6mre0ODQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a942b233-1b7f-49c4-7324-08db99982821
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 11:51:39.0308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lYpj6+GkwvrIfXBynLHLXiBdi2maprmoj6lMEBo7jVddRTkk62QgbrKCR8PaAsEyUfBVduTh9fjdGVJFB9+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7390
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming,

On Thu, Aug 10, 2023 at 05:20:57PM +0800, Ming Lei wrote:
> There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everyth=
ing
> is actually handled in userspace, not mention it is pretty easy to suppor=
t
> RESET_ALL.
>=20
> So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.
>=20
> Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
> libublk-rs based ublk-zoned target prototype[2], follows command line
> for creating ublk-zoned:
>=20
> 	cargo run --example zoned -- add -1 1024	# add $dev_id $DEV_SIZE
>=20
> [1] https://github.com/westerndigitalcorporation/libzbc
> [2] https://github.com/ming1/libublk-rs/tree/zoned.v2
>=20
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 5 ++++-
>  include/uapi/linux/ublk_cmd.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 109a5b17537d..939e4584485b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -251,6 +251,7 @@ static int ublk_dev_param_zoned_apply(struct ublk_dev=
ice *ub)
>  	const struct ublk_param_zoned *p =3D &ub->params.zoned;
> =20
>  	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
>  	blk_queue_required_elevator_features(ub->ub_disk->queue,
>  					     ELEVATOR_F_ZBD_SEQ_WRITE);
>  	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> @@ -393,6 +394,9 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_=
queue *ubq,
>  	case REQ_OP_ZONE_APPEND:
>  		ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
>  		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		ublk_op =3D UBLK_IO_OP_ZONE_RESET_ALL;
> +		break;
>  	case REQ_OP_DRV_IN:
>  		ublk_op =3D pdu->operation;
>  		switch (ublk_op) {
> @@ -404,7 +408,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_=
queue *ubq,
>  		default:
>  			return BLK_STS_IOERR;
>  		}
> -	case REQ_OP_ZONE_RESET_ALL:
>  	case REQ_OP_DRV_OUT:
>  		/* We do not support reset_all and drv_out */

I think that you should also drop reset_all from this comment.


Kind regards,
Niklas=
