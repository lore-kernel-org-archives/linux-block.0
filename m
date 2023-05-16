Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E040C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 12:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjEPMEs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjEPMEq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 08:04:46 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D244AD
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684238681; x=1715774681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Gqt2mAc0R1XNYLNxChNqQ4Cq0Y0lvzM3yVMHSZTS37idlZxylOHK6v2i
   euhvpO83+hsAWaQl2JB6qZuMHmnrqZpaLcoNNH3aXCpd8gaCfiE9EXsY3
   uGVpjcyEb4sII3olh3BLLI+RtM3HXFxjzTqREO2Bjc/k1njWauhsQbGAy
   l7mw/r7ktue8ygPL5J67gG5eDVHm8mWXG4PaIQdTZCJ6A1lsHsvdaYnx0
   W9JLT+JauTq5pNab/vVkIHFZtsWsDjKst1mCW3mebQHbMce/hHJHSRrz9
   Jc9RrucjaG4ht0rchAr1uji0rbYZA2ZjLMNIpC6BThGZKPafUQXwEgyd+
   A==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="229085245"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 20:04:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbdUFAkIjlOqkKt02ycpKrvsyA9zrCecQwuqeELQPjt1GlVQ6SLe1QZ8SUzQYkyIsksykpffaOc8ZkCq50O8xYzfpJT89eouKYDgkxdOWxpT7vIKljQW8jcXmIaz4O10/dBd/AMoytfr7c8f0+ihYPBUnlguaFKGN7zz0br/dm3G2J8Iqdhvl7klSF+vic3hWH2EEjR9OcVLpsTnZg2qPVCNhizSLUcxPWC1KsfI1NE4AO2vDNLUvNYiEJGBsaJE7eMQUdYN3TrBa2NPlDxkqe5fl/hFm+S/PrmAj8hiVhC4c24mWcigeFP2rzLM4VgVINg6WAxY+/BmwU8y+LB7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Qjfq6/HcCX/+ZeVpfM2swQuKKqlqj8jgqz15RJBscpG9Jp+XXfa4hkAzi0dUN80rstAJzV0DlnOtTfN46KAYsuy6rjBTT+ydvQfXjXANzUViqcW8r52ihaPPsbozoRHhtkH7YmED+618IQOz57tt+Tprc6oDr4TqkS0YTc6/xlSUNv4uNkViia5duCdYadQe0cC2Udob32W69KN9QkGCC/cG/C1NWqRljZFLyGAoP99GK0/BlHy40f2x5id2tLEu96SAB7wqsvQTKRjHYXVTb7F71WjNk7ZTve3NRkEq7i0s+nu69Xj5l96sabCL4perbYYVhIchZBFMUQLqV8fAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Vz5nA8FidUtcrbyVW/q4kdOkzkpjyTzcJZPd54OAgtK+y0Mx0OjLEU+TfSNTonuUwHKqObkSHv3TSbcCFcPY+gOo5LTUZpKLOpVdKyzItIfXGoSTls1emAcyE1Mw3S3Ws/De+nJKfsDkEmzx8xporkTKxxJ3XDGbaGFuU28+vf0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8360.namprd04.prod.outlook.com (2603:10b6:a03:3d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Tue, 16 May
 2023 12:04:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:04:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Jinyoung Choi <j-young.choi@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/8] block: move the bi_vcnt check out of
 __bio_try_merge_page
Thread-Topic: [PATCH 4/8] block: move the bi_vcnt check out of
 __bio_try_merge_page
Thread-Index: AQHZhNcwEMRoEh32jkO4Kfm2pzgjnK9c032A
Date:   Tue, 16 May 2023 12:04:38 +0000
Message-ID: <c7f836a2-3037-bfe3-464d-aecb10c39dc9@wdc.com>
References: <20230512133901.1053543-1-hch@lst.de>
 <20230512133901.1053543-5-hch@lst.de>
In-Reply-To: <20230512133901.1053543-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8360:EE_
x-ms-office365-filtering-correlation-id: 60f6daf9-06bb-4eb7-95a7-08db5605b94e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJdX3B9cznF24e7bdKl8ddYBzjp5Qgko+4PZfylXeKOz+Nwpx3U4UoW4DGUCJsfN7jI/Y/qmN9t8RGyhaQ5/FuVTUxzBMdyaDUg3j/MocD3uz4PXlSDeQMJh2mnljv1KskvO8E0jqJQpqdV5sbMqqdLDqwfX9aexYAnp1cAa7kIW+0vNrLoTtb1Dd3WtAqcwn0dqr84BRWnPMDCE4/uWQc1uQVOKwmTX3uJrvO0FnI6KgheJPgQpBUQolW374XHiOrkxEXsANmVR+npNk6OLf91hcDiWbY0/NJ13pHC/0YZzi/Dee6jJSEAY+SD6mPVksXkf9nTiWrPVD4SCEtF0/WSfbY8eVd/JYjH4rhqWghquQiRZkPH6RUqBMwxCl1k8IzVsKWe/6NfJjcbk7vl+Px3AcYK615I/gijhq4aHU/AoiPQm2i+CPCH4W4Ijjt8x18JvceZHJCjNuTRGBg2jiUBwAIRY3Mk272bj8w2XpQMkNXuHoYg3A38YNIuD+fEAlrqlgoBTOctFbgt9eVaRas4F0ehIUoL2gDjV6W/fEQc72inYHDpgrnXDy8sKUc/B3TiKb9jh/GFU370PIdObJ3yJT6nYKdCcl4RQFTl6HmXQxuGgCkmXXeMX5k9+JQv7V5Ty/Vdnuj4zv+N8up9ZkXxo4iC1KEMDmDkVuuQUOb044OQ38z5ovRzfieVBBGj4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(71200400001)(6506007)(122000001)(82960400001)(5660300002)(4270600006)(2616005)(19618925003)(6512007)(8936002)(8676002)(26005)(558084003)(2906002)(41300700001)(186003)(66476007)(36756003)(38100700002)(6486002)(66946007)(66556008)(31696002)(478600001)(76116006)(38070700005)(110136005)(54906003)(64756008)(66446008)(91956017)(4326008)(86362001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3FOc2pwOXlKM0hkemNxZmFMT2tvMzlNYnYzazFaeVlYVmw4UnF1RWNnTmdk?=
 =?utf-8?B?Nms5Y0NFVllOald5T0l0M3hNUnpYUXpzbXE3RjE1dVFybFRtRXQ2eUY2Y0JP?=
 =?utf-8?B?RkFSVi9FQ2RqQUhvdWdiSnFyMDc5N1QrM2hGMlJnNVIyWmd0ZEsrbXhmUmhR?=
 =?utf-8?B?TXp0UDJMUkc3ZHBHQUNUdDJBWjNmaG5oTFpvaTdZNUZCVUliWm1VRjd1M0dL?=
 =?utf-8?B?aUJleTJ5UWNIay9CdXJZQUFMM1RkeHZrM0VZdElNRTJvdTRWTEViaExLbXRh?=
 =?utf-8?B?RWEyTkowblU2d2s1Z2pqWXhJTDRJamZWbTlydmoyKzNoTnNiZjN5TCtpYkJJ?=
 =?utf-8?B?VG45OVN1eHE3dzQ2empTQkl2WDkrdHhDMmpJTmxJUTN2ZzcrdHZ2Y2RjbjNw?=
 =?utf-8?B?Y1lua2NlZU9MMVgxRGVvSkkyQU01bFl3NkxEamlyNkpScVJRWGwyakJrTTFz?=
 =?utf-8?B?RS82OGdBVXkxVTVXRmlQWklzaGUvTkNHbnJWMnBnYkxUNlBxN1piclEzV1Bw?=
 =?utf-8?B?aSt3eG9WWVgxTk54dlJiNmpLakh3ZkVhUDhBZHJLZDZxczAwSExvcWNZZjll?=
 =?utf-8?B?Vm42bWV5QU05YlZ1T3ZSL21TZnMwZytYeTdPT2tXTUNLbmo4SlhObHNNWXRw?=
 =?utf-8?B?ejgyL1FjV2t1SUcrWFlBdjA5NEpGaTdDeGJ1ZFlRaXYvdmpnS1RjMXJVVFFv?=
 =?utf-8?B?dE5oOVo1MnZoZFg4bzArZE91aUJIRjJ6VjZLSjY5cWlLT2VaVXEvRGRCZm9I?=
 =?utf-8?B?dkVSUWVWVG9EbE5MOVFpazFqWWVGR2Z6RFBRaWZGTUpEcmJxbkJLV2hnekRC?=
 =?utf-8?B?TU5IQnYzTzVGZDVZSmNxNlNIOXpWZWpvQ1NTenJRY3NUMWZuVlZ6ZHV2MVFU?=
 =?utf-8?B?K3g0c0JBZFRUNlUyalplM3p4SnpLc3BvUmJrT3c1RzRoVUF6Y2RFUHc0a2RD?=
 =?utf-8?B?ajhNYXdYaDg4NmF0TVdvdXNuTk5rUWo1eGdHOEJzRVI2c0VxTFZXbWh2d0VE?=
 =?utf-8?B?QkoyS3BjTE12SnhQVmVQZlpKamVzSExrN1I0V0c0elphM2ljbDBFem1ueEFi?=
 =?utf-8?B?LzQ4bSt6b1NrWHNKNnJ2bVdZUmI4RTVNNGdXMGZRd0lUVDRONWswOTFTWlZ2?=
 =?utf-8?B?M2RBc1l0UmZlUEQvU2R1QmpFRHB4aWVieTA4dFduMyt6Q1RFbnB6QzY0VXpx?=
 =?utf-8?B?ZTNGRXVrNnJCTDJiRDJlU20yR0h0S2xhZkgxdE82ZW5BK0hxZzA4KzJHMGpO?=
 =?utf-8?B?OWMySjRJZk9vWkhza1N6Q2M2VTJDTWkyUVUwQnVaV0JFSWJET2V0UzJnUWZY?=
 =?utf-8?B?MFY3cjRJamRSMytUdFRoOVFhVlc4NUxLWTlTR2VXNE5XY3pWYk94aWp5VmJC?=
 =?utf-8?B?cWRORnpmR20wcDVBOTQ3UzlNZDBVYkNDM2h5bnQrZk1GTjl0Qnl2ejhBN2JI?=
 =?utf-8?B?TGNyUXUyS0hOOFNrUnVXdHhDa1BSMTZVL3NsYWRDcUhrYjRET043WWdoNE0w?=
 =?utf-8?B?bXZNUksxNEJQdTZudGtTbll4NUExRGtCanpjSGxtUm14andueTg5YU0vM3hO?=
 =?utf-8?B?a2NPYVBuNjNLb2FyS3BubmQvUUxLWDdOa1hhMjRXYmxNWW4rN1FJdmZKdUQ2?=
 =?utf-8?B?Y1l3OWtrUklFMWs3YzZWVTZGSmZ3cG5sajF6b25TNmlOZFUvWk0rbmRrQzRP?=
 =?utf-8?B?b0VpMFB5bHE4b2pWMXZrcll2bDl4VXJoWjdZcTY2MURsdkRnR3paUXpWeVRB?=
 =?utf-8?B?MHc3a3pkUU16cmJKZklNc2c1dUthMmRWRG9GQTRBVHh4YTVGYjlUY0l4aEw5?=
 =?utf-8?B?aUY1NXI4NXJNVERPL3ZSTUFxWGZtMjJ1UDVvMlFrY1NjL3hrWlA4a0l0SVFm?=
 =?utf-8?B?UTFEUDhHSy9YMitobXNqSWQrNFVzcFNUYSt0Y3BpVytjL01EVGZ0dlhBL3p4?=
 =?utf-8?B?dmNzalBRczc5c3gxRi96SDNNYkpiMTVKTWtKTy9uOUwrZUU1VUh0TnBVYWgy?=
 =?utf-8?B?VkthVUdsbVpDdi84eGxtNitKWmhaTFVTVGtmdVRmS3ZuT3NFS1BoRkE5cVdi?=
 =?utf-8?B?b3NnQXo1UmNyV1dtd3JxajRSZlJTclFZVzZublJUYW4zNldoTGNRRlFUZzZp?=
 =?utf-8?B?NzNSOGRTajFONzdNTGtBYlh0SzM2MUUrd1N3eHhPaDRpUThuNG4weGllelpV?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C806BA7D639CAD45957BC1C95B2FB040@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m6++N7P2cJMi1zdryQLyM7wIKxXHGrJCTXfbyVWaVrBh5817Ce+d6N6Za5bleatxjVTsUZ3sa/+MSuHTFHsjIxV9T73Si3uAK8/8ykpdpqb9WTnH+Rlo/ixJKJDBso3dciHTppslqyWAVrrKWeftk3fHAsD9yJGZf1eF7G+XddrQyr3ChaqdxfjPiQIwIytmcUAS5oGhexdBgrlBuJ8DMVaNQVUzTZO+h4dNDH7lTg2L57F7dxOHogr0gmHZfHloiT+GS51oFSFVAH+NlRJWZ73ldriIBeMEo3Rp8qWP4++tJZB5KKrekp9ouqSt1KJM9KEkyMwE+CfCH0NB1s20GnfWhRE74iyqHGJd664yk9EZi0MZ1nwpxEdO69kioil4iQCukchRL3J5nKFoWLyWdeL3kt65XOQnkjE5m9bp8+1+54B8JbshetmmM2PostqGXqN1Ydli8qqC6OdswzgMpQSYo9+okF4IbYSG4Bl2r+DDOXHqd18WGymmt56J1REaLoSMyUGX+c9Ve7847UhugbedxMTlefD3HtQ/J7bWLphg0k7MQt62tOOPlEgPLP0iYVGxtbh8p21ZfS2gYq9VCIidWYd/l75UWW7RevfXOloBIlUn0gn6zdUE78NujYycbC6h6tITABA2kfYIWeaNtRRa4JdLRZ1lTcNNjB1YUzFKjEXAbc2rxNOLb+jDyVYuGZbbi9ycgxWW2IpHTCk8dPitmvJJro6zE9EuDx3HZjC6jHg7CKfxcq98qqzgGHkAhj64O6IRQbTQ+aeYdd4iYnTjqcZ2lumx8r3WanpLJ6q0Y6Tj7D/U2j+C1+wJroe/7iM4JnBFMXxD4IvRToPVov8r5DiBD8BmJn3AKttmfm0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f6daf9-06bb-4eb7-95a7-08db5605b94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:04:38.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 648TsxP5kFE3Ku8X4r3iVFFsRZD9DpTANuiMyBYEgel0NHoxaAD9HCBQmd6WEogMnKpAzLbyyzZsmn+T+TMkVEIT28LkbwZAywtebUS5d+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8360
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
