Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576EC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF8C2084F
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDITN2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:13:28 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.210]:54237 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfDITN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 15:13:28 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-west-2.aws.symcld.net id 6A/CF-24550-5DEECAC5; Tue, 09 Apr 2019 19:13:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRWlGSWpSXmKPExsXi5LtOQPfquzU
  xBvu3KlmsvtvPZrH3lrbFomWtzBYTfl9gs3j/4zq7A6vHzll32T0uny31mH33B6PH501yASxR
  rJl5SfkVCawZb75vZCx4wVLx/s5/xgbGByxdjFwcQgKrGCWefTvLCuHsYZR4e3s7cxcjJwebg
  KHEuS1v2UFsEQEtic1NL5lBipgFpjBKLF7cCtTOwSEsoCDxdJUORI2ixI9nx8BqRATmMUpM2r
  yeFSTBIqAicXX9PkaQel4Ba4nGrd4gYSEBH4kJh1uYQGxOAV+JI4/PsYHYjAJiEt9PrQGLMwu
  IS9x6Mh/MlhAQkFiy5zwzhC0q8fLxP1YIW17i+afF7CDjmQU0Jdbv0odoNZfY9Pg4C4StKDGl
  +yHYK7wCghInZz4Bu14I6LI5G7QmMIrNQrJsFsKgWUgGzUIyaBaSQQsYWVcxWiQVZaZnlOQmZ
  uboGhoY6BoaGukaGlvoGhlb6CVW6SbrlRbrlqcWl+ga6SWWF+sVV+Ym56To5aWWbGIExm5KQd
  e7HYxnFqUfYpTkYFIS5XW4sSZGiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTv/bdAOcGi1PTUirT
  MHGASgUlLcPAoifC+BEnzFhck5hZnpkOkTjFachxY9HAuM8eM+8+A5NuDz+cyC7Hk5eelSonz
  sgFTlZAASENGaR7cOFiiu8QoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcFyFqezLwSuK2vg
  A5iAjpois5qkINKEhFSUg2MRvZK+o8/Hra5dMnq5ba9er+L+WVmbzw71W7Knaln+x5J/MhOMV
  M8Fv6nJPm657m9G/zvFJ355ZvtZamsZ/5a4tjq3E7+iuDztWHRiXcyCvsOPZAqWGx9xrjBNcb
  y0hdxlzNuWysC6lKTbBfXrdgeXpe8772HPBfHnXu2Jl79K+L+mbB97JqkxFKckWioxVxUnAgA
  OAAJKG8DAAA=
X-Env-Sender: Seth.Bollinger@digi.com
X-Msg-Ref: server-13.tower-365.messagelabs.com!1554837205!7084780!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12689 invoked from network); 9 Apr 2019 19:13:25 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-13.tower-365.messagelabs.com with SMTP; 9 Apr 2019 19:13:25 -0000
Received: from MTK-SMS-XCH02.digi.com (10.10.8.196) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 9 Apr 2019
 14:13:24 -0500
Received: from MTK-SMS-XCH01.digi.com ([fe80::cca7:5299:c88e:1c40]) by
 MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb%20]) with mapi id
 14.03.0439.000; Tue, 9 Apr 2019 14:13:24 -0500
From:   "Bollinger, Seth" <Seth.Bollinger@digi.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: Bug: VHCI + USB 3.0
Thread-Topic: Bug: VHCI + USB 3.0
Thread-Index: AQHU6+SEgulXK6TzJ0OKPp0lJzg2fKYuYXeAgAAIH4CAAS7ugIAABkMAgAADKICAAuoyAIAAH+eAgAAgmYCAAA8VAIAAEicAgAAIsQCAAANzgIABLpUAgAAiuYCAAAo4gIAANTmAgAAB4QA=
Date:   Tue, 9 Apr 2019 19:13:23 +0000
Message-ID: <6FA377F5-595C-4197-850C-5DD8C1B172D5@digi.com>
References: <Pine.LNX.4.44L0.1904091429330.1599-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904091429330.1599-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.30.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <585F314CC9869C488AFDBEA1D875F6D5@digi.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBTZXRoLCB5b3UgY2FuIHRyeSBhZGRpbmc6DQo+DQo+ICBibGtfcXVldWVfdmlydF9ib3VuZGFy
eShzZGV2LT5yZXF1ZXN0X3F1ZXVlLCAxMDI0IC0gMSkNCj4NCj4gaW4gZHJpdmVycy91c2Ivc3Rv
cmFnZS9zY3NpZ2x1ZS5jOnNsYXZlX2FsbG9jKCksIGp1c3QgYWZ0ZXIgdGhlIGNhbGwgdG8NCj4g
YmxrX3F1ZXVlX3VwZGF0ZV9kbWFfYWxpZ25tZW50KCkuICBQZXJoYXBzIHRoYXQgd2lsbCBoZWxw
DQo+DQoNCkkgd2lsbCBkbyB0aGF0IGFzIGEgdGVzdC4gIEhvd2V2ZXIsIEnigJltIGNvbmNlcm5l
ZCB0aGF0IHdl4oCZcmUgc29sdmluZyBvbmx5IGEgc3BlY2lmaWMgY2FzZS4gIFdvbuKAmXQgaXQg
ZmFpbCBpbiBhIHNpbWlsYXIgd2F5IGlmIGEgZGlmZmVyZW50IHN1YnN5c3RlbSBkb2VzIHRoZSBz
YW1lIHRoaW5nIChVU0IgbW9kZW0gb3IgdmlkZW8gZHJpdmVycywgZXRjLik/DQoNClNldGgNCg0K
