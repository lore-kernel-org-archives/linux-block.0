Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645EC282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0903E20663
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XTvJwA21";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I1B5MBhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfDSSvy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:51:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35781 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfDSSvy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555699913; x=1587235913;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dDJOXeQAuLapSXek2T+lXgCJ3JEWd8HdFfGOljcn3jc=;
  b=XTvJwA21rpxu+IMt1XC9nSQ2NH+CmdAyKlLIM1RCpCx4F3UgksdR5YLB
   wEv/+gUUtuUTWyL4p+w9PVSQJcKqYmmnardUaQ8vK/4TanSZJcJ+NrjsR
   WYizy1N9kf/sMrBJ4GfdjkIB4OfthJUBpjb+02O+a75R9jaDTvNVj4u8l
   C+90MeaxU+5J81piK+TQsvvGwX96wgT6yJP+H9Vl4HH9sJVkTBf6DG0/6
   jdzACbhg9xj9sF15gMcsBMDwK1rkqDL/7uFCCVy4/LqYaQicRpdvdkhJQ
   hFrS4ju2/Eiy90a+x3a//wLVN+f3PGOtwaZC8BX/4kZi/OZDZtWpF3Ty7
   w==;
X-IronPort-AV: E=Sophos;i="5.60,370,1549900800"; 
   d="scan'208";a="106369749"
Received: from mail-bn3nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 01:29:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/aYlLrqWH/sGkjsSOegXmMjXsSjtRTbyNtDGDIAato=;
 b=I1B5MBhC8e4bCREA9UTTMadJ7Bnc6moMufxgCr/cJEd2th6t5zZYPVfRTAyrS2vAfHwlMPNHJATCwzMt0iOc8V2gs2FgNiGVhprJQldCmC9/VMmFKTlQUVMLL0fQcwE3MhghnUZLFkP1hQmVOpSbsZmAj2r0wwvjDYSVh0iJ/2I=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4413.namprd04.prod.outlook.com (52.135.72.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 17:29:20 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 17:29:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hou Tao <houtao1@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] block: kill all_q_node in request_queue
Thread-Topic: [PATCH] block: kill all_q_node in request_queue
Thread-Index: AQHU9lmE1AtNyBRypEaXT6ub+91Ttw==
Date:   Fri, 19 Apr 2019 17:29:19 +0000
Message-ID: <SN6PR04MB4527F9689EDBB2B97C914EA286270@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190419023127.71085-1-houtao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b8c9edd-2d0f-4da4-0c67-08d6c4ec8e6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4413;
x-ms-traffictypediagnostic: SN6PR04MB4413:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4413447DC9D18022AE33276B86270@SN6PR04MB4413.namprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(256004)(54906003)(110136005)(2501003)(4744005)(2906002)(8676002)(55016002)(4326008)(81156014)(81166006)(316002)(76176011)(66446008)(53546011)(486006)(8936002)(91956017)(52536014)(66946007)(66476007)(66556008)(6506007)(76116006)(97736004)(73956011)(64756008)(102836004)(14454004)(14444005)(68736007)(25786009)(33656002)(7696005)(476003)(71190400001)(71200400001)(99286004)(6436002)(186003)(5660300002)(72206003)(53936002)(305945005)(7736002)(74316002)(6246003)(478600001)(9686003)(66066001)(26005)(229853002)(3846002)(6116002)(86362001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4413;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vF21/ixWvuehIJUHmhvevQoTK3lNNvaR7A7TOI2amPsJTdHqW/1xR3JA7wV0O2HfJdZZiIqCenRHrKcn2Qip8nbGSPl0hjauHRiqrBFnVgCrFxgKg26uDb108fGNgk3ZmxWzNFB047roDR2aH0Eu2SaFBPI2GNdP8+JfnolEOuvl4BA0tCWajdK+E+J0g6EZqAxQMSi2Y0i+gqZllR6Rl/wpEkWBAQE5vgmhUmPEM6hakeWQww5fAD+lAX2PFqtrQytmSQQ4aifOntIGU0dvZpdqG4jz8M3SeF2J4g+qLpDnqhhkjz7BVf433L1f9n3QHbJ5sOO3a1F8HoyMBjC141fTbOyO6rwCB+15RyzkLI4qZalgm45WbZOSVCF+5dIbkQjkPZwYoxZsh1fMekxb20Tt4mtZ9RRsAOcRjoglffQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8c9edd-2d0f-4da4-0c67-08d6c4ec8e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 17:29:19.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4413
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/18/19 7:42 PM, Hou Tao wrote:=0A=
> all_q_node has not been used since commit 4b855ad37194 ("blk-mq: Create=
=0A=
> hctx for each present CPU"), so remove it.=0A=
> =0A=
> Signed-off-by: Hou Tao <houtao1@huawei.com>=0A=
> ---=0A=
>   include/linux/blkdev.h | 1 -=0A=
>   1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 5c58a3b2bf00..317ab30d2904 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -548,7 +548,6 @@ struct request_queue {=0A=
>   	struct rcu_head		rcu_head;=0A=
>   	wait_queue_head_t	mq_freeze_wq;=0A=
>   	struct percpu_ref	q_usage_counter;=0A=
> -	struct list_head	all_q_node;=0A=
>   =0A=
>   	struct blk_mq_tag_set	*tag_set;=0A=
>   	struct list_head	tag_set_list;=0A=
> =0A=
=0A=
