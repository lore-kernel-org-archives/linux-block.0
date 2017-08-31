Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2522 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdHaVWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 17:22:23 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] <linux/uaccess.h>: Fix copy_in_user() declaration
Date: Thu, 31 Aug 2017 21:21:37 +0000
Message-ID: <1504214495.31872.59.camel@wdc.com>
References: <20170823222911.29453-1-bart.vanassche@wdc.com>
         <20170823222911.29453-2-bart.vanassche@wdc.com>
In-Reply-To: <20170823222911.29453-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTIzIGF0IDE1OjI5IC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IGNvcHlfaW5fdXNlcigpIGNvcGllcyBkYXRhIGZyb20gdXNlci1zcGFjZSBhZGRyZXNzIEBm
cm9tIHRvIHVzZXItDQo+IHNwYWNlIGFkZHJlc3MgQHRvLiBIZW5jZSBkZWNsYXJlIGJvdGggQGZy
b20gYW5kIEB0byBhcyB1c2VyLXNwYWNlDQo+IHBvaW50ZXJzLg0KPiBbIC4uLiBdDQoNCkhpIEFs
LA0KDQpDYW4geW91IGhhdmUgYSBsb29rIGF0IHRoaXMgcGF0Y2g/IFBhdGNoIDIvMiBmcm9tIHRo
aXMgc2VyaWVzIGFscmVhZHkgZ290DQpxdWV1ZWQgZm9yIGtlcm5lbCB2NC4xNCBieSBKZW5zLg0K
DQpUaGFua3MsDQoNCkJhcnQu
