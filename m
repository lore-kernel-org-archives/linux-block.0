Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Sat, 25 Feb 2017 22:47:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 1/2] lightnvm: add generic ocssd detection
Message-ID: <20170226064701.GA7557@infradead.org>
References: <20170224171649.27409-1-matias@cnexlabs.com>
 <20170225182117.GA26447@infradead.org>
 <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
MIME-Version: 1.0
In-Reply-To: <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

[adding linux-nvme to Cc as the patch changes the nvme driver, despite
the subject line]

On Sat, Feb 25, 2017 at 08:16:04PM +0100, Matias Bj=F8rling wrote:
> On 02/25/2017 07:21 PM, Christoph Hellwig wrote:
> > On Fri, Feb 24, 2017 at 06:16:48PM +0100, Matias Bj=F8rling wrote:
> > > More implementations of OCSSDs are becoming available. Adding each us=
ing
> > > pci ids are becoming a hassle. Instead, use a 16 byte string in the
> > > vendor-specific area of the identification command to identify an
> > > Open-Channel SSD.
> > > =

> > > The large string should make the collision probability with other
> > > vendor-specific strings to be near nil.
> > =

> > No way in hell.  vs is vendor specific and we absolutely can't overload
> > it with any sort of meaning.  Get OCSSD support properly standardized a=
nd
> > add a class code for it.  Until then it's individual PCI IDs.
> > =

> =

> You are right, that is the right way to go, and we are working on it. In =
the
> meantime, there are a couple of reasons I want to do a pragmatic solution:

Reasonable reaosons, but that's just not how standard interfaces work.
Either you standardize the behaviour and have a standardized trigger
for it, or it is vendor specific and needs to be keyed off a specific
vendor/device identification.

> 1. Enabling open-channel SSDs on NVMeoF. Customers are asking to use OCSS=
Ds
> with NVMoeF. I do not think detection of PCI ids works with that.

To use NVMoeF your protocol needs to be NVMe.  Get it standardized.

> 2. Some vendors are circumventing the OCSSD detection by utilizing the CN=
EX
> Labs PCI ids. That is not very helpful and shows that there is a need for=
 a
> generic approach. When they become public and will use their PCI id (if t=
hey
> will do that...), it is cumbersome to backport their PCI ids back to
> previous kernel versions to detect support.

Sue them.

> 3. Things are not a technical issue for why this is not adopted today. It
> will be soon enough one way or another, but until then, a pragmatic appro=
ach
> would go a long way.

It's not a pragmatic approach, it's broken so please don't use these
whitewashing words.

> If identify VS is too specific, is there another combination that solves =
the
> above in a generic and practical way that would satisfy you and the above?

Standardize your interface and get a I/O command set bit for it
standardized in the NVMe spec.  You've had a year and a half since
the lightnvm code hit the kernel tree to do this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
