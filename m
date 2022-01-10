Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC3DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 16:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiAJQXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 11:23:02 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:45690 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237222AbiAJQXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 11:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641831781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7j3knFXN7WIyBx4QQeU2uzngo8evtbD6al1IEbYXIKs=;
        b=THp821q0l71L9kqO9y0kCMP2OXSn/0yeMZag5QEpE1MBf4CTXQVfFDNVTJ1kWzudncEX3s
        d7/jkE16jNtu5j/yHgK67sKOU6mOOqlf/zWC2LknjXqmbRrtO3tCx7h2KEygO13J1lsTi0
        g7RKjZxhMaZoYh39sXKPZPZ/pbgeHC4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-Z8AgYMMdPc-1Vc9jTeu2zw-2; Mon, 10 Jan 2022 17:23:00 +0100
X-MC-Unique: Z8AgYMMdPc-1Vc9jTeu2zw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAxd3P8dyZ/B7AVU3/rxnpQKYyxj+Rh3N5G1sSYjJeR58vdctcJPraouE4Lc+i3+2X1xslG3NtSfFgCql4njZBU67Fp6MNnicQSrPkdq39yCHTK313igY9t1eTenvae6KQgmCBdhhqkDW3qxnCG0vk4+E9LuaahpxqYzNVR4KBjByJexBEgchDr8aJCcV1E9S8GcMEgdO8A4YPCJ43UUWLqVfQQWojgmePRSgmSGELDwaWoqBZzMVDqWd0GziZtYuP+MrDiQAFrKxpcOBe0vbNR4unxws2BPcXnNZPj6sbgivl5M/aitNsmqbFYx5rUodgJ0XS89tx2/dwd7Dg284w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j3knFXN7WIyBx4QQeU2uzngo8evtbD6al1IEbYXIKs=;
 b=cAiOijcnVeMz2ztbfUQSt9rDct/p/Op5ylNmLhh/jCbR09PF5sG1YjZUGpqAKQc5hVYhjsiSTNgEXJUnSLExKl4Z9hUrlZT6shv3eBVaIIJzy2e8xkpUV/ew+vmZ5hiXpD7L20xOrYKBriluj4JAFK2AuE2f5qxiYMuYRQ3gB3laFVnrre2S1t3fi0TR4/tnWNwuh9MfofSyryVZN2veVXj2VljWhbhIoCykRsIJ3JXFPAoeyhFdQA29Pc4EjxbUlDWIKa4j1ohqeB0nrgaiNKXrsrlepfvKJdzVuw8+pfpkWCahFn2cSDBUbAKJnob4aDHy0ViW1EvKVLcCRrxQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com (2603:10a6:10:103::20)
 by DBBPR04MB6155.eurprd04.prod.outlook.com (2603:10a6:10:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 16:22:57 +0000
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::11e7:5ef4:4a27:62a9]) by DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::11e7:5ef4:4a27:62a9%6]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 16:22:57 +0000
From:   Martin Wilck <martin.wilck@suse.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] lib/sbitmap: kill 'depth' from sbitmap_word
Thread-Topic: [PATCH] lib/sbitmap: kill 'depth' from sbitmap_word
Thread-Index: AQHYBcRvy91RkLONmk6CKigjG4w05axbfm+AgAAMY4CAAAFUAIAA5PaA
Date:   Mon, 10 Jan 2022 16:22:56 +0000
Message-ID: <1901954a13ba59a731a5b79b52751060bce5a1f6.camel@suse.com>
References: <20220110015007.326561-1-ming.lei@redhat.com>
         <020ba538-bb41-c827-1290-c2939bf8940c@kernel.dk> <YducMfW4vhk15CMq@T590>
         <8e24bd70-a817-ff8d-c59a-3e998e5cb869@kernel.dk>
In-Reply-To: <8e24bd70-a817-ff8d-c59a-3e998e5cb869@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 846311fa-f0e1-47d8-171c-08d9d45576aa
x-ms-traffictypediagnostic: DBBPR04MB6155:EE_
x-microsoft-antispam-prvs: <DBBPR04MB6155BEEF01707BFDE8CFEBD9FC509@DBBPR04MB6155.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egLAB2WURKqLeNuxM9d9h/mKq4clfTy3bxTztBEUeI1NVATT4mwYr/nsRGzJiz+koe23ea6wkGPBQxQ67Se3SIooGwksBr+I7k7ubXlu4OJ+Eg78SVi9f4jruhro/St5+vS5p8lAI1LZs6GE0fFjm2oRwhgYGeahP3BOUx1XHoPESzbevgaxh/oqUR3azrGO44pGN0OxsQr1tGYsPEDa8tNRn4t9DUE34KBId5xkVmw6zwOsmukhFz73szlnNAcZducyvGMRXb4XAfFcGUgIDM35/1lzmozFFGbebsPRI3A2gnxhbOcPP2XODRoLYX2rGgKTO+bKLfBkRC8Qk72zdGStQ3I8f7ylVa48LCB+k4K45QUeypQQus9dP8EVmBtNDmyyBt2A0d4aueFg9AwkXpaJsuDHT5FtxNxgocBysmJNRg4kD02+HRhASA9NbDHGQCWFxc+dbGeAkLVWYrSZK7YUS9uOAajn+b/I+HgHbRedZlNU/wgxF7N3n7UVMlPeHB2Y8uXtFbzCfoGnx4qHq+FBzYRb+Jz9EilCNg1xxjBiPOONbEnv7YRAvMSGLgvC+DQRFlW6YIBpdfjhC662r92LrGpM4JpJ71eCBgv5x0yFFerKuIBGwdz8W3U6vBhgN4xqjovmj+QWnFX6WerEiLfrq/0pQj3PO22q+J9DE1GypajcmbLBHoNqvDZMT3oORwMUOcpfmiNWJ96RTDJblA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6512007)(83380400001)(44832011)(66556008)(508600001)(26005)(186003)(76116006)(316002)(66946007)(91956017)(64756008)(66446008)(86362001)(4326008)(5660300002)(66476007)(110136005)(36756003)(8676002)(122000001)(38100700002)(6486002)(71200400001)(2616005)(38070700005)(53546011)(8936002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?jbzq4m9oQUJO7R7pigtIfLOAxcbPQaEC3i59YaRaRJsx2wUcLvSF1tMMg?=
 =?iso-8859-15?Q?WF9MDgESQDLPHfDeVJXeHGebx5RMnRI/edVLalrKD0XaG4vyACO0YNvCH?=
 =?iso-8859-15?Q?BmgDU24O1N5QByh3OMQf3sCUyROVCZgdog/u1T03XVKIeQG6EQwb5zwfe?=
 =?iso-8859-15?Q?FXYhHNpDeAa9lj5JzSagsrnp9new7njZVxFTNmGDfIoKaBrvk2pXmcgth?=
 =?iso-8859-15?Q?pNRtn/4hvoT2EQ9MD5KbsBL19sJjJXNTHbALNUoYAOt6kWnfdBmPknq1l?=
 =?iso-8859-15?Q?MrOVP6vvTPIIL+Un1M9h/og1HjXM91zC7ab9cF47Lja0ctCqvLE7BqNgG?=
 =?iso-8859-15?Q?z1+OCbrynYFCoWiw+KokWv1vGAW25BJEd3Lp3TFFhZVdJLdbNjaf5aP25?=
 =?iso-8859-15?Q?EU1vA3eMSY4DzFy4kCt8bvV5Vf9sBpGl0ROH+9DzsF4DsJmmIkkq9CmNP?=
 =?iso-8859-15?Q?wZKgf7XuB4botSSNfU9+aQOYAXCk3zdk5L1RZmAxv6SiT/D55nGBMYX/+?=
 =?iso-8859-15?Q?2SzgBhrG48HQbwk81K6odNL14OltfoTAwXHTsBsLisO+3r4fpO1TY3lbI?=
 =?iso-8859-15?Q?ThZO7UtbzYadYNvOk1+9BzcElAtUynoxv0CRLrz4mPwLkSjNY/0nqKxkg?=
 =?iso-8859-15?Q?ZnGqV0NZLJ4N3sLOeEY+qhoa5Vexxr/aLM9RlAhQQ9j4ghLoqKtFvoYrQ?=
 =?iso-8859-15?Q?WhhevpaB2FUmcn3B0XdDhDGc/zrUOSFHACB0nhXf5z8m8xFOJzY/VOQPX?=
 =?iso-8859-15?Q?PutaeQbZiwEAP3T0O5uKzmuFufwmZcY8iavJia9Ukr/czPxd03F5uR6kA?=
 =?iso-8859-15?Q?Rbl9ow91Yn45eYijZFmB60+x8akTApB/3mZuihmWUvebSS1/iTfe6vxm9?=
 =?iso-8859-15?Q?697b6uxD/1Lo03rSQHjHjBnLVl/hbCNoXeUBu+r3QMVDsDpZymITo6uBO?=
 =?iso-8859-15?Q?4xwWUvE8tOcxBJZHxWf3it7GW4FNi+X478v08uLV9v4APHe3QZJo/DXu/?=
 =?iso-8859-15?Q?zuVPZa+/c8hvTCL0UZMoPQzTbIICdbwIDqzRlNRD94vVr9cyAVGMFKL8v?=
 =?iso-8859-15?Q?TFQG8VQgQ7376Eh2baZXYcg3NgcT2yOndwuPHkilyRIVlzCn46AfJtbAM?=
 =?iso-8859-15?Q?9HizGb86MVj7YXdVeNFERzsShVGHzwSf2aDh9doDpNWGbGyD20+rw/qqW?=
 =?iso-8859-15?Q?r/oJWwQfMm8P+/+LHKlgSbU0YjlZHDLQBiqDE47y40M5YSPfhdl7DrLpB?=
 =?iso-8859-15?Q?W7mo6TsRdbhemRM+VfM3l3BLioQ9psJYAwfE42d7GGQroukydyU8WIqtG?=
 =?iso-8859-15?Q?AGPk6Rvt2fNXky8hn/9CDv5RxtWl+EmawgHtZJcjKGkMIvVizMcSGY7JP?=
 =?iso-8859-15?Q?/htZSvGTwxB72ZAY7Yeh0zbQcU4b+6n5fDlES1mJG/hBr+JaSmJBLN4aP?=
 =?iso-8859-15?Q?OtVtgzkE9gJJe+RRcpQme8Facs5IXEmyRgfu03rf/Vx/hx7x9ElVAdxTI?=
 =?iso-8859-15?Q?NyOwkKip0cV89gsmP+5rDEFvum4avUfwsa35SjXB/27H1pGV1v5W3gkgH?=
 =?iso-8859-15?Q?Pxu4KbMHi3fWxAaXMPZJcP+pHkYT3rodQslh0lGjPyszB8Fdq5OZZnaCv?=
 =?iso-8859-15?Q?YEfjMsaP+SXsfahy7dVGN0de+TvPZRSQWDmbXcURPlCEOgbwF11kZ53En?=
 =?iso-8859-15?Q?qxxiSdBDMZOLwyUCmNlA0wZzrcShEPiXk6vDEAxtCuU0Ceg=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <8E068D9C8B19AE44A3E520A92399172D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846311fa-f0e1-47d8-171c-08d9d45576aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 16:22:57.6303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYN/3+x1ckX9JvNo4KIyyM7wUVL4fISZJhV1caCZN+TeqlsqVnO7At89exDCHc5PompemEaBVxuZhwJRF9D2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6155
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

On Sun, 2022-01-09 at 19:43 -0700, Jens Axboe wrote:
> On 1/9/22 7:38 PM, Ming Lei wrote:
> > On Sun, Jan 09, 2022 at 06:54:21PM -0700, Jens Axboe wrote:
> > > On 1/9/22 6:50 PM, Ming Lei wrote:
> > > > Only the last sbitmap_word can have different depth, and all
> > > > the others
> > > > must have same depth of 1U << sb->shift, so not necessary to
> > > > store it in
> > > > sbitmap_word, and it can be retrieved easily and efficiently by
> > > > adding
> > > > one internal helper of __map_depth(sb, index).
> > > >=20
> > > > Not see performance effect when running iops test on null_blk.
> > > >=20
> > > > This way saves us one cacheline(usually 64 words) per each
> > > > sbitmap_word.
> > >=20
> > > We probably want to kill the ____cacheline_aligned_in_smp from
> > > 'word' as
> > > well.
> >=20
> > But sbitmap_deferred_clear_bit() is called in put fast path, then
> > the
> > cacheline becomes shared with get path, and I guess this way isn't
> > expected.
>=20
> Just from 'word', not from 'cleared'. They will still be in separate
> cache lines, but usually doesn't make sense to have the leading
> member
> marked as cacheline aligned, that's a whole struct property at that
> point.
>=20

while discussing this - is there any data about how many separate cache
lines (for either "word" or "cleared") are beneficial for performance?

For bitmap sizes between 4 and 512 bit (on x86_64), the code generates
layouts with 4-8 cache lines, but above that, the number of cache lines
grows linearly with bitmap size. I am wondering whether we should
consider utilizing more of the allocated memory once a certain number
of separate cache lines is exceeded, by accessing additional words in
the existing cache lines.

Could you comment on that?

Thanks,
Martin

