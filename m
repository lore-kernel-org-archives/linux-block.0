Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6564FC6FD20
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 05:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCHFjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 00:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCHFjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 00:39:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0907960A3
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 21:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrNY06lMp9cA9UoBxK523DpJfuwTi3/z23rlf6Vom8SlYaDF+sY/hxmo5k32qtyqGkuGom8HoW5/+rJhSged3IhMH6cchNzfG4DeIbQHjuBKhlHTbB68ddrkeryVIgtJYjo71BslkVrhHvPfpSE7LQ5WUAnm1ZGe9XWr/gDSevObs+BvC/zbzy86DDB4S8LD4/L63pgMPsJJ4wGT1AkKZX7gHaU9LVi2zaF6ehuJbciHghki/lYxUIHSKFEZB2xKyJd8E44G/Yy40TokqIvRuzp7NOMRw0w7kszXZssgFS/4dsFbwqFsq3HDESut4sMMaZkRdPFjmY0lHlxyEMBAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+etDeZK3Hgy8E8tOqGZiJoCxx5STD2+qXxuY6jNBaDA=;
 b=PZfAZW7bN5lzJu0qsVy+3Eb3sV6pSeFFYSuIaOTvEUY+MnEwGeQ656ws9r4IId3sCQDoUOnrMzx62pVVyUDbuXyTO7weKFDhlnw2QkOMKbsxozOVlxspv7Ulsxc2y2pLHOydiUOwPF90azMRKe+Su/rZk8O75mpKzQDe66fZWlTnPC6Pau6oAibVZFryxxoYDgxAep8ZKhXIOzTVvW93HC6dYqTix3LybYuEyjImlntt+co4QhLbc3itUWM3uvJOmoSifADlqTBcZmG/8mmZFMtOXMaVDPDgHf9aSwG0Hf28cq8M7kUmY5yFMUwuN5w+ljQkZbocNzVtF7B1YpxTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+etDeZK3Hgy8E8tOqGZiJoCxx5STD2+qXxuY6jNBaDA=;
 b=BMIAzWkRP5ETVYOEEK0l4/3wyW9rPCKhrXCDN6Ex7s/3CSOnnKcjmyQiBDtRdRm2Tme2u2g4ZKsvhdUxCp6o+m3qpu2yB4BQW9n9j0if3Cach7NfcHBWg6X7VNrCeiQtosKu0J3s0TBZrqPO06NwEfx1uxatwDci799J/jodXzO981lTL5UrtXIgiLhGeACQjQQwo1xtey59QsxbVDx2ZfqBNEWrj+c7K8RkdJLnrIrJvNbpp3R4h3g2jV4t0QHdmIWRack3fPPpeBfi9GS3aXEsPe04CiRfLsbe+p+PMMhLyE3xSsNz1acwfEiFERskJjrrm4vBa5d8yOGz+D+OdA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 05:38:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 05:38:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: fix handling single range discard request
Thread-Topic: [PATCH] nvme: fix handling single range discard request
Thread-Index: AQHZTiX2EW8aeGjaO0qLT1SlqfD6u67wZEIA
Date:   Wed, 8 Mar 2023 05:38:58 +0000
Message-ID: <2035a3cb-7cec-e461-d36f-140ab751c04f@nvidia.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
In-Reply-To: <20230303231345.119652-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: 873089b2-a1ec-4afc-0c96-08db1f9769ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtg7dQJ5eZDc84PVF05giqswmYSVKyskDBR1CSFqwAsEyh1sIvtwq+T2flQy6jVUMS7Nf+FQ12wlTsrPv2GiapFgXYbk1XVUMFS4H6lbG5DAmFrs/RmONd99cxaT8PCLNVoJckbH9kA18GZnk36BQhaSbiVe7oCniDPIqE3HlOmvgtHSnLksL2WXn1IOZddFSgxTwP5vyF/SbzjnJlK/3BSS7t+DBhMm4lJncYpVQ8YXeGtwk0dZY67UW1FEpze8YJ1G99MwtWbGSdZhg0+mm4SyWSCGnYbFyKgqa7sDqgepMr/lLTyGHUSeDSu4JWd9asoW4eP3RfZNpRlHHayEIen5U3kEGOxCU7SDNZRndglb9AZSxWLViV41fH+/iZOX0RhrUggA5YRr1cjc7eqI2+jjvQXN9fhToUb9m9YnwQhk6bLVBUW5eNYww7nc2vOVB+UKI/HQ9QeZ30iD8kl5UqNjSdoaJdxmOOi/QQr6AxncrrLpB6w0tKZ9VJcxdarDVWgFenRovoD50W8GdADg20g4wJtKahHNMEryLiBUWk67FaBuBSh6GOQvm4Up9s3MVsjBXjMcPW4pHv/eMuFne0sXqvSLNXbc+w96R4yQAbqAbT6CcTOE4pHFwglGBCImgH7AJUyJtdpkcMD89W/wzFBEJsVR7fI/EGNVobUIVuo+IosmTzSiOYyycMjr8zqXANsFGoX7h1iKelPfvlI8FJSYp2iX3GoGOPEekrXjf0aRz9TTa+osCp7WgSIxjTM+h79fi+d3hV7X9eRB0uv5VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(31686004)(36756003)(66946007)(8676002)(5660300002)(41300700001)(6916009)(66556008)(64756008)(4326008)(66446008)(8936002)(66476007)(4744005)(38070700005)(76116006)(86362001)(122000001)(31696002)(38100700002)(2906002)(6486002)(71200400001)(478600001)(54906003)(91956017)(316002)(6506007)(83380400001)(6512007)(186003)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGVkbXBDcW9OK0huR0d4R1JVTytDUTYxSVJrVDVoNzZWcUtmb05nTTl4N1pJ?=
 =?utf-8?B?SHE5amdGL0pzV3VwN2Jpb3Vic284dmEzREw4em9rWUl1SU1JaXpBUFZVSnQw?=
 =?utf-8?B?MjBNVXZrdFVHZ1duNU5mZExid3RmYkEvbWdGTTcwQkZaTU0vZFJZQVhYYVVI?=
 =?utf-8?B?ZnVmeWZ4ek5GKzZkSVZ0SHJQYmZDSmtWcDB3ZGlSd0p1QmpQS2toZ3VpeUR0?=
 =?utf-8?B?Q1VvMTFNcVhhdDc2cGM0dXBIVFRWVUNGcEgvbU94dWIweXNvZjZ0dHd4K2Zs?=
 =?utf-8?B?MGpUNllmQnd5UDN4b2s3SkRvWk1BWUg2ZmN2dTlVUjN5SzRwdXVpek95WTAv?=
 =?utf-8?B?dXUzREtqZHEyb2dCMUhiNXEzNmxiSGhFdGRQUEppNkFtRXFYS2tOamlCcGFM?=
 =?utf-8?B?eVNRb21xWml1Wng3aHFSRGdSV0U5M0xDelBsNnc2aHNpdG1jVGdST0UrQzQ1?=
 =?utf-8?B?aVFUSWF4Ui8rN0w0d2ZUdysxZlJET0ozSG5BcEIvNStJWUxHUjlaZFR0aEo3?=
 =?utf-8?B?MzJCQ01rbEhaR3p5TTlWV0FEQXpJOGJxS014eUdnL1lRYTFrYithTG42QlNE?=
 =?utf-8?B?clR2VWNSYnhMdTBsWFZxL29aT041ZlNUQmxEZVMwUW5KUGV2YnRtSU1wSEZy?=
 =?utf-8?B?aTlxcFlDWjd3aDdxZStsZUM2TDNBYVRocWlVUG8zVEZtZXhLMitwQnZzODBt?=
 =?utf-8?B?d2RSeG5HMUsrdVQwVGxqL1k4NWNDTDIzWFN5SGhZNGdOcWpBdVJmMGR2ZkZW?=
 =?utf-8?B?QnF4Q3JxOVFDODVCSGFzQ2RqUyszSTVYb3VobkdHR1BhWFp2ZUtGTEdpci9G?=
 =?utf-8?B?SC9DQk9Rb0VZK1JwYzFoVjdNWTY3YXRYK1E0dUdYVHFzSDFmYlhVTk9qa0ha?=
 =?utf-8?B?cDZJTldjQ1pCaDl4dDJKN29nRURWdDUxblY4cVd3TklhRWZOd3dWWkt6NXBF?=
 =?utf-8?B?QVkzdjRnL1Y1b1VTWlVZV3RmQ1BETjdkWjR2VE5CWjRkRTUvVlNhSmZoeUEy?=
 =?utf-8?B?OGI5SHY4V0N1SnJQcm11V0ZTWEFjYlN1Umh0cXNMOGtycG4yYW5oaVZYOW56?=
 =?utf-8?B?Qy9Na2tYS1A3UW9CZEl5RWZPZHhyOWlPWmI5WWpoajJHckoraXRQUGYzL1Nz?=
 =?utf-8?B?a2dhaDRBTTBVY0liMnNQZ21kQ0owaVRnZjJza1pvWksxMmR2QWNCOW41UDZR?=
 =?utf-8?B?OWN0V1ArUXoxOU9XMllMdFZSYXhjc1ZEdmRtNmF5VlJWZmZyRENnZFBFOXZm?=
 =?utf-8?B?Q09qUG5tY0ZsTC92WFNqTDZZRzA0WmUxd203eHFucDhQVjZLV0lmN3VROWJz?=
 =?utf-8?B?Z2JkcENvRkRXZjBiMDIwVno3RTQ4eFlXSk16MGpZRTNGMGZqazFGMW1pdUcr?=
 =?utf-8?B?aFd5VVlSR0lyendUYnorZjNORjk0NklqQmxiWWJOVVV1YS9sMjMxZG9aamtR?=
 =?utf-8?B?M0l1ZElpRWlTU2hxT3RiYkJ6QTZVVHNFbGNTRE55ZnY1enQvck5iMzQ5Ymtq?=
 =?utf-8?B?ZWpHSFc5bW1PQ2E5SG9pdW9uM1lqZWlPdXVBRDdCWVVTeGFBM1VLWXBEUDJo?=
 =?utf-8?B?SzYyRERLUDhwWjdZYUNoeFhGYTJrVExoMG4xU01lQWF2cVlseWN0VGN6K2tl?=
 =?utf-8?B?dXM4MEl0SzBnSFUvcC9UUmFla1JtYzI0REkzbG5KQWN0cHYzazZJNzh2K1g3?=
 =?utf-8?B?VklIWHNITUFRWXpSK0FGVXljS2xpY3BtbFBKL3hIRXJ2alZldmxLODlGNWtZ?=
 =?utf-8?B?VzR4VU8xcVo4YnpoSWxncUo1d3BjWFZBaHpkZXJNRDl0S3NXUHhEOU15Qk10?=
 =?utf-8?B?VkRPbEdMWHJlb2RWNGpCQThjbVY3OEVBOWh3OUNlaE1zNmpNZEgreWlFcTVm?=
 =?utf-8?B?eHdaSzk5ZUh4YUZSbmRuYnlmck02Z1ZkSVprS3lzN1dOK0s0eElBQmVjcDM3?=
 =?utf-8?B?VFFVZWovWmRscEc0bjJpSUdtamRkaThQS0lBZ0pVUGJ1RFJncVdYT3YzVUNu?=
 =?utf-8?B?OW1TbWVTb3BoZ005TWFXQmNHQ0N0d1poRUUrVEJiTTdRT2dBWTNUM2lDRnM3?=
 =?utf-8?B?OUtQb1kwb1U4U2ZYRE94cVhtWFFURG5za3ZlM3NyeFQ5cVJJcmZLcENCdk1v?=
 =?utf-8?B?aXBWcmtEbmxXNy9oekhmM0huTzhsKzZYUFlqY2hZRXg1aVdsVE5NbEFYNGln?=
 =?utf-8?Q?46IH4fny91kLhjk9TbXPkZEC94PztOeDO1zSMK9ATYa0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58DEBB7B53081F4F9E9179EAF5A8CB55@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873089b2-a1ec-4afc-0c96-08db1f9769ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 05:38:58.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKoX8spBLR6JvcMAqqNiqJb3DM6vM8ywROUbpfColVT5RaZ3EP8SDw0zOHcjK+567HxbOcXQKnXrukbLbHP9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8zLzIwMjMgMzoxMyBQTSwgTWluZyBMZWkgd3JvdGU6DQo+IFdoZW4gaW52ZXN0aWdhdGlu
ZyBvbmUgY3VzdG9tZXIgcmVwb3J0IG9uIHdhcm5pbmcgaW4gbnZtZV9zZXR1cF9kaXNjYXJkLA0K
PiB3ZSBvYnNlcnZlZCB0aGUgY29udHJvbGxlcihudm1lL3RjcCkgYWN0dWFsbHkgZXhwb3Nlcw0K
PiBxdWV1ZV9tYXhfZGlzY2FyZF9zZWdtZW50cyhyZXEtPnEpID09IDEuDQo+IA0KPiBPYnZpb3Vz
bHkgdGhlIGN1cnJlbnQgY29kZSBjYW4ndCBoYW5kbGUgdGhpcyBzaXR1YXRpb24sIHNpbmNlIGNv
bnRpZ3VpdHkNCj4gbWVyZ2UgbGlrZSBub3JtYWwgUlcgcmVxdWVzdCBpcyB0YWtlbi4NCj4gDQo+
IEZpeCB0aGUgaXNzdWUgYnkgYnVpbGRpbmcgcmFuZ2UgZnJvbSByZXF1ZXN0IHNlY3Rvci9ucl9z
ZWN0b3JzIGRpcmVjdGx5Lg0KPiANCj4gRml4ZXM6IGIzNWJhMDFlYTY5NyAoIm52bWU6IHN1cHBv
cnQgcmFuZ2VkIGRpc2NhcmQgcmVxdWVzdHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIExlaSA8
bWluZy5sZWlAcmVkaGF0LmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
