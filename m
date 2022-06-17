Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFDBC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 01:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378967AbiFQBWi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 21:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiFQBWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 21:22:36 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC02614
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 18:22:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DW;RN=3;SR=0;TI=W4_0.1.30_DEFAULT_212D5AFB_1655428716527_o7001c223n;
Received: from WS-web (liusong@linux.alibaba.com[W4_0.1.30_DEFAULT_212D5AFB_1655428716527_o7001c223n]) at Fri, 17 Jun 2022 09:22:32 +0800
Date:   Fri, 17 Jun 2022 09:22:32 +0800
From:   "liusong" <liusong@linux.alibaba.com>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "axboe" <axboe@kernel.dk>,
        "linux-block" <linux-block@vger.kernel.org>
Reply-To: "liusong" <liusong@linux.alibaba.com>
Message-ID: <61b3a897-88a2-4d98-b5fe-5a7b6ef73fb9.liusong@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYmxvY2s6IGFkanVzdCB0aGUganVkZ21lbnQgb3JkZXIgaW4gc3VibWl0?=
  =?UTF-8?B?X2Jpbw==?=
X-Mailer: [Alimail-Mailagent][W4_0.1.30][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1655286442-104784-1-git-send-email-liusong@linux.alibaba.com>,<Yqm8C+W+/8ZRyM3m@infradead.org>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMi4wLjUwMDUuMTE1IFNhZmFyaS81MzcuMzY=vN
In-Reply-To: <Yqm8C+W+/8ZRyM3m@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pj4gRnJvbTogTGl1IFNvbmcgPGxpdXNvbmdAbGludXguYWxpYmFiYS5jb20+Cj4+IAo+PiBCSU9f
V09SS0lOR1NFVCBpcyByYXJlciB0aGFuIHJlYWQsIHNvIGFkanVzdCB0byB0aGUgZmlyc3Qgb25l
IHRvIGp1ZGdlLgo+Cj4gQ2FuIHlvdSBleHBsYWluIGhvdyB0aGlzIG1hdHRlcnMgYXQgYWxsPyAg
VGhlIHJpZ2h0IHRoaW5nIGlzIG9mIGNvdXJzZQo+IHRvIGdldCByaWQgb2YgdGhpcyBjaGVjayBh
bmQgSSBuZWVkIHRvIGZpbmlzaCB0aGUgc2VyaWVzIHRvIGRvIHRoYXQuCgpIaQogICAgVGhpcyBj
aGFuZ2UgZG8gbm90IGludm9sdmUgZnVuY3Rpb25hbCBjaGFuZ2VzLCBJIGp1c3QgZmVlbCB0aGF0
IGl0IG5lZWRzIHRvCmJlIGVtcGhhc2l6ZWQgdGhhdCBmb3IgZXhhbXBsZSwgdGhlIGlvIHRyaWdn
ZXJlZCBieSByZWZhdWx0IGlzIG11Y2ggbGVzcyB0aGFuCnRoZSByZWFkLgoKVGhhbmtz
