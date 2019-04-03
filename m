Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABE6C10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E0C206DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cT8XEZwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfDCQIK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:08:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37816 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCQIJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:08:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so5321881ply.4
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JMXZLGa1AbXsvKnZ90qPbpZuT0gz6jvkKk+0XYLpHYQ=;
        b=cT8XEZwYKSZ/g9tXtmqol9sRWN5L/Hmn3ZhW3yQbBwtD0LebQcbRo64KgGMMZ/JhbR
         X7tNObY7cJJScHh5/x9jO8qbLsLujLvc+nLcMo2MgK83toX9Ghc1w7u2eUzsglv70CKS
         o0lAS+jWDDhC5qKD2Lln70X4GxRtRNdLvYRY8cHAkacKuUkdThuxmQKPAqwzKjwn90b3
         pFaKJX4bb8qwoLSbGMmsQoKh1kZ19C1ZWuXOm0ZgtN6un2bIXf08jv24BT7YX9FAu/US
         chalxcHZIfUN7I/ItpLl323UcwXnK62v7ZB4UjfHX3A8AEaX6CpREEZJTIy/+LfkCWGg
         wEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JMXZLGa1AbXsvKnZ90qPbpZuT0gz6jvkKk+0XYLpHYQ=;
        b=ZtoZ1myMyQS+Zcq/CfMDnwPDbuhUlw/0LY1Huqw9YyCQhCWTpMSD1bMK/frGHlwUvr
         zB3iZRryC3Etk3Gb2QEIxdTV3h/CE4Fn7Ry62KeUj6Nj5KFdSovIWZjgS9MMebizTKli
         2s8TYl9QQHvq9YEZZLt88QsHbD1PTMiYwsZJKJV1IL05lB+/ciEtngSoNrY2QhAmP7yn
         zb9bHy12k78m4v3/5XcredrcbFT17sOZoKsRnD6b8OWl7+V0Orx16PKjjH7BPpAQJbRq
         vAUr3Rq13qZLVtCY8gvKPjmwJ33xkorEk552LBTLuoS5hZQBv6VRfI/HtgQP5Tr2AGFU
         F4ew==
X-Gm-Message-State: APjAAAWY7gIBvmWahf7KQcLGwzJNeSc97D8X7MkUqhqgZWdqIFzamYMo
        FKxdkcRdYdDP9ky4ZtaPo2/hQXkRaFuqpw==
X-Google-Smtp-Source: APXvYqy1W9p+I9yyHFxr3/SoSUUG4bnd95AP/SUX1a/GkzaUpXrwN1XZFnzzQe7kcpUnUg+cAhh24w==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr712378plp.99.1554307687670;
        Wed, 03 Apr 2019 09:08:07 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i16sm26292857pgk.51.2019.04.03.09.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 09:08:06 -0700 (PDT)
Subject: Re: [PATCH] paride/pf: Fix potential NULL pointer dereference
To:     Yue Haibing <yuehaibing@huawei.com>, tim@cyberelk.net,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190403033707.8840-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e50f2958-6387-e06c-7e26-232ca161ee9e@kernel.dk>
Date:   Wed, 3 Apr 2019 10:08:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403033707.8840-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yLzE5IDk6MzcgUE0sIFl1ZSBIYWliaW5nIHdyb3RlOg0KPiBGcm9tOiBZdWVIYWli
aW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+IA0KPiBTeXprYWxsZXIgcmVwb3J0IHRo
aXM6DQo+IA0KPiBwZjogcGYgdmVyc2lvbiAxLjA0LCBtYWpvciA0NywgY2x1c3RlciA2NCwg
bmljZSAwDQo+IHBmOiBObyBBVEFQSSBkaXNrIGRldGVjdGVkDQo+IGthc2FuOiBDT05GSUdf
S0FTQU5fSU5MSU5FIGVuYWJsZWQNCj4ga2FzYW46IEdQRiBjb3VsZCBiZSBjYXVzZWQgYnkg
TlVMTC1wdHIgZGVyZWYgb3IgdXNlciBtZW1vcnkgYWNjZXNzDQo+IGdlbmVyYWwgcHJvdGVj
dGlvbiBmYXVsdDogMDAwMCBbIzFdIFNNUCBLQVNBTiBQVEkNCj4gQ1BVOiAwIFBJRDogOTg4
NyBDb21tOiBzeXotZXhlY3V0b3IuMCBUYWludGVkOiBHICAgICAgICAgQyAgICAgICAgNS4x
LjAtcmMzKyAjOA0KPiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlgg
KyBQSUlYLCAxOTk2KSwgQklPUyAxLjEwLjItMXVidW50dTEgMDQvMDEvMjAxNA0KPiBSSVA6
IDAwMTA6cGZfaW5pdCsweDdhZi8weDEwMDAgW3BmXQ0KPiBDb2RlOiA0NiA3NyBkMiA0OCA4
OSBkOCA0OCBjMSBlOCAwMyA4MCAzYyAyOCAwMCA3NCAwOCA0OCA4OSBkZiBlOCAwMyAyNSBh
NiBkMiA0YyA4YiAyMyA0OSA4ZCBiYyAyNCA4MCAwNSAwMCAwMCA0OCA4OSBmOCA0OCBjMSBl
OCAwMyA8ODA+IDNjIDI4IDAwIDc0IDA1IGU4IGU2IDI0IGE2IGQyIDQ5IDhiIGJjIDI0IDgw
IDA1IDAwIDAwIGU4IDc5IDM0DQo+IFJTUDogMDAxODpmZmZmODg4MWFiY2JmOTk4IEVGTEFH
UzogMDAwMTAyMDINCj4gUkFYOiAwMDAwMDAwMDAwMDAwMGIwIFJCWDogZmZmZmZmZmZjMWU0
YThhOCBSQ1g6IGZmZmZmZmZmYWVjNTA3ODgNCj4gUkRYOiAwMDAwMDAwMDAwMDM5YjEwIFJT
STogZmZmZmM5MDAwMTUzYzAwMCBSREk6IDAwMDAwMDAwMDAwMDA1ODANCj4gUkJQOiBkZmZm
ZmMwMDAwMDAwMDAwIFIwODogZmZmZmVkMTAzZWU0NGU1OSBSMDk6IGZmZmZlZDEwM2VlNDRl
NTkNCj4gUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogZmZmZmVkMTAzZWU0NGU1OCBSMTI6
IDAwMDAwMDAwMDAwMDAwMDANCj4gUjEzOiBmZmZmZmZmZmMxZTRiMDI4IFIxNDogMDAwMDAw
MDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMjANCj4gRlM6ICAwMDAwN2YxYjc4YTkx
NzAwKDAwMDApIEdTOmZmZmY4ODgxZjcyMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMA0KPiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUw
MDMzDQo+IENSMjogMDAwMDdmNmQ3MmIyMDdmOCBDUjM6IDAwMDAwMDAxZDU3OTAwMDQgQ1I0
OiAwMDAwMDAwMDAwNzYwNmYwDQo+IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAw
MDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IERSMzogMDAwMDAwMDAwMDAw
MDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IFBL
UlU6IDU1NTU1NTU0DQo+IENhbGwgVHJhY2U6DQo+ICA/IDB4ZmZmZmZmZmZjMWU1MDAwMA0K
PiAgZG9fb25lX2luaXRjYWxsKzB4YmMvMHg0N2QgaW5pdC9tYWluLmM6OTAxDQo+ICBkb19p
bml0X21vZHVsZSsweDFiNS8weDU0NyBrZXJuZWwvbW9kdWxlLmM6MzQ1Ng0KPiAgbG9hZF9t
b2R1bGUrMHg2NDA1LzB4OGMxMCBrZXJuZWwvbW9kdWxlLmM6MzgwNA0KPiAgX19kb19zeXNf
ZmluaXRfbW9kdWxlKzB4MTYyLzB4MTkwIGtlcm5lbC9tb2R1bGUuYzozODk4DQo+ICBkb19z
eXNjYWxsXzY0KzB4OWYvMHg0NTAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6MjkwDQo+ICBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJlDQo+IFJJUDogMDAzMzow
eDQ2MmU5OQ0KPiBDb2RlOiBmNyBkOCA2NCA4OSAwMiBiOCBmZiBmZiBmZiBmZiBjMyA2NiAw
ZiAxZiA0NCAwMCAwMCA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBkNiA0OCA4OSBjYSA0ZCA4
OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmIGZm
IDczIDAxIGMzIDQ4IGM3IGMxIGJjIGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAxIDQ4DQo+IFJT
UDogMDAyYjowMDAwN2YxYjc4YTkwYzU4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAw
MDAwMDAwMDAwMDAxMzkNCj4gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAw
MDczYmYwMCBSQ1g6IDAwMDAwMDAwMDA0NjJlOTkNCj4gUkRYOiAwMDAwMDAwMDAwMDAwMDAw
IFJTSTogMDAwMDAwMDAyMDAwMDE4MCBSREk6IDAwMDAwMDAwMDAwMDAwMDMNCj4gUkJQOiAw
MDAwN2YxYjc4YTkwYzcwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAw
MDAwMDANCj4gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBS
MTI6IDAwMDA3ZjFiNzhhOTE2YmMNCj4gUjEzOiAwMDAwMDAwMDAwNGJjZWZhIFIxNDogMDAw
MDAwMDAwMDZmNmZiMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDQNCj4gTW9kdWxlcyBsaW5rZWQg
aW46IHBmKCspIHBhcmlkZSBncGlvX3RwczY1MjE4IHRwczY1MjE4IGkyY19jaHRfd2MgYXRp
X3JlbW90ZSBkYzM5NXggYWN0X21ldGFfc2tidGNpbmRleCBhY3RfaWZlIGlmZSBlY2RoX2dl
bmVyaWMgcmNfeGJveF9kdmQgc2t5ODE0NTJfcmVndWxhdG9yIHY0bDJfZndub2RlIGxlZHNf
YmxpbmttIHNuZF91c2JfaGlmYWNlIGNvbWVkaShDKSBhZXNfdGkgc2xoYyBjZmlfY21kc2V0
XzAwMjAgbXRkIGNmaV91dGlsIHN4ODY1NCBtZGlvX2dwaW8gb2ZfbWRpbyBmaXhlZF9waHkg
bWRpb19iaXRiYW5nIGxpYnBoeSBhbGNvcl9wY2kgbWF0cml4X2tleW1hcCBoaWRfdWNsb2dp
YyB1c2JoaWQgc2NzaV90cmFuc3BvcnRfZmMgdmlkZW9idWYyX3Y0bDIgdmlkZW9idWYyX2Rt
YV9zZyBzbmRfc29jX3BjbTE3OXhfc3BpIHNuZF9zb2NfcGNtMTc5eF9jb2RlYyBpMmNfZGVt
dXhfcGluY3RybCBtZGV2IHNuZF9pbmRpZ29kaiBpc2w2NDA1IG1paSBlbmMyOGo2MCBjbWFj
IGFkdDczMTZfaTJjKEMpIGFkdDczMTYoQykgZm1jX3RyaXZpYWwgZm1jIG5mX3JlamVjdF9p
cHY0IGF1dGhlbmMgcmNfZHR0MjAwdSBydGNfZHMxNjcyIGR2Yl91c2JfZGlidXNiX21jIGR2
Yl91c2JfZGlidXNiX21jX2NvbW1vbiBkaWIzMDAwbWMgZGlieDAwMF9jb21tb24gZHZiX3Vz
Yl9kaWJ1c2JfY29tbW9uIGR2Yl91c2IgZHZiX2NvcmUgdmlkZW9idWYyX2NvbW1vbiB2aWRl
b2J1ZjJfdm1hbGxvYyB2aWRlb2J1ZjJfbWVtb3BzIHJlZ3VsYXRvcl9oYXB0aWMgYWRmNzI0
MiBtYWM4MDIxNTQgaWVlZTgwMjE1NCBzNWgxNDA5IGRhOTAzNF90cyBzbmRfaW50ZWw4eDBt
IHdtaSBjeDI0MTIwIHVzYmNvcmUgc2RoY2lfY2FkZW5jZSBzZGhjaV9wbHRmbSBzZGhjaSBt
bWNfY29yZSBqb3lkZXYgaTJjX2FsZ29fYml0IHNjc2lfdHJhbnNwb3J0X2lzY3NpIGlzY3Np
X2Jvb3Rfc3lzZnMgdmVzMTgyMCBsb2NrZCBncmFjZSBuZnNfYWNsIGF1dGhfcnBjZ3NzIHN1
bnJwDQo+ICBjDQo+ICBpcF92cyBzbmRfc29jX2FkYXU3MDAyIHNuZF9jczQyODEgc25kX3Jh
d21pZGkgZ2FtZXBvcnQgc25kX29wbDNfbGliIHNuZF9zZXFfZGV2aWNlIHNuZF9od2RlcCBz
bmRfYWM5N19jb2RlYyBhZDc0MTggaGlkX3ByaW1heCBoaWQgc25kX3NvY19jczQyNjUgc25k
X3NvY19jb3JlIHNuZF9wY21fZG1hZW5naW5lIHNuZF9wY20gc25kX3RpbWVyIGFjOTdfYnVz
IHNuZF9jb21wcmVzcyBzbmQgc291bmRjb3JlIHRpX2FkYzEwOHMxMDIgZWVwcm9tXzkzY3g2
IGkyY19hbGdvX3BjYSBtbHhyZWdfaG90cGx1ZyBzdF9wcmVzc3VyZSBzdF9zZW5zb3JzIGlu
ZHVzdHJpYWxpb190cmlnZ2VyZWRfYnVmZmVyIGtmaWZvX2J1ZiBpbmR1c3RyaWFsaW8gdjRs
Ml9jb21tb24gdmlkZW9kZXYgbWVkaWEgc25kX3NvY19hZGF1X3V0aWxzIHJjX3Bpbm5hY2xl
X2dyZXkgcmNfY29yZSBwcHNfZ3BpbyBsZWRzX2xtMzY5MnggbmFuZGNvcmUgbGVkdHJpZ19w
YXR0ZXJuIGlwdGFibGVfc2VjdXJpdHkgaXB0YWJsZV9yYXcgaXB0YWJsZV9tYW5nbGUgaXB0
YWJsZV9uYXQgbmZfbmF0IG5mX2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdf
aXB2NCBpcHRhYmxlX2ZpbHRlciBicGZpbHRlciBpcDZfdnRpIGlwX3Z0aSBpcF9ncmUgaXBp
cCBzaXQgdHVubmVsNCBpcF90dW5uZWwgaHNyIHZldGggbmV0ZGV2c2ltIHZ4Y2FuIGJhdG1h
bl9hZHYgY2ZnODAyMTEgcmZraWxsIGNobmxfbmV0IGNhaWYgbmxtb24gZHVtbXkgdGVhbSBi
b25kaW5nIHZjYW4gYnJpZGdlIHN0cCBsbGMgaXA2X2dyZSBncmUgaXA2X3R1bm5lbCB0dW5u
ZWw2IHR1biBtb3VzZWRldiBwcGRldiB0cG0ga3ZtX2ludGVsIGt2bSBpcnFieXBhc3MgY3Jj
dDEwZGlmX3BjbG11bCBjcmMzMl9wY2xtdWwgY3JjMzJjX2ludGVsIGdoYXNoX2NsbXVsbmlf
aW50ZWwgYWVzbmlfaW50ZWwgaWRlX3BjaV9nZW5lcmljIGFlc194ODZfNjQgcGlpeCBjcnlw
dG9fc2ltZCBpbnB1dF9sZWRzIHBzbW91c2UgY3J5cA0KPiAgdGQNCj4gIGdsdWVfaGVscGVy
IGlkZV9jb3JlIGludGVsX2FncCBzZXJpb19yYXcgaW50ZWxfZ3R0IGFncGdhcnQgYXRhX2dl
bmVyaWMgaTJjX3BpaXg0IHBhdGFfYWNwaSBwYXJwb3J0X3BjIHBhcnBvcnQgcnRjX2Ntb3Mg
ZmxvcHB5IHNjaF9mcV9jb2RlbCBpcF90YWJsZXMgeF90YWJsZXMgc2hhMV9zc3NlMyBzaGEx
X2dlbmVyaWMgaXB2NiBbbGFzdCB1bmxvYWRlZDogcGFyaWRlXQ0KPiBEdW1waW5nIGZ0cmFj
ZSBidWZmZXI6DQo+ICAgKGZ0cmFjZSBidWZmZXIgZW1wdHkpDQo+IC0tLVsgZW5kIHRyYWNl
IDdhODE4Y2Y1ZjIxMGQ3OWUgXS0tLQ0KPiANCj4gSWYgYWxsb2NfZGlzayBmYWlscyBpbiBw
Zl9pbml0X3VuaXRzLCBwZi0+ZGlzayB3aWxsIGJlDQo+IE5VTEwsIGhvd2V2ZXIgaW4gcGZf
ZGV0ZWN0IGFuZCBwZl9leGl0LCBpdCdzIG5vdCBjaGVjaw0KPiB0aGlzIGJlZm9yZSBmcmVl
Lkl0IG1heSByZXN1bHQgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+IA0KPiBBbHNv
IHdoZW4gcmVnaXN0ZXJfYmxrZGV2IGZhaWxlZCwgYmxrX2NsZWFudXBfcXVldWUoKSBhbmQN
Cj4gYmxrX21xX2ZyZWVfdGFnX3NldCgpIHNob3VsZCBiZSBjYWxsZWQgdG8gZnJlZSByZXNv
dXJjZXMuDQoNCkFwcGxpZWQsIHRoYW5rcy4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
