Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE99C46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 07:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjAJHpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 02:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjAJHp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 02:45:29 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EEF18E39
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673336728; x=1704872728;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gtqwC2kHGPZJ9DTiPYxgi+RXuCI+yUnpgc7bCNiKcBNMkJePYmP7ePpz
   rWRTUKJ4Dkr+xY0OLk3Se2BSJTYIR5e/v/YGLo8HakDtScJZss3+C+ewP
   g7icYaWfa3gYUj0LI7kjZ4SFJL6CeDXPiL62MsnPLAEpxcqLNrshLjGp3
   RcTRfQdAlSiOtH1n1ixOIjSLk/R3E/ozqtw9oD/8jtENSAw1cDYb31XN3
   LhwWZcDxynnqaZT3Lnyx7zJW3f8+hl0cCMtKXoIcaxrO+LPwzmc5oUJIB
   r3B4w04k51VmkkDmWeVyuquCz8O8++rXSrNNMzzW0NbAjEK5GoSwIC3UM
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,314,1665417600"; 
   d="scan'208";a="218732986"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 15:45:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1pKqBCh+7EvX91PfXkn4MfqK1bHFrdA6DILiktP8LG22MptXKBQFk8C3aQT6vojRyu1J9BZAkHteyeE2k9LsgchqyxPRDnriiuA5muHQu+X6Oc9Z1+vSxyzQJvIZDvoX5mPXmSC+/fCOkuLGmuQEHHsYI96zjRC/ei6S6vU1Jn1KWY5xf2zqZif7cG97/NUJpObc+mqCEookQ9vuO7pcJS+11IUEPVxPcYCQQtAXxYGhHQ+5U+s9a5pNe5LJ0Fnezkz3FmtbqgOtg307o5UcLlh9BMVlDN4Y05zO5YeIee0u/vYJtuQxqNCX7yvMAsFKFYtDlVWwAfHkRvKqYXWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nsGnzT3ulbse+I6IdZOfMXmC+7ZjsZhBrERQjNfMvdgavq03sxH4pMI2XWb0uj/O9lUloF0AJ1tR5rMPNici6Y89fYkcnt9VZsGr3ux3pPt0j9sdqnZxmB+2c3CbubYWwxYC9TsxafbUXooYs217ADfssAwzsG8PZayTQKf4zlgzxiH9WW9+cKvrqNU0fKs4DJPQJcse/ao4cBpX/q56ymR2S71iCzW7ZWA5wT6PE4CfObsg9OV9iui31Rhj0t6o8h86HZNIv18uggRGktoump3xGhyP4bZt0+LOrxZZycg+0H1LuICL9l0If/+QyxRtI7IM+qu3Zdnc2Ou3uZwBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=khW9JoDwFr9T3Xowmq4FScxOf+HCedbeR1MDW77qm6TFvoMMpv6uOikjA1QdeT98Mu2YCK0sE0GJWezskdbPFqMtCUGOJeW+elNTfLz/eoQusX28pmJljeToRSuSTnzg10k/NwcPcf9o4gPMDuIEP5Kpqj/riMNK/MvHxWCBrg8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6507.namprd04.prod.outlook.com (2603:10b6:610:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 07:45:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 07:45:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: add a BUILD_BUG_ON() for adding more bio flags
 than we have space
Thread-Topic: [PATCH] block: add a BUILD_BUG_ON() for adding more bio flags
 than we have space
Thread-Index: AQHZJFMsV/MbvU9m0EKUcjyzrSYdBK6XRlgA
Date:   Tue, 10 Jan 2023 07:45:24 +0000
Message-ID: <491e1979-e413-cee6-750a-da205f5b36a7@wdc.com>
References: <da48fbb7-ec78-f382-919e-cdf23fa200db@kernel.dk>
In-Reply-To: <da48fbb7-ec78-f382-919e-cdf23fa200db@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6507:EE_
x-ms-office365-filtering-correlation-id: 834e7700-c0d7-45a4-eee3-08daf2dea286
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTqFNENLwW2ISsvfkpuTSrkbPfPG6nhQUuZhNqq9ZHrmHR9UyW9cYUF3BEsT0wElr9/Vnnvz2Xf+R+af8k9ZEZYBQmK927A6zf/Sfn1VUFcT+xq1za8Kekiu72i8Fg2wgH8aN0SkBv7gJm6Pt/6q6YW8hWXA+c1R0v3637CAgMTA+03zUDIceh/snkNDE2QSpI9BrKG2zXr3qcN4OYS6BDR2WSiBRPG7v5nhGH+c42v0vVbGV3vD9LfD0i40nvxewQjjaOPDrfMthzYFwJqICkljGJ+yhHtPikGB20OEVSAtLxEHOtRkPr94rJ9pZ6ii9A2clos2OAPUvvVlEjmja7PPtcdYiye94bhCJ0AEr4xGqI8SbjvWaY+KRvlzUKCWLUfePO7VhT+p7oyyXizOPBABDV4+9JLsp64layeXo3Mv+K8am9S3SnAiWXKw+YwvbDYoDYEzu1sRyywmUkStpsh+9bxx8y0oI00HuGbNuRYkAaYCYPl9wZu5tXM2zcez6GrYs2WA8e7mduwhuQKmv7srMCsrr1ikLjPgPu/NPoreJoPGoM+mxI1Ddk/wEPhEjP2T0YUzlI619ILJBvUcE7WOx/2LF86+ifhQphZZHOfZA3DmtbeHV1wcszmmC6oMk76nskFT18732pbufdF0WFC6Y+R7zg1aUlDmcfCgjE0HwnCARo8cFdr7Ts14UkTTY9NTXP53oQwyo3z3nM7ukbD8nsL+guBIXaWkv+ltsKzDz+vvw/VaoghmIgY8LHdQX97Ce5zWwAkb6zS3bZy5MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(8676002)(64756008)(76116006)(66946007)(66476007)(66556008)(316002)(66446008)(91956017)(110136005)(38070700005)(2906002)(5660300002)(19618925003)(8936002)(71200400001)(41300700001)(36756003)(31696002)(478600001)(82960400001)(6486002)(558084003)(6506007)(122000001)(38100700002)(2616005)(4270600006)(6512007)(86362001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE56SUZNZmoxdWVwR0JpdWljV0RyYzNsWkRkdW1hUSszZ24xcjBLalFXb0NV?=
 =?utf-8?B?Yk1zN2dzOU1oNEtuSEc2a09XTWxtNURiaDQxYWhiZkVsMk4rNDhnTzhSdFpY?=
 =?utf-8?B?ZnRxektmY2JwU3VaTjdqSGdkTzZMclBOcmhvQnc2Y0Y0RFJGb1E1azRWbmJr?=
 =?utf-8?B?RUEvZ2d6eG9zS0dMdzFlc2ZyaDRiL3JhM0Q1NEpCY2ZOT2pESlZJVDU4ODJs?=
 =?utf-8?B?YkFRa2pFMzdmRU9wOHM0RGh3Q2QwSUdiR0YwVUNnRk1jQ0lZTnNEekwvMFBm?=
 =?utf-8?B?cU5BUytyRVpYOVBSbTQzY0ttVlJFdERWVEFZazB6OTBZQ1Y3UlBzdDI3bFpW?=
 =?utf-8?B?TGJFakRjTnNNRWV6VWdxTHBrNjFVQXltN21Ucm1oZVZMOFI4UFdHMUtjZURY?=
 =?utf-8?B?L2p3MmR1azBvcUg1ZVp0aHVJUnJwT3d5QjdzYmd5RGhOLzQ1Y0R4a0pjbjgy?=
 =?utf-8?B?UHplZmZqUFY5SGlDTXY3Uk5kMlhVRUlTV2NjRUpnZlVMZHAyVXN5RUdPN0d5?=
 =?utf-8?B?bTdBN0sySVBidVoxNGpWc3B6SU1SQWlpb2VyWmhYL2xQQUVTbWlKcDVLVEha?=
 =?utf-8?B?NlpNQWt3TWxXQ1J2K3ZLQVZCSDZJaDF2RGpzWUZsa1VpRTFLVlhteEhpeEgr?=
 =?utf-8?B?aWFaaDVVT0ZyUjZyYnNybURQTElsaEt3Nm51cFpISWJtZTdOcHNUeEtBWGhj?=
 =?utf-8?B?UVQzaVdHeENPclMxeHhTbENyKzJlR05qT3dEdEhXSFpNMW5TU2VSQit6NytX?=
 =?utf-8?B?NGVMa29MdEtvbUtlSGl6OWlkTnE0VWZ4RlpUZkFnTnNYcTZGSlhZVU1hTWdE?=
 =?utf-8?B?czJNdCs0STlEditCTzJmK2Q4SjdvbWFjVzcwU0F4aEtRUWI4MlVKcWRhNi94?=
 =?utf-8?B?dFJoSXpoNkVFYmp3YzBwTW9CVTNsUXYwOTJURkVBVG10YkdPTUxkSUVDZ3lt?=
 =?utf-8?B?eGt0NUFYWmVMTlY5R0RXUkJ4RFJKZnZEVExUb2NlN2pVY0hXSHVqWVhabjZy?=
 =?utf-8?B?VjBlTlhRdk5sM1l3ZWo5M1J1dWhKOXFpTWVuNzR3RWt2NkVwenBNeS9ycUcy?=
 =?utf-8?B?MkJEc0NKYk9XaHFJdUpYWFZxZUkyZkdqVGhOYkhpL2JCVFRocjVScHUwWWFG?=
 =?utf-8?B?SFBma2JPY0dkd1JEM0J3ZDlJbEJSWFNzN2pMdnBRWGpJNHlWTnhXK1gvVnVY?=
 =?utf-8?B?UE5URHRvSlNURDB0OXpSdG9PSjBHTEk0Qjlla0VJTUY1dFRQaGxhSVZ2RzBq?=
 =?utf-8?B?SmlzY0k2OFlaNzU0TDVDa01HK1hhT2xwR2FwdHR4N1Q2TWVtQzErZWllT3Ar?=
 =?utf-8?B?VWdqOHBoaks3eU9zZHgxUkVyblF4L2M5ajdhMEw4ZEtOODR0Mjh5RkJwQkVN?=
 =?utf-8?B?Z1d6L2VuMy9nai9KSUVUQTR3WFRRc1ltVmhuZ0tIZ2JuT3k4SHRUa29hOE9E?=
 =?utf-8?B?MlFpYW4wU0pBUDl2RlpQMHE4WE5ha0grOENUY2ZkRmxUcVBCMGg0RHE5NUoy?=
 =?utf-8?B?dm5UbWlxQ3hlM3FITTBzcjNoelZQTXpSOGJzTUJwc2FXTC9EbUVOOG5ETDVW?=
 =?utf-8?B?MWl0UE5vdlQ1QUNta3F4YU5RcXQrai9Lby91eEhRWFdRais4NnpjSXZmRS8r?=
 =?utf-8?B?WnVwUjNHcENleSsvWGtScHVrNWE0UG4raGl6M1kvZzFJYTdCUlFrWXFWZGdN?=
 =?utf-8?B?UTM5elJrMDZsVmtXWmVla1RsMzNCajAyOWl1Y1ZSeHdQTE50Mnc2Q2VtRG05?=
 =?utf-8?B?OGVQMmJzUk4xbDYxRTd2aTE4ckY2VUJUT29mM0dCdjM3RXZhM2dyejFERzBl?=
 =?utf-8?B?QmtlL0dIWkVkRHBnNXRicVVQcTU3cFRrd3NUM1FPTVk1YXZsMEU0WXRYQmdt?=
 =?utf-8?B?QWhQaEx2ZjBKMGtQOG5kT2JERTdaQmZYT1JBNkVoRExZblRSeFBuOG9uRElC?=
 =?utf-8?B?VE9RUmcxUGkzN011VVJ1L0ZnRU8xUktJRVoxUXQ5SnhuNXhiUFlVYlpuUTN4?=
 =?utf-8?B?TzRMdHFFU1c2d3BDSnRiNkZ5TUtwRU1tSkVIb3U0VC9xcTg4NE9EQ2RPOFVB?=
 =?utf-8?B?UDEwZ1Y3ajhQbHhvWEdzSFJlM0xseHViWTl5UkE5M2htc3Bha1RScnZCOTdG?=
 =?utf-8?B?c0k4cGE2cis2c2kwL29KLzJweXlzMElSMWNJa250N3p5Wng1MXFkQkpnMWFu?=
 =?utf-8?B?ZXh6RVFWdVR6RXJySTNreGFibGNrQnZPeDBSNkUvaFBEbEdJYVF4UE4rNUtQ?=
 =?utf-8?Q?TJqxPrpZbNvVLIwDf7y546LLjveKBfGvi3FXzFVCkU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82E2E895E318D24A8444E1729C19706C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LvRxTNjNUxx6bn7ykAPW7wbBgu5ATr/9v2TgioW7F4RE1TPeWSvdd4xWiPm6yoxTGPV4W1CWkR7LceHkMi1GCQ4W1c6hhPLnTyFXtWqvffZ1OhnFwH1RYhl1xspMx35ajzNIEZtBEI4o4FjKvprCrLJoSSAVJJeo44lSiJelX3pW0+dxgcX6v5grF4ig4lqlGBY4C68le8lJaDAgNmH/XcaaNdsM1U1TmLKgINlv+2Vh+9YIGoetAucEmqigSuKm+7sjJ1to5z+HMNvOpsl/TQPdR9SeT7YTXQ3s965a6YgUM7ZAhGf66Qa9EN2A01LNG7TDbwsoeLt4VlA9giWx3PHAm/JUezz0/La5MGThvgROBYfvFwYvAPg6j3yzcZJSHDuqxNtShuwtmnIqRGK+vIV0Ugq91/go66TuBVbEXrCMUugVfviuKtGPmogn8aw7zA12yaUQHuT4lJ2s5DrGzaXUmdgEDwpVCpkOFBM2IBEzshizX544v5bc46/GHzIuMnSe4H1t1qLukqDA8AFQ3/2cMnV0Hr7b6ybCVVorjUbk4DMJdavY6PfHLIIyXfdW+6Qe4D2KBOVoYDxSecURPGhm6mowOTyMlOVzBs6Rb4arc1Qy4NhC8yTSXup76zOU+MtVDpokg2OADnye+mkCwVkZM0iV+gVLx/uasQEbieSyo8ofxcfLrXMdK1v3ABpib2KzUV/T/gnKSA9oIdQkbu7UhHOYkS++n61GddhJ2grUG3T9Yibq8LaFL06uULCJjkphB+MoqlC34W0CeHR5r/FWSvOFkPKhRSAvGeu+8aH8C46FHXbOqKvp7Qa1gDeQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834e7700-c0d7-45a4-eee3-08daf2dea286
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 07:45:24.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9PJ0DltzPLzmLG5fSr3/eJWK4W0T3jcl04ArIAZVYQ3hhRQYO705q1k/+F6A3UgrOwwBDpYSW19dLTgZFUkFRQoD3bibK9EZhAvTsVlq/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6507
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
