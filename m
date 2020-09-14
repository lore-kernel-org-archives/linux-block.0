Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BEEC433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C97B208DB
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hR84b0kV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aOyvLRqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgINMrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 08:47:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54368 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgINMrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 08:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600087636; x=1631623636;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3Pz81gqJVlKP1sFeJs0rcJRn1wPu0ahD/zQKJ4Jlo24=;
  b=hR84b0kV1RMh5lfOCu8l8tFl+OAnxvXBxoA809xwRPWNmF0pSrixDmHw
   vTqImSTWMbaczD6QXa+EefSH31OxPiEYbi1F2Po1QcQjFrZydts3AoCoh
   umXml4KTTWzGOrN1ZCiOthXtL+JqxIZ7Qfju2gJeixDYEmatSP/EzJoB3
   sZMfLZGovXWhXVLQPYffUBzq+kSHKwhSJq+B/YrLmX/XTb3GJxd4Ei6vv
   3Hb8vk4el8DpkD8RDAF+mwEv5Vyb5oJL4pIPxyjYzZ9PtGI8pHuIzQSRc
   kW/n94ngdEc3NrY/OEon8caqQVj9DzYI8red1TOFYelN8jTAmRoVnQZwh
   Q==;
IronPort-SDR: 4nyYf+YRG64CzQwqR6XzhBNBHBzWzmznhudiiTTJu6pmC3iMurqUczof63nUkSCNim+m64xSqQ
 R8BKxmQl5gb8u0xYf8pRHmp9NV5zrV79hAvzgdtfQWvBn8S8SUVeX7BJD3xdY1IXs7XCJmoWy4
 DzI+6f7i3XCZup1cyi4LxwJo7MI4pCK2UnskLOFPc8so+QJTlX9TDOd2lrW/U045oFpwft5cPK
 RlsRiqpOf9GDf3cGcnJpgioioNZtcIAovXG1SC51i7z29wnF9NbJnssoT0TyM0PViZPCCvKPW/
 GbQ=
X-IronPort-AV: E=Sophos;i="5.76,426,1592841600"; 
   d="scan'208";a="148539248"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 20:46:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ/QZPZvM99gpHFqQZ63iVZ7q+z/L8bpMJXpCyBRtiAjFZFKPHVnFouiKaIsbwo9C+xq4i8GlJY2c0lAw3FRUwxz+8bPiCDJWEPdKLW2p5O+8aCq/IaohJ9eQKrlCCpKsp0jiLnI1OBAQoK8kgoZhrxW8jz7/8YMktT1nmCFRf8CP66ixBwIz54ZWCxK+1yh9H7iCRE0qwmUF3hBtGj2t6AuJN5ab7Zime8zh4KRN47Pk8cBfBJKVViPE97qXSfAglWwW7ewFbTvqn+FhB7bYEtNwwkWxU4D0yhTAJDdPLF847ydOupCQx025EfXYnFL/UIeGGOigyY4IskYdbpAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNgux2vyY9cGPCES36Zsg4B9DCpjTFdOK1wx+ch4QAY=;
 b=LpsCvYqKp6Oy+FXM/G+JQ6FpZ9ODuIyBGRXKbxNB/L1NDhIJ1OLbEDmsuci1cmbNb/zvqHSB6vH939yE1B3DfyK0M1BoEK7xF1zhXiPa71IF1qMiRdHjIwb1xPKt4GL8w4UcYEY+oiMRRP4uXkzEecz44kgkgV5IJrYWkCG4KSPr46TS87QWaG4FzQrls5ArVu2ThPQVHeYMJ3aDyx1f6spQGYffIYEghoQ6IMaHEYA/LNPYEevF4sPTPKWEmhtq9EYOql10InUI+FR1MkQCZM6kwSPtlLns5yVJRsCry0OqPHqDU23YaLVZvWydPfwwdvSBEtQIOzEjiYZFYWsLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNgux2vyY9cGPCES36Zsg4B9DCpjTFdOK1wx+ch4QAY=;
 b=aOyvLRqIRulbIOOD6RGuzUkPJnO1dSOdv6Had33y+az3KYTyiL0rO1dWQPor4pI7f/Q899kv2mZz+luQEwO4mzCSIjg/PiojFAqPnCIMQYxw0BkOexM1GumhhCid7KncdYr1lkJH5fm0iy5pBwz+XacV1Zy8ztKRcZ+7qmgXves=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 14 Sep
 2020 12:46:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 12:46:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 1/4] block: use test_and_{clear|test}_bit to set/clear
 QUEUE_FLAG_QUIESCED
Thread-Topic: [PATCH V6 1/4] block: use test_and_{clear|test}_bit to set/clear
 QUEUE_FLAG_QUIESCED
Thread-Index: AQHWijwBqkVLvY17rkqdbCndFE5Bgg==
Date:   Mon, 14 Sep 2020 12:46:27 +0000
Message-ID: <SN4PR0401MB3598AB9B149DD7457A0D01069B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200914020827.337615-1-ming.lei@redhat.com>
 <20200914020827.337615-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0ef7845-6c8a-40ed-526e-08d858ac323b
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB359705E1DED35FED5C96CC7A9B230@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuALd9yXjHvIqAYyJpse+CgaOwl9prZwJTvkQ6FV2ARJJhnwYW7niPW8NvstRq9yyIedC+ySDXCI2b2x1lN40UdbH+5TxMqCUPCFu9o0uoxNOoDPcx0DPAQfeOgpMohaOvEnaA3WybmJBOnLKjxom5kzLrmT9gxHd7jjUDIOdwOT3iDF1wEPUMUv4SdbhPqvwB6EuOYJy1/RBiaxTtQcgkB/TnCc4FK9HEUofV3fp7GE9zIxfvf2K1D8oS/p6ejljZpj9QAxalEUNSJrlU4hHnIqRZRPo/fIwjMch8QEG+NOog85r+DQv6pBTj1h09dxXovE82PTsA3chhdIrzen8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(66946007)(4744005)(508600001)(316002)(54906003)(55016002)(91956017)(66476007)(33656002)(66556008)(110136005)(83380400001)(66446008)(64756008)(52536014)(76116006)(8676002)(53546011)(8936002)(9686003)(71200400001)(186003)(86362001)(2906002)(6506007)(7416002)(5660300002)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6x7JAcaF2t3ZUvdpxdM8G052P4btVnkQ0ZPSXSKPOdFmKcmGVlTV/7b4uBY9eQYrPU2jE83qG8DylcOhwG4J5V7r2gOfyn1M/bbf/eHjboGloYatLWxNR+6YxzeZU89s4EicDp2x/qqoNQpJetu5TaXqDxMVr6F2HqhS35tTe7S4NAhclnSPepjKuIwDq2tX0+rR6CbCPNa/TQ1KyRCFcBLQM4GcY1qwACeNNY6wigUi0szE50IVlSUaLvYTRn3LeKFsX2t+qUTa0zdZnPXjQuAhAJzbcyN+vfUrKIDukdrWHgdM3xWLUHiWjRfW8IL28HExLP/rjSWQvw4nYIdJqEl0u7ZTTvlJ1dS0DJO8Fk8LVxFw8CgyL6Ruv1hJyg6rULTZwjkTzWG+3Rat0D5bI+hSzqHII2oYOMGNquh27Zgv/wMfESdgCPH9AbT3nRlsVxUkfu74sTFefwYYMpJehVMGxWkm9wfgx3Kuia/Gf6pxFznlTDTyvIUBndujp5gFmOynapiDq42bO65yjt+dh8b0atOxJMIp8tcnUwGxhDtYbHG8iKfXftar+8IpZ4HHz0Pu6C6MGcIH/4GopjCxL2Pf1OcePn3KdM9VUvP9KPBaDSyTZNWNswqcTIA1VYltgGuT9Lo2yapfVIilh2+m4ezCTzKBEAN065nV1mosFwsm7lqmA09MRi0ioClyzqLGw9p7erd+LZN0OyVe81/WHA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ef7845-6c8a-40ed-526e-08d858ac323b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 12:46:27.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vziZmp49fyZIDZrZ5C9MjpH8q8ST/aTHLG+e1IB7x2BpAGswzCv9h+UzCviKL46ZYx3RSZaTEw8P/VMLZ8cLTQUZ3G0twg3l1HKmzMxfcNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/09/2020 04:08, Ming Lei wrote:=0A=
>  void blk_mq_unquiesce_queue(struct request_queue *q)=0A=
>  {=0A=
> -	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);=0A=
> +	blk_queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q);=0A=
=0A=
I don't really understand that change, why do we need the =0A=
_test_and_clear version if we don't care about the result?=0A=
=0A=
