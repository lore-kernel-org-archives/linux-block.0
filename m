Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 07:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376367AbiDTHto (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376363AbiDTHtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 03:49:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80460340C9
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650440813; x=1681976813;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=M9o1Y79BVx4wpmB1kvLcrD5KR92qO1w2egxTJy/+LzoLHwSQyCGffJl7
   8yC7T9pu20qEnvQpOpQjJofjzhGxC3tWQv/Mp6QMlYfTxmJRisK2Uqw6e
   215wMrLz+vOgbTVxXyPJr9RCN3rF71lKg2bGgPhjPzxbW9n2j0Qx4l3jA
   /FhtSSfajz0voschnKnYgarhu4mr+rEtQ0fKCkF0U8fPzGubaONLMdIyd
   Z4E2AkW/V1G3lk8xEMs7JdQiN+NnwKvJ4WeMnaExvPA2J8T9TwYWc9qj1
   BKiLg4PR+ACV35g3jN+xDH/cx9xKzu6KiiVrYJ1AXgzEgQZlGvAWF86HA
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="203209025"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 15:46:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCHZ0yMrtI5Jmi30gDl2xpJwe7W9+mKAD4QFivOKDVEpfnSX/a/WStXDz+rDiF3v/ar2fGlRXZJsTAWav6iuVreFqb6cWeoMtYpyUjpsJ44hh7CFKx0hhActWuIChSdjvd1f6DXCcH/NlUDh5F1JYGV3xYzF20Z4gr5bmDtg536oD34sDyDodi5x8+ww+Q/JEvd9uoWk8uQ11HuKTFfp3YBntQeFrww93nIfYSVhmJZvU2agfmUgAFjuJs0sqTke9vSPxWHIySv61zSwBVrCmL0yh3LP4k3imX0v2Zzf7WyjTxYrGtULg1Qn0YgpaFUY2Ko5ZcH0DB2BEA8EWgC9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AU+6bXBiKZC6NGmLt3MpMKJt73zvI2tLo80XAC1tdvzRMKuzFpdRasBdoQrKdDFyb9UcjuKaLFBvZCybmC/EZm2Pe6oRD4ZscM9Py0x5akcO4lC0hjQnfyWgceZVOKQq5CnGZIBvbwm4K3SwjaOHMlhXQuN9tWyQHkE7/dzTRTLyr9fc2bGpmvaoa++sVSLd73o0KLGS03lEFgGyAC9uXDsPMyeQtoC7vbu0BXKXeZA31YIYzbnnONR/hVD7c6urINWcRqa1Dsmrk3sFCKLBnN+yx7pZRF44TTvGCJzWyk6tDLSr984eNFNazUzgEoxErOB3Me7gF1er5+a4kSneCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=u9/tYmfYxmFRAgqD4OpTn5WFzh0yW93W/Ugjneh+vbcNm+iDxUInXlsmngxwFdBtk0afGhnjf0VScaQw9l49eEF9Q2JSsRThN8gz0hzayzrLETLJ0x7dS7puEZ3gYSfhLsRDIX8eeiqd0BGJxacZ8AhD8/bCOHkTcfAVn3a1F80=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7783.namprd04.prod.outlook.com (2603:10b6:8:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 07:46:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:46:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Thread-Topic: [PATCH blktests] block/002: delay debugfs directory check
Thread-Index: AQHYVHNmNeEqFdqrKkavRYbWkwmbcw==
Date:   Wed, 20 Apr 2022 07:46:52 +0000
Message-ID: <PH0PR04MB7416A2EE7A9FCDB31E15902A9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bece2be4-9788-4d61-e769-08da22a1ef39
x-ms-traffictypediagnostic: DM8PR04MB7783:EE_
x-microsoft-antispam-prvs: <DM8PR04MB77839C436C000476D3A252249BF59@DM8PR04MB7783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnO076ogL2jAArDrNq39NFuw1IfsUDmy4LNW+UEWBYvgs9M/fOfr6BBZTz7TYvHxItwE1ugsnIViANl2ffbHGIfVSOCRjJmyPpoiVehTctudO20/EqpW13YIYENRi6LOmk+kLpLZUjz0FYy6N1KY9CKk5S6+ukfuo/Zq16bzRMCOPBzl7UBecm80xufeEJPuXHE46uA39bMGnS1rIndS7sq0sBVVMrbI6kW/NnTJ0E7y8DNm5UHmpR23JEmQVARHav5ivTSfAKFp4STQqU/rLS7AGN73TO96Da2CPEuRcakKQQgepYiMpAjY68yMposKk2qlGUOAFBoKg559HFAkJnl664aUDUWVWyMsS3/8tBZs4zxhZGTKwnKlH5dMGhwvgkKU82gD0BrDSXwr4q+EOFCv9spkyHZ8W+bN735Vc5eOThhC4+Q9vZemeziVvwevCGTeJsZ+ExYzlS4KT7gvvzTNo9suk5ea855NGbATx2FwOc+xpOmyJg0yQD3K6brdmiUhXnOHFM8nEfPLYpAXPyaNR4GPOF5dW2S77NRHJfDXIrST+gRi5KF4pRp1HBKPMcFx2+WK5TlWv13TXeHedsQRO3By7CziOwQg4vsGVvcRd3O4i3WkhxsrwA3Ivzg2DmXBKEt2Gkl1cagJbb9LaAVag94mdSv3gH7AA6D3zfsse7mZeCz5qDXeYux74RYKmxDQvBN4+5bELdWOug/Zyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(55016003)(52536014)(8936002)(508600001)(122000001)(110136005)(54906003)(86362001)(316002)(558084003)(82960400001)(71200400001)(66476007)(66446008)(7696005)(66556008)(64756008)(33656002)(76116006)(66946007)(2906002)(4270600006)(6506007)(9686003)(186003)(5660300002)(4326008)(91956017)(19618925003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1Gp6v9fLQuVjoQOrm9XcSH/HIjibH9ZOV+PLpiCvAoIzLyrYhtyXYA0io/e?=
 =?us-ascii?Q?It19z/yhOvNDievSLieOjPsiPQA1WjHEuSzoy7QuFjb9GHl1G0GUHOgnoET3?=
 =?us-ascii?Q?Uzh+7N771hbtF07w3vz3BDzAgS9NPh+Io8yp5GWKNVIaf3zo9JgAyl8qj26e?=
 =?us-ascii?Q?NIm4Oa4xgfTX2hyy22Iur7MUhM6QBb3EhMNm36LhoNWPaYcPO+bZmk+eTPAP?=
 =?us-ascii?Q?6Xa/yiLO8ilOVBAi23iBKUy5b4W6kkoAV+eF06UMSI7NsO7E3tPOsBSWrq7A?=
 =?us-ascii?Q?0PdtpRo8Yjvny0huGIRlQoTrAV0lrYmUxIHUWTjny2cqmTL2wMHykR5Eg8QU?=
 =?us-ascii?Q?tvqyOfwVeuM6b2a4+1zqcgJqRd5F/J7M8qQUcerhuvlR4SyY7+Aciwh84We1?=
 =?us-ascii?Q?Fc6p2jeJhzgXbFqQ61rE4BhQkTFitxktRuZXhqU+1lGf2Y9kPgYa5zmjZjD9?=
 =?us-ascii?Q?iFlRzqBFiJrEz1comsFhOUJex/yogCMWNGHuh57Zlc0+z7vWzM/l3sYAXoUE?=
 =?us-ascii?Q?7dMLxgNkKAp749cQyv4DNIsE6tttgOk/dCAhfXvR1QAVnXAp6d5q3c6OwFp0?=
 =?us-ascii?Q?9ne8QZ8bnczNdVuKpiYuYoCXPOBKTpzXgJI0ExgW0OrV9Qbsr3lH7ycGO9+g?=
 =?us-ascii?Q?cpef7O8/gudQwi6/2Bk9n3uDNUj9ucHhm8remrsyzR7VqybkDll/vaqRwg+u?=
 =?us-ascii?Q?1JIqdY38mblyMjxbb08iO7B2VtogTmQwnLAv4yFZEHkA9RbkX4nufJ8qlzAT?=
 =?us-ascii?Q?XloaVo4P5Tfnyqei6fJ9lSCEl4fUl7rmRtYu9ZpC6FLv+wE9TUPeqqHx0wvR?=
 =?us-ascii?Q?oDXjkGDKsvfx4ADeOAgv92J2S0IxVLoYuHN+2rveCt4HrCy8NVZKKkmxs3P0?=
 =?us-ascii?Q?OLMzlYNInbfQpEH4yKJ9jxqW4UVvKyI56mOmWCVaOjxIgUWyFmaKlxX1b9iT?=
 =?us-ascii?Q?13bMVUXs5qrr3l0R2/Ccojxa/lFN213bjoe03/C9O7byr3qGPNXwcaZO/fwk?=
 =?us-ascii?Q?468/6n1B/4cjMGtXvQAhzyJjXBnueAFwzNTB6i3mC8oS8WItGWhbrLpEcYc7?=
 =?us-ascii?Q?Zh8hZO/LHe5d8EDrX5807QfYDrdTQCQAof9CX21h3FHdtSIJe3Ox0L6jxNjc?=
 =?us-ascii?Q?tEu4Fs/JMzALKc4hEonm5EBRqLTLS4OnwIz87xqv1yhREcMPKTz1+w3Uo2Xe?=
 =?us-ascii?Q?17ivjYgdJoASJt3CpOhsyan4KHqZ8dhPVpzr/AxDzBaIBkgKu/Ys9K7z/xuo?=
 =?us-ascii?Q?COrF+bURYuQZvCNQFi1Cf8+raIuiaOFzg3zuLb2/dSnX+PkfQiu+B8ieyPYJ?=
 =?us-ascii?Q?AfBOxhFA6+eQXbrkt9LHBQMpIeUvJmtDIOPlt6QmumfJGflxVpsSlZnGUHAQ?=
 =?us-ascii?Q?lprj0J1pVlbaqb0Np8C9numeVafSY2Pxfx6abHerIaLvyHOwCXS87JDE+8VP?=
 =?us-ascii?Q?hZPCLWGlmn7t2Hk8vUtjk+lN/AIH2/EGNAhVC7gAlxN6UhidCcs6Jv9cI5nr?=
 =?us-ascii?Q?6vhRVwiCNb1mkkWhBMZDhWSndTMXfnd0uyv8FRHW8YF6Fx9CYsbG2xc5rMHP?=
 =?us-ascii?Q?jUutITDX1JG3bG0ywNgqZCt2o5lZxkXEBzYjvNqKlKdn+4tC/gaDMgTx70nq?=
 =?us-ascii?Q?uvYC2fp9AnKszIAo4WsJQu9KvREZ5UC8TJeE6uV+aS/nuR2sR9bLmR5DzE2s?=
 =?us-ascii?Q?06obef4OGBAs1E1DBTzfiGOHWCcHDoua3jqawwCB/YDf1AUuB8xOjWfERwLV?=
 =?us-ascii?Q?s/rHACUxs/NPM5VVbOD6npPXVyrezc6v/XqFoiHemIRPefAzvyuBqlLHI/rj?=
x-ms-exchange-antispam-messagedata-1: imFhhgb/KpPTJ5pie3XHp9L4emAW0fyL6muIGA2XjqVjnQZ872uPu8XO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bece2be4-9788-4d61-e769-08da22a1ef39
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:46:52.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlfyP8xDEO4jOHfRnvfC/PazTE0r40kiSpgbZIzgWV/yq1/VnWhJCX/FJ8f4rMFvim6+R0iBb2VexItJlImCOdmPBdXx9SVl7Fb200enfsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7783
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
