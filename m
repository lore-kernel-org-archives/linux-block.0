Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B11C4320E
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 02:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B19161102
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 02:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhHMCSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 22:18:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25158 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhHMCSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 22:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628821089; x=1660357089;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xmJ9NKKU/6L15G9dGMtx28KeDDV9aninMB0uio2PkHk=;
  b=nR1kohDhmQUAehfEXVpvwpgZ3A4v5vLdnaO7l93MSHAnt0Zr+Pa9aGNv
   ZHa0h0vi2VZLH8iY93jgk1BJroX95eU1qeujCRN/VGnYODfVbvr0cgQVw
   NCupB2ErOsCSWVvSBLAp+/pZiwi1YuTUB3ZYn4anFX/OMDEX3t8Dkic7o
   6b63wbQJRudkPG6VUT8cZ2IT9k6h5y/BKY3Uy7oVyFNzEjdn3nUBalilz
   ushW2zPMgC1nQqbHEvtxMfIBy4ZszuQ0VZjWDT2hswRYULBcvLmbEwUdt
   I2TvV4tLniKv1CT9FBlt10ufMgM0DHnC5d6micL/ZJFEltqH3B2Oeq9Rs
   A==;
X-IronPort-AV: E=Sophos;i="5.84,317,1620662400"; 
   d="scan'208";a="181911884"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2021 10:18:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwgZE+JRrZi+bVxF92qFiMBqkkB9BwxTc+Ywf40ajXWEdpuQ7a7EmY8j0zp4ByvzU7ByyCZ0kQvu7c+LOQLQ/VfmaDVbapUzt9oHbOSgKolwFn7KgwYbaKYi/60/YEfB+xV5LcpgfLYyqkTZr+CQlrM0C8pyxQtApalrJfH7Kc4Y35Lp+RJbnWEhytMPxCGeJAxxcRY05AvWUUO2P9c8OZkSOJZ/JIFg/JzoU+geSuJGi4ttdReXQoWCkq/DH5Zwcrl/WdiHw8DTkKVf+WoG9RUXWbPnmZ405N//HuMwHuBl2VMskFK6x/i8YP3ewkqrb4TwM4N5ks3UmrqsnDa9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmJ9NKKU/6L15G9dGMtx28KeDDV9aninMB0uio2PkHk=;
 b=Oo5mGqVKhhEbAO4gd3v/pMS1tJ4o6lG8jsBtp2eeMpU7OsBq0CHp27LC7L/4dybxstFSUxSPZMLgD17hmRP9Ahd2+KjhdlLNL1vdw3vhxWy+rNVtXJyzR6th8HwkNkZb43ph5stvWee3YDqjYamD64PiVdUxF1R3NKCYQffGNg34eQNPAxkgiBloJje4AV/5eT6we3x6ZjSk6q5BVVb3XgJkwOcLsO4m0pqVi0HmMPdoHvyzN4HrChW862lUV1EEmwHDo3tCovUInx1USwQMd0ZZkcNnNjR1sGDO0HHvRB84SeE/FS6Qi3WBdfztwrGtektKLwBJIC8/iFCzCtzcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmJ9NKKU/6L15G9dGMtx28KeDDV9aninMB0uio2PkHk=;
 b=s2eK3z+5CXQPI4xC7IglGe4XgFoSsQz9Rksrkq+iorjITbyJLb1bdvGN2s2HrcKjpf44te5gk7EGPhMWucIO1j0rBp1UwPpuHVIk474KqU0WOvg8h50X59XStVIS43zWaYzuSMTi0TVl96KR+BOE/r024hdUC/1agpZaZqrAoi8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6922.namprd04.prod.outlook.com (2603:10b6:5:246::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 02:18:04 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.016; Fri, 13 Aug 2021
 02:18:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Thread-Topic: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup
 support"
Thread-Index: AQHXjtgt0+uKAnJBRE21gFzIPxLXEw==
Date:   Fri, 13 Aug 2021 02:18:04 +0000
Message-ID: <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
 <YRV1JkkxozEb4YO6@mtj.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65c52124-f2cf-42f8-629d-08d95e009555
x-ms-traffictypediagnostic: DM6PR04MB6922:
x-microsoft-antispam-prvs: <DM6PR04MB6922AD5D3B89E50855EC5A14E7FA9@DM6PR04MB6922.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljNTC9jgNMB9ExvNGbYsoEcriY+U6y/G9utQ8eFtbnWdHD1djlobUTa+zwBvFq5IF2wpZC5e9xf8v31xft5jPA7hkBbw+G/vefnE0PZwlpHuwV1fmBvWDu5V4LS7A7J6dZu9qR2p0W2CzBZfQMhZsfCfqVyA6RSlj8R4AmXf9nGBa4huLWnDYf9WBlydbqTEgtEjqWR0YqnJO+yjxACr70upqsr6nUTHJ0kCcHnPbhwIiGX6KZLGxHhZR70eu2Ad9xc2K+WIXYX0RcIfavVMZ+OuijwrWh6eXsKya22IFjS1PNXVIxnrtqwB3///frMKxZvmOrycplnB44gCJNq/TZzrbJMbuQFH/T9ORHyOuSlHoBOsjqsbpJl9LBU0eMMhE5mRD4YPWBDafMRKVAsJQL9SwCkpQIpQo99LR91hpzF6j5U2G88YK5jA5vyJ1Y0AX8PIx+39MHOhbx8AXTisfr0WBTQwptUfeHu1N15F0WRINO+wPk3Oo1kr62LcWmXOdT/VGEgLofH85+sPaPu751ATM4QQxlcCBCNixtmAdSchvr63nOTLQiZnQlhhQ+klg6SvfxR3Ojn8rbwcgNhNikkchwZsXwPRWEd831j2tjZNWYhhaqycnzStPn3rcuJxAsm8E0FNDua1ILmUGpSva2XNUWoIJ//O+MtiXCzlomziKBecB+sCuR0xI6Q/3tluHSTzh6pPPmH/w1YzBt+Jrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(2906002)(6506007)(186003)(8676002)(53546011)(91956017)(4326008)(83380400001)(38100700002)(54906003)(52536014)(76116006)(110136005)(508600001)(38070700005)(66556008)(66476007)(86362001)(316002)(9686003)(55016002)(66446008)(7696005)(122000001)(64756008)(71200400001)(8936002)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TRw4ltNJV4KqBqJEQAQrau1F1Ab5NS/Ux4ORIUE7LHynhSh6tyISVRRX14iT?=
 =?us-ascii?Q?wr6pttQFO1vN/Z9scEsUxx4V2E47VaGTgmD8sFrl/T1tEd6PVpHMsuSMyR72?=
 =?us-ascii?Q?wod+Pr+TaJ0KC/Ou7uv60XTmO87z716x2Jf6CZLeWRjNcmgUYV6cmw2XA4yw?=
 =?us-ascii?Q?kru5CIri7taBVL2E/VYI0xTY2bxrK8qXznmbcFz8nehHr/kqLwk+yuLHFlyf?=
 =?us-ascii?Q?hOfDToOHPGS1veJ+XEnwICKKiaQVTA5gFyhkavWy0uSP2Q+yX8kNYGui8Wln?=
 =?us-ascii?Q?IanRbZe0MtFfKfd2qN9CMxLQ8Ynv4aHWzbKdTsOr+qjeAOBFtxFBg4bbPuRU?=
 =?us-ascii?Q?IroiQ82C77ZEk2rzRwGdN+ruqLuaDdUqWueq3lk+5kbNGxcqBjGhZnNo7swT?=
 =?us-ascii?Q?k4AdtxuJ2kD99jZiNFxcghf+IxH/dfpQUowXE/cG8sa+nqnhAvcVZhHl7//T?=
 =?us-ascii?Q?YXJ6fSnjEuAbqxbjiz/bvX/YDhfAjMuptl3F5ihf635puRipmArPJKsljNC/?=
 =?us-ascii?Q?RweJb6FXpUeShkrzpz2bl/k50HE0DOFcIhdiWGa47lRqkrAhmoaskfyPN1fc?=
 =?us-ascii?Q?XjX2vlbqYre+UUHdw8gI3uhpEwoCx4tpfySl0ylJDHQIjhtxuEUEuWGtKujM?=
 =?us-ascii?Q?jTeRraQD0cu9AQ8ba6yFsDMV1jWu3HgjfBUW9rigprPrNBdWvjh6lP5Ft4Ot?=
 =?us-ascii?Q?zoROUbN/NX2aPGcXBGlBebwyCRQWgaXJuQFcBTp1j/nzNed1rWHvRd87qdDh?=
 =?us-ascii?Q?hDkq95QQ7noHIxsWmMHDaK5kc+Feg6jMVsNeeQf2R0zhmdTOkCZiSrpXHjoT?=
 =?us-ascii?Q?vRr1lcChmCaBwFrdo2b7Xje8bzf719eAjIvPlFMmipjXyVRWIpsE5vfAOZMm?=
 =?us-ascii?Q?JsN4jF75u3bJTjHm4b7oNTyA0gx/Lo0mrKichVjt9DfvCWWqMDXG+eGwVVxv?=
 =?us-ascii?Q?L+nr0Rj4AZCS12t/0BXviLU4R1RakhwXXfIgl3ND6dy4hkUa7gNCK9lYbYbc?=
 =?us-ascii?Q?sZyX3LELAfa3vBplr2nOw9u4SqoBTL1Hyw4Z17JHkk2MgGA6C3mlur9vgHwS?=
 =?us-ascii?Q?M2a+/6je0S1wM7upYft/FHTjAia4CYkYEshws5lsRAQnijntENTvs5BP50Oj?=
 =?us-ascii?Q?wJN1F18Xnx/QG3z7ehvJXqHYqBPmSOxnkXWqgvuVcTrwYaH73VKPpcvziwKD?=
 =?us-ascii?Q?kcxarvBvdaZQWvk7Jffkiz3PAaWSosFCkfyp1IHhdCuzavyw/Qx+WBbRIEC6?=
 =?us-ascii?Q?Y75EHfPlY87EBtcNKzP+DrudRSs8+tO4mkwQymWzRLayq3GO0gY2WWyXUAJU?=
 =?us-ascii?Q?PHT14tGZ7IHcCS3CFt3Npb8k4OkkBXWSPyBGjAvXUqyXk6Gl7sd/Sl0/n3Ce?=
 =?us-ascii?Q?JKC28xHfEThcJ41fMgrxYWoQ7NmLXwc7rdVCUNcajqXuQzCj+g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c52124-f2cf-42f8-629d-08d95e009555
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 02:18:04.7042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDOmxzisEJSMUf3qT+6ZsWwBOEtfWhYLgyKzaGDzgIm28xMKi6nIbZcxkX44AAk0hy5j2gsFXWNFfTd7ePeB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6922
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/13 4:23, Tejun Heo wrote:=0A=
> Hello,=0A=
> =0A=
> On Thu, Aug 12, 2021 at 11:16:37AM -0700, Bart Van Assche wrote:=0A=
>> Are you perhaps referring to the iocost and iolatency cgroup controllers=
? Is=0A=
> =0A=
> and blk-throtl=0A=
> =0A=
>> it ever useful to combine these controllers with the ioprio controller? =
The=0A=
> =0A=
> So, I used controller as in cgroup IO controller, something which can=0A=
> distribute IO resources hierarchically according to either weights or=0A=
> limits. In that sense, there is no such thing as an ioprio controller.=0A=
> =0A=
>> ioprio controller was introduced with the goal to provide the informatio=
n to=0A=
>> the storage controller about which I/O request to handle first. My=0A=
> =0A=
> My experience has been that this isn't all that useful for generic IO=0A=
> control scenarios involving cgroups. The configuration is too flexible=0A=
> and granular to map to hardware priorities and there are way more=0A=
> significant factors than how a controller manages its iternal ordering=0A=
> on most commodity SSDs. For situations where such feature is useful,=0A=
> cgroup might be able to help with tagging the associated priorities=0A=
> but I don't think there's much beyond that and I have a hard time=0A=
> seeing why the existing ioprio interface wouldn't be enough.=0A=
> =0A=
>> understanding of the iocost and iolatency controllers is that these cgro=
up=0A=
>> controllers decide in which order to process I/O requests. Neither=0A=
>> controller has the last word over I/O order if the queue depth is larger=
=0A=
>> than one, something that is essential to achieve reasonable performance.=
=0A=
> =0A=
> Well, whoever owns the queue can control the latencies and it isn't=0A=
> difficult to mess up while issuing one command at a time, so if the=0A=
> strategy is stuffing device queue as much as possible and telling the=0A=
> device what to do, the end result is gonna be pretty sad.=0A=
=0A=
Let me throw in more information related to this.=0A=
=0A=
Command duration limits (CDL) and Sequestered commands features are being=
=0A=
drafted in SPC/SBC and ACS to give the device better hints than just a on/o=
ff=0A=
high priority bit. I am currently prototyping these features and I am reusi=
ng=0A=
the ioprio interface for that. Here is how this works:=0A=
1) The drives exposes a set of command duration limits descriptors (up to 7=
 for=0A=
reads and 7 for writes) that define duration limits for a command execution=
:=0A=
overall processing time, queuing time and execution time. Each duration tim=
e has=0A=
a policy associated with it that is applied if a command processing exceeds=
 one=0A=
of the defined time limit: continue, continue but signal limit exceeded, ab=
ort.=0A=
2) Users can change the drive command duration limits to whatever they need=
=0A=
(e.g. change the policies for the limits to get a fast-fail behavior for=0A=
commands instead of having the drive retry for a long time)=0A=
3) When issuing IOs, users (or FSes) can apply a command duration limit=0A=
descriptor by specifying the IOPRIO_CLASS_DL priority class. The priority l=
evel=0A=
for that class indicates the descriptor to apply to the command.=0A=
4) At SCSI/ATA level, read and write commands have 3 bits defined to specif=
y the=0A=
command descriptor to apply to the command (1 to 7 or 0 for no limit)=0A=
=0A=
With that in place, the disk firmware can now make more intelligent decisio=
ns on=0A=
command scheduling to keep performance high at high queue depth without=0A=
increasing latency for commands that have low duration limits. And based on=
 the=0A=
policy defined for a limit, this can be a "soft" best-effort optimization b=
y the=0A=
disk, or a hard one with aborts if the drive decides that what the user is=
=0A=
asking for is not possible.=0A=
=0A=
CDL can completely replace the existing binary on/off NCQ priority in a mor=
e=0A=
flexible manner as the user can set different duration limits for high vs l=
ow=0A=
priority. E.g. high priority is equivalent to a very short limit while low=
=0A=
priority is equivalent to longer or no limits.=0A=
=0A=
I think that CDL has the potential for better interactions with cgroups as=
=0A=
cgroup controllers can install a set of limits on the drive that fits the=
=0A=
controller target policy. E.g., the latency controller can set duration lim=
its=0A=
and use the IOPRIO_CLASS_DL class to tell the drive the exact latency targe=
t to use.=0A=
=0A=
In my implementation, I have not yet looked into cgroups integration for CD=
L=0A=
though. I am still wondering what the best approach is: defining a new=0A=
controller or integrating into existing controllers. The former is likely e=
asier=0A=
than the latter, but having hardware support for existing controllers has t=
he=0A=
potential to improve them seamlessly without forcing the user to change any=
thing=0A=
to there application setup.=0A=
=0A=
CDL is still in draft state in the specs though. So I will not be sending t=
his yet.=0A=
=0A=
> =0A=
> Thanks.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
