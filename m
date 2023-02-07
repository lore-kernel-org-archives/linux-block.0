Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82EDC636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjBGJlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 04:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjBGJlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 04:41:02 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133A4224
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675762861; x=1707298861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EkdcgZjfx140dHwJfKTAtiU/81c1BrZ2HUqxpJ/aCpM=;
  b=GBTctKo9hhQujwui3P+c2t2ghx4fwixqcjtRTPKF1qTMQGrv6TA6Rxet
   /ypsdf1jAhLh0NFWqdDwTw1FAhcCemmLdujWGmZt7JgANMjeGHFP1fqdM
   RFmAlZwQ+4oJ6Is3R4HXalXZFYjLEaUXpv9i8zBeAamPZooDPPN9TOctu
   zYgwis2maFJCHvJSSoVBmvbq0JB0adbETAd7tdIlrCcRwIUCajZQTjrFc
   7M1zlxAVPCSda/WYALFy6WVJlS1UcPsrXfkBxVgR4CLigm4ISxPJ6+Pyg
   2GE23XGYK56QMzmsQ9OfizHZ5PYLl6IT7XOODeFKUCh0BtH/ho9K/qxIV
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669046400"; 
   d="scan'208";a="222495802"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2023 17:41:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O63SLc2EK0odXzmpkc+iyjwZrUfdkw6k7kU7ddvxvaGbgc+lP1kDUdzWoUtxAq/KdB+qYLBUYpCvKmHWOhGl/q5X9D1rMKreO/QziYdXYoWZVEgRMQ4oExmDjVXoiRah1seUxFphiLcGAzRpd5HlNaFkCJpMJWC8AqitSWkmaR9gykJatP7USTu1N9GXFZB+YWOLZSz6d4vd6aPZ90EEwXWJ6NJnpaiEW0X7CQq834GdfcuW6yG9g/WB6G6T0vsjUmDTWEsqKBaeuYITV0VsN6hWxzCjzgga0KYnCzd5IY1kAyL0Sx8/HgLdqcSBp4t6zuuMiYH0Ob+fqJwqbyYI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkdcgZjfx140dHwJfKTAtiU/81c1BrZ2HUqxpJ/aCpM=;
 b=al7D1P6KRH/xqVrkeCtW7NuAd8otXlVkmEpLhswqopJ0wD5wzd6Su8gkrMyGGoIrdGckIlfM6jkHzj9cOZMQ4LAdgPP63FNQQyZob1GdM/xw7U3/l3HO+PvMzc0PDsC5cjE6MRia6WUz1ohXVl8GOU9scDgldfp3hycCOtpfwF+le0vxohYZeWQerSyjKeoT2eV5/cSwflqlee/NEB1WRYSxKI3ED94fzniVMvj7z8jqglV2w29vjWR7jGLcl7dLpxISJM06Uo+10nlCCEdjcJ0vZZjX7XIdoyU/n8PWXZ6cNw+tHcNS3VWznpemoa1j620iTtSAPY9pReRqANc6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkdcgZjfx140dHwJfKTAtiU/81c1BrZ2HUqxpJ/aCpM=;
 b=XtJdcxl2L4VmLEe0VYtMZy5Etrsl8C1CsCXqSoqWmenUiE1q669wTnodEyMXQFhBUgRmaGorXxpoK6RiF5MoPygrL9smovBoICfpLlI3eWS6Gy1YqB5aYZ5ToPBRg93qPz5VVIbN9E21kK71t7usf3eBOweBOMLepIwF1nOZjKI=
Received: from BN8PR04MB6417.namprd04.prod.outlook.com (2603:10b6:408:d9::23)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 09:40:58 +0000
Received: from BN8PR04MB6417.namprd04.prod.outlook.com
 ([fe80::11f5:2a3a:5b5c:63ce]) by BN8PR04MB6417.namprd04.prod.outlook.com
 ([fe80::11f5:2a3a:5b5c:63ce%7]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 09:40:58 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>,
        "Barczak, Mariusz" <mariusz.barczak@intel.com>,
        "Malikowski, Wojciech" <wojciech.malikowski@intel.com>
Subject: RE: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Thread-Topic: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Thread-Index: AQHZOhHSKPSlOHoOkUKnFFq3rkeAba7B3rKAgAAbshCAAEPkAIAA+mhw
Date:   Tue, 7 Feb 2023 09:40:58 +0000
Message-ID: <BN8PR04MB6417FF274F763EF9D864D050F1DB9@BN8PR04MB6417.namprd04.prod.outlook.com>
References: <20230206100019.GA6704@gsv> <Y+D3Sy8v3taelXvF@T590>
 <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
 <a25e02a6-4f79-da85-bf35-427b7a523aec@acm.org>
In-Reply-To: <a25e02a6-4f79-da85-bf35-427b7a523aec@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR04MB6417:EE_|SJ0PR04MB7261:EE_
x-ms-office365-filtering-correlation-id: e1a7f026-6269-40a8-066e-08db08ef6aae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f0RTjfJuJ32G0cQ9eA3kqFgIfiUulLq6qZdL/Rb/2Nad1g93/q735/XwtQsZlk9Jb5D+qKOtdf5ijoaMg4dGi6dKV3M2xsj45RXYdiN5oS6jOyQLeg6LVAubxb7nNl2NsrWhWdnu+fTWHyevIb3BBakJw3qE5qWlqCJEBWlwjTNAopBKoHHwQB+RtyzFO/gnHUX5XDwK/wCGL9tGf8iBXwKO7K8mDJ12uXShgZHnHiBWdNRnGFfvazN6t0X/Dypx5/+PwqFrLStBE1bZg2OACPn1SI1HXFicjLJqhCquSkoyXsA9SVZ7NIb79aKB9gDN0rhM4mCC5biup60sxo7Uv9uQjzRWJL39cVE04h/UhIRTY4+KNkuY+V1OBlDAFRv+ppHZb8D0dhnQzZChrARL3DYvxkJXiwDk8L2JL9Vw6wZaoSrJl0J5iFqMNXsljFrKq2MKGLQBPM7s0dZI0WsaOexJo9kifbmrUwru89nUIUGGZUUNPnOviTtXj8MQgGJWIYug8eEroNFb7tyL+Wh8uAUvxpmzL0Fz2AXEkmVTAZhSI/5+l2dPRxTMDuTAwivgodMIiTNfH5g8VqgAWiLKDjD0/AjHYpW4vgTEBxuGZumLLpbZQj/82Jx4d4sQe9jwUq3Dw5qh7i4YTN7EfR0/yEZGgkk6l+o5y2mJR0XUGowa+CozZrY1kexnTjZCwf2N2uQbcUOagUTEGY/+mjKFXnukEINjjOAwjgEdsycnb+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR04MB6417.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(76116006)(4326008)(66946007)(71200400001)(6636002)(66556008)(64756008)(66446008)(66476007)(110136005)(54906003)(55016003)(8676002)(83380400001)(316002)(85202003)(966005)(478600001)(7696005)(186003)(26005)(9686003)(6506007)(52536014)(7416002)(5660300002)(41300700001)(8936002)(2906002)(82960400001)(33656002)(85182001)(38070700005)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckp1YldGTkk5aXJXNWxOK1hudU80enhSSUdlbEdQWmFhQTRHMUxVUE1HNHpW?=
 =?utf-8?B?SGxOTFovcHlNNURZc0sxSFQwbmRvT2lwUlkwV2JNTmxoTi9NK1RMUDc0NUFn?=
 =?utf-8?B?bnU2a1RVL2JNUGxTOERvVmxRRFV1Y1FjcTN5aFJLQ1ZKcGJBQUN1dEFuM0ZO?=
 =?utf-8?B?S2tRdDJZbFFsdW1sbjV5c2dmbGxPbFBrbC85TVd1UnJzbU9QeElPZkNRQXlL?=
 =?utf-8?B?RTlyWHhCSmFYcER2ZlhOYWo1OFZVUG5kTnNwczFudkxRUjA1eVc4eC80cVp3?=
 =?utf-8?B?L2MrWTF2VmhpSGt5eFJ6MTlCOFJGM1BNMVNkMmVVNkhWeGJPaEM4citQcTB5?=
 =?utf-8?B?TDVGZlRNM0FaTTIxVjBsYncvaGNIa2tCV1RBV3R5RXlNL1hiUHpDN2Y3bDNr?=
 =?utf-8?B?MmNYR1ZGYS9ZTHlRVGx1eXEwd1R4YSt4YmRUWVUwRkNQbjFuN1BRMnJ1RGx3?=
 =?utf-8?B?amxKRklFNVZBMnVEUVovbk5CdlMramJQM09hWlZLNWlDVzZ5TFVYaWE1SWZl?=
 =?utf-8?B?enJUOVFodjVmWXpQQWZ1TStDZFR3dVljU3NiNlpST0poNmhRdkc5bkE4RXRT?=
 =?utf-8?B?d0cxWFdjRXNhQzdsNjhLa3VpWEJRcVhNbG1aU0s4UFRpY0xCTEhPdWQ4WnV6?=
 =?utf-8?B?ZEtyb24zQUZVY0RsZWFsd2x0OFJOK21HbmVSdGk5YzBCTzNMZi9IUEI0K3Rm?=
 =?utf-8?B?dUNWK0FuNjhrUkN0NjVDcGpaSFY5Nk5adXVMYzc1dHhWT2ZRS3ZRbEZTYzQx?=
 =?utf-8?B?V3F3QVVNN0hhMXk1cE0rYk11Nml3bnB5WnRQbXYwdUlCVGM5NVlmSjgwVEhn?=
 =?utf-8?B?YVJPaXB4MEdaSmxlMFp6UnJOOWp3Qk5zeUxhNHp3ME5LYkdNcU96WFY4bWFj?=
 =?utf-8?B?eXFFbU81cHZNMVdzMUxOaEYweFhDclpaZHhtV2xQUmI2ejNVWVBkYXJLN0Qx?=
 =?utf-8?B?K3BrSTBreUdEVTNWZjJ2Rm95OUk5YjUrVzlQeVREZ3VWb21OaGs5UmUzTDA1?=
 =?utf-8?B?NnlVbnhBeWg3RjZxTjNLQXB4SUduWjFUaDlkMlVHMkU4TjhydEozdTJ0UC9X?=
 =?utf-8?B?REUrdkYvbEZlTW1kVkJ5dENMc0c0S1cvd29vcG80SlViZnZKMkNHOC9NT2Vx?=
 =?utf-8?B?cEYxcUZQWHNicys2S3B1NGd3NWNINjUwaTgwZmwvUHpyWENyM0xOb1lIeE41?=
 =?utf-8?B?TmRrd2Y1VjdzRGpDRm5VKy9zTncvS0pBRnZ6ZVZDR3VtMFN0U2t6RGV6Y3dW?=
 =?utf-8?B?U0lwWFBkZkpQQzM1OHdJSnd3QTIwc1I3Umd0b0FuTnp5RzUwanRhMlVmYXhN?=
 =?utf-8?B?VTBNQVI5YmJLY3JVUmlKcVY3bHU5L3MwT3JKaEtaWWlHV2p4cEpNVlJERUsw?=
 =?utf-8?B?WjR2bTFvL2NPaHJGSDRhT3FIblk3SXA4YTV3Q0V5SG9tRmMwdWUwckZBekla?=
 =?utf-8?B?b25aK0drdERpQk9sRHIzb1kwMytpZDlhclFVVmhEZlpmVW9mMjdYVHZWem96?=
 =?utf-8?B?VFRveXFqMkRKOVFJUWdxRUVHajJuRDBub0RSZkxJOEl1TlFKKzVVT081aWhi?=
 =?utf-8?B?WWRSZnR6K01EWVNnaTRianpxRzZjSHdTZ3pLSzhvQVphcWFIR0xna0VYMWFQ?=
 =?utf-8?B?L2JKdVdFZzYxNEwyNE1tRnNXdWdtSlhJTk1PZGxYSGJ2aWxvTnpuWlM3M2Ir?=
 =?utf-8?B?MjdSOVVDK0R5dmdCSXQyUForYUFLYkdVdVRXOEJGWndxTXlKZmxZK1RDR1pv?=
 =?utf-8?B?WGo5YU15RkRwL0lPdUFtZUtJWXAwRTF3dWgybmx1cDdpRjVEZStNZHJJbElz?=
 =?utf-8?B?a1U5NTBDWXBQWXBsMEhaZnJibWdodGE2R2VHRFpXRlFmUHNDdHIwTnhySEJN?=
 =?utf-8?B?VXp4UUVnSmJOdkYrcXl5WWF5SzArcCtVVW1tOGQrRzdRbzVNVWZLNGI2UW9B?=
 =?utf-8?B?dXA2Ulg1L1NXR3V6RDUxZWpUYzY4NVdPOXNXV2U0eENzSzlkcS96YWFwTmFv?=
 =?utf-8?B?c0UyV2srK0RYWWFGREdXQ2FGT29KdGJqcktkZ282M2ZuUzBtaVpVYUhaemZy?=
 =?utf-8?B?b1ZDRWxOZDZCbzVyNmxRUzVreGVhVGRFckNYNlcrZzJJVEcxWFRvOXcwWU1a?=
 =?utf-8?Q?aC9QIySPY8K2JSoa5TAuArOn7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b0tiU1QvcHAwVk0yRDQ0UkdCRUVlK1MrQTNCZDVIVXRPenh4ekZxbUMwL0tG?=
 =?utf-8?B?anBZNHI4Ny9obWcvaEFabkhjZVViV0dnc2hYMkNuWUNHSWpXVU9CNnd2YnRT?=
 =?utf-8?B?OWRLbXlwUjdwOEt0TWcrNW1IYkxTTkdsbUFmcHRvV3J2RGtRU1pHZzY1ZVBW?=
 =?utf-8?B?MjE4bkZ3emZuVlhHUHd5UjRCNXFpbExDQXpzR2M1Z3JIRlErOG5kQjd6bWFX?=
 =?utf-8?B?OS9wRWg5YVJaYzI0NjBjcUc4R1pReVFmd2NxZWZ4OWQxT0pnajlXelhYTEdk?=
 =?utf-8?B?cHlKRWNSR3hjeUtwbG95NmRwcGZ2UWtGYm1CZ1Q0MCszTTYxTjdvbTZOdGM4?=
 =?utf-8?B?cUtBNUU1SWZwdWVKVFZQVncrVjFic1hkK1VnT1djaWRjNXBsSExnL3MwRHRV?=
 =?utf-8?B?NzAwdW9GVVBRUWZJZjkxRnFUZ0JxdERJMUhsb3ZrZ0N2aWt6emFtWlhJSVVI?=
 =?utf-8?B?SDdZTUYvOGtTSGR3SGo2VHpZd2xEUEFxT3ZZODlscHhzMVNHcTN1Mzc2VjNM?=
 =?utf-8?B?L2JzRlRuV0Iyd1g3UDYrYVU0alhNSCtVQlRNRzNyV3Rha1N1VjFiRXFvNDZF?=
 =?utf-8?B?c2d6Vnp0NkR0TEYyejRsSTVuK0JVZU5VQ2h6Uy9UYmNPVnlMVWhPRG5WN1lN?=
 =?utf-8?B?Y3VZd05TRFpueGxYZ2VtQ04vK3VIVTR4MS85MXR4d0lnWjdDZCtxLzNjMXlU?=
 =?utf-8?B?M1NFdExzMmE2eW9uQ1UxWWFNTVgvdE5GTkswTTdyaDlybHFUU1lXalVUcGla?=
 =?utf-8?B?OFNNdjNCMkR2aXF3bVRKeEFFbllXa0xGUlFRRGhQT292clBra2dISmZsNWtp?=
 =?utf-8?B?bk1yNmp2TnkyS2VEMjFGYkY3MGdBMXNzTXFNRXlPeXZvbXF6bzRXZjYyNkRs?=
 =?utf-8?B?Ti9DVjJGMHhHZ2dUTU5tejh2ZXpMSlNYS0twN0x4L2h0VmpMVlNCQTExZjd1?=
 =?utf-8?B?SDkwdUo4SE9zRVdGVjJxVVBScGh4V1crcGhmZnJCeVdpbitXTGp1cEVxMnNP?=
 =?utf-8?B?dVpJTGhQM3MvNTMyckZnckRwaWdVY2E2dmpZTUpkbEc2RndpNjJXTFlwSUFq?=
 =?utf-8?B?UVdSRjlBeURXTTYxV21udVJrQ25FU3ZaU3ArbVRiTzNwdm1kUkIxUUJVYTF1?=
 =?utf-8?B?NE5Cb3g4Q3dBbXNBMndCdGJKdXJnVlhCSDYxWDAxTWZjQ2RSaU5XYnVJNHZ1?=
 =?utf-8?B?T0ZOZlRwQ1FTNUxMd2htNWhWZjBHeDRXeXN3RHgvZVc1K29YMUcraE1nbWpS?=
 =?utf-8?B?bGdCYThNN1BQd3JCbk04WDlNNHNmRGZhMVRHRUtySldjYkJMREh6TXZVTHpM?=
 =?utf-8?B?S3Q3SFFDR1UzWDJWV3owY1Z1QlVCSzFTbldHdy9yTUNpRnJWTG5DU3JVUUN3?=
 =?utf-8?B?elRpMUtwK0o0Rmx5RGhzWjRSSmYxYWNsRXF5SmlEbTF4dDlXRlQ3VjVqR2Jv?=
 =?utf-8?Q?WOtIcvb5?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR04MB6417.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7f026-6269-40a8-066e-08db08ef6aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 09:40:58.2896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6QPWjR7ptPWwPVXHj6N5N4ywZM70XyhwWMJmBUaEYqY+p5Yn71+iLm69pRAW/rN3i23k/35tmSKBg0mTTSkcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiA+IFRoZSBtb2R1bGUgaXRzZWxmIGNvdWxkIGJlIGV4dHJhY3RlZCBmcm9tIFNQREsgaW50byBp
dHMgb3duLCBvciBTUERLJ3MNCj4gPiB1YmxrIGV4dGVuc2lvbiBjb3VsZCBiZSB1c2VkIHRvIGlu
c3RhbnRpYXRlIGl0LiBJbiBhbnkgY2FzZSwgSSB0aGluaw0KPiA+IGl0IGNvdWxkIHByb3ZpZGUg
YSBzb2xpZCBmb3VuZGF0aW9uIGZvciBhIGhvc3Qtc2lkZSBGVEwNCj4gPiBpbXBsZW1lbnRhdGlv
bi4NCj4gDQo+IFRoYW5rcyBNYXRpYXMgZm9yIHRoZSBsaW5rLiBJIGhhZCBub3QgeWV0IGhlYXJk
IGFib3V0IHRoaXMgcHJvamVjdC4NCj4gQWx0aG91Z2ggSSBoYXZlIG5vdCB5ZXQgaGFkIHRoZSB0
aW1lIHRvIHdhdGNoIHRoZSB2aWRlbywgb24NCj4gaHR0cHM6Ly9zcGRrLmlvL2RvYy9mdGwuaHRt
bCBJIGZvdW5kIHRoZSBmb2xsb3dpbmc6ICJUaGUgRmxhc2ggVHJhbnNsYXRpb24gTGF5ZXINCj4g
bGlicmFyeSBwcm92aWRlcyBlZmZpY2llbnQgNEsgYmxvY2sgZGV2aWNlIGFjY2VzcyBvbiB0b3Ag
b2YgZGV2aWNlcyB3aXRoID40Sw0KPiB3cml0ZSB1bml0IHNpemUgKGVnLiByYWlkNWYgYmRldikg
b3IgZGV2aWNlcyB3aXRoIGxhcmdlIGluZGlyZWN0aW9uIHVuaXRzIChzb21lDQo+IGNhcGFjaXR5
LWZvY3VzZWQgTkFORCBkcml2ZXMpLCB3aGljaCBkb24ndCBoYW5kbGUgNEsgd3JpdGVzIHdlbGwu
IEl0IGhhbmRsZXMNCj4gdGhlIGxvZ2ljYWwgdG8gcGh5c2ljYWwgYWRkcmVzcyBtYXBwaW5nIGFu
ZCBtYW5hZ2VzIHRoZSBnYXJiYWdlIGNvbGxlY3Rpb24NCj4gcHJvY2Vzcy4iIFRvIG1lIHRoYXQg
c291bmRzIGxpa2UgYW4gZWZmb3J0IHRoYXQgaGFzIHZlcnkgc2ltaWxhciBnb2FscyBhcyBaTlMg
YW5kDQo+IFpCQz8gRG9lcyB0aGUgZm9sbG93aW5nIGFkdmljZSBhcHBseSB0byB0aGF0IHByb2pl
Y3Q6ICJEb24ndCBzdGFjayB5b3VyIGxvZyBvbg0KPiBteSBsb2ciPyAoWWFuZywgSmluZ3BlaSwg
TmVkIFBsYXNzb24sIEdyZWcgR2lsbGlzLCBOaXNoYSBUYWxhZ2FsYSwgYW5kDQo+IFN3YW1pbmF0
aGFuIFN1bmRhcmFyYW1hbi4gIkRvbuKAmXQgc3RhY2sgeW91ciBsb2cgb24gbXkgbG9nLiIgSW4g
Mm5kDQo+IFdvcmtzaG9wIG9uIEludGVyYWN0aW9ucyBvZiBOVk0vRmxhc2ggd2l0aCBPcGVyYXRp
bmcgU3lzdGVtcyBhbmQNCj4gV29ya2xvYWRzICh7SU5GTE9XfSAxNCkuIDIwMTQuKQ0KPiANCg0K
SGkgQmFydCwNCg0KWWVwLCBpdCBkb2VzLiBUaGUgZWFybHkgaW5jYXJuYXRpb24gb2YgdGhlIGZ0
bCBtb2R1bGUgd2FzIHRhcmdldGVkIGFzIGFuIE9DU1NELWNvbXBhdGlibGUgaG9zdC1zaWRlIEZU
TC4gSXQgd2FzIGxhdGVyIGV4dGVuZGVkIHRvIHN1cHBvcnQgbGFyZ2Ugd3JpdGVzIGFuZCBjYWNo
aW5nIGRldmljZXMgKGUuZy4sIG9wdGFuZSkuIE1hcml1eiBhbmQgV29qY2llY2ggaGF2ZSBoYWQg
dGhlIHBsZWFzdXJlIG9mIGJ1aWxkaW5nIGl0LCBhcyB3ZWxsIGFzIGVuYWJsZWQgWk5TIHN1cHBv
cnQgdGhhdCdsbCBzb29uIGJlIHVwc3RyZWFtLg0KDQpSZWdhcmRzLCBNYXRpYXMNCg==
