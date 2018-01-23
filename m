Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29743
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751125AbeAWJNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jan 2018 04:13:13 -0500
Date: Tue, 23 Jan 2018 10:13:09 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Aishwarya Pant <aishpant@gmail.com>
cc: Thomas Maier <balagi@justmail.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] Documentation/ABI: clean up sysfs-class-pktcdvd
In-Reply-To: <20180123091032.GA18947@mordor.localdomain>
Message-ID: <alpine.DEB.2.20.1801231011210.3589@hadrien>
References: <20180123091032.GA18947@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On Tue, 23 Jan 2018, Aishwarya Pant wrote:

> Clean up the sysfs documentation such that it is in the same format as
> described in Documentation/ABI/README. Mainly, the patch moves the
> attribute names to the 'What:' field. This might be useful for scripting
> and tracking changes in the ABI.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-pktcdvd | 122 +++++++++++++++-----------
>  1 file changed, 71 insertions(+), 51 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-pktcdvd b/Documentation/ABI/testing/sysfs-class-pktcdvd
> index b1c3f0263359..e85ec99c6e31 100644
> --- a/Documentation/ABI/testing/sysfs-class-pktcdvd
> +++ b/Documentation/ABI/testing/sysfs-class-pktcdvd
> @@ -1,60 +1,80 @@
> -What:           /sys/class/pktcdvd/
> +sysfs interface
> +---------------
> +The pktcdvd module (packet writing driver) creates the following files in the
> +sysfs: (<devid> is in format major:minor)
> +
> +What:           /sys/class/pktcdvd/add
> +What:           /sys/class/pktcdvd/remove
> +What:           /sys/class/pktcdvd/device_map
>  Date:           Oct. 2006
>  KernelVersion:  2.6.20
>  Contact:        Thomas Maier <balagi@justmail.de>
>  Description:
>
> -sysfs interface
> ----------------
> +		add:        (WO) Write a block device id (major:minor) to create
> +			    a new pktcdvd device and map it to the block device.
> +
> +		remove:	    (WO) Write the pktcdvd device id (major:minor) to it to
> +			    remove the pktcdvd device.
> +
> +		device_map: (RO) Shows the device mapping in format:
> +			    pktcdvd[0-7] <pktdevid> <blkdevid>
> +
> +
> +What:           /sys/class/pktcdvd/pktcdvd[0-7]/dev
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/uevent

It looks like there is a small alignment problem here.  Maybe you use
spaces in one case and tabs in the other.

julia

> +Date:           Oct. 2006
> +KernelVersion:  2.6.20
> +Contact:        Thomas Maier <balagi@justmail.de>
> +Description:
> +		dev:    (RO) Device id
> +
> +		uevent: (WO) To send an uevent
> +
> +
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/packets_started
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/packets_finished
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/kb_written
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/kb_read
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/kb_read_gather
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/reset
> +Date:           Oct. 2006
> +KernelVersion:  2.6.20
> +Contact:        Thomas Maier <balagi@justmail.de>
> +Description:
> +		packets_started:  (RO) Number of started packets.
> +
> +		packets_finished: (RO) Number of finished packets.
> +
> +		kb_written:	  (RO) kBytes written.
> +
> +		kb_read:	  (RO) kBytes read.
> +
> +		kb_read_gather:   (RO) kBytes read to fill write packets.
> +
> +		reset:            (WO) Write any value to it to reset pktcdvd
> +				  device statistic values, like bytes
> +				  read/written.
> +
> +
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/size
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/congestion_off
> +What:		/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/congestion_on
> +Date:           Oct. 2006
> +KernelVersion:  2.6.20
> +Contact:        Thomas Maier <balagi@justmail.de>
> +Description:
> +		size:           (RO) Contains the size of the bio write queue.
> +
> +		congestion_off: (RW) If bio write queue size is below this mark,
> +				accept new bio requests from the block layer.
>
> -The pktcdvd module (packet writing driver) creates
> -these files in the sysfs:
> -(<devid> is in format  major:minor )
> -
> -/sys/class/pktcdvd/
> -    add            (0200)  Write a block device id (major:minor)
> -                           to create a new pktcdvd device and map
> -                           it to the block device.
> -
> -    remove         (0200)  Write the pktcdvd device id (major:minor)
> -                           to it to remove the pktcdvd device.
> -
> -    device_map     (0444)  Shows the device mapping in format:
> -                             pktcdvd[0-7] <pktdevid> <blkdevid>
> -
> -/sys/class/pktcdvd/pktcdvd[0-7]/
> -    dev                   (0444) Device id
> -    uevent                (0200) To send an uevent.
> -
> -/sys/class/pktcdvd/pktcdvd[0-7]/stat/
> -    packets_started       (0444) Number of started packets.
> -    packets_finished      (0444) Number of finished packets.
> -
> -    kb_written            (0444) kBytes written.
> -    kb_read               (0444) kBytes read.
> -    kb_read_gather        (0444) kBytes read to fill write packets.
> -
> -    reset                 (0200) Write any value to it to reset
> -                                 pktcdvd device statistic values, like
> -                                 bytes read/written.
> -
> -/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/
> -    size                  (0444) Contains the size of the bio write
> -                                 queue.
> -
> -    congestion_off        (0644) If bio write queue size is below
> -                                 this mark, accept new bio requests
> -                                 from the block layer.
> -
> -    congestion_on         (0644) If bio write queue size is higher
> -                                 as this mark, do no longer accept
> -                                 bio write requests from the block
> -                                 layer and wait till the pktcdvd
> -                                 device has processed enough bio's
> -                                 so that bio write queue size is
> -                                 below congestion off mark.
> -                                 A value of <= 0 disables congestion
> -                                 control.
> +		congestion_on:  (RW) If bio write queue size is higher as this
> +				mark, do no longer accept bio write requests
> +				from the block layer and wait till the pktcdvd
> +				device has processed enough bio's so that bio
> +				write queue size is below congestion off mark.
> +				A value of <= 0 disables congestion control.
>
>
>  Example:
> --
> 2.16.1
>
>
