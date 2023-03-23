Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA3EC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 11:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCWLHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCWLHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 07:07:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D32F7B9
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679569616; x=1711105616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G84IBXodexAL0XO0zT6heIYpnGUy+nVdyYI/kTigWxI=;
  b=fHZz30shCQqYLIIGKhRAnde4amQfJGW7zytxHJKzqO3OfmXNi3VCq3BJ
   9JSLcVJosvPEuXrNrdSNg3jKYUUCXuy3NP2DAIFgHIzUaCxCPxTW24TDF
   kTdRx1fNAbzt4aqfRBKeIZeCCLAVGstpkYVno5150lKywmkz1KHIOBnyy
   tB00VfkUMCgJR+UBs3OICUO+nL501aoDCGV2yQPbDpqq7Y9AYTTXJ7EoE
   MeD9WY+b6eGDHg9i/LjzUhtMyOuyIjIPrfsTom4l9mS4KqVr6e4DzhnHj
   cvL/np+08SengzQ0g0NnKCCGW3XA8rqtBIcGyUibxl24SXYuyCa9OOqdE
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="338377340"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 19:06:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2F+Nz86PNK6cUJv94uW6t+pmn4AwEbll3OjVtJOFsghy01nto945pUZ3kUk0M60jIPX4SLqF4YyQcc3v57o76nHrm508i5AeOt+PsXfZpMtAdbW5FqqTB6UQHFoYFi/uzfsNiaFiDuuKt/PaOtyYhomD/VtDQDmiUVQE+4VD2d+V1ddsGutjtHrTzw8bbkqKdpWapG0nLRQyir76aDBJ+zuR7naGAqW85iV2z1Q8GX3XwFs0lBQ1T7lBbmQn99NjP/rPUwzjtRsTFIVWBHBZ4fFF7/7/c/N8JJukUqi5ArIQeQ0L4UwmTigSEE1pHNB5PPZO+i9jjfR8EcycXdcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0kfEvmGyMiJLkBaAAcJPuvcI4FJfQoUFcChdlK/UY8=;
 b=dsiHTU8dZxpRe8WcRYsjv/FMty6F4bG7KhbTZh+aMy2hWAzz8XrZHlKg1nKHcmT0hSZjoKhmSG09em28GNQoppgv9Bj5Y6zSfH+V1S7KodFMm8B0liZUt5UzhDopNGMhaaFxwmU0qxUockEy1dPoht55gaz7skH7u7OyhpzJQmj6W5tqLt4vqQ6KEIkkHcnit/yKhZf4hl8khzLD8Z3bwgSVs35BJWx1ZlDoo3GbxLEvW2gUqYS72+AYXA6YC9xzHcYnv3vjb5sxgSNgPrg+yg5FWgKitKCN72d0EdziXO9DJYAXt1i7vxTDVrytQk9ytkzv0/b/b1xQTH+9w5ihsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0kfEvmGyMiJLkBaAAcJPuvcI4FJfQoUFcChdlK/UY8=;
 b=VQjYWgo+w1mt7D5L5r4lZOFZn9GXoC5oQJSSZvtj7MHG3Hrf7xwPwkizQX9qfeN1vW4d2S+sH03O7265eDFFB5Mo+xoLyb5khJP2jCFtOg9mA3deOIIbNz/ts7dzAZTddq81b/8sg0FCVjPfFlDeKipQx2pZ3qi22YeyQ2GaohM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7316.namprd04.prod.outlook.com (2603:10b6:303:7e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 11:06:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:06:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Thread-Topic: [PATCH blktests v2 0/3] Test different queue counts
Thread-Index: AQHZXKdwdyBttNI5FUu+ySjKvJyL+68INdSA
Date:   Thu, 23 Mar 2023 11:06:53 +0000
Message-ID: <20230323110651.fdblmaj4fac2x5qh@shindev>
References: <20230322101648.31514-1-dwagner@suse.de>
In-Reply-To: <20230322101648.31514-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7316:EE_
x-ms-office365-filtering-correlation-id: 82fe6a5f-1cff-441a-0343-08db2b8eb55c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ue5XwqmpqpU0QiTDjo87Vg6wqJObIBVtzAM5+RSnwovEHN1cPLo5pePq3wovq99Z6dAUA1zxgSZ3C1cH4WisKypYP5nyCotnnpQ4W9hTD2zBpFCVgUQ2eQktCZKyklFGKy3saLOjnqW1MJ3d+yNw3NccODYoc8mVOzHqqEnlKOGVuFiZrJeJb71rejwCEt3eQAJoJy5vdKeAJ6zVYvaCRXjcZDgsZudpByqyn0hXPiEARS04GQKBrfqXjnqlFTlhF6FhCiH4yIQ0Y33B3E2he0qJq24pkXS55TEexdDQA/rLjnNByN+RqYs6m4WcPBN6UEs6Aey7RjmR8ik6edmb1Df5JRq2NjLNcC0y33ZOV3D/c6M2upT9/T2CKNhzXeK/Umkj+naApG0+uOae9jS7ptsN9+ln0mTvmEfwyAOpX+g3pOvHGytJVpspvuNK+CBZYAU8zjX4b89lA+Hd09TGP0kCwB2AYUjYXIRx+KUhMOIq+ZU9iiAxDZF1JkogGeKgv55J4V2y8F6B+/nkiUEjD/Q5+Az202hjIJBJ8ONAVTbU9L/OnR1GA6aagsRie9PyeNJzgnfhnWQOQjlutApB1fbkTu8fMQgSL+9pdStfkzKGl9fsfO3Aed0AW+sG/KXkgKQICu1tQgmCfOfnj/Gi3abKGiWl/A/5XlfKb+RqMp5PtswF0wNFRVw1gTieg3y7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(38100700002)(38070700005)(2906002)(83380400001)(71200400001)(478600001)(6486002)(966005)(9686003)(186003)(86362001)(33716001)(316002)(54906003)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(4326008)(6916009)(76116006)(8936002)(1076003)(26005)(6512007)(6506007)(44832011)(5660300002)(122000001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DwSaRsvOz5buyfMiix0zkpH3XqaQIy0nmavBusxbxcAgak3yUwtNLk7kf/zW?=
 =?us-ascii?Q?PqObzMDFB/kUqJq0H7Zqmdvltty5UJwzxSh3+pUlFQER0gB2+LFiuPStrlm+?=
 =?us-ascii?Q?2z7s3E1JGjB8TeUnpkbdOzfs6EpxNZraN508c4RkHwK0/u2xlRQFB3q1zSKh?=
 =?us-ascii?Q?7y1zi0/Nc4H8gTHZ6foei6bLin+Sn2M+EptR9YzSsgsP/063su/aE0k6KV/b?=
 =?us-ascii?Q?lUtsWz9qIimheKChPRMbMeCYLPvHGz/QUOWZlxoObkzgNqJyKDX8dpY4uyaC?=
 =?us-ascii?Q?vJ/R5+Q9J/i/cwLxsfxvvitkC8daeAJk8ZPZ/jiC2g+zoScy2l52fw3DvesO?=
 =?us-ascii?Q?+clKvdiEAqL3M/a6bkZKXAR/OzsOFu21C2hRKGtkwVYE5Uyu+wXahxnrv6yh?=
 =?us-ascii?Q?lI0h1f/hGWGiNVmr71ilJjb6nZu4As5XecbQj4PGGr2VjB70KG9S2rLTEsfz?=
 =?us-ascii?Q?c8XWSJlE8r7qCpeO0AjMW6R/e8gvkPQNOn5myhZ2MmOU/eQkrd600WvpXcxq?=
 =?us-ascii?Q?tNIajkdPhTxfpweX0qE3mrU+/PUcQG0fcuu4UQoyAFhHbb3ehWADvhrbJafn?=
 =?us-ascii?Q?Be0Pg6fZHOxssdSofCNcjholza291lrS7XMdUpvvOrlB1RWo5735e+GKNfkV?=
 =?us-ascii?Q?DmF89vMjTNlOmYcJ4PQubxt804IQSlFAjEe/DqCgNOVjfhiyqZC8yGbyqmsH?=
 =?us-ascii?Q?0FhS+/Q8TPwBuswKfSiyqwLJePQttJnbGOQY0r5L8vB97PBrLfdAVtMeFc1p?=
 =?us-ascii?Q?uMuM5j5Y9mn+JXSoPss761LA2gCJbg2e9/XFCGZjMki1jaIYo93hqAXBZOkx?=
 =?us-ascii?Q?imuZyYTQPXdO9qI7Vljwww/39LGkji9shavUFJN6gLbpMxam1IJFyOTF459J?=
 =?us-ascii?Q?JVTCkRiIybmrIeBnT0ZGyZIHdAOH8ZOO9FDxtVdICv8whFAHwqt7o6wxEJPv?=
 =?us-ascii?Q?hx/PmZthBO1Jyrfwk/WAawlJnF2fhau6DHM9mWk7v/QVwPMeqJsI4PC3jy6J?=
 =?us-ascii?Q?bMRUtg7rorz24ASIMjrZjCZYO3QpFWdCVw/O/40KP8X+ChOhVJGmkDz+ZC6p?=
 =?us-ascii?Q?EIv4LNySV9iA25X/x65tG/L2fClTgTx8hWkboPYygZBnb3AMZ1EovNeK3IEV?=
 =?us-ascii?Q?cPkNhN191Q3MbbAJAj4136pnbp1/F/mMVD4NzrjwGLJdAovtK458ZWAMyImr?=
 =?us-ascii?Q?PHk8S2LCnX0X2RpP0JSZBijwefbaviTPkzyz0IEWpm47W5MrJJkLmwveWw4C?=
 =?us-ascii?Q?NrwHl3OPkyYfJ0993sOechJmjfPkdHgXxbNAwLS/F0RLq/dbPWzzu43lRO2s?=
 =?us-ascii?Q?Q8E80zTjfKWBbRbSEUYnPf2ovKgq1eJOqjn5UGvJgUNa5Sc5RnIxTsF/56Cq?=
 =?us-ascii?Q?50n+0nTbWUy47/Gzb9DVvL4lO2e8kpI3p2Alq9m9lhzKGaMnJkAqCn4iSluF?=
 =?us-ascii?Q?W/81S6mUBbGxx5tImkT+KUHfZ2bH9pXzX3NRuC5kVnO+lwlfB+r8wf9pFN5T?=
 =?us-ascii?Q?B50TNwjNtn/csoFRtliH1AB3dORL1A0aT0ciss3lqbjnKbeC4VVy6x+D3acV?=
 =?us-ascii?Q?Bcqg+quPXixR6RbWyxW5BjvOes+OXWUC81dXTboppICdmxUPt95m99jvfM6U?=
 =?us-ascii?Q?sFNW35tCoIBcApPpk4gWiJ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39D5353BD77D9D4891E4185E78D8C60F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bFu3Zitx+VYag08fjk4otm4PEpuqNWAL/EzU7TXOvWa8q1bH2/9n5SI97HaJM8bd+RxXgtdRuztlSqIFNJWo4gpr5Wm4NxAlfHr6e3rQLvt1l/Eq2dsIbAS4WyqX/EOHkqaaPjQUgWmvl/FhX8iBser58V6UDy/tu+GH+ateEys8CddaIEuQOp1+leF8EiFMgHV2mxXFYFQc3BlvkMZ0mvIzjPaXerHfs4+Rk0823SXCwWlINFe4B5bXyFLTr0E+LkG868p7pBrcwFVXICKbD6w20ofdsYYF9ISat3+ggKH+rP/HjBKyA6HEAXGEpILyAVxXQM9Ldcx8Rx5fmc1i85H8XAfxK/SA5PhKk0/9xRq+FICIC3EBcdPwv1ZSRfKFzhXzaOJIE4c2JHVQl+gS2ikJzwBbb+JaBqx5NyXq4ZYPfORhE9KwR94a79vITOxP/eFxrSXeJ8SJvmTqLX2s8THRP8GqCfh03+zgL9ggDK3UVUH3iYKK5blrA80B6RNUHlU21yLPyNyGUJIMZoioHO0OkxYBG65ufr8829cGvvjfexLEZZes2uhjcvLeXhkBKUBnVm2HL3WTaRdRYZCw+xFZ4tGN+DrlyLwRlmLF7CPLS1A4KrJw9qbNOeGk/BsmiylBO95a62GiH+49mqfenQZGp28W+bxVpj+Yz+BaOPewfp/0L2DVnIpG3t7le/fUSQB5hhT4UeWl3WWiWGtMDdCrTj8oaekWY3OkGamIMClPk5SWBFTDCjl9J9sBddS4VlAX6V/hpLA5n8S74fag/1xshe8D2Sc5IQARMvX/aim2X0ueMmTSDjceRJTkYfj4EIw2XiykyYye1ibpTCO0tpzMkh+8kPErxfGquHxRTqsLfbko7ExBDk3jPRWLg7az
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fe6a5f-1cff-441a-0343-08db2b8eb55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:06:53.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOCb9rfyxR8znTSOccPVSFl6J5mK1Ka0Ozx0MMJrwT0DYKpsgi0KV8JlvWxJZFBYAYLGxTm0vsz5a4gFvkA7TC+aDkH75I2sT31kHqHqDFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7316
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 22, 2023 / 11:16, Daniel Wagner wrote:
> Setup different queues, e.g. read and poll queues.
>=20
> There is still the problem that _require_nvme_trtype_is_fabrics also incl=
udes
> the loop transport which has no support for different queue types.
>=20
> See also https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbus=
ch@meta.com/

Hi Daniel, thanks for the patches. The new test case catches some bugs. Loo=
ks
valuable.

I ran the test case using various nvme_trtype on kernel v6.2 and v6.3-rc3, =
and
observed hangs. I applied the 3rd patch in the link above on top of v6.3-rc=
3 and
confirmed the hang disappears. I would like to wait for the kernel fix patc=
h
delivered to upstream, before adding this test case to blktests master.

When I ran the test case without setting nvme_trtype, kernel reported messa=
ges
below:

[  199.621431][ T1001] nvme_fabrics: invalid parameter 'nr_write_queues=3D%=
d'
[  201.271200][ T1030] nvme_fabrics: invalid parameter 'nr_write_queues=3D%=
d'
[  201.272155][ T1030] nvme_fabrics: invalid parameter 'nr_poll_queues=3D%d=
'

Is it useful to run the test case with default nvme_trtype=3Dloop?

--=20
Shin'ichiro Kawasaki=
