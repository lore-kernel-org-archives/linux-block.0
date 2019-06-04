Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F6BC04AB5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 00:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107CC264C0
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 00:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QTEfm47L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UiPukwMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFDAon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:44:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23158 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFDAon (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 20:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559609082; x=1591145082;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FX+envACwwSfhA4ulNnXy5ouVfPefR4+w2kzHeM6huM=;
  b=QTEfm47LSAdW0fa9Bzg9fb69SDX86ZfEjZX0Tw6hnoDYARnkUKI3f2Ms
   1znWIaQnceYSi5B1LM5JTsS78W80RvQZ7ivsMJlLwGUdrMsCUGrb9Cd3l
   XSUsGQTY56t/dIFQID1V32zn4QBeTx+VhPglbNOL6dQFTiJFZB9skj+lf
   p2pbsq0tHD7PPAAEuWqiEsZFFlMn9B48XCXYm3/Skiuz1ThiJ14B0NKL/
   KSNaGeshf9ZPaO1G/EclD6xzB6I5AV4ghwbzLSVzIT+r0/PBwrsVVqcIs
   7j2IfY0LNK+gI9lGaUQ9HX54a07TVuv+AJukoZl/h5Fmpu0Mx0HxaMfTv
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,548,1549900800"; 
   d="scan'208";a="111387411"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2019 08:44:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB+6DicZE7UPiDGKHe7ASGyWXbEVTA4vPM7E08DTnqM=;
 b=UiPukwMV12ZnrHcz2Z8vIAn2oPkcXXhriBhvZGS7023ozuzSt9Jt/7PNK8MJ1jhPMg2Xk6bJf8dyfetqDQpSVumeJD0rcsEB+bPhwShKhheTZkNq/BrGf7sSLdPbrTfDGBDe64SmRvd9GHbF7R26HPWttcZDAEJNVKjEs5/5wT0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5781.namprd04.prod.outlook.com (20.179.58.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Tue, 4 Jun 2019 00:44:40 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 00:44:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] MAINTAINERS: Hand over skd maintainership
Thread-Topic: [PATCH] MAINTAINERS: Hand over skd maintainership
Thread-Index: AQHVGmW7ENLLb4S1EkGmmDTi+8cXMg==
Date:   Tue, 4 Jun 2019 00:44:40 +0000
Message-ID: <BYAPR04MB581625378481F602D303FD63E7150@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190603234019.107514-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fff72269-ab14-4d2c-b505-08d6e885d43e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5781;
x-ms-traffictypediagnostic: BYAPR04MB5781:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB578194221559AC960168857AE7150@BYAPR04MB5781.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(86362001)(2906002)(14454004)(478600001)(26005)(73956011)(72206003)(3846002)(6116002)(76176011)(66476007)(64756008)(66556008)(66946007)(76116006)(256004)(4744005)(91956017)(9686003)(66066001)(110136005)(54906003)(66446008)(53936002)(316002)(305945005)(55016002)(186003)(7696005)(25786009)(52536014)(6436002)(14444005)(229853002)(68736007)(74316002)(71200400001)(71190400001)(99286004)(102836004)(53546011)(6506007)(8936002)(8676002)(81156014)(81166006)(476003)(6246003)(486006)(33656002)(446003)(7736002)(5660300002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5781;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mM/hjfTMLLw7MJoHdLjTdRW4lz1H2p8eYbbQ1KOLfP9ELlp8Z2qqhMCxZLs4W7mpSvtOGqwmaaudS9XlYkkJZkcJYW8/NwZYyEN9n7nruqNc8N/9RZXDU/0m8ZU2Ti2OzrXJaO5VTmGNCFLWbkVGEzLFS2doKmoYHOyrpZVMK2RQ+Mg2bJHHHSlFZOeAlrZfEDtwqBQH8VLtJM/R1BbhgyKwy3Lydzum1lUDrqSUkxSyTQBFozbLI8k//ru1M5+pPk20Y45mLnD/HKOaPtTdQMwJcMjjAh1bFbRF9CSgBPo0If4NTYPeBeNa5xMPvXg+26YCxQWeJHysb8QY29T6NHteeDPUMqUfcxD8agWg9C2eTW3v9V+kDqJpsBdwl5ctjWboRciKGBcl9zxKTZ9TMbIiFCFbowak8unNyKD9rB4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff72269-ab14-4d2c-b505-08d6e885d43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 00:44:40.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5781
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/04 8:40, Bart Van Assche wrote:=0A=
> Since I do no longer have access to any STEC SSDs, hand over=0A=
> maintainership of the skd driver to Damien who still has access to=0A=
> STEC SSDs.=0A=
> =0A=
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>=0A=
> Cc: Bart Van Assche <bart.vanassche@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Cc: Hannes Reinecke <hare@suse.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  MAINTAINERS | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
> index fac3f405e7c0..2bdc4acb22ec 100644=0A=
> --- a/MAINTAINERS=0A=
> +++ b/MAINTAINERS=0A=
> @@ -14979,7 +14979,7 @@ S:	Odd Fixes=0A=
>  F:	drivers/net/ethernet/adaptec/starfire*=0A=
>  =0A=
>  STEC S1220 SKD DRIVER=0A=
> -M:	Bart Van Assche <bart.vanassche@wdc.com>=0A=
> +M:	Damien Le Moal <Damien.LeMoal@wdc.com>=0A=
>  L:	linux-block@vger.kernel.org=0A=
>  S:	Maintained=0A=
>  F:	drivers/block/skd*[ch]=0A=
> =0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
