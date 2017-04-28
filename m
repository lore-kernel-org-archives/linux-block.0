Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50379 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1165737AbdD1Pah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:30:37 -0400
From: Josef Bacik <jbacik@fb.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: nbd: fix double free
Date: Fri, 28 Apr 2017 15:29:06 +0000
Message-ID: <91DBEBD8-44DF-4346-B51A-214A04689C7C@fb.com>
References: <20170428042942.6567-1-ming.lei@redhat.com>
 <B95137F4-8B73-47EA-9DB6-BF008F59B2AD@fb.com>
 <20170428152739.GC25592@ming.t460p>
In-Reply-To: <20170428152739.GC25592@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

WWVhaCBJIGZvdW5kIGFuZCBmaXhlZCBpdCBhbHJlYWR5LCB0aGFua3MsDQoNCkpvc2VmDQoNCk9u
IDQvMjgvMTcsIDExOjI3IEFNLCAiTWluZyBMZWkiIDxtaW5nLmxlaUByZWRoYXQuY29tPiB3cm90
ZToNCg0KT24gRnJpLCBBcHIgMjgsIDIwMTcgYXQgMDE6MDA6MzBQTSArMDAwMCwgSm9zZWYgQmFj
aWsgd3JvdGU6DQo+IFdlIHNob3VsZCBoYXZlIDIgcmVmZXJlbmNlcyBvbiB0aGUgZGV2aWNlIGF0
IHRoaXMgcG9pbnQsIGRpZCB5b3Ugc2VlIGEg4oCcbmJkOiBwb3NzaWJseSBsZWFraW5nIGEgZGV2
aWNl4oCdIG1lc3NhZ2UgYmVmb3JlIHRoZSBrYXNhbiBzdHVmZj8gIFRoYW5rcywNCj4gDQoNClRo
ZXJlIGlzbid0IHN1Y2ggbWVzc2FnZSBiZWZvcmUga2FzYW4gd2FybmluZy4NCg0KVGhhbmtzLA0K
TWluZw0KDQoNCg==
