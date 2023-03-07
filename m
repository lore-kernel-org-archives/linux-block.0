Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53CC678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 09:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCGJNo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCGJNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 04:13:43 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004737F05
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678180422; x=1709716422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=31cEdZZ/OyBdUQi11w1lw5B18bD1Ecr2hr5s7ONgcZs=;
  b=plu5mV5RiPd29sy0eJw6wSuhRwhN3JhNSM/JOvsDXc+WyznZpXJIRXsS
   Xc9Z01NeM7WEe/8DeM1EuOi2YfgrwmpQyJOpuW7nV4wTZzsrBZ+rXfPaq
   6MHyGiGfAk3LZN7iofyP8BySg1a7aG2jAdp21BbjFwHTtvqonSzFSUeKq
   L2P2axZkyh/Go/AkGhfYcJfAcWnk8VsL7C/i+00TaXjARpiOAFZMjw9AY
   432VVmVI89Aw2urkAmOGyfzpzCj8Bn0dyIT6cIxjFdIYQZrv+2KPIW/66
   nn2oBun6eVwgP0EetbbG3Wui8ma6IuBJORjYLcJEZyUdRDSWRdHKF2uOD
   w==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="223278377"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 17:13:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaqXpa+itG71JCmgRKfx87X2m2nSJqHJIq41jfe2VazLzAotKJmgFMuRzfoFQCcd0beXNTFeA8DKYBx68CKwPdgej7LXvFrkqvowoH7amCaIi9pClYrscLzmW2G/g3m6vAVXiItGGjO3NE/ucql7tXF98lgleNU1DvTyf7oBW9zLdslMRQMwN90loBy7XvY6dStbYvSb8WtaQi+BJQ5Sg9dICuB/VclH/L81RSfTr7luCzNNgJp0XwvykLpx0nPkbOU5WxFDL7hhpTmHMNanYncp+R2Gy1aoEtvWlTYK8Mufti3LXyrYp2attR3lMPt9iaz9Je/xgMc1ZBZJ4Ptyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31cEdZZ/OyBdUQi11w1lw5B18bD1Ecr2hr5s7ONgcZs=;
 b=lbCXQOdGa7rFiUJEUA+EVNpA3/t2mPxsg0u/8jpUlMXd4zmFI7cUbYPpqSRZNZXDWwF3g+1Y0ZZk6XNq8yyTyowRpVMpL5p2yo63kLtBGc2jgqbmXOoli3smK3qEfCMOFalgdWNtv7sMk15GiILNNKx6Wg3sVM98M+P5z4CHPCUlyFZBiyw/QuAAo+58NB0GBzLWB1wZGrI1MsWChMzVz+Ffextx0uG1FO7w0r5aTshsc7kQDkflvBhAFA8uH/Kj3UBQspOyl303RYMPov7xI/l+mIL23U7bUaUzyJBJOGXnxPdenb+ghoCH/6dRivjwNdKjMKXDj9TOe5Qhp/8E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31cEdZZ/OyBdUQi11w1lw5B18bD1Ecr2hr5s7ONgcZs=;
 b=ZJ55HjFjWFrvpgdLWRqJ5ZeQuQkn5qFFo5YRK4lxlGnnlu/eWEhgpHyk/ir1T401boI59jJhf9o/tiCIKS/dRNe3TAOpNhKYfh4PaOTrrinzhVV6nagZ3BC/8jOrbpsLdu7nYzUtNtCR6VPY6PriKWWWcTVCXuYF9lr8BgV2OF4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6496.namprd04.prod.outlook.com (2603:10b6:5:20a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Tue, 7 Mar 2023 09:13:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 09:13:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
Thread-Topic: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
Thread-Index: AQHZUMSAZFA8a8YrAESPLW4VjNB6Ja7vBESAgAAEZAA=
Date:   Tue, 7 Mar 2023 09:13:37 +0000
Message-ID: <20230307091336.p2mzdo225zkoldmd@shindev>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
 <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
In-Reply-To: <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6496:EE_
x-ms-office365-filtering-correlation-id: c8d0ea0d-7b5d-4940-f9a6-08db1eec3c02
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jd5spoTidOZGzmLuJXMvzCGrOI5eZZEoYEM7p7H2YNpfJ/ywlMDUbXysLAWwhjclqY/IbrG4JV2b0CINFEjTjHFj7q3bs5ETv0SQayQHDJIBSpmyTujQAmWvpZOuoisHsczJ9OQeztH5CbRS/ToRQFfsNUZijwognRR9iFlSsEqgp1zUJuYH5yV5hmveSaTHxsMkrQF3gWvRf4S/CDkbXqoZ1XrtrBj1fES47FWPY0smufONAaF9HV0qlSkmjXRpIL5R8JGvyfh+nT4HZtndeg8L2xVjfxdTeSFsBiy9H/lCfyrow6St5ArHI/HRMXZhQF9UShHjQn2wI+qy0wGsup6UWpYniRdwsR4MB/S8zDPvoITEi1am0dtwZ/JfTRBwfQzjzTDigoSQQ/cWrFwYiSF1+Ad2bVMIbPiVoBMJTdXsmQV3rpDfVub8d6Kyq7cMv5aT7u9DXmUgMqRsPY/mtizGxTUA/YCE01YTgLudHeRK3lrlrqsuv4Hnjs3nRBfP7H5TtD2i5Bm3N1NLPHDFy6h43X3mkEI51GwVYbUcOR7i9nluHYn/3wS0ZixwKBXI3vPPxr6UTcFjufY+xMYOUWw+i7nW2rNaleSRPgDUvhxhjOrPQ8raH6s0kB8p2zzsA8NWCQ8a4wCupJ2CQ7nWCNofyKIuaQlczx4KK1eGNMEAchxIKgC/aa9otU5SDoPyPyTTyayiy4xWTC0MUQMJDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(376002)(366004)(396003)(136003)(84040400005)(451199018)(26005)(6506007)(1076003)(6512007)(6486002)(38070700005)(86362001)(82960400001)(122000001)(83380400001)(38100700002)(9686003)(186003)(33716001)(41300700001)(91956017)(66946007)(76116006)(66556008)(4326008)(6916009)(66476007)(8676002)(64756008)(66446008)(2906002)(44832011)(8936002)(4744005)(5660300002)(71200400001)(316002)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C++qBLbDfCwjUjcqtMLPWGjVPLOgjCTVCZgimATytA5BG4wuS5TWkXfAP4HM?=
 =?us-ascii?Q?Fxvj8jFqgYdzpa/R7Ofa7RO3rfkQpbNtFkXK4YGTVt8GlOrP1wByJ7ORqyhk?=
 =?us-ascii?Q?Rb4BtPySmUlw3DaBZY8FIdDoHHwW37VqltsHYHHTq3relqDl0v2EZfBmzoGS?=
 =?us-ascii?Q?WmSefGJ3NCqL9MEo5/HsH/HrAGy+5FoG0P1XCbFQBxiv1bWxnLoync2XdsZW?=
 =?us-ascii?Q?/0g1ROWUSf7n+PKPfX18ErcNt+Ayg/t2X2tSARCn02+p3zzYfVGW4TjVouMz?=
 =?us-ascii?Q?AygCNkSLopmJZM8y/NxQk0UKzsMU3Go1HnDW/aDVFyqKZpyUJQzkRy5cVoFg?=
 =?us-ascii?Q?Fxal56XLzQ2s2JXcC/QWk3JcjmEElbnjskAhytz3dKaohNsc+rw8qAbA1voX?=
 =?us-ascii?Q?bvVyRsJnX44ZK0b2sLNjNfqw3O8geiSycP3n4rCROSqjqMtaeoAV+oaRFZPr?=
 =?us-ascii?Q?1H13F3qf3jcbjqSrmUgAxqWoBiye7XscfXHD4jLfcJBfe8KKVciuC8CWnwo/?=
 =?us-ascii?Q?/dTPRN+OHHJBTf5xATCmbKQY5BuTXVlKqlC4VxZ0jR+SvWtvTjeSgTcGTgd/?=
 =?us-ascii?Q?L4z6vcR4czUWebP0GpwbPe9DMfPWG9T1gaW77bCOHZvygRbOqp50H17R6bhw?=
 =?us-ascii?Q?fGO+MzucQwu6xSfNeqioUq7zItVmJo7TnaPioNQJDZIwIHAoaxWxbfERXLad?=
 =?us-ascii?Q?vRFlhcPz0RMBtLzlrK9kZ0Fbgp8P+rD3k+Fr7ofysGkd+UU9TEAbekIjx+Fp?=
 =?us-ascii?Q?VEqe6uVgmeZ0inU5mB5B77jTTh0eoDu+qqIr15lZ7nEerKovJRGROh5TXhUL?=
 =?us-ascii?Q?UyqAZM6tCLcLVD3K6LAzGf0BRkyt2wBFfEtZU3P35hIoLPn0hpMjabRwdcdX?=
 =?us-ascii?Q?I0DSKpdG0uTVmCjDTq1SyPDTdM4NaOKkZExQNd/4eH3OszhGKott+GvW0nJl?=
 =?us-ascii?Q?mkS0oN/tghGfn/XJRzmdJHUFqVJ9Uz4FZhNjWo6YO9WnSx6hcXl5xO5gzk1C?=
 =?us-ascii?Q?jcSbdPRUA2KfE2MemE1NZu3olSHw8A2LVMkDifBl3ZNT6TtbBKDX8c1uBn/G?=
 =?us-ascii?Q?OwH+ZwrwVNl82Du7M5WLzFH9rha9RZAOjD4VWOJ0clPB3zCVr/AyveJi7kWj?=
 =?us-ascii?Q?H9Iae0nyc7XCExVbQfem4fQdSnCXtA73JmZmSiQOQS4rwENIPk9tOj5VJkEc?=
 =?us-ascii?Q?9niFOKmNJ0SIL0OuXcH40Iu7dv0O3qdlQ8pWPTWxBAxDI5iHsepc/6PMbM6R?=
 =?us-ascii?Q?2Qm7sC2iGWykuUS2YXIl7hyMb0iavmH+CcRpSIeOiOwmZhfTPbz7cJhA4TyW?=
 =?us-ascii?Q?1olZc3wW2HmyNObGRx0CQloAn4zeRSfxNCEv0AN5t8aKfhONKkMO2mJ2Pnxu?=
 =?us-ascii?Q?poazppWyc6ZZQajI8GJqw7e5ByqAWlTLTvco32eEFC9MnqYVUPIFRp1c1fdS?=
 =?us-ascii?Q?tr6NY1pM1rc9Xo0IfhOoAJsyhNAvQP6W2T73oNqStQ90LCZKxqmgnHqpRtSz?=
 =?us-ascii?Q?RcodXCTzYgLIhwDVutlySHGIR2LK9j3KUSz1Lq7ckqm54zCiy0EtsA4etEMd?=
 =?us-ascii?Q?IO0Li/rP0Lyv4Wl1F69nyq8hrr8PPkSB4LC8n6V1RZEbJ9xyGlmzTlXB67+y?=
 =?us-ascii?Q?VlpM7ThUUKmHTGvQh+bVjEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF13959500F3B547B846272633F41824@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CAXqKkJzOQDZCGHHEhICjNgtGyE6SOi/pz6wUEJ0GFCuo5VfYUwR7O+KW9Vc?=
 =?us-ascii?Q?IOGnu6ZrPbwSAmHIqqKrAJYO7v5EaQgsl8a7P/jT9TY59eRe1zb1vf/qSo2I?=
 =?us-ascii?Q?1fY3ozfmmviP6/wQPyWORHlJhCAhd5C/VJ2q0fHqPoyap/PlB8qDURY1bYqT?=
 =?us-ascii?Q?cH2KhSsWPsFEE/RQNsQrdkDHHtGm6p9p/QxKJ3CIe4rQtIw9JQ26Gbk5AInI?=
 =?us-ascii?Q?bEV6TbAwvlFnp9VOeDj33u+N0mAPPXFqfD9uhs/ExfXy8EO01kIMWL7jXa0H?=
 =?us-ascii?Q?Fi3Lk+sSqapNCMgevqn8FYXk5U08BfS2gYP+xe8UzV1jZVTXBJBy4Ni5ozic?=
 =?us-ascii?Q?kKWhNZEA50PTArxGyo3iy7sf17wAnXepo24tW8/UVl8iakQN+6HMSqMAvcv+?=
 =?us-ascii?Q?+3ersbT8IZhC427o2KbJBjLUl6kJiyamrSLtzrPHRcjEpzU2jQAen2/OOF9Z?=
 =?us-ascii?Q?9QB3TBGEX8ZDWh6rTI/WjCl0uoRmbYI1HEcbMMuRmK4bkCbE1ZpuSRBy+OLg?=
 =?us-ascii?Q?hPXvVNfKTm+NhSnujqnrV+6agIxZeojtKQLa1z+AdD0b1K9lRXskUTGn3vsz?=
 =?us-ascii?Q?kd8soseP2I4sYBZWiH7P5fVUDoO40LcQqjC/+PdWky1Mrm338flj8UTw37jS?=
 =?us-ascii?Q?2b9UGhmwLzwN5S8d8fi4eEy1iTsTPATDrT3d3hL2FNLZoleQaPo00r9AYqt9?=
 =?us-ascii?Q?z/vbVHlk14oWtsFATkF1WeEysbr7CoqRY+fhrgt9TObdql07ZMgW+4HqWi1z?=
 =?us-ascii?Q?poT6HPmC+9kHnafmYBdSQX/lpWpLOOtj7JaZJOrbTxa3jTx1LZav8+FiseRR?=
 =?us-ascii?Q?J9p46V1w1crUM3xJPBFD4tVgX5eUZh86e3LF3Z7CjEPnqIfNBBiUwoYFsTi7?=
 =?us-ascii?Q?OpK4eEv/VwaQGohdXktF5Dxsk/3ewTOilLYFw13skII8l85nbXGmOHEKF5ZB?=
 =?us-ascii?Q?cS4H4flYdvLzGwEoOdQzvNO8kr4KnRXnNhJxyg9kv8E6cN3QQ0vuqTJtwjbk?=
 =?us-ascii?Q?m4LLOVh0l4OLFIiEMxNF8iMTlA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d0ea0d-7b5d-4940-f9a6-08db1eec3c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 09:13:37.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfHXySKzoQ1S6hCcmWQ9V7ctMfU/YhR4pLGIBfXX93MCFjgnlRxJfBUiC9nknwzxpEoIkEAqgTrZ3/lBQyk3ceb0DOf91UX2SaCtuI5zLkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6496
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 07, 2023 / 16:57, Yu Kuai wrote:
[...]
> Thanks for the report, can you help to provide the result of add2line of
> following?
>=20
> bfq_setup_cooperator+0x120b/0x1650
> bfq_setup_cooperator+0xa41/0x1650
>=20
> That will help to locate the problem.

Hi, Yu thanks for looking into this. Here are the faddr2line outputs:

$ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0x120b/0x1650
bfq_setup_cooperator+0x120b/0x1650:
bfqq_process_refs at block/bfq-iosched.c:1200
(inlined by) bfq_setup_stable_merge at block/bfq-iosched.c:2855
(inlined by) bfq_setup_cooperator at block/bfq-iosched.c:2941

$ ./scripts/faddr2line vmlinux bfq_setup_cooperator+0xa41/0x1650
bfq_setup_cooperator+0xa41/0x1650:
bfq_setup_cooperator at block/bfq-iosched.c:2939

--=20
Shin'ichiro Kawasaki=
