Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0588FC35671
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6D22082F
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H4zPmmED";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EAveXHQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXLac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:30:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23882 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXLac (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 06:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582543832; x=1614079832;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p1JjaQTGTwGfrKTEPEapbbeLiqUJrU+odoHsNNybmZo=;
  b=H4zPmmED2s/ow5YLqIxcwXycNvfEIqqLSMu/7xQsodKx/gTFd+lKLhWM
   /vbvPs6R5gL1EA4fnJ/EuET72thMm8Vwb/+qH8DRhfYlsDDWEu3VvwvKG
   sbhO1iu7TbZuotLVskUNAEzRhaKmgeuiTT+SFPcywLQe/G7dvXdmSmLqf
   ogtDUY2YY5wAqaE1q+JqCR46wvmR7spal0dEfpM1hIBCivuC3r5bBV2ff
   kyxYwce3fiUeE0Mwd1sAoOn9Rmv2Kdpx2jTY7z2mggw1E4VWPsn8XnIK/
   R8dV+ProX2umBfB/oc1AgOv9dLCejY2Qt6C3I+vAlxOJQa0Na981QH5GY
   w==;
IronPort-SDR: 6kjtteUTZguaRFaO/+X+wOqj5m68EJpWuTIjJDFbND5KJJ836vTMGfKZVHNRfg+pvq9zZRN51g
 oGFMz/jD5qawIT/tGriIO8dTZfBpbs2UJJNri9VVzqvn25PjqtMKb+RWrjYBFiM6S0XxYGnJK9
 GKyxuBhQF1jRGswbexfnZfTzshgDN/iiwzTcg+Yz3npuVdAMS3HEym9PiT/DQzXW169gW6xXTO
 PyjQKUxGF3auTXp/BvlLOF3cud2qhJuqZa9PsFKNrDuv36G4bFdOwZyPeGDG158aKjcCpeGfl9
 9us=
X-IronPort-AV: E=Sophos;i="5.70,480,1574092800"; 
   d="scan'208";a="132020045"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 19:30:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvy4ReHSiWsl/yEZvPAD6+wyA65JmWQh60zHyMqe0snnuOvq4xBW4kCgt6A8SdkOGbbWXBKSRYp76+kgc5AqNvz2oPYKi/beSVBjYbLu2V6+itPWNLxgJL9S/DlNpqAQjzEU9lZpqN+0hsHGtO2YBWHbVD0drm8bVIMCpaZuYV3GNT6FJp9wVu/i09Jy7ADYqJi+66Dzo0jJ99MyDoGMKbWOv86SCEbHKrud5iS0uvKZyCTuK8jsZbY+Sd1TsLJqnj2jzfnX3sil42szZqBsSBM1bkDPpM7sGcDmcHZYuiYAjUHn+gEEbaeDA66kPYV+tbOkDqjbRoqbNpuAS0wbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1JjaQTGTwGfrKTEPEapbbeLiqUJrU+odoHsNNybmZo=;
 b=jrEnDnuKHOrMtEXNd+3FTfmV0AXTSv4ejaf6ADm8r56et07A5x42+gLjNV0Rpzwju/4Tw9tISCBU6lUR+OsfHM063kwxGk06VDyGr+BpO3hCk2jUpQqae4Y5B60pwsWgr6Rg4uaM3c8FzD4GYlYsmH3iUUoPoFgVA99n0EBc6IpyGK1yXwllpitcPwobr9Z+R0ycUbhwx6fwcEC444eNdQ6VZ9a0Zqh62PPdXcnOy7DF+jB4FsAqYs1n+ZEXKGVabq3GD0OTuobhqxsOvcREU3rvt5/msmg/CyDn5AUbh9RJfokCBAh4Gs+/1vRlyenLiZpljbVUPOGJTXNqs9qU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1JjaQTGTwGfrKTEPEapbbeLiqUJrU+odoHsNNybmZo=;
 b=EAveXHQ3pAlZRAoUQBB/5AScscCSt0sGRg7Itfuza01RbAxJUKhFEv4cxjpbRR3SV+WhkOsn9hN2/2PH30eT5ffgf1unuSeT67HBcoOyxVQQy2UogTtcS8GRht3+3VXtrMdZ5sMeY92Misbjb4CsTjdqoRR04anPeCLJGcOR8yQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4632.namprd04.prod.outlook.com (2603:10b6:a03:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:30:30 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:30:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v3 6/8] null_blk: Fix the null_add_dev() error path
Thread-Topic: [PATCH v3 6/8] null_blk: Fix the null_add_dev() error path
Thread-Index: AQHV6GY9ossTX0P3kUyPBAcYPO412g==
Date:   Mon, 24 Feb 2020 11:30:29 +0000
Message-ID: <BYAPR04MB574924E9B2A8BBB1CB3F986086EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6174dad8-a183-4e8a-6a02-08d7b91cf407
x-ms-traffictypediagnostic: BYAPR04MB4632:
x-microsoft-antispam-prvs: <BYAPR04MB4632BADA2E2CB3D363D2D4DB86EC0@BYAPR04MB4632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(86362001)(55016002)(4326008)(66556008)(66446008)(66946007)(64756008)(4744005)(5660300002)(54906003)(110136005)(316002)(66476007)(2906002)(9686003)(76116006)(52536014)(186003)(478600001)(33656002)(81156014)(8676002)(81166006)(71200400001)(8936002)(6506007)(53546011)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4632;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+J1DtwKaIPcto4TgTTAn6yZ87K9k64eiYWkE2ObxMChHi4e5UB3+TqUwqY3he+ZbCWiMgX3merYOT1vDWpgKex9UWiReFkE3WRxv883O8SU1ORx2gLF2IGeTfQGcTuktP/uhj4sH/WsCcXLp3JxuHiJab5kIXDbb+aHDZANO5/w9oDe1iAL0eD1QZjglSh6xUd7YCQ/O3alYm6aoNBA3KmrZYEhVdPdAVgqNcpcdSI7QKAZ3DD3093VIHxWqUE+UlyIHYy1xg6M5aGFCL6Bk6TPQ03g7MoFZUKX7C0fRPCmDnOgqddRoG4hEsT1moXhoenIQsCXph4eYv2tFZ7W41qRdBKKdtU6GBuORnTbcFe3YRmSMmPVSQFspPadRO81ytS5CFgKZh7gaEBZ0uoglurplDaL3YMhh+0fRjiiH7KywpJfMGxybpFU10ph+WDu
x-ms-exchange-antispam-messagedata: 8nf6YVoD3xzh0rwirtuwJlqtjZ0W5RRmnuESA7EG9AIpSf/8dTq+iFNLJWIRta4Zk7OO2QfQ70ehneebcOGYgFqLy5hQzF0PZcweGy2NgFiXD7a49OIcx7P6S/sdfYvlGLQpTBCwyR0w9aWPmYSffA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6174dad8-a183-4e8a-6a02-08d7b91cf407
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:30:29.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16EgxkfTNaQNxxrx4bTEK5qlRpRwGhXXwRZEpz5QEkyi+rP/99pFghLp8nFZ+ydO+953fH0P+VSver0PCft9Ui4vN1A/HL0urpthr2JTXpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4632
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/20 7:23 PM, Bart Van Assche wrote:=0A=
> If null_add_dev() fails, clear dev->nullb.=0A=
>=0A=
> This patch fixes the following KASAN complaint:=0A=
>=0A=
> BUG: KASAN: use-after-free in nullb_device_submit_queues_store+0xcf/0x160=
 [null_blk]=0A=
> Read of size 8 at addr ffff88803280fc30 by task check/8409=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
