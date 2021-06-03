Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00543C47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 11:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7295613F1
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 11:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFCLWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 07:22:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37776 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCLWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 07:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622719236; x=1654255236;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u2lKt9E1NWmRNe4M1/yrpm5KsR427MY37UrDc7+QvPY=;
  b=XbfXPxFcczx6KpC1Mcs2xzicv84s6UHYNoaVaIbBIdBpznf4oBvehonW
   no76mLltcsbBYfHxhIygGT1LqHo6twVlFEUTmemSBnnw1jKs7uD4mhW03
   eCY/RFZahy4ovdlX0netvkMFjtduKpjhgldA2C6vw80gOXkNnrGIXudp+
   K/hSwKcL5UlftRdEHXGfwmQ2W/I64BD3pv622uNv4iysFeuzP6Rz1HfUb
   JxJEehxj9ofMKVozRlYHPhQ/apH6gNHGBtfUGaL0nRy2SvXjqMFYgEfX/
   R7pJY+xtDbW8RTkkzdvOBHxFlPgb9IDu0G0uA/YsiAsXy3D8twJTZhhvg
   A==;
IronPort-SDR: mN1om72qfw/G6tZ1wRO/vCBJiycSAL68GYIk7N+HNnBdq4D0EbrK1pnWNPl7NmcFpmwDnQoa+H
 VvmO8N2IcFzLtORoC9aJEnavZHK/b3kZTbm2CbE5ZwlTmE1TEYhlMVBleAl/qD2KZeQesJp54J
 CuvHOUu6Laj4WVWHawGRKRy5782rdyUDA+73KlgNN43NdTIlthxnEaaj6nk7ef84GFELSBkHLd
 NQ1G+QM2lZLQDHh5FILlsvDUEJRVNc5VqbFBWE3XynOgE7UljIlK5UBlB5BltGguRX4fKIXcBj
 PMk=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; 
   d="scan'208";a="175300344"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 19:20:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScKzS3ytlsCnnL1qqS2gjxT98k/OonRkoko0ZyssUzrWpqgn6/LTUyMezfpkrtq0yn4xbWQAxbcVe3Wi0Xy1c0F2dOFGzaXFbmHVMsQAqsXE6xj6K6eh4kMzJSerIcXoSSvguFK9HAAFxaHkyGI5mrGcWVaHSbhApyCPsW0ZJPI7IrUbYg68ZLYMp+bd9dKPqiv83KbzwW/lGUAXCzIt2Bl2gXNu88yaVVzkcTzP3XFqEgt3MoNg+mK1fZMPyavN0tkoOwICnb9Pk+tAODco9EqSMa3y3/iLNyjIBkWlh05Hk/Fc4Picq3GBQO0O3imciMnnlNXFy3lcyJ35gZTQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2lKt9E1NWmRNe4M1/yrpm5KsR427MY37UrDc7+QvPY=;
 b=ATg8hxdtQeDiaa/kNNu3a9HAav55hMhc3xmT0OLuE5DmipctTPUEnt1JoqefHFgvMPztLwguQQS/jThK0ILMI7OlSeux72soXsqcnQVVxI3xxBmQrrxsZqRHZC6HcvyDg3hpA7jJCsFWvvmtXz3a+/Ypv75IA7biPtG7hqyiuV07gR+B+18rDsj/WLWuT6hs9bMXurj4nUk1EpPAgXyy1SHIbXmWOymBxklwKXRRJ7yuLsEVgH2kPJGbwPN04OdDdvibbKS0CiUPkkmJOCUC1qnXs0y/uoLRTFvXEKVI0nl7q/oR0sPQ6kvBj727sbuh8gPArZDbZtysY8JPFc9fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2lKt9E1NWmRNe4M1/yrpm5KsR427MY37UrDc7+QvPY=;
 b=PKxkFKt5s+DiYbOmwESqsYkBG527ixlJjkRxtzlXORx0J0ywTDo/I4gA9Q/Cn5QuTSDUCmFctcZD/Ef67/bKuMmqdaHumtF2M4cJBZVBQayvett8GNJaEdOlD5OwHj/rjbbj2Uc2iMOd66vUZY/x6/ykYX3E7z5ihOejNB1sYg0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0812.namprd04.prod.outlook.com (2603:10b6:3:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 11:20:33 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.035; Thu, 3 Jun 2021
 11:20:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Topic: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Index: AQHXViSI8g5t53fJ2UqQanQJze0fFQ==
Date:   Thu, 3 Jun 2021 11:20:33 +0000
Message-ID: <DM6PR04MB708127C72BDC03B446997DACE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
 <20210603095117.GU31483@twin.jikos.cz>
 <DM6PR04MB7081B69E31BB7ADDF02E2D9BE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210603100436.GV31483@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:467:7587:9599:cace]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9735adb-1e02-41e8-e3a4-08d926819a77
x-ms-traffictypediagnostic: DM5PR04MB0812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB08127D93B99662EED6DEB054E73C9@DM5PR04MB0812.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 490uLlDslQC/wnMq1pY42PMLcpYFJ8QoZGok2T5+ooi796/U6IgTcNxTEQhIwvDPaqxqBH45Txr5bR5YVCZLli6EoZZpWF+i5TRQFM60CBur1MLtFOtSa752Y2lbOF2GaT4io7oe3RfKcma1Vyns4ZjY1z2uknKivpWzE62v4xJKNcf0RaiXVZZHPD9MHccwtmvvZ/4KiBC7PZsg0mENOnnSBm5ytKm6YJQNIgVnz9FMwLpdKcAByj3XcriWLHLdK5ZbaM/ZaGuDDQ1KISxKLtUCnbvEGFSyB/BjsSS7v1JAYRGVr0xaHzrBN2y2KvXhK0vULCGQrhHoFTY3+FgqaWNP+NECZk7181x9DBjaSAApVoCoAP1sD2OFOCYCVO36vgdTimL4AZEh9wK85/oM92kv9sNHtqjloCYLUSF3Zzde/f0NF5uM9tXPulLsaGS1uFg897v+wvz6eu4xf4Gl5KiGuWA5StJqy30zE8wnhQ8FkndLWxTcdg8JWhRY2mUsIRhkJAcdYNqz8JiwgRXHAgD/s8YPX/ZWnnJ1lNpZwV5bMuxZvAC6bztw3Xn/f1PDepyMlE6u2+lwXvNxrCOUsYZA2jbp719xDxZxsXBtvPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(5660300002)(86362001)(53546011)(7696005)(71200400001)(55016002)(52536014)(6506007)(9686003)(38100700002)(122000001)(8936002)(8676002)(6916009)(478600001)(4326008)(66476007)(66556008)(64756008)(66446008)(2906002)(91956017)(76116006)(316002)(83380400001)(54906003)(66946007)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Nx4odCKdxwMdenSiqhUd9IxDOIKMSGf5oTcR/uM/22dZ5J9gHFDyaCo2UgNQ?=
 =?us-ascii?Q?5eBj7rrXt6lxy1CkSbKK98sLSu5iw4Kaa6SuGi/zinHIwTPyJjw7ZrNcNXW2?=
 =?us-ascii?Q?VauDLOKj5XfAsNAzQVcZQzbzW/jhVyuneQcRzMgU5ynqTrV4xsZqiI+9rszN?=
 =?us-ascii?Q?zMZn01UQdRIq3KF1b2Rf1z6T17tm8fs7g1ubZtr+5rNZej1yoPdln0/4Qow2?=
 =?us-ascii?Q?NnTiBsuxUW17U6SIDEx5JrR5/yLpC7IfWCnWX4n3WInXWx2ZZdUB9sVgX8Dz?=
 =?us-ascii?Q?OLviwfwESn2Bqk21/p3ZTnX+BEgZRmNA3NntZHjZ/dRQJbEV8ckEuc8EWmCr?=
 =?us-ascii?Q?4oN214s9x28C4NhkgOI8ng8pSO18PhMxtcwY7aGH9XbxpEvFsW23t4PiNe1m?=
 =?us-ascii?Q?YVuFlohZOThsI/w7JnkgUn5fjuYgoieWK0t7ERiOOf7BvPZOJXIooMAjsZ5P?=
 =?us-ascii?Q?oyrRuM7IGGkoW6zGHI+5KZvLKeo81bkrEKlvaaDA2lndlvyWdc5UB5CjsIUT?=
 =?us-ascii?Q?9AcOS/6efcf+c9PX2P7bHveLfKc3GWPQ/7G4lH1zsTHogsQ2cC+YIANcf2Vk?=
 =?us-ascii?Q?cZ0BuPe9lQFmO3L+W4YelWPzKaIIJHpaWAkO2FRt8I3tEJiVB6kGjsnk+1Pu?=
 =?us-ascii?Q?9uk+94AZc4nIGgDdmjWyK5Ulh2M/6N/Q0gKCnmGNCfKCyDq4EGY8eqdj4wEF?=
 =?us-ascii?Q?lwQOlNbBCwQmCvVSsPGFuvUGwtxj3cZkzpknGDM7xdj3Yn/S8jal3x/b34Zu?=
 =?us-ascii?Q?gAfFK3xFs0jPgkNiui0b1GRBE18mOabJgnr3IQd6fYez7iumUlMnBg2EaooC?=
 =?us-ascii?Q?37y2fAk4nblWJ8Xbp/0FFo95FUh2AMmy4I3vrODr9QAwnaG6GdCBruP+jDmx?=
 =?us-ascii?Q?2JT+1nqQNUo4ODsjKwExLTdI8w885Yo3PqozhBE6dc9uopn561DNwmyBWSEg?=
 =?us-ascii?Q?Xd6h/YrGbD8v5ZBIbMRZDDOKbFeFNjJBSxD0csmcqAjSF18RpTdUpSNzTpot?=
 =?us-ascii?Q?rCDXkYfRJYw6OGDjXSNXPAvJbAryRJ2qPJszaS/fGrdpm/rvnjKzulnaovBE?=
 =?us-ascii?Q?O2IoFl8t5K0W43J0nY0xOEyZIyBTS9bY7WN7zxEAzqYoRXnvkK7nZo88n5bk?=
 =?us-ascii?Q?oIQcnmTsu+a6El8tZytgZL8Wp3x/0INer//Cib90GL1jV9Et0wQ+wxT8Fhk/?=
 =?us-ascii?Q?WaJTS9zBxQwdO2bitRfCtymwIbIGA1gHZ4HF83A0JrC/Z1i2e28VSE+9w/VU?=
 =?us-ascii?Q?Tuz672KTeoWjD6V0174c56rMNJIdqXo+r29X/k1vNnGUIdjPFMuE33hRQg3x?=
 =?us-ascii?Q?SRA2RrO2WlMEKDuEU4GYaovFJQqzC3a/Qy3NiIZXcw/0Aw3gq/zsJZ2++7rW?=
 =?us-ascii?Q?58kh2GgLu+8v0AKUp+rcbcjMHIjx/Pt9y0IzJmk4X3PBL107ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9735adb-1e02-41e8-e3a4-08d926819a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 11:20:33.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/upN7Q7N6IAATa/XJeZsj6z/ahLhEX1qxhY3jExMS81VJzsq/RBcwJZo0WRWj1aL1nP9qBZENb4rx97hnvwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0812
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/03 19:07, David Sterba wrote:=0A=
> On Thu, Jun 03, 2021 at 10:00:08AM +0000, Damien Le Moal wrote:=0A=
>> On 2021/06/03 18:54, David Sterba wrote:=0A=
>>> On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:=0A=
>>>> From: Niklas Cassel <niklas.cassel@wdc.com>=0A=
>>>>=0A=
>>>> Performing a BLKREPORTZONE operation should be allowed under the same=
=0A=
>>>> permissions as read(). (read() does not require CAP_SYS_ADMIN).=0A=
>>>>=0A=
>>>> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd wa=
s=0A=
>>>> successfully opened with FMODE_READ. This way BLKREPORTZONE will match=
=0A=
>>>> the access control requirement of read().=0A=
>>>=0A=
>>> Does this mean that a process that does not have read nor write access=
=0A=
>>> to the device itself (blocks) is capable of reading the zone=0A=
>>> information? Eg. some monitoring tool.=0A=
>>=0A=
>> With this change, to do a report zones, the process will only need to ha=
ve read=0A=
>> access to the device. And if it has read access, it also means that it c=
an read=0A=
>> the zones content.=0A=
> =0A=
> Ok, so this is a bit restricting. The zone information is like block=0A=
> device metadata, comparing it to a file that has permissionx 0600 I can=
=0A=
> see the all the stat info (name, tiemstamps) but can't read the data.=0A=
> =0A=
> But as the ioctl work, it needs a file descriptor and there's probably=0A=
> no way to separate the permissions to read blocks and just the metadata.=
=0A=
> For a monitoring/reporting tool this would be useful. Eg. for btrfs it=0A=
> could be part of filesystem status overview regarding full or near-full=
=0A=
> zones and emitting an early warning or poking some service to start the=
=0A=
> reclaim.=0A=
=0A=
You lost me... the change is less restrictive than before because the proce=
ss=0A=
does not need SYS_CAP_ADMIN anymore. The block device file open is untouche=
d, no=0A=
change. So whatever process could open it before, will still be able to do =
so as=0A=
is. More processes will be able to do report zones with the change. That is=
 all=0A=
really that changes, so I do not see what potentially breaks, nor how this =
may=0A=
prevent writing some monitoring tool. Whoever can open the block device fil=
e has=0A=
FMODE_READ rights, no ? Am I missing something here ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
