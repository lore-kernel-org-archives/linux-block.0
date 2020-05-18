Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D52C433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 03:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A59207F9
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 03:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oO5XsLsK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uc4dtYtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgERDMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 23:12:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16846 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERDMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 23:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589771538; x=1621307538;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=87KEmgnXXabIANyt47rPcFjvmwLu5FDU20HI9lK9h2Y=;
  b=oO5XsLsKvjqqifLWYs1lH1R+j/xH6KLAZ2qCo4FkIvermHLwAVh6KnE6
   HFiatddMmBXkeLMlDgMFMCY2/9N9E9bV3oOkViUfz+a1eoyaGHB27Xw+/
   Y6gqZe534tTJA8b0rjxc7+Dkc/7uVYSQBckA/2EV7K/SOQG4fco7a62IJ
   6Uww5ITV0QPrPdrnmSO7NHzLJ5WisMkQ5szUHcegWrMLGCleeUG2Cy1Yb
   CEPp9YxUntPM0WAAASPE+zohjlEjiFob8crwWiPFgwXpwFOXwwlXI4cU9
   mtZOvkKpJ3L5NYddWQwBNnKk4Vgq0PA4+auYVC6AwykjcShzsxq7ny98P
   w==;
IronPort-SDR: DiN6xjWMniX75Z6rsVq5nMVuq6h+blUh6p7mVxAkVtU0spfxcTVQgV7CjBNdojaugtHvhYg9r6
 VY6jDojoh/iOTsH/9TRWfTWmnayjWIp7nQJVhC88oMMW028h0xalnQYApwdiPkj5WyLRzpb5Yf
 ke1J3SAzXDkJbdszy/l/BxrMXbTu3v3z3vPpthu7c639cMCklmbK6SKSYtd+6c5Br3N5uOlQn0
 zAggd8+jGBB5/jXDRQFbRqRm+vfHEL8cL3yVaTIGPM65v8udlrBojwoQPM/snodbyJbuz9+pvv
 G0U=
X-IronPort-AV: E=Sophos;i="5.73,405,1583164800"; 
   d="scan'208";a="138243571"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 11:12:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma2/Gbx1xGPi5Riiijo36C/M5SLQQvxMdIoUVTaS3mXaJU/4Rm0tu9mvSAGV8SM2Tjg5kZzuQndRRrliUdRCBjzWfQFuwL08Jfrt36vOvdIg+Db6HCACss0YWa//12Zczp+i5Gvy/QEG79a2HpdFqb6XgV5mEGXiC1f2//h+c0PuGc07S9qcdy85XbvRHjUA4LloyAA7E7E3yEWQzOcFEbqAG2YRK+7VfcAMAEf6r/vu1B3aEQ60VUfccpKBE2ad0zZK6krCqyRDgXC0X2pqgIKAlKP6Hq66SJCfx2mjcSfdHcYV/JBIkH3tS1RahiyMYLw5yapyn6Ti6XWPYYjooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH3ULRGZs2RTtpnrYzp7LS7FAmVcw2W5/9Vpsv6J1UA=;
 b=e4t+jHe0yY8h6B51N3OSt5ggVF45zeEhp27L9UAeO24A7TYc6jesSt8zk3CEF0cDOd7Wts6ydOjJmSyOI4AqLVYKjTPEJhk1J1ukVuUYiPG1dvLGKfTp3AkxaIon+RF8QnqmzyhqNfmrhTGzXV9Jc//JzPG82b/5yIVaiHvIx5XfAR5f6VbcFGW4OppW9fHgPwdpQfG/qzjYzGQWcFnVVMJ2bzJi49Cbqn9QqMQfzHc/1EfEUBp1tHXzy8mKoKiaJBbIRhHw4EkMpzwsAGUKGI/E2/W2TbPuS2D275NDPLI8UXp/Vs4Beb9S/ol7A7KAIU17Vzk3GqjTSEPahCgZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH3ULRGZs2RTtpnrYzp7LS7FAmVcw2W5/9Vpsv6J1UA=;
 b=uc4dtYtDf+qyfZpTN+fmFLRVwSYzIV/I8KwGO+Cyi5Kc88JXxtK0OOc0OAhadVxal+B6cBRbYNLHMYHGbjswALd5/jBEGsdpgbUKQaWfe6NGlvi6NGSkG1NxRsXLZhIquPo65YpxyCoxLkUl2O/VsQX82EVHijuxSOecSVGmVR4=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6325.namprd04.prod.outlook.com (2603:10b6:a03:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Mon, 18 May
 2020 03:12:15 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 03:12:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
Thread-Topic: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
Thread-Index: AQHWKxeutW6PgxRL9Ea9BZV4XxYt6g==
Date:   Mon, 18 May 2020 03:12:15 +0000
Message-ID: <BY5PR04MB69008EEBF379E3E45CE972D5E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-6-bvanassche@acm.org>
 <BY5PR04MB69008A16B82CD028FC01D0A6E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <440743f4-1053-32f3-2edf-3eb0fdd057ef@acm.org>
 <BY5PR04MB690032A546EF80F2B823C984E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <45f9df39-a62e-4721-5bc8-ac9fa87b02ea@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39956bdb-e4be-4b73-c88b-08d7fad94411
x-ms-traffictypediagnostic: BY5PR04MB6325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB63250B734B6CC829B55B509CE7B80@BY5PR04MB6325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agWMKI8NoqCwrLcqm1A0n5rGRUC5Ku7k03Q4A2bV5+sr5p+l7Em0KWgzhJ7O0uk+hr1/DDSR3PE4aj8bKHHDafdlBMtb4HoL1sEU1xfe1FaicJa1/LiU1rQpeQ71KMJ2xaFmTvGDVl3781QJu/8cJYh1BYRuTEgzeIgF5QWmkskwEbAyCTlhppv1P6uvH73Vu0n/v3wdfpDwuF/PGCiyMI74eTxwW4NPr2AzlzAWAiWQHnU2TT/mLOE+2a7SoRldpj+aZj7KT0dL6rA8ypUQn0icuezB2c04Cn62+P3tMtbWUhcnK/K3dwdCf7rfB2MIfoUBmysKKu40veEtntqaqlW5x6G6pmXe7t5PgSzLKPyLfOlr8N6kYQwIlvcHmYFhysB79l8VguA0N1KemLM2infec7Qm8x6c4SE9sJYnLDpCDyIpdYk8WwKqUAwHv22g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(66946007)(76116006)(26005)(66476007)(6506007)(186003)(53546011)(64756008)(66556008)(66446008)(5660300002)(4326008)(478600001)(8936002)(9686003)(8676002)(7696005)(33656002)(2906002)(86362001)(110136005)(54906003)(55016002)(316002)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8MTw5fvn3n0zUiFFCiBZoW1v+XsqgsONPWJZzirmf9jr7NB1Cm555JHejLZQqKuL5Q9SVaUxQJvro30BNfGnNEOKC1Y7RfmgDJNW7+EUZUPBOTKErynX1qADaoKO2O1Ab3PvYbRIOJIoo1X3OIN7AylpRNxlDdDSffeu58UXfPzcdWPd9ukpotuEM6OkcnFmVRmoXasAjEjRMC6xqWumJgbMr88yC/zd/JNLVQ+1Vew3VkAd96k/luV4jNVc4evaM51XYZkV1gRTus8IH6I1PyYpaicQjwHNmKnYYvwzG1XCNUZbmMWzGjxiV2h7Y9SBuUi3gBgtrp6bM9IRrc4yMAcbuA653HeIFu80/c/fjBKF4abFDSQcH0TmYSvX86B+E45xtqsq2bFXEi49psc55Ylm0sLUqeiW1kt6ueB7UlggOdvozxe40R0SNTEywgyg4ljEQFesTlJjv7ze6a1GQ4sbMc8bv3yefq0zS9GBMvaY/nFd+YE0uUYlW+hk2Hq2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39956bdb-e4be-4b73-c88b-08d7fad94411
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 03:12:15.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5keFB0CQRSkI8CVahdhrPvLnwmu5EVWAD6KFOytL6sOslxagF95zmczOcp9oanWAPpr3FkYb3ZSk10hwPzTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6325
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/18 11:56, Bart Van Assche wrote:=0A=
> On 2020-05-17 19:10, Damien Le Moal wrote:=0A=
>> On 2020/05/18 10:32, Bart Van Assche wrote:=0A=
>>> On 2020-05-17 18:12, Damien Le Moal wrote:=0A=
>>>> On 2020/05/16 9:19, Bart Van Assche wrote:=0A=
>>>>> +static void nullb_zero_rq_data_buffer(const struct request *rq)=0A=
>>>>> +{=0A=
>>>>> +	struct req_iterator iter;=0A=
>>>>> +	struct bio_vec bvec;=0A=
>>>>> +=0A=
>>>>> +	rq_for_each_bvec(bvec, rq, iter)=0A=
>>>>> +		zero_fill_bvec(&bvec);=0A=
>>>>> +}=0A=
>>>>> +=0A=
>>>>> +static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)=0A=
>>>>> +{=0A=
>>>>> +	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>>>>> +=0A=
>>>>> +	if (dev->queue_mode =3D=3D NULL_Q_BIO && bio_op(cmd->bio) =3D=3D RE=
Q_OP_READ)=0A=
>>>>> +		zero_fill_bio(cmd->bio);=0A=
>>>>> +	else if (req_op(cmd->rq) =3D=3D REQ_OP_READ)=0A=
>>>>> +		nullb_zero_rq_data_buffer(cmd->rq);=0A=
>>>>> +}=0A=
>>>>=0A=
>>>> Shouldn't the definition of these two functions be under a "#ifdef CON=
FIG_KMSAN" ?=0A=
>>>=0A=
>>> It is on purpose that I used IS_ENABLED(CONFIG_KMSAN) below instead of=
=0A=
>>> #ifdef CONFIG_KMSAN. CONFIG_KMSAN is not yet upstream and I want to=0A=
>>> expose the above code to the build robot.=0A=
>>=0A=
>> But then you will get a "defined but unused" build warning, no ?=0A=
> =0A=
> Not when using IS_ENABLED(...).=0A=
=0A=
I do not understand: the "if (IS_ENABLED(CONFIG_KMSAN))" will be compiled o=
ut if=0A=
CONFIG_KMSAN is not enabled/defined, but the function definitions will stil=
l=0A=
remain, won't they ? That will lead to "defined but unused" warning, no ? W=
hat=0A=
am I missing here ?=0A=
=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
