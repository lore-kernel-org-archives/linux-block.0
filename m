Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CEC47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 23:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A71613E7
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 23:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCXpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:45:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13811 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXpz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 19:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622763850; x=1654299850;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O8rzw12Dy/6UYFms8wpDb6WOlpbE0yMOM0fTNCWkF5s=;
  b=GA2E2UbMfR92emUHOTTiMLdZLx/9qIYgHo/LK6Zjrvn9dqgAVYZpeF6R
   Ja8BdaJ3RMFQV5Kjq6sHq0pT+/YadjYm4VERSAx9r1W1w5LViMp/uGNW2
   dEXry0JSeyVzpAFm+OKSMik9rFKmSWkKRF9+dFgYCMh/FUGBRhJvKbW2f
   7rd2NoZrc2nNRiykCd1SWKZ4Y3wDYhd70sAkOpLNZRVReBL3jzpJkfhQA
   vKXsAw82GTaiMWkeQoKCLI7Cs5RExL1XJiN5F58oUSEUHyPl4BcBMwmEZ
   D+cb6y8HyHNZGQEkCSrsBumO4n7+S1KywmQIf1mPI3TemdJ3frmjbpHXU
   A==;
IronPort-SDR: B48ETwZcstXe6yd6saTBZwl3dWTg8pTmXvjIMEkWpu5Y5AqbHiJmXqzQt/0lOEoTVaL5m9cDbh
 psKY6ICZvK5FYIGaa1KSIRvG3pvr4qbfeJ/n7S99664D75CFmC2R5+1OVxyFACUYc62GFO13c5
 KbcSRtu8RuazbdSddaUv/sJkLjO5tsaQgHnykAQX21XQMLQ9FcM/1V3BqNyhVVFizpiDsQIw3+
 rzUpmlD4QRAEaRPeikL5gisL1vupsECHEb16uy+ZfM7PQp5/EZLcYPC6UUyqh0WseTknYu9leh
 rzk=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="169944091"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2021 07:44:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrdGactCFxm0guwmWNWl0sPbiq2x3x06tKuG7QxnlJSC4ECrbcRO5B5xN1v3RfJD092ez4uLYmZLPBNR2cIDMzDwZhOEhubIeOGeyau7+erO0IHr085ngbCR7PLwpN7dgZ9AFUD9lgu22OLogrjpGAHGxc+s1bYbN0dIKw33olFYS9UrdgZnuPsi1DZfSqaaWfMDUidVp9pwbj1pDoICjpiQQER4gGqIdimDDoL8tzSQYjlkPwLwNCs+7Yo6IOxwWi3fcSVemJGUokxgjUoKRqkgbrPwgL53v+hTbxOUBoP+x6KDCJ30hnfOnvlYScNpRnZ3o1X6I/wAOha4+AN0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHm9H5zrJkh0Phm0VPmuzCRhI0hV37jtTxTlE4Lb9kw=;
 b=jYtkkhqMHAf74BsAKcfhzXRMSqULoQEPkmTlTiMqs6/NbCmXu4U3UUGUBzXfTm2hzRpLNQVmImtDyI0/gECukrcFGM6fQ5Vd6Qrh1m/CXJ65mz2GRrTsl58RoocEioqxAAftpZ16PCSZEU5Xc007FhaqMPUcNppdgo+f0qxF8HseJTxk091OxU9V2Qb2rh9qZKmeRt303/oruXT5bylezmNJQoxJim11mlPnhYVM8SsDA+uvTAEfxGO0vtQd4HICtNCmA9z88Z34H2paJGvW5qYI0xB6QvD022huULRHE/E/o0nswVNAcdpaaYx0I1QPPuFCxsnHv0eusFjyuKXWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHm9H5zrJkh0Phm0VPmuzCRhI0hV37jtTxTlE4Lb9kw=;
 b=VOGjBReuoRc0gw9W/LacUvYDGj57eA1pnGp8nS3Mys51/CTq6WcjWmG1GfIwRPpqjGLL9nbLPORHzzlnHv2RnTrNJo9eXW6GtpvHE9GAblzc6gkewAJoqxCn3wMSQAE9xKo3EWPxuqeAFOf67p1VQQbpC3Mgz/rP92z9B2qQtqE=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5882.namprd04.prod.outlook.com (2603:10b6:5:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 23:44:07 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.035; Thu, 3 Jun 2021
 23:44:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 00/11] dm: Improve zoned block device support
Thread-Topic: [PATCH v5 00/11] dm: Improve zoned block device support
Thread-Index: AQHXUaxyAuyK4c4Z+0yqEP2QqnaCJA==
Date:   Thu, 3 Jun 2021 23:44:07 +0000
Message-ID: <DM6PR04MB708128C3992978EFFF638851E73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <DM6PR04MB708146E418BF65FC2F7847E3E73E9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YLfO168QXfAWJ9dn@redhat.com>
 <a972018e-781b-c0f8-d18a-168c3d1fe963@kernel.dk>
 <YLlUzX18P0V2lAek@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9bc:fd30:41b8:96f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3d4ab50-db1d-46d8-5884-08d926e97a6e
x-ms-traffictypediagnostic: DM6PR04MB5882:
x-microsoft-antispam-prvs: <DM6PR04MB58826E013CC7ABFA2452E15BE73C9@DM6PR04MB5882.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uzyqrwzTeyGQFy6FuT2kvWpezCP8gSsZ67xVmCCgDrs1NHpTfilgkCQ/yTBlDDzYQsjxB29V/1Nc0Xh238L0siV739pq8IjYBp1UAlVwZZm0bmW1aGADOzWg15VopzWrab9x+nKW5dcOuDMSX7PubkcalDCjeM29ALLIHVtvtbwN1SQ059bkXDNlFybiid6//1QPrfIyvxL5p/DJJyB5+Wecu9shaTfErbkHRlMrOQv4OUofMRN48BoPtksL/xTiroKXAdp5jL/5vvNhGKd527/HADD80gQ5Ca3eEjfqjoXhICEFb2DuuQC+z2NerGGxERSBlQN6JXfab+1b/jH9cTmEzjvxBlHL0PYznvqjuiCqLfJgHooqaI3RIuKsdATrml9Plg74MreS5CQ/I/HX3auzQsplcsWM5kaExwusLhamwz3aGQqCAY6s5hdds/48nSVvKdAV+hqbPCOvByxh2yea/25kY9/RtSMGzua/r3ft/v6JrcS3kS3zaPF8Ssbf85fZLALwp1z6GsijzImZ29HI7GoeH0u/+BobfQjqWE2oTj8uIyl52UvQGPnrWyC8q1/2JxVQNu8JmHuyh/qjQ2wNogCewb0vWsz4ZVxJ3QoHS/+aYLfreys2qKAGKY435sGfazxyiAlpk/wewp3EyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(366004)(9686003)(66946007)(66556008)(5660300002)(316002)(8936002)(76116006)(66446008)(86362001)(6506007)(54906003)(122000001)(53546011)(91956017)(7696005)(83380400001)(4326008)(52536014)(186003)(38100700002)(478600001)(2906002)(55016002)(64756008)(8676002)(66476007)(110136005)(71200400001)(33656002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z7QUuBB4oj2MmlonGVymdDobFEfz8Sxi2HJApbsVvUBzniJWDrb0iBOsmezc?=
 =?us-ascii?Q?I6fsNg3tewq7stQx3UP8wOkhMfPswH1JBUMV2wYkLw+dcKtgY9dy+3UboE1i?=
 =?us-ascii?Q?Anv1QvWMP+Mj8KgVJ0r9OGeK4kpHci8oNlSmp9XT3KJp0rIo+KS3LW59jtjV?=
 =?us-ascii?Q?XvvbQjnHXqOEW6QlqDdGaZoP1krJy4YuRzzJS4pjJvkRF1ZrRMumE1zRexk0?=
 =?us-ascii?Q?AfgAnez4fFqy49M8eT8SDfplPSocvzvdQVjOOeU0289O944rqLOurskybUSL?=
 =?us-ascii?Q?/Woz4lzSCEp6zswtVsTCxXchoFJrfwIirWFsf4kU0CadccJM6Rt6KSQnql5Z?=
 =?us-ascii?Q?3PfZbsrbFkS8P5mGyWM6SXKHAcMo43phZbLFgUMr2+N1StRE2oyGl5xZ9tGl?=
 =?us-ascii?Q?sZjANmOWAc+MMqh1T/tVuur8I2W4KuJcHSa8LzlEmspTeS8t1T8TUYVG3JPJ?=
 =?us-ascii?Q?zE1gVWJMZSkkkh6efdQdWdeof9+2eA17RfhYE3SXfQP6AUs4adS20jJtFZ2P?=
 =?us-ascii?Q?YJoShM7Te0ZbJV7pq2bfU5dstRs6V93RSkg/guXFD+MTR5YESwKvfHOAqOna?=
 =?us-ascii?Q?QGPU3I4VRz75MIRhFyrhkzWOBIVfT/x8OljIHwJMekAiK/3rrpfuVZVQ50om?=
 =?us-ascii?Q?0k9Y93vNiBShJXyVBTpOF1XKuzyZtJZWC3fxl3itWs34UpU73EUPkLaUS5hm?=
 =?us-ascii?Q?tSMIlHruUHJIAohGVFpxmelSR3o7GosDoSUOURR31GoQWBjNek7foYYZ+gO5?=
 =?us-ascii?Q?19WA6gmahjSn/ZSEMiROZFOT5/O6vnAl6ZgJUnwSw4ZRdi239E1TUCKYkzw0?=
 =?us-ascii?Q?S3uoI+2NamF7Z1EQgmScAVf9UYDFim2qBv4Ahx+CIlwlMMLMySd21cFpR9lO?=
 =?us-ascii?Q?UT4m2SYGMMDZp4tBRf6/TkREy0YfI4NHGIdYlMdpOGDAS0mgldheSfy0zaQa?=
 =?us-ascii?Q?DVRhhMHkfOgsQsb+uTaM2P1i8iNosEtVvvbgrIMj9XxbzTn7+jGlSPDRz0l2?=
 =?us-ascii?Q?KL6N8/TYX2/N94yXjjwkbEHsEDl06/Z8sP4vUzm8cL1noX7GvQID0nsP2d91?=
 =?us-ascii?Q?4BU2zBFAmS+WQ+3f7LbLZy63/KIBGwAJwpjOZ0m7O49vFKM64MjLUvBJhdjh?=
 =?us-ascii?Q?odyCqBpeZoDa3ybBNX7iBQXdxNeAoYQa96JmwEwz3Q2/gW/+hFVxz/Rmq5Zd?=
 =?us-ascii?Q?oJA0riiKK2n2LlLFSttlqIS5zMlowF4TX0UhuTb/jy4lZ0npjhk3UkmoQzJh?=
 =?us-ascii?Q?p/eIA09O/WsEU73JsuYE8BceVOuyzRL9s80/smt03mM/vIXYARERW9R8sM+o?=
 =?us-ascii?Q?pxUaSq13JwSiSTpUQj7Dz2mSIODK/R/f3OcARCNoYRBcY2DcxLYSIzhNIh/g?=
 =?us-ascii?Q?XuAhbG6iKDDhruhAq8mTXTn5HMbTPuISOvUHc67YkiTfr3zXlA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d4ab50-db1d-46d8-5884-08d926e97a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 23:44:07.1838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60J4YF0Xgks+ASGgRE6j1SYVxz1SV89GylZpVSUtHZwljuJPk/vF/+LWJLLFnN/YrgKkvs4oFINwuQne2Ze9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5882
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/04 7:16, Mike Snitzer wrote:=0A=
> On Thu, Jun 03 2021 at  1:46P -0400,=0A=
> Jens Axboe <axboe@kernel.dk> wrote:=0A=
> =0A=
>> On 6/2/21 12:32 PM, Mike Snitzer wrote:=0A=
>>> On Tue, Jun 01 2021 at  6:57P -0400,=0A=
>>> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
>>>=0A=
>>>> On 2021/05/26 6:25, Damien Le Moal wrote:=0A=
>>>>> This series improve device mapper support for zoned block devices and=
=0A=
>>>>> of targets exposing a zoned device.=0A=
>>>>=0A=
>>>> Mike, Jens,=0A=
>>>>=0A=
>>>> Any feedback regarding this series ?=0A=
>>>>=0A=
>>>>>=0A=
>>>>> The first patch improve support for user requests to reset all zones =
of=0A=
>>>>> the target device. With the fix, such operation behave similarly to=
=0A=
>>>>> physical block devices implementation based on the single zone reset=
=0A=
>>>>> command with the ALL bit set.=0A=
>>>>>=0A=
>>>>> The following 2 patches are preparatory block layer patches.=0A=
>>>>>=0A=
>>>>> Patch 4 and 5 are 2 small fixes to DM core zoned block device support=
.=0A=
>>>>>=0A=
>>>>> Patch 6 reorganizes DM core code, moving conditionally defined zoned=
=0A=
>>>>> block device code into the new dm-zone.c file. This avoids sprinkly D=
M=0A=
>>>>> with zone related code defined under an #ifdef CONFIG_BLK_DEV_ZONED.=
=0A=
>>>>>=0A=
>>>>> Patch 7 improves DM zone report helper functions for target drivers.=
=0A=
>>>>>=0A=
>>>>> Patch 8 fixes a potential problem with BIO requeue on zoned target.=
=0A=
>>>>>=0A=
>>>>> Finally, patch 9 to 11 implement zone append emulation using regular=
=0A=
>>>>> writes for target drivers that cannot natively support this BIO type.=
=0A=
>>>>> The only target currently needing this emulation is dm-crypt. With th=
is=0A=
>>>>> change, a zoned dm-crypt device behaves exactly like a regular zoned=
=0A=
>>>>> block device, correctly executing user zone append BIOs.=0A=
>>>>>=0A=
>>>>> This series passes the following tests:=0A=
>>>>> 1) zonefs tests on top of dm-crypt with a zoned nullblk device=0A=
>>>>> 2) zonefs tests on top of dm-crypt+dm-linear with an SMR HDD=0A=
>>>>> 3) btrfs fstests on top of dm-crypt with zoned nullblk devices.=0A=
>>>>>=0A=
>>>>> Comments are as always welcome.=0A=
>>>=0A=
>>> I've picked up DM patches 4-8 because they didn't depend on the first=
=0A=
>>> 3 block patches.=0A=
>>>=0A=
>>> But I'm fine with picking up 1-3 if Jens provides his Acked-by.=0A=
>>> And then I can pickup the remaining DM patches 9-11.=0A=
>>=0A=
>> I'm fine with 1-3, you can add my Acked-by to those.=0A=
> =0A=
> Thanks, did so.=0A=
> =0A=
> Damien: I've staged this patchset in linux-next via the dm-5.14 branch of=
 linux-dm.git=0A=
=0A=
Thanks !=0A=
=0A=
> Might look at optimizing the fast-path of __map_bio further, e.g. this=0A=
> leaves something to be desired considering how niche this all is:=0A=
> =0A=
>         /*=0A=
>          * Check if the IO needs a special mapping due to zone append emu=
lation=0A=
>          * on zoned target. In this case, dm_zone_map_bio() calls the tar=
get=0A=
>          * map operation.=0A=
>          */=0A=
>         if (dm_emulate_zone_append(io->md))=0A=
>                 r =3D dm_zone_map_bio(tio);=0A=
>         else=0A=
>                 r =3D ti->type->map(ti, clone);=0A=
> =0A=
> Does it make sense to split out a new CONFIG_ that encapsulates legacy=0A=
> zoned devices?=0A=
=0A=
Well, the problem is that there are no "legacy" zoned devices: they all sup=
port=0A=
zone append commands, either natively (for zns and nullblk) or emulated in =
their=0A=
respective drivers (scsi sd for SMR drives). So I do not think that a new=
=0A=
CONFIG_XXX can be used.=0A=
=0A=
What we could do is have this conditional on either:=0A=
(1) the DM targets that need it: dm-crypt only for now (CONFIG_DM_CRYPT)=0A=
(2) Zone append command users: btrfs and zonefs only for now (CONFIG_FS_BTR=
FS=0A=
and CONFIG_FS_ZONEFS)=0A=
=0A=
(1) would be the nicest as we can keep this contained in DM and define some=
thing=0A=
in KConfig. However, given that most distros (if not all) enable dm-crypt, =
I am=0A=
not convinced this will do any good.=0A=
=0A=
Note that for the !CONFIG_BLK_DEV_ZONED case, the "if=0A=
(dm_emulate_zone_append(io->md))" is compiled out, resulting in the same co=
de as=0A=
without the emulation.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
