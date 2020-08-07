Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD93C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 02:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624E8221E2
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 02:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JLqL4gIs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N/Ytqrlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGCxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:53:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11477 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgHGCxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 22:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596768799; x=1628304799;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3hBG+CHOPeo76GP1OR3NsBxa80fM67TQ3Xns0GPO8KQ=;
  b=JLqL4gIs7zvsS4vl6GLxqzPviX3is6VPj4px8+Nlx9H4+e1V4fmDkNgp
   acQaE99XK857kwE+Wz0Y5Dc0GaH7QC2MNuENgWhuejCh3HjsJ+BTUhmka
   xRVYq1SbZ62+4KDzYN/Em5PGFaK3h3UGNRTBrn5/bwoLszTmx/7VQPblU
   u32CXeNKoFajS8xtK1HxO0iqJJtE8kRaN3k/caWEXOyxTMidnwbcyYVwM
   4o4k/nZmMmje7+xNgGHpgSWe9N419/U21V3Tm/g2V5NRf1DMHk5u7WkvV
   3FCPjMjuMcJLujhgnTXDmRh4krcIY7nCweJE0Thrvoa46yhiLe4ZJN7k3
   w==;
IronPort-SDR: jbSWEHM8F3GplMXIhkU7sgjtxfZ6otdhdqlhpreyYOyatOzBFug+NL4ORAwVq6jzMuA6iX82Y3
 JezmE5VvMA+dT75B+n0Rdmc1jiDIzLvt5IJ21sSTcEeqm30fVafDxhhgxgdhM0x5/TM1tkTB8J
 doDdczwIXm1G2d64mDNSKzEWc/SuxplhooYRHb6d0czgdI6EFdPVDoesmFpIy7RnSCThbJuYgg
 RAFw/LNFooAOPPKoFTo2r7G9zXM1FW3+AKkBk8A9JCVXvZphGmIYDlpfyAo5/KhX1/r9J4joEx
 F+8=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; 
   d="scan'208";a="247464091"
Received: from unknown (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.106])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:53:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBRC8MEbbIcIAA8MdIO9jxBa3g4UFO4qKecSEuYwQZG2FApirhQcVr0i9TqPOg4+JF0occWZkSnfuprYatO7nCexRSLEyz+uLrcNIo62vb4/b4pRbYp/7E2nw5/zemAiHtH4150KlboiqN2gRNRuKKQ0iTtU0AEJBvAJhrkQMjfOVpbZpD0YAYsiLIwLHcKII76W2LG96Zt1AFp5HMwEIt6VqXhMdGSWcdi4IzD10/KWEswUGmMvaOYvcqSbQMc2ZEgK8ltW4hf1eIKg0nOiyPDvTeURmaJpyvEyLCei0d8pBPQaVXBqlFqJgqhS9WTCEnNS51VTH5nCgbcx1X102A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zruAsqhVRZublUrtqpxSB0BtlZTykl36cv77GK0TI00=;
 b=LSAaPy1R23Hxcl5syFv677S7XWgrw2efV1wlfvgdZqTkAtfr/KMY9rl+2ZNg4pdrJvBjhya1X9RqPdqx4DitfzDp3EDROqryZ9cqzcb0EmYil/NUR9nuA59F+02HGaOjQ0cO1Myj7zqO1qX0GuoXUPYOHB7LKooFPuoNj3yvL3MOgiwkAhXyISUv1sAjCn7QsVDm/ZZ2eQHUmT2hVCbjGEZ3XoO/GGJj9OdLOM5x9anA3tLGRLDKIo2DFJNRJlaP408q+EvH1m1U7BHMFoGcvw2l/AaYvfuoHpD4DTR2yXmmKkk+tbLSfE5QQ1xLWk827PbQ4E/3WXObXMPVjBw5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zruAsqhVRZublUrtqpxSB0BtlZTykl36cv77GK0TI00=;
 b=N/YtqrlxP+sW5l+jlsHIpc1kc6dayorgZPVIV+gvLOB/3sGjQQiTEk/POobY2mHyZ7g7r+wufuIrwzCT0ZUh/HyUJ+03ETtXX0lEztDQaiscYTVPIy36Nc9ZIZlXDT2uWaNeVp9HrAp7yvRYOLK2JDQaqm3wD9nWPjyyarIt1gU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5687.namprd04.prod.outlook.com (2603:10b6:a03:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 02:53:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 02:53:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Index: AQHWbCXyfk97HUGSg0KKD45yS5/FoA==
Date:   Fri, 7 Aug 2020 02:53:02 +0000
Message-ID: <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69d6aa11-3d74-4ab4-5ce8-08d83a7d00c3
x-ms-traffictypediagnostic: BYAPR04MB5687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5687DA2F5D860799E209D8B286490@BYAPR04MB5687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HP+zK/GID98Xdjo2F00anGZR5GARyLetl8YuN2vjUIn5ZBBkaAn7lyAYp3ZTC2HteAwUt74W0z9d7XmlsObbHEKsyyyi+pGiUvhiEFlHvLFe+69ej8EDf9r59hsj2yKj8esSfRyf0e3YnxyQ6ivP85UMECeV5ctlYFwgdzxi/YLId1mqtld7o2MxQj7+DVBICgrvGhZbZu55Tp9j7CwGTdMX/ltYEcmfsWhJ+4aehVtNg2Cv07d0+2I3TlhOucOYNRlhjhNKC4/TcSE3WKI6zGN6srYuQt3Ii520BouqmYagEC8DBjDq8+Lb3envgKnC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(4326008)(54906003)(55016002)(2906002)(76116006)(9686003)(478600001)(110136005)(66446008)(64756008)(66476007)(66946007)(66556008)(316002)(86362001)(8936002)(83380400001)(71200400001)(5660300002)(7696005)(8676002)(186003)(26005)(53546011)(6506007)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RM2RLPx3jNKsu6bOq09tB0b3tnJiINS5/8wTLcck+fJrHYM9E3k6LUhfGdraB5kztPIXGm2gEyZAhwlh2fJ8VrvBXX79QiiNi8rDAeghw4u04ILBticJTKYUOBmHtz1bJXxI0cQX1GRi7gMmH30Ga21QAVfPwaBNqA0qXgcyW7SqG7LyVFf8wkIZp/BYrotyMQKFl5jgicPKw9x5Lr1AwwGGQe97IFrsPiKykeIekbhfVWYeyAJZJZk1lPQFhNsU7FVVM0mqKvTwh2sLRc7MnJnRL/p2QoduyeOWpuOZ2/oykBYsmXAwSPZoadLyr/BbbifLOj8Y0HR5jCsajO3MEQdUokApfKFY7K+ZK8vkTZCzD3rF2jWy22QJYCkAvaLPZfnNYUPk6b1ULZKdSmlsSlJDgKQms1OfZ4alkHU6hm3xVERZCysk+sBOy+gHbo5aj3OSIu/94i+1FuL4CBbgU1lrfBq+cOKcke/E9EjAtiIZw5ozkfBXLPMTLbBPCReUTg5J1jVT67S/FRLmgdIxE5zkDPltsA2+wZzssey0A1OtewXSD5tacyGKivPMb3hUe/95yItVNtfjRMZSwAhDkYJHNMWmiy9blpaMv1ipX8k1uC+svLu3+jQ7jxWc7nOD1StsnMfPUDKv+YyZK2pbng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d6aa11-3d74-4ab4-5ce8-08d83a7d00c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 02:53:02.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GQ7Gmw8Uxfx7ozwb2InUBNidD4QY+zhICQTO9nuWkkREpw4QJj52FoZWfISGl4WEkoO4lzg4h56F9PIdNJKtzZQ8sq1SXTk8D6MMieFTAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5687
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/20 12:15, Sagi Grimberg wrote:=0A=
>   =0A=
> @@ -97,6 +97,33 @@ _setup_nvmet() {=0A=
>   	modprobe nvme-loop=0A=
>   }=0A=
>   =0A=
> +_nvme_disconnect_ctrl() {=0A=
> +	local ctrl=3D"$1"=0A=
> +=0A=
> +	nvme disconnect -d ${ctrl}=0A=
> +}=0A=
> +=0A=
> +_nvme_disconnect_subsys() {=0A=
> +	local subsysnqn=3D"$1"=0A=
> +=0A=
> +	nvme disconnect -n ${subsysnqn}=0A=
> +}=0A=
> +=0A=
> +_nvme_connect_subsys() {=0A=
> +	local trtype=3D"$1"=0A=
> +	local subsysnqn=3D"$2"=0A=
> +=0A=
> +	cmd=3D"nvme connect -t ${trtype} -n ${subsysnqn}"=0A=
> +	eval $cmd=0A=
> +}=0A=
> +=0A=
> +_nvme_discover() {=0A=
> +	local trtype=3D"$1"=0A=
> +=0A=
> +	cmd=3D"nvme discover -t ${trtype}"=0A=
> +	eval $cmd=0A=
> +}=0A=
> +=0A=
>   _create_nvmet_port() {=0A=
>   	local trtype=3D"$1"=0A=
>   =0A=
> @@ -206,6 +233,6 @@ _filter_discovery() {=0A=
>   }=0A=
>   =0A=
>   _discovery_genctr() {=0A=
> -	nvme discover -t loop |=0A=
> +	_nvme_discover "loop" |=0A=
>   		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'=0A=
>   }=0A=
> -- 2.25.1=0A=
=0A=
I'm okay with having a wrapper for disconnect but for connect and =0A=
discover command it can have many arguments having a call in the=0A=
test-case might loose the readability.=0A=
=0A=
The downside is it will need argument count handling in the future=0A=
and makes things not easier when user want to skip certain=0A=
parameters, closest example would be _create_nvmet_ns().=0A=
=0A=
Also if we are adding wrappers why not move $FULL 2>&1 to avoid=0A=
duplication ?=0A=
