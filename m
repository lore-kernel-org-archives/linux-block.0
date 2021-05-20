Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54843C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37044608FE
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhETOPq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 10:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239729AbhETOOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 10:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621520000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vkKoZ+CKUsYvNnISKHeZZWH2ryJwgpmqIR8PS+x2z3k=;
        b=WlLpepYbQzrQOOq6ZqkrJRJVH/S2WphTPDvcqaUmbqHpvkrE1TKORfJHVnVDwU5g06U04U
        pQsGx++DMdwH5MoJT6SZkOsiSXD+OZJalSrJZf5dz0f6TnOQQi89raO2zbW05LOflsVSGm
        vlJkN+8EPIDe9weGDDfmcQYe+zjBaZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-iepZhC42MJ6ZH5r6tVwZig-1; Thu, 20 May 2021 10:13:19 -0400
X-MC-Unique: iepZhC42MJ6ZH5r6tVwZig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4AB4180FD61;
        Thu, 20 May 2021 14:13:17 +0000 (UTC)
Received: from localhost (ovpn-115-223.ams2.redhat.com [10.36.115.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96EC51001B2C;
        Thu, 20 May 2021 14:13:06 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/3] virtio_blk: blk-mq io_poll support
Date:   Thu, 20 May 2021 15:13:02 +0100
Message-Id: <20210520141305.355961-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyBibGtfbXFfb3BzLT5wb2xsKCkgc28gUkVRX0hJ
UFJJIHJlcXVlc3RzIGNhbiBiZQ0KcG9sbGVkLiBJT1BTIGZvciA0ayBhbmQgMTZrIGJsb2NrIHNp
emVzIGluY3JlYXNlcyBieSA1LTE4JSBvbiBhIHZpcnRpby1ibGsNCmRldmljZSB3aXRoIDQgdmly
dHF1ZXVlcyBiYWNrZWQgYnkgYW4gTlZNZSBkcml2ZS4NCg0KLSBCZW5jaG1hcms6IGZpbyBpb2Vu
Z2luZT1wdnN5bmMyIG51bWpvYnM9NCBkaXJlY3Q9MQ0KLSBHdWVzdDogNCB2Q1BVcyB3aXRoIG9u
ZSB2aXJ0aW8tYmxrIGRldmljZSAoNCB2aXJ0cXVldWVzKQ0KLSBEaXNrOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBOVk1lIERhdGFjZW50ZXIgU1NEIFtPcHRhbmVdIFs4MDg2OjI3MDFdDQotIENQVTogSW50
ZWwoUikgWGVvbihSKSBTaWx2ZXIgNDIxNCBDUFUgQCAyLjIwR0h6DQoNCnJ3ICAgICAgICAgIGJz
IGhpcHJpPTAgaGlwcmk9MQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpyYW5kcmVh
ZCAgICA0ayAxNDksNDI2IDE3MCw3NjMgKzE0JQ0KcmFuZHJlYWQgICAxNmsgMTE4LDkzOSAxMzQs
MjY5ICsxMiUNCnJhbmRyZWFkICAgNjRrICAzNCw4ODYgIDM0LDkwNiAgIDAlDQpyYW5kcmVhZCAg
MTI4ayAgMTcsNjU1ICAxNyw2NjcgICAwJQ0KcmFuZHdyaXRlICAgNGsgMTM4LDU3OCAxNjMsNjAw
ICsxOCUNCnJhbmR3cml0ZSAgMTZrIDEwMiwwODkgMTIwLDk1MCArMTglDQpyYW5kd3JpdGUgIDY0
ayAgMzIsMzY0ICAzMiw1NjEgICAwJQ0KcmFuZHdyaXRlIDEyOGsgIDE2LDE1NCAgMTYsMjM3ICAg
MCUNCnJlYWQgICAgICAgIDRrIDE0NiwwMzIgMTcwLDYyMCArMTYlDQpyZWFkICAgICAgIDE2ayAx
MTcsMDk3IDEzMCw0MzcgKzExJQ0KcmVhZCAgICAgICA2NGsgIDM0LDgzNCAgMzUsMDM3ICAgMCUN
CnJlYWQgICAgICAxMjhrICAxNyw2ODAgIDE3LDY1OCAgIDAlDQp3cml0ZSAgICAgICA0ayAxMzQs
NTYyIDE1MSw0MjIgKzEyJQ0Kd3JpdGUgICAgICAxNmsgMTAxLDc5NiAxMDcsNjA2ICArNSUNCndy
aXRlICAgICAgNjRrICAzMiwzNjQgIDMyLDU5NCAgIDAlDQp3cml0ZSAgICAgMTI4ayAgMTYsMjU5
ICAxNiwyNjUgICAwJQ0KDQpMYXJnZXIgYmxvY2sgc2l6ZXMgZG8gbm90IGJlbmVmaXQgZnJvbSBw
b2xsaW5nIGFzIG11Y2ggYnV0IHRoZQ0KaW1wcm92ZW1lbnQgaXMgd29ydGh3aGlsZSBmb3Igc21h
bGxlciBibG9jayBzaXplcy4NCg0KU3RlZmFuIEhham5vY3ppICgzKToNCiAgdmlydGlvOiBhZGQg
dmlydGlvcXVldWVfbW9yZV91c2VkKCkNCiAgdmlydGlvX2JsazogYXZvaWQgcmVwZWF0aW5nIHZi
bGstPnZxc1txaWRdDQogIHZpcnRpb19ibGs6IGltcGxlbWVudCBibGtfbXFfb3BzLT5wb2xsKCkN
Cg0KIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAgIDIgKw0KIGRyaXZlcnMvYmxvY2sv
dmlydGlvX2Jsay5jICAgfCAxMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0N
CiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgIDE3ICsrKysrDQogMyBmaWxlcyBjaGFu
Z2VkLCAxMjMgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4zMS4xDQoN
Cg==

