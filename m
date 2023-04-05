Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57135C7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDESoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDESoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 14:44:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619391B1
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 11:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtpGVETSs1WTdbLvfmKAiEVbozUBc+3j63XSLJsrSzcBH9JXyTeeNA8cisxNuvtSFSo/DjmOcdVMnCsN6JTqFn57JugmNlt0L0o3xFL8nPmYRoY02Y+sD0Ktv9HsMZ2at9RXvmFfhZ0Qrd94AQyroI+COtnQqg1LYm0TFYtqalyt3mMptqwY+afKY4CI3jT5S3ScdWKYY1oU6QUfkxtleclIczI4zebfCzZ4GFdwrA+hymmSeH4oeBZyILVuoITaep9iAQIhJdWW/5rA2guW+n9wHjvZPOsHbplDjqHu1fNPjOuEvBoBcWVDBt9NayRGRxbSyzEf4DwI3j0Kjr46eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iwjj1glqPjYuDs1Lva/m5j6TE7FLVQP/HlN1iqjlCc=;
 b=Bv9pb8hZXQPcAQTzP05/NrGHUiJdUwb+vRFUKU1XIVAr154ACj+XCksbtTBZdK+2X1bGwQOgKLxUMZO9Q7ijEP1bit9UxozGb4ovSm1euDWOfCYgSkg5xsr0Hetsbf+RQjkAgOkZkhqeuTNfYHzAaATQJL2OGNjIkoDPtnbse2vGxICFZ8a68/+Pj7Tjhkh/o1/2cmYNFs8VPN1XU6/ax/C2889Do5Hd5i95BdeB54wjVzgD4Y13zLJxBuXAz2GsUmhj5Abt6brgtFluQp/7wl7bnUgpKyIfO+vNCZrkEA9hsc1F8qYd131g/F8ZJFVJyx/VvsEBsQPLez7+jtCbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iwjj1glqPjYuDs1Lva/m5j6TE7FLVQP/HlN1iqjlCc=;
 b=lUNELZpi+9df651/Dr4fHZPYGNJkgUX2v62U4OH6VWWYaENJbKyQgFnPef6C70fyvgP90lxHLCUMrwUpUbL7wfjhNF7ue/cyleVFJzYSjaxVXGnUR1Hyzypfw4GxPebs4xVZP9mib0Hg5B0sJ4eRNMrguE4EtxkqO9ZkvRk+d6CReiLK4akoGG3BmsjimVCWEVyGNJf4MRwMDNfyznrSKvB1Bh+GN90KgzfU3rFxSW69BO5Y4M6VblsHjl9hWJpAYlpRtpTZq+YPBj8YvXwP6ihGh/4OUSIWSQv8odS5KfZiyD2Q5HL5xj+CjUe0cX/aW4yeCKAmfrsZvdlgQzrryQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 18:44:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 18:44:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Thread-Topic: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Thread-Index: AQHZZ9X5/fquS5aXZUWrqdtzWxsMWq8dDYIA
Date:   Wed, 5 Apr 2023 18:44:02 +0000
Message-ID: <27228610-1f72-dca1-0931-fc8c8c1ba61e@nvidia.com>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-5-dwagner@suse.de>
In-Reply-To: <20230405154630.16298-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB8520:EE_
x-ms-office365-filtering-correlation-id: feb5d0a3-27cb-4270-5bc0-08db3605ba32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nu+gq4Yf17r0YeLHo2hzZu6B+ev4A9E+OsTrc6W1mOt2jZNoDLkBGsZYxOzPm3AY5kh19Cr4luzljlJJIVHLWcub1PbII6GNm1ik2nm19Lhn94VIwul/HZ6rZOY5l/Yzq2X6R/GCSpaaMmBu3BjmUa4j92RvzJT7MyIPWST/qM9n96Fa6fPL7ywMEsaZVk2v/FYGHiOeC3wtzHL1oZLcJfwW+gGwPkOMaMS3NGO3VqwSb4N79FTAsRojUBOb/cC1xgSsw0QDKH0rmjzWpq+BoIFwWhmRyUT6O44TESdwpaPifTCCdv/Fl7DlE20xGZW0VOqP41Tkf6/bgF70AlX4BTEirHrUBXa1Vyvjoues6I4dGrYysFVPlJbI93tBo0NDH0jv4/UW6nmnGaekebyAeV37w/nHXIY6rnyAB4sctPj2GFz78pqUx2K311F3u6tjyAhXvFZb/tiwjpw3tSyekmxbTc+y8+DFLsYO04DVpDaeoBq7IHO6DKnR0GCZ+COq+cVN6qzViUb+lcM3FoFBcj4UEhKZcA49PB83zTz0faXcTyjiCVUJkqLv9yhlUEutgo+yedIBWihzTmQF44eYpAECncsG7fmR+YsuRe+C8nSRoZWVRaH5j3vdY2Z8OVBx3+5p2H8pPc7BGbWS7XU2m9iGwB7uFJe+n34HKlbLb0zRrj13tANe78kTQUaaedJC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(2616005)(38070700005)(186003)(8936002)(5660300002)(2906002)(558084003)(110136005)(122000001)(53546011)(31686004)(6506007)(54906003)(6512007)(66476007)(8676002)(66446008)(64756008)(66556008)(41300700001)(86362001)(91956017)(31696002)(76116006)(66946007)(478600001)(316002)(4326008)(6486002)(71200400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUcyRGhmU0hBNXNCeUtmLy9INUI4L0dMR2dJeVRvUGJ0TVlrRGhaVXJaM2wv?=
 =?utf-8?B?bHFFV0U2cDNvQWV6OWFKVWxrY29UclJsOXZIMGgxaEhKM3BvNUt1bithMW9m?=
 =?utf-8?B?eHF0YitGclBUM0IxdVZCaDlhWmlnTGV3eUZYNWE4UkJsVlA3VDc0cEFzRlVm?=
 =?utf-8?B?Y0l5cVVTUkRWOEJtR3huMmhsQms2NlY5S09iYUpTRzFSQUs2SmVqQ0RJQmx5?=
 =?utf-8?B?WlQ3cXlIa2VvcWphUEIrVXFleFNVZmpMdkg2VSt0MkNrdWRYYnY0UjRUTHc4?=
 =?utf-8?B?a1drVVpVRm5xanlXbEZ5KzZ6NmVUdDZHbVR6dzIzZFdCeGN5OExqZU02cXZC?=
 =?utf-8?B?Y2hYQmdwelE5ZHhlRncwa05zZ3RsdG1pQ2E5a05nK2ZHMEFGMUUyMGI1cTkx?=
 =?utf-8?B?RWxUUlBUamZVMEFiazJTUkEwTjBCKzBtTTB1dFpERk0vSDhoVmlKRFNZa2o1?=
 =?utf-8?B?RWMwYWZyYUxXVkNyQUxPdXpRSnRIc09CL09abDJ2U2cyUmFscDB4RGQwWEFM?=
 =?utf-8?B?aWdnL2hpLytOUkRSeElDMGxvamE2cFNHK3pheTQ4L29STFg2NGJwN3VlTTdY?=
 =?utf-8?B?dStKd1lObnZrblhLaEZYbEQyUVNmK1NLL3BCcWVQZkRZbElBb3RnL2UzRDBz?=
 =?utf-8?B?eFJURUJ0ZEZwanBGblJ5azRqQzdFdGJyUVQ4ZUVCQ3ZuSTg2Q3hPQXVKKzNt?=
 =?utf-8?B?amlWdzlBbnpGT0xQUHp3TnNKY0hXTU84WTlHSXdMRTlRaWZhVGY0YUV2c0Vw?=
 =?utf-8?B?aitZRHVZbVJ2OW56RG5KQ1JxYlVLL2JSTUVrTmdOa2o1SjNZb3JjaEMrWU5u?=
 =?utf-8?B?NWwyci9hdUgraE5Oak14S3doWVVVVncyUCtMUWhQMzNraWIwQ3ZnTE15Y3dO?=
 =?utf-8?B?WUYvVzhheDdhS0o0cWtGdG5XblZtWTAyTVdRcVVtb0RwYzJVQms0ZDFFdFBQ?=
 =?utf-8?B?eHRPck4rYU51YW0rejhnaytCT25iT3gvN2xRenRSeTNzb0lNR1VmbWlpbkRF?=
 =?utf-8?B?RGpLREIwM0d3Vk5qMHV1d3B0YlA1U25lSENYTmZaUlE4Rlk4VjJnU3JLMHM5?=
 =?utf-8?B?L25Uc016SHhYV2xqZVBzbFdsbUdld0lwMmFhY1lRK2dZZjlBeHRxZk9XUDY5?=
 =?utf-8?B?aWdsNkNzS0thcEFSbWhEYWFHT2FtSDR5MkJLYmhiejdQbm5uSmdCOE9kWktZ?=
 =?utf-8?B?SXk4bUNNZS9kWmNPMG95bTU3ZU9HNyt5QU52WWtOMHJid0FnMWZmdmFsa3N1?=
 =?utf-8?B?UC8rZzlDZVFlMTJzVGg0R0huYWVmRUdYTkIyb285Nk9tYkRJcDByaERrRUkz?=
 =?utf-8?B?cU9rZ3RYS0xkMjJhLzVuTERhdHRMNlRwOUJXN3dSUmI5WVgxbXdmSVVsMEFT?=
 =?utf-8?B?aWRHMUFmQ3JTL1lWYVBOL25ac050MzgwN2czZGZSeGlHU0tuQTdTVjlsTWFO?=
 =?utf-8?B?Y0tyTUNLUW5SbS9wZjJvR2RmaWdnTXJwb1NwMlBKVzVuRlI3aWhmdGJ6cWwy?=
 =?utf-8?B?ekZ6Rm8xN2hHYU0xVzZ0eE1tNGV2SDR5OERYSUhBK0RiK1BTUGlXNUhWbWZq?=
 =?utf-8?B?NXAzeGJpaC80am50MEtGREJoWnlZdkR5UDR6QWRGWWNrYTF6dzRuZGZBcktn?=
 =?utf-8?B?RnhQVEhYUmFBYmV1dkJQbVZidFhtRVdRYmQzMk9VN2FyeEhKaGRxV1c2Sitp?=
 =?utf-8?B?TU5Va2VxdTZWY1Q1Q1pjeFVOWnRaZllIajBGanRQRzE1V3NodWpiNk5RUm8w?=
 =?utf-8?B?REE1ZTdINzJNWEh1UnYxclo4QUY2dEN3bjNMMWpxRjZ2NTc3QzV1Q1VLTlo5?=
 =?utf-8?B?TEk0aGRNL3BzTmV2eWdlWjJjUit4eHRlUUFpSGRjNzV3YjFzTEdXd2pVamFJ?=
 =?utf-8?B?RzFEZWtJRkc3VXJJejZlYlJVeHlrc0g0VXF6U1lzMXJ4a1Zaa1pZcHc0MXZE?=
 =?utf-8?B?Q0x0d1NuTjEwbVFQbHNSTE5RQWNYVi9KTHMvRGRKNGVTY1Y5V2RYZlBOd1BK?=
 =?utf-8?B?S2QxOXlXUTlLZFBiYTZWR3hFejduaFNOelB2OWRzN1ltUElpT2RUa1ZpNDA5?=
 =?utf-8?B?KzF5TzNJVy9VbHVpaUZvY0toZmJYalNVcUJaM281azB2SHBVdlRhdVVsSTBS?=
 =?utf-8?B?ZWRsU2ZkSjNld0IrWUxtR3NYMWtaTjNwZDhyUVhPUGNncHluWmxvbFJCYURy?=
 =?utf-8?Q?9qdPQEQdsPZl2c8qpSGCNpTYhLFJy9WMT4oMbs07BiSI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19F44907DF2C8A489FD28F29D76211EC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb5d0a3-27cb-4270-5bc0-08db3605ba32
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 18:44:02.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqsfmEHC2WUJcxKKmWwBWU97K2YXdQHHPHCa05j/nkGQmD7IwAEnPxDjiU+mrh/lIb41FNRSp6MgnENwgs8uGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC81LzIzIDA4OjQ2LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBUaGUgdGFyZ2V0IGlzIGFs
bG93ZWQgdG8gY2hhbmdlIHRoZSBudW1iZXIgb2YgSS9PIHF1ZXVlcy4gVGVzdCBpZiB0aGUNCj4g
aG9zdCBpcyBhYmxlIHRvIHJlY29ubmVjdCBpbiB0aGlzIHNjZW5hcmlvLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K
