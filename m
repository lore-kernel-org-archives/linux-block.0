Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4318C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4B520830
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfDJNuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:50:35 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.116]:59218 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728553AbfDJNue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 09:50:34 -0400
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-east-1.aws.symcld.net id 3C/8B-24715-8A4FDAC5; Wed, 10 Apr 2019 13:50:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRWlGSWpSXmKPExsXi5LtOQHfFl7U
  xBo9PSlusvtvPZrH3lrbFomWtzBYTfl9gs3j/4zq7A6vHzll32T0uny31mH33B6PH501yASxR
  rJl5SfkVCawZaxbdZCn4wVbRtfcyewPjG7YuRi4OIYG9jBKzug4ydjFycrAJGEqc2/KWHcQWE
  dCS2Nz0khmkiFlgCqPE4sWtLF2MHBzCAgoST1fpQNQoSvx4dgysRkRgGaPEr8vNbCAJFgFViU
  0HXjKB2LwC1hL/26aCDRUSqJXY+e8KK4jNKWAj8Wx6A9hiRgExie+n1oDVMwuIS9x6Mh/MlhA
  QkFiy5zwzhC0q8fLxP1YIW15izq3T7CD3MAtoSqzfpQ/Rai5x9n8PC4StKDGl+yE7xAmCEidn
  PmGZwCgyC8mGWQjds5B0z0LSPQtJ9wJG1lWMZklFmekZJbmJmTm6hgYGuoaGRromuoYmBnqJV
  brJeqXFuqmJxSW6hnqJ5cV6xZW5yTkpenmpJZsYgZGYUsDSs4Px2NL0Q4ySHExKorx5d9bGCP
  El5adUZiQWZ8QXleakFh9ilOHgUJLgXfIZKCdYlJqeWpGWmQNMCTBpCQ4eJRHeLpA0b3FBYm5
  xZjpE6hSjJceBRQ/nMnPMuP8MSL49+HwusxBLXn5eqpQ47/dPQA0CIA0ZpXlw42Bp6xKjrJQw
  LyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4ZIGt5MvNK4La+AjqICeigKTqrQQ4qSURISTUwLhacU
  ziXy/jetYA9iZcEvq1Oas09caD0zkcW7Xnn/lvUV9/1EF6seVjY6ozFyUdG+UE/K9fNv2sr3/
  b7I9csPstfpw4cmdO0S910prdK/YTZBlPMM99M3V7FJF4tGdyePDt0pg2j0/cJ3vuPnvaw2RZ
  r1JDP9NP52661AoGet9a+Xtl1w/ORrRJLcUaioRZzUXEiAOCpg91WAwAA
X-Env-Sender: Seth.Bollinger@digi.com
X-Msg-Ref: server-14.tower-405.messagelabs.com!1554904232!7302049!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20230 invoked from network); 10 Apr 2019 13:50:32 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-14.tower-405.messagelabs.com with SMTP; 10 Apr 2019 13:50:32 -0000
Received: from MTK-SMS-XCH01.digi.com ([fe80::cca7:5299:c88e:1c40]) by
 MCL-VMS-XCH01.digi.com ([fe80::5587:821d:f8e4:6578%13]) with mapi id
 14.03.0439.000; Wed, 10 Apr 2019 08:50:32 -0500
From:   "Bollinger, Seth" <Seth.Bollinger@digi.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: Bug: VHCI + USB 3.0
Thread-Topic: Bug: VHCI + USB 3.0
Thread-Index: AQHU6+SEgulXK6TzJ0OKPp0lJzg2fKYuYXeAgAAIH4CAAS7ugIAABkMAgAADKICAAuoyAIAAH+eAgAAgmYCAAA8VAIAAEicAgAAIsQCAAANzgIABLpUAgAAiuYCAAAo4gIAANTmAgAAB4QCAATgfAA==
Date:   Wed, 10 Apr 2019 13:50:31 +0000
Message-ID: <D5C0CBE7-AD66-4CF6-AD7D-2A0064FDA464@digi.com>
References: <Pine.LNX.4.44L0.1904091429330.1599-100000@iolanthe.rowland.org>
 <6FA377F5-595C-4197-850C-5DD8C1B172D5@digi.com>
In-Reply-To: <6FA377F5-595C-4197-850C-5DD8C1B172D5@digi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.81.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC5C181B71DE146BB5ECBF73AD00E6D@digi.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBPbiBBcHIgOSwgMjAxOSwgYXQgMjoxMyBQTSwgQm9sbGluZ2VyLCBTZXRoIDxTZXRoLkJvbGxp
bmdlckBkaWdpLmNvbTxtYWlsdG86U2V0aC5Cb2xsaW5nZXJAZGlnaS5jb20+PiB3cm90ZToNCj4N
Cj4gPiBTZXRoLCB5b3UgY2FuIHRyeSBhZGRpbmc6DQo+ID4NCj4gPiAgYmxrX3F1ZXVlX3ZpcnRf
Ym91bmRhcnkoc2Rldi0+cmVxdWVzdF9xdWV1ZSwgMTAyNCAtIDEpDQo+ID4NCj4gPiBpbiBkcml2
ZXJzL3VzYi9zdG9yYWdlL3Njc2lnbHVlLmM6c2xhdmVfYWxsb2MoKSwganVzdCBhZnRlciB0aGUg
Y2FsbCB0bw0KPiA+IGJsa19xdWV1ZV91cGRhdGVfZG1hX2FsaWdubWVudCgpLiAgUGVyaGFwcyB0
aGF0IHdpbGwgaGVscA0KPiA+DQo+DQo+IEkgd2lsbCBkbyB0aGF0IGFzIGEgdGVzdC4gIEhvd2V2
ZXIsIEnigJltIGNvbmNlcm5lZCB0aGF0IHdl4oCZcmUgc29sdmluZyBvbmx5IGEgc3BlY2lmaWMg
Y2FzZS4gIFdvbuKAmXQgaXQgZmFpbCBpbiBhIHNpbWlsYXIgd2F5IGlmIGEgZGlmZmVyZW50IHN1
YnN5c3RlbSBkb2VzIHRoZSBzYW1lIHRoaW5nIChVU0IgbW9kZW0gb3IgPiB2aWRlbyBkcml2ZXJz
LCBldGMuKT8NCg0KSnVzdCB0byBmb2xsb3cgdXAsIHRoaXMgZG9lcyBzZWVtIHRvIHNvbHZlIHRo
ZSBzcGVjaWZpYyBwcm9ibGVtLg0KDQpTZXRoDQo=
