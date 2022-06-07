Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FF9C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiFGMNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243504AbiFGMNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:13:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC59C4EA7
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654604034; x=1686140034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mv/oWliYT8koUT0Q0uBjIH502hHaSGXQ9Yi6n0xwoas=;
  b=WeTx5S3DF/z+ZowjvdpdVeE9e3c3oMhT/hHg5HU7TFjcQ1N4RKUTTynw
   xR0A+p3MVMpbGQvWCGxUzEN9O4An8yi6OOE0vqwtTBSORCqUOk1BmR6qr
   lRs4wHiXR1Sb9mKPjN8ifs6lwUtQMLj/n5gmYKy8tguSG2JTewnxBS1G+
   /+rbjSTmldlTBFV/yP/R/ax5jRGwIzQ+GzE7irODJJlEDdWGyivt6HMI5
   lvv4CsqCM7LPGbenhbqr8x3PqZtJwak9Vcqng2vQkYmNQ0X3WkZv2eqh1
   WWTwKkYuueNmFMyEFKdCWbFRfK/FZzQ3vQ1gW96Irfet8EzwwKhA8HVb1
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="203261634"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 20:13:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeWc5+yek5FREILluHYwLOce/5TZHyKV/dLJfb8SyefI7Vv89Lgo4y4PsO57nrDqnwECQ8xqdIK1lx4XLTutexMzIRa02CpBXom7Iyry2rkN6Fom7P8PfUQC0o2xwXkYUy6IdqfrvEd1Ia+SVD44iwCB5hPuoO7JsIIBkXGED/1PjOFhw2UHi0EHKNKiHixt36CJTgO9yRw+j93ncQJSJN++M73uzyk/oi7WaCEyw+za0zJnVtU0D5es4neahfJRHLKsq0z7v32X3k0vwQQlyCpBkqIIhkp+5VT2wftlRCENY+s9HUi/9iukiecAjMgc1gH7z5fmdfZfa4INSVRLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITvu7LLFEUz6QBan0xDRhgOU0qxA2AR2NYqQC1ID+KQ=;
 b=JLHNTkfFt0bgoC9vnAYVx4ek+q6q3U69Hp4hRx52pBu9W5T3amEmU+XH6k42LqgXt40h/OYXi+e742q4jTNGbKGGETeaA87Zj+//3l+oUoct31OVT+3fsEh7v97U3cFt+DEY+C6IqiHEkiPksXv3z4a3wiaRt/x/4OkvLp4X1P9Rec3xTaFipG0NMgacILeQT/8eKWpDXDntS37NL8V5Yd0KVTz+VbMXleL+K827uZgXVUvtkwQ9rtLoiGiJmu3ReDpTeTbXgXZKFdLsj9y+OT6VmCaikvLhYYfj1kafSi/xpz8xHp06TpLcYJ7s/mIyKoqcEloAhUQqn32rziNifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITvu7LLFEUz6QBan0xDRhgOU0qxA2AR2NYqQC1ID+KQ=;
 b=xJa1pBmyhpY+CLfrPzEp6PNIGBd1WSDEYwU3QxWsM9EX/TF7mmW96JnLvziiDDdRUIwC9SMPVHttQCsAkl2WpQf7dxe7PHXYIkxlF5BYR3+wBf2PYDq0o4pJ671ly+LKd8gj3/rYwb0/U1k3K9sxfMDWPU+JQabFMbSpLqbpWRQ=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by BN7PR04MB3891.namprd04.prod.outlook.com (2603:10b6:406:be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 12:13:48 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::19e0:250c:79ef:1617]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::19e0:250c:79ef:1617%3]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 12:13:48 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block: fix default IO priority handling again
Thread-Topic: [PATCH 3/3] block: fix default IO priority handling again
Thread-Index: AQHYemgKTwcl8NiRekC2a5ebgGT04A==
Date:   Tue, 7 Jun 2022 12:13:48 +0000
Message-ID: <Yp9A+yxFkREMOXqt@x1-carbon>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-3-jack@suse.cz>
 <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
 <20220601160443.v5cu4oxijjasxhj7@quack3.lan>
 <c79b25f4-88dc-c432-e69b-ef5abdf37720@opensource.wdc.com>
 <20220606104202.ht6u7mek3yfs4koi@quack3.lan>
 <20220606142136.j7lztd5zyuowuh64@quack3.lan>
In-Reply-To: <20220606142136.j7lztd5zyuowuh64@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99dacbe9-4cd9-469a-b4b0-08da487f2d17
x-ms-traffictypediagnostic: BN7PR04MB3891:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BN7PR04MB38915AC6A734150280670860F2A59@BN7PR04MB3891.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kwgn7xaPs1FrOIDq12h+ChAl36QGz7ciR/8jErL/Erj1M7nGtGcktkLfO+STUNXI90weKDDS0yHAiq9ERKg4zqnchljGjT24maeVGoG75laF2+WTV1L9v/fZD69+StdA0OHSJP+LBFw0acNH7Zeog0A58H8OnzPACi1hWb1wn3o9BLxG/2JTqio3svs9av267Xosk9kPVCvHZOP35lycx9tpM3vBH1pkcG41gnhQE5F7IO36B9IQLNXFvLm3KicMK+j6U/YExPlxUSwwhCZWMJZVGtDMoRs5+nXSj7e/1wsrq50l5or7vz75+DYoiHXsAPrxVm7C1CANdkPfCt6ubOvIKkSilVMzss7yYxUjUeDYGuQG8AuSjI2kCE4djdD5yZRVO3vwGH298DeJHEM741QO013rsIei1XDNeTnSSUgyll+pudmnWPcpVsCxJRbwuFdHWToRyn3pdINhVWvBwPeV+w7/J0kLUzMK5ZN/jIfwkpyUQ44xEeppK/vRW5NqztddNfhaTgXMEKmEjVwYnOl6IZvftuafhmwpjqgetCcDzxzys4mmyKmX2seCBj1EKcBw4A7G1pvVWlALnZuDStY5Fq7Tbz+6VP6ysTgXQvabqjQfwr/sgUEnloSTbjdbvM/vTnUz8ZIz89tqWNgj+xmLstY8jwzo5goqFv8qfnB/CsLKmKog6NAi4aSZprqhFEF2AY3n9kYvTttZDurUp+xaT5qqsvSK/GyayNgCnhs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(64756008)(6512007)(26005)(86362001)(9686003)(8676002)(508600001)(186003)(6486002)(71200400001)(122000001)(66446008)(66556008)(2906002)(6916009)(82960400001)(33716001)(5660300002)(38100700002)(8936002)(6506007)(83380400001)(76116006)(38070700005)(91956017)(4326008)(66476007)(66946007)(316002)(54906003)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LblA0WOLTc/RrRashyST7/Of2ijWOJkzpPX4zdLLVxNQtZkFPHC3k77pfGiF?=
 =?us-ascii?Q?1jpICBWP4GO2rzl62JSRPgKOW+MY4C+VpQ4f8QTrGybkppGEMLIeTJSmPiy8?=
 =?us-ascii?Q?Jgf3ZJ+OgoZI5exLxRJXHQERqmuuxTjTcJq1eNKfnhg64hlUuW8G1Xv3oFTY?=
 =?us-ascii?Q?wORw93OO+XYRmZ/RcypgS3hMRLGFSCja3+FFsyFdpeCq7f6Z5c8iyl1kXQzC?=
 =?us-ascii?Q?bFammA8KKgx8p8zlF//w1g6XgTor/zFjPPJ3umJeBMtM/JEjbMm4/KOLvI/K?=
 =?us-ascii?Q?hl+cMeUwty2YTxnQwvCdgKBvUcpUwdLlTE5OXy3VBJuTsh9tuMVO/bw3thdL?=
 =?us-ascii?Q?40e1Cxj7DzwGGlHAWjywbVfOKx2JhNX9SfyVnC/BoM843gNvRw3Ix9gDCURM?=
 =?us-ascii?Q?ubpWQ7TYyonvcRlh/A4fiTF2NmCMKn9aI28JQtPxVx4azFiSfRqrAahNG1HP?=
 =?us-ascii?Q?3Wi5NPe6TS0ohAJK8VHs0QPtVnGB3ika+swxSITfXCAY6zfEK/aq3Ulq9DBM?=
 =?us-ascii?Q?MEG3vdMxx1aoHUC/oDSdfcvnNo6txZ+vk0U7v2DgD0GVO2p63hPSVa58mL9t?=
 =?us-ascii?Q?pIBW1bZ355IxpT3NFD0QR0X0tuK37UgNuHaOHFZd74iMXSi4Fo0kI9qnQ+d0?=
 =?us-ascii?Q?xKunODFS48/iQyr0MAn2HaeddmcZtmcoRJD6lPDcu1op0wQmifRGWw9w6O4m?=
 =?us-ascii?Q?N7CneTOtTFuvpNrRzCmY22K0x+4ijkI9qkEJkyzstnNjYe4VVddEDCyPhgls?=
 =?us-ascii?Q?KRrNxZKgIc1qShaGHNvxJouzSPXmj42N041ELbKPD7YWq/ksRvyXDFX3l40J?=
 =?us-ascii?Q?qR0I2GAosA5aIG8cbkiAzKtbBiVA7wOWST5j8op5n2+/nN64qyLAi+nivgVz?=
 =?us-ascii?Q?JRoSU/6xzbztfdw5QWDul/uMdqXnaoQxmIOIuL0/A0Nsm2C5DTdfRMx6wNd5?=
 =?us-ascii?Q?lTqU8xKeAiK0mUPVKumBA/JMZBgPVGYatwNEdRN+QTnDQm5iF/q+/i0KZKNK?=
 =?us-ascii?Q?ijmepazBLj110Tvm37+otJz/cvXKCWle9CA3tdLcepip8yZE++kwYSFpke3I?=
 =?us-ascii?Q?4MMhRkWVLFLraACYoBwHGw+ZQ0OZzxKRu23n7lfh/RHclLo5u0a5VsiLtOQn?=
 =?us-ascii?Q?p2hc4NuMlEfjSZGZZXoqidv2lzQCYETD9xlN+DoMypQxtlfEgDEuU2PFD1iu?=
 =?us-ascii?Q?bZAinB1dSS0nyY1OZ8vVMOrd7D9ByVgI+94h1B13sJXRfMSICd6e3PfG9ZKv?=
 =?us-ascii?Q?R8GhHAe2TJJhLN7ironC4M7AGwxkt0UMopdEnEjytPunGkoqflkTtIIOpssP?=
 =?us-ascii?Q?3UeqQmoQgD4gzNrnMyAFkJuI3OjaOUxJQ4JPCEXmJSTtL2iXxD4pjd9MaJhc?=
 =?us-ascii?Q?UoPIrJUhy4m1J8p7uKMD2jylmxfLG+vULjftdPYoyB6U1JD24670wZaYk4Wq?=
 =?us-ascii?Q?EF8Uc24BCPvGSFGLq6ZTBJ4dQdOWY1EsjF8eRFmc/dIKBUJ+hks9a0u2A/Mk?=
 =?us-ascii?Q?lYbDQio8aQh1NR1eNBn8i3Jyheaf86sZlNloy8Vz4K/sezr32Wu9T85zF/y+?=
 =?us-ascii?Q?6IjoYkVvZKE0DepsrUfOYIwKiOV2gKZuUxSalcS81OMf0zau0tbCNn+90cJk?=
 =?us-ascii?Q?cCcEUs10dPmo1xNo60mfpKXj0LeZsC9PbsGN+XNEUUuxkFZxITS87uyzYkIv?=
 =?us-ascii?Q?WwqAeYcciF7XJVpEAR6CgqpYv/L7JCZcq+OsdAagUfofDK/bEFdt7Smcxtvu?=
 =?us-ascii?Q?LDiTrNB55K+LEveytnV/Si1TBocSlzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D0BB47C8B691444BCC967CA796CA3F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dacbe9-4cd9-469a-b4b0-08da487f2d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 12:13:48.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: My3MusFok+NklIaPWT0OYuCX/cbjlImDizuPUeIaTMx7EDgxOvAeeQsjUoH/Z2had0i8v1ewso02L/3ny+GBhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3891
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 06, 2022 at 04:21:36PM +0200, Jan Kara wrote:
> On Mon 06-06-22 12:42:02, Jan Kara wrote:
> > On Thu 02-06-22 10:53:29, Damien Le Moal wrote:
> > > But to avoid the performance regression you observed, we really need =
to be 100%
> > > sure that all bios have their ->bi_ioprio field correctly initialized=
. Something
> > > like:
> > >=20
> > > void bio_set_effective_ioprio(struct *bio)
> > > {
> > > 	switch (IOPRIO_PRIO_CLASS(bio->bi_ioprio)) {
> > > 	case IOPRIO_CLASS_RT:
> > > 	case IOPRIO_CLASS_BE:
> > > 	case IOPRIO_CLASS_IDLE:
> > > 		/*
> > > 		 * the bio ioprio was already set from an aio kiocb ioprio
> > > 		 * (aio->aio_reqprio) or from the issuer context ioprio if that
> > > 		 * context used ioprio_set().
> > > 		 */;
> > > 		return;
> > > 	case IOPRIO_CLASS_NONE:
> > > 	default:
> > > 		/* Use the current task CPU priority */
> > > 		bio->ioprio =3D
> > > 			IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> > > 					  task_nice_ioprio(current));
> > > 		return;
> > > 	}
> > > }
> > >=20
> > > being called before a bio is inserted in a scheduler or bypass insert=
ed in the
> > > dispatch queues should result in all BIOs having an ioprio that is se=
t to
> > > something other than IOPRIO_CLASS_NONE. And the obvious place may be =
simply at
> > > the beginning of submit_bio(), before submit_bio_noacct() is called.
> > >=20
> > > I am tempted to argue that block device drivers should never see any =
req
> > > with an ioprio set to IOPRIO_CLASS_NONE, which means that no bio shou=
ld
> > > ever enter the block stack with that ioprio either. With the above
> > > solution, bios from DM targets submitted with submit_bio_noacct() cou=
ld
> > > still have IOPRIO_CLASS_NONE...  So would submit_bio_noacct() be the
> > > better place to call the effective ioprio helper ?
> >=20
> > Yes, I also think it would be the cleanest if we made sure bio->ioprio =
is
> > always set to some value other than IOPRIO_CLASS_NONE. I'll see how we =
can
> > make that happen in the least painful way :). Thanks for your input!
>=20
> When looking into this I've hit a snag: ioprio rq_qos policy relies on th=
e
> fact that bio->bi_ioprio remains at 0 (unless explicitely set to some oth=
er
> value by userspace) until we call rq_qos_track() in blk_mq_submit_bio().
> BTW this happens after we have attempted to merge the bio to existing
> requests so ioprio rq_qos policy is going to show strange behavior wrt
> merging - most of the bios will not be able to merge to existing queued
> requests due to ioprio mismatch.
>=20
> I'd say .track hook gets called too late to properly set bio->bi_ioprio.
> Shouldn't we set the io priority much earlier - I'd be tempted to use
> bio_associate_blkg_from_css() for this... What do people think?

Hello Jan,

bio_associate_blkg_from_css() is just an empty stub if CONFIG_BLK_CGROUP
is not set.

Having the effective ioprio set should correctly shouldn't depend on if
CONFIG_BLK_CGROUP is set or not, no?

The function name bio_associate_blkg_from_css() (css - cgroup_subsys_state)
also seems to imply that it should only perform cgroup related things, no?

AFAICT, both bfq and mq-deadline can currently prioritize requests without
CONFIG_BLK_CGROUP enabled.


Kind regards,
Niklas=
