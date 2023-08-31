Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D38C83F01
	for <linux-block@archiver.kernel.org>; Thu, 31 Aug 2023 12:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHaMXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346221AbjHaMXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 08:23:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871641A4
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693484589; x=1725020589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=R2Af06TpkksnzICLtez44zbD5mOHQd49xggdKD+fI9KZnl1kUAGtcHnr
   T/nojj9wj82Po9b0uP4Ctf7mcOL1VUIkjd+zHcUTyDJIi/2vQ7cC+4up8
   B8eeDFqaa6lPjpPqDDs5/pf5iejrSPwToFnDP3A2wcRw3rPe7D9ZtjHj8
   jhP7qJnNo0y/poLSkajTjgJrbpVLUVn1v6GuoM++7oQwfxER6qWqMfCTZ
   88l8fluLbuVnvgvXNzRTTEzcK3hp07BBOSDiVtufXsCwb3qoeiApCjRiD
   aeHSTBAoWtiSrgkt0fcR+KcRrC2EEPVoerKVJhg+ga843rb7+TzVq4fB+
   w==;
X-IronPort-AV: E=Sophos;i="6.02,216,1688400000"; 
   d="scan'208";a="240851616"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2023 20:23:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj1957u+HYGy3OVvbbtAY3+YzTwK1Yc6/PgPiTpggsrlAxmneQcmB9gfgysnVTCQ2ymHu3OHB9jRZaUMGGiobamigeP6/31u5Wzase0sz6qa+W9KIYaw0MzLcrjffjyxdEA9yV9Jxsw2goJ6XKPbRk2Aj/mMQ6eBbFLGB84MPcCDg1aFrAeCmjDcijzerVoLEyqfTN0yOj5m+UrSw2G7C0ro9xOaGhzUtDOCiT6aPBSw/6zfLP+s/9bE4EnQswcbXo+7z0zYZv0oD5weF8qJTwUUmrqcDvhj6R7i/EIB8LgTMy1bvnHbelEr/BMLAPTN/PNGKh4QKZ5i8sHL6h2AWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dNxvxPpfxmx+p8cTTBSAtnVg/Ab4WLqhBR/SSoq5QV5KXmqX+hlsn4PUPdkNbkpCPu3ml1B5ROfOpUw1futPwajKIvDwiicuuYaKljzjHPas4yn7qZaBCMzQWQyUeBXgBfrdOzYUor+adBT2tdhsplHIkihE3YsBtA2WzLS92Lu0hk31Wpml96eRUY8Z2H3pcroEjvDhruTc4UdJ8zmvEqv7fMziNCupaFiMjm4LzzsECxzXVoynVD+pYnaECJiuQ7OFMtNmLpKKlZcuqZzZ/E5r6CmuWSRiCxCE2U0FD1JfedT5ZTJPYxees5Cy3lIKhoGLBJ9a4pkZDu81bS711w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=g6nBN2ObLWWS4+xHubTfxx2V0fwGIqr3XKL6IP2GaSXHiS+WJtYIfK6SWmiQw6iyLi6NjsxXbnoNCqECMpOuzgRtnma1wSWDwsm4kgq7vWjm/xEPCG2PealdzXPGa9JBjCWdhp5VVKGUb9qEPm6vtYFsMSqAqhLVfW9LERk542w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7928.namprd04.prod.outlook.com (2603:10b6:5:315::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.9; Thu, 31 Aug
 2023 12:23:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6768.014; Thu, 31 Aug 2023
 12:23:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove the call to file_remove_privs in
 blkdev_write_iter
Thread-Topic: [PATCH] block: remove the call to file_remove_privs in
 blkdev_write_iter
Thread-Index: AQHZ3AVkeZuFjRTFSUef8p0/CeyyN7AEU76A
Date:   Thu, 31 Aug 2023 12:23:06 +0000
Message-ID: <afdb1570-5fd0-4366-8f87-379ff8c9b5a2@wdc.com>
References: <20230831121911.280155-1-hch@lst.de>
In-Reply-To: <20230831121911.280155-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7928:EE_
x-ms-office365-filtering-correlation-id: 3e795e43-3986-4112-d3c7-08dbaa1d080a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fx0yXBK9lg+k+taMis9JXx0cSO6/7uNSBecZAPFNzopxpn2VnDnST/qSyKHqAjvaPwM/34JvnUaoRkSC8s8qllAjnjy1PGk9dTHhgFwNS4NRGYUelLZaaixwWLPT8YCtEG5K4idSkNPZYcoeelzhPlm0jZKEqypkhr6yiSLaj9081gcbSSMTTKB++3x+p4iUY3d1aFZPWhy3097LMwyYOgCZTzj2E8VDmMZBHPEu1lb2ubTKvxhQgbZYR0DCIZJpFAANYbQEl7dToln0S7XF2wFo6x31jevKjWfOCgP55TqTiRWSVFMCdrPub2/kNABUpj6h8vHqDFtMM0xXjniNMidG3Cg6vlsm9OIP9+K+1v1/hG/Mo4QNRtpKTpsfKnDk3z9/wtKg3Nt7uvVEo9g1FIwe4z1bqkn0bRmuc4bO7sCrqCzbJY5nbC+qpJMGHQpu/X395OLRGDk/D6dWpkzlwMZO7Q7LTl2RJ+H0OgHs6yj3YKpscZANhOsxzc9GrGLlRsPy2nlnX7pWvy5XgkUZnmmEpqarvyL7gWAhWHQ98RT9RL1Z/dc5eDVTWjtln9bAPtjEgnD8E6NgDutXItGh6Ek9OhABgkmHwNE9K8hpGtIKhmsA4rLIdad8CCdVPOeBfg6FFzRHSURHTZrbueQexTisCaGh8KS4q5lWXcRkgGBDtjAARhkyDm+IphLorEFj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(186009)(1800799009)(451199024)(41300700001)(8936002)(64756008)(66556008)(8676002)(4326008)(478600001)(66476007)(71200400001)(91956017)(66946007)(110136005)(76116006)(6512007)(316002)(2616005)(6486002)(6506007)(4270600006)(26005)(66446008)(2906002)(19618925003)(38100700002)(38070700005)(82960400001)(122000001)(5660300002)(31696002)(36756003)(558084003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTNzNjU3aHVCUXFRWlMzc0JDSHlvNmhpZ0gvTnpJNUZvUVhaUVRRTGl4RldR?=
 =?utf-8?B?VHQxdDlmUWxsWEdxSitaSWJJanlzV2VYQW9FMHhFc2NaWXc2Y0o4YUNuMUE4?=
 =?utf-8?B?V0QrWDlSZFMzYTJ2eTl1Z3MvTTQwV0U1VWVidXpjMFNpV0RNNEMwTXFUeFE3?=
 =?utf-8?B?UkxRNXZMREJ5OTlKTy9mUTZZU1lZWmVLTTBnWTZnZW9YVW5tZGRmYUZNQUR6?=
 =?utf-8?B?RVFHd04xUzZvWUUwNlZaWnd0TVFWcytES0ttblVlMktJV2hIZVdVczI5a1Z5?=
 =?utf-8?B?VGNXNVFWamlRZUZNSW9lN3hhTTZpVXo0a2VXSUhlN01yWkhEUVp2dGhMVFhr?=
 =?utf-8?B?ZDJNQ21JV1ZSb1UrNTNrY2JBelZPMzBJM0NocGRQRVVHd1ExOXRLYzJhejNZ?=
 =?utf-8?B?TkQwVGlzR2l1bjRobDNUa1ZKZnB0UUpWamtISTNGZnl5TEpJKy9od0U3eUhG?=
 =?utf-8?B?eU1RRy85UlBqWFF1ZjJvd0NRaVp5VUFaWU51SDZxQnQyWFhtcEh3NEJmeHdq?=
 =?utf-8?B?N1FLdzFxcVBMUXN0MHp4ZDJGcVBBa1Y5VG1pbVVnTHNpK0ZKN0lEcjBWdTAz?=
 =?utf-8?B?T2J5dUlEK3YxazE4eHJiYlVmUFJCQ2V0NXdyVGpCNVRKNnJYOGNVTEI3cDBB?=
 =?utf-8?B?NUUvV21zbHltV1IxbEJzUGRzRHp6RjJtbDBMaFJSdXlHbktMSTMzdmtUUmFi?=
 =?utf-8?B?L0lWQ3VTZXQ2Wjh5dUdDcEkvMWc5NFpBbm0xZExXZnEzMm9QVkFZdHVrL3hZ?=
 =?utf-8?B?QzBwMXdtd3RiYlZ5Yks3WmIrMkduOWdyUWs3NTI3RGdYVXZjM25KNGJ1NTlM?=
 =?utf-8?B?RDJxVkp0MWFsTzg2cDQyck81K2kvc3VNMHF2M1NzWlkyYjZ4Tm9NRHVHaHh2?=
 =?utf-8?B?ZThUYkVvaGdyUWxWVkJHaWpVeEZ6TVk5MEtycStoQ1JCYTUzZXJJNU5oTldm?=
 =?utf-8?B?Q0tTS2hQWm1pMEVoQjFwRE5OVGlmRVIzZ2MzY3c0cGE0RmJWM3BkY1hTU0xD?=
 =?utf-8?B?d3pIby9iMm94VTVsZDFwYmlxQitvMlVSdVNEdjdKSXlDdkhtZFhRclNXTVBp?=
 =?utf-8?B?R1RSSnNuL1NYeDZsZTJPTGcrUVZUUmZZaTF5V3ExbngvUHRPb05ybld5M2Ju?=
 =?utf-8?B?UXZlYzdTYlZYcXRZT1ExUmVpWkh5SVRmVGdCblFEZFRXaktGdFhFZDJtRG1R?=
 =?utf-8?B?YmNnQStYZ0ZrUk0rSnNsRzJUeU5kY0xIcXBqR3lrY0x6KzFrL3Y2Nlo5M0oy?=
 =?utf-8?B?TmtRY3I4QmVmdWhTWHpDcnMvR3ZrVzZtT1FSVGlwY2VtTERiVzZTWXJxcWhG?=
 =?utf-8?B?ektycjBPQVRtOUo3cC9ZVWk4akRCUEZBN3hXZGNYc1NxY2d4VWJEV2VUdWsr?=
 =?utf-8?B?T0w3Rk50YXMvWnVhRzNZR0lkNjlwU0c5ZEV6djdaZnloV0VZbDdZbVpaeDhR?=
 =?utf-8?B?VDBoamlPRk5QN1RTZDFaeDVZdmgrQWt2b1JIdzQ1bVplRWlBUzdtd3gxRERD?=
 =?utf-8?B?VHNCTmZIY29kZUtib051dGg4UHRsQXRSazc2YUI3bzlWbEI4UWJlZi84Z1ZR?=
 =?utf-8?B?MjZGby91c3REOW5QeUk4WlJZZk5pcWh5UWpmYzBGQWsxRjVnVyt0MHErSlpn?=
 =?utf-8?B?NzI4Q015cWltcFMwR2FXTU5KL08zOVloaUNlVnZmSWpVc1RSL3R5azMxUXor?=
 =?utf-8?B?NkNDcHpid2VaYXFuSmtSSEhUTGdlZ1N3Vkd4RElWcFpxZTVEdkdPOHB5TC9F?=
 =?utf-8?B?QkpZdEt1a1RSN1k0czNpSVg4Rm95MmRwNVREa3MzbnV5ZGdyTmRmYzltMlRz?=
 =?utf-8?B?WFY5KzR1cHVxbGhQWEFtaFJnSEZNTk5FUEhtVU5BbDZLQVVBUnZnb2dpL2FQ?=
 =?utf-8?B?VzZOOCs4RE5VcUhUR0Y5MGpONzh3cXFxNm9XMmFHZmMxSzFBRjc3cHE2V09S?=
 =?utf-8?B?YWQ4N2UyeG9JeTliUjZIZ3hOenZlakRwd29JaFpnMVZOK2VzYmo4NlBqdStH?=
 =?utf-8?B?ZG1zQSs2OGZnV2pqYm1HVnZnbUZyRmxFb1ZQU1pZdDd2MTBTbTRqRXc1dVJy?=
 =?utf-8?B?cW4xK1E2YzJtb0xaYkd0YVBSNTNWby9EeWZlWFlXWlFYWXlUV3FRRS90b0JI?=
 =?utf-8?B?blZCK0FiTmlnMnpCSzZuWnJCRkRkb08xM2thRC9YaDhhVllyRmxRTFExRlY2?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A6456E2308BE64B8C5FDACFA0F9C35B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yjmQkiIxlar9gxpMaHu5ma8hXfGeGLCAK84pfkmOK8ht59TmznMTiLEgI95/o/0pC+63Ta7lF1wCJNicGongMMWrSWS2wQ2HolvTM6M+lxjpRDAADlpceYdF5KmDStrzdKT0Te+U8QOffyGFthKOGyyMqMMvpQQLoiz99FGJpRbTUU7JlJJyhuZG5UIYdtVUKWHC0AnjUtS0OHOBiQuVr/VYFUQZRT1yU4NdTjibu32pkgGLrNR7wq54T7c7S0yi7bcNUiNyvcICEark31l+OOAzAqjXDia5+85sQrkSRg1WSM29zBvQJ6hd4dK54eKs97aueIVyCr2/uT6qGw6rn+pGcdcdV726aKZ/njy4QThd/B1GTw8H0UUGsEU/eV8CcZ0TYy98dtPPLQzzox2fDtI2G8yO212Sd1gdYVXKioUSCIOL10ctxZN8Bq3K7rh5j1/Ue/Dbp27W5bnvzYpolDUI7VDce8Wn2rhbr6DLrH0UzcHTdIh+5O423049MfZzrVLxxCBT97ISvjxwJri28G+a+L8vFop188hGqr347XBBAGrkHt/+j1vHI3/HOEUQoGZV6xwxi/K1RspRD/QC/cNYZbg39fGEb7fx+9CQT+JcR6Ir1K9FWqEf9BV6kpUrEoTkjdakFyHxs5rBTe/3Pw81XTLInLoMeru5w7nsGumwbNOQmjvPlHmzvu1BBFQQS2f01+OdrlR7ZFuyH5wxZLvu0v+Y5BnhRrju8QXjPW/5Vh9V38yn7gay+DNthQ4BIqAPsInJt+XmaPhvP1ZOJB5grycQY9gbIoPiq7+BZtnDnrnyqu5tOrtVhqRoTGcDG1WtaSHOK5DpIPxhWqA90A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e795e43-3986-4112-d3c7-08dbaa1d080a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 12:23:06.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Tasp8ZFSJ+SqPTfEPaVClvQmLxxlcJtMejLTTxkkAcW/W2xSMBl9dNhPKnLQ576ANI94Vpk7h8/24v0bqRqwWPYZFkdQR7yC5zSs2vfcQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7928
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
