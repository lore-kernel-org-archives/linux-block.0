Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40993C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 04:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbhLXEcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 23:32:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17628 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245653AbhLXEcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 23:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640320341; x=1671856341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IDS+dk89rbzaFOtTyNJSAJYMgkvlmjdcGF7md941q1E=;
  b=YXgeW2TVvviG/89PePxyVuC5rzoZRevWYtJY9jMX7qdm71eAM3KbQHfI
   cMsw6TPWdnhZMqmpQ4iq9YhpxsGlIVaozpxib9fu0TlE/rMWYsezys08d
   yXa7VZz6TpVyR1YRFsTuVUo6ggnU5xSxAeP3JCKQpONtF2KjqlaExB/kN
   PaQy1Nl3jDocaDukX1Z/CF2zQZ+GRATj8bmrRyBldIiPBJRX3QFYUPs58
   hRYDzn0c7UGKw8MOmqgH0WsMWZvTnuoWv4u8ru/2FSB+Hd0SNv/avCHfc
   En08ybZtHmmMrp4p34PSfouRTmf6lGtLUC0robVhy6N1u6KrhTqfmjYGb
   A==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="187976045"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 12:32:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcCMi06MeUS9B76/MjGI8/q3X+XaToCl/3wdsDg1tfBTirRn9yS/YsoBdvgfGg8HwtU3IQ51KHNj4y9PUusM/QHlkefSBNIhrIShGekkME34SKXPK2+bpiM0bzyivhh6dJnu7X6vpvZI0/21Y0Wgv1QEeLAWCiXHw6zs3sU8VYzQ1K1oDgqOOexB1DschxS5EdedZcsPPMwjue8iDNC+JntXkLVvIv6b+fflf9ebELQC+Kb7bJuM1gWiHxsySj1SK2kaYP1wo+7Tepd2uchTfQnvcF4LSBFTjxmLmWRraSSRwpzC5hb7xCwEfkZbyfzr7blFSBn08pnrmYAimCiWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXI5nvLL4Ntw+H7uE6y0hBvaILQnWNp0LPGLHJk9wU0=;
 b=JZ2zzC9tsX+tK3np0R3V6y/I4gKbHSvaZBleElfWGRYyILe1ddeGOEThHQnobsXTMpYBhTuq/cDRgzoaltuXnwkA98PjUj4bsWx7cF+GeJSsCmV7bvbGaM0UPzA5LvDWGfh8cMwgcEsMXLVBQd66ufiXxd+zKehRPQe2Wf+lW4rEyqFSvUA7WqrXCvKg3/YzxqahO933R6j7GIKlPcChHG1bWWzPE2QyvAEzH/5xZDxQ8lmQCA/j14ved8heGa39RufCREaqt49N5RG0bG5N0j+uxntBfgLAo6If0ef+37hh5NsAnLLaAnG1uhsYOaKf08eYQ6HlfKOXDsF1b/NEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXI5nvLL4Ntw+H7uE6y0hBvaILQnWNp0LPGLHJk9wU0=;
 b=khvSnTwqO8dJwXp8uTLAztRFeD5ux0BHNx5UgR5D+FnTfYT/wexi1PMmN3ouFE0KufXTFi1gyC532Gis98ogf8jJ0hDra/E/mVC4/0PwSXioM49e8vxXJDQBXh5B3Y2KQy+b9uPlylpYqAOnl7wH6bF/HuplN3SRWqURK3xuuDA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7944.namprd04.prod.outlook.com (2603:10b6:8:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 04:32:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc%5]) with mapi id 15.20.4801.020; Fri, 24 Dec 2021
 04:32:19 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] null_blk: allow zero poll queues
Thread-Topic: [PATCH V2] null_blk: allow zero poll queues
Thread-Index: AQHX6Eb7Cs5SXvZ3O0ieh809OWrnVKxA8IiAgAAA0QCAADyQAA==
Date:   Fri, 24 Dec 2021 04:32:19 +0000
Message-ID: <20211224043218.lmt5cuosout4hap5@shindev>
References: <20211203130907.3667775-1-ming.lei@redhat.com>
 <20211224005237.ryuyjrrn63t7y7sa@shindev>
 <8b1f05d7-c741-24e3-be67-bf3616ff1931@kernel.dk>
In-Reply-To: <8b1f05d7-c741-24e3-be67-bf3616ff1931@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30188276-2eb5-47d1-65e5-08d9c6965f65
x-ms-traffictypediagnostic: DM8PR04MB7944:EE_
x-microsoft-antispam-prvs: <DM8PR04MB794485BA1BF20B4D5D8DF85AED7F9@DM8PR04MB7944.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1LpAwMzUiUz8VNqkf16rTODqGYeI13+4CKzuRdahL+873OQvN5ytclgnm3u2tzcwOakdpoN8r2hobIvqV8i6Gry0F66tK3pp8R2UNxfVrVnoLu4F+QDOiiKmLGqNg5WHwbQ3X0FnQZGGECBCC6EkJIe4M9AlrGZANTRoJct3Vle8lwhPH5mqp2/Bvoe0t3ghaM0CJNtRMJ92d/fqR7f28jUcVC9PRmS8WIRuhs5G+g6RZ6ZJy4U2eJOUvndADwc99WDnu2bfLgPfYQe/ijaY7SulYf8pQN+qy9UbeF9d9GQPYF/jYyHTGQNSQzTOTa5j90QHbnTXIdn0D8QXBiWs3tQeIoFf3izTFL1nZdDhg7ZpzZDWnXgECERsxKgCe/Kds/4F3e7U8rUhv26KszYLbeJRdmmcM45z8vKzUVoTP9GM9HGikzmwQ51ws55kZpIejHLqB8aFWANulhFVBnJL4VkIgdQ2e/BHYdDWpAJafUgg2h4jRyVpUzQaurjlNmSFL/NFgC8tLtcqjag3wxOzks1G0c7bB70OQNB7wx7SftbYJI8dugoJ7HiswOD88g0s9qfQbE/nVcnCgqUTBBiWpybfXuvDLf8eQddqlGG7Vw5lB6wuytrwQg/ePKksJzVFVibc8aO8c55YOVLdNcxk64V5b6fvJCFyZ3uw/+UIwhAQKfSDABhjuevFo+pHNcs20tnuiMtfWaR3PIr5Q6KSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(83380400001)(33716001)(5660300002)(8936002)(6916009)(26005)(122000001)(186003)(44832011)(1076003)(54906003)(38100700002)(66946007)(53546011)(2906002)(6506007)(316002)(508600001)(38070700005)(82960400001)(66446008)(64756008)(86362001)(4326008)(66556008)(6512007)(6486002)(91956017)(8676002)(76116006)(71200400001)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JrJjId+IDhLe6I0Vd4875ie6PSJ5/Uk5UzjkBX1aiMq9899aAE34xBB4ywQY?=
 =?us-ascii?Q?BM0qGPbeyLPV+aKNYva/n4p3Tdh9pc7SEnAbhDtZMiJa+mY8/VOy9ZdLXFCX?=
 =?us-ascii?Q?jKA7BropYIUN7wyy2/r9ERyORlwiGIVDWPwDaAx6zM0nq3iEGbs8W1/9Klrt?=
 =?us-ascii?Q?XHoa7w0DT5jWGeZoBrtyNDIxGGKINPNOl8quraVOsP4v5bVwep0i6mswf4BE?=
 =?us-ascii?Q?9UCSowqZfhqZiF80MXTED8GTttASjZzbEKkW4Z0Ok7edTvbqdd52uo11YVGF?=
 =?us-ascii?Q?szBsjgGyzL5WZkFWa9BEqoxNxxTNYOOS3uJfckVC0ZUEuPa+1Q5QQ1slP8sA?=
 =?us-ascii?Q?Wu/I809NnPYqsTfTthXP0d2CC9uvs6cSi+OTeJIerCdAhXjI3l61RVcUiXAa?=
 =?us-ascii?Q?F7pblA/uGcnTRnbOu0SiNfvd0Ih7Wu9r4JAmqiTEBM+4BzjPFhlzWT+ClF3C?=
 =?us-ascii?Q?BjCxMoUifDpKxDTASySAtKBgbgztynp/A1Eos+Pa8nXFcybahWUID8tWGfRi?=
 =?us-ascii?Q?55cJ5kAIn36M3ZmHBjnSPyv5x4xM0DGeN765WUeqybiRJ/QO+joa8I5mRPhT?=
 =?us-ascii?Q?R0l+wPSjNnNuNcJ3L60ow82bi3Sv25wVLCtau+tReHmBmcBu9Qx1OWa3lcub?=
 =?us-ascii?Q?VQhcHej1wEVpG0ogBflo1A4m5BpPbQBO19SMwNeVYb8gtH3IRUfh+azENlvl?=
 =?us-ascii?Q?wBN3RM67R3dHEcsS+8SfP+Org3ENyoc10yCYscuyWJ4VFcQ4xjmcTJK6Jh62?=
 =?us-ascii?Q?NF4iZSawvncrnYfU6TDZose4lVy/90WZlXIGLIL6KjkD6eua7khFW7NZnu5E?=
 =?us-ascii?Q?cxgGQUyVFItY+BJpgBeEOqMTmQnfB4bP4lwuZq3x6SpQ9JZwj+0zV3QppGQ5?=
 =?us-ascii?Q?M3Xwg//jeLS30na3M2+3nTkByuo63jvrj6mSnCpinAypjrhB/mGP+1eLy+IW?=
 =?us-ascii?Q?UFVQBle573pLRoP9mxpJ6h+nfklNx9zkBGLtIkKkRAMJzgQa4QR+DNqjF4DP?=
 =?us-ascii?Q?6DhUSgdO16z831bKgd6+yOqYKB67BYle/r9iLBMtIiAX072x+Rza+MZDCyMX?=
 =?us-ascii?Q?JOk4SCP2b32XuG2WLZv2yAX38p5ZCTxJXq5zuZuBVGFuRqcCSz3v09Z4T+TM?=
 =?us-ascii?Q?uMr3VDke297ccAKUpWtiXLNhVVOE5U6GZ7EKcE9WMeeXWoqJq7anz5l5OyhP?=
 =?us-ascii?Q?suAIq7BOrQMXXpO21XCRiBSX3qiGqEeEflH18VEA+7Ynpd/GnI/c854HMPG5?=
 =?us-ascii?Q?T/GoyvyHCPJFJ7LTP3tR2UFGR+jECuIWBfUxf9HmTeNZy5d+eJovr0WrB+M/?=
 =?us-ascii?Q?9HXnm36pPJqzM0G/oVOwwCjpwTGQNQb5WqUSHqfKj0np2lODpmI9msJc84Y6?=
 =?us-ascii?Q?r2hnfii2J/aMH7HPgojjNbChM8OZKIIs/91EXBrKy2ak66+WPhRHZEMiEckp?=
 =?us-ascii?Q?ofaLpFoHFN95q8jXLdyiKYVMBMuIK6IRAXoa0nRSpEuLruO/y72F39RvVLXm?=
 =?us-ascii?Q?7nXtCS/C+X/oDLDcAdNrz9kWa5r2PbhXDRgK7nvSBbZvhcZwDWjioaQTCfAO?=
 =?us-ascii?Q?ISzLdUQjuvauw7o7vdjZrbWEEDNepXSJcgAC4dgYwxdutCzFphB4/f6K2R7r?=
 =?us-ascii?Q?Fx8qNzGqpn0g77P7aclnxzay0ZW4b9o7Md88a/+HQrYdnafEmc641VJfzDez?=
 =?us-ascii?Q?dcqAHa4Cqne3ieKGWtPv6PWupm0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD00A6E11CECD946ACC3B573E2D4E336@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30188276-2eb5-47d1-65e5-08d9c6965f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 04:32:19.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQQY9wKGYKyrE3/JdpDprACKUIoQNTXWEV0oFgi81GrioEm8dQsTrIBVeVsJIVGBmY3NT4+0WDcCFItoL2wyr0zJT1F5Ash1Vz2E6VfTKWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7944
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 23, 2021 / 17:55, Jens Axboe wrote:
> On 12/23/21 5:52 PM, Shinichiro Kawasaki wrote:
> > On Dec 03, 2021 / 21:09, Ming Lei wrote:
> >> There isn't any reason to not allow zero poll queues from user
> >> viewpoint.
> >>
> >> Also sometimes we need to compare io poll between poll mode and irq
> >> mode, so not allowing poll queues is bad.
> >>
> >> Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll=
_queues attributes")
> >> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >> V2:
> >> 	- fix divide zero fault as reported by Shin'ichiro
> >=20
> > Jens, Ming,
> >=20
> > I find the V1 was applied to the for/5.17-drivers branch, and the addit=
ional fix
> > in the V2 does not look applied to the branch. Do we need another small=
 patch to
> > cover the delta between V1 and V2?
>=20
> Yes, please send an incremental, thanks.

Thanks, and Ming already provided the small patch (So quick!). I've confirm=
ed
that the patch avoids the issue. Merge to for/5.17-drivers will be apprecia=
ted.

--=20
Best Regards,
Shin'ichiro Kawasaki=
