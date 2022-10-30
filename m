Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E70FC38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 08:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ3Ify (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Ifx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 04:35:53 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E9E120;
        Sun, 30 Oct 2022 01:35:51 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 30 Oct 2022 16:35:42
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Sun, 30 Oct 2022 16:35:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Re: [RESEND PATCH v2 3/3] block: hide back
 blk_freeze_queue_start and export its blk-mq alias
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221030082130.GA4930@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn>
 <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
 <20221030074010.GD4131@lst.de>
 <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
 <20221030082130.GA4930@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2e53c763.15296d.1842808478d.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgAnYvxeN15jL6yfBw--.50915W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKYKQAEsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiA+IEkgYWdyZWUgdGhhdCB0aGUgZnJlZXppbmcgc3R1ZmYgKG1heWJlIGFsc28gdGhlIHF1aWVz
Y2luZyBzdHVmZikgc2hvdWxkCj4gPiBtb3ZlIG91dCBvZiB0aGUgbXEgbmFtZXNwYWNlLiBJZiBu
b3cgaXMgbm90IHRoZSBwcm9wZXIgdGltZSwgSSdsbCBsZWF2ZQo+ID4gdGhlbSBhbG9uZS4gSSds
bCByZXNlbmQgcGF0Y2ggMSBhbG9uZSB3aXRob3V0IHRoZSBjb21tZW50Lgo+IAo+IFRoZSBxdWll
c2NlIGFjdHVhbGx5IGlzIGVudGlyZWx5IGJsay1tcSBzcGVjaWZpYywgd2hpY2gganVzdCBoYXZl
IHNvbWUKPiBjYXJlbGVzcyBjYWxsZXJzLgoKR290IGl0LCB0aGFuayB5b3UhCgpUaGFua3MhCkpp
bmxvbmcgQ2hlbgo=
