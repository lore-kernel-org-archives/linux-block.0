Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A2C433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150BD64E32
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhBBJOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:14:11 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41948 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhBBJKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612257002; x=1643793002;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OCFQ0waXarM4UyJ0w0sYBrMqrPmB1v69pi1RcEo9gmM=;
  b=cds2CyDcvXPa51gjSevohuhetD5+2QBNvW6SdvlDRR09iDTTjlAQdgvm
   8nsc1+PcbHRzXV/c9CeP4orkri1AEx0ldz4uM3A4lfYlS3Luzmjof5m3L
   7xI4CpDDkUZR6eG9aJiTAy4sDbTy7XHmo8eBHZcB3tgtTo9zWUve7B6e5
   yquiTDgS5TkMzNBilDOFWVWFC2508Xo1mLngPc43nPD/qau9aM+FevyY7
   w1cmqF5QWZ7bpn3QI96Jphq/bpXhXmJ4t1JReMJDLu+er4oUTMsN4ddQD
   LONDcXmQ40As/CRYaxOygZTi8Rx6AO1Zi0ru2KnKrxGCaHcIjDUifJA6/
   A==;
IronPort-SDR: rGXvDGQDJaaxMThBvGexQgvH0zNkAcxOrbuvjVoUWKKHj7Wc1HDwYWxbd27WuT3VLvxqmhdnsH
 qRMwNUtL3LFD4T2THhlojLouYARquaRTmRGGPfWG/EJn4sUCj31SuP39ogFmU/DhNmpI1G45Jb
 JRFxZulD+L8G3h4yFo4M3gTa4HodioWlWOly+DPIShN2kFgW9T9Yt8TtwRQiBG+WwKvl5c5pBY
 Ofqt78teJ+/bJuXaB+O3aHQ1LxSkT/cXW+2LaH1xMBig9vdjSHIm/Tq/2utbTnziklR6GfCpko
 j/I=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160086493"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:08:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw57qbH1ArGipDwPbcy806IYKLE1Q39DW30IRKUI7aWLpzFo815fBWwTz2pc9/8BBf4ljcuZAVi5/6TiBSINDbLDUKbUndpCBqDk4N57m1bJOMVnAiHy3ImocpVQD/XEJsV3y6e3eyP/MRO79x+ajqwbnddZP/Yjlc/CiyTj7YX9QQsRTfmhU7FrD5DJEtUCwrruzSoqVueauLKi+XTO0SCWVUTB4SUs8GwILc7jijIclOQBctYtQSDejoigxZnc1v1Et2VBEeHwtfQBMMz8g3kmcFZev+XrzOfbCHRXk0/ZVHl2cPue8bAEvY5w2VF2E81jBVjAQrAT36d9NzX15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0XL0JMIjPRZ296tBYIgPVnG55YDetwxwpYP7cJlu3s=;
 b=VhUd5n7ULldZAzv1c7b7JdYoQrvLDKneMm2nWAzi3tXTBDkE8yuUZEHzy1n5KYXqzUwwEA7OtR8QXiuby9zyE4loqr0pZI8TVb/oovynMAhvj5TKRTuFVAELYFihqQ3y60SyoYS/+ARdM4CCiXH3mk9iQbm6J7Wm70BaLdnUKMl1UWzU3NrrTPiS8o4+nYteUt4MAXpSEJCxwc3rO5FFJM5MlQshXIfNm5NSRg0Q8F2B3ExWYtdSzSCbPw5enuWXxfyCYANL+hWk6wadGBB+y5VTRcwwtaBOWJYR/TU6FM+8a3UqF1hPP8BSen80Xvo7anqomCUJf+qHjE8SwA2llQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0XL0JMIjPRZ296tBYIgPVnG55YDetwxwpYP7cJlu3s=;
 b=HvW1aMHu/HC6EUbI9CGzOKb5gXkWMzCLsNeAwNv1YRi9dGZX44ps5CCGhK/kMNU12QiwgHz7P/ntk/GzTjKjKUzLYK9CRSHHnhaPisskzc8IujD5IoRT3R5t7SSb9k71QGYBuhSVXOX/pAqH5OVP8dENBuZreID5lEQkUCWKrms=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6448.namprd04.prod.outlook.com (2603:10b6:208:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:08:53 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:08:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 6/7] null_blk: allow disacrd on non-membacked mode
Thread-Topic: [PATCH 6/7] null_blk: allow disacrd on non-membacked mode
Thread-Index: AQHW+SQDf7ZtVD/2vEWq4xtnOUVHDw==
Date:   Tue, 2 Feb 2021 09:08:53 +0000
Message-ID: <BL0PR04MB6514BB3CE744EDC43058B456E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-7-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d108d0b-8671-47aa-95c5-08d8c75a29b6
x-ms-traffictypediagnostic: MN2PR04MB6448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64480BCBEF6CFBBE84DE1ABFE7B59@MN2PR04MB6448.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zba7uDlPh7dY+3V1Z6JVSfhMkje7IB+yLmwvTBDmpyMinCIeyFTvf2HuuY1OcALPrG3cV6Mc6zVSJhFW68x92S2rkw+JrQbi0Kq7oRJpYxTBoIpPigI0UzoZ7yHSvupacoFOs6xVwC/7W4bRY8jxZmKAwerhhG1Aivzx9UBZwgFNrrIjKCSqBWCyPraspEQ+7KhMLXNS9hPfbFtzrhKJ7+ipBAh+hvoJZtVH92d1TWami3b5hshrHBKLQR1zNftagQ3Ml6lo0aIfhofP9bOlztmpznvQwTR6eCFOmxJpxcvuno4EsBND7eQovAdzt2JPGjC5zasUNyqpxcb07jFOGVea1Sw7RmjVseW5YjC9Mcp2cJYWyV5JfuJqQg9PFzrsVVeTsWwuIvENmAKYn7FgOX8n1+B2Kmricn2utU0T8P9rhSxZzkMFVn87URZvDopXH437p9RTmxFIzm+SNNDrtrYk5q6LXVfIrJpTpttqqE48QyjOu9V8AbiZVKMHUsX5O14f2sfAof4ae70bN2CsGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(66946007)(76116006)(53546011)(478600001)(9686003)(83380400001)(186003)(6506007)(55016002)(4326008)(8676002)(91956017)(64756008)(5660300002)(66446008)(66556008)(110136005)(66476007)(71200400001)(54906003)(7696005)(7416002)(33656002)(2906002)(8936002)(86362001)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RQeX9K3UwOHF56WmMFDRyQVuHme6UoP68mPjom4tpaqNWa2C3icGAIAbX9jl?=
 =?us-ascii?Q?O9avzb4dtfnaaXyfA9p9FuOfaZIpIRQeGlH34zSql767nGam133WcHqxu6eN?=
 =?us-ascii?Q?/7tRtg0TtfbtdCz24Dctic9g9i5lzOXXj2mbqrQ0N0gv85JMZsKlx/baWW+n?=
 =?us-ascii?Q?szZbfY6elUvHb/R0DHtBJ8Qbbftpr2EkhTrncgHehUsmIxbL0flM5TIDAibs?=
 =?us-ascii?Q?FqZoOYEnEFwMK+H7XQv2ON/LrmXzAqengsJtMpfQTRX2jc3D0bm7c+zrHoNW?=
 =?us-ascii?Q?PC5ZXejfcfwY7DwVxqaRklLh+l6gpxPWIVrYItKz7toKritV1R/nVFG20b7U?=
 =?us-ascii?Q?7pmzLtavBjx10U9pyuFNCjz2Jhq/EgkVbpgAcCHxgSvfj8bQ/WGgSDYOAUHt?=
 =?us-ascii?Q?sytoqCwihgziBVKpDLdv4/jGTHgvmCqpQocrnxvGRm75BfaxKDIGcmpepGb1?=
 =?us-ascii?Q?KElNbQ56nItaLy6j0KRRVSPlde8rbSBi1CbP61aaJHbyYEOUl8bbL0bUgadT?=
 =?us-ascii?Q?U5PZumIvsLobXx3Tsaj5iRbycT4KL+S03aCp6ljGVbQz9yWxD1B/sMvKx95Q?=
 =?us-ascii?Q?4GjqHIgPjj49JCT6usIOcJUtR5SBX/1YBrsJ3ulYRU8pPetZ9Ht0vTpefRIq?=
 =?us-ascii?Q?BxUh18gVg3QEgtQI2RjFBzYQkIXF1iWO9Ql+lPQqAwD5r6F7RmRJ+TWH7o2b?=
 =?us-ascii?Q?KzETuGpvC6GwkOlQaJPDbl5EV/q2Ut0KCH+3dr1Zwb5XGuuou00wMcIwawW/?=
 =?us-ascii?Q?VLW7Ez+xzls5upXlzAOjnHb6UTXKaklttviKlwSxYnRgPlQ+xI2Kw9ospmEH?=
 =?us-ascii?Q?2FzX7gNixzNtasPX17hDgK+NYp8TsRRY1QeATUyb2VGmt2NgJbM0PoQalnLr?=
 =?us-ascii?Q?JHMa5iAAmB4hF4jU8KO4/LZvSSc9AYLlTphYKKk1hW35V9iB39lPUdiXdsi5?=
 =?us-ascii?Q?K+GYBlR8zmtbc7LGSYI4GEr2vQfYuJ6FbKSdxHcvi7jWDfA2FuJw053QWytY?=
 =?us-ascii?Q?HusrXKCd2YkxE9AJMg0fMekAD7xXwcC3GbDrF/kJd5gzegp0iW/wA6q6ZRSP?=
 =?us-ascii?Q?PXT3bziaAG8JaJRfXcRw3aIyGlnmNgT6azqODDkike1yQL/LY5DZgHAL7Q1Q?=
 =?us-ascii?Q?4QfKnqkHRuA7KjUHymcHN+ZMkarnnvbAtg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d108d0b-8671-47aa-95c5-08d8c75a29b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:08:53.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhf1LdOQCXdH6Blw6g4QaeccNTnKLl5r4iT/4Rz68wCmX+cyes2tSvO40KW08h1d3HUa/MzULRPX1bcy85xRIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6448
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Typo in the patch title.=0A=
=0A=
=0A=
On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> null blk driver supports REQ_OP_DISACRD in membacked mode. When testing=
=0A=
> special requests having REQ_OP_DISCARD support is helpful to validate=0A=
> the special request path when mixed with read-write.=0A=
> =0A=
> Consider module parameter when setting the queue discard flag when=0A=
> device is not memory backed.=0A=
> =0A=
> This is needed to test the tracepoint related to REQ_OP_DISCARD.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
> # modprobe  -r null_blk=0A=
> # gitlog -7 =0A=
> 4ac4d49e1028 (HEAD -> for-next) null_blk: add module param queue bounce l=
imit=0A=
> 468e3617dae8 null_blk: allow disacrd on non-membacked mode=0A=
> bdc96efe9681 block: get rid of the trace rq insert wrapper=0A=
> 73bf523a7ce4 blktrace: fix blk_rq_merge documentation=0A=
> 6016632555da blktrace: fix blk_rq_issue documentation=0A=
> 58b5d7103a94 blktrace: add blk_fill_rwbs documentation comment=0A=
> 534f321f57dd block: remove superfluous param in blk_fill_rwbs()=0A=
> =0A=
> Test to exercise module parameter vs configfs discard param, set up=0A=
> nullb0 such a way that it errors out in both cases for module param=0A=
> discard :-=0A=
> =0A=
> for discard in 0 1=0A=
> do =0A=
> 	modprobe -r null_blk=0A=
> 	i=3D0=0A=
> 	echo "Module param discard ${discard}"=0A=
> 	modprobe null_blk nr_devices=3D0 discard=3D${discard}=0A=
> 	# Create dev 0 no discard =0A=
> 	NULLB_DIR=3Dconfig/nullb/nullb${i}=0A=
> 	mkdir config/nullb/nullb${i}=0A=
> 	echo 1 > config/nullb/nullb${i}/memory_backed=0A=
> 	echo 512 > config/nullb/nullb${i}/blocksize =0A=
> 	echo 2048 > config/nullb/nullb${i}/size =0A=
> 	echo 1 > config/nullb/nullb${i}/power=0A=
> 	echo -n "$nullb${i} membacked : ";=0A=
> 	cat /sys/kernel/config/nullb/nullb${i}/memory_backed =0A=
> 	echo -n "$nullb${i} discard   : ";=0A=
> 	cat /sys/kernel/config/nullb/nullb${i}/discard=0A=
> 	# Create dev 1 with discard =0A=
> 	i=3D1=0A=
> 	NULLB_DIR=3Dconfig/nullb/nullb${i}=0A=
> 	mkdir config/nullb/nullb${i}=0A=
> 	echo 1 > config/nullb/nullb${i}/memory_backed=0A=
> 	echo 512 > config/nullb/nullb${i}/blocksize =0A=
> 	echo 2048 > config/nullb/nullb${i}/size =0A=
> 	echo 1 > config/nullb/nullb${i}/discard=0A=
> 	echo 1 > config/nullb/nullb${i}/power=0A=
> 	echo -n "$nullb${i} membacked : ";=0A=
> 	cat /sys/kernel/config/nullb/nullb${i}/memory_backed =0A=
> 	echo -n "$nullb${i} discard   : ";=0A=
> 	cat /sys/kernel/config/nullb/nullb${i}/discard=0A=
> =0A=
> 	# should fail =0A=
> 	blkdiscard -o 0 -l 1024 /dev/nullb0 =0A=
> 	# should pass=0A=
> 	blkdiscard -o 0 -l 1024 /dev/nullb1=0A=
> =0A=
> 	echo 0 > config/nullb/nullb0/power=0A=
> 	echo 0 > config/nullb/nullb1/power=0A=
> 	rmdir config/nullb/nullb*=0A=
> =0A=
> 	modprobe -r null_blk=0A=
> 	modprobe null_blk=0A=
> 	# should fail =0A=
> 	blkdiscard -o 0 -l 1024 /dev/nullb0 =0A=
> 	modprobe -r null_blk=0A=
> 	modprobe null_blk discard=3D1=0A=
> 	# should pass=0A=
> 	blkdiscard -o 0 -l 1024 /dev/nullb0 =0A=
> 	modprobe -r null_blk=0A=
> 	echo "--------------------------"=0A=
> done=0A=
> =0A=
> modprobe -r null_blk=0A=
> modprobe null_blk=0A=
> blkdiscard -o 0 -l 1024 /dev/nullb0 =0A=
> modprobe -r null_blk=0A=
> modprobe null_blk discard=3D1=0A=
> blkdiscard -o 0 -l 1024 /dev/nullb0 =0A=
> modprobe -r null_blk=0A=
> =0A=
> # ./discard_module_param_test.sh =0A=
> Module param discard 0=0A=
> 0 membacked : 1=0A=
> 0 discard   : 0=0A=
> 1 membacked : 1=0A=
> 1 discard   : 1=0A=
> blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported=
=0A=
> blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported=
=0A=
> --------------------------=0A=
> Module param discard 1=0A=
> 0 membacked : 1=0A=
> 0 discard   : 0=0A=
> 1 membacked : 1=0A=
> 1 discard   : 1=0A=
> blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported=
=0A=
> blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported=
=0A=
> --------------------------=0A=
> blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported=
=0A=
> ---=0A=
>  drivers/block/null_blk/main.c | 11 ++++++-----=0A=
>  1 file changed, 6 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c=0A=
> index d6c821d48090..6e6cbb953a12 100644=0A=
> --- a/drivers/block/null_blk/main.c=0A=
> +++ b/drivers/block/null_blk/main.c=0A=
> @@ -172,6 +172,10 @@ static bool g_shared_tag_bitmap;=0A=
>  module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);=
=0A=
>  MODULE_PARM_DESC(shared_tag_bitmap, "Use shared tag bitmap for all submi=
ssion queues for blk-mq");=0A=
>  =0A=
> +static bool g_discard;=0A=
> +module_param_named(discard, g_discard, bool, 0444);=0A=
> +MODULE_PARM_DESC(discard, "Enable queue discard (default: false)");=0A=
> +=0A=
>  static int g_irqmode =3D NULL_IRQ_SOFTIRQ;=0A=
>  =0A=
>  static int null_set_irqmode(const char *str, const struct kernel_param *=
kp)=0A=
> @@ -1588,14 +1592,11 @@ static void null_del_dev(struct nullb *nullb)=0A=
>  =0A=
>  static void null_config_discard(struct nullb *nullb)=0A=
>  {=0A=
> -	if (nullb->dev->discard =3D=3D false)=0A=
> +	if (nullb->dev->memory_backed && nullb->dev->discard =3D=3D false)=0A=
=0A=
What is the point of adding nullb->dev->memory_backed  to the test ? If=0A=
nullb->dev->memory_backed is true, nullb->dev->discard should be forced to =
true=0A=
also to retain the behavior we had until now.=0A=
=0A=
>  		return;=0A=
>  =0A=
> -	if (!nullb->dev->memory_backed) {=0A=
> -		nullb->dev->discard =3D false;=0A=
> -		pr_info("discard option is ignored without memory backing\n");=0A=
> +	if (!nullb->dev->memory_backed && !g_discard)=0A=
=0A=
I do not understand this one either. Why look at g_discard ?=0A=
=0A=
>  		return;=0A=
> -	}=0A=
>  =0A=
>  	if (nullb->dev->zoned) {=0A=
>  		nullb->dev->discard =3D false;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
