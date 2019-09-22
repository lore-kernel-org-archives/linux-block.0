Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4634C3A5A6
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 22:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F77A20882
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 22:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CS9IAv3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfIVWZv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:25:51 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:6145
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfIVWZu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 18:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccI8jfyMHVwhOQlISFj8GdIb8ZZur4pPCgZBVI385cea/L/jipItA8OTxOEd9JZ4hTtJwIY2znBe7OMTTBYdxzSMjUZk4gVB18CSoQUYsWErt25D0JE/emR6+zQn43+6r8ZnpM/qxORkvghCCsjMXPAwnkDmX7yjfqLAJnKdun1u6Xr3qCT38ON54xEoXTJUaSe4Kr3wRQB8XvCSvM/2nDyvYRF95YK8iCbSYqtKXR8X/g0dV5k9WupNhNoIQMttZiqYiUOw1UyiG17jSvULlroXXrEbWPUNMatRl7bhEDLEdjmDuj4JD128LUP615Dg7Qj3WlufMicFm36XraanZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP5vWnX1cmx5wQNXj610b7UNCrsKKFHIf2Pb/P2Kc6g=;
 b=nkTiDRpY+ENNY14MUFkmlH/FFfzcITUVN2LbjnGl76LzZbOEr3Xfu3aRY/+7UeWCFcGZerJeH38uQFf/HTuyM+cEBh/39GhQt2sCuoacPeQ/0mOJcEZP/ouotRY2QWIuusP9++OItQNh6ZRvhqoaeGn9z9PuzUB38+IlXR4hDMDrH0NJxRi1G+i2H2vSVw8tZ7607BLBIRl89e0WJboGYlmZRCnm3pIbk9RJZub6O/lCYxYbY8HJzAt1A2NzUEZId+N9lITbjOiGhwqgsJMhtTOwF7fjiKPggXdbPirOXqbbnrd23zLuk14DgqSUxg1iXC1k8r0WGv3OPWQtfwP2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=arndb.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP5vWnX1cmx5wQNXj610b7UNCrsKKFHIf2Pb/P2Kc6g=;
 b=CS9IAv3i1mti1TWLz7Xqps24IzRWfBU2Jqo0wQh3S6GsyKOKeT2oYe54zTS3B9ovSNzNGNOnPfaON0Xdk4WC371N0Jj16fC50nRJu9WS7HtiNZpWL7Rf/ZUrSbLtJ8T4bNZETkD72HzGxTw96JHsyGSDAvbCb+lmhCi3wFXfpsM=
Received: from HE1PR05CA0218.eurprd05.prod.outlook.com (2603:10a6:3:fa::18) by
 AM6PR0502MB3944.eurprd05.prod.outlook.com (2603:10a6:209:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Sun, 22 Sep
 2019 21:21:21 +0000
Received: from DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by HE1PR05CA0218.outlook.office365.com
 (2603:10a6:3:fa::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19 via Frontend
 Transport; Sun, 22 Sep 2019 21:21:21 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT047.mail.protection.outlook.com (10.152.21.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Sun, 22 Sep 2019 21:21:19 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 23 Sep 2019 00:21:19
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 23 Sep 2019 00:21:19 +0300
Received: from [172.16.0.111] (172.16.0.111) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 23 Sep 2019 00:21:17
 +0300
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI
 types
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
 <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk> <yq1tv955kfy.fsf@oracle.com>
 <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
 <423a031c-a016-96c6-97ee-fb4e49a0f247@mellanox.com>
 <ddd909c8-1309-5830-0669-371d2ae839fc@kernel.dk> <yq1o8zc5jc2.fsf@oracle.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a98735bc-3a03-0816-5fc1-abac2c6b4fc6@mellanox.com>
Date:   Mon, 23 Sep 2019 00:21:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1o8zc5jc2.fsf@oracle.com>
Content-Type: multipart/mixed;
        boundary="------------3402F18BF7C1093CA1C92549"
Content-Language: en-US
X-Originating-IP: [172.16.0.111]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(396003)(136003)(376002)(189003)(199004)(31696002)(561944003)(316002)(54906003)(229853002)(58126008)(37036004)(106002)(81156014)(86362001)(81166006)(4326008)(16576012)(16586007)(31686004)(356004)(6246003)(8936002)(305945005)(6666004)(65806001)(66574012)(8676002)(65956001)(66616009)(70206006)(110136005)(568964002)(70586007)(36756003)(5660300002)(14444005)(5024004)(16526019)(26005)(3846002)(53546011)(6116002)(186003)(2906002)(235185007)(7736002)(2476003)(478600001)(71190400001)(336012)(33964004)(76176011)(446003)(126002)(476003)(2616005)(11346002)(486006)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB3944;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d4ca788-bc89-407a-f14b-08d73fa2d093
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(49563074)(7193020);SRVR:AM6PR0502MB3944;
X-MS-TrafficTypeDiagnostic: AM6PR0502MB3944:
X-Microsoft-Antispam-PRVS: <AM6PR0502MB39445C10B20F884569747843B68A0@AM6PR0502MB3944.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 016885DD9B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QxTlTmzIfN0/PZ2l+swmgncghuktMiV5rJhHawp68cibPW6YQJB1ewxnqf/cOiBvP2630L6qU0CA3TScUs7yytSWrqJRdWdmuGWXR7xQZHxvUgV7on/1beD8FcKPXsPpF1d7aw7/kQaqbZQ1EAz8AQjf9QEufm8h8/WaRkqhGuXL0+0W42Pn2XWDTJUmK1a6bfUTsldmXg8HiJBdu5cy7CUsXusFeJ2Ohj/dOg/A7f8sEs3EaIltnzJYGWPFV05PGDmGY4WN6W+fyy1PnCOChJqiFFyJb0izxXYd/k2GBBALbaEfp8QChT0RPvzEm654qgkXzpiwDAAnFOPQhCtOIOpv6dgmr/ijuLY6/jMYrWARr1lu8tKe6lIb+oBN1K5IhVdoiBeigIn6ib/IXZPhC5DPasVY0740mmsHNT9ffzc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2019 21:21:19.6990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4ca788-bc89-407a-f14b-08d73fa2d093
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3944
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--------------3402F18BF7C1093CA1C92549
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/2019 8:31 PM, Martin K. Petersen wrote:
> Jens,
>
>> It's effectively the same thing, I really don't think we need (or should
>> have) a BUG/BUG_ON for this condition. Just return an error?
>> Just include a T10_PI_TYPE0_PROTECTION case in the switch, have it log
>> and return an error. Add a comment on how it's impossible, if need be.
>> I don't think it has to be more complicated than that.
> The additional case statement is inside an iterator loop which would
> bomb for Type 0 since there is no protection buffer to iterate
> over. We'd presumably never reach that default: case before
> dereferencing something bad.
>
> t10_pi_verify() is a static function exclusively called by helpers that
> pass in either 1 or 3 as argument. It seems kind of silly that we have
> to jump through hoops to silence a compiler warning for this. I would
> prefer a BUILD_BUG_ON(type == T10_PI_TYPE0_PROTECTION) at the top of the
> function but that does not satisfy the -Wswitch logic either.
>
> Anyway. Enough energy wasted on this. I'm OK with either the default:
> case or Max' if statement approach. My objection is purely
> wrt. introducing semantically incorrect and/or unreachable code to
> silence compiler warnings. Seems backwards.

I agree that enough energy wasted here :)

Attached some proposal to fix this warning.

Let me know if you want me to send it to the mailing list


--------------3402F18BF7C1093CA1C92549
Content-Type: text/plain; charset="UTF-8";
	name="0001-block-t10-pi-fix-Wswitch-warning.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-block-t10-pi-fix-Wswitch-warning.patch"

RnJvbSAwNThiMmUyZGE0YWRhNmQyNzI4NzUzM2E3MjI4YWJkODBkZTE3MjQ4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXggR3VydG92b3kgPG1heGdAbWVsbGFub3guY29t
PgpEYXRlOiBTdW4sIDIyIFNlcCAyMDE5IDEyOjQ2OjU1ICswMzAwClN1YmplY3Q6IFtQQVRD
SCAxLzFdIGJsb2NrOiB0MTAtcGk6IGZpeCAtV3N3aXRjaCB3YXJuaW5nCgpDaGFuZ2luZyB0
aGUgc3dpdGNoKCkgc3RhdGVtZW50IHRvIHN5bWJvbGljIGNvbnN0YW50cyBtYWRlIHRoZSBj
b21waWxlcgooYXQgbGVhc3QgY2xhbmctOSwgZGlkIG5vdCBjaGVjayBnY2MpIG5vdGljZSB0
aGF0IHRoZXJlIGlzIG9uZSBlbnVtIHZhbHVlCnRoYXQgaXMgbm90IGhhbmRsZWQgaGVyZToK
CmJsb2NrL3QxMC1waS5jOjYyOjExOiBlcnJvcjogZW51bWVyYXRpb24gdmFsdWUgJ1QxMF9Q
SV9UWVBFMF9QUk9URUNUSU9OJwpub3QgaGFuZGxlZCBpbiBzd2l0Y2ggWy1XZXJyb3IsLVdz
d2l0Y2hdCgpBZGQgYSBCVUdfT04gc3RhdGVtZW50IGlmIHdlIGV2ZXIgZ2V0IHRvIHQxMF9w
aV92ZXJpZnkgZnVuY3Rpb24gd2l0aApUWVBFMCBhbmQgcmVwbGFjZSB0aGUgc3dpdGNoKCkg
c3RhdGVtZW50IHdpdGggaWYvZWxzZSBjbGF1c2UgZm9yIHRoZQp2YWxpZCB0eXBlcy4KCkZp
eGVzOiA5YjIwNjFiMWEyNjIgKCJibG9jazogdXNlIHN5bWJvbGljIGNvbnN0YW50cyBmb3Ig
dDEwX3BpIHR5cGUiKQpDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KU2lnbmVk
LW9mZi1ieTogTWF4IEd1cnRvdm95IDxtYXhnQG1lbGxhbm94LmNvbT4KLS0tCiBibG9jay90
MTAtcGkuYyB8IDExICsrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL3QxMC1waS5jIGIvYmxv
Y2svdDEwLXBpLmMKaW5kZXggMGMwMTIwYS4uOTgwM2M3ZSAxMDA2NDQKLS0tIGEvYmxvY2sv
dDEwLXBpLmMKKysrIGIvYmxvY2svdDEwLXBpLmMKQEAgLTU1LDEzICs1NSwxNCBAQCBzdGF0
aWMgYmxrX3N0YXR1c190IHQxMF9waV92ZXJpZnkoc3RydWN0IGJsa19pbnRlZ3JpdHlfaXRl
ciAqaXRlciwKIHsKIAl1bnNpZ25lZCBpbnQgaTsKIAorCUJVR19PTih0eXBlID09IFQxMF9Q
SV9UWVBFMF9QUk9URUNUSU9OKTsKKwogCWZvciAoaSA9IDAgOyBpIDwgaXRlci0+ZGF0YV9z
aXplIDsgaSArPSBpdGVyLT5pbnRlcnZhbCkgewogCQlzdHJ1Y3QgdDEwX3BpX3R1cGxlICpw
aSA9IGl0ZXItPnByb3RfYnVmOwogCQlfX2JlMTYgY3N1bTsKIAotCQlzd2l0Y2ggKHR5cGUp
IHsKLQkJY2FzZSBUMTBfUElfVFlQRTFfUFJPVEVDVElPTjoKLQkJY2FzZSBUMTBfUElfVFlQ
RTJfUFJPVEVDVElPTjoKKwkJaWYgKHR5cGUgPT0gVDEwX1BJX1RZUEUxX1BST1RFQ1RJT04g
fHwKKwkJICAgIHR5cGUgPT0gVDEwX1BJX1RZUEUyX1BST1RFQ1RJT04pIHsKIAkJCWlmIChw
aS0+YXBwX3RhZyA9PSBUMTBfUElfQVBQX0VTQ0FQRSkKIAkJCQlnb3RvIG5leHQ7CiAKQEAg
LTczLDEyICs3NCwxMCBAQCBzdGF0aWMgYmxrX3N0YXR1c190IHQxMF9waV92ZXJpZnkoc3Ry
dWN0IGJsa19pbnRlZ3JpdHlfaXRlciAqaXRlciwKIAkJCQkgICAgICAgaXRlci0+c2VlZCwg
YmUzMl90b19jcHUocGktPnJlZl90YWcpKTsKIAkJCQlyZXR1cm4gQkxLX1NUU19QUk9URUNU
SU9OOwogCQkJfQotCQkJYnJlYWs7Ci0JCWNhc2UgVDEwX1BJX1RZUEUzX1BST1RFQ1RJT046
CisJCX0gZWxzZSBpZiAodHlwZSA9PSBUMTBfUElfVFlQRTNfUFJPVEVDVElPTikgewogCQkJ
aWYgKHBpLT5hcHBfdGFnID09IFQxMF9QSV9BUFBfRVNDQVBFICYmCiAJCQkgICAgcGktPnJl
Zl90YWcgPT0gVDEwX1BJX1JFRl9FU0NBUEUpCiAJCQkJZ290byBuZXh0OwotCQkJYnJlYWs7
CiAJCX0KIAogCQljc3VtID0gZm4oaXRlci0+ZGF0YV9idWYsIGl0ZXItPmludGVydmFsKTsK
LS0gCjEuOC4zLjEKCg==
--------------3402F18BF7C1093CA1C92549--
