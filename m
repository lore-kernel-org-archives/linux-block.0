Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878711E889;
	Fri, 28 Jun 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583242; cv=none; b=EOGFEVf3RGpXyouZNcZYZhYxjJCPYs2bpW+U1Bq1GQfGDBx7R3/XkNQpag46d+S6gBThpOGWwr+0NjtJyVWn/KW3MasU7DZyiQc5UAG+a6atZ275kyn6rYzpNT6crYE6DpYIB4UA9dvygmCZf3k6Vp4RAUQmCorUFlKW8nMea7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583242; c=relaxed/simple;
	bh=gJSDCDl2ZLDs8dW8dJhpapFBbEIcKabxr5MXo+v0kGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa4SzKBfxxCyjPxSiji2nmVWpVv0opmYtUIraXk8ddaAdzV4aY4QVqZv95vAB7GC4pMLfmWCNbM9KMkqgyhlu2pc8bF6aRw/40I8m2nt613Y9NxZsV5k79C8hLhOObgYGHep41ip+t39qf+BHMS+L8MmU+ur/n23DSlr33KeyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sNC94-000000003K2-3H22;
	Fri, 28 Jun 2024 14:00:10 +0000
Date: Fri, 28 Jun 2024 15:00:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/4] block: add support for notifications
Message-ID: <Zn7B5adt82suLrRq@makrotopia.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <4ebef78f07ff1ea4d553c481ffa9e130d65db772.1719520771.git.daniel@makrotopia.org>
 <Zn4_-alKtxuZ6zNt@infradead.org>
 <Zn6rU-mCYQcyCkGT@makrotopia.org>
 <Zn6xjP8eH470wWXC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn6xjP8eH470wWXC@infradead.org>

Hi Christoph,

On Fri, Jun 28, 2024 at 05:50:20AM -0700, Christoph Hellwig wrote:
> On Fri, Jun 28, 2024 at 01:23:47PM +0100, Daniel Golle wrote:
> > So that's what I did consequently. Using the notification interface
> > the NVMEM driver can live in drivers/nvmem/ and doesn't need to be
> > using block internals.
> > 
> > > And not actually having a user for it is a complete no-go.
> > > 
> > 
> > The user will be the nvmem provider, you can see the code in earlier
> > versions of the patchset where I had included it:
> > 
> > https://patchwork.kernel.org/project/linux-block/patch/96554d6b4d9fa72f936c2c476eb0b023cdd60a64.1717031992.git.daniel@makrotopia.org/
> > 
> > Being another subsystem I thought it'd be better to deal with the
> > block related things first, and once that has been sorted out I will
> > move on to add the NVMEM driver and make the necessary changes for
> > using it on eMMC.
> 
> It is rather hard to review an interface without the users.

I understand that, please take a look at previous iterations of this very
series or use the link to the patch which I have sent before (see above).

> 
> I still dislike the idea of notifications from bdev discovery /
> partition scanning into the users of them.  We have one such users
> in the MD legacy autodetect code, but that has largely been considered
> at bad idea and distros tend to use mdadm based assembly from initramfs
> instead.  Which IMHO feels like the right thing for nvmem as well,
> just have an nvmem provider that opens a file for a user provided
> path and use kernel_read on it.  This can covered block devices,
> character devices and even regular files.  It will require initramfs
> support, but that is pretty much used everywhere for storage discovery
> and setup anyway.

The problem there is that then we cannot use Device Tree to device the
NVMEM layouts, and reference NVMEM bits to the dirvers which need them.
Hence also the definition of the NVMEM layout would have to happen in
userspace, inside an initramfs. I know that having an initramfs is
common for classic desktop or server distributions, but the same is not
true on more simple embedded devices such as router/firewall or WiFi
access point appliances running OpenWrt.

Carrying all that board-specific knowledge in the form of scripts
identifying the board is not exactly nice, nor is creating an individual
initramfs for each of the 1000+ boards supported by OpenWrt, for
example. Extracting the layout information from /sys/firmware/devicetree
in userspace just to then somehow use libblkid to identify the block
device and throw that information back at the kernel which requested it
e.g. using a firmware hotplug call is an option, but imho an unnecessary
complication. And obviously it would still prevent things like nfsroot
(which requires the MAC address and potentially a WiFi calibration data
to be setup) from working out of the box.

Doing the detour via userspace only for devices with an eMMC would be
different from how it is done for any other type of backing storage such
as simple I2C EEPROMs, (SPI-)flashes or UBI volumes.
Having a unified approach for all of them would make things much more
convenient, as typically the actual layouts are even the same and can be
reused accross devices of the same vendor. GL-iNet or ASUS router
devices are a good example for that: The more high-end ones come with an
eMMC and use the same NVMEM layout inside a GPT partition than mid-field
devices on SPI-NAND or UBI, and older and/or lower-end devices on an
SPI-NOR flash MTD partition.

To better understand the situation, maybe look at a few examples for
which we are currently already using this patchset downstream at
OpenWrt:

Inside a GPT partition on an eMMC:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7981b-unielec-u7981-01-emmc.dts;h=abd4d4e59d74cc0d24e8c9e10e16c0859844e003;hb=HEAD#l39

On raw SPI-NAND (already possible with vanilla Linux):
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7981b-unielec-u7981-01-nand.dts;h=230a612a34f7d370eb09e92284950d9949bf10cd;hb=HEAD#l45

Inside a UBI volume (also already possible with vanilla Linux):
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7986a-asus-tuf-ax4200.dts;h=e40602fa215e1a677b534c85b767e824af041518;hb=HEAD#l255

Inside the boot hwpartition of the eMMC:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7981b-glinet-gl-mt2500.dts;h=15818a90fca02955879d1bcca55ba2153e390621;hb=HEAD#l156

Inside a GPT partition on an eMMC:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7986a-glinet-gl-mt6000.dts;h=fd0e1a69157ed0f27c32376aabab0fcc85ce23b9;hb=HEAD#l317

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7988a-smartrg-mt-stuart.dtsi;h=2b468f9bb311141d083e51ca5edaa7dce253c91c;hb=HEAD#l504

Those are just the examples I have been working on myself, so it was
easy to come up with them. There are also ASUS devices with Qualcomm
SoC using the same layout as the MediaTek-based devices inside a UBI
volume.

Once a unified way to describe the loaction of the NVMEM bits is also
present in upstream Linux, all those downstream device trees could be
submitted for inclusion in Linux, and one could install a
general-purpose OS like Debian **which wouldn't need to know anything
about the details of where to read MAC addresses or calibration data
from**, all hardware-specific knowledge would reside in DT.

The failure of defining this in a nice way results in very ugly
situations such as distributions carrying the (board-specific!)
calibration data for very few but very common single-board computers
like the RaspberryPi in their rootfs or even in initramfs. Each
distribution with a different level of hacks to give them individual MAC
addresses and to load the correct file... And while this doesn't look so
bad for systems which anyway come only with removable microSD storage,
it **does* get ugly when it comes to systems which do store that
information on their eMMC (typically "appliances" rather than SBCs meant
for tinkerers).

Please take all that into consiration and also note that obviously, on
systems not making use of any of that, you may simple not enable
CONFIG_BLOCK_NOTIFIERS -- other than in previous iterations of the
patchset this is all completely optional now.


Cheers


Daniel
