Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB3C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 13:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450BC218EA
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 13:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfBNNbk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:31:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436702AbfBNNbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 08:31:40 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guH6s-0007BW-Ey; Thu, 14 Feb 2019 14:31:26 +0100
Date:   Thu, 14 Feb 2019 14:31:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?GB2312?B?s8K7qrLF?= <chenhc@lemote.com>
cc:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <tencent_6460D33741AF25B57E7BE493@qq.com>
Message-ID: <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com> <20190213105041.13537-2-ming.lei@redhat.com> <20190213150407.GB96272@google.com> <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de> <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de> <20190213223711.GC8027@localhost.localdomain> <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de> <tencent_6460D33741AF25B57E7BE493@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-190354540-1550151086=:1561"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-190354540-1550151086=:1561
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Feb 2019, 陈华才 wrote:

Please do not top post....

> I'll test next week, but 4.19 has the same problem, how to fix that for 4.19?

By applying the very same patch perhaps?

Thanks,

	tglx
--8323329-190354540-1550151086=:1561--
