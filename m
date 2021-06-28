Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A43CC2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 07:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3833561464
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 07:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhF1HWr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:22:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44696 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1HWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 03:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624864820; x=1656400820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KxCUpyrRAz/EzJHl31c5Z7FHK4mK7pb3E6rPLW12mrc=;
  b=C3pMOZ0158qRqjr0sEaNahLcFC60wQCwaQBRaqL+8wjJ+agz1+oKC4FO
   IP5QBBkHObVmzMb+A0796lR5Su7GyGe4iKyEZOMFGe7t7THT8N2rk83A6
   72GhocQ7qv9KmzAh/fV4pqqjOh7oPHDZFrQgMb3C6NAcl7OAuVLnWMxny
   lIZ3E72BnpkwtY8+gjqtAqll34JHMOZMmo084yYlHWyQfYkPZPt4SfCLd
   LLvUNHN+4mUFQAKt/FL7qaKlgyp7JrSY6NO9RKmb7dqqX0Vf9PTOQ0XsK
   MKH7er5/TXOBrqWFPRyg5/co5guRv/ZJrNT3M8oZ5N3UPHRQHJiC5bsS7
   Q==;
IronPort-SDR: NvIr1/MdJHZUKJH/dD1ajw/qa0Gl8cfaPqE5brTYwsVFRO9gdOHit/p7w7AUknKymGiiEmRj5Q
 40hFUskRQRp4hP/5RZu0tR8z8Qt/hranp3OVqkoQ1kd06epNoOYiSa7My8SRlnOO9xHdax4lWV
 RBzJYo60P1NdzrBO2S4wFtSrO+qm0X4ADDQEhKQZK6vYNzCADdgL8ad173CwQsfQgu/NgKrdkr
 4sRaybBv4Iq2m2LbNfm3XnxAq8e3vGEKql1VjzzXxAfPxeSFToZmUa6sncXyAUkgyTPDME1eU4
 ygI=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173070215"
Received: from mail-dm6nam08lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 15:20:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRnU+etzsCQCfc5i0sq3wCH8G3SFYwglrXbvCXS2U5Y4z7bo0xXvoLFheqJNz3CGfuNZLY0knKOyP/O+6ki8Za8/ScElHIvnFl12rGooKg3UYXZayee/be7eVPrnX8UzhT8fZohqzWDaLEX9m2NXPXJjXmrE1qVnOI6Pbf6cEl1tKN5/YaOyalyFoAk4r54s/hAOBq37l+SXB0DvUs2SyewVGOTz3HCOwwOtiXS+A0k6I++I5mO3idFKCF0a71cMqxtFY4B88IL7JuE9JCBpjqrR5waPJrF2s//b4kVoso/kG6GfFA/jj23kRSklinjyTgFpi0hhBeKLd8hqlcvlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLRklSHpBC79X0XQexnU3XL8q6ca/BVYs8mk7FisfXQ=;
 b=LWItDlR9/VmqrS3HwtUEcenMSgOq2zsuYWCoruYIqovx20DhIHmFvnsfYN/J/akM1NaroOwt3f3bxr/YqTJqV5HTxEd8snwbNgUONhqqfx/DKNW9ttkIiPqGE0/NMde+H5U+gFVc3yIUY1fKMTRMXDkqjM5tbMyk8ROY8snrNpoNR5+NuGqul/OJSGteJeNA/3IDxEu95BPjITfhq09xZLIxTk03gHdEav8eR3QkiHln7gwhhZFpr4D/eR2Xj4NNbT0P+6cDaQSEK6G64Kj6kuKlUuuL01iRQr+JH4DLlBYqxKyvU9GHe1iwLqOXPiHs0bNFz6zky4fJnZv4wc9P9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLRklSHpBC79X0XQexnU3XL8q6ca/BVYs8mk7FisfXQ=;
 b=BEKtnAARFm4ZIHRCQX3l3rJ1A5yYnf6AiJGVXGzldLBG7q6+QzHrAOlK4EDkYw5ktMKBg/wnsO0v/GHNvblRczLmjMmGb0MBtTrjOXr2oiYywFygir4hIvST47k7/Z3Ww9PytPA4vGM6b60d7bFTX7A/kXS3RlCPx+E7zDQwWds=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7256.namprd04.prod.outlook.com (2603:10b6:510:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 28 Jun
 2021 07:20:15 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 07:20:15 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXYRgPtP8+uBs1gU68gsGoV+YyFqspGeKA
Date:   Mon, 28 Jun 2021 07:20:15 +0000
Message-ID: <YNl4LXUKOftl15M9@x1-carbon.lan>
References: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d64cbe0c-3c91-414a-1a3a-08d93a052cec
x-ms-traffictypediagnostic: PH0PR04MB7256:
x-microsoft-antispam-prvs: <PH0PR04MB725623AEEE79193F9D2C7847F2039@PH0PR04MB7256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gakXyh/lRfcwQZ+N2YGSwViZSy/FjqNDXQJykMFeILB+j9w/tIK8BgmqiIcMeiQsnAkhBIyzHh9FsmwFIl9gQ+YGK8gpSDsXfh1bmgTyZS0rfBQHyLRzPVNqWHyeJEGHgBkr3sECC5y8seNG0mduZKQPo9iMzAxrvW6Cw5Mw/RFe3Djz6+6XQ5vrx1+22wY3NsZhfHUkRn8opn6++5tyebfNpgo6tjE0DkgQM32VguCVgzwdRA/pk4ezdxGNwhogtZVhYqPx+ykpf1z9iHcA+e8h2bRLqjkGsXoE29xDUKlaCoPrhw+OxpNFRHUD7YWy6t/Xp9mOayFZBXgABIOjWRMCeb1G+Y1Q4LDKuFhptLCzWm37ESi8Z507yFihgC02Uzok1LRhxLC1jehn2Wn318/sPZZC9rSfFCLxxHoWpcWXAm3dX9uCN3fuIHu/OF+awisDn3rrjnVH7uBmuf7LEFd1KacYxcEP5HMFlIPrb0+AGYXTKlA2QUc991jHS917fMRi2uuXTsM3Ek5xxIybcbxqhbDo96O6CRCfw7vcs5fYyomofFQhq6x5FG4zPyJ77XTRjRNUo2Z2hUbqQw20KoWIqaIpIijfntS+o1FjzamVT9B4NrgslLVHdOqKC6KI2LvoOdhiH2suzcLAe6vnDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(86362001)(66446008)(6506007)(186003)(71200400001)(6486002)(91956017)(66476007)(26005)(64756008)(76116006)(8676002)(5660300002)(66556008)(66946007)(54906003)(36756003)(316002)(478600001)(83380400001)(8936002)(38100700002)(122000001)(9686003)(6512007)(4326008)(2906002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZ/kCvBdi5puj1ntmmKMeDjAuWPC4Sj7XZ0INC2843sXoSXayuGuU8szFIIG?=
 =?us-ascii?Q?RVpCuN6KM5fGrLUezcCSwoC5407lZoP9htLjP0uvP2Y0XPTMBuDVljZryKKt?=
 =?us-ascii?Q?Jk2g11P5Oy8+/MjU4xOq3wEZCeQa6DpLXBDBj5xcnF1pF//nIBvf3dCRy9LX?=
 =?us-ascii?Q?DnKEIpy2woLkPeDv/HZ2tytd9rY0sM3NpdolxdEn4O0fga3pMTUaSvo81tLe?=
 =?us-ascii?Q?2PHBCWdmPPZ3fdMRAV0aeqNzZVos/84YgyKePNE5g7bO3ineUoItL5FSRlgH?=
 =?us-ascii?Q?gvvS/8hx6JstW+J21rAiWQXqZBEBe8tjfF9bAANhta3VAZp0bYyUBjMjeRj6?=
 =?us-ascii?Q?NN2+01/RRODYGk0J3AzVICPgQkV2OTxPSTN0dL76O1f2tnTsIUm9Y7wGEB6F?=
 =?us-ascii?Q?HDJmb9DBJ7l88gmsKmkcVoQOvjMNUvo9KGVNvQ4KQ6EGgZ6YpgJMJ+rkqmQa?=
 =?us-ascii?Q?GnC8Kj8/Qb1aPnO34BnXzU/MwA/6WfiGzIxTB2LbihPNBbb1ypgd2sQLrZeh?=
 =?us-ascii?Q?lV1ZWUqgWkL7UblQRbdntoLGs5+mpZykgbSBTQ5wY9dWF7hyF/tyqNTyOYJw?=
 =?us-ascii?Q?RVdEdL9uaBqmfKJs2mRcr2+BlUk5MCQ1tvPx+HAXnJ3D2Ahl1O39aIotpyK8?=
 =?us-ascii?Q?y+QE/HcQeWiQ17lkKInNpqVy5Dw4/HvloyF/3VutQulr4nd8RqQthZ65yQaR?=
 =?us-ascii?Q?X1x8GHfDmoMq6YPIdwZnlmPkYFPq1A5agni0ckpvl4UBW09orqdENENO294c?=
 =?us-ascii?Q?TVefwd99T6FMRbpzL35dgCgkxxABdpssk7aZIBLsb+vo3oBBsvEX02IjkFGK?=
 =?us-ascii?Q?b3cLEom2IGebpmTL0QVI4CKvfEVDyQSOm1D0X39X3xP/AG7GuQlJpascKudZ?=
 =?us-ascii?Q?1MGDb2rcR6HHeh4y9O7hrzESW77Q1pG0Y97GRwtP5a2fgLgMLdztKxOnmQbl?=
 =?us-ascii?Q?hxuK+RwJB0ty2TEPyoOQvTbk3oGBKhMix7W+mXcs9Xid2yD6ybGR/Ce181mG?=
 =?us-ascii?Q?rzmsjJQe75fQgK+K7ew6UumNX30DBFRNByhv2YaV2CEXDoC04gE0G/Qh67Iq?=
 =?us-ascii?Q?yOftaI0VnUAX5M0IWde03E6OExZQXhKw0eyEERTDKUxPtIt+Z/qWEUU+WMPE?=
 =?us-ascii?Q?aa37CrwvyPKrLpauZ1sx6szQIsWuY6Wjl8OXuEOoSSTzlJSe4lMBitLJ75uS?=
 =?us-ascii?Q?X6waRxaOHCIvhuucrTbG8shOzoxgEo4iLFuhZ3qs3dk3uZXppmJW6iNb98Hv?=
 =?us-ascii?Q?LvQ08+A89sSWQodfejgPRRUDslWhJ+sDV2i4Vj10+YKjoRe6eiTNA0jI3NFj?=
 =?us-ascii?Q?13gZ2aQqxmhWNzB/K7f9S296?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <204BA4122C434345BA2FC49F47EB916F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64cbe0c-3c91-414a-1a3a-08d93a052cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 07:20:15.1588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vemUxLY1IXsN9WwzjDrp/6hRitduhMBhKifoR2GTfkWCYAzmDuZtU6QDFHQp+D1pd0RycbnqJxw1T5cVIcXwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7256
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 14, 2021 at 12:23:19PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
> BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
> CAP_SYS_ADMIN.
>=20
> Neither read() nor write() requires CAP_SYS_ADMIN, and considering
> the close relationship between read()/write() and these ioctls, there
> is no reason to require CAP_SYS_ADMIN for these ioctls either.
>=20
> Changes since v2:
> -Drop the FMODE_READ check from patch 2/2.
> Right now it is possible to open() the device with O_WRONLY
> and get the zone report from that fd. Therefore adding a
> FMODE_READ check on BLKREPORTZONE would break existing applications.
> Instead, just remove the existing CAP_SYS_ADMIN check.
>=20
>=20
> Niklas Cassel (2):
>   blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
>   blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
>=20
>  block/blk-zoned.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> --=20
> 2.31.1

Hello Jens,


A gentle ping on this series.

I think it has sufficient Reviewed-by tags by now.


Kind regards,
Niklas=
