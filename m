Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53047FA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 01:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJaBtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaBtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 21:49:18 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFF46550
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:49:16 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 31 Oct 2022 09:49:13
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date:   Mon, 31 Oct 2022 09:49:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: Re: misc elevator code cleanups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221030153229.GC9676@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
 <20221030140357.1327019-1-nickyc975@zju.edu.cn>
 <20221030153229.GC9676@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <230ecaa6.15bc4c.1842bba7e73.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHSrCZKV9jh_NPBw--.13064W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgQTB1ZdtcKpowADsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiA+IE9ubHkgZWxldmF0b3JfZmluZF9nZXQgaXMgY2FsbGluZyBfX2VsZXZhdG9yX2ZpbmQgYWZ0
ZXIgYXBwbHlpbmcgdGhlCj4gPiBzZXJpZXMuIE1heWJlIHdlIGNhbiBqdXN0IHJlbW92ZSBfX2Vs
ZXZhdG9yX2ZpbmQgYW5kIG1vdmUgdGhlIGxpc3QKPiA+IGl0ZXJhdGluZyBsb2dpYyBpbnRvIGVs
ZXZhdG9yX2ZpbmRfZ2V0Pwo+IAo+IFdlIGNvdWxkLiBCdXQgdGhlbiB3ZSdkIG5lZWQgYW5vdGhl
ciBsb2NhbCB2YXJpYWJsZSB0byB0cmFjayB3aGF0Cj4gd2FzIGZvdW5kLCBzbyBJJ20gbm90IHN1
cmUgaXQgaXMgYSB3aW4uICBJbiBnZW5lcmFsIGhhdmluZyBhIHB1cmUKPiBsaXN0IGxvb2t1cCBp
biBhIGhlbHBlciB3aGlsZSBhbGwgdGhlIGxvY2tpbmcgYW5kIHJlZmNvdW50aW5nIGluCj4gYSB3
cmFwcGVyIGFyb3VuZCBpdCB0ZW5kcyB0byBiZSBhIHF1aXRlIG5pY2UgcGF0dGVybi4KCkdvdCBp
dCwgdGhhbmsgeW91IGZvciB5b3VyIGFuc3dlciBhbmQgcGF0aWVuY2UhCgpUaGFua3MhCkppbmxv
bmcgQ2hlbgoK
