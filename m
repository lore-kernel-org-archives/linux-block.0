Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA70C433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988D661A06
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhCXM3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:29:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42827 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhCXM3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616588975; x=1648124975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p+Yv2bejqJWDDq2E5UtILekJsMPzTQVeV1cI6Z0Obc8=;
  b=IKJPi0ZZS/g5Y7Q+PSzz0W/7c4C2N71Zm3I5OOu1O6m/Zxzrhvu5Y8t4
   gCYR0YjU0Og6vrHQ9ql6uJ/O7VQGiBrsfTbpxVPNlhjppShbVDpDQOVyi
   BEihsyZkpxqj/gfFrpQIN/5u4PAn2FZNJXqSZZIjf9/cRJ9axFOHrZnJy
   opQ1OKx744Ic5UEQreQl1IWc2rJg0rdOPh/Vj3L7O/zhvqErLRkz26VyY
   Ou8gJoPMVJ7U5DLuvqiKRamf+AGYkDbL3csTYiJLf/5eE8SiyS5yFxgnR
   jD+00FI+aX6EVsZimbDWw7glf2uJdBVMe70hZ/4DRDlcWT/w3J46QT9Wz
   w==;
IronPort-SDR: SdzcflUZzGUi5fnNSeOiP6II+oDGZDS0slKNlCVLbIXkxw+/gQKMczQVSsLm7e5v0lXYJTG9GO
 3fOa5LFprlJdTDHkEW8CayVrdTkjgofGGY/Id6W7Fdwg8edFn5bKwvRLKGghVxRXnzXnHANL0o
 rLhHg6TRBiZDlw2b7dpktxPIhKX1/ub+0f7eJaHFByP18UrYSGkU2eXaymjZ96tLZ2EkKBpVV+
 FIhYr5nZ+Th4/aIhEACRj0zO1U0tV1WaVFraYdEWUdnyJ7Rzl/qRpgpN+ZwaCPEHIePC8a5hT+
 o1o=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="162841594"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 20:29:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7j2metj+TX+2ew1xZpGyMJXu+qdttWU5HnMK9vn6thFySZykHijzcD5dH97IZDbfzfxBOoZQob84VQME2QrC5ggC7aUHlok/twdCgJSsSlth7KhHi9y/JU2mCn+26aKzXHPfD/T7RUaJqg5yrDLvT3usatf8IcI/SLc6HY9/c/S/BorigBLqZs/pRoN7BAfq4XT1BOZ1ghHGPwQ19+uM7s1PJct7kEOboD+Vl/EY9MWavF87jQFoXWonSHwmBhuHhrCsYotmbHl6ad3+6Bb9MuB917Mr0mycr8Dcy20aYERBtCHERCB+opsd5eYlvcNUhqF1/XvUncjxLGPGYBigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJhJsCQjbEXs6ks24zDERPb9Qpzq0WKT/b236DxY3+Q=;
 b=dVMTjoryyi6Z2j2Bb5kYYi74hxEUvqNlppGhXUz3STLRgSueRAzTjmD5gJslWBGef6giwT9gQCy+UwgbPu1kPxGDVpjRWzJqlcrBIB97JfzQ4o6TCvpkoP9wvDCEqvjGJqCa5pOwj1BQUTiP+hd3wPMcNqoNCI+j932mVXjg5JVDWn5GmlHUJKzVEtEhPZDMync8ZtD6uXfqcVYBiXTmmpTgIxWYWScPpujYsGKhjw8GPu2DEFwFdRmzEAQyYABZ0BNyDqtjIq+JPywXuUDE66LslXyzF+ngZMtLyjl2E5IqIaBBfjCBU5q3SVikdztDrmwsR+b5r+SwW/NaklhaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJhJsCQjbEXs6ks24zDERPb9Qpzq0WKT/b236DxY3+Q=;
 b=QJTlfNdgcAx7zb2aUURUIVt35yPcBrx7PwwNi63051tMyBvqlRRWyNsh8AW/O8D5B22lh31bKeL4txRvc+ORAoH4XbhrKRDdY42wsrkpxMPkv2FRTp5EvPSkc1HU3LGpv7vLeHvkr6zj70kStquKULTzSvCeNp9ff6+S59+VR4Q=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM5PR04MB1210.namprd04.prod.outlook.com (2603:10b6:3:a3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 24 Mar 2021 12:29:33 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Wed, 24 Mar
 2021 12:29:33 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "javier@javigon.com" <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Thread-Topic: [PATCH V6 1/2] nvme: enable char device per namespace
Thread-Index: AQHXIKlX58TcqiDl90OEMALlWkZSkg==
Date:   Wed, 24 Mar 2021 12:29:32 +0000
Message-ID: <YFswq8pgzg9y00GO@x1-carbon.lan>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
In-Reply-To: <20210301192452.16770-2-javier.gonz@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd2648b2-361b-40b8-6193-08d8eec07a99
x-ms-traffictypediagnostic: DM5PR04MB1210:
x-microsoft-antispam-prvs: <DM5PR04MB12100EA557D793204434D114F2639@DM5PR04MB1210.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EUdrT6kJhjU001sWKnRzAZiMAm5UeSsX0rlzYBqDEYIPYLjLracQb5uZfjfF9irkowgj1S3AJfZzDS9oKcqI12pt9StkbBq/mo1x++2A3sRouaimMPnYn2CuYhKiygrjMSJPkayJz4JD6bzdu6hMKoV/2vKg71bCjgb4kE9p2DzTTlT/RTKMhb/3T0Vup12q5PMxKpaLAIArSY8ot3dqn8ye7zcfKcMe/9q3RqvNpYRFePcYq3YKuAYv12nwiWKoHXUt8zRdAaF8yHuktXESIkNjPp8dZmTvhF/4b1RWkPlY65osP9esek1eG3AoqiVCRMTH2Gy5U47QGFV/8Y5VlmQ+TbQqDnCKi5IrLnuO3jvANsFaC7Fc7Ztc57s5DkE4WxvLBkr1a2Y5WfJvk3c8j0MmxU8zngzy4wBUuBtt3LwTP+vwd/ITU7NhIWCUkkyqje7nUpNMFHcB9if7bFvpEW8/piMom2yNz+KvMdvkp3Z+zV+SHHqOUXa33RxQVt7DfUlTayPE9I00cMvQFjncS/KtR8F4bveWDAFfVefdcTk3qkCZ1L98yCW00xB/XY8lsAbV7AabzgI4lNKYd35DlNbNuuWrxHCQ4Z643ZfxkkxGoCRyqrQa8CS+2uWKteaOKEk17dVXfSUiw+4k902ZURE8U2F47vAE5nJG9chz7YYk9JRyNlHdoV5c3czDZJ/Cf3qxJebJPg5fbTQ0lSKAcInxhkb9ShySRqETwruZdoCc/gVR3zDFOBgUwTYsWdMK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(6506007)(83380400001)(66574015)(54906003)(9686003)(8936002)(4326008)(36756003)(316002)(6916009)(86362001)(71200400001)(26005)(5660300002)(91956017)(186003)(478600001)(66556008)(6512007)(66446008)(66476007)(66946007)(76116006)(6486002)(38100700001)(64756008)(2906002)(966005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+Dav/ppOeIqQZDqVBujDPcMc58WbgheabMUCSC60c2BB5EbHseRfuQNDaF?=
 =?iso-8859-1?Q?ap/3tDW2xD9xvVEHsHlfW//nzLUc2aVQ3eRB0xpVkR56cRNUj29ErOvtG4?=
 =?iso-8859-1?Q?RJa61iXlUJspUbj3EPbw17jOQ6+xpgHmQL8guTBc0AoWJc2F3Z2W8XMpsz?=
 =?iso-8859-1?Q?UDEgY2yjG5+4jM74o6VC2ISo7GUdMZg3mo168KN3I9fasBTtdA+ZIguGuM?=
 =?iso-8859-1?Q?RiyMqOfKaur4l6N5Nf2gas/Nftb53g007ZeSrfZUFJ9aZN7YHsoOWCrjaC?=
 =?iso-8859-1?Q?HwqNcppzjCzi9kQy/ydhQaq9hA3F1u8HN//qKAhgaTePxxhUQ1KIlmn5b5?=
 =?iso-8859-1?Q?GzBbhTLNsJTyll0FbF4nke9QgGcXHdET8viwzaCRRQG8PTYYBc8e2vGV5e?=
 =?iso-8859-1?Q?4v5cZovXKTIzFzem+6fI0is7woCkfxOwUCu1FGVF2N0ugB4DY2BfoYGjgS?=
 =?iso-8859-1?Q?WOOEJneg/IWft/qFK6PLUSZAT6BCtbF1MrgEQMBZ5kQHyVYaUtgizoAgus?=
 =?iso-8859-1?Q?trVqP9IkvRCed5CFB4CZXLFpBf7cr1+Oyd0mDJEcJNSu3B3cCgK+3PHTu+?=
 =?iso-8859-1?Q?HhS+DMSbs8xJerolgc+mp7s5o5pmiUS2kSXT917yMqNDlIujJmpuYHssjs?=
 =?iso-8859-1?Q?+S4EreRQY62y44Vjqa+dGJUqGyOif5YNE3Cx7WNhhZ+7JOph9sPhqiCumA?=
 =?iso-8859-1?Q?AEXPbVhSP36Eo9we8sCd99qZy679SdBEP01xPLi94kIOT17KesBdXEhQvW?=
 =?iso-8859-1?Q?jnaGDTt6nDSgJFRB9cjULbHxweBb0Q4ndKpIPnZ4KWPnwseKxAGme571MK?=
 =?iso-8859-1?Q?mDz1cSdeqOycfe/nz346cKpM0GUsnW403t8JipDllaF8U3dgVzksBkbr55?=
 =?iso-8859-1?Q?0oatVSlr7BfT6eFp/Qhog5G/SOo4oZ+poKx0xjfAptGInM2CmRxg5SA/A0?=
 =?iso-8859-1?Q?WQRVE4YHfrya4poxapCfFV1A/F+irlmqRLne+4Qms0BeB+tlSS+TQC9JRM?=
 =?iso-8859-1?Q?S78cmqcQUFQ449H40kUn9pRRju3wS7SctDJeHZx6O8VYoiArlWb0Bv0hVz?=
 =?iso-8859-1?Q?bPOqfYU2gKVk89Tq4vQ0MYNe/q6r4L+GfBuSCsY2ziGZTe0BGZ0ngnXFhc?=
 =?iso-8859-1?Q?49er3PUOtIuNzB/hIG2DxQzutzyU2ujPx4+m7FRkWTr2yBQriCv7IvoyiK?=
 =?iso-8859-1?Q?H5uDhm3qFSYjkShcmKVoGn4C7Z00HXQ2vAt3KpYasPj0Bc6piK+jzULnXJ?=
 =?iso-8859-1?Q?OpAX4uU3PQ5qtGFYTr4Zx2zMHR9a1jGhlIaSG9v+1AB7xiHUNZop4asnZW?=
 =?iso-8859-1?Q?LoGB49YniCBAvf6r9oXFRRuCMgPgwZBDpQIugfbYT+swa2qlx8e2pTmKqd?=
 =?iso-8859-1?Q?5G6pWFeocU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1FF09A8302B70A40AE6894F728CDDB33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2648b2-361b-40b8-6193-08d8eec07a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 12:29:32.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tM/HVrJK8qTb3kk+FTZmkHQk7fkY2XJ9EpyQI+dc/sE7E8sg87P+hKfNcyToBAhHrkWQhABAxiFkl3bqeGeXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1210
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>=20
> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether the features implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using the char device.
>=20
> The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> for multipath will follow.
>=20

Hello all,

Looking at the discussion that led up to the current design:
https://lore.kernel.org/linux-block/20201102185851.GA21349@lst.de/

Keith initially suggested:

a) Set up the existing controller character device with a generic
   disk-less request_queue to the IO queues accepting IO commands to
   arbitrary NSIDs.

However Christoph replied:

The problem with a) is that it can't be used to give users or groups
access to just one namespaces, so it causes a real access control
nightmare.

c) Each namespace gets its own character device, period.



However, testing this patch series out:

crw------- 1 root root 249,   0 Mar 24 11:32 /dev/nvme-generic-0c0n1
crw------- 1 root root 249,   1 Mar 24 11:32 /dev/nvme-generic-0c0n2
crw------- 1 root root 250,   0 Mar 24 11:32 /dev/nvme0
brw-rw---- 1 root disk 259,   1 Mar 24 11:32 /dev/nvme0n2

NSID1 has been rejected (because of ZNS ZOC, which kernel does not support)=
.

However, if I use the new char device for NSID1, but specify NSID2 to nvme-=
cli:

sudo nvme write-zeroes -s 0 -c 0 --namespace-id=3D2 /dev/nvme-generic-0c0n1

I was still allowed to write to NSID2:

sudo nvme zns report-zones -d 1 /dev/nvme0n2
SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: S=
EQWRITE_REQ   Attrs: 0x0

Should this really be allowed?

I was under the impression that Christoph's argument for implementing per
namespace char devices, was that you should be able to do access control.
Doesn't that mean that for the new char devices, we need to reject ioctls
that specify a nvme_passthru_cmd.nsid !=3D the NSID that the char device
represents?


Although, this is not really something new, as we already have the same
behavior when it comes ioctls and the block devices. Perhaps we want to
add the same verification there?

Regardless if we want to add a verification for block devices or not,
it just seemed to me that the whole argument for introducing new char
devices was to allow access control per namespace, which doesn't seem
to have been taken into account, but perhaps I'm missing something.


Kind regards,
Niklas=
