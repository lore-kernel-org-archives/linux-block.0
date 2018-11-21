Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A984DC43610
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 00:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9ED2145D
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 00:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9ED2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kazan-networks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeKULNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:13:05 -0500
Received: from mail-eopbgr790047.outbound.protection.outlook.com ([40.107.79.47]:36384
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeKULNF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 06:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kazannetworks.onmicrosoft.com; s=selector1-kazannetworks-com01c;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN9F/txaCuXAV33sFkA0pnuq4L8ToLQIdesA0aDaIQE=;
 b=DxoaQBKStxw6JtQ+8+VJ3p2JRd81XlBzNWAn7JCUj+JK4diOiM9ASxT1UX6juZphpx8z0Nvi5CF39xINV+mNn687K7DH8N9dknKlVUFVhaWS7Z5daZCVUFmOjL4Xb5RidduWMQKlHBtSDEJGK76uLxRfi3poZe1p1znhZg2vkag=
Received: from CY4PR08MB2582.namprd08.prod.outlook.com (10.172.157.16) by
 CY4PR08MB3544.namprd08.prod.outlook.com (10.171.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 00:41:03 +0000
Received: from CY4PR08MB2582.namprd08.prod.outlook.com
 ([fe80::1531:7db6:a1b8:d409]) by CY4PR08MB2582.namprd08.prod.outlook.com
 ([fe80::1531:7db6:a1b8:d409%5]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 00:41:03 +0000
From:   Ethan Weidman <ethan.weidman@kazan-networks.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
Thread-Topic: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
Thread-Index: AQHUgH08qGftzZlx+0O7C+eVpsYyUKVZZC9w
Date:   Wed, 21 Nov 2018 00:41:03 +0000
Message-ID: <CY4PR08MB258265FB085A9C26B6F27D93CFDA0@CY4PR08MB2582.namprd08.prod.outlook.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ethan.weidman@kazan-networks.com; 
x-originating-ip: [50.225.120.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR08MB3544;6:DlKn+Smme3xs1jWSSDUA0lbmNvmIpWch5orrzUz2SxwkbsQma1P6Hz8YGCX2pX3nxn6r/QEEOlv/K9tjulgRjrWxgyZvlDjYauGJQpC3QphrSyzrcNcNVWKgGz2JCYM6avlE6RWhdhAfA+Vjh8Mq1LRdDBYjzcoIofFXo0+oFk7A9EtBO5DkJk9vuv6to2mm2o/kUfKPldU4vfPGpzAdLDyLFN9tFe//XDznVFlU/epKZrZSgq0YiLP0WAJHXUbJYu6ZegRfkXNRJmrl58jRV3+xKUWyeUAsq1V4ylxluhxb0/YM8yPZS/vmHtghbAvOWmRWn9AR/I+VkC0FB/5L0cpkWKqTtlTxxiL6WOOOYx7qW2rQcxIwXVz15EALOjlhi/VeM9lDcptgSdjt4V3x6u9hKBaisyLu409Er7KsYrqcAAPJaHTZxUqWbLn3zip+BRYjMWqNMuzngNLdp4Qnlw==;5:2taPDDUgGZqJqm0dGchDK9jzmeFQthD1otOia1G58Q0/oe9H+TfIlbOKqGmItAkTb3p6IVimyrLgqcZf5cXYV8tfs6wAvmnWbBXxD1m2CNFQVCZfKZe/3SYLy9nong90emmdgjwg50CI5t8Pb2xBFts0k1BcGX8hlIAry8dcIEE=;7:mCkZKL1khcbaxHmJcvCsi3r3Z303zcbeJY/WrUZ0kSJ4Bzsj91UJsQoRe63QoesaJLpvTY8cU9KMQjl+AjNnWJPcSNz3nAYS+nBD4fVzEOZHJeWCkKwKdk5gDz6/vaCvQefkfGpRlojuG2OjRhLitw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e3c42de-6d2b-4321-3600-08d64f4a0435
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY4PR08MB3544;
x-ms-traffictypediagnostic: CY4PR08MB3544:
x-microsoft-antispam-prvs: <CY4PR08MB35441B9D1EAFDFC11ADA7A83CFDA0@CY4PR08MB3544.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR08MB3544;BCL:0;PCL:0;RULEID:;SRVR:CY4PR08MB3544;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39830400003)(199004)(189003)(76176011)(256004)(66066001)(105586002)(106356001)(71200400001)(71190400001)(2501003)(99286004)(186003)(81156014)(6506007)(53936002)(26005)(8676002)(25786009)(6246003)(14454004)(7696005)(8936002)(81166006)(86362001)(102836004)(4326008)(68736007)(476003)(446003)(9686003)(11346002)(5660300001)(229853002)(2900100001)(6116002)(2906002)(3846002)(97736004)(44832011)(7736002)(110136005)(305945005)(54906003)(33656002)(486006)(74316002)(55016002)(508600001)(316002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR08MB3544;H:CY4PR08MB2582.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kazan-networks.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: glPE44OsXnrNHx/T8CbIRewJg9zW3bZI0sSBScWFRuqsLzUbufUGAkK9ZMf6nVtzTTgAcrhB7hR3KSM2Uwa7/rqbkWHQxZQo2ElOx0/YSaZCTFYD9U3NTpcFk3L1KQsM6eC7CLBByfnNpx761sxMX2rrVtpdVlXq/rJAPuQJuI0IAtlSqL0j4NBzO/JRg2ePsyXLddPvQRJ37/itHfA6pAlEFoUQGq/11DkePxqo0BhSPg4pRifLMwItoYBgVtIk9vHU+uOT+BBuz777TablhQRNMQGhLWWUQ8oT3LpxnAumcwleT6yHvnwzqZsdb2Zo8/I96/NmtvPcqbfjKxx2MS85EYZz5Ac/JZmrEmTnRwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kazan-networks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3c42de-6d2b-4321-3600-08d64f4a0435
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 00:41:03.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4be78cb4-18e1-468c-af31-7f1298442f0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR08MB3544
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>+static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>+               struct nvmf_ctrl_options *opts)
>+{
>+       struct nvme_tcp_ctrl *ctrl;
>+       int ret;
>+
>+       ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
>+       if (!ctrl)
>+               return ERR_PTR(-ENOMEM);
>+
>+       INIT_LIST_HEAD(&ctrl->list);
>+       ctrl->ctrl.opts =3D opts;
>+       ctrl->ctrl.queue_count =3D opts->nr_io_queues + 1; /* +1 for admin=
 queue */
>+       ctrl->ctrl.sqsize =3D opts->queue_size - 1;
>+       ctrl->ctrl.kato =3D opts->kato;
>+
>+       INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
>+                       nvme_tcp_reconnect_ctrl_work);
>+       INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
>+       INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>+
>+       if (!(opts->mask & NVMF_OPT_TRSVCID)) {
>+               opts->trsvcid =3D
>+                       kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNE=
L);
>+               if (!opts->trsvcid) {
>+                       ret =3D -ENOMEM;
>+                       goto out_free_ctrl;
>+               }
>+               opts->mask |=3D NVMF_OPT_TRSVCID;
>+       }

NVME_TCP_DISC_PORT, 8009, should not be the default for nvme fabric connect=
ions when trsvcid is not specified.

NVME_RDMA_IP_PORT, 4420, should be used, or renamed to something more gener=
ic.
