Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43725 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdIOVHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 17:07:39 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 5/5] dm-mpath: improve I/O schedule
Date: Fri, 15 Sep 2017 21:06:50 +0000
Message-ID: <1505509609.2417.20.camel@wdc.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
         <20170915164456.9803-6-ming.lei@redhat.com>
In-Reply-To: <20170915164456.9803-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA5LTE2IGF0IDAwOjQ0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gMSkg
bHBmYy5scGZjX2x1bl9xdWV1ZV9kZXB0aD0zLCBzbyB0aGF0IGl0IGlzIHNhbWUgd2l0aCAuY21k
X3Blcl9sdW4NCg0KTm9ib2R5IEkga25vdyB1c2VzIHN1Y2ggYSBsb3cgcXVldWUgZGVwdGggZm9y
IHRoZSBscGZjIGRyaXZlci4gUGxlYXNlIGFsc28NCmluY2x1ZGUgcGVyZm9ybWFuY2UgcmVzdWx0
cyBmb3IgYSBtb3JlIHJlYWxpc3RpYyBxdWV1ZSBkZXB0aC4NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
