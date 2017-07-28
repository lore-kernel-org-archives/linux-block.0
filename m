Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23676 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdG1QRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2017 12:17:55 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [resend PATCH v2 11/33] dm: add dax_device and dax_operations
 support
Date: Fri, 28 Jul 2017 16:17:07 +0000
Message-ID: <1501258623.2413.3.camel@wdc.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
         <149245618859.10206.13182319600260215993.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149245618859.10206.13182319600260215993.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-04-17 at 12:09 -0700, Dan Williams wrote:
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index b7767da50c26..1de8372d9459 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -200,6 +200,7 @@ config BLK_DEV_DM_BUILTIN
>  config BLK_DEV_DM
>  	tristate "Device mapper support"
>  	select BLK_DEV_DM_BUILTIN
> +	select DAX
>  	---help---
>  	  Device-mapper is a low level volume manager.  It works by allowing
>  	  people to specify mappings for ranges of logical sectors.  Various

(replying to an e-mail of three months ago)

Hello Dan,

While building a v4.12 kernel I noticed that enabling device mapper support
now unconditionally enables DAX. I think there are plenty of systems that u=
se
dm but do not need DAX. Have you considered to rework this such that instea=
d
of dm selecting DAX that DAX support is only enabled in dm if CONFIG_DAX is
enabled?

Thanks,

Bart.
