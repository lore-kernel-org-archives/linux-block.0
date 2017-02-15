Return-Path: <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCHv4 4/4] MAINTAINERS: Remove powerpc's opal match
To: Jon Derrick <jonathan.derrick@intel.com>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
 <1487195159-12599-5-git-send-email-jonathan.derrick@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Scott Bauer <scott.bauer@intel.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 16 Feb 2017 10:55:04 +1100
MIME-Version: 1.0
In-Reply-To: <1487195159-12599-5-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4e977771-2391-5cef-5571-5710693e0c1b@au1.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On 16/02/17 08:45, Jon Derrick wrote:
> PPC's 'opal' match pattern also matches block/sed-opal.c, where it looks
> like the 'arch/powerpc' file pattern should be enough to match powerpc
> opal code by itself. Remove the opal regex pattern from powerpc.
>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

It looks like this change will exclude the following PPC OPAL related files:

drivers/tty/hvc/hvc_opal.c - HYPERVISOR VIRTUAL CONSOLE DRIVER (which 
lists linuxppc-dev as the mailing list, doesn't name a maintainer though)

drivers/i2c/busses/i2c-opal.c - I2C SUBSYSTEM

drivers/rtc/rtc-opal.c - REAL TIME CLOCK (RTC) SUBSYSTEM

Documentation/devicetree/bindings/i2c/i2c-opal.txt - I2C SUBSYSTEM, OPEN 
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS

Documentation/devicetree/bindings/powerpc/opal - OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS

Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt - OPEN 
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS

Documentation/devicetree/bindings/rtc/rtc-opal.txt - OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS, REAL TIME CLOCK (RTC) SUBSYSTEM

Documentation/ABI/stable/sysfs-firmware-opal-elog - no other subsystem

Documentation/ABI/stable/sysfs-firmware-opal-dump - no other subsystem


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
