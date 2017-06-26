Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33771 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdFZVbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 17:31:41 -0400
Received: by mail-pg0-f42.google.com with SMTP id f127so5858939pgc.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 14:31:41 -0700 (PDT)
Date: Mon, 26 Jun 2017 14:31:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] rc: add helpers to handle PCI test devices
Message-ID: <20170626213139.GH6710@vader.dhcp.thefacebook.com>
References: <20170623142951.17189-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170623142951.17189-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 23, 2017 at 04:29:50PM +0200, Johannes Thumshirn wrote:
> Add two helpers to check whether a device is attached via PCI and to get the
> PCI device from a TEST_DEV
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  common/rc | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index b01f936b878b..497cf81ec475 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -120,3 +120,18 @@ _test_dev_queue_set() {
>  	fi
>  	echo "$2" >"${TEST_DEV_SYSFS}/queue/$1"
>  }
> +
> +_test_dev_is_pci() {
> +	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q pci; then
> +		SKIP_REASON="$TEST_DEV is not a PCI device"
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_get_pci_dev_from_blkdev() {
> +	pdev="$(readlink -f "$TEST_DEV_SYSFS/device" | \
> +		grep -Eo '[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]')"
> +
> +	echo "$pdev"
> +}

No need to do pdev=$(blah) and then echo $pdev, you can just do

_get_pci_dev_from_blkdev() {
	readlink -f "$TEST_DEV_SYSFS/device" | grep -Eo '[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]'
}

I'll fix that up when I commit it. Looks good otherwise.
