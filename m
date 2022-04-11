Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B436C433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 23:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiDKXuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiDKXt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 19:49:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA563A1
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 16:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FevyAv29Mas9Rbko7tyGLDxDu7ZLoZCrfL2IptHT2KKL+rwAkyLDrfDeN4fhaMZ0XS9TTViVD8rV9NzSwCaL1V/2117BTiNY6QKMkqfQlVPPufFDrKWk0oew5c3p3a0FAUpHmnp649PnWK1x6nx6t9jzhCTfUqOEgkhPAzmoe2doC6o7dmBdMTD3XxXCsDMONMb1M8QWXnjMt2Ivs7dtJoKx78RCY6SzW/y6UyPgB7FPZx9bclgTsqU+4L28jhecG4DirUf5vju6pw7ceGGTmFNKzs3U8eU6+WxDknb+nVpSSJqLqN0sTuMlLP1FznjkJFLnbrYuKrSQuzd5zKFVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltctEm/Px8/9xBI8XGUbeIdThiqPEMfndqPgg+kjzsU=;
 b=ksPlIkWJtgKN9ey1kcGIagXpGpQr3zilZw1EgvCK2R52TLmfB1AcSmE1H+7JO43KcFa5lOe1U3oNcNX3hsiM0CAnoy1k2ny/8mbaz5vgxCphLFtPpfQuglmttUXS5eyiA10wxd0YrQmSzMegaeJzHqGwmPdNTv2DdzmO6VhRIxtQK5MXjdWm0ooQnZKMyYB7/jy25mRi+IxWBnuPwzejeUtVnjOvB+J6p5uCLqVnpqCfIFXoTwQSsJtr7VfuL4ucHCzaYJgfJCQ+BkwSQNXxH8KEQxf+ldLb4CCpALClIkehuFimeH2n1iW+RwspfwhSHRPlgoZOwdptPg86NtfKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltctEm/Px8/9xBI8XGUbeIdThiqPEMfndqPgg+kjzsU=;
 b=ffu6wEXsScNrHnEMacI8wscL8D6RoCQ11E+72chwah2f0MRZdsg0oJY4i2xKn2w5TJC/NmAglEPE9Uy7CUFFz6TXNvoxsn/6JYz+zKRymlizcC05Eq1MEB5eubEaE8LL2cYwG8eIIE99AInvctulxsLhlGhSREZVi9czBzHM3+CklpnX5ZbHp6FEEq/XVRzTEXBnhDeSNK8hqWxfKQzliu14S+XIlvJFLQ7kdlLO7bEyN4TMCWjk2Nk4lcnSexasQQCigrpqG9txZnt5SxYvZngfxKozLflKmpJ2RDharE0MoQYEJo2ciI7hl1ME8sLfc0plE2nSGAsfk90pIYrCQQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1351.namprd12.prod.outlook.com (2603:10b6:903:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 23:47:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 23:47:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "elliott@hpe.com" <elliott@hpe.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v6 0/2] virtio-blk: support polling I/O and
 mq_ops->queue_rqs()
Thread-Topic: [PATCH v6 0/2] virtio-blk: support polling I/O and
 mq_ops->queue_rqs()
Thread-Index: AQHYSdw3ZzbMJFUzIky4jPf2FWUvN6zk2bIAgAFF5ACABUm4gA==
Date:   Mon, 11 Apr 2022 23:47:34 +0000
Message-ID: <86a7c623-7494-ece3-d607-63a497eb8068@nvidia.com>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
 <3b36802a-94ca-776b-bc15-51f60fbbcf51@nvidia.com>
 <YlBOgKV/y/9bCWD4@localhost.localdomain>
In-Reply-To: <YlBOgKV/y/9bCWD4@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c6afaa8-14a7-4768-c4bb-08da1c15a6a6
x-ms-traffictypediagnostic: CY4PR12MB1351:EE_
x-microsoft-antispam-prvs: <CY4PR12MB13515CD926FC95C8D2DB76B0A3EA9@CY4PR12MB1351.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9RD3iPeLcIqZPrJfX44CD3gT0SlrwyE4q/uROoCBeqg6+ke/jyWovEIXtvXL5cKUFiCAEpoL4jHTUC0ebD4ujq03Nfzp1PX3NDgiRIPKWl7rAYgK9mY46d+T8JW/gLIGE+uG+8fMC/BPsTRGmlMD4m4fmHu8xm7Pv1AnxEtUun1ZBHac2HPONXHIBi8NskpoapnZLNIfDSkLfAs9wfyGjnmnkRPCK20m3rjVieyjw+FNA+h9xXC0iI7n1nq3sWuwlLx+c7fOHj+wv0hFBOFF8VqFavn6oyTKwzkBP5y1v0emTLe63RtwnB1q+U9Phs97kuT1cYT6bgKBgCfIi6VcBrm9IdAHlsc48C8CdpKs1jLpc3kLwXbtdXrigX4Nnv0UHkoky6iVIfsMTSjfZUnlaHSFCJEuxkVMRKUjKtREQs8RVI5tks64WcBn4nKBdzPDIpFiGP72FLzBYF2/vLAIIelnmlLvF6yoSJnW5YzjIFiDWev7zFyJKHs0Jz0JeTovTPYVOx4b5qkfPFPvDKTjCvzXOSHoYU4RBVax5Z5yc4GenilaQXxPnXfHc41lbbAi2RGQWO8PAQyK69i3NZtrTJ/6TVQDUmL1ojVHETRQkD2WD+A44YfZL2docc6bWjNLyyQI4j20S54Q7M2v92AH5XiBGGm5VfQsH0mqxk8tDHW7IwzrnSjQsVh3H1imEg1G1L2WKJYSqWVUUguUUzanXsVgImTwh4Lzs+YeDlXYkbxrvkjprtdAXQY6Q4/LFob+eTHlG9HsLgE9RlzLUOvyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(86362001)(64756008)(66946007)(66476007)(54906003)(91956017)(66556008)(66446008)(107886003)(8676002)(31696002)(508600001)(76116006)(316002)(122000001)(38100700002)(2616005)(4326008)(6512007)(6506007)(71200400001)(38070700005)(6486002)(8936002)(36756003)(2906002)(31686004)(5660300002)(7416002)(4744005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFgvL0JFRFJYM0tmMVYvVzNTM0xMYWFPRldPdTh6ekx6QWVMSHM1bnY2cG0z?=
 =?utf-8?B?Z2JWRDJvWkxsbVQ2eFZuSDhXQmtSZzNJMlM2eCtWQldEdk9kMElQb0tKSXY2?=
 =?utf-8?B?WXJqMlUxVFhCN0VNRjhVT1hqS1A4NGg1YlJ4aEVnbzU4TE5BMUNtNVk3K0NO?=
 =?utf-8?B?MWVwT29TSjRhMUZoSjBLQXdJVGt0RXd0NnVVWTUzVnRqV1ZXU1A0bjR0L0tq?=
 =?utf-8?B?RzlYVEk1VGx1a0orUldOelV3aHRZZUFKR2tvOGxwdzZEcGEwdFRBcDFZeXhI?=
 =?utf-8?B?U0lYWWpzMDRlT3NCOHhSamhELzJNNkVTdTdjOGJ5em5aUUVvUm5OSTdkam93?=
 =?utf-8?B?SWI0bk8wNnVXYnF4Qi9VRXFzUCtaTVlmcldKTVhUUlpYUzNYVTVDcWNVQVZS?=
 =?utf-8?B?czltRE10RzdLREFzSjdNcnpQY2xrY2pWMjk2RU9veGRWWGM0cEFkais1YVdB?=
 =?utf-8?B?eVFBcXhnbHBhOE9UNlpPbDB5ZFdhRTNNNTlDaXhoZ01GeThFQzFMYzVtYkgr?=
 =?utf-8?B?ODYxcmVSVURsRzF4c3RWdWlGVUJUSXFCSUJucWowTnByQnlxQnIrVytHU3Mr?=
 =?utf-8?B?WnJ4OTBuVHU2eXAyWXRFREozeXNoYkYrWU5EcTVocEtneTdyOTNkekJwb0ZJ?=
 =?utf-8?B?dCtYaXNqczIrOXk4Y3A0U2djZ2hkQkt0c29ZRi9qYVdiSUlLbG80NmY4NFhz?=
 =?utf-8?B?YU5ZdlQyNE4vVjBVeXBhTER1VW1GeE1rN0M4ZmJMNTJnNXhaMVlIRWhPMFZa?=
 =?utf-8?B?T1dmYTJ6WlRTUWhUZTByVE5IcEFtM2JUZWxJREF3V2dMc3FNNGFSditmdjZ0?=
 =?utf-8?B?bC9lR0hUQVRkbzBwbVRUcXQ0dTdoTG9vMzd0STg0VC9RNXVTT3BWU0p1VFVR?=
 =?utf-8?B?RlZ3eUNaVTlFVUxYQnRIUXB2TFN5eHU3ZThHOW5nQUJYWlVGMEVYa2xESHZD?=
 =?utf-8?B?c1VNaXFsNFYxYmk0c0Jaa05pdVBOV3JOSWNlZHFaWjYrNHN6TzZpcU1mbTdr?=
 =?utf-8?B?blZ2YzNZd2x4a3FvK0l5Yzl6SXZ5UjZ1cUxNYW8wcDBMejdBUVlGbUo5Q205?=
 =?utf-8?B?akRJOUVhOFdLRUVsZkFVcGQ4MWhUcDZjUzdFTWFsT3BWZG5TOTZtTDI0VmJ0?=
 =?utf-8?B?UmMzeXoxSDZBeFVEcXVpd0d5ZEM2cWdKRFBwM01ONDhLQUNWcGxYQnhVeGZj?=
 =?utf-8?B?alBCRmRDTVZORktMZXVkUmxqVWRTTVY5K1dVOUxCL3JubU1qRXpOQXd0K2lj?=
 =?utf-8?B?UjRoOE53NUlqT2tlSFBNa2l4T3dpUDVvT1lIM3lybXg2c1JSZDJNUmxTWnpm?=
 =?utf-8?B?VmdlWHd1VVVQL3lLbHhhTm9aeDN3Szc1aEUxSzZzdGcwUXNFM2Yvb0hOVkp0?=
 =?utf-8?B?eVpDQllPNGxJM1NvelVucWlFcE9XY2ZNdGJkUmdBTUY3VFZsMzNKU2xiTllX?=
 =?utf-8?B?ZnRJNmI5Nkw0RUpVbVl3UnoyWXQ5YWQvNWNLNzBhWXhzR0ZMQWJFNHRhT1Rl?=
 =?utf-8?B?am5qV3BzOHY0TzRvQmZoSkNiaXFGL2Vld2djRms0TkV2MWJLdkQ5T1R2Z09J?=
 =?utf-8?B?Y2FBeS9vRnY4ZE9vNDArdmd1eEZXbGRaNFVYTStNYVVGVVpkdjZmUlBqeDJC?=
 =?utf-8?B?U09FT3h6VkxKSmV3bU5qeVp2SWdwazRNaHdzRUVnSVpnelFjRzBkNjRqRzAx?=
 =?utf-8?B?enhlL3FpejZmUVZKQnJKR09qNUw0UFNJajdQWDRKSUZxa0tTVDBpVGl3WDNT?=
 =?utf-8?B?SlVmTithcTRxdmFXRGpHKzRMajBIYWh5aFp0eENmRVlsNjhwdDYzeUdRVXNz?=
 =?utf-8?B?Yk1UUm9SN2dWS0luOXpyUnd1TXYydnEzYnhYeFF6YmNYelBheGxZb0hQSU1X?=
 =?utf-8?B?TlZlckJ4Qjh5QUxSSzdWeDVhbXRsK3pEWGk5WnpSTWZUeCsvQkZRZDhGWUNT?=
 =?utf-8?B?THZuenh5UlM2RHNJWHJCNndFS3FVTFlpdmR3Y21QdEUxeitFQXlBM3RzbWo2?=
 =?utf-8?B?VlFhdEhkcEVMVFVMdjdXRVlyYmt0QU03QlBpRG12Q1NsSGdLVVR6WXFhYjlV?=
 =?utf-8?B?cUhJODI0UXNaMUZqZ1FPb2h1VHJENG9IYU1GZmRxUzF0RTU0bmRSYk1zVFBG?=
 =?utf-8?B?cVNtUWRSeUNtZ1VCQnAwS213MXpVMlhxUEYyQTljRmI4YWhtWlJtdEtBNXhz?=
 =?utf-8?B?ZE8vWGdZS0JSZGhtRDV5R2NrV0wxa29LNEJ4WllvaGhnUjdia2s1TUN1S0Qz?=
 =?utf-8?B?RS9kNzJRVDgvd2NJdjh3NjRFOWxPUVhKcnQ2T3ZWcWJRZVJ5clZHcGt6bWZY?=
 =?utf-8?B?UjM5ZC84aGNpRE5VWVBnMEFhbmFSSFJvNi9MNkp6VW9YR0NpRldzL3dUTW84?=
 =?utf-8?Q?okawv43p+GLJE1fM/sm0cXlC33IHJxvcAs7bfc4UwrDw9?=
x-ms-exchange-antispam-messagedata-1: n/XnQFYT/6zX4w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A43DE600A7FB34A84C3961EA6F9846E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6afaa8-14a7-4768-c4bb-08da1c15a6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 23:47:34.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Nra+l105tKoY+I5Mib9/DrWwKb8RAIi5m9lmszxWOzmx1cJHjaZ1Sesi0T71TM3WEYvuJD3W/1IoFUh4i6m8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1351
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IA0KPiBIaSBDaGFpdGFueWEsDQo+IA0KPiBTdXJlLiBJIHdpbGwgZG8uDQo+IERvIEkgbmVl
ZCB0byBhZGQgYSBuZXcgdGVzdCBzY3JpcHQgYWJvdXQgdmROIGRldmljZSBJTyBwb2xsaW5nDQo+
IHRvIGJsa3Rlc3RzL3Rlc3RzL2Jsb2NrLz8NCj4gDQoNClRoYXQgd2lsbCBjcmVhdGUgY29uZnVz
aW9uIGFzIGJsb2NrIGNhdGVnb3J5IHRlc3RjYXNlcyBhcmUgZGlmZmVyZW50IA0KdGhhbiB2aXJ0
aW8tYmxrLiBTbyB5b3UgbmVlZCB0byBjcmVhdGUgYSBuZXcgY2F0ZWdvcnkgdmlydGlvLWJsayBh
bmQNCmFkZCB0ZXN0Y2FzZXMgdG8gdGhhdCBvbmUuDQoNCi1jaw0KDQoNCj4gUmVnYXJkcywNCj4g
U3V3YW4gS2ltDQo+IA0KDQo=
