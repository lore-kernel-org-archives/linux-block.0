Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E392C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41D220856
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 08:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="EKNQhc84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfCZIGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:06:51 -0400
Received: from m13-37.163.com ([220.181.13.37]:4176 "EHLO m13-37.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfCZIGv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 04:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=e0SYl
        +G2gMP2T47fr0R5SU8lscsVUcNOWxUkH+DbRw4=; b=EKNQhc84CAjzx6FAv0vuB
        vDJ3PlkCdVJ5QlU0Y5TeXOgoboOwkHUa2kzPq0oXY9p+ChlB5I0zJJWbnE9kfVq3
        L8FTj8iSUX+JmKEWDWISaKl8nszwhc6b0mUak7sNKz6umOHAt014vYSmjedPFw4l
        Q0DCjrGKly3RdGiW0WOOdg=
Received: from luferry$163.com ( [42.120.75.143] ) by ajax-webmail-wmsvr37
 (Coremail) ; Tue, 26 Mar 2019 15:55:10 +0800 (CST)
X-Originating-IP: [42.120.75.143]
Date:   Tue, 26 Mar 2019 15:55:10 +0800 (CST)
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
In-Reply-To: <20190326073954.GD21617@lst.de>
References: <20190325152640.48120-1-luferry@163.com>
 <20190326073954.GD21617@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <48ca2186.fc76.169b8fef63a.Coremail.luferry@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: JcGowADX5gTf2plcf9kfAA--.38729W
X-CM-SenderInfo: poxiv2lu16il2tof0z/xtbBLwWDWlUMIcBO4gACsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CgoKQXQgMjAxOS0wMy0yNiAxNTozOTo1NCwgIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGxzdC5k
ZT4gd3JvdGU6Cj5XaHkgaXNuJ3QgdGhpcyB1c2luZyB0aGUgYXV0b21hdGljIFBDSS1sZXZlbCBh
ZmZpbml0eSBhc3NpZ25tZW50IHRvCj5zdGFydCB3aXRoPwoKV2hlbiBlbmFibGUgdmlydGlvLWJs
ayB3aXRoIG11bHRpIHF1ZXVlcyBidXQgd2l0aCBvbmx5IDIgbXNpeC12ZWN0b3IuCnZwX2Rldi0+
cGVyX3ZxX3ZlY3RvcnMgd2lsbCBiZSBmYWxzZSwgdnBfZ2V0X3ZxX2FmZmludGl0eSB3aWxsIHJl
dHVybiBOVUxMIGRpcmVjdGx5CnNvIGJsa19tcV92aXJ0aW9fbWFwX3F1ZXVlcyB3aWxsIGZhbGxi
YWNrIHRvIGJsa19tcV9tYXBfcXVldWVzLgoKCjQ0OCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqdnBf
Z2V0X3ZxX2FmZmluaXR5KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBpbnQgaW5kZXgpCjQ0
OSB7CjQ1MCAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZp
Y2UodmRldik7CjQ1MQo0NTIgICAgIGlmICghdnBfZGV2LT5wZXJfdnFfdmVjdG9ycyB8fAo0NTMg
ICAgICAgICB2cF9kZXYtPnZxc1tpbmRleF0tPm1zaXhfdmVjdG9yID09IFZJUlRJT19NU0lfTk9f
VkVDVE9SKQo0NTQgICAgICAgICByZXR1cm4gTlVMTDsKNDU1CjQ1NiAgICAgcmV0dXJuIHBjaV9p
cnFfZ2V0X2FmZmluaXR5KHZwX2Rldi0+cGNpX2RldiwKNDU3ICAgICAgICAgICAgICAgICAgICAg
dnBfZGV2LT52cXNbaW5kZXhdLT5tc2l4X3ZlY3Rvcik7CjQ1OCB9CgogMzIgaW50IGJsa19tcV92
aXJ0aW9fbWFwX3F1ZXVlcyhzdHJ1Y3QgYmxrX21xX3F1ZXVlX21hcCAqcW1hcCwKIDMzICAgICAg
ICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIGludCBmaXJzdF92ZWMpCiAzNCB7CiAzNSAg
ICAgY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1hc2s7CiAzNiAgICAgdW5zaWduZWQgaW50IHF1ZXVl
LCBjcHU7CiAzNwogMzggICAgIGlmICghdmRldi0+Y29uZmlnLT5nZXRfdnFfYWZmaW5pdHkpCiAz
OSAgICAgICAgIGdvdG8gZmFsbGJhY2s7CiA0MAogNDEgICAgIGZvciAocXVldWUgPSAwOyBxdWV1
ZSA8IHFtYXAtPm5yX3F1ZXVlczsgcXVldWUrKykgewogNDIgICAgICAgICBtYXNrID0gdmRldi0+
Y29uZmlnLT5nZXRfdnFfYWZmaW5pdHkodmRldiwgZmlyc3RfdmVjICsgcXVldWUpOyAvL3ZwX2dl
dF92cV9hZmZpbml0eSByZXR1cm4gTlVMTAogNDMgICAgICAgICBpZiAoIW1hc2spCiA0NCAgICAg
ICAgICAgICBnb3RvIGZhbGxiYWNrOwogNDUKIDQ2ICAgICAgICAgZm9yX2VhY2hfY3B1KGNwdSwg
bWFzaykKIDQ3ICAgICAgICAgICAgIHFtYXAtPm1xX21hcFtjcHVdID0gcW1hcC0+cXVldWVfb2Zm
c2V0ICsgcXVldWU7CiA0OCAgICAgfQogNDkKIDUwICAgICByZXR1cm4gMDsKIDUxIGZhbGxiYWNr
OgogNTIgICAgIHJldHVybiBibGtfbXFfbWFwX3F1ZXVlcyhxbWFwKTsKIDUzIH0KCmhlcmUgaXMg
cHJldmlvdXMgZGlzY3Vzc2lvbgpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEw
ODY1NDYxLyAK
