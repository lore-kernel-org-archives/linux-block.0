Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFCC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00E2075C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 09:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="mEHCst8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfC0Jy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:54:26 -0400
Received: from m13-68.163.com ([220.181.13.68]:12076 "EHLO m13-68.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfC0Jy0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 05:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=7GSXx
        uT0CRFKEw8oXRKRG77jQKPHPJO7Ld6zXEqcU8Y=; b=mEHCst8ToB6+3/tTynVSJ
        qxPKZoMJ0EJd7WoTKQ4fPhLSsgk9win3Kgpp6zkABjW8jjotuzhm0gYVRBmgRaOe
        gXtqqvP8wfcRrDMNvoI13BGPcq0hNGFNK8qjfYSBsCpaGv0Tu81JuwZ+oMhmynen
        FydzXbth8EZHhXBFQZDqS8=
Received: from luferry$163.com ( [42.120.75.132] ) by ajax-webmail-wmsvr68
 (Coremail) ; Wed, 27 Mar 2019 17:53:49 +0800 (CST)
X-Originating-IP: [42.120.75.132]
Date:   Wed, 27 Mar 2019 17:53:49 +0800 (CST)
From:   luferry <luferry@163.com>
To:     "Dongli Zhang" <dongli.zhang@oracle.com>
Cc:     "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>,
        "Ming Lei" <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] make blk_mq_map_queues more friendly for cpu
 topology
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 163com
In-Reply-To: <8e02b730-b504-50a2-64e6-72817b07e93d@oracle.com>
References: <20190325152640.48120-1-luferry@163.com>
 <20190326073954.GD21617@lst.de>
 <48ca2186.fc76.169b8fef63a.Coremail.luferry@163.com>
 <20190327081619.GG20525@lst.de>
 <764f3c.12445.169be70834b.Coremail.luferry@163.com>
 <8e02b730-b504-50a2-64e6-72817b07e93d@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6acbcebd.13280.169be91f175.Coremail.luferry@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RMGowABXCectSJtcosEiAA--.22088W
X-CM-SenderInfo: poxiv2lu16il2tof0z/xtbBoQ+EWlQHEINdGAACs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cj4KPlRoZXJlIGlzIGxhY2sgb2YgdmVjdG9yIGlzc3VlIHdoZW4gbnVtYmVyIG9mIHF1ZXVlcyBp
cyBtb3JlIHRoYW4gbWF4Y3B1cyBhcyB3ZWxsLgo+Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sL2U0YWZlNGM1LTAyNjItNDUwMC1hZWVjLTYwZjMwNzM0YjRmY0BkZWZhdWx0Cj4KPkkgd2Fz
IGdvaW5nIHRvIHNlbmQgb3V0IHBhdGNoIHRvIGZpeCB0aGF0IHNwZWNpZmljIGNhc2Ugb24gdmly
dGlvIHNpZGUuCj4KPkJUVywgaXMgeW91ciBWTSdzIHZpcnRpbyBtbWlvIGJhc2VkIG9yIHBjaSBi
YXNlZD8KPgo+QXMgbWVudGlvbmVkIGluIHByZXZpb3VzIGVtYWlsLCB3aGVuIEkgd2FzIHBsYXlp
bmcgd2l0aCBmaXJlY3JhY2tlciBieSBhbWF6b24sCj50aGUgdmlydGlvLWJsayBpcyBtbWlvIGJh
c2VkLiBOb3Qgc3VyZSBpZiB0aGF0IHdvdWxkIGxlYWQgdG8gdGhlIGxhY2sgb2YgdmVjdG9yCj5p
c3N1ZS4KPgo+RG9uZ2xpIFpoYW5nCgpJdCdzIHBjaSBiYXNlZC4g
