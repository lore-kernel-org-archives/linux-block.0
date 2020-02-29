Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C65C3F2CD
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4322467B
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M53Kindy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JBf57kd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgB2XMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:12:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61219 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2XM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 18:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583017950; x=1614553950;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qzBSmQi0PufM/Ik9kS4TUvitpab5G3AUNyd/A3qFAzY=;
  b=M53KindyewtGz+YOmDC1ZMh6sHpsRt15QjIDIR/q1HWznqdCQQT5aMr9
   C2JUqZkzcbwFKzhp6LID5+gPrFAGTONgySSlM0oAFT54hW5bDi6E0Aq3m
   Qct+3fGo9Kfi6JK70ZnS9+2ZSF1vLvCBBzzqTtVBOF9aCGDu4fdK1OtkO
   pUw7TTFEzf8O9af8TNk0P0tk7r85qBB8Qts6gADDY/xnLPCgjNdXkhX3S
   M20+FzgdJLSa/0Q6AerBM5OgRSbA3clIfaH60FxmqQ6K8AIJwIqrOtOi+
   AxSnObmQkNGngjSpIIV5FrioV6i6mGxeALojFgN2tjMpRnwOYYpPWk6xh
   A==;
IronPort-SDR: U+mq1XEHQSQ8M4YSNTo7ylE+rsYliQvuWokUkSwCXCQ64z7VyE67y60gJttWH5RutZs/hAaghv
 gM/X7UD8O0jxMDHPqmbuh86DQ1tLdho38YbvUHYqRfPwXpn8hCF4Z8FuzN/Cbrq0Vw+HBQPPdP
 g6jm51rpWhCwYX5cfiLAvXhc0kB7OAquAESoO5jCgmEv89+U8Nw5ecQfzBdtUcF9BuTiQUXrcl
 bTRGlo3RPL3M5s3sdFEZQRPsYqAAqStdxWQFWKb43ox3tTgvad3z0pS2SFGaTEozcoR84mciAT
 Ivc=
X-IronPort-AV: E=Sophos;i="5.70,501,1574092800"; 
   d="scan'208";a="135481575"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 07:12:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aptkheej1XSFUy0rkgUqWe7B3+A+4ip3bKTMnXG6OClOF0VZt4mPFULwO+sGNGmtv0xlXUTSevzFijrSmxVbI9f0bgyovXgX57O0XwfFicreF8btYTNJ7HYiC+izeHV8hUnUemTQw6Z5vIAd+0TmGZ5bSFpQL8+q/j4FTzHo62YS1sKDbuHtWbqyZ3mgkzPvb2uryolapu/lvIVVXZTJSh4Z1cMo/ld1kJP5j9rt5ocEdCVHscqWnhD3Qob8cJO+in1DMTBLGKGngm8HH9v2EAlD6j/9ZhRID8pWwg2cid2cjw5TNRXYS2fPRFHpMOd76hd8N43UiEd9vvWR+ugigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzBSmQi0PufM/Ik9kS4TUvitpab5G3AUNyd/A3qFAzY=;
 b=aNermSr4wHsd+OMTxZpXt67/soAQz4N2C9loxedtt+0DiJ3LxLJUxlmKDkC55neLU1iIxBj/26RwqrDk0UmQShHPvJTK+xb8CkA1N3hPVtUfjP0ygIrVgmCiBTX3KQASRl9+fxDTgUMySqZZKOzsKsMRFRsPeEPXOy9NS7CGAEa0oOYQQ4Zv5VKwtgI3k+MR8BXpM3LHbHLl4qxeIFRtZbu0J63Yq0gNstemEIr3KK3b9y4k72Napi+MRbDarsyACpuzI/6swl6Z8Y/ahSE2jl1IsY2fq3nU4KqE+l242+PaKMiqkPT7E4hWlQw7JHTCWgoBvDyMX+i/qSbwWjAsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzBSmQi0PufM/Ik9kS4TUvitpab5G3AUNyd/A3qFAzY=;
 b=JBf57kd0O9/pcn7Mk+Vf14Bw1MmKjMId653xSQhTNZ7A7IApxQO0edGHSSq0u7T4H7e4SoKIcgUrd+QzAjD4qYh3Uuaikz+JQyuR6ssjIf4Lusv+oab2uQVxeSrVniTMQsQ1AzfWjef5PN4Axqw31ZHBrDVVbylKQU/cEYQge48=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4568.namprd04.prod.outlook.com (2603:10b6:a03:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sat, 29 Feb
 2020 23:12:28 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 23:12:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: remove redundant setting of QUEUE_FLAG_DYING
Thread-Topic: [PATCH 3/6] block: remove redundant setting of QUEUE_FLAG_DYING
Thread-Index: AQHV7kinu0RkmRH7XEmdjRxco+zs9Q==
Date:   Sat, 29 Feb 2020 23:12:28 +0000
Message-ID: <BYAPR04MB574993BE743B35C75E7F112486E90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-4-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b99aa82e-9316-4e11-41fa-08d7bd6cd86c
x-ms-traffictypediagnostic: BYAPR04MB4568:
x-microsoft-antispam-prvs: <BYAPR04MB45687B36C7EA50D4B2252B2E86E90@BYAPR04MB4568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(52536014)(5660300002)(558084003)(66946007)(55016002)(53546011)(110136005)(8936002)(6506007)(316002)(478600001)(9686003)(86362001)(4326008)(186003)(71200400001)(81166006)(76116006)(33656002)(81156014)(66446008)(8676002)(66556008)(64756008)(66476007)(7696005)(2906002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4568;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLKrcFmbmv3vnT4fx4dIhQ4+4yG/chlwL5zQpV9qERMYC/LI+r9YDj3rRRkaNoKT1oRWj80Eg680AH+HnccsgstBkBb5V2LKeOV2A4a+mrCuYvchC8eaZdcH7Nc0l/9EYYW/1rKaeSe5l9N9OV3eIyw4XjOR8HNQRdkjSZ4FNz2Gdqt3oGT07nmd+rLJlcBA5LW53XH1POJ4N+29j73W/3mhkQhT0v9pcDGHBDGVCsKv3/sG5pf9m+GNkhhmPdoGbHUbd6qihrP4EfRG64i3FKlRoz2ihb/DmkoNl2Pt01qpRWxskGja8pXTubwNevp0wIJgqRw44ONYxsZADq005TP/JYtjOW+45U2PKZmE9MWl5W1qoo5T8dJ8zzRcNoTFyHu0xCsMbl25MnF/222Mype3J6wIZDRpuHC+ugu7mQuV0BrE5rQOZvcls29LAsHm
x-ms-exchange-antispam-messagedata: bj1LnwOLuKYrd8EpXfVVh1ibjD8TZrUzLQ3gXQC75g8m5BYn/nHKmkKgne3fFR6FKX2k496PfuWM+/h7ZVtsiVCpwQ/jNpVvQVVQofVs+RrgVKQubtZ+9A8qSZdwYE5pIsZ1jkNItTtJo6L29zNG+w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99aa82e-9316-4e11-41fa-08d7bd6cd86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 23:12:28.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZgO72iZQfhIhuuHTDF53bFa5LcesILCZG4Wa0ZfdKjM9N2fAJBPkF5zjjhxfFGIoaaU35xcjhCvW2PEt6LIQyfaroHu/+kF96AwZXuQyGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4568
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 02/28/2020 07:06 AM, Guoqing Jiang wrote:=0A=
> Previously, blk_cleanup_queue has called blk_set_queue_dying to set the=
=0A=
> flag, no need to do it again.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>=0A=
=0A=
