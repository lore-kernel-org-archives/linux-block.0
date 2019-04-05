Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132CC4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37EE2186A
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B9F7w/ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfDEPZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:25:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44129 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEPZD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 11:25:03 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so5274203iop.11
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+z5Ury4MY0ac4auTRYPYh1QWeB/5PQnmPHd/oEN7ms=;
        b=B9F7w/ctSBqay+MUx71pBnnkxSDQgKs0BuiV88hB4eR/WYA/WFKmwHiBt2UOZP4sEa
         uqlTx9sS8c1gMoSqnme9ayfnTZ6evCeDal2ZLBC7gNf/qmbctAA4MXsYldOhnMZxCzbq
         0b6xVsjuPmt9J0E5iHJwgy9BVdQeUYRqTyTXNGL6CNW9/Y+BfzRwwPd6SrGEs5ARe+1F
         JLM8XZT0OfLU9u18GDIEBrJdaR5b248kXESuJUBGLou9Y1DY+grflTucxoOvT9lNHL5m
         dF2atgM6TmDBt6zWxXsHzwM8wiSR/pmm8MPNgoZGyXAZOIFi8HFcoeMSm1h0BwnVPOp7
         3G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+z5Ury4MY0ac4auTRYPYh1QWeB/5PQnmPHd/oEN7ms=;
        b=lYeTouxKI3f1eHjE+i7atNxVnHi2Nyz3UEJyMAQubEcM6GN3VtEFws3iuZS5zmAHsd
         5w3llfGdxKIQzriud5VYlfISSTc6hGgt4fGvszhEnCgfd2q4lV1/soBDFQxG1JqgtOCf
         Ijy4AbtG69OgG/BUdu2gav0VTpXOIJW52Vh9jwuqXtU1OfEQuZ2zbKLTHNUusGacatcZ
         JmjvvKaa6fdAMfTp8QX8Gm1ene/mvBlW45tu232kSBr2yICQjK1FzkNknRo5ezKD3iQZ
         P74+ZY83O7im1KS+ZmQuYgIp2A1JnhTs9YcnhOXp1OAxFUyUi0afUZf+VW3J61KwPjLm
         8Hzg==
X-Gm-Message-State: APjAAAWMoZOX+jFyqIEEQKlUSHkcEnQ37+7Gzfbk8vs6BcYeCR2OdMGx
        ib8Nx1OXxHC5OeAyOvTZdN6OYrfEe+44Mw==
X-Google-Smtp-Source: APXvYqxwhcwsbdAL/0fvDYrp9DqR+I3/M0tUpbmmekRWSzwpouoqPgf1wVwczoyeQYCwAwkMTPnbTw==
X-Received: by 2002:a5d:8248:: with SMTP id n8mr4043295ioo.125.1554477901927;
        Fri, 05 Apr 2019 08:25:01 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s5sm8732259iog.34.2019.04.05.08.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:25:00 -0700 (PDT)
Subject: Re: [PATCH] paride/pcd: Fix potential NULL pointer dereference and
 mem leak
To:     Yue Haibing <yuehaibing@huawei.com>, tim@cyberelk.net,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190405021458.29872-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4084a000-3557-ff84-ef37-ed68ff6822e2@kernel.dk>
Date:   Fri, 5 Apr 2019 09:24:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405021458.29872-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC80LzE5IDg6MTQgUE0sIFl1ZSBIYWliaW5nIHdyb3RlOg0KPiBGcm9tOiBZdWVIYWli
aW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+IA0KPiBTeXprYWxsZXIgcmVwb3J0IHRo
aXM6DQo+IA0KPiBwY2Q6IHBjZCB2ZXJzaW9uIDEuMDcsIG1ham9yIDQ2LCBuaWNlIDANCj4g
cGNkMDogQXV0b3Byb2JlIGZhaWxlZA0KPiBwY2Q6IE5vIENELVJPTSBkcml2ZSBmb3VuZA0K
PiBrYXNhbjogQ09ORklHX0tBU0FOX0lOTElORSBlbmFibGVkDQo+IGthc2FuOiBHUEYgY291
bGQgYmUgY2F1c2VkIGJ5IE5VTEwtcHRyIGRlcmVmIG9yIHVzZXIgbWVtb3J5IGFjY2Vzcw0K
PiBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQ6IDAwMDAgWyMxXSBTTVAgS0FTQU4gUFRJDQo+
IENQVTogMSBQSUQ6IDQ1MjUgQ29tbTogc3l6LWV4ZWN1dG9yLjAgTm90IHRhaW50ZWQgNS4x
LjAtcmMzKyAjOA0KPiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlgg
KyBQSUlYLCAxOTk2KSwgQklPUyAxLjEwLjItMXVidW50dTEgMDQvMDEvMjAxNA0KPiBSSVA6
IDAwMTA6cGNkX2luaXQrMHg5NWMvMHgxMDAwIFtwY2RdDQo+IENvZGU6IGM0IGFiIGY3IDQ4
IDg5IGQ4IDQ4IGMxIGU4IDAzIDgwIDNjIDI4IDAwIDc0IDA4IDQ4IDg5IGRmIGU4IDU2IGEz
IGRhIGY3IDRjIDhiIDIzIDQ5IDhkIGJjIDI0IDgwIDA1IDAwIDAwIDQ4IDg5IGY4IDQ4IGMx
IGU4IDAzIDw4MD4gM2MgMjggMDAgNzQgMDUgZTggMzkgYTMgZGEgZjcgNDkgOGIgYmMgMjQg
ODAgMDUgMDAgMDAgZTggY2MgYjINCj4gUlNQOiAwMDE4OmZmZmY4ODgxZTg0ZGY4ODAgRUZM
QUdTOiAwMDAxMDIwMg0KPiBSQVg6IDAwMDAwMDAwMDAwMDAwYjAgUkJYOiBmZmZmZmZmZmMx
NTVhMDg4IFJDWDogZmZmZmZmZmZjMTUwODkzNQ0KPiBSRFg6IDAwMDAwMDAwMDAwNDAwMDAg
UlNJOiBmZmZmYzkwMDAxNGYwMDAwIFJESTogMDAwMDAwMDAwMDAwMDU4MA0KPiBSQlA6IGRm
ZmZmYzAwMDAwMDAwMDAgUjA4OiBmZmZmZWQxMDNlZTY1OGI4IFIwOTogZmZmZmVkMTAzZWU2
NThiOA0KPiBSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiBmZmZmZWQxMDNlZTY1OGI3IFIx
MjogMDAwMDAwMDAwMDAwMDAwMA0KPiBSMTM6IGZmZmZmZmZmYzE1NWE3NzggUjE0OiBmZmZm
ZmZmZmMxNTVhNGE4IFIxNTogMDAwMDAwMDAwMDAwMDAwMw0KPiBGUzogIDAwMDA3ZmU3MWJl
ZTM3MDAoMDAwMCkgR1M6ZmZmZjg4ODFmNzMwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwDQo+IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMNCj4gQ1IyOiAwMDAwNTVhNzMzNDQ0MWE4IENSMzogMDAwMDAwMDFlOTY3NDAwMyBD
UjQ6IDAwMDAwMDAwMDA3NjA2ZTANCj4gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAw
MDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gRFIzOiAwMDAwMDAwMDAw
MDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4g
UEtSVTogNTU1NTU1NTQNCj4gQ2FsbCBUcmFjZToNCj4gID8gMHhmZmZmZmZmZmMxNTA4MDAw
DQo+ICA/IDB4ZmZmZmZmZmZjMTUwODAwMA0KPiAgZG9fb25lX2luaXRjYWxsKzB4YmMvMHg0
N2QgaW5pdC9tYWluLmM6OTAxDQo+ICBkb19pbml0X21vZHVsZSsweDFiNS8weDU0NyBrZXJu
ZWwvbW9kdWxlLmM6MzQ1Ng0KPiAgbG9hZF9tb2R1bGUrMHg2NDA1LzB4OGMxMCBrZXJuZWwv
bW9kdWxlLmM6MzgwNA0KPiAgX19kb19zeXNfZmluaXRfbW9kdWxlKzB4MTYyLzB4MTkwIGtl
cm5lbC9tb2R1bGUuYzozODk4DQo+ICBkb19zeXNjYWxsXzY0KzB4OWYvMHg0NTAgYXJjaC94
ODYvZW50cnkvY29tbW9uLmM6MjkwDQo+ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0OS8weGJlDQo+IFJJUDogMDAzMzoweDQ2MmU5OQ0KPiBDb2RlOiBmNyBkOCA2NCA4
OSAwMiBiOCBmZiBmZiBmZiBmZiBjMyA2NiAwZiAxZiA0NCAwMCAwMCA0OCA4OSBmOCA0OCA4
OSBmNyA0OCA4OSBkNiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAyNCAw
OCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGJjIGZmIGZm
IGZmIGY3IGQ4IDY0IDg5IDAxIDQ4DQo+IFJTUDogMDAyYjowMDAwN2ZlNzFiZWUyYzU4IEVG
TEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAxMzkNCj4gUkFYOiBmZmZm
ZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDczYmYwMCBSQ1g6IDAwMDAwMDAwMDA0NjJl
OTkNCj4gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAyMDAwMDE4MCBSREk6
IDAwMDAwMDAwMDAwMDAwMDMNCj4gUkJQOiAwMDAwN2ZlNzFiZWUyYzcwIFIwODogMDAwMDAw
MDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANCj4gUjEwOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA3ZmU3MWJlZTM2YmMNCj4gUjEz
OiAwMDAwMDAwMDAwNGJjZWZhIFIxNDogMDAwMDAwMDAwMDZmNmZiMCBSMTU6IDAwMDAwMDAw
MDAwMDAwMDQNCj4gTW9kdWxlcyBsaW5rZWQgaW46IHBjZCgrKSBwYXJpZGUgc29sb3NfcGNp
IGF0bSB0c19mc20gcnRjX210NjM5NyBtYWM4MDIxMSBuaGNfbW9iaWxpdHkgbmhjX3VkcCBu
aGNfaXB2NiBuaGNfaG9wIG5oY19kZXN0IG5oY19mcmFnbWVudCBuaGNfcm91dGluZyA2bG93
cGFuIHJ0Y19jcm9zX2VjIG1lbWNvbnNvbGUgaW50ZWxfeGhjaV91c2Jfcm9sZV9zd2l0Y2gg
cm9sZXMgcnRjX3dtODM1MCB1c2Jjb3JlIGluZHVzdHJpYWxpb190cmlnZ2VyZWRfYnVmZmVy
IGtmaWZvX2J1ZiBpbmR1c3RyaWFsaW8gYXNjNzYyMSBkbV9lcmEgZG1fcGVyc2lzdGVudF9k
YXRhIGRtX2J1ZmlvIGRtX21vZCB0cG0gZ25zc191YnggZ25zc19zZXJpYWwgc2VyZGV2IGdu
c3MgbWF4MjE2NSBjcHVmcmVxX2R0IGhpZF9wZW5tb3VudCBoaWQgbWVuZjIxYm1jX3dkdCBy
Y19jb3JlIG5fdHJhY2VzaW5rIGlkZV9nZF9tb2QgY2Ruc19jc2kydHggdjRsMl9md25vZGUg
dmlkZW9kZXYgbWVkaWEgcGluY3RybF9sZXdpc2J1cmcgcGluY3RybF9pbnRlbCBpcHRhYmxl
X3NlY3VyaXR5IGlwdGFibGVfcmF3IGlwdGFibGVfbWFuZ2xlIGlwdGFibGVfbmF0IG5mX25h
dCBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgaXB0YWJsZV9m
aWx0ZXIgYnBmaWx0ZXIgaXA2X3Z0aSBpcF92dGkgaXBfZ3JlIGlwaXAgc2l0IHR1bm5lbDQg
aXBfdHVubmVsIGhzciB2ZXRoIG5ldGRldnNpbSB2eGNhbiBiYXRtYW5fYWR2IGNmZzgwMjEx
IHJma2lsbCBjaG5sX25ldCBjYWlmIG5sbW9uIGR1bW15IHRlYW0gYm9uZGluZyB2Y2FuIGJy
aWRnZSBzdHAgbGxjIGlwNl9ncmUgZ3JlIGlwNl90dW5uZWwgdHVubmVsNiB0dW4gam95ZGV2
IG1vdXNlZGV2IHBwZGV2IGt2bV9pbnRlbCBrdm0gaXJxYnlwYXNzIGNyY3QxMGRpZl9wY2xt
dWwgY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRlbCBnaGFzaF9jbG11bG5pX2ludGVsIGFlc25p
X2ludGVsIGFlc194ODZfNjQgY3J5cHRvX3NpbWQNCj4gIGlkZV9wY2lfZ2VuZXJpYyBwaWl4
IGlucHV0X2xlZHMgY3J5cHRkIGdsdWVfaGVscGVyIHBzbW91c2UgaWRlX2NvcmUgaW50ZWxf
YWdwIHNlcmlvX3JhdyBpbnRlbF9ndHQgYXRhX2dlbmVyaWMgaTJjX3BpaXg0IGFncGdhcnQg
cGF0YV9hY3BpIHBhcnBvcnRfcGMgcGFycG9ydCBmbG9wcHkgcnRjX2Ntb3Mgc2NoX2ZxX2Nv
ZGVsIGlwX3RhYmxlcyB4X3RhYmxlcyBzaGExX3Nzc2UzIHNoYTFfZ2VuZXJpYyBpcHY2IFts
YXN0IHVubG9hZGVkOiBibWMxNTBfbWFnbl0NCj4gRHVtcGluZyBmdHJhY2UgYnVmZmVyOg0K
PiAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCj4gLS0tWyBlbmQgdHJhY2UgZDg3MzY5MWMz
Y2Q2OWY1NiBdLS0tDQo+IA0KPiBJZiBhbGxvY19kaXNrIGZhaWxzIGluIHBjZF9pbml0X3Vu
aXRzLCBjZC0+ZGlzayB3aWxsIGJlDQo+IE5VTEwsIGhvd2V2ZXIgaW4gcGNkX2RldGVjdCBh
bmQgcGNkX2V4aXQsIGl0J3Mgbm90IGNoZWNrDQo+IHRoaXMgYmVmb3JlIGZyZWUuSXQgbWF5
IHJlc3VsdCBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4gDQo+IEFsc28gd2hlbiBy
ZWdpc3Rlcl9ibGtkZXYgZmFpbGVkLCBibGtfY2xlYW51cF9xdWV1ZSgpIGFuZA0KPiBibGtf
bXFfZnJlZV90YWdfc2V0KCkgc2hvdWxkIGJlIGNhbGxlZCB0byBmcmVlIHJlc291cmNlcy4N
Cg0KQXBwbGllZCwgdGhhbmtzLiBOb3Qgc3VycHJpc2luZyBzaW5jZSBwZiB3YXMgYnJva2Vu
IGFzIHdlbGwuDQoNCi0tIA0KSmVucyBBeGJvZQ0KDQo=
