Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8FC10F1B
	for <linux-block@archiver.kernel.org>; Wed, 28 Dec 2022 03:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiL1DZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 22:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiL1DZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 22:25:47 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58428C42
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 19:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672197946; x=1703733946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lCIGi2VEtQsVKkuH1yUDfJR4HjdcctVrU6/H6TnWMIc=;
  b=dM04AyDnDyvtKpAI54PbnuBe6toTyU1C4D11ZtTLJWeLKbfuXNs6lAFJ
   OfCKhhSwbnbGhuB2V3BXH7SYbEulp9Bj/n9Ik5GKKoiGzQp3ESGfulLyV
   m/xIWimS4+a35uMVc3qm9YZElldDdWF8YY1+0jmC6Cqs+1UAAU9UogCy7
   z8M5UWeHWmKqpb0Ifg1OAiagrK2HA062ewH9wfsL3+FlIPl8KJDouxd0K
   WFa74kPE6XmmUpFgAnfbrq66azLmBt2Le9xGtmoALQzjO0LRvyAFFc5KC
   v8WSvGdQPWHZanL4HZwBtMhicQHAUJ7DfCuadM6ZcfalAbBzIPf7X8GKu
   g==;
X-IronPort-AV: E=Sophos;i="5.96,280,1665417600"; 
   d="scan'208";a="217810534"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Dec 2022 11:25:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvjJ+htneEVCLnzE5VUdj6e/OREuvKaJ25t6P4iU9AZJJztMuI5IhQoorv593c1ErSYxH0rzbsmf/LmskLKR1IhTXlh8WV28gnlF9Pernn9IFp8Oz2U+jV4g2lDPzJR4btuf/G9c0Kjgy8ei4S/BAOz/IOAPrRWfNENFSn14VF3m1bo7EsftpcH29O+VeMHUkOqIkOw1vURid4sVHsJQAbTEDajC2zhdht3zO2JSP9dDFu5Q4tjIigCgnUnlhBBg0V3n8DB3SgGGD1zx6AABQJvjF8AZ6wrReXVdgAb/u9vQuGe83eXkTOIzDo4iFCKEzKB7b6a+XrwflE2BioxMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCIGi2VEtQsVKkuH1yUDfJR4HjdcctVrU6/H6TnWMIc=;
 b=Zgd3GhMP7tfAkfNmKDYs1nBo884K84Df9nfTTP9/Tlw+tpzVmwF3RwaJvWdgXAr5GavMCMf+EWRaO8xXYrCq4o4PW3RDO1GEvGJ5L3FWjvNMHeezezyEhDh/7w09G1w66U5WBdtnrxv6TtYpqjOMqR3g+8p2RDjXjm+FEhckB9DEfs6494UIFtRK9BMMUMhYEGG7IlvaUsbLYrnhan0KQPcR2owPt6lPMTk0X3XZLj23ZV0C8pOQxCLz2/vV9naPrAqiZ3s/WmAUGa77j0eSXuCYRYLRHEFGHcTvF9F8E4IRqsyPNFzMuNYxzdnc7hajmdN8BjMq3SCFM8zj/VqS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCIGi2VEtQsVKkuH1yUDfJR4HjdcctVrU6/H6TnWMIc=;
 b=qeDMWgpLr2RLXeXA1LoLMVQGIyRzPfZ8DHES+Vlmw6Pw8iYnhTx5a7BGUMQ5U0wg1ZMZyKPRMq7w0+g4gMh+eIqPINlfMXe0V43Zw8U2yRt6OYH8txQcXl7IWUT1RBRkDdNn4aTl+HldegY1vvlnO1di/CATgXojqN75h7CSeZg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 03:25:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%8]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 03:25:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/6] blktests: char device tests with iouring-cmd fio
Thread-Topic: [PATCH 0/6] blktests: char device tests with iouring-cmd fio
Thread-Index: AQHZGmwQnOhtFcKnHkW2d+vuQZoRtA==
Date:   Wed, 28 Dec 2022 03:25:42 +0000
Message-ID: <20221228032540.lkprcp64numwjvr7@shindev>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB6514:EE_
x-ms-office365-filtering-correlation-id: 736e97ec-0165-4d41-9f87-08dae883331a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+RvYibhqePBntP0oMe0SIc3i0OAfZhya5+zMITPfeS1RcJNmpmB8Ge8z6eWki9xmKriK1u3fwJjfFRu4PNth8234QlicfOqk0tgnlEcMBsJpDYc5NcFPwZ4GsJ54O4XVEhbgOq5PCdOCSv2IPs44yDWD8VQFcO1PUpsD8XOlFWnGt5tt54CRp9bOGAuTsyZVIqmGiRPMqJEVvigcfEnf02/EKT7zdDnLRPleFCldOkF18B2ZyCIuA8dYxVmjlovs3UGIWwSmzdfA3NoKx5t1TRKpqZTERH8ucQCWKYbDca/pUjipPOoUSkOsZY3howRw0I7JTPWj3Cev5TqYRBuUOHYl9MDCgDB9DFb1EiH/FlwB5NoDcs0Jb6Uoo2OpRb4HDKPWieelqBOewxSdWp3iyMmeVTHrvWcWT+Z9Yvfy7uJwsYnXOgTQZMn24o8Ye+JtpWgP1cF4T7oLHm+ib0k/REfCKKplGvpqAJ+i39KrEQa4o4a3yG9YUz5pniUAwJZd6OLJfUM3QESfVGeYgNG5UbUxaY1v7zu+GK9lnSgg611u1XRMwYqDD9yuGvzk0XOABApzy1GXBStnazwVAAlJVJPi06XvC4T+q3IPXAnPnSONFC1Kq2+OE0nBSzI3F9SN4TwrZsQqpASoas9NkIE8xlRorgPyriDInLhe5ujBCs9oVFzJ0cmoUbp4KUBADsnyqEBbgtBQ3bD4LSIAVQiGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(71200400001)(186003)(6512007)(478600001)(6486002)(9686003)(86362001)(26005)(38100700002)(38070700005)(33716001)(82960400001)(1076003)(122000001)(64756008)(66556008)(66946007)(76116006)(66446008)(5660300002)(91956017)(41300700001)(6506007)(66476007)(316002)(44832011)(54906003)(2906002)(8936002)(4326008)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kYol6tE542Ztykn554AYOF3ogY+SFpaxAB2l7vcazLUSC3C76vImR1HQgn+H?=
 =?us-ascii?Q?hERwktMiJMVmrntXHBnIl1F0BqAdRn7KtX38N0et9mUKzUjHer4ZQgWCbnsA?=
 =?us-ascii?Q?bJKFxC71bCXKZyOcQYnSB4erPzS0Y2p7yTGs9LzQ56w/+I9kAttLlBaMGQrU?=
 =?us-ascii?Q?+TSaF1WXjz2yYAJXsDnQrbmLuqBKqJcB8qD8n5RScafYM5gkvasoUYUMK7ud?=
 =?us-ascii?Q?jiehQfe9vNc+7T5CggGj+oMZkfvz1QFNi+k4oBLt+yfwTET3I0ITaL8C7G6I?=
 =?us-ascii?Q?0Ry9yM/AgmtF3skUepdNgo5Hr6ZN2Fow5AxEJi6lIS0RCaharUcKYvU6yiLr?=
 =?us-ascii?Q?8+8FmeiiH+0iYJqg143zX3Ww6sJRr7wJC6NZST5iaE5F8YLTH5bh7U5uJ+qq?=
 =?us-ascii?Q?I7qewbZ/JgGsI/6RQWJaxjKzdhX3V41M1GJaKJe+8N9ajnUFR3g6AyVge5R/?=
 =?us-ascii?Q?l8jCOxNFjaqXxWNnFz03MPDFPnoNneQydpaG85bTo7fqTxud3z6KAuQbjYPB?=
 =?us-ascii?Q?qSkhr47uSjvfwiIg1GMX/2sOLHuw0UvVYi/QaGWLWv9I1I0GU2yCq9RB0kZ7?=
 =?us-ascii?Q?8cX4CkFRhPG77JyHMgJFfyypOx3rfn/C3XJEuSyO8O/HlWAMe4hhUPfqADy8?=
 =?us-ascii?Q?tWWztDb57m+HMdXVAyNCDAaBoQ+AMHvt6pShCK10Fikv0n360GrA/v0YNDzn?=
 =?us-ascii?Q?Y1pL5DL96aDQPETamc3CXZppgKtA0Ni7yTCnDjvfajxiRxArsKEIheNLHKmu?=
 =?us-ascii?Q?X9y/YMBlOW5w9O50BgmU8g5hYOHkzPAKbT0LE4f2zXLeVzWikSL1p94+kQX6?=
 =?us-ascii?Q?QU3ziUnvigdSVg+wb5NgbXLGRyeLezPVueoCgiqtqKCd9RGOizYjowDY2vih?=
 =?us-ascii?Q?ddB5pr7F1AQs81mwUabepfkTeO44HChYgILHMGTCyF+CWPKv/lxamj3phLkh?=
 =?us-ascii?Q?IsNEo0z08buf8tLO9W6lT1vELRQYMH//gq3dcPmkR0VUNTgCt6iZKiqjb25Z?=
 =?us-ascii?Q?dcj1IS2mUrnlN1Odz0FJagwxu8RomqlPJWDUEC32ybJRsu7NjWu1ej4MrUYF?=
 =?us-ascii?Q?i1uGVH2guMAyLqmgAwkoOHacM8Ohq6Lm7o/O5Oah384H1MIaxMAMxlKFdubO?=
 =?us-ascii?Q?4i+Bo+xVkBzwZqZvj01EWfXS5DIMM24ewF/0OEboRaTUzHLgyEk7Fpl4czUW?=
 =?us-ascii?Q?RQHhP4V8NIyIVDAS665vyofMEXvXyOcTFt/UjQQskl2nCous0jaBoeH0syVW?=
 =?us-ascii?Q?HRQi1cJmrnI/bYt4BNFWMTtiECFbMRDUndmUnYaBeKuU56M3cU4O4jq17atB?=
 =?us-ascii?Q?UwqtuA7vC2XDTcUO95prkZZ/K/1AmAclDWncYC8mYrAoS//4MfVIPPTmj7XP?=
 =?us-ascii?Q?KAF5y7WaGD1IzNXnEXb2OIfBid9DlJPQxxECjLNQ61Qwgqf8ilBlcQu6R6u+?=
 =?us-ascii?Q?e76NxYMUERMEXk9Q3KJqwqqnXEDeMPABd4fd7vAj+3qx4e30hZ/jEZPjdRno?=
 =?us-ascii?Q?apPLYRHcAMkn2hUUaPn3RXSZt+C116HcsBaSJ9z74rF0pjsbsOwvjoJksGDk?=
 =?us-ascii?Q?1FSu0oBuarIgw4NWAeRKD5yJIDWKIDdPFRNxWyKm7u1RxK0GlSvUBFqfQENb?=
 =?us-ascii?Q?U/TV62vvfWIpMZ0ruYf37iA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0B8B25A1B89D345BCF2B97FCA3F19F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736e97ec-0165-4d41-9f87-08dae883331a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 03:25:42.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7wM6EtSknngxydzv+9e4YHZM2ysKuu5zd0JN5plvKHhyJHm8FuYNIMrwEveh2/4OKegnq8TwrNcm8jRKkyzzrM+HLt71vd/r9Ye/p3/EVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6514
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 21, 2022 / 02:34, Luis Chamberlain wrote:
> As io-uring cmd grows there's a desire to do a bit more funky things
> with it. Add basic support with fio and add a few simple tests to
> tests the NVMe conventional drives character device as well as the
> ZNS character device.
>=20
> These tests are perhaps a bit *too* basic to merge, not sure, let
> me know. But I figured that this would provide example to let us
> grow this with more complex things later as folks add support for
> more features.

It is good to have new test cases to test new features and their new code p=
aths.
I agree to have new test cases for the NVMe character device with io-uring.

Having said that, I'm not sure if we should have all of the five test cases=
 in
the series. The test cases nvme/046, 047, 048 are similar. They do random r=
ead,
random write, or sequential write respectively. I'm not sure how the worklo=
ad
difference expands the code coverage of the code paths in the NVMe driver. =
Same
for zbd/011 and 012. They are intended for ZNS devices, but I do not see ZN=
S
unique part in the NVMe character device code paths. Then the variation of =
the
test cases do not look useful to find bugs in the driver. As the first step=
, I
think single test case will be enough which does basic read and/or write to
exercises the NVMe character device and io-uring.

--=20
Shin'ichiro Kawasaki=
