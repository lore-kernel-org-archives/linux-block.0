Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Mon, 4 Jun 2018 18:41:43 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
Message-ID: <20180604224143.GC30325@kmo-pixel>
References: <20180522235505.20937-1-bart.vanassche@wdc.com>
 <20180523013020.GA12391@kmo-pixel>
 <65261494f966d140a7542fb1533a4dd2f7fd02a1.camel@wdc.com>
 <20180523021607.GB12391@kmo-pixel>
 <f9d3387040d554fdcb07e32737c56f14e61151b1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9d3387040d554fdcb07e32737c56f14e61151b1.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 08:59:39AM +0000, Bart Van Assche wrote:
> On Tue, 2018-05-22 at 22:16 -0400, Kent Overstreet wrote:
> > May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: fail to get serial
> > May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]: sda: using deprecated
> > getuid callout
> > May 22 22:13:46 moria-kvm-kvm-kvm-kvm multipathd[387]:
> > /.../srp-test/bin/getuid_callout exited with 255
> 
> (back from traveling)
> 
> Hello Kent,
> 
> Please comment out the getuid_callout line from /etc/multipath.conf and try again.
> Changing the "/..." part into the path of the srp-test software should also help.
> That line is a left-over from the time when the NVMe initiator drivers supported
> dm-multipath. I will update the srp-test README.md to make this more clear.

Deleted that line and it still doesn't work (I also tried fixing that line so
the path was correct, but got the same output as what I sent you earlier). With
that line deleted, the output is different. test output still says SRP login
failed, syslog says:

Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: --------start up--------
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: read /etc/multipath.conf
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: path checkers start up
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: sda: fail to get serial
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: sdb: fail to get serial
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: nbd0: HDIO_GETGEO failed with 25
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: nbd0: failed to get udev uid: Invalid argument
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: nbd1: HDIO_GETGEO failed with 25
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: nbd1: failed to get udev uid: Invalid argument
Jun 04 18:35:31 moria-kvm-kvm-kvm-kvm-kvm multipathd[453]: nbd10: HDIO_GETGEO failed with 25

etc.
