Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE6C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 18:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiBPSJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:09:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiBPSJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 13:09:07 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30078.outbound.protection.outlook.com [40.107.3.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA5B2A4A16
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg2TlMJ0TWkrFED/NcSvFN099jGA7C/Agv0Iof+RcMXnm0lZSmsFLAG/J9uN+NBMXvuDQxEdm1s/Q6Adik2vvEXaXoAvDbajakdjC5wvMAusOPBzy9xdlXtdP8rDvnh3gqPqAFR5yYRX1i0wxmrhYAIMDr2Ifjc4n01Y1XVn/vGiEGCViTIO6kYTEsltZN+Fng1YifsHEcrFGgKPK8wGlGLNsF+ZvODshVLQE0t1DhYbGgZbXlNGgDebl2eAKoGFB3FahlBUkTW3GYMuqYEI39xMtRR7h4+180gwNTZZ2JccMbxsFxs9RtfFTT4kyOt/kdpOmrJ3iQzqxvbQPIPPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVDKcF7PFeuOpmoqkP5qkymY09rn4pibOdH3zycN+zo=;
 b=bUnHj6rj2dklWJx9+TwCAuXvSnTcZ77chApoH/MikybipUq/oH/bEj2ZAL2M2mi4NmSdB0hAh55nAo+Z592mLpXUoMkpzq0BGSz086w4P/e+aarFBMNFO6CJP4Dsc6J9WEOQAxD0Tl1XzGcid9Nn9ftVzf2akZm9gJ+d1lZ5XIrhK3ro2VCuAl42ZuTZeew+fufGLRs1A+4PAzRFT1moMzRE2GqocUwbYiRH/EZiTj2QxjQzicc2NcJBu4JFBVLnXYqxBjn96GHwhBVjHeIGwtViBfxu1eRa/AKPMhX8N30fB37JjZj7l2xaQHnORf1DFjMeoYkni72zPpiN+7+D4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVDKcF7PFeuOpmoqkP5qkymY09rn4pibOdH3zycN+zo=;
 b=nJmfKALKmZojmFaQPGUGtSQfoI9ehRL76kyjqOm4arcMvg6uoOifDU5uSmKwdzpcnmYChIadnxHNOtD1do2WNvoG2cugnTNMaZ0OVNH9lTyK/T5A62nRumgrYg8ErvyecfzJovTuXjseX66FzbopU/qNDTZSjcTjoXD10nbtCWxSa0gFGDSm3aoNoX+ab7vTB0Zo7tPbuRgfL2qWD8JmYwtU9lLo2o0XojEfnc0Ipkq3DMS5kfMTFjpph5bamqJff+OYugr0OZwpM8VfABZ5Upx3dAEexwYykSPGEEH5U5gnV7JtvlvlHaaoCQMYwxEiH7HM7AE9HfhH19lcZBBBsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
 by AM9P193MB1981.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 18:08:51 +0000
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0]) by AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 18:08:51 +0000
Date:   Wed, 16 Feb 2022 19:08:50 +0100
From:   Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <20220216180850.fjcmj5yinaqolskt@ipetronik.com>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
 <20220216170919.GA20782@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216170919.GA20782@lst.de>
X-ClientProxiedBy: AM0PR03CA0064.eurprd03.prod.outlook.com (2603:10a6:208::41)
 To AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36275ba6-9b70-40ba-1acf-08d9f1776301
X-MS-TrafficTypeDiagnostic: AM9P193MB1981:EE_
X-Microsoft-Antispam-PRVS: <AM9P193MB19816B80F4F9248D88AA14D792359@AM9P193MB1981.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73MIqjsjVIJ9XmbdzFjLhQtbPXNQ20oJzK1EgRQ4aiSEEO4J9/ejxrUzXIx9NL1QhpAOMMV1MnbZ5grHOnanBS9UxeCDBUpevwULH/ReZKmXhrwoP5fx/aN8j3xyM6fGp5XfOvFNkO9q7RQieVaBXpbYLlFbsjwckG7S1AiFbcZF0U2ltxQWleLMj4hu+fTDR1VAHbo02iWdKqF68jDgAjleGGKpR24E0HscPd8SOxoPTFbyyiN9O20PcT6BNXLHsYcyXrcCDVm/CLSjgXiN+6TwPLh7sNkRNEbH3/539faNDbc/mg31D9vNTZKFaB6SEJqF+ATHFmxbGG1UWM3knaNtsntU1bzM6jGsxC+DSKvULJxXGBnLsXR3MQOI8T4IGJcIB3xCj8M3Ana7bG4NJROXHT+Scf0+MVThq+5F4DT6D8/XVcn36xekKP3lW5SplUaY7/BlxZf+QFAftvNyQhl5JyW7hIZSIhf+DANu169ZZ4hCXaDCWyweE3Tr3IJ1WcAqYRoE4pwM8M2P1aIoo/E9AXP2G4DhLMUmUT7JL9HGMYvP7cAu377d/pXGEG3h4UHD6Riz+15mvr67ZP0BWjtchvcnbDo9ldVvCgLBH/V3qS7VQdhpjOs2tSoybNl7U+Mwhl7abpuThoXTypFQFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1572.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36756003)(6512007)(6506007)(66946007)(8676002)(52116002)(83380400001)(2906002)(5660300002)(8936002)(4326008)(66476007)(316002)(66556008)(6486002)(6916009)(1076003)(2616005)(86362001)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DxBPx3L7RrKIzksaZq8ur7kQx0JhCIwP81PaaNcOW/b8BqLgJPosn16Zqscg?=
 =?us-ascii?Q?Qb2vQ36boV5tzXLcMArfsnlCJjGwehK4hMQX4TUcvKJ/H2PQo4P5qyU5UXUu?=
 =?us-ascii?Q?GdyLfSYbQDR0i0Tj/BB7ifPG5rWC313jX90jct3esQY9sY8mX4t2U5KiADXJ?=
 =?us-ascii?Q?h3grg0c/M4sHMo/weCoTYLYu05eaRYTqt0UnJVgr9HSkwt7ZhtVYJQp7iqO6?=
 =?us-ascii?Q?mbCHzN9WFRezj604mSIzjm5wlDAk0fbBAdGwz7nNGa6Y5TdOonC/oIuaEnR9?=
 =?us-ascii?Q?3pRpFxqER9GI56HE7sA1aOCMLEVQBgfgcODqfp3Gfq9vuBjL9iBF3P0zPu5m?=
 =?us-ascii?Q?JoNuPRxJyD+3ksfNLj6PXbwGdPMwfffhersKV39vLEJrfUkJ+qlpVQYngoBh?=
 =?us-ascii?Q?EynR/YFrQRGyEjWdyI0CuC782grnaI5kBlA1gT2dkk90ohfv0eVDjHzt2sB0?=
 =?us-ascii?Q?+cMhynGB7V9kQDTRwxw6AIOT+r5LpTi8cWmO5tOd0/o00pLF8Ss8FkC8I3ro?=
 =?us-ascii?Q?iwBk/ZDd365NYeI6g61xtwhnp9Fr/ALXPFhEMiNp0ndlM4zOiaWH5uDxg0lF?=
 =?us-ascii?Q?SBqyvMuIvcwJ1Te53rW6Q9nPyLALNaLcdfj0IRN7VFUP960GuuO4sbp1J8Dm?=
 =?us-ascii?Q?vEBni03z75cHykQ4YxytRo8fcw6s1qNA+wbrssRtjHGwaaDCM4b+6hhKnksr?=
 =?us-ascii?Q?KPu9wtPh3PJz2aWFTbojLKYQNevVBDR8jq6NJaYgWyWKwK2vYH3UJ1PerSlq?=
 =?us-ascii?Q?t6E6OASATxM/hWhOz6jS+XT4YU79zGuk7h8YYulvsP/y6XDtuAVhn3t2Kqx+?=
 =?us-ascii?Q?LSlZMcWroFTJqpFRMoOmerP7K19f4B+O3OKny8+6M+2nbZJQXwHHb9NwOvRO?=
 =?us-ascii?Q?Fqhn3JZn41b9uHkkhjKnio2ClDy1KMUYw6V0ArpKLKgbHfuyAZ544LWCzfB4?=
 =?us-ascii?Q?GZATJuHbcAYOkF6spordQWn4n/gflwi4B/CJ81cHuKKvH6YH+oaXiMkZb6+b?=
 =?us-ascii?Q?4+HJgd4djwqx93G/0cw+HwE2l3hStwwfQECTrLxdwO3hvsFR76Qp6U5NIPB1?=
 =?us-ascii?Q?ySyPBUsGmd9hdsR7xPT0wPqWA1fYNvXFWU3Mcsrf/kbBblTUDYxxhm6N8m3w?=
 =?us-ascii?Q?hJB6jMpZ/6lwjw56mkjsgRUe+a0wZtiQHvMIaXr6pBKybGR7K1OuJsqiTInw?=
 =?us-ascii?Q?56dtbeH0VESJxZlJKbvRere9T9B/PpIXiv1t3dS/c8n0awscWgxUHNLMEmMD?=
 =?us-ascii?Q?1FjkJ5BnPnyBSHNEbJbBYz7wKZxPgbEXg6faI1Ux3XAr0kzN2+jUHAVot1nI?=
 =?us-ascii?Q?xf4wK+bHtUQ2pnjzSDTYgv19CldNB+oFeoquiVJsUuLCnNCdNp7za1oyD5eN?=
 =?us-ascii?Q?9UT1Jd3CZ1RC4GSWclxkQo6sT9oP6FSP1cvExkUC31E1o6NiWU/uhVrD0/jv?=
 =?us-ascii?Q?0gTylPbMr4jeSMg+I8a2BEZNybuiHZfjCaPNhlDNJVtkI4IhgCY6l1hYHYQP?=
 =?us-ascii?Q?k1BEbfjDtkwOcMMGXYKqZ6bREEEGBAMuaO5fZJm2SbhyflO7JEEOEPuShqGN?=
 =?us-ascii?Q?V7NEPbGRLsPeBx5hEqC9MXcf73Bg0GpNciNYKpb9Baj3w29f8WCNhYwHytX9?=
 =?us-ascii?Q?ttMCo4wTUHeQq009Y94lw+PvhWYvu891cS3KDne1+6N80s0lNWLOI0aPtmlZ?=
 =?us-ascii?Q?aem+79IFsFQXhfzPhE2xto3WdZ54HwE57KkdYQFeoz8bZ8Q75ET7GPchGxX3?=
 =?us-ascii?Q?yzdHMHnW5U/47+1HpkTSwlQfUWnwQQM=3D?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36275ba6-9b70-40ba-1acf-08d9f1776301
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 18:08:51.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qL43xPpjW9sQZ+TaFMMJq/5b3f5IckJ/B5aCgj2mx7pboQbjJ0a0c1f7mOCx8ihvPuCKb7YjV5e6+kLCDY/kz1hGTflvzz5W9HIyt8bGgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 06:09:19PM +0100, Christoph Hellwig wrote:
> > I might have missed something here, but assuming I am a driver which
> > employs multiple different queues, some with a disk attached to them,
> > some without (Is that possible? The admin queue e.g.?)
> > and I just lost my connection and want to notify everything below me
> > that their connection is dead.
> > Would I really want to kill disk queues differently from non-disk
> > queues?
> 
> Yes.  Things like the admin queue in nvme are under full control of
> the driver.  While the "disk" queues just get I/O from the file system
> and thus need to be cut off.
> 
> > How is the admin queue killed? Is it even?
> 
> It isn't.  We just stop submitting to it.

Ah, It is in nvme_dev_remove_admin() so as long as we don't get stuck
ourselves before we get there, things should be fine since other tasks
waiting for blk_queue_enter() only wait until nvme_remove() is done.
> 
> > > --- a/drivers/block/mtip32xx/mtip32xx.c
> > > +++ b/drivers/block/mtip32xx/mtip32xx.c
> > > @@ -4112,7 +4112,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
> > >  			"Completion workers still active!\n");
> > >  	}
> > >  
> > > -	blk_set_queue_dying(dd->queue);
> > > +	blk_mark_disk_dead(dd->disk);
> > 
> > This driver is weird, I did find are reliably hint that dd->disk always
> > exists here. At least mtip_block_remove() has an extra check for that.
> 
> The driver is a bit of a mess indeed, but the disk and queue will be
> non-NULL if ->probe returns successfully so this is fine.  It is more
> that some of the checks are not required.
> 
> > It also only set QUEUE_FLAG_DEAD if it detects a surprise removal and
> > not QUEUE_FLAG_DYING.
> 
> Yes, this driver will need further work.

Alright, I more or less ignore this one for now, then.


I noticed that set_capacity() is also called most of the time when
a disk is killed. Should we also move that into blk_mark_disk_dead()?
Any reasons not to?

