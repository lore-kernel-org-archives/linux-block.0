Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CAC43334
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiGANq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiGANqQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 09:46:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A623141
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656683171; x=1688219171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QmdHmTrPgpAMgNTAWCdMtKT9JVGdMFSlSmM7cZvdOHw=;
  b=kq8uws6T/wHw2/5KW7oMhMF5osVLew9PFUumY5g79PI6o8+ZagiXJhlK
   heTTh2PZb9xlohJ7ox+IhYEUMfHwdI7+18JDqyOxs5w3SGAqfqQJgvkN6
   B9SXcARNYw182ZusSDWXXHoWrdORgl+JAQcRcJzD/mbPFUFEzIk6/1qa6
   /0HKC5I7QcVS8C/XwqGyBIBXJq2439QktjAiZXxnUjvBLgPJArE6O1de4
   uDkWBfj6aen8/47LCmoc4mYvZN4ZEuPagNpIG3HnqdPgzRpnZF283vyBT
   46x5S1dzJ9S+pPUW2rSUrTD3oeoaW7F+Q5E9lZ5SjjYJLXbkd4O7C+0nD
   g==;
X-IronPort-AV: E=Sophos;i="5.92,237,1650902400"; 
   d="scan'208";a="308913409"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 21:46:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBSHW7p3xeV5Ijrg1qRH/364JHR+vOtMyXK8N2rwVZow17pSbgdb0DIClRBzPAeUw+KOqYv0tL2ZrGL4SoUgQHYEIoxjCf4f88EUg87eNjmz63aQvx+RXd2pIUp6EyP9UliTqKZRmZE47d9HfvBRt812qA7GxsHGRO8bAagOJnwNkTQOlpW4yorJzsOS/seUCr8VVGUCacMDAUqvRD9rtxJ7eCv5g4SXP/5htqdnYX4GH2kDRagO4MHi8zL8t+sr/gKd4o8DSq1i8LL0HMyMXLEQ3SoCUt16IP+mbY9B5mjrqLnHii28M7P47FMYwOG45huLZtQnUFpZBgaZditqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmdHmTrPgpAMgNTAWCdMtKT9JVGdMFSlSmM7cZvdOHw=;
 b=Xn9BJJo/oo3GsaO+8co971KCuLuCtO3oqHk9R0NfpB+HnzvRfJAv97z+1/g0HzFO88el/tJ+cT9HZHd9ty8ToVwSqTNgGwx+s/rCNm4wubtV6hft98c1u6+sxJd87QlwYKGNnpwWjLoFOKOVRsYu+QcXHflTjmAlv6R8Gy3WdaSx9h1Wd6OIFzLJXLKKxtyFTkh5e0cdLDEELj5KY0ZvUWSBwH9XfQF/oQMcuhMYaw92j0ursj1UCPLkDrZlaAbBCqrlpp2BiIvHrprVcc44KCjERVpFMa8A48rpsKoClHNCYLufOetkrWppTUloiBBRyHErIzQMZLGkCLWnuGkSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmdHmTrPgpAMgNTAWCdMtKT9JVGdMFSlSmM7cZvdOHw=;
 b=MOZi7NpqeecYo6jg/yjYHuPFUsg7wc4ltBH20vLW5bilfGJTk/gW0k0cNDcKxrMMkdlx361prGOL8Kt0Alj0x06fNIW4cm0IoZ3U8qr1eixWNG+KV2ZJKKCsAPLKzr7OlUvjt8meiKXWp2kE7/IAxh3HS2GIKPWfuaYUoNmGcJg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0208.namprd04.prod.outlook.com (2603:10b6:300:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Fri, 1 Jul 2022 13:46:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 13:46:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: Re: [PATCH blktests] common/multipath-over-rdma: skip NO-CARRIER NIC
 when start_soft_rdma
Thread-Topic: [PATCH blktests] common/multipath-over-rdma: skip NO-CARRIER NIC
 when start_soft_rdma
Thread-Index: AQHYjGe2ug1ooHvJRkiA3OAdd/PwPK1piQSA
Date:   Fri, 1 Jul 2022 13:46:08 +0000
Message-ID: <20220701134607.fg66g5nrllnhqdc2@shindev>
References: <20220630095625.2705173-1-yi.zhang@redhat.com>
In-Reply-To: <20220630095625.2705173-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6b486cb-8eed-4751-f007-08da5b680d4c
x-ms-traffictypediagnostic: MWHPR04MB0208:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOmtvDVHWDRdcusgJULG/FUJtCDkq8x14dMwe0NX76DtsweoMJum5PI3ckoi3F7t60aiA6WGiN4tMRB0lj2IwfeJdOkNLSBNg1hAeAcatOTr+lpy1snD7RZfLfenmw48I4ik5ib03s1DVP4qhgbRYKgncvc7MtyACBlEKoZAeVtxAbHFElsXAH38G27dLjrjrGFKWU/zd4C3hgP5O/9veVtcNCHTULiqvJUaypNRiT6OmxsdMVXN4rzy7/AZG2wfy9i4plPN2IAeXchRYdT4+uac15LqQPUGsK+Imx8Z6LdUVceFJNl5Sp5JZpZ9OQDaeilY3Vd9zUfPAYNOrQ2edMfrO6WzDRMkSW4y9GiXPbrgQihPbGtzT5cr023elBLqhSlT3KhdYoTliEUfcC97AAJJJ97uawFAidpAg3JaRd+sTD0HHf9fLY5ce1y0xv8K1/kNEmaj8ToAJEdlBtIRLGKFrKgIXftBxChSaHDdSoDrhdBk0CxAbKc/JSdy4HGw7wYBYNpEKpAFf5ZzlTYzRHhN4qGWOy2BzX3qM91LXRAsy6Vhq/KOLf0xT5NoIirpdwZGoBAuuGOyFLa4bin/9OAtC3Om3UY2P86a/nh9mKWuKZKacPNAeen088N2kwG98AvSxFnHSuPg9CSg7FjG8fcNxzhezHZQSZtnslIbvcb0k7fcSrFFpNgfPN+29X6RudAcUZVVQ6LSsnxRdU3fMUv3hNF37fnck03YdDHOnI0md4CDmgWI88JY9xALg3VmZW8j55L0lmHDe9ffKHyhKa074z0yGTIkt4l99AltcNxu+hIZlKHTnbeVTryad5Mw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(4744005)(38070700005)(44832011)(6916009)(41300700001)(2906002)(54906003)(66476007)(82960400001)(6486002)(5660300002)(478600001)(8936002)(186003)(86362001)(6512007)(316002)(9686003)(26005)(122000001)(1076003)(38100700002)(76116006)(6506007)(66946007)(71200400001)(33716001)(8676002)(4326008)(66556008)(66446008)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sxk/B+3RmKdW7o1q/cPcPEH0W+wFij7qzlqMeESsfWSVxx4hIH9be0TEDzl8?=
 =?us-ascii?Q?9spTihyQA295FYWlW8Dk9FjMWmnpAgXaPz902XV/wI1Gg7KMdGCbe01gcbEi?=
 =?us-ascii?Q?wymUU/A7+sPzK85MJx1p1lKxj/AxANzb4bjLrgSfkPCGV6VWUFXZKZD48kP4?=
 =?us-ascii?Q?rBA3duOIDh/bDtViKh8iAq0mtBUBPT6bsPwBdcdvbPKutSq/bqi2TKUfVmb1?=
 =?us-ascii?Q?gUBUAxMle94hNK7ZxbNm2k155tTHCr0H/wASQkwPt/dcBtRUPw379MQrJPGr?=
 =?us-ascii?Q?qZyzEAP9T5m7dlKwPqLgw5AoZGttF32NkIriOhXhfnAUFh9GzdXo65HGGAGj?=
 =?us-ascii?Q?Vq6vvsjyN+ZwgH+Jz4wEYveBkw//wTjsL2ZFuK8wVK1VWyc31y4DeYUEnUYO?=
 =?us-ascii?Q?WkH87KyZm9YrZ1ZLWRACAv3xom1CKWN7jCB6hUfYr4GTzMEuhHVfH+eicj7e?=
 =?us-ascii?Q?MYWiBTUJC8xgAeT5DgkBlUtMtBG2wIkx9gcjL4xR+8ukMdjmgOm6hF2mWUdV?=
 =?us-ascii?Q?SrHcS0V6IGoP6LzokbcCT7YK15AGTfLLhfYP9CAE1EcAgktIuITfyFl25cJs?=
 =?us-ascii?Q?1Pb7LXKBY4XW2U+Yqu9RWwUeIIlU6butPYI8VTxK9S8FW+i65wiyQXsgQdkz?=
 =?us-ascii?Q?UgDQPGCb8ndr6GzioTHRi63HOEMkmxy9xtKawBD1DGieNnDOb5EUh5pPPlhl?=
 =?us-ascii?Q?+PqV/UVdB6jzgkVHfk2YrNblIiYdJmPQ+dz4thXt4N+6enD7y2JnRsQK5Jh8?=
 =?us-ascii?Q?tts4pfIHmovJwNiWfvvMIUNlrAfECLs4P7tMPNybOksrCtAi+owU3x55aesF?=
 =?us-ascii?Q?Rifnmuwt0wQ3vr4ZE8VNC4wBdRhjuhEbb3Xs58PSZWqOB6do6B8w+29mw+Z0?=
 =?us-ascii?Q?rPlFM4mDUpjmECruOL6oJPMvrpFzV2M2z6ZfRvZ2quNRVkAhLx+7SW9AoN/A?=
 =?us-ascii?Q?3AAGmq7PPPszPs60iwxTjKz6kJ48J8SWx1z9M/1VIr/28Pbm+C86ebC3tuTd?=
 =?us-ascii?Q?Xnndz8wbw1ajFUI7+YXTbTQcV87UteYI7BCAlqy3Vp+UGTouU8DFvFiQ3UN8?=
 =?us-ascii?Q?BsoIDGm1NpZ0fS8+UGdZgOpHTXw7TsXIhquvP/cruCkJHXH3qi6anX3dmlP/?=
 =?us-ascii?Q?/bAFI+C+3MerRezFTnFUXepW2QJsQ0tKqfaBwLdTd43ssbMhR31FJFEWjzA6?=
 =?us-ascii?Q?byz56TGjtIuBV3dPT/pqXQUk+EWaZH3govaRDtCMiSd+q1Twsa6IrAUkka1H?=
 =?us-ascii?Q?YXP+pULDhpQN7g+Q0diKFuKFrfefT2duz59IcRlDXOTdTWPmokWKIpcPd5C0?=
 =?us-ascii?Q?8qQfSEteXGX9HLz0mBDxBPpuqlvpxqc5gNAub+gD2wFa75CuDJW5ynQCTjcz?=
 =?us-ascii?Q?mTpb56bcg6MbbYnRAWeFRnpmMYfrujzHeHQz55DG+9I2LReZeP/k49VqTdwy?=
 =?us-ascii?Q?68qQHNQ8L1MpMqxrLat3YD5PQaBPnHpwLRKJ9U0u3YdCrtZRbC0+P73kNKw3?=
 =?us-ascii?Q?UaQwz0TTV7vtYqaY/88esEEeA5rKqtblBxxEc1+w1oxevd2j3E1UPFsY43B3?=
 =?us-ascii?Q?R0udHjdj8orxWSCq2ByQC3MmkoXdJNYj60E/U3ceWOgPq1NG4iit1ZppshYX?=
 =?us-ascii?Q?Or+jg/nD6DW9xkffv4WWB4k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0D6236701F158459B2FA99C21F48C3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b486cb-8eed-4751-f007-08da5b680d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 13:46:08.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0ISVS6ExlVOKnS56rnoayL1VVLu5SBNIW/ly1GAIC4FJMbkoSJZFPS34MgDqfkdpgpRqPYjCePFj8LlTkALr8/1rfBpm8M0Mn1KTGeycoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0208
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 30, 2022 / 17:56, Yi Zhang wrote:
> The rxe/siw driver will be bind to NO-CARRIER interface which lead
> nvmeof-mp/001 failed.
> For example, nvmeof-mp/001 with two NICs, if will output
> count_devices(): 1 <> 2 when the second NIC has NO-CARRIER
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks, applied.

--=20
Shin'ichiro Kawasaki=
