Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15850C46467
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 13:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjACNCb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 08:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbjACNC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 08:02:29 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F1DB1;
        Tue,  3 Jan 2023 05:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672750948; x=1704286948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jFIG7H9zzC/DkeT9RurS6ycqeU/Qrm6jM+RlkIlcTzQ=;
  b=F/PvbzD/ClN6sE0j8LaQPejvo58DFcCWvHqPFHd8B+/NlqQo04VI8CmH
   TPM4fGwapl3bhym3qLVHkY6+4TFPqNA+FOd/8ywDYAzTtQAZpTClPMAsr
   Qbs0pI/rb7JQOdmRGiRFBqAggdst2RgHMrJbyKuICu6/it6Z21/UqsnHV
   LKOwUs1+HpmF49FGCWprrHq3xgCQp/xtigm3aAgBj3cM2w+lIzXqoUmAb
   GLBPz0k041C2hYEk9L8Y+zP+MLKB3HQXnEheQiYSai+ZVluKtx55SKPDk
   V46d3fns8gJC95lHTgemmwqw5+6Xf1qViPZjbnPDP3WdS12kFfhlGLMgJ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,297,1665417600"; 
   d="scan'208";a="220043447"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 21:02:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RInCq0bGnvfakr/iEYL/8dkr1lCSCgo43ndFR2AZLagXRsg/EkLuLp+bJO1TUnB9oOqk3sW/6iiz0Be567i7miqKdb4EN78IWg5NlhD+hrTjZ/8s4nL2+6YU7SnkBzol2E/z823lJ5h+Q32IMZIT9LKVaXgG+G8/S7KROwTnZVKLl2fxTXjC9NYTmQXm0QgLZns8q9dkzBgthPx/S7p01gJKMc2OdYgEgVjqdQTqL4LQvsISETh5NtgMS9i7+/i5hvDi6YAJhp4XJOj5XMYTQ6dr+A40QeoqHPhkBVyNHO7Q2hXkDMhhcsX9YkZ6/xOE4dX/uSzkbAREHAsWrvstvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL45dtcFJhXsLy+bfau6cxpPEuBxk+XCkgrMHgfrHCU=;
 b=nKCKUXw+oB6WjhWLm+E0rddpif86mUURIqnZikwqjsLnY5/+VTr9qLK3Oh6wIVNIfITxs9Q7xoJo0iKUafqbuRqu8ARkN2yOtAYiC3VhrUeZS3TLlcIRzmDxIWRDCfoCTwtwFX7FlsTBki+XHAz4m/hjehxnViaKEh8HynRrt8XAeHS9YJfCSzylDZPK9IJGMibwU3Gm2Eb0inn0nFH+34o468aDb408SPVcMTNr1Uj/eR8NwHEAfk+m1u2x9H+neCO89Ar3G+xHdoB/53ZunAcv7gSbYkPmPKcHs+Pwe+LEb5xzLXaHJKzJFzu8DGvq+8oxzfuo0Daa6Uh+HX7BGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL45dtcFJhXsLy+bfau6cxpPEuBxk+XCkgrMHgfrHCU=;
 b=kmm34x+41nl0+JXZAuJqF/J4yPDbuJklTEb/9/N2SCvX79OrrAUnmApYIRhGFA1QaQMceeCXmltr/Qf4pWIbnrzvYe4KUxK9u8J4KZCEszjx1K7ZMO3qdRmI9dB6OICdOA9UGbVlGQ42qvso/wV597eFFef5UqnBX03BxYvAbzE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA1PR04MB8238.namprd04.prod.outlook.com (2603:10b6:806:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:02:24 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.018; Tue, 3 Jan 2023
 13:02:24 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Topic: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Index: AQHZHzL6SgMkiLYtRkCPdJaLJwZx8q6MqNYA
Date:   Tue, 3 Jan 2023 13:02:24 +0000
Message-ID: <Y7QnXs7ztFdTfChd@x1-carbon>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA1PR04MB8238:EE_
x-ms-office365-filtering-correlation-id: f3b61707-1732-4b7a-0248-08daed8ac207
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIv1bUFUnyX1+9HRCSSo10CdhKkm6+qu5NzQZIMiGeuJRRo+pc3G1cfSlJa/wSmuliV72BdHUBTXFG82XvX4Nm5J2Ar2aP0jamVOER8Lrmu3ZVMtQnZdYwyxOA1oW62zx0Mtmt3SO/2mTNxkt24uvOb+h7xVSflIuTvt/DArEs8dJ11sLfFNW84FvjY6IJgz+GMOXwvfI6KvCrgp71O+FncOP5OMyysNjY3aKuso6/UQlKgTMjgxhzGCfjAp056s/c4XZkYappY7Cca1yZEeky77+EGpnIWScgTjgTw9i5zOIyHDDqM2ZCLtuMt9/3OK/UTPkOSNjZy/1NEABPjLFhrz28BsfQL7ncHluecRHPWc10eM/Lj2VBS4irXybip1L9lNOIu1DHO+e/EFuBqASAXe53/4mfbJkmN3XRP+NM9IY/i4mpbWeTe/MFKsF3HY0Jw3tBWQQCeCsLGmXDs6adNclpM+VKzjemh78XBjDGa8YKnmMBTOTy5JxDyqHeo2c6DHFHVTzJcKl5DWGUEM6ZQRzcqYfkohlSRpAi+EFMNna92lotdI4au1WzYZgR0KpWQ0ByzaZijomh1Z4/RoyhA4hFr9GAgDwSM0NEDqO9yWIN34NoLiSQvZKvvJmKuG5KkzjsBkxXIWVoqybPICg452KgicG9uvA8hKgb+PNwQj2/5su0o3Aa+3lpY7O00IT/IxZzVSmX522p4LoJmQ0HQcZW9w7VYJMlWD6H7u6l4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(2906002)(8936002)(5660300002)(6862004)(41300700001)(478600001)(33716001)(26005)(186003)(9686003)(66476007)(6506007)(8676002)(91956017)(6512007)(4326008)(316002)(66446008)(64756008)(71200400001)(66556008)(54906003)(66946007)(6486002)(76116006)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?reS3KE+YLwIEwL/SLwaUw6xEN5opN6ypdefV+9Z+f1omz1RdjTEKeiuKHnGL?=
 =?us-ascii?Q?iBkx/7g/EODQfvzvG05ZZ1BfDFtjyQBDQMOpOqO0NATOtP11e0ViV4mgl7EW?=
 =?us-ascii?Q?Fnm4hJAzDS1VxcMQeHYA+bZk65rGLVbFCTo1XHPN0DI6maY7gf4qGGyitCcf?=
 =?us-ascii?Q?wk0n0mRfwLn8EGXQcVZLKO964U6qOMniKoJu4joLJtyAm57nmDZklKsOPb8V?=
 =?us-ascii?Q?CjDy4KKqV4OJT88glTA0YfNZA/PWH/IRze/3cBhSfml9wWQw/DRU/05HrA4a?=
 =?us-ascii?Q?tyvdcI7eZZwVoYLBKE791F0SsEVbdrxzLaw0qamGSrgEg3kdSSOB/UABKsB9?=
 =?us-ascii?Q?DLRiGAfrbA/VSVpN2L+C1DfhcFF7Z5tErU6dw5lWIx6xrg12Gx6/1shDYxRr?=
 =?us-ascii?Q?HWQshMxRi/nBm0962dfKItc2N1BsG3UVPm9/Furq2fmOif3/NSB89KNe1/Ro?=
 =?us-ascii?Q?7VBTyBmR7NKs1hvCsj34VXecOjj/jvmg6/0sphuQoXiGKK3lMPa9srqt8KIx?=
 =?us-ascii?Q?vxlsGQ3roFZjz8p25x2HU62WHm0ADNETQ3Lu1oO+HoVEEz9B9o8cv2Z96zPv?=
 =?us-ascii?Q?dMVuCQUeZ+DZ6iHsOnQ1gNqsjKqq141jMh/3BSXzgzkqMfAOMqgGfELsRfiw?=
 =?us-ascii?Q?uveQdRSVEgYZCy1uafsHYZvTEOEeQ68fOwDGfZLby4p1S0K34gFNYnLioFab?=
 =?us-ascii?Q?x2AFo5Kg2butRbhUFNJ3qQerLoL6GgsxvcapafvPU/FmGvEwP/e7HxyrfzNN?=
 =?us-ascii?Q?6lLRGGKYBytP1/a6tkLmcPnE6UcmqHEifmlPWuCvaqu9xa0RkNGyTCow9Cgg?=
 =?us-ascii?Q?OKH6ib/wSWXPoYYZ4FN20Kh+8cz7iyBtIRBpPFJZnqLzsbeSyQfb3Vq7GrZn?=
 =?us-ascii?Q?PRtc7bxSJtD7I6wpDAyiXDBc1yJCoL2BU0mqtzpz3ifcLrYwEoVklO5b5vSb?=
 =?us-ascii?Q?vSwouTKiVE0/9nMGnSsPj3PhcatYoNvxxGbASKrQT0xXP/1bPSly6vNEiIds?=
 =?us-ascii?Q?MeTgpN46vuoQdxir+S9TBUkKb6Pn1P2mH0dxQD0CDcCS07B3OCdMzRyuJ/ln?=
 =?us-ascii?Q?i1OJkK6fhmdF4pKmRRYpG/8U3LUSe+cS9q5YeTCOAaWw+kVhvrTUC3gT+bZ7?=
 =?us-ascii?Q?Ub73C+Y6G9Fs0xthiYJK9tAQtQVyclGB8F9/ONxCE0StwCKJ7RPujEiKcxI7?=
 =?us-ascii?Q?JX8kOlBW0u/QFUATBL2p96o4QjvmZVjpdqGuucqxC0mjO2WV+aqDc7OqiphV?=
 =?us-ascii?Q?7x4QhjwZipAF8nM0SP9zk214wWTKHYN9SK8IVI2phl4l8h/T4JM3C4JmqkW5?=
 =?us-ascii?Q?ePpJpkX/DA0YG6+r8N05QoXjToAe35YN6NH4o7V5tWVHDGtz8IoNpgt9+z3Y?=
 =?us-ascii?Q?3TwQXyyTBBODqH4H0P4vpP6m1hwcWN/yLv02corGo2b1QncjrRgObgnUEmqq?=
 =?us-ascii?Q?EOSEAenO32WHINCC1LGP133/+FTes7APcJfZSCNvSKebF/2SeABQzRSYNPkp?=
 =?us-ascii?Q?pJmGuvv1KPM9qoKWqgLV5F6pgSlEA/0WQMizVBjv6phRu3cpUeO/86dAnphn?=
 =?us-ascii?Q?896n7jHAIXmO+rarV3s2xXz2ppk66MTZvQwCoYJAfvMAtjpRAJfan2jV16IX?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46E5884796C3B7448B60906CD2E4A154@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mLVmIDTUa/EtwEfSaqgQt29RbLDK5WvL/MBq1QboLOojvw92iLV9w0ChKdN3?=
 =?us-ascii?Q?KvPqPr/C+SWepwe4mha34p1ABOqoPsVO1Ohs3Y0tcnk4J2hDb7RvWAFaxABv?=
 =?us-ascii?Q?X/G/wMDUlUO2A7KEonajADC+eWrxNFOLx2Bfom+A03Xi7rmgfddCHwK45Wtc?=
 =?us-ascii?Q?YOqGknqHhkoNaMvqexw7keiCbVJHWBSq0iNf8U8+wB20TEFGCzZicnzXukla?=
 =?us-ascii?Q?md9ZCrUstkoR1DJp/IATD2i3a2NzKE2RcCb7ZIuZeDx9Rt+MWTYJcl15bFnD?=
 =?us-ascii?Q?eutKCEPHZo5pRhhcxyAIWCvz5JXJtK6rGbcWoqCzSC7Qm/MosFyHy7wA0rQm?=
 =?us-ascii?Q?EN8iEDxU0/CD5rSjGvu4Ub11mKugkA1qsezdCLQ1uwvDIphI6cCHITLetYMQ?=
 =?us-ascii?Q?lbhW8VaqLzeRerJ+1ud3vcoTaOIhKGsUhBB40rOV4SjuKukETDjZx55DhpIw?=
 =?us-ascii?Q?1fN1xKpgIlGUWx3gmr8KZvDHYfemT65EZOdfiWbR6jOmHGJDbcWsZh+eCtLW?=
 =?us-ascii?Q?JmhrKlom+3TyIyhDCzfyJ+HB6IRlP/ofnN8rCSRAepXuOIpCPG5/S/YJaJdJ?=
 =?us-ascii?Q?s6gY3lWrXJt9d7PzA9kxoeoyL/Ez+R0pP4uwJ9eLS7T9sfblM8IaySP0xyGz?=
 =?us-ascii?Q?k9NDb1pXUb++N8L/Z9kN7W8lm7ciFFoHmsjYQzMpcC+CkhJeHGDRt/nr54K7?=
 =?us-ascii?Q?de9BGvLINXC7H7miOVdj+Mp2tBCuNIjlZ/R9KH+umQAqEv+IO/TKONZkK9cG?=
 =?us-ascii?Q?CYn7hQxZEVD+c/YrwTKPRI22SdvGjpEmeDFpO12/QL/55jHr2oIjn6OPkW/V?=
 =?us-ascii?Q?qmUF/iLeB+N7pE8STe1EKBzgm7MAUmptoKBTfGReAg4J1pTxIUMBrAMLCquO?=
 =?us-ascii?Q?B+QSIXbjGIVmes4osidYwJbIrQ5kxM1i5+c2mTzaqkYiRRnarQ8qXyrpMDg1?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b61707-1732-4b7a-0248-08daed8ac207
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 13:02:24.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kY7bBXKrwpiIHIAL3DKAj14zN1tMT3MESv8emRUBm6vZakw+gkuz3jmcMkpErISkc8Lg3jSONEXNvvFGD/uNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8238
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 03, 2023 at 02:19:18PM +0900, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
>=20
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
>=20
> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
> these are data write operations used by btrfs and zonefs and may also
> have the REQ_FUA bit set.
>=20
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  block/blk-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..c644aac498ef 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
>  	 * Filter flush bio's early so that bio based drivers without flush
>  	 * support don't have to worry about them.
>  	 */
> -	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> -		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
> -		if (!bio_sectors(bio)) {
> -			status =3D BLK_STS_OK;
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE &&
> +				 bio_op(bio) !=3D REQ_OP_ZONE_APPEND))
>  			goto end_io;
> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> +			bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
> +			if (!bio_sectors(bio)) {
> +				status =3D BLK_STS_OK;
> +				goto end_io;
> +			}
>  		}
>  	}
> =20
> --=20
> 2.39.0
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
