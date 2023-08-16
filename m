Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8CC04A94
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 12:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjHPMLN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbjHPMLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 08:11:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C5212F
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692187870; x=1723723870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GiODiVRqoyNI315AHF6+5L0vEtJZJ1xkcoA9ko9VrBc=;
  b=AsCUx/sFgTUnBpIC2w4PHdfHS4u1a/twL+X6V3L9Qu1STaJB7HBATPSo
   1MQ77LuXhbBrpdk3/k3oTvQNHM2byJJUP8iVsJI9fsAco1rlimAWNs1u+
   8vYzIYnRapqUlyTcNo4Lf74CpQlBgPAa8/kIDt7fiik7AtJg+VOQZozY+
   xb/boUtZpMUo/UhT0cI35BiVQ/rVimyoUfVWU72vNV0YjlK+nodxufab8
   YloNhoKhDrh4lMLkL/38AgJ2XW9UwooxCWLRyHLt9oyPV67d2Qzdwj/Lg
   vhmjr83/zFbIu1qVaStVVSNHe/oYga6zzUQRehGDobAS1GnUOpzUN2xkR
   w==;
X-IronPort-AV: E=Sophos;i="6.01,176,1684771200"; 
   d="scan'208";a="353245753"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2023 20:11:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSaDCfiK3w5LeoVwyzblpz+flpdYdRZH2DesfRNN2AakMtt+ZINpiJyo345H/5Drkgh0iJF1oiwSfUloiW/g6QPcylyWFCjM+oFK3z7kLAy69j4P21G1PHcsLelVWvNPs4CCSS8T6ltoxeI2TlzR5gYpHiEi3RJms2QxpX5L9+XIbObNyJBclfDlK6FDYu0Mhk3foWKMRsaPPJC2fUYi2haQ6GtRpbMZ/x802uCDnENRbpsns5MK+Bqfh1UDL+bR69tIMi8x/UPdAUoFcW7Q4HX/wCKaMqvAyB0BxUDYNoEE+2UDpAYx3PaUFDr6Fxly6SSmLolVAlI/YGEH0yh8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiODiVRqoyNI315AHF6+5L0vEtJZJ1xkcoA9ko9VrBc=;
 b=XDufdkOsdDzED+AXHPlL52RP+biVV9/w/DPj4FqlTYeSvnLxHywg1HbuRx3Y7ncRCU6Xpb8K4uawk05grVM/wwuy7Nf/QnamWJcYjNrRu57LYdpRHOD7PKcwMMZXiFjMEynevfiR1q03IASainDgxKrJU1mH1+MjnbNaNkjhTVCnWtalFyrvdV1QKDmHta2FK2rpTlMrqz/KPq7s4MDBMW5/KH8iLEXrbbc6e43LttmxhuRzz0JlfLrPslaNNNrOH0eGaJpN20XmqjOREpP9FDVSlXK9CaMCmi5QhHb68P67+hJ7OgcWk8lZwVy/FbTR6I0LZLvGzW+vj3uT7UdIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiODiVRqoyNI315AHF6+5L0vEtJZJ1xkcoA9ko9VrBc=;
 b=at1Zka+k+jS+JizzoHhAJ/Rw0Apjpvk9xfQcKW+IoF8Aka+IdhLvSjdYB60nhQAnGL+ocBPz97g3U0Z44qZUTTShMEH5Bp04UNngnVf56w//vmplWSAxz9x1oiRZ94as+YCs6rcqV1yOgb3ioHiCfYDW9HqEGOvlf8ztbQXJTFk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7846.namprd04.prod.outlook.com (2603:10b6:8:39::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 12:11:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:11:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Topic: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Index: AQHZy/J3Glbz+YK/PUq03CAsK7LAl6/pjh0AgANPcwA=
Date:   Wed, 16 Aug 2023 12:11:05 +0000
Message-ID: <3zmxxrhmcpn2ogavpuropzmqbhwzqtgurkgx7cgpws3rt7qq4n@guspsox5d73u>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
 <149f023e-e4f4-3b36-56d5-e2d0f486439f@grimberg.me>
In-Reply-To: <149f023e-e4f4-3b36-56d5-e2d0f486439f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7846:EE_
x-ms-office365-filtering-correlation-id: 967b6910-ec00-45bc-6569-08db9e51ddcc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lwm2L8rnatFL/iIJ3QkALHNi9/klshStMkbK71jtuXSSUBk5w+g9C1EYjzIwW5ztLu8wDqaEdKXT4DUiaXmDM/q4O6Giv9YuecMBjonJQ7q9o4FgjBblqCswz+AUzB9phxCYZ6cAbIIrE1oeQzgFk0F+BSV8JYSjd96d7/3XPxl2IG0VajvYFaWfEJG51Yy+o2ubEA+xXq8q/s6UMsYaeR7tT1y9k+OqOuVienIiYuQqei1WxnMZUwIx2DARrFDgkuVzyUKZY7xjHnUykAdGiBfeqU/ffC/TeBHntNDxlllncHiDz90/VbZS2yik0/Ke0+RMqQAmewuExqeMCG1pYtR3dbUznd+B7PygzThENTDGQT7ea1DXX5XzZ/rybtP7qx/oEEirCYaf2d9Tk6C3CpugzZ1IiUBtlnLOrg1rHHag4vtFYoRttOQtuwHWzlAOW3wLT5zE6iIMjX8TUlez8T65WLqRbHoYDqdYCWyqfEydrmPdijUG1A55zIxUXcnS9F573ODrzXwGjbn514qCLg7MKDaQEfkc0yt9aTKMscwxqDTbV+mBB1TEWVHHTRVOg2dU4OQ8+ZOR2uuMPnCxmKh1tq2qOGmCNRJXQlgidi8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(33716001)(86362001)(8936002)(4326008)(8676002)(5660300002)(4744005)(2906002)(41300700001)(26005)(6486002)(6506007)(71200400001)(44832011)(6512007)(9686003)(122000001)(91956017)(316002)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(82960400001)(6916009)(76116006)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LAFxBDx1nriqMR9tlY/ppKY/VmtZpq1ksN+Xhdg8BvLdAB9mB1k4W2Qo9mvu?=
 =?us-ascii?Q?6qoCYqu53Pq3zMg7YexZ+/7Wg/OdJdsqinh8jW9rgubm4OqW8Dk33pHSKH8c?=
 =?us-ascii?Q?qcwzUcZsoseH0NV6je7q6laAboynFxsl+m44EPKRFneFpAXTlyd/ukgu+Ecw?=
 =?us-ascii?Q?VkGnfRAq0roqbcOcsA/owoVPHwnei7k2xNRkmTMuBJ0yjMgH1qTQqLuA5i1k?=
 =?us-ascii?Q?kTtlogvxuhxLAUZ4bJfipBpp9Vn9goNpxkNCZNZ3Z32CzFVaofArf9S2OYNt?=
 =?us-ascii?Q?enMcCYJIqG0JHaHhynO2O70VQ8Fbz/GAelxG+KJuKdQN/tRSEMNAjgOUPnml?=
 =?us-ascii?Q?LdaG5aDh8n148NxLtp0pL+wNaPcVyLVXR2g/Vt9vFUBiT/fcAYD8FUvDAlGq?=
 =?us-ascii?Q?oZOCogVTRM6oMREAwWjBjIDWLiWUuz711tirCOPHhcmvyp2reqZzbj0vDcW/?=
 =?us-ascii?Q?faJY+aoQwrdOMKogvm6Q7Vqe5oOlYeUud+is+0yWDmVYXgr1Y0xJz76GTTTC?=
 =?us-ascii?Q?qQewRxc/z9Ukn/d16T7jFlTp5n52PlQjOkl/Z4hHVmbau+jY9Kz5xTgOcB9Z?=
 =?us-ascii?Q?PxSKmJ3wRt7o4kBJwxogrRemj6Syd1w1YVHyvcn53ebIKRBq3Q/iZbern6zF?=
 =?us-ascii?Q?45gK6OxHhc0yFLSJG98uCN4kFKACdRb4mvbXzefCcRyR73Gcbg5GMd+mVMVF?=
 =?us-ascii?Q?HzRfUr02YSbaLIW/Z0MXXbCmmLu0wJcIi8j2/SR57bHb63/jGCukEU+Xhe92?=
 =?us-ascii?Q?8cE6wdqMSezWhsD1K0mi9eQ8l6Ee9zuGC7Bp6j8ZcXk99Jvzf726mG7FGHdD?=
 =?us-ascii?Q?jtCIN5/waOHvhwVQ0mjvpOtIsO6cjFqxD4J+jXqZausZwAZzq0SxsuPhor3C?=
 =?us-ascii?Q?ioVuPGaqhr1UcVqwBa9+txh+SVErqp/4kPx+DnJgvsYPOz+GTkeOzOKjp6Xr?=
 =?us-ascii?Q?Siqb+ct8rjfmZfzaez+SgCuvZx1CdF2jtxlGEC1aLWAVxcFgK49hz87kYZp0?=
 =?us-ascii?Q?YraX9qMh5Sf85rYibuNbsWUFQmDvcDhPMe5OzGlxGRaxjpDCqLCZXAKs0UCk?=
 =?us-ascii?Q?qL8+1eRkLF/8Ojm5VVoIqvm3YteP4VukvNGSzWjDjNzjoiA7i6PjoBY2kFCd?=
 =?us-ascii?Q?ryMglgoyuRQ+ThRzKL4sYsd86o9zne07Tej4garNSQigVSv0Ertho3mqYYQT?=
 =?us-ascii?Q?Wfok43qhjHFVKyD895q9VMYTSKx73AN7YAZZQ6v/Tgho8i9QgqxHqsIdXrBL?=
 =?us-ascii?Q?yht38yGuYYj9bG6rUK9CqFpHcXeguWoA0+ulPbOYsE0cNzncf8r0L5ntUPct?=
 =?us-ascii?Q?ii5KIWvMg2LOxRndTKjBrQpKeu+zDWbvU0c6Kx5s/dS8/HGMNldLC22PZOOy?=
 =?us-ascii?Q?esWYG0oVccs1xWkeCurEZuEw6ZRm7cl97q7UaLtX8voxC356cRqHpxdDfN24?=
 =?us-ascii?Q?IHrgWS0uuEkcPhTE2ne6A4e9G2kYaIqqke9drRCOXuqAXCik8+OH1EUpGlq5?=
 =?us-ascii?Q?4Vl3uQkCwMylxusYqnk3tk35+rYg6mU+3QeUZ7T7gVU5MOV3SxwHlDwuRxsX?=
 =?us-ascii?Q?6yMc8jcasuTBIu3o6fJBTQjVDEK94qQRliTfyvGW8kmguuvlEP7V2VGfGwrK?=
 =?us-ascii?Q?fSfgW9+6D/3XwSxdxDnwZGg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97F4C6C38046E64CB7523D59C3AB20B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6EBUQIdlEvEBuaC2bxHj1RLi92Nxgs7mCfrBc0l0vZxzWYjYb3x3zcBB0jb7?=
 =?us-ascii?Q?ogNMP8zGjX5nHEOdvq3NtiFSIZ5ZOlzCVtlbSc4XOpJfd/3AOb/UqZn3BZGa?=
 =?us-ascii?Q?qZZvlrN5V2ZBT9uJRbyjxqXiZ9ebHgtg5JVfdbQTP2Iak7Zf38sO3wPAGPqE?=
 =?us-ascii?Q?yu5tniXc82VeOKCW0ewvDGsSJoL6ol89EjuTbKbqVwK/ywObmVrWSIiLCLCL?=
 =?us-ascii?Q?P6r2Vh5+gTtBi83txXSKdjXfYD2CErDaGNT43E0grqc8menf20Rk9XAFGNw2?=
 =?us-ascii?Q?nw4fZpHutcLZmtl+J5cbCAtS+30i8rXhyGpWDX0Ukkk/zOMvDX1YLSZ6eYSM?=
 =?us-ascii?Q?UuJfBN0ABjJIjj3U7rEYiDrcAv3hYmxToU1d2KsbgtgxGY30AJ1bOGqHCHhr?=
 =?us-ascii?Q?oDRfJykOqKl++iQmuLSKUvxYjvM99X7ClD8QLd8VDtLNLMHMmWSktIGzr71R?=
 =?us-ascii?Q?gg5VPN0ho5kddn/+u15jSHYD5r4mlI4lR/T41WhzzModKi0Bwk3MaPgmsW6g?=
 =?us-ascii?Q?UxPOnfcQBfQdUML/ebhcP2lCpkH5lkQ0e7enSFRZHSpdlQSPQj2FfjCBeDqy?=
 =?us-ascii?Q?4ByKAFhftEBCOPrAhMtBIk5iUGVhFOwjK7TC2W3OpSIE0tHz2hUdObLQ5Z3u?=
 =?us-ascii?Q?6Q7z7Khs/otzUhh0iNyhi0XUq0tNxHk/CVk/LlTU8l4GuOeIOrb8rQQaSRlU?=
 =?us-ascii?Q?PS/AlNlHXTF394E7BsubSZ2yk5t6HO0r6jP8HujmQpUWT/Ms29b3JtnvCY6t?=
 =?us-ascii?Q?sLgu7Li0aUnR7tVIFzQwv6U1eNLViXUIPKJl7mUypZsh8WP6tX315Z1/8kcX?=
 =?us-ascii?Q?AwRqQp7H+CEZ9ovwWghdxBJbPCts7sz0uK89uNHOxgwB4XzduyJYIm9ImfF2?=
 =?us-ascii?Q?NLUEc6KFwhTUYRbEjukX06S+YdYw3jWe5nMlRz9ZzP9+y2A6lWFWzZdBWNUO?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967b6910-ec00-45bc-6569-08db9e51ddcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:11:05.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06hAAAnkRoNKNm/oAbfu02Znv8L1n2lDnnoepOlEleucqgR/BTQl6gS6N5M/855/10MBcYKvo7VgK1EPccjN3d1rABl1cXtYMyNdVWjxEEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7846
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 14, 2023 / 12:37, Sagi Grimberg wrote:
>=20
> > The helper function _nvme_connect_subsys() creates a nvme device. It ma=
y
> > take some time after the function call until the device gets ready for
> > I/O. So it is expected that the test cases call _find_nvme_dev() after
> > _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> > the created device, and it also waits for uuid and wwid sysfs attribute=
s
> > of the created device get ready. This wait works as the wait for the
> > device I/O readiness.
>=20
> Shouldn't this call udevadm --settle or something?

Ah, it will be more stable to add "udevadm settle" before the readiness che=
ck.
Will add it.=
