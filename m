Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C1C0015E
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 10:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjHOKDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjHOKDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 06:03:05 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8DFE
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692093785; x=1723629785;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=NIiVPAiHlRR4AH6+d/le7H0LIUgBOWky3MAdHepsvORY6HIeG0OfBua2
   jBpwIszgSAwGFxKotCg7ixm+PoZC3hYYfdfI5xzAPQU3K7yYbn4PL/yRU
   bFoUrNV0lAxgGsohF2AS1VAD7eb5sfifRINa8NB42wZotZPlN81O/+zFD
   y+b/dWPxw000KtqK0chBQcAE5qHMAK33MmMKPRDt9/ISkHYY4jEfzGh2X
   MZYrEXdNM64FXr7ITuUN1lXBKFJvulHKmNMlcOeSmtbs2nobHQDK96ZmC
   SPuAFrOOgENR2+nxovTJbX47lVgktHLhDemFxXchAPH1WHYf+how4TBqV
   g==;
X-IronPort-AV: E=Sophos;i="6.01,174,1684771200"; 
   d="scan'208";a="353143698"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2023 18:03:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwsP2STIROuEiwtnjl0wtXYeKNT83xaNbhJpYmBxTPpjKyiTsb+xX0AsMwxBOUb7WHDy/VE7sCpqcFCDY1pesjKpZdTiD36GErB90ZycTZz+uFxSHvNEbLUxSjsXseTc5ppnvTof/j2veQlKFGxZFY6ZBnCYc14VfvhGXSrERVt6UFJyS6aoIRkZRpST+/9MxqRNifFN9IhLLuZu9ApWQK02wHb/al76aYb7Qo4AO52ZKLz5sRz9wBqxtS6FnhupQY/ewtrlVeft2Y+T1I2kQtid1ccJ8VFQgYXloLDgFMpYhQU1cl6sCc7oGVdpRks0UQ6Ylq3uwRr6B52ifN8VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=RtPONfTmR5wwuGRtDAWpqlJSdNuNOAoNpfCIwl99bQ25LKZs4wwjGBoIcd99agFuKfWIqi6OgSToTDaxT+fJXyXYTjWuhwgc5V3D1irNfPbu0hrTT9ALDzknLtXgLWG2ZfEX6ZdJCp2vQsIp3j3e2CzHysxartbFW7n97XKeyOpO954Uh4WgPgPFWiI7NdA1aDiJ49vje+0LOCdgtYMof+au/G6BGZU/WyGyvusV66FljG63JOTRW/uiL2bWDI9tumMElL2Qn2s8YKk9MnZ0vjWuXSGXZZTT3FWnK4b7WanQ6PbToSqUZ8Oiv/e+/N3R0/VVimOEm5HeFilgHLtMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Zo5JYzpceIQZSQ1aMNCcQK5iqOvsUa54Ak6h7tvKJGQuMLaF1xfqxFbZrr0p23xKpKSSJMIgrNGn+AxNW4SRymPFLfqFCgSTXtJpAV5aHnb71uDWts1YKm7QB+/2L8Pk0gY6b5+qSm3mGklcg+sUyV+OUh3r8ioIJR7NcLX/Gn8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6284.namprd04.prod.outlook.com (2603:10b6:5:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:03:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:03:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: Improve efi partition debug messages
Thread-Topic: [PATCH 4/5] block: Improve efi partition debug messages
Thread-Index: AQHZyiIgKwnhFanLFkK83T3zXC5806/rKxYA
Date:   Tue, 15 Aug 2023 10:03:02 +0000
Message-ID: <3accb2fc-b004-43c3-8d7e-04a670456ecb@wdc.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-5-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-5-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6284:EE_
x-ms-office365-filtering-correlation-id: 163412c6-8b8a-4fa2-31eb-08db9d76d05c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Y9GLGvvNc4sMOT2btCUkuK+MjKhatmraLahJceRANbeCdmtoq7iTZ4dATCYwVb9oC3O7LPa0Dlb+K7AKZ2yXfUY345AEVl9hwv8mPxZsBy+m42JAhC8JLHkPco+GCnWCFrgcAL3+h2P6OkIFep+ne7s5dtgJG6p+XfxskcatH49Vth49IYzsswVATAa/RfjFlBSfZCP1NNYEfilqlGQsICKI/RF23TiuIB4Dx5vvm9l228hTlFJfcA5lItz+5Xz4bIAHLFgoZzx+sCh66wAISRGQqXBzDCeFy/lb4fICpH6oBCSr3RCgGDjKbYYJsr6mCmlN+j14PiYBY2fhmvODSWsQTuundMoWu6ctS3cuvbbegXQcumBnCRHMh6otqrLgp5B8fxH3wiKF/GJCiptWBPiIUU2BQl7X184HbOxO89bqF3AmVpSB6fBI8PlFc0behc8iLJE7cffzeWTjnWB0LEUgqVXTwnE98OCpJohjx7sE5I4Hg5j1MJSqibRnC1iTb9nCLCVoygvMsf/nxFcHGnKzjq1dYbbxqBeE0mIbS841GD7YgdH0kwDCuqLfnWUvDfnvW3BK67LfQ6QN83luMwkKGqncc504CFRzgv8mdJXqzYsE3O1RFPBAhzqDqJyZ/hgn4pFNfPBO34agzLsWM/9a4GecuwBJdaf+rtHpT5YLHf0mvwkusJvkkUOdsHC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(186006)(1800799006)(19618925003)(4270600006)(2906002)(6506007)(2616005)(38070700005)(478600001)(41300700001)(5660300002)(8936002)(6486002)(8676002)(71200400001)(558084003)(31696002)(31686004)(86362001)(110136005)(316002)(91956017)(66946007)(66556008)(66446008)(76116006)(66476007)(122000001)(38100700002)(64756008)(36756003)(82960400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3pBN2F5MjJFUHk3b1ZUYTVQd0tteEpHNG5sNUY5NVdUanNsaGdockNhNTZP?=
 =?utf-8?B?THNPL29vY1RIYlhMSkRQNGZxSWdQcmlaNDlLaTdORC9aZXJqamQ5bWZKcVpB?=
 =?utf-8?B?RTc1T2ZuTllQbFRIZ3JBUXVEVUU1L2UrSFBCZ21QZUxXMUFZenpxRGpuMWt2?=
 =?utf-8?B?YlloUktSanM4dk02dkRoalR3U1h0UFZMNzVaMlptVG5GbzR2VWtEZmExVWpY?=
 =?utf-8?B?TWV2a0wrTVRJem8yT3Q1M3RTODQzbmR6eTZPdEpnSElZQ21ZMzhXSjg1SzRF?=
 =?utf-8?B?dHlqaitWYTdsK1BDZ0RlNlFpNkFxOTViejJlWlk0WHk4UjdleFhEZmN4VWZY?=
 =?utf-8?B?Yi81cHVNbVAyOHdMdkxDNThoMUgva0R6OU1SL0lxVmJiS0xXTnpBclg0eDR3?=
 =?utf-8?B?ci96SmhacU9NcCs3VmNPQ0tTZEZYeWppNDExNHByVWVBS1d0K3dFU0lCYktM?=
 =?utf-8?B?MTYyaXYreHFPaFZ0QytMNUR4OWlvdWhVRHlnNXEwOUV5dWNETkZWKzQrQVg4?=
 =?utf-8?B?RGtqRkZYRFYxR1RVMVRkaUcwT0R4U0NZMVhXT1ozcnAwOU1iYnJNTk44bDBY?=
 =?utf-8?B?UnlYVDEzcGRsQ1hhek0zRTcyWHovM0pyNU9yV1BqTzlSa2IwYmNPY2pLSlJw?=
 =?utf-8?B?MEFRTHpiYmw0Z0NLQ3FUZThocTNOWE1KajVOY3NQVlJ4L1M3T2V6TmFLKzN5?=
 =?utf-8?B?alFDQVRVdHBNdDdCQlUrWi9HVHJTaWZ3RXAva29WQlZlblhqaTJSOTlRMW1G?=
 =?utf-8?B?ditiT1BNaThNN3lYaldNU0M0YjVrbkpEcUxDcTJJcUNFbEM2ZjVPNEFoWDZ3?=
 =?utf-8?B?L3JSNWxIVUZIOWRSOGdKWWM5aEtRTnRnbTZnOGJsc09YUXdsSWZwSit3S0NB?=
 =?utf-8?B?TjZoMUJkYWZ4TUtCeDJ1am1iT004U1JOYi81NTVrczNkMTVMZXFkTEM3K2w5?=
 =?utf-8?B?eC8xdTQ5Q3lzTmIvNUMzdHVGRTczV2lsUGc4QUJlUmV3TjlwaUpydk5icTB2?=
 =?utf-8?B?a0thRnlYYWZ4N1U3NGwwWlAwcS9uRVFvN2pudVRvbDlSM2hzWHVkYkpjS1l5?=
 =?utf-8?B?UUZRQ2NWQXFyMEtPVDdRUzJNVk1QMmxSTmpNTnBqUkxBUEpud3FXUmNRcWMz?=
 =?utf-8?B?UTJqRFF3Q2hKb0lBTmRYTVhzeXViVlhERW4wbGNWekdqbEdYS1dKVzFHRW1J?=
 =?utf-8?B?M2pnTDdwWlN1dHpTUVRVMkw0MTJpZE5wSVh5SXg2RWlnTi9MQTdqdzJvTFIr?=
 =?utf-8?B?dzJuOEhSbU5iVklPQmlQY1M2UHVMOHZFN0JkQWU5ZmR6UVEweTEzRjNtWGtq?=
 =?utf-8?B?MTllZGZVWDMrMHlybTdtT00vSTY0LytyYVZ4bGl2Y3p0YmRnTUhSNGJLQVh0?=
 =?utf-8?B?REhFdDNSazJUVDZQcmozSGdOOFdkUXpqd3kvQzRGYWltSEhBUER5SGNnbUZE?=
 =?utf-8?B?YThJVVU5eVorakhIbGJzL2ZGV3BOS1VIUUhFQStlRi8zMHYyOEJjNUQ1cXF1?=
 =?utf-8?B?aS9ubkRYRkxEMmxtUkozSkd2MzdFdC80dnJEb2c5RXJGcTMrTTdIcFpheHE4?=
 =?utf-8?B?cUk0S21hcC96SWgvczJudlBxQkU3Mlk5bmNhRDl4M3lEdUtXS0xIZ1dEQWwr?=
 =?utf-8?B?UklydXN3UzZEZkJBVVpOYjFON2ROZUZOeklOM2t4RThHWDhtK0UwWFR5U1Np?=
 =?utf-8?B?MFVVRXFYNUJ4cCtYSUpGM0E2NlRjbTNjazVKejZ5Umt5dXFlVnYzUHQrWGp0?=
 =?utf-8?B?M1RwYU1nM3h6UlpIZXVYRDdNSk42ZkFXSzVxZGY4d3hCYjYrRzZ4M2YxdnEv?=
 =?utf-8?B?eHpYODBYcWNOZkQyWHhTQ25SWDN3dWhuRUZjY1BLTElmOFk1M3pSbnRDVjl3?=
 =?utf-8?B?cVl2cFFldDh0b2RvQTR3dEVlc2swamNLRnczR3JZNk1vcnE0T2g3Uk5TaWY1?=
 =?utf-8?B?aW55N0gxWW44U3hJckVoamJlK0YxeXpqb1BSMFZCN3ZDbFZjNkNuRFNRaWpl?=
 =?utf-8?B?YWx2dURvelo4MTM0bTkxS3hRUjd4eHFuTHlMTTJUdDhmNXRITjhtcyt0Q1hD?=
 =?utf-8?B?bzdlZHByajhEYzg1RXhrcTV0M0VzVWdFSTZOeklUSzNsYnN0eUMzak9Xb1ZX?=
 =?utf-8?B?VHJaN1RwcGdRRk5PZWtDTk0rdGIvaXdTcldickduU3U1cE5UWjFpYUFTc2tN?=
 =?utf-8?B?andFdVFlMXNhRmU0b2ZaS1FmR1hVSitQWmF5TkNjeFJnNjBNNW5vaStaVGcv?=
 =?utf-8?B?T2lWRG93Y283OURyL284aDhMeURnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A85F8D03C87FA4FB049197AC1BB1708@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mDH4elN3STCTLdTzWEHEKod9T9NjSmOVsUg0C4J+PXTlGwqH9DeEh+F+D42hmIEBP0wMTeGC7oKekNT3mRbgP+5nlQ23h4wThZYLWVS5Q3R4VQ9fa2jd0+AQMZAR4AqowPPS8gDbDifWS16Tw5bWZJdHNY8+MeGTQExPVp/LKvMuoRDO1Car1ThTTdreKB0PtzZmxg4y+ZI/7hW5+ioPTJVO3XjcbHyWvE7cPfVxb1JlKTfC//y5F/wlCQTaUbzocb4XpXCYeKtKndoWsOXP9GnGHYxcD37Hc6zDIR31FaeOUBSe3q7rBE1I0UdkCua9+tc7JzbECqYPiVEPTp+k2oOpqNI7N/5T81L5i6IpRoQCvHhp6yeEuWlRqM2CAYEMjdZCAbmSoPjobNhzhwGzVrLg70BWl32BJlP4BhL8cix5y99Q8N2exfYYtPmkYSDwyT7XYEPvD/bCbHUoVkdeeRXYZQanUbDCPBw8r510nEOtT8VhsdqEkomkV799ksxyNwGfqnu3bCV4O8iQy8zCtBfPIk2UaqlJPfG8d26efs4O/lEvLio+clo2jTjMHVt1dYQ0SWsbUwNhuj4sWEE+/JgxdOYSL2Fn7xL96kbLclLwfaGiA29u3G7eLUUDZXYddIbPWgfxoT1hBPxNHJalCkYl1aif3AarR9ozB7V5Ug2MdYOeqbP4yzk1+52tuJ1LlUsTRJcp5rxpMH9ZVXoL0r4qkvVI0BTGYpeTw42JoDoDuOlACORV21LkPMx8907BVNiuqmP0HDMLhdl3MsCuZ1ONMWyaT9F8CgnIRs7ROpJW5L6pWQBVL+z7rtkqJeTE+P69WluGMrd914maKHZbAA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163412c6-8b8a-4fa2-31eb-08db9d76d05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:03:03.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcPq19HvaG/8OkCdSvOca4rE55aIW4/7LZv/IE+qPk8P0HtP8G8e5+Fk5m8GIiXL+M7y6lNLelVXxB66UtR9Hvu4oQKOd0Nr4g0ThiPzAhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6284
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
