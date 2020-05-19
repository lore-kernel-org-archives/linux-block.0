Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC359C433E1
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 03:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A499620674
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 03:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JDujzT43";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dxJA5sTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgESDDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 23:03:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36527 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESDDJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 23:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589857389; x=1621393389;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XEAomOQBmSsNo7F8QGfjBe8brTF8IDN6oJ6MD9+k3+Y=;
  b=JDujzT43lcIT07DIpbqo31ktKsWmcplunty4KD30t5M6bJ/jgfozploy
   n0nGhaC29zdctGc429u9E1KvRemsgywLbAvFs7t94bJaTmOQ/t7RBx3tI
   gVG5sQUzJ22rkIzl4nBEbjqZPGBeGz3pSpasltujkLinuYN8xiX6R9VUv
   BiVtRvK+c6WNdfbFOKGtetyT/Bxgwdxf0oqPkFSGDGf+lijtZkYBhfvGZ
   MLrVW8bUCvTtYtzpnmS7HYPvmLAraKrM6/H8efZ/whaKUfIqMsyzBXxip
   9csfz/4/rywcr3daJ9ZgSrbIoLTdF1A6oqtBln6JZXo/a1xHcDWCNT5Sf
   Q==;
IronPort-SDR: XX1ddfawehoJoJem+98sBNY3likjPZAPuEI3hkhWPlPwBXI1YGymanbpp5wFveMt+PPyxAJvOs
 pwFrG7Rfl4BoQFmq8nPM/iBxzrcXXL8lFkVndhE38BIK3VL37QYWQlGBu32t+UPVWUbNDZZGEQ
 tvx0HtfVWJnI/QMD8gL5yT+YNSrzunLXMpqCwxQACwuydkhYTtBTapeA9Or9VDlx6RIMA1gpW3
 ti0T1Mck8sqE0rd9JmpHuSy/u/o4BUmiJI6Q1IFinZLMWZfNa+Y6rKI/EnmyhX8uv/YqlwmJ62
 w7E=
X-IronPort-AV: E=Sophos;i="5.73,408,1583164800"; 
   d="scan'208";a="139435903"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 11:03:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKumERKuRe9Regmcdqm2cNHjOp4Ptcv0pYWAXzU+pIb/JgDBUEruVZhWkQPYl9Ob1fK5J1e+mHhtYx1dn+xsEiH3yX3mjrZiCIGzdtcngj3/gIrgpRDpPVNQZHtvFfW/jKwO4+qplDgwlGBi2wyHZev+BqN6K4ehcMoaq7EYItOK0sW16Gb7U7JV1aceM4Wp0shlvIGXzYtcZIBALS9GRpOH1oJB0kJfR0yC1ny6tWfHwHpoqrvPUCG33vpbWV+k221hiNGsy+Lvum0JmpITVAWQSNBrd55JGjCBLSCtAG0XAv+EtUDX9vELBLPeZ9LfrBGcORAzhhoQaXjsBhMhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8lurAkoRMNUEFmcUISq1kf7QhDKYuMoWxK+U1D6ITg=;
 b=JGU2UswDbZuPT4Z3jpzWMT/CclwoY8Ee448noLDgdyrOeU3KtVetzFZ0CG8GGQeC4Z18kP4UudZhZMfhi2/kCDkhDrOrMhsj2W+mlPup6XT+tu/OIeN5xfuRNDcwg7ahBZK8wKwOORIK/F5qfoWAwtOperAdrKrc8+45DC0/Y7QfEygrcha5xhLruxEh7hE7OZrHcZ3J3xoundlUOltyqP4HRFvWG9zspqpk6Y9xuxz4sO2rjXKFgQwOJOekwHbv0yawgUuZF/AhhdkGpwep3cx1MLDYYQhHNkpv7Y+ziCpz87Wmxpu2GwBl51onZsRK1grE64C4I9GLXzGdW7fg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8lurAkoRMNUEFmcUISq1kf7QhDKYuMoWxK+U1D6ITg=;
 b=dxJA5sTbO0GJPPy+JCfdOpQl8Go5MlNkpkJWiNKUJodKnB1mvM/MEN56H916CxSnk5CxPc7jMueH1/0/ft4rNdiKd58vC8nmCyvBdil03xbfPzMzWwmVHoXdmXFz3S4MzN1nmac52XQXyeLk8uOHlstqafd1Orf3awIN94RMjbI=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7011.namprd04.prod.outlook.com (2603:10b6:a03:21b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 03:03:06 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 03:03:06 +0000
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
Date:   Tue, 19 May 2020 03:03:06 +0000
Message-ID: <BY5PR04MB69000C77620D48609E90D411E7B90@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-6-bvanassche@acm.org>
 <BY5PR04MB69008A16B82CD028FC01D0A6E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <440743f4-1053-32f3-2edf-3eb0fdd057ef@acm.org>
 <BY5PR04MB690032A546EF80F2B823C984E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <45f9df39-a62e-4721-5bc8-ac9fa87b02ea@acm.org>
 <BY5PR04MB69008EEBF379E3E45CE972D5E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <be635a33-c07c-c961-3033-cc1a9bc82e8b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46f8428b-3106-4dbd-7fdf-08d7fba12794
x-ms-traffictypediagnostic: BY5PR04MB7011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB701112F72A133205B43AFCE9E7B90@BY5PR04MB7011.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2j35M47NfDbRTBQlzNOsD/GJbe6wi0lFqI9dU1g2eMVq7CgOd6YtvFIqiJRomg58iYBIV5KBDJkuQ7Snt5zL6XKgwt4h6HDWgh7VOJAxXmC7znUsBGIQSZygaKXZbpW+4Wdr6eQyPHuzXbzbyWzxSSJ3N4C+9jp6SnwCnt68+4hH6B9CY0wPDUfjXAJHEJjdFtsjtnhZq146CmUNA1aImG8ASlSR7bFLAxLz9WEX+53gmtUvYJAiGnOc/eLL3cYxWKyUwNh8jcitj/bgBt/Xn56t+ZQvf73NgDnL7zM6rZL/zdTJfgzkVq60X9MCR/RED8krkpdWSKF+E7ZZFRzoNQN2n9k664aLvtLgA5r/EZLGHYLpEqhJfn9ciL05o17y4uQdEf/a2i7x+AzaFPuN3k5H1rkDkcDtY7wi7+4V8kUKV2CR8W6xv/lS4Jor7TY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(186003)(86362001)(2906002)(26005)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(33656002)(71200400001)(52536014)(316002)(5660300002)(53546011)(4326008)(110136005)(8676002)(54906003)(6506007)(478600001)(8936002)(9686003)(55016002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 21liR37q5gzO/5acflFzp8ANsIjHduGjHh6z3eKJ0J5LRYZZdstzM8XWMtr5ppNWb6d+HYagHpY4SdFhHoAexIa6d9MxKRM3iFYPxedd2vC1AdGx10CqLM6iFMOAq0rOjxEdnoC/LoEERpjfyqPUV28FBMhf+IyGrkOPHoffNT33GOLzgRgx08fintNb/vgcuhxL7OU6pgAwpAf33kSHSOdMkzhMLy2m6bprw0MsFp4gfxDj7djIE2DbA+FSkWWBnogugQwuRfQQOHjUnPVCklQJWj0YWmtF1mpLs01goaJaE4+MUccIXlhi9xoU6B2sjAvTUGGuZskKyvrXcWQwTkxpA3ki2cuLyad14ykS7+z7PMRY1Lov2aTxqqqri1rg2Y4ZkjWmpP8CDgViBh3YgX6R0B5bVghOnKg79kU+32rhSyEHuu2NMZE+c4CenGBzBGwDYhwQGx2hCbzPlC/60X3qFOAqRpWT8BiCCcQbPKCDB120SCl4UpqD+QP9gUaB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f8428b-3106-4dbd-7fdf-08d7fba12794
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 03:03:06.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A09uQz8UaTt/EOcHrgp2qyY12J9uo2BtBmpfo3PJMNRIKVOwVhwJefu5NSPdEhemlLM8G2hQDA1EYe+ZfuiZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/18 23:31, Bart Van Assche wrote:=0A=
> On 2020-05-17 20:12, Damien Le Moal wrote:=0A=
>> On 2020/05/18 11:56, Bart Van Assche wrote:=0A=
>>> On 2020-05-17 19:10, Damien Le Moal wrote:=0A=
>>>> On 2020/05/18 10:32, Bart Van Assche wrote:=0A=
>>>>> On 2020-05-17 18:12, Damien Le Moal wrote:=0A=
>>>>>> On 2020/05/16 9:19, Bart Van Assche wrote:=0A=
>>>>>>> +static void nullb_zero_rq_data_buffer(const struct request *rq)=0A=
>>>>>>> +{=0A=
>>>>>>> +	struct req_iterator iter;=0A=
>>>>>>> +	struct bio_vec bvec;=0A=
>>>>>>> +=0A=
>>>>>>> +	rq_for_each_bvec(bvec, rq, iter)=0A=
>>>>>>> +		zero_fill_bvec(&bvec);=0A=
>>>>>>> +}=0A=
>>>>>>> +=0A=
>>>>>>> +static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)=0A=
>>>>>>> +{=0A=
>>>>>>> +	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>>>>>>> +=0A=
>>>>>>> +	if (dev->queue_mode =3D=3D NULL_Q_BIO && bio_op(cmd->bio) =3D=3D =
REQ_OP_READ)=0A=
>>>>>>> +		zero_fill_bio(cmd->bio);=0A=
>>>>>>> +	else if (req_op(cmd->rq) =3D=3D REQ_OP_READ)=0A=
>>>>>>> +		nullb_zero_rq_data_buffer(cmd->rq);=0A=
>>>>>>> +}=0A=
>>>>>>=0A=
>>>>>> Shouldn't the definition of these two functions be under a "#ifdef C=
ONFIG_KMSAN" ?=0A=
>>>>>=0A=
>>>>> It is on purpose that I used IS_ENABLED(CONFIG_KMSAN) below instead o=
f=0A=
>>>>> #ifdef CONFIG_KMSAN. CONFIG_KMSAN is not yet upstream and I want to=
=0A=
>>>>> expose the above code to the build robot.=0A=
>>>>=0A=
>>>> But then you will get a "defined but unused" build warning, no ?=0A=
>>>=0A=
>>> Not when using IS_ENABLED(...).=0A=
>>=0A=
>> I do not understand: the "if (IS_ENABLED(CONFIG_KMSAN))" will be compile=
d out if=0A=
>> CONFIG_KMSAN is not enabled/defined, but the function definitions will s=
till=0A=
>> remain, won't they ? That will lead to "defined but unused" warning, no =
? What=0A=
>> am I missing here ?=0A=
> =0A=
> "if (IS_ENABLED(CONFIG_KMSAN))" won't be removed by the preprocessor.=0A=
> The preprocessor will convert it into if (0).=0A=
> =0A=
> This is what I found in the gcc documentation about -Wunused-function:=0A=
> "-Wunused-function=0A=
> Warn whenever a static function is declared but not defined or a=0A=
> non-inline static function is unused. This warning is enabled by -Wall."=
=0A=
> I think that "if (0) func(...)" counts as using func().=0A=
=0A=
Makes sense. Thanks for the explanation.=0A=
But from code-size perspective, I think it would still make sense to add th=
e=0A=
#ifdef CONFIG_KMSAN around the zeroing functions.=0A=
=0A=
=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
