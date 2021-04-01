Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B66C433B4
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 06:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD1460BBB
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 06:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDAGX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:23:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9128 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhDAGXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 02:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617258183; x=1648794183;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=x6nL0lcrTozojIJ7HWDUay3HOY1ldF37taqk+LrEI0U=;
  b=iXVUNX9RVH07IdHIZJVagW2OAKIuGEfmnBEuwAryf0O/Lwuxj0ASmbVA
   mSql4j+itll3WYA9xxScvwKVr94//D7Le7yQxsi8ZKM9aeTmhnPXVVUIH
   bwb2ljnGdjiTagYHJy6GUcl3Zo9SJt08S/yuIUu19vPEAT4WNb2+AripF
   yqEJCGZgeyGzYdHy63CFL0bQp67QW5FKUMSH9NxzqMc0FtxMaU1teWZ+N
   2clrqMbdycIg5NjPb7BL1cLnJnpjDCMDDLkp1esnVAZX/ka3N0hExEEPg
   CsXrs+mI5ojITh9Q/+5Mgp27YBRwU7t5Rcc5o3qN4Imz+cVfgbhaS/g+9
   w==;
IronPort-SDR: RRKB0H7j1myby3E/QM8MTgSK6XHUJQYkcodlG7+2nbGKnMHsCiQuk8UjrjKOwNP2RLpx9aO0GW
 SpneJi3n+qZwFAecQOnz3xZzO2IgrtU+m6zjsgxp9ECnypl/yZLAhM64GYB+Kj/YrNjj8tVn0g
 YXW8mYX9oHpmdvplqqaP9+Ew6Wu/OIO1JNIQKNPxAa5urFPxZ0toRDQdLVyDpWG0ZbSWHlj0U0
 s9FEdgAWOXOcbqNHPpM9vTRms4m/WBxaOERroF2sBiNWVftTmETbs120HqajiYoDKpZtfxDRnU
 4y4=
X-IronPort-AV: E=Sophos;i="5.81,296,1610380800"; 
   d="scan'208";a="267939584"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 14:22:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8e1wqAH20HGugD7wHGlmlvpKJDIwIaegfOPWb586I15V20QmO6cmaQmVoyuVjkm9gHtzCWBOnDjv5VSQ2e6Hizg8Ehmdijm51G8bemL9S9jrcZ4qYSfdp7vdsRkG4aFcvwddMmToDDWOi/enXhvXkFGqDFUcJ3uGFIZyHNUTXEUHQK9CovoTOAn3dgi0oLT6j1JF7bES1g5oagaKlmCCZd0McsJ6nkKJAbXG+7au6zqJakv7xRbLS1rUQtHB7oeHM6PaMlIcE6HGY2Y8NmTY+7GJBhGdzYB99aPskoF5YlShJ31cI1qbPs2xKfDcIg4di1L4Br3xUk/od9M3/3iOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6EPfW1aL1MhqhrkjTMJgrltGlATilzYbqEp4OT44G8=;
 b=NVeODE/smy8uhkPaRUgBHz0tWndMoezsXbJqTZzZkoRRRfkFSRXAs9WoRW3sCc0sR0HH+W4eKy43YvmcVyoyQVByPQdp/Ya0J31bs/M1PL2oMGeB5Wgx7E+p9PICDguvIgSB10fip6ysCCFuw9fWWH5UA+mj8oFklFdr/31V4r8MWrlmFZNftzR9xGvAgHk9aV9UoyDQcHWqipUzv2YekmFhlEEudMPPacHXODCDc5m0cp1uzyCtGkpbQCJeGAD+6q5tCUy/Qo6Eem5IfCW9O/BUnvTvQWEH0Q31R1TsnMnvRT7dKfRRXpu+/pVm+B5isFiYH9o8TISgufQ6XgXEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6EPfW1aL1MhqhrkjTMJgrltGlATilzYbqEp4OT44G8=;
 b=Y/l3t8ojDZRtfoURdZwmYMITVXXUZpVMNS0I3fd7w4/RgI0sMhzFYYCma+HY3UO4UbKmISBRdZVx3SwyWUiB52uP2mU9t+dI4RVU+camGivLKHYqNYzs69ZihjrE5hUzR7Ogqkn6KaRJEY8p7otKrRmuP0jZo8XOdQyt6EwJkaI=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN2PR04MB2240.namprd04.prod.outlook.com (2603:10b6:804:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 06:22:36 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.3955.033; Thu, 1 Apr 2021
 06:22:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: fix command timeout completion handling
Thread-Topic: [PATCH] null_blk: fix command timeout completion handling
Thread-Index: AQHXJoCRZD7+6l4FRE2iuUzcuaP1aA==
Date:   Thu, 1 Apr 2021 06:22:36 +0000
Message-ID: <SA0PR04MB7418984520FCE6D90103A16B9B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20210331225244.126426-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be6a182f-420e-4252-1518-08d8f4d68b0f
x-ms-traffictypediagnostic: SN2PR04MB2240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2240E83080D17B67035E93DD9B7B9@SN2PR04MB2240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDrjuV16Er/TproHl3Wwziec/VmA21fG7+b7aR3QtJaJtb1d6e+3bWfcZu4Dz4BPfL06OnEjNPbv6xvCJl9wemqy7Ie2YqXJqNM70MVtcROgzomlkFMtH/E66h4fKwnAFYBb3ym37Ob1n3NZgOCLtrPWoShTApO5PJ3O9JgyciNzY61tUhvUp5sdw+6+6lGa3GWnxK/zKEIeDzQakkJYa8GDO2SrzIqyWB0iVATV7qoKLCVxp2KJPxBX2RvzYB27CXdXQoVS2xfS9KdPJJzJWMjTAwJ6ICYw+QQ2K1n0GTbnFNLXbxjck5JzJhElV/yC92rwXtWsiSAm9wyh6WkbCTUq4zrZjkVDRYHhzc3X8e3pmhQ+ey4eyJthr5DGQx1mW2OoKqqkpoITINf+QiIbShvzvRkb/1nqsZgRs0ZK+r8cgu+RgVpGU7uJJ9m9QeTprPzvON4LfTQ920y/XQzWmC17P0/v9/ooRZoPH5S8ZTO2C63HGtRMAjL82JZSMVKulCyUaE99NVX5s4SWQnfLY9eYENS5MFRnh5V0Oam8syXcnwTNP5gXZ64v7tN9JI1HbpB6XPEmYt9AB6Efxy6/ajnCt21izkDcm/NGMo3vaIiS1bjz8USxTwxahKiHWqH+jcUB3cm0KruWGlar2Nh4cMN4bbNSuKGj4fdWxgKpMuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(316002)(66446008)(55016002)(110136005)(7696005)(6506007)(8676002)(5660300002)(66476007)(53546011)(9686003)(66946007)(52536014)(2906002)(86362001)(26005)(83380400001)(71200400001)(478600001)(33656002)(66556008)(64756008)(38100700001)(91956017)(76116006)(8936002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OBVZ24gqFcOvykmjQLoWUwhlr7wOYRhB/2GHtNIsJaRdO5rJxvu4SWN2xWQe?=
 =?us-ascii?Q?6z0uw7S4hErWSrgreut+RbDNEs04/5nQK4xX+rURAQcV+inbZfHPuEGf4U7z?=
 =?us-ascii?Q?N4A9VpzGmpkltpAfw/43MRyKd1u+Z/Y4BtuN9+maNP/Bmu3teYqWc7o2u1Sk?=
 =?us-ascii?Q?1stld99t0e0eayCOQJ9qttSS6fG6gBNufx+9VA57RMxIGWaMCy7eg0evVBij?=
 =?us-ascii?Q?f6pWbEbLlohWE+5deDMJFA4+9g5dYvnYbUihZ1TExx6LBhqUnNGmVU2GQyhC?=
 =?us-ascii?Q?aLd7lDYOyB3U91eX0UztvtYRXpqr7/R4u/CxCWhH7baVtXAD618gs3wDtrPX?=
 =?us-ascii?Q?fcbZqUFb/7LdKp1k7Ph39w6fYJ9v4+rWDolzy9qMrrCl0U9tYKBw3jNqPz0Y?=
 =?us-ascii?Q?lDllAjtS5T4TFaX2U3+joBc53QiY67n69BJS/hKp+TvfYiAV6ugSLreFYyAU?=
 =?us-ascii?Q?kB7CORyD2+cRTMiE9KQOthHEtAj+O3sbul6ogph0VbWWoYRFUv7VyHS3d3YS?=
 =?us-ascii?Q?OiB3xkpLoa8fWz0qNko8yJ5zPOTzs6omF7gfdSSOD+DST2EwdW+PfLu48yPS?=
 =?us-ascii?Q?xlqan1F4TNXyeMxYWPxHXSFOP65w9/99OvcCAgwgbys5w6kU69Yxe3ZMdEMd?=
 =?us-ascii?Q?BbAaXuP0xpgeUq9X33JKL5JkU611GyONO/xmjVzEd12aeVRGi+vzXWulYET5?=
 =?us-ascii?Q?fvU8U/OObDg9YQxNRD32I4sEaNFLdf1r90FQp6jWX7ZQNR/0gOFBoxfyDFC+?=
 =?us-ascii?Q?mqPBuzZfyalvFgKQRqg1iK8JDUMixirEdDomkaAWovf0jUWTf/bM3PWWg6r/?=
 =?us-ascii?Q?lQa/08vOftNIuoTdCCTvD4Tv7IjsFw/Y38zYaHOFw5fmFzOPyGGMFcBPLOdb?=
 =?us-ascii?Q?+OSlEir8HAVN4m6lytvTaolJrgw9lTZrxGhE9LeKPyNOUuC7ej4UK/Yc6DTj?=
 =?us-ascii?Q?CIXCLaxP/tpcT+28Vx7qFXOG7o+5/2Ws3px+V0LTj3ZYsIuS522w04U9VOuC?=
 =?us-ascii?Q?fjBYHduLcWfPO3r6kIjWHzRg5jWX/CJh/f2ZfOU4ABkgvw7oOxxqQdEDARI2?=
 =?us-ascii?Q?T1U8EeqJ2/OerloVdpxd8KBSf44I/9kV+jhR9ZKHzxZL8rF5L0Z6a4hZaIJM?=
 =?us-ascii?Q?NOEOg6ygGeZoPTtpg+l9phApYAjzk/rsZexjHOIWnfMLtYzpIn+cYvNaH8T+?=
 =?us-ascii?Q?TzIuE/K51Ew0VrkP8ewdxH2fohKutJRgUveqMAHSg4fkdgPohsmXNm3zS8OM?=
 =?us-ascii?Q?RAmW+ZvmHvVvsVhdq8db3XiFz+mHJODgN9qIpdUBeT6zWdqCXHO/p/PfKRw0?=
 =?us-ascii?Q?o5qH/MBgd2pK1F7oSAZYaJ9gido/FuNzaHigAJaL+2OL/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6a182f-420e-4252-1518-08d8f4d68b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:22:36.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUsnHLotKh9iWke9REr35D7Njjjps4ByPomemOLMplKCNnH5bDJkNqAjiyiSc9bsZNhBXwnsDnTAWLAF/LGgaJlA7IjKEJ2dvdOUm5jsTPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2240
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/04/2021 00:52, Damien Le Moal wrote:=0A=
> Memory backed or zoned null block devices may generate actual request=0A=
> timeout errors due to the submission path being blocked on memory=0A=
> allocation or zone locking. Unlike fake timeouts or injected timeouts,=0A=
> the request submission path will call blk_mq_complete_request() or=0A=
> blk_mq_end_request() for these real timeout errors, causing a double=0A=
> completion and use after free situation as the block layer timeout=0A=
> handler executes blk_mq_rq_timed_out() and __blk_mq_free_request() in=0A=
> blk_mq_check_expired(). This problem often triggers a NULL pointer=0A=
> dereference such as:=0A=
> =0A=
> BUG: kernel NULL pointer dereference, address: 0000000000000050=0A=
> RIP: 0010:blk_mq_sched_mark_restart_hctx+0x5/0x20=0A=
> ...=0A=
> Call Trace:=0A=
>   dd_finish_request+0x56/0x80=0A=
>   blk_mq_free_request+0x37/0x130=0A=
>   null_handle_cmd+0xbf/0x250 [null_blk]=0A=
>   ? null_queue_rq+0x67/0xd0 [null_blk]=0A=
>   blk_mq_dispatch_rq_list+0x122/0x850=0A=
>   __blk_mq_do_dispatch_sched+0xbb/0x2c0=0A=
>   __blk_mq_sched_dispatch_requests+0x13d/0x190=0A=
>   blk_mq_sched_dispatch_requests+0x30/0x60=0A=
>   __blk_mq_run_hw_queue+0x49/0x90=0A=
>   process_one_work+0x26c/0x580=0A=
>   worker_thread+0x55/0x3c0=0A=
>   ? process_one_work+0x580/0x580=0A=
>   kthread+0x134/0x150=0A=
>   ? kthread_create_worker_on_cpu+0x70/0x70=0A=
>   ret_from_fork+0x1f/0x30=0A=
> =0A=
> This problem very often triggers when running the full btrfs xfstests=0A=
> on a memory-backed zoned null block device in a VM with limited amount=0A=
> of memory.=0A=
> =0A=
> Avoid this by executing blk_mq_complete_request() in null_timeout_rq()=0A=
> only for commands that are marked for a fake timeout completion using=0A=
> the fake_timeout boolean in struct null_cmd. For timeout errors injected=
=0A=
> through debugfs, the timeout handler will execute=0A=
> blk_mq_complete_request()i as before. This is safe as the submission     =
         Nit: stray i ^=0A=
=0A=
> path does not execute complete requests in this case.=0A=
> =0A=
> In null_timeout_rq(), also make sure to set the command error field to=0A=
> BLK_STS_TIMEOUT and to propagate this error through to the request=0A=
> completion.=0A=
> =0A=
> Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
=0A=
Tested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>=0A=
Reviewed-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>=0A=
=0A=
Thanks a lot=0A=
