Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F54C433E7
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E09222E9
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="myhmrCI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgJSOqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 10:46:18 -0400
Received: from m134.mail.163.com ([220.181.13.4]:15916 "EHLO m134.mail.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgJSOqS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 10:46:18 -0400
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 10:45:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=U7LM+
        dC5vhJuqgB7bSYkXHferWewlR6tdqdoY40buGQ=; b=myhmrCI+zQ8Mq0kKdJZz0
        C5zfewNVQm0NZlFSD262dpBA7BeXsXv7GVQJTlXUuu4bkZhJgzdC6/7agb7FyGQr
        QKikr8O9U3boBWA6JLm784vqB3MAcTSVPfQQGgX2EqraahlLVRauaZwKlc2c5PZc
        KTWScsCAweRGrwGrqDaosY=
Received: from sh_def$163.com ( [139.162.39.19] ) by ajax-webmail-wmsvr4
 (Coremail) ; Mon, 19 Oct 2020 22:30:06 +0800 (CST)
X-Originating-IP: [139.162.39.19]
Date:   Mon, 19 Oct 2020 22:30:06 +0800 (CST)
From:   =?GBK?B?y9W71A==?= <sh_def@163.com>
To:     "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] blk: use REQ_OP_WRITE instead of hard code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <SN4PR0401MB3598441A5D53ED264496CF419B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201019135059.GA16475@rlk>
 <SN4PR0401MB3598441A5D53ED264496CF419B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3e965865.5946.17541447519.Coremail.sh_def@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: BMGowADX9v7voo1fGGBoAA--.47468W
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMR3CX1UMWAjmbAABsz
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

WWVhaCwgeW91IGFyZSByaWdodCwgdGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uPGJyLz48YnIv
Pk1heWJlIHdlIHNob3VsZCBkZWZpbmUgYSBNQVNLIHRvIGRvIHRoaXM/CkF0IDIwMjAtMTAtMTkg
MjI6MDk6NDAsICJKb2hhbm5lcyBUaHVtc2hpcm4iIDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNv
bT4gd3JvdGU6Cj5PbiAxOS8xMC8yMDIwIDE2OjA2LCBIdWkgU3Ugd3JvdGU6DQo+PiB1c2UgUkVR
X09QX1dSSVRFIGluc3RlYWQgb2YgaGFyZCBjb2RlIGluDQo+PiBvcF9pc193cml0ZSgpLg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBIdWkgU3UgPHNoX2RlZkAxNjMuY29tPg0KPj4gLS0tDQo+PiAg
aW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvYmxrX3R5cGVzLmggYi9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oDQo+PiBpbmRleCA3
ZDdjMTMyMzhmZGIuLjdiOWIwMjM3OGMyNCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
YmxrX3R5cGVzLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgNCj4+IEBAIC00
NDAsNyArNDQwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGJpb19zZXRfb3BfYXR0cnMoc3RydWN0
IGJpbyAqYmlvLCB1bnNpZ25lZCBvcCwNCj4+ICANCj4+ICBzdGF0aWMgaW5saW5lIGJvb2wgb3Bf
aXNfd3JpdGUodW5zaWduZWQgaW50IG9wKQ0KPj4gIHsNCj4+IC0JcmV0dXJuIChvcCAmIDEpOw0K
Pj4gKwlyZXR1cm4gKG9wICYgUkVRX09QX1dSSVRFKTsNCj4NCj5vcF9pc193cml0ZSgpIHJldHVy
bnMgdHJ1ZSBmb3IgZXZlcnkgcmVxX29wIHRoYXQgd3JpdGVzIHRvIGEgZGV2aWNlICh0aGV5IGFs
bCBoYXZlIA0KPnRoZSBsb3dlc3QgYml0IHNldCksIHdoaWxlIFJFUV9PUF9XUklURSBtZWFucyBh
IFdSSVRFLiBZb3UnbGwgY2hhbmdlIHRoZSBzZW1hbnRpY3MNCj53aXRoIHRoaXMgcGF0Y2guDQo=

