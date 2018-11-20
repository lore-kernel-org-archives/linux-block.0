Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC25C43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 23:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CA920878
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 23:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NVCY64Nt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="msP5XEkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CA920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKUKaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:30:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64399 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKUKaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 05:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542758293; x=1574294293;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jUEXQNm8ljhWmraFHVFFm+KbE+twJVTB+h+tGqlizsM=;
  b=NVCY64NtddNK2ZZmz7Eg9nyQqpz7Ln9EX2nA0h3/GFiZlwdbRsUskEE1
   Stk+M8FDWwo0kC69I6CgKrqsk9KoQiDRdZ6dHLHjeqAgpjx3VLDjd6Xr5
   OvdchMCvkUA8/S1DUj5yhmlru9lWZR0cXU368cUobiqfaKr/WGhqx0x2s
   97tW7MuyQvElkNO7j9hFpibZl2MPhe0qIG2142hu74Kcy1LA7KMUJeCUV
   mJkMvwSFVvyFRO+/0xZIGNtLqrjfVTCoBjgucb2mAhk8vD4hreIBCikY+
   nOJC/erYbzI0G96P09yFTyoWdTODwgsvS6g/anQ6PiyDrUE3Dx6C8ve+b
   g==;
X-IronPort-AV: E=Sophos;i="5.56,259,1539619200"; 
   d="scan'208";a="99555371"
Received: from mail-cys01nam02lp0055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.55])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 07:58:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi/WmLHhukGE9oU5pN+R2aaO1FbLLlnJkLRF/yz4IXI=;
 b=msP5XEkhvyTE8Oc5sR52aqXKo/0dFgRMY0VXYs2e+81Jtfu9rIcsX8TIWZCvLDc40y6WGkEAOvz+RvJzygI8oHV85QY9RKWT3g6U1sj8zeG2tut16sjIi4Ey3nkgkJlDlo1obQedkpExKNR0XYt2nDdRqxaS7aEfTR+xF03Wa1E=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1411.namprd04.prod.outlook.com (10.161.210.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 23:58:09 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 23:58:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Topic: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Index: AQHUf7tEoRMSe3tInEucKAoqKOcuBg==
Date:   Tue, 20 Nov 2018 23:58:09 +0000
Message-ID: <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1411;6:knnw8zureRcNlZ/zBXDHEhkYfjc4Ap7ssl2p6EppziXaGafIhRoEdEn3uHcnwQ/ku/xvI8Jc25SkPmvIFnamJkVgKcCZ0WJit35ZYVyE1uSCg9ajT4cKmDw96VBPniOE7A7gRmK7cpIZZXJM2ZST/NUwwL4QlFpL3nl25EbA8wdN779FzXSCH2FlMm47U51aAEZMy2bsV4E9SF8BV8h5oJXEKLI3UNgGXAhG5NF4By0RfswsMhl4QWFIKz9Ha4/c/3iCVAdaVZwjMxaJl+0gGfzrXKlJdNxs1/50bWr4D3tMwCQZ7rWCp8xLtwc29kjcZjnrFmmscopGqi+d1bIBAoqZmQd4iNbAncbPDm1PzG5CeKvtx0ZQJ14hGAyGEda5GLE1Sa8ynus4vYysmbMVUgjnBATPQBp6p1OSXyRR7LludlsuMlbLsdbV2pvmV5P1jtoVnoyKEVkyT2aL2tWIBg==;5:Jqezu77xmCjpHUlTn7BvSFC8VA0I0pRAh5ContEkyleVAhz2zuCJZmeYTCzJnhINacFWwVT7RiKRtq0JZp5RowCHhUarEMvECdShByAqID/tN6ViEMWWhcHX+k9iJNcdlMUtSqWfxEDSX5jA05NDCxHId8sOgW5wTtHQv/GLawg=;7:cRc1LHFKA5docsSiTWSFmr8pphZehumPelDbIdDxuBMNoxRGkCPBMlRZcqx1gsIYM9oa53PcZUm0lMdCsEtdfSdYk6pJYhq8kAPqFWzPoNiiBgei6MpP4by4PNq760I54mG27+fbdcGx5RNPg9JTLA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a6188902-9605-441c-1ced-08d64f4405bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1411;
x-ms-traffictypediagnostic: BN3PR0401MB1411:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1411E4E4E212726E2E2567B6E7D90@BN3PR0401MB1411.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1411;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1411;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(5660300001)(71200400001)(305945005)(74316002)(66066001)(71190400001)(478600001)(2906002)(3846002)(6116002)(72206003)(186003)(105586002)(26005)(53546011)(6506007)(229853002)(7736002)(97736004)(8936002)(25786009)(102836004)(6436002)(33656002)(81156014)(2900100001)(76176011)(8676002)(81166006)(93886005)(14454004)(99286004)(7696005)(6246003)(486006)(256004)(316002)(9686003)(4326008)(54906003)(110136005)(68736007)(106356001)(446003)(53936002)(476003)(86362001)(55016002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1411;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iRH+sNZKCWfFszRuo2KW3SxU3OSe5Qo6atvU6+u2t8oBTKEKfLyWq/N8G0EMFdEXSrGMhpBPpwJFsaTVlBO5mfH1PDdVMl8duusjPIBe4EvnAENGx39xLBoQO4HpjAzXkMuMUY8eXvPxpoH/4x9sqvOyyYGHS0RmYDKpuxonOtCkAxKY9l4qsxouYjO9JITslXp7pFwyOx07SAbivKpL0Wcal+qtP/XtqP859HWrn6OjrigqQ3T82ufgLJTIGXebnIEecrS58jyBD/diOrsc2ADD3ndQHe5f9wNcnvzrbD3Wy/AiPPLDU/XCcSIRszrIyiFHcwz7SqD2Yb89/rZOH3AI6JgJ9zPjF4BaVHlXGGk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6188902-9605-441c-1ced-08d64f4405bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 23:58:09.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1411
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/21 2:31, Jens Axboe wrote:=0A=
> I think the below should fix it, we haven't necessarily setup an=0A=
> ioc if we're just doing as passthrough request.=0A=
> =0A=
> =0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index 13b8dc332541..f096d8989773 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -34,9 +34,16 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);=0A=
>  void blk_mq_sched_assign_ioc(struct request *rq)=0A=
>  {=0A=
>  	struct request_queue *q =3D rq->q;=0A=
> -	struct io_context *ioc =3D current->io_context;=0A=
> +	struct io_context *ioc;=0A=
>  	struct io_cq *icq;=0A=
>  =0A=
> +	/*=0A=
> +	 * May not have an IO context if it's a passthrough request=0A=
> +	 */=0A=
> +	ioc =3D current->io_context;=0A=
> +	if (!ioc)=0A=
> +		return;=0A=
> +=0A=
>  	spin_lock_irq(&q->queue_lock);=0A=
>  	icq =3D ioc_lookup_icq(ioc, q);=0A=
>  	spin_unlock_irq(&q->queue_lock);=0A=
=0A=
This seems reasonable to me, but I wonder why this problem was not triggeri=
ng=0A=
before. The previous code getting the ioc with the rq_ioc(bio) call was=0A=
essentially the same and there was no "if (!ioc) return;" in=0A=
blk_mq_sched_assign_ioc() before the patch.=0A=
Any idea why this is popping up now ?=0A=
=0A=
Ming,=0A=
=0A=
Is this a new test your are running ? If this same problem triggers on stab=
le=0A=
kernels, Jens patch needs to go to stable too.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
