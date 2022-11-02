Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34BC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKBBog (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBBof (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:44:35 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A37B5DED7;
        Tue,  1 Nov 2022 18:44:33 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 2 Nov 2022 09:44:30
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Wed, 2 Nov 2022 09:44:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 1/4] blk-mq: update comment for
 blk_mq_quiesce_queue_nowait()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221101172720.GA20526@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <489a9322eed1f95f8770752cc715084f1fa961d3.1667314759.git.nickyc975@zju.edu.cn>
 <20221101172720.GA20526@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f33a768.1635a2.1843602e799.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAXz1p+y2FjIKdcBw--.53643W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIAB1ZdtcLuXwATsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBPbiBUdWUsIE5vdiAwMSwgMjAyMiBhdCAxMToxMTozNFBNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBibGtfbXFfcXVpZXNjZV9xdWV1ZV9ub3dhaXQoKSBpcyBub3cgcmVhc29uYWJs
eSB1c2VkIGJ5IHNjc2lfaG9zdF9ibG9jaygpCj4gPiB0byBhdm9pZCBjYWxsaW5nIHN5bmNocm9u
aXplX3JjdSgpIGZvciBlYWNoIExVTi4gV2Ugc2hvdWxkIG5vdCBjb25zaWRlciB0bwo+ID4gcmVt
b3ZlIGl0Lgo+IAo+IEkgc3Ryb25nbHkgZGlzYWdyZWUgYWJvdXQgdGhpcyBiZWluZyBhIHJlYXNv
bmFibGUgdXNlLiAgV2hhdCBTQ1NJIGRpZAo+IHRoZXJlIGlzIGEgaG9ycmlibGUgaGFjayB0aGF0
IHNob3VsZCBoYXZlIG5ldmVyIGJlZW4gbWVyZ2VkLiAgVGhlCj4gcmlnaHQgdGhpbmcgdG8gZG8g
aXMgdGhlIHBlci10YWdfc2V0IHF1aWVzY2UgdGhhdCB3ZSd2ZSBiZWVuIHdvcmtpbmcKPiBvbi4K
Ck9rLCBJIGd1ZXNzIEkgbmVlZCB0byByZWFkIHRoZSBwZXItdGFnX3NldCBxdWllc2NlIHBhdGNo
IHNlcmllcy4KClRoYW5rcyEKSmlubG9uZyBDaGVuCg==
