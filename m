Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37673C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 12:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAJMPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjAJMOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 07:14:52 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9B5F9D
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 04:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673352794; x=1704888794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0kTRiZnEVOgsLMKHyZ9aj1zxnv+VlUomlxZ1WOxWjKs=;
  b=Vy8xOTPrOvHN//84ts3hJQgQS1qnvJtOydNCT5G8PvVoBl8oXz3rjtuX
   jMR6NHjt5hKXBvNQxDj0ad7DxLSCi/A94EB+4scwmpqPOXbN7S8C764Nr
   8I8P9+Z1L412ZwU+ZIu+QWJkq6U92ryxj2IwG+1eKentfRXYVe1FSdSnI
   RznElyVJzi/B8R8uAecWdrlDNAnkaOsMMBt8xiHtWy3TFofzjBRfIDeOZ
   YjOSB8EfNqBAoYPY0fSYhbuil0VpLWM7+6p13C7vYhYJpSQdFn5A3u8J7
   BkseXfGEa/TLhtIvC0VDOVeRLznTNI/u5qFIMw2SntLwMZMch0Ed9I9iV
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225489702"
Received: from mail-dm6nam04lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 20:13:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCUGOuGLOCOVpxIG/5uwOkWO6JzF//TtAoYNtbt1PVSVwfo+Xcjzs6BHjg+86eCD9IY6yzlcGG3DJcn2TR0RlPnhodBRuAQvEzYVFDngp48pI7/LWnlaIdeJEYhXNSAMS7BjC0N9AxoE0QoIYtLSg2VIf1Jg+xwJO2Lo30xNKzf1/FL/LksiG3DdkJ21dInMq7otCjabRbpnBSYBhk8XTA53cF9q3F2dqbYYPZigEpEq8trhrQTNcDTn7CosjXhT2XkzQFCpp6UpT9FwRcvq+oidWc1hJiKsrbVP+qZ8yQGUOzJK0YnOlOQEVD+agZWsh6u+OM2cJy3M6kdNMcxo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAIQDSvBoVxPqzYCmjDXK9u53WOSDk0XEvJfWhidtOk=;
 b=W33YejMlOXaEfwKpWq8CWZZDlRF3R2tuG1/ErZfEGs+ZNyZiLEltKrx2aCnxefW8xSw4sS/gBZZbWSwNPKi8hTTssIqLVc2oBigzfcy8L6BMO1ia3436RFG12MXfpSsvqRTMXuwam/9gFsznltwlql98Yz+sO/fVDIqlBSSo2AS5RxV3inXvwg2IVPH0FvSx17G+rUEhVlFswU6LtmwiVqT4M23edr3E6iNTrr9sEYhiu3myg0EKgJahqpRxvnxqMJo1S2ktxm+K1wnbY2/4WzE5u4dvHEKqqQJUcrFXEXt5E9ibwFD8s59cfDXWBAw0RYfYsp64GKXjJt15Q8aFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAIQDSvBoVxPqzYCmjDXK9u53WOSDk0XEvJfWhidtOk=;
 b=N3TItJjgoUu88Grdp0vxxaoMaeXB0DKXf1JQWq3ySuSstmXdmlaZqfj0C8VB54qHi28xsSihdx73QTqTv3co8o5m7GMyCllo+XOuksPsd84P1p8Ti3iWvTMzgWJLIDF9vX6MXLEDi1NDuYVTNP4un0klZZHdzdXv1V30IeFgGEM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN6PR04MB4303.namprd04.prod.outlook.com (2603:10b6:805:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 12:13:10 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 12:13:09 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Subject: Re: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Thread-Topic: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Thread-Index: AQHZJNk3XHj60bP93USrHT1itP8JUg==
Date:   Tue, 10 Jan 2023 12:13:09 +0000
Message-ID: <Y71WVAAVzYEyKedM@x1-carbon>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-3-bvanassche@acm.org>
 <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
 <22912d92-dd0f-8fc9-8dc5-10a81866e4ee@acm.org> <Y701TJtNyj86G1QV@x1-carbon>
 <278a9c42-bfa3-1602-622d-bdbbf72649a6@opensource.wdc.com>
In-Reply-To: <278a9c42-bfa3-1602-622d-bdbbf72649a6@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN6PR04MB4303:EE_
x-ms-office365-filtering-correlation-id: 6af426f4-b0cc-4686-ed43-08daf30409d8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jlVTzCS1A71VfWaNjuK9RNpLu26t/lPIevSr8G8UETxOqBeZ+4wg4MpKxTewH/xKpQ9Ha3eeHAHsIlzIVnzBzN/ZKCdrvlesOvMOzbiP41u4cxW1lyxASixKUGOkTYHxgAY3AbEI0wNGWnJ9dswBlW2hfXYWx//rX/7MByBjUqfaTAqAOEA+MO8FScyUzzAXqZSNPHIMNWvSFBj5aDcJs/bHYYDTJRVRBbvpxW22iwxWFi+WePANFj5gK33f72texkWc0FXbVLO0EaEkRfxphLu0xQO8SkBo83d0MxvhFmu6nWVxsHtuBQsur0qnhznNfA/l20ft/BZNnURi1gH+zc+AyUZuhZNkp0dwB8dxWV2KOATY6RHOIrGHvCVRbTrkqETNf8BhmoIoCMY1BW7qL4qKIBSPE9g6j0g1ng54sYYzEW6x2q55oT10UtgQpbCmdoIymTYOGihsS9EZtrt4AbBgOFYSJ5gNwHUzoHC7CvG3IQp2JwHxj4e/nYulPQL/TlEyMNZO+TlRjx4kccYAALV0gzquyO+vS3oysshCRT1da9nUuvdtwoLwh+aXWpo8KyB+5lkjDs4tGiWMPOAywrytvBJgZv83fYi/5/mxNuZND2lWk/BJ3fPxI0p1bs82qNefIAeT9bEbnkdzIiVVuGQLp7OrZ3iv8s2uOaAQWof3QNfXvRTxlFA5clLUUQS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(53546011)(2906002)(71200400001)(6506007)(6486002)(186003)(478600001)(26005)(6512007)(9686003)(54906003)(316002)(64756008)(66556008)(66446008)(8676002)(76116006)(66946007)(66476007)(4326008)(41300700001)(8936002)(5660300002)(6862004)(33716001)(122000001)(82960400001)(38100700002)(83380400001)(38070700005)(91956017)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgoLhaUsM43e9NxtKQn3y4nFnXcrZGtgFdIwXlsAHuF6/WykicZJarPsvpA2?=
 =?us-ascii?Q?7oDI2454b7I3gFaGvtEM3PGQzGPEKGBfoT4zimVJj+Ec+lf4Fme6Dqfi8B2e?=
 =?us-ascii?Q?xbpaCMFcr3HtX/y2qhKeDibGKpmlXwSU1ogTVLnkA3qwr1STPxjwVkGcYkha?=
 =?us-ascii?Q?8K6pQqpPu0R8sGRkTZ1tdLzL7k4au6wjIt/u099YhlQMX8I3SbFAaXVUALwq?=
 =?us-ascii?Q?zkTJL+QdBx2YZxygX34/tjWQT91BIwkYxUIHQvAUAxnWAx7+vEy/AWsXJcgG?=
 =?us-ascii?Q?8BA62c6EgGQ94JVUSm9AcDuEv6yg/IPlqb+19OSuTYyhO9uIupMTBfmN3XEn?=
 =?us-ascii?Q?npc7TQ66Or40nLxhjFqz/3GCoA4f2bl2LhEAQ6BDchQPRTMimBmWZyTard84?=
 =?us-ascii?Q?i9tUd4tjO13MCcPppQ5UTYic5/qCSxnPBqZJR7NKDBbxB5wzzHvhBGn/X9pk?=
 =?us-ascii?Q?5QNjkkzemnuF3qT3giUdsVOzyXuo2URVHZhXlDVNLVyziDCU/dKC4eF5zmhq?=
 =?us-ascii?Q?NaRztahx8nUIHQfvn0nNYEO2678XsRc9tHzczqvuh1A8m37nM4nQvN249/5e?=
 =?us-ascii?Q?WPau//37jYg0DK9L+k5JsJ7oyN6f0PMrJrkUJdo9JF6JnyTwcflgahX/pXbz?=
 =?us-ascii?Q?sAi3VWODrcC32FtGHKNx41ezPI8ALd+sxq+9ZpsDx2TvS2td8o+m0EED2IU0?=
 =?us-ascii?Q?WjppH6zwa4tzF7wVIzP31NGuHlHi5u9tYy+eouMy+56zduzChtEYOk9gKxtC?=
 =?us-ascii?Q?glX8WmH6jCyOotJb/xNVuzY4kwjn6QPB6q6iRc+68fV8JALAorLsI/zFcvIu?=
 =?us-ascii?Q?+YVIMvtKwuqniZPtytaPSsd6kjRCYdhAvhPI+wmEuJ5H35r6pwVgJVQb15mD?=
 =?us-ascii?Q?S0XPDIMrHGBQeQqo0CoaYL8QZPUXouwHKvkGHl5txdjGIh9Sq7REawVW3T/4?=
 =?us-ascii?Q?We4GkgZOMyq5DjajynBjU4X44613lKZN5a6MB1a2OouFMCnUp+tqxheoWnqu?=
 =?us-ascii?Q?AshiAZtoTLRvXCKPrjpv98kC1g2oPBYe4oO83k70i7A5Uo0JKFfGCLhob80L?=
 =?us-ascii?Q?EDxIT2WIH3Tle6WltNiHojYVpwEf7PWm4Fc5uea/Ly5BLGEXqXmB8DFoiLEV?=
 =?us-ascii?Q?U0wnIXhHuA/ymcdF2izJtm/kw5x/LcMNgKEvISGYAabXHsVD5E825REKhVvw?=
 =?us-ascii?Q?bm/r+FvMdB1Vu6+rQhIlRXPuycDQfVWgeJdp1MDjmOSpn33JSnuICtuEcX/s?=
 =?us-ascii?Q?1dvIR2ZCUoxY8bsu/5fkDWtimrJSxAMrJNgUCsCOUbici7Y7s4/c8KWF2oMb?=
 =?us-ascii?Q?C0yxkpC0j2RkO+puMZQ8DY0dXXp45ln61oNao4m1e1vhU+YZY3t2Zdxoz3Mf?=
 =?us-ascii?Q?v6T/TM4cpzCtSfuNW38b3S36JjHM9UrgbauPb06hHj000IeiW5oWSbxUqNCU?=
 =?us-ascii?Q?DO0hzOPFBv3DozoNHoP2RINSqayhWIvigZ1hYYJLiWUd3bAI0tA0aUPf8bwB?=
 =?us-ascii?Q?TRDUFY2/UuT5e1+pAcMisaFCG3Wox+Cg6nhgplzrTCDdnIHHGqQkIiIlbzGi?=
 =?us-ascii?Q?SBraan+wpsrsZPdUeARtn3dfzjUQdAdFsPuhOgkzJFLCvZbMDgYD0A293lDT?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82B8E181FA2B05489ECF58F7B2C9EB47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JIusjsd9mIrQv/2vfsstkSJPz2OZIwYZN/C3EotYt1ke+jVyIRYFUAKa7gWx8JPLkBRqlzjwylXDOkJnSfylQNZIG7k6GtlWn2F9s0LzwEa3g9O/NHWFXKjl1d7Y0rT9poZ7QRIqdcXrXb4RfjJhzOHCCgez0H7ABcraYtDxLuO2LmdyAqj8bG5KTk4hAGl7Hs+VxcXo1Pfdg+O5UjttHdVM2w8Wbd+on3A1jFeLsCreMZ/US8QkViOWXNYZt+bo9uFHBVdZWdxlJZuL3M3FyBxKcnuv7kZFkCEsShwrBGxFrKMUBfBBcqCh0/L5afkx5gsKEWVXnZM9gIVp5TA0FzB+drr0gpHKSxHEoLxp/+YV0CD3ouieulPelTccOCtdGi5c9mwyEi/5zd8jRhI4AHCCkwp3/v633M2puuY0+6uRiMgpSlIG1OA8GKtRBrlMUdR3kdoLynOmHMo3Pz3H0EjJe1w0Y+c9uIZFoo9MMDwCNpLlgVykfEPpCn7eLVBLq93xGKT4pjLPgOKLVq3WOp2c7QMwGZ488JDotjrkZg6/YLez01aBYxpokJqQKUf3bJpDRLtmLFnCCyEreMjfDT+JGHu0pOx+d+dxI1Anpi3IiV3ktLdkAYKZ0kRdJPfjMJVjwOUFwF1PX7YvNpdze8Rr9Jfhh69kP3AzFlp82dC8y34RtOMb2l3Ln6IgFY7QBEREXKtw3+JkZmBAIbpma7ikQXkf1D93sYMbQP2gPqDMl9ogbNKXT4QPdxtr4VLi6UpqPA5X393x7ayegKQULHfO6a6XjWmqeVdzVfg2skoC/STwVxor/pWRtI8m3SOndwpbC1QgpUY+xXgGPWGqjGIVQb1U1jO31EZGE1QRSvQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af426f4-b0cc-4686-ed43-08daf30409d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 12:13:09.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIZa33VvDQn/KwKk6IyP8hi6TATGCL7HqszEB+WS+RpG0IX1mrA7NSAa5ArgOX2bf5UqNvbColVukkI2e8VmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 10, 2023 at 08:54:24PM +0900, Damien Le Moal wrote:
> On 1/10/23 18:52, Niklas Cassel wrote:
> > On Mon, Jan 09, 2023 at 03:52:23PM -0800, Bart Van Assche wrote:
> >> On 1/9/23 15:38, Damien Le Moal wrote:
> >>> On 1/10/23 08:27, Bart Van Assche wrote:
> >>>> +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
> >>>> +{
> >>>> +	switch (req_op(rq)) {
> >>>> +	case REQ_OP_WRITE:
> >>>> +	case REQ_OP_WRITE_ZEROES:
> >>>
> >>> REQ_OP_ZONE_APPEND ?
> >>
> >> I will add REQ_OP_ZONE_APPEND.
> >>
> >=20
> > Hello Bart, Damien,
> >=20
> > +       if (blk_queue_pipeline_zoned_writes(rq->q) &&
> > +           blk_rq_is_seq_zone_write(rq))
> > +               cmd->allowed +=3D rq->q->nr_requests;
> >=20
> > Considering that this function, blk_rq_is_seq_zone_write(), only seems =
to
> > be used to determine if a request should be allowed to be retried, I th=
ink
> > that it is incorrect to add REQ_OP_ZONE_APPEND, since a zone append
> > operation will never result in a ILLEGAL REQUEST/UNALIGNED WRITE COMMAN=
D.
> >=20
> > (If this instead was a function that said which operations that needed =
to
> > be held back, then you would probably need to include REQ_OP_ZONE_APPEN=
D,
> > as otherwise the reordered+retried write would never be able to succeed=
.)
>=20
> Unless UFS defines a zone append operation, REQ_OP_ZONE_APPEND will be
> processed using regular writes in the sd driver.

Sure, but I still think that my point is valid.

A REQ_OP_ZONE_APPEND should never be able to result in a
"UNALIGNED WRITE COMMAND".

If the SCSI REQ_OP_ZONE_APPEND emulation can result in a
"UNALIGNED WRITE COMMAND", I would argue that the SCSI zone append
emulation is faulty.


Kind regards,
Niklas=
