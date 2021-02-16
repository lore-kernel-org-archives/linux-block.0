Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3368C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B49564E7C
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 23:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhBPXHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:07:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32484 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBPXHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 18:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613516824; x=1645052824;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rflz6V1S8v+93ctPCFQ74Oizqw9qDJrLL61BauziNBc=;
  b=Vpu7Pc6ZMbYsQNM/YeTe7Gw4TbzupJFLyHnqWf67GX5BwdacW2ODNGC1
   SfY4Ntvk8964JAh2GGQsARGWwpkcNlQoXdx0BagpkJO+YfBvbybEqXWk8
   ZkI6ujihNefW8S6K5kiK4nHOCyIDrpEowj1PwUrQAwSgMqzt/y+7A0BJo
   sxUD2q5/MAAlCZnD/KqYdbecAoWx1WI3E9ZZlMhFlnvzJNSS0yQ8FDy59
   qCxSUaM7TAYzihCWDMq/gRlU2lYw6vZvNPK0nu5djNNEFoPGucZHYvERX
   1JpqzX9FPIdCPIPbuPTFM3xyOw7KBTfzPwbPCIPnYnTHx8UNU1Cg4wlEh
   w==;
IronPort-SDR: YvspsjIKsxRA+0QsTweiQATLNr/PG6LgM5CWj20l1WyHjNtNzCw5jktW79EAFRpak8Oj9R8Fti
 JqWQJsawqUTSxKCP+hBHRpzIs8CmFhLVVnBXBAgCJN9WGtaD7XiC2HBTMtlTgl1f56B3fOjVIR
 NEoiAeMbBz6d5todWyOWap6jIQ+5xcKJfUWMGue9hRG0tMhChJq+zfGQOZWrlZQdjO4ROa/MRM
 jDCQok3AyFDUhqyrWEHUkUwfPhmDsGEiqiTwTFFsa/W7G3ffvXvBxl91Dy2nNRj7PSzVqFytT2
 7JM=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="160094158"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 07:05:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyF6wEaDU4gQRhXTtUvO5mZRXbcOHM5Et827OELeKT6TxaTdFWZ91YKxnimNnuD+JVwsNx7le50x4YswEF5sevsfaekI1XFEWHPuK7J1uO8WukRWqVFDGzGOl4YEDoAXvGPJKsRNl2+mEGftcW77YL1AztGtG1aokcVbtx2+5zisf8kjlDSEAvY35FMgCBv3WS69P/hbwox9C3O3bEVzBfEMsqQ+YQ/aSrJ+oXnPL1l6sgR7A2fSyiudY8i+M4Pq7UgJepPETqWOY0oRiFw7IuNMLpENT/Unp14olUzTlSpCLFyrgyWl34gsLfglS+fQEB3cM+d5z/fi+jTYtWaqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlhQs2qBNDJhtg8mgawdZXtHQ3CtfFeGmf/iWKcMFBk=;
 b=O0M4KpORizoiH4Gnsz0M9ABLoXCFfkXrFsTwvDL186jtKvF93ZLRyn1B2S6P+6whWu6Q2r/WpWYocO02pSBDBAnD8gZzOanJ1PuLH2MunrZtITXxPjMYNGfq66gZJyWhtFlFWap4FuVIdp6fej7gjBFzQQUaoxpQSPZ0Lw3/GtUFCNIPm9lsjxXyYAhBB+YT73NGJ9NRH83gDHLthZgU1LF04N12Uo1on5rgBR+8lVKsIsj9oVLNJRmrxydh9mlBQ0CE52TQ/qDTwvY1PXA6LnvWhC8QBrhy6uKCxWNUoMFRrD7KdM2iQZMTPCJb+BtB/C17DgLg+fO5S9mkHyETQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlhQs2qBNDJhtg8mgawdZXtHQ3CtfFeGmf/iWKcMFBk=;
 b=kW2L00+4y93r/jK++9pP8N7pUrIWkWTeCuwlI/idHBcyVn2Q6z4DFG841y3fScO28WjQ/68T7uNKIbSxN7sgxSHXlAYl4s3uoxY/ITgE9kdpiOGlSHrugeasoMQLQ4Dj3Nq/j88iIPF272D8l/m+fWdC534FnSxKIKBLNpHFT0M=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 23:05:57 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Tue, 16 Feb 2021
 23:05:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Thread-Topic: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Thread-Index: AQHXBGmJovC6+TUaiEeXj6FaL10VqQ==
Date:   Tue, 16 Feb 2021 23:05:57 +0000
Message-ID: <BL0PR04MB651447424E3A3EFD5BE7A987E7879@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210216133849.8244-1-jack@suse.cz>
 <20210216163606.GA4063489@infradead.org>
 <20210216174941.GA2708768@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:75c0:49b:2210:beaf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e88dda98-fcd7-41b5-2ae1-08d8d2cf6b9e
x-ms-traffictypediagnostic: BL0PR04MB6514:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BL0PR04MB6514E5801FDB5674465C903AE7879@BL0PR04MB6514.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zumhYqlOjt/oFQU0M21dzUuUcCkf6fspzcphysdPTaaGJk5ZBG9o7f57vZTilIkNEC0KhakiCBAjA9df0sz9cGRTGNZa7WsTqTNrpCXFxUwtC+SV5oaQWJeC/yXiFxHAw9cZ88rbz49KEQxQ6PEj5Z/p7hb0tNnR/Sh7fi1r1LeT4PFE7jqiyRwZgPvfxGI8GdUa6JBD4x57n4Si0xZTjyz7QcqpF9ZKsh/DRE4EnI+yAKkEBHMF0VZXZIcJOS83CM5HElDMywy02k5Hk4Wd3yqDkTX86Mi+FB1JGm/QPUXzi8bG+t686/4+io6GZMtEGmqo1+FHw5VpL0DrTmuThnyHi3Npla8RpAuUzu1+btsjKCh/cNf0ez+chAvWRfIoWoZEVKc0J2c3qWf1fz4zZlPamu9BI5MHQXcdS7s5/WeOYOSXVnmvR8Oz1fAXvMmH8CEeJexMVGYg8rsx+AJ0075/aB3kFXwr+yTaefpGC6gR/vLmDVDqWM409Ku06mBrKDnnQtPI+V55l/I/CDuVIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(8676002)(64756008)(110136005)(54906003)(71200400001)(66446008)(316002)(8936002)(4326008)(66556008)(76116006)(91956017)(5660300002)(66476007)(66946007)(53546011)(478600001)(186003)(2906002)(33656002)(55016002)(9686003)(52536014)(6506007)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MabRWEvuCiLAB48ZqUSgqzRzhon5dj9cZVBX0UtgiqL84wOArRAbWgkKPced?=
 =?us-ascii?Q?ZlNfH1RnJGBtNeEmam/TBXSpejKtwAkMsLDDIMx4p05Xc/w0Bj30VnLhP66r?=
 =?us-ascii?Q?tN2Z/KOejZ8AKm/YENWIeicP+zrUNSbzONQqxKUpt4NwazWHYEbuWXAJyYai?=
 =?us-ascii?Q?naGAIzskQjRG7AdEYp4Vh27ztmVuiCynVY34xdX9ojd57QURp1tMp1pBkgR5?=
 =?us-ascii?Q?o0LWFDLzDgQGS+owZf7Pj0MbceMtozAIHnaDQJLjCfCRNODLB2vRb1FFVinW?=
 =?us-ascii?Q?I388f2XZrHPJrKKKVDACfRtVJgq2vQRZySSV2Dktgxd5sZcDojYGQIWMJpp2?=
 =?us-ascii?Q?P3MGSpfRKYVt+Gbux5tXmB5g99EB4o2x50hATi1eaGKg7zg7N3l1ghIGrbfn?=
 =?us-ascii?Q?zAjRxXOLLbkA/oFVmcBUCyDXfoIKumvcjiYedKsuGHwG5c2Ns6FAWt9ELKw1?=
 =?us-ascii?Q?/czFDOvcd/XUpnzH+mu9NFH2x6RbmWbfhie2G/Rpfhs1Srg6SGv6aqJmPusc?=
 =?us-ascii?Q?LAt2UDZOUzKplI8Uw9j61Ad906hATp3GiQiv6oO2rjZjGqhQKRQHXFb7iqgJ?=
 =?us-ascii?Q?zOeGIisDBLXoB0H7ItHqZEVis4icXDXd2mUZyywN9fXfBpes3O/iytZUBPXB?=
 =?us-ascii?Q?yp3FfxQ0OBZ4VUkeAszw6oGEhlZ5bS7j0/oQKPVi2YpNbMx2no03UJ+lbbGL?=
 =?us-ascii?Q?1BtN51vaz5/bIjYIGYTbsQ6gbvB0oznDSPXD375BBgt1ZZaqc8VBJUYS3A6h?=
 =?us-ascii?Q?NRpxJF47GacDgaPHjxtq2dtHZZGzbzPYE/vnr1rLx09Y9+dwToEJ2XhrTYoH?=
 =?us-ascii?Q?rAadM2M+VXmQY/aCKrqE69TUfeVTReoxF+5FL0liHtbpycK6mGKiQkUF0Bm9?=
 =?us-ascii?Q?dwRdkEbDZqm1rmQgyzAOL3OPMHxOU0otU7qC+PwCc5i8O82bMqPbO5EjuOgk?=
 =?us-ascii?Q?qEYb3bAsZUCuqTbILPt7zBCoDCU0NJrkC4bxMlRWFwZ0ojK9CzY8bnox3s54?=
 =?us-ascii?Q?rRRc7MokUxWnrKazZBR4rMfhVVSSIT90U+PuSALCCPyEG0gb/Sv47seZ1gVE?=
 =?us-ascii?Q?kNH0CWlKIp8tpPDA4WKjDw6WpGxIZuw5/xCGvK3mywoCmw9LQr2Rj0oVOcwj?=
 =?us-ascii?Q?A9n6ppzm1JFObNCCo2W3bmVexEQjdR/oa9x5YGdPHjrk0IJ/HD/UUJm/zcZZ?=
 =?us-ascii?Q?PPrZ9GTxGHq6cu9MJtzXqg2WHsWMeK+o4hLnDp4Vk+kG2ydZuM/nNzYv5cNn?=
 =?us-ascii?Q?htlWcOJj79qL4ywjK4LnaqieCp0WKeOdQs5PG0DL3HewQ94SL70M1UdL1GU8?=
 =?us-ascii?Q?LbNvQ8CLrDuFD6VuY+f4A1dqSCfpnwtyzssLXYtA+z/SMtEB1FHfSp7h6Veu?=
 =?us-ascii?Q?dDYy++nxCJ7RdFA9Pg6VCZ99m200ZT0FY1PdSp76Hi0Vsfm80w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88dda98-fcd7-41b5-2ae1-08d8d2cf6b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 23:05:57.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRxaLt0eE7vArrlrC+qeRWc/USvWEFDAYAmChe2Wt2k1zTuCd4+DL5lDEPdW51KpoX/VqWshIFMQ5arlrmSJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6514
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/17 2:51, Keith Busch wrote:=0A=
> On Tue, Feb 16, 2021 at 04:36:06PM +0000, Christoph Hellwig wrote:=0A=
>> On Tue, Feb 16, 2021 at 02:38:49PM +0100, Jan Kara wrote:=0A=
>>> Apparently there are several userspace programs that depend on being=0A=
>>> able to call BLKDISCARD ioctl without the ability to grab bdev=0A=
>>> exclusively - namely FUSE filesystems have the device open without=0A=
>>> O_EXCL (the kernel has the bdev open with O_EXCL) so the commit breaks=
=0A=
>>> fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV and=
=0A=
>>> discards ranges released from LV but that PV may be already open=0A=
>>> exclusively by someone else (see bugzilla link below for more details).=
=0A=
>>>=0A=
>>> This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.=0A=
>>=0A=
>> I think that is a bad idea. We fixed the problem for a reason.=0A=
>> I think the right fix is to just do nothing if the device hasn't been=0A=
>> opened with O_EXCL and can't be reopened with it, just don't do anything=
=0A=
>> but also don't return an error.  After all discard and thus=0A=
>> BLKDISCARD is purely advisory.=0A=
> =0A=
> A discard is advisory, but BLKZEROOUT is not, so something different=0A=
> should happen there. We were also planning to send a patch using this=0A=
> same pattern for Zone Reset to fix stale page cache issues after the=0A=
> reset, but we'll wait to see how this settles before sending that.=0A=
=0A=
There is also another problem: the truncate_bdev & operation following it=
=0A=
(discard, zeroout or zone reset) are not atomic vs read/write operations to=
 the=0A=
bdev. Without mutual exclusion, that page invalidation is best effort only =
since=0A=
reads can snick in between the truncate and discard (or zeroout or zone res=
et).=0A=
With our zone reset stale page problem case, it is reads from udevd that we=
 see=0A=
snicking in between the truncate bdev and zone reset and so we still get st=
ale=0A=
pages after the zone reset is finished. No solution to propose for solving =
that,=0A=
yet...=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
