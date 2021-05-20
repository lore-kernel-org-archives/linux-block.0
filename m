Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F2FC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEA1608FE
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbhETOQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 10:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242098AbhETOPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 10:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621520027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Agfgj5H+O2SpDpdHb5XPypSRzbYVYTbhLYER/UTUmY4=;
        b=A1VzRPiXyCPSIF/csRki/y+JB1FAKQKa5i66BXo9gCgSTolWEJwX6W8OMygNWOblWlRXKT
        5Lr8LwuX7cTClnxw0oKMygKdQRrs5qT2ZWkkPYPuj0/sshZEPHR0NECwvc7d9w90g7RgFJ
        8Yr75Ddk3Gv9NqzjpxuEp75dP7zfQZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-dBeH17zRMVu4AQcmL-Y4Ow-1; Thu, 20 May 2021 10:13:43 -0400
X-MC-Unique: dBeH17zRMVu4AQcmL-Y4Ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29A1E801B14;
        Thu, 20 May 2021 14:13:42 +0000 (UTC)
Received: from localhost (ovpn-115-223.ams2.redhat.com [10.36.115.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78DBC1037F22;
        Thu, 20 May 2021 14:13:31 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/3] virtio_blk: avoid repeating vblk->vqs[qid]
Date:   Thu, 20 May 2021 15:13:04 +0100
Message-Id: <20210520141305.355961-3-stefanha@redhat.com>
In-Reply-To: <20210520141305.355961-1-stefanha@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

c3RydWN0IHZpcnRpb19ibGtfdnEgaXMgYWNjZXNzZWQgaW4gbWFueSBwbGFjZXMuIEludHJvZHVj
ZSAidmJxIiBsb2NhbAp2YXJpYWJsZXMgdG8gYXZvaWQgcmVwZWF0aW5nIHZibGstPnZxc1txaWRd
IHRocm91Z2hvdXQgdGhlIGNvZGUuIFRoZQpwYXRjaGVzIHRoYXQgZm9sbG93IHdpbGwgYWRkIG1v
cmUgYWNjZXNzZXMsIG1ha2luZyB0aGUgcGF5b2ZmIGV2ZW4KZ3JlYXRlci4KCnZpcnRpb19jb21t
aXRfcnFzKCkgY2FsbHMgdGhlIGxvY2FsIHZhcmlhYmxlICJ2cSIsIHdoaWNoIGlzIGVhc2lseQpj
b25mdXNlZCB3aXRoIHN0cnVjdCB2aXJ0cXVldWUuIFJlbmFtZSB0byAidmJxIiBmb3IgY2xhcml0
eS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
LS0tCiBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDM0ICsrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBiL2RyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jCmluZGV4IGI5ZmEzZWY1YjU3Yy4uZmMwZmIxZGNkMzk5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYworKysgYi9kcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYwpAQCAtMTc0LDE2ICsxNzQsMTYgQEAgc3RhdGljIGlubGluZSB2b2lkIHZp
cnRibGtfcmVxdWVzdF9kb25lKHN0cnVjdCByZXF1ZXN0ICpyZXEpCiBzdGF0aWMgdm9pZCB2aXJ0
YmxrX2RvbmUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCiB7CiAJc3RydWN0IHZpcnRpb19ibGsgKnZi
bGsgPSB2cS0+dmRldi0+cHJpdjsKKwlzdHJ1Y3QgdmlydGlvX2Jsa192cSAqdmJxID0gJnZibGst
PnZxc1t2cS0+aW5kZXhdOwogCWJvb2wgcmVxX2RvbmUgPSBmYWxzZTsKLQlpbnQgcWlkID0gdnEt
PmluZGV4OwogCXN0cnVjdCB2aXJ0YmxrX3JlcSAqdmJyOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CiAJdW5zaWduZWQgaW50IGxlbjsKIAotCXNwaW5fbG9ja19pcnFzYXZlKCZ2YmxrLT52cXNbcWlk
XS5sb2NrLCBmbGFncyk7CisJc3Bpbl9sb2NrX2lycXNhdmUoJnZicS0+bG9jaywgZmxhZ3MpOwog
CWRvIHsKIAkJdmlydHF1ZXVlX2Rpc2FibGVfY2IodnEpOwotCQl3aGlsZSAoKHZiciA9IHZpcnRx
dWV1ZV9nZXRfYnVmKHZibGstPnZxc1txaWRdLnZxLCAmbGVuKSkgIT0gTlVMTCkgeworCQl3aGls
ZSAoKHZiciA9IHZpcnRxdWV1ZV9nZXRfYnVmKHZxLCAmbGVuKSkgIT0gTlVMTCkgewogCQkJc3Ry
dWN0IHJlcXVlc3QgKnJlcSA9IGJsa19tcV9ycV9mcm9tX3BkdSh2YnIpOwogCiAJCQlpZiAobGlr
ZWx5KCFibGtfc2hvdWxkX2Zha2VfdGltZW91dChyZXEtPnEpKSkKQEAgLTE5NywzMiArMTk3LDMy
IEBAIHN0YXRpYyB2b2lkIHZpcnRibGtfZG9uZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKIAkvKiBJ
biBjYXNlIHF1ZXVlIGlzIHN0b3BwZWQgd2FpdGluZyBmb3IgbW9yZSBidWZmZXJzLiAqLwogCWlm
IChyZXFfZG9uZSkKIAkJYmxrX21xX3N0YXJ0X3N0b3BwZWRfaHdfcXVldWVzKHZibGstPmRpc2st
PnF1ZXVlLCB0cnVlKTsKLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2YmxrLT52cXNbcWlkXS5s
b2NrLCBmbGFncyk7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdmJxLT5sb2NrLCBmbGFncyk7
CiB9CiAKIHN0YXRpYyB2b2lkIHZpcnRpb19jb21taXRfcnFzKHN0cnVjdCBibGtfbXFfaHdfY3R4
ICpoY3R4KQogewogCXN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gaGN0eC0+cXVldWUtPnF1ZXVl
ZGF0YTsKLQlzdHJ1Y3QgdmlydGlvX2Jsa192cSAqdnEgPSAmdmJsay0+dnFzW2hjdHgtPnF1ZXVl
X251bV07CisJc3RydWN0IHZpcnRpb19ibGtfdnEgKnZicSA9ICZ2YmxrLT52cXNbaGN0eC0+cXVl
dWVfbnVtXTsKIAlib29sIGtpY2s7CiAKLQlzcGluX2xvY2tfaXJxKCZ2cS0+bG9jayk7Ci0Ja2lj
ayA9IHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUodnEtPnZxKTsKLQlzcGluX3VubG9ja19pcnEoJnZx
LT5sb2NrKTsKKwlzcGluX2xvY2tfaXJxKCZ2YnEtPmxvY2spOworCWtpY2sgPSB2aXJ0cXVldWVf
a2lja19wcmVwYXJlKHZicS0+dnEpOworCXNwaW5fdW5sb2NrX2lycSgmdmJxLT5sb2NrKTsKIAog
CWlmIChraWNrKQotCQl2aXJ0cXVldWVfbm90aWZ5KHZxLT52cSk7CisJCXZpcnRxdWV1ZV9ub3Rp
ZnkodmJxLT52cSk7CiB9CiAKIHN0YXRpYyBibGtfc3RhdHVzX3QgdmlydGlvX3F1ZXVlX3JxKHN0
cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LAogCQkJICAgY29uc3Qgc3RydWN0IGJsa19tcV9xdWV1
ZV9kYXRhICpiZCkKIHsKIAlzdHJ1Y3QgdmlydGlvX2JsayAqdmJsayA9IGhjdHgtPnF1ZXVlLT5x
dWV1ZWRhdGE7CisJc3RydWN0IHZpcnRpb19ibGtfdnEgKnZicSA9ICZ2YmxrLT52cXNbaGN0eC0+
cXVldWVfbnVtXTsKIAlzdHJ1Y3QgcmVxdWVzdCAqcmVxID0gYmQtPnJxOwogCXN0cnVjdCB2aXJ0
YmxrX3JlcSAqdmJyID0gYmxrX21xX3JxX3RvX3BkdShyZXEpOwogCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7CiAJdW5zaWduZWQgaW50IG51bTsKLQlpbnQgcWlkID0gaGN0eC0+cXVldWVfbnVtOwogCWlu
dCBlcnI7CiAJYm9vbCBub3RpZnkgPSBmYWxzZTsKIAlib29sIHVubWFwID0gZmFsc2U7CkBAIC0y
NzQsMTYgKzI3NCwxNiBAQCBzdGF0aWMgYmxrX3N0YXR1c190IHZpcnRpb19xdWV1ZV9ycShzdHJ1
Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwKIAkJCXZici0+b3V0X2hkci50eXBlIHw9IGNwdV90b192
aXJ0aW8zMih2YmxrLT52ZGV2LCBWSVJUSU9fQkxLX1RfSU4pOwogCX0KIAotCXNwaW5fbG9ja19p
cnFzYXZlKCZ2YmxrLT52cXNbcWlkXS5sb2NrLCBmbGFncyk7Ci0JZXJyID0gdmlydGJsa19hZGRf
cmVxKHZibGstPnZxc1txaWRdLnZxLCB2YnIsIHZici0+c2csIG51bSk7CisJc3Bpbl9sb2NrX2ly
cXNhdmUoJnZicS0+bG9jaywgZmxhZ3MpOworCWVyciA9IHZpcnRibGtfYWRkX3JlcSh2YnEtPnZx
LCB2YnIsIHZici0+c2csIG51bSk7CiAJaWYgKGVycikgewotCQl2aXJ0cXVldWVfa2ljayh2Ymxr
LT52cXNbcWlkXS52cSk7CisJCXZpcnRxdWV1ZV9raWNrKHZicS0+dnEpOwogCQkvKiBEb24ndCBz
dG9wIHRoZSBxdWV1ZSBpZiAtRU5PTUVNOiB3ZSBtYXkgaGF2ZSBmYWlsZWQgdG8KIAkJICogYm91
bmNlIHRoZSBidWZmZXIgZHVlIHRvIGdsb2JhbCByZXNvdXJjZSBvdXRhZ2UuCiAJCSAqLwogCQlp
ZiAoZXJyID09IC1FTk9TUEMpCiAJCQlibGtfbXFfc3RvcF9od19xdWV1ZShoY3R4KTsKLQkJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmdmJsay0+dnFzW3FpZF0ubG9jaywgZmxhZ3MpOworCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZ2YnEtPmxvY2ssIGZsYWdzKTsKIAkJc3dpdGNoIChlcnIpIHsK
IAkJY2FzZSAtRU5PU1BDOgogCQkJcmV0dXJuIEJMS19TVFNfREVWX1JFU09VUkNFOwpAQCAtMjk0
LDEyICsyOTQsMTIgQEAgc3RhdGljIGJsa19zdGF0dXNfdCB2aXJ0aW9fcXVldWVfcnEoc3RydWN0
IGJsa19tcV9od19jdHggKmhjdHgsCiAJCX0KIAl9CiAKLQlpZiAoYmQtPmxhc3QgJiYgdmlydHF1
ZXVlX2tpY2tfcHJlcGFyZSh2YmxrLT52cXNbcWlkXS52cSkpCisJaWYgKGJkLT5sYXN0ICYmIHZp
cnRxdWV1ZV9raWNrX3ByZXBhcmUodmJxLT52cSkpCiAJCW5vdGlmeSA9IHRydWU7Ci0Jc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmdmJsay0+dnFzW3FpZF0ubG9jaywgZmxhZ3MpOworCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnZicS0+bG9jaywgZmxhZ3MpOwogCiAJaWYgKG5vdGlmeSkKLQkJdmly
dHF1ZXVlX25vdGlmeSh2YmxrLT52cXNbcWlkXS52cSk7CisJCXZpcnRxdWV1ZV9ub3RpZnkodmJx
LT52cSk7CiAJcmV0dXJuIEJMS19TVFNfT0s7CiB9CiAKLS0gCjIuMzEuMQoK

