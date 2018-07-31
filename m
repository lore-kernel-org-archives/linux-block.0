Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:34274 "EHLO ustc.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731912AbeGaNTM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jul 2018 09:19:12 -0400
Date: Tue, 31 Jul 2018 19:32:05 +0800 (GMT+08:00)
From: "LIN Fushou" <fshlin@mail.ustc.edu.cn>
To: linux-block@vger.kernel.org
Subject: Some questions about bache bset tree
Content-Type: multipart/alternative;
        boundary="----=_Part_102958_2002754762.1533036725001"
MIME-Version: 1.0
Message-ID: <4b181c95.7519.164f01c0310.Coremail.fshlin@mail.ustc.edu.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

------=_Part_102958_2002754762.1533036725001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RGVhciBhbGwgbGludXgtYmxvY2sgZGV2ZWxvcGVycywKCgpSZWNlbnRseSwgSSdtIHZlcnkgaW50
ZXJlc3RlZCBpbiB0aGUgcHJpbmNpcGxlIG9mIGxpbnV4IGJjYWNoZShkcml2ZXJzXG1kXGJjYWNo
ZSkgYnNldCB0cmVlLCBidXQgaXQncyBoYXJkIHRvIHVuZGVyc3RhbmQuIEkgaGF2ZSB0d28gcXVl
c3Rpb25zLgoxLiBXaGF0IGRvIHRoZSBleHBvbmVudCBhbmQgbWFudGlzc2EgaW4gYmtleV9iZmxv
YXQgc3RydWN0dXJlIG1lYW5pbmcsIGFuZCBob3cgdG8gdW5kZXJzdGFuZCB0aGUgcHJvY2VzcyBv
ZiBtYW50aXNzYSdzIGNvbXB1dGF0aW9uIGJmbG9hdF9tYW50aXNzYS4KMi4gTWF5YmUgSSBkb24n
dCB1bmRlcnN0YW5kIGJrZXlfYmZsb2F0J3MgY29uc3RydWN0aW9uLCBzbyBJIGNhbid0IHVuZGVy
c3RhbmQgdGhlIGZ1bmN0aW9uIGJzZXRfc2VhcmNoX3RyZWUuIEhvdyB0byB1bmRlcnN0YW5kIGJz
ZXRfc2VhcmNoX3RyZWUgZnVuY3Rpb24uCkNhbiBzb21lb25lIGhlbHAgbWU/IExvb2tpbmcgZm9y
d2FyZCB0byB5b3VyIHJlcGx5LiBUaGFua3MhCgoKLS0tCkZ1c2hvdSBMaW4=
------=_Part_102958_2002754762.1533036725001
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdj5EZWFyIGFsbCBsaW51eC1ibG9jayBkZXZlbG9wZXJzLDwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+UmVjZW50bHksIEknbSB2ZXJ5IGludGVyZXN0ZWQgaW4gdGhlIHByaW5jaXBsZSBvZiBs
aW51eCBiY2FjaGUoZHJpdmVyc1xtZFxiY2FjaGUpIGJzZXQgdHJlZSwgYnV0IGl0J3MgaGFyZCB0
byB1bmRlcnN0YW5kLiBJIGhhdmUgdHdvIHF1ZXN0aW9ucy48L2Rpdj48ZGl2PjEuIFdoYXQgZG8g
dGhlIGV4cG9uZW50IGFuZCBtYW50aXNzYSBpbiBia2V5X2JmbG9hdCBzdHJ1Y3R1cmUgbWVhbmlu
ZywgYW5kIGhvdyB0byB1bmRlcnN0YW5kIHRoZSBwcm9jZXNzIG9mIG1hbnRpc3NhJ3MgY29tcHV0
YXRpb24gYmZsb2F0X21hbnRpc3NhLjwvZGl2PjxkaXY+Mi4gTWF5YmUgSSBkb24ndCB1bmRlcnN0
YW5kIGJrZXlfYmZsb2F0J3MgY29uc3RydWN0aW9uLCBzbyBJIGNhbid0IHVuZGVyc3RhbmQgdGhl
IGZ1bmN0aW9uIGJzZXRfc2VhcmNoX3RyZWUuIEhvdyB0byB1bmRlcnN0YW5kJm5ic3A7PHNwYW4g
c3R5bGU9ImxpbmUtaGVpZ2h0OiAxNi44cHg7Ij5ic2V0X3NlYXJjaF90cmVlIGZ1bmN0aW9uLjwv
c3Bhbj48L2Rpdj48ZGl2PkNhbiBzb21lb25lIGhlbHAgbWU/IExvb2tpbmcgZm9yd2FyZCB0byB5
b3VyIHJlcGx5LiBUaGFua3MhPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4tLS08L2Rpdj48ZGl2
PkZ1c2hvdSBMaW48L2Rpdj4=
------=_Part_102958_2002754762.1533036725001--
