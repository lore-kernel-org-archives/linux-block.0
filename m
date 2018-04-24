Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33099 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750791AbeDXWE2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 18:04:28 -0400
Date: Tue, 24 Apr 2018 16:04:22 -0600
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add surprise removal block test
Message-ID: <20180424220421.cwu5bat74633r4ga@linux-x5ow.site>
References: <20180424214146.31168-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180424214146.31168-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 24, 2018 at 03:41:46PM -0600, Keith Busch wrote:

[...]

> +DESCRIPTION="break PCI link while doing I/O"
> +TIMED=1

I _think_ we can set QUICK=1 here, Omar?

> +
> +requires() {
> +	_have_fio
> +}

You're using setpci below, so please add it to requires,
i.e. _have_fio && _have_program setpci

> +
> +device_requires() {
> +	_test_dev_is_pci
> +	_test_hotplug_slot
> +}

I think this sould be _test_dev_is_pci && _test_hotplug_slot


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
