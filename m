Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] block: remove the paride drivers
Date: Thu, 15 Mar 2018 23:37:18 +0100
Cc: axboe@kernel.dk,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180315075256.25652-1-hch@lst.de> <20180315080455.GA12388@lst.de> <201803152304.40423.linux@rainbow-software.org>
In-Reply-To: <201803152304.40423.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201803152337.18938.linux@rainbow-software.org>
List-ID: <linux-block@vger.kernel.org>

On Thursday 15 March 2018 23:04:40 Ondrej Zary wrote:
> On Thursday 15 March 2018 09:04:55 Christoph Hellwig wrote:
> > On Thu, Mar 15, 2018 at 09:04:24AM +0100, Ondrej Zary wrote:
> > > On Thursday 15 March 2018, Christoph Hellwig wrote:
> > > > The paride drivers are some of the cruftiest, grottiest block drivers
> > > > (besides drivers/ide and floppy.c) and have seen one single targeted
> > > > commit since the dawn of git in 2007.  Drop them to make block layer
> > > > improvements easier.
> > >
> > > This will make my parallel port ZIP and LS-120 drives useless :(
> >
> > So you are still using them and the code actually works properly?
>
> I don't use them daily, only occasionally. Last time they worked.
> Checked now and it seems to work:

Forgot that my ZIP drive uses the PPA driver, which seems to work too:

# modprobe ppa
[  816.690602] ppa: Version 2.07 (for Linux 2.4.x)
[  816.762167] ppa: Found device at ID 6, Attempting to use EPP 32 bit
[  816.763037] ppa: Communication established with ID 6 using EPP 32 bit
[  816.807658] scsi host4: Iomega VPI0 (ppa) interface
[  816.926616] scsi 4:0:6:0: Direct-Access     IOMEGA   ZIP 100          D.08 PQ: 0 ANSI: 2
[  816.987969] sd 4:0:6:0: Attached scsi generic sg1 type 0
[  817.054564] sd 4:0:6:0: Power-on or device reset occurred
[  817.158623] sd 4:0:6:0: [sdb] Attached SCSI removable disk
[  817.742723] sd 4:0:6:0: [sdb] tag#0 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[  817.745168] sd 4:0:6:0: [sdb] tag#0 CDB: ATA command pass through(16) 85 06 20 00 05 00 fe 00 00 00 00 00 00 40 ef 00
[  839.268575] sd 4:0:6:0: [sdb] Spinning up disk...
[  840.320383] ..ready
[  841.596371] sd 4:0:6:0: [sdb] 196608 512-byte logical blocks: (101 MB/96.0 MiB)
[  842.088415]  sdb: sdb4


-- 
Ondrej Zary
