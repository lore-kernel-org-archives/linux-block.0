Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C6C83F17
	for <linux-block@archiver.kernel.org>; Thu, 31 Aug 2023 09:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjHaJDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHaJDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 05:03:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED189CED;
        Thu, 31 Aug 2023 02:03:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693472609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DqmEc/FX/P+lcCR70f8LkIeHEIRHTdDQ2F7hhsMmf0=;
        b=hschOS8pFrS8BxfZyRmLmeNkCrKn61a6PjP7cP2iRhqW01gm2/ffKPnFc69zBB83B6dfyD
        p0B1cUzxOWAkMSLA+4pmRqW0lf4sILwDqMuEQOS5QiKYfZSVSLiGpSGczUPu8bCAJSfFOb
        L+JIeT2GcHxVZ0vmHiVqKykRT6wfQydr5Dar0LGTI5AxuFNBmDFccgiG02HXaR76X3HaN5
        6tAcfCFRjYwP323nMYWJnWKorRJpdrY/rbtFNNaCHrQ+VN+MgXotkKO5IJ92Yu/65YXe5O
        kweLhfsJqhdlLnfpbLDx4PByLcvVjHVVh1SD+kbcz+Y4ae4qfrhmFJFFSwHlZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693472609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DqmEc/FX/P+lcCR70f8LkIeHEIRHTdDQ2F7hhsMmf0=;
        b=wGvNhW6kQAjCGvpRjzaPw3AFq5CZfF5xsWNZOKUeExtca5ekTeP+TyUFKUfku98vahY6+y
        +MrCDltFAqcmUgDw==
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
In-Reply-To: <ZPBLy41y0NQTJ6Bw@fedora>
References: <20230818140145.1229805-1-ming.lei@redhat.com>
 <87edjk5st8.ffs@tglx> <ZPBLy41y0NQTJ6Bw@fedora>
Date:   Thu, 31 Aug 2023 11:03:29 +0200
Message-ID: <87zg274m8u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming!

On Thu, Aug 31 2023 at 16:15, Ming Lei wrote:
> On Wed, Aug 30, 2023 at 07:44:03PM +0200, Thomas Gleixner wrote:
> There isn't difference compared with holding cpu hotplug lock, because
> the cpu hp state is always changed even though cpu_present_mask isn't
> updated with the lock.

Updates to cpu_present_mask happen with the cpus lock write locked:

acpi_processor_hotadd_init()
  cpu_maps_update_begin()
  cpus_write_lock()
  acpi_map_cpu()
    generic_processor_info()
      set_cpu_present(cpu, true);

The only CPU mask which is lockless race free accessible is
cpus_possible_mask because that one is set up at boot once and never
modified afterwards.

> And all CPUs are always covered during the spread, the difference
> is just that it is done in 1st stage or 2nd stage.

I'm not objecting against the approach per se. It just needs proper
documentation why this is correct.

Thanks,

        tglx
