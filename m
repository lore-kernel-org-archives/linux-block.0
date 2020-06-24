Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3499C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 00:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7294720CC7
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 00:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kCg0qnTO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fvew9dH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbgFXAqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:46:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47584 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgFXAqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 20:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592959605; x=1624495605;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5Rk7kvqew6mYPNFRR+jnF7tbuvKdlMwjbf6naqWi66M=;
  b=kCg0qnTOcgWSqxpA6HPrJsWLbX3XTeEqdND5MiMxedJAxr4GB2iLjm91
   mm6W4VfMloXTHnO7pQNQkK28nyoIHICOkXeeRZNy7sEwizcGTnoFmrBIV
   ngni3UzVJBjDpeHTP/2/FSRNgId/dMzitS0qPQnC3izELZOpj/ywWrya/
   jJcsssCX/8SPQ90mC6h0z01GSUsxTymUsLiCGCus/BQiHCxEiFPziPLtH
   nPEtFveB1soWQHiLbSG130OB4jH5kBNS4ermB4RDKHhjuCREnyht73DfW
   IaZsLayLb9HN4FoVW/zYwSOXc3mV9395UE9L6KEHwdbyunvlefvtAv67b
   w==;
IronPort-SDR: 3P4MlaaiIUxrgk2WMfvPbcIn0NhgVuESfdhgJ6Iu1dlbCCE7Xx/3B6XbrhTie9Y971Lg41ldLC
 +9FVFJL5OlJSEc89P3o9Khl51Gl6B91LS24+5N44Q6oOQxu979GRXRWCjx/CmrkPSyt2skLVeq
 rO1HwwkNxGVvmb01hldI8tgo/jgPjgqGoL152xbH06EKSBex9Gaodt3QsC/hIANYc9tGoaC4EJ
 G1U+WaD78psg7QxBcPc2FKux+oL8QxvuF0eicDVH+X45s5+D20ETo4SClh6n7BoWV+GmJNTcvI
 7d0=
X-IronPort-AV: E=Sophos;i="5.75,273,1589212800"; 
   d="scan'208";a="243748347"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 08:46:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cla42P9yUeHie+fzFx37ZYfPsaQtsX5Z4jPM6f9KN6XQ15ccbARgCf4huc5i1FdrX5RhG/FTFNtOF8ut2T/hpArR7KxjN509XBHzazDlyFGVDfbXfltBC3F2BwOmNgX/5VDoB9sHpvNrKJkudWrw//3OSldyW5G4seXz2DNVpwlmk1U933yPnKlNabY2F2iJrifj7lb1F36Kl6yhOT0X4lEt8fmmrQ+rNzK6xaVM5Dh7kpqvgiq1/y4khZahC9dd0fpymyZlF5DqWMetLSjKdotqA636/KZudWzxLRSJKlx5Y7N2xSdjJj9Yqf9MWGrvB3erUPcy/9oo9gSRcPOmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwZkzGcKCqpEbmNTJgY6CNtlCyvyu7UDgnkkV7r0saU=;
 b=SzvFDveOpVBWLhyuMMeA9BISG4qMWUlL50g6zE4f8c9t4vLi8PvA90fNdTf7nuzWWWCp9oQQWR6oCwjYIUYSJ7/DI7QNVk4UglzQy/2s76zm5nVMNiPH41hcefxPbszKsi/QC/0yuwOH17Q5CTfs11pOLSHtXglwQEWlA9CRTiZb1TB78zqK3YgTA7hg/N3V+ogwpveM4smRq5asFPWqROcxaOhl3mEOKbAIZZbhGFEzmXjiyQb/SiTyMFgsekj5GXnfKQELTZLM3gLdS0Z+M78DzzhQOzE2dwhf6fVR+xTHqWpW9S0ek6uRq9/C1TZqxqrZ0AVcoDcyrU9DlfRpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwZkzGcKCqpEbmNTJgY6CNtlCyvyu7UDgnkkV7r0saU=;
 b=Fvew9dH89nSEHfE1CpNpe4mj1pn41zrezV+AefprTeoPNWSMKQzo/3EdLjIHY94njMoQLHpevaLIKPqav5q5L23DrklqvxiX4Rc+bmUgeJXMDZp4EygkvbH+oROzhgeNccj+KK7dox0un5KzRnGP/qq2JrU7HLDf06biFDjFHrc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.26; Wed, 24 Jun
 2020 00:46:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 00:46:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "satyat@google.com" <satyat@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: move request_queue member docs to kdoc
Thread-Topic: [PATCH 2/2] block: move request_queue member docs to kdoc
Thread-Index: AQHWSaocy+swFSiiDEyuSPmUryXI/Q==
Date:   Wed, 24 Jun 2020 00:46:38 +0000
Message-ID: <CY4PR04MB3751713BBBC1291A0D3A6A21E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200623220311.8033-1-mcgrof@kernel.org>
 <20200623220311.8033-3-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dca8dd88-b95b-4f2b-1980-08d817d80d9f
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-microsoft-antispam-prvs: <CY4PR04MB09682BBF3921DA31439D1234E7950@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knEMuBNIvF14Q6OrjEQTydRGGso87on0/xoypNlyIF+VhfoXAJA579wYudqPntflChlF7/k3b1io8koj16oHfi+YLSRsl1gcdGNPT4t3naC4VCPMI+jLjjGRe2s1qS+Iss6rA/o5xgpUz6dOliILLRlzADMKXWEgw9HopbVVSTymzxURekPpkKKhFg4qjxwXT2Rtxwnr9nbg+s+gKuTZOWP/AEPIT3BZ5ZiPotrPLLTIAn6PrZJHa6u33y3PrKxVcM/v9i25l/H23sJRKC4dSXQ0SWQjxsRWHc6oo6t+LiiOw6+sZSoOD2oBKDoEyCQNgBk+5tLzF4SzE+Lb7w2m0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(54906003)(478600001)(110136005)(4326008)(316002)(64756008)(66556008)(66476007)(2906002)(66946007)(66446008)(76116006)(91956017)(5660300002)(7696005)(52536014)(53546011)(6506007)(55016002)(186003)(86362001)(33656002)(83380400001)(8936002)(71200400001)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eveHczcjx65NUwsk+Z2JyQshfCTXcvW7G8KeWfVYbMAhft9MekaPC5Go0vfPYFVoy7T2K2qG7Cl7RQ0w4mDkQWTdQfQ1ycPLzIDeOpysK9n1rSyVHcXpaG9whHQq65JY7cUKg5xofjql6Bo+5nT6h87LOpYeYlq63SWqH8XcWKe8cSpsYqFgKdIY/F6RWheW8OMk+GQYJBmq6J73Ppbf4nmjWwhTidx8mdd8idNjLm8xd3DMEljsIZC+8qrsg57MLD1wVv+DDPPt2z+LmOQ05kebduVhJKLfwJn+3PJL1G5Jop/vmXLsrWdF7HDisYIVX++42YRX6Qe/eMNx8kF9rGkTBq6ngWDr/+aTJQMW2TylMHpQxLzU7IOHdctdg4fZPD+cuSFK557yWvmSVTQsVZhTdZmfyCC3SIWsjPSi14hZsyb2bdr9GjjpOtgUm2HRUmU7FlKGcKvRyJd5boQmgvGj/k/hae9tJGmgM6B/U0h5eeTN+e6juN/iEOLNld3a
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca8dd88-b95b-4f2b-1980-08d817d80d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 00:46:38.0601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PQM17GQAG3AaQN+hwfwDDJn/UchHntS2NH0Gx0/otpkI56m27wGzwMuRDn36pJO5RJ4nTECRrvGqJYlAWBzPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/24 7:03, Luis Chamberlain wrote:=0A=
> Now that we have a template, expand on the kdoc form for=0A=
> the request_queue data structure with documentation from=0A=
> the rest of the members, *only* for information we already=0A=
> had.=0A=
> =0A=
> This does not add any new documentation. This just shifts=0A=
> documentation to kdoc form.=0A=
> =0A=
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>=0A=
> ---=0A=
>  include/linux/blkdev.h | 139 ++++++++++++-----------------------------=
=0A=
>  1 file changed, 40 insertions(+), 99 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index ea319c2b0593..d30bfef893b9 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -396,8 +396,38 @@ static inline int blkdev_zone_mgmt_ioctl(struct bloc=
k_device *bdev,=0A=
>  =0A=
>  /**=0A=
>   * struct request_queue - block device driver request queue=0A=
> + * @queue_ctx: software queue context=0A=
> + * @queue_hw_ctx: hw dispatch queues=0A=
> + * @queuedata: the queue owner gets to use this for whatever they like.=
=0A=
> + *	ll_rw_blk doesn't touch it.=0A=
> + * @queue_flags: various queue flags, see %QUEUE_* below=0A=
> + * @pm_only: Number of contexts that have called blk_set_pm_only(). If t=
his=0A=
> + *	counter is above zero then only %RQF_PM and %RQF_PREEMPT requests are=
=0A=
> + *	processed.=0A=
> + * @id: ida allocated id for this queue.  Used to index queues from ioct=
x.=0A=
> + * @bounce_gfp: queue needs bounce pages for pages above this limit=0A=
> + * @kobj: queue kobject=0A=
> + * @mq_kobj: mq queue kobject=0A=
> + * @nr_requests: maximum number of of requests=0A=
> + * @ksm: Inline crypto capabilities=0A=
> + * @nr_zones:=0A=
=0A=
Above line is not needed, no ?=0A=
=0A=
> + * @nr_zones: total number of zones of the device. This is always 0 for =
regular=0A=
> + *	block devices.=0A=
=0A=
May be: "total number of zones for a zoned block device. This is..."=0A=
=0A=
> + * @conv_zones_bitmap: bitmap of nr_zones bits which indicates if a zone=
=0A=
> + *	is conventional (bit set) or sequential (bit clear).=0A=
> + * @seq_zones_wlock: bitmap of nr_zones bits which indicates if a zone=
=0A=
> + *	is write locked, that is, if a write request targeting the zone was=
=0A=
> + *	dispatched.=0A=
> + * @debugfs_mutex: used to protect access to the @ebugfs_dir=0A=
>   * @debugfs_mutex: used to protect access to the @debugfs_dir=0A=
>   * @blk_trace: used by blktrace to keep track of setup / tracing=0A=
> + * @fq: for flush operations=0A=
> + * @td: throttle data=0A=
> + * @unused_hctx_list: list used for reusing dead hctx instance in case o=
f=0A=
> + *	updating nr_hw_queues.=0A=
> + * @unused_hctx_lock: used to protect the @unused_hctx_list=0A=
> + * @mq_freeze_lock: protects concurrent access to q_usage_counter by=0A=
> + *	percpu_ref_kill() and percpu_ref_reinit().=0A=
>   * @debugfs_dir: directory created to place debugfs information. This is=
 always=0A=
>   *	created for make_request and request-based block drivers upon=0A=
>   *	initialization. blktrace requires for this directory to be created,=
=0A=
> @@ -413,67 +443,35 @@ static inline int blkdev_zone_mgmt_ioctl(struct blo=
ck_device *bdev,=0A=
>   *   o custom solutions such as scsi-generic=0A=
>   *=0A=
>   * All partitions share the same request_queue data structure.=0A=
> + *=0A=
> + * Zoned block device dispatch control is managed by the fields @nr_zone=
s,=0A=
> + * @conv_zones_bitmap and @seq_zones_wlock. These fields are fields are>=
 + * initialized by the low level device driver (e.g. scsi/sd.c).  Stacking=
=0A=
> + * drivers (device mappers) may or may not initialize these fields.=0A=
> + * Reads of this information must be protected with blk_queue_enter() /=
=0A=
> + * blk_queue_exit(). Modifying this information is only allowed while=0A=
> + * no requests are being processed. See also blk_mq_freeze_queue() and=
=0A=
> + * blk_mq_unfreeze_queue().=0A=
=0A=
Ooops... This is outdated... This should be:=0A=
=0A=
* Dispatch of write commands to zoned block devices is controlled using the=
=0A=
* fields @nr_zones, @conv_zones_bitmap and @seq_zones_wlock. These fields a=
re=0A=
* initialized using the blk_revalidate_disk_zones() function from the level=
=0A=
* request based device drivers (e.g. scsi/sd.c).  BIO based drivers, if nee=
ded,=0A=
* can initialize these fields directly. Accesses to these fields must be=0A=
* protected with blk_queue_enter() / blk_queue_exit(). Modification of the=
=0A=
* @nr_zones field and reallocation of the @conv_zones_bitmap and=0A=
* @seq_zones_wlock bitmaps is only allowed while no requests are being=0A=
* processed. See also blk_mq_freeze_queue() and blk_mq_unfreeze_queue().=0A=
=0A=
>   */=0A=
>  struct request_queue {=0A=
>  	struct request		*last_merge;=0A=
>  	struct elevator_queue	*elevator;=0A=
> -=0A=
>  	struct blk_queue_stats	*stats;=0A=
>  	struct rq_qos		*rq_qos;=0A=
> -=0A=
>  	make_request_fn		*make_request_fn;=0A=
> -=0A=
>  	const struct blk_mq_ops	*mq_ops;=0A=
> -=0A=
> -	/* sw queues */=0A=
>  	struct blk_mq_ctx __percpu	*queue_ctx;=0A=
> -=0A=
>  	unsigned int		queue_depth;=0A=
> -=0A=
> -	/* hw dispatch queues */=0A=
>  	struct blk_mq_hw_ctx	**queue_hw_ctx;=0A=
>  	unsigned int		nr_hw_queues;=0A=
> -=0A=
>  	struct backing_dev_info	*backing_dev_info;=0A=
> -=0A=
> -	/*=0A=
> -	 * The queue owner gets to use this for whatever they like.=0A=
> -	 * ll_rw_blk doesn't touch it.=0A=
> -	 */=0A=
>  	void			*queuedata;=0A=
> -=0A=
> -	/*=0A=
> -	 * various queue flags, see QUEUE_* below=0A=
> -	 */=0A=
>  	unsigned long		queue_flags;=0A=
> -	/*=0A=
> -	 * Number of contexts that have called blk_set_pm_only(). If this=0A=
> -	 * counter is above zero then only RQF_PM and RQF_PREEMPT requests are=
=0A=
> -	 * processed.=0A=
> -	 */=0A=
>  	atomic_t		pm_only;=0A=
> -=0A=
> -	/*=0A=
> -	 * ida allocated id for this queue.  Used to index queues from=0A=
> -	 * ioctx.=0A=
> -	 */=0A=
>  	int			id;=0A=
> -=0A=
> -	/*=0A=
> -	 * queue needs bounce pages for pages above this limit=0A=
> -	 */=0A=
>  	gfp_t			bounce_gfp;=0A=
> -=0A=
>  	spinlock_t		queue_lock;=0A=
> -=0A=
> -	/*=0A=
> -	 * queue kobject=0A=
> -	 */=0A=
>  	struct kobject kobj;=0A=
> -=0A=
> -	/*=0A=
> -	 * mq queue kobject=0A=
> -	 */=0A=
>  	struct kobject *mq_kobj;=0A=
>  =0A=
>  #ifdef  CONFIG_BLK_DEV_INTEGRITY=0A=
> @@ -485,66 +483,32 @@ struct request_queue {=0A=
>  	int			rpm_status;=0A=
>  	unsigned int		nr_pending;=0A=
>  #endif=0A=
> -=0A=
> -	/*=0A=
> -	 * queue settings=0A=
> -	 */=0A=
> -	unsigned long		nr_requests;	/* Max # of requests */=0A=
> -=0A=
> +	unsigned long		nr_requests;=0A=
>  	unsigned int		dma_pad_mask;=0A=
>  	unsigned int		dma_alignment;=0A=
> -=0A=
>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION=0A=
> -	/* Inline crypto capabilities */=0A=
>  	struct blk_keyslot_manager *ksm;=0A=
>  #endif=0A=
> -=0A=
>  	unsigned int		rq_timeout;=0A=
>  	int			poll_nsec;=0A=
> -=0A=
>  	struct blk_stat_callback	*poll_cb;=0A=
>  	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];=0A=
> -=0A=
>  	struct timer_list	timeout;=0A=
>  	struct work_struct	timeout_work;=0A=
> -=0A=
>  	struct list_head	icq_list;=0A=
>  #ifdef CONFIG_BLK_CGROUP=0A=
>  	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);=0A=
>  	struct blkcg_gq		*root_blkg;=0A=
>  	struct list_head	blkg_list;=0A=
>  #endif=0A=
> -=0A=
>  	struct queue_limits	limits;=0A=
> -=0A=
>  	unsigned int		required_elevator_features;=0A=
> -=0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
> -	/*=0A=
> -	 * Zoned block device information for request dispatch control.=0A=
> -	 * nr_zones is the total number of zones of the device. This is always=
=0A=
> -	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zon=
es=0A=
> -	 * bits which indicates if a zone is conventional (bit set) or=0A=
> -	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones=0A=
> -	 * bits which indicates if a zone is write locked, that is, if a write=
=0A=
> -	 * request targeting the zone was dispatched. All three fields are=0A=
> -	 * initialized by the low level device driver (e.g. scsi/sd.c).=0A=
> -	 * Stacking drivers (device mappers) may or may not initialize=0A=
> -	 * these fields.=0A=
> -	 *=0A=
> -	 * Reads of this information must be protected with blk_queue_enter() /=
=0A=
> -	 * blk_queue_exit(). Modifying this information is only allowed while=
=0A=
> -	 * no requests are being processed. See also blk_mq_freeze_queue() and=
=0A=
> -	 * blk_mq_unfreeze_queue().=0A=
> -	 */=0A=
>  	unsigned int		nr_zones;=0A=
>  	unsigned long		*conv_zones_bitmap;=0A=
>  	unsigned long		*seq_zones_wlock;=0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
> -	/*=0A=
> -	 * sg stuff=0A=
> -	 */=0A=
>  	unsigned int		sg_timeout;=0A=
>  	unsigned int		sg_reserved_size;=0A=
>  	int			node;=0A=
> @@ -552,59 +516,36 @@ struct request_queue {=0A=
>  #ifdef CONFIG_BLK_DEV_IO_TRACE=0A=
>  	struct blk_trace __rcu	*blk_trace;=0A=
>  #endif=0A=
> -	/*=0A=
> -	 * for flush operations=0A=
> -	 */=0A=
>  	struct blk_flush_queue	*fq;=0A=
> -=0A=
>  	struct list_head	requeue_list;=0A=
>  	spinlock_t		requeue_lock;=0A=
>  	struct delayed_work	requeue_work;=0A=
> -=0A=
>  	struct mutex		sysfs_lock;=0A=
>  	struct mutex		sysfs_dir_lock;=0A=
> -=0A=
> -	/*=0A=
> -	 * for reusing dead hctx instance in case of updating=0A=
> -	 * nr_hw_queues=0A=
> -	 */=0A=
>  	struct list_head	unused_hctx_list;=0A=
>  	spinlock_t		unused_hctx_lock;=0A=
> -=0A=
>  	int			mq_freeze_depth;=0A=
> -=0A=
>  #if defined(CONFIG_BLK_DEV_BSG)=0A=
>  	struct bsg_class_device bsg_dev;=0A=
>  #endif=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_THROTTLING=0A=
> -	/* Throttle data */=0A=
>  	struct throtl_data *td;=0A=
>  #endif=0A=
>  	struct rcu_head		rcu_head;=0A=
>  	wait_queue_head_t	mq_freeze_wq;=0A=
> -	/*=0A=
> -	 * Protect concurrent access to q_usage_counter by=0A=
> -	 * percpu_ref_kill() and percpu_ref_reinit().=0A=
> -	 */=0A=
>  	struct mutex		mq_freeze_lock;=0A=
>  	struct percpu_ref	q_usage_counter;=0A=
> -=0A=
>  	struct blk_mq_tag_set	*tag_set;=0A=
>  	struct list_head	tag_set_list;=0A=
>  	struct bio_set		bio_split;=0A=
> -=0A=
>  	struct dentry		*debugfs_dir;=0A=
> -=0A=
>  #ifdef CONFIG_BLK_DEBUG_FS=0A=
>  	struct dentry		*sched_debugfs_dir;=0A=
>  	struct dentry		*rqos_debugfs_dir;=0A=
>  #endif=0A=
> -=0A=
>  	bool			mq_sysfs_init_done;=0A=
> -=0A=
>  	size_t			cmd_size;=0A=
> -=0A=
>  #define BLK_MAX_WRITE_HINTS	5=0A=
>  	u64			write_hints[BLK_MAX_WRITE_HINTS];=0A=
>  };=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
