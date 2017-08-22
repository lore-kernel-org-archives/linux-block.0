Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4792 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdHVTv0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 15:51:26 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 04/20] blk-mq-sched: move actual dispatching into one
 helper
Date: Tue, 22 Aug 2017 19:50:38 +0000
Message-ID: <1503431435.2508.11.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-5-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gU28g
dGhhdCBpdCBiZWNvbWVzIGVhc3kgdG8gc3VwcG9ydCB0byBkaXNwYXRjaCBmcm9tDQo+IHN3IHF1
ZXVlIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2guDQoNClJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3Nj
aGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg==
