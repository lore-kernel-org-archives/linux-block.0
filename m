Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D2CC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 21:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6E321019
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbfAVVFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:05:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60753 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfAVVFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 16:05:00 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gm3Dv-0008WA-UN; Tue, 22 Jan 2019 22:04:44 +0100
Date:   Tue, 22 Jan 2019 22:04:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Huacai Chen <chenhuacai@gmail.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Michael Hernandez <michael.hernandez@cavium.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] genirq/affinity: Assign default affinity to pre/post
 vectors
In-Reply-To: <CAAhV-H7=E_uwvGJF5-J7r0LLG4-=MEqOSnyR6ajThp8Qy0UUdg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901222150300.1628@nanos.tec.linutronix.de>
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com> <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de> <tencent_7CB943266ADCFDB06DDDE6EF@qq.com> <alpine.DEB.2.21.1901161016270.1655@nanos.tec.linutronix.de> <tencent_0985E6EE28C337614825A2C1@qq.com>
 <CAAhV-H7=E_uwvGJF5-J7r0LLG4-=MEqOSnyR6ajThp8Qy0UUdg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Chen,

On Fri, 18 Jan 2019, Huacai Chen wrote:
> > > I did not say that you removed all NULL returns. I said that this function
> > > can return NULL for other reasons and then the same situation will happen.
> > >
> > > If the masks pointer returned is NULL then the calling code or any
> > > subsequent usage needs to handle it properly. Yes, I understand that this
> > > change makes the warning go away for that particular case, but that's not
> > > making it any more correct.
> 
> Hi, Thomas,
> 
> I don't think "nvecs == affd->pre_vectors + affd->post_vectors" is an ERROR,
> so it should be different with "return NULL for other reasons" to the caller. If
> the caller fallback from MSI-X to MSI, it is probably "nvecs=1,pre_vectors=1,
> post_vectors=0". The caller can work perfectly, if pre/post vectors are filled
> with the default affinity.

This is not about 'works'. This is about correctness. So again:

The semantics of that function is, that it returns NULL on error. The
reason for this NULL return is entirely irrelevant for the moment.

  If the calling code or any subsequent code proceeds as if nothing
  happened and later complains about it being NULL, then that logic at the
  calling or subsequent code is broken.

  And just making one particular error case not return NULL does not make
  it less broken because the function still can return NULL. So that
  proposed 'fix' is sunshine programming at best.

Now for the change you are proposing. It's semantically wrong in the face
of multiqueue devices. You are trying to make exactly one particular corner
case "work" by some dubious definition of work:

     nvecs=1,pre_vectors=1,post_vectors=0

If pre + post != 1 then this still returns NULL and the same wreckage
happens again.

The point is that if there are not enough vectors to have at least one
queue vector aside of pre and post then the whole queue management logic
does not make any sense. This needs to be fixed elsewhere and not duct tape
in the core logic with the argument 'works for me'.

Thanks,

	tglx


