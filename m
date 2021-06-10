Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17017C48BCD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C43613F4
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFJAlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 20:41:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4673 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhFJAlW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 20:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623285568; x=1654821568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vdL5prOFOe1U5rRWpCEWdGcqzIVloyQWMSHMRTlecn4=;
  b=eYSaEAf3YGUZkeFpLF01WB8Alf4EDV73vmiVYBH8FwoBsY+j8syjo4nn
   jwYt8saS+REMk6xPPdnDRgqCKIieso3TfGMUzxw4DA+m/jY7MxcczTrC0
   5usvz9AEdi/r1FoNhp1tgBoZrp+QGoj1xgbsfftWhXRHjWTWQJ4DU1ONN
   rqP56luPupxFseDl9IBQCljGfFW0O+2L56wK6A8B+haMwgxkaILqDXbVH
   0X+Icmr48Z0VoFVmSOd4wWZbpSvALAP7y6Do1qm8czYTdd8uRY0Czuq3V
   RTS4Q/gSURtf49abSbH/fpdUJ+p2rJmKb3GWtguJ9TgXXasMajfgyuRPF
   w==;
IronPort-SDR: JQn1R0ed4Zai0cU974mI8ppzUvki0LRPRdGE+9vSOrfOl0Cu5Ev+zgGIUi7y5SY8N4IUHCPhBu
 UZr+EynEhy/V1jNI0dC2KQyRpmWgGFjSZTNdiAmBxdqjkwxyo7gKyokG1+ZqSRoxO86sXtqvml
 INX70HVX2jOi5C5x4wawIXzg1MFZMuyqSe6KpQrQofMkoNMVKmf20Yjr5rfxpWt9Pd7PC/LbLE
 fMOODVw3oBrry7kT9Er9BhT9RbJOPBX+FTcspOnnIOiap+W7f+qY1fznsDqIlZIhjXDE57US8j
 bxk=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="171922595"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 08:39:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3pCFRyBifnSNuVT9cI/j/UfAd9Mpmk2Mhr6+OudQXpctue+k/IWoDGmyV8kciz1Nn7vZ6xZe3B46XqIHsCkJvdUckoLbhQ5RFVSXa6mzv3ONs79Vm5YVS0eVFs9pMdjtIQv/Hu/KWGuDIQNJLEjB+2dyBHrfOosbik+Mnt8xGOhRdnYIwzLQdibA/IaWS1w+g4n6SGQqGjHb2qkp+ZehQyladHFGgGwuQGjvRxInNav//HMYJoovZqTYmSg1oRraEXn+cCJGv3YJx0LIsPoPjGcr+PXKQhkKnGOOred1r9gtu3kahGbx+GfFHFZfQtWJmjt9qc/xxhYyZPkm05Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUDIsjIl+O/ce4nEz6KxiSBOteew0S3urKkLUwYLUuw=;
 b=cHSlChrtFK5juh9haQ09lx23gjEwAZb9kT4zAusxFnN8PN+ZxgBd+SSrtJ/kbRcDUzIO6BqAQ7dPDQzvcUj4ixZdKb9ioQuGWNsS93RBmW6n+DhVx8goaIKXYOU5nFPUtC3Byr9iVDVf0aOZBMltBuB6DhOEJ3meI+UeVVvA/UBWU9IZqui4j2Kz582ecxlsSXBLBBcfdNqzAwuiy6CpgvpC2fj15T4Kz0+n8WH0xfbmbGuYmVpII1IATzmfwMrMFrlikijmXDnIRXLJ6lU+3s5NQV0Co8J6nQC7tf6IdhlEMna5yCZgsGAOFh9WJuo+fqWWNlHqQ1GpRKQz3pXnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUDIsjIl+O/ce4nEz6KxiSBOteew0S3urKkLUwYLUuw=;
 b=FwxZdYXzZRF3NVz8ofg536bfJ1P3mZr5DllTglJomhpeWK4Win6HRMDdUiLx1yZXFGuZNM3aVKRWosiFgwbr76jdYsSXCC3Uswi6IgERmV3x09bJROGiF69Wv0wgNrYOdIWGKZ8VsZxHokeriucxrtkAqwEPgUPLNoJ3wDZenv0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR0401MB3528.namprd04.prod.outlook.com (2603:10b6:4:76::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 00:39:25 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 00:39:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 12/14] block/mq-deadline: Add I/O priority support
Thread-Topic: [PATCH 12/14] block/mq-deadline: Add I/O priority support
Thread-Index: AQHXXLsQrNfwnSgnmUyY0OBm4aL5wQ==
Date:   Thu, 10 Jun 2021 00:39:25 +0000
Message-ID: <DM6PR04MB70815D5E4E64C6B78CCD410FE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-13-bvanassche@acm.org>
 <DM6PR04MB70818D0058A0B1249AC7EBFCE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
 <7fa81169-6c94-f7b1-f086-6f2caa775d41@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a66ea5c-d25a-47bc-9fff-08d92ba832c1
x-ms-traffictypediagnostic: DM5PR0401MB3528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR0401MB3528776C89342E0EB41EFB13E7359@DM5PR0401MB3528.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7ZTdUSRBqdXW7ff9wz9oZhfGZXpHH4cAskE7SHbj6zAxDLGbCQ/sagqoo8JTIlN3wdv/B3FVgrCrPrw3ktkoAHE7ShmVjmY4Sw7S9OU6dEL2LJOWaAWDps9BIR2hkti9mzi17LcpYU2xhA7owCTxvdCPejzHoSSwxzrY1QtYIvTylwfCKNmCv4XfTRo4zGHWwQLyBez13R1OAyE8MfZFEFMCW+6LIiyK6mxRNCyxH2a/JieE+805wTQC4RuPx52Pe0wSKTDj/tjcuZs/UV3zU2fk6bvUnVVrVm8jwm/e7EryiiKlqsuvHzFTuW3aYhm5oO5Tgct/dicxY24JuCQTUXAktk5Fvw0gFAlYYxsFsE9bHN/Sj+ZFRyWRjWzAYKtqXU3ccE+xxhqsBeecuZ3k2knzSNalHmrSnGx126yVrOvlRmonzGUeDQ/C0qRKscsZe3QgzqVjwSH/1bWPHf/1GhTojHJuJsJWnDDqd0xSAsToaqE5iEMIbCrFgK1eqbbY27PLN6EeF5YCIgL6ImH2h4dx/Xt+UhW4TNj4kW1ytPQB4I38RDqyLoda1O9jLdoXLGf6yWVrh66+8y6ZUh7Sbv2Y+gYIs/6yu0gaycWi/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(478600001)(8936002)(66476007)(66446008)(66946007)(66556008)(71200400001)(64756008)(83380400001)(8676002)(9686003)(55016002)(91956017)(76116006)(122000001)(33656002)(5660300002)(6506007)(52536014)(38100700002)(53546011)(4326008)(7696005)(316002)(110136005)(54906003)(26005)(186003)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v8Nr3j3pradmh9851pR9VQqnxxdPAIYWThsiBHzsy33686lhZHPS6lL5cAX3?=
 =?us-ascii?Q?djWDYQOQMo6nEIlaTXjsITsJ7J1C//mHx0BjDtbyfB/XIc97NFKk4zA4h+RZ?=
 =?us-ascii?Q?qLhzDIQPhfVOqMu0p3eF7euGOd87PhFG/HMTiKNnsFVK2Jr7NSPyyA3pr93d?=
 =?us-ascii?Q?0FYycfLiSWblfGU+BtOJonaMddylaKXtEAmiLeDOzQN1am1y3OXNaJwjQl/3?=
 =?us-ascii?Q?cRxVgX1+yLOauDkxggOTbhN/HHUiRpvWqftTEnAhL/OKlOIKEyO2qtDrK89o?=
 =?us-ascii?Q?sxFR902UexNZUyNwRS1Zaun7HnN8dpP0MzMUAmhaWbYEqnohMV4QjWwBKnX/?=
 =?us-ascii?Q?3lSzKHWRxa56Zw+8nazeH/BMtsmVK3u9Ep3JIhBgZXp5JBZ3Yie+eiieRHPJ?=
 =?us-ascii?Q?oJ7m7R23dfIuOzOHpkwjzE2buhiOgssilbljr7WyR5Juml6rYSNaWwpXWl0j?=
 =?us-ascii?Q?3DBgBnlUbbwZzGlRzO2YN18/c9dN59ELAnIEAzY/IkayWrrzZ7g07hjWvrI7?=
 =?us-ascii?Q?JcPOV8WeeiSGOctlbh7RLmTtv7AJwXsfKTnqPJfghQjk43trtpy6HsAOqUgY?=
 =?us-ascii?Q?VqrRM/3yKub6iPmspRQ2WN9r74j81crdpQuvWGTYiOgCu+O4A5gyUj04CwlM?=
 =?us-ascii?Q?ITwOdrKlcaBV7mdWhjzl/ev+9k5kyJG1YFozgiM2CaSVn9WP6iHTvQxRV2rE?=
 =?us-ascii?Q?GPCfP3omTh0guLGtDF1LA2hcAkUThaBg/etk53pMeQf78iB8KvfLHVDB/CeO?=
 =?us-ascii?Q?vH7iQlL38EnNUfdtibvfR0ckGsLVzfTWT33d0FxLiSaVB4N9XTYsbUVCNhZy?=
 =?us-ascii?Q?sbCnpoFj4u08PykvovUqCBlKHoFPu9hXPylNASjf+PiyTDNJRguxb1kTwYmC?=
 =?us-ascii?Q?GI547yRahpotOWjqxpp6kM1uiY/lG8m6IoFtGCIqgV8FWcOREc+bAC59JoWw?=
 =?us-ascii?Q?xfnDT2aeKSHrh4nxkc4Jl1rCkBU33utLra/JofadmTLcAuLpNz8q2kU5sKit?=
 =?us-ascii?Q?ARm0mHJvhNuOwzQ/9217LLe0fp0gEaQNVxgTbDFr8Hc7YLCeKrrW2D7JuwBK?=
 =?us-ascii?Q?STNBRrdKScpfmO0Nnqg7p6N5/d7QUtqo8r/oeUeVzsIedGKl+2RLgR792N4k?=
 =?us-ascii?Q?7Mepjx0kWfO/RqIIwh44QqGwG3GBGtsnEZz6IPh6nIcEDJf17riUYGGMRJQV?=
 =?us-ascii?Q?xB6Hro6RaERSwkKoIYSYwOI+wRz+UjZsjDAh2v/H3jjBjcuCY4QoGO98RdGn?=
 =?us-ascii?Q?qM5X/Wc32ciH3irT1RQf3xYKUL1wvmqeIjTd4qe6UywdJzA6W82QiLnqRHqT?=
 =?us-ascii?Q?LBmCiKo32ptIuLoy/FYL/KuRrqR+YuvVxxtHIAsEMe8/9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a66ea5c-d25a-47bc-9fff-08d92ba832c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 00:39:25.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DiJlmSvTwHjnUvNZBKJZC9hgH4FttRmHstN7sF35n1Lo3AkVXyjyTc1I91MvOL91yxMNXljqSTyNPbFavBoIbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3528
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/10 2:25, Bart Van Assche wrote:=0A=
> On 6/8/21 10:03 PM, Damien Le Moal wrote:=0A=
>> On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
>>>  struct deadline_data {=0A=
>>>  	/*=0A=
>>>  	 * run time data=0A=
>>>  	 */=0A=
>>>  =0A=
>>>  	/*=0A=
>>> -	 * requests (deadline_rq s) are present on both sort_list and fifo_li=
st=0A=
>>> +	 * Requests are present on both sort_list[] and fifo_list[][]. The=0A=
>>> +	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO)=
.=0A=
>>> +	 * The second index is the data direction (rq_data_dir(rq)).=0A=
>>>  	 */=0A=
>>>  	struct rb_root sort_list[DD_DIR_COUNT];=0A=
>>> -	struct list_head fifo_list[DD_DIR_COUNT];=0A=
>>> +	struct list_head fifo_list[DD_PRIO_COUNT][DD_DIR_COUNT];=0A=
>>=0A=
>> Would it make sense to pack these 2 into a sub structure ? e.g.:=0A=
>>=0A=
>> struct deadline_lists {=0A=
>> 	struct rb_root sort_list;=0A=
>> 	struct list_head fifo_list[DD_PRIO_COUNT];=0A=
>> };=0A=
>>=0A=
>> struct deadline_data {=0A=
>> 	...=0A=
>> 	/*=0A=
>> 	 * Requests are present on both sort_list[] and fifo_list[][]. The=0A=
>> 	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).=
=0A=
>> 	 * The second index is the data direction (rq_data_dir(rq)).=0A=
>>  	 */=0A=
>> 	struct deadline_lists	lists[DD_DIR_COUNT];=0A=
>  The deadline_fifo_request() function and several other functions=0A=
> examine both directions so I think that grouping per direction would=0A=
> complicate these functions. Grouping per I/O priority might help to make=
=0A=
> these functions easier to read. Do you want me to look further into this?=
=0A=
=0A=
If the code is simplified, yes, let's do it ! And Hannes will be happy as t=
he=0A=
array of arrays will be removed :)=0A=
=0A=
>>> +	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
>>> +	const u8 ioprio_class =3D dd_rq_ioclass(next);=0A=
>>> +	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];=0A=
>>> +=0A=
>>> +	if (next->elv.priv[0]) {=0A=
>>> +		dd_count(dd, merged, prio);=0A=
>>> +	} else {=0A=
>>> +		WARN_ON_ONCE(true);=0A=
>>> +	}=0A=
>>=0A=
>> No need for the curly brackets I think.=0A=
> =0A=
> I can leave these out but you may want to know that leaving the curly=0A=
> brackets out from this patch will make it necessary to introduce these=0A=
> in the next patch in this series.=0A=
> =0A=
>>> +/* Number of requests queued for a given priority level. */=0A=
>>> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)=0A=
>>> +{=0A=
>>> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);=0A=
>>=0A=
>> This also includes requests that are being executed on the device. Is th=
at OK ?=0A=
> =0A=
> Yes, and that's on purpose. Please note that this function is only used=
=0A=
> to export statistics to user space.=0A=
=0A=
Yes, I got it that it is only for stats shown to the user. I am just wonder=
ing=0A=
if we need to separate in-flight requests and queued requests. That should =
be=0A=
easy to do since you also have the dispatched count.=0A=
But again, not entirely sure if it is useful to have such level of detail. =
So I=0A=
guess it is OK as is for now. We can revisit later if needed.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
