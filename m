Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A90C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F080720659
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 04:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qtP9ohWn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k4uNo8An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgENENs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 00:13:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62657 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgENENr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 00:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589429627; x=1620965627;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9GuDYFskA+PxsnbRLjc4tUEkkxFI+LCpkfRmM6QqljA=;
  b=qtP9ohWnCFcHjQFxu/+Y7jYVDmTv5lahNROgli08QOmSIljtLDGQfiRS
   Qs2g83aQRVlhRPp0m3VhB/myHDB3dhSf3o5xquOyEBcWGU6PSXmS5gZUV
   oOxeF3RDr2eqetwC8u71NLd4ebZh46wb3zI6Ih+O/aimPv2w6mOkcK8yS
   sBP9+zrTVbSzURnSKtDkgcJxTn3jiQjNgAfnl/2IJe1zwj0vF0yfE6SLR
   fUhJo/ocr6U7kLooKUxY8ySDC9ccUVY58jNhHteWyo/VcNsZGJFPGBqq4
   XNogaE2K+nOzaLELLmmXi20HYxTcZvuayhG51jwWkqlaug+vAyEcwUrRy
   g==;
IronPort-SDR: czHs8QKvxtxKLsV8bogJIE480CRcRzYXpLqI7dBbdBKY+A0CMPiJgGMvqAcGzgaQc2PYghG0nW
 R2ncYYCDNZZudqcE6qZO6FbhGqEs4cLq46Y2SslpOtqLx23V5zEZHL+1loinP3dn3AJKg6x/wi
 e+NdT0ESrhsm90G0nQfbvVzX5GE3+K8ibnixvMyxPyKXDUn/3I1qdbGjdvK2deN2kZp42k9o9h
 DuFZFVkLDUsl5LcI2OVUyaFTA+/nrJ3Eqc5njC9KVFsWBnqwrpdy14l/9Ed5r4dVK52TSMg/9v
 zS8=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; 
   d="scan'208";a="137976915"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 12:13:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcUc1Xcgd7aCJRuXnfi3ZL66o5qk5S81+w6+MU6o4DuJV1HAHXc+p1V6EE0qJkR1TB3QVwlSO0qQaNJyYwffjxHKh+ZrqRbS/gs5/uA3A7dyvcKHryDC+CkVyjPZME54l0cXW/bkY/sgzIfPmrfZYoIB7J9dtIWqgasDg0S3Q3cB4YQsPDStLsXbGShXeUv+O4pJBXaCM2wumvGWO/ymNp7Z/TF3GlIl0bTH5YtebrGxGd+VH7DXtVyevPCZMD3AJT/rXmycEPnLs4IAnTnTAC6FzDCNDTHyR0OG/8bSQ+dAiSpE5cU78vjiXfhEd7P2IO1/P3yXISv1F6ZqgzgvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/jMYgOwXYoS2k2WAj4auEAmfPMFLfctgo5haqxtlco=;
 b=ixW6y6MNX83SKJVZz35NnQIMwMa+ACFH79JA3q4saZdCJ9nJmrHtVA2W91Rks0jYaRR4xtTnr/W5sUu9k72+5AcLlAj/NsyBnVegZkdM3xprl6qKNXl69Rpet/GMWPjjIPHY4fjQ6oj1xldDWnEaGrXF6NYx1xV75xbRJknfdGYav2C+9ooH7zUPWeEdM4GAr33iYCSK7DSzJcGKsCrdfybQmfTZPWm51hnV0KXpR3P8KF2ByBVrPZivRiBQaaYp4k8rvypz1aQwnjXEyRXdhretaU7cM4DKfJiGEkpTUyG4I/yrCfUWxsBPSGAoNTSEdIA8LXvV9/NRz+eJU2cbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/jMYgOwXYoS2k2WAj4auEAmfPMFLfctgo5haqxtlco=;
 b=k4uNo8An7h04yr0XrXu40gmw3Z1ar/MeIqQ+CJlLzhsAmo7aSLFBS7izXAv49V9wV34sAk2UN6DYC8TqdxU4JzQLz3noj5Fn1FRdn9UuQEbQ25bAMM87/0yTMTY6wcIKCsnP8BGVnIYtZ6GAlvTzD84CmcxXzcLiKf7M8H1j8jY=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6390.namprd04.prod.outlook.com (2603:10b6:a03:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 04:13:44 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 04:13:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
Thread-Topic: [PATCH] nvme: Fix io_opt limit setting
Thread-Index: AQHWKZKteeWR5SmRQk+RzMo1gzRfSw==
Date:   Thu, 14 May 2020 04:13:44 +0000
Message-ID: <BY5PR04MB6900B9C6ADCEBD122154A22EE7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
 <20200514034033.GB1833@redsun51.ssa.fujisawa.hgst.com>
 <BY5PR04MB6900584D1F292E65425827F4E7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
 <20200514041215.GA1900@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17cff4f3-a47e-47bf-8ccf-08d7f7bd3187
x-ms-traffictypediagnostic: BY5PR04MB6390:
x-microsoft-antispam-prvs: <BY5PR04MB6390D98BD581BBFBF25BA201E7BC0@BY5PR04MB6390.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPnZWFpEWpGbXKiCpdSQT1WboamiOJM9QUtiuxeHPC4Ia2/GSzbf/M6bjiaA5IR6Hc+LrW5+KqLcgV3o8SDVZmiy/ewhqMnWds90eROdfjnab+CkUQsf5zShdEL6V9wPd0TNfQSiWi26gXUzuL6NhUwGkLuSMYXd/U2bMKFkzeIjEjhvvOpyG96SWnUr3Bg/273rDSL7AvTYTkhaY1aR5uMtPg8fc36fsy92lMq+3Aj0TMQ58FkO2lWucubMKWRj/prbeVZpo/lFP+v+KkBRgQnAZhaSIySKLNpeor1c0ejj06zbDQ8WYBKe2Br3FRyisz3yWQ8ytubxCk9fh4/POpJdg//eHY9OOeWfsG/2EAFDfQNhKjl7ipdu2Q+8tbXsa1fr6H6ZVt35OhaBbPvh8RZLL0MEOmgSEjnoxdlL7sHxHHcjorF+7LypBcqnf09a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(52536014)(8676002)(316002)(9686003)(4326008)(76116006)(6916009)(86362001)(66446008)(71200400001)(33656002)(54906003)(26005)(53546011)(55016002)(6506007)(7696005)(66476007)(66946007)(64756008)(2906002)(5660300002)(8936002)(478600001)(186003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wQ9NrYpFsZjImtDbc+sOJ7NN++JoB64smWY82NkRnL1BSdwn4ZknQCL5KRZeu+GgAz8aNm9AtVPvoz2Vlq6t8KHHVeO6pMdgni8zBDKt819Ix9gcuLTdQE/CPeZv+wbn5vDilmnswyHJnGCbMK0yG3G1bU7vWpSoBUE7BTUR6Juxoe28OaqhCKd+nlanJ5lyXD7FQiIM+VY4TRug2kfLJtBWgatlcLtUT7qhuaT+eOQGu9kaPklqupuglj2nErsWcMXpfFwlFADhNTMV9LjxQYqJUkSmdtNEgjloUV0Uuge1CEJoztcXTqhYtt3RGMnDTwllm/rD+iNJya5wwE0O5VVX3h50T4BbrUPwwJdLYXWqBJrAh+Rt0YttB8dpSMyH5Xn9RYau9YCYMqwTZyciqqw5zspKQe9IZqkNTQz0LbC59CFhsHfF+lNeDIDs6I275Hsk7HxjxtI7RCaYfw1w8c8zUFrf1v+khsYhlmarDoOJn7TEHJJeq7RB56fAc0YT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cff4f3-a47e-47bf-8ccf-08d7f7bd3187
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 04:13:44.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/IwbfgcjFSzMCjnPim+JdYCu92qGa85j/oVoH+R7dMnXXZfJFVYXMw8rtdbnUmX+4u9IG+U1gCB+/0LcwG0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6390
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/14 13:12, Keith Busch wrote:=0A=
> On Thu, May 14, 2020 at 03:47:56AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/05/14 12:40, Keith Busch wrote:=0A=
>>> On Thu, May 14, 2020 at 10:54:52AM +0900, Damien Le Moal wrote:=0A=
>>>> Currently, a namespace io_opt queue limit is set by default to the=0A=
>>>> physical sector size of the namespace and to the the write optimal=0A=
>>>> size (NOWS) when the namespace reports this value. This causes problem=
s=0A=
>>>> with block limits stacking in blk_stack_limits() when a namespace bloc=
k=0A=
>>>> device is combined with an HDD which generally do not report any optim=
al=0A=
>>>> transfer size (io_opt limit is 0). The code:=0A=
>>>>=0A=
>>>> /* Optimal I/O a multiple of the physical block size? */=0A=
>>>> if (t->io_opt & (t->physical_block_size - 1)) {=0A=
>>>> 	t->io_opt =3D 0;=0A=
>>>> 	t->misaligned =3D 1;=0A=
>>>> 	ret =3D -1;=0A=
>>>> }=0A=
>>>>=0A=
>>>> results in blk_stack_limits() to return an error when the combined=0A=
>>>> devices have different but compatible physical sector sizes (e.g. 512B=
=0A=
>>>> sector SSD with 4KB sector disks).=0A=
>>>>=0A=
>>>> Fix this by not setting the optiomal IO size limit if the namespace do=
es=0A=
>>>> not report an optimal write size value.=0A=
>>>=0A=
>>> Won't this continue to break if a controller does report NOWS that's no=
t=0A=
>>> a multiple of the physical block size of the device it's stacking with?=
=0A=
>>=0A=
>> When io_opt stacking is handled, the physical sector size for the stacke=
d device=0A=
>> is already resolved to a common value. If the NOWS value cannot accommod=
ate this=0A=
>> resolved physical sector size, this is an incompatible stacking, so fail=
ing is=0A=
>> OK in that case.=0A=
> =0A=
> I see, though it's not strictly incompatible as io_opt is merely a hint=
=0A=
> that could continue to work if the stacked limit was recalculated as:=0A=
> =0A=
> 	if (t->io_opt & (t->physical_block_size - 1))=0A=
> 	 	t->io_opt =3D lcm(t->io_opt, t->physical_block_size);=0A=
> =0A=
> Regardless, your patch does make sense, but it does have a merge=0A=
> conflict with nvme-5.8.=0A=
=0A=
Ooops. I will rebase and resend.=0A=
=0A=
And maybe we should send your suggestion above as a proper patch ?=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
