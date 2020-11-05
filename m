Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682DC00A89
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B92B2151B
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O+rqS09K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kw6APY17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgKEH7w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:59:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29674 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEH7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 02:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604563191; x=1636099191;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=45frMaS7Qsu6ZWspEIrAauzri1QM5AA2uEsIKb/RsU4=;
  b=O+rqS09KlT+EoDx0CotIE41wTYU5HUp4Bh9ReYB1CIGm3zAl1mn8z+JC
   ZBkLaykI3BwSuBQT/lULSmKuvEh17cB8zEqemyWp5HCeZ3PoSB8FiQiXg
   u6RZbQ288QeYSduJHO94V0kVymxWxTey9BhmFRHZBkq6VoehqSpT3v322
   uAIPXRq59e/vqEVfjDr5RGAjGI+xst2oR4kd79mUFTUD/5wDUW2ZohUqJ
   WWtSmw0YPckXIMYxBTJoR1UsjdTRRCzic5dYTCUSJ2W/u18INk4Km2kPB
   Ohn1HGK71nuUWlgRicO8RAwWt+C6RxVwQuoC/pUKmlrrKFEf2tFWqrJ9x
   w==;
IronPort-SDR: aKwzi4BpMkbbZYHmGMWpk242pcfelEEWD4hiq5itH3t9CMKwqIsA5CSwzY5YKBHaHWCWQ6uH7N
 MKzsKPdJHU+vXTKdZ4U6YOS1rA9SuMOgBuwOUzW7FOLHCs04+VKgG1N2rXu9jpjG0igj5dcAJ8
 pl+xAfICS5CyYKiAYLBapwD4DGDigsOswEe6GsCfRrCziUAl4ripJ4nnjqvMMDMUe6I6vfCkXt
 zkfeAs38hQjssVbb1id2rd+9/FXD2lCFR2wmI0z0/RSRlwPMJK7yGKvhGHJkC37AZD5/gQ45/3
 8jo=
X-IronPort-AV: E=Sophos;i="5.77,453,1596470400"; 
   d="scan'208";a="151783182"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 15:59:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL7jbqMi2QepolqKEknJJy+xo1MUpxNuAwQB6Z65F/Rogtv9GLUhYJKBw9w6ZC0HQvfxVeOyXoc/S991Yv+sWfZtBA5xvrnaAJ5zMIYW/aBeo+87Zww84vBp0liL1iD9mcOg5di5OPomDfPSITIL77jL7t1xJPzBXeBEYzfOLq1jy6nOR98lmB5MvGAtQ8efagNyhVUfhw7yqcjEWrFeDZ/ijaCPxvT3WK6yhuXqF5RPQMlX9nwiD5aW9iMyh7BKaNqU3o4M4l3NUWe5bVSfe4q2fMptObkrAq/Fc1hfu003mKBo9S3ks0ApaOQYaq4CqrM36zCdWTfepceVcsD+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSV5vlouwTapDa37FtNjza/O2mloQI9bVPGh9v625Yo=;
 b=oaeffM34AMb/oPpKAxQu4dhvV/x9M6GnuCFjICNSOzrbSNiVgx7FA5dvEuz4SdniIo65wrE8bxq437FmCWmCOiL9SWjZ5dbWNTNQvIx2wrOKBdGOBHP1ULkoe71P9N4gyGy3/TLPJa7mS3HQZX+sAOvAnNy8mzWFSGFyVkEmumKfmeTAHBIK7/VsJ5roDIflwr9KcJQJNqWFmcAuDofzZdQttIoeUpe3QRiQOjQ+RkwzBp8z2r6Azah2KZsPN2ol1flmSFWxj9LDl+ZytcnENBXO7q/l/DFVxUXlbkVfxCOb6onYAVMAFfPnO3rf8/uWOl8Yu5yCfLmdWGZNhJ2Kyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSV5vlouwTapDa37FtNjza/O2mloQI9bVPGh9v625Yo=;
 b=Kw6APY17B0etmq6XSYMUJ2sbSvOBPR2TPq52rLycspQTVzmdBLnyt/O8atGHzlSsk9SQxEyudzWbrGUU+dJmiScWmpoZU4y9o/h3PspsIpBeNNpoQTshAZNvooV4B/eV44z3OXUqTb1zxhc1Xolwsi3N2yCN750tCfr5CC4KM2o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6640.namprd04.prod.outlook.com (2603:10b6:208:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 07:59:48 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 07:59:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Set mq device as blocking with zoned mode
Thread-Topic: [PATCH] null_blk: Set mq device as blocking with zoned mode
Thread-Index: AQHWsz/r9sZHVc1mskeMtHsg66vYdA==
Date:   Thu, 5 Nov 2020 07:59:48 +0000
Message-ID: <BL0PR04MB6514CBDAA1C72DE610351689E7EE0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201105065008.401112-1-damien.lemoal@wdc.com>
 <20201105075402.GA19304@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:830:5e48:69b5:9288]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66f34de8-5f7e-4e18-9b23-08d88160c499
x-ms-traffictypediagnostic: MN2PR04MB6640:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB6640F220D49FB62441FFB524E7EE0@MN2PR04MB6640.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvFKe5gch8JVAPnBWoMYV74zkFBnApa8HefSd4OPJfIA1GOcPgBdwPQypR7hBUtKv3kwg3FBv9zwKRTEPAcZvFccGGDaK2xq/yEOdtSfy7ndRpxCAfLXFgRcxcXndsTlFwIbgIpzJmCfoOtGxeIJixdJVybmhZukkfl7VXLpxoKrsBip3KcAJuMTdNIe0vRD8fVliirz9ODdIXPh9SY6HL21TBnWIcj3W1bysDQ0oQ87ILAtpxKS6paMtrcFduKSnoD4WfyL/2/G0yMz15Zug7M6Q7vbv8B+DgnL0AgvnPzq/F6dh0TaV4TN0KY1O2BFsl47qhLRyyIFcNd3NQKBGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(6506007)(33656002)(53546011)(5660300002)(52536014)(8936002)(7696005)(91956017)(76116006)(71200400001)(86362001)(4326008)(2906002)(66446008)(66556008)(478600001)(66946007)(66476007)(64756008)(316002)(186003)(6916009)(83380400001)(55016002)(9686003)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f8POPbXLhnqecfYsMyh3e32j2AHqTDBVqv1s5Z1SA5O8XSdN13Wx74ZaOcPwXr8ZkhnysOTTX0qXoRv4VSBmhfg4Wf0rrFXTjKPEOEN0YbnBiZRJXTSOuL2QU44BrqmrLBSo5jnCrC0xTMz+zD7AQQyQqNp1BYVyEce0kg6Rdo9SU4uq0q+I97HjTHdl6g7C+ry2hPnC/wDsBJzV2Pg3hcTpAUWeU6G88FoDbjKWZL15sZxQ7omJA0uiS01iHIPNnQyeT7R9IflpqXzcfKvHKxRCRzbzOEgPn3tgxcqY7w1lOCsIPCFVY4H1RRPx+LquAEFsPme2sH64JvMSzr6Hhq4T4i0+AYCxt7JMXgLJhzvh+cv8HnjAQvKWWGVYxmgAbv3K2csEosuP3kIP8qcinR0Yy/v3VKnr86PojCV0HjdSAtBOsKrgs5No4/HaMVLa86wRTW91W1nV2q4c2fkr95gRhcYLzFi45wDeVY1RGhKFtP5/wl/B2mCC66rcsakocQTiBeuhdvgGTuwFFTa8qTGGycDbNebnubf1SclxptgSV2x6n55aZ3mA3AIK3pPVNMmIWX/w7q71NwuswO45dJT8Ro8XMIX7P6i7tvhaovE+FOGpHfxjEXe5iGXs5gylnx1KMtJl0FKWfVc9xPh586CqtL2JFMi1AugwqT12zkvE7qz72jSVkvPNvq0S+qpMirq/ouTQa2/t+wDj/5RQZg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f34de8-5f7e-4e18-9b23-08d88160c499
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 07:59:48.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3oSf3rNBePTwSyhUzmuZwH4mr8vWhpBbwwdTp5soCzKDTlyvTqioWdN9/t6KluNUEQyKkGYK6uTkkXVLxsRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6640
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/05 16:54, Christoph Hellwig wrote:=0A=
> On Thu, Nov 05, 2020 at 03:50:08PM +0900, Damien Le Moal wrote:=0A=
>> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed zone=
=0A=
>> locking to using the potentially sleeping wait_on_bit_io() function. A=
=0A=
>> zoned null_blk device must thus be marked as blocking to avoid calls to=
=0A=
>> queue_rq() from invalid contexts triggering might_sleep() warnings.=0A=
> =0A=
> That's going to have a fair amount of overhead.  Can't you change the=0A=
> locking to avoid blocking?=0A=
> =0A=
=0A=
I know, but the GFP_NOIO allocation with memory backing prevents any sort o=
f=0A=
spinlock. So unless we change that to GFP_NOWAIT I do not see a way out of =
it.=0A=
I am fine with GFP_NOWAIT, but not sure if that is not going to break some =
test=0A=
setups out there.=0A=
=0A=
The other solution would be to "do writes" (memory allocation and copy) fir=
st,=0A=
regardless of zone state, wp etc, then do the zone checking under a spinloc=
k,=0A=
with that eventually failing the IO despite the copy already done. But for =
a=0A=
test device, I think that is acceptable.=0A=
=0A=
Any other idea ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
