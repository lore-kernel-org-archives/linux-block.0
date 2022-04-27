Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01C1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 05:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiD0FLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 01:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245431AbiD0FLk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 01:11:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A16D38D
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651036108; x=1682572108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0T+96cD/C9xt1wVYLO6txszRs0NP+v8wg8iyC5uPtY8=;
  b=NnyrrNoR8iRYpi3a/XDoHg4WaKDXnu4CSTSSSYHuOxxnfnOxHqD86yY0
   4/yyYC3bnJAx5A2zMSSJ3eXjTxYOM8iRCCJAJPvnWuO9CEhdKzC1dyqfa
   EoTas946zQTRj+bnX0cz8ZA/4JPWC4u1rEBas1unEl10CvvoW617FwkLv
   kMWgqEhIhSUNAB5dFF05dcf5aYxJPAiDvk5p/OzT3Z//heXlYXlW+Gp1L
   7jDjCQFZnAsYNLXMj7CzNT8rfFE65YBiEKZTRjFoGeT78Ug9yJpWlCN9q
   ncR0GiyGroQi4jaQwXR/yVUByaOE0usDP3rdg5Tp5ZNiveEA2dSHM2rGP
   w==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="203793877"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 13:08:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMf0vlvtCKuKD2ePGkwzIRB7Z3qMhYjk3rD6poKX1BpDrhWn0FYi2hUn+L5YXAplZYaM1zRdu9AwY+VSIDFkT2UXq+aCPn0gMm92DSxO0DoQKRwbfzLtdolvkyGl8hqUU/vaUZ7kFQdeA8LK+GK4T2LXz6KwClXHX0n9HUIHrJhCAIhZJIbwjc/bUtRrvlITbgAEtVwEDvhrTgrgcIGQgS2t9YwRook/rNxBfy3Hjz6/9VMlSNn88Uc09TRagwocnurhrBwU73jvREaHWUWc+D1t5HI3KG4Dotf3sY1LpqX5ryipbzrU4Diu+5Cn/WCn33pjXTSP5n/IlLyICQbJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaFaY7JoelC55mcPW7iF8vooQJGqIKnSRkRhXlCsJKI=;
 b=druSP8/YoSgjWE0JTW/u3xSzHc7B4CZSD7RszCZc65y3fkdFP7FG1w/sUCMzKT3FhB+LmFtm3ImBbVh5a9o4VuutB3LpNtQnC/JDiRw1/npFG1cgSw5g3r/pYBIOivP7uuvW7Wld8CXeaoIFDVHVUISuvzTTHi+9pWcwBklr/7LMRKO9657UGTkHQ9VqusvblkdIcX/k6v3TCufgI6XVUG2V4N4VNrC124eHye3mk5ARs9G1J1YcWVhTQxiJaEvPSlhXe6g9UkXeNZeHhxR8iEIEJCs0FJQ5/J09EDKfHI3w90DLT3N1HNy4S9dgJ/mDRagoV6RWsE6TSev3UW2ePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaFaY7JoelC55mcPW7iF8vooQJGqIKnSRkRhXlCsJKI=;
 b=NYd0mfcXA/GmrTFFtxAahYs0clpaqfOURMZ2cxI8Sb8TlAtqOEIKAG5+VAwSb59enYW7psm5xBJ+Nx6RUH+fa5OPsEgzv8OfB/jQh1C6rSuKoIMEZjNXCjTD3L4mAwYCigAj4jq6cM9PQ9Lay5mm3RLOvGx3Qv2VoESwB+ZB81M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7774.namprd04.prod.outlook.com (2603:10b6:a03:303::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 05:08:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 05:08:25 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Klaus Jensen <its@irrelevant.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Thread-Topic: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Thread-Index: AQHYUEtZsx+sXkXjFUmYoV9Oexcksaz4VZuAgAJdDoCACJZlgA==
Date:   Wed, 27 Apr 2022 05:08:25 +0000
Message-ID: <20220427050825.rkn633nevijh3ux5@shindev>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
 <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
In-Reply-To: <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c01b93ef-d633-4f3f-5048-08da280bf5c2
x-ms-traffictypediagnostic: SJ0PR04MB7774:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB777463EBCC0F8E55C19B4FB1EDFA9@SJ0PR04MB7774.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hezsOfl82rCAmdtbUnpi5Zn/WsCq3O0SVVXj8TjCJkTQM3SDiUFmLyWGqmDIOXnk2zJFoT3PMKOqN98l/HDMBj6rSYdqN7f+1wQsqv/YhwHatZXIEVfl9nM4XlR2acPfFBtrwSMpThI3fHMb089VkFcgPun/P1h+drl625Q86ftinCLlbexCWJYaxzCjBoZCgLtWqMa0PhEXvUAdKaSpXLJesiL4xCKRY/Q3R3/yck4w951A/TV0LE6m0NLh+no9UJh3prw7fQ9/RHTeNlTuDc20yKIUM+9S2SSdFTP/o4lepGn3du+ZUOCZaKMIDahT/qpBc8mEFtx0SD5UUGuZ3vHwfJ3E4nhDwgiiar2jL92J9XzbbvX5BZjA2K1o5vMaVRhmVdD85BzJPq/QoNJ8/OzSq4BFWv3WYds5QuPKcua4dckvL0Qdv5mK1WUfTsJl+GT0KCU5dZCZGjVHrj/UnCUC2TGIMCRRs1Cirw8QnvU8sgru05reDkNqOcNUR/VnHE55+IoESmxhm5i0ql/EXcOFZphjDHo9w6/6wTZD5UlWgO6EPrgXEADbdac0XyeMWevIxVvc1O1yn0ODMVwzd6raK+Zwdlv/7L8rP6mkDgblCtlFqkPQebjjEArWLTY0+tGFmljM/gRSBnsrJrA5TOZGRxbGbgI49IyF4A1nWQOsaaqI38ar6M8vd7esNRqyV5p4UI/PfRxs5FFQsbr3bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(9686003)(6512007)(38070700005)(6916009)(83380400001)(316002)(33716001)(71200400001)(44832011)(64756008)(5660300002)(1076003)(26005)(86362001)(2906002)(122000001)(82960400001)(186003)(91956017)(6506007)(508600001)(8936002)(54906003)(6486002)(66946007)(8676002)(76116006)(66476007)(66446008)(66556008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1XWDiRymsD/pPCnBo1EJSIJ8oZ+/OzHtux0whJP0uHQKzzIaWvfEcBqTdFF?=
 =?us-ascii?Q?5Isbio21CTA1xlJG80X8Lti5gFQnBjoQGSum5uYSHLbd9mOrU/T4DvCZqaLg?=
 =?us-ascii?Q?6zrCLumwxmShTeRvyrgqzlnHehYMzK8BWPml2v8iRDCVqC7pa3TpMTJBBfop?=
 =?us-ascii?Q?wtaElnGs2y4NCX73h/+SK+dCldEhULeIRaVCgNlfNt58BQd3FqHeZBDtFjHy?=
 =?us-ascii?Q?MI1mkCrFnILVnNC+YRTs1z3J4DbqOOktU58sJBw7nxHy2LDuwNl0Zlv/oobB?=
 =?us-ascii?Q?yIfdC6a0qu17lusLL8j7wektQdH4J+OqmAKo8U5gXirvnPOdC1bx6IKnLalT?=
 =?us-ascii?Q?wMAWwBaW2RNHcHwOP6vy1uVBiav4E9O77tloeYqTBw/RKTZF2Ll3oi05BoDX?=
 =?us-ascii?Q?qUK6pbSx5KAfoHJpuwehUNRfMInID9Y4syIhKMSS0zecoHUluxST+N2shrxH?=
 =?us-ascii?Q?/wEX1HIVgtfPDDt8FKBmoLUeMY1BX+lKZG5AGKVOxoCl3o4RE0MY9n4AVq1I?=
 =?us-ascii?Q?X+HwFD2+f3WTf9v6IwT+GJgl9ias/AgvLdKybbXQBYAxnkMRaFqMWwNiY8e0?=
 =?us-ascii?Q?osNKmKzjAcSzC5osVw5MNw5qq5GsaCDyL5Y/aLVTbyxCKRWXvZjpgH+62Zj8?=
 =?us-ascii?Q?fn6uyiiy3n6qEH6c2ZP7rGprc5daq1LRbJEQV23QRf2CWTq10YUBieMAu7g8?=
 =?us-ascii?Q?LKsXvjRynxpN8AVadYQVay3a8Xvz5IF3lSiycmQROm9o9n4le9legbHid9Im?=
 =?us-ascii?Q?5i99KTiqj2aV+gtO40Omc/32GT/fahQOsWQKN/rgjpgKuon/j/1Vu8LN6f9y?=
 =?us-ascii?Q?JYNrju4Y5k2sRVuVModJoEVQhLA4dhl2FhA2PdwuhS2AObvOZaKUFUdskJzA?=
 =?us-ascii?Q?04Sy80nzMRAg4CBYkxdJG/v0Q1DvNPn0HYeOWciCl2agbuSOcipk+vxINWR9?=
 =?us-ascii?Q?a+6r2BuR9FtOtcPDCCimLBl5KVvhhqXwOLAY4SDvxa8Cacky0yZB466ISFwX?=
 =?us-ascii?Q?7/zM9Wuyo4EldevzBPjAUADSIUTFAFNHpc1Iq3oD+gUvMRVSaPh81IIXBBDI?=
 =?us-ascii?Q?Knvbpf6d/3+K9RlFft5cqbtB0EkqqCmsNUQq9FyJwEnyWi+8ee88pF+/EFTl?=
 =?us-ascii?Q?mTjRNfGsF59q+d+uuVF/PqcM8s+VgIi9EhTdGHQ91iVh3DAxHV77m4C4IXKy?=
 =?us-ascii?Q?AyiX6ParAKslXyVl8oWB2Zjpu23oYjbq1iOXElM9VCbFxMIpemlEIxVFiivs?=
 =?us-ascii?Q?smj9KS7y9mTVYJPuD4aNizLZz9JVaayj25iGZN1VUxH/rgaK3/ile8UEUC15?=
 =?us-ascii?Q?t0nOSvw7YdGgdz4NxhnPfmq81QgDIpH7N00R4NHqwyYcZwCl3F61kbMYlNCn?=
 =?us-ascii?Q?tSEM+BZqmwxbHPG7rPPsAzUG9n5MU0rh6Sw6lXDJ/htRRBQDjeU3Wy9W3WD7?=
 =?us-ascii?Q?YvqZ2KTru/5ZtOuEtCJkc72oghsia3zVdV/wBINxpSwgjvVVkE7XJGRC6Wau?=
 =?us-ascii?Q?nuYpY/h6KYEJ8g/QjkXMliYNtIzR7doP0WCpWVSkkpZVrecZ2w5C93ifJQjn?=
 =?us-ascii?Q?HvMeWhpWSkVXNDo8tb7UijYrIHX/BWw35jYTnTRX8/sXAKU28VdzHyYx508T?=
 =?us-ascii?Q?AiUOYKNZY7YSs/xvi5g6U8STcBRPULN7WWkcEtkPD9SwT0uX3gpZG9IE8Imq?=
 =?us-ascii?Q?lV2HJFcojE8LJ9Z9p6kgiOFtX0t6CrKhpqhJIOHQQmPuMNxG7bhz+6gXtjOy?=
 =?us-ascii?Q?Wlaz0K65m4LSPYPt4YbGiEemVzkhwzx6A491WOHOdCiId6AK9eOG?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1876959E432BFE45A14887D6732F55DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01b93ef-d633-4f3f-5048-08da280bf5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 05:08:25.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yav82iHOm42R9pOdJ/tvB3lGk9jB5G2OTfS4kQcQ8/1zGyK813NQpr2PM4C6edUKz7WO7eBojM9usrOSp3I9Hvsg2HqOsrNjjJa1thCDSr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7774
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 21, 2022 / 11:00, Luis Chamberlain wrote:
> On Wed, Apr 20, 2022 at 05:54:29AM +0000, Shinichiro Kawasaki wrote:
> > On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
> > > Hey folks,
> > >=20
> > > While enhancing kdevops [0] to embrace automation of testing with
> > > blktests for ZNS I ended up spotting a possible false positive RCU st=
all
> > > when running zbd/006 after zbd/005. The curious thing though is that
> > > this possible RCU stall is only possible when using the qemu
> > > ZNS drive, not when using nbd. In so far as kdevops is concerned
> > > it creates ZNS drives for you when you enable the config option
> > > CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy. So picking any of the ZNS drives
> > > suffices. When configuring blktests you can just enable the zbd
> > > guest, so only a pair of guests are reated the zbd guest and the
> > > respective development guest, zbd-dev guest. When using
> > > CONFIG_KDEVOPS_HOSTS_PREFIX=3D"linux517" this means you end up with
> > > just two guests:
> > >=20
> > >   * linux517-blktests-zbd
> > >   * linux517-blktests-zbd-dev
> > >=20
> > > The RCU stall can be triggered easily as follows:
> > >=20
> > > make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy=
 and blktests
> > > make
> > > make bringup # bring up guests
> > > make linux # build and boot into v5.17-rc7
> > > make blktests # build and install blktests
> > >=20
> > > Now let's ssh to the guest while leaving a console attached
> > > with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
> > >=20
> > > ssh linux517-blktests-zbd
> > > sudo su -
> > > cd /usr/local/blktests
> > > export TEST_DEVS=3D/dev/nvme9n1
> > > i=3D0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; the=
n echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=3D$i+1; done;
> > >=20
> > > The above should never fail, but you should eventually see an RCU
> > > stall candidate on the console. The full details can be observed on t=
he
> > > gist [1] but for completeness I list some of it below. It may be a fa=
lse
> > > positive at this point, not sure.
> > >=20
> > > [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
> > > [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> > > [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> > > [493336.981666] nvme nvme9: Abort status: 0x0
> > > [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
> > > [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >=20
> > Hello Luis,
> >=20
> > I run blktests zbd group on several QEMU ZNS emulation devices for ever=
y rcX
> > kernel releases. But, I have not ever observed the symptom above. Now I=
'm
> > repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device, an=
d do
> > not observe the symptom so far, after 400 times repeat.
>=20
> Did you try v5.17-rc7 ?

I hadn't tried it. Then I tried v5.17-rc7 and observed the same symptom.

>=20
> > I would like to run the test using same ZNS set up as yours. Can you sh=
are how
> > your ZNS device is set up? I would like to know device size and QEMU -d=
evice
> > options, such as zoned.zone_size or zoned.max_active.
>=20
> It is as easy as the above make commands, and follow up login commands.

I managed to run kdevops on my machine, and saw the I/O timeout and abort
messages. Using similar QEMU ZNS set up as kdevops, the messages were recre=
ated
in my test environment also (the reset controller message and RCU relegated
error were not observed).

[  214.134083][ T1028] run blktests zbd/005 at 2022-04-22 21:29:54
[  246.383978][ T1142] run blktests zbd/006 at 2022-04-22 21:30:26
[  276.784284][  T386] nvme nvme6: I/O 494 QID 4 timeout, aborting
[  276.788391][    C0] nvme nvme6: Abort status: 0x0

The conditions to recreate the I/O timeout error are as follows:

- Larger size of QEMU ZNS drive (10GB)
    - I use QEMU ZNS drives with 1GB size for my test runs. With this small=
er
      size, the I/O timeout is not observed.

- Issue zone reset command for all zones (with 'blkzone reset' command) jus=
t
  after zbd/005 completion to the drive.
    - The test case zbd/006 calls the zone reset command. It's enough to re=
peat
      zbd/005 and zone reset command to recreate the I/O timeout.
    - When 10 seconds sleep is added between zbd/005 run and zone reset com=
mand,
      the I/O timeout was not observed.
    - The data write pattern of zbd/005 looks important. Simple dd command =
to
      fill the device before 'blkzone reset' did not recreate the I/O timeo=
ut.

I dug into QEMU code and found that it takes long time to complete zone res=
et
command with all zones flag. It takes more than 30 seconds and looks trigge=
ring
the I/O timeout in the block layer. The QEMU calls fallocate punch hole to =
the
backend file for each zone, so that data of each zone is zero cleared. Each
fallocate call is quick but between the calls, 0.7 second delay was observe=
d
often. I guess some fsync or fdatasync operation would be running and causi=
ng
the delay.

In other words, QEMU ZNS zone reset for all zones is so slow depending on t=
he
ZNS drive's size and status. Performance improvement of zone reset is desir=
ed in
QEMU. I will seek for the chance to work on it.

--=20
Best Regards,
Shin'ichiro Kawasaki=
