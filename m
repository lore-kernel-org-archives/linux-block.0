Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9551 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeJ3Iti (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 04:49:38 -0400
From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Steve Wise <swise@opengridcomputing.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "'Max Gurtovoy'" <maxg@mellanox.com>
Subject: RE: [PATCH v2] block: fix rdma queue mapping
Date: Mon, 29 Oct 2018 23:58:31 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A2FFFC0B@fmsmsx116.amr.corp.intel.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <20181017163720.GA23798@lst.de>
 <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
 <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com>
 <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
 <20181024000923.GA17352@ssaleem-MOBL4.amr.corp.intel.com>
 <60315f82-ebc1-838d-4757-c27b9bb650ff@grimberg.me>
In-Reply-To: <60315f82-ebc1-838d-4757-c27b9bb650ff@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGJsb2NrOiBmaXggcmRtYSBxdWV1ZSBtYXBwaW5nDQo+
DQo+DQo+PiBTYWdpIC0gRnJvbSB3aGF0IEkgY2FuIHRlbGwsIGk0MGl3IGlzIGFsc28gZXhwb3Nl
ZCB0byB0aGlzIHNhbWUgaXNzdWUNCj4+IGlmIHRoZSBJUlEgYWZmaW5pdHkgaXMgY29uZmlndXJl
ZCBieSB1c2VyLg0KPg0KPm1hbmFnZWQgYWZmaW5pdHkgZG9lcyBub3QgYWxsb3cgc2V0dGluZyBz
bXBfYWZmaW5pdHkgZnJvbSB1c2Vyc3BhY2UuDQoNCk9LLiBCdXQgb3VyIGRldmljZSBJUlFzIGFy
ZSBub3Qgc2V0LXVwIGFzIHRvIGJlIG1hbmFnZWQgYWZmaW5pdHkgYmFzZWQgYW5kIGNhbiBiZSB0
dW5lZCBieSB1c2VyLg0KQW5kIGl0IHNlZW1zIHRoYXQgaXMgcmVhc29uYWJsZSBhcHByb2FjaCBz
aW5jZSB3ZSBjYW4gbmV2ZXIgdGVsbCBhaGVhZCBvZiB0aW1lIHdoYXQgbWlnaHQgYmUgYW4gb3B0
aW1hbCBjb25maWcuIGZvciBhIHBhcnRpY3VsYXIgd29ya2xvYWQuDQoNClNoaXJheg0K
