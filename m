Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51955 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbcEJTtM (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 15:49:12 -0400
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "hch@infradead.org" <hch@infradead.org>,
	"axboe@fb.com" <axboe@fb.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"xfs@oss.sgi.com" <xfs@oss.sgi.com>,
	"linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
	"jmoyer@redhat.com" <jmoyer@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"boaz@plexistor.com" <boaz@plexistor.com>,
	"david@fromorbit.com" <david@fromorbit.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH v6 4/5] dax: for truncate/hole-punch, do zeroing through
 the driver if possible
Date: Tue, 10 May 2016 19:49:01 +0000
Message-ID: <1462909729.29294.21.camel@intel.com>
References: <1462906156-22303-1-git-send-email-vishal.l.verma@intel.com>
	 <1462906156-22303-5-git-send-email-vishal.l.verma@intel.com>
	 <20160510192507.GA29312@infradead.org>
In-Reply-To: <20160510192507.GA29312@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE2LTA1LTEwIGF0IDEyOjI1IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gSGkgVmlzaGFsLA0KPiANCj4gY2FuIHlvdSBhbHNvIHBpY2sgdXAgdGhlIG15IHBhdGNo
IHRvIGFkZCBhIGxvdy1sZXZlbCBfX2RheF96ZXJvX3JhbmdlDQo+IHRoYXQgSSBjY2VkIHlvdSBv
bj/CoMKgVGhhdCB3YXkgd2UgY2FuIGF2b2lkIGEgbmFzdHkgbWVyZ2UgY29uZmxpY3Qgd2l0aA0K
PiBteSB4ZnMvaW9tYXAgY2hhbmdlcy4NCg0KR29vZCBpZGVhIC0gSSdsbCBkbyB0aGF0IGZvciB0
aGUgbmV4dCBwb3N0aW5nLiBJJ2xsIHdhaXQgYSBkYXkgb3IgdHdvDQpmb3IgYW55IGFkZGl0aW9u
YWwgcmV2aWV3cy9hY2tzLg0KDQpJJ20gbG9va2luZyB0byBnZXQgYWxsIHRoaXMgaW50byBhIGJy
YW5jaCBpbiB0aGUgbnZkaW1tIHRyZWUgb25jZSBKYW4NCnNwbGl0cyB1cCBoaXMgZGF4LWxvY2tp
bmcgc2VyaWVzLi4NCg0KTW9zdGx5IEkgZ3Vlc3MgSSdtIGxvb2tpbmcgZm9yIGEgeWF5IG9yIG5h
eSBmb3IgdGhlIGJsb2NrIGxheWVyIGNoYW5nZXMNCihwYXRjaCAyKS4gSmVucz8=
