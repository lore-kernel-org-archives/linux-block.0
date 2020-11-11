Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A606C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5871206A1
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HB68LtCn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mWQUoH+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgKKPUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:20:46 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2184 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgKKPUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 10:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605108038; x=1636644038;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=j9OFHxUFJv9cEVokQ85/PB/doD62hkTV+0zogxigj68=;
  b=HB68LtCnpSghI7Z/NU+i64t2ETGLIMtHGArRgoBj77VMpob6VTmMHRhS
   CudCVAOjU/5bV3pjba+a+oV6MvadZzhH+KqAooLVLnyiUqH8rjgNS6Jp8
   HdAq9KWYdTZ9nnwJ69WdWgr+DQjbvN5DzCZyNCsVyNcZKtPhwrx8bionY
   DCQ3o2vzvn0j53T420dRnICGPlvLwhxDpcFAgf3RhDEz0UNSPpEc6h9y8
   o/oRTyOPOvTwcFc4vY/JktYls+PSf0O2yd7LHGKb9Sy2GphW4IKCrEAeQ
   N+Ismrxntuzf8HZ+wernFATvo5n4uFb9Y4TEJzCoR9mtqfsT+nUpMlj6b
   w==;
IronPort-SDR: r0c3lnHmdR7SGu/Q55QwQ7zYfh6+z99rqemohYIeHnDTwjTTpWl2WhAbRGqpohj4LiZw4yXXmR
 jfDWbnZnLl9y8kqNu2wbwuZ7AEV1Z/GtSeemyI+wkexKotWV7Q7gc++sXnslM6mCccHEFc8VcR
 giyoIyeR48SdFk/p6xiyoJCk6xcKrfCStoQbJtEqjZwuOB3IqaqsPOgdx1uo73C73gH3tA1U+7
 ClolxVsfqtgb9691QtwaIveuv8f4WRzrWtC7BcjXUnhzNmn1DE/CMjkrWG7j0EErUu0lmLoZC1
 1IA=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="156875868"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 23:20:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxfZy8lDgcIMTOYnvPMoH3tdXt5mpvb6oarS8uveidmykRHoFma/3vU9EinmFkF9VOufmZgSKUm94VjHrpmgoTKPNp/kYrE0gEgB4o5xLGA7MPtKBVKVNaC2iT/EBQ7h9ktVg1B0jgwTEa5izx95iEk0D3XB+FNiKXKNm/AodiOsui+ecL9qsV6K+2Hx+D5u4r9EONmyMBlr6RSzNlcAegaehdHkGZ3Ddcf23A82XWLSM46ooXKkz3l3R7lAfwJaMsURO4I0cCGDz23vwf28b1x+yY85eFCCvn1NLhLrFZx+s0lh14VnE7k+1wY2hbwNdExFLwqeVl+0kgFGn8oYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLVrma75sb7q4BIqzAmSBuCuEp+e4WJGPQJLPTu4dCk=;
 b=WznrRdbLQo/mk4hQrDF+JOpzojBxz7dh5COXw8J94AG4N/tHKJLBRHIaiYqaweflIIjYZ50QifQ+sOqkdUeqlovOreoCj1S5yTgCO5f0TW2GInw8VgLl4G4u0wN9TKqQwpG67hdmVBkZ1gMxFogdRXYOtFN2/HKGo12XrZz825P7H0lERY0Vt42QoTFoMHrAud+9G2hIw8LFLDSvt/guJauszlltgcAkoNr+kKkBVK0AY5PTp0nX1GOaO6IBlVNSkFeZ8u9fMOlLdEOzh8ToXJdNn3BgQpAK0bZvP8vwWwrwrB2dsJ5qXugvGiG4OTcJpgi+P+wXjfhP4B5BB7oAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLVrma75sb7q4BIqzAmSBuCuEp+e4WJGPQJLPTu4dCk=;
 b=mWQUoH+5cWj+FqMTA5LmCm+QKWJmUpvkLnlaVZFjD55n1Y8SO3Js4R758k3+KZqf2KN61KNk2a66Y91gJJCL2onaaNPXmdrezCGOYFFY9BkOkjJD4VDhUGDBJksEi5r5UId9jDcNlpK8h9w6UqizYL0Jfk4262BdEY4Fx45fDf4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3888.namprd04.prod.outlook.com
 (2603:10b6:805:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 15:20:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 15:20:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 3/9] block: Align max_hw_sectors to logical blocksize
Thread-Topic: [PATCH v3 3/9] block: Align max_hw_sectors to logical blocksize
Thread-Index: AQHWuCq0DTxiEhrDdEO2+CxYdUhJOg==
Date:   Wed, 11 Nov 2020 15:20:37 +0000
Message-ID: <SN4PR0401MB35985007136E54A57CD714359BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-4-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c4a4263-b789-425b-334d-08d886555786
x-ms-traffictypediagnostic: SN6PR04MB3888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB3888E2EC55C4A9D7B53DD8659BE80@SN6PR04MB3888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4o/t0qSb7eq4XKndJ4K3SK8TPvLQKF3A0UapQmqRyq0S+vlal9c7BeO/mCLM5KDq4rIUkpxGxfpQLcRojhggWP4TwL7Vdq2r0350jglXXTB7PtpDX+qhAjlQeq0v8OMph2kGzl43VKQ00cbJQ+XeX07KpW+Mb204mnNFJiSJV+ArLbNM6MtSb7UN7HM0AkffxXwVW73QDm3egiKw3y7jR2twFyW82wyXLrXOGiB9mcWN0M5+465w8MAxue3Uh6htICm9iZ14qDHg+2fiUTjFNtGoNFDGWZd6ZfKCbhAnVLnZFLg60J/EzQQba2Wk06VVUeNusRRn9rziccqmIr90Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(2906002)(66946007)(9686003)(8676002)(91956017)(76116006)(5660300002)(7696005)(110136005)(316002)(83380400001)(55016002)(186003)(52536014)(8936002)(26005)(6506007)(33656002)(53546011)(64756008)(66556008)(66446008)(71200400001)(66476007)(86362001)(558084003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1ye7GHumyb4OdhG1Q3vs1spUtYi3KUNbvsz84/2tl9cLE77pSz4e7KQE940uzN2K17NRgNqjzL2j5j3i0yY/6UXnu/myY4/eXlQ/TFf+WwAQGWVE9vK2hC2RcdP15ifwZB5t4HJc3u83ofwUz0vWSuiiIawqy5FQptEn9ldgMzNUiiHiP1Q92/WKJvZKow/E1jwRKbqeq1eezjRSUpItEWWF1gJgaWOn9r5gJlyMJbF3HRfzRAJB7xq0/DIcGWj5yBE65mBiMMjariX0vk+o5S2M3AmMslM1X+2O6eqPdnSUseRAopy7KZzAqYfvLtWCVB7dtUnDYIN7kAkXBr0G3CVEV5WxFqdl+XfwFBFfojQ5UYWRmTTZYV4QJjY/wsSvQxSEt7EjvPsPz0NIh7Cw1o4qhEoM/nvs3iu5FVoHRW2VlfrrbnByCiQ4VvXawCtWgF8MR+0EU5sALzRN0avfYWYaSNeFnZxmWiL2S3/PD2/6aReKozvGNZN8RN/zcKdRhmWmAr9V6Tqq3Vsxr4Xi/KcrEhsekJkGNCD5QXvh85UGkijHSJqMKu/EbqJttOgiGmR5z9qR8/otV96+LEDSj6/tYzib8sgopm3WphKNq4dE6A34wiWUvw47dvNQ/oQ8V/2hm7ooAwSEYhfE8x9yUg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4a4263-b789-425b-334d-08d886555786
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 15:20:37.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEDX4XJ7wm1q6kr9nIQUqk6mPJ5IC989NJ/JI2jEVZBDyy57WDeuLLWpIWGzMu/l5gsNs7ACl6VQqejSFoqDKUnDOfxa8Atu2jF4DRTifeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3888
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/2020 14:01, Damien Le Moal wrote:=0A=
> avoid introducing a dependence on the execution order of this function=0A=
           dependency ~^=0A=
=0A=
Other than that=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
