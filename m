Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33116EB64DD
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 06:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHGGZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 02:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGGZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 02:25:21 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59C10F9
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691389520; x=1722925520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=il6BB/A25FO4flQWeiQz78KjGrpkrEcCDIqWYlKcJzM=;
  b=E/j54M/hLt9MNC5hqlsiRc+1d4Aq7fH+LgFIQ8c0vMWYQzsldj3yqom9
   /BE0cSgqL5CiL+t7LuZWG4v/bIVYzGy+mvIBl3n7WbryR3JFy8f7QWYi1
   14gijlSpTkG6aiJxPsMJqabs7EN+8Odk7BqNnmxznGvEYlp/KxC1gQOCZ
   NjAWm521xt35ZZmYyLvFY3n4QLjkHuegYSpdKom+wTe8nIGVj7OvsytMa
   dUzu5PQI/rD2YEKreSfnlTjw+X1doH6vEyoojZYZ7AeFsLSZwPxFz7tvY
   FLIGhIcNcuGL7sgBEeP3pLivTrWUSd1VmveZOvWaqhYoATRbCRYAfhgAW
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,261,1684771200"; 
   d="scan'208";a="244912733"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2023 14:25:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwPeioO6Jj5iLfWG8bxJx4Vnx0YzkVt2hp7xPHnX6od66zxneqmD8FKjhh2NItirrAQ8z9uY2LxOCw2rKOqTkJ3cRsU5eNdnHDpfKiTWnCnEXyB6+1M4663xIvoYm8qbHteqWKwCnz6K2S2tEbsOTTSBq+9e2L0surUjP0P29aBOd1Nk13dkWql3E2rzpjCcSf9jRdhqGj61U4KpL3IBBVe5Xz6p9zf864rFyFYkVHLb8LfyIvYmWoVxzoRU5ewZqKWmgE3WXqQBhBiQvFgyI4MzgG2cZ1Hme1SX8Ua9lbQH3sNQvZ5Pw5dithb9VWIrQwIxTDwbzgnjfLUxzZOFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eh9ZkCRJIr56yk/lOQyPcCuDKSP3pjh1b2b1XXudoM=;
 b=EYOL3h5ro9BsSXwVrmByABh4Jvb+mdDNfo+bEWcMImSlsSPWCos80xOnEqs5Wq3beLkTP4t/mXvpzHqqsetN2BmsaNVOqhLI4ktp+lbLQ8pUYlveAA2b1I76LnMYq1KiMgkGuyNSDx4PXbbmOwhEH11AFRLole8XdokWJStD+rZGg3fM4X+OkbmNx2Xwlwk80aWxTkvbB6aiOk4bVw6x322AZEs7dYaZCxCUa9rIH/K4SJ64Gq1r9gWiVeG7rUhx+KcwIyJGUTryrwyfu1oLIE0AxTXKG68/82AeK420lcEectYwq70itFYNodgW7jTq/mQIN9xyFqw1YDm/oRl/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Eh9ZkCRJIr56yk/lOQyPcCuDKSP3pjh1b2b1XXudoM=;
 b=Am4NRcgdHNYLOst5OJIv7pNUoOS/Ur2CngmyQAhk2ZAoqbJQu2H4QsS13fjHHuF762k3MMvdWVrFNfCx4vtCA+4J10UcduayOJws2j/LQ/tSuXp9SgtQqD2khq4a8jWbBUJCEm6gGlxmUPe7bbyju4pcYO/UzTZ/FR0SyGWf9Wk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7831.namprd04.prod.outlook.com (2603:10b6:8:24::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 06:25:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 06:25:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] src/Makefile: fix static linking of miniublk
Thread-Topic: [PATCH blktests] src/Makefile: fix static linking of miniublk
Thread-Index: AQHZyPfuGPNgzBQvhEOUwhGKw9OASQ==
Date:   Mon, 7 Aug 2023 06:25:16 +0000
Message-ID: <5v4ix4mfg67xnucc7cipbp6i2abiyjq7udkficswgkzughfiad@7ux26eysnsnb>
References: <20230803212052.1173449-1-tytso@mit.edu>
In-Reply-To: <20230803212052.1173449-1-tytso@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7831:EE_
x-ms-office365-filtering-correlation-id: ed0f55d2-9ae0-4265-7f04-08db970f1123
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74NgMBGz3qQ6AWzrbo6/Uuzh/hrPT5ncf9nRqqRq0czp+MSosNOKi1N6Y+WqdX22u9LIppnM0PN6sct0eHbPKbhSEhp89yg5hdxj0hBkDy2Fp8PXskkJCKt69fe8JdTROgo1t93E0/PJbZ6zDbK/JVTCGm0QHo6NIIyhXZSsFZo14qrIfqAkQtkKJkBfhPqYf8J+GKQ+R9jOZCng/M8Fyg3JisQITlQ72WfutrWdUXjgoz5Y/73zQfk5DoqtVZMC1whzDBZYAC4qo/jfjIlU1Ht6K8wCjXHlMGbf4ndkejjGzXBlLY+pEL0e5tVh18A7NgAPVKbX1+WVGQg++9vLIu6HV0UAmQIZqhE4caDQKvwNquFVkvAIK5U57Dz6+ZPqP8MRAhxDmxPhxeSCIspB6xcbN8tzKMLnYhq/sb5ojpdNHqhORAMa3k4iRxpwZCoF+uxSmN4wwzhGtr+o7bNT698UE0QDCycK6bkxgeok74et5/vfoMq7eS45/3xSN/HiAYf0iqC1HKWav6xtV664AgUbhpGJG1uQmR9cTGKfMjIGfbLe542YjblmZtSrUDbZX0mOwe+3sEqBI/ZYT8PXn6c2oOKM+PUSfeIL2e2Nexdn39GHo3fGLR5Le4FMNdPe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(38070700005)(41300700001)(26005)(2906002)(5660300002)(44832011)(8676002)(8936002)(122000001)(478600001)(6916009)(86362001)(316002)(82960400001)(6506007)(76116006)(38100700002)(6486002)(33716001)(66476007)(66556008)(64756008)(66446008)(91956017)(71200400001)(66946007)(9686003)(6512007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+nbF/DdpfBA0VAUSWaj6NJNjcV2NX58hjk2MzJdrOEeWjYTfLNwwz96XBM7?=
 =?us-ascii?Q?x8Y7l6t4vW+BAuhyj5R9oXo2f5RYqKPgRngEUNbqy0dyAwES1vEgNRcPty4E?=
 =?us-ascii?Q?O8zW+COIvleITqqFnSjobOLANcGcUJo0isQMkfOS1e/AVTZiJWT4sK/1DcN8?=
 =?us-ascii?Q?vgyGa21nOZLqIXM5wbbUMoelBQAhGF8lRduVMba5f9SG2Bs8q3Z9Mp5MOtjs?=
 =?us-ascii?Q?BnybIXMVTeA7JpzvHGu1Dxi3IDfojNUj9UHok9U0Tx5ImfnauLZGZT2GTZHp?=
 =?us-ascii?Q?uvMCW2fdTW8SWBlaF23c+hSV1J7rGM4p1emgHh9G03TmT666uN+8WBbt1BqA?=
 =?us-ascii?Q?b3RZ0/7clcW/U1ftIVw/mYT6jOX3jKX+zQJrYgySHDhHLdcP4GrvZTtiBoLZ?=
 =?us-ascii?Q?yYDtLq0sReKjZy9j81/R9iVpJGI9kuejDnr3uoa9fiDjtSqa2VQVNkFmUIEr?=
 =?us-ascii?Q?ypWa12vhkx//ce6YcFPZ9LrAPhkPKCmIIAzmsf71X/LKoKrgk8eK8E3F/IgJ?=
 =?us-ascii?Q?eUuw19au0XBh6iQvQFuSg0AaUpTQwUMDAMLVXeRRx+ok8yvHh+YEX568sZuZ?=
 =?us-ascii?Q?G+PWX2MhhWa0PF3DRjQUWu4NsdZTUEmDusL84CItTKNOgXGeMpxIQHxlrwM2?=
 =?us-ascii?Q?Szb6iBDoy9mOInvtO0/7FBLgtqIl8QBwFfwq6TCNDejjNSgZLAWIQbQs2MPr?=
 =?us-ascii?Q?RfX16OdGi93bTR3bC1YdIwKKDhpSfdHIrtQCQH2yUDXBXy5Nd1NY5XXzx60u?=
 =?us-ascii?Q?1G5vAtDk/2awWnlQMB56s8EcChXzh4lxXwtHzr9UvEpEgkf/+be+C+0dmxeJ?=
 =?us-ascii?Q?v3O8eR8DQsN+93Pjw4CaalPgbuRvbLr9yX7OzVVIFyG+UpVdSZM1Jl0Guzyw?=
 =?us-ascii?Q?EeorXPWibxB37b5YY4JZa5t0hLJwGTBrsnX1+2dKMyZpxChgOVUngOcPEgXs?=
 =?us-ascii?Q?ozs1bSqYwuCI8KIlAod5n2DQsFYENl7G3GiJ3IdO5LVCe2Nt9qTOImR7mw2H?=
 =?us-ascii?Q?yBa6VnJir+OuupbjMsLa/znzb5iAiWgQFPEg7baAJ/ApYsH34pCtcFWb11c+?=
 =?us-ascii?Q?gwpTSXelsdvt4Powx6/gvbcnnNuEw5FAKu/32gTJ8iS9RxoL/wzF+xq/g9Nd?=
 =?us-ascii?Q?+IcKauziL4FXKzRRsMJQR0xD6sSXFyE3AQ0DkUhSYMjoxLFLYdX1bDytCGRE?=
 =?us-ascii?Q?yMO0O/iOWuUx6DrmMtcnKS4o/oZGReCH1hOVLo1RSfg8LgsQ8uPzLS5RD62P?=
 =?us-ascii?Q?N+uIJclYLavOSvOzDjeZta7D1dfu5KCw3RqKDk5zqylAJgJkFdGzf5U2jHoZ?=
 =?us-ascii?Q?NvEWPsnPg2X8yATFBS9LWUUA1ukl/K5lk2rLd4xoqKrjMj2lyXhYFFAvUEev?=
 =?us-ascii?Q?K0QziDFQ5ZhS529gsMA8lmqAPrY6oBzmS4yeAZ8P8hDmIGYEFx7jQvOAPOEo?=
 =?us-ascii?Q?qDhuklqUw3CY7WWgkERESaMnpGDwAtX0nyw3lwNj1iYwGkEEdrtoezOEmkVf?=
 =?us-ascii?Q?X62QiG9x/ROXNqlMbvXeVrYdDYoNj6X/pX79VpUmTTT8RWobS18ZVfWDwxxI?=
 =?us-ascii?Q?kxegbyv1kXAecsyzLRtJqN0EyZhHbMaO7N36rMlMbBXk1PDCTDMon51V5JAO?=
 =?us-ascii?Q?TW8UY/x0kgwnM+avuXc6wWw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EB0625BDE8A5C4A8575055467387A09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ylUwKTJHxN/lpkL3ibC7iCr82XNIbxm+SiHBjHX92kKZ8NKU/4gxKZrrA9w9uc30p20CwBi86V2jS+U1Ay7e+fxNC7WwP4Ydr73lR6bvW/7DF7Mm886iqeCI5O3VpFap/J3eeve1uf0JN9xADjnWEclY3Krw5QAweXaMyz3Jqu9xdMGCMTZ8LYH2gf6EarTJxsic4kiTpLoWoLRpRpQShfvl3aNg0EcAv7mxQGKHGC7wyAcqNxVABI1D/wZGPHfnBR+U1GKIoFNurQkESYfaxZjMitJdJbK6qmeGz/mblxli699kmmsQlbRzHHRxkxrpX339EK4GPYr5sgGLoK5v4cWwGHbBE3hgKb2t0ggNLKLKfYPO84ubdcbjt6IsJUpwv4iLZHVt/Zf7Qjp8w6vQyGrovrPCxv/pO4FNMjCxROSDRelnqLJfrc1oG8+W6u8HCzts8DVo9ebXFdae2FD1jKt79QV4jCILNEf/FRWUXMmwabJ2szF9+1eqNV29oHyVPBJcrIXAKeoDZFVz46X/OYmM6NjQMBLw+GBLE+vbxMuCNu1efec29cdozDz/RQX1ZMjTy/tnkJvb7Hv55L7hPj6isB9j+DI7sgNnj8bODzDrDYhqlHbG+gqHJxwtQdaasNQkXaYeYPNZkJqSWziwozbHTPKfF4NiAK5pjrIjs4NJfpplyBwoNG522bVjnhSko8oDTXUJK+MfgObGLzrVWugldCxsuX2gzfxUiVrQJCabvp16jk/2lZyhvauEEbuTFBBckOGFlTpCmlQFxO+Q4bW+iF0DRcik1uejvAPcswQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0f55d2-9ae0-4265-7f04-08db970f1123
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 06:25:17.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNfG58mVC62KmcLhaBSMgAk9oFneiz8Z+r2ToD+IJqRSgolCRK/2BisEsOUXcn3n+UF0laqnOU7nbs2BvE1IDiX2v+Zmloc5cIrW0Vj+008=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7831
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 03, 2023 / 17:20, Theodore Ts'o wrote:
> When using static linking, the libraries need to be placed after the
> .o or .c files so they are searched.  Otherwise, the build will fail:
>=20
> cc -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H  -D_GNU_SOURCE -lpthread -=
luring -o miniublk miniublk.c
> /bin/ld: /tmp/ccfjiUvb.o: in function `ublk_ctrl_init':
> miniublk.c:(.text+0xaeb): undefined reference to `io_uring_queue_init_par=
ams'
> /bin/ld: /tmp/ccfjiUvb.o: in function `ublk_queue_deinit':
> miniublk.c:(.text+0xb73): undefined reference to `io_uring_unregister_rin=
g_fd'
> /bin/ld: miniublk.c:(.text+0xb85): undefined reference to `io_uring_unreg=
ister_files'
> /bin/ld: /tmp/ccfjiUvb.o: in function `ublk_io_handler_fn':
> miniublk.c:(.text+0xd62): undefined reference to `io_uring_queue_init_par=
ams'
> /bin/ld: miniublk.c:(.text+0xd77): undefined reference to `io_uring_regis=
ter_ring_fd'
> /bin/ld: miniublk.c:(.text+0xd8c): undefined reference to `io_uring_regis=
ter_files'
> /bin/ld: miniublk.c:(.text+0xe94): undefined reference to `io_uring_submi=
t_and_wait_timeout'
> /bin/ld: /tmp/ccfjiUvb.o: in function `__ublk_ctrl_cmd':
> miniublk.c:(.text+0x14a6): undefined reference to `io_uring_submit'
> /bin/ld: miniublk.c:(.text+0x1533): undefined reference to `__io_uring_ge=
t_cqe'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:61: miniublk] Error 1
>=20
> Fixes: d42fe976 ("src: add mini ublk source code")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Thanks, applied!=
