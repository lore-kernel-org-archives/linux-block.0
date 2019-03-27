Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210ACC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 09:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7C12075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 09:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="kRlm4b3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfC0Jcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:32:45 -0400
Received: from m13-68.163.com ([220.181.13.68]:60379 "EHLO m13-68.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfC0Jcp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 05:32:45 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 05:32:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=G5oi1
        9ZA0X4816eHrENqAbN3PPrrhPtsFymGAe9GwJY=; b=kRlm4b3SDDkrFIGYUQLpr
        8EiEEytZ11lpCVUdnwlylW5tpOZK0lA1xRmwh9rouxZYhhT39DcrIvTafqMrEIrv
        rIo/b9DyoejisWoQTRqckWjB4jGUfNiO5kOiJyo1XjTcGF77N9ph7srOgr7Xln0p
        sag++0+0K6ygsqWPzL390o=
Received: from luferry$163.com ( [42.120.75.132] ) by ajax-webmail-wmsvr68
 (Coremail) ; Wed, 27 Mar 2019 17:17:18 +0800 (CST)
X-Originating-IP: [42.120.75.132]
Date:   Wed, 27 Mar 2019 17:17:18 +0800 (CST)
From:   luferry <luferry@163.com>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Jens Axboe" <axboe@kernel.dk>,
        "Dongli Zhang" <dongli.zhang@oracle.com>,
        "Ming Lei" <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] make blk_mq_map_queues more friendly for cpu
 topology
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 163com
In-Reply-To: <20190327081619.GG20525@lst.de>
References: <20190325152640.48120-1-luferry@163.com>
 <20190326073954.GD21617@lst.de>
 <48ca2186.fc76.169b8fef63a.Coremail.luferry@163.com>
 <20190327081619.GG20525@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <764f3c.12445.169be70834b.Coremail.luferry@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RMGowACnB+WeP5tc06siAA--.37485W
X-CM-SenderInfo: poxiv2lu16il2tof0z/1tbitB+EWlSIbM+hQwACsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CgoKQWN0dWFsbHksICBJIGp1c3QgYm91Z2h0IG9uZSB2bSBmcm9tIHB1YmxpYyBjbG91ZCBwcm92
aWRlciBhbmQgcnVuIGludG8gdGhpcyBwcm9ibGVtLgphZnRlciByZWFkaW5nIGNvZGUgYW5kIGNv
bXBhcmUgcGNpIGRldmljZSBpbmZvLCBJIHJlcHJvZHVjZSB0aGlzIHNjZW5hcmlvLgoKU2luY2Ug
Y29tbW9uIHVzZXJzIGNhbm5vdCBjaGFuZ2UgbXNpIHZlY3RvciBudW1iZXJzLCBzbyBJIHN1Z2dl
c3QgYmxrX21xX21hcF9xdWV1ZXMgdG8gYmUgCm1vcmUgZnJpZW5kbHkuIGJsa19tcV9tYXBfcXVl
dWVzIG1heSBiZSB0aGUgIGxhc3QgY2hvaWNlLiAKCgoKCgpBdCAyMDE5LTAzLTI3IDE2OjE2OjE5
LCAiQ2hyaXN0b3BoIEhlbGx3aWciIDxoY2hAbHN0LmRlPiB3cm90ZToKPk9uIFR1ZSwgTWFyIDI2
LCAyMDE5IGF0IDAzOjU1OjEwUE0gKzA4MDAsIGx1ZmVycnkgd3JvdGU6Cj4+IAo+PiAKPj4gCj4+
IEF0IDIwMTktMDMtMjYgMTU6Mzk6NTQsICJDaHJpc3RvcGggSGVsbHdpZyIgPGhjaEBsc3QuZGU+
IHdyb3RlOgo+PiA+V2h5IGlzbid0IHRoaXMgdXNpbmcgdGhlIGF1dG9tYXRpYyBQQ0ktbGV2ZWwg
YWZmaW5pdHkgYXNzaWdubWVudCB0bwo+PiA+c3RhcnQgd2l0aD8KPj4gCj4+IFdoZW4gZW5hYmxl
IHZpcnRpby1ibGsgd2l0aCBtdWx0aSBxdWV1ZXMgYnV0IHdpdGggb25seSAyIG1zaXgtdmVjdG9y
Lgo+PiB2cF9kZXYtPnBlcl92cV92ZWN0b3JzIHdpbGwgYmUgZmFsc2UsIHZwX2dldF92cV9hZmZp
bnRpdHkgd2lsbCByZXR1cm4gTlVMTCBkaXJlY3RseQo+PiBzbyBibGtfbXFfdmlydGlvX21hcF9x
dWV1ZXMgd2lsbCBmYWxsYmFjayB0byBibGtfbXFfbWFwX3F1ZXVlcy4KPgo+V2hhdCBpcyB0aGUg
cG9pbnQgb2YgdGhlIG11bHRpcXVldWUgbW9kZSBpZiB5b3UgZG9uJ3QgaGF2ZSBlbm91Z2gKPih2
aXJ0dWFsKSBNU0ktWCB2ZWN0b3JzPwo=
