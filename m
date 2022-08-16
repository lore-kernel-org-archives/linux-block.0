Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038CC2BB41
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 08:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiHPIFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 04:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHPIDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 04:03:44 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F09109A1E
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 22:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnNTjRrE+zf0yDIRR0OI9nSjOpAeH8j+/s0CwSS1D1i+UUzc0pLLcJFDFY/x4+sSKy+leqSXOvUjksFudnoc9ZCqdBgfFlKnnx3qFC71n3zmAu8Rnm3xnED0SjaJzVubf+ndpYONKCfUB1wz/JR/z3hsd+UhV2PdnEmlavfh72w1PdOeIgWHQNFDzDU4ZfVsgczM9SpTrJoq7RCb5SAQFCy3VdU13fk69sV1OqQte+f/79M5PK5o7ZZLbSO2q/YxBdbe8flfdYrKABFIlC3eXYzic5roVpfxp3sf4h68VTsaWm1UpPP3XfoscsNJLx2wYqMnm3/3yVq8YRqiVwfeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//cUabbitNJI7Cb+2TE4YhYw/G1XRuqdNXEcq7dX4Vo=;
 b=n0pFdeLIR6CRC7MPRF0DkccQUBChF6Vxc+uPBu2Gfte6KSvcawCibc30kP7wsXg0fv3wJ/dsJCMb6dguV29/DjM2q87eH6lMwXXU/6VgRGPfiQ5HfmhBBnEstGPSG7q0e7iZyfz6qdnpzDJpA1CdxblcnTfMACRkqJc8HEDGpkzLWvPXleJxGAKCAjRDPeKqcFK2gMgA8Cq4hZjoHcCW4yWo46l49uxmCz6eVchZC9uIAKr2xQLS4Qn0nKw9v3ZZ6EayqOyGZyLFZ4DSWG+q4aX86TEawrx21hPHl8kaaJIY3dGn0MPtDRcOEAIoGZeCYKqtmj4A+RP0hDZgDNKk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//cUabbitNJI7Cb+2TE4YhYw/G1XRuqdNXEcq7dX4Vo=;
 b=m3YIeB/czLSfbxfo5bhaYueoETG720uwbafBRllj1vtqVdCKEV78CCWj/GOZLWpkaOHlVh5hE8QITqCL1fCWBPiWkSKBd4DC4yFRLK4OSI9ojkapxG8zzXifh31v/dZonoX7r7crw+tmfqpHh2pIuNNazAui9Rhy0MMjDLnjeOiSI5+nTgxIGFHBbfjxccVVHIVWm1n/e5gYF5Jv35puh2m7u2UoykdGpbDU00CZ/Xwg2Q+5JrTmy50G0mIi1mxmxUg5xUee+I6Z0ZE7dWeH7gdgEVTzFm3HzbVzgUw47Uxul+Nj/n5McWeOAu/j74gWHiyp86GF0f58F/nkOHOsIw==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Tue, 16 Aug 2022 05:26:49 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5504.025; Tue, 16 Aug 2022
 05:26:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 1/2] null_blk: Modify the behavior of null_map_queues()
Thread-Topic: [PATCH v2 1/2] null_blk: Modify the behavior of
 null_map_queues()
Thread-Index: AQHYsMiciuIVJpqOJkKXVYACCLXpNK2xAACA
Date:   Tue, 16 Aug 2022 05:26:49 +0000
Message-ID: <e7424a4b-aad8-0af7-30fb-73f552d1e633@nvidia.com>
References: <20220815170043.19489-1-bvanassche@acm.org>
 <20220815170043.19489-2-bvanassche@acm.org>
In-Reply-To: <20220815170043.19489-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c89cf95b-d858-4b86-dfd0-08da7f47eb4e
x-ms-traffictypediagnostic: DM6PR12MB2684:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDRGiDSk0N7YPHjv+Ak+Qwpp1JN8WRboPpCq99JvxNuyKwGFxiELBml1Fbntu5opneDLz1gb+PQrFhBZn9qAuep3W/NG2pWOVVslM0c1vxC2AnuyT0Ctl/4I+Ih+WbNdm2tfVnATJXAkzQAYDcjXlq+kS8MfZmCHHtsrvsDvwCBwnZqgE7A4U3L+46Z1talPs0nNTkOxQIkWcmkKBC5mL63W5k728oppKoUbto7gfsi7WjvPsdHOV8EyLtOqtTCzVWU/9aQylc/+ySH7+Zdg+V2Oo+6CHu6XtX9KLNbaEpeum+JE/dweomvPIHrfeeFv+pexjMtyqzNB/vKR8f6kBh58K57VdeSydmx6+yqO5rtPB9z7ig/GhWUxoV69L7gw5f5Own6DBQIMzDIKS4ekZVa+Bl3V27icMmm400VtOTrIiMOk+xxLWBOSkYebeBCbgdXyQ8jsKAIYiAMtJzihAM9zF3OcuNBSPKmKyhcBp4nOWM24Grn40B/zfMfoI6/pM7iTKqPc9TUI2CjJYeNdC8oLKlVudqL3lnMyxwcyp/1iUSMwkTYZ9tH+DrIuugdbLeuCCsKwAmq+mwHtwuAS5DyEx6LViEBxhzD+wXIszhZs73KMOdSAEFnpyix+kOIOW0Ik+s10JDT46Kcu2Wm6S5TEsmjodY4fa+B/fveVfOXIjPIzmxCA1jFhS+IosZws2zCY54CEUQuM2OR9Oeckf7CiKRgbVmNVsqljyGSgHGwc3eM8cRhu67ygNoS6fLMHTeucZvmMihnh59I438Y2J3CKqWSqBVcsp3yPsTEAz265tUU1h2lbuOS/fnxSiSBc9wYjopxVLgrYDDNqUPK2tRq9P/sLuU21bAwPnfYKOUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(6916009)(7416002)(76116006)(54906003)(38070700005)(5660300002)(91956017)(316002)(66556008)(41300700001)(64756008)(31696002)(4326008)(86362001)(4744005)(6506007)(6512007)(53546011)(36756003)(8676002)(66476007)(122000001)(31686004)(2906002)(66946007)(8936002)(66446008)(83380400001)(186003)(2616005)(478600001)(38100700002)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3JGME9sdnZNQTF0dDVPdEJvNHRUcXpqOXBKelU4VzVWMUg4YnpBOE8rWE5Y?=
 =?utf-8?B?RXhuL0ZpZkxpcFU4N29vbk9yNlpNQ3dacUJHNW9HUHhGNDB2ZjRZMjdUbExN?=
 =?utf-8?B?bVdtT2J5cWMxUk1TeC9ocHhLcVpkYWl3dGtkNFJTOFU3WW1welQwR3I0MUM2?=
 =?utf-8?B?WVZSYTYyUkoyb0xBdDBaeW9SbUZLUzBUZEpyUEZ5T3l2SEtvdHpFTG8zbXVN?=
 =?utf-8?B?NGROM1VmenluY0VUQTFvVlhWMUJPTFF2N29uVlZnMnB6amxqb3dQU09ZRVN6?=
 =?utf-8?B?MGtGbHdFYlcwNktmbWxLNVdFdWFlVS9rdC9PQmVTREluSjIxWE9Vbjc0Nlht?=
 =?utf-8?B?dlFnNTVqVUVWRUFLc2JCdE1QVm5ZbmVwSk44YjVXUEEwME1US0JtTld5UHNn?=
 =?utf-8?B?TXJtekF0SFowTWNFdmhsQnlhQnh1R3ZtNSsvSmRyUDV5V1lQSmxxRjB1dTIr?=
 =?utf-8?B?TDFDbWhTTWlPdTdyQ3JpaC9odmJvWmRyNnpPUkhkMDhsWUJJcnFtanBMSk5k?=
 =?utf-8?B?ejJOVGczUDZYM0dhMEtjeE93RVE2b1BXSC9hc3pvOWRIWWFNdWU3NmlsaEVQ?=
 =?utf-8?B?TGJwaUZKdjkxZzUrbHVHUXpSb1ZLd0lhenQ1Q0d1QjJuenpHamJjR2VNTi81?=
 =?utf-8?B?cml0OXRFWGF3OUFzRzB3UDBMZzMyOVB6QVhsRnJtNGJmeU9XdWl3c3lmVjc5?=
 =?utf-8?B?Mnp4ZjkzaytJVHVrelQ0QkdkZnN4RTBpTU4vY3JGZndHWFlxSnptMS9KdXRz?=
 =?utf-8?B?Y3NlaVRNTVpJbDFDVFd0TVZEQTNMMWM4MFZGT09tZnBEL0t4Wm14RkFIdGNi?=
 =?utf-8?B?VUxjV0FWcnNNZnc1OTVnQ1loMldCdEJwOGlrcmY2QWlFa1diN2RCbmlzSnBo?=
 =?utf-8?B?am1IaWhZTzRXbm4yMVhDTDhnSlVndlpmaXB5SzNTWUxZV3EwOFAxSFJReVh3?=
 =?utf-8?B?MTdERlo2YXl0eUpPWDUraTNvOXlQZFhpTHdzVDczdkZaYlNnQjhTU3VrTDZv?=
 =?utf-8?B?V2QxakVNa2NLeUdUankxeXNjbWxpeitvcllNaU1qVUtEYzc2bVVYKzQ4UzBQ?=
 =?utf-8?B?S0t5YUFHUWNYUDRZaWtHOUtwWFB2M1BFb1c0T0ZBRlBMazk0QVZEb1ZkV2Np?=
 =?utf-8?B?UXlWSHpYQ29FSWd5Mkw1dW05bzFxWFIvOHRXTG14RzIvVzl5WnpMM0VVTFBW?=
 =?utf-8?B?c3VsWFNEWHhjSzl0YkVRNUpxWGxjN05vU2ROMmtZU0RjMXduWHZ4VHpFdUta?=
 =?utf-8?B?aGlMQXdSNElKOCtsaWViOFJtRkhjUlEybVlTL2dNT3FzdWgwcXNyYnhmak1u?=
 =?utf-8?B?ZjdGNFJFTHB0aEh2VTRGbG1qVmpTbEdJcTVJUVppQklGQ3dBUk9DcVc5cm1o?=
 =?utf-8?B?WDB4WkZxZXRMbjVsQjhiQllxeGREOFh0Sk9HTDVWblQ5WjBZU25zTk5Jd09N?=
 =?utf-8?B?TVEwdkVXMVRvNG9hTEkyUXlQTVo2UWhMWXYyTEF2OHo1NnJybHVYaWFpUFZZ?=
 =?utf-8?B?NGFYWEtaMDd0MTc3Y0E4TnphZGtOQmIxT3ZwMnlzRndCdndrNHFadW5uemlP?=
 =?utf-8?B?eVY5QysvYm9kcnFZcm54T0FUZDBZYTJMR2tMV3F6RmxKUVNSNzdsMUpud1Rm?=
 =?utf-8?B?UW5RUS8zYjczWjh5bWJZQlVlUTd4WEtldGR4MmtyUHpqam1oS3dQbmViSW9T?=
 =?utf-8?B?YjhiYXNQdDF3Y2R3eVJOYy9NTXI1aHNQdlY5b3lMSW0ybXBpM2xjSFRYczlY?=
 =?utf-8?B?TVorbWtPUXdsNWhBK3ZYWUpTdTIzOEV0UDkzcjdIcDlmV014bDNjOGkwenpm?=
 =?utf-8?B?TWZGTG9NQzFHbkt0OEo3cEpnd3U1MytqTEt6TTg3NVZMdllPUHdFelRsRkJI?=
 =?utf-8?B?WkJmeVBGTmhMQ0UvU1hxdlZMYmJoRVZqMUZXK2NiVlhPcE51bHhFSVFIV3VJ?=
 =?utf-8?B?VjYrdnRQWVM4dHZFYnFXMmhaRVRyNGF3NDloV0p3MDJRbDcrUDJaRlBsc0hp?=
 =?utf-8?B?c1lmVVA0UkpGRXJmSFFaVmVkcVNjWXNmTmhGWDJvV21aRVFpWXNPVllsdy9q?=
 =?utf-8?B?WHMvQVgxaThIWlFvVDErbUN0TGE0Q0NJVmxGc1pXemR4MHd5ZFRJSHFnZjln?=
 =?utf-8?B?UHNBNUFPQ0szVnVmeWZxNy8xbTNTdUpsR2N4eFVZRS9XcURoVjl0a1VYQjhP?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9266823A5D282C46B91B90421DDF31D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89cf95b-d858-4b86-dfd0-08da7f47eb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 05:26:49.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+223hvyS61QLSlBX9YiOoA11Lmad7Nm16khZiHgsvtYCHPPGerNiWOlyDoldQmQq21Li8OOn2F9LUDU7AvDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8xNS8yMiAxMDowMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBJbnN0ZWFkIG9mIHJl
dHVybmluZyAtRUlOVkFMIGlmIGFuIGludGVybmFsIGluY29uc2lzdGVuY3kgaXMgZGV0ZWN0ZWQs
DQo+IGZhbGwgYmFjayB0byBhIHNpbmdsZSBzdWJtaXNzaW9uIHF1ZXVlLiBUaGlzIHBhdGNoIHBy
ZXBhcmVzIGZvciBjaGFuZ2luZw0KPiB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoZSAubWFwX3F1ZXVl
cygpIGNhbGxiYWNrcyBpbnRvIHZvaWQuDQo+IA0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+DQo+IENjOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IFNpZ25l
ZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg0K
