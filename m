Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB9CC00144
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 02:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiHBC7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Aug 2022 22:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiHBC7l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2022 22:59:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D461EAC6
        for <linux-block@vger.kernel.org>; Mon,  1 Aug 2022 19:59:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lxfps6kYYz4wgm;
        Tue,  2 Aug 2022 12:59:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659409174;
        bh=o02elc7vcNifhbeV3coWloUDHcopIpvkM7Sh6wZduJQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UrWkb5nTr93L1+2TQ9PQl2iZx/Fzjtdrx6s93rWczHt611MG6Twzd2CO2B+kcNB/M
         jqIS9IexzMsczBWfTWaGYzPzrnhvrQ6w2PUBmVvnVz73eIwJ0UIQUSsv9OqMlAaYWu
         4e/o+cwNp6UzDl8y831lQ+5+HDTWQK5jVO12NHND0/FSNIGiOsFQ8vHyqsIa44cNxA
         O9ZIYBBDslku2IujEXKqWvL2CDhYaAAqUYewvDKaVQDyOkMNORLz/XSXGDbffvdIvp
         KcYYKPLzSPwfN++TwNWocOZSP+rXvuk4VYsd6CSQcQR8Wtf4wD8zrI32IxtgyMlSNd
         JzoCSYsIY34nQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, gjoyce@linux.vnet.ibm.com, nayna@linux.ibm.com,
        jonathan.derrick@linux.dev, brking@linux.vnet.ibm.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        gjoyce@ibm.com
Subject: Re: [PATCH v3 1/2] lib: generic accessor functions for arch keystore
In-Reply-To: <20220801123426.585801-2-gjoyce@linux.vnet.ibm.com>
References: <20220801123426.585801-1-gjoyce@linux.vnet.ibm.com>
 <20220801123426.585801-2-gjoyce@linux.vnet.ibm.com>
Date:   Tue, 02 Aug 2022 12:59:30 +1000
Message-ID: <878ro7bbal.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Greg,

gjoyce@linux.vnet.ibm.com writes:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
>
> Generic kernel subsystems may rely on platform specific persistent
> KeyStore to store objects containing sensitive key material. In such case,
> they need to access architecture specific functions to perform read/write
> operations on these variables.
>
> Define the generic variable read/write prototypes to be implemented by
> architecture specific versions. The default(weak) implementations of
> these prototypes return -EOPNOTSUPP unless overridden by architecture
> versions.
>
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> ---
>  include/linux/arch_vars.h | 23 +++++++++++++++++++++++
>  lib/Makefile              |  2 +-
>  lib/arch_vars.c           | 25 +++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/arch_vars.h
>  create mode 100644 lib/arch_vars.c

I don't think "arch" is the right level of abstraction here.

There isn't a standard way to get these variables across a given arch,
they're not defined in the architecture specification etc.

As demonstrated in your patch 2, on powerpc they are coming from a
platform level pseudo device (provided by the PowerVM hypervisor). But
they would come from elsewhere on a bare metal system.

And you could imagine other architectures could support multiple ways to
retrieve these kind of variables from various different places, possibly
more than one place on a given system.

So I think at least you want a way for any device to register itself as
able to provide these variables. Possibly with a chain of handlers,
something like the sys_off_handlers, or maybe there only ever needs to
be one provider, the way pm_power_off (used to) work.

Looking at your patch to block/sed-opal.c:

  https://lore.kernel.org/all/20220718210156.1535955-4-gjoyce@linux.vnet.ibm.com/

It seems like the calls to these arch routines are closely tied to calls
to the keyring API. Should this functionality be part of the keyring
API?

At a mininmum I think you need to get much wider review on something
like this. So I'd suggest the keyring folks and as Michal pointed out,
this seems a bit like EFI variables so it would be good to Cc the
EFI/EFI variable folks.

cheers
