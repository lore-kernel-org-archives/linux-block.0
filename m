Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C076C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09282600A
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SgtoC1k8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PyXTt7V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEaCBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:01:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35992 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268108; x=1590804108;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T2ON8qYqVkn7VhPg+7ev34wL47FS3rb1ed8Sk8r8zRY=;
  b=SgtoC1k88KkFg1oaIAJW/CKkMK/pTg7iEXMC/XuXJZQgqSMyJ4hQtsPS
   3XEQXW5fP8kmGPxKrKz17BfPaKv/5qt5KIUkyDjgTqyuZnwa8sLz2zhZz
   SLpDTzRUr+RjFgjHip7p7GIFypelCpHJrXUHz0J18+3SWnJTfVOHOlOYz
   BwezZOCwkOxbbNpPPdARlGndUoc49FkaDVvRsfcUmID+qKJV5DPQ2Hxyc
   mqTAA8TdD56o/vg7x5V/4uVRxYUeK+EgUml6wie67JzkzMGOGZBa6eoRN
   HLnxgCn8jYQmP9dvJ6EwSfQSWiT1bfrOVvo5WQoWTtCIeUDVJMyKeucZz
   g==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="114412928"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:01:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p02aOmqnaTMzDvBtdNDklDZioDqGkNy3rh9XsgbZsmY=;
 b=PyXTt7V+v2w3Vxlm4W8/jAALf01iDsCVG6qE4EE4DSSuwhT9gA7sm6jbXcYgTxaRI371gKvuDxhH2yVOvL6hMNTZLluyXp0wFTFX4tsPLjV0maP5Ky4UTl2EWbWtfYkkFdxjAFQKj/krM49ieJDrUdCCFwQ5Ys4GsnQSBddjipc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:01:45 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:01:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 4/8] block: Fix blk_mq_*_map_queues() kernel-doc headers
Thread-Topic: [PATCH 4/8] block: Fix blk_mq_*_map_queues() kernel-doc headers
Thread-Index: AQHVF0P27ksbF+KR0E2ZSvChU4eD1w==
Date:   Fri, 31 May 2019 02:01:45 +0000
Message-ID: <BYAPR04MB5749FC4EA0A79CD0C9A159DF86190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7f681dc-62e5-4ee7-7e5a-08d6e56beeef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB567054B30DF0D0E4235C85D086190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(4326008)(256004)(14454004)(478600001)(305945005)(7736002)(54906003)(110136005)(26005)(8676002)(8936002)(66066001)(486006)(9686003)(33656002)(71190400001)(81156014)(81166006)(71200400001)(186003)(55016002)(72206003)(316002)(25786009)(6436002)(66476007)(66556008)(66946007)(66446008)(64756008)(102836004)(76116006)(73956011)(3846002)(53546011)(6116002)(6506007)(5660300002)(53936002)(2906002)(76176011)(86362001)(74316002)(52536014)(68736007)(476003)(99286004)(7696005)(446003)(6246003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nHqa96Ocbu7dzqaY47wkv3LMid+WJ049AMP/fdHPofBr2Q7RY5pAnzt0AqZ0TYOOD8fZCY6iaBvrg2l7rP4PjSRW8dkUWoSSdZ2w6Butcb1e9jKUswWdGYQTZzg3pf5GT2qOeyonvtduexGRWRSD7zEGQ7mvDc7eJW6/g1ntmr1IU8CWugC43GAMaF+eaSHbChDX/XUsP4+02mu0llLg8iI1vNrvnjVR6nHWaOmuAygI7n0LBWOfW6I0rglWdeAnah5GfapAvFk+r3uu/jg96T+6DiB82S2Sd1Tl8mOmA9iWjbfnN71C8UEPKFLA5/APDI5TAkpdBv7l+gY8P9Qq/jIuxKMx/MIS+dgP+gR3zuZ1O0lg4vFWLFV46PTV+Ss3D/Ks1YAxUi7fQqJNp5knAgDuqlCQGouR/4e7zrDvAx0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f681dc-62e5-4ee7-7e5a-08d6e56beeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:01:45.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5670
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chiatanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 5:01 PM, Bart Van Assche wrote:=0A=
> This patch avoids that the kernel-doc script complains about these=0A=
> function headers when building with W=3D1.=0A=
> =0A=
> Cc: Hannes Reinecke <hare@suse.com>=0A=
> Cc: Keith Busch <keith.busch@intel.com>=0A=
> Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0.=0A=
> Fixes: e42b3867de4b ("blk-mq-rdma: pass in queue map to blk_mq_rdma_map_q=
ueues") # v5.0.=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-mq-pci.c    | 2 +-=0A=
>   block/blk-mq-rdma.c   | 4 ++--=0A=
>   block/blk-mq-virtio.c | 4 ++--=0A=
>   3 files changed, 5 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c=0A=
> index ad4545a2a98b..b595a94c4d16 100644=0A=
> --- a/block/blk-mq-pci.c=0A=
> +++ b/block/blk-mq-pci.c=0A=
> @@ -13,7 +13,7 @@=0A=
>   =0A=
>   /**=0A=
>    * blk_mq_pci_map_queues - provide a default queue mapping for PCI devi=
ce=0A=
> - * @set:	tagset to provide the mapping for=0A=
> + * @qmap:	CPU to hardware queue map.=0A=
>    * @pdev:	PCI device associated with @set.=0A=
>    * @offset:	Offset to use for the pci irq vector=0A=
>    *=0A=
> diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c=0A=
> index cc921e6ba709..14f968e58b8f 100644=0A=
> --- a/block/blk-mq-rdma.c=0A=
> +++ b/block/blk-mq-rdma.c=0A=
> @@ -8,8 +8,8 @@=0A=
>   =0A=
>   /**=0A=
>    * blk_mq_rdma_map_queues - provide a default queue mapping for rdma de=
vice=0A=
> - * @set:	tagset to provide the mapping for=0A=
> - * @dev:	rdma device associated with @set.=0A=
> + * @map:	CPU to hardware queue map.=0A=
> + * @dev:	rdma device to provide a mapping for.=0A=
>    * @first_vec:	first interrupt vectors to use for queues (usually 0)=0A=
>    *=0A=
>    * This function assumes the rdma device @dev has at least as many avai=
lable=0A=
> diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c=0A=
> index 75a52c18a8f6..488341628256 100644=0A=
> --- a/block/blk-mq-virtio.c=0A=
> +++ b/block/blk-mq-virtio.c=0A=
> @@ -11,8 +11,8 @@=0A=
>   =0A=
>   /**=0A=
>    * blk_mq_virtio_map_queues - provide a default queue mapping for virti=
o device=0A=
> - * @set:	tagset to provide the mapping for=0A=
> - * @vdev:	virtio device associated with @set.=0A=
> + * @qmap:	CPU to hardware queue map.=0A=
> + * @vdev:	virtio device to provide a mapping for.=0A=
>    * @first_vec:	first interrupt vectors to use for queues (usually 0)=0A=
>    *=0A=
>    * This function assumes the virtio device @vdev has at least as many a=
vailable=0A=
> =0A=
=0A=
