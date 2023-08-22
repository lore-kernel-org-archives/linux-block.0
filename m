Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41DAEE4996
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 03:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjHVDty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Aug 2023 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHVDtx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 23:49:53 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE4186
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692676190; x=1724212190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rckpc3CFB9e4bzpKDo3NlrmFknSFn7WgzJccbjYInDA=;
  b=aeswBDe0DGlMlNWUSZ+j7JSHY17/VU/Bav6iJIydh7RNLRfjWnZks01d
   7oKEuPPHY0SiH2nYu/e2y5QiBS/VGcZAg4U7+NLg3KcSH56jIj02sNk9V
   zT5mZa3s51WElWOKDIf7sPSfVEhOqfi+vp41fzEcrykr8EwvuYUJeBY51
   MdWZEcD5TSLHH5lNJcqg27ifojLITMmvNEYjid8ZDZlmrXgBL61RgI5C4
   SQeOTx2hfApRO5QpfJqlmiFagZWtiIyQ9nApK3nxOfZIbw6F0iLZpVlG6
   bm/Poa/2EWzj8fHrdx1cqLGZbeCsP/4G9pRdQw/G+7LG0dtcmT/Q47yic
   w==;
X-IronPort-AV: E=Sophos;i="6.01,191,1684771200"; 
   d="scan'208";a="242090588"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 11:49:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERNwdq9eojBJiEjFZ2yzAFkmCAho9lGMVbXbLVEIXNdKR/gUHgFS+e5EAC1oIEvXnW9BKCn4hmY24LGwzzVQl5yyGlA6U5jWRaH4GWJ7d5hGd4LmtXuNcymOSclN79yjl2OcpCmN5hUOIjbIMXFgL+KxEB7dApN6b6xBLKFnoWJ2FFUgkkgQ1w55Nf5eT0QjQ6M3mIftuTn4FIWaaqwmwaIio8XPoMdY5Qcw1xVKq6qk63XqdOqX9iJVupC8UH+QH9G0vV6x7puNJu+dW/TkzZtBtouDZ0as+QPlGtTd85WXfmtqzluSDyDAeMbkIcfEW6KeG9yA44YUsTHq89se6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rckpc3CFB9e4bzpKDo3NlrmFknSFn7WgzJccbjYInDA=;
 b=NiLqXwtCNDcC8Ga6pV0S2WGJ2caPHqxAVnXNEXtX/ozcO9lgmhJXS7pmGB/huGaRDu6MOl4iuxZGaeVUyF9ZH+K6c+jdfn3BmU4IaaXdRrHGzs3VnttRArcG4HG0b90itGS40cFALoWLQotoBI+Yj/mFdN5SROpm+ip1NLJebAwm7lHb3qr4nz5yoRcSb62S0GPgDK35jNKeMcyenXBpyJ/EWjNuIZYTDrSNbl1RjXAXykbXlTR824gnHCCaH/fwjWGukm3F2GJyTfeG34yXepWQh1zIUPFPmUUj0sjwU+jD/UUI3/ac31PYh6FKeW40o+epOuB82QyGSEfNth1MPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rckpc3CFB9e4bzpKDo3NlrmFknSFn7WgzJccbjYInDA=;
 b=dRJB5oi2vxGGgNXnc7Dtp6vPQxiI3o5EGXTAvvMU3I5lzVhH9vzGkJEzsGS6HdC+PJxUo+YkZImebZeTfwBfI/AT3aZLiZl5NeRR20tZlEK9cSBlMDrHGT4nGEu83OR3INvvjs46VlxyUsxKl2R6cUdTpYMsBwnYDEbdIHIbjnU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB8192.namprd04.prod.outlook.com (2603:10b6:408:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Tue, 22 Aug
 2023 03:49:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 03:49:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Thread-Topic: [PATCH blktests v3 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Thread-Index: AQHZ0Y4wNWMY+2F98EKZHuEV5VJm+q/vv8gAgAX0a4A=
Date:   Tue, 22 Aug 2023 03:49:47 +0000
Message-ID: <jpo6k4plsg5one3r5kaogg3ieucxfc5ha4r75tsbr7uamzpucp@dd5jwwerz24i>
References: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
 <mgfm3zji6qpuohc2hxfhttu3dmrj74ytmx5wfkloj23le6zcg7@gorhk6oekqln>
In-Reply-To: <mgfm3zji6qpuohc2hxfhttu3dmrj74ytmx5wfkloj23le6zcg7@gorhk6oekqln>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB8192:EE_
x-ms-office365-filtering-correlation-id: 24512593-0f3a-4545-29e7-08dba2c2d454
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvewY06KVglByIL1b5xewKxw2pjtqxIeTUjbxxMhQ2GEClliJSbGbiPYmX6h9XQ+G0DwyIR1mh+JItU+OYXjIOjLC/5NJ11n/LjMsy3SMV6hDOM/FO+xPo0ZNkN4Arm5h2KDAH5sxtzGi6cNtPmgtK2BAOp8m7uTMJHanc13Vf54c2zESEnwa4BA2Wn1khp3UB2y9EaCIAWIvOwdugDpgGrODExEQd9QSEihDmwZL41vFidTiJY0GHDp/EXXH14wuMeNTM2ao2sYRazN4vK5klSa3x/srTF2v/SE0n15FYLJ095iq907+aHPfKUH49neYFHFFjytL0XZxcbfwJa5jwKSdlBllQaiR7tW1NQ3e9t9KZsDzoRXU+MDjXGcKEafGkfKdkc+CDyu/kYtW/IsEZNGv533JLRX5msW5j0zil3I06yTYiBN3A5DQl2/wcXXhzFMSugGYVUz7RWA1ZJfpwPy5HccZYiUHuPNOZ1pnCdcjBMFu94Og7/yfRi26zIDYFGThcqbO1xzKLum9mSnxQMe04fjq0NoVpIuxd3Pd1x33ehOpXia4Zz5axhn7HF9okP6EnuE8bi1R6WHMr3o/2mxnqV/xlb6xbqx27VePeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(83380400001)(6486002)(38100700002)(6506007)(5660300002)(44832011)(26005)(86362001)(38070700005)(8676002)(8936002)(4326008)(66946007)(316002)(6916009)(9686003)(6512007)(66446008)(66556008)(76116006)(64756008)(54906003)(66476007)(91956017)(82960400001)(966005)(478600001)(122000001)(71200400001)(41300700001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tNNF4kmhX1CpQOL0fCpgcXd4QDPcedHuH/xu0vqw8w++3BmcJ/gwGy7eiE6a?=
 =?us-ascii?Q?OvD8hlCLIH9+++IX1n0Wvsj+n/qPnmIuRdJQN5d0dp+A7WClUW+eWWA1O5Zq?=
 =?us-ascii?Q?+gDBsObqZXjc9Ek29jhBZc/URrDOzr5UgE3TqTIftM1ujp+t0sEkYS2XBCfS?=
 =?us-ascii?Q?p23z+iNoiZjpUGuV+kSPnyR2d021UaCQ/QYqoimOzB3dF83rm6Epb7pwB+8q?=
 =?us-ascii?Q?NRnefmfl0c6t4wqF3vYVtbmfahSfpruyF/px7O0fnUHYIMLrLw+LROZa0RzK?=
 =?us-ascii?Q?LT1VjM5nFZ8BDCcH2CmNvK++1pLrbu9Ei4bvMJ9PAQIFg4MjgiNYAzbPYrma?=
 =?us-ascii?Q?0wgn1NDkUG+uDkAT552p1Z48nOfCj+IDZuJlu7hJWaIApP1cfwacTJb51Gk0?=
 =?us-ascii?Q?jVJDY6Ah65MKkBqefH/LPZaXRDeWyrFo3j5wJhIWV9oe+NM/jJGvkZaabPxv?=
 =?us-ascii?Q?9Km5RYzLzNuVxwIaUYCHgyIRP4IbN/aRlE5HdbWBEn8aGLdgeRu6d8jblTwI?=
 =?us-ascii?Q?/RojN0RDdNLnOANtKPN4DFXUSvfdp/mGalqWb681f5tBUnppf3BSf1NsTGKT?=
 =?us-ascii?Q?tZ8qFmIsF8oE5br6GVwhuKn+bhecZw8+3FQUsk6LDrZcX9C2C/jMUrRq53AH?=
 =?us-ascii?Q?5/Zig5xoO/hoqZC1MTeV1rqLvoAvEPNGlAQfv7wndMlrXSxLaAYCYePvbq88?=
 =?us-ascii?Q?QZB0N96tkrEWnqEzgG1gOyayKlxQt9xj0/c5mh9ySng+iIYjMVUcbPd2EyGf?=
 =?us-ascii?Q?xBNyJcRgFuq8s7pY+xl1EBrnfXe8b9NJoO1ancjPPpvZQeL2K3bQ+C6LQIUa?=
 =?us-ascii?Q?XoIgtPjKVxexukJsZbtYOHUQi8dXb1d8yIs9FXQiVb09qYtiIcGRorhFhtkq?=
 =?us-ascii?Q?zfD8HbEneOEMHupXXAYdA0PP+LpYdJPEiwgKTTe4hIUgaNHcaZSyqnOleNP/?=
 =?us-ascii?Q?yHlDCRALu6x+/UNMfEBabOUStkGaYpVfg7OOr63Oe6cK933wL6u3cnzPX8+6?=
 =?us-ascii?Q?+fOlIt1X2GuSh5Z4JmGrLyL+28utuyXiIENXcOcTAybZSM9vOfuUUg2bUFAt?=
 =?us-ascii?Q?Md6yhwPi5+4zAsXlp2scok1yAiKCsEu9c+X3L/G6cdLEuVksV9oVONmAfADx?=
 =?us-ascii?Q?rFzp6n7yM10PJnCY1bpz54dREdALbiBK7i5LB48DZApVDEkzvDR23J5tQx24?=
 =?us-ascii?Q?0iHO0ihBb4sX3dLmQ8GUys08in6M0BtwrgkADyrN2PxoJ0ERuNomCLo+emws?=
 =?us-ascii?Q?38nE066tlOQVR2i3cqR5QeWsH6v7PAIKwgkskyJqYUADlDEEKccvKXuMiUI+?=
 =?us-ascii?Q?/WEvTiYiesp3Ifyfy8abvHWFeLUdJ6Tjvbrq9o8o3GNoLxObXzmOSGDN0kw4?=
 =?us-ascii?Q?wFr00wBULcCHooiVIXCic9Jz8JHUi+ue5g1paPE7Ys1WbQZ9JwPZE9vwg3D4?=
 =?us-ascii?Q?xbJIQGFLBg85tamxFAcz/NOkVRaAKY75U2vEoAyV3mdbhV3u2+37Ljz4sJWv?=
 =?us-ascii?Q?++if7xvKCttQjplKD33rhHFcgQ7e0PKYonCePMgeY58HpoaBgcoJto8XTxpN?=
 =?us-ascii?Q?4IymtFUMi0i4GLNQcDH8hxm+gV1pQqjmwUyBsHPW91SHJ2CWK5MWQLCGx753?=
 =?us-ascii?Q?XpRc/tJTKvgQQroAZgyhXRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AD21691A8797C4C88F060AF05DE7325@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NbsGCOgviOvykITrs2G48KXM3R8rX+++ewgJcQQZyYoFYdjS5ZIh5Nz555tB?=
 =?us-ascii?Q?jw3SRk0qE/8iMCF63jLNz+92EtCX7+y2ncO4UIaFOpuOmH5C1gcrhwomVNZT?=
 =?us-ascii?Q?ablY39ME0J1Q7WgA4A1KvvrZrSFNMJAf9T/dVcFO9r4yXZ3w/lrWsjm3J3v8?=
 =?us-ascii?Q?VdPumSrLjw4rGsmPkVHvdYSsAgy0A77L+2DqOfySDGza26qz0byvR6LRVasg?=
 =?us-ascii?Q?SwZbOFIcghRj7RRiT9eZW5IN4dTspbkdpZRnE/DTPUKGOvTZsKlCPX2T23zv?=
 =?us-ascii?Q?Z+8QlWxJ1P+xygjKK0ElW02qpArdXu+70ycKyQdYYyYwPxnJ6N7N/hQliifJ?=
 =?us-ascii?Q?11a2qMcN7z2zUgShGKSefxWkqojH7+nKIPu9Dl24f7RX7l8hy/F58/SRWe/h?=
 =?us-ascii?Q?WC5bSkGyCjeFf6lx60XoN6SKGpng2oMv85dy9XGD4+qtzmWXc0GlTRsEVVe1?=
 =?us-ascii?Q?zHJgbYzLFFu3KIgD8adgJNAvBJFKK9S83VsVIVCZj1Iv0hiHui3e5q+9yaY4?=
 =?us-ascii?Q?tSWQklApaA+cAUqZqLNg6Vdzqj25ju8wm7y3GSnkiixNQLymMTceKWMzlbLk?=
 =?us-ascii?Q?+iYo3DNYwrJVzYlp5Z/umSuM3NJKuILRkocfUL9r1acwTjUKwJSI/gAmwSBM?=
 =?us-ascii?Q?DIO3IjypLwtH05ngzz3G88wwCzfFFHIeopFLjbmJn7HJizoomICUDefI5wxc?=
 =?us-ascii?Q?mAUsch/whTYkr6/TuGPefJsVr5cmggkCjZTZkBCdK8nI2/ySGEVoqVLT45DL?=
 =?us-ascii?Q?LE4p9TLMiwFoj9PEv5U6skqm3y07LvXxt29nAjM2z3/P58k2vuLEZj9y9gh/?=
 =?us-ascii?Q?Vqxw0eg61C4PCWUIHgptuigWKD/pD1Nt5DBU89fsQqiUyw3TRXxbLZ9dWiJN?=
 =?us-ascii?Q?IHomWZZkm3RIUB3G+QIzmv/cHkJJodEWo8Ighz27mAomIdesUAzkx/26U1Tj?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24512593-0f3a-4545-29e7-08dba2c2d454
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 03:49:47.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWTbOXjE02lO5LVakwI2MoA2xb0PC8iqwAj4dim7u5AnCv/LVcg6v/7vbbuMo1la20F83OTcBD1Eu3rwOboFA68ckQU2xxqmCW/FnL2ecNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8192
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 18, 2023 / 10:53, Daniel Wagner wrote:
> On Fri, Aug 18, 2023 at 01:40:56PM +0900, Shin'ichiro Kawasaki wrote:
> > The helper function _nvme_connect_subsys() creates a nvme device. It ma=
y
> > take some time after the function call until the device gets ready for
> > I/O. So it is expected that the test cases call _find_nvme_dev() after
> > _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> > the created device, and it also waits for uuid and wwid sysfs attribute=
s
> > of the created device get ready. This wait works as the wait for the
> > device I/O readiness.
> >=20
> > However, this wait by _find_nvme_dev() has two problems. The first
> > problem is missing call of _find_nvme_dev(). The test case nvme/047
> > calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
> > for the first _nvme_connect_subsys() call. This causes too early I/O to
> > the device with tcp transport [1]. Fix this by moving the wait for the
> > device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
> > add --no-wait option to _nvme_connect_subsys(). It allows to skip the
> > wait in _nvmet_passthru_target_connect() which has its own wait for
> > device readiness.
> >=20
> > The second problem is wrong paths for the sysfs attributes. The paths
> > do not include namespace index, so the check for the attributes always
> > fail. Still _find_nvme_dev() does 1 second wait and allows the device
> > get ready for I/O in most cases, but this is not intended behavior.
> > Fix this by checking sysfs paths with the namespace index. Get list of
> > namespace indices for the sub-system and do the check for all indices.
> >=20
> > On top of the checks for sysfs attributes, add 'udevadm settle' and a
> > check for the created device file. These ensures that the create device
> > is ready for I/O.
> >=20
> > [1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRY=
C-ienAZz+sa7az1RK77w@mail.gmail.com/
> >=20
> > Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> just a minor nitpick but feel free to add:
>=20
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks for the comment. I've applied this with the suggested change.=
