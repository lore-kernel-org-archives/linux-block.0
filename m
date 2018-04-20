Return-Path: <jgross@suse.com>
Subject: Re: [PATCH 1/3] xen: add generic fault injection facility
To: Stanislav Kinsburskii <staskins@amazon.com>
Cc: jakub.kicinski@netronome.com, hpa@zytor.com, mcroce@redhat.com,
 tglx@linutronix.de, ggarcia@abra.uab.cat, daniel@iogearbox.net,
 x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org,
 axboe@kernel.dk, konrad.wilk@oracle.com, amir.jer.levy@intel.com,
 paul.durrant@citrix.com, stefanha@redhat.com, dsa@cumulusnetworks.com,
 boris.ostrovsky@oracle.com, linux-block@vger.kernel.org,
 wei.liu2@citrix.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dwmw@amazon.co.uk, roger.pau@citrix.com
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104726.17823.40147.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <03a333dc-e505-e254-f39d-e68b1453a6f3@suse.com>
Date: Fri, 20 Apr 2018 12:59:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180420104726.17823.40147.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 20/04/18 12:47, Stanislav Kinsburskii wrote:
> The overall idea of this patch is to add a generic fault injection facility
> to Xen, which later can be used in various places by different Xen parts.
> 
> Core implementation ideas:
> 
> - The facility build is controlled by boolean config
>   CONFIG_XEN_FAULT_INJECTION option ("N" by default).
> 
> - All fault injection logic is located in an optionally compiled separated
>   file.
> 
> - Fault injection attribute and control directory creation and destruction
>   are wrapped with helpers, producing and accepting a pointer to an opaque
>   object thus making all the rest of code independent on fault injection
>   engine.
> 
> When enabled Xen root fault injection directory appears:
> 
> - /sys/kernel/debug/xen/fault_inject/
> 
> The falicity provides the following helpers (exported to be accessible in
> modules):
> 
> - xen_fi_add(name) - adds fault injection control directory "name" to Xen
>   root fault injection directory
> 
> - xen_fi_dir_create(name) - allows to create a subdirectory "name" in Xen
>   root fault injection directory.
> 
> - xen_fi_dir_add(dir, name) - adds fault injection control directory "name"
>   to directory "dir"
> 
> - xen_should_fail(fi) - check whether fi hav to fail.
> 
> Signed-off-by: Stanislav Kinsburskii <staskins@amazon.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> CC: xen-devel@lists.xenproject.org
> CC: linux-kernel@vger.kernel.org
> CC: Stanislav Kinsburskii <staskins@amazon.com>
> CC: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/xen/Kconfig        |    7 +++
>  arch/x86/xen/Makefile       |    1 
>  arch/x86/xen/fault_inject.c |  109 +++++++++++++++++++++++++++++++++++++++++++
>  include/xen/fault_inject.h  |   45 ++++++++++++++++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 arch/x86/xen/fault_inject.c
>  create mode 100644 include/xen/fault_inject.h
> 
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index c1f98f3..483fc16 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -77,3 +77,10 @@ config XEN_PVH
>  	bool "Support for running as a PVH guest"
>  	depends on XEN && XEN_PVHVM && ACPI
>  	def_bool n
> +
> +config XEN_FAULT_INJECTION
> +	bool "Enable Xen fault injection"
> +	depends on FAULT_INJECTION_DEBUG_FS
> +	default n
> +	help
> +	  Enable Xen fault injection facility

Why for x86 only? I'd rather add this under drivers/xen

> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index d83cb54..3158fe1 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_XEN_DOM0)		+= vga.o
>  obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
>  obj-$(CONFIG_XEN_EFI)		+= efi.o
>  obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
> +obj-$(CONFIG_XEN_FAULT_INJECTION)	+= fault_inject.o
> diff --git a/arch/x86/xen/fault_inject.c b/arch/x86/xen/fault_inject.c
> new file mode 100644
> index 0000000..ecf0f7c
> --- /dev/null
> +++ b/arch/x86/xen/fault_inject.c
> @@ -0,0 +1,109 @@
> +/*
> + * Fauit injection interface for Xen virtual block devices
> + *
> + * Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation; or, when distributed
> + * separately from the Linux kernel or incorporated into other
> + * software packages, subject to the following license:

Please use the appropriate SPDX header instead of the full GPL2
boilerplate.


Juergen
