Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC55C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1191120714
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 07:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFOH0Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:26:16 -0400
Received: from mail-177142.yeah.net ([123.58.177.142]:57487 "EHLO
        mail-177142.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgFOH0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 03:26:16 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 03:26:15 EDT
Received: from vivo.com (localhost [127.0.0.1])
        by mail-177142.yeah.net (Hmail) with ESMTP id C84A06445C6;
        Mon, 15 Jun 2020 15:18:29 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AMQAhwC7CIPskkflFGpmIqrA.3.1592205509810.Hmail.wangqing@vivo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJpdmVyc1xibG9jazogVXNlIGtvYmpfdG9fZGV2KCkgQVBJ?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.124
In-Reply-To: <20200612102651-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [157.0.31.124) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 15 Jun 2020 15:18:29 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Mon, 15 Jun 2020 15:18:29 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHU9DTR8fSh4aHUIeVkpOQklJS05OS0JDTkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhDSUNPTUxKTENLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Nio6Eww4TDgyKwgQEB0XPTwLFjIKCTpVSFVKTkJJSUtOTkpLSUtNVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZSk5MVUtVSEpVSklPWVdZCAFZQUhISkw3Bg++
X-HM-Tid: 0a72b6d804be6473kursc84a06445c6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcnNcYmxvY2s6IFVzZSBrb2JqX3RvX2RldigpIEFQ
ST5PbiBGcmksIEp1biAxMiwgMjAyMCBhdCAwMzoxMDo1NlBNICswODAwLCBXYW5nIFFpbmcgd3Jv
dGU6Cj4+IFVzZSBrb2JqX3RvX2RldigpIEFQSSBpbnN0ZWFkIG9mIGNvbnRhaW5lcl9vZigpLgo+
PiAKPj4gU2lnbmVkLW9mZi1ieTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4gLS0t
Cj4+ICBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDIgKy0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+PiAgbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+
IDEwMDc1NSBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+Cj4KPlN1YmplY3Qgc2hvdWxkIHBy
b2JhYmx5IHVzZSAiLyIuIEJlc2lkZXMgdGhhdCAtIHRyaXZpYWwgdHJlZT8KU29ycnksIEkgd2ls
bCBtb2RpZnkgc3ViamVjdCB1c2luZyAiLyIuIEJ1dCB3aGF0IGRvIHlvdSBtZWFuIGFib3V0IHRy
aXZpYWwgdHJlZT8KPgo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Js
ay5jIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPj4gaW5kZXggOWQyMWJmMC4uYzgwODQw
NQo+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+PiArKysgYi9kcml2ZXJzL2Js
b2NrL3ZpcnRpb19ibGsuYwo+PiBAQCAtNjMwLDcgKzYzMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICp2aXJ0YmxrX2F0dHJzW10gPSB7Cj4+ICBzdGF0aWMgdW1vZGVfdCB2aXJ0YmxrX2F0
dHJzX2FyZV92aXNpYmxlKHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+PiAgCQlzdHJ1Y3QgYXR0cmli
dXRlICphLCBpbnQgbikKPj4gIHsKPj4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBjb250YWluZXJf
b2Yoa29iaiwgc3RydWN0IGRldmljZSwga29iaik7Cj4+ICsJc3RydWN0IGRldmljZSAqZGV2ID0g
a29ial90b19kZXYoa29iaik7Cj4+ICAJc3RydWN0IGdlbmRpc2sgKmRpc2sgPSBkZXZfdG9fZGlz
ayhkZXYpOwo+PiAgCXN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gZGlzay0+cHJpdmF0ZV9kYXRh
Owo+PiAgCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdmJsay0+dmRldjsKPj4gLS0gCj4+
IDIuNy40Cj4KDQoNCg==
