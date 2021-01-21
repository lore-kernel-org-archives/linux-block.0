Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D29AC433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BB8238E2
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAUHe6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:34:58 -0500
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:39247 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAUHeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 02:34:18 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1303425|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0211761-0.00130404-0.97752;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=liu.xiang@zlingsmart.com;NM=1;PH=DW;RN=4;RT=4;SR=0;TI=W4_6085603_DEFAULT_0AC264B5_1611214294767_o7001c689i;
Received: from WS-web (liu.xiang@zlingsmart.com[W4_6085603_DEFAULT_0AC264B5_1611214294767_o7001c689i]) by ay29a011140100061.et135 at Thu, 21 Jan 2021 15:33:26 +0800
Date:   Thu, 21 Jan 2021 15:33:26 +0800
From:   "liu xiang" <liu.xiang@zlingsmart.com>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "linux-block" <linux-block@vger.kernel.org>,
        "axboe" <axboe@kernel.dk>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "liu xiang" <liu.xiang@zlingsmart.com>
Message-ID: <460a3fcd-b7a1-42f4-abc3-b1a267259c26.liu.xiang@zlingsmart.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYmxrLW1xOiBpbnRyb2R1Y2UgUkVRX0NPTVBMRVRFX1dRIGFuZCBhZGQg?=
  =?UTF-8?B?YSB3b3JrcXVldWUgdG8gY29tcGxldGUgdGhlIHJlcXVlc3Q=?=
X-Mailer: [Alimail-Mailagent revision 794][W4_6085603][DEFAULT][Chrome]
MIME-Version: 1.0
References: <20210120021522.28584-1-liu.xiang@zlingsmart.com>,<20210120095409.GB3694085@infradead.org>
In-Reply-To: <20210120095409.GB3694085@infradead.org>
x-aliyun-mail-creator: W4_6085603_DEFAULT_AoSTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV09XNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS83NS4wLjM3NzAuMTAwIFNhZmFyaS81MzcuMzY=zN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMTA6MTU6MjJBTSArMDgwMCwgTGl1IFhpYW5nIHdyb3Rl
Ogo+IFRoZSBjb21taXQgIjQwZDA5YjUzYmZjNTU3YWY3NDgxYjlkODBmMDYwYTdhYzljN2QzMTQi
IGhhcyBzb2x2ZWQgdGhlCj4gaXJxc29mZiBwcm9ibGVtIGJ5IGNvbXBsZXRpbmcgdGhlIHJlcXVl
c3QgaW4gc29mdGlycS4gQnV0IGl0IG1heSBjYXVzZQo+IHRoZSBzeXN0ZW0gdG8gc3VmZmVyIGJh
ZCBwcmVlbXB0b2ZmIHRpbWUuCj4gSW50cm9kdWNlIHRoZSBSRVFfQ09NUExFVEVfV1EgZmxhZyBh
bmQgYmxrX2NvbXBsZXRlIHdvcmtxdWV1ZS4KPiBUaGlzIGZsYWcgbWFrZXMgdGhlIHJlcXVlc3Qg
dG8gYmUgY29tcGxldGVkIGluIHRoZSBibGtfY29tcGxldGUgd29ya3F1ZXVlLgo+IEl0IGNhbiBi
ZSB1c2VkIGZvciByZXF1ZXN0cyB0aGF0IHdhbnQgdG8gY3V0IGRvd24gYm90aCBpcnFzb2ZmIGFu
ZAo+IHByZWVtcHRvZmYgdGltZS4KCkluIGFkZGl0aW9uIHRvIGJsb2F0aW5nIHRoZSByZXF1ZXN0
X3F1ZXVlIGFuZCBpbnRyb2R1Y2luZyB0aGUgY29tcGxldGlvbgpmYXN0IHBhdGggdGhpcyBzZWVt
cyB0byBsYWNrIGFuIGFjdHVhbCB1c2VyLgoKSSBoYXZlIHRlc3RlZCBtbWMgYW5kIHZpcnRpb19i
bGsgZHJpdmVycy4gVGhleSBib3RoIGhhdmUgcHJlZW1wdG9mZiBwcm9ibGVtLgpUaGUgbW1jIGRy
aXZlciBoYXMgaXRzIG93biBjb21wbGV0ZSB3b3JrcXVldWUuIEJ1dCBpdCBjYW4gbm90IHdvcmsg
d2VsbCBub3cuIApJIHRoaW5rIGl0IGlzIGJldHRlciB0byBjb21wbGV0ZSByZXF1ZXN0IGRpcmVj
dGx5IHdpdGggUkVRX0hJUFJJIGZsYWcuClRoZSB2aXJ0aW9fYmxrIGRyaXZlciBjYW4gdXNlIFJF
UV9DT01QTEVURV9XUSBmbGFnIHRvIGF2b2lkIHByZWVtcHRvZmYgcHJvYmxlbS4=
