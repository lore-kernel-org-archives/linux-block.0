Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF635C19F29
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiHANk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHANk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2022 09:40:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61872BC39
        for <linux-block@vger.kernel.org>; Mon,  1 Aug 2022 06:40:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B6ED38C76;
        Mon,  1 Aug 2022 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659361219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/15e5KZCnNKb0azDiCVDEz20SQoPdOtelD54ZT3HrI=;
        b=vZsF5JXt0yunqdghLnL8szmYGnecduZ5VaUF50ssv6NhWp/sQ/Eoqo26SQgkJghY6gmXSI
        2yUH4JSJxYyzwbRG69QWbS8VhnlIvOs2vK1vMqgrN9cmcPTxGc4YaB6ORGS3ggcUhw5Y6h
        IUBr3gPcpkJNVdZqb7IRrfvb0+LZeGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659361219;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/15e5KZCnNKb0azDiCVDEz20SQoPdOtelD54ZT3HrI=;
        b=HMNxuNm0lGxkGLz2Wj+1OUU44LycDhShMQHSDOcCtFhc0cGYVlZ4pNxYPg7V5AqsB2Llw9
        jbnAZv4hyp16SwBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4520B2C141;
        Mon,  1 Aug 2022 13:40:19 +0000 (UTC)
Date:   Mon, 1 Aug 2022 15:40:18 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     gjoyce@linux.vnet.ibm.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, nayna@linux.ibm.com,
        jonathan.derrick@linux.dev, brking@linux.vnet.ibm.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        gjoyce@ibm.com
Subject: Re: [PATCH v3 1/2] lib: generic accessor functions for arch keystore
Message-ID: <20220801134018.GY17705@kitsune.suse.cz>
References: <20220801123426.585801-1-gjoyce@linux.vnet.ibm.com>
 <20220801123426.585801-2-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801123426.585801-2-gjoyce@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Mon, Aug 01, 2022 at 07:34:25AM -0500, gjoyce@linux.vnet.ibm.com wrote:
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
> 
> diff --git a/include/linux/arch_vars.h b/include/linux/arch_vars.h
> new file mode 100644
> index 000000000000..9c280ff9432e
> --- /dev/null
> +++ b/include/linux/arch_vars.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Platform variable opearations.
> + *
> + * Copyright (C) 2022 IBM Corporation
> + *
> + * These are the accessor functions (read/write) for architecture specific
> + * variables. Specific architectures can provide overrides.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +
> +enum arch_variable_type {
> +	ARCH_VAR_OPAL_KEY      = 0,     /* SED Opal Authentication Key */
> +	ARCH_VAR_OTHER         = 1,     /* Other type of variable */
> +	ARCH_VAR_MAX           = 1,     /* Maximum type value */
> +};
> +
> +int arch_read_variable(enum arch_variable_type type, char *varname,
> +		       void *varbuf, u_int *varlen);
> +int arch_write_variable(enum arch_variable_type type, char *varname,
> +			void *varbuf, u_int varlen);
> diff --git a/lib/Makefile b/lib/Makefile
> index f99bf61f8bbc..b90c4cb0dbbb 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -48,7 +48,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
>  	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>  	 percpu-refcount.o rhashtable.o \
>  	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
> -	 generic-radix-tree.o
> +	 generic-radix-tree.o arch_vars.o
>  obj-$(CONFIG_STRING_SELFTEST) += test_string.o
>  obj-y += string_helpers.o
>  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> diff --git a/lib/arch_vars.c b/lib/arch_vars.c
> new file mode 100644
> index 000000000000..e6f16d7d09c1
> --- /dev/null
> +++ b/lib/arch_vars.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Platform variable operations.
> + *
> + * Copyright (C) 2022 IBM Corporation
> + *
> + * These are the accessor functions (read/write) for architecture specific
> + * variables. Specific architectures can provide overrides.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/arch_vars.h>
> +
> +int __weak arch_read_variable(enum arch_variable_type type, char *varname,
> +			      void *varbuf, u_int *varlen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int __weak arch_write_variable(enum arch_variable_type type, char *varname,
> +			       void *varbuf, u_int varlen)
> +{
> +	return -EOPNOTSUPP;
> +}
> -- 

Doesn't EFI already have some variables?

And even powernv?

Shouldn't this generalize the already existing variables?

Or move to powerpc and at least generalize the powerpc ones?

Thanks

Michal
