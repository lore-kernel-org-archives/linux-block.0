Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29871 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcERXz6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 18 May 2016 19:55:58 -0400
Date: Wed, 18 May 2016 16:54:56 -0700
From: Rafael Antognolli <rafael.antognolli@intel.com>
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add Opal unlock support to NVMe.
Message-ID: <20160518235455.GA4242@intel.com>
References: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
 <20160425082408.GA13629@infradead.org>
 <94D0CD8314A33A4D9D801C0FE68B40295C43485D@G9W0745.americas.hpqcorp.net>
 <20160426213349.GA17078@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426213349.GA17078@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 26, 2016 at 02:33:49PM -0700, Rafael Antognolli wrote:
> On Mon, Apr 25, 2016 at 08:29:22PM -0700, Elliott, Robert (Persistent Memory) wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> > > owner@vger.kernel.org] On Behalf Of Christoph Hellwig
> > > Sent: Monday, April 25, 2016 3:24 AM
> > > To: Rafael Antognolli <rafael.antognolli@intel.com>
> > > Cc: linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > linux-block@vger.kernel.org
> > > Subject: Re: [PATCH 0/2] Add Opal unlock support to NVMe.
> > >
> > > On Fri, Apr 22, 2016 at 04:12:10PM -0700, Rafael Antognolli wrote:
> > > > This patch series implement a small set of the Opal protocol for
> > > > self encrypting devices. It's implemented only what is needed for
> > > > saving a password and unlocking a given "locking range". The
> > > > password is saved on the driver and replayed back to the device
> > > > on resume from suspend to RAM. It is specifically supporting
> > > > the single user mode.
> > 
> > Passwords stored in memory are subject to cold boot attacks.
> > 
> > Could you tie this into the keyring infrastructure, so it would
> > least be no worse than other kernel modules?  This would allow
> > support for TPM-based keys (if present) to resist more attacks.
> > If register-based key storage or other techniques prove viable,
> > they would probably show up there first.
> 
> I'll take a look at it.

Hi Robert, I've been looking at possibilities to integrate this into the
keyring infra as you suggested, particularly with the trusted
(TPM-based) and/or encrypted key types. However, these key types do not
support any way of loading a key from userspace; the API for creating
trusted or encrypted keys generate them inside the kernel and it's never
available to userspace. And at the same time, the current utility to set
a password on Opal devices (sedutil [1]) is a userspace program.

I could not find an easy way to connect both things unless, for
instance, I generated a trusted key that the Opal kernel code can
access, and used that key to encrypt the password to the Opal device.
That would work but would mean the user has to request a
trusted/encrypted key to be created, and then point to that when
requesting to save the password. IMHO the API of this module would start
to be a bit tricky.

Another solution would be to add support to at least encrypted or
trusted keys to be loaded from userspace (as unencrypted keys, not
encrypted blobs), even if they never get available again to userspace.
This should be easy to do, I'm just not sure if it would make sense to
have that on the trusted/encrypted keys.

And yet another solution would be to implement a lot more of the Opal
protocol in this module, and make it support setting up the locking
ranges and passwords (trusted/encrypted keys that the userspace never
saw unencrypted). But at least for now, my intention was to implement
just the least needed to unlock devices, not really implement the whole
OPAL spec.

Anyway, do you see other options, or would you mind giving your opinion
about this?

[1]: https://github.com/Drive-Trust-Alliance/sedutil

Thank you,
Rafael

