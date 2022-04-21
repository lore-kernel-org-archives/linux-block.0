Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB22C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356628AbiDUV6J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDUV6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 17:58:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF804D271
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 14:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVjcnLVzH6kwEP784GBnPoQYZNSTdfeVitHnZwkK7F6QVWv6AfsrtwxldOk7xEvnKL2jCip6NAsuPbkBmXsj1wo10dBpRX4HrgjIerpA5LRIJK3df4LwdwxqfTx7bZt1GKsxmncGq9swDrf4cXuw6fwrll3sVCp4cN8cC8yWczdELnfmA66Ivb5tdXoW21obfHcdUY7tFhsDeqnR4nQc51Syj6faBSZFJm/bhBXj2k+xb8UIkg7xMYU/+ytDeEerOHmnkU913z3fEfPC/Ao+hOpIMdAvJrOXLoKNQC5nKd0alYAe9cy2y50+b1nxBNm5/UOxK3hv0jUP8Cp5VuFGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKn9Gxx8ZBmL5D7j7PdXJPTjJugxg7lsVdZ7E18xhpM=;
 b=YjC9QMtZctyhWHNQzYcn7OHy301gDGUz938qyo/b+vKTQO6ppdcf5r9yO7ZJXip6jjI+WyJo7wREP4pbmhNjO/iTnuBrTPELUBe+YHHE5Fuj6Pizm37rqXfd9jatxmGUZe9sRRC6v8a1sz3DkZ/J7pvGk0LJEsYBoLR6zNsofIKGPC4pxWErvKAHVaNE5IZrb5CsidJH5WSMMLb7vMr/H9ubsqdr36peAGPXHgYqYnonxTTH9BBu61jppFkyNP10E6fj1hv0joJi4fM2tl1Ejl2pFRkAomUVBc+05Pv/ui5jnGUV7tQo+hjSkLKKAEQZLYfmC0wWLDjx8R9xWuOCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKn9Gxx8ZBmL5D7j7PdXJPTjJugxg7lsVdZ7E18xhpM=;
 b=g8eLJbWHT2H7ulm+3lviDOol/KO6yrEqRPYl67ZuSW+cfhLpdcbkYIYbj9ICrnPUZZtlc7LXyFxN0jV7szBCQ0IjEGjTL+yMjCA65zCnLMBIJnL4sII+vbAZD+xsWjQIfi7bqkHfiMbv6GNp/e6Bwu4dYenHblmPDhhKG2moS36d8gebzZ9SgI93x3613+L3iVg5OmwNuFY8izodjS8Db0f4fPbvQVeA233Uu80kitHmVvtcpAUaHUWS7O1/D0FLZyRy837TJCVBlitHfsqbYClVi0oG96Xpxix7jFXlpRAQw9OBbg+z/hqKNUhTmzVj7wQ3oJuGvlbNlMUT5vq6kA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 21:55:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 21:55:15 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] virtio-blk: avoid function call in the fast path
Thread-Topic: [PATCH 3/4] virtio-blk: avoid function call in the fast path
Thread-Index: AQHYVGy6NMWwP9csJkOZrLVHRViI66z46j+AgAIB3QA=
Date:   Thu, 21 Apr 2022 21:55:15 +0000
Message-ID: <928aaddc-9bff-c824-69ae-33e708ebb955@nvidia.com>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-4-kch@nvidia.com>
 <YmAjs0O58TuGkJO8@stefanha-x1.localdomain>
In-Reply-To: <YmAjs0O58TuGkJO8@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38df359f-b0ee-4b3f-d3cb-08da23e19e06
x-ms-traffictypediagnostic: MN2PR12MB3661:EE_
x-microsoft-antispam-prvs: <MN2PR12MB36614E625F347F977463B15EA3F49@MN2PR12MB3661.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCdVo30Wk6M6msP48CM98TbL46imEHKMyVHt7Tc6hmazmxCLqnJa/l0dCMx0hyi7ey6Wb2lEe/HX4zJDCIbFvc5GmI1+2kN5A1L6xHTAGxByeDsF8XvD4PfJFgzbEWSHtI3onCyheEtc++PdttzWJcE6YoeE9If9t8Esha4zpZWlSaX43R9QD/oZqQaaDSbRcUmBGVP/hGfemM9D95B+o/9hXN7kY7ZrhA3f6kfcgPaJzdKSEz+PvJrjN3M0YF8PgN1Og4nBJ+unRkDaI6CnYesa7xHgIrDCByvzshTNzLqLBOCasejo4zlnisN2oFVhuaGFwrQhRUHZtIxlSJfcTUx0vmUDtL5qSaJ3sban3+z13JWeBqfhu0l0hB2SZH7EjT2tzm7A3Qi76flY9LfIOycNMJlR3BivuD1Ro9Tob91wPyf9fP966gut50nDeziID4C3ZrQTNBhEhyqyZ6sOzA/Fg0ZSnU5SWSBW2f5mkKWF8mLr+NDxCVE8zwJdHrsuMy128RtLNH1Z7aMHj3u3Ghp1D6QlSumclO14Vx0UfPnjWKvvx7hoVQl5wX5dmZjqdolp+d5wLx6bRSuMTUPKud1z6mpKNEWgWGItwyHY8+H0A7Dl2LEChvkhT17rfEbKSI9IRngduvoL3esuG6WRhQwtILXhSKssXF2Q7pFIkL0bYkQ3PjmO7jYc0T3U9VjycNsIMlujoZIqq/19vFOitPXyQXvLhwCFjz7/a1OhX1xTV6BuSIa6wr4lbmJCku3/nW1u6KSCZqCFc9iZ+thsiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(508600001)(31696002)(54906003)(5660300002)(6512007)(110136005)(8936002)(53546011)(2616005)(36756003)(186003)(91956017)(6486002)(316002)(26005)(122000001)(2906002)(83380400001)(66446008)(66946007)(38100700002)(38070700005)(86362001)(66476007)(76116006)(66556008)(8676002)(64756008)(4326008)(71200400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VTNlFBVkxNZ3VWUC9vcEU4bk1hQmJqNW1yUC9NdzVnMUFVOG5yWGR3Zk1t?=
 =?utf-8?B?TzhpNFV5MzkwNW9YdGFXYzJGTEh0L2Z6U1NNeHBJb1N2cGNyekdSSWdBK1Zu?=
 =?utf-8?B?TTRsSTJiTkNmY08vSTUxcTZWUHZGTS9xN2pFaktZYVpOaVVzRzVZL1lxRndR?=
 =?utf-8?B?Qk1DNFBITXM5d0Rqb2gwOFlyNmJFVm1ncmQzYVFyUWRLM1hUSmFMYkNVNUJv?=
 =?utf-8?B?THhMbk1uZm9USHR5b1JrdGtpNHlpWG1kcWhYRXlna1ZmREtEMmNLV3FNOUcx?=
 =?utf-8?B?QzRBK0o2OFNLVXMvNVlidllMY05mV096a0ptdi91azd2blMrbUs1aCtRdmVi?=
 =?utf-8?B?WHFFZWI0YlhYVnlPV2JnM2dwNnVZa2ZyNVhCeGNoVE5uUlVmbXRiZEpWSmdx?=
 =?utf-8?B?NmNLNk5tbktpSDZvbVlYT1RFTkN5YjJJWVlFdGl5YUFNZy85M29xeDRtaEpn?=
 =?utf-8?B?VkY5SUlnc0hUa1MxcURXQW1neW5BbWVxdWxibFlnWlVBQkVuaG93RGc0cTMz?=
 =?utf-8?B?bWV3MzBycHlzczhkQWxxaWpmc0Z6bUlJWTFMeDUyZWtXUHEvcjFpQnNWWEZn?=
 =?utf-8?B?b080VTEvNVNCaXZzZWJ2bGhPbkpITmZFZG5mdS9LdXFCWGJ1Q2szUjhZUDQ5?=
 =?utf-8?B?Zm5QVkJ1dGR1cUpINHhZTTBtNURMVjFYM2I2bzBRQ1oxNWdvZlovN3BqWkZx?=
 =?utf-8?B?S1Q1cEtyL2x5L2VOcW5wdVVZZ1o2bTBBVzdqWEZIUzFkeUVzUXpBZW5xdmFY?=
 =?utf-8?B?bTJ0cnVJSytZc083YnpNVytWaEUyMWNzM0kxQVhJSDJvR3hGYUdPME4xN2h6?=
 =?utf-8?B?YU1WTUVxaSs0aFlJZ3NTMER0TWNLVGtDRGQydlFodE1nUE1XbzNBN3lYY1ov?=
 =?utf-8?B?UWtxdXp1MXk0MDJrQ3FqeTAyLzBrQmttS0ZUUzBlWFJXYTFXWSt6aVBRU3Fi?=
 =?utf-8?B?OVA1cStZNmF1UUhkR3VPc3g0NDBRSFVod1Y4SXNidERabWtudXJuWDM1YmJ2?=
 =?utf-8?B?Tmd0RzQ4bnlpZUNISXorQmtrcW8wWEYySGNIbHVIMjk2by96cWZnSXZqa3Fa?=
 =?utf-8?B?Smx4c0JMQmUyTkNiN0V0S0V6UjRiMm94ZEVoZWpYUFZSR0c0aDZJa3c4NWpy?=
 =?utf-8?B?VlVlV3Y3eUZoQjFObTlXd2NXOTRxbzNLa24vNGtkVEZ2NGROU0VkTmExVVNL?=
 =?utf-8?B?Z1p3VVpiK29hV1k2WTRnQWV3M3cxTnNkM094eDVMU29UYnJxZWNzR3ZRQ0NM?=
 =?utf-8?B?YmpFUURRMlMyVmd2V1dWczBTcDVNbmZVdjZQbFNvRlVLUnBkL3p3MXlHSWNq?=
 =?utf-8?B?dmJheGxPTWpCSWZ2MzRNb2RaREhUcUVmbldFbU9EREIvdmFaMkNaV1pLRkVy?=
 =?utf-8?B?VWoyZU9uV2JxOVpBbU94N290WnBwd2RSaFBTNFkrVFAwcFhQTHVjeEhMNkFa?=
 =?utf-8?B?ZVlMVmdFRktIL2xMcVFjb0M4cW9Wb3RuMStycUx6b3YyVTNDanZlMTJpZTBo?=
 =?utf-8?B?a0lkcjhOQWdFSXp1Y3R1dFQxMngxUlYzQlVyc2NSOWJUMlBnUW1sS3N6ZU5Y?=
 =?utf-8?B?UEJ2U0pQRlBobVk4YjlMSkx4MGxkUlYrVFZ6UEJqdFFjTlR4SkcwUVVNVE5T?=
 =?utf-8?B?dTI3RGM1S05Da3VMYkhSUy85d1pqMGZtME03eUxkRkczQ1hSdjFGclRzMStm?=
 =?utf-8?B?WmlxaTBSeVgvd01kQ3RMNVNkL1VqVmdGNE9XdkVGbHZMajljeXhqSUFyNGJ0?=
 =?utf-8?B?SjFZVHZ4Q0dhZm9PN1NSekVlRVBBVjN6NWNPdExCNkR2aHUxeERia093TG1H?=
 =?utf-8?B?QXZvcU4zdFZSSWxPSDRNbUZGSE01WVJOdlZqMWlobG5rSzFhSFVpUUI0RlUz?=
 =?utf-8?B?SlpablB0NXBZQnhKdk9RZmd2K3hRWUZTOUZlcG82T3hsMWRjS0FnZGhRRmRs?=
 =?utf-8?B?Z3BtQUpMOTZWMDBrZXFOb0JEWEk0RkwxZk0xOVJoOGRYRFZNK3FSS2VnRzZX?=
 =?utf-8?B?L1NKMi8zN2dPZDdsclZQalRCVmdQM1hKSE1hcEVCYkI3dm5RMEdoOUE2c0tC?=
 =?utf-8?B?eE5IbVl2NHFTSFdoUHZPb1lZOW9sVFlBNHNqWFo0R05BUk9hckRZUVNVdlMw?=
 =?utf-8?B?M3V6SVJmV1N3MEs5Q21zQm9XQUVmcS9FU3BFUlVUTytTMnhsWFRwQkNqeXhq?=
 =?utf-8?B?SzBOL01ETGM5aHZEdDVucUM5cDhIL2FiQTRjN2JTeDQ1eXNJZDBGRjV4WjQ1?=
 =?utf-8?B?ZXZBb1Q4YzhKOVBNclRHUE5idTAvQU51KzlBZXpqa0tPRUZoTGp6dFQwNmxP?=
 =?utf-8?B?V2p5aVRwOFVGMWFYdVFUNHNDK3kzZUt5eEQ2RHFhWGNiTDdGZ3dndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEEE72CDF25980498FACF385EA4D4C82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38df359f-b0ee-4b3f-d3cb-08da23e19e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 21:55:15.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eQdk4fNpAVd/DLw3rmXePFNj2V3aYvtvCALljdbGVBSsa8JGLcJRGReJPDUW0g7IVeEgUraJV4ZPgayVryrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3661
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yMC8yMiAwODoxNiwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAx
OSwgMjAyMiBhdCAwOToxMDo1MlBNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+
PiBXZSBjYW4gYXZvaWQgYSBmdW5jdGlvbiBjYWxsIHZpcnRibGtfbWFwX2RhdGEoKSBpbiB0aGUg
ZmFzdCBwYXRoIGlmDQo+PiBibG9jayBsYXllciByZXF1ZXN0IGhhcyBubyBwaHlzaWNhbCBzZWdt
ZW50cyBieSBtb3ZpbmcgdGhlIGNhbGwNCj4+IGJsa19ycV9ucl9waHlzX3NlZ21lbnRzKCkgZnJv
bSB2aXJ0YmxrX21hcF9kYXRhKCkgdG8gdmlydGlvX3F1ZXVlX3JxKCkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4g
ICBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gdmly
dGJsa19tYXBfZGF0YSgpIGlzIGEgc3RhdGljIGZ1bmN0aW9uIHRoYXQgaXMgbm90IGNhbGxlZCBi
eSBhbnl0aGluZw0KPiBlbHNlIGluIHZpcnRpb19ibGsuYy4gVGhlIGRpc2Fzc2VtYmx5IG9uIG15
IHg4Nl82NCBtYWNoaW5lIHNob3dzIGl0IGhhcw0KPiBiZWVuIGlubGluZWQgaW50byB2aXJ0aW9f
cXVldWVfcnEoKS4gVGhlIGNvbXBpbGVyIGhhcyBhbHJlYWR5IGRvbmUgd2hhdA0KPiB0aGlzIHBh
dGNoIGlzIHRyeWluZyB0byBkbyAoYW5kIG1vcmUpLg0KPiANCj4gQ2FuIHlvdSBzaGFyZSBwZXJm
b3JtYW5jZSBkYXRhIG9yIHNvbWUgbW9yZSBiYWNrZ3JvdW5kIG9uIHdoeSB0aGlzDQo+IGNvZGUg
Y2hhbmdlIGlzIG5lY2Vzc2FyeT8NCj4gDQo+DQoNCkkgZG9uJ3QgaGF2ZSBwZXJmb3JtYW5jZSBu
dW1iZXJzLCBidXQgd2hlbiByZWFkaW5nIHRoZSBjb2RlIGl0DQp0YWtlcyB0byBhIGZ1bmN0aW9u
IGNhbGwgZXNwZWNpYWxseSBpbiB0aGUgZmFzdCBwYXRoIHdoZXJlDQpyZWFkL3dyaXRlIHJlcXVl
c3RzIGhhcyBwaHlzIHNlZ21lbnRzIGFuZCB0aG9zZSBhcmUgcHJvYmFibHkNCm1vc3QgZnJlcXVl
bnQgcmVxdWVzdHMuLi4NCg0KSSdsbCBkcm9wIGl0IGZyb20gVjIsIGlmIEkgZmluZCBwZXJmb3Jt
YW5jZSBudW1iZXJzIHRoZW4gSSdsbA0KcmVwb3N0IGlzIHdpdGggdGhlIHF1YW50aXRhdGl2ZSBk
YXRhIC4uLg0KDQotY2sNCg0KDQo=
