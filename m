Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4DC77B7E
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 12:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjEBMUx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 May 2023 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjEBMUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 08:20:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE052693
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683030049; x=1714566049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sawx+zcmI/fQ56rGhZzC6YFJdBHb0JqJsYjLvAFsuY0=;
  b=lX23QHuEf8LNAhZRJlPx+R0AzGYrAzvRQJRpf/W6a+0b74Ul/CIGkdPS
   nnF5L/r0fcMHFY/pAc96xDuxWU8iHyENLhQz2UrFB/cCHgMBguxwUwzXb
   ODeI/flGaqqOa0mOIWOJxx4BWs+wxt1TG2QLp1dJtTN0IYPUzcCewZVHj
   YwXt0h2lyOHo6kndgAhR+IQfk9oMgxfL5ZHtRYYLTa4ofOl94kNcF9ezW
   iQ/a3HPiFwWEpXNxg9wu8fnqZHoAaJJiNIrP+fqMpLpa4U7TYMO6dzk/X
   oXsvkX/YxF1/6LkE4SW1gVi3K5exYwBT8stBUvyQukOZmIb4v9pIEe8Et
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="234679973"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:20:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjrGo0xpw3Vmu1/jcnZKrCKEMC+dA8zzp8Cf+fxlTQGYXvYH+H+KFRbV27TBKSXp+Aye9CjTJOuPYK4mAhgHCSAtRxrnkG8gjhbXb7uUPSpkhI1Rnj4d3WmP5taDTmhHLOwxzHrsBWU69njtURttcP6KQsiUq0yD1JCD/H2hXOAFHUwCZXZMZwUEaYB5sqlYG7uHkOidPP2CdKpnvXUPeUQnHmLi2C5gZafRiwLOo4aRrxStQhu9+Il4p1DmVvwMJVZc50pM2KMLwZQaD0Qh5vZbmAgLOkoLo4LFMsik2kWb5AHggOpEuccX+DFC3+U7tMDA0iTTi4vUlqJ7OwWTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sawx+zcmI/fQ56rGhZzC6YFJdBHb0JqJsYjLvAFsuY0=;
 b=gwpxREXdkBLCqJk5FOSkJuhvvevBXbto9tNtR/iaPezNr1pJup/LYVV4dV+U5ljavB5shULrEBytrSrRwIwv+tuUp1AB9Q6TDv284Y1gc8cVe0IuBPRYv+MjGN2S+s7uhIhn9nF6TPMXJFHtd7xLw2qnXHK0GTOgmLSDJesUTfNazafsGQEdyInyDtVMXnTjPaI5HYspft1CLKrlOZb1z3QqAp7Ycs7TWw11Ql+H5mxFd39cj8hncBQ22weKu73i0YkwH7moE9tlCIWuRNKFp2ofizutg/LqIvH4f507DKF/LSeaBuOjwE9z+qmvJ25nyKxPeoQVmgg5AnNwUL68hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sawx+zcmI/fQ56rGhZzC6YFJdBHb0JqJsYjLvAFsuY0=;
 b=l51K85VehI/OMJLZVeb3aF0mM7w2coF1SRLPatl8IDq3+ppdSqnTA8FFlijU/6QGCD8lMpxieO6XNAKWtU0a50OwoWZNI1l2/aeqimm+diCvYc6giiW11yeiYrvL137tUunQHQvm/rALtTH2UKrhA0+09tPpsayx3HXkM87Eo8k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6727.namprd04.prod.outlook.com (2603:10b6:610:a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 12:20:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:20:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "xiaoguang.wang@linux.alibaba.com" <xiaoguang.wang@linux.alibaba.com>
CC:     Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC 3/3] nvme: create special request queue for cdev
Thread-Topic: [RFC 3/3] nvme: create special request queue for cdev
Thread-Index: AQHZfEJM59fc/lIqLEaMBb1fssa+Za9G6IEA
Date:   Tue, 2 May 2023 12:20:43 +0000
Message-ID: <3feb3fdc-ad67-4a57-fc60-eacde3007db9@wdc.com>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-4-kbusch@meta.com>
In-Reply-To: <20230501153306.537124-4-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6727:EE_
x-ms-office365-filtering-correlation-id: b72f1937-2519-4323-7c2b-08db4b07a677
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCNoYP2gn0mqjz1e2zlguXKBlTOk+V33h5W72ke7GBhpW8yIUfnmode7Bw4A92GV/Xw7bbw/L1cXVUsxBukKKXQeZvSQfLYPnzcmmeLUe3wZqyDUCgWk8xPVSlxo5sQqwSJDq9X+mK7TMfA4ijSi9oFDS/uZLqk38cbdftBBqLPq+MTzYC5oz12qZGHNwL1dxHnojEC6+kHgs37BsaRdsNu29LHhOz1VY4UT71lmKYnT4tdRNjOwtx7BCSXeqFlOI3B3uimT7VGzrQ7aO4cUPas0zG1Zhkg2SS3BqI5+iCaUPxHsL9sWg8oEZbtItjwkOECU5dU/2h4HWV7bdu4aaVYXmEjF3RjymavSCARfbfL/TLM9avcqxfUYgqOfPOOxBM8LJhHCRJb3QqBda2johEETSlvmhqDXw/h4oklJks4i7RaN7QAzuQtoaYLXrEcCr+u9AtmClnSzjLoDKC1w/NIX5nZcBQcdh5TxsSWpJKLfkqmX8UqKemzl0bFGVlUXc0CdYXC9jZ2IhRaF83ua2SeMjty7w36QjDqt6c4n8+b1lrLB9LPlregDgFbBm6ByTXY0ulvisULIybUlZhPjpDv+bCMydiq5ODhTq7XbxGfqZzElvZFZ79fL5BuZDp6F0RAi1KEDP+AhQpYQgfei/OZwv32RnVAJQ8ECELp18LAauGQ27d+u+CHeGGEF+gyA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(186003)(6486002)(71200400001)(31696002)(53546011)(6512007)(6506007)(558084003)(110136005)(2616005)(31686004)(36756003)(478600001)(4326008)(66476007)(66446008)(64756008)(76116006)(66556008)(66946007)(91956017)(82960400001)(316002)(122000001)(38100700002)(8936002)(8676002)(5660300002)(41300700001)(86362001)(2906002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rlp1RENEMFM0NnlSeDkyYUFDODdUMVN1Q3RGWnllK1ErNkwydFhNRXZ1aXhW?=
 =?utf-8?B?eGIxWVd6TzcyZTRwMW1ra0xza3FGS0YyT3FVZG5XVUw3cVNteHpMMm9Oazg5?=
 =?utf-8?B?blF6dGwrUFpaQzc2TFpqSUttdmxCU2NaNkVGSDRiUHgxcmdrdjFCWDdLTVZs?=
 =?utf-8?B?ZzJsUVR4SzcxbHFiRlNXVmN3ekZJcWR5SWE3bzk5OC9pZXl6T2F4dFNXRm14?=
 =?utf-8?B?UkJJWFFWWlF3Zk8xZTVBTUF4ci9BZlltaXh5VjJhTjliSjZQbTVVcUpjbkhm?=
 =?utf-8?B?WkhJNmhIM1VKd0RCUFpoNE5SWmxIZWNHdlNOV1VlRkJEOGs2dnQ4OEtOODE4?=
 =?utf-8?B?eVBUeHEvemVxM1R0VkRuMG1NSzZSdWQ5YVJva3plc0RzNHUwY29oYWJySzA3?=
 =?utf-8?B?bTdOSnVLeGpscGxTT1ZsZWs3TlppY0t0SWtjMS96SmJpMzB4alFWUis2RUVU?=
 =?utf-8?B?WC85NUcvTUtXUHF1d3hrWm9CM29hUGFrRnF1MUY2R2hoU3o4SzlOUi81SWI3?=
 =?utf-8?B?TzFmclhLL29QeTJ6c0llQ2xySHNyWk1UbXlseFh6V0szNFpNUGZJTnhyNGJ4?=
 =?utf-8?B?TDBLNmxVbjlYQzJxWVNhMzZSblZxaTI0MmxBcm83V0xwNnhmUTJNY094MWVj?=
 =?utf-8?B?WkVNYXFDaktEcXFXbDVOM0ZlYWRBVFUrYnU0UFdzRHZmeEQxRHdoYm1vUUV4?=
 =?utf-8?B?ZkFLMTNIQ0tzb1BnQzkzMU56amdrMjk4aG85S3ZsNzdEQ1gyUlpwRFNBMU9B?=
 =?utf-8?B?R25DbUUxU0VhVEQ3Mkc5V0hnQWwzQytqWHhVdWlqZDlIb1pTNnp4ZVpTaS8z?=
 =?utf-8?B?UnhVSVMzOHlCZTY0WUwzMThkM1dXUHJ6R2VETHFGamdxSWlOV1FnQVIrQjdt?=
 =?utf-8?B?Z2p5Ym85a29SOVZ5UnY0U2RLcDA4LzJpSkg4dy9rNkpIUWpFVE5lUitlZ01x?=
 =?utf-8?B?NjhGNlpmcEJNbWJlbXF1dWtuczByODNYd2FWS3cvdTN3U0lZSGlGQmdvM3ZL?=
 =?utf-8?B?VEhCUW1hSFpzQjRSWW51VEsrcXdVbkFjRXFFdm1WSE5ubHUrZTMwaEtqTmJS?=
 =?utf-8?B?S1UxRzROM29UMWZXTVZBU3owek9SbTVBakh0L2ZZZGFKZXR4em9zYXQwRksw?=
 =?utf-8?B?QXNnc2N2UHVGZjlnNnlqQm1tcUpwQlhLRmNRdGlRMFpnYWN1N3l5dGtlMURT?=
 =?utf-8?B?UUZlTHE1Sk1Hb0o1MW5NNTJvTFgvd0J3R0VmOHBzNjBsdWg5cWR1QUdPdzhN?=
 =?utf-8?B?MHVWS3JoSm4vVE8zRlc4TWozWmZDbjJ6WE9YTS9kU3pzS0hud3FhNFl2Kzlv?=
 =?utf-8?B?UFFxQ3A5NnArRnpGSzYvSFdrdTdiTVdoR0xZNlJ3S0N0ZEt2RUZqdHZBdTMw?=
 =?utf-8?B?RStoaEhSQUl5Y2FvYkZhTklpbHJaekVSRFpsWTgwL0tBODZ3RTk2UFkxWGR2?=
 =?utf-8?B?RmcrR2JVYTRldEFneHpTdkcrY2RDdGVEdnNXSi9MMkx1dFdaeW11NnY2MGpl?=
 =?utf-8?B?QXFaLzRid3Jnam5qSCtGM3d4Ukh3Tzk0MXA1YUsyWE1OK0poSzR3NVVHcnJD?=
 =?utf-8?B?TUoxbDhiVzhmT3ZvdDl1RHJ2cFdZTlkxbzIraGdNRlk5N1BWakp0dEszY2hG?=
 =?utf-8?B?a0NVWWRmcWVSVm1aNHRGVVdhZzJuTWRrdDdqRmkwcWlRRTBKQXllS3JrYWZ1?=
 =?utf-8?B?SWNqanFvY0VGVmdqMlV4WDB4Mk9DWjBqSEhvNjhVMk1Dd3NPdEVidzRWRjE0?=
 =?utf-8?B?ekFJa3prRFoxRnhMdno5TXk1SW9EUWp4dE12eEk4OHp3cFYvWitxODVIQ3FL?=
 =?utf-8?B?UGIreCtxOEtDNEgrWmZYTjF2WVBqUy9RRzIwc0NUZytEOEJXbFlsWXhCZlU2?=
 =?utf-8?B?M1MrbVJKZmRKdEhEUTIxU0w1akkwZUgzdGZxRWlwK3AvdGR4ZmlqUTF4ME8w?=
 =?utf-8?B?YTR0TFpKUUFLMDB5UTZxSUNuaWFvZGtTZGVQTWZqd3dLcHJuSHRhSXRsMkts?=
 =?utf-8?B?QUp4WlUwZncyaGxrajlTNHNtNjJGb21Cd2dZVnlDZDBSZG8zaTdJVnlXMnBT?=
 =?utf-8?B?UW50U3dhMUd1QmVqanpSOXl5cnhlTW5nbTlRYjlLSlRJUTJXaVlQN3BueCtS?=
 =?utf-8?B?YTlHN0NRdE9zWHllczdHTlFFNjJlZTEyZStaN1pzQk9kMDc2SVJLK2RGTnVa?=
 =?utf-8?B?YTRvNEs1a0VKbWZZb2xZRjE0aGtCa1pSK2RLK201QjhWYVdMZXlCTCs4TlhG?=
 =?utf-8?Q?aAAvY9uHzwnFMHYCZzu2B+qURzo+otlOoCCW2qQ+CI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70D2FCC402F3454C8414308099C340F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTJGaVhIK1l4Rkd4YzFNQ2htcDdVVHVOajZ3TCtKVysrTTRaYmxtN0tOVDFN?=
 =?utf-8?B?b2lGeFdXSGhZQVVzZWhYckdobU5FK3Roc2p1T1pjczdQUjJMdFIzMDFkVFVz?=
 =?utf-8?B?WVdCTkQ2Y01RWnRELzdVK1JoWnV4Qmx2M2Nma2hEcVJ5ZnRvQTNHY21ZTWJn?=
 =?utf-8?B?L0JBalVuVXlUQ2Yvdy9pWE9WR0dlMVhjUVhWejRVOS9UbTBiWnB4Q0lUdnN5?=
 =?utf-8?B?d2llRUM4bE5iN05QM1FrTUk1NkxYYkk1aXBvS0FKL2pWNnBJbUcwRUhtR0Nw?=
 =?utf-8?B?SzZVVitIeitDVEpqemlXSDhXdmhHd3NCdm9aVWt5OXNQZms4TXVTMTk4YVRl?=
 =?utf-8?B?ZURwOG9FSkZNcDY2KzBjU2EzbkpxamFISFVubTBxOVdwWDhUUEpLRXN6clBX?=
 =?utf-8?B?T05DL0lkcUtoSnM1eWdlc0F2aDVMYjNOQzl6NFRsdnV1K09mejBVRWxrTWNp?=
 =?utf-8?B?WGVseWx2bS82QmpOS25SRHNWMUh3RTcyQmU0czhSYmtSWm5wVWxQK04wV2gw?=
 =?utf-8?B?ZWNvUWlpSmxtN1ZaM1dKdjJtUFFsS2RhWkxSMWhkREE2cHFjTDl5RlRZSmRL?=
 =?utf-8?B?M0xKSDd0Z2FnbHFpNjV6cmVDbjBVUkVsS0l3d0x6VTdxYVNCZW1DYjA2Z2F5?=
 =?utf-8?B?Yk83b0FnekwrcmhLVG45R2Z3b1VDbEtRbHFvS2w5ZGVLWGtXdCt2Y2JrdDFF?=
 =?utf-8?B?YmV6YzhLQ1IzSUs4ajltaEhqMjEzRk9PS3FjNXpOaDg0YzJGamtQZzQvdXV2?=
 =?utf-8?B?WDlWblkxS0NFb1l6TldraVd4QWszeWMzU3Y1SC9jNlJQdHFSdlhVeFF5UE83?=
 =?utf-8?B?V0c2VUxEMHdiTTJMajA4SlJFOVNrSnJJQXM3Y1piaTg4ZjNzRmlVY25mUEUz?=
 =?utf-8?B?UUhpMU51cDRjUEdxNDFpMUJvZXBLNU9jSGFXS2JwSXZYYS9FbVYyMDU4bTdV?=
 =?utf-8?B?Mi9nMFhVek9mVTVnZHd5MVRSb3pqNEttM0R3bDJrTmFpQkJIRmRZWkJRd0Mz?=
 =?utf-8?B?am1UT2RsTkwwYzB0QkRYWWd3K1NNWDUxVEpJRU1meUNNcUtYRTM4RDlvMVV1?=
 =?utf-8?B?cDRhWWU1ZWJLQU1IcndYNXZPWTltWWNvclBxRThaWm4rOXJJWVErekZPSWxD?=
 =?utf-8?B?ZE5reWJWZkFnQy94VnJuQUhYY2pSTGFHRWptOG1LNUhML2hZUGlzOGlSUUs4?=
 =?utf-8?B?UFVtT3g1R3NiUWFPYk91QkVrUEVzWTNOYlgxNy9IVkJHeURpdG9pTnNteVFT?=
 =?utf-8?B?NVBaaXFIV1VsbSt6V3VPcUtLaWIzTkhJbnVtWDZKWGRDQnd5UjlweUhZZGRr?=
 =?utf-8?Q?WDKk7UHsSH/dLxc+WHkhpbLdEDkmCpcuLJ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72f1937-2519-4323-7c2b-08db4b07a677
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:20:43.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+s90SIHFNFu5a5Jcc7c3EQGhvio7ePWM384exuMZOIw/1Bru6hMATVjHgKvbd41tvaTj+dRbvx5kAtDMN37DsX47IU1oHdiPMoVbwHAzKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6727
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMDEuMDUuMjMgMTc6MzMsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiArCWJsa19xdWV1ZV9mbGFn
X2NsZWFyKFFVRVVFX0ZMQUdfTk9NRVJHRVMsIHEpOw0KDQpTaG91bGRuJ3QgdGhhdCBiZSBibGtf
cXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19OT01FUkdFUywgcSk7DQo=
