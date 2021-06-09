Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C9C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 07:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA0761002
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 07:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhFIHNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:13:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20176 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhFIHNp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 03:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623222712; x=1654758712;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QVJsTSdmEB7gA013czesGL+v0YGnINVB0dV9aRZBOqU=;
  b=ayHUXnwdpPpG2y+qw9Ju+u3sx21EVMxxeZZofYvLiTewlegogbx6uT5W
   b/jkpbnLk2dbXdtf+n34c+uz/CS1FUMK8Bfe2Ls+/XaaE/DyWpeH6XvQe
   2Z2Sjxh7c76hBA8YceV1+5kMtp3vxe3nuqBgHMHNCuJb5JoB7QJog1Fdw
   fApzMS0I8lKElf7i/+QX0kzhSiMftR05TvIHlxxZbFNvYJWJLtqV1TlYq
   vXQQnS9S+TDIMvTU54HM9omc8SFrEtGWONGpMTgM3CiDza8+WSXXsKhFx
   vpvOcVaRMmwE/GAydrmhL4K4CyAN55jBrTh3c4Fs1gCvwvUln5o22pFJ0
   Q==;
IronPort-SDR: FnVhblJoDP3blOF5/iLqY+F3w61Znv58qO7xjjEZA5CJSJIIPoDFxCFsuZyAY9XHvTU4Y0+t/u
 kpDahGvIdX3hb2TMUsb7X55HBnhhNdaMw7moCZwkiAXC6+sOvjPOq/pf5uhQbryyBBeULl7Qdm
 aHBbrdVOEcad33Q1S8sN7gvHpauZxcoUf4dqO5SJPkKGgGXahYwBKmEma42N1bmPeBzoUyqBtH
 AvzGrUGYRaB2tvdXETuxhGdBYaK5aUIHr8jPDOeJ0mp3Yomgh0pJfzvCf02LSKd+YJxeLPTTA4
 u8I=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="171818213"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 15:11:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLXLjd1YBjNxD9Jz+6Sth5PF8mryed8OwwBTFNEWbPAR1i3/Mx0O1v4zLWvoYaR571qTXrSwvkuFN+MPzvqBN5O25ACWBgYnql5W98zPxZooh94gDOEEh8PFKW8amfVJzMt9858AZelEh6mkH6ULNuK9TBh8ePy2EdDc26SazFp9PzSTXBNOalqKPJ/KhahyMxYcHOWmV2oi2HCFGBd3/BGGGoGL1DlTdqD2dActOevlS+4dvTPrRooXI/L4ou0tGEc0RVryzxR81Fv7TQNBio//IBVNJ0AjwlhXgcfvN6Pr22h+s+0DXTpaeJasj1TH7V2YcBgqB4+gCYXKM0bxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDy7SfF56bn77EvjJl8PThDAKAtxuy7RE2Xs5CHIHS0=;
 b=Rmm7kNq/oQLtj053gOmg36ItlYS5jmVog2qX5JeGqvNR+q5r4HeHkHuA7yS0hHnnm5QWBwH6bblBOfqkTGZu6rLJeU/0cpImejKZcuWaJC/fwmueU+rd26z7v/AAvNNCJyxOJSNbDxvf3tvKhPeYH/BKOTFvGGikKsfFNebXHVIuE8FKwh5bmFKmlWhhzOlkFB0aS3gc/PDh9RaFSDQu/bmtrZIvTvK7lpOIEgjhVj3GKWT08du0wMprGTH2W4fWNUqVAmNbx7elugb1dXdnkRvSh2FZxHJu1adqXJTRtMC4ArRQD4tgsB/+SWSBPcW8wDepE4J9LA738Yn6tspGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDy7SfF56bn77EvjJl8PThDAKAtxuy7RE2Xs5CHIHS0=;
 b=NqZGOvCftmee0bAlQuE/6cZt26oTT+sOxS5JhzccRXgIVaqqZExnLnfz4RnEI6IjHFN+Gt3NrOBdKUt1qKasxmDKZ4PlF/v/nmPUAo+9yjpmn0fZ0IeiiVd1ipp8romKE6XQvN4Vn5/w0mLkILlTQR/7xcM4PsAmlTWDDjIs0AU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7349.namprd04.prod.outlook.com (2603:10b6:510:c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 07:11:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:11:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store
 macros
Thread-Topic: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and
 store macros
Thread-Index: AQHXXLsU815IwYZWdUSCfnXX6T62GA==
Date:   Wed, 9 Jun 2021 07:11:47 +0000
Message-ID: <PH0PR04MB74169450017D5A976BA91E1E9B369@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-11-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:2906:41b5:83cd:3a40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 662a28db-8dc3-46e5-dea1-08d92b15d853
x-ms-traffictypediagnostic: PH0PR04MB7349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73495EC4377C4BD9EE99999C9B369@PH0PR04MB7349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKTrjTo8qALLpWkIVyf/PZ+jxkRK4BjwVXAfqzARnHisMSkTYdo3UjRAnk6+ecj6tJ3yMy74iajCRKh7nnBc1k+j0Drn4msjn9MQ0hJauV1HfqeqNGhYPNKHpyP4iscCTlOi+pZwx/8+AI3SigwUkmU1/JSypr1DMIdIkgN3IUOR7H3pXMAGx7+HVtY+OYZLoM96oZwxmwTK6y8/fJYbPQ0Ffh/ehkTaJT1Z4ccz05/NUR7JElQhpz7Jp4y0Y+l++LdwwyiVT/GITc4IvAh4AKSVUTshPYLndpRd9mVM94NB4YAQz0FBxzPE5doQx8xstHMX2VGBX7YYVVtoan59Or5Odxb5Q6WILfcKmT/C/EFf3gqitIv4tC/VIKp7kvNQ6Sp7FEuz37TGYs7H5279AmXe0HsnzEzfLVEB/9sZqjsZe02O9C8gMNonCyLEHP00Rtdbv3y3Fe3Fq5p55XTJKJq8g2y+QhjZUQaHHqivIKvaTj7ESYEh1s5j9Kv7ce/MrHkVVQ8KnpdWJuJrG16qGmICbx5QvP26/Cw9WSAqrM+IW//B4WXgPm8GPQMAucMfYwt4PgeEfuDcQ8DL8o6sMLSpcqf1i1ZPp5HHIrL7/ew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(2906002)(6506007)(5660300002)(478600001)(8676002)(4744005)(7696005)(186003)(86362001)(53546011)(83380400001)(52536014)(110136005)(9686003)(91956017)(4326008)(38100700002)(76116006)(55016002)(54906003)(316002)(8936002)(66556008)(64756008)(33656002)(66476007)(71200400001)(66946007)(66446008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NlAMYy8Z18VTFaXL8ACSy899Vp5uw5TlJAtEeLhlvqhnX2EO3Iqm4OmBhNkf?=
 =?us-ascii?Q?UHOThe/K4JANFdchRZnZedyOy31HhLUTszUVrQfv8xIYOOIN1SHw+l3bATXb?=
 =?us-ascii?Q?7RRLb1RwhUuzffsMCVcJbLx/DhN69kUR9C2amw2zuTuFVlUhPGBQpahWwI6J?=
 =?us-ascii?Q?HWg4CbB+rhVLladfLgDduvxFbn8uAH4nhxjww+nHDnPWFsi+MiLst1GnYyHA?=
 =?us-ascii?Q?9rGczUVNg+BiSsA9j6h61ffFjDVnbuwmcrHeoWKPA/Cl46xVgAAuSreMg/hd?=
 =?us-ascii?Q?o+l4VmiQYL4hEtBklFTLkkrs8SoFw7+aiIO2NsG+Ep1UiLs3Pc4WmMD/bXri?=
 =?us-ascii?Q?HQRBPxwrLYer398Ial85MLxppMAuqqgw4tweyJ7C2kTaOkZL0mrF0md+Bzbh?=
 =?us-ascii?Q?VqMW//SQ3xl+MKFmzvZYySy6Ttnyawnvu+ghtVzyN4uGdxkEW8NlQSiFrO4f?=
 =?us-ascii?Q?8DtFcF0YmjmgVxTX1GVSsm3N8ogmdfX6sZogc553wjYV48/7/lUHf4HGZ3Z9?=
 =?us-ascii?Q?RHGIBu+fBPQx4EOb+9uERccTM/yZO+OVAc4xBSnihmP75hSXkf36GUmKTiWM?=
 =?us-ascii?Q?czXP1t38eg2TNh+YLE6L+jhmVUdf8lCJa4U8Aus6Ngn40Ciy4XK/bEm3iQjK?=
 =?us-ascii?Q?Z347GfAb3v2I/tbT2SpUWYb7yZ2pBqmGbr7+rvMq0Rq1lcJhaJaVoieoY2ov?=
 =?us-ascii?Q?uQFvzXv0EmvCpokwBDm1//YymmkMESxQSk+WaYdDljyYJlupmTm/TuUwund9?=
 =?us-ascii?Q?SgH/s4SxfvbHLMInRmpBvv3vH1oo1djKfG/HaLTkG7IPy/+Ln/E3MtOncB3x?=
 =?us-ascii?Q?X+PBevtL6F/myDTXcnVv1OSNIChGD4B4zYhNf4V4v2+JpBblWp6Wv5D8vFkN?=
 =?us-ascii?Q?yO9eqqHfwrT1Z+ZzE0RJMS7Q0ItzjLdxPtqz9tbfjWXmSE3YOoP1daZD6giy?=
 =?us-ascii?Q?3khui4U+4xVCWtwLLNsBNKpG3PUQCKfZ7nAxTKYH9L6v8ZOlB0TaFlGQXAne?=
 =?us-ascii?Q?PWczWI01ci8+8MbbLOejdzoSkEt8eVG5uFMg+DPYgW3/LPGtm9vZKXqqAgd9?=
 =?us-ascii?Q?k16ueG/31K2NovXx4KUywMbVFDwZQjidcprdeYRh5LU4CCB27uOC0ABrVwVd?=
 =?us-ascii?Q?qgwdIQZbg+sEGUF0nRr/gl5dfpTHRvhbFL4WqNfCXDf62gWNbqaRcau3VMSr?=
 =?us-ascii?Q?MBQZWfBjXU/tEeyz7zbKPHqMnaB9UWNFo/9mQzP3eI7n2/QoyGMsNVE/i1v/?=
 =?us-ascii?Q?+IYCuKGOLJfxqB8dJC15AWcCQ2wZiV+AZyRrx3gekmf1P5Smz/sEtg7waSdv?=
 =?us-ascii?Q?Js+4nq4bRuqsrVYhAX5jBOumL75bTt01v9kI6jaoPnlWPC5hKTrBlqKMA9OH?=
 =?us-ascii?Q?lsm4fAf0wTvjrGNlR8GO+93o5EqhHACHTeQVMs0JJF7XUzr2lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662a28db-8dc3-46e5-dea1-08d92b15d853
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 07:11:47.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DORSrAon4Y4L+P6rrDl08uMb+P23s4XV7NFRHqBLVNMPHdvRNaoqUuQgj2iv8jtSWYWo+h+fQMr/cgBOke9xLBMg/y6wxhPymBiW1utcILo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/06/2021 01:07, Bart Van Assche wrote:=0A=
> +#define SHOW_INT(__FUNC, __VAR)						\=0A=
>  static ssize_t __FUNC(struct elevator_queue *e, char *page)		\=0A=
>  {									\=0A=
>  	struct deadline_data *dd =3D e->elevator_data;			\=0A=
> -	int __data =3D __VAR;						\=0A=
> -	if (__CONV)							\=0A=
> -		__data =3D jiffies_to_msecs(__data);			\=0A=
> -	return deadline_var_show(__data, (page));			\=0A=
> -}=0A=
> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);=
=0A=
> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);=
=0A=
> -SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);=0A=
> -SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);=0A=
> -SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);=0A=
> -#undef SHOW_FUNCTION=0A=
> +									\=0A=
> +	return sysfs_emit((page), "%d\n", __VAR);			\=0A=
> +}=0A=
=0A=
Nit: the () around page aren't needed=0A=
