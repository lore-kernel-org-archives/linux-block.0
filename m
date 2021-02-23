Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C8C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C847664E4D
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhBWHjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:39:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhBWHjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614065941; x=1645601941;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jtNaw+rQKgFvlyEjRIOl5Dvr2asY1onEyGIpZ2rmpHA=;
  b=hvJv869reINJtgmtL3iN9EQfvoJQp02yJqISG+SDC8FRVbh8LzLKA1Fz
   qWK25gkBP1f6rlmsQCrJyq8AjgvNYc2FKdUCUvuXVAGSQgBpL/Hvo0hC0
   JH9q3bvAHH4QeJm7ewk0BeyrZkXQ+zZFNFs7rkQHCecVsiVux29/GK0SM
   09uCID47kYgKryqeOLcbvpx9aQZmBe19d6GzEKxmMFYeAB/YDaqpNcqwu
   jLX+8pTqKKKbAlbFk5HYrXfIv1DMNFdT27X1z0phML2C81L1XVgryXD9s
   iquXn4Qt0/Oq1cUIZyBSWJcP0wFyARv6/uGqUrQZYlMdNDUUn9NsoqQuy
   Q==;
IronPort-SDR: r9Gf9U+v/3iUk4xpvjY0ElK4lxi7tdE7u4P1nMvX45upnx+Y+Zj6rF17BwspPCol1AHcXUXUbe
 76McgaTNa7zBb+Wxd6pvx9fIzIqW7WHfpDcUg+k99Ub/uUtN29tOIgwLeBCXZRWhL1jDivh5+n
 SdXo1chZq499KwACQ0cNMVUHzChEYJWjXnzvyAeEMG21pjIfUSPLeZHxXZuRP4xmxCZLd4mNIP
 zBOZwVvHwsoMZGUbI4S75Wq2d61iZYZjILcP4WSz6s0/G7oNf+dy4R8p70oz6ZTGGeIVBQ20F3
 6P8=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="271116073"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 15:37:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUFq2NhFCgGKvbcloXVdWaaJWDf30HnYB3MGl6J+MM+C0VeDv8VSalI2mV8E6GLKv+kXoOKIaVXB6u/pBO3XVvb0rGLUyBFbJIFjM2Lu6EWfEweVcRlXD1yx4GdkIPfeSP28rMHX3Oz7SQxRqeUDCurNCJnGnW+XH0Ry543uY5Q1Dq3J+Z5zKaIrwiORK3e+Zd1aHnfpEvDl8/fzDZmoIYf5md6JIKpw4MRCDjhxysST9dDJDeyfunXTuwDBwQZ44xA/dD1UL3vfpxzW3+FvIM+UFCA4EeM7uyApNVkhwGR4Q396NN6A4fc/DYubzEyN+G84XIcjuwBw3Bg2vP/tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpzKNz4yQusuCGAlzn+aiVTTPOchAfA5F0gvirSV1hw=;
 b=Xz3zcBlBByd69GLJYC2HbpKAPkn1wnC+OXM4X4gygTXNV1K/bw8wKGnDOYGtwawf41PFn3F/JTQ4HnZjzEh5ge/IoynkWBelTdPR3/+L938H11O8a7ThJjDaBtB4TX+RSyVSubN4cbLRsnc1OtHGw7Ddr+Q24M8+XZjryTy6TrhTc0ocLxXH0CFQwao20o4b5qPbgUb07qjuhf+dHzN8BC7SnzgJ31f61ks0mEGS4Xq/1lRwD5lqMI+au+5FK0aggqy4f/xiy1/2xCijB+G0zX6PAUYN8A6vFLES0gcCQVqo/5rHzEWasMcXjG6OyozB+TRR1DTKjKDnoLO1LowBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpzKNz4yQusuCGAlzn+aiVTTPOchAfA5F0gvirSV1hw=;
 b=RubY80EcJ51Wr55GuEexB/EDM/4cPXB1lApFo4tPw3S9B2J/q3TvD1BmiPp4zHmUZuxnaBgq95P2WXf3053glq5ef1erFjkWv/7kBYOcGLIYXpJfT1OXYeCxudBu7k/sl7pwbHUQhAri4uKAXKEWNlPCdFl3c43H4XVkImIRa4A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BY5PR04MB6280.namprd04.prod.outlook.com (52.133.248.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29; Tue, 23 Feb 2021 07:37:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 07:37:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Topic: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Index: AQHXCZD3vAo2wh9jek+o1gtQqbdo1w==
Date:   Tue, 23 Feb 2021 07:37:52 +0000
Message-ID: <BYAPR04MB496574519941459FE83C437D86809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210223071040.GB16980@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 879f6857-0daa-4135-e4ac-08d8d7cded5a
x-ms-traffictypediagnostic: BY5PR04MB6280:
x-microsoft-antispam-prvs: <BY5PR04MB62807DE9FB0D3A3CC11B5DA086809@BY5PR04MB6280.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCMZBYacWeV0T+fQ4laJvUOBskt3olYopnpvgFAqBJT15Yl1pNrA5J6a5Nzo4gnS9qbquPriaQRcGmJEEDVuGV/G4AKuCFV7vAErnQntr33gcts3LSkBq0tqjMYRpwp7hSullPyCbo7peywkESq6CqstRSvZXq0RzxECyrXPwV3rFozIw4A5t++XUndkO6EePhx0DXuNXr/Tyr0svaFe7YCU36MvHd+A6eQaWDiKjGPjA6xlTEVCv7uZMOaczl8Pux9axh1wahTr+nz14O2smFqaSKD8ovR4KNKQ58lLb1Sf/E58oTxF60hJVzwv+787WdZHHD1vAvMr3pgproy+F64ej424m8W3cpL8Y1gXNDoNF6gCX+6fNMijY+6JkHjTKPD+2TgNUfhjR7ROw8f6KsT1ug4Rs7ZTkX5IZYticytuOVh4ei2xhywE8JIZMPQalavC9Q8bDug5NXwaD883xsD2TCkUVlbolG3nS9qiNL4/7YSIS20HMsmiAPYOblPWZHKjTMudWubvS2UvZ+HVwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(6916009)(33656002)(86362001)(76116006)(26005)(186003)(66446008)(66556008)(66946007)(66476007)(64756008)(55016002)(7696005)(54906003)(71200400001)(4326008)(316002)(2906002)(9686003)(8676002)(53546011)(5660300002)(4744005)(52536014)(6506007)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eX31LxN9JSqJ0on2sIepbKPKx77Nkj2EYGphugd9lpNiMlOeTPgsoM86LbIP?=
 =?us-ascii?Q?4oFVOsWSOgA61LfVUak/OFWLiJOmBMnH7iXTY0RRAWgK3gqTVVwgEWImkt04?=
 =?us-ascii?Q?8pxRWF3wLREZRvJxtIRPCCh9kHrLRAWMmtTUgtA+GJyQ74wzV6GPMVUswXHP?=
 =?us-ascii?Q?i/kcHlqsNj5EitbxWJNE6yUoYOcrFxBWOZIjYSg6ktmceaSunZ/SB5LHJlGy?=
 =?us-ascii?Q?GBjksa9Z46wXbGvbB/nCa1zITiJlxCFnbi+mK8WXLEvT6Fzf/dEfY2Ab+rzZ?=
 =?us-ascii?Q?20lGqGHaJBPqC1kg85FJnLGIlxvcr827tqhEGwqw3PHYL1LQy1nyYzcvAg9T?=
 =?us-ascii?Q?ncWGS3O99+OOypZhs9N6AUn+Jt4MSzdgXNU1ffjNrGB6blKFF5F6ULNA6BMZ?=
 =?us-ascii?Q?GjKkCGOoYcjJQOCxze760ngNpdeI8utM2gEcf7gWxL2f9hE56n73BbhNi/Xh?=
 =?us-ascii?Q?bxP+KiOhbgTmR4wRe1UkKEJzWbkmf7TL0239a0YttcbFKpYtV280u386JF+S?=
 =?us-ascii?Q?JoEwb1gO5VLI36M/HBsYhqVmWcagDTwmT1WpvLCmTFZgduc8kHSeIEkjaFNx?=
 =?us-ascii?Q?7tvBMBAtou2QyLzN8zZmiQ0VY8MycPGJTzDAgtHYI8+u/3wyTX/XJxEZNPzL?=
 =?us-ascii?Q?Em4taEE+YRdHdR1liR4Kyn7xsCfdnd7KPytjYRVMhu7n1p+LQ/nkK4THqb5k?=
 =?us-ascii?Q?2FNQVKgB8emr2mj3G5xQal65/m0i1qL8N4zYEmbDQi1gfa0rKYVwkSWccwTB?=
 =?us-ascii?Q?takOzAGi/ylkZvj+ggt5pwJewQVnaYzglvZsEpvwoDUnUZlCy6WFLnFn701t?=
 =?us-ascii?Q?yif7owj6RgLC1jZtGjybDydI8l8HB2wpz6znEjLm9Ez7YaWeIQAsirLOiUDI?=
 =?us-ascii?Q?/AP1H7sG0nmf+ouYPxyxr7/TICA4yldmF1UyWwHvy6zfxhX9GsS4md78M8kf?=
 =?us-ascii?Q?LTDom9l0rKhoG80b0uysYrm6x3BTtBzuF/TkbQklIj2SlOq93H6FsIKy3pv1?=
 =?us-ascii?Q?IVXTWVe1FQKVkUoqVAUpk7Spp94BkqZqgAfeOxPviOvklipS59lcQR2eTYrV?=
 =?us-ascii?Q?R0PYHiFm6TUOYha9QPVnKjlRU0v17uK6sPHgvyUr7UDsSyKGfhuLfcaG9Zob?=
 =?us-ascii?Q?YI+cYClcAKmDxjKc2ONhBwLapFYafLVE0DVkFQQPiq9GrjcEMdfPApUKzQdx?=
 =?us-ascii?Q?NqOdEkvwKeWiKWcaEOIuh5Cu1oqa2Ln4e+ylPPAFylbCoWRKalKvDUZtapoD?=
 =?us-ascii?Q?rvjX0W95ggAu7Jl1UyN7I9wo/aWlOlsQhNsv1+N0zdPGC5WQHEc0wDpnZrN8?=
 =?us-ascii?Q?SCH2Bm0aCoNteXVLTictEUYpE4NWtpO/E1+N6ENi2UL2MA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879f6857-0daa-4135-e4ac-08d8d7cded5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 07:37:52.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNOtSCT/WVrmAfr3CnBaTyfc5ajkFXeW0sD4kPpAkAV4AL+/CAWb41lyT4qF90RElhjQj/drVIkkSUmF0/zzYB0CANQgjUrepeJ4cE0aAOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6280
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 23:10, Christoph Hellwig wrote:=0A=
> On Tue, Feb 23, 2021 at 03:51:23AM +0000, Chaitanya Kulkarni wrote:=0A=
>> Looking at the other call sites do we need something like following ?=0A=
>> Since __blk_queue_bounce() passes the NULL for the passthru case as a=0A=
>> bio_set value ?=0A=
> Well, that is a somewhat odd calling convention.  What about the patch be=
low=0A=
> instead?  That being we really need to kill this bouncing code off..=0A=
I assume you are sending this patch, let me know otherwise.=0A=
If you do please add, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
