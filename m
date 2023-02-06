Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883ADC05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 14:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjBFOfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjBFOfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 09:35:01 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393823D8A
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 06:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675694100; x=1707230100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BQdC9HseWxG2pw/4NjhI07nNr7Ujn5ZDzs43KQQywFc=;
  b=K0KBDnCJtcM+KQ8vhNM9hmqb0XzanPLxFXUAMo+uoSczqpDsKWctWZnF
   gb9GXgTf5/9e1dze4sI9LUZeB/COr8b8+GHPZGQe+llVR/AMFiAn8wSup
   y0mwdEKy+FPfEqk28zk5mDKJ5Emno0liWErNvtn3IPuCp1eHe4FAAYrRa
   spDr0q5TIzPyvqWy7XxxX0ejwOO7ktWb3N31nOETP0lVd53O3KCBSstfZ
   XwbvRiH6ztPISLB0THN7gyEuwhCM6j+j5Os2kZml/9DQpm/Ts3/Bj6zuQ
   MG2KS/V2M+z85u493vfJb7KSu3RP1EczdVZkUO+MSZv+HKURdIplX++ct
   w==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="220940981"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2023 22:34:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw774mqGLHvgZBQ7L7P3ZxSpL2aoiwZovJu44mi9L0JcUomGnYL5FoIeDm735I37mW4NtfqSGbU/MGCvBDdjNSxL1KdP+w8rvRNm/yITDaRqPBo2iUQux0Xww4DMoU0DABYaP1lFGladYHicl0Rny8sBiGzvCKROGcw4G543ou5BwmOJRx4YPXJ7e5n4USaPKbZbB0Vh4KrLzR8KBQRPbrl81vgl0YzvD3Z/Mjf1V2V37I61XSkJJ1PVZbW+aYgvPNyyWF4EqqLU/zDMJVNyVWcKx//GC+gp7zc8jDj4Ig9d0DAGSv8ZwgRgQlZJ3Kqks5Zn3rGJzQ6RpTtWtM3UWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQdC9HseWxG2pw/4NjhI07nNr7Ujn5ZDzs43KQQywFc=;
 b=Yp3HtAMHEKqb2ItUXUQpNQKwaBtnq4DOVNd2lkU14HFXeCKRtMnu77Lc9T5r0guOPeAnZQ/lgfmbuD+sreC95ExNeo2UvAdiNVM/JyZbMN/4Sct4F8bloR1LI8ambpKT1T5r+Zkbhkm9liQA7eQu9GyG28XU2EW0cNvAZAqPfljY+pv+abMdbk6VMsLkh9hAWvnj/c0MzprrxtfZvbHFNzHU35M8zVbaa7/Wh43ZHO2OBIsCzyhruBs2dTzRjTWPloooPxk07hJ9xzkVw/6cqjWIPDUbLT/yB+IJHXEjt/D20PippoY8fw9sZ13yBoF1Kzm+8puNnSGmn/p1sTiwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQdC9HseWxG2pw/4NjhI07nNr7Ujn5ZDzs43KQQywFc=;
 b=mDDB9I3hxy7CE7AXTMiVoFYm3ybg9Q1EqheHd3iIdbTcEjuQXMwtZecxJMLio6uU+rvTTBz8u2jWUWFks8B76IQ6g386j0YJfbBAls8D96eWDClHFtUZE5KefjsGqTxOMJwb1Q+775jRa0XVi8qAS5RyS89uHnfCqHEKMKt8qeY=
Received: from BN8PR04MB6417.namprd04.prod.outlook.com (2603:10b6:408:d9::23)
 by BY5PR04MB6598.namprd04.prod.outlook.com (2603:10b6:a03:1db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 14:34:51 +0000
Received: from BN8PR04MB6417.namprd04.prod.outlook.com
 ([fe80::11f5:2a3a:5b5c:63ce]) by BN8PR04MB6417.namprd04.prod.outlook.com
 ([fe80::11f5:2a3a:5b5c:63ce%7]) with mapi id 15.20.6064.035; Mon, 6 Feb 2023
 14:34:51 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Thread-Topic: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Thread-Index: AQHZOhHSKPSlOHoOkUKnFFq3rkeAba7B3rKAgAAbshA=
Date:   Mon, 6 Feb 2023 14:34:51 +0000
Message-ID: <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
References: <20230206100019.GA6704@gsv> <Y+D3Sy8v3taelXvF@T590>
In-Reply-To: <Y+D3Sy8v3taelXvF@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR04MB6417:EE_|BY5PR04MB6598:EE_
x-ms-office365-filtering-correlation-id: c3ad249e-bc15-450f-735c-08db084f4e48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXzYxLnHQLfc2WOKmtWYmwmA40BSklch1d8uNO+Qx1R/+8C2AL8m2n9hSKZqSYFW5WGK+6oPiYrs2q/NbMBMIqr5m1RW6jK7YYomzIr16Dx+Ifxu0pqO5PQ5Zgc25vLlwIWeD87yVnZoDID7FUy2D39Nf02OK74HJTy9Sz7ncnIAUR2XiW+W99EqE1UndoEqXiADJnwOPPi5XRzNe9DO5EgOHgPNT9Pq5mwzXxk+CUxNK5Tqn+MxbxE/JRAwEPPifFgvcQ7s4HWjwgVod/gk623FVmi5MDlERwrcG/rCuHZNHUZOqWanyuHe4GrwOs3Ek/X9LJAzWBshLAIf6CvU8wEIIcvBiZN4Qw0mJqjX6gmstsUczmEHuALGSwEIzpEY1Kef9AOEFpOi19GhbjRbgdyVPWJdkP/fULGm1xvZ2tj1y4vBIKOUUM6mwDMAreXs+45sw1V0bLIGATEoet3mCD9tqlrXf77UttstKnaNmsHXtOVvbbCBo5iLlr71ObndcbjyAtg61TzGK4w+C68Sf3hP2Bp42wXr54FfX0cK6bjxm1RqHpZBV3T6Z6qYsHCcMXsYIhaM1/37Lyxui0VwkrJ26eAcjHJlO3LGDdfYi7kAIoQ4tSCot2MKWXz97R73sz4DkPfu0vf4p9GKjNuG3bCsn3VO5r7w6UqfEy9Fe14qLZHAOAc6JG5FTyiAEJadCFJHIeRUo2DA2BR5PNO9hkR5K745qtQ2N5S7O+UDfIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR04MB6417.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(82960400001)(86362001)(38070700005)(38100700002)(122000001)(33656002)(85202003)(85182001)(26005)(41300700001)(66476007)(66446008)(64756008)(4326008)(8676002)(8936002)(5660300002)(52536014)(66556008)(66946007)(6636002)(54906003)(110136005)(76116006)(316002)(7416002)(55016003)(71200400001)(2906002)(4744005)(478600001)(7696005)(9686003)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWxIeTIyR1JBUGZ5WTdvQVE4VCtWZENKc1FkS3lWOXVQamxjNk9vNDhRaHZz?=
 =?utf-8?B?N202Ym1QbmRUT0l5bWorTjF6K1JOU2NIYWFIV0dVVlhLSVIxNUlTTWFtTzJJ?=
 =?utf-8?B?VXRPODBzUGR2ckJobldvK2oveGxsYjlqMjdsaVVXdUNDd0gwZnovNTBPUE0x?=
 =?utf-8?B?UXo5OUhGa0hrTWZJR1hnUFRYNmw3TkNVeU5Qc0Z0M3VGR2kyUVFhUC8zdGxL?=
 =?utf-8?B?aXB0YW1XeDZxSklrUkRkK1hHazcrdXUrM1Fzc080ZmFGRm5xR25YSWkwQVdR?=
 =?utf-8?B?Mjl1UU9OQ3RSaTdLNXR3ZkJCRTFuMTlVREpraXlreUxmM2t4cG9PQVZ3RlhB?=
 =?utf-8?B?amVPQ3JVVlpzV1FXQVJZSHNpaCt0TGczcDVDTmxSYmMvdHVPSnl2d3NUcUw0?=
 =?utf-8?B?dkRNSVF4ZjFUQlM2ay8xK2VLdUpuSmhQU0t3ZXlOb0xnNHdSa2JvS1lCNzF4?=
 =?utf-8?B?elFKM1Azb1c1SE00c2k2b1VldWR3QThFWUVWbERZdDFqbHliVUkxek03TFEz?=
 =?utf-8?B?eTc5K00zMGJ0N0hMTkhKQkpJWVFtSzVLeU5qSlUvdUlzMlpvOUtTbUs3QTIr?=
 =?utf-8?B?aVMvajdrTm82akRwZjlKeEszdXR4MWlUbHNLSTVHUVVZNkJ4OTRodHplb2x4?=
 =?utf-8?B?aHFUK256V1V6N1liK1Z5ajFtaU9kSXdmODZhaXVnc3dUOXJPQWxoNUhTMXZj?=
 =?utf-8?B?RFJ6cHltR0NGRUVsNzYvYUNkdkhGb1NRZlJhZkhTUE1MeVY2SU02REtoMEVo?=
 =?utf-8?B?cDRzc3FuVlFZZzV3Sk1Ed3Zvd0JqOTJzRjRCdGFqYzc1L1RDOWc3b0hORW9M?=
 =?utf-8?B?TmdOSlRyUFpZU3FYOWZudlJwMlREaUdyek9yZ3czVmRMK2lWVTF4bFJkTWNw?=
 =?utf-8?B?eUZ3dUIyTm1hOXJGMHlsRXRsNGs2UnNwYUJhY0thYUJGaTNBU1M5Z0FMRHVC?=
 =?utf-8?B?eWd2b3lqRS9mL3NNVTF0SGlNR1pDdEVBYzlxTmh4d2Z0emYrSkJNWDVRZVZL?=
 =?utf-8?B?YXZlQTF6TnI5ZXlxaTBzeWp1azd5UXRCYm9Xdk9VUVVtOUtYZXZBb2Rpdlhu?=
 =?utf-8?B?K2krM1owSjB0OUpsSXVUU0pjZUdlcjJEZkdVUzlzOEhmSkZFbUNxcUExaWNl?=
 =?utf-8?B?ZjZWdEpUeFM3cS9PTHZLU0JtRjdTbFE4UC92SDhkY0djeWJxekloemppWWJ0?=
 =?utf-8?B?K0pGcG1XWGdLRTJyMXNRK01OK214dGdUZGZRdEpNczBqM0xtTThqZDllMkRq?=
 =?utf-8?B?YTBXZVVyOTE0VWpoMVFOcjlrVUw2dWh4UkxSVERUUSs0L2FnYnlNVGJKQTRY?=
 =?utf-8?B?Qkp3OVZhREJMOENxUE9Zc0Z1cXA3NkJsZ3NJZG5QUVJrbHMvUDlpZUVxT2g1?=
 =?utf-8?B?RHVuUU40N0dZVENybGlnUXpEQktVUkFKc0xiUmNpMFJ2Vm1TSVhINXAyWDZW?=
 =?utf-8?B?RDZTdVFNZkc4dVdNcHdtSDk1REY0ZVk4RFU5T2c3aXczaHNFUjV3Y28yL2Na?=
 =?utf-8?B?eEVxMStOMXE0bDY1Ti8rWC9mOEJUbllkdENTdkZHaUlTRk5pNmR4Y1ErN0ZM?=
 =?utf-8?B?ZE9lNFlDUTltZFNHTUozR1kzZ3QzR2VHeFZtRmFXaWNBb0hRaFdHTm9qeG1R?=
 =?utf-8?B?SGdUdjdHMFRWOXBOVXZ3SzI0UlRFYUxBeWtheTBWRmVkZEdtOUFVTVZWbys3?=
 =?utf-8?B?cytkTGxhOVNQRDBDTmtrZnlmczZvSGttYzhPK3JrVVJac0tJcnhqYkNDb3Jl?=
 =?utf-8?B?ZTVWdkFvMXRxYmZWMlB6em9OVWhWU2xMMEphTHhTa1BBT3dJRVhqWGdjL3FU?=
 =?utf-8?B?LzlUZjkwTFVpR3pOQkNyQ1JVdUFTa2lNSmVwV0tXNWhJZ1ZTN3FodlY5Y2lG?=
 =?utf-8?B?QU9mZEZtalpPS1k2b2Z1UGZ1Zi9zODU0OGk2Ty81OWRENWpjeENTMmpXZ1lp?=
 =?utf-8?B?LzdESlozVzg2OHE5Z2dHOGlHdmFKUDNuS0pieUNiMGFHWG9vMWNYai9xcm5L?=
 =?utf-8?B?c04zVExyT0wzbHF3dGhuM3FtdVJ6akFweGppVE1paE5RWE1LU0NlM3lzSmF3?=
 =?utf-8?B?SFJoSExqTlJnbk5MQjlCSWZEeEU0TDZBTnhMN0VqdEF2VTNxMWpCbWh2YUVk?=
 =?utf-8?Q?I28D5eNCiy4ORtbJh1IsFwI+X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WFdzYi9WYTVpQnAzWVgxMlFGZ0dkb3VoTm0wRll3Zld0OThJQ3daTUFlYUt5?=
 =?utf-8?B?cm04VllqSDhZc0xtcU5HZk5Wa0ppMUhlT2RoRDd6WXd3aUNlY3N6R2FMaXJR?=
 =?utf-8?B?ODExdmZwc3FKKys2L1dyd2hoVHZQejVCTWwrWERoRkdGYW1XaG5FQVBaV0RD?=
 =?utf-8?B?bFJBcm41NDFCWnRRZDJGNk52cnJRNTk3VHJQV0JDcHlJM3dkbE83Y3JsSzRk?=
 =?utf-8?B?ejQ3Sm52QitETCtiWGJNbnR6SDdsY3NYUmNZcXJDalNYanZtK282Rytqdk15?=
 =?utf-8?B?RnlnNEhnejhmS1VWRWpzUk0xTU01b003M21qM0JVcEE4OXl0OVBzM2JOTHlp?=
 =?utf-8?B?NmtLNGRKTS9jOThJdXlxSWhYN3djRTk5RGxySHRGT2pzRHJWVUlUdDAxYis4?=
 =?utf-8?B?YUQ2YjE4VHlmeW9ON3VKUWFHM2hsRnBlN3UyUUpqVjVaNjdvUWZOVDBRV0wv?=
 =?utf-8?B?aFpIOGtEL3NCNE55UnFLbVFWU1FaN21RaVFuVmF5UGVEKzB5UG5RRlBldjZL?=
 =?utf-8?B?N3I0Y0o2SGJJaU9CYm1Kc29ldFplU0ordUZkNkdWUlhUZitlblZsSE4wZTRm?=
 =?utf-8?B?UEFhU1hiNkxhWHpiQ2k3RlB4aG9iQ1ZUS0NOTUVFdERjb0hYeEZkK0hqLzZ0?=
 =?utf-8?B?UXVoSEhPTDZVTDh6OWVxNnp3V25ieldaVmRiT3hQUkdIMXJFK3cvYXNQbmNS?=
 =?utf-8?B?THdtSXBTanpoTCthcFo3TWxhTEkvSVVtWGFpbXJlTGdCa1k0Mi9WYXQxeWFY?=
 =?utf-8?B?d09sTWlkQ2gyZVlJZDFlemh4SDRGZWtrMXBWZnE0WVczOE44ZjhnbnpsZ3hZ?=
 =?utf-8?B?ZDhEazNySFhFNW9FZnVnZlUvY0FxM2lXWEJjb0tZNG12NmZKd2IreUxFYUc0?=
 =?utf-8?B?TUVFbEhkZitsRTM4YTBRMVA0dzhpaGkzcEhHQ0N2VXVCYnZ5c0hRTXR3NW5F?=
 =?utf-8?B?cytqM0NkdVg5SUV2dmpteWVPNzY1b3ZHdnZ2NG1XNGtyYW1lV3UzanU1NW9N?=
 =?utf-8?B?WU9BWW1ZVVY5V0tKTEpmbjErNzNrcTNNS1Zpc1lYeEFHWitxSEZIdXpVQTBi?=
 =?utf-8?B?VExBWVpmU1c4ZmFOM21lOE12VmZsRWRsTU0xWTZqVXg5bmFuM0p1eWw5b1dy?=
 =?utf-8?B?Nkkxb0c3eXJRR0Z1a0Nua3BvcDkrR1YrMUgzTnk0Um9oRjNid0o5TEZmYng1?=
 =?utf-8?B?VncyWW8vQ2xXWTdHQU9QSTJFdzBpNW95d1VmQTcvVUpHUHFlQ2FGcmlYbDg2?=
 =?utf-8?B?ZFlNVElqSzZsU25tYXN6YnFuNnFid0dXWGJuVGE0bFR0R0U1d29jRFNZVThT?=
 =?utf-8?B?Umh1MEFLZHAzcHZ2U0VWK2VhNEprOG9uM2JjVjZVWE0yMXEreUpnQThrbDVP?=
 =?utf-8?B?TktUZ0RkcEhPeXc9PQ==?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR04MB6417.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ad249e-bc15-450f-735c-08db084f4e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 14:34:51.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qux9KzikZdu2CvKaog/gw/EMe4uQ+ALDvEmYs5u6GlbDVE4nwFrs36gz2rrTGWHykVZzfnYtx4b8N88RED+Yew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6598
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBNYXliZSBpdCBpcyBvbmUgYmVnaW5uaW5nIGZvciBnZW5lcmljIG9wZW4tc291cmNlIHVzZXJz
cGFjZSBTU0QgRlRMLCB3aGljaA0KPiBjb3VsZCBiZSB1c2VmdWwgZm9yIHBlb3BsZSBjdXJpb3Vz
IGluIFNTRCBpbnRlcm5hbC4gSSBoYXZlIGdvb2dsZSBzZXZlcmFsIHRpbWVzDQo+IGZvciBzdWNo
IHRvb2xraXQgdG8gc2VlIGlmIGl0IGNhbiBiZSBwb3J0ZWQgdG8gVUJMSyBlYXNpbHkuIFNTRCBz
aW11bGF0b3IgaXNuJ3QNCj4gZ3JlYXQsIHdoaWNoIGlzbid0IGRpc2sgYW5kIGNhbid0IGhhbmRs
ZSByZWFsIGRhdGEgJiB3b3JrbG9hZHMuIFdpdGggc3VjaA0KPiBwcm9qZWN0LCBTU0Qgc2ltdWxh
dG9yIGNvdWxkIGJlIGxlc3MgdXNlZnVsLCBJTU8uDQo+IA0KDQpBbm90aGVyIHBvc3NpYmxlIGF2
ZW51ZSBjb3VsZCBiZSB0aGUgRlRMIG1vZHVsZSB0aGF0J3MgcGFydCBvZiBTUERLLiBJdCBtaWdo
dCBiZSB3b3J0aCBjaGVja2luZyBvdXQgYXMgd2VsbC4gSXQgaGFzIGJlZW4gYmF0dGxldGVzdGVk
IGZvciBhIGNvdXBsZSBvZiB5ZWFycyBhbmQgaXMgdXNlZCBpbiBwcm9kdWN0aW9uIChodHRwczov
L3d3dy55b3V0dWJlLmNvbS93YXRjaD92PXFlTkJTakdxMGRBKS4NCg0KVGhlIG1vZHVsZSBpdHNl
bGYgY291bGQgYmUgZXh0cmFjdGVkIGZyb20gU1BESyBpbnRvIGl0cyBvd24sIG9yIFNQREsncyB1
YmxrIGV4dGVuc2lvbiBjb3VsZCBiZSB1c2VkIHRvIGluc3RhbnRpYXRlIGl0LiBJbiBhbnkgY2Fz
ZSwgSSB0aGluayBpdCBjb3VsZCBwcm92aWRlIGEgc29saWQgZm91bmRhdGlvbiBmb3IgYSBob3N0
LXNpZGUgRlRMIGltcGxlbWVudGF0aW9uLg0KDQpCZXN0LCBNYXRpYXMNCg==
