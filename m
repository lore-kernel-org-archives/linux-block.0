Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926ECC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 23:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE03205C9
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 23:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G+Kf0H8a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MOYxbpVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE03205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeK2KhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:37:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41899 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeK2KhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 05:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543448045; x=1574984045;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oKTovBnK2jJHuydxPMV8hy4sYEYmyLrQhSTjng8RsIE=;
  b=G+Kf0H8aJCUNC4Jx1j8U92sWeFbnD7yhr+Hr9jvivJoz+LsClCjqiVn9
   mr1Pa78im0YVCm96aa5fM3Wvo4JQxUTpbxUIXvtB/LNmWM4bx8mFobPSF
   aKSshKwVZIxx0jngYzfwFFFwugNxLtXdTzDReQvb7vUdDzCBlbWsqdEyR
   Yf3YA2EvE9pJfFLSKygA2jYHHcbfDeRpw2J21NNRa3ONmyw/cFZQNyeCx
   D6GppQ0LMIX3na2veriiNnlRII9pBKXvnAthxrPZ00OwFodhurUDvJQ/S
   g4/0puce2oZPjBM+p80ZVSmxkEgJEel92QBf+NhfO08Vs7be8gbu/wk+4
   w==;
X-IronPort-AV: E=Sophos;i="5.56,292,1539619200"; 
   d="scan'208";a="199937741"
Received: from mail-sn1nam04lp0082.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.82])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2018 07:34:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB+nK9Kmuky/CGhANJMI9mNQAoekX0Xzhza8cLqREuA=;
 b=MOYxbpVcQpDqXlYRIcGJAuqjlQw6IrF9NKxYaLvm/GNPQEmntmF0is0+097/VT6tahJeE2LfdmLYvHpKJ7YhC8FNla83OBozuyMBb5SmmFG66JpYU6tP8AOc2P8Gpma9i5lWCGZOV4fM1FfHYT5H78ufaVuS4pMkDfYXCqWZHjw=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1512.namprd04.prod.outlook.com (10.163.38.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 28 Nov 2018 23:34:00 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::fcc4:f2bc:acef:5d0a]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::fcc4:f2bc:acef:5d0a%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 23:34:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: update documentation
Thread-Topic: [PATCH] block: update documentation
Thread-Index: AQHUhrlSAxZp+4biPU67xHwB0AllYw==
Date:   Wed, 28 Nov 2018 23:34:00 +0000
Message-ID: <BN3PR0401MB164038AD6DDF897C00B4F32FE7D10@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181128012552.20568-1-damien.lemoal@wdc.com>
 <7606799d-1ecc-fc8f-cb5f-caa90e49ad09@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1512;6:8LCHfsxNFaXeSl3Q/pG0dGmeU3EhJFSgPWTUhPxeQOW5+tJF78HUZeOV6hXZoAYcD48Bt+Nw/+edjABHq2edaamOi9cUgt6WhD/TSJSNWxA51OonhCk81b10jLXOOVkbJeNS/JvG8hbTiLZba6x4+iHOkHIdRwHiYSjIyd35/P7iaousVBXMAxi+Rs/N/5IBdaPgq5V2QlxMqriWH1xsSxErXy9wljiz+gchV1sifBzk51ercAeGuPesS1Xho3crzcX002IaWzn+2hl9t1qAxhCAy9YMjifYDahLyyG6XO0jRuyXnSBs0YRSRZO+ypoBX/muO1ub69c3NYaiEwFg4UI/HnVYt04Vfd7bEotP6REZRmmeIc7V4Erl9yl3k2YpiUuZggp9L+bcGgJiEUljwnpV/eoM2011mQ1YTvktywGW07419Cg3yVMTEa8kZGj7q0o5m9/pWmScQdpAAwm8xHbc6+1SLHkK9qR6GFEpMFQ=;5:V01WyGH4PxC69Xuz33ourorV1+rjevEBD5S51HdrfOcK/kE9tI1YACMwBcHwVHbHyYI9znakMbQ4wHa1cbFfrgzId0zdc3KKWldWDfQLJhvw9wTrchNkc74JqhGErVzb21sVFyzF9t+jO1f0ZHbayww8G6lrrc9Hjb5PxHKvnvk=;7:/ca2TqxzJ3dhsgMasFL9HWX+7G3m4h4D9yp7UvNQOuXSdah4LRZqe54kR0oNbl9bH0P4Csvn/Ficd3MQR4RT1NGOs0XOTZQP+uweGyb59r4PeshchEkjMIy81tgqwEhq0iAX6T5wRyDiwHGytAy9XA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5ee5c5ba-1fb5-4d08-8b20-08d65589f9b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1512;
x-ms-traffictypediagnostic: BN3PR0401MB1512:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB15129EED23D6407708B1D268E7D10@BN3PR0401MB1512.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231443)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1512;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1512;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(476003)(486006)(72206003)(478600001)(14454004)(99286004)(102836004)(105586002)(106356001)(53936002)(6436002)(26005)(6246003)(446003)(110136005)(15650500001)(66066001)(2501003)(5660300001)(316002)(68736007)(81156014)(81166006)(558084003)(229853002)(9686003)(6116002)(186003)(3846002)(8676002)(55016002)(2906002)(7696005)(71190400001)(86362001)(8936002)(71200400001)(33656002)(97736004)(76176011)(256004)(74316002)(7736002)(305945005)(6506007)(25786009)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1512;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JmOFJw5GaZ8MgXFDVkoFTmt7P7eBzHnT7lk2kKRFZVBkOsYzI+8LH3nzi+br1qouR3E82r5NV+0+EBgARwy73Ualpy/4+xWrsPRzSfz07R3QtGyArOUOyfluWmDKGBuTqa6TN5CqjUWtcsmNhyVheTH3CkBgqzbc85Nw3tTPtu4ImmHco+47tTYLs/wadSPGFKOWvbVzfFytHZOCWn5ueRAN5A07aN+PbVSxOHXRlH9rea9pefpRC8WlPimTU7rLD2Y/wQ/t0NqhP4XJXv1H58qzzr6VoWhtGMhqaue9lbVPfaDCIGlEGQbg2tSPF1bQIRdYgqEszVa3aJd59MMQJOClyryGmMKM0CeZWNf1mv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee5c5ba-1fb5-4d08-8b20-08d65589f9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 23:34:00.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1512
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/28 18:55, Johannes Thumshirn wrote:=0A=
> On 28/11/2018 02:25, Damien Le Moal wrote:=0A=
>>  Jens Axboe <jens.axboe@oracle.com>, February 2009=0A=
> =0A=
> I guess that address of Jens' doesn't work anymore either.=0A=
> =0A=
=0A=
Yes, I guess. I only updated my own email address...=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
