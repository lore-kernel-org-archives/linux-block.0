Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbeKHFhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Nov 2018 00:37:06 -0500
From: Jens Axboe <axboe@fb.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
CC: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: respect virtual boundary mask in bvecs
Date: Wed, 7 Nov 2018 20:04:58 +0000
Message-ID: <b557400b-4ef9-481f-ac0b-b80545e84a2f@fb.com>
References: <20181107135814.15727-1-jthumshirn@suse.de>
In-Reply-To: <20181107135814.15727-1-jthumshirn@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gMTEvNy8xOCA2OjU4IEFNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IFdpdGggZHJp
dmVycyB0aGF0IGFyZSBzZXR0dGluZyBhIHZpcnR1YWwgYm91bmRhcnkgY29uc3RyYWluLCB3ZSBh
cmUNCj4gc2VlaW5nIGEgbG90IG9mIGJpbyBzcGxpdHRpbmcgYW5kIHNtYWxsZXIgSS9PcyBiZWlu
ZyBzdWJtaXR0ZWQgdG8gdGhlDQo+IGRyaXZlci4NCj4gDQo+IFRoaXMgaGFwcGVucyBiZWNhdXNl
IHRoZSBiaW8gZ2FwIGRldGVjdGlvbiBjb2RlIGRvZXMgbm90IGFjY291bnQgY2FzZXMNCj4gd2hl
cmUgUEFHRV9TSVpFIC0gMSBpcyBiaWdnZXIgdGhhbiBxdWV1ZV92aXJ0X2JvdW5kYXJ5KCkgYW5k
IHRodXMgd2lsbA0KPiBzcGxpdCB0aGUgYmlvIHVubmVjZXNzYXJpbHkuDQoNClRoYW5rcywgYXBw
bGllZC4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
